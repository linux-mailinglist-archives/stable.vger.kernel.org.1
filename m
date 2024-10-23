Return-Path: <stable+bounces-87820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F79AC89E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CCD1F232FE
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393181AC88B;
	Wed, 23 Oct 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XQeSNJ9y"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035291AB521
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681673; cv=fail; b=WDSgcTRwkGV0GN7peU79FMpEm0b9/gUkKylh9aPzdTXL0C5OuljcStZPeAVhgjBFt5QvdLmvN1r54SJp1IjTEOZnKCwZmhDYFdpabIiGjvs6RhUG6BuCNavzhLCYUMjQlBrOT5Nj3EAJd8AQqBYGSJ4MDfi35iKBsG2yiedqfMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681673; c=relaxed/simple;
	bh=vXw3kRsWxD02bASUgffc37El5ouWAjHlftmRIF3/pD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ttKZ/ypnenfml8z4920ORw/aJ6B4CJX1ucVSUaEJX/wYEG+1wWKVmkv/OA5Vw3NVEW5XKBsaM11SO7S9yw7QwqNNNxwFR4e+h9P6PYTTmzpPKJwhLrKZX7enTtq7EN+uEa0VYvHnszcEPhheU8c5rC+IzDDe5xkyKlrD9PuFFlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XQeSNJ9y; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYF/J8YkYk68Vj4JAmhixqf5uY9dGB2EjKCGytKxiWrzSsKEPS5AzksdIXI9dVYnNJFtXqXPjJPV0V3vRJvj0kcp3v2jCdQZWs362uP72y820L2ymXmlatPmtPGKCaGuemGq0P4jUdIBuNfIADXxKsEaKykI8ilK3G8Ov4iiE7CxFBBM0kfC83xl5PTET3P01ZmXD66Q9MYk1NSNZbmrI/jTkbo0mvGjTSIXW/0bGeFEB0gPrbBL9ErIBrxztFeqXLszFoullQUf4/Oxbnlehhlw2UI6RGTu/igQWFOgBwMgzH1nPdN5mjEFAbz1Tvny7gB3++9jImJ6ZljODtntFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6uaelI5eBcMWiDG6kUjDklZ+FS4JB0xnaOG+YbbqTo=;
 b=nACb3EDLfEIzW3FCQ6V6z52HPI0BMy2pcHvaWnmLjymjn+zSciJIeGKdaui8DYpFhmZBFGC0rDD6Yl0izho2edVI10p8CUDQplCpwZHbq5U2UvTDMhJZTovVPaK+mBUZTEGpSdf4Ut3Mj9RVpd2ti2pvRnVPBOYy7IXNsHHmnzIFA9EZ5tnXkVHWDVT5bYOWdA4gwWTc1elc/A2Q1uELlGHdWr11/gZfLjn7zV7TUUN4DheCNxrL7UTL4WO4SnJ4f1u7XLVdB3X1TUM84zSOEHwQ+OhWU9sS/vgFGK4epDNps48JCYHKLJsvB1h9Fi6D+nGtUSaicsT1BBXuA8Zyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6uaelI5eBcMWiDG6kUjDklZ+FS4JB0xnaOG+YbbqTo=;
 b=XQeSNJ9yKY2XwTLmw5cI89oCqYpJ7yUh4RdGv98z1FmOuaN9nAcBT3QFqrYWs1sAUIS0eegeDAwaFNtszIHu8ZxsGrmfbIjyU6uKoLgfuFl1UDYh4S4qgFcGeP10KvDQD1GtQZFmzS6o2iNDrDsWn84qTpkeNnLkBxldQ2bx3V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Wed, 23 Oct
 2024 11:07:49 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 11:07:49 +0000
Message-ID: <1f6feded-066d-4207-9645-f2bbed5ebfee@amd.com>
Date: Wed, 23 Oct 2024 06:07:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Steve Wahl <steve.wahl@hpe.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>,
 Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
 Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: a55ce95d-9548-4aae-b824-08dcf352ee1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzRZWUlibFg2bTd1YkpYYTFUS3NxN0g5YmN6eW03YlowQm0vUk5lbUpGWW10?=
 =?utf-8?B?eEh3MWQrdE1iaEJxQ05LRi9TRVpGU2EzTHdlSHhYb2dhNmNrN0NJcjlLSW9m?=
 =?utf-8?B?cFVWbnBnd1FxY1ZzY1Z5UzVORisxZ3ZtMk0vSmVwVUFBakRJVHVNWjJtSHhI?=
 =?utf-8?B?Q1lUQTZ3Q1pBcnk2OSszendGWkU4OFduRmlQU1lTdTJGMVB3akpwckg2em1H?=
 =?utf-8?B?UC9uNDJUQ3Y1L1VDWWU4MDVvdTRJYXBicFNkcDVqYkVLdVJUNG94bjl4SitM?=
 =?utf-8?B?aCt5ZHpvNzF1a3c5SnVyR0hCTno0Zi82RllzWmE0bkhBQUJ5T2hKbzR6eDJv?=
 =?utf-8?B?cWFkQzQ0dmV2WXF0ZENzOUtpd0xiTWwyTSt0YzBpejNWbUlGTXRabUFvSExl?=
 =?utf-8?B?OFUzSENxRlE1QnkxMTgwR2hkcXBZZ0Y0cnl4L1ZzS2VJbUxoekx4SGlDV21S?=
 =?utf-8?B?VUZzazdoTkQzTW0vcGVvbDZHZTdkVFM5c0dlL2hIY0N4WkhncFVTQ1E5dVFU?=
 =?utf-8?B?YU1nMmxobUlKSkZzclRtWkREb1hucWtaZHlpOVRPSFZ0bi9TbEhLNTZnN0lv?=
 =?utf-8?B?MzVETFRxcTkwa0xCaU1MVnpLTS8yWVppUzlJRFVLVHhPNHBtMkNzV0VZTXQ5?=
 =?utf-8?B?TkJHL2JPNlhsY0FFeGlxU3EzbmR6cUNOa3dkNFZDcVVmOTQvK211alAyV1dp?=
 =?utf-8?B?YlJiR2wyYThWZTRMdlZCWkc2YXFuMDJHRjhsemRKQTFrTncxdndaMnVsdUpw?=
 =?utf-8?B?bFpIZjlyYk1HRFJlOWhrQmZ5ZUZlYTZiY0ZOSitLVCtwUktCQ0NrVm9odkdk?=
 =?utf-8?B?d2hmWmRUaXlrZlNvb0ZjaklldDFPeXdhZFNMZHpGWGZxbGNnNzBsbW5zWGt0?=
 =?utf-8?B?NW1MQ3ZTQzY2Vkd2QnF1OHRWV2I2YVozNnJjWm5KOXloSFRwajVWQ2tMYjZM?=
 =?utf-8?B?TGJYam9aL1hUK3hPOE1WclpBbXdCMmd4Y1FGZTUxUEVrK1F4MUNxdytDd2tZ?=
 =?utf-8?B?TnI1M3h1R0J4VXgyUFNWK1RBbWJaTXhCTFJ5MzAvRDBhQkFJRmlERDJrUDJE?=
 =?utf-8?B?dlJLZGlCTHVacCtkaE5lSUtxSHA4VkZaN3RzeTViVDR5Y2owZUNCWTNTQk44?=
 =?utf-8?B?cGlJMXRTVFQweFljdFNwSjdMRmFyNVI2VnBQeWlWeFU2YVFldUlvVnFyMDJJ?=
 =?utf-8?B?Uno4TnE0end4a2FFdDkrZXI4alFyYUtHbUlXUk1lOWlGTk9Rekdkc1NveWhK?=
 =?utf-8?B?aGlrT2gxLzZOWDRFOVpOY04rdEt0UjZRREhWbTl5REc5bUdUdHU4MlJZWjB0?=
 =?utf-8?B?clhmaHp4S20xeVJDQVc3VVo4eUE4ZG1jemhRaVlHd0dENkVtcmRDU2FIdmF3?=
 =?utf-8?B?ZWhxRFg5S1U3V252RDJZWmh2TzB3SVZGNk5JTG16MWI1bTA5L05OaGNHVEJL?=
 =?utf-8?B?b2dXc0JMSGlTd3RVa21sWjI0S0pXaXVaZUJnWUxjQUhEY2NlSitHQm5vMUZl?=
 =?utf-8?B?NWhKYVVLdG5ZN004YW01TElwM1dUNitGUHRNakRnLzBxWStIYjlVaktxVjA1?=
 =?utf-8?B?YlBDdWlZN0E5aVFTZlJidFNyQk4rTW1odjExMy8vbU9oZmFQdGJpK2NzTkFh?=
 =?utf-8?B?akJKWm8rcEtWYlZaSzYzMTE0Q0VpQmF6SmYrRDBWczlva0FaZmZqZlhLT205?=
 =?utf-8?B?R1ZqYksvaGdlaWswUCtkZndOakMzeGwxVWhrdWN6Zmo0dVkvZnYzbXlTMlND?=
 =?utf-8?Q?tyFUVvMY1tdiLpTDMofIhyEEcfwYKIO+CtSPJun?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmN5UHFrM0l4WitsRXB0TmpZeDRNQ2QreFZWN2tVd0tHSGduMFJ1blVUcktN?=
 =?utf-8?B?MU1rR3B3VDVLY3JndVE0aVhCcStaUThucHh4ZW1yRGdMRFhDODlMU3ZoMC90?=
 =?utf-8?B?TVV6QkxWK3FlZDJsRHFZc2o4TDE1Q09ZMXNzUWwvMGRLZGtuL3V4aW1PRlE5?=
 =?utf-8?B?bTNkYm9SclAwU1RPaVFZK05JTFdQNThRTGFxdEllLzh2Ym1mWTk2TWVMRHFK?=
 =?utf-8?B?VEt1K2hUVUU2OHRWamMrZ1NuMENCem5Ta2x3OWNOd2kxTm9pZlBFTVlBU09E?=
 =?utf-8?B?Sm9qalhtWFNRc0Y0VkNWSkZHNnYwVUh0NHQ2ZklRVEdzKzFVRU94QU9HMEdk?=
 =?utf-8?B?U0RhZ0ttMmJOYnVmOVBkNHdPM1FMVkcwL2JxTmR5UWFUd0RKaE92OHBHN1VE?=
 =?utf-8?B?WWFNcGVLTGRUbHd5VHZUWUg0TzhLSW1PZVVpS3ZJV3A4L3ZFYUlhWm5DU2I4?=
 =?utf-8?B?NWhLOTVSUlRFU3c5MFFIYzYrWGtkTVJQbTFnK2xDV0kxNG5iSjJzR0VQckVB?=
 =?utf-8?B?WGkrd1Z6akF1YzFpYnBWZkRoWFltL3drdStoSFZCelBwRmtQYVY3d1hFV0o2?=
 =?utf-8?B?TW1ZcC9pcDZMbHpqZGhXMDR1UyswSmlwYmk1cldrSFZvc1ZwUk9jdGU5clFv?=
 =?utf-8?B?ZmhuS3RyaEhqaWVWVzFWdDlydUo2YkI5dGlmUys2QnJOT1BIeTVuak5iZmFq?=
 =?utf-8?B?MVZaVTh3RGxNVHNuK1hoYlJmbTRHdUozOXpKaWc3MWtnRU1oWUd1aU95dnBO?=
 =?utf-8?B?ZFhJbTBPVklNUUdjSzVhU09CVTYwSHQ5ZWJmcVB3Qk5VMythdk0rdFlIbHlz?=
 =?utf-8?B?bXNDZ1o4WE1oZ01vRC9oZlBFUUNkS1VOQ0tqTXdZOVBTd3hoVTZpSExJZ0h3?=
 =?utf-8?B?MzkvWWwzK0U0TG5IUlhKS1BJTDRrSVZpb3grSDU1emhueDQxZWl6Sno4bE5q?=
 =?utf-8?B?cUcrNXNSQklLdlpnTkVDSmJGUVRUM1dLeWNwTmpxK1pYaVBvT0VyY0pIN29a?=
 =?utf-8?B?YW9yS2x0dTFjaS96TTZYWnMrMVdpSEJta29WdlMrRjRpMXczZlVoMnlOS0RF?=
 =?utf-8?B?WlpXa2hRTnVrMG1hYm5hQlZCb2U0TGphQklhR2NIQjlBVm8xd1JpbzZCQ0Fz?=
 =?utf-8?B?T3VBV0ZscVpsWnlZWXR6VVlYeFZRNWltSUJjaERSZE44cFR5ZXNuU1U0Ny9I?=
 =?utf-8?B?UlJKWDhCZWFRWGhlRVdKTmJoaHVnRG53ZW95b2NVTjlWeGtabCtqRWVDcGV2?=
 =?utf-8?B?UmtMMUNDWHlaQjlwWWlwa0hlazNRWldDOWxjTnNKSVh0TE9CbUV4RGw1QU12?=
 =?utf-8?B?WDZMR2J4bmNNMGl1ZkNLM2lnVW5VM2tYZzIxZ0g3N0Rwb3F3WGJaNGxGNHI0?=
 =?utf-8?B?ZnFkZWxiRzFsYUY1Y0RmYlRQQ25WZml4SmowQ0ZpdEtkUXh4MjBvd25FQ2t5?=
 =?utf-8?B?TXRuMnQraWJNQVF1ZGVEV1I3SkpxV210REpwWkk2UDhxL1BreE5saG5IcEY2?=
 =?utf-8?B?dFpHTk5oMG5IckxCNGlhSDhYKzlGV2JQNzNxcmpOTTR0SFR4amZkYlNoU0pO?=
 =?utf-8?B?U3lscEdORzBsZGprM0JFMVV5dWdpbDJnOTk1d25GbkNsbTMyQnRlWG1jN29y?=
 =?utf-8?B?ZTlQT3JsZjdFcllXMFl5Si9wbHpHOWFGZ3lNZVBKY2loZXlDSXNYOHJIYUU3?=
 =?utf-8?B?a3BpeWlvVkJlMkFOMUc2M2tUSm56VnNISGdVYkNyRFFwNFNjWHBEK3BWYkx6?=
 =?utf-8?B?ZFhjTTNwWWRLOUxEYVVmZHd3dUZndy9FUDBvTkdvTkh4bmEwYUUrUTJLNVpp?=
 =?utf-8?B?WEMvcE1tNzlMR25xS1IxSldvMThtNXZQVVV2RG5ZbUtLUDVRVWVMdWVMLzJH?=
 =?utf-8?B?K2VTaHF3SU9TTGt2YWJ4dmRDdHlXVTZULzVBRkpxRS9tR01Ec09FL1M5VHQ2?=
 =?utf-8?B?TzBUVUFJWWU2TnQ2Y3U0NlBzZUJGcU5Wcks3aUpKUldtRlhXVDhvOHNEdzdk?=
 =?utf-8?B?enExWWV1RFpNK0NGdmtyU0xvTjhwbGdYeW1CVUs0WnFDYjhtdkJWcDlhVFcy?=
 =?utf-8?B?OW9mWTNuTGFtRmxJUjFrWXJUY1h4Z3JkYlBuMG9FWU91SndhbFFiTUxjZk1G?=
 =?utf-8?Q?LWzINZNUgHLUGevRt98NVLgrX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ce95d-9548-4aae-b824-08dcf352ee1a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 11:07:49.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP5f1AJg8fduhV9Qy3HB9xsLvX/TIgaHIiF+YGHmbIjqcKABz01TXbZLrbJPm6NO+Zj3pgxWSAvoblrtAKOgzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

On 10/23/2024 2:39 AM, David Woodhouse wrote:
> On Tue, 2024-10-22 at 17:06 -0500, Steve Wahl wrote:
>> On Tue, Oct 22, 2024 at 07:51:38PM +0100, David Woodhouse wrote:
>>> I spent all of Monday setting up a full GDT, IDT and exception handler
>>> for the relocate_kernel() environment¹, and I think these reports may
>>> have been the same as what I've been debugging.
>>
>> David,
>>
>> My original problem involved UV platform hardware catching a
>> speculative access into the reserved areas, that caused a BIOS HALT.
>> Reducing the use of gbpages in the page table kept the speculation
>> from hitting those areas.  I would believe this sort of thing might be
>> uniqe to the UV platform.
>>
>> The regression reports I got from Pavin and others were due to my
>> original patch trimming down the page tables to the point where they
>> didn't include some memory that was actually referenced, not processor
>> speculation, because the regions were not explicitly included in the
>> creation of the kexec page map.  This was fixed by explicitly
>> including those regions when creating the map.
> 
> Hm, I didn't see that part of the discussion. I saw that such was a
> theory, but haven't seen specific confirmation and fixes. And your
> original patch was reverted and still not reapplied, AFAICT.
> 
> I did note that the victims all seemed to be using AMD CPUs, so it
> seemed likely that at least *some* of them were suffering the same
> problem that I've found.
> 
> Do you have references please? 
> 
> If anyone is still seeing such problems either with or without your
> patch, they can run with my exception handler and get an actual dump
> instead of a triple-fault.
> 
> (I'm also pushing CPU vendors to give us information from the triple-
> fault through the machine check architecture. It's awful having to do
> this blind. For VMs, I also had plans to register a crashdump kernel
> entry point with the hypervisor, so that on a triple fault the
> *hypervisor* could jump state of all the vCPUs to the configured
> location, then restart one CPU in the crash kernel for it to do its own
> dump). 
> 
>> Can you dump the page tables to see if the address you're referencing
>> is included in those tables (or maybe you already did)?  Can you give
>> symbols and code around the RIP when you hit the #PF?  It looks like
>> this is in the region metioned as the "Control page", so it's probably
>> trampoline code that has been copied from somewhere else.  I'm using
>> my copy of perhaps different kernel source than you have, given your
>> exception handler modification.
>>
>> Wait, I can't make sense of the dump. See more below.
>>
>> What platform are you running on?  And under what conditions (is this
>> bare metal)? Is it really speculation that's causing your #PF?  If so,
>> you could cause it deterministically by, say, doing a quick checksum
>> on that area you're not supposed to touch (0xc142000000 -
>> 0xC1420fffff) and see if it faults every time.  (As I said, I was
>> thinking faults from speculation might be unique to the UV platform.)
> 
> Yes, it's bare metal. AMD Genoa. No, it's not speculation. It's because
> we have a single 2MiB page which covers *both* the RMP table (1MiB
> reserved by BIOS in e820 as I showed), and a page that was allocated
> for the kimage. If I understand correctly, the hardware raises that
> fault (with bit 31 in the error code) when refusing to populate that
> TLB entry for writing.

As mentioned above, about the same 2MB page containing the end portion of the RMP table and a page allocated for kexec and 
looking at the e820 memory map dump here: 

>>> [    0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x000000c1420fffff] reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000c142100000-0x000000fc7fffffff] usable

As seen here in the e820 memory map, the end range of the RMP table is not
aligned to 2MB and not reserved but it is usable as RAM.

Subsequently, kexec-ed kernel could try to allocate from within that chunk
which then causes a fatal RMP fault.

This issue has been fixed with the following patch: 
https://lore.kernel.org/lkml/171438476623.10875.16783275868264913579.tip-bot2@tip-bot2/

Thanks, 
Ashish

> 
> According to the AMD manual we're allowed to *read* but not write.
> 
>>> We end up taking a #PF, usually on one of the 'rep mov's, one time on
>>> the 'pushq %r8' right before using it to 'ret' to identity_mapped. In
>>> each case it happens on the first *write* to a page.
>>>
>>> Now I can print %cr2 when it happens (instead of just going straight to
>>> triple-fault), I spot an interesting fact about the address. It's
>>> always *adjacent* to a region reserved by BIOS in the e820 data, and
>>> within the same 2MiB page.

>>
>> I'm not at all certain, but this feels like a red herring.  Be cautious.
> 
> It wouldn't be our first in this journey, but I'm actually fairly
> confident this time. :)
> 
>>> [    0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x000000c1420fffff] reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000c142100000-0x000000fc7fffffff] usable
>>>
>>>
>>> 2024-10-22 17:09:14.291000 kern NOTICE [   58.996257] kexec: Control page at c149431000
>>> 2024-10-22 17:09:14.291000 Y
>>> 2024-10-22 17:09:14.291000 rip:000000c1494312f8
>>> 2024-10-22 17:09:14.291000 rsp:000000c149431f90
>>> 2024-10-22 17:09:14.291000 Exc:000000000000000e
>>> 2024-10-22 17:09:14.291000 Err:0000000080000003
>>> 2024-10-22 17:09:14.291000 rax:000000c142130000
>>> 2024-10-22 17:09:14.291000 rbx:000000010d4b8020
>>> 2024-10-22 17:09:14.291000 rcx:0000000000000200
>>> 2024-10-22 17:09:14.291000 rdx:000000000009c000
>>> 2024-10-22 17:09:14.291000 rsi:000000000009c000
>>> 2024-10-22 17:09:14.291000 rdi:000000c142130000
>>> 2024-10-22 17:09:14.291000 r8 :000000c149431000
>>> 2024-10-22 17:09:14.291000 r9 :000000c149430000
>>> 2024-10-22 17:09:14.291000 r10:000000010d4bc000
>>> 2024-10-22 17:09:14.291000 r11:0000000000000000
>>> 2024-10-22 17:09:14.291000 r12:0000000000000000
>>> 2024-10-22 17:09:14.291000 r13:0000000000770ef0
>>> 2024-10-22 17:09:14.291000 r14:ffff8c82c0000000
>>> 2024-10-22 17:09:14.291000 r15:0000000000000000
>>> 2024-10-22 17:09:14.291000 cr2:000000c142130000
>>>>
>>>
>>> And bit 31 in the error code is set, which means it's an RMP
>>> violation. 
>>
>> RMP is AMD SEV related, right?  I'm not familiar with SEV operation,
>> but I have an itchy feeling it's involved in this problem.
>>
>> I am having a hard time with the RIP listed above.  Maybe your
>> exception handler has affected it?  My disassembly seems to show this
>> address should be in a sea of 0xCC / int3 bytes past the end of swap
>> pages.
> 
> You'd have to have access to my kernel binary to have a hope of knowing
> that, surely? I don't think I checked that particular one, but it's
> normally one of the 'rep mov's in relocate_kernel_64.S.
> 
>>> Looks like we set up a 2MiB page covering the whole range from
>>> 0xc142000000 to 0xc142200000, but we aren't allowed to touch the first
>>> half of that.
>>
>> Is it possible that, instead, some SEV tag is hanging around (TLB not
>> completely cleared?) and a page that was otherwise free is causing the
>> problem.  Are you using SEV/SME in your system, and if you stop using
>> it does it go away?  (Although I have a feeling the answer is no and
>> I'm barking up the wrong tree.)
>>
>> The target of the pages above is c1421300000.  Have you checked to
>> make sure that's a valid address in the page map?
> 
> Yeah, we dumped the page tables and it's present.
> 
>>> For me it happens either with or without Steve's last patch, *but*
>>> clearing direct_gbpages did seem to make it go away (or at least
>>> reduced the incident rate far below the 1-crash-in-1000-kexecs which I
>>> was seeing before).
>>
>> I assume you're referring to the "nogbpages" kernel option?  
> 
> Nah, I just commented out the lines in init_pgtable() which set
> info.direct_gbpages=true.
> 
> 
>> My patch
>> and the nogbpages option should have the exact same pages mapped in
>> the page table.  The difference being my patch would still use gbpages
>> in places where a whole gbpage region is included in the map,
>> nogbpages would use 2M pages to fill out the region.  This *would*
>> allocate more pages to the page table, which might be shifting things
>> around on you.
> 
> Right. In fact the first trigger for this, in our case, was an
> innocuous change to the NMI watchdog period — which sent us on a *long*
> wild goose chase based on the assumption that it was a stray perf NMI
> causing the triple-faults, when in fact that was just shifting things
> around on us too, and causing pages in that dangerous 1MiB to be chosen
> for the kimage.
> 
>>> I think Steve's original patch was just moving things around a little
>>> and because it allocate more pages for page tables, just happened to
>>> leave pages in the offending range to be allocated for writing to, for
>>> the unlucky victims.
>>>
>>> I think the patch was actually along the right lines though, although
>>> it needs to go all the way down to 4KiB PTEs in some cases. And it
>>> could probably map anything that the e820 calls 'usable RAM', rather
>>> than really restricting itself to precisely the ranges which it's
>>> requested to map. 
>>>
>>>
>>>
>>> ¹ I'll post that exception handler at some point once I've tidied it
>>> up.
>>
>> I hope this might be of some help.  Good luck, I'll pitch in any way I
>> can.
> 
> Thanks.
> 

