Return-Path: <stable+bounces-220260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BAHLpMyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FEB1C5B95
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2D6C349E4DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C62344D95;
	Sat, 28 Feb 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSdGZ3gf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0337CB38;
	Sat, 28 Feb 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300163; cv=none; b=LLwg9QtRrP1PttOO9Br04fOsneK7jEVJDra6fI1BD2/JWE78r+DDDAai1TkgoTBG14Xp4GYzySyQ1677cbxqbm6Z0rntP5UY9Jm9dexq5OY/LeEbEGTdR7xp33sYdvY1JOqogh3LNSK6WODN3vT/3w6S8pqjF8l/bC7IfH3i0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300163; c=relaxed/simple;
	bh=gPbdJqv4xljmyF8pHGB5Em8Jezw6VJqYoetBZ/ST+5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pprP5Mu+DV5X1HpoPEZIs5KhEw/eOUG3VkNkBpILAVn3urL3sQn9FhLLJgbXG0hQFpYxUn/a0H24i1CUA7VaYDHMWeTo0nW7mnYZeh7twU5JBILvN0zqAYXKykONUP/LPtqTGDDn/VpmK0fzxXIPkWXhK9aanUVvrDQiRqctr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSdGZ3gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62B3C116D0;
	Sat, 28 Feb 2026 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300163;
	bh=gPbdJqv4xljmyF8pHGB5Em8Jezw6VJqYoetBZ/ST+5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSdGZ3gfDTtyWjcmTi0xxa14Czgxs9H7tnS7SzEEVzmMiY3LYgL5KB44HEyNbXQCA
	 3TDyUt6i9Hq6kVqvEt1mTmMsADS3WwTMVFey3BIrbZxbJSxmXkgcLkHO1m5tgP+LVI
	 BznSl5uzeFrrzs5lj355WQmKWiyzE146YI3V5DY/MkMMbcVrI6kyl8JUMMaKQF2S0b
	 /KvQL16wKls7XsNepIdLQKlrrScl4JJY5N9SDebxMFtIdoqI43NOpckAOwBaRErIde
	 z20zUvDCMR+vAqKefW4ym1lE5naKfB1ForvnDni1Pq/oNb5wNd+9+aoeaJyJfg0byC
	 mqmbzjj2CVLPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 182/844] media: qcom: camss: Do not enable cpas fast ahb clock for SM8550 VFE lite
Date: Sat, 28 Feb 2026 12:21:35 -0500
Message-ID: <20260228173244.1509663-183-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220260-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 55FEB1C5B95
X-Rspamd-Action: no action

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit a89e490ba3551823511588b7b3828d67f8b82954 ]

The clock is needed to stream images over a full VFE IP on SM8550 CAMSS,
and it should not be enabled, when an image stream is routed over any of
two lite VFE IPs on the SoC.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index fcc2b2c3cba07..757c548af485a 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2704,12 +2704,11 @@ static const struct camss_subdev_resources vfe_res_8550[] = {
 	/* VFE3 lite */
 	{
 		.regulators = {},
-		.clock = { "gcc_axi_hf", "cpas_ahb", "cpas_fast_ahb_clk", "vfe_lite_ahb",
+		.clock = { "gcc_axi_hf", "cpas_ahb", "vfe_lite_ahb",
 			   "vfe_lite", "cpas_ife_lite", "camnoc_axi" },
 		.clock_rate = {	{ 0 },
 				{ 80000000 },
 				{ 300000000, 400000000 },
-				{ 300000000, 400000000 },
 				{ 400000000, 480000000 },
 				{ 300000000, 400000000 },
 				{ 300000000, 400000000 } },
@@ -2726,12 +2725,11 @@ static const struct camss_subdev_resources vfe_res_8550[] = {
 	/* VFE4 lite */
 	{
 		.regulators = {},
-		.clock = { "gcc_axi_hf", "cpas_ahb", "cpas_fast_ahb_clk", "vfe_lite_ahb",
+		.clock = { "gcc_axi_hf", "cpas_ahb", "vfe_lite_ahb",
 			   "vfe_lite", "cpas_ife_lite", "camnoc_axi" },
 		.clock_rate = {	{ 0 },
 				{ 80000000 },
 				{ 300000000, 400000000 },
-				{ 300000000, 400000000 },
 				{ 400000000, 480000000 },
 				{ 300000000, 400000000 },
 				{ 300000000, 400000000 } },
-- 
2.51.0


