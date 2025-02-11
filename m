Return-Path: <stable+bounces-114867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5CA306EC
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF551888508
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A841F12FD;
	Tue, 11 Feb 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YhvTmJCZ"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83361F1512
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265910; cv=none; b=B1PBur4MaIbmP8m2FcIrHuVYir7QAbEs7E/E0Hv0PuaJbPKjXYJHGpqQ5C4vCdRlhadew6iH2JE/hZP7Sn4LcwbJKPfny841/7SeHRwPx5gLo1G8OprpL2QsnWp5bEiVAcvnJ3/gyatWbmHJ+IG0mHmFnbrmn7cxfQbJwEA0toM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265910; c=relaxed/simple;
	bh=dficntmdLBv88Uvc4N5XgHBbu1lCoeFFI/9KziADYdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=S/eyJl+u/dOLKXAWlnP4yHzjxR25ovyFMUHlmQK+syFSk/yT56B+/wm/p4MBCqUqPeyIzPq6/g0IAgD9X6/avF7YWEYj1kdeirA//n0Du+Uq3x65R90EK5BeWOriI1HlVpqaqsKMv2FuxRxo1U/f2EP1TS2oLDA6GADdQw8aprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YhvTmJCZ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250211092504epoutp03977a2bd94ecbd5eec86f7a11edfca2b2~jHSAWZnEQ2509825098epoutp037
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:25:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250211092504epoutp03977a2bd94ecbd5eec86f7a11edfca2b2~jHSAWZnEQ2509825098epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739265904;
	bh=3HLbLMPJmzSucOlsqmhUhAS8S4GVvP2o0xrz+vP8sis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhvTmJCZk9X/L+w33ltSyBoXqsFT/Agr0R1gpmqIadl7j1+/BV1QxF/sfKzWCUuci
	 g+wtXdb8SeNghHIuaTWrdcS3JKQmLjqFS+1WHzqI+6W7FVtZIMsMoO7Qyq1eoYYpz8
	 QX9ASBsLkrpFRCF4XTdQJT1NAnV5fumxIUmfUvkM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250211092504epcas5p1d333cfd2983e630a5f1b533e8b778ea1~jHSAIrTYJ2787427874epcas5p1e;
	Tue, 11 Feb 2025 09:25:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YsbdB65Txz4x9Ps; Tue, 11 Feb
	2025 09:25:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.3E.19933.5671BA76; Tue, 11 Feb 2025 18:24:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250211092453epcas5p17c1ddadb1294b8b3effd594418e752fc~jHR1r1a_t2787427874epcas5p1J;
	Tue, 11 Feb 2025 09:24:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250211092453epsmtrp13f966022df56a2828cfc918fcaf02914~jHR1rUNhT2223822238epsmtrp1p;
	Tue, 11 Feb 2025 09:24:53 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-5f-67ab1765eb24
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.2F.18729.5671BA76; Tue, 11 Feb 2025 18:24:53 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250211092452epsmtip2cb9922b63b4a35acf0415904a889648f~jHR1JkkcS3183131831epsmtip2N;
	Tue, 11 Feb 2025 09:24:52 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: selvarasu.g@samsung.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] usb: xhci: Fix unassigned variable 'tmp_minor_revision'
 in xhci_add_in_port()
Date: Tue, 11 Feb 2025 14:53:54 +0530
Message-ID: <20250211092400.734-2-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250211092400.734-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmpm6q+Op0g/srlC2OLP/IZLFg4yNG
	ByaPvi2rGD0+b5ILYIrKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
	VXLxCdB1y8wBGq+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvX
	y0stsTI0MDAyBSpMyM64/+coW8EF9or9146wNjAeZ+ti5OSQEDCRONbYyNzFyMUhJLCbUeJt
	52RWCOcTo8TPLSdYIJxvjBIz2qcDORxgLX822UHE9zJKHOrrYgEZJSTwnVGi7zgjSA2bgKHE
	sxM2IGERAWmJWRvPMoPYzAJSEus+HQLbLCyQIrH2M0Qri4CqxJwZF1lBbF4BK4muhceZIa7T
	lFi7dw8TiM0pYC1xcvpaRogaQYmTM5+wQMyUl2jeOhvsAwmBdewS8zrmsELc6SLxuFEfYo6w
	xKvjW9ghbCmJl/1tUHayxJ5JX6DsDIlDqw5B7bWXWL3gDNgYZqAb1u/Sh1jFJ9H7+wkTxHRe
	iY42IYhqVYlTjZeh4SktcW/JNVYI20Pi+qxuaAj2MUrcPP2TaQKj/CwkH8xC8sEshG0LGJlX
	MUqmFhTnpqcWmxYY5aWWw2M1OT93EyM4iWl57WB8+OCD3iFGJg7GQ4wSHMxKIrwmC1ekC/Gm
	JFZWpRblxxeV5qQWH2I0BQbxRGYp0eR8YBrNK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5Y
	kpqdmlqQWgTTx8TBKdXAxCLQ71emmmY/9/E5RvFArsgl8bERy56W7heV8GqZtbtJKOLQf+Oc
	75HrhGIl81leHZTWn9fw0dna1pI/0DUqLTp4z2WOBQ5aNzlXKP79c/Z0SAebz+SD3wXqV4Zx
	O5z6e1Op414q39GzLV6SXfqlvpHTb73vO6R+lrks0nKd+LL+2dsjhEX7d67K12P+vDB7a4Xy
	nBVmLM9mTayr2FezIyJZ95XSjY/33lkmbrSXOblz0okVPVdzt/EY52WtfdzeU1cX+I/321vH
	KYIMqSW8355cP+FebcyaeVKseb9hMEvJ7KxY97RdubbNfdrPBMX/ldUtXfb74cGS5Rtyqtf3
	89+OrJzJzGp1W7vXW1aJpTgj0VCLuag4EQA6/8S66wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvG6q+Op0g+vzuSyOLP/IZLFg4yNG
	ByaPvi2rGD0+b5ILYIrisklJzcksSy3St0vgyrj/5yhbwQX2iv3XjrA2MB5n62Lk4JAQMJH4
	s8mui5GLQ0hgN6PEoXk9TF2MnEBxaYnXs7oYIWxhiZX/nrNDFH1llLj2pJ8VpJlNwFDi2Qkb
	kBoRoPpZG88yg9jMAlIS6z4dYgOxhQWSJGb9XAE2h0VAVWLOjIusIDavgJVE18LjzBDzNSXW
	7t0DtpdTwFri5PS1jCDjhYBqbqx1gSgXlDg58wkLxHh5ieats5knMArMQpKahSS1gJFpFaNk
	akFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcABqae5g3L7qg94hRiYOxkOMEhzMSiK8JgtX
	pAvxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpgSv3YWGi5
	4psOS8phpe6bl09pRJSG+u9XvK+YsI9jxSdVs5zeA7PnLVh9Yk3iKdvk0D0+Nf1fv3Is+/C1
	/tldH93DG7X3BV54NzHrklOccdDCH73c//8bWPsee+/f7LWqadZ67acPuX7cLFubnDdzx6c1
	F90PCOvIGRyoL3DcktKida59j8f8eQsTflzfMidlw34uO501U5OCJX5UeHzvDI6ZbK/yQDAj
	n1nOzHq/2uLAXdFNc3T27L21W/5BFE+Ib6zwfQn1ubMfhjhyFO1MfPD002XuJX5bdjVG77Fv
	6JowQai7JV5mQbbXrbjQ7MfKMkumTRGsUDklsOzxztDUJNnz5h2toTKmhzdm/o5sVWIpzkg0
	1GIuKk4EAJxDqTevAgAA
X-CMS-MailID: 20250211092453epcas5p17c1ddadb1294b8b3effd594418e752fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250211092453epcas5p17c1ddadb1294b8b3effd594418e752fc
References: <20250211092400.734-1-selvarasu.g@samsung.com>
	<CGME20250211092453epcas5p17c1ddadb1294b8b3effd594418e752fc@epcas5p1.samsung.com>

Fix the following smatch error:
drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'

Fixes: d9b0328d0b8b ("xhci: Show ZHAOXIN xHCI root hub speed correctly")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 92703efda1f7..8665893df894 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1980,7 +1980,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision, tmp_minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision = 0;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
-- 
2.17.1


