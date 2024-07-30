Return-Path: <stable+bounces-64094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA0941C16
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828001C20C6D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B518801A;
	Tue, 30 Jul 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jhlw0jIg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06D1A6192;
	Tue, 30 Jul 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358971; cv=none; b=tzyA3wYWmGEKflT7LJoXrSB+laDNDML+VK0hKny3OuC29N3qOiJmi0Lml16RWIhtdJTEDIe8YkK8vy9NR+idZfwt6MPwDNIw7J9Vhj7a11s3WRKxPtJC2CjHvKbMHs9oiJb1CcTJ4+1cY8RhOqGdELjANF5FpuhH3jKBk3zEsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358971; c=relaxed/simple;
	bh=b2GTWfKcjijhyMeQu9TnZcv1JAapQQidBT5Qyixb+XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plvQQFk4WobjU2TRqGbo8eb03CYxPY/uEJgqNQKGngyes+IzauA0mRuhiPlSn+AYZpLjnk5YaDKihA30UYgTaCgLeSbwaWwZrUf48rN+GjNGYBxCG4OYTIBsrP+dgo1rWyz4dAxEvn8Dpjd9jpKlkP3m91o0kFzpMTiF6f9GSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jhlw0jIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B2C32782;
	Tue, 30 Jul 2024 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358971;
	bh=b2GTWfKcjijhyMeQu9TnZcv1JAapQQidBT5Qyixb+XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhlw0jIg2EqKjRGJ7pR+1dRIca6iuf0iaNZtecIqT+krRbSrZuUNYlYyPiHxlHo0I
	 +7vgIY3oDNXVxULQ8kW7lz/XpY0B8ieAmA4wp8bzGbnZwy+NzZlYg6Gu8ISuBt3P/j
	 BFi/YVq52R0181rJivssE355lWGTP/sEAc/tomNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 394/809] clk: meson: s4: fix fixed_pll_dco clock
Date: Tue, 30 Jul 2024 17:44:30 +0200
Message-ID: <20240730151740.242709597@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

[ Upstream commit c1380adf2e8680a00dedaf1b25c19beadbbe5bbd ]

The fixed_pll_dco output frequency is not accurate,
add frac factor for fixed_pll_dco clk to fix it.

Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Link: https://lore.kernel.org/r/20240603-s4_fixedpll-v1-1-2b2a98630841@amlogic.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/s4-pll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index d2650d96400cf..707c107a52918 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -38,6 +38,11 @@ static struct clk_regmap s4_fixed_pll_dco = {
 			.shift   = 0,
 			.width   = 8,
 		},
+		.frac = {
+			.reg_off = ANACTRL_FIXPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
 		.n = {
 			.reg_off = ANACTRL_FIXPLL_CTRL0,
 			.shift   = 10,
-- 
2.43.0




