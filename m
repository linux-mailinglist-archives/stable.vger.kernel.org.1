Return-Path: <stable+bounces-183496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E82BBFA1A
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 23:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3873AA2E4
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1D1F3FE2;
	Mon,  6 Oct 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTGLrk7H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409808F4A;
	Mon,  6 Oct 2025 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787976; cv=fail; b=mQtedi0UZ7TYV07AQmQ0W8GyLtaUMtWOuD7UF2/UbeCXWlz7PS9MFCFxxyQv2BD6aSEsbuYthLnn2icVfm+wFsuIiyX+SVBsc18S93jl/iax+cDyU26IWOggYp0vZnBk00z3xzLOJmuEDvj3lNaIhK1arSRlTWqQR1LvSuNQ9Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787976; c=relaxed/simple;
	bh=Xqma7zO4xxm5y85uGVto1tx7bXpwhXg8VQcHfCjS5D0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SnHhlGP+7YTbbgGcG/C1O9ILc+2GS4RU+NH5Avj6p4b2V+E13/p4BR/a7DgF6B2TB2g8ajjnK/WiQoX4Bu9zXRjOoz9ZBNJvqol+1opj4ktxuNRIBK6Bjrla10yams9/qdhhWEQPNxn6aO+NuO4ihV6yYNgraSyH3PwNyNdmVzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTGLrk7H; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759787975; x=1791323975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Xqma7zO4xxm5y85uGVto1tx7bXpwhXg8VQcHfCjS5D0=;
  b=CTGLrk7HCGJUTcQfGY7EPIB20ZPBCFPFxyeotl5DoVBCj7C8OeSYBArV
   EAz6zeY4ccVU1imIdbP0EF4stz1HI0iSD1UXItXe6ILXOp+MkX5Wvrga/
   xQNh9HMK+ynqQ4eIuer71zYuP0rD6JGV5X4KwhbvwpvW/npKuEi2ie9oi
   hmyDB011t2IbC+mF1TGXJYtnp8d/epPzVqxfcN2TJAxucRmHLWB8F4XVl
   GSSY3WWh20sKfz4aWLKssaPa2ihfucKtu0+SCs9wV2Hpj4NA4i+I+39Wn
   5YpV7zwK4hSBpjxomjtNZiIpIlK+gqHMizs7KxTjjBY5JMmgPHccOOBGG
   A==;
X-CSE-ConnectionGUID: xwrMD/7CS/W2SrZVY0gkMQ==
X-CSE-MsgGUID: ivowHV2jQrKfvbri9wdljQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="65819461"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="asc'?scan'208";a="65819461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 14:59:34 -0700
X-CSE-ConnectionGUID: jKjVl3uZRaycSRqSfUttSQ==
X-CSE-MsgGUID: cEaDRMYCRuiCAJzyEmeHSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="asc'?scan'208";a="179117271"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 14:59:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 14:59:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 14:59:33 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 14:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl3cs/llMHHCwX1qAFgxfMniOB/rcRlnw8Wp0F5Qyjyw4z5dXoymBolaAEys+UC2kRPOdilOXN20XKihGpHclfwaqfhZ2ss0386fLN3wyziBwCbTaaKSze1FGhSv6mgNRD882f+lBGyo1OU3eoRc3tDCWIjfSwj79fT5Bmm/kiUADrCcITEttKZU1cAJW58l4KBM+LsCGcR9Kb5d9TsDpmrCCtMXq3ixSjGuWY0dvStHxqcF2XI25q0qGGB/rNWknsfeyL9FABugWdahhV8RoxU7zyophtFgarQOMAUjbOuVrdfNkC3GTttVSOhfJ70Eb8TkEafSJSxfJaIwrxvaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqma7zO4xxm5y85uGVto1tx7bXpwhXg8VQcHfCjS5D0=;
 b=LVyd0s+8jbOKyh8KHfV3Hf8doL5/6g6KpC28bfy4DjsTPI2f6v5nT+/GcpKVKDyFf/U6uALjb8rnvFO+S4yDqEnfll6RjGOfhzsixavi+HdDZoEMKm+Z3rZ8MRnPv7tzdxkKEQb3kj2KEnsBY6A9OtCEP1eCySP0OrEpO6shk2otjVDQQd4/FNQ8e0jyjo7AW81HmSy0lEK2Uy1uP9XObEEtBVILU+UOGL8USdmG/Aoc+tIvAhTEBbwiHRzc8u6AWyNCXo26LT0R2zfS/COSJssN+pY7y6tYMI1r7cj+YgNMT9YEmkVlZK1vM/n1O8Gjy1CLN6xgmhlyxkiI4p6Q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 21:59:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 21:59:21 +0000
Message-ID: <7e70a5ca-029b-4b98-87bc-dd3523776cb8@intel.com>
Date: Mon, 6 Oct 2025 14:59:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Emil Tantilov <emil.s.tantilov@intel.com>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
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
	boundary="------------utoYGtJEtFrjLNN7GVSNcmxG"
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 651d856a-c52c-45fe-d399-08de05239a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVaQWs2cXVBZXl5cWlzK1EybHBQbERPam1YZmRTMFJaalJhaHZ3blV1UmdG?=
 =?utf-8?B?VUV3ZHpUbXF5aDMxTE1xRXhFSGk3MGxET1MvcWd4UHJ6SS9HUHNPSXRtVklp?=
 =?utf-8?B?dlc1V2QzbVVtNTduRXFBbmxxVXJyd01lZkJaOTd0di9wNTQ2M3NFTlB2WmJ4?=
 =?utf-8?B?SlNteE1xSmV6TW5MQm0rVDF4REFOQ3R3WjY1QTNFVUNFb05ENy92SDFSc0NC?=
 =?utf-8?B?bnNVVXR0d2M2TjI3ZTBKMGQvTkxqbTdIVE05M1J0bk5BSTFSdk1NR1NHZ0Mx?=
 =?utf-8?B?WVdMZ29kUVpXc3FGb0MwbUJVSDR5V0NxVS9weE5hQ1NwbGUwRkdFNGQzd2hP?=
 =?utf-8?B?MHg3UVV4ckFqZmpxQzZETFhNSFZPT1BUcnc0OHM2bWc5QVU0RFYxdU9MaTlk?=
 =?utf-8?B?NFlUVVErOUQwNkZnMW9oYVJPSFlTUWp1QWhxbnF6TGl0ZnhYdGovdXpTekc2?=
 =?utf-8?B?Y3Jtd04vUWJRYzBrZUI1MVluSVcvSnFYRHI4VzgzWVhEYjgxcENZSlpObVB5?=
 =?utf-8?B?ZU9uOEd0WW02d1ZCcjYrQjEvem9iK3FicEJWWHgrVW4yV1VoN3hWYVM4OWdU?=
 =?utf-8?B?Zi9TazVEenQva1p2aS90R1NVY2xhMFVVV0VxbHBONTdZUjRXV2UvOFRYenpC?=
 =?utf-8?B?VU9KQkRBeDBCa0hnQkFUUGFLM0FISmRXUkphUTdnMGFKdXdHR3FvdUhCYUxm?=
 =?utf-8?B?UVJ2U0p0MjVicUE3ZmJRRURhOGhBMCtIZWJLZkVUNkFsdmhZcDI2cHB2ZThs?=
 =?utf-8?B?TzlrTFlHV0tjamJBNUJlTlErNEZ2MTZPRWJucEI3Y0NTL0dCTUhPQXFlNnlq?=
 =?utf-8?B?Y3VIWDVSRkc4TmhSYnExdFgwazc2VVFYTkRSWWtLSTZZUWowWmdPRk9hTmVQ?=
 =?utf-8?B?WXBMSTZwSnVmcStOTGE1dTBqY1BaRkk0VEFubXdUSWdaRm96M2tqdXFVaFNa?=
 =?utf-8?B?M1pxQWwwSmRyZjY4Smd1Q1ZwS2l2elhJT005blc0cFN6eVpmb1pxRlJzWjZw?=
 =?utf-8?B?UW43QXlFcDQrL3plZVRsSVVxUmJZbmgyL3VFRFBENUU5UDdUZDJnRmliWTdT?=
 =?utf-8?B?WERWa2U2QWFqOUFwWVJiVmZDcEl3Y2FjV2trVWNUTG5McTgyNUtlUFEvRU1T?=
 =?utf-8?B?S1VOY1BUZm9oQ3RKNFNpTTVYUEJYckd3cno5WCsvRkZQYlo5UFdSSTV0ckxD?=
 =?utf-8?B?ZE9mYUxqeVgyelNjM2dIM2N1QlhOS2MwVU8xV3AyYXd0WlhHdDRKSXB0dlkz?=
 =?utf-8?B?blczSXZ6MXBON095VDNVSXNURVZJTForN3hYU3BHbTBWTHpieHNqbUdGVExU?=
 =?utf-8?B?WkkwbWlTSFM4UjBvSmJjTTBvSjlnREdmcjJUZEZQbGNrNjNwV3JFTFMvQ3ZH?=
 =?utf-8?B?dXdObVJnd2NjbDBrSnZ6VmxQaXhQUTlKZk9GWE8vaU1WYTA5aHZhQytMWVhG?=
 =?utf-8?B?S1FOdnFORUFWNFc0N05XWG1DenZzRDdkamdpNnVMZXE5aUtXcFNMb3FseEpi?=
 =?utf-8?B?elFLNDJmTU9Wb0hIbW5RY3pkOXFmYXZVWDdVcERIeFNDVHd6NC9lMUorRE9o?=
 =?utf-8?B?ME9vZEpqbE0vMlJMODRqbWxRczlzNlI3OUtUTENtR1NWQTBRM1hFS0xmaklV?=
 =?utf-8?B?Zm9UanV1b3Z3VUZoSHM1YWdFMVZJT2sxTUFrVE9pUE5Ra0p0RXlzRTZnNTNv?=
 =?utf-8?B?TE02c0R6c0E2OUk3Vng0NjkxWnhEeVdYR0hndXZIdjVNVitiUXFtQkpvQStQ?=
 =?utf-8?B?VWErSjRVeTJ1TEp3VmJQTzZLNTFFR3prT3lSUTZWcU5CNmR3bUl6WWtXY1hG?=
 =?utf-8?B?Z1E1RXg2d3MzNVlsTUtZWkdMYmtqbkFTMllhRWdQM2Q3NmFjUVNNKzRBK21B?=
 =?utf-8?B?L3RBRmtUWDl3d2x1NVF5T0ZmMFBhQlhNcXB3WlZ4dnkrcnp4TVRUdktKMElQ?=
 =?utf-8?Q?RGVCw68gptEHenyNgBLIdVSKH28KDMAM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjEraEpCVFZLTkd0eTlMRzg0RHkvMk85ak04d0lsT3N4UnBIZUE3eENEYzBn?=
 =?utf-8?B?M3l6eW5WamhOZWtHQ0l2RG10MjNYWDFPaEJSSDMzakwvUnpXdCtSWmpFeWVs?=
 =?utf-8?B?TzFkZkk4VlFwU3VIRG1iaW5OL3pISGd3MU5mR2lDSWt3ZXA0d1B1Mk0yZndI?=
 =?utf-8?B?UWFQcUh3bHlTTGtDbUxGd1NQOVFvTUdDbURydmJPaGtCdGxSMW1XOUZjYk5l?=
 =?utf-8?B?NURtSVdBNHgzWFBCMlZaNms4ZFcyS1FOWTMwRUR2TkNoQXY2UEZMcUVpdXlC?=
 =?utf-8?B?M2tWNWlveDhNcGZPbnZDbzJwUnlYMXlYSzM2U1VDTlMwcnlvVml6M05qalpH?=
 =?utf-8?B?a3hwT2FDTmk4eFNSRW9qVHlkWXhMcjB0U0FMQWNHMlBQcndrYXp0SFpPcmts?=
 =?utf-8?B?ZGliTS9yY0t2djBXV3NqUCtLU001YnFzOURKaElxSkQ2enA4WVE0Ky85MjQx?=
 =?utf-8?B?OGRjUU5nVGZVYVNVNVBZeXIvc3ZkaDJweTA1Q2xOWnpVYkxiS00raDFEVFRJ?=
 =?utf-8?B?T0M3aWd1RlJ4bUFYb3pLVk5pejJjaTk4UDlhQlhFVm5BQzFnZGlvWGUwR0JK?=
 =?utf-8?B?OE9yN1Y3UnE1YW90Y2E0amUxQTBDdElsSDF1R1k2eVdDN2RvbXZ4QzhsTHlw?=
 =?utf-8?B?QVdURUxpeXIxb21RRUR4UnppTjhmS0pCVGt1NXVxRmZDemV4V2xicG1OZ0FD?=
 =?utf-8?B?SWwzOVgvTkN1ZkVzV2hLYkNQWG1TSUNaU3NvK1pTT3lCNGFrM0pzV3pLMU5Y?=
 =?utf-8?B?eGFRUmN4eW9Dc3h3dVl3L1NtcWRERzZlOG9xQ1R6UERvUk43L0xaS2c4MEZP?=
 =?utf-8?B?VytmYkhhdWVDSUs0UnFIUDVTb1ovRUk2Q0h5UUMyS292ajlRZVVMWXhuOTRW?=
 =?utf-8?B?TERMRURKTW0wb0FyczFMNWpWU0ZKMlhmU2xCK2NIT2lrcGY4T3VINnUrQzRI?=
 =?utf-8?B?bEgwa244T3Bsd3h3L1RMd2I3T1ZxRmtSZEkrUENSNi9LWm5iWGNlZkgxQXVh?=
 =?utf-8?B?MjY1VllkQkp4c25CQ05nQ2FLVnp0RkhOZENwN2ZydkNkdU02ZnhNODhhaFdz?=
 =?utf-8?B?RnBCRlFQUmVZTWt6cGFPWFBoSzdadE9saEo4ZldZNlJSamkwS2dUTVFYd3lE?=
 =?utf-8?B?c3dETjR1bnZEUlBURC9zeE9mSGRQQUlaS1Y3TDJWWWpDQ1QwbkY2ZlY3MFdl?=
 =?utf-8?B?WTBaRlZXTllxbklaVWlKL1pPZm5VUk5ibHd2NWZUL2NzTDFseUh0TnA3UEJZ?=
 =?utf-8?B?ZHFXRGpzdVRBT1owL0NMUUk1RXB0WDZGVXhxTXdCT1lpVmJ3VUNQVkJqSkZN?=
 =?utf-8?B?cTB0dW1pNWJXTzJPL0pNRnc0YzVpWUp1T0hKZ3VwMWIwUFh6Mlc5cnpXM0pT?=
 =?utf-8?B?bmg2RldRT09qT0wxWW85YVZvSXZ1MUltZytkRnIrV2ZrTVZvSVdxbDkrWkRM?=
 =?utf-8?B?UmNyc0o4bzdOdG1rWkYxdGUxOVFKR01RZVNMYTlVVlo4L1k2YkFCWDdrRjJC?=
 =?utf-8?B?amxNZ0xKOUl2SVFJdkM2VFN0L0czNWlRZm9rSENlS0dNVVAyZ3FBT2ZsdEYv?=
 =?utf-8?B?dG0rcVl5cU5pckgxZUdRVklvOHdudTQrUGlDSUx4YUNMQ3R5T1QrNGNRZ1Yv?=
 =?utf-8?B?UTR1SWNZSUJHcG9HQ0xwZmd4K25KVVU5Rk8zRS9jOUdPM0F2SzB3NEdyaGov?=
 =?utf-8?B?SHhnRzIrSFlESUcydjc2QlpKdWZUclN6czJZQk9EcktLSHk2MUxJS3pHNnk0?=
 =?utf-8?B?d3dXMnlsUzR4ZDg0TWlxSkFZTW5kYkJUNkZ0VTBTUzhWcnpNVnBDSC9sNndK?=
 =?utf-8?B?V3V2Qm9mZ2lDY3dMYy9LNUhRd1dSQmlmbEhNNGRSS04vdUNpS1dKTUYzbkxN?=
 =?utf-8?B?dDVZZVA5NmNwdkVTQnpwa0ljNTlRUU5LZFRpNHE3RjNaNDhLOXg4V3dDaURJ?=
 =?utf-8?B?TFl1N0p4dlpwWFJlY0FjQ1NXZ0hubEgzS0Jtb1orK2ZaSVNxZHJvWjZvQU9X?=
 =?utf-8?B?aG9QYlpZbGlpR2IySzVIODhCRXBhS0g5NEpKUHFPenhvN3Z1LzllZlozd2Ra?=
 =?utf-8?B?YzdrWVlUamFGR3ZvaGZKelpMWXpUZ1BOUDlCbUJ5UmUwMTk1Z1I4NS9iaVJM?=
 =?utf-8?B?M1lURkpMYW9vQ09GSHZEVlQ3SE1GVHVXZWVJRXNINGR5MXR6VjZ1dXNSVzlZ?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 651d856a-c52c-45fe-d399-08de05239a9a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 21:59:21.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yJbGkSzP/kPlKJepWq1RQlUiDHDn0NxTASwy0irdawgo2WE3jxjUKeaY0oeozPpYzN+kR0ABewRbuO0vSVGJNUBGOFu2VEz+k0lGG7gy4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
X-OriginatorOrg: intel.com

--------------utoYGtJEtFrjLNN7GVSNcmxG
Content-Type: multipart/mixed; boundary="------------Wst0Vol44sAeE9RCTW4QdU6E";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
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
Message-ID: <7e70a5ca-029b-4b98-87bc-dd3523776cb8@intel.com>
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2025-10-01 (idpf,
 ixgbe, ixgbevf)
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>
In-Reply-To: <fe038b93-8b18-4358-a037-76f4647cfe1b@intel.com>

--------------Wst0Vol44sAeE9RCTW4QdU6E
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

Yep, I thought I had based on this after the merge with the XDP support,
but apparently I was too early.

We have outstanding comments from Jakub on the flags changes, so I
dropped them from v2, but still have conflicts. Working on a v3 to fix th=
at.

--------------Wst0Vol44sAeE9RCTW4QdU6E--

--------------utoYGtJEtFrjLNN7GVSNcmxG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOQ7tQUDAAAAAAAKCRBqll0+bw8o6EpY
AP9UjLR8O7xI9ToHDPrNCe70CU08tVf9KxxYajEy/djncAD/Uw+DD00OpGBkf1fFzjGmSGWxYxzO
kLLDH42pUMzvAwI=
=hQ2s
-----END PGP SIGNATURE-----

--------------utoYGtJEtFrjLNN7GVSNcmxG--

