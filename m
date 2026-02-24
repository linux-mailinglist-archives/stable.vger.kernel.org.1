Return-Path: <stable+bounces-217881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD1pJTBZnWlzOgQAu9opvQ
	(envelope-from <stable+bounces-217881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:54:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7B183558
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1197302330E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046892DFA25;
	Tue, 24 Feb 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pAuJTNib";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Vkg9hQz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84930BBBF
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919621; cv=fail; b=X7aQOb1ygVzplbe4JDxQn3UaSGb0tSqVX7tRfJLwGdS27liXfxN/auPR35dXzYDGWU0M20Ac+wGhm/+/zOdR0bhNzG0ZqYfyu+cXnKUaw7Xn5O6u1EEm7WbTdD577l/OBXuQnfUytvuM8DPc0GR/zAuRpv7mzIAuqtyI7hg9eQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919621; c=relaxed/simple;
	bh=kBpow91TfSNDMyAnmegWp4wEs37td8+7z335P+wtXF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=joRxV/VzzzKR9dDS/F0ZMj0Xh9wLJO6byAtldkkNyU5RAWjyRZWaeTb+vgeNGO3CN5VN8QOU1VuuEzOMATG/Nq8JzuWMPIVYJA3vWCwqIvU2ZkPvI6iA5Mk8JeABgb6Mz20/wiC54fUSTRohhejs+jAOr2rssy4hsR6S+DVoNig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pAuJTNib; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Vkg9hQz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NMv9uA2584915;
	Tue, 24 Feb 2026 07:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HK2Id1YZuPWjaB9Ucy8vXWddk9wcfcLNgC0Y3TrpsbE=; b=
	pAuJTNibhFjbgGrMn62OlYT7haW+wMCQ6qVOW6dkRBGP7+xuUFm1VpsK9TOm7tkH
	x8TVUwSX0ZdgMjdOOtJH3qOVjU1xKNdDCHgt+uZSEH6iO+ZF8cbWTxJynQqZtGgp
	XpcM6g3VQfk29DMQ2Ga3GwB5j5QrCLGvf4rzgF9+htL5VdWNfYDYmZqSVfSiV/r2
	1A/Zmk8Kd7fkbh6Pve6lTnhqBQFOigXNmVh8AavtP8b/1vFCDMNeeSIVyfpNrnYp
	6QuG7smPNFsK5PEmprCtKnRwqmKtUljS1YffqE2iDYjtZWw6ZOtg7mlsTf8NapC3
	cJfhnev1wvL4xCOn9rG5vA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7ur8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 07:53:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61O6KHSS006450;
	Tue, 24 Feb 2026 07:53:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf359nc37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 07:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMcHqv9TA8l3DXAa2YuBTlp8sX7bhJWX7B6mlpvq11JMBz4OFWxqXKZlSRmbLOG7QaZdrcOQFg1faxWUIMYxC4yncTLtvZFoKy5yAWz3sJpjY6Xe8zIOHm91juyDhdx+nBRb9g9Q2L4qf85AoluzxQdFyDF/rNKIlOS/eulzjd9KXzBl1/xT99FDKrsDZUrb8ACEyVxemmsS8+eWWzWPLZPhY64sFotRLzfB1HrcMlRbeIRjoap9IW5ncebZlRr+qL2cZ5cYZp15nMg20XPJqxOHEUT/cvn+yd6wMDDtG9KeV4jkmFSzmErDvtxQzAJ4q5/vopHCkK2Al2FXzUDMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK2Id1YZuPWjaB9Ucy8vXWddk9wcfcLNgC0Y3TrpsbE=;
 b=ISIlRlaXycBqq0HjPeXN2g/C32v5FT+wtzIM5Bmgxvbtvmtp9uGg0PVKmMe+fyajO+rwz1RCwii7OK4IVZjjRQllaCE8GZY2Fn8xWTSikpLth/VdPmvh6Uh0xPDMwD5HvJ0UfgK/abFP6cpxbJmYtxUO6E5jgY1QEY19ZfTsDgH8oY8Poi27UyAvEIkDLEYaDilzWaca2n9lWodHZP7qCGM6wnS40hl5kgCgdIqWYJyvHOvBHY2IHdl9bEtRHQWwF/YaCRYQDOq2akTlvzU5SI49AqAhApWKRR8u6BaGWGBVksAhGFSiQ/OtwTKgbnEqovOkQKITw18tTIWlLlrWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK2Id1YZuPWjaB9Ucy8vXWddk9wcfcLNgC0Y3TrpsbE=;
 b=0Vkg9hQzoZBDZ1wonZmhX+UGmz15Eft4aRRnHaJXiWi7JLpha7DJmbna3RBq1Ip+sCPpYkWWqj9ttudHHKYMraYSAHYcgb5QYFeNFgXaclEqsedD8bR4ewTpkw09nASndHhOkPZNg5w+LjV0NshMIcMW5H8xhX4mGJpqfFbyQ6A=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DM4PR10MB6255.namprd10.prod.outlook.com (2603:10b6:8:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 07:53:34 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:53:34 +0000
Message-ID: <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
Date: Tue, 24 Feb 2026 13:23:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/5] Backport selftest for "bpf: Check
 skb->transport_header is set in bpf_skb_check_mtu"
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, stable@vger.kernel.org
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260224073810.85945-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DM4PR10MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: af133085-828a-4ae7-0126-08de7379cfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2pteUxIZnV0VTVzUFVONE8rUzJhRnpZeXFwQzN2RmQ0QkJhWlQyYWd3RnV0?=
 =?utf-8?B?L0djOE1waU9pNTNzeUFzV2lkRDZ5Wnk4d2ZjQi94K2FoQ2ZKV0VOQkdpaWFZ?=
 =?utf-8?B?TlFGVmo5MDZhcUFOOWN5OHhCU3V1YkNHOTJNSnlFTjlOajdQTFpnNkw1UU9G?=
 =?utf-8?B?U2RscVJmYlRackhLZytVck5lQ3QrVEJMaFN4N1RQY1puMUdxSTlVVkRyc2sw?=
 =?utf-8?B?MjdDZjhualJkYnNnQ09yWWNkcDByd251eS9OWk93VWNNYmdET01RRHo5bnBI?=
 =?utf-8?B?bUx3RWxSSXRkZDFDVER6V0NEQVZYenlIUStIZlZmWFhrTGthUSs5aThoanFX?=
 =?utf-8?B?UVIwUjNSdkk3ZS9jK1JoNm0yVnBhOGpvWnJSMGpUT3ZMcnlYWWNjRTlpeDdz?=
 =?utf-8?B?cGE0dDI2M0NoazNmU3BHajd4Y04yRVRsb0ZiekVVZURRbGY2a0VFVThSUlph?=
 =?utf-8?B?SEQ3T2pYWWFKUXNldFprcDRndjhvV2JRNnBzT3lsL01PYWdUNndQK1JTdzRT?=
 =?utf-8?B?aThWdHJwd2ZyV0RkaVlGUVgwUnloT0VKOCtsajkxdVE3QmxTM3owdVN6TFJw?=
 =?utf-8?B?Q1AxNjdUVFh0TVhyeGx6Qm0vQy9KbW5LN0NNdHFRSWRGMG5INlN4L0xoenIr?=
 =?utf-8?B?NEpOeTRGL3NGMlRHSms4bmhjdXBWb3RjeGVSMVhBVHdGdHZRWmFZR3RrQkli?=
 =?utf-8?B?cHVlVlB5amhmMDVqU0pDbGpyNjZPeTBmNjFscjYyT2hyZ1lhS0JWM2pNcG1h?=
 =?utf-8?B?Y2pmN09mdzJ6cng1WHRjOWVMN1BDbDRFNDdpeW1UUk5ZYmlDOU5LU3ZwS01q?=
 =?utf-8?B?dW80MG9mZG5FOTdtMm5ZNDB5QmhMeDJRdnJoVi9ySFlmVktaV1Jha0lqY1M5?=
 =?utf-8?B?Z1BBYWJiUEU0Q3d0TkI3YVZhY1c2WWpyaEhPRWZyVDNqVDVaTlcyck5lNWJ0?=
 =?utf-8?B?ZnlJcTJOVFpZQlFvK3J1dzJYTlViSDA0eWR4WVB4cXcxTEJ2Q0dia2pHdFY1?=
 =?utf-8?B?R2FLTk9lS0xXaXVzbmlqWHJNUU54amZGWEQveWdvMmZBZlo4WFk5aW5PWmtz?=
 =?utf-8?B?SkROL0YzNkZUS2tsakJlLzE2bWxxZWNSLzVJWndTaHFCZERoMlJRM1JXaEV6?=
 =?utf-8?B?eW1DbVlTRy9HanEzM2JoUFNpRW8wckJrV0JuMW9TWTYxT2dTS2UyRGd2ckhV?=
 =?utf-8?B?TnFzcU1OUkVrRkJ0UU80amIwMmR5TFNrNFVlTVVIcFFWcHFuMHkraTQzYUdI?=
 =?utf-8?B?a0FsL0hpUlFNQ2tjemdRcE5aK3VpamdXNWFIVkF0TkQ2NWVsSFhCSnY2OUJ0?=
 =?utf-8?B?V0hyVUMvTHkxREVQUEx6ckJ6clNES3cwOTc3djF6Q3owNmcreUNuTXVYalY0?=
 =?utf-8?B?Qk8zUXVOT3pualVab0gwN0JRKzRuU3hKYlU0QjJuUFlWcnpFSEpLb0RNdXpZ?=
 =?utf-8?B?VzJ6b0tXcE1QR2RjcHpxUTBKSk9KT3k1eUdJQlpGQXEzUGxNbkRxTHhtT0RW?=
 =?utf-8?B?TnVwZ3hyZU9pU09BbG9JeWVSVkZyczk5ekJUeTVwUFVFclRlZEpDUjNoTVAy?=
 =?utf-8?B?Q2Jnak5VdG92V093eTl2TkF1aER0TEZ0d0dCbWhSTjN6TUFRY1liMUliRjBX?=
 =?utf-8?B?K2Q5R2U4RUNzQ3dQK0FYSTFFenpsbjhHM1ZydHkwRUZKUXg4bzlRZTBNNnRH?=
 =?utf-8?B?WGVDMjY5ZCtTYm85d0hBanBtbkVubXNVTktxQlZjOFV5SXRFUkJIZlJieW1l?=
 =?utf-8?B?QklJSEc1anphY3FURWsvVDAyMm91b3dXaGhEVklVT1htYk1WUkk5MnZ1NThn?=
 =?utf-8?B?SEVmcVRsUGZ5T0drbkQ0QVp6Q1ZuRDRvS3dmVHRPek5TQk9lVnVzVHd2Q1d1?=
 =?utf-8?B?WjRSbXcydjJST0h6bkk3U2d0b0VCc2Ivc3IxT1RlWE5TNWEwMnc3WDZpbDRK?=
 =?utf-8?B?dTQ4akxESlBsWGhoVThwVDdpVVNNK2JMTDBNSmRpUFhvN0hoblBOUEt1S281?=
 =?utf-8?B?S1lOUzVqQjZMNEhzRTg1MzdpZGZ1T1Vmak1XSjJYNFA1N2h6eUhBOWNPdGNw?=
 =?utf-8?B?UW80U20yVTgzLzBBbnlpNUpxRVR3R0x6bFBNK0JPTmlUQk1BSjQ3MG51a1R0?=
 =?utf-8?Q?fgK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUkxSjJXTnJGcm95Zk1mbHpSUVMxWEorRmNrT281am04NDBvMmo4SUp2c3Yw?=
 =?utf-8?B?Zmk4ek5tMTZhTzRURXNBVjREbURTTTgyMEZSOEd5ZmJNQjk1aDB3N25KdWZ2?=
 =?utf-8?B?eVBGSUVuT2QwdURGTmdkS3FUcDhtUmhXZk1MVXFlRkJJdnlqaGl5eSt6NWJG?=
 =?utf-8?B?dElvbkVmRXovTEQvWEkwS0d3d1lMTTZXSSsrUUVQZmdobytzV0YveEVTOEVi?=
 =?utf-8?B?RVhPN29rZTBCMXFRZ05XdDFIdFM2SjN6VGx0eDBDQzVTbVU2Zk9Tc1kvUnZJ?=
 =?utf-8?B?eUc5MGxuZzBXTlNCNnFibEhxWGpQU2k0WGpLRkFCL1p0Znc1TDg0U0h5M1h3?=
 =?utf-8?B?MExEQ0RwbTM4QStLSlhicUZrczRHaE9PNDc0UGxUY3FDWGNPY0s3SnJRWGtp?=
 =?utf-8?B?UkgzYTVoK0pVVlNJMVBrcEN4VHNXUXRVOUs1WVVSK3JwZFlkL01WeGFNblR2?=
 =?utf-8?B?RDZGUk9obmdESXBPYUZFd3k4RUl1U09uT1pPKytpUmpLSCtSanMvV1NLS05h?=
 =?utf-8?B?d05QaFZOVEsvTGJXWGo1MFVTMGdKSGdKaWJYMlVFRjRzTUIrNDZlNU9nRkdV?=
 =?utf-8?B?QW5WUlVPRldGMEdiSWpLVmdmdVppalB2bGFLWWtsNVhUYzU2ZktuRkVXVXdl?=
 =?utf-8?B?ZS9kaFlPZk56Y0xTRysvK1AvZVBrdDBkUEZ6ZEduSlVGUnN5Q2oyazMyYlRo?=
 =?utf-8?B?aHhubHJGVG8zSFA3N3U4YlJmdmtPWWo3RExvSWJWczlzUU9YK3Urd09IZjdM?=
 =?utf-8?B?NXpwQWcvVHlrek5WMTNBUFJUeDg2K1Bld1h1dW5CVTc3bXRlM1BVbkJEYnMw?=
 =?utf-8?B?L25QTWtGSklBbStOTWRCRFo4NW5tLzhKUVFoR3FwM3pTQldVbWsxcW5Xckxr?=
 =?utf-8?B?K0cvNG1zaUY5MjlacWE3YkJVRlVYZXRDQVk1RkVzK1YzUVQwVXg1dTF1WGhJ?=
 =?utf-8?B?b2J1QVNjVFViWDQ3R1gzcVRrUmlybXIzR2QwYi9GQVJ2NHRHYWR6dks3aUtU?=
 =?utf-8?B?QUpVZDQ5UVIvTTNRTEtWWnB4VzA1ZGhEejlMcE1aZTJhMW9NekYvRUd2c3pJ?=
 =?utf-8?B?c3cwWUFjTk5QY2syV3ZVcjYrbSszOCtIMkVFSmE0T2RvVHphMitPSkNHRkI4?=
 =?utf-8?B?NWc3dTlwbTgzSE5Kbk00bisyRWcvb0tEK2UvOWpKSWxZWHJRSk9lcWdqWnhF?=
 =?utf-8?B?U1VjKzl5NFJOSmtRV1FtQmtXeXk5MGROWW1VdUpuU1h3TWhoWWZTZWJpaEIz?=
 =?utf-8?B?NGpOOGE5eE41TDE1WG1MS2NNWTZIMUhjTzNSYzMzRzRMakMwTjZaaEpnWEZS?=
 =?utf-8?B?bmhHc3d0MUg2Vm5GM1Q5UFRYbnZiSWVuV0o1TnZucm0xeUVROWtTUzJlUmRT?=
 =?utf-8?B?cXdJNXZzTzdHZFk2bXI2ZEgrTjU4YTFxaFlmV0pTYWxEcDlsZG9RdXdrRW5G?=
 =?utf-8?B?OCtmNkZkVDlNd2cwN0lFL0lVZzllcWNlbGY5VkZnWFlpTDNnTVM0ai9iYlA1?=
 =?utf-8?B?TG91S1dxTEwwRkZEOVcveFNkMExLNlBIcW1Qc3drRHgrb0xHR2RKR0xBMitl?=
 =?utf-8?B?ZUxjVFpxekFDbnExWHNMTnM0SXBmTzgyd3N2TGJGcUlLWElPVnRINnRMSFFx?=
 =?utf-8?B?Y3dJRGFxUWU0aW0zTHZEK0laRWZwayt3NnpLeGNMOWYyK0FBa3lIZXR1OUdO?=
 =?utf-8?B?Rk5OYnBObFRmbkdUV2EvWFY0dzJuY0tPTG1IL2R4OGprYThlVEhNUjZiWHRI?=
 =?utf-8?B?NWw0UGQzR2pCcWp3WVVNVWJ4S1VxUGdtSlF1NXZqSFVsRUlsclJRNENGZnYr?=
 =?utf-8?B?a2p4b3kzTkV4d09rR3Q1WVcwWC9ENWpsYy8yeHgwUkFuMlQzb1IwODZZeDJj?=
 =?utf-8?B?cHR0UmhkYy8wTThMT25OYml1aUpqUktNdjBtM3dRRDZuOUF3SGZ1NXBLY3FD?=
 =?utf-8?B?ZlI3UGUxK0UxWElKbDFHZ0dlTFJiU1hXcDRNSktqUkZpK25VMEVBQU1qZ0Nw?=
 =?utf-8?B?b0toeUxGdGNZbnNOTUZYaG5yOHF4T2RUK1J2M2kvaHd6WkpaQ0M4Nmg4SnNJ?=
 =?utf-8?B?c09rQlBDKzgxYWd2WFo4T2ppV09YS3ZzQWl3ZFVhYmlvMGxNNkdxSURwK0c0?=
 =?utf-8?B?cU9QK0FueUNXZy92MFRGd09tTjZsTmszc2FEazc3ejVTZll6SEZwM25lMFVx?=
 =?utf-8?B?Slovb2xLS1pHdWJ3aXdIenhiNVo5REVMZUN1YU41VCtoK21La0RoMGNsc29u?=
 =?utf-8?B?b3g3NVQ0R1p4M0ZSS1RrcG5zckE2MmV2eWxmRW1USGF0VUdCN1lBUHVkaEVw?=
 =?utf-8?B?eUlDd0MxNWw4RnVpdTNOWVoyRi9lSERzeklrL3BOSXNHN0lOcjh1MVNSYmtq?=
 =?utf-8?Q?QK1vDuWVFd59qZBHAZExF/zSIbvaXAkzQ4o0I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	224rFQj5lCglZBY0CCEdWOYoJ08HpHf3vMwFa812F808w2bhv/zHwhHa/YfFOnF//1CslNn0xqxj5ZuSP6qK2oIRn976oqc27jU6prS1tb1Cz5XCJot8gm/WMtpqoa3nvxnfSxrpPeHca9AxSGfeBNK2bfejtnz8wO51OsaFJNqxP7bUOwtoMK+BZwjEMbYJZjQ4IX2bmtXbc5O2jAWe/8j689okABzoytZtfrxtnIrJICcBqSbdHSJ9rgPhM5V/WyCcrvygfguVw4qE/Cp1ZjV1QGo3yIn696/T7ba2ckCcwC1/LKm1KW4ldMFQvp8b5/IyZCaP9L+qISP1+o4MQhScAf09C83yWILqEzD1u9k14iNuS9xqPJIXSgcM4MC15H4p8g63X0JF2sByn2Li2hdZGP+MKqmVXX9GNheAeFbaPqro2R+v5Wo4yksq3e9Yd4xqlHPwcXz6fxMp1+Ysq6T3m19lrDo/lKT/rmYPcoXucWlPkNt9NBSe2XGzJeZED3pR4mHuJpuBQiQt+bskGKBl6BRLUv7PegpJl6Z5h7/r2rh6klFCYqH0dJsNLSipLRB6n0jOSnTZLTa5/HpmqkQyv2FXE0C9GW2CtVeeiJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af133085-828a-4ae7-0126-08de7379cfb5
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 07:53:34.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muO4mkSEzeSzZRwYiLedY/8tUqZPXYtATSXEWT5tePwyLl61/SDNtjWqgfO2dF11hsD05J6euyDTONCuyqG7JmGw4M3z486etjSeXam3l0IUgDFS+7dN97sqv/IZRU+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240067
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=699d5902 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=1iUlYxg9ozmVHI-Z85AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: kO8W9TMhG5iI0OPppxFxUmAjwK-qyPWq
X-Proofpoint-ORIG-GUID: kO8W9TMhG5iI0OPppxFxUmAjwK-qyPWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2NyBTYWx0ZWRfX0AitVNOY2h2r
 lqs1+iGPI3cEfl4GNwtGlTLJ5vmo4Jn8NlfeBeLkzObzwaNUjVJz+dIkRehBlzJeJZVTtL2qdLf
 dFMA5kJqGiVrBE1tTSZQXxo9vXtTWiSpOv2vZQznkcbh8ZFZizULbpYmDS44W+RRukKekbHjXf0
 si8lKaC73oTcLq91jgAgHnV+p1Hen6jaJlQAEAGl/TpQLybbvvpuZNMvgEorX2ZM3JApmRAXtEo
 V+mx5fHaA3Q9/BLAAmQ02v9nU7e2LQfO5ql72Ob5TpFt401UsIKE5rcgtDakcUfJDOjPDBEwH7E
 4+lsLzQa6KdZIXHn2jLkxJEnoWSUq6JZCbI99IeZDu5jpX6rHsm08qSEw+uMVQwtTT/WoOoByai
 dthaO3nFCDcg6fOVEAO50yhAssnnVcwL5mEl8NZ/GNxOaf6X4JhJizJVL1vtki7vMrysJqCJDzG
 Upv0LWdqynlM3PvRO5Q==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217881-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 17F7B183558
X-Rspamd-Action: no action

Hi,

On 24/02/26 13:08, Shung-Hsi Yu wrote:
> This patchset backport the corresponding BPF selftests for commit
> d946f3c98328 ("bpf: Check skb->transport_header is set in
> bpf_skb_check_mtu"), which has already been included since 6.12.63.
> 
> The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
> bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
> additionally depends on network namespace support for BPF selftests
> added by Bastien, otherwise the MTU in root networking namespace will be
> set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
> Marlière for figuring out the dependency.
> 

Note:
I have recently learnt that ideally we are supposed to run upstream 
latest kselftests on stable kernels as well. If a feature is not 
supported the kselftests are meant to be skipped.

https://lore.kernel.org/all/a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfoundation.org/

Thanks,
Harshit
> Bastien Curutchet (eBPF Foundation) (4):
>    selftests/bpf: ns_current_pid_tgid: Rename the test function
>    selftests/bpf: Optionally open a dedicated namespace to run test in it
>    selftests/bpf: tc_links/tc_opts: Unserialize tests
>    selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature
> 
> Martin KaFai Lau (1):
>    selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when
>      transport_header is not set
> 
>   .../selftests/bpf/prog_tests/check_mtu.c      | 23 ++++++++-
>   .../bpf/prog_tests/ns_current_pid_tgid.c      | 49 +++++++------------
>   .../selftests/bpf/prog_tests/tc_links.c       | 28 +++++------
>   .../selftests/bpf/prog_tests/tc_opts.c        | 40 +++++++--------
>   .../selftests/bpf/progs/test_check_mtu.c      | 12 +++++
>   tools/testing/selftests/bpf/test_progs.c      | 12 +++++
>   6 files changed, 98 insertions(+), 66 deletions(-)
> 


