Return-Path: <stable+bounces-83501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0299AE26
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 23:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B669286A90
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D31D1726;
	Fri, 11 Oct 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n1fp7qET";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PQCfc9Rp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5131D0B97;
	Fri, 11 Oct 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682874; cv=fail; b=QeeMZN+Xb6ZLlB2e8NYgWTKmLrtpHOPpKR+1VwqZlHh94AKfllPODT5qhqEIkQK5M7W9sv0GEjY/osfJZfuUwsCJ34nV1WBaBk+IP3dEZGqmNCx8fhHf+nFsKMz2ntnRItOpQgXTGMc5wYk8uQGo44B42Vka3zMQTjRziCU1r/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682874; c=relaxed/simple;
	bh=+eILp/XjEVsofFlk2cs6DLEgfT4fpPyvYUFGD5aNNic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tga+Lh8TnRYEjmX1owTT7Wsfny6jWYXn8fJCVw3eY4OdCfecOmAf9Rb6fCAwAKErJUoD6zKpD/Uq5VDB87b2XAAlsO3PkVY7fs8uuWEGP+6QDAQVUAcdbc030Wh4CaVyT/QE8SZgxt+DPe63p7D4C4Yu5lDtf6so7TL7x9sDpvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n1fp7qET; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PQCfc9Rp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJRSMe029731;
	Fri, 11 Oct 2024 21:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uUzt8Mkee09Wd0jWebETRKcifJ2Q2DMgRbGu1vlmJHc=; b=
	n1fp7qET8zsGlV2J/WhqGwote7NztB/Mc0lLdYP9T+gz6B6yosGz1s/4FBTdkZOg
	ramu9Agz5TxB7XUQn6tp4N49rMBlj1duLZS5fvQItpPr5EtqMyHkOtWcNRqH/daq
	T+qA0oe7wMSE+JblrtBzZEwyN32quocS2WeYxFTM1rGQH9Q7ixbQ5Pcraf6THCVj
	zRaRtM1VMEsmeaiujqS9bu+Aq5sBAOGROWdFTYcFdNZTpJDIUVcdaNE4TztLTuWL
	ljWGE2/yEsZ5vXS3crO8mnt7d0Phh+U4x4lC35VndWJ4AYxSC/wry44uC76EMX5S
	44GCCRy3NPYRweVE5hTouQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwvg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:41:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKXjKg014596;
	Fri, 11 Oct 2024 21:41:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbr6n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBNqqljZc+yGqghrwpeT6iDv4qbCe0N9sB06MPe/9/jKt+P1PMLBYewQwhyZD0K0O0FcRhoEVdc+sKiz2xg0bTKqd+aOUurNJSAZRXNwDuAlGRc/GMd6NVYmdKmOdKltMqcS9pL7GCKqjHMU1dmTYLsjGJWsD8cYDChc57FjYatPfilbd5p/fi4aqs8OM1T3bzeabhdnPty02hduvD4WeBmeJ1O9IQf+a7CFrjz8SE2kIuFz4W4O/wA7R5yTVk6Dr19V4HgkAeuFdSl1tOl/2psHzPANNbfDXt5x5M7VGD9vhzbBs2DwNT8BK0hEI3X4lVYv6gLJZmP1LGONC7ov7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUzt8Mkee09Wd0jWebETRKcifJ2Q2DMgRbGu1vlmJHc=;
 b=bYCDaE7rObjoNaHgoh3hHI5eo02ifbW13O2h0myZogO/2BP2uh7Wii5o2662ZMbSJjYs3Bfuh1rFBxB3mnK4KAWa3yRgs6nGPlcAz2b8YjpUIjgO2344jUIPW3d79Q/Zs0DPbBRFQSG1PFjma0QyGm7y8xNQNuBhPHrn5ROnI1xfKE0r4aYbxz6DaX5x75eF6xIAQXQKhQV1EudyDv8ljAdM0ryJaR+E+LJKmzl6R42HI6P6pHwwoVBD+dvCFKua48jdyFJlqKbUs8VfkGICIWJHtjgMKqUv+e4M9/vRGyR5AhybELbRLQkWM3jHYL0JwdZcKIqhTZ97Xy22CF89+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUzt8Mkee09Wd0jWebETRKcifJ2Q2DMgRbGu1vlmJHc=;
 b=PQCfc9RpNv9d+RF98jYWf/k+GL79944IUH9UT5sUO6x2RBrjI4gLr8+utx5wU0/J+hpDbW9ipeQo33pLBkMB3rX/BiAQrCVk9bWZ8mTvVQD4CpUip6dup2cDVr7db0M8fIXQzNUnQQCjwFqt3sjFrLw6yhLg2RawE5VYM7Jw0Rg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6768.namprd10.prod.outlook.com (2603:10b6:8:10c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 21:41:01 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 21:41:01 +0000
Message-ID: <a96536d5-4d55-4e79-bf1f-519e77dcbf06@oracle.com>
Date: Sat, 12 Oct 2024 03:10:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] platform/x86: panasonic-laptop: Fix SINF array out
 of bounds accesses
To: Sherry Yang <sherry.yang@oracle.com>, stable@vger.kernel.org,
        sashal@kernel.org, gregkh@linuxfoundation.org
Cc: kenneth.t.chan@gmail.com, hdegoede@redhat.com, mgross@linux.intel.com,
        xi.wang@gmail.com, mjg@redhat.com, platform-driver-x86@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20241011175521.1758191-1-sherry.yang@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241011175521.1758191-1-sherry.yang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b54dcc0-a5d5-4b1e-ccb1-08dcea3d66a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2dpbW0xdjZ0V1BtbTJJS2Z3YlVzeGxyd05LUlZUMFJpT3BOTnFiWDVNTzJz?=
 =?utf-8?B?TFFQV015VHg0aExnUXBrOXJHeWhpQXorT3dMaGp6Q1BXcFU1RXdobHNaTk5w?=
 =?utf-8?B?ODZ1eHplVG1iZ1FsRHZUWmhYdWZ0R0dyWlcyWTZreEdpS1lXaTIwRnk2NXZ1?=
 =?utf-8?B?WTU2MjNTcnB4cGFSVEpHaEJNUUJzaFB4bFVqTTBKM1hlZWowa1hseS9zbEdX?=
 =?utf-8?B?N0VFeFdHUkQyZTNMQ2tlVHpRejQ0cTljOC9LZzUrd29KZHFkZWx3dnkwcGMw?=
 =?utf-8?B?cThwSzhrNVp5YXNxcS9aMGUzWlFLQkJPWUhQV0VEM3NBWUNXKzFNVnpVc3pC?=
 =?utf-8?B?cm1UMmpSeGk1T1ZTQ2pKZkNyQ0F1ZW5GTm9QNUs0cVVLeGViTkxtVjRVbE04?=
 =?utf-8?B?bEZmQmlONWtlM2JnMHN5Q2UveVFUMjlYekh2RVdua05ESFR6NEFhUFZrK3BO?=
 =?utf-8?B?ZDE1NzdaQkV4N0R6NXoyNGRTU0FSVHhFSEFXMjVlbWlmdkdWcEhpcjh2MzFQ?=
 =?utf-8?B?SzU1dlB2SDZMMDFoWnI2cHJ0RlNYQ2tTYVBIRFl0c2dCOGkxNFE4alkrWkxy?=
 =?utf-8?B?ODRmVzA1WkJIcnk2clFWYjBnQUhMMmlsUGllRFRnaHFGQ3I1NWdnY01SaGxo?=
 =?utf-8?B?Z2x5SklQTytLYUc2TDlRTjduNjB4OXk3SjFrR0paZGNpdlcyUG55dHBxVUpp?=
 =?utf-8?B?OWZidXR6eWhIM2xpVDQvUHZuZHl2dU5UUi9scXFKMWFyRXBNR0M0dlBPdUQy?=
 =?utf-8?B?Q3hrTWQyRjFxWjBDMDZEWGdSbU4vSzlsbWZKd1ZMbVF2Z0dDY2djbGFQQXl0?=
 =?utf-8?B?M0QvWTZIZFBrSk90dVRscVZmSXgxR3NSMVVaYms1WWEvdkRsdUJzN3V0YU4x?=
 =?utf-8?B?OEVrWWJlU09YcG9QRGFOc1hhVjRCTzVPYlYxS3IzVmV2M0R3UFJxN3AxbDZL?=
 =?utf-8?B?em10WG9BQTZaUlkrR1kwR1h2eDdQN1FsV2E5d1ROSWxGcW9jOE16dlFSREJq?=
 =?utf-8?B?dW91cVJhM1BuZitQYVE0VllXUnR2cDVWcUZRZ1hUVnMzeHhIc2tpWDZqTGIv?=
 =?utf-8?B?ckx3MEM2WHNCU3h6alR1aXZLcHZqRk45V1lXUGRaZ1ZFd2Y1cXBTV3lYcXNp?=
 =?utf-8?B?ZmdHUk1OaDVPeUJBRjlMRURzYXQ1MGFNVWI5SXE1bnQzTW9Uc0RkNnZsRmNj?=
 =?utf-8?B?aGdDdFV6TlBMUUhkelVDY1hOK2FaSTVDVnNJWnhvVlBQVE9jMUUxMDY3dUxB?=
 =?utf-8?B?TzdOU09ubXptYU1zSlpnbzI0UVRrcTJWUmFzSm5DYWlyZklPY0VBYUlxODZj?=
 =?utf-8?B?VUhuaklRMjgvemhCWFFaQXBYUHVsRFliOEZzMW5RTjFYYXd5dDBpVjRuWVhE?=
 =?utf-8?B?dnVRZUVLcm9FaVYyWHdOcUhnY0Y4T0JLWHhzbFRhOEwyTDhvZ2JnbzJXWHYv?=
 =?utf-8?B?SDFXVUpjNW5kczZyN2pXTFJlK21WcUhxRnpZY3FGS043clRpdVVBYUx4Mldj?=
 =?utf-8?B?STduUGE3MEphcDZudkdWdUlNeWFvRmJVMUcwY2lGQUJKTy8wVlM5aDZFK1ZC?=
 =?utf-8?B?dEZTdms2Qy8wcHZqektIV1pWalZES05hcHZwYklIaldTUk5TU25NYndkb2li?=
 =?utf-8?B?Zm9oWHlBaGowN2Rrc2ZDYUh2K3JjUitYa0ZyM1lUalBMZ1BYKzh3dlVjbzgy?=
 =?utf-8?B?aWY3VDRhQ0VuOXRuMjczZExoanpMZ1Jra21JOUtadkhzcGpoa0krN3JuK2lV?=
 =?utf-8?Q?ZNjivJExtuA2b+JrJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1hb21TQ040V3ArNHR1L2FBTlFMSDJ2bnRtSmNibk5IQ2Qzd1RIK3lCRTlW?=
 =?utf-8?B?RnpHM1R6ZTFOaGd4Nm02R3NPNDlqRG85SmYxRGN4YkwvSXJFcE1OeUlFQWF2?=
 =?utf-8?B?YUE5T042MkVNcHlnK3NJS3Jyd3l3NE9RMndKYUN3RStscDhLc3Q5OGJSNThC?=
 =?utf-8?B?elIvMDFkMjU4bUdCQ09HQ2xaVHVwNjFkWkJ5SndXZVEvM3BTTnhKdkg3bnZI?=
 =?utf-8?B?dS9OMWlGNHhxNURXUldxQkZwNzRWOEQvZFJSNS9CYTl4dTZGWmV5bnhhZ3dW?=
 =?utf-8?B?Tlc1ZWdmQVVNQktNTkZWVmNvRkZ6TmNvM3l5V1dySGd1QlpGNFJzQkhQUzg3?=
 =?utf-8?B?RzRJNVFJVGxaWjE3VHZUSFJZdFZEdlNGZzdTdDY2MGxRblVlMmVlSU16aGJW?=
 =?utf-8?B?M3Y0aFVLeTRzSksxVERKa2tpQkkwOWFIQ3d0a2RQdk9KajdEbXBNbWQvNkps?=
 =?utf-8?B?V0hXbUxJKytOR05HdkFzSWZjb2VsNHhKRjd3TnI4NDNZNDV2VVUybFc5K1hK?=
 =?utf-8?B?RGJqcDNpTkNkZ1lEUStWajJmWnFSd2ZmaDU5L2JucVFidXA3b3RHdFI0djlz?=
 =?utf-8?B?ZlltK21qcWVkTnA2R0twV2tRQjVGYXZodU1pSUVUUHZjNHZJekh3QjM2K1dJ?=
 =?utf-8?B?OE53N205eFE3Y3Q2dkJVNFpPd3BqdktWMnRjc0pSVDRnaTNNS1NUSFVaN3Y1?=
 =?utf-8?B?NW5EK3lMMHBNYmkySDJRVmJIZ1B5YWt0bXdkYTg0YmlvUG9kWXhRMFNWL0hQ?=
 =?utf-8?B?M1BZN1lXRXpvVG43ekFGMi9vUGIzUm5ZZmpXOXFGb1hMQUxOQkZpeHY1Rnl5?=
 =?utf-8?B?VFBOWjdpaEFrSmNkdmVZbFdDUnJNS01ubk5KVU9uWTN3T2hsU2ZCMjFhcy9Y?=
 =?utf-8?B?OWlkNTAra2NrQVFsaEFwTEZuZnppdTI4b05QdTl0UzZLK3NEYUkwMkdPNGhH?=
 =?utf-8?B?VE1VMVhGVDJNZXpITlhGdUNoaTFxNHorbTdxT2hWWDRrUklyNGMwRkd1REd2?=
 =?utf-8?B?MXI1UzdiMXZCeXV4bUk3S2lmcGI1dTV1M1ZMMGE4cm5vZGtsbGxxV3Nwd0Z6?=
 =?utf-8?B?SWNGQ3lOY3A3VHowS2NpRlNlUSs1QzROaThNYUVacnVFdloxeWlYcW5KbWtI?=
 =?utf-8?B?RkR5TkNrWmg1dHkwQ2hOYytVUFo3YWlkazl6TW1XVUFBV0F1d1lybVN6Tytx?=
 =?utf-8?B?YkhzMWJ1QXgzb3ZJaiswS3hlOU1IWTRNK1FXSDNMTVYzazJ6RjI2dzZkeEFw?=
 =?utf-8?B?SUkzUk5mOC9VMjRUOXR5Q3JiN2tibHNXZmRtYy81VllFdzNuakMvYzUvZ00v?=
 =?utf-8?B?dGl6bEx1Q3V2K0c3M0xqMlBWaGd6VWkwSWJoTlppejk5K0VwOVVvRTVhN29V?=
 =?utf-8?B?MnZXYVY4MmtadFhqVURaSlRmaFVsUGFYa1FsRmVOaVZWaFlOc1ZQeEhqdVo3?=
 =?utf-8?B?bnpWeW1wdGxWNHRLWkV0bUpvaUlOR1p1aFRBNE9UQ2xZN0F5TVcxdjNzSVJm?=
 =?utf-8?B?aGEybDZ2R3lVaHJBQ3c2NmMvcXhBQUdoZWc5OVBxay9Bb2JJMHdrbkJ1QmlN?=
 =?utf-8?B?aEFEb3BtL2JrZW5Lak8vanFwVnBMZk93dk5jQ0tsdmJURU5UUEFyN252ekhT?=
 =?utf-8?B?VTFIZHhHVTBvZzd5T29PTUZxaHMxYzZWZjhtWG5qeTl4aHVmRUNobWlKc1Jr?=
 =?utf-8?B?VUJQWitvUVlBYlc4MG53QnBsd2gzdDR5SlhhMWhYY1BRVjh3TVJTNUpHM1BP?=
 =?utf-8?B?WWJwL1ZNT1JDS29ZVDlsNUE4eEtkSXoyRHRBbUxQZXZIbE95UVQyRzdocFNu?=
 =?utf-8?B?VEdYK0NvQWRaR29ZbStZVjVlRHBKTlBjd0FDYVpqdjRmUkdPZk1NSEgwQWg4?=
 =?utf-8?B?TEJBRVltT05EbndBcVRQMTVoMzJvSmxOR1NVWWl6V1ovaEYzc2lmS1lacGZw?=
 =?utf-8?B?V3U4RmxKOWRUMnhOSmIwcUg2SmczS285SFUvMzZValgzSGJ3bThlMlhzYkFp?=
 =?utf-8?B?VXRBNkIxWStXV2hvVGZyOGZ3Z293TGdjalN5OGJUVWpoSVhicC91WlBnc1dU?=
 =?utf-8?B?RnNoYkFPZFk4RHF1c09ka3lEMWprcjVwc0tVTUVwUUJ0cGM1MFZ2U0Rncmha?=
 =?utf-8?B?N3hsQzhNa293Z0tHWnpTbjlQMkhUVWo1YXR1eXpJY1NNVzB1WHJZMVNvUzMx?=
 =?utf-8?Q?SML6cVjgAPCOc4kZTAnw/dU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	heGXdJARJElV5TMQ9eGNjn2dsvC8YU4ROJKx7Xc3TXZPTANYzS/fJ5tFHmL0/vVuBlE04gL+arm3hBiABcdjWW2ggbBB4p09THYfbpbVjgfp3JHMUlCgg1YJ/gA1Erfg3Nnmpv9Ku3vX8eCKU0cZJnjeeVZnaHHshU6JN8xy8mUKx0METFQIbwQi9xY69dr0nmw6qFtZxMuXkZFoEnf5HDdpQv6KYPTRjW8A9sLqQkd+IezOVX8LAiTZBoxBwb7RgnCZbiTmGtyEXeAmkq38QplZ5LwVSgmMRzQvW6zTWodJnPFSfcFb4wu1jVWzqc4R57gTcwRXLULo819f6bzB4aqgKGfKk8KoDTJZb8jNo4LgzZclyoYL546o0FI4YFSfdUsydYLFYxi7QNQA2bBqQNWaLStg/5JY5BWvoA/vI0EYaEE3V66xepbwL1zhxF5l2McLB1l3V/PIC+NJbRVRXIYFvpQV1HPNhG7U+haAFm0BoR5ed8CdzQNEIpUgmDXsqHzBk1GRM4RQND1ltuTjJcgPzuZztuyFMXZ1vyBK+Bz+mGCdwkrUMc6JS+s6yaBq/KzXK56ZK452du/zyCInL0MIAmlrRP+/2agoDOkVnEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b54dcc0-a5d5-4b1e-ccb1-08dcea3d66a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 21:41:01.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCrzf1q51N6q4jrfr0+Ejttoa2SpXC/kPSh49yrKs+TIUy7rjw+wwulr2wT/+kY11yiW9cNx1Xb15sNDsZbcFWOmypHfoRZaSV+TLXrbSd8A77DtfjdvmxUgniDW67h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110152
X-Proofpoint-ORIG-GUID: dbfiLa930_nAaveCX5v1T36ILTJjDNyV
X-Proofpoint-GUID: dbfiLa930_nAaveCX5v1T36ILTJjDNyV

Hi Sherry,

On 11/10/24 23:25, Sherry Yang wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> commit f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4 upstream.
...

> 
> Fixes: e424fb8cc4e6 ("panasonic-laptop: avoid overflow in acpi_pcc_hotkey_add()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/r/20240909113227.254470-1-hdegoede@redhat.com
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [Sherry: clean cherry-pick backport, fix CVE-2024-46859]

If this is a clean cherry-pick and has a CC:stable, I think it would be 
queued by stable maintainers.

I just checked the queue and it is already there:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15

Patch in the stable-queue: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15/platform-x86-panasonic-laptop-fix-sinf-array-out-of-bounds-accesses.patch

I generally check the stable-queue if it is a clean cherry-pick and has 
a Cc:stable tag in it.(Also absence of "FAILED patch" for 5.15.y on lore)


Thanks,
Harshit
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>


