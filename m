Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004DE703522
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbjEOQzz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbjEOQzy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7585BAA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD52629FA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429CAC433A0;
        Mon, 15 May 2023 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169747;
        bh=CT4FyBRv6zvpjFV7hoAeHAaUF0sHSKetItBxJCBNlCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXOwTNnIsg0+1cFyIuR6JcvPq2H1Qt1pfs6FbjX3getPv4CfLyT1S/q+bqWvlTtZl
         pO2wzTOjlU1ibCHfk4z6PhgHB/D9McHJNANCp1Z8YOr+wYrGxU2D2KJChpwrUB/k4w
         wUhVoyLv+Yk1dxXfdS0iz33X/dhdCdGKrfU6slcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 150/246] SMB3: force unmount was failing to close deferred close files
Date:   Mon, 15 May 2023 18:26:02 +0200
Message-Id: <20230515161727.052596831@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 2cb6f968775a9fd60c90a6042b9550bcec3ea087 upstream.

In investigating a failure with xfstest generic/392 it
was noticed that mounts were reusing a superblock that should
already have been freed. This turned out to be related to
deferred close files keeping a reference count until the
closetimeo expired.

Currently the only way an fs knows that mount is beginning is
when force unmount is called, but when this, ie umount_begin(),
is called all deferred close files on the share (tree
connection) should be closed immediately (unless shared by
another mount) to avoid using excess resources on the server
and to avoid reusing a superblock which should already be freed.

In umount_begin, close all deferred close handles for that
share if this is the last mount using that share on this
client (ie send the SMB3 close request over the wire for those
that have been already closed by the app but that we have
kept a handle lease open for and have not sent closes to the
server for yet).

Reported-by: David Howells <dhowells@redhat.com>
Acked-by: Bharath SM <bharathsm@microsoft.com>
Cc: <stable@vger.kernel.org>
Fixes: 78c09634f7dc ("Cifs: Fix kernel oops caused by deferred close for files.")
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifsfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -744,6 +744,7 @@ static void cifs_umount_begin(struct sup
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
+	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {


