Return-Path: <stable+bounces-6421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE57B80E6C9
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85604282B8A
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D648785;
	Tue, 12 Dec 2023 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XF0BnnDp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036DD5
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702371208; x=1733907208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ECNiAL0j7VUaH9y7uDqi/H4b4h7+amYNXB99NlS27sw=;
  b=XF0BnnDp9n37Hamsz2JmhKJltTT8ettLiTb/BTUJ12MyvTm3UldPqPeV
   d+I6iBlrrkOgDihkYrbmdUT0cGp2wyzzibyYEpkwPJh8+qQwP3rETyFWK
   EUpX8ZMPxP3mSwnddjoD4j/uiCn9vawdxCTJlw+I4pJIaff03oEgdkoP1
   HUHHZVx4ScygFToDxxbN5VNg+JN0D3y3OQ/bZC688xX19rnqrnR4t9A/T
   EG9M54HR8YcTOGHbtK4zRimfXd+x1s5keMREm/YLiR34emZ4n5ixCMvBP
   qGbYuMpGMwfZUzFKLeqIDj1oo2y9JPpKwB8kDCu/gy4NOF85A1d7C6REo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8135288"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="8135288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 00:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="14881115"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 00:53:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 00:53:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 00:53:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 00:53:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 00:53:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3mwyd930zBnYYjPcNohWvLtg0VJn4q4vewRASZuMkhgzif5MuXksLcUQbn/Bejru18Lo8mDHEvcSB8SVqEp1d+cS2G2Ue9qJ39Sy2Z90S7P7GM4Kt2qswj8H7hMu0xh0kJ/3Sc0kJMjk0emmVj/+cJvooYntFTCLK8Q+2xfreWVEXUGwIHTTB3N8tZsSGNDCuRvusNsFqWMIS9qkYBxgasKO2WOYhnfB9c85BI+QXYKwa9y4oSUiEFj1ExMge08YRFz66KZkAHfjqxBcgXnw1e5NrFxesCle+E0Yt28+6LaZllweE9DY0mmsyLdY9rJanpZsZBIHxdlVtPXDkQdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0i2n5O9AxgKc5XJtjqwuk0Rn6A8xvL9c2+JQihmBIM=;
 b=Qc2uqh1zuZX5W7TAUWEBqmfCI4wYMmqofPXQOvkKduU41vZsN/+N5eHO58jRMWLiiPRCaZf+IxDH7o9AAI6FvluhbP5H2M+/sGLwZsbg0d0slOq+jVz8YSV2SUud3OX3JAWCZiVdSTTQPf4rB1TZJ2fOm3gBqwA33YCYyKjo4MHtMEoVl+2spxiuRF/vwxHy2myIedDDpyqc7YhR3a4IMLX8RKfVCh/ifKQXu687UMOL+zzC+pB0kCfk+gu7/P4oM9dKYdzcIW2FDXMtoHuUuHnI/UoC45ovIKl4PwPFPCqzEst9v6MFujln5eQHECiztgSRbsn63jakw8GvzwlgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:53:24 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 08:53:24 +0000
Date: Tue, 12 Dec 2023 16:48:54 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Johan Hovold <johan@kernel.org>
CC: kernel test robot <lkp@intel.com>, Johan Hovold <johan+linaro@kernel.org>,
	<stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Message-ID: <ZXgedtUhbKEwtSMr@yujie-X299>
References: <20231211132608.27861-3-johan+linaro@kernel.org>
 <ZXdGxI0OrIUKrbcS@be2c62907a9b>
 <ZXdJZ6yfK0NWz_zj@hovoldconsulting.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZXdJZ6yfK0NWz_zj@hovoldconsulting.com>
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eeab935-71be-413a-1497-08dbfaefccb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vuxfGgBpXsefskYsTwP/FbHXmdQdy8p+xQSkOCR0IDOi1ymOC6QDKsi/ZGp8WfPZFFczCi4JWWzqQI6xyZ/qOEgqjzciHkaG/xGdNd/692uRXCP5213wlq7L4KMM6bLq/2h1oXLUpKWSer7EVZrhCK8Fi+Y+LMrVE0Hu+uztQizO8dPrGhTnaIP4jcOBFRQMZd86yNNfC6Pfk6Uz62PA+81LMaMjgEK9Y4JtX759+t4Pp7vVlQC/Aw1YQCMR+MI2OIboPzcv90QbLuMQmwyAzi+xAH1fjpFmBQ3ZdmhRXAofQmZ82Nn+KdMndhod0wy+H3PRAkY/BdXdBJ+W4LgiUDXARdaodw/tT3PsoK/5zAGbZ4FdVnZZ53jJ6VhY1uScKny1JZm8ZZAiILpFsDPLeD8rmbAqJD+BvNksaSoUFmIfFNkTAOl4HPB5Vd+r3J5CuJ7wAqUcTwaNhvmPiIXtHxdzbw9CyzbExjZ2/RVn0H0Wxnj5Nxai5pRagFJTRHyZnmTGXGE0Ykz6UVP8QPGB5VqE8wKMIurM3HyPO0bO5vB8Wf0874KEr4OsSriASQs5KQAhri45zmz6uzXsg58gETwUD9NB9Gto28wfdMzssFaerpIKkrlK43fzH+28cWpGaYPPD8T6qcwSGMSAlef/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(86362001)(41300700001)(54906003)(6916009)(66946007)(66476007)(66556008)(6486002)(82960400001)(966005)(6666004)(316002)(38100700002)(8676002)(8936002)(4326008)(6506007)(9686003)(6512007)(33716001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxxIx5vFunswCDs7B7eUIL7cb1YqZ9G8UJUsr0cB5LPDQP+lGOLMTFRYHa93?=
 =?us-ascii?Q?uCLjximVKDd3Bn/6snvUZ8aRiRCiJKNH2F0JceyZI4nnEhl8UasVhkbsHKEW?=
 =?us-ascii?Q?Kv0IkwJfXen7HpqHC7IFyg4t2PnNWYnuNmco5SY8GyUlH79GVc+wqilajPCe?=
 =?us-ascii?Q?2k393Mq7dQAyMWlnX4f4C9GJdYX5hvoQhMZb+tUqp8sZE8yeqMSseW71vDZC?=
 =?us-ascii?Q?zHkq9WolEY9lpjETBZF4fuZG0ymufgVIk31aWKzxWTFYXnM0bMCGGxqfe+mY?=
 =?us-ascii?Q?/S1Msbc4nAEHnhhSUyYNRBw06cY+UgkTbdcmsXbaai+bnKaVyfgatp8Bdstu?=
 =?us-ascii?Q?sTk6U9em5r62Me1nElUhALHMQ7AM1W5LJG83DCTvG+uciNGF+eV8i8YxhnqL?=
 =?us-ascii?Q?wq1ArY7L/y19PTOsF7VtrBla8gl4nohNL2ryOM3l/1P8ClfknSdtEssfj2QG?=
 =?us-ascii?Q?ki2Z9gwpeg6K85BHBEQO1sdb74Qqljbtjc/Dgkm83cWXntG9cQgkZ8tFF50h?=
 =?us-ascii?Q?draxAoxmt9uJD+kvmpI45o6lwWLhidKlWmH6nIU+DPkkrQgmlQCbwkjwbm+t?=
 =?us-ascii?Q?76T7G6vAHJ8o23AgUtBpnXznC+qDr8IQDE3iqWvgvrVTZWRWuMOdoQaDW1NK?=
 =?us-ascii?Q?2a87X1K5vkAQnQ0qWHR9oQp65wqfL/yT1vyzDzX6GsSX4o9uhMRO3AXu/dXz?=
 =?us-ascii?Q?rnsAYLxyFBzlgIKXfNFyo7HfpKMocBpKuNuMQ7YJ4pIGi2WjawRhEMMqjX8C?=
 =?us-ascii?Q?i1Gs7K/+hVx7qs/Fp1vuNYwJQQwLTk201lmRsMW0W+qIFzoU24bzunOJNAof?=
 =?us-ascii?Q?hEaVK6gz6demuq7E24zj8dOBmI3AGgl7vq2+9TiSzcPEzplMc5eXm6gTnhVC?=
 =?us-ascii?Q?9MEK4HENN3dzRkcDIOCS1Udlasw3lQWj1YABq+JWoJ/fKsUIwoZ+HR0BmpGV?=
 =?us-ascii?Q?aGqh46NqI+yB0068OqPuyynelXV+NG57Oo90KOBm1Hz8+toBuOgwSywuyo2n?=
 =?us-ascii?Q?u9OyrwcHlco1NalJLUJiD4wr2aydyWf3eWrbKXcznjQ2djNPqWjWJQFuOv2/?=
 =?us-ascii?Q?0Y+2UNdoL8TWUxAsKBUb8zy3PTphB7mvW2Uk9Dado44C5Vy45iwCuM2mr8ww?=
 =?us-ascii?Q?cJ+lvhhVZ1E4FHhut27RrHIUta6wFSi14wu890ohinrhlR25OdYJlol18jj3?=
 =?us-ascii?Q?priKjnK/B1M509hdQO1aMlOMJeCMmf4/MwxKHU1u222aePjYmrL9AJqGY1lV?=
 =?us-ascii?Q?lJKY3aBSiGYvqLS4WB0Ujkj/puWOiNS+eP3lTXetYsQXQ/OgBZAQ4SOf0+Rg?=
 =?us-ascii?Q?oNcn2bxCJRJQxpJ7bOkTLH/T8EVVU87OjgNDguyUlwPA9mMTQWtRa5n7NB4y?=
 =?us-ascii?Q?8cudTc0m/FuJbKEYLlwLb5KNAtIZnsGJLKnu1oLGRm2IIYWkkN5oRRvjh3Kd?=
 =?us-ascii?Q?YnWJha89j1CyiDo6JJbR/6wzqdPBS2D3WpY+ZKDFuqE2FrT8okTxi+Inu4iC?=
 =?us-ascii?Q?j4lSjAw2ShJKwtrd5qzhkm3fMemlfoavsYL4sHsiV9f383ghx9VixH7AiJuy?=
 =?us-ascii?Q?Tze4B6HLcFRFdDnoULTBo1cKZ+PgBLP3z1YlHCkw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeab935-71be-413a-1497-08dbfaefccb8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:24.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4aeKGdFsbTZXysoaoyZDgNwpQ0ltpv/FCIQKEOGEs/yHj3PN/Hajm9nKwLUbOtPj9OEngNffht11V6LPlebqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com

On Mon, Dec 11, 2023 at 06:39:51PM +0100, Johan Hovold wrote:
> On Tue, Dec 12, 2023 at 01:28:36AM +0800, kernel test robot wrote:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > 
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
                   ^

> > Link: https://lore.kernel.org/stable/20231211132608.27861-3-johan%2Blinaro%40kernel.org
> 
> Please fix your robot. This is a series of stable kernel backports so
> the above warning makes no sense.

Sorry for this wrong report. We introduced b4 tool into the robot
recently to help simplify patch processing, but seems that b4
automatically removed the "stable-6.6" prefix in the patch subject when
grabbing the mail thread, and triggered this wrong report. We've fixed
this issue for the bot just now.

$ b4 am https://lore.kernel.org/all/20231211132608.27861-3-johan+linaro@kernel.org/
Cover: ./20231211_johan_linaro_asoc_qcom_sc8280xp_limit_speaker_digital_volumes.cover
 Link: https://lore.kernel.org/r/20231211132608.27861-1-johan+linaro@kernel.org
 Base: not specified
       git am ./20231211_johan_linaro_asoc_qcom_sc8280xp_limit_speaker_digital_volumes.mbx

$ grep -h ^Subject *johan_linaro*
Subject: [PATCH 0/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Subject: [PATCH 1/2] ASoC: ops: add correct range check for limiting volume
Subject: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes

Best Regards,
Yujie

