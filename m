Return-Path: <stable+bounces-225343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL+WNgw4tGnTiwAAu9opvQ
	(envelope-from <stable+bounces-225343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:15:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F3286CB7
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6514307E58F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E634D4CB;
	Fri, 13 Mar 2026 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgFkQGEE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3934E75A
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418327; cv=fail; b=cxNkBmXVdPKc2/z6VYZWNbxEmcD2ORWvg26jMHtSPPILfzd5b7TfYwgxqlE0JBpc6xubaN7/EL3jkahyyJ3FgR44zU8+vuMMtE4Pm0VAKd+wep26vvHyi0KRuEeuFZIyAVHdt5DYVJvfS+kIlITd1njWae7VAHsc+prYaBI9X8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418327; c=relaxed/simple;
	bh=D+MabwuA+c+jYtObjPO3fs66j4L2HLwch7NWkEICmpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1jDQpLIKxEHYELg8pLdk7hNeaJHxUORVPDTMbdcdsypObOrqjqc4s/YNzOkMI3k4Yoobyyq+x3KxlzDOuX7QOOhlTUQFS3nvH+Dykyq+mYiUxFTBbriWXvEOpww5osAM3F5pPkQkW+99LJGOgoGFC2ws0RRb+Gqzy0eUAFJp9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgFkQGEE; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773418326; x=1804954326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D+MabwuA+c+jYtObjPO3fs66j4L2HLwch7NWkEICmpo=;
  b=cgFkQGEER6Tzaam1W4PTAVmZw4TRIenz1FxNfbDzXgSU6pZ7Jsp98pfD
   fvtXpom1HUBK7Oyy1UTbGKThuxmNibDAjuFHCFnLOVxOVNsyTw/KcoIHN
   h5S/0vspeFPp4DwsDS2eaLaiDtPBojWos0O3NhtB67jIJIwVtQlpRpI/G
   VVrxh9mbLbgjXU81kIW8zZq9s4pQbB6H3zU0QpmcnZFwoxGHBApR0ESw7
   bNyyAxh542ydyfMJKGqhRR/bOa0kYxEvsyQgMeWYq3epTlIwcuGfgH78K
   OoFmq7/SjVK9xDbfGM7pHV72B93cL7X5ov/RilfzldXdH4bnLFlsGM/v3
   w==;
X-CSE-ConnectionGUID: 56gxaWEbQ92ax0C3BbjPDQ==
X-CSE-MsgGUID: t/vkrW92R5mtGS28BGrgMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="78378733"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="78378733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 09:12:06 -0700
X-CSE-ConnectionGUID: FpsBpV11SH2JsOzocgTJ7w==
X-CSE-MsgGUID: YPMOvtEIQPGIAC9GflOVmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="221423503"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 09:12:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 09:12:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 09:12:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 09:12:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvkhzraNYWjcp517BX2DWh8EWJnqdtgAQiL0IOzxEqY9sysDZohrExN5NCi9I1i/imSSmX83QSZDCfwXVdC6gFcKdpRQnXxKNauqOmIhI8GkhMDJRisQQ+NR7wi6ysSSgnHaXdEO6qaK+H71G8ucB/GqDYBfilKiFFVG60u0B9SPaSkxg9/P930i6Uxx/9ctA0ZGsWCFt7cNpnAkFbl9/BVOXyrX3OmHgNkrhgaceWqSI9Ukt3+Og80yI5EGewZqpMfa6Soianowlm4WW6T+JylqjJ+uIyYms06zzYpOwsSD+KWzuYMmUlmbwR/r3SPb0gEIFxdAPsxA6zNO3+UEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+MabwuA+c+jYtObjPO3fs66j4L2HLwch7NWkEICmpo=;
 b=IVctnWXUNrLuenWAqXyUuEMsI3aDeshMMBqo4pedbKHjpUc4Vp8VIv5B4NmDxPExfBAEyfQ6yRBheubMJKFPndP2VnvS7jYvXww5Os++48CCX2pDmzOyhQ9XyrhY1GKxW+3usP6DO1OlghYKmg7/hJ4t9xIUTeGqK86lWy0/UTmj626xyRmJTD/r3BYhtre4ZFsBuQGPBs/OmVmYh3dPhlojC/4Klg76PTiVasOFhXV8npbTPkL+4vBi5kuECE8pnXvOjgremKhpYvB8LxL/yxAqtMML+nao2Be3aZsHHpB2M0pz4hltMJFepZ0TEz3H3DmRaH60DXkK5PMmiWYhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 16:11:55 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 16:11:55 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"Brost, Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH v2] drm/xe: Fix missing runtime PM reference in
 ccs_mode_store
Thread-Topic: [PATCH v2] drm/xe: Fix missing runtime PM reference in
 ccs_mode_store
Thread-Index: AQHcsrmGIYSZzAeT2kCuKruQ240THbWsoLMg
Date: Fri, 13 Mar 2026 16:11:54 +0000
Message-ID: <DM4PR11MB5456FE61A7572FFC865BA68CEA45A@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260313071608.3459480-2-sanjay.kumar.yadav@intel.com>
In-Reply-To: <20260313071608.3459480-2-sanjay.kumar.yadav@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: 367a1d26-18fa-4bad-be4f-08de811b3ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: osDEYW2tfB8URSmkb04oCDUxtPQaOikkE9FOmG0V3B5rimXnsn+/fNqv1Q9FQ4TQoVlREMx9DraN5Og3PYGsZL8P1zCKKpFx5GiB+xLuWf61FrqXdEhFjcH61Tz4ktHttVhgueVVIb+E2nzxex4E0hW0b9kAM+clOwfsbZgDKttkRlA3e4DKsb5vdWfqinsBC82IjOkrZ85tLUPV0TDDLHqvd0FSiWc6TB7KPTLeAQJqpZ8VvTLI2GV/l5VQCQWDmPvhIJoBZ890d2pis4ayKE56+iZNlPdGHSAlGXDDM81pUtjGqUHhZV3FRI5wrmXpC6q0s+XvG1gZeuoW04oyKWJJ1QlMP1/nw4pUCWoDin5PwV7FYt8b1ZFY3BCG3yu8eEn+VcxxMKhRDqSzC/8ps1+dJYxfCuDTYHOeBmWswIVKfHev8UKhuKvGcgMW4eMpN6TIR35OzSJcuYRXwcnrpTmay1aU5tjXbMIE+jTGMU2D6tPdID9VNL7/puH8a4NxecRQEHg4qR7Lza2hGEn6naCuR5YrBp3Ji3Ph0RHX/6I7spvKPYEuXkxyHK8KV0uJmK1XomuQVclo9lver7xpHwBgC6zkiLNpvbig/uknDVlfF3hhJEoKXbhPCUyL71xAldCtDNPF/btFbhdZbp8jk2psWI29zwk8lkr0lN8oC60azq3gkzuzx66fG/zmEgBeDqXI3oBQJS99Be0+C+aciu1oNYKKNM4t1k/ZsQQRG1yW8y11TqcIUOPbhq5xDJCB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW94aHNmazcrMmlzS0RRQ0NMUG01TldqUnVhT1dHZVhYQy9GVnNqcHZpWmsx?=
 =?utf-8?B?SmsxMG0vcmtWYWxLVkEwMWcvRDFyVEd3ZDdXNkVyWEQxdmFHeHNVdE5aQklO?=
 =?utf-8?B?bXVQNFBzTVo0YjNKOFhiRHlqMFVnbTFoTXROR05qNUU5bHM0dkMzbWNYT0J5?=
 =?utf-8?B?b2E1UmVUdndkT1p4c3FCNFRtVVZ4V0JBaSsyajlIbHc0RUVIRUtKcys0K2ZF?=
 =?utf-8?B?aGtOZVNoTU1QNWdUazAwN2ZUSlB2aGdHVEIrdnh3SFN2Sk9mTGxUZlltRnI1?=
 =?utf-8?B?STV5dzl2bXI5ZGE5ellsOTVHM01Yd0xCNGtKOVZCdS8xQ1g3RDNFV1FnYWVq?=
 =?utf-8?B?Qll6Z1gyWE9aUURnelB1aVVhc1BzVGJ0NGtFMTNIb1JOVnNTV09LS1dTVE5i?=
 =?utf-8?B?MzljWlkrNjU5WitlQzNwTkZEOVpNbUlKbU93TDBFTXBncFB1bWdRL1VVZ2x0?=
 =?utf-8?B?Z1VkT2lRNGczUVBWakNldURKaGNqVzhoRHFXcmVEdFFDT1ZxbXlUTHpQN3k4?=
 =?utf-8?B?Y3h1N2pCck8zNUFyMzloRjZhR3ZkN1o2bHQ4SFJSajJLMUxDNFJkWGJlUGpQ?=
 =?utf-8?B?RCtDVTdaMkFvU05jYzQrbkMwa1JlT2FGOS9ENDJHS1VGSXo0SGM4SlBFSWtM?=
 =?utf-8?B?aCsxM3h0YlNQSVQ4eVB4T0FTTmNoK0N2aFQ3a014WmVZcnJUOHhqMStreTFl?=
 =?utf-8?B?T2s0NXpWNENqRG50SkJlVUJNOEMzcVgwQlplVkt4M0FBbU1NZ256d0JVSWpW?=
 =?utf-8?B?REFwWFBlTXpQRWZCRUZTS3dub2I4RUxaYmg2MFdwUUxNWnRvTVFPMmlDNGp2?=
 =?utf-8?B?VHhwSVBuSWJuYmRXMHFCMFhhOVprV00yQmROcjIzSlgzTXlWbWFYWUo0Nm9W?=
 =?utf-8?B?Wlp4UnhDUW1rdmttWnkyOGQ1WjBJZlJsdU9YNW12K0FHK0pJeXd4aGVpZ1la?=
 =?utf-8?B?MzZienUrd1FZd1ViNHc1b0U2aHpvc2xjNUdRNWRyZktNVitsYlpXRTdTTC81?=
 =?utf-8?B?QVY2S0lwOUZpTisyNXZyL3JEWGp4Ni93ODl6czN5U1dMMFFBZ0lRZVJ4QUxZ?=
 =?utf-8?B?eEZhTDRIdWVNaFhKOTZkL3BzN2RQeHlJbXd6c2g2U2plS1NUcGtjdE1ON2Ft?=
 =?utf-8?B?YkZWY1MybjFPN2pIM0VoYmVzM3R1bUIzbEZXVm05UE5xVnRHenVHcTl4dFVG?=
 =?utf-8?B?WDlzZXBYeWl4Q2IvcFN1bDdOWnQybUpmbWdNR2poVUhIZWdsVjlvKzJzNFRV?=
 =?utf-8?B?dGdObHdiV2kvUlNhaDhuclhpMXIyUGNoN0R6Q25wTk1FTnFpM2NpZUxXaEhR?=
 =?utf-8?B?NGFHUXhnbFV5YkxkQVAwdEFWS3dRT0l5eWFKK3p4OU1uMUFxTlptMzRUOGV5?=
 =?utf-8?B?c0U0YzlkOWxRNXlKdCtVU2FzYmRLOFQvU1kyZmtVcmdldkdTOWJZUzAvMDZm?=
 =?utf-8?B?UUdHVzhYdFN4dWJvcjZHTFE0Tmh3THVGMzJLclluSHlRNC9HQnF5T3NiNGQ4?=
 =?utf-8?B?c2JuMWVMb29FUXU5UGJSUE9JTVVHUmJXZEVxVlYyUG12OE9FTnNxeS9uZFpr?=
 =?utf-8?B?NlNGazI5VkMvTWxYNlEySjIxd0VOUG9ibGlTZ2I1ODd6Y3l6ZzNEaVpQUmpm?=
 =?utf-8?B?R2xqKzEybnhDRTR4aDRDaWIwUkRWMU1XVGplSUcvTmgySFd4U2svYVFXTHV1?=
 =?utf-8?B?Nkc3UEp2RzdOOTNrdWNzQ3E1MEphRmJOcEQrWG5KajVnNWdkSnVVdzAxSm1w?=
 =?utf-8?B?UUJLZ1YxTFlYN2ppVkRQendwR0s2VlB3YU04czNuaFhTZGVyRlQrbmlDVXRp?=
 =?utf-8?B?aGljMDBwM2QwV1IwbVptMjBOYTRLOXpnUzh1c0N2WnNtWkNTbWU2dk9wclRI?=
 =?utf-8?B?cnorRDBZa2wzRVlmV2hSZitHOEtoSmNGYjJYdFBLdU1PZTQxbXZPdXNOcVlj?=
 =?utf-8?B?VWY1Y1c3eHZNT2ZNSlQ5TEdqQUhhNjFTMWFIZjV5YnZtVFVuN1RVZ1FCZ0xr?=
 =?utf-8?B?NWdFZmVjbXhWUVFRSjlMcWpCejlUcVZ4Q2RtdEVkY3RMUlFqM2ptTk5rTCtk?=
 =?utf-8?B?T3pRYU5BRCtTdlZVTnM1VFJRMEl6SitVOVQvalZPQTVJMVlCUk85YXlORGlU?=
 =?utf-8?B?M3FWK3Voc0gxVE1CMGhSWXViNHdyS3ZmNStkdUlUdEFuWlIyUnhISkdGclp2?=
 =?utf-8?B?MEhNdm1VSzZaTFp5MjkrcEorS1B4MURMTGEzMzVtU1V3NVZ4VnI5dHhCSDY1?=
 =?utf-8?B?S201aDV5aWZHajVuM3B5b3dUNDFYRTRKTVMwaGhMSjI4bXhtMUIvYXdpaThv?=
 =?utf-8?B?cjBvS3RucjZCQ1llVTdmNGhzMDBpa0dKVS9aazcxcXZ4Y3dtSkdud2RDNEJy?=
 =?utf-8?Q?lqmuJ42MwT7d1b+lyJftF8Xk4CPcMauaDv6yaVFJh414Z?=
x-ms-exchange-antispam-messagedata-1: JPKGqne8ffGG/A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TIMku2R8XhNY3/3Yd7BA3E784uwg9bELeM35i5Z40WNFist4HvaR3kSgxlmGRB2cqv2X1/DvAn9BoVzMc/Nb1RuMxuf4H9Q0Zwr+w7VSdqFKg93lWLYDW9DqnTqcirp45SybriQoCI0xFE2JYKrxpAnvXEsTHFGgxhSpE5W0FUPY7aLYu4d9vwRMWuQRe5RqYJxyvBaQq9DVCn93ROf5LtA2cKz8JiSsGUA2/UiE5S21rR1QvEel6gmkBjeLQnuR5Y6saJynNUX6Cp8Y1Wub1K8wFQ63UFXZPMCJfXTaW/l0Yh1yk74yGEDkgGvtT6eOYWpQnl8ouy13mNbhLStSzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367a1d26-18fa-4bad-be4f-08de811b3ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 16:11:54.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBFepzol7zWTeeZ52Znt1JnyiPoes6anJ4EG9X01f3FSBjwfRKEVqrA6I33Qp+lQhSNHWjKeOqxOZiIxrSCU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225343-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3F8F3286CB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCBNYXIgMTMsIDIwMjYgMTI6MTYgQU0gU2FuamF5IEt1bWFyIFlhZGF2IHdyb3RlOg0K
PiBjY3NfbW9kZV9zdG9yZSgpIGNhbGxzIHhlX2d0X3Jlc2V0KCkgd2hpY2ggaW50ZXJuYWxseSBp
bnZva2VzDQo+IHhlX3BtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKCkuIFRoYXQgZnVuY3Rpb24gcmVx
dWlyZXMgdGhlIGNhbGxlciB0byBhbHJlYWR5DQo+IGhvbGQgYW4gb3V0ZXIgcnVudGltZSBQTSBy
ZWZlcmVuY2UgYW5kIHdhcm5zIGlmIG5vbmUgaXMgaGVsZDoNCj4gDQo+ICAgWzQ2Ljg5MTE3N10g
eGUgMDAwMDowMzowMC4wOiBbZHJtXSBNaXNzaW5nIG91dGVyIHJ1bnRpbWUgUE0gcHJvdGVjdGlv
bg0KPiAgIFs0Ni44OTExNzhdIFdBUk5JTkc6IGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9wbS5jOjg4
NSBhdA0KPiAgIHhlX3BtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKzB4OGIvMHhjMA0KPiANCj4gRml4
IHRoaXMgYnkgcHJvdGVjdGluZyB4ZV9ndF9yZXNldCgpIHdpdGggdGhlIHNjb3BlLWJhc2VkDQo+
IGd1YXJkKHhlX3BtX3J1bnRpbWUpKHhlKSwgd2hpY2ggaXMgdGhlIHByZWZlcnJlZCBmb3JtIHdo
ZW4gdGhlIHJlZmVyZW5jZQ0KPiBsaWZldGltZSBtYXRjaGVzIGEgc2luZ2xlIHNjb3BlLg0KPiAN
Cj4gdjI6DQo+IC0gVXNlIHNjb3BlLWJhc2VkIGd1YXJkKHhlX3BtX3J1bnRpbWUpKHhlKSAoU2h1
aWNoZW5nKQ0KPiAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZSBhY2NvcmRpbmdseQ0KPiANCj4gQ2xv
c2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL3hlL2tlcm5lbC8tL2lzc3Vl
cy83NTkzDQo+IEZpeGVzOiA0ODBiMzU4ZTdkOGUgKCJkcm0veGU6IERvIG5vdCB3YWtlIGRldmlj
ZSBkdXJpbmcgYSBHVCByZXNldCIpDQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2
Ni4xOSsNCj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0K
PiBDYzogUm9kcmlnbyBWaXZpIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPg0KPiBDYzogU2h1aWNo
ZW5nIExpbiA8c2h1aWNoZW5nLmxpbkBpbnRlbC5jb20+DQo+IFN1Z2dlc3RlZC1ieTogTWF0dGhl
dyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYW5qYXkg
WWFkYXYgPHNhbmpheS5rdW1hci55YWRhdkBpbnRlbC5jb20+DQoNCkxHVE0uDQpSZXZpZXdlZC1i
eTogU2h1aWNoZW5nIExpbiA8c2h1aWNoZW5nLmxpbkBpbnRlbC5jb20+IA0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d0X2Njc19tb2RlLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2d0X2Njc19tb2RlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3RfY2NzX21v
ZGUuYw0KPiBpbmRleCBiMzViZTM2YjBlYWEuLmJhZWUxZjRhNmIwMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d0X2Njc19tb2RlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX2d0X2Njc19tb2RlLmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICNpbmNsdWRl
ICJ4ZV9ndF9wcmludGsuaCINCj4gICNpbmNsdWRlICJ4ZV9ndF9zeXNmcy5oIg0KPiAgI2luY2x1
ZGUgInhlX21taW8uaCINCj4gKyNpbmNsdWRlICJ4ZV9wbS5oIg0KPiAgI2luY2x1ZGUgInhlX3Ny
aW92LmgiDQo+ICAjaW5jbHVkZSAieGVfc3Jpb3ZfcGYuaCINCj4gDQo+IEBAIC0xNjMsNiArMTY0
LDcgQEAgY2NzX21vZGVfc3RvcmUoc3RydWN0IGRldmljZSAqa2Rldiwgc3RydWN0DQo+IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICAJeGVfZ3RfaW5mbyhndCwgIlNldHRpbmcgY29tcHV0ZSBt
b2RlIHRvICVkXG4iLCBudW1fZW5naW5lcyk7DQo+ICAJZ3QtPmNjc19tb2RlID0gbnVtX2VuZ2lu
ZXM7DQo+ICAJeGVfZ3RfcmVjb3JkX3VzZXJfZW5naW5lcyhndCk7DQo+ICsJZ3VhcmQoeGVfcG1f
cnVudGltZSkoeGUpOw0KPiAgCXhlX2d0X3Jlc2V0KGd0KTsNCj4gDQo+ICAJLyogV2UgbWF5IGVu
ZCBQRiBsb2NrZG93biBvbmNlIENDUyBtb2RlIGlzIGRlZmF1bHQgYWdhaW4gKi8NCj4gLS0NCj4g
Mi41Mi4wDQoNCg==

