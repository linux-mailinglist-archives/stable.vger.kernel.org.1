Return-Path: <stable+bounces-105062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645499F5774
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A3A16E55C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3F1F8EEF;
	Tue, 17 Dec 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWLr9NVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DC749C;
	Tue, 17 Dec 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466595; cv=none; b=SAFkxrFSNVfOzu6SyGfK4MZljtegTGxOWQ2sB2KOtx8GWir6LwmIWO0hc/mNXKHsLNGzPibzAwzkhOaVHacOWtrm/p2uuz2NkkA8YKgapXuYWNpeYSs0eu7dxqfgVDwGZQdGKMVMfMbeSJq28Axris1nTlx7zLOu6Q98SID47BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466595; c=relaxed/simple;
	bh=+w7QFWiqsyThQ/PJOJZIXG/dhL6X0lgvSeC8TLDHq90=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=GNxISqS+sJYXzAJPwIWTI+qyyHtCoHg2GY1igcYlVDIblZl7EbjFjRCyBqfnkExOO3FmQA9pl7ebyMQlthUFu5dTkqXlWpWsjLOtmE0A6U3LJuGeylhEZXgsMuztgwBLRJWWN7CrmJZU8aa58hwFavE6CvM65Z0trxCkOf/nw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWLr9NVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EDBC4CED3;
	Tue, 17 Dec 2024 20:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734466593;
	bh=+w7QFWiqsyThQ/PJOJZIXG/dhL6X0lgvSeC8TLDHq90=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=RWLr9NVYRfsC5YeJnYSAJtERdDyXdeG1tAsyK4BKZJulBdIJJH6y9rZULakDqIf3q
	 OBwshHQOxihngNaXgvj7NS0BKORMY5PT0BAFg0vyQ2fN61829+TId6rY5rvI+1Rrw+
	 pCGdii6AsgD2cFvfd9YHPxuJAt6zYiDZxHP5+TwbDxGxnfqI13RezcP7lMnA9q4Ncv
	 lGdkNhr2SGGrVTTnuEsSHq1Y31igFk/BPcy7hQvUkpkK9SNYeWL5PzlXhw4Hz9K7ee
	 ek4vS6nqx+1hllJCyU2+VnLK53RfqWvjA/gQ562emtLWzuL3ampaguxMU/xtGtv/CP
	 v97RLcXgx2Aew==
Message-ID: <9f9f82956607d47881091bdb0eb6b380.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b8526c882a50f2b158df0eccb4a165956fd8fa13.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org> <b8526c882a50f2b158df0eccb4a165956fd8fa13.1734300668.git.daniel@makrotopia.org>
Subject: Re: [PATCH 3/5] clk: mediatek: mt2701-bdp: add missing dummy clk
From: Stephen Boyd <sboyd@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Geert Uytterhoeven <geert+renesas@glider.be>, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miles Chen <miles.chen@mediatek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date: Tue, 17 Dec 2024 12:16:31 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Daniel Golle (2024-12-15 14:14:24)
> Add dummy clk for index 0 which was missed during the conversion to
> mtk_clk_simple_probe().
>=20
> Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to =
simplify driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next

