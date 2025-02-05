Return-Path: <stable+bounces-112902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E0AA28F01
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251113AA04F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4B1519BE;
	Wed,  5 Feb 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUKaoJcR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F94A28;
	Wed,  5 Feb 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765143; cv=none; b=mgIhR69JMvWeazk2/z0wPt2O0mjAhQfluKWgPB2IbBCF0XxcCEMvvtGyCYFJQ9gAH321HidFf/VRjHi0FDyBBNABWLoPEIskv9Cp6zMonMb2KQYqbJrEohittrFcrQbGvnKeGY9DW29JYeI8L1pzTZSBRkGFpDco23HS/qE4tLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765143; c=relaxed/simple;
	bh=pG5HAy0Jl1NARVXNrYziFZBtw+iTDZIzQf5cO0F+qRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWIwZLIy1JtDHaWWt8uKkgG4xwWGWvlrApS4IsdKawi3/IVQgFkBbGqYLhDh47mbE2sF6E7lHU+/+rwc7BJJUW0IzHOo1/5xHrA3iJoT1sN1tgVuLqpgXLN+y3j66d9SHQTM4PIFrOjyIxZoGzs0L3x3TUY4M1KwHjMeuMBfp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUKaoJcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F5C4CED1;
	Wed,  5 Feb 2025 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765142;
	bh=pG5HAy0Jl1NARVXNrYziFZBtw+iTDZIzQf5cO0F+qRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUKaoJcRNeUhDZ8iNh8IcWSpTvTRyaSSY8hHsOWfa6GErCYzJYYRSCPp8WY71mdfp
	 iqUpTjg6xjRDMKCgHnmZ0JqK5MkAKgy922R+Q/NDSSy3X8OptbfzSGzilZmDfM11/N
	 wAR6epiEuYIa1r2KUEwMD+FpQq2BXKjw0m/XO/Xk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Drew Fustini <dfustini@tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 169/590] clk: thead: Fix cpu2vp_clk for TH1520 AP_SUBSYS clocks
Date: Wed,  5 Feb 2025 14:38:44 +0100
Message-ID: <20250205134501.746177182@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Drew Fustini <dfustini@tenstorrent.com>

[ Upstream commit 3a43cd19f1b8d3f57f835ae50cc869f07902c062 ]

cpu2vp_clk is a gate but was mistakenly in th1520_div_clks[] instead
of th1520_gate_clks[].

Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
Link: https://lore.kernel.org/r/20241228034802.1573554-1-dfustini@tenstorrent.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/thead/clk-th1520-ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index d02a18fed8a85..4c9555fc61844 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -896,7 +896,6 @@ static struct ccu_common *th1520_div_clks[] = {
 	&vo_axi_clk.common,
 	&vp_apb_clk.common,
 	&vp_axi_clk.common,
-	&cpu2vp_clk.common,
 	&venc_clk.common,
 	&dpu0_clk.common,
 	&dpu1_clk.common,
@@ -916,6 +915,7 @@ static struct ccu_common *th1520_gate_clks[] = {
 	&bmu_clk.common,
 	&cpu2aon_x2h_clk.common,
 	&cpu2peri_x2h_clk.common,
+	&cpu2vp_clk.common,
 	&perisys_apb1_hclk.common,
 	&perisys_apb2_hclk.common,
 	&perisys_apb3_hclk.common,
-- 
2.39.5




