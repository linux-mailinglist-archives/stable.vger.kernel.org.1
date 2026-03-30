Return-Path: <stable+bounces-231148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBetK1JQymmb7QUAu9opvQ
	(envelope-from <stable+bounces-231148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:28:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BCE359404
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E528306EEEE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05ED3BED47;
	Mon, 30 Mar 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm1Y9tLd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510113B9DAD;
	Mon, 30 Mar 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865803; cv=fail; b=VzvGARjf1rirLmW4NFeN1Q49nf9L8wBt/nyYvfDlaavrLUKDKVFSXAcu11QkiVy/AE9mP8q7zGPJfN9Na5tvdzGlqeEU9XwMlpT6oI/kIYxaEPv2Oo8WzEJXJUn3afIA3DTyxPHvPfy2uLFFStOwYh6qvVyvFr2zyZ8rAHfR5eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865803; c=relaxed/simple;
	bh=+cZ2/bZQBmXo6hlusMmTrARjcc71lB3FXm3Cot/bWWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gusDrLSUHQxBK0/Ug3yKSkKKMsP44S9U/DWdwyOH+XU7TDttELQ3yYUTmGgCjdcicRJW5Nd2zFBafLZC3AJyxi9W3FngksO1l9PjCmZrNUoGDW/VNejnWKprnfsAQs6KMR/HDs2Wa3A1GFwNzpqI/OZETR6zwdSi+IBaSaotaYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fm1Y9tLd; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774865802; x=1806401802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+cZ2/bZQBmXo6hlusMmTrARjcc71lB3FXm3Cot/bWWU=;
  b=fm1Y9tLdFwkbJwv3jxhi7kwltun5sRQDVGyYWLU0IzdetQRvl6C4usL9
   v6hL7+EEIZQ5996/szN6+tTT0ho+8K4HRhb8btLJeoCehr0Nb/0rMYEyw
   AXpX4QhTYooI3a9CFyzQkT/nzwuYxVjIl+dWdbDpfvsSoyafAPYbgpUMc
   Qp4Y5aaDrezIhXA9qj8ldrUH58hhSjU64StLqlIk6r8XiEnYe62kA2O9v
   U69TOp9tWiPRYlfJloF1980NJprDvGU71C0zWpYV6R9Sdn62HtX3BppWl
   NuIx8XG+0v1n2neXMFlT/qd0XXUVGpy4AiaHUPbGmD0eK2+UFD0rpv81+
   Q==;
X-CSE-ConnectionGUID: i9Ea4Wp6QvS7U0ovymQt0A==
X-CSE-MsgGUID: 0R5Eo+GISgmCjXG8wXIVVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="78449758"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="78449758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:16:42 -0700
X-CSE-ConnectionGUID: RIc/Oo2oR5Sgib954Imkpg==
X-CSE-MsgGUID: e3hrqOT/SS2XI3OKZrkEhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="227628788"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:16:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 03:16:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 03:16:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 03:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iScLt8bHNStWAb2r3kFEk4F63r+jqwTqIMrXOZbOhqH7l/WdtQYKW2q8wCbGMdUf5ijWSf4+OMbY2a+pZC082fVvQzeOB4zExm5Z61UjjREfUmsZ5CGeOuw63LLF6Y5Y746T6m2cq+xjPx2/zLuKvVsYDbz6hcvN3QnR8WKwEfx+VXjcND1gJH34GVB2cwl7QcvBCkguPJ7ochSbUrvkBILrJU2QVwzTLnZlW5YsNuZrIZjeEu2JHfD9+bVJsW1+vMjnK8Qqmm90g6ueBhtbejWhfRBMUwS8VFaSc4YgFiGobPZ8r725pDmDFAWulaSuYZ1hdf4ujXgs6uIdg366nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cZ2/bZQBmXo6hlusMmTrARjcc71lB3FXm3Cot/bWWU=;
 b=MjgsIXUPZNS9yWDorQ5He9XLFCp64TywMJQO5Je4EncMfRaYQgfWqOpZGzumMnzchhh8N44vTNrZJkyB1FQ1y4I25OBzcrdWoI5AbNEO4/2yH3Bxc4JdJX4DREdPN0v9FloLlXjURhc9wxkADCg0cojnCaxB1mLm404TvrKrqQONmSu+//WK6nkpD6BrD1YYMYc+MQubaVAcjcqajD6tWvE16g/k4/09QWpjAcfdko+zYwoYpvCftHRLlikQeWwFJ+9W7S3LUMPX19UUNT/JOv5fRErs/CPia72G0BcbRJbLviL+CK6Gm2zWwrbvkDmPSCmE2fzUT4BXMoFl64OBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Mon, 30 Mar
 2026 10:16:33 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9745.019; Mon, 30 Mar 2026
 10:16:33 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Alex Dvoretsky
	<advoretsky@gmail.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "kurt@linutronix.de" <kurt@linutronix.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v3] igb: remove napi_synchronize()
 in igb_down()
Thread-Topic: [Intel-wired-lan] [PATCH net v3] igb: remove napi_synchronize()
 in igb_down()
Thread-Index: AQHcsieZ2k95IXxzOUynBa0+I8yfPrWsM3mAgBrEkwA=
Date: Mon, 30 Mar 2026 10:16:33 +0000
Message-ID: <IA3PR11MB930147B64F6421FD7D01AB418A52A@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <DS4PPF7551E65520F55DBD20987BCAE3C6FE544A@DS4PPF7551E6552.namprd11.prod.outlook.com>
 <20260312135257.71610-1-advoretsky@gmail.com> <abPY+aT0SWuixsmN@boxer>
In-Reply-To: <abPY+aT0SWuixsmN@boxer>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|CH3PR11MB7915:EE_
x-ms-office365-filtering-correlation-id: b2bb41f5-0d75-4a2f-b10d-08de8e456b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Zj8702viS85r8m910Wtc9hS5Jb6KyvI+/1BxkiXSGnr/N2E5q/giICGO07SngjQffM5Mxx02hxyvH0QzTHOZ3mnl+AS79Ptm+zRvaEHwjFYZXWU40UvHHm6o8Yx8y23OO87obBYhuUhIi5djjzf59BGGteKaZ7NB2Wx5laFj+lZ1aSc9lK94V616KJuxOeFF61sr54jdr4XP282azbR5XcMO2JTmLPm5rt4Qg7LBJTrVI+MrTbg95z7D0uqyfvNgY6xc33Dh7yuE4kQ01z6+8dkA95+J0b0jzKfFa+zpw9pAY43FcYe0ucLPvsrvEtF9jg+3c5fD6mwEYjclDsVMD48LvgJ16ZBEuWn2V5RifpYoWaVig8svATK1e7erapA87tOxto/2CFXC0+pcbT+EyQJHkj9GvA//3vm22HiYU0XKUmIKm7rZjBG2bz5OYpuZuwLAWekLkYgiXgZme6HFiGoJAIP3EolSzD9Q2HVmBeA06AgF5WtgeOQHTqOWu+Ctbvo2q//KaWD/o7oMhMfSqBC8CVhmNOwLV05NvXlsL4dQUqxyCkYRxbtXXxeR42bUe8po0xv3i3JkeIwy7EJy60sR7zH2eyxZ+kFeTay6qx6yXPWrmjymHfksrsqDRzKR2fNxz8D7oRkdeMWU1JNnrln6WdU2Ad1lUyK0/cCEBOD8XjaWgtF8/O6UjpuF0k38uejzE0VW27Y+qmJQRfvTM2hLDEjxrbi9oHMQz8HMdvDm9maLoNw2fm29iDwfVGroq2ETLCQk5Tet3txHrclWN8+avfjBY30tOoC7AisdWTc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHI0R29lS1E0OVRaeFRqQUxDdlppRlM0TGV1c2F5WUtNWHRUMlEreTFSRnla?=
 =?utf-8?B?NTF5SUxrM3EzcCsyOXhuZnZ6OFVLQ1FvSVBONHZaSEtPQmVPMmJtTFB1TFBN?=
 =?utf-8?B?T2tzWWVFcXBQNHRuaWFpRHhmT1N3Y3dIU05OL0hhc2xqTXRoOEUwcnp3NHlF?=
 =?utf-8?B?SzhaTm1IMFV1RTBrbkN6bnpaSCtHVlBLNm5WQmtEQUhBUnY2T2ZsTVdPdmtR?=
 =?utf-8?B?RDdyUElpUEpjcDBIN3hNQ0NnME9CblR4Y3ZpVmVBSWNyUVlzekhVZ0NyY1lO?=
 =?utf-8?B?ZkUyWFVySW1lZTQyZzFiV2gvQzZPVlI1dlZxbE9ZaEdCQ0tMLy8waTJGSnJs?=
 =?utf-8?B?bUlOM2pCOHJLSS83djdKZ2k3QWNWR3QzSWdRTnJMT3pXRittVDBpR3dEdWNE?=
 =?utf-8?B?VFdiVGlyQWJqSG5sb3RzYThkWEttRUQ2ZW91eW45OTZQT1JNS0cyaHVxWWJV?=
 =?utf-8?B?UGdiMnQrTHJDNTJVUTZLblJRMEFxNW9sTkZLcFMwaUlzK2JTcGhybWJBamlM?=
 =?utf-8?B?YnVjL1dnY3RsdktPM2NFYkE0MURBTHU0MXhFNDg1cVFBcjVlUldUYW9ia0dD?=
 =?utf-8?B?YmhMcnJmOU85WS9Ic0k3cHEwUWlWWGNxdVlqUXFSbklzOUpTOXI3azBMREg5?=
 =?utf-8?B?MXRjOGRUZFdETlNJNzJlVDRYQi94cFk5ckRKMkUzM1pSMDh4UmpKdE94akU3?=
 =?utf-8?B?L2hiZ3ZQWjAzQjhVMnVMWXdzVlE3VW5WdloyMlVZQU5NNTMvN3h2UFNNUktx?=
 =?utf-8?B?cC9TTjN5WTI3Q3BzS2s1RFNKcVZqTHA0YVU0WE1yNWhxTVhlVlF0WEJDTmJM?=
 =?utf-8?B?VnArWDhnK1J6VitObEpXSlUrcTJEY2V4VkpRa2RESFV2Z1lYL1JCVVc5VUpV?=
 =?utf-8?B?SkU4b2FlMjJhOU9pbEEwOEhRQ3JaSWVnd3BqbDlkSGNNb0tiR2tydTdqMC9I?=
 =?utf-8?B?cVFzTmFLVml4TTQxOHUyTU51VC9WRGZ5QlBRN29HZ2sxVGxIRG05Rm9oRUhL?=
 =?utf-8?B?a3loN3c4OWpjMmJiYStRSWN5M3lhZExDeE9sM1ZVZERCcTBkVm5sYmREY2Zy?=
 =?utf-8?B?NXRkYjNwQ3VYOE9LaHdsNTE2akxFKzc3SGpFc3BSOWVYWXVIOEFQVGZJWjJH?=
 =?utf-8?B?WFl4cFpWK1ZyYWR3RVlockhTZ2ZCMWFWSHRSb1ZJNElBUHpmczh3V2VWVWFR?=
 =?utf-8?B?RnR4aEgrZktVVlZFT2UwU2VjZnkvOERNUTBGb1MwRCt3S2g3MHlnRjVwOGZm?=
 =?utf-8?B?MFZhQ2FnYXMvdVg0cmRIaTdhSmFiU2hITXJNaGplb3k4ek83aElXYU1NSTVL?=
 =?utf-8?B?cm5Gams0V0xvbzZrS0JXNWQ1eVJUWkNSSTl2bUpQenNYQU9FL0V3amovUjdt?=
 =?utf-8?B?MkpJUjNDbjZWL0RTdWNhYm9xSXl3TURPb05FYVlLRTZNU0tNQi96cVdXK0hX?=
 =?utf-8?B?MktMSSthZVFpaWhvblNZS1hXSzBSOE9NeHZpTDk2bWdXNHR0ZlFtT3hCcStp?=
 =?utf-8?B?bGNkWjVoVGlOaWp4Y0VQclNqd3hwSWdpRzEvUW9XMi9teGxHcHJBdDZSYWFq?=
 =?utf-8?B?K1dlUElrRERvdVIvemplSFlMRjJRZWVFNUNkeTM1eW9saGxKQ012SHNGQW1X?=
 =?utf-8?B?RjlwYjg2ZEZtT00rbG8zWDlQaTUwUDZMTXJpbTZxVFc2SmYxY01lcGNTM2F0?=
 =?utf-8?B?N28zY2QwdXNuRjFBdHU3MHlpQ01VYUUvNmt4c1VISG9BWnZ5VzkvYXdzZy9v?=
 =?utf-8?B?WHdtbEwvdGowSkVTZmZEYkswSUIwNkdSVzVNNGQzdENsNC9OZnBobHpxSzF4?=
 =?utf-8?B?QWdhU3JKUy9kTnVuSXh4QTJZS1FjY280UTRyRXV0OXVEQXE0SjZET1BmRERW?=
 =?utf-8?B?VkluMlloQlFXbXBGaGJNRjU4TGJOcSs3WTUxczNicElVT0xpRmRYRjM5bWZr?=
 =?utf-8?B?ZXQ0QkdkY2F6NGlzaHhMMU1nMWpleVJFSDlod0NNSG9oQXcwdDBWclhIT0pW?=
 =?utf-8?B?Q0FiYzVZMklwZElzcHd0d0dZdkZBNms3Z0dyY2VmUUw0QklnZExPSkJoNzI0?=
 =?utf-8?B?WjhvMEpqK09NWmJJYXF4Vno1SHg2VnRrdE5HS1VQd3lDTzdLNVV1M05CUStB?=
 =?utf-8?B?bFJqanNEcFpQcmlwZktmeCt6NkIzMUF2bUIrYjhla09SbjgrKzZQSkhTRXZT?=
 =?utf-8?B?eUVMamJWMDVZWEkwdEFzYWVPQmFOTVZ4NEh4OVRhSjB2ckNUQmZoVmpnVmFx?=
 =?utf-8?B?a3VxemxPRmpaa2JPSWVQREtnZXRzM0RBSnJPenlETmRNVnZHcll4cVlkMzhx?=
 =?utf-8?B?akp1cEd0eUJUckR2TFJqeFJlY3RmcW5hVnpyM3JrVzFqSDdtVTFEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T3EkOHJxDQchA2lKdF2l5wTqIrgJaLibtBXCMsK1DAJ4Vdd5lFFqubIIUNAGcn6aixLB0qshGjn8wjLxqL7MNYsTxUV9wAwlDg3/Ho+4uc2o06x1C4ttMBYvHJb+wOcmN76U5CzwUMI+0wjr9OBnEB3Qr5mkWk4kC4P9d2Mk4pAesa4u2VtoezUAPZ6McvLDuQ/PqlUA+3SAW4ByE7U/1o3nJYfurQJqey8suVmjeJ59UvBLmqJjdx4wfyQU2jopcNsD16G7/KwVdhUyKGp87GN4tMHkE3cf4+pVyaJUQ4BluKlYbOa3MRDqjyckYHE0F4NeOlyN0AICxvs5stGk6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bb41f5-0d75-4a2f-b10d-08de8e456b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 10:16:33.3508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bwk2n7PFMvjLCP/SFMWtyimNzXZZXG0hsEpB6b6a5npXcC4qWVCRuACS/GAC6+2a48J9o+Dyf9Y8ttkNL9ZD+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231148-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,IA3PR11MB9301.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 50BCE359404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEludGVsLXdpcmVkLWxhbiA8
aW50ZWwtd2lyZWQtbGFuLWJvdW5jZXNAb3N1b3NsLm9yZz4gT24gQmVoYWxmIE9mDQo+IE1hY2ll
aiBGaWphbGtvd3NraQ0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEzLCAyMDI2IDEwOjI5IEFNDQo+
IFRvOiBBbGV4IER2b3JldHNreSA8YWR2b3JldHNreUBnbWFpbC5jb20+DQo+IENjOiBpbnRlbC13
aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTG9rdGlv
bm92LA0KPiBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgTmd1eWVu
LCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6
ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IGt1cnRAbGludXRyb25p
eC5kZTsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVk
LWxhbl0gW1BBVENIIG5ldCB2M10gaWdiOiByZW1vdmUgbmFwaV9zeW5jaHJvbml6ZSgpDQo+IGlu
IGlnYl9kb3duKCkNCj4gDQo+IE9uIFRodSwgTWFyIDEyLCAyMDI2IGF0IDAyOjUyOjU1UE0gKzAx
MDAsIEFsZXggRHZvcmV0c2t5IHdyb3RlOg0KPiA+IFdoZW4gYW4gQUZfWERQIHplcm8tY29weSBh
cHBsaWNhdGlvbiB0ZXJtaW5hdGVzIGFicnVwdGx5IChlLmcuLCBraWxsDQo+ID4gLTkpLCB0aGUg
WFNLIGJ1ZmZlciBwb29sIGlzIGRlc3Ryb3llZCBidXQgTkFQSSBwb2xsaW5nIGNvbnRpbnVlcy4N
Cj4gPiBpZ2JfY2xlYW5fcnhfaXJxX3pjKCkgcmVwZWF0ZWRseSByZXR1cm5zIHRoZSBmdWxsIGJ1
ZGdldCwgcHJldmVudGluZw0KPiA+IG5hcGlfY29tcGxldGVfZG9uZSgpIGZyb20gY2xlYXJpbmcg
TkFQSV9TVEFURV9TQ0hFRC4NCj4gPg0KPiA+IGlnYl9kb3duKCkgY2FsbHMgbmFwaV9zeW5jaHJv
bml6ZSgpIGJlZm9yZSBuYXBpX2Rpc2FibGUoKSBmb3IgZWFjaA0KPiA+IHF1ZXVlIHZlY3Rvci4g
bmFwaV9zeW5jaHJvbml6ZSgpIHNwaW5zIHdhaXRpbmcgZm9yIE5BUElfU1RBVEVfU0NIRUQgdG8N
Cj4gPiBjbGVhciwgd2hpY2ggbmV2ZXIgaGFwcGVucy4gaWdiX2Rvd24oKSBibG9ja3MgaW5kZWZp
bml0ZWx5LCB0aGUgVFgNCj4gPiB3YXRjaGRvZyBmaXJlcywgYW5kIHRoZSBUWCBxdWV1ZSByZW1h
aW5zIHBlcm1hbmVudGx5IHN0YWxsZWQuDQo+ID4NCj4gPiBuYXBpX2Rpc2FibGUoKSBhbHJlYWR5
IGhhbmRsZXMgdGhpcyBjb3JyZWN0bHk6IGl0IHNldHMgTkFQSV9TVEFURV9ESVNBQkxFLg0KPiA+
IEFmdGVyIGEgZnVsbC1idWRnZXQgcG9sbCwgX19uYXBpX3BvbGwoKSBjaGVja3MgbmFwaV9kaXNh
YmxlX3BlbmRpbmcoKS4NCj4gPiBJZiBzZXQsIGl0IGZvcmNlcyBjb21wbGV0aW9uIGFuZCBjbGVh
cnMgTkFQSV9TVEFURV9TQ0hFRCwgYnJlYWtpbmcgdGhlDQo+ID4gbG9vcCB0aGF0IG5hcGlfc3lu
Y2hyb25pemUoKSBjYW5ub3QuDQo+ID4NCj4gPiBuYXBpX3N5bmNocm9uaXplKCkgd2FzIGFkZGVk
IGluIGNvbW1pdCA0MWYxNDlhMjg1ZGEgKCJpZ2I6IEZpeA0KPiA+IHBvc3NpYmxlIHBhbmljIGNh
dXNlZCBieSBSeCB0cmFmZmljIGFycml2YWwgd2hpbGUgaW50ZXJmYWNlIGlzIGRvd24iKS4NCj4g
PiBuYXBpX2Rpc2FibGUoKSBwcm92aWRlcyBzdHJvbmdlciBndWFyYW50ZWVzOiBpdCBwcmV2ZW50
cyBmdXJ0aGVyDQo+ID4gc2NoZWR1bGluZyBhbmQgd2FpdHMgZm9yIGFueSBhY3RpdmUgcG9sbCB0
byBleGl0Lg0KPiA+IE90aGVyIEludGVsIGRyaXZlcnMgKGl4Z2JlLCBpY2UsIGk0MGUpIHVzZSBu
YXBpX2Rpc2FibGUoKSB3aXRob3V0IGENCj4gPiBwcmVjZWRpbmcgbmFwaV9zeW5jaHJvbml6ZSgp
IGluIHRoZWlyIGRvd24gcGF0aHMuDQo+ID4NCj4gPiBSZW1vdmUgcmVkdW5kYW50IG5hcGlfc3lu
Y2hyb25pemUoKSBjYWxsIGFuZCByZW9yZGVyIG5hcGlfZGlzYWJsZSgpDQo+ID4gYmVmb3JlIGln
Yl9zZXRfcXVldWVfbmFwaSgpIHNvIHRoZSBxdWV1ZS10by1OQVBJIG1hcHBpbmcgaXMgb25seQ0K
PiA+IGNsZWFyZWQgYWZ0ZXIgcG9sbGluZyBoYXMgZnVsbHkgc3RvcHBlZC4NCj4gPg0KPiA+IEZp
eGVzOiAyYzYxOTYwMTNmODQgKCJpZ2I6IEFkZCBBRl9YRFAgemVyby1jb3B5IFJ4IHN1cHBvcnQi
KQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gUmV2aWV3ZWQtYnk6IEFsZWtz
YW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRHZvcmV0c2t5IDxhZHZvcmV0c2t5QGdtYWlsLmNvbT4NCj4gDQo+IFN1
Z2dlc3RlZC1ieTogTWFjaWVqIEZpamFsa293c2tpIDxtYWNpZWouZmlqYWxrb3dza2lAaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogTWFjaWVqIEZpamFsa293c2tpIDxtYWNpZWouZmlqYWxrb3dz
a2lAaW50ZWwuY29tPg0KPiANCj4gPiAtLS0NCj4gPiBBZ3JlZWQsIHRoYXQgbG9va3MgY2xlYW5l
ciDigJQgbm8gcmVhc29uIHRvIHRvdWNoIHRoZSBOQVBJIHBsdW1iaW5nDQo+ID4gd2hpbGUgdGhl
IHBvbGwgY291bGQgc3RpbGwgYmUgcnVubmluZy4NCj4gPg0KPiA+IHYzOg0KPiA+ICAgLSBSZW9y
ZGVyIG5hcGlfZGlzYWJsZSgpIGJlZm9yZSBpZ2Jfc2V0X3F1ZXVlX25hcGkoKSBwZXIgQWxla3Nh
bmRyDQo+ID4gICAgIExva3Rpb25vdidzIHN1Z2dlc3Rpb24uDQo+ID4NCj4gPiB2MjoNCj4gPiAg
IC0gUmVwbGFjZWQgMy1wYXRjaCBzZXJpZXMgd2l0aCBzaW5nbGUgbmFwaV9zeW5jaHJvbml6ZSgp
IHJlbW92YWwsDQo+ID4gICAgIHBlciBNYWNpZWogRmlqYWxrb3dza2kncyBzdWdnZXN0aW9uLiBu
YXBpX2Rpc2FibGUoKSBoYW5kbGVzIHRoZQ0KPiA+ICAgICBzdHVjayBOQVBJIHBvbGwgdmlhIE5B
UElfU1RBVEVfRElTQUJMRSwgbWFraW5nIHRoZSBfX0lHQl9ET1dODQo+ID4gICAgIGNoZWNrcyBp
biBpZ2JfY2xlYW5fcnhfaXJxX3pjKCkgYW5kIGlnYl90eF90aW1lb3V0KCksIGFuZCB0aGUNCj4g
PiAgICAgdHJhbnNpdGlvbiBndWFyZHMgaW4gaWdiX3hkcF9zZXR1cCgpLCBhbGwgdW5uZWNlc3Nh
cnkuDQo+ID4gICAtIFRlc3RlZCBvbiBJbnRlbCBJMjEwIChpZ2IpIHdpdGggQUZfWERQIHplcm8t
Y29weTogZnVsbCBFMkUNCj4gPiAgICAgdHJhZmZpYyBzdWl0ZSwgZ3JhY2VmdWwgc2h1dGRvd24s
IGFuZCA1eCBraWxsLTkgc3RyZXNzIGN5Y2xlcy4NCj4gPiAgICAgWmVybyB0eF90aW1lb3V0IGV2
ZW50cy4NCj4gPg0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4u
YyB8IDMgKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2IvaWdiX21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9t
YWluLmMNCj4gPiBpbmRleCA3YzQxZTMyMjU2ZmEuLjA3OTM4NDJjYjkzNyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jDQo+ID4gQEAgLTIyMDMs
OSArMjIwMyw4IEBAIHZvaWQgaWdiX2Rvd24oc3RydWN0IGlnYl9hZGFwdGVyICphZGFwdGVyKQ0K
PiA+DQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgYWRhcHRlci0+bnVtX3FfdmVjdG9yczsgaSsrKSB7
DQo+ID4gIAkJaWYgKGFkYXB0ZXItPnFfdmVjdG9yW2ldKSB7DQo+ID4gLQkJCW5hcGlfc3luY2hy
b25pemUoJmFkYXB0ZXItPnFfdmVjdG9yW2ldLT5uYXBpKTsNCj4gPiAtCQkJaWdiX3NldF9xdWV1
ZV9uYXBpKGFkYXB0ZXIsIGksIE5VTEwpOw0KPiA+ICAJCQluYXBpX2Rpc2FibGUoJmFkYXB0ZXIt
PnFfdmVjdG9yW2ldLT5uYXBpKTsNCj4gPiArCQkJaWdiX3NldF9xdWV1ZV9uYXBpKGFkYXB0ZXIs
IGksIE5VTEwpOw0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPg0KPiA+IC0tDQo+ID4gMi41MS4wDQo+
ID4NCg0KVGVzdGVkLWJ5OiBQYXRyeWsgSG9sZGEgPHBhdHJ5ay5ob2xkYUBpbnRlbC5jb20+wqAN
Cg0K

