Return-Path: <stable+bounces-240067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEohK94p52mo4wEAu9opvQ
	(envelope-from <stable+bounces-240067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:40:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB3E437BC5
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A40B3062262
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF09F391512;
	Tue, 21 Apr 2026 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IytWxjgV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579E38A706;
	Tue, 21 Apr 2026 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756935; cv=fail; b=Nhpwk6jo7+BYuMR7aHxa3tSqpG1wOHaNeEL28f3R5zrFhTG7j9cn/Xjp97XYS8hkG4dMmmVR6IL+hBSXPDeuwo5soe1O6xhHrupg3u6G7SSNTJuEZ1J4niOpWc6mx4aAr5kZGSccbcnMCEvZIc7LJfp8UzqYCbUYl0ke6lHY+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756935; c=relaxed/simple;
	bh=vrJgq2ubLedxXwnejb8xqvFNi+iBVzJof5NUXTpqQ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrcdaWOcBmHtBuAY7l4TmjiloHePWnWj7G/SoN/AP1mCkzLvBOajgAB1zrjPH4gzV32dJFY2+9Ro6y0wRn/ENU8vbbICCd+r/clQU5oUe7MIne2RzH0UfCeqqqDLo7sZhi7bq8y9DzugH/IxC5JZxa463Yxd2TxoLQauuQxuU7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IytWxjgV; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L517XA383621;
	Tue, 21 Apr 2026 07:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=edruRNhOFxoTqLpoRttq5X20SXLnytn48rYp1IqcNcs=; b=
	IytWxjgVsJQbDcB4kEcA4bNxTQLPiAoL8YBOk/BjeOGUJ8ZQEHVTIoWDZzarj7YR
	wvuQNmBUlAD+OksRMGb8dtfQyHKxJMZdeAJ7DU6nNQ7jny6tBNBeRlxA3+fHOQgz
	rInYoNSBWxFlpKrMO7hMtZFLh7ijCbk7XW4ZCvXYsgJMLBRVg42iRZMYBavHUOPg
	aEtyiKm/VJ9dnSq8G+3f7YQqMto9JL5d/IAWjtwHko24aw1dTSn4c54SASt2bfWQ
	05t0zTRCn0ySC8uEqRVstjboaae5rf1PvZm6VQX5ULQ1XM2KHX611UsAbxqDVSXb
	xnwwGY8EmfkodN6BBdClvg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dky5yb2w8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 07:35:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6TKjxpQU5nu+bM17pmeNhTue5lE2+/OlzDAKiR+2sizhCB6GUvK/TEWHtIyZkC9WAddrOi4OSV3YV2ptnmuac3+hjLpytjH+1jwm+8SP+JQPB+Mjix2imbrhrY0hZ5OSdQs/odxq8BJ0sKiVkVEjk/MIZkT6HX3QTu101fzUOvOHNwrJJ0L7DPMM6kwrQhLqoScD029/gaI/DoVcWz4yeadrJ+U/563+Uggl7urB2oPbxgOei14ZaMaOotgNtupdg79LxE5xklVuXUHTnTuIswVTRWN/fqvnAxJWv4+5WSSpOIcy21FY8ALHY2N2KxefU0kDQUOnTK3HzMtIre7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edruRNhOFxoTqLpoRttq5X20SXLnytn48rYp1IqcNcs=;
 b=JWHjZ9uzt6AgrvU9Jc4Lne/6yLXxfKPD5i1qlQ8xDuwdWn8+1APipM8AGZcKuTb9G7xwhhdC+jQUoSGuKaxiSuT0yrfuSgBiPC5/zAmXyVcMeF6llgiG821/aiMFKDL9Va6+N7f8VvYPXmLVXrKxFEWBlT9p6CX1Fnlkf6iHUqV/OnRZwVowXrZf/zinThkD1DyB7Ee7ycCBjaNwRbBImdp/O0QmBmwKIdwWbTO4fEut2L2vSfiiQA/2mIsURGHNK4aZ44Ucj1HAV382PpUT94ex4OaymkBZFp4QoA+igjLRUQbDY+yEskgpBYj6LI7bLLoIkla7dTmMFoE4ChkXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:35:05 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:35:05 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v13 2/2] PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock in remove_store
Date: Tue, 21 Apr 2026 10:34:21 +0300
Message-ID: <4625becce42253d53a615efccc33c7d91ccf5312.1776756380.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776756380.git.ionut.nechita@windriver.com>
References: <cover.1776756380.git.ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:803:14::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: b322aa95-719b-4548-91a6-08de9f788163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|52116014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	v92Vm8SJDHUJCHl2o8R+XELUtFvIPNxP8Ya7vISlMWPHJDPun5Y4PV05UsYilsdqvx5bZgkHgH3RRs/Z+NHOcmtHmvw7yX+vAatnjhJ+iUQGlrnw0+uApoxVpMXPZ8i6CrDehT/z6WwTaf+/OBHjK8OnYr5tSxvXYwJYaaTDgpcwDGmH+gyEBHEruZOKbbE8UYx6sQXHcgzN0/2djfwN2QxVz2VEsT7yrFBOpWPyTQCzBzqgda8+JtEDIfQs/bE8Z0Zi82PqYNwpKL7bU5lUivmFyCb1F5bjZydYL+3f6WtLQymXjIZlmzyyi3ZXpYm/i3aI9i1YpzmpBr1zcpE9cSa+hAJ+k87AlGRnSsenZl36qw3DcjpsRHwXe5kPgTFw0eg5DtVlMFJ8ON28q3sjcSap2l2p2c67DHKmGJujpYfIVtPDEhPMUDh7QGIvMyeqtCnhL46J+HQK3k6bXE1Q6m5nOJqIeaSyvoZGh3cqsrkkfTFdCWUSI3Addyb7PrVBsRRhNhQGNDt1U8F9dWRAkbibQJF8cPBzcjkZlKYx4irflNpC4h5Dq+ygOHMJCUzimOjJBDA5M6eiMIHq8siXN6cO9JYphRxGoeSuLe57wiSHZWeiCt9F3bJ0XvJwhiUoyN3z4uXOPEgLzFzEmyeCCjiraM8w3c84vn7ZlGsENIWdeLf5t+teC0sWE9HpKi5D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIsFhG+03X+RkczgDjwIpjmpZcmuMYgdaARTLFZi7FKjAwde6w2Bs18TqNrj?=
 =?us-ascii?Q?ctfJbWw2f7/D+t5vw5pbCo0p1YfIOqKEhU/uBQr8/ozkz53ltYYJbgNTGUts?=
 =?us-ascii?Q?7Vq5VY54ay30+pC2X3s1In0rlVWNyi7udoqXps1M5vOAgunUf3beaguQ2s/s?=
 =?us-ascii?Q?adGqRuQgS0Vg5pvjHCNvAskGM2yJEzlbclI1ndbqVY814o62ZDgCiGqFZh4I?=
 =?us-ascii?Q?7jZJZntlWzaat9wVajWkKhlYbhU1EYdg+RjVk7IQccveIPythMlK0lI16AIW?=
 =?us-ascii?Q?asfZQjwqdiTcqb7Sjh94Q+yM1/DR6GTp+htPRtAypOAX2FSV0c7iR4NMlWFi?=
 =?us-ascii?Q?csIwThPnfnWNupcl+hmwVz/V+nqlSYpbCy3GyMZTqeNbjDRNWLlbiS2lvpbR?=
 =?us-ascii?Q?moSYcmwZo+jAsIuKlm1zhprL22qsaRaZLRiTlsPamSHcgNCxEu/g0Q7gqdH7?=
 =?us-ascii?Q?aMSqgCytP2WWNHPsb6sOKAn0t3UeMikNO/9ksiy5cC2esVLwBzsSjX+Cfh5g?=
 =?us-ascii?Q?T5t150qeIuDJIoInmYVj0BdJQyfvv+551alKiDRxmbnntbfZMU8EE4AaGKIV?=
 =?us-ascii?Q?Js0AbT7WFGH+Ywv96K8CuE/4UBWc+gKwx7djAMojFW3pufwh8KHmQsm30Cxu?=
 =?us-ascii?Q?07tgHFh4m6F/tebdsGt96KRiGtDYV/3qssGQPd7gB6m+f8zXZX2FyKco6Ss+?=
 =?us-ascii?Q?S4kaq4wYm78Rfxr+mPIrIYMkdksNB5Z3X3tDGiUQX+3wAMHX84zx7JNb76Gm?=
 =?us-ascii?Q?x63vFZ4mPCb4t7dNO7voCQuIks26yfB8PVm0MgEiUw8vMhTCLl+3P6ywMBIh?=
 =?us-ascii?Q?lHCizYeBQpJAbXI7obXQ1Nd7ohg1q7rLQB8dQ8cHVK3j5MY4QFqUQHBj5c8l?=
 =?us-ascii?Q?z51vUvv/lilAeQOlRfNlZB83Dsk5luxNLPsQpcEUa+CSJWyuvoNuJbK9Wiv2?=
 =?us-ascii?Q?uo1sNC4arbVbIB2hMG7F1pvFsF2fWOMf0Fv5saYrY4My/7w9Ij6IiF2iZ97W?=
 =?us-ascii?Q?xz5igjddReY4MyZUTJk/EJjVbLaGCcxxH8XNuA+/xCDezTBBjqPR9eThyj1M?=
 =?us-ascii?Q?oOxDg3GTxsmk+XXtWrRTpk72rGeJ1eYkOD14S54zChGRCmT6aXE7whKPxxoj?=
 =?us-ascii?Q?U0ErgYGgE/scDI0fZ8zm5OHUfpUYpaZmMyND59hJwnITxA5AwiNvpIIPU7y8?=
 =?us-ascii?Q?IZyrDtXU0G8PXe6RBknQF2dmaQwwemPSsziVjx+k4T0d++f1Ynb8Rh0+ZKKh?=
 =?us-ascii?Q?hx6KiGikKy7ESnnwhZ+o6FgDPa0jMRG10tjOrWqIFeKp1Zmnp2dKKxlbm3N+?=
 =?us-ascii?Q?eQ6IirgtzVCM16liO+a+toD34UfoxPW+ChiCS9Ex1qsEPNhdOa7vLQ62Z6xD?=
 =?us-ascii?Q?ashOqndS6rKS/8I/cERmABXVV8sbvSHVsV4P1/uxfN6Vy2zhawD2Oqj+dzQe?=
 =?us-ascii?Q?Q6LNMNgxswBeVAXHVIZTMKyVjE3zvwUo/WHlxGGPsh8CXEsJzydEGKa0BVf5?=
 =?us-ascii?Q?V3f6eab4mMObyuDiR8kg15GB3Nj6EeV63Cdi6tfeRgLKOix9hi+6RymgF5bM?=
 =?us-ascii?Q?MCklLNyWmclZUlBAtB+Hq800HMRCxjqNEdiU+vvfj5qmVVM0IOMPbRWJb3fJ?=
 =?us-ascii?Q?bHnFIyfsL674CSOsGd6DoNs7AjRGeCD9+92noOTSDdsE25HRrUjkNSjCHasE?=
 =?us-ascii?Q?GNqHHGlqr205LW4s3k9mZrg3N8XQJYR6wUlQ/1/SPK3JjJdjHWx1sDd8/5A/?=
 =?us-ascii?Q?3hR1Re7FsGHdd56EYKaV9VJj0gtEP7G57mU2sU66WmzGXjVRGwIMK/4WjXLR?=
X-MS-Exchange-AntiSpam-MessageData-1: lNLvL5G5sRH75Q9rvT0luTJlPFyjJYplDF0=
X-Exchange-RoutingPolicyChecked:
	cUgMvsmkn7RwUUZjhdc+BwIi7J2bOdLgy/W9zgYyBDaZlI8MAf5YhAqPhK4/a5ytl8ysiKmbAsQexH9KMFGaL+AFJaT1bTwaxx7sU3g5tvkRtS7DAoODycs54Xe8PTuqAlZ6uQL+7FkCy/qm9Hcysql/G1OY+aGJJKGIx22lLO9jkeH8t5VHeclYxcsfFKBdLpRTzaLL6bnrZ2rN9sYLNDFNHgEtWE3iq83k3Vl/Ys7zJeacchj4i6aLs2on2QF/5oumXqa4yIVvX5fgcxfzMEl+tpaZI/C6m0S9iRhsxGBkGC7mP4Vw5T28vZAuzXnpcwe7Z+81cMe6f10ZTjqH6A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b322aa95-719b-4548-91a6-08de9f788163
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:35:05.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uD+5SDO3LjsamFw6qTEV1ulOvyB4q2FMrA7HbALqx/GZduqq9+7HQZh5j5naOKGv3wuU8S6MCMNnub+2MfUjXkAa1RGGKDs3yMBRny8RzI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MiBTYWx0ZWRfX2p5mXAUlYOao
 ooRrVfpKuc2zcgJRYqEXKwQF0p5bIMbXJFvlfdwTi+U88LphqAx3s9WqpqZ/U450eK6VcQYJ8Ri
 gvtDATHf9ouuA8piWlMWYsY/rXsWmNOvVXAkJatMb4BFFLQB1Dk5YoxCgrugBmauHT/iW1H1glV
 Ql03hUn+2fOv/ePp4RWwppDGA/tyx2UG4/1awqrMc6BVlC/2SY28/Ia3m40lx8OOUaxhq98ktoL
 kc4Qqc2hmhZfdhW4uKgmZNwQQoYkmNAmvh3LRQ1KeyNy/69O1KwEeSHp0TrB8jgMLlLEXZXGczC
 dkXrew3Zjy4vizarzHWYO/Wln9+0DmPlwiAYRP2nCZW1HvFmuwJZB79Fd0FGHq/oeh71KHPTa5u
 zewOFsN36bTG2tZxlIVrO3GpRbunlPcQ3D6eoGvZCoZmtf05sh7T9nIz2YIUvfGzjLl0uXARjtT
 N8kYC/wOksWlQhOQejQ==
X-Proofpoint-GUID: Qq-YpKawnwfepJfF_sJUImX8aEjDOSNQ
X-Proofpoint-ORIG-GUID: Qq-YpKawnwfepJfF_sJUImX8aEjDOSNQ
X-Authority-Analysis: v=2.4 cv=Bp+tB4X5 c=1 sm=1 tr=0 ts=69e728ab cx=c_pps
 a=kBTuJkHEWKOaoYTOH1TR3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8
 a=mm2UkWPFonPHBTd3Hn4A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210072
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240067-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DB3E437BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

remove_store() calls pci_stop_and_remove_bus_device_locked() which
takes pci_rescan_remove_lock first, then device_lock during driver
release.  Meanwhile, unbind_store() takes device_lock first (via
device_driver_detach), and the driver's .remove() callback may call
pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().

This creates an AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Fix this by first marking the device as dead using kill_device() to
prevent any new driver from binding, then calling device_release_driver()
before pci_stop_and_remove_bus_device_locked().

Marking the device dead closes the race window between unbinding and
removal where a new driver could theoretically bind: once the dead flag
is set, the device core will refuse any new driver probe.

After device_release_driver() returns, the driver is already unbound,
so the subsequent device_release_driver() call inside
pci_stop_and_remove_bus_device_locked() becomes a no-op.

Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net/
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chlorum.ategam.org/
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..1426328e9f05 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,8 +521,36 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		/*
+		 * Mark the device as dead so that no new driver can bind
+		 * between the unbind and the removal below.  Once the
+		 * dead flag is set, the device core will refuse any new
+		 * driver probe.
+		 */
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+
+		/*
+		 * Unbind the driver before removing the device to avoid
+		 * an AB-BA deadlock between device_lock and
+		 * pci_rescan_remove_lock.  Without this, remove_store
+		 * takes pci_rescan_remove_lock first (via
+		 * pci_stop_and_remove_bus_device_locked) and then
+		 * device_lock during driver release, while a concurrent
+		 * unbind_store (or sriov_numvfs_store) takes device_lock
+		 * first and then pci_rescan_remove_lock (via
+		 * sriov_del_vfs), creating a circular dependency.
+		 *
+		 * By unbinding first, the driver's .remove() callback
+		 * (including any SR-IOV VF cleanup) completes before
+		 * pci_rescan_remove_lock is acquired, ensuring both
+		 * paths take locks in the same order.
+		 */
+		device_release_driver(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.53.0


