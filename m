Return-Path: <stable+bounces-220438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDIUAts6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E271C6790
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37A7E32C868D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1913B5BE0;
	Sat, 28 Feb 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKEnZ6P5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B3B4489;
	Sat, 28 Feb 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300327; cv=none; b=tzh+yWhfm6rmTzi3yMzsR0tW7Loqmdo17bxSP9cc+7dI7WSsaHTaYyCosYqpyhkyRUSFks10AIuIe0pXb4RkErVjKxzdObJBVFwivMjQXgWLeRkWMogIvPBusnV9aFndwnEmsRnrMxcjJehvLrHr1FJIBzrPvJO8QH0OGILoUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300327; c=relaxed/simple;
	bh=/4RIoFWQvmnECXfpoZ2li00lAcsTSHybmqIwvfbhU54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/RrUch9MBDPEhEJ38dqWMKsuSB0R7ziS1SAAdoBFcViL860BgJSHjHskCY0Kzv6Ak8k5uykuGER+pHDHJdy3oo+BU7u+ohQ86yHhwXhYbV0xG0DL882LbftHMejNU6FE8Lsemr3woMq8STMUzV6O08YGEfEyUnONq2I7bsuM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKEnZ6P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF930C19424;
	Sat, 28 Feb 2026 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300327;
	bh=/4RIoFWQvmnECXfpoZ2li00lAcsTSHybmqIwvfbhU54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKEnZ6P56ixpUTKZp8RHbMlDATVbk7bU9r2DktZPwxpj1ClAdD/922X4wTqCnW0P0
	 1efKSP+5JcOvvraOxysHzndyasYyD9AjW4+S2M6FT+6mlz76dgfDHaC2QxqJaniiwL
	 LFIGP4LodbT0+zjhBgw26iSoQSY/wIJVgsw9oHc8iyeyD2fUi8u9YRbVe22hIF+Xp2
	 FAHnhFw0huSngZeQJX8GL/AvBEF4KconquY+NWNSQF6gnxreJAHDngnD90TF0PSWIB
	 nb2BaDJHn607SKipuehmyjmGNKGIgkIAPk/t6t18TNyGIP+VPJ7xAZQ+kpCE/evsbx
	 etCDbQvRT1Z/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chuan Liu <chuan.liu@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 359/844] clk: amlogic: remove potentially unsafe flags from S4 video clocks
Date: Sat, 28 Feb 2026 12:24:32 -0500
Message-ID: <20260228173244.1509663-360-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220438-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amlogic.com:email,baylibre.com:email]
X-Rspamd-Queue-Id: 28E271C6790
X-Rspamd-Action: no action

From: Chuan Liu <chuan.liu@amlogic.com>

[ Upstream commit 4aca7e92023cac5018b4053bae324450f884c937 ]

The video clocks enci, encp, vdac and hdmitx share the same clock
source. Adding CLK_SET_RATE_PARENT to the mux may unintentionally change
the shared parent clock, which could affect other video clocks.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Link: https://lore.kernel.org/r/20250919-add_video_clk-v6-3-fe223161fb3f@amlogic.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/s4-peripherals.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 6d69b132d1e1f..bab4f5700de47 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -1106,7 +1106,6 @@ static struct clk_regmap s4_cts_enci_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1122,7 +1121,6 @@ static struct clk_regmap s4_cts_encp_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1138,7 +1136,6 @@ static struct clk_regmap s4_cts_vdac_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1169,7 +1166,6 @@ static struct clk_regmap s4_hdmi_tx_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_hdmi_tx_parents,
 		.num_parents = ARRAY_SIZE(s4_hdmi_tx_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.51.0


