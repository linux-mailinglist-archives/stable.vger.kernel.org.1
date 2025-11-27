Return-Path: <stable+bounces-197113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEEC8EB4B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015483A4B24
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22532D421;
	Thu, 27 Nov 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bmX6Lo0I";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="a2Fy3lGi"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4F23507E
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252302; cv=fail; b=jeTE2976xcRaoNbAzdoectC4Iuoo54ycoi/KP8Pzez01ix7xKYLozyehVaU8BtIqfVw1pkJ6kzIYD7eLsdYDTHlxKj8M+Jn8W0c0qhOwcdmdVdGGZcgV+2lu8ksf43OqgRyO3IogaZlTOoEv0be/Ju2GD8c3nBpdUKVQ5qsYonM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252302; c=relaxed/simple;
	bh=YjuLFRCotzfs69wIfioCUzerv3ZQEKRjxFaW8Jhliy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tceS3ix5BViiBPVKTuNJDLBrBZphqh9Cw+rRu6onuWJylAjje1uZB7BUNRBw54sPDdVXq/zLihOM1aDyr+aomrKpw/CeJRzx0AzPsdZho2/CnDhheCo5iAlkClekVx+xQBu48g22v657q6kyMdiy1PvZoanfJOmXCV0Earh9Rew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bmX6Lo0I; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=a2Fy3lGi; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR4mDCO068057;
	Thu, 27 Nov 2025 08:04:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=4puVSGrlbPtHN6lXxrcn9CGAtxc1EUyqLUz+7Yh1goc=; b=
	bmX6Lo0IHwHhxuncrQDPHvXc6er4ZDuUlbgc8HZKe68SF2BYLnLRkiUH62R37Kdc
	ukoE40AKM2naH+OHy1jKpskDlbqvilQOTGkSBGO/Cd986Qn7DYR95NXFMv6vanfS
	XhkPACyqUVxrW7zOIqDVs6ZtkBRUMRS3iVcSnvpoBZ2BrxP7hNMNtFgIZRggUIs9
	qN6C97asmuzB8F/n6lpwHYl0N+3s5g8qxkTzlJ+2rcjIVdR2anWRRkLX8h7+3KQv
	aqCaTxGS2+hI81QAKEmKRa9E2DRv1g6dBSzUORza1wYkd+gVbpQYiUni9PXplxUm
	z496Yjaf5xMxK13WXYoGRg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022100.outbound.protection.outlook.com [40.107.200.100])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4anjw5j8k9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 08:04:56 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjC+SG5nRoM9RVM2GkJlDaIvImFqzVovTgyLc5evXrYTC0On2U37Ko7EmGVoND/FFLF8rfTg+1HIEGRAHidFg9M52cAbpsFUUvm46JEiF2wlkIAEBXFMkENT+KD1A7JVVPAhmXle78OXcTY5WHORW7a/BZ8EtdfZJq9pUVTtsvHSO56oEHl83R3wHgROB+rrf0EahG9bQh1BoMLiJZOj8LAnsRLGmLS3akLecpX+1hdB+Jfd1l4xQ/lEQ/9FTXg7pcmaSlbdKG5kf5gPooeJGrBE70RMqr4AfIsMoiU1K3D2sAhCBQ7MD2h23Dtp4BpMHLwpuYICgVNTK3Na/pul8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4puVSGrlbPtHN6lXxrcn9CGAtxc1EUyqLUz+7Yh1goc=;
 b=Qi9+LxUtlCiGCiyzVc0CfKliOAGYr0sozmfR/HV7l588y7gz5x+KVffw7hutSwD7wj8oAl4UlVtgUH/zS6KQigMLcw3IwjYgwwnQ6DkfxaN8Otyjx/vUqLFGPhc6dKOnICh6fMHZFuqJ2nAaoY1BX7ZkjbBCl56m8hq+FK5rR+F1wnL6mXGDkDWn+tUsQrR4HLtSDEltwXf7If5bQy0BX6szXDYDPWBRLHxw6z6c5qkc3HKvroKC7UUfzQB7U4BTRLuuteBsZqZAPLxmu7inGjIpQ9FjesASLGz2huIzrnFwCWwF36jo65yADe6wxquPeJ0RZgyVmmvE7+DxOsdERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4puVSGrlbPtHN6lXxrcn9CGAtxc1EUyqLUz+7Yh1goc=;
 b=a2Fy3lGih5WKxhs2BvPLezkafz/MN+mdzQhXhZ5uBNzMW6Yg9yLpb6dXXpMdO09ca16qMJRhT5X7R4fYD7JwnsmQoBeQXtiHwpBitCX5FpRvQqZjv+WqwPYHKloUdy/Ki/wHMWT/0OkBLN7xoteVVToE86MyIbqvGGSErN0nT2o=
Received: from SJ0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:33a::21)
 by PH0PR19MB4807.namprd19.prod.outlook.com (2603:10b6:510:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Thu, 27 Nov
 2025 14:04:53 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::f4) by SJ0PR03CA0016.outlook.office365.com
 (2603:10b6:a03:33a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Thu,
 27 Nov 2025 14:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:04:51 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7C60B406541;
	Thu, 27 Nov 2025 14:04:49 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 660EF82024D;
	Thu, 27 Nov 2025 14:04:49 +0000 (UTC)
Date: Thu, 27 Nov 2025 14:04:48 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
        linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <aShagMFXfpIYyJPO@opensource.cirrus.com>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh>
 <aSWl95gPfnaaq1gR@opensource.cirrus.com>
 <2025112757-squash-hesitant-d8d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025112757-squash-hesitant-d8d6@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH0PR19MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 501e719c-3304-426c-e935-08de2dbdef3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejNNb3lwNkNINXA4NHFIbFo3QzRSYzBWd1FDN2I2WUxOMU5BdDdyWHRPakJC?=
 =?utf-8?B?d3J6ZWo5Qk5nWTMzb3NzbDE3clA5K1A5Vi94Rmk5VWhzdEw1dFBZMkFGRjJ2?=
 =?utf-8?B?Rjlra05GZ01GV2VWdDVKR29wYS94SGJvWDlJOEUrNFVVYzdwREhoQ3A5S0g3?=
 =?utf-8?B?VjZpQVRUQUFEaUoyN2R2UUxpSmc5aWN0aEx5VFJEREorZDlnZ1BrRERvdkdh?=
 =?utf-8?B?M0dhZ0oyTjRGRkx0WHpGMXQrRGFvelE5T2pSZFdWQ2tBN0J5aUc3U1RaMEc3?=
 =?utf-8?B?TXdZOTlDb0ZMNFYyMGhOdlA4d1doM1dxck1VL0FlTGJHSXdzTk1VSTE2K2xv?=
 =?utf-8?B?MzJ2UU5yRW1ua0xhZmpVUjZNclVuWXNmWm5aSzdzODRnb0lPWnlubEJDY0FE?=
 =?utf-8?B?ODFSQmJoTUJmM0ZZU2RJeEdzelIrelI2aGZEWjY1VUY4WGk5RkJNYkh5SmVo?=
 =?utf-8?B?ZkFQWWZyVWtFTThVUHdPaXBYT3Rxc0JaVERwa05DUkhHYWErdk9YT1VkK1NL?=
 =?utf-8?B?Tit3RDNsVkxpa1daZUp1Y3JybXZnUnU2Y0RCSlhDeS9SU1hzbXJxbjI3cC9B?=
 =?utf-8?B?UGdQMTVRSllxREUzUG5WcFB5R0wveERCSGY5WE5ML1BtT21jYjAvOWRKTG4x?=
 =?utf-8?B?Y05mNXNtTVo3S05zc3FFcXkxMHRZa2FQR3lxSHU5TldKV1BrVWxadWRLc20y?=
 =?utf-8?B?SDVsTW9nNHBmZlJXcXlwUHM0MXcwd0NUdXlGNmpESjFnNW5vK1ZYWU54RVFt?=
 =?utf-8?B?Z3pvOGxGWUU0ekUvZ0N3VGxOTVgrelNWSDVGTGUyUDNkT0FOUzJwelZEb1RC?=
 =?utf-8?B?R3dMd0pLa0x0eEpSTzdWMlJnS2dSZlZlM3FndDJJWFgwb1N6N1MyZkxGazU1?=
 =?utf-8?B?NC95TGY4N3pyQlQzRy85RU02K0w2eXhabFJzTWVuRVhiMTFvNVVPdStOaU9Z?=
 =?utf-8?B?WVNweS92dkt3ZEZkM0U0SnREdURnUzFaM24xMFF4MS80clhJa0VsY01YdjJW?=
 =?utf-8?B?MllLQTcrbHF3ekNWemViMXJtTVVyY2duTEptMThjaHZoai9TZG1tQ2dab3hD?=
 =?utf-8?B?bUJSalZmcStrUG9tVEQ3THIxRjZpN3MvU2xnaXlVekV3T1N1eS9DK0VpaTVK?=
 =?utf-8?B?ZVdubzVkSWpTc0Z1NldsWUV2RDZFbFZ1TmpkRk9mSVNzaEdWYkFpTHZMOEVl?=
 =?utf-8?B?MmJURGpuczEvTEk3aGsyNVFOUjZzT2VtTjJTRWlwRUEvVjl1RlEvczR3b3lw?=
 =?utf-8?B?NzZvUHJteWNlb0JwYmxPS2pmS2RLUWluN0V3QmlBZ2RUc0tsa1dCcjNZM0pH?=
 =?utf-8?B?dy9HOGJkMGY2NGZZcjhjUzRWa2xWVUpTSFRqVElNR0dsampXRTI0RXIzRWtT?=
 =?utf-8?B?OGRJbGlHOFJjYSs4emsyVmE5K1VES083RTVwcWFWdTByTm9jdDNxUEpjdkRL?=
 =?utf-8?B?c1pmRXhzYmUzT2Q3c2k5eHIrV0hiMWM2V1lVdGQ4VWZDVnFoZGhVaXhZOFMz?=
 =?utf-8?B?TkhjWUFiM0NXVWdESksvVTVueHFVV056MXB3bFlMTEFDenA5NmJxdVIzVkJO?=
 =?utf-8?B?TjdhN2VsUmVCUmp5b1M3NkhYZHZpWkNrTTdFQldDTGdZMEhMcUtOc2lub2RV?=
 =?utf-8?B?ZXI0OUJlcU9RYlNyZzd3Nk9jemVPZDBLL0xSVGFTNnNZbkhOZjFUQVRkMWZv?=
 =?utf-8?B?YlJDbkcvbTVlQkxwQ2pnSUNUSytsdjFxQnpxUXpITFZnM251am9iaWtONDh2?=
 =?utf-8?B?cXFITW50cVJnNUh0MGEwVjIwV2VMNEZqWUY2TEsxZUpBR1UwTE5lUU1KN2VU?=
 =?utf-8?B?eUUxbEtGeGxPZWJUNUh6K1YxZk9BeEJHV2dyWVJFVndlR3J6NTlDdnh2YkY4?=
 =?utf-8?B?Rit6YVFzQVVZUUgvcSs2aS9TOVc4cS9MS1RmMlZYejZscWc0VmZoU3lYOWdm?=
 =?utf-8?B?WUU1UlNjUUlJclNvSHJ1THVRbWw3TURHZHorQzg0Nytpcjk1NWQ5QXJFaUpD?=
 =?utf-8?B?Lzc0TS9QcTlsbUZjSktqTnNRQXFmZGVJcWNHMXhkNWZITnJSSlFsRkVnYTBo?=
 =?utf-8?B?NXZnTjNLTnBlNGpyL1lpZ0JzU1IydTRNdVZ1MmVSWjBRRlpXYnJWM3Yzd3lU?=
 =?utf-8?Q?ISOw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:04:51.5386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501e719c-3304-426c-e935-08de2dbdef3a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4807
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwNCBTYWx0ZWRfX4+9E4El6l/da
 jBT8sHCFsBmmBKEpmMrqxOo1JJaUdJiE7UgYaceutMrV1E2hzOXkNbtN7iDoipUYg/bRkiHt6X9
 z9VRK5acLBQpP17j6sV9iqYnWAUqL0Gn5jBlE0uQC8wiUJm/JC5Q9uJ4/OtcJCrent106A6CTMc
 sFI5/QVvdVze/AvLIe34AAfNZxMgE3C7gAFgMnWnV/HinucNjTyeAAeo3P6qWML6cMjbF3ZNLNp
 cUj+syaOG+TQhbNbu7KBfW3TLRDRcE89yntfcHtoLsxWfsFHRPpGvnckGMIo+kXOF50YtDX8k8Z
 MTRw2zfFPUsZuDT0pa7fe2nq0De26qoaUZSKGUp3+0zMH3CEQ5+YuYZw5YERdZU1x6tvGpZma9f
 s8iqySZXrR8snj9/15W3C7+SFbVBpA==
X-Proofpoint-GUID: Sz2_yowIwwBIvvdVvQAXnhuwtGwpR3Yr
X-Proofpoint-ORIG-GUID: Sz2_yowIwwBIvvdVvQAXnhuwtGwpR3Yr
X-Authority-Analysis: v=2.4 cv=V4JwEOni c=1 sm=1 tr=0 ts=69285a88 cx=c_pps
 a=eFEjX9j3IP+CJDDqlGDD1w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8
 a=v_9_oMGvomznD_UxTaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 27, 2025 at 02:51:50PM +0100, Greg KH wrote:
> On Tue, Nov 25, 2025 at 12:49:59PM +0000, Charles Keepax wrote:
> > On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> > > On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> > > > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > > > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > > > > <ckeepax@opensource.cirrus.com> wrote:
> > Do we have to wait for the fixes to hit Linus's tree before
> > pushing them to stable? As they are still in Philipp Zabel's
> > reset tree at the moment and I would quite like to stem the
> > rising tide of tickets I am getting about audio breaking on
> > peoples laptops as soon as possible.
> 
> Yes, we need the fixes there first.

Fair enough, but it is super sad that everyone has to sit around
with broken devices until after the merge window. This is not a
theoretical issue people are complaining about this now.

Thanks,
Charles

