Return-Path: <stable+bounces-45581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B98CC3FC
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43991C22356
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A75731B;
	Wed, 22 May 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hlPYcKC6"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5F1864C;
	Wed, 22 May 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391199; cv=fail; b=CbZsmF6303ZTNV9fplqoAzKee9HtFzov4Un1jysNKY28C4WzbMt5wXtXTNLZd1psu6cqRukxjHinLiIsyyJr3Qkse6S76MmRKRcCFC2NcoFHEpsUNS9u98S57yBf7N9H0zNtWt2yh3245Q6gAWJ1TaiQjI6GZmFmWJjZuVPsZ0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391199; c=relaxed/simple;
	bh=k3pBluD1MKph4SboHHigvsCwat8hmUEE7QcOyf+7tSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aIZ9u2EoxgHxYOUBuAPJ4O8SJvtKdGSzQfKIaMy/IXy2q0CtxYGoyXE6rOe6dYYR7LtNnb9BIfBmFrIKMdboEEtbbuBLUAbJJl8eFZzD+GGe+A6nmZy78tGdR/OVuix6KOUE4S6iAC5XwDEz1bNPp9txydnfCdyO1OEO5VdClao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hlPYcKC6; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahbdJ+WQ03TwsnqH1zDKyFbOXideGhPm0lnS4uh8ic5wgYtN4CXXa4yJ680iJihkhSyL74jEmLVcNRU/icNVzN+OHuw0Oo2Q+M4YAC5TCaH2kiVjKYpkf3AsE/v/HCFavd6RfUGgxCN/+M4KmM4SeQlfyLfqDE2UyH8KSjpqkHDNhCmLRjBj+C+3dR3G5f/qT5BGIi/aNFnxffatuGXuUMzOWpSdxqcQExQn0xCav9KfQZhf0cHa0yuI7WMBDDMVLem1F6Wnujjyg1ZiQW68y+7/IFKjtFfZoBSvQMwVKdpxI4+njG0s5FmiWosgWIq8ORJRwLK29dHsD+6tLcPp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX5KWZaTGzKnCsEW7POcYJNliTQ40Azw3kSGgA3R9eI=;
 b=D+c+uxRPT0AKCR7321n1WQECtM8byWGREx1XLV8uTD0p0juOH5DrhMvsfmkRYa6nd872nUyCD69kLoQ7nm94rJ4OP4P5iWXHUyYX0EliFdvL9JQb452/ReImmf+gH8vVpvLG1iOWNBUdPqsNC0sNK09y4v7Qj9V65UEugKncCFHa/PuJtkJ2Ox+3hF98vU/jzf8VL2M77CmMQC9+YUorecNu7XkCO6ptWSYnn0OyDFCUDtD01nT20hnZWIbOSjUij/nOY5trRP2LgEnUi+I2U+iuzjSmi2iEG4+tbi+b9ZfmDvJucHEtgY9ET1fdCcyx8zYfqP+L9dcyGnxiM+XNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX5KWZaTGzKnCsEW7POcYJNliTQ40Azw3kSGgA3R9eI=;
 b=hlPYcKC6VluOSavwSu+Q52bJcgzxkJlvvp4xVPyN2F0MTKr+FyBicrzycANw+FKC43DnfH5nu3sP+/sprdKa+nkxn/NaEIAaFSXMm775Ke9V20SZD2xDuSdABbi8h7XO8dSnuqZMwY8IK15GRS6R8KJamRakIACe60Xcx5oQ2aE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 15:19:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 15:19:54 +0000
Message-ID: <79dfc0b9-94d4-4046-a3b9-185e53b4a192@amd.com>
Date: Wed, 22 May 2024 10:19:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Gia <giacomo.gio@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "S, Sanath" <Sanath.S@amd.com>
Cc: =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>,
 Christian Heusel <christian@heusel.eu>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@micha.zone" <kernel@micha.zone>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>
 <20240521051151.GK1421138@black.fi.intel.com>
 <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>
 <20240521085926.GO1421138@black.fi.intel.com>
 <CAHe5sWb=14MWvQc1xkyrkct2Y9jn=-dKgX55Cow_9VKEeapFwA@mail.gmail.com>
 <20240521112654.GP1421138@black.fi.intel.com>
 <CAHe5sWbAkgypzOA-JpBpwY5oFP1wXShKDNevmjLEu1kR1VOeRA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAHe5sWbAkgypzOA-JpBpwY5oFP1wXShKDNevmjLEu1kR1VOeRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0113.namprd05.prod.outlook.com
 (2603:10b6:803:42::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: d59812fa-c62d-496c-7c42-08dc7a72a1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2ZaUDlQaFVPZU1IVHhiNFNXWkVHYTdHVTZDYXJncTU0aGxIcWc1Z01aTWF5?=
 =?utf-8?B?U0xsVWNRU2VaL0xHWlA2MjN2MjBiSTgyMFFSMkUxczA3My83VktHamhKS2Zn?=
 =?utf-8?B?SElTMGNIYVlXeHJrRkF4Rm5lNGNlU21nMUpWbGRrbXJQckttOW1Rd2t5R3BK?=
 =?utf-8?B?S3VyTTZVS2V4UjJWZjRyakIwWE5jeXRvSWlsUW5jUFFPSmlHQ3M0Ym5aa0xj?=
 =?utf-8?B?UUxiZURJZEpnaFJUakNPTW1LcVN1QlBDOGFyZlUwRndMNExuWG9kZ2JxYzh6?=
 =?utf-8?B?NmhYQmFQNHc1RVNhaVpwUHM4K3UzNHV5dDJzNWlqaXMyYUJJUWt5WWJoSEM4?=
 =?utf-8?B?UGlLVzZCNkZmNmZzcGFCRmZmUWJ0UGlSNTlsNDFNRWZSQmsrWkRlMHhsbU9Q?=
 =?utf-8?B?UzJGbzBpb1c1T202b24yRk1MK2dTZEVZMUpHOEE0UzBmVk9zcmZyRW5HMkE5?=
 =?utf-8?B?ZktMcGFQNUMwdGJHZkRzZExGeUJiY3JLN0RVdzN4MHhheVlqYzFlY3V5Y2x2?=
 =?utf-8?B?cDZETi9IUDlldnJ3NU9wbHFWU045ZnVGeGJLMWovWHgrYlUzbnVlek9ZRGFq?=
 =?utf-8?B?MUhvVmNOMi9tMEJqSDllS3p6WjlRKzJBejRydHNYNWxxRmlnWllCVG9LMnh0?=
 =?utf-8?B?aE85QTFndktwS29xd1ZPR1lYclBCOVJ6THRWZjFZbHRJazR3Tzg1UTYzcUpJ?=
 =?utf-8?B?U3ArYjcwZkd6c0Zjcml2ZWkyZGU3L3hRam9DdWYrMm5YcHRWQ1FTbE5ud1dE?=
 =?utf-8?B?TFJkU011dTQ2ejR1bkJiUHFBNkhaZWxXdUcrNzlJSEQ4UzQ3TEQvZ1RGckU1?=
 =?utf-8?B?S2tRNXN3OGlZY2U4djFnR1RDNE5nZEZYUjRwU3BpblR1U2ZaM0oyZTgyV09D?=
 =?utf-8?B?dktPM1c0QjlpbUU3UXRmWXZRVTRabUNHbWJTSEtKSUlQcEpRSTV1cmRuTkFu?=
 =?utf-8?B?RjZTTkRkbGNteFA1WGZJeVBQVE8yekROSEdmWnhzejFhb1psNzBlaG5KckJp?=
 =?utf-8?B?THI4NnJnckdqbG5NdEVtK1hZeHFYYzl4SVdXVjJ3blJpVmdTb1VSeTZXa2tD?=
 =?utf-8?B?ejNIaSs3NS9SK20rOUdpbVg0dDFCcy9UWlBWc1lmc1lYd25OY0hWNm5uWTlG?=
 =?utf-8?B?TEovSWJVcFlxcjVwSXROM3JlYlZtV0VCRWJBNGZQRHVWaUZuZXBNYmF4MFdh?=
 =?utf-8?B?a2lHUm5CODczWHptSXNleE1vWlpnY3hPNTgwS3hhUnBRd2Nidjc3Z25Wcy9k?=
 =?utf-8?B?b1hjV1pnVVlPeGJKejN5SXM5ajN5Y0IvTUZKVlFZdHRYZHZHekcwU0Z5bnMw?=
 =?utf-8?B?MTFlRW55ZEtsczV2dTNWNGdySStqMGhoNE9VS3Bxc3FUR005eVozQlZXci9N?=
 =?utf-8?B?ZkFWbjFxcm5JT0pHWEN2OFRqN0VyWmkwYnJwemJWeU1zcWFSeHdiZzhNZkdG?=
 =?utf-8?B?cUsyZG5KUjh5cktpdVBzWk12YjdwUFJBU2o0b2pXWHlBa1oxT0EySzVRUUdm?=
 =?utf-8?B?WXUyNkl6UHlWb2ZWeHNmMjdybnUyNHhSQkxMamRYQWd5SXdUcEovYjR2cWpW?=
 =?utf-8?B?OGJIWmx2ZlpjYThreDhNZEtFdjdVRnBLeXZsU1VOdE5vSnRCNCtZT0VyRzdn?=
 =?utf-8?B?TVNQTUN1MFR5dUw0Nms3eHNYcGVmR09wTnBmYVEvQzd0UkE0QW1LdGVldWxl?=
 =?utf-8?B?aFYvd1BGRWtzV3ZDNmo4SCtYalVYQzdtYkE4M09EeklGbmZ1TmllNTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBIOXF3aU1iczB3QjE3aDNwQTJ5SGxDdXpWcjNWYklCTDhaSHEvQnFGQTEx?=
 =?utf-8?B?RWoybWtQTUF2NURZOW5pZW1jNE9XcjZybzNuUW1UTVV5QjBYdEVYbmNaZHlX?=
 =?utf-8?B?dTNzZ0Z6dzZzYVdBSkR6UFo3Zkhxenpsd1RsSlVEcTJ3NHMzMUFsOTN4RWs2?=
 =?utf-8?B?cXRPVHpxcnZDTmFLNFBVY0tnRkNXREdOaFU0eXIyZGd0eHpWK0pVdHE2YWhV?=
 =?utf-8?B?dWFpMVBFb2NjMFhlWW05UGVuck10K1lOUHI3UDNhQlhFeCthWWE4NWpSaXhD?=
 =?utf-8?B?azZ3Mk5PZHhsNTZ6bFBWUWxwUzJzeUpLb25KbE1tNnVCZStFVWhpZ1BPV1NV?=
 =?utf-8?B?bVdoSHMyL0dPTHZOcXg0ZjduVWpOZzVBQ0ljTVh0b1RHMDl1VUJXZC8vdUdV?=
 =?utf-8?B?aGRDcFZvUnFOaFhHOUJ6Z3lPTlZDZGRkd2k1R2pocU8xaVdVOGRmTDd3aUlM?=
 =?utf-8?B?S2RJanZ3L3g5USs2Tm9tR1FuNTYyVitMSFU5cVUrOGZRSXZoS1J3MGVXamRL?=
 =?utf-8?B?N09NRVdDNjlKNDRqNk9WNVVKYjV3ZmJwbzYxazBlN0ErYmhvV2l5anNQWFVC?=
 =?utf-8?B?TmtjYS9BUmNUOGtaWFdUdGtRSWtjdnJscUIyUVBuUEFSaVJ4YVpXZHA2MWhl?=
 =?utf-8?B?enROWHc5SXpxU1krSVhFVmlQcmtOblpGcEFhTU16WUNVbm5EcWM3Z0J1bkI5?=
 =?utf-8?B?QTkrbUV6bmV3MlJJSThUd0JPL090OTBPTzhBUGloRHVQdU1Sd05aVjhPRnJM?=
 =?utf-8?B?STRxL3ZGTjNFMFFSVENxTHlBOGhuZHlPMU5wQjE2WEFHRHdUQ2dxd3VNMzFG?=
 =?utf-8?B?Vk40SWJvdkhLTEh2MWVVMU96MkdRbnFzTXJtYllNbzdQb2E1VFJqaTRwelpG?=
 =?utf-8?B?LzltKzdGTUE1OUNleENQMUtGeG9tK1hiU3pwZEs0d3BzNVhhdEdvSU5hNWVM?=
 =?utf-8?B?eW92ZTFxU3NNRUhHUVR0aDBpRW5wdzlnaUVPZEpMM0dUdEVzL1dHanNnNmNj?=
 =?utf-8?B?ZzNUL2dwaHZ3b1RndkpQNzdRdjYrZTMrOEdHVERiQkJzQ1QwYmFkUmlDQi9Y?=
 =?utf-8?B?V3hRd2JJTmRWMEVPMFYxTUxxOEtmU3dUaWtieUpOV3hXZ0pUVTRzOVZFT1Zq?=
 =?utf-8?B?TlhsKytFNkUxM3VMR283YkNkZEMzYzVMbnVrY1FqNjV4TWNsL1RlOGNFNGJK?=
 =?utf-8?B?djhIaXBDOEp2ZXg0UWsvek5aZGdEVmhVczBNNWNoTjJkYmd4WUU4RzMrVnVz?=
 =?utf-8?B?YUNxTEd4MVJXQ1F4U0dQQW9ISG5sT1VSbm92NjlKd0hJejdlOTRSTG1FRis4?=
 =?utf-8?B?RzlPWmdrbVhtKzQyeGRnb3JRR05PMkJQeGh4NkZXNlpZRWltSklSaTN1bjV4?=
 =?utf-8?B?QzIxTytBUkUwZ2dZYWdKci9jUzRtY2Z6dkhHYTRmNWo4UVBOYkROY2FUcnJx?=
 =?utf-8?B?ZnRlMERSVndreEJNQ3hydkJ3NFhRZ3U3QUtNL1RDcGN5MmFrZm02M01xelRX?=
 =?utf-8?B?bk5SdUZNRjVWVDFZZkg0NzU1YjMzMC9vaW5ybTl3ZlhNMm5yaVNSclJ1Rmtp?=
 =?utf-8?B?Mmc0azZ5ckZRZExYV3lSU0FlNDNHUk1nYllkakJnV2NDQmhiU0k4RXBSUXVq?=
 =?utf-8?B?ZjBLK0VBUzR0MDdDd3NkUXFCTEJKTFh3eUZjZ0VhTG9sUHlnczVqZElJN3Vm?=
 =?utf-8?B?MGJWMDJFWUswSjFtVjh2VG5wY2lhZ2RGaVdwUktkejZrcE9tUFhnM0Z6UzZW?=
 =?utf-8?B?RDJsaWorSnF6eGtkeFVLZVpjelp0Yk1RMVJHMFhyNG9rb1NSUXhxQ1ZYM0pJ?=
 =?utf-8?B?b3FUa095WEpLZ2JvU3dRdjVWR0pnV0VmNXpnN3BpOTBISHdoVk1zalFZNmxn?=
 =?utf-8?B?Um9ncFhRYVRIUVpENitYcUs4UzZxTXVKVmN3anBPU09ZWWVDdVgxVWYzdEJy?=
 =?utf-8?B?ZFlRYjVEeW9DV3FTMlFock5qckRVblFqK1Rzdm5kQkJ6Umg0OG03OHk0czVG?=
 =?utf-8?B?TVV5ZXQxZGtHWmhUcWRiQ2duUWdXUHpKdDM4WEQ1Smo3TEJ0enlIWGM5dUJL?=
 =?utf-8?B?Umg5M3VpU25vbGlHbHVFTWU2OXBqaWFDVzg2dlpsMEttVnB3MWs0VXhhVHZI?=
 =?utf-8?Q?pe/w4ZWv6eMIbeobUOvyzJlRX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59812fa-c62d-496c-7c42-08dc7a72a1ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:19:54.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkqiseoHoZ1jbz7erXt0LHXCGExYrYXxl83CamzG9pdA+aKmXsy9+iC4bOxDJowppcwjXtqFzumIHFU6s0y5EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

On 5/22/2024 09:41, Gia wrote:
> Now this is odd...
> 
> I've tested another cable - a very short one used with a Gen3 nvme
> enclosure that I'm sure it's working - and I got Gen2 20 Gbps. I also
> have tested this on Windows 11 and I still just got a Gen2 connection.
> 
> I was almost sure it was caused by a bad USB4 implementation by the PC
> manufacturer, then I tried to connect a Thunderbolt 3 disk enclosure
> via daisy chain to the Caldigit dock and I got the full Gen3 40 Gbps
> connection! See the attached picture.
> 

I suspect you can't actually get Gen 3 performance in this 
configuration.  IIUC you should still be limited by the uplink to the host.

Those are some really odd findings but it's at least good it's 
"consistent" between Windows and Linux.

I'd suggest you report this to your manufacturer to investigate.  Sanath 
can keep me honest I don't believe we've seen this problem on the 
reference stuff.

> I'll try to connect the dock to a laptop via Thunderbolt 3 as a last
> test and I'll report back.
> 
> 
> 
> On Tue, May 21, 2024 at 1:26 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>>
>> On Tue, May 21, 2024 at 11:12:10AM +0200, Gia wrote:
>>> Here you have the output from the dock upstream port:
>>>
>>> sudo tbdump -r 2 -a 1 -vv -N2 LANE_ADP_CS_0
>>>
>>> 0x0036 0x003c013e 0b00000000 00111100 00000001 00111110 .... LANE_ADP_CS_0
>>>    [00:07]       0x3e Next Capability Pointer
>>>    [08:15]        0x1 Capability ID
>>>    [16:19]        0xc Supported Link Speeds
>>>    [20:21]        0x3 Supported Link Widths (SLW)
>>>    [22:23]        0x0 Gen 4 Asymmetric Support (G4AS)
>>>    [26:26]        0x0 CL0s Support
>>>    [27:27]        0x0 CL1 Support
>>>    [28:28]        0x0 CL2 Support
>>> 0x0037 0x0828003c 0b00001000 00101000 00000000 00111100 .... LANE_ADP_CS_1
>>>    [00:03]        0xc Target Link Speed → Router shall attempt Gen 3 speed
>>>    [04:05]        0x3 Target Link Width → Establish a Symmetric Link
>>>    [06:07]        0x0 Target Asymmetric Link → Establish Symmetric Link
>>>    [10:10]        0x0 CL0s Enable
>>>    [11:11]        0x0 CL1 Enable
>>>    [12:12]        0x0 CL2 Enable
>>>    [14:14]        0x0 Lane Disable (LD)
>>>    [15:15]        0x0 Lane Bonding (LB)
>>>    [16:19]        0x8 Current Link Speed → Gen 2
>>>    [20:25]        0x2 Negotiated Link Width → Symmetric Link (x2)
>>>    [26:29]        0x2 Adapter State → CL0
>>>    [30:30]        0x0 PM Secondary (PMS)
>>
>> Hmm, okay both sides announce support of Gen3 yet the link is Gen2 which
>> makes me still suspect the cable, or the connection in general. I
>> suggest, if you have, try with another Thunderbolt cable.


