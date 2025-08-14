Return-Path: <stable+bounces-169568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C572AB2694C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46751CE7764
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462621DD9AC;
	Thu, 14 Aug 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b="qOliiFpc"
X-Original-To: stable@vger.kernel.org
Received: from moint.1and1.com (moint.1and1.com [212.227.17.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E11321422;
	Thu, 14 Aug 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=212.227.17.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181098; cv=fail; b=J+3G84TP9S3/y+Sobfzcp+OWfAxylocQjPSPz8rXZPjO0QNqoDp1ezKrkcPKkTMikpv7zElJR27DFV+BQu5O9B+8t3/dorLVSXQ0F1BAY7PQq6JWItyXWfF2FDsy+5zlEgbsiOlxEmH8XNJuVCErMplAWujXXQLtK7ZPUJs98zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181098; c=relaxed/simple;
	bh=tRFisZnJKwRN3iNOf+cfFrO3HoI0x/Zi8MfICuH5lEk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQC7+Dkk+recGJCk7KwGfzKZEsr8wnxvH+OcsqkNbi1ZpNryML0vzoiimn8IepDj+ZC1b7XUl80ENRsnGtj+wdA/MBqOl/q3kZK06IFE+l0KxpGnw5py/nHqmbKLaWgRvKh+qvVvjXtseqKoF81GXxQ5vuDIDX0Ksq1r2rVyzrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de; spf=pass smtp.mailfrom=1und1.de; dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b=qOliiFpc; arc=fail smtp.client-ip=212.227.17.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1und1.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=1und1.de;
	s=corp1; h=MIME-Version:From:CC:To:Subject:Date:Message-ID:sender:reply-to;
	bh=Kn21SlJcFyabc82pvPOColwiFXvE+N7P6PeonvC7NfM=; b=qOliiFpcxHbH8oiwoLVXLFzzcV
	M+rgKAETjrkMO3XN3Ks1wfLwuw8paEwO5CUk06a3LXeO46WOs5maoa2j4qVENRDA3Avh/jAM0QHxZ
	+xv6uA5JzgbZSAd1pOpz3eMSCjkWORp10vszM6pLXvs2oo35KOfnC0eMsfJ8s9EMi1g0kB0Gq0CzE
	8g6XvOmBy0J8hs4sSvz0/iSKaj/cT2X8NUuX7nkjUGMOwa6s93FGNlSxqJFkJ/HFoAi77REuHKTeT
	f7w/GtED3Vq99THIQGfpevLUmhhLDM/yL9KumG28w8umFNYbH5hxjM9VLtgAH/46vo7XBnkn3IXAH
	aVLTUVuA==;
Received: from [10.98.29.10] (helo=BAPPEX025.united.domain)
	by mrint.1and1.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <julian.taylor@1und1.de>)
	id 1umYj6-00HNK0-0U;
	Thu, 14 Aug 2025 16:14:44 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSeDLPfySYlt2XZxib5J56G5AjcH15VcayxVByuKRTd4ABDWulCBherBgXLSY1/V3sGE2zQdRHWqzeRljv2QoVoBxDthNM/ztpRLVxykjoKMNEhMNWEKydkbQGrZmq58jJ0kgjmuYccFWXIXXrZ45sbuHoWyigawWKiAvzNS7UBfZGlQEUK5NAvsbODS7BBhtiS9SRFVCIcM3EZvxxjY3QOmtwR5yVQWwwuiYQhmjncGIl6th45CW2/xCwU9mvDQOIxZ6t9hSkj5RzmGdKfyfHnxDD+J/cXQwh9uDHpTjr2ITWavItv8C65cAFZTAQSzoubJo9B/4zSchNuN5D1l3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn21SlJcFyabc82pvPOColwiFXvE+N7P6PeonvC7NfM=;
 b=iwvkKu0y8fhnVNMLH8meeyW2fDlAhczkasrLY5rosCNMc0+6UkGhURwQRWnD9kt7koCXq0dPJJ8TThl62tdwlDuAFI6sQwrXKaYFqEF5Sc+NvswsFs68eon3iMcQ6Jt1Qv5u9m2TEvcCu6pwW1wdHrTS+zD7HX3oaYBQBKEkrAoTMy0CYs+0hUpS/TIVch5qhqG4pE31OdLXbG2RgnfKIMiCeljlEMpX9QSX1+753/o6c4rNnnRtP17XuU96LQpsqrKj/PjONsLJHMUVkJHURjWtKI5rFk6eYuqiyCgdAan2Z3Pv8ID1v41XD5irKdriWwcdVzw9GkkOt7rj1hzXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1und1.de; dmarc=pass action=none header.from=1und1.de;
 dkim=pass header.d=1und1.de; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1und1.de;
Message-ID: <2ebf39be-aa26-4863-931b-a32fde9de182@1und1.de>
Date: Thu, 14 Aug 2025 16:14:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: avoid infinite retry looping in
 netlink_unicast()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <patchwork-bot+netdevbpf@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kuniyu@google.com>, <edumazet@google.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
References: <20250728080727.255138-1-pchelkin@ispras.ru>
 <175392900576.2584771.4406793154439387342.git-patchwork-notify@kernel.org>
 <9fa0c0ea-9c5d-4039-856f-222486283a3c@1und1.de>
 <2025081422-monetize-ferocity-fe28@gregkh>
Content-Language: en-US
From: Julian Taylor <julian.taylor@1und1.de>
Autocrypt: addr=julian.taylor@1und1.de; keydata=
 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
 7oKCuVqh8kE3PYxoRHbuOnFcKDL7dV8w3Mak
In-Reply-To: <2025081422-monetize-ferocity-fe28@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To BE3P281MB5199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:cd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE3P281MB5199:EE_|BEZP281MB3207:EE_
X-MS-Office365-Filtering-Correlation-Id: a0633576-09c3-414b-e1eb-08dddb3ce8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk52MVROY0VNUFVBZDFibTl0QXl1RHVqTE1lTXNSck1QS3dzY0I5c1IzbEd2?=
 =?utf-8?B?V0xhcUF3VXI3WmxCVUZPb2JkZW1uSGFmb0NSa29XTzdDZ041V1VmS2VNK1pq?=
 =?utf-8?B?QnBtZDFFNjNESExRNkRxV1hGQ2gwOHNqc2h1d1daWFYxbis3SVJRcGNPeUk4?=
 =?utf-8?B?RG1WRlU3cXNGMzU0S2VEcitrVXJyeFBmRGttSVU1Y1I2K0tSZW5seUdJSkpk?=
 =?utf-8?B?bzYzSG43UUJ5ZkZPd0pmd0xEaWpobHFHRDhWN0l2dUtCTUNFWmx0QVZ4bVBw?=
 =?utf-8?B?ZHoydmw5bEk3NXhnK2lmSExML2YzdVhlOEhCTCtpY0VMeXY1aGNxQ295Wk1Q?=
 =?utf-8?B?RCtrRjZVSmRHajBHMzJSVkd5ZzM0bGtJMldVcHRxU0EzZ05kbXI3TWh0cjls?=
 =?utf-8?B?aWhPM2hkazF2cDVNY0dST2crRkkvODZpT2QwN0VVQ203eUJGSlRmL1JBYVQy?=
 =?utf-8?B?VjF2bGhxOTV5b1NNTC9pWVpqYWdwOXlkdlBsbU92ek1oSExMQW9SSkxJSUtr?=
 =?utf-8?B?SnhzL2c2US9Zc3ZjNmUzN0FNVnhMTUhiL0VoSFVHOXYwNTlPbmIvZDM2Zm95?=
 =?utf-8?B?akRBbmovSnNZOVdqUVR0UjN0MUhpRGQ3MnBxd0tNS09DbUdGOUx3cFJaZm9W?=
 =?utf-8?B?SUxBMWdOZ2ZudDRtbWRITklKcTZTeUFoTkpweDVuMmpoUmVyTFJjRTIyYXVu?=
 =?utf-8?B?b3hhMlVVWGVNRDRQVlJWZjRmSTBaMVNHbDJaR29MTGNXLzEzY0ErT1A3MzlB?=
 =?utf-8?B?a0FiRGViMDJFNUU1YWJaYm5nV2JvUGQyeTVaK1REblQyYlVRR1F6TkVMMWM5?=
 =?utf-8?B?YkVoalBPZExnOGF3bnFLWGFiNEZaaVhaK1lydjc5WVl5M0o1bnBMbXRIRmVT?=
 =?utf-8?B?WC9QcWJERm5MUzBNc3NyWnU4NWVGanZldGRRRDNzWmFYR21FOXkzOW9YVHhS?=
 =?utf-8?B?YmtxcGVhbVcyakFzUnBDQWpNalFZU2NKbGxwT1BJRGtLNUkxTXJETWZwMkpj?=
 =?utf-8?B?clhHak1BcFRmUkFnSFZsL085cWFDb1BzMS9IakM2OHo2blFwWHZ3MUZWaWVC?=
 =?utf-8?B?YTBqMUVJNGZqQjJxckl6a0xmUDBZOXJCUm1YZUMwZ1hOeVhmdlpLTmFiR1ZN?=
 =?utf-8?B?TEpzMVIrMWhrdnV5ajBhekNjMXgrMkU0K0k5emVDVXh0b1ZodjF1K3BhZGkx?=
 =?utf-8?B?b3drNUZSSjV4ekRsTTM5RE9RYjlOTEVHOHdYemlnSUt0N3ZMU0ppNnpqYThQ?=
 =?utf-8?B?dTljcHNKZlNwQnZZV2t6VktleVpqTVhlZGIzOGp4SVB6dGNKM0pSeEhaL08r?=
 =?utf-8?B?Zm13bU56bTdmbUczaFc5WmFMeXNLai9rdFlvbXY3RFlxK0pFOEMvODc0WWQ4?=
 =?utf-8?B?ZkI5MEZoclgvbFBaUVdibUE1ejRhWEx6SXc5YXlZd0pEd2k2SnhpT1kvaXNz?=
 =?utf-8?B?Rm1BcjNLbGxKNXNxZjFiUVdPbWF1UzNuOFlMUjJ3MElON2l4RXlsK1R3Zzg5?=
 =?utf-8?B?b1RBYkdjOE1QQS91eVVhTHlXVUdLaTBlQVJzVVJKZmdrQTlTNkRtYk9UK1hD?=
 =?utf-8?B?QXBKUE5TSFRKNTR3UXR1cWx2RDg0c2RDK3pvSW96RTdoTDB2Z1h5eE1SKzl1?=
 =?utf-8?B?eVdHc245NmJSV3NnZzBoNmlRVUVmSGtjTTNFM3pCOG9XdElRRFJrVzhVN21l?=
 =?utf-8?B?SHpMTVkxL1JkUjJMWmdRNVJmYm5jdDduQ2VmOTl2OHg3RUJhcUZvNzB2QVhy?=
 =?utf-8?B?SXlzbmg2bGtiSGljSGtadGJzam52aFVwMmpxMktZWmZuOFRpL1FNdk9tRU9L?=
 =?utf-8?Q?CtXH9lXSGQ5FnJzqTMGkFChN5g9rKxJXetR6M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5199.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emh5V2N4OEZ3RXdGMGo0c21ZVTdUd0ZZbVM5YkJXaG1OaVFSNkxCUFY3R3Ft?=
 =?utf-8?B?ZWpDcTJReEpaTlJCaWRsT2dNbXBqL2lOc1BISndNYW8yOXVUR1hSRDJOUm9O?=
 =?utf-8?B?L3JHd3JRWEVtQ1dUM0YvVmJsL1h2emNXcGR3VmtOZVFjU1JBTndtMjBJZkxH?=
 =?utf-8?B?Wi96M1ZTSEtaMzNwaFZvSDNUb0cyT1cyL29VUnNBYWtJUkthSktDREY5YTl5?=
 =?utf-8?B?MG9DakdsZzV2aGJqb01pUU5QTTdaeGcrZTZMOFFDNkMyRXlHSFFQYnhoTnli?=
 =?utf-8?B?RzN1ZWpEZkduMEVRcHloWUVHQ0hRTExwY0dXS1VPQjBsazZvdG50bE1CZHBn?=
 =?utf-8?B?dURlREliak5ZVUlBOXBWS3pXczBkYnJvY21EZklhRjI0QzJDSWYzNjk3cXNJ?=
 =?utf-8?B?MDI1Q1R0ZktxTkVzY0V4K1ZQcHpGNGxKSE1FTlFoaXR1MTRIRkZpOWxUNVky?=
 =?utf-8?B?bVd2MTlGdmNwRGRXUDJtUlV1UkhjamtRa3QxaVVwbGN5ditXa0ZTeU1PcUlC?=
 =?utf-8?B?SG1pb0cyR2JoaGNCaWdmdTNCNkpuZXZzUVZGQ2FBNkJQSXpIck5uWmx3bG5D?=
 =?utf-8?B?aVRrcmZ1RmhWb01tUVZKdWZ0d0E2d2lqWkNMUitEVTh5SWRwVTJmNHdteSt6?=
 =?utf-8?B?VEMySzcyaVJrU2dJaGxrMXphbFluREFtaElSU1JSRG5mc25MTkRWWFBiVmNa?=
 =?utf-8?B?SVZhS09GdExoQXEwb3Jxd1J3ZzNIcHhEZEVnZ3BxdFdFR09XTmRqbmY1OVlh?=
 =?utf-8?B?VGtWeGxiYnBURldXanRPRmlNdjlOYjU4bEx0bnhjSXVnak53UDJ1NCtjdGhG?=
 =?utf-8?B?N1NQby9nKzdCWEYzQ3UySkRDUEgvTG1ieGpWSlh5bUd5L2RBR1dKUXMyckRK?=
 =?utf-8?B?TGxpdmpzajF5TTV1ajRZNGtUbVlwUVoyanJRbUVSRjBKM2RibTkxSjFkNWFn?=
 =?utf-8?B?NmtZS1JxcVI3THRJN09LNmVrYmxVbE0wbVFzemtoMGlKcng2OXEvOS84Q3Yr?=
 =?utf-8?B?Z1hhSGpQWGRvVHdsR3BHbkM2TGVmZUVqZS8zb0NIcno5WjdvTWVreXVQQU5a?=
 =?utf-8?B?aXJuM1lJZ3M1Yjlqd0psc0x6SUxDUEI0NEI5RmkyTmlVZE0wVGhqZDBBRVk2?=
 =?utf-8?B?cEU1dWZKOHczL0hxVkNScmxzbWdzV2FPT3RMM3FCUHR0Wkt4bGlYclpEUmZ2?=
 =?utf-8?B?ZG5RTWcxQUJkRFhpRCtVTkEzNGRGQ0h1YTRSckRQWDRuYld0eURXbHhKc2U0?=
 =?utf-8?B?RkZhaHJSbVUxRDVXbVU4OGF6VStMVldKaXJReVZ1YWdZS2tyM3JBTE1wQmVT?=
 =?utf-8?B?K3ZBOHYwQlp0Y2R2Rlc1Q2lEMXJJaVBKMGxOSGdndDB0L3JhT2ZTckRQRnJM?=
 =?utf-8?B?ZG5kZVhORHAxWmRHcTBIcEtibjhnMFg5YUxjY3lHZkVWbzFVR1hodzdZRmVH?=
 =?utf-8?B?M0lIdUFubjdJcE0vdzNVSU0vTDJ4Nk05akZ5SXJraTNzL0hrYXh4Vnh0UEZQ?=
 =?utf-8?B?dVE1MzdoU2hZQXlYV2Q1Tk1Tcm1EVWovejlKbElRL3gwb1p1NkhmOFlvOEt6?=
 =?utf-8?B?bnI5UzJxT0JyQ3p5blJmdzhlRlY1YnduNnlHdUNvelZ0ay96MFdJbHFwalU0?=
 =?utf-8?B?NHNEZURaamtuL1h5ek1mczVKd29EUWMyOGQ0L1MrN3U1ZCtMbStBQ3lzY0I3?=
 =?utf-8?B?V3prdE8zZjJQRlMzdThwT2N6bHhJb3RuVEZTUjBvcEJBUnVsODdTa3Ixd2ZW?=
 =?utf-8?B?cC9YMXpVMWs2UjZlYldoTk5VVFI5Vk1OZDVuWXVIK3o2cEFSODZYSWpIMjM1?=
 =?utf-8?B?enozdSszVTNrYVlXdEtmU0Y5dUhpSkhDa3VNQmxsNXFCWXVEU1FBbnFMaWJO?=
 =?utf-8?B?OTQvNlJjbXIvUTFSSmVWVVkrUTRmVG4xSE0wN1pWZm0weEhvNGdEZUtSY2o2?=
 =?utf-8?B?Zm1aL2NZSFl3Mms1ZTFKdXhrcHVadjVuOEtibXFNMTZFWkJtaGFHajJablZi?=
 =?utf-8?B?OU51VzhMcVFlc3ZueWc2WGpRT0VDbW5HMi9mS0hrNExqY2JPS21YMFA5YWRG?=
 =?utf-8?B?UzVCdmtJZGh6K1RZK3EzMlcwWTQreXoyR2VIWEhRVzg0NUJObmF4VU5zUWxP?=
 =?utf-8?B?TDU5a25qTHR5WGVmSUxQdk96aU5xUzZkMUxmRnFHOUZyelg2MHhWb21rL1NF?=
 =?utf-8?Q?D51ene7PGcEsfbqggvug57eHI8fnQlXI3f06i8ihkkrQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0633576-09c3-414b-e1eb-08dddb3ce8e2
X-MS-Exchange-CrossTenant-AuthSource: BE3P281MB5199.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:14:40.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4336ed25-a33e-4aab-92ed-3e7fae3bb2fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QusTo28eKZxQDNgHlzwvEIMzvfEi/mJ03vzf08tfFNqmxwcT9mY54dywgiFafT37hQ6NPgcqwEQ6a9zjsbMYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3207
X-OriginatorOrg: 1und1.de
X-Virus-Scanned: ClamAV@mvs-ha-bs



On 14.08.25 15:57, Greg KH wrote:
> On Thu, Aug 14, 2025 at 02:51:27PM +0200, Julian Taylor wrote:
>>
>> On 31.07.25 04:30, patchwork-bot+netdevbpf@kernel.org wrote:
>>> Hello:
>>>
>>> This patch was applied to netdev/net.git (main)
>>> by Jakub Kicinski <kuba@kernel.org>:
>>>
>>> On Mon, 28 Jul 2025 11:06:47 +0300 you wrote:
>>>> netlink_attachskb() checks for the socket's read memory allocation
>>>> constraints. Firstly, it has:
>>>>
>>>>     rmem < READ_ONCE(sk->sk_rcvbuf)
>>>>
>>>> to check if the just increased rmem value fits into the socket's receive
>>>> buffer. If not, it proceeds and tries to wait for the memory under:
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>     - [net] netlink: avoid infinite retry looping in netlink_unicast()
>>>       https://git.kernel.org/netdev/net/c/759dfc7d04ba
>>>
>>> You are awesome, thank you!
>>
>> hello,
>> as far as I can tell this patch has not made it to the 6.1 stable tree yet in the 6.1.148 review yet:
>> https://www.spinics.net/lists/stable/msg866199.html
> 
> Please use lore.kernel.org links.
> 
>> As this seems to be causing issues in distributions releasing 6.1.147 can this still be added to the next possible stable release?
>> See following issues in relation to loading audit rules which seems to trigger the fixed bug:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1111017
>> https://github.com/amazonlinux/amazon-linux-2023/issues/988
>>
>> I have tested this patch solves the problem in the Debian bookworm using 6.1.x
> 
> What is the git commit id of this patch in Linus's tree?
> 


The commit id is 759dfc7d04bab1b0b86113f1164dc1fec192b859
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=759dfc7d04bab1b0b86113f1164dc1fec192b859

