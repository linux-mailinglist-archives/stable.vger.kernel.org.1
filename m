Return-Path: <stable+bounces-222554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMjQJkxapWlp+AUAu9opvQ
	(envelope-from <stable+bounces-222554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:37:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DD1D5A49
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCF73032072
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF238F639;
	Mon,  2 Mar 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cjoozq8y"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1A38CFFC;
	Mon,  2 Mar 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444187; cv=fail; b=lnSLQsLHWC2NWw9NLBLmqfPV6Ahuo8T1vmHHCsqZthnadlW36pa7E50nBVK/9eGUQFrNe64ykLOiYUwZGw/nhFD8kk9vOrZOUDv4QvohBepO9lpDN/rxt/5UIdu9DdJFEQHp8CdGCv3tiEovW2EU3KVAcptVoeCOyZNf2WrcVGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444187; c=relaxed/simple;
	bh=okvmapAr86ECPikhfDjhpQza2YuMYkhQabQ1QdZoxd4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imb4FxakIaUtC1BxDIx1hqRpzdiB9sfisZERJyhzg8lFI6FDUIlsec3IZXJVViftRPPAIeghWwY6SKP1oDG68jebWcNmeIFDbYSLpsAUm2CsZU40tE4ItTB83m5bOZZqsAm8kt9/d3863iGZuaRMlZPFA9YbmEf1TMhluNd8z8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=cjoozq8y; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9TbWfUOQrQ18+CHFG/FxQ/l8AgkCsVwBlGnEkj/vODMALUijnlq/UcKDFVRPJMe695BYWtkwGtP7dGnD3gu4WHLiki92+wGncPeNQrwFxwWeDHZi3Ui6btNvKrNVuXmg09Wz+pr0JJJ4rjXsclfgdOBeKwSYJRiwWKo3xWMREJ9APUYplC1j8wTkmeCgYmeFgJ646fTEuGkUcevdp7LA5bp8zm2aISaw1I/fbiOZPnpiGnFi8fEoAI7BNImVmAZs4PXuyESARScHj2D5rQhvp2lUzNjWSb6Jo/+feJjgmMa6sI4YF7PXyZ0aLouSawwHQyQLLFI30WuTKhG3SFdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8NLqrhrvJGe10958GB5hFrE5LoWWzgJqJf2n7mpkBA=;
 b=BIQgcaNVwiBO3ImhqXxLVkcW/G6KY3qTxMEwRErJSY+sd+tiMjnALquoRw96nkIGpptUKQmQog/Ly9GwRs4VyHgqKEVRBJ7yDqD6eJs5eWpnZOIS3ZOFrTXfSaJXInt94CF28Lt9GYIb4/yvRM94oi1yIjjfB5ZM3jmv8f91DlS7nlHR/oRWPmFKKD+pwXA9C0XnkC4RdicyqAGDV4NejgMc14t2bPzY+Tqx/e3RpQSRl8h930N3mGirqc+pfBIc3mnslpz/QoC1GCT+moj6H+cdzWLbtV0DfUbmf/Rzt+SWHEna6yHK+i8YmSkHFWfDA9FJ8oh04igNMEV6qfiSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8NLqrhrvJGe10958GB5hFrE5LoWWzgJqJf2n7mpkBA=;
 b=cjoozq8yghsP8LibWLp36P47clqheOnCIcViuw0AmUdnIYa3NoteVqDKajQgs5q1DqkeRN5iFT69hfP7Y4jjT1lvM+zMQD4plRHXOekvhDDCP67aDfLg0HLGQbUPJSn943TeHOnzCJzgZj9ekrNMfPsfiT16tbfx0RlPYuoTnPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 09:36:23 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:36:23 +0000
Message-ID: <c6659868-dfca-4aa1-9581-f6f37674b6e3@citrix.com>
Date: Mon, 2 Mar 2026 09:36:20 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Yao Zi <me@ziyao.cc>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20260228173704.62460-1-me@ziyao.cc>
 <05f84fa5-d0df-4bab-80a6-5ff2c418b5ec@citrix.com> <aaUbR-vuxmuRhAsC@pie>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <aaUbR-vuxmuRhAsC@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::22) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|LV8PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cc2671-b5ab-421d-d4dc-08de783f2b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	aq6MRd4A1FkunGZj/+kjcjPX7iJ6D8SIj9ZQseBSm49myC3q/Eu7STNcJV7q7HOuyoISaHObBbP6VGmLO8I+e/PuN8p6PSxF0XICJBB/uhaqCvhVWWYuiKsfDhKypxza23qvmaCY038MWZT4VYRb41O2Prz8jnGDauXoG+bqCi7dQT+lFHSqVC5nOaVvgWWC6e/RHeDcafH0dRs6Ffv13xN+XopOHqTEmCor2URh1T6ZlG21KLDTnSr/LP06bWo+/OBnfT2z36l9gB1L38AkHDF7NFrG9b5SM1EmbNevM9CN4Y7pnuZCs2DT15ztAcJwj5pRtaVsgn++TL9uS16l7OzrE+zAEdoM87DMMJEwxJuoUfPB82JCcLopCWNts6EY6RpPxBf055bWSgAhAoLh1rL3Q8/2TmYJ2ytsXqE0jyJO9zdqeBtrfbGjxw8DPceohULF5nQ4GtfPMelj3a0+TXtd+xm4V5S1RbpkFBd2gDJ9W5szAAOPB/9p+/B9k8oEhUcdXQ+Er+k5Y+uJHsCGbGJ66EXhe0h8272m60OeDz3RVZU1tFOQZPl7PInbGxGFdXh5YfxDKDFOoGzbzgnq/RQO1MBWm1eMDeoaMVYhcezxjV8BFCIBlNMyxJzK9le+kMCTOuFuqsgYn1vM5d23ko9H89+UPVyhXsVvPZJ2DWWOY34lHc6JIRkqvc3vLeSLDC5MFSdbLFbDMSPGMf/YHLI8klTbibDrSROGXcGsI0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdIclg1QkFHM1RXdkd6OXpqcG4yeVZtTndIQmRNcVNTbE53bEtzUU1jZnhC?=
 =?utf-8?B?ZlptR3BEUENNZE5LTkd2c0dRNStwbm5leE9hR3BHRmJJMFNIdGZlZ3pNdi9S?=
 =?utf-8?B?djdZRmN6d2FRYTRvUGZycDZCcDVHQXRnRWxNUlQ4Q0ZzYzd0N1J4dHgwWHBl?=
 =?utf-8?B?R05EVDVxRTZMZEhJZzJmV3dna0hmVHgvcG9IRk5KSDg1cGI1cDc4L3diS21p?=
 =?utf-8?B?Mm5UbmRkNHlLYjFOOTZnQkxybU5ZTnhwS2Y0bTFSbjBaRFREbWNGa3J1eWx5?=
 =?utf-8?B?TlMxYUM1NjhNeS9WR1dGblRJM1dFMVgvWGNyTzZsQXROdUhESnNEdURrcUZO?=
 =?utf-8?B?SVV3UFlmdUdzaGJNVVFVaitZbTJSN0JoYWFoRWc2WmNoMXA5SnZnZTc3U3My?=
 =?utf-8?B?N29sR3JUTkl3YjZWTTRTTU5xUmUrVlRUdXBiNmFXVENqTGVEWUZDMFZJTk0z?=
 =?utf-8?B?VDhaREV1cXpiNlNzMmQ4dWlnR1R0MFBGaVVWYVVxT2t5RWVlcVlNaDhkOWJt?=
 =?utf-8?B?dGtsdUJjT2tPQ1pTK1Ezblp5ajFUVm9lT0sydWplbWFTTytYaWpSN2dDcy81?=
 =?utf-8?B?ZEw1N2Y3MkpvSkVITjJaYWNSZEVISmVnM0FCWHg5cjR5Q0U1Tjk4aUFSTnFY?=
 =?utf-8?B?ZUYxeFJNSjJkUmpmejdHa1M1ZU5pUG1PbUpHb1REaHFOVlV3dnhqK3FtZEc1?=
 =?utf-8?B?N0hXV2ZkU0o1MUxaK1QrME4rL3R5VTBJTGpzNFBVUm9HTVZ2blBzemNRT2RJ?=
 =?utf-8?B?T1BPNG9oL1FJR1JEYy84cTMvWXp6a29nUFZ1eC93eUFrU2xobU00Wk1DSGFQ?=
 =?utf-8?B?dHFHZDRwV3JLdVh6dTJwR3NLckJzVUZuQWRQRUVBY0k3ZmE2SXQ4aFl5QkZN?=
 =?utf-8?B?MWJ2YXN5M3M4QXpZS0dUZ3d4RGYyeWt1akFoSFV5NXIwV2VDR0dmTDE2d0Na?=
 =?utf-8?B?OWFIRXJPbWppWU1HQTRXTFZmWEJMeDFxSncyaiswbmQ4by9uMlBBUEFlclFv?=
 =?utf-8?B?WDZhS2lGcTBVdVMwR1A4eTlScVNNVG1UODBFTTNJQk1IUWgwcFp4MTFyNkt5?=
 =?utf-8?B?N1ltY0orc2xyQmFOdWtZRVowMTQvaW00OW92M3l1aGhlUjNKR1dJTFhGL1J4?=
 =?utf-8?B?TzRhcHh4ZCtQK3NNKzRRampSbE9NRENUUTRFdjlZRUliZ1NEMGNPWkJ0REwv?=
 =?utf-8?B?SlFxRDJ5M0JvY0VPZVJqRFZIYXJyeWxjdDJPNkdLUml1NXo0OFhrcHJvUDlT?=
 =?utf-8?B?M0Q4aFdNMDU2a0VhdWpxQmFSQk1LUHZpbmhOd2pjQ00wNll4YmVoVm5BZnk5?=
 =?utf-8?B?RkJhT2VRb0c3ZXN2MCtjN3pTOUFPSWhJWllHL0pzN2JlSlZrYk0vbG5PVHRL?=
 =?utf-8?B?RDdMcFllOGVwemFFcG9nTW00YjAxVjlPcEFhclg4dERnYzk3THdoekF2Um12?=
 =?utf-8?B?eGNpbm5lRG41K0JUUityMWR2cHJLcXBXZGNONUpzVGdhWkFuQjMrQVp4Qzky?=
 =?utf-8?B?MTczcG9jZVdFaTdKUCtMaGVIY0trZ2c0emd4L3lWMVZpTlErMlFvRTdpWG4x?=
 =?utf-8?B?MVNOOWpMcWxUS2lpc0tzaVdoV0p5NTFTSk1JdWltN3BnWjEyWjNyT1BxcGRK?=
 =?utf-8?B?MVg1Z1ZTeCsrVkZxRysvN3k2UXpESGxrNWNqSFdZVTNmTFBFVDJYaG9ncURq?=
 =?utf-8?B?dDdVYUJEV0lkMVFndDdCeDBsSlk5aEZtV0ozWjc4RzltNUtqcHFIM0F6eFZj?=
 =?utf-8?B?Y09QK253a1FRL3oyc241d3BwQmJwbnpPaVJ3akZaMlBIMkxlR2M0aWlKdm44?=
 =?utf-8?B?VkpBamRMS0VlWUJlWE1wT3VVblk2cHJNMnowemxtbUdCSzVtWnF2QTBRTzFB?=
 =?utf-8?B?V0dZRURGN0k4WHMzWmdNRVd1YXMxL2dScHQ0MjNzS3hCL2tod21WMnA3dVFW?=
 =?utf-8?B?VUZ3Q3NjekpHMXpDL2VaTENtNzRwaWUrZHJZMUgrM0p5eFJoZzhTSFpKMDFp?=
 =?utf-8?B?TnMvUVoxdE82bGVLQlNERE5lSG5DNWZyYStPN2R5eFlURUdFblNUdDg0dXFN?=
 =?utf-8?B?enkyc0FFV2djUURNRXZVbFVOYUw2V1QyMEtXR0FYcnZhRG5KaDlYNTJsVmpj?=
 =?utf-8?B?VnRjemZoeUszNGZIOFlyS3Y0VFJXc2VuUmY5Vkh4aUtKOVZvL3FlcTFnRk9O?=
 =?utf-8?B?TmZpWUlmS0VHWWN5K1VscmRwK1lTS3E1MUhFYWMzK3lsZ1hyK3hDVWxUMHBl?=
 =?utf-8?B?MHpzYTBwS0tBQjZQNGcvTTl0bmpNZitYdVlZbXlkKzlRYkduaXlLR3VHajFG?=
 =?utf-8?B?Vm5HSllIUXk1WC91Tk81TG5vTTNGREduVSt6N09xVnZFZ2pBbHNpQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cc2671-b5ab-421d-d4dc-08de783f2b10
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:36:23.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQlNFyk4Iaqgo1269FE2kqmbT/p55HdN9Jdte3lrW/5IQuHDgApOIFu13ZQHRNkWAkDTyaGUiV3UkxB/EPjCA/5iGnKmjMhOLAlf5fk5T8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222554-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[citrix.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,citrix.com:mid,citrix.com:dkim]
X-Rspamd-Queue-Id: 013DD1D5A49
X-Rspamd-Action: no action

On 02/03/2026 5:08 am, Yao Zi wrote:
> On Sun, Mar 01, 2026 at 04:29:13PM +0000, Andrew Cooper wrote:
>> On 28/02/2026 5:37 pm, Yao Zi wrote:
>>> Zhaoxin C4600, which names itself as CentaurHauls, claims
>>> X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
>>> related instructions fails with #UD exception. This will cause kernel
>>> to crash early in current_save_fsgs().
>> #UD is the expected behaviour of the FSGS instructions if they're not
>> enabled.
>>
>> Are you saying that this specific CPU enumerates FSGSBASE in CPUID, and
>> permits setting CR4.FSGSBASE (without #GP for a reserved bit), and the
>> FSGS instructions still do not function?
> Yes. Without any workarounds, the kernel crashes in current_save_fsgs(),
> which is the first use site of rdfsbase, instead of identify_cpu() where
> CR4.FSGSBASE is set up.
>
>> What happens if you read CR4 back after trying to set the bit?
> CR4.FSGSBASE is set correctly, I wrote a small patch for testing,
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 1c3261cae40c..d89a2cc71147 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2048,8 +2048,13 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	setup_lass(c);
>  
>  	/* Enable FSGSBASE instructions if available. */
> -	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
> +	if (1) {
> +		pr_info("%s: enabling FSGSBASE\n", __func__);
> +		pr_info("%s: before enabling, CR4 = 0x%lx\n",
> +			__func__, native_read_cr4());
>  		cr4_set_bits(X86_CR4_FSGSBASE);
> +		pr_info("%s: after enabling, CR4 = 0x%lx\n",
> +			__func__, native_read_cr4());
>  		elf_hwcap2 |= HWCAP2_FSGSBASE;
>  	}
>
> On BSP I got,
>
> [    0.298016] identify_cpu: enabling FSGSBASE
> [    0.298021] identify_cpu: before enabling, CR4 = 0x1200b0
> [    0.298027] identify_cpu: after enabling, CR4 = 0x1300b0
>
> and on APs, CR4.FSGSBASE seems to be set by default,
>
> [    0.414981] smp: Bringing up secondary CPUs ...
> [    0.415211] smpboot: x86: Booting SMP configuration:
> [    0.415219] .... node  #0, CPUs:      #1 #2 #3
> [    0.001869] identify_cpu: enabling FSGSBASE
> [    0.001869] identify_cpu: before enabling, CR4 = 0x1706b0
> [    0.001869] identify_cpu: after enabling, CR4 = 0x1706b0

APs inherit their configuration from the BSP.

In which case your checking logic wants to enable FSGSBASE in CR4, probe
a RDGSBASE instruction (see wrmsr_safe() for extable handling), and
clear the feature bit if the instruction faults.

This will be far more robust than looking at the brand string.

~Andrew

