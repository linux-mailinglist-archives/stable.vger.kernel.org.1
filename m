Return-Path: <stable+bounces-181478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DB8B95D96
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83E72E1619
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC62857D8;
	Tue, 23 Sep 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f5WTWL5d"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF48288530
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630815; cv=fail; b=Mgz8cT2+xx2JtF2vumGIFEVP1mkXLei4XWktQIEBN60nWdn0GukaAGK4czPolXuIHTzILFGqTCXg6cJZeAIxlml8UPNEFA7MK9jcGGAgcSAs3mm5W6GnuIF54YZUzPeN5aCXthqsMenZVWjPDrp3Oa01GE1Yxs5vvSH7BrWxbXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630815; c=relaxed/simple;
	bh=X3XfZ++Xjo/uMtmCN/j4JNMCF9b6vlOS1wsCBkgt6qg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1hRaPLty3V8p8qLBNis78bbvkTJblHI4Avn7tVfgj0UEUqK06IH1DzHII46/IlGe+CIB1pJ+C1nhS4Dr83DKKJqzR5k3SISNxo7bNzdwWMTJVwkdvp7fvc+yL4tg05EKXBGeBKkI3PQLY6rPUm57gDff3sBf3OtPwkuNEe9qzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f5WTWL5d; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC+LDNHg3rrYXtdRI/ZsSCQ6lOouKgyAbSaxsiZ5G1Hws2SQqVYU/ttKMbiG/5CA2LXfYm4sTWXL2mTUuHn48WxZ/wKbMgxH5lmPD4NgOM7vl/ENFOFBpO7O0xWrSsiKAYWxXeBHORqdlqnoTVKVjyz2R4P4NdeR2nAUicHTclNormc+Hu9PYMaNw4d+XEwL7cLIjAST/HBvZ2lCYwUYqftebwuPeTZRHnPd7Jg+QTFJSil/i+Lj5aHNhPoNx7zk9MPJMUjpRcBCdCkZpGlIqbZ0506na4vZkvKBglT9r4kQhk1fEBqEKaC5fe9gtTMazUYNWty8k2/JUlqtVzLjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0xVKeMykjMmOem4uKxt/5gDRpPhWu9tCU0BPPXfDdM=;
 b=lYY368fIvMoe7I0oE4ajZko2hj99vNLaqcd+UgwBToeY/254cqnKNWSCufvHuj5O7Fwt/Ste97ikTu+P1k7T8dZmozljwJlbS3cnFJOHnq4KOxJvOeLEf9WMQwXwY6au2JJl0InIcFgWeZT/68EZ8geoYeSQv/L6qME/idaaafMQnHMPHvyyB8+xA+EbyOUmi9yWi/X4ZoTo1aJ+RaNaicFIJdlqY+I1oA+AO8PyJcgZdbRo2ulY4xqs+nykPPbRyZPxLZ2DeEBKDL1nw0jQRQ2+HLt0i70TTDPUFNhcuNC0l1gVwgJRzUIIkesiCh9fXBnxvXZVvfflUMu4y//eMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0xVKeMykjMmOem4uKxt/5gDRpPhWu9tCU0BPPXfDdM=;
 b=f5WTWL5dkONCrJfO/Z/OWs9LfUnHgIMAbUr5SEPeteuyk7LoGjybV6eB57lV8sLBVvwnX08ci4VNElxdz6Xxz5feddzZHeH5zzY2dfCed6X7GN0KqY3GeaBt7lOeOLtqPXHEFezBewKa1CtdBK6vOn46nNqqBMzZZiQ07n349Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 12:33:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 12:33:29 +0000
Message-ID: <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>
Date: Tue, 23 Sep 2025 14:33:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
To: Philipp Stanner <pstanner@redhat.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
 <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
 <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0430.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4c67df-229c-4889-4bb0-08ddfa9d662f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTBuQkFaL041SWNIVEE4V0diRmh2REEwWXlZZExSa3dCMXF6bnE0M1AzQXU4?=
 =?utf-8?B?YUZadEJJQlZBbi9GeWtNcFk3Mmh4bUh4VEJZdyszS2hQK1pocnJTSUtpNHho?=
 =?utf-8?B?NjR1V0xkYVBCUmduZ01kN0NNWkpHZEI2ZGVBWjB0WFJDcHRPTkMzSUNwNnBu?=
 =?utf-8?B?WVM1ZnQxdHZIU2t3elZBZGo3VXNXcGhpelFZdFp1R1JrTE9GVDVmNFFJR05h?=
 =?utf-8?B?UGJ5dWd0clRPN1dsbFphS0s2MzZnbEo4ditCb0xzMVEwc1ZIVG4rNlhGZ2F0?=
 =?utf-8?B?MzVLdWJmVmNpbnRDUFc0elFWYTlHMzd1UnJ5ampuR1N1ZVE3S21laWlHb2Yv?=
 =?utf-8?B?OTNRU1ZSbEMrYk10U3V2cFZxQ0kvS04zK1Y5aTVYdTFxOThLU0xjZW1wVTAv?=
 =?utf-8?B?SVoyUXBpbXB6N3F0UnRhdUxNRDZBaWMzSnVYNmg0clArZlVOOU5pUWxNd2Ru?=
 =?utf-8?B?THVYTW8wQXNULzlHcXVla0NmYUluS1JhQ0FLMkYvRE00UFhkcWJUVUlxMHdm?=
 =?utf-8?B?MDV4ZllLcFhicUlzOXVJbko3azg0ZUNOd0NmRzhobitiaVBSazZLbEwzUDNZ?=
 =?utf-8?B?ajl1a1ljU0NtMHRSMFZlSTFMM1p6S0NvTVdNMngvbk1adUlIeHV3bGZCN1Np?=
 =?utf-8?B?RllRZHdHNHcyMlhEZkpOaWREbjZwdzFOeUFPTkg3Vm82ZzVOTWRacUNUcVJ5?=
 =?utf-8?B?eXhhWmVtMWc1VnpndEFldDRBdk5SYUMrRU9JMTVUeXhPczNaZHp2Ky94bFQ4?=
 =?utf-8?B?aGl1TGNDbnNjQTZUbE40bnBBd202RTA2UnZ3S1VIZ0l1dUwwN1VLaW1GZ2ZD?=
 =?utf-8?B?OGY1Mk5QdnNtTnZ3UTQ3RSt3T3JJcUVadVBKK2IvS2JqMlVTL1BIQzN3bDQv?=
 =?utf-8?B?N1JWckVFMzV3T3FsaXNOeXhlcVdLdWl6SmF0ZzRsWW5tTkRsSDhIdTgxUlNt?=
 =?utf-8?B?NGlocFQ5akMxemZIc1ZXK0ZUZ25UYS94bmswSXVoRWI0bG56TFFWYkVLMWVU?=
 =?utf-8?B?STJDQ0JmTFppMTlycmtMV1gyNVpyWDRRcDRFMG1Ea0NoUXVRaCtDQXB0dVNU?=
 =?utf-8?B?UlpRRTRId0NmMWJpSldtdjlzbzhRNU1Ea0tzQWVYMGZXOVkwdjRsTUYzMDNM?=
 =?utf-8?B?d1p5OS9sWWVKQVN6a21ycDRGSHFScGNrYXlzMkFrSWtFV244d3RLY29ONWIy?=
 =?utf-8?B?VkNHeURPSkI1eDdDMjVUMjZHbHBMK1l5bCtSMkdnMzJiODhQbkxOZXdjb0lo?=
 =?utf-8?B?cTJsOUN6VG9zRFJqSWhZWDNXRXhUeXJ1cjd4bjVENlBVSnp6S2VUK3VZL0RE?=
 =?utf-8?B?SlZ3amROUHRHSHoxL3Bldk4wWGhlbEU2RGUvby9HVTVLNFJkSG9MZzVVSDl0?=
 =?utf-8?B?OXpMQWRhNGtxQlhoeW0va3FJTHNEdHVyeDZLVTJlNTZhd3l4WE4rOHlIYTFR?=
 =?utf-8?B?Q3lVZ2pGeDNSU0lWTElQUmY5WVR1Ulp0c3FCVE9rRk1zMk5Na0NWMTcxbGxT?=
 =?utf-8?B?Vi9mbUp6K3RqTmF2a0MyRzE1QWFCQThhMWI5VW5vdHBUNy9adEwxbVJqQjBq?=
 =?utf-8?B?b2lMbHJjczBvSlFYQjFVRVV2TW1lb3BwZzBqQzlMK3V1RDVkb1IxMWRQZGtD?=
 =?utf-8?B?aHh3K0drL0Nhbk1WejEzc0N5Ri8xTDl0eEJhcjlWd0RyV1ZZalhjNVdWaFlZ?=
 =?utf-8?B?NFVLQ2ZFQnp4NFRhMUltSGRON05ENHBpZkxMRFVlY1JWVzJiZ0FSTWFPS3E3?=
 =?utf-8?B?SngvRTB6RDU5SmFzeE5ScW05emVnK2NtOUZmVjRPTnJSMFd5TEdTbTdMaXdv?=
 =?utf-8?Q?LlfXLyKMEentiEacl288KRhgnNT+yYy9umBi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnExU1lMYUUrdzM1OWhrR2E3R01DQWhJOTE3U2dqQmpiQ3VpRzlMMWdoNG5V?=
 =?utf-8?B?OXI5bU9hVzVzMXVGK2xvMVUvNzVXdHpJYjNraFRYdTlzc3lrMDdsa3Q2TENk?=
 =?utf-8?B?aFFqYnJDbi9tc1NHaGhkWHJBdEdSYWxLVkdENGxSTTRzemlkNkdTcEZpb1F1?=
 =?utf-8?B?VGlsWnBqSzBHeXhCcUpCbDlGVFUyMTM1c0F0aFVWRUtUZVhDcU1pRk0yd0pa?=
 =?utf-8?B?SnQxamlpMDQ3VmNrL3JQTWtSNFhxaW1wR2NYUjFJRWxtRUNTOXlBU2xYVnh6?=
 =?utf-8?B?RTB5TG5GcDhLT1lpM2JhQk5GV2hJVEU0UjZLSXdlQSsxUFJtMnBGNjY1OTMr?=
 =?utf-8?B?TGdqTjZvaTcxQXVTVDRkSzU0MGMrNVUrcjNac1ZjZkNIV3JYaGVkVG84SVhM?=
 =?utf-8?B?Nm9VNE40c21ZcUpCdENiQ3VmNlRxd0JEbTFsdjNDMFdCc0VNWDcwbmpEc3g1?=
 =?utf-8?B?YzNBbGhWbC9ka3czYTJGNnYxNlA5OXNnTWtQYjlOUzk1UU4wUjBQVFlVR3Fo?=
 =?utf-8?B?ZUFrS2k1WWVhdTFLMGpKMHo1TVNsUjIwaUdGZkdEclZHaU4yb0pNYUFxWW1G?=
 =?utf-8?B?TUhMdHREZ3FRQzF2QVZTM0FLRElYTmxLN0hSRmlnbS81S3NKaXBnM3duOXlv?=
 =?utf-8?B?WCtzbXpXRnRlVkhNTXBsazVIS0VJUXVIVFU2Q05qRzRLcDFhUU1NSXdvWEpO?=
 =?utf-8?B?cDQ2SjRROXpMNGpNRVEvalhxYXlLczQ1VHhqdFZCM0JJTkIrTXJNcXdza1l1?=
 =?utf-8?B?RFcvLzZIMk5hSVZCeW9Jb21CMVRFNE5pYzBZZUQ4TklsWkdsMFpLZStPZkRS?=
 =?utf-8?B?UFNZaHBTVDV4cElkcXJLam5EYjQvYTJvbmNsa3lycTdGNm81elNNVEJBQkxs?=
 =?utf-8?B?dCtueG9lR1VwZzN1UDl6WXBpZTlUU2EwdTZCMjNNM3U1N3pDNHBEQm9WN1Nz?=
 =?utf-8?B?TEhZRG9xZ3dUZmRKU2V0aG9wOUpKSFJGOWNwMnVJbzlOeWJQay9SK1lydk0v?=
 =?utf-8?B?T012U3E0N1VxOGErWUxWUFl5RldXOE5CZTRKN3R2M1NySDYzbnN6cWNqUTBE?=
 =?utf-8?B?cWEyZmFCeDh0Ui9DZjFmc1I3S2JHMVFaNXl6b3Y4NWg3SEUwRXUxdUhQa1c1?=
 =?utf-8?B?T3MyWU94elUrc3o3UHJneWhRd0ZrS3VWYkR2WUdwVTdVT0lmSktPcWhSMzBK?=
 =?utf-8?B?ZnFTYURlWFA5M2R6QyttZjZ4ZGZDQnl4VlBvakpjeEJ2ZFcxcEpuSTJaMWdQ?=
 =?utf-8?B?ZUlPNEVocm5RY3FUb0dna09OZDV2Q1gvc2h4YWwwbzBsVkUvMmEwakZLQTdk?=
 =?utf-8?B?ZHZ2RUFDQTFyMTJDU0RDdlBWTjRpT3E3Z1NPUTRsbXBURFozTnFJdTZZakN3?=
 =?utf-8?B?WXczUlNEYzlRdEZOS01pUUVDODl2RWpFUkJjZlF5MFdLMXNjL0xmQ0J1YTla?=
 =?utf-8?B?TFdVUm1GOXhid3NwbzR4Z3R2cHpwSmNZa2JKOXZqMUxLMGFpVHlaNjE2b2o0?=
 =?utf-8?B?NDNOOFpHVzBSaUdkNWt3Z0JpaXZDbTg3QTZ2WC9KcTlyMDlFSTB0bUttcnRX?=
 =?utf-8?B?ajRmS3JQU1NxbFZlNEliSk9DbXF6SnYxN25ESW43TEg2aUwwTE9tQUhLeW9o?=
 =?utf-8?B?VnJFOFdKUXNzd3U2bmY2bldHSSswUVNzYmxydkl6Qk4wamRJTGdsSlAyVjhS?=
 =?utf-8?B?K1ZtOFdrS2VpbjArQTlPeVNVOEVWZG5PSmhFeTdQbjQvUjJoVHJLKzlRNWg3?=
 =?utf-8?B?SjlJdzRDemtqY3VHblVxV3VlaWdnVHdBTzR2dzNFRlFXRXFwUG94WTd6VFBK?=
 =?utf-8?B?blBQa201Q1gzYTl0ajRwOGJ1d3dST3krM012dExwZUdWQlBKZzQ4bGZYbm1S?=
 =?utf-8?B?NUlmUVNybnVMdnNsNk1TZnhQK1BFUmlhWENYMUMySkRhblFQM2wzeWRqaVcx?=
 =?utf-8?B?MUNKdDE0eTFXZDZRV1BHWmNxM3k1R3JUa1hmRTR6V0ZnK05uaTh5STlOcWx0?=
 =?utf-8?B?YThlemNVUnFsSzVWeUdKRW9aY0l6NlJVcCt3V2t0SzR5Zm1GWmFDLzRTMmRn?=
 =?utf-8?B?UXhMR2lnRVB6d2JNT0tPcldFQmpTc1hQaEpUWUtlVDBZRnAxSDZXMGZuZmkx?=
 =?utf-8?Q?stZ8NGgI7Q5nwzJkJjms6MnZz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c67df-229c-4889-4bb0-08ddfa9d662f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 12:33:28.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBTyCBiciAM54l9CczTQhsXwa4inGAyS6ByuLqaJei6BcSP0haVwBx7iBU42hJSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

On 23.09.25 14:08, Philipp Stanner wrote:
> On Mon, 2025-09-22 at 22:50 +0200, Jules Maselbas wrote:
>> On Mon Sep 22, 2025 at 7:39 PM CEST, Christian König wrote:
>>> On 22.09.25 17:30, Philipp Stanner wrote:
>>>> On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>
>>>>> commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
>>>>>
>>>>> In FIFO mode (which is the default), both drm_sched_entity_push_job() and
>>>>> drm_sched_rq_update_fifo(), where the latter calls the former, are
>>>>> currently taking and releasing the same entity->rq_lock.
>>>>>
>>>>> We can avoid that design inelegance, and also have a miniscule
>>>>> efficiency improvement on the submit from idle path, by introducing a new
>>>>> drm_sched_rq_update_fifo_locked() helper and pulling up the lock taking to
>>>>> its callers.
>>>>>
>>>>> v2:
>>>>>  * Remove drm_sched_rq_update_fifo() altogether. (Christian)
>>>>>
>>>>> v3:
>>>>>  * Improved commit message. (Philipp)
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Luben Tuikov <ltuikov89@gmail.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Philipp Stanner <pstanner@redhat.com>
>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>>>>> Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-2-tursulin@igalia.com
>>>>> (cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3)
>>>>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
>>>>
>>>> Am I interpreting this mail correctly: you want to get this patch into
>>>> stable?
>>>>
>>>> Why? It doesn't fix a bug.
>>>
>>> Patch #3 in this series depends on the other two, but I agree that isn't a good idea.
>> Yes patch #3 fixes a freeze in amdgpu
>>
>>> We should just adjust patch #3 to apply on the older kernel as well instead of backporting patches #1 and #2.
>> I initially modified patch #3 to use .rq_lock instead of .lock, but i didn't felt very confident with this modification.
>> Should i sent a new version with a modified patch #3 ?
>> If so, how the change should be reflected in the commit message ?
>> (I initially ask #kernelnewbies but ended pulling the two other patches)
> 
> You know folks, situations like that are why we want to strongly
> discourage accessing another API's struct members directly. There is no
> API contract for them.
>
> And a proper API function rarely changes its interface, and if it does,
> it's easy to find for the contributor where drivers need to be
> adjusted. If we were all following that rule, you wouldn't even have to
> bother with patches #1 and #2.
> 
> That said, I see two proper solutions for your problem:
> 
>    A. amdgpu is the one stopping the entities anyways, isn't it? It
>       knows which entities it has killed. So that information could be
>       stored in struct amdgpu_vm.

No, it's the scheduler which decides when entities are stopped.

Otherwise we would need to re-invent the flush logic for every driver again.

>    B. Add an API: drm_sched_entity_is_stopped(). There's also
>       drm_sched_entity_is_idle(), but I guess that won't serve your
>       purpose?

drm_sched_entity_is_stopped() should do it. drm_sched_entity_is_idle() is something different and should potentially even not be exported to drivers in the first place.

> And btw, as we're at it:
> @Christian: Danilo and I recently asked about whether entities can
> still outlive their scheduler in amdgpu?

That should have been fixed by now. This happened only on hot-unplug and that was re-designed quite a bit.

> That seems to be the reason why that race-"fix" in drm_sched_fini() was
> added, which is the only other place that can mark an entity as
> stopped, except for the proper place: drm_sched_entity_kill().

That is potentially still good to have.

Regards,
Christian.

> 
> 
> P.
> 
>>
>> Best,
>> Jules
>>
> 


