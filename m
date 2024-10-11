Return-Path: <stable+bounces-83462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716EF99A5D9
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FC2828D4
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7F219CB5;
	Fri, 11 Oct 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOKj3Znj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AA219C94
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655819; cv=fail; b=CbLjwxbJ/RrkcQ7KNn7RZjfH3bIk0GRSQDtMuONATz43HUbp6aZUjXeQEM5kJwRi+R4oOSA83SRv+Qov9aq3n73VwOeR2K66JTzn0VMw5rh/sT8KV9M/qfve2DQPCfp2sxgyAYuYRYzVArUDHW8S1xwg0sPHrTESLIHunnGZ+4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655819; c=relaxed/simple;
	bh=Y+0sGZNmFqcd/a0eHvqM9iCdbFt4pyRZK8PwCGgUXeI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AifR9Z9QnaFq9WLcz29T1Js4zkua1+MuNt8F5jFvgbZc/HHfiGltNbO7gtuPh29JvO7JzkI+tD6LJ23OqSWIfl5cSQ0CC773dpvSaFv9JFVKomTy3xJ+O3Hx1EEny99I6DC8kmNyTklwZGh5U9km5wsMmuwHW+C23XcA/UIfXhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOKj3Znj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728655818; x=1760191818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y+0sGZNmFqcd/a0eHvqM9iCdbFt4pyRZK8PwCGgUXeI=;
  b=AOKj3ZnjtFkpfP94/xkyXAZgOUycEX5tnYWV9sftmO+7zw1bTr8L4lTd
   x8HuhGXMw72bgIRgzsLBOJfvJk5aH3MZInTXUMNv7gXY+6YL350cWY6Jv
   UpANR3UaOs+jNQBQwEdP5IKNEZZM50AUUHMortVFzVA/R5DiNZj6Qv5YI
   R9wP7z0CaybAhTLsqMBOe7tFYRevTRFAlqOPgXAURWsbULyIeocxIDeSe
   UakvJhQgr5X6AQnjSHV1os4KZbaTtkyhswRN9793j5kKSZjiZ7m7ZdEki
   d6q2dn//bx36OMDt1157vQjzRt9x9Qs76mWddunVyN08HYM4DTzFaumNh
   A==;
X-CSE-ConnectionGUID: AoztEMIOSnGLvnbrDllJHA==
X-CSE-MsgGUID: tqfVle3ET3+rBDW+Ms3YAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53461532"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="53461532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:10:12 -0700
X-CSE-ConnectionGUID: a1F3K0foQy29IReTI2gPyw==
X-CSE-MsgGUID: qViGdpcvRYiezgXIh8r0xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77737059"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 07:10:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:10:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 07:10:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 07:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZzIPE+gAMth+I7TBP0ebHlTkLhUa4SyR3hbFCWqik2ZQnK2GLgxJvtRmoLX2XwRiUUMyuF25gKojHAEZKCyBv2KPybMiCywnox0N31PPIDCDSQziGA3S6Q+ryREsJDC9+icvOdpXE25V2x2OsADMv2S54/rILtvD/81mrbo17c8huaBGrqb9F4XiGANXeJHM8E0uX3X4QCj+YruvwJE4Nr3dGc6HSV0yoDH2q99n9ou9lgdXhbWVb5+CZqqQabJC3Lb2+0c9FoMLS75JdbBZUVEHW+2ehR5n/hRZQtE+Qejczfj1mFomAb81QojWNcGR7HVGThIuK+o0CkVfIcBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8WR9P797P+3j4RZ0AbnqEZ6olbEHDXSIR6A80VxaVs=;
 b=Ba1xnA47Jk8N/1Yod0aK7ddbc0yMbo84JyjXkYok2pKC34MTT7cqbZrx3XqZxZT5zDtZ8cLIWHBzathLKmBdileJcM/WAHwBAZEyPbqyhTDmggyldC7RrbDNuMLKJ4T1OM2p7VwFKfNDwjHwznR4Mn0zcOKGR0kyJW0nSehPMNgjbGh7ynEHA7qTXjpPSNXuEglyKfgaAk8ejzmme1eAtHDVMVqtuJk5TACOba0g6NJWV4HUXXviduRNEoV6+5SITfnPR9GHAuRo7Xt/jW4pip5Z0Cjis4+gKF48P+ZL59t2Fh8zEBMOYtmatts6+zgwupYiOq9FgDfo0rxBTUCbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:10:05 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 14:10:05 +0000
Message-ID: <07151ff0-90b1-4ec8-9f64-f695fb411dbf@intel.com>
Date: Fri, 11 Oct 2024 16:10:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/ufence: ufence can be signaled right after
 wait_woken
To: <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Bommu Krishnaiah <krishnaiah.bommu@intel.com>,
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost
	<matthew.brost@intel.com>
References: <20241011132532.3845488-1-nirmoy.das@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <20241011132532.3845488-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To DS0PR11MB6541.namprd11.prod.outlook.com
 (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f09ac51-d4cf-4d66-d5b0-08dce9fe67f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1RLdmZXWmJaNTFVcTYvR2xiWUhaWEowTXMvOS9pbS9TdVhxUXZkTGxTdWY2?=
 =?utf-8?B?UE9nRkFlcXU1MUd1THhDS1BFUkNKOEU5d01kMHVJRldSOTBNN3ZzT2c3eWtT?=
 =?utf-8?B?YnVpOUNTSmpybjFHVDNrczh1TTNSREZEc1A5dlhoUGxLWmtiTndEdUJmc2ha?=
 =?utf-8?B?enlvVEFIemkrUjZWeWRVQ3NicFhEWjB2cjRhR0ZFUnh4Q0dKZE4vZDRtd3FH?=
 =?utf-8?B?dWxtM00yWG1LTyt0Z1RGTkI0WVlmQmQ1M1AyRExKSzY2OTlnUG9LbkFaZXRv?=
 =?utf-8?B?OENNb2svTVB3NG51a2lHaDczMEdCN0dFQmk3OXRwVkZsQXljbGlSQncxQklz?=
 =?utf-8?B?V3NSVFZMaGl0cytScE5pRitXWkp1dzI2aXkzaWFEZHM1STFJTjRGdUIxZmRX?=
 =?utf-8?B?WFpqb0I4eGpoT3V0bTNLbUQ0T2t6QjQxVGhxYktXRTlzYmFKNHBsN09GVFdY?=
 =?utf-8?B?ZUNCMU02RGlCWjNBSWltT3pWVTdIOXY4WFFrT1dTa2VGcDR2dlpVUVk1Uysv?=
 =?utf-8?B?RWVrUk83eStMTHhnc2EwSENhZzRJRkd5Z2RMaWR2aTIxZ2RUeFVseW53ZzVJ?=
 =?utf-8?B?U0w2UW5kajA1QkdidnhKLzI4dWUzd1U1K0tBV1ZSWXNpRlQ3S1NzemxKRjY0?=
 =?utf-8?B?SU11MWdnZzQvVW1KdU9BRjBsNjZtTmxseVZ1VzBEYjdERE5HLzlBSHVObWd6?=
 =?utf-8?B?SUx3VUl0RkRUN0htbWJqQmk4UGx6clhwWllvYjFQL0JoRk9UWCsvNkxpNk5V?=
 =?utf-8?B?UmdqNFVNY2VQZlJGOTNMT2RGWkpIbi9DY3EybUhqTXFsRXFlay80QzR6YzA2?=
 =?utf-8?B?UmtZdEIyS2MwUjMwTlNIRXNjRmVSZUJ3dmFOS2JwY0R5M2twMFBJcDNRY2dY?=
 =?utf-8?B?Z1h0Sm9oNE00ajV0ZUFRTHlqVWFBaTVQQ3dlYVV4cW8raVppK2NNWjVreGNp?=
 =?utf-8?B?OGpXdTJzUmZVUC83Wk9FSkllbjA0aDZ0VW44b2dKOXpkNzZwWWU4NktQRVdo?=
 =?utf-8?B?ZEJ2VEtXVlpaNUFwbFlRTXcxSHpqSFd3aktiRTQ2OFVheU1ubG5CRW4rMzF1?=
 =?utf-8?B?eFFGa3hzek9LYXpEc2N6Mks5NkJFd0tsWVhsWGJueUNjZ1Yrckc2VFlqLzRv?=
 =?utf-8?B?blp6aThMd25KVzBuQmRwenJlaGFtblp2M3VsU3E1bWJHOXVTamJQSitpeVov?=
 =?utf-8?B?aWVkSW1WbkJKVkFSeWZNakxPYmJmYzVVbzZvMENOUTVrMTFoT2RIazVsTFlF?=
 =?utf-8?B?dEwxbFVHeU44WFFjOXlCMnoycGFsdUZ1NnVnS1lFZTJTME1iTnd4VDkwcHBK?=
 =?utf-8?B?YUZnZER6Sk5QU1UwSld5TzRaMHVRNThraFczODRobzMrZ3NxQU45dU40VjVn?=
 =?utf-8?B?Z2w0d2F0VDBvakIxQjJvWkxGVmhWRXQyMFRXdjh1eVBVY2c3bFVINE1JVnhL?=
 =?utf-8?B?WHo1Qi9FbUIwTHh6T28wUXl0aHVWSUFzMzdQYXJnaDJKaVJGTlJPTmp5Ukh6?=
 =?utf-8?B?aHhnY2l0YmxBTnlvN3pIQkJBREoxekIxRkZkdVJ6c3hmb1o0ZFBLOG1IM0xD?=
 =?utf-8?B?UHRHeFJKa0x1NGVHRENOWGFranhjS29DOTRNcG1GcE1iYWZRVCtLdlZaQ1FR?=
 =?utf-8?Q?Qe26X3JZ7+hRW28PQ/nQDp/1SXFE2cUMe2BD6qXr6Ft8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dCSG1reC8xSkIvZHd4RFp3UVN3ZUFkS0w3TTJwRzcvZjVFR0g5aVZRYm1o?=
 =?utf-8?B?a1pUS21Zd1VSQmFmQUM2b3V5NEMzV040dlczS3Mrb2JLWGkydHhvOFRhU3Z5?=
 =?utf-8?B?NG83bDVnZjVOeVY2czVoczQ0alVpaWlKY054QnE3cUptZFlNckhBQU1aeDF0?=
 =?utf-8?B?aGRZTDQrWUJwWGZtd0RwSmhnOHNDdExRNmNyNWR6SmJtb0tMNTR3ZTlPeXJX?=
 =?utf-8?B?YUtjTStuR0dMOXYzVkY2djBNQXk3R3NlRzlyV2UxQmdaOEhCTDBjSlkwNEk0?=
 =?utf-8?B?WmJyMnBSRUdYMWJ2cWVLQVYxT3NFOHJGMG1rZ28yVnZOY0JEQnZBNys2cDBW?=
 =?utf-8?B?RkUyQTFwSDRMN28wVlAxb2JCUGZTTjNmYUY0TDhnSlUxUlFBckI5RzVBUHJ6?=
 =?utf-8?B?bVhrdnk1Q2lDNUQxZGEvRTVpMzVTWXIwemF5MHFwTTcwdGdrMHQyMFdIdmNu?=
 =?utf-8?B?R2N5UlZXVVU2eWh0YUhpUjd3V1dzMDd6K1JvVjZrRlp1ekxLa0JvRHczQ2NP?=
 =?utf-8?B?RnR1emZKTHRIcWFydjMrTmhkQzlDS1Z6TlVjREF4YnROV3B5eExJM1RTa2dx?=
 =?utf-8?B?ekQvemRHV0c1ZnVlWE9RUUdyQ2tLWlFtTjJKcTBJcWt2ZXl1RWhORFdnTmVh?=
 =?utf-8?B?WjV3eWlWaTdrTmtwL2Y0WVZMMy9sMThwR1pLUUYxMW1EMlNyUmcxbTVPeVNX?=
 =?utf-8?B?bE5MVDl3Wm9DenhlNllBZFpDT1VWWHArd2UrWHR2MFhWS0w0Z2YzbktpTU9n?=
 =?utf-8?B?cUFHNWRKR29PeFdHVldQQmtiMUYvTlNBQWYvdlJJSE9RSjNwY3NiQkZ3S1ds?=
 =?utf-8?B?YmM1dkZUNDM0MncxajNRS2lLVmtBS2pBUzZaeDh5ajhvWC9aOVBaZXM2czA4?=
 =?utf-8?B?UGFZaXhMdGdmaVZEeS92Q3NSNVBPSFhRNXFmYmdlK3RDcllOcmJVMTA4SVI0?=
 =?utf-8?B?SlNESys5eGI0dmxPclQ3cmhSWVJubDFRQzBtMk1Jb2dpWStpSUdHeTBqQk1G?=
 =?utf-8?B?dFUrMEV3Z3NYbWkwWTdkdU9IK0xMSFl4RnJVY0dJVmt2WGhDWFBiTWxzUjkw?=
 =?utf-8?B?aEFsYnlOc2hnd0V4L1NLMytiUHMzZUd5YS8yMjI3Z0tPdGd0eVozMU4vWWR3?=
 =?utf-8?B?czh4aUZNWnhadlUzUVR3QTNmb2J2eUtRbldxVk1BUjVKaFhRZUVmd2VEUTB3?=
 =?utf-8?B?TCtLSSsxb2tPQlhPZG03OEhyOTd5ajFYWEJZQUdPOWxpQjhmVldNT3p1b3NC?=
 =?utf-8?B?d0YyYWRsWWJSTHdxTmhtc05sNllremYwOFV5TUt0ZzRZWi9VMGNmTFdxaVVx?=
 =?utf-8?B?N3FmTTlVcHFBYzAwSURrKytPa2EwUCswNnJDMGdGVXRVU3ZZTWdHTlJsb2J6?=
 =?utf-8?B?Z3ZwaXdrZ2I1Mm9wREVDR0VLWml6VWExcDJIY05KMlBjR0dLYmRkT2xUQ0Qr?=
 =?utf-8?B?ZlZnbG93aEVzaW55dE4vZjdsekhSa2lYOTd2TmJhajA3a0VzVjh3SCtOWVM4?=
 =?utf-8?B?V1VhYkY0N0NDUTdteUwvZU0xNXZmdkZFSklLNkpJSk1GbnVYcUNaREZyM28v?=
 =?utf-8?B?REtseE81bzB5VDhJT1NjMkYxbS9aenRoVFNxYWVzOVNmbS9veFdNUGlpeXcy?=
 =?utf-8?B?d2tHN3YvelRQVjdBSVhuV0tTSTJ6V0g5a1ZCOUs0VmM1WFp1RkhJN2NrS0h4?=
 =?utf-8?B?dEFCTHA4N0FrczlnUURxTTFKMnJWejE4U1ZlZ2F4TGU1UnBLTU9STjVIcUM1?=
 =?utf-8?B?YnhsMFFSRkdhVUMwOXpFbWZqNG51MzZOQ3U3Q1hjTEx2dW5aTmp2K0lsUE90?=
 =?utf-8?B?dzFyT01lY2NkamJsaTZLaWU3VUV5MlRJdGdCTHhxTktlY2hUa1hwK0VqWEpu?=
 =?utf-8?B?QnZ1UlpZOTcxSGc2TE0wOGZVWjJkdUh1cE9nM1pEdEdJVmpvZ2JrQjljN0g1?=
 =?utf-8?B?OWdxSEJ0c0ZEVHRrWnFNUEdpOXgvaTNnTmo3Q3B0UUdpdHNndzZNWk96N0xn?=
 =?utf-8?B?WmFrR2tVNUhyaEh2dS80UW96YkVHL1hIdWVmaGM5UkJwNm13UFJHNUpLT2hL?=
 =?utf-8?B?UU9TcVNBTm80NTllaHk0RDd2T2lJUzQyRHZwem9sVXU1U2lpZnQ5MWJTRmQx?=
 =?utf-8?Q?CZhZU6WLfKjThQq7NIbr1LBIg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f09ac51-d4cf-4d66-d5b0-08dce9fe67f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:10:05.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPSXJJ+MhuKUNwP39htHcA7P/DWtXbw9eRqy2r24FW/zkXGB1a6pgjmEQvNEayJQgWiXK0KTjTIpj+DmPAIPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com


On 10/11/2024 3:25 PM, Nirmoy Das wrote:
> do_comapre() can return success after wait_woken() which is treated as
> -ETIME here.

s/after wait_woken()/after timedout wait_woken()

I will resend with that change.

>
> Fixes: e670f0b4ef24 ("drm/xe/uapi: Return correct error code for xe_wait_user_fence_ioctl")
> Cc: <stable@vger.kernel.org> # v6.8+
> Cc: Bommu Krishnaiah <krishnaiah.bommu@intel.com>
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_wait_user_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> index d46fa8374980..d532283d4aa3 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -169,7 +169,7 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>  			args->timeout = 0;
>  	}
>  
> -	if (!timeout && !(err < 0))
> +	if (!timeout && err < 0)
>  		err = -ETIME;
>  
>  	if (q)

