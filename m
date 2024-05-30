Return-Path: <stable+bounces-47743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DC8D5416
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 22:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2433286E71
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F31802A3;
	Thu, 30 May 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/tvVvus"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82017F4F9
	for <stable@vger.kernel.org>; Thu, 30 May 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102512; cv=fail; b=aThfpd7ITyE5rTRKG15x6WZ7hvHnG2O1pJ6Zav6VYroGLymCIHlaBrLrRZkLg++UlSuIS3XUHoFCUyhNFQxALY4G990JLbgJ8ovzYmzpX+pfdFpVPlmG8wyhSU7r1rrv1rxWKDdHXJ1gXNmTVpbz/8oJQt+FmAlIK4ltcxRFTRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102512; c=relaxed/simple;
	bh=rg77moqy7a/Xors/JJKVbqnGKMXaCsfsd3gC0qfaSKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+0KUAcrC3gO5KXbSUrKpm5SqOBHe6yyH5dQBaAE7BzVL4Z0G5PLC10poltf8XUEo9t24p3ZvAIkrMVrBxD/L3P6b5jC7kOLAjKR2BX5rfGIEovUCgRGm/Kvjzcj2lOrt1HNHciX/c4g/HIMIICxZY+qf0EUl7F9J4ce38iufvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/tvVvus; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717102510; x=1748638510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rg77moqy7a/Xors/JJKVbqnGKMXaCsfsd3gC0qfaSKU=;
  b=m/tvVvusUy53FDxukMkn9tkIr+cFc/R0Z4xdOBXFFI1vd+cmPbsfbjag
   cLvSji3hGn3dSU+UXEMbqEZhMi2WJUL47ijdeR5xhMNxKSJfGbxMM92Zt
   H6ZiVDXY7n/oWfu5m87FMgspmsxns8uYgHBgA9lLUr7TSJSFMiCiZctyi
   /FhshmcC6sXJ4RSeTYE46YsN5hLcJMA4wCsf0j+5gNF4m4GNWAZQaKpdj
   ygk53DI94hElw5KVNuLnL30ne9ipY4wCBMYHunKnv1pqHu5DShczNcgmJ
   5qkkaaF+CznL6Xs2HsUxVnW8mT1/Rg89GJWzLHN8G/XxDLCjB++6xnhA1
   g==;
X-CSE-ConnectionGUID: ZwUdmz+jRmiImHjMjCIZAQ==
X-CSE-MsgGUID: iU1iFkYNTSaaJ8+i+4e4lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13819442"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13819442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:55:09 -0700
X-CSE-ConnectionGUID: dmZ0MZwXQxavp/oiG7GCwg==
X-CSE-MsgGUID: smGSP5DwRtSAndTvqBIQpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36026417"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 13:55:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 13:55:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 13:55:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 13:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXbh71xctR64OIBxc0D17HEgNreCNKaCXfBbAbrshS67LMfYZWqzXpPcjbK+3A87N00ZnvS7JHAwnR9Vgh+h0LkjN4u6bi0hCNJDKxv4+oMjhPonYAay8Qk2nDhniXU0aEd3P68CxBJjQiJ3GbLCMUDRRKPKAGIVN4ks/m77R3UaXJ3bWZLmbjwEfysoY5pA7WHLB/bjwFis1U8T4EcCNdGth6YjAvU5g6RAia3kivo9K5abKzlDvfk/mz3oxESKGI3KqtK2QWDFvUyRvFb36qyZq+xKARHQFf4LJy0QqXBbDkpZc1UP+HnqrZlD7QKTS+JGCg0gqvwIt9fuPW87eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg77moqy7a/Xors/JJKVbqnGKMXaCsfsd3gC0qfaSKU=;
 b=Ch5eDIrQvOhys3ixe0PApE+QItRgsIMRGsVejgtCfo9iTziWITjWw6ppPVppcW8Rr/lboku6gsN72rMOQYgmtYAbjia2lRgLKIVaw+XaLBVIqZreK1zXCIorxMPwAVG/Avumlf6sxmljlOoLumlrY6HUjYFTayKAg92MpImRp/tqTlMSdjo4u3H9+liQHxq/S6cZFv3FyVOf8heY2NFnbKLQ92OGlNx5GZBZDOiss2miA+rvDy8SExyNesw5SVNtY5I8eJAAI3J6fz9QgLYin5bGQSp0WeAfIlpg7uxnlDV4HVXEg8T93pfEcxoVdN++sbDtxaQthN4iGeUuOGVLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 20:55:05 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%6]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 20:55:05 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Brost,
 Matthew" <matthew.brost@intel.com>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix NULL ptr dereference in devcoredump
Thread-Topic: [PATCH] drm/xe: Fix NULL ptr dereference in devcoredump
Thread-Index: AQHastC/usBwTwnuvE2ITNGwevVUZbGwQaYA
Date: Thu, 30 May 2024 20:55:05 +0000
Message-ID: <de4994c16b9ff9f8dc68d345f7172dc926ead396.camel@intel.com>
References: <20240530203341.1795181-1-matthew.brost@intel.com>
In-Reply-To: <20240530203341.1795181-1-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|PH7PR11MB7500:EE_
x-ms-office365-filtering-correlation-id: 09a03e94-7151-48f0-081a-08dc80eac849
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RmxVUjliUUhKU1ZFbytOT2ZEVm1NcFVtVGxlQS9lWDdHMzQwdU9FZEdQY0gz?=
 =?utf-8?B?MUE0U0lreGF1LzlGeW9ldW5NT2VWTHV1Y1FZSGN0dDRvRnFxVmdpY0EreEU5?=
 =?utf-8?B?cGJzU3BOcE9mbHc0TGF1eExvRlIxNElVS3VlM21FUllCOE04bFpVMXJqTlFB?=
 =?utf-8?B?VC93T2Z5MmRsNVVWdmNhVTFLQTlPYTRMUk1Xa2NJTHNyTm9SWmpZaGtwSGd0?=
 =?utf-8?B?Q00xb3l6bEVLcUc3aEJrZUdCdUp3WjBuakYrTFNacHp0c25jZGFNbTcyU2M4?=
 =?utf-8?B?MWFId0tUc3B1cDJEbmttdmttSjJqZ04xZHo3YTAzR3Q1em9wbEtweUk3K0ky?=
 =?utf-8?B?K3l2cmsvVEU1UVd6OUlmZjduWk5ZdDVBdlZwZGs5YkxvNEY5MWlNNEV6UTcx?=
 =?utf-8?B?L1RCYnN4a0VlMkdSbmExbjFTT2ZpNk5xR3FxbHhEUFlHOHVIL00zVUxtUUV5?=
 =?utf-8?B?TlZoWmJqZnJUdUZFa0JSLzNERUNzbExxMnMwaVhlbGNEOEM5OS9laXZ6a3Uy?=
 =?utf-8?B?VGxBZ0QyUVVRTmFxZFI2VmxEU2FnOXhiY2h2VjJtNFVTV3UycUZwSjBIRnk1?=
 =?utf-8?B?QWhCV2lwZW9wUXA2ZmdaZ3dnU1dsTmsyc2RVSVBwWmFOb082SndQQjRiaTl3?=
 =?utf-8?B?ZE5EUjFGTGxMTjBLazZLMjFrYlNLZnE5enNlWTZQRjg3WnJLTi9iVWNGUDA4?=
 =?utf-8?B?MnN5SnhYZXdSZlNZNUhjc0g2Q2cvdnFZbXdTOWRLQmV5R2xFYXAwZVJQemJ2?=
 =?utf-8?B?dlhmR1dKOC9UeXlsYWl6djBDbUxCMFRBdWlZUTN2QXdVSllISU1NUG5oT1pC?=
 =?utf-8?B?WWxMNEVDQnlhR3B5RDB6V1UyVFJwUnpvWXc5S1I1MkFJN3VzcHIxRmNNRWFm?=
 =?utf-8?B?bEI5MHdFTTlUYy9CRmRVczNLeUUvUS9NaGF4TDZ0bnFlUGJBbFVlazBuOTlW?=
 =?utf-8?B?VC9FYWk0TzNhemhlNWRJVHBIL2Nza3J3RWVCa0UwYm5wZ0pwRytDT3lidWto?=
 =?utf-8?B?RlNLMlhDV1JFa2VaNWZuMkl2T1NVSlRyRStmZ2wxQitzYWdRbVgvdmxTZVFE?=
 =?utf-8?B?SGZ3cUp0bjc3WXFVcGFHVU1PODB0TnErOWszelg5WFl5ZFllRnJvQWtGTnBM?=
 =?utf-8?B?ZFQ4Sitza3dDakhLbUMrUFJvTVBRVHhXYWVRbDhybnZUMjZEbTVuNUs3amJq?=
 =?utf-8?B?MXpTa05TTTdMa0I0QlVlVFZXc0ExLzZPLyswSGFZem9mdlpLUmIvclR5MHMz?=
 =?utf-8?B?VXJ5MXVBWWJxK3VvQ1J0TzZvMTJGdUZrczF1STlONjZjS3RxWkp4SkczUXJv?=
 =?utf-8?B?WFFRNXZKK0Y4dGdsdk92WGxRWXZNNlJqemdTK2JBVVhiMGtNb3VUWmNCeU9P?=
 =?utf-8?B?NGZtUlVtaW0zSHZEMm1JMlcwYlFRa3VQdm9FQVNkN1NNRGYxeWhXMmJ4YmdO?=
 =?utf-8?B?ajh6S1FLRHpIUFlXWjJNUlF2QTFQMGprelp1R0FKWWpVNGxwOFdmbHdHY2NR?=
 =?utf-8?B?R2RGbkNpSmxKOTR6UHFmYlhYaEtCNXJvS0VnVUFBczd5YnY5d1NQUWhiY20x?=
 =?utf-8?B?N3MwNGJGREdYdXlobjFISTlqa1ZmNXQyZDFXUkt4Vm9rRzdQK0EzS0thb2FB?=
 =?utf-8?B?d1c3dk5DV3drTXhIWit6YXBSeEhLUGE1K1V3SUV2RVBGeDEraHF6MUlRSG5M?=
 =?utf-8?B?a0JFWEZ2Y09mSExpRzRaVDFlNGQva2xoejJjbE1pMHNKVFNqS001ODlldmhh?=
 =?utf-8?B?Ym5keU44R0ZzTXBRRkFMMnkwVjVqMXFpOGxCWjVYdVdqNHppdlgxYThpSXRH?=
 =?utf-8?B?SUNHL1I5c3J4c1k1VHNxUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmlWQjhjODdHZFBnWHBmN2hzZ3BxeGZGMDRRNDlYNzFBV0FnNFdYTU5KV0dF?=
 =?utf-8?B?Z2VoOTZ5QlRTT2M5a0xJTXJtNm1QWmNoNk52QTZkd0hlTnFVY1JhVmpTaWNX?=
 =?utf-8?B?VXo1ZmZyT3lEZFlaSkVkWVYvL1o2ZVlBZno1NXlweGpRUk0yRnErRjh6bG5C?=
 =?utf-8?B?cXR1V3hsS2E4T1JIaEpzRkpDVjE5d2ZTMEkwS0ZxRXYvZlQwR05iVFZoMHVx?=
 =?utf-8?B?ZlN6T0ZScElaSjBXWVRUcmFNdU1EZ3FqU0Qxa09XM0pNQ1VrSzVPeExJV1NG?=
 =?utf-8?B?dy9lUXNtR3NtN2tWWHFvclRNSG83Yys5NVlzSUhiUXNrTGVHdUNRdTVON0h3?=
 =?utf-8?B?QXllazlQaFExNzZxcXZteFhFOGczRkdSZFJhS1VCL0RaNnVqWU5JcENHZCtv?=
 =?utf-8?B?MTVVK1hpVUNLb0kwNDd3T0IveXZvR254d1RCbGpRSFRlaWkxa3lpbFZZZk5G?=
 =?utf-8?B?UkVEYVllNlhqWnFzUUJNYXE5U3E4QnZYQlNPRmtZMkdjR2VJblhxNk5VcHB6?=
 =?utf-8?B?RlI0aDZJVHh5aDFvTTN6NHJiM09MMzFEeDRRckMxdHRuc0M5cnlWZmswT2Zr?=
 =?utf-8?B?Yy93ZUlVd2NVZ3VkSmwvSWFBU2RwUXdTekJxWVdKRXl4QkxhK0VWQ1pFVUds?=
 =?utf-8?B?U1Y2bFIxSGlGTGd6UmJaZUxyMU9PS2syWXFZdlZ6ZzkzRlBUK0Q1UUZLcWdh?=
 =?utf-8?B?YURJZ011Y2VBeDc0Q2pnUjhSYThia0dQZFFzUks5NmY2RGxEMzU4SmJpcmJj?=
 =?utf-8?B?ekRlUlZmcDhxdjE0TURFY1VSYzJpVWVhb2NiSm9IQWxCbjRzeVNKSVB6OThZ?=
 =?utf-8?B?cGt1OWQveFRLQXBHa0VPTHJmY0pzd2xDSzAvbjh3ZlB4TUM0SnBnMUZ2U2tt?=
 =?utf-8?B?UXhtTnF4TGhrMjdUMmhjeG5uMkN4alEwL1FpRmd4eENzNC9oSWpONVZNWkFJ?=
 =?utf-8?B?NzJsc1JxMU4vR0ExQ05JRXZZQWRRMDAwV0FTMDAzbGlDcHVnSmh5RDRpZnZR?=
 =?utf-8?B?LzBoR0wySTVBanptSXpCUDI4dWJueTFiQUMyVkhoMnhCQWp0Wkg5Q3RtaU9v?=
 =?utf-8?B?YXJQZnpNRExlU0ZqMGx6MGZOc0FMcEJnbGJkRDJyaUNPYk0wZGJEcTdpMWx4?=
 =?utf-8?B?dGVDUkRjc0xkb3FwNmpYZzFSZUE0Y0I5MGZTNTRDUndkSXF1YnNRRHFHWlhM?=
 =?utf-8?B?MlZhYlZnNTNBOFVzcmRkZDl1c0xwbENTK2hsSTdvTG9pR0h2R09CNXdPdzFT?=
 =?utf-8?B?SndDNmk1NGU5SnBrK2YvN1pVaHFUTENseC9KS1E4UTJGcmQxMGdjdThOM2VW?=
 =?utf-8?B?V2hLeXFNcnY4OTIwc2lVTHZNZDVETmFsWSs2STVkKy9Jb05iODNTVHM1N1g0?=
 =?utf-8?B?d1BXT3BDT3IxZFVBOUdGT1NoK0V2dG1ubHFJT3RhRG5JQ0JXVVNNTzN2VFVL?=
 =?utf-8?B?aGxid0tGQnJrWjRVTUpyeEp6cDl0a1J6UFNaZXJsczBxRVFFbXF5YUNjcmNE?=
 =?utf-8?B?TUQzOVFzMjZCTWRHYm5ueEtxZXRueUN6czM3SVA4NW5KWG8zeDVxbVJsc0dv?=
 =?utf-8?B?bWQzSmdEbitaWHV6citaN3hjSk1CUXJvMTdNeENFRGFGQ01CRU9rU2JjZEVp?=
 =?utf-8?B?aTA4QlgvbzluSnlmQlFXY1BQa05NRWo4ZXBNdCtUSzBxcDlQU3hSdmxxRDJ5?=
 =?utf-8?B?MkcxSE1PWll3ZGxad2VLWWRZNlIrb1Q4QVlpMDhMdFFyeHRHU2lkTFRmbGp1?=
 =?utf-8?B?czhabjA0ZmpQWnU3MTJJa1JUQ2RiSm5FWUF3cmhHKzFXdStqcjdDbFNiTW1Q?=
 =?utf-8?B?NWlaNThOaTRma3pyZTloaER1YjdUU2V3enQyWng1L0R6a3NqRmc0ZDJ3ZGJL?=
 =?utf-8?B?eU1GNFZXZHBmcDZTeGlsSFE2ajhaNGx4RGxscDZUY2ZqOFN1bkw5ZGNtcjM4?=
 =?utf-8?B?Y09WaER2RjB6ZTdwdHA0bXhlenNPYWdqUWQ2UXpuQTArUk1xVGpOV2ZJbjEx?=
 =?utf-8?B?MW5vNTV2Y0FSRGJqM0sycnV4Z1NEQkxBZDF3M3YwYkFxeitLVk9KM2RNOFdR?=
 =?utf-8?B?M2UvbmNoRnlld0pNWTgwcWZHbGFlT3FGZTUvUDdsY0lFbFJPdHdNZ2pYRXQx?=
 =?utf-8?B?bmpReG16d0VTUHFncmNKZGliWTVFNmM1Q0hHR2NCQWc0N0w2eUhlTjJDZi9q?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78E91292849B974A805CEC4DB74CB056@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a03e94-7151-48f0-081a-08dc80eac849
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 20:55:05.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h96WSX3PiYeMKFYKoouz4xtT4AK+JmKZp/En9a+VUgZUyLj7f0UnHtz26xF5gPlUz3dpWaYaaWVZvY5TVG/FEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDEzOjMzIC0wNzAwLCBNYXR0aGV3IEJyb3N0IHdyb3RlOg0K
PiBLZXJuZWwgVk0gZG8gbm90IGhhdmUgYW4gWGUgZmlsZS4gSW5jbHVkZSBhIGNoZWNrIGZvciBY
ZSBmaWxlIGluIHRoZSBWTQ0KPiBiZWZvcmUgdHJ5aW5nIHRvIGdldCBwaWQgZnJvbSBWTSdzIFhl
IGZpbGUgd2hlbiB0YWtpbmcgYSBkZXZjb3JlZHVtcC4NCj4gDQoNClJldmlld2VkLWJ5OiBKb3PD
qSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGludGVsLmNvbT4NCg0KPiBGaXhlczogYjEw
ZDBjNWU5ZGY3ICgiZHJtL3hlOiBBZGQgcHJvY2VzcyBuYW1lIHRvIGRldmNvcmVkdW1wIikNCj4g
Q2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4NCj4gQ2M6IEpvc8OpIFJv
YmVydG8gZGUgU291emEgPGpvc2Uuc291emFAaW50ZWwuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0
QGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5j
IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMNCj4gaW5kZXggMTY0M2Q0NGY4
YmM0Li42ZjYzYjhlNGUzYjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9k
ZXZjb3JlZHVtcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5j
DQo+IEBAIC0xNzYsNyArMTc2LDcgQEAgc3RhdGljIHZvaWQgZGV2Y29yZWR1bXBfc25hcHNob3Qo
c3RydWN0IHhlX2RldmNvcmVkdW1wICpjb3JlZHVtcCwNCj4gIAlzcy0+c25hcHNob3RfdGltZSA9
IGt0aW1lX2dldF9yZWFsKCk7DQo+ICAJc3MtPmJvb3RfdGltZSA9IGt0aW1lX2dldF9ib290dGlt
ZSgpOw0KPiAgDQo+IC0JaWYgKHEtPnZtKSB7DQo+ICsJaWYgKHEtPnZtICYmIHEtPnZtLT54ZWYp
IHsNCj4gIAkJdGFzayA9IGdldF9waWRfdGFzayhxLT52bS0+eGVmLT5kcm0tPnBpZCwgUElEVFlQ
RV9QSUQpOw0KPiAgCQlpZiAodGFzaykNCj4gIAkJCXByb2Nlc3NfbmFtZSA9IHRhc2stPmNvbW07
DQoNCg==

