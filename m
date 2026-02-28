Return-Path: <stable+bounces-220217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBlJNQQ0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5AB1C5DAB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 080E730E73B0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D544DC545;
	Sat, 28 Feb 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWj7djLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96534DC539;
	Sat, 28 Feb 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300122; cv=none; b=ntF9K2zvJPlVrb9Ao8ixaScjWG7C9h16K0swy9nKqFy2OXLVmPpdvB2gNmRARYFq8ST/AVhWa6SCOB6SzgsecWb2dJIw28FYoTLNH14NeuhO/giUTr+oA56U0J1Udq8BCfH7xBj7ksV8x/zBemn2werEh0HpTcJXe3zPy+/ydX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300122; c=relaxed/simple;
	bh=ioaz2LX6Riu+loomCejEGpzXL8egcwvTRFq/OvGpw7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXvzeAzisiEFuwKmBs3/NRV6pwhLHeoaN2Bi9NF/FqFK7sxoxwg9nUN5CcWVyj/75QSH4Ko+9U8ECdK2q/pcBiH7799SUGvB6GUywfmXCMAiSO8VwjPizTPSk4AnpKPB3vnOaEIBmOG0k2Rn30Q9s49b7ekxiKKW909xhq4Z4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWj7djLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A83C19424;
	Sat, 28 Feb 2026 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300122;
	bh=ioaz2LX6Riu+loomCejEGpzXL8egcwvTRFq/OvGpw7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWj7djLjtA33okc1Ulzj5T5kPI5pyQ68/n+OtuujSYC8rmXA/ZKd4Gb4U+sLDUFYN
	 xp4tYZ/KHGclwgvW9w2FgscdKkGuR4OP2sVN9llfvYTCV3xTHd/hmqhc11G6jbjMfs
	 9QlaV+yeThqrC3D4Xu2e3jkZREzJYDFiC05AfN/emx8M1FV3hGLfeCMg0cEQynVEaf
	 luo1QTQkrZPdl95jdkB+Nxq1xwSnvoq7li1nO1cUC1VH7gvkm0cByWH0vM+30Q37LF
	 2HPjv0vRxFCMmuP3wlklWxwaRPeIY6wrF+ZrWxbSpp/cIhAfniyVkuJV6D/afG13yE
	 MU3VK4+96hpAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Marek <jonathan@marek.ca>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 139/844] spi-geni-qcom: initialize mode related registers to 0
Date: Sat, 28 Feb 2026 12:20:52 -0500
Message-ID: <20260228173244.1509663-140-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220217-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DE5AB1C5DAB
X-Rspamd-Action: no action

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit 739062a9f1e9a77a9687c8fd30f8e5dd12ec70be ]

setup_fifo_params assumes these will be zero, it won't write these
registers if the initial mode is zero.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Link: https://patch.msgid.link/20251120211204.24078-4-jonathan@marek.ca
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a0d8d3425c6c6..9e9953469b3a0 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -724,6 +724,12 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	case 0:
 		mas->cur_xfer_mode = GENI_SE_FIFO;
 		geni_se_select_mode(se, GENI_SE_FIFO);
+		/* setup_fifo_params assumes that these registers start with a zero value */
+		writel(0, se->base + SE_SPI_LOOPBACK);
+		writel(0, se->base + SE_SPI_DEMUX_SEL);
+		writel(0, se->base + SE_SPI_CPHA);
+		writel(0, se->base + SE_SPI_CPOL);
+		writel(0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
 		ret = 0;
 		break;
 	}
-- 
2.51.0


