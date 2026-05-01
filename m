Return-Path: <stable+bounces-242522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NMMORAW9WkEIQIAu9opvQ
	(envelope-from <stable+bounces-242522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC14AFAE8
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94C493009E19
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B0423A97;
	Fri,  1 May 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oICx5wJX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90906321F5E;
	Fri,  1 May 2026 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669490; cv=fail; b=kyGlf2Fa0HjqmZZ2fCCoscj72TLUgDidYDsX3ELEsLbJ0nENrnIr2v2K/nwgAyikL0giBoybPHdwAMwNKmOBj8i/ZsOJeMF9VAxGVTyeNAFUk8hKDtDtikThUHdK/jrEhroLldygsrSauDDzNb8wdRxHuCeNuEacONqLLidv9ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669490; c=relaxed/simple;
	bh=gqh4TLt0+hXMXY6gzrIpyB4o/qQcnjPaWxG9j+9fmHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhIEzLTEcdis2z4uIOohtNpcfLDBmYMtZM1FOq07XegDmxlos8OqgwQhw+dZjWsA+oHbbEBjkqqXqMuT7oWGm+hwah5q7QKyClfhiLofDR4mdhxOPG/7QDekv2xXvI/QmmiOCxGHDb9b0hSaPyct8BD20sTNX/P1DyiKjOmb5jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oICx5wJX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777669488; x=1809205488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gqh4TLt0+hXMXY6gzrIpyB4o/qQcnjPaWxG9j+9fmHE=;
  b=oICx5wJXDb9eU+npM7o/OR999EPKgAPxQTeLn3mFEctgn0o/MyyHRKcq
   nypBW3CTiiLR2nXfzHVRftSX/hKkZ6U+Laz7BVaJZf0EPT/GpHnNOoAJm
   pjZtFMMvZb+O37Fv8SFwORPeAR+AxGJWfGL/tn3/T8P3ZuBeF5gl90RNv
   0ydfw/ezGC1kA7I58uiIHsewpcN/xB1kD5eSp1f33Mim+dZw/Owkuadmk
   uKwaCZiQCoualkyRlaY1EKK0K42KmBhzQrBC1p6aAGUZ4oPSS3HC4eOz9
   TYW4EOxjCySPrTqereYr3kt1ontkClQobgSHuKTNDT/FYiyeCD20FiiRh
   w==;
X-CSE-ConnectionGUID: 31icuuf8RFG25bZrtzyCKg==
X-CSE-MsgGUID: 2tP9WYyiSYawjnqMGqxpSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="90092399"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="90092399"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:04:48 -0700
X-CSE-ConnectionGUID: kYFwn6FqSti2QxIhkoLdig==
X-CSE-MsgGUID: gESzA6bjSiiraWumUr3yYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="230598350"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 14:04:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 14:04:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 14:04:46 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 14:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPEAeRUeqas4QcrnneR1slgFveEy1XUqTfVd9ySDdQLMZ030PngyF1c0fvBQEew+LR0NTwFBGNmJmi3vrMWwtwIxj7s3uv1k3BezfuH4FHghJ6gwO03jYRo8S7ncx8ht3nCxQMJOVcOx6JfTwHI4i6AyJSDRSuTpk+z8NAWzF1iZpHO0zkaT3H3pSahRdPHC1Xilq81ULN2WJGUB32Ip46z0CySyytaWVETF7CxHWiHH5XkQ8JdoE69MCw2I9XxARCMWqBeMcdJEerAG+OWsyPs+1G1OLBT9XKP6R1aDKkvSCY7sv1o3JNUj0ffNh2wJ73CYpT15LOvmcjjww3tdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZdiB+WTk6wmmHzF/unZC8fXnt549jpmsWbSI6aFCeM=;
 b=gQOTqpZjbAdOYexRYKSiGXpY4L57X7Ge1Nhy50A4Zb/MKUsLr7sVL5xeYZfNybdqwCKA8poXtrzEHtdAtmiQn8Hzx3bcsfmM+7ElU/a6SuDclQ1W2hiPl/MBeneUyHBFFgM4IXDZ1XAzv4TF73NMFyuk7ed9BG8Lah456DrVlFyVnd8bP2cBJJrUhEOHsnEAG7XdZHjUYzbojo+IdjQw+5XbdBHrZN1u2pYyLR3a2pTMp9eXera6KNSKXHpAsDDDANDwnAJSu870rBYsMuHPjM/N99fWZyTb/4NOicc2q1GC/ZwnoXAepiV8iyPnGFfJvcj2m4lUsIpk+xrIQg4/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 21:04:42 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 21:04:42 +0000
Message-ID: <c4fab3dc-1627-4775-986e-6b3ea52e7c36@intel.com>
Date: Fri, 1 May 2026 14:04:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Andrei Vagin <avagin@google.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <criu@lists.linux.dev>, <x86@kernel.org>,
	<stable@vger.kernel.org>
References: <20260429000623.3356606-1-avagin@google.com>
 <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
 <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com>
 <CAEWA0a5=S+C2pdViHPWykvG0Dj4hbuKFVhSnEzpPWoyOh4oAnQ@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAEWA0a5=S+C2pdViHPWykvG0Dj4hbuKFVhSnEzpPWoyOh4oAnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: e1529c56-0101-4e4d-a132-08dea7c543c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LkBbhIXZcY/3nvYVqLF2HB4MxokS+tQY9Yt1Inrjf7ocr0LGPbIrDfZOr1J535uSM2IJr4YJZO7XqqSarC9mKrevxU5y6rVuvKX+EOJMmNBCCyY7X43/nIOiWVd0UIKcY2XLC1Cdfqxnkh8ScgFQLGlrsd9Ahp57GUL9eBR+e+LNAYAmLdNOttZ61yYvS53/HTpU+sg7SRb8FiVXkhPiLrjK3tyX0iXDMciixqmEav1pCOJmoYzXvW8SMlv2haLPLR3r/Xo5+nAdyPLQ0CpPiA5OKjMmfm0Fh1bOjKPLXVbQBsvuCZqsWcn+iPoYaGKWucBPRzlJNfYDVuOMn+8u1aaOwvrHQv706Fbi/Dn36OxIjD/J2Y7cPKu+ttmCe1vNZhjODaOTNhoglBSyfSzWmtG+QcwJevKabxtiUFW56D7v6M37MIlMw2avxE5tpC0IhwQuWHzBtKeyIy3CnyeLgXGdV1NpIp8xVbJCaHrt5KfFmmhY3EJ/hxIPiDKF6j7SUgE8r7n7r4sDsS0QVpUB3JiwSoxGwiLYzMlhtubej3GIGqftYAOwuTIm4ycLq6rAp7EXJFc86g0cQC9GQS0sJldhQZ+dVseR11a76N9jXvkQFAxlaJvL4CbadvdmIbzKsfVDRdcEnarmVJp6PSvq4qJqVVEsPKsehhv9HIVYT4/1DnFIvRw/Y9K6HGWLTk/P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlh1cGIxbElXRWx1WGNXZyt0ejN2K0hnUnBoSTZmYllPZU9OdEtWKzRzdUp3?=
 =?utf-8?B?dENLalFGTHpUZmxseFp4a1RNLy9rNERPVERhRExNdkRTVHpWZ05UZXE3Z1o5?=
 =?utf-8?B?ZkptNWNjQndxYVo5cko2Vy9mVjY2TDY4TGJMazRkbWZhVmJTVnJXRnFGYURo?=
 =?utf-8?B?clI2UU9Ibm1Hem5GcW5VV1ZMV3NrNDhtMDFxUThTMExoeWh4SmtXWVVYY0Jt?=
 =?utf-8?B?dmIwcUJ2eVpZVDdKK09OQ3diOGthZ2Z4U3FYd0h5eDA1Y29mOGRrUkdiSlNs?=
 =?utf-8?B?U3VHbFN4Z3lHZTRKZXpFK3M3WkNQVVlrNDFDeTNJMUtzWXRaWWZpKzV2RkNX?=
 =?utf-8?B?blJTUmNnMTlPdkVIRFBhazRRMmY5UVFJMEdTdFFiSVhSeFlaVmFOTGhrOGdB?=
 =?utf-8?B?RmhnVUR2WEJNckxsTENMU1hNSXJpdGdTWFlIR3kvcWZLNXRqNHVMSjMwRmJh?=
 =?utf-8?B?N0dmMkpmbXhMTXZZc2VPQ3pjUkRoU0FUaDA5OVU3eFlJMUxGT1JsZ2V4VTlu?=
 =?utf-8?B?aVkxUjRqM1laZHNLZ1h0Mnd3eTJjRUE3dXRTY1FoY3FqcGplUUNLbnpBU015?=
 =?utf-8?B?TnAwcTZ4Y2NONzFKMEFCeS9BTDhkSEFjSFZ1Q0ZRUi9nTTJJc2E5ZUQ1VDds?=
 =?utf-8?B?WTRqVUZXTDUrdGhqZGhSTUZKN2JYZ2UyK25QOW5VYUwwdnZHWVRJMHIwY0ZJ?=
 =?utf-8?B?Q1NZN0dJc001RVRqazhHVUltek81UWhkdVRZVnpUQkxvK0NLWDBYQmh6NE50?=
 =?utf-8?B?NDgzaGM4Ykp0Zkg1UjV1c25TNWYrZzMrWUJIYWQzSlA5eE56OEEwOFE0VHp3?=
 =?utf-8?B?R01FUXpWQjJqRjI5OXoySWFQTUtwbURlYWVRenhWcUN2YXFUSk1BNU9vMlVF?=
 =?utf-8?B?d0NXWTR1Q1F2LzZRQU9OdEtGeHpXZ3ROZ09WRU1oa3pUeGJHV0REN3F4Uy9n?=
 =?utf-8?B?bks4NXFESk00UE9EK1A1UVpYZWRQNzNjNVZ2ajZobjFSNVpkZkMzS2wyMXdk?=
 =?utf-8?B?Z0FpcHZGWEVBT0w2QzhhdGx4d1oyVmJSRmc5bDdOTWU3QVFhdjhmYlRhTG9U?=
 =?utf-8?B?dlFyYWFWWjdSWjJrbEp5ODVIc211ZUF4Z0tvT0gyZW0yd0RwbEIzQkcwbENQ?=
 =?utf-8?B?ZkhPeXAzaW1DTUZhaStOUHpmakpxaUx2bjJhWlJ5bERTNEJvSTZORXFJZVBv?=
 =?utf-8?B?dnpSMXp5UjRLRWY5bW9IODVSU2h0Z2hlREtjV3AvRCs3UWZGVStzZTNMRkpU?=
 =?utf-8?B?YlJtY21HeTlIbmxWZ2twWTNZZ3dMbzZDOWdhcEp1ZCtzclZEZmRYZThwajUy?=
 =?utf-8?B?NXo0Tk1iK0E4em1SU2huRXI2UXVxOTRxaGhSeHRSL1RVSmpPUU5TMDloeVhp?=
 =?utf-8?B?dnN4T1F6a3IyUFB1T1JWUzU0Zm50T2RrTC9qQ3JDOHNOMmU0b3RoYVY4bVJH?=
 =?utf-8?B?NEs4aEU4dXM1NlV5dGpQZVV6ejVvb0xFcEVWYXE0SGpyQStuVlExZlc2amdR?=
 =?utf-8?B?N2U5dnI4STZydzV6VElxcFZtS0tnaWp5Sy9FS2QvUCsrZkxnbTFFMW9QMWJX?=
 =?utf-8?B?N0ZCU25IRFhHSFdWMHFhcXVNbHFTcG53L054UzdlWEN1SitRUVNZK296UkNu?=
 =?utf-8?B?c0hOcyt0MDRXckZma2g0a1poVmZFYXA4ak5mdmFiaWlNSllDRlZJcnpwcytF?=
 =?utf-8?B?TC9tczB3VW1TbmQ4M25CdmZjYzZEVTZjbVZYVW1lSStTZGQ3cFpHRC93ZjBV?=
 =?utf-8?B?SHJYbG4rUzE5L3A2SnVzSy8vVFdSa1AzN0Z4eFhIYXo1WWNXclVRNDFBNWJI?=
 =?utf-8?B?QUtHc3l4aTJta0haNk5iUzNlOUNQTzV0bmFwT3VGOUxTSTllUE5iOVJGallv?=
 =?utf-8?B?NGY2RVBmbmdRenhCTVQrU2Y4VWFjSzhaUDhpV3o4Wk5KOVl3U1VYUktWcHZW?=
 =?utf-8?B?VTdEa3NxakRyZzhOUGhySDgxMnU2K0d6aEc3THpSSndkcCs1eXpxQTNFSzlU?=
 =?utf-8?B?N010eFNtcDFMSHFYR0owMmFDaFJYMnkwYS9hOGFITG9UWURDcXZUVUZPdWNa?=
 =?utf-8?B?emg5MkFuUVNoaSs0R0lDK3dTNmN0UUVGTDRHYXV4T0tYazhKL1AvU2pVaXps?=
 =?utf-8?B?bGF0REVlcEl2MitRYnVjSDFQYmY0WFFBaU0vTmR0TVRzbjg0Vlc1TGRJUDFk?=
 =?utf-8?B?N0R0eCtaRXROaDhJYmZacGhCS0lSaEhxcDhmUndpRlh5NkFJNkNySVlTYVU3?=
 =?utf-8?B?a2l4bFU1eEJLUVRJR1BwVmUrZlVSTHZ0WEd3S2Y0VS9uTHBxMjRCR004WVc4?=
 =?utf-8?B?WFlZL1V5NDJZQmZlRDZPdWhKMk10WWh4OXdTS0YycmNtSHdKL3ZGZz09?=
X-Exchange-RoutingPolicyChecked: j5wIYDREFJgJQ/yf+hGbMvnnoI4s18dTJHED4wkvToqo/9c7Wllr8jsPHZO0BDophQUCkoLXr2DqnQQX30Y7QXREkrPTwE+lBnwYgqO0/jgJZrRniaQbs1Wz6aeIBN6duMk/oKSCvKkQsyXjFZKZufb3Ad/J+/bqRxDUS7tRBbH9kPYo+6GNk0IBYcgtLteOSqmKlxBMDOUPkuBk0CDpL/Uxy1yp4C8/igMO3oB5C4texp/U0lojkXUsoT0wBIIs7qQYIGZfvLIv3p6EfEDmfltiGhA1peHvCwFF2jDITP5OlL+H27cC9G5R5XMWHW4AS8XoCF8uYfmCBMqsvC3pGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e1529c56-0101-4e4d-a132-08dea7c543c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 21:04:42.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abs9SW58TsGHXCsVanXp/i5mbYEnTCy4xux4AE1+HdwaRaV42VhDTJOLlYTv1+owxHffqtYI0UyxqUaXKK35ilBpmxE/FiyN1FQISdL11jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E2EC14AFAE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242522-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]

On 5/1/2026 1:50 PM, Andrei Vagin wrote:
> 
> This is a different; here, we have two different CPU vendors where XSAVE
> layouts differ. The XSAVE layout itself is not the only reason why migration
> between Intel and AMD cannot work reliably.
When saying CPU A and B, I didn't intend the same vendor but x86 in general.

