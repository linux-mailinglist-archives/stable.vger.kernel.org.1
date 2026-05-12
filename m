Return-Path: <stable+bounces-246704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBBjO461A2pg9QEAu9opvQ
	(envelope-from <stable+bounces-246704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:19:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6D52B3DD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052293058821
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260A0383337;
	Tue, 12 May 2026 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Msw/91GL"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837633EF
	for <stable@vger.kernel.org>; Tue, 12 May 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627977; cv=fail; b=LIBCsDSWD0uOXa80PtTUEoLQDFxq7wxpZg+A+QmVDrdGyUXlhOKEzsVB6uI4SZ9RStdoXRZou93OzQwkw6FREcgoOpQ5QEZsY7zVxG3OCScRL1xTcb8l2gUZExHHXvtbfRKOM+uhxd8iQj0siJe7+YDI3aWZ7zj72VLA4JW5ARs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627977; c=relaxed/simple;
	bh=VbJwtoxKAnJ4MPx9gOfPrOsg0IWBrN4/l50Wpkao9js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JtQBcfleNZCavWHYzmJAa6tUPkd07dxlY7ds8FfIpMZTONXsNBv00wxAMKS52KLGRn7EKWMW1gb5a7HYJ757QbyvwDdRodXSTc1XKh1+llRSleaHL+TWjJAjuW2eH7wEC2kByOdxI0bWHpCB+NIz92KUsPJSnmybfhDghJv+Wj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Msw/91GL; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJvTcLh0cLJxm26ENP/W5cXwplzEBwaJJQzv8wK2zlHVictkSmCapD0q8ibkk59zkD/vs52481/uPZZmTwscYYk3KMdDGwi6mEGg8qFbf3aSk3R64jtnSRgUGNgKGTSqwd39UO8TvAHGB1La1xj/EWprsYmhAC9bEGzGbXPwMw8EWsaa0mC/+m/tpG5X0XRoStsBSlH1cmDt5I0SmOaNGGUH5fJyHyAkqKRfeR1szHCspzttvALmv0A0V3Pb5Z76AWMQQW1BbOxjumM9ISsVDi8Wn2gb4GoKlyHpEQu68KB3sLuRMpvrNI4sKGCYYosfJ2d5GUqvU1TOtyYZw9urGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8RDgE3oMoEcFRGJlDRb/oEL82Hd4fhQeIa4vzDrIaY=;
 b=KrJ2fDSq5TnuV3I2YBjQhHVv0GuHsiuAOLkIvr0N4J2dsNAdvLYi16BiCNlse3dxox1gYjNlPg9F7CvWcvohmM8UOL8Sj4B01cH6UfKHeC2nyPl4DacKT9JEBbg3R1dxf4vVXDRIgDjSL0IdPLX21Tz6SWQZLW93vCt4dajM995mLmcKGhQgXidl8BB2zvfZIunAwle51V3rBbDOHzf/MUdPv3I7IFzM5vrm2yTN1eKplaaf5K1OKJTl9/85uEbQMtJBQ+CPHpKXAWfaDlEpVYfJhPEvWSuqrM/PfNPIid+enXbL1CmjZyEHoKukOqm8PHUpsBJZVb2pzLwIL348qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8RDgE3oMoEcFRGJlDRb/oEL82Hd4fhQeIa4vzDrIaY=;
 b=Msw/91GLIQ0aNuzwunEIylCe5Js2oJrTeipz8lnjFMkV9tkdwjszAedtjej9Gpiz7GPvC/yDnzuI5JmxW8aD9o57Nk9TDZuFLEnIKBy3g0CHLupDMHH7gORwKfCRhyIaabJR+gfFHstBNe3iwalEawkfhbs1/pubS/apCLPwD2pZ/SGdcJ4F6Z3IVmzt0K0uF5/u0Xvv8gOaEKD8/rAyFJIsn9mkSojHKgKaGZWUMwq0/gyg4tYKU8RRCobCPOXfnz9u04Bh35pWSa+MJtJQ1ToQWqoguQF9AgwLwIaeW3zutxMfHQUEbStLSWLfm+G8Et0lrvWi3IEnDMdi8wwh2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DSWPR12MB999154.namprd12.prod.outlook.com (2603:10b6:8:36e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 23:19:24 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 23:19:24 +0000
Message-ID: <18ac53cf-72b3-4322-846e-7f6fd614172c@nvidia.com>
Date: Wed, 13 May 2026 09:19:16 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before
 return device-private pmd
To: Wei Yang <richard.weiyang@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, sj@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 stable@vger.kernel.org
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
 <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
 <9a56d762-ebe5-429e-9fc8-a9c9e5d0d434@nvidia.com>
 <20260512231442.53qwj37fbykp2qus@master>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260512231442.53qwj37fbykp2qus@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0027.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::16) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DSWPR12MB999154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf45b36-ebb8-485c-1461-08deb07ce7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WZFyy3tP8is29bwuGDRkmOF0cZkOHzDG3dxLhjOvn2tVtDl4jq3OJHQfFoePZhmhxFVwcxcPtd46OaaInTbL++m0NMVdXLy9Ne65rbqFbZSDNhHf/+8YJX8+m1CZci5glYD/9oaTwT3CslqQUmJ8K8vl2yVqp1sb5GOeC8RozjjVEkeiL7K884PQTbLvuq/j0aO4elYQCQ4Z+IZ0GIKzd5uVy/4JYDXuUUK7autjmMdFokBG7ryZLQcKtn641bDENnwSUUzaDLCTFoTzPVIZSmLVb+fNPSWgouQJ6VA9YGMI95A9qycXpBYg0x07PKlb1FRzl325bfJdljxCD5mKMsvuo7Nsh360u9Cvn8wSYMZpn0ixrXvbOfjVWJcQnHutDxpbrjmX6NDCa6ldCCYENk1fVWZjw5IAhgV+kghQmsaaWwMCoLT24RpBE6dHnBhvvu74G13uUxjPUl335a0PIXCXGDHaTo7857T4uoNI9fgxHmh2clMpqOgG8dMLv9VfKPcHDCnEbyzJnSw7adcwBgKXDzZi784w7rBnSog2KiSeP86zoEe4M8ngwtLQR3aFIfpEWOTcrS7TFCDhc4Z61ix1gIYzFcYilIFY+fHFkzNdbhVb77eBth2nQb90vDofM25/Bw/C7U3hw17XWS7CsIVJZDg8g+7DN0Gc+aXyvjCjxt8D0prxsUvAsPHg+PEp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEJoUW1hckxicVlWVnExMnZQWTdYSUZ0Q3VSQWZKQ3IzajFHZEo1dmd3M0dS?=
 =?utf-8?B?MHdPT05jd29OaThnTTMzbXg2amlXMlBCZEV6aE90SWo0SmMrVzdxUUd0dko3?=
 =?utf-8?B?ejladlA0QmhGa0FTWWFKMWVzU0ptcFlxN05ZSWN0OFlBVGU0cGs5OXlUczJ5?=
 =?utf-8?B?N09sWElwOEhKSE1va0kvcUF3MnJaUUFnUFVWMmtpL1VrOXFIZnVUU2xrakM2?=
 =?utf-8?B?anRScjdLTnZSaEtsM08xTXNMcHhLUCtXM09GVmd3N2xKMjdtc3paa3lHM0dm?=
 =?utf-8?B?ZlZ5U2w3VW14NEpNUCtoVzFjSS9nQitJYzVKZjFIaTFtekNZK2JEdXp0YTFu?=
 =?utf-8?B?eFAxS1ZNZnUrUjdweEJSTWhIZHdaQlNlamZUbWxHVUR5NjNoZmJkNXpHaXlz?=
 =?utf-8?B?RVRVUTRCNW4vZGVyRFFLdWhseEp3UFZXVmRkdFZrNytZaEJrYU1GSlRYNHNI?=
 =?utf-8?B?eFVUTFovRzg0NW8xNGh3SzN6N0FKM1VaTTFXZGROc29YTXNPdUFwN0xpL0s2?=
 =?utf-8?B?VHF6Mll2Q1Zha1F6TXNXZUdEeWxEcjRMNHBxM1piQ3ViY0JsNm41UUNHWWVR?=
 =?utf-8?B?d0l1TTNBdW9YSEhMZUF6WTJHM0JUZlVncS9ub3dCVlFTWll2WmFMTG5FL2h0?=
 =?utf-8?B?UE9LdHhYdlg2M1c1eFo0TWlHUjRGT054ZHRZbjhMeVpPbmI3TmJCMVVUaEYw?=
 =?utf-8?B?a1I0NGd1bXloYUpkSXVocDA5WmFPY0Y5dG5tMU45SlkrdTBkV1l1dlU1My9F?=
 =?utf-8?B?WE43TitWVElvVzVJc1kwd1ZTQzdYU0F5SEs0WlJGM2E0ZUxpa2IwVmRZcDY3?=
 =?utf-8?B?QS83dWRibWxIRWdOY1RLWU9yMEIxK0VueVdkNkdTdTdKUkwwdEkwYUVoaVNE?=
 =?utf-8?B?UmxLV1RGTExSTUpDSWtPYVoyYmJhYjNYNUhQWEQ5M1N3TUorVklJYkp1N1lv?=
 =?utf-8?B?RXpIck1wK2lZeVhuWkZrZ0ZJTmFkUTdjcGRsREo0RXFVWGx5SU5nM1YyS0pP?=
 =?utf-8?B?ZUVRU0IzQmtvays4a3BBUnNTKzF3R3RWNXNKVW9IMmFPbGhTcmE2NFludHQx?=
 =?utf-8?B?UWJqUENzVWpYVGM5QVVhMVB3R056bTRwVkF3N1EvNWViTTA3VVk1cDI2OVl6?=
 =?utf-8?B?VlJHZXdpOUc2RmVaN0JDY1dJTlA1cWFNVGVxYVMycjdRRVc5NWp6a1JoRWcz?=
 =?utf-8?B?bkJMNVE4alBKN0FxT0hmS0s3aW1ndVg1ZG5rc2pPUktrcksyN2ZIQm12T0VX?=
 =?utf-8?B?UHJYNHpZUG1zZXA4MXRoNytVNU9LZWoxcW1ONysvQnl3ZW9jOCtPcUZDR3k4?=
 =?utf-8?B?UWFwbktZNlAvblBGTmZkUE9xVHVncmsrTVlkdXRVSy9lU3ZleDdSd2ZhQlBB?=
 =?utf-8?B?aGdCNU4vMEZqMzhPTXdiM1pFRHdvK3czazlKbUhFcDl0VjlXVHRMbk45VGEr?=
 =?utf-8?B?TlpzNC9zOEV0YkJpcUZ5clVYaEY1amlzNFZLRTZFekliSU80OG81RHROSkFq?=
 =?utf-8?B?ZWZHMVYzSzhlNlRnY2s1SjZzcFo1Z3kvWmFEWjd5RUtaeE9LN1BCYlZkZUh0?=
 =?utf-8?B?Zm9rNDB1cEVGeTZwcWFJMEc3VUZRYVgweU9Ud00vcStOR0hoMDB4NnJIUStI?=
 =?utf-8?B?QllNT2xZNGt6WHRTVXVJVW1RMGh2TFg2VnhKRVJlMmk1TEdPb3dIczZodVJV?=
 =?utf-8?B?dE84MUFUb0RXVitDZ1ZvVUlReVo4ZVM2ZWRmY1g0a3U2bUhha21CYm5xSnZZ?=
 =?utf-8?B?UWdUQ0lnMFFNdmc5REU5Wm1lMldKZmxKMG83UzYzNnM1MzZ0SnFQSDNDbDNU?=
 =?utf-8?B?Yi9KNHdRVXB0M1lJNXlTMnpmTmxzRExxa3g3S3RGR2hGcUhleUZUSFREeXBX?=
 =?utf-8?B?dWJ4cEVneXlMV3dsREFCQkN3R05zY3RHcEpTQXI0SWxtSFowc2RidVlqdFZ6?=
 =?utf-8?B?YUFGWm5jOXAxaXU1bFloS2UzMStHaDhiVy9DTVNNUnhyUDV6OU1ZTzkrbXlI?=
 =?utf-8?B?QjZMQkZxbjJvbjFKLzgrNEdZOFBKTktyK1Rkd1lSelpQZzQreEJ1RUtza3p3?=
 =?utf-8?B?aVhjZzl1QUVveUJEQ1NrVkxLUER2OVphNFdIbU9FQlA5U2ZlODVqbXZMRjFt?=
 =?utf-8?B?aWFjS0RDaTBkM01DeEh2NGtaU0Q3QWovbjRkWjhGR0N1b1hlNC9ENGhQK0Mv?=
 =?utf-8?B?SG9CakxuMmJuajJGM3pla1NjcFU2cy9DaEdZaFdSdDlwT1YyZ0NaL3VITmlF?=
 =?utf-8?B?ZnhtNEQvMkYvMitDQW1CSzJoUTNTTFJueUhUcTBZYnRYeGoyOE1HclYxVmZS?=
 =?utf-8?B?QlNzdm5GUm4yTDlzZXhIK1RHUktQSVNKVmVLZGpHOEJ1bTJnQVN6Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf45b36-ebb8-485c-1461-08deb07ce7a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:19:24.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ecL9vaw9VaAxubq7DClZiGd8f+y/TTb6HFqhg1ykaJ/b+xQyR+km5s7A6SxqLt1g3PfIXdT5P/O089AwEPwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999154
X-Rspamd-Queue-Id: 5DA6D52B3DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 09:14, Wei Yang wrote:
> On Wed, May 13, 2026 at 09:03:47AM +1000, Balbir Singh wrote:
>> On 5/13/26 04:55, David Hildenbrand (Arm) wrote:
>>> On 5/12/26 16:35, Wei Yang wrote:
>>>> On Tue, May 12, 2026 at 02:43:54PM +0200, David Hildenbrand (Arm) wrote:
>>>>> On 5/9/26 00:48, Balbir Singh wrote:
>>>>>>
>>>>>> Could you elaborate a more on the improper situation?
>>>>>>
>>>>>>
>>>>>> Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>>>>>> lock and check once?
>>>>>
>>>>> I think what we try to do here is, is to only grab the lock if we verified that there is something of interest in there.
>>>>>
>>>>> I wonder if we should rewrite that whole thing to just do a pmd_same() check after grabbing the lock.
>>>>>
>>>>> Something a lot cleaner like:
>>>>>
>>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>>> index a4d52fdb3056..de6a255cc847 100644
>>>>> --- a/mm/page_vma_mapped.c
>>>>> +++ b/mm/page_vma_mapped.c
>>>>> @@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>>                 */
>>>>>                pmde = pmdp_get_lockless(pvmw->pmd);
>>>>>
>>>>> -               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>>>> -                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>> -                       pmde = *pvmw->pmd;
>>>>> -                       if (!pmd_present(pmde)) {
>>>>> -                               softleaf_t entry;
>>>>> -
>>>>> -                               if (!thp_migration_supported() ||
>>>>> -                                   !(pvmw->flags & PVMW_MIGRATION))
>>>>> -                                       return not_found(pvmw);
>>>>> -                               entry = softleaf_from_pmd(pmde);
>>>>> -
>>>>> -                               if (!softleaf_is_migration(entry) ||
>>>>> -                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>>>>> -                                       return not_found(pvmw);
>>>>> -                               return true;
>>>>> -                       }
>>>>> -                       if (likely(pmd_trans_huge(pmde))) {
>>>>> -                               if (pvmw->flags & PVMW_MIGRATION)
>>>>> -                                       return not_found(pvmw);
>>>>> -                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>> -                                       return not_found(pvmw);
>>>>> -                               return true;
>>>>> -                       }
>>>>> -                       /* THP pmd was split under us: handle on pte level */
>>>>> -                       spin_unlock(pvmw->ptl);
>>>>> -                       pvmw->ptl = NULL;
>>>>> -               } else if (!pmd_present(pmde)) {
>>>>> -                       const softleaf_t entry = softleaf_from_pmd(pmde);
>>>>> -
>>>>> -                       if (softleaf_is_device_private(entry)) {
>>>>> -                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>> -                               return true;
>>>>> -                       }
>>>>> +               if (pmd_present(pmde)) {
>>>>> +                       if (!pmd_leaf(pmde))
>>>>> +                               goto pte_table;
>>>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>>>> +                               return not_found(pvmw);
>>>>> +                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>>> +                               return not_found(pvmw);
>>>>> +               } else if (pmd_is_migration_entry(pmde)) {
>>>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>>>> +
>>>>> +                       if (!(pvmw->flags & PVMW_MIGRATION))
>>>>> +                               return not_found(pvmw);
>>>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>>>> +                               return not_found(pvmw);
>>>>> +               } else if (pmd_is_device_private_entry(pmde)) {
>>>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>>>>
>>>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>>>> +                               return not_found(pvmw);
>>>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>>>> +                               return not_found(pvmw);
>>>>> +               } else {
>>>>>                        if ((pvmw->flags & PVMW_SYNC) &&
>>>>>                            thp_vma_suitable_order(vma, pvmw->address,
>>>>>                                                   PMD_ORDER) &&
>>>>> @@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>>                        step_forward(pvmw, PMD_SIZE);
>>>>>                        continue;
>>>>>                }
>>>>> +
>>>>> +               /* Double-check under PTL that the PMD didn't change. */
>>>>> +               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>>> +               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>>>>> +                       return true;
>>>>> +               spin_unlock(pvmw->ptl);
>>>>> +               pvmw->ptl = NULL;
>>>>> +               goto restart;
>>>>> +pte_table:
>>>>>                if (!map_pte(pvmw, &pmde, &ptl)) {
>>>>>                        if (!pvmw->pte)
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> There is likely room to clean this up / compress it further.
>>>>
>>>> I tried to compress above logic like this, hope it could look cleaner.
>>>>
>>>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>>>> 		unsigned long pfn;
>>>> 		bool is_migration = pmd_is_migration_entry(pmde);
>>>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>>>
>>>> 		if (is_migration != for_migration)
>>>> 			return not_found(pvmw);
>>>>
>>
>> I got some time to look at PVMW_MIGRATION, remove_migration_ptes
>> is invoked for device private pages, would we want them to skip
>> device private pmd pages?
>>
> 
> Not get you clearly.
> 
> You mean skip device-private pmd page in remove_migration_ptes()?
> 

Yes, could you elaborate on why it's OK to skip device-private pmd
pages in remove_migration_ptes() and if so what is the impact?

>>>> 		if (pmd_trans_huge(pmde))
>>>> 			pfn = pmd_pfn(pmde);
>>>> 		else
>>>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>>>
>>>> 		if (!check_pmd(pfn, pvmw))
>>>> 			return not_found(pvmw);
>>>> 	} else if (!pmd_present(pmde)) {
>>>
>>> It's more compact, but not necessarily cleaner. In particular, I detest
>>> pmd_trans_huge(), we should phase it out.
>>>
>>> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>>> 	goto pte_table;
>>> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>>>
>>> ...
>>>
>>> Might work as well. But once we add support for other softleaf types, we'll have
>>> to touch it again. So I'd rather just list what we actually expect.
>>>
>>
>> Balbir
> 


