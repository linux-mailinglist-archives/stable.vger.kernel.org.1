Return-Path: <stable+bounces-227133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFzbLt3mumkpdAIAu9opvQ
	(envelope-from <stable+bounces-227133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:54:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF1A2C0BAC
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FC03289E3F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59152FFDE3;
	Wed, 18 Mar 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkD8B0kp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832D2E9729
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854411; cv=fail; b=nCozECOF9LF89jArPyQoxfabSh61ovtWtJzWa05U9H3AMRdFUkhNnc8L3rPvQGJrdjmlW07Mb12ybB/MVfXvJVqS3/rNqGNeXqiUDK5JwMChML6mmYygL4jJtIbdGrafj+WrMHXavgaWhGO+yPybzHQkmOCFCNKlCWaQPFNX42o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854411; c=relaxed/simple;
	bh=ovOVauE9rPEKNpQpCYFTszdyQrUJLErh4qS77kNjShk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLvz5ZQ0HMyrL/Qh/HxfZ197VrZ0hMFPhuU5T+ekfAPkt4xvGdkqDcheP4t3X9rsWnp+TNmNglJPvUPfkUx7LXKlh50lvNj3+aZjF3uj7jXKGZQa1bn7YAXAaWNIPcbRA5YNXJM9vAc2dGzFdujFjOHbkmIE850OAr4uFnqfQgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkD8B0kp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773854411; x=1805390411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ovOVauE9rPEKNpQpCYFTszdyQrUJLErh4qS77kNjShk=;
  b=mkD8B0kp9xP8BhGmOOH5SZCJ3Ea3sdn+qY+ANdziN6AwcIVHs0BCLkDV
   S0SsSuvKq4mS2e0jYPduRM1FDBgNWQAFyLPdR/UJinJj/5UQVgCFdRHVQ
   FjvvsMd/ejW40dZAJM5bPxnpPx6Jh/ElyFfikyowsa16Q92EVnEnuEUKI
   ik5PZmIL3+OUuhMELqf6XPdNINXghR1+NJ9OCDQwL+9GczOnkmq58C5/J
   ipU2ObZDZuUvfjUd1ir56xpaRuWq5b5IKJ5QPxanWY6ZyA6YCbWuGzJs/
   wWYhsurnES/RwKhWZ95en84z5pRx5LTduqZq/N/OVcFbaDISQ1oe5XpHw
   A==;
X-CSE-ConnectionGUID: DE3zQ0dvSS+sV+owb1AFYA==
X-CSE-MsgGUID: 3g4CnL1eSle6e9yaXA59ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85234742"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85234742"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:20:10 -0700
X-CSE-ConnectionGUID: fL3sR4ELTVmgJh87FDoTjg==
X-CSE-MsgGUID: aGBYevy9RnKQLQxVcB1ClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227173465"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:20:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 10:20:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 10:20:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 10:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH0ETcOwb/guPGnWsoJkdG/8jyDmfw3mWkuCW3SXAPFC36l4qLdrNPqBJdEaL19NBxAztolopigzfFM5QmrAfA9qhEsPxkht3a70ZrYXmoXjilFch2bjMj1J2QvK0OOeDjRSZv0YVIhfJw5gvkFs+fesS+gtzwDy1v8wQnKGw3aTzfVLPScZ19xlFG6fR+uBEChnbBOWTRnFY4yrzvbwfdL3HkVyk3nCkT/UBLeSsihTjgNoG60lpwe3g5xYO7MHrBs9dhEADKqlKCQqf1xg/lnp7QNuav4AvUMoLxKis92A+UyHtdPp9mB18M3eKvzyaY1Pa2sD9QxpbS1Aio621A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovOVauE9rPEKNpQpCYFTszdyQrUJLErh4qS77kNjShk=;
 b=PHu1L87cT7zeXn1hAcUlVHnD2ZBlQd4Bsr9Ou3EFNqSXKLOb/eWJwOcVwxOZBpCouZAkG3OdF/GLkXrAlgwoENZM4Jl9dsKYql1GCi7ylNpmbSd/YnpSrDbRNDGrrsajbOmg2CjF0eKKJFXVROZ03FJASOgZB2B4AZPFRrV0vlVC2BUCmHWn4psKEvDeOdW1vLomzVKihOn61PjLlxsgQc2cq20EZBExK9RowfUrTNGiLZAWvuSk6FifvAhEHL7/YN8SQaW3Wpe1tSLIyhLImBE8gkbDSmirChcK9jTRyp1dS7tyWjOR17FgLg+KBpNKQt3MeOl+dMNW3a1nuuhwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 17:20:06 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:20:06 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially initialized
 sync on parse" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Thread-Index: AQHctgPgECEJeu0MVEWd50ZolA7oKrWy6OSAgAACNQCAAAjCQIABRJiAgAA/koCAAAz1gIAAAn5Q
Date: Wed, 18 Mar 2026 17:20:05 +0000
Message-ID: <DM4PR11MB54564E029B910AA49F92397CEA4EA@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <2026031732-size-unfasten-2bf3@gregkh>
 <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031748-huskiness-autistic-5186@gregkh>
 <DM4PR11MB5456067D5FE7F51042296C41EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031851-glamour-unusual-8513@gregkh>
 <DM4PR11MB5456118C166481BEABF3CF33EA4EA@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031828-dyslexic-retract-a423@gregkh>
In-Reply-To: <2026031828-dyslexic-retract-a423@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|SJ0PR11MB4879:EE_
x-ms-office365-filtering-correlation-id: ca99a116-ca94-416c-f9a9-08de85129962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: xc1Ww12UVtH10IhItCcjSwjLBqC+J5W0OQmk7BmirOuuudGDE155ZCBzHn+sK51RS7wdyzh9x1Af6rSs+qHkBORhQ8FTPh6EqA1lDCeDa2MfF/XzgOUrzwoBjlivUKJH+seMzncBqNp3EsGDtjiTbKAdZKxuJ8ziOXW7aVnER0WZKNN2ftE4sQ6iJGOVXI+H0JG69IzVq3LTkLCbnnSYCuqIw2FewvyLJbIELgM3zSd7n1Mlja8VJ7Rj918rxwXDLatQ7hSBX+hVYfdDR0oDp+iE0KbfCSD8Ps7Mg4dbXza82JDdOcF4mzIOC9T9mnttslHxwau3w89sAv+kp9nYhlLk8r9je9rhObADalRV0MmjOjgWj1gucUrLDwJYd+rl1KxVJNLxPdoWKNf8Wve21tKRbl+3XMyjcJjruxwWTfNSFI/EAJ+yNgHA2z+TlK/vAU8upN1KSc+C2okkmrr8uTQmQI18tPAZkmBfTXzZvP37d8h7fbf1SjgqGV8Qj/no7DTdb1JY5BmWcb2fDM2Zf4hWpFJ/BYJWUT8EpB2KXWhqlwcPMDzuivO5qS4iVxWPntyp+axsuvwhN0HVMgkQBpAbSJ+9ynn3MHq++Sa6+qf86dhuFehhWWT0x3xt3zBcDVaDx5/Y4CjoT/5S7VZ7guqnkYiceD7Qhb0WIhX1Lbcahx2CZfFKhIb1f+kXBHPtkodb7OPAB0nip/KksPh0x0PFG5DomT9QO/VsnZWnKudPT8TYT5Hab67kvF5MBAHcG4OXKaGcm9bXX8z96JA9mYvYeq1KODAjzptAK8IEhlOCN9KxSwny+RJpI5Zin3+n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3JkS3RObHVNMVNPUEl5emIzL1FOd1hGdEtvR0taRDR4NUFSSi9GSWtPMG16?=
 =?utf-8?B?bE1vVzZjc0o0bnJFbDlXUnZocmkrYXlueTBJU1lmVm9JaCttcW1weldUbUpN?=
 =?utf-8?B?MEZBN2lDRmlwbllMQ0dlYy8xTmJ5NDNyTjZCdHlhMmNPdUF3ZDNhSGRQZHVE?=
 =?utf-8?B?RzYrQ3lvTlZvUkFwdXR2U0g1eFN4VWswdEx3QnBobEx4WjZucXhxL0dwYUxU?=
 =?utf-8?B?bkYwTlhnYWVaNmxYRldDSDJmcXlSTndFQ0wxaUZsUG9uUlJaMm13TTNiN3d6?=
 =?utf-8?B?Q3R0bURXYjB6TWt3MkRlS0xaSGZ6cnM4T1R2Mm9YRjY1NnB0VkljL0dWZENj?=
 =?utf-8?B?eHcyTk9Yei9rc0NhclhWVUd2NVN6Y0oySDduc2xVTFpRK2hJYS9Pci93VURF?=
 =?utf-8?B?KzdWRmJ2WWJrbnVtcFNaVHF4aFMwT2UwTUEvdE8vcnZiMGQwZkdRbkN2V0ky?=
 =?utf-8?B?VnZGbjFSUmtGZkhUS08yR2doWFoxeklrMlIrcVVsQkwxYW5NRE1EUm5FcStV?=
 =?utf-8?B?SHF6K2ZrOFpiZ0NFcjY0RWQraEp3THd3c0Z2MHJKbTZDUFRDRGxaVThiSERV?=
 =?utf-8?B?a2M0cVN6ZG05dDl3RUluY21hcUF5NUh4L3VQSm5UZU1aZ3pBM1JqRENQTEVW?=
 =?utf-8?B?L2trL1RJN1d0eE0ySlBJWlBidVZ1TVRUYktQUVdvUlphYkJDZ3FUeHdWclVx?=
 =?utf-8?B?NGx4MU5tTlF6cWhzbE9Wbzg0K0pIa2dSME9CUVhGVUlUcEZTaUFiVm9VbnE2?=
 =?utf-8?B?UkthbGtwNTQ3MTNSRXQ3YkFsM0x4QloveGJTMlpaVnJxcDZIQjFIUUpVVEtq?=
 =?utf-8?B?cjVMVHcrZEkwQU9rbkR2eDZTcnV1Q0oxK1N4MC9kTDdLZzdLU3hSbmErMjlw?=
 =?utf-8?B?aHk5S1ZoQitzdUh4Q0FRMldEbUJXeUNMV2RvdmYxUjNHOWl4NXZEYzZ0ZW5Y?=
 =?utf-8?B?eU93dXZJdGNpQmlBQWx6Vlh6V1E3bWRvYzlyZ3g5V0NySVNqUVd2VStNaEhq?=
 =?utf-8?B?MnUxZ3RwUGdiZUo0SU9hSzdMaGQzdjdMdVI1MnVFSmFNQTRlcTZXRjlSS3F6?=
 =?utf-8?B?L1dKMnFMWTlydmlOZzRiTmE2dTdWaU8wZkFCSXFVaGdTTlh6MjQwRkZKa1Y2?=
 =?utf-8?B?bFJXWGdUZmhHRGZPaEIrRjIwdVdhZno4S1VVVU8vcEpVemkvMzM2cURzTDBD?=
 =?utf-8?B?MlBBeGxZbSt4TDhyTkhPSUtSWFBMaVdWODBHV1RGRzhGSFc5ZkpBYTJ5VXU1?=
 =?utf-8?B?TlpLTFJ4QlZEWG9pS2RNbUJqdG5jMjZucWs3RjllVWhGZ01STThOMW1UR0pO?=
 =?utf-8?B?ZkNJNUpIOFdKRVZYUXcrYndZdFBPYmZmNWZVVHpYUzVFYWwrdkxCSjdZQktM?=
 =?utf-8?B?NzRIT3gzaVNtNzRqQmU5OVhrTldYSWU3aHpFN2dmNmhoL2hWSWI0NzVOUDg5?=
 =?utf-8?B?SlFCYkF1Zm5kRGg5TGRLWWVCWHhWcDVuSmplbHNzQklpUEJ0NTdRaXFKVWpM?=
 =?utf-8?B?L0VTTm1Oc0VhWHV5Wm5YSUZtbnhCQlRqbXJ2Q0kwdjIrYi8zOEVwUStYcTRR?=
 =?utf-8?B?bmJSWHYwMk5Hc29UVjVjZ3pIVnZndU1vaWxJNlVsUXNhT1g1SWdVbHhUcHNZ?=
 =?utf-8?B?TzhqeGhiRUpyVWtHV0t6RHduL015cG92Rm5pbEZJQWdIUzVqeEdZL3VwWUZK?=
 =?utf-8?B?SHc0THJpNVNTeFEvUXhhOHU2TktjSmJjMkx6VHhlajRLTlVLUzdGeis3Ulpz?=
 =?utf-8?B?L2YzQUVUWHJoa3FYSDY3ZXFEZ2dWSCsrSWRobkN1SGY2YURFQkZ1cjYzd0Yv?=
 =?utf-8?B?N1VmU0NkNTVCUnVZK0QyUVAwU0V3bnJpcHk4N1VldVBkaW5OWERRWEdCR3N4?=
 =?utf-8?B?R0NPMUV0Q3pRN3pKU1JWdGFQVGhDdGd1MEdGbFdWQ1dPYUlVSFdVZ0VDdzVq?=
 =?utf-8?B?YkRCVWtTWFVPR1BxSnpQU20yeXpzZnJHZEo3VmxPazlhM0l1M2pOZGptcjBS?=
 =?utf-8?B?RFhsajhMdWNMYVpHWVk0WEdLM2N4bjdyZjA3dTlWUENSbkoyTXBubjJST21M?=
 =?utf-8?B?RUNIWTQ5ZXphaEMrbVNuMksyRHZBWTl4bjEwOGZ2YUJuMC9WWWZyMHJMYmpG?=
 =?utf-8?B?Z3MxNFgwaC85UTljUU5PK2ZJdSs1MG9MR2k3ZXB2MnpmT1Z1aWFPVTh2QnB3?=
 =?utf-8?B?a2ZQOVVMQ3FTSHIzZkF5NlRSUi81TTdzS2ozVlgvQ3RqMUE3Q005YzlkOW1C?=
 =?utf-8?B?bDFKbjJMN3UzRXlTNTQvdmlUL0k5SVRwbklJblQyMXlwNm1XNDhHMnF0YjRu?=
 =?utf-8?B?bXpPZWIzdlZneTU5TlpBS3g0b3Fma2hONkZLdTR5NjdjNWVWNi83UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L6AtFhvg6wwmbSPE7VOyhp1NSnUA+Y1jSXk1nIGDEXn+EKFEVL2FMYXMqXLRT/55p38+/+TodWwtndmzmIKy7DiyaHnGF3eoQ+Pne5DIPtyOpvUpZ9zMO9njKp+qlBdAANN/2NebIBwiYSU21z1+9kU8Rf/+OMmmBzV6j1Zp1c8zfstiGlddUjhltOJW64hCXPcbIyPBADtfra6BDWE2wbZ2roOeVs9L5rYfpZifAkBZjQ4wIkumrayxpB9MzkCVA82O359gD4YpKZJz/qS2EL20mm6AtZbVIE36vgc84Ae3TUZ5Ff9HvvJZPw69+usk7nwqbcSTvmQu8w1xn3I6Cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca99a116-ca94-416c-f9a9-08de85129962
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:20:06.1227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UMbtD9YJqE0DPz0iCFVECRVj1vY3S8rTDvqVRnHnWfNS6V1HaUehnnvVJViJ+XBaykQlRoNgIX19W1GNFYm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227133-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2DF1A2C0BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBNYXIgMTgsIDIwMjYgOTo1OSBBTSBncmVnIGstaCB3cm90ZToNCj4gT24gV2VkLCBN
YXIgMTgsIDIwMjYgYXQgMDQ6MjY6NDRQTSArMDAwMCwgTGluLCBTaHVpY2hlbmcgd3JvdGU6DQo+
ID4gT24gV2VkLCBNYXIgMTgsIDIwMjYgNToyNSBBTSBncmVna2ggd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIE1hciAxNywgMjAyNiBhdCAwNToxMDo1M1BNICswMDAwLCBMaW4sIFNodWljaGVuZyB3cm90
ZToNCj4gPiA+ID4gT24gVHVlLCBNYXIgMTcsIDIwMjYgOTozMiBBTSBncmVnIGstaCB3cm90ZToN
Cj4gPiA+ID4gPiBPbiBUdWUsIE1hciAxNywgMjAyNiBhdCAwNDoyNzo0NlBNICswMDAwLCBMaW4s
IFNodWljaGVuZyB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFR1ZSwgTWFyIDE3LCAyMDI2IDQ6NDgg
QU0gZ3JlZ2toIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBUaGUgcGF0Y2ggYmVsb3cgZG9lcyBub3Qg
YXBwbHkgdG8gdGhlIDYuMTItc3RhYmxlIHRyZWUuDQo+ID4gPiA+ID4gPiA+IElmIHNvbWVvbmUg
d2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8gYW55IG90aGVyIHN0YWJsZSBvcg0KPiA+ID4g
PiA+ID4gPiBsb25ndGVybSB0cmVlLCB0aGVuIHBsZWFzZSBlbWFpbCB0aGUgYmFja3BvcnQsIGlu
Y2x1ZGluZyB0aGUNCj4gPiA+ID4gPiA+ID4gb3JpZ2luYWwgZ2l0IGNvbW1pdCBpZCB0byA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFRvIHJl
cHJvZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJlc3VibWl0LCB5b3UgbWF5IHVzZSB0aGUNCj4gPiA+
ID4gPiA+ID4gZm9sbG93aW5nDQo+ID4gPiA+ID4gY29tbWFuZHM6DQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IGdpdCBmZXRjaA0KPiA+ID4gPiA+ID4gPiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXgNCj4gPiA+ID4gPiA+ID4g
LmdpdCAvIGxpbnV4LTYuMTIueSBnaXQgY2hlY2tvdXQgRkVUQ0hfSEVBRCBnaXQgY2hlcnJ5LXBp
Y2sNCj4gPiA+ID4gPiA+ID4gLXgNCj4gPiA+ID4gPiA+ID4gMWJmZDc1NzUwOTI0MjBiYTVhMGI5
NDQ5NTNjOTViNzRhNTY0NmZmOA0KPiA+ID4gPiA+ID4gPiAjIDxyZXNvbHZlIGNvbmZsaWN0cywg
YnVpbGQsIHRlc3QsIGV0Yy4+IGdpdCBjb21taXQgLXMgZ2l0DQo+ID4gPiA+ID4gPiA+IHNlbmQt
ZW1haWwgLS10byAnPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+JyAtLWluLXJlcGx5LXRvDQo+ID4g
PiA+ID4gPiA+ICcyMDI2MDMxNzMyLXNpemUtdW5mYXN0ZW4tIDJiZjNAZ3JlZ2toJyAtLXN1Ympl
Y3QtcHJlZml4DQo+ID4gPiA+ID4gPiA+ICdQQVRDSA0KPiA+ID4gNi4xMi55Jw0KPiA+ID4gPiA+
IEhFQUReLi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGNhbm5vdCByZXByb2R1Y2UgdGhl
IGZhaWx1cmUgd2l0aCB1cHBlciBjbWQuDQo+ID4gPiA+ID4gPiBUaGUgcGF0Y2ggY291bGQgYmUg
YXBwbGllZCBzdWNjZXNzZnVsbHkgd2l0aG91dCBjb25mbGljdC4NCj4gPiA+ID4gPiA+IEFueXdh
eSwgSSBmb2xsb3cgdGhlIGluc3RydWN0aW9ucyByZS1zZW5kIHRoZSBwYXRjaC4NCj4gPiA+ID4g
PiA+IExldCBtZSBrbm93IGlmIGl0IHN0aWxsIGhhcyBpc3N1ZS4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRyeSBidWlsZGluZyBpdCBhZnRlciBpdCBpcyBhcHBsaWVkIGFuZCBub3RpY2UgaG93IGl0
IGJyZWFrcyB0aGUNCj4gPiA+ID4gPiBidWlsZCA6KA0KPiA+ID4gPg0KPiA+ID4gPiBJIHRyaWVk
IHRvIGRvIGl0LCBhbmQgaXQgY291bGQgYnVpbGQgc3VjY2Vzc2Z1bGx5Lg0KPiA+ID4gPiBJIGNo
ZWNrZWQgdGhlIGNvZGUgYW5kIGNhbm5vdCBmaW5kIHdoYXQgd2lsbCBjYXVzZSB0aGUgYnVpbGQg
ZmFpbHVyZS4NCj4gPiA+ID4gQ291bGQgeW91IHBsZWFzZSBzaGFyZSBtZSB0aGUgZmFpbHVyZSBz
aWduYXR1cmU/DQo+ID4gPg0KPiA+ID4gICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9z
eW5jLm8NCj4gPiA+IGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9zeW5jLmM6IEluIGZ1bmN0aW9uIOKA
mHhlX3N5bmNfZW50cnlfcGFyc2XigJk6DQo+ID4gPiBkcml2ZXJzL2dwdS9kcm0veGUveGVfc3lu
Yy5jOjE4MjozMzogZXJyb3I6IGxhYmVsIOKAmGZyZWVfc3luY+KAmSB1c2VkDQo+ID4gPiBidXQg
bm90IGRlZmluZWQNCj4gPiA+ICAgMTgyIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGZyZWVfc3luYzsNCj4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBsb2cuDQo+ID4gSXQgc2VlbXMg
dGhlIHBhdGNoIGlzIG5vdCBhcHBsaWVkIGNvcnJlY3RseSBhbmQgY2F1c2UgdGhlIGJ1aWxkIGZh
aWx1cmUuDQo+ID4gRm9yIHRoZSBvcmlnaW5hbCBwYXRjaCAxYmZkNzU3NTA5MjQgKCJkcm0veGUv
c3luYzogQ2xlYW51cCBwYXJ0aWFsbHkNCj4gPiBpbml0aWFsaXplZCBzeW5jIG9uIHBhcnNlIGZh
aWx1cmUiKSwgYWxsIHRoZSBjaGFuZ2UgaXMgd2l0aGluIGZ1bmN0aW9uDQo+IHhlX3N5bmNfZW50
cnlfcGFyc2UoKS4NCj4gPiBUaGlzICJmcmVlX3N5bmMiIGxhYmVsIGlzIGFkZGVkIGF0IHRoZSBl
bmQgb2YgeGVfc3luY19lbnRyeV9wYXJzZSgpLCBhbmQNCj4gc29tZSBlcnJvciBwYXRoIHVzZSBn
b3RvIHRvIGp1bXAgdG8gdGhpcyBsYWJlbC4NCj4gPg0KPiA+IEZvciB0aGlzIGFuZCBiZWxvdyBl
cnIsIGl0IHNlZW1zIHRoZSBsYXN0IHBhcnQgb2YgdGhpcyBwYXRjaCBpcyBhcHBsaWVkIHRvDQo+
IGZ1bmN0aW9uIHhlX3N5bmNfZW50cnlfYWRkX2RlcHMoKSwgd2hpY2ggaXMgdGhlIGZ1bmN0aW9u
IGFmdGVyDQo+IHhlX3N5bmNfZW50cnlfcGFyc2UoKS4NCj4gPiBUaGUgZXJyIHNob3VsZCBiZSBk
dWUgdG8gImZyZWVfc3luYyIgbGFiZWwgaXMgYWRkZWQgdG8gZnVuY3Rpb24NCj4geGVfc3luY19l
bnRyeV9hZGRfZGVwcygpIGluc3RlYWQgb2YgeGVfc3luY19lbnRyeV9wYXJzZSgpLg0KPiA+IENv
dWxkIHlvdSBwbGVhc2UgaGVscCBtZSBjb25maXJtIGl0Pw0KPiANCj4gSXQncyBiZXN0IGlmIHlv
dSBjYW4gc2VuZCBhIHByb3Blcmx5IGJhY2twb3J0ZWQgcGF0Y2ggZm9yIHVzIHRvIGFwcGx5Lg0K
DQpZZXMuIEkgZGlkIHJlLXNlbmQgdGhlIHBhdGNoIHllc3RlcmRheSBmb2xsb3dpbmcgYmVsb3cg
Y21kLiBUaGUgcHJvYmxlbSBpcyB0aGF0IEkgY2Fubm90IHJlcHJvZHVjZSB0aGUgZmFpbHVyZS4N
CiINCmdpdCBmZXRjaCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9zdGFibGUvbGludXguZ2l0LyBsaW51eC02LjEyLnkgDQpnaXQgY2hlY2tvdXQgRkVUQ0hf
SEVBRCANCmdpdCBjaGVycnktcGljayAteCAxYmZkNzU3NTA5MjQyMGJhNWEwYjk0NDk1M2M5NWI3
NGE1NjQ2ZmY4DQpnaXQgY29tbWl0IC1zIC0tYW1lbmQNCmdpdCBzZW5kLWVtYWlsIC0tdG8gJzxz
dGFibGVAdmdlci5rZXJuZWwub3JnPicgLS1pbi1yZXBseS10byAnMjAyNjAzMTczMi1zaXplLXVu
ZmFzdGVuLTJiZjNAZ3JlZ2toJyAtLXN1YmplY3QtcHJlZml4ICdQQVRDSCA2LjEyLnknIEhFQURe
Li4NCiINClRoZXJlIGlzIG5vIGNvbmZsaWN0IGFuZCBJIGNvdWxkIHBhc3MgYnVpbGQuDQpOb3Qg
c3VyZSB3aGF0IGlzIHRoZSBkaWZmZXJlbmNlIGFuZCBsZWFkIHRvIHRoZSBpc3N1ZS4NCkNvdWxk
IHlvdSBwbGVhc2UgaGF2ZSBhIHRyeSBhZ2FpbiB3aXRoIHRoZSBwYXRjaCBJIHNlbnQgeWVzdGVy
ZGF5Pw0KVGhhbmtzLg0KDQpTaHVpY2hlbmcNCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBr
LWgNCg==

