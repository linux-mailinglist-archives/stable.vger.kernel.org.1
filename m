Return-Path: <stable+bounces-106654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD6E9FFA57
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38143A26A8
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDEE1B393A;
	Thu,  2 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oRhiFBLW"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1018EFCC;
	Thu,  2 Jan 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827626; cv=fail; b=OnMgxNpldMKN1xPQtMrOpH/AHkbRo5nY7Fu4f0stHG4SuzzDgjLV9O6wkH6icSDveXmeuDjLQaX87dMD+hHYww9C3oMrXFXm5CuBbck6F9/bW71s6pmxNgaRvb2QsNhj/tkEvQYGh/EsPgzm3tiIXmDLU2p0+QyXioy7ac2VChY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827626; c=relaxed/simple;
	bh=5YCNmdQ1xo5CC0kilF1EKYsGM9rmXGKN6c+j3/tonEs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fh0f1KjNafvYFARZF7ZAYhxI1jKxtvYRJPhcpMXRFo61QUCpvFhGnrPfvQl0QTivakHTabmRffnCtuzfKjNvqLtBsV/aC/UwsKaihna5sXCBD54V6C2+xcF0VHdmp/y/aRMMmfA6UDPLAThqkfBJfBcNddZqNgNCmogbCs5guMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oRhiFBLW; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXcn8UnJZGPmhHca5SDn3mB1E3kQnsVWHYo9W3co9Y2oFlXF97IOFKV0+EZ7zpyWNPD1g/RVGsYPFLEGzl3Z3LnutxXZhz+C46UF+jhbWwWcH6cSKll13cXuzBPW2Dc9C5ttjJLiUyDaom8QgMULeMhTjL9WmNcwDRRsYByWbpDw6SvL1F2yID3rTvieOobleHCSh/uKjud3IPqRSUae1WlikPsgyPSoYq8eb3yP4WR30LMiEenBHaUaU+KLJRorDi8qH1/G+Shj16OjsoQOr/Xx1VEZd9kUGG5804hheEdpLKIn5uIb1GC03ad8scOcvNIoS1ItiDHQ8+KnQJMDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MRSpLdYvsAnslVa3/pR3WOUDQNXpZq3FnYcG14eZOo=;
 b=TOXt+x0KaPa5BEsIXMEuuf09Hlv1Gu7LG0M7/I/1tDFTjHJ3/WHGxuwMtnKQGlo2m3zgopi5RHTevWtuXlcYKGZ99Xo1r2oEuxUpy/isGpYfZGlD7VIAanFbG8XvkLLsUnDnCslLjAYME9Zc2x9/S83w/FrCujTacsOcFmaW219M2BsYuZB8V4NeH+itrOFv2MLYo4pQw13me5xpH29xKpbu6gJ1f55WLuDl8Jf5eEOgif2KSCoYo6SPL7xx2OxcLzD/DuVImzntoeoOVdfAQ7kh8BB0spXmAKywBaWCh5ogi8/IgPjL2mFd3aQIbgvnLkqqsEgSgd+MM5azjIlQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MRSpLdYvsAnslVa3/pR3WOUDQNXpZq3FnYcG14eZOo=;
 b=oRhiFBLWjBoaBEr50hvQvwft7wg6LN0M3MSwB5AG6Cqk+vDqn5s8DpnPBAOQ3nY8jqLQsBJsVErxeT9uakqvvnJynZ3M6llqxw7Z2kwlMDU3zXK0mx/+M0TLtLZhXcdkHxZHxIDjj6tttBUn7Y0/QjRKYxT4lkCBnVwsO7X8o39QvNuxnSXLruCCEBl0JgrJPYKh2cfiI0LqpRS5IbtNqQIgqmbPKT2ISLt1v5P/v2GT33xdOuf62FdTSvOvN1rvsU4/44OpAghnkc2GMokUW2Q2FTRuxvjOtAov5q4ReqN2M/cgMpV99cOR6I0opN1s+yqKlZ39tuCDBagGV+gGng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:20:18 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 14:20:18 +0000
Message-ID: <51fefb2c-6858-49de-9250-d464ef9c6757@nvidia.com>
Date: Thu, 2 Jan 2025 14:20:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] USB: core: Disable LPM only for non-suspended ports
From: Jon Hunter <jonathanh@nvidia.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Kai-Heng Feng <kaihengf@nvidia.com>
References: <20241206074817.89189-1-kaihengf@nvidia.com>
 <dd77fa22-fde8-48c7-8ef4-6e2dc700ef0c@nvidia.com>
Content-Language: en-US
In-Reply-To: <dd77fa22-fde8-48c7-8ef4-6e2dc700ef0c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fa01a5-3c55-41e3-a4ee-08dd2b389539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1UyWnB3RjBORGxEb2FsdjF1NnJ6c3lXWDBwVkVkSDZjRlpQaTdLcDhaRFZz?=
 =?utf-8?B?K2pOaWRYdk02ZFcvd3IvTmxWeXp1cFNkc3BtTWgvQlQwNU5POVJHNUM4S09o?=
 =?utf-8?B?cU5EMjQzd0RZYmhmSGdvc2NTS2ZwR1pZOVRXcVJUM2l0YU1hNlVZYkhpZGk2?=
 =?utf-8?B?SjgrK3lBOTJLNTNabmtHeGxkbys2U1ZvSHRrVjBYMitSZzExdEQvYk1WOTMv?=
 =?utf-8?B?NjlBNHg5a203VkJieU9MUmZsUENXdnZzMjZjSUlXaW5icXZqemRhRFVSdk84?=
 =?utf-8?B?NEdkK1BPVWFzNDBGeUl3TnBCdzI4Q0QvemlnYlNjeHZTY0pnRFBzVHQwVWNo?=
 =?utf-8?B?akhCbEZEOFo3MUpoQ1I0QnRiSC9XME50dzR1b0taSnUyS3lFS09BT0U3UE5Z?=
 =?utf-8?B?eFM2ZTFrT0NJZTRrcnIvSExDcUdXT2NnN0pSUWZvQS9LSEdJK05xeFRHenlN?=
 =?utf-8?B?ZkcybCs4blpVVnlHOVNFRDcvNFRmcGg3NEhLUE5reEZwS2hjMmwwclFjRm1S?=
 =?utf-8?B?UXFIc2swd2U3Ti9HNG5XVG44UDZrQ3FBSUlvcStHT3JmTW5NU05oTUlMNjlN?=
 =?utf-8?B?bUhkbjg3RS9pVnRYWlhGekN2VXJwZGZPUlZLYXlSSnduTnY4Ym5pZXMwTXBk?=
 =?utf-8?B?TzVlejRZWHZ5ZWh4ZlhESXhJM0M4SDJUVWMxTXo3cHFqNit1cCtySEJid0hI?=
 =?utf-8?B?cW12UkdIWDVKelVpdEk5dm9odVpwcjVUL0laMW5iNHFVUSsrblY3NjRFOHpR?=
 =?utf-8?B?Ky9YZTliQ3NDYXI2OVBZMEpKaTBiVDhMRzZ5MmxSVnNic3g5Q3pxTEdhUi9D?=
 =?utf-8?B?VDBzMTN1UFRGR1V4SXhTcWordHNwTk9nZ1QyY0FyWWh4UmxaSHU3cFVqRHFC?=
 =?utf-8?B?RUVLNWRmMWFJUWttZ3B2UkQxbndOZ1lyU0xPYzhvRGNKanY2WWFsd1hpQWZ6?=
 =?utf-8?B?M2dpRE0zSHc5SkxUd3RQT3pPeW1JNUNXdExVaHl3YkFJMGZCUkRhdDJCcWxN?=
 =?utf-8?B?SGZTUXBLTGEyT1hNS1ExUEpOam1WZU93VFFuNnlLYk1wLzhyazlRTTd4bVV4?=
 =?utf-8?B?UHlwSzM1V0s2Rkc1SmxmbCtCVVhNY3ptd3Z0blgzb2psVTdtakJJOS8xWFAw?=
 =?utf-8?B?RkVFekdjMDQ3bm1TbU5sTTI0emd1b1ovdEdhZkxXN3FETDhvcy8rMzBsb05M?=
 =?utf-8?B?bjNqT3pEZEZTYkF4d09zeXhoTDBIZVI1enVMZTRUM0t6cnRTeDRmQ3RjRTlR?=
 =?utf-8?B?Ulo0NDl4RWpvUDdoenZhYzRKVzhUQm1oR285cGF6bjBoTHFjTGlwaDJTczAz?=
 =?utf-8?B?c3hXemllZ2x2NDBucUpDdkhtVjk5Z05Kam9acmoxZXl0TkVHUHhUeFNjNHhH?=
 =?utf-8?B?V0YzcGZ4QUdCalM2Yzh0RytPSURwaXFtZXZjTFhUQjE0TlRneE5sbkFPeXJm?=
 =?utf-8?B?RVFiSTN0QlR2dFE0eG9Ed1NrRURocVdpVnV4WFBSNzZlUHg3LzJIcFNWRjl1?=
 =?utf-8?B?RFRleVQxVW1aVDhjeDFIMURmdGFXdUQ4L3lvOHRkOXVjaVI4a3pGYVNBRFh1?=
 =?utf-8?B?TjdxM2wyd3ZQblhRMWUrV0NmSlQvUXBjc2tkSHlnL3RDS1IxUmpnK2sxemFP?=
 =?utf-8?B?V2todUNhbHptQlpRSFEzUnd2WEV0Y1kvaE9aSForRkNiTThHYUJkb3dyU0JX?=
 =?utf-8?B?ZUk4ZFJNUnJnSEEwZDArNEM3MkowdE4yaGlZb01rekpUZlJ2Nkdrb0JZOGVL?=
 =?utf-8?B?ZlI3Y1lCRmlEVFdzbXVSZy8zZEYvUUUvaGxQaUJxemZuSzRHVGEwVDJ3KzNJ?=
 =?utf-8?B?dXgvNXgzSjQxZ2JoTk9xWTZ6UDl5ai9paUR5ZnZUclkzQjQ2YTMzbnVRa3ZY?=
 =?utf-8?Q?TfFhKaiG52sNs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWV2dUVuaGttci95MlBJbVlkRGsxdFV5djdudlg2SUFvc1RNVzdLYWJlemEw?=
 =?utf-8?B?Z0RIWU9iK0dNOHFXbWQ5UnAyaGdNK095Qlh4OGVkQ2hzT1B4Sk53dG5ORkNx?=
 =?utf-8?B?M1VRSmN3aXp5NnBrdXd5YzIxYVM1bWVLV1NmZTU2YnlGVjQ4bCtPK2ZXTk9V?=
 =?utf-8?B?SmRxZHNMNVdPaE1reHhzeGg1VUVHVE9HWEZYNWQrcFJuRnVIZ04vbk5DSytN?=
 =?utf-8?B?VStwb2R1YW1Uc1R1Um9lYUwzNWdIUFVjL1UwS0FNcURGS3hJcmtHclN5VWor?=
 =?utf-8?B?WHFYUXNDUXBzbTdUdXJPK0o3NS95Q0dyZW90WkFzMVRMVnQrRTNJQkpHczN5?=
 =?utf-8?B?QVIxQ3ZiWk5qenpFdURvRU5SUVNoM1ZmOHNxSnNHanF0UGZjWWV6d0V1alF6?=
 =?utf-8?B?S0paMVhSWXlXdHVxcjJVRkw2RXRMVGRpM2VrOGdGd3RIS3lTWS9tTkRwbml6?=
 =?utf-8?B?K1k0Q3VoN2JPWDJ2OWlFa1V1d2U5dzFyS01pTDFqaTBDZ3o1THpqTWF1MTFx?=
 =?utf-8?B?eGtGMFNhL2MyNkhjdkNjMXpkbTZkODZyNWJHYlNzSXF2dFpEUUVNcGhkSXN4?=
 =?utf-8?B?bGtyeVg1RFFySDhBY0xxUHA0elFSMlZXZjlaNUlkZ2VuZ0t6MVZGVUFlMHor?=
 =?utf-8?B?Q3plbjBwY3ZhSThJcnB6dW1VRjZpRUoxc2RJN2c0b3FMUVlGMW1HSVV4SFl2?=
 =?utf-8?B?SWo1WTgrdzEzbFd0aHV0RmpsOFBsbXRFcjQ3alBJSFRyM1dBZTF1R1h4RFM4?=
 =?utf-8?B?MVV1c05TSHp0dzRDQ0ZCc2RWWkdYNUtkb1Q3a0JwdnFzemFrQ0VHd0h1MFlR?=
 =?utf-8?B?VmRGZjdZd2JwOTl2RVcvWGd6dkJRRW1SRWxrdFpCb1laZXpSZlMzQ0NYalox?=
 =?utf-8?B?VTl6MmZaTElYVEZMWlN5WVgxdVJqSzRreUIzSnVTNDNaemlaUTVVbGl2cVI1?=
 =?utf-8?B?YkZma0oyb1VOT0pIZ0lSTm1nWGIzWkdFbk1KVWZCNzY3WDIyOFdpaUJXNmdM?=
 =?utf-8?B?T3ZnMGtXS0YwcThMOEkrNXJUNCs1cWEvQU1UOSt5TGFRWUtzMDEvU2hzTDRm?=
 =?utf-8?B?bEszRFBobzRKMTFBOW02K0lUV0FtYzBNckloM0VQdmsya3dFeGk2RUtLMzBL?=
 =?utf-8?B?aVl6VVJjdENqSjA0MEVPcjd4UkpuNkUvZE1nMm9kbHZYTDB0aXdFVnNUbWdp?=
 =?utf-8?B?MmNMYndGNVVTTFZQOVRKTnM4NGg3T0JnaGx3T05SMWFlUHpXT0EwRjZUay9T?=
 =?utf-8?B?V3BTdGFZeWk0ejVnOW15ZENGQlNnOXNNN2hMZC9HUStvWTZQOTNyK1RPOWhn?=
 =?utf-8?B?cS9FaFgvOW9xQytMSmRRU2RzMndaOWs1eElSSUlnUkp5TWJJNnZtSHVLQnVu?=
 =?utf-8?B?YnNkN3A1aUVvZ2N0ejJlL1VlODVSWE1ibmFINTVBS3ZYUXU3RlhjVWJtdDhD?=
 =?utf-8?B?N0dPMlhDRFIzdXdENjE1QjNvbFZqTTNHa2NFalZRM2NES1JwbTRnWXN5YXAw?=
 =?utf-8?B?dFBuZnRFNUR2RktpTUdXQjgzTE9vd1BldEpjTWFWdTNRYlJYemdra2xvNzlM?=
 =?utf-8?B?Z0JZcDRsWXFtY0Vtb2Z6VGc1djNWZDhJS3EwQzNrQUdLa2VUSU1kQ2lqTWRG?=
 =?utf-8?B?QkNMdUY2TjlZOUZWZ2V3NjRtWGVOYi9xWVNjcm15OUZnSW1xUDhMTE5iclBs?=
 =?utf-8?B?aHBjWVJDU0hUdzEwRmVIaHdhVGc0a2grdUs1MmMxNVE4MTYrUUZpb2pPM2Vk?=
 =?utf-8?B?Qm1VSnVGQWNrWTdCZllhVy9XSnlYWVgwWUVxMlp2ekNkbEdYTWt0TDlZUkFU?=
 =?utf-8?B?VmtndzhDeE0wZitKTFNiaGR4T3RWbTFucnpOWWhCa3pMSTZRTmNBeGpkWUFp?=
 =?utf-8?B?SFlwSjlSQ1ZsUHZJc1R0SkErcHkxQy9kajgxUDB2c0FFZGJOcmpTa3VOL3hS?=
 =?utf-8?B?bzR6MUNRSG5CUWdyaXB3RFYzVUhJSXUxSlprSlZmS2RPcEFGbWQyRTl5YWk3?=
 =?utf-8?B?U3d0WEZSZXpxUlM0TFZQWjlqSjRCSGlNOXFKQ01ZaVEzN3d0S2swbXdQZnBS?=
 =?utf-8?B?bTd5V2ZBZVBRaGV3TmlMOGNjM0V6RjZScGozT2l1ckNpMEEwWlc3NEhDYmVy?=
 =?utf-8?Q?x3r3bOdWc9joHxjDgqekN5gQr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fa01a5-3c55-41e3-a4ee-08dd2b389539
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:20:18.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua2lTc52gGGajIAdPlR2ZT9XGb7K3fBhNJlsxWkKsJFSvRUvoSzN7kRIKSNwg7YQCbAxMQ1dsGsUXZEZ7x+qyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

Hi Greg,

On 18/12/2024 16:21, Jon Hunter wrote:
> 
> On 06/12/2024 07:48, Kai-Heng Feng wrote:
>> There's USB error when tegra board is shutting down:
>> [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
>> [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
>> [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
>> [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not 
>> responding, assume dead
>> [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
>> [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for 
>> evaluate context command
>>
>> The issue is caused by disabling LPM on already suspended ports.
>>
>> For USB2 LPM, the LPM is already disabled during port suspend. For USB3
>> LPM, port won't transit to U1/U2 when it's already suspended in U3,
>> hence disabling LPM is only needed for ports that are not suspended.
>>
>> Cc: Wayne Chang <waynec@nvidia.com>
>> Cc: stable@vger.kernel.org
>> Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> ---
>> v3:
>>   Use udev->port_is_suspended which reflects upstream port status
>>
>> v2:
>>   Add "Cc: stable@vger.kernel.org"
>>
>>   drivers/usb/core/port.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index e7da2fca11a4..c92fb648a1c4 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct 
>> device *dev)
>>   static void usb_port_shutdown(struct device *dev)
>>   {
>>       struct usb_port *port_dev = to_usb_port(dev);
>> +    struct usb_device *udev = port_dev->child;
>> -    if (port_dev->child) {
>> -        usb_disable_usb2_hardware_lpm(port_dev->child);
>> -        usb_unlocked_disable_lpm(port_dev->child);
>> +    if (udev && !udev->port_is_suspended) {
>> +        usb_disable_usb2_hardware_lpm(udev);
>> +        usb_unlocked_disable_lpm(udev);
>>       }
>>   }
> 
> 
> This resolves the issue I have been seeing [0].
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Thanks!
> Jon
> 
> [0] https://lore.kernel.org/linux-usb/ 
> d5e79487-0f99-4ff2-8f49-0c403f1190af@nvidia.com/


Let me know if you OK to pick up this fix now?

Thanks!
Jon

-- 
nvpublic


