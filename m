Return-Path: <stable+bounces-220297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDzKJrA2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B828A1C61C6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D02DB31264D0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE238B06F;
	Sat, 28 Feb 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGwwT/kY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7638B062;
	Sat, 28 Feb 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300201; cv=none; b=FT7TJTS1w/k+oPVxAicONCUYSf17bVUehln8vhKKcgK2FSxveEA4O8kDXAQWV4rHLzMdIWE1PwtlgBGJSQNU/IIR0emSaWFCY/9TpPjSjvOgE/a+dWOP5qAo1C0o6y9jcFBfVKnl/dZbJb6joyAEs36aNuFRePMMsWCw2BcdQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300201; c=relaxed/simple;
	bh=0mcpErzsT89PNp6WTm45KtHOVA09y6/piPalN8kPFUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvOEOEC84hEAMqv7j5DFulDLMtAELpvZ0U0A2CR6bDaEV4SipAyWb2a+dwhEcW2PORryrHLXxmIJqZwZ5wIorF5bsh/7KS3CNLfsI69Ve27pdZ/pxP/MVjZnb6BWRG/+DNlI5uXRf+zVHWJ5DWUQX/SjuOm6VwjPDJ4dHyF72cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGwwT/kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0795C116D0;
	Sat, 28 Feb 2026 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300200;
	bh=0mcpErzsT89PNp6WTm45KtHOVA09y6/piPalN8kPFUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGwwT/kYiEBj9ui7XcqMskFk3JQwbNBAmeug068vEp3lYzyJWj0xK4DYNu+z3SELf
	 6uaGwM9HlSaMobg92sinW1I4TYHBgXYULfg7OQP1loMyqKochAHpT5vaBhM2nhivZy
	 a/43OGb+csz6WxAGfNDL5PSTBohmm6x94+P8qr+qM6V2EvwZznUP0aYOac6D+qsapl
	 0rbI/QrqZeEOvZViUAtaZAzkHZPXui33uog/v2GB5E8wqwOVLHfyg/zU6Hv5Y3TaIP
	 oS9D5mniVBm01SBkSD1l1iNJuLxWUqCKWp72x9fIArPGUB0K0ijcgi1byoIErDXx3j
	 Bt3ockaZqFcJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 219/844] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
Date: Sat, 28 Feb 2026 12:22:12 -0500
Message-ID: <20260228173244.1509663-220-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220297-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B828A1C61C6
X-Rspamd-Action: no action

From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

[ Upstream commit 53f826ff5e0e3ecb279862ca7cce1491b94bb017 ]

spi_mem_dirmap_create() may reconfigure controller-wide settings,
which can interfere with concurrent transfers to other devices
sharing the same SPI controller but using different chip selects.

Wrap the ->dirmap_create() callback with spi_mem_access_start() and
spi_mem_access_end() to serialize access and prevent cross-CS
interference during dirmap creation.

This patch has been verified on a setup where a SPI TPM is connected
to CS0 of a SPI controller, while a SPI NOR flash is connected to CS1
of the same controller. Without this patch, spi_mem_dirmap_create()
for the SPI NOR flash interferes with ongoing SPI TPM data transfers,
resulting in failure to create the TPM device. This was tested on an
ASPEED AST2700 EVB.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://patch.msgid.link/20260120123005.1392071-2-chin-ting_kuo@aspeedtech.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6c7921469b90b..965673bac98b9 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -719,9 +719,18 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 
 	desc->mem = mem;
 	desc->info = *info;
-	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create)
+	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create) {
+		ret = spi_mem_access_start(mem);
+		if (ret) {
+			kfree(desc);
+			return ERR_PTR(ret);
+		}
+
 		ret = ctlr->mem_ops->dirmap_create(desc);
 
+		spi_mem_access_end(mem);
+	}
+
 	if (ret) {
 		desc->nodirmap = true;
 		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
-- 
2.51.0


