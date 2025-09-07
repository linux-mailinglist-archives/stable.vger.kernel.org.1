Return-Path: <stable+bounces-178031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C159B479D0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB6D189B059
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE762192E4;
	Sun,  7 Sep 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BmdaC5xr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HmkNPDv0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795A13EFE3
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757234214; cv=fail; b=ia09xnD8UHUcQ4+sGlMNlAP/i4TSLHxNXl/AltNizMwFM2Bf06Znd150zrHa6XBevUSjxcbID3vEWtK0GEj+uNyc08azoZee0UKCZe6W9JH7kmhm7YLNtCExcv08RjkOZ8WtamqMeY7vywTJLj7s3rFwtApDo8i8o3k9xW84U2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757234214; c=relaxed/simple;
	bh=YLZ8TwMHbL830qOAUu/RUCRRnJKYQSnN4L1eD+7173I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=An9XgQM6zm+0Gg/YOcLdLcE5lXgkbfk3I/Q2l/ld7dZjYWTSPrmRMgJ+7GtEp0jEKWbE8yaWXRJK07VRom9fqhmajuRa33FT6/a0tJun2CWLoPVU3cJjxe2WtWw8FQ14l/38lLO5xyD4Fo+KDbtCWylyHhodQkBlGLRed2l59cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BmdaC5xr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HmkNPDv0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5877ZPss028185;
	Sun, 7 Sep 2025 08:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2FQrCNeWuyPmVnLnlOgPP4VMJWhBdyDvWF9Xd+E3n4I=; b=
	BmdaC5xrZMirFmLkDjr8L1v4wR0twvoJO/vk2Dthr1HPs3VIgnewqXmqJ1hONLYR
	PNZvWVwB51qvVIy5LgfjSiN1IJOYlRcj+gp4EZ7yNHl5rSR9kW16UK/LJrAPoKqN
	CKdgQXe9Z6dy0fZPILUC5s+FdkOJc/HAnzASSVtzTxDZTWaTem+i4f4lwbjZxDPI
	Po7Hnr9yUBfadwb0kWpsc0FlhWKQrxXGGWzVIBmCVFEQOg8gle6Oq1U82ba0a40v
	nCMGM9Dc6qpgoISeTPYf7ZoHrGCMLUimQC/Ypqb2osji7djb6cE0cNl2jkgO0abq
	oUUWwR+TPBqZUPmxIOds1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4915ser1er-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 08:36:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5873oaNX013563;
	Sun, 7 Sep 2025 08:20:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd7b729-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 08:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coSEonccROkxCi1YcHlhRKEQBWYbwv9aNheU8PhynDTJbUJCizpvhiG6X25NFx1e/MaDrcjFYMq+iqrw3etrjq9CvOMKtSX0XuQ+a/LdQC8FA6+xmAz/dotgi0/aj9xXvhfcZmRjSQOJaxYMGo047ruc/noFj2qH0+GJZOmt00Wrb5/HIZOLg8j3Wjn3bYoDXs56JgdrLCnCaZPKe3CC/TbzrhN21xAYefuG3qcoH05VH6yeRfwdU2rxOwDjwamcCi2sHDfB0QG6LgLPISkGzp6qVvrZAhZ/WYTatw2R46jHZakF0qE2UhEnAod1sfDjhPXrChnEiK9sH3RIY4NCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FQrCNeWuyPmVnLnlOgPP4VMJWhBdyDvWF9Xd+E3n4I=;
 b=qDH2tCC8TDyM68AYZGcRgAo8dM+m6VcM9w3Xn3dDEU9+q4oTUe2qmD5tFv6zRdTBcwj7viBcLn1lJ4UZlCUj6CHj6f9+4Y/OUv6rVUPAQSKJFWRwL/BZt2aG9hQU+305Vvqm5kBoKFTIlS+nsf0CYpJwa0y3QgKm+Z5doLOvm/Ev1Vh8n27EKUqVrsdleHkLWJ7JCR3bZFQgacqDqrkWoiraxooPWZepE0ijBx3dCg23VjMamFYgLQvG+EkhcbJPGnOiC0jxv8G3CKbQ7XGO2OgmBaiudenZ2Bc982kynfX62O9PnwhX6s9GyZL3CRCaeGXuyuEOoEBFqeP+sRdhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FQrCNeWuyPmVnLnlOgPP4VMJWhBdyDvWF9Xd+E3n4I=;
 b=HmkNPDv05xlSIxtgPiv8x7v1y1ipb48yt3b7lH8f89k1LkYdVqm98lZmzI3RlanAlpqDaKsbSLa+jFrHiGOlVZcKMyKdpGqRfqx7hDtBMWVnBfQTmjXQU4X6jjGAju+9JuRJpbAIkVkc1Xv0t1bZuU7SrWwjtTqKs1NCfjoNWeA=
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20) by BL3PR10MB6018.namprd10.prod.outlook.com
 (2603:10b6:208:3b1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Sun, 7 Sep
 2025 08:20:49 +0000
Received: from DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::5e2b:7bd7:5247:ccf]) by DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 ([fe80::5e2b:7bd7:5247:ccf%6]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 08:20:42 +0000
Message-ID: <50f51dd7-f761-461e-9e74-030c15f64873@oracle.com>
Date: Sun, 7 Sep 2025 13:50:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 00/15] Backport few CVE fixes to 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, vegard.nossum@oracle.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <2025090727-twerp-gawk-25f5@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025090727-twerp-gawk-25f5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To DS4PPF5E3A27BDE.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5E3A27BDE:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1520443f-24c7-4b53-0199-08ddede76f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHZGcE9ESEt6Sjk5TW9yN3I3ZjFlUDBkSEtlbGRJSUowV1ZlV2RZSmlHQnE1?=
 =?utf-8?B?ekFFalJxaW9yUUFLS3Bmdy9tOGs0aU1BS2JuRkhSM3QrYkw4eU1qSWF2RXJV?=
 =?utf-8?B?RE1FRTJ6dUEra2RZT0tEaXpJcVBaVldVbWZ0Zk50ZnJ6eHNlUUZHNStLQksv?=
 =?utf-8?B?Vkk3ZVY1SGd2ckx1UFZaM2V5RUtVUTR0bXV3K2NxbTFoMlRoeVZ5RllZU1dz?=
 =?utf-8?B?WVIyY24wVVZGdnYyM2U0NDhJekZUNVdDL0QvUm1lZTZlcjh3V3ZMTnBicndB?=
 =?utf-8?B?N3FWMlE2Tlo2dEdRdlkva2FZTU5QVXJ4dGE0d2FjNzBjMmY3Yi9tb2ozeU1G?=
 =?utf-8?B?TkFHdC8zcEN3OUt5S3JVTCtuQ2RVMnQ0ODBWSWI2OXhpSTFxakFad0gvMVor?=
 =?utf-8?B?SjlNOEJhSUtxa2dZVHEzakNKN3daWTlKSkVmbWNteXZQbTk5NjFWYnlSM3B6?=
 =?utf-8?B?TElsNExUS1VBV1NHL09oaVFaT3A2dmFyaVgxdkJrd05UdFMrQlB0NVBvM3Vh?=
 =?utf-8?B?Y05KMlI2WWFMbnpYRkZIckJyTjc0K1dlK3dZTHJNQURYbXpjY1poSEZlOGtY?=
 =?utf-8?B?dVF4clg5dUxJT0YxdHBFa0xRbytKdzN5SWVRZVJmLzNQQWx2bnc0Y2IxYXda?=
 =?utf-8?B?MzU1WElFSW93MlNSY1RJWE13b2h6QUM1RWpyVGU4WENJWXFDaVZMRWpsWTBr?=
 =?utf-8?B?ODUrNXQzNjJBRDhhdkdUVDREMjBESkg5TlFTNDdaTzZZcUhHaGk1TXVON0pU?=
 =?utf-8?B?Y2IxRWZiajZRRnRSeTI3a0FoWWxDTC94by9Xbk5TOGNiUDVtUncvLytBWGlF?=
 =?utf-8?B?ZkZiWmtBRHVwc0hLVW1HaXJvZVpFME5ybUtUTUFOdFBQbVcySEcreG1mZk9v?=
 =?utf-8?B?NXZjUWhPcTZQdzNqdE1rSDF6dEozYnNNd05UQ0sxeDRQeW5pbTdzUDEycHlq?=
 =?utf-8?B?dW0vV1ZUTlhEUkFRd3lsTU93OTVDbTNaSGk3UERKeGw2Sk9BWTRzU1NXYU9X?=
 =?utf-8?B?amdMUFZITENvelRZZ0J2b2o0bDRXN2RaVlFyYURhcmE5bFhQZG1LbThZRW5i?=
 =?utf-8?B?MjJzY3N3TW1hUDM2NFhiV25hZ0VVSXV1WVd0TXN6ZXB4eXdOSys4bE1yZ3Nj?=
 =?utf-8?B?V2JBeGoxK3AwdHJNTVZtaWh3MStqNDJZcGo1Z0pMdTRFb1BRRVNoMnQ4Q0xU?=
 =?utf-8?B?aW0rV2MvaytydHdYV1Y0Y2dnaHdieU5LSmRhbVVTWktCbjZlSTd4RlU5L0pR?=
 =?utf-8?B?RkJIZ2NZVVNOME9tQ29oZEV1bC95STJxYkpubzFGWVRrNGJ5V083TUlwMHJO?=
 =?utf-8?B?Q3NKY0FFU0FaV01yREpmeGt5TzJHZGlLM2h5L2VGMm9KaFJOVTh1RzYyQUNR?=
 =?utf-8?B?elpjei9kQ3NBMGJMbSt0NFpQWU8zMEpjTjFXUWV6K1F3VVFJL0Y5L2tyNXVn?=
 =?utf-8?B?Um44RXZBOGI1dzZjZjdNNGtsdERWeHVrN1JsdDBVTCsvN2o2L1hYQkdKY3RK?=
 =?utf-8?B?QWYxU3NqYWpMeVJMck9yRHgyRTNVWVF0dlJxR05rOFZtdEVDT3pWRjZYVUdS?=
 =?utf-8?B?cFJtTjE0aithNTN3M0l3Y1BMMlNrbjNSTWJSbXlDRGU3eFc0d0oxMS9BTy9l?=
 =?utf-8?B?NXo0MjgvaVNJdkprTjRVdUE0bjRMRTd2OVpFVjNzeWFOS1YxaUJZaS9LTGNw?=
 =?utf-8?B?MldBb3R0MW9kV1VGaXd1N1oyTFJ5VW8yY3JZVXc0b080OXRNY0ZsdkRrdXhv?=
 =?utf-8?B?MEswVUg5K3dLem01Ujdld0k5Qy9OZG0rQ0VFb3NtRjB0c2xZTERzQ0dDUHhY?=
 =?utf-8?B?eU5TaTlTRHNDc1N6OWFTRDNoY3p4eXlXaHNKRStxczZ3RTVSTUl4OHd3NFVu?=
 =?utf-8?B?bFNVOUtPOXNjRmZkdDNjeGFiZG9EWkc3RGdPQUcvV2sxanJLRkZ5NzFOdTFD?=
 =?utf-8?Q?OVyLnB98TnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5E3A27BDE.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE55NlZ1azU0cVVzMGJid3FtTXE4NEsvMWZKSlYzMmtvdm9wVE5SR01iMjB6?=
 =?utf-8?B?c0lmdTNwWmp6ZnRDeURDN0VYYStZaDViZ3IrWUZ1OFFScmtvdVpOK2tKdEhB?=
 =?utf-8?B?MEJqcks4UzBDTEp5bW5HNTU4OEFoMkNzMGJUVWtaandUWDdMNnovVE0vbDNy?=
 =?utf-8?B?ZjcwMG43ZWxLeEtPZjNrRU1ZNkNaYTlTSHRnL282dmRKTi9ZbVd6SXFVQ1Jx?=
 =?utf-8?B?cEgzU3R1MHlXOWkyOWpJMXVXSWlCY25JV2lFQ3cvNE1GakdkdzE4a1pqYmIv?=
 =?utf-8?B?eDZsQklCTHh4bWI1aWJGQTA5cXA4b05mTEdLRVFIbFFtNEpWaW1vQmxzSXF0?=
 =?utf-8?B?WmxBZjFhRFRvVHNFRURFRVhjdzkxaTZ0cUpBQTVrODdzNE56OGRoVklWZXFw?=
 =?utf-8?B?MWhpREd4R0N2eXBXRlcwaHM0N1JOZmxraU9KSkp5N2JidnFhcThLNFlDNGQ0?=
 =?utf-8?B?dkFtalkxR0ZWdmxRcnFVb1FNSkRsSGk2SmFZTGNrQVdTMmVyUFZUWVRvU1Fy?=
 =?utf-8?B?bklhK1Z2bWhWL2ZYOCtIdGxHQjlnY0hnNFhrMUUxQ1NlN1JGQ21LcFY4YW13?=
 =?utf-8?B?STZiZ2wwd251UlZVd29UUmVvSVFEQXdwTm9jdXM1VktNODJwdXV4N2FBQlRI?=
 =?utf-8?B?T29mSFpkUnlseGl5d0tQUFAyc3hUQlBxT0F5U29KZjY2OGxtSWo4MWtuOXRE?=
 =?utf-8?B?M0phdG05NnRVSFVhSGVuUEZoT3RMTkFTbG10U2ozWjZIeGo0bGYxNFpRYUtB?=
 =?utf-8?B?MUY1cFlRdUtwSVR2aDZES2pBVFBGSmdFcm1pSFdDRmEwUC9JeElkazFzQjIz?=
 =?utf-8?B?ZFdOYjF6OWljNmVYNm4rVG1VRVhhck9oQTN0eE1UeDduZitLd055SzEwZTB1?=
 =?utf-8?B?RUVxeExCb1IzRmQydDZOdjV4enVGSkZsMHVSeWJjN3UwRmlCQUNtc2hXSU1R?=
 =?utf-8?B?b2Q2anZ6RGFPVTIzOWtGV2dnaUtyU3Q4UWNUMzk5akwva0dIY0EzNWJsQmhm?=
 =?utf-8?B?aFhHUDRXMXNMRGZ6TEVkNmkzOUdKUFA4OEhTWUQvcHdjRE9aM3F0d0lWT09h?=
 =?utf-8?B?dkNUVEJWdE8rV2x0TXZsTWxTdDRya1lTUE1yS1pkMmx1QUZ0QkNlUGNGZ2E1?=
 =?utf-8?B?eU5jRWVqS0NJTUFMc0ZISCtjZ2t1T0toQm5ySVZrRVg4Q2NQakR4QnRiR3o2?=
 =?utf-8?B?clhNbGV3WGhsL2Zwdk1sbWs4cUpDWUdGdWZpSFAyNitUYWp6R1NSWXc1NVdu?=
 =?utf-8?B?a2M2QjduVjJkcXZRcU0xNUtob1haSmZaRmFhOWZYeHMzQ0RpaFVocGJCc3or?=
 =?utf-8?B?WFlBQ3djdVZJVDF2ZTY2WVh2Z25qdjJkTXRtcys3N0xDU0RTa1hjT2J2UlVw?=
 =?utf-8?B?Mk95amFZOEIwV3Nra2NWcDBOUnBLNlFMblVEdDI4SGhQRU5jd3Jaa053QUhn?=
 =?utf-8?B?Szd6N0FBUDFlYnVVWUc3M2thNEhhU0lJZVpobWY3aTFGdkN2L250U245czRL?=
 =?utf-8?B?R1I0UGl6UFF3NDVHM0k3Qk0wN2VXM1A4RHk2d3k0SDlPRDZnamtnWG1oampB?=
 =?utf-8?B?WGd0dTVPRzFGMGovbG1ER3lSSHNCYm1MOXJ0WFo2ajNEQlI3OE5XeWdYcWt3?=
 =?utf-8?B?Z0dWSmkwSjhEZzlPK1VHT21EVytzakNiWWZhcUQxSmlkWjlmRGpqMXZZeFEv?=
 =?utf-8?B?bHVQSnpKV2lzMFZOU0l1U3NJalhNL2FURTE3aTljUVRSTkhKNmdETkQ1SEw4?=
 =?utf-8?B?MUlXOFZqR2Q2MjFtZmJGWGZFWkpvODM0c3dZMHdtVjdGbUdmSUNxTHZyVWkr?=
 =?utf-8?B?ZkpUMmdCNG96bSttSzIvUmNUL2dOVmtOaWtEVDRFYkdMeXhEYWtrQUdHdFRy?=
 =?utf-8?B?dUs2RUtXRk96WXhnREJKYzZ0KzZPcmVsdEcwMENNN1N5U2VUeUEvMlRMcTM4?=
 =?utf-8?B?dDV3OWhtL3ZVaGxrY3VtOUc5NERUSzJHMmxiV1ZLbUNlclI0eGl2UzA5a3NO?=
 =?utf-8?B?MWZVU0M1aDRCb3VnZDI4Mm5nQ3EwcWdlS1JIanRmVkVwNUFnVmZxNW9VT0p4?=
 =?utf-8?B?Y2M0UzBCNGo3UHZBTkxjRnJvd3RqUk5PZGdUZDVsazF5ZW1VRHZhWklzSVVD?=
 =?utf-8?B?YUxMNE56RTgxaHBWc29qdi83QWR0VkZHTzFHUXF3bTVVMmtFR0pMeXU4NGJR?=
 =?utf-8?Q?fS51GE9DLbsqvWg+j/5JWKo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iqqxpgnp0DtqZziy7U6ppA2zxCc7lD0Q/TX6JQ6Izv9uyUPuX151p0l7obKnWCuRfGAghCXZIcxkLtNVA/k+5IMD47CYhZCMdZfmizaYV6imFWos7ZlpLEdWgvpWSNGlF1CE8hLvLIr6nyMx9kaAhYBuU52tc2WTMphaIMGbIwSQr+bzsPNh1T7iybcOY0DI/iDBSzoXNQYQ71rSboD82UgaZp1KH3pUgpMygNQqMWwpqvv4joOjerhMf/Vl8l85kQr19enNch1+vl0955xj+P3AC/i0adFvJyfBb+/FDRU4FLQt5w0DNxvNudxBNxrlc9lzGQjE1J90VMbmrxs+k+sGEmytSrBL0amGvtdmTSOYSPj8pqmJH2e/vebtOFKyI3tdoG//+LcRQNFkeeqF1++3sjv4SlDlgoa4wyucifiGDW9jN8bLJoafXhlgF8efeSVZ7H5AXqW218nqeXNLZH0jqbzIKl1pdprHmUOvCPX0OCMHR+GqL7sXNB0tvlN+DKGoavFQiLA0bXSeYPLnc69uTv7uvAY/CxkK9IrPxoPHwhdempvyYCHz5oEqmUPdBgyuMUodr5/qz5j0izERAtkbX+flrRC7fqGYl8+F3Yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520443f-24c7-4b53-0199-08ddede76f87
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5E3A27BDE.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 08:20:42.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBacpfD84+u2g51Hofc/hhQX+otl6POIzBYR5sGLtA0m+uNvaS2hgQdV3MefuGTxBaKR490m7CJBpb88yBXcTUJbX4eBgJO7AwNR5qj3ko9urKfQkZ6/EWiqm1sl7CA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=818 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509070084
X-Proofpoint-ORIG-GUID: leGo-n4hl0u82zA24P9iXJT70sLOHqnf
X-Proofpoint-GUID: leGo-n4hl0u82zA24P9iXJT70sLOHqnf
X-Authority-Analysis: v=2.4 cv=K9QiHzWI c=1 sm=1 tr=0 ts=68bd4422 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=rEAv4Lwz60UxF0nLFOIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDA3NyBTYWx0ZWRfX/lwGPd6WTRY2
 5UYSic6BcxH6tG5mVEa2QIdvw3b3bv4gV17JRgiFpJs1Ud1QUCk9abqwX+JrQS3IUhtZN+ux+YU
 g2HttWgorw5EBgwjekNwdOkTRmtDwt5BMq22Vns+4yCbqgCmbtlUXOor4WxG8KirUacF2LVxa6z
 Mesrq7x+OHZlgpfIARvLLPQwCRWxB79x7w0UgPn7gYok6pXdBVH3AOJAVgomjm86WuyHdq1PNsu
 t0rOcIk1JEGwtyjz+riIFCBmoWwsqpKZvPz24MJYKnTVfDi3PFkuQH6AGZE9qH6okrkwd1jH/rr
 xuV/iNSfxGfukDboYIcg5FdOUc2vJ4AFjWr3yVfcp0URIEa4DCK5m+5SSqO7vGBl6qP3nseEtML
 CPP9bGP6

Hi Greg,

On 07/09/25 13:10, Greg KH wrote:
> On Fri, Sep 05, 2025 at 04:03:51AM -0700, Harshit Mogalapalli wrote:
>> Hi stable maintainers,
>>
>> I have tried backporting some fixes to stable kernel 6.12.y which also
>> have CVE numbers and are fixing commits in 6.12.y.
> 
> Very nice, thanks for doing this!  All now queued up.
> 

Thanks a lot !


Regards,
Harshit

> greg k-h
> 


