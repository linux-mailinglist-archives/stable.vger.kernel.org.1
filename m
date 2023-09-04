Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D50791D20
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjIDSfV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbjIDSfU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2D9E
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46854619A3
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5B0C433C7;
        Mon,  4 Sep 2023 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852516;
        bh=Yj5D4FRIPI1AFPnqux9n0Csz0bZRJBmRjyRYdG71KmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bY/DAg8Nphcz39r60daQYO/GcMfRxCk/gJ9RESWvcv+K6P8GABRD/JZVJQTxmcpyS
         3KuLxtXHkP7Mzv5qHSv+wlUjr783VLVlo+9pd7xPf6mQ3Mx3o1CFIdr2aL1r8V+a9X
         1n2ZLoTTM8EQ7thJqhfShsQ8RWvJgkzZ5f+Ip7NI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.1 03/31] ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
Date:   Mon,  4 Sep 2023 19:30:11 +0100
Message-ID: <20230904182947.157770722@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 4b081ce0d830b684fdf967abc3696d1261387254 upstream.

If authblob->SessionKey.Length is bigger than session key
size(CIFS_KEY_SIZE), slub overflow can happen in key exchange codes.
cifs_arc4_crypt copy to session key array from SessionKey from client.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21940
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/auth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -355,6 +355,9 @@ int ksmbd_decode_ntlmssp_auth_blob(struc
 		if (blob_len < (u64)sess_key_off + sess_key_len)
 			return -EINVAL;
 
+		if (sess_key_len > CIFS_KEY_SIZE)
+			return -EINVAL;
+
 		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
 		if (!ctx_arc4)
 			return -ENOMEM;


