Return-Path: <stable+bounces-109585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94474A17798
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 07:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D5116A711
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320C1ABEC7;
	Tue, 21 Jan 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM8/9XZC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDB1A83F4;
	Tue, 21 Jan 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442615; cv=fail; b=P4hxHkJ4ZOsJMXf+3MK128GgTsIzIujAmGifRifZLU8JbQUCJbLdbs1PLj0ETQ/fiuh4PS0oV3qb+9448go+Lmo6q/ObRUbjDpJ8yr9e7J8BZb6IziD7yTJsfeIXwMQIXOynHTJ1ZhvTE0GO0FQhNqfl6dht8NF0sABaZCoxVh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442615; c=relaxed/simple;
	bh=XDOVB87MOS4Am+IEW+6jqqsVJaFTUlOvcCYC+LgUMuQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlYJTCb5sx5BuRd1Jjn5YKA5Y3PID2ysJPxCz3njjIiTabxZJGB+PtQS6k9BKLuB13pkr+N2KG1a1yl5MfYAq9rsYdPEwKnhhJSi70xV40yP9CDj2g8gSZp+Aux8Yg3Zo8s4AbDlloq1XlbjGs96xFvvNTUbPMTx/EFJJXHPhWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM8/9XZC; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737442613; x=1768978613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XDOVB87MOS4Am+IEW+6jqqsVJaFTUlOvcCYC+LgUMuQ=;
  b=aM8/9XZCvLf+4tsK5eFNtpgrg5g2TzmvoTpGg/4toSFYOimCeK4jXGCT
   /6BG//xXQTpjEuO5tiw65dFQbRRW6VSPCPbadXFl7sWgsp6VFLwvn2cEP
   ptR4N5Kir4iYKcLS5rZDRxkSbDzwK9BBPZLr0ynwASmwl8K8e3rr44kVD
   7oQD8vJGfPWdhjzjwepyfPClAwr5dvOGi/MVbaug0JvqiHXviGp0W5nAO
   LabX0yMykYiuPDZeV4BktIZSNe8qUdHghJjdfDRjCOgVlMbxd9MoAjke/
   s/Jsj9EPc7VrjVmqJfkF10T+p0idGKU/jpwwWGPY46Jpu8SoTZ3TAaW4p
   Q==;
X-CSE-ConnectionGUID: iinM/FxKRV6NeBCEDG1n/A==
X-CSE-MsgGUID: 5nugjK64TXGUKVf2bDOmXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="38001830"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="38001830"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 22:56:53 -0800
X-CSE-ConnectionGUID: 7CFMH4nQQaSMroeyA9AVJQ==
X-CSE-MsgGUID: /864Gtn4Tu22TqHGbjDp5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="107319553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 22:56:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 22:56:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 22:56:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 22:56:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PojyOtu/Wtc+S64KvSLvVRzX3pOI0Zha/uhBBF/OTGGvpxhw2fGs77mYUyk3yqBzEULG2GoPRaLyY3QAVhfwDdWjEHth1mZBaJLilgAC97258R6L5gzH05BB01kTqoGlNyqhs/YqYGNAuOKAjgtrW5kUD/YxOVuU86hHSHD6enGS5YVODSqLLabMO6cQhQNlx7L11brBnrnjNjXrvlH4iiL1lrkVg6N5DspaioEUe9UgCJD38s9fMXBzXTOFEg+fUEYN8GhvE7ZTIkQx+ViwYsVJFn6MbNZ9XmAUQz8cWP0fLQnli0T11NtKmQQ/7v0mX/aUN+EoEQOmFFnqBaATYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl2PJzPVSqtSyFXpPWYmpPQUk0WpxXVYertpw+IiG1w=;
 b=Y6W3T35UfZOngXHBbdSG1MjaT0HJf0S8o8OziZrmn96u+3NMfvvcPHTAKQGLkcd5+5xCs7SneLvF5uBt0kKFQlgkVb9u+oYMihOv+/v9W35HIKSMJtSplvQKasPtsDxCLjCpErOllDGj2sk2f40tdPH77ftmLu3qzETDUDLYKu4QZFYw/fOjXGkWH9M61uQ3mT53NqdAYVdOzNpq6ReaB9J0orAJcMeAaXpBKXOMmiQ9ZlhZL/RlRRyfPNB/rZ7VBshOZzn6HwfvxRVXv8edafu2CwTTYJcL9EANKS9OMUUMt4sLUFjzVU2c4lhURiKpfuGsMMBYPE68pUweq4AK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 06:56:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 06:56:16 +0000
Message-ID: <3cca401b-e274-471b-8910-bb30873ead1b@intel.com>
Date: Tue, 21 Jan 2025 15:01:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq()
 cover faults for RID
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250121023150.815972-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250121023150.815972-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a898d88-4be9-4c74-317c-08dd39e8b393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGJqS0MvTFg2N1BaU2pYZE56alZ6K1F0c1Z1blQyajhtQml3NG5ya016UXpj?=
 =?utf-8?B?SDRuRUVncWU2elRNK1JUMnpqSmh3bGczN25CdGY4amZQU2lRT2ZURGtIaC9S?=
 =?utf-8?B?UHZTUzJaZFMvTUlIbC9YdzZPbHhPQ3F5NWZJZitDTFcwNjdVcG1NU3hMTVVy?=
 =?utf-8?B?OTd6QVFrWHdSOFVjaDJHYm1hUlI1cnBDRUUraTg1aHJHWllZRTdudnpxRW5N?=
 =?utf-8?B?ZFdmaDhPVGZSYUx0ZTFIRjc3QUdURjRzRk1OcTR5YS9CR0NQbS82ZkNaTURR?=
 =?utf-8?B?aElhRjBEWUpReGRYQi9pVXpaQ1hXeTFoc2psdnI3UHhuVU9NbGhhUnk0YVk4?=
 =?utf-8?B?d0FKak9vOU96d0tTUU4zVFJ1Nkc4MGpKS21wVStVODFwRlN0L0hHdktRY254?=
 =?utf-8?B?R2oyOFJiNlN1YjZjL3RlaWMyaWRpS1dMV29kMTBsUXJpNGpBV0cxZGhQK0hq?=
 =?utf-8?B?MVhlZTZwUytzMm1yUHVDSmp3MVdScTViQnhxWi9BclBvUGdvb0xITVBiY2Q3?=
 =?utf-8?B?Z3VnYm10WFk3R2U5OCtVaU9wZW4veFJxSVRhdmc5L2ZMNVBLZ2FQcEprYjl6?=
 =?utf-8?B?ZU8zWndJSFZrWkJZYWtQdmFxYzhxUGlvTXdVUzJmK1NqWHJVU2kxV2RvVEpQ?=
 =?utf-8?B?a2wrQStkSE5la256Sk93ZDl5RXh4a3o2M2g5cEhYVnJKWS9VQXphM0htOUVO?=
 =?utf-8?B?ZU5POUxabjBhU21NT1lweEU0eEMwcFBpVWYyY3JESm1SQ2lOMXpiQlltb1VP?=
 =?utf-8?B?U2VMNlM1d2Uyck5aOCtHMGJSaGhlNW1ITzJOZFN4QXkxdG9YalYzN2V0WTB0?=
 =?utf-8?B?Q1lWWUhuTW5RejBaVEZ2THMwWTl6cVlmcUlxWi92YTBlcStYaXV3OU1FdWt4?=
 =?utf-8?B?UDR0MFhvQ1pzRHlwWm96ME5LdW8zL2hZclpIZ0dmc1ZPekZzdURlc0wyS1hF?=
 =?utf-8?B?Rm5TNGNpdlNaeXBqaHczM0R0cG9ZVVRqMnVweGdwSDAvVXprVkFVVkwwbXJj?=
 =?utf-8?B?ZUlmekl0SG5YYmhzOUd1cTA0RUN2TVp6NVYrckg2MVhlTTM3bHpiMlRqbjBT?=
 =?utf-8?B?WWlCSzQ5QzVOMVZaVFc3ell0UmhJWDRoUG5NcXQ5RllialZkWUpzY25oM3FY?=
 =?utf-8?B?MTZ1ODMxb1VwbmpsZmZKdGRVKzNtMFpUMmV3R3dJcUsrTi9Wd1JOZEY1UmtJ?=
 =?utf-8?B?UFpTbWhhc244TUVoTlR3ZTUydDJOZGZsS2RBeXg2OUVDeDJYS1FGdEdlMjhi?=
 =?utf-8?B?N3BObGtBMzlIRzNVbTRtSDNmbzJlTkRWWmIzY0Y3VlpkTElyZTZVVjJEd1E2?=
 =?utf-8?B?QlVxa3lINmVDUDROcTJYOFEyUVlCY1RnR0xhZVJhRVlrb1NoaHdsZTQ4S3Z0?=
 =?utf-8?B?Yk9QdUNxdjdpbkZVZHN0V1BoSDJNUTNNRFoyNEdnT0FBbTVlSGRzQm9FY0JD?=
 =?utf-8?B?VEEvWEpaekRJbWtIQVQ4ZU1TZXcrQTNKWktaK2VuNTNDeVJzL3NZeEVLMjFT?=
 =?utf-8?B?ZXY3bzJVQ2dTV05wR1c5Lzdpd1BteVo0RWxVTEpkUmJ6RXlQYXM1ZnVaQnJG?=
 =?utf-8?B?eGlYeUdVNG9mNUtiMzBROWxCWVRYK3J2dEkvaS9YUTE4QTdFV1Fyak1vWnBL?=
 =?utf-8?B?QmFjbEFjVEUra09sYTBhTUJiQWlpYnhPWHdsd3p3dUc1RzBCWEU5ODUrRVdi?=
 =?utf-8?B?ZitNTTNUSmtwZTJ0c1ZUUUVYY0JhUC9PaWZaQ3JXYWplbmRzcUlxMm1qUXN1?=
 =?utf-8?B?OU55Vm5pM0tOZmJ2ZitlQUFJaUxrYk9qYnEvNDJJeVJWeTBDK05VbTRCTkJa?=
 =?utf-8?B?T2NhVm9ZbDRFQjZwRm1FcmV2V2Z0K0Zqdm8wTTMwMDl6Wi9HRDEvVFJzNTNH?=
 =?utf-8?Q?Lw/7Oy3tbH8bF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm85akIraUxXRGl1YldJelN1OFhYU1R1MEl6MDc5cnpDYkJFU1JmSkZ5Vnhn?=
 =?utf-8?B?TjgrMXVKSVpIYXlOZ1loU2lWSnFoditqVFRhWkdpZDJGcVhLSk1MWlVPVDFw?=
 =?utf-8?B?QWtZUXhTZTFUTm5pWlZIQnhqTzJEdTJlNS91WWo3dGRQaFBES3N2WUk3bUhJ?=
 =?utf-8?B?WFFQcVphdklJZlRkMlM4S1ZKVHdvWSsxVWJJcGU1K1d1YWpsQXZabldoc2VY?=
 =?utf-8?B?SWsvRlhYaWd6WjNZeThBa2RnaHFtNEdVTjlnaS9wb1N5RTNFMloycUpaSmps?=
 =?utf-8?B?S3dtUDcwOVBLQ2NPNDhkMHdrV3dsVjBrZHVDeVFJZ0VvMjA5K1NocVNMNjBG?=
 =?utf-8?B?ZVpPRDVjb2lyT2Fja1IwcmNkaE1SZlQ4dXAxdVY0enZnV1ZXSUxFNzlRaEpy?=
 =?utf-8?B?N3ZWZnlVZVRFTGI4UXRZallkMGpHSTJmSTRQd3UwU2d3Z2VFQUJQVTNVRTBy?=
 =?utf-8?B?bVNaakhnSVpQbndMYkpDZHgwbVJYa1VacjdzSGIyVTRCNWw0eFRGT1VaMkY4?=
 =?utf-8?B?SVFoVlMyZUNNdHE0Q29iRkM5NzRnRldjYi9MbmdTVFBJMmMzUHhLU2Y4QytE?=
 =?utf-8?B?TDZBTyt3QXkrRW1CVjZPQ081RTY3TlhxVWttTDlPUGZ2NDRpNEhSSXNsWWdT?=
 =?utf-8?B?VEdhM2J3QkJNZTRXRldSaFhaSEt2U3lJaU9pTE9keVFhalc4TUg2bVVlVkMz?=
 =?utf-8?B?V3VYUWNUcmJsT1ZjcC9DOFNYa3lKS1U5YnZsb2xIVU8rNi9MK3BMMGNiSXBF?=
 =?utf-8?B?Y0E3ZGFBbVZkZlhwcHdUU3hUWEFZNDRId0JRaXJYMEw0akVybFdlcXkyNFND?=
 =?utf-8?B?UnM4eDQ2dHZWcW1OR2QrUE1FYk5jMjB5czZRT2hkOC9EN3J0OXJGZHFoVGhi?=
 =?utf-8?B?b1ozejFNZVdqblNVK3NuUkUrWm44STdNSGlZZlBRaHZDUmJzL0VROTB4NGNu?=
 =?utf-8?B?emhJeDVxTEM5anI5Ty9ROGNmVGZKNVdZWStPZTVLSGczTDZ6b2FJKzRyblps?=
 =?utf-8?B?dXRxaEJuYVMxbFpnQWhWRFBNYXlTSDR0NXUwSGhRSmhnVGdRVkZSMDEyd2JN?=
 =?utf-8?B?OEo4UjV1MTE4cnZzT1dYUHJvNkZzSi8wMjJHbHdkdmkwYzV3cTJwVkdJTVJi?=
 =?utf-8?B?b1ViRzBSUGpqMjVjaFhjTzJTbEtvTFJsRkJ0ZURMa1NTR0FyNGVTckJtbXlN?=
 =?utf-8?B?ZGhUWUkrb1JYdWxPNXRsZXYwc2FucDRLeTRFaDJIdnJERWNpYktRNUVvSjNN?=
 =?utf-8?B?dFRnTnFxM3BqUzVuaUNUdTZ2SFNvRUhta2V1cHE3QUZ3a2s5VlllNmZZZEhw?=
 =?utf-8?B?Y0RxdmF0dUNlU0hKSHR3ZUlLdzJVditEQ2JTMHExYXYwbVFMTjdFYXlQSjRB?=
 =?utf-8?B?ZWRlT3JNVXhKeWlMc3VXM0JIS2REUll4TFEwOCtwOUNZb3NvSnI3V2g0bDFN?=
 =?utf-8?B?dGVuZHQrWjZQaGdoaFdIRzVEQkN1WkEvc2cxblhIbDllQklja1pKK05TajVz?=
 =?utf-8?B?VnI0VW1xVzVXcnk1UFI3WnUvcEk0YjQ4STJKRlBRcXp6WC9FWFA2dUpaaW9r?=
 =?utf-8?B?M3gyZ2Y0VGJ5SnBpNzdmU0RDaWRaWjB1UmQ3Uk1MRkdwdU5CNjlpTVYrWngw?=
 =?utf-8?B?ajVKenNnQ0pzaDN0YlJLbHVPdVFoVzdOUDRMS2thVXVmZ2Nnd2xQNm56Qkxr?=
 =?utf-8?B?ek4yYTVtQ2Nydk1jR3VRYUh0WVF3cTFyWEJ1V2dMQm1lOHUxL0ovVExqcVdm?=
 =?utf-8?B?Z3dONUtGT3ZSZ0hmUGdIZDRyRmVYN3hVRVFJaHlBc2QyeGtzQ3ZyeGRkejJl?=
 =?utf-8?B?TTVqdHYyc0VyR1ZPbVFldjdXRFlUNHVKSGlMcUV2cm0zL1Z2bm9FTFU4U3U4?=
 =?utf-8?B?OWtlREJML1ZJUGswcmdpQ2ZqTnNKVXJid1grckpQMkFQQ1NzYUVIb0c4cGU0?=
 =?utf-8?B?NHZDYlBjZnFYSjIvalAydTBxSThsNjJiVjVxbjA3Snl4cmczaklIaEJIMzUv?=
 =?utf-8?B?Ni95b0pLMlFwdHlBZUFtZ2F1ZVNCbFNhUjcxbnFtYU9uN2Q2Z0NrcmkzeU9H?=
 =?utf-8?B?dHY1aG9majBWU1JVbk9tbFdjeUhRdkd4RnNVVGd1bjVKRHlyc2dzTThOL3M3?=
 =?utf-8?Q?+Q90pasriaquE6oxgXiYvJ1el?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a898d88-4be9-4c74-317c-08dd39e8b393
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 06:56:16.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FK4rgMAOvhzPGUY9FhGo4kc+ov6Y4EMzFeRsmQLVBBv6xf5oVW5KrN8EnKWcr4WHxVEEImh9Wyx7tHT6OQwFPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
X-OriginatorOrg: intel.com

On 2025/1/21 10:31, Lu Baolu wrote:
> This driver supports page faults on PCI RID since commit <9f831c16c69e>
> ("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
> allowing the reporting of page faults with the pasid_present field cleared
> to the upper layer for further handling. The fundamental assumption here
> is that the detach or replace operations act as a fence for page faults.
> This implies that all pending page faults associated with a specific RID
> or PASID are flushed when a domain is detached or replaced from a device
> RID or PASID.
> 
> However, the intel_iommu_drain_pasid_prq() helper does not correctly
> handle faults for RID. This leads to faults potentially remaining pending
> in the iommu hardware queue even after the domain is detached, thereby
> violating the aforementioned assumption.
> 
> Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
> for RID.
> 
> Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in prq_event_thread")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/prq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Change log:
> v2:
>   - Add check on page faults targeting RID.
> 
> v1: https://lore.kernel.org/linux-iommu/20250120080144.810455-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index c2d792db52c3..064194399b38 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -87,7 +87,9 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>   		struct page_req_dsc *req;
>   
>   		req = &iommu->prq[head / sizeof(*req)];
> -		if (!req->pasid_present || req->pasid != pasid) {
> +		if (req->rid != sid ||

Does intel-iommu driver managed pasid per-bdf? or global? If the prior one,
the rid check is needed even in the old time that does not PRIs in the RID
path.

> +		    (req->pasid_present && pasid != req->pasid) ||
> +		    (!req->pasid_present && pasid != IOMMU_NO_PASID)) {
>   			head = (head + sizeof(*req)) & PRQ_RING_MASK;
>   			continue;
>   		}

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

