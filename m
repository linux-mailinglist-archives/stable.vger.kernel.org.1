Return-Path: <stable+bounces-223043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJEfIUMiqGl3ogAAu9opvQ
	(envelope-from <stable+bounces-223043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:14:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B01FF8B8
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A0203025E34
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672ED3AE1BC;
	Wed,  4 Mar 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zDr4XQnT"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C513A8728;
	Wed,  4 Mar 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626495; cv=none; b=TTiMhcJe+ALmJ8Z3+xfV4ly/4Uct3I5Se2oa5i6DiEJJTKRfStKc729RUOltFdBRBtTuL45FK2qJoZZw/yD9lYdVCO0zPbtIBGj/KlkE8QLfqTYIE2rTfvYvvqps6h6gCh2ctJKXE+cZUeX3/YnFvqmGTaC1GL6ZDWEs0FZaEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626495; c=relaxed/simple;
	bh=o1IO/7Jx2Z8RpKsNrWhXXQKWQ/F53whEvuDY1IKh2Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDaQ6RywzT2RurbdB6ruvqc1tqh1i1CS7OVemR03ltiWNCSQZ1PgiuC2czWq6W8Jkgccky8CIP146uSf3cqvXln4V5qG3St6BiGkH+gM2+aYNRreVO8phQ3+/fcu8ene6TsVBlsEulE2qYuJFFRfdcMFPkc/74d0UHxyr52ZAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zDr4XQnT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=D1J6bBElKC5kc3fK81QWrSYx8rE0smFFIJm9isvrGyE=; b=zDr4XQnT4lsz+ngMWLnCpdR4BM
	ZCUu2f1o2py44Z97GR1XFrdgN/DjAMgLywfnvndfMHTKeWE+hVuXKkR0otnma5hIJ+eo1jMf2id+D
	gu2pJSHiH7jStO7Md/Jms+fjA7rHP62w3oAuz4+O9b9HFisVShulF1OZjKk8P540GGVh8TXaWoZpg
	SHDgBUxkLoDiRfMeMF3zdzAFwEKaAtCXLYrNVCvxn5jspG+oJFUVgHvvftbaS9fAwUAfOJUWJIE5a
	jzgl+hjoQKq9afGfbiXK87De0IHKg1UMmRxspiqDNB2col3YZYc8wf90H8nrUU7883b12iM7f2Tg1
	TsVL10iw==;
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	zhangqing@rock-chips.com,
	sebastian.reichel@collabora.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	andyshrk@163.com,
	macromorgan@hotmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] clk: rockchip: rk3588: Don't change PLL rates when setting dclk_vop2_src
Date: Wed,  4 Mar 2026 13:14:25 +0100
Message-ID: <20260304121426.1184680-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304121426.1184680-1-heiko@sntech.de>
References: <20260304121426.1184680-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F8B01FF8B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,rock-chips.com,collabora.com,vger.kernel.org,lists.infradead.org,cherry.de,163.com,hotmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223043-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sntech.de:dkim,sntech.de:mid]
X-Rspamd-Action: no action

From: Heiko Stuebner <heiko.stuebner@cherry.de>

dclk_vop2_src currently has the CLK_SET_RATE_PARENT flag set, which is
very different from dclk_vop0_src or dclk_vop1_src, which don't have it.

With this flag in dclk_vop2_src, actually setting the clock then results
in a lot of other peripherals breaking, because setting the rate results
in the PLL source getting changed:

[   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2 to 152840000
[   15.155017] clk_change_rate: setting rate for pll_gpll to 1680000000
[ clk adjusting every gpll user ]

This includes possibly the other vops, i2s, spdif and even the uarts.
Among other possible things, this breaks the uart console on a board
I use. Sometimes it recovers later on, but there will be a big block
of garbled output for a while at least.

Shared PLLs should not be changed by individual users, so drop this flag
from dclk_vop2_src.

Fixes: f1c506d152ff ("clk: rockchip: add clock controller for the RK3588")
Cc: stable@vger.kernel.org
Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger w/ DP
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/clk/rockchip/clk-rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 1694223f4f84..bea2deed0e23 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -2094,7 +2094,7 @@ static struct rockchip_clk_branch rk3588_early_clk_branches[] __initdata = {
 	COMPOSITE(DCLK_VOP1_SRC, "dclk_vop1_src", gpll_cpll_v0pll_aupll_p, 0,
 			RK3588_CLKSEL_CON(111), 14, 2, MFLAGS, 9, 5, DFLAGS,
 			RK3588_CLKGATE_CON(52), 11, GFLAGS),
-	COMPOSITE(DCLK_VOP2_SRC, "dclk_vop2_src", gpll_cpll_v0pll_aupll_p, CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+	COMPOSITE(DCLK_VOP2_SRC, "dclk_vop2_src", gpll_cpll_v0pll_aupll_p, CLK_SET_RATE_NO_REPARENT,
 			RK3588_CLKSEL_CON(112), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(52), 12, GFLAGS),
 	COMPOSITE_NODIV(DCLK_VOP0, "dclk_vop0", dclk_vop0_p,
-- 
2.47.3


