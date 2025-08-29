Return-Path: <stable+bounces-176716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D08B3BE91
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD15A27C8E
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67731AF25;
	Fri, 29 Aug 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgqiukTE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100131CA77
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479204; cv=fail; b=iHPcaHooco7b9dXnoytHhQ8PfrpCI2KmfTvb1Y7iBr+u5w0B59wJGlqCIYY2yTpE1nD3pinZYX9MZeVS0gi8Rq0Uv2CqdndXFxnv17OqwKPxZDPa6jFRfGUTDMVXMzLkXH/19RADL62gkytZrF8aGGR2UparkFwH9oAqHmwkhGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479204; c=relaxed/simple;
	bh=ESmCYbajYKLg6l4rUtVWKrnjpoHJDi6ktCgcu3KxzcU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ktJy251sKnVMr0h00IuOfoYIDDzZrbuKNo8I5xQzwqgEkDaTcGcRlirOImucRylwF2uLt37VfJ0KrWnZu/gtNNVKWoFOuSumZG1/y3x/riWgdR3bGse17at/BYEMT762EU1ArhdpcBfT/Bxyx+dyxQm/C5tr4Gw5e8Gnvcq7p60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgqiukTE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756479203; x=1788015203;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ESmCYbajYKLg6l4rUtVWKrnjpoHJDi6ktCgcu3KxzcU=;
  b=TgqiukTEgykwJGw+RCziRDp8plDwBaTPAlZnQckyuz7D+75afpnqcodQ
   7XZMPYjy1pUHGM1jNYrd/+JISCbzZc6sgMO7/MjF/Gw+Yufmf/lxAvD1w
   k9t/aGDvdEKCFFOdpmkDyNlGMgW1q5Wzp59jpG7cYLa9P/9WCoeo0Wttw
   GAtNHvbwG7ysSkM8qXz3vzYVubFonDFzezNKT9vrmDuHwhv7wcJRxjZtS
   gobj+BmhTjr98MfoFFd3a/yEhLKJVM2Ao1cWMCTxxYl/CuDAa6pcwxugX
   ndyz3BnClo4pRXkvQnhLkCEdurK9k/1toldGloKAkQ/xTVUqCCdZNV1MZ
   A==;
X-CSE-ConnectionGUID: Nj9aGmR4QyS5j48b8NrV2A==
X-CSE-MsgGUID: D/2WF9lnQqiuWQ8QO6ZQdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58695568"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58695568"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 07:53:22 -0700
X-CSE-ConnectionGUID: vBqZgs/1RKGpMN5hnWeYjw==
X-CSE-MsgGUID: /2RfkpzSQnqhITCxzdE+aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170303256"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 07:53:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 07:53:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 07:53:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.63)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 07:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O296qDCA/D9Hbxt7na/J7ZMhnBr0naU5EKPcc9UYiATiTYyTNTdkAsHYaKLnkl32/pAzT3i0uKCfMhyCX5mPd0kNSAcKLQOraXTSsQa6zR85LhqJ8iXLt0+Ytig9HyEliCiROnnZG3Ng7IU0k5db6fhsPTaoBkT2Zr4Udx0ZfYeBR13zteNZAHO27GAMCSZv1FX2+80OXowp9SSF9eKjv2ZJoB2dpEj+SYAk3x55WerEReyI2wspYy5nvUR1i2QJNMcCISDIxuAf7uaEcRk/JM1easjaaBRRM85gOZjFz1wHYM7hZs6uCAtWwrykh2PT5Uw0YvBCUuuAwoS8i/FujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpcR5p//vQytouxdUaIL4u+RcB8k1hi0a0R6qEHbgRQ=;
 b=WSFVouwopGPVu0hU0zHfD5m9UCB1x6rE7mOKd04LksY2mOo2ONMxOmZ7kjziUCWOvXgcZB5UEFKesCU4k/r+3kMvTD0cfLHIlFuDksPmv2RBFmLGmXDK28WQWwFHdCaZRZ4pSOqcR+KeVitjdloUoYCUl0jrk4QUrXjkNi5HmDDhJEoRddpfc4dBcA7cgkZ5/yvqBdB6YMzeyMgRgwS6Dih7UbblxgDeSx/WBpsM1nhlpKgM4cEDfJT8z18dcmnlrqgPuWjw1+GVAbZMqIZ/eUtrJ6u3zRsZdIRKnVLyn5v0xvGlwJkEpG42CiiaI4RWAF7K4Qyxe/TH7oIeYcnR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 14:53:14 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 14:53:14 +0000
Date: Fri, 29 Aug 2025 10:53:10 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
	<stable@vger.kernel.org>, Matthew Brost <matthew.brost@intel.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/3] drm/xe: Allow the pm notifier to continue on failure
Message-ID: <aLG-1s3M9Z9vELIo@intel.com>
References: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
 <20250829113350.40959-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829113350.40959-3-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|LV8PR11MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 811f1205-46bc-4905-ab6a-08dde70bc824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rfdX6qFtau1YzDvxwGJ6jdsesgczMOmWjeuABuhxHAs2ck4pcsk2u0qkgN?=
 =?iso-8859-1?Q?hMuuzT26kT6S/TiAK3jA2j9xiuRdGRLC4DQRkbQgbpKDQXRU02YPuTDrT1?=
 =?iso-8859-1?Q?zoKoyQPYEt+rOwR31+3Px630+Iq14EjsboOjn7/xSCtvBV/rHQ0N4dEjlw?=
 =?iso-8859-1?Q?H/jZzIo6CMq3OAZkq7bzicuHS3o5x4T1tQC43ka+jaOS07u6WpB14MVLPF?=
 =?iso-8859-1?Q?+XzAvwujOgh+LcC5WFP2kGKMOXpXSC9wgiy/VIHsw1wGB5jQfXnBxQc8c0?=
 =?iso-8859-1?Q?KCH+8HsqiNNSZnZljQMtw09aDcntMQjjd8PPFGez91+ZDPIth2BHsZzWoI?=
 =?iso-8859-1?Q?WX4GBKRnZoaGkfqaM1e0gvm4kP5EXTrB8JpvKDqlS5NT8gZZTVmN3I6N0I?=
 =?iso-8859-1?Q?NvZbeHPAGjrqPH01hJl8xAJpMv6JJaBPT2rcZZPg6EaMfKv78i8s1FWiiZ?=
 =?iso-8859-1?Q?dYmHjjsBhYSIxY9J3yjihg9tlasANbUL+ekjbjmYlir2xOf33F1XxZldPj?=
 =?iso-8859-1?Q?+XpAl3r2XGuxOnAdolY1MWBN+jXRv4GS64P4Awp6+xdJFo7eRcoHpVnvGj?=
 =?iso-8859-1?Q?reJTNswL7uOLnIs+IYytK/kNkANfXJDxVcjI5TAy1Lb62PvUTt/4QrHClF?=
 =?iso-8859-1?Q?8pcD0azirrpretA6hehRtTPLdY632cLrchDgOqjyfq9GSxSN1gA5u5h6ri?=
 =?iso-8859-1?Q?R5CxDd3JGCTly4HqwDr9MIXuGD76gIo88w7LYLFlid6HOfXUEYsWAVyMRG?=
 =?iso-8859-1?Q?otd6cnWMQcuGDPw5bXgM1cziqXqQfr3xcfIPV5W4PvG5W7tLc8ACr9fSW6?=
 =?iso-8859-1?Q?+sFV/4IrD3hqdAhQzGi6bv5vATvUMllSl1Ru0ohNpW9XWz2EsUXkw/Jb7q?=
 =?iso-8859-1?Q?U/k6l4K+fohWOJDSG7Fm7rLPDEXLU/UjkLHQw//U7ve/t4T+qefO2eDMRQ?=
 =?iso-8859-1?Q?9pwP/ZT5jS96gzIpkIB4uEyhGI8M/pn+dWnb9KvdgTDU2TlJI1D+gvrzEs?=
 =?iso-8859-1?Q?zRp1ABqgla/GKcpyAMgL9u9v3VE4fCN3d5hvAVdKTcMh7/AMvLwNdrswPc?=
 =?iso-8859-1?Q?ABVaXs4oJtebuXybWgIlV3VnlIx2vZTcmPtKBE/C6Glw4kJin1LHbxPY36?=
 =?iso-8859-1?Q?ThK/357zG1wI7//Lbfn7iQvzMPcTj4l8Il/3l6XG9MejC5bBfFXCqA7eYz?=
 =?iso-8859-1?Q?7LUxEIjNvq+cKSRRT/Xm8Xoey3GDqrcO/8EfSPnd70otwPQczzOLYRcoFf?=
 =?iso-8859-1?Q?3ROqijioP4jycj82zTrhDSSFC1+5msvCssK8g7yY0BHevJwfXH8U7iG02n?=
 =?iso-8859-1?Q?AQSivD7XKJYajG7F3KEaq2cHms3Oq6s/VbxFtZzhAA09osdeHOEP/i/jZG?=
 =?iso-8859-1?Q?ilYH5CE3Ylrl85hPZOSy+ujxuwdbMNY8LTUcsDwe1a/8B12AIhWOb0hxqE?=
 =?iso-8859-1?Q?kDQD7aCf1PRIGcx3Ra41BgHKG43ed1VDOdiRs+5i/Smu08B0zlFvk2AzdS?=
 =?iso-8859-1?Q?c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q+h36j0JdFa8bD/qE3OEqzfgU9542lau2NcuYSqXCHeTiSoO4TQn8y4kLi?=
 =?iso-8859-1?Q?fNu+uTY1oagtVgcWkP1F+Fp6ZCRyhacDoMkoSN71q/JMu7EUvxVJUJ8CoI?=
 =?iso-8859-1?Q?gpNi/pGR56fXxYlnEaGWtyKnL6U2E3I1FtdFH23uk7M/+lsgcw5s73GZLl?=
 =?iso-8859-1?Q?LII6FmKzBEBRIM0Ux2P73SdFBsM8iN3QZ9SGVAkoMd51nPIt2z/YYYy4NM?=
 =?iso-8859-1?Q?3M3s77p60ViZvExlFJ0EfL9BnAZlCtfz1ErIcLxzICIhaSGKKkj8r5L47l?=
 =?iso-8859-1?Q?qoQCpCcSMwcvAJ5OrRBfcZcHYE15SlR2KdaDToxMDpBpU6VMA8lcJDIyfd?=
 =?iso-8859-1?Q?mk+nv9ZNzMhuG3v2tQDXnN7wK/nRa3JzgcY/V5/5ytE4rsJIltqx7c65JF?=
 =?iso-8859-1?Q?wV1U84sPT3IThruqxjgYnZ7J/nY1B5z9IpeeMPrffySG8UvsW3f89h3KEQ?=
 =?iso-8859-1?Q?EjLmSiE8oUv5DBqPB1l2NzX9zqgo9Ntg3gQRfTpAfaoPkYx4CzcsqvyYrx?=
 =?iso-8859-1?Q?vvmJYk9kBCPfGZgx1M1jydewp6Yks6qSSKSuthg90P+GgasdHpqmwzirYH?=
 =?iso-8859-1?Q?Cw74Lc/PYDaWKJ2kGZfCJTXynJtcHz/J4crGcwUKv0UxkCYHLCYgNsSdFO?=
 =?iso-8859-1?Q?M9L7qYYDVdJMmufdIvbfuDpcUYq0IubJwklep8RS/Eyzr1Fzdnv0j9fEaN?=
 =?iso-8859-1?Q?xtB3BjGGt4NyCtRUxE2OhHOwMzSCojuWeuVB12kMI9gRPUHxONLvfjE+h7?=
 =?iso-8859-1?Q?JVVs8i5TaLQ8Gi3/iFdpjOenLsrFJzDk52Rp4wLFt00TWKFDWeEfLy7OEU?=
 =?iso-8859-1?Q?L2tY3blXs/9pFWv1NZwJ1DUyXaEhBuAKPCqZoROBuk6GeXAYukS/f8RKL8?=
 =?iso-8859-1?Q?AwwMVzcEZtN79mxlyy0xZ4UA1Vn94D5IbQIXL2tUWe2v56k9Ev7fL0i40g?=
 =?iso-8859-1?Q?IBO32BVnVGAs1ER40CFSnIWlMX5fAQbIdC7zHu3gK2M75d4osmJigeL5la?=
 =?iso-8859-1?Q?1uiPiWeAzozZUk3p8/3+JA0DnxQ5Hwb0mNvi8csZSOTqtK/mNhVFbc77Eh?=
 =?iso-8859-1?Q?NeT2cmPwr8cDkyAr0NCU/N9AVJanSOC52Q/CoCNjh7J7ANYK87fdsBXcJb?=
 =?iso-8859-1?Q?CzcIy39KMkFWl4WPdFsn+JK3He1e0Vf018Dpwjye0kE1N7xIaqOgt3WpyG?=
 =?iso-8859-1?Q?8gZh0760WFzRJUWYgV7HK9BUYXF+gvJod9yGT18BT6LhD4hdslRratSyZ5?=
 =?iso-8859-1?Q?b3rn/zfLhMWMj3FG2q3YVuj0W3HEBktDg5Ee6s8kxAWsvTqkAWZ44x45Jv?=
 =?iso-8859-1?Q?oGkhW9OulkM/OSqUnbgKVi3M0gSOaM5Mm83mUaBS1LCyq8KZY8fEOLBIM9?=
 =?iso-8859-1?Q?TVuLeXufttMCGRBxaGopweCaCkin3rMAFjO27Jc1gwQX4jrCmpGqLRAIcc?=
 =?iso-8859-1?Q?Ht66HHvgL9BvittCjhglHAr9/riZTaKGv3q+Nys6i3+utmKG1vyY3hABPg?=
 =?iso-8859-1?Q?AYP0pQtDeOzuLj1TskGXrmFCxQ+EMzkD0GvV75pHNhOCCiBoIg74F0HMOm?=
 =?iso-8859-1?Q?oyr61HMyPd4yFxmaQfBbrBoEVJVr+qUv8aoxCv/+ZHaRk11VfPvcePBSgv?=
 =?iso-8859-1?Q?/0GhQPj0nk43f98Vuw5wIclBFOOMamsDIGLsYxWtru4dBectKqF+aaBw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f1205-46bc-4905-ab6a-08dde70bc824
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:53:14.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDf6EGTBQoLN+kLjUh2BWkAaXvuNmxaUSyyn56adZokhQ4R3YX7RzkuaJpCfUblk8DfhkDzShEL2A3ePlVpO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 01:33:49PM +0200, Thomas Hellström wrote:
> Its actions are opportunistic anyway and will be completed
> on device suspend.
> 
> Also restrict the scope of the pm runtime reference to
> the notifier callback itself to make it easier to
> follow.
> 
> Marking as a fix to simplify backporting of the fix
> that follows in the series.
> 
> Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_pm.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index a2e85030b7f4..b57b46ad9f7c 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -308,28 +308,22 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>  	case PM_SUSPEND_PREPARE:
>  		xe_pm_runtime_get(xe);
>  		err = xe_bo_evict_all_user(xe);
> -		if (err) {
> +		if (err)
>  			drm_dbg(&xe->drm, "Notifier evict user failed (%d)\n", err);
> -			xe_pm_runtime_put(xe);
> -			break;
> -		}
>  
>  		err = xe_bo_notifier_prepare_all_pinned(xe);
> -		if (err) {
> +		if (err)
>  			drm_dbg(&xe->drm, "Notifier prepare pin failed (%d)\n", err);
> -			xe_pm_runtime_put(xe);
> -		}
> +		xe_pm_runtime_put(xe);
>  		break;
>  	case PM_POST_HIBERNATION:
>  	case PM_POST_SUSPEND:
> +		xe_pm_runtime_get(xe);
>  		xe_bo_notifier_unprepare_all_pinned(xe);
>  		xe_pm_runtime_put(xe);
>  		break;
>  	}
>  
> -	if (err)
> -		return NOTIFY_BAD;
> -
>  	return NOTIFY_DONE;
>  }
>  
> -- 
> 2.50.1
> 

