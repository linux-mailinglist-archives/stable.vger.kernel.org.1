Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F3738F51
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjFUS4n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUS4l (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F60197
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4367061698
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0B6C433C0;
        Wed, 21 Jun 2023 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687373799;
        bh=gd0TBF3lVEV2e4W9kV0pUoJeEKk5ksDEVXjONwCa+XA=;
        h=Subject:To:Cc:From:Date:From;
        b=arG55i3kwm/A6OB14HN7r2haOQtxTKdasRLLxhXxv22kqULMEiB/ZBY2UMjvwct/2
         fMMPM5cIMYFz8iWjy5BLCkz2WRXrK66IdT3aDLDmenKbHWYmcc1fMfFcs85g92XQCC
         EcK8+cJLusovhwWMgNGXefaOWr9U8zm8N+GwrWRA=
Subject: FAILED: patch "[PATCH] ksmbd: fix out-of-bound read in smb2_write" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 21 Jun 2023 20:56:37 +0200
Message-ID: <2023062136-xbox-tidal-465b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5fe7f7b78290638806211046a99f031ff26164e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062136-xbox-tidal-465b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5fe7f7b78290638806211046a99f031ff26164e1 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 15 Jun 2023 22:04:40 +0900
Subject: [PATCH] ksmbd: fix out-of-bound read in smb2_write

ksmbd_smb2_check_message doesn't validate hdr->NextCommand. If
->NextCommand is bigger than Offset + Length of smb2 write, It will
allow oversized smb2 write length. It will cause OOB read in smb2_write.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21164
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 57749f41b991..33b7e6c4ceff 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -351,10 +351,16 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
-	__u32 req_struct_size;
+	__u32 req_struct_size, next_cmd = le32_to_cpu(hdr->NextCommand);
 
-	if (le32_to_cpu(hdr->NextCommand) > 0)
-		len = le32_to_cpu(hdr->NextCommand);
+	if ((u64)work->next_smb2_rcv_hdr_off + next_cmd > len) {
+		pr_err("next command(%u) offset exceeds smb msg size\n",
+				next_cmd);
+		return 1;
+	}
+
+	if (next_cmd > 0)
+		len = next_cmd;
 	else if (work->next_smb2_rcv_hdr_off)
 		len -= work->next_smb2_rcv_hdr_off;
 

