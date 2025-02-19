Return-Path: <stable+bounces-118031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434FA3B8DF
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24607A510E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752331D54FA;
	Wed, 19 Feb 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xV1rLNit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F28629E;
	Wed, 19 Feb 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957041; cv=none; b=U/JGjtk2weI/CODqxnitYTaZeVkM8/JjVKXxB4Fqad8/emd8uiSkmVkHmIKeeFuSK/RbopSIeGjZw+KAvA459QNRw3jpz1d/QiS1rv/6NjFzQuV27FpeUNYqyUqEFzR/GeqgtM5+sfULjMGOj7ZTdusP0iPrZs3mOVbHNEyx7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957041; c=relaxed/simple;
	bh=Wq5UHDrA6oTJTLcCG3mag2XRhaYhIWKVOjxtd1iU9Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh+5k6tIG9NJEvVFSrlhxof3tvhQpIHjMUBQewEwvxcp+thw/0dWKyMTzW0c2gNsyp5oZaqG1Mo0nROjdEZKcw/BhlDQf4eu0j1/eckn614xHmLjXY4ZwwrISZ0qcfIlw5l7YDyJNeamYDr90UwLN5eKKxRjIezn01t8LEAXE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xV1rLNit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC87CC4CED1;
	Wed, 19 Feb 2025 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957041;
	bh=Wq5UHDrA6oTJTLcCG3mag2XRhaYhIWKVOjxtd1iU9Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xV1rLNithEOI4D//X10d0Eo+LgKOVT/FzQz07lI8vantcgKI/2SdltJIWdxJRoRGw
	 ByRnh/lnZnmnCj8X09DAPzsJntEorsWVWc3OHfRvoFgDh7YoDwmPO8ncJo2ftN0QIi
	 LUAMVWyKABCuXMLlDOGeNTIoditATt5A3/KPw21s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 6.1 356/578] clk: sunxi-ng: a100: enable MMC clock reparenting
Date: Wed, 19 Feb 2025 09:26:00 +0100
Message-ID: <20250219082707.027049250@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cody Eksal <masterr3c0rd@epochal.quest>

commit 16414720045de30945b8d14b7907e0cbf81a4b49 upstream.

While testing the MMC nodes proposed in [1], it was noted that mmc0/1
would fail to initialize, with "mmc: fatal err update clk timeout" in
the kernel logs. A closer look at the clock definitions showed that the MMC
MPs had the "CLK_SET_RATE_NO_REPARENT" flag set. No reason was given for
adding this flag in the first place, and its original purpose is unknown,
but it doesn't seem to make sense and results in severe limitations to MMC
speeds. Thus, remove this flag from the 3 MMC MPs.

[1] https://msgid.link/20241024170540.2721307-10-masterr3c0rd@epochal.quest

Fixes: fb038ce4db55 ("clk: sunxi-ng: add support for the Allwinner A100 CCU")
Cc: stable@vger.kernel.org
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Link: https://patch.msgid.link/20241109003739.3440904-1-masterr3c0rd@epochal.quest
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -436,7 +436,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDI
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  0, 4,		/* M */
@@ -444,7 +444,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDI
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  0, 4,		/* M */
@@ -452,7 +452,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDI
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);



