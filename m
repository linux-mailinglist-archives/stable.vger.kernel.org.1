Return-Path: <stable+bounces-213333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBGFKyekgmlpXAMAu9opvQ
	(envelope-from <stable+bounces-213333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:43:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 587AAE0806
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CEC730257D7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FDE286413;
	Wed,  4 Feb 2026 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZeae0/1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C5280014;
	Wed,  4 Feb 2026 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169378; cv=fail; b=LggmfyPi6eG6XSuq9B7MwwBDliTuGQhbLIRQZ8zRtDtT6iKXKsexJz0ySn6ZR29Adzm/jsT24mrLCnHN61wDvLsIvwBvCHL21aKod4nOoETD/sc86skflDekU3IzN7OTM+4Q6wWAng9VgBzUi0IkpKlBVe3MddhhTQzS8HFApe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169378; c=relaxed/simple;
	bh=xcxoHkdD3BZnIUDSmz+2vbVemWYuI36UATZlFlafw/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rfB9qFZK9w1ExlRN5SxNlkjdw3fetfarAze0ziWVeruesM55YEL4JMdNI5vz28L11qOE7AWX/8QM0btb0NTCU0vbI7wnFmj+yxRv/YmkvY71ZhLL3ykUgBRSMaDFIZ8MrKjKrARlnfZpjtM/4MQ4VimccfstWVglOb0J94Lg3TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZeae0/1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770169377; x=1801705377;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xcxoHkdD3BZnIUDSmz+2vbVemWYuI36UATZlFlafw/A=;
  b=lZeae0/1PD29g5gNbtFExD15o1ZtmfaLO5t7zH0yPqh2xEBbpu3Hnnv0
   bm91b4bG1GoLg6efOm69cfQ03IpFrazB5u0jrRBnW4ur8B/TYfJkSIAIk
   KuLoxXmYeXrbL2SB2F/uKCPhTDw+UY34ln/090P3wzmFTIv85aph2k/DA
   cwbEqvInE89Agww8wCVc0GUHphrfXNjOlMhs774MnJkV21zZj6XxG3hOv
   WqBCxWKYi7TNYVEuNuBGsg1uaS4wbxXoTaJQ7VjNgeFs1Mh2mVBzxjeGg
   ywpXH769JLQurc60S2BZRgg6CDeuc6AWzyvKeswmJDNQDqyPbxxA5GRVs
   g==;
X-CSE-ConnectionGUID: FNHpz+tjRNu7KKXniRD2cQ==
X-CSE-MsgGUID: 4NkXydwtTlGRShuDuiNb+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71074049"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71074049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:42:56 -0800
X-CSE-ConnectionGUID: jMDag48eT3mkj6zr9xRkLQ==
X-CSE-MsgGUID: 5geGkjfnR4mrW9O61GIc3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214563896"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:42:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 17:42:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 17:42:54 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.45)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 17:42:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj6vjv2O1t1u+tFjgqvOxx86t9YfVeZta7emYfBqM5KleNI8LC9J5k1aDPkmU5pIszCEsSFNjXRgYTpvZqcvNjyhpKRW/27ZJkXZcR8yrNqSuDjDrq10N1c3DyTbG2BKXMisFAw2z9IdFwR5+8pLfwo00GGdYai6CY2hUfVC3PPD4NRY8muYnEIsv+1J6ha5P43zpc/ZoNXR9NJ6T0Bg3s00pTJrg4kA9NsMLDg3ckn9q5hOuapIAE+VcPJkpNvXUQM5ie45KpiWuls1DDp9mzAcB3fbXhdY64kz8lxEdgNGc/N49uvoUiiaahQ5f04w8F+r6eSPKJfsdNvZKb1k5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U48XOBITpNOBHBbHRTUxJOc53Jnl01L430kEvubj85w=;
 b=pzaIeBgCf0ZLAuWDAHyh+mlmSyhklHi1f/Lm7v3wNvIU5yn3G/QWi2IP97BG7bDH4jrbqR+0RLTFOaHyvuSENo738kaf1nH1z//ZjXzUFkdK3XuP4Pjh3tCys788gmWdbwXVJin1/ORH8wC394DWtIbAc/9N1hJvF86Dcf+b9nJYbF21o29kVsn9tqcRHu6sGFekpwiOlQccrmjzaYLbftYINXxMGOUtI3bEpTKDpXJmxdCrAdOtprW0Od0L7eSZR5RVqKt+QvwBfKx8O8WMwdngDarSk6GqAxXfhUqBRI/pmBWRO1DuNv+JlzhNEfZ9D5x5oJsgNLn7K2j7vyy2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 01:42:52 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 01:42:51 +0000
Message-ID: <6bc348ed-3ed2-4eea-8527-44b082f7be25@intel.com>
Date: Tue, 3 Feb 2026 17:42:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] gve: Correct ethtool rx_dropped calculation
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <ziweixiao@google.com>, <jordanrhee@google.com>,
	<nktgrg@google.com>, <kuozhao@google.com>, <yangchun@google.com>,
	<awogbemila@google.com>, <maolson@google.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.com>, Max Yuan <maxyuan@google.com>,
	<stable@vger.kernel.org>
References: <20260202193925.3106272-1-hramamurthy@google.com>
 <20260202193925.3106272-3-hramamurthy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260202193925.3106272-3-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e444ec4-7d7f-4364-da34-08de638eb591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjRMNm5CZkdyTUJ0ZHBjQVdFK0dqRklKQnpGRHc3UUZvUnFPdmkxSnk1Q2ZZ?=
 =?utf-8?B?Ty9ydWJtUkdldFJsVGN1c2VLVk5kNUg0MmxzOVUrL0h3alZnVHJRbi9OMVli?=
 =?utf-8?B?dFNlSEpwWTBMa2xBYm9OaEhYbHZFeHlWb1ZtbFRwYThJbXFER1FXdVFYU0dJ?=
 =?utf-8?B?WVJPS2NxMVBKcUpOYVNNSThGTWtGRjlPMEFHOVJ3ZTdJRWJjMGNxc3p2cWZn?=
 =?utf-8?B?K2VQOGZyejQ4dmpFZlhuZzNIaVJxcHNaZFBYdjZYY21JSzRlc3lNOUlhc0NE?=
 =?utf-8?B?RDRxUXh5LzVPaDVVTjdCemdvOXNpUXB4NXNQMmhDSndVNEtneldlZERHZWtQ?=
 =?utf-8?B?OURwdmc2UjlDbDNDcUY1NmFVMXNnb0tXUEswYkk0Yllyc1FaTC9xWVo0Q2N2?=
 =?utf-8?B?VCtzdloxSXVaZmdyOWRBWTJXaXQvZ2RLMk13d1Y4KzBWM0xzeEtUL2kzMHNR?=
 =?utf-8?B?TUFjMUtsN1lEZllNZVdPWURWbFZSRlozalpmQ1lPa0MxOGNIMDNVU3I0OFFK?=
 =?utf-8?B?aTF3a0hBUjFnZWZJczFEU1RHQVNvUVNtYlByYk1RNWZrY3JhYklxMXhkZ09V?=
 =?utf-8?B?ZWJaQUhmVlFYNUdraS85eVB1YnNwcXhjcFpJYUpSVGFNUkJCb3lQRkxDK21q?=
 =?utf-8?B?VFE3WXpvaVpxUWxqR3lvcHd3NEVGSEY0MlJTSW0xREVBRnFoMFMrVzFoN0tS?=
 =?utf-8?B?TWtodUg0Yms1bjRCT3ZiL05HZ0xvMlNoR0V5S29oV2YrWE45SXBRRXVhaFVT?=
 =?utf-8?B?NThLN3dmMWJ2TWdkcGpKT2xxSUJ5YWhteitTbHBNTXpPaUxuMXQrLzA1OHRo?=
 =?utf-8?B?dGF0THJ5aTNTY1ZkaTg4QmgwcDB5TnBuMHROQUJva2hRcG4vbTF4ckRzcHox?=
 =?utf-8?B?V25oYTNJcTNtRlg1WHQ5V05vdTErZkZrQTV3MS9YaFZkQmt6NEM5bDFFbmNv?=
 =?utf-8?B?aHE3Y0g4SHRSdy95dHA5Tit3MjdTaFd0bEk3Y3h5UUlINkJhVU54T0taa3VZ?=
 =?utf-8?B?bGtVakcwWlVtMlJEV2s4a2xhZ203NHRKOU9WVGNWRHN6cG1nSDFhYW1yU3c4?=
 =?utf-8?B?eE5sU0JET0lFK1BuUEg0dWJrSTRLZEpyQ0toZ0hOQUZ3b085Y2FWTEZlRjZG?=
 =?utf-8?B?eUdmSGlRSFkxcXhGcVZjY3lIMnpQNC8rKzViMTlvSmVRSHo0Y1VPN09TZFJs?=
 =?utf-8?B?Y0VsNDB1T3RwRzRHZENPOSt0Y29kT2dhaHRXdDRZZVIwYUtNUXVocElwcW5r?=
 =?utf-8?B?Yit5UC9tcjhzSWVQUDdtdzZqSFprYTBhOGkxMzNvb2FDZUFxVTdXTGtpc2g1?=
 =?utf-8?B?c3l1ZFZnSmVEaFk2WSs1cHFrV0FPUHZHZmVhbzZtQWFwOHdtY3JaSE9uOFo0?=
 =?utf-8?B?dk16U3BrWENTQnFJZjc1aGF0Zmx1eUNneFRzcnBTbUoyMGVydEVydVdVUnBn?=
 =?utf-8?B?bEVZTGFXTXRVNkxyTTlNWWJZSHdtcndmTi9XN0Qrby9LbmZmNm9xMnh1S3pz?=
 =?utf-8?B?SWpYVzlkV054Z095dXZPZW9FQnRQY0hRb2YzbnVuWEdDNllWbmxYcCtaVDZB?=
 =?utf-8?B?K2lIM3AvZU4xalB2V3ZnTUc0S0lwSWVtT01COXRpZG8rRFc4ZkcyU2xQSnFs?=
 =?utf-8?B?Qm9nMStJajNYeGI5ODhoN0NhcktuMzBjNXUrVVhaeXA4ZFVmNGRPQ1B1RnVk?=
 =?utf-8?B?MUIrVktibHFhbGwxTEt2QSt0Q0ZFTjFXcTdaNW5kK1dqanNkbENzcEZpNVB1?=
 =?utf-8?B?TWkvdDh1UmpONkRnNXJveWRYUmZXT1RrNWhSYnF5cm0zVXNKaE9pcVQ2dWMr?=
 =?utf-8?B?WHRjMVIzd3psQ3kzWFU1K1F5cFVhRXNHQ0hMVGFBc21laHpqNDR2TE5jTEpv?=
 =?utf-8?B?cGVjNUM1R2V3N25XSkNBeFVHK2lpa3BPK0JJNFFpVWJDYThpTlZzZC8vdjlI?=
 =?utf-8?B?ZXZUbW1sSGRPaWM3V0s4OEQyTnVyM3NoNk1LMFErMmc0LzZZbVQvNDV4NFVs?=
 =?utf-8?B?cGV6YkNGMXZydGkvZ2g4VjYxTkZwbWdqQndrWlh2SFI3WHlldk9mM1VQZVhE?=
 =?utf-8?B?WFFwMHpxUldnMG5FVSs1UmI4QVB5ZTg0SG1palcxeHNkUGluaGhMU1R2QWpo?=
 =?utf-8?Q?+rTo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG4ybXN2ZkZRcnd0WEtrcWZIOGFoTVlUdGdSMWl1UHE5aUdvaUV2dEdDRzNF?=
 =?utf-8?B?cS9RWHR2cEd5V01BY2RmY3BjaEJxZFJLZnpabk5FUyt3OG1qcTAxQmZCcjNu?=
 =?utf-8?B?eXNwaEp3K3p1b3kzNkM5bmJQYU4xL29WY3B4Y2t1Q05VM0VrcTNIRlpOSy90?=
 =?utf-8?B?YitIaGRLeDVaenNEOTBKYUZkbGxFV0l6YzM0aExCbmtIenM0Rkg1a0d3SFVw?=
 =?utf-8?B?ZFdWa1ZLVnE0WXdWQzJ1ZGZZUkt3SlVDalFydkhpSElrMWZyWXNCalY2eHg4?=
 =?utf-8?B?RHdwa1dYV05iS1hDYmdVc0IvZFNCNjRwMnhpVmlFbzNtL1JvTERBbCtCRU5T?=
 =?utf-8?B?TGdISURGN0YxS1FaQjMxUXgwSnhFcXNPM295djdTZTVsbUVWQ2l2UVpQT01Q?=
 =?utf-8?B?cWlGNFJ4YjdkbThYSjN0L1BwMU01QU9HT2I2QTcxaW5aKzdDK1FXZk5lY2RD?=
 =?utf-8?B?VG1CQytUK3d2cmRZRFNrazd3TEJIbi9Tc2xpSUpDZHdlbnlZMUU4alBldzY1?=
 =?utf-8?B?OTlvQ1hwZzlkYXRZalQzQVlqTGtRZ0FoYUlhL0tlR0R3ak9aTSttWU53V3Fl?=
 =?utf-8?B?ZFhXVEtxd0VNekh1eTRlT3dkR0Q0OHJXOUFuSWtrVTNZV1hTWFJTWjgzUlhY?=
 =?utf-8?B?czZqOVYya0tsL0Rzd3Vad1E3ZlhMQlg0YVEycWJjaE9idmd1ZWRPczJUZWI1?=
 =?utf-8?B?OGFzR1JhV3FHajlTNmVDUmNxUEV3dEVsQlpJUEVhc1IyUTR1U2lURUhKWmFt?=
 =?utf-8?B?Q2kxRTNTd2VrUm9BOER1MzF5eElUOUNqKzdoUVJvWk5WeC8vTGNmZ3VhTTVn?=
 =?utf-8?B?K3NDdFVSNWM4UGxSblIxS0hGTU9BSVFoeGYyZTBLQUs3M1BSZldtM1c4V3Q3?=
 =?utf-8?B?WER0L3JZQ2luaDk3OTY1UjNQNFZOaTJ2MVRuZDJ2RFNRUDA3NVpGY0FRZk1N?=
 =?utf-8?B?Uk1mYUd3MVMreDRtVjlRYU1ENUVkN3VuVHpaRGVMb1NYRmZvWnVtYUIvWVIr?=
 =?utf-8?B?R0FyNnpYbC9OWFJhNUJSb3M3VkJFaEU2cVdZanQ3aGhTMWZJU3h6NU5aVzJT?=
 =?utf-8?B?M0VjLzYrZUlYdXA2MXV3SmRvZ2FuVG11d041K1duSHRQbzFBUGhKbHZEK3ZM?=
 =?utf-8?B?Rmpjc3BEZUw3Z3o0bVpDME94RGlLdWpzRVRlNmZLRlhCYmwzKzVWZENONlR2?=
 =?utf-8?B?V3J1eWZjVll6dzM3eHBSZjhxc3VVVk5DWEsrV0s2TWlrR1MzNVU4R05xa1NZ?=
 =?utf-8?B?RGZoMVlnRVRZOGM2UGZVYU1PT0pHNkcvazNhM3EwMmpCTHFQZnR6Qkp5QUpD?=
 =?utf-8?B?L000UGd2TEMrY1JrTlo2VFBZTXUwaS9kb0owcHV1SmVRR1R0OFJvUnNCYnZv?=
 =?utf-8?B?NFpzQXpkOW9ZU0t2WU9aTXNDaDljVGhCWk5DQytPbDgyekhlb283UjA1a0FG?=
 =?utf-8?B?K1FodWFvQzZHbVBhYi9HU3l0c1VVeVZJVXNnaW9uUlRrS0g1Z0grN2t3NTcy?=
 =?utf-8?B?TzV4SkNlNTRyaWNkcVh1eUR5YTNnSnF4RDlvOFRqSklIWEcwUDF2UExrMW4x?=
 =?utf-8?B?Yk03RkhEL0QyVnVoemFwMmZnd2FBcjR6QW14TnVOSlYzZWU5QjJMQktINTE5?=
 =?utf-8?B?eFZldVEvNjZtYVRyOUxrZmxZRG56R0p0My8raHlmdlE3TzJXVHhQSU9wMnBG?=
 =?utf-8?B?OGs1RHdJTWhnb2JIV3BHQXpib0hiVkNWTnhhZEZCeGV4QjI4VW9UOHY4K2NB?=
 =?utf-8?B?T0QvQUhiRS9WV0IxVTdzaGtHdlR2VDlQOWorMHZFUWI5dVRTL2F4OUtNbnVZ?=
 =?utf-8?B?STRiZUdKSC9KajhCMUJHV0lOTDd4NnUvKzFjT1BmWFp6SjErTDZiOVhHNDZC?=
 =?utf-8?B?MW1QVnJpU24zd3JDL1p4VG9OZXZzSFM3eGx3QWthRW9hVExCRjdtOWpuS1dP?=
 =?utf-8?B?NFlKclZibkxibzU3dEVyZ0ViMjdiRXd3OUJvTmZDR2ZENUNWdFk1TjUxbzd6?=
 =?utf-8?B?cmMveGVkM1liaGRIdHNzOG5KYi92bGdBanZCZTJOa2g1akhDbWpIbjRudyt2?=
 =?utf-8?B?bVd2OThOcVl3b2RuM0FocE5WTElkeWdtRm83QTB3QjdBZi9VUVZqRGgwRi8y?=
 =?utf-8?B?VURaMGt2elVKYkdIU3l1Q1FqOERHTkduVVZRekV4UVVnWlNTTXZuWlpVRlZy?=
 =?utf-8?B?dDE4NjcrZ25LVFg3aTA2cGYxdVpwZTloZFk0VFd0Z1lTZ2hYVzBibjBMY1N2?=
 =?utf-8?B?czJWTTgvc2xOc0ZFZDRmR2ZvSUNTclNpV2FOZGZmTWVydjJjT3kzakNvSkNy?=
 =?utf-8?B?cTIvS2NGbFZUTGdGbld5R2w2aElYM2RUWVpCMjlXVW4wSEVxOUJOdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e444ec4-7d7f-4364-da34-08de638eb591
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 01:42:51.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0c0zS5xe38ejPaGQ0wm6fYgS3G2nTDh/fPPpiOW4LdSryvuB4iFTG9pdNTMBBhtlEYlMmxvm6NSI44Xd+huWDc0iA1KEVdoGXVjOZmUvGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213333-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,vger.kernel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 587AAE0806
X-Rspamd-Action: no action



On 2/2/2026 11:39 AM, Harshitha Ramamurthy wrote:
> From: Max Yuan <maxyuan@google.com>
> 
> The gve driver's "rx_dropped" statistic, exposed via `ethtool -S`,
> incorrectly includes `rx_buf_alloc_fail` counts. These failures
> represent an inability to allocate receive buffers, not true packet
> drops where a received packet is discarded. This misrepresentation can
> lead to inaccurate diagnostics.
> 
> This patch rectifies the ethtool "rx_dropped" calculation. It removes
> `rx_buf_alloc_fail` from the total and adds `xdp_tx_errors` and
> `xdp_redirect_errors`, which represent legitimate packet drops within
> the XDP path.
> 
> Cc: stable@vger.kernel.org
> Fixes: 433e274b8f7b ("gve: Add stats for gve.")
> Signed-off-by: Max Yuan <maxyuan@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Matt Olson <maolson@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

