Return-Path: <stable+bounces-230426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGwkADbXxGnk4AQAu9opvQ
	(envelope-from <stable+bounces-230426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:50:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF93300CE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29A6301BC2B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EC332604;
	Thu, 26 Mar 2026 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZT6wMSMV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UtN4oC4U"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555D336885;
	Thu, 26 Mar 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507824; cv=fail; b=VV1gHKMkFtoTZdESfzmmbq8iLKCuh+gDZz9PF661zx85OAKNWu70Lgpu2Ud8EbKQYH1RvXaUSSlJfTvzycBJ3ll+aTzhoEkFwSV5mldCuChwMiRHpQKnF1Bt+ISakV26hJom5EdI7mXKrQJouxiROV0cBsjNoX3XHLx/8ChOvrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507824; c=relaxed/simple;
	bh=GnmSF6XUGLu3VsQnSGhs8/Iia24jDgwFN3iXJ0XEkhw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kt/hOgz6NKAKNdb9LkSB4+PUmwOFC8MGxmfkOYbn7cBk9kKZzIYKouNFDLXGiz6jFE8/jK+pX95AUM9oVwV4i8GnZjfn6H1zOzuFKTXEh4DvPGe9Tj/kEafxdlJE7oug2pXtg9r2NklYqkRvwuH+nx2Cj/bcXYBq0MzIB+ky3Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZT6wMSMV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UtN4oC4U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFtx9o2664765;
	Thu, 26 Mar 2026 06:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a8sQZWp4oEryuMU9fvT9WG4XHnuv7eIhPxudwJbaEJE=; b=
	ZT6wMSMVrT8NWqSs0l2XCRZsn+KoRGUOk8LNlK8Tj3IfrTufdotz+hlCszQHCgPs
	aeagYZr5qsKEaHTqcYukaHI5ZITUKf9Y4UQIggVgZ6YNfExlGZlqWBfIMoUe/YAt
	5e8WHdy+xT8Vf3W6rpABCno2KM2FAO1NUwLcNlfl7Nkqzbo99G/sVYyYudKni1dO
	Jnnr8/K24bbcLC3iHoT6w0w1JuCWQHmq8AR+5rELvV2mSAGYWHaje+yJgW51Aykz
	vmP1MeiRbhNhMCiKJWDwLdC7WUWn3t5Q82CE6ByWJ7wNsgZo+dbFONgoPzq19Odl
	CjzzArOIYjymoHNdDImo3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2fqce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 06:50:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q6U30I038371;
	Thu, 26 Mar 2026 06:50:05 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xs5p1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 06:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGlH5u1w2CtIsvzZgpC3DFts+lL12PD7MzXC9n40+mAhzwhVNgFKvRkMOcAOFM9z0v6/WzXE/forquySs+8lJjd7hAPfm3Itq5PxkpRDwO5qDJdBXVRYiJa2IIU1F8d8RBqCtKx71m86xgIjtR7ffjAlGKT3RvUHSn3pm9nxCgEldkmK7hey4To9l9lIqGMDViyVIcqo+GihU3Kl3+25InoJUJTr2hVj59EDDd89sLQyI9UwAlwS9EzAKPIvdkiTtWmNoYNj5P6yKtjcwSqZv18EKehmPeKIzFuDvxb7xrnTA0eRseGs226qEpXJxHYo+nUrbVLUIuErgL4+fLJRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8sQZWp4oEryuMU9fvT9WG4XHnuv7eIhPxudwJbaEJE=;
 b=Opq02YQRvucrucweYjymySf4R3M96onzvC5hHcgl8MlzLLRc8dO2WHkvn8pG3BjA1PKNHbLmyAe6wnPTggH5JlSJ+Qw113eNOABlQDDJfqlKRqSMoEqPM686xEUtmpaofE1W+srVLClqeZGou7HY0wpEWsmgvvFp1HzYOHRd6ghxeFQwzFq+dMKcgzYeJIGaP3rUGg2fC3URCFYeOriVBQmdV3l9kGYGZ7r7CMv8tidmbTydIO9apcR4FtcN+TJACCIFYHjtYwoOupznWmsO9KTkRx7zNWbOGkCmTj3g96lksJX8TKdvTJ9lJKnzen1PgI/aVGr3ig0WbOjm8dALRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8sQZWp4oEryuMU9fvT9WG4XHnuv7eIhPxudwJbaEJE=;
 b=UtN4oC4UyD4ndvGhyUmzURfwD/1rjoEAFtdXWr1lfHgDY8O0M6Zj/31cfu/5AeMa59hu5S6YaZysEbmbTYbPlJ8SltGyBHU5wLwNjmKbhxPBs2H3mNc9pbhgWTZMJDgz2Yye+IbtJJvNQuzHPvDAEn7eTFcZ8b2v3+xxl7JarfQ=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:50:02 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9745.020; Thu, 26 Mar 2026
 06:50:01 +0000
Message-ID: <9223c139-3c0e-49b0-a5c2-27025739e8e9@oracle.com>
Date: Thu, 26 Mar 2026 12:19:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18.19 -- amdgpu bug and a new warning
To: Mario Limonciello <superm1@kernel.org>,
        Cal Peake
 <cp@absolutedigital.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
        jslaby@suse.cz, Alex Deucher <alexander.deucher@amd.com>
References: <2026031914-send-embezzle-1648@gregkh>
 <1df33732-8d66-d669-84a8-259f1b7f3278@absolutedigital.net>
 <156c7e58-df60-44ca-8c26-78ccab2c1647@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <156c7e58-df60-44ca-8c26-78ccab2c1647@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::20) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 73850663-216c-4475-14b4-08de8b03e765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SiHBEMhn1zibZwBVLPLs4gzB+87LmD1inwo0eWwp7BlVae5rdiAruyo8bWW1U6UHTnolmwbJPbsdjFdKNQSG/kxFYpojE2TBzujXeLrnfW4Y/PaANW9EYUIF8KsaC+9M3A2sTHkRNetsW3BU3nBndkAbZhmaMlsNmXDmhV8/cgN3N/SqPqUBK1ew50aUgumsGmLHZ+jVTpaI0wVMvrqU/MlBBDXjBThd1ekQcGIpO1NACKIa398nRV/fhAW1mg2v5ZXmGp2s2P4mESYnAibz6hSuq1mtDh9EmAIgL3icOZJFH2tl/NeRg1cUq2+y3oc9odRZvUBbqjcRCeQXuZ8SmEYOWSlQylE0JOPD+rzh8vaGgPqAg9Docb4den0GJa2YhmQa9/e6kYSTdoLLv7J/WiY1Y5Z5LAg7msUY1zBunlCC7PpeHVaKlAi9bH8Q2twqBR0snYND8oIL27LJy1N5t3JyeoJKzNCZfsr7tnEjUfH9lGfZksa03pY3PSM9Ta7sMyh2/VPgEAlbjMdupd3Z2doQYw0wHzOErnqUynOeiJAq9QMQIgA1ZJb+tbrJ7GIPq8dRo3+ltCqEnJr/qadujwY8xaundkC+/zUJOWP7a7+g+fC1HEzZl/ZQHuR5rW7LpMj6j+beoUqFvVjDv71SaiR1kVW78uQEQUYv3N89U6gXZDXl8x/7n8/Rusz+U+571CJlKH0GwoZAWXhyVpRhSI4FmZZnfVzwnppZ3ip2V3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJUNExCYVhENUVGWVJEM0dCNUoyYUpPeTJFejQyWHB2ZjZDNmJjNnQyNUNZ?=
 =?utf-8?B?S01GV0RkVDJmMExzZUZxRk9iWEllSEZNUUlHSjN6YUV0K2JDdTR5MjNxWVRY?=
 =?utf-8?B?Kzl4amhBaXdTVU5oRnVDKy93QzJZR3JwUzZqVGpSYmFhVzhpZDhRa01VOFV4?=
 =?utf-8?B?UUxRcmg0N0F6QnVKc3o3MWRaTFMwSVVEMUNhUTlLTHl5Qnk1LzJNRHBnQUlY?=
 =?utf-8?B?UGhqR3dhV1QyS1FSeXNnVVR5MXduSnJkY1dGK1N4Yk03Z2ZPQmo5ZkgxSG9V?=
 =?utf-8?B?YkFIMDcreWxCZ0Q3OU53ZEZGSWlaZEFjbWFMNnZad3ZPb0tia3J6eFE5OTZL?=
 =?utf-8?B?ZUZTWkZXVkdLWW5nMTRZKzF5Tm10YTBKZnplTTFab1AveGlYUi9DS3VMc2hT?=
 =?utf-8?B?S3JSd3lHUjBOT3lRWENka3kvTytaRXhIVitGVjFWekRlL2ZudW55M2xMaENm?=
 =?utf-8?B?VjlSb3pjREJCdW9VZnpuaWZCMnJ4aHRPL1N3QnhJbk1INVo4Q0F5cHZScVVp?=
 =?utf-8?B?LzYya2ZnMWdmMlBmT1NIdDBHUWt4UmFTTnZKbi9UaUJyK1lXNnJUT2tVQzQ4?=
 =?utf-8?B?YzJveHNYNDZkQzF2c1BRTXhvQnVMMThwekc5Y0I1NU9wc0VnSmxyWmw0aDVV?=
 =?utf-8?B?dVpya3VvMmxXNllwN3dhZHRnNnlZSEJ6dzA5aHZzZHZ1YnJPZWY3anpYaTVX?=
 =?utf-8?B?Y2gwZk1xUzFuUWJoQUlvc0VzZlpnM2tRNkNTVGNjMHd2WVhIbEwwRWFLb0lm?=
 =?utf-8?B?MWV4S1EwVldCYzBBakxycTI2cVhkazY0TmJUOVQxRHlkN1QvYklTOXB3a3VF?=
 =?utf-8?B?bUgyM1VYQWJCSmFQSEY4akduNHJwNENCbUcwdjJUcmlJUGNZQU1uR3RMeS9E?=
 =?utf-8?B?V2tiV2JyNExoU0I5b2N4WkVBNUY3VDMxaUNpbkY0MC9BbnFrV1UrWVpSRkJk?=
 =?utf-8?B?bTFzWlNYS2htVjlQZ0dNWlMwQU41UlBJbTV5aEk2NGZMbnBWeWhWaTI3Y25p?=
 =?utf-8?B?aE54OXhZVFBSMDNCY1c2SnJyYW1tSjd3SUZQak5UbHJhQmw2Y3FLanNZVkw3?=
 =?utf-8?B?UU12NXowMXAzM1VGbjFtNUZock1tQUZYWi9pRmZ1dDNRamFsWHQ2Z21aZjJB?=
 =?utf-8?B?V1lPQk1uK0Y0bDRqcVlheVNkamQ2UGpmOUExR0M3TkNOL3kvTjQwRWhJcXV5?=
 =?utf-8?B?clg2QWlBdHVkMXFod2N3M042WlhXS0NBYkJQWDdtTjJVWU9RdW90WWZnQjBX?=
 =?utf-8?B?cXY3RlhBWk54WGkvU01kYk9wbmp1RlNXZC9pbzZhMEUrbFhaY2ZwYTZValo1?=
 =?utf-8?B?aWdVTXVpdXgrbktoMFMyTlVIWmlTZkcrOXhYZHNuM0hiTmRxM3JrYzRKZWVr?=
 =?utf-8?B?U29GZGY4YzVVUlpic2xqeFl2ZjgvN0F0MUZaOGU5T3UxK1VDNFZBeUc4cUl3?=
 =?utf-8?B?T0YvcHA2aGZTUnRZeWxWdndNYUg1L0ZkMzZISzlibzg0SGx5cmx3dk51ZzlS?=
 =?utf-8?B?TW4yODY3U01GOWg5Wmd1TFJOWmZmczUwYy85MXlXbzBxczkwOUlDbUdLbkNz?=
 =?utf-8?B?eEpyMWNMRDZ0bitnOHRYZFVVR3BFR056c2FaZDZLWkZpODdyU1B4YnIwZEl2?=
 =?utf-8?B?TmdaVmxpZDk4cUxUSXV4UWdHbmdLempGelg3aWlrMCtlazdTa0dJTVhFVEJL?=
 =?utf-8?B?K2UzSitBa210VmlSN0NMekFpZmNZQnYwTDVhb2RvR2dnZE5GRVA4KzhMMHdq?=
 =?utf-8?B?SStTSy9najJUL0o2VVFkMndHQmR5TXdlU0ZFZEpNaDJqVHZaVm9xY2pkWkRT?=
 =?utf-8?B?WVhBS0lCN2p0K08rWHlpM05BVjRkL3Q4K3ZJVXNITTNmWGtEWWM3UDY4dXpo?=
 =?utf-8?B?NzdjdWRycEhjWlBvdmx3L0J6cFQ3blh4Ny9laHRGdjFIZTBvQzJwT1JaMXRi?=
 =?utf-8?B?U2dYU0lQbW5KSUViWFh1L0l4WG5MbHk2aXhhcTh4S3ZWTU45N2diUExPY3hU?=
 =?utf-8?B?RmZEWXBJOVJ0aFAwM0xYL0x3TFRzZW4xZS85Z3RndVI4MlJlcjlDYi9adkw1?=
 =?utf-8?B?UW43cmNUQ3lBczUycVA4dUdhL2Vra2V3TEF3TlNwdEZRUjUyVk1ld0N1Wnhn?=
 =?utf-8?B?NHMvZGROSlZFK2huRUpZWFo5bzM4SVFJY2xjSmNLb0xHelJVUjRQZVM3V1dE?=
 =?utf-8?B?K1J2OVJSRGRHdjdYcEJKa3RMZlBOeFp6TXBCUlNYUjFEMGZmT1FxMUl2ekJO?=
 =?utf-8?B?MWdjeWVtWkxlRkwrOVF1VzNLOXQzOVdyeS9oaVQwVG5vYUJzV0xYMGp0UjU2?=
 =?utf-8?B?Mm1VV1ZsNVJBTE1QZU5LZjFMN3p0L0oxN3VEUkc3bjZDRlhuV2p1eXB4cjhS?=
 =?utf-8?Q?9iHQtHaoYb4tWbiyey0ep5QWfKXTwWz6kUn9p?=
X-Exchange-RoutingPolicyChecked:
	ld/a2qexylfMajSK+2ZOaRNa/L3VkSDp0sExAkt1MK9uCQRknBbWo+BvVa6Sl0u1rsYB8hB67lClcd8U+nFOvkn3WTbeQSXShosNQy/gY8pzW1I5RA0SwZK+oIY3SEd98/jTF52filmpUroWoamiF9Ruw5g4A3QcNLrKst/V/fWlzfPDPBpi8TcdqdnZKCUNDxpqYgwe1SwSjMukjSeCeKGY5t2qOcPFIvRQH8b9mISaKrD0gzShlVfQ8J9W73cfZyH3qoBLj9RKfSJcCUDyghbnYNB9r5MuA7wRP7TOUKJWQOTsA95oSY4zT8C2v2GB4pjxz4FCZviDma1a5PKXmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kKyifqJvCoDfa1TGKWADW+DZ1GN6J0yKO3HBwEaU+T/tYKQbl/pmLyDJJGlDU62Z4R7BmuYYfbA6rBPPujXok7NeKKCEN1XJiZjRCnnrC1YPy5hNvRIHdhym8r7wIj1E78Lh7GfTaqLcjNOtc5/WAncEqLfgU8VHPcDuI4a2XOARtyduHohga1xDcK7Mmw7/8NMqTqYPgTF90dxYh9h7as1K30VaJSQT37iJPPwWJOpiIAwbQeSNQDtJNjCOtcVYUJMSs9L6lJ4Z0dHGxDo6ja/UMESfhbH9NE0E1dWTOumF27JDRs2HYHkXFPAQKZ9aTuMntQuRTbRIC1ZdDh2DOM29TR5ykcwD/YMIq3da6xpNaAbCXYo1YHE36gpluldK9P087C2295kUjQyNddu199cfzL3+2DWvNUrYs6U6AoVBuzFHcLvFKAZlR/t+pHJuxDgXxqz8WFpZ3Rr1dVAfsyhcE633Vh5LsB/eeAcayeoa6aVPfc6gwSL/M/i0SI1IqtwkhVr4TA1byGSFFoykdgFkc7Iqus8P2+L5C+v7ojh3edAWKaaHgXTMbnWDdlwsi9aVpJumtB58sc4ircqaZQXzp2hs/LvPsLsfpo6WZbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73850663-216c-4475-14b4-08de8b03e765
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:50:01.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iP7zCdRg3xRy1jLHBZBMxQ6Hj2Nu/9qBieLp3HANSleSYOPhR2NQTjJgRM8xyJG7LIg+6XR8siDQFaCU1Ywk7J79m5y1C/Pr0GM9selQsDvmf7Sq8ESunP8A7H14zob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260049
X-Proofpoint-ORIG-GUID: sYt8TPSARzFjncrB0hp1sNRea3v9Oyf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA1MCBTYWx0ZWRfX01m2eVwTBiSS
 3rsjx5kQ/yuW0jAYlZiseytP8ITcdGGl6YUymipcdJw/SYUB/ucbSsCWfG+4+tELiUGbu/iw2Rv
 zll03hJc5YLhKl6d0dlL7vGhNmxF+SGx5GT/fsW1WJTLWl9oZ7z48Vw4c415sdzxCAiZV6TU7Yz
 0/9fTKisGmQ4vy8lnOm8Bb5i29ijLOsVjme0mwGaeUUQKSGTjO72eOSESYv44WqDK8fytp1zD+2
 cgFA4wpCucCfFnppP0SYLww3d4quARPj0q6FuuRez0ax9sLK9M9x4yivtobZT2oszx0TDIiQ7ow
 4WztYhkBLBOMFAwsomPgn46LmOaisLhjfuKJ7xnenuuDeu/o7rZIDATsawQWnatWdgDFcpzFe0i
 v1307P3A1fxO3tujXnyUXLsx7njKuc7JLm2CXaXc50X2Orb9mjUOF/X2b1DV7BIffv7OmSB0s98
 1Wjy0WDKdEuJMOIQMcGkuJSsNK2lixKG9W/WmdPs=
X-Proofpoint-GUID: sYt8TPSARzFjncrB0hp1sNRea3v9Oyf8
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c4d71e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=4PkGp1oktIktu0GHUjMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12273
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230426-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bind-device.sh:url,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4FEF93300CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

>>
>> A commit in 6.18.19 has introduced a bug and a new warning when doing
>> amdgpu driver re-binding. In addition to the bug, the last line of the
>> output below is a new warning re: the thermal alert
>>
>> This bug doesn't seem to cause any show-stopping problems, but it is a 
>> bug
>> and it persists into 6.18.20.
>>
>> I can do a bisect if needed, but I'm hoping one of our AMD guys can more
>> quickly spot what's going on :)
> 
> Are you saying it is from 6.18.18 to 6.18.19 it was introduced?  Nothing 
> immediately jumps out to me.  So I would say bisect please.
> 

I think backporting this would help ?

commit: e12603bf2c3d ("drm/amd/pm: fix amdgpu_irq enabled counter 
unbalanced on smu v11.0")

>>
>>
>>    amdgpu 0000:14:00.0: amdgpu: amdgpu: finishing device.
>>    ------------[ cut here ]------------
>>    WARNING: CPU: 1 PID: 2773 at drivers/gpu/drm/amd/amdgpu/ 
>> amdgpu_irq.c:639 amdgpu_irq_put+0xa4/0xc0 [amdgpu]
...
>>    CPU: 1 UID: 0 PID: 2773 Comm: bind-device.sh Not tainted 6.18.20 #1 
>> PREEMPT(lazy)
..
>>     <TASK>
>>     smu_smc_hw_cleanup+0x61/0x490 [amdgpu]
>>     smu_hw_fini+0xef/0x180 [amdgpu]
>>     amdgpu_ip_block_hw_fini+0x37/0x41 [amdgpu]
Thanks,
Harshit

