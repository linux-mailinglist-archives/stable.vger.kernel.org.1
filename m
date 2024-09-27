Return-Path: <stable+bounces-78160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9AB988B91
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCDDB2173D
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B01C32F8;
	Fri, 27 Sep 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDol2Rad"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E346188CC1;
	Fri, 27 Sep 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470364; cv=fail; b=msW39eOmw8szgklX5U85D+dfcC/d2qpAZvbgUxLl3Wll/TKvUnu0dp9CBRzNlO+S3anTXI+1/FZYkCgKvd0HiyXOl78ik1p4KYMm/jRc/bM46DixvF04dU+JA+h9nqyf1uBMvxQIeMQ972rHNZAbMDCeG6M9YQbx+b5O6GKQEQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470364; c=relaxed/simple;
	bh=5ywvQj7rH+aLzvOZl+v3MgF/YDKObjDHTR76jCvVEsw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxNs1W4iZn/sDsyygxxYRTWj9qHs6IRx6B9PU8svkm3cymhcu8BpGi+WQpHCZ42O5uglShie+8msC+f1vHnLlwZscFmYi+2/21q4qsfgZnMFzDRCz3XFvSi9UtQR83mQQH8zW8eKqnXQj1plbWd/oj3xIi4guOl3+GScTMNT9VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDol2Rad; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727470363; x=1759006363;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5ywvQj7rH+aLzvOZl+v3MgF/YDKObjDHTR76jCvVEsw=;
  b=aDol2RaduzTFPUEO5B5CcKaLRb6TEFElQ7pnv7ayi6CfdjIVVLvtoquM
   Cl10aQ6BhTKG3j9cz3b4c2pKURvMQuEFpNLpeenJ0iU3+jm3XTfYyJLYt
   mhCdIPsIxCmOp2IMbCnfrzLi1sgXgRreRqX5LPDASUk2gpZQqoCEoel+3
   6ZomGvedIZm2dbpoR1gi5IS0fBfWvAKxbd5wU9I3lBGh5bFQoU51rxZ2x
   blWS63lmIKJg9dhUdEBGp/2m/nKYDLT+LEQ+Ncz94xJzcNSJk01o+JP0O
   87cGCEdanoAbA9EwAyNk7SMJlziR363dheP6pWjbEIsTDqreq5bY4R7Ov
   g==;
X-CSE-ConnectionGUID: HuwAvz0VSgWt2XQLdoTsqw==
X-CSE-MsgGUID: XO8J46+EQrOyRfeJB7tnVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26759885"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="26759885"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 13:52:43 -0700
X-CSE-ConnectionGUID: MyaqfEtkRE+BExgNYngDJw==
X-CSE-MsgGUID: /DAowAMkSD+ce8HvlBiW5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="72324653"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 13:52:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 13:52:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 13:52:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 13:52:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 13:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX7RHhyCnLlbnhzZLNqeihYEcWypj08Jpao+9YIV3EEL/PiOnQVJLvOpQ/VrnG1UZJi9JD5unRRPrXjewxqymvy5G3T9NK/rC126yxO4SmEmo6t9+V80ixi8TZ6v5Sni85fDV+wLIRQwd/1neckVv0N32Ti/hDzmy9zSwK3H5zW/vH76AhyKDbDRrDyCnnh2yxWH3h+NFd5P9tRE2oL6DlPx6dcblJYei81PmcM5odE9BBeIxbKoqWIj5Fxx73PC8mflemdJnBxBnHaTo/fsmlniZ2x9spqhNugowV636BdDS0WoUmkwa3AM1MYWFmJoriUNTsoFzq0hMABt5umMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9BskF0fyDWA1a14eyuKcaPYZN8AjfBlu6nqhlZ2+tI=;
 b=ItXvKtIqGkfmt4GJlh1EV1YKc6/3s/ki+mL/Hut4/L+fNd6l6oUVkmjlzyAng9M1YvJOoJX82gBRUDgKub7cxkpT/m8K+MXR9q2hiQdMGw5D3pS1sib2SHXjApVxOHPcJ6dIU+qRU4h8Z9p192B43doZkAHlZS3dCrXVDxNB2FBI2RCSlEJN42uvPyctXe1a0GqoKjhfhCIij/Z7JHnHpSfSZRAynMRMEQEpSwkkPPhfrOhwCX9LoQKyMLW9oKHOljNX7plWM01gQEPHn6DOUyNjdfNyc5da6B4wkFMsuI4CuaHdDIE7y062pnG7n3ztkZFNf4a4pXTLRsnC7PwnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 20:52:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 20:52:39 +0000
Date: Fri, 27 Sep 2024 13:52:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Linux regression tracking (Thorsten Leemhuis)"
	<regressions@leemhuis.info>, Dan Williams <dan.j.williams@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>
CC: LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, <tools@kernel.org>
Subject: Re: [regression] frozen usb mouse pointer at boot
Message-ID: <66f71b1452d7a_964f22940@dwillia2-xfh.jf.intel.com.notmuch>
References: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>
 <2024091128-imperial-purchase-f5e7@gregkh>
 <66ef853de5f16_10a0a2946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <66f229fc4daa9_2a86294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <38620c47-62ea-40b6-a7b3-afee9a3238a3@leemhuis.info>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38620c47-62ea-40b6-a7b3-afee9a3238a3@leemhuis.info>
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b610b3-4aa1-4969-22b9-08dcdf3652ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDJYVytla3daWGRVTk1iSmcwRVRkcG1NUGZEM3dxcmtIOHNjdWVwV2NyVGVk?=
 =?utf-8?B?cFNSbzd3R1BoZ1E2Unhjbm5qRFZySzdXQStrSmY5d2IrWExmdFhvamhrMVJ3?=
 =?utf-8?B?cTJZM2hrcm9CdlJkUVRCMlMxMys3NmE5dXlsdjVUYjFXTkFQRHdaL1k5cUlO?=
 =?utf-8?B?d2FTbVBraGcxc3BlMk5nSDJ0Y0lHN3M4SUwzUFNyckV3UVJUcHdDaUl3ZEdl?=
 =?utf-8?B?aHNKYWdnY21vUzc2Mks5OUFvVnBSSWI1dVNNaG82K0wzenZ2OVE1R00rdGQ4?=
 =?utf-8?B?amRkQUg4Ry8ySWlYa0xvSjdCdEhUY0RnTHBTdm4zcGsvaEFPYlJxelFOUG9n?=
 =?utf-8?B?Q1lSQTFFN2laYjladnJqT3hSUDlSYkpDK2pHSmhlWTFLbXYzSlRVWTY5elNn?=
 =?utf-8?B?UEFOdGFqVGNGbnBYQi9FUTVBNlFwYUJpbmZQN3k4aFlyVk8zam1lVkE2SDVI?=
 =?utf-8?B?S3pIUm1WUnJ2aHZHWGMxcEtsQnk0YXd3Nm1kaFp2RHdFTVVTcGN4Wm5HWWVo?=
 =?utf-8?B?VHBqZlhYZWV3eUhWdzhidFFWL21BZ0JsODlGVDE1MzNPVm1SSFI3MlYzK0JZ?=
 =?utf-8?B?cGxUZ2NvM0RQbzFiUFFKbU82dEZUazZmSjNBazlnTWxiR215VjZxMnBDNzhi?=
 =?utf-8?B?NkJ4NVJCYnJiTWtnUDZkaC9uQ3JLWEI4U0lWa1hhamdsWWp6MCt4SFd0RHlo?=
 =?utf-8?B?ZGxJTnlsZGU3SlQ2TUhhMnY0Z2QvalZFRGRJcmtpRWJNVURyNWdQb2pjQXpl?=
 =?utf-8?B?YzZ2dWtKTGgrTXpxSXF5M05mdGZvVktGSk1UZ25GWERaeUJlc0Fwd3FoeUF6?=
 =?utf-8?B?RDdWU044a3VaazE5MENtazdPOWRqemthQjBTQndySnVtTlFnd2t6aERFZU9P?=
 =?utf-8?B?akNqY3FqNTM4L1NEcmFKLzV4aGRreHdTMVFmU0xkUjQ3MXNCZVh3U0EwSFRw?=
 =?utf-8?B?WjNWQXJNYU1vUTI5aUdyeW9LZDMwZmRVdzRJSExjblZRdVB4Mld0MUdUYVoz?=
 =?utf-8?B?cWZjamZCRzVOcjFmSVVaeGgrUGUyQ1Z1ckpBZFBrMWpCTTJHTXhON0I4cnBF?=
 =?utf-8?B?bzhGYjBGWjBqT0xpR05CNjVzcW96NHIwVjdRdGd1Z3hTYWZGQ0ZRdWRrcStX?=
 =?utf-8?B?VjdvdnNORWMxQXhHSmdDaG5uUlVmWkpaZ3l5Z3AwVER4UndSeTU0VWRRaHVC?=
 =?utf-8?B?bFhzdlB3b3BjSE9QMGxieXYvcmg0MEV0MWhJbTNiMzJvVnF4S2V6V2NhODg0?=
 =?utf-8?B?TnNYajZmWU9IQSt5OGdDcVoxbjltcm5KWmMzNXRTUHp4VFdOVkZWSXhtdVdJ?=
 =?utf-8?B?Q2QzVW9uTm4zSVFSNGczTWdXcnNjU1hxNERxN3NnQWZNRUFrYXEzcFVjSncy?=
 =?utf-8?B?dzJ1NlVBSlJNdHREczhaZ1hDL3g1eS9GNGw4Z09kR1EzSERmOXJKZ01wRHlr?=
 =?utf-8?B?NnhodGVEakFHbGREd2ZhSzhGRUxLTVN4RnBzQ0hQNy85Tk5XKzMxZTJML25l?=
 =?utf-8?B?YzEwK0xMenQ4RittZWMvWDczM2tTQ1RHWWFGSUkxWWZOOUsrbGY4aHgrZSta?=
 =?utf-8?B?WDZ2dXdsa1Y4SjByNDJoL2NwYVMrVWJ6MDJnd0pyQ0pJT3dlWVhzaGtqSGNa?=
 =?utf-8?B?TkpmUXluL1NkZlZyRFJlVXgyODhjb044SnFhalVkYnlOcURoV0IvQm5jeWFl?=
 =?utf-8?B?ZFJYT1Z6TkQyYUtGdUVnUnBTYnhFSENiU0pWS1pOU2VvemdkR3lOaitnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVldDRpVGVIb2hGalVRZDVXTGNzeVozYXQzY3BYTExJaEhMOFlydnc5YmJI?=
 =?utf-8?B?NDh5YU5WYTF2SEZ5ME1QQURBUi9wWm1kWWZDYXFhRyt6aXk1QVV6NXdOeHNr?=
 =?utf-8?B?R3VKTHh5NXp4K24yS1pnUVpvOHBVUVVEcXdsL0U4ZXBhbVZNNjFpYXpCT1Zy?=
 =?utf-8?B?VlZTbHNVQ1NDTzlsb0F4QmpZeU03MG9GSXJxcVBRV0JWdVhzcHdoTWZQa0dl?=
 =?utf-8?B?bG0wNkM0TlpsWWdPWFNkVGpJNzJKYmoydUc3djkxUHJHbW9VN0JvOURrcUNU?=
 =?utf-8?B?YVVlRjlkSmtqU1FUSWZZOXc3V3laRythTFZrRVNLb1BEclF4YTh4dW5idUVW?=
 =?utf-8?B?NnBCM0ZqZW1HOEFWVXRBNnFFdExGellPRTJSK2xZaHBaY2hXSFZKdGE0UzNU?=
 =?utf-8?B?REJtNW90NnBBQ2hlT0xIT2t3U05sRXA3TzBzWjZ1UnlOdkJGUTJjcVNLWGw2?=
 =?utf-8?B?b0hibkg0M29XTDdNLzNwcmlmOE9aNWdrSzIxdnRqeE1VSmlZbHZ0U2JjdTFY?=
 =?utf-8?B?bjQ0N3hCYkFOUlJaNjc5SXZmNVRsdXdvaTU5eDhzUlg1ME1Wb0ZpNytYdzda?=
 =?utf-8?B?Wm9HUk0wUndhWUw2cjZrOHhESjhiZmpYZTdyQUk1TFNDdWV1RjcrSlUrcUpu?=
 =?utf-8?B?eDBYeXpnNnN2SWMxeFpLOGxTcEtIUUpmMnJJcjFVeWJnSWZUUmhhUlByYXJn?=
 =?utf-8?B?Znh0blVlUTg5bjRrb29hZ2pWeXJNYU9TbnVjRFFieUJWbmZId2hWcHVOUm9r?=
 =?utf-8?B?K3Mvd3dueVI5U0szeklaeGFlL0hqTnkwbVdhOTZtYXVJdmEzMmc0bnkrcGx1?=
 =?utf-8?B?MUpTNGpaUzJlZkQ4Nmo3S2c0amZpVzQ4SU1wTW4ybi9pY1FPdHRjZmM0ayt3?=
 =?utf-8?B?SXdIN0ZiTzZTcUtqMWIza2tyODdTNjVCRXlLbmhQR2FJdzhKZ3A0WDFxQUdZ?=
 =?utf-8?B?YkJMa05HRURiSU9NdDFrdzc3WjdTYmhvdS9RN0ZkZVpwTElqVDhDc0hlNnJT?=
 =?utf-8?B?MlVOZVl1bzJrRzVyQnJJUWlET0NxN2UxejJNTnZMU09ySC9JUWkzVnRCMEpO?=
 =?utf-8?B?bUhlSElKY2ExY3pFM3FLNGZzYm9kZVFydnd3Z3R3WFhLZWNGYUp4SUFTaEZX?=
 =?utf-8?B?MjJHZFBFVVFRcFMrdUllaVhJdmZRUFR1TUZVZFhuYlhvaHhxT0xrTjlkS1pD?=
 =?utf-8?B?eVlIdzlMNmRTQmNaWm9GbXMwNTh3bEpQVVpCZklWQ3U5YUg0d0E0QmxtbDBG?=
 =?utf-8?B?UUJnMHdPL200bWRTejdHVmZmK1N1TklnM0ZTR2ZxOExJM0drdkJIMzhZRXlu?=
 =?utf-8?B?VW43aE5nTldhb3IrOTkvWUFVaE8yb2ZhOTEwbVkvd0lOdDJCcUJpZEk2Rm5s?=
 =?utf-8?B?b2MzdU1KdjdNc1EyZlBhNHB4MHBqS0ZyTDRiOVVJeldSZnVDZ2FPU09sSUx5?=
 =?utf-8?B?b08za2NCdi9xem1UREZQczV6NEc5R1poTE1vM0FhcVNmY3dKRWd5TUdMaytG?=
 =?utf-8?B?ME54eFVvdjUzdXI3V0NkeGg4K2xRVlBEZHZ0aE1JYUpVUExISTVoUFFJZ09T?=
 =?utf-8?B?dFF1bGFqNVdBTGhFMnpDUWhvT2Jic1NtNDlEVTBpZmYrTXFYcTI5NFlkZ0dH?=
 =?utf-8?B?OUliWjA2ZTk5WlJCTm4wTGlrM3RFQnJOS0J6S1RaeERnQlJBdjgvQXc3cjhh?=
 =?utf-8?B?Z2Foc2QyVlRhckE1VWEvVzhuTURpa1hRRHZXemJ0V1FjK0s3SkNnUE05bkc5?=
 =?utf-8?B?KzBHZDFIY05xRCtJcjZoRjVCMUV3WFNlZ0xuRmpjMHJtUTQ0L0RhRTdubVU0?=
 =?utf-8?B?ajhGdTMyOTBsMFlOYVRUMDR1cGx5QU9GY0lnNERDZmFPdWw1RDFxTUVETXFq?=
 =?utf-8?B?MXJjbFhQeUIwWUhaMk9hNmwxdTNIWlBTa09hRzNrQXMyYU10UEdjZkw5U2tn?=
 =?utf-8?B?QzM3ZVhqa09LUVVEYUJuME0wbk9nZEhzSXl6UTFSVlc4YUhPdGpxRU91TzJv?=
 =?utf-8?B?Z1FQZmlySDNNZ0cwbDd6TEhqSEJtMUlOaTdtUU8vaGdESG5hQkdaZ3JVejRo?=
 =?utf-8?B?cHJoYThOSGhGczJBNE5XSFYzdnpqTFU2UHRhendJVFVqUWxZZXVDR3g3cHMy?=
 =?utf-8?B?U3lDRk9qd0hPWkZJYWc2U3ltSkVYOUxibDQ5NWQ3NTljSldMUVVLMzJkVHA1?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b610b3-4aa1-4969-22b9-08dcdf3652ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 20:52:38.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3xrqBnjikZNVkV2C4y2SNoPGTli0XgIZBRMJFKjySEBFTMB62zuu12UIGCzWGLn2TQN/39pgBFb+QKEHGqXA7XoDmn3B3EVBCXpd/dL2jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

[ add tools@kernel.org for bugzilla bridge mention ]

Linux regression tracking (Thorsten Leemhuis) wrote:
> On 24.09.24 04:54, Dan Williams wrote:
> > Dan Williams wrote:
> >> Greg Kroah-Hartman wrote:
> >> [..]
> >>>
> >>> This is odd.
> >>>
> >>> Does the latest 6.10.y release also show this problem?
> >>>
> >>> I can't duplicate this here, and it's the first I've heard of it (given
> >>> that USB mice are pretty popular, I would suspect others would have hit
> >>> it as well...)
> >>
> >> Sorry for missing this earlier. One thought is that userspace has a
> >> dependency on uevent_show() flushing device probing. In other words the
> >> side effect of taking the device_lock() in uevent_show() is that udev
> >> might enjoy some occasions where the reading the uevent flushes probing
> >> before the udev rule runs. With this change, uevent_show() no longer
> >> waits for any inflight probes to complete.
> >>
> >> One idea to fix this problem is to create a special case sysfs attribute
> >> type that takes the device_lock() before kernfs_get_active() to avoid
> >> the deadlock on attribute teardown.
> >>
> >> I'll take a look. Thanks for forwarding the report Thorsten!
> > 
> > Ok, the following boots and passes the CXL unit tests, would appreciate
> > if the reporter can give this a try:
> 
> Somehow I apparently became a "bugzilla-man-in-the-middle interface" yet
> again... But whatever! ¯\_(ツ)_/¯

Oh, sorry about that Thorsten, for some reason I thought we were living
in this new world that Konstantin mentions where mailing-list to
bugzilla communication is automated. Hopefully that arrives soon.

I very much appreciate the help here and thank you for the hard work
you put into taking care of regressions!

> 
> To forward the latest comment from the ticket:
> 
> """
> --- Comment #11 from brmails+k@disroot.org ---
> Good news!
> 
> I think the proposed patch by Dan Williams fixes the issue.
> 
> I have tested it with v6.6.52 and v6.10.11. I haven't been able to
> recreate the
> issue with those modified kernels even once.
> 
> The patch can be applied to v6.11.0 and v6.10.11 out of the box. For
> v6.6.52 I
> had to slightly modify it as the line
> 
> #define SYSFS_GROUP_INVISIBLE   020000
> 
> doesn't exist in /include/linux/sysfs.h in v6.6.52 hence the patch
> looking for
> that line fails on that file.
> But after adjusting the patch accordingly, the patch works fine on
> v6.6.52 and
> the issue is gone with the patched version of v6.6.52, just like 6.10.11.
> 
> So, I assume that the fix / patch proposed by Dan Williams works as intended
> resolving the issue I had.
> 
> Thanks again for forwarding the bug report and for the quick fix!
> """

Great news, I'll revise the patch a bit to add some clarifying
documentation. Specifically, that the new DEVICE_ATTR_RW_LOCKED() is
only for exceptional corner cases like uevent_show(), and that most
usages of "dev->driver" in a sysfs attribute are best served by being
declared as part of "drv_groups".

