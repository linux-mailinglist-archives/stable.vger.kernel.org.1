Return-Path: <stable+bounces-181632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D018CB9BCB2
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 22:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92291B20130
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65F273FD;
	Wed, 24 Sep 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZBL0emW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aklqIzJw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF5272802
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744082; cv=fail; b=r8NDUg/qmrkpnzyZKnpop2dpZP0AKoAgw9BiLQvRYdOzvm+T1kBZIuog4Iy3qjQu72Wz/cR54iE0Wg8VjiG3klPE8PPAXz/fqKkk0HTPU+Oh5UXuGQNo7e7/nG/mo7XRLkbf+shAp4nXgu9nAFq+yH5arnA2GhaZCRnS63WMvlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744082; c=relaxed/simple;
	bh=1yXL9Rd9aoEIhhGmA8zxTgN3T1LDyJSxWYdEb9LUel4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BAdOkONEQuTIFIM51NWegu9q1OrGEMGqukDic7+BBKBpLZ/myry7Sgi6fPdjLfhQ+VmOfn56Tz/8P5o70ikfPT44ll6ry8RoowdKJvXkFf7ETlZztS9knUIWKpjAqrBrIjWwUBqO70JvEKDM636O4Poj13TI2ZuX8fVmGi2zTVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZBL0emW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aklqIzJw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OItx9I000833;
	Wed, 24 Sep 2025 20:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ufcjVKN3PUijdL23gBLSY6uYpaBSThlyaf0WzSMnOSU=; b=
	AZBL0emWR3ySa6s18BcIoUU0x7wBQYuZ93UszlEG6uD0ZPWAiF4IzBxOcAoCy0aL
	5oLSdmJaRPT6SaL6Om+iJizqK5wK6LL74TDmcmPxCqfxIxjVaARaqg+CXBy/9Zwu
	5VwSf5dMcrMCOW1ynwWI5LNGD9+ky47fvXUDR0iLW8XM4iuI7LZEK6ridrMQubrM
	naMb45j6DQqpuIFwszUCDB5pPaIfnHuPaHm+ZfvDBc7U0JR0V5li3RC3vpsDV0jF
	gWXrQxJkWPVQbHSdKdIgQZmy3Tsb8j3d3EzPoSWPW5CIMqBlUk3vGjFjw4Cdkn1V
	pFeaa5H8oWhnf2KG3C5nfg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6b0hq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 20:01:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58OIxHOp013491;
	Wed, 24 Sep 2025 20:01:16 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a9516rhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 20:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fajG2Hnj+Usw4voEIcrWR3EKxl74vIO0JQiRG0vrOi9zOlGVBR/jzGtPSRau/GXDqkbvqMaAFhzf7qP2djF9hNZnA0pdDPx2UipBsVqE1q/G/ksOjHNmyHULUJCVgYrAeCPzK4Xdl6nl3lRlYcjWr9Zy4tIhUN+Hb8ni5J0YC3Sk3WZeZSkTYZwCUbkqMvzmkW7eL6zx6A4fHAJgfFVoIcHt/BOB/PPqcyjyncFAaK6wUHL3YMc2tyJrOwaPC29YnlApXZi37vE7IGV7mQyH9nVAGfnZgEaYgvXvx7zcZBw1P3QVEmQAigqOgOOtif5VzxUBOzU+9/ND4PHO9kunrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufcjVKN3PUijdL23gBLSY6uYpaBSThlyaf0WzSMnOSU=;
 b=ITAIAHINqfsIg/CzCy09KZFRoykhw3U8hqMYnFrHk1SEVrfpQvUGZYPnQXXrk1kCktnNRDuSGatt5O7kzNKP5HgaxImSayZA3gB4UPgavK9uIw2b58nfX37tGWq0AC7v1THh5ziQowUph5tff9IWwSNQrlyKypzg51qNptHW+g3RFjIC/R2m3sMY+yTxkxnNojoMSxHrED5hIRPhOoUZVynBvE5xKzbK/8K6otaaak6FwqfeYTXjfMXiR58jwcu4vhVv7A3Ab78Qv5bQt/6M6p8FKF2yxuQMaY25R3UXBWyIKGMA52eUKYVxFHaRXnP3bJcctnaepg1KajYA8rHhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufcjVKN3PUijdL23gBLSY6uYpaBSThlyaf0WzSMnOSU=;
 b=aklqIzJwleU/H4NfLCgWIofjpes9toMalOBqCKn7xgQQ+b8Ok8uZS9f91VEj1HDhaJeaGflncqSr9XC4nB1vi0D97B+lwqTuKEAaPhR/gVRGjMF3Hrz2aTzhZvsx2RPbCqzhkrBuSKkQZlbKsvm6lFLcKyqKxpF4NWvjC9GRxqw=
Received: from IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 20:01:13 +0000
Received: from IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::7eff:bcc0:7955:112e]) by IA1PR10MB5994.namprd10.prod.outlook.com
 ([fe80::7eff:bcc0:7955:112e%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 20:01:11 +0000
Message-ID: <df5cf0f2-55c6-4786-b129-0a84101a5801@oracle.com>
Date: Wed, 24 Sep 2025 16:01:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Confirmation on EOL for Linux 5.4 Stable Kernel
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        stable@vger.kernel.org
References: <7502ef4f-a911-4c08-bdfc-eb17183e668e@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <7502ef4f-a911-4c08-bdfc-eb17183e668e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:510:e::30) To IA1PR10MB5994.namprd10.prod.outlook.com
 (2603:10b6:208:3ee::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB5994:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 28276499-819e-43ae-e09b-08ddfba51bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWdZSVIzSkU2Y1hpbHJURE5QY2o5S2ZLaHNaMDNRR3R0bW9EdHRzd0xZL3B2?=
 =?utf-8?B?dVRaVFZDL3dRM1g3ajdXYzhOWURaS29lVThIODl0alA0U2UvNGszeG9Cc1B5?=
 =?utf-8?B?NzV2Q0RZSGlUZWlOUW9DL0Z0c2tRbXhlbEhGTTkzTEtqNCtLdDZVYnBDWVR2?=
 =?utf-8?B?TjFOalRaMGlyRHJnQ2t1cGhDMjZoSlhKbm5pc2srRkpxSjRzM2lCNGdTR0l1?=
 =?utf-8?B?eERBWUREMk42Y3RPR3NOT1BCdzNTclBUbS82bGRrVEd6NXJ1YU4yMGo2bFJh?=
 =?utf-8?B?c1p3TEp4Zk05S0tvQ0w5TmJLaTBlK3U5ZFdHNXlCK1N5VFJOOVBic0dnNWFl?=
 =?utf-8?B?S3B0NUllK2RNWXJwL1oxdU5nWEFuTURrZnkrNTNqdEUyaVJpeXYwRnk5d1o0?=
 =?utf-8?B?NE43bWM4UFFWU202SDk2cVVLZllXcWdPVGpVM0s4eDdkSWh6RXFiSVdnQkxu?=
 =?utf-8?B?OWgvYkx0WWxoK3J0dFkrWDEvVWJlT2xaN0pEM0R4elZCa2x0aU5wZVpNek5o?=
 =?utf-8?B?R3dKdDlhNUFjcU5DMzIvbFduRWxWV0dyZCtVODFyclEzZlFaVHlIc0MvK3ZO?=
 =?utf-8?B?elFCNHlpc0ZVa3dKMXpheDUrVVRpbU81N2F4MVpleTlYMFQ2UVptY1NzTmNL?=
 =?utf-8?B?TFkwcVBxZDlYWjZJaWJFajl6WjYxS3pMRy92b01NTW5jWkR2WHU5MFd4YmNC?=
 =?utf-8?B?OFhkK2dRemNzWjJFRkdQUTFpUG1EQ3Q0NzYzTlF2ZWdTbHpOOUNqZCtRUFQv?=
 =?utf-8?B?WjNEUmdXN2d0dUYwMkZUNTJmbTNKNklRRFNhc24vc0V1WkcrbnN0b01tazVP?=
 =?utf-8?B?c0d2T2ZQb2NRUXpYNThFbndzT05XMFpRcUVzb2Yyem5RNFNhcG1UbUVrNXQv?=
 =?utf-8?B?c2xjSWZFTjl6ZWVHV3VJcVRXTFh4NnF0YnZ1YWFaaGVxMlRJY0Y3YlYvOFZq?=
 =?utf-8?B?TUp4aWgvK0x4VFVrNklXeFZLNU13VXVRYXlqRnhsbTRhQW40NTJMSmQ0aEJq?=
 =?utf-8?B?OTU2YUllSm50VkNTbkltcXJJMm1Yc0VHc2RHWFRJbmVweXdjNXZ4TFFvczRG?=
 =?utf-8?B?WldiUGEyQXZLdHZwRDVSaS9jQTlHNlcrQWJ5aDVyTE5aRVlrZFNCTlB6Rzdw?=
 =?utf-8?B?elNNRzgvaWprVnNaSDBRamR4ZmtoYlBrSnN5RnNGNkZuY0JIM1Q2ay9SKzBZ?=
 =?utf-8?B?RlpaS2owTHlOWmk4NlRWV0I4dktVdmxzd1ZDTjA1YWVvNjJCbndidXhoWThH?=
 =?utf-8?B?NG83ZCt1c2pnQ3ExMm8rQUNuOEVhV1FlV01TM0FLTktNaXMwdDNMZHlxSnVQ?=
 =?utf-8?B?TXFCSDVKSnZaOWo1MGcyK1BVdHpXOFVoZTNDRDRzVW1ZZHRJS0VMeFhhNWxW?=
 =?utf-8?B?ZVBxSnIrN0NIS1hyTWt6UnJKSmxiSm9SVWsyUHRXL244Zy9NcUJsdFZLcEc1?=
 =?utf-8?B?cUhyQjFkdUhRcGdYRzlOZEFuUm9KQmtsMWYxc01xR3VoYWtwTmhHaDhXbDJx?=
 =?utf-8?B?QlFkWnQwaTFCcUwzd2dsM2haTEN0L0RrM0RxSTVDdUpPN0tZVWJMR0xjRks1?=
 =?utf-8?B?SlNoeUZLZU5nTVFxVXVFdjkzOWlKU3JGaGxFRlVGM0NGRVRqNTViOWlkcjh4?=
 =?utf-8?B?ZXFRSE5jQ1VwYWgzV2xzVHNhcURacjRiRDJ3RXhwQUV6OHRIMXJUYWt2akNK?=
 =?utf-8?B?SGhJdnZhc2FtdzdGaTU3SGpBdEZGRjlhMXN6Mi9GNmtRYVJiSWhwUXRlTGk1?=
 =?utf-8?B?NFBNbjR3RzRyViswSFRKWWhqd1Y3ejNiSFVMVkxFdzgvNVhjNDZnV0Vsa3pB?=
 =?utf-8?B?N2pHRlFna2RXMVNOZnZpUm5TRVFtYXRhRXZrSDZXUkMrNlcxVUVQQVRoOTdX?=
 =?utf-8?Q?UlRjeNfkDNZ9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB5994.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTJRSUZOR3gwVVVoVC9kS2VEUjFwdnp1dnB3dWsvcVRhYkV0SmJuTEFUNmlM?=
 =?utf-8?B?TXNNMFp1ZGw5UlYzc25DVEtFQys1MVJhcmMwbElreVlMWnpSeGI1dVpCMFpL?=
 =?utf-8?B?UHZSdzBMbkM5MWJRV2hzM0NKczRsYjB6USswNWgzMFR4eVFnTG0vQTU1RklP?=
 =?utf-8?B?WkFBR0M4MCs1Y1ZmWk5kTVRFYWhpOGZnMndkQ09WODZEMDJZSUNaeHZtNTFm?=
 =?utf-8?B?aG8wQ0Y3N3ZaSHZodm5JUFBkdE9wSWlhbXRIcUpqem1KbWltM2JmMUh1dEFT?=
 =?utf-8?B?QkQ1OWRoRVZPTWZQUmhhR0FXb240VjRGT1ZQQ0haSUIwelF0bjlnV3VLbGNP?=
 =?utf-8?B?ckZMQlgxaFY5ajdBeFJDRnBaYnUzVEF2K2hmYkRtNGw4QXVLZXFoSUkwSnlR?=
 =?utf-8?B?ZWhrSzlOK0o0SnI5c0ZTOXh6RVBZQ21hUTJHOE1XQzdQdkZidFJrZFZSb0VV?=
 =?utf-8?B?aHhQTnNpMXJDeWdTZDNvb0lxd0RxRzRHRk1WbW5xZ3NTUWR6YnArS3U0bkJC?=
 =?utf-8?B?UUlpZnBHRUk1Nk4zYmsvZTJOMitNVVI1U3A2SEUvcnhiWHZMdWVBQ3VheGlH?=
 =?utf-8?B?QnRTbXdndFIrTVh6ZzA3eHhSMVMwczVGMUJNcHE5VG9EYlBFSitGUW0rTGdj?=
 =?utf-8?B?T0tZNVhxTjZCRnpLc1Z6S1ZmbmF3RzVYbE81S2t0b1Y3OWVJMFk1SGhZbWFK?=
 =?utf-8?B?bjgrYU9sMUhqdTZUbDkrTUpHK0NVa2xqSW5HM01wb0E5ckRiWDBFZkdDMjFE?=
 =?utf-8?B?SWcrY2JRTmplUHdWNXBTWjM3bXZ1dVRxVjZGaUpaVTM3dnZuN1dPSFNtMms5?=
 =?utf-8?B?UUlISWg0bklKaGlCNlEyMEo5NEMxSEFwK3JaYlA5NG94OVpQSExYb0ZRYVJW?=
 =?utf-8?B?RXp5SkdCb0FjRk03NUI1WVZRa3p6WWxUTlg2Z2VUZDIwQUh1MGpKN0hCMDYv?=
 =?utf-8?B?SnNtcFlkVzBYMkthSUJBUXBtQ0hTNUlhMGFiWDJSeXBPYzBzb0NlaVJNdjdF?=
 =?utf-8?B?OWpIZnFwSWFzczJHcVhzRkJqSWpTYmdicEcxMTYxY3Q1cnVYd1Q2cEtuR0h6?=
 =?utf-8?B?QldleSszZlFjLzNKWi9KUkgzOHpDeHltSWxiYzdraEVyZEtyWnBwQlJ1OWto?=
 =?utf-8?B?cmpqWlpudWtpSjlKU1Q1RFlqVzZpNjBsQjBKWlBDVjV4NTBaS3g4bWZjWkMr?=
 =?utf-8?B?VFJwQkY1a1laTDNMOGxSREhpd2t3TW9zSTU4Vk84YWk0eDYva2JySTlRL3Yw?=
 =?utf-8?B?REdubVJlek1POGk3K0ViN2g3TVB2b1BHakZtSlhEcG5oMjc2MGFMandickVi?=
 =?utf-8?B?elphR21qaHhpYWJmR0dBTkM3ZmtiMk50K0Y5aGdGZHRUMmE0VllaaUxYSlAx?=
 =?utf-8?B?cG96MzBhcFpzVTZyQkFhQnBNWVgyMStlU1ZFYSt6Wm1DRFpxSDJJT0ROK1RN?=
 =?utf-8?B?VVd5djJ5T21vdllOUC9WaVErM2F1dzkwRlF0aGZLSjJUU3FTT1oyNmo1SDVt?=
 =?utf-8?B?MHRzV0Erb3VEYWE0cWpRenphaHozdlNNN0pvZWpZc2w0eCtlQzRPb3RTZXo1?=
 =?utf-8?B?UDdxYWxKeWpKbTh3V2hFRXorSkhyeDNRQWVxZEEzSzgvdG1JUjRpMlFQa015?=
 =?utf-8?B?c0hsMUVXYjZ0dEhiSElEdlhLUHlWQmk1VXROSUZDdzNnSkl3NjA4WEN1TVFQ?=
 =?utf-8?B?SHQ5L3VqeHVNT0s1YnkwSkUxOXhSbGtxYzNMWEJ3dlppbW11OWxyRm1jOEhF?=
 =?utf-8?B?cC9xNFVxemQ5NkYyQWdvczQ0L1BhUm1rK09LMi9hUU1wLzJGV3NZYVVhWmtG?=
 =?utf-8?B?TVVpN0NLSjUzMWhGWVZWS2hTa3NYWGRYWVAxSGRaTDZPYU50eGJvWFRaVXJG?=
 =?utf-8?B?TUdobzYycXpvOVlJNHBrd3hHemJycnBUSmFSMWF3V1g0clczSVpyWUZXV0Z0?=
 =?utf-8?B?c3FOWUVNZ0U0ZEZXdHJhRnVwaHlxVHBxTlhULytqQkxTTTRzaWc3R01JaWlG?=
 =?utf-8?B?MGdYdkUzbExWNTJvSHF4S0E1T21TWTR2YmRvUDEyUlRzc1JEY0lSeGJTNFJ6?=
 =?utf-8?B?VHBLZUVGVVdVY3FVOTIvbDBCaEo3QXAvSWM0am90bFJydlRlUktjaXVrc2hj?=
 =?utf-8?B?R2xES3VvQWltcU9wNnVPMVBRR2doTlBEalRQM3VxeThrb3pUNkRyUnlrSXJZ?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z9E46mbEcKws/hO9N0rqIjEJMARIU5rpdOEUHEJfUd9BrdWjUpdi+kQGkO8iUrvRtH7+VaA8Vn+7rivuxbI6mxohlQfhzkVKzt/Q1WBaLFQLRVJ3ZypRvhT6YpeOCO41mN70BCOTarnoSbYA5h/mkwgpOILH+rd6r80w9CUaiOi4CZS4a0qzq/qdSC/lQPrWEytQV2epmKg5fpu6RPuuiTuO1eBKfY1BeI5ewGPtn/D53euW72QkxE6V8fDmKFNzi8syCOja71Is8v63ZxZUQJBQdaghH0tARfb1mgcnFIR/44zsutMiGLu528w5k8WFg0/vUtmS2iW6pfCA0vwTfpl0be8H4OK/0eEL0kCCZTjwuG9DELUx0DS63bulW4zEs+6SVMgaAJnwIaocvQDiGYIzc+Z/2B8xDTv8AtGPP7hDMrWeM+SqYirkA0sDeWPdRaqsIeKbWCaJVMizR20T4C/aiZUm+C72+4TXgUJsequ1+vGJffkbz0KyRSV5YbsGE9MvPEUkAaG0LrGmdlv8+rm+r9EZCo8+ZEKYIUCEz5HjdxGJWHn24+5HohjXApXpj2WxCpL/e6g9EjT/o4mVvE42R9954fwE5ZfpLjdToIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28276499-819e-43ae-e09b-08ddfba51bdb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB5994.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:01:11.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SDHm9voc1bwpctL11wrNtBos9aEFKCxkwPk36/P76ZeF42HQ1cYi/kDsZEEsKyEpEDgHIjntx47pu00KxEgnMPX1MN7MbRKsZiRCKLGmuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509240175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfXxqbZ3SsbPlTa
 9QmGfAqKlJG/h7EY44e5AI+MhZQSHeFuJ+oAvO+i9jnRhaoXV+oE1vrU1jMOlF46G6HOJjd1fxO
 rS3cVM/6JGOl4gNkHqoCWlihTSG6ggeeAHKIt9uDFATemS+8f774JVWonWmAqK5TFEm2AJboPF2
 9TpS71mEw2OgtKXORDfVQvGwVj5o0p2+2Ru/dornbwdr3k7Yrd4SZnMbtyt/jdy/xn8kFq56d/G
 SY66LgDGBB9YU3evoukzP2cQXrqBg9Eyi9FLf28PTnQtUDCj6ZAUsNMoKP0nsjFGpYebx/WJy8h
 cFu086ZYklsHhwjk7Sa6oCxeHS7qq5JRU9zA4Ko3wqvWoB1VXrlo9D5VsU9zks4lS+I60fI9GRK
 TpMP5X2kCuR2lx6pPWtDa95Mg9kf4A==
X-Proofpoint-GUID: jc7L9YqarH3xpvazm-5I1Tgdxnum3MqX
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d44e0d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=gSPd6q_hU0LnOk9aOZgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Qn6xTRysOZEA:10 a=FoiGvTp0eMAA:10
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: jc7L9YqarH3xpvazm-5I1Tgdxnum3MqX



On 9/24/25 13:41, Joseph Salisbury wrote:
> Hi Greg/Sasha,
>
> I am reaching out to confirm the projected EOL for the Linux 5.4 
> stable kernel.
>
> According to the information listed on kernel.org [0], the EOL is 
> currently slated for December 2025. We are using this projection for 
> planning, so we would be grateful if you could confirm it is still 
> accurate.
>
> Thank you very much for your time and for all the work you do in 
> maintaining the stable kernel releases!
>
> Thanks,
>
> Joe Salisbury
>
>
> [0] https://www.kernel.org/category/releases.html

Sorry, I forgot to CC stable for the wider audience.  Doing that now.


