Return-Path: <stable+bounces-185736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBCBBDBC6B
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7877F4F1997
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62D2D6401;
	Tue, 14 Oct 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnbJI3rB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BB2C21E8;
	Tue, 14 Oct 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484033; cv=fail; b=Yoioryj9m6YBHAkH2UUAWVU5qQI0GmMOQhJWnXDoSY8mIs1W1JxBt5T8JxrxNCIN2d7LZurJ6zP9A3+i1X1QHOMZybWN/TiyQYf7DMg7ilEP5rjqJfSPdH8zPLTG7OM30aYPv8xFcX64qTVbINj39+WyiYclDUSKq4gFH409h64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484033; c=relaxed/simple;
	bh=V0tnNFxaanwT2QleXWUE55lUaRERW9t6BE7PWBF3cAI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnUcEVNf0NyoxPA661Dl/3mIgFOtejuffw1o83QdQgFoPE9DXlHhopHWxrndfWbf5EcDUNR7D6aYqJdCcf2OVCbz6u1J2uCOIdBxE4bVM8h7u+/2BiFb9FYe3mtRoJGt36r2pW5XtE/itJyEFIMBQDOvbrXhsiaPoHTp5sNOJo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnbJI3rB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760484032; x=1792020032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=V0tnNFxaanwT2QleXWUE55lUaRERW9t6BE7PWBF3cAI=;
  b=fnbJI3rBrl800SQaCZJSqNe9zNCbc0XdYknSzvpOim3KM880Iv6OqylG
   3dmd8dmcGqjEX7UUiXGDn/Dc73+c5kgC8mB7EKnxotPt82LMRFrdSbGQP
   BnZ+L/afTlUKNx0Z4GNBAdDd1VESsuWJ7/I08spGtdJLSh45pWyilGFeN
   rB58xcO5bT9IGOEAPMATEH1k2iEW0kBrLcJkd3BC/sSRsRlKEwlcVUQ3U
   3XAUR/WxBgGwKjc0I+FEB45tjWXjRG1WWr80+1iyifzxF1LSCRlzko6/e
   PT0IufUXDOpOVTS1IzlpuRlHSOJaC9JKlXRsRelK7dtjHHGilGRx8LXPJ
   g==;
X-CSE-ConnectionGUID: ckY3B3UfQjigqyDOVT2/AQ==
X-CSE-MsgGUID: Blgabt8kQVuLsSLEh4FsgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66304363"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="asc'?scan'208";a="66304363"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 16:20:32 -0700
X-CSE-ConnectionGUID: 1fPxCBieTJmtYEToyAmc8A==
X-CSE-MsgGUID: W1aEPBJYSeCMIUmKQaEmhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="asc'?scan'208";a="181151133"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 16:20:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 16:20:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 16:20:31 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 16:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPNN6cEu8xDktwTIhE9iZBL97xqCeDwyPftqTqjqRjhBPe4Act0bglwWmnOQQfl0zhVFeg+cItLAOQmsHZiU9K1MuCP9Um7OuFKNrMeY9pA9u8kWgJRl8txxHa1W9wmrIbQ8TeKxcwfEZUVY0av/Uo6HzRMtzgFMJuKgLtKoQiIQRiRG5BvVciyD4zUSMC2jAMT/ifZIQTY+QmFZBbUiOJQF18aJUEsgSEOzKU+2N0+VjU3h2oIXA/td0v3RyDrSF1X+eGDsHAqGfZ1Ci+D2ESCbcewDPaUxMMAUDU4UcJUoLCpAmW68NdXmdwrEwIB1hRXCrroN8HtIchJtw4jq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SspEZ5e/mnGfnb2HhO/u26f6teWgZ/vjlYhBLMaUw9o=;
 b=v9U+p1zND9PveXSiVzUDMg8cYm8gb0VMzOBWQpTynb78gqJPW85EPiy3k/Sa/+wyQBP2gN+kSM4iApZrbS7Ow2ThTg1AAzI2NXtzlq0EhbD4ZYGGSKC7DyItd21V3C5m7pZGVeowG4KxZTXY9xZnptoAh8BpQUAaQtBDWXmnRq79FD0qKFdHL9UJST6AIFbmhIoynrXfdlExClrGfgH/6HiD1yjPTuYreKLqnhNxs7mc2W9MxuV9cUHDtupZrNvLOYPehUo8KZJJjCJUQe+Mo3x2+mYPlWQWQt/a3fFOzVN44atWAxrquNYkmDfzjFlcV3zAVpLYibYLmSeo+Fr5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Tue, 14 Oct
 2025 23:20:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 23:20:21 +0000
Message-ID: <e0a835b6-0c85-433a-8850-75c16062af14@intel.com>
Date: Tue, 14 Oct 2025 16:20:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
To: <patchwork-bot+netdevbpf@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <emil.s.tantilov@intel.com>,
	<aleksander.lobakin@intel.com>, <willemb@google.com>,
	<sridhar.samudrala@intel.com>, <phani.r.burra@intel.com>,
	<piotr.kwapulinski@intel.com>, <horms@kernel.org>, <radoslawx.tyl@intel.com>,
	<jedrzej.jagielski@intel.com>, <konstantin.ilichev@intel.com>,
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<Samuel.salin@intel.com>, <stable@vger.kernel.org>,
	<rafal.romanowski@intel.com>, <den@valinux.co.jp>, <sx.rinitha@intel.com>,
	<pmenzel@molgen.mpg.de>
References: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
 <176040423576.3390136.9978557000620458920.git-patchwork-notify@kernel.org>
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
In-Reply-To: <176040423576.3390136.9978557000620458920.git-patchwork-notify@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------hWfgVZtyXPNaCffkp2JzBV3S"
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 452cb254-7ef6-4d38-084d-08de0b783f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RncyMDlzK3I0d1Jib1Q1Ykl6aTlBdGRMMTZpYUd5ZVh2b0FkWTlKRFhFQ3NR?=
 =?utf-8?B?bStBcCt5RExzN3dISk15NWF3T21WZ1U3UTJNeFJ0Um54ank4SUVZVWFWUjhR?=
 =?utf-8?B?UFZpNzNHdEx0dWphUUpBRy9UYmVCUTNwaHlzZkh3bWs5aTIxQmpQejI4alhY?=
 =?utf-8?B?SE9SeW1zb3VFa3BDcGZqQ2hmT2ZUZjNxUmY0S3pGMHh2THJJZFdkR1hvTk16?=
 =?utf-8?B?Y0F4YUhuRVIveFh4RGZwaTJuam1oc3RVUzNxd3RWd3l6UVA3eHNQSXRVd1NQ?=
 =?utf-8?B?WE9kMHJWR0RhWVpsVVM3bHZ3d2I2RGZQZkg1M0dZeFpMNDZtd24rcnJkZVZW?=
 =?utf-8?B?N0ZNUmEyRW1pUk5nTURhaDRJWGFtM0pKWmljN2ZFZFNrdjU5N2YzcjRVa0Z4?=
 =?utf-8?B?UVVNMFczeSt0a2tlWVBBUElLOEZOQkJSUUlEUUdhUmNzdC9zVXgvWmRRZm9r?=
 =?utf-8?B?SmZOa0hna0xuSkFMcHM4bm1NL0RUNkhnR2dHQ0dpSXJSRVRGdVlLNlR4V2Vj?=
 =?utf-8?B?aTdiVHFhSlM2VWorMm8rUUYyQTRLaE5BMk8wWjF6OFZWeVA1T08zcDRYUkpt?=
 =?utf-8?B?ZEc0aUQ3MnNkdTgybVFaUHVaQVEzejhBemg0WXVzK3kvb1UwRHgraFBuQk5l?=
 =?utf-8?B?dEtKYUdCVzluUFNjb1RHN0I5eDlFSTVieGtUYWZwU3QvcnAybUhMNk9kS2RH?=
 =?utf-8?B?alpDQVM1SjV3eE15RDNhRU1DQmZlREZJZUkwSVFjYnVIYVlibldmcDN1eXRk?=
 =?utf-8?B?bXkvdHozV25qWEhEaXlLemRaNDNFbzNZOFZkM3BzQWgvYWhYa1dYcGZWVm9v?=
 =?utf-8?B?bEpoRCtnZ1RRMUswT0craW9MZDhjMktEMmdGdWlmOENKc3FaQndhelA3VHhE?=
 =?utf-8?B?OXNZNHBGSEZWQm1GdTl5M0N4U01nVEJPVUEzbjhNSDFhNFMrNjQrOFU3VmF0?=
 =?utf-8?B?QlJKbkRUUURmV0VHSWJLMy9TVVh3SGttdFo1YWI5QjlzOVV4LzMycWdNLy9M?=
 =?utf-8?B?VUZDeGUvSTZvcUQ4aGlvZ3NmRU1NZ2dJZGc2UXppMEFHb0tJR2M4cG9yOVdI?=
 =?utf-8?B?NjgrNmtmUks5V0VLMlF5cmRtZkJpRFQzQlVDZi9EOG1PM1M1YkxJMUpwelNX?=
 =?utf-8?B?cmlQdTZnWjNYS1VLbzcvRWxacjN2Z3dUMXdWQXJPd0I2bExmcTYreUhsT05O?=
 =?utf-8?B?OTRzS0NGdE1XS0hLTzArK1JuRG5sQ1ZTTHJPK2hRZmo5Qnl6WER5ck1QbVRz?=
 =?utf-8?B?L2VnMlRzUmhzRjlxUWZXZ0FjMHZJL1NkYlovOUlnVEtZRGM0c2lzY25KRUU4?=
 =?utf-8?B?SFJzdHQyRUt6RkRabTNSNlZIWUNPMFFzWnduelhyaEExbVdPZllNN0d4b3F3?=
 =?utf-8?B?aTBJeUVnVUpEd0dGRkxDeUgxSFZseXJBcVZuSDFoWUo0WTloVFBkN3Iwc1Yv?=
 =?utf-8?B?am9DV0NEcG5pb3JicXowMlg0SkEzVU1CaTFZVG5UUDNKaG1wREFrVWZJN1dR?=
 =?utf-8?B?VGVRODV1MTZNc1pNbUlOUk9hNUJkSGFvbTJUekxIWmF6anFaNmc0WFBDWWdL?=
 =?utf-8?B?Um05eURFR3ZKZi82MzI1SHUxMUJ3UlNkM0VUbldkRUV0WkxqNzNobGNnRURv?=
 =?utf-8?B?Yy9tYkI1NFlDR0xSZXdDMXMySkxma1oyV3k3WDJ2WDBBQkRPaS9pQWVoZmor?=
 =?utf-8?B?UTZPdVNYd3RVbENDMTVEV1UzS3ozY2wySldzbGhya2RSbVVKS25vdmZHQWpF?=
 =?utf-8?B?bW5IeTZoTjRyRGtDVG9LSzNTbXhuNU9ma1BpMzV4NUpuT1pLWXBDUldKNkVl?=
 =?utf-8?B?L3JTYTFhYVcyWklEWEt4VEVEcmU1Um9oUHpyTk1yNytkd1lKRnJENEZZbXlL?=
 =?utf-8?B?ZXZUUWwxSXFDVmFIeFp2Mytoeko3eW01Q3J2c3hGTUN1Y3pBSUNlZUJYT2gw?=
 =?utf-8?B?dzQvdnpEdjJ4c1N1YXdWV1oyRVBJUnczcTNOMW9ycDVMYUE5a1drQ29FS1FE?=
 =?utf-8?B?Y2Vjb3lqcklBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdmWk1Wdkd4c1lxcnFXdWhMV3FTYlZBMmVCcEVPUmwxL1ZqVm5SelVkVElM?=
 =?utf-8?B?ODNkWitBNEc2UDQ5dE93TmhDR3d4MW9PSkVkNnc2a1hWM01YMEZYS0JuNGsv?=
 =?utf-8?B?Y0tubmN6N1BoTVhMaHlJRExqUTlqQ3pUR0VkM2JTdGE2S0U5c0dHaGZpT0VV?=
 =?utf-8?B?UXV5ak4vKzlxQU1qc1dqNWxGZG53UDhNQlRKZXlyTkwzTVFLV0NzTEdYVkQ4?=
 =?utf-8?B?aklqTFlsbVZwWG9GaE9Xd2czVHgwR2V0NmkyalphYXpSZ1AwT1MyakFzanRB?=
 =?utf-8?B?RkVmZGcvM293L3V2ZmE5RCtxTnBhQ0htNjdjem1ONGd3Zm10RitrZUlmMkRq?=
 =?utf-8?B?czlCYXBOVG5EYTZRVzVvRW15aXNjZndHN1FmNmtZVFFCM1dKZ09MRmpOZEQw?=
 =?utf-8?B?SldFZXRkcm0rT2Z5dUMwMlV4SWNvREp5aFlWTHdVUDFoRDdhbjhiUmhEYm9a?=
 =?utf-8?B?eGJ6OTdNa3NxRW92NFFqRG5FQ0dSbzIwN2ZRNFV2N2l0ZmNWWmhHSW1iMW1Z?=
 =?utf-8?B?UDl4dUJIdjBLbGtNV2d1QTgvYkU0eGFhREJOc0k2NmlSblRxRnBtRHVtRVRt?=
 =?utf-8?B?cnNsYnRXVEpNNEtKSmVNL0JQbjVuWE1HamNGamk1OWJnbW1jUStCWHY5L3Bz?=
 =?utf-8?B?SGRTRnpmcmJLeUlVbFpUcFlrMkt4WHh0NXRrbmxFOHFaTkVsVG1MSTMvais1?=
 =?utf-8?B?WkJteUE2bkpzcys1Y1RIQlZOTnl0Mk8vVExKaU1xemRlSHhOK2ViS1oxeGZG?=
 =?utf-8?B?ZWpsR1dNY2JLdmEyb3hSaXZ0Y0Q4d1Y3TmdzK2tmdUQ2cGdrNXJCNXd6RkNy?=
 =?utf-8?B?UlJmSTVaQjJpVTQwcmh3RXVCVm8zbFFMTFdmVGFNUUZOTmNES3lrbXNjZkRj?=
 =?utf-8?B?WnpFRzhabWd0QlNaVzdod1Q4T3Z2NUNJTGZnWmRQZ09PZUxLRTROL2cxaE5D?=
 =?utf-8?B?TmwyY3RkYld2Y3lVWDNmeFFDQkVBVFU3emJSNjVmd2N6ZVFYWVhyaFpHbUtp?=
 =?utf-8?B?d1U0OGNIMzhMVW1CZ2lra0FFSjBnWG41b0U3ZHVxeVR2RTJRdWJhRUFuYXpx?=
 =?utf-8?B?Sk9Tc3Zta1p6dUdSQmZLQVRPQ2lkTXZrVWlIbGczSkI3U1RPdVZsWHBUWjht?=
 =?utf-8?B?aWYyUFRzUzZjVDExTndHVENnM0RsbzQvSFVka2tYNTl3bDBYTVVMam1SbGdj?=
 =?utf-8?B?QmxmNklJTU96ZzlwWEdYemQ1TlgwT1E2OFFTWENkdTVpNS92bDhPMHRoUU1h?=
 =?utf-8?B?V1I5cXF6V2xVRnZFdmlHRTVVVkhid0NOMXE5WkgvUmdPSlFsY2VYL3FHT1RJ?=
 =?utf-8?B?MWE1TlhlOXBISzg3WVhML045aGtUY29Tbm1HUDdpMU9nMTFTd29jUElxZFhu?=
 =?utf-8?B?SzFxR3E3ajZpOSt6UHZJTS9QZk1SWVE5T1o3SWJNeXZHak52OXhoOUdUN0No?=
 =?utf-8?B?MmZCb2JsSlRrRkpGNmNZaEg5TGd0d0E3QS85clVUSEs4cGV5cUdBVTZXdkhK?=
 =?utf-8?B?dUxyT1pCUExaWUlLTkxLV21jVkZOWjNsNkVVWVFXaU1FejR5Y0V0SXkvemEv?=
 =?utf-8?B?TXIxSi9jbnZHZ0ptekpzV0RpcmIyejBSOXJndGFNdllXMjh0d1NySk5pTnRy?=
 =?utf-8?B?dTBldk1mdlBYNWFUOW05MU5zV08yMUxOeGErTzJoNUdPRElxby90WkRnZDhS?=
 =?utf-8?B?elk0VFJYVDRTd1d2SlNTWUFVajVHZWY4ZjFNOFNKWCtPOS9NeUY3WGY3b0Ra?=
 =?utf-8?B?dFpTNXdENWpUaXZiN0JYdlVMTlVuWnk5bEJkMzVTVW5CR1JmbFZvS3lBRFAx?=
 =?utf-8?B?SkpOOWt2c01rd09yM3hQVkFVU3p2alIvRWNnTzRNZ3ZhMng0aE1EWHZ0K2Zt?=
 =?utf-8?B?K1JUL3F5ZzIreTBaaE5CaUZ1LzdNQU9tMUd2KzIxbVdKdTB0ZFN6T0x2QlFD?=
 =?utf-8?B?M0MxblF4S1dUZTVuTDBFS2lNenBJTmRDS2h2d0ZJVDQzRWVTYW9zRE1Ldlc1?=
 =?utf-8?B?VXZiVlBuWEF5RTZCWGd3dHFPQlJIbVo5OTdoYnFySEFOOWdRRjVwcnl2VjF6?=
 =?utf-8?B?eDVBKzcxYUdVSlFqYWF3USsxalRqQVVSM0pmRTRaMk1SK1I4QWhOTGZCN3o5?=
 =?utf-8?B?U3ZlNTE3VWhPTDFrbS9qdFpVNUNZOHRLU3d2Y3Z0SnFNMkp6aHdESHdLSUhY?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 452cb254-7ef6-4d38-084d-08de0b783f07
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 23:20:21.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTI7YqTqM3HnpTNnQMXIGKnh3lvE5I+xJWT0gXnTxrE6+uwHtDoBXRte/3uussKG/eHKk6P5F0Cerf5z1vuUBGGNDY53Y4e10BRY6TFZ5C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com

--------------hWfgVZtyXPNaCffkp2JzBV3S
Content-Type: multipart/mixed; boundary="------------clWd034th0yWxw7fqdmFPtLd";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 emil.s.tantilov@intel.com, aleksander.lobakin@intel.com, willemb@google.com,
 sridhar.samudrala@intel.com, phani.r.burra@intel.com,
 piotr.kwapulinski@intel.com, horms@kernel.org, radoslawx.tyl@intel.com,
 jedrzej.jagielski@intel.com, konstantin.ilichev@intel.com,
 milena.olech@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, aleksandr.loktionov@intel.com,
 Samuel.salin@intel.com, stable@vger.kernel.org, rafal.romanowski@intel.com,
 den@valinux.co.jp, sx.rinitha@intel.com, pmenzel@molgen.mpg.de
Message-ID: <e0a835b6-0c85-433a-8850-75c16062af14@intel.com>
Subject: Re: [PATCH net v3 0/6] Intel Wired LAN Driver Updates 2025-10-01
 (idpf, ixgbe, ixgbevf)
References: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
 <176040423576.3390136.9978557000620458920.git-patchwork-notify@kernel.org>
In-Reply-To: <176040423576.3390136.9978557000620458920.git-patchwork-notify@kernel.org>

--------------clWd034th0yWxw7fqdmFPtLd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/13/2025 6:10 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>=20
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>=20
> On Thu, 09 Oct 2025 17:03:45 -0700 you wrote:
>> For idpf:
>> Milena fixes a memory leak in the idpf reset logic when the driver res=
ets
>> with an outstanding Tx timestamp.
>>
>> For ixgbe and ixgbevf:
>> Jedrzej fixes an issue with reporting link speed on E610 VFs.
>>
>> [...]
>=20
> Here is the summary with links:
>   - [net,v3,1/6] idpf: cleanup remaining SKBs in PTP flows
>     https://git.kernel.org/netdev/net/c/a3f8c0a27312
>   - [net,v3,2/6] ixgbevf: fix getting link speed data for E610 devices
>     (no matching commit)

Not sure why the bot didn't note this one this, but this does indeed
appear as applied:

53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")

Thanks,
Jake

>   - [net,v3,3/6] ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox opera=
tion
>     https://git.kernel.org/netdev/net/c/f7f97cbc03a4
>   - [net,v3,4/6] ixgbevf: fix mailbox API compatibility by negotiating =
supported features
>     https://git.kernel.org/netdev/net/c/a7075f501bd3
>   - [net,v3,5/6] ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd
>     https://git.kernel.org/netdev/net/c/823be089f9c8
>   - [net,v3,6/6] ixgbe: fix too early devlink_free() in ixgbe_remove()
>     https://git.kernel.org/netdev/net/c/5feef67b646d
>=20
> You are awesome, thank you!


--------------clWd034th0yWxw7fqdmFPtLd--

--------------hWfgVZtyXPNaCffkp2JzBV3S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO7aswUDAAAAAAAKCRBqll0+bw8o6CtH
AQDJyT/No8Iq82dMe65Ws9HwHdpCAm991kliyG8joLJ2gQEA6/maepEdWCUBH8zfMWyv/zySRcEa
XYovxBMjEdVUZAc=
=Lvwq
-----END PGP SIGNATURE-----

--------------hWfgVZtyXPNaCffkp2JzBV3S--

