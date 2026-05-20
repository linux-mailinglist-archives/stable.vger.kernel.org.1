Return-Path: <stable+bounces-251450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFO0OCP+DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:32:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C6596765
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BDF7313765D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEE36F421;
	Wed, 20 May 2026 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1SrlE0aV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E136A36A;
	Wed, 20 May 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298013; cv=none; b=oD8HYVqhYqJabON4FxrWqORZm/ZLnXz4JAacARkZISYqlZ4FkS1fCdcf+A8BFEiTDpiVl3atthlypO6I40edTr8HySGKubZHcEFCAO4u0vPjdE0h5ThUA4l9M3/WZbdFlZFOZcPhmiT0AetEhLD8mzhTUcjN3p+zFvuXtMHVpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298013; c=relaxed/simple;
	bh=U9p4HdZFlVUwb5vuBQv5qSMKYXrPko7RWMSUPrN+qlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaRKrw8YrYMEgX5K7g9pGcQYH/7aRPIe0JkpJSI7qGZf6N/sUI4o0tXEDvKwY2SY8QHM0Q9jfZn3TbhKyDbMhFqzlYFZlfeytpIpLOCxLc2uTOTgPj0xvPX49tTfsFqt4NQ1VKby+ejvXbWhTWOip3zQFwqr1fmPH4jc37oXBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1SrlE0aV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9AE1F000E9;
	Wed, 20 May 2026 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298012;
	bh=3sERcYQqgSK9nUTAtdHj/P6FM8qmpfuLWiIAnsJ3U2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1SrlE0aVDwWRSp56pTdNe2OTDCtaRav59BAjDCBj223ZsLfPmfmti7BRvHXoYBwIt
	 VBRduJJb1zGk2r/V6JrJR5BYVEw/ejzh3xi1CWyrQGGqDQXLaFKh9/5OZN5pJTJeAr
	 u7QaO3Txb47+U6GaBuR1kgBTcDCD32PWYmb2z5Hg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Charkov <alchark@flipper.net>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 248/957] ASoC: rockchip: rockchip_sai: Set slot width for non-TDM mode
Date: Wed, 20 May 2026 18:12:11 +0200
Message-ID: <20260520162139.921404750@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251450-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E30C6596765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Charkov <alchark@flipper.net>

[ Upstream commit 8a6391ec669366cbe7bde92b468c561e8b309fd6 ]

Currently the slot width in non-TDM mode is always kept at the POR value
of 32 bits, regardless of the sample width, which doesn't work well for
some codecs such as NAU8822.

Set the slot width according to the sample width in non-TDM mode, which
is what other CPU DAI drivers do.

Tested on the following RK3576 configurations:
- SAI2 + NAU8822 (codec as the clock master), custom board
- SAI1 + ES8388 (codec as the clock master), RK3576 EVB1
- SAI2 + RT5616 (SAI as the clock master), FriendlyElec NanoPi M5

NAU8822 didn't work prior to this patch but works after the patch. Other
two configurations work both before and after the patch.

Fixes: cc78d1eaabad ("ASoC: rockchip: add Serial Audio Interface (SAI) driver")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://patch.msgid.link/20260318-sai-slot-width-v1-1-1f68186f71e3@flipper.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/rockchip/rockchip_sai.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_sai.c b/sound/soc/rockchip/rockchip_sai.c
index 6695349ee561e..b38c2cb81f807 100644
--- a/sound/soc/rockchip/rockchip_sai.c
+++ b/sound/soc/rockchip/rockchip_sai.c
@@ -628,6 +628,10 @@ static int rockchip_sai_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, reg, SAI_XCR_VDW_MASK | SAI_XCR_CSR_MASK, val);
 
+	if (!sai->is_tdm)
+		regmap_update_bits(sai->regmap, reg, SAI_XCR_SBW_MASK,
+				   SAI_XCR_SBW(params_physical_width(params)));
+
 	regmap_read(sai->regmap, reg, &val);
 
 	slot_width = SAI_XCR_SBW_V(val);
-- 
2.53.0




