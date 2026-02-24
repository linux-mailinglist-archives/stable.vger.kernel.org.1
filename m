Return-Path: <stable+bounces-217880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDtHKH1YnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:51:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B061834CD
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE8AC3073DB4
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6F366060;
	Tue, 24 Feb 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fw+4n/eg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x/8liFg0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23074366546
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919409; cv=fail; b=vFMKnKVOvy6DPaKsnZO0HQDrXHaPowNnSXnMNutmZfyLbP8QXWYpnZJL6+k24pSRJ81DuLnjxabkZFokloQ8lZGzYPCooK9n6INp1zJ/dV2IJyLo9/ihmf7nSsLFX+0c0DccXp2Uf0xeM78lUnTLjcaLu5oQKceMUqBpVdImDOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919409; c=relaxed/simple;
	bh=qbrR/vVfT8IDHaYI1DH82sm/3ZTTE9R82e5IdO4pvYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WuMjlQktl/TOB43uF7qLXF5fu9zA6yPg4u+klsrN7u1aN5L2856zucmB7fzKMA9cGn40C5IePeEQ5hxseCN7miKe3n0i1q+IN7eI4+JACfKOvG11S5iJBdPxS0pzJfoZI3IoleEQyRH/YOcNnSWqr5o+5h2J42odTQGbiPC/lPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fw+4n/eg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x/8liFg0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NMvHfv3045670;
	Tue, 24 Feb 2026 07:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z8IwgLduNka5K9XcBzh58Mfk1bg87N+ylxXCK9I4jdc=; b=
	fw+4n/egbIXuFnqj3hi40SVH4JNWFFYfF40WR5TBcUDOIKiFEq8y3rimdPNP1i6f
	y/Uvlp0rGEptjfrckdzvGzW83jFFMl9py3hgbSN1G5Va8xGCgxQSZfeLb0rnmhkk
	NLZ31LotiwVSW3BTtyc5fNBMa8Qerqh2UWTDNO/IVxgiqAkfqmZiFcFRGq8rp/hW
	tm60II4x85z8aRUJSg+NTx4+S+qsYbg8B8zOP9D+9Gp0N6cw8x6X77lgwDI4+VA7
	lNd2Ge1ssz7yYqrNDUZg99ONeDjxPvAO6vxwCmr6g0JjxO6crTP8XIm5X96Ec2Xd
	N7l0wV5ZhyhtFh/4zUgRTQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arbs18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 07:50:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61O6eahG015828;
	Tue, 24 Feb 2026 07:50:02 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf359n4fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 07:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqEEUE73tbE9KhM4ifcK2icqOb0Gp7X/qtnBVgqdh+hF7XSIplCBY4//7jGjr1oSwE+9IkVJid50pKyF4/MYDwJQS5khIGG0tfG7UZtK0ByWi7dvMjVBJryulw8Y+jCdwHiBUqEj2QPz7jvbo3qkWQt1+yQc6oZxpH6o7t3QFfpdDoZDtncGmTXo2Z/UfMVHU8l1oIN6iGxWp6xVfQ54hnEhK7UbZGvikV6lzbYnbn7sw9mUTb9Ledeb2QuHoXVGXBSYmv1lyyuPbMDfFYL1DtM8Z5pD6UBv5Js7kGSFWuctYrFnujcgEcOGUfn/neBgx48xe1iy3pUo+XTMftJiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8IwgLduNka5K9XcBzh58Mfk1bg87N+ylxXCK9I4jdc=;
 b=hOnBUKg7s8sEIZnB2svchGrd30m8lY2b4LmzciOlG2/PeK5aeDjKwz5DwMJ85UvYMxJHoejswnYIswdytziFSvQnuOI6kdQQb1jxsxRq/Hgd17sEUqNlJ2UvIMR3Soagrpuy7Wqx2DneuUCOcvcVmlGZjTkUeL5uxqKAT7k9TJa2amSzzQh+FIR6yrpLHYsqwCf0sgwHnFEJsIJiDE9EbQU3uOoXvyvpQcZ2gysK1HwwiuTwxZuN/1F8sdCGSvzsLW78XNNVn2fnWH4j/GHqKfRqHxH2HY3a6i2l2NX/3aVFnLnVK6IjY4veoLsCZ5wCBZYj8ZLIfZ1FVkGQutAsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8IwgLduNka5K9XcBzh58Mfk1bg87N+ylxXCK9I4jdc=;
 b=x/8liFg0RV5aZlbpMSo0/CtmWyQWyURdOxsThJAdT/MZzohaJmDen0v0SGAErmKsOeyEYGYZF3zi6nvWjrX6uFGGt/bAq6ACTk0M0T8WxTzt3UE+Q+Hz8eqRonucFqqZ+frEi2NYiI0DoMYVxmSMdzUdfilRk20EMYhNxB/PCJ8=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SA2PR10MB4572.namprd10.prod.outlook.com (2603:10b6:806:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 07:49:54 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:49:53 +0000
Message-ID: <74eeb06a-d21f-4ead-96a9-4cc91a126059@oracle.com>
Date: Tue, 24 Feb 2026 13:19:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: backport fix for NULL deref in scsi_queue_rq to
 5.10.y
To: Amine Khemissi <aminekhemissi61@gmail.com>
Cc: stable@vger.kernel.org
References: <20260223074357.7507-1-aminekhemissi61@gmail.com>
 <ce957e8c-a73c-4259-a040-a1679e9caad6@oracle.com>
 <CAEc6xTXq+WTvZFx8FoGhJE4NLbj6p-R7VMyCq7Vj_1O6_WBYOw@mail.gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAEc6xTXq+WTvZFx8FoGhJE4NLbj6p-R7VMyCq7Vj_1O6_WBYOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SA2PR10MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: cd27f76e-e313-443e-242f-08de73794bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE5CMkJ3SVh4Zm14dzEraHh5VngwR2lBaTN6TDltZ1A2NHdpQ2NMV0JwUmlK?=
 =?utf-8?B?WkN0V2Y4V1RKdXhaeEZQN1VobElVaTdSd2ZMbVE4Mk4wU3lzUUxIMENUaHkx?=
 =?utf-8?B?enhkUzIxNE1tOC9ZYVkxeVVZamlMa2FUVkp5K3NWRmFQcEtSNGhEZjlyTzNK?=
 =?utf-8?B?M2I0Z2ZJRXhvaGs4REhtSGdRZS9WV3FxM3dUSlV5RHJuaDZoM3pCd1B2NUdh?=
 =?utf-8?B?T1JHODBaWlc1REl3Y2dZMGZ4ZmgrWEZNdHdQMWpacnczeGlPNHNLYlA2a2Yz?=
 =?utf-8?B?Z0ZQM0lBeDMyQ0lZU3J1L014L3RHV2hXK2VSNE9ib3pyMGFqY1RycmNybnRX?=
 =?utf-8?B?QjlQOGFuaENheVZuclN0UEVWVkhsMUN5WG1nQk8vcFJNN3M3ek9kN1hTTXRC?=
 =?utf-8?B?eFY4K3lBa3B2QWFuTndycmdXS2kxTTJMQTlRN2drZXJTL2lFajRLSXdQenE3?=
 =?utf-8?B?T0NCUkV0WWVYeWNLQzlydlFEdWpQbjIzUDJOdUk1U2kvcHJ1dDg2ZWlrQXhn?=
 =?utf-8?B?NDJPYUlUc3plNmpCVmplU0Z2d3JXaXRFRU03SjZESXdjV1ZUWjF4RnNUb0hu?=
 =?utf-8?B?NW9HL0Jrb3cwUmlFbmkxaWZ4ZURraWJQWkpxcEVMaG1OVlF6N3dmM2hpdGFi?=
 =?utf-8?B?bGxabVVpSWI3aWhuN01tYnBWL3VrWnZmZ2FVOXUvUjMzS2lZcEdIcFBiNWdk?=
 =?utf-8?B?eDJONldOTEorZDIrZEhiU0NPR0lzMWFuTnI3OXZSRk5QSU1aajRZTnlBVzBa?=
 =?utf-8?B?NVJvSWdLdGovNEl2UkFKL1pMdWhyWkdZZ0ZHdG4zbDAxTFJWekdkdTZkazN2?=
 =?utf-8?B?UHd5czVxdGNHRDgzMjFrbUFLOTI2cWNjVnN4ZHFvTVZ1bjE1VFRueEFDU0l3?=
 =?utf-8?B?RmRrVXZ4eWExWjQycGZnVGZrcEVGSjB5SWxQV3BsTzZLUHF0bW9PVmN2QlJP?=
 =?utf-8?B?Yzk0ajR5WG4vbXNYbUZBU0FtZ2tOOU9iVEtBaC9BT1Z5TWo2SjdzaW5Qdi9r?=
 =?utf-8?B?eFprV0JkSHRuTFlIUlVOSm1BMlltUG1BQ2g2TzNZUUIrM0JRLzFlNGwzUXpR?=
 =?utf-8?B?a3VCMXJtWmI5M2pxT1JmYXlDRStsM2FsQ21wTVoyWmNDQVFlWUkxSHVIMGx1?=
 =?utf-8?B?ZDZkM0lOZlp2dDZxanRQRDh2eGxvK3FGV0NCYURxLy9NUUMxVkFkVlUrdVRl?=
 =?utf-8?B?cVMyMXhpTFk1TndndXV1K2pNYWNqcWdySVBIcE1lV2ZlMi9vMXFOYjl5QUFV?=
 =?utf-8?B?SWczMjlHRktTKy8raUpYc25ER3FzRW53c2RFYVlhNmdvUGJsYUhmKzVoSm56?=
 =?utf-8?B?VTcyblFVM0EvOW1KeXhaQngvWUR6QWljSjRTVmd0bHEvR1IwdkZHMldFTkR2?=
 =?utf-8?B?S3JZOVk4SmVHUEI1cU9helV3VXkrTm1ONytLdTdCUWV5MU52M2RQUUxvR3dl?=
 =?utf-8?B?dVRHTk90dEltMDVncGN0ZnpmTTc2US9iQ0dsYWFhemNVOW5DTWhDdGJubUEz?=
 =?utf-8?B?Zy9ndEg5dWZ4WGExQkQ4RDJOTklKc09BZVphM1JPTlpGTUxtTFoxZ2h0aWZj?=
 =?utf-8?B?THNTUFhtOW40SG9YanBsWFpBTHJqbmxnbjFXNHFlZy93Sk9vOEUwR3FrbFU5?=
 =?utf-8?B?bmdVcXIzeS8vbmZPOFkzQ2prUUFVWDhWZ0xDT25GTUV2b2hRK1YvNy9jL2dy?=
 =?utf-8?B?Z0lDNkczRUZMRXRzdDQ4TWtHdXJLa0NnYnlsUDdRa1NMd0ZWYlkwcHVUT0E0?=
 =?utf-8?B?TE5OYjJCTmhEMmN5Q2s1aHNkcnFsTXVjc0d0bXlsOU9PWlpGc0paT1hxRkto?=
 =?utf-8?B?UUtVeDl6VnlmMFBLdkpkTVpOK1VxWVFOQVhnVSt4Y29LK1VKMGNwWm1oYng2?=
 =?utf-8?B?aUdZb2xDQ2xBZjhkZUxWMkIyZytUSloxUjNUaTRBQ1ZDcUZna09iOXVISHha?=
 =?utf-8?B?V0hwZUZQMmp6a3k1N1NSSzR4ZWIyUXdZMG52VlN5U0lnUUIrK0VGdXV2Zmhl?=
 =?utf-8?B?eVNxa1ljYlloL05TQ1JHWGt0T3NlMXNQdHZhRlJuMHRRL29uYWp4VW9ZY0JL?=
 =?utf-8?Q?mXLiw9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWNrOVhlUW5aMURnWndQc1ErZ1pjbGxMelVhWTZ1RXBMOXhBU2tzREl5SThx?=
 =?utf-8?B?dmZGTkx1OG00VVcwQUQrU2l5d2MwTlYwN3gvaVVSOXN2T0V2V1VyYVZsZ28v?=
 =?utf-8?B?NDRKK1ZqT0ZLUGc1emZBYjMyV0EzWU1LLzRqMVpOazlhTFhlbjFOdXFzSVJU?=
 =?utf-8?B?L3R4c3BuUG4xZUI0SHJHaFZRS2dmSnZVWmgxakI4d1pIU1I2UEZwMS9ZRjlY?=
 =?utf-8?B?NlRjOC9HMllhVUVvaEZUT1lTNWRWZE50b1NnekRZNkVwdjByNUVIUHoybnFW?=
 =?utf-8?B?ZlIrb0lRK1l2SXlZQk9KbjFwQzhPVFh2TXBzV2NvUmMxQlM2M1NvMVkzaU1a?=
 =?utf-8?B?Y0puR3dUMWMxL1kyRmF5MzhUVi9LakpCVXdPYVFSRU9QaFl3Wis4QlVXb1Z5?=
 =?utf-8?B?SnhrUkFPellxaEN4UW4zRlRaVmwrYm84bDhQay96dUFUb0ZZQkxFWnNHYjlJ?=
 =?utf-8?B?QW10SWNqUklUUEpZTEw1bkU0dFBFOWFVa1V5cjFFTkR4bnlEZnZDOWtuZ0RU?=
 =?utf-8?B?Y2dmYlVzd1E1SEJJOWM2TlcxL1JVZGZhaDJld1NXWXFoMmFlaFJpNnkrWlRS?=
 =?utf-8?B?cG12bFExeU9TTGJLWWtBU2ZVLzJmbnNLUGhlcFU4d3pSUUprY1lJQWtzdjVz?=
 =?utf-8?B?VDFIdDRXQ2xGZkdKSTBtOTBQcHFJU1RmK1p6UXoxY0I3akxzTW80TCs3UWsv?=
 =?utf-8?B?NmVIcmp5UE1xaUF1WDUvSTRxb0ZyN2tIQnpXeWxXR2RBSENTRklSWnhJTDd3?=
 =?utf-8?B?OEpwQ0Nhc0U4S0FLazlVeUJid25LZnNCd0Y2OTc0VG5qUWpWL3BPQThrNGdv?=
 =?utf-8?B?VWI1Z1hTR1VrTWtwdzkrcjRWZUc0VnhZc3N1aG5xTXJJamJGTSswWkViVXdJ?=
 =?utf-8?B?VnBhTDFKeEdUeEJZaHlmK2o1RmYycHFxUjdFQ3VmdElFU0s2UUxVdjcvQWVm?=
 =?utf-8?B?VmRoTlZMWE9DRUZuTkJZNjNGYWxOTDhhSVJZZWlLOWZJa2ZNSitKOGVWSUtr?=
 =?utf-8?B?L29NeDB5b1BzcVpsZS9vZWFXZm9scm5zblg0LzBvaEMvSmN5ZTJJVU80dVBV?=
 =?utf-8?B?NFRJL1ZjVHVURDczN3R1a1dNdG9uK3JOYVo3eDc5NlJ0aVp2UmxHcmtpWEt2?=
 =?utf-8?B?UTBiNGNjV0QvWmhPaUNjRHI5K3dITzJPTmZodGwwbm1wZlp4T2RkWFNrL3FK?=
 =?utf-8?B?UGFPcy9kc2VncnEzVStnOWpFZXpSRlJsbjREemxyejZaRmhYbFZjSy9FRjFY?=
 =?utf-8?B?NU9ZclB5dDVVL0FPMzUvZXF6bDA0RExIVUtTNnYrWUwwZmdOWitaWlAwQmN3?=
 =?utf-8?B?elYyeXprMytZTGpHaUF6L1dEbjFlUzQvSHFLd3hXYWcxbkpEUmRaMmU2YkJt?=
 =?utf-8?B?Tkh1a1ZYWFI0aXFTSGVLbXNiQ2hzVmFGelJqcGwyYytKWU5DQUxyRHlIdTJz?=
 =?utf-8?B?akpiYlRkak5DSjhrTjNWNngrZHBDODB3dFFNeGIrTGZ5UEFUS1pWKy9LUUFo?=
 =?utf-8?B?RzRxNUlrVU5IWG1ObVE0SXU3ZEVwaDkyLzI3L1ZGbEpyZGFhV0hRdDVGYldW?=
 =?utf-8?B?WFcwelFSTDBZSlJxUy9jVjBNbVJlcklYY3l1T1JCVStzZW9wci8zMVM1TW9m?=
 =?utf-8?B?UDdMeUFRWCtDNDI2eVh1WTFvM2JEL3hWMjRvV1A2R0ZhelBncE9SOGVKcDMx?=
 =?utf-8?B?cGt2OStqZDBybzBVcHVIT1A2MldWcGxBUWNhV2J1T0ZkQjVUV05GKzBpT0tv?=
 =?utf-8?B?K25za1NDbVJidHJDZlR4R0Rmb3ZNSDQwKzg3dFhiK3RTa0hPa3BUUksrb3Y0?=
 =?utf-8?B?RUJEOEN3dG4zbWorSVkxTDJIK0MvZ2d0a0JmNkJMZ0NYMDJKamxTYk1obkt6?=
 =?utf-8?B?Szk2Q1JqcFlVaXptakVET2pmZlAxREdPekdQcHU0QjdxWWVWQjlnbjdTckZx?=
 =?utf-8?B?c1dMZEIxcXM2SnV2N25kOTF4Ujl6SitHNFVRUmEyaHJ5aGFnY1B2WDMvSDFP?=
 =?utf-8?B?NW54SzdoVHRKM0ZTSlRxeUxxRko2ekhJcmVWZjVqMG5FZmFMVVBleTFxcGUz?=
 =?utf-8?B?d2w0czc0SkxwMnRSOC96SWloSWpBN1loVGtqak9FSmNMYVhzeXExWHcrdEg3?=
 =?utf-8?B?RDFHRDI3UmlkRDdQc0NSM1lFOFRGcCtSdjdYWnB0NkN6dWExNVNKeWlVU0JS?=
 =?utf-8?B?eXBiT0FUWm4yRzBmeEVyUWNJeXNFUUxlMTVTOEVjd2JaU29wN3BZc2cwOHNI?=
 =?utf-8?B?TmhIakMwMk5LR1Q3TWpGT1lLK1FNSGU4RnpRRjZFWFcxSFlrTjZkTlBzNm1m?=
 =?utf-8?B?NGNDdWE4Q2lqNC9EK0VOOUR4a056UWNleVNueEM4MnY1Q25teGFkLy90UUVs?=
 =?utf-8?Q?eqASwy3+njAtieaIpXHpbG0Xm4l2cKEYip8O6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5nbg1QxlcbVLRTjf+hheCLAqHgmbHFTkAAnZJxrS90jg+ogEgem5ytlfqzQYCCJJNNlYEaeuIjACMWseJH86jI5/vumXn9nRm86UCf811gT9NvIAHFuOVb5DhGN8pd2FVOCdG0GSnpwldTz9Y+3z6jSZMm/5YhTn4sz9wB3DOJb2CGhJQmrUOrm7g3GKcM+hI5pAYLZ3eu8WuPUEPqxkHExGYLD79uH4VLvZsMMa89fBA+NqZOGSzvq8rWx6+N7F2A6BtD4dHP/tyvS16up8IMGsrWThkFXs4XEzyaDfBeFsSEL0GGMZJ90gzKBkOzMEx2dhb8yjXnVsAQOZJx4xGpLn5BCoQOV/NbUJMqMZKveMo5NcShl0dPeei+lJ7sPk1QmqROBrLGwQGYYlJ/8A0UdtDF7dNX+Du9AvRxgj5w5UBbBGBLpxDTQlRCaMNdHVqhV5k8LwrJySWwp+mIrZspgGaedB9COW56FEUSX1E/WMVqdP+3HTk8d/c1LIVgbgUOLl22NdApgm0Vu8mV5dhXLkU2KzXjuMTmgBp2gsiVC8MwFKLDFSwZ8tj21yK8A9GNYwHuwhy0OBt8xxANOJ8YhfsukZUFodtzMkrpjYskw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd27f76e-e313-443e-242f-08de73794bc3
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 07:49:53.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHkH7l+7zdEiwOcEX3wMt9xbc8i0CCeGoV7cSl2SWXl2Iw/ehKhCzRJ+0fcmRo7jBLZyJIUC+tjBA4AKrrOQJTWWbd0/+D+oDi9sA6V1/ybuOEUYDXb/WcfA6/utFlBq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240067
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699d582b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=ycGLOZvRAAAA:8 a=YKEgdNGFHJTZdborTKkA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=QEXdDO2ut3YA:10 a=_FdmRy1lNMmlPwh0EFDV:22
X-Proofpoint-ORIG-GUID: 106FqQ3Iej4pIylMF9eNybaynERFEc6w
X-Proofpoint-GUID: 106FqQ3Iej4pIylMF9eNybaynERFEc6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2NyBTYWx0ZWRfX+P3rXq/r8Mww
 Gq5XniWuPEylIzscWOZT92tMN0CBrn/nGMa0L5k4iLeI3PmDZfcsBlVH3AHZ7Rk4Ne39sCHvmpF
 jTeDUxiQ7blfv+jftS19zLSDkOiBdxMRSeyVdfFyfa4z1tNjIU00VHpiOYWzdK+Qr9hXWnXxPv/
 lDdwMptnGqVcD4ulabCztJMne3mU7QhWJL8xOXWuZVWlTXMcJcdRytDoiI07/eI261OXjKZfY4p
 9GZbBt8LaelB/zQS835/Tj0/UWdk4y08so8fWPwjOwNpruoQCauzorpzIan7ycyR+Cx7JKq2c8t
 5ajZqeed4KSH9sAp0wDf1pxUS93AI/Olj6gcpYI5mvv2QjvocMfB78HFHjb4R+ubf76+2sjJbc7
 N+izmCxv108u2JpoN1FuUFcmkCCJVdEBSliAf7Pio8b5KQAzU3hnrhmtiNb21w6T5bhkE5zDjnz
 viRh2GnFNUSZN2fkGfQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217880-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nickdesaulniers.github.io:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 18B061834CD
X-Rspamd-Action: no action

Hi Khemissi.

On 24/02/26 02:55, Amine Khemissi wrote:
> Hi Harshit,
> 
> Thank you again for your patience and detailed feedback.
> 

No problem.

> I want to be fully transparent: this is my first time submitting a
> kernel patch, and I made several mistakes I now understand:
> 

Sure let me try helping, might not be perfect.

1. You are sending it to long-term-stable kernel (5.10.y)

So stable kernels, long-term-stable and upstream release. You can read 
more about them in [1]

2. Generally you worn against the upstream branch: (master from: 
https://github.com/torvalds/linux/tree/master or linux-next [2]

Once the patch gets merged upstream [1] , then you can backport it to 
stable. So the first question I would ask is if this issue is 
reproducible on upstream kernel(7.0-rc1) ? If it does, then try fixing 
it there. ./scripts/get_maintainers.pl will suggest you whom to email 
your patch. For submitting a patch there is some good documentation in 
[3] and [4].


> - CVE-2021-47552 is unrelated to this bug (blk-mq race, not NULL dereference)
> - The commits I referenced do not fix this specific issue
> - This is an original fix, not a backport
> 

Relating it with 2021 CVE might confuse the situation and in general, a 
CVE is associated with a fix, so when you reference it directly it might 
give an impression that you are trying to backport the CVE fix to stable 
kernels.

> I also have a practical problem: I am not yet familiar with git
> send-email, and when I paste the patch manually, the whitespace gets
> corrupted.
> 

References [3] and [4] will suggest ways to configure your git send-email.

> Could you kindly advise me on the correct way to submit this patch as
> a beginner? I want to do this properly.
> 

I would also suggest running ./scripts/checkpatch.pl on your patch.

> The bug itself is real and 100% reproducible. I just want to
> contribute it correctly.
> 

If this is a new issue, please use upstream torvalds/master branch.

Couple of situations that might arise:

1. It is somehow fixed in 7.0-rc1 and you couldn't reproduce it there, 
in such cases, try finding the commit that solves the problem, and then 
submit a backport to affected LTS/stable releases using [5], see the 
options mentioned. Also remember that while submitting a backport to 
stable/lts branch, always ensure all newer stable/lts branches have the 
fix. (say: you want the fix to be backported to 5.10.y, you must ensure 
it is already fixed in the 5.15.y, 6.1.y, 6.6.y, 6.12.y, 6.18.y, 6.19.y)

2. If you have to patch upstream, one way to correctly write a patch is 
add a Fixes: tag(that would indicate which commit introduced the 
problem), also if it affects stable kernels(CC: stable vger as 
documented in Option 1 of [5])

Let me know if you have more questions, also you can ask questions like 
this on linux-newbie@vger.kernel.org .

Thanks,
Harshit

> Thank you,
> Amine

[1] https://www.kernel.org/category/releases.html

[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

[3] https://docs.kernel.org/process/submitting-patches.html

[4] 
https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/

[5] https://www.kernel.org/doc/html/v6.18/process/stable-kernel-rules.html


