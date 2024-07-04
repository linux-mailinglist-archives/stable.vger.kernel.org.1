Return-Path: <stable+bounces-58096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E96927E46
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424D01C22520
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0461213C3D3;
	Thu,  4 Jul 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="ZsAhtEqS"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2132.outbound.protection.outlook.com [40.107.104.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4D15491;
	Thu,  4 Jul 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720124340; cv=fail; b=FMFUmWqzisguZrVrqw7YPWqgJg7FDbQVbSoDPkpTPZXLHQ2ElJEJBh8cLNRaWUtSr6QHDaYnKfaf6+pJLaxS4Hqy0//w0UsFi/MlT30hdlcrkmtjm/BgK9eZIIObCeClt/lU4L8HkiWnT4/eeQ8rZniOBnv2uajO5XUdpGreGYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720124340; c=relaxed/simple;
	bh=heb7B3d1PhiZ8ANBMG7IRWCV9k7c+NATVAJa/KD546c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uamqqOYjvKcDxkUp0J+htEx96MJ3zoZMFKy3HcgC91bmC13F4HyKzplaY3DeWpXI4xJFoUjwFGABXw701ZewWx0RmXjqm/wsCjb95y6ultsu3r01O22AdChhWkc9algKcyjN/rqbziS75mjJgyD+8JZ5pl4mg1YON2ByqvTzX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com; spf=pass smtp.mailfrom=raritan.com; dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b=ZsAhtEqS; arc=fail smtp.client-ip=40.107.104.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcrkw/g5J/HYzYEL5L4MNjeyDS+REcaHOQnkmGKVYPsdb+oD5aCoD0OOu4BoHbqoLT0koiaY+g8LhiFgKmP1AverXLWTRlJBGw+JbNFMGmJ06RbTHWXk/XjR/ogpPuFHw6whwGQLhBw7gd+kaYRQNhMsUWF8GKR46RvEevSLOx7xAMyxlFpIyYYyLbaHHlAzr9vnpu/FK0genD5hOmlYvV1GomLadmjYix96nPphMuJDZ3C9iuxDV9yqZifeVV/juExHk5vossx+pieTIraqFOEH3TilpS+apbnUiiIU9vZLd0pzcpk4U/sZMvXByo6urkCKbK8xSMWUnfvzoNatBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiuNJirf5kIxqUBz1s5hHv7uvvayt3Up9nDMof/TXF0=;
 b=WQGRyHdG4zd77fdqlnxThgFzQGbM46ra+LTMWXX3fkwAp5mUcgN/hYcZM8PMIDGkJf8MMW1bDtddaW5WqvBmZCLwDAEh5igXOEe+PL7Q54fuybsOIOVjnhll/sRxHZXuhIykjpwv0aDKig5lbJmdEcI6S5vxzUXvgWrcRMBRg0VRJj1qT7kIgODPnRPQ6U2J8RR4hXCUXRQ+3J69LOPyQiA/Ff6XOguGzBpw8E7aHZtyetFiIoYrK42bc0mhakN5Y53/p28ybfoin/GkHf/NKig/P5wXY/1qV9kYYKtWQU8cQYJCI/2VRXl5Ody1SouM9rXucF80r0EIuUWZowurQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiuNJirf5kIxqUBz1s5hHv7uvvayt3Up9nDMof/TXF0=;
 b=ZsAhtEqSDIO2Tfqbzdo+B/QbBOxPd6vXGBGIb8/qYcgQtkL/E3N7ni2tHDR4QeCLb9eZGM8qfqvaBQ/qJ2OUy55cHoP/02cH89APJKVGozJlfrGHT9zIqdxJk2oyH5vkesuZjWu4qEDGF3MCC9ewuy7en1nd0hJ7G59nyNjNKss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DBAPR06MB7014.eurprd06.prod.outlook.com (2603:10a6:10:1a5::23)
 by GV1PR06MB9444.eurprd06.prod.outlook.com (2603:10a6:150:1a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 20:18:53 +0000
Received: from DBAPR06MB7014.eurprd06.prod.outlook.com
 ([fe80::cf79:7281:5306:df94]) by DBAPR06MB7014.eurprd06.prod.outlook.com
 ([fe80::cf79:7281:5306:df94%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 20:18:53 +0000
Message-ID: <025c01a1-457a-40cc-804b-cb4c3c6e3502@raritan.com>
Date: Thu, 4 Jul 2024 22:18:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ks8851: Fix deadlock with the SPI chip variant
To: Jakub Kicinski <kuba@kernel.org>, Ronald Wahl <rwahl@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240703160053.9892-1-rwahl@gmx.de>
 <20240704074407.4cb4ebdf@kernel.org>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20240704074407.4cb4ebdf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To DBAPR06MB7014.eurprd06.prod.outlook.com (2603:10a6:10:1a5::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR06MB7014:EE_|GV1PR06MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cab466-0e0e-4666-5d3c-08dc9c668605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em5KaDQzc3BWbHd2TTg1RHdFRTBiUFpTaklRazdkMmtia1M1UnlHK2ZvUTA5?=
 =?utf-8?B?N0ZidkdrUjlMcmh5d3hpTko5MTEyRGh6dHFxdXNZY1N5bWV3QTVtZnplV1JD?=
 =?utf-8?B?NFhoMU90UzloaS9JenVuajZaSDFudzd5cFpZREFHbm1yRUJFOVlxY1NUc3Rt?=
 =?utf-8?B?MXNYdlJPL2haWUFWZ3Y4eEhRS203M3RWQ2FMTFRsdlh2dE5DeEhPbC9NajBB?=
 =?utf-8?B?aWcrMkxmSXV1OVB1T09VMW1Sdzd1dThyREpKQzNLMlZ2UjJJT1ZwOGVacFNa?=
 =?utf-8?B?YUV6TVp2azNRdkZPU0N6MUE4dzNSWHJzNVl2UWZET3J6WURBRDNKSE15dmRw?=
 =?utf-8?B?djBXdTF4WlBwblloL2N5WmR0enlka1V4ejhpNFF4OXY1K0p5N2FRdG1IalNQ?=
 =?utf-8?B?c1pJTWx4T2ZHYlFGRjNQOVVPTkg0eE5hRTVwOVBwKzVRRFNWd3pJK044WE5r?=
 =?utf-8?B?enpJeXU3TkU1aG9JMU8vSDBtKzZ2dnJmWEFCTko0VUxlNkdOWk9RQmQrTTFl?=
 =?utf-8?B?ZUlMb2JONkZ5dlpubXBzd2hvOVBBYklCOXJCTFhOeWMvbDd1QnlNNGhBTUUz?=
 =?utf-8?B?UitCcWZTdStjZXlBZ3NpdkVrbUNYbzNTOWU1NHpjRWFKRlhjSFZVRHY5UlZw?=
 =?utf-8?B?bUxNNlRBUklySUVFMCtxRWFpbWpkcUlmc1ZQOWRxbGc2Sml5Qm1zaTgvY0I0?=
 =?utf-8?B?T0E2U2U4cGRvbDM3U0hmZ2NhRGpMb0VLTStNYkFOYXVDbUhaYm02ekJlZWZE?=
 =?utf-8?B?SVNYZVhoWG9HYUx1TVE3TWREYmxnNzRub29lcmd6L09NSmNwNHBXeXp3ckNT?=
 =?utf-8?B?R1ZKR0UrVGxKSk1ZSW9Pc2hKYmo0TXZXLzIxZm0xeWVZTS9XSzYzMzZRNW9K?=
 =?utf-8?B?SFpRTXVDY3FoRy8rSk95NFZ1ZFRhZldTcDFab0JKM2ZhOGlvTFdoVTVITlZy?=
 =?utf-8?B?elpCdkVUSVgyMmpJQzZTaUZ2b1cwejl0dGo0ZG9LbHczMzdvUmVpcmVYSjFC?=
 =?utf-8?B?dHBXclk4NTd0MVpTVXRBY1NsUlFFazEyQ2huVWtqTDBDZzQ3TXBuZ2dTNzRn?=
 =?utf-8?B?RzI2NmVSNW01am5yZFN0Zm9ObU03QWVZclZyZ0x5cHM0OUlvclQzQXpHbnBX?=
 =?utf-8?B?bVR1OXRLbGhWQjV3d0txMG1GRlFHd0c5U1RNanpSeG9nT09Oa3ZGMWFjWkVn?=
 =?utf-8?B?YmdqeTNZTVRqMU94V1ZGamhSZ0lick0zKzc4Um1ucy9VNlhNSXBEWWNpdHN4?=
 =?utf-8?B?OUk5c1RZaGlSeDJLMCswTHl5d041d01iNlRiUlFGRnpwditacFk4Y2o3MkZx?=
 =?utf-8?B?N29jYWtlajB2Q0VPeVdYSGM5bTF1QkJSYmtHejg3N3dRRUNRa2NwVmh6Skw4?=
 =?utf-8?B?QWM1RjI2TUJSSldjeTViTTVJVU0rNWdhTlZEa2ZzckpUVnlNc3A5MmJwWDYw?=
 =?utf-8?B?eXBYYUNCS1cxNlFJS29xMkhKWmptRFRudU02VHYvc2c3VmRUcVNiRVJPQ1c1?=
 =?utf-8?B?S1NGRUVCNXkwK0xxNkkvQnlMNGNWZWRPSk83dnliYm02bjRYRm0yZjFPV1FC?=
 =?utf-8?B?bU04YlQxdUdtZU1rQWtnVVpkZ2NQcG1wYlFPSmJpZlBhRmg3SHFsMGpyemtX?=
 =?utf-8?B?ZlhVZkdpSzVkNWI1YUhINDcwMENXTFVmYjNGUXJZdjFrOEZXeVFKcmVIcUVC?=
 =?utf-8?B?WWxHYUdSWUlsTFI3QytBREkwbytUemlaTmV0akRMZ2psaHdQbHE0MlZEYW1D?=
 =?utf-8?B?S3QyS0NDQ3FET2dqSCtXbU5iaStoMmxQenhOUE9zK0MyK3h5Y2l2VVlSaGpR?=
 =?utf-8?B?N0JKNDJmdk1RVU5mUVQrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB7014.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2RHT3Jweklzbm1FR3dSSkRadzRiSGJRY2s3VjRyK0ZXbmFFRGxpR0FFV1Zs?=
 =?utf-8?B?ZHloZ0NZdE1Lbmt6bVdPVjJqZFh0RDc5ZzFBY3JPZVRDWDVPUGgvQWFqMnYz?=
 =?utf-8?B?NmtSYWZxMm9yS3ZQTStkZDRpWmZ6UTl1MEluRVQ1ZU1vdDZmdUFqaU8wbU1S?=
 =?utf-8?B?bENzOGJsTEtiT2w0aEdKaGFEblFCNEJjeGV6cjBrcTgyQUFqc2I5cUhQMWIv?=
 =?utf-8?B?ODR5TERnVTlrRTk2cHRZMUpzdExMbEVrWjFJOVhTUVJwKzIvVmI1QkxuSlJa?=
 =?utf-8?B?aVhkYkJaWTlCdCtFbEtKR3hZalBueWI0SE1IQmdadTRrcTR3SUt2K1JJUEta?=
 =?utf-8?B?WWk0Tk5WMlF2N1BxaVgvL0dsZHcybm1id1NYeGF0MDhQVEJDS2ZlOEhJSXMr?=
 =?utf-8?B?Vy9HVXJ5L2J1c2REREcvY3dnc1hGS245SHVwK0xCTE1UenJhSC9JelJqSVdp?=
 =?utf-8?B?YUlPbEhTd0tubjN5bDJWNHhwdHc0OVA5TmNBR25LVGJDVjViTTdFWUV4cGhU?=
 =?utf-8?B?TTVJQk43bVBhWWE0US9lQ051aEhQb3lwa3ZTRWRMNUlBamI3V0hBbnpPNWtw?=
 =?utf-8?B?c0VBMU5OYkZZbklXRmQvbjFocSswUjY4dktCUVFzQ0JFNmVWc0RMWEdsaU5j?=
 =?utf-8?B?YjBkYk91NGVFT2NxWTFURkFXQkFXN3pCNUFydys3U3liRm1kY2RsZ2x5eXd5?=
 =?utf-8?B?VXRCbUErWWhTZlZYYzhVazFjb01aTnpFS3ZFaEp5ODNTY1JpODNqWlRLbVdm?=
 =?utf-8?B?L2wrOXhpYzFaS0d1eWFlMmRBQVhvZDhQcUxxY2xFaFhyaklPczdPTlo0a1hx?=
 =?utf-8?B?OEQ0czk3TUVNaEZLbFNNbytyY0x2ZHJzZGQ5SHZWZW54Z0MydFZxUDRFd3V1?=
 =?utf-8?B?NUo0NHhJajcvQWFIaDRZeE44VFI0cW1BaWtSYmt0amRCVzB2MXo1NXM4SlI4?=
 =?utf-8?B?MWRWY3ZTTFJuS2RxV1hqekc5ZDNsaUxmZFMyK0pOck1nNGRWbnNJMmR4NHEx?=
 =?utf-8?B?MHhlK0ZjZWI2UUFMQmQyc2hVRFhBVlpOcHNZeTFQTGFOVk16VVlJamV0NzdM?=
 =?utf-8?B?VmJhSzBhNEZSWFZRS3dUNndGcXBYSHNXekk2c1VKYk03MmRXTnlWbkZHRFhI?=
 =?utf-8?B?Vi91NFNqb2xVM1BxRjRtVkk1SCtodHI1T1dLTFNFS2Fad1YvRWJxT3JJNVox?=
 =?utf-8?B?cDdWRE5DOXNDL2c4MFJDeUJpSytmWXl5TmZxVWFqM2FzeWJHTzRKeXJOQmta?=
 =?utf-8?B?N0p6eHVNZElSVzUzQWJybmlxNGhENUhwVENNV2hRRUlqYmNrZ05KZVNiS0tS?=
 =?utf-8?B?Zmo3bDFoU3ZZV0piTGxZNW0rbWpvdk1qUXZaR2hRV28zODI2bzF5M3dtVXN3?=
 =?utf-8?B?NEtLTjlRam9abUJIOEl2bk1FZWRDd3dHMStIdVUyaE5rSHEyMTBocVRqVjdZ?=
 =?utf-8?B?V3MwSmZmOHBHY2dIZkNUUWRFSlY0KzlCWkFMemIwMGFLZUpOMTFyYytDRzZ5?=
 =?utf-8?B?eVI3OHpTTlFuTnF6UU5XMGQvYkl4am50UzZtODczM0hoL0dOdlgvK0VlNHlj?=
 =?utf-8?B?NFpuL1R1QXQvTkEwaDR1NFZhaHZ6TU9TL2p6NFVJallWMFlweGQvYVc4bXVR?=
 =?utf-8?B?ZFhwUUNrOGo1d2g3TGwrT3MvbXZtaDRMbHdEaGUwRmVqVkdtOGlEUkowZTQx?=
 =?utf-8?B?UUNaUUtRYXNrKzFYK1kxMHFtYVl2WThnQnZ4OE42ZzdkbVZIcW53RnAvQlBX?=
 =?utf-8?B?cm1ybmVGTWcxTGFSUlFCeVRiRkp1NmF5UlBBOUoyZGh1TGdheWliN1JXSGds?=
 =?utf-8?B?dUkyNmRtQmFXV3RmV0dJcGhnMEtVRTBtM00vVjU1Z1NHZmR6bTltSEpyM2I0?=
 =?utf-8?B?NXFDOERtTC8zQkpwNjRLU2JkbjZNQm84akJvM0VGUjF4bUVvTXdyM0RDTnpX?=
 =?utf-8?B?ZFpBUlpHbUZJUGc2ajQ3bVNjUDg3MERmOWZsbjhWTVpVUjNzWHA1SFhEUHRU?=
 =?utf-8?B?WmwzVGNrOGFMbi84Zzd5MjRHSVpWampVREoxdmNTNGJHY1dscHdWMGZRdWdL?=
 =?utf-8?B?Ly9OOFZBbVowRVVuajM0cU9idlpncmN1bTErbjh0U0VWTmFZQkl0aXRVUTRQ?=
 =?utf-8?B?TGYycXo2V1BSaWY0c294UGluYmhSUlJHOXAybUVldkIvcG9DTzlhZGsrT1c5?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cab466-0e0e-4666-5d3c-08dc9c668605
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB7014.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 20:18:53.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqjS1IFPQYFUBunoIQs1fd49JUXKfNsTVolIZ47SmM45fUq3UKO258KLKhwwnB2RB06ha8r3i0WDcoxgwgeb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9444

Thanks, I made a v2.

I now also found another potential TX stall issue caused by improper
locking. In ks8851_tx_work we need to move

   last =3D skb_queue_empty(&ks->txq);

under the lock or otherwise risk a TX stall because in case the queue
was empty and has meanwhile being completely filled while we were
waiting for the lock. I need to double check this scenario first. If it
is indeed an issue then I will provide a separate patch later.

On 04.07.24 16:44, Jakub Kicinski wrote:
> On Wed,  3 Jul 2024 18:00:53 +0200 Ronald Wahl wrote:
>> +            bool need_wake_queue;
>>
>>              netif_dbg(ks, intr, ks->netdev,
>>                        "%s: txspace %d\n", __func__, tx_space);
>>
>>              spin_lock(&ks->statelock);
>>              ks->tx_space =3D tx_space;
>> -            if (netif_queue_stopped(ks->netdev))
>> -                    netif_wake_queue(ks->netdev);
>> +            need_wake_queue =3D netif_queue_stopped(ks->netdev);
>>              spin_unlock(&ks->statelock);
>> +            if (need_wake_queue)
>> +                    netif_wake_queue(ks->netdev);
>
> xmit runs in BH, this is just one way you can hit this deadlock
> better fix would be to make sure statelock is always taken
> using spin_lock_bh()


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

