Return-Path: <stable+bounces-148151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1772AC8B81
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635B24A19EA
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E6B22126E;
	Fri, 30 May 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YBDev9d+"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D478F59
	for <stable@vger.kernel.org>; Fri, 30 May 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598883; cv=fail; b=OALeb00e2iEPJw88Wc7ET4EdYv/BRubLYDNvec9A9uYbhw/3G7OIIW+Q6bmhoY9nlTkbhmwpY8XgteuBQmntPnP1MhHqZfI4ffFINzTCNBRg5WIidDKXcsjJp+/z4c4g2vhUq3vQMm9X8n5Ga01sQ5VBREqtkV6K922EZFkoSbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598883; c=relaxed/simple;
	bh=wF+Q8VRmDyAaYmH5AgWm7NabHrts9mOduA4EQEbLh9Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mALbjt2nY3dAWGoSvZU7BtNdocKrS4DUJaDFQaG3vs7Hmh9FSEx5GhF4bqqy/BA4pnNlMIryGprK26xsixOeJcEqnogPtb5wd1UHxmpaqFgS0BmnJAdAZwRcDZ1Zm3foRliYpcZgTyZxkizckeDIPOYk3YSYITauRgDEO6ue++k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBDev9d+; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXCLiYXjMU1Lg+GwNAqfP07K7cQ1/xtSNt5xulN6OjK3OJ6TsdpsfxknhSfj8IVbThYTfLqticaQy0GcKpxhHZbcfxe0dXQmtBDZ+JUbyAuLlDxHrAo/U7weH8QwdUKx5Bbz09mq0z1o72R526tPWQJP2XM1QJUoNvJHU/qRdseDriKsfBkkWjEmlNKsMe6xMu/2OvHIAr/gOB2smR9pIRvLcxBZu+VnEt87tXd9kWNcZHIasTQF+ZmQCEyjcYJRSgDPH7RuWz9nnDTsXiQgb5BUvA4vG9kpTMN90Kk556Zug1Mt4bdj2z8jayJtuvDsJCs5eQxdNUBrVRsIaRwqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP2pPk7aYqo8R0loiK/Q4rwirSUONhLD5bzcdvmkzY8=;
 b=c23DYztYdyaq7L7rBGUAg7DQfJdE39RpXzSkRf0KLPU8sHo5W2rdl0B71atsEv2bSkeobfHI6jrkjL8a36Ph5iY7uMnjPd+oSO6DPFTzk0x/y19VpbQ6QmdPr338URB3ufPCZoABTQj9CoDBzJSHUQ58qCyQArfhM7e1qBzoLVsH71y3XBRhHsw77xtY/XSzQQJIoVyYIugZd2dkL7f7ThGd1OZBQbrfmD1v19rJHO/yGpxFAcaxHi5+9Ulyywt5peS3zKzWjA1+bcVYR1kpnJvyAkzoNaPtd1DBhYUPsjq1UohLfEQTAprexrnRbSEGoYbteS8oLsNxgGCrgX1F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP2pPk7aYqo8R0loiK/Q4rwirSUONhLD5bzcdvmkzY8=;
 b=YBDev9d+ospQpsGCVBNhGtYfjwqpLr0K+Lkx3IV2qx351OuPP9ct2Vqlgf5g2lIM688t7hzw6wd7QmUAAkELnjOT4MkM6zRxMvnBp65CQOnjeAzg99GWFaLfLqP0zo4ssW3GtFISKb727eKnqjj+sLEOF2hsBaSYZxVIpKtyQUHtcxRgEPLKLaNcJchVZerMP2njtNAd233Ijk+2uS8FY3ZSFUUKBcAT4c23ndy+BgWPICynlM/qh+wpojNC7h6X1Gxm37qSWbqsFYARzGaVW+CiarUIKR76vSP9gO+usRvSYGop08HQeLxAeAP2l5Bj8m38KfI6cpFTIWIthx8i7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 30 May
 2025 09:54:38 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 09:54:38 +0000
Message-ID: <300d265c-ff6c-4e01-a841-e8925e5d6d3b@nvidia.com>
Date: Fri, 30 May 2025 19:54:32 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] x86/mm/init: Handle the special case of
 device private pages" failed to apply to 5.15-stable tree
From: Balbir Singh <balbirs@nvidia.com>
To: gregkh@linuxfoundation.org, airlied@gmail.com, akpm@linux-foundation.org,
 alexander.deucher@amd.com, brgerst@gmail.com, christian.koenig@amd.com,
 hch@lst.de, hpa@zytor.com, jgross@suse.com, mingo@kernel.org,
 pierre-eric.pelloux-prayer@amd.com, simona@ffwll.ch, spasswolf@web.de,
 torvalds@linux-foundation.org
Cc: stable@vger.kernel.org
References: <2025052750-fondness-revocable-a23b@gregkh>
 <0c1d51d3-7f25-4a7e-b97e-dc2177d6bfb6@nvidia.com>
Content-Language: en-US
In-Reply-To: <0c1d51d3-7f25-4a7e-b97e-dc2177d6bfb6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: d840d5ce-f73b-4dc5-e061-08dd9f5ffd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|13003099007|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VStoc0FVNWVxQ0M5TFk2UzRKQjJ5SnpCZEE0WUZyL1ZHVVhDdlVxenNsSm5W?=
 =?utf-8?B?Ti82TFoyRTc0ejg4VGNsRnJkUE5EcEdXWk1zUUNHMHd3TFMwTEwxWnFwUlhm?=
 =?utf-8?B?UElKaUw3SHViSWtpM294cFdoNFAyZGJiUlJPTTNyTlRWVVBDcXlxcnJ2T09G?=
 =?utf-8?B?ZlVPZDRBSmdnMzFjOWJ5OU1RUm1RQkhqVHVENXZyeTUrVTBhTDRZK0ZrRHRE?=
 =?utf-8?B?ZWN4MTQ2TmVGcTFIUmt6eXFyRzdTRXB3VjFEVEYvOVlZajYxb3dMNmVmTXBi?=
 =?utf-8?B?ejc0Um5LN3dXTHlVcjBIZjRwc2M4UE1oTnpMV2Z0N2krVXN2R24wVU9XQThO?=
 =?utf-8?B?NkFSUERKSVBBUDdrQXZJMjU3VVBaWjRNejRHdFRZVllhbGdOcjlYeTBJSXYw?=
 =?utf-8?B?UjJQejVTMlRmTDlFelBwWFZqOGJnVDFoK1BoMVpUbnZMOG5scjJoSHRKQ1d4?=
 =?utf-8?B?VG1rM3d3clgyV2RZR3RRZzhZN3cwQkMvVEFFdXVyTThDdVJiQ0paOC9pKy9n?=
 =?utf-8?B?OU1WZFpvUGFBZTU0UTR6WXEzZjl6WHNRZHlLYjFJQS9qYWN4KzNwcW9OdVEr?=
 =?utf-8?B?Q2xZWktwdmVFNFdPNk4zdXhxZFlwakRaV3M5QlZZUURTektHZG1TeHdXV0M0?=
 =?utf-8?B?QmFWWWp0QmUvOFpTT243VnVXdzJRcStMd1NjMkt5VjkrVjM3Y3hHRWtyV3Vs?=
 =?utf-8?B?LzJqUGNTTDdrSzlhYU5vYWtzb0pxd1hiQ1NERVdmYUh1UE1KVlg2cDcyQVVQ?=
 =?utf-8?B?eXBaM2xyeXViUWw0UGNRbzlrQ29ORmV3Z1cxTDlOOG1ra1FHSUs1dWlPMHJ5?=
 =?utf-8?B?WC9mVFN4MmVPQS83VjZ2V3hPSW0xTm1MdytBbUNEL25zdE40WDBRS2lWVzFK?=
 =?utf-8?B?WDNUS2gvL3pSTTRyS20rZXhBbmVTcjRqSlBsWEU0elp0cFdHdHpxM3FmVlBY?=
 =?utf-8?B?UmM2cW5yVGd0Szlyd2lXRXVlcjZxdWdxSzkwd0JxaGNhbkxLZ1NvTmdiMjhn?=
 =?utf-8?B?UjVIaW5JT2QvNGxrdUd2aU52ZGE0RWxVWnBCN2NHRXpmamUvdFBZNERHdWt5?=
 =?utf-8?B?blNGNEJwaTZkNndueDh6ckJZcW5rdnpDd3ZXNlNuNnd2OTFydWlwN1NBQ1h3?=
 =?utf-8?B?ZjBKZHpwRTVsaWNhV0h6alZ0ZnN0cGVrQkxUUUI5K3RsRWlwSG5NWGJIK2RZ?=
 =?utf-8?B?RGNRdHc2N0dMandnekdmQ0lOV0VJMWszOWQ4bWF2MFNjZkFHZjNTSGxXYWlE?=
 =?utf-8?B?M0lBenNHWnp2ZXM0dGxSL3FDbmRma0dKaVNqNk5FZ2MwckZQek1vT20rQUpp?=
 =?utf-8?B?UEFrUzY0eGUwWEtOWUNZb3ZqVFJ1SnVGWmJkZldsTVFGL2poa2trWndZYXFL?=
 =?utf-8?B?Slg1bDU5Yzg1dnN0VXkzTms1RDhKQlFXMGsyemhUblRTcnlWd005cnU3YURS?=
 =?utf-8?B?M0JXb2MrVEtmN0V5U1ZDWmRvbTdTeTNMclB0L25GQ1ZvcFNZcWE2N2dKalFI?=
 =?utf-8?B?WDQvZUR3aTBaUkR0NE9OdURUZ2VZMWJHMlBoRXM1RkpsdGp4RHBteDVTV3Z1?=
 =?utf-8?B?WXdDak5Jb0w3QmhMcjhKSGYzTm9Lb3QwY2NpdlVCQnQ2ZFM0Z3FOVWFtYUVS?=
 =?utf-8?B?dW1aOXd4VUZUMHFZeTZXcDJhME9xcTRqSXVKeENLTVYwZzJ2VEJ0UVY1OVJl?=
 =?utf-8?B?cXd3TXhjZXpZTGhMVndxWUVKSFEyZ2dWdEVJcm1NTy9VR1FKZWcwYUQxbVdl?=
 =?utf-8?B?ZGV2WWRVbXlxeXVOekQvM1JPc0hrSU9BazVqcHgyR1JvQk9wS2w3ajdwWUFi?=
 =?utf-8?B?RGxNT2dDZkljalZ0RXh2S1pqT3JLdThIS0FEUkVONHFoNHZudEdnb0Juc0dh?=
 =?utf-8?B?cTlvbjRIKzVJTzhneWs0dnFuSTVVS3lYZG9MNmFYVVFyeHRHKzgxbnRHZXh2?=
 =?utf-8?B?ZjI5K3doRzBQallqb0dnaU9HWEJYQkxNWFFQR1VmRkZFSFRLQTJqOFBsSFp2?=
 =?utf-8?B?WmF2c0F6MjB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(13003099007)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clZWQmNjdVFVeTBZRUc1TzhjTEhzNXI5S3g4ZUJxUzNHU3hnSnVRNXZDWi9D?=
 =?utf-8?B?REJZM2EzVGlMUHk5UWVTSHByNVJNdkowbG1ESTBUT1RjbWFIVWJ3RHZBWmZn?=
 =?utf-8?B?MEc4S1Z1T1drdW1HTENIVUtVV2hPR1NhOC90QjZRLzQwRUtNNlRScE9KZ1py?=
 =?utf-8?B?YTJhdmFudXpQZHFmWisvWk0zZDZ0KzczcFFnclBLQ1kvYm1tRW1qM2JkMUJm?=
 =?utf-8?B?N3dmZ05hSFdudTgvYldIOVFTcHlTb05zejJvcTRkNS9sYjdUN21ZYmw2eUJk?=
 =?utf-8?B?ZU9LdWRjUVZpMUpDYitTSzFZYXhPeFRvL0JFU1dNNnhIZkF5Qm1NL1VBL3NW?=
 =?utf-8?B?b2NtZEZxSC9JT0laeTYzZmJ1dDhaaHJNKzhobXFyY0JUSXZlc1V3RXJ3aGdQ?=
 =?utf-8?B?MTBxM2o5aW9palJqU2x4Y3pEZ2ZUYlZwd1huVjR6UG9raVkzcmRuL3Nlalpt?=
 =?utf-8?B?T2U5VjBjbjNScXNtNjRDV2k1RzlkcHkyTC84S01xbzdJSmtuTUdITHBOOXo2?=
 =?utf-8?B?ajhaS05zN3VOWXdHTmloYndYZUhla3NVVllQOTFMWHQxSkZIb3RCMHlpQyt1?=
 =?utf-8?B?NXV3eDhWMExJYnNiTmFFcUpieUpFZjc0VVcrU20zVnNSYVFUaVdZTEtYSkZD?=
 =?utf-8?B?ajJjdXdEM1oyWVE5aW5BNnlXaHQvVkp1U3NUcUVSanBPNm9GdXU5YjJZZWJs?=
 =?utf-8?B?Rk9MaFRhaldoYStFQkVXVnZvUnI3NzBuKzB1aSswVS94MHI3WDhhWFhvZUdv?=
 =?utf-8?B?R3diRmFQaDhsRHNuejhJWEg1UG5hNmRSWFdqLzBMNGpUNXh0OExxekNpZjIy?=
 =?utf-8?B?eGo2T2hVak82MTM1bllQUDEvS2YzRjZZL1J5RTNRU2RTd1l0VmRkazNtcHZ1?=
 =?utf-8?B?YXpOQXc2OWt0cE1valA1NXptdEtsaXlPaVBoM1RKQ2FNMGErcGlVUUtvaXlq?=
 =?utf-8?B?MXoyeFBZTTc2RzFtVkNWMzY3NUdYamdwL1hBelNwcmkyT3BvT0FGKzEzSEF0?=
 =?utf-8?B?clBCSmZDbmtLN3lDV3RyalVteWo1QXM2NzZtV3JLQTNVWkdtOHoxME9xT2Ju?=
 =?utf-8?B?cVAxMmVPZE1QSVlKZEZWck9xeW9VNm9HY3h3SSsxV0J2SlZoT2dmazNRQnNI?=
 =?utf-8?B?Z0s0ODNDNG54SVNnNmdweVpxUWRpVWVrTXFuMnFZd2NKY0wzWXo5RDRaU1lJ?=
 =?utf-8?B?UGZiOVl5MnFFMmJWRHFEZlNUNldBUnI5eXUrdmhqbTRNUlVnUlhzdUFNL2dX?=
 =?utf-8?B?ZTZqNXNTbDJ6SDNaV1plRWZWZEc5Tmsvd3FzTzBMK21OaFRkd3NDVkdrSUQ4?=
 =?utf-8?B?dXdsOGJoNXR0ZHFXN2JOM3lLblJDZU9CZ2p1Y1dCZ3I5eWMrV3FTOFZEUWFP?=
 =?utf-8?B?TTZyS2xodEs5TkNhODdhVE8wSkcwZ05mWkZ5Rkw5RFlmU1hGdXd4UnozREp5?=
 =?utf-8?B?UTlIZTFaUVVMR0hMYk0vRldZR1p1c3J4dFhqSFlYeWtrU3A2ZUd6NzhkV0Qw?=
 =?utf-8?B?a2RSYkZEZkNqOGRKWllMLzBqUWlBUHhGQ01pN2pnVHhEVFZ4NVllbUwxVkdi?=
 =?utf-8?B?SGhuMHNHR0xrWWNYVG5wSGJ3cTI1SGc1R01aVm0vVG1uK3lheExxSnRZV2pp?=
 =?utf-8?B?bHRUWTFNOTA3WldVT014eXRqeU1qU1pYMTVzblRPM2NTU3V0OVhqWVl0THRC?=
 =?utf-8?B?MUFjTkNuamQ4WlJYVGR0NEpwUGFucUUwaDBvMHA2Y0pjVkRlQ1JnMHlkK2kx?=
 =?utf-8?B?NFlTcTBzaGlNZnNPVjd1eDJQZlZUWEVNWHZGQ1ZyUnJFQllTdC9ZWWxyWmJn?=
 =?utf-8?B?Qnh0emg1a1BjeGZUN1BZRXRXNEwwd2lGdlA1d2h6M3BEWFF1VDNGVEJuZTRV?=
 =?utf-8?B?ZDhjOHJTbGlDZFpMaGRDMG5JY3RzUmxmeSsxZkpXYzAzcmxZK0dxS21DQU9M?=
 =?utf-8?B?ZDNuUjRvR3NqL0cvMGZrelY1RlcrRHVieFBDOGphaXdSU2VzUmpYQmQzaktO?=
 =?utf-8?B?YjRFcForMTVuRzY3elJ3am9LNit5dUphSFFNM0NCakRhTVR6VlRIUDZCbkFi?=
 =?utf-8?B?U3VQVU11Y2VSSXEwV1ovZ0d2N1JJajNvZTZHVnltbmFtS2VmbjhBNW9jV29N?=
 =?utf-8?Q?GElgRtOEwv7K3DzBftSWeinRF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d840d5ce-f73b-4dc5-e061-08dd9f5ffd70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:54:38.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOc5AYcXTXg6YjFxaWiSXXEf3k7yZskRq/RKRrWTtfBxON/rdhHxO8rtj8fhV9tEroiKNBrdNarP0XHXrE67Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162

On 5/28/25 08:59, Balbir Singh wrote:
> On 5/28/25 02:55, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 5.15-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052750-fondness-revocable-a23b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>
>> Possible dependencies:
>>
>>
> 
> We only need it if 7ffb791423c7 gets backported. I can take a look and see if we need the patch and why the application of the patch failed
> 
> Balbir
> 

Hi, Greg

FYI: I was able to cherry pick 7170130e4c72ce0caa0cb42a1627c635cc262821 on top of
5.15.y (5.15.184) on my machine

I ran the steps below

>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821

I saw no conflicts. Am I missing something?

Balbir

