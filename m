Return-Path: <stable+bounces-164587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A3B10791
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F76B7AFFC9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34F25A623;
	Thu, 24 Jul 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7iz2Wn+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439A7F9;
	Thu, 24 Jul 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352291; cv=fail; b=jEyKS8/RW7EY0KH0cI1HycSRwuDD/oR97Wl+toMCR/9/ZN6h+CzhmF/6umWWSdBfXLNR9OODUcxs4nUq1GstSvce3NkNMqE0aZVLSC0++k7jsbKfv9RvKNLbzFPBMHlvycw3a9jCRaS+iSOaegwPnLbn20OzBrMEXpZnCiZcFhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352291; c=relaxed/simple;
	bh=B337WhNPcLdv+qs+n1fpS5oLPhymtZspMsu2nVRgCeo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMAhbs6UVdbNT/2/jufjQuhhBgM+AlTs1qa8owjW21xpVrh074OYmK1gLQESArfKctl+lJ266+dMWedfN6WLxh5r0NIiCwCQ9e7lKnt9ifeAhRN5b6gP991pRk3DSr4NfB+PZI5JRZKpL6WxNfkKlIQ5L5UJWVwGaH2gKO49bzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7iz2Wn+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753352290; x=1784888290;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B337WhNPcLdv+qs+n1fpS5oLPhymtZspMsu2nVRgCeo=;
  b=N7iz2Wn+AQaPZPW/N7XOTBPYt7C0NwwDGVzmUfTpLZHwAc6y/ZBrexEC
   3jtF6Q/QVu5WBXGTkKXJ5auqP9W0rTGnbGa64gNXUP5iWPyoXqceUwIQn
   2qNLu3GJBFyP87dVeI73WV0gM6REMm+YtlCVlha5StVauCbRrVPcNTgS4
   1CyxU/WVmPMkPsy52Yw2bS/Nl3HRN7azmCxIJ9TYPuHlBScP4WZFMTf8/
   m6BDweBRwe9OZh/sF+hVdsbxsoVh3eW1iW+uja8RZ4wvO5IhUXVY7fgLG
   0n87U2dqIH9cebUi4mOK3A+V6ibgY+KpE/iB6NhP9PGyw3j69LWEv3y5J
   g==;
X-CSE-ConnectionGUID: WpwhZSHDRq6aeie53i+28g==
X-CSE-MsgGUID: mugXXFnySWSsa3LH3e6wsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55506044"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208,223";a="55506044"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:18:09 -0700
X-CSE-ConnectionGUID: jnmkZg1lSj6auC6FevJRUQ==
X-CSE-MsgGUID: Nl76dFvxTLuSRQ7tx9wJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208,223";a="164632640"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:18:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:18:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 03:18:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgq1mpfPRSG6mdBNaifjaCgdLj8lQKYIWS+hgDalFgF4blhO9Yr6919joXcTEUrimp46xTJxVTW61ZhSnrBSRQR3dWjH0hx4fbncrt6Vqr22rnW2MujM/uzK1sU28DQwUajEKVaObWml9mpdOc6vCBfbBSuXrxaMFn4EXjdl1KyhpgX8QsJa7UMe2GbB02V0ARXfoZHVJ+L+qE2t2HwHZpOAwNFt1CWED0Z6HeK9ig/E46v2/WFirthBROanJ521ROMSUaFNeUIdThN6CzGdzSzYufkzgqGpRMOafoArGXx5ULKOcDtLYKCetx+GuIp3WuG+KEUanQ38npW/+iileQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxoqPbCo8aD74POFHJSRUEUzmkuWmEhkTaxp5IyBBLw=;
 b=NBIrQ9Hdf9fOUdyV99/yTudV1aWgnImUoG+jrAcFwAYiDoWn1TTeQtmeK0VuB2SJQovQQfCow/8NsHEgBQub8bPXajz8TaNpbzmCL6T/u2W2K7kg9sMS0goUR67OrKymXvW9CROsv6XDBgFmfCPd0GcDjEB8P69TZbafpOGhH1VRrNOOklAqSpv86LB2feXNyE4zAEGKvnO+0HUSOHLs5nL5UYKwXLAIg8TuMaVboNPjQHf9sNfUGGEwtR9WPsx2XBrs3rgXjE90KgmeKyJjoOFuHvVqM405inNv3C4ge2oSeG3RJLEafRf6EOJIui/MFjPRYqJj26OvBSt9HQdEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 10:18:05 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 10:18:05 +0000
Date: Thu, 24 Jul 2025 12:13:25 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kyung Min Park
	<kyung.min.park@intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
	<xin3.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
	<stable@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
Message-ID: <7rugd7emqxsfq4jhfz47weezipfoskf43xslgzgwea2rvun7z6@3tdprstsluw4>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
Content-Type: multipart/mixed; boundary="qcl4oja5xcm7xybw"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
X-ClientProxiedBy: DU2P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::32) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|PH0PR11MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: b842b2b8-9e9f-4777-02b3-08ddca9b60ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?o2pLyeMZVNq2sT6J9TKbiGbLKZz3+NqVWrCnraueAcat3F0qOq9261g9d0?=
 =?iso-8859-1?Q?+IiCEfJ+G1PoHhJ4nOQtrxl+zIspwK9tNdShuh5HcPzVQ6tpHqr5Jxi9zo?=
 =?iso-8859-1?Q?FGOGLD7zQaJpVisT+boTrizQwsrpeMBdzxK/cFwGX72z3czLEeN0UHQzlB?=
 =?iso-8859-1?Q?clJGOok6FErSgNlG+NToIrA11o54kxXOG7R6FGPGT/TzYgVskmuhSebeJI?=
 =?iso-8859-1?Q?nUjBESIT2UG56lw0QgixPv44luL8MEj1wELxu9Is3RP7kRAGufRj4YC8ca?=
 =?iso-8859-1?Q?k/tfnz4HEmMIkjFRvTP2LFVJAl8hGcCVZT31km729znSoWICecZTXeCYNH?=
 =?iso-8859-1?Q?xwLRgotPRVaReG27yOv64jrO2XKmgf+hl6vCeAq1L7C9QkZ/SFZrmSkWYN?=
 =?iso-8859-1?Q?xMMAb1epf3s6FlhKsFW3bAQtY1omwcdVJ/p8C//4VW+PBeQDiXr5IXF6h6?=
 =?iso-8859-1?Q?nyYaMlYXxnwEF2EZTAo3jMXIFhOwdYSPEBWCvRgVQ6roj85hcX/IE7CrJe?=
 =?iso-8859-1?Q?Hy26REJG3WsD4WgVLieCT7H967VTWoLiqBTp2d18CoMhUwRDZuzSWIWt2o?=
 =?iso-8859-1?Q?Sd9e0ewiVrrjUjLMN2pawYQ3JYGBCSCn1Eo5aGWCOIJJNcyga4G01FByUY?=
 =?iso-8859-1?Q?v/JqfrcvzRRmLONrJiF6LdyBVVnActPUJ4KUOlh2eK5obXbAEuzbPHybZ9?=
 =?iso-8859-1?Q?vb8BH3zjlcZQhJFNNBgyk78nuW/mOMOSwTvC0lDVY/GD2ypnSZWvgv0kJN?=
 =?iso-8859-1?Q?hQ4qlqoAmhs+3PmDwjF+6d/NNPVwl/0CeidsLCUqIjKa3FZrpdSf1e4Dme?=
 =?iso-8859-1?Q?4iMFRyaDLVRohESarmsnUqfbx3rg5TRSm4GybINbKKODBbJ1hWbR0dVpFc?=
 =?iso-8859-1?Q?jzPgaMkwV4tG8oDeOCZIOpgvCHdbDgmotHDxrD+y7f7IjWO7Ff/mchIhnC?=
 =?iso-8859-1?Q?LLW7hv842RsW+p3AYf81FX1u7ZAT+tn8QS6yMlVpA4tjCk7ZwgXmh21YvH?=
 =?iso-8859-1?Q?dI1sCAF19C0F5b4NcOaOGUINuGM1EnH+lUhAsvANjUk9OVC0ivH7oBGbDy?=
 =?iso-8859-1?Q?V30DIoWwzsjwvsBO4tXfG2QFKqgeIFNToJ9i6qPANJgD8931Ikux04sfkz?=
 =?iso-8859-1?Q?3VyFOTooXa9llJ1JcAFTL+qJ8DKah9HMDyCR9wFqph2Uh6ebWFpFDII82D?=
 =?iso-8859-1?Q?rs4y7+VDwFsV+tkV+yEq903tDwKP/IKIwfwtkISEWLKuCrAYi3FlR48cA6?=
 =?iso-8859-1?Q?6D6L48Bl2GlNOWJjJOCbRAfN+13jtrzYRYASVnnXEdnKF6cBAzInQS/j0s?=
 =?iso-8859-1?Q?SNN0qqoNTWfSIYrqT6lpaSCMZdf4wI5FH3pM5KFsrnfvI5K7UtQJiLd9tW?=
 =?iso-8859-1?Q?+Dpr7wAPyqLehpbx/wn+Q3fGTFaYfzsBhy9znOnLRs7CPNOJN2MiWAm1x7?=
 =?iso-8859-1?Q?fMp8og7LdcaX6zmE6Bkyf772rjBbwf2AV2T/4oiXk2OzJ4VEV/o9EVoO7z?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pKQTIaHqZjxjxnWzeIYRkXvnslY/zJNIzjvqoPCWHwyVQ5pC2i6XBCWtXj?=
 =?iso-8859-1?Q?7beEnAMWWxB5dPGl2sjG8R5qXF2LZaQQh54Lnx6exBERoClA4ysg0cdRFY?=
 =?iso-8859-1?Q?a0lB5xJtevEHZx45AsPs//MIu2FvKcoxEyaGPzS1xG7EIUsBuLmprJSDyp?=
 =?iso-8859-1?Q?aJFhoFHP8oiTiDEYvd0TgncY/ago5wFktHYhLqeECI/Qbz7ZJtby5u+aGH?=
 =?iso-8859-1?Q?yp+3ZWODHcJ5i640pN6VlC+NH6VYaZcZpSq87pit8png0RSBqDgEIhrSTs?=
 =?iso-8859-1?Q?RrKBqMtWb5xFbAb6OjrXd2gIIvEY/4RHD9pITikxqMW6m/d2zcEChtBBdX?=
 =?iso-8859-1?Q?uwPQh3UW++Iu3zKyNUd+i7aWov4m5av6xN2+PeSo+KGgXbhHcpacBShpB7?=
 =?iso-8859-1?Q?j0R1Em/NsVxHLnK+V6ufNn5dUxPBWWjYrsX6zS27FJ93MB/XtZvBA3kMIZ?=
 =?iso-8859-1?Q?oLGlKpJwWZsBKf/kNKlHgwc8bjnDA8kK9CIOT3N/WBUWqz25xY+u1eYqTb?=
 =?iso-8859-1?Q?8b9xvqzY6dwzOjTg8WrSIKSxp8Dm2nN3dn+MCDRga94vVazNEEaI2KCoxT?=
 =?iso-8859-1?Q?Wkw9KCo9pasC2ekAHchUsxDcPw8afkFg694QYO3PwDK9od2mF1H7u2OCkh?=
 =?iso-8859-1?Q?tfzKvccYMTTr//VfITbzgBpth8r3VLtipPDpFCNHSx7fgEIVlpLPZbZUPZ?=
 =?iso-8859-1?Q?eNjOiiks5U5C/R2fcB9vTZwEo1x+oIXDPAx5Ho0s320ifQKMsXBzPWSurB?=
 =?iso-8859-1?Q?xHc4+Z+JUXGVLgLHbZwuCGO3zUVZDiyn7Equ6gD1yrpFE6qNxy0zavgdxH?=
 =?iso-8859-1?Q?Fvf+rSwR/WbAuGaKiuvia5+a1TsH+XSkpLkEbHSNADsUh29Qq51mHMzoOR?=
 =?iso-8859-1?Q?fDminGQEoYsM7vuZWOxi2DRJ1r6vp2oaE4NW+CtX3DVbt3OhOhbnw8sI4c?=
 =?iso-8859-1?Q?A3PNMduk8Ttpp677p8oPxHYkomRUPExcwSYAMebwDLqqYuLkQ8R45mIFs9?=
 =?iso-8859-1?Q?zAgA3Y8wj2ZqLGNWEgiqeZbqexNP76HeDE4OUvDMuwxDdBDx9Tfyrm1Ckc?=
 =?iso-8859-1?Q?trqYq3eT7dJWAD53bAOaaLdWGq2A7SgvfOlgigVM9/ek1pZe2u392kCqxo?=
 =?iso-8859-1?Q?A+Yp8faLxVT4UzVHAEhj1exHdLHo8UYZmnEewIdnEhSsC0aGk+HKTGxqae?=
 =?iso-8859-1?Q?fic4Gj9E5GNRJW/YcHEJBU8FG6wBonEgdtwfPuPUfT+GVYGcrjqaxBjKWJ?=
 =?iso-8859-1?Q?h6EqTPA/JfDMTxIlUlE7kOs9jX9PYTpvMmn45p/TFKNxVlDH0iJkeUxTuq?=
 =?iso-8859-1?Q?L+PBjBIzEInoXgLLz++sHBD2WA85t7c5AStGRbYKuEjtrLc/HsQsZK8rHt?=
 =?iso-8859-1?Q?GJX6xtKkHhPk/Own3jHsg/HNSWyoJ9/Ekhh+PNxVB+JLpF3HphKK6sMY43?=
 =?iso-8859-1?Q?E2op7AdxmGhTKW89yYQzyN5liNY89m3XFGUD3wz+eUiBEjRgku7vzcsnpU?=
 =?iso-8859-1?Q?pPBxfYBVTrheCGoGr0JdsoRfpUHeuY4dYL4NJs1zCeSC0CBW6yV4PM/otr?=
 =?iso-8859-1?Q?6sUQ1M9P8p4NHR9/pEEljbHXI5GOKKmOl/yWWPPcSV4rQSsAkocO68reUS?=
 =?iso-8859-1?Q?BAYju/S4HNtrb/0DFhAtmGhu/s6Kr3oNF2zuRanL3eND5rI6bQur4xsvIB?=
 =?iso-8859-1?Q?WC2y0xxloqGqeyViI0Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b842b2b8-9e9f-4777-02b3-08ddca9b60ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:18:05.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF/PClWInNOfIz+BnWjVwfMmsocQjBpX7l/wBzIdE1+6uETGCZsp+CS1zDK8ysEzInY/FDMQZ2MJ7v0Wi0SXF3BHTjEndf7SVmYDjFQKrL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com

--qcl4oja5xcm7xybw
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Greg,

I'd like to ask you for guidence on how to proceed with backporting this change
to the 5.10 stable kernel and newer ones.

I prepared a patch that is applicable on 5.10.240, and doesn't use the 6.14
disabled feature bit infrastructure - the disabled bitmask is simply open coded.
And as far as I tested the patch compiles and works in QEMU.

I wanted to ask if I should submit that patch to the stable ML separately? If
so, should I do it for 5.10 only or all the stable ones separately? (if they
have different lenghts of the disabled bitmask) Or do you prefer to backport it
/ apply it yourself?

I'm putting the backported patch both as attachment to this message for easier
downloading, and in text below to make commenting on it easier:

	From 7dd94f58d28ac98dc39bebc8ce8479039bc069c8 Mon Sep 17 00:00:00 2001
	From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
	Date: Thu, 24 Jul 2025 08:34:33 +0200
	Subject: [PATCH] x86: Clear feature bits disabled at compile time

	If some config options are disabled during compile time, they still are
	enumerated in macros that use the x86_capability bitmask - cpu_has() or
	this_cpu_has().

	The features are also visible in /proc/cpuinfo even though they are not
	enabled - which is contrary to what the documentation states about the
	file.

	Mainline upstream kernel autogenerates the disabled masks at compile
	time, but this infrastructure was introduced in the 6.14 kernel. To
	backport this, open code the DISABLED_MASK_INITIALIZER macro instead.

	Initialize the cpu_caps_cleared array with the disabled bitmask.

	Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
	Reported-by: Farrah Chen <farrah.chen@intel.com>
	Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
	Cc: <stable@vger.kernel.org>
	---
	 arch/x86/include/asm/disabled-features.h | 26 ++++++++++++++++++++++++
	 arch/x86/kernel/cpu/common.c             |  3 ++-
	 2 files changed, 28 insertions(+), 1 deletion(-)

	diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
	index 170c87253340..a84e62cdae57 100644
	--- a/arch/x86/include/asm/disabled-features.h
	+++ b/arch/x86/include/asm/disabled-features.h
	@@ -106,4 +106,30 @@
	 #define DISABLED_MASK21	0
	 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 23)
	 
	+#define DISABLED_MASK_INITIALIZER	\
	+	{				\
	+		DISABLED_MASK0,		\
	+		DISABLED_MASK1,		\
	+		DISABLED_MASK2,		\
	+		DISABLED_MASK3,		\
	+		DISABLED_MASK4,		\
	+		DISABLED_MASK5,		\
	+		DISABLED_MASK6,		\
	+		DISABLED_MASK7,		\
	+		DISABLED_MASK8,		\
	+		DISABLED_MASK9,		\
	+		DISABLED_MASK10,	\
	+		DISABLED_MASK11,	\
	+		DISABLED_MASK12,	\
	+		DISABLED_MASK13,	\
	+		DISABLED_MASK14,	\
	+		DISABLED_MASK15,	\
	+		DISABLED_MASK16,	\
	+		DISABLED_MASK17,	\
	+		DISABLED_MASK18,	\
	+		DISABLED_MASK19,	\
	+		DISABLED_MASK20,	\
	+		DISABLED_MASK21,	\
	+	}
	+
	 #endif /* _ASM_X86_DISABLED_FEATURES_H */
	diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
	index 258e28933abe..a3c323acff5f 100644
	--- a/arch/x86/kernel/cpu/common.c
	+++ b/arch/x86/kernel/cpu/common.c
	@@ -588,7 +588,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
	 }
	 
	 /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
	-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
	+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
	+	DISABLED_MASK_INITIALIZER;
	 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
	 
	 void load_percpu_segment(int cpu)
	-- 
	2.49.0

-- 
Kind regards
Maciej Wieczór-Retman

--qcl4oja5xcm7xybw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="v3-0001-x86-Clear-feature-bits-disabled-at-compile-time.patch"

From 7dd94f58d28ac98dc39bebc8ce8479039bc069c8 Mon Sep 17 00:00:00 2001
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Date: Thu, 24 Jul 2025 08:34:33 +0200
Subject: [PATCH] x86: Clear feature bits disabled at compile time

If some config options are disabled during compile time, they still are
enumerated in macros that use the x86_capability bitmask - cpu_has() or
this_cpu_has().

The features are also visible in /proc/cpuinfo even though they are not
enabled - which is contrary to what the documentation states about the
file.

Mainline upstream kernel autogenerates the disabled masks at compile
time, but this infrastructure was introduced in the 6.14 kernel. To
backport this, open code the DISABLED_MASK_INITIALIZER macro instead.

Initialize the cpu_caps_cleared array with the disabled bitmask.

Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: <stable@vger.kernel.org>
---
 arch/x86/include/asm/disabled-features.h | 26 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c             |  3 ++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 170c87253340..a84e62cdae57 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -106,4 +106,30 @@
 #define DISABLED_MASK21	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 23)
 
+#define DISABLED_MASK_INITIALIZER	\
+	{				\
+		DISABLED_MASK0,		\
+		DISABLED_MASK1,		\
+		DISABLED_MASK2,		\
+		DISABLED_MASK3,		\
+		DISABLED_MASK4,		\
+		DISABLED_MASK5,		\
+		DISABLED_MASK6,		\
+		DISABLED_MASK7,		\
+		DISABLED_MASK8,		\
+		DISABLED_MASK9,		\
+		DISABLED_MASK10,	\
+		DISABLED_MASK11,	\
+		DISABLED_MASK12,	\
+		DISABLED_MASK13,	\
+		DISABLED_MASK14,	\
+		DISABLED_MASK15,	\
+		DISABLED_MASK16,	\
+		DISABLED_MASK17,	\
+		DISABLED_MASK18,	\
+		DISABLED_MASK19,	\
+		DISABLED_MASK20,	\
+		DISABLED_MASK21,	\
+	}
+
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 258e28933abe..a3c323acff5f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -588,7 +588,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 }
 
 /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
+	DISABLED_MASK_INITIALIZER;
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
 void load_percpu_segment(int cpu)
-- 
2.49.0


--qcl4oja5xcm7xybw--

