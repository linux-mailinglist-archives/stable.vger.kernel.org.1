Return-Path: <stable+bounces-196875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF106C83FB2
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 09:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3475134B429
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B62D8776;
	Tue, 25 Nov 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XVBzHxmN";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="csI7SuzC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2C2BEFF5
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059382; cv=fail; b=Thi9umABGTCTqCuiQCfqXfCHZB4nGhxBmAKdqOyDXd+dSDAQ5OyPxMFRGCM+kzckkP61+K7oRlcG9zVuMfJ3w/FSwC/Juc2v19Z0oD2jMiDeYDugvto0tqJC8fAn9A1Wzf0cSQ9GrHB5j5qItEBUUbHVUjgTpVJjPztLg+B5Cs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059382; c=relaxed/simple;
	bh=S0AMc7JP5vxRMJiSBPQR1AJ4NdAo3Rp/WqVeweLRL/M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VKv4DtvLPkjZpuVk8iyc0dz3GORQNSfI96wce/nVdrtyX13R6j/NofGT91x+0H/TVr7TdD5335kUnUoZx88/6Qt55+r0W8Xn81lqxnaBQRX88QpV4FN6bPqiiP/NSr1sp8Cck4f9iVeJjx63IZeKFOKEGnwM5ntxh/2wlqUDeIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=XVBzHxmN; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=csI7SuzC; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP5lVJ03736075;
	Tue, 25 Nov 2025 00:29:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=9hXVL53Vl1c9W
	Om6QpvQgI+9Lp7BCdBUrUj0yyu8fcY=; b=XVBzHxmN+OTi0xlcQ9dO/V0IuujW3
	A4xPUfLusgVt3jI+vcJ6ZBiPBDrLdz7gcinzaov11otfDxkXdd2ymgblPSQYUMJa
	w0pK0BJDZQq4SGMOGvKkt/PUcjsQ5+eq2txtEw3JSYifrKR1EkI9uGizXXy5j+fh
	i8IOTnyTbPWzOgtKXSfgHyFydfexuNZhs9k3K0QhfZoiu5i6V3nvTiECSiyyXDBN
	Mo8mXfg9Yv3oFoBKjDW7yYDn3vQoDlDNFJczZ+9AZDgifUSD8xiUnTqw2DN0FQhG
	VpDnSYutg2OLXDfhf9IEZj/U0vwbD2wLnrh8Us1ExehhOkYnB9i7s79XA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021092.outbound.protection.outlook.com [52.101.62.92])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4akbkhwesg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 00:29:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urPhbtzrRZdoAEOngZzyskDJD2fWZyxIpP/urmvY8/XzVe3xU0K4l8TOUlZAQsqm01Kgjc3E5QILpg7BHUHMGBdz6mQHZiFqQMaP/x3WtEziU7NepcrOCt7z0CWkgXYmX/iThqPBToyWSFQwVvvH3hwrSGT4HlzxxkLG4vVVQof4aIXNYbOX/nEGnd5WVBcniuktuZMiFua1Vm9tGbBVWlrlPe7cgsNm6Z4Jr/4plsadezFmFOvdU7/kqmZa8hagbkS04wDXPMKEXqUG6k6GkqfFNElQ/ZUdbyGl4+dCFiJvcUSQGw+eCXnTyF4q0HVHh2BmmPR7OPs4VWSp6kr5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hXVL53Vl1c9WOm6QpvQgI+9Lp7BCdBUrUj0yyu8fcY=;
 b=mD+z0OP5BIV0Bs5CDzz9r2z4YHeHwoUbW2DYdeFUpv4fF5r0KuWzA/j3QrDZYjtn1tR+LmXy+1F/lA2UTYtdQo/w3T7nxFdWoALSjN/JnNu9u8xAuZ7b5Orx5J6iXZMUE5w3c25j+1T1SnKOXsRondMdBFl7VpFKHlL6Xy9oImGtydms5Lf4H2OBR825QQYQPeu1I8Gq8UDFWeWplCK1VunN6taAwwFVVBR/6YfaLtdVlv0XOL50g8e8rwXHoqQBA5xDwfgTo3oVczAzTA2Ld/OjuxHj4JsJLkpORPFRelwwR6s11Rb84yIQppuiz8l9CtiCQXmK2G40OMFtzzVuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hXVL53Vl1c9WOm6QpvQgI+9Lp7BCdBUrUj0yyu8fcY=;
 b=csI7SuzCNs7h0+gNSzBG9Z/ZdswMxiQMIaGKUmeKozICaUgTvnkZ/QKHpWdkdqR0Vnbn4crsQDbUnuf1qjXPgnwsKjzdhUoQKeNT+X3WOrerE6IekS88LzPF2A73TZHl7KJTSVDpsKiZL4ShciXx14H9P2yEiAvPS7H5NWZHXRPz5NueynBuzX0lkEYTazrJ09IrZc3QXVA6OSBgtiEJjUN/dMXaFr3ZLIR+eC3+/PFAUIjgyQeqsfCF3eUFaJff7LUX7yCLu01A88dlXMF5uKO76BF9vZcs6tnVplxLgGmYvMKAHXQplIpwinqFkVk2afmgSoh4EgctTUm+UmObDw==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SN7PR02MB10177.namprd02.prod.outlook.com (2603:10b6:806:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:29:27 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::27c4:c948:370:572b]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::27c4:c948:370:572b%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:29:27 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: khushit.shah@nutanix.com
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: [PATCH] KVM: x86: Add x2APIC "features" to control EOI broadcast suppression
Date: Tue, 25 Nov 2025 08:29:22 +0000
Message-ID: <20251125082922.1657936-1-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::20) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|SN7PR02MB10177:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bc66ad-f135-4798-d762-08de2bfcbf31
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J//mj8Nypma5zPoRVYRtKJdAAcD/y0xYjfa5YC13qsBiGFVRNNR1fXEIi42M?=
 =?us-ascii?Q?MA71zzXRqYz4W8gF9zabV0f0pFWu4sjI6NNuRhNOXeW3EDYhJbdyuGvQng0f?=
 =?us-ascii?Q?XEOzsQ88takyhgZjXDZfoCOpOop/TfJKn1dFxWjTfGSP8ywHY9ru+gNPluxg?=
 =?us-ascii?Q?23xtzKcme+TNzbg87X2h/K+LvNh4cegZ65Z6ZdwdRg0o+/RNorUhpbDV0nU1?=
 =?us-ascii?Q?pzBtoj4k9cjXvDnZ3x8JVsJ8wG4GgGg4FqSJzsTeF1F/ybfLyZpOg7mV/0al?=
 =?us-ascii?Q?ETQ2TldvUr1C+cN31t/gYtGdRfR/tN8V+Umc8qAbOVR9MzNcd7o7BXtoVRn2?=
 =?us-ascii?Q?WGwtGK+jJUymT01r9zKJA9aP2tnCH249sc5C+jcM+e8WGBVCLBUvehUsd/9w?=
 =?us-ascii?Q?Ji+0cH/U9v8/8SxRZX1rw1HoAPXXeSjS6GyXvVWJc/LAiPe89/dmbK8e98m9?=
 =?us-ascii?Q?hVxElL1F07MshXw7Out45Pqg5npYANzVgvXOD8B+KQvSXJRvXG2qzBJnKCmI?=
 =?us-ascii?Q?nJmX48ZiAJq8GDhY0DddZUrM4pzD74FcygbTTUzfQO7CjANiV2C0F0Wx5QHR?=
 =?us-ascii?Q?e5HbZYFiiU5gKSBD8X9EkrfJSoWxvPXPqSzWE7piU//N5T40LClj6qCZ9Sq3?=
 =?us-ascii?Q?8CQhDsSEje0OTMvLVO4gvhBHcaoWfMWz8yM6XgVVnSOEJ4SM1/Gc95lDAZvx?=
 =?us-ascii?Q?Kcoe51yVrok9xOEC7pNglW1S9pVlRzYx8OzUqt6Q+QSF7Cjzm2xNEYdxKzYL?=
 =?us-ascii?Q?A6FvRVzP2bDVNuXVy8Z/VErhElOyxn++fWmfRPT+1KYRFcxBXmL+FMkM2wCf?=
 =?us-ascii?Q?V/N9In+XTohjY6gR8Cd28qbIfModd/nRPW0ojVa0Yk3PEUKWlOOSgCYUAQJv?=
 =?us-ascii?Q?YFp10ZEOveEgLPMBC/d8HFJShPbt4WGhSu4jjDMp0zhSrXIgNdxGJPnQIkTd?=
 =?us-ascii?Q?0ikm/IpXpar+4Kl9cD2rHW7Niq9ttTjHDY/rATKjjfCDK1feCxtPyDHUO7v0?=
 =?us-ascii?Q?k0boxoF4+JzgQCDrHni1Psh3Pqvfywa6SFwA9sh0IxPrGgGN9nRy4s3pvc2m?=
 =?us-ascii?Q?1xfts7w7PYB09xxAdSOyvj3/pU9JqaoJOJmXhlSwTgYGlZ2SG0flW4F2TI43?=
 =?us-ascii?Q?jm05pDfbwF9WaaxMHnubCjMrtGFFYajfTWQB9cF7Y1okSqGMjmjBhQXZGyeG?=
 =?us-ascii?Q?9DXNfpGSQnokHGVk1dEzUKabHBC96o/MBRkpVTBKy4pkNsoFZtCz4qiQgPB2?=
 =?us-ascii?Q?TY0tCrsIs2l7THkh7YTzgceOGlQUejFteRw4XJVc6tKxVfW0SZc9G/5o1SEk?=
 =?us-ascii?Q?BLTv0ookeZpDXFq+sKZ7gEQoOROSXwS5Z7XjYWbjVmCVQRAUcWqd0TYmSaYk?=
 =?us-ascii?Q?unJvarrkWFMxRDcBH4FeU099Pu35A8sU1JKXj7w1iciwBXlMAHlZGeUQb3Uv?=
 =?us-ascii?Q?i/QvlZj1UqpwpYh2h9t3iRpST5qS306iEA9a23Mv/PB8JXXj7YbMUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wXpf7fzDCAcqtQ5NDQQJkC9Np51uOOrQ53y/8f0p0HFiQ19oan/y+H4sf6id?=
 =?us-ascii?Q?l6+H7QKdriz6KJiqnmI15mikdLcrtuE099X8RgfF/dhqrVF85gMaiHLvNxA6?=
 =?us-ascii?Q?Lj30pB5Lh8myMmXvf55L8VdlRUGhtMbm4HMhYrpZjZMAkLIpaRvAb2hM3unw?=
 =?us-ascii?Q?xIySoJeuePU5F1/mDNY+RjBA7JQZ5lGDJxpUYM4GxAqsXBmZb5FXzK9lKbSb?=
 =?us-ascii?Q?5jrKgyXjqjiX+MKtvtoyY89pmt/z51u2sRzX7ysCSvfYCBCVHfo6tWoVA77r?=
 =?us-ascii?Q?d34VA3UQVLC7m1KPNcSdVRAoryYOGHsfcH2DQB/q9ZttMQ3Zv3z7mh/PuK6Z?=
 =?us-ascii?Q?NUA8l8WcLHv+kNt+VK9TzQM4XWFJqxz3VyQKPXmBuzqe+7iETvqTy80Q4wLl?=
 =?us-ascii?Q?ltfjoBimqUyY9PkR24n8LlR226HBtPOSZdr+v01QWliWLrZXFdSFVel5ySSC?=
 =?us-ascii?Q?atXIiqUdgk9ZgxEVAZsaoqm43KFe5q3VvB6Kz5RZ+cMh6foycIS6E0S2MZvy?=
 =?us-ascii?Q?cz6C98VuPpib/j5sXUxdcdmrzADmosG5Ag3pBE6DevR5u+2BBNwUkA8MVJFD?=
 =?us-ascii?Q?VorJ6bscSpUgWDRfkWjbH0hOjTqNif0OIHWVmgyhN2sTek1LFsCD01RcAiTv?=
 =?us-ascii?Q?bARv7x4zHOVLIqJ5glUUn+ygRJPiYcnPTt8ZCupgEz+EUXhO8MENVR9o86XP?=
 =?us-ascii?Q?JQGXRACemsO3Jl8xHsyEa+yPq8oEJJu3ZLJ5LFx2Qth/EuPX2OhjNRjsN0uT?=
 =?us-ascii?Q?r9BkvqhpCWM5jSGfOdOgGzhDfghA+cEHrqKzA2esLzj2xVXhJvC1lsAVpVXO?=
 =?us-ascii?Q?00WTtBchJhAuOvO4HGX4puOg9G5mHCEpg5xOQR9/zANBaVF8RjHAKs82OEpi?=
 =?us-ascii?Q?ODcU+dsp8yX5Cer3HvKqxqJiqDj49TuvW/h4HajhCmi4itPCRqWCPmt/2X+8?=
 =?us-ascii?Q?ygHXard7pm/NVHipbsyghSQwpUOmr1EscQeG7T/34FPVHOJpg1jghcW5rtDC?=
 =?us-ascii?Q?blJYqjk0VU4+gQIvoOhJ0IttTsAU6OX6Y42wTbbi4IRfAZQZQuLML1uOLNvm?=
 =?us-ascii?Q?D2gBzELj0RUwkS03uPV78IHLqzcQ8c1u9bHo+PALwOEP6AvNKmVQ2uU+mMkg?=
 =?us-ascii?Q?TUWB4B++nfuM1gC98h/W+JlBT4WmyCRqE1HP18M0eFS79iCDN4HdiielWGsp?=
 =?us-ascii?Q?t0957cm1iJRiGFZGYqtUesgIli3jtCYsMXREqp3zjAaPA4EY3dniWoj7Cl9g?=
 =?us-ascii?Q?v+3SxwCQBNJRFcQ/AEeEqPBVyTlKgAEZ2eMuL7ILwWuOoPLPOn/sCF7BSeJM?=
 =?us-ascii?Q?5ZcSq1FZP3FoGIg+W5F8K6MitYOEpOic3uMERgpodhjRhTvJpcvCzMFoJeUR?=
 =?us-ascii?Q?Y1Ult/yjv+8GeYc+P0objg/Na9cbW7D5vJohd4FYn2ktLMh69ZotrfL4ljjS?=
 =?us-ascii?Q?2eIkxXRqNRdqLNLJJHbSlWakBo8zqfzZTq7Vjeu4fwOYDJ1LONVGVKfnesaT?=
 =?us-ascii?Q?biJqEZxRNL0sHjo2Xg68eoYodhqqlHtIkzNVf7n/iqyFXG4JUEaE4Wdld7R1?=
 =?us-ascii?Q?Ig8DKCjCqPsYPuV5Gkoo9S4+Z/6TB6ER2TYRjd73zCa06ZnmNudmpOWBHphi?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bc66ad-f135-4798-d762-08de2bfcbf31
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:29:27.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFhbtRz3HTsaWbRgBrfmwL6akqdpNrKVSOYDP3W1/0qz4NeCBZU/UGFquU4lLqyvQPb5gwxxwxKavei4uR86yNECl2xmEQgmQ93glZn5qhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB10177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA2OCBTYWx0ZWRfX2JIps6ZFUtDm
 QjirFN4xkKB2u8uqCfPylQgEllUZcBdd6SE3O3DzpclgiAHYYtwQ9Ts9PEMyD4uyOZg2lw30iTR
 Ldzre36Rwyzea7khkMCWEC8cn5f7zofMgl6/fZJg2V5UjNMIx+ulgI/GR/H1inyJQUWqodEvrir
 oVUi8Wk1daUlVZkTxZ0dQ04BS4xL9vVuVZLVrUmlUj09qkil9RxLpvn0sM1ybFKkYUPSLp7mTtH
 fzO+AjqBn5+s97ACAwrjMrAAZ6g3cF0vfZOrI0IAagPuDMTj6qK1vqBOBt0WpI3/3p7wz7vaUST
 jhmSnX2aRahs+96PV4eixDfQAI0Zk+jCQqSBn/AFTRqDLytsPTPnWwcAnTaU8VC1QhDBlmnn2Uv
 OiUQ9ECdQ4npi1A0oVDdu+G4DbpPuw==
X-Proofpoint-ORIG-GUID: 4Ecarl_RGX9yKRcCoLxu1bLwJyngyQJ3
X-Proofpoint-GUID: 4Ecarl_RGX9yKRcCoLxu1bLwJyngyQJ3
X-Authority-Analysis: v=2.4 cv=cPbtc1eN c=1 sm=1 tr=0 ts=692568eb cx=c_pps
 a=v2TZfKysXdkZaZqPd8ZU/g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8
 a=SCrn97RjWn4ANx8Y1YwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Add two flags for KVM_CAP_X2APIC_API to allow userspace to control support
for Suppress EOI Broadcasts, which KVM completely mishandles.  When x2APIC
support was first added, KVM incorrectly advertised and "enabled" Suppress
EOI Broadcast, without fully supporting the I/O APIC side of the equation,
i.e. without adding directed EOI to KVM's in-kernel I/O APIC.

That flaw was carried over to split IRQCHIP support, i.e. KVM advertised
support for Suppress EOI Broadcasts irrespective of whether or not the
userspace I/O APIC implementation supported directed EOIs.  Even worse,
KVM didn't actually suppress EOI broadcasts, i.e. userspace VMMs without
support for directed EOI came to rely on the "spurious" broadcasts.

KVM "fixed" the in-kernel I/O APIC implementation by completely disabling
support for Supress EOI Broadcasts in commit 0bcc3fb95b97 ("KVM: lapic:
stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use"), but
didn't do anything to remedy userspace I/O APIC implementations.

KVM's bogus handling of Supress EOI Broad is problematic when the guest
relies on interrupts being masked in the I/O APIC until well after the
initial local APIC EOI.  E.g. Windows with Credential Guard enabled
handles interrupts in the following order:`
  1. Interrupt for L2 arrives.
  2. L1 APIC EOIs the interrupt.
  3. L1 resumes L2 and injects the interrupt.
  4. L2 EOIs after servicing.
  5. L1 performs the I/O APIC EOI.

Because KVM EOIs the I/O APIC at step #2, the guest can get an interrupt
storm, e.g. if the IRQ line is still asserted and userspace reacts to the
EOI by re-injecting the IRQ, because the guest doesn't de-assert the line
until step #4, and doesn't expect the interrupt to be re-enabled until
step #5.

Unfortunately, simply "fixing" the bug isn't an option, as KVM has no way
of knowing if the userspace I/O APIC supports directed EOIs, i.e.
suppressing EOI broadcasts would result in interrupts being stuck masked
in the userspace I/O APIC due to step #5 being ignored by userspace.  And
fully disabling support for Suppress EOI Broadcast is also undesirable, as
picking up the fix would require a guest reboot, *and* more importantly
would change the virtual CPU model exposed to the guest without any buy-in
from userspace.

Add two flags to allow userspace to choose exactly how to solve the
immediate issue, and in the long term to allow userspace to control the
virtual CPU model that is exposed to the guest (KVM should never have
enabled supported for Supress EOI Broadcast without a userspace opt-in).

Note, Suppress EOI Broadcasts is defined only in Intel's SDM, not in AMD's
APM.  But the bit is writable on some AMD CPUs, e.g. Turin, and KVM's ABI
is to support Directed EOI (KVM's name) irrespective of guest CPU vendor.

Fixes: 7543a635aa09 ("KVM: x86: Add KVM exit for IOAPIC EOIs")
Closes: https://lore.kernel.org/kvm/7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com
Cc: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 Documentation/virt/kvm/api.rst  | 14 ++++++++++++--
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/include/uapi/asm/kvm.h |  6 ++++--
 arch/x86/kvm/lapic.c            | 13 +++++++++++++
 arch/x86/kvm/x86.c              | 12 +++++++++---
 5 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 57061fa29e6a..4141d2bd8156 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7800,8 +7800,10 @@ Will return -EBUSY if a VCPU has already been created.
 
 Valid feature flags in args[0] are::
 
-  #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+  #define KVM_X2APIC_API_USE_32BIT_IDS                               (1ULL << 0)
+  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK                     (1ULL << 1)
+  #define KVM_X2APIC_API_DISABLE_IGNORE_SUPPRESS_EOI_BROADCAST_QUIRK (1ULL << 2)
+  #define KVM_X2APIC_API_DISABLE_SUPPRESS_EOI_BROADCAST              (1ULL << 3)
 
 Enabling KVM_X2APIC_API_USE_32BIT_IDS changes the behavior of
 KVM_SET_GSI_ROUTING, KVM_SIGNAL_MSI, KVM_SET_LAPIC, and KVM_GET_LAPIC,
@@ -7814,6 +7816,14 @@ as a broadcast even in x2APIC mode in order to support physical x2APIC
 without interrupt remapping.  This is undesirable in logical mode,
 where 0xff represents CPUs 0-7 in cluster 0.
 
+Setting KVM_X2APIC_API_DISABLE_IGNORE_SUPPRESS_EOI_BROADCAST_QUIRK overrides
+KVM's quirky behavior of not actually suppressing EOI broadcasts for split IRQ
+chips when support for Suppress EOI Broadcasts is advertised to the guest.
+
+Setting KVM_X2APIC_API_DISABLE_SUPPRESS_EOI_BROADCAST disables support for
+Suppress EOI Broadcasts entirely, i.e. instructs KVM to NOT advertise support
+to the guest and thus disallow enabling EOI broadcast suppression in SPIV.
+
 7.8 KVM_CAP_S390_USER_INSTR0
 ----------------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 48598d017d6f..f6fdc0842c05 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1480,6 +1480,8 @@ struct kvm_arch {
 
 	bool x2apic_format;
 	bool x2apic_broadcast_quirk_disabled;
+	bool disable_ignore_suppress_eoi_broadcast_quirk;
+	bool x2apic_disable_suppress_eoi_broadcast;
 
 	bool has_mapped_host_mmio;
 	bool guest_can_read_msr_platform_info;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index d420c9c066d4..82d49696118f 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -913,8 +913,10 @@ struct kvm_sev_snp_launch_finish {
 	__u64 pad1[4];
 };
 
-#define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+#define KVM_X2APIC_API_USE_32BIT_IDS            	(1ULL << 0)
+#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  	(1ULL << 1)
+#define KVM_X2APIC_API_DISABLE_IGNORE_SUPPRESS_EOI_BROADCAST_QUIRK  (1ULL << 2)
+#define KVM_X2APIC_API_DISABLE_SUPPRESS_EOI_BROADCAST               (1ULL << 3)
 
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0ae7f913d782..cf8a2162872b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -562,6 +562,7 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
 	 * IOAPIC.
 	 */
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_X2APIC) &&
+	    !vcpu->kvm->arch.x2apic_disable_suppress_eoi_broadcast &&
 	    !ioapic_in_kernel(vcpu->kvm))
 		v |= APIC_LVR_DIRECTED_EOI;
 	kvm_lapic_set_reg(apic, APIC_LVR, v);
@@ -1517,6 +1518,18 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 
 	/* Request a KVM exit to inform the userspace IOAPIC. */
 	if (irqchip_split(apic->vcpu->kvm)) {
+		/*
+		 * Don't exit to userspace if the guest has enabled Directed
+		 * EOI, a.k.a. Suppress EOI Broadcasts, in which case the local
+		 * APIC doesn't broadcast EOIs (the guest must EOI the target
+		 * I/O APIC(s) directly).  Ignore the suppression if userspace
+		 * has NOT disabled KVM's quirk (KVM advertised support for
+		 * Suppress EOI Broadcasts without actually suppressing EOIs).
+		 */
+		if ((kvm_lapic_get_reg(apic, APIC_SPIV) & APIC_SPIV_DIRECTED_EOI) &&
+		    apic->vcpu->kvm->arch.disable_ignore_suppress_eoi_broadcast_quirk)
+			return;
+
 		apic->vcpu->arch.pending_ioapic_eoi = vector;
 		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
 		return;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9c2aa6f4705..e1b6fe783615 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -121,8 +121,11 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
-#define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
-                                    KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
+#define KVM_X2APIC_API_VALID_FLAGS	\
+	(KVM_X2APIC_API_USE_32BIT_IDS |	\
+	KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK |	\
+	KVM_X2APIC_API_DISABLE_IGNORE_SUPPRESS_EOI_BROADCAST_QUIRK |	\
+	KVM_X2APIC_API_DISABLE_SUPPRESS_EOI_BROADCAST)
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
@@ -6782,7 +6785,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.x2apic_format = true;
 		if (cap->args[0] & KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 			kvm->arch.x2apic_broadcast_quirk_disabled = true;
-
+		if (cap->args[0] & KVM_X2APIC_API_DISABLE_IGNORE_SUPPRESS_EOI_BROADCAST_QUIRK)
+			kvm->arch.disable_ignore_suppress_eoi_broadcast_quirk = true;
+		if (cap->args[0] & KVM_X2APIC_API_DISABLE_SUPPRESS_EOI_BROADCAST)
+			kvm->arch.x2apic_disable_suppress_eoi_broadcast = true;
 		r = 0;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:
-- 
2.39.3


