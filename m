Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94F75CE55
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjGUQUU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGUQT7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7719F4226
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82CF61D3D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB02EC433C8;
        Fri, 21 Jul 2023 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956322;
        bh=+RsjphFFg7pVLQ9ePTZLAZWQN410QFyG4FwkD9G1pKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XooHun++CCsgGUlPhGtsq9YVEWSdiU54WzsmIuKeD8ULoyQuKUxrVEHSsxsM8/b1j
         jIWfskeiUPK0jy1TA96CkEuiIMRH4XFmSRenOoLTN3ugn0kGiWFlZLhxdV9Lp+b7R3
         Pct4JB9OSB3pNc6tjPzkLzDba6snC6bagfeS0x7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Michael Haener <michael.haener@siemens.com>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 6.4 128/292] tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
Date:   Fri, 21 Jul 2023 18:03:57 +0200
Message-ID: <20230721160534.324545866@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit 83e7e5d89f04d1c417492940f7922bc8416a8cc4 upstream.

Underlying I2C bus drivers not always support longer transfers and
imx-lpi2c for instance doesn't. The fix is symmetric to previous patch
which fixed the read direction.

Cc: stable@vger.kernel.org # v5.20+
Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
Tested-by: Michael Haener <michael.haener@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_i2c.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -230,19 +230,27 @@ static int tpm_tis_i2c_write_bytes(struc
 	struct i2c_msg msg = { .addr = phy->i2c_client->addr };
 	u8 reg = tpm_tis_i2c_address_to_register(addr);
 	int ret;
+	u16 wrote = 0;
 
 	if (len > TPM_BUFSIZE - 1)
 		return -EIO;
 
-	/* write register and data in one go */
 	phy->io_buf[0] = reg;
-	memcpy(phy->io_buf + sizeof(reg), value, len);
-
-	msg.len = sizeof(reg) + len;
 	msg.buf = phy->io_buf;
-	ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-	if (ret < 0)
-		return ret;
+	while (wrote < len) {
+		/* write register and data in one go */
+		msg.len = sizeof(reg) + len - wrote;
+		if (msg.len > I2C_SMBUS_BLOCK_MAX)
+			msg.len = I2C_SMBUS_BLOCK_MAX;
+
+		memcpy(phy->io_buf + sizeof(reg), value + wrote,
+		       msg.len - sizeof(reg));
+
+		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+		if (ret < 0)
+			return ret;
+		wrote += msg.len - sizeof(reg);
+	}
 
 	return 0;
 }


