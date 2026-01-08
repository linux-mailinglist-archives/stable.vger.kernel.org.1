Return-Path: <stable+bounces-206348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0DD031A0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 787BA30CA42E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4806396B6B;
	Thu,  8 Jan 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fc41ABWG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C3ZWluN/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C48397ADB;
	Thu,  8 Jan 2026 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878594; cv=fail; b=P9OlW37YkYT4ivLUUbNB4QNMQzRR4LWf/SJShPH3R9vVyFzGQWjxuMV0aS7aju0Gt8oEYhAe2HjlA4lsLD0vO5RU7t0tuBL7gUvorHa1a89tae0AgM6qZQRT+GGJ4ETbRcXk1N1oX+mGpH5gdPhXnjxZc4Wj7wN86QUUhrPzKzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878594; c=relaxed/simple;
	bh=r0B0A86iN0KWRxNgvV5kss6EnhzDKhXZ6WRgm8TsRqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQHlX5MMJ70Pq+mqf4v/05Rs0j5rDJoWHrx28179M0p3F8xquB5PLSXG1qU+hVCtQUkM+xRWWffPLkhsR7olqFh5AY0O4Gx9v8Cxt6vhkSnw2JGbVrohNrbakgpDR3E+tDrP3PVDN2dB/Nz5D2aLfJTMq6Kf3twuYn4KTfHFxgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fc41ABWG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C3ZWluN/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608CnZ9q695909;
	Thu, 8 Jan 2026 13:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=izae+nuwzdywOoKgM0oyY7CYBfh/LJjYvyyuzuCL7Lk=; b=
	Fc41ABWGQ9S27lJbWI8B56GezHoTS/xrLFOdeNkG2m24NhiiREYEwzxw888W+lr5
	0/GElQL3OTQNL9yxvOxqVzEbxPvoIMYSdbwUcM1/c5fYQFTGJ4oR8wL5VcSj5dHe
	9lMAJu8sGzfACU9WtftD9NbaYrNj7FAv/gbf8fgidLKWPR+dWwpARjxnZ7D1SHN8
	+3r04V1juwtFPNDb3EGEp/1AX916e2DzfaJ4iKcCY6roxR2pNCHRCu7cdb9nYDtx
	6YIO+l6+BVEIJhA+WezYIaQK1UWmOYEGg7W/MyD6VmC5sp8akNMap6MY10h9WJgu
	I+cpWXeGsQv/uRU+LgCCYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjcx1814j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 13:22:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608BxEac035120;
	Thu, 8 Jan 2026 13:22:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjatw2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 13:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj4C4ifmmJwNM7JFaSyNLIzGn9jrrHbpjGsLyN4dc+IcPoYFYn280vlb50go6L9tsvK9Uh19sBzOc9whEe4mM0IfvwUSF5BzNiECJ44/QiyKljRgu2NtEHozNeMnuUqJGClOFFRiBvWLOuMI3/HPkgVapHyA1FE78e13KpKqZcb6Jo1utSYugsWLgu4008NnUj2YoYP41F72oB5rRiYun7PzEcDwCWPf+prHyxA/7CzS7j4fY+RqowuoEWG9qwztFNvTlqf4chfgDAaN1JQjuWhA8uc6Xo1lM6ypLw/EixUVq8xlEPZJ703wXemj5MGSGVLEVo+aag3qUjY2CPXdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izae+nuwzdywOoKgM0oyY7CYBfh/LJjYvyyuzuCL7Lk=;
 b=XuMDQPrFihWgsi58OC5SfWUM9Wsa2aNGTKFFFkKHZ/5t7ARt/BjbSwRzdS0Clr7Hhnqpms8mZfczDFQy5ec8o9een87cdyRKCHB25CxZQ7mCND8eRQtxK4O1YTTJNUjkadjxC7gc32HOZ4Gvb+U/LYqJ/FQ/0rknxmBaRK4hABID95OxhFGdz9yBLLotVGMBlEXy5373ZwGPDDx4CEsq6OXok3yDyKqwCENZQ2mHC6Ku2becJQ/dMN3bRb8QK6Wex8ARuim1o5WRx+atJffem5O5/Eq+f51lxvwQM0ztZu1hsCaEh8/1jWxbyw/fvWyaA2UmGCHepiVQ50jg75pylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izae+nuwzdywOoKgM0oyY7CYBfh/LJjYvyyuzuCL7Lk=;
 b=C3ZWluN/C2G0vjyQgszRpQZ1GZhpCzxc7OzNmBxw+Ygw2AR64PLeCOB1ewjncP9Wah2U8D8l9ID6F6trS1k2iW1fEQ5FP6rJzTCJFljKraQn+z9jgBt0jGEi847lqKgWTB7sJ7cahHR2XqRu7HDiG7No1LrKNgDDUPp5e8q8wKo=
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6) by DM4PR10MB7390.namprd10.prod.outlook.com
 (2603:10b6:8:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 13:22:37 +0000
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83]) by CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:22:36 +0000
Message-ID: <574e390c-b6c7-4b7a-88e0-1166d17f6b34@oracle.com>
Date: Thu, 8 Jan 2026 18:52:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.12] usbnet: Fix using smp_processor_id() in preemptible
 code warnings
To: Rahul Sharma <black.hawk@163.com>, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zqiang <qiang.zhang@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260107081855.743357-1-black.hawk@163.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260107081855.743357-1-black.hawk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0233.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::22) To CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR10MB997695:EE_|DM4PR10MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: b2417099-9913-413f-2c85-08de4eb8fd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm9HZmtnTDVheFgwVzBLWWhHL0IxNzV6emxCZ3RUQ3JDMzU5clByMUxXcisz?=
 =?utf-8?B?L0VLdEFiQUs1V2FVR1RqQ0taNjhHV01EdGdFcU5pMlFONjRzWFdGbDQ5Snpt?=
 =?utf-8?B?aWtXWXN2TkdRd1BFRjNVTnRaQWtuRGVPS2R6VjRJWkgwd0tIcTVvWjZRSlFH?=
 =?utf-8?B?UHZ0NmhWRjlmYTZBSU1GM3VYNlVJdnVmcjc2blZSaG9kTFRUTmZWaUlJL0VX?=
 =?utf-8?B?OG9tRk0zS1ptSFF6Yk5tdTNldUtuZmZ2OEdDWG4yS3hJUWJaU3cvS29Cdmgw?=
 =?utf-8?B?VmpIcXdwN0Z5d1VBK2czSWw4R0R3TGpwWkVmK2E2TGlrS3lMSkdqTGpneWNI?=
 =?utf-8?B?dVprSDRiVEFSWlpsV2p2dnBiVXpKRHh2ZTkreHZrR05qWEZldmdhckxZU1BD?=
 =?utf-8?B?MTllalBEZEFBUFE4RTMrVmlCTHdST3g3aVVZRitXZDY5YVdsWnhZeS9lMXhC?=
 =?utf-8?B?SmxXVzEzNFg3akxaVURZUi9mZFlSZ2pTR0ExQnNYWGhXWFN5bXNESlZqc0tt?=
 =?utf-8?B?WER3dWVnclhwem85QUdObjducXFFUy9iKy9GaG5YWHlWTDZ5OGk2anh5WWlC?=
 =?utf-8?B?Q2lSTWpwdzUyTENMYndOdEI1NVFocldCUkMyNFlSck4xUCtRakYrcWVWYVRW?=
 =?utf-8?B?YzEzdDhQQWVBL1VBazhWaGQ4dDdtbnFndnJEcStEdlR6L1lwZnBZVzUvbkIv?=
 =?utf-8?B?VjZsWjJ2ZzN4S21RWHlKT1BxMmJGRFZtNDA2RXJFY0hxZXJITjV5U2tzcVRw?=
 =?utf-8?B?WnBMbkl6b00rWmowUVkrY3k2RWdXMGNuNUhXSnM2NEM5NVozRmVyb3V3Vm5C?=
 =?utf-8?B?ckZjNlZPSzg3UmZnc0tZOHlUaE8vUytXNUxwQnlnNVlrQ096NW42cG9HbnRi?=
 =?utf-8?B?K1NUK2gzWk9zSnEzQnpya2RTR1VVcDA0YW42T3pNZjBpUTRhdk83akdyclFN?=
 =?utf-8?B?S200bXRPbnlSa2daM1h4WmF2RmE2QnluU2RLR1VhRGlHTTRVc2h0VjlpdGoy?=
 =?utf-8?B?WTVFYzhHY0VkNU1IRDVqUXBjaFlMTjhueG9hSmpjd0FHa3FRTXhMNmRvclVF?=
 =?utf-8?B?RTZBSFFsNXh3cUlUMjlXdm1HcTR0STJ2MTc5NHYrSmZYR1JhZG9vdjlSZzFy?=
 =?utf-8?B?N3c3TzQvN2hGQVJxY3BFbjNEekpJRmZPRE1rT1k5UnphU0pEdlNBK0xLekhH?=
 =?utf-8?B?anQ4VFYwNkNpcmZ2eUMyMCt4VlJWSWs1MWlTSUxpQllHMk0wQUZ3UmJTbDRu?=
 =?utf-8?B?MHdtMy9wU3I0K0RqelNyNWREN3l4czQvblcvTG1iQUVCWkxKTXl5VTYvQklq?=
 =?utf-8?B?S3RyY3V2QkJZNURvVTVZTEo3UEMyQXZHL2Q3M1FqZmhTcVkrWjVwSUl0WC9p?=
 =?utf-8?B?NkltRVJENnVob0RDQ250MHRoeW1jdmxmSlkxV0svMGRYazRLS2ZHckprZWEy?=
 =?utf-8?B?ZmZiODAzNDlPV3lrTyt6UVg5ZU9aTXczTUhnOGJYM0dxcjZxZ1J6VjQ0ajV4?=
 =?utf-8?B?VUg1R21EbjVKYW4rZFZIN0xSNXZ6UDBKV0crc1hxOTN6SEJ5cTkyc0RRSnor?=
 =?utf-8?B?V2RsMUJpVTJwZVE4MUxjWWNGaUFNZUI2MXprY2QzMTlJNHVRYkczdFhtVjB4?=
 =?utf-8?B?VFcvMEdCVW4vQkNIc201RmoxbHBGQitKS0FURHBJRUM4blJEb25qV0FIMG55?=
 =?utf-8?B?dHpyakhQNTh1U1hHL3ZXM3c1MXVBUHplMFpqTlpyNGNHbENWYnRRaVdQSmtw?=
 =?utf-8?B?S2gzQVMzb1NtekY2QkhJdEJhL1dmWDNicFRqNzFXcFVEbm9WMkMzcW1TdHpV?=
 =?utf-8?B?SUxkUGd0NU9udnBWeDBiNWFKbkMyckZsNHRiemhHaWFuckQzc1N2a0w2ZlJr?=
 =?utf-8?B?VlVNVVdjRFl0d1NKZWlXVTFNMEJNT25JZjFXeDgySmF5dlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH5PR10MB997695.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVSZEJZK3ptQUNJSVJEMVlQVnROYVRDYk15Zkl2OEtaOFNCdEp3eGhxa2R2?=
 =?utf-8?B?dVQ0ZTlPNUFDY2hKa0ZWamZOMlJxcU5OZVdwYU5qZHJDbVBUaCtOMnJkWnZO?=
 =?utf-8?B?Yk4wT3R1aE5za1hXVmRObzh4MXN0OWxYRlRRTGhXbnppcElLcWlBNE1YVzAx?=
 =?utf-8?B?cnRiZ3lSRXAvcEZvWmIvUnYycFJLcWJDaWwrTkhGK1JNNzJxSHdPeDZVNkZw?=
 =?utf-8?B?bFJHemhGUnZ5dXNZTWtsVUhpMVpTamdUSW41Zll1NU1FaXllS2tzckYxenVO?=
 =?utf-8?B?Z2toTFViUWJzbXM4d0o4MTBhaG5PS0RTUlBsRGk4YUhYSmtTdEJJSFo0ekFr?=
 =?utf-8?B?YllvRTVpbFZZQURDQmFsYVQxYzhSNWNnSnVJZk5ybytiaWZpWWRNUE5FVzFm?=
 =?utf-8?B?SlgyUkdaeXV4SEk1VEVIYWRtVjFmWXgzRml2bXNOV3dVeE1zLzhhOFpLL2wx?=
 =?utf-8?B?ZGpJNzdjNTJYV3ZDVklzZFBhaUUxTENaMzFSK2pJcGY2cXpDdGd3WTd0N1NI?=
 =?utf-8?B?bldvNXhmTGgyUHlwZEF2OURJcW9vWllSWVh6cG4vSVZZZ21lcS9HbHNVMjRH?=
 =?utf-8?B?OEwwV0JBWFVEVFlsNlpJNHZEV1I5LzBGcis0K2dsTi9sMVdxbjRzTTRVL096?=
 =?utf-8?B?Ymg5R1Y2cHpGU3Zwb3JuTC9CY2tGdTVFYXE4NnMybVBPZE1GbnpjaUtaWm4z?=
 =?utf-8?B?OUUraklxMzZKWjhPZjVTWGtXVzNZVVo0ZTM3bWp0NGorb0puaFJuUGNIM3pG?=
 =?utf-8?B?d2ZHVEJiUmRHSkt6VEtpREwrbU5pQTJ2aUhlQlNVdER3UEgwRDFwSldqMjJN?=
 =?utf-8?B?ZG5YMTk3WXFWNU1wUEtqVllhU0IrWWkzY1ZCdkJjK0RlQk5NLzhjYStRN1pZ?=
 =?utf-8?B?QU5ISGNqQndIVlFnQlhJem91QWdyS3JYVC9RYnplNXFBRERtSy9qbTRKbS8y?=
 =?utf-8?B?TVMxdm95eTlFcE5nYTJOOHpGSDBOdnNRZUx2K002dk5OTFg5SmlhN2tTT2Jx?=
 =?utf-8?B?bUZudXJaeVJzZXZla0Z6RzB2ZEh1RWNybkdaamVLYVp2UXV2UmprOTBNNTFE?=
 =?utf-8?B?ZkRsR1I4d2JwWnUyNll1d1lMdEtnRk5hZUx1endpQy91ZVQ4bW9uTkdYT2RD?=
 =?utf-8?B?dzhWQXhnRE83UmZVVXlocEdtUnhWSEVOYUtQa3VBV1Z4UFNRTERYZGtGczM2?=
 =?utf-8?B?aXZBQ3NBWjEvbWhOeVhFSzNJQS9URDRQNUpnbVUvci90L00xUUViaXpXVlJk?=
 =?utf-8?B?cUNqSjdIZkVGWEFPMnY1Zkl3aFpUMXlFVmJjSjFCS1dUT3FESm50NEk2dGNu?=
 =?utf-8?B?Q2w0WnZOazdwZkZTS1BhSzg5U0d0cE5XaGdHVDNQVkpGVldWYlNVWVlLcStR?=
 =?utf-8?B?My9QR3kvVERLbldEWUd2YVgxV0lEWWpEdHdYZXpFUDdmdFdaWTExaG5yTGl5?=
 =?utf-8?B?czNZLzlOS254cGJyMjY1MnMzMGVnVzMvV01QTmZ2V2hGVVNMVlVtSGFhNmhG?=
 =?utf-8?B?QVpQekRRWGxLbXVlUTFVcUQzdE96VjhpSlVIZzdnWFJDZ3pCMzk1Y1VXMnpB?=
 =?utf-8?B?ZlJ2azJaKzc2S3c3SnI0enZ6MnJQTnJldDFzY3dJOG83alM5TVgraGxaSDZv?=
 =?utf-8?B?RlVnUlhCbzg0b3I5Q0tONjhod0JsVFVVYVdxSGp6Y1dRRURqcHczZmRLSlJo?=
 =?utf-8?B?YW9RSlBXSkJlSWJGekRPOGxaTGJmb091R014R2RGV2RnbWZaTThkYU0xOURj?=
 =?utf-8?B?WWtsTU56N3hCVUlPVStUNTVjMW9KS1UrbUNqN2xMOHFJT3IvMFJ1WUdqSWZH?=
 =?utf-8?B?ZnBwUEhQdFEzWjZCVUs3T3JYMXN5Zml3ZzJkaWloSCt5QTZVWDg0VlY3dW1h?=
 =?utf-8?B?RmpWcXJlSll1M1BzdU1WUEkrdFdQMndHZjBFdEc3YmM4WjVpUjVpRFp3Y25z?=
 =?utf-8?B?b3BXWk5PcklyeUNhdDJwT01PVi9zS09LOVIwY1B5SkREM2VwVTFTS3Y1Zlpi?=
 =?utf-8?B?dXRSa1dSNG5Qc1A3WC9qOTZkMVp3V2dEUkpZRDdFY0N6bjhMdFBYM3p1NUxj?=
 =?utf-8?B?RFBBSVUrMjNRSXhmL3FvMXQrOXJJNFM3bDN6WTRlQ0oxd1Z3UXkxUEVlVVJQ?=
 =?utf-8?B?ZENNVmV2NkEwUkdXdHlLVVZqZXBlSjY4Rk00TW1HdW1DNVpWcU52bzVob0pu?=
 =?utf-8?B?N3Z2bmlkSlkzcXNaSEQxNU8rL1VQYldwcEN2R09nZVlBSmJJdCtpWDRTWktt?=
 =?utf-8?B?TXpna1JIY3NUVUZGR0c5MDBGSm8wT1JqeWxNanFPRzZQWHErSUovVGgyTHpJ?=
 =?utf-8?B?ODZRbUJQNEhKSUxLMFdQbUhEdUpQdm5wZDR4RjhidHEybGJDT092RHNISkJI?=
 =?utf-8?Q?tUIQw54f7jbyt1Qt2xZKtWtKYyMb1dztpCfys?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p+/CqX4lZ4EFJxP9YGgPvkENponMwfr9iL3USINdzZYguZlz5WlXNaknZJrjLJBKlsrbUTUplLEAY/XdBoht32dBgUW99Qh9a+1CegMZ+DhyLt/wvnUWR3td8j0BUhyDBQXbX80RfrvnTKI4uUde6vm9PuOTn3Z/zuJ/TCOaJYqYcxPZsBO5M1nNhVedbLM64PxPJTwjEPgRe/xDkfjb4+JpdHy0FEy6L/XucgSy7vA1YXDO8VGQ+Mi+/P+UMPY5+n8VZXa3xMMiL6QEWfDaphV/+1o0SIRRcCgKtFAzgYk7znDaS9ZO/e2usSktJImzUbYTfJ44B/TdFG+4/6aDqEMVAcyENhfVJSd7dnY4m+4OouuXll6q9z7paLfcMIT59V8jK1LHNZeIXy3FtVMLKsGNaY1Ijo/HCOk/DeU4BnEmfC1j7g0OSFpEo7CXSGTdZodCsuT1d4g6mpgb/lFkbAbzlCuvp1YRMstDEsu+rzjW41scZBr6FJX8d2DMY379uLt4M9dcd7vYtjHCqwLIxAqLM0Wz+2PbMKu3EQ8Coy97TLn4/R2M6RUmhxvDyFAV3BM0uAK8Q43o6g+RSkJhpj6hq6iklU27m5JR+nLB0TE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2417099-9913-413f-2c85-08de4eb8fd4e
X-MS-Exchange-CrossTenant-AuthSource: CH5PR10MB997695.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:22:36.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dqZPOfPrh1AxK+0fsdI3smncrdW5jsGTWjoF1TRUZOvaVYaajGI09zaRnxYbb58Tzx95AeuC/kobv+4TYExMhX5x1BmySo7AXs5EG3RAfFaVi4A39h86oFRW5h2fRZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=772 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080094
X-Authority-Analysis: v=2.4 cv=CaEFJbrl c=1 sm=1 tr=0 ts=695fafa3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=20KFwNOVAAAA:8 a=Byx-y9mGAAAA:8 a=Q4wKaa-KC88Z4bEv6dwA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5NSBTYWx0ZWRfX3UMOvDxR8C3R
 I4jbyPXIBzerCw9cBYQVAf1T5LKWFqHalSj/wiRQ4KYif4Xy6BDC+yvykomTChzwU02ngxqwEZ+
 v7Mhn97GoA+gj7fv1/4sh6/P2XSBYw1MqAPXsJaQ5AmVskEZorDy89EknSWniwU5ua/c5O7VTE9
 /l0OBpcBUhmvnrwXGTuIRSB7oP+SmdXGO/Nt2AjzHaXl8MscNb6K9yR4CFFcPJnmnOqwVSsTLqc
 AUcwYTHdY0nb1or8dU6wAJB77nDt6gcIniUnS3JQGJa1X7cyJH1iDz49La6t9zaIstPu5/bOJJz
 /5dM0c28l+rA3P0ZyuJal/ek3bPE0tYnkt6zR58dD8qpth3chCH5IONO0yNivW9QCKTk1dPc9TI
 JAYebcH4PI85Q125GWoHABZT2RnspQzK14k/Vbtu1/l6SvPYB/4JyrqpTt8kJs4KTFkBx/8/8Po
 z9A75DaH8CH7buhusCA==
X-Proofpoint-ORIG-GUID: cTlWsk_zMzSLSolNuQJUwjs7ABUw23xa
X-Proofpoint-GUID: cTlWsk_zMzSLSolNuQJUwjs7ABUw23xa

Hi Rahul,
On 07/01/26 13:48, Rahul Sharma wrote:
> From: Zqiang <qiang.zhang@linux.dev>
> 
> Syzbot reported the following warning:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
> caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
> CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary)
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>   check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
>   usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
>   usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
>   usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
>   __dev_set_mtu net/core/dev.c:9443 [inline]
>   netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
>   netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
>   dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
>   dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
>   dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
>   sock_do_ioctl+0x19d/0x280 net/socket.c:1204
>   sock_ioctl+0x42f/0x6a0 net/socket.c:1311
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> For historical and portability reasons, the netif_rx() is usually
> run in the softirq or interrupt context, this commit therefore add
> local_bh_disable/enable() protection in the usbnet_resume_rx().
> 
> Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
> Link: https://syzkaller.appspot.com/bug?id=81f55dfa587ee544baaaa5a359a060512228c1e1
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Link: https://patch.msgid.link/20251011070518.7095-1-qiang.zhang@linux.dev
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [ The context change is due to the commit 2c04d279e857
> ("net: usb: Convert tasklet API to new bottom half workqueue mechanism")
> in v6.17 which is irrelevant to the logic of this patch.]
> Signed-off-by: Rahul Sharma <black.hawk@163.com>
> ---

Greg already queued this for 6.12.64: 
https://lore.kernel.org/all/20260106170510.964268694@linuxfoundation.org/

and 6.12.64 is now released. So I think we can skip this patch.

Also, if you want to figure this out without searching on lore. You 
could use stable-queue repo to see if a patch you are trying to backport 
is already being backported by someone else.

stable-queue repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/

Thanks,
Harshit


