Return-Path: <stable+bounces-245173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHXsHvOmAWrlhQEAu9opvQ
	(envelope-from <stable+bounces-245173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:52:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C350B5F8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDC943071843
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D73B774B;
	Mon, 11 May 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoOQ2bwM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0B3BD63D;
	Mon, 11 May 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492452; cv=fail; b=MkjdaLvKZrSS8IsmhwHOjd2lXeSJcQh9JyAaElJ68w1VryA/q05P9Q65E7mEOAFC0gBOwg7yXUB95QThqFzK6A2zs/LgbXKfGBfkVwrVD/JYQZUh4oGD+CgMOKtL/AGxX7NdyJQc0tvrhPHQVojiRm2OHJdDy2/jtRpwOlten7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492452; c=relaxed/simple;
	bh=r14Vrn8GAWFB/EQBIfO1GAQFxgsarjh2kaFl0qNY6sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGUO3zP6wDKCdC4NmUMPy7OzxKV9waS+GcvCvAsEbIy8lC7BuuvF1gCfHkNWAwqm0kTZKBekEVuIidx9ApsNbV20SukHnvBGld/sbJx0BjqS3NiUWeQ/TKGpikddEECO1s9p/5uzRIBTNE04tOFEaP9sVpt5Yqzonk9WQECpdfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoOQ2bwM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778492451; x=1810028451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r14Vrn8GAWFB/EQBIfO1GAQFxgsarjh2kaFl0qNY6sk=;
  b=VoOQ2bwMywvY8OWGYb8aMgJvV13ku/4wd4dK6KRWtgoPyG6NVsfjTjAV
   5rp3IiTCXnSkp+Gxfv0duvmFk5Q5F1zvTXHaI31tI3DOUegV/srAd9ONy
   KOYD/Kpo5miE8k5z39AiYvG6mUxeQY/A54WBvbtUJAodt70FbS7xWCH5U
   5OsmxljkWrDZdjpFrr7SKUMbLYXudkXH3WIYQywnd6kuekHKE3+6yIE23
   QLS79BDymA+eMU7ZzOadwjBg1mA2U/76eQiu9ySr+cJ6EIEbxglbp2cvH
   cVoP0qAdqQNjnQYtuFmCTwQhKfxCWvs0iWaAwCpUL+dVstEbG12JZIZUj
   w==;
X-CSE-ConnectionGUID: YAV5tKqaQn+NnbLbSq6ohg==
X-CSE-MsgGUID: pRgVo+hyRju0gCNW1A8UYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="78519107"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="78519107"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:40:50 -0700
X-CSE-ConnectionGUID: /D/qCeGuRaediMjGCFl1+g==
X-CSE-MsgGUID: 8gBZYSZtSqq/5jzuE/GB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242393098"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:40:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:40:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 02:40:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw73xxmT84Emp2npWNiRvCzFAzvLUH1eGGoNgcIeHHqnffTZ4lFtH95SUUZAu4BXRoiGmQiiqyZcIGD+niHDohYccNNyD9vPAHYF+LwMhNYavwXSxXmDnnO/BkwqTnIwXB7bEHs/MWtWytZVpbJ17J/zktI557sEO70y1X1zKmgXv03KPtNIYdOp225Kd1pFCy4ki2tJHexUD0ettiXD4B4x7vEZU/xMd7AJJrqedWmcToDo14XZ3iQXMgCBac4ba/PGBGrguirlascUBiLrCNNXmGBpDE0BVDvr7ksle8eVKCYLQCZ+GzREg+yaLsgyyaAwMCOY5n11+PBem+PdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r14Vrn8GAWFB/EQBIfO1GAQFxgsarjh2kaFl0qNY6sk=;
 b=dcVNZL/KpJkW9id7UQUajwOYQTiTGxReHdXBQCEdmkunISpXi2QP+JDkXXJQ9lABsMPtYGWX/0oF2svWWQa16cXiy7ckUq0QNfFnxW4mLtgZjzSZ/t+QF2Svoyd3oG41A6N4V/5YWw1giX7t39Is2IwbAwezGrof8FHkMcfoiehQ8P/szpaN1HE4d/ta2vqPAwLTm8PM2Zck4ERlbp6hvVQAdqHFtMmdnfTwqvxz3zQIJWvwwafHB2ASLvxyhozu8lwdqOrf1VosxOSrhkWXZEQ5c9OgxJJv6B+agXsntKA00BkQtP92mYAEjEOfjKLlaDqapp5ryfpPUNsgylk9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:40:47 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 09:40:47 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Michael Bommarito
	<michael.bommarito@gmail.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ixgbevf: fix use-after-free in VEPA
 multicast source pruning
Thread-Topic: [Intel-wired-lan] [PATCH net] ixgbevf: fix use-after-free in
 VEPA multicast source pruning
Thread-Index: AQHcy6AO1gCTwG4iLE6EKMlYE96WG7XgT2sAgAADv4CAAZ5dgIAmy6cQ
Date: Mon, 11 May 2026 09:40:46 +0000
Message-ID: <IA3PR11MB8985F6561982F08FBE7A40968F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413182427.298513-1-michael.bommarito@gmail.com>
 <20260415161720.GN772670@horms.kernel.org>
 <CAJJ9bXwQyd-cZ0h_FCNj29GZYpXyCBu444VhLGLZkf1bWYqoKQ@mail.gmail.com>
 <20260416171349.GC863718@horms.kernel.org>
In-Reply-To: <20260416171349.GC863718@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DS0PR11MB7580:EE_
x-ms-office365-filtering-correlation-id: 8f638893-edc6-436d-98f7-08deaf41611e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: wRZqSVugyaLEs/gVgiVyOtlWMT5DBNyVJofFR57NZcDH+ls1qGj9aOcrnV8gumA8WJlJz2ZNxxXVV2F5c5f2ZOJbEhhHfB1nYxhVQlyA4GQVl+DuXxykJEs0EWdgtMC+CyqqK/h5LdnM+yHGU67qUAUNulC6HyEUGHUniKAB1uqfF6x9BJyiXPdUxaQPRRV66egCa30BpBoUgkcQWasnHSrjaDhjaeopcFqThbeiUa7YNgKtyvacujC/2HuG/dKQSdYOnoSYGdadD2qvuHzNosGWccDbJ4Z79KHnMBL9cu6HkVUIWNAl0ljTMidDj5sa/Ik3xxkrBsKDaSWhW0W7Wuw4PGD/mFvUyqytoimjNwo+pvGQGdr2nXYGP/4vX/1E/qQ3Rqvoi9haea3DRmM472CAxdD8EFcBSJbvrxBUoDCQMgMgZ/rLDNgbG7mraWnt6HdjQzi3YTn0DFWI3ntXT2/wKDKXZNMz9zzm6KNkp6sSinUISOhKIfELfF75+eHZ+ynbtRMLJg232nY9OFocrzZtWGVaHbgxSatzTFLJpH16f2fK5VMpZWC5WWkJAunz3Fhben87D6+b30DLIcPexqNvWquhuLtALd7IS5ZKQL+t09kPuCgUODns7BsUtMoSyx9fmAlPXpAvRtSaFzBv3e7TM2wCZY9Fs+YBdwllVzmk1RPtpjzpmjgWjGWKlehMFMCcfoWVlTWhqefjPCd8nqRa4mdOXo+FmDMLGaMruXuCKCrlLg4GCYPgdes20zAo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnRJSDdpRmQ5TzVZY3Y0OGhyNTN1U0JoZkpwWXAxalNNRHZNa0VudTVWanNQ?=
 =?utf-8?B?MngwRGd2em5JOTU2eFNPcUpETlFEVjlvaHg4ak5uckJVaTRVVUhJSzl2bGRh?=
 =?utf-8?B?Ly9OOEJuZWwxUytIdUFZUVJGazU2U01SUEZGWTNsUDdHOU1uVmorUW9Wbmdm?=
 =?utf-8?B?Z2pVanF2YU1nUnhRQUxWNG1WOTJPRGIxQVFOcnJLWnBHWDFoRzYvK2ZSSmpZ?=
 =?utf-8?B?NCtVT2dEeU1yR2xXNVczWTNHendybjZhOGt0NjBSYUxFRlNjakFhbUFmTHE2?=
 =?utf-8?B?S0FRQmU0QzRPdEd6VFdFbmxzS1RrZjJRU2M3dG8rQmx2K3FoalRjSnhGY2tE?=
 =?utf-8?B?VVd5Wkh4cCtuS29xYmNTL1M1ajgwSldMWlJrVDcxemZ5YzV4OVphYllHMDNj?=
 =?utf-8?B?bEIvRE0zNUt2MlA1UTFWZFI2cDkvaEVYZCtacTVPeU1NSHI5N1ZKSmxpWDZU?=
 =?utf-8?B?Y0cxalN2d0s1dThSM3BvRXRmRVMvRHZmeWtha2xTVWRseEIvTUtPWEE2czFF?=
 =?utf-8?B?MzZxNlRFeDN0WWxpODZnUlV1eDJKdDIwNVpnL0pZSDdEUzI0cWJ4dmRXUUU2?=
 =?utf-8?B?ZUNoMGhJYlhpcjBhWm9wRWt0U0JURFpaRjJtU1Ivd0hTOG1ScDJwSUxpRHpL?=
 =?utf-8?B?THdCY2NQWXNQMjMrTFJnUVdSUjNEVkRKdlpjelUwY1pISmN4SENyWi9QVXha?=
 =?utf-8?B?R3EzRWFwcEZRS1J4K0tINWw2eC9HY2lUL0Rvd1VsNWdOdlRXRkRJYXgzckFJ?=
 =?utf-8?B?RktVWHIxUXM0UXNRRnFpUU04ZW5HMGZzQXdOMEg5UllqcGF1a3BxclRuWVNI?=
 =?utf-8?B?Vmt1VENkSDBKZ3lGUU9oMUpwTjVZbDRqeVJSMk9NZ2lSd3lGU2VUenRQSStm?=
 =?utf-8?B?L3RCWmlFNkdaYnVXN3NmRHdwMmcxOWltWWNBOUZDamQ3eG42L0V2ZThyN1Zr?=
 =?utf-8?B?VmNkTE42MGFhbHhQMDQvNUNKMU0xRXVhRTVYQVVxSUd4bVV4V2JmbGhjTWla?=
 =?utf-8?B?WnU0MTVNL253bzBOYVhmMGtWeVlGcEtlLzAyZ3dNN2cwQnBYNm83NzBQRkc4?=
 =?utf-8?B?ajNLUXBoazZnck13OEpzdEJxV1dMWkpGUkU2OUpXUTFyeGFkQmRLZC8xcjJB?=
 =?utf-8?B?OGxYOUoyaFpmdGtNNXJvL0dLOEZFU1B4N3plY3pJZzZ1QTI0dVFvNGFWQVVL?=
 =?utf-8?B?SVVGZEpjWllSUFZXSDZqTk1USlNjaEhCQWJqYllveUhZdUM5eDArR3RlRlZi?=
 =?utf-8?B?S1JxV0JrTXhBdFE5SjhUWWc4TkJxU2FEQWFPTFFjRlRRcHF0Ny84c3o3WS91?=
 =?utf-8?B?OGF0SXFaNmxUVDRIS2VFNkdoV0V5TGY2cWd2SWhkcnUwRWdHMktHUEdtUzZR?=
 =?utf-8?B?dDZJNnc0Wmp4c1hudEZZTUc0RkljYU5ybG1hamFlQ1FDRkFxSlFSRC9lS1hr?=
 =?utf-8?B?UXFzemVIanNDc25Na2Y4bHAzbnpWMDZVbUZNc0Y3U1A4UWdHUFZPNkh4YlQv?=
 =?utf-8?B?TXhjbzJtMTcvSUxVN0E3VFFsTEwwYTdJL25MMElJTnlUQ1hMNUJnY3pOeHpm?=
 =?utf-8?B?Rk5HaFdWcFNMZllWYm4vZzZUV1NHY1gvdWhOSkFHRU1nb3hGdGpGZzJ5NUU2?=
 =?utf-8?B?VFdKVnJLZldrVVhLcHdFOU9QNFNmWE0rYkZPR24zKzlqb2d4dTVuSjhtOFRQ?=
 =?utf-8?B?WEo5Qyt4ZjJMRDBjWnZudG5SNU1ObmRzTDBEazdCSW9KS2ZydWlLSFBsWHdr?=
 =?utf-8?B?ajdCODhQZUpUOHFHdk55MU1RSXJIcGVsb2JwM01ja2U3blM2U2xxNGZmVzF1?=
 =?utf-8?B?UGxBQlJEVEI1MU5Wa2RQTDFxenI0cVFQNThzRmQ0SnltN25BZEtTdzNCZnRK?=
 =?utf-8?B?YWxtNTRiYmFtcS9BR0hFZnFvaG1KQjNmU0ExVVRndGZWSjBYSWRiNmdEZ0NQ?=
 =?utf-8?B?QWt4RXBZemJVZytWUHQ2dFlLRjhyYkJmT1U4Z0R1QVFmMnJodmt4QmJ4cG9D?=
 =?utf-8?B?VUpjMVNsalkxM0hzUk1vWVhzY0sxMWUwcXk1M2VSMnFCbUs0dndqTGtIYU5J?=
 =?utf-8?B?cXJEY2JicmtzUDdqeEZFVVRuQmo3bExjYzNnS2hWZnc2WHlzWUpmeDJXRC9V?=
 =?utf-8?B?S2pRVkc2YXo3Tk9TVHlRZDRrdHJjelk4WDhiUzhLWmpKYWxkQ2IrRXQ3Vlpl?=
 =?utf-8?B?Y1d5R3N3UFJHaXZTc3EvNnhlanFQK3RWNE5URFdPQWRBU09Ub0VldzdabFVl?=
 =?utf-8?B?eHJ3amIrZU8yTHVDb1h0VFppTmFUNW1heDBhVW5JdkRNTmxCczBJVitiVExi?=
 =?utf-8?B?b09SbWRaSjRxTDlXcG5uSSt6bmNmZTF5Z0diWGRMQXVXTFB6bUdYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s7huGXx/ZQJuS+4j1Fs3FsibXbJDg+ZylptDT+4+4KiJKyJ3DzwxxZjvmMXsvxet7jlZ1zuf3fhJXG8HxzOJEI2+RLN0nhBRNNTuBOLFIJ3vP01AprpEgJiiHkH/EW8UW++yZ36B2Y0XjtXIGzFaCZivAKRbODE/hdCZV2OGNzveLUxvsjR+MKq7YxnMdXs5L3MLbzjeu/mLP5WCKOBgfat2fNmHHPtHV8ppweej4E8xyS0WArL71vZakgp/qCQx/aZprpzZv2sAPjo+XVXZ5iNcDyI6IbctuaZOHvfImJyJrEpsT/xY5lTTETReWFzb0oW8aBKignvDcSu9I71eWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f638893-edc6-436d-98f7-08deaf41611e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 09:40:47.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74XjFyVrOD6gQY7sbzOQkXhm7WBJ0AyC4f9qFt7E5lMKFKfvb6ubMOjHkNoDUcbyEf/pkG5GVUdeUECN+99CCLn0AZEvti6EF2hZaCpkpcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E56C350B5F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-245173-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,davemloft.net:email,osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBTaW1vbg0KPiBI
b3JtYW4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE2LCAyMDI2IDc6MTQgUE0NCj4gVG86IE1p
Y2hhZWwgQm9tbWFyaXRvIDxtaWNoYWVsLmJvbW1hcml0b0BnbWFpbC5jb20+DQo+IENjOiBpbnRl
bC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhv
bnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+
Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQN
Cj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3Jn
PjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBuZXRdIGl4Z2Jl
dmY6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBWRVBBDQo+IG11bHRpY2FzdCBzb3VyY2UgcHJ1bmlu
Zw0KPiANCj4gT24gV2VkLCBBcHIgMTUsIDIwMjYgYXQgMTI6MzA6NDVQTSAtMDQwMCwgTWljaGFl
bCBCb21tYXJpdG8gd3JvdGU6DQo+ID4gT24gV2VkLCBBcHIgMTUsIDIwMjYgYXQgMTI6MTfigK9Q
TSBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gU2FzaGlrbyBm
bGFncyBhIG51bWJlciBvZiBpc3N1ZXMgaW4gdGhlIHNhbWUgZnVuY3Rpb24gdGhhdCBkbyBub3QN
Cj4gPiA+IHNlZW0gcmVsYXRlZCB0byB5b3VyIHBhdGNoLg0KPiA+ID4NCj4gPiA+IEknZCBzdWdn
ZXN0IGxvb2tpbmcgb3ZlciB0aGVtIGlmIHlvdSBhcmUgaW50ZXJlc3RlZCBpbiBmb2xsb3ctdXAN
Cj4gPiA+IHdvcmsgaW4gdGhpcyBhcmVhLg0KPiA+DQo+ID4gU3VyZSwgSSdkIGJlIGhhcHB5IHRv
IGtlZXAgZ29pbmcgaGVyZSBpZiB5b3UncmUgb3BlbiB0byBtb3JlIGhhcmRlbmluZw0KPiA+IHBh
dGNoZXMuDQo+IA0KPiBTcGVha2luZyBmb3IgbXlzZWxmOiBJJ20gaGFwcHkgdG8gcmV2aWV3IHBh
dGNoZXMgdGhhdCBjb3JyZWN0IGJ1Z3MuDQo+IA0KPiBJJ20gYWxzbyBoYXBweSB0byByZXZpZXcg
cGF0Y2hlcyB0aGF0IG90aGVyd2lzZSBpbXByb3ZlIHRoZSBjb2RlLg0KPiBCdXQgSSB0aGluayB0
aGUgSW50ZWwgcGVvcGxlIG1pZ2h0IGJlIGFibGUgdG8gcHJvdmlkZSBiZXR0ZXIgZ3VpZGFuY2Ug
aGVyZS4NCj4gDQo+IFBsZWFzZSBiZSBhd2FyZSBvZiB0aGUgTmV0ZGV2IGd1aWRhbmNlIG9uIGNs
ZWFudXBzOg0KPiANCj4gPg0KPiA+IFR3byBRcyBmb3IgeW91Og0KPiA+DQo+ID4gMS4gRG8geW91
IHdhbnQgc21hbGxlciBwYXRjaGVzIGZvciBlYWNoIG9yIGJpZ2dlciBtZXRob2QtbGV2ZWwgcGF0
Y2hlcz8NCj4gDQo+IFRoZSBnZW5lcmFsIHJ1bGUgb2YgdGh1bWIgaXMgb25lIHBhdGNoIHBlciBw
cm9ibGVtLg0KPiBQZXJzb25hbGx5LCBJIHByZWZlciBzbWFsbCBwYXRjaGVzLg0KPiANCj4gPg0K
PiA+IDIuIEFueXRoaW5nIG9uIG15IGxpc3QgYmVsb3cgdGhhdCB5b3Ugd291bGQgKm5vdCogd2Fu
dCBtZSB0b3VjaGluZz8NCj4gPiBJJ2xsIGNvbWJpbmUgd2l0aCBhbnl0aGluZyBJIGNhbiBmaW5k
IGZyb20geW91ciBTYXNoaWtvIGl0ZW1zDQo+IA0KPiAuLi4NCj4gDQo+ID4gICAgIDMuIGxpbmUg
Mjc2OQ0KPiA+ICAgICAgICBydWxlOiAgIHNlbWdyZXAgc2lnbmVkLWludC1hcy1zaXplLXBhcmFt
LWttYWxsb2MNCj4gPiAgICAgICAgbWF0Y2g6ICBxX3ZlY3RvciA9IGt6YWxsb2Moc2l6ZSwgR0ZQ
X0tFUk5FTCkgIChzaWduZWQgc2l6ZSkNCj4gPiAgICAgICAgc3RhdHVzOiB1bnRyaWFnZWQNCj4g
Pg0KPiA+ICAgICA0LiBsaW5lIDM0NTINCj4gPiAgICAgICAgcnVsZTogICBzZW1ncmVwIHNpZ25l
ZC1pbnQtYXMtc2l6ZS1wYXJhbS1rbWFsbG9jDQo+ID4gICAgICAgIG1hdGNoOiAgdHhfcmluZy0+
dHhfYnVmZmVyX2luZm8gPSB2bWFsbG9jKHNpemUpICAoc2lnbmVkIHNpemUpDQo+ID4gICAgICAg
IHN0YXR1czogdW50cmlhZ2VkDQo+ID4NCj4gPiAgICAgNS4gbGluZSAzNTMwDQo+ID4gICAgICAg
IHJ1bGU6ICAgc2VtZ3JlcCBzaWduZWQtaW50LWFzLXNpemUtcGFyYW0ta21hbGxvYw0KPiA+ICAg
ICAgICBtYXRjaDogIHJ4X3JpbmctPnJ4X2J1ZmZlcl9pbmZvID0gdm1hbGxvYyhzaXplKSAgKHNp
Z25lZCBzaXplKQ0KPiA+ICAgICAgICBzdGF0dXM6IHVudHJpYWdlZA0KPiANCj4gSSBkaWRuJ3Qg
bG9vayBjbG9zZWx5LCBidXQ6IEkgYW0gYSBsaXR0bGUgc2tlcHRpY2FsIHRoYXQgdGhlc2Ugc2ln
bmVkIHNpemUgcHJvYmxlbXMgYXJlDQo+IHdvcnRoIGZpeGluZzsgd2hpbGUgdGhlIG90aGVyIGl0
ZW1zIG9uIHlvdXIgbGlzdCBsb29rIHdvcnRoIGZpeGluZyB0byBtZS4NCj4gDQo+IC4uLg0KDQpU
ZXN0ZWQtYnk6IFJhZmFsIFJvbWFub3dza2kgPHJhZmFsLnJvbWFub3dza2lAaW50ZWwuY29tPg0K
DQo=

