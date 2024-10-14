Return-Path: <stable+bounces-84683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28999D180
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33141F244DC
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4E1B4F0B;
	Mon, 14 Oct 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3m6738Z1"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F71B4F13;
	Mon, 14 Oct 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918852; cv=fail; b=Pjfusjf9nQjxovzlLft+qJ6RLE0t7Soox+JWWPCaLxZ2bWrMzcsyao6xB8LJYuR33M6LiMzfKqOYpTdrd2hUfQ3SuS6eowPDDBI+7AmZnA38LVkG/Zlc3zt0SoUb2t4IduP7upJ38LXmvF1OgBGvquO/ryvuNBX2vLRH3W/mPT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918852; c=relaxed/simple;
	bh=3AjwK5PNVXKYK1aF+rzmIpIdjER0bxRtaleqWzDZJuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SERzE5vrOqhzAvEBfwyxwAAuuIDB/wU/eqh2pQIC2Y04Vj0aMx8uYuBOHWOvawFWg47IOyMyJWPgGqAXxPa42SfbhcUGJrDQXzb+WzOxmGXoGWjgwTMgaFiOwsYXD05PxacttYtuEwbCra5S+hHP3spJhkbes4SoECdHKkpHcno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3m6738Z1; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfwVghrYc1Tjjrq8qIsiYOYKgQYcpEH1N0e97JPoq5KFDhTL8JitTtb9hTb+RHYxDH7lUqPWj+SNJDbBuj8CSkZW+xxeKQXIdw9bvFgWuyVGQmdU80v4zJNYO3nn75yW/O9TxDoXawv4Li/s/fo7qQr3wCTW73KgAHzw0/S4IteYyq1N60wyG+rh79gp4L5NNJlrAq889bab5ZFtSstu9KLyFqdtke/T0sv/Q1vSO3XxCu5QYB4QUi2yxiSqty/3bAps69LWWfb1sZNF8dNRNosx49OiHdqXAoV60PewqNL8NIfzQBinL5ahHCblnW9kwXXxyYaWXOliM34URVUXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQR1UM1cR8QfLLZqWCF0sBxx5bXPJvioRe89rZ5FVP8=;
 b=QAGsVasRlbt/z5R1Er29hfg2hflCpJdOCNniekwqsnt6AoL365beLqSVP/VuRboC8x7GiGAxN6U20fK8nhzpTkWxvuwwizdNsndkrpvW9aqaPO6pkgaN8ECXc/72983XS/GR2cr+V+668cbMSyPF6DJm+v9UqAdSwM//8ebdGwM3YLHz2ubHVJl9AXc/If72qCoAGe/Ej2sd/SG7biertXv+cQsvoXuJbN3LeFDjfZuCdINSpTCe2/PaIW4Y8Pt64OHaito0AoHnXtliqsK34+l13hisfdCp7V3ZNEe/NQoRIBEegNT5E1t8ZNNf0irQvs/aSep7LpbOC4McKlTzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQR1UM1cR8QfLLZqWCF0sBxx5bXPJvioRe89rZ5FVP8=;
 b=3m6738Z1wc+zO2KJ2wODb4SOZqgQIEZmpJQ13F7Ia5qiHZuo8z+6dV7ykbhY1o9lpiltQY8j3dJteinhytBvt5bU5xoGyOyn6xckEQUkMy00gf1ipp2FzLXh2PfGzEahvNe5dOqJUO5KvmsAedZnX+db7FazCkTeum/LNhIUGqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:14:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:14:04 +0000
Message-ID: <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
Date: Mon, 14 Oct 2024 16:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
 <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: e7db695d-f968-4130-c8db-08dcec62d75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHpKYWptMXdjOThGYjFPNFc1OXJwVWNicWVUajBsKzFhZmFFQmwvQWh2L1Nx?=
 =?utf-8?B?TXV2cVhnMG10bVowVWR0Y2hOaXZBMHAzUDJOK1IzdWs0M2Q1OXhydFR6cWNR?=
 =?utf-8?B?WXhCSWpVNy9YU0llT1lBSnVwcEU1UzBwWXc1aHYxNTU4RjZWNTlmZUE4NGg1?=
 =?utf-8?B?VDVZbmdSVlpPbTNUZkk1TGQ0RjRHbzVkK20wNzJ3RjJIeGRVR3NWVVRWa21U?=
 =?utf-8?B?cDhxUXcrbUJQS084MFByRi8rc1dBd3hlSXFKR0Rmb3JRdGNPRlhVN2I0VnJu?=
 =?utf-8?B?M29SUVNxaEZjbGlaWUlaU2syZWEyYXc5NVFNSEU4ZGxCM1Q0bnpjSitRa0s5?=
 =?utf-8?B?SEZvYUR1b2ltRTltVFZweGlMUmdOYURZck5jOVJCS1BzRFpjdmNNdWFqTUtU?=
 =?utf-8?B?U0VJWnFLdVhJdXE1cDhDRWQ5aUlUTjlDaFh2Y010ai9YclVmS0RnZXA1cCta?=
 =?utf-8?B?eHR4OEllbHFTWWxGdVNiTmovSGFPNW1Ca0hOcGY2ZG1Sc005ODREOVlhM0tu?=
 =?utf-8?B?emd5TExuOEhoeWtEYndLMC9BUnBYdWVzMFpoS3c5ZWphUEdVTnpneFlWem9J?=
 =?utf-8?B?cCtabklac1cyZld5Wlp0aWlSdldIUGxteUFaVnNqazY2UDhlYmVNaEFnSlFJ?=
 =?utf-8?B?TnBROG5pc01QNndIU3YwK2toQXRta0UwajhUbWpOVVE5TXZDc2dPRlVCRGdv?=
 =?utf-8?B?WDNFNUhoUGhPaVZrcWFHSU5haWZJWFEvd0dSSjBLZmhQeFVDMlJWOXJWZ3Nv?=
 =?utf-8?B?aldLVkNPWVA1TkRZaTNzZmsrN3pXS1JMZ0VZQlJ1ZExOeC9oUTZaSkdlSm1V?=
 =?utf-8?B?cDdBUklTY3JPS0l3YTAzaiszZzJUTUFPUUpqNitSQjVRUjd5ZEtJRmJNaitp?=
 =?utf-8?B?MVFQSVZleTVZT0FnL0NCYnc0WGJHVEY3cXFrOXV2UmJ6aFJ6Y1V6QmR1di9j?=
 =?utf-8?B?bUlTdHBrQ1poMUZMVzRpQTJ4ZG9KMlgvaTlmTFdMR01DM00vcm85VXFEeC96?=
 =?utf-8?B?OUMzUjhtbEtucE1ZaUpiOC9oeTZXZUpiV1JRbG9tRWZBcXlLSzhxNjZQWnp0?=
 =?utf-8?B?cUIwT3RKQk44cjd5bTVTV0wvSjdrQitZejVxdTRhK3dJTHRUcGJ5WWtiemhi?=
 =?utf-8?B?bkhveGpCeFc1V05MckhQQzRRUVVzdlR3aHdPZmhFTDRFV0plZmxWTTlHSUQ5?=
 =?utf-8?B?TFE5eHRRM1FDaXdBRkE3VTJzVk9qeGNBR2pFaWZMUlE1ZmRKMjJERFNMUSs2?=
 =?utf-8?B?elVPUEx4bGJQOFNoSExMd3RsL284MjF5U0RvV1hXSWZ0b3JjeEVCeEFLaGVj?=
 =?utf-8?B?M3hlU3A2bm0zVUtTYkgvVTZvRTlHMmRHanJVeGJrRldrUjB0dktCUEw3THNq?=
 =?utf-8?B?T3B4SGk3MUZTWFFvY0V4NzVZNTU3bUlZTU5GajJvWC9DcWtoczdaRE9RdnBm?=
 =?utf-8?B?WnJua1JiaUFCTzM0L3c4eEtpYXovNXNoVDBFZnVVWFpobzNhLytReUxyQzR4?=
 =?utf-8?B?MHlrb3pkV1UxenREQW1keUZxRHZNQVU2YWZyOVhFVVRYZmFEYW5IUWJzVFQ1?=
 =?utf-8?B?NEJvemowYWNCaEsrV1kybjJ4bitPWXVlc2s0NGZEUDhBOUY2cnRXYWRxemJs?=
 =?utf-8?B?WjdqVTJiUFN0S215SkRWalVkOUk1dzIySTBoWCszc21VR2pSUVp5Q2JiN09k?=
 =?utf-8?B?UkpKWGtXWkpjNXBYajdDYmNuS1g4TlFWbm9SYUtFbThiZ05kZVRQT2FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q204L3hRZUFxR3BVQVNKTkZNWUMzeXJZUTlOY0cyQUh2QWtqSUp3M2REeU83?=
 =?utf-8?B?TjVUYUg3Q1FqT2lIOXdXY1BiRjVyTUFoQkVHVWxvK0c4K29FNWp0QWJYay9Q?=
 =?utf-8?B?My9FZWtRVFZ3VGxmVFNEZVRnNG1ic1F6bTNCS2J1dk1NOUhlSmg1UURmOHF2?=
 =?utf-8?B?bVRobjJwRnZreUJKUXZncnJTT3lNN0VBTmpSRGVCTkZQdCtqUGo1bnVXNE9V?=
 =?utf-8?B?V0RGTnhxK2JIZGJFVURyeEYyUUcrTy9FQ3lhZTRLTitvaWh1L1hsRUN2SFo5?=
 =?utf-8?B?NXVIU3k4bUVjSHlTWGZNY0ZHMWY4VFlOQ2xaUTE5cDNIZVpHR2dZY1hTV2NT?=
 =?utf-8?B?Yi9LZHBxdklLYnlaZHJDUUh5MlY4ZHRWUlVTdittemNiaDV4dDhHbm1vUSti?=
 =?utf-8?B?ZG1ENWRVWU9ZQ1IwUTRyNW55eHVXMEUxUTU4YWlEdVVPTUpvMSsvZkplN0xo?=
 =?utf-8?B?bVdHb1M5dTFHbGcvSkM4dmZqYVMrb1EwamVBdWh3VTZlNjN6QTl3TS9Kc2py?=
 =?utf-8?B?MWlkazIrTXpRZDBWZGtpWFFESVliUi96Y2VIWTR0Zkw1M1VuWTV2Vy9oSldX?=
 =?utf-8?B?bnJZVldQdlNPNVNOcUIyNDQzZ1o3RzJ1Nkp0NHF3YTNNTVNOYUdjWDlyME5E?=
 =?utf-8?B?Nm5GZU9BaEZ0UG1TWTlSZkNJMWZBa1ZITSttSHhMbzZIaWd0OUFzQjl3N0R0?=
 =?utf-8?B?Tm15MTVXdkgyUWdXL3d3YVhiTzd4WW56RHdlRDhuWjZYZjFCY3BJTXFXUTRW?=
 =?utf-8?B?NVhLa1FUbkRKUnQyZ1FDTXhmdnR6RVE4SVdab2pwdDcrc0JSbVZPaXcyb21m?=
 =?utf-8?B?ZlBCT1hLQXg5aVd3TVpqRWcyNy9rTFREMzY0YWNGQTZ6M0kyVVFmZjZhYUJQ?=
 =?utf-8?B?TFRSb28wUHRvODhVMG9ENEVTMzEzbGlmNzU5dk5vOWpoL3ZSc1F0ekFzTnhU?=
 =?utf-8?B?OFhYcitENktNc2JwcmVjUU5sS2R1OERvNXNoVXBQQjhqOGl3dm14Z1FnaU1l?=
 =?utf-8?B?ZkVDYktXbktFS1gxMkpsRDRqUmo5cThkTDdST0FpNzNLU0cyWGxpTWVVbFox?=
 =?utf-8?B?UXFhcTFuWk11cFU0c2d6clhEeHVhY3ZFSkx6Y1UvQ3NkaS9UdmxpOG5TNkY3?=
 =?utf-8?B?QzQzZFJtWDdmVThOTVkraXNhRWF3cDdsM3FieGZFbEpZc01qUjdsMWhHSU95?=
 =?utf-8?B?bzJLTTF6N04yTkFTMmZnRU13dDd3N3hCQlZRakFESVBjOUFJUktOU2pqTHNY?=
 =?utf-8?B?aEs1NGpmYUJBTlk5aHdzN0h6cVUvUU1sWE0wRjNUL0R2RUpNU3N1MGR0NUM1?=
 =?utf-8?B?eGhPaFJqUEJWRHNvcGpaWHFmUnYwQk5ma1FVRzUxTFp1U2prdFQyb2Z2VGJL?=
 =?utf-8?B?Z0F3WGwzbjZiNTF1VzhCUTc3ODVlVjVTMFJKWi9vN056VEZ6czBmb1JpaTho?=
 =?utf-8?B?ZGVpTC9zeUxsYjdHNHFXeWNkWkYza3ZxU1Q4YlFUUTFaQ2NmZE1PUlc1RlYw?=
 =?utf-8?B?aDlOWW1RV0w5eTFiaVhZUlUydExVYlIvSEtPTE1kV2N1SnNMdTdjbUdXQ3NZ?=
 =?utf-8?B?d1ZOV1UzdzlobzI3czhyUHVicDFLdk9MblovV2NueUNRd3dENFJvVDAyTTUy?=
 =?utf-8?B?VTQ0SThIeDR4OWU2TFcxaTUwbndHS3owYVZQSmZ2VERyV0dnaThkVFFNQVdV?=
 =?utf-8?B?WFFYbk53UkljWHlKa09acmZibWNqckFKbzZreDF0Vlk3R0hoWlMwWGRiRGwz?=
 =?utf-8?B?UXF0cVI3MENRVUxJWW5ZaEhiUExERlRzTzZHWGhaRWJWbFVHMnlQQ2E4QmMr?=
 =?utf-8?B?aW1aUm1WRWFpbG82MDRZQkd6Qm5SeHJsWTRqYWdGOVZhUWcrYTM1ZkNNNjRs?=
 =?utf-8?B?WWYrV1pURi96SXJKOTZlZFRzNDkyemNUa3VuTDU1T1ZiZDRjMkt2S0hKOGFW?=
 =?utf-8?B?TWRHQTlyK3lNUWtkdXcvem1kZG5XSGxxTE1oTjNVMzlhdkNjVVdpUVQrdVg3?=
 =?utf-8?B?Wk5jYkVObTJnN2hpbHAyTVVTR1dib05VekdadjQzNktGdGtqRjlaNzBXR1hH?=
 =?utf-8?B?bE5EeG5nWXFsQmtlcVE3cGpyQ0lHdkVHNzUxYTdtV3AwTjMxSUxUV2RpSTM5?=
 =?utf-8?Q?zG9y+2xyK9bFVDEwdO5HvYwF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7db695d-f968-4130-c8db-08dcec62d75a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:14:04.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfbbsyVe/sg65+uuE2mG1z+T1u594e0LWhUcKs1PEeyJMMETFKQ97EEDZiC8i+1oswje/fg0RtwV8l1bBwzYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795


On 10/12/24 22:57, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>> I am skeptical that PROBE_FORCE_SYNCRONOUS is a fix for any
>>> device-readiness bug. Some other assumption is violated if that is
>>> required.
>>
>> But that problem is not about device readiness but just how the device
>> model works. In this case the memdev creation is adding devices, no real
>> ones but those abstractions we use from the device model, and that
>> device creation is done asynchronously.
> Device creation is not done asynchronously, the PCI driver is attaching
> asynchrounously. When the PCI driver attaches it creates memdevs and
> those are attached to cxl_mem synchronously.
>
>> memdev, a Type2 driver in my case, is going to work with such a device
>> abstraction just after the memdev creation, it is not there yet.
> Oh, is the concern that you always want to have the memdev attached to
> cxl_mem immediately after it is registered?
>
> I think that is another case where "MODULE_SOFTDEP("pre: cxl_mem")" is
> needed. However, to fix this situation once and for all I think I would
> rather just drop all this modularity and move both cxl_port and cxl_mem
> to be drivers internal to cxl_core.ko similar to the cxl_region driver.


Oh, so the problem is the code is not ready because the functionality is 
in a module not loaded yet.

Then it makes sense that change. I'll do it if not already taken. I'll 
send v4 without the PROBE_FORCE_SYNCHRONOUS flag and without the 
previous loop with delays implemented in v3.

Thanks


>
>> It is true that clx_mem_probe will interact with the real device, but
>> the fact is such a function is not invoked by the device model
>> synchronously, so the code using such a device abstraction needs to
>> wait until it is there. With this flag the waiting is implicit to
>> device creation.  Without that flag other "nasty dancing" with delays
>> and checks needs to be done as the code in v3 did.
> It is invoked synchronously *if* the driver is loaded *and* the user has
> not forced asynchronous attach on the command line in which case they
> get to keep the pieces.
>
>>> For the type-2 case I did have an EPROBE_DEFER in my initial RFC on the
>>> assumption that an accelerator driver might want to wait until CXL is
>>> initialized before the base accelerator proceeds. However, if
>>> accelerator drivers behave the same as the cxl_pci driver and are ok
>>> with asynchronus arrival of CXL functionality then no deferral is
>>> needed.
>>
>> I think deferring the accel driver makes sense. In the sfc driver case,
>> it could work without CXL and then change to use it once the CXL kernel
>> support is fully initialised, but I guess other accel drivers will rely
>> on CXL with no other option, and even with the sfc driver, supporting
>> such a change will make the code far more complex.
> Makes sense.
>
>>> Otherwise, the only motivation for synchronous probing I can think of
>>> would be to have more predictable naming of kernel objects. So yes, I
>>> would be curious to understand what scenarios probe deferral is still
>>> needed.
>> OK. I will keep that patch with the last change in the v4. Let's discuss
>> this further with that patch as a reference.
> EPROBE_DEFER when CXL is not ready yet is fine in the sfc driver, just
> comment that the driver does not have a PCIe-only operation mode and
> requires that CXL initializes.

