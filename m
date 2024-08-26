Return-Path: <stable+bounces-70150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C095ECEC
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43F6B2117F
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF751422BF;
	Mon, 26 Aug 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QpkolqLj"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2A13CA9C
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663853; cv=none; b=OFEf7N6z6XmGB7M8Dt722qWiBcxiyxad2I8caR5JK7tgllULXyXz9Uh5Xjn3ZpS5eLDsgJFdowpiu2fEw/D8Q9Yf6DplbP8RyG7Fk9p6t7l4UxvUyO+RwUfBEXmRbvuG7PX65iUkgguPfLRqp9VQyaRzuHWsGT9njOzdq9RuLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663853; c=relaxed/simple;
	bh=asCoAs1B6TeLweLBRFsG8LwcXo9p7phRfIJfMNeUiXo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=JoOLCWURoZPY+MRuMyEJnYNCxGrPGc0PTkXnPeV4TQHfgCBTptO4JftK10IFIX7hGeY90QJ0kdSuSM0KwvwVom0B5z1losaX97pCdAAPKTGQBB8+uF3ZOIp75O34QjjGAoyuIdU7zLVZXm75KQnj6sZZXRue4olGUkByUh7gp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QpkolqLj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240826091728epoutp0258d604937d6cdf8c1434df99d363d237~vPKHcC9Ha1633716337epoutp02a
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 09:17:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240826091728epoutp0258d604937d6cdf8c1434df99d363d237~vPKHcC9Ha1633716337epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724663848;
	bh=HsgEOK+TFX6wt+HKoeqr6ur6faQDmraUby/Snfioctw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QpkolqLjozngGmGWciDzQztOWVBRom7ZVrdD7WJ5H5tbY+6T8CgXOkoLWUIuZgCoN
	 hH5ez+CzqY6aKs0rn/l51RLYfRzG5MDoqjVKjt8QRJcVPY3dkGu0hD8Wn3d4ZZ+hNR
	 v3K6NE6mgboVuapX/MwNmnnWQB/qQ2+v0t4T4lD4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240826091727epcas1p34d9645597636831f03915db661976a64~vPKGpftId2876028760epcas1p3m;
	Mon, 26 Aug 2024 09:17:27 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WslSQ6zB6z4x9Pr; Mon, 26 Aug
	2024 09:17:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.C1.09623.6284CC66; Mon, 26 Aug 2024 18:17:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a~vPKFn-Ssp2463524635epcas1p19;
	Mon, 26 Aug 2024 09:17:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240826091726epsmtrp1b73879ec5cd022d94fd160713ed8d77b~vPKFnG9RH2107921079epsmtrp1S;
	Mon, 26 Aug 2024 09:17:26 +0000 (GMT)
X-AuditID: b6c32a36-79485a8000002597-b0-66cc4826b65e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.05.08964.6284CC66; Mon, 26 Aug 2024 18:17:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240826091725epsmtip15e4c1642950997823fe35a09919eb6fe~vPKFXRirS0411604116epsmtip1L;
	Mon, 26 Aug 2024 09:17:25 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com, quic_asutoshd@quicinc.com,
	adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mmc : fix for check cqe halt.
Date: Mon, 26 Aug 2024 18:17:03 +0900
Message-Id: <20240826091703.14631-1-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmga6ax5k0g/O3DSxOPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	tTMnWC0WbHzEaHF8bbjF5kvfWBwEPHbOusvusXjPSyaPO9f2sHlM3FPn0bdlFaPH501yAWxR
	2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
	5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
	3k6fwFzwiqti7vWrTA2MPzm6GDk5JARMJN5c/sUEYgsJ7GCUWHA4tIuRC8j+xCix69BERgjn
	G6PE3JOfWWE6el+eY4JI7GWUuLjiCAuE85lR4lXHMkaQKjYBPYlX7YfZQBIiAosYJfb+uMMM
	4jAL/GSUeH/9IDtIlbCAkcSp9ffBOlgEVCUu7bjNAmLzCthI/OneyQKxT15i9YYDzBD2X3aJ
	k+9Vuhg5gGwXiQ3rQyHCwhKvjm9hh7ClJF72t0HZxRILN04Cu05CoIVR4vryP4wQCXuJ5tZm
	NpA5zAKaEut36YOEmQX4JN597WGFGM8r0dEmBFGtKnFqw1aoTmmJ680N0JDwkLg5rQcadrES
	q54dZZ7AKDMLYegCRsZVjGKpBcW56anFhgVG8JhJzs/dxAhOflpmOxgnvf2gd4iRiYPxEKME
	B7OSCK/c5ZNpQrwpiZVVqUX58UWlOanFhxhNgUE0kVlKNDkfmH7zSuINTSwNTMyMTCyMLY3N
	lMR5z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpgWu7vumRryUGbvAzpvI6kjv2ndsfdvrNP0eeJ
	RnrfouNa+YyCkvusQnflafI49v67Z+h6WDKr8LxH/Pljnumfr0dbcL5KmcroU7izxNfV8D/L
	opeuQXO4Vnvv2ue02/7vij/3PAQnH776/MGtq3Gyrx/6nzThXNDUIi+obH1lW2hyAfv2JVMc
	CmdUR3KfntBbusF7T1SifcjDhUZmUx+Jhn0uOd584uvc+o6DZ6O9fxccT1v7acbNj2+f7rro
	u1/LTod996LNAknhf3dPV026r1gV6HQgVXTV6gqGUxJ2oieVlrnOl0rasdTv4B/1hY3f1JgM
	dBc8C9y3d6Zu45mkW7zvVey0qmQ3FTl7hJpNUGIpzkg01GIuKk4EACuhMJoHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK6ax5k0g+dv2SxOPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	tTMnWC0WbHzEaHF8bbjF5kvfWBwEPHbOusvusXjPSyaPO9f2sHlM3FPn0bdlFaPH501yAWxR
	XDYpqTmZZalF+nYJXBlvp09gLnjFVTH3+lWmBsafHF2MnBwSAiYSvS/PMXUxcnEICexmlDj8
	6iIjREJa4vGBl0A2B5AtLHH4cDFEzUdGiW9n5jGD1LAJ6Em8aj/MBpIQEVjBKDFz+VRmEIdZ
	oJVJ4tzWNiaQKmEBI4lT6++DTWURUJW4tOM2C4jNK2Aj8ad7JwvENnmJ1RsOME9g5FnAyLCK
	UTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4ULU0dzBuX/VB7xAjEwfjIUYJDmYlEV65
	yyfThHhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAdZhA1
	cY/xbc65bJtrPL8rcc06/dXqFw/cU7Ja/NaJJ+LfsyKT6BOuN3K2Vq12kuCtnfTO6pf6ojsn
	re5e7FAzn9CUfSrZ+oHksmwtjVtWJxZoHi8/925nQTerfcV17qun/5aXBP06sOV28AEBHrWQ
	WV8Wl1dtO8x+WOD3kuiFvfcS5qfwqcr/ir4+38FYyI85demmh/dkjx9c8G/2xF3lh9rvKV37
	e/ns+279hSf+fH22g6XnyIdn7XJCpxjbLkxkX7zivfufc3HWSaaL/G0P3lioudFt8dF9Fyrj
	w/9+D2P7ue3a2uMh1g8vr8udqV/ByRC8bl7WtXPMzWtuXrOyUTrn72lwJeTQ2/KE5V5HJZRY
	ijMSDbWYi4oTAUSiL0DDAgAA
X-CMS-MailID: 20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a
References: <CGME20240826091726epcas1p19797d2dd890feef6f9c4b83e9156341a@epcas1p1.samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&. Therefore, code to
check whether cqe is in halt state is modified to cqhci_halted, which has
already been implemented.

Fixes: 0653300224a6 ("mmc: cqhci: rename cqhci.c to cqhci-core.c")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
---
 drivers/mmc/host/cqhci-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index c14d7251d0bb..3d5bcb92c78e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 
-	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
+	if (cqhci_halted(cq_host))
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 
 	mmc->cqe_on = true;
@@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_halted(cq_host)) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
-- 
2.17.1


