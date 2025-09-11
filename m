Return-Path: <stable+bounces-179236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BDB52891
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573531BC2C2D
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311625487B;
	Thu, 11 Sep 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1ZR9z1B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383ED29405;
	Thu, 11 Sep 2025 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571295; cv=fail; b=LWehIuOO7MC/SP/iWsCHMlsO6M6aSzyIfRH2vNsx5kE85qktUVbqr6yRG8YYy4dbdNDon2+mRNqavOmbqcpb2sPn9azwOEsJ1hzE7A/IDLFN44E5wAaPqi/jSqPwtis9LdNnwwrvMSzATFw780OyY2KxviJDGlD7+9yRhnVJ0jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571295; c=relaxed/simple;
	bh=7qQ0p9OkDbe1s6hsmkcitrUx1G5RZUVex1/06BGLRUY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3Uv1adPyTqM5uAiptsK5RkzxiTPIg+7peR00A2yoYsqMfC6HZWK4NXFhAlUQTMS0a8zDdkB7oe3k1Y90GVcOAZsNiDsBZ2OA3/1qfWafMaICj4cGiagD7kf5myc/Tc3w1zWlYG2KCkglMLGO8DffgN1Id2fpK83AbGqWAt7lHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1ZR9z1B; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757571293; x=1789107293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7qQ0p9OkDbe1s6hsmkcitrUx1G5RZUVex1/06BGLRUY=;
  b=W1ZR9z1B9ClPESiyVYalRffkX7qEU7DDHopOLKvAaC2aQYCRQkG+JPWo
   ByDkFA2ANeQodoFUBNGWtrUkCpn5S9hSfFt6MNkoKNrL4WqqVoBgN7bSr
   nuzRRswq+n+cyGadGEokclo9TCyXtZK1s+AWiPgkk4TFlvoWen9skYsRZ
   cf1xSeeb80VTaJSSEmqQ7o+nJ+d+jN2WsiL13tstfHaiQCjOy774UcuKp
   5qP5Z6cMjoehD3dZOSmNK0NeE2ioddcTPbnIorK9g0RqcsWpEk/wA4T0M
   KOowusyWD8YYK5uhwuWscaRs5Uojr62FrFU99uaNVKtkWOrsLHdNo1+G1
   A==;
X-CSE-ConnectionGUID: DES/1LwARFmiVvaackYMdA==
X-CSE-MsgGUID: g0ecnBAgQpeuH1h7eJBnCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="47465620"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="47465620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:14:52 -0700
X-CSE-ConnectionGUID: 97hbJZFcTVGBiujJcgG6Hw==
X-CSE-MsgGUID: M/xj5/qgT/iBMzd79Oc84w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="177906839"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:14:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 23:14:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 23:14:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 23:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYqA8wfzsfdhnEo0LJe7xEzT84BGKRgcJ6PdKEsIKHdgUqcNv1XqGU22Lm+Y6mt4i7WQiE6Qqq4DAijs3J16HYAMG2dWjSOnd8XOv4uZrDnC2sMXpsaYyNGDyKB/mACi+/7EE1ZEovrkZINw8OPBJ+jxi/lh5gNYCb3kj8ejt319cldI6J40gdK0Y9M7DFAJnlqM+w4bwLGHN0hc8A7h3ikqB6DJ4ILRCntljK0H/d2tRLy0warYIuNEIdK8N2ijiwgMldlUlnsocOTE1rBRdVLQ7b1L7VExk9OOUb+4uBRvd4q9GIGmCdPM/3O2zU8IBK5Ey+fugJtGt/88NCF8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyuHMyHdPcXDYUbboC3EJeIawzhGl2jdTdOe1hMuUPA=;
 b=cwtPHDn5QD0FvK+KJJh8p+zdFfwIcRwLnt4G1zw0dpc3DKQ4jVkRPe+mQzjZI3vuT/Y4wXL2Yn+H9DXepiJe0YTKCQjqvzeWJP5xZc4VKkhB5MZixxkwLt2URYgSSdFwCHU3IrBD2W+oretTiWL4bLGTJYbXC83p6GkOjTbvvdORwWCM7q6X8Ub74HcYLDMQsJHvJoc8b5NSIGRQ3xAa6gXqH6Ghw/xyeXCrdQ65nWku1p5FHIxRHwBtWtJAAY1Jcm+Ny2dMRchyhzghASuOM+OijzQlYOSvxNprJBQPMhEZ5D5NoyifZ+zvoYcc9sFNNxhQIVI3QTc5NKlobXEuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:14:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:14:48 +0000
Message-ID: <62b98a0b-320a-4f27-95d8-612a23bb369f@intel.com>
Date: Thu, 11 Sep 2025 09:14:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Ben Chuang <benchuanggli@gmail.com>, <ulf.hansson@linaro.org>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
 <6ac048c1a709e473f885c513b970fe355848484d.1757557996.git.benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <6ac048c1a709e473f885c513b970fe355848484d.1757557996.git.benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::33) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: ba272e01-c638-4cc3-1c6f-08ddf0fa82db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEMrR2YvT1BaOG1GajhjYy90ZkY1aEp0ZDdUaWMwMmVXYnRmK2lLejVMS1VM?=
 =?utf-8?B?elNHRE5LTkluMVpXUTI3TG9kazNxeTh0NitvL3dhdjQvUEhjVktUOXVVdGxQ?=
 =?utf-8?B?NHpaVUNuVGE5WmQ0L3l2MjdXU3hWK0xOdmdLTTg5RGw4N0M1emQ0S3ZpcEJR?=
 =?utf-8?B?cmlXTU82N05SV0NoTHdBZVdmZTNzWUxPZkVGdEt6empKWWdRVklKVmhESUdl?=
 =?utf-8?B?dUNqSHZTb3N3a2NFc3JZTGY2R3ZTKzYzMHlVdS9ZZnY4aFZRVjg1dmhaVStJ?=
 =?utf-8?B?K3loUDlyejMrSGFOR3ZGaGlYazY2VU15VVE3YVluL2pIVVJQcjhhMG9NV3I0?=
 =?utf-8?B?U1h2MHVBcEg3RE5qZ1lZVUlUTjFlMVRXSElXeG9JMEo5VWFPcHprUmFyVEs2?=
 =?utf-8?B?ZnhUZzRyMmoySGxkcDRQSExnc1JpNTBkNHBBTE9RTHJTTC9FY2RhM3lROUh1?=
 =?utf-8?B?YThVWEVxOCsxTXBhSlBITmFxUjZsRmE3Nm5Ra2pURWdMWDROVFl3WU1KR3FN?=
 =?utf-8?B?d01rZDRsNWhHNVJhbWk2ZVRGZmtVbGx2bi91MitGWmNTc1BUOW1UQUJyUnpR?=
 =?utf-8?B?QUFjVDFXajV1NHJ5QmRNZjlQRU9VcjFJeGVUMzBaTzgzNFFtVGhQTisxUnAv?=
 =?utf-8?B?YktTYmVqVHFOU3czQ3Y1OGpDSlZMcGM2YUs2NFNtWThURkxaVVVDeStxY2NJ?=
 =?utf-8?B?MnRvZ3ZDZGFkam1idTh5dExKaHh5R0k4Qm9SRnlvcTBHcE5DUStzcEV1eTZa?=
 =?utf-8?B?ZXg2NlljTDgxUzIwMzNvZG9tVkJqcW9uVDRpODRicm02UlpySlFWclFnTEI1?=
 =?utf-8?B?Njk3bmJIZk5hdXFFdHlVbkVicXZ3U0dYOUhSZkF2d0VXOFlXQTRYZE51K04z?=
 =?utf-8?B?aFF6SU5zYnltaE9XWXkzcnZJRnE4bENTclRaM1JhMGJMM0hJNWVFdktDUG5N?=
 =?utf-8?B?cXloYzJSOXIzbGpZY3hqNSsrd3c0a0tqRDd4WVBZMExPdk9CWlVHZUMxNy9s?=
 =?utf-8?B?TFFFTmVLV210YUxMMkJPOUZra2RIMVBCSkQyM1l2K1Z6REVza3IvRElpWUc4?=
 =?utf-8?B?ckhhVGlTNWpReFFPVVZXbjN1U0x4R2dqSFJ5MllDNFhZU2ViOWE3MXQ4YmFW?=
 =?utf-8?B?cHlNaktnMktjZlpNRGVGdklBREhaMEpJVUxmQ1BFdkkyREhScHE4bHdwRjNO?=
 =?utf-8?B?cldKREg3S3VXSWJleFBvak15TFhLNzVyQWlGWDhWeHpTeGdOQVBycTJlREI1?=
 =?utf-8?B?NlFqcERodE9KZXdiekhsRHpNWW83S2w1SnloYjhrcVRZUnhoQkg3OS9HTWcw?=
 =?utf-8?B?dHFLc2pTbkt0NkplZDYxQkp5ZndMTSswMlBwaTZsaDVXdWw4SDh1ZlpuRHRY?=
 =?utf-8?B?cU9MQ3BBSFdJTFZZTFYxeGVaSzNnaHNiQ1UvNDFHRyt5c3V4SFZsSy9sR3J4?=
 =?utf-8?B?enEvVkY5RUlwS1ZINnBhRS8vVTdESmpWTHJqcGVoMjl3L0h4RE1FaExZN2Vj?=
 =?utf-8?B?MkF2NDBCZjFwWk9sWU1qUWRJN2hTNlYyK3F3RVVPdU94TVk3SmU2Rms3d1lL?=
 =?utf-8?B?T1A0eC9UWGE0bkpxZzEwWVZkWWErdC9KKzQ4TFdTSGlSSHBxSHJJOEtORGdz?=
 =?utf-8?B?SThRUnppQXhHUisrNTZqaGZTenBrd2JjUlArb2NUNG14UVExZVEvQ0Y3dUlo?=
 =?utf-8?B?VmpRZzNZZ0xmaE9EU1JsQXdLdDJ5MTlraU8zYnI5YUo3OFJpb0VzY0RoeDdE?=
 =?utf-8?B?Qlo0S3dZWitvVFVTNnlwbzhRS2NXWjZVcHFiRFQ0RC9FK295M253Tis4bG41?=
 =?utf-8?B?OXlndmRrNjlEelJwbHJGUEpST0JxbWd1dlZkcFBaUjR2a0NUSzRvSE0wbmZB?=
 =?utf-8?B?Zy8wdHplRG5yQis0OWp2ODk2Ry96MWExalN5ZXlOcXhFV0ppdE5UMExZNE5z?=
 =?utf-8?Q?UDLY/m2bego=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElpQnIvc1l5SjFIN0ZMN0E4RldpbXRzbnpyQUdpMkREOXlsNFZnRXFnWjNa?=
 =?utf-8?B?bjJ6UjdUS0c5ZVYvWTQzK2I3d080cllMalQ0MERBK3QrSmRJNGNIZWowYkdW?=
 =?utf-8?B?ZmdZeGpBU2JvWE4vWk15ODBmUVBseEc3TVZ5eFFIb2gxMGdNSlFUdWtidUx6?=
 =?utf-8?B?Z2VuanN6bTlRMmtFeU5ZL1dIMDVFcy90Y2dPbzhLRHdLNW9sU0xsTHJUKzRG?=
 =?utf-8?B?Wlh4WElsRHk4R3loVkVhelR3VG9lWlJ0K1FpT01hMTd6WVNRTDN4MVZTdlBx?=
 =?utf-8?B?RW9vYi9JRU45Yk9UTXVzMTlQbU5JSHlyTDd4UGVhM2VxOTZuMGVRQkp3TE8r?=
 =?utf-8?B?c2ZIdHdFYkZ6U1hsZUZlN1ZEN1krN1dHWlhBeWxjVWFmek44QlVDQmJVdDlz?=
 =?utf-8?B?elNNNmdOTTIrSkxxVXlnbHZpVDhobHJUd2Q0QmxzdTlKbk4rcXExcWhqTGU4?=
 =?utf-8?B?clhxd0o0dVl1MlMxU0xnbGRzdVJrdUJlK3N3UndEeFVrZ0QvUFRlUUdnR1BJ?=
 =?utf-8?B?a2p6QVZ3S2YvZkd6WkhJQzhQU1BINmpPWkwyNlAwVHJPbGJOOEtkU3B5Vnp2?=
 =?utf-8?B?VUtJdDFYek9jcjBpVUFUZVkzTUJyaks2dmlXQXF2djhiOXVKbEV3SkJnbTls?=
 =?utf-8?B?Zkl1bTM2RnlIRUFFZVYzQVEvVXQvbjYxYUlIS3dUWnJkNzl6MGhNRjZoMkpG?=
 =?utf-8?B?UE1DcmRxaWg1blhpNHQxTFl0T2kvN0xqaXdDanArUVJma3J0VzJua3hSeUlu?=
 =?utf-8?B?TlFHWW95OCtMRjFoZHpxV2RBU3RuWkI0SkIrUm8yWmRJakFsd2JIQnJQMFov?=
 =?utf-8?B?WmJCU25iUjZzRzdKb011dUJhdzBCb295K2w0YVBQdVZBZ0V6Y2pYaHJ0M2NP?=
 =?utf-8?B?T0xMZXlmV056cmJHcFBrUUtIL2VoU0syZlBXQitsKzdza09HNlkvbjRTNWpN?=
 =?utf-8?B?aVZ4R05QSDVwSHJVUldqb2NGQTRJb3JacnpPeG45aE5vSVpIUDcvb2M1UWdt?=
 =?utf-8?B?OWdEejFUUGl2eEVHVjRlOXNCU2N5RDNmamVzbG0wUDdHSlgySEFNVWtzM0ls?=
 =?utf-8?B?NzY3aEEyOEZFdUJQMGNWbXFOUzJ2Mk1ZRlZDMk1OdDdEd3FZaHVQU2FQUmlp?=
 =?utf-8?B?ZDBlWXVsYlF2SmswUWVubnlLZ2F1Yit6bFpyYmFOdUU3Uzlaa3MwMGNJam1w?=
 =?utf-8?B?QXNCcThvR1ZnODhtcStLNjdSOU0wRFN0cWxiM0FPWmpCM2J2ek40ekRvZnJn?=
 =?utf-8?B?UXNyTjAydTNRRGphMXNpV3hnTGl5U0JKbE9weHNSY0IrQnlSVHl3SjVMbzVu?=
 =?utf-8?B?eEpkenRWSElFTS93M2pTQmVOYjdWam9vbWdXUHlibWtoaEZhYjhST0gydGZo?=
 =?utf-8?B?ZnIvQkJKTElaY05TYW1qd3NuSFlnUG9VaDNlbXh5bFRjeHVuOEFXL1BycGR1?=
 =?utf-8?B?Ujg1UE1Wd1AxaXFpZEczbEUxOS9mV2xTOFJGa0N1RlE4WVpLakIvV2dqWldx?=
 =?utf-8?B?NElHZjZiQjF1NWpxcXR3U0ZQcndCbTNjUmthekVaZ2gzcDkya3Zza3J3UXU5?=
 =?utf-8?B?MjUzQ1ZqK3ZYSkRKNHVDbnMzcmMwUW5TZ3hHY2Z2M1ByRE9IOGxxblRXSG9w?=
 =?utf-8?B?N2JKeTZsNy9FeE8yU2hkUWFxbTRRNkFrbld0VlJZUXEyNlM0QXQraWFjNDBD?=
 =?utf-8?B?blFpZkxHVGhJQlR1UzVrc0dUeTh0dzZmQmg1M245NC9jNDlmOHVBUTEvVzhG?=
 =?utf-8?B?Vzg2enRrTkpoeDI4b1BhU0lXemFiVUxDRVVEbUd2bCsyOTl3YWZqZjZ0S2Zj?=
 =?utf-8?B?ZXZMUHRNYXdBaWNocU85YnFDeVk0MC9uMnB6SlI2aUxNa0wxdEpMYXhmTVov?=
 =?utf-8?B?aHJ2ZlBId05oVldMWlpFdnBvYTB4Q29lTkM1TWpnZUJHbGkrSU1lOXlYT1gy?=
 =?utf-8?B?eGFJWnV4T2g2eTRtMGtqTnRxbVlKcnN6ayt1VldQRXNoREc3OWNUYXlWYVk1?=
 =?utf-8?B?MmpmSzZtM2pHTzFLaFFHZ2duVDF5bWNzcGZlZkdLeXdHR3RCbVg3NDdZWVcz?=
 =?utf-8?B?NWJJMVplNjU4THJIK3J6V0EvMHA5MmZMTUN6azMxeUlOdUdGMjQxV01hMTFH?=
 =?utf-8?B?b29rY3VOWlY2b0lmN05oMlQ0dStGVWU0QjBkUE0xdDRnUFMzWE1qaTYxYWdW?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba272e01-c638-4cc3-1c6f-08ddf0fa82db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:14:48.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9nCeOun2KOHDSy15gElYhdSImVpDzeO0JBHscu/QVqwmz0jMcsFg6kCl8gQ26Ve8x/rPzFBjUi6yvuzBKC9fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com

On 11/09/2025 05:41, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
> vendor defines its own sdhci_set_clock().
> 
> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v3:
>  * kepp "host->clock = ios->clock;" to part1.
> 
> v2:
>  * remove the "if (host->ops->set_clock)" statement
>  * add "host->clock = ios->clock;"
> 
> v1:
>  * https://lore.kernel.org/all/20250901094046.3903-1-benchuanggli@gmail.com/
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 18fb6ee5b96a..c459a08d01da 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -295,7 +295,7 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>  
> -	sdhci_set_clock(host, ios->clock);
> +	host->ops->set_clock(host, ios->clock);
>  	host->clock = ios->clock;
>  }
>  


