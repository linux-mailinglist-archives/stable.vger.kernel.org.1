Return-Path: <stable+bounces-77798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE1987694
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3872816BE
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5C159217;
	Thu, 26 Sep 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G0gY/3KF"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084C158A13
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364837; cv=none; b=SqyaGB25faatOXAAq/0uocvEl5lLao28d9LYpk8SbjkRRvjf93DBWlhPWhg42oQdALv2U94jH6pUou7vfY7vWDcrZ+E8B5s220pizR6Rptq5zY7ITQeFQ1ocCEldSWex5XF9umbx3uGMgjvS3ePhW7fdjrYvXgwWT56woqBQX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364837; c=relaxed/simple;
	bh=vBy7OFug84v0/K0Vd+HlF324zw+uJF9x+kHFONfOVqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=t1jhJ17Xn/xRuIzb5NduhCWiZe4w/pbwHa8/Pgop0kAZQU+ZTsGQ9i9IlM/ROZunSvS60Q0E9Z025X6VqnsqJln+P7u7oNJ9QP+AUCe9xpjZpEnuRPDcQ/mBjB1mn0AHm8NOCLQi7GLI2nlA0EuArhicjCkIMxlE4puxtLDLwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G0gY/3KF; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240926153353epoutp0140c5e85f65aa757286f76288649e190f~41SoUJdeQ1264712647epoutp01k
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 15:33:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240926153353epoutp0140c5e85f65aa757286f76288649e190f~41SoUJdeQ1264712647epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727364833;
	bh=sfSiZshNltBPyKbM7f8L8Q015QrPMyWEOljZ3sJgHEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0gY/3KF8nTo8NdaGCkvM8DI5uwIH8CSK9gi2PNEeEkrDNIe4TKta9kM2dJ4B/0vD
	 pdcbB4qjOJDba51gitUi3Vpk5sIHVam94uz/DMlItZe4ocNkA2OmxV7rujwMJt6bvr
	 blPtutntFlwKyzkSHfvbx9wVoHFLKieSjgM2ak8M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240926153353epcas5p4240c7cc9f029c2ea1399802f17fbb5d2~41SnovrrP1931019310epcas5p4_;
	Thu, 26 Sep 2024 15:33:53 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XDyLR6Mqyz4x9Pp; Thu, 26 Sep
	2024 15:33:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.7E.19863.FDE75F66; Fri, 27 Sep 2024 00:33:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240926144743epcas5p2047d01217bf90d6d52ec97c9b3094c82~40qUQ3poA0768307683epcas5p2s;
	Thu, 26 Sep 2024 14:47:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240926144743epsmtrp18cdee3eada09707edfebfe34e564a663~40qUPXza90487704877epsmtrp1V;
	Thu, 26 Sep 2024 14:47:43 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-7c-66f57edfe441
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.EF.19367.F0475F66; Thu, 26 Sep 2024 23:47:43 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240926144741epsmtip1a45675997190fef8c60891441d978414~40qSJO4m81883918839epsmtip1x;
	Thu, 26 Sep 2024 14:47:41 +0000 (GMT)
From: Varada Pavani <v.pavani@samsung.com>
To: krzk@kernel.org, aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
	s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: gost.dev@samsung.com, Varada Pavani <v.pavani@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] clk: samsung: Fixes PLL locktime for PLL142XX used on
 FSD platfom
Date: Thu, 26 Sep 2024 20:15:13 +0530
Message-Id: <20240926144513.71349-3-v.pavani@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240926144513.71349-1-v.pavani@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTU/d+3dc0g4sX9S0ezNvGZnFo81Z2
	i+tfnrNa3Dywk8ni/PkN7BabHl9jtfjYc4/V4vKuOWwWM87vY7K4eMrVYtHWL+wWh9+0s1r8
	u7aRxWLBxkeMFht6X7E78Hu8v9HK7rFpVSebx+Yl9R59W1YxenzeJBfAGpVtk5GamJJapJCa
	l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
	zqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PL40VsBZs5K55f
	7GdrYHzE3sXIySEhYCLRdX8ukM3FISSwh1Hi1Yt3bBDOJ0aJj629bCBVYM6ePguYjl+3uqGK
	djJKPLg3BcppZZKYfO4nK0gVm4CWxOqpy8FsEYEjTBJ/TqSC2MwCERK7Gm+CTRUGsru6X4Dd
	wSKgKnF/+2Owel4BS4lnK36xQGyTl1i94QAziM0pYCVx+vFJVpBlEgJ/2SVedn9i6mLkAHJc
	JA7OlICoF5Z4dXwL1G9SEi/729ghSpIl2j9xQ4RzJC7tXsUEYdtLHLgyhwWkhFlAU2L9Ln2I
	sKzE1FPrmCAu5pPo/f0EqpxXYsc8GFtJYueOCVC2hMTT1WvYIGwPiRdTt7NDwq2XUeJxv+gE
	RrlZCBsWMDKuYpRKLSjOTU9NNi0w1M1LLYfHWXJ+7iZGcHLUCtjBuHrDX71DjEwcjIcYJTiY
	lUR4J938mCbEm5JYWZValB9fVJqTWnyI0RQYfBOZpUST84HpOa8k3tDE0sDEzMzMxNLYzFBJ
	nPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqbiLD6nZ40GYi8/GwguL7ObNeXxj7qgMOVFHw57
	uK1s7kiaKVvw8eJchcqzE1usPPZtc0y82HPcqIr5POv1tKXsv7P2rl94Yev5Pp8bx9j/feQ7
	qHK86ZbGCffPxQo6Ey8yt9gkZpbJbLGWmZi/ddXUM3vlQkt2FVxeGdM/q7/myq9Gd4tdnbmz
	RLrTdj9Wcq2a9qwiWlSxKd7ULSzuR4+2iMAG4bM+m47KvWOsLzGVvZoYLuN2xMmr1rN14lGr
	co9OncQTkxMP7Yi5W6gVxb/n78zbRbmqVxPavTma6mXO9BulbL5XKs+8PPF0+hX3Dw+kFqz1
	VVzzeYlI7c/3G7gOVYT/VVN+PnX60/PBEUosxRmJhlrMRcWJAP/QbXMXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnC5/ydc0g/+bJCwezNvGZnFo81Z2
	i+tfnrNa3Dywk8ni/PkN7BabHl9jtfjYc4/V4vKuOWwWM87vY7K4eMrVYtHWL+wWh9+0s1r8
	u7aRxWLBxkeMFht6X7E78Hu8v9HK7rFpVSebx+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRv
	l8CV8eXxIraCzZwVzy/2szUwPmLvYuTkkBAwkfh1q5uti5GLQ0hgO6PExuaLLBAJCYmd31qZ
	IWxhiZX/nrNDFDUzSSw/Pp0VJMEmoCWxeupyVpCEiMAlJokDR56AjWUWiJJ43bqSsYuRg0NY
	IExi9XsukDCLgKrE/e2PwXp5BSwlnq34BbVMXmL1hgNgyzgFrCROPz4JViMEVPPu/ga2CYx8
	CxgZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIEh65W0A7GZev/6h1iZOJgPMQowcGsJMI7
	6ebHNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQYmd0mm
	WksFi7uiG9bNXRHnJtC96LBmuszOpLbN+sbm7U+mFAts+b6PsTnvqJRLZuUhjZ/vIm079ft5
	zz95FPkmIP/ZrSlPDV9cL/8nobzwfTVbqPiu0wEcV9y5DnBlz84ojftv/ClqbyjTzjDhL7sm
	O3wxvbRMzKGl9tLm39cLYzJ8WaY5XLLpnayptu2b4Mr7d0LeBLrk9i3fccoycw5DP4sF13pp
	aZeC/UusxQ/mGB3jCivbm1zGfqWKlWviw9Lp9xv35j38n7hTxk03dc37TwdVNh5eE9DKLPh4
	ddOHc/vemy7b179++163hqv/L6Ywvu2Yme27zbrC7+h10cPv9dX2v5V729657+RNubm6SizF
	GYmGWsxFxYkAfL4ykswCAAA=
X-CMS-MailID: 20240926144743epcas5p2047d01217bf90d6d52ec97c9b3094c82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240926144743epcas5p2047d01217bf90d6d52ec97c9b3094c82
References: <20240926144513.71349-1-v.pavani@samsung.com>
	<CGME20240926144743epcas5p2047d01217bf90d6d52ec97c9b3094c82@epcas5p2.samsung.com>
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


