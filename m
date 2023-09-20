Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C917A814F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjITMoT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjITMoP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:44:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4DC83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:44:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEF1C433C9;
        Wed, 20 Sep 2023 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213849;
        bh=nF8Z5SYUYcUaWEw8Sl2RrTtZDW+JffUNW48NIp3Qoxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTpSE1giYxysO0tHjBmE5TYRpPYIHnN8SD2kmzqUlNOi5KPhafnnqAmoqtpCQIUHw
         cZG7RGzgupnDh/Kii2ubuA8RW83F7+66CSFx28l1lwe6uaYGC/62dF6TsVPrNf5p+M
         26Y5mwqFyK2WTxfkjfJPMSH/vfNZDf0/KHAM1JHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/110] tpm_tis: Resend command to recover from data transfer errors
Date:   Wed, 20 Sep 2023 13:31:18 +0200
Message-ID: <20230920112831.150360994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Steffen <Alexander.Steffen@infineon.com>

[ Upstream commit 280db21e153d8810ce3b93640c63ae922bcb9e8e ]

Similar to the transmission of TPM responses, also the transmission of TPM
commands may become corrupted. Instead of aborting when detecting such
issues, try resending the command again.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d7c440ac465f3..b3452259d6e0b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -469,10 +469,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	int rc;
 	u32 ordinal;
 	unsigned long dur;
-
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	unsigned int try;
+
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc >= 0)
+			/* Data transfer done successfully */
+			break;
+		else if (rc != -EIO)
+			/* Data transfer failed, not recoverable */
+			return rc;
+	}
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
-- 
2.40.1



