Return-Path: <stable+bounces-218298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H6/IZNRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF2418F02E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A7CB307D734
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3FE18DB2A;
	Wed, 25 Feb 2026 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSnMvYnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2C1E2834;
	Wed, 25 Feb 2026 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983099; cv=none; b=f+OWvGTM1nvDdvhSFCzD/Tzlg4BOggC1WRyLW5Bi7tCaZhqTfsVl9Xjp+0alfZAoew4liHCdEeZtzz/0nPdH2S+GElyKZGSKX4QiOe/5Tj8nGqL2JqtFnkuwNHDFE9rd4+azeoGjyq2hBdnUMpC7oKbL1xzJe/r9mCD/kcTpyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983099; c=relaxed/simple;
	bh=XCXbX0dJqcGirfWeaz3PwfKTds6v6fsQROxASmMrd9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdopoDFZZTVHLkCO3NxjMcTVGt3unVk4ju4jKkxnH36l1CQ6Us/x7jJTQisGV56IiEYgDC5sA6lynNpt3EpYbKcJtaPbwwNcl+CYP7DEBfpWNilDWMMTO7KtaMbXdKkTGjdnVyUxBqWH/jdDo9u/2DttnqbWWuM9uCHQMPabz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSnMvYnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457D6C116D0;
	Wed, 25 Feb 2026 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983099;
	bh=XCXbX0dJqcGirfWeaz3PwfKTds6v6fsQROxASmMrd9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSnMvYnjsRoOPygsOiT4k+2NSincjlGqJKqAfZOMpnjcvo5J3B6TyH+yC+EmSAQnQ
	 TL0XkPx1ldzWoG078lFRO+E7Iq4kgfryAfrb965CePl7Gc45lDimWPfWLY2BadT7L+
	 VgPMXuQ0dRetRVr/yEl3+hmBZMuTzpwEDQUvqsVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 253/781] spi: microchip-core: use XOR instead of ANDNOT to fix the logic
Date: Tue, 24 Feb 2026 17:16:02 -0800
Message-ID: <20260225012405.913738308@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218298-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2CF2418F02E
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 19a4505a7a5d4eea70f1a42d601c25d730922fdf ]

Use XOR instead of ANDNOT to fix the logic. The current approach with
(foo & BAR & ~baz) is harder to process, and it proved to be wrong,
than more usual pattern for the comparing misconfiguration using
((foo ^ baz) & BAR) which can be read as "find all different bits
between foo and baz that are related to BAR (mask)". Besides that
it makes the binary code shorter.

Function                                     old     new   delta
mchp_corespi_setup                           103      99      -4

Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260108175100.3535306-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-microchip-core-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 89e40fc45d73a..c8ebb58e0369a 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -161,7 +161,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 		return -EOPNOTSUPP;
 	}
 
-	if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
+	if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
 		dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
 		return -EINVAL;
 	}
-- 
2.51.0




