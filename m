Return-Path: <stable+bounces-158370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF1AE626F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21C8188A0FC
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2B2820A5;
	Tue, 24 Jun 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWugKWOV"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD925DB13;
	Tue, 24 Jun 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760964; cv=fail; b=LoNi4V4ek1sx0WmqmKD/E/saZpRFXiH438R/KQYJALRWz5S7h/MaKqrikMsbhRmueu/LBl/RyLv3FP8gXfZHEd+LfDOhgBRZ+Ae6S+JTYi5ydTeEluriSw59pdph95vq8xjEUziwcYk4hOuzCR14dVyZpcf82+2clCJdIJpTnZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760964; c=relaxed/simple;
	bh=5lVuvdNcEoPcelwyN71hJz7LPNn+MbuLfdEgJNNxuUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOhawfBEZVCcFbgA0uxX4Gz3vTlZsR9LncMjFTUPlZAANbAwPzlB2S3sBJBGR9YJi8qOuZjabkecGTrEsWnw1ORKkR23Z0+WwzFm+qVt6tYVPpzXHAziJTph5ecrDw1NUCJYflSgaRQpMv7PQ3iofLf72d1U09aqPRcBuiaNgTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YWugKWOV; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/h+8M+dv63RprZkL6xSTcEsMp1iFRIgbAusa5DX/gm8Lp/bEP8Psaf2UbNLz9PXTCaLzDzzSbPNdTdYdSGkvqDswb8ZUpXXXRe/JE1RiYbY3wTRpACDot+dfQdXmnk7d3l6wbsTJlqcRikbmMHsCkVVCjRZmarRAv3AIqH+Wko7SSO5Jwgz6sq6zeNEl4aCU7dIu/fpGKFHlMy4/SC3PK6fcCOC9fdQUmBeqeEa6XeyqgqJrnIsWuUS9EiTkh+kYBDG+ZCmIPz1hXJM5eUo5c1tq2ImQxX5P8CZZc4tYjlwNYTylD1Qf7Ts2N2ghzxlVYvxNJhugaLxjGh5ETWGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxTcUCMhPU/l3j+1BcMcldDC/VJ06Q/cfGsqVefQ3Yk=;
 b=EqbcsFKPBEs2tUHYItLPVNkR6jqZ9YLPHL6HR6Vhcp/d/BLaagEnJABFupIMolCa2LjHCMSyuNxREboUdiLdPQtBjpkApYJZ5vnsq6MX5EOO8/mnd4ljMEvc243K521yjhzGoWzP45R+ZdHJ6dKb9RPJssXA2NPdB8ViLpgKnWlC9DjioCg11NcYgjnc/aCRSZWkVXaNoJAu2gLetc01QtkOhfAsZrhSIwzxLEheLWvRKiqabiPZGnLFUckjUDrpop6lFXEZFmtKEW3CKcLGqfFkazhek+HQUEYda4CMLS7bs5iGoe8EmtQRLPLJ3/EApm0e1lEaMS5w1sIjRgG3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxTcUCMhPU/l3j+1BcMcldDC/VJ06Q/cfGsqVefQ3Yk=;
 b=YWugKWOVnVOfLOFayZUk0u9UU+LzA7Df3fsWgZ2O7yapOUH3iq/c3w4662EE9WHbxYAEl78UNDvnlxGR2OhrcUzP/c0bILvx4jAjW3qJt5s8y1GBEf2L4ADJvPlOyllR/8fJ2uXPU7mgWQAPdfVzvsCO7NuFcFLSNSl3NanOnlP/xcFD3gRjdr+i1md0Eel5xQsWb5ZMRT8SIFsoMHE7iZlnJFbY1n6sjAdhszPCml03UE6qLV12mCFQJSFG3vx8tjOiwVHQ/ZR3uSjUueWzRtoHgOKeNAMe4GO/TNUGDdiPJp7ucsFo43FwkBnlmyU0WNxEauJc5p1tLzRO1Uizkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Tue, 24 Jun
 2025 10:29:20 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 10:29:20 +0000
Message-ID: <af93eaf3-f4bc-4e88-b8c0-623de133b860@nvidia.com>
Date: Tue, 24 Jun 2025 11:29:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] Revert "cpufreq: tegra186: Share policy per cluster"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Aaron Kling <webgeek1234@gmail.com>, linux-tegra@vger.kernel.org
References: <20250605125341.357211-1-jonathanh@nvidia.com>
 <2025062347-snaking-daytime-b878@gregkh>
 <2025062344-molecule-running-1e49@gregkh>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2025062344-molecule-running-1e49@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0262.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: b265ce1b-90ce-475e-e28f-08ddb309faba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWNTN3VxYmxoaTFoMk54OXBGemdUSWllbWo0MCtPV1prMnh2YWQ5SDhacUNs?=
 =?utf-8?B?TW1XLy9KYzRGNm1MZ1I0b0ZlY2M2ZVNHelgvNk1GbWVZUXBWZzNkUm5QMGlR?=
 =?utf-8?B?TzNHcWVsWlI2Z3J3OWk5UEVDOWJLRk9FNHZEQ1BmMHB2RTJLRmI2OVNPMXo0?=
 =?utf-8?B?bFdrcWIrR2Z6M0s5eldBZitCd1pRK21nWU9Pbi9odnFBMWVzUk00Wm5yQlVE?=
 =?utf-8?B?OVZTY2MvdkZuTnFuNUhVTHZ1cW5KdDFaYm5leHB1RVB3ZXo4UGN4bldkQSsz?=
 =?utf-8?B?YmtsWGNLZml1UGI2T1R3Z1hhSW9NNm1vQjVDZ3ZmbGltU1ZnRG5EMWN0Ny9L?=
 =?utf-8?B?VzRudytLYzh1bXlEaHZIRjNpUnBITmlKbW9Oa1NOUFpwWThsU2ZUd2Vuc05P?=
 =?utf-8?B?bzJzRGRJMjNhVndMdWVTbTZJWnFIZk11SFNHcldXK1BKaWlUZjBNR3ZFeTNr?=
 =?utf-8?B?RC9aSEJDZ0g3RFVDckpmeSs4WWhTQno2dEM2WEVLanRva0tSV245eUw3Y2o4?=
 =?utf-8?B?Uy94OHhWV3IvdTJ5dlJrT3JpYzhLMlowTStBQ2tMS2RVQW1ZUytxV2xpMlB3?=
 =?utf-8?B?em93VHI4aEFpVmtHWCt6cXA5NlRvNG9kdDN6d0t1SVV3cGE5UDAzand1OTMy?=
 =?utf-8?B?ZWdFcS93VkVZK0hMYlc5emlKUUszMUFMR3VvakZwNS9ydjlYM05Ha0prR1hK?=
 =?utf-8?B?bW1nanRweVNYaFdaYU9aK1IrWW5DZllET21HelRKeSt3elFaS0JXTDVUMFQw?=
 =?utf-8?B?cDV5V1l3R0xOV3VCQ2pUZnFwZ0FxMmRyWGNmM3YxUjQvTGhOc01lVTFVNlJX?=
 =?utf-8?B?SzIrTU5JOW5ZZk45Y21GMkpOMEpKd3B6cnE1RExYd1Jvc0lpMlNicnI4Rnl4?=
 =?utf-8?B?MUZjNWs0eHhvVkV4V3loVlJBVTYxUDlWTHpYY0ZsTlNRK0pzUFlyRnFabmxU?=
 =?utf-8?B?aytHYmV1c3hkdjhMWHhlejIxN21yVTRYZUlXV2pJUE1KR3VHK1FKUlVWQ200?=
 =?utf-8?B?Q0FCdkNEYmlEZlJrNVJWSHlvTjgrNDhHUGpRMGlpUXd6NGRWY0JIa2hzOXNF?=
 =?utf-8?B?b0xTU2FtUkgvQ3pweTYvZG9qQjFZYmU0c2RyVkVVU29zS0dDVHJpcFk2MVUw?=
 =?utf-8?B?VmNWR1ZRNEk2MlZuSStDUm5PbTFHTUlXR1VwZGp6UVJlQTR4bjFsZVA4a3Uz?=
 =?utf-8?B?ZmY0UVZLSk5jaTM1TkZKaTRZV2VvWU1LelFqVWRsN1hMMXBjVnQwSk1Jd2Nm?=
 =?utf-8?B?a1BUaEgzZ3dGd2F2YlNiN1lLRkRWM0s2V2VzRWcyMUpWallOaVgyUnpPc2dn?=
 =?utf-8?B?S051c2JzaDRjckxURjNObDduSTRFc0lYTEFsWkZma3pRK01NNVlYNzJuQnFv?=
 =?utf-8?B?MzBMb3RRUjJobnV0ZVBYR1ZJS284dWFPaWJ0b2VmSXlwRUhmc0pnbzQwTWY5?=
 =?utf-8?B?bVRaZ0Q0cVNqdFIxbFhpTzFWYWxGaE41RTFaMDN2elZSbEFybXQ2UldCVTdk?=
 =?utf-8?B?OUZaeUZ0NEJrT2w5N2NnQ0FQeG1uSnY0bGx1UHlzMTlXbGpRODRFUGtTVFVX?=
 =?utf-8?B?b0kwRFZkQTBJNExWOXAzTGtnekdkRVdYWVliK0orb0oxRVNVYWZvWTJlVnp3?=
 =?utf-8?B?QkFoV0hDOThsUVhrblRBOFcxU0RBWW5vc3liWmNyNFFPN3FCdjViOHFGNEhu?=
 =?utf-8?B?QlF5MGpTbkw3VWRrMzY1dlpCemtEZ1A0MzBuZ2ltWkEwbXNnOWxsNTJiUElJ?=
 =?utf-8?B?RFMwdW0wS1dGdWE1YmRsWkdYcjBpdGVOdkpVSTg3UnV5RmR3SGJIMXdjYVdC?=
 =?utf-8?B?WWlob0NodjYyWGxHNm90Rm9oc0NUMVVubG81d2VETkZDbUtMN281c0h0Y0FZ?=
 =?utf-8?B?RzgxbVZ5MDhHamZSNWZHelZyM0hKRU9VT1ozYkVucmhwQ2NvaXVyNFNQWjk5?=
 =?utf-8?Q?3bQ6Zw/MK54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXM3WUtJbHBSWEc1T2hzcjBFaFR1NDJDMUdyeGpKMG1yN1o1REE3TklHa3Bt?=
 =?utf-8?B?VFp2Q1dxZzNQNDZqZUVqWDB0cHYxUHF1NDRvRzhZbnk5MlJGTXVrUDQ1M0g1?=
 =?utf-8?B?ek9sa0FrQitwYkNRSTRFbnJYTjhTd1hxc25haHYvMjd3RFNkZ2w5L2YzOXJ5?=
 =?utf-8?B?MmpnbkVXdnFoYmtiQlJMYnV4NXA4emkrRENFMHh4aTBlWXlkdSszUTU2V2RY?=
 =?utf-8?B?aWgxenFoMDNwQzY2aWNLQnAraWk4eWhvc011WmVFaDA0UitkbnoxT3dORGF0?=
 =?utf-8?B?bkZMQUxWVElSUjM1UkJQZUpKbzVaSFdsUHVzY0RDdGo5eW1oaklzdWtlb09o?=
 =?utf-8?B?M3hTOHNZUXpQbk1Ga1g0WVNud2MvQ1V4QlZEdXA2UlZybHhtVkRWWXFKUzFR?=
 =?utf-8?B?R3F0TTlRaytjTittZDkybktjUTJVVzE2czlUeVlJcUVnS2JvUVJmUk15NDc4?=
 =?utf-8?B?U3BsYm9yZktsQmNVN2l1VHR4VTgrWkhncnhNMStOZ1pnYnc1cHgvd0NKbkxz?=
 =?utf-8?B?dk82QU5MbXlzdEd0N2F5d20rTHZhRmdDb2tvZzd5UHNjOHM1ZmZCZ0F0Nkti?=
 =?utf-8?B?elBNZm1hUGdFUXU3ejJjUEtmVVN5aWJVYjZUbXQ3dTc4aUFmdDY5Skh6MzF3?=
 =?utf-8?B?SXRqaWZ3UHZubyttMnUxME5VOU5uVGdhZXhLNXNvTWRDNHExQmhMR3pkL3BN?=
 =?utf-8?B?QWsrT08xWGxUN2hFQXlodmtyV0d6QjJuNkFFNG1qWWRkaDk2UUtQUVYzR293?=
 =?utf-8?B?UmdwdTFtMDFBazMrcDQ2YlV1dkNob3JiemM3R2Q5Q1IzZVAzdk5rWTdUNk83?=
 =?utf-8?B?QnMyeFRkai9vM3pmZVUvejBQckE1SVB4Sm1GMmNmelVoVURCQ2lJcEp6TUpE?=
 =?utf-8?B?L0NRSVRUb2RidDl0Z1pENVV5bVBmeVplYzVlY3pwQmpWRVFMR0pTQ3pSWXFs?=
 =?utf-8?B?Z2JvTkQxbjhIMGhDT2tCcWFnSlp3TmxXQk9BdytVb1ozbXdMQjFmbE5JakNM?=
 =?utf-8?B?YUVaNFZBR2RxT2VxYjJTYjRVWExXbmFpZzBUSlF4eW0vVWZ0THdKeFNXamk0?=
 =?utf-8?B?RW9LMGEvc1M2QUFzRjRNSTA2cVRWRnBGM1ZZV01od29uVGZPMlFXdUdOL2l1?=
 =?utf-8?B?SkNReG44b2FhdUF1cXo3cncvb0tFbmlaNjhJT2dGWTh5REcwd2JtMXNsUGlK?=
 =?utf-8?B?dXUreDNiYUcvT1l4S1htUjZHSEljK1l3TDNmNWk1QmROMXZ3WHdqdTdLMVZN?=
 =?utf-8?B?NkpsRUwyUlUwWWs3cUczWmk1MzZoSFBqRUVyVU1CaWlaMmZ0RjZHY2tMV1V5?=
 =?utf-8?B?U0hsTHFGZ1Nyak9nVGs0TDU1T3hDOVp6WjRJbGt4K3AvYjhOVHQzWWsxSU5J?=
 =?utf-8?B?K2VBcDZLQkg4YTUyVlh4WmtVT1FtZVd4OTFnVDRxRTBaRHhKL2c4MTNnU1hY?=
 =?utf-8?B?WVJrK2VSVnRSRjdpN0NMNi9qRC8yaVFvWHRDR2dhNm8zQVZmanU4enhIamFj?=
 =?utf-8?B?clQ3VFIzeXBPR0VEWE9pRGJaWWVGaC81L3FCK0N6OWRvOEVhVkEzSHRIdzBl?=
 =?utf-8?B?N3JZa0FXR1dueEhIMUova0xuRFM3Yk0zZ294c0o3UlJobTNsYkc0bUI1aERV?=
 =?utf-8?B?MmczK1ZtaE9oZjRKdkMxckNqaUJqN0hTN3FlL0lGeDREZFJacEtld2tYNElG?=
 =?utf-8?B?WTBvb2hIYld6L2NkVytRbVNxODRaT0xXcnhTRmcvbDJVS0szcWJhbGo4SFE2?=
 =?utf-8?B?QTFaM1poQTFHVUc3MExTWHBhQndtaS85UERKbUV4c2V4NGJtTGZuT1M4RVEz?=
 =?utf-8?B?c1lqeHE1c0ticVlLZUtTb2NjMVVRb2tHdVVSNkJsNzgreGcwaUF2b1Z1T05Y?=
 =?utf-8?B?T1RrZHFtYXZYalNCMis4OFZ6ZHdxa01KYVNWeDdoTjlvczU3M0FvZnhXb3NN?=
 =?utf-8?B?b3YzdWxueGdueWVpdXNWekVlOHFuWFY4OU9pWjA2bHA2MEFqS0ZKNitZVExV?=
 =?utf-8?B?VXRwVDBnTXVLNWNFMmJvdE5ZckJNNmhXOFRQdFp5aVN2alpDOVVjWG4wRDFq?=
 =?utf-8?B?ZFJ5OU5RV2xsKzgvYWxLR1hQbG5rWlRYR2FKdktEMHVkY3ZRMmpTQVhFRXRG?=
 =?utf-8?B?ckRvV0QrRDdaL1l6b0lGdmhOd3NhcHNBeTJHMGxGb1paMjlrd1ZlWTg2akR3?=
 =?utf-8?Q?yCvBanJXqb9HMjjucyj20NJnoeXWWOc61QLTKmntko+5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b265ce1b-90ce-475e-e28f-08ddb309faba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:29:20.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taPDMklP3ZAHfENJzyVp9Olg8sFf860Miw3ioYXlPW8DKtiEL9VrxzY5nfhBzjct9kbAC35c1PiQAmw14j8aNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664


On 23/06/2025 09:06, Greg Kroah-Hartman wrote:
> On Mon, Jun 23, 2025 at 08:36:15AM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Jun 05, 2025 at 01:53:41PM +0100, Jon Hunter wrote:
>>> This reverts commit ac64f0e893ff370c4d3426c83c1bd0acae75bcf4 which is
>>> upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.
>>>
>>> This commit is causing a suspend regression on Tegra186 Jetson TX2 with
>>> Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
>>> this change but indicates that there are there changes missing.
>>> Therefore, revert this change.
>>
>> But this is the 6.6.y tree, not 6.12.y tree.  So is this still a
>> regression in 6.6.y?
> 
> Ah, nevermind, I'll just edit this by hand :)


I should have been clearer in the commit message. The regression was 
only seen for v6.12.y, but we decided to revert for older versions too 
for consistency [0].

Jon

[0] 
https://lore.kernel.org/linux-tegra/2025060413-entrust-unsold-7bfd@gregkh/

-- 
nvpublic


