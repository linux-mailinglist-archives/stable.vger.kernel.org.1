Return-Path: <stable+bounces-212812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDT5Bbqye2nNHwIAu9opvQ
	(envelope-from <stable+bounces-212812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 20:19:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88035B3DCF
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 20:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DA503016815
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240602EFD91;
	Thu, 29 Jan 2026 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqKJ1+rf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104557080E;
	Thu, 29 Jan 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714358; cv=fail; b=R+viQgy/n2d7zE7mUHPyp75s0vdxHXBfXtc42jjJmk0nYCp10PgNd4bUpHtIG01QjKCdrph+SENkqb596Xu2hxqQKgNwqLSZTDuCxlpqCzq3JucrmHGceHOwrsHzTe8QJ8KkGx+xa/vDqjJO8We4X8GacO53h1C3C0O7TaAMmuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714358; c=relaxed/simple;
	bh=oVzmL8e6yI7s/6ltFxMnCgdxH0TJcwM3D67DNR6WVMg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LoAB0k1lkTdIsku9ZXLN/8z3Ejq+7K7OCxXUd7f6VZgCDcpnqIbLN6XZVS8dM5+FHbPfP6U5o6gbhcw1j96/eFjgmKsqzwEfHf8+0k+fU1TuGcDCBh36CqCjEA8jcwVKtjfzu+Le/XgtWP9Cl5+q/sjTxc9E3NnvywvN8uGEJIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqKJ1+rf; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769714357; x=1801250357;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oVzmL8e6yI7s/6ltFxMnCgdxH0TJcwM3D67DNR6WVMg=;
  b=CqKJ1+rfks55VTmZoB125/yw2XvLlj201wPpHw+lFZj4KB6STctPWK3K
   mB8RYAhRPorVtbGVrFkB4IKnYQMA3Hiqfd1Ijh9YJtmeWLXg9EMzbYYrt
   6TPGdo5lvbwqDRg6eD3On5iEdV42XJKjf73LgpxlFRuJf0xoQNq4X0IzS
   uikhbDQvD0+NcXCoKLfFPoTu6r0oQ+Zb6fQOUgDGUyd5zrozlxIaR1Uah
   lbPzpRna5rqEkQ0jjP09sudQnDtvuvT6VZqRiHH3WtcpygEQz+nNfz7Q0
   bIwml2o7QEeqGvGE1JzFhac55IQgzwNOpb5ppWL7JfWITlv9XfL0djAAp
   g==;
X-CSE-ConnectionGUID: uaxUGOPtSX+ydHI+1SPbqg==
X-CSE-MsgGUID: 09KJt5r4SdyDZunvI/gZZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81697589"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="81697589"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:19:16 -0800
X-CSE-ConnectionGUID: xt2lKCC9TU+7NYXd03KcXw==
X-CSE-MsgGUID: Ct/e/KE7TvObjsDA2vDDgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208574407"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:19:15 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 11:19:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 11:19:14 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 11:19:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2AruhEC5BuFkRkndSB7AjEayiUq+lNV5md+yW/nCnzc5GlkgJGUbujlUEpEQvyVIONUWNVLLupdyAyvmOmtNvos5tP1FK60oR6vG+Uy+gcXIyIihs0qJSv1bsGGF7wHvm65eaoeGxng2XkTrhf7WF7yniniL3XVMMIQYnKakNz7BYWlNYzC41DCspi6m1EXFcwxiBULiojTKitdF8sIhOVs7LppifEgwZzbp/aFzR4cTclc37mFmBD55Bo4KaegmP9p4y/k7i4QaPW523WgKmoN18pTN5onxL+ZsIlIdHCkYnh9yfaANiDKaWTYmMAFYWa3kTCjVi2ZY/TuPfQqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2erB3ADbJUbuZPbZ9MsPZjtMqyJVkvGHomd0e2oN34U=;
 b=op0Hp2Nl9ofYB9EcxnofxdFwoa0CCExCu0UsU/33rW/MJOWDcdU8kj/m84G2zaXM6R3NFkYL3KdXsnlB6W5zxBfjSlIaelSi4l58DW4JNMjbewAsAp6RLk+Bx8lXXK1JPA5ynMzuOZg8boMSPLmcwG1TyMagIVHm11JcwdFtf26hExahxPm/yv5rrDOrSrSjGpH5JpCLU+HB/S8ie+YCnxcVVcIv/lXXC86bXznJh2kPNxe3Yll0BvQsC2wD2skidFsYT15JmKthx24eaAh9v7l9I1qONnp5h7j9gXio89XJlra2+oJwWuyaXjzrT4XRStRSZBIHpINfup6hAOpiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 19:19:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 19:19:12 +0000
Message-ID: <ccc16b08-776c-4c72-a533-4806200f437c@intel.com>
Date: Thu, 29 Jan 2026 11:19:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: sleep instead of busy wait for BMC
To: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>
CC: Pasi Vaananen <pvaanane@redhat.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260128-jk-mgag200-fix-bad-udelay-v1-1-db02e04c343d@intel.com>
 <338ff7cf-1c7d-48da-b1b8-37aac440fed0@suse.de>
 <88f33e4e-5d0e-4520-a399-5be2901a3281@intel.com>
 <27af79a8-ee84-4845-a737-82d3883536e7@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <27af79a8-ee84-4845-a737-82d3883536e7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 35eb7dcd-0f53-4779-e390-08de5f6b48e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THJWUzgxbzBXTC82RlJaNHlHQXZyZjNXQWJ6RFEzaFZUb0t1TzJyT295ZXV5?=
 =?utf-8?B?NFBXY2hRRHFDdVlsdjhqTTArVTRieDJCY2IxS2tTU25OR21BZXBuZTJZQXNO?=
 =?utf-8?B?bzJZekp5S1BzOU5LbElNY0VrUXMwMWtUbXZMMEgyeUhoVE9ZQjZEOTFNVmk3?=
 =?utf-8?B?bTJXV252ejU4RnlMbWpoVkhpZjhsUVZhNThwQitNdzBsbDlmKzBDZDR1b0xy?=
 =?utf-8?B?TExjUEhiOVFPSXo2dHQwNzFzUG5tQ1RHVitHb1Y5ckZadnR6a3ltam5BWm1B?=
 =?utf-8?B?YitjWWZ5T21QTW9lK0ZZUXRKNGRBd0ZZWWhTcUw3bSsydS90ZHZobkZZck13?=
 =?utf-8?B?WFBVK28yeTlxK05XazNOOWFYdW02RWpUc3BwN3ZZcTRHbzNoME5XdUFHazQz?=
 =?utf-8?B?WHVtNlU1dEwrc0gwYnFndXpxU3ZTci95WlRrZmtOS2dzNUhEMTR6bllhbWpS?=
 =?utf-8?B?aGgvb1lJU0pjMmNCVzVyVFE3WG9HWS92NlNYOFdFMzZDYlcyb1lZTFZOeHow?=
 =?utf-8?B?S2MyQmpGclhseGxibFluUVJ6QXFEZUc2WFFwNFBUS1JwQUcvK3IzamZyd0ZU?=
 =?utf-8?B?eWpxaDk1N1k4ZnRBSmlSN05vSEd4L2tLbXlOUGdESHFJcFJrNjlpTW5hTE5n?=
 =?utf-8?B?NlRoVzVmWWlad2FRTkhYK08zbjd2K3dhSk9GUWV3Mm42TjVDRktGQ0Nta2xs?=
 =?utf-8?B?NnJaaGducXJZSERRTHdDVlNsYiswL3VnSVlUN2xZNGFrWDBWVm1wSWlyODBm?=
 =?utf-8?B?d1JMcEZFVUc2Q25sd3hZdTdZQTIzMDdLU3VBRUZZbFREOFV6YkVWSm1tTnJY?=
 =?utf-8?B?WlBua3VJMTE0VEplWTdLWm9KU21pTVVHNkxaM3o2UnlqNGFibkZXczN3TXVR?=
 =?utf-8?B?ZDV2MSt1SkR4dDh5Zmp3RnE1L0RUdkM0eFdFZjNrNHlscU5IdEhSenlFOG5k?=
 =?utf-8?B?dlAzbGVqU3AzSDVMTElMZHg3aHdTL0dqUjNsMXpyWlpUYXlPR0hJT0FudkRW?=
 =?utf-8?B?Y1RBZXhxRXZLRnlFNjFOTjFmL0NsM09tNm13SnlQblpocVJPRXM4WERzWWFL?=
 =?utf-8?B?WWprRzdFYTIxWkp5YUpJZnBaRFRiYlBLMmRDUlIwQytXUnNxbGd6T2RPSWVK?=
 =?utf-8?B?WnplS0ZwZTJQYVQvWVNwRG5VY1FrVVQvb2NFcmhkaUhGMEs2VUl5MTZqUEJU?=
 =?utf-8?B?UXVKdFFDR3BiK1BXOFBnOHM1L2lhWTBaZmVRU3Nac2ZtNitXeElTeXl3eHF4?=
 =?utf-8?B?L2NTaUdvQkNEZ1QwWm00bzRIdWFJV1NBeGpucXpUb2VRWWNTRlVLUDEyMUpT?=
 =?utf-8?B?ZmNBWkJNdHlaZVZleW44K1BvemZKaGZDSGtYT05VMU5pVzBxTWZHc1ZEcXN4?=
 =?utf-8?B?bmM1UHRzN1pYcGJNSmJwUEpMTGpYYi9WeWFUMmxuYitud1V2ZDl1SmVJTzVs?=
 =?utf-8?B?WmNXYUczUHdHOFZhNWdZcGhSMmp4THVtTm92My9iY3Zid2RqVnJCWFI2elh2?=
 =?utf-8?B?OHJ5OUpvclFHYWdObnlRWHk3NWhydllYY1NNdjVMallGTGxId29tVm1Lcmpq?=
 =?utf-8?B?ejBILzVUa3FySzVnR3RTL1lOUlJxaGFjV1hTUUN1aHpvQTRNUEMvNkRmeURY?=
 =?utf-8?B?dURDbCtrT2poQnBWVUhHb0xkTzBoemZNWlFXaDNwV0V1MjRHaWNhUGVmdW1t?=
 =?utf-8?B?OHVQSlFDS3FvSlYveFFGM3BzZFM0OWZOd1BNVHBvQmtvQ1VNODdJMjNvazEv?=
 =?utf-8?B?WitncWFhWUFZNy9MSVp6cEdVRUo0ZnQwdVJYVS85b2QyVGVsWTdGNTFYZHI4?=
 =?utf-8?B?S0dRL0tOQXJXN1lsR2hYMmdweEd5bEpuejNDOHg0dGxUYXRpend1T21SRm56?=
 =?utf-8?B?MTlwSWRVNWNUV0xkZEJ2bEU1Mi9NaFhrOWhUQ0ZiVEkxREhzYUwvNTI3Qjly?=
 =?utf-8?B?Mmw1Uk1XODM5NHV2RmZ0enZ1UzVBOUlITlJPNU81dGF3U01wSURCN2xRenlh?=
 =?utf-8?B?a2lXRW4rNGtzclUwQkVLeUtDVkxVSk1SVkt1aW44eHF2NW1sdUo2WHVDU0lK?=
 =?utf-8?B?MWswQ09sOHI1clYzTkFwdmIvbnNHOFBFcWhKemlTWWNJL1BUVktpSVhyUkgy?=
 =?utf-8?Q?dSUk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5xTWlZMmhpMzNjMjBIOHBCRm56U2R2Q0plMmtXVkcwUi8yVS8zZU1HUTBZ?=
 =?utf-8?B?eUZiUE5GOXI5UjBNTmEzODlOdEpBQjkvemhlMEN6SnpmUmFCV29tRGlXV0M4?=
 =?utf-8?B?N2Z2Sm1ROGlqSElVeU1xWDNyRmJRTjV5RVh0ZFBmSG9hTXlyYU0xNmg4cjhx?=
 =?utf-8?B?MFh3SUZhbTNtdklrb1NKMXV2d1JQSUw2NmY1MnhtYWVMdzhrdFZxOWlNeXQx?=
 =?utf-8?B?MURBRW0yb0NiczUrZ1J6U1JPdGFFSnhINWtFVVBOTWY2bHZuKzJhQVFuTVFi?=
 =?utf-8?B?NklwVGJlL0JFbUI3UUV6UVNrS1pRZTUwbjlnQnUvNUc0ZW5LRlFacjh3NGxG?=
 =?utf-8?B?OE94Z1N5ckVLVWtEUHQ5Y0JRNWRhRXpXMEM1N0tRY2dPZUplZjIwYVF5STZa?=
 =?utf-8?B?SXozK1lRVGg4bm1NTjY4WTlFbG0yL0FyaU9WUzRRRWltSjdQZVlaRFIyVjhB?=
 =?utf-8?B?bDdrY0JjNk5iVkozbnQrbmZGeUJBdVRFYjVuSzJoTnZNT0oxMHRNWTVWOEN3?=
 =?utf-8?B?d2trWThkZ0pOMWNTTW4yWjErRStiV3NLckNrN1JwOVVFODlsUlZtSlg4Uzlu?=
 =?utf-8?B?VytVNitQNGZsbnAzRTF5ci9PNk5aYlV5d3dEZWx0SjJZcVhVVUU5MjlKTmd0?=
 =?utf-8?B?TnJiS2JMU0EyaUV5dk90M0p6eWlUa0crYVR5ZmdZVUJUcnM2V3dmTFRhQ0JT?=
 =?utf-8?B?NGhxV2RSODkwMW1uZmRreEpzREdjZVQxQjd3bmw5NGxnMVRTUDlwWHBOaTNJ?=
 =?utf-8?B?Vk5RdmVTQXlrWFZWYjRnZENhWURXL1Fhc3dvOUM2V1lISG5vdDdMMG9BYnBr?=
 =?utf-8?B?dU8zODM3ZVZtNGQ0RHNnY2VzR1BreDl0Q0h0azdUSVNEdFhzd3FWaTlkNDFT?=
 =?utf-8?B?eU5qVi9WTTFhclNrRmM5TEVQSWZPQmw2SzRnaGMweHZOWkdQeGE0UlB1REx1?=
 =?utf-8?B?Mi8yRStic21SM0F1ZHpIRWtwVXUyVGRib2E3RnNsL01EZEE1R25sZHZIK01Q?=
 =?utf-8?B?ZXVTVHRrT0U5OC9mSzcxU1U1a3dkenJGZy93SjN6SUpsR3hjSDVuRnN2bUVt?=
 =?utf-8?B?TUdNM25QMFpQSjVLMm01R1JsWHNyeFJPZzczTVNYNkhVNUZvNEkwVUQ2UUJz?=
 =?utf-8?B?UXNBVWQwTFJ2QVVyY09zYm9ncmYxaGhCZlZlYzF6bTJVOWZMMVRWT0tNSEhv?=
 =?utf-8?B?TnJRMHY4YW9ObkJUTzlreWZRSjlXV1daMTQxQkhJb0tYYnJCeXA0T0daaDMr?=
 =?utf-8?B?aGxFNkFKNVBFb3k5bWR2S1l1M2VLaDdyWEMxcEc1T1pVaHB4aWRFcVZYZmhk?=
 =?utf-8?B?VWJBUlBaaXdBL2YyVktSbURtcE5uaWlFWHpEaGFkdWxJTmpXSUlCZzQxYzE1?=
 =?utf-8?B?ZG5TVDB1bGlVNy9LZWZCNCtEbWM0WFJZM0VkOWhhNXc1RVdyRm4ySlhPYUE0?=
 =?utf-8?B?VFhDZGR3Z3BNV3dVSjNEbjFMSVpNeWpXdS9RZFphcXBjNmg2a2hXUzB0MU1t?=
 =?utf-8?B?aEI0YzVJS2VPTS9TcTJLZ0s5OUE1TTdKRzFNMkE1d1pqL1ljTGRaSk9uVTQr?=
 =?utf-8?B?ZS9HMENlaEk5SkpHTkNvazJHTlR1MFc1bis5RnJjb1VKekUrZVFFR1BUeGp3?=
 =?utf-8?B?RXRjNXZ6ZnlKK241S1NnODhYdHlQdjU3Vk8yKzJuUkFjZmhTUWI4QmVERHVX?=
 =?utf-8?B?N0h3MEtKa3NlRTZRQUN4QkVSYlY4NnhqZm9Yekoyd1VacDV0b1REREd3WnMr?=
 =?utf-8?B?Rm93WHZwN1VzdHovdWk0TDJKRHYyMFRqdVZYM2tTakVyNXNLZEtxdzdIR1dS?=
 =?utf-8?B?YjFiSDBrYTJxUHBKRE11QWhNSDJBMVJQVWFOTDVtOVhTbW1lUTFQV0xLU3lP?=
 =?utf-8?B?eXpVTStyVkdBNUNZcDh5d1V6TnN3NnVGM09ESEg0c2V1QitGQkt5VjhBMm9y?=
 =?utf-8?B?bGVTU3N6Y2JQbGFiUjFhNHE0b25GbVhoOHpyZi9TN1Mydi9zMDg1cFV1Z2NR?=
 =?utf-8?B?SkN2NlA0UjJwU3J3MlBWOHVsMTJ4c0k4SW1BNktXNWEwOTRlMmRFWk5PZHYz?=
 =?utf-8?B?a3hYOUZGbjBFZDArZ21nUmdzdm5odFZaVWxLQXl6bEZRbG00V2pSaDlWdk5Y?=
 =?utf-8?B?aUcyMW9NV3NUOEU3ZFFpbzArVFlpZ1VRSXBpMW8xQUtXOGJwdlZLcUlRU3BI?=
 =?utf-8?B?VFA2ditlaFFDNi9oNmhMWXROT0R1WmRtUHRkVzhFd3hxdERRWGYvTG5iWnlP?=
 =?utf-8?B?dUtmTEFpa091SFNMVmdhS3Jya0t5VHl3UitQaUh2bnJzMEFyK3J4dnZtSW5a?=
 =?utf-8?B?amFWdEJMZTJFMmVaWlo3bGhid0ljakovU2taditoM3BacCtRMjlwQ3NlL3Ay?=
 =?utf-8?Q?P6tX99s5zkg4eBFA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eb7dcd-0f53-4779-e390-08de5f6b48e4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 19:19:12.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMvhgOVS5rBJO2xwXLAo9dQ0fJWNBg6kiUFuSa4PbcKAgeIziUV6257DtGLw6d+LGgvgr/uIjDb5zb/+ZBISR8fOl4fFFOxmbD/TIQIBYlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212812-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 88035B3DCF
X-Rspamd-Action: no action



On 1/29/2026 10:47 AM, Jocelyn Falempe wrote:
> On 29/01/2026 18:35, Jacob Keller wrote:
>> On 1/29/2026 12:15 AM, Thomas Zimmermann wrote:
>>>> diff --git a/drivers/gpu/drm/mgag200/mgag200_bmc.c b/drivers/gpu/ 
>>>> drm/ mgag200/mgag200_bmc.c
>>>> index a689c71ff165..599b710bab9b 100644
>>>> --- a/drivers/gpu/drm/mgag200/mgag200_bmc.c
>>>> +++ b/drivers/gpu/drm/mgag200/mgag200_bmc.c
>>>> @@ -1,6 +1,7 @@
>>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>>   #include <linux/delay.h>
>>>> +#include <linux/iopoll.h>
>>>>   #include <drm/drm_atomic_helper.h>
>>>>   #include <drm/drm_edid.h>
>>>> @@ -12,7 +13,7 @@
>>>>   void mgag200_bmc_stop_scanout(struct mga_device *mdev)
>>>>   {
>>>>       u8 tmp;
>>>> -    int iter_max;
>>>> +    int ret;
>>>>       /*
>>>>        * 1 - The first step is to inform the BMC of an upcoming mode
>>>> @@ -44,28 +45,20 @@ void mgag200_bmc_stop_scanout(struct mga_device 
>>>> *mdev)
>>>>        * 3a- The third step is to verify if there is an active scan.
>>>>        * We are waiting for a 0 on remhsyncsts <XSPAREREG<0>).
>>>>        */
>>>
>>> Either these comments or the original test seems incorrect.
>>>
>>> The test below is supposed to detect whether the BMC is scanning out 
>>> from the framebuffer. While it reads a horizontal scanline the bit 
>>> should be 0. That's what the test is for, but it gets the condition 
>>> wrong.
>>>
>>>> -    iter_max = 300;
>>>> -    while (!(tmp & 0x1) && iter_max) {
>>>> -        WREG8(DAC_INDEX, MGA1064_SPAREREG);
>>>> -        tmp = RREG8(DAC_DATA);
>>>> -        udelay(1000);
>>>> -        iter_max--;
>>>> -    }
>>>> +    ret = read_poll_timeout(RREG_DAC, tmp, !(tmp & 0x1),
>>>> +                1000, 300000, false,
>>>> +                MGA1064_SPAREREG);
>>>
>>> The original while loop ran as long as "!(tmp & 0x1)".  And now the 
>>> test stops if "!(tmp & 0x1)" AFAICT.  This (accidentally?) fixes the 
>>> test and makes the comment correct.
>>>
>>>
>>>> +    if (ret == -ETIMEDOUT)
>>>> +        return;
>>>>       /*
>>>>        * 3b- This step occurs only if the remove is actually
>>>
>>> Since you're at it, maybe fix this comment to say
>>>
>>> '... only if the remote BMC is ...'
>>>
>>>>        * scanning. We are waiting for the end of the frame which is
>>>>        * a 1 on remvsyncsts (XSPAREREG<1>)
>>>>        */
>>>> -    if (iter_max) {
>>>> -        iter_max = 300;
>>>> -        while ((tmp & 0x2) && iter_max) {
>>>> -            WREG8(DAC_INDEX, MGA1064_SPAREREG);
>>>> -            tmp = RREG8(DAC_DATA);
>>>> -            udelay(1000);
>>>> -            iter_max--;
>>>> -        }
>>>> -    }
>>>> +    (void)read_poll_timeout(RREG_DAC, tmp, (tmp & 0x2),
>>>> +                1000, 300000, false,
>>>> +                MGA1064_SPAREREG);
>>>
>>> Again, the comment and original code disagree and the original test 
>>> condition appears to be inverted. It whats to test of the BMC has 
>>> finished scanning out the final frame. The bit should turn 1. Instead 
>>> it tests if the bit is already 1, which is likely true. Hence that's 
>>> probably where your 300 msec delays comes from.
>>>
>>> Best regards
>>> Thomas
>>>
>> @Dave or @Jocelyn, any chance one of you could help me figure out 
>> whether Thomas is correct here? It does seem likely that the 
>> conditions were originally inverted and thus forcing a wait for 
>> 300msec every time regardless. That does match my experience... But I 
>> don't have (and web searches failed to find) any relevant datasheets...
> 
> I will give it a try tomorrow, on my test machine, and check what this 
> register value is in this case.
> Regarding documentation, I've only seen the original documentation for 
> the Matrox AGP card from 1999, but I never seen one with the BMC registers.
> 
>  From what I understand this code is only there to wait enough time. As
> mgag200_bmc_stop_scanout() is only called on hotplug, we could even 
> replace that part with a msleep(300);
> 

If Thomas is correct, (and the comment was correct but not the 
implementation), then I suspect we'll actually be able to wait 
significantly less time than 300 msec.

Thanks,
Jake


