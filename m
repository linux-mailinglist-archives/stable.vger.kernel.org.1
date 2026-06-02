Return-Path: <stable+bounces-259917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xbRYLghbH2r/kwAAu9opvQ
	(envelope-from <stable+bounces-259917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:36:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F86327C7
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=iIva1X6y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259917-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259917-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5F530C5A4D
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35853C4178;
	Tue,  2 Jun 2026 22:28:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EC3BC69D
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 22:27:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439281; cv=fail; b=WDmZGsS9U1kq6VYIBz9vv0OyOpMVrRi91M/zKc8KS496RDzwrro9DgSHmYpaD0K+ECtym+iBht3zVl5mUuYXjjeNxn5ndE5TMbGbSs+hl7DgidhukXMbJOdfVfttqHnmNYucCQVgHVB5ycq7d7qEEBngUBWs1dC2v3V2Zgo0yeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439281; c=relaxed/simple;
	bh=iAsUiJdNR94S9VSuGvWKJknkSIKZ4FPt3DyggxuUNFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LQJuOVng0uER2K22GX42ISoItTQyje5BOisNzlW1Jqy1d39oNp17e6x5q8+i3UkKBGAnEll1ruzDHhtZIzdW65UUXKVDoggTdEo550Flf4PlCagpAQIhcBLD6I+JNaqH+NUu62h5pRWnEo3ACLa+kua9Pg5Sp0YtNqULY8vew5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iIva1X6y; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epyu36btCrr//l/G7nOoMsjOJRimc+rGrV/Irbi8h6F63/4Zhq9p132AoGhdkqt25b/nUd6HVA41kGlWSETOg9LgpdJVmT8Q4X0YMzdAdC5QU4FuzpBmX1kPpxN02aOaa2m7SO2IhSRqMtYqI6iSgVWYGoC9yYzlMhMvgF6xYM3jYzwEIj5O4nzbMgak4sLxDI4SbIHGL8OGljAYI2c6ELfSqbHwl1pw1OMZhpJIdk3ag+TVydJT8YMIf5o6G1KGMm0nl2hNkQwrH7v3wBYQxZfANoAtQyKzKl2I29qCr3HXHGgsjV9IXvQF/3h/w2o8fUJKzKh6ekW8oPHADQnsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWJT9z88We0r6Tx90ifW3xEnIxFsu7LHShbZ6K0TXac=;
 b=JMuoeMXk+xBeoF88Sb+AM1s74V9u0AG2OKR/9kijlqWkScu5eTTpkqyp/weaXhWuW+gNZY+MGYH8kyVUtcPXqNzRtFRSVhOwZCnrP7Movzbe8n2NZqWao31Ajy/la85T+gHXu+zlXhKPAPSqx0UyYeOMaIdFv5aA/R7VGnC7TsUYmQ6WVWOxz/ijc+ugDG7xAbguNwECSGiTXKg8EoN2VrR35cLC4SKPwMUG/UZtePSB8fFJHhm6swGt26oQIELR+tFivp0i3A7UJucPXXoIa6GkyLdn/kMl5XY7X9mLJip77nJBrectYJRO3xSwQAAMBqF586u70jmPGCo2esmBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWJT9z88We0r6Tx90ifW3xEnIxFsu7LHShbZ6K0TXac=;
 b=iIva1X6yyZZxbycAkk9bsTlda45MaCJql26h2GHPahyVsiLtgtAGjP6Zv6PPn+tqdjf2sYOUibpqdYp2SV9SvJlKCnreukM86M1chU4V+6jMqD5+/14jOSWhQOm8szEy0hZIRtqFxr5pka9Y6Aem/5FzxBdOA1GSVC1fx9RBChM=
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 22:27:57 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 22:27:56 +0000
Message-ID: <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com>
Date: Tue, 2 Jun 2026 17:27:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes
 SDMA0 permission fault on RX 7600 XT
To: Gerhard Schwanzer <geschw@pm.me>, regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 alexander.deucher@amd.com, Philip.Yang@amd.com
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:610:60::27) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5b1b52-8ccf-49c0-c457-08dec0f631df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|11063799006|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	HcKFOmPwnZ290HSUAtQFWzThiAZ5zKeFmhf7pOZabs5bRxcCPwAjE3EsZ+yVt3wAV3CBwEtkbw5/YAvaEqivP2WieS59TsjKK6oqfVKTV4ywIU+D56R7QuteLGcreVkRrpF+X57aUIUeiHV2Xo5L0gJ1xBkA69i4Gnl7wyofrPPHHSfk+RMdUNWHWkktoUEuZbRvAd0mN5g1dk5HqgisZi1O/+eyX7kWfXCueqDiXjquhnLsIS6Lg47Rdm31RdC9R9GIAhVTqxAqJ+jgsG1gjBNyyzm9zqnpnutBW+cH1TSGBwiDepHClKP71xn16A4vMhxuKhcu6q19fsSMuUD/FiM0YKWgTwaU9JIweuBwENwD682+kTh14TWHe2+W9hQQ8aeOxd8O2cVC6Gh38VKRJcY1HFshYiVpRNMRHghytVDuADkJaprsvCRiEMU2FWcQB6aWLH5envp2W9/xO7jbAG16DYQu/HfkzzOp52Uh0dYcLZ6jA8+KLoeq3ygkZGSrkudI3kN83itP96i8woukSol98PmYlZFPykGiJYqqXyKCr0rO9jX/5wfp9qlczRRQ6rA0eWDxofBtZXuxeN7XwPdkEJKDKFIyASwZcdTnka7Q2ica9F9QxpkCKIDfZwZI+ES12puR/zWi5lCZJH50ZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(11063799006)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZThIUllVRUJLbDZwWlpmdS9iK3g0VVpaa2VkS3ZLSldETytEM1ZPQVVobzBz?=
 =?utf-8?B?MFJmaHBTL2kySUIvMTVGRTBya1dPUlhtRFV5U2dpVElVTmhHTzB1VURZSWIw?=
 =?utf-8?B?Z253SytkMEtBbjdjOTdGbEdqd1ZMekY3cWdOYk44K1c0eWFJa1R1dDlwTHhw?=
 =?utf-8?B?VjNZNmJ4alFGZmFSOTNkS21NeUdXUnh4RjdOMnJFbHJHc1hOTDczNStzaG5I?=
 =?utf-8?B?WktTdVJ4Sk1zUklHb1dhTW5GMWs1MUVFR1VFUXl6dUJReG5Tc3Qra0hKWTll?=
 =?utf-8?B?Vlc1Smt6SjRzczRlRytQVFZ6WUphTGZYZlhBaVVoNk1oV2pkNkF5K3RWcTIr?=
 =?utf-8?B?MFlwQ0d0K0tDWmdPZ2prYmxUYWxBMy9WQ2tZRHhuYUFlcDJtUnNHOUhFTW5M?=
 =?utf-8?B?K25DU2tLWnlQREl4RWJNRTQzWHkrU3dqTGNGdUZJaFUyUkp2WXpjTytmT0R4?=
 =?utf-8?B?WlhpbGhxSEV6RGpGY1JCNkdIQmlubi9BZzZ1c2JrLzJiNzA4TmI2OThqWWdi?=
 =?utf-8?B?QmRzUnc5R09zYklnYzdwUTRTVlVyRVF2RVNDcG9hdHZsaWNvTzRtMXBMSlRM?=
 =?utf-8?B?SUgvYy9xZ2pweFBsdG5jNmhjWno2UThzYmo1V3BUK0Z6WWRZRXhnQkhuWDJH?=
 =?utf-8?B?YlU3WkFicDdkUWRubkdSNklFTHlIb0E1UlBoSk1rSWxkcVhhQjM0Szk0TEts?=
 =?utf-8?B?UzJGSjRieldkOWh6M2o4ckNZN255MHgwUi9aaHhOazNrVXhqT05aRFE4VEti?=
 =?utf-8?B?WG1WaFZWR0w1b0hGVXlXYk4vdFBpVVdSNnpFZE9Rb0prcVRzd3QwVG1FYkUv?=
 =?utf-8?B?aUd0NlIwSHlobXJYNzZnM0FhVVNJblMwak1pQ1lnNTZrNExpWXNtcjVNZldD?=
 =?utf-8?B?Z29HQkV3WWpoV2ZNMVg1clkrdmlYdk93WWNaL2NtYmVlaDI3bDJwc1NiWHlI?=
 =?utf-8?B?VDdjZHBhY05FdXBVNFg4YURwUU9seHR0WjJvMVRqeHE1elU2TVVZL0ZnT0da?=
 =?utf-8?B?RERyZjY3ajhabmROMGdENjJpZkdpMWhVd211ei9tbVpVcG0vQUJCZVhrS25q?=
 =?utf-8?B?eXA4QVZmRjdIcFNjTkdGVEV0S3RjdWVvMmYvQmIrV0xZMCtWdnpLaDg0UmF0?=
 =?utf-8?B?NmR1YXFWMFFOaVMveDZqWVUybXMxN05VVVZQQXFuL3ZBVHJiNnYzRzRWVGVS?=
 =?utf-8?B?YlhSUDRRa3BEemdlR0tONFBMZEdtenR0YlpESXJ4QUxKU2FaZjFsSUt4OWtJ?=
 =?utf-8?B?aTR1QzQ3U2VEbWJGZzIvZ01WeU5QemdjK2I3SjJaM2E5eldXTEV5RUE1SXFT?=
 =?utf-8?B?VitmSjhYYWR3QnliMC9HUjVMT2Q3eVFyeVRleFFFVkh6dHpNbnhXUEplMXVv?=
 =?utf-8?B?ZUpmSW0yTTg2YkpSNW0xcWtjd2pQYTBmcnhNOFA3dTRWN1BkK1hpNXFZQUlx?=
 =?utf-8?B?aUFqMmJ3bXJPU3JyUkx0Mko1UlRLS1N6K3EycFdNL1VteGh6cUJMazJtc0Uv?=
 =?utf-8?B?THRSVW9tQTBwRlpEWU8yTXo3eEhlRE5OaVdPVHhOUDBOYVZoeDVwci83Zktm?=
 =?utf-8?B?UkRiQS8wcmlRUTdiazBPYTdEaktUdC8vUHJCOVN5d3JncXEvejVjSTlndWpk?=
 =?utf-8?B?U0JLM2pBKzUrT3VFUGZzQnNTRHRrVGFHQm1VbGNMK0VlWTc4WXQrbUxVY1VS?=
 =?utf-8?B?Y0FSazVoc2R6dzVTOHh5UVZBU0xvYnNXRU1FWUdMakFyU3M3RFd6OHpFNFpT?=
 =?utf-8?B?K2RPcnIxeU5ncS8rSWxlWjIyQ21NRzdhY3l1RWE5TXI3ZmlCNUU4YWkvUnc0?=
 =?utf-8?B?M0x5cStmMnJyeEpvcjdLelFyNlRYSkN5M3R4ZmFoaU1ndUt3cjZqeXozTGd3?=
 =?utf-8?B?V3lQQlBIZFdPVi9mZ2xDWkRpSnBwZzdueGNpbmRIV3BvQXFnbjBRMzNZQXR3?=
 =?utf-8?B?SW9IeWlsbFVyQnZlamVkQVJYZjZiSUpBbXhuMTRYbmZYTDVSRThzTTJnOEdj?=
 =?utf-8?B?eWVUZkhob3FMU3NsN1RMZzhNUTVzWGh5RGFYcDJ6dXQvNElva2E0RThmZTIz?=
 =?utf-8?B?Qzc0NEw0ME5YbldmSTZDclJiVEFrcUlWalcydmlnb2lZVGdkN0NuaVJMbUdr?=
 =?utf-8?B?cXFRUGsxZW5zS21BcHpWdEdjQ0MrRVQ4UlpGaWF1WFcwZFZtOCtCd2ppcHEv?=
 =?utf-8?B?MEhWZWk0NTR1R2VEWlh0ZS9MOEMyRmZuYUF4S2lYZUdVblZYb3pPd2hjSUc0?=
 =?utf-8?B?RXVibmh0UFBnQVFnZlduS2xTKzYvS0hPT2lDZ0xaWlg0OTdkcEF6SVBzeFlI?=
 =?utf-8?Q?rw3wFRUM2m8kgn0IXi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5b1b52-8ccf-49c0-c457-08dec0f631df
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 22:27:56.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL2SFdzBHka+b8SfYUjKDpS2PmfjJ27NIfwj9q1lgTMTEF84NZXW3g87Tz5VWRuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259917-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:geschw@pm.me,m:regressions@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:stable@vger.kernel.org,m:alexander.deucher@amd.com,m:Philip.Yang@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiaogang.chen@amd.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaogang.chen@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:from_mime,amd.com:dkim,gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D2F86327C7

I cannot compile kfd_svm_split_hsa_copy.c, there is no 
"trace_history_replay.inc".

Or can you  send the test binary?  That should be enough to triage the 
issue since it is a regression as you mentioned.

Regards

Xiaogang

On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:
> Hi,
>
> I would like to make sure this AMDKFD SVM regression is tracked by the
> Linux regression process.
>
> GitLab report:
>
>   https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>
> The regression was originally reported on 2026-01-27. It was bisected 
> to the
> same functional change that Alex Deucher's revert patch later targeted:
>
>   448ee45353ef9fb1a34f5f26eb3f48923c6f0898
>   drm/amdkfd: Use huge page size to check split svm range alignment
>
> The affected kernel line I tested identifies the same change as:
>
>   bf2084a7b1d75d093b6a79df4c10142d49fbaa0e
>
> Alex's revert patch:
>
> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html
>
> A small C/HSA reproducer is now available in the GitLab report. It 
> does not
> require PyTorch, ComfyUI, Docker, model files, or the original 
> workload. It
> uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM
> SET_ATTR ioctls, and an HSA SDMA D2H copy.
>
> Single reproducer command, same binary on both kernels:
>
>   ./kfd_svm_split_hsa_copy --upstream-ab
>
> Same-machine A/B result on an RX 7600 XT:
>
>   448ee453/bf2084a7 active:
>     1/1 run faults with SDMA0 permission fault
>     GCVM_L2_PROTECTION_FAULT_STATUS=0x00841A51
>
>   448ee453/bf2084a7 locally reverted:
>     10/10 runs complete
>     no ROCr memory access fault
>     no new GCVM/SDMA0 permission fault in dmesg
>
> The bad fault page is inside the split tail and inside the SDMA copy 
> range:
>
>   critical tail: [0x722429d61..0x722429dff]
>   copy pages:    [0x722429b30..0x722429d70]
>   fault page:    0x722429d65
>
> A full ftrace/PTE run with the same C reproducer/SVM sequence also shows:
>
>   split_tail ... current_remap=0 old_remap=1 missed=1
>   MISSED_REMAP_CANDIDATE split=tail
>   no amdgpu_vm_update_ptes covering the fault page after the marker 
> before
>   the fault-side GET_ATTR
>
> The suspected code issue is that the split-tail/head remap predicate 
> introduced
> by 448ee453/bf2084a7 can miss tails inside the final 512-page block. 
> Since
> prange->last is inclusive, ALIGN_DOWN(prange->last, 512) is the start 
> of the
> final block, not an exclusive upper bound.
>
> I also sent a short follow-up to amd-gfx with the reproducer/A-B 
> summary and
> asked what original failure or workload 448ee453/bf2084a7 was intended 
> to fix:
>
> https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html
>
> I can resend the reproducer source and summaries directly on-list if 
> preferred.
>
> #regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898
> #regzbot monitor: 
> https://gitlab.freedesktop.org/drm/amd/-/work_items/4914
>
> Thanks,
> Gerhard Schwanzer

