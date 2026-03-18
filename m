Return-Path: <stable+bounces-227165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CwdF5sTu2k3ewIAu9opvQ
	(envelope-from <stable+bounces-227165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:05:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63582C2D38
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3699314122B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA46374E46;
	Wed, 18 Mar 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jzBK1RpK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE35372EE1;
	Wed, 18 Mar 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867866; cv=fail; b=H7tUXybZZswDRQFWQ1VJP1ccwxbatTTT/ftJz7ngXaoE17UNz5Yh3E3EXBtDdGsDxpecGgMkTJY98Yu0z2lPkIHWnEc25L+a9OInI3ZWO8rh+U8RBc1ATtPY1RUPtjgIgjvJD8DG5HBJpky9sgb4juJ+kthnN3fc+usxaoGLKFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867866; c=relaxed/simple;
	bh=+RzuUa6v334DJOm8huc+iFLrzejRVq+juLE7DdqG6Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mgR13HU1Rx92/QqCiNsM1f7VNwYt5WZqmx0//BSZEiBedvA8gJhtth6ea0eQK23vOHRXaCguhXuTqyb+2nL1YGSlUWI26DuMABG5NFopCvXncGryQt4BsUXftFElFk8ddTdKnYjTUlm05bC8dluxFjc2epPeyqbjnHRgg2B+QBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jzBK1RpK; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I5f7Fw1345601;
	Wed, 18 Mar 2026 21:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=3xuypTeKj
	dQl6ppH9meKDdHaaBTYQt8yGVrDsUobtdI=; b=jzBK1RpKJZHrRh+four0noRy7
	H4SJ5u5aIhvEjXxVMDMBNUtgaAs3MlFGihTVYVpcV46dF32/eQbkpvYPwPWJQ7J2
	g+PqIHgTkGlHhITAhFFIJMBzBKC1wfJVyPr7jfifGCFwo3Y6ovfQxxyypkXGVrpu
	9DO8oP6gLE09y5x/Km0I6AqUR3OZdHhNSUIVVRYSWyGWrP5iWvDL1ahJ35WNy8gH
	cYpWfg+xrvmEbaGxGfLBkhmjmbE1yr4+VWEiU4rUQMJKrz5sBQ0/4S0LL/e9C/FT
	HH+7zo5w4VHANFNRlCuMBRiZhmvF/RqkriSDCjAWH+A3LDpa9ySIcPDwhA46Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cxm66bcjj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 21:03:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyLxDlfuP4xSlWK6E9gaXT+zUnNwYFAYbsJ7CpytJrxIoDcAn+WV7cbM4xzYWeUfmPRaYYyRBiYbu6iFmjgmhFzh4Msxr+X281TfcCBEiPOMaXlV2jzTMIq8zKtts13i25SDEVw9QUDe7nEcNdessI6jnqtuZFYuYd3D2t+3bscCawZ3k8ULLNC6HjsngODJGFdjnY9OBvUh27TEOJAjtC4dMnPe5zu+pjY8n4oh5pOCw2OxGSOVqoDKxF+p/As9htjSuBCX7rK2KcMBItVJuZutMm4bouatsC0pF2d8IuBPNUYwSGsUZW1r96KZmPpIvgQNT6pLB+NH2OrQr18GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xuypTeKjdQl6ppH9meKDdHaaBTYQt8yGVrDsUobtdI=;
 b=Q8ahrmVA6zUvX6enjs74XlJrlXSP6CrJoIATlw+zLcY1vVGFUprJirszBkj1gXZPJTeO7XywmuUWbdWZE0TVVdfrpGanJE99axhyawvo7sxi2gRVe8qFmof1sZQOfNrZC5B7Flm299vv8BpGJCxzwjsvkItpXtybEY7c2TbP+eRRBsKm7iOVLv0Q9i70NK3MZk/RZJYgbk7aFmm1/OPUj6BJmlBOu1WD18WRyFjAM7nlxsrsgg1yUCyQ04ycy9mMV6VMLH6uZH8EhO+NK4ppQOTk+rN+WFHBdCyJ7YrjGcHfVENvMBxwl3yT+ubo5N5CdUtL/DuPFuOge0VwYJBG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 21:03:32 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:03:32 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, lkml@mageta.org, alifm@linux.ibm.com,
        julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
        lukas@wunner.de, kbusch@kernel.org, linux@roeck-us.net,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v10 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock
Date: Wed, 18 Mar 2026 23:03:14 +0200
Message-ID: <20260318210316.61975-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|IA3PR11MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd7d919-5ee0-436c-e6b4-08de8531cf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zZOKi2FE5gOw0C6WdkoJ1kOyCEwfYmjkDk6MO/zGjg0+cDzVuMA8Coiu+KP4GOl76f2ytgbNte5RDS6dU+4fqNzbE00I81z8HywOnn0IIZF00n2qEK+L9WplYU+E73AGDlnc2wx/Dtf82Kz536etkSD9+nUU+LlRMq5sZXrsT/8WnOBmVON9xRq2BWGIIOTlnyq8aKLZ6vT8iBGh5xkmQYwJkpKNawuvtdozCauqYOaDykSkeJA7ixM5v6rARP7C+/6x9IhtwQCnsR30nazdJglUYnTZojogdcWKn2kjIq3fLEV3b4YzFJXrqG6PcdXteyAovftP0M3kLSth/NkEGf2IUsYG7aOgHht0oQml8nOB5AfScdqMkQ/cBUeDx6e6p0r5yrdptnXW85iOpx8iqSctRIPa1WkiOfcH1cljjEyiGuSTMvt+gq0Hkt5dQxHprZQNeuFgmsSGuK33zDndIR1Og9HUe0eYHRS64NOiq738KRoFDNVwTUPxB4P4cAtRBDwTmSsn+v1e0s9PaFT8HCZUrzHGtlQyLAdk2kQI6AkQdlfiOPV/ohtAbGubZ/xlSggzvftG9tNva6rMtHsogGld/kTZDfOzsFg7DeJG1sird9IgMcGWOKlSvyyIhNUzhxxLCVgoOOjc+zmSocPcagHXKuruFFnwxVYlHy/+2sWlnymmEMmLd+3VK4IEEdfKjsahs8PoUkptCTHs7YrpeEcoNZb8o8plT8Xk0vJ4uFAL2doDgzKUjNfnrQ1xa0cM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllpVmRKR3o1Z0JKMWZvUzBlcnlVaDJacG5nMEMyZlFBdHc2aHdJS25uSXlU?=
 =?utf-8?B?UW5DcG1yRDFXd0REdTNKelMwb1pqR0JnSDIwWktXQjBlU2p3WlF1SjNkNnNI?=
 =?utf-8?B?YUZXVUFGNC9zMWxuZHdJWXpKcE5xTlAyUTVOckp4c3FpMUNFVWdiVmhvRmNF?=
 =?utf-8?B?MWNTTFB0Z2Z1WlNvY09yTDFBVHhiSVBtZEtWWmwydXlpNWZ0NkM1L3ZpL1dD?=
 =?utf-8?B?QTRIbnlETnFLSCtsVlRQNW1taUc0a09vc3hENjJRSWNPWXRPNXdOcXI4V0pk?=
 =?utf-8?B?eW85aWhWeTdSMjlyTWdHNHVJa2hNTnZhYlJNdWpWZHJmVkxRaXlGUmJYMmE3?=
 =?utf-8?B?aURXc21jeGwvTGlSRlRIbllDNHJ2UWFkU0wwdXMrdzJhT0RwcXFlTUN2ZXls?=
 =?utf-8?B?VnM3TGhpU0p4TGZnWmRaOWNrN0RkYW5uTzZtVWtzMklWNEpPRE5vNVFza3R2?=
 =?utf-8?B?Vys0SmZmeUxIdjNBaUdiN1B6RGpybzNUUTVnd3NPb0laa2xlbTk1MzZ6YUdz?=
 =?utf-8?B?UEYvUHA0YlptZ00rRFlOeWxPaVk4TUo0TkRxdXo5K05iT052MUlDNzJTOW8z?=
 =?utf-8?B?V3VDcFdNWk4vKzBuSThjTnVVM0lscmVvRzNVOTc5VG1TMkJNUG5aQWVPdzE0?=
 =?utf-8?B?eWpQc2wrSEVhK0NxakJCbzB6Y0lqSElsL1ZSL0xKZGE0a3NyVVVqc0JObnVj?=
 =?utf-8?B?Z1BSMHNsdWFXSGtyeng3OHRnRHg3cVZ2akh4QTZaM0gzNHA5K1pBR1pIR1Ft?=
 =?utf-8?B?dVgwVEhoQjlZUHQ1RXlWOVlpWU9WMWJyV2VCNW12eUpnSVJPREFvYU9RU0Fy?=
 =?utf-8?B?U2JpQnlzTzFTWXk1MTBDa2FGMHN1OVJmaXN4ekRHREYyVHZxK0s2SG40QnJH?=
 =?utf-8?B?S0dWVzNqc3hIdm9acHlDQkNPWnZqcE1Va2pWbHNpZHYrcndCdFhMOWU3TEdh?=
 =?utf-8?B?dUVmMnhnMTM1SDY4V2lpTklCcFVpc1BhYnV4QThsT2FQb2pDaTBnNnFmY1Rz?=
 =?utf-8?B?Sk5yaHNqSmxwSndOekt4eTc1SzNtR1hKVGVoeWtrcDcwRmhqWnJiaWRocHdn?=
 =?utf-8?B?dFU3SGplOTRyV2Z3QzB6b2NPTGx3bUVQZjEvVmZEc2hSWUlDY3A2STVtdUh4?=
 =?utf-8?B?Q2ZwMHl0V1VmRFhTMTAzOUVJQU1TS041emdpTkJBbkZJcXkxbW9jUHlnYU1L?=
 =?utf-8?B?cFNGN1VlN2hudGVPYUZUNnVTNU1XTXpZNEtsT2tVOEtrV0x4d2xGSlNrZkda?=
 =?utf-8?B?NGRPOWtWem5HNlNJcDlWSWVTQy9rNkxzeDFGVi8rbXYzZVBHbGpoYTV2RFJu?=
 =?utf-8?B?WEFGZWZnZ1dEL1d4dGZXSUI4ZXhwbW03QjBWV0lEY1ZoL3o0VVBtK2RTaVFK?=
 =?utf-8?B?RU9lZkhJSkJaUjdnb3FjcDNlZlg4RUZlem5NbXF1TEhqVmx5VGM3ZWJlWW42?=
 =?utf-8?B?d2JnSkpDOTd0V1ovOTFXMVFpV0VlTGFvUVU1VzhvOXpqdUlBdDdNYWcwaUJR?=
 =?utf-8?B?RTN4ZVl2TVNwN28rSGlIS3diT1hLdjVQZ1B1Y3hKYmcrSXF5N1B2R2I2SzhI?=
 =?utf-8?B?bUVWMURNY1RiTVVIeTRKdnNYL1ZJK2N4VVAzcGJPUll3bW9pY3Fqb21nbzN3?=
 =?utf-8?B?R2pBSEszWFJDN0lUbGNMbWR5Qm5iUDluWkdXNC9DRmZENW42Mzc3QmxZbjRR?=
 =?utf-8?B?SG5pbnpGZ2pMRGZGYXA5Q1FsMFpqdDhLTGFtV21CalFBSjZIWEVYTWlFUjFs?=
 =?utf-8?B?TEtZUERqUW02ck1OYWRFK1FqMzBjWHp6aDl3aHY3dWFFdGJqWHpNaGRQRmNR?=
 =?utf-8?B?ZjRlRlBQUkRWRVU0cGVNL3hOL0x4NWlvN2l6eFlnVkRrKzA3aXlGbVZFTDBU?=
 =?utf-8?B?aGxLOWZ1dHZkSDhvY3FQNDg0VVhKVzdRangwRWxIMCtwMlB1cVl5S0dzUlJO?=
 =?utf-8?B?Vk0yUTRodW1MR3pvWFg2YTRPYjRhMHdmUUJrUlNERmdtT2Fab2dPVlNpbGUz?=
 =?utf-8?B?WWEvWnRXQ2hzUEJYTm9yNlBLaU9rQ2VDV2l3TzFEcXBlYWFtekZSeFUzbXBv?=
 =?utf-8?B?RDAzbVhrQjZNeUMxMFZ1L3F1eEJHcEJ3ZWNQNDhuR29CS3BUOG9OSTNhZDBH?=
 =?utf-8?B?bVpCME9qN1dFRmxLOEduajFkb0VjZzdlKytnTlZ2cFFxaHhjVEduQXdjNE5k?=
 =?utf-8?B?aDIyMkE4ZGhHcEY1SVRvNzZwS3dzcDJpaXJ3TEdoekNLVHo4N3llZkREaWtM?=
 =?utf-8?B?ZGlBcjNCU2V3QXhwQW9sKyt1N0IrNWEraVJiTy9EMjVpV0c1dzUvTkpEbnZD?=
 =?utf-8?B?cnRyV3NyU2l5b2hrbzg0WDV6R1VUYlo4QXRKbDMyakhoN1I1bmhKNTZyNlBk?=
 =?utf-8?Q?6MU4xQwzkFPOoR2/sjlUCSr7Mz1Vc/SDKOj62cJdX4dCy?=
X-MS-Exchange-AntiSpam-MessageData-1: cw7ZftTglABxzYU3yEWQNUZxD7sh/Y6mU0M=
X-Exchange-RoutingPolicyChecked:
	EGWoElOHi154WEynN+YQtm8SK6G4buoubNqlMkP4IoI42zjPQCnrV8a9eFTj1HR1D7EzN24Y6gq/4JsyuL+1ryql8wLP7kpNevW6AcSFMN5n9W16E6VOK0pZGDhJrLfPpgLBfNpOWTGClQ9jjaOmz9yQcCPK3nOMG9XX8TiAQqlsdwQFf/pkzgIG5vtELj6i1G9klXH76dtok8PaeMZ/oFcJ97XJhtbrgOhx0IPpA05jB07nDTycwxemCin1h7oKWBC3tB+gW1x9MEpXMXfMfBOCCiHlq2KzZIrClAgeuAUGED1L2aC0Obf1/oSJeTLsqiCE6XeDu8id0LhXLwrhfQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd7d919-5ee0-436c-e6b4-08de8531cf97
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 21:03:32.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRu1cIXjWZpqJfXlz1ddIkDn882Ugx1C2Xak+cD0xkjIH9ikY3NRrBdnzNbTHJzQDa72t+Fe0YB+UhC5zKwhMDx2kLqPvNoZwZP2kK6MiHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
X-Proofpoint-ORIG-GUID: cJ8XXfVrJiy1fBl5JocCOAB-gQEQV8Tp
X-Proofpoint-GUID: cJ8XXfVrJiy1fBl5JocCOAB-gQEQV8Tp
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69bb1329 cx=c_pps
 a=k7JwuLoshMfzPsPeu96bmQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=TIvJlQMQf6_p_EiZzbUA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE4MSBTYWx0ZWRfXzi8VkTtedv60
 5pVy6lk/r56bWixGubqL3YOQ+M1OGcPfb6PSsss48rJi9lO6sck3yi43LAT9TSdITLW8awF+R6p
 PqjMjt8WLR3p5l94luHsqRPhQvBujVidAAJhIQvNJJ5eK7MBemolRFc5VNwPtppPHnJobbFMFlw
 Q1GXelvqGTv0mwuXyzQPI1MLwagTxS/ueem/UCGvq7yOD5725CrwYwIc8hdGbhmpDQMQjrE+2BA
 FEPt5nE6UBRV4I/ZBYvtH4SZ9brFaqMCEgbeO1CPtUETJcTnHEKG4ULLaEwcADWKF1iwVdXtCOo
 4jy1diZDT5pRB1sBq6WvcGp3LYPwkbWixVW0cGDKLaRjShn+fWNEbiC8kQ3rGaRgZNdDHNWua5r
 oLmVxJykc5ygn3mqYrZLTi0vmWIRxYSmX+TV9qfqBCIUl2RWBd04XfrEcm9QG5hGyVsIKTrZPUT
 XcnRErVYhocuazBzY6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180181
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,mageta.org,nvidia.com,wunner.de,roeck-us.net,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	TAGGED_FROM(0.00)[bounces-227165-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D63582C2D38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

This is v10 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events.  v10 adds a second patch to fix the
AB-BA deadlock between device_lock and pci_rescan_remove_lock that
was reported by Guenter Roeck (via Google's AI review agent) and
confirmed by Benjamin Block.

The AB-BA deadlock:

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

Patch 2/2 fixes this by calling device_release_driver() in
remove_store() before pci_stop_and_remove_bus_device_locked(), so
that the driver is already unbound when pci_rescan_remove_lock is
acquired. Both paths then take locks in the same order: device_lock
first, then pci_rescan_remove_lock.

Note: the concurrent unbind_store + hotplug-event case (where the
hotplug handler takes pci_rescan_remove_lock before device_lock)
remains a known limitation.  This is a pre-existing issue that
Benjamin Block is addressing separately in:
  https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/

Changes since v9 (Mar 10):
  - NEW patch 2/2: fix AB-BA deadlock in remove_store() by calling
    device_release_driver() before pci_stop_and_remove_bus_device_locked(),
    as suggested by Benjamin Block (addresses Guenter Roeck's report)
  - Patch 1/2 unchanged from v9

Changes since v8 (Mar 9):
  - Added Reviewed-by from Niklas Schnelle (IBM) and Tested-by (s390)
  - Added Fixes tags for the three related commits
  - Removed rescan/remove locking from sriov_numvfs_store() since
    locking is now handled in sriov_add_vfs() and sriov_del_vfs()
  - Rebased on linux-next (20260309)

This race has been independently observed by multiple organizations:
  - IBM (s390 platform-generated hot-unplug events racing with
    sriov_del_vfs during PF driver unload)
  - NVIDIA (tested by Dragos Tatulea in earlier versions)
  - Intel (xe driver hitting lockdep warnings and deadlocks when
    calling pci_disable_sriov from .remove)
  - Wind River (original reporter and patch author)

Test environment:
  - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
  - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
    versions)

Based on linux-next (next-20260318).

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/lkml/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]
Link: https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/ [v9]

Ionut Nechita (2):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs
  PCI: Fix AB-BA deadlock between device_lock and
    pci_rescan_remove_lock in remove_store

 drivers/pci/iov.c       |  9 +++++----
 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 drivers/pci/probe.c     | 11 +++++++++--
 3 files changed, 33 insertions(+), 7 deletions(-)

--
2.43.0

