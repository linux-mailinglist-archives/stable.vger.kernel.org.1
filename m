Return-Path: <stable+bounces-183495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C3BBF9FF
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 23:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462553A57C7
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80D2264CC;
	Mon,  6 Oct 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vb4aQRi0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28A7E0E4;
	Mon,  6 Oct 2025 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787856; cv=fail; b=TNDnjrVA2wBpXNfDrX7kuKD58ZOIolwOHiZBW1rnu0QjBEHEd0CEIbqzrTPej4Tac5uwdT49nicN5TmxNWEeoYps0EK0GwHkOWD80Fy/9hda7jeoo5QnI6nRYkMe38XlzrcUJ81P9mpStcEyPfeJZX2GFLwsXD5V1ckE/fmw1Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787856; c=relaxed/simple;
	bh=68aKUKOnMSf/UGvBRi2wXjwD/lj4pPX7VUmxNFbYWPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLf5eAY32ybi0N/cMlWdSlFZSwQna498f074jTIBJtqeL7I2yNkxod0vY0AhHM1KqU9QfqWOrlOElYb6BhBzfqno/ILKriGC/EQyuq2VyT5a/huavEFq2vda6LZtvmTUgGefr+lYm/nk/4DEBcOv39E5ppvQ0Kwn/HFG0dPMWCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vb4aQRi0; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759787855; x=1791323855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=68aKUKOnMSf/UGvBRi2wXjwD/lj4pPX7VUmxNFbYWPg=;
  b=Vb4aQRi0eplhhmsGTzPrRMz5DmWgCuUDWEZAs02bD2ynwWVAZnu4iDjM
   S3HVVvuc9pDxDN6EA44V4x37kcKG4RWhgGVcpq2hK/mtheX7ZoQzilUMA
   6T8uQgbKIXwtkEZg2SAfIw0Bd3k1oe4TcEBGfQhj88fuZkchOLlU+E3it
   DWXabo5KWbz4dA10FEXOtrVMsqFrtqO4eyh8+p2uQs5LZkL2FPhxEjEW0
   NgzhSj1VqgtToS58kQ+ssGhR52rA4Uv0HKS6Y3KPDJtlDQLLk5Lkz8/lm
   pyFB4EjrmGj7FeWMYJIZ+SeusbzLqZnbqeVWym9+BQrz+fb2xWF199vph
   w==;
X-CSE-ConnectionGUID: HstalItrSPaA+iSbXq6zKw==
X-CSE-MsgGUID: yOTjwsBVTRma2XsYj+oqow==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="49523913"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="asc'?scan'208";a="49523913"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 14:57:34 -0700
X-CSE-ConnectionGUID: Nzemy1P6QAmIqeEOTrs/YA==
X-CSE-MsgGUID: 4o/q4RMOSQu51jSoucuD3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="asc'?scan'208";a="179916062"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 14:57:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 14:57:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 14:57:33 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 14:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFMyd1jXuIT7mRlkMSaLob2T+GIdU5kwH0KhuP3B7Mu2fWzWk9RgYLC1o9ZaZY3/7sTSDhWX4XiDf4csae54Og//pyfXILgFhdgw32wgc3a1aHr00fCzpoBsertDh6DJzUDdubrAbBdtK9fh0wqeIdJ60YWgxmpkBFB7lWsIv90D/4tPvr/jKW42/PGFp/MQA0ijov1+YtC8WxfzWCs1EdWTJie2QLY7J/0vHs/T+X23C5XVqAU072MgPHu7d4wLPA5VaCNpBUw9y/qB7aOLJeLwJj50LV2M+5qIBpnHRaJZEcrPAknrEfKlhDbGbPETVWchmFolbWZeERJCg4+6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68aKUKOnMSf/UGvBRi2wXjwD/lj4pPX7VUmxNFbYWPg=;
 b=AfUhVtT73dNn2U5Xpeb2HSP7nNwo+ZEv7XM1GIlhM+ZwBG2oySbs9gQl1yXtBxI3pX4sj9bDx01Jtaa668KzHVgD/BTzEkWq++P40Cdh+wvT0XpZ2cHtscnN5EVx7ve1Gq6567BHsQBlYoHx25dAefjxxlgkdA62xGJ2+SiOQi+iXwFzJRcknHknG+ElDOalXeEVu2eSO4pHBIbCXwAOxZRD4D8uaLvK0dEuZrrWodgnyUnVHGwh30eCMVAGgfB8JmQ3Ds28HtxIsywRTgfuKN05pNBYH5dudFpFnTrjRdMocB5q+TOtHjULfnlL96t4pU4As23lnm0eXuhrrwepzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 21:57:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 21:57:24 +0000
Message-ID: <27d67588-ac9a-4c20-8c71-523787da78c7@intel.com>
Date: Mon, 6 Oct 2025 14:57:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
To: Simon Horman <horms@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Emil Tantilov <emil.s.tantilov@intel.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Willem de Bruijn
	<willemb@google.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "Phani
 Burra" <phani.r.burra@intel.com>, Piotr Kwapulinski
	<piotr.kwapulinski@intel.com>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Anton Nadezhdin
	<anton.nadezhdin@intel.com>, Konstantin Ilichev
	<konstantin.ilichev@intel.com>, Milena Olech <milena.olech@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Andrzej Wilczynski <andrzejx.wilczynski@intel.com>, <stable@vger.kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>, Koichiro Den
	<den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
References: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
 <20251004165623.GN3060232@horms.kernel.org>
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
In-Reply-To: <20251004165623.GN3060232@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------kK3LN2YzGnwcDKfCxs8s50L3"
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: b50a48e1-db2c-4ae6-3e57-08de0523551d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Szk1eHN2Z1dPMm9MTyswanpHb1lkcENjOEppYWNEY0x3V3BaVWljeDFmeVQ1?=
 =?utf-8?B?bjRQbm5Ub2FpMlgvR29oSkZkWjl2K3pkdXhnQTVoQVdiNXNRME5FLzZMVUVY?=
 =?utf-8?B?ek9DcDc3QmpTVXp1cU12TXBPSG5sKzlRRUI5RHNsdnU3aXMrWVJIbnRXZmI1?=
 =?utf-8?B?TWhsR2hDS01TNmpDZlZMbG5MMEFUcXJvQUtWYmNYR0ZZaXJJR1kwWVNDb3F3?=
 =?utf-8?B?RXh2WXFES2VCUGU1VExDZy9ycFBJSzdGZUN2VmNIZ29IdGNPVWNzU2JLVUhG?=
 =?utf-8?B?VE82QmdvQVhYRjFVNFlMK05GSHRrMTF1TGpEbG9Fc3AxbU8wUERhVkJRY01H?=
 =?utf-8?B?MEs0Sm5CQjFoYXVuS0RTaUVPcnE1YlVqbVVXQjJPdGhaWko0SXNtVkZ2VTE3?=
 =?utf-8?B?cnFtaW02RUQ4RXVkOVRGZ2hKV3RmMVFBTkZiZ1kzNUF2UWgzNjV6ZVQzanJV?=
 =?utf-8?B?bTB5ZXF0UzVTMHpJNnVhY3czcHlJV09NNnhFS2gyRzRXaExXMk1HTTFhQ2NC?=
 =?utf-8?B?TU53QmZEckZsaGI5b0JtN2ordWR6WjQzSmFaVHNZOWRJWHhKM2o5emU4M1hn?=
 =?utf-8?B?SmZZMG00aGpDSWV2ZkJwSUFMSDcrWXFIRTBIWUtyNzJ2US9iYWtXaUhJZnlk?=
 =?utf-8?B?TEhpSGlWNldOWldMQkU1djJ1Mjl2emJNL2ZNZ0V6SUgxeE50Q0prUVhjRlRZ?=
 =?utf-8?B?VG1VbkRkemIvcnRmdmVTMEdIclhEU2wzTW5UTmpoMTE1VkFZYVdUTnVZR0dF?=
 =?utf-8?B?OTh4dlVsV2ErRFlSZ0xwWUtOSno2N1lqeUlYeVM2UWgvay9GakczOXZXc3M1?=
 =?utf-8?B?S0RTS0xWcEVoTUV3eW5sV2FGWnFOdmlTdGNJRHlGb1k1aUxBcWl5ekZIT29G?=
 =?utf-8?B?UVZDYU1zQzUrbXdHU0NUY0d2NkxSTFVnY2tMcDFlYVRGZzFESlR0aENsckRE?=
 =?utf-8?B?dFdtOTFCRVNmOGlyQndDNllnUloxR3FyUDREZUZaWU5VaHVOYTg3ek4wR011?=
 =?utf-8?B?ZWJwWUhTZmJ5RUZEbWRUZHV1UVJ4aEtSeWYzN3lGdU10azVZQlEyM3hwZFpS?=
 =?utf-8?B?UWJQc2E3akNWa3hTT1dka0thMlNGL3VoODhDN09zQ2dMdjRVYW9wWmZUL0dN?=
 =?utf-8?B?d0xxRnVBQzV1eG9oQlNjZjE5TUdPN3FUSzdqM2x0U1kwVDArUkk3emZsdjBM?=
 =?utf-8?B?VHBreWlRdUJkNHZHS0M1MGcvYWFmeHIySklsclJCMGpHTExRSDR6TkQyRjdJ?=
 =?utf-8?B?UXl5OEVvQWh2ZzV2cUpUY05DeElVQm5JemRwODYxa2l6T2dNUnBKVTM0dDA1?=
 =?utf-8?B?dE5rL3RuaGpEZnF1bmloRXNoN05BRUI4cGUrVUpRZEtNOVVBcFpRa3kyRFVj?=
 =?utf-8?B?Yy95NERacHNYNmMzTmhaYVp6ZEJvSW10RzBwQnBLT1BiUVlzRGZ5TjJjbFNl?=
 =?utf-8?B?Z3RUTlc4VnJwbmQ0R1NMNDVGZjRCaXltd3crbE8rQkhEalo2dFpybzdyMlJs?=
 =?utf-8?B?Tm45czhMRXhOSi8rN3ZtYnJWRFFpWVY0bnJPQzBGR2dLYVkrRUtTRGJ5WjAv?=
 =?utf-8?B?K2tZd09ldE5OdnZhc0wxVTJBQXBsY0YvRmVJbk1ocjBCQ2ppUjZKRklxa0d4?=
 =?utf-8?B?bUJuQmtOTG5ZMXJWL3MzeFc5eUhBNWFXaGMvbTNNL2ROaTNOWWErOXowYlZk?=
 =?utf-8?B?TDBkZXRELzI0RTd5RUxFSmlyMUd2UDl5djFOZzl2NUw1OTIzemtnUWVoRE1v?=
 =?utf-8?B?Um4ySGViZkhEeFpiM2dyOFBpTDY1Ti9WNUdUWFdUSzZSUzZxWU9NREs0a2d0?=
 =?utf-8?B?amhHMVFtS052RzlMa2FSRTBpWm84dXo2dkxidGtiaVZMNUw1VW9oa0NkS29V?=
 =?utf-8?B?eGlVa2g2eXp1dGczTmpSQWpPdkt2VkV5TTB4aVF4MUZaUGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVA4aVdKN2x0OHAvRCtiMkxSaVVpaTluTmh5SlkxcjNQSTkxMWs0enpoUTMv?=
 =?utf-8?B?RFkvYS9TbHVVMFMwU0Mwcy93Q2cyRnhlYVI0a2haclV3Y1Z6NUtlZXp4b1BN?=
 =?utf-8?B?MzVuZ1dRTHRMS0xhZ0djV0RUQXlTSnlsUVB2KzN2YTRqTGoyazFUTldFbzM1?=
 =?utf-8?B?YTBSVGpES1MxbVFRN1dlaEF2OUQrK1grZDZhNWZ1aHpqTCtGbDFRQlJiNldG?=
 =?utf-8?B?bU5BQjNRN0dqdHdNWVQ2YnI4WDVJMmQ4VWdTT0dveENySm1ITzdrc2hXazRl?=
 =?utf-8?B?ZVE1Uy9MTGphcDZ2Z1ROZXdTYTlieUVycExsZXE0QVFZLzdoa0JzUzJ0alVS?=
 =?utf-8?B?b3JYeldJSFhXY0J3b2FCdjB3WXlhT2YzMTNVeWdiaG4zRTBiVVRmZVFCQU1w?=
 =?utf-8?B?ckpoWFlHc0ViNU5JdEFBOWlkNy9LS1g4SUpBdlVuVmxiVndlQ3hERElGc2Ey?=
 =?utf-8?B?SDhhREVyYWtDUThIM2lnQkF0K2FhYlBaZlhXd3BPWElFdGt5bklzWW5uQlJM?=
 =?utf-8?B?VGJhckhjSlFVWVJxNksrdDd2ZDhHMUZmT2g1c0Uwem1oNFVDY2xWcHZ4R2Fa?=
 =?utf-8?B?d3k3WFRUZUhaY1BxMGJMTnhSVzFsUGFTczNROHg1elRmTUsxSUluNHF1dllU?=
 =?utf-8?B?djVPRE9iYSswUkZiUGV3bFZZUC8wM3JRSEtFZkdvNkNpZnBOKysxbXIveXZ0?=
 =?utf-8?B?aFgwZ1JOMktvMXdyUHEwQlNKNE9kQ0FJaUhoUVZXdnNMbkwyVkE2cFZUUXhh?=
 =?utf-8?B?ZXp4bkw5ZG5zdzl5Zko1Z0I3WkpPVytnbFBva0lrODA5bmx3K0lObndGbXJp?=
 =?utf-8?B?eE5UWmFKV2NWK2VET2xoV2pOUFd2NEFQWEVJVDF5YW1LN3ZTMmFOYTVOUWdu?=
 =?utf-8?B?U0E4U2RiN0lDcHllZHFuQ21qbm1Nc2d0cGdMUzcrL0FIUkFsVy8vQ1ZXbWFi?=
 =?utf-8?B?MjkxRmhvYVBvR2QxME1vYXdrb01SRmcrelBmMVk1L2hkYkFvSituNzl0elZP?=
 =?utf-8?B?N0JuTWJEcWhRUEY3cVRheG5qbTh6YVdiZ2lLK2duZ2x6VkptTElQRC9xOCt0?=
 =?utf-8?B?Y0FWYXNOUWt0azl3bHE0T1hNZUwxbzRaSEZHVkw0SmZ0ZXNxMVVPajNudERP?=
 =?utf-8?B?NEswbFoyZmlpVERpMldxQmpjZE94VFVaT2V4Z1c0blBtNGNoVUNidW5OZnNS?=
 =?utf-8?B?K0pkTnZhYW9pTzh3WW9EaGlUWTdvNUtpRXdKVUpvTXk3WVd5TVVhWWt6Y1Ri?=
 =?utf-8?B?QlhPbXM4WnBqWURPK3pQZEYwRmpPa3M4dFYzbkVGSGhLYU9pdmhxdWZyaEI1?=
 =?utf-8?B?aEdqOFR0UUljcVpCck5jL1ZPNFJoS0UyNGEzb2lQUXZISzZQS0FJOVpjUkZM?=
 =?utf-8?B?ZEdEVzA4MEpUT1h6MSt5VXpqeUhKdnVJaXVVZVp4ZVpaSnhRYUE3aFpmcFA0?=
 =?utf-8?B?UXNGbHhxT0dIc1ZyTGpaLzNKWlpHSjV4aVBRZmlyQ3B5eWRoZHUrMWhrbWdV?=
 =?utf-8?B?M1hDcDJSMWxFREw3MjVJY2ZnTGEwamdZNWdWK1BzWTI3c255alNOVnhXNHVk?=
 =?utf-8?B?ZXZ5WENtTFBvTzJxMEJVRWw2dERGbjJwR0JCczkzYkcyOGxJUm9CemR2SkJi?=
 =?utf-8?B?MExmSkNxSjBvVTErZDNLV1dCdm1KWTNoOUZndEQ2clZiU2RVeWVIelJHYVBh?=
 =?utf-8?B?OU11a1lDOXNRRUdmbjBOV0pSaGNPOEM2aTFkVXBvZkZFcitERHZsNUg3bWVR?=
 =?utf-8?B?N3RNaTMyRWQxWGo3dklJZlArYkNCRnc0Rzd2TDZueWcxVUJSanpoNUtZUEx1?=
 =?utf-8?B?L0hSbDJmN3JReExZam5BK3ZnNUFwa05yeCtOQm1ESEx0TkowRmpLdVJmR2ZW?=
 =?utf-8?B?NzlaUWhFR3ljQlYvV0ZVN3haSnpudHAvTXZ1bitLdXRhWm5mWkRKV2JMd3hj?=
 =?utf-8?B?MGZaRlc0b285ZVZYTWFUL0kvek9qNDcxNE9BYnZqWkdyTlhvRWhDdWdiZnlo?=
 =?utf-8?B?cTdkMDVzNjM5aEhvcTZFanJRdTZ3cDV1TTVwclZIYldIK1FncXpsVEFTejF6?=
 =?utf-8?B?Q1VvRVp4SSszZHZrYytmQWpwejU3MWVPRTc0ZzVaSW5ENU4xeVBkVldXTFY1?=
 =?utf-8?B?QUZUYURtb3RpN1pXOXpJVU0rV0tqN0pEdkIwSkRxTzJ3SVNEMkRoOTd2aE9r?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b50a48e1-db2c-4ae6-3e57-08de0523551d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 21:57:24.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGkNZ6G5gUDzS0cSIHzYQxJuWO1ryzx65erX9yVKk6OITQpmmpcmCurkPHX5ux/+owNbl4rWWrPgEN5H2HCwpoT7SPquPWJzM29vE8M03+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
X-OriginatorOrg: intel.com

--------------kK3LN2YzGnwcDKfCxs8s50L3
Content-Type: multipart/mixed; boundary="------------qGzjPgfVbiCNeXjU5a0XsxxM";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Phani Burra <phani.r.burra@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Anton Nadezhdin <anton.nadezhdin@intel.com>,
 Konstantin Ilichev <konstantin.ilichev@intel.com>,
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>,
 Andrzej Wilczynski <andrzejx.wilczynski@intel.com>, stable@vger.kernel.org,
 Rafal Romanowski <rafal.romanowski@intel.com>,
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <27d67588-ac9a-4c20-8c71-523787da78c7@intel.com>
Subject: Re: [PATCH net v2 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
References: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
 <20251004165623.GN3060232@horms.kernel.org>
In-Reply-To: <20251004165623.GN3060232@horms.kernel.org>

--------------qGzjPgfVbiCNeXjU5a0XsxxM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/4/2025 9:56 AM, Simon Horman wrote:
> On Fri, Oct 03, 2025 at 06:09:43PM -0700, Jacob Keller wrote:
>> For idpf:
>> Milena fixes a memory leak in the idpf reset logic when the driver res=
ets
>> with an outstanding Tx timestamp.
>>
>> For ixgbe and ixgbevf:
>> Jedrzej fixes an issue with reporting link speed on E610 VFs.
>>
>> Jedrzej also fixes the VF mailbox API incompatibilities caused by the
>> confusion with API v1.4, v1.5, and v1.6. The v1.4 API introduced IPSEC=

>> offload, but this was only supported on Linux hosts. The v1.5 API
>> introduced a new mailbox API which is necessary to resolve issues on E=
SX
>> hosts. The v1.6 API introduced a new link management API for E610. Jed=
rzej
>> introduces a new v1.7 API with a feature negotiation which enables pro=
perly
>> checking if features such as IPSEC or the ESX mailbox APIs are support=
ed.
>> This resolves issues with compatibility on different hosts, and aligns=
 the
>> API across hosts instead of having Linux require custom mailbox API
>> versions for IPSEC offload.
>>
>> Koichiro fixes a KASAN use-after-free bug in ixgbe_remove().
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>> Changes in v2:
>> - Drop Emil's idpf_vport_open race fix for now.
>> - Add my signature.
>> - Link to v1: https://lore.kernel.org/r/20251001-jk-iwl-net-2025-10-01=
-v1-0-49fa99e86600@intel.com
>=20
> Hi Jake,
>=20
> Maybe I'm missing something simple here.
>=20
> But this series doesn't seem to apply to net due to the presence of
> commit 7a5a03869801 ("idpf: add HW timestamping statistics")

Hm. I based this on net when I created it, but I guess I was too early,
probably before a tree merge happened.

Will fix.

Thanks,
Jake

--------------qGzjPgfVbiCNeXjU5a0XsxxM--

--------------kK3LN2YzGnwcDKfCxs8s50L3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOQ7QQUDAAAAAAAKCRBqll0+bw8o6F1k
AP9UIUc9Y7WiFg1W7E7xLLEFzUBX/+FyO8hCBrtOjEs67AD9FqcGenqz9ZZMJAiNl4ymVCnOXXxr
itFjXnaPpICUMQw=
=eP7M
-----END PGP SIGNATURE-----

--------------kK3LN2YzGnwcDKfCxs8s50L3--

