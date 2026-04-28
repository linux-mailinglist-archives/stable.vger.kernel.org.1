Return-Path: <stable+bounces-241497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFrxEWhx8Gn9TQEAu9opvQ
	(envelope-from <stable+bounces-241497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:35:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEBB480406
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9509313EF28
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F863DE448;
	Tue, 28 Apr 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aotzoqU4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833B3DA5D2;
	Tue, 28 Apr 2026 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364854; cv=fail; b=pXeNCzACdfPX52xfJFzK7qO5zgD35WVjO4pppBmMKck6C0nmBnKUymnMovseRFwmsPsN+ti2m1T26nDVsdULBxPEe5gw7ClDXlYRI60trNQiaasmG/aXvd8U7utYzNWRclviQgYgHlVVTVx77v+1g/sdcIBC8nYxFl42gx6xWSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364854; c=relaxed/simple;
	bh=IEhhOOaTANq50KeUUokP90UMbiKIIRgzeaEmK3fky1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CYycjQ1PYg/5Q5OwiJzJQmNvI9cvOTeSAU/TeZ7j8wr0J/F0eUBW9ZQ8hPDRxbY08o1zLNH/gh5/9r4QZa7+M4a5E3M3LVb8ZmbJrCuMspaoLhXr9ISe0OZYHzFsuwaJ/KVTfSeqLEiWsPzhGSfJiUdWtJdGC1lrtyiei6up6Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aotzoqU4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364852; x=1808900852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IEhhOOaTANq50KeUUokP90UMbiKIIRgzeaEmK3fky1c=;
  b=aotzoqU4Gzf879dLKmenMPfT9FZRGKCtSar3V9KIdoOQxp4DiYigdlYL
   WtQDWx94wHlQGlRg3yDfhhFFFuLIDXwtYhoCwNgwn9ED6kQvW1j4oCYFJ
   fcGN3Xbp2joG2HS/gcRkhFxC0Oa5mH9KeKjN+eHMb0apVLLjjwTqyGFML
   EQqcBHcw2ktX2dVDqgSdT3FXeg2KK4uYB9Bx+10WtrV5TL+XEadD/W3v8
   cR6TvnkK51gfsd+NxQxwcMWqHYjJKzP5jDVrweoDvcOdlGlgqTFUPsYTY
   b7kRNcleL9YO32U2E35GohPlXDmvC4cM39SD1vWsb8plxp5bFSlDJgx2f
   w==;
X-CSE-ConnectionGUID: t3jl4uoJTOqGMzrcFIqBjg==
X-CSE-MsgGUID: oi8NVvKpRLuMmRsqVqSrNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77431293"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77431293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:29 -0700
X-CSE-ConnectionGUID: Tc0KHaJrRG25oChOZYXOcw==
X-CSE-MsgGUID: IPGVGyUfTEm9oFoeqLCY6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="272020432"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:27:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:27:28 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:27:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROUCJLGJW+/VhQxuOmmYhLhfyWOcLhzU5hapXlaF6XOjiZvrmS0p/GUB90b7VSiOLbNELMgyU2yT2lOJOjm9urO4mIQwE/6Va4zFSzY/gW71jAFTGxVjZZuVKz4YYmz0/qZiZ4zFNAfIg0hGz2KwRJBu7UKX5YTBHvqXKZigIRdTiYC6QnkUblcNSN7z7rOALqdbKEKJnHZm9wRSQ0OabtZ98UKqk2HlPPX8KBgf7ifq4CetpV06bzvF4Jw6XCJoVHhXl7zt+CrLLKe980drqC6UK0vJdO4u4E4kwURYq+hq7t9ddb6vf/4sZ0C2Ow0a28lWQein/HH2JcApMaALqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0ERwsKQ+St6+QG6MZ7w/N9hO574G3t085N5WnzAva4=;
 b=djVmSl4fuPjmd/nx6J1DwBTqlm//mWodktEVudbJqa68XrDxB40jSdYpRODRVl2ZQaeNtjyKcEtuR1GkNrUUYWp9E16dNCeP1jb8oxHp196ws0SrUSnxhiEYnajP49R0boZQN3zTkpJRyZjaVnyVc9ePMaY5+RKDNL1TKUQNSjwgzf+1v1aO+/w7BQLNQFGilwG9774hcB4oprNfgNBYEq63/l6PP5bvbcqICgg4HQg3/xuBiiXRTZVVJx+g5hn756EgDK9y0Jlk0Q69A6nGwjfRyx1GEAZ42OqKwMTya98qwAo0N1LBhAmvygaRdowbfFH+/oem+o3fu20YNM5VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 08:27:20 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:27:20 +0000
Message-ID: <a496168b-409d-4270-bc41-70737b9b4a25@intel.com>
Date: Tue, 28 Apr 2026 10:27:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on
 platform_clock_control error
To: =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede
	<hansg@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Charles
 Keepax" <ckeepax@opensource.cirrus.com>
References: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:803:50::28) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: b50c6059-35fe-42d5-1f5c-08dea4fff74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l2H+PpCR6f347imPNwtrjA9Kby/FVq6PzMz/+U6SHK6pqv3HkggEgFmUJ0gW73wBKlgstzh1Aqzeyo72jAwL79vKl6DrJJRoRgVPbOQ1pOcBx/S2iQ7nlPC9fFbifV9O7SRHapdG+fXNCZqwSeP9GQR8Y07NNjVklpkPW+Qqk78VsjwbnSwQ2t/Q/Yz+0Y9BY5Hpcjz8hBlCqJJ8nu97UnvIID8mUbywrpqkrs9gLbTWCTzLS3TyE0TD2100hcMK1jBKTeG9hhsyRcNnH321qXCy8Xaci7iXFd3cxRQgLt6Zolx0wR5j1xXKdQMU48UqlbI7bLFB1bZi0wd+gvf2CUwVcK5+jrhwZcgVpGkRJAMWqQVDn1A5v3EHtkJEImzQoPpVHZvMt/pW2wAUp3HMyJXd/zbmR9NFyNy9AW/SLjKuaNd5P1LYk4gYUX83cJ3gD+ITomtrPEGau+TxB7JOs8zF8vgoxe0UjlAowoJwjuYsUfUfxBcmXSMrQV/oQi94LTmSkpNBfjMcmi9Lt9xGq9QmLFJm4BLh7nGpUnZix/9RSk6sJ9Ab5KoIfaCVmeRGXEiGuxCkjWU/oIQzFIeSKUmlUyctJNORKpk+sQ1HMepC/eXajkh+ZK5HMpZCpNVIT/IIk5kiSvHgX2nxFW6VAlqtq4yGHEnv3r8tDtvQhsq1TdZaKiekZYF8Vexz2pHzaOiEBQlMd1uaBwaNVTsaGnIQBIpxT9d59H2cttizR4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZiN083a1UvUWlFVklWcDNhR3FKTS9sK054Vk1QYlVJZHI1dDE0akFGMUp4?=
 =?utf-8?B?QVd0alFOOG9VaWVPTHhoWmI2RUJnOXpHaDZuRFY5alRqSkxpdHF2RkJENDBo?=
 =?utf-8?B?czZicFZDQVRVTkNuRjh3UE1ORVBrdURWVkQ2ejRaZG84VUhZWVc0VG5ZSGJy?=
 =?utf-8?B?M1RKVXl6Q1ZxTDAwbGNyVFpMeHgyMGl5ZVNvck02ZkpXQXF2NFBSTDRMb2Ur?=
 =?utf-8?B?QjdWUTZoQXpaQlJuSmNqRkVqNzcvc1dEbVVBUGhzcnp2bXpjazJESXBnaFgr?=
 =?utf-8?B?YjhKRFNqNklyT09zVEdYemNWTmJTQjV4QTJVSzhwWW8remxzWFNnZnRhb1U0?=
 =?utf-8?B?ZGI3dGQ1YkpabGgvaXM0OU1COElDcmlJMXZCanRYNEUrWm9wU1NSVDlqeHpU?=
 =?utf-8?B?SldXTk9NaU0vdXVwSGc4VFppRlMrVFRoakFReWxpTWkvRnRxQnowRzBDSFR3?=
 =?utf-8?B?aWtwVmN6RW9WRGZhUENoWlM0OWRxN2tRaUwzRlQ1cjE5K2J5TUY3TEZEdU5W?=
 =?utf-8?B?NnplWkVtRUdJdXVYS0hQR0VOVkdyYldXT05ZTVc2L2RpNG5Fb3M1RkdvZW9D?=
 =?utf-8?B?c1k1YjllcU5ieHQ1L2c0K3JTNms0d3QyQytZVldXcFovNVVNdUIyYnBhSFFW?=
 =?utf-8?B?bWhnUm1PWE1zeElMaUQ0dmFod3gvcm4weVZ6MzJHY3l5RTJWcnNMR1dqYWlk?=
 =?utf-8?B?TEE4UDlpMXpiNkN6OWFHUmo2SUk2YWx1N2puZnhIdWoxQ0JRK1ZMVHJkZTJW?=
 =?utf-8?B?TnRoZUgrWkpQMEx2VTVaUjBsQlJjaDExcVFsVkNLNWNqWjVLaTJkcEExd2tD?=
 =?utf-8?B?SmErZFNCUWhCcnZDL2hhRlZTZnh1Tkxod3dkWitFN0hkRXExS0EvS2dHRHUw?=
 =?utf-8?B?TlBjeFdNa2hiUU9oNU95ZGVlUnVxbFhsZVpyZzlERVg0dFZ2NXR3a1FxK3Aw?=
 =?utf-8?B?MEcwOEtzNVlwNlNIWVEvejhjN2t4eFVkNVgvd2p1c1o1MEFUc1Z4aW5WZzI5?=
 =?utf-8?B?R3k2bVovNXFvejBXUkVtVnRxZ0RpYjlPZWpZcVBjTmhURkRPYlhBTWFibUNE?=
 =?utf-8?B?L0ZtTHgzSUhHa0U1cnJ0dDdkT2lISUVnOUdvblAzcCtRVDZZWWQ2bDQ4K2Rw?=
 =?utf-8?B?bC9wQ3RyK1hvbzA5bzh5ZzhySVgzZENlTzZVMlNnYVFrMlNHdXA4ZmM2YjJD?=
 =?utf-8?B?N21RQ3U5MDFMWkI2aGsyaU9CdVJ2U0NqdHdYVFE1SXdwOXB0NU9KOTF5VnNG?=
 =?utf-8?B?SXF1em5DR2NtbEFrTHQvSlA5OXZYd0h1LzlQRktWR3cvMTRSTE5oN1kwZ05L?=
 =?utf-8?B?NGpVMjdTaDJxZnlVU3lEWG03S3owZGNvV2xuM2t5NFo4NTJFRVJtZWdVNXdE?=
 =?utf-8?B?d2UvSlNXNzM5cW9LZ2JsMk9LeWlLekxDTjdQQmFBYkxNSHMyS0lpQ2xQYmVI?=
 =?utf-8?B?anR2bFFtVXVXY2JIM295eFR6WlNUQmkzQUYzdFQwbHc4RkMyRkFVTFJIYlRi?=
 =?utf-8?B?bW8wNUJJeUFUbGM2U0RaeEtvRElYVmZLRnpaZEE1UDF1cWR2d1g4MmlTem9Q?=
 =?utf-8?B?V3NZNkk4Y29ML2I2K1ZnN0ZTbWltKzgzaTlvdWpxZmI5Y0h6aTBsNXBZWjk1?=
 =?utf-8?B?cjhXd1FuNThKeDY5WFo1QXk4NXhTOWJxaFZST0RTeTBaWmsxVmdKUUpqOG9p?=
 =?utf-8?B?ZHRXUzdZbjJ6WjlqbmJnK0FaYXpBRWRGa011eDNKbGFRNFBFcGx0bXl3R3pm?=
 =?utf-8?B?cElMQ2p6RFNDZ1ZCaERDSGJnZUJKQm92Z2w4Q3VQUmRaYXpRSHJ0alVWL3FQ?=
 =?utf-8?B?ZExKTFY1U3VTbUZMc0RFOUhmeXExcnhyQXJiYVRKa3BUTHAzU3dHK2VwR1p3?=
 =?utf-8?B?bWJma3VBaTZOTDBlbVo3WW50ck1QeWF3blhYOHQ2MVBQWW1XVHVtZDhtYXRv?=
 =?utf-8?B?RmtCbTNmdHhERHhYdHZhd2hIcjcxVVYxc3NsN0ppS2RvZXVWNWhESjZDd2Rv?=
 =?utf-8?B?cUVSZkVHK1krK1V1aVZXeWE1aHc5bTJ3U2F5SlNMNWJ5bllnalNRQWlrR3Er?=
 =?utf-8?B?N1cvSUhmWXpPc3cwbjk3dllGVk8rRkxTaGVuWERMUmlXMFdZa2NBWmRoZGU3?=
 =?utf-8?B?eUFwRUVuNk4rWFBCc01hLzJCeGZxaE05RzRJVzM4RmZrRms4U0ZKbXpsTUs3?=
 =?utf-8?B?Qm9CWUZiRmVLSEMzTWkrcDlLcWFKT2d6WG81a0xmNEN1a1lXdmk3OExJcFRp?=
 =?utf-8?B?aU03MVZZWlErTGJ0ZVVGTERtR2Q1d3BLYlJjQXpGK0JYSGQxMkl1YjUva2dh?=
 =?utf-8?B?TmFGcWUwd2kzY0VHUmthRTA5TUpuMy9CVVdGOVg3WHdJc3ZaQjlnTFkwWWtJ?=
 =?utf-8?Q?3t4X8zOIeQR6jSck=3D?=
X-Exchange-RoutingPolicyChecked: Qjz1rf/756q6UnelgnSS6xZpJVO1dBhelYIRyrs9Rzq+rkQlv+5tfEHRVyKBTCltmRyA1tMhgx2HADOUO9UjO7KB8wRHJxEBCO2fgMLbc0osBcV1zsullOh7sfd5KCDYhvBWEDIn2obZwJFnummIS7kldBGtsBh2q13bzY32HmUbfRRl8/wPK+vwlhunGSa5r3AXWweqr08mjSwvf/q5Q8Dd3u3jZO28VTm/ivsmRFwFK3Zgp5T+GeE6OYiHPJV7oNX89jFmJ9rclfUHIapFRvmYmd+cL9eJrlYpQWR09fl9aylmF+3DNohvVGgtdsyOs40P7/jtgdIx9wIooppUeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b50c6059-35fe-42d5-1f5c-08dea4fff74b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:27:20.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BegOa/2IO/tsPd4KHX+gc9r3wd/5l969V1Z+GatbOgZ0MHvrWKato5xCDoAN2jf6KCc8dRDYapVQ5Tq5M28G/Njl4u1kh15/cNe1AZDMtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AAEBB480406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241497-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,linux.dev,kernel.org,perex.cz,suse.com,gmail.com,opensource.cirrus.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cezary.rojewski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 2026-04-28 4:38 AM, Cássio Gabriel wrote:
> If byt_wm5102_prepare_and_enable_pll1() fails in the
> SND_SOC_DAPM_EVENT_ON() path, platform_clock_control() returns after
> clk_prepare_enable(priv->mclk) without disabling the clock again.
> 
> This leaks an MCLK enable reference on failed power-up attempts. Add the
> missing clk_disable_unprepare() on the error path, matching the unwind
> used by the other Intel platform_clock_control() implementations.
> 
> Fixes: 9a87fc1e0619 ("ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>   sound/soc/intel/boards/bytcr_wm5102.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
> index 4879f79aef29..4aa0cf49b033 100644
> --- a/sound/soc/intel/boards/bytcr_wm5102.c
> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
> @@ -170,6 +170,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
>   		ret = byt_wm5102_prepare_and_enable_pll1(codec_dai, 48000);
>   		if (ret) {
>   			dev_err(card->dev, "Error setting codec sysclk: %d\n", ret);
> +			clk_disable_unprepare(priv->mclk);
>   			return ret;
>   		}
>   	} else {
> 

Thank you for the fix.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

