Return-Path: <stable+bounces-15764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B783B8CE
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 05:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FD287C8B
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABF2582;
	Thu, 25 Jan 2024 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="RjWhhgzl"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9C79E1
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 04:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158685; cv=fail; b=s2rfhfKij2qNDNHHYWh8mV9xO8wL+hc5MJFbiUXuUt0G9lGVINeXwL+gB2kNyMJUtvy64m/pjcDXdavJajBfw8GvAAGaToLp7YgdVwOnDqjVuXs0dGEk0JRnsMJVuos7UBXtBMouXmPRErlpDY/tRahSbL/sSz22io39S1oQfWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158685; c=relaxed/simple;
	bh=yw0sVGsI9R5V79lGzq46wap3NaBVNaADV99yvWdE45o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=salvK1dbzZBVdIqQUfFrJtORaPZDVBO/4tT8JRZEceRJY83cCmgffDNgo8xZYPpu+2BWaXi7xQbRyPQ/uAMCTKLqSg4H/Uwax7aQTIN/cMODWyZbjvLT7QUUqSiYCDBNbhM+mZaBnu5/BtDydMynMh0G3jIpmChQZmsp3qG5uW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=RjWhhgzl; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltFTuMFMbR586WS83LIoOHZ9XyTso3Vm8nCfkCE+5tbJIiNOt31aR48kVnivILEfxXVE0xMg9HSZdFBTGKZ7rCpr6II+jJ+9pMq65CweFK89bXMojdh260Xqx7z+eSnPfhpFZ6IPsT3pQmlo9cc095yp7mboHWTrwzETaYpynR+54p5kSSu355fvY+VtRNhP+qwOFx/vl8FjIUhrXBuwFSM2uFC9SYa7zEHjWvPxsxH6sehhQYC67y6K381bp/BZywplaOUc/E3FkqPnx8xT/Vmh9YW4rxcnZKc3NNm/osrDd12JhqYDI+mGjEceHDNjphtd0CVYVymOmOhUFPpPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw0sVGsI9R5V79lGzq46wap3NaBVNaADV99yvWdE45o=;
 b=IHlU2FfxLXxZpCGZLE3+6dv6sDTdUl0MSDtrVCJZAZq7to+BZSaV1pA6rLQk13r/XcAMyGkUXttiNWzpCLRHCF9zIyZz9LS27B6hIX9EL9Jkjus2DzmardD5S4sI/r2hJL4dJQfsDtMtXeyX/iAgT8nBJSpltcixS6NxQBhw/sGERzwOhKNEPqejw6VhBfG3Lm6kfubzNlABTL07YW8oLISB12IF5vJFYhUvcE47lkSbR24jYLowc4ywQo2mTXMasMnxLZRmL+TXpezE6M8HGluxM9872m7cVO5vyrE2zKBHLcdFyZS84LbEgXJPlrhYmcVPFtMoC45gWBh7hwb5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw0sVGsI9R5V79lGzq46wap3NaBVNaADV99yvWdE45o=;
 b=RjWhhgzlOkQi/lXs2PSKI3GuzTpsPzzRs6t8Lc0DUYNySfXwBs3wBMgMg3CqbmuWTmT8MhBS83uzoQ6Ven8fGr+xePBuepV6jxT0T9FcAaizlF657FWBzTnWdLr0KO6Kfx5lkckp0hIX5yMWfFtTgrwi9UFvSZ2zfyjEXptsEh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB1374.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 04:58:00 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 04:57:59 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: stable@vger.kernel.org
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] serial: core: set missing supported flag for RX during TX GPIO
Date: Thu, 25 Jan 2024 05:57:07 +0100
Message-ID: <20240125045708.536-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024012243-scorch-bundle-08dd@gregkh>
References: <2024012243-scorch-bundle-08dd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR4P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::8) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB1374:EE_
X-MS-Office365-Filtering-Correlation-Id: a592beea-cd88-481b-a3fd-08dc1d6233d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kR1xni04Cb1Kf+xMR3PtGvB/o2UINQbw5pntW9SYFwss+AbbTMWMYl2DPk4f8FgPQNxtvqby6RsJW/uDkG3vBHUCRI2SdxfUsGL6lw5G2M7+iHoQ6Ah4QIw0J6CrVwKz1GLgmu3Z1hRnsBOj4ZX6+MW7VuFnJEeVthQ/CmVaTZ6/Trwsem+qmlVMF7qB20piFvHBql+bp0VkvaACbL0lnHTKfoAUa9HCmdhyfQ7PmPAixAsmVS5YJ8u5JFKItVu1shSqIS+Jj3u62jeMDWkuREmJGznkaM2taD79CA5BP/0Ivhdp7/VsCBYWxsfkhAVOR/0OTTr+2lYN2Ns0/RcqHU+v/ui5KlQDKyG9OXByM6TMY/StcPIq2cxQmSEqsITJ72TNGqTIUH9s2e1KJ0zeP8nuxCKQ0Wv6aqQYEwPZ5i62fS8CZFWurLD5m1yt8s/fzyn9umvY7lj1D7J86tzPiRw4PEzUTM1AQrsj3LckVEVjSYDBncDL5XLR/YbcDgIm5sYuXqubFTyLYtSJqt9qmKmvg0If6Y5c3Wana7Q2OIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39830400003)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(1076003)(2616005)(966005)(6916009)(54906003)(316002)(36756003)(52116002)(6512007)(6506007)(6666004)(478600001)(6486002)(38100700002)(66476007)(5660300002)(66556008)(2906002)(66946007)(86362001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEpGaWs4VXdtVUt4YkZ5b3poYUc1S0hUWU03ZXJCYXlObzlFVXo0WnRPL3VT?=
 =?utf-8?B?clhOck0veFhkV1NhNDg1NGphUEEwTlo0MkExMzJTbGFYMXRxSlVwVzlKMHI3?=
 =?utf-8?B?UzRnUWtvYTJtTWdKM093dWJtUTdwWVBmSzBLUG12NTVTNTBQUlhXeFc5YTRx?=
 =?utf-8?B?TXdQSTR1NHlzUHBiY0g3anluTmtYbG5UN2dlVkdNOWpNMEhIZ1BTcmlLTmJw?=
 =?utf-8?B?R21jL3hJb1V2b0FRSk5ieDd6ckQ3QkM2QmVKcXVIM2ExLzBmZzVtaittVk9k?=
 =?utf-8?B?WGtpekFJa2VnaXdyY1lTY0I0dkxFTDRJTkdROEpNK1JZeE85bUdkajFIZG9i?=
 =?utf-8?B?bmpxZ24vTTFXV3J0N2xCNUNBNVM4SzFrWnBvWmp0NUVzSFl5OG5rb25ZejdH?=
 =?utf-8?B?clU0MmNTRStJaTJaQmg2UGtibnVsSHQxRXNMS2I5bkRFbm1lTnJkY2ViRjlo?=
 =?utf-8?B?TmxYUWJieG5hTWp1MTRtVTdYVkhXWGhVNDdDVUJsWTFzSHhraFNJZnYwMi92?=
 =?utf-8?B?aFBwNkVyN2NHMTh3bmdhOUx4Z3R3c3dyVUk3eXlES0NHR2dFaUhPVUJ0Y1py?=
 =?utf-8?B?MDNqam9hbEVWS2FwV3NyK0RzNGd1OC9iUHpSTWZLT3FWYXRpa3Zzbk1IWFdn?=
 =?utf-8?B?V2IrVWllcmVOYUpqL2MwNmRuR0FWK1FVWndGMWZuVTVvOFNlZTRuUE5rb1Vy?=
 =?utf-8?B?TTZKdTIvME9mVXVkVGVteEYrZVgrdUtKb09SRnRwdWRZSUtHc2RpQXAvSHFv?=
 =?utf-8?B?emUvYjNjYWJjR29mSUJSVlFJYmkzaE1GQmdyeFN6bitWTzE2MTI2TFBuWVJ1?=
 =?utf-8?B?VWVxK0pxYkJaMURiNmpWQjRMOWllT3owV1ZoMW5wMXE2UU9WazlkbzhSUjln?=
 =?utf-8?B?anBnYnZUYlgwNHBaNmpWVG8xdlhiSXM2dG5xbW5adzdmZ0Q1dnptTC9tYmhC?=
 =?utf-8?B?ZWlsNU5FU0Uvb0Y0RzhEdWRDeXprNElwckxoRHVZV3hSYWNiWmovMG9FcWlh?=
 =?utf-8?B?YzJLV0pTWjdtelZEVjRhUmpndlNLdnVrUFBBWUxDdTlQZkUxeGxPN2d1WTU5?=
 =?utf-8?B?a1JrUHJBaytScmRTZm1rWlk0SWNuOHZYbEwzL0VhR0JRMStFSFBPek5kd2xq?=
 =?utf-8?B?TnN3a1o4RE91ekc0WDNPay9QalpRWEFqbHN3Z3hDMStQcHFJTU9IVGN6dGlL?=
 =?utf-8?B?Z0dBUmp5emVYdjZsL0lmS3lQZW8zdG5VSW5vOHplOXJIckxOclE2M0d4UTVi?=
 =?utf-8?B?WUhIRnBkVXl2ei9Wc2pSUk9NY044cmJ3R0lxTVQycUxSUUJWb3psb3U3czZ0?=
 =?utf-8?B?KzZETFBLRUNQMlcvYjJBMVVJT2RQSllGQlJoR0dhcmk1MmlCeStNTnNuNUxF?=
 =?utf-8?B?VUhRd0FVblRzUU12UERsWmQyeWs0N3VLMzJLZitvM1JxV0JRbWsrTWpFT3NL?=
 =?utf-8?B?K2t3STdsTlZOcTRXTjAreVArN3o2NUtpeHVRWDJSTmhDTWRZbE5iYXFDZEVP?=
 =?utf-8?B?T29Za25kN21FMURBNUpaUFdPc093S2pyQXc3MkhaN20rUEI3bXM5SjdLQlN2?=
 =?utf-8?B?Vzg0ajRObHh0MmZrdmQwbHFOdkszTUQ2cW53WDZYRFZFL25pSG92RHd1Z2RY?=
 =?utf-8?B?dXR1ZzY4d2dKRjJ1MGIvQ1dXclRvNHdVS2V4bVlSZkI5ckNsN2g5aE11VjJ1?=
 =?utf-8?B?S3h2VWxQamFWOFFpNG5wZ1NabHIxcWZIenJhbDh4Zm9aZDFtQTkzZTVBMmFx?=
 =?utf-8?B?cEdDMVBUS0RncytZVndkREZKd05oVDdNOGhucjV6TDkxUG52VGdjZy95WDlU?=
 =?utf-8?B?dWNIdmhEYWxtampKL05yWEJydW5UWit4YXFIeWxJWXBoYUFzL0pCSGxYaUYx?=
 =?utf-8?B?ellMNStFNU5ZSjUrRktZS2lXdU1IWkdKYTNDbkRLamNxOTNSQzVUTHhucEhV?=
 =?utf-8?B?VENnalFsS2g4T2dLVUF5TzQ4cXBvY1Uvdkx5VkNwVXVmc1NRTzJydCtvbHJJ?=
 =?utf-8?B?clN0dDcwYTlJbm8wYkNRRWdBQlBYY3k1Q0FQYkVOUk5uTkU0UTNpb1IwY2VS?=
 =?utf-8?B?MWpDSlBYd3lvTmxGb05QakVDZXZoQ0c0UWFtamVwRDlYRDBEaVc1U2NqWUhV?=
 =?utf-8?B?QmR6Nkt2UDNDMXJsRjRBUVRJZW9BWDVDK3o1dkpWbzZObWhXMkJrQkYrbE0y?=
 =?utf-8?B?TWdNNDQxQ3JwcXZxRDBYM0NTMEgwWlB3YXAwKzZxZ2x4cTFwcHZGQzM0UUZx?=
 =?utf-8?B?c2NhQWNOSVF4RkZyeTBjTnlPSkNnPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a592beea-cd88-481b-a3fd-08dc1d6233d2
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 04:57:59.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM5BaR7H3TaThRRH2VpX8twdN41y2IqPKaJbO8HX54vUyF3pzhoAYzMzjiwniaT2TLS6rnrlJ1t5fTUduL9RtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1374

SWYgdGhlIFJTNDg1IGZlYXR1cmUgUlgtZHVyaW5nLVRYIGlzIHN1cHBvcnRlZCBieSBtZWFucyBv
ZiBhIEdQSU8gc2V0IHRoZQphY2NvcmRpbmcgc3VwcG9ydGVkIGZsYWcuIE90aGVyd2lzZSBzZXR0
aW5nIHRoaXMgZmVhdHVyZSBmcm9tIHVzZXJzcGFjZSBtYXkKbm90IGJlIHBvc3NpYmxlLCBzaW5j
ZSBpbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NSgpIHRoZSBwYXNzZWQgUlM0ODUKY29uZmln
dXJhdGlvbiBpcyBtYXRjaGVkIGFnYWluc3QgdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBhbmQgdW5z
dXBwb3J0ZWQKc2V0dGluZ3MgYXJlIHRoZXJlYnkgcmVtb3ZlZCBhbmQgdGh1cyB0YWtlIG5vIGVm
ZmVjdC4KCkNjOiAgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+CkZpeGVzOiAxNjNmMDgwZWI3MTcg
KCJzZXJpYWw6IGNvcmU6IEFkZCBvcHRpb24gdG8gb3V0cHV0IFJTNDg1IFJYX0RVUklOR19UWCBz
dGF0ZSB2aWEgR1BJTyIpClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5l
bkBsaW51eC5pbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5m
aWxpcHBvQGt1bmJ1cy5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAx
MDMwNjE4MTguNTY0LTMtbC5zYW5maWxpcHBvQGt1bmJ1cy5jb20KU2lnbmVkLW9mZi1ieTogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KKGNoZXJyeSBwaWNr
ZWQgZnJvbSBjb21taXQgMWEzM2UzM2NhMGU4MGQ0ODU0NTg0MTBmMTQ5MjY1Y2RjMDE3OGNmYSkK
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
LS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IGY5MTJm
OGJmMWU2My4uNGE3ODNkNGYyOGYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMzYy
NSw2ICszNjI1LDggQEAgaW50IHVhcnRfZ2V0X3JzNDg1X21vZGUoc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCkKIAkJcG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8gPSBOVUxMOwogCQlyZXR1cm4g
ZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkNhbm5vdCBnZXQgcnM0ODUtcngtZHVyaW5nLXR4LWdw
aW9zXG4iKTsKIAl9CisJaWYgKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKQorCQlwb3J0
LT5yczQ4NV9zdXBwb3J0ZWQuZmxhZ3MgfD0gU0VSX1JTNDg1X1JYX0RVUklOR19UWDsKIAogCXJl
dHVybiAwOwogfQotLSAKMi40My4wCgo=

