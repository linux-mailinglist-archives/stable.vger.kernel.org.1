Return-Path: <stable+bounces-195476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E7FC77D3D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F9334E8683
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EE339B4E;
	Fri, 21 Nov 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ktba0Loo"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749792F8BCD;
	Fri, 21 Nov 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712806; cv=fail; b=n9tedZoxEUxjZiLzS3yB+xdMu9jJzL9d3XBsZBNy0Xc5Cs4ZWzyY1JWgnD01eVUP6oVuv8NdAsnQ4FWLAijnXSKy35EJqCKih69eyiAL3Vocai3k2sJWxp8dcr0qVacl2cqE6PQs/92TjtM1Nyb6FHyWvx0Iu9uopO6ysGEeWmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712806; c=relaxed/simple;
	bh=Q8tEyErh493lGsiohYX4tuS0861qRme07Cy6A2JgzOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=alczHrJEysU7Jmvb5grjPilzFr5WSv+eE787e3dkTHkGykKylck8tSfpjUSkT5vaKZjWZ/+wsOEyA0j4nF/PJTSk+JHqtaUP6ZF019jGioEIDuB7by4BchsFpD6UlsA9+X5TZPPJFrgYQ0gwZij+TixiA/Rw4HMcGEdIZH1yGKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ktba0Loo; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcXhdqkW6g3tTdXHhVg1vR7cK1FmFiHW4p5fIi4aMp4Z+3psREC3ZNO6QyoNwqTMO2Zsw0VDa1unnyWndYlmCLPgGUlETr0mu7rjnbupw+rAH3dF58cSq+ZKbCM3DiLheWB2FhCkVzX/CP9iXes+GYxSvH89LfJgssHFWz1V1WBU7XYpzefnAqs/8kIkZvKo0PQayddgTx9/lZRNbm3xfTRDBhwYyWlOno5cct6IfjN4V/RE3FSXfPACRgUmOBF3haSR4kBqcO3NTHfH4Q0os7oly1K/wPhnRlLmoQ4W0guMv04zWysQLwpwLcokwd2wy2+LF1Rtal0XszPAVljyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaD+uAahzp1VMIzCBnn4nEA3bB7AAyLw9TUuM9YZxO8=;
 b=cUIUpA+NoYuElgXOAXuvIvdhxDfF/U0bxwLYOna+kxUj1OMxNeMHsV9ekAWLtx49d252SmYr6S6EOEibpeG/zd4LoTtz611CWEG1IlB7vA/T2yN93mxdGRvdittDGi44ltdamT/8MQ8mAI9MBRjqJjCUX0tS9hdMTYCdwHIF4OkfJjlMElMl5q4W9gdnsvdDUzWHhl4coMGWIEIDEiOUHqZWIiv4eyok22DDd2wGdhej14QE/DqMUDpIQIp+/MEzOYhTbjuh3Rv8PaNzhcr2hMqfd+tV4nZfnDGF9MZ+cbL/KUqy/rbv9Da2NlMRl+9+BAeY+gB4xAa8ExmkgkH/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaD+uAahzp1VMIzCBnn4nEA3bB7AAyLw9TUuM9YZxO8=;
 b=ktba0LooaI/Xn1aqeRp00wy+ZmPJQavmNK3NyC7wGOPRjkP9+7CNUsd4DUECGOpwI000kIXFGCQa6x/FpmNuylgkJDgKngeKtB2T5+vyvM9ZrA9mGS1ROzQ83PAgcFKw4tnWrQo9XXvTZF+GSJDRi53RslK7t0VLy94pvnBv59g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.12; Fri, 21 Nov 2025 08:13:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 08:13:18 +0000
Message-ID: <f9d5b6d5-4850-4c61-b691-3a9ce9b4eb22@amd.com>
Date: Fri, 21 Nov 2025 13:43:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Propagate the error code returned by
 __modify_irte_ga() in modify_irte_ga()
To: Jinhui Guo <guojinhui.liam@bytedance.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251120154725.435-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251120154725.435-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 16991581-74c0-4139-e8f2-08de28d5d388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0dtK1pGYTQ5OWpMUG1RUVFHb3E2ZGJNNzdoRUdLUks4d3ZYaXFTczUrSWhu?=
 =?utf-8?B?SkR4bmIreWtjZUMxSDM5cGk5bXFWMDlUbkRxWDZKMnVHcG1ubEJ3am40MlV2?=
 =?utf-8?B?SDUyVHFlSjVmM096dk1yMUM2WGtScGJPWjlyQ1pnSUFrdm9wU0JORGhVQTBq?=
 =?utf-8?B?UGV2Q3FRbXFjd3dINWcrcWtzb3dWdVdkS1pWQ0x3MEhBandFQ2hIdWtsNVZ5?=
 =?utf-8?B?aGV1c1F3V0dMakZMNjIxNUY0ZUJRQ1FJUldNdkVFKzhyYkV2dzJSQzJoZ1h0?=
 =?utf-8?B?MTBmb3lSMi94Nk5tYVF3eWI1NDA0UkRYcDBaNHhSdElybTVycGhFcUhPQWc5?=
 =?utf-8?B?TVNScnFGY0RCdmRXUGlvTkdMZjlqNmZDUlBGNUp1SXpHeWpaWFp4V0tQSHYz?=
 =?utf-8?B?Rm9kTkkxcThwdmwxOGtBRHJ4MUE0NkI3dk53UjlNWXhFaXk1WXJ5SDdSNjlW?=
 =?utf-8?B?QiszY2ZDdldKWVc4MW5VZVlkYUpGRnlHQS95K0NiejUwWVpIY091MEI1eG5t?=
 =?utf-8?B?cytQZkRqdEpJcHJVK2ZPbWVPMHpDalRyZ0I5emR0eUIycVFhODVTTCs1c3Fx?=
 =?utf-8?B?Z1FqbWZvU2xNd1duWmhRTFJmWGJRR2tDRS96WCs4cU5EdDFaeUNNS1ZyVVJi?=
 =?utf-8?B?aUlUVzFlZWJUUWoxbXBlZVNrSmFrTU9obldMcWxuV1B5YUdMM3J1dmVRZGVB?=
 =?utf-8?B?dGpJMGk3MjFSdTNZaGhua1FQRzBiNVNXYXYwS0srbW1EQjZyNXNBditZWk9W?=
 =?utf-8?B?UXM2VCtabnpHNkxSVi91SENDZ3Y1WWgwU3NxMVc0clpPbVFWL1BZZTFXNEJD?=
 =?utf-8?B?Nk5hR2R0RVBqVGFaUXdXRGhoRHVOa2htUDBNRzZtRnE3V0s0SE9zMSt6QUdx?=
 =?utf-8?B?YTVIRW42YVhzbzJPTy8yMlZuRkdaSU1iSVBWQWJuQWNPMG9hV0tuV3lWTHJF?=
 =?utf-8?B?RWZ6NVNvTGlTZUs4ODBPbkNZbUp0bCsraXNtNVk1S1VVTXZzNlA1TXpRcGlu?=
 =?utf-8?B?TFhIak9NQkM5MHg1RE5OeUp0RmlCRTdJZjdNK3d5dDN5cTREV091bGtudm92?=
 =?utf-8?B?Smc0YWl5YjlJaXR2VjdLYldhYTNRbjAycDllUHVTY3BIL1cxdHpWSWtxM2NJ?=
 =?utf-8?B?UDd5WXVhM0NRajIzWjFGaEpqNy96c3EzMUZIRmRGNWhMaitXMkpvS2NwOSsw?=
 =?utf-8?B?NElJRTh4SmtXeUFaeUpNTG16UjhNVDFFZ2tBcUFLUGVKT2ZTMXNreVBGMlBs?=
 =?utf-8?B?OGpqMDJmZzVBRlJlMzN2OTFvdmhSWTh6VVBhSEhYNUZQQU5zdDF3ei9IREdK?=
 =?utf-8?B?OFZhaUVhZ3J4VW1GTE5pVW10Z0VFTjR0eHJ1TzlZbnJrWThiQlR0M2t3b3M3?=
 =?utf-8?B?QkdpNTlmN2ZLWGR2WVk4dDd1aXFGVTZkUHM5SU0vZVNEY3NhSGtYeWYrMC9H?=
 =?utf-8?B?WVU4Wmh6aDhnb2FBK3BTdFVQczhtclpCdGtKZGt6R1hSRHRubnVmU2NDNlRM?=
 =?utf-8?B?V21lUTJWQzFjZVZ2dGxaKzZRUnlTaFFzMlFVaUJDOHZ3QjI3YS81VTJTbW53?=
 =?utf-8?B?WHNsTTdpbVZTeXY5NkZ3aFpHRVkvQUVYejRJWmtuWjJWQ081dzRac2ozNy82?=
 =?utf-8?B?NzM3Zk9tU2xJR1VxT0xWMTBTeWgyN3E3VDJsNHhVS0Zza2ozUTBNT1RJOGpK?=
 =?utf-8?B?MXBuNkJpNndURmh2dlR2eTRkVzg3dWMxbTRYNUVEVDM4MmcrQ05EOVB0TTVs?=
 =?utf-8?B?UUxqQ21JbnZPUzVTaG4yWnJGK0tRajhsbHpGQWRvMjNBWU0yM0ZSS2gra2Mw?=
 =?utf-8?B?U3NkK0dNQndEcFMvZTZZY244L3VaRzhHZ0F5MWFzVUp0cGlVSEdhTW8xZmJj?=
 =?utf-8?B?NGliUHpDQzJLZzZvam1NeWtIVnUyMVl5cDM5aWVZenRKdjZwWnhZVU45TVo2?=
 =?utf-8?Q?kIPIkjRsJ8YwJTLNPrPf9PmDyTZFX0F3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjI0K3lIaWZ3Y1F5aXFselU2NWF4eTlwTWZobEFPRFVaWGRNenYxZnFoTzlm?=
 =?utf-8?B?bE5BUVRSc0x0b3hMTE10d0hnQTBPcmszOUVWdmZta3Z0bDgwTmJ1WmV0cjhP?=
 =?utf-8?B?UWowNWRiTnZ2cURkMWJrVXp5R1NJYWhXVCtmeG95emNMUnZNc21PQmxXNWdE?=
 =?utf-8?B?NDNXdkJweHRhcWl5S0lzWWtnWjFNajFaeWcyQ1owRkVnUFhJOEdPdm1DZk02?=
 =?utf-8?B?SDhQbWM0eVpYUHl5TG5iODRDa21LU0NrS2dPcUFhZXVZTnJHV0NoaXVRZVJh?=
 =?utf-8?B?RVBJVFV4M0grRUNtbngvRVh1WWNKN2V6Q1J6R0FkOVZUdlZ0QVFnN3pCSmpP?=
 =?utf-8?B?cVl5NEhkZnllVUhvMUZpQURaTHJ5VWJsWHNRUmdqMVBCNHdZeGZJRGtnWDI3?=
 =?utf-8?B?Nnp0cEpwazlST2ZCSk5UZnBzdVhYb083Z1ZjVkdKNGxWU1k1aGpNZUVMNysx?=
 =?utf-8?B?TEJITjY1Ni9qOTJOVm4wQldncG01RWhpZFpBdkprTW9IRWdoMDFSbFFLbTFO?=
 =?utf-8?B?UDF5ckl5R281aUNUazk2QWwxaGV6dWZkU3RlYThhTDM2eU44L0hFMTZsbXZ6?=
 =?utf-8?B?R0licHJHQ3d2K0cxMkZES1FaV1JkM3VhYXVHbEVXamY3QmhNNW1qcEFqTWcr?=
 =?utf-8?B?ZzBqZlV5NENTZXExNW0rcU92SHByOTdGeE5Kd0FOWTdTUm1lM2Q1RXExbTJO?=
 =?utf-8?B?RDlmQnpXbEkyYVF3UWFlTUpiNE9rSkZ6TXVXelVxTC9VSC9MeGhCczdnSER3?=
 =?utf-8?B?bkgxVGxFQndZM2FRM3kzSGxFYUp4bUdyOXdQU0hoQWtLd2ExNmFqMDZ3aXkz?=
 =?utf-8?B?NmJIbGtFanRMbTAyUzBSU081QlE1K2pyYXBSd2FlOWUwM285SkxHY0Z2RWZy?=
 =?utf-8?B?TXd2OFVvUi9sUGdIaVFKU3J6RWZ4bGZsaGh4ZTJkSjhhNC9PVVdrU0VBTkR1?=
 =?utf-8?B?YjRJb2tRQWFaRWNYUSttdi9DS3hmaGw1TWxWcDVEOFhvSzdwa1QyaGg0cWQ0?=
 =?utf-8?B?NGVhNFFteFVpUTI2RlQ1L0VydVpmRmJiQmp3TmpaYzRIMUEvek5TQUJGcHJa?=
 =?utf-8?B?d09mTmM4Ynh3dm1yZUtubVU5MnYrOFdXa2tOdHhaeFZQRFl4enJSL0lnNXl3?=
 =?utf-8?B?WU5mZUYwaDY4cmFrU1NmL0JtSTdISlZYQVpaYzFZaklEZVFXUjJCS0RYQm54?=
 =?utf-8?B?dlFVc2hxNkJhbllua1hQWlEydlBiZ1llSU5hTlVTSUF4RXNpTUphaElpbXdz?=
 =?utf-8?B?bFcwVEpiT2dhS0tzV0YwVE5qVEorUjIwclo0ZEJDM1A4VCtVaC9EMjB4YW5B?=
 =?utf-8?B?T0hDQUdhWDQzNVEwSmR2cjI5ZGIycWFLTHM3U1luN29RQ3ZIY3VONzZXTW9F?=
 =?utf-8?B?ZGVSYlpxam1BVnBTenFoa2tFa2hEdU1yWWx4b0VkY0VvdG90R0FObWNBNm1L?=
 =?utf-8?B?UitUV0NXZm9wLzdBNFltekUzbmhaNC8rY1ZNcmxMU0JkNHc2RFlkSVZxMXhJ?=
 =?utf-8?B?SHVIUC90N0NkelRFSGpQbFh3RjZBQlJKUjNzVVE2Y21VeVlUWXBjSjg4Z3M0?=
 =?utf-8?B?ckxPR3M5OEVNcHNCVHBTMlo0UjNxRXY2QkN2MjZIOFBna2tDYmRJcnZkWmVP?=
 =?utf-8?B?emNSZDFMeU5TaUFuWXpqZmt3M2xvTjFROGIvTXpzV3doYklSdm5mZFdHdS8w?=
 =?utf-8?B?L0JldEZxQ2xXRS9GdXN4M011QnFHZjBQUmZ1ZUVGSzRhR3dXSDJLcHNTMElW?=
 =?utf-8?B?VW1FMmY1NHpEYWxkdm02ektyUlBsOHVrZERYR1lPczcwZ0dHWkpZR09ZYk8x?=
 =?utf-8?B?MzQzeVBNb2N6dkxsU1BSQnVSUzZiREgwSFJGUS9OUUkyOFFnL2NaUklVV2VR?=
 =?utf-8?B?Mlg5UTJXM1NlaXFaVkNUY3hiS3BwZGVCaS9YQ0pwWGNNK2dHOXVKZVg4dlJQ?=
 =?utf-8?B?RTRGTkxwb0ViOS9pcXYxT0g1UnlNOVlDSDl1WXRqT2VpQURud1RFRVIzcVoy?=
 =?utf-8?B?aGFrQzE4aks5WmJsQnB2NjhtV2Z6T2w4bkV3QjV2RWlIQTY2cWR6M0E3b0xk?=
 =?utf-8?B?RkRMMnFudlIwOUlYRDdjTTI5bjNydDNDYnpPNU5vS3lrK3hzeHNEams5cndk?=
 =?utf-8?Q?mYymk8oGWDfLXnd7pryzupbjz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16991581-74c0-4139-e8f2-08de28d5d388
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:13:17.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pya8FL78r9UCGJYdouw4TCrkAjQ5P+HE8ZpOwBZXTkNbrDwmDI8gKC2D3HTR79xMjQsA6wwgMFY597B9u9lL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

On 11/20/2025 9:17 PM, Jinhui Guo wrote:
> The return type of __modify_irte_ga() is int, but modify_irte_ga()
> treats it as a bool. Casting the int to bool discards the error code.
> 
> To fix the issue, change the type of ret to int in modify_irte_ga().
> 
> Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


