Return-Path: <stable+bounces-94009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6499D27A0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC10B2539E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE101CC88A;
	Tue, 19 Nov 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJRamchw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zXOdGVoW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4701CC166
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025209; cv=fail; b=tCvlZKmzTZwJX6pBfheImyFF8DV9yCq/lv6M5bZn1x8RtkIetfh8M/Dcjb8GHix54ABuOM/3AbI0zt914eZ8zDyAqveavQ/I0M9p509xXzP+pYMFQ3fRhUGou4v1ofKAiYQ+x37lDcETCOaFm8ceXc9LSZ7bUS+1OwenIED9oXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025209; c=relaxed/simple;
	bh=GfZx5hkX4Gxt1ZArbGvX1IR2xvjfcnfyJFKr6Ct2288=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tiDpYzL86yAB3gmm3ort2xboVnvwYLFD5muyFqKzxNp25P4nd+9SNqE1br+TOVhDR5GDIc0980YM2HpMf9E7RcVC9+oZaVROolYyqHyrQFrxIL6L168mQINEf5HPYfhG5koNtpZmy0NjKC0fXLtmT76+2JXztZyMxSZgMK6WB0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hJRamchw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zXOdGVoW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDhMKf027941;
	Tue, 19 Nov 2024 14:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZC9GZ6VJ4QgP76Tc/h
	yXYP2IbXog7haSwA1WDtSNnoo=; b=hJRamchwh+1l4enygAG0rm/9LBFI7E3O0r
	ktD3oHryTxzqea3R6aFRbi8fN2L8hyAhRtkW/RQN0wyVI0m9wYoAUN79qtfXsW+R
	7MU9QNHMAdChZH5JxXocgOp+qf1Y8wIYlvJ1bV56GtlRrYsU9Xf/LE9nm2xqCEpT
	ddLBHRoqDMLODqIoNx+ONySzfCBmEe7DE20xAAMWcUzViEXxO/EIlUsm3PMCzUHd
	GyAwBmZEjegWXWEunACaXAI88HOj8567vpP2VRCqqVqHcVsAL4k5PRN8rAN936b2
	yopM5SrOWwERy+ADZ8K5HAg9zgsOzdyxXbQ7JEgM7vfuKnWQhVqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr3erc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:06:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDxG1e037101;
	Tue, 19 Nov 2024 14:06:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8kjcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw5PkwjQ2qVKUkC3ZupwP7lCtwPd0Pg05XWcSQ9xVTuEKkokLhCurizd8FEy2MaqAH/AzgWqSICjF8NPzWcltNg2Asty2PH6mz1gP96u8ZGVd8C1EsL3XBtsdv0/hhsn1hhYrMYYN8jgVPChd9LG+bL92MyZHUc0eIquHsNyYgqZe39b1h8QeHjKoF4VyaWxbJXUZCkRSe53KXAgeFCaARsggFvrVROZvmSWEFCEnA0TbsqyxgcHLD3Y62Bm9B1KDjwa04a2PcmSHORKbd8Esy/NW0hjD8yYCHyQ5WuTdgpA6LnafEypyvVLVpuKQzsOvNHYRhizRT5tRmH9eMWNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9GZ6VJ4QgP76Tc/hyXYP2IbXog7haSwA1WDtSNnoo=;
 b=Ps9BAE+SUR4PsQGSDpk8s9gSU4n7CqXktQS2UwzhcY1+AJUZ6isfkiVY7so/eH6mFpq7ebL2RChY2L2kNVjqXYW+Wtvx3B/8z0YW1S8MyqvHGQvsu+s50T9+d79G9odadDpKQwUIHnXz3/AsZe0NxXIEEYEa/xgyLTRvGjhH51XQjD40SEIMKkqVEXF0r8TCVjtH4jdq9deDvkD9N84NHB8DJW0kuZir0ARRaXNAbQU7nXxI3cWWGg312xZ5r2QtqCNoc0n+WlnKdrCzbmpFp54yStIeiggWiuDf6/6k+zfl1Wnqv9fF2XOIEjnPxdF3TsKSQTjHbrW4ctgni8TR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC9GZ6VJ4QgP76Tc/hyXYP2IbXog7haSwA1WDtSNnoo=;
 b=zXOdGVoWq1keTP8QFlqDOk47VzOw3G35tLDt199HVdvU34E/st0x9Bq90DsS/m93fiwe/iA5TGQhHlMT1HG4eGmpKhJo4eAU+iv00j5r2QFslUobHDR4DWIkgdpNP7I/Ftg2fbCzKBs22t+FJOzbrainMl5xKABkOhiRQtpeTvo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 14:06:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 14:06:33 +0000
Date: Tue, 19 Nov 2024 09:06:30 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, cel@kernel.org
Subject: Re: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in
 nfsd4_copy for use by trace point
Message-ID: <ZzybZplCfSkWKsyi@tissot.1015granger.net>
References: <20241118211900.3808-2-cel@kernel.org>
 <20241118211900.3808-2-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118211900.3808-2-cel@kernel.org>
X-ClientProxiedBy: CH2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:610:51::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: db349364-6832-4e2a-e51e-08dd08a35f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?33jl8FiUmSBAFIMKvrsp8XjNuLvqasNrTKSelp9aKKMwSqD0vijn2/T57aqF?=
 =?us-ascii?Q?BFf5UqiRXCRJlWmZBDhVQMfH+Ev+Ew+Vpzh0uaI2cYeRw2TB0kLa4rwYkGhA?=
 =?us-ascii?Q?2s7fOVsgDdNb8GcKbUpu+o6AGMX93EodWweQGWIiQ91Eas5NBCORL71pmPTw?=
 =?us-ascii?Q?VGSb90cJIL+H1bxPt7UJKocnDC5rwG0rTlJ59u7YekehzSs6bNBJ7HDP4OXF?=
 =?us-ascii?Q?BDfR01ozLxJdg5KhPM0VZi2d+8q/LwYJLBit0jD4mMdf5k67oPc8ODk5B3d2?=
 =?us-ascii?Q?0laUnuFGlGLziRZOROlElPNR/YrlbHzV7BTNxqP2UlhzfGpQKddd5AH4vIQI?=
 =?us-ascii?Q?m3hR0bXzo9tdegDseFlNqJiXLOmZS8khoi1Byibem+JLxLZFv9L9eaWdGznw?=
 =?us-ascii?Q?B5h8q1pz+puSESiqlxe+ANebQ2YEJtjGQa2tZC3U/M9rrpt6/2QiwQId7uxF?=
 =?us-ascii?Q?sJYPupRpgNdsHIVX1QsSINeiw9r4xrjd1uKCHidSnEs8lqQ/PTK8SYBUydlN?=
 =?us-ascii?Q?+MdJh7qWhyhnXRRj77Gz00nMusMHRgCehKAAmgC/VxkPH60wsVyd6XSyYX5g?=
 =?us-ascii?Q?RScjXpZCzRG9esoygZVHCW+1yN/jFIcvGQcOpMQaFmCgB5c8FAzk4Ywg0Wm5?=
 =?us-ascii?Q?jlTl1DS6/UzrfVCRQa/AjrKZZtAehdSjgN6l86lK/kcDe2Dudh0Z13DP55Ju?=
 =?us-ascii?Q?Dhbr9M6eeY+YBgdesHmfiXoJtaWDHDmrREMvSTo90DCexbYX45ZW2+0vr4xe?=
 =?us-ascii?Q?koz0By8kf0ihsWaoRA6NNoJ+2tdn21FxMMrGowaBdaK00EXr5c/726Aoh/jH?=
 =?us-ascii?Q?TWDbsR2Pkx5mWOw0s253u/NRxgDhMXceENcCG9r7pA3R1QbII1nd6ClCORO0?=
 =?us-ascii?Q?i92jTZSrNdevpyASJdsouRx46cAXlK7knETf36mXmGihlVc+ez1t84AHIIef?=
 =?us-ascii?Q?9ZGCFU6EH3QZcOdbKduJegdmvRZw1N+7RbVvFfkhEKXM7cbSHLKftjQeV1hT?=
 =?us-ascii?Q?hthEnY+To5Dmwv9+tzSYyGyt7+e/fz2obvPPob9SxQFOuqxwYqYmOfI+UaBs?=
 =?us-ascii?Q?lXYHW+FUuOv8098KlrGTUdmT8pSQtEZp3f8y5guSt95irykzG+uQgw0caAYz?=
 =?us-ascii?Q?BQ63nKNui1RaoTV1X212W35Ywvw5KL1XMls/NNGsFmHcozlDqpec+9MmRV7e?=
 =?us-ascii?Q?Rk5Yp0pBqKLHJ2k/+UzjYYpkSGKrob2ameYosnk+2MMErbKagpv2g4Gr8di+?=
 =?us-ascii?Q?tYAIYFSBSrRQVCDFu/QmZ6cm+yNNPqjy1y4nmDr4eQiDneOgKH6xG9mh3aMy?=
 =?us-ascii?Q?fUXoWfVMk7Jx00K8T6GGYTlo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxVWRa7p75gUqsfC/w9tCiVWXpBfhkVMvi29Qkp7Arx99xGFJ1xs4tA/hhJD?=
 =?us-ascii?Q?sPOiz+mKYQifUGtLTuPdevBDnftmmLJRyzQqMuSeSWQ7J+UsiiIJyXty+T4d?=
 =?us-ascii?Q?dIScKUQ4snZOvEBzZGTbe4nwtIJ85vaRCZhslKeU41FIvOLb0fD3mgWcxRA8?=
 =?us-ascii?Q?8cnRaZg8UQ6+F07T9g8vHTQ0zz9GVoKnt0UX2ia7K3MFcdSoPQdW2YOaVQmn?=
 =?us-ascii?Q?cORGL9z2eNBllkovXHzZ1vHkZIigPBA/dtA1RaT9DJ2wW+wKEVey6ehIZVqW?=
 =?us-ascii?Q?Avrl9Is/AHJbxQioLKo+13O3g8pv/eLth9oB7EXuUNC+k/OkZF5plJ/sTiqo?=
 =?us-ascii?Q?cxxgS6hg/2X9i8L8ZrxNsQbId57GGXQkrcNU5OLvItopvLXjkWA/0hRhfaKJ?=
 =?us-ascii?Q?IHwtASMOmk1cUkLfA5TsOuK012rgdvKu5xvogjxPGAMnSYv4iHImRmRIsx2v?=
 =?us-ascii?Q?+Xi6CMc2nyOceA1+CDRMKhL1YBS58icHYr6YFCO5mK5EZUqsq96BYFyUeQW1?=
 =?us-ascii?Q?uB9Ol09TAmUwnM5YsPvKte6sYDeE7WWIkWbEV2BBNFkFXsMtFWPj+TToJJa6?=
 =?us-ascii?Q?WdCrZjiZ0jNxcqd/bF+u6+s3IxYfix96ZtQsGB/5Ro1SSx3mCzXcdZXOMgVI?=
 =?us-ascii?Q?Ub3X4YxKTd3Z4Oz2glY90eTx+7tSgSBAeD086Qb77cp/B0Q+PUpOIWsFC31i?=
 =?us-ascii?Q?/mAIAI42yTKVnOBHcRy65pLnBFIy3XXaiE32COUUM2Fpw3smT1XUFGkLidiB?=
 =?us-ascii?Q?j2lwSt0r4LXiyeNtgRIgmrPoVV9fPdBFyb6zMXGZ4XvO2xCtJIhzcLL+AYCk?=
 =?us-ascii?Q?dTtMqHgILbA/FpoLs5kpSaBR30kMIQeuSTUfbGUX/3h/axPHShnazN0ycxJZ?=
 =?us-ascii?Q?X1O+DwZkX7nUh+cN4RABkkzrUdwpJzpws92bi48SyKGwiIPUqDQ3FO9VdIZT?=
 =?us-ascii?Q?CKQ2mh2KTEyLxDHW1PayriEz71aOM4lNwn3I9AjvWFDRUmz8tC+YU0+y+25W?=
 =?us-ascii?Q?okcumYx0x4O0rig69uW0DsGwtFrN167MVRm7zjyducR0e8FS+jAdOduPa2py?=
 =?us-ascii?Q?kSTfxCEWeFaXK70hG3RPBV5LOBTfj3eR0oJ8LvLGhmSfEIiUoaFaO80wNNlS?=
 =?us-ascii?Q?F0YFKjvLEwDttLr9g1SsHOhBNVJZDarkbqWDYyHyMagsCDzrFABEGkYdvejn?=
 =?us-ascii?Q?ReJTLY3R9cHy1pwOOXxYmTZnnq0OiSCMcIXc1W6puO/0VY0dMxQX3vpTldGC?=
 =?us-ascii?Q?GbYPU1KEil0XPCHR8/dEzvsOZpbDfqVRLaAHbGVzsejQbsEDlYsb1oWJqhMl?=
 =?us-ascii?Q?fqU0Fd2xd/8CgZiVs/fbjueR5GOelkDi+UCkvNvuEIBYvEBqY44IaAtfuVme?=
 =?us-ascii?Q?j3jk7nSWJHEKGpB1b+a1IxN06TQhdLct8RpaWRMSb3upZqqqcHWx3eWFQNl5?=
 =?us-ascii?Q?ShjmPsV7AFsXsxHpLp1llWN6qmbpE9Op42HOh+oam+kIKkRlENhXfvIYOkHi?=
 =?us-ascii?Q?5KgsYURQhQfTX493Lzqre4MkHxjyqjqhwsJzz1OcyAR8dUmiAa+S14q2O3Rd?=
 =?us-ascii?Q?IdJxiRzctj27XDAQobnhJA9w+Dntma9vz5Y6YJbQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Mhc2Q3E/HxpiYLPYBXMHHQ5Svrr4Vcfl+Bl+bGPWZonErgUPQJ961N4vpx1IufS925XxxuJo/PU4lmWPO570cGrz/EIDWLDJIQcW0+Qk6ohoUgXfWcSJt+rs0wHPbuhEhjQtdXeHyzSntJ5/jRTpO+tMuPkMNjHsWqf6GChfEqikSNPs6F51TsQgGbwwwcsDdiDrPb3YTykdE0Nnl/Uhhaxj1gpwTFmhQPFJgPZF2tSMe2IhJiy6BmAmZJwJH9SNYy2uctrHNSKrD0hywK4X/ToTbLnoNYer8q63jXfuLu7Wn+bWNgPOFU9zKjfEOfLLNUMkM9NWtF6hpFZFYmjfJUewmPpX3vWJOz71anBTUW5Dm/pq5eFypXNuCkCDEBodocK5JTIV1isx4OR4aZ1M1ISLeqdMxzhEPMlU04VpUytmRSnzX+6aB5fmDw8UYcB8DdAiPTcDl3DVK0CYqwVmdZqMIh78b5s2GLuCYI6qMAFNXuquWDpg2/7o+UBN/76cRYVdAz6R6M46yPNuUofYpmHK43R3rrIDnMrQXoXj8XfNbLIiUcsGrSDZEQKhT2++HNB3mbE9M0ebuelnLAl3YMprhoasBAfQRux21qaBpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db349364-6832-4e2a-e51e-08dd08a35f71
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:06:33.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Q8yLu2HLTMo8PvKpsw6FmwFcIZDQq7kINwkAudkSZXW7uYvur9mu9LckFgRge+e7M2Mv2jF8WBmBx3DUemUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190103
X-Proofpoint-ORIG-GUID: l7GDaMkdCt2Rj54xJ48unkQMibBCxpOl
X-Proofpoint-GUID: l7GDaMkdCt2Rj54xJ48unkQMibBCxpOl

On Mon, Nov 18, 2024 at 11:36:15PM -0500, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> The upstream commit SHA1 provided is correct: 15d1975b7279693d6f09398e0e2e31aca2310275
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: cel@kernel.org
> Commit author: Dai Ngo <dai.ngo@oracle.com>

Is this a bug in my backport script? Should patches backported
to LTS retain the upstream patch author, or should they be From:
the backporter? If the former, I can adjust my scripts.


> Commit in newer trees:
> 
> |-----------------|----------------------------------------------|
> | 6.11.y          |  Present (exact SHA1)                        |
> | 6.6.y           |  Not found                                   |
> | 6.1.y           |  Not found                                   |
> |-----------------|----------------------------------------------|
> 
> Note: The patch differs from the upstream commit:
> ---
> --- -	2024-11-18 23:00:36.794064423 -0500
> +++ /tmp/tmp.6a2P3hH3a2	2024-11-18 23:00:36.786070330 -0500
> @@ -1,17 +1,20 @@
> +[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]
> +
>  Prepare for adding server copy trace points.
>  
>  Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>  Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> +Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
>  Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>  ---
>   fs/nfsd/nfs4proc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>  
>  diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> -index 4199ede0583c7..c27f2fdcea32c 100644
> +index df9dbd93663e..50f17cee8bcf 100644
>  --- a/fs/nfsd/nfs4proc.c
>  +++ b/fs/nfsd/nfs4proc.c
> -@@ -1798,6 +1798,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> +@@ -1768,6 +1768,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	__be32 status;
>   	struct nfsd4_copy *async_copy = NULL;
>   
> @@ -19,7 +22,7 @@
>   	if (nfsd4_ssc_is_inter(copy)) {
>   		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
>   			status = nfserr_notsupp;
> -@@ -1812,7 +1813,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> +@@ -1782,7 +1783,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   			return status;
>   	}
>   
> @@ -27,3 +30,6 @@
>   	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
>   		sizeof(struct knfsd_fh));
>   	if (nfsd4_copy_is_async(copy)) {
> +-- 
> +2.47.0
> +
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.1.y        |  Success    |  Success   |

-- 
Chuck Lever

