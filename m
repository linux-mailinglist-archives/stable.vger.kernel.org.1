Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098876AFA3
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjHAJt0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjHAJtL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46C1FD0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7BE614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F0FC433C8;
        Tue,  1 Aug 2023 09:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883265;
        bh=WVRwoKwrLONAYgMK5eNciSc9jTW6AGrgvZ0VpqpNpgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Me2LOiJKq4AYBRANVEsLIqgI/v7AgFybkekeVIt0OFPZ7VSNuci2UcR33LqCEbPr8
         ld9nHGsNKPH0lJs0pIiS4mgtfCPa6gRBEwTfxNsjyB4mzIT0aT3YmJrf++5Yv3dsvF
         n1QjR+oCsXDrh+doixvfyCa3vrgQSgU44JGiAn9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Zhang Shurong <zhang_shurong@foxmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 6.4 174/239] staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()
Date:   Tue,  1 Aug 2023 11:20:38 +0200
Message-ID: <20230801091931.916187852@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

commit 5f1c7031e044cb2fba82836d55cc235e2ad619dc upstream.

The "exc->key_len" is a u16 that comes from the user.  If it's over
IW_ENCODING_TOKEN_MAX (64) that could lead to memory corruption.

Fixes: b121d84882b9 ("staging: ks7010: simplify calls to memcpy()")
Cc: stable <stable@kernel.org>
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/tencent_5153B668C0283CAA15AA518325346E026A09@qq.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/ks7010/ks_wlan_net.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1583,8 +1583,10 @@ static int ks_wlan_set_encode_ext(struct
 			commit |= SME_WEP_FLAG;
 		}
 		if (enc->key_len) {
-			memcpy(&key->key_val[0], &enc->key[0], enc->key_len);
-			key->key_len = enc->key_len;
+			int key_len = clamp_val(enc->key_len, 0, IW_ENCODING_TOKEN_MAX);
+
+			memcpy(&key->key_val[0], &enc->key[0], key_len);
+			key->key_len = key_len;
 			commit |= (SME_WEP_VAL1 << index);
 		}
 		break;


