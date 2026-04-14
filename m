Return-Path: <stable+bounces-237875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJMXEudC3mlvpwkAu9opvQ
	(envelope-from <stable+bounces-237875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:36:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E41533FA914
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E763046506
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118BE3469F4;
	Tue, 14 Apr 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coVfWLw+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AE2C21C7;
	Tue, 14 Apr 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173660; cv=fail; b=i4F+QsOUn/LTEXzVJR6o21W89gJUjXY+mCgtEp2EsnKkO5xajkHTUvT5M6TmNkIJ+SaUujxVOZitQfFoa+9uVj9E+1MIb4+qMuZAYtvkhPQd2gXpbe4LyJXYTJdLSjNczmm72CM5Hli0DbHUWSoSA/JMKQ+F2m68ajeOuO1+/6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173660; c=relaxed/simple;
	bh=L2odwwDrFjWmizRr8fbGfaNx5nbRKiU9pwiTT3Vht8s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEL+/GbCxCjSwYtZeOccIBNiJ3HDNhsU4KdMxuBxUyLO3iiRtPu03MZRSUVrY38RXC7tPImOIJW3r9pNo5QNFFNJI1FxTThQ4nzHSe1cLET/sm/tPL0RPTVrTLiBJ0Rhq7/GQzDKmm+vc1p8vlhuKqEm5i9ET5LDUuRTSCpX2CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coVfWLw+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776173659; x=1807709659;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L2odwwDrFjWmizRr8fbGfaNx5nbRKiU9pwiTT3Vht8s=;
  b=coVfWLw+gy2EG0HZ4YmSiBauQ1o5+HzUUy6lZxM0L/ZOrvpV0bIYD8wQ
   FYl0NaqLJcLyZElEJAQhcuJSvR7O2NYtDu2ZyMBF7qAkxaGLOYnHBX3E4
   Eb0Gx7cFfv+bsvTqG+uQLiln0j/9xjahzQYuZLJTGEA/Vr52YE+1IvG2l
   s/JDQPtS6G12Yuij70vdbaDWzMFF0kpX+9Tuq4KUac1h3QehVFpGL55kU
   NzJIzIoIs1ApYGMa4mVWX3GHF2xq3q4uTx3azwsRXJTeY3WrH1jaZ2QSV
   idISSzQwwQWQwqabeXWVh5c+5fLO2ex4GJ7rUci7VWm57UtTttHSMQTgh
   A==;
X-CSE-ConnectionGUID: vijBB7rIRh+D98AxH5Cqrg==
X-CSE-MsgGUID: XNSNkfKdQ1y5kMbt/iJc4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76292400"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76292400"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:34:19 -0700
X-CSE-ConnectionGUID: Qo7uXF/gQTytNLhet9a0lQ==
X-CSE-MsgGUID: 9K0eViBqQqa9MNDoDe+OxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="231846690"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:34:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 06:34:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 06:34:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 06:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOrpHvvt2n9EO6sDjhB73BWY1Ja0uESJUthwSQX/g1AB62s0EtgvmPalmfnzoQ9Pa9Qizg+5tkLz+u2Agc6p5p5sfL1sc+sHSI1AVxzdOE/ynnt5aUBhZPRhoARXW7Xtni+pN3FP6I+B+SKOglBTAwFQ9eczT5xLamwA2ylG0eN7h0VIaWPzmy3wRU7YJHjFxo4XjjcrrdCAk03pLpmIv1hhNXj8QNu/623VHLQgi3amaJjw+NORO+uU46blKVUFQ0Tuo5WoN5FbN4ewzgb5dx4MAQBqHXkJXbhnRPKkGeFwF7FhAG6tg0LjK377Xg5zkOnFaN/Eac9wGsn6hZ8Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MxS8TavIgcvDapRVozhlx4bSPTIj/Af4v7GCLAWWMY=;
 b=HPV66UULj4b+04NpWfpL5jE7hlQK9qESgDLoS7Ja672ES3LzCEEtp8xU6kAmEjGCU1dfbyDp+sX5BFDJs5gz/xJZ9eC6+MLOPuP4htCAENg9nGYr57vyIrXDWFCd7cAarPzlfj+NZEtL1GYF4Ahcy+jn8pWTRuNvljhwsBt8hWfB7NhVVsXgGbbVsn7lWaxSyTjfUPaX3A9ilM/E3tY2Zvo3+1dEh0M4vi6GnQN6lDI45h8Eysrq25Oq8BWi6WXP49RBUtl7AeSQh329WRa+HibJ7Tkzes0s+4WoKVycONT1VDUXHXW57KJDbP1VoWniqGt3WZPvM0WsHF/1NNspxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 13:34:10 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 13:34:10 +0000
Date: Tue, 14 Apr 2026 15:34:07 +0200
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Marco Nenciarini <mnencia@kcore.it>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI/IOV: Fix out-of-bounds access in
 sriov_restore_vf_rebar_state()
Message-ID: <ad5CFCCSlACeByhM@nostramo>
References: <20260408163922.1740497-1-mnencia@kcore.it>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408163922.1740497-1-mnencia@kcore.it>
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a63bf04-e53b-4701-8472-08de9a2a82bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: p954aHtoq6Qssnjq1SFFtgGII0S+vUn1Un4XHU09jfN9mfVnZK9GqaO0vg+3zlqI/2yGleucDXIT89pTYkJa15v2c+OoBkEi6RAi8PSiULdgshPZHPIejsfYJJobEEMM1v3FON59qKFkBtKyBujPeCAuCbyOxf+FBxWarcj/p+K6Qemfyi2cDSc0x3coAIyaAncd5dekh74Lwe0Coswcql47x8H7gU9nvYXMAZ5IrUfF9/I8ZcJcLKJB9kO8iXkNAju8n0Xj+GgWHzoZYUZUzFXlTqPbtnU0FRD+3tZMLXU8MEv0ZIlwdC6JzAaDeCk/cLjprUVOzjuiryb8wpkIrtZnMJRqx/lt+kGHQsW2v9nbYedIUrjNEvUVPJCpnBxqoVdmhRZ3LTVwmd+QNYStp3E9JZEvl5dqkYDJ/QVWbpz5weqiRODMpX63plEA5WU5MZe19Cuv2Rwsqlrzq7Em0dhd3xmZ9DKvsdFt8Zi+6AfTGFW2nf8Km0qPOhyWxEY4tGgHpo3163iO1dAtm1UQEDB7Q4R0N8/g8UQaOzyLs4Q+GhWWmOllmKjLZQZPfQKDYhERudgRD/Nf1dZT094fIHvey7XP6dqDxC/jYRmAcdoaBAxmlPYR7lrBN4N04tlXqPvc4tsbxlKB7Ejd/+PQ0aYH4EC3WPIMavnzIZMnpAE5ccbGpCmKwaeSxT54wwBemHTKrgtKAwRi0TQBVld7Cn6KnqT2Blad2Hae3LfNjNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNjbHcvRG5yY1Y0YVVJbUltSGVWNmI5QktzU2F6RFZRUERiQVJkWVhQNzRS?=
 =?utf-8?B?RUJTNnl1OS96L0l1U0tVaXNHVS90aG9FaGxWaVZVRDR3VGQrVWhUWlkwbWEw?=
 =?utf-8?B?WkEvTTh6cGU3RkJHQ2R5TStrZVEvM20yRGU0UTBmWlFVYTVNKzE0bk9tVTBV?=
 =?utf-8?B?UzNZRy9xUGcreWJwbWtqZmpXTVdzQmpjYTBKMmtJOTJyMkhQK0RrMkFZTHh0?=
 =?utf-8?B?TkJvanZvZkxvTjhVRnVIUlVEZkNzemN1OHBRMUZ3dDFLTEc0WmEzS1p5YXlB?=
 =?utf-8?B?N3BZVDdYRjhQcTRSaHhFLzhyU3IzK0R2eHVMLzUzQTJwZ0JuSUllMVd5SS81?=
 =?utf-8?B?SnFPOHE2T1Zxa0xYSUFsOTN4WGpMQzlJNW1LMC9jbGk3L3B0YmJYUUoyU1lG?=
 =?utf-8?B?VVQ1Tk1XZnJPUS8vQzgrUUxqQmNPS0lCYjlza3pBM2gzVk9KUkQzL2kzRllh?=
 =?utf-8?B?cDd5MkdVMzdEWGo2aDFzcGhRZ1laYXdEbXJPSDhsUzB0VkhCNjNFdExGQytV?=
 =?utf-8?B?S2pxb0xNYXNoVFREa2VUMEU1Tk9QaUM2YjRuczIwOVRDa09rd0MrK1JtdFVj?=
 =?utf-8?B?TGRsRWc5MmVzWDJmenJPT1RvK2pRK01mWE5nWGY3d1lUUjg2cGxqSXJpNXBt?=
 =?utf-8?B?RGYzUG5Fam5JeERpbGQyeFVRekhlWlB3eEJSbnh0OVpjcDhQWkZ2Z211Qkg4?=
 =?utf-8?B?TDcrVSs4KzlNQlpXcWVkUnlXWjlFSkRsMkNrQ0taMVFWYmZPRXYrcTJuOVRR?=
 =?utf-8?B?aDZacHF0Q0RIQ2hodzFEL0d2ZEk0bUk5eHdpZjVncmNOQTZ4b01DaTk1eVRh?=
 =?utf-8?B?aWgvQk1SZjRwakJTMGdNR2wrSU5pU0hlME9zclZtdm8wcDRTdjQ0aU1WZzFR?=
 =?utf-8?B?MUx4RjRFRlJlbUdkc29VK3k0UzFaUlkyQld0dU1haXBBREJkVjJZb01vd09r?=
 =?utf-8?B?K0FMa1RSU1lnMk1ybVgrcWhKSmpmZmRKd3hHRHk0eEhpOEFqck5BenJjMStW?=
 =?utf-8?B?UytvUWZYVFZVSTZJKzA0Y09Za1VWa1E0MHY2d1ozOHpaK0FlZjBkdW11SEpp?=
 =?utf-8?B?RndBVW9zc0gwUEdwYVhYa25jRGw0ZFgyeXBQMXlZUFQ4K0F5dU1EZFp1b09I?=
 =?utf-8?B?QUJtZERyelV1dlZrblNhSEFJbHN6OEhON1paVUw2RG9vUXpDbS9XQzFnZHRE?=
 =?utf-8?B?SXlrQk1xd29hVEozV3c1cXQzcUwyVTBuRC9iQ3lxVnRVSXZZa2hacVdDODBJ?=
 =?utf-8?B?S0djREdIQTJpekorVTVzQ1Z2SGVnUWdCTHNBUGJKaStiS0FDcHFSbkhFcUZP?=
 =?utf-8?B?VTlLVEhTNExTY1JaWW53dmZaT284OVFBZ1A1aFFEM2g0RnBNZTdtWmdaVGx2?=
 =?utf-8?B?dkxQNEt0V1JiY2w2amZXOXYyYWJqS3lVbjY5RzNRRG5vc25MVjZJVk91UFlR?=
 =?utf-8?B?aWh2bkE2TEdYdWYyaEV5UjJsTXkwTXk0czdZMThKUzhKZHBicm1FWlNsMjFT?=
 =?utf-8?B?UDh6QWNWOCtoekttbi9JUEg3STVkeUxFblhzMEhETTgzWkJ5ak9LZ09mMllk?=
 =?utf-8?B?blFnMTB0cVRnc2EvbnRSdDdnbndWbG85RDBtNUk4ZXFsK2pKeGRQZU1YQlkx?=
 =?utf-8?B?aG5UVmhaZzI5YWpzNlVjWmlxcEExSmZmUFUrTFRnaldiMm5aeUNBTkxCRWJG?=
 =?utf-8?B?dURSYlZ1NTFJMTFtMlE5MmJ6Z0pFUXBKb3dzRzRzU05LU0V2SkxXeVN0TGlq?=
 =?utf-8?B?b2ZQSW9XaDVqUmxOeHhJRXJ4VStMcFRNMnMySmxQS2FaZG8rN0ZsSjVZczRM?=
 =?utf-8?B?c3poVWdMeHNyaGlvV25JU1ozOVdvajJ6SDcrZHB1cTFKUDBxbmRBV0VGNWRz?=
 =?utf-8?B?MXJiaTVGL3o0Ry9BdzVPWHJ6dmNZdkMyKzlnRlJtaVpOcVRWUmlpZ2p3UmNY?=
 =?utf-8?B?RFdPTzIxdmF2eDh5TFlBNVVCNzR2aUt3OHltdi93OE1FdEJndmVtMzFhOWJ2?=
 =?utf-8?B?ODgvbXZ4SkUwbjJBOHJmdklpQ0tNMjd4dktHVTZEeTJRREhUazhKVHhSK1Az?=
 =?utf-8?B?TG91L3ZSWU1ZL09taHNwcXp4Rm94M2p1VnArbkVRU1RrdnVFVXdmb2NDeSsw?=
 =?utf-8?B?NGpFOWN3WDVRMktpN2FaUVFKYXRoejhGaXFCQU9tNlBDeldsbjMxZVV1amt5?=
 =?utf-8?B?Q25vK3pmY1BadXlOOE94RjlEb2cwK2ZZUHNTT0RVYVFNNFNhRjhPb3Q4R0p1?=
 =?utf-8?B?U2lXbkc5cFg3NGg2NW91elhReW5yREtHQ3NNVVd4dG0xSEd3cnhIN0Nja2V0?=
 =?utf-8?B?bE9rVW8yblVYVWJOdkpiQ0w5cDcyN0wxY0NtRVQ0Ykh1WVJyLzJ6UDkwa3ZS?=
 =?utf-8?Q?vT5MwGix0VrXc8QY=3D?=
X-Exchange-RoutingPolicyChecked: JFGBwFGrCV6prxHHOfnHOgNpdoDjnI8MuwUra39GRoY1j7bQbHS+hXq4G+J8vXuPKrFw0La7iulrK0NH5+GhnTo4oospwtSkj7MxGpjHYcaOwertGf1cGHo/9zICra3rFLCPt9ySIlhxUsJrJ6Jnn9VfQqTYDvYjQlFeTDBId9k3pLiPZ5BTBiaavg5ByaiDa/xoNhF3qYbU13p1OG/7BcAuI7D0FMU9w/EzZoKCa7uT1bj5FoDsMfgE4Bw2aN7qf35hJc/OmGb9EQ6ywQbemWRpYwYeX+8Jv5BBeEERzon5krpx2HWZYlU39k86a4xPo1TOdK2Y41BPCqj8Pg9DUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a63bf04-e53b-4701-8472-08de9a2a82bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:34:10.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgAio0XwAFn5ihWZXYOO5VYH6j3g177obcMCSh/aS28zaNzv9cIEkFcwmnUedtSWC3rWPxoJGvL30ZlbaOIJMOW5nPK4MsGTupNiwwdypUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237875-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kcore.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.winiarski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E41533FA914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 06:39:22PM +0200, Marco Nenciarini wrote:
> sriov_restore_vf_rebar_state() extracts bar_idx from the VF Resizable
> BAR control register using a 3-bit field (PCI_VF_REBAR_CTRL_BAR_IDX,
> bits 0-2), which yields values in the range 0-7. This value is then
> used to index into dev->sriov->barsz[], which has PCI_SRIOV_NUM_BARS
> (6) entries.
> 
> If the PCI config space read returns garbage data (e.g. 0xffffffff when
> the device is no longer accessible on the bus), bar_idx is 7, causing
> an out-of-bounds array access. UBSAN reports this as:
> 
>   UBSAN: array-index-out-of-bounds in drivers/pci/iov.c:948:51
>   index 7 is out of range for type 'resource_size_t [6]'
> 
> This was observed on an NVIDIA RTX PRO 1000 GPU (GB207GLM) that fell
> off the PCIe bus during a failed GC6 power state exit. The subsequent
> pci_restore_state() call triggered the UBSAN splat in
> sriov_restore_vf_rebar_state() since all config space reads returned
> 0xffffffff.
> 
> Add a bounds check on bar_idx before using it as an array index to
> prevent the out-of-bounds access.
> 
> Fixes: 5a8f77e24a30 ("PCI/IOV: Restore VF resizable BAR state after reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marco Nenciarini <mnencia@kcore.it>

Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>

Thanks,
-Michał

> ---
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
>  drivers/pci/iov.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 00784a60b..521f2cb64 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -946,6 +946,8 @@ static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
>  
>  		pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
>  		bar_idx = FIELD_GET(PCI_VF_REBAR_CTRL_BAR_IDX, ctrl);
> +		if (bar_idx >= PCI_SRIOV_NUM_BARS)
> +			continue;
>  		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
>  		ctrl &= ~PCI_VF_REBAR_CTRL_BAR_SIZE;
>  		ctrl |= FIELD_PREP(PCI_VF_REBAR_CTRL_BAR_SIZE, size);
> -- 
> 2.47.3
> 

