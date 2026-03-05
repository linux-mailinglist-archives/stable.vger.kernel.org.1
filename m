Return-Path: <stable+bounces-223226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM3lFvugqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:27:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89221482B
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 438C53008C06
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F303BA259;
	Thu,  5 Mar 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmlaQ6JQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD633ADA8
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724143; cv=fail; b=FUXRBCSgkv4ynSGP1zZ70r3XDyXOVjit4O7LC+d/S1gOQpx73F6MyaUcKLXhVUMAmmv3i9TFsxj9RizJlEMfZDPnbOP8veNMewGETbmWW9ShBl0FEcrJD99LcfZdlBenT0YlmPoHS5NX6XT9pr+F05oReM4ZKPDme3q8UCByfx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724143; c=relaxed/simple;
	bh=KaUKhrV11lesWNn+3uPas3rbGz09x0K7FCSP8Ghk8mg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4pXrB4/9mAO27S9oLWmpoKtHnnFN7o+NlSu56T3dQpEdtTqej+W/8tEnX6A29PDsGzuCnrBcBL3U9gHGqURwDRWynkNRRTYL1FiozNg4voWVuhqaZfKs5J4gCIscMPkgIBlJG+ouT7o4sTWmo6cYVbCYlCBvL9KsD76GH+sFow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmlaQ6JQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772724141; x=1804260141;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KaUKhrV11lesWNn+3uPas3rbGz09x0K7FCSP8Ghk8mg=;
  b=QmlaQ6JQlVJ92f5h1Fs29GgdfMeUtsbFW9SxUL0JwBoQMEfr0auxB8kp
   QuygnfjYdPtXLygFB1+JtLazfryz2t/cJZWYm6lxsmIuATiAw9F9eqrJ7
   HJ2slFQ8125dwVlGVGVP9Pl5/rOUE65sql4kam9x8UaRyLtT8gx1bbXy9
   WyN7djmy5D/gjPqhB3YOSVjPK6xVBjjzbpEMVoVAbJNhlUMATRiWgozmf
   nPRT03jQ8L44FUQvDz9ZvkzrDKAwswweGAO7LIGLHc69lstwY/QBraC31
   VJZA49ao8s66udWOyzaLrGykaCutgCPHsadK+rZ2wBWj63e0+C04nYmGg
   Q==;
X-CSE-ConnectionGUID: lWHteNXvQMy1nGWJnKRMzg==
X-CSE-MsgGUID: aaINtzCcRLGPzWiRCp9eNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73934515"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="73934515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:22:19 -0800
X-CSE-ConnectionGUID: 5W92gCc/TRan0FavKulZCQ==
X-CSE-MsgGUID: IZApc1tcQh+Y3/w4UZcIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="222860819"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:22:20 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 07:22:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 07:22:19 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 07:22:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYAj7OICtaFP0lNlIOTGyPZxj6xGpRaxqJLi6JZH1XC06kTXKdZvJnQE9o0/yI7xZ5aC944UbhowDOoWP12hPoG8m1UtRABHQ08RwvLgZe/RMc08MQMRxptjjTL++CycQt51i8i4+HYnxkS9hT2d0dCItPQJsDKOS5RnLRRmhc3Opk/Lgqf4niTMvAvMITW7IoNJYkQ9u2SfHDW3VKaKKXIINOrKc3GWZPqQDrZ9kYc0ayhg96AQ8R8hkzfnKBZrlzDgLy9g8nhijZpFjj8cPhK2OH6jqm6M0ohhjXMNwePePZldeM50bpHH6pX9bmJ/EtnKaS5CUuSDlNeYpI7wBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbjtNkuKvf3vVfF2COYBHp4M7iIMmFsL/J8NIwJ/sfU=;
 b=Gh78PvPUngsXoU4flTxaysnPvakaDQrxWnyWn7eketzHHavV8yJLPsaD/QnZnH6xYKI+M+spfPq4fpohQE6KDkUrfyzwmpFHnozH3xH4/04KqeAbWcOU4Wy42l00tWo9caWI05Sa3OVFs598HdiAHvPr8S7AdolwTOcSzu09gUw4dFTDBb8WG13GwfLikOcTRMYZmjrBBEWqJ5UjyOqQfUT/e3AB8PUwVRCIXB731mMaJA7VAWLYWTuDCyScjlAgdJRt8dch2MeHLirCucbunW/ou5m8hj1QiVobHBKQzAycO+L6jOuhugOLGKSQOqrz3HVyousJ3sKegScOPHAUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:22:15 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 15:22:15 +0000
Message-ID: <dd9ab590-f8f7-4979-9bed-30a284eca0ec@intel.com>
Date: Thu, 5 Mar 2026 10:22:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] drm/xe: Open-code GGTT MMIO access protection
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20260224163555.218750-1-zhanjun.dong@intel.com>
 <20260224163555.218750-8-zhanjun.dong@intel.com>
Content-Language: en-US
In-Reply-To: <20260224163555.218750-8-zhanjun.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|PH8PR11MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4724e1a3-2c57-493e-4999-08de7acafb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: j5Q2FMZ7EflTAf4zFvAo91uJcxbS54ivC70zsXRIOE0CXiVxRPW6aHZMmXXjpjHFfjcV93xkLk0ahe+kophb4qrUxALf3xlmY3fZsu3ktl8eGm5k+YsJS+p87vf1LrK/4FAesiztZ5YdHIZqxGCu8Y593yH+15wQhUjPWcVCJuPxaZtu8wAAbAR3FZLch275qEh8UVjVCmvdIgEdqNhMmWG+84mJ6ipM8LsXTH/IYsg8V35S9iA2e/jVAC09I7anldenaA3QEhJJDbxiCMDL68EYTJ23d6JJFmQxkwBMlqKohjmzrDjrl1NbrRtgK3jpjBX9EGmjVAxb7Ly57KKjog/C7xnNjCSfxGTccAIX909abZsIlEIwMCmJOkW9UUazl5Cgn44D59/o4fVCmw4vBlcM4bOIlke6P66w6AFcHad4R2IH7GuCyuNQqYOANNQ9n9IwoWg7OmttEiqnfWRlDB4vVicFr554rtB/pgk7acaKnwi2w3BWJtm/u5wK4K6ENqA7rIxDKN5I7Tx5abKekHG5skQo6HOAfOt/8rLRKzFmhBNltE+5W6XD4d0VEtJcOedIbZjQOz2MZmkteKS5AV5QBdoByOKG15Xd7gA4ntnbzK0BVWZmPQBW+gzhkvf2wcT+4hck20fHCura2+j0S9hxYnHavWWJ4UaPgPJt61fC7bECkBcu6zswiVtPqNRzWeNJo9lu+Gh4fELzkLt/HW6rO1UaTSqtVar5n3a3mN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFTZmsxaUhlNVhwYXdoWnlvOU1ET1drQkU0T0xDcDBuQ1hVU2g1QkhvTE9n?=
 =?utf-8?B?R3dmaHozOWdOSVdDNWVRUGt0MTZKNjE3NFhnUUhKaStzclN1S0RMdkJnbG1y?=
 =?utf-8?B?RXZ3U3pTMG54R2RNd3hiK1hUZksrN0FRc1RKek85b0xoMjUxTktxWWJ6VVhv?=
 =?utf-8?B?cm0wZ1JPSU9PRFB4aTRnZFZXcWRyQW0veUY1bUJXZjRldkhyUExwUVRUSEFz?=
 =?utf-8?B?YzNOSDdwZERxZ3JCb3Jlclk5UXRMeEJkaGZuZkQvSnpFRnFBenVodmswNmF2?=
 =?utf-8?B?U3M3UTdwVzFaT3B0ZEY2R09vL0k2UndNZnRqay9NdVppbFo5d2FvVUN5UVNJ?=
 =?utf-8?B?VDNZMHhNc1BMK2FrMnhXS09mRGp1OGxFTFBVanJZdlJJZ24ydnM5WmpjRG5a?=
 =?utf-8?B?K0NXdDh1WEFKS1BSVGJVcDFVcjg2TTZsTHJPSEY2MVJ0ZFlCckVEUytOOWZU?=
 =?utf-8?B?cGlHT1hnTVU3bEsyME5pbGZoaTBvUDB6VHFiTGpXc1UxZ0tmNDVBMzB0Qjgz?=
 =?utf-8?B?d3Fna09TU1ZLSGJaRFRCTnBlNXFJWEZmQmRyVFp0cFl0djdLWkhQRElyR0kx?=
 =?utf-8?B?bHZwUzlyV0ZqYTJyWkhvUVh1WUlQM2J6MDF5ODUzaUIvQ0ZKQThUOXVlZ1Qv?=
 =?utf-8?B?SERMdVBHRU9jNTJHYUdyMG9MdTN2ZzU3d0VLQ3RUYnVyeUlIdXYyMEhTV1Fr?=
 =?utf-8?B?a0Z4c1dqdEQrYWlibWRoM2VUaDdvQW9jd1NlcVVRR1lueXdHUkwyMW54NmxJ?=
 =?utf-8?B?MXQxeHZub3JBc2JOS2dEaU43RmhsTGh5SVd6THprK3A2TE9IZHRYZmtNbHVn?=
 =?utf-8?B?ajJJd2wzN0JxWkhrVGNRWThwZGJaM0p6K1h6dVM2MXMvRlNFN2NTdzE5cHRq?=
 =?utf-8?B?VVRlY2lFODNCeXFUU1lEV09henlvZTRiU0huU0Z0b0hudDJiM3BDNkgwb1pY?=
 =?utf-8?B?UGdJeXg5THFuU2xIWnA4UHBzUjJLYUF0ajcxTzFHYlBBSXBZaEpIVTFDMExk?=
 =?utf-8?B?bnI1R3NsTHZxQjlJN0xoanhqdGxYNDNORXVhRDk2dldXTFBzTElkWkJuakl2?=
 =?utf-8?B?WGJDeDhBYmlGRmpDWGsycVR2eGI4bkQwZmFaMi94UlpPUjV1UjZHQmFxb1Iv?=
 =?utf-8?B?bGd3enZKdG92emdwZzZqeG9iSzJuOW1yMlY0YkdLY1gzd0lTYmt6MVJCWDIy?=
 =?utf-8?B?SmFnV21sRjJEVFJZRmxudFBIcUxQVGhkdStzeWRPVlAzcTZ0eE8rQlc1dzRN?=
 =?utf-8?B?c0NoUHR4TmhWaHE2cDZnV2U1ZmJuQXZnbVBqT01na3hIdDZwUzZOMWlZb0N0?=
 =?utf-8?B?dGx2UUd4cXBiTzZVYVZDbzR6eGgzM1VNYzQ3VU12WjRoZTJqOUh6ZWU4SVhM?=
 =?utf-8?B?RmNzaVd1RHJzYUFrYlFtZzNMWG5JS0p3ektLNzFPNStKWXJPTmxvdFl3VGEy?=
 =?utf-8?B?dlBqQ1Y1NkhVMEVTbXd2MGJ2OWs5SDEvRHBNNlNIYVQyNUFaRzM5UUNXU1N6?=
 =?utf-8?B?elR5TS9EaUJ1ZFEyNS9CZ1daOGcvS2svS0VjQzBEc3ZYa3htaEJnOURNU3Rs?=
 =?utf-8?B?L2ZGc0Nta1VwYkVueng1enlGWDVPZmFWVGFwLzN5M0pvN01KMWU5TE5tOFk0?=
 =?utf-8?B?cFhlcDM5bVhCTGRGdWFrTjNYaXFmRHM1REZhRGhFMGhHSEozTW4xNDhBd2Rq?=
 =?utf-8?B?TzVrajR2L2wrd1h0blZ1ZGgxVGN6c1d6d0dOa1RrTFRwSFVrQ1ViRCthQWVT?=
 =?utf-8?B?YVpFUFBrV21nWk1tQ1RYVHFXbkJETE9jWVBvTTdFSExkMytQWjl4Nkp3WDNt?=
 =?utf-8?B?emE4d0dvL0JPOE91THE0OTB3YnZUbG9zZFRXYTRSbk9za0diYmEvS3VPMWx1?=
 =?utf-8?B?TkFFcmVlQnhGWEUwWTZacWxPT25sa0lZWVRET3luM1F1eTV0Qmp1eDlqL3Z4?=
 =?utf-8?B?VjAzR2U3T2k5K1I2THRrWGJVcXZSd3BPdHBQOW9HRm94aUVvaUEvK3diNWFm?=
 =?utf-8?B?S25SUWdkdWJhRm1hQTNPZVFjMWllbkszUmt6U3E1U2J0TTkzeEdJbUdCNmNH?=
 =?utf-8?B?VGJsSmc4Ym5ONW5QTVRodWdDdlFIN1RYWHROUnJTcDFVU09tT0UvdHZmalFj?=
 =?utf-8?B?OGtRQ1AxVFlQYTkwWjdVZkUyUXRHRDFhQ0dkWVpQSTVjS0JMWHcweEhCZEdj?=
 =?utf-8?B?RVFTclhaRm13bXIxUjNXWndhTXpSSStzWUR4aEdycnNVSm1kNE9CNUdvaGVM?=
 =?utf-8?B?dHk5RHBjVVUvdUdscXluT0daOUV5VFFhdW9rbS95SFRscDA2eVJ1bVU1WnV4?=
 =?utf-8?B?aXpieXI3ZGt6V2pxMFppbUtsSE5sajJPNzErV09xcFBXNDJ0SW9EQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4724e1a3-2c57-493e-4999-08de7acafb82
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:22:15.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPOOrBRJLgmNTw4bxlv3jtTUMp51Q2DA+IZGtv0J1T0qQ9ZhD8rmcBrSygCzK09xEGtOT+ghxJUT0aDv+v6aSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: EE89221482B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-223226-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

LGTM
Reviewed-by: Zhanjun Dong <zhanjun.dong@intel.com>

On 2026-02-24 11:35 a.m., Zhanjun Dong wrote:
> From: Matthew Brost <matthew.brost@intel.com>
> 
> GGTT MMIO access is currently protected by hotplug (drm_dev_enter),
> which works correctly when the driver loads successfully and is later
> unbound or unloaded. However, if driver load fails, this protection is
> insufficient because drm_dev_unplug() is never called.
> 
> Additionally, devm release functions cannot guarantee that all BOs with
> GGTT mappings are destroyed before the GGTT MMIO region is removed, as
> some BOs may be freed asynchronously by worker threads.
> 
> To address this, introduce an open-coded flag, protected by the GGTT
> lock, that guards GGTT MMIO access. The flag is cleared during the
> dev_fini_ggtt devm release function to ensure MMIO access is disabled
> once teardown begins.
> 
> Cc: stable@vger.kernel.org
> Fixes: 919bb54e989c ("drm/xe: Fix missing runtime outer protection for ggtt_remove_node")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_ggtt.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> index 79310f565fe3..cf3311f5d140 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.c
> +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> @@ -66,6 +66,9 @@
>    * give us the correct placement for free.
>    */
>   
> +#define XE_GGTT_FLAGS_64K	BIT(0)
> +#define XE_GGTT_FLAGS_ONLINE	BIT(1)
> +
>   /**
>    * struct xe_ggtt_node - A node in GGTT.
>    *
> @@ -117,6 +120,8 @@ struct xe_ggtt {
>   	 * @flags: Flags for this GGTT
>   	 * Acceptable flags:
>   	 * - %XE_GGTT_FLAGS_64K - if PTE size is 64K. Otherwise, regular is 4K.
> +	 * - %XE_GGTT_FLAGS_ONLINE - is GGTT online, protected by ggtt->lock
> +	 *   after init
>   	 */
>   	unsigned int flags;
>   	/** @scratch: Internal object allocation used as a scratch page */
> @@ -367,6 +372,8 @@ static void dev_fini_ggtt(void *arg)
>   {
>   	struct xe_ggtt *ggtt = arg;
>   
> +	scoped_guard(mutex, &ggtt->lock)
> +		ggtt->flags &= ~XE_GGTT_FLAGS_ONLINE;
>   	drain_workqueue(ggtt->wq);
>   }
>   
> @@ -437,6 +444,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
>   	if (err)
>   		return err;
>   
> +	ggtt->flags |= XE_GGTT_FLAGS_ONLINE;
>   	return devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
>   }
>   ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
> @@ -465,13 +473,10 @@ static void ggtt_node_fini(struct xe_ggtt_node *node)
>   static void ggtt_node_remove(struct xe_ggtt_node *node)
>   {
>   	struct xe_ggtt *ggtt = node->ggtt;
> -	struct xe_device *xe = tile_to_xe(ggtt->tile);
>   	bool bound;
> -	int idx;
> -
> -	bound = drm_dev_enter(&xe->drm, &idx);
>   
>   	mutex_lock(&ggtt->lock);
> +	bound = ggtt->flags & XE_GGTT_FLAGS_ONLINE;
>   	if (bound)
>   		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
>   	drm_mm_remove_node(&node->base);
> @@ -484,8 +489,6 @@ static void ggtt_node_remove(struct xe_ggtt_node *node)
>   	if (node->invalidate_on_remove)
>   		xe_ggtt_invalidate(ggtt);
>   
> -	drm_dev_exit(idx);
> -
>   free_node:
>   	ggtt_node_fini(node);
>   }


