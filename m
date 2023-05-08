Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737E6FA400
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjEHJyK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjEHJyF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B125714
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C2C62209
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA59C433EF;
        Mon,  8 May 2023 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539638;
        bh=Q2Sai8ec9u1/+g6OIGrAdwFdvHVwtH13NwfguS3+Bfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aauAisIwK/a0l/nURPdYUQMlxqYq/BP5ByCzrrnRZ54WcjZlOQjRUAtDTc1JCTvsj
         pdOHW1qQ4IT8X92UXq8yHYax2OK27BStJ5BMnQ1n5fuInVc2gmBSZQ2QZGLe9lJlJz
         9w/bcswhCp46xag0qBuYpx7Uu9TJhl7B3Qttb980=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.1 089/611] ksmbd: fix NULL pointer dereference in smb2_get_info_filesystem()
Date:   Mon,  8 May 2023 11:38:51 +0200
Message-Id: <20230508094425.049125170@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

commit 3ac00a2ab69b34189942afa9e862d5170cdcb018 upstream.

If share is , share->path is NULL and it cause NULL pointer
dereference issue.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20479
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4913,6 +4913,9 @@ static int smb2_get_info_filesystem(stru
 	int rc = 0, len;
 	int fs_infoclass_size = 0;
 
+	if (!share->path)
+		return -EIO;
+
 	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
 	if (rc) {
 		pr_err("cannot create vfs path\n");


