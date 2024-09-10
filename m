Return-Path: <stable+bounces-75655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4C9739B3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7841C20DAD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6B6A01E;
	Tue, 10 Sep 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzNg5sNg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA25142659
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977928; cv=fail; b=d83fhX37aPmcBoSDIJOSZWNuwyOiBn4Qy9WnjhJ3lY6zEJa8Vrwto/ngGROTL/RRPf181L4q6smYLoU580kE79fdQms2x+/2USgiTmNxOLaxnxRpqKJL6onQRTGL2IHcb6I/8cyC1tNQ3ss65iHOZYV+5xnZPjlSR/9086R7OzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977928; c=relaxed/simple;
	bh=AvsX4zf/at267eIUS5BHZc6Ubu07TvrvX+tasVxgetM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FQWiw8M4t4okPodo0VZzJ3f4vSFK5RCgCKKAnG1EHxw9l6fSqyB6UyWtFvXhZqCF8vLJFwhDKjj2xmO45hd3QUSulpKTnYl5nViIp0rh7Vkso6kz2LtWKc69nGyE1Kd4gmte0TAVCrVuG6wtaNjm6deyP/B+BxR6/HLlp7FqA2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzNg5sNg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725977927; x=1757513927;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AvsX4zf/at267eIUS5BHZc6Ubu07TvrvX+tasVxgetM=;
  b=PzNg5sNgKT5SqIDzskp46o2oat2L/HMvSjA/kEMj/JewWo2C4Z18yXXz
   pvTEj26PlDzZkE1dPRL4AIVp1qZg/JmMlEGIyA8rLjWvMMqY3LshEKyC2
   2hZVAm+5zkB4JQ0AeyhoIZEXNY2R5dOmp51U1C6WyyTwLKVyCV80Vne9+
   yqo8P3kp19rAcSG1nW/5Pc9PAc/z8dkSGC1PLS7EwS5b8gXlAawSN9WRj
   GhHutNHilMqnj/u1cham7HQEWtcxxJOfiZp+R2lYe+1TvlSrIrfTZh95i
   ihrBEFHrf7vfCxuS9pbxivzP892o2GqD2CmtRzu9skhoFVz+thVpl1Yk+
   Q==;
X-CSE-ConnectionGUID: lpVI1Ui0T/C4t/Qx4xytyg==
X-CSE-MsgGUID: Wn6v/q6oQsSYSHPX4NnLSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35298580"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35298580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 07:18:46 -0700
X-CSE-ConnectionGUID: xJWvzzh2StOhsKFYFz4CGw==
X-CSE-MsgGUID: MKjNsTNcSd6l9evX7ln4cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67056404"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 07:18:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 07:18:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 07:18:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 07:18:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 07:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyRZIIOjCGJox3ja7jAAsf2x9VP2nLhV5O68DlUxMnOju50qX7ABW6GwPyFek1nebHLvnXcx0UJ/aIXC8heiE0rmX1+8FzpYzpnc790sS5/TyZ951fzTMBwGNRgWBjL3mcHL0LdG/ToS01itQoGYMwlUHPsis3Zc36HlXxuXsjQxjlfEMgAejk7iB8lpziHsH4sw80Eap+mCkGbdqtCzdb4RDyupxPJxEaX6C/8BFJ7Lmh+KeQF/jKrDtYniMmrQkKgI+SLC5iLRV5YUclk4sqNF3L3zb6Yy5r7BjzvOzjo22Kj/gBqILog96hqEPSRja5DBtjPRmrdUm9UJjflgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubo2oL9O5ALYbAhTxRWpYuL2roqyjXQWV+nn9KpDtJk=;
 b=nts1DQbLVmIGgyavRMNv9y3p5OPr4DTJuP+TmDS4cBcYkL7disLKp8zU7/2e8kRq8rDkdFioCtGiTQzVpe1xe9ZPmVY/GQmyVJnEcdpZBwz9TLTji3D2aqzf0Vz5SsSqGtOT0IClAluuYGX73TPYEmkRq2FqUd9yflM0w24XY+IBXCxKu6Y8QaHljxoJYJ1I+xZME924A8fdPC5b+fZoZujHK/2aoWJTfFfmbK49V5JBm0Co91FlPc6A0HK26P7VTvtI+G3z6fyDmcCKtN4u5QoOHpdwRN1fdL2zkCgd/KcMowgM3jDN+KVhEItP5GeqpYVfTtJHCdwRG1Vgd2qRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.18; Tue, 10 Sep
 2024 14:18:40 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 14:18:40 +0000
Date: Tue, 10 Sep 2024 14:16:25 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/xe/client: add missing bo locking in
 show_meminfo()
Message-ID: <ZuBUuSMHvJmalK2k@DUT025-TGLU.fm.intel.com>
References: <20240910131145.136984-5-matthew.auld@intel.com>
 <20240910131145.136984-6-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910131145.136984-6-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ1PR11MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f28e3a1-c906-4beb-b8c0-08dcd1a37838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?eZK5ZAckCJelPwe2iVbjQjv8OW7BrMC7F9gqvbpnyoyscBN22Z3nSOXPQm?=
 =?iso-8859-1?Q?qp//pESuoAn/mpA2E/mY2qJM/asHdjzyc7EhTJKL6MT1B9IhmbRU+2yjQW?=
 =?iso-8859-1?Q?6RlkHjknq1TQa8Nn5yzZFxdrtUPe2xTnABJKhWDoIz8SUObB3nklxtd11M?=
 =?iso-8859-1?Q?48bNEe7FoiKBP8CSQCP9gso6JIm4WeLSCVaXJFeKgzqkdqux8QJIhmDLp8?=
 =?iso-8859-1?Q?FouBRh3VP4Kgf8tAAQ0RDht5ydGwEHmTd7CyUA8bR2FADhR0TFVzjWBZRU?=
 =?iso-8859-1?Q?UNO/oSTgGEyHkzMZRJOJYRp+P3ekjfNxQ9iDl3wDRVyuXVrOI5TZBo+vad?=
 =?iso-8859-1?Q?n1ebyxK/CVvguy+kfQOlIGFgNm6A9TjCwVTVr9sgAWkVNiyRygHSc7uOvX?=
 =?iso-8859-1?Q?v26K02zhHF7BTpCZe9UTvjCZs43hu9XAcK0E8i/5zx8fONcSj49CBhsIJD?=
 =?iso-8859-1?Q?CMZ1N3kHLDDfcFgZWCl1rzyW2geFLgoP0NT+C75fkgiKRb/wFzhLYDwXgh?=
 =?iso-8859-1?Q?Y6sIw3FCI7q0I1N0T+rUxuT4uBnlVaFubEdVE95ZEknr9s6rpuR5KdQpSB?=
 =?iso-8859-1?Q?VWsZh1tDGHamIbO3nrGdWXOPlwnv5Cve5g0QcInOBeFl01wHKCFddCftAe?=
 =?iso-8859-1?Q?yFPFbmNJ203djOwxQ4SJLS3qWaqvsu5syxuRP95TN/bMCgbBsmqqMTs+D1?=
 =?iso-8859-1?Q?QH5aBdcTEjbtBvnj6KtNiInu848f6WYuEcMmDEcdmnxO6XVaiwnr40Drei?=
 =?iso-8859-1?Q?yrHumYX4yvVKCDILHKNcMH9ZGrP+nMDeZm18qEWEbtSwiGrlmoECRjyOW0?=
 =?iso-8859-1?Q?zrs+oy+yZZqJdH8x3B8mHYYvzfuN8rs8XpQPzVfxPyuIv4X2CU6hBfLGnH?=
 =?iso-8859-1?Q?9JPVHdt2zRiUoVmtkU+mpUZev0yBlctzxnkflTuwEUM7eoX3lFmQdjNCO9?=
 =?iso-8859-1?Q?Aj1WIAV3F8wNzXYInKSsh1SaLqCD3OzO5foPfQG6OF112xkiGguLFbp6A6?=
 =?iso-8859-1?Q?Oz95Y4Zyr0XMJ+AufCpP4eH0ZVwkvjELpQ9wDBaphSG8nH1ej2TZ6paDfr?=
 =?iso-8859-1?Q?7xnZRJr8kjP8oDFvVcBl9I7FjZc+UezEO78PC64q1TMISNaaI9qZETpyhA?=
 =?iso-8859-1?Q?JUghPLF8hx3GTGpT1ckW6dwYDpa7fUrsr8sATh5iIi99SNipOf3WaU7MAT?=
 =?iso-8859-1?Q?jBKPxLoKRVuD0HSvfkUXbUTOD9Wg7fqMWWL6nfM70Fa0uaR63v/f7eRf0U?=
 =?iso-8859-1?Q?TF6J6/uuhjThrB8l9RKJfqvDSz4mg4mQnXuoDWnyHJ6jQJuiCCQyB7teyg?=
 =?iso-8859-1?Q?60KowBXRTdkKQCz/2nrbmhfZUA7EfcRMuTQDoknEFOQRZaQRW4nQQy9t0b?=
 =?iso-8859-1?Q?NK32p0Nb9jwnQXPkg9Ft5upCqWZ1aBdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HRN6TPDnivlqlbOXMKrdkbG0vtmJLmqgJzpR1eiZWVGMpN8/z0dkdNzl8q?=
 =?iso-8859-1?Q?hZEnMd2z3W3lBP+U7dm0XfJxzmcwCKLr4TywU6NZB8jVKD26JKlGSl2Xs2?=
 =?iso-8859-1?Q?lsxCuxlGqNiUExcQUsIIvCA85bxccr9ThEzPtkRlk/OVGQSz1b54SV9lSm?=
 =?iso-8859-1?Q?+s0P9Wwl2hzHrC7xJ9qQgJp886v3DYL3ugyhC06sydA3sZ9FTGOcPjpHI8?=
 =?iso-8859-1?Q?ahq/eoqA4e9ivgC6Faa746Izt5dEvGklEKZ2SD46yvK3r26Dm/TD6aZth0?=
 =?iso-8859-1?Q?Wjm/dhRtRunUqyj2qDmapaTAtitP10vX9Q+ao8tbnBDuvwt7e7+50PMvPI?=
 =?iso-8859-1?Q?dZnoytQde5FhiCXO2zfv/jUf6A2IAeyADSZR6jaNkTjEAyh7rAT/ZYR5Gu?=
 =?iso-8859-1?Q?Y/DZPYLJEBLdUSOYd+KXfvOM7Hf50XamnorOKHPOgF8tnFwzxoD82FJeqj?=
 =?iso-8859-1?Q?T0h13vSkQShP5L2WbfLKDQoomXLV1JEj0cn1byxo/EhMhnbhXxm+5smFn2?=
 =?iso-8859-1?Q?LG5V9lxDQFP8W8vxEZZsTtvY0bDGVhXiXUQeLwtuW98tkq28RwTjLxjRsD?=
 =?iso-8859-1?Q?SUbZ5NYi4DOqHUEr61g8H6Fu56Spij08p815oc5JEpWqZdNCIu/EgeFrIk?=
 =?iso-8859-1?Q?h6G/DTmJVVokTyJOb5tiU4428m7doTxA4FncANCJjSVHDMuB+5gsQMXhqd?=
 =?iso-8859-1?Q?Ue9K1JfQXYGkOsJkmESXzPx8w5nrDUzTc64M+EbQLcxnDMLMWuAnPNMGKF?=
 =?iso-8859-1?Q?3cw20hwPvZ8OgN+pEvIgn86oMW43zsoBJmvcpXZrDS7Q3TyAaZybgrwbDO?=
 =?iso-8859-1?Q?7Lto5Lx5nZi12nx/3dJwev89tEOkw88GJylLTZrTZdNsYZ/Akzz3Lwc5Dr?=
 =?iso-8859-1?Q?7Hvz4WJdvuMnLLksudKKlIGHkix05ariegQx2PdtzeV1ACa3xi0MXd9Pc/?=
 =?iso-8859-1?Q?UnM3v7FgLb69XxyG0xEWJm90xaGXLMYbeAK70g0BqWyujRniT7sXiIz/eD?=
 =?iso-8859-1?Q?TUDJtu4AeM35ee5IiUCDwRa60tQvKvpphKn35jEBa3HNTq5BSw7/k3EJfd?=
 =?iso-8859-1?Q?8TrdwBS1k7gA5XTtv2f9bUo7zSkQzBm/eD/xQPyjclPATMc8xpeUaQytYk?=
 =?iso-8859-1?Q?zLWT3Td82o+ZWtaKj2vBdKoSR0Xi/8Cm/qatbOXwYv3QytNMSBkh+e79/F?=
 =?iso-8859-1?Q?jJHIcL3bvO7zi7j4rxFLroB6Hdut6giV3ssvzBCUf7g69398DGqY4Af9T+?=
 =?iso-8859-1?Q?lLuNKX3dEySczcCfl9lhpzKO2anJJFM3YMP7M9guISfJIXtluTtxgcGSWD?=
 =?iso-8859-1?Q?FUgG/pngeWvIyIloaAef3+muQmbuLil5TAhTedfGhYJA8MlqVp6KT4Ym0G?=
 =?iso-8859-1?Q?HZ2pqpm2ff/dNQf97FbMZbk2InD7b2gr2CzWTMwHdUmeagSczYPjxMyz1C?=
 =?iso-8859-1?Q?UfnLcnFHf1oQDP3TjHVfYHwwSpmJpnV/pVZUsybUNmM9Zmkr83C3Sz0YPX?=
 =?iso-8859-1?Q?WLn/m4FP4uGyKNuzGV5ijGvnZi3BfC2D1MWFip/vrwkHtoHdINJYGInaeO?=
 =?iso-8859-1?Q?A+7Qjq0hmuidZfATW4woYO4GrkhbnaTV7Pu6NF2ShxWOnIXyh61E3l/ZkP?=
 =?iso-8859-1?Q?2ZT2TyiNE/noZ8JdX9wbti2yfmIMGws9TI36JM0JsLMgXwky9MVf/hrQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f28e3a1-c906-4beb-b8c0-08dcd1a37838
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:18:40.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlr+mLg+7uObfMntJGdq0KCSUGJlg0quTfIbx9bhgkK+IUPQ2KiAtuAbn3Ed7Z/rwcKA6zxMUyORisIlnpYQfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 02:11:47PM +0100, Matthew Auld wrote:
> bo_meminfo() wants to inspect bo state like tt and the ttm resource,
> however this state can change at any point leading to stuff like NPD and
> UAF, if the bo lock is not held. Grab the bo lock when calling
> bo_meminfo(), ensuring we drop any spinlocks first. In the case of
> object_idr we now also need to hold a ref.
> 

Path LGTM, one suggestion.

> Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_drm_client.c | 37 +++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
> index badfa045ead8..3cca741c500c 100644
> --- a/drivers/gpu/drm/xe/xe_drm_client.c
> +++ b/drivers/gpu/drm/xe/xe_drm_client.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> +#include "xe_assert.h"
>  #include "xe_bo.h"
>  #include "xe_bo_types.h"
>  #include "xe_device_types.h"
> @@ -151,10 +152,13 @@ void xe_drm_client_add_bo(struct xe_drm_client *client,
>   */
>  void xe_drm_client_remove_bo(struct xe_bo *bo)
>  {
> +	struct xe_device *xe = ttm_to_xe_device(bo->ttm.bdev);
>  	struct xe_drm_client *client = bo->client;
>  
> +	xe_assert(xe, !kref_read(&bo->ttm.base.refcount));
> +
>  	spin_lock(&client->bos_lock);
> -	list_del(&bo->client_link);
> +	list_del_init(&bo->client_link);
>  	spin_unlock(&client->bos_lock);
>  
>  	xe_drm_client_put(client);
> @@ -207,7 +211,20 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
>  	idr_for_each_entry(&file->object_idr, obj, id) {
>  		struct xe_bo *bo = gem_to_xe_bo(obj);
>  
> -		bo_meminfo(bo, stats);
> +		if (dma_resv_trylock(bo->ttm.base.resv)) {
> +			bo_meminfo(bo, stats);

Add a xe_bo_assert_held to bo_meminfo.

With that exrta assert:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> +			xe_bo_unlock(bo);
> +		} else {
> +			xe_bo_get(bo);
> +			spin_unlock(&file->table_lock);
> +
> +			xe_bo_lock(bo, false);
> +			bo_meminfo(bo, stats);
> +			xe_bo_unlock(bo);
> +
> +			xe_bo_put(bo);
> +			spin_lock(&file->table_lock);
> +		}
>  	}
>  	spin_unlock(&file->table_lock);
>  
> @@ -217,7 +234,21 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
>  		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
>  			continue;
>  
> -		bo_meminfo(bo, stats);
> +		if (dma_resv_trylock(bo->ttm.base.resv)) {
> +			bo_meminfo(bo, stats);
> +			xe_bo_unlock(bo);
> +		} else {
> +			spin_unlock(&client->bos_lock);
> +
> +			xe_bo_lock(bo, false);
> +			bo_meminfo(bo, stats);
> +			xe_bo_unlock(bo);
> +
> +			spin_lock(&client->bos_lock);
> +			/* The bo ref will prevent this bo from being removed from the list */
> +			xe_assert(xef->xe, !list_empty(&bo->client_link));
> +		}
> +
>  		xe_bo_put_deferred(bo, &deferred);
>  	}
>  	spin_unlock(&client->bos_lock);
> -- 
> 2.46.0
> 

