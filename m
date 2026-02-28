Return-Path: <stable+bounces-220139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LhtNH4qo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B01C51D9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AC5A3182B6B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDCD48AE1E;
	Sat, 28 Feb 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+8cx1uI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4A48AE16;
	Sat, 28 Feb 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300048; cv=none; b=N5a7eskoP58HtylJA71BeEXpPho/5figJn+3AsxSo9e3kAtSgoeGLggGN20vuf+HEmNE4ImYNm2yTJU8Fi09gkXkSMWc9jpt7x7wGVt5Mfvvc12nELNuKUN6aeD8dK3w6w8lDrdx3bGXWbUr5PrVpZxBlzPb/9fI+68Vn6BXDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300048; c=relaxed/simple;
	bh=eZhw+wdg5qva2KkhBd421DUYgq7bIAGOMWDp7kXJ3IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3WcVNT7cMIsA0t0dV9C41zSIKVR6b/W3C+EWNwW6bCsGUDrBxrHSigjXmdEa+iR7LRkXrqpeTkX5yho+qu4fEOyo/H4xhzVBoFCiW9oPQToHO5PH91tEuFQMCnikQZ1XRFTSGD9ZwlpeXQm99VECyM6Vp0DC/mxaYHVLV0PJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+8cx1uI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FC7C19423;
	Sat, 28 Feb 2026 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300048;
	bh=eZhw+wdg5qva2KkhBd421DUYgq7bIAGOMWDp7kXJ3IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+8cx1uIraUM17nEZce3DjP6eexzwvjKUkf1YUM900I3466FrEXWdp3g5IW8gr3NP
	 SJCgcKADI3/OWdLaeVdt4A7PV00CuwV25eGcTPB7thFrvwmS383ey5K+ofiefo2c+S
	 VK/+uhDgJCUxDgbePQf6IiH1f3ST1wpwEc6r/KQeB9zBrXG4HhjxPETtcMv/76wvGs
	 ZgORqXJcK/NDJP+Q1dlwUCLOkeSWUwpzd158KF/7ef/NtAjNdrF404PsJjkUMEUx/U
	 l+OgAtIgVMt5zYfOj8WPYbxIY/0gEK5SCyPgQvUHA4b5AfoMCkvSI30JL28a2tA98c
	 VSSM+rrAKJAEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinqian Yang <yangjinqian1@huawei.com>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 061/844] arm64: Add support for TSV110 Spectre-BHB mitigation
Date: Sat, 28 Feb 2026 12:19:34 -0500
Message-ID: <20260228173244.1509663-62-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220139-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,huawei.com:email]
X-Rspamd-Queue-Id: 506B01C51D9
X-Rspamd-Action: no action

From: Jinqian Yang <yangjinqian1@huawei.com>

[ Upstream commit e3baa5d4b361276efeb87b20d8beced451a7dbd5 ]

The TSV110 processor is vulnerable to the Spectre-BHB (Branch History
Buffer) attack, which can be exploited to leak information through
branch prediction side channels. This commit adds the MIDR of TSV110
to the list for software mitigation.

Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 80a580e019c50..b3801f532b10b 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -887,6 +887,7 @@ static u8 spectre_bhb_loop_affected(void)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
 		{},
 	};
 	static const struct midr_range spectre_bhb_k24_list[] = {
-- 
2.51.0


