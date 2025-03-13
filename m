Return-Path: <stable+bounces-124270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A884A5F208
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F8B3A595C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98562265CD1;
	Thu, 13 Mar 2025 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zVoAZtvH"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC2265CC5
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864176; cv=fail; b=ksIlLjA01Qv87vvqpEmbdxQb5/Tond4kUfUsv6FlTA1PqkXlXjJxZoTDhtpM+6aIv0n70kiyWQpezKPujzRF1/KVqGR76Lt0I1ft3DgMxlzsR73yvxkIoQBGag98zTa0h39otmu3XbqyR8RRvvxQL/FWWXQ4MMKeLNglnQWXylk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864176; c=relaxed/simple;
	bh=NtMtLD4HMjyh3kq2rz2K7SzL318C/GTviswRytReoBw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LiYh3g0XdWOpbhSIeOLJCn+WSFvG99mdqg3nVKV/OsiMdygpRMJn81io9AycO0LnDudNPBUj0toIOboblge8JVe9j2n77cysMACzdmcsxxrmEFjI+0bV6ZqkTRCx+3oodsFRo6pP4bpO0pxltkds+MfaFxV1+7DIRuEeDjCoQgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zVoAZtvH; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfWDNzePvAdHoAimgXieFkj8oBxSeqWdAQG0LxOzirhDliTsg2u8ElZX99x2nDjMg6WCl5sOsfcllpvh/agBrUHE865cvPmZMmrivl99ekHHE7dPTxRqs/FjBZMvs/fzRLrmH2mYlmjE0qVdXYnG8rz+WzI7Ov56PnFSRsHtGhfSFalKPazyMxDuJIXP3wZz0JwI4W4ojh8R/smKKcPVYvMhUOW45x11o0+7smnfuoNCVJpvLvKXjW7juE11qkGx9GR7m9qBwyNC94HKOn5o4DN7HsV//0zjVA3Hh6sLsVmTZly6UJSEOqiXqc9F0NBFstB0xOoMXnnogaD9tbGibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQLfr3RWhxqiMhSMsrNt+A6PEJzSyCBVTq0QzL5RLiU=;
 b=URcUIGBiZImNFZ2OWiOJLAcrUO2zb+Fg38efB7PLdU8J1rWa1uwA7V8wV1JylJZhVcd6cX7iR7n20KHpSglwshlUPfzikyKxpZ9ltaxz8F2Bw52457yLiwsQMerwFsDK4PtrJ3Y7ml52r5Gocqk6rp2aS0+I9dmu03FFpCF0BMsnu2j8cgUxw9y4Z3Bp/BSIrSYa1MdFrh978sRMrij7vFhKqqcINMLSMedY0KYVrtfeUyo2C59jIiG0xXGn6aL9QuCY2OEXFE/AGQV7HnqbmaIwRdE+3duQSik+qdNFIsI7i5PYTvwIIuEnPmgwg/F2g1FuFsVmFZrUjeWb9j01WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQLfr3RWhxqiMhSMsrNt+A6PEJzSyCBVTq0QzL5RLiU=;
 b=zVoAZtvHuWlJQkTT/SrPz4Lw/Xcy1QbUtmH5iI+FbxbmrAZ9/DuLTtjPQbknaqsxf7f9cdTKinQfLCgSL4/XSrHx3/QMZyDTmNLriXJrP620DYgH54CHk1LwUOrelr6d7hB2tD2l+m7JIoTfBABX78/RHdM9ZJBkxv2655iw2Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 11:09:32 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 11:09:31 +0000
Message-ID: <4b8da939-7985-43b8-b0c6-12e5871be632@amd.com>
Date: Thu, 13 Mar 2025 22:09:25 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages
 handling under snp_cmd_mutex
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250312223932-352a4f3bf0ca25bb@stable.kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250312223932-352a4f3bf0ca25bb@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME3P282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:80::24) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d479f30-76d4-4637-121d-08dd621f87ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHlsVDlFQzFZRUVMUlI5clFiVkdpamdhb1pxRGh0QlBTSngrUkE4S2NXV2R6?=
 =?utf-8?B?cEVZMmJNZ2RRd3loVU80emE3MGJ4Y0d5SjNaL1hDanJHenNXb2E5Tnpaajgw?=
 =?utf-8?B?SUxZOXpKNURra21VNC9YSlNWNjlLMEJyMElTWlNzZXptb0sxMkFrRGdEVnlC?=
 =?utf-8?B?cC9DditnQkZWMGZ1bllQczkyaFpMRzhpaUp3NWk3aHhuV045MHA5c3dqTmpH?=
 =?utf-8?B?MjRNWG4vaWpudFdBUHJtbEkzaEZLckF1SVM0cG05V0RkU05aWUU2cVFtS0dD?=
 =?utf-8?B?Z21uUGkrc1VnUGVKY3R6NVl1Wk9wdGFiME04anhhOU4wNm55VXFyZUswc1Qw?=
 =?utf-8?B?K3FDWTExc3cvZGFiV3UxM1NVcWxxVFRHRFl6cWZCTUh1UnVTMXVhb1ppTkpz?=
 =?utf-8?B?eUM4UlAraHBjVEJmR3h6YksyUERlSmpZc3ZIc0xpTkE5a045VXdXVmVuZ3h2?=
 =?utf-8?B?QWVSUW8relcyekJkVlE4RTNPQThpOFAraThpOU9SRG5KVlZWZUFVRUhJQ2lE?=
 =?utf-8?B?Vi9CcWRMdFBVR3JqOGRPVllIcm0vNmNnV1hCd1NGVWRvSGhZUmFOVzhTRDBS?=
 =?utf-8?B?YUpMM2ErWmZSYS9lQk51ZkpxV2hhRGFmcDQvNGFlZDdKSG9SOCsxRStybzNP?=
 =?utf-8?B?STg3YUx1MWRYMTc0ZU9scXY5OGdmK0lTQk96TXVyREhvRjRYSlJndDRxTUdJ?=
 =?utf-8?B?WW5rV0NDWW1YQlR4ZHg3THduZTl3NzZDMWZSeU9BOUg0YUtrQnAweG9Yd2xM?=
 =?utf-8?B?TG0rSEw4aVhVQWdkTEJ1VURtMXhUNGYyclFVQ1dEU2U1bUtiMTh4eEVBVExI?=
 =?utf-8?B?MkNSSHdkcEZ6Z2trSFZYZ25pS3ZQNVMyV0dkbm5Bcm8yV29mQmlhMklUbXNT?=
 =?utf-8?B?VEpJeTNEeEFzekloSTFWOXlLQ1BQdEFpdXJpM3NzMWNHZHBsL1AwMmZ1OHp1?=
 =?utf-8?B?UExJU2FHcUs1T3FSOVZOYmdZV2htR3Y2Kzc4MHM3dllYOUpXMzBTRHhhbWVU?=
 =?utf-8?B?ajJPZEw4TzNMa0lkOFRHTFhwL2hMRUc4bDBrYzh3T204ZnNJR3hhUFZPc2U0?=
 =?utf-8?B?b0pzNzRRWDdQazkrYjhjZEpndStCNUdTenpmZk82ZlN6RXZyclVLVXlLTytE?=
 =?utf-8?B?SmRNTVZ4dHF5QmNKcVZmMlptb1dYMWMrQzgvWkkxajN6dkxnMi9POFhuRHdN?=
 =?utf-8?B?Q3phWFkycnJidkh5Y0swNjVMT29DN2tza3YvVmt3Ri9MM3N1MU1OcUNObVd5?=
 =?utf-8?B?QjZXR1BXMnB3NjlRQTMzUGFGbzNPTVFnNEUwWmlsOU9nNWNEd01vcmFPTWEy?=
 =?utf-8?B?RU5FODJydW9nZnRNL0ZoeHhQby9xUEo1dzFjOWxEZURkM010b1IyTHk4ZVFy?=
 =?utf-8?B?UVlyUDYzV2FkRGMxcU82SDkzR0pNN1o4b2Q5R0JpYWFtT296Q2VpMVZmOGlJ?=
 =?utf-8?B?aSsrUVB4ZS9MKzBTbG95aVo1TnhHQm9XQUdzZCt6WGpmU0dvamVIK2l1bEFz?=
 =?utf-8?B?c3hEZVJ2aW9tNGxhc1BKdUZiZzhoV0N6eEZWM3lLdDZNSlZrN2NlYjV1WEZ1?=
 =?utf-8?B?Vm5xbGhmenkvZXY5ZmZ2dm5VdjVIbklKbWRzYUhQMHlEd3FPV2grdWRFbUcx?=
 =?utf-8?B?MUNGUFBKcVRCaGtVUnBYbVBDV2NqMlNzZWwzMWhmZGdvVXFUamdDNkpvWGgw?=
 =?utf-8?B?NXZRazFaZmhmYmFydFJDaHExMWVhR0UveU5NL0dpbVJMcGM5bzJ5S3c0Qk4z?=
 =?utf-8?B?Zzcza0xLTTJrNzl1eEMxdGNReWJNUklEV3dRNnozemRUamUrZXUvbXBocXBt?=
 =?utf-8?B?ZStLdmwzbWk5Tk9TWmpXeW1JcGowcExGcHl2MXN0bUREMVZUcmZWRHhSNG9Q?=
 =?utf-8?Q?B87b7sHXwodhs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpSaE5LOHBjemJBWkkvZVc3cFBzeElWSzQzd3ZRTUF0aXNlbXlXODd4MldQ?=
 =?utf-8?B?RlIwRjBDQ3MyUXdSWDRhNUN5NDJaOFEwVXIydXAxWGdVeUhvSHdWaW56Wk1N?=
 =?utf-8?B?OFhQSGpEaWNiT2tabVBZMUVUWm40cXBWaXV3ZWFvODNmRVlkbUtOd2R1YSs4?=
 =?utf-8?B?TSswS1VaS1E0cHl0ZEVwZHFxWHM5ckVMVm1TcTZiSUEybXNtS3Rzamo2QVhO?=
 =?utf-8?B?WSs3WXJkM3ZXUmZuOW94VFdlZXVUVFdMNDdUTCtkcHZlakNyTXA3aVV0YXM2?=
 =?utf-8?B?UThsTVBIY1VlNkZ5YTJlUjAwQmxVcWk2QnFyTmp2bHBLNU1ZT2lmYlpDMWdD?=
 =?utf-8?B?a0I0d3pUYm92K0V0dVA1UGdpVGN3U295aWxQRk80bWZPRzFlbWlBYUZodERs?=
 =?utf-8?B?UVVsY3VxSW0vUS83UUxVcmdlMmxsNXpDMGFOc3NLalNvM2hBV09scnZYZDI0?=
 =?utf-8?B?ZXVHUWZmbjliWG9Vekxvd29USG5tSlVoSTZHRHp2K29aUTFkenhGeGEyeFFr?=
 =?utf-8?B?dVVlSVhKZEFIM1BwNms0WVlGajRhN3BVZmsyU2Vnd3EycTlRTUlobUpHZVor?=
 =?utf-8?B?ZHN5SW9rS2doOCtITGVyaVRmdE10eUpRY0VEaDBHUzNORVlUQkpmcGNZZjRk?=
 =?utf-8?B?eUNXSUtzblNhTCtBa0srWnlDQXpXdEQwVk9wT0lkUm5WRzNPZE9CVTMrS3BV?=
 =?utf-8?B?V3RndU41QzNzM1F1L3NYc2IzekJIZ2xjSXJLL2pzcXUyTlpUYzhBdlFPL0Fo?=
 =?utf-8?B?dENyaGNNNXhoeUhmZzZwZjllTTdCMDhldWZGR2VMeHhIVTFEVTlhTlpPVXU3?=
 =?utf-8?B?cTkrVk1hdEEwMkxvUWhCWXJSaHJ5aDZ4SGNObTlGUFJTRk5wWisybUMxTTZK?=
 =?utf-8?B?V3lSN0FCQkVYdHd2TjA4VmFoSC9na2NJVTRLUVg2cE9YOFg0RzJqNXNubE9k?=
 =?utf-8?B?RS83K042aEV5NFFDUGZqRWJSSzg2ZXdKaFdXaCtVNnZlZG9vcUhYQU1mazht?=
 =?utf-8?B?eTBHbWZKWlFqN2Yxc2RlK0lDYjdrK1NiclpscGd5SHYyRUIvMit5bXJ4bFdS?=
 =?utf-8?B?a1hRaHkvSHY1cUhMdFNrV1R4VXczejlOTm16RHU1TjB4T0pSMnUrWDhjeUVx?=
 =?utf-8?B?OGRKTmlxRVBtOWMvc3B4Sm5udWhsdlRrM2YvYzExV2w1cFhCb0l6dHFsTG5v?=
 =?utf-8?B?cE5mSk1sTDVLRk92ZVluVWVhMHgyeGwyV0p2M3V1SWxlV2JYeGRKQzZzVExJ?=
 =?utf-8?B?OWFJR3Z2dW1UOTh3MmZaT2tIZjdMN1VJVkpZbG5FbDNMSkczVi9IazFmNVNj?=
 =?utf-8?B?ckZKc2E3a0dWcFZGVC9xcDdyUlpaSFBFdUlmSjlnbUM2T3ptemtpTkJudmMx?=
 =?utf-8?B?aEpZU0h4TWFqUmpqeXZtV0pZTWNRMm5iWk5DTi9SZGZCTmNwQVZTRHFnRjJq?=
 =?utf-8?B?VnM1ZjV1VjVmWW1UUmNtMWJtemNmejNoQ3FuUnRBdU9MQ05DeVBNTlJwdjJo?=
 =?utf-8?B?UHRiRndxcU55R3VKU0ppSGV0R1c4eE9FeUVKcmxkOTg3SHdDUWdRenlnQ2Zs?=
 =?utf-8?B?K2pBOWVIc05GVUJMUGVtcW54Q1FUL3MyWnRMQ3dEbzB1M2FGOGFIMXcwUm40?=
 =?utf-8?B?YzVYY29jS2Y2bDhyNUN4Um5VV0hRbEZ3QmIxYjRmWDQ2a1V6aExTUnpVRkc1?=
 =?utf-8?B?U0dSUWZMRThTTUpza1pqWVNXN3lhYXVkRTduUVgwb1RtZitwU252cFJocTFO?=
 =?utf-8?B?QWJCTUJXU0hQYU81M3BtVFFsaDEvYzh4K283aUJPY0VaVzdDVU4vVUJ6bEhT?=
 =?utf-8?B?RjR4Rm8wcWZQSFY4M3Z4YjY1SWdRenoxK3RGRUlnMzh4eDZJWk9haWRyajBk?=
 =?utf-8?B?TWV0UGhWRDErL2s3aVlEQndOTlFiVzd3UWpDa1BuUDlycWVhTGVibmZWdm9q?=
 =?utf-8?B?bitoc2xZRld6QzZEWUF1QUNCdThzTVd6bXlFaW5xOG43UzJrMFpXRVJCcm5s?=
 =?utf-8?B?RW84c3lBaGhha1h1OWdLZ1MwUzhBYUpRQXdjL1NMT2NMYmVXRHBlUjdNdjdl?=
 =?utf-8?B?aG55bkFGbUJIVzZZaTMrVTZxKzdyNVNUUzB6ZHdicWk4RDZsaWRKaC90eHZX?=
 =?utf-8?Q?nP8jcfP4xb2VGCx36SYBF/fN1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d479f30-76d4-4637-121d-08dd621f87ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 11:09:31.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2tIo5GRKCYBAuoDRObTz5fyc3vFH3iZtztPRzO+Ix2Vo7Tt/4y6oH5aJK9ImqVypBpIi5fSe+lHcE89ttEbhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

What does the tool not like in particular? The fact they are different? 
Or the backported commit log must have started with "commit xxx 
upstream." and "(cherry picked from commit xxx)" is not good enough? Thanks,


On 13/3/25 20:08, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> 
> Found matching upstream commit: 3e385c0d6ce88ac9916dcf84267bd5855d830748
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  3e385c0d6ce88 ! 1:  796b69e2edd7a virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
>      @@ Commit message
>           Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>           Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>           Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
>      -    Cc: stable@vger.kernel.org
>      +    Cc: stable@vger.kernel.org # 6.13
>           Link: https://lore.kernel.org/r/20250307013700.437505-3-aik@amd.com
>      +    (cherry picked from commit 3e385c0d6ce88ac9916dcf84267bd5855d830748)
>       
>      - ## arch/x86/coco/sev/core.c ##
>      -@@ arch/x86/coco/sev/core.c: struct snp_msg_desc *snp_msg_alloc(void)
>      - 	if (!mdesc->response)
>      - 		goto e_free_request;
>      + ## arch/x86/include/asm/sev.h ##
>      +@@ arch/x86/include/asm/sev.h: struct snp_guest_req {
>      + 	unsigned int vmpck_id;
>      + 	u8 msg_version;
>      + 	u8 msg_type;
>      ++
>      ++	struct snp_req_data input;
>      ++	void *certs_data;
>      + };
>        
>      --	mdesc->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
>      --	if (!mdesc->certs_data)
>      --		goto e_free_response;
>      --
>      --	/* initial the input address for guest request */
>      --	mdesc->input.req_gpa = __pa(mdesc->request);
>      --	mdesc->input.resp_gpa = __pa(mdesc->response);
>      --	mdesc->input.data_gpa = __pa(mdesc->certs_data);
>      + /*
>      +@@ arch/x86/include/asm/sev.h: struct snp_msg_desc {
>      + 	struct snp_guest_msg secret_request, secret_response;
>      +
>      + 	struct snp_secrets_page *secrets;
>      +-	struct snp_req_data input;
>       -
>      - 	return mdesc;
>      +-	void *certs_data;
>        
>      --e_free_response:
>      --	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>      - e_free_request:
>      - 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
>      - e_unmap:
>      -@@ arch/x86/coco/sev/core.c: void snp_msg_free(struct snp_msg_desc *mdesc)
>      - 	kfree(mdesc->ctx);
>      - 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>      - 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
>      --	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
>      - 	iounmap((__force void __iomem *)mdesc->secrets);
>      + 	struct aesgcm_ctx *ctx;
>        
>      - 	memset(mdesc, 0, sizeof(*mdesc));
>      -@@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>      +
>      + ## drivers/virt/coco/sev-guest/sev-guest.c ##
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>        	 * sequence number must be incremented or the VMPCK must be deleted to
>        	 * prevent reuse of the IV.
>        	 */
>      @@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc
>        	switch (rc) {
>        	case -ENOSPC:
>        		/*
>      -@@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>        		 * order to increment the sequence number and thus avoid
>        		 * IV reuse.
>        		 */
>      @@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc
>        		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
>        
>        		/*
>      -@@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>        	}
>        
>        	if (override_npages)
>      @@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc
>        
>        	return rc;
>        }
>      -@@ arch/x86/coco/sev/core.c: int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
>      - 	 */
>      - 	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>      + 	memcpy(mdesc->request, &mdesc->secret_request,
>      + 	       sizeof(mdesc->secret_request));
>        
>      -+	/* Initialize the input address for guest request */
>      ++	/* initial the input address for guest request */
>       +	req->input.req_gpa = __pa(mdesc->request);
>       +	req->input.resp_gpa = __pa(mdesc->response);
>       +	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
>      @@ arch/x86/coco/sev/core.c: int snp_send_guest_request(struct snp_msg_desc *mdesc,
>        	rc = __handle_guest_request(mdesc, req, rio);
>        	if (rc) {
>        		if (rc == -EIO &&
>      -
>      - ## arch/x86/include/asm/sev.h ##
>      -@@ arch/x86/include/asm/sev.h: struct snp_guest_req {
>      - 	unsigned int vmpck_id;
>      - 	u8 msg_version;
>      - 	u8 msg_type;
>      -+
>      -+	struct snp_req_data input;
>      -+	void *certs_data;
>      - };
>      -
>      - /*
>      -@@ arch/x86/include/asm/sev.h: struct snp_msg_desc {
>      - 	struct snp_guest_msg secret_request, secret_response;
>      -
>      - 	struct snp_secrets_page *secrets;
>      --	struct snp_req_data input;
>      --
>      --	void *certs_data;
>      -
>      - 	struct aesgcm_ctx *ctx;
>      -
>      -
>      - ## drivers/virt/coco/sev-guest/sev-guest.c ##
>       @@ drivers/virt/coco/sev-guest/sev-guest.c: static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>        	struct snp_guest_req req = {};
>        	int ret, npages = 0, resp_len;
>      @@ drivers/virt/coco/sev-guest/sev-guest.c: static int get_ext_report(struct snp_gu
>        	return ret;
>        }
>        
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __init sev_guest_probe(struct platform_device *pdev)
>      + 	if (!mdesc->response)
>      + 		goto e_free_request;
>      +
>      +-	mdesc->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
>      +-	if (!mdesc->certs_data)
>      +-		goto e_free_response;
>      +-
>      + 	ret = -EIO;
>      + 	mdesc->ctx = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
>      + 	if (!mdesc->ctx)
>      +-		goto e_free_cert_data;
>      ++		goto e_free_response;
>      +
>      + 	misc = &snp_dev->misc;
>      + 	misc->minor = MISC_DYNAMIC_MINOR;
>      + 	misc->name = DEVICE_NAME;
>      + 	misc->fops = &snp_guest_fops;
>      +
>      +-	/* Initialize the input addresses for guest request */
>      +-	mdesc->input.req_gpa = __pa(mdesc->request);
>      +-	mdesc->input.resp_gpa = __pa(mdesc->response);
>      +-	mdesc->input.data_gpa = __pa(mdesc->certs_data);
>      +-
>      + 	/* Set the privlevel_floor attribute based on the vmpck_id */
>      + 	sev_tsm_ops.privlevel_floor = vmpck_id;
>      +
>      + 	ret = tsm_register(&sev_tsm_ops, snp_dev);
>      + 	if (ret)
>      +-		goto e_free_cert_data;
>      ++		goto e_free_response;
>      +
>      + 	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
>      + 	if (ret)
>      +-		goto e_free_cert_data;
>      ++		goto e_free_response;
>      +
>      + 	ret =  misc_register(misc);
>      + 	if (ret)
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __init sev_guest_probe(struct platform_device *pdev)
>      +
>      + e_free_ctx:
>      + 	kfree(mdesc->ctx);
>      +-e_free_cert_data:
>      +-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
>      + e_free_response:
>      + 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>      + e_free_request:
>      +@@ drivers/virt/coco/sev-guest/sev-guest.c: static void __exit sev_guest_remove(struct platform_device *pdev)
>      + 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
>      + 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
>      +
>      +-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
>      + 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>      + 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
>      + 	kfree(mdesc->ctx);
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.13.y       |  Success    |  Success   |

-- 
Alexey


