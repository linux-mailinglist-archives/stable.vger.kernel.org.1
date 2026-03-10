Return-Path: <stable+bounces-223951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOA0Le78r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD624A28F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E1993174BB4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510235AC23;
	Tue, 10 Mar 2026 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvC3fCj0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32A2D978B;
	Tue, 10 Mar 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141086; cv=none; b=rBuPOjR+V03+N4+k7fdOWzAVvHbkTCuuphZb7J6vowsw+Y801BxoDFPZrltrB3gGlgA/AOh3KgywIhgpnJPe44W9fItDI5dmF5LQyxTt7snMjAp5jmB48iG5Pb5dMTdNGn0NuddFnoz8aDhXcbm+x+LU+euAycH/H4b2BHg7mTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141086; c=relaxed/simple;
	bh=TOB66ADbYOW0D6QGNyfHFRUs/DkcqeEQ0i71djPOefo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8angs4wyjDtW/mQPaWZRuxLPry5X1fOxnu3sjhYPKxWKAIQ/PwjP4jnlLlxkWCi/Q5ZZcRcBl7FGqu8duY1w0N6lBdqKv26UUawsaK++z86xQKWZ2WYfd8myP+nMjbqsPFDCnIgMVaAWLfwBNAnC9Q/NvyOYF+c71wZ6o4G5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvC3fCj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B127C19423;
	Tue, 10 Mar 2026 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141085;
	bh=TOB66ADbYOW0D6QGNyfHFRUs/DkcqeEQ0i71djPOefo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvC3fCj0RxrmUOspux7k2K4nlqk1Ne+s/CwivvLXRmoxvsPa5zoMpCHbALwz7x6ds
	 DpPsgzawq7LRvGBTVJY4+aDLVQc4zNnlGogt/yp+0fR8V1Cv3M0ConHfIFvCROCFm2
	 tqEykxg7cH4w3H9JK5xuJFrJMW4TJCJaTcWczqGQHLvSxNCVfaYRDqQEeqeIXtjFam
	 Svdv+5nBRIG0n4JdbLSrVjvq1h1jclYbJMU5k9kqp7kdWf1IKOQrlx3IlDAb3HpKwr
	 rB+iieHi9f2duChHAGo+Pv2PGQ7DETRFFT+4R46zKKJWkkIcOy3KctRSCxvj6YUqLD
	 G0u2qBI5/T1vw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 086/311] spi: stm32: fix missing pointer assignment in case of dma chaining
Date: Tue, 10 Mar 2026 07:02:13 -0400
Message-ID: <d952700fa2ac7a310fc2e6a0036ba1fa5c04d147.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20BD624A28F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223951-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mandelbit.com:email,st.com:email]
X-Rspamd-Action: no action

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit e96493229a6399e902062213c6381162464cdd50 ]

Commit c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
introduced a regression since dma descriptors generated as part of the
stm32_spi_prepare_rx_dma_mdma_chaining function are not well propagated
to the caller function, leading to mdma-dma chaining being no more
functional.

Fixes: c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Link: https://patch.msgid.link/20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 80986bd251d29..7a6ee93be9bd4 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1570,6 +1570,9 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 		return -EINVAL;
 	}
 
+	*rx_mdma_desc = _mdma_desc;
+	*rx_dma_desc = _dma_desc;
+
 	return 0;
 }
 
-- 
2.51.0


