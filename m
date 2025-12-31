Return-Path: <stable+bounces-204322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93846CEB51F
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 07:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ACE2301988B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B70E1F09A5;
	Wed, 31 Dec 2025 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e+kYAOA8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PIKUvd6u"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63098282EB;
	Wed, 31 Dec 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767160836; cv=fail; b=rfXL5PIrl5IAN2RrE1ojrgIkkulrEv8l8rcXwDv5BnJ5s3vSX/jRcAEIdsfeG06h7/t/dFzIlnH6eQEXZM0HZJVAMHMdM7du+QIVMIHJoDuAb86pOwJq3TsvbVWnJaray/qoQw7ecvGnQqdXmIJI67sxndaGo5ukvFjetBOJW+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767160836; c=relaxed/simple;
	bh=AqckrVcCR50b6vk/zMyJjpZlGTV0IhOQUw22b8Hcvyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6k5wRdcCa5sqw89UDsdLqhkl8pFxq9XrCIv8XsK/oI2UDble8Z2pAjuG84nBmw9DeeTmUyOfrM2RaHKBzGuTa5bGdhj3d906oCuv6bS2ytL6NHJ7e+WNSCfrQNJ07mKsMirUe+mmReERNxTDZDaTc9HZN1I+aDZCf6b5Qa1PfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e+kYAOA8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PIKUvd6u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV3Qe5W1812734;
	Wed, 31 Dec 2025 05:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pG8Cbq85rsoDj16TyMB0xrWysYM+TahiUqa/J/kfWT8=; b=
	e+kYAOA8uYYIiw3o0qhMFlECH5PggHLdr0YCo12u92dx793sFV7i3f2nNm99t/nn
	02DJDsVl0oIWkX1Owpu9I6rat2Vd+o3t7mWGwhcH3wlYV5kFuAI6Lk0dm53sUzRX
	QJZbIJNzHM0JY+JtPMsT4Cmp1uwPkYVCUWHoXMmrWNmKBW1V8wFhmPzjsATOzBHT
	8Z8neX3W3nuQia0oHoei9BNA3+fM9B3lBBMhA5bIraAXaf8OizdUTLnYSyEU+gXS
	b44f9VIjDDU4kGbWF55VxqVnimN/1DSRnzf5zcwP8twBZduPhOrEw9JKpBgeJVc2
	Rhlz1ugCdrd7fO6pXTOpTw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7gabdqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 05:59:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BV2EJ1k022874;
	Wed, 31 Dec 2025 05:59:47 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w8c270-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 05:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ga1/XS4+FK88SosEgCqL79K7yB3p1U7RMwx2NptUNqmdjrB+FarJZEv6JcgN3ktYxcCFHkI0QKcMEnokRLM40y55d45O/lx2Xt9CwoWFwEvH8dKPjrrs6zEqSUNtsJ+0ALDo7IZB7Qs4hdOyxFbFA0vP5/OeyDxhW17yrrXUPbSWiUo2vzrXF92Xfqd+Uz7k2I7LFBDK5F72xZSDIcAOEq5CtGzWm61d/N75I64UZxuoAcKELYctCHTwqhN9M3GR05eMwBX9W/Pwkpy2iWsyVtoKpeSh/JdtWIfen/LH5y6enH5RUWWUbIaphpepVLZRTIK2Q6mMZtiv9h2CUs5WlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG8Cbq85rsoDj16TyMB0xrWysYM+TahiUqa/J/kfWT8=;
 b=llstb9tYBJsYpc/iRxqv28lQRcwO0MTt8FwHt+Tm0K4NQ+v+B6DsfaTsiGJkkvmflLBiRstxfbtPLOai0xVski4A5rY2Uskd/5TM811KK3BbYPL38tGEJoR1t1lm83XSkKLfjpfOWPn9KWAb5pnMgvuJm31BuBdN3GckHGh8yHmgNL7y6L6ny3DpaEdTFXwjB0YWHe3MAkj/nzRrjHpaaFIyT7WJyhYwFSL/35Ri2D0wUFiTQ9sdrBP236EnHzi5AA6iAyHPlNI9CxFM20qkL2NcQw0mhYZbJ3riH6ooLA9uSkKiHYvSjIqPRq6fKhnN4f2wjQSQ+DKYjUakcBDfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG8Cbq85rsoDj16TyMB0xrWysYM+TahiUqa/J/kfWT8=;
 b=PIKUvd6uEaQV4yxE0RdPnORaorTwaQ7aY/ECydpFuNULo0Oqhl7HzxglvV9/vjbt5m5SHjfi6vcI1zl5tM/zO7/DeW7J3FJHqLUa4aanhgx9TC8rYaYqnaiLTxorAlX6p/VKZkbtc7PTmG3W3ZASNhBx/0mOFtDyZ0wF1A85Rno=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DM4PR10MB6085.namprd10.prod.outlook.com (2603:10b6:8:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Wed, 31 Dec 2025 05:59:43 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 05:59:43 +0000
Message-ID: <f103170b-a9d6-4c78-9159-8f87a535b0a6@oracle.com>
Date: Wed, 31 Dec 2025 11:29:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ima: Add ima_validate_range() for previous kernel
 IMA buffer
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, graf@amazon.com,
        guoweikang.kernel@gmail.com, henry.willard@oracle.com, hpa@zytor.com,
        jbohac@suse.cz, joel.granados@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, noodles@fb.com, paul.x.webb@oracle.com,
        rppt@kernel.org, sohil.mehta@intel.com, sourabhjain@linux.ibm.com,
        stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        yifei.l.liu@oracle.com
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
 <20251229081523.622515-2-harshit.m.mogalapalli@oracle.com>
 <29879a797996a14547c1274c45a4e7b824ab95d3.camel@linux.ibm.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <29879a797996a14547c1274c45a4e7b824ab95d3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DM4PR10MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cdad3e-8894-4781-8eb4-08de4831cb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG9DSWlPeWRIakxRWGJuS1FVQXZSelQ1c3ZPdmhJZnYzbnp5cjB3ZjRod2dw?=
 =?utf-8?B?OXdGeW15MmJqSi8xQ2VJQnl0OW52bzFqMFNiSldVWjNuaHhZOWo1VzBEYVo3?=
 =?utf-8?B?dDYvcmlPNnlHMnloMGxRZytOQ2JiT2lGUG04ajlyUURFOGlVcU5qNDhacVFB?=
 =?utf-8?B?RS9PVTVTYkp3SVRFNGN4RjI5OHRJcVR2RGZEVG50Y2c2aXBvVnRGVmIxSzdP?=
 =?utf-8?B?OXdFREJwSGl3ZFNxWGZiT0VPUGtnaXpSeS9pSXVLakRpbVBtM3VBSzBlYkh4?=
 =?utf-8?B?blFsdS9Ua2FYZ3JxMkM4WkZJTWJaZHNxVkxNQ0lhS3NGZk9CTmkwZlVCeG05?=
 =?utf-8?B?M3hiU2NMeTM5Q25HQVdiYmlEa1AxZVZDUjVxSTZPckVUU1JJTlczb21vNk9W?=
 =?utf-8?B?V09NbUZUR21pOElwTmdxUTFjOWhJVDJkR1JrMm5HR0xSUmltSTF5ajJHVUJI?=
 =?utf-8?B?SlZSbUM4ZW9nZEw4ZHB2dEhZcHpDRnp4UEwxVitwa1ZVVjhKeTltNzdvWTVz?=
 =?utf-8?B?cXY2QXViYmlFS3BUWGhOQWdYSW1hanFXKysvQVBhaVNaTTFqa3lqc0xUaUhW?=
 =?utf-8?B?TE5rUW5YaWFzeWZJN0xBaXJEdnM5WXRodnBOZEh5MGNzZFl6ZUo5WTY3NHk5?=
 =?utf-8?B?bGdDdFVzbDBCSEs2aTBRRzY5MDl3M1BLRy8wUWZpRFdRdTlaOEtrOUxzNUNi?=
 =?utf-8?B?NjVVSERvZFV2Uzdialh2VEhBeGJPK0tSZWpRL0RuUDBJNlBWTytIZUJXbG1n?=
 =?utf-8?B?SzZHV0VPd3R5dTFPVFU2bVd5Ri9nRXE4eWpoRGs2SFh1SDVjSjdIQ1doWlkx?=
 =?utf-8?B?UWRZUzJ5VXBsSWM3S0wrSzJCNm5tQVNwNE9tL09QVE1UZHplRjJHM3FOdTB1?=
 =?utf-8?B?dEdBWWJkeDF2Si9KdEh1MW1WYUE3VmxETzlQSWJqTHJmZGNXYm9MMzRhTjFD?=
 =?utf-8?B?OEl5azh0Zk9pSnZlalRWRVAzdkdMR0ZJZnVma1VGdjFGbS9yRmlxdVJQb0Y2?=
 =?utf-8?B?UTYzYWxkKzN0UUVHUHl0bEplNmlEVTVoeUZXeFB1VjJhSy81T05ibmpTRzRY?=
 =?utf-8?B?M0pwem5LZkFZQTNJNUEzbGJxR2lhNXFKdjROSFR6aGE3ZHdZN3hSNkp5akFp?=
 =?utf-8?B?R2NvcEhnYXVtUTBVb2xwWHdNaVFjT1lkVzJXUVd5K1haWVAra29Iek5pYlQx?=
 =?utf-8?B?eFQ2eVJ6Wk94SFRNS2lKYXRTRTVTY2xRVy9tUDhJcTlqeGxDeDlOekJacGh3?=
 =?utf-8?B?c2g4eUZaSk1BUjlWaUFGeUd4bURXRWt2NEpnRWhwa0JjRHhwangxMVkwenoz?=
 =?utf-8?B?RWw3Z3ZUaXhjQk5JR2FSWlN3NWpORG5hR3c5SGQ3QVd0NWsydHdDSDlkdVpK?=
 =?utf-8?B?RnAzdXFYSkxoTTB3azNJWWhzOWs1RXoyUFN6Vk9TeFdTd3VOZ2E4ZU1XeVl3?=
 =?utf-8?B?bUduRm15VUlwdzk5b09rVm96SVkvSDkxNVd5Tm55dWs5dXY2ZHJ3cG9sV2hh?=
 =?utf-8?B?eHl2SHFZVHd1WW1UMlphWFg4NmdKTGxHTnQ1Q0ZtVXVhTktwaWs1cTF0UGhp?=
 =?utf-8?B?Ukx3VWJpRWUrak9leVYrVTY4OGFFOE1waWZnTmM1UVR6Yjd6ZjlsU0Q5eVVR?=
 =?utf-8?B?VTNET3VFTnZoSWRmaXFneGc3VWJqYlpOT0cwRThPUFR2VU9teldIeTJXTGlq?=
 =?utf-8?B?djAvdkhrQUlXY25LNmlVcUFUTEtKNUhLZkJWQ3JpRkRpSlBCMTNBekh6cTdh?=
 =?utf-8?B?ZGNQcjk2TGJRd1Vsd2F1MWxYN3UxdndRQ1NrVFFJck04cUJQSFBwV0tPMGpY?=
 =?utf-8?B?d2RxRTVXbUYzVkdSMzNHaTNRVWpHbkpwUU5ISDB5RU9GTFVELzBQZlNwWjJY?=
 =?utf-8?B?YjFIUGw3V2tvay81emVwUFZTSjlSd2l1dS9abzB6ZTFOM003UEc4azN1STlM?=
 =?utf-8?Q?UPaUlhzrwV78+bwGVVvfrJObVzQThlrz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3E3R1pXNGEyUllZYk16VWJaMFN5amtERnZUVUwwOHVBRkF0b2VCWXc1M3F0?=
 =?utf-8?B?SFlZcGgwdUd3cGVVekNoSnVtbDd1SmlsNVU4QW1kSFF5Z3Jkcm1WSHh5VkhC?=
 =?utf-8?B?V1NrNEJsNGdUOTk2RUVZVHJiYWc0ZVNQTEF2YmRYZ1BjSG1IUEZpQWFoVzdX?=
 =?utf-8?B?T0diSUVnMTNmQ05QK2FuQldaSFJ4cTZTTGMxa0xNZUZmWUxsMFZvRk9TY21y?=
 =?utf-8?B?eHIvSU9PVmQ4YmM1VnJEdU5YQWE2RG1pTVZ0T2puTzI5cUxQeGR3dkdPTmc1?=
 =?utf-8?B?UXE5RnZON2Jqd3dscmlqZU91K1hzaklrd0Izb2Q3SEFJZW5PbTFQdFA1dmhl?=
 =?utf-8?B?K3dZSGV6VG9wVkU0aWJCcHJtWnJzNmRLUytYdGw5YlM3K0hkRE9ZMCs3cmIv?=
 =?utf-8?B?VkNLQVJaNmFsVDBLSHV5OExRcndyQzBKS2NhM3IyZ08yVmxIS0FtZktJcUZI?=
 =?utf-8?B?cGNsbGNJdmx3NmtIdzZMMzBObjdlNElKU09VMnIxVklGMWpOaWczRURpWjNI?=
 =?utf-8?B?RmZFSldzLzRFd0MwbWVyWVF1dHVNT2FWTHBOdjdXbmNCc1lFWDJHL01iczMx?=
 =?utf-8?B?LzVtNkZ1K0J4WkZIZ3BxbnhpQURkMU5lVTRWZ0xVUzJKVEcyVVJ4SEVxYzNw?=
 =?utf-8?B?RmFyNU4wYi8vdGYzVDMxU2RSTEM5S1IxcUdSQUVJekNYM2ZWYmFZem9kSFY0?=
 =?utf-8?B?VTVUSkd4b2d0QU9YdUZ3dk9GbmdLT0lsOHliekZDUXJVU2FUUndNU0ZWSU1p?=
 =?utf-8?B?TnJ5dFkxcGcwdDJMRTNoK1FiWm90NUFwRVlTUlJWUXF3cXY2R3BLSW9uT3Ju?=
 =?utf-8?B?SDE1S3RzVG1RWEYrcEppRWw2eEhEY3lVb1VmVzR4a2o1bWtrNWlwN0k2eFA0?=
 =?utf-8?B?alorR2xSeU0vQmhUMFA4cUhuQXdDeU9NbkQzNE1VMXE5YlovMzN1ZFBGZmlk?=
 =?utf-8?B?NE10L0ZMVzZVbDZoZmUxSnZaNjVXWUx3Q094c3dFVEkzeThtKzhlSXNud1dT?=
 =?utf-8?B?YnhwSCtsWWViR1hTbjVwSS9admRvWmlTN0VVR09EWFRIUjNIUnh0SzE3RmlX?=
 =?utf-8?B?NElTY1dpWVhWQmZNQzl2SnhMQmE4cW1wNE1wS3l3cnQ1Z3JIWTBabVRrR0RQ?=
 =?utf-8?B?U3l2aUJQUWhpRUJYQnAzalVCZG4rZzQzZVR1VlVVUmJiOG9tNjZuR2traVpN?=
 =?utf-8?B?Y2tWd2N3M3lqYTRhcWZvV2s0T2pYdVFkR09XMTBCSEJtQS90a1pVOVQvdnpy?=
 =?utf-8?B?MEFPNkkxR3Uvd2lUNlI0K1RaN0RIcEdkYnBCb1FXRkh6QVdicGo5bmVjR016?=
 =?utf-8?B?MDEySXRNcVpBcGR0UEdOOGlxSHBFM09vTVRQcFFBS0VLcW80dENDMzNaVUtC?=
 =?utf-8?B?TmUvRitCQ2NTMytlR0VncVlLOEp0T1R4c0VwTzJVWFRBUUpycE91VjJOMmFy?=
 =?utf-8?B?V1B2bGpxU3RJTlFFYlozTUxMYy83Z0NiVDFsQlE2TFRWNllvMFY1NmJSUGhX?=
 =?utf-8?B?VlhvOG9hc3k4Tk1JbkFlNFdDRmZKSkU3OU00RFVxSE84MDNWZ2NWaDY5eTNC?=
 =?utf-8?B?VVNOVkRDanhUVnNnR3FOU2VFRTBPNmRta3dwUUVYTUZvL01pSWk0dm40cS9U?=
 =?utf-8?B?THdVMml2VEhBN1hxOTB5T1R6aU5GdWdzWmU2WEJHeEZsMFp4TUdhU2daL1dj?=
 =?utf-8?B?RjQ4Y0tWM2pCQjZiM0ZBaUxmTWJTSS9mVzN1UGxoeUxzbEVZcXExaGlJMzBu?=
 =?utf-8?B?eGxsTVhzSzRtcFh5cHBkcytsL05aUTBMbE1remRrbnJtV3lva1J0OUhOS2Rp?=
 =?utf-8?B?ZzhLaTdkWE50eUovUmVEMmxCdi9IdTNDYzlhaHVnNEpKUWM3UG1TSTZUZmM5?=
 =?utf-8?B?cHY5ZVFHb1F4bzRFQVFDYkJvdm5yemx0RWhoUUpDamZ4dVlzZUxUV2V2QUxu?=
 =?utf-8?B?aVBaaTczc2l3Z3JUQmhqUXc3Tll0QVpPMGpQQ1hrbHlmRHFBSTFXY2JSRWJo?=
 =?utf-8?B?SmVJbEk4eU03dThoRktpdlZ1alBERWZraXhnVVRTdGxqaExpN2MxZklUUUlD?=
 =?utf-8?B?ekF2SktmckNCVnRkRjhOQkJkVWNtNkdrMWhEeGdmSHNuWmFSNVRmRmZlSmZs?=
 =?utf-8?B?UWtWUno1V3g5dzd2cHFGTjMrMUp2OXBRdk81THRMYnBlNzVvTmk2NTUzQVA2?=
 =?utf-8?B?ODNtZjU4Vjdtbi9Lc0o2QTBEZVNSSGtZOGV2ajFpdWlnS2x0SUVVOFpiSnE4?=
 =?utf-8?B?NEpoaEZIbG9KWkJFVjF6a2R4dnpScFU4SEo0RHRLdDFiekYySkVzM3NXQlJI?=
 =?utf-8?B?NUJDWUh5NUZQb09kRlRxZ0E1Y0l5aFFjYzJPMUxjTVdWOHFXNU1SMFBlanEv?=
 =?utf-8?Q?7gYAN9gThe5HzwHn+FMwYWBR97xm1VV/lrF++?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KcGbrwNiwdScLf8/7KMPof5kPqsTkV4+/3w5DOWPByZIdtCZiHDfWsBBRMf+3REqhsGr/grbfTxLB6CrEtcrKvcu11rvx23pjpc6lkMKZczIUkysYI4uwkdt4thbZu/ju0kFRFcBLAzrubAOH5IhGvMj9x2Umk7C09wbpukSEiDV5qgzQXb+7PicWpoL4+YpUBiuqp/Z0t2P209KIKh9TOR6SBDXxn7bL8nWy74lmUGUwYhD2nCHV6NnNT39LxENvzU/CyW0Vn8ab8D+k674mkfGgTWoBJWnrWjhzvoUi9J3w2PiGGhNeVI39y/qydSQYmVvj0OP2eMEO22v2NqGcda6C3sjlpZjfkWrcSKaztIFcwI4zEqnUctIqLK/idDyViE37rGmAlq13wRYS8o44khd1cH7kLl7r/tO8JNK7HsmS/YVo4r4ra2AAAWRNflZa3sC3RZGkpSNniqq+ucGvDZKTR7KyXkaALGAUIRa8IcuRWwJuWh/xcr5CKRPDT3ixZdXlxYlVhB060sEk0tSCtCBDPlx0OnS4QeBeGCyshsrqll69TizRCBnPfkwoAk+qZz1jaLYh46yAw5EwdgVtdicTimQyjm900yuitC82vM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cdad3e-8894-4781-8eb4-08de4831cb2d
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 05:59:43.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPro4rzvFT9uG6h7hY6xw9Y8UsOhkGZ6je2tyYm52LV9SfXxq6P8dWgN1m3emTnBYe8ZIVyAt+V1w/N7CliAEOjUxskLEiVz+h+Y/UotmlUfhfGW2Ar0CHuZmG+EhQny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512310050
X-Proofpoint-ORIG-GUID: 5RSA93PskQOvtTV0uncqb9mLqTi9GrRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA0OSBTYWx0ZWRfX6/iYS/AZ3AxW
 00QvfDsJ5gIfcIf3OeNmyBOXpuwqn4KZxowLzOUmmVxmnyQ9y9HFYZA6jgJsxf41vdUfqiJ96c5
 AVQjqB9vJi1A8uWux3o3Lp3Sem37kNXlYQMriaEC1+sPD6l8W200HLG3l74r+VnpY/cEhHr2jf5
 26YjxGmW9tXVSv5kO5SJrVvAW5XqnAXJWLKYTojXlhIBU5KeBXYeUMjIyIqkppFTp/7UQjSDvp6
 NGuwQVrFqunc8H3wNCaiRMxxQfej65Ka/mt6HTvG4U2mSchjPz7SYYKxTFvup+Xf+su2H7GODsF
 CoArdWiQbB3PsRj4oZtqfPs+jlokw4sFj0JKT/29XtEX8UqwrgR4REQUECJG+dyYWg0T8UH3anL
 QXe1VyOTVOPSNcKJkeHMINXlHkbqpQKlHbeAGy7t4/unUN4RQ2yZBYhFrzRevjjKnxZ0j102wp0
 u1kA5ulRLASPFU3CEKQ==
X-Authority-Analysis: v=2.4 cv=T9eBjvKQ c=1 sm=1 tr=0 ts=6954bbd4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yrsuZjNxCSASvtA_FNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5RSA93PskQOvtTV0uncqb9mLqTi9GrRj

Hi Mimi,

On 31/12/25 02:05, Mimi Zohar wrote:
> Hi Harshit,
> 

Thanks for reviewing.

> The subject line could be written at a higher level.  Perhaps base it on the
> ima_validate_range() function comment "verify a physical buffer lies in
> addressable RAM" (e.g. ima: verify the previous kernel's IMA buffer lies in
> addressable RAM).
>

Sure, will do. Thanks for the suggestion.

Regards,
Harshit

> On Mon, 2025-12-29 at 00:15 -0800, Harshit Mogalapalli wrote:
>> When the second-stage kernel is booted with a limiting command line
>> (e.g. "mem=<size>"), the IMA measurement buffer handed over from the
>> previous kernel may fall outside the addressable RAM of the new kernel.
>> Accessing such a buffer can fault during early restore.
>>
>> Introduce a small generic helper, ima_validate_range(), which verifies
>> that a physical [start, end] range for the previous-kernel IMA buffer
>> lies within addressable memory:
>> 	- On x86, use pfn_range_is_mapped().
>> 	- On OF based architectures, use page_is_ram().
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 


