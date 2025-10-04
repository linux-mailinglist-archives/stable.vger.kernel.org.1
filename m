Return-Path: <stable+bounces-183347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08257BB875E
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 02:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8964C2504
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093A41F92E;
	Sat,  4 Oct 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8bfSafv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3BEADC;
	Sat,  4 Oct 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759539532; cv=fail; b=DvFK4RNyW990WHj5YhPPJqhjHXWmtZr2MAPWDr5POAx4hrtUzukwGaVGhSc+OzClOljI6ThJY3Xelgs10B15McFaYaAG8Y1vn0a7DLZQGHnBe+e1VyWqfKjlxkKy4tyQ+2EhdXFz0U40YfIihgxN9P/B8CREt+DMegfgE/7qNqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759539532; c=relaxed/simple;
	bh=RBt91yDEEESJAiIOaD8JAIuStiCA8UC5KyFY2v1DrA4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V6934Ir0vrM83AfuvT5Tx4uOM1437MMCwRkD8GquLEOR12tuByuhwQhM3duvDFoE5D8pn/7i9sOFx/SuJCWUsDutl6+cgEdHxgojeUH709VsEiVH3I+wU/XmG6jCQZVYLRyKv7oNtvN9FfyLjIGkcfuI0zzVEWcVEzhZbIDsMoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8bfSafv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759539530; x=1791075530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=RBt91yDEEESJAiIOaD8JAIuStiCA8UC5KyFY2v1DrA4=;
  b=I8bfSafvDXE+2uL7SPPWUKWbAsNoPj1DbQJIMiq3GxcdOY+y6CFVB3oG
   epl+bvjv9RHYcF7ikbimfRT+YEOTTrL70OpMjU3mJplsrgeTsjenjY75T
   P8laRwwOH2FSD/33BrL2VW6OgmvIwkOyN5uE4Ge+c2XHF8gwuEJKjPPC7
   8bXJm817NDUwZHb7GhCNDFvYq1BbKSCHC5LsloGNVDTr+FEwYcwSzAHpz
   o1eXklJSyNhjEXu00c5a7qxzooESLZFJ2tydWWQ1X9GRc1rMtUKXF25x1
   BPwiAkIMlftJ6Sr4AH05ZORFP6ZowZB8JdMy7WOZgIdp4eJytO9HtL1Sj
   Q==;
X-CSE-ConnectionGUID: lxlT4NSpQViy3gMZYvkjQw==
X-CSE-MsgGUID: 5hiOSspbQw24h8f0Cmn6NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="79468220"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="asc'?scan'208";a="79468220"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 17:58:49 -0700
X-CSE-ConnectionGUID: BsE+DgTlSL6ulByb5tH+dw==
X-CSE-MsgGUID: YntsCPRpR0G0YidxGJwswA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="asc'?scan'208";a="184691316"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 17:58:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 17:58:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 17:58:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.34)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 17:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8pqTVw4GCSpO4t7F+V9PBPhfIHDMtGOCo7FtisRB87Ef9OULcfzUh2p0n0quyx1mZIUla4srhf38bj2m4W25dCJKMqHvu+5SrWdzyWFZDjEkHo5C3vOpVvLKMR9BDQx7v6I+Fq5WlPNZXJhzIT3J9atBVqGXQkpeBWkHDZ4b9Ty1Wts+7Dcx/QyWqBUTpofuMofjATTDckPihmKfKwRRAnL7n6q9kq9bAVy4nG/L7w+IS/K31MTiu7KUPsZXNYQ8fLKJvNpArIc2c6Xpj7fEPniHe6xxzKbaKSTPHD26mk9VZHnx6cR6D+kT4HytRDJx+sq5U3g5Db26+M0gil/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBt91yDEEESJAiIOaD8JAIuStiCA8UC5KyFY2v1DrA4=;
 b=VzDUEjR53RkEaGCII96ntE5TTZUJbyhJnJ+YTRl6yVo7wTOOT8Saia97vWNLKpwQyrPRg4mBXapfxzDkNajz+oKLJP/OweZAG4YJ8OuzZexN9Hy23nHK7adWcJFzjsH+UL2BBS/+ON0if86MD0FfyubXvPQLVI6AuUQLFYJUD9sW67mK71BG1b3HnAR/vPb24NdN3tmc/34fK1M7MTZ6TjoBxZ89AI82uETw0crOr/qd9G+vDyUGF2mQ2DUNwmauCASIkZmzJ1pyMiqA+x6TVXP2FGGXZmwP+F4x9is15MIudJLU7zXSANAQ9a23DDUKdwONaFRpWiMMTmnNNMDYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Sat, 4 Oct
 2025 00:58:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9182.015; Sat, 4 Oct 2025
 00:58:41 +0000
Message-ID: <41c29f93-06d0-4211-87d5-d9ba232a8af0@intel.com>
Date: Fri, 3 Oct 2025 17:58:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
To: Jakub Kicinski <kuba@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Emil
 Tantilov <emil.s.tantilov@intel.com>, Pavan Kumar Linga
	<pavan.kumar.linga@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>, "Phani Burra"
	<phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>, Milena Olech
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Chittim Madhu <madhu.chittim@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
	Andrzej Wilczynski <andrzejx.wilczynski@intel.com>, <stable@vger.kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>, Koichiro Den
	<den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251003104224.59777107@kernel.org>
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
In-Reply-To: <20251003104224.59777107@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------96EDbU6sWthWZt04r9Luv1Sz"
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dc5b7c-cbf5-4d60-7697-08de02e128b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHhJK2lmOXFoZG9HeGRtQzVkTzdwZ0NVLy9xMGxCcmhVR21zc2xOaU91aGdE?=
 =?utf-8?B?Y01JZUdodE5QbTY5YlAyTWVhbFc4VENZanc0QlFYaExmWDZIRG04WTFQM1F2?=
 =?utf-8?B?Um1xV09JQkpNR1cvZHNwbXJnaGQweGFRK0xpNHdzb1h4RytORWJqWWV2akZR?=
 =?utf-8?B?YkM5aktSaFFoblpmVkQ0aXl6V0VUZDZBUGNMQ2R3TitBRUZ6TnBTSDA2eVVk?=
 =?utf-8?B?cG1SWmtiVnJGZVBuVHVTcmdRckxjUkZsSy9WaVpoM3lNQnE1Z1daMWVDVUtx?=
 =?utf-8?B?Ulk0RE11ZVlkRlliTElWdURqVUNxMFVmMkZNWGtyQ3k3bmQyblBTOFZFY0x3?=
 =?utf-8?B?eDFyR2lIaGdaZTc3dVRuVko2MHFQL2dLNXVCdGs4TlVqMTZqVjFIRkFpaE1H?=
 =?utf-8?B?bkpVOEEyWmUvamRaSUxVdGdYWVJMRHovNG9jYVQ4QVFTcC9XUHBUdGRLT1ZZ?=
 =?utf-8?B?MnFyVEZodXhiZWhhRVVIcEREd014ODVMVk9zeWU1YnM5RitOalhESi9WWVNW?=
 =?utf-8?B?Y1pBbFNoVzVleGNJVEoyZVcxWnlhQnZtdGVnMlNUWEpoMU5tMGsvT0pYUWc1?=
 =?utf-8?B?SzlVMVBjd2ZQdVM2T29laFBiNXFvSHJnSWpFdUlqU3d4elZEdjJMYXRlNG1i?=
 =?utf-8?B?S200UDA1OG1yZ0E1UU52YlpyeWNWRDY2SHlrcFZTSXlwNm5YclJhYWM2U1dY?=
 =?utf-8?B?bHNlUExuQTVKazhzbm5BNEF3dlNIVENwckt5RWlUUm1JbGlTTEMwbHNrYnQy?=
 =?utf-8?B?MlVTR1FvMVNoSnN2bVJkaEVUUjNVaTFnVUd5MEpmVnBlY0UxcVNPeTdXOFRm?=
 =?utf-8?B?Smp0WmN6RHhtWWtjZklwbE1ZMXk0VXdINzZET2VXSktkbHlYdndDTFB6Qi92?=
 =?utf-8?B?bm14Qnlrb05ScUdmbkxGcExjcThiV2Juc0tLK2hCYXREUTRmMFovdjNtdTZz?=
 =?utf-8?B?UzJmQmxXcTRHdzRNNnlNbEpIVjdhTzdnNVNWa2VwQU1MRnlpWExDQ0xaWktk?=
 =?utf-8?B?ek5XWVVTbEdPdTF3dnl4OHV0V2pmSDYxZzJtOTR4bkhocUUzbmdVWkpUczUy?=
 =?utf-8?B?bk0xNVhYZlVWR3pBVlAxZ2wrbEFyMEVUS0c2a0xnYSttOUxtUk1DN2pNZFZR?=
 =?utf-8?B?UnJKcDRmQTRmV0hVazNOM2NML3QyUWxCb3hVaW9VYWpPSGxIdTZvMm92UGd1?=
 =?utf-8?B?cVlOdGdIRm5XYWRITTA2Qmo3WHRkcEhFdUJkenMra014UlozM25RSE5RaWU0?=
 =?utf-8?B?dG45encvK2p1bDZJc1lkQzFGQzRmZWtNSnVFYTRGRDNhTmZTS0hwQ2ZreEU0?=
 =?utf-8?B?ZEhwQSt6UFRWb1JjODRydDkrY29kVEZaUUpMcDJQSVY0dDNRNHlrQ0U5S3g4?=
 =?utf-8?B?ZDBYRWxURm5xdE5qenlqTVk1c2RQSDVLek5pWU1NbkFFeTM4TjBvL2w3SDdP?=
 =?utf-8?B?VnlNR3F0Q3dPOGFsWFdnZkE3TXpvYVNhc3lrK0t1M1cwZEo0TjQ1b1FRdmJN?=
 =?utf-8?B?eFlONDFjbmp2NWtEOUNJUllHbmc1VHBmZjk0c1Z5Ulc0NzhLK0JERTB3MUpj?=
 =?utf-8?B?WmFzQ0s5bUpndEF1N2lGWVZRQlZKKzVlQlJQTTNXeVNvcVNrWkFTeitVRmhZ?=
 =?utf-8?B?ZmpqOG1TdDk4b0hzQXUzc3hRODlBaVdiUm83WTFYZ1ZyK1lwTU5yVHV3d1FO?=
 =?utf-8?B?cjUrM2dQeGltZUFxZ0pSbFU1aXBjcTRTeFJuL1liTTlzTUN0NFBOY2xrYStK?=
 =?utf-8?B?M0N6aWhIT0VocDdBK0FhWHl1TlU2aWN0VUhjR29mT1FoazJ5a0xFYXRRNWIv?=
 =?utf-8?B?S0k2WUMrcTNSUjYwbHF4SDRBOGNHaUdaMjFoUW1nSXRidjYxTzhMamJnejQr?=
 =?utf-8?B?Y2hqTDlNaW10YTJsUU5sd1RaNVNpdmg5Y2dGb1VFT0pZN0ZiVCtpSHl5eG96?=
 =?utf-8?Q?5ge4/Ck/CxOFLcHHnWaCad2T8/taQhW9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxjY2VUakxOQUI4MU9mcE5uWFNmQ3NJRzV5M1hsMk1DTzBRSGFrcVFjTFNR?=
 =?utf-8?B?RHBMZzFSYUZJT0dxbEtUYXJZeXBraUpmVlVyb0dYM2JjU1NJS3JkUzN3Q0d1?=
 =?utf-8?B?QzdFYU9TaWxvdnUyRThnejZHbGJFNjl5c2RTMEFQNVVnQmZRc28rVzNmNkEr?=
 =?utf-8?B?ZGpKV0tYZDdCSGIvRUNLbmNpd1h6VnFTSHBCODVqUFJzemh6TjNDUzIrN0ds?=
 =?utf-8?B?c2FmU2d6ZEZhaFJMZUhCRjVUc3lXVHR0cUtBQ0V3cTQzUngzeGdFY0lXZ21u?=
 =?utf-8?B?Y0NEYzhVTDk5WDN1Y2lEUTZSRGZrNWIzTXRHUVJ4U2cySit3TkZ3a0RmUnJ0?=
 =?utf-8?B?WmIvcTFwY21FRE9xdksweFRyT3paS2ZHTjREcitBZFUxVlFhSkIycWRxMEN5?=
 =?utf-8?B?cmdKVzJUMitJdVVOTzJJblByTEVwVlpaaCttZ0doWFJlSlExUWEzdEdHY3pj?=
 =?utf-8?B?Z3hYMC9KTFFQMGdkN0dOQUgvWVJaTTZpdEpMT2JVRUJOVzAyYTVVd1RzZmti?=
 =?utf-8?B?Y3ZucDdRMnBRVEthNmMvK3RwT3RkOFkvUzd6WkQ0WVNqdDN2ZUpIMlBlc01x?=
 =?utf-8?B?MWlmcWhwT0NFZ2FyQjAzVjFDSzlZQllOOCtYKzBDU3VYUGhHR2QwV0lGSnpE?=
 =?utf-8?B?aGprS09vL0JQVUdYMXcxYndTYXgwUk9WalI1UmdNMDdYczdZTXRDV3lBcVor?=
 =?utf-8?B?aGNjcC9xWW9hN3lHRDI3K0JUdFU2MDVZcVlXR01YZmZ6YWc4TmttWkVISExt?=
 =?utf-8?B?TzNmbzUvcnpUMWVWWU9nMFdjbm9NZENPbU5Kem5iY05qUVB1N3RBZk55NnBv?=
 =?utf-8?B?MFFFZWgzbXFJcThIQVRrRFlCeGJXUXlOT2U0eFZjQ3NINzJrTnRYbStnR1Qz?=
 =?utf-8?B?QjdjSGxhSVNyWjBXQjNzR2RCTURNKzJpc08wOWVqWnBvNzJqY2w1ZUt2SGxJ?=
 =?utf-8?B?SS9rWnlVclpqWnRkeE1OTnA3RXdUSjJVRVVyb2s0Z2RJZ3dGa00yUG4rditr?=
 =?utf-8?B?RGNIcHArSDZqd3pwSkdLSXhjNm1WVFpxSkVkNyszRTNjOCtuQU5wZTlvT3FJ?=
 =?utf-8?B?bzNNb3llY0RBMFRtdFl1b0lpTHJCU25QQm1jMko4bFB4SllQam0vOXc0RFhp?=
 =?utf-8?B?dUc2dkV3S2V4bDQ4WTUvZXcvZTB5clhTVFRkOTdjVXZWM2RaeFRmNVRRNmlG?=
 =?utf-8?B?ZkRDYVdrRXVLNTJkd0kwdGp4L29rTitHZm9lNXVvUkdIeHdnYmFYaEJCTi9Y?=
 =?utf-8?B?cmtlNUVpWkcxL1ZLWE4xQ3Joc0N4NHJrcXRiR2VoNU00UmwvcHNaN1A0WUYr?=
 =?utf-8?B?a3hYSXlxa1ZQRVh2RFE0VzVWekJIUk9UTC9DR1k1a2hoZ3Y3YVhlM00zNVBm?=
 =?utf-8?B?VDROVnF0eVFabmk0ZllEN0FSUlY1SUM1VkhGbGdiMlRhOFBnOHJFMVdqRFFt?=
 =?utf-8?B?OGovSTNxNmhNVmhIeHQvODNlR3NMUlhFN0Rxd1hKYzcvOGw5UWwzSHpUeWZx?=
 =?utf-8?B?bVRYbk1IMXdMajNKNktubUM4VjBZdkxWM3RkM3VVeTRjRUEydDBJZUZKMHZQ?=
 =?utf-8?B?WHhlYzhWZ0d6V0owZ3ZEc0hWbHhsSmc4M1J3QjIyN05CSXJEbU82NmlVMWg0?=
 =?utf-8?B?RFQyTTViS2N4cloyaitZcjlVektlWG0zL2gwVnFCeHNqdzJNdEtKd3l0ZUEv?=
 =?utf-8?B?U296OHdNdzllOGNNM0NlYXF4Wnp3RHlyNG5laHM2bkVzbGJxSmVid3o2WE8r?=
 =?utf-8?B?V2xuL0tkNEhhWEp2Ylltd2laRkRZa0FTY29MQ0lTYXhxWHQ3RGREc1VHU0Nw?=
 =?utf-8?B?c01EZFhwVVljK3M3NjA1S01rSi9odk5pZGk4NGozTW55cUtPbm53NjVmdHY1?=
 =?utf-8?B?c04xRnNmelBybExVUTVVMUFURExEd0xHYk1iVXVMUHFPREF6bzdYWG9lNDdh?=
 =?utf-8?B?N2xUV2NzdXNYRFV1cFM2THQrbGVSZXB5ZCtaMHN6OEFLRTAzM0ZnTkV5cXZz?=
 =?utf-8?B?TFl2U211c3Bwb3RBTHQydDhSaXBRaDAzZEY5clVPd2ZxM3d5SlR2ZlE3eFBq?=
 =?utf-8?B?ZmgwOS9NMGxpT1JOcHozVUtGRUR2V0IvN3Nsdllmd3JYTEJLelFMMitEbDQx?=
 =?utf-8?B?YVpSODNoTzhpOW1idlBVV1F2UE1LUHUxbVhJY1pHTnpDUy9uOXUwNU1Vckd6?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dc5b7c-cbf5-4d60-7697-08de02e128b8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 00:58:41.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uLrUD3LMqbPT/7GCrZ8yGATC/7wp7Rq+sAXFgeGluz0MMGfUL2PdkSU10OGuYXknn5cOSQaURIzKXYC0iaHM30n8YYH8My8j8wR0XTl2S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

--------------96EDbU6sWthWZt04r9Luv1Sz
Content-Type: multipart/mixed; boundary="------------Azm0zU53o60pvhlQNB5qML1T";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Phani Burra <phani.r.burra@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Anton Nadezhdin <anton.nadezhdin@intel.com>,
 Konstantin Ilichev <konstantin.ilichev@intel.com>,
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>,
 Chittim Madhu <madhu.chittim@intel.com>, Joshua Hay
 <joshua.a.hay@intel.com>, Andrzej Wilczynski
 <andrzejx.wilczynski@intel.com>, stable@vger.kernel.org,
 Rafal Romanowski <rafal.romanowski@intel.com>,
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <41c29f93-06d0-4211-87d5-d9ba232a8af0@intel.com>
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251003104224.59777107@kernel.org>
In-Reply-To: <20251003104224.59777107@kernel.org>

--------------Azm0zU53o60pvhlQNB5qML1T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/3/2025 10:42 AM, Jakub Kicinski wrote:
> On Wed, 01 Oct 2025 17:14:10 -0700 Jacob Keller wrote:
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> We need your sign-off on the patches.
> Sorry for not noticing earlier.

Argh. Apologies for missing that. I'll resend the ones besides the idpf
fix you commented on.

Thanks,
Jake

--------------Azm0zU53o60pvhlQNB5qML1T--

--------------96EDbU6sWthWZt04r9Luv1Sz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOBxPQUDAAAAAAAKCRBqll0+bw8o6MiA
AQD8aNuu38FKtMqph2Vrrxf2jf7nfEvGS3DTzxrBGlaX1gEA2p5Z3rmD7GeoCS1LizrcnH7AvRg4
Q4VwscgxPs1XyQk=
=W8Rj
-----END PGP SIGNATURE-----

--------------96EDbU6sWthWZt04r9Luv1Sz--

