Return-Path: <stable+bounces-195135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C501C6C2C8
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 01:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1F4E9C53
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56336221DB0;
	Wed, 19 Nov 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fne/kEc/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111A21D58B
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513437; cv=fail; b=NgffOe0dDqsov1LvbQ9C8BBR/S6krdrDTUz3psHcDAcdBSeE0iNCPxPkTHkCNRuJS+KONt65t99Wtby+KFlUDJMB4XB3b3u7mR1VrFCmFflfpiS2Yx6Uvg/rGbSAXG0/fWLjFcNr8XoNHMmaVzH6LtjWWtV0JZpYCdQIgJGRACQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513437; c=relaxed/simple;
	bh=SrIiQegp/IeEheVzym0Kx7Od6L+NbV6Q1Co1p1w2Wkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SebjohJN0J4f9Qo1zJBRiS1sEwm4jFstJD9ikjfH0rCshMqJtUqxAPEqMMjHqrSnUyeHX6IbWg1cZefPpbZy6THoIe8zdxdbJOr+kanX8RIjQJmMSka+rzSvpbEaAvDbIAVlfuAi7g/JALlwc9XbZBxBJP7oxYC75+fMjsXmdB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fne/kEc/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763513435; x=1795049435;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SrIiQegp/IeEheVzym0Kx7Od6L+NbV6Q1Co1p1w2Wkw=;
  b=Fne/kEc/HpOg5KDetXXTrT28aY1MjOT2JX6zcb5qEF2eX232uLE4CT73
   m1EtoMTdM3WHT30Ag/Hau1l3Y/2wyNjY47kLaDake/375nM1xQMR3/jdc
   ckLb85PswHOA7FL7tIfFtD8SKPUA9tmXJVa3d6rtV08osGEOaJpfT/ghw
   +70p/2905Zb8PN1L7sjTvzjggnkZe1HYZ7gnSEjv/sD5fjsdqe7/6mKN9
   BmP8okUFGNruvEKbIqL64alJHkevgOKIfBaDLsNm+HomePmKH5/0BYqQI
   svn7tyNzTHYVFotrJVQD2TVWh1L8geO2g1f/2DeGJkqsuLyid5zbZ6DaK
   g==;
X-CSE-ConnectionGUID: LddREiK/Q7KbtFL/Tt8/KA==
X-CSE-MsgGUID: pQGCPLvRSneT6Ao7uq0J4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65489208"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65489208"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 16:50:17 -0800
X-CSE-ConnectionGUID: qlsOUYIkS7WVDMpvtDSSnQ==
X-CSE-MsgGUID: 6/CTqM2ASk+YirT2zKtttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191344767"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 16:50:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 16:50:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 16:50:16 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 16:50:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfhReTPrRC6bFIpp2hGDz5vCxUN3JqbgD+Qz9uvbK/HXBSu/qf+fE/lLQYwvUSxtYr7nbtrCYK94q1Zx/xccbuo3vxPhoahf/hmIz5VJK9DunsCEhYIsXC30D/GxeTXe0sdIwxQSN4BD+qwx5G55nnLTXaoUdNvhO+7bm3TtCkmwIIEqF5ESgESs5bw5BECpIrZjXSVeMXA9lcKn8HRt7QfrD4SlpOe874xMdbU9rummnaXdgBOHh1NUyYbKh0SLr9J1xvPHaaAiWfNg7R94rA5z8x5X/M1Ml1UOJM2xljbtt2OED/GaY8yUzPdN4sA4b7Aa6awVOpRqmcfYOUAEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8OUXRRp08wDvUQmg2g56wo6gMj2tboyn4/SXX4PvTc=;
 b=xCKtx2VX031rCj/23rR5WIQSOwFOAiOJTmtZfnS4f0WKw0EtS/6WGCQ6BxfyJQpbRhA7IdPZIF96ikMeIlxdB9YY7b95r18O9jdb8tBqxzJl8h9j7aqBVAfgbRVwBRvZ7ljMRTh/mfNQ+8blYz/OCgeDeI2ZcGsfAlaDvcgxmqpKuOLUt0rLL/kSSqNHn6PA3Qrr8qu3kbOocb1pnXLVG/QX0mEFDz8ME8DFruZeBZlLZmxpYJXTWOm73lKtnYNtQnHirInSksSPYnax2YEW8r1RCayBpeMb1PF2E6hL+Vlg67G2BtrqnYFf49r9jNRWzjT5c0g409ZPx3Cbawa7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 00:50:13 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:50:13 +0000
Date: Tue, 18 Nov 2025 18:50:05 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, Sagar Ghuge <sagar.ghuge@intel.com>,
	Stuart Summers <stuart.summers@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Message-ID: <q6xbaysjemijasgw5gddu227du2h4smaslqjsyg2vvaetn7yjk@iu77svwmmsmq>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
 <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
 <lc3rxncpictivozzuecf5z2kfprsmkjk35vd2djlofppfa33jq@hdvuteq3wkvc>
 <cb23a8cb-937b-43d7-85a8-68a60c98e0a4@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb23a8cb-937b-43d7-85a8-68a60c98e0a4@intel.com>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH8PR11MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: a15b7cec-e0b0-402a-5467-08de27059935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2A3Me7SHi2D7SVtRsumf3NncDYnNG3YXqAloxssTw3h4MHLlcl+e8i6yb8?=
 =?iso-8859-1?Q?WxNqFFzBMs4ncVYLb0U9yfrQgXlnSfEmKKrLx8jVqHVXmUryDzYOXx7i95?=
 =?iso-8859-1?Q?s3uR5vBGuyvEcrhcbgkf+wVA7iSD84N+4joz3T6hCEKu3RvSGF4jGu3Zpj?=
 =?iso-8859-1?Q?ZJ3JJ0m+1W1Ps1XNpy8JhjYe/Rxg0eHAnyA4IeTsZIUkURjk06kW/2BwZA?=
 =?iso-8859-1?Q?XY/04LFk3rc2ZPiVukvK/5Gzr7NUAyycnRytE6yPdNwYlXrABa9CchYvOA?=
 =?iso-8859-1?Q?YQ8aU8abwAZ8HGCfHOkALm+PIPsZhH8tqJYgHfufWTdREZ2R7/RIeXa4WC?=
 =?iso-8859-1?Q?TlI+zNMlgYfYKp3OcHyLlZjwe1gJ1HflekhpO0DMhBmpRkgUns1yjFaGnd?=
 =?iso-8859-1?Q?qoIxfhNA9HeFRjvz/DwHDGFlR58Wb2B0q/xnqUsslkcbiF9IdapQ0vLQOC?=
 =?iso-8859-1?Q?Uk2NY3DA7TiEnYXW8lVwqgtbJ+GdEW7WFf8A3tdOYvw4F//cWf4WLYs22Y?=
 =?iso-8859-1?Q?0CI3OExgT/5YD7Teujqd+97u66+pCOQSlRCsZOMQwGh8zh5IGyjlq/wcuF?=
 =?iso-8859-1?Q?QKjN50ch9T9zfCfXAmLDrWriMW+hBMubE0DhsZKFoxFIFrnH7FZ1nI9bzP?=
 =?iso-8859-1?Q?7foccxflPxflb/fX8yUiPbgErrMyEd9nJZZJ8JHaHStnQzV/R2tJ1AI2Be?=
 =?iso-8859-1?Q?/Ap0PZWHbJJ1oGVKa4KAqRtAnbE56OloYs5Em80cto0s1DhiJrekUs7WEN?=
 =?iso-8859-1?Q?m0GGRnedwBPmV4mtn2INMfW+iTDq8WJOmOpi3sYfFoUnCtTQwsK2NlYkin?=
 =?iso-8859-1?Q?GYSyKbM5yXFU0z9vXHKPr3TspLIBiBatLD/na+hlJqOYLV+P6BpeFND3dY?=
 =?iso-8859-1?Q?nXgUt2iyQXgaTCG60afcGFLVtb2y13xbVQtb1hXrzkLqfbT21fSbBvZmNf?=
 =?iso-8859-1?Q?l27MWo/d7OSI7lgnDU00J9R5sHfpPSDvfL10+41aqEWcXfdxFaLvK55HPD?=
 =?iso-8859-1?Q?Ge2pALznrAU8d/JIytZEKfNvrZ61lsXPLxk2+quMw1njb9Xct2YcgisE13?=
 =?iso-8859-1?Q?REx0T7lv/Gfc2Z4wgOpoDinOxnr/LUZIBy1KHLmaa2Q1ZwoeQ8EOKhzxMa?=
 =?iso-8859-1?Q?g9IygHKF7esqWCwm0hFufliRei8xhS3KS8YHTCja9iGaR45+Gy4PyG7gZi?=
 =?iso-8859-1?Q?oJiHdhCM4+hW25kKiFyyejRqM3YuTMJqOBHuQP+QszuYha/EcbYYbERvah?=
 =?iso-8859-1?Q?TqwhHkmPuG2z7a3vgTEMiksfCG8c/5xePkssPdBC6GMjwWbonY9djItIGs?=
 =?iso-8859-1?Q?WCRTHbGs79HegcK3LMayvXhdq1sDuI58bISHGRJWJy81Rc4ysvObjwH7OL?=
 =?iso-8859-1?Q?7oN2KyfDjP0cdtbmE2Dko41lW9vp1NcxFokB6Mkiy5fcc0nEuJpFTLmYNd?=
 =?iso-8859-1?Q?Tdk/YLFuvb5Xp4OyDm8K1Wu8QEhmlWenwe6qrsKAnhRGPBXk1D22qPg/dN?=
 =?iso-8859-1?Q?nEPnDeJMpv/MgCcjKSDnbD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W+ntnAnYRyBEyRhL9lYO0cf1rmRvf1bbmLX+Y3iYZHQnlQhIA6D99/Ly2U?=
 =?iso-8859-1?Q?y/wjS8X2aPTEFHyyVPv49armEAPoJ1VvlzPNG4zpalXmK2RjJTtj1S90Zo?=
 =?iso-8859-1?Q?2Am8e8yK7Z75oe7ysbF9nWquGNfdrlkPnoX05pVa2ksHmWPZULG4wmXXrN?=
 =?iso-8859-1?Q?UM9WEQf2/+EjIyJWmZGB3FpFh6beXodfIFFPmjh3QSiFDyx5MPFCe0Ihui?=
 =?iso-8859-1?Q?RO4PGdeVV9KlpiK8SUZ+ULH+B+IiIZl2kWJ+0EcpiEQ0wu4YsOTb+8jAuT?=
 =?iso-8859-1?Q?xTcGXQx/YC8FtQvACQql46wZ0vlpZlUUFoYus6/GSmF5ztNB2Lu83CgJSy?=
 =?iso-8859-1?Q?D2F3edVkxyoO02SVD7CiZHbBC4uzlBKwWLwLqbpW+tozvdROnEHH+oM7ac?=
 =?iso-8859-1?Q?rciBcdFlAv0RV77SKiRgPwlRSNmQv/mWAGO8qk8ed/FSv2e2ejlGWRxAuw?=
 =?iso-8859-1?Q?KcbYF/Y2JOJtquns7eho48w3aeRcS16MMMth2MMfiREgHR7aZEmEMfWQ14?=
 =?iso-8859-1?Q?FX0P4jT7ZOOx4kEJnLSZ6tyXgiz8SPrjKhKFPzHreSVLywWFveHvekLdWe?=
 =?iso-8859-1?Q?TXOE/Af97k7taoFxGhE8u7X3c6PGx/hkJFZEGFo0SUrcAVN/972Ckuh0Qo?=
 =?iso-8859-1?Q?n60xEaF1/mlWmK6y5LVGVysBV6Ve9NmcUWIvTRyrlbEZPGcXNCoA/AeQMG?=
 =?iso-8859-1?Q?BBSsy8nbGOdaU8B3mytzTAhF2ZJjI0eeVUBjSIDMKrm5upxwds3nmcA5PX?=
 =?iso-8859-1?Q?5C8ftO+ds+EYLyrKw1B1LsbKYurCB9DPdN+DO7dr3DHDwX2qDwC5yIh4yw?=
 =?iso-8859-1?Q?cbZqvf/mkVPJWqxI+J+gIyBai+1GVcJiHMFCqPDH8Eg/QhzTWEddRn+B3l?=
 =?iso-8859-1?Q?bPZXIricdsj3P5w1I3bR2k3/BdFFFCB4dgyNU07qTif1rpAveeucH9XG7Y?=
 =?iso-8859-1?Q?jc0tHLyKBOpiM/NKJC8jdM4ArsGWUucK/PJzmqLCcQNo5gCIz0PigDHY0D?=
 =?iso-8859-1?Q?wlXHwkgwLoBZ8TW/2FrJ5o/I/+oeRe3GoU03bwcL9KVP/U12H+oeCaB7ng?=
 =?iso-8859-1?Q?En6buNo/9yTVF777Ij2wuchHVsd8f5OszSCoKIOevuP5v3aepToFSXWVpM?=
 =?iso-8859-1?Q?QTwKdHBR+Gyqohi/FgLgnmdalBMQayrelHbkgmhybrZvsy8OhYZZUzJonE?=
 =?iso-8859-1?Q?9xepUIWzQ2jK4T0Ap9kL1iff57n217EeK8zz3Q7PWs85rCT0/KuYspXjbA?=
 =?iso-8859-1?Q?33jrLIqvHB5EtUHQXsRsxc9KKLn65j4zEcFmggTkx+Qrq4PcO84hn0udfB?=
 =?iso-8859-1?Q?ly1+/DU2NYrGE7qj0qkmarSO8W2UWXA/fxqaSZNwqOrUtcgtwiM6Eecsvp?=
 =?iso-8859-1?Q?WZId0hQ7wTCsJzwj+9wyONM5d/A2+Gk+04IjPhM9Sq+1Lq9iUSoeXWaxdC?=
 =?iso-8859-1?Q?wjd/Vc0VAG/UhkHgGZqEy+FeM7MVP4XXWDztiIxj3rjaNbN2ryalry26a3?=
 =?iso-8859-1?Q?RVacT8AulVbP1MZU4zNnES7uunMpMbIVu3yNeEBL75nb+tMICbtQKAf2XA?=
 =?iso-8859-1?Q?TRCu30whmSmvHfQoD2RDOz5V1s+qT8HEsln+dhRbiyXRQPO6yhW9utzmij?=
 =?iso-8859-1?Q?exP7s7pGtQ0/hfyTgGwe6pHF91Hu8umewqDhZ5uK/PdPyYtwLKsGcmHQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b7cec-e0b0-402a-5467-08de27059935
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:50:13.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRfq/pFuRfzH0FZE9nPHPI2Yhi5GtI5c5hTIyNtCYthd2z4BG7EhMAQ514PYRbueE86hGUub3g4k7YokdMUqpLoqyw3SMwJy7MGfursuxMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 09:09:58PM +0100, Michal Wajdeczko wrote:
>
>
>On 11/18/2025 8:50 PM, Lucas De Marchi wrote:
>> On Tue, Nov 18, 2025 at 08:29:09PM +0100, Michal Wajdeczko wrote:
>>>
>>>
>>> On 11/18/2025 8:08 PM, Lucas De Marchi wrote:
>>>> Add missing stack_depot_init() call when CONFIG_DRM_XE_DEBUG_GUC is
>>>> enabled to fix the following call stack:
>>>>
>>>>     [] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>     [] Workqueue:  drm_sched_run_job_work [gpu_sched]
>>>>     [] RIP: 0010:stack_depot_save_flags+0x172/0x870
>>>>     [] Call Trace:
>>>>     []  <TASK>
>>>>     []  fast_req_track+0x58/0xb0 [xe]
>>>>
>>>> Fixes: 16b7e65d299d ("drm/xe/guc: Track FAST_REQ H2Gs to report where errors came from")
>>>> Tested-by: Sagar Ghuge <sagar.ghuge@intel.com>
>>>> Cc: <stable@vger.kernel.org> # v6.17+
>>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>>> ---
>>>>  drivers/gpu/drm/xe/xe_guc_ct.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>>>> index 2697d711adb2b..07ae0d601910e 100644
>>>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>>>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>>>> @@ -236,6 +236,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
>>>>  #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
>>>>      spin_lock_init(&ct->dead.lock);
>>>>      INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
>>>> +#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
>>>> +    stack_depot_init();
>>>> +#endif
>>>
>>> shouldn't we just update our Kconfig by adding in DRM_XE_DEBUG_GUC
>>>
>>>     select STACKDEPOT_ALWAYS_INIT
>>
>> didn't know about that, thanks.... but that doesn't seem suitable for a
>> something that will be a module that may or may not get loaded depending
>> on hw configuration.
>
>true in general, but here we need stackdepot for the DEBUG_GUC which likely will
>selected only by someone who already has the right platform and plans to load the xe

conversely, if we have DRM_XE_DEBUG_GUC set there's no downside in
calling stack_depot_init(). Any performance penalty argument is gone
by "you are using DRM_XE_DEBUG_GUC".

$ git grep "select STACKDEPOT_ALWAYS_INIT"
lib/Kconfig.kasan:      select STACKDEPOT_ALWAYS_INIT
lib/Kconfig.kmsan:      select STACKDEPOT_ALWAYS_INIT
mm/Kconfig.debug:       select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
mm/Kconfig.debug:       select STACKDEPOT_ALWAYS_INIT if !DEBUG_KMEMLEAK_DEFAULT_OFF

The only users right now of STACKDEPOT_ALWAYS_INIT make sense as they
are core ones. There's not a single driver using STACKDEPOT_ALWAYS_INIT.
drm and ref_tracker, on the other hand use stack_depot_init()

Lucas De Marchi

