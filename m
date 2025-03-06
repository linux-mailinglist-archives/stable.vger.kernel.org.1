Return-Path: <stable+bounces-121281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B611BA55231
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5473ADEA8
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A925A33C;
	Thu,  6 Mar 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/RDVZcM"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8792561AB;
	Thu,  6 Mar 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280534; cv=fail; b=DD41FifIZW5vnnV8Y0kn7x2BawTcEgPcwDbijKi+Th834TX66j04flo6aVO8jMU59XLajNictZ9co87/xae9qT6XDe1BJ24LxeuodywJ8YZ62BeHSmfv95cV1EOBYvYZtuq5MRuiNPxeteHpKonkSinCjxPwwJcYOJP+RQ/Lb1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280534; c=relaxed/simple;
	bh=VMNwUi5dzFGCey8ddHHUs0klMM+hbZy1fERQqAP2ySc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwRnAeF63FBMLJzagrBJ6mymjNgfAyu+LUyKLON3obAQogSAGB0OsqNaCn8f2MeOCuVb6bRCwwhKChHpQg40TfLtZA3zSAOT0UTbPfu3CaJOtFlSTdL/P4KZwYL8Uy7zBM/wsUP20DawVf4N2oahJW/jo48Hren6+hg9IA/GNO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/RDVZcM; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wcuhi3pWDU2W4+sQOuPnXix5JblgH014k2ahIf0rB+6UHa9DKw5a+JRoga+nxkRSo5JhMVPt1pAxMsrRWk7o7dBDk4v293jVtxKspz9AbgF3uVx1kGcG05lCaDmj2Pde9OfZr+on2xRmDnaLuqwNLo7x+dzCfv2Iy2A2X6ulTzF7GWQsPKk5OD7WOp63zEILCBeGEgwizFbGL1jCUMVQFTHTJ/oz7S00igS2dzOTAxPQJuWRVemf30lIRHI23ilck8wmfUNcFdSJH/5APjyMeqv0IM+Dkze/ynMOcXgmL3k6/imlyeFu0rngzM1aVj1hNFszC3DiEFO3RaoWp19/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUoU2dlXh6zTOgPMBagWEWt36VEIli/hSTmbS7c9Jg0=;
 b=GsNAaqvfW4SJQc2mXT75qkpmBZwp/RGbiKQ6oDXhpLH/Y/waZvRq0NHa9WLwx1SvEITMDKsz2ruCJ/TM8up/H4u597R/wLp1gZFOnJoLWMqZXX6A4EwQadun6CRlccEGePSXCb4c86n5yy3dgMrjsYz58hwgCdSaDywNKMfX8m9cPcWLx6Q5AHuj0OwdwLtJCJ/wlm0jTw1OGjfFma3t6i7vKvZFJgxwVMKwmd6viR7+E0ZTmYX80ef2WO1YR6x4jFBFUten9ZBZxFBr1J2dLeOTYiNhdUXmhMODPKThZ8QEiVVDodwTqfoNOd1GzKp18Gak3giD2CZZFakV+IUafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUoU2dlXh6zTOgPMBagWEWt36VEIli/hSTmbS7c9Jg0=;
 b=G/RDVZcMx7xIm57R9kAXLfbM+IsGUGDsw0k+9j0QQPe7loVqCkw+3n16rYys69ggqgq8LB+T4OU1RMtQUC4r4+FzFwnV3tvYtxxniKtdZQ37m7RaiJcYCN1VQZVlO9s/rpe19jZHEU/v5qQUMpsw5JElp4Dia7kzUY+IS76jOyYT721xWyIqgXO4a9LxLACC+loFUOlRV8ZOzj+gZXEX9ni8bS6xXvIGuHUiqgQctkUsZgR4UO841axy4jmyUy8YAA73NT4WjVGyOfmXYp5+OUbwpJj7/wrSXRav6vamaGAFiGnO9T4iZtmkgokiI1psiP5ieEXnHwY5ltvfWNsXtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 17:02:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 17:02:09 +0000
Message-ID: <002836c8-002f-43bb-956d-e5dce6546af4@nvidia.com>
Date: Thu, 6 Mar 2025 12:02:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Disable DL server on
 rcu_torture_disable_rt_throttle()
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 stable@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250306011014.2926917-1-joelagnelf@nvidia.com>
 <Z8lsX0GDrx7Pa8vd@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z8lsX0GDrx7Pa8vd@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 66212b2f-838a-4c31-13e1-08dd5cd0a1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0NxSW9vM0laZGtBRkZqcVBvUWp5dWR0eUROZTJFNXhXZ3VzZWlNNXRhaTNy?=
 =?utf-8?B?QURCT2dZOHRBekFBbEdQVEZqMUZFblZXenliT0hzRGJ0eGIvSy9RSitrL3FS?=
 =?utf-8?B?d0FPMFRYK0dVdHlvYXZFVldwZXNVZDYzc2hZNmpTUlVYTkwyZklTYWdQL0N3?=
 =?utf-8?B?bHgzMkVucW1NVjRYWGhQbnhraUhQVitZejk3b1ViZkorbDk4cE8xV2QzN1FF?=
 =?utf-8?B?SFk1T0NWU25KaHhsdmxkQkNGdHpoc3k3RFZlTmRObmVITEVKTVhGVjNURTR3?=
 =?utf-8?B?UDVDTWhkU0tjc2lkS2VWUHQrdkFmaUt3TmJFQXZpL2VIRUVRNlhKYTh1RVd0?=
 =?utf-8?B?QWhGZWRsZjRvallMc1lsVERDeVYwNWRJM0JVSnROTVVUKzREYmVubmZYcjRW?=
 =?utf-8?B?M2tPZVlJRDl0OWtaUTNkQ1MvQURoRVN4QTdtWWFTQ2F4QnVWK1RTMEExVk13?=
 =?utf-8?B?R2dMVUtsUVlWdGhUTjkvVG9Zb2ltMVozU01oVG5qbmtmMnFBNTMxTUkzdTE2?=
 =?utf-8?B?Ym90WGt2Ly9aeit2QzQ3dWk5dm8wK3FSQXJvSEovQVIwOEZ0NjVoQW5peTRJ?=
 =?utf-8?B?VEpqNk1ZZHdmQVJyRjRreUNMSUFDSFZCK25BdkErTy9qYjRPck5oS0FZRE54?=
 =?utf-8?B?dzNqUk04ZHVCa3VXZ3pUU3BCb1d3dEVlMHhOYlQ2cDZoTWZ5T0xhMmU2cUFB?=
 =?utf-8?B?TnIwWVpXYTRndHY4Z29IcEVLaDhTZWdzSkxUMEZXTWVqVVdkRVVCUERQMDc1?=
 =?utf-8?B?OHRjVlhHbmNXUG9UN05rRVMxUWFvTS9ER1diMVFTbXc0TlF1WmpoUTNnZ09C?=
 =?utf-8?B?aTNkdnhnZUxvKzZGLzl3M1lmRmhEWGRybTVqR0hoOVRBRW11VXFMQ0NXM1pj?=
 =?utf-8?B?akM1K2Q3ckxwZ2Vyek10dmNmOXpjTkdURnZ3U2wzMUFpZks5TWhUQVZoUitW?=
 =?utf-8?B?d1NNb1F3VWpOcldYYUNUY0psdnBVRHNURVFGVnZvcTZZcEN3bWFXT2Z3Q3JB?=
 =?utf-8?B?LzdDWXF2clQwM1BmYldOVjM0aDJCYW5JeUt3TE0rRSs1dXhzNlg4YmRzaURB?=
 =?utf-8?B?Z0NVaTk3S0hPaGdSNXFlazcyYUEvcEQyWkZDY3Y2c0hZWkdrSzc0YndLc0FW?=
 =?utf-8?B?MFlOc2ZFejczVk9HRXRTeU9sdnNaQjk1QUI0MGxhQURQdmdyL0VOR0RTR2l3?=
 =?utf-8?B?WEZVR1hheWg2ejVFekg3ZjZoNkNjOFdCZHlvcExwU3VkWlptcTFmTUloVFM1?=
 =?utf-8?B?cmtVb1dsclhEQWNPaW01RVFIUnpsMW85UE5XYnN4OWpzcXFTRitjbm9xcjhK?=
 =?utf-8?B?WXZDekduZ0pqaTloY21KY2p2Rk8zbWhiQkM5aXRxenhPU2FjMGRwUW03bzFN?=
 =?utf-8?B?dkVRQ09ETVBveUIvQjR6dDR1OWdQaTNxNmV6c1pSYlZTR0VHd2ZaNU16dW8x?=
 =?utf-8?B?MytFMDRPcVZqRGMyazQ0WmRZRVFwNzl6NTlPeWxrcCt3SnZmN0FJbHhLVG1r?=
 =?utf-8?B?SWdLamhmY21McVB2emdnb3UrOFJVTXVqTGhrSHM5KzZuQy8zNVRKMnVOVm1R?=
 =?utf-8?B?T1liOE9JZzkzTmgvY3UvN2JCNk9FbmRQYnF3YUFramgzYmprYU5iWlljQWdN?=
 =?utf-8?B?NVlwL0phSHNDMWlJNkdhUU56NEgwMDg1UFB5R2czSTZCUHpDdGM3Uy83MHRk?=
 =?utf-8?B?cGg1ZzVySmRPTkVidDhUS1FEd21WZ1FKVU1sNkUyRzQ5aFdmcEhxaWFvMUZh?=
 =?utf-8?B?VGpMRUI4aGxPUFRkNmRWeWRJM1ppNnhBOENlZ3AzZWF1ZW9SQkJ3VHp4Q2sx?=
 =?utf-8?B?SFZSQ096dWl4VUlCcFNpRmhaWi84RlJoeHFCL2lweXRuNUJtTEVmcWc5TVFh?=
 =?utf-8?Q?OGRDGwiDVLFWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhTb2ZyTGdrbitWMlFFMEI2QVpNY1d0UVNlNGFpSlJZR01VZkJ0dzhoOVpE?=
 =?utf-8?B?U01obFFGVFlPSnBIVjRFZzg4SFZvMmhNS0pXTjBXdldBQkdMQUt3bkNwdnA4?=
 =?utf-8?B?UGJOVCtNSm1SWTN2R3NFUjVDRE9SeS9xOVZ2K2hpSHhmL09RM1RVYWJmNTVM?=
 =?utf-8?B?T2NqN1RySE9DMTJUQ0lZNjFoc1lPRTlCR2MvNG44dHd2OGVYbXpVa1Z1WUl2?=
 =?utf-8?B?S21Oc1FOVE5OcXdtM1lpOXI0Y2dqSEJmc2tQYnZ0Skc4SGloQy90M2xnMVBK?=
 =?utf-8?B?U0NQb0tiMW9qL1BSZmtIWFNLUTRldjRUbnpKdTh5ZVFYQjBYVGNYL0NlQnNN?=
 =?utf-8?B?Q2xIQnlzMkpReHY2Y2lmZitLN1hOeVdvNnA0Um5lRWttd3Eya0pyZjhmWW8z?=
 =?utf-8?B?ak1XdCt6NERSdFl6WGlxbXh4WUo3cG4xSm40Mk4xb2N2a0YxakU5RHVoRTFz?=
 =?utf-8?B?VTRTQjI2R0MvYnQ4eVRzcHNlMFFTTFA1b0JiRTJsY3hrVkxaWEVGbUVyRWZ5?=
 =?utf-8?B?cFh6WHpwSjNIRlU2WklPQ2VpajFnMlZpOWRYWTd6bFd4amludjBUYVZIMXJF?=
 =?utf-8?B?NFQ0a3Z3K3dYWTBpclQzd1BSYjIyWkFRZ0N2bnpIdDlUM05zWGFEelJRVjJN?=
 =?utf-8?B?MHE3cTY3aHRxMXhuUzMrUDZaS3hrVExoWlUwcEozNDJFSlFGQjFvNWZLMEdY?=
 =?utf-8?B?bXhyWmVzdVNPbGg1S3lHK2NyUG5UeVNEUmhiQXl2a1ZvalZ3TDJwbjVQM0c0?=
 =?utf-8?B?b1FNZi9lYVBYYVJEc3B1VXBzVnlVSGo2S1JVVEhaUzZ4eVRkSDNFYlFPOElO?=
 =?utf-8?B?b0VEL1ZMRHR6bHM0Q0RIa1B4aDVMQzVYMU5kQ3hvV29qazlrcTA2b21Ubk13?=
 =?utf-8?B?M3hMTkdGRGJHR0lwRTdpYmdUNUJxSithWTA0aHp1ZkVST0xMMWE0UmhIMDlT?=
 =?utf-8?B?c3ppZGxCa2pVMDNuS3BXQVRRTXd2OVFGMjh0THpKSnVYNkpGSDJsTGtUWmlC?=
 =?utf-8?B?b2o3Zm1MM1JOSUtRN01kQmtycnM3STErZUR5S3Z6QUpwc2RiR0RiWXVNMDFI?=
 =?utf-8?B?eXNRVnBiai9yQVNUcC90bkduOUc3NWcwODRldkxid2xpN1dDSWdlZnV2QitL?=
 =?utf-8?B?Y0x0ZFYycDNFL3QzN2NOVTJGSFVPMzVuSysrOGN5eitMeERjY2N3ZUJoVFQ3?=
 =?utf-8?B?SFlCeEIvR29FSUhGUEpKWWR6dWQ3QzNQWm4xVHNNMjFmelBLdXdqZDRrakh4?=
 =?utf-8?B?MU9mUlR6ZE5rK0xWYmJzbXJuOVN2OW9qOHZvdXVhWmlocUpvWTFhY2JQNU5N?=
 =?utf-8?B?ZVZjWm5YTy9ocUNRL1ZvaVUwTkhHaGh0MDZ6ZFQ2NUdxWll0OFBWL01qRE4x?=
 =?utf-8?B?UHJUR0xObUMzNzNaMUxpVnVsc0JNaEpBYzJyZEpDcmpwVFM4am5qZHZGQlRO?=
 =?utf-8?B?a21xc2t6alRqbmR0V3lNSFJ1MWJzNUdWYzI4b0pSMitKVVc0SDNHZlZHdG9z?=
 =?utf-8?B?OW9Pd2xpR3p1NVpEeUZydHFQZzkvL0VBZ3RzREhPR3lzNktsRExYV0ZDNWJx?=
 =?utf-8?B?elVUMk9LYkFEV0s1akI5K3BFeEdFcmxrcDY4ZzM0MzJHUVRuc0hpL0xIdmhF?=
 =?utf-8?B?cU1GOVRBRzUvMldWK1oxUDRSVVZDaG1ScXZVbzNHUmMreGNJaUx2dFFDSi9X?=
 =?utf-8?B?RkhBMEliWWxVdHllZXQyMkk5U1Q1ZXJJNXgvR3R0V2ZocU9XWWRxMnJVNVRY?=
 =?utf-8?B?dlZrcElTc01MQ1dPUDQ3Vk5XbkNUdG9SMlZrMjFXYVZwb2k2VUdVM2R1VzE1?=
 =?utf-8?B?ZHlndTI5azl2dmZxa2pxdjNGZ1Q4aFVUTHFPeE5yUzJEeU50a3lKRFNpWGpx?=
 =?utf-8?B?aFhLekhhaWQweHJXNTRsMElxMHVrTVpJNzBHOU1hQUNlVTZoMjd3OVdIYzVk?=
 =?utf-8?B?ZFhHc29ObFlueXBOUytjNkJtaWZTUjR6aDFpVGoyajFBQXYvbzRHc2JMNUtD?=
 =?utf-8?B?Rlc4ek9UY0xndUVsUHFWZGZEeEF4OUp5VVowalpTQ3l2MFFJRnI1ZkRRWXkx?=
 =?utf-8?B?OTdITm1hRXNaNzFlSXVsL3NobThiaFcrZEZYYit2cEtaSk5UVUFqUkh1WVNa?=
 =?utf-8?B?bWNFWHpxeEVLZXFOYlhXTjhSVHVQNEVKVHJsMm9HSUZqZFQvSDdRSmhOZlJM?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66212b2f-838a-4c31-13e1-08dd5cd0a1a8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:02:09.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPEnkiZP85XMHPxFnj2UWupqZhSjNGu+5UNyUp3F05mRhbYSnD4XdSi4Skril8Fuq6agBB1KcF3yMA2ABruTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789



On 3/6/2025 4:35 AM, Juri Lelli wrote:
> Hi Joel,
> 
> On 05/03/25 20:10, Joel Fernandes wrote:
>> Currently, RCU boost testing in rcutorture is broken because it relies on
>> having RT throttling disabled. This means the test will always pass (or
>> rarely fail). This occurs because recently, RT throttling was replaced
>> by DL server which boosts CFS tasks even when rcutorture tried to
>> disable throttling (see rcu_torture_disable_rt_throttle()). However, the
>> systctl_sched_rt_runtime variable is not considered thus still allowing
>> RT tasks to be preempted by CFS tasks.
>>
>> Therefore this patch prevents DL server from starting when RCU torture
>> sets the sysctl_sched_rt_runtime to -1.
>>
>> With this patch, boosting in TREE09 fails reliably if RCU_BOOST=n.
>>
>> Steven also mentioned that this could fix RT usecases where users do not
>> want DL server to be interfering.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Fixes: cea5a3472ac4 ("sched/fair: Cleanup fair_server")
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>> v1->v2:
>> 	Updated Fixes tag (Steven)
>> 	Moved the stoppage of DL server to fair (Juri)
> 
> I think what I suggested/wondered (sorry if I wasn't clear) is that we
> might need a link between sched_rt_runtime and the fair_server per-cpu
> runtime under sched/debug (i.e., sched_fair_write(), etc), otherwise one
> can end up with DL server disabled and still non zero runtime on the
> debug interface. This is only if we want to make that link, though;
> which I am not entirely sure it is something we want to do, as we will
> be stuck with an old/legacy interface if we do. Peter?
> 
This is true. I was thinking more from a FAIR PoV. rt_bandwidth_enabled() is a
generic function that's also called from the DL code. So I didn't per-se look at
it like an DL server interface thing.

But you also do have a point and curious to hear what Peter has to say.

thanks,

 - Joel


