Return-Path: <stable+bounces-219198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEf3MCyanmnXWQQAu9opvQ
	(envelope-from <stable+bounces-219198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:43:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E9192716
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A043072A2C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3F2FF65B;
	Wed, 25 Feb 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W+YzC/4z"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A62F2914;
	Wed, 25 Feb 2026 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772001800; cv=fail; b=iXzFUFZiRVqCSxdE/0/90ObVmwW8ijHEEef+RnhyHqNMe6JIE2Qyotdf6qdq1TNl5iyWSMBw3IJZmKXWLT7AhgjCRs0Csxt/3aR3y4gfssE3ONGJdOiw+ORbvwllTtdWoCVpvNf6fHKMNnIcLxrBmiN/8gOqC59zrDYMOIH03KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772001800; c=relaxed/simple;
	bh=54PmbWu5L1fHstMkmo5PqBwuydS8sBRc9Ag6ibJm0+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwbqPyy2YwL+JiMSHFGp2fxv4L9qBxP+oeULI9fBrQhK1cS+prJFKh1USUBX32ObWUBzH7PSnLz9svZt9TO9D4aNSOM5g6NydOCxHT4sy4gVdqjEbOzAQoEOFhk9EypgEV8ScjRx52p5krALfuWEafExGk/4c4E0RIL0u3TUfYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W+YzC/4z; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzSvMmc0MHAWQJZtvdVikpOd3J+so3aEb3OzJVcYvEIkkuH8gGOLgsmNLJJJVVJImK5AQ8POwBPDZJa05IjoDALV8zhauee3BF1OgIDkrjFdC4M7cbYJFLdIhHGOUyIgy+gUaIYC/7rl1UsOV1XAI+rZHzAcVP5Zvql9U6oYIcTmEFqqbeOpm7d11tKUKTfSQuNB28QpwU8huSwZgJZZELG0YCrICYa0FxuWxYB6423PRQGPY2Ue0KNf4sJqsytFC6USlnah9Ea/tAvJJLe0GhB0Das9pm8BYItF3ahfRSa0YgjuNXz7Fp4RVCI9lrMDSEV17v6ISCMuAbbRHEkZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdU2STJVRvdbjIoV/FrxuZzRnj4yDyjVBP+dPtfZjf4=;
 b=b09e9K/QqcC9Z08SDedM7NYfst7zTB3F0/IWS8Z18qJdtytz2oF2CgJUe6a1ZazGNp4jwBLw2N3Cy0WuzDkPVpCzhgywHIuljjJvEhutPpqMkG2BEmaJciVdtuhrvP2jJ+CE65w/dTbU7in6hMQzoOis/ncO+unS8Llu15mrzVEedgFg5ZH+lEbvhKjqCKvE4QNF+kX1CvUnlHWHAz/MoLRApwSNs7YCVokcDilPGtwRX7PICAkaqgXwLE0MCAEdCn8sKzTEk8rmSTYJvht+ANXRGehYyyLccRawCWIwMuUfk0Wo11Yh8AmN/n00gDIktp7ewWxYhpU53jy1OrNZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdU2STJVRvdbjIoV/FrxuZzRnj4yDyjVBP+dPtfZjf4=;
 b=W+YzC/4z2raVLis78xcGGwnzScknrfarl1TBtoUlUzNRMgTX4ZSBYfJ7mDM38526tkaqBi81A7sT8Jt7ID/NH5s1n88U9cxe8AuHUtX2Td9AvjgI8PCU5ySZjRX5e/+Vf44nbu/1dnLdfkQ/YDrrsFG3p7UQ27XGVC4gf3m2i2HBFnbW+KzYVJhWVlIqEf/XKLHzh3Dr1ATf4vt6QL3OtRSq4D0E6x9Fnfv68sChkypx9K6LjC6ZfnSeAIMdez3PobNTlg95VMzbn1873ia9ITwQwPHKfurOTysHzxOnZwrUBCaDywJEYebjfTN0Nm+dNiaMEe+q3T7okSDVqbezAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:43:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:43:15 +0000
Date: Wed, 25 Feb 2026 07:43:04 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Disable preemption
 between scx_claim_exit() and kicking helper work
Message-ID: <aZ6Z-JrJM6nO_XsT@gpd4>
References: <20260225050055.1069822-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225050055.1069822-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: a7238621-f02e-4a3f-70af-08de7439276f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h9Hgz6PJweMyPh3Zu/bZEZk8Oyf2+eADTqGN91HfLtUE1r31ScKnhQ9qJbrl?=
 =?us-ascii?Q?keCRr8eM0hniAfhdZ92qy/Wagr1zEsTYmLh+y6PwwOi490ebsZHsod5zmY2W?=
 =?us-ascii?Q?8tdRXT+UJLj8OQQhBlbGRUH7OfrAHIiBeEvvCVmHwNRM9yI5Luy1IB8zJyIV?=
 =?us-ascii?Q?dGzWpp+OHF4t3EcRZvUQAIegvsOY0RUIjuO2l6zy6I4t6lDYqjbmsFTFLt0i?=
 =?us-ascii?Q?q3rPVK2Q4NUNXVj9sLxEP1SqSQm2QC2l61k5W4bsWmQBUy4AKi3AITeBJKpv?=
 =?us-ascii?Q?jwit2DyR1RMNOYAxoEovQioMTrtjkbhnsr0c2ouwsnqwOUTjO+OIBGhbMI1B?=
 =?us-ascii?Q?Iip0guaQlkc56wvFeRdQeaJtOAQfT4ReaWBj1ZdHqTjxVqt9eLn0Rz9aK/CN?=
 =?us-ascii?Q?wXZOuhDWIE9QkZHzecLGDWBp5Pbldh8uYcCuBuldpXyF/aHniRYk5eKJ0nBm?=
 =?us-ascii?Q?W1Tp8L2/uDKyo4YzH/3Oqw3vPnqfdQ0XXCaQey1tgWaqfx34AZaQ6Uu8hMBW?=
 =?us-ascii?Q?5vYNg1f7SWBoEdRd3Zuus2Qg9dJapeAPTS94lNGtc7w0cTWVOsOYH1SHFQBk?=
 =?us-ascii?Q?Y9bZ5apMUgatHPMJ6p6zsEDqBnbQvs2R5Jp8eZCg0pAuojBZdggEBHq5+LX4?=
 =?us-ascii?Q?Jm1z/y79Fff9JsXQhMLC0cJ857qw4+/2u0LR4ZgX3tePpfOzbc3/wxZNsnWW?=
 =?us-ascii?Q?5/AikWanL93hiNKjHH8JZ2UMMK/J9zRIvq5BwUmUvd2ZGiheUBNrUbf82o4+?=
 =?us-ascii?Q?k+SnzI/yChswG+oxEU09n7U3P9LO00F77vj+kNKlTv1w4DbX7W27ykE0KtDD?=
 =?us-ascii?Q?fm4/CcMu8t6QRWb/oE8NmS9PsrJ0T4nv0STkkhltfpdBh+qDCA7OEmtJ6LZt?=
 =?us-ascii?Q?7YytpTohBAJau5sSF5N1PwaBBDiiJkRbxdaG+xX5SLLEum/NhBbw0/xkNy2D?=
 =?us-ascii?Q?UiLZXY2hpTiuZyzx0QzoQwEsSfuCexcRlzEBHjOscSP93aMzrHuIyLd04v0E?=
 =?us-ascii?Q?4kXV2lze+ocs7BNUXvSvcO37IIwuLC5RwJEHSAGabxWQrD9YQNIsWe83jS6v?=
 =?us-ascii?Q?F3hAryu6ksI1RjYGfNRdFaycYEw+4yx7eP5kk/78zjRfLk5nkor13bDIl367?=
 =?us-ascii?Q?ldSivzkBxcqQqtQjJZF3tvzzwAvvTrzGlyuwe23G19m6h6Ic4qxU0uzQN2h9?=
 =?us-ascii?Q?/g1KhEm9c0YlVWCF4HuJ/nZhP9flGSC0M4cnsucChGIE6KhVS/NJiqKwSgIC?=
 =?us-ascii?Q?yLYWduoJbYuj8M2glzGCKBYSx6wJpBA5Ll9kR4AEdqPd0XSop30C0oXCjg5k?=
 =?us-ascii?Q?/N8KPbybc+BowVpatpK8JV72l4gwv6DCI9OdAWGYsD/JCyadvieqX3TpHyWj?=
 =?us-ascii?Q?+jR0rmL+u7VckAY7GXzKHXUkrQ8NeVqNDVTUDvTaxxUkSOcwjkekHoqSJRN9?=
 =?us-ascii?Q?M5j/GklAdYuW5+P8CtlGnemIwqkam9X2rtln25m41+Cys8r658ZwKCgeAXT4?=
 =?us-ascii?Q?wBpF5SCGgtmYNLA3TuTvMhDfhNXfjLKSiwkuwXLjcEcqfERcGPMp+Mt9yZEe?=
 =?us-ascii?Q?puMZDalET1UOdiiJGrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMSsJPkyu0pJ41/+8JVU1F+IWjwbIaPj4GdVPpnNGGTgq+XMVT6qsqqe6w0a?=
 =?us-ascii?Q?IDOoELxN3lWFk9RqCZWnnArV7VQgArDfSzcrBWp1Lkfyan54xaAewpTh4kIw?=
 =?us-ascii?Q?ITSOr3T/mQghu1T8Znqq+2Kiuggk27/XknDdam0eo1xuykF55FOfbzQWH+xk?=
 =?us-ascii?Q?A9DXKTCXw4nqi8ydL1CILmRofBOqgrqF0kGN9y4C1ZR/+cYNgO7ximklD7cB?=
 =?us-ascii?Q?D2Nefrs55+D2o3ED97m15uII+dqVwWuLe6DZfDlQcaB+Ws82SOMwwMf4XZBr?=
 =?us-ascii?Q?XhhyGyhdN6aJuSYqMpuhmT4c9K+pq1hk3Pt5E/cAmXxCW5DoidDoEguAw5jM?=
 =?us-ascii?Q?oFFThz/1t/QixPcam81UcVd3QpNC2mOmpTdl6qmDNSPu1O8RBkWq+ncXelnG?=
 =?us-ascii?Q?CZTRe7NZblGUwndkMBJRdRdrK+k63s6KtLxjVJek0CMVWsnXzaUA+F8FRJ3+?=
 =?us-ascii?Q?v2ozdl00cVdnMd/mQwGh4KRiqLuhefaMJ4dVmueahYRjCrG0v6PChywnBTpj?=
 =?us-ascii?Q?NG09aEGtHEZ/FOYb4e3ispSr40WHoPEm9xH9wSqLGTyx9kfQGigGUF8+q6Gt?=
 =?us-ascii?Q?u8zpxqUFfxq786/IFR4mshi3AhbBAZZHkHwUaJb7fxPCMYFb+/auax9Xi90S?=
 =?us-ascii?Q?oX6Ta+UO6n+zt6I0iERRAtuGd9sx/rue2XrZT9hTE75UHAxIQBt8mV7Raaj+?=
 =?us-ascii?Q?9J4SqzoXsDCq472lrVKmUtz1l8nmqNk2YC/7thQVAO3vxWQrpNPkFxeiPaIs?=
 =?us-ascii?Q?AvdDak1TNIlQ3uotkwxt2LwK/8WMC3YNVG1bWjeT7XqVvboFOyZg3RWhi8Ba?=
 =?us-ascii?Q?PlreZuSQhbKYKslqWS14Qorq4LoZklIk4EQq5INqj9NbAmK76mqTW4nPHuOd?=
 =?us-ascii?Q?eE2hsIlI35ia4FsO2iyQu1aYZ48fKp8+Jf4Qfzx3bL8y8gSeH8EGROnSl10G?=
 =?us-ascii?Q?wxR+58uqdUQEScQxrSjf6oDbk/F2GiaKqjs7DzwJUZdMUzQuycsmzBPb5oYJ?=
 =?us-ascii?Q?eqecUeLohg0KAVjk05aUJZ8PxPMztJ8cx+Irv/dRjNNkQCTVquAz2Dy11bLQ?=
 =?us-ascii?Q?uVSdBxXOPDHDouZ95wxViFziUpVMTWy1y7bDF7jD0Svu9fF32gKF1txuIBUJ?=
 =?us-ascii?Q?ypiZ4YTM9F1Y4tv+EWXcjSro3fzOhMAiRS5Xz3Zm9hty1OE9SuDXEIOg3BFa?=
 =?us-ascii?Q?qKfcmfYg300Gdj88UObz6NanjHGf04TCFFF1Qui4p0FRz14IxRiI88EVT0Kl?=
 =?us-ascii?Q?H3C2klCmaeB7pgs8tFoAqEpGtQL30zpgsh/bWsFGHzHJNKttU+iRo11c8PI+?=
 =?us-ascii?Q?ofXI4ZSmmdy9ZDtFABJblkNWcZXcbsjoshhoECm7JNjHvqqO1K6B4/BOZ1rP?=
 =?us-ascii?Q?ghSm1+HDTIC8+hNET3KwELa7Hl5U+ymO59V7FJ2Ceih2YJ17DgmHAVYej/Vf?=
 =?us-ascii?Q?7JI32ej+aA2pUyJXisQUD55fagXP4TduM3uP2fRwqRoPakdQUJ16aBLaSGGg?=
 =?us-ascii?Q?eH0OssELJCrFGb55J+doqAGlA1b2JnQhQ6Q1MyzKsFzfOIBAM5vzZHSfqIfN?=
 =?us-ascii?Q?PVzEAjWZySuitc9Yt85RP2uS85noBq5qc27eQZJ0hNoVaEC0zOSRMA5ZsIxP?=
 =?us-ascii?Q?wtAjlnzMMzGOR5g23KRRIBUhSZuw8kPJPXShAsyYvCSTAhv/p9Gi0XHTES7P?=
 =?us-ascii?Q?VwynbUuTkyiPoO2yg/3XUOhaoirgC8WiJyIpM/6VEE9ZX6ytVVHhB8UffN6t?=
 =?us-ascii?Q?Sef5MCv5ng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7238621-f02e-4a3f-70af-08de7439276f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:43:15.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fjgcSFab5uZAuQcuId32fTIUObfmMJyqJVLkCZFEO9ceLW4RRkqN7Yw2BWRtt/36SvY20hsXdZYQhQ0hFaGmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219198-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 201E9192716
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:00:55PM -1000, Tejun Heo wrote:
> scx_claim_exit() atomically sets exit_kind, which prevents scx_error() from
> triggering further error handling. After claiming exit, the caller must kick
> the helper kthread work which initiates bypass mode and teardown.
> 
> If the calling task gets preempted between claiming exit and kicking the
> helper work, and the BPF scheduler fails to schedule it back (since error
> handling is now disabled), the helper work is never queued, bypass mode
> never activates, tasks stop being dispatched, and the system wedges.
> 
> Disable preemption across scx_claim_exit() and the subsequent work kicking
> in all callers - scx_disable() and scx_vexit(). Add
> lockdep_assert_preemption_disabled() to scx_claim_exit() to enforce the
> requirement.
> 
> Fixes: a69040ed57f5 ("sched_ext: Simplify breather mechanism with scx_aborting flag")

I think the same race window already existed even before this commit, we
were just doing atomic_try_cmpxchg() directly, instead of using the
scx_claim_exit() helper.

So, probably the right target should be f0e1a0643a59b ("sched_ext:
Implement BPF extensible scheduler class").

Apart than that, the fix looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c18e81e8ef51..9280381f8923 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4423,10 +4423,19 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	scx_bypass(false);
>  }
>  
> +/*
> + * Claim the exit on @sch. The caller must ensure that the helper kthread work
> + * is kicked before the current task can be preempted. Once exit_kind is
> + * claimed, scx_error() can no longer trigger, so if the current task gets
> + * preempted and the BPF scheduler fails to schedule it back, the helper work
> + * will never be kicked and the whole system can wedge.
> + */
>  static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
>  {
>  	int none = SCX_EXIT_NONE;
>  
> +	lockdep_assert_preemption_disabled();
> +
>  	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
>  		return false;
>  
> @@ -4449,6 +4458,7 @@ static void scx_disable(enum scx_exit_kind kind)
>  	rcu_read_lock();
>  	sch = rcu_dereference(scx_root);
>  	if (sch) {
> +		guard(preempt)();
>  		scx_claim_exit(sch, kind);
>  		kthread_queue_work(sch->helper, &sch->disable_work);
>  	}
> @@ -4771,6 +4781,8 @@ static bool scx_vexit(struct scx_sched *sch,
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
>  
> +	guard(preempt)();
> +
>  	if (!scx_claim_exit(sch, kind))
>  		return false;
>  
> -- 
> 2.53.0
> 

