Return-Path: <stable+bounces-244445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDhCE5yj+2mvegMAu9opvQ
	(envelope-from <stable+bounces-244445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E14E024E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57E61300AB00
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12D34DB46;
	Wed,  6 May 2026 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAy8Z+vI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C402305E3B;
	Wed,  6 May 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099095; cv=fail; b=lE8RFGHGSSn35GC6tHcPLgo62dqxA/X3ZWfYAwcgCVIuOq8GmZpOi8cKCyxtkN7u86DFdKzODy9CKSJfQOUUGBkDWWibrXbsK0tweO5r12ya5dom3nnX3FKgIhSsuc+aTUi9fh91pJwI6U+uB5qWknQ3QDE+ZknvM5g0l5BW8jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099095; c=relaxed/simple;
	bh=xXWwqrkmRPW4jzZQ/5NRQQQ9HcurHMfHMmzlLQCHDS0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AKlXm/B4mX2YCiR+iQNcIKPY6YIbtwjzOUkHLLVKhbUE9s0Q6E38gjF/ShyknfKc39oiAUFd+jgFN1h3zCk8tCn1R1RLOTCSO4L2nzPlwlU1pboUf3MCiHuyMRDSLggxcP7Rs5D8TUeQ0svo5FGsD2jQyfmKOHhIfetFKSiGNHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAy8Z+vI; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778099093; x=1809635093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXWwqrkmRPW4jzZQ/5NRQQQ9HcurHMfHMmzlLQCHDS0=;
  b=AAy8Z+vIdKXaRi68NNCRDHc5kfzUdubWHhUNHOf87JqkS4675tKgIYJe
   +DrJYCfi42h0vea1jV1z/DTRr5LdnJPpf7ZeFrE+XP2vxWl+rshn2hxj8
   BEMhukcWDooI8lxGydePs5Hdpr274TJ5bcy91/5X/u6UDWM2hddp1aKwU
   5hzmK9/yNlbsTdgtZcHWkpk7WTfQwpyyfP5ZAzYj/udo655+oOHgsN7ix
   q7VxbpgKAlhMIY56rS0zsBngkKZkJ5aMqUtGk4g8qPFnCmYl5n8gOiRQ8
   YlI+vGPXuL7JN070IreqlB8ThG4hpR8DtkKvD5WOqahlk51MBmw9pjwyW
   g==;
X-CSE-ConnectionGUID: SXmAnMsqQj+YOl6AdKOfww==
X-CSE-MsgGUID: FYndPBbUTOSj81bjtn/Q6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="90142906"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="90142906"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:24:52 -0700
X-CSE-ConnectionGUID: rHn2yHDyQyaS8oQjCQdxAw==
X-CSE-MsgGUID: lenBa2khSiqnf2ztxS7CGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="274368870"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:24:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:24:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 13:24:51 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxuKegt1FGfYibSqDivA3Q5PcZ/mTfGR+/9OaOyJAytluYER8B/IV1TSLo4TFKLfEpnxex6HjnvfoObVEROT6tezJdTkxJU+A9By5jlU/vtkpRXMqpyHSUufapiVdEEjow9e4g96qRhkbFojMaQHtrlOgD9xAEdPwZTrdYRZV1VSE3LmbZAIwRKZqtqWgT06TuJFghdoAmw7BJk8fY9C5c6vJHQLzA/hDv6a/orEEYvdNxSdIRQULJmf3IoQDvTLwEnDt8QY0buEjCKWQ6Hje8Ie96MqyaY+4sUVoRUA3nP8+T4KSBcXQcibBDcr8J1vYDNKjA3MTFnnS09R9VCh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1rR4syI6y3TEkiGzGV36j7XzzDtb00goNFn67cFRw8=;
 b=TXrP0CHO5kACEefoJjxQrAnVhziTbJvQ2iQq/7wPNHNiJjj4gevuOgeC2Cvm6UD/2v5j262DHZGKy0qZ32par99Xp8UDbdMvW2sJl248GejPo0joL7Vn44ewszm6ieKvaC9Tc1GiFID4Em9eXx6OGuDgomUlJiJtcQAwRP1OxYrFkDKRfuT7g8CteokzcxnGS7SToO1sIrQNII+doBMYIZqGKQL4y87as2yfJax+3Z23RRgQWkos1zO6HsbK9vyh6oGIN16xN0FeBT4HMHiZCRcuFhy1CwbohfvjZVsJVdnwwmPhtHVPUzdDh8q7ipBZ+WaXTrB3h6lrQ7uT2Fpu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA1PR11MB6345.namprd11.prod.outlook.com (2603:10b6:208:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:24:48 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:24:47 +0000
Message-ID: <30de916a-2f74-4f8f-8054-2f2037831bfa@intel.com>
Date: Wed, 6 May 2026 13:24:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/13] i40e: Cleanup PTP registration on probe failure
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
	Willem de Bruijn <willemb@google.com>, Dave Ertman
	<david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Matt Vollrath
	<tactii@gmail.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-1-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-1-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA1PR11MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fda96b3-a345-4769-39ef-08deabad84a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kY03CU/jW3jQxY0N/VwTJEwfHeWxHoI+3nxNdzYPG9oCD7klYprlJ8BRx9lyzepa7LU5mDojEuqJpSVa05xjWXNmS6q+LH2HMPQKE8ws7L3A3E9C9/L3tJ5Zj2qY8tPF+l8gAvzH7ITCgeDoml2/b9AsoDnG7kxKJ+aBZ2RbWEho9bkkea5pFnGfw3zTQLIeO2bPPnuZTWiOq4F0rn6ocOIw/IcWEs/H6kMjybyR+Y4Tu1cxfEFKOIWD79ZZqeEVCeNfztMXF3Oj8q36bP7RAbSvAiGzOoLqsCcgFAVohUkPymXyvRfKOU/ZQlPCRgjsCFSZvF4pxTOQBCGIHikdqQWpGRBFqbF2u2qT2VPXqPU3D0Y92hUyEdkoftOtLVJAd7pY2oGodjiCughGsys+Svy4OximxjXfp3AFewn6Mqn9nERtYJU1u95NRmIr1goZsn8wOHOHACsjy4GrVGip1hu6IsXqa8Y1Bn2/zcAgNqJMvgw606neP+hboEAvOvHav9BcqCCyWO3ORRhDvIu2DreYyh6H/aI5XOMvk9ha8+g8O9S+vz2CiHD0K1otQH58wnglok0nnLZu2YLT09WkTWj2KhQHynIL+zha5WxsqPGOp+yB2/THSn3dmfT8lZ09zRTzyTZ9pjkd95A1tt7npj/hDksl9ova+i+X2cg+GZs376tVJ4hBXm6lDF0gJOlKF3dglgVfoZ8w3baBAkOQ/4XcgHPMw8TeI6fRwyQ6d+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lpT0ZPWG9QSS9VekVRbnREQjFlclVYdlNTbVFkTlB1aHd1YzZuYStndWd3?=
 =?utf-8?B?ajdDS2lkREQzVmJjSWJSYzF1dkhGVW9XVzM4VnpaOTU4b1JnMW04SGVDWXFK?=
 =?utf-8?B?bWJtd1NqdEJEUUxqVEZGczlqeE9pZmNGSFdZOGh6NjFsSFlQbUNFS1EyVGZN?=
 =?utf-8?B?M3RXT1lBbGNrenZJNXpIRXIxQVhKR0xwZXdnZm9MS0d6NmJoWnd5M0RqR3NM?=
 =?utf-8?B?L2NZaDVxdlk3b3Z6R1pXdWRMUkJ2bFlUWDZrM1ZLSVVLK0xMdEcxOW1ldUUx?=
 =?utf-8?B?cGJjcWN5QmIwdEthQUJJa3hIUHgrdU42RmV1bmpWSzZLQzl4Q1BCOGZPWmF3?=
 =?utf-8?B?ZGRXaXM4UGppWGErQlUxRmhDaTNqR1cwYzV5bHpCTHUvZmZvdlZrb1cxZ0c1?=
 =?utf-8?B?TnNhUXhjNTV0MHdzVU9DZUxRelAxZSs4bDU1Vzd6NlV1RjhNa3RiU01heHhY?=
 =?utf-8?B?d2xmczRPUW83ZkxLYVZ0V3EwMGE3QlRCdWZsT1VVQkxSL3cwbENxeHZuS0NK?=
 =?utf-8?B?Uk4yenZDc2h0TWROYjQxbW43TVZ0bVY3NGxMb0daczBiVEhmTEFhOUtkVkNE?=
 =?utf-8?B?b2JTVmZKR1pwR1p6YjQxZFU5cDZQOVE0YkhMLzdVZ3d6MTMrbHZxSzhZWXJZ?=
 =?utf-8?B?aGhzeU0rYnQ2UTZDdmF3ZktpSnEwNGtVWkgvYWRGOStKb2xUT3orSGpqR08w?=
 =?utf-8?B?Zll1amhMRFdMdG0vYzd6d2NyQzhNUzdxeXpESHV3OFlDNjVyZmpyM2hVWXhS?=
 =?utf-8?B?ejRRWmtVd2ptSGFNaWxhTnJpajA2RGJDRjY1OThmQkNvckJtaTN6V3g2czFP?=
 =?utf-8?B?LzFuM01FaUNBK2tPMHZKZzZzSEtQa2h6bHdnUmUzc0RNY1Z4UTFpbWhYY2xP?=
 =?utf-8?B?Q1NNSjJua2FObE4yUytyZW1mRzJ1NWJQNVdBenVrVGdJdFlJZVlNczVVc3RU?=
 =?utf-8?B?TW1HQkdtcVhiQlIyN243UGRBdkgvSFJ3OHJ3cTF6Y0o5KzV3SElkL2dXbVZ2?=
 =?utf-8?B?MTJnd21RT1h1RGRMaitvRG4yUmVueXdJKzcwenBZSlpEemFjL3o5YVJ2VENl?=
 =?utf-8?B?WjZ0bktXaWk0UkdwSmNGMFczZWFpTFJBdjJCTEZBTS9KM3VvUFRRZ25ucnhO?=
 =?utf-8?B?eEVoVi9PV3U5UTZYVEtsT2FXS0JXbUtCZVphL1h1dVZCMlNzUHJUVjQybFhH?=
 =?utf-8?B?RllkaEJ0bU16bEZFVjUwaHpRNmxkWXlqQ0ZmTFhoZWcwNzE0UlROSmR0Z0o4?=
 =?utf-8?B?YkJ4dXJkbEE5MWp2czcrUTl6RUFET25TVFBmbVBEY0hFYVVoYStRL0VTYVR3?=
 =?utf-8?B?dHZyUFFWdFFqK1AxWjc1SEZqV1NHUzh5eUpCS0xJaXd3RXdlOEJoeWMzNyti?=
 =?utf-8?B?N2tWZ2RRY2hHY0tVSjY2cHNpb3VBTEdLK0ZpYysyVUtPR1ZYYjh6SGlMNVk3?=
 =?utf-8?B?d3dxODhFWEVId3YwNmlWVTBVRUwycEZBaU55OWZTcGZ3OFZnbDFreUhHdjJY?=
 =?utf-8?B?YkJ5SE8rT3MrY3V2Z3FkTmhDbUt6ZVZZcURaOGhuT2ZZVlNXL3ZNKzQveE9U?=
 =?utf-8?B?QkxrTGR1eW9lcHE3VXBsT05wK25VcmVaLzhHNURVQUhGNUZubTBGbmczYklw?=
 =?utf-8?B?Z09RL0ErTFJFYmdBUlMwSk1uTndrbkh6OFMyVmNKUWRkSFBSTXZEa0tzQldY?=
 =?utf-8?B?OUpGV29JUlpIVFF3ZlIzUHJVdTN2bDVsa1NXT0V6Y1F6Y05zd0M4SnlycUhj?=
 =?utf-8?B?citxRVF5dWlDakxhVXNpVi9uQkw1bTI5RGpZVlgzOUtVdjNMUDJkMy9qQmd1?=
 =?utf-8?B?dVNOWHl0MVoxcGcyOUJvOVVWR2o1RUdIWVA5UXF3Q0FEMnVBSGdiOHJLNFhU?=
 =?utf-8?B?VHhQaFU5OGZVVEhveGExbzhpREMzSnY4NFlML3B0VTdQNEU3KytURnR4emlK?=
 =?utf-8?B?bGROYjVvTG10ZjVpMDFDSnBKTG1GNjIrZU1oZVFDdllTNUZ2NVo2SFNvU0ox?=
 =?utf-8?B?VTRYa0l1aW9qNFN6REhXYUw4NDdHZ0NYYWdQaUltTXBESFJLOWtockNyR1Np?=
 =?utf-8?B?dWp0VDZPNkpoK2dPaW12ZG5EZ3hMZy9YQ2VmSEJaVUZmbllTd0s4em5WdDht?=
 =?utf-8?B?VjcrUGoybUtUNm10WHF0dWV5dHZ2ZWNUbDlwYUR2ZjhMeUhyTmdpVUZmS0sv?=
 =?utf-8?B?RTJ1bTQvVm9GRlpkQVZNc2RpRkdERFJaRGlMYzVvUUFVcFlDWGpLbTBVU2tv?=
 =?utf-8?B?MnV4ekFORDFVR1ViUlBQR1lJNG5pN1g4SkZhcXVoY0dxSkw1QkdwTHMrK0sr?=
 =?utf-8?B?Z1dKQTZUM2k3bWd5dDRCY2NXa0Z5U3NsekpITWZBbVNleElnNnhQSytzU3Ri?=
 =?utf-8?Q?0/dbz1Efvxh2XxOc=3D?=
X-Exchange-RoutingPolicyChecked: Vr0ReovO0ghQOjWDV9s9NVqp9nhYQtdffZOmK6rt49L3HJprCeZvf6H/3x/x9W/c4bfVneJeXjsZPPWBPOcjy9eZwMmuyC9i/BXfcocgNWuEvK4dDP+pd4mFgiL9kH2Y0mh03oy/tl0CD6d64Le+Kynr0VVB7w10Rw8h8y66MHAqIg4qcWPrxMOmXKQZvxZrjJd19ya+ALWIgIZ+sKM+Llls8uTL07NlofUnr7l8D+NCOVJ4VOLpv4HV5hkth5wENDyWp10gJCmrT3Wz4Om6wZvALxb+SJu8kgEyHqpdQme7JGhrZecTQ8W129xtrbS6GLRMrxDXG6QJeET6Q60olg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fda96b3-a345-4769-39ef-08deabad84a0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:24:47.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQq5hngtoLoQsvjrc75DA3jQR/e9+0ZvEJMFifx8j4AFautK8V9N/32pLJ8doNOPwkHYP52Hv6ByXlLI1s3KxGwLwuDBph4LPuJzR+RqhFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6345
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E50E14E024E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244445-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> From: Matt Vollrath <tactii@gmail.com>
> 
> Fix two conditions which would leak PTP registration on probe failure:
> 
> 1. i40e_setup_pf_switch can encounter an error in
>    i40e_setup_pf_filter_control, call i40e_ptp_init, then return
>    non-zero, sending i40e_probe to err_vsis.
> 
> 2. i40e_setup_misc_vector can return non-zero, sending i40e_probe to
>    err_vsis.
> 
> Both of these conditions have been present since PTP was introduced in
> this driver.
> 
> Found with coccinelle.
> 
> Fixes: beb0dff1251db ("i40e: enable PTP")
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 028bd500603a..f06fcef644e5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16108,6 +16108,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* Unwind what we've done if something failed in the setup */
>  err_vsis:
>  	set_bit(__I40E_DOWN, pf->state);
> +	i40e_ptp_stop(pf);
>  	i40e_clear_interrupt_scheme(pf);
>  	kfree(pf->vsi);
>  err_switch_setup:
> 

Sashiko points out two possible issues, both of which I think are better
served by follow-up fixes:

> This isn't a bug introduced by this patch, but is it safe to use
> i40e_ptp_stop() in this error path without canceling its workqueue task?
> The PTP initialization logic initializes a background work item
> pf->ptp_extts0_work, which is scheduled asynchronously by the hardware
> interrupt handler. The i40e_ptp_stop() function disables hardware
> interrupts and unregisters the clock without calling
> cancel_work_sync(&pf->ptp_extts0_work). 
> Could this leave the work item pending if an event fires right before
> interrupts are disabled, leading to a use-after-free when the module
> teardown frees the pf structure?


I think we need to double check that extts0_work is cancelled properly
when stopping PTP. Or confirm that it won't cause a problem as-is.

Sashiko also says:

> This isn't a bug introduced by this patch, but does this error path leak VSI
> structures and leave netdevs registered?
> If i40e_setup_pf_switch() fails late, the main VSI has already been
> allocated and its netdev registered via register_netdev(). The err_vsis
> cleanup block only executes kfree(pf->vsi), which frees the array of
> pointers but fails to invoke i40e_vsi_release(vsi) or unregister the netdev.
> Since the driver then proceeds to i40e_free_pf(pf) and frees the underlying
> driver structure, could subsequent userspace operations on the
> still-registered netdev execute driver callbacks that dereference the freed
> pf structure?

The only way that the function can fail late appears to be if
i40e_validate_filter_settings() fails.. but that has a comment around
i40e_setup_pf_filter_control() which claims that we shouldn't the probe
just because that failed.. so I think there is maybe an issue but I'm
not 100% sure how to resolve it properly.. It does seem like there may
be a pre-existing issue in the i40e probe error cleanup.


