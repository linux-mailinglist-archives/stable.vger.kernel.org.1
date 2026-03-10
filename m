Return-Path: <stable+bounces-224245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHoOGFgCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2024B1C6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1B03303A279
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA39389462;
	Tue, 10 Mar 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM1bpjch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A7389116;
	Tue, 10 Mar 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141942; cv=none; b=TazN3nPNK9GtP/fMAUHknzYnGxlHNNS0P6A0t7sp/D5uO/N3qt3maN5Sgf7XOEXxyg7ag1yPdY5wzysIT0wDN3iOQuWOrY6hkS8OYpIR1MSk9ZjEtaptHj+21g2joUummC/gfXujtDyts9EPyLpCFo08v58lHxB7Lj7BnBSTU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141942; c=relaxed/simple;
	bh=TOB66ADbYOW0D6QGNyfHFRUs/DkcqeEQ0i71djPOefo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcwAj/DStalaiRabAcPiv5Tf4eU4qL9Q21ZiQulXo/HTvbOd9rrNIUa37jMQYlcL4ujJnRvIf7Vur8M/J4jg4qCNAa94xZZo69oFiXWoVF7lMoVCFOC9z+3Q3Q+jhnFc/LlINUBF7NtPKEhGNsSynGUwRZgGSFWMagWN4VqQ17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM1bpjch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754E6C19423;
	Tue, 10 Mar 2026 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141942;
	bh=TOB66ADbYOW0D6QGNyfHFRUs/DkcqeEQ0i71djPOefo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FM1bpjchyrGL6pYMrheYYFuoM/OCl/mbMhExTY/Q+W+1NK2lsYavs2pV99BoTZcY1
	 HGamGHwDGOs+v4Nk8iIlSBQqV3o3b3X3GJObYLgDpoP3C00z2kxUBVAIMuL/8Vaagk
	 meqGvBSRg7vgKv3jo19r7fEUJnc9QrsX+qzU+zEPxmmugiwHoS5UKyR1FxKV6Q4pkL
	 0bJqoFeNg+J6ItQbRt4Czu+UXfPhXeuaiGTPMk1aVLi1c8WPq2gWs09e8/hkrc3anr
	 97Ks9fwgh8quEHLpvCaUDEP6tWs2qBH4MuJ0jEgymacKftsHlhSwmynVt+rmZExPNz
	 oevCaR6xG63Kg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 066/314] spi: stm32: fix missing pointer assignment in case of dma chaining
Date: Tue, 10 Mar 2026 07:15:25 -0400
Message-ID: <989b22bbe9b32527a6799d787a5cd10024971a74.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EC2024B1C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224245-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mandelbit.com:email,st.com:email]
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


