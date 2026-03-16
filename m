Return-Path: <stable+bounces-225508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OVjKoGxt2m9UQEAu9opvQ
	(envelope-from <stable+bounces-225508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:30:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7162959E1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5E1130074A5
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152D34EF15;
	Mon, 16 Mar 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahwZFEc4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA834F46F
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646203; cv=fail; b=ZD9dTPS7GKi34sMtZcLjSj3YkVYHdjpKH8xKVyGwo6SDmZq9+w5sg1eHga5urZa9LhilkB2D2YmjPOAT4sAlGvIrkfF/rzm1dYuNcXcpToUbqqusAPo8F2IYBhg3dTr7g4w3P496fCuklVVsEmuSoD6WkKQvJYIDGKjcyqs3OyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646203; c=relaxed/simple;
	bh=sLsezpMDohFyAaOWJKxFjRdGgm/097j++WPIWff2UGU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p98WGwUEfZVSDioozu3zzHMoTn12luY3S7BrY/oRPZavWsCc/8g1UaiP6r46U9JrLNITxIp/SFBKvzT9FCyNvIAssUku277xY4Br5vlhWDLZuMwoEnwb5ktaXGkjCBPfrijud4lTZO33Bo66Kd6y2t1ph8/oHtOZN6QXe3sO6TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahwZFEc4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646203; x=1805182203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLsezpMDohFyAaOWJKxFjRdGgm/097j++WPIWff2UGU=;
  b=ahwZFEc4Y0z4s74mO6EHAFoKvyKG/QGF24GXcao9t6gQDWjHek8cHp1T
   /BYg1zilTj9SxxjvLtdekwg2Uri0E+Lc59vENykwPfLKpMhhK6ITzY+cG
   sGaBbQnsa3Cx/2vvjuR42quYLOIa82c/fDcgt3+ZoY6T9MKWDGJWqkhD9
   KSLUjhWdnksX1Y4talUT/Uulq140SYQD/Y+yLaUyNePf3lwaCPR4QbYqR
   rMMk/TPlDhfC96sQa6r6MWddbJob7lzkD67sZykD32+vvfxTR/4V4nGRE
   faItz9mQ1S5O05ZMUGp92qpXbDyaetYlBxLbrN0u4rT8qC3Tr5OVrClm9
   g==;
X-CSE-ConnectionGUID: 1G6/evVKRCa3pCJL4wjU8Q==
X-CSE-MsgGUID: AhtIa7RqQmym5aJdaomP3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="84971406"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="84971406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:30:02 -0700
X-CSE-ConnectionGUID: 3XGiwz/hQReJNdlkhtdZJg==
X-CSE-MsgGUID: C7KPLgsLSmiU6uICFcJlKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="221784593"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:30:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:30:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:30:00 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SugvXeMjnBpOG8zynw6vqP00kR7k7D767r6QftWLWUKL6h//42mZl3COpaPMtOCj0Idw7X1ZIFe/HqeHMc9/L9atjamU36d+Id72n1Rm3fPJLks9Y6YC2JH2YSeGXylZcT2T4P8tZgoDMAVZiKnslPYGyIYNvX4TEbTz0I9cI4LkgrPk3i8Tc+6dulM8uoD4hTsi3lM1gd8sGRX8XKhsLHwToMurdQMdZqV5ZFxL56EhManlxfhjhgxFHMsnMoD3pdcBOufdoWmBK1BJSqXcMNImCLt+fMEf5y/IrhhnmEyLlrLrKtYYg7EUg+/JNWK0sX/LpR6TvjdAxMgr9bi2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3c3v1uvlvy8LBs/GPavPUU9qIi7G7bHi0FqNteLC5A=;
 b=VDJjhqakIZyHLyxlzP784NvWLoYxnFi8vN4ROO6hdLiq1IGF/aZy+0WqcNg98hHKsiev/2glxdUNsdZpjtupWZVRlR8+T/Mv6kj2kH/w94FFLGsd+JOb2kc4lRn3aZxNdoT3fiQD1nHCxOrwc3DvWaQYxjxsDZCMLDpsWQKiXYc6XJTFsESJaYBPSGiPSoF0jczqs2g/d7gfdhfifRREyLyTwWyVIdqe24joz/naW7a7GtIe6qI3SWvVjVot8E3D2vOk4Y4sDiNc5DHr0Y4wAsGqYLARRqeGB9mbXOgknE6qGercjLyAbkfTvb4kE3HoGakxheVSEl86KTZaDTriQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SAWPR11MB9758.namprd11.prod.outlook.com (2603:10b6:806:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:29:54 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 07:29:54 +0000
Message-ID: <ff8869ea-47cf-4b02-8173-7f3b0928585d@intel.com>
Date: Mon, 16 Mar 2026 12:59:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/colorop: Keep colorop state consistent across
 atomic commits
Content-Language: en-GB
To: Harry Wentland <harry.wentland@amd.com>,
	<dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
CC: <contact@emersion.fr>, <alex.hung@amd.com>, <daniels@collabora.com>,
	<mwen@igalia.com>, <sebastian.wick@redhat.com>, <uma.shankar@intel.com>,
	<ville.syrjala@linux.intel.com>, <maarten.lankhorst@linux.intel.com>,
	<jani.nikula@intel.com>, <louis.chauvet@bootlin.com>,
	<stable@vger.kernel.org>, "Kandpal, Suraj" <suraj.kandpal@intel.com>
References: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
 <a0ec2ae2-502a-4587-8951-41dca92fc8c6@amd.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <a0ec2ae2-502a-4587-8951-41dca92fc8c6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0192.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::10) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|SAWPR11MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a04e045-394a-4080-8cd5-08de832dd12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: D6xqeXDUMDyHFToFBd7WD4grpYcdkeqi2LKd6s2irstDxg1Hw9uQ38v0pO16DYmYJVjgXmH0w7bTIr1JQSRQKXqvHmSRmBcQxrYFSxfdZ00Rcnta/zxFsH3mwug9ijvZU5ydR85G6whOz/MeIM3COXeGRdUznOrB89TsQPcP7F40pZWC2uuRkW0Fs1+APm+OSgXLili/KXAtD8+0mOvlF56VlrJMFI81s5O1aIvdCTQQJEibKAPOhlkCmniNmJhm4Os7+zwWqq/hEB1Mr/qSnnMLklGZpmfP6GW+Y9AVI58z0Rxy5M12QtG6eMofwOgkP7+mH8G6HPSqXpy0RHQrYdRMQyBirVaNGRjfsFn5yi/g5gnNWWKUx6knCN7+Q1KxHYMuOQxtd0vbZknVny0piz+e/VU2kwFteHRHLZ481KDeEa9oubEoOfARu3KChgywtMkgymkAImchmFcCABgqblBE6y6pVRv6GF7aowwhh9KnPHyZ2he2ZEneU9Wi4xo32mUyCWqsfpTgpq7AlxqeIRam9onzRO1HT7eUY1wujZ7uejdmnJvifVD68mIfRkbWxanDPHfMXu98jBThGyP96bqoSBpOkVQ5eYkufHVOPfpBNq5KHQQjY6JeW3kzwWMA6iM+QtAUXa8hbsO4xD9DgchMh04LzuH0wHhh+vt3p4KQJAaWwA4Z509b+X6kbRFy14NW9bArcZVpcXJEZO8Mlm6PApTNbn1D7thFi/2yu7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VS9VNDlKZjdlNTFyUlhyMk12RzU3OFhQTTlWelZ5VzdnZk00N1NnSzFLR3Ux?=
 =?utf-8?B?dW9tYWR4WVd0QmdTdEpNTEt6WVZub0p2dEEySVBJY1c0REZRbGk4SUVQeEMr?=
 =?utf-8?B?WGRxcUlWUWRRN2k0OFhqUEhQMVQrRG9wUkdaOFVHT1pHU3p3amhxUEUrV1Q5?=
 =?utf-8?B?d3d4SVE2M0gzT01oeENQR3dKOGJQbnZLQjVva0RKTUduTjBCUUlPenFWdG1N?=
 =?utf-8?B?SXc3RXo5S251UkFDUXp5eWRUelBNNXNSNTBiSlpBQjZoLzZuRk1FSVAzelEr?=
 =?utf-8?B?VkFPK0JYd0tjUUF3Q25rQnVnMFdKQ3RVem5PRndqMGVhVm56Ry9OUkJnNUVt?=
 =?utf-8?B?dmpEK1VUZTB2M2FCbE1wNzJDenA2elF2a2plSkpNcS84cjNMVno4Tk1iVUU5?=
 =?utf-8?B?WHhLV1NZR0JjVnBDUDVrVjJQLzdQdnB2WG5GUlJnc1NVR3E5dmMxeVhRVFRM?=
 =?utf-8?B?RFhsUG1NRnRJSG1WbHVuejc1ZXJYbmh1cnlOekZGMEtlZ0xKQTFScnhIelc1?=
 =?utf-8?B?S0puQk1SV3dTTlVlbmtDV0VaUGE0Q0ZtODI5SnhLQzRpRXo3M2JzZzdFYmdZ?=
 =?utf-8?B?ZGtzLy9SdVljVUdsWTFnZ0dUcWY0ODNlMTA3R3cxWlZNSmZXUXVrUnN0V3pB?=
 =?utf-8?B?VnBzR2ZrUjVEWW9mOUlXMlU1Y1d0TjdlZVhIcUxVOW5oTU1wQ1Vsbkh2UkR5?=
 =?utf-8?B?UHE4RjREYkdTcklRN2Nnb1lPODJaRFk1cE0wRUZMM2JKZElaMWc4M2l2cExS?=
 =?utf-8?B?dG45NTdsS01aUlphME8zRXhzR0ZwWXJOZFM5K2hDZUM2b091M1RkZmxlUTNv?=
 =?utf-8?B?K1U2NjFuNUpaUWx2Y1I2aTd4THFvbHVPazZRRmhNRzRKMmR0ZFdHdTZaQUQr?=
 =?utf-8?B?dEJoTVhtTHBSOGkxVHEvL3FwMUhJQVlTWEpYeW1MTXVlc0VxNWs4K0g4dDh5?=
 =?utf-8?B?eXB3V2RZN0pwUkhrL2cvN0N5QU1iM1AzRVZrRHZudkx2QUpFcEtqKzhiWUUx?=
 =?utf-8?B?c1NMWm51UlVweG13YnpKZGVoY2NxME8vZ3FMeG1UUWhHclkxNHZ1WGFxUXBX?=
 =?utf-8?B?VjNScFpnVVVQdHNPMlM5Q1dGYjZ4OU1acExBeVZ2OVVDODB3NVlSVGdBRHJo?=
 =?utf-8?B?WVUrRFoxVmdURlFvR3phQU43QWk3ZERaNHdnVlhDNXpvSnpFWTBJaW1hK1hX?=
 =?utf-8?B?bTJQRllicHh5NDdUalRmTE90SjhDWVR5UVNqbEIvb1Q0cExiZTE2MUl3Tnh5?=
 =?utf-8?B?akJCZkRycjh5bkRoZkRxbGJzUktuMmhPNjVHb1IxWWI5WDdic01uZjhvQi9k?=
 =?utf-8?B?T3FZRVAraSticWpueVArOTlMeGc0TzRlWWdGK1lTZWxCT1pnemVxd2hiZG9y?=
 =?utf-8?B?YTlCNlR2Rk5oTld3YWloMTMyRmxTamtiRWVnRVVLREFpbFdXSDBoem5TZ3Vk?=
 =?utf-8?B?NzZoWktoY3pJMFEzdENDOXUyQUhsL3pMdGY4WGEweVd3YXJXd2tEL0ZrQU04?=
 =?utf-8?B?YWZGV0tPNm5TNjFLUjVpL0JLYndvUk9Mb1pyMEhzM3JDVjZWOUFlQXZnNUhj?=
 =?utf-8?B?Z3I5S1NjVG9kc05IUmZlWm1JTER0WlBTUmc1NnBIVzh0M3l3QkNURTl5aldi?=
 =?utf-8?B?UndaRXBNOXZWVk1OQ3ZzL04xVnpOd2gzY3JxbHY1SU8rMk5sU0RZWXYwMHd6?=
 =?utf-8?B?VDBZOHZJSXV4eWM1Q3ZyT1JEVmJJSTBtUm05U1E3MWVmejRWNnZzN2x6MW45?=
 =?utf-8?B?TzFQVTNhM3c5dmx4UGptMU8zQ1YyRENmVGZyM1ZwSVFpT0gveE1PZ3JtUUdH?=
 =?utf-8?B?T2lMRmZXd2hxL3dWbkNaSXBIOVUrK2pOVGpscTF1M0hKbFI0NEswUU0rUDZO?=
 =?utf-8?B?dHZQbGEzNnI3UGJZYm1Fc1pZeVJRQXlXSXRtZWRrR3o0MHZnQWZpZzk4MXhN?=
 =?utf-8?B?ODcxQ2pzV01rR1ZnckpOaHpZTzhYOFBiWE5YWlZCNjlWTDlyWlJaN2t4Y0hV?=
 =?utf-8?B?Si9CcE1XWTV2bzZienlRSGFZNytLZWJEcFB2aWFkZDBFYUtseXBkMVl5ekw4?=
 =?utf-8?B?V09LYlVKMTFlZlVkaURJWXloT0tWNDFsUnNnZFFiTU9YOExzRXBudjEyazll?=
 =?utf-8?B?Q0ZqY1QrMnZyOXB6Y3EybHh2dTBlL3lSb21sOG9TbElRTWlBSTgxamdROXJR?=
 =?utf-8?B?SGMzblVQNTYrQnh1b3B2T1BVc2xKWEhsdHZNUkZMY0J4MDUvK21LMDJtTUk4?=
 =?utf-8?B?S2o2aW5iM1NRaU5Sa3J6MHJZTjY3dWhadlZBZkZIdjY4US9IRWVESlIyWkRB?=
 =?utf-8?B?ME8zWVg4aTQrV2lhRzgyTUh0MEliTEljZ1FWMFZ5SGFBQmJKaU12Z0lFUkE4?=
 =?utf-8?Q?CM90sg3co0Gns2KUSC1WCGSlcfONYED3DlBHj?=
X-Exchange-RoutingPolicyChecked: VM6NW3rGTlbvPgz4SE9FNBY73HCcNNTEpr8HZ40Mjyd7GSJPBM6SpCM/3sGHu7yzG3BmWwMgxQK4eEYLaFEAB08lqNwZxat21BQR+w/+djLh4f5T9yCvobtzTj/KvRtQAOrz0l484FEYUVzjh1Pw9Lunng8soz82I4BgWJmmbLZsabvo7HyOPHeI3lC3cwDDX09SFscIAY4FQLWNLPf+48BHuOQ8Wb5+PXhNZugYqAoD+Wg1t5/36Df3/HVihFwC4JqumSmyjcLLXS0g1emhzSxGS0boNQGQcdlYdtStEfievw73hOPnRFYo9okO5bXOGuB3ndXql6qcHA08igpGbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a04e045-394a-4080-8cd5-08de832dd12a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 07:29:54.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CR9lw/A+eQvFU/Oo8gaHByLuqT+6wRmOGXYiX6Uv2xapWUXoUoOqOUGWvLcO8mdUMMGpsdjBXOqYeqebzkiBTGFVuTlH7ljHBoi5LEA9xXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9758
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225508-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4A7162959E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Harry,

On 3/14/2026 2:15 AM, Harry Wentland wrote:
> Would you like me to pull these into drm-misc-next? I'd love
> the changes as base for me next patchset.

Thank you for the reviews. Suraj(in cc) already merged them through 
drm-misc, they should already be in.


==
Chaitanya

