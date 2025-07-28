Return-Path: <stable+bounces-164939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAF0B13B89
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9AF1884C58
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C132022DFBA;
	Mon, 28 Jul 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6qtGCqh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579781BC5C
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709472; cv=fail; b=WauSV7cMZ+J/FRLr7Ksil73PLQZtCGGBqiBE9enelMtg35pUcEn/jnM4IXeWmflGgsRTzKn83GYkG+jODEFfIE2DDMRmm985gqq65WR9v57HIRQYYDZjGUnx4NY4b+yfblxQ7APn5MnUIPaKUosw9FjP971S5eL1AITR0sixXGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709472; c=relaxed/simple;
	bh=HDzJnyk9suqUXEM5bU1AQIcyk/UEWQFRkUYKbe0ML+A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQR5acPeJcuxNOdVtrgq5Se7WL1Mw7l4cAdih6/co4F3I08n8yzLepAp7oY2b9+if1J9Zpze3A8sM+w1zu7iPue2FoZ0FF/AeMNxgFFXZEUILFa12Lcoh03CTqgyFXmWlJCLpP9dwr3jSIkV27k42mjFiOQnLepjPfF5IKYZ7aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6qtGCqh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753709470; x=1785245470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HDzJnyk9suqUXEM5bU1AQIcyk/UEWQFRkUYKbe0ML+A=;
  b=Z6qtGCqhRO51sU/5RbiuAxCs2D1UGNG0lwcv7uwGk3Kekq5hCCsblaH8
   XoP2vMMTZ5Na3qLlii3TKgC0wjRrUeE/I/i4bp//f694ui171NpSTTaie
   2arcSRR0Uf4XBaw9OKUL9Ag1GlvufyF2EP9k5taeFRSHaq0u/uk6dTpRa
   7ZIzKKMP/Ew7TY5wpsBQLNqD9xPq3eMNFR9idCvdzQyzos3VNKDpskt+V
   GpRKamCwq7A1wiCwSnHHnRnmVaiTEkKNCnSZ5DsIGvSQOoGA3v/DbGeM6
   jbkxsVjz9yBP+DrTmFGnTbF1lBaptUKGTjTfkqoguMFIxn1FlXtsO2D5E
   A==;
X-CSE-ConnectionGUID: boRuxMvpQcC2mvNvRW2XvA==
X-CSE-MsgGUID: I7lbcuNbRmOgzx9MYLcbnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="73541927"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73541927"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:31:08 -0700
X-CSE-ConnectionGUID: 10BnpqJRRROWw+kB0uoDYw==
X-CSE-MsgGUID: OsqppJ3ESkell+h9QVM7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167827990"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:31:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:31:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 06:31:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfQM/HdQDrDgPkyPj0RM07qC/6zmhALEbh2dd3QhsjwvR0EiVNRjBdBM33auAUwQ4eQcjuOwNvJ8hd3oMl45zpW4tAv64AfUidNcveDcH4FBiZSr1sFo3L1V8XDfbG9DelKEJz6gMeKBE5rzsrtqRsgIWYS6JwkCPm7RspgLnQyYT6yO2KyZ8IJXq2if8UnB+qzZNfjmyaOn+e9tL5H9GPGrCwr/EhyKby2c4MHHUI9Rj7je140+bz/aSvi57tXode1u4nbhwhrhU8EVx7lFXYXL9xw2ZRAG5N8wL0i2TFVlTk7dAS9WiT2feziLXrG/36y65GAMsUPtY9LjZfBj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh1de6xVZ2ki3rMClvIXdQJ9cVILsVKjN3jB4uoIo8s=;
 b=n0F97md9IT3gAARA2emJ65/w1phDvEC6QGddkZyMVUhozAuMXrZ1rSe6S4I2NQ3prGBJ4FWvRpD3JsHlG4BkQU1BWnnWq6M4Xey67x0DMsGP/0GqLTFXXiDXnSOckbl8hlxm3qBuFhpbrzBjf06htZyQVqtMotzzfyJBSjENiDRY9fyN1L/CmGYJJhRDfNu/1BPrhlBITYqq6fyAuFlHeS0n9VEu9pRk+JelB/PtAiT2o8hAivX3JAb+C26FA+LkMAMuMusXfN7epmWLtbv966KVkc8F4hKIFcMeaHUuQNpe+w5/qfIedqkkD/WfRE2YceAswXrHgyDoJzEoRPV5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:30:51 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:30:51 +0000
Date: Mon, 28 Jul 2025 09:30:45 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
CC: <intel-xe@lists.freedesktop.org>, <jeffbai@aosc.io>,
	<stable@vger.kernel.org>, Wenbin Fang <fangwenbin@vip.qq.com>, Haien Liang
	<27873200@qq.com>, Jianfeng Liu <liujianfeng1994@gmail.com>, Shirong Liu
	<lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>, Shang Yatsen
	<429839446@qq.com>
Subject: Re: [PATCH v3 1/5] drm/xe/bo: fix alignment with non-4KiB kernel
 page sizes
Message-ID: <aId7hYAfMxlBTV8x@intel.com>
References: <20250723074540.2660-1-Simon.Richter@hogyros.de>
 <20250723074540.2660-2-Simon.Richter@hogyros.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723074540.2660-2-Simon.Richter@hogyros.de>
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 5543597c-820a-4f5c-0aef-08ddcddaf830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mvKdFQc5uo+MdThvCGW2qBeNlrpAVWb9iYMn9wKal+/WdSvJjiiz82fn+V4q?=
 =?us-ascii?Q?nRNeO8QIH60TPZYHB9N9cmcnRVR3SUaw1MRcKaonSqTQympmh8yWdy/5sF/a?=
 =?us-ascii?Q?e/M7zT3sx80rWaVqyoUJyTZQMq5cbm/4sUYedcsxmFuOzGuPaeH2YW8sMiNs?=
 =?us-ascii?Q?07KlQPKMq4aZLnFLdiIs4ybUcUppnWi+TCMOriVBbt3rZxMa3oPZjkHhdtPa?=
 =?us-ascii?Q?2HxvQQxTVUv0Gio/DoZPNzTWK5wngKza75S2P8vNOUm+LktfRoM0DyoRK/K5?=
 =?us-ascii?Q?avVOuQmAeVqMHByeLSku7e6zqnA8/gk3jYDZ/xeY/O5dpIE7OVO/YvLGbWW6?=
 =?us-ascii?Q?xNNu/MeLWJFGt/lPXstEn6rIQxREbntlZ1LUQ0w/GGVT70zzS0bBlgHRxDw6?=
 =?us-ascii?Q?yM+nGtGLB38LjWQaeEl1PU6ZGvDP/jqqibZws4H+gcPGyK2ye151Ld0apXVm?=
 =?us-ascii?Q?JMGS7fOo4WBeZIrhfo2+ql59qzAziUfR6Q8XfuaY1oFAT7TPEegOf1f42lCI?=
 =?us-ascii?Q?LVQd9DnwQ0MANbFVYENx+S4ELlx93bJ66Kh9upV+Ibpxh02TQTokdWtd77p/?=
 =?us-ascii?Q?spPVNQ9Vul7k1AJRVJKlX1cm16n/GnLqdXQTUT3q60cdVDWvLqzeMzInHyh+?=
 =?us-ascii?Q?KC6cgvlFhIvtIm0zDc7v2E9L+M32pTwv/h4OgXfeyRycXUDuKB9H1H4hQUID?=
 =?us-ascii?Q?GwA7wH2gUZjXv3HIigOM1tIgqXqDPpLKljMTFrcJL4+ftUgfLLtC9dKEn4fE?=
 =?us-ascii?Q?VSm+xhocjVx1/5E27PEtros7R2WsPIL57ubJFxaxkTXmONf9fH48+/ns91Iy?=
 =?us-ascii?Q?ABBocy6VirIo/h2zcNLyAPZD8lQCL43UXvvt9rpglvFVIxKmOWPzMIdTDqms?=
 =?us-ascii?Q?DoJFPghaZjxAc4SfPGcffuAHhNptiuOOMLSu+sRTeGmHQDrij0BltLFB8KaX?=
 =?us-ascii?Q?vXc/TV7RndKcX5yLVo+lD0NjqIacnwAiYc0uI8gvLZjzHHa7MuJgNI9wbm+4?=
 =?us-ascii?Q?0y2tMiMFi5Q4fbOTHIln6gDIGeDZ/Vgy/Yk/67ra+GC4SWvs85lDGLL84A0a?=
 =?us-ascii?Q?zKmzPfS3+Gg2aPx5SzodF3Y0090OXPM3CgTQbcODfXhxSdd8fhykWC6+MIar?=
 =?us-ascii?Q?0cxnozmrdJB0Rw1er1JUX+23dn94200PzDLUccFFEVDmi35Mr4UL4hxjd5At?=
 =?us-ascii?Q?uzahnI6YZvV7XR9MapW5rVO2iTTA6dNHH8k6iv9f65KdwiPB2M+qS+EwbJrl?=
 =?us-ascii?Q?dr739bYqPqBOXYuMSvTvjsZ7zedIG8ZdnA4dYxyF3Kx3JKwORtDHfjqPK0as?=
 =?us-ascii?Q?wJu9zMEzFCu3BNS7MDEke2DbHY9Td4VpAJE06hmYv2er6yI9T3dqL62/cyyp?=
 =?us-ascii?Q?cosu7yvj1OYOJaDMbL11FBGf+De/Lskox6o2fJUIekv5N+tvbz3cVFqDrrdE?=
 =?us-ascii?Q?nlcoJqO/8Mc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jXf3qy2dtIlEyIv7mlIvI6pdvwPxRmVaT1b4t7fR6iCXA49E7Z234b8HXG/c?=
 =?us-ascii?Q?AdeffGs9Eqq/ZYhRFmcZ9JIAWOvaRwd+Z82TGYUhE9BU6nPlSo1rnItygAZ4?=
 =?us-ascii?Q?VWr5m4HdORERS62WKwtVO2kvM69xE/XRf1d0Li2lttGrj9yAkgILt/fIFfaM?=
 =?us-ascii?Q?sEvvaDG+x05XvCvP9LIH6tl98uBseuzgP6/ucIN6Bo27Ruyn6rD+UsgGko/P?=
 =?us-ascii?Q?2MdcNLg1n/qpXLyCRWV1/vyVlK+v0WwTmFMJ0HJn7EYEda8D+Vk69Hp2vaEb?=
 =?us-ascii?Q?C4rGpnKunoNMbfWrml9vnEbk7t8QLfA8Krqgli3dmEx56ttVMtDwgkeV7kb0?=
 =?us-ascii?Q?SlpS6Pyrf3UsMmCft7pmaeyZNTcyhCyTCH3FOz5LXEOCwSzym4NMVc6tOiM/?=
 =?us-ascii?Q?0xMVQul7V2OwZJ+TVfdMQ6Sc9jh/1xGuRiugcg7IALe3UGF9Iaj3IaTjiAV6?=
 =?us-ascii?Q?CZtswUP9CYBOZWlFdG7ljb+/8BhQWbG0GeBYIz0umbDPXXeXBaSzZPv6wdcx?=
 =?us-ascii?Q?AJ5TGbzy1aOtMZO9qaC8Vf8RQni2TdyxMsooHQMIcZjK1oy2x/cZfF7VO2wD?=
 =?us-ascii?Q?nIirMjRhpyLYIi4Ff4ZdAlaidKL/ZHkD3p6KWOh8WXthPFl6IH8PuCnkVcj1?=
 =?us-ascii?Q?n/B+4n5l8oIrzwoDnPdHn9wdlpoVARqkAzYFt51f+pv24Cc0oFs2k7w4BYTl?=
 =?us-ascii?Q?Y2qHaQGhiGH/L2JS6l/wPewq/RPO/B6EiZ0sWUbw40uExrApSQ9tRRlRqQpl?=
 =?us-ascii?Q?JBPaI/mp75Pbmx+Y4kVJ2YhUcHyUSOXmVEVoeP+NX1Dva7j35imf9qnQqRNW?=
 =?us-ascii?Q?oe+bWqjmHtg4wCdKtGR5M/ND9ad8zdOx7dMSgnx0PjwmR1QdKWpHPno8/2Jz?=
 =?us-ascii?Q?VeSnbWgHa16T0msoFd/bSaQJzerc5cMRY+1z9FxDJ3fePjxgK7qRN1PwZPP+?=
 =?us-ascii?Q?UbKeTEeiJTtqpo2p392q09ivc9HgALUWVONwIRJBrptTb4jgdPSBOehrbC0l?=
 =?us-ascii?Q?vLboq1XE4KU8JSefPzYKpC9DlAf8D48jUgdFOIwIni080UKXvvwz+DFmEoci?=
 =?us-ascii?Q?5VdxKs7kEMlCP4pxywyYrDfIe22zZsjqtzKGlQnb1d3MZ9vnuTvnkcmx4KNg?=
 =?us-ascii?Q?lPtGnm8S87O15veJT77ff4nxIh5Of9kiQ1QcduUcUX9N7Ur0CExuqHnxg4QV?=
 =?us-ascii?Q?XubwAhFhGiNf6haZdTWPXtYnM822cmgIIT2d+QKElCobR96JMV4ouQF7bloN?=
 =?us-ascii?Q?I6kp84E2OyS34mo4w9HfK3aY0F0eTi1OI8k9TfGK3r42q2ooe1DgrpGZnVry?=
 =?us-ascii?Q?z8nyKmR96HCHtqvo4d/nnK5eDZapzrf4DXqjRsGYCl/X4WgbKDtLnkMz+RQD?=
 =?us-ascii?Q?PSnmuLiZ2ycpxDCMe38nW85XTrlzqR92iOQubBTvft4iLw0HjtNT/pEIKaSy?=
 =?us-ascii?Q?IXAgKB5rw+Si565dRiSMMXWMFPt2pau3sGM/pHevy2HMRtukOBzHhbieKIln?=
 =?us-ascii?Q?Yh4CN5S0TfeX/JE07paQoV2dpJITokxQNoPLA3ewLa3l4zo4BfsdYsh2y0Zr?=
 =?us-ascii?Q?VxsGU4eVYNxpzX/ns2Rkn3a9QuubWQ3Qc2r64lhR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5543597c-820a-4f5c-0aef-08ddcddaf830
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:30:51.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR/4kuzco+AqXDJUCYDCoNEmqLWXcndYL1azlpAnBslRaNV5/iCKK236UKq6iJk8bF7NTl0kXniwRX+UDN5gyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

On Wed, Jul 23, 2025 at 04:45:13PM +0900, Simon Richter wrote:
> From: Mingcong Bai <jeffbai@aosc.io>
> 
> The bo/ttm interfaces with kernel memory mapping from dedicated GPU
> memory. It is not correct to assume that SZ_4K would suffice for page
> alignment as there are a few hardware platforms that commonly uses non-
> 4KiB pages - for instance, 16KiB is the most commonly used kernel page
> size used on Loongson devices (of the LoongArch architecture).
> 
> Per our testing, Intel Xe/Alchemist/Battlemage families of GPUs works on
> Loongson platforms so long as "Above 4G Decoding" was enabled and
> "Resizable BAR" was set to auto in the UEFI firmware settings.
> 
> Without this fix, the kernel will hang at a kernel BUG():
> 
> [    7.425445] ------------[ cut here ]------------
> [    7.430032] kernel BUG at drivers/gpu/drm/drm_gem.c:181!
> [    7.435330] Oops - BUG[#1]:
> [    7.438099] CPU: 0 UID: 0 PID: 102 Comm: kworker/0:4 Tainted: G            E      6.13.3-aosc-main-00336-g60829239b300-dirty #3
> [    7.449511] Tainted: [E]=UNSIGNED_MODULE
> [    7.453402] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05756-prestab
> [    7.467144] Workqueue: events work_for_cpu_fn
> [    7.471472] pc 9000000001045fa4 ra ffff8000025331dc tp 90000001010c8000 sp 90000001010cb960
> [    7.479770] a0 900000012a3e8000 a1 900000010028c000 a2 000000000005d000 a3 0000000000000000
> [    7.488069] a4 0000000000000000 a5 0000000000000000 a6 0000000000000000 a7 0000000000000001
> [    7.496367] t0 0000000000001000 t1 9000000001045000 t2 0000000000000000 t3 0000000000000000
> [    7.504665] t4 0000000000000000 t5 0000000000000000 t6 0000000000000000 t7 0000000000000000
> [    7.504667] t8 0000000000000000 u0 90000000029ea7d8 s9 900000012a3e9360 s0 900000010028c000
> [    7.504668] s1 ffff800002744000 s2 0000000000000000 s3 0000000000000000 s4 0000000000000001
> [    7.504669] s5 900000012a3e8000 s6 0000000000000001 s7 0000000000022022 s8 0000000000000000
> [    7.537855]    ra: ffff8000025331dc ___xe_bo_create_locked+0x158/0x3b0 [xe]
> [    7.544893]   ERA: 9000000001045fa4 drm_gem_private_object_init+0xcc/0xd0
> [    7.551639]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
> [    7.557785]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [    7.562111]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> [    7.566870]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> [    7.571628] ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
> [    7.577163]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
> [    7.583128] Modules linked in: xe(E+) drm_gpuvm(E) drm_exec(E) drm_buddy(E) gpu_sched(E) drm_suballoc_helper(E) drm_display_helper(E) loongson(E) r8169(E) cec(E) rc_core(E) realtek(E) i2c_algo_bit(E) tpm_tis_spi(E) led_class(E) hid_generic(E) drm_ttm_helper(E) ttm(E) drm_client_lib(E) drm_kms_helper(E) sunrpc(E) la_ow_syscall(E) i2c_dev(E)
> [    7.613049] Process kworker/0:4 (pid: 102, threadinfo=00000000bc26ebd1, task=0000000055480707)
> [    7.621606] Stack : 0000000000000000 3030303a6963702b 000000000005d000 0000000000000000
> [    7.629563]         0000000000000001 0000000000000000 0000000000000000 8e1bfae42b2f7877
> [    7.637519]         000000000005d000 900000012a3e8000 900000012a3e9360 0000000000000000
> [    7.645475]         ffffffffffffffff 0000000000000000 0000000000022022 0000000000000000
> [    7.653431]         0000000000000001 ffff800002533660 0000000000022022 9000000000234470
> [    7.661386]         90000001010cba28 0000000000001000 0000000000000000 000000000005c300
> [    7.669342]         900000012a3e8000 0000000000000000 0000000000000001 900000012a3e8000
> [    7.677298]         ffffffffffffffff 0000000000022022 900000012a3e9498 ffff800002533a14
> [    7.685254]         0000000000022022 0000000000000000 900000000209c000 90000000010589e0
> [    7.693209]         90000001010cbab8 ffff8000027c78c0 fffffffffffff000 900000012a3e8000
> [    7.701165]         ...
> [    7.703588] Call Trace:
> [    7.703590] [<9000000001045fa4>] drm_gem_private_object_init+0xcc/0xd0
> [    7.712496] [<ffff8000025331d8>] ___xe_bo_create_locked+0x154/0x3b0 [xe]
> [    7.719268] [<ffff80000253365c>] __xe_bo_create_locked+0x228/0x304 [xe]
> [    7.725951] [<ffff800002533a10>] xe_bo_create_pin_map_at_aligned+0x70/0x1b0 [xe]
> [    7.733410] [<ffff800002533c7c>] xe_managed_bo_create_pin_map+0x34/0xcc [xe]
> [    7.740522] [<ffff800002533d58>] xe_managed_bo_create_from_data+0x44/0xb0 [xe]
> [    7.747807] [<ffff80000258d19c>] xe_uc_fw_init+0x3ec/0x904 [xe]
> [    7.753814] [<ffff80000254a478>] xe_guc_init+0x30/0x3dc [xe]
> [    7.759553] [<ffff80000258bc04>] xe_uc_init+0x20/0xf0 [xe]
> [    7.765121] [<ffff800002542abc>] xe_gt_init_hwconfig+0x5c/0xd0 [xe]
> [    7.771461] [<ffff800002537204>] xe_device_probe+0x240/0x588 [xe]
> [    7.777627] [<ffff800002575448>] xe_pci_probe+0x6c0/0xa6c [xe]
> [    7.783540] [<9000000000e9828c>] local_pci_probe+0x4c/0xb4
> [    7.788989] [<90000000002aa578>] work_for_cpu_fn+0x20/0x40
> [    7.794436] [<90000000002aeb50>] process_one_work+0x1a4/0x458
> [    7.800143] [<90000000002af5a0>] worker_thread+0x304/0x3fc
> [    7.805591] [<90000000002bacac>] kthread+0x114/0x138
> [    7.810520] [<9000000000241f64>] ret_from_kernel_thread+0x8/0xa4
> [    7.816489]
> [    7.817961] Code: 4c000020  29c3e2f9  53ff93ff <002a0001> 0015002c  03400000  02ff8063  29c04077  001500f7
> [    7.827651]
> [    7.829140] ---[ end trace 0000000000000000 ]---
> 
> Revise all instances of `SZ_4K' with `PAGE_SIZE' and revise the call to
> `drm_gem_private_object_init()' in `*___xe_bo_create_locked()' (last call
> before BUG()) to use `size_t aligned_size' calculated from `PAGE_SIZE' to
> fix the above error.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 4e03b584143e ("drm/xe/uapi: Reject bo creation of unaligned size")
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Tested-by: Wenbin Fang <fangwenbin@vip.qq.com>
> Tested-by: Haien Liang <27873200@qq.com>
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Shirong Liu <lsr1024@qq.com>
> Tested-by: Haofeng Wu <s2600cw2@126.com>
> Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
> Link: https://t.me/c/1109254909/768552
> Co-developed-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>

please remember to sign-off whenever you are sending or handling other's patches

> ---
>  drivers/gpu/drm/xe/xe_bo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 00ce067d5fd3..649e6d0e05a1 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1861,9 +1861,9 @@ struct xe_bo *___xe_bo_create_locked(struct xe_device *xe, struct xe_bo *bo,
>  		flags |= XE_BO_FLAG_INTERNAL_64K;
>  		alignment = align >> PAGE_SHIFT;
>  	} else {
> -		aligned_size = ALIGN(size, SZ_4K);
> +		aligned_size = ALIGN(size, PAGE_SIZE);
>  		flags &= ~XE_BO_FLAG_INTERNAL_64K;
> -		alignment = SZ_4K >> PAGE_SHIFT;
> +		alignment = PAGE_SIZE >> PAGE_SHIFT;

okay, this is definitely right

>  	}
>  
>  	if (type == ttm_bo_type_device && aligned_size != size)
> @@ -1887,7 +1887,7 @@ struct xe_bo *___xe_bo_create_locked(struct xe_device *xe, struct xe_bo *bo,
>  #endif
>  	INIT_LIST_HEAD(&bo->vram_userfault_link);
>  
> -	drm_gem_private_object_init(&xe->drm, &bo->ttm.base, size);
> +	drm_gem_private_object_init(&xe->drm, &bo->ttm.base, aligned_size);

but this is strange.
think that we could get rid of the aligned_size variable and only go with
size = ALIGN(size, PAGE_SIZE)

but then there are some checks in between on the alignment
and different handling in different if conditions.

We need further clean-up there to make the change obviously right first.

>  
>  	if (resv) {
>  		ctx.allow_res_evict = !(flags & XE_BO_FLAG_NO_RESV_EVICT);
> -- 
> 2.47.2
> 

