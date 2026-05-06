Return-Path: <stable+bounces-244456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN/zDIGy+2ncDQAAu9opvQ
	(envelope-from <stable+bounces-244456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:28:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2894E095B
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D383017266
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2C3563EB;
	Wed,  6 May 2026 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xl9WHbPy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14E30FC1C;
	Wed,  6 May 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102500; cv=fail; b=jzzXy6ASsm7uG9j4rDEHRa5BsiZ91W62SnKwE2DJVvrCjueQIcqK3nJk0eVf8Bf0ASs9+DiEhNrTo+eL7kVwOA2iOIJKJ4bJHYR7c6mdeOfewWLi7wagZCb8Iuq/L6G38gb8WBPXvrtPOQgGKGt2X5prYXR/2U35CO0RWijttQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102500; c=relaxed/simple;
	bh=sMJLjmps/XEhxFy4sIXlR4ufdvS9iPlNFo2P4hrnSns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzOUpYKEQA30fVxFLqavnCHWYG6rIPXziu8sQkwDxeGSjEjIW+dQnLrAFDJulxewpdT4B2ShGg67A7D804uVUx4HSk6A5y8pMgVr9UtscvAiUUDbLiCVlu9Cm3D+Bhl2ELCKqFPn3okToLcC5Xwkk+S0rwBXe+mUu7OSx3kKEmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xl9WHbPy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778102499; x=1809638499;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sMJLjmps/XEhxFy4sIXlR4ufdvS9iPlNFo2P4hrnSns=;
  b=Xl9WHbPyEsseoNpMfWI0cvyYlP/yKgf9iPFJ/V5gax5fTVj4+kXxepsF
   T2D3fb/M4CnMRqYWNIqguvKHpNApDkGatxTbcZtptCITTas62D04RYn1X
   PoWGkH7c51CHFjw+r8Q+y8+79Gjcn3WJ6V09Q37iCNwR0vVnSjRZWqnsU
   cd6OnsJogJwQCkUds2eh2qrL7TxtItzz9y/gC5djqRKe6e0QkHUEmNTTk
   HEoWi7wrKepro4hqfPl5nBerBN5E9/ujhc/k4MwWCFjfWhm6L3vSsk89o
   5+KVXJ3eW+2Dv6aIrFgPQHig03V9Oq2KjKFsaarGTWmJ8ZKYXc/lS7WlV
   g==;
X-CSE-ConnectionGUID: OOtewSX5Q7iyHhPg67BI4w==
X-CSE-MsgGUID: viN13CwbSzCZK6t6+nr7YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89633726"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="89633726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:21:38 -0700
X-CSE-ConnectionGUID: ZVuNuzBvR8ilf3Bcvo881A==
X-CSE-MsgGUID: ffWqEp8IQVWe2xKjOwvNbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="240252022"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:21:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:21:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 14:21:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtSoLpLIFcXYTpmtX7F+m/rUeF5n+IMhYAbcc3NLFVLod5YjNEkICmAvZOLmG/kzJ8bG0qnqIGinmVSB5atR8g2Kb3FNUvbESwRoziwNguQzv65xVjgME0/bORz9681o2QvoWXJzGvlNHb41DVMOwfMBOiFNvFNnvTpZF5Qg/LDHLc6J7ebeDhKSW2GxYd9Yv5WJ4LY/Nsd7gYBTitzloUwFAwfQNcQMvQyJRLifGTQgq93HFgjEB2RbJ19fMRpTEXJGcz09WYewGfyFh10/XDuuB784sYEkJ1jPNl9pb/s4Ako0l/f0fejjBWeLX1nmt5V+3U6LySwWh3b6c7EieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkNxAkJW9vdyP6GOkxohqzL2pbReotyAYNOEvvCi+fE=;
 b=MfSbbcN9xGHngycc0+lPmBMAQq1XXMkohnRKpBVebzshFcUY13oPgKMkmOcwXxmIC4c42XaJ/HXAA6Qaws2KlUkKhzxwXlyxuUYfz0QbJ7UAgt0/cbK1501Tc1Qe8J4XIaIozehqIL7S6R3uT8hcvBWj9pgKIVvt+qshNbrp74xjzxTSM9WJAv0wGOyenRN6SbcEnEotnNnD7qykX9YcywL0j5JfauLt+7QrOFkTCZ87YhY4z14QVK2bY5i511ViCYB1dmwtqFJMhfHuaWwvd23HnekMOT+nmdHsmTCJeWBY0MTSO3kQW+01JmkJaiovrQVm2fO0zpeIbMgtYBlVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 21:21:31 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 21:21:31 +0000
Message-ID: <152e0a33-af26-4c42-be8e-96f91fcfce56@intel.com>
Date: Wed, 6 May 2026 14:21:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/13] Intel Wired LAN Driver Updates 2026-05-04
 (i40e, ice, idpf)
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Willem de Bruijn <willemb@google.com>,
	Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Matt Vollrath
	<tactii@gmail.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>, Kohei Enju
	<kohei@enjuk.jp>, Paul Menzel <pmenzel@molgen.mpg.de>, Simon Horman
	<horms@kernel.org>, Emil Tantilov <emil.s.tantilov@intel.com>, Samuel Salin
	<Samuel.salin@intel.com>, Patryk Holda <patryk.holda@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <stable@kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Bart Van Assche <bvanassche@acm.org>,
	<intel-wired-lan@lists.osuosl.org>, Arpana Arland <arpanax.arland@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA1PR11MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abbc0ef-8be2-4862-2241-08deabb57117
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zfKxDAvN4r5hl5RUyXRJgYL7LukXn/sNwNcSMgYILtrm8v1L/7a+96p7YCOiJr03gLE1e9i177OnyARvANNNBUTXxGvYfYzh+6WNhgLUhsLj1yJr9NYJ6YEy3lA/QKvODgyqYySZvAn188rvqHOoPiDuO2qhPvm6l9FILH3ApPu/mEa4YdiIHk34SUfWXXiJX3ybKjWlvVN1Jk1NaoqmZWoVySLVv0FY78Sf7HY45GOiDTYlDDTCTpbRsIyOJmvGArBl6dxoTAHUQm4YdUDeOZfO3NiZ7OrTcitjBhvP8Z+2NcImSEHvqHEB3EYFCjDhVLoOwDgaa/E2o4tzJalzXeuS2n6IK3OZ+w2/ShUig564Hgaqg7DFxwQDNv7hqd4ScaFDSI0oP7z0PJZxIl42OfYAbWCb+lzpqql7y7USX4+VCZe6+H9J2op8b+XRx7NdUaErJqgM2tfKml+SmkQjiJpl3HUxpGdLhmITqoSmfS4wzPOyoJw7JsW66KheHtKzjWfncMRhK+vPRuiNtFj+2Whe/8DUX130vxWUNKpoUzsaEJculhoEYhC2WXeuiH4lSpvQC4w1lICOipx+Z3z8kFBjEB/dTiaOwuEjTjCgZUPWoEGH4It4bp4LapkhFk+U/VFoEC7vny7VVv8aEYkfyUsEfT/O6+s+yASF+1olABhpTZ+9xyJwifoCzFDYzOFSsTeH2BVpKFFY2xOClpj85+WAs+Zoedh00+lna2/gE7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpMY056WXBMWkgzNkFoc3lQVDhUQ2o1MFVud3RoV01FWm5LSkNlbCtldmli?=
 =?utf-8?B?T0RhNUtzRHJXZ3Z2Y1p2dnpFS3RKWkFvRnpRZ1lSdVhXSXl5KzFqdVNwZEFR?=
 =?utf-8?B?dkR0dWpYK1JFcm9XNDNJZTNNRkZUcWR3dnYzamtNOFpZQlk2czNaVnU5K0FP?=
 =?utf-8?B?S0Zma3UyZHY2elcwVXhkRndBNndzRmpiWEZEZEYzemJIR1dHeVoxMkJIZS81?=
 =?utf-8?B?UFh2YUcxbnBJMFZuQ0JZbmsza3Q2V0pmd0o2Mnhuais3enlRNGNqSXlmNWJ4?=
 =?utf-8?B?ZXhkblM3OFpsd1JXQjhySHpQWHU5M0MwQjczQjk3a3BLdGpvOFVwa0NoQlQr?=
 =?utf-8?B?MFg4eDdOLzZ5NzNUZVlYR29FMDA1WnhlQmoxdmNlTi92ZFFwdEUyTkQyai9n?=
 =?utf-8?B?cGNNUHo5cWFHVEc3bXptclpTNmtHUlpvcC9LZ1FWT2NTY0s1OWJkRTNBanpW?=
 =?utf-8?B?ZW5RR3NUaHNiZ3hTZUFrZFRJdUdycVlCMmtmdlVhRkRCVVlIQVdVVlN5Z29B?=
 =?utf-8?B?anlxdXVEcmJaOHk0VDdDWHQ3RlZ3ZDNIQnc1SFI0MnQrUTJyc2FLbjRCaFZs?=
 =?utf-8?B?b0J5YmQ3U1Awa0JKU01OcjBEZzJ6cVpLUjN3Q212KzFCNEF2V2JCcnBpR1pX?=
 =?utf-8?B?Tm1HWmlTcnRmKzFxV29zYVYwKzJTaVc4aWowUXVrQ2NTd0tkWE5HL1AwUzJm?=
 =?utf-8?B?UjB1M1dEVk1xaGp1cUZUdVcwN1kwRTdHVDY0ZHdsdnVjbzVaS1Uya0Nnc1Y3?=
 =?utf-8?B?THl3cE5WVEpHVHhUVENmbVBCNlVrVjBTR1BwWjl0aFFkZVpoamRGbkhMZTJS?=
 =?utf-8?B?aFk0dGRPQ2dkMm05Y3BNeHRtWldLRVFrWTl6ekMycTFnYU5tZUdvVkNpSE1m?=
 =?utf-8?B?UGFsbFB3S283VFJnUElwaDlQa2hqMGR1QnZiWUhGR2EyaUQ1c0IyR25pVmdS?=
 =?utf-8?B?aEE3RUNsSzQ3TlgwazFFK1ZZRW0zenlZVE1pdFM1eEgzaWlvOHdRcWw2QzF4?=
 =?utf-8?B?bkxSZHIxbWkzVVhVMmg4dXdLL2dJajlLOUlFLzNBU25aNnNGZXRTSW9VUDBu?=
 =?utf-8?B?Q2Q1YW1JWEVDTEhRbVB4dmJ5aTRXWE85aGhJVFJ1b3VkdWQxdmI3Wnplemlq?=
 =?utf-8?B?YmF0elJ6S3VGVWFIa3pZSnhDRXh0YVNUMUY2a1hxeXl6MzJ5MGNMMlZmbXJJ?=
 =?utf-8?B?aEhjYnFwc2JqRDk1aTRXcE1xTSt3NGFlTzVGbXRCblU1cU1VTkx2d2NSRk43?=
 =?utf-8?B?b2JBZGdhdDI4UFVUQlJkOE5OWjhqc2tQRmlxbHNGTGRNUVI0MUMxcnlGQ3F1?=
 =?utf-8?B?U1BHc290YzRsYWNlNW81WWo5TEpOSVJmTS8rZzRPcmVBRTFwYVVsVzB4Vit1?=
 =?utf-8?B?a3V4T2oxLzZqNThBaldFcllZWXRMd0pCL2JURDdLVG4ycDJGcmI4bGl3V1U1?=
 =?utf-8?B?SW4zZndwRFFkYTNwdDJPRFlvbXoycUtKVXYxbjhjRExSOEhrTUxjK0Nac2N2?=
 =?utf-8?B?eERCNzI5WGFzOFFNTWJuMkFOZnF6N0IycGZpcWNSOVhpUHNuNis4UVFrTGpt?=
 =?utf-8?B?TDlNUU9NTWhFUERpeWlYVFA1cmUvM1dOYlYvQzZsQTNWVGlySG9LcDZwVm1D?=
 =?utf-8?B?WndhYUpyV1JvWTZyWEF5NC8ybmVSdDVOMlREVUtJZjZCeDBRSm5yUUc4eXVo?=
 =?utf-8?B?akpxUlB1NmZsTHo2VjJDdnBnOHUrZWtFVUM5RkFJRDJidmxPclE4SVFNb0lj?=
 =?utf-8?B?UGFmYlQyVlNrWmhid1pBS0JjSXdzMnJaL001eVBYUFFBeHRKaGtzWVhMV0VT?=
 =?utf-8?B?cHprb2FaSkorS2RVbXFpcXZ6SkVxQ28raWNRNTF2Ukc4MmY2dHJuc2ExT1F5?=
 =?utf-8?B?QXZqN0NWZDM1cHkwdE1RMm02U1dPZ0R3UjZia1hKRkVXTUI3Zjg0aTBTR05P?=
 =?utf-8?B?VTNOVEdsVW51UjVUcjdlU3lqdXdLWDMxY09kQTBPQnFDTWhPdDE4RjhuMm94?=
 =?utf-8?B?TTVxRGhRbVhkZzlpWWZRMm5WRlRhNjI1a01BOEg3L3VyN2lmOHJDa0tRbEZQ?=
 =?utf-8?B?VXNsT3grMVdydTI5L1VyR1Rhb05SY1FPUW9WNzdPSTN1c2dQN3NSeHJZaDRS?=
 =?utf-8?B?VENFZTh2Qmo1U3hyeW9jUEJDayt4MHpybjVWSlg2T2Y0MHpUMFF4RVNYRTU2?=
 =?utf-8?B?bk4ycUtPWWlkakdnYTBWeE43QjVzNmdpU3FQbTM2TmlTN2IybEgrN2prcnRF?=
 =?utf-8?B?V0FPZ2lubGEwMlNiclc3YURaWVdVNjg1RHZCYVo3d2VseHN0UG11bFo0S0dr?=
 =?utf-8?B?dTlRQ2tMcCtjeHhlTGVwM2FjblJwZDJMSkZtTTdmUVB5YTRVQVNwUU1ncmFD?=
 =?utf-8?Q?MVH06hF8uCifwN7Q=3D?=
X-Exchange-RoutingPolicyChecked: iHUHRZ+HAJDXh8mRJJOkxIoxI9Oe4y1mTqeyCZTtEdmLO7ytlHrG1yUQ2J/bm8ambm0UwQOjjF+DDIP8sUXu2Vsd6iUxuv5JLt9901mwTNRtXcTZkjMi/JKvH37VnceYUuW6K/isiPBE6C5J9DWlRx0AzYdEsuXFqQT+r+83fZyEzHrQsS+fc7wW4cn5wweNsfdKL6i+ridU4BVb/awYS09nbdHY0/Ed1S2DldGMny4EUR2ad/JiWmKmfFDuNxLTBNPH4vB2IvKxQ6Tff8i3k6iT5FyW+0GZLLWNqQLTrZ36vzJjHLuoENi0jiq1N/3XbFk8mApgg0Tj48OPcdJYNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbc0ef-8be2-4862-2241-08deabb57117
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 21:21:31.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuBSwl8Ea8MJeJu9DIDe/I8TXRBddI+bBwLLFktiX6F1NmJxJwohtYpfxRxOFW8xW0teS03DpInv0QzeRu0qMmOpEU3Q/UoVbBoITA1zmlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8D2894E095B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,enjuk.jp,molgen.mpg.de,kernel.org,linuxfoundation.org,linux.intel.com,acm.org,lists.osuosl.org];
	TAGGED_FROM(0.00)[bounces-244456-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DNSWL_BLOCKED(0.00)[192.198.163.11:received,100.90.174.1:received,2600:3c0a:e001:db::12fc:5321:from,10.7.248.11:received,40.93.195.52:received,10.22.229.24:received,2603:10b6:806:343::16:received,10.64.159.143:received];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DWL_DNSWL_BLOCKED(0.00)[intel.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,40.93.195.52:received,2603:10b6:806:343::16:received,10.7.248.11:received];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> Matt Volrath fixes two issues with the i40e driver probe routine, ensuring
> that PTP is properly cleaned up if the probe fails.
> 
> Maciej fixes the i40e driver logic to keep the q_vectors array in sync with
> changes to the channel count via ethtool.
> 
> Emil corrects the initialization of the read_dev_clk_lock spinlock in
> idpf_ptp_init, ensuring it is initialized prior to when the
> ptp_schedule_worker() is called.
> 
> Josh fixes the idpf driver to prevent enabling XDP if the queue based
> scheduling is not supported by the firmware.
> 
> Josh fixes the idpf skb data path for handling queue based scheduling.
> 
> Josh fixes an XDP crash in the soft reset error path, restoring the
> original configuration if idpf_xdp_setup_prog() fails.
> 
> Greg KH fixes a double free and use-after free in the idpf auxiliary device
> error paths.
> 
> Marcin fixes ice_set_rss_hfunc() to use the correct q_opt_flags field,
> correcting the assignment and preventing submission of invalid data to the
> firmware.
> 
> Bart corrects the locking in ice_dcb_rebuild(), ensuring that the tc_mutex
> is held over the entire operation.
> 
> Grzegorz fixes the ordering of ice_ptp_link_change() in ice_up_complete()
> ensuring that the PTP timestamps will not be enabled before the PTP timer
> is actually re-initialized.
> 
> Ivan fixes the rclk pin state get for E810 devices, ensuring the index is
> properly offset by the base_rclk_idx value. This ensures that the correct
> pin index is used to look up recovered clock state. He additionally adds
> bounds checking to prevent attempting to access pins outside of the pin
> state array.
> 
> Ivan also moves the CGU register macros to the top of ice_dpll.h, inside
> the header guard to avoid duplicate macro definitions should the ice_dpll.h
> header is included multiple times.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Sashiko pointed out a few issues with some of the patches. I replied to
all the patches with possible issues, and I think some really do need
more work.

In particular, patch 3 needs to resolve a definite use-after-free issue,
patch 5 needs to address an issue with the extack pointer use, patch 6
and 7 need some investigation from the author to confirm, and patch 11
needs some confirmation from Grzegorz on whether there is still any gap.

Sashiko did have some concerns on patch 1, 2, 8, and 10. I replied to
the patches, and I think those are issues which need separate follow up
work and shouldn't block these fixes.

I'm going to submit a v2 which drops the patches that need rework.

Thanks,
Jake
> Bart Van Assche (1):
>       ice: fix locking in ice_dcb_rebuild()
> 
> Emil Tantilov (2):
>       idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
>       idpf: fix xdp crash in soft reset error path
> 
> Greg Kroah-Hartman (1):
>       idpf: fix double free and use-after-free in aux device error paths
> 
> Grzegorz Nitka (1):
>       ice: fix PTP hang for E825C devices
> 
> Ivan Vecera (2):
>       ice: dpll: fix rclk pin state get for E810
>       ice: dpll: fix misplaced header macros
> 
> Joshua Hay (2):
>       idpf: do not enable XDP if queue based scheduling is not supported
>       idpf: fix skb datapath queue based scheduling crashes and timeouts
> 
> Maciej Fijalkowski (1):
>       i40e: keep q_vectors array in sync with channel count changes
> 
> Marcin Szycik (1):
>       ice: fix setting RSS VSI hash for E830
> 
> Matt Vollrath (2):
>       i40e: Cleanup PTP registration on probe failure
>       i40e: Cleanup PTP pins on probe failure
> 
>  drivers/net/ethernet/intel/i40e/i40e.h          |  1 +
>  drivers/net/ethernet/intel/ice/ice_dpll.h       | 32 ++++++-------
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h     | 12 +++--
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.h |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 36 ++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  3 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c    |  4 +-
>  drivers/net/ethernet/intel/ice/ice_dpll.c       |  5 ++
>  drivers/net/ethernet/intel/ice/ice_main.c       |  6 +--
>  drivers/net/ethernet/intel/idpf/idpf_idc.c      |  6 +++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 +-
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c      |  4 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 61 ++++++++++++++-----------
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 19 ++------
>  drivers/net/ethernet/intel/idpf/xdp.c           | 15 ++++--
>  drivers/net/ethernet/intel/idpf/xsk.c           |  4 +-
>  16 files changed, 132 insertions(+), 84 deletions(-)
> ---
> base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
> change-id: 20260504-jk-iwl-net-2026-05-04-f9526823577f
> 
> Best regards,
> --  
> Jacob Keller <jacob.e.keller@intel.com>
> 


