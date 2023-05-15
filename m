Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF55703797
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbjEORXI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjEORWr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014B10C7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A458162C53
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94930C433EF;
        Mon, 15 May 2023 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171255;
        bh=e4QBGwX+Izxjh1QZWTpkp9px+pDzxg0KWgSxmDigml8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teoO80LFNrdqb7SHG7xy/Pc98noH2+uJM4J3Hs4uHU84SxK8R/nvTWe1BTDNKsalf
         GzDJWad4qJlB04NME+GwY9StvOdYnKvnwMNqpNzcKE0M0D8a0VwGhpM5DHbl2J0fCu
         f+jKsP81WNQnvLms+lYwazI0Bcoxej0LfjD7Lx/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.2 151/242] SMB3: force unmount was failing to close deferred close files
Date:   Mon, 15 May 2023 18:27:57 +0200
Message-Id: <20230515161726.420542840@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -743,6 +743,7 @@ static void cifs_umount_begin(struct sup
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
+	cifs_close_all_deferred_files(tcon);
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
 	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {


