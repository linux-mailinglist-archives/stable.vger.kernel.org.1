Return-Path: <stable+bounces-237824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLViOI4n3mltoQkAu9opvQ
	(envelope-from <stable+bounces-237824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A25333F9762
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A888307BBCC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746E3DCD89;
	Tue, 14 Apr 2026 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZyjuhkQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D23DB650;
	Tue, 14 Apr 2026 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166610; cv=fail; b=TrqJcZKUEpWRh/Ct+5LZaLVSWTYlzDY6BM5O2R/tTsiBF4OkeDFHWSDDCZy3ZSmr+vVxzI16+scatFKWLEV9scCfoOLGc1Upe+CcWsGddP43zLQDBSrTu5kRHCv2Ks2EAn7e8xpJQgGSxWj6NTAikdRfFfOqya5Hge6+PhNas9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166610; c=relaxed/simple;
	bh=jvsKCTBAm/tTMGUkP9kItNTiHNJGhIB6dyFi+Lb/eUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYlPECTSf2GFqbx/2ArPbDDnioMZrM322PXqnSTA/aWL/2QV4pXr6W7qTIdNoH9xqaetDzcpLPR3ZHrlNH+0yr2mVZppATaMR2HFpE9G4u0eXjLzphep2KIAd5CP7Rlcub3flk/1inKfgqOCn4V+krTHxpuoT/6smAyZuKNiYCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZyjuhkQ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776166608; x=1807702608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jvsKCTBAm/tTMGUkP9kItNTiHNJGhIB6dyFi+Lb/eUM=;
  b=YZyjuhkQkQLUXi2jqb48buOI0HCrZuHAQEHVRaagbAd14RpdNsIZSV2I
   dhF/Rxfg1lIH/NLvf/NWmjLXeYrhk6UUjv8O6IeVPMA4jl35qfSbjE3Pz
   NVgRcMbmZR1RYzq+/edfLa6xg1+xx4/q8D+Ij+jESnIO/dl6NBIizxvCJ
   szfS9ebS63FktREhYuSLVBJwWtPoVX9Wq9WsCr265D0vmj6zrzMwImIQK
   prPRJ8L7oxw9vKjIx8Wq75v8AAy1nlxMaZ8kXGF/aJY3qjBjHRouDqXVN
   fZIQ73DGvzjEGcSCMpyjmzJGdlLZFfWCT8Zn8HBTHHiwJwKTQRo86r35m
   w==;
X-CSE-ConnectionGUID: XjoYtwiSTZ21CcuCoX/qpw==
X-CSE-MsgGUID: SxZTtfeARg2yJ2W1/Kzi4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80984514"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80984514"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:36:47 -0700
X-CSE-ConnectionGUID: 3uOV835OReSsZNTy9ZXIJQ==
X-CSE-MsgGUID: E8Vku+diRGaI4qQ2nYEnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225346340"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:36:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:36:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:36:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3beOGWaq+sUeZl+PZovJD08cN8ZJZ9z7ORkJtHFSUytfhONc6781wv575Dj30xMZm1VKKxESDUATcy77ZvYW/PdqMpPdylG7AEhgChjNGxKjemPjXbwxjaDH/K5Ql3sdpX6Io9Xu1el08OyMuY8252GgLCyU31U01pf0qPM7V6WHl4MkFXfdX39uPd5lNmpkglKJUDcEiI5uHP8zx3nTvqynyIVf26m2SK7+0HBLLWAMO+XxE5yBVWpJFAqv6tpymuNhQdNBhf8kl/W0BXwib/JmOAXIsx0uZ4OoasgbvActd1Xfx7ww1XimvK6HCdHsw99v/2dIse3cV5odaQFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCkDuQlHCM3ATQI3l/S5MX1YOMzWlZepLD3h4hbV450=;
 b=Y0cJHQe56GicMkZM45VoKwnFetGCzbrBKBsyc1WhHaA8nrxljfL9wWBMR8aP/2GcXEIH1crfo80HIcunbXvyEYIGZTwTbZmALQN3bqsVvs8q/TZaf9OaUZw4wIK+WbDLeZ0tifRJd44CTiN1Duarca1Z/oQBfSNSzegvl2AL+jBMbqLyrFk2rsEmZsbGAHY4POPhep3fEFm+5hw6c1KKhoX2Ouo3+r+rz4VJx1E/66ndgJJrSbHHfWneeVKM/TQXVI6P9Ihu1RnttUhw13IMPlZQnvyFz4jsKVt0S0FxmHc1djBE392U+7k5tXgRIX8QAdW6J2uZYk8yQxw1Q3aI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Tue, 14 Apr
 2026 11:36:42 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9745.019; Tue, 14 Apr 2026
 11:36:41 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Simon Horman <horms@kernel.org>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>
CC: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org"
	<ast@kernel.org>, "willemb@google.com" <willemb@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "decot@google.com"
	<decot@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "hawk@kernel.org"
	<hawk@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix xdp crash in soft
 reset error path
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix xdp crash in soft
 reset error path
Thread-Index: AQHct/GmXoFitUEuIE+GYFwBQ2vxA7W3s7KAgAA/awCAAMQwgIAl3PSw
Date: Tue, 14 Apr 2026 11:36:41 +0000
Message-ID: <IA3PR11MB93015C0824E82CDCD21AE2008A252@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260319224159.23885-1-emil.s.tantilov@intel.com>
 <20260320174843.137651-1-horms@kernel.org>
 <0275cffc-7a61-46fb-9d1e-c309ac680b80@intel.com>
 <20260321091753.GT74886@horms.kernel.org>
In-Reply-To: <20260321091753.GT74886@horms.kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|SJ5PPF44E8B88DF:EE_
x-ms-office365-filtering-correlation-id: 4ed1d05c-54d8-457c-aa65-08de9a1a192a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: fUESM13/LlAmEB42m3Vkdu0qplQOn8+Ly22UDdz1dexem4yiMo3kN5L6XLKxjZWcRpHA/YZkOVMuGsLg/W8wM4Acs3+MuLDAghBvANJ6QUIXymD4+8ZMgyC7S5bJeoeA0CGRMJoUC2wQC9Un6vQbmr5ZDHEIaJa6JSwSBYfHI2f0rBob/yNWyCnOlyKHpxpMpo0qp9babzhhgWnBlNQXWQdbqevxAb1b5pN0vPqU5CdP/nzhqLtQGIlIHGWPktweQfh62Q6kFmKKwUfg0qTr/Yoojb4D1mDOrD3YAHoiNYV/y81O8YNQ2KBljZ4lSZkWbnrcbzknlbTN+UiPKOHgcKxHonh84SSQ1DUqvGARMZRaGdt8wSU3KvFCiQiKxoFAW5XOK64OrMz7HV9K8X3QTvT3y2twGZzcFU7wYk5JDE0apY/uhHmuVXRbKvJa526yJgKHte7X4zPQ5Bwo927tdBs+QlL09ZJXvKkFDzrdpmoyaZIBg10fYIwwgs8fc56waSDbu+uiYeWPqT+qIHGcp1LzzOlIhLH4rJmhjVmP/bfcAnzPRH2F5BxJ7bgqs8ZscvJ+aXWBbS4UkLovcQTTuMaExottxjOhth4IERvPISJ4jK5zUnwiGtwCLmIgkN/XHBCwXU0fsNjSXGyDTQ1xW69zixz8AvIIozQZ8pJC5N2qgkipKM93PLHlm/8vTVJ2vPJB/SBt9DtMTPiOyOPShoREx0QP4Ljks7b+7GPPMLyY1BH9vAe6QFe/bCvALXAK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S08MoYvdi4bBD63XYQy4Odg6Wzw+dV3rFlerHAJUPJkLZXwNYBeLj540b8?=
 =?iso-8859-1?Q?I6DOnAz3hxJjTHsnp8Z9o0AlYafYXiOcaxfWAKR0T1l+4ttsU3yueRtsVx?=
 =?iso-8859-1?Q?+Nt1qUtvFMd2MwGsC76OXriGt9ZOHh+FGmL/MdsKOWSPWqlAvS83YQmZ7e?=
 =?iso-8859-1?Q?5aRRCHMS+aaEDlWswQSR5G+JQrSi5r/NyEBR7tmKDskFNfO8YhIr8leYF1?=
 =?iso-8859-1?Q?J9EOsi46Qkstdf9y3JFVSfcOuuKCuRKOcYPMN4E4mpHEoiozeE61l00mb5?=
 =?iso-8859-1?Q?5AB58U5wotsy+EphY4MqaBokr4FJLce1aw3/DIuRfuMh/euGge2/RgiCXi?=
 =?iso-8859-1?Q?OX7mejFZ7CY1Q5GX1b+ea6pzzEZHZeBGeCnay+q8pfbb1aqZIAbrFSIfhB?=
 =?iso-8859-1?Q?1Yi1WOP8T2AzPq24mH9WdJmGTn6nDj58o1mejTjGNWveLbODpgj3KFUQ8e?=
 =?iso-8859-1?Q?FFOqBhhUmE4XWr8GEtcqM7pQSPWk8TFFq0QOuN818sin0s3BjM6bgyAHdl?=
 =?iso-8859-1?Q?ijDMwLMf7x6XDTodsZ3cBpSzF7pgX1/lPETwjEiJR2X5S8ZnDTKRcTGWpA?=
 =?iso-8859-1?Q?oDbc8usR+DaAh/4+kBPN7AA05wzSC/pmMnToKq0+Jbn67c6JdSBhvVowXn?=
 =?iso-8859-1?Q?JH3FJCb1VEZetPQZa2BlIMX4l+av9e+WzlUhDjKIZCAbsM4blNLPMr+q5k?=
 =?iso-8859-1?Q?uJ6+XOD16H/9BnH38JRVLp8FKjTnv016ywLmZsjYPjQhsvtfh2CZKUoMkg?=
 =?iso-8859-1?Q?Wzl1T/xi51yIP9VXssJD9/kT/UPZiQNMyC6e3lFkRxWYml/HK5NqeWZseN?=
 =?iso-8859-1?Q?bWsyMlRlGBgUbf5b0K9uXBCzqq3ByGy64PaDyyHZDZetQmOYlcWEIKzqgN?=
 =?iso-8859-1?Q?XLNsme4/I0rznMFPr4eTCpueNW5k/LbsTEAyhjK0fIvuIPF7/R6TQ5acax?=
 =?iso-8859-1?Q?0La46aIy9Kk+UnWrTJsp2uiPQFynH3KD8Hhxm1LyCIHy2x/L1HGBzxEae5?=
 =?iso-8859-1?Q?v10NAaYdEn7hVs4IjIQlc5lbav4VjYaeYUelLLrc55LOsnBXhC3UM+j2e4?=
 =?iso-8859-1?Q?/o992jihV8+UYBY4cFPsxmibuBj6dFM+WGh2n7slSbTL1fP1xYofW60Njh?=
 =?iso-8859-1?Q?32S/j1uqJXfLqtFoxbh9fCAyAv2kkvLrw+uNnl0o2vknz7yPExoZOuKpys?=
 =?iso-8859-1?Q?vd2350llh3+/QwrAc9cPQ2I8fSYf8D/R8cUVlTEa5hRqe8pWJAI5zaxMaW?=
 =?iso-8859-1?Q?ycDsQwPnjhIGVQZv+78VPV1AlfCehUcHvVTyWqJ0B17E8J2YdEZXfpHZaS?=
 =?iso-8859-1?Q?RjuLVXrYpGVaRhHD0fGcqmn/dn3cdTnAAvWrKFWmfjVT4+PQgbfhsswRDB?=
 =?iso-8859-1?Q?QF1qs8gAWwu+RTeeVFOS2g2AQjFVr1eNuElRula0gPd3NpjyxSwwHFTpmr?=
 =?iso-8859-1?Q?3xZeQNFCcNeOFv/BvonJICJDUFuMmZJFCHYqJuto3Yiq1PFoc4ifWwj3DB?=
 =?iso-8859-1?Q?JU0SS7x5UFWj0b4dlRlIl4zo4RUons1KbXoSqYMX1sqD5GaGn6/L5pxz99?=
 =?iso-8859-1?Q?55fuh16Hk4J6bJxUoY4JRwDSUY7TOQ3UleVorIjc3/rZqsEzOIYFngZLw4?=
 =?iso-8859-1?Q?vPI82hsioRiSwNLgbuMfXzyh7vIABFIpUcwuLirYhxWvvJAvD8RBRyhy5N?=
 =?iso-8859-1?Q?qPmprtwFx2ww35aIlYLQEOqwa3MN3Bzi4EVwoalqcOKcY0mwxgJJJRd+VY?=
 =?iso-8859-1?Q?G2OPafZNZucpotHlk6f9Tk7L2RmGtiNk9iJI9TDPvJFVICBEoIvEvF6UXe?=
 =?iso-8859-1?Q?BYrCCGzx7Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eBEAOBg18wZ2SvxWEtfE1pYz8JZKQe37tXp9vTwMAijaugeeSeozEFMjJQgjqMKoTRQA4UirISZgtSNbqdbSGsVwJJ36HXwLAh+1dd9LGiDoJAYNGaL64SN3PROlbHKGwdUksz0PlGG2MFeYbDhCPChd5vJnbjcQcK9iuB/VDkdfSk4ux9hOdLVt1KzGl//SbsEvCCUQbCrg4cvt/e2lSyp/oHvU2KXFbo1OxPltd20IN9uJXguvS3yETdn79anXrP80V6KCzF9w//bf6Xheldjl/vTYblLep+01upKVtr9eA/dI90+t5n/5GClmYr/1xSNYoTt4gRaR1dO8nvwDbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed1d05c-54d8-457c-aa65-08de9a1a192a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:36:41.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKpjf/Aiv2SXZH7x5K4uNVX4GQK3K5xajYVHfkCbTcki3L3b08vuFtnKmLNmfO3ADQ7mmp5OfML7MDzYeK1cKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237824-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,google.com,vger.kernel.org,intel.com,lists.osuosl.org,redhat.com,lunn.ch,davemloft.net,fomichev.me,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A25333F9762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Saturday, March 21, 2026 10:18 AM
> To: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Cc: daniel@iogearbox.net; ast@kernel.org; willemb@google.com;
> stable@vger.kernel.org; decot@google.com; bpf@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; netdev@vger.kernel.org; pabeni@redhat.com;
> andrew+netdev@lunn.ch; kuba@kernel.org; davem@davemloft.net;
> sdf@fomichev.me; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> john.fastabend@gmail.com; hawk@kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix xdp crash in =
soft
> reset error path
>=20
> On Fri, Mar 20, 2026 at 02:35:42PM -0700, Tantilov, Emil S wrote:
> >
> >
> > On 3/20/2026 10:48 AM, Simon Horman wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > >
> > > For local reproduction steps see
> > > https://netdev-ai.bots.linux.dev/ai-local.html
> > > ---
> > > idpf: fix xdp crash in soft reset error path
> > >
> > > This commit fixes a NULL pointer dereference that occurs when
> > > idpf_vport_open() fails during soft reset. The fix restores
> > > vport->xdp_prog in the error path and updates the restart check in
> > > idpf_xsk_pool_setup() to use IDPF_VPORT_UP instead of netif_running()=
.
> > >
> > > > Fixes: 3d57b2c00f09 ("idpf: add XSk pool initialization")
> > >
> > > The Fixes: tag may not be targeting the correct commit. The primary
> > > bug being fixed is the NULL pointer dereference crash in
> > > idpf_xdp_setup_prog() that occurs when soft reset fails and vport-
> >xdp_prog is not restored.
> >
> > This is not exactly true, this is just one of the instances that would
> > cause idpf_qp_switch() to be called. [1]
> >
> > >
> > > Looking at the git history, this missing restoration was introduced
> > > in commit 705457e7211f ("idpf: implement XDP_SETUP_PROG in
> ndo_bpf
> > > for splitq"), where idpf_xdp_setup_prog() was first implemented.
> > > While commit
> > > 3d57b2c00f09 introduced the secondary issue with the netif_running()
> > > check, the main crash fix addresses code from commit 705457e7211f.
> > >
> > > Should the Fixes: tag point to commit 705457e7211f instead?
> >
> > The reason I chose commit 3d57b2c00f09 is because it is the commit
> > introducing the function where the crash is occurring:
> > [ 3179.284770] RIP: 0010:idpf_find_rxq_vec+0x17/0x30 [idpf] ...
> > [ 3179.291937] Call Trace:
> > [ 3179.292392]  <TASK>
> > [ 3179.292843]  idpf_qp_switch+0x25/0x820 [idpf]
> >
> > The setting of the restart variable is where the above commits "meet",
> > in that both conditions - netif_ruinning() and idpf_xdp_enabled() [1]
> > can be wrong:
> > https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/tr
> > ee/drivers/net/ethernet/intel/idpf/xsk.c#n571
> >
> > which would end up calling idpf_qp_switch() instead of taking the
> > alternate path:
> > 	restart =3D idpf_xdp_enabled(vport) && netif_running(vport->netdev);
> > 	if (!restart)
> > 		goto pool;
> >
> > Which was introduced by 3d57b2c00f09.
>=20
> Thanks for the clarification.
> I agree that using 3d57b2c00f09 makes sense.
>=20
> ...

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


