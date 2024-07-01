Return-Path: <stable+bounces-56265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5391E4AF
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F6C1C21555
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5516D4CB;
	Mon,  1 Jul 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y2f1wdVk"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7C126F1E
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849504; cv=fail; b=tiM1DkDJE8F655OZo+O6wqjSQjIu1SYlkcALpq6Hn7xiaYojNSHeZmk6xHTbbGyJOHOHhOCeudOSyf+SzYrS6beGbQCuumuIq+9rFHwPjho5wUHT2NQXPG0ZafW1tpP8wr61CNN8uLGKZZKNq6xES4sq9QsJa5zm7Hb6BYB+hZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849504; c=relaxed/simple;
	bh=W8sOoJQ/jCYFfuSl7vd0/gfi207Ty+q+dby2rL+/bbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9zkCoV4e97goliGR4bMrJlGLjzQ13I85Qc3GBWRDCLSnUlY2yjaJ0mrbKhr8ofK2pCZZxRB8OvcUkwjPM9uYQCEfbFDJ2j5Fq66+wIc+amqvxQ9nSVqJiJu0nBSb0X8lfHbDbgf0hT1J0a6tSiwzY+nOKQ5CasZsEkYrWCU9sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y2f1wdVk; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjWeomI464e/Rn49iHtbA254xwqBZO/XA3aDJIelXhzc5VKEFXiDIHxLqfUzPAivOmqM+W8BpFgAW30nhwgES7+G8t9NFIDWpWjQ/e68FIAMvSOU1qYvLZ7pMIRVdhrP0Y4O1sc3dzP2JMKH/d5kGH3Vbhu/7C1PjumIZ5sLsYMUpQ5r+WPmRciNj1ZuuK1gLMW42BuBS3BZDtLBQDc0FbWyX8vTA4LdxeDgqODwnJXnfevQMMq5Th1F9QCQKoRTKXPJjLOprghJd0n2/mrPqxwKQk4sFCHHj2fh6AmF4ALMZxZhQonjnFB15no3wnUTRcGnx5OdYkhh6wm8y4Xhag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkaZS4sashp4Vsw7pZ1aARIe8AzmsoeDga66YyvziSk=;
 b=PcV4onlPhg7uy5slBmoOUGghF5W4C47SCdIflYeCB2ZQzevvATjTrwx9UMiHlFgMeK4bEGRLQq3JzHZvaKJp9QhM+VonjxhDte36eIMPcmbb0d3lEQajr44PFt8j+nUYZa3eUnBX8VN66Vle43ywFbHjQGJyxabC1B6WqVeXG5JxZbVPIflZOsYsc7iBt3YpqDXdfgmKq6VzBNQah4k5i6p9p4rQ19LgIx50rPrI6lhSnPXsilxzNg+NqPiafntolbzMTFUOEXmStRuN46nARmcxg6WiCqjnSWn9JBRBZFY/NOftXiBIyoChi9R6+G6R/zrKKac6wu88670gt7hmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkaZS4sashp4Vsw7pZ1aARIe8AzmsoeDga66YyvziSk=;
 b=y2f1wdVkmmbBGHDTG1zD2uO88OI9Jy7Yx0XRhtQkFLYGJSmxS+ZkkSCJ5gSHm1ymiYVz+jeJboyo+fVYtuhIBPMucaYzNIdrloCCMydYpBYZxLiD7CJs+3Mj+jzd9cTCHJUSI4vPOBR+29OTs5HGKzHsqpZpguLM9npbIcW5Fus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 15:58:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 15:58:20 +0000
Message-ID: <fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
Date: Mon, 1 Jul 2024 10:58:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since 6.6.34
To: Lars Wendler <wendler.lars@web.de>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
 <Li.Meng@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
 <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
 <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
 <20240701174539.4d479d56@chagall.paradoxon.rec>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240701174539.4d479d56@chagall.paradoxon.rec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:806:d0::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4a24cb-0d8c-4386-8280-08dc99e6a10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T21oblkxVC9SbFJqeGZmR1pML21mUGNWdE0ySE5oeGdScGFrV2xhbTZ1Tmls?=
 =?utf-8?B?L1ZMWkV3L2xjNXdtYXZ0Nm5uNURIQVliR0wydmVUNWpaMWNlb3VtTnhRWi9n?=
 =?utf-8?B?K01tUXR3Z1V4dTZ2clVQeGs1WXoxRnNwSUl0WWVrMUwvbjFEMTlUZVJuWnAr?=
 =?utf-8?B?dTZVSmpNaHdrYk5iZ1lqbmN2L0lDYWpoNlZPSDlzcGQ3QjlHQVU1TzZvelUx?=
 =?utf-8?B?ZVdDUVVsQ0pObmNkQm41TFFGM3IvdzhRTWwwUlhzNnFBckNxaFhmanE5emNR?=
 =?utf-8?B?SmcrWEIzbXZkMGJ0YlRqbGhRdjhNK1VXT251NWI2OHBIc2V2SU1hbEg4SFRa?=
 =?utf-8?B?YTduQXlCTHFidFhwYWtGRTlrUHVIQ3FNZ0VqanpKTENHdjVnOXUvUk1oSlJR?=
 =?utf-8?B?TllldGxSRGJkN09TdFJSQW90T24rWlczRXhXaUZ2anJWa21JeWFFTXpXYnN6?=
 =?utf-8?B?SnFmRzFwWW9lNkNtVDlscWJndFR3RWoycUN6MkJaUHpRbVV5S09XZEJZM29F?=
 =?utf-8?B?aWVmQ2tPdldOVWEvRHVXVEdOdFZ5WWM2WUQ3WXJJMXZTaTF6Y2tGdEdZalp5?=
 =?utf-8?B?Skc3QU04bjExTmhyU0JuOXRENkozYXhLb2NPZDJtV1FPOWhrZmN1elppVkps?=
 =?utf-8?B?bG9RdUJMclhyZWVQby9HNzVxNGFsaGowWm8xeWNERHdOOU9rZU04VDBnR3RS?=
 =?utf-8?B?OGZTOTg2SXBwNXRCYkU2NFhOS1pYSVB1Nkc0ak5ReWR1UmhCcU5iMk5IQWxG?=
 =?utf-8?B?VWFxOTFCenRYdkdncVcrV08vSHlVaUlxdlI0ODh1bWczMncrd0dwQ1VhMXFx?=
 =?utf-8?B?OVlXbGFqL0EwNzFLWkNTZmJnbDl1dVJGZktuY1U4Qm1LVithc21YVlg0eWtH?=
 =?utf-8?B?dW5ScFQ0aklTRXl6aFYyeVN1cWNKOXF3UUtnLzU1QTk5M1g0N0hoaTZINHpZ?=
 =?utf-8?B?Rlk2WXFadHpzajUyK1I0Y1R2RmNRZ01DTCtuQjFQZ0tPekNIOTFhMUxObG9D?=
 =?utf-8?B?cU04N1JrdUFtTTlBeHEvYmdqK2dpUWk1d09SS0UvUnNiai8xT0wxbHQzMmEr?=
 =?utf-8?B?MzVCRGxnNFczblR3ZFUwdEM4QWExQVVqVzA2dXp0UkZ6cGxLeU5Zc0RHNS9r?=
 =?utf-8?B?OXVpL280VFloazQzU2ZSNGJmVklaYm9HQmN2NGYvVTBDeitjSjdndzdKZW5j?=
 =?utf-8?B?SmlPbzRGbDhoZU40eW9WZW4wY2xGM3Q5WjNaN0lwWmxScjVNWEdLcDlOZmsy?=
 =?utf-8?B?MHhvQmxvbStjL29iZVVLREp1QjJsN2tFdmo1L2hoRmZ5RFl0R05KWkYzZXV0?=
 =?utf-8?B?K0ZOZkpRSXJscmh2V2t0aHpVZzlxU0ZJaEFDRXJucmlpQ1RXUEtpR2duUlND?=
 =?utf-8?B?d0FXMUtuYzNJOXJXSUhpRjRNcEhSckJmdWhEL2JRbHFvQnZ5NkM2ZFdEcm9L?=
 =?utf-8?B?ZWRCSk1hQ3JERi9RMUNOZVdwOExHc3dSRGVuelBrcGVCYzZobDBrb29DTlhQ?=
 =?utf-8?B?cE95TXVTdG9mL1R5LzBsQW9ZeWR2TWJHQ1JxM016U01iL0tHSmhEMmNncVhP?=
 =?utf-8?B?ZmtNZGZSRDRmYW5weXRKRjdXTmhNbktsdCsrSGJDZlVUb3pQZ0VHQjdwazFF?=
 =?utf-8?B?Qk9BeGhFb2tjUjhyN3l0Z01HT1NDU3FYdUlvQXJIa29RRXR5WExPZ0dRbFFj?=
 =?utf-8?B?ZlhhNWkyV1hpV1RibWNmL2ljMGtuOGQ1bmR4bnNBd2Jla0dyM09odTY3S0pQ?=
 =?utf-8?Q?B4nI+xoS/d8HxW2ulw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDE0cUwraldvU2FpTG40djlUOUFZdk1NZnhyNk5EUUt3WjJRYzh4TktzYy9T?=
 =?utf-8?B?MXR1bzFoNHJBbnZMaWxjck5NdlV4c1Z1UHltM0xOaFE5Y0lreklMK20rWnhP?=
 =?utf-8?B?Qm1BdEtCZGtoalNSOURYYW9jWjdnb2Y5ZUtEejVlK2ZQK2ZKZEJiK1RLQVlW?=
 =?utf-8?B?bmF4WXB6WWR5UzBHNkRmUU9qUk52Sy9uZEhJZUl6YzZtUjdmOUxJbHJnWVNR?=
 =?utf-8?B?TzN0dm1vYWlidU9BSXFsVzFEdTVZZmw3RUt4OUdKR1BYcCt1MG9sZ1BBSERi?=
 =?utf-8?B?V3VlQzVXZklnUi9xZU5YYVJQWWNYaTJaeHNYODRnbWo2S2VTaFpNWlRwYmMx?=
 =?utf-8?B?QURULzVmWnBOaG1VMDVPKzkrcnBUNHpvRE9CdHB3TVdOMnhKTG9jcTJOOFIv?=
 =?utf-8?B?Zm41THJGdDh3TnNKbytSWU9WZDZvTkU1Y2djempDVmFLdDZxalpCbE5CNzVM?=
 =?utf-8?B?aUxJVVZXQm1vZlpTTHo2eDJUMjMzZUxCVWdJZkFydW5KV3pabFVRVDFNSytp?=
 =?utf-8?B?elpaY2ZMYlZNS0tOZmUxVGc2TzFzV3RLSm53SGdkWFJRLy9ZVHdkV29pR3kv?=
 =?utf-8?B?ZkkzTjBhKzhWNFM3ZmRPLzF5b0lWOHlKWEd6cXNsY0RGSXdNU25sTy82enhB?=
 =?utf-8?B?RjRvcmJhU0E5anBCbmppTEloRDBrRm1FSzJ1MmpoYms3T3BkVTBvRnRCenBQ?=
 =?utf-8?B?ZWF1S2w3c1NyRWhEd2lJN2k0cFV1NGZkZ0doeWxNTldWMHh4eE02WmRwa05r?=
 =?utf-8?B?L2JIWUFlanJSSjIrQTlsb3BwVHlsNUZ5YjNmVVZTT0hPWTR3MkQ5c1FNekgr?=
 =?utf-8?B?UFU1aloyTllrQXNZNEk3WjJRMk1TWEkzcFVpMVVFK2J3S3pQTW9TYi9KemIr?=
 =?utf-8?B?QzlZR2FLS1VidzJtWkhXTmlxYkZxejE2ZHEzaFJQMUozSnh6VlFBbjQ1bzVO?=
 =?utf-8?B?UmZabjFMT0QwdkhrYVROUFdUZ200cFZNcDJaRnNXZmJ6VG1IK0RvNVZaVTcw?=
 =?utf-8?B?TlIwaG1kVi9VaFk4cy9sNW5FbzhSeWQvMk1hS3NZUUVOTnczWVZ6OEV5ZGNT?=
 =?utf-8?B?SVUrS2kxTzN4anV3MXI1dnd2UXBOaWJ3N2lraUtwVG1rQStlUndnL3Erb3JG?=
 =?utf-8?B?aFRETkZpWit4N1lVRytJdXFyS242eDdVdkV1SVc1aGZ4ZlVsU3Rybk9IV1ZY?=
 =?utf-8?B?M2R4dmlFdW5RV1ZEbXJuaDVYaDFuUEJ5cWU3UFBkYVZ5NGpKVEU3SzVGcG9M?=
 =?utf-8?B?U2g0TFFpM2tNYnIydjRxSzVQY2cwSndZblMzWmlzTWdENDdITW1ncXo3M294?=
 =?utf-8?B?RkRHN1Z0TUxWT0xMc01sNUlXYUlrTGwxaEVGMURHNVh3R1hqajR6a0NaYTRh?=
 =?utf-8?B?NEZpMC85cWc0amt5bG9hKzVjeCs0S280aHhHblZyK0hWMk40ZEJxbklobHZj?=
 =?utf-8?B?NEdTQWxRSGNqeGF2N2pDV2xWTVRrR09jMlNXTzJZM0xxRDFQYTQ3dGRkQitT?=
 =?utf-8?B?empTZGNGcWtaZmRGeFlXaTBFK3VsZ1lVc0NXM2hiSWN4TERwMUJISGxUVlFk?=
 =?utf-8?B?WG1DUVppbjFKTnMrK0xzUDZrbTRBZEkvNkdkVm80dmtsK09HM1p3b21wMFhh?=
 =?utf-8?B?N0pkTzdsUWg2TXFLYmFmTWxRYStIRlA3K01XZmQ2RHVNQzlsbHB5Yk9TQlFI?=
 =?utf-8?B?QXhyay9nbHhDc3Z0bGRzdWg1M2lZdVY0dWpZWDJMV3V5d2FPK1NNN3FLYUdo?=
 =?utf-8?B?RW1ZL29JN1R4NUtSd1U0ZWFQcGxYUjFtaGRwKzF2UENzWFRYV0pPUVJ5SVI3?=
 =?utf-8?B?MVg0dmNZU2NabEx6ZWlKTjM1YUJ2L3VIU1JBTk5oRElhVTVpeEJNenBNQXRp?=
 =?utf-8?B?S296Q0VYbWYyemVYSTZhU1Z4VUw3ZkZkeDRtakpaV3ZSNVdSVlYyR29COVJY?=
 =?utf-8?B?clJTa2QzbVMxWlEwS3pVQXhUR2l2VmNReWluWXZDeEVCTm9vKzB1V0xLbGRS?=
 =?utf-8?B?anNNZ2I1WkU3KytoTnc2UEFMVjMrelI2R1htOC9wLzdFZVhCKzBEQy9rRU1Q?=
 =?utf-8?B?T2FjcW5kNllwTTQ0bGNNQjVOYTlldXNJRlE0SVh0Y0ZndThtR2c3ZUNQQ29R?=
 =?utf-8?Q?+SstDP4dliOlIbDN3ZQuXSutD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4a24cb-0d8c-4386-8280-08dc99e6a10e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:58:20.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiyK0WJBJP/YWJtBuYRNIaFO1bhgVi79nhtBYn3noCYtt5n+ayaGh3YQm5Rf6EPXguX1AZaWpwAZtoqmyDq65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

> I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
> issue. I can disable CPU boost with both kernel versions.

Thanks for checking those.  That's good to hear it's only an issue in 
the LTS series.

It means we have the option to either drop that patch from LTS kernel 
series or identify the other commit(s) that helped it.

Can you see if adding this commit to 6.6.y helps you?

https://git.kernel.org/superm1/c/8164f743326404fbe00a721a12efd86b2a8d74d2

> 
>> I'd like to understand if we just have a missing commit to backport
>> or it's a problem in the mainline kernel as well.
>>
>>   From the below description it's specifically with boost in passive
>> mode, right?
> 
> I have only tested the passive mode on all my Ryzen systems and only my
> Zen4 machine shows this regression.
>   

That's an interesting finding.  Do you know if your other system(s) 
support preferred cores?

Also as a curiosity why don't you use active mode (EPP)?  Most people 
find a better balance with perf/efficiency with EPP.


