Return-Path: <stable+bounces-197697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E25C9666F
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 10:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20CA34E31DA
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA9301473;
	Mon,  1 Dec 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MuDRDfWb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T9E2pCMv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC402FE578;
	Mon,  1 Dec 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581695; cv=fail; b=lne2S6aKO8NLvEbSU85lAKZR8vBgvggrGyg4oW0W4JqmWnckLVrtVixgTKEOb7IxBKt89Cnzk/de0EF6bj8LliCWv5OrPpY6YGY0UbDvj7geh4tjs1/bexiN5l7TMgqtHicRN5oX/Uo139/xLJbMBPk7jwXolDFLdQ4smPVc828=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581695; c=relaxed/simple;
	bh=fp0HkfOXehkn0dO8aL/fs9o+Kp4p9CvgDyT8oSZ4S7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OOIeVMKpJRxuuEkddeV9B5l9OTDp4pjMPjE9jukoLn+QfdW2AXFEjiJekWosVupvlwh3t2vtHat1GQ97b1byOfpNYIPn85BQtoJJgSjUMZ/D5wYqZ4XXmZSzjesnFBGTJbQWFSiN+m3ExF36Nuj8T6fuJN4Ui4m3rzoPdFOeFoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MuDRDfWb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T9E2pCMv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B19DdKj1588630;
	Mon, 1 Dec 2025 09:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x73Npq2aeoniCpYiUI0mTejjIixuVke7rHT+gPcmgLI=; b=
	MuDRDfWbXVieozgG/zBoeI5SnszP5o0Xd/qmp8GOGl7+KJPn4EX4zmxTXyJ/6Ezm
	IV0ZKy8hto7s2N0wzg5nbyuOUBQLyak5jMM4PbyjHDR7oYTLPp4Fcy6lxhGLOPzP
	u4jHWVIv8Yy6a6R45qwWTENlmrCq/axsZlHnyZQM1OPjQcOvMZZJMKCkKOxhBXA6
	92npWaiiA5yJf0eMOuaQMd3aatg95jE7lIhb+LxDuTiZ4HNx+c/dI/KIo5nc2qws
	T8ItML2mERn8IBE8yGoVB/RRtcS6e0w2VuUfWT5EMZididhu3jQ393DHXzKnGO+m
	Ek9zlF6utvNA7CkvdlLlqg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as86y81b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Dec 2025 09:34:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B17uk03004540;
	Mon, 1 Dec 2025 09:34:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq97hxer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Dec 2025 09:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH2o8ASg7LeecLY64igfiWHLiTMaRCk1B5b1BhkvMvXiBvbm2YM/wKMluFMWSmZ0EXlgGoOPHG5w7x7q70HCBrhFxAdtO9uJvvMGyu9PUCle8eMNwAr1CXxv9NB61BqR3nF5UNApw+PVj9wMvdTq8MGClZOPuSFb2Irh2/nPE2PJ9Mayk8CY20fbo4CqgH3dDl2JS2unziAmip3qaQq0PDGqlKJKSGtZJPV41H3RicGB2grtxJ2eunIv5eA6zz+j86fAcHAW3bT5ljj50Kzzlx1JTr1avQqJp6zXofcuEcjIiJkJ90v8gRKKSKFkhK+0CYuOOqidkbc1Dxk/iLJ/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x73Npq2aeoniCpYiUI0mTejjIixuVke7rHT+gPcmgLI=;
 b=Qzv4fi2pYxCJrL7oP4CXSP3cKascpEa4HZ/ZWW5Hf6iqN4w1Dxrjl7jEGrg3bjznZnr4mV7qPfy+N+ucM9JvGiPWji0tRxl4nYYvTz4GGvld95vbl3s7BHHsmNu5hMtDFcGG+g3vqSaipVkS1/BDUj7t/E4bi+YVgb2hALozNIN1VxdWjfuPKEi/Dao59H369FP2vIH1Sq5a12dIl/BK2D/cWzIOzzaH2PReXpSAi7b7FjR+nh8egGymZjNi8iXSHEquN5TCgREe4Wx4YbDJS/Y+VHtPjto8as23naaC/rbr6+LXEaovy/3X0otMLU43/Y7m/qjlHhgxsfWddTFs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x73Npq2aeoniCpYiUI0mTejjIixuVke7rHT+gPcmgLI=;
 b=T9E2pCMvOB3bIVlYy4YXjcGzVFiDmJ0cLJKYJGbJLtAeKIOn/g3jQoYSvEZ3iVXk7ebyqOlRx94W1PXZ8fA4llteEpYrbLj1StSPaXcPc63KIZXkww4IBxQIxV0DYmchuDqUX8pl7AurWy/HRhEqrW0ObSPOZCf/6TEg9C1oyAg=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by CO1PR10MB4628.namprd10.prod.outlook.com (2603:10b6:303:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:34:03 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:34:03 +0000
Message-ID: <633a35b8-207b-4494-9a4e-24706abd3990@oracle.com>
Date: Mon, 1 Dec 2025 15:03:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
To: henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Jiri Bohac <jbohac@suse.cz>, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Guo Weikang <guoweikang.kernel@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados <joel.granados@kernel.org>,
        Alexander Graf <graf@amazon.com>, Sohil Mehta <sohil.mehta@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jonathan McDowell <noodles@fb.com>,
        linux-kernel@vger.kernel.org
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        Paul Webb <paul.x.webb@oracle.com>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0590.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::6) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|CO1PR10MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab8706d-8ae5-480a-1858-08de30bcc3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjdsZnJsOXBGVVY4M0FlUCtuM2pVbmpKV0ZJM3dJTVlSRFBXSHdtMU0yZG1X?=
 =?utf-8?B?dXcvakZvM0NXdXlxKzZ3cVhVSElIbjBlcXNYaloydCthWlhqWm85dFlOa1Jp?=
 =?utf-8?B?bWhtNTY1N0FYdTVEekNyeVpmUCt5bTNGOFdGNE03WXBHMWpVS3NFd3R2N1dU?=
 =?utf-8?B?R3dYR25HTW5qNFZ3OUdUYmUySDl4TmpIQkMxMVJMWDc2Rm50VElBV2NCc0tm?=
 =?utf-8?B?L3ZZVlpCOGg1NWlFZU4zTFRpTEc4N21JUkxCRnB3cS9GOE83WGR5U01velB5?=
 =?utf-8?B?MjZqdms2cEhFM0tPMGFlM3NSamltb2NUYnk4RTNuc01OaWtFWjFDcU1YVDQ2?=
 =?utf-8?B?NXlKWVdoN3JNVm1UOWp2QXJ1ckVRMnVqRGg4QWlQMjJwcHJRZWk2VGlOWmoz?=
 =?utf-8?B?T1VFdStTcTBDb1lNSm1mUDNBaTBiUGJCNDhSZ255WFJuMW9IcDB5QTB3c1A2?=
 =?utf-8?B?YkRpbTFTUkRYaW1mdXY5SFVWSU1tTzE2VGVLWTlwMWdkdFROeW1LelV3Y3NJ?=
 =?utf-8?B?bmxIb3gvaDZYNkFkMTIzYlAzMHVnN29IUHA3QWpqQm56QjJML0h3bTdIWGx3?=
 =?utf-8?B?NzVOaGxZWEJHWC9TenVXeUVzc2tvdFNtL2daS1ZtbUlNeVdES0ZPMjNZeElt?=
 =?utf-8?B?Z2V6N0lRb3BkM2VTb0tQeWZad1YrdkhjK21vQ1FrT2ZRU0NSOHExbFd5MGZJ?=
 =?utf-8?B?MXpyMms1bmpUM09HcmZIOXl5UkZzWXVWNXJQdDlsOFBjK3JKenhhUXNsN2gy?=
 =?utf-8?B?TFFvWVFIVCtzL1NVdkZFL2tVQUVGTnhvZXBqVE5IMUdKUmRpOHVrSVluKzE0?=
 =?utf-8?B?azdvM3VuZ1UyWmNIQkJSTzI0bUlIWFd0aVFvQVZBcVRXZ0d6bEFabUd2UE1I?=
 =?utf-8?B?a2FSWWNEY281aHc5MDBPcHZCQm1IOW1OeGtaM0pZNnBtQXN2TGpMOXV6aGt0?=
 =?utf-8?B?dEppT01hUWlKSC94OXV3VzdIeTFTYmxNSlJlck5ZcWUyZ0NwTHUrcloxcFNW?=
 =?utf-8?B?YXNXelZXWUxoYUVsU1EwTjZ4WVNSZWRURDFTd3pKUmEyejBObGc0Ly9uZE9N?=
 =?utf-8?B?TUc3eklGUm44WW5WZUlzLzRoVXlJVTM3ZlE0UmpMNWVxMSs0Wjl2MEZoZGd2?=
 =?utf-8?B?RzhBcXg4d2lrdkR6QTJIeFBBY2tIU2xZTHZUdEw0dmVuRjAzQUR2a3VaeU9q?=
 =?utf-8?B?MU0yaktCK0VCNmFTbmtSOGZJOHUwS3ZRbktWb0p1QzJ4NlVqN01VVU1BcGRP?=
 =?utf-8?B?WHpkZmxVN0pkcGZjY2lwRk9IU1dsU1EyOFpmNHlCcHMzWnk0RlZhNnV6Q1NS?=
 =?utf-8?B?MFNNaENTNStpYk1XZXgydlVVNjJtTTZFS3llMXVOdlRDNlpPOXgxMU1vdjFt?=
 =?utf-8?B?V0JiUnU3bEtkdjlSc25yd2s2QzlIS2c4L0VGUEw2WEFvREpDQlFQNGhBakZj?=
 =?utf-8?B?Z2I2dlJSeUNic2NLa0lrR2J2QllNRFc4bVYvTEVYaUVVSEdRTWEwWDFKQjNv?=
 =?utf-8?B?VWdnb3krajFCR1QxSVhPVjBVQmRzOS8wRWZacVZvMGcvakdVRVNrZlJtbHVP?=
 =?utf-8?B?M2dpSDFpQStMeWxDNWtqMWVqNTNIZ0JyMnRPOUIzVjZmTmpNRFJMUVJHVUNC?=
 =?utf-8?B?MHJsUnV0NkdnM1JpT1B5ejZGSnZyTGdwYmtneEw3ZHhEMVJXZGgrV25GUHJ3?=
 =?utf-8?B?VkMwQjVtU1hCYnFBR055a3VDZHIwSXhDckZQZDJ3U0MweEpSbmNqNHpqMG9z?=
 =?utf-8?B?dmFtSVBtZHordE9VUC9nUGVmVTBibElhMDRSTUQ0dkpwU3ArZ1NsdDlTV0w0?=
 =?utf-8?B?T3FrTFkxRnpOd204ZnN1V01TRDFyNTdTalFCQ0I5bEUyeEJtK29LUHRCaWJY?=
 =?utf-8?B?M3JiemduVjNRS2Zyb1JlUWJiQStNSC9Od0d2a1pQM0Myc0lwTTNBYndJUzRZ?=
 =?utf-8?B?YVUvVmxtTkJIOEJOT2tUZmpsS29na0JrRUg0YjlLZllQWXQ1TFBVelpxdm9Y?=
 =?utf-8?B?Z1pFQXNYODdsWTRvb2J6WmFHWldSZCtBM2liZysvRWVnNlBZQ3NqQXNlUkpr?=
 =?utf-8?Q?tB7Mje?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1pQMUZCK0wyVnVqcENsNng0N2djN2xqOGxIb2h6UmM3dWtobERUeE9Zb0tW?=
 =?utf-8?B?czNjRE51SEYwNFh0UXNFMUQrSWZvYUtaOE5DYVZSYVJkVkw5N0h5R3R2Q2ZI?=
 =?utf-8?B?ajd1a2taOUtiencyMjE2NktIMy82NXdpZGY5bzczelR2SUJYWGRpdStqZTJ1?=
 =?utf-8?B?akM3U050eGptRkZyVHVSN1BqU0Jwb2VMZGcwY0t0bUZkQUdveGo5K2twektv?=
 =?utf-8?B?d2MvUUh6VHp1ZnpUQlprRGRsQ1c5NTRveFVjVXZZb256blBFZU5aQkY1OHIw?=
 =?utf-8?B?MjQwMEQ0V3E2czQ4TUk2TnVxMHFSZ1NXT0tiMFo1ejUyN0Ewc2hwMTlPaEVM?=
 =?utf-8?B?ZGhEQlZwL0hTb05XRktYZnZhR2llWkJYZ252c2dnN0Jmd3hIaFVETU4wV294?=
 =?utf-8?B?ZG9Ec1BYYWNEV2RaRHFsOXE0akxpSnZ5c1hiemtmS1JBTHRGKzhaaTQza1FJ?=
 =?utf-8?B?dEVVVmhMNWtjOGdpajJRNk5GNWcwMlpERkJSZjV2YlorYnE0Y2tGVnQ1dmdF?=
 =?utf-8?B?VEhUdjFLejRjUEZ2ZjBFWDZUemsxZ0czb04zOWdNWDNxUks3NHcwbm5SRCty?=
 =?utf-8?B?czdRR0IyMUU0STZKZ2JsNFprL2hMRjJURkhOMWtDYUt0M3htOXpHeG16Z0lu?=
 =?utf-8?B?d1FtNDhsNkFjbDFSTG9jdUJ5QnQ0L1BrZExmZ2hITmxqUDR6cVZsRnA0aCtP?=
 =?utf-8?B?d2RlbDFkV3hsZEdiTjZaam1qZG05V1BnamhxQ2M2RXQ1Zk1PWVEwSzIxVTZM?=
 =?utf-8?B?TlB3c0kxSkNCQUxkbVZuZ3Q0c08rQWRYUVhFMVJLRG1WRDlxZmdMVXVscjl5?=
 =?utf-8?B?eVo1QmJGUmQ0NG1PbTdyVkZRaVdYQmRoM3VidUI0bUcyanZpRWNDSmZVS3ZT?=
 =?utf-8?B?dmxzbWVvZzlXdUdYaFZxTi80VnBMOTBBRS9xWk5TVDBpWjAvcU1TQW8weHBO?=
 =?utf-8?B?bkNjOWlLazVZV3V0RGVyZ1FUaG1OVHhNTjRqNWlXNjZYL2JXQ1B5aWVxdmps?=
 =?utf-8?B?Z01BOThpVThFdExpLytua084RXZqMHVuL05SU2NTUFQ1aE1MUTBCREFmTnJJ?=
 =?utf-8?B?UzhMSEZKb2llanBrcXZEUWZJNjRHMUg5ZnR5MVRxMW40K0paNGRqa2djV0ZN?=
 =?utf-8?B?LzZRc3dJMkphQlBLY1BBVVhGV3loSWpCb0lyZFU3QkR5dFA5Y01Za1VmMVYr?=
 =?utf-8?B?NTlwNkdvZkxTNlZwV1dNWEVUVXc1MkFxNnRHdWErREs4M2tKdDJQd3dJdTY2?=
 =?utf-8?B?NVd1TWV1enVYdk5hS05YNThkcEdPalVPZXd0YjN4T1o3ckpFMS90Q0ZMano2?=
 =?utf-8?B?NHEvam9VZDBnT2ZSbjZaU2s4TmpmMnRXR0o5aGRieXNxR3pFYUhrNWs4c29y?=
 =?utf-8?B?NEpZNTNxOVFSWGtPWGM2dm9sOG1XaXkxYlp5S3RhUEhJVjNzN3JpNUZWb3ZC?=
 =?utf-8?B?eTBjK2N4b1dQd2x6K2U4OGdMTk1mK0tsWHA3V1RGNGZqRWRxMnEyK0Q0WXVU?=
 =?utf-8?B?YmQzWXE0Nm42Y1FiK1VqM1NsL2NFUHBZTWRuVkVyc2JId2toSXdXNk45K3Jv?=
 =?utf-8?B?YTNhRVdUMkc3K2xjVXRCbUFKMENtU0l1SXdGMWZMUWVldFR3YWpmeHNmeEtr?=
 =?utf-8?B?N05zVDZMaS9GOEZ3bFJaT1ppMmN2REtLTEhEb0hLNmlPb0h6MGJvWHVrM0p2?=
 =?utf-8?B?SHlVWjBXYzZuak1FRUtZdERqK3ZHcXAwc1hMZytWd0g0b1N5VWQ2K0pWd2I4?=
 =?utf-8?B?UEhHL2FsNmJYUVEvTkJhbjRrNktqMDVuaXZJOEY0b2FDaGJtcEZPRFhEN0dH?=
 =?utf-8?B?SWR1ekFaeitSQVptL0hPOVdzSW8vQWErcktVYmlKM2x4cU5QQjh0SDBhUHJ4?=
 =?utf-8?B?NnNmbnhLNnJ5bEMxeENMMkFOd25Hb25RaE1rUmd0Wk9kVGlrUDRxWWwxVUV0?=
 =?utf-8?B?bWxQVnBWYW16QXBDa1BnOWc2NDdoaEtISW5qdy9KcmJ1Q3k0bDZWK0tHL0N1?=
 =?utf-8?B?RnZSTUFTc3RDeDFuMFpOeDUvSndvWHh3aUdBN2pPcjUxTmtvVzAwOXdCZ1dB?=
 =?utf-8?B?Wm0rSWhMaCtVT2llNWJ3Z1J5NHNxZGgxVU9ydGZYNUc4OE1VMm95dDZleHZa?=
 =?utf-8?B?cnRmWkVPZDUybXY2c1lpN3RFUWxMcXhRYjhhVTlrc0tBQVFiTUNmL1h3UW5F?=
 =?utf-8?Q?wcLb6h/jv+15h//tsLGB5DY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XtVIDkxWkGd5gyrZQiEGmPwryIv5bhTxqzV4TIdMYr9FReSxgkV2Fc14gFlog5ErlMeaIcq7Jor7ik2zCebLCDlCSIYM+PuItLLxZlhIwtr5M81bQu/TsTu0ot9i+aJ1DyIWBwMXRSgeEtAtcjKAesBbqCZ7WNGPayD6CvGZX/6wvevr6w8P+R1gkPW2MIugmVQVn4lOFYw/1cygvEwEiUt25aX4vgkW9Y0D4KiEzUX71b4Defn5a8omDPbdzKJ5SxH/6zAb1aK7J2a/tmgnzcp6s0wl8K1QbMP8zTsscB5vL89R4vdRy/EbSGasT13WibFG0ZY1kaqub7M3FuP7B6+8awDcdyTaj7A+f4o/7arqF3jMwO7pqRbHO8eejAK8X32xjypGSpVl0kv+dgj5MaIVAn6I+jASgBJZ+/zOXnxs0Z7WJ8RXV+DcNAmAhyHLoIa0hoktLFpduNp/RD5s46NaeDLAydPjAxfGFFSBbFObmPOrbABBki8xXjVXWvpUcqcq1DdEgozYGcZfj+xR2Cr7h1pa+lGDX0g9Xmnu/JJLQTqIthu9GwnXnnym28x4sMkReAY6Rgr4GKML5LB+u/Mq9sBBfQRWE1h2GktkE9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab8706d-8ae5-480a-1858-08de30bcc3c2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:34:03.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGXUYjEkhBa1Rqz4uOkPPXEasPkPBZ64DrUyXXTCeGz6G5w8beQs+my1z3BSwaTqLhdBQn41IWn0ueau+o2cypgGAuPf55toW33Z2XZ7fTnkbs/U0WuilyMAuJ07Nq8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512010077
X-Proofpoint-GUID: XmGIfCGnxWRb0NIt1uV6KDgn2h2Jhw_F
X-Authority-Analysis: v=2.4 cv=AaW83nXG c=1 sm=1 tr=0 ts=692d610f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hdtbZj8bj3JI7INVXmgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA3NyBTYWx0ZWRfX7Xqt1nSa1Fh9
 03E14mct7ZLrVLzvWXQW4L8qVUGX1UeDdesk7A8Y2dt1wnx2tt8QrsxE6qOGdcZw3wc1bzpvlBq
 xfZglRVJx7ApbiuiCV8WUCh0KEeSRl3DZPDwg20lXJE/FoHMOSFauxti8uvOg7SqbAC+Rrc13KU
 BuN0xRJ5fDS0ZHB7SHXrkO/nZGUhmdP+R4TElzKf2mwgZ5apoM+H3UMnQXPSy6GAGkbo9hhuKrR
 83cXKVQ2hqLPAfGqjm90WPxTdanv36yO97TjwiD6rpeFsYj73TkgX3cKGXTJ8hE475mYjNAZCVl
 U5YjsoUxCBXXAeVF+lN2P8xVdLY6fg8UvUkAmlkJWO6TPIDfsPAM9DapbMXcQ5PwC6o5oQdSFUo
 b1Ty6CzjwQtpU8CrGFlG5T/3rFv2vg==
X-Proofpoint-ORIG-GUID: XmGIfCGnxWRb0NIt1uV6KDgn2h2Jhw_F

Hi all,

On 13/11/25 01:00, Harshit Mogalapalli wrote:
> When the second-stage kernel is booted via kexec with a limiting command
> line such as "mem=<size>", the physical range that contains the carried
> over IMA measurement list may fall outside the truncated RAM leading to
> a kernel panic.
> 
>      BUG: unable to handle page fault for address: ffff97793ff47000
>      RIP: ima_restore_measurement_list+0xdc/0x45a
>      #PF: error_code(0x0000) – not-present page
> 
> Other architectures already validate the range with page_is_ram(), as
> done in commit: cbf9c4b9617b ("of: check previous kernel's
> ima-kexec-buffer against memory bounds") do a similar check on x86.
> 
> Cc: stable@vger.kernel.org
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> Reported-by: Paul Webb <paul.x.webb@oracle.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Have tested the kexec for x86 kernel with IMA_KEXEC enabled and the
> above patch works good. Paul initially reported this on 6.12 kernel but
> I was able to reproduce this on 6.18, so I tried replicating how this
> was fixed in drivers/of/kexec.c

ping on this patch.

lore URL: 
https://lore.kernel.org/all/20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com/

Thanks,
Harshit


> ---
>   arch/x86/kernel/setup.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1b2edd07a3e1..fcef197d180e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -439,9 +439,23 @@ int __init ima_free_kexec_buffer(void)
>   
>   int __init ima_get_kexec_buffer(void **addr, size_t *size)
>   {
> +	unsigned long start_pfn, end_pfn;
> +
>   	if (!ima_kexec_buffer_size)
>   		return -ENOENT;
>   
> +	/*
> +	 * Calculate the PFNs for the buffer and ensure
> +	 * they are with in addressable memory.
> +	 */
> +	start_pfn = PFN_DOWN(ima_kexec_buffer_phys);
> +	end_pfn = PFN_DOWN(ima_kexec_buffer_phys + ima_kexec_buffer_size - 1);
> +	if (!pfn_range_is_mapped(start_pfn, end_pfn)) {
> +		pr_warn("IMA buffer at 0x%llx, size = 0x%zx beyond memory\n",
> +			ima_kexec_buffer_phys, ima_kexec_buffer_size);
> +		return -EINVAL;
> +	}
> +
>   	*addr = __va(ima_kexec_buffer_phys);
>   	*size = ima_kexec_buffer_size;
>   


