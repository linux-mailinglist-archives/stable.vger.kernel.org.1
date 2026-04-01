Return-Path: <stable+bounces-232701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGBTKU+7zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:29:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 168943752F5
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B0F83035035
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E3329C49;
	Wed,  1 Apr 2026 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4VXqZbo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i+r2cn3g"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2DA2367B8
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024973; cv=fail; b=uMtd8SeziH3YG/G0gdwSk+162d3vM61N8FTVG0Xy8ni4P1CIHMMckPW7BO3sscphRaZ4Zw7hcjHY2laKzlex8aXMYallrr34sWGyyX3Y3x5rjeBemQ7tyebpi4aogFmpQhKU1VlEtmxhmjzwn4EWspXUcwHE5eXUYMN3WHzJgbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024973; c=relaxed/simple;
	bh=YWpacR9I3aHVrla21sZQCczUuB9FEK1ZGEoPFl47sw8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dl0t0yVbNBxPT8Y6QmORW++FmJEIS+I8M642CFJaWo5GGsA1vGR+RYSPgPWKPqko7u0L6wo2noS7t1sXTRtl/3B9dTGMuSxbokfpGtuqoRD5WubsmzaTRcsIoJl1Wj4FO3dZRRpCOQ3ethLMemk1Wr2GJCSKlRk8kiHJzBUViZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V4VXqZbo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i+r2cn3g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311GckP3249296;
	Wed, 1 Apr 2026 06:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LABmBDIrcUqRh5j+a5e+830vsUBgg0Fs2DnMcS4mUB0=; b=
	V4VXqZboTUja80XmurjSpAHUnVWP6J2T57GFS9IwG20H2V+boX/7e2BKb+T0eYEM
	sPZHQiGpC67tWzV/QPIqD24ECm07ZKLmuj6Et5ye9HXgkGr0GoKfxkbC5Oz0Ef9o
	+5jho+2raTU3FxNO5HJ9TSWIqGd/wgeFQY+/yWpE9c13c7xZL8X7ayiwzT/HEW7b
	V8WrIJV3LzHKA/DDrdmWAxFh53fZdVji/9iqA24huP6yQFXjCwFaXyd8qoCGtpcS
	p+/GNEdgvwRD0eeioG2fRVs+pf7a/d/XC1wAC226FR5s0Knc3GU1yFPneq7Btuiu
	ARMZG6S1qhAUTM6+HLoGFg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65s0wuu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 06:29:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6313Z7Xr020867;
	Wed, 1 Apr 2026 06:29:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ehg6cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 06:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsCh5yA/uNJ7+9fBUUnaFrEkFgnaPEe0TV5GzfaagEjEEIin3QS5vWaSRx4+Np9+fbMEVHXIiqODPpP/uOclZrEWeL8w/HUbKMXHIBcydU9Tsot5pV/H4RYKRzw0x51QueodQtVN9CNmHwyyh+bSWw/twn6FZdgaJ+1wBx85cTcCqQHyQ1J8XhMO4M1Jlf88IQ2YZdH0SnBPiX4K6mtTR2rSJBjN19cvJVLnQzpeyLywIS4I+0EwkHPprGHsCuUe5hpQ1AZ3IWqpcj+ZVXpe2rQGDXubler7Utb1mLUayaos9U7Nq2x4K1gGpU9txqKhxvSVDi2bHV6+zy7VlSNXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LABmBDIrcUqRh5j+a5e+830vsUBgg0Fs2DnMcS4mUB0=;
 b=cnSD6sTESFhiVi/W46T58611m634qekrSpn6mx8/UHv6ySReXHmwzcbpdwwYrRpJ+AT0ndPx87Omxg+L8MncxLYX4xT8Rs0wHqXJJbqlEzeaeehgN9lrdz55qU+hppafV4PPdUfkwkCujkIPJcYiyHJWOi9mvy/6iBCOXODE9Vaok/MvIBDS3BxftHn9dGBIdqOXuTIrbI7epd6KuNhcPbaT689g3OooSDNO+StPPqWuW+iUacZTuofOnzHO1b22YHqTp1Tuw+OU5ApJCR51GcarLNnZKIXHH9rRnsQTcNJeMk7K2GnUARnTb2+S/g7wtCDV9FCh6KuTm9BJzsU2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LABmBDIrcUqRh5j+a5e+830vsUBgg0Fs2DnMcS4mUB0=;
 b=i+r2cn3gy6yeST5rZ0fPVOEBR9xiZ/FZidRNr1guLBSKB2snt2RR3bq1qBSUKJbhS8mE+IhTQgDZjyeKjkUAhA42sMLzBH9jltsAP4xHVd8ZF0iU9V/4Kg35UaoJ5/YUWS0cKgFc3jHN1Yx1FIX7wduAQmLCg886cNOyzqSoctc=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CY8PR10MB6633.namprd10.prod.outlook.com (2603:10b6:930:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 06:29:27 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 06:29:26 +0000
Message-ID: <a3c185fd-2573-4061-8816-2762241a4144@oracle.com>
Date: Wed, 1 Apr 2026 11:59:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 0/9] Few stable backports for CVE fixes
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0505.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::12) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CY8PR10MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f28102f-3168-4af6-ccfa-08de8fb805ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/yGwd4Pdr3JFFzEAtplwFadBsPpuPmG5gH3welgWxZYPXvPhK1l+Qsuoe34+2xnFgPU2VptDO/YGZ0xT2lO9unKcKsOW8ISQC4l3ruGFL2ZxOpFRcaKTLuLb7/+ozqwkuHK5Dx4hpcm7LTDqGOPjPjEZTsnSDBy6jZ1wALMxni9V4STXZX5DYZKLaH6zuaz8Lpay6pRvstuyYME4C4oO2M3zGDgSdPpcOr2DzN+h0tE6vx+TEkke2FM4IAT2oOsLbZOsRWPK7www5IJFOlmAxizWfwKN1ayVSuaCIBkSmr+phxW5JWUIJ437ESHEVUW57zSfXj53LFi6jAqbcTpSHDhRS2bBDqbM50rB9FAeAzivFfX+YvvCIirGqFCZtcIsQ+iVOBGXYRoRwz7iAYwhG4v7xOlnv5TODDmSngSkOOPA+fGikeD5B5MT9LLO2k/4APHUcIE+LYi5ZX2aZqS4pt9g/JFekjpFKQ9x7PiSGXF6Vf8hOk7+sWaE98U6fm6nc5JAB1u6dy3segkCmNsPV8N2Qnvcl+iVWGwfPihi+GbCe9zj+gyKJu7Obp+iHYJFyj1AVFJkPgHEl180gVbH5kAuqeUvDDuL3Tup+EUmMuVsccMQV0BpFZv5AESmTphROXX93Nw+2eVHrOQqXLkycnM5x61Zszdj44TNMnH0K0QpxFRI0tQK8gYUwcGnyZL8T8dnqZUFbedkPeCBWTpp3PLQoTLuzyHvfnXst1Z9NyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU1yRGs4Vlk3K2hNTXpUZkxSajhrZGltN05wb003NnQyNDFBRWNpTHpmZldH?=
 =?utf-8?B?ZmxYcHpCVk41YlBGa3ZTQ3I1ejVJamY4OHRSVDJlNlhVeEVoSVVDeDM4dStR?=
 =?utf-8?B?b25NVGlGcHJ3dHc1OFV5akxOTXJtc3FOcG8wT1NzY3BjSTNWQmg0QlphVEdx?=
 =?utf-8?B?elgvWWJxeTlOZFdVaXV4VWxWaEc3Lys1OFRMa3ZsNmJWWi9hTWhPRzNsaE5I?=
 =?utf-8?B?SGY5SUFBcWhJeTF2MmpUaEdQQmpDKzZhaFJVQTNyVHJPazhoSlRENnFPLy82?=
 =?utf-8?B?c2VXaGpFdUJ6YXRXczlkbEZXNzZKcXpaMjNXM1BuQ0ZNeFBCUytYelZiV1VZ?=
 =?utf-8?B?YVovbUpXKzc4Zk03TXZTb285WWZ3bEp1TUZqK051bHErV0hYOUQwNlhMZk16?=
 =?utf-8?B?ejQ4Vlk3Wks3dTRZVk1LMDNYWTZ1SXFoM1NKZDRIdzI0UlMxODFJTHppYUtK?=
 =?utf-8?B?SGZJVnZqTGFsRlZuK0FXVmxHT1pMRG1FRjlxOXVWeDNpenNVaVRDZWY4Tk52?=
 =?utf-8?B?djFIMW5aSzh1d0t3enEweStEUFpoZXJCdDVyaTMxSS9MODM2eUQ1SjBFcEhS?=
 =?utf-8?B?ZkNxUkRDYWZBOGxnK1BraDExYndJc3JoTlJSU1MvMjBEaGVNeWxSRnY2RW5k?=
 =?utf-8?B?SUhMWXg0aFYzaEZncldzK2dKRTBJbmN1MU1wOU9sdWwxTGVHVFlJSURQeFlB?=
 =?utf-8?B?NTFwVW1JQVlzdFU0RnU1U1QzRzRtV1VTdW9CbklXMDJ2cWpGQ1o5Uk0zV3lx?=
 =?utf-8?B?NmkxL1Y4ZjBXbHNlK0xWQUcvWCt1MGFSYmUwbUc4WW10V280NTJOelVSaE40?=
 =?utf-8?B?OGltN2F5VG1sOVJDNXM0VE0zSGl1YnpmOWZDSit2Y3JtbWZYeWdMYXIyd05B?=
 =?utf-8?B?NC9WemM2U1ppUFhvM1BRR1BGK0w5SHo3OWpMY2hkRFpIbEhvK1g0VUZnVm5h?=
 =?utf-8?B?SkNTL2toaXVzNTFUN2NBVEV3M1l4WGZ6OFZmMDZNRFYxSTQ5eWZac0VvbEJH?=
 =?utf-8?B?czcxYWxtREtTYUlDL09kVUpZMXRHa2lYMFduTjhRcG0weHF2VkcraGNTZTJu?=
 =?utf-8?B?cTRFZzFMMkI1dE5jRWxURFNJUWpvMitVZStnR3dCeFEvS3FidE1RUkMxSW9u?=
 =?utf-8?B?MEgvUHA1eEdJbGJVM2loSWtqTGNIZll3czMrMHpxTENTalEwK1JoTG5nRXVx?=
 =?utf-8?B?Mmt5TUpXVHZQZjZPQXRYWThkRTJmTFlqUFIwbU8yWXlUZ3c4c2twOHllTlFQ?=
 =?utf-8?B?a3ZzYjJFNXFlMkhmR0gxQ205TzVvY3pxTm55bzdmd1V6aXVET0d1bnI0OVY3?=
 =?utf-8?B?NE5hNDFnSStQWkRKdmJxNklaOURJdUhSQWJrMkdIQ21DWnpMa1ZIeXlOT2NV?=
 =?utf-8?B?RW8xQkNwczY4V3RmWGZ1aTFaM1Bmd2VQUUY2VkxSK3BwZXVvc21PY1FMcDVl?=
 =?utf-8?B?N0wxL0cxUVhoVUZrUy9GOXdTdTBTWWRQeFJrSzIzelhtVmRRdXdKMHhGZE1U?=
 =?utf-8?B?QW5nS3VCMTBDQWJTL2ZLSzhoQzBnUFdzS1pGZU1rQ3dKVjFYQ3IySW9TUGtF?=
 =?utf-8?B?aTByUFdtSzR0cEt5eWMxNFJHa0FIM0huRFo1T0lTdStQSW5nRG5vTXRRbDMw?=
 =?utf-8?B?QjlSVHJxUjd6VkZCVnBhcGpYcURZZGVIWUVBL3lDQ25ZanRET0xBMWtyMC8z?=
 =?utf-8?B?VFJ1TE5xZVZrNmtqRUUrRmx1OW9DU2ZPck15OVhodFQxSTBsc2dsNytoNUV4?=
 =?utf-8?B?MVVYTlNtQjlJQW9TTk1XRDVWNUNhWENacVpKN1ExOEVCRGdiZTdmdjlPK2J4?=
 =?utf-8?B?UmhsL0NmNDVjS3FUbHZFTmZFblVvbXpMMWJZVW83aGZCdmgvZ0RYbUZOelQw?=
 =?utf-8?B?OERwbXp4cU03SW1wZFpHcDN0emtOaldzRHNwVDZHS3ZYQXo0K3d2QkEzejlu?=
 =?utf-8?B?Y3dRclI5QUhwTlNUVkc5akZyUU84UnI2MWhaMDRoSWlaV0VoRnpKbGkvNTFl?=
 =?utf-8?B?SWxWejJYc09CWWFkS1dqVkRJTzE0b2NIb1lIQ0JwZW5mMXJDalR4OW1HMGdh?=
 =?utf-8?B?V2c3NWpFWjEwQ0tUckRzYlRTNFZKdHpWcVh2RW9LSFNaVUdXUFB3RnhWQTVO?=
 =?utf-8?B?ci9WQkV2V3ZvL3hTMlMxMlVwYXRkTkN0T3g5Vng5ME9jd0pLSlhDc0c2UTgv?=
 =?utf-8?B?QXJBL1pvNkx1VU81Q3RFQS9ad1U4ZVEzZGQ0ckR4ZXM4VjZjY3Z0VkgrQzdS?=
 =?utf-8?B?THMzWnQ2UFk1U1k1Nk12SEZGZFpaYVJpYzlzWWRtRGNzMXB3N3JLeDlmY2d1?=
 =?utf-8?B?SUdndXIxODJkSnNTK2ZJeFcrM01NbzAzSitSbmNiZmlFaGlmZlp5SmdNbXkw?=
 =?utf-8?Q?QkaIoHdzzjqBeVnkr8tBDaIhHVe9X64atrtqh?=
X-Exchange-RoutingPolicyChecked:
	Byum5lL8aP3iS/nJQjyjFk12KLhqVxL46aWZbdZ3PyFGqBOCWPTkDnKRY0rXokx5JF2zqJJJPeQk/dN0b3Rcj3JljqprIixJ1QycPc1ViROGnP/BlJw1tzuK93LMiLKraZiXYbLoR10RjsEQalDW3GeCLSjVVLfhEFLyPYy4ZjrVC+PZsS0kokrXAAOVcUGpFJeGZFOqxDPkj2BTcaeTwcsXYNiTRVUBSixYbHWDa7MvzdgI4MrOytaCqX7ASVHy4W6Mi2IZtsYp0boYk5X8x2djJdomnxvSRA97oTLqeOiOUSLpRqK+ah6C7Sod8D9Rx2oLqCd5q3gxttHCf4d1lA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c4waahQ1nHR7358XaEYhok8i1opnhjsCNdUKLQIIqcmNExAlKpZBNmgZ4LxHsug9RyqaHD+aFyXLaEtuhQd1eBvvVwjhKbPaGdH59NEr5Md8cv/NbTTXsMQQsgujOx91/wV46BvJ9hSJnwSeB2IpngqcgldmbPoumCKy0zZNWJ8qaPRWI6BLy6/SwJxyCmfa4IYfieiLnHIL5uzPubfGyMyapZkybEeP8zEaDZ+ZBNDaGi5QZcyabuur2w3yZWVAOf7HnUdJq8hfXdIfW1Hh3uNo3wkHjWHw4WFzheqw0Yf4dk1jTO7//O+J75cUA7bPwHDxz96jWLx3S0nGtHi5rGc9REC404GRxDfJHFP86UnRZYt0cDTNSYW/HszadcpJ3iILchHloTLuo22QWRpUOfgWce1QStaueYnH0mnC009EZAbUOGCw4fTNTsLohY2tYL1gxaeTbqdcrwim8kKKz+wxAvA6lSAdC2PLHjY01XsYoFAMuD3qeU0KzZfR5KbC0LGEYJLDYze/RsPpQepaytDrsoiceczn/FWw2q2ZEYxqFVCQExFw74Fsf5a8xwOHLHV+QGfrkLT91yw9nmdNLjiTizhMmCigyFD/2lNwHh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f28102f-3168-4af6-ccfa-08de8fb805ba
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:29:26.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAWvhh74lxFbOxrOS/zjiMnxGGyDKlLtreqDqS0hqHBZX3lwFSIXXceppUqwpX1d5XP1f2bi+0+BBnR+yg9k2w6S0T6yOO9n1H8oVkTM4K9T71kyWnpm1ByPTfBE9oWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=891 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604010055
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1NSBTYWx0ZWRfX1Gdv7se1L22O
 4wRxWq3QXKUmX4MROmIIJl9h2/uo3QvjzdiCUmCdxOOfkvipPOwM9dc2nFB6hLgutFDUo0uvBYI
 vw6bhbR/9zhoUBY4cu1Qfz/w6LCmv7I0iHKC03P/KLuXkFvaOfR9qzjDvxUkGHmfZMvmeS3jm+G
 Wfc2xkaIi/eUz92ObJ3V5jvkf/b3gxA3QTGnbj58W7dJRVDhs6xfhKKdN9GkGmDhmjDR6a0AhYY
 PzjcRWc1jEMJUm+GAwSxZDZxfomrYDnlYugafv+w3fwRWQQCopq7xAX011OQwX2INrhOo51Ghvf
 /oBnSxlz60GgYOEeZvT/6k2a1W/8tEYd0T1OObOEkkbhE4HaOQBE4Ldf0AXD3YK5aErOB2OXLWD
 YEoWgY5pzaM2QNJ1u6VY4bCxtknSxY4DrK7nsd72qw/Rqs6aMkYzlly9dK4mmOQY1SBRlXDt90Y
 Vlq1lQHKcjbwLRgey/0GFwtkkidQEFMxmnvSf04Y=
X-Proofpoint-ORIG-GUID: aKbJUudbx50Pe8vTJtLERGNkCHKS_Dv5
X-Authority-Analysis: v=2.4 cv=BvOQAIX5 c=1 sm=1 tr=0 ts=69ccbb4a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=9FdGgMbYGDxJX493XQ0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13825
X-Proofpoint-GUID: aKbJUudbx50Pe8vTJtLERGNkCHKS_Dv5
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232701-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 168943752F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On 24/03/26 19:34, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> I have tried backporting some fixes to stable kernel 6.12.y which also
> have CVE numbers and are fixing commits in 6.12.y.
> 
Thanks a lot for queuing these up for 6.12.y stable tree.


Regards,
Harshit

