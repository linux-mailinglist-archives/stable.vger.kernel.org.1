Return-Path: <stable+bounces-244641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECJFBq0A/WmxVwAAu9opvQ
	(envelope-from <stable+bounces-244641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:14:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BCB4EF28E
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49AC5300D76E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F997340281;
	Thu,  7 May 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9uTtKZQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52933BBB1;
	Thu,  7 May 2026 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188456; cv=fail; b=TjU81FtV6MGIfdMRZqjjRy1SZ+kQlPOm/u6WwsQMWpQN27a3QmfwESMsUgKq2Ir1BGL1gkrttb+K2q1wV/4vBUdZCsxZ+b2buNgE/tfDDqxTIgRE23RG/nXFYE7MQiDn0+T95Tow1C8kY/VL2TDgLBFEYKJ+pbw9TIOTWQsbRyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188456; c=relaxed/simple;
	bh=ZLjDnLQTPyVbadlBEyDw8h1nQGV5jCswUEoSjri0uiw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACsQ1KvF595vRDjMdp2YfyV6b72x0ymogHLSVqDBOE1j9EFJx+ebFm2IYeGgylFMTHL9SVcrc08xsNny3JiVaaK2Y9+9jWuTFdb/sXWu+AquqgYX2R5UTrTUGdDIASy33dne6cm8cFHB9eP0IxM7zvA8tn0oT3kp/WKbE7zRs9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9uTtKZQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778188454; x=1809724454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZLjDnLQTPyVbadlBEyDw8h1nQGV5jCswUEoSjri0uiw=;
  b=P9uTtKZQZ5wjkCdpAMM4PLpMS2bamzNlA/qYr5aYrFf8MhLgrgYjLIoK
   TSbyC5SjdaMl2KcCjxWO4hBXf70eQjkQ95M1h83eqH1N4Msrom3T+kQUs
   itFVDWRMAxblC4VNP3fUt6A2dhVY7BuL9KHudhFQTifhNP/a1XWac7GL9
   pAcA3ZMNtV7BG2AUxh057WUY0+9qUGL2tWd/6LEXYvZYmlbltGbPDd8dI
   VrPDOQAT2qh8rzxYuKo7o3XEhNddtRxlP83nDVchc4GO2ZIkMDORKC0a3
   tRtw/JHPfUQZ8hlJRjhViqwsO1xdaynxU7AMB06ofjUvXFOgFBMSF3UBn
   Q==;
X-CSE-ConnectionGUID: eMt6HwjnRqGJO3SK7Hr8yA==
X-CSE-MsgGUID: ZVQdafH4TcOsePbr2ONWuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90531645"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90531645"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:14:12 -0700
X-CSE-ConnectionGUID: OMzH9wI7T1qON9cd07YDWA==
X-CSE-MsgGUID: GJyy9FthQk6ibEcuZR9VTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="230181667"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:14:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:14:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 14:14:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUdTcGjw6P0HDMtZw0RVxma3kh9C0eZPbCG8R/3zYnAkVt01lCn1F05IQ63Te0h2+mTzYQz/F3EOmldEiXBPgoGSmCGwBDeb63IUCUqDpbLN4+Q8VwblYcnnHCwI1+WyKDKdbpSRy1kiDQnL9Ba7wRjSj6xBacRlt6GOqm3rM8oDejF6P3Qf2ds4r0JTC9A3iZVVh+V26ZDs8GhdwSkKyRk4yvoASbnMvZZ18iFfciIC5gJgVbDvhxLQ+ph7cyK2gaM4ueG5K7MN0Io50L/zPZ9ZJ3IFjGhrdw39zJD45aRSIALgF1kdT0tJ+e/rPly3xAJS/Vpz8Pml26KCMChzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqH3muY7q0n1iGd1EMhY8c0dh+KEqxFFIYNwD09hLx0=;
 b=n8SfMEbKKHHJKmqD7S7qslOcOifHb44fsCib4AyJ5jjueLZpmLDb4qNTV6SO6pDOLrzpNQlGsG3XtDitJB9vhBoQ07t74INCTib+B89BlA9MEev/bPbsu4qGBf3VvtcuwdYQM4Iuly7v/L1FsnyXYV77awgT24njy+7DAY4os+1QhQJ8R3ca0wGb+ZqjZnzIPKZl2V5hTHZvXl/tbrUZhS754kZzWJL4eYTj6UwIINASfgkuMyYkJWlYTVivfjhJTp9Sspv2PPanssaKbCyVDFCzAYUMuiYTIxtn3h7pCHmYFDQZXAQ2luUtFWi5w2QqYrlySStn5k7YDTx5dbZLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 21:14:02 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 21:14:02 +0000
Message-ID: <cd38d92c-84e3-436a-bf51-5ad6a2bbcb45@intel.com>
Date: Thu, 7 May 2026 14:13:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/13] ice: fix setting RSS VSI hash for E830
To: Marcin Szycik <marcin.szycik@linux.intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Piotr
 Kwapulinski" <piotr.kwapulinski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Willem de Bruijn <willemb@google.com>,
	Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-9-a222a88bd962@intel.com>
 <068a5266-4721-4496-b027-3b32da3e02ea@intel.com>
 <56e52628-d029-4919-95dd-aa6da13f3b08@linux.intel.com>
 <3abb7d8f-82eb-46e8-8243-fc6f596ab84c@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3abb7d8f-82eb-46e8-8243-fc6f596ab84c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4d9f3b-d74a-4ae4-8361-08deac7d8fd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0/1v2nZtNcLFnIayTgB33Ka3cHIMiz2+91qegflDJQY6GiXKfoPZKmjyNG8NcBVy5vXilNLAgUCIf5/B1q2K4GlvdAMGFuDH+M4i5MxXLCw86tw/3bbFLgdoWkVEd4Xs0CHVoO8tvNqVLGUXXVoAlLk0WolqrzbAGFaqTck0psj5ylS/YopZDoZJqKXQJboWz2QL4DswVW9amS6nE2ZZrBuRmPXPDPltbDLblPoRHkKEJmoiAWEEibFjnRM71PBVLaVnoZ2L+VZxhUfX5qwfLO+dpD15OMbj3wTOjJ3JgNWh0JQtpI17ZpZUNz1msPFw58FsSfMQMgVNjG0q1eJsDdHAYJ/L/mbfVey+gyqMHEf/VRA95zR6RbnMypBpUnjcZXjyudUXIoQ22FJIvLc/NkG2DqAMAuQGMzJgm9vVDt2ZnMOQ2ifEpc2g3SrhF6cIfj7TikDFaG5NlMdGyNwItNat7x8puE9s3boJ6Db+5iapAH8ouoswUUCKb7qzGVbtCW/es8mnmdfBuaphDlTt1iT9V8HWnoywL/jnawyBPZ1gscayXpiafQzOnm3fs3mr8LTFYEoyMcQUaUbRAG6ZVWNo1EVduqzbwGKoG99ozHumWGvqCMpRnOjHGSRN0P3G6z4tYguEFxSveuuZF7uVGC9Nw1jmHO3VO7SIhkRa4SOL2sBq432j/haHGFKr9XJXdGiPyTFTpNy1vqiKkOTZjzMR39QnblKHgjU+6IUqYCMPuVumYUc+22Z5dvBmmht0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2d5U20zUjN4M3greFl5Z05sa2YvVkxieWlqaUhWL29WVWJKVTRtZTFBYTNt?=
 =?utf-8?B?bUVXTk1vSlRPdFVQRHdoQ0RETUJRb1RuQnFUUGg1WXpwNXlSRzJBSXRiVitD?=
 =?utf-8?B?MUVMOTVtdVNRdC9kMXk5TDNNeU0vWXVrWTZCL1FlUzhvRGd4Sm0zRmM2Zm5x?=
 =?utf-8?B?RFdmT3dKbDBmeTM0eW1leFVwVHJiaGhSNFV4SEFQN2pOWFRJNHRuTEVVcUo4?=
 =?utf-8?B?RWZuRURNN0poQ1paZFJQUHB4Y3I1S0ZqMXNlWkozWFljZGg1M2oraG1xNkV4?=
 =?utf-8?B?bHdsRVVPQmpsQ1JOMWEyWk1tYVF6M3ZOOTBsbTQyM2xtbzJLandlcm8wRWRj?=
 =?utf-8?B?ZGtweDJsRFkvMkRZV3llT3I4Mk5XYVZjWVgwYWRyaGtuV21JV0NVdDEzMW41?=
 =?utf-8?B?UTRSS2dDd1hzelFoeGdjNWNtRGdGcHZoKzRHTk51eklvTGltU2Z1cmgzR1hT?=
 =?utf-8?B?d1o0VGkvelZ6cmVCL1JxWUhQLzlDbjlBeml1NmJnUHd3Z1oydFR3R2tScGto?=
 =?utf-8?B?a0dOYzB0NjFqSFJkbmlzd1A5c0RtRUpQd0I3dE12R2Rlc0Jwbk8rZHdsUGEy?=
 =?utf-8?B?d0VxazFWb1NiUlo0RFUvWWFOTGhEZzMzVWJkTDg4dUM4L1Y2NTVES2lOajJ2?=
 =?utf-8?B?SU84SE9LdXRJTm1vOFUrMTV5bHdudEFkdHdONnVuS09QRW9QN2V0MGxtNThm?=
 =?utf-8?B?R0NvaGpGdFlsdGw2WTV5T1ZobnBlMnI5TE93aEpNZVV0Q1NRR1IyNTJSTlZz?=
 =?utf-8?B?R2NZUStzemVRcnlNeVFpemg0K3F0R0c5Q24vVXVndUlaNUdzSm8vNmgrcWo2?=
 =?utf-8?B?Q01MS1pnUFNlQldkWWhYbDJNdjZUYVVhNWMrMCs4ZU96Snl0RHlTVmVvWUpN?=
 =?utf-8?B?MXVjOWkzaWVXbTZSSzBGb0t6M3BuUDEvbjVyeHh1RFN3TU1vamd2MS9NVG9D?=
 =?utf-8?B?QlkxeWZCOUVueUdoNzFHWTJvdG9FRzBiWGJkU2ZWbjNEcW9NVFp1RDBYcEov?=
 =?utf-8?B?MjlFVitBMktrYmdyUzBiSHRPSnI3RTZIQjVuUU1qUG41YWt4bjRrYzRPUTc5?=
 =?utf-8?B?b2MxQnVRZ09TaVg1S3JZUEEydXU2VFdISjczL3Myck9CWlFtNTYzbEFYYnM5?=
 =?utf-8?B?Y3JxbmNkcXI4QzFWdTc5VkdNRTU0WENkS3doZUZpaXBQUzJFai9uMEtFbnlX?=
 =?utf-8?B?L3ZvNDRtanBXalEvaTNwNFhqMmk2RDhSdnNvMC9vYytyVld6UitQcUd3aDZz?=
 =?utf-8?B?ekdsWW45U1FlT1BmTFQzL0V0NDUyU0V1eGxLVVBGZDVvYzA5N3oxMHM4Ujlz?=
 =?utf-8?B?Q2R5bVdUZHdtYi80VTk5RkdMY3FlbmhnblBtSUc3eU9ZSjBuTkxidHJRcGlG?=
 =?utf-8?B?V1ZRZm5pRkIxNlltTEtoYjBxMksyd1BvODY3NE8xN05jb2MxbWI3UE9jNC84?=
 =?utf-8?B?b0c4RkhlclMyR0xvVjl2TFE5UG90d0NnOStaS1RtTEhSa3pZN1FJWmJrQVA0?=
 =?utf-8?B?LzFBVEExYjRYTGNBaG53NGFneVI0VVhtNkZkM1F6UVB2TDVMMnpxNTl0N0RB?=
 =?utf-8?B?UmVlNDJDUFlwY2htaFVQSFFqdDl6aVljZnhuYW5wTG1mVTk2NGpCcjA0MDFS?=
 =?utf-8?B?UGtCN0dPOWIzWjVSM2RZZUZQTndFNENpYVRLcSs5MmZET0JMN0NrR09PWHRZ?=
 =?utf-8?B?Y2hkWkFtTUVhWWJCWGlRU01DakFIM3dteGFwdlBKT25KQzhIUktOZUJKdnJj?=
 =?utf-8?B?UXBRVnRzSDNGTk45dFVwcDdoTXc5QnltcmNZdU1mZUJqTXlENDRoY25GQVNh?=
 =?utf-8?B?TzlhMTdpZlpPQ2ZmYlpYM2RMYVBCSmtwYU5FaTdCTWpsVDVBcDlOWm52ZGs3?=
 =?utf-8?B?VG1aMEw5QXFRZDVVYWZVbm5ReHhRb2dNcXlWRForenBIVmZvc2grQXFaVWVz?=
 =?utf-8?B?amNyaDM2RHJRWTBzY1F6UzZqL280VCt5TjRGRndwMEkweGNPbEw0blpYZWVi?=
 =?utf-8?B?T0p1ZVJLTkV1eldjblNvakxWRU44T2YvZVd4Wm00Rk1MNlpSUG9HTmlvSFQx?=
 =?utf-8?B?eGNudVJlU1FVR2I4Z0hMWWxhZU1menJBY3l1R3RLNlpUbjI5TUxzSE4vMVEw?=
 =?utf-8?B?YldscXkreVBXeW1sYVAwU1RTd1VoL1VtUDJTVmRTVEVWYzZGbkNVYkpLWC8r?=
 =?utf-8?B?bmF6MEtQR2dpWmRYcCtSeWxKN0JMSzA5RTMvbUZXVE5ZOUpIMjZFcHBpbDl1?=
 =?utf-8?B?L0tMUDNJK3lremJZRVFubzF0SDlCLzFQMS9GLzE4UkRoZ0V6c0YzZG01Vjls?=
 =?utf-8?B?NGFnVEZjSk02TTYweDczYUtaemw1VnpBbS9PYnlNdWpYZWNpYkVRdnJsNDJ4?=
 =?utf-8?Q?E78KFW/KefHNHLbo=3D?=
X-Exchange-RoutingPolicyChecked: FJw4Kc1UxEgFrblQ9tEKKgvZw0lqkAEoWXl2zCGFaiL02leYFA4tgCx9VrRWtvvuJQgqpJQpH5iZSP/gECTKMMQoKzS6zuh/Nliy9e8/OAIjrhP9M3BRAE2jrIPBoXgZmf2ztvVoFWW3tz9G/I6e2OQBbCQpt/G808+9Hzmvz7AgEIGf8GVzka4ek+1TLzJ9XNEflMynmz2kKThm4dQ29Tda0gyibKta8esqz+bGI5E7SF7VK4KGgV2hsARiymeVjYsCVzzNasF92Np/jt9IHGuLdYhlYSbnpAPrH8mb3KHF9aTF3Ags4ksp7Wea+kwMKPU5Kgt07659ij+HbrqBDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4d9f3b-d74a-4ae4-8361-08deac7d8fd5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:14:01.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgAWD6gT7oI8ZP7t/31QH0+E+2VVkVsYTpPC07SEf1csWsGL+ooutRMafl4XwtZxA7IQD1JRC7UkFDOLQzva/uzCTh0sq+XzlZJCihJyfcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F0BCB4EF28E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/7/2026 9:59 AM, Marcin Szycik wrote:
> 
> 
> On 07.05.2026 13:47, Marcin Szycik wrote:
>>
>>
>> On 06.05.2026 23:06, Jacob Keller wrote:
>>> On 5/4/2026 10:14 PM, Jacob Keller wrote:
>>>> From: Marcin Szycik <marcin.szycik@linux.intel.com>
>>>>
>>>> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
>>>> function, leaving other VSI options unchanged. However, ::q_opt_flags is
>>>> mistakenly set to the value of another field, instead of its original
>>>> value, probably due to a typo. What happens next is hardware-dependent:
>>>>
>>>> On E810, only the first bit is meaningful (see
>>>> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
>>>> state than before VSI update.
>>>>
>>>> On E830, some of the remaining bits are not reserved. Setting them
>>>> to some unrelated values can cause the firmware to reject the update
>>>> because of invalid settings, or worse - succeed.
>>>>
>>>> Reproducer:
>>>>   sudo ethtool -X $PF1 equal 8
>>>>
>>>> Output in dmesg:
>>>>   Failed to configure RSS hash for VSI 6, error -5
>>>>
>>>> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>>> ---
>>>>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> index 1d1947a7fe11..c52c465280f7 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> @@ -8046,7 +8046,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>>>>  	ctx->info.q_opt_rss |=
>>>>  		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>>>>  	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
>>>> -	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
>>>> +	ctx->info.q_opt_flags = vsi->info.q_opt_flags;
>>>>  
>>>>  	err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>>>  	if (err) {
>>>>
>>>
>>> Sashiko complains about ice_set_rss_hfunc() but it is unrelated to this fix:
>>>
>>>> While looking at this function, I noticed a pre-existing issue regarding the
>>>> hardware cache. Does calling ice_update_vsi() with a local context leave the
>>>> global hw->vsi_ctx[vsi->idx] out of sync?
>>>> If ice_update_vsi() succeeds, vsi->info.q_opt_rss is updated, but
>>>> hw->vsi_ctx[vsi->idx]->info.q_opt_rss is not.
>>>> When an unrelated feature such as RDMA filtering is subsequently toggled via
>>>> ice_cfg_rdma_fltr(), could it retrieve this stale cached context via
>>>> ice_get_vsi_ctx() and copy the stale q_opt_rss value back into its command
>>>> buffer?
>>
>> Yes.
>>
>>>> Could this cause the firmware to silently revert the RSS hash function to its
>>>> previous configuration during the next ice_update_vsi() call?
>>
>> No, because the context object passed to ice_update_vsi() only sets
>> ctx->info.valid_sections for the sections it wants to update, so unrelated
>> values are not updated in HW.
>>

Ok.

>> Looking at other ice_update_vsi() calls, most of the times the context object is
>> being allocated, not taken from cache. It's not immediately clear to me what
>> purpose does hw->vsi_ctx[] serve - it only appears to be used in
>> ice_cfg_rdma_fltr() (correct me if I'm wrong), where options from the cached
>> context are being read to fill the unchanged fields in the updated section.
>> This seems to be the equivalent of keeping track of context values in vsi->info,
>> which is what almost all ice_update_vsi() callers do.
>> If I had to guess, I'd say hw->vsi_ctx[] could probably be removed and vsi->info
>> used instead, but maybe I'm missing something.
>>
>> TLDR I think this is just old, inconsistent code that could be improved, but it
>> needs some investigation. Until we don't have a clear signal that there's a bug,
>> I wouldn't touch it.
>>

Makes sense. Its probably better to leave it as-is for now. Either way,
I think these shouldn't block the obvious fix.

>>>> There also appears to be a pre-existing issue with state desynchronization
>>>> when handling failures. After ice_update_vsi() succeeds, vsi->rss_hfunc
>>>> is updated, but ice_set_rss_hfunc() then calls ice_set_rss_cfg_symm() at the
>>>> end of the function:
>>>> ice_set_rss_hfunc() {
>>>>         ...
>>>>         err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>>>         if (err) {
>>>>                 ...
>>>>         } else {
>>>>                 vsi->info.q_opt_rss = ctx->info.q_opt_rss;
>>>>                 vsi->rss_hfunc = hfunc;
>>>>                 ...
>>>>         }
>>>>         ...
>>>>         return ice_set_rss_cfg_symm(hw, vsi, symm);
>>>> }
>>>> If ice_set_rss_cfg_symm() fails, the error is returned but vsi->rss_hfunc
>>>> remains updated. If the user retries the command, the early check:
>>>> if (hfunc == vsi->rss_hfunc)
>>>>         return 0;
>>>> evaluates to true and returns success immediately.
>>>> Could this skip the ice_set_rss_cfg_symm() retry entirely, leaving the
>>>> hardware's flow director rules in a non-symmetric state permanently while
>>>> falsely reporting success?
>>
>> This looks valid.
> 
> On second thought, if we decide to rollback changes to VSI on ice_set_rss_cfg_symm()
> fail, we must call ice_update_vsi(), which then can also fail, still leaving us with
> hfunc programmed and symmetry not set. I'm not sure if it's worth adding rollback
> that can fail and still leave us with the original problem. User would just see 2 errors
> instead of 1.
>> Thanks,
>> Marcin
>>


Either way, its a pre-existing issue that could warrant an investigation
and a patch, not a reason to modify or delay this bug fix.

Thanks,
Jake


>>> Someone from the ice team should look into this and determine whether or
>>> not its valid.
> 
> 


