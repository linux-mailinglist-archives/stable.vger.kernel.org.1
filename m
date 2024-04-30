Return-Path: <stable+bounces-42800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311B8B7B3A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178112810C1
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78F77117;
	Tue, 30 Apr 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1dtd3vI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28577114
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489915; cv=fail; b=VTkiiJ+Sm7kTlLxiYlSK0CYCD9JgWcgc/sqFRxIpJEq2+9QEClyINc6Ja38xmb0j9Aa7O5ay6cDkmO6klSRgYjfxvdDFe5CuSEQ49W9Y6ULj8OjkrS9trA6w1BgKfMT0FEmm61bTJGd3B+ZTv/29/pr4k6ktuMPJZSapMfISzS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489915; c=relaxed/simple;
	bh=Qk1ubsS/dPGuSLM7HfnAqvBf07ueiBtobNuvffinmco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fCuRTcXFo35NKNjeGsJsSmkJrRQ2tJJQPcLtpCUCMYZ2WerurjIiLIURlHOjhHDCVlOM25EN9WbLO2rpVbYVQOQG9LxjpvJHr1HfQ3nJifB1wUjgnVQb9Hd6Ikc+IvohQFmzIB6dIJPbeHA7/jaN9VMzuJe4z8WpP2C5VsJAos4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1dtd3vI; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489913; x=1746025913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qk1ubsS/dPGuSLM7HfnAqvBf07ueiBtobNuvffinmco=;
  b=A1dtd3vIY2UiX07kJXBTL1yTIhHCTLJW+eldM/Z5NGhXhjhI2S/H0ad+
   eCNz9ORqVUvudyEEga++RrHgaaKleCOKbaDsbX9VH+XhXFd0krXRj9W0M
   4sGeX4/jX5MTzsxwVsnFPZaeWZs1bplOdhFj0vgl8UPl9o1ofytfWb32P
   bhFWSIZkUnBky6uSbT685nbvE5i85SSlNGKrWo/nRPMDFbdGUfB2UFr69
   lwueXCCFv5fKxZAQYtut6NCVBnEBF+YzvtxY6//m+XcLfDHWsVX/5EDgu
   pnpVOQ8foT34QPC1irRiRDMFgJTEGhu3PKs2VYpzVsOv2kApqiAaqsYiJ
   w==;
X-CSE-ConnectionGUID: gM3WR7DnSC2DeAyMcEZOuQ==
X-CSE-MsgGUID: HxClCZsSTd6koBuSfVeypg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27651230"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27651230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:11:52 -0700
X-CSE-ConnectionGUID: 4YBpoOIERt+Rl3RpECs2yg==
X-CSE-MsgGUID: /kaIwiB7R8W8OjU8MYLJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="49703821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 08:11:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 08:11:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 08:11:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 08:11:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 08:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGW6rO0e/vTpwu4e+2TmagffPlbMIrX4jFs3svUG9ijGJNRNp71MXWrIAF7ZnqGNu8kTB/XM5VUFzPPbOOu4xbJc77nQOvtrVbJpzVumVUBvZODosrowV3+ji/+gHXAxmv+HLraprzwD5oiOwM8qqjxChmXn9jdZlH/lFIx6lqmcXafU/evJughs2PBBl4CObsfD8Brzr8rQ/V+bgNcsMJa+x/Ez6nRTQCfVaNz7eMx3C3jxJjya7q6q78WlSVBvrh8984AxGNPg/KkHENmYp8UulqDbLWhZ5OxFoZpszEozWViwkYpnW8hwYT/BZzBmCcvmY+FGBY2hBXjtV+roZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhphGflVwMxjaZVNtX7duy8Dv7xjFNBuFedQxytlTwg=;
 b=GDXUt3PoGdNUakQDkEJ87wXa5Hd4VEV6yZgammbyyZT1tryLZS+rGGmpQgQvkqR3TUKn1j6GxduqVA1Kct1sZ3tQ5IKqN9IKC4InbnXQzv3+Thg0qR4zoGNJuuayDEyHNWLNLaI+iRfbKy1BCc1ZQlLsvIMsFO5ZuozrGeT/eV6PEapZQMc0twlRpDho6qNvjxqPixg76gjajRRfbr8J4fOWghXsHe0WReTIoWwjAHs6bz5doBsoiKWuDiGMCL7E90zGu17/hixidKgF8wGscwQ7PF1Gf9ZstJrA3QUS1lAy4B72YCZkXcKsRamPh8Bv2TuF6qsHs9jxbr2SmP+gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 15:11:42 +0000
Received: from SA1PR11MB6991.namprd11.prod.outlook.com
 ([fe80::c06c:bf95:b3f4:198d]) by SA1PR11MB6991.namprd11.prod.outlook.com
 ([fe80::c06c:bf95:b3f4:198d%5]) with mapi id 15.20.7519.021; Tue, 30 Apr 2024
 15:11:42 +0000
From: "Zeng, Oak" <oak.zeng@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Thread-Topic: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Thread-Index: AQHamDIABv9a32EftUGqBpesvr5L7rF/R9wQgAA6IICAAW3fwA==
Date: Tue, 30 Apr 2024 15:11:42 +0000
Message-ID: <SA1PR11MB69916539EB7B6F7DD49E2214921A2@SA1PR11MB6991.namprd11.prod.outlook.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
 <SA1PR11MB69916393B52812A5D25302D9921B2@SA1PR11MB6991.namprd11.prod.outlook.com>
 <Zi/WSRbYmpZtELhK@DUT025-TGLU.fm.intel.com>
In-Reply-To: <Zi/WSRbYmpZtELhK@DUT025-TGLU.fm.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6991:EE_|MW3PR11MB4601:EE_
x-ms-office365-filtering-correlation-id: 98f8f506-1f68-47d3-4978-08dc6927d7b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hiiR/z9+/6ntlS7WvKxLf5bKuF3HMaTgyExmCavVBGVNPSrlFnldxry/PD?=
 =?iso-8859-1?Q?Ru49hpprCkZ141INBoneQe/gzIW24W6+7F2gay91t0pxrWm8ywyELD4lJ1?=
 =?iso-8859-1?Q?DiIqgQ0rJVa0SdT9ZGak4WOyxrjbKiewGsUokmCwJjQ6Kb7TUOnJGJZyO3?=
 =?iso-8859-1?Q?TXq5Xh8i2VrycUjPcib/UCF+RlxTQdRLrDEranhUoWWOFXM3+SG9/R9nrY?=
 =?iso-8859-1?Q?IpYon2HgdYelgEw6vLTvQjdpfpV2oZ2MO/nKBilUONYWPL9MSQ+e7gYzEx?=
 =?iso-8859-1?Q?V39Z8CryXrSc+oeGcZxg/0sCS/lf66dwoPjOkaMKuEJJnhuUWsATktJ5OM?=
 =?iso-8859-1?Q?VFFs6Y+6Ozya8dmaW4WJ1H73W0PYAFf98OPRXvxqKdzX7+EcnHWR8pyaKu?=
 =?iso-8859-1?Q?58UyyWCDXdx+1bkYeQMiWaxdR92b+u+KvT3keintwrRZFiqIGBjthnWeaW?=
 =?iso-8859-1?Q?In3+ND7DxqUXoLuELGOSQ2puMMR60XnV/oEPjOAK04BDxgDqI6fejJJh9A?=
 =?iso-8859-1?Q?DyGr+2HWmc5baD8/z8mjIQzTpjUKzLyRPg9hj+hlhLRtd4mrYROG1IuluP?=
 =?iso-8859-1?Q?3alBY7xcVq3TyzQ93Z89tRHmFS69Fhivfl8SIOf7+KGcUhzOUmncqc4Db5?=
 =?iso-8859-1?Q?6I3u+3032tZ181nMOHiok+6j/oGvHful3wziWIWd2xRzDbmM3mBQC5zhbh?=
 =?iso-8859-1?Q?CJuitBNpLwdObTd8kfzWBLmo0P8d7l5a7a97FSqdBKobG2XE+elGqNmysA?=
 =?iso-8859-1?Q?rc2UHTWxmVRY1ns0TxekvWWgq1VKhwrCusClMOl5GboGlAZRY8Wd6WPgiM?=
 =?iso-8859-1?Q?L2E7wtnTPr52npo8Tsa4pXi98voDz9eZKwWq/ynk+rXZ8TgvyNbjk5KcZ7?=
 =?iso-8859-1?Q?liePYpmBtAPAZXXXAjPcP8OKBN48ggZ4hIWUucfHyb2xvHlenA81ysTkgi?=
 =?iso-8859-1?Q?DOmvsrEfnyuTTPJQ6VVGCZ7wDCBvLXxwE4DdyAuVFMIWL7U89E7VKVsw33?=
 =?iso-8859-1?Q?f6DbXAHSlGkPzJzuR9V2hufmONywKmJg8ZI5Woa823OgIBxXkNY7F98H+J?=
 =?iso-8859-1?Q?AX69X6Ayqiw6A9QpMKTs2PwraFay5m70Wb7vO0jZ3JzRMiBqdhvAlAJpS4?=
 =?iso-8859-1?Q?6peWjF3Tr/4+x5h7BXkwtCqi5lG8TER+E2dcorptrGO5xm/SeH8NYfeDe3?=
 =?iso-8859-1?Q?E7wOQ3F2DTiyx+nQ9JjzORRvME0YNjXtd+GDypLlF/+xBfgoUZ2oWhGoM8?=
 =?iso-8859-1?Q?xsa7r8oUWQ1mdHnyoB8LZ/Jg32yG2WTns9/tvIKvTgJPZToudNVdY37YoI?=
 =?iso-8859-1?Q?2OvZ5Zcp4FFPmroOIGGypQ2yzlEzO+Bz4dQAvbWxSqFE+1TlLTGSKvnQzt?=
 =?iso-8859-1?Q?JfNxRgI+TUo1Ln3+ftVOaRG2ltssGMsQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6991.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0n4hunovMArwzrEyq7zu1mRkq3RON9nJM6UDfLGf2FRbQhaSLUhI78iT1q?=
 =?iso-8859-1?Q?7HvvhJ3TmeeugOcvzmn4rSadnZiE3frhHdr3ThAs4QD+VlWtbOH1EQfjth?=
 =?iso-8859-1?Q?AzIw51mr07KJzREHiIjlhOplIE6qrpgO0fZoPq82KI/E0kU9P81H5qgu+9?=
 =?iso-8859-1?Q?iF7Ap4yqLJQlpGRjOPLRAP5ARCe7TmrlzPCoTia3TraWnn0I84iLd/UO/i?=
 =?iso-8859-1?Q?1ECw0majPrsqbXCRDJP3dr2YQFYEONAl87ZV3okWbo8mo2Gr6v6+oQXtHB?=
 =?iso-8859-1?Q?zGSjaUik0Mt/VI9+eUoxKmRXofTb/Q7yETNXp9rPFogxhjWN8p66l6V87I?=
 =?iso-8859-1?Q?mDg/TJJRC3z2d4FmEedb1gPw+k70VuaPFL1jgTeYY5CPjMUlgT3/lHipz3?=
 =?iso-8859-1?Q?cAOCRLja8XmPOmN2iKs62vHJnByM/zhqaNqd2l5g6a/XfnAXBwpd3E9YCP?=
 =?iso-8859-1?Q?ZX2RkfJFosAjgZOxJOv6CD1SWpLvS3kuHbqebJ96kVweY8whsCBBPCbtTa?=
 =?iso-8859-1?Q?emczOwSiUquuEcBy3iC5MOdBKgV4ljQz0DPhn8sp9BNE8A7Tv/OSEF2NST?=
 =?iso-8859-1?Q?mUBvvMZvW+nZANGZdtwTlMoRXt/P7MDxuQ/1lF53i1mQb/0j5jgPxppmUD?=
 =?iso-8859-1?Q?A77AVmwqRD+vqcCO6v+eZe5Twg6pwR6rDMQV285a0wsmaS/0oJ2DCk45Sx?=
 =?iso-8859-1?Q?rtRIA3V1Cx9SyvBwkD6nK+tYf4oKQIm8RbUbNsN5f7UAEBOOK7tCDy/PPI?=
 =?iso-8859-1?Q?VEjcp3ElAlTvtJHb+wgyxLcV+PMQtjgGnXKLllaQFpSpfaI9FaGD1Y1hF5?=
 =?iso-8859-1?Q?X0KHDPRJGsQfFeCJNUgKMvRmATJVC0nimrp7/Or0R5S6hzID+3RFwMZE7O?=
 =?iso-8859-1?Q?66gCy5HBQ0KJ0V4V+L1OynDSS1kXgTHOEIp95otZSJs/QKLeJhpN5h7zmG?=
 =?iso-8859-1?Q?8ImC18i+AtvRvmV3RkMHN/yawKpvKXRp6vFhN4F8obceIABqpkEKe+sooE?=
 =?iso-8859-1?Q?WvcHSqsuqsqLuGWBLqcgTxu9n/38nJeddebHJFPsNoRglz8T5wbtxemrvF?=
 =?iso-8859-1?Q?gKBWzEaKzgPtjuFV3y72r2oIZcX6jg3J/VTJVOsJkjG/XWURzDGf4AxcED?=
 =?iso-8859-1?Q?L9Alb5/D4SWUWorRmIPbqrqV0vfA0XfC3320S3XzvP0NZH6Q6pi47w2g8t?=
 =?iso-8859-1?Q?1Wx1WWsfQz6V1mFAWYTtLnY33qPeNg/KIIZYn3rU+ECi2loXGngC9tDXf7?=
 =?iso-8859-1?Q?zQqLT9Cag5bG37+kMY/VsrebaftWiGRcu7WraB+IZqUP7z8RIqworeE7sV?=
 =?iso-8859-1?Q?BHFLmyKbV+rViOcgEjsmtL8k53+QAEUC0ZQ1bL5B15fyP3i9WYj5MV5BGd?=
 =?iso-8859-1?Q?Ib+ORJv1LfIJXNBIjBHUtNUv/MAcBSxYTJO5DVFuq11UfxZYyC7m6jQPj3?=
 =?iso-8859-1?Q?7GBja+3hHpRDLSU/TwYsXr8RksNejoYyc+VXb+3CiwhRM9POOgZI72Y04O?=
 =?iso-8859-1?Q?hXzQRz6SW2QIcONpyeF+7zhOIB5p6KXcsQnAKLpXSM22/t47vewp74zbw3?=
 =?iso-8859-1?Q?xQl0BnRZjAOJyqP6G+K2Y95xxvi1x+1gS1Z2zto9WEDRPaabVLmz78Rw4K?=
 =?iso-8859-1?Q?D67cbIkXilyCc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6991.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f8f506-1f68-47d3-4978-08dc6927d7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 15:11:42.3041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRUysC+1iwymMfR19hhW3q6qYnd4ZJM8F0r/KLBGOF5OsoU0InzZb5ExmfOD5JUoh12qj4NEaqu8coVt64wK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Brost, Matthew <matthew.brost@intel.com>
> Sent: Monday, April 29, 2024 1:18 PM
> To: Zeng, Oak <oak.zeng@intel.com>
> Cc: intel-xe@lists.freedesktop.org; Thomas Hellstr=F6m
> <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
>=20
> On Mon, Apr 29, 2024 at 07:55:22AM -0600, Zeng, Oak wrote:
> > Hi Matt
> >
> > > -----Original Message-----
> > > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> > > Matthew Brost
> > > Sent: Friday, April 26, 2024 7:33 PM
> > > To: intel-xe@lists.freedesktop.org
> > > Cc: Brost, Matthew <matthew.brost@intel.com>; Thomas Hellstr=F6m
> > > <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> > > Subject: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
> > >
> > > To be secure, when a userptr is invalidated the pages should be dma
> > > unmapped ensuring the device can no longer touch the invalidated page=
s.
> > >
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> > > Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user
> > > pages")
> > > Cc: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > > Cc: stable@vger.kernel.org # 6.8
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_vm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index dfd31b346021..964a5b4d47d8 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct
> > > mmu_interval_notifier *mni,
> > >  		XE_WARN_ON(err);
> > >  	}
> > >
> > > +	if (userptr->sg)
> > > +		xe_hmm_userptr_free_sg(uvma);
> >
> > Just some thoughts here. I think when we introduce system allocator,
> above should be made conditional. We should dma unmap userptr only for
> normal userptr but not for userptr created for system allocator (fault us=
rptr
> in the system allocator series). Because for system allocator the dma-
> unmapping would be part of the garbage collector and vma destroy process.
> Right?
> >
>=20
> I don't think it should be conditional. In any case when a CPU address
> is invalidated we need to ensure the dma mapping (IOMMU mapping) is
> also invalid to ensure no path to the old (invalidate) pages exists.

I understand for both normal userptr and fault userptr we need to dma unmap=
.

I was saying, for fault userptr, the dma unmap would be done in the garbage=
 collector codes (we destroy fault userptr vma there and dma unmap along wi=
th vam destroy), so we don't need dma unmap in your above codes. It would s=
omething like this:

If (userptr && not fault userptr)
	Dma-unmap sg

If (fault userptr)
	Trigger garbage collector - this will deal with dma-unmap


Oak=20


> This is an extra security that must be enforced. With removing the dma
> mapping, in theory rouge accesses from the GPU could still access the
> old pages.
>=20
> Matt
>=20
> > Oak
> >
> > > +
> > >  	trace_xe_vma_userptr_invalidate_complete(vma);
> > >
> > >  	return true;
> > > --
> > > 2.34.1
> >

