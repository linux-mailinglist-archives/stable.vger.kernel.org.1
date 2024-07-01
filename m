Return-Path: <stable+bounces-56288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61991EA83
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064AC1F21B6F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE80171657;
	Mon,  1 Jul 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0muSbS0d"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607916E893
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870808; cv=fail; b=Xr/+zRt8i3SxxBWbeO3ZVBJVXbFhN4N3Kua21Ofm/R+EL4ZHlhgyyupXdZ35DYhCieENw6UFurc5cUdF6sEnhPJpSfnmv7nyzy8Oo6o4pimMCVjMDZ4olBBYq1F2dicMZ8ze8AWDzwE5eJXoJT4+uLhNFEDtp1BK9dKoPgF6WCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870808; c=relaxed/simple;
	bh=vStGsKUMml28itvN6eBkqr0EFlRpl2SM0C01C/hkSb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NTgLhRwbFVfGGMMjCdZzIFmXsdojNO2LZzocy0PgKg0pjZ788T4yX9qkxaovpyO7CWxba85p3kgJ6EBqudtQeNtiQx5dpKGQ3zDU0qndWhBRP9Nf0yfOsRa+FpC8msHWJJrjOJCGdUjDiiXcISTY1bT8ouCevfHFw6FWib4mtg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0muSbS0d; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cURelY11wckTA9QgVu6FDV0Z+EFaF9Quhh0AQma/qyL0zB692DzdhOtSDvqiHCE1eFoH5Tg8ymg+1JepdDoHn+grX1a3cxSYHGHVgLq3yh5KefWwRYd+LjCwrj2iW4ypR+Xo7pTvfkzSf5fyprSFRQqgnEUlrh/gLxVnphY1g0ishEvxtJ1Wj88r7HkotHqvdmw2zQkuIxdwECJ1ZsC3RQDUZ02+lsAUsQlBu86DnVoNQoWU3y5KHw+zZnQOyx9oCzoHv0Wsq9GOj9f53n1cjHW+iXzQidmBUcC/ig+lz435q8QfTRxaAKN90qcaX6X5jZ7Z3KRFFruYVoUw8rr0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nCsCA+mQ+MEsukiDPB7iFSgFyMwFI5hgP+MzeYtZpU=;
 b=IBnyif4QCK7y/aRPaL2T1KfyaXBqn9qpnnqi7WVf9RZjD2mtefm+pf9qy/5BwIDf7yefIRxFnxfPRu2skJ+kdE7IMBd5Rbdkcft/1ZixJjMq26uyybqllKqMaUUtw76x2tzpeynWVwLDYy0pY7JLzLh4lNeyBmhL/I/ojd87sCHvi48K7ncYBR074mCHmPfGCZ2+27NsHmSOSMRZS/do/u68E+O2LDkjEgOL8hv+uWFozVRv5isNSnAb9kbMFjioqNm8p/QSqKxbU9YiZrq+QUB0P+XdMO7WmLnaHH+l8uN8lWBrqU4MM9IzgoRbNxk+sR+V94PeyinScMv0kGU1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nCsCA+mQ+MEsukiDPB7iFSgFyMwFI5hgP+MzeYtZpU=;
 b=0muSbS0d2SHuyL1dyKfuXYtBjeZBTzsf7np4LM+inf31krrwltchEwVFchuDjVatmbsEh37EwZQKVwWpLTFUJIMqGH3D8qrDAX6/mTvoGFxgpSG+wkDr9D6e5ME/4lHT5I6VKBTmXLULJtgvTdY0QZo8rRjAH6DkNHg1FYGNKoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 21:53:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 21:53:23 +0000
Message-ID: <18882bfe-4ca5-495c-ace5-b9bcab796ae5@amd.com>
Date: Mon, 1 Jul 2024 16:53:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since 6.6.34
To: Lars Wendler <wendler.lars@web.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
 <Li.Meng@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
 <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
 <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
 <20240701174539.4d479d56@chagall.paradoxon.rec>
 <fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
 <20240701181349.5e8e76b8@chagall.paradoxon.rec>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240701181349.5e8e76b8@chagall.paradoxon.rec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0062.namprd05.prod.outlook.com
 (2603:10b6:803:41::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: be25b1a1-bbc7-4cba-d9d0-08dc9a183a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1Jyb2ozeXoyUmFnRUVZZ042MjJWYSthVG9Lb1RnWSs1WTRXa1BBVnhqVm85?=
 =?utf-8?B?V0hEb3UxanRFaFNkTjRBWXBVMUZ2YWNxZ3Nrc1RQM244c281U0FQZmYzcEh1?=
 =?utf-8?B?Z1Q2Zkhya2pDS1lMcmZDR1VwM09xbmVoR2F3bURNRDJuSytUdHorUGxza0J2?=
 =?utf-8?B?Tmo0aGdqaitkZHloOWs1eUFrTU16bGI3ZnZGZTY5dUFiKzN1aXIxNHJqdXRW?=
 =?utf-8?B?VWlrNDQvZE1RQklNUXZZbi9zOFFSLzVOV00zVGNTc3pVTENTT0hWb3c2ZFF3?=
 =?utf-8?B?ZC9lMjFXZzRrWWc4eEZ1NitnNTBPdDJNNWFkeDdGZjVuektrQndWdUNFMmdk?=
 =?utf-8?B?cDlqV1czbUhnbWxBYjY0bEszYkpaYU5KL1p1bnBKREtPSDIvUjBWaUZCanhx?=
 =?utf-8?B?RnJ4L24rdWpSZkk0em9FYmVEalh4OCszNTB3RFBBRGo3dzMveHBBM1FKS2lC?=
 =?utf-8?B?NUlMVmNZUzVrSFZGTE41WTdNWVRkRmZaVHRxK2lHblQ0RWN6YXRENWRqK2Ro?=
 =?utf-8?B?ajk1M3JWM0ppOGhBTjIzN01uTVkwaDFybFlKTXpaZjB0cDF3dVBTdDlOS0FQ?=
 =?utf-8?B?VnNSYXhjcVEvLzhwdTBOTDI2NnQvTE9JazNOaGdOczJFMXJkUlVXV2x0Tnhq?=
 =?utf-8?B?ZmgzVDRwSnd0UHlJbUJaQVF2V2k1MXlncTNZZmM0NTZQOGxXWmVlbk94dUlj?=
 =?utf-8?B?Kzd1alhITzJRUWZ4ajQ2UHVtR09PalhMY3MzTDZ2NHdIRTF4LzVlK2kwd0xE?=
 =?utf-8?B?RXFkVWpzL1FwQnkwWHhzTGJjVTJoY0x5dWdscHR5T3RwUUh0L3dKeGNuSlRG?=
 =?utf-8?B?N0VoZUQ3cEIrRkp1TkRKOFhBbEhzQmJqZllyYmJpTVo4MXNCN2kyNEk0RVND?=
 =?utf-8?B?VVdUMTFsWUtuN3JIenZLZ2JDQit4UlV3UUFGckVVRVVSNTFTaCtqcWRyRWpK?=
 =?utf-8?B?M3hTY2REVGtXb3BXUElCTWxuVk1ydERhNFg2ZUh6Y1lwdy9tTFgvK1c0ck9j?=
 =?utf-8?B?amJjQUtrek9DNUhpbUNTTHo2SmpUSUZleWV1M09jMGJkTDhlR2FsSC9samZj?=
 =?utf-8?B?TmFaYXRYRDBxdXprN2JDUGk5MFlkZ0cwcXNsalpTMHVEMzR3YmhrNEdlSDJx?=
 =?utf-8?B?akxPVmlYSGZhbm5SWmNTNXovTSthUG1DVS9HeFFGNVVCaW95TW8zME55WC9G?=
 =?utf-8?B?SC92L05UYTJDUkFZLzdkTmVnU3ozWUNQR21Ga0V5ankzTEJDV25UVTNROHlv?=
 =?utf-8?B?bnFFMklkYlU5Q1VGUDFpVU4veFdYUEUvbzI2Z2N2Ty8zQU5lT21TOWpqOFlJ?=
 =?utf-8?B?WGprQW9DNTJWMDdmS25OUXZNYTZ1aDNjcVBLMTUzZjhCWXgySmx0bmFZY3VR?=
 =?utf-8?B?REdVYmpNWWtuNG1xRklqZUJQU3hLSlVhNEl3Z0hqR2pzS2xMSE9vdC9velV3?=
 =?utf-8?B?SDZKNWJ1UUhONk8zL3I5MVBlU2VUNUpwRU5uV2JxWXIycVpDMy94cDhmdEtP?=
 =?utf-8?B?bWxaV1pCeXB4Q2NuRGZSbjQ0S0doQTZ3OXNoTy9CUjkrME9iU0tXcVBXYWZo?=
 =?utf-8?B?bGw4MEl1MnNXTkNmT1JzSnNMbVo3U01sQTVwek51YTlqQnhzeDViME5taytx?=
 =?utf-8?B?bTdMOVMvRUk3L3VLaENxUW1TTHJJUUZCVEVwOUJpM3F0azBQN0lMS1BFL0pX?=
 =?utf-8?B?TTVBOEFpTWVlOUtjL2JoY092VkU1cm4zZ3hvRXRpTXhvbEJrRGZzd0lYYU5N?=
 =?utf-8?Q?epBdqqaUFtV72YyyGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWRWZVBEZWluZUpVZkpWSnJrd2VZZXl2eG1qdmVLN0dFT2tzUWVpRys5REJW?=
 =?utf-8?B?amhDRnZEN0htVnN2VGZoOFBDaCtsZWg4ZVE5NU9nTjFwNUl3eE9VNFdwTnhJ?=
 =?utf-8?B?Y2JreXNGRDA4bkp4eDFTZ0VYTjhGT2dFS3J2R2QrTlZmY0NvNnk1RkhOMzl4?=
 =?utf-8?B?NDJ5bFhyTzQ2cUh5d2dDSEVGZ2E3Y0E0Mno3eGluaHhZVmhQUFZQOFNPOGJF?=
 =?utf-8?B?NmlpMzFEdlRqNUlhV2M4am5GZUV4OUhCTTJSYWlNRW5LUkE4TFFycEp3c3Jm?=
 =?utf-8?B?L3YrbmpJZnMrUEEvZU9wbHV0cDdQNFFzRXpRSEt0SmVwd2hSUXpueUhGV3M1?=
 =?utf-8?B?K2F3b01GUmQva0xhNCtLQTVWMHd6Q3BiQU1FU2dvTjlQMVZWVmFKQ2JEZlFM?=
 =?utf-8?B?K29icTRhU2cxY3YwYW03VllkbnYrc3hCYjBqRytkMHlCTElwckM5ZTVBUlBE?=
 =?utf-8?B?Q1AzdmFWMFBWT04vb1lMc284NjMrZTFnbEVvaVVkeGN5Z2FHZ1ZaeW8rNTB5?=
 =?utf-8?B?SXNMS0REbitqNGVDR0lRRzhhSTZjMTVXSW5DZXcvUmJMWFZGNnNYcHNEOEEr?=
 =?utf-8?B?SCtGYUF4UVRVMFZnemMvdUJTRU9uNFFhVlZYOVE0TWt6NUt3b2xzVjBmUzF0?=
 =?utf-8?B?cXN0bUlSV0Z0MFVHb2FZZlMxc3YzT0g4aGFxSUJ4RTRZU1d0T3czcDVWSnUy?=
 =?utf-8?B?bWpLcmhsNS9nU2x0TlUwdmJKSE13ZUM2THJFMlMyQ1FTa2RsQVloN00vSkdO?=
 =?utf-8?B?RjJaSDZITStYZmdsM0pJdUJHSEJMdzQzL1NaRVBDdUNWZkNzNm5OODcrV1lM?=
 =?utf-8?B?YU5ZVU5wQnV6Q1lDblpLKzBQMlFMTlN1QnpsWUdKajJsenNGZWxsbWxETHp5?=
 =?utf-8?B?Q3lRZUIycnZZLytJaVVVMHZ3eDR3YnQ2bm13MDcxZXE4bmY2LzFFa3lKcktE?=
 =?utf-8?B?Qzk3MkdzbCtVSHhQTURBWGw0M2FGSEtDdjhuTk94NEsyREs2RThaMUlqMS9i?=
 =?utf-8?B?Qlcwb0cyUkdqV0hKNU5saGsyMk1xR1BLV0l6eVc0SzI5MHZNd0hSajhhc2xI?=
 =?utf-8?B?T1pld2JSdDFBVTNPVG5lMjc1bWc4RysrUlgwUkYyRDZ4Ni82cnI5d2toQWlD?=
 =?utf-8?B?Rml3RjZMN0xyZXBibzQxalFTbDdNZ0c1bm94N3ZzUnJ6SkRXeUFsL0toSStP?=
 =?utf-8?B?blNrYUlvbzZQZDVja3N1NHZvTlhPOWttQzl1S0NpbENwK21lclR3S0xINVlB?=
 =?utf-8?B?R1phRUozaWNFN3d3TjRCeU96WEpYdUNXcS9yRFppcERnSXgvM0MvdHY5eSs4?=
 =?utf-8?B?WE9jQm5ZV0xCa0tSaDRtUXJxTnZIak91RVhxbm5ZcWwrQWpHNEdTOXMrclYz?=
 =?utf-8?B?S2E4TkJNWGs3RTlSb3FVSVA5cjg1SjY1SHRBK2JyUFUwK0VyZjJGdUVobE5X?=
 =?utf-8?B?M1lTd0JHZzJWTzVIWUJpOFNyK2tiOWdvL3Q4eFhvdjVuOE5ES1piNWFyem5l?=
 =?utf-8?B?SkZtVkp1bjgwQ3ZRaWpIMVdWbERmeVVpeEhIem5VUm9iSzk2V0lZNlU2RDFJ?=
 =?utf-8?B?SE5WdEhDQnh6bXVROFE4QndqVExPKy9JOFJmT0w2eHNCWXcrN2cwV2NHd05G?=
 =?utf-8?B?OUpRM3FLbUZJUndaVWlRZm40NGxUTkxvSmZ1cUhPdjkveXBPQiswQ1EvSlVU?=
 =?utf-8?B?MC8rNEJkTVEvN3hiTjBhby9GZHNjTEQyRVNGSWhyTnRkUlJrOXpEVWZ3VlRV?=
 =?utf-8?B?aWxxZHVYYkVaNGN6ZWh0dk5pMHhaQjBUUjIyMnhFRHczYnY0VDJlNDhjOUh5?=
 =?utf-8?B?R2xkR3dPT3pVNW9qWE5USnY1Mm55akUxSnV0RU1sRThTSWRCTGhDdGpOZkJJ?=
 =?utf-8?B?M1dZY3l1UmpPMWJSQTQ0VUJKbGJuYmlnZnhUS2YrdmxZRGRNVUo0TmFGNk5m?=
 =?utf-8?B?dDBxbm5iOHRNaHplSnBvQ2oyQUhYbkV0Y2pYRWc4U2FyVmNENUNrOGljRUVU?=
 =?utf-8?B?TXhtc0RFNVQ3YVRoaC8yd2IxT3I4QkJYL2VYTE55UXRBaHJZd0dZeWswNXE2?=
 =?utf-8?B?NWtVQmgxZTdzMmE2ZXlGYWdCRkJERFpvUEtKYW44cE1HODliNll1UWsvaDd0?=
 =?utf-8?Q?NmgxSkd5mexMuSRopGr1d7+lm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be25b1a1-bbc7-4cba-d9d0-08dc9a183a83
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:53:23.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+pCvZHuGOIMdnpOLw7qB2EApKG4UtxHMNKId52z/aFeO7DVasTggPEZ/fKIQwBgxBHq1tnRtLHwQB7Sf+S7sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

On 7/1/2024 11:13, Lars Wendler wrote:
> Hello Mario,
> 
> Am Mon, 1 Jul 2024 10:58:17 -0500
> schrieb Mario Limonciello <mario.limonciello@amd.com>:
> 
>>> I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
>>> issue. I can disable CPU boost with both kernel versions.
>>
>> Thanks for checking those.  That's good to hear it's only an issue in
>> the LTS series.
>>
>> It means we have the option to either drop that patch from LTS kernel
>> series or identify the other commit(s) that helped it.
>>
>> Can you see if adding this commit to 6.6.y helps you?
>>
>> https://git.kernel.org/superm1/c/8164f743326404fbe00a721a12efd86b2a8d74d2
> 
> that commit does not fix the regression.
> 

I think I might have found the issue.

With that commit backported on 6.6.y in amd_pstate_set_boost() the 
policy max frequency is nominal  *1000 [1].

However amd_get_nominal_freq() already returns nominal *1000 [2].

If you compare on 6.9 get_nominal_freq() doesn't return * 1000 [3].

So the patch only makes sense on 6.9 and later.

We should revert it in 6.6.y.



Greg,


Can you please revert 8f893e52b9e0 ("cpufreq: amd-pstate: Fix the 
inconsistency in max frequency units") in 6.6.y?


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-6.6.y#n678
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-6.6.y#n637
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/cpufreq/amd-pstate.c?h=linux-6.9.y#n703

