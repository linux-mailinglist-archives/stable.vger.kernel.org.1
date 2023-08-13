Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C377ABAB
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHMVY1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHMVY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F58510D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B9F628EB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F57C433C8;
        Sun, 13 Aug 2023 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961867;
        bh=6w60sbFKMYmVG66+dYlN5FMzeWBOFAW6DGEOx/KgqSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkoolObUJxNonZ6coWpasWIPn2iuf18d1jteR7fcF3sUYLqVjlLlO8VXKtXCnHTsB
         OLs3Rw8AStw7lPb9j/sU2GHz+gE6hFizFxvdvx1thmxfLPXvOhx2BBlHoNAvMaRN0L
         70SCft3phoQXafXPprqs9l99GmWYxKjdL6a5f6EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Long Li <leo.lilong@huawei.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 005/206] ksmbd: validate command request size
Date:   Sun, 13 Aug 2023 23:16:15 +0200
Message-ID: <20230813211725.127664356@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Long Li <leo.lilong@huawei.com>

commit 5aa4fda5aa9c2a5a7bac67b4a12b089ab81fee3c upstream.

In commit 2b9b8f3b68ed ("ksmbd: validate command payload size"), except
for SMB2_OPLOCK_BREAK_HE command, the request size of other commands
is not checked, it's not expected. Fix it by add check for request
size of other commands.

Cc: stable@vger.kernel.org
Fixes: 2b9b8f3b68ed ("ksmbd: validate command payload size")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2misc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -380,13 +380,13 @@ int ksmbd_smb2_check_message(struct ksmb
 	}
 
 	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
-		if (command == SMB2_OPLOCK_BREAK_HE &&
-		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
-		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
+		if (!(command == SMB2_OPLOCK_BREAK_HE &&
+		    (le16_to_cpu(pdu->StructureSize2) == OP_BREAK_STRUCT_SIZE_20 ||
+		    le16_to_cpu(pdu->StructureSize2) == OP_BREAK_STRUCT_SIZE_21))) {
 			/* special case for SMB2.1 lease break message */
 			ksmbd_debug(SMB,
-				    "Illegal request size %d for oplock break\n",
-				    le16_to_cpu(pdu->StructureSize2));
+				"Illegal request size %u for command %d\n",
+				le16_to_cpu(pdu->StructureSize2), command);
 			return 1;
 		}
 	}


