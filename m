Return-Path: <stable+bounces-78252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F298A23A
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77FE1C22609
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B861917C2;
	Mon, 30 Sep 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gNwuM+EX"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50856190692
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698742; cv=none; b=EzKcKcYOT7KHXzR1mUmStlbfk5HhK0/negH5N/IdANBXioBxcw0qWEFdRmeKrr8bACpUMQ3lETAakFYi8lWpraxHzhlk9sSqufr3DhIyMMd5hLbvUD6qsJyLTyzIXPDQy1ZrFaBFXn2mZRcwhvH4soTUqUZc6IzJCgDBEera0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698742; c=relaxed/simple;
	bh=vBy7OFug84v0/K0Vd+HlF324zw+uJF9x+kHFONfOVqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=uZ7J0viHHE0FmFiR28ameOwXXWvrvApCjzZ/F2l6RKnFx04I2DeDvyWKKuzPjirQt7XRWvyVtbmMD5NOp50ONTxQqtzOBOYHnOKzUNXXfQAEexmV1boCLlnD7OHr/WE0aLIG1H1aM6ZAitT1/hJeZoDrhRHpLlluK0x+u59aoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gNwuM+EX; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240930121858epoutp0164557d461f5dd78ca5dcaf926ec76374~6BNlPSgMZ1253612536epoutp01O
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 12:18:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240930121858epoutp0164557d461f5dd78ca5dcaf926ec76374~6BNlPSgMZ1253612536epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727698738;
	bh=sfSiZshNltBPyKbM7f8L8Q015QrPMyWEOljZ3sJgHEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNwuM+EXvEKRw5E4bJrNQIYsztG+15o5EW5y3q+nBkcQGJNnLF5S3B4TPsJGw4fNO
	 yfryurxmgs72FwPgugXUI10kJf/PGqq60zvmUdNLDeWmH99V0/C02Jcd5E/D3U6dt7
	 Tm67ty/70hYKxlmXElaWG7WyjveTo8A+8CO3D/cA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240930121857epcas5p49237819634a1a4c2495b41604a0a0916~6BNkuReZ30681106811epcas5p49;
	Mon, 30 Sep 2024 12:18:57 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XHKqh4z6pz4x9Q2; Mon, 30 Sep
	2024 12:18:56 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.7D.18935.0379AF66; Mon, 30 Sep 2024 21:18:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240930112135epcas5p2175ec81bb609da5b166d47341ece2f67~6AbeqYbyM2495924959epcas5p2O;
	Mon, 30 Sep 2024 11:21:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240930112135epsmtrp1743da13a16b4401159e1c7a8d98ca372~6AbepoOGR2631226312epsmtrp1W;
	Mon, 30 Sep 2024 11:21:35 +0000 (GMT)
X-AuditID: b6c32a50-cb1f8700000049f7-2c-66fa973031bb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.57.08227.FB98AF66; Mon, 30 Sep 2024 20:21:35 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240930112133epsmtip2aabb8e0f2086f34c47bdb457a284a90e~6AbcoJIpt3034630346epsmtip2V;
	Mon, 30 Sep 2024 11:21:33 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
	gost.dev@samsung.com, Varada Pavani <v.pavani@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] clk: samsung: Fixes PLL locktime for PLL142XX used on
 FSD platfom
Date: Mon, 30 Sep 2024 16:48:59 +0530
Message-Id: <20240930111859.22264-3-v.pavani@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240930111859.22264-1-v.pavani@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTQ9dg+q80g+V9ahYP5m1jszi0eSu7
	xfUvz1ktbh7YyWRx/vwGdotNj6+xWnzsucdqcXnXHDaLGef3MVlcPOVqsWjrF3aLw2/aWS3+
	XdvIYrFg4yNGiw29r9gd+D3e32hl99i0qpPNY/OSeo++LasYPT5vkgtgjcq2yUhNTEktUkjN
	S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
	Z1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfHl8SK2gs2cFc8v
	9rM1MD5i72Lk5JAQMJG4ePIPWxcjF4eQwB5GidP/rrBAOJ8YJVauW8kI4XxjlOjY9ZQVpmXl
	hEusEIm9jBKvn02HamllkpjXsh2sik1AS2L11OVgVSICfUwSd09MYAJxmAX6GCVa2p6DrRcW
	iJDo6n4BZrMIqErcWXWADcTmFbCUuHnjNdSJ8hKrNxxgBrE5BawkLs35ww4ySEKgkUNi/vZX
	UEe5SOw8fJkRwhaWeHV8C1SzlMTL/jYgmwPITpZo/8QNEc6RuLR7FROEbS9x4MocFpASZgFN
	ifW79CHCshJTT60DK2EW4JPo/f0EqpxXYsc8GFtJYueOCVC2hMTT1WvYIGwPiXmT9kCDqJdR
	YuGP1UwTGOVmIaxYwMi4ilEqtaA4Nz012bTAUDcvtRweccn5uZsYwWlSK2AH4+oNf/UOMTJx
	MB5ilOBgVhLhvXfoZ5oQb0piZVVqUX58UWlOavEhRlNgAE5klhJNzgcm6rySeEMTSwMTMzMz
	E0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpgqn71W/OJoHKh6prdgXdsdPUHrZcnM
	M49wse0orBYJyautMjpXq2bxtOSIq0/ytk1ybSz+OXK/xAqnlKtUrLrxKMcl/tvxo5tyLjiL
	f533K3TuEnXLO/WfXJanaUef+bAysnPb4tc5F6b21VitvXFLoOq5wdnbb1Suv5i84tMPy7SX
	qmkGTkECvvOfGTzZde/N88kVP5xPlR2f/eNlite8huz7XX+WtKkvmGE6Vfuw0+uD168zr+uK
	X7t1DXPJhznFmj8rDnzcs0NCf9mMbQfeH5v9sT5+vQPf0gUXpmk2KK8+nxy3ryiFSeSoyFe/
	O0e6LuWeFtyrYe0m1pf1pndjcmp50Ow9DwJK77rn+LHFKLEUZyQaajEXFScCAI7CFkccBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvO7+zl9pBg9nCFg8mLeNzeLQ5q3s
	Fte/PGe1uHlgJ5PF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxaKtX9gtDr9pZ7X4
	d20ji8WCjY8YLTb0vmJ34Pd4f6OV3WPTqk42j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjf
	LoEr48vjRWwFmzkrnl/sZ2tgfMTexcjJISFgIrFywiXWLkYuDiGB3YwS3y98YYVISEjs/NbK
	DGELS6z895wdoqiZSeLi9xVg3WwCWhKrpy4H6xYRmMUkMXfJBxYQh1lgEqPEuj/ngao4OIQF
	wiRWv+cCaWARUJW4s+oAG4jNK2ApcfPGa6gz5CVWbzgAto1TwEri0pw/YK1CIDUvsyYw8i1g
	ZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcwlpaOxj3rPqgd4iRiYPxEKMEB7OS
	CO+9Qz/ThHhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamBS
	CC6Yv2LqRpX8CfOMj/xPnmEw+3/K383BnQYelh8+3ur5u2DOnc9xlRLLZia73e/xMerSO3A1
	zXfK9pmTfwSmTe279iT+BWPWbS99XeE7hfGLfpw1S+3WniedrTbtzrmOCq0vezdzS3FKCKre
	2mLd+r9Qc7mZ1wTT+sVfrl+t4dGZutlmb4rVkbdvl99LTPlqq8Kw5rl95cyKYyKvuc8sXPuq
	fF1CBedU8X9b3S96d04Sbnu5TubdgctbVr7R7oze7fak54fli9cBLydf14/4o7y5ztbXMv58
	4iSPyyFvdcpWc5wxmLWqdgdbaJTSBPsjq5V1CqMLnHJuTp+x2qpVqfEyY83yW/KBPdN7Vq9p
	VWIpzkg01GIuKk4EAKHIgknQAgAA
X-CMS-MailID: 20240930112135epcas5p2175ec81bb609da5b166d47341ece2f67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240930112135epcas5p2175ec81bb609da5b166d47341ece2f67
References: <20240930111859.22264-1-v.pavani@samsung.com>
	<CGME20240930112135epcas5p2175ec81bb609da5b166d47341ece2f67@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Add PLL locktime for PLL142XX controller.

Fixes: 4f346005aaed ("clk: samsung: fsd: Add initial clock support")
Cc: stable@vger.kernel.org
Signed-off-by: Varada Pavani <v.pavani@samsung.com>
---
 drivers/clk/samsung/clk-pll.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 4be879ab917e..d4c5ae20de4f 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -206,6 +206,7 @@ static const struct clk_ops samsung_pll3000_clk_ops = {
  */
 /* Maximum lock time can be 270 * PDIV cycles */
 #define PLL35XX_LOCK_FACTOR	(270)
+#define PLL142XX_LOCK_FACTOR	(150)
 
 #define PLL35XX_MDIV_MASK       (0x3FF)
 #define PLL35XX_PDIV_MASK       (0x3F)
@@ -272,7 +273,11 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	}
 
 	/* Set PLL lock time. */
-	writel_relaxed(rate->pdiv * PLL35XX_LOCK_FACTOR,
+	if (pll->type == pll_142xx)
+		writel_relaxed(rate->pdiv * PLL142XX_LOCK_FACTOR,
+			pll->lock_reg);
+	else
+		writel_relaxed(rate->pdiv * PLL35XX_LOCK_FACTOR,
 			pll->lock_reg);
 
 	/* Change PLL PMS values */
-- 
2.17.1


