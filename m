Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7895775D461
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjGUTUc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGUTUb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B9ED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 947BC61B1C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10CBC433C7;
        Fri, 21 Jul 2023 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967230;
        bh=zQ9vyPPsAm83hfZGIgmAi3Wx4iQ3/nUJvyP6XGYBxd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5hQSmmuuTFZTK/978a9dlosP536D9ypGl2rehzAk8gQmQRoTyISe51gQsUhqKSo/
         Yk2cwYgliy2rJGdNPuseXHNJs9IIKnzNAg1vdt37mY9c6ARK3C9sRKphR0iD/aBtNQ
         ztoawZsekyg+a2DOXAgm7R6QnBVVXMlHYWDUu/LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Michael Haener <michael.haener@siemens.com>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 6.1 090/223] tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
Date:   Fri, 21 Jul 2023 18:05:43 +0200
Message-ID: <20230721160524.698730965@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit f3b70b6e3390bfdf18fdd7d278a72a12784fdcce upstream.

Underlying I2C bus drivers not always support longer transfers and
imx-lpi2c for instance doesn't. SLB 9673 offers 427-bytes packets.

Visible symptoms are:

tpm tpm0: Error left over data
tpm tpm0: tpm_transmit: tpm_recv: error -5
tpm_tis_i2c: probe of 1-002e failed with error -5

Cc: stable@vger.kernel.org # v5.20+
Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
Tested-by: Michael Haener <michael.haener@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_i2c.c | 37 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index c8c34adc14c0..106fd20d94e4 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -189,21 +189,28 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	int ret;
 
 	for (i = 0; i < TPM_RETRY; i++) {
-		/* write register */
-		msg.len = sizeof(reg);
-		msg.buf = &reg;
-		msg.flags = 0;
-		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-		if (ret < 0)
-			return ret;
-
-		/* read data */
-		msg.buf = result;
-		msg.len = len;
-		msg.flags = I2C_M_RD;
-		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-		if (ret < 0)
-			return ret;
+		u16 read = 0;
+
+		while (read < len) {
+			/* write register */
+			msg.len = sizeof(reg);
+			msg.buf = &reg;
+			msg.flags = 0;
+			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+			if (ret < 0)
+				return ret;
+
+			/* read data */
+			msg.buf = result + read;
+			msg.len = len - read;
+			msg.flags = I2C_M_RD;
+			if (msg.len > I2C_SMBUS_BLOCK_MAX)
+				msg.len = I2C_SMBUS_BLOCK_MAX;
+			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+			if (ret < 0)
+				return ret;
+			read += msg.len;
+		}
 
 		ret = tpm_tis_i2c_sanity_check_read(reg, len, result);
 		if (ret == 0)
-- 
2.41.0



