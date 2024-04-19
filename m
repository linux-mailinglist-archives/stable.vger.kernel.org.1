Return-Path: <stable+bounces-40229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B28AA679
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 03:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D883A1C21139
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442310E3;
	Fri, 19 Apr 2024 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8+iJEe1"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E665F;
	Fri, 19 Apr 2024 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489478; cv=fail; b=lh6Nl4ODOtvCektt6fI0gNfxYd5G7lWbzx1IX8/A3J6V5mmGngty+ZtQ7f3FabjNAS2w6tLqUl/nsSq86/5475ZezwRqd8P8lCk/b8MjQkpBokjHa483Wu5AeWKSxy4HgL3ssqLJ04/2E4K8DTBvqplG+ay34AV1jCH9HG//YKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489478; c=relaxed/simple;
	bh=q7axH4c4s2UH7QepCkZuLb+yoSmmHF8NhxmJw505bgo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pTEqWqyqouHz22V2RM9E0iFJajLeIBguF5zDsXASHxG23hzgnisgaBVmE0cn1ERzfle/dvY/tldBJfe3FJIU7T9zM3vlzWURrplBjdGuMnbX9G4sUZN/sh5bTt9kildjUMGidgPQ8ss6Ypqaf0NBk7Oz7yLOnquyf9zHUJp61wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O8+iJEe1; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzjHgm/bDVy/GuPDTek3wTLOK+Qw9W7CLp8G0NdDuivIswoyvC1zzA2NnPgUpne6J6zn/y9RBkSujcQUaCeQAsKbsuMTiW3EY80shSN65YA0QdJ2UfFvVwcBz7zDx81B2h2Ckymlg9SlWM/1f5FSd0ZHwzb0aoE0WqR7pSlCVgC6mcGNx9yfgUGsATsS2pBExa1eZ/bmlbLhGKwFQZMHYr+xFOxSiBuY5gQOJXgBpY1cNSxZ3rsxcIJRa+k2jkhdSKuZnE9a02whYt3lwBhvexUxjbzrEE+hCZPmuO3GEUNO3GXDeg1xLLqKH1Cy3/oRUO9qH1TrSymHIb9mqtHkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7vz5cTvvbYDbhMDWjNpseEU7LYS8QqfZHzHqd7wMH0=;
 b=W8iM34CfxALIi0KO/pPU5odTaamOF2FpKqaHruIJM6Sf+Y1UbJ2ql6Sz1iEBPjcuqlaPs6Mo37R+XV3H21xz9SEBgThKUbrlxLneyd5QUHc5K6apF1lS+bqPU8HZWzZSmEMGZX7fH5kDxIl9V2HLM5SU1Z4JzOCccXaHCDksn14Z4Sz0pSeGZebNkJYVXQEmZMop12WBDUjJF58AN7CEhrZc4zbZVUy9LR9vvEijv1PuFV2NUEvW5bttjyJMUwhuUzGCt5IDImX9mJfbpd+FccK0rlvERrjmhsVA5nqzGPPzENbpgrTamG0nJ6iGa4fcWg60fn/s1mj1GoqVj5Ktkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7vz5cTvvbYDbhMDWjNpseEU7LYS8QqfZHzHqd7wMH0=;
 b=O8+iJEe1OnigwDYmUr8BT39eYwDht/AZopJRKDmRZXKYO/k7Tpqi3X8n3Mio3hz4xisvACExkNRiwacOPQ5PI7V2x6sV9EqRE6F/piyGVNUXaKhgapAV+HSn0BsrxbqPe3JVSVReYU68iCiUKaVKO0kvj+8XDUK48jUcnzySwZxC/AwtXesjA6vDw1NdGw8MwfCR1uTRGsxhgzpEu4CG+qZ19lh5dQK3KflWpQaaRqOLJZdpShKql7uvwUGDiswxIEbjPReRTBCKJNlZdjTKf/4wgjb71P3KBq41XfXFZaPD428MhOVI/+C8OyoGRuqvxz+8+ZEfGKTp7C80Aej4ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 01:17:52 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 01:17:52 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net-next 0/3] Resolve security issue in MACsec offload Rx datapath
Date: Thu, 18 Apr 2024 18:17:14 -0700
Message-ID: <20240419011740.333714-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 01dce619-25dc-4e06-268d-08dc600e891b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGo0TDUrNzRVUks0ZnNQTjd2NVc2Vy94OUtSUkdHOUlMeE11a2lLaFNSQmtn?=
 =?utf-8?B?TkJ6MnJYYVJ1ODRhWWdGVEpQUFQ5VWxQK1ZZV0U0TnBtaUQwK1Z6aWdjU01Y?=
 =?utf-8?B?N0xjTHMrQmhGVlcxTytTV0JHQkpPVUNOSDZ0TVpQa2pYVlcvWkhMcjJxM1Rw?=
 =?utf-8?B?YXVPT2h4eFNRUWdwenNnK1REYTNxWWY3dmtEbUxmUkN1Y0FSd3hpei8zY00y?=
 =?utf-8?B?eFJkS1lMdk9FeEwrS2Y2NFl3RVh6WHpYaXZkSmZNTXU4dHdMMlJ2THlVQVdH?=
 =?utf-8?B?WVlDOVYvWlM5NWJ1MzAyZmZLVDRGc056WU9WNm1CTWZuSTR2OE5lVUQwYVdZ?=
 =?utf-8?B?MGowWmZpOUt5c2U4S0JyYkxzOUFMb2xYRE9EN041T25JbVE1Y1ZXWkdKSGRC?=
 =?utf-8?B?RkVmMzlncVE3V2RIOUJSNTBacWtMMGptWm9EcjRFTjNyejVOTGJQY215UTM3?=
 =?utf-8?B?WUd3QWFUSzVwMjM2Tk51Z3pGQ0RteEt0RUdDZFh4ZWFUMEFLKzdjenRBRERh?=
 =?utf-8?B?WDdvOTREalJ4SktDak0yL0VCZmNPc2VXZjN4eXl6WkllNU9tYjhkaG5iYlhx?=
 =?utf-8?B?bTc4TytQbGJLcUtNY25JS0d5RUY2LytMK3ZsWDlVb0ZRVytsbjVRdFJ4V1FV?=
 =?utf-8?B?M3g3OTU4S2ZNYkFTMUFQL0xwQ0YrcHFQNDZLUHdkTUUvMnZZWmZKcUtaN3BJ?=
 =?utf-8?B?dHZIY2FKMnlLQzFtTzdhK3hHMklNSVdCTDNUY2VxeUMrMVRyZHBIeHlYcXpY?=
 =?utf-8?B?b25RSzBiQlp5VWNDM1k0NnlINUV5cWFheHRHM1JTYXB2MEl3VUpqY2NKZzZm?=
 =?utf-8?B?ZFcybU9nU2tmRmdIeG5JODlQMkxsZU94TFZHcUJ4RzNZbkJhVFV2MGdDVSsz?=
 =?utf-8?B?bDFnaUFqWUdmOHh5Vk9uVFlrRnVqZEQ0QjU3QnBjRzlRUkx5UUdCNnI4b0Ji?=
 =?utf-8?B?cStWZFpsUTFnRTZyRUNIUG1iWW9OOE5aNUh2a1JsVy9lUDVjLzNRazBaNjdo?=
 =?utf-8?B?Z0VSaERZaEpnQnM0Y2JMUWl6ZWU4cm1vMXdqaCt4ejcrUmpDc0NuS25IWFNT?=
 =?utf-8?B?c0VOdUQ3d3NwT2dEUm00RmZBR1VlYjBuTGRKM3BuYmZtY1phd2tVQlRWdnBW?=
 =?utf-8?B?aStMeXQvcWpFODU0V0QvK202NWZPdzFJeDZKYlN3azYzRk5PTzlGaXhXUzJi?=
 =?utf-8?B?b0FzVUMybiszMEpUbXVERC9aWFE4RkI2bDNCMkJNOHNvZzBGR29sSlQ5REQz?=
 =?utf-8?B?RS9QRi9lMHJCRk05bWRxVys1QkFpV3NaWG1wL0lqVVNyZENGN2F0TFdUWEEx?=
 =?utf-8?B?T0NKNElvQ21WS01aRWNHd3J6MzJuSmZTVVZNN1I0aDN3a05HUlV0dGJZKzls?=
 =?utf-8?B?SytrK1lMVndKTHdQRGRzQUN4Y29zaEx1OGhLVjFOV2U4VE1HaC9Qa2xJS0RP?=
 =?utf-8?B?dDVhVXJnMlNJcDZvY1N5VzZQMHdQQW5IbUxXeU5YQzhJZGVnSzVGeDhJYldL?=
 =?utf-8?B?c1RTUWhiMVhGTUdBVXNZRUJsbXA2N2haQnQwTkpndEtqeUFwQUJ2eDBUVURi?=
 =?utf-8?B?K0oxRG80STBRdVFrSlU1VzVTYXlyMDNJelUyMzVhQkhqYTNyYnB2a3ViMFpB?=
 =?utf-8?B?dlhLajNYYzNnWHRBT3poSEZKaEJkQVh6eXBrbllpODNVQ09YQk90T3l3V1FF?=
 =?utf-8?B?VmNhMjlnNmMxUXgzQjRmVUhtSDI3T1JyUUJYdU41UmJoQmg0ajZmWEhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjk1TEhKSjdTa2J1Y1lZUUpadkhKd1FEaDJPUUtvdGVZblduZHp1c2Z0czE0?=
 =?utf-8?B?dkQrenJ1Y250OEZxLzdqZVA4dTZWaEJXVFdvY0JaNHhCWUEvcDRQa2Zyck5M?=
 =?utf-8?B?ZEMvYmI5ZVltazNkQ2x4WWV4VUFYeFM2MFg1d2QzVFlEWm5tYmJ2SDdUYXVK?=
 =?utf-8?B?eEJiS2NXRmQ5czEvRGRWNU81Q0NaYUQ5UVJoVnJyZzVNOEk0eFkyWU9icTR6?=
 =?utf-8?B?UFFEQVBXKys0RTRTMUo5SkIwbXVpcmVTbXRpcXBENWpPcHRwR3VtTDdHdG9n?=
 =?utf-8?B?ZHJyQlNCQlRKb1QwZFVZYnpma2hjWC9ZeTByL0UyS1hPdllqa3lvLzZlUGpD?=
 =?utf-8?B?dklvWFlxTGxTM0lVYlJNZ0hWemRkQ085WU9VUXBNMjBFbmNvTFRIYXNSamcv?=
 =?utf-8?B?Y2dFZE1LZVJZKzhJekM4azl5TndvdlBsb0xwODZOdTFPOFM5VXRNME9IV1Q2?=
 =?utf-8?B?MHowRFQwbXJzTzVzOWlhMTgzU25IOU5xTHY2M0hwbHZFWUZFeWljQjhueE1Y?=
 =?utf-8?B?YmpBZ3FCZG5KUkdqeHNIK3NzQjgzeFNRRllZQkxTYlRZU1g1Mkprc3RCVlE0?=
 =?utf-8?B?cFpzdk9LU2Vldjh1U3BYTjVncEQvUzBEYVRwekh0NUN0VlZrQjB5bEpHMFpG?=
 =?utf-8?B?bHh0QmV0cVN2MkFXMkcvZm5IR2N1NHo4Ylo3bXVraE5FYkVQL3ZmRFJHQ1lB?=
 =?utf-8?B?WU5sbjErUzdKUEFLc25LSitzSEZaeGRXQlB3L2ZWMis1QVc5eDdoNHUrWmtB?=
 =?utf-8?B?d3BBZnJCUzQ3RWN4cmZFZTZOdVhack1wK0hwVk02Tnp6Z29PNTRGanlydFEr?=
 =?utf-8?B?RCtSanBncHRtd0tTV2VuQUZ6S0g5TmFLNHQxbituWk53NmVJRFF3VTlhT3M4?=
 =?utf-8?B?TUFTeEY3SXNua1hGZGo1WEFzY2NwWUZKQVllMVhwSG4xU2I2dG5GbmlYQyts?=
 =?utf-8?B?RWlZVGdvN3VjV3UvVUhvR05pSG5iVVBnRml5UHRlczlwYTM2TW9odjhMazla?=
 =?utf-8?B?K0xOL29scng2MjU5d3lQRkMxeWsxMWdMT3MxMU1MVDNnYmZtUXU0a3RaMHdv?=
 =?utf-8?B?S2Vlc1EvR1picktCZ296ZElJdkNkcHhTUlpkeTB0dUVhbEp0djBsZG13SjA3?=
 =?utf-8?B?dklIUmIxaVhrUTRHQ25ab0FKUzBSS01XVXRLMHFpM1RHR1dadDRDb3VqR1NE?=
 =?utf-8?B?T1U4WEw4VmxnY2tVUmhFM0R2VDZWUWdEUlpvUjcvdjJ4T3NGOHdCRzFPTTVP?=
 =?utf-8?B?M21aTWJ5R1RxeTU5WDdNeGttN0VKUThoczkrMS96RUNUeS80S1RVVDJhWnkz?=
 =?utf-8?B?cmZSakVEVDVCSHI3WGJ5Qys1QllVUFZKNEpZTlhOUHloOWJDTHc5M1E5cG41?=
 =?utf-8?B?bmJkeHh4S210MVZGTnJkekl0Q284Zm9kS2h3M3NFaVNGQjhJSWdwaEhtM0Vo?=
 =?utf-8?B?WjBYUUxlRHNhYVd1U1MvUnA4SXVFbVVNcXZWUkg3MXZQeWZJamRVempXZThv?=
 =?utf-8?B?clo4NDE1dXp4anVVUVZrU09oaS9HYkpwbFVjTzFVVlJRWDlOdkhTU00zSlBH?=
 =?utf-8?B?Nk1WYmpuek9mbUVueTVZVjI5VjZUbXc3QjE0UFdYVE85Ymt4MnMySkNlT0Ev?=
 =?utf-8?B?WmUrL3dZU3d1cmg3MWxLRW9maC9TNldzUFFrME9nUzhIWGZrNW12WERRQ3ho?=
 =?utf-8?B?emcrRjdJT0cxd0V3b3lud2Vkcll2ZktranIxMTdwYmhwZ2RxQTZETitaYVBZ?=
 =?utf-8?B?UmxMOG42MnpEUmQ0cndjMm1YN2dGNnZTK2dnQlJVVTZ6bHVXbWozeUhzUGYv?=
 =?utf-8?B?bVJUWFlwUFBpYy9KT0Q2OXNFdWpJUGJSRjRWc21hekRoZjNWYXhiRXNVN25o?=
 =?utf-8?B?alVYSmtxcVNEWVlLZXNwZUxMMHRrNjJwVW5PSTRZakRvM0dVWEdFQlRFb3dj?=
 =?utf-8?B?Wk9EeXkzSkNiRDJhSXlocXdCWGQ2THVFL1Z2aGpSUmdsNHRxb0ExZFFKU2l5?=
 =?utf-8?B?K2dYZWNZbzJyVkFwVnB4bGpmL3I0cEk0UkxHRzd4djZERjdxVmFQaVpPajFV?=
 =?utf-8?B?UTVxZHY0dFJycEdhbUNDSmxnaXI1Ums5TFBpU3c0M0laTVlsNENzV3FGYkQ3?=
 =?utf-8?B?ZEFHRUlkckpQZlBGRzhzSDRBelRGc1JBSytqcEcydi9YL21YcWl4dmFXd1Jj?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dce619-25dc-4e06-268d-08dc600e891b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:17:52.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azcYazsvOdDneC2eLYg8aufInBTHvqw2I5yQxSyxXyw9a48fc9Qp3Gd4sI2nyqz+y+Aev1AbC0e7FKI9kBOk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

Some device drivers support devices that enable them to annotate whether a
Rx skb refers to a packet that was processed by the MACsec offloading
functionality of the device. Logic in the Rx handling for MACsec offload
does not utilize this information to preemptively avoid forwarding to the
macsec netdev currently. Because of this, things like multicast messages
such as ARP requests are forwarded to the macsec netdev whether the message
received was MACsec encrypted or not. The goal of this patch series is to
improve the Rx handling for MACsec offload for devices capable of
annotating skbs received that were decrypted by the NIC offload for MACsec.

Here is a summary of the issue that occurs with the existing logic today.

    * The current design of the MACsec offload handling path tries to use
      "best guess" mechanisms for determining whether a packet associated
      with the currently handled skb in the datapath was processed via HW
      offload​
    * The best guess mechanism uses the following heuristic logic (in order of
      precedence)
      - Check if header destination MAC address matches MACsec netdev MAC
        address -> forward to MACsec port
      - Check if packet is multicast traffic -> forward to MACsec port​
      - MACsec security channel was able to be looked up from skb offload
        context (mlx5 only) -> forward to MACsec port​
    * Problem: plaintext traffic can potentially solicit a MACsec encrypted
      response from the offload device
      - Core aspect of MACsec is that it identifies unauthorized LAN connections
        and excludes them from communication
        + This behavior can be seen when not enabling offload for MACsec​
      - The offload behavior violates this principle in MACsec

I believe this behavior is a security bug since applications utilizing
MACsec could be exploited using this behavior, and the correct way to
resolve this is by having the hardware correctly indicate whether MACsec
offload occurred for the packet or not. In the patches in this series, I
leave a warning for when the problematic path occurs because I cannot
figure out a secure way to fix the security issue that applies to the core
MACsec offload handling in the Rx path without breaking MACsec offload for
other vendors.

Shown at the bottom is an example use case where plaintext traffic sent to
a physical port of a NIC configured for MACsec offload is unable to be
handled correctly by the software stack when the NIC provides awareness to
the kernel about whether the received packet is MACsec traffic or not. In
this specific example, plaintext ARP requests are being responded with
MACsec encrypted ARP replies (which leads to routing information being
unable to be built for the requester).

    Side 1

      ip link del macsec0
      ip address flush mlx5_1
      ip address add 1.1.1.1/24 dev mlx5_1
      ip link set dev mlx5_1 up
      ip link add link mlx5_1 macsec0 type macsec sci 1 encrypt on
      ip link set dev macsec0 address 00:11:22:33:44:66
      ip macsec offload macsec0 mac
      ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
      ip macsec add macsec0 rx sci 2 on
      ip macsec add macsec0 rx sci 2 sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
      ip address flush macsec0
      ip address add 2.2.2.1/24 dev macsec0
      ip link set dev macsec0 up
      ip link add link macsec0 name macsec_vlan type vlan id 1
      ip link set dev macsec_vlan address 00:11:22:33:44:88
      ip address flush macsec_vlan
      ip address add 3.3.3.1/24 dev macsec_vlan
      ip link set dev macsec_vlan up

    Side 2

      ip link del macsec0
      ip address flush mlx5_1
      ip address add 1.1.1.2/24 dev mlx5_1
      ip link set dev mlx5_1 up
      ip link add link mlx5_1 macsec0 type macsec sci 2 encrypt on
      ip link set dev macsec0 address 00:11:22:33:44:77
      ip macsec offload macsec0 mac
      ip macsec add macsec0 tx sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
      ip macsec add macsec0 rx sci 1 on
      ip macsec add macsec0 rx sci 1 sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
      ip address flush macsec0
      ip address add 2.2.2.2/24 dev macsec0
      ip link set dev macsec0 up
      ip link add link macsec0 name macsec_vlan type vlan id 1
      ip link set dev macsec_vlan address 00:11:22:33:44:99
      ip address flush macsec_vlan
      ip address add 3.3.3.2/24 dev macsec_vlan
      ip link set dev macsec_vlan up

    Side 1

      ping -I mlx5_1 1.1.1.2
      PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
      From 1.1.1.1 icmp_seq=1 Destination Host Unreachable
      ping: sendmsg: No route to host
      From 1.1.1.1 icmp_seq=2 Destination Host Unreachable
      From 1.1.1.1 icmp_seq=3 Destination Host Unreachable

Link: https://github.com/Binary-Eater/macsec-rx-offload/blob/trunk/MACsec_violation_in_core_stack_offload_rx_handling.pdf
Link: https://lore.kernel.org/netdev/87r0l25y1c.fsf@nvidia.com/
Link: https://lore.kernel.org/netdev/20231116182900.46052-1-rrameshbabu@nvidia.com/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
Rahul Rameshbabu (3):
  macsec: Enable devices to advertise whether they update sk_buff md_dst
    during offloads
  macsec: Detect if Rx skb is macsec-related for offloading devices that
    update md_dst
  net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for
    MACsec

 .../mellanox/mlx5/core/en_accel/macsec.c      |  1 +
 drivers/net/macsec.c                          | 57 ++++++++++++++++---
 include/net/macsec.h                          |  2 +
 3 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.42.0


