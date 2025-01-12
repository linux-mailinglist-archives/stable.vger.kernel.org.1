Return-Path: <stable+bounces-108308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7272A0A7B8
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18B81888A00
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC4416132F;
	Sun, 12 Jan 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lFpti3qm"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1E4086A;
	Sun, 12 Jan 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736670678; cv=fail; b=PFizcNYdYB1fVaD2dbx3RKtIn10+Q4oQ0cCM/UpioeghY4AsCM346w5LuS1BZvof5qkAS9Q+n0HfJu7Swt/OVVgvqUUDpsYWe8aqsxbL/Pw+RMzumGkysbW+DGhYUUGnqlmOyniexkS8zuINPP/hsoWbNVbb7en+LJ+b9/TJ494=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736670678; c=relaxed/simple;
	bh=DQ0FO931YGOWC/yMWWtvvz4I7eeKi8yz3OJLL/PV0kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/15JXJT+SYMOfUdTBNtv5linEx+yOnD8j5ycQA1QHeruwQ0Wp3oKCZ30QFsRb9YtpCAjjvYXUrY1vRdeHSvX+0KgKHzjT80ajpJ3OslwLaLGik/CdywxbGGlYxOOBaKQzW8ms9oeqZljOEq4k8YKyyHD+3tHuqNi849dkndUMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lFpti3qm; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OokQhtAs6fnapX6UaxF3NsncJO0dr8VSwQvEmPUlKDSzHKL/jo7qkTriVDVM2WqnHLHJoEDExWPdKSOOIR7M/b8dmIuYMuUexdZENxgEhVJMB839FWUnMqXdjfQuUeUq2uexTLPw+BiA5ksyLFbkF7wXCcPq4+OyuOqgIg/jZbpcepqlasN7wjT73uAXSjzB3ebtq5uRSPGnTXAX5+eWaEWTaoh1fColwy/CZqOE8zbhUkL0UwJxewgIN33wxHmwBidYCog6ExvXt/9GeUHbUbpsy5wCohESjwfqVighTiozQ0/ziazdGrWha6UH3c3L9X7ODyaju4D6pTgzbSb+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIzFsdcYyN8fh9Dr6f1zWbDdAxpOUMKtzzcmuXkp7Yk=;
 b=s3kxBa4jdWpAtgmL1fa8T2tGrA1jFUANlkhOm7Ab4PHNjW9kxcW7fRBUhDwdtaw2SfyZSJl7g1kA8A/lhjtIra7XP0AWSqxXbTKcXfvJI6bXRZ3RyFF3kJCu+YVSFg+8lX51tmwfah1ebvSRGuavtV2BGELiiyuX2WmeJko15Mobeq8TT2yZSAITqrP439H9OFfhlUmhrHeXrSqzdjuq+JS1nUvwbAK9B0GtGI7zTp/ZJwHKLxhIit/p1WryY9RjIAbdZHRaHPgO07AbvF+JvvFb/js8XFRWOFKrfAYGkJqWGaTVILdDiGPcAQu3bAOg9TPtL7Y00MWjqWm4np60iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIzFsdcYyN8fh9Dr6f1zWbDdAxpOUMKtzzcmuXkp7Yk=;
 b=lFpti3qm7D3EXRxC51GgwyRE7vEs4tVF2h8djthvr/NIbI41gGdgFD4JfksJoNnS1hKKycRn3DJAuyzEih79AmUxC3dsQBkWNZ6rMPzBjsJvTiNQjfN4G3gge5z2hC35frL25M2sT9AR3ScAZu30MbKlk4gAsRqizWiotrUpXZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PR3PR08MB5867.eurprd08.prod.outlook.com
 (2603:10a6:102:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Sun, 12 Jan
 2025 08:31:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8335.014; Sun, 12 Jan 2025
 08:31:09 +0000
Date: Sun, 12 Jan 2025 08:31:07 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: 1534428646@qq.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobe: fix an error in single stepping support
Message-ID: <Z4N9y8XpblDoI5Jp@e129823.arm.com>
References: <tencent_4B60C577479F735A75E6459B9AEAB3F54A05@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4B60C577479F735A75E6459B9AEAB3F54A05@qq.com>
X-ClientProxiedBy: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB10521:EE_|PR3PR08MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5976776d-d4ad-4b78-8f66-08dd32e37713
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQ8b0K2loAyVB1NwgK1d/tCIJwO8l7rfpuFH5DkPUyk5way4n2xs8Kpjn1q7?=
 =?us-ascii?Q?UQj+sMc30AmjuqmtN1fIwY4606X2QhB3rf3zDZSj71ZEd2Vf44Gh1ZZRsEcG?=
 =?us-ascii?Q?aBRHJazVt8MWqvXKWZFpjyUMC7Ig///RrcYY4Ueo/eS6EwPAy4znWOI0EBpE?=
 =?us-ascii?Q?X/Dg+4qWtMkO5iNMsw4ImAcIveLSP3/DPE4cH6q84+yPdqCjSP+JUWDjClP0?=
 =?us-ascii?Q?6H/XZ6vcrCQIJ4WxdqPwc/n1ZA0t+tD8Af2wKSbNtO/OrlG3XasvRavJZEqN?=
 =?us-ascii?Q?NjXNgjG4k+MALT0WiJta/BvQKEFOSEdCQftGBddu0Y+25EDJqEnw65iEcbUL?=
 =?us-ascii?Q?Yz5FUpe0vwmXm3xZazLJjTFvKeaZwTDRGHcK0+o8Us41L3kIei2mUt1pZ2FN?=
 =?us-ascii?Q?4xrMnPFy0wBkJMCKYin6hhq3V1Pghc8mhb6HrvRU/SZMNRYC2AnGyZTsRtdy?=
 =?us-ascii?Q?iXyHM58C/80QaqM2JR4MaRJYCqtCaxM7sEObRFC2XvkWUrPTlbw8iEA6Qu7Y?=
 =?us-ascii?Q?3ZENd+0MdXzviZzaxpxCTrQbvT3fMJEPEjOAFp9LusQ64BrrwCT9cAGZuAX5?=
 =?us-ascii?Q?zZ+TdnBegYB+y+C5jiRwdAHKYwwAkqp+IEgIOdSUhwBSMINhh7JsUXomJJ1X?=
 =?us-ascii?Q?R9mY1DsbN8QldWaRdH13L+NZjWsooAKCA1Gu7dQ/oU0tuTyBlnMGvCrvvIQz?=
 =?us-ascii?Q?JqpODK6/6QufGZCcaBmOrx6wXT5iN2ohFR1MrgADxMVSHD9IG0lSEJ+xQx8c?=
 =?us-ascii?Q?uTUSZJK2O32YA9SgQfMwrt+i4j5FG9Vc3gzfBdjyUMJ0AM4TyOLHJ/4UtyNC?=
 =?us-ascii?Q?alVZB66GwfsHYpgMpHNT6lrFZf84w1U8J9RAOSKix+0D/Ox2K6vc7IO9EnvF?=
 =?us-ascii?Q?n/cVskRjoJTnCxNofomxiWVQQbfYdD3wYEhf8BllgGg8eOTmKhl2oW8Mod85?=
 =?us-ascii?Q?lCodJFQHU2vulX5k6klftxEy2txkgc8b0OqFocB2C866OSdpfh6ukqzx3TxP?=
 =?us-ascii?Q?ZWszvEdOjqNV1V2yEgMY8vObG262r73IKokV9+PcmQJlNICtE6pBafSSbfPN?=
 =?us-ascii?Q?wEj5HkOt/gPhfD2W6x+dDqno0Ffk5SlM77DenEeKbmzIuukzaf1OnB9DSzWK?=
 =?us-ascii?Q?HDvTQvVQLSpA4oX19fHUfCG+oNMsryQUyNre3sH9KdADuuhy3EMoqqD4hlD1?=
 =?us-ascii?Q?c/2aYi0AgY7OfVl/F3mGBWr3t+bAABq2Fy/jIf4Kw2EGrzg2f+/GgdnTjkm1?=
 =?us-ascii?Q?HTJZBirLoF69d+Qc531iUhEXt+WvutHNd5CDFlmBc8Antk/+1n3QQ0iSAliP?=
 =?us-ascii?Q?uC8h4RwQ1jN6ZvhfNDqWCq+ROKY7ee4tH2Azg4pCE91+s/5SwXarj3Z4yAKX?=
 =?us-ascii?Q?YaPe73kdgQDmUAVQdgk0yI1HsC3L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z02IJkQfPr62SJphtxSX9zPJt0+NGGWKjbAD3FARBldeLTc0AuCt6XcOOa9E?=
 =?us-ascii?Q?QUAuAiFTLeIVf3VeMKp3u93ZnXSpIE1rDTQRdCf/qD08YGs9J3fidKF6VHoc?=
 =?us-ascii?Q?N9RZAqo27VWYmD7RJKgwuxYqLYGBGLLOUIGJKSUoOPK2r2P4VPfa8l96ZOcE?=
 =?us-ascii?Q?Ov9k8w1+W+DLz4G8su1vA4PReBV2LXdOvGJ/VEofKFFhVyKD06wXq+H0HI6d?=
 =?us-ascii?Q?m6A5uo/d+SMhRQla3YujWzo7WJCEW6M7jjXbHqtUdqkvzEJPS+RWBws9O6SV?=
 =?us-ascii?Q?7xHQVWFiF6u0ECyeAnnVxo/o1l9XSgx3R9Dz2y7oaxxrd9Pvte+HiTpaccCZ?=
 =?us-ascii?Q?GNmU130fnlkQYQY894S6QapznaSfFpgj0TnwgdOjVKhOsyfRIzmZOEwBozXy?=
 =?us-ascii?Q?qz2bNuDa3+daPgkSIZaYBRRdWXX/uWiZDOwiXqXTYm7r6euuWDsPaX4Wy+R9?=
 =?us-ascii?Q?GgBl29DoTGT7ghCxBVugwYPOX0duPFQFtsJ1j9TNgKBrhlBXgrAWeBY4pve4?=
 =?us-ascii?Q?FJtm+I2JNzznEhAV9CnPJWRU68CvfKIkpbtqmA6BjXQubGFiP072yw4KPnXx?=
 =?us-ascii?Q?frLmfZFf3MBnA47px68ssjRpSfrU8ygZpSRIhRpPZnCLIdrjTPEc/1lxMnF6?=
 =?us-ascii?Q?H2ksk8ttaxHU6t9HDTsdXO0FK2jB3TyZglC5F4J40CogQS/Gt66UkZthmeGw?=
 =?us-ascii?Q?+/IR8eyH+G/UvTyLZ5XItBbXCN2Uiuc+iAGDXAK17U6PW3WptA4ZQ1s+cf2J?=
 =?us-ascii?Q?vMLeulaegnerpM5ffoK5vcFcsO3MDuRdn6wGgmmsAS5+axNe9ZwowdL7YWpE?=
 =?us-ascii?Q?uIGqtDus7klKG6PrhL7b5+7tV7bBqm1Cgj0uV3hJZ4Fixcv/OQTTpkcjPw2H?=
 =?us-ascii?Q?PZwFh9ulqXEU606rC3a9NihVy/pPCMOVbF/7ihxTbOMwb5451ZI2q0wxCnDV?=
 =?us-ascii?Q?I4YpDC4saxND98Z+LH5ThGkao1DxGgamjd7ODSzYd9sIWr5jor05wRifOMg5?=
 =?us-ascii?Q?C/R+gs1EwvgC3YMZRIENWWwxB1Um8KN1c5NcxijH+x1RNeYg+0U4gjqYElIh?=
 =?us-ascii?Q?xbCfU3M+k+7/JFF3V/XTpc7kj9SS4YeFaLGsltBFC7+3U3JMturEKXcm/e7A?=
 =?us-ascii?Q?wQ2RUK+Y+clR9GION1j/83Yltd2nR1XSVR/c5LM69cgaY32IR1Eu5Ai5hMil?=
 =?us-ascii?Q?2isvjxQudrQ/7nNqDN+J+P194qufwngm7qyLYSdKK/JMHBmlkXOPiatcZ42/?=
 =?us-ascii?Q?fWcUYAirvYoD2RioUBwZ5uYMWHypaT6cPipqJtHXa+o358ngxf03eaZ7ef2k?=
 =?us-ascii?Q?vjL9QWRqf/vVXwbF1Q0uvdCa4kKdch3YwBIoj0a1DCBTFY8LqzBx7nWDLHCp?=
 =?us-ascii?Q?SW7CjxlR1mRG/XE2/d09g5x1NMbpyqnLuCBXC6IX2GFv5fkvHDjmhB6owG8W?=
 =?us-ascii?Q?FqwKRWqPUn7ptT8nEgwSosTymArkN5TBH+louhjUf/L8aCNvXP0Qg2eSlEj4?=
 =?us-ascii?Q?tAkmU7c10egMI+LeJMKPPzoT0KmVbWzApahFe4yqFtuDyANH/OGjpUpHs53w?=
 =?us-ascii?Q?Us63VKywMbK1WSmPwE28grfxcJs42ksOlovkt7nu?=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5976776d-d4ad-4b78-8f66-08dd32e37713
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2025 08:31:09.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk6oqXsERHhbnax1Q63QDqLFJwQhs3jy8Bwnc7GSlyIpHCdQQHgpNEpf2UC9R1nllEHMeVAVH0D2zeNWv1h3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5867

Hi Yiren,

> From: "Yiren.Xie" <1534428646@qq.com>
>
> It is obvious a conflict between the code and the comment.
> And verified that with this modification it can read the DAIF status.
>
> Signed-off-by: Yiren.Xie <1534428646@qq.com>
> ---
>  arch/arm64/kernel/probes/decode-insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> index 6438bf62e753..22383eb1c22c 100644
> --- a/arch/arm64/kernel/probes/decode-insn.c
> +++ b/arch/arm64/kernel/probes/decode-insn.c
> @@ -40,7 +40,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>  		 */
>  		if (aarch64_insn_is_mrs(insn))
>  			return aarch64_insn_extract_system_reg(insn)
> -			     != AARCH64_INSN_SPCLREG_DAIF;
> +			     == AARCH64_INSN_SPCLREG_DAIF;
>
>  		/*
>  		 * The HINT instruction is steppable only if it is in whitelist

Nit:
When single-stepped, the DAIF bits are set, in setup_singlesteup(),
Reading a DAIF via mrs instruction isn't correct value as comments
describe.

What is conflict?

Thanks.

