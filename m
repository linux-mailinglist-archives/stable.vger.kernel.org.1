Return-Path: <stable+bounces-183499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3FBBFCE0
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DE8189CDA7
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B5212560;
	Mon,  6 Oct 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRamVPtP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF935972;
	Mon,  6 Oct 2025 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795134; cv=fail; b=aR0wobuwVqSM4VB9XNWZJmNlAOGeguQq+3HJ9PCNkq1lKGALvQVt+k1rSq73BJmcBP9Rohbgz0pZJ/Ka8lrYBIYX1RoypXA6VIDKEQrcfq6GkYz4N2Lw1VEJLGpON3PNIKnn8pfWRN9JqKCiADCna7lP3415o6qhaopkbap0zOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795134; c=relaxed/simple;
	bh=f86UEzjCAhDnKD88wJhaMEmKrJHNNVGX4JYTmMQMQ8A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZpStvJhtoF/6+tWSh0srevHIprC4gQ0UEMAwiZ4xUL17WEdpfwMUa3tIqt4gu6epTOe+vNo/Nc7alzA/KGM4TjHXVnmYuJKE9ye1TRvOjmo44RdPHDxSsh52y3Thw9/PLJvWlBbREaSHPHLyGCQ43s7egSsUVk7x6d4Q7wFqgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRamVPtP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759795132; x=1791331132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=f86UEzjCAhDnKD88wJhaMEmKrJHNNVGX4JYTmMQMQ8A=;
  b=bRamVPtP5WNTy5ddc1/DahevYE9pwXXWrEBQKVNRL9h44Y8cXC2hjB5b
   +DdwUQxD7XIhN0hGChGHgRy/gHHKNFIV0R65X8GJm0YK022Vt+xFX2Kwg
   YtGV0k97e06j+McRSbekRa982inFb9atOeW5sSHhvWvvZcD4p0h/ewLV9
   Lhed1o8aAGIeZl/IrQrPX1Vbwwaxb3M6oLDsMUNotW06yW6I7aVrOXrsZ
   ccqsvgGYAX/qb9jWChJ2HCbIGDk0YS48VPYoaSIRp8N5pzKb6x7xEhVrq
   ytT+hSvvuo86ENEkLMXQnCViAiNhwbkfHa3k/UZx7p5RXfhxOsuX2ihFx
   A==;
X-CSE-ConnectionGUID: X9XNv37pQ9CEZtkLDBxw2Q==
X-CSE-MsgGUID: XNAjaMH7Q5OWhaPhFtZbaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="49530782"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="asc'?scan'208";a="49530782"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 16:58:51 -0700
X-CSE-ConnectionGUID: OcfCRrNBSPOBI3ou2UYpWQ==
X-CSE-MsgGUID: /yfl2NmySlyoWV4R9Zpo0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="asc'?scan'208";a="179822105"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 16:58:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 16:58:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 16:58:50 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 16:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFvb+g5MaH+wsHnwiz71Xq5s9qm2zDC5E5EXjZnDDylozaazYLX6UfoLjq+UbG5jsZydHwc9Wh76m0+2Fz10OIDb9lS2oRRu87oTuLX2mPJYzxn5zhB++btt/WUUr3hw2XKE+NSpCeFzabxI/tL85TpDH4Rq2x/wR3LZ8J+zKIvAqUWWOpcfwqdA9h/CwfxsxT/Dv75rHf9mVz6CeqCfpDcucmnVcVnJvX+90nVJ5t1mtBvftDbRm8fxqbFRgAcL5zsLqRitvH302ygZdROZPhrUWzuCEkz6K0EwzBV0Pj9P2f1SGakuwmkPo9tof8LZREV4+RI71pL+eSYGyJOV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f86UEzjCAhDnKD88wJhaMEmKrJHNNVGX4JYTmMQMQ8A=;
 b=HTRcvN5l6uy3Wwaa2bW5g0QhUbbJk5sswzhWeJRzuBvera0a1o+I3naoYC1mPV+HaakB1ehGvZ+tsTLykRFIb+aOgK7xRyeDYWXM3qBxfuGKk3mqIcmy8SR3SMyQYIJc5loURvRu2wKQfhXBMhMJSs1rlA1Y6sAB4ovF4XCUA+/tgeMYEW4wolLz8QY3g6Z2uqkb6ubUTNkXBuL2n/LMLdkH/bmYt99HgKxEXCiDR4qdgG+s1uzomcDEYvR3fl5JpzeQNqm2W2zc3CWgCQRaOnf02IW8BIdAzokVVyL90RcpAlzEq1O29sUgMBsWfD067A2+MBu07ZoR6vMrVPJ9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 23:58:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 23:58:44 +0000
Message-ID: <a4bbc8e2-06fa-4df3-a907-66b6b6c92723@intel.com>
Date: Mon, 6 Oct 2025 16:58:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Emil Tantilov <emil.s.tantilov@intel.com>, "Willem de
 Bruijn" <willemb@google.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Phani Burra <phani.r.burra@intel.com>, Piotr
 Kwapulinski <piotr.kwapulinski@intel.com>, Simon Horman <horms@kernel.org>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>, Milena Olech
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Chittim Madhu <madhu.chittim@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
	<stable@vger.kernel.org>, Rafal Romanowski <rafal.romanowski@intel.com>,
	Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>
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
In-Reply-To: <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------F5A6abojKOgN7iAzE40edZj0"
X-ClientProxiedBy: MW4PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:303:dd::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de28b72-743c-4f99-4872-08de05344813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ry9iK1pLYlgwSG9DaWk3SS9PUzJHWEhGLzhLUGJGb280YTZxSThlanFUZWFp?=
 =?utf-8?B?bEV4OTJzODI4eDd5UkdGTjJvb1V3cFV4YXJBK2lIYThjYmFVdDIxSmE0UGpn?=
 =?utf-8?B?dlNUVE5TS2xGNUVjdDBKdUtNeFdlWmZZNG8ydk85ZXpBWG5aL1Iwc1lxV25t?=
 =?utf-8?B?YjJKNTBPdmNKSTRCUnVmWExaeXkvbWxaWmY4VThnRkZFd3M0bXdreENROEp3?=
 =?utf-8?B?RUlzMFN3VG41cVplVGRyWFRhYmJXcWo3aUZlNTJCMlhBb0ZQYVBDM01sazBu?=
 =?utf-8?B?K2tSWkRQSjFaNXV0d0RXekxpU3lsVitpRHdablhMZWVacDBQeUVGaGpvay83?=
 =?utf-8?B?S1JhZ3k4UnR0MlZGSFd3R1ZsOVBrV3NWL2Z0dDRFc2tMZkMxMEtnYmJ2dmFC?=
 =?utf-8?B?SjZVQ042cXBVNWxoTHprQU9laEJyM1ZCSzFscmE1M0wrbmFLVE1CdXVjUXVN?=
 =?utf-8?B?M2sxNHdMa1U5cEZuZGc5ZFY2aUtLYkhtZTJjWDVMOTZvaW5SaWRRckJuQkdF?=
 =?utf-8?B?Q0pJditRejBLbWt3Y1BwT2FNbStybmt4TEpZOVYrYXZJZ3J2TE9iQWorT0JY?=
 =?utf-8?B?bERqWEw3SHpTc3RBWWdFVUs4VTNmR2lsaXhTeFpyOFlzNk4vSCtyTTBwdHpP?=
 =?utf-8?B?Vm1jNGZpb3k2WXIrWCsxZVZHc2MxZkkrbnVFd3h0NlNZajR0WlhlcU1ZcEtD?=
 =?utf-8?B?d3JBQXM4b0R3RVB1Y1UzNjNydWV0NGFOL2xNc1crYldTajBTemUyUGk3VGpP?=
 =?utf-8?B?VVQvYzFESU5OeFpGcHVydkcxbXhENjE2N2FvTWNRZVkwUU9mT1ZFTEE1b3BD?=
 =?utf-8?B?UStITkUrQXJsRGJhSjI3QUVnSnQvY3RUWEdjSnVySTN1ZEZKbWNQUW5DVElq?=
 =?utf-8?B?NFduVU5GZjRBSTB5WEhUSE8rSlR5YXlxUHZhYWJzcFRpNUNad3hpWklZSUVv?=
 =?utf-8?B?YzNRa0w5QTR0Nkk2NG9DMUVZMUFqc2VhN3hBK3VqSllSVDBZWTNzbVQ2Rkor?=
 =?utf-8?B?T293bXdUR1JnTGxmZGRFdUxNSWFocW5IYTdITTVYcE9QZFF6YmZ5T1hwdUxD?=
 =?utf-8?B?YW00S0ZCdy9zQ0dFODQveERNSnA3RkxxY1hFaUNuRTdpYjV5UXF6VE56bGtk?=
 =?utf-8?B?OTdyQVZxSTkvekw2bUwxd3hDRW9iZmdTWE15b0xrcVA4c29OY1RualJzY3k1?=
 =?utf-8?B?VThqTDJZYjlmYjZmeng1djFKMVQyWU9rdVVTNllvQ00xWmtCZ2NZVTB6NFMr?=
 =?utf-8?B?YkpKYkJGWFdGcVljVU1kYU9wRmhzSTNLRHVtWkg1V1grZGxTSnBlUDdxU2Mr?=
 =?utf-8?B?WGg0bUFVTEdWN2w0YTMrVzBBL1JJNUVLc2I2eVVLRnhmZGhMbTcvQjhVWHEz?=
 =?utf-8?B?SWlUUmZ1dmVLS3RhdXB1WUpoUm1NeE5maGJob1FzVXlsaTUydC9sZG5EQmVO?=
 =?utf-8?B?dXVHSHJJdGRzbytFVHFsMnRaSVUvVUY2QWNFQkxqU3R3anRVNXNydEkzQTkr?=
 =?utf-8?B?Qk5ETkFCYmJNSkZMRzRmZE9HN3FTSzJGcFB0ckg0SHlWa3VwVS9XMkE1WElU?=
 =?utf-8?B?NmhmSlo1MlRMK1lpN3pQZWpEbkRXSytLd1pBekJ1SHlDeGJiV1h1QUFGdkpY?=
 =?utf-8?B?R2RIN2Q5bmcrYW12Zi9zcUlhVEVBeG9aekdWTG9FNlRCZmxPZTZMMk81MVgz?=
 =?utf-8?B?aEZpY1dVNHVUKzhWREZvYUJBSUFhUWlZaXprcklCWEdNVUF6U2dLdW41ZWJ1?=
 =?utf-8?B?cGNyWGcwUHhibGdaUXg2aHdmSDEzdlRMR25JR3p4R0VwY2x5alJCUWNxTUVM?=
 =?utf-8?B?TmVQcUNUWERMRk1iSFRMUmhsRXk0SzNzV3A1eGUvaGRhY1ZURVFsc0lJL2o2?=
 =?utf-8?B?V2RCcnFIcXRKSzl1NUJhN1ZmSXY0U1laU2I1M1VwTW40WnFBUHhnellSWTY3?=
 =?utf-8?Q?742S4hOKZLTJTUOrTEA1w3cllvI6lyFR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFVbllaV1hyU0hXcndOTFgwUU1yOVovLzFqQllpeEx5M2hLQjFDU0R6Z3ov?=
 =?utf-8?B?bisvUEs5TjJUYlZmUEpxOW9PUk5TOEwvZzYyNnRMdkhPcVFjc2tiWnk5Y3FN?=
 =?utf-8?B?dkRob2lwQnljWlNuWkE2SkNXVUtiWVZqejhLaEhOVXpiZVNFRllyUFViK0Qx?=
 =?utf-8?B?R3BCWUZIRTdmcTd1VlpOY2MydVNLNG5Mcm9nUWdCNGt1SlRkZTBBT2hFaUh0?=
 =?utf-8?B?MlViNnlTVWxYUnBFMnl2SGhyd0FocGFFU0ZnVUpiSVdGa1VlNHVtOC9oZ2pL?=
 =?utf-8?B?QXhFKzlBd0VKckJ6cjJ1YXBDcUJhS3EzUlVaRHVGTTFWdXl6VXVOL0Y5am9l?=
 =?utf-8?B?ZGJWQWhuaGRUVlpEV0Jsc2Y0S0xkUE1rekFoc0tvdEtyY2dTRnFLZ2Q1K05E?=
 =?utf-8?B?YUNiQk5iOXNHWkV3UjhIYm44UEFnZEhXRVVSVy9FMkNNNXBLNmpEMWlVTUVr?=
 =?utf-8?B?Mnk4TWNyVmtBUVlTSDh1U2IzVGUrWWFTWVJURlJ5ejFXU3NadzJseGJYZFNI?=
 =?utf-8?B?UjBMY09ER3dIb0tucVBabDloNFFjbmhzcy9tY202UnliaGpHei9nZkNZeW5F?=
 =?utf-8?B?YUpvQ3VsNyt2cmM2VHI0KzhFb3ZtRTJOTjQwdm1xbEMxNUtWa3dzMFlibjg1?=
 =?utf-8?B?N0paMU1ERkxnZVl1MWdLckV0eFFnMVRIQnpDdUN6M3hKM0xwb1dWWFNVVHlw?=
 =?utf-8?B?dGdmUWRpcUQyNXV6RWo5dVV6RGpvLzJYNUUxSzRJMEpSZk1CTW1MdWUwUHpY?=
 =?utf-8?B?ZTMvbHI5dnRVanVQUlcwZE5BblJUenArWk9sWG4wUEpHUVNZZmRGZkp0dXIx?=
 =?utf-8?B?aXJLQ3p6RnJHcFIrUEFhbUpybjYzSEFKNHlTUG1HSnhBdXc5dTZLWE9NQkt5?=
 =?utf-8?B?ZXdqM3hneUpNV3pwNzZ3VWRtNmE1UHpIbFhMUTNEN0o2dk5mS09hMmVlNEdp?=
 =?utf-8?B?NWRxdzc3REZjMmpTQlRpQVRtNE9mZWFMS0dBem5QQ0RIc3I0MGJiMWEzSDU0?=
 =?utf-8?B?c1Y0cFRIdWdoZCtKV09JSTRudDRRUDFHV3BYdXZmdEV5NS91MGJONUNaWHJy?=
 =?utf-8?B?VVlPTFRQRmhyZ2lrQmFKUlEwc3VrQlhJYnpSWjhtSG5JS3JGaXhpc0NhRmFk?=
 =?utf-8?B?SFJFajgvUlFQd3Z0R0Q1QUMyZkZkRG4vRFN1KzhKNHV4c3Byb3FvWVVDcXVW?=
 =?utf-8?B?Vi9WdSszVXRJQjFma0Z5cDloTTM2QTUyMWMwOW5sa3ZZOEdlRFZwdmhLWWJT?=
 =?utf-8?B?Si93LzVpbnd6WkZIZUxvb29GNkREbmJIc0pST2p6c1JvNzNvamlhMWNId0l6?=
 =?utf-8?B?MkZ3cHpNazN3UWtNdGVOQUVNRDBTbkJLNUVUMTc2TnV6ZlJ0dm00NVJrZ0do?=
 =?utf-8?B?bHpwd25INnZqZDZ4UGtqM0FDdXhFY2ExOGV1VkdDREtMcEVzSWdRaGFITmc2?=
 =?utf-8?B?a3hJWnNZWlVXZ2RjR1lEcnJhd2s2Z2ttZnU3UGZvL0dSV2JLbjhqQnJaRTJZ?=
 =?utf-8?B?VUp3RUxJamVTUGI2ODhMSkp6cjVtL2tNa1VFbWhhQ1I4enVIeTNjakp5MGww?=
 =?utf-8?B?WVVzbnlpYUt6UGZEa0grRmt6YUVidjVuUnI1WG9XRTRFQ0l6eUlSenc4ZStY?=
 =?utf-8?B?SnhOa0xKNStsRUxheHlZTXpoSlovTktaMVUwZWgrNUtRRnB1OUZ2TUlHY3E3?=
 =?utf-8?B?KzVpYzQ3di9GeDRUTk1aUkxCanp3a2p2YmEzUmo4aGhIM2h6bUxocFZnK3A4?=
 =?utf-8?B?eVNIU3hGMzFFd205VHRRam9aTVd5c25LVFVWd2JJN0VUVUdiQ3BFQm5FMzBy?=
 =?utf-8?B?VXcra0VQdW81bGo1U1NPNEV2akxyNmZQZ2dXTXNnZDZnWTNuVW0xZ3ZLeUxL?=
 =?utf-8?B?OVdVVjdtTzFOSG9jaEp4M3FDL2lmSUhXMVJtUzUvejhUODJXMzNZMlRZK1FH?=
 =?utf-8?B?L2swRGhzam5RUFVOOXdaU0ZRbE9zdG56VndUTE84d0VPNEkyU0Y1TmdBdlJr?=
 =?utf-8?B?YUUxdWxjRlc3YUc2Nk41VDNVd29TR0NhcFZKWjZwOWlnOGVvZjQvM1RDWnJN?=
 =?utf-8?B?VVo2RmV6VDZFenB3NlFHLzl5MUthTDlJay9tZUhOcC9abW5nM1pqMEw5dmxY?=
 =?utf-8?B?eDVsb0F2TTVKV1JNTDBjQUUzSER0OXRQRURzeklEOE85ak9CUzE3eUVxOFla?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de28b72-743c-4f99-4872-08de05344813
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 23:58:44.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /x9HpVvaVsSoE0UVTmopwJZxy0+5XVjPc/W9/UXqBSeqLVA6EObLfzsGox13nOPpoeHDFv3vTbC0F0bs21TUkCHGGXaLcU2+xWWagaTbHyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com

--------------F5A6abojKOgN7iAzE40edZj0
Content-Type: multipart/mixed; boundary="------------9Egxja0bdnlkz5XaDO6j69mB";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
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
 <joshua.a.hay@intel.com>, stable@vger.kernel.org,
 Rafal Romanowski <rafal.romanowski@intel.com>,
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a4bbc8e2-06fa-4df3-a907-66b6b6c92723@intel.com>
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>
In-Reply-To: <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>

--------------9Egxja0bdnlkz5XaDO6j69mB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/6/2025 8:27 AM, Alexander Lobakin wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> Date: Wed, 01 Oct 2025 17:14:10 -0700
>=20
>> For idpf:
>> Milena fixes a memory leak in the idpf reset logic when the driver res=
ets
>> with an outstanding Tx timestamp.
>>
>> Emil fixes a race condition in idpf_vport_stop() by using
>> test_and_clear_bit() to ensure we execute idpf_vport_stop() once.
> Patches 2-3 (at least) triggered a good bunch of compiler errors in
> Tony's queue due to that XDP and XSk support for idpf went into net-nex=
t
> already, but these patches weren't rebased and retested after that.
>=20
> Thanks,
> Olek

I've at least fixed the compile failures on whats published in Tony's
dev-queue for net and next now. Thanks for letting me know.

--------------9Egxja0bdnlkz5XaDO6j69mB--

--------------F5A6abojKOgN7iAzE40edZj0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaORXsgUDAAAAAAAKCRBqll0+bw8o6BJ/
AQDZ/ncx1O64glmWCTYPdpw/OAKq1u9aDN4ddxH3aKkqngEA2I8rc/kvUIpQ/1cxjwx/Ae3Jp+mV
t/t5CBATHks5TQA=
=bI1m
-----END PGP SIGNATURE-----

--------------F5A6abojKOgN7iAzE40edZj0--

