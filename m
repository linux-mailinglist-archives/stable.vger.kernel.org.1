Return-Path: <stable+bounces-180539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7BB85318
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77800584ECB
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D230CB31;
	Thu, 18 Sep 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlC1YEsu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA41302CB6;
	Thu, 18 Sep 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204708; cv=fail; b=u7kmQ+OTYGCuvMsXAYuR/24vRi6Vy5QwYIut297tN7yCUcJS84G7LFFRxUiUj21DFufwUcJ4cVfQDRPtzRbsRqZ2n8k0gIMnUhKonkvE/dN9lsS6GkHnqSIyljgAjMjbXBlTYvcO96f6icfMUOh1wNBZebuxKp7SdiUvkYoWkVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204708; c=relaxed/simple;
	bh=MirpS7Ld2axSD6Z8QMzEZh7aYIQdG0LbdpZux7yF7p4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PnX43hVxVjYpEGDlHTkiGH1sogNLtZIG6qGHg6XcqYB4OTRe+8U7IsP8wHcpOqykVFTcxw0jdJvWI0olh/6eBazllgCNRSYeTLgxi/q4FNtxV7lpPx323Zm8EYmXbG/D7Stu+UzuzZoYZSVuDS1WLgzBoW+N8CIF6G9TJfxEpQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlC1YEsu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758204706; x=1789740706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MirpS7Ld2axSD6Z8QMzEZh7aYIQdG0LbdpZux7yF7p4=;
  b=TlC1YEsu4F/CfuC8JjK1VXfLrQpEzXLvpReFiiFjDPp6GpIMlfk+IswL
   GJEWHAR+CU5zQMsev2nIad0t9NwnO9hSg3yC7ziqFJf4GXR9CwEmomJxE
   zeJJBiYkuWOqOVtt/jrgLz4aCLH9zHqVLie9YldHN/MlB+5oDpszzOWt1
   KhPhYt+svT76eFPLlPKpyPFJ5mGhj63hIethwCmkAg5yYGwKKqE2e4sr9
   fH/Athp4ao5D41jLLqI7aqnotAW449jBMHv/1N9stL+zaROIeat+W01et
   aYVGaU1Vncf30q/82Rw69K7s1+tOxLSPB/GOoTQUVahcbbQiqb4JcDQia
   Q==;
X-CSE-ConnectionGUID: /dfYmp1RT/2lOvjTG+8wvw==
X-CSE-MsgGUID: JoXQ0zJgSZKITP4MJ88jMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71904498"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="71904498"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 07:11:45 -0700
X-CSE-ConnectionGUID: pdKuMtGhSRyao+eto56r6g==
X-CSE-MsgGUID: 1i2mkSzJQ12FY+ETcf8ZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="175625413"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 07:11:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 07:11:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 07:11:45 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 07:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJLe4WNCzpUQ6YZFO+g4Dtvxy4Yrs+6Fz0bnDJS5YMFaercgJX7k0Ll0ujHejawhZdLR+yHMTodmyf7leXTbuf4xnbMPBD4/QXHiLXw8ngYtnqyLaUz83YERBOitY+njx0amXclYbCT/O33qjwJKO3MDf+2v0PbTzppOc3cgSd9sHbGW2fl3OauLTwaBkXGpMTSZtET23V2JEbj7IJi0CWkiOw28IVT4Y5Aynk1WknbSVRHRJnXfxnHnXzf5sjzgpJKHi5zudRbV2prO+ubO+tkIzNf7yluHHy4zKQWpTm0KsCHX4AyBFA3f1yOb+Ehw3MdVFXkCC1exGLDbFQlbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efduL8cOz6VOmdYpmux5hVkuwEMtpdDIYxHPJkYj1Tk=;
 b=XGDxJzqh6Ztt/LT/u1LaKNKBr31PsFuC5WTi3uf2ujNP7f0cZQVZywl2FGcfd87lVS2u0acARF70paOSYfEsDHZODTNtfTH637Td85RotwBUx1g3yvmaxGqIEGnQX+/u6lfuUIl4ndLO8TuYO5LJUj0MkCbhwqNhJcJeN4mvlg1twAHc1SVnVcbB01QMTklTC7ZXgPU9DauLHhhgnWo6FK0S1Q8yWqt0HE6jrOERVxkSyJzVbnmCIbbCHTiQEbVOzvYhaOWptqnCZGa6oy2hJQUI/HQFXLDtaZKX1e03fxMAGNNwDcxWiKqfWXeSr2VOXf2jxgiOSF/HTe6Raf7+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 14:11:42 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:11:41 +0000
Message-ID: <c595f1a8-373a-42e7-ac22-9a203de05ca7@intel.com>
Date: Thu, 18 Sep 2025 16:11:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: Add check for kcalloc() when setting
 constraints
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: <stable@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, Piotr Maziarz
	<piotrx.maziarz@linux.intel.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250918135627.3576836-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250918135627.3576836-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::29) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|MW6PR11MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c15797-8969-48ec-ec36-08ddf6bd4aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXh3UjBybTB5S3hZS29xU29mMnVESjloUmNOdHV4MjZsZms3eGc0dzlYTmVq?=
 =?utf-8?B?K0dFSHcxNVQybUJ3ckdaa1p2aFlGZWpVd2JIMy9sNXN4SGhBUnQzVllkMld3?=
 =?utf-8?B?VmZtODZZazZXNXhJbXRaZW5xK2ZUQWJ2R0pZVHlucUFBQ1JkamlCZzIyYkZh?=
 =?utf-8?B?SGZ2WW9TajNxN0twVXVKQmpOQTk1RjhEWUp4OXJNbEpvdjl5L3J1ekJPU2lY?=
 =?utf-8?B?ZEd0dDBjTXFvVExlTGdqUU5vV3hGaHNRMENubTl5WDJqRldOeXd1Mzk5aGRh?=
 =?utf-8?B?dlB4eGNrTGxRRGo0MXdienc0eC9hVGZ5QkhpY293aW9WSGE1dXJZMFl3VG9a?=
 =?utf-8?B?L1JsRjllNmJIWEJkZllSOHEvalVBek9mdUJuMC9kVndZaWo2eGo1SS9wM1V6?=
 =?utf-8?B?RGtLejZzUlkrMHBVNzJYWi9DOGxQcWtuRWJvMVhla3M1VWZZaVArbTBCZ1FW?=
 =?utf-8?B?aFdLNHRHT2pmQ1BNOGJGTnRXNUVybkRTVG1ML0tyNHFkNkRkTStETW9Xckl1?=
 =?utf-8?B?RDVFeHFtbTR6UEtnUnYyWXNjRURJUE0yMWZGTUlaM21xNy9jNHVsUlVta3Bm?=
 =?utf-8?B?Uis3czlveUQvdThER2tBaXdCSE5kYndwYWZMZlM5dUpkelp1akVEN1hnUWZh?=
 =?utf-8?B?VTdLTGlZSlM1WFVoZDRNWGRKVkQwajFsY09wVE4vQThCV3V4RzRXbjh3T1Bx?=
 =?utf-8?B?VlVGVmVxZUpmVS9lbnZWTGJ2NWp1c3p6VytXNGhpektRZVpNcWF5OGkyWFpM?=
 =?utf-8?B?QzRDNDZ3SG9QQjREWWlhMks0WmRpcW9qc2hiSGZRZk9pYUJmNHZTTmZJTmtS?=
 =?utf-8?B?L0JxRWtvTmlkTVF1c29MM1J4OXdNckRhZVkzSm54ZStVZlVqajNsdmlLSUNE?=
 =?utf-8?B?MW1wV0U2aE54Zmt3cE9rRnNBQ2lWbjNJekt2dzk3aDZ3Q0poSmVnR1ljTGZa?=
 =?utf-8?B?VGhhT1FlckVaZjg2WDlmaDRFUExUdUIwektrdlNYb2pWbFJHM1FIYU1ld3pP?=
 =?utf-8?B?b29mUElLQTJTdnNTaXVSb1dYb3JsY0NTVXo2MEM0Rk5ORHpQZ0xwN1hEZVdM?=
 =?utf-8?B?MkMzL29xM05aU2NlKzhNNjZZSlVYdE9KSGpFTGF4RVU2Um9EU0s2M1dLTHVy?=
 =?utf-8?B?Z2xEalR4WFE1S3Jqd3pSNDhuRi9wK3RvSS9ZMmhINjN2aVJTMVlOUHJxK3JC?=
 =?utf-8?B?S2VtSlhjRVlESDFNR0V4R25yUWcrTEJCTkxJVC9raERHV0VoT3h4ZWdFeWdD?=
 =?utf-8?B?Y21TMEFINlU1dEJIZmluVUY0ZUE3U0cxbGlIVEhOZVBsNjd0bmNXdzdmS3Jw?=
 =?utf-8?B?MmZwRjh3UWtOcVRMVnlwaGlYRjdGTS96UWhhSnRJci9TT2xUYU9EYS9VM2JN?=
 =?utf-8?B?UStzYzNXU3FJQVIybXVUTE1rTlpBMStBUzJpbWE5WUh4aVNBZ21jMk5VWXZN?=
 =?utf-8?B?NjJSclQ2THk3TWw4c2krRU5hSmlzM3Z6cDhtSGxBZGE1LzQrbnVVL2VBbUcz?=
 =?utf-8?B?OWtWczY5VURmYjJ5RExuclJyRUJlbytlMnNyNnl2TVlielMrYzhKWTZBWlU1?=
 =?utf-8?B?UW42MUdlekZXK0twUWtXbHdGQ3pDdng4RVFxRmRTYk43WkZqd3lCajJmOU83?=
 =?utf-8?B?MEVScHpTS2J2a25CbTZQK3B3a0NSQnRXTmorNkR2SGdFTUNWdEtTdk9HTVZD?=
 =?utf-8?B?dlFvcDlTRFdHU0YrRE9xNmxyemExV3BUY09MTFdxR1IxYWNkRkM1Um56cDVI?=
 =?utf-8?B?WjZib0dxYk5Ea2tlVWdwN2hIYk9Rcko2V0lIeHY1Nm15KzRCb2puVjBJL2sv?=
 =?utf-8?Q?Q63dHWl4T6qFD3pxVr3TbYEwO8V+lORaz0j/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXQ3ZWVueUxwWStGUjNVTmMvc3c2em1nOEhoYVVLcHNpUitNL09WT2FXMk0r?=
 =?utf-8?B?R2tlakwwamlCdGJORU85TVYrMXgxQk4ramk5Tkc2Mit4SmFFNFJsTmRsWnRS?=
 =?utf-8?B?SWRxS3A4bmFjdC8vM09SeUpxNHNzWUdFQXJUeVBhcXFXTjFoRHRoNUk1TG0y?=
 =?utf-8?B?aUhEZEdMcjZsdHVvR1JURnJZdnk5RllZNFNDQkEwRjdjNnVkSUgzQng1cXgy?=
 =?utf-8?B?UzRvWGJyUmZ4N1VDRmVSOFRUckhMWUxHUk5PcnhOdVRmRU03Y29DQVR5bWRn?=
 =?utf-8?B?VmpVZjNFL1pjdENIWllRZE9Qb0RlV0Jaejc5VUZnSG1KV0lqS3hweStXelcw?=
 =?utf-8?B?YlFzbVZHYjE5dkk5dlVYVXU2OWd4c0UrdEF1Uzc0WDB3dFNGM2xGdTFFc2U4?=
 =?utf-8?B?M3UwaDl0MnZXWW5JbHZNQlowMkY3ZVlHbTIvV2kzb1lHSG40ZVk0c1dOTGQ5?=
 =?utf-8?B?Z1JxR0d1U3JUcG95MkkzZUFPMGkwWHRjYkQ2SzVYVk5IYWwzNTVYMHhYM2lw?=
 =?utf-8?B?Q2tZZVMvRFZSb0NSWTMvTkxoQmlYTFZFcHBxQW03SDVFaUpoOERsRXc3cnl4?=
 =?utf-8?B?Vjh0eHJoakNFei9PbTJ3NGExV1FSaXdlYXE1SEpQWDBIN0o5Rm1HdjRlOXNC?=
 =?utf-8?B?SVhYQUNZKzlhanAxeFh5SG1zNm8vaXVEb29QZ0FsNEhMUndkYW5QeTNEWm1H?=
 =?utf-8?B?QTJORndjc0NJU0x3SEQwMGM0Zlpva1dhLys4OEFhMXpTMFZNRjU4MXpWWXYy?=
 =?utf-8?B?WGhkS2pyb1BzY3JiZ01HZ21WbVdlNGZETkova3Z2SHVTSCtPeHVXRDRERXh0?=
 =?utf-8?B?cUZqTURUcHpuNWgrVFFNN1BXbHFYay92WDZqSWZXbUFpdUpiN09vVWRhWHB0?=
 =?utf-8?B?WXZZeU1WRUx2Snl1UjJkVytEYTJnZ3JLeXRQVnMzNnFEeG9vdnozREpSRDE3?=
 =?utf-8?B?OGlxRVhnT056UmM0Vk43b083SVNNdnQzamhQdVNzeXhsUmJXRXB6ZlQyNEx5?=
 =?utf-8?B?dU1CM1BraE0zcCtyWGNCMDA1TnB1Z0xoNFdpd3FIM3diekVDd09xaHdWekVC?=
 =?utf-8?B?WHlOeGxXd3EyMG5Uby9LZHZiOStmdVJMU3BxbkFsTWJ0di8vMFFHN0Z4clI3?=
 =?utf-8?B?WVZnbmU4eCtibEVZMnhieHlpVWc0Sk5KN3hhbFJDUUhJUm9zTndYb0NmeTlH?=
 =?utf-8?B?TXQycjdhME9UQ3Znb2JOQnB2SUpZZVlHM0xhQ3dQRnAyVVorSzYwcUh3aFd0?=
 =?utf-8?B?VEZpNFIwT05QQlJtNnJXRVA0Q3JmOUZqVTlYMWVxV0FrYTV0amlEZzh3bUsz?=
 =?utf-8?B?S2xWRS9waWExYjZjc1htWit0ZnNJUzVhakJrU0JuZ2h2WmJyd1lRbmtBQXox?=
 =?utf-8?B?UjdybGRkd1NILzMzNloxSG5QQkE3Ti9idVFrUnJoTjQyaHJBTHNQZndlY2Nl?=
 =?utf-8?B?aTBqZlNUd0trYkozSlg5MVBDRkowajVHaWsrSkw3OVBSUzJGSUVCN3NCR2Fa?=
 =?utf-8?B?SGptdmx2aWdkY2pVWiswSmQzakdBUUJCS0MraGo2UTYwUVBRRExBN1dxUG1C?=
 =?utf-8?B?SnpURUVBTWVyKzBZbVIxVVdCaGJ3M1U4VXRDMG11WjgxTWpMU2xYUEZtekw3?=
 =?utf-8?B?ZEJFTlRnNkRjNHBtN3h0UGpGZ2I2b0JrSmtOTGdSOUU1SG0zNDBHNTlYd2Ji?=
 =?utf-8?B?RU5uWUZTWGlRT1Fvcyt1eWs2YStpWjlxV3M4NGozbThZVHBvbUJ0N0NDeExZ?=
 =?utf-8?B?VVp3OVV2WHZhN1gyQXBMem9KTElCSm0ybzRGamhXRXpDaUJMSTVoSmN4YXRR?=
 =?utf-8?B?QkFRWStmc3lCSFArMmhGdEcwSUxxRHhBZlNzcEtjemFCYW5jcmdpS3QwSGZC?=
 =?utf-8?B?VWNMQ240V1VzakZkV0E5eGc2ZWZEdE5adEJCd3lIOEJlUmNzOTc0ajljK0ZI?=
 =?utf-8?B?Qk8wTXkwa3dvZGZ1aUpIb3hkQWUvLy9NRXpjWHJVM3hYdzhJcURYV2xBMXRM?=
 =?utf-8?B?MWttdk1Xc0VqRmhDenJPNXI1SnFLNUk0Tk9xZE14NkZ0U21wSjZ4ZXVJU1hv?=
 =?utf-8?B?c3pna2dIajlKbDJMZm5nSTdORmEzelNmZUtWT3cxaWhFK1BIbGxrNXowQ1Bv?=
 =?utf-8?B?V3J1b0pTNVRkQXE3R0g0MWZILzIvMFQ2dENSUFFsM2V3OTFEMTJZT0lVWUlo?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c15797-8969-48ec-ec36-08ddf6bd4aa7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:11:41.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npnKD3QKANXyNuS8Acovp1Wn55ojSqz6rGrGTZWFvxpuXoDxbLakNaOxmGkrpzn8ypSWOONNBjVoeFyq3tYSYcHcT600TQjyM9wOuP7VZrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com

On 2025-09-18 3:56 PM, Guangshuo Li wrote:
> kcalloc() may fail. avs_path_set_constraint() writes to rlist[i],
> clist[i], and slist[i] unconditionally, which can cause a NULL pointer
> dereference under low-memory conditions.
> 
> Add checks for the three kcalloc() calls. If any allocation fails,
> free any previously allocated lists and return -ENOMEM.
> 
> Fixes: f2f847461fb7 ("ASoC: Intel: avs: Constrain path based on BE capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   sound/soc/intel/avs/path.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
> index cafb8c6198be..cb641d37d565 100644
> --- a/sound/soc/intel/avs/path.c
> +++ b/sound/soc/intel/avs/path.c
> @@ -135,6 +135,9 @@ int avs_path_set_constraint(struct avs_dev *adev, struct avs_tplg_path_template
>   	clist = kcalloc(i, sizeof(clist), GFP_KERNEL);
>   	slist = kcalloc(i, sizeof(slist), GFP_KERNEL);
>   
> +	if (!rlist || !clist || !slist)
> +		return -ENOMEM;
> +
>   	i = 0;
>   	list_for_each_entry(path_template, &template->path_list, node) {
>   		struct avs_tplg_pipeline *pipeline_template;

Hi,

Something isn't right here. The code is supposed to be already there, 
please see one of the series [1] I've sent earlier this year. Perhaps 
you're working with an older version of the kernel?

[1]: 
https://lore.kernel.org/all/20250530141025.2942936-7-cezary.rojewski@intel.com/

Kind regards,
Czarek

