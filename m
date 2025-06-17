Return-Path: <stable+bounces-154596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3DADDFCA
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 01:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7C160FD7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489F294A0B;
	Tue, 17 Jun 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4cHxXAf/"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FF28BABE;
	Tue, 17 Jun 2025 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203764; cv=fail; b=V5Cd6ZbjDos0Rc6iJX0yVfsDin/gtS+OrEeJ93HFIlHfVUULNa1BETJ6QEmWNt/uBthdnwMIiqCXulMJt6zv3W9DJKtpVYRlwR2KmxunAT3XFvksqsS7CUO7drbYV0DoojVSHLUQQ6Agox44GlSJtWBr6wmLvFQgYp96I6gM+Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203764; c=relaxed/simple;
	bh=YEcE9gEKtls3jo9lHbvNPhfC/KGfPigWq8MosbXc12c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RsWiDabtvfwaMTAbovstzTxeTfpyqFJVeOJ/FI4Ut+2m7oI21b4hd+xu3kSoY0NzEV4ES58+XS9jvgoiVXwHF+dvwjAk04LQa/2mGuS7Oy6XL6Rv0d0lufAWbi10HRWcAKd86Dt1oq++7l0h7xvpHofYRiLD040Jv+AcKMm5UAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4cHxXAf/; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxP0qDwPaQPkPqnVRVZGIu7XATz+Qm3U7Uw9f6PHxE661DeFVp4W9w+OnMKhHu5GD4EYPaM0Iz9sXBOJtjKAZ/v2Pehuddeu/uY61xrXE7A3Z1Q8BulL/Jc/1yf+SPS124U+XpGpktHZAj6l89mCpAcyWTJnHU/8dsxgJySOhLQBTSDFLC8N9e8JUTHC86LbAAAl1VHlw3Y/rnf1upNZPz63c6B7qP9OyRCmzFdCYhczzAAjWPcPQEJqFDoFziaY73ooKa+dARODTilS8Dux1VO8P4wd5/CDlESDfhNBM2Zi9DrXf2M53CfL4hwsb5aOFEYUgUNjliPxCIvLBKHG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zIeUlEMXcgmPhqNxH5sUhXwmH4o2o6nxYiAOk4joiM=;
 b=hqeZnNIyiu0zCQnsO+YKjTfIPFnViAkvFMk4WNACBGUYogJ+G4kAJyhIVYg86EWFvKhVGY+a7VCs76H+z/wEv820Q8E4gGDXeYrxycQoflZBdK8Y6dPTW3MkYuZK+4V4k9yDJqfqCE1+Crssxbhi/TtHR2TS3ea+Z06AEf/0DVtRmgLZ4V05cs1KJKZeT90ocwK9K5oMaMxjwDJs8+hyW8mmJ5WQzLY34OhSN25wET4JqTLB6ztPEHtJvdacqk9oBWF85ZdfZeFJhMJcrFsoM7V3vWhYXm0kBaCg8O6KUMXpyDVBN8bvOqFvMbtzYbx3RBrRYRtimM4Mq0UqC+f5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zIeUlEMXcgmPhqNxH5sUhXwmH4o2o6nxYiAOk4joiM=;
 b=4cHxXAf/PITnH8dyrmwGSdWRbLrj7kECXEPYr6Uui75T3SQRXgfmdi7CYCW3zV2m1T/DU1AFc2Ayv+gr/yArx4L2NqmnPBohtHkZAX2TD8UAvzzmhZLZLFRgEOisRxYNAln8HwHbaEcR89XKQqkHhwkLA6/YB4crlKmezWWbfzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 23:42:39 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 23:42:39 +0000
Message-ID: <3002633a-5c9e-4baa-b16a-91fdec994e02@amd.com>
Date: Tue, 17 Jun 2025 17:42:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: Radeon 840M/860M: bisected suspend
 crash
To: ggo@tuxedocomputers.com, stable@vger.kernel.org,
 regressions@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Christoffer Sandberg <cs@tuxedocomputers.com>
References: <fd10cda4-cd9b-487e-b7c6-83c98c9db3f8@tuxedocomputers.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <fd10cda4-cd9b-487e-b7c6-83c98c9db3f8@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::28) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: f074a88d-23af-4774-0eca-08ddadf8a500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3djRkxMVnZGb1ZBNWpQUzcyeUlKQ1J2ZXFteHBQdjRESklmNm0vdmNyS0tF?=
 =?utf-8?B?VGhya052VDZJYi9LdHZUMkIvWVBkYU1LSGFYTFRRSWVXT3laQi9RbmJ1ZUxS?=
 =?utf-8?B?L0JZVWRTeUlmKzNxdXArUDJvSXh4SGtiSFVzTm1YT3drWWMwWmN5SlFZS2pX?=
 =?utf-8?B?TjdYQXFSOUxDT2VnVzFKWjdINnNHRnNIU1BTb0RqRWxnRFhZZkVVeEhha1Fy?=
 =?utf-8?B?Z3p4QU1mdUx1WnErMTcwQU43N2NlZTNwT3VaYXhrMzI0cjRYZEtOeTh6VjJZ?=
 =?utf-8?B?cTF1eElXV21uS2Vrdks3VVdpK0taTkNFK25Mc0MxSXE2VnlzczEzT0ZLdmxl?=
 =?utf-8?B?R0hUTC9jcXpIWVRNb21kNTRoSGM0YzRCeVpDcXlzRVZWVGxBcmtNYWYydG1Q?=
 =?utf-8?B?SmZzUDR3c2d2ZWp0c0JiZ3Q2bGdSMjhFNUFOSGdnZ3lVdEljRTEwNkNuV1p1?=
 =?utf-8?B?NmFoU1AyMmpTbmdwTkQ4ZTRuM3ppS01jSFpxM1pXeVdHd3JienMxM01BbXdx?=
 =?utf-8?B?VTFwbDFsQ1g2dUVWZTRQelRGK2c1a2VMdjNWNElBQjc5RmJsVzd0dW9lNXJQ?=
 =?utf-8?B?ckVkMzltMW9STkk0ZWdqYkNGWDQ0TFNPU2hmcGxxdnhUZVpYWHl6RldOYTRv?=
 =?utf-8?B?VlFTOERHYWdTL0dzV1hWTCtHd3NCYU9iaUhIbXRQdWp0NHVKME5pbUcza3Bi?=
 =?utf-8?B?UUx4bXF6cUkvcVR1YytDUE0zblREaDJzeXhxc1JDak01SU5YbTA3NWRHRVA1?=
 =?utf-8?B?ZHJqZlJRMnRlRFpGY0cvaGZkdWRBNUZVSFhLRmZoYnFWd0tTRjlLYWNuUk4w?=
 =?utf-8?B?RXB6NktFYVlIbE1BM29ucUlQbE9XZTJjOS9iUXo4elVOS1hMekVkbjlUYjMr?=
 =?utf-8?B?bEVUTmtQMGFrNWNYKzVEQXZlMzJQd2lEVFk3Wkp5SXJKN083OHhDZEhQL0lP?=
 =?utf-8?B?TlRUVk5kY0dZaVdBUVB4UkJzd3RUd1ExOEhIWnFieFRiWlhvYW5IWVYzM0dW?=
 =?utf-8?B?czFrTHl5WjZEMU5kVUNBY3UxUVdGN2c2UEZDWHZMaVRoU3V6RkIxUk1kL0RO?=
 =?utf-8?B?UEQ4cWlacm1RTFkrQS9MOGdjaTdhMzMzOW91eDZsYkNxNFFaSWZKOWRDVUZE?=
 =?utf-8?B?a25ISldIR3pQbE5vVG5XSlpObmVFY0hoekJoSGdVd3pkV3EwKzIwNG42VDk2?=
 =?utf-8?B?Q1F6eHZYME9Tc3hCTzRpODlSY0I1UEJILzN0UkQzZVVUMUljRi9hQXNRQWg2?=
 =?utf-8?B?MUwzS0d3TFBJTnA3Q2dYVExmS2diaGV5Sld4c0o2dlBrbGtLZ2RncVdGTDdT?=
 =?utf-8?B?SS84NDY3aVVBY1lJaEJXNkxDck9Bc2dYNnlCUnk4VTNmYXZnSzMrUGpjNmtR?=
 =?utf-8?B?d0g3cVlHV3hCT2FwUHhsaSs3UlBHVVZ3SmZqRHcxSTErMm5oWmZ4bVpoRnAx?=
 =?utf-8?B?N0RnMi9tcUFHTkdjTjVlUEExRVRNcmpBM21mWUVXcEVXdXdBSDQxVE1KN1Vv?=
 =?utf-8?B?QllyMWRUSnBsdHg1Zld1bXlpN2lUcC9KZlBieVZpcUpTemRuYlRKVzhBbUtF?=
 =?utf-8?B?OCs4aTc3T2Z3Qnl1UVcwZDRnUTUzZGlHNFk2OHlpZnh0U1VuaGsxZXEyQ0VC?=
 =?utf-8?B?aGhMM3k3VTd3US9XczZPek9IenlGSzlYUW9rbnJ2S1hWNTJoMEdVUGljM3p6?=
 =?utf-8?B?QUJYSmNFVlZPcm9JN0QzY1BmVTlMYkNKZDdlS1crNDIwWjluQ2RzSzFObk9M?=
 =?utf-8?B?L1NMcThzVDNsbnhIUWdFRXVmQ2Q5eGdIZnhwNWsyWjVjL1VUVGJvaUZlZE1s?=
 =?utf-8?Q?hg0huzr8IZ0Q+IpmA0R9lsOcYefTtLgnmtO7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVZKMGxtNlFDUDI2THpmOHNVQXRFTVJDYkV5SlVqNDM5clpjSy9uY1dheElE?=
 =?utf-8?B?U3YrSThsTm1IOFlqQ1hMdFcva3B2UnkwYkpUZmNyb1RoNThTdjlENHhkMzJS?=
 =?utf-8?B?WitnWk03Qkp6UnZnR3VqU2JIdGpGZWE0dXFYMy8vU1Z2eStqRDBWVHpZMTBR?=
 =?utf-8?B?SU95ek05OUZlY3BhTkh0VXV6RGtoSjhMU0xQWFJoekgxVitJdHU2U2c2aTVa?=
 =?utf-8?B?NmZFMXd2alJtVExWNjk5Sjlad1FITnVWejMwMGVvYkJiM3MrSk51NGQxVjJw?=
 =?utf-8?B?VUkxaFhuUjVaYnVFcHM3MW9RLzlVNW04aDBuOGhrKzc1SEJMeXI3RkhYZk0v?=
 =?utf-8?B?MDk1eXhFOWgrUm10VEVhcEJ3RmIyRkZ6NnovRGlQSmFYaWtLKzd2T3k0Wk16?=
 =?utf-8?B?b1I3L3RXdUVVZk00NFN6Z1lmT1ZkTENJVFhvZXdWbitDeWZRTGNMYTM0S3Qv?=
 =?utf-8?B?d1NnVHBDLzJtellhKytaZ1hMRGdtRmRwMWNSeDJ6bHRFVkpIcnpRSmJpcG95?=
 =?utf-8?B?NTFMYXRvdThEY3RyN3E3OTFDMUtqSlVGOTFkNXBwSGUrSG1QS1k2ZDZ6RE5E?=
 =?utf-8?B?QjJFQWZaenVmZjQ0OFQxOVl0TGVuRXFaNzBSMWxrNnV2b2U4WUgwR1ArMjVL?=
 =?utf-8?B?ZlJDN0F4aG45SjdKWmQ2Nk9rSTlSZHUxcHNkZXNOUmo5bmd6eFdoNmhIc1Fu?=
 =?utf-8?B?cnZya25QSitzVTlNY2tWM0kwU0Ntc09RRURaSmVtMlZGTGh5ZWxZaHo5YmMw?=
 =?utf-8?B?OVAzZVVFZlVDdENWa211RFdyc0hYM3pnMkpnRkJPTksrc2RRWGRWOTJqNTcx?=
 =?utf-8?B?Yzh1MG9OWTZZd3hqWDhDL0ZmN0dQRlBuMWpqY3dzTFhvak4vRG9VbWpXUzIx?=
 =?utf-8?B?OStWZ1dWckJsMjJSald3QjMyZ3VnUjIzR2tMc2ZtaE5vY21XR05ibi83Vy83?=
 =?utf-8?B?NzZFaW0yYnhadm44aVJEZEdCV2VQcEVFOHN1UTJ0bHl6LzBQY3R6ZXlUMHE0?=
 =?utf-8?B?Q2NrUzQrTWlMWXV6c29xVEpYNERkV2JBSVhaNkU2WkE5YnZ0eEZjajVjbjdT?=
 =?utf-8?B?amw2aVU3WStVZENRRUZYREJocWx4ZTRUWFZpYWNDODdJZkpHRFBuNkhTdGxr?=
 =?utf-8?B?MXpMdW9JZUdtMXRycm5KY3gwYXo1VlE1cG50c2p3ZnpBaS92aGtGMHE2RkRn?=
 =?utf-8?B?eXIrZE5qa2lzYlUxZDUyb3ZXb0pNcFBNRnVPMTgrWTZ6LzJHbmIrZTNXSnFO?=
 =?utf-8?B?QkxlUzVtM2YxZ25jR24xQ0l6K0tRQ1d2UUU0cXY3VGxRWEhzNHN6ZTlWeXBK?=
 =?utf-8?B?aDZ3QWhJUW9sUGpWQjcxZCs4NE94NGJiam9pT2ViQWxvR1lkTDhXaml5YlRu?=
 =?utf-8?B?Rm1tUEpYczc5M3d3blYvUEZ3eEpIcGRBbDh3elNBU3dqK1Z5OXZyd1JudlZp?=
 =?utf-8?B?VjhsSXJWU1VTRms1dXFxOEhkd0lhRXdPc0lSMkZxMHplVTVZeTUvNVk3WElK?=
 =?utf-8?B?SmZoUzdaSFk4U0xRcVV2bTQrNm1sUkxsSGJZTGJmOTRZbjJtY3A3a254UFBG?=
 =?utf-8?B?SjFqL08xRDhYMzEzbmJFaHoxcEo2NHZWbXVWYm1reEoremU0N1phcFArL3FM?=
 =?utf-8?B?cjVPUy9jaTE2T3ZzdlhDTGMzRjAzRUtDOHRINXQ1T0VISXdjU3VXZWhpUFlo?=
 =?utf-8?B?dy96VjhodFVhY2V2dUxSSmYwZzlIdlVlWnRaTzdLeHdkWVFGQUVoTUtWK1ZW?=
 =?utf-8?B?MEUvYzVpZ082R3BVRjlZa0tVTmN3bDlhQ2JvZDExeUZleGRDVEFJNldDL0c1?=
 =?utf-8?B?NURxWndjUEhGdzk3RHBjbEVIT0MwYzAzRG15OVhsdjZ0TnZKQURwVlJaL0NI?=
 =?utf-8?B?cUVLdk8reHB3dk9iNWFTeWplVkZhZnhZdlRPeEdHUXNudFk5ZVRsWnBPdFM0?=
 =?utf-8?B?QzhFSGxyOS9VSjNkUEhaTWhiTVRpRk5hVXN5L2U5ck5mT1FxK1JleXI3Nnpw?=
 =?utf-8?B?K0wwdy9NWjRkc2FPMEF1b01TUHVZSTJqWVFTUE5ubUhjK1pPU3pscDZTLzZD?=
 =?utf-8?B?KzRHMFhjdG1pQ0J6SGwxbnQ1cXRZWm1NNTM2QmJGVHZHOHZnWVZnUW0wdm9X?=
 =?utf-8?Q?a7ja2HKjixl73EZcpLPpxLgJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f074a88d-23af-4774-0eca-08ddadf8a500
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:42:38.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmCBJZ4+LXQu3cd7dQZyvJjLh28U96csR5BwytnY2EWz2wYGtqR1FrOpdr71E4OH6WS/YZ7GkPPiQGBOk3td9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

Hi,

Thanks for reporting. Can you please create a bug at 
https://gitlab.freedesktop.org/drm/amd/-/issues/ for issue tracking and 
log collection.

On 6/12/25 08:08, ggo@tuxedocomputers.com wrote:
> Hi,
> 
> I have discovered that two small form factor desktops with Ryzen AI 7
> 350 and Ryzen AI 5 340 crash when woken up from suspend. I can see how
> the LED on the USB mouse is switched on when I trigger a resume via
> keyboard button, but the display remains black. The kernel also no
> longer responds to Magic SysRq keys in this state.
> 
> The problem affects all kernels after merge b50753547453 (v6.11.0). But
> this merge only adds PCI_DEVICE_ID_AMD_1AH_M60H_ROOT with commit
> 59c34008d (necessary to trigger this bug with Ryzen AI CPU).
> I cherry-picked this commit and continued searching. Which finally led
> me to commit f6098641d3e - drm/amd/display: fix s2idle entry for DCN3.5+
> 
> If I remove the code, which has changed somewhat in the meantime, then
> the suspend works without any problems. See the following patch.
> 
> Regards,
> Georg
> 
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d3100f641ac6..76204ae70acc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3121,9 +3121,6 @@ static int dm_suspend(struct amdgpu_ip_block
> *ip_block)
> 
>   	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> 
> -	if (dm->dc->caps.ips_support && adev->in_s0ix)
> -		dc_allow_idle_optimizations(dm->dc, true);
> -
>   	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv,
> DC_ACPI_CM_POWER_STATE_D3);
> 
>   	return 0;
> 


