Return-Path: <stable+bounces-89514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC599B97E3
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F668B21001
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F21A2658;
	Fri,  1 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ldf1t0lg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAC14E2CF
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486996; cv=fail; b=AV0vbD7a1xff5m95QcdRXUtu2AVc1Vkye6kOyQTR6AxVzdSlAqrTfnc+0IBm58fZqPgGEU66i0r6uIrQVGqHcolZmmF91QUJV+SYP+FVqAtIbgA590S0fcSVAYxOr70qN4O+7PqXus0lEvrVjpHSaS//KZzT0t859fBtAa/e0wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486996; c=relaxed/simple;
	bh=5M27XlpzcAyddLKa4B/nmX1Cdg/6ikdvTZ1tDuxPyc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cd6FSbAmB/4q+xGrtVhNeyIFewDz156q1o3JeC+SO2vbEAFfSOI62MAxbKT/K4Kmr2gCInO/bkBUsA1FYYX0ffSF33w4NdxUj2B4GjXymweU8RAq8w7xWIPuSiQcwkdQcugMoAfVuSMsQ+hXyy5DosBMhyOcT0LXp34N7DA4yEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ldf1t0lg; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730486996; x=1762022996;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5M27XlpzcAyddLKa4B/nmX1Cdg/6ikdvTZ1tDuxPyc0=;
  b=Ldf1t0lgqjKn2whxOoXxINMl8nIU8YelbA3rV/gN922n3H8jScH+y7zC
   nNE8NRwBvfYxRgkdlj4r/kwqBGv8ImpyMg7yomYpKnC07gA9UHMazu8r3
   UTBIBCkB6po1DfYeyB5Otw8ZylJtVeDOl+bCZDjz147ZVXzf5G8ZTQRNg
   qe/EnOJYbi6+ss/TO1HbOHW5SWqfkVQVVHkR4Aa8Dg1N8QwGAmfejnp/x
   sdsrSQIecnnFzr2fe+uzpwkY/nvgbEglC6Y4BzSesUEqOab12FpozOoqW
   AHQ+0uIe7v51WPCr+3tm5uejmcVUM495NHU7xOn1/GXh1yzpjgXWXi0o8
   A==;
X-CSE-ConnectionGUID: vslls7j6TriO2Ai6UOF7Mg==
X-CSE-MsgGUID: Z/jDxKCgRYOTVJoN/zju/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34054474"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="34054474"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:49:55 -0700
X-CSE-ConnectionGUID: CumAgwKyTcWJWwYKuuPA9g==
X-CSE-MsgGUID: APLWue1QT76XypBGLUo2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83385570"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 11:49:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 11:49:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 11:49:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 11:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxHhv0CmkPFvB28x4JQas0CFi03kYEwT3acnnWptqSILSPwsMhC1jPNR/4acWLh0uBIEBDJGF/unOtA6cbaV6vFDoUuGtZhb/zeX+txNsKEBXkWmfG57CTQof9/kAqcra/1Rq9y2xoAVQ/8VPJlHcPaQVgCA5ET1CT/lrYKQK0REJfFw1HFQxHgu3mFALkzXrNoZh80Kky55qc/3emU7aD3lsFwKAmudt8QguNrqhHd4dT1/x/njtZ4euAP8Aehl2iUk1OQriroPgMogyzRLbZG66F8IsjtkE6KRchefOTvWU6ooQO3vsYjo+zQ4IG9pEZbhPCP1cPZHabmi466Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjDzZaKLBzShyk3cqsnNNwoSHItAXP7kdx9KJsIMq58=;
 b=LYcEt+RVgn/JHeGGV+y1gCZGVZo2ilGc0pVkUzax6xR2Rylytsdn1Op7uJ8mNZXFN2BedSZW1FuIoToXMaXxMSq/3vaKqycuHCmqewdXV8QDDAHUhBUX1sTCzBYxlHHNrONcN70kEQZRNFAXuuq+GM4OSmp3MQKl12DzcJ5WomB0M5jUI+12pi7txlUr8SllRnLfdq2HMcDe6o1+bSo6KYVOSXL2Ghao7sDMQUraxUxC8ocLoiRQ8ghJDs/mHkBKyKzxDsXaPqLAm6qbbpq/bN30ZEickK0zSD2Vr4RF+GNZGgIt3roGeaovCyBsOiHC5xay9pN2eNL1sh+Rr663oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Fri, 1 Nov
 2024 18:49:51 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 18:49:50 +0000
Message-ID: <30f5ef7f-f58e-4c9f-a5f4-7a487f9b7fc6@intel.com>
Date: Fri, 1 Nov 2024 11:49:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/xe/ufence: Flush xe ordered_wq in case of
 ufence timeout
To: Nirmoy Das <nirmoy.das@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Auld
	<matthew.auld@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <20241029120117.449694-2-nirmoy.das@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20241029120117.449694-2-nirmoy.das@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec48e5d-8afe-4253-f508-08dcfaa5f741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGYyL0hTOFdsdGRYQUlHZ1ErazVpUkhDUmp6bFNvcFJrS0ZDNE4zanE3WTRo?=
 =?utf-8?B?d01RZkZQcHNsTlFrNW1ycjVZYjQySk9oNmtrSkpsRVhuYUlmL3NDd09SRXYr?=
 =?utf-8?B?eEVzZFExcnRpa2JvQXhaVU1NbUFZbEFyZURUTFJkQlp6b1dyeXN1cmlFQWc4?=
 =?utf-8?B?cE1NYVNnREhJZzlMcGtxTnF1eTZ1K002aXR3YldnczdtbkxtWm9qdFdDQytt?=
 =?utf-8?B?Tk9UbHQ0b3hha2tCYjc5TGpkMmZHaG9tQlJmbGZqaWNCbDlzN3QyTUZZTWV3?=
 =?utf-8?B?eEtaRWhKc3VGc09WaFNLZXBkSXYrU2o0YjJCcmYxeGJYNkdVRjJBR1MwbHZO?=
 =?utf-8?B?QTc0ZkVqTjNzc3kzbDBoWWgwUXcrT0N5LzRVbXZ2ZGd3aGptUDNnc202bU50?=
 =?utf-8?B?Sm00b0lseE5CNVhja00rNU5DamVhdkdzbFJVT3E0QmJDRVdyWXhnZ2tOODQ1?=
 =?utf-8?B?dzlnT3dhZ0tFSlQ5K2xaZU1vVXc1TjBSbzVuWXBoWkJDSTg5cmRySFAvb2xi?=
 =?utf-8?B?Q09qNlFac3Ywcml3VG5JNzV3UGxQVU5aampDcUZ2UjN0WXdkeFpVZ2RWb0Ni?=
 =?utf-8?B?dFhtU2xQaVkvTG0rRS9ZbDlUNmpRZkFleGhwaUc4TVhTWXVuaTBZaFZuNU1W?=
 =?utf-8?B?WCtEdWEzQlNoYXhyTC9RbmdCMWJ1R2VqZ0VjR2EwSUhINHFTRmtNUlM1Sldz?=
 =?utf-8?B?Ym1JSld1c21ZakpybG5rSk5jQ1Y0cTBGZXFrS08wVXBoQVJwb2JFM0FjYkpJ?=
 =?utf-8?B?Mk5BMVA2QUZwN1VXRDZZSXZnYStMeEFoclA5dkZLS3dEWjUxaStoM1ZXVXlX?=
 =?utf-8?B?RUY4WDc5eDNkR1NKblQ2Y1ZlRi90Z3ZWbHZFTXA4bTRvRHRrWVJnNzdXa2p6?=
 =?utf-8?B?TFBYMnNaUThWTkFOSnpIbmlUSlV1MGV1Vjk3bTJITkkvTDhnZGtTSGZsRlhJ?=
 =?utf-8?B?YWwvMDcyYWNCV0RMMVJjdTB0MmJMN3kvcTBDMmh1MkxRR0Rtcnh6MStRUVJX?=
 =?utf-8?B?SE1za2RUdHNyYlJJajdaNm5WYi9uangzeTZSdm1NekxaTkY0RkNZT1p0eWNF?=
 =?utf-8?B?SGVNMUw5MXdNc0hQZlBCU1I4WWkxWXVKZUZNV2tNek8zS0JkZDVTMjRSdzlF?=
 =?utf-8?B?SDlNUW8raVlRRW14WEhpMjgzWWJNN0llQmE2TFJza0RkYjhadXdjcjM5SS90?=
 =?utf-8?B?RmFqb0xHQ1ZVdHhyUk9CNkx6TWpaL2FabTZkeXlNNUZmS2o5bDJGVjU3OTJ5?=
 =?utf-8?B?NkNsWnNwSFhPWlNRUDNEMlVpN0F1b3FRdWRuMlk5Z1FrTDl4UFFFSGc5Qmpv?=
 =?utf-8?B?MEVUbEs1UE1YYmVsbWs3K2RFYjZvaEpvc010cWdITjJ5LzlRTWtGanZ1ZXZQ?=
 =?utf-8?B?VUZtbGcyMVZ2REgrK2dja1lIQmgzVnNPc0ZsVWZmb2tBNzBwTGF1YXZDSUQx?=
 =?utf-8?B?ZG1KbkpwOURNYjdqR3FtRUtaeFN3OCtubzQ1Z2ZHUE9Xbksvd2lNTDF5cUsv?=
 =?utf-8?B?NVhtQ3FJRlNOaDk2ZnFlK3JUbFBab2llR0xFbEZXMmN2b0orWVN3R1VsdG5G?=
 =?utf-8?B?Z1VLTU1taXJYTlNwQUNnWmh6Q0J3VWc3Wkh6RmhNZG55WVFuc3dxQkYva2RO?=
 =?utf-8?B?aWlZeTZvWXh0VUxPcXRVNG02U0NOWHl5K1k0ZWJrZWgyYlE3WDdrQnJTSWor?=
 =?utf-8?Q?5I8reaju9ZxjZdcgY3mn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ZTZVd0Ry9TM3hMMXprYmRTaE5aQUxZaXZvcUhJVFF6bHF6RjlNUDlrLzZF?=
 =?utf-8?B?djRaL01uTjJFcWFXTklhaXdZWUd2QjNTWVpzb3U0ZmJEZmlVd1AwZnNMZlhZ?=
 =?utf-8?B?SFpBL3VzaXp1WWEwSVJXOXVtQi9BNTFzSDB4QkFucGhCbzBkWjhnM3NGVWww?=
 =?utf-8?B?OTlhL1NCd3BHNHA4SmR5aENjb01RUEVkaFV5eTlNRFdtUHc2MGV2MGRPZlZT?=
 =?utf-8?B?ZmNWdU5wWWtrN255TzZzTzhuRDZ0OE1jdkdFdllSQTVtdTZleXYxdStjZURa?=
 =?utf-8?B?bzlIcUNUZWsvV2ZEK1ZxWDZSTmxzT3d1M0Vsb1ZBaDZ3ZTFwS0FmcXFsVm9i?=
 =?utf-8?B?aGxYT3dFeEFkVUdMNE1KZThEY3Vwcm5PdCsyVHF1T09SZUJvWVRxL29yRng2?=
 =?utf-8?B?S2daQm5OeklIRzRydFljMkx2aGVaOVBqR2JKNW1ZT2tWQUxIS0s5MGJzTzZs?=
 =?utf-8?B?ekpOOHFUWDRrMFl4MGZNWUVqOERVYU0zZ3NMM3VyMnZlTFZxQ3EydlU5NDVN?=
 =?utf-8?B?OTl3ajFUSXpsakNHUW90Y01UdkUzdm1LSEZLZ1RuMVB1RGNyL3RMOEJzN3BZ?=
 =?utf-8?B?SXlyL2ZCMkhBdTN5TXNuc3h1NDhZSjZtL3FlaVN5ZXhEZTMrcGRzQTNPdGNZ?=
 =?utf-8?B?NmFDRDlrM3NoN1pqcTBNbDVGQURxeWdKOHpkNjNKN1FCZ0UrNnVWREtvbDBM?=
 =?utf-8?B?S05DdU5nQzh0YUVaK01CZzY4eDIxV21BUFdDb0RFM0JkQ0o0N2lac3I1Q1Zr?=
 =?utf-8?B?d0NPcWdSazZSOHB1WXJpek1HRk1qYkdUbGlja3JKZzEwU2lQR25lcE5DWjJh?=
 =?utf-8?B?UUFOZ2NCaUpDSVNmMzJGYjJlbE5kS0VxQWU5cW1kcm9zQ0V4NmJlK1k0U0hP?=
 =?utf-8?B?cFdhZGQzTlJaVGNhU1o5YWJZbmlYTW9VZEV0bEdxZHdlMmw5RzZmVUZsa3Zh?=
 =?utf-8?B?SXdGdnh3UGpHS25sclIzbmNQZXRtbkFhSFJoYlFGSkFKNStUWERINTh6ZXhR?=
 =?utf-8?B?UWdoUDgvNWVwTEhDL3g3cDFRaXBRaG1KZSswczZlaDcwU3V6UWJHL3VLV0Rn?=
 =?utf-8?B?Z3dNbkNsZlF3aFhOZEJmMGduL0VvTWhNNmRYRlBBTE5EbnBRdlB5azhBQjEv?=
 =?utf-8?B?WVRoUStWamtKSnFrZ3Rqa2E1eWM2QjdWOGxzbk1ibTFNVHF1dVAvUWwxTUZl?=
 =?utf-8?B?OTdXMWUxZXErRG50bVJHTUZaOWRvV3B1R1VzTzJpRnBYWkpZSUZYRi9zdCtt?=
 =?utf-8?B?Vy9oTnNYdWpjZ1o1MTYwSkNGNnhIQ09FU1JqdVdsWWxHQWpPcERkQmhiZm1u?=
 =?utf-8?B?dnJ4bVRzSkFoVkI1MFMraTU5aDRqV0ZreUpQckRVa0toRWdBeXNWeEZWTjUw?=
 =?utf-8?B?akxMMEhaQ08wZUFKdHg2UEs3a2s1T2x3RG5nd21wV29lamxFQnN0Y2lXSjli?=
 =?utf-8?B?YTMzd2RvK0liaW5pZDRObnhRcTJnYitRYlR1UWV4ZWFsL0FwTzg2VkdOMWlJ?=
 =?utf-8?B?ekhtZGhxVFpDbzd3Qmxtb2FhUEhQdStySVNNOUc3OVF1cHgxeFJXSTVPRUhZ?=
 =?utf-8?B?MkJacWc3SFdGaUdQT2g0TzRuSXhxL1NaNTdQNFpaWmhYQVllVFphWVhoL2hQ?=
 =?utf-8?B?VlFONFQwZ25jeVB3K2xsQWFGZ2NRV1pNWk1wdllzbjduN3hnSjNOSVo2Y0Vu?=
 =?utf-8?B?TisydTNXSkgwenFwdkw2WldLQjdFeDBsYWtocEtYd3hkYU45YTFHK1pDS2NP?=
 =?utf-8?B?TTl6RzJqTkpqVXRUSUdPUS9RQVJVOWhONkVYTS8xTndlc3V6ZU9CQ2RxcWxa?=
 =?utf-8?B?MnBiUG1XUSsrV0VDWkNJR3B2d3dZdkl3NEthZUNrMkp3VGpYOUk3bDBlRVJ0?=
 =?utf-8?B?c0hhRGNVTk92eUNlYzQyb1hLWC8ydGlTNVJHYkd2K25JdmlZam1kbDZtcmsx?=
 =?utf-8?B?SkhXNy9LaXhTUkZkY3U5U21yL1U5a20weDRpdnJ4bzNrb3Jzd2pmU3BOL2Ji?=
 =?utf-8?B?S2FTQnhYT0ZRV2xQQkFKTmtkdmd6Wi9HMW1rL2NsNUFiMkhzQXVJZUlwL2tL?=
 =?utf-8?B?cUVEU0t5QXJOVWVnQ2k0TVdEZ0tlMmpaaGRHWHBkT05NRjBESE1rNVNBQVNW?=
 =?utf-8?B?VEdlVExkWkQwSUhvY0pLUGE4Q0o3ZTVadytrYmM4M3Q0bi9saFBCZkJLcWRL?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec48e5d-8afe-4253-f508-08dcfaa5f741
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:49:50.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js/9GgwF3F1naCgIcmrkqJWB770mt9ey9swYwZxnZ/MZyORwJP52TjMSUg1TXo2qUFaGDNrQuplLx+AFlk+6TP5AKaeH4L1kI3QIvWr5Ih8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

On 10/29/2024 05:01, Nirmoy Das wrote:
> Flush xe ordered_wq in case of ufence timeout which is observed
> on LNL and that points to recent scheduling issue with E-cores.
>
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is a E-core
> scheduling fix for LNL.
>
> v2: Add platform check(Himal)
>      s/__flush_workqueue/flush_workqueue(Jani)
> v3: Remove gfx platform check as the issue related to cpu
>      platform(John)
> v4: Use the Common macro(John) and print when the flush resolves
>      timeout(Matt B)
>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> index f5deb81eba01..5b4264ea38bd 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -155,6 +155,13 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>   		}
>   
>   		if (!timeout) {
> +			LNL_FLUSH_WORKQUEUE(xe->ordered_wq);
> +			err = do_compare(addr, args->value, args->mask,
> +					 args->op);
> +			if (err <= 0) {
> +				drm_dbg(&xe->drm, "LNL_FLUSH_WORKQUEUE resolved ufence timeout\n");
Should this not be a warning as well? To match the one in the G2H code, 
with the reason being that we want CI to track how often this is occurring.

John.

> +				break;
> +			}
>   			err = -ETIME;
>   			break;
>   		}


