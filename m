Return-Path: <stable+bounces-172794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B9B337C8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B95189FDEA
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0828B3EB;
	Mon, 25 Aug 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KowB563K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDA288C8B;
	Mon, 25 Aug 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106892; cv=fail; b=bs09nKfijhRMmW2mG4YvhMz3PfGW95ONPD3n26TsO3BP4rYQn2vIhZIpb+tA2Gw+W0Ox7SC7yZpq8FdhO1vLFx5hFuwKq0t8wZ3F+tG+IKOLL+3LNvmjmMZgmD7yfhPifAkzGDTFBDnmwD9uY2sfKkwBbl7WNcxJlewB30Y36DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106892; c=relaxed/simple;
	bh=3c2eS2EUB17vaJ95lSMnX97exYJ8YdmZwQy7WmDlEJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPYg0rYbFeiwaByJUULFZI7vZYwDZVfF9UheS0eN2imSigvHIvWOC5qOC4Fs8DbkdonVhoziseKn2aljgf1/pIHX3Jrhl5QMVfWc1+uGGxkJEs7gjZ2od+WiGv8vRdWvtVGQ0H6g/p1l4423bmN3VOr1B/4psQkcs4FGZrQA0fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KowB563K; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756106890; x=1787642890;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3c2eS2EUB17vaJ95lSMnX97exYJ8YdmZwQy7WmDlEJs=;
  b=KowB563Kpe90nsrA91bx+jHK9k/6ZNvylm2IzO1eGiJFLcj1K+Z1JBt2
   gf2VUpRw0Y6IcQ9/YRZI1mx+0NYNfgNSv92Eyh8E3iKHm3CQ4vXydITuA
   cWhbnI0GXNYkxhDRmZh+3hrlh8/EO3KYTmxdQIfg2xq4LaCY/vUd7dXPB
   wJauBe3rQAG3RX8HSuMyAmGPK1oFuWD5u5swkJMPJbUNhdJSVQVw6KNlN
   uMIhI6XSu7hz0Wlm2gF1jJW3ckbaki166mRrl2i+y4upKu3vch9Cdcz7v
   zTmBRsuc+e4GMnxIlt/3yjSLjf6v7/NT6OvxYFMtf2tAix5b1wj3aQZDP
   A==;
X-CSE-ConnectionGUID: q2y4giNOTQCHUygJ4+wm7Q==
X-CSE-MsgGUID: QQeTYV2DRbiYjzCw2gc1sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69416172"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69416172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 00:28:09 -0700
X-CSE-ConnectionGUID: g2hSe+YlQf6zHfTDK1JqOA==
X-CSE-MsgGUID: ro3l5B/UT5KKgq7JBNRzuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173626484"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 00:28:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 00:28:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 00:28:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 00:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkoRVZKf4fuJYblIPwQUwy1Y3D9TbS2aNFhort2YLIr4Dk/LpNQPAZnDQnnA1vtWGmnZzNzpZsI83k2J0D0Hzd8ktzxn6mj6w+KA7uJytAFyCWCxdaidv6n1fOnNGOiPw3Nxk5ElrZEkHOh12Mcl9EwL3/gIRRgrk0kn0l7PPou/hL3cPuJ2v3fTqolcHZHqv1EKqtpCTHGPF55/IueTxVEdHYypKnG4oxFKM8kn6U9zg9lhsvUUD+ifcIAeg9cX9Cw2UeTDxdQB9CIWFVha8rJASJ2oliWWCvgJtBPm8ba67QoNiZXKk7ukVCPf062siju6khGRz4x1uhzUrF4NZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C32aStPOJXvosfkSvs1s7R4cGosHfiZLa1d5ZP8pQMo=;
 b=v+tw4Q1jQ1o2DjceskeMp2LxOmNTJSdRg2CssQ/ZevwELf/16/djZQGOhDGPRnyWkfKe7R+eIESZ62Yx6zZyWYcfi3eYGqmHWT22ICjZyIOFbM6Pt9bloE1nP1e73hph7ednmNcT/xDjTqk4Xzrqq4+8Atkyqu1QdenGeuxTqJmV/iPjV13N7NkQewcXfxySjNi3FMAB+Rq5R2JfU2s3/FB4snJgFrCg9H/5SWJhFyFuCtAtSj0TbOx8ddGdkeaOGktJ9rS+uYOTtZIpKJxmaflLfAA46N9B9PEHwc95yLPExmuoEAgGWIdwDPxFh/rCpxH+mmkFMBQ1i5pBIk4Y2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 07:28:05 +0000
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f]) by SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f%5]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 07:28:05 +0000
Date: Mon, 25 Aug 2025 10:27:58 +0300
From: Imre Deak <imre.deak@intel.com>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <jani.nikula@intel.com>, <jani.nikula@linux.intel.com>,
	<ville.syrjala@linux.intel.com>, <stable-commits@vger.kernel.org>
Subject: Re: Patch "drm/dp: Change AUX DPCD probe address from DPCD_REV to
 LANE0_1_STATUS" has been added to the 5.4-stable tree
Message-ID: <aKwQfhfSu5aCUktw@ideak-desk>
Reply-To: <imre.deak@intel.com>
References: <20250823144436.2255063-1-sashal@kernel.org>
 <2025082417-santa-ibuprofen-2a70@gregkh>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025082417-santa-ibuprofen-2a70@gregkh>
X-ClientProxiedBy: DU6P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::24) To SJ0PR11MB4845.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4845:EE_|CY8PR11MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 417863ac-2d2d-4383-2755-08dde3a8ee0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Jcs9O5uNTje2HLgwd2WtnebNyw42OYqcasM8Tg0wh9LUg+J36c4ZZBGmYN?=
 =?iso-8859-1?Q?L0NrRyz5R1kizAMwOAgXIj71tjn307Zwj3jaBg/bJ7kjSlN4k0vmwp8Ja6?=
 =?iso-8859-1?Q?6ng8uNHPE+ZXuJixaD1MRroEiasbFB2zfYA3Tq4Ummz82JYc+XhyCK49Di?=
 =?iso-8859-1?Q?tVlrQkukqAtT2OW8hBM8ymh2U3wluDesATz0gOrjedYwoRlVnhOTz43wQH?=
 =?iso-8859-1?Q?6CKRQmr2iQeZ266RFJTMd9LruQACPSX4p1HAclL/2jhyo7HX/+zXu4v3NP?=
 =?iso-8859-1?Q?CBO6RTPM7yBTqYj11PGX3CYC/LqqPbZbLrYIi6li5QuuB68z6oY/6HEddx?=
 =?iso-8859-1?Q?k4jycNK7yN1Ew8nxSChpvYyQY9cwzDXWQ903eXzD/UxlQY2YggVx30zj5n?=
 =?iso-8859-1?Q?U+Pn16yUdYQyoOSGuw+rUyzUKEYuWxu/saS5116AFUJrnDtQmXXk3Q/xCg?=
 =?iso-8859-1?Q?/k6BGMp4yZhfcJ4ndeBGwY9/rqbXNjIOgWtgLFhHorf6bJ+e6JMKPTsSJi?=
 =?iso-8859-1?Q?uJQnzQ0GBsiElG8C74r3NhyJU0oKT+iaSVbQA7VTDFdjYZgyHTVK5CNS6q?=
 =?iso-8859-1?Q?ke3f+mWCBXXxRERJpsVhTTU0o8Q3b2+QwoayF1/BSymG1xATAyu6afWPpf?=
 =?iso-8859-1?Q?LpvA9cC07Ljqc82RmnB9ADbM5Nk82CoIsb2KTglM333eio6zo8c4r2dAjI?=
 =?iso-8859-1?Q?q/2/7licMYD1K8cGspBYYp2vrErU3nUGOiPxfE+zERBdMSMunBgIxGgmdX?=
 =?iso-8859-1?Q?oLJkhej1n+3c/it57L/IO6WnoTK7tlFbwiJsXFhau6qq8COs6jhrRftbYu?=
 =?iso-8859-1?Q?sXn8PnB5d3OsLyXfofggPvQqKImgkbjYPJWpDyjGcFnAWIFLgRhVR17CL1?=
 =?iso-8859-1?Q?8B1BFxE3GDdPoIFZU6f22Sc5VpXDSHmFjNE2aTPDiBOfEcNcuhjtTJqVCw?=
 =?iso-8859-1?Q?m9YvtGzPJWSTJamkIEY2sGV6iylBHgu7j45jGjN2C1LsgP816KeueaQPP1?=
 =?iso-8859-1?Q?T6838Add1bjzyS3nzZtCAiH6dNBRwv5WFMJzx55hX4DXG/maT29o+JjYBl?=
 =?iso-8859-1?Q?IzHiiWjLWdrKZfWiJZEo3jTiVUZw6P5wzRqqtUebaGhZgi7ogGWYEJpHfM?=
 =?iso-8859-1?Q?myhDjpZW4pDknE4v7XmUkp0ecIddhDJwFhnjUtuaY3pAbFozT2tPzY28Fj?=
 =?iso-8859-1?Q?XJlTjaakX81S+icQxmluNxsjQj3x6be/3itZFu3sb9OE3WFxVIdoaWp6tr?=
 =?iso-8859-1?Q?M3UwcSPDf82uNdTahf+AN919pB7IVYUStojEJ2uAc2IRoiqGff1AjIc/w3?=
 =?iso-8859-1?Q?yqVpbKN1dzITLXUq7xVU48P+U8rsiXDr8SvZah8wXPh/Jn0ZUvMnY+a8cI?=
 =?iso-8859-1?Q?2dOCMr2l3KVSmO/7VHtfMOYl+u03d8x/arVc8hEcQWCS9PcwFnBxgBFoSY?=
 =?iso-8859-1?Q?U6mv4M8Zom55rCWqo/hS0fJbkxV2Yd8zJMhWFuPwD12SGiCNFjMsdpZR83?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4845.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aj1T2Wnw6PMw9hdYYm5kj4a99H6wakqUOng+y/IvVK3QL69xJrRT1ccJsO?=
 =?iso-8859-1?Q?6DdqmI6h9NxpftKBbrclq3QeCk8JpkUpaJ7G3jWzoWZHdOCdDveGshhOv4?=
 =?iso-8859-1?Q?3RzGkXYxNW3EpbmCgkUEE2/ML64CG97Ugup3Sx6RtDrNQ2lZqkhIdxbkR/?=
 =?iso-8859-1?Q?Gjqo9OazQu4tM60Hc3PKFlGEkJWBFsW1k882JtperIxWX05NI60OU5+K9X?=
 =?iso-8859-1?Q?2pGkeYIGu30DEZLC5RxW0wY4Es0qchnPsB95/M+xzts/ZaHc3aaEcLyybk?=
 =?iso-8859-1?Q?Vq+3GjHq9hcSJ5l41UBTCNH2MwEDuOjZ7SWHRaMhjWmdunU6s8YCHGlwXZ?=
 =?iso-8859-1?Q?Nh/rhqF0Awthslq9r/F6c73QasQSDNtfpqDiGoDvALJahz+B/bNbrEe1vu?=
 =?iso-8859-1?Q?7FxjfktMzZypLiMwRvjbz8xLNmgdo08kiH7gt9gzWiZvGM89MyYWc3Cr9l?=
 =?iso-8859-1?Q?CPZejW/zoEwFx/r5F54wviL/IWGahPxmdM90xmhU8Xe+cMdPhOUiEu7Pjo?=
 =?iso-8859-1?Q?wP76TQZNrmE5606EogOGGDiiafvgSJH06Q73+g3yuhekwm5B+anWtbkOKY?=
 =?iso-8859-1?Q?ngNoLuoeNKjQCeySPceoAAQE0R5ae1qQgiRC2E5WLvXDmgly3BN2CEmsHh?=
 =?iso-8859-1?Q?Zyyg/LMlAdIzvcqiryI5/x/I5tcwavTv4QW56+Gja4O5qa4ZuA36xLFrg3?=
 =?iso-8859-1?Q?wrDbDmo0KZht9Cp4Fk3M2iR5du64cWG8pp1w96RN10q1K2JXRF5FhwnS7q?=
 =?iso-8859-1?Q?eGXJwwZLeJfAJTU2KzE4em858jZo5wyk64/aZedO46tS4SLIKXz8AMOzcz?=
 =?iso-8859-1?Q?fGcfsU2pxWy0nLlUC8PCucnAXRMm0dNm5vt9MYhbzuSPyfMXjBzskEIawR?=
 =?iso-8859-1?Q?uhpWHTNFTPeYY2DjnY5N2Q5FXG36SpeQyFpg+Vud3GYXNXhXz0MOv3rMzU?=
 =?iso-8859-1?Q?S3orhpOaowMJ1Ue5ERuoM8TrKv8j3UBy7PiyIoRAjgJ8cc4u9Eb3mMb6Su?=
 =?iso-8859-1?Q?SAFvn7UgjWqTsMz04kZqd1A2JFKiBscQKehruPzH02ntgEFqLGXc6Ast+S?=
 =?iso-8859-1?Q?ZGjA9nP3CJeyl9jgHjB2Cc0Y2w0KdPRLGwcmrZw7NUuESvSwD/0lmGuzpO?=
 =?iso-8859-1?Q?ElGkZS/FumBpQfPASjCh+PPRopUq0SYU4+3Tubyno/EXkGsaO7BXv7glz3?=
 =?iso-8859-1?Q?NEykWR47vfunffXsEV9tLOi/LePP5EqLX4SSztPp11q+AtfNAkuirwTVw7?=
 =?iso-8859-1?Q?5lJKEA2Hi4t1VRIDepyXX5fYB6KONAovXw+OzADvl/I2iyQaEDJCYkcFUB?=
 =?iso-8859-1?Q?s5dAW5BSVZQXVJ8ry78Bk04fQtCwAU4elJkMfVkF/I28z/YfYJWI5t5YO+?=
 =?iso-8859-1?Q?24hkvSriqu5KV6uqTRFkVMv6nok4svkaMn+x86j/EpQD7hYsBM56wABVM9?=
 =?iso-8859-1?Q?gi3LTye0MU/cIfDxKPJEBVuXQmun1fdtbm+OAnYLh4QTLil+RKV3u/K0H6?=
 =?iso-8859-1?Q?FD0kaWSSVAo2UmmglIzFVLU3hXFjlmgqUWZFVMKSZQLHLLJ2xWaPPlSAXX?=
 =?iso-8859-1?Q?GnYSP6PVCpgGmXc+RzmbhwARLlZ/ZXXvKhRmkWPiRofF9VzOCwmHY9v4r9?=
 =?iso-8859-1?Q?R11r+2ValQqhwSKa2LADuGoikNDXQUENpi5JXMf4Ea4syDyPjz+nZ8RBNL?=
 =?iso-8859-1?Q?zn/ZOrrZvQ1SCFqbf1gyEJWmqDCHcLDHl+2wDAiX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 417863ac-2d2d-4383-2755-08dde3a8ee0b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:28:05.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOxlG9DMPXyNcIc2EbeVftZi0IJzOHOk+NatZqOj273lZ53r7EdVQtudwGvoy0TLEPAXRmurRdF9ck5vyCDQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com

Hi Sasha, Greg and stable team,

please don't backport this patch and drop it from the queues for the
5.4, 5.10, 5.15, 6.1, 6.6, 6.12, 6.16 stable trees. It causes an issue
which is described at

https://lore.kernel.org/stable/aGaiASySvb3BVXlM@ideak-desk

I initially asked not to apply the patch to stable trees - and then it
was dropped as I requested - but as I understand now it still got
selected/queued automatically. Sorry for the trouble it caused, let me
know if there's a better way to avoid auto selecting such patches for
stable in the future (for one I can CC Sasha on such requests).

Thanks,
Imre

On Sun, Aug 24, 2025 at 10:49:17AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-dp-change-aux-dpcd-probe-address-from-dpcd_rev-to-lane0_1_status.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> From stable+bounces-172609-greg=kroah.com@vger.kernel.org Sat Aug 23 16:46:09 2025
> From: Sasha Levin <sashal@kernel.org>
> Date: Sat, 23 Aug 2025 10:44:36 -0400
> Subject: drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
> To: stable@vger.kernel.org
> Cc: "Imre Deak" <imre.deak@intel.com>, "Ville Syrj‰l‰" <ville.syrjala@linux.intel.com>, "Jani Nikula" <jani.nikula@linux.intel.com>, "Jani Nikula" <jani.nikula@intel.com>, "Sasha Levin" <sashal@kernel.org>
> Message-ID: <20250823144436.2255063-1-sashal@kernel.org>
> 
> From: Imre Deak <imre.deak@intel.com>
> 
> [ Upstream commit a40c5d727b8111b5db424a1e43e14a1dcce1e77f ]
> 
> Reading DPCD registers has side-effects in general. In particular
> accessing registers outside of the link training register range
> (0x102-0x106, 0x202-0x207, 0x200c-0x200f, 0x2216) is explicitly
> forbidden by the DP v2.1 Standard, see
> 
> 3.6.5.1 DPTX AUX Transaction Handling Mandates
> 3.6.7.4 128b/132b DP Link Layer LTTPR Link Training Mandates
> 
> Based on my tests, accessing the DPCD_REV register during the link
> training of an UHBR TBT DP tunnel sink leads to link training failures.
> 
> Solve the above by using the DP_LANE0_1_STATUS (0x202) register for the
> DPCD register access quirk.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Ville Syrj√§l√§ <ville.syrjala@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> Link: https://lore.kernel.org/r/20250605082850.65136-2-imre.deak@intel.com
> [ Call to drm_dp_dpcd_access() instead of drm_dp_dpcd_probe() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/drm_dp_helper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -280,7 +280,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_a
>  	 * We just have to do it before any DPCD access and hope that the
>  	 * monitor doesn't power down exactly after the throw away read.
>  	 */
> -	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV, buffer,
> +	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS, buffer,
>  				 1);
>  	if (ret != 1)
>  		goto out;
> 
> 
> Patches currently in stable-queue which might be from sashal@kernel.org are
> 
> queue-5.4/bluetooth-smp-fix-using-hci_error_remote_user_term-o.patch
> queue-5.4/pinctrl-stm32-manage-irq-affinity-settings.patch
> queue-5.4/scsi-bfa-double-free-fix.patch
> queue-5.4/scsi-libiscsi-initialize-iscsi_conn-dd_data-only-if-.patch
> queue-5.4/f2fs-fix-to-avoid-out-of-boundary-access-in-devs.pat.patch
> queue-5.4/net-ncsi-fix-buffer-overflow-in-fetching-version-id.patch
> queue-5.4/tcp-fix-tcp_ofo_queue-to-avoid-including-too-much-du.patch
> queue-5.4/kbuild-add-clang_flags-to-as-instr.patch
> queue-5.4/watchdog-dw_wdt-fix-default-timeout.patch
> queue-5.4/dmaengine-mv_xor-fix-missing-check-after-dma-map-and.patch
> queue-5.4/usb-chipidea-udc-fix-sleeping-function-called-from-i.patch
> queue-5.4/net-sched-restrict-conditions-for-adding-duplicating.patch
> queue-5.4/drm-amdgpu-fix-incorrect-vm-flags-to-map-bo.patch
> queue-5.4/pwm-mediatek-fix-duty-and-period-setting.patch
> queue-5.4/ethernet-intel-fix-building-with-large-nr_cpus.patch
> queue-5.4/usb-chipidea-udc-add-new-api-ci_hdrc_gadget_connect.patch
> queue-5.4/hfsplus-remove-mutex_lock-check-in-hfsplus_free_exte.patch
> queue-5.4/mmc-rtsx_usb_sdmmc-fix-error-path-in-sd_set_power_mo.patch
> queue-5.4/net-thunderx-fix-format-truncation-warning-in-bgx_ac.patch
> queue-5.4/cifs-fix-calling-cifsfindfirst-for-root-path-without.patch
> queue-5.4/net-appletalk-fix-kerneldoc-warnings.patch
> queue-5.4/comedi-fail-comedi_insnlist-ioctl-if-n_insns-is-too-large.patch
> queue-5.4/media-usb-hdpvr-disable-zero-length-read-messages.patch
> queue-5.4/media-tc358743-return-an-appropriate-colorspace-from.patch
> queue-5.4/net-appletalk-fix-use-after-free-in-aarp-proxy-probe.patch
> queue-5.4/rtc-hym8563-fix-incorrect-maximum-clock-rate-handlin.patch
> queue-5.4/smb-client-let-recv_done-cleanup-before-notifying-th.patch
> queue-5.4/rtc-pcf8563-fix-incorrect-maximum-clock-rate-handlin.patch
> queue-5.4/pwm-mediatek-implement-.apply-callback.patch
> queue-5.4/net-phy-smsc-add-proper-reset-flags-for-lan8710a.patch
> queue-5.4/hfsplus-fix-slab-out-of-bounds-read-in-hfsplus_uni2a.patch
> queue-5.4/s390-stp-remove-udelay-from-stp_sync_clock.patch
> queue-5.4/bluetooth-fix-null-ptr-deref-in-l2cap_sock_resume_cb.patch
> queue-5.4/m68k-don-t-unregister-boot-console-needlessly.patch
> queue-5.4/net-ipv4-fix-incorrect-mtu-in-broadcast-routes.patch
> queue-5.4/cpufreq-cppc-mark-driver-with-need_update_limits-fla.patch
> queue-5.4/virtio-net-ensure-the-received-length-does-not-exceed-allocated-size.patch
> queue-5.4/netpoll-prevent-hanging-napi-when-netcons-gets-enabl.patch
> queue-5.4/fs-buffer-fix-use-after-free-when-call-bh_read-helpe.patch
> queue-5.4/media-dvb-frontends-dib7090p-fix-null-ptr-deref-in-d.patch
> queue-5.4/usb-hub-don-t-try-to-recover-devices-lost-during-warm-reset.patch
> queue-5.4/samples-mei-fix-building-on-musl-libc.patch
> queue-5.4/asoc-hdac_hdmi-rate-limit-logging-on-connection-and-.patch
> queue-5.4/staging-nvec-fix-incorrect-null-termination-of-batte.patch
> queue-5.4/media-dvb-frontends-w7090p-fix-null-ptr-deref-in-w70.patch
> queue-5.4/bluetooth-smp-if-an-unallowed-command-is-received-co.patch
> queue-5.4/usb-chipidea-add-usb-phy-event.patch
> queue-5.4/pnfs-fix-uninited-ptr-deref-in-block-scsi-layout.patch
> queue-5.4/net-vlan-replace-bug-with-warn_on_once-in-vlan_dev_-.patch
> queue-5.4/crypto-img-hash-fix-dma_unmap_sg-nents-value.patch
> queue-5.4/uapi-in6-restore-visibility-of-most-ipv6-socket-opti.patch
> queue-5.4/arm-dts-imx6ul-kontron-bl-common-fix-rts-polarity-fo.patch
> queue-5.4/hwrng-mtk-handle-devm_pm_runtime_enable-errors.patch
> queue-5.4/wifi-iwlwifi-fix-memory-leak-in-iwl_mvm_init.patch
> queue-5.4/mtd-fix-possible-integer-overflow-in-erase_xfer.patch
> queue-5.4/tracing-add-down_write-trace_event_sem-when-adding-trace-event.patch
> queue-5.4/drbd-add-missing-kref_get-in-handle_write_conflicts.patch
> queue-5.4/netfilter-xt_nfacct-don-t-assume-acct-name-is-null-t.patch
> queue-5.4/mips-include-kbuild_cppflags-in-checkflags-invocation.patch
> queue-5.4/wifi-iwlwifi-mvm-fix-scan-request-validation.patch
> queue-5.4/x86-mce-amd-add-default-names-for-mca-banks-and-blocks.patch
> queue-5.4/usb-xhci-avoid-showing-errors-during-surprise-remova.patch
> queue-5.4/wifi-iwlwifi-dvm-fix-potential-overflow-in-rs_fill_l.patch
> queue-5.4/benet-fix-bug-when-creating-vfs.patch
> queue-5.4/crypto-marvell-cesa-fix-engine-load-inaccuracy.patch
> queue-5.4/pci-hotplug-pnv-php-wrap-warnings-in-macro.patch
> queue-5.4/soundwire-stream-restore-params-when-prepare-ports-f.patch
> queue-5.4/move_mount-allow-to-add-a-mount-into-an-existing-gro.patch
> queue-5.4/ice-fix-a-null-pointer-dereference-in-ice_copy_and_init_pkg.patch
> queue-5.4/arm64-handle-kcov-__init-vs-inline-mismatches.patch
> queue-5.4/pci-pnv_php-work-around-switches-with-broken-presenc.patch
> queue-5.4/thermal-sysfs-return-enodata-instead-of-eagain-for-r.patch
> queue-5.4/kconfig-lxdialog-replace-strcpy-with-strncpy-in-inpu.patch
> queue-5.4/kconfig-lxdialog-fix-space-to-de-select-options.patch
> queue-5.4/hfs-fix-slab-out-of-bounds-in-hfs_bnode_read.patch
> queue-5.4/et131x-add-missing-check-after-dma-map.patch
> queue-5.4/asoc-codecs-rt5640-retry-device_id-verification.patch
> queue-5.4/comedi-comedi_test-fix-possible-deletion-of-uninitialized-timers.patch
> queue-5.4/usb-typec-fusb302-cache-pd-rx-state.patch
> queue-5.4/gpio-tps65912-check-the-return-value-of-regmap_updat.patch
> queue-5.4/pptp-fix-pptp_xmit-error-path.patch
> queue-5.4/rcu-protect-defer_qs_iw_pending-from-data-race.patch
> queue-5.4/mips-don-t-crash-in-stack_top-for-tasks-without-abi-.patch
> queue-5.4/net-drop-ufo-packets-in-udp_rcv_segment.patch
> queue-5.4/scsi-aacraid-stop-using-pci_irq_affinity.patch
> queue-5.4/usb-chipidea-introduce-ci_hdrc_controller_vbus_event.patch
> queue-5.4/serial-8250-fix-panic-due-to-pslverr.patch
> queue-5.4/power-supply-max14577-handle-null-pdata-when-config_.patch
> queue-5.4/kbuild-add-clang_flags-to-kbuild_cppflags.patch
> queue-5.4/mm-zsmalloc.c-convert-to-use-kmem_cache_zalloc-in-cache_alloc_zspage.patch
> queue-5.4/kconfig-gconf-fix-potential-memory-leak-in-renderer_.patch
> queue-5.4/pnfs-fix-stripe-mapping-in-block-scsi-layout.patch
> queue-5.4/fbdev-imxfb-check-fb_add_videomode-to-prevent-null-p.patch
> queue-5.4/net-fec-allow-disable-coalescing.patch
> queue-5.4/mtd-rawnand-atmel-fix-dma_mapping_error-address.patch
> queue-5.4/net-dsa-b53-fix-ip_multicast_ctrl-on-bcm5325.patch
> queue-5.4/pm-runtime-clear-power.needs_force_resume-in-pm_runt.patch
> queue-5.4/hfsplus-don-t-use-bug_on-in-hfsplus_create_attribute.patch
> queue-5.4/powerpc-512-fix-possible-dma_unmap_single-on-uniniti.patch
> queue-5.4/crypto-qat-fix-seq_file-position-update-in-adf_ring_.patch
> queue-5.4/media-uvcvideo-fix-bandwidth-issue-for-alcor-camera.patch
> queue-5.4/jfs-truncate-good-inode-pages-when-hard-link-is-0.patch
> queue-5.4/selftests-futex-define-sys_futex-on-32-bit-architect.patch
> queue-5.4/nfs-fix-up-handling-of-outstanding-layoutcommit-in-nfs_update_inode.patch
> queue-5.4/alsa-usb-audio-avoid-precedence-issues-in-mixer_quir.patch
> queue-5.4/ext4-do-not-bug-when-inline_data_fl-lacks-system.dat.patch
> queue-5.4/clk-sunxi-ng-v3s-fix-de-clock-definition.patch
> queue-5.4/usb-xhci-print-xhci-xhc_state-when-queue_command-fai.patch
> queue-5.4/be2net-use-correct-byte-order-and-format-string-for-.patch
> queue-5.4/net-sched-return-null-when-htb_lookup_leaf-encounter.patch
> queue-5.4/scsi-fix-sas_user_scan-to-handle-wildcard-and-multi-.patch
> queue-5.4/pnfs-handle-rpc-size-limit-for-layoutcommits.patch
> queue-5.4/mtd-rawnand-atmel-set-pmecc-data-setup-time.patch
> queue-5.4/pm-sleep-console-fix-the-black-screen-issue.patch
> queue-5.4/dmaengine-nbpfaxi-add-missing-check-after-dma-map.patch
> queue-5.4/vrf-drop-existing-dst-reference-in-vrf_ip6_input_dst.patch
> queue-5.4/wifi-rtl818x-kill-urbs-before-clearing-tx-status-que.patch
> queue-5.4/pinctrl-sunxi-fix-memory-leak-on-krealloc-failure.patch
> queue-5.4/ipmi-use-dev_warn_ratelimited-for-incorrect-message-.patch
> queue-5.4/can-kvaser_pciefd-store-device-channel-index.patch
> queue-5.4/nfs-fix-filehandle-bounds-checking-in-nfs_fh_to_dent.patch
> queue-5.4/usb-dwc3-qcom-don-t-leave-bcr-asserted.patch
> queue-5.4/udp-also-consider-secpath-when-evaluating-ipsec-use-.patch
> queue-5.4/net-usbnet-avoid-potential-rcu-stall-on-link_change-event.patch
> queue-5.4/drm-dp-change-aux-dpcd-probe-address-from-dpcd_rev-to-lane0_1_status.patch
> queue-5.4/alsa-hda-ca0132-fix-buffer-overflow-in-add_tuning_co.patch
> queue-5.4/selftests-tracing-use-mutex_unlock-for-testing-glob-.patch
> queue-5.4/clk-davinci-add-null-check-in-davinci_lpsc_clk_regis.patch
> queue-5.4/mm-kmemleak-turn-kmemleak_lock-and-object-lock-to-raw_spinlock_t.patch
> queue-5.4/wifi-rtlwifi-fix-possible-skb-memory-leak-in-_rtl_pc.patch
> queue-5.4/caif-reduce-stack-size-again.patch
> queue-5.4/bpf-check-flow_dissector-ctx-accesses-are-aligned.patch
> queue-5.4/usb-core-usb_submit_urb-downgrade-type-check.patch
> queue-5.4/wifi-iwlwifi-fw-fix-possible-memory-leak-in-iwl_fw_d.patch
> queue-5.4/wifi-cfg80211-reject-htc-bit-for-management-frames.patch
> queue-5.4/udf-verify-partition-map-count.patch
> queue-5.4/kbuild-update-assembler-calls-to-use-proper-flags-and-language-target.patch
> queue-5.4/usb-xhci-avoid-showing-warnings-for-dying-controller.patch
> queue-5.4/usb-hub-fix-detection-of-high-tier-usb3-devices-behind-suspended-hubs.patch
> queue-5.4/bpf-ktls-fix-data-corruption-when-using-bpf_msg_pop_.patch
> queue-5.4/iio-hid-sensor-prox-fix-incorrect-offset-calculation.patch
> queue-5.4/pptp-ensure-minimal-skb-length-in-pptp_xmit.patch
> queue-5.4/xhci-disable-stream-for-xhc-controller-with-xhci_broken_streams.patch
> queue-5.4/rtc-ds1307-handle-oscillator-stop-flag-osf-for-ds1341.patch
> queue-5.4/net-vlan-fix-vlan-0-refcount-imbalance-of-toggling-f.patch
> queue-5.4/media-v4l2-ctrls-always-copy-the-controls-on-completion.patch
> queue-5.4/media-tc358743-check-i2c-succeeded-during-probe.patch
> queue-5.4/i3c-add-missing-include-to-internal-header.patch
> queue-5.4/usb-chipidea-udc-protect-usb-interrupt-enable.patch
> queue-5.4/mm-kmemleak-avoid-deadlock-by-moving-pr_warn-outside-kmemleak_lock.patch
> queue-5.4/scsi-lpfc-remove-redundant-assignment-to-avoid-memor.patch
> queue-5.4/selftests-rtnetlink.sh-remove-esp4_offload-after-tes.patch
> queue-5.4/f2fs-fix-to-avoid-uaf-in-f2fs_sync_inode_meta.patch
> queue-5.4/usb-hub-avoid-warm-port-reset-during-usb3-disconnect.patch
> queue-5.4/nfsd-handle-get_client_locked-failure-in-nfsd4_setclientid_confirm.patch
> queue-5.4/cpufreq-exit-governor-when-failed-to-start-old-gover.patch
> queue-5.4/vmci-prevent-the-dispatching-of-uninitialized-payloa.patch
> queue-5.4/mips-vpe-mt-add-missing-prototypes-for-vpe_-alloc-st.patch
> queue-5.4/wifi-brcmfmac-fix-p2p-discovery-failure-in-p2p-peer-.patch
> queue-5.4/asoc-soc-dapm-set-bias_level-if-snd_soc_dapm_set_bia.patch
> queue-5.4/staging-fbtft-fix-potential-memory-leak-in-fbtft_fra.patch
> queue-5.4/usb-phy-mxs-disconnect-line-when-usb-charger-is-atta.patch
> queue-5.4/pci-acpi-fix-runtime-pm-ref-imbalance-on-hot-plug-capable-ports.patch
> queue-5.4/media-rainshadow-cec-fix-toctou-race-condition-in-rain_interrupt.patch
> queue-5.4/module-restore-the-moduleparam-prefix-length-check.patch
> queue-5.4/f2fs-fix-to-avoid-out-of-boundary-access-in-dnode-page.patch
> queue-5.4/usb-musb-omap2430-convert-to-platform-remove-callback-returning-void.patch
> queue-5.4/pci-rockchip-host-fix-unexpected-completion-log-mess.patch
> queue-5.4/usb-xhci-set-avg_trb_len-8-for-ep0-during-address-de.patch
> queue-5.4/usb-cdc-acm-do-not-log-successful-probe-on-later-errors.patch
> queue-5.4/hfsplus-fix-slab-out-of-bounds-in-hfsplus_bnode_read.patch
> queue-5.4/net-sched-sch_qfq-avoid-triggering-might_sleep-in-at.patch
> queue-5.4/acpi-apei-ghes-add-taint_machine_check-on-ghes-panic.patch
> queue-5.4/net-dsa-b53-prevent-switch_ctrl-access-on-bcm5325.patch
> queue-5.4/net-sched-sch_qfq-fix-race-condition-on-qfq_aggregat.patch
> queue-5.4/perf-tests-bp_account-fix-leaked-file-descriptor.patch
> queue-5.4/netfilter-nf_tables-adjust-lockdep-assertions-handli.patch
> queue-5.4/hfs-fix-not-erasing-deleted-b-tree-node-issue.patch
> queue-5.4/rtc-ds1307-remove-clear-of-oscillator-stop-flag-osf-.patch
> queue-5.4/can-kvaser_usb-assign-netdev.dev_port-based-on-devic.patch
> queue-5.4/arm-tegra-use-i-o-memcpy-to-write-to-iram.patch
> queue-5.4/scsi-ibmvscsi_tgt-fix-dma_unmap_sg-nents-value.patch
> queue-5.4/rdma-hfi1-fix-possible-divide-by-zero-in-find_hw_thr.patch
> queue-5.4/pwm-mediatek-handle-hardware-enable-and-clock-enable-separately.patch
> queue-5.4/jfs-upper-bound-check-of-tree-index-in-dballocag.patch
> queue-5.4/alsa-hda-add-missing-nvidia-hda-codec-ids.patch
> queue-5.4/bpftool-fix-memory-leak-in-dump_xx_nlmsg-on-realloc-.patch
> queue-5.4/x86-fpu-delay-instruction-pointer-fixup-until-after-warning.patch
> queue-5.4/usb-net-sierra-check-for-no-status-endpoint.patch
> queue-5.4/drm-sched-remove-optimization-that-causes-hang-when-killing-dependent-jobs.patch
> queue-5.4/revert-vmci-prevent-the-dispatching-of-uninitialized.patch
> queue-5.4/ata-fix-sata_mobile_lpm_policy-description-in-kconfig.patch
> queue-5.4/crypto-ccp-fix-crash-when-rebind-ccp-device-for-ccp..patch
> queue-5.4/netfilter-ctnetlink-fix-refcount-leak-on-table-dump.patch
> queue-5.4/fs-orangefs-allow-2-more-characters-in-do_c_string.patch
> queue-5.4/pci-hotplug-pnv-php-improve-error-msg-on-power-state.patch
> queue-5.4/btrfs-populate-otime-when-logging-an-inode-item.patch
> queue-5.4/drm-amd-pm-powerplay-hwmgr-smu_helper-fix-order-of-m.patch
> queue-5.4/bluetooth-l2cap-fix-attempting-to-adjust-outgoing-mt.patch
> queue-5.4/ktest.pl-prevent-recursion-of-default-variable-optio.patch
> queue-5.4/fs-orangefs-use-snprintf-instead-of-sprintf.patch
> queue-5.4/ipv6-reject-malicious-packets-in-ipv6_gso_segment.patch
> queue-5.4/nfsv4-fix-nfs4_bitmap_copy_adjust.patch
> queue-5.4/scsi-isci-fix-dma_unmap_sg-nents-value.patch
> queue-5.4/arch-powerpc-defconfig-drop-obsolete-config_net_cls_.patch
> queue-5.4/net-dsa-b53-fix-b53_imp_vlan_setup-for-bcm5325.patch
> queue-5.4/s390-time-use-monotonic-clock-in-get_cycles.patch
> queue-5.4/asoc-intel-fix-snd_soc_sof-dependencies.patch
> queue-5.4/f2fs-fix-to-do-sanity-check-on-ino-and-xnid.patch
> queue-5.4/arm-9448-1-use-an-absolute-path-to-unified.h-in-kbuild_aflags.patch
> queue-5.4/scsi-mvsas-fix-dma_unmap_sg-nents-value.patch
> queue-5.4/media-venus-vdec-clamp-param-smaller-than-1fps-and-bigger-than-240.patch
> queue-5.4/kbuild-add-kbuild_cppflags-to-as-option-invocation.patch
> queue-5.4/pnfs-fix-disk-addr-range-check-in-block-scsi-layout.patch
> queue-5.4/wifi-iwlegacy-check-rate_idx-range-after-addition.patch
> queue-5.4/jfs-regular-file-corruption-check.patch
> queue-5.4/usb-musb-fix-gadget-state-on-disconnect.patch
> queue-5.4/kconfig-gconf-avoid-hardcoding-model2-in-on_treeview.patch
> queue-5.4/pps-fix-poll-support.patch
> queue-5.4/media-venus-protect-against-spurious-interrupts-during-probe.patch
> queue-5.4/alsa-intel8x0-fix-incorrect-codec-index-usage-in-mix.patch
> queue-5.4/usb-early-xhci-dbc-fix-early_ioremap-leak.patch
> queue-5.4/net-emaclite-fix-missing-pointer-increment-in-aligne.patch
> queue-5.4/iwlwifi-add-missing-check-for-alloc_ordered_workqueu.patch
> queue-5.4/nfs-fix-the-setting-of-capabilities-when-automounting-a-new-filesystem.patch
> queue-5.4/mwl8k-add-missing-check-after-dma-map.patch
> queue-5.4/usb-musb-omap2430-fix-device-leak-at-unbind.patch
> queue-5.4/scsi-mpt3sas-correctly-handle-ata-device-errors.patch
> queue-5.4/f2fs-fix-to-avoid-panic-in-f2fs_evict_inode.patch
> queue-5.4/wifi-rtl8xxxu-fix-rx-skb-size-for-aggregation-disabl.patch
> queue-5.4/net-ag71xx-add-missing-check-after-dma-map.patch
> queue-5.4/pm-cpupower-fix-the-snapshot-order-of-tsc-mperf-cloc.patch
> queue-5.4/ipmi-fix-strcpy-source-and-destination-the-same.patch
> queue-5.4/wifi-cfg80211-fix-interface-type-validation.patch
> queue-5.4/kconfig-nconf-ensure-null-termination-where-strncpy-.patch
> queue-5.4/rdma-core-rate-limit-gid-cache-warning-messages.patch
> queue-5.4/regulator-core-fix-null-dereference-on-unbind-due-to.patch
> queue-5.4/alsa-scarlett2-add-retry-on-eproto-from-scarlett2_usb_tx.patch
> queue-5.4/cdc-acm-fix-race-between-initial-clearing-halt-and-open.patch
> queue-5.4/netmem-fix-skb_frag_address_safe-with-unreadable-skb.patch
> queue-5.4/vhost-fail-early-when-__vhost_add_used-fails.patch
> queue-5.4/i3c-don-t-fail-if-gethdrcap-is-unsupported.patch
> queue-5.4/media-tc358743-increase-fifo-trigger-level-to-374.patch
> queue-5.4/watchdog-ziirave_wdt-check-record-length-in-ziirave_.patch
> queue-5.4/pmdomain-governor-consider-cpu-latency-tolerance-from-pm_domain_cpu_gov.patch
> queue-5.4/fs-prevent-file-descriptor-table-allocations-exceeding-int_max.patch
> queue-5.4/arm-dts-vfxxx-correctly-use-two-tuples-for-timer-add.patch
> queue-5.4/rtc-ds1307-fix-incorrect-maximum-clock-rate-handling.patch
> queue-5.4/mm-zsmalloc-do-not-pass-__gfp_movable-if-config_compaction-n.patch
> queue-5.4/platform-x86-thinkpad_acpi-handle-kcov-__init-vs-inl.patch
> queue-5.4/scsi-lpfc-check-for-hdwq-null-ptr-when-cleaning-up-l.patch
> queue-5.4/media-venus-hfi-explicitly-release-irq-during-teardown.patch
> queue-5.4/reapply-wifi-mac80211-update-skb-s-control-block-key.patch
> queue-5.4/securityfs-don-t-pin-dentries-twice-once-is-enough.patch
> queue-5.4/soc-qcom-mdt_loader-ensure-we-don-t-read-past-the-elf-header.patch
> queue-5.4/acpi-processor-fix-acpi_object-initialization.patch
> queue-5.4/arm-rockchip-fix-kernel-hang-during-smp-initializati.patch
> queue-5.4/jfs-fix-metapage-reference-count-leak-in-dballocctl.patch
> queue-5.4/sctp-linearize-cloned-gso-packets-in-sctp_rcv.patch
> queue-5.4/media-qcom-camss-cleanup-media-device-allocated-resource-on-error-path.patch
> queue-5.4/comedi-fix-initialization-of-data-for-instructions-that-write-to-subdevice.patch
> queue-5.4/media-v4l2-ctrls-don-t-reset-handler-s-error-in-v4l2_ctrl_handler_free.patch
> queue-5.4/use-uniform-permission-checks-for-all-mount-propagat.patch
> queue-5.4/cpufreq-init-policy-rwsem-before-it-may-be-possibly-.patch
> queue-5.4/asoc-ops-dynamically-allocate-struct-snd_ctl_elem_va.patch
> queue-5.4/mm-hmm-move-pmd_to_hmm_pfn_flags-to-the-respective-ifdeffery.patch

