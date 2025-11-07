Return-Path: <stable+bounces-192701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B00C3F47C
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3DFA34D677
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7D2F6585;
	Fri,  7 Nov 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO0dwnTx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615B2D9EED;
	Fri,  7 Nov 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509398; cv=fail; b=SqDjL91fckbExws5+SqD5ECIamEM8nmVRlbU+cpbe7zXw6eFQh8TJiW14qI3lDm6L5zoPzMHN8pYfsgu97qrQcqmL+5ST3ExtcJMGPpx8j/tgfyVG8czaBPkTzExSkThBN3vPJpMtfZ7aXQ3X5WQPHONqxHbkoY0cz+7+Vo82+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509398; c=relaxed/simple;
	bh=5h7HZcz/iuIWhfi1ljBwJaPuEGM+N6Xfk0MeqiA7TpA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjtCOKZStnPAGEEPXKPLb4iI3RaORObtI7YIFiokbsdvySVTy+EIAbklFipC/r3f+cbg99tafL1aINfoHpMI127kYvrMc5GsGMefBsMKd0+5loWgPu1EDMkhx5SpVUtzFr64XcW9cl11Ir0oSYJywdUnYxu1HXuVhsu+mN48WuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO0dwnTx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762509397; x=1794045397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=5h7HZcz/iuIWhfi1ljBwJaPuEGM+N6Xfk0MeqiA7TpA=;
  b=TO0dwnTxdEn3Gj5oAxb/zhr2hdWN4j0qY7Q+obZbDJPsuVKKtIOPxeqJ
   Yx79xgaP0iMOjxEiL9Gcf20GuYpsomh1lj3X6nIpq/x18RV/OFTPCenFy
   /NGpkWw3r/CCGIWAm37RI3y3EBfdqZmYDcpuU3xcqTGThY7TgmJrUow5k
   26PHOR3HGRjW0RY+27m00GWnLAVugl1YxnSmjeWIwjr09f3V3tU8+VTzM
   UKzhQmBAK8tUAYAZc7C8FQDPbj4RfersxeuqZXTIstfFbbP34kh0FYRUL
   5/w2kYyWx5UbwpmULBvXrZ0uFMhdPVp6QWTXBZpQIt9/cMxE3F3ovWDc+
   A==;
X-CSE-ConnectionGUID: 9qyBypI+S7OuE6Mv3+Sk4A==
X-CSE-MsgGUID: cwATL0JhQfym77Tp3i0mcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="67269239"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="asc'?scan'208";a="67269239"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:56:36 -0800
X-CSE-ConnectionGUID: 1GQumejiS+msD2Q5HnPYeA==
X-CSE-MsgGUID: RYdzEpKOTOmORGAgXt0VnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="asc'?scan'208";a="188163946"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:56:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:56:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 01:56:35 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:56:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcCdhBXOQioNWt9d6VH8atsmMZJTQp/jd5TlomnlkOvc65XH5xEDVK+McBwsT2Cl9L+48OD/vm4yzs8UeF/7LcTCoM1y1rz+jMpK0BYqjQZmuhsLsqaq/PGc8v0hLKfV03XlptNoorvZOzrY/zJCkE5RvF0s6tRHbOshIOTm24Lt3SphiDfkleEwifPsYeGqmQ5CF0Z8W8z/hWLQGlP7mU5G4/nCKrUBMQVgqwsqcSrCqv7uXJXuYHQt+qUPwFr5M/SvYHV/VgCRXzfBJ2URpR6qWNQSniE3e22DYMhP98xVHiTJEhKAjyAGqvQ+hJXKwjGPnnrACkRJQrBsen0okQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPpB2u90iHLiS9k9bPKheSLOW5TWTK32TDI3LQu//jE=;
 b=MHk/t2Zvc1S/I5eQRtsUr6fi49x6CqF7SJyr+sORnqiNqpEGBHbsnW8gbAjTqUJEYvq+mSMEJX6/a9VaVuYsgAh/A8fqVD9vstOoRJE9NbB2gKPNB+8DzddP7A0Srx1cfZZUcH5c6YRsckPq7ddhqiCGUqmpffYDaXOMFXGbanScBgirczkHd9FckDzwVjUjzXzoKrslxLnB/pZTUkZigBFAdbcYUCroYSDE15YGUJqLtEm8d3+ptc+21jstDNp7KT7vjJeRONzxb10kDkt9KF72O0Tt9k5mailAxuPdVzgKEb3KtkDeKuYYzQ6K28TVEgL2Uagr1/aI2dIIrRtYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 09:56:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:56:33 +0000
Message-ID: <98c774ea-943d-43f0-a29d-b540bf289939@intel.com>
Date: Fri, 7 Nov 2025 01:56:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
To: Nate Karstens <nate.karstens@garmin.com>, <netdev@vger.kernel.org>
CC: Nate Karstens <nate.karstens@gmail.com>, Tom Herbert <tom@quantonium.net>,
	Sabrina Dubroca <sd@queasysnail.net>, <stable@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Jakub Sitnicki
	<jakub@cloudflare.com>, Jiayuan Chen <mrpre@163.com>, "Dr. David Alan
 Gilbert" <linux@treblig.org>, Tom Herbert <tom@herbertland.com>,
	<linux-kernel@vger.kernel.org>
References: <20251106222835.1871628-1-nate.karstens@garmin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251106222835.1871628-1-nate.karstens@garmin.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------8U6omurRma5qEgPzIYC36inr"
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: ef060030-8550-4fca-53ed-08de1de3ee94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU1NeWFHb21QWW5NSWZyRHRyNlVxOTdkbHNoNnVVN0ZJWlc3ZzhZRUFRc2pN?=
 =?utf-8?B?YVNncEZzWXlwMlY4OW4yUm9lbjI4d3BDNnczNVdyN2ZVRmNqRDVtZkVUME9s?=
 =?utf-8?B?SkE3YkdOV3pvdFNaVWF5eFpQOXUwZ0tOeEhSdG9BK2dZWldSMmJITm4zQXFv?=
 =?utf-8?B?b0JBblIxcHY5bmNiNTcrSHpaTHhjMHdRYWI5WmlRRVV1anRjZGJzbkswY3BI?=
 =?utf-8?B?L1RCd2REN0xQSTkrb2lnUUR2TVNTbUNPckpoVlJlUXNHRS9sWnZ2MlZmb01L?=
 =?utf-8?B?M0REQ1dLY2ZnYkN3YjB0R3ZWTk5jME9RSDdPajRkTHhENmRxdnZBYUlyTEU4?=
 =?utf-8?B?Y09hcmt3a0QxZGVSS3Znd28wRFBoRWhEUU90YThNb2NrNlZSUm5WNENxU3NW?=
 =?utf-8?B?ZEJ1aGRNZjFZQSs0eHdVSDFMbFc4Ris0N2RhRC9lcjNvMFFEOHk4amxNZGcx?=
 =?utf-8?B?Tmg2WFl3a3VKWGhmZlYxSXVGWStMeWdvaEJ0RUI4a1VWckNqZGdYOTZqYTE4?=
 =?utf-8?B?MEdvU1hoeUdFQ09HK0xSUkJYU05JMnNyT0IxRWlENmdyVUVKdCtlN2I4ZUhr?=
 =?utf-8?B?VUdQQ1oxSkdQR1hUQStyYnh0Si9SUTRzcUFBejJDVlpic00xTDdpUDcxZzE0?=
 =?utf-8?B?ZFNjd3RWYWNqNGljYUdVbk5zbjFVMkd4VWh3YzVGNDU1azgrbkVCa0RGeEhv?=
 =?utf-8?B?NVNXa056Ylc5Q0VYZTBEdHAwSldSZEdqcDRVdElYQlhSR1EwSVlBeDBrR3Rs?=
 =?utf-8?B?KzVrZkRKQVVyRm5rSzVYcis2MWFoeFkzZ1QwemFXeklFd1RSNXVHN2xiSHNP?=
 =?utf-8?B?NkN6dk1BZ2hMZWdPTEFmWk55eDEvTXlBYmVkU24wMnUwcEp5aWpCN3FiVU1O?=
 =?utf-8?B?a3dvQ2FFOGZVUTlpSUFDdnM5VWg3LzAvb091M1JMU2gzdWtkTDVWUHp5WkR4?=
 =?utf-8?B?ZlVURFZYdW1JZysxV2NyZXJQUHRJMmNOeUNTU1ZoODhUc2FmQmUwVE5QbE9Y?=
 =?utf-8?B?UkRRTTdLdVZBS2gxRlRZVDgwMlBNNEZZNkZPQVA0VGw4UFRtWkZUdTZJK3or?=
 =?utf-8?B?djVOR3VpdXVLOTd1My9laEY0VFBnQlBEVjZYeXBneVlVRER4Zmp3bTNkd2FC?=
 =?utf-8?B?YS9BUXhsaE81MjJLZ1lERmFpT2NGa2srK2NicVF6UTQ4ejNUeWRCQkNHZFAx?=
 =?utf-8?B?LzQ2ckt5REVpZTRCNTdKU1lGTThxYUVKUEphaE9tMGRsaUE4VjdFWEdZdWN2?=
 =?utf-8?B?S2VlRXpoWXdwTndhRCtBa2xwaStiRDhCOGtyYnI5MUpUaW4wUXB2Y2JOQVJD?=
 =?utf-8?B?eExZVVFsY2dncVpIQWhOY2JRdVFqR0NqTC8yZUpySkZIVXY1L2NHVDEyRHdL?=
 =?utf-8?B?TU8xL21kSHI4RjRuUG5kSEZhdW94MUg2UUFuR0hEMFd4NFJOMTRWVUtPbE1j?=
 =?utf-8?B?WjZjSzEzMFcyNGVla1MwVXl0dlIzY0FYVDgxaXdTekRaRXlBeE01SEEvK1BC?=
 =?utf-8?B?SmdIU3owVVdBVTVQaS90ZlhWeTNxcnNYcVl2anc1a2d1Wml6eG5kSkh4cU5U?=
 =?utf-8?B?RmdKTWNTOUxadXQxM21oOElLenVGMkpiZDNHK3FVUmVwRTc1MVlJdzRlb2xN?=
 =?utf-8?B?VS8raUEzdGZMTE5mWXBQcHRyZXZvaW4rMU9hV2JIKzZma0hiTDMxUWlFQnlr?=
 =?utf-8?B?VDhGUEd2V2d3V1Z2UXg2SzJHeXdqMTVTVzdING5pbTI2R0VyWXZKOFQvWU5D?=
 =?utf-8?B?elRXcVF2dmF6YVNJbFN6OEdablVTUGFmN0k3YjRuQURpUy9LdksvYnRXeEZs?=
 =?utf-8?B?NktmRUVuOTBsUVU0aGJodVZGM0hkZGhZQUVxMmNhUGg1MkV5SndYdUFUQlFy?=
 =?utf-8?B?ZGh2N1U2dThxS3BoYnk0ZExBREhBOGlJREoyOWlPRElwUnB5WDViWjNvbXNC?=
 =?utf-8?Q?U++yv1YZNyT+BLwjcbaMlpI9UYnFt6cR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnpwdVBOWmVlYUlHelQvVXVZbEF2OTlqbjlmZWg2am5OdVVlMmxtbmpsWUND?=
 =?utf-8?B?dVlqUnNkcXE1RGF5cGxKL3pPRkd1SHdGQkQ5U25aa2hmNTcvUzJoNkhFS2tU?=
 =?utf-8?B?K0pqejEyb0NiOGVwN3ljWmJmZnE1TGNNcnBBVU5MTFQ0SGVCZWZjY0RpUFFy?=
 =?utf-8?B?b3NLck82TlZvaVdpcHF5VVJmL1VMRU9PblRCT1dxU0dnY3ZxVktOdlpkbGtq?=
 =?utf-8?B?YlYwUXM0ZzhwVGUwYkZkb1pNVHZZZHNqL0hKTVNZSlZCbTJhbG56cFMrbm5Q?=
 =?utf-8?B?SUwrQUFVWDhldk1YemttbnF3T1JSRHc4aGpjWTljQy93bnkrd2F1Q09Vd3Zw?=
 =?utf-8?B?RkdWeHY4aGtDUGREUzc0bVdaODVCK0t5YmFXcit0ZlRLbjQ4Wm4xK1VTcWFa?=
 =?utf-8?B?L1hhNmIyYkJLUnpiWHBscXc3WnByZGsvZm0rRUI0WE90alo2MFg1NWpGbWgr?=
 =?utf-8?B?TklpSmdXRU8xL1dVMUR1OVVhaEVzOHYxMkdMVW4vWmdtS2ZjQ21NdXdxaE9s?=
 =?utf-8?B?bzQxNEF0MDNqRlRtYkdWWVV1M2JUS2VvZFRjTW9GS1ZsSHZsTnR2S25tWGhr?=
 =?utf-8?B?RFhHTUZNRTVXWjRFVlNFRy9adFNTdXBRU0o1S2lBenZIMEE2WnVQSklDREFD?=
 =?utf-8?B?Z1hXRmQwdWZpdDliOVRvR2VSc2NNV0w0T0hWMExtNWd0c2xQVWRIcFZFOXRO?=
 =?utf-8?B?NitOSS9OWkY3SmVWYlYrM2NhWFh2T0NxRmNQNU5hcTZkMDBEdmUxeW4xeDJ3?=
 =?utf-8?B?MENNdWpVU1dWeXFqT0pFLzVWMm5hUDk2NGZrajB2M3FhZFFlWEQzZURRd09V?=
 =?utf-8?B?SWtLcXlpRWR3MkVpa2pDQzZOZjZkK0Ezd2l5MFpRNlhpc1ZnOGU0MkQrb2ZT?=
 =?utf-8?B?Zy9PcEY4SURNYUlGWXRIMU00b2dzRWpRLzkwRmR0UUFtaUU3ejE1TDFhQTBS?=
 =?utf-8?B?emg5cldBdHY0cFVQWnRSVzBwVEpvQXJVY2Q5OGRyeWdDYXd5MG1ZTmNWUHpR?=
 =?utf-8?B?UzA5U3RlUlZ3R1VSSzVmR0F0QmY4TDU0c1pCWDVGWnoyYjdFcklRMk5EU01t?=
 =?utf-8?B?MFNLYVlYdzUraHZqTTZqRVBrQ1M0cHR4aUhhZ1pRYXI3UDVxNjl1Ung3REpD?=
 =?utf-8?B?TnQ5a1JVUzVZOVFod24rM2JmNW9GeUhQSXNLMEtTdGE3S3F0TXpqcUN5MGRu?=
 =?utf-8?B?T0JjSnNoTUtBRHZWNHlBMk40S1VIY2VUcUNmbHVRNEZQaU9nTkR5NklZWVE0?=
 =?utf-8?B?eERkTXZkS0JTamdVZGlsR29GRThQYyswZm5BenkyREwwZEtaN1BuRVRCSnhv?=
 =?utf-8?B?SEdocThOeWpuTlQwRGNvenpQeEJjb2FDS2V0TTFQZnJYb2loNTlOcStSUmc1?=
 =?utf-8?B?M0JIV2p6MWxNcUxxUnp6V0pVNHViUzhiYXhOWHZFMkpza3dnVXQzdjJmZ29J?=
 =?utf-8?B?Wnh4TzRra2ovNnczZWtDZ1NIdkJlRFlINi9JajRVdCtndElCQUd6aXU2bGpr?=
 =?utf-8?B?d1RVeDNsR0ZSMnFSUFZFeHhobkxjL2tmSjZUc0xBbWg4bVdNbGpIRElpL0dC?=
 =?utf-8?B?VUp0LzVwOHpsZ25URkdMcnVxRExaZi9oazNQWXdRcWJUaHJCZVMwZ20vTS8x?=
 =?utf-8?B?K2xQMXZnZlRDVksyRWlDUVRNb0xBK1YrWEJpU1lYNFc0VzhwdTEvSWxDZkp4?=
 =?utf-8?B?NjBRdC9EMGpKY0Voa29GaEdUSjJWd3NSZmw5cG9QMEFpOHJveVVIajhQQ044?=
 =?utf-8?B?NWE1cm9yemtnRVpqS2FjWFpZZ0pDWGdZTTdza1pFMEFxWUh3d29xL0tpRHd6?=
 =?utf-8?B?a3QrVTkyMFkxUnl2bE9wbGtIcnE5WjhHdWRLQlk2RnY1ZGw3OHAvSkEvV2Ev?=
 =?utf-8?B?ZmFkM3RsYi9tOVV3ZWlrU0lIQnkrZnI4VUttQ001a0RRcklub1pHSm5zR0RS?=
 =?utf-8?B?NFBzYWh0em54a3pQcnRYRnFIcEFOT3lmYzd6RFBhUGxKZzhDRmkxTzJtNnBN?=
 =?utf-8?B?eDdFSHhFYlBTQnJvdU5OaDFOcUdpQkJYMFRmSmVaaEJDTDM3MG1NZkx0ZE1P?=
 =?utf-8?B?bE9rUFdtZVpwd0pnS3RiV05IeTdyUEl1S21jbTVsQ0dQYTRFOWU1N3RKOTc5?=
 =?utf-8?B?U0oxZzJhVGZXMmhGaHFXdnZFcHBnUWlzeHJVQkJUUWtidnYwSWdrTUZFdEgr?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef060030-8550-4fca-53ed-08de1de3ee94
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:56:33.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muPp2K47TnKC8fM7BhxTXJnQsEUayS/i5jj7+wnD5trLhGer5SDfOyXFtn0SEgBWJljqp61Pieqt6xsM3fVgl9vJiv+g2hx/O69sXm+Y08E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com

--------------8U6omurRma5qEgPzIYC36inr
Content-Type: multipart/mixed; boundary="------------ztfZIIwmbApEMzzf2m0IfT9K";
 protected-headers="v1"
Message-ID: <98c774ea-943d-43f0-a29d-b540bf289939@intel.com>
Date: Fri, 7 Nov 2025 01:56:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
To: Nate Karstens <nate.karstens@garmin.com>, netdev@vger.kernel.org
Cc: Nate Karstens <nate.karstens@gmail.com>, Tom Herbert
 <tom@quantonium.net>, Sabrina Dubroca <sd@queasysnail.net>,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <mrpre@163.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Tom Herbert <tom@herbertland.com>, linux-kernel@vger.kernel.org
References: <20251106222835.1871628-1-nate.karstens@garmin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251106222835.1871628-1-nate.karstens@garmin.com>

--------------ztfZIIwmbApEMzzf2m0IfT9K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/6/2025 2:28 PM, Nate Karstens wrote:
> The `len` member of the sk_buff is an unsigned int. This is cast to
> `ssize_t` (a signed type) for the first sk_buff in the comparison,
> but not the second sk_buff. On 32-bit systems, this can result in
> an integer underflow for certain values because unsigned arithmetic
> is being used.
>=20
> This appears to be an oversight: if the intention was to use unsigned
> arithmetic, then the first cast would have been omitted. The change
> ensures both len values are cast to `ssize_t`.
>=20
> The underflow causes an issue with ktls when multiple TLS PDUs are
> included in a single TCP segment. The mainline kernel does not use
> strparser for ktls anymore, but this is still useful for other
> features that still use strparser, and for backporting.
>=20
> Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
> Cc: stable@vger.kernel.org
> Fixes: 43a0c6751a32 ("strparser: Stream parser for messages")
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  net/strparser/strparser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index 43b1f558b33d..e659fea2da70 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -238,7 +238,7 @@ static int __strp_recv(read_descriptor_t *desc, str=
uct sk_buff *orig_skb,
>  				strp_parser_err(strp, -EMSGSIZE, desc);
>  				break;
>  			} else if (len <=3D (ssize_t)head->len -
> -					  skb->len - stm->strp.offset) {
> +					  (ssize_t)skb->len - stm->strp.offset) {
>  				/* Length must be into new skb (and also
>  				 * greater than zero)
>  				 */


--------------ztfZIIwmbApEMzzf2m0IfT9K--

--------------8U6omurRma5qEgPzIYC36inr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQ3CTwUDAAAAAAAKCRBqll0+bw8o6D0K
AQDFlBw/EWdZOaQ8B/NtzktAThNlMZZ0X5O5GYDaW9SvkAD+K4vGKT2OUgo8++1cP1KG24elHwoi
dNxL9STsI9lCZAE=
=UsBq
-----END PGP SIGNATURE-----

--------------8U6omurRma5qEgPzIYC36inr--

