Return-Path: <stable+bounces-169409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D49BB24C65
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7153917160A
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76B35977;
	Wed, 13 Aug 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pja3SAyi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E42E41E
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096326; cv=fail; b=Ia80QTXN5Vqzu9JVqqUCQx9KD+0Lc9XV20vUKPZkTxJeGKdWZHzsBYFbRfD6sBsLW1hVK1p7P5JhTppr1zqelp8tCh2HqNz5CZrxzVNVyNakHtd+h6omSC4K7/PMcnWuUmJ/ewfD5EE+mfyJZa055OjUBpj4mdN0fGlMfVB1lwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096326; c=relaxed/simple;
	bh=FJZYbyOfFmc+XgKNhVjjjuCKLDZXA9kpCkrCPXij41s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1u8vp8MseqsaDW0BKkVjG//fbUJ1bUbATehuYflsaYkYlVEWHuxHFCYXoBl1lckOwEpHawPWZj+LSmGAt5sHbn0dL5xCu5CMQHz1TRJwcDic/AzXXfslEtKd0HpVGlBqfUFuzYIR4JPUn1P/X4SdF6c4oul0tOEIs+adlRT87I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pja3SAyi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755096326; x=1786632326;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FJZYbyOfFmc+XgKNhVjjjuCKLDZXA9kpCkrCPXij41s=;
  b=Pja3SAyiQlJDo1/F96rNZQWN3Ir2oMwsptqw/4PtTnK7ycktcCzep34J
   sL3Djc33TRARc8zV54z6BIJeicAxc2By4ixR+b88uAwmI538TCeA7PJ7a
   x+FhcHu66Ihj/4x6SoX8p+9z12MKCPICwBEnES4e3/+etHsb8aAGHLJGX
   QUgBqC3liMOq7+4AJ4eC3ZttIEA2fAK1CLDcvMHE+2XQNBHiATo/e75pF
   EZiYZBbCxKobM1atI72KEkX3GdwhOckUsL69KnAWp5sJtnxS5zL5pZhm2
   LXe3jpnzQCmurE6VgjXR+SGrT5uqR8z8z7mmcGSwRT5yfQONZ+GjluIpr
   g==;
X-CSE-ConnectionGUID: 3E+6nDXFQKuEIZaqMw9gXQ==
X-CSE-MsgGUID: o4QF7oVcQlmp40HiMCrxbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74841503"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74841503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:45:24 -0700
X-CSE-ConnectionGUID: ySzEssOiRoy27NtC4tZ+6g==
X-CSE-MsgGUID: yO/iZuuaTSOsapTUmcwmdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166379825"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:45:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 07:45:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 07:45:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 07:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTz66lhftYNn3DnddVg2jyuFswldE75hrpVufGpZj7qd24h0lOfpjFdPajCPDuau8tnRO5+UcoULfLpUrXZw3pjnKVmNVMgCg/4W2TNx3FXvot8S+yueY/V75gnP8l8DmizC17l/yxaL4g4c7NCEjPXHLA8IKjGCMzJEQVF7VKgHOiOp10KSD35QPs1LQkmXxjNwUuipmeXlCqZ1lqgSJKykzrVT7ViHYKvdAHx8LMWRjKzr4GYTm7lQwZ16sdmQGo9dzRXy93b8UUnw/Jz4ysJH55uaSlikr0lWrQQmT3QJ1dv09078bLsHH0ixPrtcI8cxAxRF2pYLhCnDe7rZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtYtTAULr7S/cwXcq5I/kbSeHUq/xp3B6yqoLGQv2/8=;
 b=mouMz4l6owvXjrq4jtJpt1LjIuQaeYBQwfUXnp74+TvzT8wPe0x/3SmK6lpJNC5fvTP6B1SIte9b3CVORVaDjRsmpcxzlyZxRSRmsJ9lZA825N5gvGp+RI4JxtEOqAOfTirMPOXB0F0C2XYH79cfgqdh5T499OuEWu4A/nr1KBOEOkuhK35tIF6W06OassIWV15LpetEwu4kCNhMZihGS7H3HW6J4k+xB0xh2x2JQunR3B1SkOe2PePllNkFFRY951DXm78aftLHcxgTiZ7O+cFFix0dsMOGaqgaoqMR4c7aSkJT5K4nvAOWWthheNlwi+t7rr82O6UGytdKu1C0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 14:45:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 14:45:03 +0000
Date: Wed, 13 Aug 2025 07:45:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Brian Welty <brian.welty@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Matthew Auld
	<matthew.auld@intel.com>
Subject: Re: [PATCH 03/15] drm/xe/vm: Clear the scratch_pt pointer on error
Message-ID: <aJyk7FUmW6PDfost@lstrano-desk.jf.intel.com>
References: <20250813105121.5945-1-thomas.hellstrom@linux.intel.com>
 <20250813105121.5945-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813105121.5945-4-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BY1PR11MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: faeaed6b-5d25-4cb1-9747-08ddda77fcb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lw53ur0dPUL0al8axxUAza8VgD0VjyRCUnAkOALgN6QiLsOv13tBR4qDMo?=
 =?iso-8859-1?Q?lUirUwv5koIdCP+7+qAoZKEL+5v+/BAiqpQn/KtAI+9G6PjDm59Bzr8yiz?=
 =?iso-8859-1?Q?Tb2V85aQeqXYotktk9WNdwfbAxhzdpGFYCX4r04xpLJ1omGC2Xe3d/KTYt?=
 =?iso-8859-1?Q?FC6p9nS4SMThS5vl3E4eR7Z6F3XLegHOhD46bKadpTuk+vpd1D4lz57HXj?=
 =?iso-8859-1?Q?jkHsD/7CQSlsBLQ4a/pHVZnZ5DpU/6IWj74wVNQNYLicwCWDGgrhdeKJaI?=
 =?iso-8859-1?Q?tWXj+q0wGuIsUpxNx34xSRaWhu4Ni+jIOJ97naFWEuA1+ZTbvuqN3bPYqI?=
 =?iso-8859-1?Q?xsLfnu5pLGrt1yzYldSaFIw0nxqahxPdTvkMSnhDKRvFP/bKc358NGMuNj?=
 =?iso-8859-1?Q?Zq7AnGC2+NE6p05Mu6JMiCOxlPMAJh4g/88ZSt1tOn62yJTQwGXleSCge3?=
 =?iso-8859-1?Q?ngOjziRUBpNnc/exRyjwxPwdcanDNn+mCG1kLY+zcfDbDDknDnIM69G3DV?=
 =?iso-8859-1?Q?HO036pkQvQ9AyGh6tg6qUmjMUgXQba+bcvWHUEAP0GdBIoJLt6LGvz0c13?=
 =?iso-8859-1?Q?PIQIf0jLUDTU8OBFB4yxW7i2Cb23lIULhT6+SNt2QecdUXgRoWBnZEmvwZ?=
 =?iso-8859-1?Q?SQ7ksG2R5pkcDy1FP2ccZdHwOHe5EHN/LAFOmYef+N3D5Ys/rEzHfQVnwz?=
 =?iso-8859-1?Q?t6fCYPijgAJRADQTLRKpsv4xH1vsR/QEoohp598cAstVS1KsrhMYSRKMfV?=
 =?iso-8859-1?Q?oo950hXddccAuidadaStL9R2m1Cu6gQgqnaSJfdHUf1jijwVf5tU9IXerX?=
 =?iso-8859-1?Q?tZuARtKbY7JIA1XDeG99/qyxmN2dqM4XFBYdI1gYZAmBRTMeDsyRzofgNs?=
 =?iso-8859-1?Q?p5MiulCUg3sqQO6UHs7W3H9tHkv1my4iu4rH9N+09T6+V2r8jnHiXn33Tw?=
 =?iso-8859-1?Q?8/lahknLFrGaJ82u7PMoq3aDTFDFwdOTLLX3tONzMNThQUMejmdeUptD6/?=
 =?iso-8859-1?Q?O9XWVNboWDFsW+F5tMQ0idLqmz4kI5WIrYva37aNXz3Pk9vjd/VhQm2LNq?=
 =?iso-8859-1?Q?DfEUedOR61glwraPRElM1rm6QZM3exUQddAoXPPLmki2ALq9gGqLxv0Tai?=
 =?iso-8859-1?Q?ev9T/i+ZOZcOuiu1T1EtzJSB2inGJ00JKaz7fN64cNXNGquAVyNiAsIiCQ?=
 =?iso-8859-1?Q?Sz9RR0lepzpNqzo1TzGoKiisl4q19yp9em+kGU49DhrR5yQnZX/S9Ly7TN?=
 =?iso-8859-1?Q?YtCBIXK9xU856OOvvqtNneZLxyNmaEunC6YJl/nCch7jrJG/FgiAaCz+G7?=
 =?iso-8859-1?Q?OtdgGcq2v7xznpVJ/oU0Pu5VFcX4WVsFBevChLf/Yttg+RklXJXh/ECZAi?=
 =?iso-8859-1?Q?N2GjVUt5FGF0G5EYgF71hY8Bm//CFaHX/HScyDgRGgEebHajebIe6wHzJA?=
 =?iso-8859-1?Q?cCL8eSNHMrgfJj6/Qur14XAvKOBNGpf8ZElAGCw4Laq6h67bkxV73EYY40?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G77HPz1uK1Et9qxo5V9SyGCPx1SIvS5aYaYn3LCV9fWRcUwJxiHk0axb7+?=
 =?iso-8859-1?Q?pxDuPyIouN07f9MleDoBr7KEcsVi9HNggKRXexCBwUJ3y2nNLzXyAXYHzH?=
 =?iso-8859-1?Q?+WYos1WUQNfTfRTrLg59YvoWv7JVc/x3yVHP34IyumB8XO+sRu4gpoJwjP?=
 =?iso-8859-1?Q?fKTIn0g30mNiF9rD0HM62XCqT1iWLCvvZqf2oTSGMQx/Us4ofhesZuRVez?=
 =?iso-8859-1?Q?K4HHvDfAOoNT9A5c6NGExXoOxz+7H4whcmO3XHgD8g2znp0d9kaXy4q5rH?=
 =?iso-8859-1?Q?lz+2P7n/iylFKoWgWJPNzQVR7OB369LIyGbJXQ46bEGBxk8q6XzQFNLpm9?=
 =?iso-8859-1?Q?oyYU1EE6J4b/7tLycbDSfOnE4Tok/sigxGRpnVi/k7LcqMx1Dmhat/GL+l?=
 =?iso-8859-1?Q?RCS/cPdrHD30of3CLH+BTgrQZQRRSBR6D7zn9gO7KLOBqqIUSaqWGZaG4g?=
 =?iso-8859-1?Q?38TmTk6NX+vqZfFZHo2FwCcttBq30/YPjpAWJ48eR6HR/4+SnPhVxBeiUU?=
 =?iso-8859-1?Q?07qnbMDjUZcbq/BB6DYs4RXP4XQOhFKg2nWDqD2mReZZ6zGQy2kQdVzr4S?=
 =?iso-8859-1?Q?sDkE4UIWF4GytuHaLAj7UgIFpWZzjRhbVLLbEQVsa/Fte+mjhBeUPk0z5n?=
 =?iso-8859-1?Q?5bDBNgsjcrHiHKoVMvGFL054L2ogaBPQFogl4I6iBUDUsuSabCxUgFwUEL?=
 =?iso-8859-1?Q?vnjp4hnwI5yxt0Uq5jN7eolEoiz0dRWmO3/VUnvnCVfdHOYhy9qlBdqiEc?=
 =?iso-8859-1?Q?S8ZPJHzhtitDxpZ/u/SHww4MmoAKVCmg4skthxwsl0NlfJ0nyp2gElSfxT?=
 =?iso-8859-1?Q?fvf75i0vkZ9o9QEbF89PhjS3Gxfb87UoyIDO/v5MYJWVpbB++u+YzMmb1/?=
 =?iso-8859-1?Q?cCms9caFkZPa/hCSwe9zvGxRNhWnUGdqT03EqNU+/f4lMCm2lUJswuMaqe?=
 =?iso-8859-1?Q?jFnr+5/wvPkS4cN6xh/h9kzMmtBgiIz88iE/jVySn6OgCwXMPh84M+ot2A?=
 =?iso-8859-1?Q?YUHa/gRXpjBv3Obd6qyaPAxjLRSS9WTl/FmeOe6U8y0xEDeTSbJlS5qJTK?=
 =?iso-8859-1?Q?pWOopyAC92xSu9igpt7eMKLapwYHi1g5mS2TgixdoHhWxgvrCy8s5I5VA3?=
 =?iso-8859-1?Q?RTNgI8y5t7Kdb11FSjglO8v8fTpxsH4pl8ny8OJsTo6KXkWNCALLVlSPah?=
 =?iso-8859-1?Q?GR+fFIvJko+0ZYkn/U6ZL33rIupY7NkE0ZKV2RLByIc6dPPXGtWZ6T1OJe?=
 =?iso-8859-1?Q?4lOQsVlmsljD0/QuxLm6BA/LGRXtJZx1DWUeQ1FQE1y389VxIAadXoLLPw?=
 =?iso-8859-1?Q?HEdzao0VoW9vfy+GqJOff+tXzRt8Hx1oqjYgEN3UDNpNQX7WWtFuCSy6ra?=
 =?iso-8859-1?Q?hyXKesGDFPcWPvetWItWEvrllAmtGvU3H1eimzAAX07l9FtuDhphNsvome?=
 =?iso-8859-1?Q?V2sAief6HwVDYCYF29ssY3oHGyLa3au1GWbcPicYdq4Jef5lU1HgB7AMg9?=
 =?iso-8859-1?Q?qWm8ITk333odx9cy/8XgY0iEia8vu/RvosSyLf4xqbj0hM4KlSGtgnk17K?=
 =?iso-8859-1?Q?E5SnMwJSRh66fDo91re0DXXy7LQMUkhyHoRVlZUH8SnqulRH8WZ8n//Qbm?=
 =?iso-8859-1?Q?X3C4u96lQW8iMxKvERLRgXDfRVz54YOIkPr4fTkUQlrqCmuddgQvKXfw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faeaed6b-5d25-4cb1-9747-08ddda77fcb2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:45:03.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImK0oMJKxT1yfKUQkBsRr3ZrwZikVS1aYfM6HSOmffwmzDXYpL8lFUjvW/byLDhvY7YLGs9GSOjsYO5j60Wepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

On Wed, Aug 13, 2025 at 12:51:09PM +0200, Thomas Hellström wrote:
> Avoid triggering a dereference of an error pointer on cleanup in
> xe_vm_free_scratch() by clearing any scratch_pt error pointer.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Fixes: 06951c2ee72d ("drm/xe: Use NULL PTEs as scratch PTEs")
> Cc: Brian Welty <brian.welty@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_vm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d40d2d43c041..12e661960244 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1635,8 +1635,12 @@ static int xe_vm_create_scratch(struct xe_device *xe, struct xe_tile *tile,
>  
>  	for (i = MAX_HUGEPTE_LEVEL; i < vm->pt_root[id]->level; i++) {
>  		vm->scratch_pt[id][i] = xe_pt_create(vm, tile, i);
> -		if (IS_ERR(vm->scratch_pt[id][i]))
> -			return PTR_ERR(vm->scratch_pt[id][i]);
> +		if (IS_ERR(vm->scratch_pt[id][i])) {
> +			int err = PTR_ERR(vm->scratch_pt[id][i]);
> +
> +			vm->scratch_pt[id][i] = NULL;
> +			return err;
> +		}
>  
>  		xe_pt_populate_empty(tile, vm, vm->scratch_pt[id][i]);
>  	}
> -- 
> 2.50.1
> 

