Return-Path: <stable+bounces-198874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A49DCC9FD8B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E743048D5F
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A034F484;
	Wed,  3 Dec 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQOMBWj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55D313558;
	Wed,  3 Dec 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777955; cv=none; b=Dpw7AfleoVSE9gc8XQ0sCf2u4GNEw1SjKc/qqnAiOcuzfVBqtmVaDI9/tJZNIwTbfz+vof/kJ1ydpTYG7TsEtr2Nt1lt+1hdPDXFB5KvzPdCDDOthsn61Hc7s0btJEDCg/ywxQuSq/FxJZwURmF7AcvSKpkNFl31awK3DCZJpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777955; c=relaxed/simple;
	bh=m4+MhPOGGAFRfTd8dlWFTXwhLmgTNbJbj+VgpgnFfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAb5xYevtPXsHxvoTE6cbM5ttKcWBkn4302GoKIJ8wDgUgYCz3p1IJ3aCvs7p/XVc+tCq/LQozkNjPyXuv6KqpdLWwJKvAsBAoEAr7RbQqLmVmu3shus9B5HYPuRRlm+fPfA1stDkO0/YmLInb2AKFGLR4WXdJqqpZ6FHSWJDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQOMBWj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0192C4CEF5;
	Wed,  3 Dec 2025 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777955;
	bh=m4+MhPOGGAFRfTd8dlWFTXwhLmgTNbJbj+VgpgnFfuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQOMBWj+xc2OlpADLbHLoKqtllIXG7l1qDj2QONHXve/ni+whF1GhDeYXpZDKJMD9
	 2znQXwbc11oRubACo3ZlVegV5Gwwp05IVUlNIJAekjeu0bVIB2RhX0Hd6KB6QPCjti
	 YNLGlMFLeWMN8e+UXCyBn5j1Lgnac+N2KdFDJbQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 197/392] clk: ti: am33xx: keep WKUP_DEBUGSS_CLKCTRL enabled
Date: Wed,  3 Dec 2025 16:25:47 +0100
Message-ID: <20251203152421.324123318@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

[ Upstream commit 1e0d75258bd09323cb452655549e03975992b29e ]

As described in AM335x Errata Advisory 1.0.42, WKUP_DEBUGSS_CLKCTRL
can't be disabled - the clock module will just be stuck in transitioning
state forever, resulting in the following warning message after the wait
loop times out:

    l3-aon-clkctrl:0000:0: failed to disable

Just add the clock to enable_init_clks, so no attempt is made to disable
it.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clk-33xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index f2c22120aaa75..37bb20e92f787 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -266,6 +266,8 @@ static const char *enable_init_clks[] = {
 	"dpll_ddr_m2_ck",
 	"dpll_mpu_m2_ck",
 	"l3_gclk",
+	/* WKUP_DEBUGSS_CLKCTRL - disable fails, AM335x Errata Advisory 1.0.42 */
+	"l3-aon-clkctrl:0000:0",
 	/* AM3_L3_L3_MAIN_CLKCTRL, needed during suspend */
 	"l3-clkctrl:00bc:0",
 	"l4hs_gclk",
-- 
2.51.0




