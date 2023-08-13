Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB777AE3A
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjHMWS1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHMWSN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 18:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78462123
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D4D460F71
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93458C433C7;
        Sun, 13 Aug 2023 21:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963008;
        bh=ZYN6cahuBPqKew9p1Yh0el1Wz+A8GFm7Ylbn5Ildkgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNdsLbA21fJoyOABQcfg5HXYxtGD74VYcstyVd78odKAoI30bfey5UAV7048fFHkT
         riT+Pj/qsjMAqY2Ysoe/cKU5esw/AEXx3NgudLrXP+oBKWU7T4ehei77OHZXYx7uHS
         0suz1eZ76jxXC6Q7IOG3SS/bBp826Eo+TOzslZSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 02/89] ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()
Date:   Sun, 13 Aug 2023 23:18:53 +0200
Message-ID: <20230813211710.859658800@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 79ed288cef201f1f212dfb934bcaac75572fb8f6 upstream.

There are multiple smb2_ea_info buffers in FILE_FULL_EA_INFORMATION request
from client. ksmbd find next smb2_ea_info using ->NextEntryOffset of
current smb2_ea_info. ksmbd need to validate buffer length Before
accessing the next ea. ksmbd should check buffer length using buf_len,
not next variable. next is the start offset of current ea that got from
previous ea.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21598
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2309,9 +2309,16 @@ next:
 			break;
 		buf_len -= next;
 		eabuf = (struct smb2_ea_info *)((char *)eabuf + next);
-		if (next < (u32)eabuf->EaNameLength + le16_to_cpu(eabuf->EaValueLength))
+		if (buf_len < sizeof(struct smb2_ea_info)) {
+			rc = -EINVAL;
 			break;
+		}
 
+		if (buf_len < sizeof(struct smb2_ea_info) + eabuf->EaNameLength +
+				le16_to_cpu(eabuf->EaValueLength)) {
+			rc = -EINVAL;
+			break;
+		}
 	} while (next != 0);
 
 	kfree(attr_name);


