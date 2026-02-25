Return-Path: <stable+bounces-219657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAYJHp8dn2lcZAQAu9opvQ
	(envelope-from <stable+bounces-219657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:04:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50919A35F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0812304B587
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817C38F931;
	Wed, 25 Feb 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NiAsYPGU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15433A6E4
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034980; cv=fail; b=Nv4tC3cBSpGDWR9nKwAAE642tfrwhk32q78ivvRBjeEDpGIM9znW4Pa2EVtYY92nEX6svmjDoKA8SbtT2BDKcIULbQplecqE3CHFiLc6M9TDbAey01LPDvnvz08ADJUyV2yeKtYQoIV0ePrLQCn5R9Sjv/gaLezo5cyqQ3vmIV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034980; c=relaxed/simple;
	bh=6OBAIdM96QuwmRLRG4C7Ee24jpyMYCN4D0j9qom7PWA=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=SSikPvcd7WZL7Dci7LJkinb4ajrO0wRlnOIntAPhUTPqIa4QmdQf0YP6fIA0SX7NQytZgnUFpHSTVUq3wUJd2GKIlBHJadNsjViMQWTgyE8cyOfLAwXzCmnsZylOLrTpDBFxi9eAr8X0cMBCGXbpdrNpCG1ddg5khToMargHh+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NiAsYPGU; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PBuc4I2188987
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 07:56:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=4OSz9D8H72M0cLjNUb+O
	PhuYIEus+b64P41G9pfCeuw=; b=NiAsYPGUfiWq6bzmN5yB2JcacrafHJWmQUip
	BZuJTn3RgZMeFrYRH5G+yIQNKZJpqHlggPkf6ZHRJCTApBJgeUZrQjfwMHQiYj0e
	vvwcPE48QKfqXouGxJNiQrNTkP6Vw+bMi8rwysy3H7+1JLNsfuZmEYiY6/itilY4
	VyWOSu19DPcA8fKEUlvCE05oFSUD0FxsYHb2stNwY/xUxQ/K8jrlu0VqPvv7rLLt
	JSATR3Yk+1fQfu0t00NUe2V2H+D+4J+1OgbpTBx9vcLnjyhwzoPKKjspvxNNGcXM
	RpxK11kTK1HFmoKuMEWjR1y68YPBssnpCeEvXrNwMWitZPc4pQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cf8v44ysx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 07:56:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIrWE21b5hogFsjM96axQDMe9D6iU8cEBEsLUuwvYX0tnjcp8JMySOnPYjKUmvHr1ZlkUYZLJMyZU97XxjUA77pr6K3Eb92bLzt1RJMTVLUn4mYfAg/wVchIB1WtTUjSfZOnp/34zJ/ynKfxmdo8m88oNzYDgbbrHJ3KU+QGSWgmSIm2fACxU/ziZzvuWaGyKsOY7lzBa2xGqxAgf1gRN/uO/0LT66JfkcWK/Ecvt4eaxKMfc8unj2RqO/82qTj4nayHiSPVGw4jITjHheXRByrROGO0xRi9cYig27pmlsxbJSywA7Bw6/CrsmGD3ZSHr0uKsVg6/lWxU2MD6SmIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OSz9D8H72M0cLjNUb+OPhuYIEus+b64P41G9pfCeuw=;
 b=SnQk5a/+uRiV6irPm0e52E1wonCdjZwLk6COeqI8NN7M9UFzs15FTtatDNpE9jMONfHSOqRgirM9ptCkuWjUJ6s9LsGtSqo3EPVQKpHFFgINEtr0TzWeMCVXXn3BUICmstIu6bed/dI7ya2smzFADPYS5wNIhoOTVSu5QHZBChkesYe+JcEf9H5EnSLFD35KyLi07iVh07zj/oEUiKr/ELMPMEJlvlmuL1yqHTiVE9RwQ+RQN3vUYOH/n5NjFuQjRWv9cC3VMf+Mk2Qo/i9K3oqsiXI6OCJhwE3U67aTj53sEWEXd1CG47HHG37468W/WlzFax7ercs+llBLM0Onrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:56:15 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::8ca9:28e3:e6fe:26c3]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::8ca9:28e3:e6fe:26c3%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 15:56:15 +0000
Message-ID: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
Date: Wed, 25 Feb 2026 09:56:12 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: stable@vger.kernel.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: question about automatic backports to -stable branches
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:208:a8::35) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|SN7PR11MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 184a689c-6b16-4096-8d76-08de7486679f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	7c7EBGFQ5e8j0EG2xt9Vc3/OM5ngGuA8CjVtqVia7lvAMDjo+Q/KcprNocNn+aekhOJNTrmK/1BGXNPosK5Oy23uMSo61ogrXVY7o07JAD4uUhbeXsRlJktRh8b7wgAWpgyisU7OuQL2pWbjQQSCCieC1+mY/L8KMe0S5gWED86C9NmRZ3CBVe8YYNcem1fUBtnqytWaiXMx0Et6wcdwCd3BCRlnVDx+/KaTSPdA6sjp/jOdYZLQgT7knmzZxDqJbX+7RG+KZ4bdEdswTPItzdA7pyWB0UpGhYN1p/sKDWDfTeTSi9kostSpWnNcpI8g8pw9poYOgNEPuiN+fURRXwcCxaowCbiaoiZcYMWVwZecnaDOU0KWcAc2gQ5G0ZR7da10KfprIKPUa+4UtJc4mFewCTjQC7Qc1aszRryFCiTK06GUkqwpVPdrYZrXPCreGxeR7vrMRRZVOthI0Tz2n3rBCNCt9bHNshAlxP1iQwmy3Nki2TyrkzwSS8+fSbUOle88ajErouJnVdoMPQNmLoRQTPJIuKggfuFgO3pMK2Z4WA/kAlQbNGMeIMi20ttLfk1flka9Vp6Tzc7+QInjhekYYFC2jJwWBqVQSj8urXHgTSZOnb32vfMJr6qLxzHrp58BZGjVJFAJMnt3dqpKcjMwEdhscFpxiQpAt6c1RyJ9xl1mCYDlXNp5uA/0XGQ4absyIbg8wxFaipr/tAfksd9wW1HYuIsC3cHGXcNzAGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3V3NHhrUmMyMy9VWTJoK1VUaURtUjBnTWZabnNVc2Zpa0N2d0xMQ3ZwU1F4?=
 =?utf-8?B?RXM5bnAzSlRUdURCblNOREROTXA5TUZJZlVNakl5NjRWSnVaQkpKdGc5Wmg4?=
 =?utf-8?B?MDdHYnZzZ2tXWkgycEFpcXVHM1ptNEdjN2dmb3MvN1k2Vyt3YU1OQS9Pc2lu?=
 =?utf-8?B?RWEvclNMbFIrUEkrcENzaXFZUHNTcjV2aWlNd1U2cU16TGxycHArMzRyTGFI?=
 =?utf-8?B?NndwNUtYbEZWek5VUE5USGlZYXJnU0NVTnN0cUVrcEVwd1dFRmF5Q1A5Nk1U?=
 =?utf-8?B?RHVBZEtMQmhyTTdLam5kWkxhVlVlMTJKTFRSeU8vU2lSazc1OVN2NDA2N21q?=
 =?utf-8?B?VHhlQ0hhRGU1NHVOTVFTOWtVeW5ybVFqTnoydXFqalVTQUNqM2pHNEtiV0VW?=
 =?utf-8?B?UVRoQndNbmRqbFJMSGlmdWtxM3o0U0Vzejhjd3NKQ1ZtWUdHenI3ZUNQcVJw?=
 =?utf-8?B?OVVtN0kzeTF3eGgzMVdrd0xlNnl0dDFvSUJiY2ZjblVmTEc5dmVrMWVxRnNK?=
 =?utf-8?B?L0pKalpJZi9qZkg1M01yTzhzc3MyYXJqUkVlRTlydU8wdytLSkl4eUtYVS8x?=
 =?utf-8?B?MmRaZXhHejlDd3llZENWOVpnVnJyL3RLSys4dlY3REZXeER0VXZSZmVTUGdP?=
 =?utf-8?B?d1l6MEJadVU1dmJOMmduQ1o4bHloOWROQU1mcHk5M0lhK1orVjNKMThBaU1G?=
 =?utf-8?B?U2dpRk9DRWpDYy9KalZaZ1lyaUJQYVltdlFuYjBudWVUSHNBQzJ1NFFBVXVp?=
 =?utf-8?B?RjRpNGcxeEo0SDByRkdWWlF4Z2JMV1FVWUdxOVg2SDFKNlBLOHp0aFY5OGdL?=
 =?utf-8?B?akNYQnlTS092QzFHS2xBK3FaWFJ3WU0zMUpIQ2FpVEs0M0N2Z1V4YWkrRkR6?=
 =?utf-8?B?Z2Z3Zi8rNzl1bldMR3pyUTlITlp2OXFicUdtaytVTWI2eXlibEFvSWF6bzNm?=
 =?utf-8?B?RnFkV2VVVEQ2Uk1XZnp2Umc4SlBORS9EVUFGenlJbDBWMmQ2VTZjTjU3Z0sz?=
 =?utf-8?B?SEJTSklTOGNGQjdWOHFZanZPU0Q4bVduYko5SjJEcFNhM05zZWRibkZmUW5m?=
 =?utf-8?B?cGZwSU5Bd2ljR0p1cGI1enVRTFVmWFFFcUpjc2R5WVl6SVVuMDM5N0NkdHdv?=
 =?utf-8?B?YkNrS2tKbHhpN2FzZDljNnVzRTRadlhCT1haNUZ5ZVZKRVNhVWNxSmZmblVj?=
 =?utf-8?B?Q1ZYL0lUbGxlOXlEWERxTW4vRGpaODhSTUFTd2ZmSXpoM0x6VG84aXJscEpI?=
 =?utf-8?B?TDVmQzVmM3cvbDBhTXVXbFZ3V2dCTXdrdjl3NC83RVMvZDFjZEpPeVRXb3Y1?=
 =?utf-8?B?anFZZkFGZDJXalFUcE9SWndZMVkrMzRLeDRDdTZuK2M5dkxGS2JybVZPbjhR?=
 =?utf-8?B?ZlZjbnFwaE5yLzdvakQzNUgzcWJqYzcvQ3BuQyt5MFk2d0FURzZGU1l6bFIw?=
 =?utf-8?B?WHRKM0hlODZOQW81dFRyQTFzQmZHdW1ud0lBTUNocXB6amxya0JQQlpxRjJM?=
 =?utf-8?B?NkVTeDhKWUx1UmhlUVRBSEJYMFkvSCtNbjBDVnRGODZBRU1MNFNhU3NpbHhx?=
 =?utf-8?B?MjlRTUU2VVp1enhHN0RESzRKdHlhWW1kZGdwUXlDQmhqRjVLcnBGc0I1WEN0?=
 =?utf-8?B?cnRmTXVsaHZoRm1WcC8vM0h2THdGWW9seStjdEZrNVpOMnp2ZjZKeFVtS2JZ?=
 =?utf-8?B?bmpCUUpRajlhZkMvcEhGeDJoUXNEMjdadTE2SkdNc2t3Y2FoM29qZ2hMR2w1?=
 =?utf-8?B?STkwS2lSNnNIQTRDUUJiZXVpNmJFdmJsdEF1eDRCd2NZdm5LNzhvUlptaTdT?=
 =?utf-8?B?cGFxWlR2SVlkNXZ6ekZzSEkrNTMweitoTUUwd1NVSjMvaGswWnQzNnY4Nmx3?=
 =?utf-8?B?cXpaQURoN1ZZakZpNGNzb0NBL3dYQWErcDRDbnpkeVNudkxZTVBEU2FqK2ZI?=
 =?utf-8?B?SHpEWW9sakJiNWloTjdhRlpXNFhHa0JBckdXMVhOMHU4YWNuTVFuSkJyc0Ev?=
 =?utf-8?B?UkJ0Q215V1Q5NGxIdUk4UmZ6RG5vdXZOaFk4d0NkbzEzOXNoRzVrR1ZpMTRk?=
 =?utf-8?B?VWJRTnYvMFlzSlNTK2I5WEI1N25FQkVpOEYzRmxpTnVRV1pueHliZHdDSVJw?=
 =?utf-8?B?Q1NmV3Q1clRHcDA1ekRLT1BOYmRiYi9NSlNVOG5adXFGaU1WZktiODVyNURY?=
 =?utf-8?B?dE5Gbzk5RWFzK3lHUGVWSUcremQvRUU4allMWGN6TjhOYm92SlFXRmZSQjhC?=
 =?utf-8?B?elJOQi9wYU85S0tqU1pwRzY5S29pYjJBY2JJSFlCQmIxdXdXNmhGRGFSVDRC?=
 =?utf-8?B?azE5YlMycEdmN2hScytJVmhoTzlhdHBYYW5sVWhTV3IwK3VsamR3LzlmbTQ5?=
 =?utf-8?Q?+opH2AhQSsak8ZLk=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184a689c-6b16-4096-8d76-08de7486679f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:56:15.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovDrRyfC8P9vIfMezPKRlvcSupXCFXF+guBY4jZddCSX/0CTVukZtEPv2bbHImtDNWvl9/QzlwO4sbazodJl4wL0d6eCQZm5F2CGEScrUW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1MiBTYWx0ZWRfX1n9FpTY1c9iB
 ALshMpWf+lXLFNPmiHAZ6kajaiP7B47RQYcJxpCxezljceFuI7xSsclcoqmUWUBYVva89XiH8qP
 Sntyj/qFyweBtNbfcZu9cspnBgZm3kn4fKoN3pOPq5Xqau5Cn+yMpn6PIDXayY1krR7lYIRwmRb
 DpuPQGhvaKhlqVWCONAndRqlz+5/VhtvH1eDXyoykX10EMLj/QxGUEeQ096iXMXl6eRBcRAux7B
 DeQSIiFq/kgXAUkbgjCxM6gcw+WYGa8FlNywknJc+GMZEn6NLghjihCB6fMklYIqbFgtvd4Z5W0
 LbcLvqI9XBjMAD9zwRZTvWEYQYlXtYasn7qQCmleNwZUJuyn+XiGR/y8Rov70n+xBcOXjBVzccg
 YkKPr2yKa7MDAIwg7Ne6HBn2HcjvV0bPr5TLVDjAhJUU1jUYxpwl00wxd5bxxT7aEw58NLAUPas
 lcG6gvI9pRLRd9hGP0g==
X-Authority-Analysis: v=2.4 cv=SNNPlevH c=1 sm=1 tr=0 ts=699f1ba2 cx=c_pps
 a=YpUwD7Le0KImUpHpM7zjfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=K19iVsl-5_AI7kOG4mQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pbi_Hc2jwctuUdA5oPF2URKso0PD1KDo
X-Proofpoint-GUID: pbi_Hc2jwctuUdA5oPF2URKso0PD1KDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1031 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219657-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris.friesen@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB50919A35F
X-Rspamd-Action: no action

Hi,

I'm trying to figure out what the expected process/timeline is for 
automatic backports to -stable.

Commits 2fa119c0e5e5 and a5338e365c45 were merged to mainline on Feb 01, 
with the "Cc: stable@vger.kernel.org" in the commit message, but I don't 
see either of them backported to either 6.18 or 6.12 -stable branches.

Is the backport a manual action that needs human attention?  I had 
assumed it was mostly automated as long as the cherry-pick was clean.

We've tripped over this issue on 6.12, and have manually cherry-picked 
the fixes for now, but it'd be nice if we didn't need to carry the 
patches locally.

Thanks,
Chris

