Return-Path: <stable+bounces-196566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39FC7BA00
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 21:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BE4E11D5
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9AC3054EB;
	Fri, 21 Nov 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnOHbl7k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177D1DF72C
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763756622; cv=fail; b=rdQ+NLL1X1nYPq7bSN2hPeIDO3Xf5cNyHivAGPP4wOEVwyBKNWTL2pvOCjq8qjnpgKRYqTMLkd81eTXgCY92B1Ku3yfvSKJ6MY7P3fAOX9sv1KDZXhaTpCFY9iwTIzswO2BuCFGbd7KXOYmmrMT3C5ODI01ODExYdYBREv+4jnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763756622; c=relaxed/simple;
	bh=Tmn+5kQoz4+S8/ZEBSzN86VZ84psQ3pjPAglOqtuSvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMy3d7gdR69KQuXXkaRzn2TPzoSY64XskeLgvEen93MOJo8IHHSwKtgGW2vA0jeCTR7Ooq9rfyxoa711HpOo9pI8RNH8glToTW+WEYpy8kaimW50bt9+4S6+2AKzh8iJZ6wXo0QvM57GpzFCXQogSE8lqq2/IG6lFJpgFGIIjJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnOHbl7k; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763756620; x=1795292620;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Tmn+5kQoz4+S8/ZEBSzN86VZ84psQ3pjPAglOqtuSvg=;
  b=cnOHbl7kbH8jmtrwQNFqbUj6d3vyCuLysrdAYDsYqPXunzQb0Ze9efJL
   B3bSoqIDg8yrL1msrB1C2IBW4ceSsyjpBu+UN8S8YMsCVim9qWcG6Zfic
   khjbs4Y/hlDQQ6DZSW+X5tlAWcf1N4sGkuGCLfXjoDm1kr7harPE5KKj+
   m8unV7cU7K312Unna2xSZbZEbUh+cePAS0SQd/QcIYwcQ4uYShD5x20sv
   tTPoVro/wendi2R2Djf4ml4nxX1fi/PjQ8JcuBavc7D39/phXILAfcjy2
   gjCAKeF4+7hrkueoK5BHX7oIFwnlDvIBzl3sae+2ihr58k3jQ6XITS/Zo
   Q==;
X-CSE-ConnectionGUID: 957KhX6YSd6o+jMuth+m0w==
X-CSE-MsgGUID: jQ14UEg2T2OPWg4GFVXcJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65939550"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="65939550"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 12:23:39 -0800
X-CSE-ConnectionGUID: /Z/QEwQiQyuFutrd7ZtL6A==
X-CSE-MsgGUID: b5BDNOPmR7C6YSoQaEt2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="191894164"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 12:23:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 12:23:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 12:23:38 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 12:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF8Aso2xg+fB01Cd9Q1doppSTREoWhgd2QfpmtcVhi/TMBcnbseQ/L1/XbWjGNn42+H7inOylpiCCVNJtuzkTymFIb0BKTswVZBlR9WKVqOgVCHaLF1QW0bvcJaxbrbqJXZvxZPyiF5ONwdLlQjj00rLqa5yeYPLwrX70fTU5O4/5p/3b4flDCY1WaE4MqISiqsSKILgYrKwOP7Zur1zYRpilXz8RHv4F56vR7ePMKFt6GmI0BUK9wBfAa1imJIBTer25yReehF0N21nSKbLt/v7WBurGZPIiaOjrm8ypl6r62gL0dqiBle46osBX7Qy8Tv/BTQ6YDljkQ7HUF056w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7UybIVQt2rBTZtF0jMvMGeWnxCphOwglJbaRXbvNeA=;
 b=TL+i5m1eKOYGmiXN9YCXY96ucE9c+OnGpfisaO0+iqDYLBks1wY6qlqJtbatwvXXel46MXqiVu2VhRaia4+JOl6ClwY7TpfQxd0I/u8ytD5SEmbRQ01jLQH6GR74fd+6muDvHZQT6PYbK4NFXZvTQDummy1j0lm28T0VQ6STtVfq6X3cBAcyAKevNH8NIpIJR7OYK4gGdkyuzhrOhN3Vwv6EnRLYE/Y+pr3rExKMCoKQTVgoqoAH2yPT+4MRYWO1pbVf2i9Dwb//ZKQn22ph8bxyVxWhO+i3p8orEysnhIvQdaYRB002U9U4IlRRWuyO7ICjeHYQ+yY88iuVs9H50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 20:23:35 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 20:23:34 +0000
Date: Fri, 21 Nov 2025 14:23:31 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, Sagar Ghuge <sagar.ghuge@intel.com>,
	Stuart Summers <stuart.summers@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Message-ID: <nxa64xljcryyuvllrh36e4asry6hx7uww5pe2summ7cu443c6y@2z3mjbugzagj>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
 <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
 <lc3rxncpictivozzuecf5z2kfprsmkjk35vd2djlofppfa33jq@hdvuteq3wkvc>
 <cb23a8cb-937b-43d7-85a8-68a60c98e0a4@intel.com>
 <q6xbaysjemijasgw5gddu227du2h4smaslqjsyg2vvaetn7yjk@iu77svwmmsmq>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q6xbaysjemijasgw5gddu227du2h4smaslqjsyg2vvaetn7yjk@iu77svwmmsmq>
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: f187bf74-17e1-4319-6d51-08de293bd816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Py6deTNH5jiXCrsq7CudtIO4KOhZ3gqDuV9wxYi+OXGazN0Qn/areYqvjh?=
 =?iso-8859-1?Q?ixlMnrPZJi+ypmXNgHzRcieSc7Bo8ag6eIeHMV+rTg5TP4lsO6x0GMwBnE?=
 =?iso-8859-1?Q?+ItnqcTytiHlimTNc9W77uF/XYzNGzdYk/fHVZbD7ju512qZhWXxWA5ZgR?=
 =?iso-8859-1?Q?7hrpflhkSOXo/VNVoAcN0b+tHlOBPehJCZPNt/rCnwiNn3LHV4svtOzkkf?=
 =?iso-8859-1?Q?Cep6SKFRyi+tZDSvuboNYz2/jsjHXBe1diB+XAmZ7+f9eLLY9mgKKW5lrJ?=
 =?iso-8859-1?Q?IvFK66EK+KfEBV6zetoOEhs9j0A3JrMjrAbVKOLmulWpNmt/XvUKjy/M4F?=
 =?iso-8859-1?Q?2D7gU8dziiI20eWYa9wQfzIQjps79CXhKoeUfMcJK4uMcsx1vdsPNYsyER?=
 =?iso-8859-1?Q?N8On6AQiwyZShCHGMqRqCXFDEAQo3cB7xhx/ugRaw6fRVnriSOhiSod7XJ?=
 =?iso-8859-1?Q?jlUTHhTbBZpxhZ0aF9/Ms/b6SCSuXkpqHoZG+XEb5mrzJ/y4vHoi91Kv1S?=
 =?iso-8859-1?Q?PSy3xx3z1vzBfuOLuSqm4upynXaYR8Ggrfbm6AiAGYj77k+ZCrLOFiIGX7?=
 =?iso-8859-1?Q?jfP+1CONAhypwJjNC+XCAnTRxjC1x4U5uWS3zbd71dJAeQN2z4r0EPDS9P?=
 =?iso-8859-1?Q?bOCVx5eBKNOjS9RODa9Sj6prySLNxemZdBXVLHZxtoIU86D+V6YpyRaOYT?=
 =?iso-8859-1?Q?cr3p/FsUGD0r6VQQrewN2OAZPt8saRWUBaE2D78P/pl26XpbRunIO1J+0u?=
 =?iso-8859-1?Q?OZ+ziQ6VEhX50upzSvaAHkZUnt6MSJR/Jxc+UjlB9LiCn+U+5rX1/TcnQZ?=
 =?iso-8859-1?Q?ILGoKddthYo/4beos6Agz7PjiCVkWmTbIqg6SbPRHIBCmhHFj/3b4QCiPM?=
 =?iso-8859-1?Q?Ena68heuE47OhRIdJ4LMutK3ArNECqZ+OxPOLrE9RXnbSFQpDaek2jeRv+?=
 =?iso-8859-1?Q?HfP5ARNDVKrVfGTCXwcpAVm+V/GjAY/Z70vQuh0ah0omMWpgvULqX30mgE?=
 =?iso-8859-1?Q?w0jtaBoRGoGClgOFzoHwu5QjDDl7ACZM8h0na6won539AIPLbTLucnjHQy?=
 =?iso-8859-1?Q?qUkbmRYSNqvSpVsq9QByL0aOwDNjjNvuywrhtTeopcvHtM/Ru7m3hLO3o9?=
 =?iso-8859-1?Q?IPy9qo1FYqdoxT6kcu7qwFD+6vcczO8kynwhQwIJsFS5vtseaiwyqp34vW?=
 =?iso-8859-1?Q?3nZD5HW17Ccfr+gVBmbQJfiUytaKuTwipfASuu8OFtS8Vy77adZEf3t+mi?=
 =?iso-8859-1?Q?zFTAYFuTZs9d6jHcmsZmVLwr3Qz70FUfuYmy2Dan4LYj0gf4TrEKhZTYNx?=
 =?iso-8859-1?Q?2Mhu3yFScvQKaZ5QkIFs3ci3v+vuzLwugoCewoq7GsDWKTkqL0lN9JFmqD?=
 =?iso-8859-1?Q?NXigMxPFd7sC/vr7fwXqgAEBV137tlg9OvRi5p1cCLasxlOfoCMeCZxRTZ?=
 =?iso-8859-1?Q?fMeL3L8lqStyMbJZvKKdRsqGYCFsGm/AtnXTOHAAXllIKr+s6ceoNU79ud?=
 =?iso-8859-1?Q?mRhLKL/AW26akLgXcNHtvS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vK0SMKdcogDCIroq8TAPoocPtacRfTTBYz15gu1marJfzK+7xC/XH9iPdl?=
 =?iso-8859-1?Q?S5ZjIoDfQWcV2NP9MjU37scCdVln4HGTsQij+9Essp395oH1TId4icgKQA?=
 =?iso-8859-1?Q?gYDK2xxlttlfHn/4/ArNlNSNhuPPkrXIkEBvvcsfD7rEayztKmu3NFQjNw?=
 =?iso-8859-1?Q?+bT/VkdaphIGIPNb4MMnqryvH2uVQvyW4rYMcM9Sfw1VHpiTBaX0LSwQ5c?=
 =?iso-8859-1?Q?dEoRJ5eAUrK9P2rMtHAW9ygCwvZVkbnih9p07eszSYk2UeALVxeAN3+r6x?=
 =?iso-8859-1?Q?fiWyWYVk+zpgG7L0gXCTGGxcHtQfrwVFh5yO8/uGR9XvqBgkTi9orCHkqz?=
 =?iso-8859-1?Q?+k8qUsCkD/ue50cxdFA0z4HJovSIar6l0kYnRuq45qk+8riWR+9BprcjMa?=
 =?iso-8859-1?Q?2hJ71DOsyDb1UqxCxSf6vDBxaHSOB3sHTAQtqvzo6+HWQdIk1KuAhUXcFP?=
 =?iso-8859-1?Q?Cnb3dHacJMW3YOxji3PeEjdVbDTeeQNws7ozYZnt/7De/o6kzIJXliW8Lm?=
 =?iso-8859-1?Q?2Z6+085fvI3Q8dGq6ACQHwT1iBdWgZi58GUds65poPt5XkR6kb0/rRoPn1?=
 =?iso-8859-1?Q?BWaUj4XP2R+i4Js4GquElUCWAiKA1I8Ng46GQataNObHycYZe0U4Z16HTD?=
 =?iso-8859-1?Q?d5oCxvbaLccPM9zElqoN1RGpirCvkUfTjQZUCvhGaDUp8R6D86S9ph85PN?=
 =?iso-8859-1?Q?bTfQs3WnXOhDdWc2KMS/126RQ7na9Df/gnQVMUWQZLt4iUyb5lrAP5Xfn9?=
 =?iso-8859-1?Q?t/5NOaMdwN1p5OfsBXv9pBf/9NA20RcluxEHh/s7PEJsoCdh7gaFsD9ThS?=
 =?iso-8859-1?Q?/jKKbSfVvWBK9j5fU4szmXO5Xa3MyE6GjMbjg56AVGTIVKvXRNrzLfK51a?=
 =?iso-8859-1?Q?EGWw/5InCnY4ljzSDOQ+ZNpCUxGdqQQPiy+csdDa/8MU6E3SWSLebTqsps?=
 =?iso-8859-1?Q?N0FK76l24CmBpoNdZLMNKP/IYEauc5MA/TfobMBGl5KC3yO3PhAuhd4zWc?=
 =?iso-8859-1?Q?ohabXn9jYAAXhCr2bsBTjaZJXwIJ1VRFkc1MnI4x+PZnJwp9BL1SZk7b40?=
 =?iso-8859-1?Q?ekUuBW3MXVuZruy2/H2FVBjWz6fL12pdsTYzW3/nmYFVd6aEWk0sONYGF4?=
 =?iso-8859-1?Q?BkuJs5poqAJa7fwZeMuSYqTno9yOV5/k2TEtTZLXFzj+hFsXqkygBpHOLO?=
 =?iso-8859-1?Q?/mimLoToiBQomYVNDhOukB1RXXs5RZYltDEPOPYK8ARzDXngKh9w93lJb+?=
 =?iso-8859-1?Q?qDD5XUWTmrAJeIxjixCmT798cxIVj7qlb+IvC4bfEpws3Te8XNerACBrZ2?=
 =?iso-8859-1?Q?6nbEnQpFXN0LoszgTK+HYUaNm8AI+eyxcESPc1FE9YEr+ap6mvRgOczrOw?=
 =?iso-8859-1?Q?NBbf12Wze1c9w/xbm3jDoc9j2kyGtSbUzb+cUUT1D9mB2iEwd6uamqoUe6?=
 =?iso-8859-1?Q?0mZuAhpnspKkomCZQI0aI8Rm2GN2aSWN1owjEaAS2ZZGSsHIFjRjRBUo/Y?=
 =?iso-8859-1?Q?2paU+bEamLJfE0T8Z3Pd9pmCgEsXvCr8iJXdRGtH26S2H1oAlQryIUHwgV?=
 =?iso-8859-1?Q?zbGV+QUG3ZWHi4RAPOLb7hdEowQqsgXSKOuQvTaBEh3LJNMkNB9n5le7xt?=
 =?iso-8859-1?Q?z9IiUp1/bCNEFLxAioD56N9W8RPO1I6lcE0zaZfjJtXG3hhVvUfhPOVA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f187bf74-17e1-4319-6d51-08de293bd816
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 20:23:34.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SC/Hifh4U73Wqvr9Gjjge9i+/YUzv+50bAyZEKr9LW629mOQm3f5wHRh58vni5aWTZHmZNszCew/V2ozjiOgQJPmm7QNcHJVIaOCzGwUx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 06:50:05PM -0600, Lucas De Marchi wrote:
>On Tue, Nov 18, 2025 at 09:09:58PM +0100, Michal Wajdeczko wrote:
>>
>>
>>On 11/18/2025 8:50 PM, Lucas De Marchi wrote:
>>>On Tue, Nov 18, 2025 at 08:29:09PM +0100, Michal Wajdeczko wrote:
>>>>
>>>>
>>>>On 11/18/2025 8:08 PM, Lucas De Marchi wrote:
>>>>>Add missing stack_depot_init() call when CONFIG_DRM_XE_DEBUG_GUC is
>>>>>enabled to fix the following call stack:
>>>>>
>>>>>    [] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>>    [] Workqueue:  drm_sched_run_job_work [gpu_sched]
>>>>>    [] RIP: 0010:stack_depot_save_flags+0x172/0x870
>>>>>    [] Call Trace:
>>>>>    []  <TASK>
>>>>>    []  fast_req_track+0x58/0xb0 [xe]
>>>>>
>>>>>Fixes: 16b7e65d299d ("drm/xe/guc: Track FAST_REQ H2Gs to report where errors came from")
>>>>>Tested-by: Sagar Ghuge <sagar.ghuge@intel.com>
>>>>>Cc: <stable@vger.kernel.org> # v6.17+
>>>>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>>---
>>>>> drivers/gpu/drm/xe/xe_guc_ct.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>
>>>>>diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>>>>>index 2697d711adb2b..07ae0d601910e 100644
>>>>>--- a/drivers/gpu/drm/xe/xe_guc_ct.c
>>>>>+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>>>>>@@ -236,6 +236,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
>>>>> #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
>>>>>     spin_lock_init(&ct->dead.lock);
>>>>>     INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
>>>>>+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
>>>>>+    stack_depot_init();
>>>>>+#endif
>>>>
>>>>shouldn't we just update our Kconfig by adding in DRM_XE_DEBUG_GUC
>>>>
>>>>    select STACKDEPOT_ALWAYS_INIT
>>>
>>>didn't know about that, thanks.... but that doesn't seem suitable for a
>>>something that will be a module that may or may not get loaded depending
>>>on hw configuration.
>>
>>true in general, but here we need stackdepot for the DEBUG_GUC which likely will
>>selected only by someone who already has the right platform and plans to load the xe
>
>conversely, if we have DRM_XE_DEBUG_GUC set there's no downside in
>calling stack_depot_init(). Any performance penalty argument is gone
>by "you are using DRM_XE_DEBUG_GUC".
>
>$ git grep "select STACKDEPOT_ALWAYS_INIT"
>lib/Kconfig.kasan:      select STACKDEPOT_ALWAYS_INIT
>lib/Kconfig.kmsan:      select STACKDEPOT_ALWAYS_INIT
>mm/Kconfig.debug:       select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
>mm/Kconfig.debug:       select STACKDEPOT_ALWAYS_INIT if !DEBUG_KMEMLEAK_DEFAULT_OFF
>
>The only users right now of STACKDEPOT_ALWAYS_INIT make sense as they
>are core ones. There's not a single driver using STACKDEPOT_ALWAYS_INIT.
>drm and ref_tracker, on the other hand use stack_depot_init()

I'm merging this as is to have this bug fixed. It can be migrated later
to use STACKDEPOT_ALWAYS_INIT if desired.

[1/2] drm/xe/guc: Fix stack_depot usage
       commit: 64fdf496a6929a0a194387d2bb5efaf5da2b542f
[2/3] drm/xe/guc_ct: Cleanup ifdef'ry
       commit: ea944d57eac746f9bd9056134751708c48084207

thanks
Lucas De Marchi

