Return-Path: <stable+bounces-236043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIRaLizl3GkZYAkAu9opvQ
	(envelope-from <stable+bounces-236043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:44:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2123EC292
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525753026AA1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9343A5452;
	Mon, 13 Apr 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUSTXH9a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142E33ADA2
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083937; cv=fail; b=X1sHg2JhV5VrrDuiFNjKoLAfzv8Y3pIZEBQIZzAkfv0rGBn59WJoxmQbcMrDhp0xfGSFqP7IWh0hrZbMMiASGKTGqozc6N+qgDw/Ht76LNjOBrc8IOi1rYvBKfv6sopcVKWox+JDSHMptQ2ownBn0DVMLxEZInAIL6ZcaervIQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083937; c=relaxed/simple;
	bh=hX6VOeZhMt+AExI6yr6skZoewzjqFOcy2Bk44DpuOYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEZX+5LiwLVvKryq/S40zz8C3SYIHRrisl3id+bDQss/wgFznwF7UdVQb7Ihk/ed6/aR7AWy46VW4RWSowDMJMOkq7SrflBWqFKFk5QIr/tDgRqWSNCkQgXfK5MUCHcjSMLwllS8JdlgSwqmcnP1Cr/tElViHewzxLvsEwSYZug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUSTXH9a; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776083935; x=1807619935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hX6VOeZhMt+AExI6yr6skZoewzjqFOcy2Bk44DpuOYc=;
  b=kUSTXH9aNJRNjPd8truRsdb2/C3k07znXMcVUWptVj/zt4Mr26Tjrmwc
   J6FLGhPTrVWavMcnqu/LscZmZKaYQvVdM6d/6t3C8JpAIzOgK5Fauk+oW
   edoBTGe1d8ut7/I0mtXMz+ImJs1pjVt5eYMPdljEQfhNkh2mQHmiuV6NV
   xm/6nd703bXOErZkY4I0J7vSDCLRqvNreO88XQvLtLezrA8fgNNN2pONa
   kFKgACFdE1NQQ7cd1B9YXpM2L5lTO4LxCZEIJHx/LtCWJUe5KIrinj1qm
   81Vt1fKQlEBMEnSiFiPV1oKMZQnYDi4miHqenYZH/Ja6tmU4rt+Pes+1W
   g==;
X-CSE-ConnectionGUID: iH3NcfN5SUemo0TjuNwk/A==
X-CSE-MsgGUID: BmNZxlGhRWOuZDYXS1LKxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76183032"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76183032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 05:38:55 -0700
X-CSE-ConnectionGUID: LsYhXZVIRHef/GD3YVq/CQ==
X-CSE-MsgGUID: v+02Vv8WQJ+/l0vWeW+Mgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="223289227"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 05:38:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 05:38:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 05:38:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 05:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0/vf7Iik6Iw0NyVQHiT/sdFm2Eb3quuwyzqxzxN1GClRqxbM9BiYYBvXN68/YKEP8ydw+kW4OmXJxBXQ6kfExsd7+ENOKId1rL3NX2kQatRAlZfR45sDEpYuIF3444H3vQElNld4w1VQAYh8sCiSubGWgSx75zvHmh71tBCY5KFiK/qWdASPg4PxVfyOajM3XpKS3JKUS6oJa9rhRnF6M6Gbo45VgIz4viRJAdC9i420YlsoeIVxcd3xG13DlRvwZhiihkmbu6Pb2dTxr7ALwqpvQ9F2Bf10EumtIi7SOZxMB3o3ZXFavS+w2MHebn7QUMeWSQGYGQ5LskrgthvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX6VOeZhMt+AExI6yr6skZoewzjqFOcy2Bk44DpuOYc=;
 b=RJZ/OJa0ro/qUl1SViBKFtjHbPwMiHOotRZExqpYPEelMw4cX+ZE8nqcQpazkctuw/YilI9q90GINsuIn9KSHnO5BZooWLfSp+Of+WeUZT0PUsBwrpFqKShIWO4DgNiszhV9zqXfBplvO3q/T7/Xp6LYLY5wzuGVXqbcRNFFUcccXfaYpptgDnt8fCDmsxErrwkCfuA68IHIM88PXxWvAimSS0fTae/UVmAYLDC6OFGp1R5vuwb2YdQ/cN9X/YtPdt6qwduHMIrEt1avG2Wt7CRwzPaiQ+ckM6W8+rwbxDFHo6RmgMP/2bZ6Sj6k48LPkSJGfNeYLZNF2SmTurt5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18)
 by LV4PR11MB9465.namprd11.prod.outlook.com (2603:10b6:408:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 12:38:47 +0000
Received: from IA1PR11MB6467.namprd11.prod.outlook.com
 ([fe80::7aa6:c6db:3d15:8973]) by IA1PR11MB6467.namprd11.prod.outlook.com
 ([fe80::7aa6:c6db:3d15:8973%4]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 12:38:47 +0000
From: "Garg, Nemesa" <nemesa.garg@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/psr: Init variable to avoid early exit from et
 alignment loop
Thread-Topic: [PATCH] drm/i915/psr: Init variable to avoid early exit from et
 alignment loop
Thread-Index: AQHcyzgT+XTCjneXvkukCtRiwjAOT7Xc7l9w
Date: Mon, 13 Apr 2026 12:38:47 +0000
Message-ID: <IA1PR11MB64678230ADC9AB122529B5B0E3242@IA1PR11MB6467.namprd11.prod.outlook.com>
References: <20260413112345.88853-1-jouni.hogander@intel.com>
In-Reply-To: <20260413112345.88853-1-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6467:EE_|LV4PR11MB9465:EE_
x-ms-office365-filtering-correlation-id: 7f802d8e-b1ee-4a58-4714-08de99599b91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 3LKP8hw8YIONbJAtfMLNSB+VG7ysafPWpfrv0qfkQvRiIRfAxyKZB3Y0QMyBZcrTfZTsw8j4XcodfkPtKuOZkNujnsjqAMYYtMiaz+QVvJaszj7puhZQNAbqaRV5N1ZklduZbJVzlPiry08JUQ1giGinQdWcIjmUhJ1jC/AgIirhsmQ3fhTMKJCNdZlP03YI3Ew//gLKpFz1tKGWJYohqHi2Mi+zlUCzyzDoiHYPbMx85+ScQhXcZ6GCvlFdfcx9HBasbJ6Kf8Clg9TTvNPiISmK2952XQLnDs9/Q6CYKnLL/GcYlg1mgER0/X//husXFDOAwqq0PXau6/EVgUW7/zDq6BvTLenu0qF9wgdVeR3a32U5b507Z/wlMm5Pw6gJvGo7BXPyRv0qt5UgcG7OV+yge8AnkLjG3oQVqQsU6ZKzgQflbCDAUnTORcWmnFq4v29wJKWvPNKss4eRcvCIHs1q4xoo5l56g1UNpzH3JQRo8NpOx8uNhvwD6Q5PdOgZIlUPliUpjnwLb7eYa/s3rZ8Ziyj8mTHGNnhJv7j4Gr6OBznh2PLyxY+2uf26kIKH0noH2Cp8U0o0+r9vSdXkc9RmcuEJPD6nEln8LJn4eqBuDYs9yEQWVl201Jm8adFuXDKCmAIhb/k1fUSHvWLxyvtNy2oBAN2ik5RMhxBVkYln6z3dQpdJJd3C9lQK89KCFfE0wTBGWMijXhACyyI+JGNmThUypTGwUFojLSJvHvlJBpm0nAKGp1ACYmzgW2oT69pzWr80FvsywvfNiFHqVR9RfJI2Z8JzSF4sIZtn9BI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6467.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NXOHZWRHdSNHE0YngxNnBETW1ZTk1idjVVc29pcDRqK2YvNmYrSkw5YWVS?=
 =?utf-8?B?VnNlYVBERVoxUjJodGhZaWpQdUxDY0xlcUdTOUJSME8vMG5QeDMwR0x4bmx2?=
 =?utf-8?B?RE8xeXJMV2ozWHJSczlZaVhBTTlQNzhnbkxZeWR0aFRnc1l0aTdxd0RZWWNS?=
 =?utf-8?B?YTZSbjY0ZngzZnllaTN1UG9lVUNwS0ZSNkdVWmxpbUsrN0RQNFZYT3NHblRE?=
 =?utf-8?B?RXY5S2VmU29wNm1UUE4rNzJXUE1KOUNtbXRkaHN6b0VCUEozbXlsY3QxdHpC?=
 =?utf-8?B?N3Mrc2N5ejB0WkQ0dkJ0bUVCOG5zalNqOGtTTWczM1dYMmJDL3YzN24rQUJI?=
 =?utf-8?B?MFlmUDdJVnhsMzk1b3V4eFRYVksweG5jVWpwdTJHTGVPSUtJa0o2a3k5ODQv?=
 =?utf-8?B?MVhxZFdjQWNxWitoa002bERJVGVWRlU4cDB4RDdnWUtpQ1lKODIvWGdjWXpW?=
 =?utf-8?B?KzF5ckNmUUVNWFVuanorWlNwQ0ZXUnY3ckpxOVgvOXh6RWtCN2R1dlpxWUpt?=
 =?utf-8?B?alZFeGJrUTJBa0hMQlR5T0kyRjk5S1VUeXBrVjNlalA1YzVFellWUGJxbFdL?=
 =?utf-8?B?RGtRVVRZazdiUnliK3VXWUdoNjFvVTY2MWlXaHZFby9oS3ZvanNjQnlMN0J6?=
 =?utf-8?B?MWF1WVBhbzcrZ3lLNitQZzBsa3RPaDZyanlKYWQxb0wwelJkYzE5cytGZ1Jz?=
 =?utf-8?B?S2tISnVaaDhzdVFNQkRUbXhMWGFmRDdhQjJSdENFLzZ5ajRJcG4xdEsxRnlC?=
 =?utf-8?B?d21OWSttRTl1MDkzWFdJcVJZd0pYRnR4c2lZMEluanl3SHkvZWxSQ3d4K296?=
 =?utf-8?B?NENhV1pzTERzUjJ6aGNSQjFYQUNKMWd3cXNJTUZONUlzb3NWYTA2U0p6YVFm?=
 =?utf-8?B?M2NNdHNOWS9SU1U1eEdKK282VjBYSExkTml5Ukp3NldWSU04L2M2OGNXelZi?=
 =?utf-8?B?ZFdDUGU5cTd2cjRtUEYxdjduVmkxNHA2cFEyWUFtWTNYWUhpQ0dmV1k3SWxS?=
 =?utf-8?B?bTFjeDNvdUNRQ1dqZlZPNnM5YU5TYUhKRFRqWnZXMlEydFUwc0VRSzZwOE5P?=
 =?utf-8?B?Y2RncGw5eTNjUUF5QnJvQW9PekxVeFZWbzhDMkhMdmZvV3E0N0lSRnRtR0hE?=
 =?utf-8?B?UkpnQmpRNVlkaitHY1JRR3pkMG5TZXhJelhUdkkyMnF3ZU5nMDZIb01oOVV5?=
 =?utf-8?B?NHJUbWkwbUkybkwwSU9IdWVpM3c2WUxDaUo2SzJtd1laT2tmbzY5RHpvVEVP?=
 =?utf-8?B?alcya3lCQ0hlYlVQb09kSWNCT1hhK3ArSlc1Z3BJTnN1NTkyOStaYUFXQkxw?=
 =?utf-8?B?MEl5U2t3bDRwZFV0bDJMbFBvdmZJb2pES1lQZmUrVG1vSC9XQXRiV0RMRFFl?=
 =?utf-8?B?ZkRGcnJxaFRWcTRDVnMrZjZzSlFhVnJiVWNTQm1oc3BBSlZyUEtqOFh2Smp6?=
 =?utf-8?B?UXRJM1VhTHZoQXYvUERjd1Z1Mjg1QmEvS1lrN25pZURHUUVvNnJEQmtwRUpL?=
 =?utf-8?B?SGMydjdXOWRnSUdXRjhIdHoyMkF0bCtDYkZCWk82ZTBZemt0QkluemlNSTlD?=
 =?utf-8?B?SDhxb0E5Z3VLT01hTTlwQzdRVGhTanJLOVJJYjdhaFpTRmhuYVRSeStkUzVa?=
 =?utf-8?B?K2c5SXQrZlhiSFp1S2s5RTZ3WlhDNUZEMTRGQXlxRUlKRUVUMEpHZENXRzA4?=
 =?utf-8?B?TUZzZzhWOUZEOHlud0oydUpBaHM0cm95SGNtMzQ2WEM3N0pzc0NoSjMrVXVh?=
 =?utf-8?B?TDhLVE1CS1Z6ejNRKzY0NEg0dkVFVS8xTmNuZXdpN1FXTStSbjRSc0QrcEha?=
 =?utf-8?B?Smhqc04zRi9GU0dBK0ZrSXhKK040UGx2VW9FdjE0Z08yNnJTNkNXWWxGSURx?=
 =?utf-8?B?QVdlaHRNTGZhRWhtU2ExV1hpTkxsaEZldDFSK2NONlQvcy9tNytjdWVyL1N4?=
 =?utf-8?B?aGVJb05ybUkrWTg4UkVuQURtcG92RFFuRUx4cVlZOE5KR1JOVFdUc1JsM2hu?=
 =?utf-8?B?ZFVVYWJVVTJuRDhFc3FWcVFDQmllOFF4RU1uZmNkVThDeUkrdnF0STVkNmRM?=
 =?utf-8?B?czhjRHV2a0NYV0c1Z2F2QllOeUphWDIza1JtSGZVRlc2WDk2TllmNXVEWW15?=
 =?utf-8?B?MkZxTC9jbDZtcXd2dE9ZOStHcjI0SDJxMEZKeHNlazNOUWJYc3ZsRGVUbjJ4?=
 =?utf-8?B?cW1CSExidnNVMEcrY3E0UmVyRSs0aEw0V1JPSFRCTXdTY1lDT3VIMDJ1c3Nt?=
 =?utf-8?B?Z2N2Njd2MkZxTEo0dFhGSTdlMEVQVFVjV0xxOEJwWXcwM2dCRHRKTWlPWTdk?=
 =?utf-8?B?dUZSaE15MEROMmZsS0lYdGlkSk43eHhHR1NQYmtwcG90Y21ialJUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sCG4+3KIdltcrvqlqoXtuCTJJU1nIDp2vKrRrTzOjs5daIWeBS7y8weaLWzkBdwCetpPNS1i3aDXaB6WTF01XxczSEfK8ooSqhlyZ2PTxlG76Krj5rDKvxJL3uLPHV2XLh0JGZyqa/4yfdMQ1TrsXoSWnANZI0xj15QkExV3znBGun5xRMY9yNj0qXOOr3jnRnNqDHgO6gZOY+SvnM8969wNm3flUPoD0++NVMJOsjLfR34pe3VluPSY1AEQWdG96oRgJKCd48JWyjK+WVj6nvlqOOcM4QOx32/P9PTZRf4LXMVttYPdtTjiM7wSgoS0kqZ6az2hzcIoPmYTT0QgnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6467.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f802d8e-b1ee-4a58-4714-08de99599b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 12:38:47.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLy+QUEJYqSkXT9OQwllb5ISTJqIBMutBxLS0HN745wellWiPCSM+HVIqrof9dXpNKQ+KxNAhXXRjvU4mb+Ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9465
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236043-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,lists.freedesktop.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nemesa.garg@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1F2123EC292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtZ2Z4IDxpbnRl
bC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBKb3VuaQ0K
PiBIw7ZnYW5kZXINCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMywgMjAyNiA0OjU0IFBNDQo+IFRv
OiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14ZUBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gQ2M6IEhvZ2FuZGVyLCBKb3VuaSA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29t
Pjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9pOTE1L3Bz
cjogSW5pdCB2YXJpYWJsZSB0byBhdm9pZCBlYXJseSBleGl0IGZyb20gZXQNCj4gYWxpZ25tZW50
IGxvb3ANCj4gDQo+IFVuaW5pdGlhbGl6ZWQgYm9vbGVhbiB2YXJpYWJsZSBtYXkgY2F1c2UgdW53
YW50ZWQgZXhpdCBmcm9tIGV0IGFsaWdubWVudA0KPiBsb29wLiBGaXggdGhpcyBieSBpbml0aWFs
aXppbmcgaXQgYXMgZmFsc2UuDQo+IA0KPiBGaXhlczogNjgxZTEyNDQwZDhiICgiZHJtL2k5MTUv
cHNyOiBSZXBlYXQgU2VsZWN0aXZlIFVwZGF0ZSBhcmVhDQo+IGFsaWdubWVudCIpDQo+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni45Kw0KPiBTaWduZWQtb2ZmLWJ5OiBKb3VuaSBI
w7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gaW5kZXggYjRjYTU4NDNkMDk4Li42M2MxOTk1OGE5
ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNy
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiBA
QCAtMzAwMiw3ICszMDAyLDcgQEAgaW50IGludGVsX3BzcjJfc2VsX2ZldGNoX3VwZGF0ZShzdHJ1
Y3QNCj4gaW50ZWxfYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+
ICAJZG8gew0KPiAtCQlib29sIGN1cnNvcl9pbl9zdV9hcmVhOw0KPiArCQlib29sIGN1cnNvcl9p
bl9zdV9hcmVhID0gZmFsc2U7DQo+IA0KTEdUTSwNClJldmlld2VkLWJ5OiBOZW1lc2EgR2FyZyA8
bmVtZXNhLmdhcmdAaW50ZWwuY29tPg0KPiAgCQkvKg0KPiAgCQkgKiBBZGp1c3Qgc3UgYXJlYSB0
byBjb3ZlciBjdXJzb3IgZnVsbHkgYXMgbmVjZXNzYXJ5DQo+IC0tDQo+IDIuNDMuMA0KDQo=

