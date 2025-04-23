Return-Path: <stable+bounces-135248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C34A9822F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBB31899933
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3223274FF6;
	Wed, 23 Apr 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mVPmi945"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1791266EE0;
	Wed, 23 Apr 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395049; cv=fail; b=gSPKZnxNGQhbeE+CNQ2MLW86HN2dnooytum/R3huOdcFbKeVp/LD6JjFxahD+kvBWRgHhQv4IpD+IDrLJXlCp2/Uey3+0YBanGy6xzdJNyF9YXtx7JFS8bjgzMv0nKDeWtSr0jLqwfXUQRmjqoGNoWPAIa32rnJZMYQj1WJoRns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395049; c=relaxed/simple;
	bh=/4qFVT6SOq7txxmgb7gL1ThC+C8hd4aSfkbNBMQF57s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=useQu18mL3H/SM8AmH7OGhomCzv3PUJxroVXZC7FK7yoMIrUAqAzwknyFj+tdipbBdVq11ndm+C4QT2oVOvTgK2aHavI9HExIHyRDR8ftP2prxCJJb1P8b1SNmeNR0ZdHiz87ufw9rSXc46ApZ0Whs+7EutjgFGwtSIzU1sy2yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mVPmi945; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4muzoSmCXqVc2RQiqadz8PFqERQKS4iZ/7RkqPV7LAxWZXmdsZXHgLoMKGoCrti9GUUzfMVqpoBYN7ZDtO4vRFvr3bYJY8iPm54PdIu6WNo7Z1V+MAzdrZobNBwKFDtpkryk5Z2SwTQUwQlgeDrAulzfmPiFpeZzQ3Nt34nfmIbnASgpf6rPq1qijwHmGJRFSAk6VOKsYg/J/Cae9cr8rMJ7BR1BKYZK9ky6FaG8vb+Gb3PWaOJhG4EAiOYlsImET6KXkwqSGjKaX33QmsmXOYrxRj3eaep4eWUSh7yiRlamKj9sSU4pA9b7lN29GGggkrae2+LJ95I5LBaqAQ3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SSgOF4/HcsFA7S0W4f8J37OBneLgUbvjrl9YC++P1M=;
 b=dL3W9URdHx/xrHmQWGtQwLDi3zy2w+Y20+p6NsSOeAN86oLCUZdPpUZQVZdjUz/XqDdYU5aoaeep0eMQU/N2x9khK9xLQx4nShJBaRdJL6YwFPQJf0VC3geqobB/KvQICHYX+I2YZ5PYYepe9NJLth4Bb8ZxiXMjXtsVjEN4E85Ndsy+yKqzY1RJbR/YiPizw+dvI3HLv4Q9sipWVhKp4uZNEzXFa9JB3azVPAs7RTcjq2KnOP0FUN5x46k3KgCeIk5bTPNLAGUAZktMlT6jL5oA/q4V7tZoM5vZjNzBguC25qU6i84rEL7oGNTOoAuiE2Xx40u/hLSsfCDGwEXRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SSgOF4/HcsFA7S0W4f8J37OBneLgUbvjrl9YC++P1M=;
 b=mVPmi945UaUBY/mCJI4QF3OViv3CKhPAiTuIHeyy85BXFBC0rpXSofYQRsn6pgu2rZELab9mfs5rWmyAE06s5YViBPAEn6ZbIrOtR2JsxsPA4OpyPGXKuAPXCpZQRnhW4L3rdjGWtxJxjitwSPbJ1WaamzMb0X8UhVjjKXge/CQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:57:24 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 07:57:24 +0000
Message-ID: <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
Date: Wed, 23 Apr 2025 13:27:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
To: Jacob Keller <jacob.e.keller@intel.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Thomas.Lendacky@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, vishal.badole@amd.com, Raju.Rangoju@amd.com
References: <20250421140438.2751080-1-Vishal.Badole@amd.com>
 <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::9) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: e29dd1c5-ea3e-4b77-7ce6-08dd823c7b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGJuS3FQTkluZ0NWM0l3c1dTd0pnVjlZVVJEZW5nSTVPd0szRm1vL0NTMmdW?=
 =?utf-8?B?T0c0QzNZQWFjV1dwRlN6QzhqSmRWbklnTU50eDZ6MDdiRjlNRHZweVVYUHhN?=
 =?utf-8?B?cjFzdVVEUjhPaWdCN0svM05UOXBISEUvVTlEYUNuL2FmUTBzejhDWVJDZzEz?=
 =?utf-8?B?ZXVkV0swMVJDWWFZNytVcWFVZkJqdXJobXU1aHpwdXpaa3hBb3pZR01pTi9O?=
 =?utf-8?B?M0JzcForcGNNaXhZSnBRazdmNWxmR1hkWlJRSVBhYWtvQkk4dmtTN0NLU0pk?=
 =?utf-8?B?ck03V0hvK0dvV09PMFlTVTJaZ2FVdklOSy9MOUI0eW5LL2xhV2o2cmhRMHVZ?=
 =?utf-8?B?ZjZROGdSaHJvN2F2NVozWWg3RmRCMlBBRkF3aW1EWFJoL0RENjJLM2p0NytY?=
 =?utf-8?B?SjlMaHErY1NxbDlYWUdNUVdFRVJ4WERVblZqd00wR2VxRVluUVF3bFhRK3dO?=
 =?utf-8?B?dVBFWDBQVEtoSCtabVlQNFAwc2tRd2ZlcUJqZTQ2NlgwYUxDUWE3RTdtdms0?=
 =?utf-8?B?N3RKTVdkVGZicGVicVlSMDFlWW1samErd095SWFJaDQvc3VXKzcvSWE1SFgy?=
 =?utf-8?B?eXFiYWRmOVA5R3BtZGJweDhNSVZ6dGRvUm9SRGlTNVRTRi9TVjk0NlNKU0RF?=
 =?utf-8?B?TWdhcTNEYjZqVDJFWHJOTlFWd1RaS2NUanlVcTB5aGNDV055VEhSRHdSaVJq?=
 =?utf-8?B?clBQU3JxaFV0YSsxbjMrOW1vQXl2VHZsQ1o4b2VSUnRrOEFPWGhCSEdTVHlo?=
 =?utf-8?B?cUI2L2VjbVd4UEdzT0ptMDVDK1dFU3g1SjZGZTFhZm9pMW14Wnc5UFU1Vndw?=
 =?utf-8?B?SW5MRElNSkxwMXlwSkkrQzlRMjNPMklkYTd6aFFQejJzTEhlc1BFeG9pSFh5?=
 =?utf-8?B?Wm5zRmpUaWQ1R21QTGhFL2tXNGJCKysvaGwwSFRYM0E3Z2xybkcxM0dhN0Ez?=
 =?utf-8?B?RlU4ZUwzbWpjdWVhSnFKbDBBdDVBUS9ybWRFWWpkbmNzSjZUK3JwZjhMR01t?=
 =?utf-8?B?RDZSVmsxS21pR1A1c1U5QWhJRFhUd3h4aThHWGQ2U25RcUlLS2NqdGUwVjVs?=
 =?utf-8?B?V1UzRUQydC9MTDdyQzl5V2c2OU5DZFltRkVIME1wdllqNzNsN3BGUytXVUsy?=
 =?utf-8?B?eXdNWUVHQTlWU3RFUCtoTnVpdkdGTWFDQzJoUkZJREdXSVg1OUh4d24xcTd4?=
 =?utf-8?B?T1k3L24wYkZ1UXRvS0tIMXcrRk9sMzhUbk1XaVI3aFpZSHo4emJJcS9WT2JZ?=
 =?utf-8?B?Q3czRjJmejRNaDBoZ01iRzJ2b2N1RTcyUlNaRDVVZ3F5eWZuYTNNWXQzYnRS?=
 =?utf-8?B?dVhzNXJHMENHSWt4eXMrR3ZOZW5OK1hoZ0IyUDNUYS9wZVpZa2VxdFNnL2hp?=
 =?utf-8?B?SkwyTGR0R3FoMWRFNWs2czczY05aWlprNHVMNlBXbUdxdC9VU1E3Z09FQVRE?=
 =?utf-8?B?U25XTytYQ21TU1N4VDErQnNuNHl6bmtDcFlmbFZHSFlTS2crNUpIVFEwZzFL?=
 =?utf-8?B?VTFzZ2V5MnlJd0hlWStBV3ZMQXIzL2o5YU5RbXFNMWNNcWQ2dlorOVdLMjFH?=
 =?utf-8?B?MSt5aXBBZTloQXFEZ1lMN0h4dCsyQkxCYTJZaWNjVk9Jd3Y4NHlSMjRsMFZT?=
 =?utf-8?B?M003VVJNejFVMmdXSVpucitvY2RGWmlrenAvckhyaENBSVNUdkZMR1g2ZW1l?=
 =?utf-8?B?c1VKZDMwa3dQV1A4ZUNETUx0R0RTckFkbWxuYWRnSCt4cUJDSFBWdTdJS2Zw?=
 =?utf-8?B?YmlkNEdPYWczRGxlZEF1SW9lL3ljWnRYczZzRFFZbGcvRHdicG1ZVzJyMnM3?=
 =?utf-8?B?RlhHNTRPVXRXVXVSOXUvMmxPVDc0NGc2S2JQZ21FY2d3bFBPbGpHTmFRM3pk?=
 =?utf-8?B?ekczOFIrTTVsTVovRllzSEdoeW5ZaVpNd2d2cUt0VGNrQ0RSTGdrVGhOSFdh?=
 =?utf-8?B?WHV2LzcvWWQ1RGV4bmdxZzZZWnJkdzVwd3JqelYyU2x5aUc0MXVwK1hHNXo2?=
 =?utf-8?B?cHdGd1NGQ25nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1VWbnExRE1UOTIxVUxUVmZ0WFRETDMzaXlGWHVnQ0M0WnI2T29IZ3VYcjQz?=
 =?utf-8?B?YSs0QVpzWnQ5OWR0Nit4Z1VrTkM2Y1RLZTl1SDM5c1NZT0krdXZFVXlLMzdI?=
 =?utf-8?B?QnFTZzR3bjMzeng0c0NKZy9pVVN6ZEhPaWs1b3pvS2FMeThsbm54Sk9xMlFS?=
 =?utf-8?B?M2lTSVZGdXo4d3NHd0hCVFltd0RjY2RIdG1nNjBIa0hsczU0eVJDL256Q29P?=
 =?utf-8?B?bDhJR05NSHRGUWY5ZlFRbXJGcWpnUU5ONnFSdGF4emM0WlJvdWFLMFBIY2hC?=
 =?utf-8?B?T0ZYajZkRXUzd051NlJ4UmNVOWNQdHhPRDdXMkdjVVhwRWplTTh1VnNrYThL?=
 =?utf-8?B?UWpzekZaaFdVa0cwbklySnMrbndLN2VRUzJNNXRYUlYwLzcyclhWNFJMa2k2?=
 =?utf-8?B?cEZwUVJiTWRMSk40REVYWEcza0xkUkwxc0JBNEhtVmJGc3R0eHdEVjNORGdl?=
 =?utf-8?B?ak85a0M0dGZIUWxzMHo1OXlKSG5LTWI4blEyQ2Y5eHVEVWlIT0h2SVlDQzBG?=
 =?utf-8?B?cWRwSVVsQ0pCMlJDSkgwV1NnQ3RQeXc0U25VK1BzRmxWSStqOStTTG9ZRjFm?=
 =?utf-8?B?bGVGUWE1R3p4Q3orMUZYZ1FtL3lJTFJDL1hKbFlwQ0treE82T1hrbDBOUU0y?=
 =?utf-8?B?MEhPNHltTzEvdmRFQi9kR1BCVVdRc2lwZURIWDB2ZS9KVUFIa3pMUE42MW41?=
 =?utf-8?B?US9uR0dUY2J0UlJkd0t5NzV0UytIT0ExS3NySXgxRFpqaU85aDhDMEppdDlj?=
 =?utf-8?B?VmFieXpUWktTM1c4L3BtQy9CY2YxQTNQMWVCZENwV1MwWThHTHI0elE4NjFq?=
 =?utf-8?B?KzRibHc2bHNhcWlDU1NYUkVNeHpueEVSM2lQWWNZUnZDUDdvTGlRSmhwOUwv?=
 =?utf-8?B?V0ZVMFErMzhlZXhOeFFhN0c3c04va3REVnpIVmpRTkUxc3ViYkYyeWdaZFBV?=
 =?utf-8?B?aWNMbm5VK3lwUHlqOVpKM3FBVGdJU080Q29HeUxGdFNWS3M4YnNsbjYwQTFC?=
 =?utf-8?B?QVdTZGZlcVJHVEQrWCtsZDdXaFh3dlQ4dHVBV0Y0aVR1K0wwVlFDT1VkSVd1?=
 =?utf-8?B?dlhHSnJucVQxTXhDMW9ZT200VmQ0bkV4MFhBN2NESXo0YTN6U2djUzRacnJs?=
 =?utf-8?B?QnhjZzRGZFduRFJsV21WaHQ5VWNxcU9sTHRncWVrdUtsSnFFR3huSVZlbWtz?=
 =?utf-8?B?ajNxZGNjQk54YzVJenJLaXRFU2czVXF0Ti90aENPdXo1anplVHVCeE15VGdN?=
 =?utf-8?B?U3BsL3crVHlXQnIxc29XR3BiOXJ5KzFFQklMRjBwMW5wTE9BNW1BaHI3bHRj?=
 =?utf-8?B?dGx3b1JEYXd1Qmg2VFpvaGtYS0tNSUNNdmtVOHdFTVEzS1hZSFgyY2daTWEz?=
 =?utf-8?B?YU5UMVEvL29FUHZoaU9LS04vU3krcXJxb21WdHY2R2Z5em40YjZWK0ZVb0lV?=
 =?utf-8?B?Y2FLODRpUGVvV2t4UUpJZU9CQktKa2NhVWt6MGRlWmYxb3FiS2cyWE1Id1hT?=
 =?utf-8?B?eE1DYnZIRnFLWU1TcUtXSnVPVGRtNU9ZU0FIMExxVUU2TzdRSVAvVjcyZkhh?=
 =?utf-8?B?Um8vZDBBVTdLeWZ3UCtsdEdjWnBhSXRhZ1BtV3k0bElDNWNNT2xwc2ExQm1T?=
 =?utf-8?B?cjlBaWFCbzNKeUlNZlE5eDZ6Q2pwTmd2SktYdkZUbWxCVm1nZGJSbTdqMnpR?=
 =?utf-8?B?RGU1WUh2TmJDM3pDU3I5SDA5bTVVek1RTFpzY2ZnOGhVSDB4Tm1xRE1FS29K?=
 =?utf-8?B?S0FyeTY4bWNHbzhNQy96V1BlckJlbXdiaWNVY1hDWVhVMW5DcEVQRUdyMkg3?=
 =?utf-8?B?UGNvMEVWNDhiMWRKL0t6ZDlYRXVxWFhPRHdpL1BHRmowN1VMcHJISG4rWmNq?=
 =?utf-8?B?bzNOSURVQjB5TDM3MTZYV1hVYkZvaWRveXBhY2JMUEZJS1dia3pBdDUxY0xZ?=
 =?utf-8?B?VlhodUoxUVZMSjlqT2xWVzZCdC90NUh1ZVJ3cVF0UVNEbW1uemhkVnhiQXBE?=
 =?utf-8?B?UGVlOERoMHdaMHF3SHJOWU1QVVRTQm54WG5FTGVoL2xVeW1Kenl6OVo4SDNC?=
 =?utf-8?B?U1dtaTZvWFFVcTdJdVk0TDdxOWg2UENoMGliaXZNNEpMYlg1YUhORXYwNkxu?=
 =?utf-8?Q?Q7tCwcGEPXR5kQ4OzkAlw5fFl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29dd1c5-ea3e-4b77-7ce6-08dd823c7b1f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:57:23.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SclxATTl8EXU7OxP63Uf11LAEvpnvVgUf6mXJdtV0L/7YlcP54FGp4T7nsGR/YDdN+bStJNO+9xYLGmtb9ZOQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979



On 4/23/2025 3:50 AM, Jacob Keller wrote:
> 
> 
> On 4/21/2025 7:04 AM, Vishal Badole wrote:
>> According to the XGMAC specification, enabling features such as Layer 3
>> and Layer 4 Packet Filtering, Split Header, Receive Side Scaling (RSS),
>> and Virtualized Network support automatically selects the IPC Full
>> Checksum Offload Engine on the receive side.
>>
>> When RX checksum offload is disabled, these dependent features must also
>> be disabled to prevent abnormal behavior caused by mismatched feature
>> dependencies.
>>
>> Ensure that toggling RX checksum offload (disabling or enabling) properly
>> disables or enables all dependent features, maintaining consistent and
>> expected behavior in the network device.
>>
> 
> My understanding based on previous changes I've made to Intel drivers,
> the netdev community opinion here is that the driver shouldn't
> automatically change user configuration like this. Instead, it should
> reject requests to disable a feature if that isn't possible due to the
> other requirements.
> 
> In this case, that means checking and rejecting disable of Rx checksum
> offload whenever the features which depend on it are enabled, and reject
> requests to enable the features when Rx checksum is disabled.

Thank you for sharing your perspective and experience with Intel 
drivers. From my understanding, the fix_features() callback in ethtool 
handles enabling and disabling the dependent features required for the 
requested feature to function correctly. It also ensures that the 
correct status is reflected in ethtool and notifies the user.

However, if the user wishes to enable or disable those dependent 
features again, they can do so using the appropriate ethtool settings.


