Return-Path: <stable+bounces-56142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A6891D254
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD69281553
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D355153563;
	Sun, 30 Jun 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc7zUtxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C792282F1;
	Sun, 30 Jun 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761646; cv=none; b=MRj/EOB1XPsKsrk9O9Rd9om8mEw01PihpQzraOfk1MYoDrHrlMbrAM0yAVrAF61um6GNOicYm9r/JShO0RQntvcRU6zuFGtJ+G6+cBR0+J0FNRubE9GavlYzsxpNLu3V4LySJLXNeqLZCIvcXHLEBUQ6t2RJH2dh512d8PqcgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761646; c=relaxed/simple;
	bh=oBsDaIgWwOPsN5NcDJk1MTGtGIh9YzY81gZmoTW+7Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh+j8JOGxXoenUlwVcBOBqrtMZYqzYRnkarx95uEOfIk8gRJTJBFR/cB/6qjrOKxRujyqUwuUTzZXQJbozT/MTXYghHuFxo7hzXFHVM9bLEegRiW/r/em0D+Pz3tptR6oieFM3pUohqf8d+4X21w7VWA05s3hKAvxBDYfuiPMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc7zUtxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F8EC2BD10;
	Sun, 30 Jun 2024 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719761645;
	bh=oBsDaIgWwOPsN5NcDJk1MTGtGIh9YzY81gZmoTW+7Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fc7zUtxhDWhgTkv4LQ29OHLe2IiluCwDUiWsZj2GETG+towrxRViQgzgjTuWsPozG
	 kRdD9A9a63BkxcSMjqUA9UV8+5S6oPqO1Aj7umyUgMuSYxLJPv67BixCDpWvVpuhaS
	 sNT/a+7/Em3FM89w1RU0k9DQ2aB6dvUIj+ZBa1AC+dSbP0WAGZgjeQr4wRF82iVNIj
	 7YeR1cYPzf4+nzSMthbtVEjXpnjkRCmQJwK/PrALsN09FA4IE/MGXmZfoXZJHsHA4j
	 Aiv9JBtUWJa5h/iAou+T8cEu2ymT6JXb6b/gFt/PfD/fjcVpmr+ehXXV8hTDlrKu8X
	 tFzix+OVM05Xw==
Received: by wens.tw (Postfix, from userid 1000)
	id 58B8C5FD47; Sun, 30 Jun 2024 23:34:03 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Frank Oltmanns <frank@oltmanns.dev>
Cc: Chen-Yu Tsai <wens@csie.org>,
	=?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Robert J. Pafford" <pafford.9@buckeyemail.osu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw without common
Date: Sun, 30 Jun 2024 23:34:02 +0800
Message-Id: <171976163761.1183893.10044135406471629615.b4-ty@csie.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
References: <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On Sun, 23 Jun 2024 10:45:58 +0200, Frank Oltmanns wrote:
> In order to set the rate range of a hw sunxi_ccu_probe calls
> hw_to_ccu_common() assuming all entries in desc->ccu_clks are contained
> in a ccu_common struct. This assumption is incorrect and, in
> consequence, causes invalid pointer de-references.
> 
> Remove the faulty call. Instead, add one more loop that iterates over
> the ccu_clks and sets the rate range, if required.
> 
> [...]

Applied to clk-fixes-for-6.10 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw without common
      commit: ea977d742507e534d9fe4f4d74256f6b7f589338

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>

