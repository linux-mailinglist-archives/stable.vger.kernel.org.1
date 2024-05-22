Return-Path: <stable+bounces-45596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4078CC7B2
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 22:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D372282C0C
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB8145B39;
	Wed, 22 May 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeajVSQE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C27D09D
	for <stable@vger.kernel.org>; Wed, 22 May 2024 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409733; cv=fail; b=Ehqz/ZIx5YAg1rGcbPwQQI74DOu0EvW1226RUQxu5Mo4/WlUFNC1E0DF9p+yx9aBeKC+eBOiOu5WB19kk1bvJOCJ3TMWgVCjggxIqDR0YFvQKJ4G6W3th46/4AMIjZLV27hNTD4CiTABA6mGO9ldnh8w6TSNyg6kKBINBwPkXhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409733; c=relaxed/simple;
	bh=IkKh+b4/gJDXJlkc1HOmed9tOgFD3pFQstU5Ky5U/9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NU38UJzmks+XPb9Q56B2+aifyNWLB22LcfeVG+Mz4saZoM1Dz724oGWTe1IWdNEOz0HGCkbHvQZslhMXQ2YhJHPJC1LHVB8NB8JY0JaoNU4E9ELW8BGfFiOlmk9CV/X3W2orzLFZN++Tqof5Szi9IA/h2osqg+eeIQvvZ+m1R7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeajVSQE; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716409733; x=1747945733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IkKh+b4/gJDXJlkc1HOmed9tOgFD3pFQstU5Ky5U/9U=;
  b=ZeajVSQE0DMxREj3ItlSPnaMnP/pU1Ra9lGbudIt9gTlLAsDpMRo9QdH
   YQnNCUE6epUtiaWGm+Iwhqr/x1vP3OjayuU3SIGQZ7nvHiawImLCnR5xn
   xR8CnFL/nsPyfJQr+MYQ1lkwjhBneWnoAImITMHUs60ph2V8zpfFJIVM7
   wYuCWyoISs9k7OyhrUlLhOOKihPhcZTDiSPYqjSLqw36vdTeHmXX8x/39
   WyRA53YKoN+K7ILd/Of+zzNF++BHAYqVpXLUyegRyeKzh2LYMwDISPisj
   ftopi/Q309F+xXA+Rfuu/CSQShqpe7jYVdPSQ26SK3FI+7iSz2VkJcBHs
   A==;
X-CSE-ConnectionGUID: +atV6aBTSO2nQj0mTo72rw==
X-CSE-MsgGUID: v7YXRzmPRe2URrfT7EfHug==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30189935"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30189935"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 13:28:52 -0700
X-CSE-ConnectionGUID: t20kMSSrTZaTDDdsW8pmcA==
X-CSE-MsgGUID: yRMEE7ZGQwCiF6dafg8ciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37800719"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 13:28:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 13:28:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 13:28:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 13:28:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 13:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMCGsQcssmopaBjq1tD8zLzd1beAGp8PAahVdEWdewnYk6coRPIIe5GgzODQl/ltqicwInfWrweTB6SnGfLJLvqOiLpFM+Isj7/2ni9xAvjB1dKT89WyjJRMeUD9VO2HHR2/389RYY3Dc6f5aLdei+Q8+URIKBCTwjjv3FafA7ibqciEDoOh/GQIt/OCSYInXk9Ivl6dfV7rfFGTpkQpaj0rdZu7r5cIg+Z+xeBHhdjM3VaRnPN/utydpRTrwQ08vhKMB+kZISjlhiZTd7yblUTwmJ/EQAefESriNO1Lv5rNtPG0dKh4CyaeVSN90f9gnacZhOIYUB4R/rGLVEhj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKh42nDGaIisJpPZoI0eoqIsXRoiTt23+MousUVsAl4=;
 b=nUlTvBkYz8AsVWJWG3Q0r4yYwqPKWZLOD7PUwuOY06XAV6TRJawMw3Rl23+6M9XN3F9LJ/rvTEK39gOqizbTk93BzsFgx4nI+655G0lEW+zacguxKLzBtAZjlPitD99lH656cLlI/auY6b4IR0bVOMn+NnHROzCgqQ82FlDqLU69d96/7Foo+afRZl/nLzyiUYit9FgFstc9T5Ry8FLR6rQsrOC7W5sDBo5Pf1qgDdmmkyjUIO91YIUkk/o0TVeZXTcX6M4Q9oMfc9lphDjRr3oQ0VXeJT3XY3fKLl3O4NCEPuFqX4K3KqLKxAbtcUpS00w3fXgk4zcL7gTFILsLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 20:28:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 20:28:47 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: RE: Fix Intel's ice driver in stable
Thread-Topic: Fix Intel's ice driver in stable
Thread-Index: AQHapw0zVEvD1nuWr0GQhV8J7bgrnrGZawKAgACusICACVYmgIAAT0+w
Date: Wed, 22 May 2024 20:28:47 +0000
Message-ID: <CO1PR11MB5089C4123C3B1AB85C9D4EB0D6EB2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
 <2024051653-agility-dawn-0da9@gregkh>
 <0683ec3d-b0bb-4612-b64c-4808b7ec8d66@intel.com>
 <2024052241-divided-atlantic-a75d@gregkh>
In-Reply-To: <2024052241-divided-atlantic-a75d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CH3PR11MB7721:EE_
x-ms-office365-filtering-correlation-id: 67c006e0-548d-414b-6ebc-08dc7a9dc8c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?WOb3di0IdU95ljhBCYPM8UYd8NyqbW+6RqX4zTO/AmNBsVqAggKGt9Xc6jF1?=
 =?us-ascii?Q?nt8Bvhi6KL9WEs31ktVATITzRr0YCnrl0JjQBZhXbde7i7lGQF19MEAkDn3g?=
 =?us-ascii?Q?6o70waQ4sV2DW6PrdkbIyHWtqpx8coSr6zTzqLxRyGvNF+Gw/VemQnWFcHn7?=
 =?us-ascii?Q?71m1mL8ucRQ029Jnm1HpLzX+3NGY4uojvQ/UcmRpQUeS4g8C2164XB9huRBP?=
 =?us-ascii?Q?iIGjpWfwZTFwtys/LrHv5Ul5AqHpbIQqql8OMvFXIG7B6vCvLbSx/0dr2YaB?=
 =?us-ascii?Q?GYVvuqsiEufzSSzDJk6wkuvGajahS0W2n4SnWCJ9SEkMkYopNAhD2ahKIMVO?=
 =?us-ascii?Q?lfhF+IhMnl85yvwhg95VWGtv42NQoYF0Rhaj3Le5tv3ufurfnyZrnK0NzHXx?=
 =?us-ascii?Q?pUjBulJHCR9UN/KceuBI6tipdQadpWmawWFDvjM9hfhbtq5gjNvVCZl5GneE?=
 =?us-ascii?Q?trHdxq+SKC2htCvQhAEaYu0Ak+owytgWVpsXM2jbJmxWS5O2XixkyuObhLob?=
 =?us-ascii?Q?+rvrk6Qlfc/ncnzJsQ3gYZMlApndOf4hPD37SrMJ+Y7xGwWdmIv/1T7l5j3Z?=
 =?us-ascii?Q?YPpuYJJBK3YYchyKPWoL6o82K+1kxCWnZunsdksOX/idsPvtsqon7vScJH19?=
 =?us-ascii?Q?88Ovcx4NgP7/EwObvg4L2pWO5XvX5TExVb0o146nhqsZXwd21xKGlkqvYjPW?=
 =?us-ascii?Q?PKY5WcGJphEdoQFMNy5Hc+QW5AYaYwGdOKMKC5bgV3p45B5hoaGbDqxvDVO3?=
 =?us-ascii?Q?7ALxj+hjHRwCqt0R7hem/NZyx2aiZ+OYVFasAgN9ZmZH67BPK05f3UL5lHy7?=
 =?us-ascii?Q?k6gKbsqNqgWlujPrkpiBz7lLod2mqTmNlwK4mpcTCaLO44XWSLRQuFnQZMu4?=
 =?us-ascii?Q?gL83PwmKMdmVV8ldW1LnfLMxxd34kUb3pBv9c0BQRJhT5ceJtulZ83aADuOw?=
 =?us-ascii?Q?rCqIHEl1Dxx7knpBxSKUZ15vR9siOWMGl883lCBcWA4Z43qZDFk8QHznUaJu?=
 =?us-ascii?Q?5+ozBXKhLj3mIH5NPI8qFj7eTNR9+vKvVLJ48puXmmkw6UqAHhPTWZixLJ4S?=
 =?us-ascii?Q?x8UMLJLmtRpZmb+hIgdrv6ETsQGZPI+CoHAGMYc/xLy9yLEmGeSgVwfwq4q/?=
 =?us-ascii?Q?Fo9PndyCuoBDK8lJ5fyAqPxZ2pj0RsFUPuQddfWB1u8otEKnGIh9cdQcm80O?=
 =?us-ascii?Q?Dz/b+WPHysydQVLoJpW42plLbVtF+LuYOzChj7ZSKt34vzrBjaDcbzSOhaln?=
 =?us-ascii?Q?T0+ewCNqjzGbTRF5d1kOkVz35ezbn+biJOqZvJC5bbIPz9142jmZISeyYxIg?=
 =?us-ascii?Q?pFSd04xx4uAvglpth14nEPkAqgLqclUyTDgOkzLiSwvKiQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?58vKtap4KPJrtJ9XrmqUANE7vJ4Lm4nqYzS6vr8fnxtIauDObnS4XRC2QNOj?=
 =?us-ascii?Q?rTJ2oTgj7tXphjlP1epuiQkjcHWKyN76PgXvzvuQuymc6Tx15goh4FWSyLVm?=
 =?us-ascii?Q?kq2pLuhcZy+PFEW9U3y3UDMr+0XXcz6pUNsJPAeYaQCmuF2bbgsyviFzucX9?=
 =?us-ascii?Q?zZG3G0HJ+EbE6UexCjMnYhDcExS3qVvqyJGDoc46CecNOctFyjj8SoLcrtOR?=
 =?us-ascii?Q?fzuBPROMt46LVFzLBQBYpmjVVvUddyFaeVPFESInCkkjszT+OTIEqLspFk3n?=
 =?us-ascii?Q?87+lkLTc/zS0eX+h3XhfYCBfzEc84PU356rCuDqen6F3EG/Jz+v7JHpY1EM3?=
 =?us-ascii?Q?6ZsyabFJBHup4eCN7UEJJlXX02Z3XL9pNIF6JuD4gr232ZaM1JSOctaSM0Iz?=
 =?us-ascii?Q?PAD8MVeW20DlqlY3maFyH3up3lAgp9Mkwui9XnKgGoBGHuWaGaRbBTySh1Z/?=
 =?us-ascii?Q?ycvpk14nRATMDmC5x87ZjvS8Mr5kzjBZZD18tLiMPdHC+LTCGa+7/7ZZJpYM?=
 =?us-ascii?Q?Niaf/Sr+o17BtRi8B4Z/+to0Nll6B4xsR9VZ4jmijZcJy0gqcyrFehnL3v+I?=
 =?us-ascii?Q?4WqjO6qNhhEn3ZHV/xJQa2smcfrUg1tSOpPCL2nZTN6oQ/D++krIWIbmYtde?=
 =?us-ascii?Q?wc2cHqBUsCbTsWK75sJU9Vq0+37MfZQyWXH5UqKE9+K++spzo6xnFky8Mo/w?=
 =?us-ascii?Q?UIJElOfAYWYOypoMusYDJJsi7iBHOzEOIsZU41R90DD/LtDvCof2e4F/XRHX?=
 =?us-ascii?Q?Xe7u8wLAfXKfrgPxWWEKMbPPLJB7DYdUtMhDxaZ55VOh+CXNbbM1+CFuvpv/?=
 =?us-ascii?Q?4CnDQybPcV5MNYaDPeBAXnTVMXdSCZmSFwky+8pGU8P1CdKLWzErA1goTV7I?=
 =?us-ascii?Q?kD7A40LVExkLuW+y7LzEgQC8gXHyTc4K/g4twBe11/LqQ87w/EQIQNSR72Ng?=
 =?us-ascii?Q?5GQrjG4xLSNzqIUSsF4aajqEluG7D0XQPsYX7wi7Yk3a+MxIoHVmhm1D94cU?=
 =?us-ascii?Q?O52pqKq7Lp2UEG58fi7XuVWFwwwxRAs6NVCB4Q+FGCfPei3GvyZx8WDeO9KA?=
 =?us-ascii?Q?MfJ+KyBoQx74pcCN/3lo/lVNiLPRTJWC12c5kyi7+i3n3JmyTVxZ0J0plR3K?=
 =?us-ascii?Q?YMLAtLjSfYbcS8ag9XL30M1FY2B/iZ3oxN0EdOJ20jPXgiW+fkhTWmqeu1xR?=
 =?us-ascii?Q?pu2ZbvITIzYrwiJ1hxVG6nuGJsWxR3iC1c7H+jYBSWUIFCi/lJxY23sGsUnK?=
 =?us-ascii?Q?SaAFxgiSE/IFy0Ce/+6q3l6lKkSaN+zkhNBdjAVldxmdlzax/ALrkmlZJuJy?=
 =?us-ascii?Q?TnmAV3SNUVcAYW7pK86hSQO35EACM+Qe3KhELYHJ/Jgzdctgy6HcGxLBnyp6?=
 =?us-ascii?Q?IQ3xTmiYVaA1YGLgd+CKfKhszG4r/JfH19wKwspvE4LO6jSm0u2owdVl9Nj8?=
 =?us-ascii?Q?ndufoW6wvbCKPOvNOk1ST+4MNwmkiiX4g0oJp8KkbPZyKGf/UuaLBfLaOnCG?=
 =?us-ascii?Q?+Rwmgirw0uHQaJ/neY1esmwhJofe8jr6vnG39GrsUw5JBT+nWo90d8VysCyn?=
 =?us-ascii?Q?XZuUa2LKN2NZSyJ22n2oSDyOw9Y7ZRXsT3oLu4fcdlWRSWLhd3FPJSy/T5CA?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c006e0-548d-414b-6ebc-08dc7a9dc8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 20:28:47.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ixf7IWVNDHIpa6JHeiSvEgFuOMze4mYWJwCFt4owpon2vceYZchTcX8uXshqWP8+MKvrA+wKq2DvY7veIi7I5FXXE87aPLn8EsZAvQ8cTHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, May 22, 2024 8:45 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Zaki, Ahmed <ahmed.zaki@intel.com>; stable@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Samudrala, Sridhar <sridhar.samudrala@intel.com>
> Subject: Re: Fix Intel's ice driver in stable
>=20
> On Thu, May 16, 2024 at 10:10:07AM -0700, Jacob Keller wrote:
> >
> >
> > On 5/15/2024 11:44 PM, Greg KH wrote:
> > > On Wed, May 15, 2024 at 03:16:39PM -0600, Ahmed Zaki wrote:
> > >> 2 - applying the following upstream commits (part of the series):
> > >>  a) a21605993dd5dfd15edfa7f06705ede17b519026 ("ice: pass VSI pointer
> into
> > >> ice_vc_isvalid_q_id")
> > >>  b) 363f689600dd010703ce6391bcfc729a97d21840 ("ice: remove
> unnecessary
> > >> duplicate checks for VF VSI ID")
> > >
> > > We can take these too, it's your choice, which do you want us to do?
> > >
> > > thanks,
> > >
> >
> > Please pick these two up. That will solve the regression.
>=20
> Now picked up, thanks.
>=20
> greg k-h

Thanks Greg!

-Jake

