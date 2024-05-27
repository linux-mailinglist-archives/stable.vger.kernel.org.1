Return-Path: <stable+bounces-46302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE48D001F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73258284555
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5E13B2A4;
	Mon, 27 May 2024 12:36:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2109.outbound.protection.outlook.com [40.92.75.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED338FA6
	for <stable@vger.kernel.org>; Mon, 27 May 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813363; cv=fail; b=as5Z1j3qPnr/JcnCbWflGEfnUbyixEJ1kkBmTHTxFUCCxOnBIvGdhD1i0Mp+LvkMVe4c73CAr4mT3DvobivmG8ut5EeFUMTHzVw9iSFH8JzYCAx7cgQmKS3oFmkz5z++iakXH1nwLV5OhALA0ILfZ2NGOl+s+zZl3cXbC/4kGFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813363; c=relaxed/simple;
	bh=7apROFw9VO1BqE+eEa5jL9T4rgPf3/PkNyYnHueR2ZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gbrj2cPoo85snKKAhPEXzxd7KZjRdHgzoiF2oCX7Tx9qoHByK3V7J+6aV/tUd2gQEhYiTj5bZ+l3bgfvDQ159zIJE0Nkq2brHlF31ZjmgxQRlnKa1me65mu7F8RlVwUKSRoPUkUZGRzFaCAnQCA80TQj+OacotZ5Lir5m0Q+sK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=40.92.75.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn7ELPlXqmP85bmcCEI773gmS+2fOt0udxVmOAq+pqorgmILUCNnZGlPHVlyeKhrWm+CbgJDBgMk7SiV36ymVirwOgBTX9aGdMlIKnrzw8QV2xY55bpkcQkarEIMxUUW4vU8MZN27sEXUCyUxYeYe7M85AhhUtzTAot6h79Ck4b2JWOCodMRTEDbUGzzuUKmWoO3FFEHJTGtYgpS5Bv2hRaVHjBJWzxX13E+wxgz68IUSDiAKKR0HNUllSmaOx1Z/S1rcLJdg9QlIQ0S3VOMbTEsPS9DT7n4N+5VCFauCIubboDVvQyzTfsILCsPrRsWrMFKulVe2+mi5esmUEiUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMAfNETyJOgQC78jP1uNQ/b/5EEv1DE3kCQBdv6yv6c=;
 b=KpMEbuQJ8g/Wg7DN+oJ+jirOdTp8y76ugzvJytjAL0NnA6R/lf/dxmzFxq8G6laOC8KpNkENCfaDDyDi+Pa+SYEa4s0Hip8kIS0hmJNosw8cumVg5Iqq5y7ljacG8RQ2YsLwPZruqHVPePyBIT5OQ+5LzJJQ0BUJD4u3+d3z3MXQ/Jh5V6cK+94TCSCLJPEFy+tqWymyAiEL3DI2KZ2TMtRZmoONPZAEsLCjMvsHqKrtgI2rNHskYzvQhroGQGUyGTNDvOCtlul3vYPoU3CbnbYrlquDLulRzYu2Pk43t0BvfdNVfLjVANcaTPI2oVTx3zkLNdD+3GnzZtJ80+dxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com (2603:10a6:102:69::18)
 by AM7PR02MB6052.eurprd02.prod.outlook.com (2603:10a6:20b:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 12:35:58 +0000
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802]) by PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 12:35:58 +0000
Message-ID:
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
Date: Mon, 27 May 2024 14:35:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
To: Thomas Gleixner <tglx@linutronix.de>,
 Christian Heusel <christian@heusel.eu>
Cc: regressions@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <87r0dqdf0r.ffs@tglx>
 <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
Content-Language: en-US
From: Tim Teichmann <teichmanntim@outlook.de>
In-Reply-To: <87h6ejd0wt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [fYGDFh9UF/xytRF+/CAZ93JJv/5vd2l1dZGX9lWCsCXghNZcfJdeK9hDyDWDZmpD]
X-ClientProxiedBy: AS4PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::16) To PR3PR02MB6012.eurprd02.prod.outlook.com
 (2603:10a6:102:69::18)
X-Microsoft-Original-Message-ID:
 <b8ab7061-002b-4691-9a26-fa25a1283804@outlook.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR02MB6012:EE_|AM7PR02MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 47746b5a-6360-4397-d9ef-08dc7e498f39
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	a/jRwhw7Ma40koCqncM9jgBAV3AwtBwTvkOIKBhV3LNylvvkxmhhPBWaAJd2iBOQFZQMii9YRflV3RwB/29G/7TT+94TEUwWaPPFEva44g1Uq2IkZ+q3SliS60Fd9thdcbs9YS1B2zVFE4NZJdnYhAgPlXHBqjOK2PbqmeokEW8S1SQdd7sK5zee6ji2+JlTvoM18rfvLnZWIs3/5J4s0kBNBe3GVqb/G9DFNA4/AZKzPmO6l4plHUupLy5YtQAdX3t1ny9v9KQzHkY7N6kAERaZ/oPQGFWR8gR85AQm4kV+z/MyVtY1/iEkAJpz2ZrAtc2hLOBUFRKg2mzQ4axXe/QUyc7y0RhLjuP4hbYR63gem7Kho1AtwAowRTEJZ2sAHB4V6YO+PsT6Ss4q88g7XQy1yxYmrpXLrgNJQTLpiWDPG3LePaByM5bN+xrWijiv1JLihm63g5CQmaSn8UzWo6iKV1hb2+j1GJYOK4K3kwEU1cPK8adRSD63tJSgG1LUc/LxHSRLdfJalZz1I/pbb23Za0AYBmdDZDcLwFxDJ/xjUp7RLex336wytTlzyH8X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUZQTVJtTzMxaW1OZW43TXpWTDRoeXR4U1pyeHMrSWNVZ1VVV0d1bHJLWGlY?=
 =?utf-8?B?QkR3UHMreHRIdTByUVVtKzBheVdXdmZ0N1U3VWJzUWE1bkNXdkVDUGdNU0dY?=
 =?utf-8?B?L0xTVVQrd3NmeFVQeHM1K2lsVCtwTTFvKzdzMERLNjE5eHdXQWsxS1Q1dERw?=
 =?utf-8?B?elNQZ2hGUTRjV3RBWnpXZmJpdXhKNU5xTk84clhnbVBxMStFY2JUNWlxUmhJ?=
 =?utf-8?B?dFZ4cTArTUtjaUE3ck9RMjg0RTJ6R2JxaE5vWTZQTkRHUkcxVDBpSkpGazNh?=
 =?utf-8?B?V1g2UWdGelYvTTFCQ3JWNFJFeVhwd0o0bW1EUXd0YnVOa0FYY1V0Y1QxWXpx?=
 =?utf-8?B?eXJ6Ty9zTDV3bmExd3h6UUtBak4rbERWd295SldvdlM2dnVaU2F1QmdPNG5u?=
 =?utf-8?B?dmpTcHFSSmxFY3JlaUl1YkhGNnZ1MjB4VlBEbVk4Si8yRHdaYzgvMVNSd01r?=
 =?utf-8?B?a3VPSHFwaTM2WFF4cHl4YlJWeFMzbjJvL0hIcUV5Qndud1JlQ2xmN3dyL3JH?=
 =?utf-8?B?V3JiMHVUdHBGcnQ5Y2VXWTR1TXFmRVltY3NxdmJtVlpoMUJGUlBZMUw1U0g0?=
 =?utf-8?B?WGkxLy95K3J2UC9CWkdaRTRsQWl5bGxCSEtTNFdVOVF1VndwUGk0MHZ4aysy?=
 =?utf-8?B?U3lXZnYzY3EyZUF6KytudmZ2dWh6V0ZSaGdneEp6UFdZR1lmN2U2d2xGME92?=
 =?utf-8?B?NllEWTgzUXhWTUFWR3dHOGVCVFhoblhDY3cxRUg4dmNFQURMR1h6K2RmNHRF?=
 =?utf-8?B?OTZjc2pVcHZSZ1JXcjA1eFJNYVE5bDRSQnp4aGVlVTg4RjRGWHpQZW5NMm1E?=
 =?utf-8?B?K3VNVFFLVWlQYWZLL2RGditadnVuZlJpcTFCMWpzRkNwS0xZdytVOWNiVnFw?=
 =?utf-8?B?L2JvUWtkeFcxcUhiUmV0MjlET08wckRaNTEzVU0vZGxETTcvdTJ6UlBZVGFF?=
 =?utf-8?B?UzQzSTZrdTN5RkhmNGdxdUViaWNTZWc3UDlVYjdsVndDWEhPSWVWOU5hN3F5?=
 =?utf-8?B?TU1jSEp1YlVaMzF1R0FVVHVLeEU0Y2pEVnI1TFYvc2twYWR6ZUhMcHVBejJG?=
 =?utf-8?B?blNpRGgvV1pjaEI3dnlPbGFEaGlPN3V1akJEVys4TDE1OHByMEIxMjgvTXNj?=
 =?utf-8?B?bWZNd3hyQS9hOHozdkw1Ym16NERvOE1GNnVoSTFNSGc5SnQvVzAzMGUweUk1?=
 =?utf-8?B?VlBXZ1R3c2hsaDRiNENvUnpDMXMxS1RjalFUUkd2QzUvS3ZhbEtLUG56UGt0?=
 =?utf-8?B?Y2xyOTBhTStTUUwvb2ZJU1dXZVQ1WDdZWG5WY1c5S2dySnQ3VG5LcjQxbjBk?=
 =?utf-8?B?VTl3RXM5NWtRVXM0emxTaCtUTCtpQWo0U0gvYmZvYjVvU1lpN0Jva3piVm5p?=
 =?utf-8?B?cStpL21MbWhZelFsTnNWWEVVQ2gvUnQ2amJvOE5xTU1nTzVmd09xUlVGUmRM?=
 =?utf-8?B?eVJHZXV2eG5wTXJ0c0pvWnRuMy9wVXdKL2xQTllYZzV0MTVHZlA0WE04eS8r?=
 =?utf-8?B?a2xIbWh2cXBmTmdQNTIrUTEvRnI5eUdWUnJGekxaaVJheTZaQ1hoQTBxdWxF?=
 =?utf-8?B?TFhZa3ZEeWgwbGZCMG1GRTZQTHZpUkMyZ09qNnlnWDRKaUFNeWluVlkxT1d1?=
 =?utf-8?B?ZFlhTnZCcFNFaHdTQUNQR2Uza1V0NkgxaDZOL0lORVZaNFlXQ3NBMnFPRDFQ?=
 =?utf-8?B?QkVIaDk3TFZlNmIweG5vME5JWitSUjJLQ25aaXRqTGVmWXJDek1xUkxISGdG?=
 =?utf-8?Q?HB7fewy53vqRmpfcwE3BXzD1nJY8MH0KlZAeWbz?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47746b5a-6360-4397-d9ef-08dc7e498f39
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6012.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 12:35:58.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6052

Hey Thomas!

On 27/05/2024 12:06, Thomas Gleixner wrote:
> Christian! On Sat, May 25 2024 at 02:12, Christian Heusel wrote:
>> On 24/05/25 12:24AM, Thomas Gleixner wrote:
>>> Can you please provide the full boot log as the information which 
>>> leads up to the symptom is obviously more interesting than the 
>>> symptom itself. 
>> I have attached the full dmesg of an example of a bad boot (from 
>> doing the bisection), sorry that I missed that when putting together 
>> the initial report! 
> Thanks for the data. Can you please provide the output of # cat 
> /proc/cpuinfo from a working kernel? Thanks, tglx 

Right here is the output of

# cat /proc/info

from a working kernel (6.8.9-arch1-2):

processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 2337.643
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 1
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 2
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 5
cpu cores    : 4
apicid        : 2
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 3
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 6
cpu cores    : 4
apicid        : 3
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 4
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1409.207
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 7
cpu cores    : 4
apicid        : 4
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 5
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1408.936
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 4
cpu cores    : 4
apicid        : 5
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 6
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1409.260
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 6
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

processor    : 7
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 2
model name    : AMD FX(tm)-8300 Eight-Core Processor
stepping    : 0
microcode    : 0x6000852
cpu MHz        : 1900.000
cache size    : 2048 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 7
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic 
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt 
fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb cpb hw_pstate 
ssbd ibpb vmmcall bmi1 arat npt lbrv svm_lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass retbleed
bogomips    : 6646.92
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

Thank you,
Tim Teichmann



