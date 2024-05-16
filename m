Return-Path: <stable+bounces-45320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57CE8C7ADD
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9B31C21496
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BF1487F2;
	Thu, 16 May 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foZZX/CR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A0BE4A
	for <stable@vger.kernel.org>; Thu, 16 May 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879414; cv=fail; b=bJ7UbhEV/eIF/ur01ICkE4CBDYO4ThCXn2NYw2v3r1I8Q1ECmjMm2iPJWqsUU51HuJv/2AVagDNWFvEs0icstqLrnvfGeF80EPAsHpd1iWTQdfCF6x1AiYAwvujp4M+xL6Z8KQG2V7aIPCXcKVbyGlK9jtXgkg3ou4HIo3/u0mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879414; c=relaxed/simple;
	bh=95JYZmb4TTw3RRYX0FslqvhLIZHrRyGW7zPYTazs2kI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/frTtkTuwK9QQjWJuza8Ydfl45FVS64uvn5aR+JKK8b8mnyeKCVU3LBHPy0de2mRNwWD+EDaEliXXkCoOHfyr/WkvYoa6Df/oEEg5qpTSSvHe0ge1AyuYMnkUj+qkl/z15CWf1F5hfh2VAY3prsPhypnBK+JdaiWEleeY/2P90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foZZX/CR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715879412; x=1747415412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=95JYZmb4TTw3RRYX0FslqvhLIZHrRyGW7zPYTazs2kI=;
  b=foZZX/CR8AHBFxgUMpfSruy3Tbq3fVTRrQdPBhTFP2uYkP76Gzu7BEFy
   OgN0Gw0NBVuThAeRrKRpK+Dfeo4lXo0ioACW8S756ayO1XNJOHUVFjdpV
   z2IUbQ7PvP0o+xLhzkqBrfbkjAI4ZKmHF8nv1ftjA8Ykm8zBrSxzJMA3H
   6Y6o4N8ch2IdUjQKtYRU9jBfuj8e/6oCw5KsIz1sos45jjGIBa60qrUAD
   3nikdY80hIFKxhY/C7PjO855ilLL9x08JHLSUW0EesNVs6WH29I+ryXFV
   KI3IFxe0mSQZDNM8TTrf0g71T7uvLWSETfPcRucvsfP4hnhd2ucdXZgaL
   w==;
X-CSE-ConnectionGUID: Ek+x2sKBTVedWF5oVyw/2w==
X-CSE-MsgGUID: 5PpnlIAVT4WaPiMswJ7GYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15837594"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="15837594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:10:12 -0700
X-CSE-ConnectionGUID: MxdR/A9YRqmi5nAcLg+prQ==
X-CSE-MsgGUID: e1vGHILWQUmpymalnD7sDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="32043528"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 10:10:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:10:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 10:10:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 10:10:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 10:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZfPdiUUWSSC9/+ZI1vK8sVSFoBRtN6T6Iqn73cnGBHwYcEYCAm7QPYpxCcAYTJP2nGoCkXT8BCvWQbM5p0/rUB3BaWsJcFQa4rGdpdUpm2+oUqKFbtphhjlzSWqO+CDbkZDGrF0t8nqIzNkOELqJ22j1eRYFfudk6VPlnFqXrix2WHuPJxGamZOdsZ7yV1PLjn92Jdc1sh5BABvEdPBLeMkAboCVv4Adnb3gdbtFF+zVAqL3oJ9g4+2LTjLH6vWAcMmRDIje+lNEpe60ELNpBn+/4KAI3pTX2udqt+GHCWXUcR6BaRAhnyXIA4bLRyx3avIx+iwjEJwzLPiWydCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlhH+0edLVLw8LBPOlw72G6BmGFHATqLDcotBt8/7qA=;
 b=KUmT5dlcVKvQzHHQDMiuHZWBVv3A//hT9Rn3t9X963Hgk7TjCEcChU4EMdAHq9pyQ3mRzrsyCKlzHE5Znp6Sh4uiFRLOvEVsoQZVieAHTW/hyXqVC3AJHHKHX9PrmevfNjOMJZgQpr4ZLy7FZcFbynCe/MbglW2qiKT+K8XfDKyU2ZLVhwf4rVeaxfdYGYWZtrPvmq/AAPPlmFtvQoFLYFE3Z2nmn+9zLSGhGf/lZ/g4nzYWn7RtaIsbhGTrzze+10b4BmIAxWAcq0G+0a7zsNOC7ATQr6SK08QW4bsju71Ip8uXbst0SPugt+QY+pcx4yJaeNOJL2oGi5cYQ5LP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 17:10:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 17:10:08 +0000
Message-ID: <0683ec3d-b0bb-4612-b64c-4808b7ec8d66@intel.com>
Date: Thu, 16 May 2024 10:10:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Fix Intel's ice driver in stable
To: Greg KH <gregkh@linuxfoundation.org>, Ahmed Zaki <ahmed.zaki@intel.com>
CC: <stable@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
 <2024051653-agility-dawn-0da9@gregkh>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2024051653-agility-dawn-0da9@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:303:b5::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cd7824-96ba-484a-beba-08dc75cb0a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RU82WVcyZzdxZ0FWTXhKTHB6WTNzS2NXT2p6RW5FQW1BZCtNZHZjU01PRjVi?=
 =?utf-8?B?a0pBWjgyVUNsemljbjE0bU9NWFJlLzNCMU5UQVhoV3h0SkJmZmZ6cnhZbGJu?=
 =?utf-8?B?Rm1XeEREbUt5Yk0vcVlmSHV6eWs5ZnN3VVMzRWwzTGFxZkp1RWhCa0pZdndw?=
 =?utf-8?B?QVFkWkFyV3l4VE52Z1BRWkY5UGN5TWJJTi9QY3JCMjZoSWpOOEpRTnJLUFR6?=
 =?utf-8?B?SVBvR2s3RVI1VENHK3lObkN2V3ptWUVtbTB4U0JtanZ0ZU5MRUpWQ0RaSGdt?=
 =?utf-8?B?KytHZVpLT01BbUQzbk1xaU9qanp1cDI5aVNnSk00WElQSjRLRGlBSzkvMzRM?=
 =?utf-8?B?OXgxNGtENlY1VkRaVENWemVXKzUwVmg0M1IwajFsKzZlYTNLdlc2K3F1dlFl?=
 =?utf-8?B?M2x3MmhVR25EallmNXNVYjk2ekMvZVBsck01MlhQbloweElUNG5ORm1BUTlp?=
 =?utf-8?B?bmZtd2ZoRnZLUkZnRGJSbURQd1Q2eUlYNEwwb05aQU1PMkNpZlFoZmdadzRy?=
 =?utf-8?B?Z1l1dmhzSXZDYnU5VXF2ZGxURUFKRWs0aXBQUVJsNnpDWjJTRzVtVk5LcWlH?=
 =?utf-8?B?c3RVYTBtNE5pREhSajlQcjdrMk0zWWUyMWNtNUZGcDN6MHNsSU1CQUdNampU?=
 =?utf-8?B?YW9saE90cWl2WUUxMSsxNnh6NXI2dEtDSjVnOFdqWDVVa3RBT2ZOK0dHNHdH?=
 =?utf-8?B?eEtUYUJXaDRxV0F6NU05OWxhSlRXQjBsT0tTa2plUHdHaXRjNFdyYjliYnJ6?=
 =?utf-8?B?VWUvWFphNnM2UmtCN0VHYjFIWFltSEpzNEoxWHU1Z3dwZTZNd1RJVG5yUEE0?=
 =?utf-8?B?dTg2bGJpSnNSejMyUjVodDc2cDBUU3lKbElvajF0bTZsSHpBb0k5REF5ejhE?=
 =?utf-8?B?NVU5a3BYMkFONnQvSjg1ZlpEQmdXeWg0OWRXcG16ZDN4ajZ2UHpPcmtzakc1?=
 =?utf-8?B?RGpNRld0OWhrU2xPZWRFWjdDc3B3Q1l4L0VVWGxMTFpnNEVKQmh1L2RyN29H?=
 =?utf-8?B?eE9heWM2ZzZQTEkwTVIzeXJtTmVhTU1FamRiRUFIMURhVnUyeGVlbGV6aW1m?=
 =?utf-8?B?ZmJKS0dYSE10a2VRa0Q3Tm9KTU8vWDFvNThFSWhmYm5Ta0d2N2VGY1psek54?=
 =?utf-8?B?NFVyQXNJUFF2bXJobnF0ejZoWVBFaFIyY2twZkpYSlhsMlZwQzI4d0FIdzFW?=
 =?utf-8?B?Z2szMXdRRFBlSkZsNjkzc1hKMTNGQkZjbVp3ZUhpeHRUcERZWlNWYmkydGFW?=
 =?utf-8?B?YVFjaHp5OHVzVy8vVkszMktmWG9aa250eDV5UmQyMHpwUWI1Ulcxd0krTFZP?=
 =?utf-8?B?eFFha0V0OG9DM29BVXBiWFViZ1NhR1gvb1JrYUZqR1ZndU9XdmdLTWo0Y0xj?=
 =?utf-8?B?cnRQYmVhY0QxNlM4WmcrZGxUMnN6Y0FSaTk0VEpyMm5HcmIxSVVzSzc4bDVG?=
 =?utf-8?B?TUVzMU9KZXdIWG16WGJwV3JxWXNVRGlycCtSK2J0ZVFkVEJ2K2NQL2d1TGJC?=
 =?utf-8?B?VHAxU3lyczdRdGFqNEpWbUJpU0FrczRXa0VCQ2krSjA5UmxPd1lwYm45NDdy?=
 =?utf-8?B?N1N4LzF3TXJGOXcyY1k5Q0oxNkhwOTh6dmFTVTVvN2cyTUpEVTZrWUNsNnUz?=
 =?utf-8?B?NXg5WEZsVm02VndHaGRQSkcyZjhFYVQ3aW1tbElXcVNNSTV3VENONjFQaHEy?=
 =?utf-8?B?YjVLdzdNYmlxMjkzcUJVbGx2KzhTakJhV1ZZV3ozak9qdWN0RHFkTFR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2hPZE9GWnBpZVNOc3dySm1VNWhsTWJCeTluS09objcwTmFmTlY1dUhjRjlF?=
 =?utf-8?B?NnJvdS93YVRPUEFwQ3dsV0lQRzVNR0ltaVZ3LzNJdUdKM21ScC8rNkZsMFYw?=
 =?utf-8?B?Y1AvVEo3UHFZTGpTMGdBS0JtOVRCTldpRWdGbHJyZlUwalJGY0tjUWRaK0dx?=
 =?utf-8?B?alN1M25TNmJNYUZ3WFhFTzFrZWI5RFduV1FVUnJKRkJjQU1jNW4zSC83dFha?=
 =?utf-8?B?MGpZZmtLaEtoWURHWHJSY1hCWGtDdUZnd0xYWHg1UUZoVmxic29teHBxMzRN?=
 =?utf-8?B?TzV2Y1N1TjZSZGtuZUw4aW5DN05LeXBiMEwxY0d6b2VnRUpLN2t1L1NVWXVK?=
 =?utf-8?B?WjBXKytiVmRzdFJrTTFmeXozRUg0c2k1R0tUUTE0Q0pSWjR2dmdWWnBRVk1u?=
 =?utf-8?B?ODNWOTUzOW9IRHJwcVhiNVMwbnFjN2dGUWxWL3krVHNqVnRSd3RzdENIY21L?=
 =?utf-8?B?cGlSejQyeGxWTnBFRFhmTnNZYnhFUTladC9PdWswd1NNNXRYaGhoU2FWTjhK?=
 =?utf-8?B?b01xMm9TcG1zMWJxUW5DRmFRTE93SC9UZzB1OUNlM1dvQ0dlMDNYUGczbnBQ?=
 =?utf-8?B?cWVHU0owaU1lN0pMT0IzT0ptemZ0TVo3TS9MdWRuK3V5Q01NVk5VNEpCQ0wr?=
 =?utf-8?B?elFJVVVpWFc1T3RpTTNscTd3MTZwa3lDUGtseFFBTVN0TkRpbHlxdUs0c04v?=
 =?utf-8?B?Lzl1VHJOWCtyRVNucTFPZnBKNlNRcE1LVnQ2bElkcHBWTE5GMjFBQlFTVWYz?=
 =?utf-8?B?VG81Vng4VlNTVktwNTFmWFQ4VEF4UEFVc1d0eFNRSU1NUkh5OTdjWnR2WWEv?=
 =?utf-8?B?bzRBLzBkeVVYK2VQQUNOaUdKeVNIb0Zxb0FhaHBnU3JqMWFydG5aVW9rQWcv?=
 =?utf-8?B?TkVudkplMmkyWHJzZWZ4eXhvY2VTcmE5TzRkRHpkM2VxbDBwYmZONEVtTlRy?=
 =?utf-8?B?MCswbjI4SXl0Tll2aUFBMmVCWWY2NlFXWXhoRDZNWFVHcmZIZzhDY2d2NUV2?=
 =?utf-8?B?Vjg0N1ZBV1M0bkljeGZTckRWa25BM1NQS2pIUk42UmsvWnBiTHVHOERmZ2dK?=
 =?utf-8?B?WDhoS052eGc4NzNoeHIzSnpBQkhiQzNKWkFaS0hIakh1bXIxaWdLbjZFZWFv?=
 =?utf-8?B?U0xJN2IrTitTK0V0cU1jOWFPVERJc0plTUhyNUlNZlFkYTBJY0hvbFhtajJs?=
 =?utf-8?B?QWhuT3Eyd2xrREg3NkVCTFpUdUxQV0VoK3c5RzJacFpTV0ZZN1ZtTG5idGFy?=
 =?utf-8?B?bThKQ1M1K25DUWtnNldBMjNQdHlLMlJtSWhWSUxxSmYvd1NVekJjUGV1NGFJ?=
 =?utf-8?B?U0VVYktWSXkrblMraHUxM0lhbVk0VnF3R3dUa0FIazZjRm1yVHFBRk16eVNQ?=
 =?utf-8?B?Q0ljdVFlNjdlNGI0NlZwZEVEc3hRMGFLTzA3Y0g0Nk5Pb2JlT2M2LzZmVkho?=
 =?utf-8?B?cEpHTkJ4YmUydm5XbnI4VUJXcHFoRVMyV29zazVQQnlwZEt2WUZxaXY2NkIz?=
 =?utf-8?B?UWpaSFRYNzFEUzZmTTJEYnljOWU1Y3dOZW4zOEpQYy83THhzU2Y2UDhjWEVw?=
 =?utf-8?B?MkdOM2sxYU1CYnFQdXRla0piRTYrMXdUT011dEFsdUhJcTFMQnBQNEN2OWFT?=
 =?utf-8?B?NUtiVTFLR09nbUVRUXNTMGdGRWFDV2RDZnAvK1NvdnJCWGJkajgvb1JuVytt?=
 =?utf-8?B?TXh1eFBzWit6Tm9Wb2lMdFFYMTBISHAydGhhTDJkM01GZ3NBa2hUY2p0cEFM?=
 =?utf-8?B?MnN6RlFMV1hpTWtiNS83WHRVVWFza1g4Z0hFNnpib29ySXkrRDFDcjR4dEM2?=
 =?utf-8?B?SnZ6ckdSSUZ3U2F3NGkvb1dDemh6ekNkNk1OaDA2bnFoNEk0ZFZleVpsaUZw?=
 =?utf-8?B?OWxPSm9MSTZmY0pUYm9LbUJqUWJqZ2xYS2ora0xMbGtLYlBRb0JBalBueXhB?=
 =?utf-8?B?bGl0TSs3SEdPTmNHSFRPVWovZmtNREtzTUVxK05IMkk4STlYdVZGWkx0d3hU?=
 =?utf-8?B?YWtBRTdxOGw4aGtnR2RQMWMyNFh2RE1zakJCZzJscXVvRURaTFZuOXF3MnEw?=
 =?utf-8?B?UzRoZHQrV21halNudk9VbFc3VzF0YUtsTytDVlczcUxGdGNzRlBRSVFTdTZO?=
 =?utf-8?B?ZHdhblBIWDJvNHFxZ2xveGJxREZRaXNkRW9hZnJ0a0RmdUxraC9WZXZrY2Js?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cd7824-96ba-484a-beba-08dc75cb0a0d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 17:10:08.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBABcTsmcO9nE6+tn2v9EP6AIcIB68tDZzbk29WkaySqH64RnP5GPKymFd2/0NoAi3nOKGMKeAEOMcDluD3TXUBERegSLuzAOZrb7GlXHC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com



On 5/15/2024 11:44 PM, Greg KH wrote:
> On Wed, May 15, 2024 at 03:16:39PM -0600, Ahmed Zaki wrote:
>> 2 - applying the following upstream commits (part of the series):
>>  a) a21605993dd5dfd15edfa7f06705ede17b519026 ("ice: pass VSI pointer into
>> ice_vc_isvalid_q_id")
>>  b) 363f689600dd010703ce6391bcfc729a97d21840 ("ice: remove unnecessary
>> duplicate checks for VF VSI ID")
> 
> We can take these too, it's your choice, which do you want us to do?
> 
> thanks,
> 

Please pick these two up. That will solve the regression.

Thanks,
Jake

> greg k-h

