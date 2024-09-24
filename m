Return-Path: <stable+bounces-76985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3769844F8
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E72EB21874
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9C1553A3;
	Tue, 24 Sep 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZAkc0gTx"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B5126BF7
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178004; cv=none; b=XEji7GfacFxZDpdAEuz++P+HqwKonZs2VSGQHsYXzLxU0J7tM/PGSHlnvrJM/234T0zb87yCNNch2v+ntJI6WERNgMuwXyeC1ulopgNkHNGXq/dSfX+qBFnsw55UmsKCCfZeFsgFzsnmAb+/1k64PaxAUyRC7BoEyIsoqddsaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178004; c=relaxed/simple;
	bh=vBy7OFug84v0/K0Vd+HlF324zw+uJF9x+kHFONfOVqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=dgqF6Ge0faBrIDK1QUnRgtSgNROOlgKMOhqFywknNjGO9sixnSDaFqzKgaPyZ3L8duaq1qkbasWGcFDkD0IUaR8jMtwGCoXQbHlluoF5ReMId6uMRYPN1CuexQM9Lg5QsxmmE3t+cfl0j4bz6YF5sTgkD6KuKHrwHe1wR6nk17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZAkc0gTx; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240924113959epoutp0120fb693dada3b6bdcc0b711281401661~4Kz1e7JIW1965319653epoutp01X
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 11:39:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240924113959epoutp0120fb693dada3b6bdcc0b711281401661~4Kz1e7JIW1965319653epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727177999;
	bh=sfSiZshNltBPyKbM7f8L8Q015QrPMyWEOljZ3sJgHEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAkc0gTx702Ghtmie69ml5RCg1Fh2DXRTKOe5rqhBUlLKYTjiW0oEBl3MwY8U35uA
	 DtNbVwoU/aOU61BUgM+BSSZJQFSgvfHTrcSp4ZarCa5Sm7MFkqHsDSSH/wqxJc6OIp
	 MlVfAyXIKrIwoIJyEKbkpmJGZd7JrLwAQ7UgemKg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240924113958epcas5p168c5de2bcdf5920ed7c06933205ff7ce~4Kz0xjJPN2492024920epcas5p1i;
	Tue, 24 Sep 2024 11:39:58 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XCdFT4nkJz4x9Q5; Tue, 24 Sep
	2024 11:39:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.BB.19863.D05A2F66; Tue, 24 Sep 2024 20:39:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240924113935epcas5p2be44abbfe0fe57d45e0daf528c495689~4Kze69DQs2354623546epcas5p2Q;
	Tue, 24 Sep 2024 11:39:35 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240924113935epsmtrp17aa15abaad8e58db8fc65b11d27bc0a9~4Kze6K3cR1853618536epsmtrp1l;
	Tue, 24 Sep 2024 11:39:35 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-8b-66f2a50d8f3b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.C0.07567.7F4A2F66; Tue, 24 Sep 2024 20:39:35 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240924113934epsmtip1083fc686b8e8827e5f6a14f987f51baa~4KzdmZMaQ0660506605epsmtip1b;
	Tue, 24 Sep 2024 11:39:33 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
	aakarsh.jain@samsung.com, akhilesh3.s@samsung.com, afzal.hasan@samsung.com,
	bharat.uppal@samsung.com, inbaraj.e@samsung.com
Cc: Varada Pavani <v.pavani@samsung.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] clk: samsung: Fixes PLL locktime for PLL142XX used on
 FSD platfom
Date: Tue, 24 Sep 2024 17:07:51 +0530
Message-Id: <20240924113751.89070-2-v.pavani@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240924113751.89070-1-v.pavani@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7bCmui7v0k9pBjf3qVo83TGT1aL79ztW
	i3m/HzJZHNq8ld3i2ssL7BZ3/0xis1i09Qu7xYKNjxgtNvS+Ynfg9OjbsorR4/MmuQCmqGyb
	jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
	gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGV8e
	L2Ir2MxZ8fxiP1sD4yP2LkZODgkBE4lDC+YC2VwcQgJ7GCWmf1jCCOF8YpQ4ef4wC4TzjVHi
	8rtNbDAtTc+/M0Mk9jJKnNo/gRXCaWWSuLPqPwtIFZuAlsTqqcvBEiIC2xkl5m7qBWtnFnCQ
	2PdlDiuILSwQIdHV/QLsEhYBVYl1L9cCjeXg4BWwlLjfkA6xTV5i9YYDzCA2p4CVRHfXAzaQ
	mRICh9glvuw9AfWFi8S0HadYIWxhiVfHt0DFpSRe9rexg8yUEEiWaP/EDRHOkbi0exUThG0v
	ceDKHBaQEmYBTYn1u/QhwrISU0+tY4K4mE+i9/cTqHJeiR3zYGwliZ07JkDZEhJPV6+BBpCH
	xM/GLdAw6WWU+HhtKfMERrlZCCsWMDKuYpRKLSjOTU9NNi0w1M1LLYdHW3J+7iZGcDLTCtjB
	uHrDX71DjEwcjIcYJTiYlUR4J938mCbEm5JYWZValB9fVJqTWnyI0RQYfhOZpUST84HpNK8k
	3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqaVOdk61V++lklfzvpj
	1Dvx+mM2KzmmvapP/BRW796o9S5+woej96/M2nw4zPeR8qINfzi3n9b5tHOHT61JrNnU2c2C
	W29PSlV4Fdy4LXpFH+um9cyl3055N+syzdrnI28tox5x4Gh3M9OZ07vv3zir1KUxha217FYH
	e3N42EvX+TqL5va5tN++tvroD41tmbwnlgYc3CWo3xv2vDzdff3E5TG7lT6tNbpntGmRuays
	uVZLweogQ8aUJ+yG325JSn01uhNZ+q7OW3O7ZuvT2i9fbqbFB29e/XBZr+ImljdBPStaXvgX
	ex5w2frT5V2T9LHHLRdrao4lawhvj3XdN1cy7+GOaS9nHVi66Wj4pRO5SizFGYmGWsxFxYkA
	CbQT/u8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSnO73JZ/SDL73iFo83TGT1aL79ztW
	i3m/HzJZHNq8ld3i2ssL7BZ3/0xis1i09Qu7xYKNjxgtNvS+Ynfg9OjbsorR4/MmuQCmKC6b
	lNSczLLUIn27BK6ML48XsRVs5qx4frGfrYHxEXsXIyeHhICJRNPz78xdjFwcQgK7GSUmN52F
	SkhI7PzWygxhC0us/PecHaKomUni79OtTCAJNgEtidVTl7OC2CIC+xkl2l87gdjMAk4SV99d
	Z+li5OAQFgiTWP2eCyTMIqAqse7lWmaQMK+ApcT9hnSI8fISqzccAFvFKWAl0d31gA3EFgIq
	uXHmJ/MERr4FjAyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCA01LYwfjvfn/9A4x
	MnEwHmKU4GBWEuGddPNjmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE0hNLUrNTUwtS
	i2CyTBycUg1MRs9C1UNvvb14Ubj4mDzf7d8Xc7+3ZX90K3p2ReWg/3GjXS8qNzj43dGao793
	bfPnKOfOvyc67uQdsLpbHzbl85ZzIoGH3hW2ZjH9Ss4p08vyW2pm+3mZjvAWlplfvDS+u5Q+
	kl9/5xSHfIs0z5ffOoJ3Nk9cH/08bu7nq0es2f597zNc9Gfj7fI2x2tTnpxcICbpPNuQqSDj
	ysMbX96bim/LWnDzRJpbV8jvRxv4fV8YWlfFJQvlvth3QExUSvCBuNhF9TcPVl/rWJ1a+P/R
	Ec2C/Rt+hphb/dqZ86gnSELzcag4G4POuuDPTOeT7ilpxbhcXXCOJSKi+lL45BddKx0iPWdP
	3TJTa9q8a9E8qkosxRmJhlrMRcWJAM21DeqjAgAA
X-CMS-MailID: 20240924113935epcas5p2be44abbfe0fe57d45e0daf528c495689
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240924113935epcas5p2be44abbfe0fe57d45e0daf528c495689
References: <20240924113751.89070-1-v.pavani@samsung.com>
	<CGME20240924113935epcas5p2be44abbfe0fe57d45e0daf528c495689@epcas5p2.samsung.com>
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


