Return-Path: <stable+bounces-245401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PAEJtHPAmq7xAEAu9opvQ
	(envelope-from <stable+bounces-245401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:59:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5551B613
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C23309E865
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975F34753A;
	Tue, 12 May 2026 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JwFmHzHD"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010017.outbound.protection.outlook.com [52.103.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FA357CE4
	for <stable@vger.kernel.org>; Tue, 12 May 2026 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568714; cv=fail; b=uXugwGnPVu36k0PZnWVQbirIWxxvxLBXaqdl38gxmKATq17bkgqPIYlhDkfdwzLM2HK+IUKSrtfJHC8CjrCIxdHXU6iH5E5erH25cc0KCoeSU+tIc0KYwqVzE99aqUbv5DlskbtkI+KmmqgJfD+fmJ/HjiGUjCy9Wo4QXElYSgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568714; c=relaxed/simple;
	bh=bYLifP1ZFIBBbrjZZQ4rG1QCt3cqQdkvNjF5IV3noR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEnyiIuWcRwv12qV3D6ob2S/BYNobhKbZSFKcYOtxASeyd6tSBHN0bYGJjfMeGrsS9FHur3Cwvp8vZxvQYyjw29IpPeRvO0icjOp0LfMwpLkrjnx9prpZ1KIBdSfj/69QoqQYmpvI6boTdjBlT8I++uTuOV5x/AOcVHWBAyUq5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JwFmHzHD; arc=fail smtp.client-ip=52.103.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+gPrckFOHF9tL7pwaEcl9O+5rY0Awri8fsg+Kqgg/mUPjnLJAyZw5Hbt/liqxjmsgYZ6VkK3bTNW+teFBGNTqL7zY2cCI7PlUKJCapnSKcLeOaANpr2SyLkD1SPWhzQ6NX0gAA7q7qy90u9e7hLdVf1r+jGbyfOeBI5VY6rZVCuyNBgn4wAZM68Dx3/zZ8FqiYC69RbGgpgJPsI+Z3K0oOZuxtPiqoXegO9Pq5JrwCYJBX5RS5ywirMoA6k/TCga3C5uXpLa71s8EV1QDP+yZdEgIfR/gwpmisSFDTPKywKbsHJRfMiVnDpJ604a5xgQMxu/sB7f/ajdME1sxznNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJqC4TvW67tyCNiepssQ3k5gqggN1N81q/dX/+rLJg4=;
 b=UnevJkWSormZe+ktAiVADmlU4kuhCPeDGOZimBo2bO31WqIG9ZB05wbERRQZ3nOWSBD2d5eOtB9Gs1tztWWiiznhU5Of3O6uTfO2CCCADIkYAZg91tg10/1HuwT7/0pOmTuhjHZmJeLF+f5Gfkd1muohlIomw8o0w0SVPUIxdJCqvA+k+tncYcWDYI6GM9AzyfeG8xMnpMgnr1cPZvvb9UzDCXf3MUZg9Fn3or84Aq+V7uUtaqmPVvoSfIspXHf1hDeqDXNh1GUnXalG82fR+EiEczdoTXdL1JYuuV4BRNeCAlmCNIjYRyIAauuHQg0N7KkgVzrFgObH5Eq2TAWbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJqC4TvW67tyCNiepssQ3k5gqggN1N81q/dX/+rLJg4=;
 b=JwFmHzHDLa0dVox3w2+3jiZHELnevx0I4b7fyRxcI5bmqV/2Sjihv/KVOZ4f+JpO7NA+QZzoi2iyGb17+oCJMZbHEMUany+GqKYIZOp1QVyLN4+6ecD7oWZc3C3UmF5giG+3U0G6snGe/1r0aYUF597gp7cYvtqqIcdbUci8bILApxZ4UVvzJQSvI4J1ACu19tDtrhc3U5alkpGQmfD0aoyvJZ4DVh+Z1obuc0h5NpKzHBZtyU2I9AHca5F79ay/+Z9/fMpt4INbxOoiuIEVn9MBmS5dwf3SDuqLYQBD5p55o9oQqyInMi+XW7vaQ+U2yuJ5GidgSZ9CTOYSTtl5fg==
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
 by SY2PPFB64671967.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::3ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:51:38 +0000
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda]) by SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 06:51:38 +0000
Message-ID:
 <SY0P300MB0769CE8F2F1C39E4194DC677C6392@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
Date: Tue, 12 May 2026 14:51:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 00/10] bpf: fix precision backtracking instruction
 iteration
To: Paul Chaignon <paul.chaignon@gmail.com>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Tao Lyu <tao.lyu@epfl.ch>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <cover.1778516196.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0176.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::23) To SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::18)
X-Microsoft-Original-Message-ID:
 <db1d4fd8-c699-466c-88cc-a7b479668c90@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0769:EE_|SY2PPFB64671967:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc07f32-c71e-4669-d720-08deaff2ea3d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|24021099003|5072599009|8060799015|41001999006|15080799012|19110799012|23021999003|1602099012|52005399003|40105399003|4302099013|3412199025|440099028|10035399007|23131999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkN2WVNjNnBRdjBLQVd5bU5rNlhpTU5UMnE0V1dRcldMT04vdGFYV08zNUNt?=
 =?utf-8?B?elQzSzBjNzJrbjZqb0pzaGlweVptRDZDMndaVXhQcGVYajRBeGREamg2TmEy?=
 =?utf-8?B?cXF3R1NsYVRMem0zcGlKalVYdDV0V09VSVpZc1dPUlkyYXM5M1JJWEhKZ0JK?=
 =?utf-8?B?ZWlsalVxWmthTUtzRnJNcU9qZS9hMVRQRnllL2xScS9xb3VRSmFGb281bDR3?=
 =?utf-8?B?VnM5KzFQRFpRZlRKTnQ5b3NnUGN4NzF6Zm9NL2RRd2xrZW9qb1hUZHZKdSs5?=
 =?utf-8?B?eGYwdWlVd1huSUVMbGcrUCtKQkk3M21WZWtWUUxYdER6QWcveGE3SDF0cGRn?=
 =?utf-8?B?d1RpckFoc25NVmx6eDAwbmFFSUhseS8wZnIyK3VFV3RZUmlRcDZYb3puMy9q?=
 =?utf-8?B?bXFWY2RGUHEzcWlFMzNwRCszSFpEY3QrZktqdHhwS0tuQWVFSTRYSkwzcmVn?=
 =?utf-8?B?SFl0MGpVbE1JMEljei94aWF0c2M5QzIyY1JRYVZRS0w1aUxyZEhKbFh2bkZD?=
 =?utf-8?B?ZExvRm1lc2xLVHdTb0VmdEF6UDdtUWg3TEZXV2hzMnlEcWVEakRQNUQrS2xj?=
 =?utf-8?B?am5MOEJKSmFjRkQ0T2loWTlJSUswY1o3Ukg3UjlRQmJHM0pOd04vSEE5S2Fi?=
 =?utf-8?B?SkhrY3RmWW1VYzZxem5jL1phNVd3dGgyM2QzVGRXU01KRDk3T3pDRUdmdUFD?=
 =?utf-8?B?NnlsQ2pIQ09FNUdERm5BNEFlUGUzaE92RVVSY3RucFNTdEJia2FtOWJRa20v?=
 =?utf-8?B?ZUVvTm9vS25oSXA5ZUpRdkRFMnBxeVNZblB4RmNseWhwSlZTb2Q2cDhIVldr?=
 =?utf-8?B?eTB2aGovdER0c3B5dVBjRlVoUEtqUzhkVnQxM0tqWGtVeWZmOEQ4RTh4NlFp?=
 =?utf-8?B?WGg5U2NwSXBsSHZKZkcxMURJRmlZOEVBWFlub21PSVorOVZBbjZwdk9hYmZh?=
 =?utf-8?B?STdZUDNWSVFTMW90ZHBKUURkcGpaKzA3SUtpWENkalA3TnkzUWh5cnVZb0dQ?=
 =?utf-8?B?dHR4dzJBUEZvQnV6RGFhM20xMWVBdDE4bkZrSXVHb1lid1FmSW03VDFNZkZm?=
 =?utf-8?B?NDhWK1pLTCtBSk51TkVtRldyTzA1YXdtaHpmeU1Sb2JTWVIzd0J6d2lIUm5m?=
 =?utf-8?B?VkQ5T0w3R0o1YTMwSXR0TEE3bzRuZ2xuOVZiT3pUZ0tENnNGLyt5NThnN25q?=
 =?utf-8?B?NGhoTElZRzhBUld4dWpURi9TK1kwU0lDNHZHV3liOVVvVWlqazBNc25hU2Fm?=
 =?utf-8?B?aHdEZHNlajBxQXJubVltdDJVbWJwZzJaQ0hEZ2oyOGVMREpuRHpXOWxTQ0t0?=
 =?utf-8?B?ZDlUU3NpMEhBcFZhSWtRUlVveHV6QVBLSGN1TmRmMVpldVRUelJlVi9WQWdG?=
 =?utf-8?B?V28yQWVXVFdSN0JiKzRONXh4d2s2TWlEVTJZcElOQWRZTjJBNFNrMEdKYnBW?=
 =?utf-8?B?THhhcHRxV3hCRkVEV2FWU21mNDZQWjRWMTd0TU5RPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ai94c2lKS211THZHZlBONEE3VWdmR0l1Q2RlSzVPZG5hWHhMczA2M2tRdGhu?=
 =?utf-8?B?cEROMUVjbG82bVppYzlKMHJPT0JGZTRERVo2dTI3R2owS1lvYTBDZXA3Wm4r?=
 =?utf-8?B?eTBBc1JKZ1JFRFkwMTI3Rng3Y2w5N24zeEw1QlZFTDcrMW1BbUd4eE5PaGxp?=
 =?utf-8?B?NlArbEZjeVBFSVBqaGFKUWhxOUhnK2VpeWpoR2M4bzQ3T1RPSCtlbWd2ZUgr?=
 =?utf-8?B?K1plaDlrUHN3QVFGNnp4YWtMeXkzckVrNnRvV1U0V1BlQlYyYks2cFlDOXlQ?=
 =?utf-8?B?VVRPblZGek95cmdUaXZUS212V21rNGs5Q2kxM05PUGRWTlI0NGptU1RYRzB4?=
 =?utf-8?B?eS9FOXBKd3JZcWxzV3l1MFJ0Q2lTOVo0WG93WVpsM0pOM3g3T2VuNnRCek5q?=
 =?utf-8?B?SUVVK25rZVJrdWJnWU1keWEyMUNVSGhNdHVtYXQ4VlVJaDRjVHZYLzFCSUxw?=
 =?utf-8?B?NVZXMmpqUE10dHRrc1VUekFKTEFHZlF0MkZXRHRsUVlwMWhuR2lYZm1mRjVx?=
 =?utf-8?B?RmVLYkk4VUNHQUFpZVY1eFZEaTNFY1VtWGxGMUI5dVhyRTRQamFOUnhtb2ZH?=
 =?utf-8?B?WTh0MHFXVGQ2Mmp0QURVcEZQSVRKNU1PUWRYS2RBVnZqMWhweDVTLzhtUC8x?=
 =?utf-8?B?ZzU2SUp6WXZSbkpOVjI1eTIrZk9HRTNOZXpicVFuRWI2Um5jM0Y1QTR1eUd1?=
 =?utf-8?B?bFdielNjcHF0NlNMTzRMRzU2aU12NkhWSVVBMVNhQjJpVDZKZ1BOa3lvMHEy?=
 =?utf-8?B?VmM3L2VnNEJUcU9DOCtqUUgrdFo1NVJhR2cwc3JCZDIyTTNRUFRUWTIvVmpL?=
 =?utf-8?B?YXFKSFFmNEFkVEpMS0o3bXhvUERPS3JBVG1hZEhqK3dTdEMxWXRjcTNGWGhH?=
 =?utf-8?B?NFZSV2JqeFhSeHIxOXZGOHJJekNLaWF2NUtYSmFMRExPL0tVcFRSaVFKYkFG?=
 =?utf-8?B?OFBrK2VCVm5sU2RTb1oyeElDZnFzbXVJeFJxK0dJbkI3R0p2UjRyMFozcGpO?=
 =?utf-8?B?czRhYlVVY0swQ1h4cmQyNTFYU3ByS29QYXBaN1Q2cDk1cDZDTGZMS2Z2Ujk5?=
 =?utf-8?B?cjRqdkdhY0VlNlRIejR2U2d6SHlkbFQxYWNVbmR4VStxWllyNlhIQ0duQlNQ?=
 =?utf-8?B?UGZZbEJKNzd6dVpwZExMTDZEQzFSUG1wUnprR2VNdUp0aVJNUUlac1RmQSt4?=
 =?utf-8?B?QnJDS1d5K1Y2MG1aUzFsS2FCeFAvS0F3MVBOUFc0NXowcUtpdUhUTkY2aFpy?=
 =?utf-8?B?NHVxZW5oa3AxMTdQYU9PNW9DUCtsejJqa1JUd2gwY28rVkJaanRScDRneFJ2?=
 =?utf-8?B?azVkWmQ2Y0x1WXZncGh3cWFZdWJVd3BnOVc4ck1SeGMrMVhmR01YaFZKTWdM?=
 =?utf-8?B?bXFWWmd4SFpSZCtkTWdKcmV4MjhrTkpubGdtUlZiNnlwM0d2RzBjRTFsQndX?=
 =?utf-8?B?WUJ2TGlNQS9GMmJ2MW0zd1pIeWlVbmJVNWVhb21CVXpGRHVLSXNOQUNxcW1t?=
 =?utf-8?B?cGdqWFdSdGVuWHRYcVhNVjVZMWFtVXJqb0pIMjV4VkhYU0o4S1IwOFdzZjRI?=
 =?utf-8?B?VUNtVmd2SzlZNzVKb2djMUprS3hEYmdQSFZhaSswSkVpL3hqbEF4VytGQVJI?=
 =?utf-8?B?ZStGTzF1SVV1MWptUlNSTEUyQ0RYcW5aemNWVWQ3YU51OWtHRVY2SWhzNSt0?=
 =?utf-8?B?b1BJVUlEdWgwbXkyWkE3UWFiUHRtTnNwUzBUaXlRd1NtaVBNWlR4am5INDJQ?=
 =?utf-8?B?Z2l2RUoraUNneTdUZjg4ekJwN2NmbDBsaWZ6N1d6V3gwZXZ1UW1BWXB1WUNG?=
 =?utf-8?B?Mnd1WkJmd1Jjb0t5UzRGQmp3VE43MDJsSkxYaXpqMFRld0dxVzdkcnlmL1lQ?=
 =?utf-8?B?ZXBFSklpQjNINmtQZkNDZXJyeEFrVG0rKzAwZ2xxdDZQR0xzdmVMVTI2azhh?=
 =?utf-8?Q?EKn1z703u8gROCur3J6PJ6yg6muNDoxB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc07f32-c71e-4669-d720-08deaff2ea3d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:51:38.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPFB64671967
X-Rspamd-Queue-Id: EED5551B613
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245401-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rsworktech@outlook.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Action: no action

On 2026-05-12 00:21, Paul Chaignon wrote:
> The first patch in this patchset was already backported before, as
> commit ecc2aeeaa08a, to address CVE-2023-52920 [1]. That backport was
> however later reverted in commit 199f04528737 because it reduced the
> efficiency of the BPF verifier, to the point that it rejected some
> previously-accepted programs.
>
> This patchset backports commit 41f6f64e6999 ("bpf: support non-r10
> register spill/fill to/from stack in precision tracking") again, but
> this time with the subsequent commits that improved the efficiency of
> the verifier. In addition, the last two commits fix and test a
> regression that was later found in commit 41f6f64e6999.

Thanks a lot!

I can confirm that the reproducer that originally led to the revert 
could load successfully
with this patchset.

Tested-By: Levi Zim <rsworktech@outlook.com>

Best regards,
Levi

>
> It took us a while with Shung-Hsi to come back to this because we felt
> we didn't have enough test coverage to backport this. That changed with
> the stable BPF CI Shung-Hsi built for v6.6, which successfully
> validated this patchset [2]. In addition, I tested the impact of this
> patchset on the verifier's efficiency with Cilium's BPF programs [3]:
> it significantly improves, reducing the number of instructions the
> verifier has to analyze by up to 87% in some cases!
>
> 1: https://lore.kernel.org/linux-cve-announce/2024110518-CVE-2023-52920-17f6@gregkh/
> 2: https://github.com/pchaigno/stable-bpf-ci/actions/runs/25671397661/job/75357317078
> 3: https://pchaigno.github.io/test-verifier-complexity.html
>
> Andrii Nakryiko (10):
>    bpf: support non-r10 register spill/fill to/from stack in precision
>      tracking
>    selftests/bpf: add stack access precision test
>    bpf: preserve STACK_ZERO slots on partial reg spills
>    selftests/bpf: validate STACK_ZERO is preserved on subreg spill
>    bpf: preserve constant zero when doing partial register restore
>    selftests/bpf: validate zero preservation for sub-slot loads
>    bpf: track aligned STACK_ZERO cases as imprecise spilled registers
>    selftests/bpf: validate precision logic in
>      partial_stack_load_preserves_zeros
>    bpf: handle fake register spill to stack with BPF_ST_MEM instruction
>    selftests/bpf: validate fake register spill/fill precision
>      backtracking logic
>
>   include/linux/bpf_verifier.h                  |  31 +-
>   kernel/bpf/verifier.c                         | 233 +++++++++------
>   .../selftests/bpf/progs/verifier_spill_fill.c | 281 ++++++++++++++++++
>   .../bpf/progs/verifier_subprog_precision.c    |  87 +++++-
>   .../testing/selftests/bpf/verifier/precise.c  |  38 ++-
>   5 files changed, 557 insertions(+), 113 deletions(-)
>

