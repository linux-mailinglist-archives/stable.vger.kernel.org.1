Return-Path: <stable+bounces-192269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A845C2DB8B
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 19:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB74E2246
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA2313E0F;
	Mon,  3 Nov 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cAi6XVi+"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020141.outbound.protection.outlook.com [52.101.56.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF9272801;
	Mon,  3 Nov 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195555; cv=fail; b=Vco1XVEO21Xc/B/1R8SyQmPKRrbmxmxqW5Oo2K0tEugLd2tukrrjYc8dl+koLpGA+rynm9/xpWSkqmm1U9MSgdbYB1UuE7c0SfQyd8BssxHT4ZFgMlZEY1arImw6Ed2SncxXuwnr/r0kGBdDOWL3e73AtCTz6I0RxIHcR4F0Nfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195555; c=relaxed/simple;
	bh=Qsyb88pq8d9+OQbsN9pbDW+ICrjs4+twFyyhKKbNSrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lBeLaMD0ss9Bgz1TZ4abFM/qY+0izCTV/PLltyI18/G+UPcrPkZqYw3LC1Q2G/zO23f8WOhTpAybV8mCROGh+WpwhBRGqmwpKYIL/7jjB8C/vrBqS1/JjuRX/MwJSBaeMdFWV/U3m+dLDew8JWzlGqT3ZmbX+pK7L8SYqQGDokM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cAi6XVi+; arc=fail smtp.client-ip=52.101.56.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDecvJ1uC88yVneA5LBh4UzHwNloRnXobPZj7jrIzb75hlfAeq9Tl+q+wE2hvn/J2iQa9kZ7AzT3EXDrtJDsSNcPE8ksSAq3KesVuAhtKT+9JmNepN5W8d76mI5j1TM8ypdF6YqQ+im2EbnZfdFhhaSCDO/uv8hc5yE5siFnWYEtRD59AwFQD1pg30xt2MEg4HgKrAOswWVljeOqgENfgX8ca+9ag7NDtuxpdKJ2TjInkohtwWXKJqFjttNjZyS8Sbx3G+qqqmwah9BjiB00REIMFo5e5VWRTHO/9s27tyT1NArHpA6M3AwUkLoJWIrGlh4UAfDqP5b8dlVQ58u8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+DEkJb3sRLMgPdJXOne+d+2kVv1sHxmraeeZlxopH0=;
 b=d1ZRyd0fn7+UxX2kz/wHUWY4aUbfxo1+74msj9Qt/7jwbVULBiekUD87CS7/y9ipyGMSEOxe3pmOAAZPEhYVTCZfnXb7fiRSnl1uU/y2VdfBSMzZXIIxvUO2viTxoGBxrjVBQiFVCVgOO1zpUwOqOZt/qgFe7EwaEbh3mM8Ic2ZaGZcbuSu5421fuRzq3vQ7YfWIt4pwqhyx04eUZ9WwB6GDnjOkNOSrq6CTDBe6TUp3hncvY8YScXU1NleuGvCydBpi0NkvI52cMJckD4LSdJbYPsIhCykO8v+5TfdPW/PHIICGjbYShQ0BvPk5WTliPFSB6VtdQeVf5T+XYNpAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+DEkJb3sRLMgPdJXOne+d+2kVv1sHxmraeeZlxopH0=;
 b=cAi6XVi+NBe5TD9bTrf+c7JohBwctFqEQ1M04hupnVgO1VMu+buT9cbDyx7TVw+SvVC8RfJMssm/0F3GCPLrydhIX4D0MY86TxUc7KqSDe2isuXZRvkoIaZPC+7ibyN9lzasZF3y/1lXNvWWWxck6d5um9awwgPp39254LobSdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7288.prod.exchangelabs.com (2603:10b6:510:10b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 18:45:48 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:45:48 +0000
Message-ID: <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
Date: Mon, 3 Nov 2025 10:45:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
 shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aQjHQt2rYL6av4qw@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:930:15::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 82511f34-e376-4945-12bb-08de1b09347b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXRiY283SkVXZUdBSC9BempFandJY2VLR05TYll4eFNyeXVDMGpVcHlLenBk?=
 =?utf-8?B?aGpLR3Z3TTJMNFB0S2VaVjliQ1lPdG9qejhJNGhXTVJ6MytrNDFLMWNFYnpF?=
 =?utf-8?B?TjZRMVJOdVlyaTU1ZXp6Um93a09id3hSb1Z6MkZFa2N2TlYzdjhqaEVyYTVP?=
 =?utf-8?B?L1dsQ1ZpNVVWNCs2UWU1Y1BaaFFmT0hGbk1xa1ZWdlN0RllyQXFMOWVpUnJE?=
 =?utf-8?B?K2RudExDNmNsTWppVGswZGVWVEZJMDN6NE9naGs3L3RzUGh6R1d3dDEzTDlX?=
 =?utf-8?B?MmVmdVJRdlp5L083VktWZURIN0tXRWhtTzYzbXpqT1dRbTZ6S1VobVYvbWcy?=
 =?utf-8?B?N3pvN3VMVDJ6OVBmT1Rjck5IT0hVSzdOTlQvYjU0OUVmTXFLWlRtc3c3YmI2?=
 =?utf-8?B?RVp4QkZaRWVTQkliRityeVVoRUJkS2JYeWwrZEF6QXJ6TFRQUGFTKzF5SGR3?=
 =?utf-8?B?Ry9mQU9vei9ES2dhZnI1U0M0YWcwUFFGKzJYSENxeHFvRU4yc0czWitKb0VF?=
 =?utf-8?B?SDJkL05wVUtOMkZDdnp3ZzhLY2hhTlNWd25JMVI3Mmhic2dETytDcnVXYTZo?=
 =?utf-8?B?ZzZRc0w0VXpNSWo5dnpjZVcyRHFMMS9YeDZBcm9oQmZ3akNKZFozSjgzUENh?=
 =?utf-8?B?SjhaMm1aN3B1eW5kS3JnOUZjSDY1T3RWVU9scXM5Z2ExVk10VnpNbFc0SXBr?=
 =?utf-8?B?QnhxRk5TWWQvaXZITzdBdU5QVTA3TDZtTU03MVlqZUxyNGI4OE5ZbzVXSVNC?=
 =?utf-8?B?MHVuWW1FblEycUp2WEFWQnpqV0Jib3R4YUF0aUtQdGJFdEhpN1FudlYzbkFF?=
 =?utf-8?B?TXRRb2Z3cTczVXJKaVIxNmV5cmc1aStjNFBVUjg4VUc1VzZIVzZwRUVZUllo?=
 =?utf-8?B?U3poOFFYa1djVDNnL3JyZTBuejFQVmRkMjRPYjlUazl3SUR2UVdpTVNESTBE?=
 =?utf-8?B?aERSdFBhZTNXRUg5OTFZQndTdmpMZU1EOUxlV3gva0NTU3J5RHkwU0Jpa0py?=
 =?utf-8?B?T0NDWHQ5SHhzTklDVU12SWo2QU5ETVpJYU1hTmpPSVpjTVU4UFplUTZ2eEpJ?=
 =?utf-8?B?WUVPYWxLU3duOWk2SWV0K0NYMlcxQVVxbjNoMjdKa2ExK2ZMbVpMVjQ4SG9v?=
 =?utf-8?B?SzNjdTZNcDhOakExV2Z2RWpwRlM0RW0ydzVXd1pSUUtDSDJNdi9ERmRBNHd5?=
 =?utf-8?B?SDhScjUza1VDZHZJUDhiTWdGQm9VUGdqNUw1RVVmdURlNSs0QjFPUm1mYW45?=
 =?utf-8?B?Kzg2cTh6ejYxdFJzYVpoakh4bjF0MWJaSnpFSWFtdkJ4UTRHK1czcVJ4QWYy?=
 =?utf-8?B?YWsrblJ6RVhCQmNEN0N3b1ZLOVM3aGp6N1ozSVVXdG1lcXE2Z3doYnF0NVhC?=
 =?utf-8?B?UU1peThhWnEzaUxEajZleElOeDBMVGg3RmhVbzl0VmRZUlhUYTdYU2I2ZkR1?=
 =?utf-8?B?cnZWcllDWDVmeSt6enJKcmhsWHZhcitMc0F5Q2grVThtK1F6aXhXTm42aWRU?=
 =?utf-8?B?dzVZYzJrTUxoM1FZRXVOTDVYK0wwUmtibktLWHhWTGUzUkNGTXF3TjVKNVFN?=
 =?utf-8?B?QUJqbW1uNWc1MDZNYmVaTFYvcWN5cE0remk4NHZvNVpYRldMOFJicEJISm9X?=
 =?utf-8?B?VTZPUWlueCtKUFYraEdCVCtRdzVjM2pJMmtBYzk5c053SmJBbmU3NnRtZUhN?=
 =?utf-8?B?MmxBTEx6VUlpL1dWeXZoN3dsMEd5R01nRGgrT2FiNzFNV0ZsOGgyQTByT3NB?=
 =?utf-8?B?VDFCcjMrMitkbWw4cGlQSVQ5UUJWRXAydGh3VE0zeDA2SFJTbXhiT3hRNldi?=
 =?utf-8?B?RmVkUmVySkp6QnBDQ2IzKzdnd2svT0djZ3dtQXRvNVBibXRnSVJNbFJRWFhI?=
 =?utf-8?B?RDFzWDNBWjN1Si8xTk5qWmdRQW0wanVuMmNXYXNPeEhWLzdxK1pNaHNhdW1W?=
 =?utf-8?Q?7bDu+hDnbAMBojbV84SaLbyNE1ttYyrJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGIxZkhpSnRoeUV0SDhwS2tFR0t0UHUwd1hqU2lkUlhRN0t6TDVXa0RVN3pr?=
 =?utf-8?B?MXc2bHlqZndQdWE2OEFMZzR6UnFDSjltaS9Vai9mL3N2amlHeXJidW5ubTFi?=
 =?utf-8?B?eTNZTS9MK0gyOUcyNm5OMmZoVDJzVnhSSTh6NFJjbDRqK2VpazJBRDg5Nnda?=
 =?utf-8?B?dTZ3UkZvZmNoSjlDY2kxbHplR3FvWXFUNFA5RHdPVGs3OFRRTnE4ZG4xUGNC?=
 =?utf-8?B?T29uRWlaajRnekVvaVB6cDNicHdPZHZnMXlFcTNURCsxMmxpSldkK0Zqa2dH?=
 =?utf-8?B?NVRibUpjeWVUdWZUanIxcXFiK2FqTzVGMC9lbFdXcE42WEQvcy91RG9LS1Q3?=
 =?utf-8?B?eG14N1ZFUGk2M3VGdEk4TGRZQjMyOWx5d0FDN2tXeUU0cGYwbTViSlI1NGN4?=
 =?utf-8?B?bk9wRVoyaXZmVi9hcUtjcnA2VlV1ajBqOGw1N1Z5T0JXaVY4TnluRGtrNmM0?=
 =?utf-8?B?aWQ1NW1ralVlR1BIVzEzQVRwdGdLZFNCOXdUMmx4bTUveEN1N0VPUmUvdXRt?=
 =?utf-8?B?UkNrc0lhNHNZQmdXYkV2MHpoNEI5cmprUlA4TTMzZExHd2wvUnlPalIyZThR?=
 =?utf-8?B?VTZ1UWRGb0krc1FCeDdneGlzZ0hnaXhReGpXQUhNS2dyVGFMUTVaSTlWcUlp?=
 =?utf-8?B?Y3dyRWxCSk9xMmRvWnBVc3J3bTFNL0sxNlRsYUVMZEVzODB6Vjd4UWxWaUVS?=
 =?utf-8?B?MW1JaDltMmE4QWo4UVg4WmcyTFdJTjdIZDhHSWFwMldRWkw2TGtCZVdITlVw?=
 =?utf-8?B?OEFpcWtFOGhIbkc0Q3hpb0g2cVZyK2pVY1h0TkhHVVBWSmtHdmVIVk9uekU4?=
 =?utf-8?B?VDJMaVZlOFJMZU1CZ1VoVXhHSmJCNHl3MzhUTWFCOExoQmFlYVNvc2FGa094?=
 =?utf-8?B?d01qM2dRS1hyRkZhdmRwKzkwWXBJNHJ4d0tkVm9Yb05uVVpWbitEbUFpbklS?=
 =?utf-8?B?RFl0MEd1bVgxekhHYkFpZm5TS3BIRXN5VlFUSWFxSVhKQzJHYk1odExoOFZU?=
 =?utf-8?B?U2orSUI5a0lIR0ZIanFIY1NLMVZhcExiZHVpVjlmNWhYcElmMzl3V295UEtw?=
 =?utf-8?B?c3M2d1hQRytPeGhWdDZVc0txY0Evd3N4THlYajdWOHRkanFSalVEOUd0VUoy?=
 =?utf-8?B?UHppMkJLa2JRTk9Ecy9Hb1ZhY3lDT2Z1UGdoMUdiNUpZSllLTmxkRHJ5bkQ2?=
 =?utf-8?B?dndLWnJhOUlJaVdJOHpDdUdLL3dIcFIrNEdhUlltVXhpY3N1SGhsTlF6K0ZF?=
 =?utf-8?B?aW1MMG40T29kQ3BiUjRsQm5sZjduRjJBdkNGbS9aaENlcXg1VXlKd1NrOU1v?=
 =?utf-8?B?cGg1eUFLRFBnUnBtNURoYVBlcUFNUXVzYXQ5Q3U0dWhaL09FOEtqLzBxRVow?=
 =?utf-8?B?SU5GR1F1WnFqVjJoS3c0T0l0NVFDMkNBWmxqS0tJQVVmZVpiVXVFUVVZSUFl?=
 =?utf-8?B?VkxwMzlzQmwxbEszcGJ2ZU9DOVI0eXJFRjUyVEE3WHk1TkF3QWRFZ0ZJMUha?=
 =?utf-8?B?S1pSV0lteXViSTJDM0tEOFYveVZaZTdaVFJrYjBZbHY2STNSamh2bS9FVElE?=
 =?utf-8?B?TW1FMVM0bzZadmVRMDFHTzZmc21oZHM0Z1BjZXpPZis3UGMrbzJwT2x4dmk5?=
 =?utf-8?B?WSsxeTV1K0ovWHJMMkdEVjB3SzEwZXBodXBNMFpPbTA1eHdqOUF2dmQvdmJC?=
 =?utf-8?B?aGNWQVBNMzRHdnNqUVJvZVdlL293VE5NQ2JCbG4xMFowRDFFQTBlVmM2QTkz?=
 =?utf-8?B?bWg3eXUyN1phTU5IaVNtMThkOTRMRHZuUWMvb3FUTm5RZjlNRWR0SVp3RVM1?=
 =?utf-8?B?SFg0Q3JXQWhFeEFNOWJKamF3ZHVJZWcvYTZDMkRMWVFJUFRRWndWQUNiSzN6?=
 =?utf-8?B?akR3K0tEZWlBNzFNSUc4ekdmRHhZUXRsR0VsN2JjZ1kyN3ZPSjYrbEw3V2ha?=
 =?utf-8?B?WFU2V2JYN1hkVUE5cHgxZlFYS280ZXMzZ0tiVlI4TGVCcGxDa3VzMVFDbmJ4?=
 =?utf-8?B?Mm9LREFuMmp3S3JsMnNtN3l3Y2d1Q2o0dlpYL0p3bnBid2RaN0g5eTdaNzNI?=
 =?utf-8?B?a21QaitVeGtLSVhFNnQxczIzNjdvUk96OCtoN1VoS04rT0VVZUx2THdtaFgx?=
 =?utf-8?B?WE1IQnVPcXRZemlBeTZPN0xuUTQ5Vlg3S1ZDeUpRSFQzcGtBZnh0eCtVTG8z?=
 =?utf-8?Q?NEAlrQ1surm/lZQzHGuMwMc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82511f34-e376-4945-12bb-08de1b09347b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:45:48.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hY2Wbl3jevOZSgffe4PS43/MQoKBVwLPHaUarAzFqrO4xG/HEqKuTtRg6Rd/tBJCmA/5QsbIkS9GKroThpt/ZTIAVtzbFq9aGdv443xVfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7288



On 11/3/25 7:16 AM, Will Deacon wrote:
> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>> Post a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full"),
>> __change_memory_common has a real chance of failing due to split failure.
>> Before that commit, this line was introduced in c55191e96caa, still having
>> a chance of failing if it needs to allocate pagetable memory in
>> apply_to_page_range, although that has never been observed to be true.
>> In general, we should always propagate the return value to the caller.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> Based on Linux 6.18-rc4.
>>
>>   arch/arm64/mm/pageattr.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 5135f2d66958..b4ea86cd3a71 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long size = PAGE_SIZE * numpages;
>>   	unsigned long end = start + size;
>>   	struct vm_struct *area;
>> +	int ret;
>>   	int i;
>>   
>>   	if (!PAGE_ALIGNED(addr)) {
>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>   		for (i = 0; i < area->nr_pages; i++) {
>> -			__change_memory_common((u64)page_address(area->pages[i]),
>> +			ret = __change_memory_common((u64)page_address(area->pages[i]),
>>   					       PAGE_SIZE, set_mask, clear_mask);
>> +			if (ret)
>> +				return ret;
> Hmm, this means we can return failure half-way through the operation. Is
> that something callers are expecting to handle? If so, how can they tell
> how far we got?

IIUC the callers don't have to know whether it is half-way or not 
because the callers will change the permission back (e.g. to RW) for the 
whole range when freeing memory.

Thanks,
Yang

>
> Will


