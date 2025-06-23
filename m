Return-Path: <stable+bounces-155810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65592AE43C9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D21BC0091
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1282561DD;
	Mon, 23 Jun 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="io75YFHX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A7AwL41d"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0864253B56
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685388; cv=fail; b=GWrJbDAcWxZH84aDmEuPOp7JRFg8FgLlBWBt2ZW7sezT9hjWMhv4r2CY1fDN7xU9m6lrZvuTobQyOqCFJ0dCdL84aF55eEWeOSdVVxW7ej0wMkYWV4ED+PZesZAxj0mWW8taFewIFRR45tF/DnI5N0TnDEEY4JOgpKXrNDhItdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685388; c=relaxed/simple;
	bh=dgdaobla6bGaXX3+3k0CsFLMMU9qZtugyYyi8AksRQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EWmaXokJUejUDm77l+vBc2J+HZ210z3100Ljg2lPEKH6TQ7yjDmypCLmUc3GKjnLaE3XKEqQ7VR+46Mado1cZM8qdXM0eg+IXOUb51lSdpBSwvrk0pliG5tlXcGCXrVZV2hsnlZUil2E9cf1BU60qDAStUXldlM0j1GgvwSMvlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=io75YFHX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A7AwL41d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCigfh027546;
	Mon, 23 Jun 2025 13:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vqV+4BAJq98IjQ64fKvCCFZja1Z7hImwhEhpH3cGbTU=; b=
	io75YFHXesJHLU8PXvQk2YNOxQe8lLbC+CiU+91FPh0XNzPSQtfH8z2sIRy2KTIe
	GF6zw6q48EkWfnF7GlPeHeDGRF66pQrXNtu0qH9yMuyV2OW0+DHxnUfmHXfjK72A
	Ow8NycPKr0I5jpFoT4yEFSoCGgVMKsLlE0eD+MBn5lQF7MVsPIyzgq3pR/LcuOit
	r070arl2uM3PEYmFUTl6766ci6lOAHUs1B2HFys5amgiDUCUdWJcnnvRyC42Ls2U
	K4grjbxHHLY+bpJhlfrgr6Oq5IY+bbr9RHFy0fMbKz0aZQhp0opDBhph6S3tPjW1
	a8BwuEo/TyLoDgo3glD89g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87tr3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 13:29:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDQCEg024179;
	Mon, 23 Jun 2025 13:29:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkpbd1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 13:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWYUTif6E2c9NWRN0MK7NZK54Yc4zFyQwS+33bb9k09JKz1gB8OX8mzeubhbs7Z+8ZVX9E0tW3YKEzvYfVpaqMmMtngjqzzLnPiTJsGZj4dkwq7PAHBmVnnNd0el5kCLquQVD6CEn9GL3h4FtbpMhzqqnk8NOY08FuESRf/CDQ0aRL9vAOo20FGGRM3hFMeNVVNzHYSwcoSdMKWDF2TiXgwKR/foQ+N5jC03Ue2hHZVT09soNUe6R+1CP92y9RBnxPhRRaqh3tPaGiyBRi6Fx3TB+N9RywkmaMuy8zsQTp66LF5IY6OT7/ROggSmB00cKLHUr12aSvGv83x0QEAgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqV+4BAJq98IjQ64fKvCCFZja1Z7hImwhEhpH3cGbTU=;
 b=gMU650fqRsYtvIf9u2rfkbFZyeHKj2Bgj+vecEggd9o4AQl+cOKMjHQl0P/KZcdxUoYQ0J968jINIGLIb3W7rxO4AOIrTVBOl/gnNRGmucH55+SnClnidrMuTam4j4dK8yoM/ycOAdTHv8PY4D/xQwJx5sSM04EVAIAEZ5qEqhcC0awKCLuGfu22X+OoTlrkkclkJOyEvW73eEHA7UgzqBCkNQDhCvpkFED/uvbo+wDi3N/NqqHKmHuUmCEmaQCKugOqh0azRg5dJZGFpTWWHqNQ/mMWRqS8O3Z4rkOGledLSpy/lAtE8oEKeSmI2WiZTvUbZMHIgUVdp2XNjiDHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqV+4BAJq98IjQ64fKvCCFZja1Z7hImwhEhpH3cGbTU=;
 b=A7AwL41daYAllwUWo8Et7d28U4sd46PnFnJeIYbX2G9gm9b5wCHTtDburKEABZMc1i+QDB4V6WqC8cuHc1VTdgVUL2xAMheusB7ometQJXe99bXmz8JZ9LLphVu+3cn4nB4STueOBrr8zvONjWMxKikKILfMeaL189eKvrTFfSc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 13:29:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 13:29:37 +0000
Message-ID: <c4172d8d-71df-4b49-a8d0-e413c1004648@oracle.com>
Date: Mon, 23 Jun 2025 09:29:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/2] Apply commit 358de8b4f201 to 6.6.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chuck Lever <cel@kernel.org>
References: <2024021932-lavish-expel-58e5@gregkh>
 <20250617193853.388270-1-cel@kernel.org>
 <2025062314-modular-robust-7b94@gregkh>
 <0b61c829-a41f-47b4-91c2-e8a7babe7060@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0b61c829-a41f-47b4-91c2-e8a7babe7060@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8eca2f-eedb-43ae-ebd3-08ddb25a002c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzRFZWFkQlNHNkVIbVFQTExIQTZvQjNrZXZWWWFaaHBYRzh0dTd5d1JCcXNw?=
 =?utf-8?B?OFRvc29BQ0FsNHFKbG5mc3drWldtaHl3dC9FMkNVNnN6cjFXWVBkYmFNZ0Jy?=
 =?utf-8?B?ZnFvdlk4d0VjcFRXalRGNHNwcDg3K2YzOFRQL1VDckpPdVNrNDBra3RTS0dh?=
 =?utf-8?B?YkJyNHNRVmJsa2lxczY2N1plZmhNaW9QNzcvMW1qaHJvUHNmN2x3alZsVFdF?=
 =?utf-8?B?cWNqWTlrL2MzVzdnQUZJaTZTZ0JNdGp0UENPTjlNcXFmQ1ZBSldMM2lrZFFT?=
 =?utf-8?B?V2s4RU0ySGtLSnU5ME44TjhuTTl4ejcxbWErQ0Jkcisza2Y2SUk3cnhESk9y?=
 =?utf-8?B?cU5JM1ZSQmt3N1NwSW1aNmdGcGpPVVNmUUN0YWdlRm9ocmFKMS9KS25mbUFQ?=
 =?utf-8?B?MElIcUZCVDBuOXh4aWRoU2tLL1Y5RG9aWTU5dThlY2p2Y0gyUVhwSkhtdWtY?=
 =?utf-8?B?OTU0b1VWMXd6eGVHR0FsVGRzOStWc1N1My9oR1FvL2c0WTZkSERORVY2bVRK?=
 =?utf-8?B?cUJsdVFHb3dwWFZyaWYxVEhTNkxrcy9HOUxPS3poeHNqU0hMcEhPZUVXNUZk?=
 =?utf-8?B?aEFuOXFPRGhQSjZuT1VIWWNoUFFjQklDaGVYdERTakVRSjhqYmZ0WnEzcisv?=
 =?utf-8?B?NkxIT2lsMmhVYXFqUnIwanhLOXowVmdNd1E5WnVvZExZbUZNZmVWUXJoSy85?=
 =?utf-8?B?TVZqVTIyYWJKQTFjVHd2TVpvK1E1eFdRYTBuMVFpTkorcVFOdU9udFdrSlNr?=
 =?utf-8?B?MXBWYjBTalJvUXp2cEJocEdQdHlmemJpNjVWay9RSWhGaFh5SGh0WjU0bWN5?=
 =?utf-8?B?T1llQVp1Mjh4bG5NbzRQdDJCd1NNS2ZiUTN4U2xrUzMxaFE5V1ZvNDNEOUdw?=
 =?utf-8?B?M3FHSFpVbklKQVBqVS9DQktYSkdPLzVURmFjdmFGb01hRm1aeU5MOVFGdWxM?=
 =?utf-8?B?ZHVhR2kvVHU3UkMxSC95K0dkMW8yUVl6bCtXT2p0TTBYV1d5UTJFRGVkMkVF?=
 =?utf-8?B?MnhyQjVEci9EZ2tDSXdRaEtGMHhRcUJwZ1VEUUpDOVIwTVpWay9EY2MrNnlq?=
 =?utf-8?B?aGRYeEhONWhaTkl5TEJRUUVZcW84ZVBIdmNVNXBjQ2tPb2cydHk2V0pNdjM2?=
 =?utf-8?B?QXNIS29KSjdzamZBckxSdUdkSnl5bVFGbzJ4WW9iOGhGTUp6c0o0ZHc2dFI2?=
 =?utf-8?B?Zys5bHQzdXRvSCtOOGhZcmVFd0ZWVzhBWUUwK0lROGM0U3lwNjZPZ3U1Z1BD?=
 =?utf-8?B?VGdxbEVaNW8vajVHSTNNaGY4RFJmcEVnSElnR1BlQnBsUyt6cXdVTURrTWhH?=
 =?utf-8?B?TWNTbDJqc0d1UW9jWUxPM21mUGJVVEI1UC9odFEvNGNBaFlUZGhpb1FyYkFy?=
 =?utf-8?B?UTQ3bGh3Vm9zS3pvTzRVTmU4dVZVcHN1UWtpRnRGWVNKVjZwbGJKeFNMQldh?=
 =?utf-8?B?VlA0dW9OQ1FWdXN6Mzl5aXcxVnhFZzdNZVJLajRVd05peWRCcG13VVFzZVBq?=
 =?utf-8?B?cUl2cW1tWHVjY1h5dWxhZDFwcU1JVG8zbGJXTU5SYlZ5RUdVcHdNaHBiZitq?=
 =?utf-8?B?NENZQzVrUDl6QXQ5U0E2eEkwTHErdmNOZC9jZ0FuV3FES0pNcVJhMW9mYWJW?=
 =?utf-8?B?TjV1WVVUTmtvQ01VR2V0bUx0TTdxZEZ0TGNzSStObGVKQTRMZFlKS094bnI5?=
 =?utf-8?B?ZS9qNFY2RkJTMTh0bHVZOCtiR1d5M0dBeUxwK253TzdWampEUTVVQ0QycXdW?=
 =?utf-8?B?T09ITWhwWCs5Z1NEbFl1QkUxelFJbG96TXBIcnBFOFlUNTFiVzhjdURqcVNR?=
 =?utf-8?B?eW40RTFWc1lFb3VDL1hkVWtOcjY5bnBjUVAxbG0wcjM4K1A0OFo1aHl0V3BC?=
 =?utf-8?B?ZmpHVXd1VGlBN1VrQVNIOXZEdDZ6dXhQN1ZrTnZWci9mcmsrSW45Y05KTjJB?=
 =?utf-8?Q?ZTD2ST0Y+Mw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STBnK1pncDZ3UHFoL3Buay8zN25VaDR0a2pMWGJHTFV6TWt4cGM5WnBvbjFO?=
 =?utf-8?B?Q3VPcTNrMExNM2crdkd2VnZJbWUxTkFNdUhLZDRnSS9GT0V2MTRaNFZNd29t?=
 =?utf-8?B?QXhLMy9yK0F6MW5WZS9aWWdTOGJUSTVGUHgyV0tQMEphbzI4VUxpWmdzWGpL?=
 =?utf-8?B?cmNyZDh3dVgwWXpvVGF4UDJoY3Z3dmMzK29tRzdYUkFqaFhHTkZEZVZCQmgx?=
 =?utf-8?B?M2ZXcmpkc2pxQjIzcExORWNFUXgvbUljRDlYTWd0N3dJYUdMb3NtbUpLVURG?=
 =?utf-8?B?UmZ5UEpQTmFvSTkwbDBsaWx1T3FIeDZUeVI3RTRVUjJ4NThvVDAxYTBPVXlk?=
 =?utf-8?B?a2JYcXFuNDhUcEFtQTJlcjlrMVFiUjU2blZCQ0dzNlVnSGpuQlg3UEVDY0V2?=
 =?utf-8?B?b2xBWkFTNUt2SGpKZDh2SU4vZGVlTWErY2tNb3dTSVNWdEMzeUFQbUY3MSt4?=
 =?utf-8?B?NWpKUW90ZiszVVhrL2JZMHV2M3FoYkl2Z2JqZUsxWnZtc2cwY1k1b1ZMK1RJ?=
 =?utf-8?B?ekFYUkRjOTFTTWs4YkVhRUxkSU1vanl1SDgwTXUzRnUxbTdJczNrUVJUaDJq?=
 =?utf-8?B?bFhCV2dQR0IyZkkzdHJPdEkrM0lEMmh5Zm1YdTR5bmJtNTFxN0FPUFJJM0U0?=
 =?utf-8?B?Z3NhdEZySnUyQ0l0c3dHOUxCTUxvVjRLa2xIOEZXOTJSUTh1Vkp6dW1PU0Va?=
 =?utf-8?B?c21ub0RvcFp6aE5FRGtUSURTWUlPWlZzWEdpcDdBL3cxaEpoNEdkalJkQkpC?=
 =?utf-8?B?bHZCK2NTYzliVUxob1FOVEViVmZHQml3K2xlNnNxdWZLWUowTGU0WXphV2VN?=
 =?utf-8?B?ZVVjUGpOZFFMVG9HdEFRbnVmTll2M3daT1JNRFRleWlSVGhGMmZRZkJweGYv?=
 =?utf-8?B?QXNDZU5QNmpid0Y2Q1JWdDNLeldEUFIzbDYwelJwb2JPQmh5L1JzN3lSZlVW?=
 =?utf-8?B?cHphbmdGek9HWU9DU0gvdXBoeXV2ZGNSN3JSekVWRWkxWS9NcUFNKzVEeVE3?=
 =?utf-8?B?UDUwWHhHWlptekNuaGhiQk0zbWpKWXJNNHR1bzhyc0V1bmJCd2ZhaTgvMVF2?=
 =?utf-8?B?VWx2YUhnZHN5dUwvL01FMUo2TUdGS2JONS9jL3RudlhURExlUS8wWXV3Z1lI?=
 =?utf-8?B?RU4zbVl6anljVHB6eGRQenRYZFM0b1hVMzltVkVyU2hFRkFqclVvMXgxN01t?=
 =?utf-8?B?UmtNZGJFMkNnam9VeisxU3RjKy9TeVlaZTVib3IxSGpFK2FWclBwRUY4Z2tE?=
 =?utf-8?B?d1Z2MXZuejVRbVdvYnROK1poQWQ0UmZETHJPeklzMll3VHB0SWI1Z05yc3Z2?=
 =?utf-8?B?anlFQXhqVEhEd1pYcUtmU3cyL1RCQVU1UjRsb0tGTGJaWGdFV3dTV05BbzJO?=
 =?utf-8?B?dkdmSVNieG93RVMrMWk1eDZzb2dpYkRLbkN2djlIWlBSMUNGOWlUdVkreGlh?=
 =?utf-8?B?Qm5GMGVpcmxja0FNN2hwMVVlemNJcjA5TG9DVzZxZWlDOFVqMUNQQVluRHY3?=
 =?utf-8?B?NGViWEQ3T2FYMUxkMTBDMEZHUy92MWQ3dmlhUXk2U2RmUmM0dDBUZVgzTFhz?=
 =?utf-8?B?a0VZM1NrQlFjV2hqR0JadkJ4cGZjVUdKV0E5VGo3WjFjVnZyZ1VsNWVWS1do?=
 =?utf-8?B?VFhPa0VQdTVIbVRIMWZwY05YRmMzUGxuMUhkanovY3dzYzRnb1FSZjMvZG1W?=
 =?utf-8?B?K0dzSUZndXJYMlVaTmx5Y2lza1VqYTN2cWZZRG1hMGhVMFJQczMyT3ZFcWNL?=
 =?utf-8?B?ZGViRDU3ZGo0NmpZcWdESmQ0MEppRHFpZlVxOS96TWp3bmNseU1acVVCcDNS?=
 =?utf-8?B?L2F2UU9acVE3dTJqT1JibThzdWQxS1Z1UE0yTlVvcDBBcityc2F2bFVaa3A2?=
 =?utf-8?B?N2h4UVROcVlXYzNzRVV1ZXBrcEYvTGFSaXBJb0dTNDl4MERNeGRsWjRFM3U4?=
 =?utf-8?B?dHk3a2UzOUhSOXB1bTRCYkovaHBneGtPV1d4cWlZVk5GL3ZrZExIUWdLNTdX?=
 =?utf-8?B?REpiNTAxNHJSNytlaXc5c2VPYTRhSmtYUFFveUNpNzVFM0VqWVpWRk0rVVRi?=
 =?utf-8?B?MGxTRStpRVczalpPbUpYcHB5VmI2U1FkKy90Vm5NZ2cxTGE2MDdYTDkwdnFm?=
 =?utf-8?Q?tWa8Pi+R/I4lEkxZy1YUS167w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YO0XJyY41v+O/SFbEEtIDBcsmoiRI7bJqsgCt3Bqay7shGKelpmA7qtR8LC5J3ULYwSSmz1DrBOUe8blQfcF0+CFe28ulVHJnvN8ORqqkSKryV1XCbswkhU8lyvQeJacTWB4MbrskzY3nEIMDNjhL31AmuLB/0fip7HkX+Q8F9MpqHePLOUkHFCHbfQmoqdUek18gNJtQ3zTdkDqDc9UFFfKYRBRfcqU0rnjWq9NY3a+pFQGUYUkVwZOB4ZF8yq7cojn9HANuTd0MAmPWyt8tXYjV5UHWlaqAcSTdeFfUqlm5wcPDYHXydHdqWkYyv44V8jKM3xBx7B9Qxlc+sQEibroS1Ux73S/MVea7crJOaWDMaDYxxUEbFpM+tqysqQ4HVMtUXTy9JCUW9y4f4KjnA35Ek9YcIBp4lHIPRJa+DPx+doOw900T4WnYjbeyRF3J/9yQlGdhHk0AjkNWz5LWSLWcORbfMQBZToa01bcwmMDSMThAq/sh3LUENoblXOfLZjUqcEdxPhMWC0f2DpWA75YCvvm+kFF7V8MREHUG8HKSK2rfmNfGMYhWbwyZ1+dzhqoMioYBe268YtDP9EJYfOHBmD1Jgqardqe+mORsbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8eca2f-eedb-43ae-ebd3-08ddb25a002c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 13:29:37.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdXyU8E9oyUC93eLN79jU+TXgJu7n+9YmtjS6sNzvuqhT4d+4NE9UE7euQagDyifXCjlXFvVSda3r2JbVDuWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230081
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685956c7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=KMZLWBGPiVCK_irms9gA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MSBTYWx0ZWRfX1///+RlBlynE MxpK4NcUQ++PVEykAkf4Myp07zyGHsxgy/HHwYx4j2NubIZEHYR5ujobE3zlT5gMlOIKSLjwz9i r+oqTICTT9MWEwugFRCTCr5GNCRTTekJFRxahOE+ytd5bIES27aJK7Xb5KZ/1F6GV/ak/xh7akF
 Tnh3TrYpmrgnuV4gQJpY9VJo60/T1eJo+h6Tvyew0rx6UEPefWAU3+DosCsJ30MAitVzsZJUOor Vzk1oDSgityHtRqIlOS6Db9Dm4xWsmf67oEoRK11ocYIhtrhSaVsdShdp5FhEDoLoLFChKQZCeC MxVf1fOMpAdT+tZqmCgNvjo9s2syU99G/1G+4qjvp0mp2Qmeg8EAHOBmZ5p62XUlljj2qYDH1X6
 OCqzyDoVBMzCqLt3B0sXaetxkFotrrQmZOnbLBWR4IEX0IuUadcEhidUbHPA14f83rUdQev5
X-Proofpoint-GUID: MbU_vQUfBZJoi5yIJnY_nmfqkyNKVB07
X-Proofpoint-ORIG-GUID: MbU_vQUfBZJoi5yIJnY_nmfqkyNKVB07

On 6/23/25 9:21 AM, Chuck Lever wrote:
> On 6/23/25 2:33 AM, Greg KH wrote:
>> On Tue, Jun 17, 2025 at 03:38:51PM -0400, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Tested: "make binrpm-pkg" on Fedora 39 then installed with "rpm
>>> -ivh ...". Newly installed kernel reboots as expected.
>>>
>>> I will have a look at origin/linux-6.1.y next.
>>>
>>> Jose Ignacio Tornos Martinez (1):
>>>   kbuild: rpm-pkg: simplify installkernel %post
>>>
>>> Masahiro Yamada (1):
>>>   scripts: clean up IA-64 code
>>>
>>>  scripts/checkstack.pl        |  3 ---
>>>  scripts/gdb/linux/tasks.py   | 15 +++------------
>>>  scripts/head-object-list.txt |  1 -
>>>  scripts/kconfig/mconf.c      |  2 +-
>>>  scripts/kconfig/nconf.c      |  2 +-
>>>  scripts/package/kernel.spec  | 28 +++++++++++-----------------
>>>  scripts/package/mkdebian     |  2 +-
>>>  scripts/recordmcount.c       |  1 -
>>>  scripts/recordmcount.pl      |  7 -------
>>>  scripts/xz_wrap.sh           |  1 -
>>>  10 files changed, 17 insertions(+), 45 deletions(-)
>>
>> Why is this needed in 6.6.y?  Is this just a new feature or fixing
>> something that has always been broken?  It looks to me like a new
>> feature...
> 
> Hi Greg -
> 
> TL;DR: This commit fixes something that is broken.
> 
> Reference bug: https://bugzilla.redhat.com/show_bug.cgi?id=2239008
> 
> The LTS v6.6 kernel's "make binrpm-pkg" target is broken on Fedora 39
> and 40 due to a change in grubby. This breaks some CI environments.
> 
> The commits in this series address the kernel install problem.
> 
> Agreed, I should have mentioned that in this cover letter. I assumed
> readers would remember my question about backporting these commits
> from last week, and I was perhaps also leaning on the patch
> descriptions, which have turned out to be obscure. Apologies.

But also, I didn't think a justification to backport was necessary
because "kbuild: rpm-pkg: simplify installkernel %post" has a
Cc: stable tag and the only reason it's not already in LTS 6.6 is
because it didn't apply cleanly.


-- 
Chuck Lever

