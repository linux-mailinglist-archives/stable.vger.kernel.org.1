Return-Path: <stable+bounces-169900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE8B294EB
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304011963124
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC8221DB3;
	Sun, 17 Aug 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IsUzFkmw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TaCafIZg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361217BB21
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755461129; cv=fail; b=ndAnrcPRz7YXik9A1SUHb43rNRqiowuozlDDEjWkuXGfQ7f/McnFENBlWKuMQjfPrLRFfjLsFMnjHdf6SYeWXjT2Ggu35445Ay/GY+zmlFojIaQyjHK5GonZ0vYynnggPGcqdynBeX5jm1RsToIWXBIDDJcL7j3Gnd5OEBOiBtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755461129; c=relaxed/simple;
	bh=Ed4nHgmbPOFJV7wQ4wfp6Xb/v7s5uUkB9miyeQyKFbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHCA5j2/27LRCOpOLRHK/5iTNlOo8ozSauTubvyDz5YDkPDXM1vWq+jcu3ghSRf8zaZYZLab2+AJDqPjXqH3xKhFJ5hoYdcNOCNTsC2kzyw2RDspefzb8ncqdHFuQj6J/rifWQO3EvwqSlbPm31d0gnqF2ATq16Bq/bkMsdZbYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IsUzFkmw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TaCafIZg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HFeJot015172;
	Sun, 17 Aug 2025 20:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uUzmb62yT7rcbqgc1rcxBXUirjycL6C0E7IR2UyAp8w=; b=
	IsUzFkmwyxe1WB5zuGruxber8Kb7DmAG5S8saj/MEMUb+IT08Tref2d0hPhzVqiT
	zRuHgV/P4uJzHKH0zzZ8+i8QX7OxpQdjqClimNWCsAFU0sJoTvmtSFMEB2jlxo2q
	zttHBXDNo7nw/b+NPwi/kA5wqjzfN1KSfoLdVjyTYe4WqvqMc6XSK4yRPb/EhWf+
	wdOPMzi50iMwo+xcFvDAZDKQeCptj51qOAnlbsZvRF/xNZZ7brUGPjMxX7pRbhDc
	k8seBVmbRDVmXh0qYVuVQX4sEgkadDW/eNNiE2+PEYFWBjOMvyjFs+/3D2Xa2oeK
	fTCSOVFGTttpXi7egksNqw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5hsf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 20:05:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57HH77TR011691;
	Sun, 17 Aug 2025 20:05:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge8dfjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 20:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8UkWetUjj8ol55hxkPk1KhKgmN9dIEtCt1Zj72EaD/FWiDceFle2DKfvkrLnhngp+43+Um/kxlfyoFQUSP9q4NBocrR5XHLFaLlSyCHgnjcLWhmVOZJWD4Ikk9MIPgGfD5ONoUFf4J4XznxKtMGWG90IhyorplYWxIsssaW+ZukJEsxxKADfVnBJmOlqQSmTqS5G4jnCoLPm9Zb3KjlBcK56IjJQdx1/JyLBz8itbO+OdK8tocnWrOZZveZwEBtUaWWsN10S3ulTk05mb0P8coWZ/Fy5o6f3SQw/4NuU7J0HCU1xsiIzVAmV3u2rJshjcaUmevv+tzOlfSvqq17pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUzmb62yT7rcbqgc1rcxBXUirjycL6C0E7IR2UyAp8w=;
 b=ZPsF269QM3qOE3QRv3kdPkLZ64N0nnqVbZ1HF9KmSyC8VxoR20b7xYduDfYtN8iTwJS0e1yY+c7DF21uJc140qHKnwrR+RrvFHu+8qJ5+s/lUFaB+5oueSUDZL3tIdb9QJYRLN7zBHplnjEGsjJfKq4UJtgwVtQ1k6XdR+gyM4guHQahDd9H74GnFnTSgYthbPOQR7rjFy+3AzSJFAjFkAkSHlOHzUULEgDLN0Y8OOdBr50hnioXiDV/V1jOQDSX7XnlAuhpG9TFE8YQ+vE+k/ojYza4JFd6YiCFdfznvhnCCTOiNlXFO08anEyc5XH7tIiuglgxFVWHW6ECzP+QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUzmb62yT7rcbqgc1rcxBXUirjycL6C0E7IR2UyAp8w=;
 b=TaCafIZg/XO95pQtYOuxl31hJpnYnBMbz/A5jn0YPBiawW0zmDBDDpfYq5pSEBY9yKKJQrGYFnhvLh7CQhZJTJsTNpdha04++O00FrNnvcX8yrBjgO3orN4WY5vkMuPgGiBwdHenyU0VvIv/yONC7dcub/c4J0Af2nCGtOFWl8I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4974.namprd10.prod.outlook.com (2603:10b6:5:3a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sun, 17 Aug
 2025 20:05:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 20:05:19 +0000
Message-ID: <caef2fc2-8e80-4fc8-9e88-f5d030542534@oracle.com>
Date: Sun, 17 Aug 2025 16:05:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: queue/5.15 kernel build failure
To: Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
References: <1f29bdc8-986c-4765-ba82-9d7ca2181968@oracle.com>
 <aKI1SJ6YrFiQpR9o@laps>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aKI1SJ6YrFiQpR9o@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:610:e7::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d5dcae-45c9-43a1-653b-08ddddc9644b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklHaWtxbWdsV1g4aHdpanBzbDlGUlJIREJwMG9FemVRVzNHMm1XK0N2eG83?=
 =?utf-8?B?NXVvOGhHY3hUSzFtMUx5ay9RcFl2d0c4V3BrU0Z3a25lL3VXeTRQWFBnU1FL?=
 =?utf-8?B?U05QejVOY1NCd0RCQUdvMzlBNVRvUW5Tb0xnZWZQc0VKQ01DNzN4TGcrTGo1?=
 =?utf-8?B?K0NKbkFLZWQwOGQxTjZubnRYdkw4SmpZQ05XS2gvejZBYzJQKzFpTG8zWm1m?=
 =?utf-8?B?UG1UWk0zMC8rUk1qS0ltYnQzNGRBQ2ZnbDlsNWVEckNHdVZ1RlFPTlBYZVpt?=
 =?utf-8?B?Q0pld0J5bXAzbzRVbjRTY2d5R0NTOEY2bnRmbjhqTGNKQXhJazZLWHorZWVh?=
 =?utf-8?B?K0pqMUxmWUFTamhGSEtjY1UxVkc3NHJyNGR2RlpKc2o0SGhmb0c5WllSU3dC?=
 =?utf-8?B?RFBOTmNzQVlqMHFJcU4xNDg3V2wzdTEwWnJjL002Y2REM1Z1a29mNzZFb0RC?=
 =?utf-8?B?ZnFyYlVCSUh0YmxDMHNna21vUGV6TUFoT1ZMN2tLSm9GZG5mNmdlYkhSVUxL?=
 =?utf-8?B?UnFFcGxxaUhKWnVMZVhIWG5DeG83RE40cmVGaWE1WUNLcVJYQ1FLRW1pZVlE?=
 =?utf-8?B?SEViTmVYNGhOL3grOFRkTG0vZW5ZQ2piQ3g4SmZDM3RKZ0Y1eVR3bjl0UUZk?=
 =?utf-8?B?TWFzSmRkMi9XUzFBYkRVclE4blBhSVRMendhVjRFSlBRQ2U5Vk9yeFowa3hD?=
 =?utf-8?B?SWJPa3NBSXc3WG5sU05HUC81WERud2llRzR1SW94OWZnWllpZ1luaC9NRWVH?=
 =?utf-8?B?NGpEMURBUTBpdmZJTkRtNHBzaTNpMitOK0ZreVpvVlpvN1R6SnZtR1oySFAr?=
 =?utf-8?B?WjBvUFhTd2gzNVRGUmZsTFdFdTdscDdwLzV3QUt3clNpc3ZFL08yTmJncTRH?=
 =?utf-8?B?cW5sWHZqdzVnQmhvMjdxTEVlNC9HZlhSWHhhbjlPQm9XSXJGWFJBNW0rL215?=
 =?utf-8?B?dnBSY3l4T2dVMFJXcjdtcW9ZMGJ0UnJPTlBpYWg1K2xKanNrQ0Y2ZUl4VTd4?=
 =?utf-8?B?VnNXMW1nbStFSkZmbUREcTlmVFkwYVdjR3FTZHltUlRTV2dJRmtrN2NtbWZw?=
 =?utf-8?B?c05HMktZMUkwNHovOE5FSXZDMVhpVHJyUFAwbHE0bVBCMzhvY0FUMXFwdHF0?=
 =?utf-8?B?SW1odVMyZlBteXZad1NrNVNOcklJU2RSZ0tsQzVzZ1NKeEJLN1dpMjFvU3Ri?=
 =?utf-8?B?dXZFT2s0REc1UU1aWDFXbEFic1ZyOFZmcm5jMlVFV3l3Y1JpcFh4NXhSU2JF?=
 =?utf-8?B?M25WTVJiMUEzZkpidlVmNXZodFpQOUVVVmgwMzFvUEx5N1RJVEE4dWZpbzNC?=
 =?utf-8?B?M0Ezai9UK2ZtamNudEVQeEtTbU9xTTMvbWZnbmgrOGVObmV6SXJYSmQ5OHBY?=
 =?utf-8?B?VlJQM21saEcwWU5WTlZoeUNzTDZLSzRBSW1FMG8zbS94dVJUelArL2xQMTZD?=
 =?utf-8?B?VHdFSHYveTZBNXZPZU1wMjg4UWtETFYyVUg4TjI5cVYrdHNRdTRIejI2bVRE?=
 =?utf-8?B?U0x6ZmxCZTg4SUUzOG9hdVZyckpGbS9VN3EwNHFZbjJVZUY5VllFZW5YRU5D?=
 =?utf-8?B?QnFWc0FwaktaWVZTL2d4anlZYzViUEhCdXRYV2NzMW45UW5ZcFAyRUVtVXgw?=
 =?utf-8?B?blc2V0lxem9EY3hXbkl4UGlLNXZaR3Z3MmkvK0hIQVZJVCtaS0UrQk1DSjJv?=
 =?utf-8?B?WTJ3ak4yOFNpWXlwKzJlU2VMc3d6VHdmendmaVo2ckkzWm5ReUF6ZzliUHpZ?=
 =?utf-8?B?QktZQlZPOXRSeGlmSVkxczBOY1dvNkFmUWFaRS9lMENERHZCSWdyNlFwUHdt?=
 =?utf-8?B?SVl1L3JWR3RRQSs3Vlh5Q2pGdFRPdkFPODVSa3FVbFQ0ZElmdyt2VkQ3ZVU5?=
 =?utf-8?B?dVdmOWEwZURQUTdWZ0E3UVY5TUdDMWdYdzFNdis1cUkxbXpwQjRZUEh0cWFB?=
 =?utf-8?Q?ZrpPoxrUPwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjJzaXNFUmJ6T3ZzT1Z4U2NBUE1ZTWVVa2M0MExtMjl3RDQxcm1EblM1Sm5o?=
 =?utf-8?B?VkRvcEVpd21Ocm1QdVRCby9Oa1JWSFFTeUorNVBNMDNCaDcwRjJnbkdTeW9y?=
 =?utf-8?B?TWxCM1B0a1gvcy9WSTBROTNGSCt5UWhmbGRqYjJSbGdpQnNOUUlKSUJTVUd3?=
 =?utf-8?B?aFdraW1lRWNHdzFDbnhQdlpzNHIwNXNldDk2QUpYa3B1QXdVaW9mSk83TTBH?=
 =?utf-8?B?RWVHaXJyR1FXcFFXY2M5eGMwZyt1WEdZcW9IYzJha2pSdGhSR01idERqZjBj?=
 =?utf-8?B?aXVFNjVZcmFtVW44WmVIWWhyZ09ZaDRTTlFVL05iazlzR3J2SEtWbHo5QklC?=
 =?utf-8?B?djhHZStIU1VvM3hia2dxcGxlWmN1bmZHU2VoMTJxQWlDNnN0eTUvb2pla28w?=
 =?utf-8?B?VWhtSW14WldhVktZWHZWditRNG1xVGZHWjBjTXIzaWU1R3prSnZ5WGQ0d3hr?=
 =?utf-8?B?Ym5sZkpVYWRuVFA1VWVWR1ZiMFZoRlFzSGVMRStBUUNtbXRiS0F0ZFZVZ0dH?=
 =?utf-8?B?MlNsNVVNQ012UWEyR0RTNk43RVpFRVNMVjJuQ3VobnE4RWVsV080OFd1QnJL?=
 =?utf-8?B?RHZGQlhGSWs3TUlIYzBXejc5L1hzTWRQd2xMWTNKSDdjTUR3MWlmalhjUWFN?=
 =?utf-8?B?NHVNZmJYYUdWWGZybHVnNUFuNE13eHRJN2pwUHhFZmo5MVVhRklaUXF0RGls?=
 =?utf-8?B?VkVhVXFlbmtmQVpXUThSTUw1eTMrM1VQVjRRVnprZHBDVUg0cVloaGk3dm9M?=
 =?utf-8?B?NFQvVitrZEZaSXVFdHMyeVBBaTRoQWNJV29TUXNTK2JBRXNrVXp1NTB0d3pR?=
 =?utf-8?B?b1hwWklwZWR3VTRTL3FGS2ovZ3BSVktMU2ZaeHV1cDJUNU5lQngyWTFhM3Ax?=
 =?utf-8?B?RHNhcFlhS09SVSsxeFVWVUx0VkZuMlJldU90R2dsVmJZWUgwWUFnWmxwUWYy?=
 =?utf-8?B?Y2pWekJvazFSZXlTV2lEZW4wYWxxMWRTRk51U0lIOW1oRVQ0YXgrelNFaDV4?=
 =?utf-8?B?OWlrV1dxaGVGRHg1UlZaanJTNXpkbkJnZm0zalNybk1TSHZFTVJaaTd6SW84?=
 =?utf-8?B?TjFIM2pMKytBVkY4Z3N0NE1TaXUvSjRqQVpwdzVOWjBmdXhjT1pBa2ZoTzVR?=
 =?utf-8?B?c1FmMkZSMkhaRFdmNFJPZjhOcVJmdGZRVGFNOU9ZWG84emdHL0NNSVN1SGJD?=
 =?utf-8?B?RFBpMlEvM3RkKzFxZUlCRFE1ZEpMd1hGNndmWGpWVmxpd1l5TkFHNmxYMTVi?=
 =?utf-8?B?K0c2QTlkL21mMitUNXZKVzIyVHl2YjI1RVZFS2xuVUlGWnB1ZHdLL05pZGlt?=
 =?utf-8?B?YzN0TXhITTJwak5aQnU3bFNoOHJucUVFVVROZlJkY0t2eHR1ejBXQnJkN1Vy?=
 =?utf-8?B?anF4bDNzZGppQmtYZGxmcVhmcFVCUGJKaGdWbVRrT3Mra0xKU2hReEFuUXln?=
 =?utf-8?B?VWRWMFdQaXBwQyswTEpqb1VDYTh6VEI2c25WLzZKNGlQaW40ZEF1YWFPYXo0?=
 =?utf-8?B?eE9wejMzNUhJajJVNlFZaFRrR2RzcFgyMDNJRmFzTkFhVVc0NnlNRVJNMzEy?=
 =?utf-8?B?WGQ4dEtjb0krUy9qTStJZ05VbncyYlBLbGlvUVNkUGlGc3M5cU9qem55T0tN?=
 =?utf-8?B?L2VOaVNEWml2b2RSMDZNeXFrakVkSnB6ekU2cWc1NW01dDhYZHlTVElaSWF3?=
 =?utf-8?B?eEQvSSs1MEYzanFZNmV5TGVNOUE4cE5sTUREcHFmOUhJa2VwREdrVjNpWVR1?=
 =?utf-8?B?UHJpRGtYdEc4djBtVC9IRXUrZ05xcWRsa084K0VwZ0E4TTVEQjlaZzlpWG9Y?=
 =?utf-8?B?OXZQOFk4RVRlK1A0Szg0dU8raTBFTkduejRsWXpBYVFEaGR3bjFHd1piamM4?=
 =?utf-8?B?Wk9aQVB4TmgxR3YweEZXREdLeURmU0VhYzc1SEM4R1FLd1ZGS3ZiY084ZjVN?=
 =?utf-8?B?cWFZMExZWCs4dThXNjMrNEhvUkx1VXRpajdOblRRRW9pRUJ0dlNzZjNmc2RJ?=
 =?utf-8?B?NUoyNXg0SjRvL0lReEtHV2g1NDhxVFQvdjgvSW4vOXJIbVU1YklJNDhGNURD?=
 =?utf-8?B?SnZqanpPT25uUGVSR0tpQ0FYZU16NTczdy90NGsrdGJ1NGt5VXFFNmh5QmNR?=
 =?utf-8?Q?J2vRzBrynyPFNjYIOBUbDAFlo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zNKb0QFHtYXUaWwHw11FM7jxiyf9Z6SFQGlMS+ldXCHb53mOL/LIaybicU58GRW7xKqIh/Rsr2/w87Hxu+bmL1eSxU9FknKj3pbfQ6jnG/TSMLo2JYAXDCnBhJyf9m8V5VADRPNA6eCsb6fz/rpKX7dj3AxOSw3+vfNACXDkoDiPJER4YbswQqT6al+j8S1V6TeDQvaDk9Fz42fx3COLcW3+KH4nevweWJIeP3mq27TmaDp43tV0Eebo4BXANq42VqmUYVDMVqxQiSs6o/Fo1+A9GynOa6BhyKFFWnYHXyc7vgBeWlAI7uelwQnEtQtj82FIUbxIHoFS4kN8oUXOZMxfpZ/oYzQDLbE7ajuamcKBqW5phHR9hXdTi/sUlmP20tp6oqKj6ODYqzI/4DnZ+WtOzAwHtKdX/mwAOeueKLIrpMmBOtGQi7nAg4kXDKWV4SV1fOzHeBBrJ01Ec2VKndAwuLsRHHdcarrvMuouZEwCk1jBkCI1bb9wSqMsKeHO/kPMcN0iUBZmiRLRyEnqsxz8iTwp+PSPsH5GRqmpfryClh3e7AkZ08oytTMsp7ng9/dBHrGwXqs7zV7KtmzXbP2cdX7cLrSuAyCDAri+nq0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5dcae-45c9-43a1-653b-08ddddc9644b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:05:19.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVNIYdpk7WrEYAPLF4Yzl1szTFyPEOHHeXynNPGmWugHfYj1ZVU5IUfUxbaEKZW0t2VOIYRY9mXVWL9isaR4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508170209
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a23603 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=buAy3piIdzWGIDUOxDwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDIwOSBTYWx0ZWRfX3hW8xRaIw5Qp
 F6567oLxBT+nlQ6C7r3w6HhuYqHjeVSeMC/3zcaTUsUFlbmaIJbRfOrqbyavs8xZWr5bKq0KVWu
 4JwfS1ufPXFijiyiWQWngld3VUMgwxEYtnAWlHhsGm9S6iwiyPP1Puu86plNCza3nC+BOF5XHoa
 5qXQdPdJ0BMvDhhArHn2NmXRFa7a6hai6KU4dLFBnNlOZ3knRFeDsYBzc7YEKLijp6b1NOqVOW8
 aghTPxtERuNmbgbZJQcuVhCN7ITVAgYLjI9hgzFV2noT7IBNrXKstJeWZ6WjvQ8HNGPZc1BYSJg
 nRAnmFC4vIJvHabsiB6bZ8Y5qK1RHQ4RvJGVfMcSZmd/ada24HMC5+ogEdt5pzJffklQfJL90R7
 JhbM6VPGEfy0WdO4vm26vk53JTeb/KKCUN/WsRk5Nri5fzfmMV6yYlcIYGYJa1K+Z92dxidW
X-Proofpoint-ORIG-GUID: AjDDsDrGGXsYfnZ0oizE8gDR2WFaa5bF
X-Proofpoint-GUID: AjDDsDrGGXsYfnZ0oizE8gDR2WFaa5bF

On 8/17/25 4:02 PM, Sasha Levin wrote:
> On Sun, Aug 17, 2025 at 01:11:14PM -0400, Chuck Lever wrote:
>> Hi-
>>
>> Building on RHEL 9.6, I encountered this build failure:
>>
>> arch/x86/kernel/smp.o: warning: objtool: fred_sysvec_reboot()+0x52:
>> unreachable instruction
>> drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
>> vmw_port_hb_out()+0xbf: stack state mismatch: cfa1=5+16 cfa2=4+8
>> drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
>> vmw_port_hb_in()+0xb4: stack state mismatch: cfa1=5+16 cfa2=4+8
>> drivers/vfio/vfio_iommu_type1.c: In function ‘vfio_pin_pages_remote’:
>> drivers/vfio/vfio_iommu_type1.c:707:25: error: ISO C90 forbids mixed
>> declarations and code [-Werror=declaration-after-statement]
>>  707 |                         long req_pages = min_t(long, npage,
>> batch->capacity);
>>      |                         ^~~~
>> cc1: all warnings being treated as errors
>> gmake[2]: *** [scripts/Makefile.build:289:
>> drivers/vfio/vfio_iommu_type1.o] Error 1
>> gmake[1]: *** [scripts/Makefile.build:552: drivers/vfio] Error 2
>> gmake[1]: *** Waiting for unfinished jobs....
>> gmake: *** [Makefile:1926: drivers] Error 2
>>
>> Appears to be due to:
>>
>> commit 5c87f3aff907e72fa6759c9dc66eb609dec1815c
> 
> I've dropped this, thanks for the report.
> 
> It's a bit funny - my version of gcc treats it as a warning, and it
> actually
> gives me quite a few mote "mixed decrlataions" warnings in the 5.15
> allmodconfig build.
> 
> Compilers are hard :)
> 

Additional context: I copied the RHEL 9.6 /boot/config to do the build.
I think Red Hat likes to keep the "treat warnings as errors" setting
enabled in their builds.


-- 
Chuck Lever

