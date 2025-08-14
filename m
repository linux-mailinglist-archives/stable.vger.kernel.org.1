Return-Path: <stable+bounces-169547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BDB265FF
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A5E1C23BE4
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3E2FD7AB;
	Thu, 14 Aug 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b="qoRlJ6tX"
X-Original-To: stable@vger.kernel.org
Received: from moint.1and1.com (moint.1and1.com [212.227.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421F2F90CA;
	Thu, 14 Aug 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=212.227.17.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176181; cv=fail; b=roAp5XUVeFEHDziNMzKz4yyL+Gskb/B/4fPeY1SHEnM+mJkW61loIUVNGAIL0b5f0EN5V3y2Il4CSSYqvnFL7vYnzbz7AaGTDzcSO5vVulcCgwhroo4Bhzp41e6iS1XDI9vJQZL2QHV2LHUdjCFNnbzq2x3tDswzatrVRE+dOb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176181; c=relaxed/simple;
	bh=awRynXbl0lGHO7YluxvikEAO21QHGOa9yEyrR11uD+U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swS03nLGaDdQMwhBBFigOAxIlmzJbZlNh9hEImG9gKkZv8zfXTIYKqgtazqlKJoP0QgvQ4VaVQxcbDXVUcE3UCXr1x0+RD9Gt7QO5xUQhDpPYGcDibvAcAnsgizkacdc+ngS3SlGoYBoQmXsku/nfrmBv5NJwSM8tU5Dp+CePSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de; spf=pass smtp.mailfrom=1und1.de; dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b=qoRlJ6tX; arc=fail smtp.client-ip=212.227.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1und1.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=1und1.de;
	s=corp1; h=MIME-Version:From:CC:To:Subject:Date:Message-ID:sender:reply-to;
	bh=AAES14BFG2FFHmaVQzb3C5VQhVQj/xqs+fHJ7XIuTpU=; b=qoRlJ6tXgoo5v9ppW47Ooxg61/
	HYu0xsqPq8SHx+yizlhQeJ3lLbxQrXEp5dbuahiJX2c2mWpfemDtFdjk2u0pXFaSNYTrKVfajJVlU
	tZRqySQmX9bZymgVDZCwQWvY4gXsn4RU1hGnN1AHaiHw6vY9fwN+9i4gYN3egY1r1XtT1AqnIdVkA
	irrc/ZRjf/OM1TrbQSqY1kEwK+w4AyHFrj7z/YiphTMn6YfQmQh/hpIILGzJXRwzlveUmD9BWHhst
	m1DjP/7PQ8MMhtUJu6gng5ATCXQsgM5BJdDEFO3C53EkqjgjAY080Zx2vAEf/E9mQd55gJuV4xv7A
	bpNdqddw==;
Received: from [10.98.29.9] (helo=BAPPEX024.united.domain)
	by mrint.1and1.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <julian.taylor@1und1.de>)
	id 1umXQZ-004QfM-2u;
	Thu, 14 Aug 2025 14:51:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/gxET1zZRyo5aXQKz8gIuvSACUzUSmjW6LjGYVLAPzpDQpNAQ759soaSUa+HnfiYU+jpQwqhQcD7elch43+xdnxiyVuhh2Zp15ZmrueEJnV6hm18MexHWpzRc/NDhXw1AtFjy6/J1VsEaCa/440UXXPAuP5vBo1dHb3efaVeXqSHa0rJagt/YfLrXSytBlfwRwCZzkYFCXe0Uywr0Dq6TTfadrkXz2r3gB6KfyqMOf3UHi7JtDCKqaRTsfQeb3CaNwBIZSVQCFe1GC1+vyci8Wo48GCMAUIMQzq+m8B9Ol2NxpM9U79dgqjpuZ3iEfef0QvP6q0KRdsJnUaVrmDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAES14BFG2FFHmaVQzb3C5VQhVQj/xqs+fHJ7XIuTpU=;
 b=w1/X/990za0nfEzF/FBuDO9m8TphjVMpCe4J7gfJ8f6T8RTCSraIHQp7GhcmEYeYnI0dPQ1bbIEMNqYrf1Jk1SSFEUwBA9EeONtgoIiPK83MAtEqH0eorFBPwclPVEuBW7IyvM5uGWgHQeko3DhfTbgM7KIPrRpWkhTg7ZZHiX3/KRiyLKJDruwxGsBBaQAdi1XufttCabiUvtQoDy9X191rXSfaJwplP39nviYRU/rQG/O/J5lrvOfr9iqbzrMi4qxlULW1vs3rICAnfzadrbVK8SSAC32SIZmwNtQpDZUfFlQk/bkNjyLds62pKvP2cM387FPXQbbm3c+RmU1HoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1und1.de; dmarc=pass action=none header.from=1und1.de;
 dkim=pass header.d=1und1.de; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1und1.de;
Message-ID: <9fa0c0ea-9c5d-4039-856f-222486283a3c@1und1.de>
Date: Thu, 14 Aug 2025 14:51:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: avoid infinite retry looping in
 netlink_unicast()
To: <patchwork-bot+netdevbpf@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kuniyu@google.com>, <edumazet@google.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
References: <20250728080727.255138-1-pchelkin@ispras.ru>
 <175392900576.2584771.4406793154439387342.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Julian Taylor <julian.taylor@1und1.de>
Autocrypt: addr=julian.taylor@1und1.de; keydata=
 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
 7oKCuVqh8kE3PYxoRHbuOnFcKDL7dV8w3Mak
In-Reply-To: <175392900576.2584771.4406793154439387342.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::13) To BE3P281MB5199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:cd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE3P281MB5199:EE_|FR2PPFC33F14332:EE_
X-MS-Office365-Filtering-Correlation-Id: 237e467f-57c6-4c02-c9fd-08dddb314901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ai9POTd2RS9nN290RzVSbmlNcVp2TmtNeVUrbEg2NzQ5a2hSdHc4aXNucWdF?=
 =?utf-8?B?N1lNNE0vRmIyNUk4bk01Z05qMGcyL1MzSG1TWHVPSVFOUlA2V2RJWlpsOFpk?=
 =?utf-8?B?U29vd1pyVFduRXB2YnN5eEEwM2xSY3ZCMGpUYjhnWkN5TjZsZjJZUmhiUEpj?=
 =?utf-8?B?TW5yTlFZVGZpWG1JMWZLNDY2c3BlT0p6TVBNTFg3QnFDNFQvQnN3SGZPMWVS?=
 =?utf-8?B?Q1F4WEtrWEV0MUhQc1dZazFxckRsUGZqZXFwNjlYYktLVndYR05pc1dYVndZ?=
 =?utf-8?B?NU90SFJHUXprUUtoU21xNW9SK0dSRDZ3TlR3cnpiYTZyRFlGU24vaTczNDlW?=
 =?utf-8?B?N3AvdUdqSXlHL1g3akRDY3RveEJ2c0lxd2c5Z3VLb2ZtRG5EUjdTQlpDaHNO?=
 =?utf-8?B?WUZiWjhqV1JkeGtoM0hNb0VxYTBtL2FEL1dsTFByMVJJa3FHZXlVVllRV1Q0?=
 =?utf-8?B?UU15eFhHbWxYLzFvWHhxY21MQ1l2dnFuMmkyQUJXMlUxbWI2RWl4c0cwZlR4?=
 =?utf-8?B?ZTlUZndWOTRhZzhycTk3RFJZUGVVNTlRa25HV3k4SUxBWE0rZE9OdFJpcHV4?=
 =?utf-8?B?K212amFQMm1oZHBDSkRSa1p1Wm1PRkF5Rnh4WkFTbHJDa0FRblEzRk1ZRXc3?=
 =?utf-8?B?UkxlK2lCMVprL0w1eHdIWWwyNWt4Z1FkOW1oeTdYYWtndE1kb0JIUTJtNVY2?=
 =?utf-8?B?YnZEQmp6bnhxYmJRMDcva0NuRElqazVDRWJrcXNFaGdXTm1GOEgyWjRNVWY1?=
 =?utf-8?B?UnViK0pOdXBLTlhBWVZCV3dNbVVoUmNUdnNRd0lJNW9QSWxjLzhPUUZibnht?=
 =?utf-8?B?MTU3L1Zmc05rczczQklRTHBCb0RoQm1Ma0JjZ1Fxb0Q3YkpEa0pqUmRGVkF3?=
 =?utf-8?B?OXRzSnJ6LzdsK3liekh4TkZhRm5ZRlkrMzVudTg0Qkd6WTZKUmVCOGhsei9J?=
 =?utf-8?B?b01YbURaZDQwZ3B3N1JYRjFqL2RFNnpaSm8zbnN6WHhNSzNrMjNrQlh6cTdl?=
 =?utf-8?B?UVM0SVpxdEFxZUlNM1pvRmJOcDlxNHU0UVd5dFlOSklYaGRIUkFWVlZCRWxq?=
 =?utf-8?B?VktNY2NtNjdDQzVMejdmSlRIdzY2YjJhRGhhU0VZUVg4ZW9kU2hhY3lJRlpx?=
 =?utf-8?B?ajFMYXZXVllhWU50YUUvVHdjZ1YwTGhZQTJDa1ZLSjdISGw4d0hQdUtaUlJ3?=
 =?utf-8?B?WUprbUlWYmFUN3BGTGZqRlJ1T09SZDVoZGJUU1pKMUdpUzVsRHd0QW9xNWdR?=
 =?utf-8?B?YlZ4MDFwWElpMW8zRTlKRkVIMFhiSG42YURlUjc4Sk5QQ2hwZ1dSdUVyZElV?=
 =?utf-8?B?QjNrQzNRR1h0NFZSUXpMNE16a1pDeHRZMDc1YVdNMExHUVhlTTltckZteE11?=
 =?utf-8?B?eTNIMUo3S2hWSHJIQ2Rpc0xHelBoMzJsRTlZTW40aHYydnRheDJPUlM5R2Y1?=
 =?utf-8?B?RWs2eVpyMGRYTnZ5TldFZEV5UkJnQXFyR0JDSnZVTWxMYi81RW5qVlU3M3FR?=
 =?utf-8?B?TjFpTW5tRlE0cnA2U1NFWTQ3d1FtMk1ON1RZeDV0MTlwT3ArRDkxRWFkeTJ6?=
 =?utf-8?B?akR2T2Z2U3NvM2h2V1YzTkErUEpxc2w2SnBiLzArM2FEdUV2dDFJeCt4Vkc3?=
 =?utf-8?B?cVhjL1BSLzRNZDdzTDBTaWF5Wk1GM2IxbklVVU5aQURmRFpiWWlEQ1pjT1Ft?=
 =?utf-8?B?b2syMVBtYkR3U2RXWW1NVjV4VUF2bmM1NjJISWx6OXlyZy9NL2czNkZndXVN?=
 =?utf-8?B?NC9aR2hudDV6ZDlwZ04vTlE3WkdDNDkyQmkwVndESi9JYk1tV0w0WGRoa1o2?=
 =?utf-8?B?REhHQVJiaHZzOXJYamFSa0RRRDFQVW9CT0Y2cmg5UzZTeWlYckNCSkFRZGlW?=
 =?utf-8?Q?eOHFfqhcqcn1P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5199.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZDYzFNNXluSWUrRXhMREJ5Z3VnTDQxODJxcnl2eXZyQmFrVjZ5SEJLa3FR?=
 =?utf-8?B?Q2FZVkN6OGFxY01vVmVtTWxYN2dDd3pyMmJuV21mbXAvZkxYYjRVLzJMQlFN?=
 =?utf-8?B?VSt6RHB2b0l6eTJ0R0lXUlZMMHNkQVZCdi9MZXJLVlVhbTJuaTAvTTdsTHhE?=
 =?utf-8?B?Uk9hdnNCYzFJenhIeVRFQmpiZFFlejlOWGhpUFRRdTBlODJGcDBTWlhHc2tu?=
 =?utf-8?B?S2JDNWNrNnZiU3B6WUwvb1JaRlY4QkgvQ01LMmQ4ZGpXL1llRjhGTVVpTTgr?=
 =?utf-8?B?WG9pRUw4bklVTzMzTTZySDFkNGZBdG5oSmk0d3VwcHRaYzl5WmllYlRpTlVQ?=
 =?utf-8?B?R3lJWUlKS2JUUUhJUFRCTzMzL3FSZHlCZm51TkFESDIxR3Vnclo4ekNZb2R0?=
 =?utf-8?B?NGswRi82Wk9mMTE0RE9lalhXVUg3NUtYZTJ5cWs3Zm1HRzJCTllKNnhSLzk3?=
 =?utf-8?B?azZwUW84OWVBSDVBdnBuVFhXelNGMDVuVnRWL0l6U01pckhPOC9aTklWbzdZ?=
 =?utf-8?B?M1ZyTGVlYjdxdU43bHhUY05lUVovVXMzWTBla2dYazJFdG5ic2RDVTNqNm5k?=
 =?utf-8?B?SFk3RHR0OVBlMzZUQkZyMVJXY0RVMFU2UkdHaHRZRXQrMHZ3Rm50L0ptOS9i?=
 =?utf-8?B?V0dtZ0dMQzhYT0FEQUU0WjQzRVpnWmxQVlFNVVEvaEdPd2JyK0lPSmNpNnhq?=
 =?utf-8?B?ZmxZVS9oTE9jUEt2ZzYyTXpJVnNqaWttMFJhVVdVT0ZvUTZDRmlFc3Z6UUQ0?=
 =?utf-8?B?cjZqMlJuU1luWUJoSWszcEw4T1k2b3IxZmZCc1RFbldLaUJlTHF1aS9GSkxv?=
 =?utf-8?B?S3RrVnpaODhlZldsWDR4d29BUy9zajVzNGZsanhiN2NNbXliVUZGZzlkb2E0?=
 =?utf-8?B?bHN5ZFJQUjV2QmpTU1ltRWwrbjhuWjlEM2d6eTlSOW5sVzg1SC9ERWx3MlZ4?=
 =?utf-8?B?dkQzdzhBV0hKT1krYWFjaEZmcTJGYVJNZys4cFZoQ0FXUG9aeEhRdk5KTDBV?=
 =?utf-8?B?QjNRTS8xazV0bkJtSThTdDRJYzFxQ2V2ZHdsT0FGK1kwUHRVRFZvNUR1L2RJ?=
 =?utf-8?B?M3JQMnRrR1NaTU40SjhIMjhnVHRvT2pMSk9yQzJ4TktzNE1xeC80eisya2Jo?=
 =?utf-8?B?YUhYYVVnRmZPWXMrOGhMUmczT2xtc1dNVURuOFNCbEU0YXRCM1pQcEVFVUdm?=
 =?utf-8?B?N1NsWlEvbVNoclRZbmFFOHdLL3REcjZNb21XUFZoWFNkdFJObkZCWnZtUVJk?=
 =?utf-8?B?ZW9xQ0pLOEwwV2pOZWx6Vit0MFFsR1dZUXJaL2pkR3pSZG9tLzdTWVZIZmZQ?=
 =?utf-8?B?OW9PRTl1MWJESER1NUVzMU91TFZ4WXkzbHRoS09Fb21oTWhwekorZWhRRE40?=
 =?utf-8?B?VXFTWkVFMHhVNG1JZm8vNmpiT3I5NFk5Y1FDK0V3RXkxcVNndFdhRVJPYzNW?=
 =?utf-8?B?K3ovTGxkQmFnYXhlSHRXY0VVTVVGbUh1MnhaMG5seHVRM0tBMjJqTmxBTHJt?=
 =?utf-8?B?MHNPU2M4ekFwcFZRazNLTzBJZ3JSQjBIL3FJcmNSekhSTkthemFSUDNlYjdu?=
 =?utf-8?B?WVpQMDVZeUxZdEFCNkwyZmhjVzR0Q2N4cCt4TjhxNmtRSzZhTGEyNzBGeVNq?=
 =?utf-8?B?bklIY3N5Tm0vMEV0RU1aTzIyb2NDb3psbFpzVDBpU2RrV0xPQkpzNWJZQzUw?=
 =?utf-8?B?Z2trZTlYTUFxWitZQ0FKMnF2eWpnbk93WFRGOEpSUTlic2xoMTV4YWRQdU5i?=
 =?utf-8?B?VEU2R0ZpaWQ1QWN1dzlBVEpGMDJJR1RJYnhlVzNUUTBIdVVCTEt1Y2JNdnQy?=
 =?utf-8?B?ZDN5OVYvS3p6ckEvVjYxbE16V2hhazMrVHZSWHdHWlV0NS9kT3RYbmhrQlUy?=
 =?utf-8?B?TlpqTUNCV2lCNllGMHZWQzZoc0RIOGtUVXdFTnBCTFkrRXVtRlo4OVlBWTlx?=
 =?utf-8?B?clVLQXF1N1VzUXFuMVozc3c4RkRGZEc5MDVnUk1LU1lPMGRTVjI3enJOQnpy?=
 =?utf-8?B?TlRESlBuditabjIrZHowMzIxSENwLzZJQklUS280Z2hYYmx6WWtBVHd1TUNU?=
 =?utf-8?B?OWVEdW5qRWs2WWZ0dDNtYWlxdFVVcHQ0RmF5ZGxoWHFDZ2tXdXY2cFZyaXpy?=
 =?utf-8?B?YmMzZXgzT2dKZldoYkR3ZzRKVTYrb0ZCOERjbVh0UDdVSEJveE5SMVRxNnhB?=
 =?utf-8?Q?1yYJnZb2fLno+uW4IizPlcUhkiKJ2eyShfmuyKNIMz9J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 237e467f-57c6-4c02-c9fd-08dddb314901
X-MS-Exchange-CrossTenant-AuthSource: BE3P281MB5199.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:51:28.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4336ed25-a33e-4aab-92ed-3e7fae3bb2fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRGXXHeLXGXOPR+Zp0dPsslmwg08q845yqx1UfE/a4LUupR2Yii8MMbOBnVnCIP9tIZ5PY58jSSwABBPPcdHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPFC33F14332
X-OriginatorOrg: 1und1.de
X-Virus-Scanned: ClamAV@mvs-ha-bs


On 31.07.25 04:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 28 Jul 2025 11:06:47 +0300 you wrote:
>> netlink_attachskb() checks for the socket's read memory allocation
>> constraints. Firstly, it has:
>>
>>    rmem < READ_ONCE(sk->sk_rcvbuf)
>>
>> to check if the just increased rmem value fits into the socket's receive
>> buffer. If not, it proceeds and tries to wait for the memory under:
>>
>> [...]
> 
> Here is the summary with links:
>    - [net] netlink: avoid infinite retry looping in netlink_unicast()
>      https://git.kernel.org/netdev/net/c/759dfc7d04ba
> 
> You are awesome, thank you!

hello,
as far as I can tell this patch has not made it to the 6.1 stable tree yet in the 6.1.148 review yet:
https://www.spinics.net/lists/stable/msg866199.html

As this seems to be causing issues in distributions releasing 6.1.147 can this still be added to the next possible stable release?
See following issues in relation to loading audit rules which seems to trigger the fixed bug:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1111017
https://github.com/amazonlinux/amazon-linux-2023/issues/988

I have tested this patch solves the problem in the Debian bookworm using 6.1.x

cheers,
Julian Taylor

