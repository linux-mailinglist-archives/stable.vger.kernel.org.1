Return-Path: <stable+bounces-222934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPmBF7Qzp2k9fwAAu9opvQ
	(envelope-from <stable+bounces-222934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:17:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E711F5D23
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5032301F9AA
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014EA43C05C;
	Tue,  3 Mar 2026 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uABAHe8I"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2242F561
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565143; cv=fail; b=DXHYZiHw99PqNrwrWr9T9v+HkcbWFm5/hbp0T20JVYuEh7I5U5bxZeDxBJ5ELkKw2sUOV12Y2ilhoLk6kmVirzQpmCucatIomcSA9Ul15hZ/BmAhrxJu18bos0aTCxNFElzepsCgRCEioIQMw0LYmhsiTlwpGQbR8V+T3Y8t7x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565143; c=relaxed/simple;
	bh=EnnVDFSp4e8kjpzg2dVvsdXtyuPmmnYwNdiQusrxoHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eV37Ym+dCckus0dzlIEuX+jsCUAwMkU83S0t4nyZPeJ9+QKSiUwKW3YBqnBBkyZDq3jSbFuHz2QvDKwRkuvurZ1x1LaoYzzbueq1rCUqbDZj9Q7FjRtjVWo59DNsz2fU5qYdWAwt0F7HkIno113oUk6bTNz29iqvPsQAApWjgU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uABAHe8I; arc=fail smtp.client-ip=52.101.57.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC23MJt2EZIp+ncOWrIyOwSGcFg4HjIjrq0aqnstBd+WoT4m3O7aOrNTkxB0Gfljv6yZ4IHOjaLbn8H20nusTwevrZDR4qDDzHvqLXSkyaQsbS0KDolKwjWBNBYELYcQFXKQXl+BZoeHINa9XCvE8tMcdeWEv4ULepDlrRFdXkcIYAOE0TZOpw0hwiR8q6fyhrjqSrty9ZeKdOFmngpZNFHYrheSf+TfebhuxHJ/z7XrGWzfcM5so0iL9DMokxMqHAQMgki76XxkiGXiX8GUD9JPKT26vcnVJ7A7WJfaLcGdgP1UA3wqF3fsfjl9K527GKyy8rxmhiuIgGWLZjuu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBlya9OxhpnOgd9HUk8VmO/UTZ6qEYrdSZMzcbErs+k=;
 b=bvd6Bs1a88cek1D+6Fa8GvP6YR6KKML00+uh72ZqbIC/pK9sec+xSJ+NHswvx2Fm6jW7fsGfk2iJ8275d6ktVX7/lL8IDeluLZMBI4Dy3Pz1S+3WkicscRB+5scpApC6bgcXT6mlwm3BYyzNYPKs1gtmX+jML9H7YKX6mQTHpB90NPJP3Ql6Kv+KW0MF43y5+IYBfrJIsTZvCWuTWe/+yy5Y2X74AN9KfTc2DY8tkzGgShxfqlml8F6mymNVnAxpfb6n62xMggAsg3q1hZfMscunr2TcR5em93/SAoC1XP+TNrHwUEyuQ3ZcOvRpEBO6HxKk63TQ9geSqSPoxcUOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBlya9OxhpnOgd9HUk8VmO/UTZ6qEYrdSZMzcbErs+k=;
 b=uABAHe8IeSdUp7KOmff7ncpStnom4r3JwfNPWrD2oQRp84Meh75ChJEHk273gnKvf5QC3n+A7JYKia8gdRIQSL1co5JOZglp5S0lX+3LI2tkPnUfSGiqufUeo0Lp9U8QDx71BsGi/D/NwvNygF+JUVCz4HrNXi+hPF14Nl+ULEnU47XW7u4N04kxgmbPgFmsJnRWFixBfcZ5+Bmf792kMERROQ2dEXiaTL9PhiDGzkJsSuZeHt5yJ0fctkNd8BibC2RA46zbj1OTnVEoAB+uL/jukQzpX7pZ/JnOcvm1ID7pPH2x6nE2hMsSchFj1klkcJIwaij6PadSQp+GdHPStw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:12:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:12:19 +0000
Date: Tue, 3 Mar 2026 15:12:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <20260303191217.GD972761@nvidia.com>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <0a10ea33-937a-4294-b9a1-9323c706434d@arm.com>
 <aacohVRfAK46lOjo@box>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aacohVRfAK46lOjo@box>
X-ClientProxiedBy: MN2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:208:120::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5901998c-87c4-4378-8add-08de7958c9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	mTHXT/WsbNdjMMfW6FS1D6eGjaVeIXfqjEpJ5zDfdkteXneqrJKKUdJqmSY29tSXKiop6srSCs4oqieXZP/gyNA5f0S24DqTXN+GPDMGmmJbIg+fU+YiKW0BfLwj2f6VbdGx60zjO8TrxogaGAnbqO5cE7Grfsc+U1PScDUcKBH1SCkyjY+TpJFFUUjkSWZk+iMgtU1aeWNRMDlKQpNYjJfUVaslP9hRDqLiXe4uAm/6j7RkTijO4ECJtAnzgqi4Gm+nnRriCw5j/MZ3inEij5pUVe9BFH/LOOXntdFHNCL8ZSBNIF3Vgzp5JM6BJJMk8mhWGMySfMOUFz/CI85kisZJXHI8vpNHya/AHbK2ra9lITZQpNtiL18Zy7DJejsdJE7e2FCwKAvluBkaZp8b/tG4MuFVUarVIFcl2Web1EVdh3kn3A+L/gasv3aCjwvfeB6nbQNnnOpNZOjYc7cq4SEM70m5TXXC7F7Os6aOgXl2k2FU/S6a3n2FM3FSQoVrANyPNGb5CoCJLDFBoe0LT/feFeLjtUZ7xueSYaR+6OEA568GbwOx/C4KV+GCaavfW36AQwmbTFyX4KTNNLzEjJ+RIihoFlFx0TE9lZTyilUumHkLP64JRwx+0SC+81Fu6i+211PtL2/MFCDEUMW+MC4Vcha3GO9I6HYaFrrVAZat4IYm8ozaAlzvzreFePXfwTnoy9nfWYX4KVrk9mOr/JjKKkm6J6LzvKFL+0F/uGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVpHTk9nVmxYcGRrU2wvb1lXRnZFQzFjUWY3UW9ob2tmWlpNa2VGN3JuRVlY?=
 =?utf-8?B?RGU0NzVjMThBelhCdkNnZVRadEVvczhKR2d1VTdBN1lhLzdhN3BuSWFDeW1U?=
 =?utf-8?B?QmVBMnhMWHFEMlo0dnRmcDBsakdHVVZZTVJlVkl1UXBNRkJJelV5MVBKK0VC?=
 =?utf-8?B?SUpPMjlhbFlWOHNZcEhhUnd6YnBQUTAwa2V3a0VSSGZNWmtEY3dEVzJWNW50?=
 =?utf-8?B?SU54cU5GQzd2dVBPUG8zeXBtbWRjYnJZWVE4LytJOGVVMndBeHRhSTc5N3Vx?=
 =?utf-8?B?RW5VcnlXOHhjbDM0RXZrbXFyRTVDTWRWcWIzSFZ2WVA3Zm8zZkxVRXdacGQw?=
 =?utf-8?B?S05PWWxHR3F5b3dtdXZ0dXRLQUJMdGo5RlRyUkV4djZHK25kMDY4TW1ZTldn?=
 =?utf-8?B?TzdMN1BBbDRHN285dFdSejRDVHJVdWp5aHRBdTZsUXE2Ry9SK2JLMENoN29l?=
 =?utf-8?B?RWNWYkZlTTBsSUpNbkRuSkxWTlArVEIrS2VpbDlkYVJPelhmNjFhWG93Mk02?=
 =?utf-8?B?SjYzT3crYlRzc2huR3M2VTlYK1B6K01LNmpKTVB4T2xkMVlCYUtaRnd2a241?=
 =?utf-8?B?NTErUmhuZkhpMVVTQ1c3TC82VXBPTFNuNGppK00vbXFzaU5vOXlmMXBybysr?=
 =?utf-8?B?ckR0QzdXcDNRcGZocGV0RWpBUlZiaUVsZGdDQksySktlRXpUMmVCM3FMR3Rv?=
 =?utf-8?B?SmR0UmppTDFiRjQvaHR3djVBaVdMNWVKUHhJaWNsdGVHRzk4OE5aNFpCZUYx?=
 =?utf-8?B?Vy92a3NkWEZ0R2huUDBpSlErSTRKcWw2azZWbVRZQWNDSmFqRjA4bHJrekg1?=
 =?utf-8?B?b3BpOFI1cjl6UndpalpnQ0tGL3gzVlBtdllFcnBLWm13RU9RbGtlenUwRW1N?=
 =?utf-8?B?bG1SeWhEUldmZ3JBTVcyc29jSjJqbUN3ekRLMTl0bTQveGdrMENxVHJuRUNK?=
 =?utf-8?B?R2RCQm5FVHljTHpSaEdVUUpWcktFa2hhNWdHN2gvUXhWRDZxRHNRWXN5eU9D?=
 =?utf-8?B?Yjc4UVRHempHUGloSnRLUW5mZStob0VkUGZXSmwrSzVxMStKRFhxSDU2eUhi?=
 =?utf-8?B?MmwrS1dlcUhGWGpuT1ZrOUkvUDVveTA3MTJGQmhNem5ueTVoR1dKdW0yVXhr?=
 =?utf-8?B?M2lFMVVzVzcxR1VXNklJYUE2MmcrdXNlRHk1R2tBdlpzYzRDYTdrWXlvS1lz?=
 =?utf-8?B?c2JHcXY4VnUxWmdHbXB0VzBOeS9tdGFQMDk0bDFBU2ZkckFVTUxHUm1nOEpn?=
 =?utf-8?B?SWpwOGMxSVBMK2pHOC9ucmU4TTdOY0hyWTd1dHVFa0JmV0dZYjEzdXpLL25V?=
 =?utf-8?B?L2hWL0JCd0g0REFHYVRUNEZ6Umo5WVdVSTEzMmVJN25JRlZZWW1US3ZjZjNK?=
 =?utf-8?B?bG5LQWEwNCtGV3BURmZSRjBUQ015cnFBRmtzQXk1Y3ZDYUY5WDR2akwxbzJ3?=
 =?utf-8?B?Nm4zRE4rWGxPMmJsR0tvSERqay9LOERwM21PY1ZDMkZsZEpldk5IbzdGU0ZZ?=
 =?utf-8?B?UnBtcWFNa2NRMjlFUWhTTXlYRFh5V1laWHZvaXBmcERSbE02TVJJOExtMERu?=
 =?utf-8?B?Um9YcnJQVEFsYitsbjA0VCs4VG52WnZRWUZ0WVhhMUdHNUJGMEpqOWVidjFo?=
 =?utf-8?B?M01FQ09xS2wyRTduRlN2SHg0a2haR1ljU21HYlNZdkNYMVQxdk40MzRaaVZU?=
 =?utf-8?B?WlZkdUFUSVdZVG55T2tBTDA0dEJzSm83K2xWMGJlb2VkOXhhMWsxSC9VeXBU?=
 =?utf-8?B?RVpybk1PL0NvTnFIb280cWJMdVRaU3EzbG9sUlN6Y3dxdU52TGF4clB0Z29u?=
 =?utf-8?B?bmgwN1BYcU9VVkVrbm05M2VyVmRWZ3hNY1lUOGRFajVKNWlMblZOSGg5Nm54?=
 =?utf-8?B?YTBpS0xKZUhvdHlueUhFRFZFRTZFZ2xrVElleCtQRFIvM0NZWndMM1dBL05W?=
 =?utf-8?B?bGVtc3pOWFVzajJjNDh3a2NjNzFDMmxZQTRnamhLUitKYXZ1dWhsVE53VGVU?=
 =?utf-8?B?SXNnNUhCbHowa1JoNHV3U1ZhYzhSdWtTR2xyNXQ5WnAvamV3NGJkdDVrQ09l?=
 =?utf-8?B?bkpCOTZYWXZWelBCWUx0TW84dmNCMzRRblYwTW92V0dQSDQyOGxiZDJrNEd4?=
 =?utf-8?B?RDg0TysxQnBtcWdCWFdlUjlhQzA1LzVjU1lZc0oxMXd1RGtaVU5Id2NsY0VS?=
 =?utf-8?B?aDJHUndJdEN3WE1FT0IyeHpCUlF1b0h1ejdTcE9VSkxreCt2MXlMa3RsdUZI?=
 =?utf-8?B?YnZrTzgyNDNKZ2hyUWw4WjVHNjBGSkZMNkJDdmFiZ3E3bnN5N3d5MDhFYjJq?=
 =?utf-8?B?Ri9TRzkwSGozWlJjSzRvaGdjZ2hJbFpjRWdYdUVVRzhKdU5mS1lCdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5901998c-87c4-4378-8add-08de7958c9f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:12:18.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqLr079Tx61bMyFaKoyRszOLMRH7P7yq6CeU7x27ZmfAom8kNl+xJnWszVYr4fkH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763
X-Rspamd-Queue-Id: B9E711F5D23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222934-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:40:00AM -0800, Piotr Jaroszynski wrote:

> > If my reasoning is correct, then I think arm64 hugetlb has a similar bug; See
> > __cont_access_flags_changed(), which just checks for any form of dirty. So I
> > guess hugetlb is buggy in the same way and should be fixed to use this more
> > stringent approach?
> 
> Given sw-dirty is managed by sw, is it correct for sw to ever create a
> PTE that's sw-dirty but not hw-dirty? If not, then I think it will still
> work fine for the SMMU case as sw-dirty implies hw-dirty, and if it's
> missing then we will set both. But for thoroughness it could make sense
> to be stricter and add some comments there as it does feel a little
> fragile. I'm very new to this area though so probably best for others to
> comment and tackle this.

I also am not so familiar with SW dirty, but the big thing to be
sensitive to here is that the CPU can get by with setting something as
RDONLY | DBM and the CPU will flip off RDONLY without issue, so you
might not notice it.

But if handle_mm_fault() is called on something RDONLY|DBM it *MUST*
clear the RDONLY for all CONT entries, or fail the fault. Otherwise
the SMMU SVA explodes.

However, I agree the __cont_access_flags_changed() looks concerning.

I spent a few AI $$ to cross check this and it echo's Ryan's concern
but did not find a specific counter-example where PTE_WRITE |
PTE_DIRTY | PTE_RDONLY can happen for hugetlb. I don't really trust
this negative result, so I'm inclined to agree it should be made more
robust. I like the look of the patch (below) it proposed too.

AI ramblings:
PROMPT:
Review 20260303063751.2531716-1-pjaroszynski@nvidia.com.mbx and focus
on __cont_access_flags_changed(), huge_ptep_set_access_flags(),
hugetlb_fault(). Does it have the same issue as this patch is fixing,
considering the following additional note:

A big thing to be sensitive to here is that the CPU can get by with
setting something as RDONLY | DBM and the CPU will flip off RDONLY
without issue, so you might not notice it.

But if handle_mm_fault() is called on something RDONLY|DBM it *MUST*
clear the RDONLY for all CONT entries, or fail the fault.
====

Analysis: Does hugetlb __cont_access_flags_changed() have the same bug as the contpte patch?

The contpte bug (what the patch fixes)

The old contpte_ptep_set_access_flags() (contpte.c:614) used ptep_get()
which gathers AF/dirty from ALL sub-PTEs via OR, then compared the
gathered result against entry:

    // OLD (buggy):
    orig_pte = pte_mknoncont(ptep_get(ptep));   // gathers across all sub-PTEs!
    if (pte_val(orig_pte) == pte_val(entry))
        return 0;

A dirty sibling makes the gathered PTE look already-dirty, even though
the target sub-PTE still has PTE_RDONLY in hardware. False no-op → SMMU
infinite fault loop.

The fix replaces this with contpte_all_subptes_match_access_flags()
which checks each sub-PTE’s raw bit values
(PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY).

The hugetlb code

__cont_access_flags_changed() (hugetlbpage.c:400-418) does NOT use
gathering for the no-op check – it reads each sub-PTE individually via
__ptep_get():

    for (i = 0; i < ncontig; i++) {
        pte_t orig_pte = __ptep_get(ptep + i);
        if (pte_dirty(pte) != pte_dirty(orig_pte))
            return 1;
        if (pte_young(pte) != pte_young(orig_pte))
            return 1;
    }

So it does NOT have the exact same gathering-based false no-op bug.

But it does have a weaker form of the same conceptual problem

The check uses pte_dirty() which is:

    #define pte_hw_dirty(pte)  (pte_write(pte) && !pte_rdonly(pte))
    #define pte_sw_dirty(pte)  (!!(pte_val(pte) & PTE_DIRTY))
    #define pte_dirty(pte)     (pte_sw_dirty(pte) || pte_hw_dirty(pte))

It abstracts over HW-dirty and SW-dirty. It does NOT check PTE_RDONLY
directly.

If a sub-PTE were in the state PTE_WRITE | PTE_DIRTY | PTE_RDONLY
(SW-dirty but HW-readonly), then pte_dirty() returns true (via
sw_dirty), and the check would say “no change needed” – but PTE_RDONLY
is still set in hardware, which the SMMU would fault on.

The contpte fix’s contpte_all_subptes_match_access_flags() would catch
this because it compares the raw PTE_RDONLY bit directly.

Does PTE_WRITE | PTE_DIRTY | PTE_RDONLY actually occur?
=======================================================

Looking at all the arm64 PTE manipulation functions:

-   pte_mkdirty(): sets PTE_DIRTY AND clears PTE_RDONLY (if writable)
-   pte_mkwrite_novma(): sets PTE_WRITE, clears PTE_RDONLY if PTE_DIRTY
-   pte_wrprotect(): saves HW dirty to SW dirty, sets PTE_RDONLY, clears
    PTE_WRITE
-   pte_mkclean(): clears PTE_DIRTY, sets PTE_RDONLY
-   HAFDBS: can only CLEAR PTE_RDONLY, never set it

None of these create PTE_DIRTY | PTE_WRITE | PTE_RDONLY. The invariant
holds: for writable pages, PTE_DIRTY => !PTE_RDONLY.

Tracing the RDONLY|DBM scenario through hugetlb_fault()

For the specific scenario: all sub-PTEs are PTE_WRITE | PTE_RDONLY
(RDONLY|DBM, clean writable), and handle_mm_fault() is called:

1.  huge_ptep_get() gathers – no dirty siblings, so vmf.orig_pte =
    PTE_WRITE | PTE_RDONLY | PTE_AF
2.  huge_pte_mkdirty() sets PTE_DIRTY, clears PTE_RDONLY
3.  entry = PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
4.  __cont_access_flags_changed():
    -   All sub-PTEs: PTE_WRITE | PTE_RDONLY | PTE_AF
    -   pte_dirty(entry) = true, pte_dirty(sub) = false (RDONLY set, no
        PTE_DIRTY)
    -   Mismatch detected -> returns 1 -> BBM proceeds
5.  BBM rewrites ALL PTEs with
    PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
6.  RDONLY cleared for all entries. Correct.

With some siblings HW-dirtied by CPU (e.g., PTE #3 has !PTE_RDONLY):

1.  huge_ptep_get() gathers: sees HW-dirty sibling, calls pte_mkdirty()
    on gathered
2.  entry = PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
3.  __cont_access_flags_changed():
    -   PTE #3 (!PTE_RDONLY): pte_dirty() = true -> match
    -   PTE #0 (PTE_RDONLY): pte_dirty() = false -> mismatch -> returns
        1
4.  BBM proceeds. All PTEs rewritten. Correct.

With ALL siblings HW-dirtied by CPU:

1.  All sub-PTEs: PTE_WRITE | !PTE_RDONLY | PTE_AF (all HW dirty)
2.  entry: PTE_WRITE | PTE_DIRTY | !PTE_RDONLY | PTE_AF
3.  __cont_access_flags_changed(): all pte_dirty() match -> returns 0
    (no-op)
4.  But RDONLY is already clear on all PTEs, so SMMU won’t fault.
    Correct.

Conclusion
==========

The hugetlb code does NOT have the same bug in the sense that it doesn’t
produce false no-ops with current code. The key difference is
__cont_access_flags_changed() checks each sub-PTE individually, not a
gathered view.

However, Ryan Roberts’ observation is valid:
__cont_access_flags_changed() has a latent weakness. It relies on the
invariant PTE_DIRTY => !PTE_RDONLY (for writable pages) rather than
checking PTE_RDONLY directly. If this invariant were ever violated
(e.g., by a future code change), the no-op check could falsely pass,
leaving RDONLY set in hardware and causing SMMU fault loops. The contpte
fix’s approach of checking raw bit values is more robust and should be
adopted by the hugetlb code as a defense-in-depth measure.

The recommended fix for hugetlb: replace the pte_dirty()/pte_young()
checks in __cont_access_flags_changed() with a raw-bitmask comparison
similar to contpte_all_subptes_match_access_flags(), using the mask
PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY.

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index a42c05cf564082..34e091b398123e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -389,28 +389,24 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 }
 
 /*
- * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
+ * huge_ptep_set_access_flags will update access flags (dirty, accessed)
  * and write permission.
  *
- * For a contiguous huge pte range we need to check whether or not write
- * permission has to change only on the first pte in the set. Then for
- * all the contiguous ptes we need to check whether or not there is a
- * discrepancy between dirty or young.
+ * Check all sub-PTEs' raw access flag bits rather than using the abstracted
+ * pte_dirty()/pte_young() helpers which conflate HW-dirty and SW-dirty.
+ * This ensures PTE_RDONLY is checked directly: a sub-PTE that is SW-dirty
+ * (PTE_DIRTY set) but still has PTE_RDONLY would be missed by pte_dirty()
+ * but will cause an SMMU without HTTU to keep faulting.  The access flag
+ * mask matches the one used by __ptep_set_access_flags().
  */
 static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
 {
+	const pteval_t access_mask = PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
+	pteval_t pte_access = pte_val(pte) & access_mask;
 	int i;
 
-	if (pte_write(pte) != pte_write(__ptep_get(ptep)))
-		return 1;
-
 	for (i = 0; i < ncontig; i++) {
-		pte_t orig_pte = __ptep_get(ptep + i);
-
-		if (pte_dirty(pte) != pte_dirty(orig_pte))
-			return 1;
-
-		if (pte_young(pte) != pte_young(orig_pte))
+		if ((pte_val(__ptep_get(ptep + i)) & access_mask) != pte_access)
 			return 1;
 	}
 

Jason

