Return-Path: <stable+bounces-144382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A17AB6D35
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D802F1B60BCE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379818FC91;
	Wed, 14 May 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4MAWjq9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299622615;
	Wed, 14 May 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230536; cv=fail; b=JPmpZAmEbfZsa+KlhwBVDVu6J8DapI4IvMiXYQkgcaOao03C2oQjz4DwhJ2nAzcXZHgpj3ZKanwOZlGgOOQdgF54jco49S2qca5bppQXOoXM+tp1bihcXSbVDT27VZQlc+MlpSWJAUoRlLuyC6kRcKTH2+8nSbCXh/+1gElagdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230536; c=relaxed/simple;
	bh=HG6A3HT7n2aXwasTfr9Sq5++f6zEZNj0ku9q/qJ4AYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k+/qWr6lWFL62KdeT1DoY5Bf/ZN+WfiJvgwB7+ZlWSZcNvn2OeZMlj+8TnewN86sKDstnOzCzPprjJk0WSb8gebm/NfHbO/3NOHVvXTVyYGnOvHBE5upIWN+KphJpIwa9vQS26r/9zdGS5/GYI/qag5RmbvBbpxTjDAdQnhDx3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4MAWjq9; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747230535; x=1778766535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HG6A3HT7n2aXwasTfr9Sq5++f6zEZNj0ku9q/qJ4AYQ=;
  b=W4MAWjq9b4uY++6IGQy+nmesEwwEGBIHdSHKfc64UYxve5k7ljqmqk2Z
   6Xao6R+ro6gJ6wx5hxkBdZMLvW1FkcC3uckfDau8esTDFFGqCna5j1c5v
   PF9NqwlTZ6tWjTNo3FWPsSS7PQAzOh8c0EeLW6+n4cOPWo52Lo+R+mcDy
   tJ4nBGI5gjQQYUkwlISiEu4S7FSFk9NEUhORQK/huxi+0n23iMAXpMWA/
   Rd6K6GMV2AhX0rDp/DwB3J7fMzBz/Ikri5Q97id73GVsTHAlRp9/+Y1RX
   S4Z2mmIzVUJE1lahunajGtHaOYwZHY8mXkEghdDzk6xqokyoDePfSd94n
   g==;
X-CSE-ConnectionGUID: IlmTSAlkTj6zoDgd2V945A==
X-CSE-MsgGUID: iFEhB16qSoih4EK+Z3unkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48239280"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48239280"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:48:54 -0700
X-CSE-ConnectionGUID: cMUTD/mwQnCzE0LlWB3XVw==
X-CSE-MsgGUID: Jf0B4chPQXWNHjPhYZZsog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="137922661"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:48:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 06:48:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 06:48:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 06:48:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdwSC3worgQX5YzFK8UuJwFgF0ZfDGuruh7vln79DrgzPMpcDUyGEUMZwg9gmHgrYQYrj8/YvhKAxsncNkW7xjNuyawEBr9FrfMjO4LOGXdW4USmTR/ej/FcDxFIFFjODQ7fAbhXsWfJGPy+wh8EfBMPUY2NAKxg3NImpQ5LniPZjTmwdyCsBDwNqEcXidLlfN+Uwk9ODBYJMVJWIBZIBdcyJke62ZKnZJ5yQnP8skddbDWcbMN6ljBZtDJyqIlnKfMLRoUmzLWHria8u3Qei2eRhr43IKBX3ENaTTCv/eptccH1x/e/5DUcWy//5N31yjLGrQkPM6M1wK8E5jDZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm9bk7UfQw4y59XMuZw1Rv99JSMUeIqsN5OPF9IrhoI=;
 b=Os/2/aKo0OuTTl3W2Zj4PFSApCph96h+wfWdXmqn8cdnRqVhy/hUGfQhAHoUeW0Wj8VBdT8ADB2D4dFDlZhiauUXq2pvWQmrEjkzt7Bna8hNTum9cc568lGXtjufAp6mKslWHb+YgCtjS07J+CfTb9OVPEREIdhMmnD2p0D8esrxJC4zrBVyeRR0KWDfLmJOMJDQnE4ctYfiGV/eJ+Dr7uWtwhn7ewUZzkYQJ3ESyCoxsG/PuWSbnczb4oysZlJ7ZgzXVdjTW+yvWAdA7xHjnqdoUZs0iV+c/WM+k2JxMF5J3G7Aau0ByTKxt4FEpkwogLS51DnyV0ponpBIpkel3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:48:34 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 13:48:34 +0000
Message-ID: <ac635ae5-5486-4243-901d-701f2ee90809@intel.com>
Date: Wed, 14 May 2025 15:48:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: Add null pointer check for es8366
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <kuninori.morimoto.gx@renesas.com>, <tony.luck@intel.com>,
	<amadeuszx.slawinski@linux.intel.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
References: <20250514133409.713-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250514133409.713-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|CH3PR11MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f20bd1-2711-4565-f4ef-08dd92ee04ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjFxcGI1WUxreE1SZHJzSkl0RGY0bkZ6YjkveVlqMzkyeVdVZC8ybUhyVUNL?=
 =?utf-8?B?c1NXQ1N2TFBBQVFkOERrdHJXZW1lTjhrUGp6M0FURzlIY253RnRpYXRHdXRq?=
 =?utf-8?B?dllhWmIyaE9qeEVraFg1aTRJUjVxUXovY2pLNnVqcmo3MlpnY0FIYjU3Q25z?=
 =?utf-8?B?UHh4QysyU3gyTzROVzNtT2E2dS8xeTRyeWQ0UW51bi9FYlZTZkVENUZLenE5?=
 =?utf-8?B?a0NEaFZWMER3aDNmSHlHaGNad2VyU3duUDZ4VTd2U1NhMm5qUU80YXRBdHJ2?=
 =?utf-8?B?TjRPcG8ranBuUkpQeFoyUkdEZGpSNWFvc3dPQXF4TE5EWGJYY1VyaGJGU3ZL?=
 =?utf-8?B?L0lwdzFPdEZvTzdQNnMvWkMwMUJzeEwwVUY0TElWbFdiRmJSbm54Um9xOGRZ?=
 =?utf-8?B?aDhxRk5Ba2FQV0ZEOGtyTWRRRFFhY1AzNmVneFMxUFhsTGxkS0pXSFd6MktH?=
 =?utf-8?B?emljSHdVTUFWVWZ1ODNmQkFZcmk4VC9MNTRwU2pDcnJBemFUOEt5VDZYdWwy?=
 =?utf-8?B?RnBZUXRDdmpKSWVLc0dBSEZHbjM0SDI1MUxkZ2tzNnk0VkdKczJBMnJwdEh0?=
 =?utf-8?B?VnRCcDJJY3pobjZGc250QWQxTTNLYml5MC9QVGs3MFBEd2ZpS2ZDQWJGSGpE?=
 =?utf-8?B?Z0YzaXZYZi94QmY1VEd6YW00YVorRVZoaXRHQWlyaXNpNzJ1ZUY5UlJVaWx5?=
 =?utf-8?B?cjJDeEhrY0dMOWExbFZQcGNhRDIzdWhhQ2hnUE9iTWxsNCsrNCtENlpCRmJK?=
 =?utf-8?B?VkN6b2hBbzdJQUdJblJKK29sSW4vbUkvblVMRi9EUzJoYm9XUGlNRkNDODZs?=
 =?utf-8?B?dVlpZ0ZHaEdiMHBac01RdTE0cGtmc3R1WEpsN1pnRFNDaDBKaVlqQlF6YmFQ?=
 =?utf-8?B?SGJjWHlKSGVRaVZPNnF1NTc2ME80dk5PRXdNMzY0RFV2MHN1aHAxWUJJNGdP?=
 =?utf-8?B?REptMGppNFVzaTArVnI2Yzh4NGFXWUtLWUZWLzBROWwzclRuWEllRWVKTENY?=
 =?utf-8?B?RXVRTlZ4MnFjNmRJSDVsSkhlT01mbmdSbnVVckEzVW5yYzN5UXN3c1o2OTFy?=
 =?utf-8?B?WmQ5aUdGNzI5NmRnR3BYVHUwUTA3NVdQT29CeE5yS3N3MHFNekIxYWw1bHZa?=
 =?utf-8?B?cU1UYmxwMWg4ZE1oWU5kYTV5MUxPdkFzTlMrVDlIOEE0VHNtQmhkVHgyRGZT?=
 =?utf-8?B?WHFLOE0xdjYwQjRQY3lweDJqVVhlMVR4VFp0N0JqVW94bE5IQzNVamxIeFpN?=
 =?utf-8?B?S2FFSlg5MXdwbi9pblYyUkxXcW9CeTBoSXArWXBYRjFRNmhsSW1FSlhhMnB1?=
 =?utf-8?B?QXlqZitGZ0c2eGJIeE54MUtQbUhqZXNoUk5hU0RDRUU5NmJMeFBhYURoRmRD?=
 =?utf-8?B?Y085blRBbG1CYm1nNVZDK29tb2hIZ2RFbUF4dEVZM0FIak4wZ3lGNk1lRzJK?=
 =?utf-8?B?em9lcXVwZkxENXdueENqQ294WDRjNTQ1SzFOSWFSZ1VOVXg3Q2ZERFA4Zkt6?=
 =?utf-8?B?dGhVMDQ3VWgrN1QxMVJseUhSNHo0Nm9SeGdRdTJLL0QyTEhMTm56cUVyWXpX?=
 =?utf-8?B?bElxdU9WakNGbmxaZC9ISHZsUHRhYnNOaWZBR2ZOMVJ4R1FrcE1CQmN3Um8y?=
 =?utf-8?B?SVEzT21lRDJVSC9UVytMZ29VVGlPeDlQeWV5MVYxUjlIZkp6T3ZESm11akxK?=
 =?utf-8?B?RFlIbmYzaURRdmo1ZmFuMHFTczhMZmtDS1QxQkQ1SFgwMEtMTjJqdk5WZ1BG?=
 =?utf-8?B?SzdTYlNSRkpiRkEvL1NrTnRGcDUwaEVQKzVGUmVzcHRaYW5UUFVCQmwvYlk5?=
 =?utf-8?B?NTAza0lrYTJON0RrZmx0bDd3T0JpUTR1TG1BTGtYK2kxUEpEalJXRVI2d1Aw?=
 =?utf-8?B?WW9PQiszenVRaWNpN0hIK2J5VnE2UXQ1VTIyNjEzWFRBZjByQ3BMTEdRcGt2?=
 =?utf-8?Q?dTmq8oC335U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFpPUGhEZ0FET3RodGpGcWhKeWlRYUVSYm12N2NubnU4UGR6cjJuN1VJWEhP?=
 =?utf-8?B?d3JnM1VSemtrVkUrNTdmSGhjc2pkVGRTUXo1UE9rM3F2Y2FTWjEwenRtakdm?=
 =?utf-8?B?cmU5dElGaFl4NUszS2o4K1Q2RkZ1aGVZaXpiMkxTZ3hmdHExNkYxcm50ejJo?=
 =?utf-8?B?UkptbEJKeUhHVDY5c2ZzSGZnTWlDSnRyMUh2cGszM1A1UlliL1hHazREZXdI?=
 =?utf-8?B?RE5ySStjc0NDRm9wQU43T0hiekRMOXR4OXFrWVFrVk1vcnVkZkJqcmlLbEJS?=
 =?utf-8?B?ZkU0WE5tWVlmeGwwTHV5Y3BzQnJEZ0hHd1MzS1ZXT2xIUkJnSDlUQ2x3QWdj?=
 =?utf-8?B?T2w1b0F4V0FRK3dzTXBwbU15QUo1SHVleEZmVkhFT2tRQnErS2hKbHhGL1NW?=
 =?utf-8?B?VTFLVW9PVUNYOVZreFZUVVNOVHcvMHdXNDU5VllTeVlBcGF6VXpWMjRwc3Zl?=
 =?utf-8?B?SkRDRGFTWUk3dzU3THNmZ3VsSHZTTkxNbGFXdE1XNi91dEFmM3JnYVFxUEdt?=
 =?utf-8?B?cTdRT3JVeDVibTdieVhtSzExY3N3Z0dSSHpiQ1ljNGZwQTZtbXhXQ1BTSUdF?=
 =?utf-8?B?Q3dZT2E1U1EwcVRsYnlLMmhmZFlVMklOMnU3dG9ybXFKVnZ0eXhSRW9ZcjIx?=
 =?utf-8?B?dXhxK05QRlpHb2twN3plZit6aGFHbDhpVlVBU3B0eXU3MjFWeCszQnRHeHZH?=
 =?utf-8?B?bEhHZ0VXc0U1VnJJb0t4TENBbjBCR0puU3hPSG0vam9nbDdhNXhwTVNrVHh3?=
 =?utf-8?B?SWhWTGY0M0dNbGJXRlBiWjFGSFdBbS91aGZIbEpGNlZyWFU1c292YUpQUDRR?=
 =?utf-8?B?TWphME1uazlZK3dYYnFScm5MaUZxWmMrTlp0OG5xNlMzOFY1RzJvTDNBUEF6?=
 =?utf-8?B?Z1ppOWhOV2hFMXN1bngzN0I5a2dDeGZFeUZhNjVLR2JiOTNJanE3NXB4bjJF?=
 =?utf-8?B?cW5hOUprbXd6b1YzRGhVb1dvSkxUTXZXNWw2UDBmMVJvVjZtdy9MQjJqS251?=
 =?utf-8?B?NndIbDRQN0tUaEFxeHBzKy9aOVVWNFdRZkJpTkRCUnhlNHM0K01TZ3JFUHB6?=
 =?utf-8?B?Skd1MDJHSE40aW83SmM4eTN5VUJqdDNHbWN6NXF2Qy9qZThYZ20yRExnSDQ5?=
 =?utf-8?B?aDVZYlZISExwRU1uK0hJZzdOOTNpTFc2V3BJNnppa1NHYXArdnhVYjFWSzZw?=
 =?utf-8?B?VC9LdVJsRUN5U2VjalRaa21VakxCbkhHMVNhb3ZsaW5zOFRZTVViNmRiM3Na?=
 =?utf-8?B?WWtBYXZWeFc2UHp2VHB4TnR4dGdkS3pWSncrL2M2dDRVVGhrWE8zOXlWYTZv?=
 =?utf-8?B?QzZWcWYzQ0JDWXpxMy8reDZldzI1UEtvRDRHL3gvS0VMYWJhdEp1UUsreVRk?=
 =?utf-8?B?WFFyUjFwNHNwdGtpang2R3duaHdDdWVFTTFzdmxOYWNJdmNMbFIvZUJkbXFT?=
 =?utf-8?B?MVR2ME9seUFyUnhwQzl1TzVLcTJzMU5TNTdkb2svNmtqWmJPem1pN3Z4UEls?=
 =?utf-8?B?VTFkVWlaYlFPSWlQdUxkQ0xhRzRKbkNRaG8wS3l4ZmllWGZPK3hsS2hoTXNl?=
 =?utf-8?B?anFRdk9zc1NJZEFqcjd1d056K293dHhkdW9IT0FaWVUvR0txL2V5TWhqaWxX?=
 =?utf-8?B?VkRuaUMwSm0vSStBMFc4aERrWlhLZWlBQVAvWERUYk9NcTVhWUxCWENiMi9k?=
 =?utf-8?B?VExpSm9nSE1XbjdJREVyRFBiL2IzeitFVjFyWXF5dUlrUUpGWnR5SUN0YmIy?=
 =?utf-8?B?UHIrYVZoVktrK05sVVcxS01FQ0hOWEc4SjVaSFVIT1F0Q2ZjMlRoZWF4TTgy?=
 =?utf-8?B?Z2RRdkowVzgrVmRpaHRQS21qRjZzYlgzMndLV2s4QksySldQTVpFb2h2QWww?=
 =?utf-8?B?YThIUlA4VitNMXRUZTYrcW5ldU83aU11ekM2bDZZSnd4QmtGdmJ2M2tZcTJi?=
 =?utf-8?B?bEtFOEJjSk1GeGZkN2JJTGhPUURNaUZaZUcwSWxMdjRXNzNTZ1dWTkZQK2pm?=
 =?utf-8?B?MkJxMXBOVzdheEFIQVZ3N1QwR1VweVpuNFNZc1lMYjZRdUZaeXUyQTJmdGRj?=
 =?utf-8?B?aVpwWTAyak9JTU5Fd2FOWk1EK1JVSlMwSEFXN29CQzdpMDZVZ3NWVEl4UjYv?=
 =?utf-8?B?YnEvTmo1R3BDSHJxN1YyMkZDcGtxTjhBSXhLb3pHRjNYTlVlWVFQQksrOWwx?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f20bd1-2711-4565-f4ef-08dd92ee04ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:48:34.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S0Vwv0Mbgnn6qYYtJjScfvDmpqdWQPnmWLJ1ropfLnNFEHWgudu/Aizu/Kna2dSQj1kSNmLyPHD8xxXRUlq0rfj4cA8h9oqyDFblsS+rZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com

On 2025-05-14 3:34 PM, Wentao Liang wrote:
> The avs_card_suspend_pre() and avs_card_resume_post() in es8336
> calls the snd_soc_card_get_codec_dai(), but does not check its return
> value which is a null pointer if the function fails. This can result
> in a null pointer dereference. A proper implementation can be found
> in acp5x_nau8821_hw_params() and card_suspend_pre().
> 
> Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
> pointer dereference when the function fails.
> 
> Fixes: 32e40c8d6ff9 ("ASoC: Intel: avs: Add es8336 machine board")
> Cc: stable@vger.kernel.org # v6.6
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   sound/soc/intel/avs/boards/es8336.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
> index 426ce37105ae..e31cc656f076 100644
> --- a/sound/soc/intel/avs/boards/es8336.c
> +++ b/sound/soc/intel/avs/boards/es8336.c
> @@ -243,6 +243,9 @@ static int avs_card_suspend_pre(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, ES8336_CODEC_DAI);
>   
> +	if (!codec_dai)
> +		return -EINVAL;
> +
>   	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
>   }
>   
> @@ -251,6 +254,9 @@ static int avs_card_resume_post(struct snd_soc_card *card)
>   	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, ES8336_CODEC_DAI);
>   	struct avs_card_drvdata *data = snd_soc_card_get_drvdata(card);
>   
> +	if (!codec_dai)
> +		return -EINVAL;
> +
>   	return snd_soc_component_set_jack(codec_dai->component, &data->jack, NULL);
>   }

Hi Wentao,

Thank you for the contribution but we do not NULL-check the result of 
snd_soc_card_get_codec_dai() wrapper. The machine board driver (also 
called sound card driver) never reaches this area if all the CPU and 
CODEC DAIs haven't been previously accounted for and verified. Flooding 
sound/soc/ with such checks is a waste of LOCs.

NACK

Kind regards,
Czarek

