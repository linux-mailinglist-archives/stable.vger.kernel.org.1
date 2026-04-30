Return-Path: <stable+bounces-242046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFvyN/4K82mSwwEAu9opvQ
	(envelope-from <stable+bounces-242046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:55:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F649EF18
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B454300D1F1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2F3FB05D;
	Thu, 30 Apr 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAHv1K4b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C23FADE9;
	Thu, 30 Apr 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535738; cv=fail; b=t0pbDj9k8H+JAepFD+Ssq8ivYlc/8tuHrj592rLjIGhRvzyy88/7KxJzn38/TUb8fY31pdOV+d49O4Ox7wUBU9zH3R6e25V4hmqfcI5rfqqax6/2JRzh+vx4sVEQGp8VitAPUdPWMXYTum9W0Oea0kdP3w6/dQ4JUgEnzWj9nwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535738; c=relaxed/simple;
	bh=vHxNQ9xLIQ2K9lLWHiy6dU/PBzempXMeC7D8YBDbCA8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J5pMOkWpHbuBGot+TQicapLUm2a2rSN5DsI/D6SedjBtkNdCZV1hrS7wb9LnK+AhqvkYfFUUdLaB/Xk2ip69SZG9RuEuLoauC76teYL3/6GU8IT/sxaXxyIb+c/srEklxOAx4O+W1F+BLf/e6g2Rns9QXY7b59zVjzEHL5tKmpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAHv1K4b; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777535737; x=1809071737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vHxNQ9xLIQ2K9lLWHiy6dU/PBzempXMeC7D8YBDbCA8=;
  b=CAHv1K4bqLw2Ko5nQ+xByHKnl5Z3bMN245pJXNA3JzwmauzAtevWIV5O
   iVC0mFhwrYADazCCHqJVgPugd2X6qkAc63p6y7e73qPAZW8SXMVMM/zpQ
   oEiP4nCjcxxr+xw9HFdMCSsaxKwKaXDVpf78EFbCjU3PnvPJm1EmWuhZp
   znKdZ4rARmhzV6A39DZ/ryo6Z/uco8KZGM9gApKuru8G+NhZbJ8Tn614q
   aP+y0TyUqIAmqaJ3lkSkKZ65qN6qfTpmCg3+vkZ6DRvnUJra4JObJ6nGK
   2ajiaRs+s0w8zu64uFmL3E8GSKCprAr2EmakVbMQATrR4kasbKzlOm04s
   g==;
X-CSE-ConnectionGUID: +/s0OZV0SeuWhHCr7MgMQg==
X-CSE-MsgGUID: 1kV8MOHLQwe8StisbWD3Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78669220"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78669220"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 00:55:35 -0700
X-CSE-ConnectionGUID: ykuOi7uVRGyVRtCMZPzgDw==
X-CSE-MsgGUID: x7aZj91vRAaAHQ6pH97lfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="230159036"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 00:55:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 00:55:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 00:55:32 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 00:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM7OpuKlB4e71L8b3BG7+NXOIm6MOH/CQF/+olHKlPV4vWOOeJeIuLwdIbZ24tTGQsL7JR4lGZviHCo2f4Jz3FyQBybtttsOpymh9ClTaJ0od3G8vLo8/jJ7QwcZGHf7hNp+zz0cCJU2xqILkn9ORLd0ntkrXdJBSQ5LgPt4Q8IlGbPmIP7o8+FzrFNeVHsT15zOmTOnLvdFCg8i8jmi4Z4lWdlq39LOyX3lYX/4E5BYf+X3y7Q4y6efJnjTOLv6Zejjpwyu0nIL5WUmg7uUU9TbP4uRecqsf+UzLr//9TeeuZKIR2a9FXtGYK3QcyBNi0ymxA5DgSSqAuBXD5YJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgxs3VPQnlsjoFEMICUb5aUPycBOe5Uc44K7+WjSbXQ=;
 b=d6/CY42Neb3GyufC8K2UHg7JrFelA9eOPZt0qWbNFSsouydPki57fS4nJVDvwsTo4EIATWcOfEP3QcyhZEHEg5IigQkAvZ8M/MFScsoMnZPOGCJlCbpOXqAun+hliVVV4r7ZtFpZDX5WfGyh20v76pL1mX/+VEfeE0rc3WQvwhiP27nj4ThSsA0UwaEMzQIJkw5PBzGGQSxTyHQsOgBIGRYeWp9eQfGRpr6BA5tTBH0i1QKjcy3LdDX6CgR/PruYpYzQXVmufPR1LEmMLhkrocrCcYoKhLLJlSdoI4NRC7mE+NzSNIl38eTsde6bMigI46DhtUDFfDnEZoWf7nHUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:55:29 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:55:29 +0000
Message-ID: <1ac694ce-fc20-44bc-ac9b-de5066f793c6@intel.com>
Date: Thu, 30 Apr 2026 10:55:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] igc: fix potential skb leak
 in igc_fpe_xmit_smd_frame()
To: Kohei Enju <kohei@enjuk.jp>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, <kohei.enju@gmail.com>,
	<stable@vger.kernel.org>
References: <20260415025226.114115-1-kohei@enjuk.jp>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260415025226.114115-1-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To SA3PR11MB8021.namprd11.prod.outlook.com (2603:10b6:806:2fd::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|MW4PR11MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccb7619-7329-4585-e075-08dea68dd824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 60C+ZjbtLUU6mclW2YRIVXtpml11FmoGhrPXkR20VaX8d0fUQthqRf8+/rsX69RX0dqodp+N0TxzsLgJnrMTmvI7v13zGRHIantmkNElwZu3ah6H+qVIddvu6JFB1oh2stm6Gst9ozr/SCySz2PnD8ELL2VRWn2E97BeUj8YrFCAIu5kJUHjkD+hdLRZKgSEep8qDnl/rc3UKQLdSBQI5beKpzGyOGOVY1CVvYox0TTLQqZehc0300yeNPMElsUxppE6bWGotWzXKpbTmm6aAwGbhBit1BiOB3I7ADSt6SwlOZP2Msq45/9EP5nr8EFtV/v5EziOIDcuNGexQcPgoBvAvCgMsHfqx6zmPH1in+GrFzvJPgQtkDWdvaYpIrunAEQSHofrLxO5vOQva0f1E3vI2oJmxs+liZOylsYkE0BR7pGO+b0P4IvcG7KGQNJQoSYFVt8zBmhfd9Vh3BLFRjqxC5RpehjOfkFwx1HvAfwv55mZUGw515/Ankd7Y+pgtB9HtKDF+x0a1bhPpFuJHUtYG1tsxk2GZ7wxtVqtANab2V7gnMlktlNm4TwQ5vgPSGOu2RJVgOBd9kYHN5xcJgYlM+puYQlXe/FuH59BGfPVsDfZfNNbCjDHyUwEvfs5TOlmRsCBtDl/Sn1L4exlJmFK+VPLkoL6fqg3rCF/f1ZIpomdMI3rcJsFW52ZRsqgrcuBijXBwYTImTxyaJzm6VSRCNWwlN9vF4W8z4xb8lw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRZZUV4SlhCdHJkNFBpZFd3Ty90em9pODN0Y000OTNJL3NqUWZ0Y0J4eWk5?=
 =?utf-8?B?dnc5WEE1Yy9IMzNESVdpTlRocFU1dCtzRXRLNGRvRFBYbzhydXAyZm1yazRY?=
 =?utf-8?B?NTlRWUp5bXg4VTBWYis5QkdtZVhUeEVmU1JiZWV2OHphZ2dHalhiSFBQRXRP?=
 =?utf-8?B?VExpajJuWE5ycUJyNFVqRzhuUTU4S3VscHJLSzRVVGMxSG1nVWpLdHB4MkNQ?=
 =?utf-8?B?Vkh3d3R4Nm9xdldkODl2dlNaQW5ieEVKUm1VaUxXYnp4bDVCTVBNRHJJaVdI?=
 =?utf-8?B?R2puS2dReXpqamsxQXprOHpkQWpkeHQwS2xadDFRa0cybDVDMTBTSUd4MlNv?=
 =?utf-8?B?Mm1tOE9VKzc4dldVR3hmNkFneW9FRnlMdGx6eWdxVHJWRUNmZzRxWk9LRjJm?=
 =?utf-8?B?ZUhaSllTR3Q3Q0tlenBPSWIzU2t2YWg4QzM2U2h2YWcxT1FtQmFuM1IyUWhr?=
 =?utf-8?B?Zjh2NmdyNUZQSFpON1A3dDAxaE1LNkhvVjYyRmxldGZ2VEt0cEZScDdHY0xH?=
 =?utf-8?B?UFMvamlSaEtUdXh2NENYdXg0UnFONVlYRHpZbURCcVlmci9sZnlIZnlpMlFa?=
 =?utf-8?B?WStmalZPS2w3NWp1VER6M2JMS0ViUDc4S2VmWE5JdDFBZmZMWXlzNUROZzBW?=
 =?utf-8?B?TXhDRUYxcHhMbUhNd2I1aWcwQ0JxLzl1a1NqK2xXalhsT1pXLzVyTk5SWDNP?=
 =?utf-8?B?c0VFaFBFdm9oNmNjMlhpSXlqemhvSXE1a1lnSS9obUxvaUxraHpNLzNEOVV6?=
 =?utf-8?B?ZHpEeU96T09aY2VsaUswNkQwZ2hJUEl6M2VHWXNRVWpTYjM0SFdVWExMVUw1?=
 =?utf-8?B?K1pLM3hLbW9taFYvQmlpUENhUk1hZmNpYjF2OCtib1VjMVM0WWMxd0tvN2tl?=
 =?utf-8?B?STJVSTQzLytwQjJLbmtseCt2S3k4Zyt3em51ZkRsRVlsajNkelU1ZFFmYlpW?=
 =?utf-8?B?ZEVXTVpneWhFVjlNYzQ3TVA5WXM2NHZtSzdJTm1uTjJGbldZTjVJRHg1NnVl?=
 =?utf-8?B?dDJPN1VRMDFNZ3Zqck5BdjNnbXpSc05tV3B4emtLVFlodEowUUw5aThyV0N4?=
 =?utf-8?B?aE5ybG1yVlBGb1k1cy96ci9TdTRiYTFUaGI2YmhCaVhtN2NpdHg4RTdlOEtn?=
 =?utf-8?B?U0FwK0R1RFpaQjJBVHZkR05vTjJZSk5xaTk3Umc3TlRhUFVmbmJwVWVtbklk?=
 =?utf-8?B?Vkw4NEZ1T0dGNU5CNmFoeFR1SlQ5cGp6L08zT28xd0xBd3VrVWlyRE1WZXZQ?=
 =?utf-8?B?ZVdnazh0VFRKblQ3SHBidTFCc09KRFNsdURUbUtBWFhucEZkSmlGT1hUWG9P?=
 =?utf-8?B?Z0JVTjZUU01URDlaekw3RUdPMitTNWdYWDNCOGQvOWN5SU1pdTdCVDVDNkJ1?=
 =?utf-8?B?TGU0RnByT09IS2Jad1kzZk94UGFLcTRselh5aFl6RGJheTdNTTRPbHdqNU1u?=
 =?utf-8?B?YlBEYWc4S2F5aytGQVBRbnhuQnVUb1AyeTUvSU9oekExSUxFQk53OG16a2tY?=
 =?utf-8?B?WmNYSlZXTk1NaEJ6OFFWZDhySDVTSnFJSTVzQkNMRWpPbHNla3pZNEpWNTk4?=
 =?utf-8?B?M0Fkd1ZZdXNtU1hObFpQSlhnVnJNYlVKVnBRWXl4YnQxd3BMbHg2cHlaN2d6?=
 =?utf-8?B?RmhKTitOaG4zQlY0amlLcDNFUGlpcXQ3eUU3WDlzZXpYOW1Jb21EVTd0Q3Ba?=
 =?utf-8?B?dVh0S1lrcVQ0YzMrTlhWRll0YWpsL3ZYL1E5QjJJNGJyY2h3aFpjaFNFbEh0?=
 =?utf-8?B?WDRROTcrTWhCUWFmWlAxSGJKcUVjRzZ1SGR4Qkh4eTIyenA4cmQwbFZVMEQv?=
 =?utf-8?B?TXpxMnlZNktVK2JMSkxYTXltYWNyMFBzTFIvVW9qZWp4ZE90bDFsOFZlT1o2?=
 =?utf-8?B?MVlLcTdxc1Z5Wk5pMTI0TWlPTHdnS29ySzJSRUVSQ3V1V2FlOEc2bHMzWk9E?=
 =?utf-8?B?N0lyWis2WTI1NWV6UHpCaFZTMnE1WVFmbWhsenNrcTdLaDFzaFBkVTBncFRE?=
 =?utf-8?B?YWhhNnVVZHFpS3hubEdWZk1salhNbnRPSFU4TjRERkd6dkRuUzhWbFp6SlNZ?=
 =?utf-8?B?OXBCYTk4VHJjbkl2bXZPbFlvcDVWaVdVUzJRb2I0cnNTSWFGOHpCNGE1cDgw?=
 =?utf-8?B?MlEvYWVoQ2VTYTZrYU1vQjZaM09wVVg4Q2hTOXZjcjk4RmRVUStzQlhsSzhU?=
 =?utf-8?B?WUNHZk9ZVjNTTXkwaEhEQmthYmpHeHRiMmxzWHVKUkZnY2xka2R1ZSttNGRQ?=
 =?utf-8?B?RFF2SEtRRERseEhObjRJMHAzUDRHV1BNSndnRkY4Y3Y3UURuV1Zmd05Jc1Qw?=
 =?utf-8?B?VmNCbE85RGdXODNURllTSFJmUlA1QkhlZTNGYnF2b0xjRVl0cGdraU9wa29E?=
 =?utf-8?Q?fvH740fj59m+I28E=3D?=
X-Exchange-RoutingPolicyChecked: JxLyW/SQSZkLkRSr6jgATC8QYThP562QWqip8MOo2iErQQQoeaUq0I73l4eZ/1nUN89KGsYWgHBHAN5lq0UQk7788Scyo4izzVyxw6bNSOTUoW7y7t3MLk0Bjhqk1Auj12dfTq4LHA8CvKaGffr/Mox0ey1VemnkZCppAttopdBF7F654envY29i62LowYXwRXxrkWlDc7lwQbHwJoq/5NwVRAk6PEf4+NmhGWnPc3My228q5w/gl0JdXQdurX9Kh2cndcI3HPHP6S37UmOFV9IxMGkpUF6FhlhlOUlDawT0psaqgeDk/cDQbRwp9TJyb+kcPDpCCbSwm++TrcrXCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccb7619-7329-4585-e075-08dea68dd824
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8021.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:55:28.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gz4GKPeVApfIK+M4EviwgOJOLWgwHjCdJ29bBJWL83PzGOH1J1i9kYh0Q5vVHeH31rA0mTsalu6J/wGN6gurPKctBbOLGm5reXANHyrQO6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6739
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CB5F649EF18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242046-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,enjuk.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



On 15/04/2026 5:52, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> Use dev_kfree_skb_any() on failure.
> 
> Tested on an I226 adapter with the following command, while injecting
> faults in igc_fpe_init_tx_descriptor() to trigger the error path.
>   # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> 
> [1]
> unreferenced object 0xffff888113c6cdc0 (size 224):
> ...
>    backtrace (crc be3d3fda):
>      kmem_cache_alloc_node_noprof+0x3b1/0x410
>      __alloc_skb+0xde/0x830
>      igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
>      igc_fpe_send_mpacket+0x37/0x90
>      ethtool_mmsv_verify_timer+0x15e/0x300
> 
> Cc: stable@vger.kernel.org
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>    v2:
>      - change to idiomatic style with goto (Simon)
>      - add Cc to stable (Alex)
>      - add reprodunction steps (Alex)
>    v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/
> ---
>   drivers/net/ethernet/intel/igc/igc_tsn.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

