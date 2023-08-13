Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922A77ABAC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHMVYa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHMVY3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55810E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E496628EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A96C433C7;
        Sun, 13 Aug 2023 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961869;
        bh=pJVku/S6MGCm4dTdMdSsfRTa1JsZUQsf5Qqr9R2FQ7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kN5bGfi1md+5e1DfoyG3M9JmkH7ZGMPzvabM+dde2C34calMCcSSxxEIeg/7ivp9x
         w9VKKSarp6Ppc28k1efcFkkcXUqW96AbDRA0D4xAU9H/FkaSr4zQvz2jF16yQvTOa9
         NjNih3eZuTCy2aqKpcrQC4N25XkswA9MnUJjQ7Uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.4 006/206] ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()
Date:   Sun, 13 Aug 2023 23:16:16 +0200
Message-ID: <20230813211725.156311757@linuxfoundation.org>
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
 fs/smb/server/smb2pdu.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2324,9 +2324,16 @@ next:
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


