Return-Path: <stable+bounces-233358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEw2Oo5402nPiQcAu9opvQ
	(envelope-from <stable+bounces-233358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 11:10:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454693A2770
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF48300C92B
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20BD31987D;
	Mon,  6 Apr 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4bgtwb6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CsfJ4OMf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C53148D9
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466607; cv=fail; b=JbBW7cmC2M9r5RvM1rBKcPjJNHyoFzpL9vwv+tC6IvM6NEubdkcEM3y6N74hVEvleCBcFWTY5WPpt3J7jhO6XQPLdRCW6CuWbvPrQyQ/i5YXw0toQGCuhKUuqbMl4uh5sbl+xw8X/ikUnRc/iNA8f5mo4zT7iXCprgrOmD4PmME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466607; c=relaxed/simple;
	bh=G90nvyDqmEdH8B+2uhYjhHofl9Rvf80XhwFD5GVhmZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lb+rPQrpwJernV6OBVZDKS/m4J3eR8/ri22B74JTqxmhNdifwwMG4AjH34fBSPes5NhutdDJlkNUWKp2U9WNlNJdu/aopOB7ozwfaK1IgOGTqH+CnD/5taA/a7FiHNk0EaMQkXBKH4V/+jUKH6PJr8HJPGMg3yyJNHHL3kwD9Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V4bgtwb6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CsfJ4OMf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6360j1GD2467359;
	Mon, 6 Apr 2026 09:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DvQ4N+7OuFCTygLaxlBPWBYwIz3Tg4b0oyGKxQLyg5w=; b=
	V4bgtwb6jcGi8vrz4KHGe6cBp3XEdg7qzADT0vLFiF9vMBsaX8Yk2CQ6lUwxqzDE
	OvcgUeqrnkPKfx3KK5yuXEh7WMeHN/m3g8AG77KH1aJZMiLGoDlnuTMp45YDG6Au
	SiQlG4PPyVqgM/TeWNnvpa9Bz5So9N8SH4z25WfWP8P00A7SR1LoAPbQjMtNfckS
	CA6xnimrB9/Z2xhOYIhKgkeqap2nuXmXDs2F2aT/sfv4EtTJL8H+lr4phpnQTf5z
	1qBPjdI4tM3I56+sUxjWmcpExdue+IjYIfuCs6TqgsaNsi5TIPqF1ybNNeOjv6IG
	xyhB2p1A7sIOGxNEz0ORjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4das2a2heg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Apr 2026 09:09:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6368mb1I006454;
	Mon, 6 Apr 2026 09:09:39 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4das37tt0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Apr 2026 09:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/hJ5L8TsF59AazhlLd+Z6jUbUEIcGHCGT1YpPZr7pj47S2Vci4dwdVlu8LjNUXEwh7vpVAYtWydZkIAzNnJ5abS96h7yWbka8bhgRbEtt2IbCjbmZ8PdFgM1dMYnyPq2Vp+ttPMLb20bhFCxmnDvD/9+GSI2hQGrGTEAm+JN1Tn3p+DqEXqsYrhrSUWJXqWNl7roeC/eioROVotHAZDKdpi3hglid0/TMs+wll6WnjzZE4wBvvRde93sYCKnLGM8wzOQHSSSzitRVDM5Z2brTqXwzSl9bQlJ+Diaw4NWwS5OHYyovj9yChdMK1zUrcWpd0UmJVRbiB7m49RH08hgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvQ4N+7OuFCTygLaxlBPWBYwIz3Tg4b0oyGKxQLyg5w=;
 b=yqGyXwuuN8JiTxOLsCj37tM+BuXYW+nRWBhoYAxrqRtyC9NzDarht9ReuRrxT0QBsXwlWT0D9fl7P6OqlS1GK4vHOs8pkWhKe6xAW10xd+0VdCR+0Q0aNAwJP0IO+gHfUNiBPrU24BAo4+Rdr8t5YO+YNR/2ypgU7tJeEjR7vqmyTO2SJ5U1CTQzGz7LDjIFmefG3dcn2kHI+4q7S/Jhv8G0KF9fyxwjXZPxlQriQNrFC5VgTXy5S9deu5f2w5uV0iHgz2kQbrBlYFFKOpO7mjt/CjJjz+2GfG5RBUEP+Of2hfJm2OWvOQwAdUAd+buS9gUARedsbYpnNk8keceqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvQ4N+7OuFCTygLaxlBPWBYwIz3Tg4b0oyGKxQLyg5w=;
 b=CsfJ4OMftR3T2+fmAerX58wNLtELsnHgcAl1FZFWA23puXJ46oDbbHnA3cdaytqHD+300gT72l/IKg6nqDAxgIj/k/J748iwPB7N9gd4wBFDxPQHEU0fCeLagolOnuSxSN5cvFkau/BA1AW6wzT6WIcfWC/tBvtVKDMnd93+4Ec=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DS5PR10MB997731.namprd10.prod.outlook.com (2603:10b6:8:343::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 09:09:36 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 09:09:36 +0000
Message-ID: <b8c15b3d-8689-4dcd-ae90-edd0cfc3ebb8@oracle.com>
Date: Mon, 6 Apr 2026 14:39:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] nvmet-tcp: fix use-before-check of sg in bounds
 validation
To: Cengiz Can <cengiz.can@canonical.com>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, ioerts@kookmin.ac.kr,
        sagi@grimberg.me, kbusch@kernel.org, linux-nvme@lists.infradead.org
References: <20260404212336.1808498-1-cengiz.can@canonical.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260404212336.1808498-1-cengiz.can@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::9) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DS5PR10MB997731:EE_
X-MS-Office365-Filtering-Correlation-Id: 125b8d55-778b-464c-9b4e-08de93bc398c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tPlYUX3ueScz/4Rj5pfCPLLQ7XNQBlPyrZtp3UBWHu1DoVshzBqcpMzEZf1EjfrsnaHdZ2qKcIPGVzmgrGhuLfgd6TAesXZZXyhBq3RUDM4P4gSC/fZ4YYgcr5l94Arcf6HoHqUHK/YLMo30oiDbEtN+RA9DLmjMgi3XVPD5xSXPIXhLwe7Cl11x0rqi/EPVM+HnhMAnVH+iSLUaOuKMHfab3Xx/2kGVdtViw1LaF1HdYTqz5Pjs4sgO78/muxGV2yLKGOrKt4k5U8yAJ5hryGzln7Ob8lGscXkGtPSxEhElCy9rO6Qg3VO6JTqJgYqDs+sPCoUsSSia5XHS342q7m8yT81f4IvEIO5c+DZbr0pay3EQ5D353JuBTpLmyLz60uAUNEImhRxi1rfCmfcGnYUivwzNrJZQLrHr8DGRW3ZA192gd6rVCzdjWie83d0r8QAuio0/KiWczgEsxlHWakEp2mthbrdadk5+64oB4RHOKQUvr7zOGViG31hZK8YOU61Hjk+ajmIO9CMN+HrZLO1MjJXR54RWQ6EPRS3PPz3mCZsk989Z5oe6k+7Cb5ltnzMi+46qRigeO2uH7lB2kL+XhinFf/6ABfbIZjs3vPVzlqm43NIk5oc0vAUBxeIUxDNARyg5TGS2OYVXIADDbBCOsOOX3LthdVTvovJ8OEDSNOD3heCRhCx4FXRPaoGh0dCUEul//+Cr4gdNPkSYpsujD43HRklYBJ9dMkqyXzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zy9ISXR6dFNHbzBTTTZ4ejMweTJZUkxEVFpGeWQwRHNuQzFUcGFnMHlZMERj?=
 =?utf-8?B?NHprdm1KSGZhU3dwRm1vN1pYbUNWOWtuMGJWVk41c1VDSGFYWWpGaFpUcTg2?=
 =?utf-8?B?V012SmMyRlFkVU1kZnFIS1MxZXo5OEdCeTdhNW5yY2E2cERObkphU0FGL3pY?=
 =?utf-8?B?dkhQWEg5cDIxa3N6U1pFK0UvMjJKdXpvUkhtdmowMzlEWWtFMEN4NWQ0SVlU?=
 =?utf-8?B?WkFicHhZOVpGL0NadTVyYjZyaklOUGpleUhBMlZ4RThlQ1lCeFlOZ3hJN2lF?=
 =?utf-8?B?UHdJSGZYalVDZEJWMDJjREhoLzUxM1gxMGVXaXYzN0dWL0JwV1AwVE9uL1lK?=
 =?utf-8?B?dmQvbDBqL1BCSml4U2g2VHVEdG5KNStvc1NiRDEyV0hYb2lWT21yQWR1cE9s?=
 =?utf-8?B?YTdweTJHcmFYU0YrL3M3T2VHdVc4QVl1aGhaY1JMMXNJeitNT1BaL1BwNGJH?=
 =?utf-8?B?THpIMGtnVG50WHd2ekVHYUszQThMeElrKzcxRHZ1MnVNY0IzUDZja1hsTXdI?=
 =?utf-8?B?Q2pLeGZCcEsrK2RaVVArK0lRcEp4aWxoQ0dSSXg1SmV6RzhPdm9QblQ4cEpC?=
 =?utf-8?B?YzVHVWFxcXJ3alFpM3JsazlReWNVZGVQbWw1L0QvcFBKejJXN1VzSjY1TTRR?=
 =?utf-8?B?c0VXTUp0VnNzVldLVEpTUFVmaGVPL2E4OUNxbjhSWnZxSVF6Uzc5dytJU0U3?=
 =?utf-8?B?b1lhcE5MbzJZSW5XOXB5eTJCZnNMSkliRlJwUUJYZnNUei8wSE5QdDN4M3Rw?=
 =?utf-8?B?M2NqUUtKTG1obnpIWFhZc09QL1dqeXlWN1pXampFbXNwaVNUV01pbC9CME1z?=
 =?utf-8?B?OUorWURUblUrZjJMSi9vaEc3WWFjbHRNcnIzVzZ3L3RQdEhka3JNVFZsNFZ6?=
 =?utf-8?B?MGx6RTZPank3ajJ1WkVPcVJ5WXFFaVJoZnNSVnFFUjJKT2ZWOHNtaWc0RXRI?=
 =?utf-8?B?bCtuNVBiUXBCL1h2RVFNUGFSaWdvN2tFMGY0UTFZZHduZjFsL2laanlrRFZM?=
 =?utf-8?B?c29qUUZESUpCdTFOSThpM2hweTAzNVFZR3U2Vms3UlMrQmdVVGtleEhXRHN0?=
 =?utf-8?B?bFhHaitlSDVhTUFMR2tFQmJxZWFkd0lmTjhINXEvcFRQOXRPbFk4bzNnbGtY?=
 =?utf-8?B?cWEzSTZpc3Ztb0dsM1VFaWVzSlV0cXR2aWFYVTFYYXdkV0dLMlM5RDI3S3V0?=
 =?utf-8?B?OTFRRnVtZFVzTG5JZyt0WTFyaTVPM3FvRU1KY0Z0SVBtcUhCK0dPNW9oVmZr?=
 =?utf-8?B?bWNZVkxvNTlGNk8yM2VGMDBwZ3E4c294STBFUElTRUxlbUtXakQ5MWwrSVAv?=
 =?utf-8?B?YWhzeko4bHB0MGNKNzVZZEZpR3krU0VkcFBOQlBNODFWM1VGK3dadWtPTWF5?=
 =?utf-8?B?SnZTTmdNckhtZVc5MHBqNk5tdmV3WnhybnI1cHRQUFNUN2FVWmpOamQ2bmFl?=
 =?utf-8?B?ZGdmRzRIMlp6a0NRSkNXZzIrME5JM0NNOEl2WFlTN1IyckFJU3ZNTzFrNTIr?=
 =?utf-8?B?dUFRTXZ5OUUrNEJRRmRIOGhUSnJpRm5rZmFJY3BCWG1iRWkxbzkwVUtuVy9x?=
 =?utf-8?B?UWZxTUZDaWFnaUtsdUZXcmN5dnRCVFJ3WXRHYVVCWkM4MHVwbVBSN1E5ZXRF?=
 =?utf-8?B?TEVxWHA4RzliUGlwN3IyKzZ5c3BTbjBTUVZXS01WbTdqVk9GWkFSMWlYRzVh?=
 =?utf-8?B?TTdUM2F0UDhqdmFiNE00S25DWlAxYUppbnExNFhCMTBtQXdsVzRtZGZhUmFZ?=
 =?utf-8?B?UnlQaTlrSW5ieUJPNjhMY3R2R21sT0FYbnJOVkx0aWRXRFh3OHBMcjcwbnA2?=
 =?utf-8?B?OU1PUVVyMVA2a2Rjc3p4L0JjcGlLc0FEZTNHN3BDTDJ4L3k3SUFIMkxNTTh0?=
 =?utf-8?B?T3lQMFB5TmxCWjNSZTdyRWd4eGN5a0EwTzF0U0JOMmFCdkNCS0pzTUhZZktY?=
 =?utf-8?B?b283MmY2TUhHVllTdVJsa2JNS2ZFYW1JZE5nOTExeUoxQ08zbnFQZ0pxVTZv?=
 =?utf-8?B?VnJlQ1VVeEFYVCt5RkpFLzJmVkkyU1g1cUtIZ01SRTJqakVRVHg3MEloZlVQ?=
 =?utf-8?B?bGJFNXFCbjU0WmhaWEJ4dk5saXNOUGY2Qm94YTNHditvUmpScXlxdmRyQ1Uw?=
 =?utf-8?B?M1BUcllMOUhqK2lUWmpLTXJaTnpFUWxwS2xyN1J6b2Q3REI4eWdmRitSa2Ja?=
 =?utf-8?B?eVVyaTdXRk1lTWtlQ1QwUTF1N0Q5emYyYm9paktGaS96TGFuclNwalpQTHFI?=
 =?utf-8?B?K244Q1pDeVlHU0p1ZlVLb21lbkxCOHdaa2V0Y0RhbThHaTNFa0VBVTFLNFJ1?=
 =?utf-8?B?WStOdXA4YmVZOWJ0RlczUThoQWtiZ21oSTVraWRuV2c3TmxJeWhGaDNiSlRO?=
 =?utf-8?Q?bqV1vm75CSwIGVcdl8x9zrinM8Beu6NYn/GsC?=
X-Exchange-RoutingPolicyChecked:
	ZH3cLi4pQubbr0WNdYo7ImxnqzGaDP6+ohLTDq89bmznETYziZXrPyXdjnhgQsp+cnHGhQwpVq6lICXNyyK3lstbLMqUoUyRic6ojhaIMQftDPo0uSHqiVcOO7u6YOe5FzOMqrRAwktn52c4Ucwqa+CyfHWVJmqRXTJDv1jsHrNdVfLIs5MRh31cc6VhNwvk3g2tIJ3cVGXqc4DwijUB/ZkPK/UuHkUL0W/aQ2ubjYp+FWdef/6/M+McZAQ+fOPmSwoyg8jy7kiknH+dkLAGSoaVZ/AUXh5brLM4YNgADdJ3ZQWRO3m5RuZtxn3XKCY/J+4+1mzTvYAiIthrQf/3Ew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zy1f8ADwaH1SmXHX+FX+Jln5sfM2iqwLJhkOqEtRNgFJvvspncSERka3L3EgMtzw783ieNr0CkCHQbI7+Jg/K0SpLJt1Cp8kghAOlRUfiIM7lcCROWfZoL8RuROZH8S+GQX2ylyEivcd1QpX7XfOs0h4eVDwR/YrVynkxQJGDfgifyf5JiQwJAvbuYpOiL8enfyleORnbNRfmNr4bECqemWiCkziXh5CTCqMu2tsLv667uxuFAWdGjPQXONA4JrSqoAf7AwblJNmRzCvjfnD3IZ4LO+woQZnf7CbWOF+pO6kTd/qu08O6FMMbozTogBjreQHTEU+s/FXFjz7ToJMFX39HBZ3Y1aCPbyYpRiH2uYy+S5UhVzw3vuhAMT/2O9JLYpGmH5hWPZM5gJG/0aGNQU+Uf2QII0NPalNJvKZin7x1E6iGkKC8w70LRv55acZZ7rMuIOCndE4de6pXOtjeCdukBLdhLofjl3DcWJCK3UcmzSi8gSfpAWN7MSc5HNicZN/aIA5nHLRuFA/zB4EhyttAzl+B3wDfCNliX64Q36dpj7jC8+wXW9tYzpnYLcYdQNOcnZ9FHNpmETfoPQ1GEd/vNpJVWlwQCup4uscQrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125b8d55-778b-464c-9b4e-08de93bc398c
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:09:36.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF1Q/MlhISR5JR2yVC7qPUty0r8PTNnLxpYrv9HLQrXlGWExAJ0dyU7mXgnPKElSNuGgVz8ILejBr9KL32wvNsG5n87B4O7hRuI+c1NrQyqLj23Yx574X/8sZTlg+o+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604060088
X-Authority-Analysis: v=2.4 cv=Ou5CCi/t c=1 sm=1 tr=0 ts=69d37853 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=DfNHnWVPAAAA:8 a=91BpIpqBps4mUoo_fJkA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=rjTVMONInIDnV1a_A2c_:22 cc=ntf awl=host:12291
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA4OSBTYWx0ZWRfXxrjyIwi0eNeF
 OD2eDpk+R8kDLjWYmDuq4xCN9BschZiDTy92/cvfpN+o1Gs1tTEqD524n/nRWvovRE/ltBwhi5D
 mhJ4PO1QLZnICDQMJwlT+fY+I++KFMNZkHqcEeDKkMNkDa8j2iHNOV1+McvN06X5OfustEm0dj0
 fjrFZz4XhzC2e1jLJ9YKCy0jlPhjTD3Z7dkeLkn6gF4EtIUiUeJWgqeF5tFd9apavZCzr9zzEj8
 xEl4mHvoQIVsymcFAVyFbtjXm+atmODx22KQASzYxQQX/5Yo6fRl2sQU+51H4Kee0M2R518nTHf
 s/jKm9zzZt28dgi34lnG4JN2svowmuYeqZRVthu2y1/q90h3b58RCin3sZHoCRC294tQyZImA8o
 WzqsNHM61XF1hKpnZjWpUNCJwtaR6TpiX4nndRU35d8cwsAMuFB2X+S3FlppPS4j1Ti9nymTOQI
 fSEtteZqxdKAgMssnRGBlBaqDaYuiL6Mdj2MAulQ=
X-Proofpoint-ORIG-GUID: 7jKEpqmm7Qf3KCvE_LlAQCuwPWecIjfH
X-Proofpoint-GUID: 7jKEpqmm7Qf3KCvE_LlAQCuwPWecIjfH
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233358-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,oracle.com:dkim,oracle.com:mid,kookmin.ac.kr:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 454693A2770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cengiz,

On 05/04/26 02:53, Cengiz Can wrote:
> The stable backport of commit 52a0a9854934 ("nvmet-tcp: add bounds
> checks in nvmet_tcp_build_pdu_iovec") placed the bounds checks after
> the iov_len calculation:
> 
>      while (length) {
>          u32 iov_len = min_t(u32, length, sg->length - sg_offset);
> 
>          if (!sg_remaining) {    /* too late: sg already dereferenced */
> 
> In mainline, the checks come first because C99 allows mid-block variable
> declarations. The stable backport moved the declaration to the top of the
> loop to satisfy C89 declaration rules, but this ended up placing the
> sg->length dereference before the sg_remaining and sg->length guards.
> 
> If sg_next() returns NULL at the end of the scatterlist, the next
> iteration dereferences a NULL pointer in the iov_len calculation before
> the sg_remaining check can prevent it.
> 
> Fix this by moving the iov_len declaration to function scope and
> keeping the assignment after the bounds checks, matching the ordering
> in mainline.
> 

Nice catch.

> Fixes: 42afe8ed8ad2 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
> Cc: stable@vger.kernel.org
> Cc: YunJe Shin <ioerts@kookmin.ac.kr>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
> ---
>   drivers/nvme/target/tcp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 8f7984c53f3f..c6cc1dfef92c 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -312,7 +312,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   {
>   	struct bio_vec *iov = cmd->iov;
>   	struct scatterlist *sg;
> -	u32 length, offset, sg_offset;
> +	u32 length, offset, sg_offset, iov_len;
>   	unsigned int sg_remaining;
>   	int nr_pages;
>   
> @@ -329,8 +329,6 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
>   
>   	while (length) {
> -		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
> -
>   		if (!sg_remaining) {
>   			nvmet_tcp_fatal_error(cmd->queue);
>   			return;
> @@ -340,6 +338,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   			return;
>   		}
>   
> +		iov_len = min_t(u32, length, sg->length - sg_offset);
> +

Nit: Shouldn't we just be moving u32 iov_len = min_t(u32, length, 
sg->length - sg_offset); line here ?

(only a nit, but might benefit future backports, so asked)

Thanks,
Harshit

>   		iov->bv_page = sg_page(sg);
>   		iov->bv_len = iov_len;
>   		iov->bv_offset = sg->offset + sg_offset;


