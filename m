Return-Path: <stable+bounces-211300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eImrLwR0cmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:01:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8286CD71
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2491C300889E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451F35D600;
	Thu, 22 Jan 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GcV3xM9Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mSj9TzqZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938733B94B
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108479; cv=fail; b=TOMpsIz7bQo3ZLOg7KAC+4xNAobkNfQrjcNdZ8g6b6yiA/Bos/IYi+7EqnBCzHBSsh/lQ+WTIB4xBXAcF3LAddp9oEolXvIzbmBfRyloV78QPyCURz9JCs9z5EfCAY3GbAEhjehcftN3N0m+W9fymBMFWyqr5U8JY5Z/+JtGSWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108479; c=relaxed/simple;
	bh=PrwyiDEadhuX19bVwKW3gPYj0UdamwMJzTziXtiqTf4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ptdTxVGdxuLMLmPvROR04ARyOZ9Hhpxd3+Z8k63s6ATFgRGQ8GP+9N9Ax8QOmx1Ri4+DFe/yG4ac6FOMWg+ryVs2N7uIGQdsG4pvXNcpB+27em11bj/XruzBfVdkyIsuHoZ6lEjYeBl/fYOFHU0tNgKS3E4OsSFR9Av15uX7rNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GcV3xM9Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mSj9TzqZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgss8249675
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=5x300EzoGXzQl/HX
	zt0MyPZeNBlRuvKNdTLDBonAAHU=; b=GcV3xM9ZfKMqy77qTh8EVPxdWZ43pFMC
	G3FciYF1c0pv1N2LEA/vZSNqMqiL6JiA6xdpjVwDAuwDXpqNBsEXlW5tylGt99UY
	0DQJTzKo24ok5HkABviXl/7QyDBFvY2VwA79f4Is2UqtpKwtp14T/lnE1BEta6QJ
	P9bsDsZIv1h5F8gNIizyAG8uHHRef88mDZi5ryZv2GCOnwDSc41Ipdik936oyqrm
	g45bngnXX416JdYrOUYK986nWyh+LLKyoij3ScrOp49RYbIlY047g8LA2PnjedYC
	AhGOWEaXMhqBTEpRauC62UiFY5KdmNVGYCIuKzwwKqbQMsULNZZ09g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w0afc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:00:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MHqT1x037842
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:00:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd9fh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw1+xbSGLezm53sj7+tWHBJXx6mqfYGcxRuKV1bMhh2zpZDuuctb+uZabqgIWvesrvT/bTITRFGGKN9otWyQQfekvSwyDx6wtihpm/AhrbHJkq2GEvdcT7mWNHh7SAlyjcaY5kkYfyQznb/IY/l/nXZceoLHbwbjQpcnF77d1MXe0oIwNQnfhci41W/q4h73uo6V2rISDEV6ElgKQ9/nDjiBPgY1IGRD+Kb9h1f/dnoTUie2b79rVnOK9sPmkfoS8LmbEjKxEWDsnnIZ+k2EYN4x0UdwmanXM1oym/Amk7qNZCHxTo2SmgL74+qvAoUs6xIqBirEn9B5RsfvLnTC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x300EzoGXzQl/HXzt0MyPZeNBlRuvKNdTLDBonAAHU=;
 b=o4waYbcaAbK3RcbEbSabfvQETrd0heD6wHVr53u8R9qqZvMdrAPIW3GRlaUDiKLjMUfszTbDcjEBa1BWJ5//TwW2O2mg2ygTmGo2Kx+s5aTjtINy5Yau1xKHyrbZc/PN0QMBhVgB18ai38ZQUc5juUyntMr6kcs9Z182w0xasKmSKCz90mZxeyrRUc5K3Uswg9VYvVGpK2LFuhwf0o/gkBLTsJH4yhKxl9b9OQ8e5aH9j3Pq3PZdXqYuYWkogT9iRivfEe0p94iQR7aqQac2SiOPk3Vi7BkLzs8ioQaILrgIgvYIviME4pPg9TCscwJsQMh46BUpbAzPbWJwwA/eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x300EzoGXzQl/HXzt0MyPZeNBlRuvKNdTLDBonAAHU=;
 b=mSj9TzqZogUeIGth3tnhd35fy2CqUBt1dIidU55t/YwMPuZ5nrMES/ssHK3hL7mH7p4RG77xWM+gK9u1Zkdvf0gOwo08X2t2FvE72/MJZ6LFgd1ZSF7IU7IDNwm7zyHhIrtKmgQ8fFbqgPqDQxFg5RQYIMEwKYr+wB+g/of98TY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA3PR10MB8347.namprd10.prod.outlook.com (2603:10b6:208:57d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 19:00:53 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 19:00:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 1/2] mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted merge
Date: Thu, 22 Jan 2026 19:00:21 +0000
Message-ID: <f1e305c89aaf15fc62c6160505eb6d19adf5d49b.1769108022.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0231.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA3PR10MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 395eb3eb-4902-408a-d4d5-08de59e8911c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UyH6logAAUMKewRFcg3720o0ceRA2UrnLtx2L5vvRKpkp9ZTBbWzFZNYrrAe?=
 =?us-ascii?Q?ZcbX3ZpnI2p7BM5azxNvabkFagwXbrd+GWxoVsK8VUq0l1KxelrqfFhyq/vb?=
 =?us-ascii?Q?UzB9q48Jj0xJDI6GICcZYNoOry7CNeL0dWz8yk11KZdM5Rz0lx7d3SSO//o8?=
 =?us-ascii?Q?4jR45UqxPFbSRrQg36EDOWUmJt4K14Xke27Ne/UtSz7rSSlJ579zsqOQc7Da?=
 =?us-ascii?Q?GFh3SpEKXRlMxa1ZqG4kDyHvUr1WG4dbsCQ3OlaqNHIyLDKk7vJNSt379xC1?=
 =?us-ascii?Q?GngU3QfSCKl4bUNl9XGvSrPvY8PN7TJjr3FsLeETEWXKqqCB3IR4j8n3FdVs?=
 =?us-ascii?Q?4jjxhBvWbp8Q9dVCnl5XAiPTLv4/WAcBOiw3doBt1HdZcrBqjvo35oLXP2ux?=
 =?us-ascii?Q?B9UG0Wm+WVSltxVf6xn9oqwACa11D6+K7qDvFqD3cBWZ9hkEUbmYWiLg2pqx?=
 =?us-ascii?Q?wl1HbAVO/DJNm4hIfzp5dVKjgi5iBWWnHwNBiAhQsRb9CHowL/66Ap5+yYwe?=
 =?us-ascii?Q?3HT+h4RQaBFT/UOkt2TTz/nmGudO7K8aT+th2NaU7c6VWfU+SHK4JbPN9Goc?=
 =?us-ascii?Q?hrErWm4fsE/8mkSFXOglKI0XYuLhL0X09DqRI7ZLARfYQfHs4hpLPmsYzmPl?=
 =?us-ascii?Q?9186Lc0UPUZrJ8CQOpRhrG587lfO3xRhK8KD2ajFGAzjG3mGkPFSgGedNzdO?=
 =?us-ascii?Q?BtijkDfhiQ804swQmA5qske+e4cppAFL1CtzzcISPFNxgLXeFjLQEBDvDEOc?=
 =?us-ascii?Q?Y4LJuZkzeYnCDTr8CB8X3tSmQPahlIfYqxeaDhUAvZE5UJGIhigrf5RR1hzY?=
 =?us-ascii?Q?o+v4+R1u+/bvi5Plbp9/PV6ySTJtInrYW4EmslQoxugvy1MwRsQDDY99UCiQ?=
 =?us-ascii?Q?rZX4sqSV3FsL9X7kgz9nNm/YQMR0WuSdf4cDW7wZ2F3ioU3ShlrzudUjGn40?=
 =?us-ascii?Q?1LR4YWrrkOjpIr2MIH3RJeUfr6Vkyxg6AMEejwmEFRIjvZcNkHbtiDCSJgR0?=
 =?us-ascii?Q?86w56nXA5l+EKnFObUibq09klC5QCEgdjs6KTGtwOk76mb57g6aH5hsPbwlk?=
 =?us-ascii?Q?uklqD4IH/owzI6BqpbW+9AYh3puocfnECXGE3XRs4ey4UvoNY0jLJfHNBFMY?=
 =?us-ascii?Q?T60H8so8JiUhONBI1BsiE5JVDFB1kDJnRuqB1x9/uq6+fpSJP4tsUWzJG156?=
 =?us-ascii?Q?ic1h1SWE/hYzZwrJ/h9JHp0Y3oM9Bt3lApP09f1lgPZMH7EQVpLWroLh43JF?=
 =?us-ascii?Q?S2J+RQtZGSHSVAkgdGUEzyS2ggfwrsIuFoV9f8rAmeFKnz0ICpNQwZSuQF3h?=
 =?us-ascii?Q?BuzKOLggIYatOsb7Hhe49iyn7z5Khxg3DYRY46gzXPwK3CAP/1BrZDmbMHUK?=
 =?us-ascii?Q?m9DiMZfTE6627nN96HpA6mFWwX5EROQ4wcYlITdP5WtZFNEbB82Xp9s+vgjG?=
 =?us-ascii?Q?m6mJxnELCdXFMcg0VoHkL947Z2ybIyOmwXv4qDzOZ1MKfsVt0mxrDIdjTmWw?=
 =?us-ascii?Q?trU7QIbM8ETRMKpUTNBn0tVHxBicNgXeTYShPzMvgp9zrEthO5rwhr5MiciL?=
 =?us-ascii?Q?Rp3LE50VSeISDza5uRQY99/rRMJZNfOF8v7IdT/z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xBo7sQ2QJxum75ajUaZJwwHgN1kUA2ZihzNoJqjmxHNwPxO3Hmx4qOLT8jqp?=
 =?us-ascii?Q?/kZ7jVExEnZ+lTEmj0LTdJLMyJF+9RAYBp3SVGfg1K0FlR3gJbDNnDHdGc54?=
 =?us-ascii?Q?LqyoDYA+SmWzvpJehIG3nwbJinLrDR1oaie2ZaUFRvEugJU6tm1AaUbCixwj?=
 =?us-ascii?Q?nkFIMRRhvZMosW2vkg9KiMMjWo7SsuhlLyChhj53PGBb3Q5W8kCphFywkyzT?=
 =?us-ascii?Q?5ZTBPaGaKW4jun05l/CcOfwQCi70xqDDqtR6lLVBz+6G85AXyqdJIn5G0V4h?=
 =?us-ascii?Q?eZBdhR1vxL2CGT8c+OtglFg6ormx0csklP5YKjuCyR3VENfzNDoLX+Z0UbIF?=
 =?us-ascii?Q?4WjTmmwOHywkWw8TKvfUmMakOqOWv4D9NDbvxyuvt07QvMkwkRANAcDLv1SC?=
 =?us-ascii?Q?9dHMlxO5yRM7Je9yIKrgfKWGBMuOVgGsBhwCyh0cPizbX0HE5/ZvWiI0RX25?=
 =?us-ascii?Q?80P00/DEuC77aYotUTknt/V0GzBvzLeF2jY+Pz6ehFJC914c4OwAExRuc7Yk?=
 =?us-ascii?Q?BM238AgpC6ogFhEYnOrivIaEO79QaIpvrkHfgnC+xd3q+E+tPo6/zdRSzNqX?=
 =?us-ascii?Q?19ZhABkCyQ4jXrJ11yABg4VK9iaqI/ZXYR2hgcl37o61qMfYRw0EDH6CBrQb?=
 =?us-ascii?Q?Sb1y3YwTvN1opavlquktFDYUaOvKm2tdTtzR5B9l6dMBtyAEBnJVdFeZPw1e?=
 =?us-ascii?Q?jFEO1rC46R+5nWgBUGhxVBHP28UujdmmIKq+D+Wh2TNY6Om7go99R1X6/HFv?=
 =?us-ascii?Q?VBOwCgv7GP6hMo+3aOOxU+iUE0YzFnCYOu53gS1XXUfwga2/YcIjwjPiVrz/?=
 =?us-ascii?Q?lMit24kk7XZAVS9ybxc7kki6EU/uQqQE4VXyQ2Gy5l6N2er86T7EAKi+aa8h?=
 =?us-ascii?Q?V+GQ3y/7b62yG+r2Sot0sDJX8zNSPDfAQA22BKNMwGG9THUOzYlL6NaVKaDq?=
 =?us-ascii?Q?o83mncC80VsA0GIzxe7wZlSUraBhNjfahL3PLQKz67azXgG+y1IOjMwMx8iw?=
 =?us-ascii?Q?FLZR2QFnFObDYMVnmN4zXx4iV6FOAJ/ZgNlde3bX/pDBUdffjnJoOVgjFYLE?=
 =?us-ascii?Q?gieliL6BvgKwVjoG4LOdewLvr2fbSFCqYaxGgp2CUmEVZVn3SfF1v7uWL3Xx?=
 =?us-ascii?Q?M/15MZ5JO4c1hTy0+XhozsVm4wKGon52eTU8v4vChG7zY3KhcsFmlDkBJx3p?=
 =?us-ascii?Q?JQz+uqrK2ajTyD7n32eF936a+1/c70ZqtWVjGA5oDqg2BoYb/GOUDkKEglMn?=
 =?us-ascii?Q?9uW7NpyesftpYrbdg9oF6cGtr2Vtlk3PQdzrIB01jW/f08KHRJaeVYLuVywI?=
 =?us-ascii?Q?WvqVSTs1X94H6eZHzTvoSZB4NcZkiGVM3+ECaB1zkW+jkggcqftPPsE0Wp+e?=
 =?us-ascii?Q?hChUa+F7CAGCJQxB4XkdIIUV1HQXF5B+hIvtN7HNhS077vP6b+QdNN2s1XWR?=
 =?us-ascii?Q?VxPUuyCW/1YqGMojOsECBwewspbn1Vgbl0iYoQSLgZf6rFd0IUQEcdg+Z8Uf?=
 =?us-ascii?Q?J3faXNdm1hozeKv4vfcCRqxIjbYjidyfQ7ZcW+cY1YKGhSDITarC1j5gtG/n?=
 =?us-ascii?Q?7+oIWSwYsxShoCS0N3qP5DTDmQ32vCNUb7Xm9nOMYxZM+SX3L8rsoDnbn6d6?=
 =?us-ascii?Q?zV0l37Zyc/HldjgBYoTbrHCaefhBPkPrGiSAc+QtwRARoSUKcBhDuF+py1q1?=
 =?us-ascii?Q?Ax6DwmpPKWGAyWR0jkqi8eCS7ScY7rEuBODJywUpQZEyPepBHrBaDTvISuhq?=
 =?us-ascii?Q?b364NrTvTiKcm+GZ2c8mtN5ZhU5WK88=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BL2zscsQvtD7xsVoEH+PlJKtv/nTSyd6B3ITghaqZv9Ujq9FkPLFgOdVASpfh/ucEBNXnTtZeN34fak7yUxvAwl+EVwlmrF8G64tLRR2ppJO8S/1HA878B5MkotWJdk5MRjgG68tNZWGrFtUdONzaiBxZVhdf+C8m4YD0mDVcLxYXnFALlSO61+G0b3rYfVSF+qxHWQDWPYA2teSFoCL5vtRwnjaEbBkhP75JXONa68paoiaXprNERWC4jw9ZuwSe/hqG9ZcZHjIjsIkq6IrZR5bf392aYLcBWIL7LzCtjiIup1ZvzGZLCvY4seLh1Ao6fAzUxnH19yb1BS4Y5dNfX3Xll3vj7B73U7x8/K8o+EUhrAU0yrNr25A8PDJ0RSWmO+MWai7pTlDcXcEMOs0v7dcTL+g9qNNqtJEwtCxGvoQn+vW9IjJBCNNqZuDxvI24NRrlCBIEVx8dSMaCerlsEScnXyeGHijZX9w//xDaQlvaOo14vqHcCJuvhmFlPAL01kv/vbcrJ7ZdV5dTlw4yu/997vgold/q4xTVudYoeVTsyG5cWEBAMW5gUYibIgqbxjtr8iWgj4hv2a3DMAn88bth8EMtzbLE4bTrRdtURA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395eb3eb-4902-408a-d4d5-08de59e8911c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 19:00:53.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf7GBHm6c+bDvxWfa7N2Op38TkVmXbaKL5Cn4bGO3dQO1VUSNVpFPf99WVEC7whDX+t8bQ81G0YtePBecVbOQWlk789ThgCHQkE5KHTzw5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220145
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=697273eb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8
 a=fwyzoN0nAAAA:8 a=Z4Rwk6OoAAAA:8 a=DpmDNo7s59ZT7HOtwsIA:9
 a=cQPPKAXgyycSBL8etih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Sc3RvPAMVtkGz6dGeUiH:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: HFiSs1Hgqi7HtVw6x0YEFWVrThtiys7F
X-Proofpoint-ORIG-GUID: HFiSs1Hgqi7HtVw6x0YEFWVrThtiys7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0NiBTYWx0ZWRfX8n8Mw9boXaz6
 umd6L7snkccRzjMw3cHxg38k3wKBTXgnXbBs9u0FkxxGKua9hGmOYjGTCLUm3wkk3tCmUUjolly
 I9EsJ13lPrINxjDaOvMTqNLc0D7LIQulAbWjCUCSgmRC9iJS9TVz6Gb1e2/GrVeV7DAze0hIFmV
 RDlTPiSvatTHGmFNIcPR/9Jj/lk+rjXHDxZrI3Bglpp05PWDPd8JjIHRbKJTum1myMK0KrB69Od
 cAAjBG82FZ5Xd59QEcwXEqi2XwC1fjpP+zDE2UjMbkz4PIgC2qMkwSE+49M+EqJOUzjOdLkOiru
 htvFftfEUkCN8VB+Fn3WlpjBad3GWBJfYf0dKYjdHZHgygp3mbqPA2r8pqdZ33qd4CAqMRZJtCe
 PMnC9XXMLU6TYlCeCcdOZbNm6nav5SHfA+1nTq6mX4GXMVH86BliCQb1RkjjUoFyhs4c/8VBw6L
 fily0VTzIDeUpR7xIOA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211300-lists,stable=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,appspotmail.com:email,surriel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,suse.de:email,linux-foundation.org:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1F8286CD71
X-Rspamd-Action: no action

[ upstream commit 61f67c230a5e7c741c352349ea80147fbe65bfae ]

Patch series "mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted
merge", v2.

Commit 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA
merges") introduced the ability to merge previously unavailable VMA merge
scenarios.

However, it is handling merges incorrectly when it comes to mremap() of a
faulted VMA adjacent to an unfaulted VMA.  The issues arise in three
cases:

1. Previous VMA unfaulted:

              copied -----|
                          v
	|-----------|.............|
	| unfaulted |(faulted VMA)|
	|-----------|.............|
	     prev

2. Next VMA unfaulted:

              copied -----|
                          v
	            |.............|-----------|
	            |(faulted VMA)| unfaulted |
                    |.............|-----------|
		                      next

3. Both adjacent VMAs unfaulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)| unfaulted |
	|-----------|.............|-----------|
	     prev                      next

This series fixes each of these cases, and introduces self tests to assert
that the issues are corrected.

I also test a further case which was already handled, to assert that my
changes continues to correctly handle it:

4. prev unfaulted, next faulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)|  faulted  |
	|-----------|.............|-----------|
	     prev                      next

This bug was discovered via a syzbot report, linked to in the first patch
in the series, I confirmed that this series fixes the bug.

I also discovered that we are failing to check that the faulted VMA was
not forked when merging a copied VMA in cases 1-3 above, an issue this
series also addresses.

I also added self tests to assert that this is resolved (and confirmed
that the tests failed prior to this).

I also cleaned up vma_expand() as part of this work, renamed
vma_had_uncowed_parents() to vma_is_fork_child() as the previous name was
unduly confusing, and simplified the comments around this function.

This patch (of 4):

Commit 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA
merges") introduced the ability to merge previously unavailable VMA merge
scenarios.

The key piece of logic introduced was the ability to merge a faulted VMA
immediately next to an unfaulted VMA, which relies upon dup_anon_vma() to
correctly handle anon_vma state.

In the case of the merge of an existing VMA (that is changing properties
of a VMA and then merging if those properties are shared by adjacent
VMAs), dup_anon_vma() is invoked correctly.

However in the case of the merge of a new VMA, a corner case peculiar to
mremap() was missed.

The issue is that vma_expand() only performs dup_anon_vma() if the target
(the VMA that will ultimately become the merged VMA): is not the next VMA,
i.e.  the one that appears after the range in which the new VMA is to be
established.

A key insight here is that in all other cases other than mremap(), a new
VMA merge either expands an existing VMA, meaning that the target VMA will
be that VMA, or would have anon_vma be NULL.

Specifically:

* __mmap_region() - no anon_vma in place, initial mapping.
* do_brk_flags() - expanding an existing VMA.
* vma_merge_extend() - expanding an existing VMA.
* relocate_vma_down() - no anon_vma in place, initial mapping.

In addition, we are in the unique situation of needing to duplicate
anon_vma state from a VMA that is neither the previous or next VMA being
merged with.

dup_anon_vma() deals exclusively with the target=unfaulted, src=faulted
case.  This leaves four possibilities, in each case where the copied VMA
is faulted:

1. Previous VMA unfaulted:

              copied -----|
                          v
	|-----------|.............|
	| unfaulted |(faulted VMA)|
	|-----------|.............|
	     prev

target = prev, expand prev to cover.

2. Next VMA unfaulted:

              copied -----|
                          v
	            |.............|-----------|
	            |(faulted VMA)| unfaulted |
                    |.............|-----------|
		                      next

target = next, expand next to cover.

3. Both adjacent VMAs unfaulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)| unfaulted |
	|-----------|.............|-----------|
	     prev                      next

target = prev, expand prev to cover.

4. prev unfaulted, next faulted:

              copied -----|
                          v
	|-----------|.............|-----------|
	| unfaulted |(faulted VMA)|  faulted  |
	|-----------|.............|-----------|
	     prev                      next

target = prev, expand prev to cover.  Essentially equivalent to 3, but
with additional requirement that next's anon_vma is the same as the copied
VMA's.  This is covered by the existing logic.

To account for this very explicitly, we introduce
vma_merge_copied_range(), which sets a newly introduced vmg->copied_from
field, then invokes vma_merge_new_range() which handles the rest of the
logic.

We then update the key vma_expand() function to clean up the logic and
make what's going on clearer, making the 'remove next' case less special,
before invoking dup_anon_vma() unconditionally should we be copying from a
VMA.

Note that in case 3, the if (remove_next) ...  branch will be a no-op, as
next=src in this instance and src is unfaulted.

In case 4, it won't be, but since in this instance next=src and it is
faulted, this will have required tgt=faulted, src=faulted to be
compatible, meaning that next->anon_vma == vmg->copied_from->anon_vma, and
thus a single dup_anon_vma() of next suffices to copy anon_vma state for
the copied-from VMA also.

If we are copying from a VMA in a successful merge we must _always_
propagate anon_vma state.

This issue can be observed most directly by invoked mremap() to move
around a VMA and cause this kind of merge with the MREMAP_DONTUNMAP flag
specified.

This will result in unlink_anon_vmas() being called after failing to
duplicate anon_vma state to the target VMA, which results in the anon_vma
itself being freed with folios still possessing dangling pointers to the
anon_vma and thus a use-after-free bug.

This bug was discovered via a syzbot report, which this patch resolves.

We further make a change to update the mergeable anon_vma check to assert
the copied-from anon_vma did not have CoW parents, as otherwise
dup_anon_vma() might incorrectly propagate CoW ancestors from the next VMA
in case 4 despite the anon_vma's being identical for both VMAs.

Link: https://lkml.kernel.org/r/cover.1767638272.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/b7930ad2b1503a657e29fe928eb33061d7eadf5b.1767638272.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA merges")
Reported-by: syzbot+b165fc2e11771c66d8ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/694a2745.050a0220.19928e.0017.GAE@google.com/
Reported-by: syzbot+5272541ccbbb14e2ec30@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/694e3dc6.050a0220.35954c.0066.GAE@google.com/
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ updated to account for lack of sticky VMA flags + built, tested confirmed working ]
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 71 ++++++++++++++++++++++++++++++++++++++++++--------------
 mm/vma.h |  3 +++
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index abe0da33c844..ca0425518d02 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -835,6 +835,8 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	VM_WARN_ON_VMG(middle &&
 		       !(vma_iter_addr(vmg->vmi) >= middle->vm_start &&
 			 vma_iter_addr(vmg->vmi) < middle->vm_end), vmg);
+	/* An existing merge can never be used by the mremap() logic. */
+	VM_WARN_ON_VMG(vmg->copied_from, vmg);
 
 	vmg->state = VMA_MERGE_NOMERGE;
 
@@ -1101,6 +1103,33 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	return NULL;
 }
 
+/*
+ * vma_merge_copied_range - Attempt to merge a VMA that is being copied by
+ * mremap()
+ *
+ * @vmg: Describes the VMA we are adding, in the copied-to range @vmg->start to
+ *       @vmg->end (exclusive), which we try to merge with any adjacent VMAs if
+ *       possible.
+ *
+ * vmg->prev, next, start, end, pgoff should all be relative to the COPIED TO
+ * range, i.e. the target range for the VMA.
+ *
+ * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
+ *          to the VMA we expanded.
+ *
+ * ASSUMPTIONS: Same as vma_merge_new_range(), except vmg->middle must contain
+ *              the copied-from VMA.
+ */
+static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vmg)
+{
+	/* We must have a copied-from VMA. */
+	VM_WARN_ON_VMG(!vmg->middle, vmg);
+
+	vmg->copied_from = vmg->middle;
+	vmg->middle = NULL;
+	return vma_merge_new_range(vmg);
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -1123,38 +1152,45 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	int ret = 0;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
 	mmap_assert_write_locked(vmg->mm);
-
 	vma_start_write(target);
-	if (next && (target != next) && (vmg->end == next->vm_end)) {
-		int ret;
 
+	if (next && target != next && vmg->end == next->vm_end)
 		remove_next = true;
-		/* This should already have been checked by this point. */
-		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
-		vma_start_write(next);
-		/*
-		 * In this case we don't report OOM, so vmg->give_up_on_mm is
-		 * safe.
-		 */
-		ret = dup_anon_vma(target, next, &anon_dup);
-		if (ret)
-			return ret;
-	}
 
+	/* We must have a target. */
+	VM_WARN_ON_VMG(!target, vmg);
+	/* This should have already been checked by this point. */
+	VM_WARN_ON_VMG(remove_next && !can_merge_remove_vma(next), vmg);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON_VMG(next && !remove_next &&
 		       next != target && vmg->end > next->vm_start, vmg);
-	/* Only handles expanding */
+	/* Only handles expanding. */
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
+	/*
+	 * If we are removing the next VMA or copying from a VMA
+	 * (e.g. mremap()'ing), we must propagate anon_vma state.
+	 *
+	 * Note that, by convention, callers ignore OOM for this case, so
+	 * we don't need to account for vmg->give_up_on_mm here.
+	 */
 	if (remove_next)
-		vmg->__remove_next = true;
+		ret = dup_anon_vma(target, next, &anon_dup);
+	if (!ret && vmg->copied_from)
+		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+	if (ret)
+		return ret;
 
+	if (remove_next) {
+		vma_start_write(next);
+		vmg->__remove_next = true;
+	}
 	if (commit_merge(vmg))
 		goto nomem;
 
@@ -1837,10 +1873,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	vmg.middle = NULL; /* New VMA range. */
 	vmg.pgoff = pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
-	new_vma = vma_merge_new_range(&vmg);
+	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
 		/*
diff --git a/mm/vma.h b/mm/vma.h
index 9183fe549009..d73e1b324bfd 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -106,6 +106,9 @@ struct vma_merge_struct {
 	struct anon_vma_name *anon_name;
 	enum vma_merge_state state;
 
+	/* If copied from (i.e. mremap()'d) the VMA from which we are copying. */
+	struct vm_area_struct *copied_from;
+
 	/* Flags which callers can use to modify merge behaviour: */
 
 	/*
-- 
2.52.0


