Return-Path: <stable+bounces-127449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F40EA797BB
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A8A16F920
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01D1F417E;
	Wed,  2 Apr 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsDBZR6/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC615CD46
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629807; cv=fail; b=tMYVdSLlIENkxrmC+/lzSWXffzOrS2deW7Wimw5u4CUpVI8VLWjHI9m5EeGTXeNOeOrAlamSn2QsgsjownRNK9PtB8P2273lFc2NjADI2WmyF0HWFf0rUonCmjyu3yu44ngr6ysOtB7t4NXidIamdJP+47KIA5Wa5lhEX6HUwjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629807; c=relaxed/simple;
	bh=3teMYADAZq3KoIwvHMfrDhycmB6B98hM011Ydyk/XHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O3sqk631bQiiiWbKYAi3erSY4CZ2sMQgngenT7ZIX/LqehNfVOGMbjrNVpC+srjl8s4FVT2DvlisqeOnJTApvCar9MSOLm1ZZtaXGTO+qFBiQaX2e0/lX20CPNCyvhpjyx6lfUdKq6Iw4SIHLlIDYCOBUNoPRu/b/g1Vy2pgEo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsDBZR6/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743629806; x=1775165806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3teMYADAZq3KoIwvHMfrDhycmB6B98hM011Ydyk/XHM=;
  b=SsDBZR6/n37FUPzeBZDVtXkSW3+uD7y2yEdImPSaAM1tQxwE4lDaYeaa
   R5XJLwV3LmhDFm1GbNX5/uXBCSGmFTQWWDEcqKMKUuqlgyCEt9yoP+oZX
   jd8fpEN9R9uW42lET71OXRP8pggEp1OMSFMvmcFa/BctGY2CxBHm26pvP
   clYh1UkbTSvu/oS+XBi+M14ejqqOoPvKnBQCulPyi8WrHpB5ff3qYPDug
   GPaPApbNgT8pa8muZ0hi3+6DzLGlAqjHt+8OLphIiYwBqpqdxjIt9tVbH
   5soqJjyNTNdl1JI9lX0jUeupeQubamHLNy00je3ZQKfAfrBrVgoY8uXnd
   w==;
X-CSE-ConnectionGUID: e+KzPXhaQqWI61GY+DXgfg==
X-CSE-MsgGUID: LAjpZ8EZRg2B57Nt9kyEHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55682215"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="55682215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:36:45 -0700
X-CSE-ConnectionGUID: EFAhxnrBSXC8elIWjVVsCQ==
X-CSE-MsgGUID: UpfQO0cDQmOAg/hXhaz7Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="127673027"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:36:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 14:36:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 14:36:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 14:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXk2pIhNkNcZJT46w/XdUCrbnDFtrMJ90LZiGubq3FtrGgUSBC35ypf4ZiKYlV1xULGmjkuHOMJoCkquEr8wM4SPqimjbmKMCZaqIzrEhPE/p/dWwKIV4NcK5/XRoRahvYKscuSwNXHtCWe0TIMcSkx1fXe1KbmkYkBDOnNMx+X/l6qp6iMfeW7AUfvHsrucC9vyDg6AekXAsIPjOqHx6J7KHFYK1I7e4Rnmmz2/v7B/icJ2UElQG/vrYc9Kn0L2bXGVIMN0t6DOAtORit32Wx4wuYIf1yWQZZSJc92ZDOevE4UtHYMV7dov/hlHis/lyrGHZSxkXgj0rwVDvqHxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/OkpqNssZURxDPPNzo1YBG7ua5hXIPTh037GCQXkQA=;
 b=EqdLuC20qpCxXemWc2yRX/SVlHYuY3+WnWVoUpbMIcTkC2c1cJL27MBPxpoDz04oKFiqj+5eJ+xbeuZh2UiiavBOeEqiNReblvazDI0Xs5eXo3HEXtos0ASsYSL4z/KvvFsNgP4B9VV5Rng0NCg5eck9VG4KEuQy69Qwifx/5eKXAX1OZKnOdTQcavslN5Ovu8gl8opP2w0Sv62CuLoLM6kroWRSV0+3irtUDuhdsMlrh7W9r2LIvYOsDT1DgraiJJGHQZvllcMZ8Z3BkLga49RfDzEFmKyBXBzw01Wh5XN2JpYIjtjLV0bHZNZTLbuUwhO+tM2eRknNF7UNUKlKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 21:36:41 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 21:36:41 +0000
Date: Wed, 2 Apr 2025 14:36:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Naveen N Rao <naveen.rao@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
CC: Kirill Shutemov <kirill.shutemov@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>, Nikolay Borisov
	<nik.borisov@suse.com>, <stable@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <67edade5e3e6d_1a6d929450@dwillia2-xfh.jf.intel.com.notmuch>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
 <00931e12-4e6a-9ec4-309c-372aaee333b9@amd.com>
 <7cgiqaoeosg3vekjkcm5iorn5djdqbqv3evijgho6tvonzhe2t@jzn56u4ad7v3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7cgiqaoeosg3vekjkcm5iorn5djdqbqv3evijgho6tvonzhe2t@jzn56u4ad7v3>
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: 06007dad-90ae-44c5-8793-08dd722e74ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VfalRPAzOq/Jao3tFlEROwnKD5yI5AT0a1sMTqIATkmFBAEpn4nJzO3ukWT9?=
 =?us-ascii?Q?a+JrHXyEnIeo/72cn5LcIzsoTESY/nw62sLOGCFls7XLTU+cxyXLeJ+qTed7?=
 =?us-ascii?Q?XJDc5fdyrPyMbUt9i1x+3n16gjxIsLrMOgsciw1BrT0NcWQILQhbJuRg6DiC?=
 =?us-ascii?Q?bnAiIHi7gG3d9Cx6W81OIoeU1hayocw0C+v/PPcN/CFdwTHORuWfnviVB4iM?=
 =?us-ascii?Q?/YmlKFAYFlI1jNV/lbUYKHZLmb1uv29BB9rQ3jgn1DZHQHUA71upxt2CO6K1?=
 =?us-ascii?Q?ka/JmR25O5oMrBr+kvlLmeH9aS9IrM2Un/vJUBhKNuNXFihLuu2ty7F+2JF9?=
 =?us-ascii?Q?TFNCEYOpcRJ6Qb3W4vtO0PzPIwyPL07RZTQz/iD+uCJL1zJBIf2Zfdwt9nuQ?=
 =?us-ascii?Q?J1d4EcpVw2Z9UMgB5nV+qlv5AXkEHDO0lO/N+pMuiWiw3+2eOKlJ9mT3ARvC?=
 =?us-ascii?Q?AOJn6B6Gjz70HutnqsDDXpnnynw2fzbIDW+gpoE6HvRlxQsCg3ayEskahD5h?=
 =?us-ascii?Q?0Y1hRcofZclB2laaRdlrR4JqE9GZxuS1YqPwtB8UfXf+3tITkNjR0Bk/l63r?=
 =?us-ascii?Q?XhA8uCRn5z5N2MAVqjdgh6l2GRNGMsMtizlFR58iNaDCk1f16S8eYTstLG/q?=
 =?us-ascii?Q?YzFjOEbZFV+a6KkqASLh+JhTRJViS2n7CqrDdqp3FsCsODGGy40vmh7igerC?=
 =?us-ascii?Q?pvxOxWbWhTxCdkfinkPMijFm7oTNKiRHKyJs1wUf6aUBfmWTfjT5BPfrPVcq?=
 =?us-ascii?Q?7GepUxpMNh8P4drDA4SulhoSOCeRMi2Z5X5vYI2fYlPOdad/UmZrM8IzE6H8?=
 =?us-ascii?Q?Thoj6XjglnV9MkOV6A7JVTMyiEhok+slnHl7SZu0QHJln9qW7AkuILgzPnRc?=
 =?us-ascii?Q?scWGrXH7CNHP4S0iOpPutOjc4M+Nr9GqW9gfPprHx7o6TGoi3YotP19aZh7u?=
 =?us-ascii?Q?xwYvJw0MjQEH+C6jE2QiBZHuZEWRf8OMZgvZD93XVV1E/njRA4/4kXggSU28?=
 =?us-ascii?Q?hg5W5iIXP4AQ0Gkn9SBfh31nVVMQL2+KpL3Hm9eB+8kBLbhOWmoKFzjPq2US?=
 =?us-ascii?Q?KDrbxWMt1rDKv2N5tyw3PRH86+kIyWeILTeifp02NRvP7M6BHOGKy1FCuk/z?=
 =?us-ascii?Q?qvBk3YjYtd1Xag+k6ZSnWBjw8DBXogtBSbemkT1RUgLYfxALk2CPwilw6MQu?=
 =?us-ascii?Q?dNL4pFoHPQcy+EHm8DI01P9GPvrvaZp+zX1BFJeZZy6HwsOe1atM0IwiEoXk?=
 =?us-ascii?Q?e/npo+yL6TeC6KE3Qhsy4ZPEqrqfdTnYit+aNWpkkJ+UYv6G++4lKJwS7/Sy?=
 =?us-ascii?Q?KuYI9p+Y89cekk26UzJuoeetrDKkNM9KNVKqb/0GZPy2gQoXuFFexPl9YH+3?=
 =?us-ascii?Q?3NrbPpHndtTfRBvau79fYtmxWJmHiFe9MV5Mw2qQ1ABsn1o/2PgW/ZyG1m7G?=
 =?us-ascii?Q?QNk5vQSgC38=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7bArfRE0wzkBef859LmqAECo4wQ1sad0ubTsbIGDMgbPb/EVvixQHuGmwdr+?=
 =?us-ascii?Q?GwVJ/RXXDqgNw66wUCizMmwGL70Fw/Ngszp/h5Xh991u6Dko1rcbOIOJP/C6?=
 =?us-ascii?Q?PluaxhRkOyakEBa/iXQ0vNyqZsBeeWB6qWvrhpfqfrWz0JsMTRPU0bFbJyje?=
 =?us-ascii?Q?Li0RzLcuKh0hNXLRSMXkFeuhVX2E6SdK9LjcNjqghHI2A6SJuqRYslSHR0Z8?=
 =?us-ascii?Q?rTWyDtMSaivmFnjgTKTVRU0+OWyZfW7UBd+1qTitDnXJxQVOEubsy4b7Fmv8?=
 =?us-ascii?Q?CeVBSWFc9arbv2QL+JwUFAE6u9UdALVAbgIUiADKve7I8Alpk+2QBsqynUJb?=
 =?us-ascii?Q?Y8VncCUet0kItf4OJHQUD3YWUvTYq9BM73bqLxSr7jYcIaA3OOSKqz2ToZPY?=
 =?us-ascii?Q?RYR2r8+RHpP7/n+QwyqlmVQMjvUUBLvho47Oy4jN0BZGjpRi86hIb6igUBp8?=
 =?us-ascii?Q?0EI2tX2xdeqUK7yfeXi4mByhfh8AAGHEzMg2zis3aZDjM/fkMYLciT8Pfimy?=
 =?us-ascii?Q?h6h8/qCdzWsmU1Zf9eon+8a1zAIVDCCgI7IbaFsnHLE8gWgmmBu5fofPWypD?=
 =?us-ascii?Q?NE9GfV5FV49iUE4N0lHlrMN4sOVIRY/pcB5sNnumDc3oLz+1jAytYe1XZJXi?=
 =?us-ascii?Q?keQANiXOscGPMdFsME5j94YmLjBjInB5CqdENQNntpqGSrn/dgNuooOEVbPm?=
 =?us-ascii?Q?VIyKUsGieLmGDX3kcJxpkE00Q+jHcbzzW4jEPPuC/WrZcTbO/u/zwjJQjQjo?=
 =?us-ascii?Q?Lqg8j/OXxKmS5GO31OlFrA8aywygv0BE+YC/LRlHH6bGANvHlyrWDl1uYOIw?=
 =?us-ascii?Q?qiGOrYd6xjPjwDbA78vGkC9hKSYihF+9bc8YgzM3iUehuakMgMlqJF5mOt5x?=
 =?us-ascii?Q?iGQ8CfSVr1A8pCgI9Ssav2UloD7hMfvMdxmfYjRTJm39cfuDBBzybHRe5vTl?=
 =?us-ascii?Q?ATZU5th6s78CoXsOGDcsnfwUEkI3v0WBH1YAXDkNBDLyId5OsuiPVmffFNdC?=
 =?us-ascii?Q?Y48tz9UY6w4gNhlH2XvlZquBTarEK8xok5OuZZOYHy4hSeYVRzAwurQ7pvzE?=
 =?us-ascii?Q?LDIbu0PIGwDj+DU2fgBAvMkWwoydbwR3eZ9Pp1YN9lOHGXnAiJvRKPhwGri1?=
 =?us-ascii?Q?CXJ4eKua9DHmTPoqSTrj3IdhKWb2GkUp+/Y5mCOiG5W7hKi4Ea2kzVrnCR0C?=
 =?us-ascii?Q?JSOtszEytFIA0P5RuOaE5ppGthzIeJEmnTs+oo4Rx4b2EtYuGZP7UyrwqSrI?=
 =?us-ascii?Q?DVbNYdLizryUMSabvYTtHRQoeZQk7gA8g/4rTtMS1NtwcCPmpglPt/tY3Hmp?=
 =?us-ascii?Q?zpNnbGQu8K+APbuGfO2G8I4960wtIi474Wc8KbTHyLNKDDkcgwkmOCpgmXnC?=
 =?us-ascii?Q?2V8rFE++xLoRhwKq8FifnnLqiFFNZ1FfwjNg46W+EqEdpIIL2/NjDer1/I9E?=
 =?us-ascii?Q?m1huuvQb3bZChffUw8pMcq6aTbxgSlq7/RJWx50XFkOW+WqHg7UN3/KPvHbl?=
 =?us-ascii?Q?XBF2KIILGD5cVz1HMs8n6Ku0odDxtvclcDTpaZlTlkCH5AKXYSsWKHH6rq6R?=
 =?us-ascii?Q?jOBPWFdXeDUWb8BqAW44e4p834+gl3Ppjn68HyJZvnjm0XXdZpUGeNbWu6Vt?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06007dad-90ae-44c5-8793-08dd722e74ef
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 21:36:41.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtmjnoQNK5rM/LZueE08XyTBzh/XjLx59VKX4BEb39HVHwbKAJAUrBdmK85BOooSr2MPcVC7S/VaZg2SjfsUS8YwhHNmSTSarpanRK+L7TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com

Naveen N Rao wrote:
> On Tue, Apr 01, 2025 at 10:07:18AM -0500, Tom Lendacky wrote:
> > On 4/1/25 02:57, Kirill Shutemov wrote:
> > > On Mon, Mar 31, 2025 at 04:14:40PM -0700, Dan Williams wrote:
> > >> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> > >> address space) via /dev/mem results in an SEPT violation.
> > >>
> > >> The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
> > >> unencrypted mapping where the kernel had established an encrypted
> > >> mapping previously.
> > >>
> > >> Teach __ioremap_check_other() that this address space shall always be
> > >> mapped as encrypted as historically it is memory resident data, not MMIO
> > >> with side-effects.
> > > 
> > > I am not sure if all AMD platforms would survive that.
> > > 
> > > Tom?
> > 
> > I haven't tested this, yet, but with SME the BIOS is not encrypted, so
> > that would need an unencrypted mapping.
> > 
> > Could you qualify your mapping with a TDX check? Or can you do something
> > in the /dev/mem support to map appropriately?
> > 
> > I'm adding @Naveen since he is preparing a patch to prevent /dev/mem
> > from accessing ROM areas under SNP as those can trigger #VC for a page
> > that is mapped encrypted but has not been validated. He's looking at
> > possibly adding something to x86_platform_ops that can be overridden.
> > The application would get a bad return code vs an exception.
> 
> The thought with x86_platform_ops was that TDX may want to differ and 
> setup separate ranges to deny access to. For SEV-SNP, we primarily want 
> to disallow the video ROM range at this point. Something like the below.
> 
> If this is not something TDX wants, then we should be able to add a 
> check for SNP in devmem_is_allowed() directly without the 
> x86_platform_ops.

So I think there are 2 problems is a range consistently mapped by early
init code + various ioremap callers, and for encrypted mappings is there
potential unvalidated access that needs to be prevented outright.

The theoretical use case I have in mind is that userspace PCI drivers
have no real reason to be blocked in a confidential VM. Most of the
validation work to transition MMIO from shared to private is driven by
userspace anyway so it is unfortunate that after the end of that
conversion devmem and PCI-sysfs still block mappings.

However, there is no need to do pre-enabling for a theoretical use case.
So I am ok if devmem_is_allowed() globally says no for TVMs and then see
who screams with a practical problem that causes.

