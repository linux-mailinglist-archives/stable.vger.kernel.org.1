Return-Path: <stable+bounces-45638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16958CCE25
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7961F2134E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C93E13CABF;
	Thu, 23 May 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApMKsh+c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EC51016
	for <stable@vger.kernel.org>; Thu, 23 May 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452681; cv=fail; b=dDz3/TKS00DJXXVsAmo9vklWb5HriSi8CdULi1WeAFbCMXdLSAUKsMwNrXXrj9h8AFHfTi9GjA+aaeZ53aX/6IEyxrMBxtRUfTw7ICRR8IQd/weh8gtPhjNJqcdvJtLnw+IozuGdmjdBW3brofgRt6x9mvOJMedxSOzhdWFsLv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452681; c=relaxed/simple;
	bh=1GCF53pMln03iAGjiI1Bn42n2dRR3UBqzZb11OaUNwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxbiE9W0yf1PTrlwQ2KJerugQyLLScgteXLx06BR+KWL+uDgAmXEbtqNztlknNukZK0hxw/vUQEf9QnOqEe89IY1+SaAJma524BG7iBMFqdOzzh3Os4Sy1cSZIqPQIFHWs5bqRzNktgiB9HYfxN5yOMFwLAEB9o61O5npuQ0NR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApMKsh+c; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716452680; x=1747988680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1GCF53pMln03iAGjiI1Bn42n2dRR3UBqzZb11OaUNwM=;
  b=ApMKsh+cry7rr90NILWrbN7QB6HJjUmKrRJtws6e+cFHEY1qYX2VGzxe
   se77BxFuc80cgiF3Gms719KIUrm1WCbVvS2ekbjXOmdT4vxpxtMHNfxfl
   uVNYFlDZRLmdlivYDFY+A2aj+aa0vQ8WSdf+duNXSVSVNVBXrryXz1lOf
   dFWF1R7zaFCCQ79khly7nA9HexlNSjOjoQtgKlb48DzcBpukhdrIeF2aE
   GtsVC3M+0ZIwK4d102i91vHvGUVSC3AMhgU0Lan63OC1djJjXOKQCXA3I
   4YYlfrrGIw6AXP2M+dFaOLIBwo5h1ETxDRmLfzPuWiryXRLePSNDs/rU1
   A==;
X-CSE-ConnectionGUID: UOtGPdJQTkWNemV2jlDZeA==
X-CSE-MsgGUID: OtuLz6N6SnWbCnuCSig2Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="35264757"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="35264757"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 01:24:38 -0700
X-CSE-ConnectionGUID: sckBQaj6QGmrA5EUes6erA==
X-CSE-MsgGUID: 0zCY1eNGQX2NPTCdsE/ZVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38367718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 01:24:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:24:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:24:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:24:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsNZ0boagil9vYWWla5Td/FSyt6Jv5PAYDGLQW4J6sw1q/DscXDXL/JrKkoVlmG1d/fUlTXTE821OY8evgCNoRu7zG0bj+vcbP+tE1mhYoHFTXUtT5Y0GQ+Y1CMRRcLwCEVqCcUbvJrdMRSrDB+TEvwpTXBQFDeJ33vSrzoPzN4x2M2pWw71DV3EpCNArVQBc7mqdHrTw3ELZZ4LuBYxZYDBR0grE4tCvI+/PsqEAFmAqXXDS/vHwHC7i6B36L4NHaVoNoflYO9z9tPdsjKPYx5cTs5xFXHBZD9maFH45P3dia+/7MKXVLPNChsEFWhv8I9p8UgHM0/sPEjyQhp1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydxzvR+oPqK1HmNSrq+gVjnR1hTU7Qw3j7y/AtYI8ac=;
 b=JgxsuHrIzUkZP9OPwz2eEhsVi5rWf6X3lwDHRLv8nLQs3RjsV9Pd2VzOJnjsNKpKkMsWUMR/sJ/Zv7D9BbRQCS/iSLNahIgm1W5W54yYv4dcJYS1tthIUoykaxoM5HI4yItzkMCQn9/U5/n7Jl83AMFfVOpwzytnJNgsTtOhxCwaEh5C4cJvBK8T+wE6ZoiP5NCtpcfhqLpJvbuXXxRpmsHL4g5Ckfvae5cz+hCbccCgu0/u54Kam982TzKSosy16h96atIIqcvFyyldtt9ZvSGX6cRMKdX1MtStijCIll+gB+VhLJHjMZsPWK+N1MDBXoOaWsxeteYNV7sbbbSElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 08:24:31 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:24:31 +0000
Date: Thu, 23 May 2024 16:16:12 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: kernel test robot <lkp@intel.com>, Gautam Menghani <gautam@linux.ibm.com>,
	<stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding DPDES
 support
Message-ID: <Zk77TDyJ1nqlnZ+B@yujie-X299>
References: <Zk2tjEcFtINQhCag@9ce27862b6d0>
 <87msoh2shc.fsf@mail.lhotse>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87msoh2shc.fsf@mail.lhotse>
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CYXPR11MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b87ac9-4e0b-4e79-4307-08dc7b01c572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fy3fHdLTGpivVSZMmKWzVhPr+8N02OmInQFlFzI1cxXj7iGz9anGS9m0iR+v?=
 =?us-ascii?Q?QZmpB44Zv5lGcPycZCt6SKqU9oL1ak/JdLb8dofvl/dEbizuUq0vVndwdVKh?=
 =?us-ascii?Q?hhX/bGTAzwsYDLM4HV25kJv0hEdlRRR5akoFMVzUzRZC9BZTN8b29r8q0y1y?=
 =?us-ascii?Q?AT2bxpjXPFWKX2utdItIvmYYv5SCqINq0/uH2TTZ1OM1PGLhAxIH3DogXCFY?=
 =?us-ascii?Q?8F+GO3wUd3hoeQWei0bzxJK76UIocuFdVVgVkx6XuJdlgIi9BMmxOUilvIcl?=
 =?us-ascii?Q?YjVKPO5PWLRV1Xyy6wVrVidYtijs6QbTX42PN50qWEW4JREVHDZcYW1SnsdP?=
 =?us-ascii?Q?QMI+VF10nPIAP10LXVEsZ+2oh0n5qBUguxI3EgRJQW/XS7gR+zY3/lIc6vLV?=
 =?us-ascii?Q?/XQRyoHlOg6NvDnq7yJ5CYyNyFsQ8B9WUeiAJYfXcdZWLtsz+/V9ql2Kd2sj?=
 =?us-ascii?Q?S6/LGE8tfxdeoPXFw+qlYT1/nN3H1DT9WPf5/lhlHC6zfP+RWE1kPosl3+uz?=
 =?us-ascii?Q?Um53/J61Tk12rbO7XWPC2zfeoHGzdom25Q4mS0SnCvJd+5c+ietkleDgOry5?=
 =?us-ascii?Q?TKdCzGrJbyA7agLCIbPGe01l3uh/79HxxodGGuD0Cc38r0K438K1AEqQTU3C?=
 =?us-ascii?Q?UWYt7KDFtQhCseBn091gnGqeo8CA+EXpfiZXFvLxhw9RDmlXYk/mSekZ3ZIv?=
 =?us-ascii?Q?qdxrPD6TGyVpOJzbdWn7XjYmvX9BRygueRwHHEpqbuaGXuItSYP0qYxNwnhW?=
 =?us-ascii?Q?ts13sLnIEHxoz0xu3iJOknOTYwQOJGsGhMF4hSeGYYsh9y0wJZ6JqgYKDdS7?=
 =?us-ascii?Q?LzbZzlRDlICiVCRkEIYkbUILPGYZlkQbDgLYWl2Ejc3u90o1w9lYixRA/f0g?=
 =?us-ascii?Q?W4nXDbKpfLIR+lZkfeSAo4UXt7ZPXmPaJ5yqOfNCI7UbLqSw7imkHC5tte2h?=
 =?us-ascii?Q?I8Cu/iFuPGZy6RypcXZAoO3BxUQFOeQRS5oF7eh0BrsIBhWhWVskQQeMyffl?=
 =?us-ascii?Q?l8q0aN2zfT6MFTy43dmqjDJ1mXIJVYP6LXGABQW/f7hvXGcAs11/52XFscqO?=
 =?us-ascii?Q?1ZAVO1RubBmVz5A2CG9gR+47G3D2XAq1DR7Tioqgj0yi0FidR9DAGXDct6On?=
 =?us-ascii?Q?oseuTS5/6nZaPcEPPFznNociuF3nloVPSOrdluyRhuLQZUQ8YgSkdJNDsRUC?=
 =?us-ascii?Q?QUTBZW5vHkhLR30AdL2vGKamjNXAamcgSo+g52DlG9mhWqbfYUF03FBQapk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rySNFiPdOMdGNCp84Zp/HXQv69Ug7Ofcp0dDL0qOjjZwg8jjS2uvb8ZHiAlU?=
 =?us-ascii?Q?lwGUFAox5/mt8N0t2LI7M6VaTsl/KAeJeM/ybS8UsjhXHK+X/GhFOtc8NwAf?=
 =?us-ascii?Q?ydX93Wfivqo5Vngm9DkdRHheaShCK9zYMRulcgyCfIZzkB8OXxIZv5K9isWK?=
 =?us-ascii?Q?dqe//o6e3QEDa/DQDaSffipp2usGNGXM+vda8CdVOMAUiYwjPO5UTJzae/A6?=
 =?us-ascii?Q?uvi3ERjIVykJ5NQmUsxa8xOMBufwiutxv4kdSijyTVpFj/ZTVvm4oC3076dh?=
 =?us-ascii?Q?6A5zpOsJ8+3P776OSIj59OtPqAIp6YHoK848uTYvo3lJ17hdzlsE3Q1qB1Bd?=
 =?us-ascii?Q?k9yNrddH7Mzk6tTXAHS9x+uC0hpImSgmziWHFs5IcIT7zCBMGPxfVbOxcy22?=
 =?us-ascii?Q?HJCMhYIUh3br8W0MDs9xm8n/Uqv02MxF21wwYxmxmFazsjccST4lMdbmhONv?=
 =?us-ascii?Q?gkJByxWqyjI7OaYoEIwXUSHbxwusfjEbLePtgzB1KM5H0lfWvv9q4psnKNfV?=
 =?us-ascii?Q?qJymxdse4PqE1WIxfseVo6O95Z59gkzP5iWqHD6o6bLlaDqIj+/D2OvsJrgC?=
 =?us-ascii?Q?tRPdWC+vu8G6OCcpX39Dn3lqrrZtDu54tNBp+SuaNy+eS2GR1vkGJzYVTOjP?=
 =?us-ascii?Q?LbSUMhk7sK00qfwSlmEEU0ayvP8njzylU4hg8vfLGL5KprxA7myVAUbI9wJs?=
 =?us-ascii?Q?AX3r6rMQxc0/Or/0Rbme3Mbsp83pHEweCNa5P3In+NtD9tKbHeUnGWJLvoKH?=
 =?us-ascii?Q?BsfTnbqeBf+Vry5WNMXY59wetkTT1XmNrYMLwdmJ4CFvCpHorOy7sGOAxbwo?=
 =?us-ascii?Q?Rq9x02CmfBJiDje1VDQ6/JS76UQIOojaVNfLtiMHH/WsLOlOTS/PpHP+XjfU?=
 =?us-ascii?Q?63nI9UIVhfohc3/7tcV2FAcHreoHb55GhnwlfNedaM32HqnuZFP2uFcGtUbL?=
 =?us-ascii?Q?Vsl/d717ankhK3NdLNVpp0JnR7GnsmiYnJCjouyN1WBOmkRhIQvYQl7c2OBh?=
 =?us-ascii?Q?UWyvQjwvh7vJdF3+xROJ57DE6C+r5hO0beDX4nHNFX9D1eqS8ykfgT3nJL/9?=
 =?us-ascii?Q?7MzSFS//X0kH0LWKrSpMSZm4FzNzapHoQg6NJedOTumYEb1DvYSY+lYy4Pp4?=
 =?us-ascii?Q?YeA0Gr/kep0qq2jYXoZBzT1Pa5oDpnxZxXZ7NcTtYVGm0W2YuDjZI773CJYe?=
 =?us-ascii?Q?mJPDOFPH5Vtw/guqGTQbckOdkS8o+BvoO2REavVFGr1EnIWnnZNd++f9xwV0?=
 =?us-ascii?Q?zBMSMgnzNtoKpyGb1jWtoc+/NU7+jKsOIoi4StGV1gQoJOrqgOog3GlRUU6s?=
 =?us-ascii?Q?fF0xGUR1GuRPV8ENhK+4T5+C3eO4cD7SK8Usm9Iag47doVnQW7eOew6ZYQmv?=
 =?us-ascii?Q?uQyXC7S4/fMxVqSuBZ6VHxkg2gFpoGaR9XH6E+pJJB23G6uIGHJOoc/5ioyi?=
 =?us-ascii?Q?vsM+tDPaWh2TEvUl2Ie/Hl0+amYHgmMZ+Lt1iBWGHdrcxy63x/Y8ezvwJod3?=
 =?us-ascii?Q?SIYEYei8tYcuDATotJTwIK3gYpwl3tIoYq5clN/muCfkscLVdo1sZhdzAgrX?=
 =?us-ascii?Q?OwWjrPWKJpuFT6YBbrrrz8Ge4fEMEd7psxfiK8bK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b87ac9-4e0b-4e79-4307-08dc7b01c572
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:24:31.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmwALeavFRVcwfQ8+D5e0g6NXxNH/d4xMxzn4LZh6jpOYDQp1r2hNn2wlhtX+8kXGomLfvek1nDQtdmmK8obCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
X-OriginatorOrg: intel.com

On Thu, May 23, 2024 at 12:05:03PM +1000, Michael Ellerman wrote:
> kernel test robot <lkp@intel.com> writes:
> > Hi,
> >
> > Thanks for your patch.
> 
> I found this report confusing.
> 
> It seems like it's saying a patch with "Fixes: ..." *must* include a
> "Cc: stable" tag, but that is wrong, it's up to the developer to decide.

We actually wish to notify that to have a patch automatically picked up
for stable inclusion, it should add a "CC: stable" tag, regardless of
whether it is a "Fixes:" patch or not.

Sorry for any confusion. We will consider improving the wording.

Thanks,
Yujie

> 
> What it's trying to say is that the patch was Cc'ed via mail to
> stable@vger.kernel.org and that is not the correct way to request stable
> inclusion.
> 
> So can I suggest the report begins with something like:
> 
>   Your patch was Cc'ed via mail to stable@vger.kernel.org but that is
>   not the correct way to requestion stable inclusion, the correct method
>   is ....
> 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> >
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> >
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding DPDES support
> > Link: https://lore.kernel.org/stable/20240522082838.121769-1-gautam%40linux.ibm.com
> 
> 
> cheers
> 

