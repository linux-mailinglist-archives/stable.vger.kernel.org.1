Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9102A791CCF
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjIDSbt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjIDSbt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:31:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF96CC8
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 146D0B80EF5
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA3CC433C8;
        Mon,  4 Sep 2023 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852303;
        bh=TNNy8Qjy57OkYRPEy89X89oWn1rE2hipgfzRTIUgSZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtnjzuUHm6l9aU3E/3MznFldJvLcOOlqfc39LjVMSMiNupn0IJgHyX8lZCs7MAfEA
         REzMsPlYRu99EIq4uzNQkaeG3zBGDlvefxy+XIQR07lWPD0wu8vrqdWmpQVWxagxpl
         vIF/atEjnjmRmZ6hdD7e8/Wtf0+HBxz/pgLnCRhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.5 04/34] ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
Date:   Mon,  4 Sep 2023 19:29:51 +0100
Message-ID: <20230904182948.806499601@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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


