Return-Path: <stable+bounces-240384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKKLM0Uh6Wn2UgIAu9opvQ
	(envelope-from <stable+bounces-240384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:28:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308744A25B
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCFD30B9C7A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47F53F1667;
	Wed, 22 Apr 2026 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShIMo+0r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE743F0AA6;
	Wed, 22 Apr 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886021; cv=fail; b=UuIRgMttLNVnmtapTeHMAH+ROp0pO74hTmgC9JP+W3GvcH91Pnaa11WQj1xq5n1DNaUY7WYQ5ZotTdEuL9HjMKuXmvewclOvI3ByM+3m2MuOFenWGLB/Nij7hWCuJnMaW3gEFj1ZSe8PajAuPRfNPRRMcw7EesnUmkc0e1QGxE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886021; c=relaxed/simple;
	bh=WA0z9sWXEvMjX6BV44ffHmrf1yvTVZDwJCiYPnrb0YM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rfwOIVt4iRiqHayVswckGCZXjQmfCiXWKo0uUUU73Wphi1vWM9oUCwq6vvx/xtaZFEek2Cv0FlvMer7nyThUMyzhUBAcVptHUqV/WJNAY1RRioEEQC54b4ybPhVXBCXzytFeO8ZJJ1uDEciikbQtqcLlLTGGCQ0sT9F19Hi4UmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShIMo+0r; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776886018; x=1808422018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WA0z9sWXEvMjX6BV44ffHmrf1yvTVZDwJCiYPnrb0YM=;
  b=ShIMo+0r/12WBR6YIT2JNJBGfXcXxPN3toDR90pvhOWLquLc6OlVRShA
   IZN5DkeYXi5tsTuvn5ykSQkegHSv4f7jpmk7++VvoRDhamA/zfnnNjHhn
   /L94iYiLVDt5wtJNhwZUBRcpqHjEUWOtL7/HO2oVhjXiw9COy87jvuvYL
   9ot1hF/NKMJjpjRCR/gNqkpTcfAhHvUsUB9RI608OLJ+4zXyJB6ohWL2u
   gVUAHCI3XQgOOhUB+MuKhJZPmgaKzZKqXdS87yCwBzRdfsHHuyH5TbpbX
   lq3Ua8ZC2vci/l8rMGTBrRbYy3b1+W1lHMgK/XMvoqdIoatwZfGiPh51N
   g==;
X-CSE-ConnectionGUID: YEW5zUHyTsqWzI5WQnvUtQ==
X-CSE-MsgGUID: khGb0vA8RrOoK64+aA51HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76881166"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="76881166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:26:55 -0700
X-CSE-ConnectionGUID: H9XDGTHaR3q3fxGgDL+Ymw==
X-CSE-MsgGUID: aCCnzxqGTCaidkhgAwpjZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="229774701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:26:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:26:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 12:26:54 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9kIMNZBOCpXQABhIXOX+8790lAWC9m7IY4+LKJ8dgzZlk1VugiMKEtLlwIK0/KXLzH9LfgotxXYSVc/OLTmpSsaenQSlm02/VcnNsQoz0NzgQEL+tLAnfQkvAqb52O9hU0/4mBvppjM+uH0HRiXZP/G15fBQkraigW1ekkgJt3Y2uZJfO+qK6cX7zGShLaptlAdynwSNNVRIW8GgqkMGjOAtqA+wWJN5Ym4l3zsKNmwqwx/Ju/tt0Mcsad7SEEJ7yM3jV1gjH5wxV4As2idCrvn+Vg0E1pZZzyqQdjTHlmk7gbo+pO1YJdnjfyjkMdeA0mIdTvx4VCO9WzjIlFSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UPbNIE11AOxxdJI4VCMkmWP5dFIq5WEmGZhBHQsVRo=;
 b=VsAPjImE9sLC/RMhByRrNSGnBgjScig4sJZUGA9sKyVEXp3ekR4Bw7uyvhz/LYAV2U2titP+cdyCWuHAWsoZa/F4PtJwt91Ky4jphKnH0Y/k6yO3Y9a0fac5E0gc8arWAMdAy+VPSogTvg0WMIz87NnBrYaMgiGSbdzW2MCtJ5hQNKFUeNF0AZghgoijH1AOJ3aYa3HSFxz60FZ7BCWWVqHBlC0pT+0xmA3quA/F4sQCWXPLmMy5fLLc7aBQCy9yA7oDWtPyCb4RQFZNt6DrMHBSSA5/p6RrtIH8BgDfYc6JK871OJOEZxm3DZ+mGkWRQ2TRN6UBGX1Q28taSizcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7388.namprd11.prod.outlook.com (2603:10b6:208:420::8)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 19:26:51 +0000
Received: from IA1PR11MB7388.namprd11.prod.outlook.com
 ([fe80::1be2:c2f0:4a54:7e21]) by IA1PR11MB7388.namprd11.prod.outlook.com
 ([fe80::1be2:c2f0:4a54:7e21%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 19:26:51 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Holda, Patryk" <patryk.holda@intel.com>
Subject: RE: [PATCH net v2 11/12] idpf: fix xdp crash in soft reset error path
Thread-Topic: [PATCH net v2 11/12] idpf: fix xdp crash in soft reset error
 path
Thread-Index: AQHczgVWGfmA9cN1f0+EFRgAa8JAN7XlLykAgAZIYQA=
Date: Wed, 22 Apr 2026 19:26:46 +0000
Deferred-Delivery: Wed, 22 Apr 2026 19:22:51 +0000
Message-ID: <IA1PR11MB73888DF3070B8B3D63D057E7D42D2@IA1PR11MB7388.namprd11.prod.outlook.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-11-686c33c9828d@intel.com>
 <20260418190019.194263-2-kuba@kernel.org>
In-Reply-To: <20260418190019.194263-2-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7388:EE_|PH7PR11MB5768:EE_
x-ms-office365-filtering-correlation-id: b3d94551-c2c7-4133-b71d-08dea0a51add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: IzeuSwaOM0FAXP4Af5spOP3U26QwqSboxTlc5JxpjOlIYeTKve/DmJIuYBuDiyDbG3z4zIG4s/HL8r1uYMS1U8Euo2cmV/l7eB2jVFdw+rx0lCagDbjr305rpRsyLL7usKF8RkYnABDO+0c9OJVHUdjDOSCjMQNDhfkdGKsU1ZmJAwFJPq9Eq1kh7wVZzMl3tEgeUNMIfKzmfq9tOM8MFhgqJmMNUrbv8KZ91Tmn2H2aUjGyh1Cs0Q7nb8odpRT4A3W7wgPLkzXIXA3xPpGL2PSqPbyKjpa76I5v2UDlOzfv1qRt6RhDN6ksKHGkqWDUj3y/SO8+AOIyDqkw7iXdVN9AYgaRfklLtYq7WgDvcd12iYpM12OTj5b/sraDM1Rt+ms/GVbaPLE6dlrhU/aCJRU+/xswhmkFX6e1mDKr2feuZFGbaxNmFQkgRpoX5iim2/3exuj0fAzaOi79FPrX4N167RNH4E0vRumbGuWc+o7pFE9lcBqfUc1/gsSfc95yuZwmQ3oGWCOGCqxvwCmugAQjkLHOT+uWbN7507SVRXkTwLwbJzlRZgxk8uQo7UxDkCJcf6a82UzjhhrImQPZ06jCcrJ9jxiq+GHopEeaa8JECoxOLYqOom/k8aZX+bnzR1DBP20su+6YqiH7sHujN8H0PxQda67eAEWj92+HZf1J2jGYtA5Y7GpcnqXuFDb04U8nNTFUhHPPWA7XsjwVYwUfvcl2Kb/S3YCrMho6+3rbGY+6lkSGMRCD/TK02I94tgGy0a30tvCuXzp9qB3XLRkpqsQ6EcEDHiTtpRa7CGQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7388.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?23ygfE7PRHFoMngZLbUnMFGw/cN2enW4CdVhXc5BjS/Bi40ozm+pRHRO5Fid?=
 =?us-ascii?Q?C/q7EMb3/NaXUDwtBrIh7neKrZJYh9pD1L451EAgXzMFo8oJVHPYgM3kkclI?=
 =?us-ascii?Q?JtFVfnjmuZpiNxtraMAo1T7ZaGBCBa6nLVodBnLRvpOyE6cSE/FLpXLyrOeh?=
 =?us-ascii?Q?yVbIqbpf9sckfkpFgKbTBm1RmvFwyGfrKhFEwn8DoCPnOlM39NcgYxoortSd?=
 =?us-ascii?Q?O2EKVhdNjztvGi1dzn30YmGyfdpm/dKquEQuzDYD9qEvPKJLvTyDsscGyvjA?=
 =?us-ascii?Q?UusESc0L7ul4y+pAL3yYYcJ40Tw4xaOq9GxMJ+v7PqQ8SQAtc2e0ejnJeHTS?=
 =?us-ascii?Q?mhPCyCKyGo8/mHoV5qLZC2dy+qggks4KqFKyAq1lGEYzZHNIeL+lw+Wp9olW?=
 =?us-ascii?Q?izG3q0YS0VX3SWGkQUXQDLa5TLZY+C0j3y6LlHlPwithF0c9PpAtmUtION54?=
 =?us-ascii?Q?JwWMPH6vgr4V/Gysc4WxFp7oEywiKzU85f1K3xGeMOa+SvbuvZiMptpf1uPd?=
 =?us-ascii?Q?R5XWGrHTLdmNnBmcxrdMXP/yXAbisVhFx1eVZyLDLhkvogzY1ut7b4weNQxX?=
 =?us-ascii?Q?6rxivumgcY7N+cDPqGnLhE3haABixKdGOei1nT8IAWVlOrf1CKogARaK9T2C?=
 =?us-ascii?Q?CIDhMfNuhMxxq0eX+SFqDEFnXG4GMo1GqLCGSPtuGbpcefNj6KTPH3eb4HfQ?=
 =?us-ascii?Q?ueRRYGXXBgfk/4hLRa1q96kIA1+XROm69kHz9G4mqiO+6nqy3dtOBVCwKyV0?=
 =?us-ascii?Q?cMh2cS94v1v/XnQ+X5N+X3m48S+UCSprnYvT8M5iXzHtSpb0pTrRiwd+oU3S?=
 =?us-ascii?Q?P75JDe+Kd9EljeiSWq+A74dNAx4EyNG9l076oNhI2v0XgvuiDybyS0V6k696?=
 =?us-ascii?Q?t3xg+UaCN2tK5KBfyuHQdWovRWNYGmRuZd5zRRfXkFRicrE9Ck6RJuvoi3uM?=
 =?us-ascii?Q?umX6Ki+Wed6eG36ffNTo28MLVTbpuG05qgdw11xhzsX85O+so1UcefhdIjCU?=
 =?us-ascii?Q?FOymfAgx7Wh9DBgGv472yUahhUm2DhKX4tglwmk2LQCi2Q+7L9rf5Uk1xWbI?=
 =?us-ascii?Q?8OlJfOjtK3ieZ3K3kLW+UsPB31yUrRZ31lQ8wv2ylEzXdPHE56bZBKaWFLlO?=
 =?us-ascii?Q?jF3SmgwGNFEBaUmXn3qs8pYwX8p6KCGo+J+20IU7j71Au3n68q1akrDgnr52?=
 =?us-ascii?Q?L7l3SiEyp2vjQTZRMXS5cn9/uSx6TESTV8X2dep3Ys2E8dKpNOKZm6rgr2+P?=
 =?us-ascii?Q?7JzSa1fXPljlFyjn6BidFz+rrSfD5v6PJgtolpXl/Gx8V45wGKVCttzmE8D7?=
 =?us-ascii?Q?8OrtED10/v1BsV/uX9kd0Lny1JpVs+xaluUd/0CC5/itoeOoLGQG3JeauRQj?=
 =?us-ascii?Q?e4GzEx2wZcalUuIZ0RuadkT8Pz+qFNxg66MqonRpx4So9YlMsY2Dq2J9AsT9?=
 =?us-ascii?Q?SY+VxWh0RbBqxd6Bg/uOLtyN/ZDch1Axl21ZQ+vhSizQGrR2eUq2+gbzLwB+?=
 =?us-ascii?Q?7GRHPOwTX4FWvu7HI1DDUwz86G79UjLfZcYhLweYCds+pBP3hDU3qPNBntph?=
 =?us-ascii?Q?pwxwR1d7kAYQnITpv9YuecjiT5g5R+LTVeYx1cIvDzWxIeN5zRNtDUGRRQFW?=
 =?us-ascii?Q?yWHED/hqux+b8hENtUs4JRay8V4XbNMzhHf0Wgc+1Kyi/vRc0DTiLwXDwwEj?=
 =?us-ascii?Q?Agbr4ScF1jh6bcaSrN/MFdxQEdEQJUuLrGnqBqh4rmUaPY+bkESsEh6gpdms?=
 =?us-ascii?Q?loTimPnlTQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ba9O+vk1i7YS/NKf+0XsfFVknC3EPY2wSKGPV41iN0cykaigRqh5/uE0ZPMqxp4RjqzjRx0httto1lpprMg2nqXNHI+XNPjIHvUNnGRqw4GUOyDIEgq/LZrHOHxDrMPb44mUYaej55xsFxHIL1HYkyiLKJUU9JShpcWUC0uvpJs+D5QhB12X2yAIB6CbsdCp8ZqMPd6tTvn854FVAvR0yUSgZ/XHVrIjmrsrPTWxc22IELrrU3oRvjpZQZ41LHrfigX3GthtpLtm/URCIOJ+WNPADjILSJux/U2ykdl2NLvyEElobC7q3eldR6hh+J0KWmBLeAn94PQw+IyyDi48/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d94551-c2c7-4133-b71d-08dea0a51add
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 19:26:51.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8iNORLJfOMAhGpKTCPqDsdYEq5+yySFXk7GSjsDA/9wHsY/C4EWdN1NzKFr0DMy/e9UMAjdeylNR6fMgy4g/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240384-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,IA1PR11MB7388.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8308744A25B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> Jakub: I'll drop this patch and apply the rest.
> ---
> idpf: fix xdp crash in soft reset error path
>=20
> This commit fixes a NULL pointer dereference in idpf_vport_open() when
> soft reset fails by restoring vport->xdp_prog to the old value. It also
> updates the restart check to use IDPF_VPORT_UP instead of netif_running()=
.
>=20
> Cc: stable@vger.kernel.org
>=20
> > diff --git a/drivers/net/ethernet/intel/idpf/xdp.c
> b/drivers/net/ethernet/intel/idpf/xdp.c
> > --- a/drivers/net/ethernet/intel/idpf/xdp.c
> > +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> > @@ -488,6 +488,7 @@ static int idpf_xdp_setup_prog(struct idpf_vport
> *vport,
> >  				   "Could not reopen the vport after XDP
> setup");
> >
> >  		cfg->user_config.xdp_prog =3D old;
> > +		vport->xdp_prog =3D old;
>=20
> Does this also need to roll back vport->num_xdp_txq?
>=20
> Because idpf_initiate_soft_reset() overwrites the vport struct with the n=
ew
> queue configuration before failing, vport->num_xdp_txq might remain > 0
> while vport->xdp_prog is restored to NULL.
>=20
> When the interface is brought up, idpf_xdpsqs_get() evaluates
> idpf_xdp_enabled(vport) as false and returns early without allocating the
> NAPI timers (xdpsq->timer).
>=20
> Could another interface redirect XDP frames via ndo_xdp_xmit, bypassing t=
he
> check because vport->num_xdp_txq > 0, and cause a NULL pointer
> dereference
> in libeth_xdpsq_queue_timer() during idpf_xdp_tx_finalize()?

Yes, that is possible. num_xdp_txq needs to be rolled back as well.
Will send a V3 to IWL.

>=20
> >  		old =3D prog;
> >  	}
>=20
> Is this old =3D prog assignment leading to a double-put of the BPF progra=
m?
>=20
> If idpf_initiate_soft_reset() fails, this error path drops a reference to
> the newly provided prog when it calls bpf_prog_put(old) right after this
> block.
>=20
> Since the function returns an error code to the core network stack, won't
> dev_xdp_install() in net/core/dev.c also explicitly call bpf_prog_put(pro=
g)
> assuming ownership of the error cleanup?
>=20
> Could this underflow the reference count and cause a use-after-free?

Will fix in V3.

>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/intel/idpf/xsk.c
> b/drivers/net/ethernet/intel/idpf/xsk.c
> > --- a/drivers/net/ethernet/intel/idpf/xsk.c
> > +++ b/drivers/net/ethernet/intel/idpf/xsk.c
> > @@ -568,7 +569,8 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport,
> struct netdev_bpf *bpf)
> >  		return -EINVAL;
> >  	}
> >
> > -	restart =3D idpf_xdp_enabled(vport) && netif_running(vport->netdev);
> > +	restart =3D idpf_xdp_enabled(vport) &&
> > +		  test_bit(IDPF_VPORT_UP, np->state);
> >  	if (!restart)
> >  		goto pool;
>=20
> Does this function leave the queue pair permanently disabled if the pool
> setup fails?
>=20
> If restart is true, the queue pair is disabled via:
>     idpf_qp_switch(vport, qid, false);
>=20
> If the subsequent call to libeth_xsk_setup_pool() fails, the function
> returns early:
>=20
>     ret =3D libeth_xsk_setup_pool(vport->netdev, qid, pool);
>     if (ret) {
>         ...
>         return ret;
>     }
>=20
> Does this early return bypass the idpf_qp_switch(vport, qid, true) call
> expected later, causing a permanent partial loss of connectivity until th=
e
> interface is manually restarted?

This seems valid but not necessarily related to the soft reset issue.=20
Will fix in a separate patch.

Thanks!
Josh


