Return-Path: <stable+bounces-226516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJp3CKyPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9BC2AFB4D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B3B314CEDF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372B3E3DB1;
	Tue, 17 Mar 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="MqTBsvwr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF7332604
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767048; cv=fail; b=Or6EVfJes58GgItWwHXh6ITQ3EqsiAifqSp48sguMlT/32Fw1Vc8K1wBjj/i646oauRRlHnC9qMuo9T0r/jsmsOQL+gQTI0UUPOIQExr8ZJOT0SmMx7fZ8v3p3nGk9WBGFMs17IbNctI0iEDeBBp2A9zjaN50a8jNRsyuu+IF+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767048; c=relaxed/simple;
	bh=Q6UxtjIAce8qBHeH7Uq5K6vNA04ZLwlsXcXt0GANSgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVroYAjxuMNV5eZ1NiLwSQY+q9Hnw7l2risyf+GJArK1xUIxUdsJNubM25etoqgobQRnK14y7YECrq+eneOzJoPQLc29gmR22bVI+i0CvqqjF/Hr/CAuGOyQms5W2YPh8VepU0nMj6FNaKX7/l0dh9sTKNPMKQiBwF6RutU6Inc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=MqTBsvwr; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMPkUX2244769;
	Tue, 17 Mar 2026 17:04:00 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazon11011062.outbound.protection.outlook.com [52.101.125.62])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gtb7q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:04:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEEhe/FfQB2ohOTG3bbuRMei8RF1t61NP7bG/n5aou2BRMxNl2rW9cEr/HIekBq1zli4PodHJklZgxdBXz8pQ5IryiyTabajrf2e6/EoZXIcXiu+pySY4TgW33HCkQUJjeX6AzrCjaAzTTu+uWetSYhofMD0/041uBegeUFAzPXaUNCyGqHpKZz1wnhZZKSD6G8E6xgPOkjr3Dxw61vak0gLqzV9ZuLOlUs+pXJiXWmqhKFxb42jgR/6yfZBrP8sOWCf5y8z97WW9Tx45nCBRWV6bMjshkFEgjIS1WfP79sBjAiHi2keGV9AODUXinNOR5ZT3kvcCngzNKkO2PKIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKyznf+mO8kxfVKxXnZ9vXSE6GYJy0xn7xUnw52oUuM=;
 b=rB6RJGIE6RSKnqERSarQkFWPBFRLczzdVTB4oNCi98EqGe6IbdUTh6Cgtt3uuBBR7ULogTyQ7WCewmgtMC0PCuO05aVrGdW1rmn6ry00OKyyQoFZdyYn+7kjSCgN6Dk6b5F9j5lQ8BWKDfXsNaen43GvX8CQkR+AmtaN6K+HU8gFadBcDjUt+pzxJAT+uaxmc+RABqRNzhBr/LSubD0+kNLP5VR6ofEPjSOsqsCs07TzwwK4Gy+ZaQfgXy4FSjtU8yPeJfGt8F4vVHCOG8sMqPLDMQ4hALscTTySW8pb1BEfNEkBNtfSv6kTKU30U8TOb6dUi7H/itIDKE0UYvLj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKyznf+mO8kxfVKxXnZ9vXSE6GYJy0xn7xUnw52oUuM=;
 b=MqTBsvwrtbJpUOYomVB/mCqduH0Eudxm6uqmzp+hOC3nyPsHYJTpLjRClinlE5Obo8MOmlUKxB4Ozo7QkTQKBOXz1ZISs49bBguSRaIRaWWBF8HHi3HkuF4z6SCOS7iaxxnIJ3EEAn9uxOWxvU2jCf2rkCw/zFsZYorMMOzVAsIlL6lx2yUG9QyhnMkYK1v+2vfiLyTZZxA3xgupTt/+3aElb0PfaQh7TCZXftbC7ZT2L7yEGbCFginPSY3k+CtCzln7ynlE4Eb0jPwTumfiRhBQcKmz3rr1truVHiYh8SWPIae1HVI+SVc2j1ip5OaptTsvuOroODHytttPI62Y+g==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1962.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:03:55 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 17:03:55 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 17:03:43 +0000
Message-Id: <20260317170343.745772-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031739-putdown-harmony-6f22@gregkh>
References: <2026031739-putdown-harmony-6f22@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1f56ba-8db3-47ba-1f5b-08de84472c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|3613699012|38350700014|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TP4HXBCXzk3KdFu1dbjGKtbw7duGZ01TH/1K1eX5A3WMHNCwmYTWO7CkGF1ObZITJsLhPyXNsoYMXmyaFq7y6EQMATK+xjV/RK/YLul5sUcfR4eLCabIq5kSqkHvixL3+wSf3pYDtJ1yDaj7/1NRRJPEJQTqROnq8QF34DsXOKRZG2EmwUD976Dph5qFmgZ28SNH7121AkJu26feVM7aTSW3scWbnFQqZ3xo8L+AkoIll0PQSnHbqx3kZf/ykshTWh/pbvBYQh2vW8bKNueYVp9IlAWKSTJs9M8RLiLSf+pQiMSD/cH/58mE5LFE+2XEjShbi/S73ghFCiSwb2a3kg7HiJ3Jh/EDznWZ1B5xK3jjO46cWCFVIMvKHLQLmo+GubENHbdLSXW4nFF2vSGdXlOWgP9ctRO5pjexvbvO0Rzy38fheUoEM59Ga9LYwZSa5PKgU6OMqNAVlwaaoiQdmbat4YQAwMPAZWv4WqLSyF38k1RrX4XslLBuD0nzkTBGGU0u238WpiAFvm74xassY8cR8GmYb4HIXNNIQy/2Ea4IsKTApDEHCj7aBZimYlr5Qq49+uHDsg+FiEtMBifEqYmsCQ4qpZNOx/PD3Qe8sZSpgsTxPO0Hd5Sq9DD56e0HicElAXqTISxZqk9n+auQg/OoSJGcaN1k1jElVdlVbo9ShrKS6lV10JZs/0R5G3cyhgzCYjlEqainQ5+H/u0qHVNeSUEXFc3Lg5XEiBNJE5Vn2xXxEZp8/pFwYyPd4RVgWExzf4cwTFNBOHcXWgYvkV6SRwG69LCxLb2oP1XII5MxDNK3jyGZvbMFhgbQwxg+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(3613699012)(38350700014)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjymqGE1+eA6qg+z61iOt1KNfs1BPXgw5RJMzZbqovU3wHa1K87swDAFrVE0?=
 =?us-ascii?Q?DTBsH2c5TLbBFc0LYU/nWLAb0cgvu7USP7brw8/JvyGNdv8kLzTk5rZTHPIL?=
 =?us-ascii?Q?gT9HcWK24PPVKmDc9+udBMRrQonlPFZOKLAnLpuE9eVXPIvM4tLmTFKdxIi/?=
 =?us-ascii?Q?Wfg/4+d88Efj/oJNdMW9VraHsNPV86w5jWkiwuHBwZXW4oGvdG/cR1Re01kf?=
 =?us-ascii?Q?cuOWFT+Kpy0lyorWFRGVs0XcAwknuDr41B8T6d1H9h72FYS97+UAHmdQTrJP?=
 =?us-ascii?Q?xykp5JEfpvNNvETw4GqYEjP/5o1uUZkJA7ci0X8Hvh9hHhZjDOMRE7f/IH5y?=
 =?us-ascii?Q?i5pxWB5KGEg1YUyEDI6cN0C2UvnSBTnRtWNa3s4A4nNqzjb3isEOGUmgp6ea?=
 =?us-ascii?Q?qORddPi30iPACB/sau1cO2ptEqj05kR7ayzL5oJxhxqmjfyav/ItpiDg++XO?=
 =?us-ascii?Q?H5QwoH9SUK2eKhY1Q1kxdVVMwr8A1t39bBoG9y1gjgKpY9eDH82yzo7y6p6O?=
 =?us-ascii?Q?mXXEnMSxXOrB9wTImw1FcYXM4JBT1vh7+TxfgNic4tVZpeE8OrrmdBdiR6Cq?=
 =?us-ascii?Q?fn/N6GtvP++Ee1tRyWOhrj4r+E+/1Kbv2mIKAgDMDVNXQQGepQAD2g1p39X0?=
 =?us-ascii?Q?si9/n/pQDoxj5eqPTm9HDDQQ0STrq42VO3x8Vo7Etd7e+RFpsX1p9h4XEAJv?=
 =?us-ascii?Q?E7IcKRJ1vnstDjBV41WJy9rHoW023i2zNBdKg5nnc6vNJHWItAaN1+GgIktt?=
 =?us-ascii?Q?cXZwMO8SDaP1cDdwskESSecBj6VCo7aQjoheynuhUm/T41HNKnnWtRwEylUK?=
 =?us-ascii?Q?dZFp+lIBvcTLikjGu7sc7aWkesoCFBM94E1H9P5RUSVqoLENdug5YhuHZYhG?=
 =?us-ascii?Q?UgmJzAZrtwrkf+sLiPM5UZaAEIaqg7RgXuJ8gKrDBSb0oa0UF7XVUwdt3+sI?=
 =?us-ascii?Q?wnWxzl6j7BXQ6bK6y4mPAE65q0R/OS8xvYAd1UAOR5TH1sewHTtk2DLngtC6?=
 =?us-ascii?Q?0aZE9SddexKMLnlV/xaqypk4VqPFpx3QeRCjNtiq2xCkGBkODIJMOKd49kPv?=
 =?us-ascii?Q?tp0YkpRaYOQQ3/+JNjBjrNe2ce2d657EqKiLvLZ6WtCLqh8mbkWQ8Y5Yw/zU?=
 =?us-ascii?Q?qaTmnmHopOXpwqXFoNWwXpfgZ9r+aYVxqvHPHmUojHkrUfVXFkoU4u4Z03QO?=
 =?us-ascii?Q?lXi8LAPOxQk+eqSK5fiU+FgFFtYCswKxyG83UD85ozWWXA+cqFNUOZXmuFfS?=
 =?us-ascii?Q?m+fpVw8h7IIlvKDyyBhVq557D/vAktTj9HIwpezBCxaC9OKYgbNrmO29k7tl?=
 =?us-ascii?Q?NmiCQlRd1XWw/ofNknKEUkGqjjuc9NIeUSBCdKfIHTCqMf5ivSGjFq8V8vis?=
 =?us-ascii?Q?8VSC3Vtc28OJmItf5olrppHUWm6SNLUOdnBHNfgs5s9CBX5ELjdf7VQ/kiTO?=
 =?us-ascii?Q?52zJS2fHWhSE++FCCS6V4hw9IfjPW0y1iK4urXlaUeWi9yK9UkAymIMchy4j?=
 =?us-ascii?Q?XSBNwNtmdaUGSReHwI3sMHI2Tu+Rww6MYSf9k0Dm1orvbfdH8gWfo+hmc0/u?=
 =?us-ascii?Q?PoD9ftxLkoyBAGt27socpBZ5eXlIhOSZpxsYU8+Ae440i6jVs/Cs++ZyL9BX?=
 =?us-ascii?Q?fjpCh5hdUeTOpY7NqRm7LfILlPrG9FYj/0PwMxMgqC6lBTgeCRzYtIjNamQJ?=
 =?us-ascii?Q?73e7glIYaNvT0qU+J4J9DvPOn7ZIuCiswfVjBOuN78V1+yLN1ad8Gvn2h+Qz?=
 =?us-ascii?Q?GtPq6poPpQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	ojqemn4wJlpIn5x3loLwF5F3eQbrN8ZUT1f7rWagDn8dpi2i5ChS4FcC2mPXh1d0mDKYDvTiFDEj4R2hrbKGWs1rhTnesQZeyERyNLWRF4xS1ilHIkYHto4EE9FcmsJsPcx1pbjvyNBHPj14+qlOXJR9ZELIKrihhA7q30SHcADsgv3R1SuSOZSaTKh6dme0myC7s3UGluqLnvrhjNipanDjJS1VB9B40xopx48rtuGcaDt2Dyv4vFBsKKp59qaD5ijcEbrvAE2vWunngxLLN3Dmc6EAeDqyJ6iSxE8PSGUb+/HErx/SGbynwPba+gHL7r8tLQmSBA9MV3vBKAhoyg==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1f56ba-8db3-47ba-1f5b-08de84472c6c
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:03:55.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSCLn/hGwSRH386jlNn0hIKOV3JC0jyc6NX2JI/Ow2jMYr89rdRY4a0JTKnJPOwm1WX5KYDgLHDllQ+vxw8THA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1962
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b98980 cx=c_pps
 a=Gy1tX0d62M1mN1iQkcjmGQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: ea12H-TuGcL35M56okX5SZhRHiJt-sd7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1MCBTYWx0ZWRfX7h/C3V+jW5Nu
 u6p31gaVl8FwIyyYgGTMEIIFfyEvVo7k50Wn5uZBvp+u8BqfgDPvala0enJUYEKUd/camcoyugL
 GYTWEs2/REitfdaJJljsdyUO7MR5Ll4AguTGq729yDHZ3lgxrp6D8JdvAinYDouRBDflLWbmbTA
 WQWI6aN1bWopyT3sLvplpxlgtw7/d82nsIAY0C/wIzNJbR/PZUscdSWg3dk+BOAPB5yLYUQuGAl
 IpFKa10oKhDjgvUKBEpWeZUONo20JSy/NHr/qeUV2wrD7qubJk/wRRhbT2Bi/tWrsyj0MeAvWJQ
 +FSNHH11QCkoS2BNjg+uiBy9TILP9RglUW0/5OwIs5731IqgBLq4jmjnOPacUz9oefJ5G1j+5uX
 uf4NQE6wo7IW8r2z5wVG9Gm6KN4g1ONLsTzgBS/uZxbnJdsAzmFZrN4vmsid8nF6YAkkH3e7Hpt
 CS9yf4h6wgKzRoDlQbQ==
X-Proofpoint-ORIG-GUID: ea12H-TuGcL35M56okX5SZhRHiJt-sd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170150
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226516-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdk.com:dkim,tdk.com:email,tdk.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E9BC2AFB4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit ffd32db8263d2d785a2c419486a450dc80693235 ]

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..f29c3e8531e6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -377,6 +377,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -398,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


