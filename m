Return-Path: <stable+bounces-100640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1879ED122
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813A018867F2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9024635F;
	Wed, 11 Dec 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="Tsiotet8"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD871DBB0C;
	Wed, 11 Dec 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933851; cv=fail; b=faKq91vtfVtH4RMDRnkZSIZLL9NJfm+9CEv8JAltph0b2imvbRKP4tDGSjv/HO8WSX2UjkXyrLuYOnUdaKIL+tLzy9Kj777/HXb54cLcawLmI5BPLZlkwGJXZlsPBqrOaEyVB7XjV3UOn27mBGHyp2hSYIrCET2NNd/a+jnr4NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933851; c=relaxed/simple;
	bh=xDb2QPceA1ev0eDfi+Ew3U9xMsCNMVkAFUwXxL2xCQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkBoWnbID78NXTJcDoYsWBOKs5LzsWzXl22xYCIaJylde8b40gx7Kjq/w332To5xvAv22F2YtlZJ5NOf3VcdtRQ8pq7s8cTGG8CIqNJrBhgolIudii4LV3E3M7Ke9zeZRcP9FELAlAYfmvsGSH6zEAvduU/Xz/ci+NGbF8sn7xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=Tsiotet8; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45]) by mx-outbound22-27.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 16:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPRQ6GZZgIk2mfKHyNRyKlYmXJEcjfRh4/sFLxhRiMZokUDt0oXrqXFZZSmusKqkzkcoKGSX6m9GneqS3pesn+Wiv4kJGPX2j30P4l4+eKKkQVm+qL/0r/7tIZ0gmFvu+3bcXQkWDFqZDrRTkC+rO1d1QIUss8WqDfreuEAdCXA5Fnx8QUf3W0bjrZQ3P9Qe52/QHgLzFf6KdGn2Kbr1Hijz/lFQtLQpco/jbSM/tl1otgbeNsoUzr3eFFPr3qpmOmItMMfG2+X9yg3gI9t5TJzoJrzJHGqVdv21iS1jr5bn6c7e1W5yEZq6+ILoRfdLvuUcX/SdNsgrLtnXLRQpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rUUnM2R7xSnQ9F4ZvqaLFdk2/HrbBon1tyirfINu7A=;
 b=QGYEGNUBC5C0EQjQF+2UNRLVbyJu65hhkoGizj+FOi7Yhc4AoJOopFjm3JLTtgK/ecE+1//AB9vtzpI8aOfEDyHFMuRDohUw6u575VDHTovuiELDhBmAJMEiW+meRETT0casDQ3zV91r0ACMk+14hHQZYpsnW8fK8rDuKnDTJK/YJq1yCgh5vkcvmaoHEKR2FjSNvHNgpp7LWf82nE8SiD+ZDAe3xWG/iQ1TYfF078HfF+P7m+3M74hdCgp3oFI/mVOSGVe59rCxxxG9uGq+JUnVMVi6RgNYvzazFS1/0U2bib15kzl2FUoRQFgIsLtVrXQiT3qsItVNX5cbfpv8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rUUnM2R7xSnQ9F4ZvqaLFdk2/HrbBon1tyirfINu7A=;
 b=Tsiotet8IxqFFkRoh7Beh0MTIff9c6TYSAE92VmeXKX81KYhIB7jq95om7Xc16Ju15SOM3sMdvOpJdYpYJQxP0kafqL9Qofu/5TEKql4wzNIMh410aDL0vE/k4TiaO7BAWuIksCtq/NeJZ0EXoxfxifaDq1M1XUJvFP+hpTuNinWfhBJOB1e9afyHCPKQ4C5ljjnUgBlErqvBf0WEEAXIhoBnrn1TEU+YdNuGajfLmmLnvGZGSX2417OL2Cgkz2AEGFVququj02xh49uf2h7OdBwTUDtS2ZsktQ3NaKiIYi8yYaV4ttuFvvhIaPxh7gWU0Mcv+dbtNlQZwljGFhJdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:17:14 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:17:14 +0000
Message-ID: <78f21350-78e5-4d01-b856-8b49b79ba0bd@digi.com>
Date: Wed, 11 Dec 2024 17:17:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: tag_ocelot_8021q: fix broken reception
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241211142932.1409538-1-robert.hodaszi@digi.com>
 <41a2686b-d549-40c5-9f6f-bad8f308b729@lunn.ch>
Content-Language: en-US
From: Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <41a2686b-d549-40c5-9f6f-bad8f308b729@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::13) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|CY8PR10MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 8282afef-2a29-4500-8d47-08dd19ff4626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnhYZ0oxTk5SUVRCR3NsYk5SSGNnUWkwUFNyQmJPWm11T3A3Nm9CcW5aZnVn?=
 =?utf-8?B?d2dCUmIzRVlFOC9ZbjNCSERCWUhodnUvMmpnVW1NaDJBL3ZFMW1OZjdoR0xn?=
 =?utf-8?B?QjZXRHdOWDdob0o3OWc1WFFPWlRqZWhldi8wemFrYitMak44K0FEUk5CcmN1?=
 =?utf-8?B?NThOZkhzVjVRZGo5clkzNU91dDJ0NEE1Zmh1WjFKb3luUnpLWDBncXFkNmJG?=
 =?utf-8?B?aytwZ2NCS0wyYU1WaWs1bEx4ekVpOHZJdDNsbVg2MHRHQmxFelIyQkpTL2F2?=
 =?utf-8?B?NmkwY2hoY0RDL2hoZHVuSFAvYmVIWlFwMm42Y29VbXNtL2FtenBHeVhpbVRv?=
 =?utf-8?B?Vmo5QkQ0eGtZQzJxNU04YjVwd04vejU4L1JpUEhZREE5WjdkelNSK3h4OXgw?=
 =?utf-8?B?QU8xd1FYSytGQStaRXpkUDZTeGZrVXpQWnVHeFdwYUlsdC8wWDM0UWZaTzVy?=
 =?utf-8?B?T0VYK29jcVBmdjRwdTl6ZEowTGgxLzFpbjdNOTNYQlVBeWpWS3d5WEdBSmhP?=
 =?utf-8?B?NnMzdENNU3hiNllWVmpTcHRCSVI0elRrbzJDUUdCMFZUZkZIbzd2MXhVR2dJ?=
 =?utf-8?B?TjBRMTRHY1RjeENVSDJYdWVhMzIyeUdCcGlTdUJWOEpQZUtWN2JSS3hPVWRm?=
 =?utf-8?B?b2ZWTmVjbTA3Tmw2bmZ3eXdTUldpa1paQnVxSlBOUkdMYTNjcjBpQnREZERQ?=
 =?utf-8?B?OFBvSFQ5NTdlY0F5UzdmcWNkM0NpbE51NTNVVXB1UURlT3BmWTVXOVRLb3Ez?=
 =?utf-8?B?WndSK0xNdmZEdTRKdkE2bkQxTktPWERMTHNUYzYxcWl2ckN4Wll6dzZjU3J5?=
 =?utf-8?B?cjBIN2kyNytoamhuYkRPL1dNaDh2dW0wbm1JRWlOdThMd0xFTFNUM3lhaE9R?=
 =?utf-8?B?TzlpRDJDY2VoUnBMNHFrQ2ZYdG5ra0kwc3FZK2Q4TmlJZzRXcGlvRGhpaURN?=
 =?utf-8?B?WjRmWTZ4RWg0a1podUZDS09VaEdrTXFZWW94ZTBvdUpMZDlRakdQM3NneGR4?=
 =?utf-8?B?WGlVSlphZ081WDgvRVJPc2xTMHpOVVc4dFRoMWNoamFDaWdiSDNGWTdLa0lV?=
 =?utf-8?B?RWZBOWw4WURYV1lOY2YwanFmZVpvMWlhb0xoZEVpcXZIRnN6anZQMjBaY3Jy?=
 =?utf-8?B?bVR3OGU5RlRhcG1PbDhMYlJRVm1Yd2Foc0VCanBGZkJIOFRla0NwUXdmeEl4?=
 =?utf-8?B?WE5zanBlb3NnS0xsZm43SVB3NytDL3hKUy9wWHB3bys0VWNmaVNRSXl2Mjl1?=
 =?utf-8?B?L3cxRUNFbjlRRGlDQnlkakhvcm53cngrTmgzNFc0cEhlYm8wd1JtTHo2RW84?=
 =?utf-8?B?RHk5d0x1ZGVSalN2blZxTXBNaXVRTXdCdXI2Wi9CY09IMGVKUUh3WEdLOGZt?=
 =?utf-8?B?NjZSWktZTUNJbTRqS3laeisyU3o0RGxOTFVvT3lNZ2ppbWZwNjZiTmR4clJ4?=
 =?utf-8?B?clFMWlR5ZDdzaGtxZStHaGhIZHhSZkY5SjZmbDJQSlNEcWFDNEM5ODZPT2U0?=
 =?utf-8?B?aHVTWmZTU2Y5TVNCZE9rbGxNclBqYjA4YlFQSWVVSmRzYVZuL2x5UHl3eGdm?=
 =?utf-8?B?ZWlMWkhiQm8zaldYQ0xnS2tKRWUxSHdXeU1QRkhQOEI5bGN2TEYyVWgySWhZ?=
 =?utf-8?B?Z0VkUVJxd25lZTZxNEdacS8veFN5alFxcFJGMVpPMWtWZ2dOeWptSFdwekl0?=
 =?utf-8?B?MHV3RUYzaDJDejdNa1RTMFZHdEwrTGtRZWFVaDFGWVdhZ2VxOUtTbitjOXZs?=
 =?utf-8?B?N3VYZHZkMERHQkJldkZNeG1kSzRRN3BRbWVaaG90ajRyczI2MEZqRDZUK2I5?=
 =?utf-8?B?WlBMNEs2NERtdkJ0aUo1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clBqMTlGeTFLZjluVnBoUUFzb0QyMUxudHpQaVpnTW81Z3Q0Yk1VV09lajQw?=
 =?utf-8?B?Vytxa0lWbW41bHI1OHFvNnc4cEhUVDNjMUxBUWZuWGpwYWVyWnRuUDhpbktk?=
 =?utf-8?B?OGNwaWRYc0ROQm81b3ExNSs5UndDVGFqZmMySlE4TG8ya0cvV3VoSnJ6bHRT?=
 =?utf-8?B?clVHelZlc1J0LzNOdElSMGlXL0gzcmViVUpvK2s1MEUrSnNCaTBnNldpblN4?=
 =?utf-8?B?dlY2c081Nmd5bmpUSHVRbjBJZU5jMnRlcjBaaUNPME1xeXlOT3FhSXFTNnp3?=
 =?utf-8?B?c3UzQWQybnBHcWNTeHFObFBPL2tzb2t5b0dpTlNLVmYvZzNNdFpBcVNqbm5C?=
 =?utf-8?B?WnBzazl6VGhxNDJlOUFSZThxMlhIaThFYTdNbjU3eWNja1Q1N0hBSUJVTHZj?=
 =?utf-8?B?eTA0WnZuN3ZIQ1lvMVQwbC9xMnRnUzMvMU9VZ0pFeCtlTGczeWNzM1BWM1JT?=
 =?utf-8?B?Q0l6RlRaVUpQMFA2amRFNjBFa2hhaVdPTGtZM285NE53V3E3L1lIcWlvSkxL?=
 =?utf-8?B?SXkweWpMSzJOUjgxbDdHY21TSnptanpKbjRYY3QyNE5ucEYwYmh0aTZ6aWl6?=
 =?utf-8?B?ZWJaRkdIWUNLaURsMUh2Sno2ZldITEtiazFFZWJJdkt4Q0FNcHcxVGh3NVJK?=
 =?utf-8?B?YUFndDhkSlkxTEswWmtMLzBqQ29kb3hEYjlMZFUwSjljMnlvK0MwN2w4VGFL?=
 =?utf-8?B?bklKTEorRGplMStDWHNlS1NGYjh5bStTcWdlVFRwZVJYQzJMelVDc1gzMlpZ?=
 =?utf-8?B?SjN0Z2RwcTBQMXgyZHgrL2tVTFBhVmRtT3RGVXlGV0xrQys4bHE0S3lJU2hD?=
 =?utf-8?B?SGlUTFlTbGpLK1MvZ3ZzekxpYVlZWXEzMS9RSG9NcExOS2V5TzZ1QTl2dSt3?=
 =?utf-8?B?Y0doUHF3SEZBaWRxNFlOM0xhYzBhN0Zzdld5L0J4LzJTS1AycXJ3Z0I3YXMy?=
 =?utf-8?B?QUgrWlpOSjJIY2pndmQ2U3BSaHBkMk5vNFFoNUxjMmhUa1BiWkZMQjY2VWFX?=
 =?utf-8?B?ZkZXaXlOdG5vUXRTMGlUbHBVWGxOUDVCUVJxeVJpSDRsUUN5dzF5YUhPWHJp?=
 =?utf-8?B?d3pFVWkvK2xiaWsrYnExd0dadENxYkx6cE4vNDhxOVNQdEZkMHB3aUFDcVVX?=
 =?utf-8?B?b0VtS3l1Vzc1c3czaU92NGhleTNhdCtMN2wzVGxDK2JncFZlVG5yRW1DR05H?=
 =?utf-8?B?VzRUL3lxYUVOaVcwSVF4bjN6TmxuYytlZ29RUU9tRDZNVEVSUS9zS1JJeDhG?=
 =?utf-8?B?bjdSVC9ZV2lza3JmRFk5VGFnMEFWTnRlUHVMdE9xdWpocHhwYmY4RGVUTUNV?=
 =?utf-8?B?NGliRno5a0hYZnRIZ055WE5GVFJvMHhRQVpsSG9nYjU2TGF0K1hvWWdHQ0NC?=
 =?utf-8?B?ZEFia1E0YWNsNzRuNU9hVW9CVkM0dFZ6eitXT0lrVUsrV0Y4V3ZSQjl3Q2FY?=
 =?utf-8?B?SEpvVU5wZU1haGYrVlhNZGFUN0pabW5ucjV3VXozMVZ0YlFOajdwZVJUUWYy?=
 =?utf-8?B?bkZsbGhhUWtkcHd3Q0poQmg1cGF2VC9DMDVQV0xZKzBqQktyT1BhNU9zTWs5?=
 =?utf-8?B?aFRBM3NGMXBOTysreWV0c3h1VkxLM1ZiS0I5a0FqZ3BHbXNjZnFTcHYvOUFz?=
 =?utf-8?B?Q2xKVWlBaC96QjFRZVBQOHJmeFM0ZzkrNUMxcEVEQVRBUXREUTFnTUtJOXRK?=
 =?utf-8?B?ZFJiUlBMWlhkZjFVOFoyL3VkSjdSSTUyY1JaMHhUSkcwSFJ0V3NxUnp0RWps?=
 =?utf-8?B?WEFuMDVWazYybExzMGV1SjJySnlDOGZ4WHI0aXpiUUZoTzRJRFhGYUFIaW9i?=
 =?utf-8?B?aUNzRUFRZHJGbHlpejJUcUdZK1I5Vld6VlVjcS9YVFRoOENrdVkrMmtndzJT?=
 =?utf-8?B?QlNzQytzUllvRHlMYWRCYUh4OFlTWWlsaWVlWGRDbldTQ1N5L09QdkxEaUhv?=
 =?utf-8?B?T0QzNWZRZVpEdjd3Vm9JSzNZMkM1bFZqQUZzcWsrdGpnSURHcm54dks1dGdY?=
 =?utf-8?B?MGJQRkw1ajA5WE9rK3RYNGVOU3dya0JXSUlXRXZCMnREMVI2RmxtUk1uK2Zk?=
 =?utf-8?B?YWRPZ25KTW9DSmZVcjl0V0hFeWlmSGhRcGpvVXVJMHoxUU81OGVuWmNYa0p1?=
 =?utf-8?Q?fdW8uve67wj1u//LLCd5Wp/Dg?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8282afef-2a29-4500-8d47-08dd19ff4626
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:17:14.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRPZXmJsXgN1QcKnqM5dGvvAplO2dwEDGaeuuhzMRtt7sFz0b60bph2ojGr10IiptKHV1HYI35pT9AT0ahEjWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7218
X-BESS-ID: 1733933836-105659-29168-1179-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.73.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamxpZAVgZQMCnVMi3V3MzAxC
	LR2CDFyMAyOdE81Twt0dwkJTHNxDBNqTYWAOcDRHtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261041 [from 
	cloudscan10-209.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

2024. 12. 11. 17:11 keltezéssel, Andrew Lunn írta:
> [EXTERNAL E-MAIL] Warning! This email originated outside of the organization! Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
>
> On Wed, Dec 11, 2024 at 03:29:32PM +0100, Robert Hodaszi wrote:
>> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
>> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
>> added support to let the DSA switch driver set source_port and
>> switch_id. tag_8021q's logic overrides the previously set source_port
>> and switch_id only if they are marked as "invalid" (-1). sja1105 and
>> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
>> initialize those variables. That causes dsa_8021q_rcv() doesn't set
>> them, and they remain unassigned.
>>
>> Initialize them as invalid to so dsa_8021q_rcv() can return with the
>> proper values.
>>
>> Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
>> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> Hi Robert
>
> The code is easy, processes are hard.
>
> We ask that you put a version number in the subject
>
> [PATCH v2 net] ....
>
> That helps us keep track of the different versions of a patch.
>
> Please wait 24 hours, and then post v3 with Vladimirs suggestions.
>
>     Andrew
>
> ---
> pw-bot: cr

I already sent out one with '[PATCH net v2]'. Vladimir reviewed that. (Sorry for this email burst!)

Robert


