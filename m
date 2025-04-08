Return-Path: <stable+bounces-129936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79AA801F0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970D719E11E7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2F267F65;
	Tue,  8 Apr 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdCQobYe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101E267F5F;
	Tue,  8 Apr 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112375; cv=none; b=GNIqRKmY+Ooqf5a9PELx8EOKR4fYrJvgxtpWyi88o1W192ElEvP7sHSH9ae9DVan9OAoExXpySIJdlBU1axrx7hHpfBDMOh6FH9xdxeyYahk7bk+PmOPfrRPwCkaPBzo7HsBVAoB7H5Tgq9edlf7+oXWfuGeSZmK/gDThSxY6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112375; c=relaxed/simple;
	bh=jQs1Hu4+IVARjzYPbWLhbFtAM5GIjI7gnsqVHiqy3Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuzwaYXj1gGnbwOdw7VNtt2hn/4TP4ufjUgGiO3/V7ZHCT9Aqe4PPmJ8XOp3JB0gK2wmmhrtaxkhHKNC83Z+Yz6GN5sJH2Cl4iA9wOQGQA7XKADCfQV6yW4+XacDN64LVTzpvkh2VfzJQSbjpQW3Ztlu3Ba1J7Iuln1X2jS21Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdCQobYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E42C4CEE5;
	Tue,  8 Apr 2025 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112375;
	bh=jQs1Hu4+IVARjzYPbWLhbFtAM5GIjI7gnsqVHiqy3Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdCQobYedDvchDlSAaFUnLF/F9ohjGmNxyj45dKNZ9km3cqS8NfQTXOdXrNozS/s/
	 gYo7pbUDDWGz7BRfLwNzq6uFfOIc/s0Loe3PLHcubUaDFqdK19bi5zSsFk4AZjRHAb
	 9Q6Gns1YkxGG/lOURoTyv2Tmat/5QiI8N+bv1Dag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	James Calligeros <jcalligeros99@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 046/279] ASoC: tas2764: Fix power control mask
Date: Tue,  8 Apr 2025 12:47:09 +0200
Message-ID: <20250408104827.619823310@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hector Martin <marcan@marcan.st>

[ Upstream commit a3f172359e22b2c11b750d23560481a55bf86af1 ]

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Link: https://patch.msgid.link/20250218-apple-codec-changes-v2-1-932760fd7e07@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index f015f22a083b5..b18a637bd9fa3 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
-- 
2.39.5




