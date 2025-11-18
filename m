Return-Path: <stable+bounces-195129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECDC6B7DF
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 522B02B3BB
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75CBA3D;
	Tue, 18 Nov 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6BxkDNQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA382DF717
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495497; cv=fail; b=Hk7OPdcZ7T5dwbRHGGn5RVvr7srjtjXC1nmvfcLjUIh3k48ZNC63GjyE0c0zWgFQQj3CPWHEoAUYPHS0/HSJgShrDjdw2B3pja+sqju1O0sZAxQGew9SQpnWmX2i3YTOj5sYv3O23zyt1B3ce5Pitrw6pLpgn3/eiOzAh0z8wdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495497; c=relaxed/simple;
	bh=e0r98l86853bvcrMFVclJB8ZvTeleThh8OWD3Hv/F+U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JmaVdBMJEWo5dxafaLlHzymhcQWCzvaBvUwrNAt2AMZpJDKDbiJo65+hThIYMiZHC6DZUeHslA+LCRLn4I70ydH7BwXbCCMif+on4xtw24FwQMrKluVJBfQDtXcN7CkSfbegl/NY2jZTXlu/lAvgDm53wc/XIrmzRJwIJOrDgW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6BxkDNQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763495496; x=1795031496;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e0r98l86853bvcrMFVclJB8ZvTeleThh8OWD3Hv/F+U=;
  b=I6BxkDNQk7E9KGkJCKfGemEZ1VxGrnk89/V/YQqKWSDdhTrqSEsWcJDu
   L9l0XW75w0+VHnDV9PnOqe5tP0l0GNDrmhPH/IKazoVdNcNO2KolqvSZy
   ZGjyajvijvusOGBgDUkpMCKh2lWvsE7RCLsVLbv4DbA2nRlLMx3so8BX5
   gpJ2DZin69rJ7FrXTdehaJfRbplb4KvrwfjgYSKHQ4HXU04s5CjkpRk/A
   bbmWQid9xadLZJwXRGjOiS7OHcfblbs28+6lhWSWDRzVRd8fjnJldlwPg
   5F2W2p7wg11Q4XgA1b1ZUv6i7aQAp66hkuxpcU2FsKOi/PbyNj5hT0/UX
   Q==;
X-CSE-ConnectionGUID: bIzx9lWrQ9aBCfUMMkoL7A==
X-CSE-MsgGUID: VRQGKw6STVSu1MDAK0+C0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76139202"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76139202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:50:49 -0800
X-CSE-ConnectionGUID: 1CAuxpJcQvO4octk76InvA==
X-CSE-MsgGUID: 7fCcC1mAQs+MPrpe7RMLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190104687"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:50:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 11:50:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 11:50:48 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 11:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAcAfCS2V2KJsDmL6XXgNaH35GmKUru+vVrjVtEiUySGSQzMTvxsuzLABSlN8WunNqimHmK+3inhSKQRYCIBEy7X60vIJHIIIoaU0mq4jz5kMqa9OrjN5Z07hLBE7vq4rSsPOHCU1xx7cm6EbmtMeg+blCDuTABzAejinZEqg/nfExRL/+Su/OBBBTuI2lEBheYd8SPOhFfX3SICBEYVp3YNFMMxk4mvic/IpcAjteGr0jG5y27MRio2V27BFrKmtUNIWHmCKWZzMOH/Loee8jbP9zhUwdvSNkjIpp5WsGEepSE09Sdys9BN/cYZt4V2E6dFaHjujZcf3ijmEwdS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsPnTozqHNqFxxEvODHJiQket4NFbIVz0KM56arx9Qk=;
 b=M0kSIKuwELFPszO+4FEmoe0J1TAnG/M3IRKl0q3Hq/ddYq84PabywpwsFY6RVX0MVon7HjfPJVqbs3JcV+o4gmbvc5mVpWo+hFcdJuifiQHdCxMsmpBnZEnYSeJfkClRLfL3PthcW3uA1J9qac95Uwq0NziPOnvzPT4O7evaWHrdot25fltVFuY2yMCFRjcBpUgASiK35gRpD70DFs95pbmIqMfrw9zsDI4n0bkoDkOso0L9rnEt030X7W2TDIVcgbBYwDprzu4lctjlyRxXdUPSRqZCvLLck4CLCc5853J4N5rB0TN4mr60reeVc9madwuZI+UOw9sqJKHFKAmkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 19:50:46 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:50:46 +0000
Date: Tue, 18 Nov 2025 13:50:42 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, Sagar Ghuge <sagar.ghuge@intel.com>,
	Stuart Summers <stuart.summers@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Message-ID: <lc3rxncpictivozzuecf5z2kfprsmkjk35vd2djlofppfa33jq@hdvuteq3wkvc>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
 <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY8PR11MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e04091-cbdc-4547-4955-08de26dbc3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TTB039h3E74hjoSw0W+E1Q1qR1pvIh1XFTi8qZFwKOSFAlvGcmuXuWKuUW7?=
 =?us-ascii?Q?3iROeoU3XfbdzYr6N5Xnp3d1BZX1cqdDXK7dp8ungxfQUOGXzaQYJRr7k1Bl?=
 =?us-ascii?Q?+vBg2RPrCRIhWpU5u15SXFmr2gh4nLT1QCSBBVzwePFYhTwdyHPzKVNplcNw?=
 =?us-ascii?Q?WW8MrZn0H5wnI+sSmRMjhtsMiIt1CqmXAqmeYxwZKz373Feu8s5SWz4Keaoh?=
 =?us-ascii?Q?T+8gXcnCBAGXUlg/7KdIt7I4+i9eRVry1f/0fZ1zG/Sz/iOZ4SIzs1idXkNl?=
 =?us-ascii?Q?TqyQBNCB1ZQD8r3HPJJSVrGeuC33fZuAY81dzjLteNuR0UozDIn0E4f4GTWl?=
 =?us-ascii?Q?aSmstJhfC32MaNB2yHIuCuYIAYfnBHM1cmvGKO0nQ8Olw18Z8DcZSSbWmGlF?=
 =?us-ascii?Q?QVnWApgSwVeW0OqkMFiRUmZR4NOmFbpjDf3ScEq1KuCVlsJ1qtUAoPD+QS2c?=
 =?us-ascii?Q?NhTqq2U7gebV68KMPykbzm9obZ0jroZjAiSVcXIP8696f+jHM+sRsHrmF8o6?=
 =?us-ascii?Q?taVhipxciGctDp5OAqdLBhF63RbEoh6z1aY4YB/8PvMTJnMZ6bKRFKfLyJP7?=
 =?us-ascii?Q?I5Q9pDfBB1zaqkqUNU3FasvdKZaoy8/Tiv3j2j4IVycyXjsSF1Ycii+HoHxS?=
 =?us-ascii?Q?3uOmbhoaLHm8Y+6iD4xad/roEBOXpDg5IxQ1iVKZfIobxNHN9SyrBPfrJHi0?=
 =?us-ascii?Q?GPyiZtIl3cJ70pHS8Gzl1AsRk5gN6qZ1mjuCy/SmQ5m7cqWB1EuKYo4+n02K?=
 =?us-ascii?Q?DaElXNemToGOfHqJZ23oRIzX2y1sq7pvf7s7Z/qvyIu4QexIeQpekk48vfII?=
 =?us-ascii?Q?tEjdFU3vUhT+m0OXExxXZbHgj6gxV/0dJx9OdwTEQOUEv+rA6UfJceCwKqOy?=
 =?us-ascii?Q?57THRkFWAlmbmcsO+pXWsr5r2P3hDpDFJl8qfTXe6AEJqg0lmCGYLw8CAiRr?=
 =?us-ascii?Q?EAlCkzq6iO5+uQkDPZDWi8PK6iTdUzfk31apso1m8+0xGWuP4ilPYDCNPqwn?=
 =?us-ascii?Q?l3x59ZRP1O0sZTorZk+ABqrdLdmLt4mGIDfFRtT/fcF6rAV6Anh9QyamX/gf?=
 =?us-ascii?Q?y1cVaF9ZP2w8/uaHB3z1v6MWybQnBNDfg6/Euon14lnE6VU2IE7JmIhYrzvb?=
 =?us-ascii?Q?wfoSIOu6p7P5Kr3cwEXl1yf/dqEpoJ+mYZBI0ks1iKd07+zZiLImHe5TGs02?=
 =?us-ascii?Q?1XkkNMACIRn1GXrUHm/UqrtjWlF67+Gaef4gAoerHT0oj9xVV90ZOCQE5C++?=
 =?us-ascii?Q?gQO1Fb1NZPkaBzoxZ6gSE00NYc7XVQWlqw+VlI5xN/9H0hf8Uv8taMZrPVNe?=
 =?us-ascii?Q?feqt2l0RU1UODDgn1Fz5yQzxPbGCppN6u3dOyDroIT2XJOpNkM1NEyDJHVQ8?=
 =?us-ascii?Q?T6muNaMwjs66k+QsGV2Ct8Idmuv6mwymgpILbMb3VIRmqrWiuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uW0NMuFahFzxfYCaGgAr6Fh/N8OGK0Zx+YjEwhIBMdN8AipwYHE1Sx28Ei9W?=
 =?us-ascii?Q?8O8DOaj7fHNQ/+6D9qhQs/Fv8cDAJS16I0kg+y6hvJXHdKQYuhvCOUBBIKL/?=
 =?us-ascii?Q?uoRuMRpbVOuvEgrAGYs1pwGFgRJu6zky/+1P8isi1AdxyIR14oPCBENvncHo?=
 =?us-ascii?Q?kON/7wDH051AtKnIuVLh+9iI/auNAmQKwGwI1TsQMCD51rosSS8mN9+h4vie?=
 =?us-ascii?Q?G2U3ANd3Mq9vISs0NDhNwGGAzSegc3yFNPLxEPIENe7exAxbFiylZ9uE5utW?=
 =?us-ascii?Q?oHTumRy/Amhyyc2ED2ufSfcfLvlqaEPDyKEpC8Cit+KtgDsocpqq/9sAGS+1?=
 =?us-ascii?Q?sEpiUaHuTSR+ODNjkTVXaI4UKeSBE+yfSLyi+Xdupw9l9vb91BQuwhaYyMm4?=
 =?us-ascii?Q?NRKgL83mhhJP7SH34cvYX1XdS2NiyIfJ8Qj5elMlxmaCpVfS4ToEYKkdeSUs?=
 =?us-ascii?Q?WDakSbfxt2cgsyaBDRb+6YlpHmAaIeITGmzzl7HuJMynlfrDb358U5KqioCg?=
 =?us-ascii?Q?hzRmY1FBwACjwRdRhr5x/DndABR0Adx5cgkowwMZR6TzhVPH8+fFbndmB7hM?=
 =?us-ascii?Q?7sd28pTQq6OTvZ2/kE79azhINkR5U4pm6mwwGXRTg7dk7taedw44D0244JH0?=
 =?us-ascii?Q?kEyiHbuu9EwK/RdGYPEmw1Ay9OxHvXzqWhsfdy921u0OFAUKYKhb/qGhxdK9?=
 =?us-ascii?Q?nUpdQBt8p/ELdOQ8C37s91uHQop9gA3zAXrkuwcFtvfC5Q64O88p4dV2sJc6?=
 =?us-ascii?Q?gANLLXdk5qwvu4pTsI4H4tQ0JuxW3WGdPv2Y/gub5Tq6kK0HA+461VyUH+3p?=
 =?us-ascii?Q?ArpocbmvH3RmIG9b9PHBlK5ufKo3Gdyxj/vybMZTIUQ6opbGJWmKEXM2uxoY?=
 =?us-ascii?Q?iRSmoMAt3sB0ria8NIeRbKtdSh57fo8ocRyKozQNjjKw74CxEhSzRnF3pquK?=
 =?us-ascii?Q?C/Cr22GcvqiqRwDRnbE0oJb8hS3rG41qp7Y8hSoutvLVDQUq77AQsxWEhBlB?=
 =?us-ascii?Q?51cN+eeoo8tHQigln9oh1xGevtKyiyUQ1wIlCijXQ8Se/dTueTAs21s4aYcr?=
 =?us-ascii?Q?Ey77XnIIkqZT+0SDvnIZLdxPM4DtgFGg8VgYKrTJTW2NGuwJxfjjC8eXt3HD?=
 =?us-ascii?Q?r6JS18+n8wct1Q0XPHQjnKxSAFPpPWcRyhVPsAewhc48L/jSlyx/c69Yhjh1?=
 =?us-ascii?Q?d0xKfUwjTATpal3CeuBisVKErdQtod8Rs72DN1/jQPZyGLs7V0uei/M+X31M?=
 =?us-ascii?Q?X1x/AVP9uol/s/c5pJEYUTgL87haHqKW/LaTxL4BKrXpi41MgIVqA1xlXJA8?=
 =?us-ascii?Q?H0QqjBcsRcSbzYFbqKN77XMUsTUuet95LCRgaVCcw/46OacXhNi5dq7AExHC?=
 =?us-ascii?Q?D03/SD+DiPFSwPQvmijZQFkt+vECIQ/h8xy9/AgzD3VEzLsfAkSHN1Nk3xJx?=
 =?us-ascii?Q?CvyhFvt9s2wFl9wpstQZjEOlxMNQ678aeEi9SqeId9WZsKYugRM6AX2zHL8I?=
 =?us-ascii?Q?UiBulxD4aRwOCWDTL7e3RDEeoMx5fJx4TuV4BN3Nq7Exeb2OmsQr23dkbREi?=
 =?us-ascii?Q?VURwQpRhOyXwQCP9NVtFmBCU8r+quhMhMoF0C0Qgr4XkFWPUvX22/OFYajxr?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e04091-cbdc-4547-4955-08de26dbc3d6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:50:46.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjDAtDffcYJoqq6n49oPzrpY25s3uQQf4BgoxpqDfUIqTOuWrozFHIuJ3GNC9Hvqp0RseWZKcaQIJqurbrAEN3CvmnsbypJvcBqCa1zIZ2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 08:29:09PM +0100, Michal Wajdeczko wrote:
>
>
>On 11/18/2025 8:08 PM, Lucas De Marchi wrote:
>> Add missing stack_depot_init() call when CONFIG_DRM_XE_DEBUG_GUC is
>> enabled to fix the following call stack:
>>
>> 	[] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> 	[] Workqueue:  drm_sched_run_job_work [gpu_sched]
>> 	[] RIP: 0010:stack_depot_save_flags+0x172/0x870
>> 	[] Call Trace:
>> 	[]  <TASK>
>> 	[]  fast_req_track+0x58/0xb0 [xe]
>>
>> Fixes: 16b7e65d299d ("drm/xe/guc: Track FAST_REQ H2Gs to report where errors came from")
>> Tested-by: Sagar Ghuge <sagar.ghuge@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.17+
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  drivers/gpu/drm/xe/xe_guc_ct.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>> index 2697d711adb2b..07ae0d601910e 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>> @@ -236,6 +236,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
>>  #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
>>  	spin_lock_init(&ct->dead.lock);
>>  	INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
>> +#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
>> +	stack_depot_init();
>> +#endif
>
>shouldn't we just update our Kconfig by adding in DRM_XE_DEBUG_GUC
>
>	select STACKDEPOT_ALWAYS_INIT

didn't know about that, thanks.... but that doesn't seem suitable for a
something that will be a module that may or may not get loaded depending
on hw configuration.

Indeed, the option 3 says:

	3. Calling stack_depot_init(). Possible after boot is complete. This option
	   is recommended for modules initialized later in the boot process, after
	   mm_init() completes.

So I think it's preferred to do what we are doing here.

Lucas De Marchi

>
>it's the first option listed in [1]
>
>[1] https://elixir.bootlin.com/linux/v6.18-rc6/source/include/linux/stackdepot.h#L94
>
>>  #endif
>>  	init_waitqueue_head(&ct->wq);
>>  	init_waitqueue_head(&ct->g2h_fence_wq);
>>
>

