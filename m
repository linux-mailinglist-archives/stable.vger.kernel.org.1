Return-Path: <stable+bounces-100632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB79ECF59
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E805A169B93
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE024634C;
	Wed, 11 Dec 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="oyupGrcA"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1789246345
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929541; cv=fail; b=gT23olAYZT4p77fN8BGeoIjeshTNiPsBPZ6G3U6loYIpxainVD147DRIWVFiW83/S0FN1bnEs7+lnGovW6rbgEIDXi5+bLxeneepPsJTYjTABYFTq5w8jNWGCc5jbWL5OzKvVUMGmdBdUjwvm6b9q+cnh4rIKd90E/wAf8snd5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929541; c=relaxed/simple;
	bh=GL6NKbQwtfRbxF2Ox9m0NuI6XeINEGhViAV2L+C6MSI=;
	h=Message-ID:Date:Subject:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ep6G0JAw6B1RyJKNr/WqkAXSF1ygxgheiPoDsxiX1IvEFN5G+mtO6ty3jlz4Pu6deRl6SlGAGIQg/IEv9WzMVu1vfnpOk+MsS3vuwKwOfRlJn/U9DPbOsSZak+MakW6dsiT2oqGQkrdejIvOwOfhbnNv1xE0AwZYEWyZMR375J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=oyupGrcA; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170]) by mx-outbound20-111.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 15:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/YuS8VWkF2FTNBxgc43txPvJ2cyKCZGMGBZxgM8U09kMIt5hx3ERjE9PMyqvcD0O0Umjiz/Fc+OZGCWjtNp/MGU/KialFBeRldfBfPLHVA5FQ/tsh4I//OlQS/iNwuhL55xZCqIfwuXAI4EjWyqxZnOWS4LEPlULg0k7j2Zr3fxLpbIxBIqS6zbuy38/ilpq9nDbwmmLeN711XamvGMfP6dxPL3nQJKFDkHwisjovYz0Xij/2S7skZNYcsovCSToPgZc4wWWrZ/TjxdYipQ+MlUS9B5R/ntpIhC1FMJ7IAV3yx/MYugvKqwUBskCs2yngL90veVJEAujcqeJIvY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q26fhv73zxF03rS6Sb9MpKrVbNrwZSA79RrcEk9Eeo0=;
 b=HMAfxZ07yJXzMJv6qqA/PbcsyXtCoNirexsViAetxyphh1xjCe/Pdx8gX8C1EP0AQrJokPuTc9CDXbgbM0a72poJ0M62P5PPHgAROe9qjjdia+DKONGWv+EWXiiwlrEjhEZ7UdXcqRDpi58Is/ialFX77hbpBqB8cz1u6GYKhZOBEchUvjDjN8YjVpqUD9847Q+dUngPL2xaMIpX8eqEbEX64dUFAiaq4I5PtbpIN6bdLTTIfs/dnPf0nJoUpAi0HVBfq8BJcSAJ+pT99kytpE/3MB087K0MLMJbX8S6k6xZu3yagG4C1IVl/aEpnh/sfqA5EK1RVswx2TElkHBqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q26fhv73zxF03rS6Sb9MpKrVbNrwZSA79RrcEk9Eeo0=;
 b=oyupGrcALstSvodaZnbhGj+SKA+DUg4O/OcEnqwuc+WB3b6c+X+bW4PNZb2rbKIJDNJyQv3VZuwCXjD9my3sMfRjPrC+YZ64avJg6yXP+e/roWPRWUGgzIxz999jGfQrvdQh5ZHswY5s58YH/O+r/DzL3/25HVOL1WUQZe+Ji3kdyRGXv80gEHPf/mQJgXKVCum/vj1XsTWDE5vgbjXjK6uJztwDolk/hk+nOoLhLp6Q4J9uk3ol+3dUrutLsDmPBtnkwQhrUZvU6Mf9QJinxTV+UhDlFzjSkvEKqkx4F5dNJc1WLYydAWJofivn3Ppj8v5s0QOqM7UXHPSbTwXk6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:31:49 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:31:49 +0000
Message-ID: <ccec7fbc-dfa3-43c0-8cf3-60456444e8f9@digi.com>
Date: Wed, 11 Dec 2024 15:31:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: tag_ocelot_8021q: fix broken reception
Cc: stable@vger.kernel.org
References: <20241211142801.1409014-1-robert.hodaszi@digi.com>
Content-Language: en-US
From: Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <20241211142801.1409014-1-robert.hodaszi@digi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: d21a8a2a-c8f8-4a36-447e-08dd19f08950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHBLeVNzK01YVi81bEMwN3IxQ2JnSmorMUwyYklISWRPUW9YM0RhWFQ2Q2w1?=
 =?utf-8?B?Ry9yT0JyNUhHZ1ZwZ2dCdXBPNTdDK1JPYkxWemF6emhudGU4SWh6MHVJRWtL?=
 =?utf-8?B?b3AvYWkxenNBYjBoWUNod0xpVFVITk9UUEZyUDBFRllMOXNyQjYyeTFTMW9R?=
 =?utf-8?B?aFNVdnM1K1llWG9Ib1dTWmY3dzl0UlhFYWJVd3Mzd0FTbFhzQ3lDUlJmaVF6?=
 =?utf-8?B?TWIxWHVOMDgrMTVDYWQyMGF6SDlNS0VFd3h1VTFZZmw5VW5VWkdMQ0lSTVll?=
 =?utf-8?B?MjBKaXBHYmNsdldFL1pkUzVXTG56cHU3Sml4RXFIdEIrbnVFbitjeWtqYnE0?=
 =?utf-8?B?YUVhRXY3NThWRXFuMWFkdkVISDlKZ25KTHd2d1h6ZThpNUFEUlRCblFNUzFC?=
 =?utf-8?B?bWVzSmdvbFk2SFRPRVBzZVBGQ2VzTnkyTjdqMytCZFlTbUJxOERKWFFra3Zp?=
 =?utf-8?B?YUxONnlIekVFc1k2YVdEY1BkSXdETzdsWHBhZXFkZ21SS09tVHZzNGgvYjJh?=
 =?utf-8?B?MzZneER4bzdvdkYvY2pUVlFXbEYxRXl1bmZEdm13STJHeEkzYm5yS285cjJM?=
 =?utf-8?B?UjBxOHhpQlF1U2RiY0xpY1JWUjdnREY3Y1F4b1hwSWJmUTlFeHhlL3BzZHNn?=
 =?utf-8?B?emZ1ZjcyaUVuZ2hsSlh3U1FLa3YwZ0s2cktYVDI4aDBNRGpuTFVlSVF6SDRQ?=
 =?utf-8?B?WDBRU1JiakdFQmdBQjhiNzBqTzNBNWVDUGMvcjdXMWlITVg5cXlRamNvUmlY?=
 =?utf-8?B?MEJ1THFjM2FhTFNMZW96K3lmOHZLeDJMeElTTlF0L0hsVmlWQ2p1WDNNSk41?=
 =?utf-8?B?L3hsREczd3lVcHl3ai85czBEOVdWditRaEtqRFhVcjVkZEZTU0Zhdy8rNmRy?=
 =?utf-8?B?djNScmZTMjhQZmd5MWVLMXRFQnZ6L0xlZGJIVHpjczBYODUzdVlxSkQvTzBS?=
 =?utf-8?B?ZURZMTZieFRwWnpzeS82R2kzUGNpOUluRlpZNy9CWjFsVjFlQkhoZmxrR2Rz?=
 =?utf-8?B?YUp6TVU5UTBwN3h0NEx4TFZIYmQ1dmIwK3FMYXpuNUw4eFRrUE8yZFNlWnlH?=
 =?utf-8?B?MHArb25JbHpEU29ha04yUHBiNlZCNkd4VXNVbGU1eVpUU3hqZ1hibnJTdVZW?=
 =?utf-8?B?NnY1Rm1Mc1VPVTlnZnE2b04xSGptOFpnU2h5L3N0Q3BVeDExaEg2NFN2NVJ5?=
 =?utf-8?B?MUxMMUhpclozeXhiMlpUNGNFUVhOQUdoVXpFTjJlalQxc0RDUnh2bTl3eklN?=
 =?utf-8?B?VklUTHdRUVM3QnUxb2UvZHdMN245ZjExeGpySm5sMlUxZy9jcm4vdWd3Z3VQ?=
 =?utf-8?B?OWxzV05yeEJ0WlpyazdTd0VkV0tkaHlQZENpRVpsdldxYWxOSUQ3aDZjVlR0?=
 =?utf-8?B?T0pzOUVQL2dDZHdwbklFb24zTHBQaWtVVStKMXVuNlNlRWxkdEhEUEFrUGhr?=
 =?utf-8?B?cnd0UmNSVjZneUhGNFJVcTFvZkt0eE5KSVpmK09rNHZSa2NnZFJ4Zy9IbFA4?=
 =?utf-8?B?QkhSZXlYdnVsckRzWHkwa2dMWDhUK0cyd0NlYnZqdjE4Zlg3d3ZLUXhxQ0xy?=
 =?utf-8?B?YTVPbkplT1k1VmNDRWdyLzF4a0pBZ0F5enlDYUdISW9IMlZmT0hIYUZjVmN2?=
 =?utf-8?B?T3I2UU9idExiZCtBTUs5bDlGM2tQc3diY3E4c1M5SVhWQ3hnb3JkUldjTGxj?=
 =?utf-8?B?bE1vZU40YzMwWmdxUTBob0NWaUZRM2h0VmlSSjN2eUl3ajU5QlkwT0dPVVFQ?=
 =?utf-8?B?aEdrM3dIeHp3dWxDTDAxbitUa2prWjE3REk0cGd5a3lSMkNzTzhraEF1Zk9K?=
 =?utf-8?B?Y3NXbVAzbTRodWo3eXZxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEpIOU1sRmgzYzA2NGZWKzFucmIrZ08rSmx4N1F4bmR2Y3NYODRoajFiTWZy?=
 =?utf-8?B?ZG5OVUtSU0NQVFBEMlV0OFkwa1NVL0RzWG5aQURNZ1hyOW8weWVSdGR6eTNQ?=
 =?utf-8?B?YTFlcTdFMk11c0tvNzExWGRwd3NKdjdQWHE1N1Q0NlU4WVVNWFZQM1VDRkJr?=
 =?utf-8?B?Slp4S0FhZVJ0U001RzROelFBR2FQV3VzanRoM3Q1QlRzWlZMSmdMMEkwNXUv?=
 =?utf-8?B?WG5uQVgzRXFOZkloTk1DVTBSdnhFelNKVWtJQ3Vvdk4wSzlZYkZNNGQwZ0dj?=
 =?utf-8?B?cUpmZzZsNTlSWU5jQmlEeU9FcjIyZTlVelF4a3pTRVQ4Wjc4WFRQVTArcHBs?=
 =?utf-8?B?RXowMkplRE1DRTNJdXY2dDNOZGY2aW9zMFFVTFFqMXRodWVtRFVoSG9CcDlH?=
 =?utf-8?B?ZzZTMzZPcExVM3BKRnlMUnJDQUlEL3ZSZzROeG0vdVM4MFV5OGxoSlZCNXRR?=
 =?utf-8?B?bncyMTFFMDFXTm9uQjBNb0pITVVSekx0U281MWRwWSs2d0NNN1g0Nkh1QWlt?=
 =?utf-8?B?cE5LMWxSbEdweitxUEsrNlNVQm9uR2pHOVBob0pBd0FHamZ5WnJtNGdsN2Zu?=
 =?utf-8?B?eEdxbU8yR1dXVVcxV3U0UkRGOHl1ci9IRmZlMWdVbm1sV1VwalYxVUI0bTZY?=
 =?utf-8?B?ZzFXb1NqM2wvT1FabUVzK04rc1AzU0NJWU1GemhaaDdxa1Z1TzFIbXYwNXRs?=
 =?utf-8?B?VDFWQnA4Y1prZVdaSEt5dGN4SkZ2eWdVaktMR00vWHpaTWtOVjNxbTFkT1po?=
 =?utf-8?B?N3ZIVWxQQkY5M3RPN3ZBc2RydW5meENLR0d6U1ZsR3BacTM5OTQ0dEwwdUJi?=
 =?utf-8?B?YnY2SnV1SGkzRUV2aWhrSyt6OUt1OU9nK0dmdUhmZTlHdmk2V0NNcDIxU05U?=
 =?utf-8?B?WmxuSzZnei8wUG5UUmxVdHVhWlVKN2prNlN0Vkh4YVViQk54U1lMVjc2TUdG?=
 =?utf-8?B?MjRQZVR6K0F1NjllRFdWRkoxQVpyQzFHOGVveEhZQ2l1UjRBekxjMzM0amNL?=
 =?utf-8?B?RFVEN0cxQ01ZUndLTUxMaG15QXdTYnljeWttaDF3RDZTMnFyMWJxUGJoRHpY?=
 =?utf-8?B?eEk4ZTVaTEorRU9WL2UrMzFPZzYrVHZIZmExZ3JDRlBQOVY2UW1tc0ZSbDh4?=
 =?utf-8?B?MnFvMmVPcWwzL1JXQjZkUS9QYnJVbE00SFI5VlAvWm43M3ltZ21aL3BSeEht?=
 =?utf-8?B?VVYvaVBqU2FoL3ZQNnRoM1owOHZOdFRDSXdCelZkT1VyVGNuUzF6ZStGbmlF?=
 =?utf-8?B?VEt1dDhDQXlTSG5EZkJHNUg4SEVjZHJTSE1HRkxFZ3FyNHF0SnRiU0xIRlZI?=
 =?utf-8?B?TURTQjZEQkt4ckJ1MnJ1OFdja1FiWWtJS1V3VDNBU210ckxLQ1JMSG4xN1Fr?=
 =?utf-8?B?YzBvRGhpZ2gvOU1XcGoxZDBOYkZtTnFlNG96eFczVXpDOFhrRXRSdnlCd3Rp?=
 =?utf-8?B?UFFQbFZqQ090eFdRa1VaWHRGRFc3QllwZVBQU2NGdmJVVGVqY1drU2lsVk5y?=
 =?utf-8?B?R2o4WTh1d3VrV1N0VytEZ3Fjd3pMbENrSmtDamp5dXJPQkduNEVZYTlDWWwr?=
 =?utf-8?B?UElOQ2JuMFJyRXFHYXphSzJxelRnVC9RamxXUGtnUDFzUUxKa3Y3aXlMSFFp?=
 =?utf-8?B?OS93OEdPOHdlUThTVFNmL285QUl3WFRxUmhDNHJHNmppa1JackFCUmRDUjRk?=
 =?utf-8?B?d1QxbjZmVngwUjJxSGQwWGR6SHNpdHZBRm5RMytnenpqcERmbXd4Y29YWGt5?=
 =?utf-8?B?aHQ2MUhSTCs1YUQ2MW1ZWTJsVUtIR3l0MVhHZkFkOC8rSW9NUTlFa3pzRGJY?=
 =?utf-8?B?T2owdUl5SFFnRjJTZUtWTmpoMWI4VERBTHB5M3dXVkxKMUUwcVhYLy84Tmc3?=
 =?utf-8?B?MEFqQ1NWeEQ3dVM1aFpMcU0yblJzYUVXSDZiL2R4WUptZkE5cmFHellBOEY1?=
 =?utf-8?B?a1R3VWIweDhOTVBNaDZRRW5KV3V5VE1ESmtWb09mM1FiS3AzcVVycTNpZXVh?=
 =?utf-8?B?S2x1ZWZsT016VW92NGtEUk5WemVqaUhCRGtkU2VUM2JpQnJLL0NJZmZQWkNv?=
 =?utf-8?B?TTVqZXVpaVl2Z09JZmh2VkF1dUlEWlhJZ2xnS1AxZ1FQeTBNdzdKOHVJaGJF?=
 =?utf-8?Q?1MbQCFyOLJCOL9MIORnZqkZX7?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21a8a2a-c8f8-4a36-447e-08dd19f08950
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:31:48.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dojI01Urb6xvnyoHLTW1t1DYyYsa3MhMr8Fca34SfGekcUTtoWv63OHW953q/4sVtP7iPWN8KDFmZDM2yF/x8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-BESS-ID: 1733929502-105231-13405-7059-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.57.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmJqZAVgZQ0DjZONHIMDk5Nd
	HAyMTCxNjYPDHVJMUy0SjJPCUpzdRQqTYWAPKDNZ9BAAAA
X-BESS-Outbound-Spam-Score: 1.22
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261039 [from 
	cloudscan17-74.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 MISSING_HEADERS        HEADER: Missing To: header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	1.21 MISSING_HEADERS_2      META: Missing To: header 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.01 EMPTY_TO_HEADER        HEADER: Custom rule EMPTY_TO_HEADER 
X-BESS-Outbound-Spam-Status: SCORE=1.22 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=MISSING_HEADERS, BSF_BESS_OUTBOUND, MISSING_HEADERS_2, BSF_SC0_MISMATCH_TO, EMPTY_TO_HEADER
X-BESS-BRTS-Status:1

2024. 12. 11. 15:28 keltezéssel, Robert Hodaszi írta:
> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> added support to let the DSA switch driver set source_port and
> switch_id. tag_8021q's logic overrides the previously set source_port
> and switch_id only if they are marked as "invalid" (-1). sja1105 and
> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
> initialize those variables. That causes dsa_8021q_rcv() doesn't set
> them, and they remain unassigned.
>
> Initialize them as invalid to so dsa_8021q_rcv() can return with the
> proper values.
>
> Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> ---
> Cc: stable@vger.kernel.org
> ---
>  net/dsa/tag_ocelot_8021q.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
> index 8e8b1bef6af6..11ea8cfd6266 100644
> --- a/net/dsa/tag_ocelot_8021q.c
> +++ b/net/dsa/tag_ocelot_8021q.c
> @@ -79,7 +79,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
>  static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
>  				  struct net_device *netdev)
>  {
> -	int src_port, switch_id;
> +	int src_port = -1, switch_id = -1;
>  
>  	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
>  

Ahh, sorry, for spamming the stable list! This supposed to be a test mail only, but accidentally left the CC there... :( I'm just sending out the real one.

Robert


