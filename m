Return-Path: <stable+bounces-139133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C34AA4927
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EBD1BC29CA
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB125A658;
	Wed, 30 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AjyYB9Lr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CYF5RogU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2F25B1C9;
	Wed, 30 Apr 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009775; cv=fail; b=KnJ9vTwdVtvC5MjHBYDyRMSy38Exsj/v1FIVTbR8caMkATE9YN271zVe/uN24tZmIK//61Jy1HB+Td7cCefOQJ6R/5RMlS5gpQSxEvSRIR2xoJ0J85VmrdSq/88UEd2qUtg7JOaoILvxg/SnqJ86k3EoEPVeSYhiohlJNirhYyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009775; c=relaxed/simple;
	bh=Mi8oRpkZefB37ZGboLPAI0peNxahrTv3InAh1vkZfBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/L4yzSvyk/eRYbrn3gjd2yP0q/8S/lIHOljL5VOThMLEgFce2qWEzh6rSXTF/OeN75Fs/F/G9jwlCNhIOMhrAg0mNCyMwmlZ7lQL8sdX+rZDgcVEnPUIM9BBCu7cGsQB7uQca3ClOISkRbQc+MG2ngbe11yRszh2K95+anSwlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AjyYB9Lr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CYF5RogU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U6Qnn7013031;
	Wed, 30 Apr 2025 10:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PvUqhaBgiXFiF4/bD6OV5P0qq0ABu2hptPx5mikO0uw=; b=
	AjyYB9LrFU7kjHm15jhndsw7vaQ7S8BngNbW+gumEclLg+BetrT109XOpV3jg9yW
	xyP0t3FzCuMf1H3T3DysSviKft6xCiCSVmpe6sPAH9vPsuEBbUCU+SYluqVN0j5d
	iVccjC1xMW1yZWcCosqN1oYjBqNGPs9fGv2lWOFfw0T6msd6h2xW7+S0zgIOtZpb
	QCk7bLv3jBHKB7D5LocWzWJMYcQzO7vHkXndfVakRAw+JKgXGw0pzl/ZqSuccHiq
	mcq7/msy89AYxV86LdFXd2miNpYEtNVkISdnPXxLBxHvOQVisJUhvtxwqp4HrOEc
	+bhDIUIoZxGsDfRTJIxkdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqgven-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 10:42:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53U9poJ0033587;
	Wed, 30 Apr 2025 10:42:12 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxb4rv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 10:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOCn+pNwP0ZA3aEoX+jC+/EoUmHHU7Iq2iIKr8a3CSbessYn5/efzrNMYaVtaU1JaQTGhZSqj+LWhk+yiLgiwGyaFzmwmKI+REIg7temOxy91xdBjHSV28DOacUrERIaOjU56tImMOGC0TWa/ogsNqB6NE9HzB41Sh3FrTBtSnDEFrN/UF6G1bPdzpqL8gZ7E2tqyLYS8Pj0e+uPj9A/5L9mtHhUP+/nlmPPs5gnFLe3QYIeL59AX/bgL0zYKPJSSHrXDFW1WNfEn3jTFsbIDlzm0CqOdj0EQNJLhp1MZp4x+GjAR4kjyJXyFcyBUmwUUA6hvhcepoJ5FA71A/xc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvUqhaBgiXFiF4/bD6OV5P0qq0ABu2hptPx5mikO0uw=;
 b=Jy9CAshPvEohUvju3sKSfkLS71uYJsqQ7csO/J6As0apvTTCuXM76I0i+7MSdBnaQU/jQbLS0zWxoSxjlklgEp0YSxPEODVcjXei07ZzhALg/SsYsqjaM1RHRuxY4ezqi/JF3geKGjCtw16Z6082CPiRLUCJX4bUq4u34amLgXnO4RMNRXq5k4UITACY+GtEpycfDq7eekAnQ9O3l8V/zff9yHif+8R0dlEf1m/F16OoeYXqmPD8QpTAX1hwT+kT37ZLU0gbEQ6WZ8sWJUzgW1qK7zKg0sVYXvy06lcg2eGwtLrB02wWAtVFEPczIWBCw6z9vchY5HoeW1apbJQ6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvUqhaBgiXFiF4/bD6OV5P0qq0ABu2hptPx5mikO0uw=;
 b=CYF5RogUfNfOX/Q/pNcbNJEdFdhkxPZ40wBV3WE9rgMcsNZiJXVRHkL1spn9O3311g+QYDChrwkQCNHg58PotoPNF8lpmCrVVIQC/GlE6qwc+YWgtiLCwaPKS+r2q+l7OxyifR2T8nac6p3E270ldTgSDHnd8aPzElTHQvJE6BQ=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by MW4PR10MB5728.namprd10.prod.outlook.com
 (2603:10b6:303:18e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 10:42:09 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%3]) with mapi id 15.20.8678.033; Wed, 30 Apr 2025
 10:42:09 +0000
Message-ID: <bc016aaa-fed0-4974-8f9d-5bf671920dc7@oracle.com>
Date: Wed, 30 Apr 2025 03:41:58 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: IPC drop down on AMD epyc 7702P
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Jean-Baptiste Roquefere <jb.roquefere@ateme.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@kernel.org"
 <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Konrad Wilk <konrad.wilk@oracle.com>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:510:323::8) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|MW4PR10MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 383ac2e4-e0ed-4242-fc56-08dd87d3a893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R01ycFp2TkpENDB0YmVVa2hpNy9tZENWcmIwdnNMTDJTbnlWOXl5elkrVmhS?=
 =?utf-8?B?bDhDaXVWa3YrZVVmd2w3YmI0RFprQXdBMWtjczJmbkFlWXpwakRETDRnTm9R?=
 =?utf-8?B?SXhrYW8vTC9uOEpsTlpCTitwbVRZTHpQL0J3NDJ6UFdwZWtrQnNFWEJDczdJ?=
 =?utf-8?B?WXZsTWlvdHJ1SXpuRTRtOHZTVWh1c0FPZmplQm1DNzd4aC9NVHBjOWltTlJL?=
 =?utf-8?B?SFlSL215R1FKejZHZ0pqV0dITEdvTUZWVks4UUhXbnJBZWc0VzFFRE82WmZa?=
 =?utf-8?B?ekcreEdzS1Z5R0Izb21BVk5YMEhJVlo0OCs2cEV1THR5U092ZUhtayt3WTJn?=
 =?utf-8?B?TzF6Y1FNQmY3eFpJK2pJWlpqSmdRMnIvbSt4ZTRWRnVNRXlNN3UzV3ZHQWwy?=
 =?utf-8?B?SFhJQzVjRkE2NWplQmpnQ0dpUWNmQVhLUCswOVNHV1hpQ1VuQVpXS2M4emVG?=
 =?utf-8?B?RnJMVTVUWXRXa20vRFZxZzROZ241K2pwSE52Y1FuRVJYcG9sUGhiVlljTTlT?=
 =?utf-8?B?ckljZlhFd3lRQkV0SHQzUkhJWHhhbjl0NlNUV2V1MmlqWVRyOGhBOGJZdE5i?=
 =?utf-8?B?Vys3VEtGSFA4RUNpZHVKeWFFTWgva0ZRYzBKVkJwdU43SzBMdXpoNGdvY0RU?=
 =?utf-8?B?UHBYb2JXSjY5NU1LZzJ0MGx1ZVZvRTdOWnRBWGprWDRBbjV5b2ZtbnpJdXNT?=
 =?utf-8?B?WmNOWlBpaUxYZ2dQQi9GUXBOVHhabW1kdFhnMlVDVGhIWHNzVHgzV3I2U3lN?=
 =?utf-8?B?TmVGSjJsNVRjN3hqUmdjcStsZlRxdnhnMmFvZ3dXVWQzbXc5YVIvcStEdnhD?=
 =?utf-8?B?REFXVElrcnlNTzB1Q3NjeUM5ZGZhN3NrVUpTQjhqalVHWkJyQ2tvY0o0cTJ0?=
 =?utf-8?B?TGRaYUErWGVKbVY5MmVOY2NyQjN0NkU1RW13VklhSVkzNGNwamNQejlRT1VE?=
 =?utf-8?B?N252OTNwNUNGTmdOcjdiT0krTFVnNWpDajhNbllDbTFIUWFid0xYZFpwd3NH?=
 =?utf-8?B?Z3hBekVIUGY0VzI1aUVsUTFtb3hHL1psV1p1by9OdFhhaFB0N3c0OE51b3hy?=
 =?utf-8?B?dVNtWm5FRlZhRFZKMk42czNRSlY3aTh1b2F5OEY2b1BlbmdQcTlsU01sb3FZ?=
 =?utf-8?B?ZWx2c2J0cWFhZnlLWERiaENhYjZ4bHhXZmZ6WmdnTGdYRi9HKy9ISGd1ZGRX?=
 =?utf-8?B?a0YwbVdQQ25FNXNSME9EUm5uM2J1c2padUlJdTltd2tvUG9hTGZ5cTk3cGpk?=
 =?utf-8?B?dUlseTlQcG0xSW5xNUdqcm9EZjhGWHVqY2V2TlJWV04vejFqcWg0YXBLL1F0?=
 =?utf-8?B?RCt6QnhnQ0oxUWJKUHZhc0t1SUZTODdxVHRxTUlWL0FaaGdRVjNiRy9YU3lz?=
 =?utf-8?B?R1l6V2FzTnNySTBYMzYzR01PLzJLcFNOTW84TzN1aXQrTHdCYUVqeVpRdWU3?=
 =?utf-8?B?YWJZb1FPcXNiVUhPYlhTWmR3RUJRZTNoVWM3MHZrSTJ6Z2RIMlR2UFJ1LzJT?=
 =?utf-8?B?VXFPdFVLT0J4Z0hJdmVRMTV5TmpES1M1VjJiZy9nMUYrSXZHeFdNOERkZUFS?=
 =?utf-8?B?MVcyM05LY3pJMm9lamVnUTB1d1ZmZ0todWpTWk9UWUdGSHpmdXV5K2JsdTM3?=
 =?utf-8?B?N1IxZGxUZkZ1YzBFOFNrNUZIS3JoS1VzZzZ1WGd4ZFFkRi9wam9pNUNGbWt5?=
 =?utf-8?B?S0FXQW1KTkorV0NpeHVIS05xQ212NjMySzJpaktnWUYvN1ZRV3RSZjYvUkE3?=
 =?utf-8?B?SXZMNk95VGxQSE9SVlBrWWY1aW54K0Z4ZVBaR05pRE9mS0dRWXh6cVk0WHFU?=
 =?utf-8?B?SitNNzNvUEhwWmN5Nm12SWxxVGNVTVl2UFFvN0FCVnRFa1FqRllTZzFUQjdn?=
 =?utf-8?B?ekp0Yk9CWU1IRWErK2djVlE2TFROM2d0a0xGQVNXWXFDTXRWNjZrWGl6Tkwv?=
 =?utf-8?Q?oo7FhsqXxTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG9teGhic2V3TkJlVVZaemlxM0twVENrOU45a1JmT3BCUjgySVJQc2lQWFZv?=
 =?utf-8?B?WllVWCtMRUQ5M3ZERzljWUtVQ1NvZGpoSDEwc2E2WFE1S3Y0aFY0M24vYmxl?=
 =?utf-8?B?ejczWkR0a2dWYnV4bmVZMHhySEI2R2IrN01BTVNXSkphQisvb0xzRlNveTJM?=
 =?utf-8?B?YW1ncUJxTVhGZDM0ODZJZmFuVUVSR056SVhxKy9TblQzSnQySmNvT2pHbFg5?=
 =?utf-8?B?QmJVbGh4dThudVd2blQ0QStxUmw3NzdUZGwxZXg1Q1JiY0RKZVFWdEdxQktT?=
 =?utf-8?B?QmtHckZoNTNPSXhha0F0U3kxNWxJY0c5NGhzbzZpSzZvTVMrSHJkdDRTbmxB?=
 =?utf-8?B?RjhFQjB5M0NOMEpKTWlYcXpXNEJ1QkRUMzAzZ0lwblRxNkEvdGtsQkpGdlRp?=
 =?utf-8?B?d21pSVlQTGFTaE1rakgvNWF5VlJ0TmlMdmorTTFtSGc4TlBUVE8vL1FxZ0lX?=
 =?utf-8?B?V0pUeENPcnltaW0vSGduVVZoRy9UWDZGampKb2V6OWxHc0ZXcEsxUUdaamU5?=
 =?utf-8?B?dGphd1pYbDR6SW9MSzRFWitwQkhvRWNOdnNTMXlhbXdVeHVhVlIxcEtmbjR0?=
 =?utf-8?B?YzZjdzI5bzhCNkxQd1ZZZ1FXVlkwREFIOWM1RHJlcmIyRXFpektLZkNGWnl2?=
 =?utf-8?B?TE8zRnV6V241a0JsYTN4WmhDelhFWmQwdnJrVzFuYXJEclpZZk9FN1lUVUQ5?=
 =?utf-8?B?M25Cb2hEejRCUjRPVXgzU3FQSDE0SVFJTS9wN1owa0ltOHgxcloveHBscUFt?=
 =?utf-8?B?VERYR2gyWWpnZ3V4RmVtSXZkUTJUdGlUa2RxR2hjUGFhVGljWHUzajdBSTBV?=
 =?utf-8?B?WXhiZDB1R2ZLdWNuTEVyZzdGSU44d2Y0S0FxTm1xV3EzUjFEUjlRL3dnY0pD?=
 =?utf-8?B?L1VxQjJ4bnhYV3R5b0swSHcvU1FncTh6dm5FdlhGeUNrbTIxVUFEV0RkaWhM?=
 =?utf-8?B?VCtCY2RlMGRmNnRrb2VGeFlqc0FuTkIvSWhyQnk0eTVGVEo2WXB1Q2xwcmNo?=
 =?utf-8?B?d1dZMGFiRUxZTDBubzRBRWN5MXZ6anh0V0o4QjV3Tit4RVFPTTNwK1hLblpC?=
 =?utf-8?B?UVV4S1ROcmU5SGZocHU2MEdmbDd1UGhjN1dzTFJFeGljVGZ5VVV1Z29OeTh3?=
 =?utf-8?B?NzV5MFpKZ2V0SkVpV1dVeTZraVhNK0VnUkZxWm5Bd1FjaFY0YmQxdEtJOEh2?=
 =?utf-8?B?U1IxdDdjSkNwWGdnUGIrYXZzNm5JQW1POHVTLzhEYjBVQ0Y5SHNlaUNOamVx?=
 =?utf-8?B?OHk5YWhvcGQ0Y3hBaldhNkRiVytpSDNwazV5dDFiZU84dTFKS2lPd1VBYjdH?=
 =?utf-8?B?Y2tMVFI3cisvaDJkRWFjbXpJMTgrWDVsUThaR3AyUjhiSDVWcEI5WnZrZGlQ?=
 =?utf-8?B?QzQ0UEZaYi9NK2xaWHRBeW9OczIxT1QxSWlZNFFxelgybjZRZnRxRWl6UWxH?=
 =?utf-8?B?TmJuMUFDQ1daeVN2TUZOMytVQ2dRdng1VGwxamFwTURSRmRHaEUzTWZkR0Ry?=
 =?utf-8?B?bUVmSmdhb1ZRd0JDb2E0MWRxcTVHVTRTS3lVblFmcTVydTRGaGMrTXJGaWg1?=
 =?utf-8?B?VGszSEhiMWk5YkU5L2toVkdRS1RFQkJJM254YXNIalJuVktqSFZ6ZEI4cjBp?=
 =?utf-8?B?Q0d0TlVjbkladGFEVlFTeXRsNUFOOFNFa3ZDMVlPWGFHVVV2cVJaYy9leWdE?=
 =?utf-8?B?WFJCemxHcWtFOUZ4dStwSG1rMitkT1pzS3NHRFVLR1dPdUE0aHk2and2UDgx?=
 =?utf-8?B?K29DN0dBZWJQeWZraTIvOW8zM0RUekpkVk1TR2lxNGUvMWd4dnhzNHIrQTk3?=
 =?utf-8?B?QVMvZ05CVk9QMHhTV2pwcGE1ZUpYeTJFRzBZSlpBTFNjcEdMdWpmb3hIQU5H?=
 =?utf-8?B?SzNqbXdxZ2ZoU1lsWjVHNlA4Qkwxc2lhck85TnlYVzdQZ1N2NzlvRHZQOGtC?=
 =?utf-8?B?OENxLzlNSERhdnY3UUExUjFKak41Y3huVGRNdVNXUlZmN1hMU0FpVlMxS2c3?=
 =?utf-8?B?US9OZXZEWkFOclJPRXhQdjcrWjAzRHRQU0FkRHRmeDZEQ3phR1JqckNkalFG?=
 =?utf-8?B?ZjNNcTR2N3hkRjJQdThuRmcraDRsMElWSXhSL3I1Zm1oaEpSbEN6OWZqcC9F?=
 =?utf-8?Q?O4f8aPVwkLWwYgXoxYYsmGEbN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VL6bpp+gw0Ccrm2fnSEu0kaE0pztSY1f6BLH96cr8UwvlLt+GVVo2cn6V2rrjiBoC1bS0hFrFfI/cn/k+cAardxNOQFI1Udp8vfnqIxPhPvKeii4iqWKdnyh3Sa5ejOIka9H7c2cAioYxUuHiTRBj5Q4nG0XzmCHPaEQMJN3vNXBFYtYz1ofmHtAKKDnc7vEKbILeEAjlpdcx1/hwAH1W2z1f3WLyYh1auQjuSrba2sfzerK2BX3RONp1OVjojOyta8lZVceqxbq2Hn9fzYVfDZnnvS28tVqf3CYbiYVowRoiWpebFwtrzrLjEBnoRZ8LiALYT13b+MYwP9KEGxaLSUNKXJleY0IJiYBPnWBB0jKxYFDNsWgcMgnJ29/yPqQMyECxSOgr2xrkwDbE3nl25szkLayMLgvY7j7LrN8/Nek6Z8gePxGw2znP0cUxvaiWOsuR3u6GQfRr7oSV+NN+GgRp4HyhB/HqHw8Ig4qFOtKAZ3Al++uIPrqFOPnfZu4sU/0syx8m+ma9hDTaqVEpwHcL7233WWwRrLaG9NmFCL7svaw8yDukk6ZOQhUzmipau694fOW8Uu1W9GWBsonCdGZ2Z/u6XnMoSW4pQ6m/3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ac2e4-e0ed-4242-fc56-08dd87d3a893
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:42:09.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilHdbBGZKBFJaCaDRRPo5OcX6C9IARuB9mnwz1KmEJwtMQ/gQWYygJDCWILJhVWBnhGQ+0Nzuz8fUe5cdnLqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300075
X-Proofpoint-ORIG-GUID: dLDGLHZrV0eLIk73G-8heM_tFisrF70s
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=6811fe85 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=fqmHi7tPKJ_pEmTx3ywA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dLDGLHZrV0eLIk73G-8heM_tFisrF70s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA3NSBTYWx0ZWRfX1bUrAGryd/fL u7jxZ66a0O+XSpvr11YKHcL7vlkUzbnywoJodaxOo+/568pT+pzmXPQBdsvkx/PwdYN47iSVR+f HdRcf61LmeN6oEaXNphW8JZYbFMhZ/A6FKKiceCrI2l03edrJwZ48ZO2KkH52iob8N0Dnej8FCw
 mzsHaXuZ1CNspHvgedwEIKx9raovylH2G03qdeSYq4gHkaCqIFHwOWkzcJWElqkHRHoV7H6vzsD AQdhkAh4LuVbUPBdXxCtV2p/d4VcwlQZEgNn9VHhLHQ2adW3TI9ogYgyFlXYkaiISWHcBrs/62l cbmAKxLDK8xVKWHPKGh866B0hUCd4r0TYG28p6uWW+YgSCwjm27qD+w/eMj/MJtbwvx/CQJXnld
 Un/MrxZ8vA/oZEfbjScOxm/0Nlvfnwsbl4GRudCMGUVOMSBGrVQIbM4bJwq5H3Dl8OVY2OOo



On 4/30/25 02:13, K Prateek Nayak wrote:
> (+ more scheduler folks)
> 
> tl;dr
> 
> JB has a workload that hates aggressive migration on the 2nd Generation
> EPYC platform that has a small LLC domain (4C/8T) and very noticeable
> C2C latency.
> 
> Based on JB's observation so far, reverting commit 16b0a7a1a0af
> ("sched/fair: Ensure tasks spreading in LLC during LB") and commit
> c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
> condition") helps the workload. Both those commits allow aggressive
> migrations for work conservation except it also increased cache
> misses which slows the workload quite a bit.
> 
> "relax_domain_level" helps but cannot be set at runtime and I couldn't
> think of any stable / debug interfaces that JB hasn't tried out
> already that can help this workload.
> 
> There is a patch towards the end to set "relax_domain_level" at
> runtime but given cpusets got away with this when transitioning to
> cgroup-v2, I don't know what the sentiments are around its usage.
> Any input / feedback is greatly appreciated.
> 


Hi Prateek,

Oh no, not "relax_domain_level" again, this can lead to load imbalance
in variety of ways. We were so glad this one went away with cgroupv2,
it tends to be abused by users as an "easy" fix for some urgent perf 
issues instead of addressing their root causes.


Thanks,
Libo




