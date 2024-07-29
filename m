Return-Path: <stable+bounces-62587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8C93FB3C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FA31F23805
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052F15ECC0;
	Mon, 29 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DRIdSjoB"
X-Original-To: stable@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020090.outbound.protection.outlook.com [40.93.198.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5C15D5C1
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270356; cv=fail; b=X7Y75Vvqimrn+RZrWVcAgI4SC5c8453obQQQ3ICHbCNvMWyrb9DQSS+gjTnZX2KI8IgY6DOb9al4UygmE+E3XlbqoxnpgnMzF9lEtcZZkTIj6tjFD5uS3YRvKvt7jbwsIO6fTpZJH9guPwOuN0RDCHR+/jE4ToaeMI28Gy17DUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270356; c=relaxed/simple;
	bh=v59TV0jly7U62V9Wf3wA30ZrFuXX/sC+Tm9LLHHFvO8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O5+lvnjx5MXBAypq8WyIz6Yxy/fRvOU1356MxsaEvwxqNBzHIdFjhLzhoH15R29GYAlQ+ZssyzXWSkHUBrFBLmd/GC0UUZHypHB1WyHaKejRo62gRZ8T7A1Wd9ItPyGWulrnMN+Ii1jdu7Wha5F00Fs7CGr6Ma9pmGu6NFSNsGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DRIdSjoB; arc=fail smtp.client-ip=40.93.198.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg1q74EAMQ4Y/18v54JSLJG8gRBu6fk8/hqcD80qcrYsP6WkPxTmDrOzpiCVXqSe8+3h14+glzBfT4gXyEdCh+l1tNBgFtz9HFxzuagYgc3zrBy6EFWTBpCSuCcwKBmp4A/Zb263Msl945UyYd3kqa7eWJlJwD/91G5FGp0x/o7WGb7vDTcr3g8M5PqUY9bWr3fHPUAQ5USbAIK8JMj0e9T7Y03mhFFKsjJdcxM2T4dm2xypwzVPQDKsuPtj2G3NralHmJUugLMypFTIlaalGEY6l9WhEZaW87L2RlxFVK9OdudG6VtA/CPFZkfazlKvuJGeGmGV2iR3gAPw7uBApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+5lEUtmAj2nXq1qPCRuFwMEppDKe+xruogCLQgd1IU=;
 b=D3bR2Kqr/jl+qqD3Y8ER13NFmrxF0ZqUa5Q2BVh2/kYryZyKR+yA7tz81jwLkiDIsjJDYUvbRFJw2fLlNIK85iungRYYrmwEEnRQxxLfrEhbams+svWBWj/vkc+2k1Ubfi+VkklxU/9UvIBpoY61t02/Cj+YipQmeISoUFy8yCrt8/BEFew68n6mAKDXCr+ddYWSrHcA4te+qrc0fMdPi+vOxRMcqAm9uCzS0lgEG40rV/8QN+2j2pCDKIYMoIceVNKSDNo+JX6FeWSfi2pPmU5MXGgUIuxLQ6RQ86T8sbJqQFCleM0Ic3IGa9JM7qoy53W20fY9Tn3/9L1iUj/4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+5lEUtmAj2nXq1qPCRuFwMEppDKe+xruogCLQgd1IU=;
 b=DRIdSjoBG/uPRlxCa+2cOh86ixsiXYouUc5USw5MpSNC1QkC9cJBQRMtwOxU3BpU4Vi1T/ePVrVdDUtuvXSdWS2FEwc3y9NBm0mCHOJ9Dpd5/sllSGVyoqMlDkPZtf2dQ5NUx9zuNLf0cS8moo67cPUYpJ/wl8cfS0jmuQTIreo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6642.prod.exchangelabs.com (2603:10b6:a03:36b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Mon, 29 Jul 2024 16:25:46 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:25:46 +0000
Message-ID: <50454ca6-614b-485c-bdae-8af37ad96bd7@os.amperecomputing.com>
Date: Mon, 29 Jul 2024 09:25:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm: gup: stop abusing try_grab_folio"
 failed to apply to 6.6-stable tree
To: Ge Yang <yangge1116@126.com>, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, david@redhat.com, hch@infradead.org,
 peterx@redhat.com, stable@vger.kernel.org
References: <2024071541-observing-landline-c9ec@gregkh>
 <818aa2e9-924f-41c4-bb5c-dd07fd07dbc0@126.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <818aa2e9-924f-41c4-bb5c-dd07fd07dbc0@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: c03ff3e5-c58b-42d2-8f25-08dcafeb196f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTdnVCs1VnlWcmtvSXk1MS9SZk8wVUxSRUtESFc3V3cxcjkyVkhvcHVIY3E4?=
 =?utf-8?B?Rm5BSzM5c1h1QWZJak1BM3piS2hsWnJVY25IekpVSjNZWFIyOVJVYjNSSFhy?=
 =?utf-8?B?anVZUUsvNWVzWVBicFE4SG0vcTRuWjhqYmpuRnprcTBPODBlWDlyb2ZDUEJK?=
 =?utf-8?B?M2YrdER5emFSV0V3OHRUeWpXbXJteGo5QVM0Y3lyY0sxQUw2VGxnMVNTaU1x?=
 =?utf-8?B?N3ZaMkdJSFJ3NFFhSGlEbk1EYTZobm0vcDlLVWpEdEkzcDJwT2VlTXdzakFS?=
 =?utf-8?B?MVVTNUphbkhacG8rRHJvejhQanpjSGF5VUZuNlpMZHdCU29Xa0RhRWpueUQ5?=
 =?utf-8?B?bFZqL0gxaVZQd2VJMDJzakoyYmtoQ2V2dFRTY3hFVEFOQ0NGSjM4OTJvODVH?=
 =?utf-8?B?eEhheE9JTHB0TXNCeWliaEtrcjFwVGxmc0NLVTNUbHVMSkFDK1FKQUxxYVV1?=
 =?utf-8?B?Z0djemtPVlcyTjlub2RTd2VqOHVmMmd3SzJQNlVUb0phaitTZENiZTF6aG1S?=
 =?utf-8?B?a1hKZzB1VUc3TDYwZmFwdno2NEF3b3lPcnNHT1c5YU04bE9WcVN4L0NTdlNF?=
 =?utf-8?B?clZNWXR3MTJiTEdlTWo1d21oYXJ4aGM3Y1VBQ243QldPRGZVKzVPcUFxT1FK?=
 =?utf-8?B?eHMzc3FLRUZqVm5yR08zbnU4c1NBLzlodVhONE5maXExVGk1TFJpcmRWMVZY?=
 =?utf-8?B?ZUZ0czJVZ0poMmlFakxFekV2NW1kZ2kzSXp4WHJRUHorVnA5OFdMSWdhVzFx?=
 =?utf-8?B?YldrU3Z5dHFPSUV4RS9OYm1KczVhUGRuc1JhR00yRzU5L25odmFUbVpFMEc5?=
 =?utf-8?B?R2NJZUozYktveVNPaWs5VU5acW1sSk9CYlh5NTFmWHFGVm5KQ0Y4dkQ1NEFJ?=
 =?utf-8?B?N1dxeXMraDVRN2REWEtQQldkaEpBOHpyQkZiS01KYWExdGl1STY4Q3RtWjRR?=
 =?utf-8?B?OG52VDVBMFVtclFPNDhwS0Y0dUsxYmd3ZVkwNzNzdHY5TW5HeVdRUWJQR056?=
 =?utf-8?B?ZFN1VGwwRmQ5a2lBUVhKbHNYRWlWdnhSNEorc0s3Z0RZOExqRk1waUJwWjE5?=
 =?utf-8?B?Q0t2R3BrcUc0V1R0cGc5UjVYcWhJSzJPUkV5OUJ1M0RwOVk2ZWlOeHhTZjZm?=
 =?utf-8?B?ektKQkh0dWxpNlFEYnQyNnRxbFBtTHlFS0pJVE1tSzVyM1F6RzJsS1ZyU3Bm?=
 =?utf-8?B?YnFlWjZycGtEK3hob1drZmJ1cDhCbVUrbkYwSERUR2doRDhvclpQU3dabldu?=
 =?utf-8?B?K2xkNE5ISWhxUWk1NUo2OUMyZENqZndmZWpTNVQrbjZqNFE5V2I1RlRvam0y?=
 =?utf-8?B?eDVJd0MwYzYvei9QeXJ2U1VjT2tzU2Y0QVMwdU5PL2tKdGREZisvNmx5UnZF?=
 =?utf-8?B?Ry9RWENNaFpqR0d0M2hUQkUrNzdCMExnZkZmc3Q2ME9ibEw2ZVpJMDJPNklN?=
 =?utf-8?B?S2hXalFXaEMxRXdRQjlIRmhaVkIxNmlZOG8xSTFPZHRyNSs4cnFpV0tNdUJR?=
 =?utf-8?B?ZWo1VGJ3Q0JHWk13WS8vMERaVEJjSkYrMVRVTmFtN3NXTm10S2M0RzlwTzlE?=
 =?utf-8?B?NEtLeFE2NUtLSDM1OU1ZUWdhQVFKdnYzUzBjZnJGY2tyQkx1MEZWRkVrSkhZ?=
 =?utf-8?B?YjVDazBkbnMwR1JnS3Via2JTOW4yWnUwVmpTNk5Dbi9FZG8wV1VsY2k2S2hp?=
 =?utf-8?B?QlhxT0xhNXo4R0xkWVAyMWxRaHZkeTd3VjVVZSsyVEMxVTA1NHlQOTltTVZh?=
 =?utf-8?Q?vhUVzX/xcg0p5WLZKBAdNbpsD3AIoEp7qJoWaQ4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFV2UmQxeDlVcXROelJxaFBMN0tSQjkzcWJncjY1bVlyMTlVSVlySTRmdkpV?=
 =?utf-8?B?SUNXUWp0cmlaNGhLZFBZcVRreDE4MWQrK2ZkWmwxU1NLRkZsU2wvbEFlY05D?=
 =?utf-8?B?QjNGampJNFdpejZENUFOcVJKNnRVZmYxQ3g5SmNvSFZqTzFMcVBocVQzOWht?=
 =?utf-8?B?Tk1oRnBlMHFucmpXbG1YSXFHSzR6d2tJSStRWlB4ZGpRN0hrbTNMZHg1ZG5J?=
 =?utf-8?B?dDNZWjJYVWJqVXF3NEMyWldnSFlWRGFQQ1lIbGZUbnIvekRCU2dMUjRMK0ZT?=
 =?utf-8?B?Vks1RUowTmJIam82bUVHVkdTREk4ZGRwNE9UWW5ISysraUNWYmZwckxEKzRS?=
 =?utf-8?B?cTlUaldWWmkrZUFuMGlJcEJKNGYxTTQ5MExNTmFOVEx6dkRka2d1QVNIVEVz?=
 =?utf-8?B?N1RZRDFhMDd0bHpYY2tkSWJ2N2dmcXNwVGRsUnBYaDFOVitSMFNublZaYlpl?=
 =?utf-8?B?SFZ1b3hqeUY2QWNrdGhWNzN3NEpzeXpzSXc5aGtCRGwwcnV1UkVCcmRmdGpk?=
 =?utf-8?B?WFNwTEFDMS84VkE1U1ZZRTZUQjNXS3hnZ3B3dk9FY0VoVDYxQ2lxMFZleXZL?=
 =?utf-8?B?QlZob1pNMjZEVUVaSmprY2o4WGVrUlZrQitSN2tVcW9yVVNIRFB0VU5xTnZo?=
 =?utf-8?B?L3NSOWp0K0RlWGY0RzlBYW84V0J6dXpwK3BnWXpoOUxkV1JoajFFNlB2cDhx?=
 =?utf-8?B?T3ZkQ2lRUGdWVzZHcEpuMkQwQndDRm1pSU9vNlBtR0ZCL2RxNlJwUHdFUFBy?=
 =?utf-8?B?bkExWjFpK1krTndOUmtFQXFGWEJZVVBqMEJYdC94ck85TWlFaHVEUkpZYm9K?=
 =?utf-8?B?TTNCLzNtc3JEL0FIQkFidlV4Q3plbFVLUkY2Mm5JQW9xOUdkOHdjdFhCUGtt?=
 =?utf-8?B?NkxNUlZrNTNTa1VlZmc3RU9KOU15VnEySzR0T1dCaTRSUTlTSGFVaWlPdFBL?=
 =?utf-8?B?TVFFbXFRM3V6S0N5aEo1emFiV0NpSUhjL0RKQll6Tk1DZnpieXVNbFp2MmI1?=
 =?utf-8?B?Nm9UOW5WYlEzSUJpKzRUVVVjeDhLdWt2UDJUdzk2SGpTTWVsOFhpZE9VeFNR?=
 =?utf-8?B?bmlEdW5xaTQxeUtpZlFIOW9yeE5uTGJrTlc4dGFYTUk1S1pxNVozSUVKZE1t?=
 =?utf-8?B?ak4wSm1NQmhmWUJRbkhHZDZBME5hU2JqR0FRcU8vTnNTem14di9YN3QrNk1N?=
 =?utf-8?B?TWtLTHpmUzV6dEdMUk12MmplZGx5NnFBUUEyTXl2VjNuZFFDVVZ4SldWcTZn?=
 =?utf-8?B?aHZCNnFxNlpmb2p0UjFXR21uZ2Q2VkN5dkNZRnZBZlo5bFU5dFFmN2swYldj?=
 =?utf-8?B?REZON2VSOEMvb01ZSEdyVVZUZWIwSGhrZmhjRGxjQlUyaEVmbVJqbVFXa3N1?=
 =?utf-8?B?S0tQRWt0TXd5RUVJVUxPbE0vTlRLKzhQeFkwVWhuWWdzUVNBSU9CQUJYNVVK?=
 =?utf-8?B?VTJkT0cwdUV3ZzRwZGV4NWZXakVVZmk1Qk1oYjJrQWJvcG9RRm16aHRpTzJR?=
 =?utf-8?B?RVZtM0VkZTEzZUpyazJFN1hNb1A0alRnSHNncmptNWxRbDBES01reU1leGZJ?=
 =?utf-8?B?R3VPNE5TVUdnS0RLK1ZzR1BldkNGNjNTMGtsbklETWo3TTNrc0kxN3VXUEdS?=
 =?utf-8?B?SU5VQlVBRVVmaU1BeU1sUk1kcDFLc2hmb01xWEZsbFk3R0tYVUpmck1kZmJ1?=
 =?utf-8?B?ZjYxOFB5Ymt0WjdRV05UWmN2dHh2eSsvRDM3N1l1NHU2NStzRklpaXkzT1Ry?=
 =?utf-8?B?TnVJZ0tJZm01cjh6K1U1Ulg1QlJ6R21UbkhMeXpCNXlEcFF2SG5TeW1UZG1G?=
 =?utf-8?B?aDVUak8vMnhzQUJHS0xPZ2hkOHVQa1pGRXhsaEpOM3hJejdMTWsvQTRUVTZJ?=
 =?utf-8?B?eTlCNFlMU1hzeHJZcDVnaGlVM0ZEVmJ5L2pFTTZsSWFNWitLUU9uVi9SbmhZ?=
 =?utf-8?B?MjdoNjdER0J0aFRJODVJZEE0bmdmek5GRkljOGRjRnpUNkRJbUxNclFLNXFL?=
 =?utf-8?B?RU83VWxWMXBab2NBL2hhQjRoMG1wSWloNzlNeTRSU1ZoTVJWbTNaWnNXOFZ1?=
 =?utf-8?B?LzJMOE94VkVZY0ZJV3ZySlRBQ2I4QkJOS1NWVVVDVFM5cW95ZXMyYTRvVHJx?=
 =?utf-8?B?WHdEbTc3SEpmeDdickFlZjQzcWtHU2o3WEI4QTBwTmJyZktMSEFwekNpMUEr?=
 =?utf-8?Q?AeXabSrj2AWhEU/0Z+PD5R8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03ff3e5-c58b-42d2-8f25-08dcafeb196f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:25:46.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLkU0I7iBKKC9wjfkia8Zh3iMhKhYxSHJEmojEZ98u86A0DczcRFobVF1lFAx9P3ksZ0YYsqO9SHagrqhMCE1pVVBWZV/ZcOALPYTQvu6Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6642



On 7/23/24 8:09 PM, Ge Yang wrote:
> Hi yang,
>
> May I ask if there is any plan to backport the patch to 6.6-stable tree?

I'm just back from vacation. Will work on this once I finish all piled 
up backlog.

>
> thanks,
>
> yangge
>
> 在 2024/7/15 17:15, gregkh@linuxfoundation.org 写道:
>>
>> The patch below does not apply to the 6.6-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following 
>> commands:
>>
>> git fetch 
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ 
>> linux-6.6.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x f442fa6141379a20b48ae3efabee827a3d260787
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to 
>> '2024071541-observing-landline-c9ec@gregkh' --subject-prefix 'PATCH 
>> 6.6.y' HEAD^..
>>
>> Possible dependencies:
>>
>> f442fa614137 ("mm: gup: stop abusing try_grab_folio")
>> 01d89b93e176 ("mm/gup: fix hugepd handling in hugetlb rework")
>> 9cbe4954c6d9 ("gup: use folios for gup_devmap")
>> 53e45c4f6d4f ("mm: convert put_devmap_managed_page_refs() to 
>> put_devmap_managed_folio_refs()")
>> 6785c54a1b43 ("mm: remove put_devmap_managed_page()")
>> 25176ad09ca3 ("mm/treewide: rename CONFIG_HAVE_FAST_GUP to 
>> CONFIG_HAVE_GUP_FAST")
>> 23babe1934d7 ("mm/gup: consistently name GUP-fast functions")
>> a12083d721d7 ("mm/gup: handle hugepd for follow_page()")
>> 4418c522f683 ("mm/gup: handle huge pmd for follow_pmd_mask()")
>> 1b1676180246 ("mm/gup: handle huge pud for follow_pud_mask()")
>> caf8cab79857 ("mm/gup: cache *pudp in follow_pud_mask()")
>> 878b0c451621 ("mm/gup: handle hugetlb for no_page_table()")
>> f3c94c625fe3 ("mm/gup: refactor record_subpages() to find 1st small 
>> page")
>> 607c63195d63 ("mm/gup: drop gup_fast_folio_allowed() in hugepd 
>> processing")
>> f002882ca369 ("mm: merge folio_is_secretmem() and 
>> folio_fast_pin_allowed() into gup_fast_folio_allowed()")
>> 1965e933ddeb ("mm/treewide: replace pXd_huge() with pXd_leaf()")
>> 7db86dc389aa ("mm/gup: merge pXd huge mapping checks")
>> 089f92141ed0 ("mm/gup: check p4d presence before going on")
>> e6fd5564c07c ("mm/gup: cache p4d in follow_p4d_mask()")
>> 65291dcfcf89 ("mm/secretmem: fix GUP-fast succeeding on secretmem 
>> folios")
>>
>> thanks,
>>
>> greg k-h
>>
>> ------------------ original commit in Linus's tree ------------------
>>
>>  From f442fa6141379a20b48ae3efabee827a3d260787 Mon Sep 17 00:00:00 2001
>> From: Yang Shi <yang@os.amperecomputing.com>
>> Date: Fri, 28 Jun 2024 12:14:58 -0700
>> Subject: [PATCH] mm: gup: stop abusing try_grab_folio
>>
>> A kernel warning was reported when pinning folio in CMA memory when
>> launching SEV virtual machine.  The splat looks like:
>>
>> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 
>> __get_user_pages+0x423/0x520
>> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not 
>> tainted 6.6.33+ #6
>> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
>> [  464.325515] Call Trace:
>> [  464.325520]  <TASK>
>> [  464.325523]  ? __get_user_pages+0x423/0x520
>> [  464.325528]  ? __warn+0x81/0x130
>> [  464.325536]  ? __get_user_pages+0x423/0x520
>> [  464.325541]  ? report_bug+0x171/0x1a0
>> [  464.325549]  ? handle_bug+0x3c/0x70
>> [  464.325554]  ? exc_invalid_op+0x17/0x70
>> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
>> [  464.325567]  ? __get_user_pages+0x423/0x520
>> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
>> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
>> [  464.325590]  pin_user_pages_fast+0x47/0x60
>> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
>> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
>>
>> Per the analysis done by yangge, when starting the SEV virtual 
>> machine, it
>> will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the 
>> memory.
>> But the page is in CMA area, so fast GUP will fail then fallback to the
>> slow path due to the longterm pinnalbe check in try_grab_folio().
>>
>> The slow path will try to pin the pages then migrate them out of CMA 
>> area.
>> But the slow path also uses try_grab_folio() to pin the page, it will
>> also fail due to the same check then the above warning is triggered.
>>
>> In addition, the try_grab_folio() is supposed to be used in fast path 
>> and
>> it elevates folio refcount by using add ref unless zero.  We are 
>> guaranteed
>> to have at least one stable reference in slow path, so the simple 
>> atomic add
>> could be used.  The performance difference should be trivial, but the
>> misuse may be confusing and misleading.
>>
>> Redefined try_grab_folio() to try_grab_folio_fast(), and try_grab_page()
>> to try_grab_folio(), and use them in the proper paths.  This solves both
>> the abuse and the kernel warning.
>>
>> The proper naming makes their usecase more clear and should prevent from
>> abusing in the future.
>>
>> peterx said:
>>
>> : The user will see the pin fails, for gpu-slow it further triggers 
>> the WARN
>> : right below that failure (as in the original report):
>> :
>> :         folio = try_grab_folio(page, page_increm - 1,
>> :                                 foll_flags);
>> :         if (WARN_ON_ONCE(!folio)) { <------------------------ here
>> :                 /*
>> :                         * Release the 1st page ref if the
>> :                         * folio is problematic, fail hard.
>> :                         */
>> :                 gup_put_folio(page_folio(page), 1,
>> :                                 foll_flags);
>> :                 ret = -EFAULT;
>> :                 goto out;
>> :         }
>>
>> [1] 
>> https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/
>>
>> [shy828301@gmail.com: fix implicit declaration of function 
>> try_grab_folio_fast]
>>    Link: 
>> https://lkml.kernel.org/r/CAHbLzkowMSso-4Nufc9hcMehQsK9PNz3OSu-+eniU-2Mm-xjhA@mail.gmail.com
>> Link: 
>> https://lkml.kernel.org/r/20240628191458.2605553-1-yang@os.amperecomputing.com
>> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != 
>> NULL"")
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Reported-by: yangge <yangge1116@126.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: <stable@vger.kernel.org>    [6.6+]
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 469799f805f1..f1d6bc06eb52 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -97,95 +97,6 @@ static inline struct folio *try_get_folio(struct 
>> page *page, int refs)
>>       return folio;
>>   }
>>   -/**
>> - * try_grab_folio() - Attempt to get or pin a folio.
>> - * @page:  pointer to page to be grabbed
>> - * @refs:  the value to (effectively) add to the folio's refcount
>> - * @flags: gup flags: these are the FOLL_* flag values.
>> - *
>> - * "grab" names in this file mean, "look at flags to decide whether 
>> to use
>> - * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's 
>> refcount.
>> - *
>> - * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not 
>> both at the
>> - * same time. (That's true throughout the get_user_pages*() and
>> - * pin_user_pages*() APIs.) Cases:
>> - *
>> - *    FOLL_GET: folio's refcount will be incremented by @refs.
>> - *
>> - *    FOLL_PIN on large folios: folio's refcount will be incremented by
>> - *    @refs, and its pincount will be incremented by @refs.
>> - *
>> - *    FOLL_PIN on single-page folios: folio's refcount will be 
>> incremented by
>> - *    @refs * GUP_PIN_COUNTING_BIAS.
>> - *
>> - * Return: The folio containing @page (with refcount appropriately
>> - * incremented) for success, or NULL upon failure. If neither FOLL_GET
>> - * nor FOLL_PIN was set, that's considered failure, and furthermore,
>> - * a likely bug in the caller, so a warning is also emitted.
>> - */
>> -struct folio *try_grab_folio(struct page *page, int refs, unsigned 
>> int flags)
>> -{
>> -    struct folio *folio;
>> -
>> -    if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
>> -        return NULL;
>> -
>> -    if (unlikely(!(flags & FOLL_PCI_P2PDMA) && 
>> is_pci_p2pdma_page(page)))
>> -        return NULL;
>> -
>> -    if (flags & FOLL_GET)
>> -        return try_get_folio(page, refs);
>> -
>> -    /* FOLL_PIN is set */
>> -
>> -    /*
>> -     * Don't take a pin on the zero page - it's not going anywhere
>> -     * and it is used in a *lot* of places.
>> -     */
>> -    if (is_zero_page(page))
>> -        return page_folio(page);
>> -
>> -    folio = try_get_folio(page, refs);
>> -    if (!folio)
>> -        return NULL;
>> -
>> -    /*
>> -     * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>> -     * right zone, so fail and let the caller fall back to the slow
>> -     * path.
>> -     */
>> -    if (unlikely((flags & FOLL_LONGTERM) &&
>> -             !folio_is_longterm_pinnable(folio))) {
>> -        if (!put_devmap_managed_folio_refs(folio, refs))
>> -            folio_put_refs(folio, refs);
>> -        return NULL;
>> -    }
>> -
>> -    /*
>> -     * When pinning a large folio, use an exact count to track it.
>> -     *
>> -     * However, be sure to *also* increment the normal folio
>> -     * refcount field at least once, so that the folio really
>> -     * is pinned.  That's why the refcount from the earlier
>> -     * try_get_folio() is left intact.
>> -     */
>> -    if (folio_test_large(folio))
>> -        atomic_add(refs, &folio->_pincount);
>> -    else
>> -        folio_ref_add(folio,
>> -                refs * (GUP_PIN_COUNTING_BIAS - 1));
>> -    /*
>> -     * Adjust the pincount before re-checking the PTE for changes.
>> -     * This is essentially a smp_mb() and is paired with a memory
>> -     * barrier in folio_try_share_anon_rmap_*().
>> -     */
>> -    smp_mb__after_atomic();
>> -
>> -    node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>> -
>> -    return folio;
>> -}
>> -
>>   static void gup_put_folio(struct folio *folio, int refs, unsigned 
>> int flags)
>>   {
>>       if (flags & FOLL_PIN) {
>> @@ -203,58 +114,59 @@ static void gup_put_folio(struct folio *folio, 
>> int refs, unsigned int flags)
>>   }
>>     /**
>> - * try_grab_page() - elevate a page's refcount by a flag-dependent 
>> amount
>> - * @page:    pointer to page to be grabbed
>> - * @flags:   gup flags: these are the FOLL_* flag values.
>> + * try_grab_folio() - add a folio's refcount by a flag-dependent amount
>> + * @folio:    pointer to folio to be grabbed
>> + * @refs:     the value to (effectively) add to the folio's refcount
>> + * @flags:    gup flags: these are the FOLL_* flag values
>>    *
>>    * This might not do anything at all, depending on the flags argument.
>>    *
>>    * "grab" names in this file mean, "look at flags to decide whether 
>> to use
>> - * FOLL_PIN or FOLL_GET behavior, when incrementing the page's 
>> refcount.
>> + * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's 
>> refcount.
>>    *
>>    * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not 
>> both at the same
>> - * time. Cases: please see the try_grab_folio() documentation, with
>> - * "refs=1".
>> + * time.
>>    *
>>    * Return: 0 for success, or if no action was required (if neither 
>> FOLL_PIN
>>    * nor FOLL_GET was set, nothing is done). A negative error code 
>> for failure:
>>    *
>> - *   -ENOMEM        FOLL_GET or FOLL_PIN was set, but the page could 
>> not
>> + *   -ENOMEM        FOLL_GET or FOLL_PIN was set, but the folio 
>> could not
>>    *            be grabbed.
>> + *
>> + * It is called when we have a stable reference for the folio, 
>> typically in
>> + * GUP slow path.
>>    */
>> -int __must_check try_grab_page(struct page *page, unsigned int flags)
>> +int __must_check try_grab_folio(struct folio *folio, int refs,
>> +                unsigned int flags)
>>   {
>> -    struct folio *folio = page_folio(page);
>> -
>>       if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
>>           return -ENOMEM;
>>   -    if (unlikely(!(flags & FOLL_PCI_P2PDMA) && 
>> is_pci_p2pdma_page(page)))
>> +    if (unlikely(!(flags & FOLL_PCI_P2PDMA) && 
>> is_pci_p2pdma_page(&folio->page)))
>>           return -EREMOTEIO;
>>         if (flags & FOLL_GET)
>> -        folio_ref_inc(folio);
>> +        folio_ref_add(folio, refs);
>>       else if (flags & FOLL_PIN) {
>>           /*
>>            * Don't take a pin on the zero page - it's not going anywhere
>>            * and it is used in a *lot* of places.
>>            */
>> -        if (is_zero_page(page))
>> +        if (is_zero_folio(folio))
>>               return 0;
>>             /*
>> -         * Similar to try_grab_folio(): be sure to *also*
>> -         * increment the normal page refcount field at least once,
>> +         * Increment the normal page refcount field at least once,
>>            * so that the page really is pinned.
>>            */
>>           if (folio_test_large(folio)) {
>> -            folio_ref_add(folio, 1);
>> -            atomic_add(1, &folio->_pincount);
>> +            folio_ref_add(folio, refs);
>> +            atomic_add(refs, &folio->_pincount);
>>           } else {
>> -            folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>> +            folio_ref_add(folio, refs * GUP_PIN_COUNTING_BIAS);
>>           }
>>   -        node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>> +        node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>>       }
>>         return 0;
>> @@ -515,6 +427,102 @@ static int record_subpages(struct page *page, 
>> unsigned long sz,
>>         return nr;
>>   }
>> +
>> +/**
>> + * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
>> + * @page:  pointer to page to be grabbed
>> + * @refs:  the value to (effectively) add to the folio's refcount
>> + * @flags: gup flags: these are the FOLL_* flag values.
>> + *
>> + * "grab" names in this file mean, "look at flags to decide whether 
>> to use
>> + * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's 
>> refcount.
>> + *
>> + * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not 
>> both at the
>> + * same time. (That's true throughout the get_user_pages*() and
>> + * pin_user_pages*() APIs.) Cases:
>> + *
>> + *    FOLL_GET: folio's refcount will be incremented by @refs.
>> + *
>> + *    FOLL_PIN on large folios: folio's refcount will be incremented by
>> + *    @refs, and its pincount will be incremented by @refs.
>> + *
>> + *    FOLL_PIN on single-page folios: folio's refcount will be 
>> incremented by
>> + *    @refs * GUP_PIN_COUNTING_BIAS.
>> + *
>> + * Return: The folio containing @page (with refcount appropriately
>> + * incremented) for success, or NULL upon failure. If neither FOLL_GET
>> + * nor FOLL_PIN was set, that's considered failure, and furthermore,
>> + * a likely bug in the caller, so a warning is also emitted.
>> + *
>> + * It uses add ref unless zero to elevate the folio refcount and 
>> must be called
>> + * in fast path only.
>> + */
>> +static struct folio *try_grab_folio_fast(struct page *page, int refs,
>> +                     unsigned int flags)
>> +{
>> +    struct folio *folio;
>> +
>> +    /* Raise warn if it is not called in fast GUP */
>> +    VM_WARN_ON_ONCE(!irqs_disabled());
>> +
>> +    if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
>> +        return NULL;
>> +
>> +    if (unlikely(!(flags & FOLL_PCI_P2PDMA) && 
>> is_pci_p2pdma_page(page)))
>> +        return NULL;
>> +
>> +    if (flags & FOLL_GET)
>> +        return try_get_folio(page, refs);
>> +
>> +    /* FOLL_PIN is set */
>> +
>> +    /*
>> +     * Don't take a pin on the zero page - it's not going anywhere
>> +     * and it is used in a *lot* of places.
>> +     */
>> +    if (is_zero_page(page))
>> +        return page_folio(page);
>> +
>> +    folio = try_get_folio(page, refs);
>> +    if (!folio)
>> +        return NULL;
>> +
>> +    /*
>> +     * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>> +     * right zone, so fail and let the caller fall back to the slow
>> +     * path.
>> +     */
>> +    if (unlikely((flags & FOLL_LONGTERM) &&
>> +             !folio_is_longterm_pinnable(folio))) {
>> +        if (!put_devmap_managed_folio_refs(folio, refs))
>> +            folio_put_refs(folio, refs);
>> +        return NULL;
>> +    }
>> +
>> +    /*
>> +     * When pinning a large folio, use an exact count to track it.
>> +     *
>> +     * However, be sure to *also* increment the normal folio
>> +     * refcount field at least once, so that the folio really
>> +     * is pinned.  That's why the refcount from the earlier
>> +     * try_get_folio() is left intact.
>> +     */
>> +    if (folio_test_large(folio))
>> +        atomic_add(refs, &folio->_pincount);
>> +    else
>> +        folio_ref_add(folio,
>> +                refs * (GUP_PIN_COUNTING_BIAS - 1));
>> +    /*
>> +     * Adjust the pincount before re-checking the PTE for changes.
>> +     * This is essentially a smp_mb() and is paired with a memory
>> +     * barrier in folio_try_share_anon_rmap_*().
>> +     */
>> +    smp_mb__after_atomic();
>> +
>> +    node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>> +
>> +    return folio;
>> +}
>>   #endif    /* CONFIG_ARCH_HAS_HUGEPD || CONFIG_HAVE_GUP_FAST */
>>     #ifdef CONFIG_ARCH_HAS_HUGEPD
>> @@ -535,7 +543,7 @@ static unsigned long hugepte_addr_end(unsigned 
>> long addr, unsigned long end,
>>    */
>>   static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, 
>> unsigned long sz,
>>                  unsigned long addr, unsigned long end, unsigned int 
>> flags,
>> -               struct page **pages, int *nr)
>> +               struct page **pages, int *nr, bool fast)
>>   {
>>       unsigned long pte_end;
>>       struct page *page;
>> @@ -558,9 +566,15 @@ static int gup_hugepte(struct vm_area_struct 
>> *vma, pte_t *ptep, unsigned long sz
>>       page = pte_page(pte);
>>       refs = record_subpages(page, sz, addr, end, pages + *nr);
>>   -    folio = try_grab_folio(page, refs, flags);
>> -    if (!folio)
>> -        return 0;
>> +    if (fast) {
>> +        folio = try_grab_folio_fast(page, refs, flags);
>> +        if (!folio)
>> +            return 0;
>> +    } else {
>> +        folio = page_folio(page);
>> +        if (try_grab_folio(folio, refs, flags))
>> +            return 0;
>> +    }
>>         if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
>>           gup_put_folio(folio, refs, flags);
>> @@ -588,7 +602,7 @@ static int gup_hugepte(struct vm_area_struct 
>> *vma, pte_t *ptep, unsigned long sz
>>   static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
>>                 unsigned long addr, unsigned int pdshift,
>>                 unsigned long end, unsigned int flags,
>> -              struct page **pages, int *nr)
>> +              struct page **pages, int *nr, bool fast)
>>   {
>>       pte_t *ptep;
>>       unsigned long sz = 1UL << hugepd_shift(hugepd);
>> @@ -598,7 +612,8 @@ static int gup_hugepd(struct vm_area_struct *vma, 
>> hugepd_t hugepd,
>>       ptep = hugepte_offset(hugepd, addr, pdshift);
>>       do {
>>           next = hugepte_addr_end(addr, end, sz);
>> -        ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
>> +        ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr,
>> +                  fast);
>>           if (ret != 1)
>>               return ret;
>>       } while (ptep++, addr = next, addr != end);
>> @@ -625,7 +640,7 @@ static struct page *follow_hugepd(struct 
>> vm_area_struct *vma, hugepd_t hugepd,
>>       ptep = hugepte_offset(hugepd, addr, pdshift);
>>       ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>>       ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
>> -             flags, &page, &nr);
>> +             flags, &page, &nr, false);
>>       spin_unlock(ptl);
>>         if (ret == 1) {
>> @@ -642,7 +657,7 @@ static struct page *follow_hugepd(struct 
>> vm_area_struct *vma, hugepd_t hugepd,
>>   static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t 
>> hugepd,
>>                    unsigned long addr, unsigned int pdshift,
>>                    unsigned long end, unsigned int flags,
>> -                 struct page **pages, int *nr)
>> +                 struct page **pages, int *nr, bool fast)
>>   {
>>       return 0;
>>   }
>> @@ -729,7 +744,7 @@ static struct page *follow_huge_pud(struct 
>> vm_area_struct *vma,
>>           gup_must_unshare(vma, flags, page))
>>           return ERR_PTR(-EMLINK);
>>   -    ret = try_grab_page(page, flags);
>> +    ret = try_grab_folio(page_folio(page), 1, flags);
>>       if (ret)
>>           page = ERR_PTR(ret);
>>       else
>> @@ -806,7 +821,7 @@ static struct page *follow_huge_pmd(struct 
>> vm_area_struct *vma,
>>       VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>>               !PageAnonExclusive(page), page);
>>   -    ret = try_grab_page(page, flags);
>> +    ret = try_grab_folio(page_folio(page), 1, flags);
>>       if (ret)
>>           return ERR_PTR(ret);
>>   @@ -968,8 +983,8 @@ static struct page *follow_page_pte(struct 
>> vm_area_struct *vma,
>>       VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>>                  !PageAnonExclusive(page), page);
>>   -    /* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is 
>> set. */
>> -    ret = try_grab_page(page, flags);
>> +    /* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is 
>> set. */
>> +    ret = try_grab_folio(page_folio(page), 1, flags);
>>       if (unlikely(ret)) {
>>           page = ERR_PTR(ret);
>>           goto out;
>> @@ -1233,7 +1248,7 @@ static int get_gate_page(struct mm_struct *mm, 
>> unsigned long address,
>>               goto unmap;
>>           *page = pte_page(entry);
>>       }
>> -    ret = try_grab_page(*page, gup_flags);
>> +    ret = try_grab_folio(page_folio(*page), 1, gup_flags);
>>       if (unlikely(ret))
>>           goto unmap;
>>   out:
>> @@ -1636,20 +1651,19 @@ static long __get_user_pages(struct mm_struct 
>> *mm,
>>                * pages.
>>                */
>>               if (page_increm > 1) {
>> -                struct folio *folio;
>> +                struct folio *folio = page_folio(page);
>>                     /*
>>                    * Since we already hold refcount on the
>>                    * large folio, this should never fail.
>>                    */
>> -                folio = try_grab_folio(page, page_increm - 1,
>> -                               foll_flags);
>> -                if (WARN_ON_ONCE(!folio)) {
>> +                if (try_grab_folio(folio, page_increm - 1,
>> +                           foll_flags)) {
>>                       /*
>>                        * Release the 1st page ref if the
>>                        * folio is problematic, fail hard.
>>                        */
>> -                    gup_put_folio(page_folio(page), 1,
>> +                    gup_put_folio(folio, 1,
>>                                 foll_flags);
>>                       ret = -EFAULT;
>>                       goto out;
>> @@ -2797,7 +2811,6 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>    * This code is based heavily on the PowerPC implementation by Nick 
>> Piggin.
>>    */
>>   #ifdef CONFIG_HAVE_GUP_FAST
>> -
>>   /*
>>    * Used in the GUP-fast path to determine whether GUP is permitted 
>> to work on
>>    * a specific folio.
>> @@ -2962,7 +2975,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t 
>> *pmdp, unsigned long addr,
>>           VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>>           page = pte_page(pte);
>>   -        folio = try_grab_folio(page, 1, flags);
>> +        folio = try_grab_folio_fast(page, 1, flags);
>>           if (!folio)
>>               goto pte_unmap;
>>   @@ -3049,7 +3062,7 @@ static int gup_fast_devmap_leaf(unsigned long 
>> pfn, unsigned long addr,
>>               break;
>>           }
>>   -        folio = try_grab_folio(page, 1, flags);
>> +        folio = try_grab_folio_fast(page, 1, flags);
>>           if (!folio) {
>>               gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
>>               break;
>> @@ -3138,7 +3151,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t 
>> *pmdp, unsigned long addr,
>>       page = pmd_page(orig);
>>       refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
>>   -    folio = try_grab_folio(page, refs, flags);
>> +    folio = try_grab_folio_fast(page, refs, flags);
>>       if (!folio)
>>           return 0;
>>   @@ -3182,7 +3195,7 @@ static int gup_fast_pud_leaf(pud_t orig, 
>> pud_t *pudp, unsigned long addr,
>>       page = pud_page(orig);
>>       refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
>>   -    folio = try_grab_folio(page, refs, flags);
>> +    folio = try_grab_folio_fast(page, refs, flags);
>>       if (!folio)
>>           return 0;
>>   @@ -3222,7 +3235,7 @@ static int gup_fast_pgd_leaf(pgd_t orig, 
>> pgd_t *pgdp, unsigned long addr,
>>       page = pgd_page(orig);
>>       refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
>>   -    folio = try_grab_folio(page, refs, flags);
>> +    folio = try_grab_folio_fast(page, refs, flags);
>>       if (!folio)
>>           return 0;
>>   @@ -3276,7 +3289,8 @@ static int gup_fast_pmd_range(pud_t *pudp, 
>> pud_t pud, unsigned long addr,
>>                * pmd format and THP pmd format
>>                */
>>               if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
>> -                       PMD_SHIFT, next, flags, pages, nr) != 1)
>> +                       PMD_SHIFT, next, flags, pages, nr,
>> +                       true) != 1)
>>                   return 0;
>>           } else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
>>                              pages, nr))
>> @@ -3306,7 +3320,8 @@ static int gup_fast_pud_range(p4d_t *p4dp, 
>> p4d_t p4d, unsigned long addr,
>>                   return 0;
>>           } else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
>>               if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
>> -                       PUD_SHIFT, next, flags, pages, nr) != 1)
>> +                       PUD_SHIFT, next, flags, pages, nr,
>> +                       true) != 1)
>>                   return 0;
>>           } else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
>>                              pages, nr))
>> @@ -3333,7 +3348,8 @@ static int gup_fast_p4d_range(pgd_t *pgdp, 
>> pgd_t pgd, unsigned long addr,
>>           BUILD_BUG_ON(p4d_leaf(p4d));
>>           if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
>>               if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
>> -                       P4D_SHIFT, next, flags, pages, nr) != 1)
>> +                       P4D_SHIFT, next, flags, pages, nr,
>> +                       true) != 1)
>>                   return 0;
>>           } else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
>>                              pages, nr))
>> @@ -3362,7 +3378,8 @@ static void gup_fast_pgd_range(unsigned long 
>> addr, unsigned long end,
>>                   return;
>>           } else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
>>               if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
>> -                       PGDIR_SHIFT, next, flags, pages, nr) != 1)
>> +                       PGDIR_SHIFT, next, flags, pages, nr,
>> +                       true) != 1)
>>                   return;
>>           } else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
>>                              pages, nr))
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index db7946a0a28c..2120f7478e55 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1331,7 +1331,7 @@ struct page *follow_devmap_pmd(struct 
>> vm_area_struct *vma, unsigned long addr,
>>       if (!*pgmap)
>>           return ERR_PTR(-EFAULT);
>>       page = pfn_to_page(pfn);
>> -    ret = try_grab_page(page, flags);
>> +    ret = try_grab_folio(page_folio(page), 1, flags);
>>       if (ret)
>>           page = ERR_PTR(ret);
>>   diff --git a/mm/internal.h b/mm/internal.h
>> index 6902b7dd8509..cc2c5e07fad3 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1182,8 +1182,8 @@ int migrate_device_coherent_page(struct page 
>> *page);
>>   /*
>>    * mm/gup.c
>>    */
>> -struct folio *try_grab_folio(struct page *page, int refs, unsigned 
>> int flags);
>> -int __must_check try_grab_page(struct page *page, unsigned int flags);
>> +int __must_check try_grab_folio(struct folio *folio, int refs,
>> +                unsigned int flags);
>>     /*
>>    * mm/huge_memory.c
>


