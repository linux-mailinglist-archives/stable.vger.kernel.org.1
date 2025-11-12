Return-Path: <stable+bounces-194566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C1C50854
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 05:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AC3C34BD0D
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 04:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82912D46C8;
	Wed, 12 Nov 2025 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRvIdtWU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71342BE035
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921775; cv=fail; b=kWLi+E7MSKRJfxFLXaxCLMYNZqF4iXlMssQ1WONIlivVdqVLqjv0/vykU9NxUW4eS7D8va3ku2DUiR0HDnXdiHS0Hng6GfXFFQFEfTNEbgpbz3L6hx2RI4fbDV6thMlTRlUkeCuFh6mv2l180aKQ5l3Cpuod3fjNhCkaWdD9GTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921775; c=relaxed/simple;
	bh=1GYjq4PE+ei0osweG8zNGg1rzrVz9EyDAb6qAPw8zQY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPKR4mQfuwvvjhO9D7SQSv5Q4oEteJk5DTaWTX3aGZbXYLBHi2TuVIbDUveJufH/Vn9w1+N6T6sE+D86tOfxxg1yRF2IgKI32T4UdtOlWolo/ok5sdjWIEl4rKKH8oo3eIiQd9XCBw104QaxeHPCS3nkPOtLqsFhwVSpPW1JL0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRvIdtWU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762921773; x=1794457773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1GYjq4PE+ei0osweG8zNGg1rzrVz9EyDAb6qAPw8zQY=;
  b=fRvIdtWUu0XH4yb0OhHE+ZPLjTkWEK/nVWnYC/hINhDbxcaAN2t6eFGI
   h4d6CTcZqEKasKGxgBn6uD6rPiXJeOPlOm4/a06IPMyixJpX8bemPMu+i
   GSso2YvrybBDGOxL0VearIv8Wn8vOZ5kJhYRRyaCglYVfRYcvTItdr2Cb
   KmwX945GRS8gpMssnqLIj1WKKuff4X9nruuXua7yyh8QUHIrZ4/K8b+eV
   TVquPEfj9/Kg0Yd4Zgpf/N2nD3C2tEqJWeNfHPWuLvlwoaq5z4SZn+7mL
   x264Pjm6pwibGKS9ZA7Cn/YOE2D9oYGRimPDVPVOsSrNSJ1yNfmgOuZEj
   w==;
X-CSE-ConnectionGUID: eR741lk7SzWAfUywmNfSwg==
X-CSE-MsgGUID: FcWXqC6tRWOYN9V1e4lxIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75285075"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="75285075"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 20:29:31 -0800
X-CSE-ConnectionGUID: 7L0MJsEvQ7CPT9vtYhtsUQ==
X-CSE-MsgGUID: bY1Py5vnQcyJ4koG075kLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="226368214"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 20:29:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:29:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 20:29:31 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:29:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZLBb1bnNCAK2pgOmwiIwwMMzng32NlKpYC6wmpGwuEcnZfm0MddkzhtPoHiFzerfASuACt5f0rnPXDGACL7cXpNcrUy8lB0SStpcJjKBv3umIxqLlO68/bzL8kUtRosaSTMP7AgpJD1lR36WgC1eg/ql5Vv+hZaS1QAxLwRJ652alM5TjglKAuAb5JLogT97WrHwx1i53OH3Z+d11MZ6vrmEiKdamI2VQ7q4DEPismvZ3gycjv3Hpua+Y7oJAksLll7h1G2Mt/B8mi6Ar+CxDogcEjDqs7Vf92ko8gHb7Frn05ODy0i0b+8z4zn1zqYbaPqscZ/neknvt/3VSX1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9m+em460cZ851HSnxVHWNNSbcjNJnXS37maoSIcxOM=;
 b=Swqtu+/2KI1sv+tqypo535E+JTTQ3ptKntL1g3SW4PxcX6V49LpDTMa0P/RxBgzCPvSTAAdEAtComGfPblSl/f4fhxW96HLO9uRG1BDwbaY0rUP/Z5c3wLLtSpKKyBxfxPYwV2a/3N7LUiIhdXLFfD/tH2tCBJV/YMDww/66UBH1ICHLYrDh7EFO4GRAagvUpV/7JnwUVfLtlI3xG9y2Q4VAJRzn8Qp9BSuUUVRgPUTG1+G9HUT2K61TgR5VmKeZir8BUK9XjEYSxTVwvx6YK0BtlkJNFEk6GjYa5SgJwg1RMVdgGlDhx87+RaJQ/vrQR60IUHwTpQEccWfcVagVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by LV4PR11MB9466.namprd11.prod.outlook.com
 (2603:10b6:408:2e3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 04:29:25 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::803d:39cb:d276:4ee5]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::803d:39cb:d276:4ee5%8]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 04:29:25 +0000
Message-ID: <8245627f-657d-41a4-a931-7dabd1406548@intel.com>
Date: Wed, 12 Nov 2025 09:59:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] drm/xe/svm: Fix a debug printout
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <apopple@nvidia.com>, <airlied@gmail.com>,
	Simona Vetter <simona.vetter@ffwll.ch>, <felix.kuehling@amd.com>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	<dakr@kernel.org>, "Mrozek, Michal" <michal.mrozek@intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>
References: <20251111164408.113070-1-thomas.hellstrom@linux.intel.com>
 <20251111164408.113070-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20251111164408.113070-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::17) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|LV4PR11MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 482d2403-4bc1-4f85-051b-08de21a40f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEtiN3BEYTFYS29WMjYxVkM3bWdTVVlHWTF1cjBpTTVMWFVxU0tGQjdqQ1hJ?=
 =?utf-8?B?S3VEcFpzUHZlWlhpU1NhSlR1QkFjR1JHR0o0MVU3QTExMmx6dHRSYTlDZUYy?=
 =?utf-8?B?RkExU1ZYTHExbDdLeXYvdWF3TVl4UUhkdnhxOThXa2VQUCtycXpvOWM3M0Nz?=
 =?utf-8?B?RThwUTF6cHFPQlJvblVvU0pTVzRwaFNzVGwxU1N2QWF6VjJZcHMzZGJ1YXFJ?=
 =?utf-8?B?VXJnTXc4Z0E5cEJjQkwrYWlqZytPZmxDUCtyaXk2dXk2b1NpS1Q5SUpRVDhG?=
 =?utf-8?B?OFJnYkZib21nTklZeWRFUWJVbFJUV2tFUzhScEJ4dHZwSWd2aDFjcDRQbU5R?=
 =?utf-8?B?RDdqdzR1WXF0bENLN3JKY3ZtSzJMbHNJZGEyWlNjLzBaazc4anFjUXd1aDZw?=
 =?utf-8?B?MHlBeWQ4V0xVcVZWaWFKZEMrTGhvUTJNalg5czhYekJzNmg5WjFxU2dTSkRP?=
 =?utf-8?B?T3BuRzNmeGlSRTZWZUw4aFBNYTlETzIzSnBEeGJ0bHQxUDZMY2dCblhFdWh5?=
 =?utf-8?B?c3M1TXlpRHlqSERKbUdJQU1vNnJ2eGNtT2ZEcnZmQWxlTFpkZGNUb2JsVjRU?=
 =?utf-8?B?aUdJTW90VjdCd0dZOWxUTUZTdHZkelBOd3NLRGhVTUNDVWQvOHJyS1VCTzA5?=
 =?utf-8?B?S1pONXlYeGsxLzNmSjZ6ckNxMWZvc2grTXNESTdyRGUvSjFNUTlOeHdCY0py?=
 =?utf-8?B?RW5DaU94MFk1WHhvWFdHdytocUQyQ3J0WXdHbjRONFNlbC9YTStVVEs2MXla?=
 =?utf-8?B?amJKTzNmWDZBaS9melFJOURKVlB4NitQRjRzSVRvTEhGaTRXT25XeFplVmVW?=
 =?utf-8?B?UGVRM2wwcXk2MnB0RjNzaEhUY3g4V2Y1YWp0VmFHcDg1aTVmb3lPdjFPcmdH?=
 =?utf-8?B?OElhbm1XZU5SejNuZWJHV0dOY2pYdzJqMHBpeEIzZmhDS1gzd1NnVzhWTlVt?=
 =?utf-8?B?MURmaVFKcnIvcEJBdjkvNzhGN1MwbTdQS0JnTEJlYVVtY2lYTmFHc3RyOVNZ?=
 =?utf-8?B?ZmkwNngwVzlWUWo0djRsVUlSWDlJcjhTNnh4N296ZWpEdVNVWHNFTEJhdlI2?=
 =?utf-8?B?SVJ6bHcreFBoWnQ2SHlpQVNOVnRMT0FkL2dFVFN1Y1BsT3lwVWR4aFFpZEhV?=
 =?utf-8?B?emwweXdwbUo1UEQ0bEZnb1E2YmNwRUhJOXdwQ2ZhR3RNc3RJSExIeTlPNTVr?=
 =?utf-8?B?NG5PZ081ckpIUXVmTHo3UnhYNmxXZFFWbmkraERYVnFidVowOTZDb2E2My9k?=
 =?utf-8?B?MXVDZnRrc2RzMDdidzZrWmlOcFpUYXZ5bU53d3hEL1BOaWVES1VXNkV3L3VS?=
 =?utf-8?B?ellUNDJrZCtFaURtdWlidHgzdzB4NVVhY0ZlSlZ5QTk3WWFSc0htcWsxV3hD?=
 =?utf-8?B?NGVXSUR1Y2xJSzlLbCt6djgyUDhlOHBlTVViY1E3TTNjTy9xeDUvUVFvajBy?=
 =?utf-8?B?QTZRYnFieHdRbTRuSHVncnlPNmQydXd4RmJkWmE2ZDFwSlBCamRwbHpSVmhQ?=
 =?utf-8?B?Y2w0QURzZEZEZ29qc0p0eHRrV09tdXZtS1dka2IwTW0vM1h0R1Npam5SV3J1?=
 =?utf-8?B?QWkyV3dFQVMwc2RuK0RYdFA3WFNLc3prVU95MnR4QUtpTGFjNjNBc0Z1VDFm?=
 =?utf-8?B?aWpGL0Q3S0pROVVaK1Fsd3hqOXVIMGplMzUzaklncGZ0UWdMVVlXd05ETEhN?=
 =?utf-8?B?NDh4ZlBlbi9TZHBYUkFFUEZjV1YyaGxlWDdraGVqbWUybWY5c21zZ0twNXZ3?=
 =?utf-8?B?NVEvTHRMVWhNYjA4d0RLdWFKZXNhRDg4NXdtZkpTeXJIa2lFc0pGSUNyYlQy?=
 =?utf-8?B?R0ZYanhmbi82cGhmL0NCWkRzeS96ZmlOK0ozOUdwUXBsNnRTKzBjN0Vsckg1?=
 =?utf-8?B?MlRGaEdVYzJXM0RDR2JwUjdMREhjalZqdUc2czVpenFhL3dNTEM3Q1VGVjh4?=
 =?utf-8?Q?DaE0+vRVsAO/mAAZ4IlnhcwnBPJqD0pA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF691668CDD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVGeUZoUG00TkxaMlhLNER2OEJ1eXpXYXVWMU9PNUROaDFSVkpDOHh5L3N6?=
 =?utf-8?B?cXdzU2owZXdJSmhGeENOV2E1c3pJbFFkcTR1aUNjdUxtdVYyRHZqbnhFeHk1?=
 =?utf-8?B?bHkvdG1IYm1rN2NZV1FlU2h0cm11ZWorOEpZLzRPM0NLQjFwNGpmTVRvM3lG?=
 =?utf-8?B?VklYQ3hvTElMM0ZEN2dVdFIrejNac2hQbmJiWEx6Zi91ejFoUkh5MGREdXdh?=
 =?utf-8?B?VDFDeFdySE11QWNMZWpZRFBwZUtSSENHV0FlUTJiTTU5NithOVM4SWNvWXdO?=
 =?utf-8?B?aWlLb3ErZUNiazYzcGNIZ01Ka3Z5T2tNRjMwNTY2YmFrWFZXOW8xaFJiTnFK?=
 =?utf-8?B?NjZXUUU3VG5qZlE3WFBtdlJvMGN2Y1R1ZGZvVEdtWjROVGhxbmorMVB4Zmhy?=
 =?utf-8?B?dHlQeTYzK01mb3Jpd0V5TTNwZHM4RHI2S09peXhjeTdBaGQ3WmZFNm9naDQ3?=
 =?utf-8?B?a0hmTUNyY21FSkxZS1ZRWmtHdlFucW9hTkNKSXZldWsvbGRiYW9nbjJTZE1Z?=
 =?utf-8?B?ZDZBZUxvMnJLWHRwNHNMdjQ3QTl1NmxXcFRpWUx2Mm5ZbllDWlFpbVZtSGxI?=
 =?utf-8?B?Wk0vSjR3NHdxZmlybkdKL3NPNVFTcTJGTE1ZYnBJR3JvM01waTBoVS9sV04z?=
 =?utf-8?B?Slc0VjZSR3p4dTlibW9SNXEvY0E0WlBYeWhwK3E0S2ltWGJjOGltcDcyMWxS?=
 =?utf-8?B?RmNNRlpzSlJiazBjTmhkUFF3czlqUVNwZEUzQWtiMlJyZmpTSGErWlJkajhZ?=
 =?utf-8?B?ODBYUUlFRTNtUHJqK01MUHdaUmdyUHFtSlJoaGZ4SVJmUm5YWVNKZTdiQ1Rs?=
 =?utf-8?B?WG9vcjlONWZUUUliM0xhR3FoOGswQUxpVGhxalhlMHBRNytmTHZPSWhYSUw5?=
 =?utf-8?B?N0FMK2MrdXhOV0xHbTJDWlFmbDVpV1dHMVZIOWthd1N5aHBGM0FqaUpMR1FP?=
 =?utf-8?B?MlNSY3RMU0w0Y0c1STZSazlETVJOWmxKaHRXU3k3VDB2ZlV5clBic3Q0c3d6?=
 =?utf-8?B?aDgvbHQyOWZ1SnZ0MVJMWVNYV0VDcVAvdG5mQ3BkMHd2Q2RNb1E2ZnhuNitO?=
 =?utf-8?B?aG9LTFpXWnNsKzU3YkVKdE9JRnMwSkJmVHUxQUE0SjF6VlRocTZFUkFqVmti?=
 =?utf-8?B?aHJ2Und1TmdVeVI3RUt4ZE9jeG45anY3TE1Cd05RbHMzUEFZZ1VpbEEyQ3NZ?=
 =?utf-8?B?UEpBelREZkhTZkkxdHllR1I3dGwvbksrVEFqbE1Hb0xNWXZoQXBULzZ5RkI2?=
 =?utf-8?B?OXVPSDVEUlVJczRaWWpySWlTdTAwU1NPY0NudDAxTkMyTnJXNmE4Tm92V3NY?=
 =?utf-8?B?TFlDdlB5blVpTUg0ZVpYL1ZBOVVxRjlTeVpaemNSRUx4ZlZXZXpwL2FIZDMr?=
 =?utf-8?B?S1NTekd0a3FIeWJQRUIvN1hlQXV3dnY3OEo1cnl6ZFJNUUcrMzBZZkpDM0NZ?=
 =?utf-8?B?V2U5b2gwRTIyekV2MDF5M0JsUEtwd3BWOTlSU1JhTkN0TmVZNytVYzh3SGN5?=
 =?utf-8?B?eUtuZThJd2pNaHJ3b2xKTkd2M2FHcHlpSmFJQVFiZStQUEVZUHA0Q2dnTFB0?=
 =?utf-8?B?cmt4bzF2b2J4c2w5T0hpbmlHeERKanR1UHRXMVNXWG03WmxSU2VpOU9QNFFX?=
 =?utf-8?B?UERQZ0J1bDVuM2dZdWhWZWtiQ3UvaUF2cVdudFZyN1dDek9sMEhrbzRYRGho?=
 =?utf-8?B?NU5DV2pZc2tVUXduYlAwWDRuaXNKNEh3Z1pzWFIvYitMREJRNzRMN2JLc1JZ?=
 =?utf-8?B?Q3daTzFYNURRa1dzZG13UXZzUTBEcGNlZGVmbmhQVCtCNkEvcXNjc1FzL3ZN?=
 =?utf-8?B?SENlQ1hPUm82TW4vdzNmSGpzQ2kvUnI5cFZua2VpM3YwaUl0czMyZ0p5dmFq?=
 =?utf-8?B?L2dBWFdqaE0rSjlZTE9EYTU5cVdXRWRnQWRzUUZQVk82cEZKSWNaY2hMRDJR?=
 =?utf-8?B?VWkvQVRuMjdIVlgrTnpuVVJnM1ZzWlJRVlgzS2RsMUZHQUdDNnlqVXI5WE4z?=
 =?utf-8?B?WWc5QjlEbGVhWjFZdnZ2QWRPR005S3BteDFqdG5BQUd5dy9SSFVGN2svcDdC?=
 =?utf-8?B?eEF0RXpvbFNGdS8yYlBsWXl4VEVZaVQ3Vmx0RXhaZE44MUtISVIydjFtYUJS?=
 =?utf-8?B?S1kzT25nWUdPU1FwNGx0MWt5UDBhRHlUQkR0WHpmNFdXb1lqcXJ4M0ZKd1Zi?=
 =?utf-8?Q?jJ0z42UdAcpfgKyuPLQj8Gg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 482d2403-4bc1-4f85-051b-08de21a40f27
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 04:29:25.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e97c/YbQnnuDyHMtdZFKWL5lgMtkMzuiqxARYHfbuLrrWt5GGwNFF1KwgZpWuv68OgV/rKciwGxYz9rOQIM93MFQ5qljQBFwfUnnjbS3xKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9466
X-OriginatorOrg: intel.com



On 11-11-2025 22:13, Thomas Hellström wrote:
> Avoid spamming the log with drm_info(). Use drm_dbg() instead.
> 
> Fixes: cc795e041034 ("drm/xe/svm: Make xe_svm_range_needs_migrate_to_vram() public")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: <stable@vger.kernel.org> # v6.17+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/xe/xe_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 55c5a0eb82e1..894e8f092e3f 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -941,7 +941,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>   	xe_assert(vm->xe, IS_DGFX(vm->xe));
>   
>   	if (xe_svm_range_in_vram(range)) {
> -		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
> +		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");

Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

>   		return false;
>   	}
>   


