Return-Path: <stable+bounces-47643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F868D37A5
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10352858E9
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AE8FC1D;
	Wed, 29 May 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGv6baDj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C34C70;
	Wed, 29 May 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989447; cv=fail; b=rQf3kq+OaBQ+mbkrcVzBGptMfguXsGbGjx+JvrrB5thpG1N2MS5g/uTejwXl9xbmcDoiVL1n66vbftVPikaew0K0HxOoGuikyoK6KaN0Iq1l8kqC2kH6gPXJfQXICZLnoclj+liC9Sm8PRJsgTa6HY1BUIs77CZhGlHTz0c97YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989447; c=relaxed/simple;
	bh=YN04JHtdlKGY3bT5s1D7vRYp028VFpUCDhUsrzxZnd0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JP11sw+KvxGdi2EP9lNGSVmIcA72mJnHf52bjHKWokqfKmKtIspVFIMdOUf6ZPo5Ahuf9W1UYajK/ZkvFBqUEtzT8J4xu9cT9p49Zc/PcwIVlZk5RbSmbxj0K6mQcDFD6yPWmWArpE6CzvfbNnxnL49AkgiJhRH+aN4VS3LuRnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGv6baDj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716989446; x=1748525446;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YN04JHtdlKGY3bT5s1D7vRYp028VFpUCDhUsrzxZnd0=;
  b=fGv6baDj/l+f921Q7ykU/SDTrGWCSxQGnc+xz7A6auorTrzn6nj4g4gI
   G1lDvqmiCQAC0k2I4FxUr7Pxrfy/entfLp4cR3Mzhwlz+XRZC7S39SMhT
   atABHqhBrOEv7NQpTRn04iq62v7F1a79IhVffZioaE8Jmhglko9r3ooMp
   AhGrh3EAxag8xf2aGzHzgrPKhiJp767/rflL4mXMatUgOSiQkczyIXM+C
   cCUY4ftzyQV0aKmODiztRAz7oOvU+QJwLdVMUIp8WwVgT9/J0j0cDeSNV
   WJPaZ4KRzAA+zNl6TGC5fukMvWMac4D9WYZDgyS0flBQR95Ib7A+1dkmZ
   g==;
X-CSE-ConnectionGUID: 9ByFnFB8TJWXl/CclC7OPg==
X-CSE-MsgGUID: XH5VXEytQrmrjvmHvu4thA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="30894469"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="30894469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:30:45 -0700
X-CSE-ConnectionGUID: 6fnTrPhpTF+Z/us3BLsdlg==
X-CSE-MsgGUID: 82JZCDugSWyhYJtanBj1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="36053300"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 06:30:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 06:30:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 06:30:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 06:30:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 06:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1Ym2+C6yTb75EPg17tN0lHv8yzx6b9K3+YruU57ab27nnwcQSiCjSpfLuCbgwfIdU3aBSoJYT5V6q+RqUpAa/W8yb4B3UPAfXpNJO8YdiNkyukg0LgW+LVVcTENSrW9hGvWjd8Ran8cx6pZMjxoTSTCNAN2qkDNs4m3Hx6zjX72VIizOGnbJzBglRjd+bOouVjqVbS5XcFb6KXe/B1FrEn5UWkbHQbTMfdsMMDvzYSvHi1herq8uY5KjhHL2bE63LIoN0L3G1WBXpxStEFzVEBbeZ02JVOR7WWSRd75tJMFkb/Rbyk7ta0H/YDpeaZkN19gSQqYINfXYPJuEqmH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/fV2x3brVroKhRIi85Cs7VBpNse/RavfTpsrgDEZ8E=;
 b=FPk4QZKwBkVNNl2BiYdZeT0VkxvnYS4wEhT6X80vmuR0u+m4vcEsVXG0vEGmJmVu5Fh83uAHi2/78E1++jPG2YXSS4G4u25RCKGS1VVyLAetCFHkdAzztSwNv96q/q3nUnjJQWu0ZZ/pH91G06MiSuFBKUuvv+TWkWcydSwjKJv+PZS+PatZmJLXvgOhSsdtXGEdsttiaU7TGs+vdJTebNDIVLU34Zlo9krDIsL8q+KosXOSQRlKgKfarHLRlRtD1dfbOaYjPPJ53NjuOvpSmMYTvYCbFfsUnoGwtNz286M++f+RsDnByVp2v94lLSxkPMQXDRrWFs2zrSEFzY1pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 13:30:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 13:30:41 +0000
Date: Wed, 29 May 2024 08:30:34 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/pci: Convert PCIBIOS_* return codes to errnos
Message-ID: <66572dfaa49c9_86b8f294d2@iweiny-mobl.notmuch>
References: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 41676649-2fbf-4212-b357-08dc7fe3894e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bwSVKxWjBgKu8zlc48HJXOpxCYx0uo7HC+QTCYR26JrQSlhJ6Gk5RM/NLS?=
 =?iso-8859-1?Q?569kWciDhab2cHUn8vPBkSCB+zRMm4jsX3mhXifzHufm1UPbTQWk+0Yopk?=
 =?iso-8859-1?Q?Vn33/Co0N1lcJly7K7dZNa3e5FbwUoTaYNuo76Z8kO/AN0ZVBsrr2zHcIQ?=
 =?iso-8859-1?Q?RF3rQ1TsUvSO64V2ZaVTZBq9+AteP3iCY+fGoLuMpSroVhC1kzR2fTMIyI?=
 =?iso-8859-1?Q?A35ig7u5V8Jw1dC9CuKrkkOsomGWorkwp1m/5x7A7uJ7AlYkj3wTPq4+U2?=
 =?iso-8859-1?Q?jMpxad8owcjz+N8Rn/lranQPKTk0DwdFEmNiliAseJkI78R9mA1FK3aEZi?=
 =?iso-8859-1?Q?L1twIkRhkiPrMpooq8TCzjJTxK3eaWupbwM/RLSkENw+gpSUEkeCwd008G?=
 =?iso-8859-1?Q?0oQBUUDv0jioivFE/OmRmUJ8DwtUONUZhPBY1Mat1Z0jXunb/WN0tWot7u?=
 =?iso-8859-1?Q?cgbZF5IYHlTJ462QuY30AQyBz8uU7O1Bi4xqDnsGs/UAEeXsf0lAXPb7G1?=
 =?iso-8859-1?Q?Ztizqia06J2WP/rb+CAtYiQOASQLSUDRAwFAHMjo+NcGpp+4Xmtmt3chgT?=
 =?iso-8859-1?Q?OA5QWLQZjrgUVFwzJa/+aqANO1iAyWG+v2OgJkg6OCT6tfQhE4JfDAf/2o?=
 =?iso-8859-1?Q?/wnIBN3wf2wH1TbFI1hm8r+mXAFHGwwm+0PzJE0uXPGJhIX1/DJntwFxss?=
 =?iso-8859-1?Q?1+AjEM1QYcxRiS9ZxXTMzEx8ArsBZ8W6q+vxGykF07QkFclOxiuIKQlibE?=
 =?iso-8859-1?Q?Lxv/FP/NTAuhUfVcX6/iNEU9rLyzDoAU+pKb/ZpgEYRLe4HTpP2VemL5oS?=
 =?iso-8859-1?Q?bj9T62WzLVCesoM8mH92qaaJPi5fXtgAqLAUFO/YIIG1F5lfckKupZDJOm?=
 =?iso-8859-1?Q?qhDtNmBg8Dp8XrEVrwQqU7ExlMwYy2x/L3uly0k6OyvIFE+GnyHjYUcKe3?=
 =?iso-8859-1?Q?s0SiXlkMmpB+VXerqXh/trWX1IyJR/kADee+O2qUP9vyRaF0CnAa3G/qrN?=
 =?iso-8859-1?Q?JUpr5iv/I57voS0umitnP1P2+05WCWrGZenCVYRcVplX4JuqVTuMU1zAcL?=
 =?iso-8859-1?Q?UuZ/t73cHfhw2JpZYdQ3DKWqGWW9YuMDDD1ufqP6Ws2l8ZD6OemY5z4qIw?=
 =?iso-8859-1?Q?Hs63H3e0sxPIOlka7czdWmOXmm6vC/LH41LygjT2xaLi7WAVQS7bCj2IhK?=
 =?iso-8859-1?Q?x2j6pAGl2k2io1r+F5ipo2CES2+X6lRmL92C+RJI2jG6z685morcBmSeuH?=
 =?iso-8859-1?Q?fMA7mDVtftq1H2romNAElZJvnVr9bk8YpjKX4JrkWV6L6XyJKF2XfiJ/is?=
 =?iso-8859-1?Q?A0XfaSoVcCp0KaWVlxYYaMzP11N5/eJJEaMRN9gTyLlgY4W54jOK92Qc0G?=
 =?iso-8859-1?Q?JQMsZgpZJG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XEaHLWmWj9P0vmbK6NYG4rn5c3Wi299lclj0BZS3K8/9MTr/Fedn3gOt12?=
 =?iso-8859-1?Q?Vv8BF9VN637jZQY8uW1MoiOjFUlcwqiaI47V7HSR87CPgBbePN415gZ389?=
 =?iso-8859-1?Q?nUY/A1nNzDEy22cbf47hlBIhdjHNCXgh1DEymlc67WMG8nOZeaqJjStcVa?=
 =?iso-8859-1?Q?OGI4xi9ubCmrsnWcs3f1s3d8CIApXLCGB01rfKXj9JQ5Uf+Xi3Ip3/fe/T?=
 =?iso-8859-1?Q?3h/Y4CSym+ezBZ45c9Vj0woNZE252YIl4KRGE10QYiVrCnnmjdQ4kltO/a?=
 =?iso-8859-1?Q?ffjv4rjRLHj0c+PbaR8CmY2qyUaMOellDHUBpBGr0lmCSdgtG2UDjo4bBL?=
 =?iso-8859-1?Q?+gouxD09caEuB9+gC8s2E9ipAOFjxAK5usKwm5qd9r3nujyoTxWhtEciXI?=
 =?iso-8859-1?Q?XeZgrmuI2EIH4R4T6e+ONd91GwX0bX5s0gYkEK2SwsoUWNIstNz4nryQZR?=
 =?iso-8859-1?Q?08ElulltvxhZlw2T/zghVhPt1AUEO1do36BHx9oXry1HmZBQy6eUN9zVI6?=
 =?iso-8859-1?Q?jrzwStN71XDz1vb2Bpgim5+v7uLvWNdhF0wLJNvMIT1Zvx3yMT1j1/ioeU?=
 =?iso-8859-1?Q?B3wQphlqBDs29PSudlfbOOoKdfyZwXN9hEhnx2t4zWsIgxSsUDHrxIPu61?=
 =?iso-8859-1?Q?WzZIhTYERXN1vhwVRBu9hRqFPANwkXSpw0cnqRqz5DIgIjkx7WN9NJHB+1?=
 =?iso-8859-1?Q?46lRuXkzz2LAekBYAln2M6d9YyXPImeWTO4jknXp0ITnzQxAZnUtafGtLO?=
 =?iso-8859-1?Q?ifVYBu7r1us1pVZ1dkDmNc6p7e8E4LX4NWNG3fMwTycmYmYlEEjPoaKN76?=
 =?iso-8859-1?Q?PQDvUyjXf13dh7SpJyyKfihkKhZu4Tp7W3oVTy9aH2hagxbUNZ71e0yRBT?=
 =?iso-8859-1?Q?ZGsNer3hxTFyfcY4X67I2/9t4fVGbqDY4c5A0fSvUjuB8JWPINwLiZB2UB?=
 =?iso-8859-1?Q?Z+vzrthXmyXiAv+hB7X9WUfRBijjkgnBGQNoSC1YZLYEi3GusSbJ92PAyb?=
 =?iso-8859-1?Q?F1WHDP0LV6oU+uGt7z+OgRSJnfiBtAsVUOLXk5jfHoc7c9P2rs/o6soujL?=
 =?iso-8859-1?Q?7+0ULTAoGH8LmHVzInTXl8yzKc182f56SIPL8mOwlhCi4ZCUvs+4KuUhlY?=
 =?iso-8859-1?Q?3eofgzoW+AfMfhAutO6/bjh76ea80Dm4YCCLVzZjMrkEfKugvfU8z3QhLK?=
 =?iso-8859-1?Q?Xfgr4tz60K8/1HatLIu4LKH+PX9C82FnhBziprH+Nn0dFcFuJBowiR6uzh?=
 =?iso-8859-1?Q?UgpIijWJWmEUfGZIXK1BgwxSDcDuzB8nY2G9iJiN3tz89WrkHdeJIPxNbf?=
 =?iso-8859-1?Q?rrSlpTgBm9oyMoGEOs8tMyXKsQpO7fhA8QihMkEnzyKCeHN3fvkChLxydd?=
 =?iso-8859-1?Q?Leye2xGVHf4hQuL4tFD0JWsF2vi778TYexTDsmvQbV/6rZH3fHd4Ct0mhU?=
 =?iso-8859-1?Q?Tpvls6dUUrkL0ibyNNO9pC1l48DFjPV1Trh7EAC/f9oeB9dbTYerzYOnHE?=
 =?iso-8859-1?Q?/BlrTO8sKzsM2PWY81MXtX39ofn2OCpxo8TjnD1PxM1Q9wy6KgzTicQrw+?=
 =?iso-8859-1?Q?WUqz5lHJQA9xJce2HzYD6fuETtHuzL+zxF33ir7Z3aiJUQREKuthN9g+j/?=
 =?iso-8859-1?Q?Fq5uwq+yMAxFYGxDf2D+ZIBW4rnSIoIzCiiEg3jM/W8KXoQ2J+t3GZHcnP?=
 =?iso-8859-1?Q?Hl+0ASmeUbELrNW3/9EqR7uc7QEKbz3CK8d81JwF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41676649-2fbf-4212-b357-08dc7fe3894e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:30:41.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjAIkD0sehJWZ3MHo4nNDH5xUyNJ+hY9VqZ/dU5eUq6Y7IsE3HKlYcMSG0zrz8b6lXg5Azo0mWXpT3zASVXq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com

Ilpo Järvinen wrote:
> pci_{read,write}_config_*word() and pcie_capability_read_word() return
> PCIBIOS_* codes, not usual errnos.
> 
> Fix return value checks to handle PCIBIOS_* return codes correctly by
> dropping < 0 from the check and convert the PCIBIOS_* return codes into
> errnos using pcibios_err_to_errno() before returning them.
> 
> Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
> Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> Fixes: 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration in the core")
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

