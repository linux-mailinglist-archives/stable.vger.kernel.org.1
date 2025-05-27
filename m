Return-Path: <stable+bounces-147891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D1AC5D73
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 00:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11271BA491F
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB202144DD;
	Tue, 27 May 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4mqmIzb"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9C382
	for <stable@vger.kernel.org>; Tue, 27 May 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386795; cv=fail; b=K/aG246DKCSEl7kATHzikMwCzaokboRM8Z9q7nv6BGHOQ0SntIu4L/zm2geKfIZnaaNATNBi68BW5X4kqlvp0Muo+vCm6DPpoWQf7G/NIDMEkf7e+nhfvvRJLRDxS5Y/K97/7sqnhMftq8yiXLVIM4bWjTFWkxOVKqIhME09EEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386795; c=relaxed/simple;
	bh=CNaTCyFvg+czCBftG8a5ae5FYIyuEmEJF8Isa04/yYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E5DAzmUtSAWPNjTQQkx8Jtzk3eS8vdWxkmuuuiHNq+7ROKrE/G5IGfXIDLkPtkMgr6L0P32ud5TOYu6Sc4xzsZ3lexXFNdzJzHF91LKmkLtHRpRsA/xXzSPf8r1wXZnS+VucGllFclsTZeB9UixOvt9byGj+NxW6PIM6Jv9hCfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4mqmIzb; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/K4Fxk4aGmSyr4HSeMC/y+f0BE7nOw84F7uBMfzEpKE0RQc4254Kp9CyH9J0oYyfTPzhMVjMYL53ZQHwgc4FBN5SxKUtDUvtrrgNDG+8ZnRgoMeOTX8/gAJfFfYvryK7cvw8ZQggnzHjjdFnYwZBEN293WVum+QK4F0wtvYQVBtysDxA8sN/7/kjxD91FPIpreshSI3xNwLCHO5yklah6nv2QQLogRktP6JuAO6AWS7rJK5b0ycIdLLhDsxouXhkJ6l/cO1tb98Ptz+d0Y10IRT59ZiXmjA/+6lY28OqWEwL4s5rT8XklCLMETbeh8fGqmq3b54S/G773kFemx6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIQpCyh2r5V9T0ZjtsC/r5AGnfDRu7GpvuUXFrS2Oq8=;
 b=forJrZCJmstd/rsbRNEQZgBlpEjaBvN4cK1xahXOvhIzR9fBZMJ9Qqul90yEbPZlPz1QOOss9nQFvmWokN7Q8qjMQZJonImgydnHq8ZDlyQ8sFXZ4RbkecD4j19vXMxZr1wrmD4YW9DNobMwzNTRB6eR7Kzno3MDrtKThYBwkFNM8I7HKObzyqqlwnfQ92HMxOcrWS/btMME9CwDroyLz9A4x6GaumNXovfq9wz+y7Wv9jFTa+aiNmq4oRMoq+/95mfhU+qGLsZx8siGnGBSwmF8r2LdQEF/PTJq216miu5zghPCkbL8teJiMJ/rSDP4oG6iuFbPdQndE460WGP1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIQpCyh2r5V9T0ZjtsC/r5AGnfDRu7GpvuUXFrS2Oq8=;
 b=m4mqmIzbNP4cACw4G/R6Ka93xTY7+wqyDAEHZLpnQGETBNJWb7X2qi7UDetIgqHx2MoSf6z7UVBcOGXCYlSXFEjYOjejVevfbetoYhwTgIoEFfWi87UL0/MFlryTl7lDfqmrbGrtWueCrtyYP8eIKNFUzJCU7xcbohx0hNLj4E7T4RlWFEG8X53hEbpfTY/NcXDbwn+Ddb3SgyPD2CVwIOcXdXRzjMv/zyudYt0O5tiIEQoosgcGk4o0L2UhyqQ61m4Roc9Z8kkof1c/zQ1jpPFCTFwwhDcNLCRa0KwtnMZwULFcSuXMOjQYNy8ztvEUVlrqGySHNrM+KnYrUIY8nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 22:59:49 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 22:59:49 +0000
Message-ID: <0c1d51d3-7f25-4a7e-b97e-dc2177d6bfb6@nvidia.com>
Date: Wed, 28 May 2025 08:59:42 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] x86/mm/init: Handle the special case of
 device private pages" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, airlied@gmail.com, akpm@linux-foundation.org,
 alexander.deucher@amd.com, brgerst@gmail.com, christian.koenig@amd.com,
 hch@lst.de, hpa@zytor.com, jgross@suse.com, mingo@kernel.org,
 pierre-eric.pelloux-prayer@amd.com, simona@ffwll.ch, spasswolf@web.de,
 torvalds@linux-foundation.org
Cc: stable@vger.kernel.org
References: <2025052750-fondness-revocable-a23b@gregkh>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <2025052750-fondness-revocable-a23b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 57306135-c80e-43f9-a487-08dd9d722e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anFVaTI0RWkxN1ltNjk5blZOZ083SU1SdzNPQzdkMElRQzFadkFRVGs4dUQ2?=
 =?utf-8?B?aXNsOWFwYWdaakRoWG5VelRObnI2VFlBYi91U0FrVXRTZjlHdTF1UDZJM0Fu?=
 =?utf-8?B?ZkpaUWFScVdkbWJ2YnQza0d0WEFlSC9uRzdxLzhqSTVUaEVUemVpM2RqM2cv?=
 =?utf-8?B?MU80WUlDZlIvSjV6cXFlV2RGY3EzaDBLMmNTZ1ZRL3RjOG0wNnJwREJTaUJu?=
 =?utf-8?B?U3NFaDl5MHVsRmhUZHBlZTlrM2hxdURDdmVBRXFUYU1mYlluNVp2UVFqL3dk?=
 =?utf-8?B?RC9Dd3ZTdW5saDZVWThVaXNLcEdGeU01UlJneUowTUZKcTdQNVlvdzI4TDdM?=
 =?utf-8?B?NTFMZkQ4aVR0NUNUMzZWZitVbG1wYXRXMEVJTmh4TG9EeU1zZnhMU1VyZy9h?=
 =?utf-8?B?MHNyMy9oRnphSlpVTTEyZlpkNkdxdEhZK2szRGhOZ2QzTkk2REh2Q2QyUkRE?=
 =?utf-8?B?WmMrTERYT2hUN05LR0RtTHRSS3NpMjBQZnZMLy9GeE1GSEFDVEJaWTgyZnJx?=
 =?utf-8?B?bHpmVk5SZ3hjekhGbUd4a1VJNXh0NDZIekVLMys3cHU3NWdRS3VBSE1aSk1s?=
 =?utf-8?B?RmpEcXN5TCtJdC9ZVTJDeStUcEdhenN6dFpWWG03Yy9WNHdMbS9nQ2FtZXMw?=
 =?utf-8?B?cWJQUzJncXB3aTl3RVA2TWJoT0MxaVg2QU1DdlFBNTFpRmdJbmpxWTZNaU52?=
 =?utf-8?B?QW80clFnOVlNR1ZVcmpSNi9RSktySlpVdVVueWl3S2JGNGREMVoyWmplUStI?=
 =?utf-8?B?NVZQMnhhSFRUS0VBbFlCRjhRWXV6bkVFcndEckgzS0dxR0V1NFNuREI5WmlP?=
 =?utf-8?B?TUZ5YUlZMjU4dDB1M1lON1owaGZmblgyK1NoWUNETjhZaFNRSmpNeFIzcUp1?=
 =?utf-8?B?dmZ3Z3FNK1hMaW5BOTc1YjRJcHFIc2hKYW93Z1gvWnNIWXkyb1dkKy9zQ0JC?=
 =?utf-8?B?SjVpSWV1OTlLM3pWLy9nYlEyV2F5a2JnalhjK0s1NXZLOUJobXFNUmwxWXFT?=
 =?utf-8?B?RHpndmdZM2Y2V0ZhNUNqZHpqajMxNkhqMmxXSFRVaURNaE43RlBtbm8vN2h4?=
 =?utf-8?B?ODdibk8zMDg1VHlPNDFtcDlXNWRZUWFodXBiRXFPNEp5VHdsV1U3ZVJBNkV5?=
 =?utf-8?B?TnVXT3ZDRzYxL3ZaNFNXZzdNZWludkVQLzF1SnRUNXZvMnVHOVBmUnI3OE5Q?=
 =?utf-8?B?WWFrR2gzaC93VXNFTUwrL1A1dXdBc3lrcUhlTFkyVHNYTnNpUWhGT1U5Yzhh?=
 =?utf-8?B?SjlVeHlGcFhxdG91dzRTY3VhUUp5ekxmTzVsalBDb1VvMERSdThkQ2l5M1Rn?=
 =?utf-8?B?WUtsNGs3V2duMk43cUlKbG1ZMkx5eE9hR2ZDcmZXTDZDNEN3algxM0lpM0Yy?=
 =?utf-8?B?MFlJZSsrYUxRYWpvS05sTmx4Ym5QalNRcmU1QzY2MlBtZ3lPWWJmaXdYVytj?=
 =?utf-8?B?M0FQeWpuaDZwL05yR2NjNVRUUHRnait4MC8vWk1UOVJESUdqVWk1N2Z4dFBV?=
 =?utf-8?B?eWExbGZyZ1I1TFNuT1hvUnpWd2dmZVJkNDZvaGtOY3BmdWRnQlo5VzY1YVow?=
 =?utf-8?B?VkEvaEZoSk1XYzl3cWpYUG91RFhDZ0FwMXRCc2FvVlpqazl4KzlsTDFDZmUw?=
 =?utf-8?B?NXhwRmZmWU1IUHhhUHkwUHY4cStHRU8yYWlKdGQ3K3JKWTVTT1JXcFI0Y2Ew?=
 =?utf-8?B?VWpMV2VRVWhqK1lwZTNuUGpmZ3hFZHhZTUlOTkRhQkdoV1NlTmY1Q2ZnY3R4?=
 =?utf-8?B?WXBmQkVPenhvcFF2Q2RtbFoweWRlTHRZaWZzWEZQdXNXR0MrNkJBbnRyVkRZ?=
 =?utf-8?B?WFJTZk5rWlIrdnJMaUZGczdXTjZ2VG1XakFndnliclhNK01zZmZ1czU0YnJn?=
 =?utf-8?B?Z3RBb2ZseUsraFcwQ0VFbktFL01XUEtydk9hUlB3elhIYTQrVFF5ZDNsbUFt?=
 =?utf-8?B?MGQ1Wk5OMjgwRzhHaERiK2t4L2k1dUlUeVFBM0FoVzFyVFZhM1RjVUg1OURu?=
 =?utf-8?B?TjBuNFpQM1NBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxicUtzZzNwOUJyenkwc29KaFliRlpXSVljTkpZYmhSM0syUCsrMUVoaFJp?=
 =?utf-8?B?ODYzUldIRzNsSFYxRWVmY3ZyZk1lcXVhZ2d3K282ZnlQdnBSZGEzT0ludXRj?=
 =?utf-8?B?Nldqc0lmTlJPK0JVTzM3R0U5LzBkaDJmUzMreFl4eVV5UTlxOHUxYUNHb0Nw?=
 =?utf-8?B?WVMvLzB0bzkyRVNNaXdGK2huaStPVkVRRmYyMHVmbEYxSkJTbGdmWnNCZVdr?=
 =?utf-8?B?eTRtcHowUHl2dXhyY0NTcHVDYnFKa3pzc2pjaUx2RW1VMElZZzNCMU9tc3pr?=
 =?utf-8?B?ZkpGdFNHUVFsN2I1Sy9DL2Z6MndnRS84STVxVUZXWFNFSi9uSWdES3c4Q3k3?=
 =?utf-8?B?dVhEWlJZcjRGME0wNXFZeElSRTlpUnJCaVV4cEhwTG1PYWU1WU5QTFVMTWpj?=
 =?utf-8?B?dURwWEI1WXFBUXRrZ3RKYTY4TlNMMndwbko2aXM1NGlWVEJsUVFzUndreHlM?=
 =?utf-8?B?citjeFQ4ODhlMWJVSnVqRjJCTmYzZy95NzhmeGRCUkxncXZaVXFIRS9zYnZG?=
 =?utf-8?B?TFdKMlBmS1lnZ0V4RFdQTDVMcEMyZlRzNFd3VXJNODJ5aGVscGhlYmtESnJM?=
 =?utf-8?B?bEZraTdCc3UycUZYalRqSjV4ZkdRWnp0Zi9KbzRQN0VYc3hRQjRyRFEwc3dU?=
 =?utf-8?B?SGhORkZkMXoxL0hDU0tsZWhpNktkcUMxcXo5QWJVbU1ad2NZRXVFSm81VGZF?=
 =?utf-8?B?aGhnTk9CZHZaYXZhU0dYVVh4WVlJOTg1U0p1cWo5dnQyemVBeXFJMDJhMmVu?=
 =?utf-8?B?OGlCYnFabHZDM1RzRE1MNTdvNTF2Tlg1ak55UXZwOTBva2NCYWtiVlVBQzN4?=
 =?utf-8?B?SnVRRTZQSTFyV1R1dVR5TDdGUEtjT2FqSHY2VlhQZkZ5UmZnejhTaGhDYlJy?=
 =?utf-8?B?QU5YYTRScGN6cWdjSEhsdUluVE9kN3FPMy9VamlxenVHb01xYXB6NVpkNDYx?=
 =?utf-8?B?d0NVZXM0ZW5aZS9yYWVwSHdBcmZtc0htTHlyQzZYa3dLM05adDUrSkMzcERy?=
 =?utf-8?B?d2h5UkpwZkNoTlFQeEs3aVBsazFYNllXREVrYTd6ZzNDdW8vV2UzRnNyTlNr?=
 =?utf-8?B?NHdkQWZHdGo0eCtrZmVjSkpLRFljUmk2ajhJdm1LeXpaZ3lqaHZZam5Hbysr?=
 =?utf-8?B?RU85YW9SdkFOREEwTktpQlpRM0VqWlZmWlZnaDhhUG5DWXMreU80NU91UnR2?=
 =?utf-8?B?Q3VnQjlNcjBldGJnY2N3NU5MMEw5VXpndGRWUk5mK0E0ZHBOVUlzSldPRmkw?=
 =?utf-8?B?cEUzMWNTZmlSYTdwUFVmbkg5RjJCVVlJY2xydHBKMWJLYnhHSjRWUnJ0M2N0?=
 =?utf-8?B?MUs4WnlXeTY1N3hWZGc3cmRwRTZORkVZd3dCc3huM2xrS1lmN1F1YXdzV2hB?=
 =?utf-8?B?VXdIQkZxMzkxa1ZEdmllc2xpeHhvUU82ZzhHM2F2cVIyaU1mdGxNaDNFaE9H?=
 =?utf-8?B?ME1QaCszY2I5VWVaZmZsc1I2aWx5UzFGSVNPcTliL05RcW8xcFNXUTNYVzMw?=
 =?utf-8?B?MWR5d2tQc3V6Snd0ZXBaMUpPVlUyL1VkbGxTVktJV1ZnRlJOblNxbXNKdktE?=
 =?utf-8?B?V3NkVHA0bTZaSXllQXNUSkRxb0p2L0hBenpQVFlaOWtUUzRHOGVLNHVORUxy?=
 =?utf-8?B?RnMwaHc3eDNKaHJtMVdLZFlweWdEdS8vdDBuVFUvY21raHk2cWhRQVV4aGN1?=
 =?utf-8?B?aFVrc3RyWnhTb1NhOW1JYUJXamxGcmUwSzNvZXlsaHpQMk4zeUZYUGpueUtx?=
 =?utf-8?B?c0VPTUlPYjlIcWgrU3d6MGl0QTlDeEZSMTR3NndGeHgvZTVTb3dQbWEvU0gz?=
 =?utf-8?B?cGR1UkhnM2g1a1F5VU41TWFvMU9iS2IrbVVnV2ZXdTY2cWt3U0dMQWJXUklM?=
 =?utf-8?B?K2lpeWNCM0NWYUJyQm54enJ1Z1Z3eGlrNnlGUGIvazdZUmJNY0VrVlNXZ1Bp?=
 =?utf-8?B?MFpFN1l3VlNFZ0E4VCtUQmx1dkc0S1NDKzBjMXhmNzNOZlFsZjRGMFZ6QVhF?=
 =?utf-8?B?bHJ4cVBrNm5iWWZSUU5XdFc4N01rTCtienIvZWJua2Q5K1lDRzZqREo3QnZx?=
 =?utf-8?B?MU91dm1YYVNIMjBTUnNybWVsdUx0TEFFQTMzTHM4TU5XcTNOZmUvMUlFREJh?=
 =?utf-8?Q?VyHCn6OJ6gmxeZlkyY88VdBry?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57306135-c80e-43f9-a487-08dd9d722e88
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 22:59:49.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP+pyIoJWGB1BJIJsZiMxZXExWBpLyU9Z7HdflPwUqqh/I1cmn84Wnv5uqY+fRkoziCFdP+6rM0nDgOw46ZG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

On 5/28/25 02:55, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052750-fondness-revocable-a23b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 

We only need it if 7ffb791423c7 gets backported. I can take a look and see if we need the patch and why the application of the patch failed

Balbir


