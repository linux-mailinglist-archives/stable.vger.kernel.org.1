Return-Path: <stable+bounces-254619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPLSK7QRF2o12wcAu9opvQ
	(envelope-from <stable+bounces-254619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:45:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE555E71A4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 135493031C0F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C342E006;
	Wed, 27 May 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsECVQdy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EC380FD7;
	Wed, 27 May 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896714; cv=fail; b=cPovBBWbPhOUbvY29/iwBKYtXWN+DG4iw2T5U/w+R6fS98LIdredRe47ATVt3gvAt1k9O/GE7VyFIVifDU/PLdyEX2Gte5MMPT1azCs5Do9L/TPol27E2f4wrUn6U6m9IPfP0Igv9F7OxNB3yrTUZ9hUQ7kcA7hSRGgIQJqUukQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896714; c=relaxed/simple;
	bh=ROE7sh+d+weeqeACN/QXHO9fXgSyglSkQ8ynFsTuzaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vwko0evQ8NaZEHJSPr7MCZSpBFnRZeXsxZ9H17UaB04MzfMiwJCKvZYvYzuPUVzEbm69/GHDMM3zNLd4jkHzif+eoh1MD3J9BdIhPDRTZ68izTuQGqKlmC242N64IzldXfV6H/nn0hB+l+g5MjotcZkC1jKtcric5CF8/EqCZPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsECVQdy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779896713; x=1811432713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ROE7sh+d+weeqeACN/QXHO9fXgSyglSkQ8ynFsTuzaU=;
  b=HsECVQdytFbXj9z6DCyZfNk8BX2V7G44NDrG/8WeXrSJVw4qCSusASyE
   LZivQKjAQ+jFczK/2hDH4aar4/fTP61KbwKbeU4C9hBIK19RywMWEXxGC
   2e00Kd0G3AlU30Cc1S7jGsluiRSvW5F6y0YJ9qPGi6nN+HfuOESWQfNCM
   Cmv59huDzwOBAfQ60U/nJpSe7CWqn4MvtP/z3JCk6kZIPAJD5ntx9Da2K
   yGo28/eYJQDMhNsp+0tyubT0lrBA5oXTtz6meSpzUTB+4ZJwQaPc0lyt4
   i7hQ2Xc2vBltuAWTMzmdFU1+spnTsrMhmZ+S0/z9qFCQc+OlyY/PCVIpe
   g==;
X-CSE-ConnectionGUID: SwBN+8uySFWL0peZVet7KA==
X-CSE-MsgGUID: ou4n8I36So+9SWgRLFofZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92205685"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92205685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:45:13 -0700
X-CSE-ConnectionGUID: cqjY5EcWR5uK0jtxT/RYEA==
X-CSE-MsgGUID: RXy2by2kRMWJZIyzFUmDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="265890400"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:45:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:45:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 08:45:11 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTrY02stvlXNdVNktd/qgBnD9P6urh4TJ9uW9smkHVLLyzHIT+w44UPfAeAV1WU1o4L+InkF0NOU2RLI+v7WbbKmVDHJ+eh+UObF3etXAJsApbJQa3RPTUCOCRr0yvCxVO20EiGkoaY1ezyZyOgxsuAL9aGbagay1GS/ags8QX/CYAH1rX76LpkwOmEtEZ+TqmxlRU23MSraogoOyY0i6b1oUKUxJEVs7xpAYSjcE709v+87z+NKAaYnUMpwiK/waApDOdfamAvb3JlOc8gA8Fc5jIbrYqfr7q/jqFm3+Yo3oxH38NhKS0BhK6FYsHN/x3hMrEIzti1QHJbDtZQXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROE7sh+d+weeqeACN/QXHO9fXgSyglSkQ8ynFsTuzaU=;
 b=JBV3z70jV4A3CCHhFiWWqPkPMcHdGdJ/oQyCBPCxm1PxcIVw/RJ58Mm2I/gGUgQQwQLCLIbMSZyv++uvCwQQIKN5f0pVViUm8UAxPxMy0lmYbioruoI6K72VlfnpvbVe8hEZom4ogaPXLfK+6xPBjUnGIl1GmcLq+FgBPjQZyU7R04I59wjpIgesXrB2lZK9Rc/HE/1FAtlFnt5xZ5YyqNpVqAwS1CE6hgHpzJUgnfQjT2/+DzYQ6yi5UGmmpFTKfPzGb4MHt/3OI/wVOZOCsC/QscZpc5wpCctDD5MO5PwQjNMECfK+V6Y7SHQCXSXIbPG6F6Rw8C6Uo1g8VOc5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 15:45:02 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:45:02 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai"
	<kai.huang@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tsyrulnikov.borys@gmail.com"
	<tsyrulnikov.borys@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Thread-Topic: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Thread-Index: AQHc7dE+s0lAAUnf2UylZ3v+STpSWrYiBKAA
Date: Wed, 27 May 2026 15:45:01 +0000
Message-ID: <bd2de640c769ba2460a92afb79fd50e9316d8594.camel@intel.com>
References: <20260527120544.2903923-1-kas@kernel.org>
	 <20260527120544.2903923-3-kas@kernel.org>
In-Reply-To: <20260527120544.2903923-3-kas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB8065:EE_
x-ms-office365-filtering-correlation-id: 6f393766-2fa4-49b6-499b-08debc06ea5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: DlLY4xBnyj5V/cK7ymFBMvuQJopiEof+6qUNUmZH7GZnxQJDBvvFhP/06rnQKHyfgDLW4K1sX4M50NcUyEvhMDFfPI7YnXItrgRYWu5TI9EYTKYife3YgMeDIVc7h3791tJfpHCoFi4Mal/rAnohFPo85DRCF9XBZQhGgMs5N9fawWaXeAk2zBEHev9hLfAIIjji/hG3/Se5/Lm1ETezNgB5+yynwC54vhkDgoBtILryTZu+5WCtYf/r9ONjbpr46zCFw+JbJawzU3HhUoshRS698DYzcwPmoXN3RjfQMP6ABo+a3aHxXX/v24J7dBt39lRnd7QXFWl9dKdfDWnCpvlBQ4vVRplMjzfdEi4UFZBU8QvmyZynjJoLUYWCxlXLzs48gJhRVti7RviM7KqQ9I8JPHw0PbVKCME94jsSLBj8eq5UXuErddRGVCebP9/4i7zN1UYHan4i2hF3n0WTUNIyYWu2QCZcV9l8VwpXgd4xTqRvu2mIDUzckrS5qkBYqD0gXE8OIwW+GJ/1Z4xPxVLqBqNeJKytWe6ZvhulOlD+AtmW+1vitsir2qhkkvhCGkse+poY1rKnS+UhM8GOLmTMK5VZiNmyC/vY1R1cY5q0p/bmkvW9ec3ucRvCwNaM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1N5WHI5OUpLU3orWjlJYkhEbVNPZDN2cGhVS2gxRzJ2cDVRRzk4RENHRXJB?=
 =?utf-8?B?YkRtS0tVeXZkUU1ialEvWENCN3NuZE5ZMk9zQkI1bDQzMDBSb0ZJNUM3K2xz?=
 =?utf-8?B?MzFvVWprd0JrR2NsTnVZOFFoM1RJeUNhZkpabDl1R25DNEIrZDBTTm81NmNr?=
 =?utf-8?B?R3dZN05HRVo5cVA5dnZVZGd6VUo4bDRCVGNNUHJBN3BONDRpcWV4RktSc3Jp?=
 =?utf-8?B?U1cwRG41KzI4R0NzaG83TFFvbDF3V3RzOEtEdVVzM1JydGEzVVJRUERtaWlr?=
 =?utf-8?B?UGhvYllSalBnL3FkR0RKRGNzQzA3eXd2ekE3K1V4RWVrakRWZzZPMVFFc09I?=
 =?utf-8?B?ZTI3eURpL1Flck1HYmhtVzZJUC80dG9SY0RUVjgwYTlianRudXM5OURycjR2?=
 =?utf-8?B?NC9KQitoVVVCR2FPd1dLdElWT3ZaeTU3b3YzMElJQVdmVlV3aUlITFBBL1Rw?=
 =?utf-8?B?NzNMb1pxalhZZVppcDdiV25MZldlWEVIVVhxK3M3aWFOQVNWUHRyQWVWdFlP?=
 =?utf-8?B?TUdmL2g4dFd2LytLWU5Bd0d6cDZyMEVXSThObmwzOGZrZlVDaFFzRDArNUxR?=
 =?utf-8?B?dzZBd2JBNWgwNWhIUm45ODBHazk4MmFYUXZoUXQ2SkN0dEZsa0x3QUlvUW5O?=
 =?utf-8?B?aXJSRjFuUW9YeXFNdVpHS2o0TitlUVJCbTcrcUp1ZVRBdnBvaFhRWFVkd1NF?=
 =?utf-8?B?N1VsZ2JLbEFBSjhHTy9mWE1pYytuNndjaHk4OUwzUGo3VFFwY3hyelBMU0to?=
 =?utf-8?B?ZDdLRVhXeVdZTTROa1g4T25SVDM3Q0lCbWFBblN1TnloUURkL3ZNbmJVczJ4?=
 =?utf-8?B?R3lvMFNLVFVWa0FMSGVodi9TSnorclk4bFJHMi9PMDJ4WmluSHRwQWpjK1NZ?=
 =?utf-8?B?RnlkT0lMdmpvN0xSTzNudlNHMGtCVi8zTGthT1Rra3FiOHVldUlhSmtlT2g0?=
 =?utf-8?B?QXI0QlJwZjE3VWF1RzdOdkdYNGZPSlFJZjRlS0VXZEVTZHh2a1ovSndhN0pM?=
 =?utf-8?B?YkdJWWpCRkRpWnZIRmFteFVaZFoxdWZlcUlMZHJkT2tGU3dRWXlrTnVLYUZJ?=
 =?utf-8?B?RlNJY3pQMCthcE5VM2NyckVOUk9Vdkx2SDBhcmorSHQrUlJoeVY4OTU0WTJC?=
 =?utf-8?B?Y2UwenNoa0VJcmZkZE8xT2hJSkIraTdyN0h0ZmhMRWVEaDJGd0hreE5aYTdz?=
 =?utf-8?B?Zk5raTJEcmsrSmVsRUM4d3hheHhyZ1VMU0ZPUTBGaDRGWWtOZTdxOWl0TnB1?=
 =?utf-8?B?djQvNHhQOEpHeHhtTDYrcGxNUm50TFVaMnVDU1EzT2RzZ3dwNUpYdnVLT0cv?=
 =?utf-8?B?VEJPQjk3QllsN1pkR1ZkcmxuYWE4TUJ6MW9VeWU5d0RLN0xEWlIxNmhsQ1o1?=
 =?utf-8?B?a1JFTUV3d3hzNDJJWDNlZEdkRkFSRmFGN2d6VmVnaHNTOUdlSTROck5BSzNt?=
 =?utf-8?B?NGR2QlY3WjhhRmVNOEhRbTVIK0huSTlwSkJMSzhxUmVuRjN1WHBZelgwS2Mw?=
 =?utf-8?B?U2M5d3NPVUx2RndlUWRYMmc0TGhQc29CeGpGV3FYQ0JDbEFTRitDNHlhNjJt?=
 =?utf-8?B?UXZBeFpDMlhDRCtqSDFPWUtBVlMzREpIYmF1NkJWQnZrbWdhSXVwS3lncTdv?=
 =?utf-8?B?TEFVbytUZFJ6Q250eFlXeUNlT25VZDN0YkJhL0t5SEF4c3h1Y0d6YnhmekF6?=
 =?utf-8?B?eUJRRHNSNmpnMUZnUXphc2NVNVNNZ0dxeG9PMjR0dzJoeTlUcjR0MzNNTitL?=
 =?utf-8?B?RnR0OUNzTnpTKzQ1QXhMNUk4T3hmQm9wb2tQODVLSmllUTZ2SndlM0NkWTBB?=
 =?utf-8?B?cUlkVU43azRUV1FMUy9lbDVjVmpwVDJKS3BCMzZXV0VlMGM4b3BOdCtFOEJF?=
 =?utf-8?B?ajFrR29ObmdadllsQUl0UmtHV29IUENUNkU4alJzMDhBcWwxbGEyRHlLbC9z?=
 =?utf-8?B?VlJSSXh1RTFYS3BMVC9FMHBhakZoOVZ0Y0VnVFhqZEZXMzZGYnI5bGNpdWsx?=
 =?utf-8?B?WDZaTUU5Y1c1TDZMdnNFQWkyMGhDZktlcmIzMHlpZmdJVG1hdWVFek5yVE5S?=
 =?utf-8?B?eHoxamQ5NURob0JrRmJNa1lmOFFHNUdhbFdwTTNMZHhadW1obTNrdWg1bkMx?=
 =?utf-8?B?c1VJSmxzQno5dHhIdFlsNWNZYjVhNkE2RUM0MURzQzkrR0tFU0IrSE9sb0wr?=
 =?utf-8?B?RUVwTk5lcEpLSkhUYWN1TTZiV0pVOFljTU5XbXhiU0RQdWh5bTNjazZDVldP?=
 =?utf-8?B?RWNxMCs1ZU1WVFQzaU1CN1M0ZzQyN3pyTDF4QnJqU2lENmhuWkZveVFkTitB?=
 =?utf-8?B?SkF2b0xoVi9JcGpBblNVZ0hvdkFmWFA0NzNNNnNENGVCS1NHYUtBdGgvS2k1?=
 =?utf-8?Q?oGlPPKs3Sk1piv9c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFEEA5CBEE4BD34C8304877AACF20E74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dzqkWXXyVxJD3/uTU7fbAImAvFnu4qhAx8ueQMUZarBvrys/UkEBjZlPNOixEWqTWUAWQr84EHG/SZbpGfsozH90jOnPGqDQ1cv/Z4t5nvK5V5yiYIT/nbz44VxHrUtEvBITDTL+yfMfQ3ixrS5Wgdt0fvY7BV7Tl9JU50pfIddePZSPrQV8eow/c2GPhLv+snJNqJT+cma7v/IRWa9CYnUQDldSWQwZbBpSSc7m4/qdZIAa7MLqcb6kXYJonx0U3nIOqK/8l/wHm+1K5GxWMn5zLVyBfZEJGXUKP+OneifBpFqJN+AGGAyZD72AsY4n63GKGesF0c6vGiifad9d9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f393766-2fa4-49b6-499b-08debc06ea5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 15:45:01.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gA+aH5lrTrC4r5n/qhtCQIli3qJ7LIpGoxZvmnRrdn0/VtXU0UudtzqzDpEfCmRappG5BwfYZu0aV49xGKHNY7smCPcftgthpEL/evbuwv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254619-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,intel.com,zytor.com,linux.intel.com,vger.kernel.org,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5AE555E71A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTA1LTI3IGF0IDEzOjA1ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IHdyb3RlOg0KPiArCS8qDQo+ICsJICogSU4gd3JpdGVzIHRoZSByZXN1bHQgaW50byBhIHN1Yi1y
ZWdpc3RlciBvZiBSQVguIE9ubHkgdGhlDQo+ICsJICogMzItYml0IGZvcm0gemVyby1leHRlbmRz
OyB0aGUgc21hbGxlciBmb3JtcyBsZWF2ZSB0aGUgdXBwZXINCj4gKwkgKiBiaXRzIHVudG91Y2hl
ZDoNCj4gKwkgKg0KPiArCSAqwqDCoCBpbnNuwqAgZGVzdMKgIHNpemXCoCBiaXRzIHdyaXR0ZW7C
oMKgwqDCoCBiaXRzIHByZXNlcnZlZA0KPiArCSAqwqDCoCBpbmLCoMKgIEFMwqDCoMKgIDHCoMKg
wqDCoCBSQVhbIDc6IDBdwqDCoMKgwqDCoMKgIFJBWFs2MzogOF0NCj4gKwkgKsKgwqAgaW53wqDC
oCBBWMKgwqDCoCAywqDCoMKgwqAgUkFYWzE1OiAwXcKgwqDCoMKgwqDCoCBSQVhbNjM6MTZdDQo+
ICsJICrCoMKgIGlubMKgwqAgRUFYwqDCoCA0wqDCoMKgwqAgUkFYWzYzOiAwXcKgwqDCoMKgwqDC
oCAobm9uZSwgemVyby1leHRlbmRlZCkNCg0KV2UgYXJlIHdvcmtpbmcgb24gZ2V0dGluZyB0aGUg
R0hDSSBzcGVjIGFtZW5kZWQgdG8gY2xhcmlmeSB3aG8gaXMgc3VwcG9zZWQgdG8gZG8NCnRoaXMg
emVyby1leHRlbmRpbmcgYW5kIG1hc2tpbmcsIGhvc3Qgb3IgZ3Vlc3QuIEZvciB0aGlzIGFuZCB0
aGUgc2ltaWxhcg0KdGR2bWNhbGxzLiBUaGUgcHJvY2VzcyBpbnZvbHZlcyBnZXR0aW5nIGFsbCBW
TU1zIGluIGFncmVlbWVudC4NCg0KVG9kYXkgSSB0aGluayB0aGUgc3BlYyBkb2Vzbid0IHNheSB0
byAqbm90KiBkbyBpdCwgc28gSSB0aGluayBpdCBpcyByZWFzb25hYmxlDQp0byBtZXJnZSB0aGlz
LCBidXQgdGhlcmUgaXMgc29tZSBzbWFsbCByaXNrIG9mIGNvbXBsaWNhdGlvbnMgZGVwZW5kaW5n
IG9uIGhvdw0KdGhhdCBkaXNjdXNzaW9uIGdvZXMuDQoNCj4gKwkgKg0KPiArCSAqICdtYXNrJyBv
bmx5IGNvdmVycyB0aGUgbG93ICdzaXplJyBieXRlcywgd2hpY2ggaXMgZXhhY3RseSB0aGUNCj4g
KwkgKiByYW5nZSBhZmZlY3RlZCBmb3Igc2l6ZSAxIGFuZCAyLiBGb3Igc2l6ZSA0IHRoZSB3cml0
ZSBhbHNvDQo+ICsJICogY2xlYXJzIFJBWFs2MzozMl0sIHNvIHdpZGVuIHRoZSBjbGVhci1tYXNr
Lg0KPiArCSAqLw0KDQo=

