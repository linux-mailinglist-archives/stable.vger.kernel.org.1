Return-Path: <stable+bounces-133093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2602A91CB5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254E817C649
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F136136;
	Thu, 17 Apr 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1ZNrUwt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CC360
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893985; cv=fail; b=uzi4zkTdL+ky4YaVpd9wd+fZPij/H9/SU6Lyo149OZx79eKbemK9pc7COZXGYIupG2CjKfRCgVNj4Rnn6yOoI2g6/NHJkF1fiTJ+MXDf9/ufq3yoeLn21CGkamOPQ+Y5+Y96ZjabWM5IchKRF2uZ4JyOIYUXD+GXb1EDam9gEew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893985; c=relaxed/simple;
	bh=Iabxwtc4xAsIVzp0nmAeD0o6PcNt31n81VclSXcVHi0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTA2C4WQvq9S6ixHWGAgRnQD/EsBD7kmC8eWcl4K7aQdelFIBcf3NwWioe0CKFPaHMun80MITyLjbXaeHVGQbDsKwm+/WNT/p+oeh5XwYIs1KRb8ChO7CNMpGhLXDXWdwXraXlnP/BASZcY68gtuJD/Afs0ZGA+ZcNyO9tu9mmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1ZNrUwt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744893983; x=1776429983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Iabxwtc4xAsIVzp0nmAeD0o6PcNt31n81VclSXcVHi0=;
  b=I1ZNrUwt5vRjNj5VdfYITABJmZMWrMd9/6Evz3dzUtSNojOy1WpuYBcB
   lQzJGNIY9hpybZNuFovhuYsktEl1g4CLXfPcBGM9kyVpW1zoFqiOEouQn
   MdEdL7MM55vICIoJfsbYEhNx8HU+go4vQM+3fcbAxkk9tRVicnSmnCxrv
   TjYw/0d6x3FEyVtaNjp0XM0rVv1hgnq3EUvaixHAFZVPFuxMgSNWp0mj4
   FBu58ePxUVE+HwNPpyRE9W579cc1Mq4NBBECfk/SgLnvreXxUwHLpAHV+
   ItT66GB6WwNZEmyseaFxAKj71kgtNvMNccFIdQv+hAKiAS2icFGmqU1tV
   A==;
X-CSE-ConnectionGUID: z2TaOuyqS0+DB5UY1abW/A==
X-CSE-MsgGUID: bDIL8MQvSImSDQ5vW086pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57863029"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57863029"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:46:23 -0700
X-CSE-ConnectionGUID: ywUWPcy5T1u9ub7t4n0L7Q==
X-CSE-MsgGUID: BmpNc4CcTw6FQWnYx+o5nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161748813"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:46:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 05:46:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 05:46:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 05:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARqbccsIfAzevRuGDH+weDPvl8cAKjVjwS4d+xlS57H6N7y7bROI4vS/M8dOhDOhfO/U+sWR4aNH+H7qW+5VZLntwoa7XaFq+YVno03+vu2553h1rWOXKYse85xiTjiuq4CRbWHlTHR6NETRkdRdHTPC/i48dvQHQRBlugXciYtCDonHkitvoSEXW9XI7ffliS19ajHKiQ3kv5voza6B7sS/0uTTs5OGLDAhNz6UDyrGevOt3DI1wdpD3M71gSgsHJkyyalo9A8Zg6W9T97roMROyBXf1k03LRqizypXSR9yBIE1dVEG1gzHl2/yx3S1x9+UL0OekifyIYSffStbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpVY0Iiw+dN+pqwTxru5TNVh91NyqxRciGXn16P50R8=;
 b=FfaUFvQ+BRe/P7uNCFMa82f71DBDIiyTvc4c1DOexfYAHZnbDS8Qc0A2cw405GBBdFc2AFckDvPGFN0R1UivomjwL6ljKZhVByESx5DlkGQVTDlejW6AHOO2O/mxraBpkXQiGNzJJ2clbd3bjIEHsy6zEK1Kw+rw92sRvmg3eVEMtro/AYdv1XNOPRGA7H4QYVh4nm9VuGBUnLJF2bjorwERIf6ElMcN+VBr5C7jMrnQTObwySpo+84UCLeftktI+ykjJt154H9qXiSuuuSBuuDlBipxQIZW92h3K2DeWElk4qXcSXorOLt8BJFVN1TBdyDpTiQx0TPRR6AFPvM8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 12:46:20 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 12:46:20 +0000
Message-ID: <9160a4eb-fc69-4a0b-8bd9-5b9d5f4f5bc7@intel.com>
Date: Thu, 17 Apr 2025 20:52:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iommufd: Fail replace if device has not
 been attached" failed to apply to 6.14-stable tree
To: <gregkh@linuxfoundation.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <stable@vger.kernel.org>
References: <2025041759-knee-unearned-530e@gregkh>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2025041759-knee-unearned-530e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 9291c82d-f5e8-484f-48a4-08dd7dadda0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWNUdmZ3SnZCUXp2clRxOGx1NTFYSStaUkh5anIwQWxXOUdFUGNGWVBlYnlw?=
 =?utf-8?B?YjNGcGU1SXdFb21NRXpKKzgxMTErMkFTM2hKQVR4Z2tMbGJQTisrbEIzTEEv?=
 =?utf-8?B?SlQ5QjVrVXZjbnNPSnVGSGFqeFJTRFZJb2ZGb3dXMythUFVpRVVxckQvc041?=
 =?utf-8?B?dkkwODBreEdXWlljUkFGTTN4UlZXeE5ZbFQ3c3lDbXBGc1o2WDVxTWRoTGhr?=
 =?utf-8?B?Rk5EUzNJbWZoS21oQ2Q1M3lxK1VGNlkrK3A3ZGdiaWdncTNhM3NuamxrcVJU?=
 =?utf-8?B?WW1Xd1lIN3BJNGkzd2ZLbVhiS2RxTWxLRDRKTFlwWWNnWlJ3WWhIYkxHSFRX?=
 =?utf-8?B?Q3FLRFRqTmxWS1pMWHp6SjQ1Ymd1N1pMSC9CM0tidE8yWUNSYzVwcGN3VUp2?=
 =?utf-8?B?WGFhak1HejVZNEx3OGFhbDNIc2ZEdDBQU2NrTTRnSUt5MklheXJIQXRFUWNC?=
 =?utf-8?B?Z3MwR1BoeUltQ1BFb0NpeXhIVTRiaU4vWUN2dEtUTzlMRS9KNXNCQm1JY0J3?=
 =?utf-8?B?MHNTMEpEVWUydXRHWTRjaHlwWGFpTmpmMWVUQ3h5QjhkM2xJazd6VWhBUDM0?=
 =?utf-8?B?UXpjVWtrVUgyWFR1L3RYbDlqVnJQNlB4d0RsZm9IV0dPNnZwclA5bTlmNTZn?=
 =?utf-8?B?MW1zWVE0ellvbnh5T3Rib2ZlZEI2Nk5EL0pqNFRDUUFtVHJpVUFtQUN4aEtL?=
 =?utf-8?B?cnN5Qml0R2o0UU0zN0I2SktkSnkwSWRZYTRLZDRLK1FhcHBhMk5JenB6VEhL?=
 =?utf-8?B?UENQRVp2WHllL3MxNEdXU2picFo2ZTlzR2RVSUNSdm9FV1hjcG5YbUFacVBL?=
 =?utf-8?B?OWhvSUdUaXJSNFAwcTlFdjdzazN0SjVRYmwzeUVsOG1TOHJkSDJBelF5cEhk?=
 =?utf-8?B?d2NCQmpmN0RUZitqMm5aUTNUZkpiZzlCQlRPMVNDMXA3K21LWFJMSjhtZWVT?=
 =?utf-8?B?Ykw3eUF4YzR2cVN0eHg3cUl1cm1hby9XNHFLWkNNeGZnWFo3c1Q2SkZ2Y1RE?=
 =?utf-8?B?R05JTTNxZU91N1NHbnBOYmxsc0hpRnptVzdPWVVGOXZ2OEdFK2hZY1JoQUNB?=
 =?utf-8?B?eUt6bEE5alJhUW5zZkp1R09XUXNZTkFMb240RkRaUWJYWGhSNjRaWndTYVR0?=
 =?utf-8?B?MjZzTkZLNUZSMWpFRjZ6QjF5MzdiWHVYUy8wM3M1TVhFc0NkQkJ0QnluT0pL?=
 =?utf-8?B?MStoNmo2NEgxdlkvN2k4VlhvcUlZYUcvck0xeDVIQzZiSWROVm1ucVFRSGpq?=
 =?utf-8?B?UVEvVTVGUWJ0ZHdHWjQ4anRrNlRHTGYzVytzTndkSXJreTROYkIwdmd6OVcv?=
 =?utf-8?B?dnpjeDdFRTZYZXZlZXR1YTNOR3ZFbXRUd3lUVzJVOW9GMHpSY0sxMUpodUdw?=
 =?utf-8?B?aU9IY1h1a2pPTi90aW5WRHlGVmhqZlVYSmZyTTlqSTdPYm1OVU1VTFJxaUEy?=
 =?utf-8?B?MXIweEdWOGs2Yzk3QWJhYzN3Q1RjdVhJY3lmdm1GWmMxc0NScnB4TW5hcFdw?=
 =?utf-8?B?RW1Tb0RuR21hU0hGL2JibFBnTUYxdCtIblZCQWFPSUMrKy9tTHd1SVNuVCtp?=
 =?utf-8?B?eWNaelJvcXd4QmZOK2tlQkVST2E3YThCT083LzJPWXAwRlRtUUltQndGMEta?=
 =?utf-8?B?VXI4TjdncnludUxqVDFXNFhEek45WDA1ZWpVNVhmQ01UNUxCdjgweFNpQUcv?=
 =?utf-8?B?QXRvMm1Hb0k2N2JhdTU3Ym11UDRTcU9BWFZMbVRiaXVLd1FJRVRzd3ZtWTUw?=
 =?utf-8?B?dHZwVDB5aGxRdDZOeGxTNVB1ZVJ3cGJSUCt6SzJIRFpsUjIzUFRRdzlCQXMx?=
 =?utf-8?B?RDBGdVhHSTVZZVVDNjZOR28yczVWMEYrTmlrOWlhWlFCSnREWURJR1FhNDR2?=
 =?utf-8?Q?ZzvXA/Dt4lqqL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZ6cEZRVFlWU0MwdlpVRnBjSSttdndzdWpLR2pmU0drWjJyNUdReGwxM1lk?=
 =?utf-8?B?S3duSmRpeXZwQnNrWWlNaWx0TTlmYkdLSG1SQkZ3dGJpa0lla1RibDIwOExP?=
 =?utf-8?B?b1BlUUl4bldhUGlvbWJTbUNVZjFEZklBbjVXQzNOYWtuZEtscXErcDk2QlpZ?=
 =?utf-8?B?MVUwS0loN0FvdThqZzJDQ2FPSlZhQVU3QmNTOExUcnF2SVFlZ1h3aDZFSDVz?=
 =?utf-8?B?ZEdTS3dIR0EvbHBDZHFuUHhXNTFWK2p3UHluSDZQSytabStPcHJpYldCVGZO?=
 =?utf-8?B?QnBMUjMwOTVSODFtWTlESTNpNURDeUE0eDE0M2xockZNa0dXcmY1QlFlYkds?=
 =?utf-8?B?cVRaM0FWZXJqbllpTlFHZWJOQ3hwYjlIeW9reTd6Tlk0UlFiZUFtZHo3T014?=
 =?utf-8?B?K3BOeEc2T21RWkN6SlFOd01vZmh5Q2hGK0craS95VTQrcEE3dUFmOTl1SlE2?=
 =?utf-8?B?ZklhcU9vUzg3ZnVTYXlSQ1pBS0FxT3piQXVieFhMUCsrNG42NUQrcGxYNTdD?=
 =?utf-8?B?QWV0T0VtUVB6V1gvdzJyZGUwLzNUS3g0WW8xdkhRSzR4c2F5NGw4NldZU1Iz?=
 =?utf-8?B?VzN1eXI3V1I0Q216cDg1Q25qRko4azIyVUlubGVpMlMvQTAxMzc4a3dzU0lo?=
 =?utf-8?B?T0dSM2xGaGRQU2d0T0hXNE5NQUQ2WUNQZCtsYWZLQ2RUbUZIUGF6VlFocVRZ?=
 =?utf-8?B?S0JZMEgxQmFhR2RWS0xuVkJsKzdPUWVodUZVNkJUY0wxTWJabjkyVzIxWUg1?=
 =?utf-8?B?c2FTTXUvZTdxNGs4STNiUkVGYWE3RFZwZmRxQkpjdDUwWGs1RGwxMTlXemNt?=
 =?utf-8?B?WHI3MUdCZEp6RHhCaUxLWVZpODc0UFV3YWtMSjBxUTZZQWZqVk92aStHSDZO?=
 =?utf-8?B?OXFvMFpaRG1hZmdMSFlKQktUbDdlSjJQb3M4bGVseExYK2VZd0lKQk4vMFk1?=
 =?utf-8?B?ZzNvalRlZjFKSHF0MmNIb2F6YVFlZHlRdkNxTnhVaURrL2NLeVYxSDJOVW1Z?=
 =?utf-8?B?Ri9QZGJBYkg2OXI1QVFtNzd4cVVUd2UyM2RBdmhOcGhpbE5lTjBaSkw4dTVw?=
 =?utf-8?B?eHVweDllN2xTVVltYVZNMXQ5MmxFd25mUTNFemJiMTFCMzNTZldwN1RPVE9E?=
 =?utf-8?B?ZW9rM1VMSi9IRU0xa0xCaDZ6NExWV0xMYjBDWUJZRUx4YUZodUxJOWlYVytX?=
 =?utf-8?B?NFBOU1BUVkhWOHlHK0JHK3E2Y2lONVRnNkFKSWNPbEJiRzk1R0IzWXFEUytE?=
 =?utf-8?B?SWp1VnhrTnFLNHVsallsbklPTEhsOUdSb3p0ODZPTnZmZytEWVhxSk1GSHk5?=
 =?utf-8?B?WlN3c3BxTEtrZ25SZjFBcmVXUEpYemNrUlcxUnR2bnkxNVBudzVpc1cvV2lK?=
 =?utf-8?B?b0pCUVRiTG81TmNsV3VMZEZZRkUwd1lXQkxxVS9QNi9CRXZmbDhVUStjUlY0?=
 =?utf-8?B?ZkQ4LzVVWWNtYjFzV0VzTDlENGw5V094ZGpoLzFjYzFQdTRHYkNoTFFWYVlW?=
 =?utf-8?B?bXJSZUhBOStjWC9vWlJnaWRhVUhFU25wYzI5TDEyWFhiay90c2w2L2gwR29j?=
 =?utf-8?B?TWlRUTFscHIxNFBXSjRreWhUYldnODdxRW9CMWRnNlJtZ1M1OU1QQnNIWFFa?=
 =?utf-8?B?YW9OT3RJVVJXYm5VL01MZ3NhNVcwV05oMFQ0V1V5T0JvZ3lxdGx5YlZ2UHk2?=
 =?utf-8?B?VzhHbnZjVWxCK2QxWjZpWGwxTi9aSHhPaDUyRC9Wd2oxaUYxRFAzNjFCRkFr?=
 =?utf-8?B?NzRzOE9idkx3MWlWcXlSRWxRaHlPTzBFS0p6ajdYaGVPcVV4aTRJckhsNG9n?=
 =?utf-8?B?bW4wSnk4Y1dTdzU2c0Y5RUNVNk9JNldONzFRV2FOaG1TV2N6NExXS2hNblZs?=
 =?utf-8?B?ZjZvbzdOUEJJbzRkamZPN2ZhVkVkZXp4VUpXRkV0K093VTJYMjlObU9vWFpC?=
 =?utf-8?B?Q2ZJS2FacDZNcnNuMkVaWGY1Y0d4QWJUVEk1QTl2Ym5GeTVrazRDOTQzejNh?=
 =?utf-8?B?ZzIrMEFaeUsyeERDa1UvVFFNU3p5SFFJdnhDY2toc0Q3ZTErd1AvcFFNcHJO?=
 =?utf-8?B?cVpla0RhdVhqWTY1enZEN1l0Z0pyT2FpZjV4NmdoWVA5ZldFNXFQVit1Y1pN?=
 =?utf-8?Q?oFHaoZD2zvSPv1Pd38skrl4Hy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9291c82d-f5e8-484f-48a4-08dd7dadda0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:46:20.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvCvdCKnKGA7LxV3esS0cVEuOmyAcIxggKi1/1Kq2L+NFZhzRpoPNe7p1BIOJyCGQf7yrm84fXd9ah6OXagl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com

On 2025/4/17 19:42, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-knee-unearned-530e@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> 
> Possible dependencies:

I think the possible dependency is the below commit. This patch adds a
helper before iommufd_hwpt_attach_device() which is added by below commit.

commit fb21b1568adaa76af7a8c853f37c60fba8b28661
Author: Nicolin Chen <nicolinc@nvidia.com>
Date:   Mon Feb 3 21:00:54 2025 -0800

     iommufd: Make attach_handle generic than fault specific

     "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
     used by IOPF/PRI use cases. Now, both the MSI and PASID series require to
     reuse the attach_handle for non-fault cases.

     Add a set of new attach/detach/replace helpers that does the attach_handle
     allocation/releasing/replacement in the common path and also handles those
     fault specific routines such as iopf enabling/disabling and auto response.

     This covers both non-fault and fault cases in a clean way, replacing those
     inline helpers in the header. The following patch will clean up those old
     helpers in the fault.c file.

     Link: 
https://patch.msgid.link/r/32687df01c02291d89986a9fca897bbbe2b10987.1738645017.git.nicolinc@nvidia.com
     Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
     Reviewed-by: Yi Liu <yi.l.liu@intel.com>
     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dfd0898fb6c1..0786290b4056 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct 
iommufd_device *idev,
         return 0;
  }

+/* The device attach/detach/replace helpers for attach_handle */
+
+static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
+                                     struct iommufd_device *idev)
+{
+       struct iommufd_attach_handle *handle;
+       int rc;
+
+       lockdep_assert_held(&idev->igroup->lock);


@Greg, anything I need to do here?

Regards,
Yi Liu

> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From 55c85fa7579dc2e3f5399ef5bad67a44257c1a48 Mon Sep 17 00:00:00 2001
> From: Yi Liu <yi.l.liu@intel.com>
> Date: Wed, 5 Mar 2025 19:48:42 -0800
> Subject: [PATCH] iommufd: Fail replace if device has not been attached
> 
> The current implementation of iommufd_device_do_replace() implicitly
> assumes that the input device has already been attached. However, there
> is no explicit check to verify this assumption. If another device within
> the same group has been attached, the replace operation might succeed,
> but the input device itself may not have been attached yet.
> 
> As a result, the input device might not be tracked in the
> igroup->device_list, and its reserved IOVA might not be added. Despite
> this, the caller might incorrectly assume that the device has been
> successfully replaced, which could lead to unexpected behavior or errors.
> 
> To address this issue, add a check to ensure that the input device has
> been attached before proceeding with the replace operation. This check
> will help maintain the integrity of the device tracking system and prevent
> potential issues arising from incorrect assumptions about the device's
> attachment status.
> 
> Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
> Link: https://patch.msgid.link/r/20250306034842.5950-1-yi.l.liu@intel.com
> Cc: stable@vger.kernel.org
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index b2f0cb909e6d..bd50146e2ad0 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -471,6 +471,17 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>   
>   /* The device attach/detach/replace helpers for attach_handle */
>   
> +/* Check if idev is attached to igroup->hwpt */
> +static bool iommufd_device_is_attached(struct iommufd_device *idev)
> +{
> +	struct iommufd_device *cur;
> +
> +	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
> +		if (cur == idev)
> +			return true;
> +	return false;
> +}
> +
>   static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>   				      struct iommufd_device *idev)
>   {
> @@ -710,6 +721,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>   		goto err_unlock;
>   	}
>   
> +	if (!iommufd_device_is_attached(idev)) {
> +		rc = -EINVAL;
> +		goto err_unlock;
> +	}
> +
>   	if (hwpt == igroup->hwpt) {
>   		mutex_unlock(&idev->igroup->lock);
>   		return NULL;
> 

-- 
Regards,
Yi Liu

