Return-Path: <stable+bounces-214554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMPSInD/hGl47QMAu9opvQ
	(envelope-from <stable+bounces-214554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 21:37:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8064F733F
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 21:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605FC301C886
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698CC32D7F7;
	Thu,  5 Feb 2026 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q3FL2DJ6"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE42F3601;
	Thu,  5 Feb 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323789; cv=fail; b=lFjSa4HlGu8FVeHiWmaTMPh1aWxu+Zjt7yGNBhPHU7Sk9cJy5BphC83VxFs9+1PzaXlEC0Nb8W+qbldRrciUg1FqBri2VDyifFlfgJGidNZE1yF1eiYgQHJrgTfumP2AS8lQOuaN+CobOZHYnMJ+FeKMJwfoqv8+W48242bgUzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323789; c=relaxed/simple;
	bh=Pi/4AbkcyoU1KPmkUhy2OTPU99nG/2OQEW0QqxaJjGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9u4FN2mLKOGqILEStjbkQPFIkVoYHDCxaRpLOA1LAvKVANauTSqswZxbG0U6YjbpGXLDX2l9XO6Oafk/KFNIBGktou7KIJwJDIvFuQKC+ErD6bZd0rkp6h2FoCbWVQrso4mE/my2d2zzI2iAm5Z0yfewC5RjbWKV1/sGfCTw5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q3FL2DJ6; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj+QRW2loOGnx/zMkoAPiGDUeyi7khHq3nsxpkzJ9Pnl9Cf2t/fn2ft0wSE0b92ijWAW7K5/7Fyl08noXmHSlsCdgm0yn4wDg0eHccMgh9Ntlyvmc6xMW2peRDMALDHi/VDQfvdtaHAD1CKEsZgPuR9qMOdTbC5nZa1TjEgn9O6IjUb2mG4aqq08+/0CP4yPh/7PTQDAC2Rfr4WzksDmPSQxnGgQ2lZPt5PzEkcqLVBQ+3JpuEwt6w9xGAqrkKDiDBmzutSFSHN0gHrfxJrAQ/XhReu/RkMsb1Oqa4K0u1PzENzijl1sXmKucFMqBGO4IJjPVpylOqeYBPemUxObPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9D+02Pv45rUPL0Y9byFJra7DOeea7MSRX5apNhLEn4=;
 b=aJvKSjcbucmd7l+BaCny2Orf8L22t3b2lVNzEN2LbqmJxut5gYhzB1gS4MZzLRobj3LNRdhFav3qBAHFnhK+ssMRoVn7iqgfjDtq9lF7uZ3alwRjutKAAdo3VqV8RSlxhEt+F9vrZbA5eGW1lAW4KK0zeJkKBFyQ6l157Rmb0Xinc9anL4XIOIzhj3h28JM23tM31HrgWWucfbzO91v6NpA8IbNeyxra3p3DycDhspzgcUdH/NOr/1VNdTYqLpkrxvyZCcKxpGKzB/SAPRU3KmP+V9H/DzIFgbIPx3LsMspn/YbxpBtKufiE3Qsr+bkiiZigwVO+DaO4x/Fx57qBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9D+02Pv45rUPL0Y9byFJra7DOeea7MSRX5apNhLEn4=;
 b=Q3FL2DJ6OsIlX/cGP38Fh+oH9q0IshKiAymxNzdnuL0MdBPYw4shp8Z2FL+hh32/Aixf9wyMhb0BIQr29PIFu7UZPGkh0rxCi4hA8QOvqx17JuQ7LXnsMAz0B8/75E4cbBPFki8MhkEBZOGTLLz6LFrvzJBj0PYVYk0eR6yQNT2W8uHa/eW171vvRK71Cb3t7K6Q2xGvTDeg00CjmF2UATwP65Jb3ZScw47oAIvw+5tdztCqDfQNdFhORrVVeNnJXjEL56zFJ1OlTXxomjQOEQDJX9HzpBxz7oQh+5zeeSkbMI6MD+EwRx6fEi/YfZCXxf7cEPK1RM0beqYgW8Gd+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8973.eurprd04.prod.outlook.com (2603:10a6:102:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Thu, 5 Feb
 2026 20:36:24 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 20:36:24 +0000
Date: Thu, 5 Feb 2026 22:36:15 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paul Moses <p@1g4.org>, netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by
 fill size
Message-ID: <20260205203615.t3n3bbqmjscp2cnz@skbuf>
References: <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
 <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
 <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
 <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
 <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
 <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
 <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
 <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
 <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
 <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
 <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
X-ClientProxiedBy: VIZP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cd0eb0-eceb-4f73-fc5f-08de64f63ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7416014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm5aRi8vaXIyRFhldkNjb2VkSDJueWlkWEc5T3BDc25tdjNRODRnbzViWU9m?=
 =?utf-8?B?QXJKOGhyMUlmK0pKeTRLY1FBVStwY3ZVZjhKb3FMM1JtS2w4OS9PTlAxakFT?=
 =?utf-8?B?a0FZVWF3TitHRTdxWFFoelljUWhxVFMzOTdMbE02eG1INDMraGluVmtZdWE0?=
 =?utf-8?B?M2JVYmhsTFhNdk5BSVdObkdKRUMwRDJkdzMxUGNITjB0YkZoaFNTV21qR1RP?=
 =?utf-8?B?UW1KL09ZcElXSTBqbmpkRWkrRDVUeG12WVFiZWdqaGxNR1p3VW1raVlFY0cv?=
 =?utf-8?B?MmtCMVF2RGNudit5emQvMFQva3R3NHc2MW1MdUFSZkhoMGx4WmVCTnlHWVQw?=
 =?utf-8?B?TEZJSGtjNWZsQ0s4dnRFK3ZQYzF3SUxkMTVkS3FFSEprOVBLVEhxU2xhU1hv?=
 =?utf-8?B?S09lclYybWRVd2FmUXJLUTNnMjBZUUpkd042UUdWNXgxaG1oTHYrTU5UMml2?=
 =?utf-8?B?NUZZVm16bDZlRS9iSkNYR2tWL2lKNDJkSUx4WG5SZnFubC9kUzdEOHU2c25j?=
 =?utf-8?B?dWo1SFFKcXhpQ0J0bzZ5bnlXOFFad0N3OG5NOTIwM2lCQS9vYlFwQ2tUQ1Jy?=
 =?utf-8?B?REhFQ0U5OEdPSlAvSDBLSDR1a2VIZzNjZDZHbE5XLzAvUmg5SitucG1HLzdn?=
 =?utf-8?B?bDgvYnhFbHVGaE56VzQxNnVuUnBlK3QrWEhhSTQ2dEZrcTlxTWdYVk40bWxZ?=
 =?utf-8?B?QnJYMkdpUjZzZDlRYTZ5L0hOT2FTSWxQVVNTc0NrbEtEQlVnd1d2Kzl0VStP?=
 =?utf-8?B?NU9aY3V5K1E2T2xzSWxMNG9rbEZYM29OVndET0o5U1FrN0tOR0RIc3ZwNlQ2?=
 =?utf-8?B?dTF0czk4QWp4cnNqSkMxNjhpZ2hGa0cvbzluRjF2R2VsZXVCRzc1Mmc2Nm9C?=
 =?utf-8?B?ekxnMGlXTExudXVPNXk1RE1SSTJRUnUram1SeE43WDN4cGRVcVZTamFIT0VR?=
 =?utf-8?B?VkN0NkxHSUZVaFh3a3YzWk1CcWVLL3pXeVBsOVNUU3hDOUVibWxrME9KQzJT?=
 =?utf-8?B?OHhoY0NQMWY2Wm9NNW1jQWtEREZEY3VJTnVLZHVUSkxLdjFERDB2VGd4UVEw?=
 =?utf-8?B?WGJyVkVlWnU3allIQmJNREZuMks5bG91MHZjWDNwWVFLTlkwVGo2RlU0OEg4?=
 =?utf-8?B?TE1yeWtDaFc0b3pqS3MxTFhTNDRDckNqWmVNVkI1OS9ybmhkRU1SSVFIdXhM?=
 =?utf-8?B?dk1SRnVMMitZZkRzNFlPWmRHNHpJdDRPeEFrRmhQRTgvN3FwNkx3TkJGQkpH?=
 =?utf-8?B?VVhPTjN2c3JlaUFFNkRIWHdTbmVSQXA0YnM4Zy9VSVdaZXBNV1orbEViWUFr?=
 =?utf-8?B?YkpkajFzT0dEakdhQzhLYmhrKzhkUXFIMFBwbVNLVFJVU0hpWC9aR0FrdmEy?=
 =?utf-8?B?NUJLMFZRZnZ2Rm5LN2lDVWFGZHhNL3Y5WWVRMlRzNFloRmszTU5RcmtSTWJY?=
 =?utf-8?B?Z1IzdndYcE4zdHJhUng1ZXA2RFNYL1dpNHIvYXdGdE1OUitLVVNieWRvYm96?=
 =?utf-8?B?c0FLZG9Hb1Q0SFJHUHkrOG9iaCtQWFdHNWNiZVZ1TUs5NHpyQjQ0ZWdpTnpP?=
 =?utf-8?B?YTA1Z1hIazYwdW1KYVR6NE9NaGRuQlZLWjdoYzF2b2E0aFhpWHArS1ZRZy90?=
 =?utf-8?B?MzJESUdTczU2T1d0eWExODJuUUJlYStXQTdPNzBGQ1VOc3RQZ2s2Z0xXSXFU?=
 =?utf-8?B?V0U2ZVE3SnJNck83dzFyc0xHb2hETTM1WFlrTW0xOVdLc0FVY2FyNUxMU2g2?=
 =?utf-8?B?YjdlNXFzWGxDR3NKaUE1eDlhTkNhZ3c0TytoUXBObU8yTUpFell0WVZraWpD?=
 =?utf-8?B?SWpTRmtlK1FsQllMZnV5QVdsRTJ0UTA0ejBJMTBwQU5Ea3k4YWVmSWJJOW1F?=
 =?utf-8?B?M0NuQllTaC9tVlNIemU3dlIzZXIxVi9IZE5McjZwcGJuK2xiOU9POCtzNjRj?=
 =?utf-8?B?R3VmT3c3L1VxUE9pY01hQWR2N3M2ZHVjRkU2aU8rZWljUWFBY3paK0VZYTBp?=
 =?utf-8?B?NkVDdnhkbGR1eEJYLzczdDlnTDJKY3NPRG1wbkhuNk9ZZ29FL1BERUpJTG1r?=
 =?utf-8?B?ZVlwN2FXSTI0R2kzVXV5NmZ6SVBaTkREUWZHMS84cTYvSWJTZjlDdXBLcnEv?=
 =?utf-8?Q?WA2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7416014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FUS3l5eGFiK0tBR3ZzQUo3TzBPd2Ntdlkrd0FEZTR6N0VHMHZrY2lFTFQy?=
 =?utf-8?B?d0lOZ0NDTkhBRExJTldjZTViKzNQRC9hdWxyd3JmZE8zNWFaL2F6Q0xUekRB?=
 =?utf-8?B?Ym5tV2N0V0hrR3BwZEw3Z0JlTXVqdllJM0ZzY2dnZFplY3RFdjVLc1ZqUDVj?=
 =?utf-8?B?R2JtSXFWaTZtVzlnVjZoR2hXR2lpVkdoZWl2TFluR1QySVRpY3JQTmdUbjJZ?=
 =?utf-8?B?YjJJakVoc3FhTEJiZ3I1bERodkxFMFordXVScVRSREVFZ3FJdFc4RXEvWFRN?=
 =?utf-8?B?emgyYkdUMXlxVCtxeGtUVmo1Ky9WWW5OcVhmbjNJbHhqVjlLR0phcHkyZmFp?=
 =?utf-8?B?L3pYNjcwVDJITXlkWTZtODJ6YWw0NXZXaDFqMnRHbXpTbklYWGdxRXZ2enhu?=
 =?utf-8?B?NzhOM1J4UkxpOTFaUzNoYWRBYk1GcXh3di9ZYU1aL2RXd1BjL21qQ3JaOEhr?=
 =?utf-8?B?ZVRqOEFQbG1UaGlIWHRadi9UWkxrZjBYTVZnRi8yWllJYnNJTnZiM2tZandw?=
 =?utf-8?B?STVoeWRGR2hkZEoxNDE4a3dXVGJDcis2SUpQTUkzeXlObG81Szl5Z21aQkZw?=
 =?utf-8?B?clp4c2ZyQWtTYVR6bkRjQTdjUS9HNjVEeHpiQURFUVpKUzNMV1NHcmlxSmFB?=
 =?utf-8?B?N28vVmM3SUo3NG01Smd3M2YxSWo5WjJPSHM1QnVvNXhLeFZjY1dObVNPaS9K?=
 =?utf-8?B?UCt2aFRwODRxZFlrQ1ppcGtDZnMzZG50NWtxWGg1cDlGcU1jM25RNjdVVjVN?=
 =?utf-8?B?U0ZCVk91YnEyZ3VZcG9ocXBmbE9Dc1NsbzcwSE12aFBuZnJLTnhMSTVTbWsy?=
 =?utf-8?B?SG5DRGR0NVdBVkc3MEduSVE1S1BxZDZyVHFYZjhlUnU4NUtsK2RMU0JsaXlJ?=
 =?utf-8?B?VHU2c3ZESno2cWVMKzhkMlNrWVY1VWpPS3g2VkQ3aG1qOENjenhSZFQwSzVN?=
 =?utf-8?B?ZHh2L2hFWHNRVHNxbnFSczMzQjBVRFRzRCt5ZXVBanIrRHpidnZIZ3h4a0Fz?=
 =?utf-8?B?Y1NEVllFVjhWcy9xR1lWT0pMRWo0dGR3UW1PUDIxdDNuZ3BKVkZKS2dYN3Ax?=
 =?utf-8?B?clUvU085TzY3U0lWelNXNjdyK0ZWR0gzazNoeVcxemxLTW9sVlZPUk1lZjlX?=
 =?utf-8?B?Zno1ZmQxNmZWOEZ2QkxyM2FzMGZ4VEM3Zk9nN2RlK2JtbFJOWXJIVTRGWkt3?=
 =?utf-8?B?blpXRjlqZUErbjVZOXR3bnJ2dGtTSGErUU00YzBNYUFuQlZERXRIN21sSlMv?=
 =?utf-8?B?Ny81Zm5Ja2NtMVY0UVUySHhqd2x0anN1dVJYZnZBbXNTNzdNZTJETHlXL1Er?=
 =?utf-8?B?N1l1SXppVEl4UGhleHFkMVE3cWFnRFEzWU95dFBuWXozc2xaV2htK1N5T1BH?=
 =?utf-8?B?Ti9ta1dEQTRWUXc5VUVxWXNtZ1N4MGNIMGpnVzFobzFRSFFLOVA2NWt4SXVu?=
 =?utf-8?B?V2gzazl5cFpvWm0zZ1A1dHQva1p3NkIvWGcxMjhrNWZSNGtQTW9qTzh1RUt2?=
 =?utf-8?B?M1dGVWZWWTZlbktxYmtsY0dHOWR5WEJaNTVKeGRlZUJWODFYTWFDeFIza1k2?=
 =?utf-8?B?QkdHd3dvNkp1ZzdDZXlPckRhRjBHaEQ2TVhGamJXcnp3dTlnOFVIWWhmRFRS?=
 =?utf-8?B?dldJOU9obnBYbUtQUG5tUlJVZTQ0KzNudkkwa3VuQmFKR2JLekt0MGhaTzhK?=
 =?utf-8?B?OXNEdkVNWElHSFYwSGkzWjdiODdBWVlpclR3QVpzZUpNM25yZVJlbG9CUkxK?=
 =?utf-8?B?Ukk5eFlDU3N2Y0NVYXdESC9RcFRudFVqV09Da3U4Wkd2WnA2ck1NVnlvaWVH?=
 =?utf-8?B?VWhnUXpuelhDZXZLYkFrOWNmc2dHOEdLWitnWGdYeUY0Z1RUOHFvM0c2UVov?=
 =?utf-8?B?Z295cFByYW0xdzVoOEhTWkExVDVpU0djUGtTOGtiajhxNG1tNjVheHFsMXdI?=
 =?utf-8?B?UTkxRWRqRjJTcDRBaVdoYUttMitxd0srZlVUZUljL2JxTWFVNkU0TzM2bEF2?=
 =?utf-8?B?Wm9nUEx6RU0yQis5Q3JzTjZZVCs5UnJJWkxSQVlQWWJDeUlhYjEwb1VDOWRy?=
 =?utf-8?B?cWNzODFKSm56WVJWMnNRQjdFWUwyRTZTTVNMRHJITzYrckUvSTU3TzN3RnRy?=
 =?utf-8?B?Q1IrYWZIRTRSVHVWQ1FkVHJrQTQ1SExacjlyTURnSk5EeWVHd3g3L2xnd3Bx?=
 =?utf-8?B?ZUVJd3h0WWg5WXVSb1JjYU5QVXVqYkpjRk90aC8rTTloMHJsQzFyWHRsOGdU?=
 =?utf-8?B?Zm5OVkRnWXFScys5N2ZXRnIwckpNSCtmV3JMZC96Yyt0TXJNNCtTSkVBbHJF?=
 =?utf-8?B?WEhFWnlwcHhkWVFtbU1UWDVSQkJHNGpJaHgxamtpMG9QSUR4UUliK2dqTXZ3?=
 =?utf-8?Q?7ugiawOpuU5iF9Tq6SkWh2EQDn6wmZwPqtGBE8+Vd5Mss?=
X-MS-Exchange-AntiSpam-MessageData-1: uldU11TAsMxRbR91dtraoYVldYNE+FXF3iM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd0eb0-eceb-4f73-fc5f-08de64f63ab6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 20:36:24.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10KAvaQym4GQ4Z0cggY+LOpbyYFmdk3a/vMFw32mIWLWsyRFtYKF5QJmdS65urp0saYHvLvDTsgmM141PVZp8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8973
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214554-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[1g4.org,vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,intel.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:email,microchip.com:url]
X-Rspamd-Queue-Id: E8064F733F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 02:23:00PM -0500, Jamal Hadi Salim wrote:
> On Thu, Feb 5, 2026 at 10:13â€¯AM Paul Moses <p@1g4.org> wrote:
> >
> > Looks like pedit might also affected. Hopefully this makes it more clear. Going to wait on more input before doing anything else with this.
> >
> > NLMSG_GOODSIZE = SKB_WITH_OVERHEAD(min(PAGE_SIZE, 8192))
> > SKB_WITH_OVERHEAD(X) = X - SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> > nla_total_size(payload) = NLA_ALIGN(NLA_HDRLEN + payload), with NLA_HDRLEN = 4 and 4 byte alignment
> >
> > Per entry size for the gate list:
> >
> > Each entry is a nested TCA_GATE_ONE_ENTRY plus five attributes:
> >
> > TCA_GATE_ONE_ENTRY (nest, no payload) -> 4
> > INDEX (u32) -> 8
> > GATE (flag, no payload) -> 4
> > INTERVAL (u32) -> 8
> > MAX_OCTETS (s32) -> 8
> > IPV (s32) -> 8
> >
> > So one entry is:
> >
> > entry_sz = 4 + 8 + 4 + 8 + 8 + 8 = 40 bytes
> >
> > Fixed overhead for one act_gate dump:
> >
> > 1. Action wrapper (RTM_GETACTION):
> >
> > NLMSG_HDRLEN + sizeof(struct tcamsg) + nla_total_size(0)
> > = 16 + 4 + 4 = 24 bytes
> >
> > 2. Action shared attributes emitted by tcf_action_dump_1, baseline only
> >    (no cookie, no HW stats, no flags):
> >
> > TCA_ACT_KIND (IFNAMSIZ) = 20
> > TCA_ACT_STATS nest = 4
> > TCA_STATS_BASIC = 20
> > TCA_STATS_PKT64 = 12
> > TCA_STATS_QUEUE = 24
> > TCA_ACT_OPTIONS nest = 4
> > TCA_GACT_TM = 36
> > TCA_ACT_IN_HW_COUNT = 8
> > action number nest = 4
> >
> > Total shared baseline = 156 bytes
> >
> > Optional shared attributes, only if present:
> >
> > TCA_ACT_HW_STATS = +12
> > TCA_ACT_USED_HW_STATS = +12
> > TCA_ACT_FLAGS = +12
> > TCA_ACT_COOKIE = +nla_total_size(cookie_len)
> >
> > 3. Gate specific attributes inside options, fixed part including TM:
> >
> > TCA_GATE_PARMS = 24
> > BASE_TIME = 12
> > CYCLE_TIME = 12
> > CYCLE_TIME_EXT = 12
> > CLOCKID = 8
> > FLAGS = 8
> > PRIORITY = 8
> > ENTRY_LIST nest = 4
> > TCA_GATE_TM = 36
> >
> > Total gate baseline = 124 bytes
> >
> > 4. 64 bit alignment padding, only when
> >    !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >
> > There are 7 attributes that trigger the 64 bit padding:
> > -three stats blocks, three time values and the gate TM
> > -Each adds 4 bytes, so add 28 bytes in that case
> >
> > Putting it together:
> >
> > fixed = 24 (wrapper) + 156 (shared baseline) + 124 (gate baseline)
> > fixed = 304 bytes
> >
> > opt = nla_total_size(cookie_len)
> > + 12 for each of HW_STATS, USED_HW_STATS and FLAGS if present
> > + 28 if unaligned access padding is required
> >
> > The maximum number of entries that fit in a single skb is:
> >
> > Nmax = floor((NLMSG_GOODSIZE - fixed - opt) / 40)
> >
> > If PAGE_SIZE = 4096 and sizeof(struct skb_shared_info) = 320:
> >
> > NLMSG_GOODSIZE = 4096 - 320 = 3776
> > Nmax = floor((3776 - 304) / 40) = 86
> >
> > 8192:
> >
> > NLMSG_GOODSIZE = 8192 - 320 = 7872
> > Nmax = floor((7872 - 304) / 40) = 189
> >
> 
> Seems arbitrary and I was hoping you dont have to change iproute2
> which restricts the total size to 1KB.
> Earlier, unless i misread, you said you are looking at IEEE - what
> does the spec say?
> If i am not mistaken, the spec is   IEEE 802.1Qbv which unfortunately
> is behind a paywall.
> The closest i could find was a vendor talking about it here:
> https://onlinedocs.microchip.com/oxy/GUID-82119957-1E11-4B69-84AC-EF0EA08F5595-en-US-5/GUID-7E7509A4-351E-4D82-8266-967681BA2644.html
> 
> And they seem to indicate you can only have _one_ off and one timer
> per queue, for a max of 8 queues.
> Since Po is AWOL, +Cc the taprio folks (Vinicius, Vladmir).
> 
> cheers,
> jamal

Sorry, I haven't been following this thread, I don't know what the
question to me is?

The tc-gate action corresponds to a feature which can be identified by
the "stream gate" keyword in standard IEEE 802.1Q (-2018 or later).
It is a sub-function of clause 8.6.5.1 Per-stream filtering and policing
(PSFP).

This is different from what you reference above as taprio / IEEE 802.1Qbv
(old/obsolete name for workgroup which later became merged into standard
802.1Q as clause 8.6.8.4 Enhancements for scheduled traffic).

The tc-gate is not defined per queue, but rather a standalone object
that streams (tc filters) point to. The schedule (or "gate control list")
size, translatable into the number of TCA_GATE_ONE_ENTRY elements, is
arbitrary as far as the standard is concerned.

We at NXP have hardware today which supports up to 256 gates in a single
stream gate control list.

I'm not sure I understand the reference to the [number of] timers.

