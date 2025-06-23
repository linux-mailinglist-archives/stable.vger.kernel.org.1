Return-Path: <stable+bounces-155274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D062AAE337F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B40616AA60
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA128E3F;
	Mon, 23 Jun 2025 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gEmwJPuf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="elyfDy1A"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671E22EF5
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750644141; cv=fail; b=G6F+EzQecDI4Ab6GzYPIJmH2P+nhlsS6SzaVIVTpupzuxoF7bTtufE6IOGVWfhSjoNeNQ6sJZnM0xV8aUhf6WVasVajM7rtIB5gIgPpoSiESpKoZwUamB1xcK06tg8TqavyoQXRR4x0MS8x7Rg+JQBlYPKeBi9vMMgA6IyQZISo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750644141; c=relaxed/simple;
	bh=OxV0UDVefG2uRN2CjkGvWwdIcKNCcyhB5YoWWmxGZG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSuOVKYqxBe8PtOdjOSk8gElo7EzBKaKke+u1J/g7et+WcLYmT+W3ezVP66/cLr7GpeiiRDkLOdRjJa7ZfVI+nPsDpa+z6C9XMho2YLtZzZkadaXj4Sr5CYbCSiOA40vKPdo24i8XbubnFi84zns4UEfR5mR3lcV+bPIH1WRQ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gEmwJPuf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=elyfDy1A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0R7bk014389;
	Mon, 23 Jun 2025 02:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nuILvl5ZCxQnGJkBQk5wcTX26dhOom6JtTh8ANL8pGg=; b=
	gEmwJPufUeoRKBhwfkCVhVwHJBMpuzYDyw0li38n/Yj+WiQoSK81Et3foBM9hpuD
	WbPP3E+tiYCzmIlvpMOfk1MNtWUV6b5d0xLLvsOWXwnZPgpBU/EeBviqo8l7HtLu
	008dNgY599yO7Ntoxi1MVsKRHVwbFH1sb6q9XYoyzZJN0JDmgX6vTC1IqKcesCtk
	ORw94kyl7cksxmi0hQurOi3xOjiVOvBUvgjRXnzsMdoFlIDEZFqrhWILZN857HTQ
	P4XlO7nqVwT20WlFcjhutQK+5DgD4YozHZ/z6EmNvvj/L/yY9qv9yQ+rxqulaqOO
	UZIAwE/6qh67On81eW4Qfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt18kkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 02:01:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0Sbde005015;
	Mon, 23 Jun 2025 02:01:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq1snd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 02:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdxtR5KouyWYfaJeC/3vbzchZae2epPOVoLHIF8rgXY2PQQbVt0tU9jETNKF/DPcZzGY2xiTa8Go5VbJjuvQ6xSGFmBqbU6FRWoCgi6N392ZonbyHpvonjqVg7lpjTNKYquDq5hgqufTXbYScxcvckSfr7Kh09DoxQU7QAz88Qz6YBhVLhLqZ+kn7jfPyL72qCSj9RUJ6vuI/zACYc/iqkbnUmp5xEkBa/z0MqeppeE062sk73c7JOxyiVvfjxi2cmzDqO2ldX2E5AEADspxMG/I5WQYE+II3yHyC7seueuqC2C/XId9IJA2WfHbeb8Q4BQf6BOt/U8mA0L97anZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuILvl5ZCxQnGJkBQk5wcTX26dhOom6JtTh8ANL8pGg=;
 b=glWy298V3HyGTQu2qo1DFiG7HkUVTxSIW0tXc50oJMrI5YcCuCH4lfxdhf8hqu2ruNGi+acP6ROY6NhDcJ9HcTlof4RJIFelrEjlzO6jrkp7rsioLTAKueP4uJqXuwIu5lxDS8+oVQZSPi+Ff33SB1RY7W2i0mglVZ9SkKBBs/sFjEgnU5kkhSYzGlKDVPNu4L/Ty10o47Yk5gcOPl9xuFbUSsFK0rLYJwOtu1VzYfRUjevcsrwvzy516rk5mWPaBDcN/rgO+TKgVUk82OO9mNlnvHtd8OU0xx9QEIqtJndhbAwzxsUYmL4cUUpMy2PBbz4D/mPXIlFZ+FNOeAmrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuILvl5ZCxQnGJkBQk5wcTX26dhOom6JtTh8ANL8pGg=;
 b=elyfDy1ArKP1MizyTLeMgwrXT9lT764QpRrG+XFBFNeJMgbPnqoFJMUbLC1Gwbg9mV8R9KZmqXr4aLi4l10C9zgXiAlawaOWvEs4JYCFiXZgvKj+wFkGyh6WoJ27taz16mF/S3JgMulVmSFSWDobcbVLNaqGybcHkVOt46AhYtc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF1731B5308.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 02:01:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 02:01:47 +0000
Date: Mon, 23 Jun 2025 11:01:41 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Wang <00107082@163.com>, akpm@linux-foundation.org,
        kent.overstreet@linux.dev, oliver.sang@intel.com,
        cachen@purestorage.com, linux-mm@kvack.org, oe-lkp@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()
Message-ID: <aFi1hcpzFs5EhPAb@harry>
References: <20250620195305.1115151-1-harry.yoo@oracle.com>
 <7935cfb1.1432.19790952566.Coremail.00107082@163.com>
 <CAJuCfpG3=0MCac2jTVM9LiJWDwWdLE3vrcJp52x4ZX5XdSEv1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG3=0MCac2jTVM9LiJWDwWdLE3vrcJp52x4ZX5XdSEv1A@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0006.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF1731B5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d618f3a-bfea-4309-e5ac-08ddb1f9e94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czh5a2NyalIzbEozMlZ6eTNtYzg4YTAxdExUYVNMeGRRUkJXUDhPdHpHV1Z3?=
 =?utf-8?B?NHhmSVZsNnNJZktFdXdDRy9qeXdXYzVmRzRFSnhaano4c0ZEYnVSSXNVOVdG?=
 =?utf-8?B?NDNCbVpwWHIyV2tadUE4WlZmOGRwek5iMlNWZ0Y2RU5GUzVMWGF4ZkZubDJE?=
 =?utf-8?B?Q1FKZHRzQjlNVzA1RTRxOXlwWm5Qbkh0K2lCaktyNFpiRVVSaFhyTExtUjdk?=
 =?utf-8?B?N1JyTEVOVEUxZzI2eFNTRFRXbnJlUUVzWDdaZktHakkzRklHTzlpZ3Eyamw4?=
 =?utf-8?B?Y0FzMzB5aWlYNkk5SWVRei82UW1SWHhIbVhKMlZ2OE1HWEVld1JpR0gzdTJj?=
 =?utf-8?B?dmJNRXppbjJjL3RJTENLODU0WUwrNkhCUDVmMjArZlNrOG1mN2tOb0lIbkUv?=
 =?utf-8?B?SG1xbEVpRUZZZnRyMFhCWm92MklERXJTNHduRHJOMDRKeFBUN0Y1WVNnWERj?=
 =?utf-8?B?dFpjUGtlRWFscG9RVUlnZWJpc2Ywd2o5MW51dGY5YWxreGZLTGtmaHFqVjI5?=
 =?utf-8?B?NlVXeUJQdko1UzBObkVodDZPaGp6ZTFyVmZnbHRJeFB0eWlJWkM0bVd4QVNH?=
 =?utf-8?B?Z1h5b2JUeDFwVmxLYjFxcXRabjdBRzVaNFZYSlM0VGVUUnQ0R1pEYWlmUG81?=
 =?utf-8?B?eFRWR2t4TE1aeE96YnhISjB4bFlhQmtYbkkxa2FnV3o5ek90Qnc3WnNXRG80?=
 =?utf-8?B?d3BZTExHcm1lNjJoTFZwS1E2NjJaeGN0R05FRDc5NkhGM0hyQ3VOWXh6SnYw?=
 =?utf-8?B?dE5vVjJnMjV2WUFWM2htVVgrZ1EvNVRRNDB1SWwyaWNnUHQvOW9LK0RMMG5P?=
 =?utf-8?B?bTA2NDNjdWxtR3FLUUU1cjRSaVBoZ3hraWtlWmwvSDd4cldYT0RJemZZZUNv?=
 =?utf-8?B?R3N2Tk5lTS9iMkZsSVRMTzBSc3JhQVhYN1ZkWjk5T2ZSQWpMRmdiQ0ZUam93?=
 =?utf-8?B?SHQyejc5dTJNZGovWDVVQXJCV2FIOUNJWm8vVjZlVGUwWmk3aXZrUHh2MGNz?=
 =?utf-8?B?SHIwMTl5aGY0WndqeUR1Rm5ieXVEK25XbTFZa2gwcE9DcWRkRG9KbExhOEF6?=
 =?utf-8?B?YzVVSDNOcUJzVExsOFB2b1VLUVY0UzN4NXdKUnkzb0pZWS9nSDQ4WVR4T2ZL?=
 =?utf-8?B?TmlYWVlkc0F5UVpKbWJQNEx4djZZZ3dhT25SY3ZrQW4yWDV0UE0xOUd2U0VD?=
 =?utf-8?B?RDNQL1BzU0dEMkdRcjF5dTl3ME5JRHhIYU1wRkIwcUh2UU5jMmVSY3pISU5E?=
 =?utf-8?B?ZlZPOFQzcC8yMG0rVHA1NDlkQmIvMUJOS1N1Q3pNRFgyczBGejRidmE1OUxs?=
 =?utf-8?B?SXkvc0ZCcEJaNUJmM1dRMHA5RXViZzlzZEMrMERpVHptMDNWWHFFREpPNHJt?=
 =?utf-8?B?SngxdFBnZWcwSjRpVU5IVWcvRUlEcEdCM0pYTllTOWV6aHRrUTM2NFN2bkYy?=
 =?utf-8?B?NTZwUEhEeXd6ang1SDkyVkZOaC8wUmJjYWdJQ2VmaE5VQytPOTR3WUxMWVpR?=
 =?utf-8?B?UG5EdFVENFJwQW44dGlERlVGTVRDV1dQM2NwNnhBVTFVcndGV0Y5R2thcHJT?=
 =?utf-8?B?TGZ3T2pjT1hSNzUxY3JZSHlvNGpOcS9NK204NmYvR1hwdU5IRmZzbUdxZ2Mr?=
 =?utf-8?B?K1J4eDlrYzhVTDY1bGgyTTBhYjRya3RtbVdyWlgyS3V4UXVkRG4vcXduT3FL?=
 =?utf-8?B?ZzdIOC9idEVFdDRSVjNhL2FJTWZGL1RxVHZwWUZST1ByYnVWY2ZacWtMUFFU?=
 =?utf-8?B?TlMwYmw5bGFZb3lWUndSSkZWL2VXQjgvQmxURjZwUm1TTzFZSUoreng2QmxU?=
 =?utf-8?B?N2YwRVZLYjUvcDVSSm44ZkNWVWhSNWRCVzE1NUw3MTZycVgyTlc5UDlWSHpw?=
 =?utf-8?B?azNPZlpacDdtL0ZUdUNuR1VKeGdhTjZLRXAxZXpnU01IN0QzNWZQOWp0RWEy?=
 =?utf-8?Q?MgmHYkmzrnA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWk2anMwR1Rab1NyOEZGRUQ1ZUVralNrSCtPZEVmWjhPRXgwcWgxdHAzaG41?=
 =?utf-8?B?TE42UjlybHphL0VMSHdMdjE3TEx1TktTQXJmeXBmMlhKWmNwZ21JQ2QyK05o?=
 =?utf-8?B?L3NMNW9DNFNNcTZ3QWhnalJyRnJHRW0yWWY2ZUZxbENzZmhOUURVeFNvNzVo?=
 =?utf-8?B?MGdCOGFpVlJLTUgzQkVEc3k3dDlPQUo2Uy9NVXFtbHNPNkVCQjV5WjZQMzdE?=
 =?utf-8?B?dmI1YWh1bnorYnlLY0xEYitmZDdwVUVqazBuaTJ4WHhZSjQxYzE3Y3dBekxT?=
 =?utf-8?B?dy9EZHdld1pNUE1XNjNadFZEdDNTNi9ITXNxQkI3aWJlcStyVmlqbWw3d3Uy?=
 =?utf-8?B?L0pxMGRKK2k5QWJFUDBpZGFjRm5KMFZ0RERkMitnVjNLM21LVE1ZK0NQRHEx?=
 =?utf-8?B?cDlaUmJHRUVjS1pabzY3WE9SM3l4Q1FhZk1QbHZIQUN2ODBuOTEvYTFucko0?=
 =?utf-8?B?dHhCQjNhakpneGtFcjM4MmkvTkJ4Y044Ky9QZDcxeGxiL0hYQW5kOHVxeVJD?=
 =?utf-8?B?QlNLNU9yRXRCbTBWV1lxKzhMazhCR0JGbldORjhyK1RrRXFPSVpza2Frb1p1?=
 =?utf-8?B?dk1CQXovTzQvUkloSFl2Y2Jnb1lqcklaV21pM3h1L0tTdmpoMkswblZHaHdw?=
 =?utf-8?B?QVgvaklIWDNHMDRVOHRQakZyeUdmWHNSOWRtTGlHeldPem1lVXhtRDhzUGFo?=
 =?utf-8?B?eHZ6Skx5cmgveVpEcTBRd1JxOG83Z1JKdTRlQ3cyTHRDSVFWTGQ4bGtvamZS?=
 =?utf-8?B?OWQ5SktzaTc4QWlvdUgrelNBNGpwNkZmYlJiYUhaSUk5QjZXQlpYZDhpazV6?=
 =?utf-8?B?bS9KbHh6NVRiVGswNkFmYnh4MXFkSjI3WXlVR0did2VGZ1FaUTI2YlY4cFA4?=
 =?utf-8?B?VXVHWTg0SEVjOFRhSzNTanJUUnFwZjJIZlFUZllhQVkxVWtxOE4rMmpvb1ZZ?=
 =?utf-8?B?OEhJeFV5OFJXL3hnM1MzeGpXUzhwdlIvSXpvMVBhVEJqYmVaVnp1cFRib2Ur?=
 =?utf-8?B?WFNDdjBqQjFscGs1UlVlSjNZdFlnL3MyTW1PK0swTnJKVVlUNHJkUmdJWEVF?=
 =?utf-8?B?eTMySHRpa2hQNlNkellJcW41WkFWQ2ZLU1JQdDlEdGE4eFUrMXVxN0t3TDlZ?=
 =?utf-8?B?SVBZNEMwT1BDY0tQRTVyVGVwTVNwRlZqWGV0NG9NSTRwa1pNa3VZMFU1ODdt?=
 =?utf-8?B?WkdzMDhyR3BETVFOT0hNU0NaK1hpbDNXaVhaUmdkK2lIdHRvNVc1dDlVSDBh?=
 =?utf-8?B?YnQ4ZWtTaGUyTFJJcThJSGpHY2dhVUpRMVphTndjTWt4STgzNi9Ld1NKSFRy?=
 =?utf-8?B?cXRNVWJNVDlOV0I2dE1SZDN5ZzZIamJraEVqbUw5SkFadkZrb0FrSitqNUFD?=
 =?utf-8?B?NU9FWmthbFFiUC9BOXcwaW00NVhHZURxRzFtWjdqdlRtSHpwK3BoL2xxMElK?=
 =?utf-8?B?TC9OSkVXdCswVjdHZ3pQS0V0Qk1mL25NSGF3ejQ2MTlETDR3dDc5cEk4SERj?=
 =?utf-8?B?YnpsRjRyS0s5Nngrc0VWTXhOZGJ6RDdRRWd3TUQrODlRWTB1Qlpsa0hHbnZQ?=
 =?utf-8?B?eUhpTWttS1RjVUxiaXhJdEY0Q0xGcGFsWDJCYXFPYm9wTno5NEJRZk1sUXpl?=
 =?utf-8?B?bmR4TVBwMzFweFRFMUJjaWI0LzNwMTF3bGVtZ2RWa3B1ZDhZcmNndzZzRVg2?=
 =?utf-8?B?VkhQNnNYUVhMVU5FTW5YcGJ3cWxPN095YzcrVFpSd2NSQWE1cHU0NE8yTmRw?=
 =?utf-8?B?L2RMaEgzVmwySkRibW9BT1hCZVlDRGF0T2I3STg3eG5YdDd3RW94TmZKRnU5?=
 =?utf-8?B?SmIvSytaMnkreDBTZWRIMkg5VmZLTkRMUldBU29pUFEzKzRZa3Z1VWlpT1Fi?=
 =?utf-8?B?a0cyQ1g4SUw0WDR1THl1eTAvbTJXZUIxdXREWUtrNUxOMHhVNmNwRkFNYitu?=
 =?utf-8?B?cElLNXN1TWM0T2wrY1I1Q0tmSThlV0x4bHFEUmtQZWdNanBIendJekhsMlRs?=
 =?utf-8?B?Q1I5N3ZtbU43RVJrSU1telRpTVZsekRxQU96cml1dUl0ajU1ZVgxZ3dBTlBH?=
 =?utf-8?B?Vjl5VUN5czVrbXFkY3p1d0JuUnVST0Y0TUFPb0FXRDl6UzdRM1ZDaUR0T29p?=
 =?utf-8?Q?d0qrys1DuUB8T0VUKdiWL2sWX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZGuErM/8ZGIkLXu6G8j/CSthYeVuslQMjuQKR+aZ2GacZ+4KxJTMBDbygSZ27usGfNh5kWD9flI0UGP9vPawYe1W7WV5GHNGBpWi+Uc5Vcc0fLyLi7OH37hLL5tbByM5ko6UxqPuZYWKxUzMVa5nyMUnLzrgBLu+b9uO3X6sKowywcHAPtJbhK0dJUtlzNcx8Z5AawZFp5Q8VX4ysqI+/MgmA3I1Utwizr5cNo6gwfpN6RbYCy+3LM8XYt2ipsgz/zSeU8FcPr3HyX77IClvSd4aoepxC+TlTySeZRQWXG/b95hU4hZixPpujN708Y67MtQeGxkGjlZy4gw7BD1p2S4/VA74DZb1syL24D9Fo1VroziALNPwodx0IWm5jmLgg/A3WTE/KQZSfmB6/vbcbBNw6PZdBkEJ1b9iH99V+CNQXojqZgNVeiOL00iLv0/cbI4kRiP/J9tbGsf6PIYO28o07TvyQ3vq2GwF1D8vo7xSfSdoJyrk10g/5oRzHaq890U/5jhoSLwcb+Gu1NAdSVo1XF1nheFDvdQJ7esSHvZ4fjTif/0/AiW3pVPn9wGAWRR7KP93mabR9Ru2ri4mIVdFmi6CsWU5Gust/fXUFXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d618f3a-bfea-4309-e5ac-08ddb1f9e94e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 02:01:47.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFTEKd6jQxRzXNTWsrAt+nwIgxYnqlhEae+XdrGEb1oLPd2TSGdq/ZJSr0oKCD/ioCJKB4Kx/x9NhZF6oKmfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1731B5308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230010
X-Proofpoint-GUID: v96yZVbO33peoJZdI7f99nz96R8CL3_t
X-Proofpoint-ORIG-GUID: v96yZVbO33peoJZdI7f99nz96R8CL3_t
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=6858b590 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8 a=HGX2g6rpJ89jZeE68RoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAxMSBTYWx0ZWRfX7csTOzeClT2U GrHCV+ZpY9HGdVdXthoqvRnj5/hpQzq9a/8TK8WQXdP3UvJkEYgCyri7/hx93wy8/+zFgEjcn4f dEeumL8p4Z65RbOkI6uu40dUIWnNkHtVC+Uv77HxU4ILsr8G0ydjomfCdBgdGgfIRILd/fwi9Cj
 YX2JBXlM2ms75/7PZcDfRqetnUnj6/Bg6wCpMrwNBuYDWFPPnv1t29geLr8VSK8gbrYnb+1RGkv bTYRjAyJGh5m+Q3PuAVGghjOVleR3VlT3twgDqW0O9tTV4dewP8SPXC3dWvpZNQ/UGyQglQQ5RG rdPNGlKLMAkqBwXLZS2J555EGfTSSvvVIXSHYFVGHx70E0bB8bZwkNrISGs9eSHelI5/ZwJ+/A5
 /g3B9Us58JcF7OkKGO8whS9wKib4v5mfFx356vt9VM0jIxgz2roiI3j5WavGeifJtV0/PIQZ

On Sun, Jun 22, 2025 at 03:24:08PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 20, 2025 at 8:43 PM David Wang <00107082@163.com> wrote:
> >
> >
> > At 2025-06-21 03:53:05, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> > >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> > >even when the alloc_tag_cttype is not allocated because:
> > >
> > >  1) alloc tagging is disabled because mem profiling is disabled
> > >     (!alloc_tag_cttype)
> > >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> > >  3) alloc tagging is enabled, but failed initialization
> > >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> > >
> > >In all cases, alloc_tag_cttype is not allocated, and therefore
> > >alloc_tag_top_users() should not attempt to acquire the semaphore.
> > >
> > >This leads to a crash on memory allocation failure by attempting to
> > >acquire a non-existent semaphore:
> > >
> > >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> > >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> > >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> > >  Tainted: [D]=DIE
> > >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> > >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> > >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> > >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> > >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> > >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> > >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> > >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> > >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> > >  Call Trace:
> > >   <TASK>
> > >   codetag_trylock_module_list+0xd/0x20
> > >   alloc_tag_top_users+0x369/0x4b0
> > >   __show_mem+0x1cd/0x6e0
> > >   warn_alloc+0x2b1/0x390
> > >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> > >   alloc_pages_mpol+0x135/0x3e0
> > >   alloc_slab_page+0x82/0xe0
> > >   new_slab+0x212/0x240
> > >   ___slab_alloc+0x82a/0xe00
> > >   </TASK>
> > >
> > >As David Wang points out, this issue became easier to trigger after commit
> > >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> > >
> > >Before the commit, the issue occurred only when it failed to allocate
> > >and initialize alloc_tag_cttype or if a memory allocation fails before
> > >alloc_tag_init() is called. After the commit, it can be easily triggered
> > >when memory profiling is compiled but disabled at boot.
> 
> Thanks for the fix and sorry about the delay with reviewing it.

No problem ;)

> > >
> > >To properly determine whether alloc_tag_init() has been called and
> > >its data structures initialized, verify that alloc_tag_cttype is a valid
> > >pointer before acquiring the semaphore. If the variable is NULL or an error
> > >value, it has not been properly initialized. In such a case, just skip
> > >and do not attempt acquire the semaphore.
> 
> nit: s/attempt acquire/attempt to acquire

Will fix the typo.

> > >
> > >Reported-by: kernel test robot <oliver.sang@intel.com>
> > >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!NZv9w8rtFb5ni1zqQs7y8loVNvbrbW3d1pBi4bA_f_Tfh-pegcni0iK5642QuK6FqCBCaOUfy-7KeUc$ 
> > >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> > >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> > >Cc: stable@vger.kernel.org
> > >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >
> > Just notice another thread can be closed as well:
> > https://urldefense.com/v3/__https://lore.kernel.org/all/202506131711.5b41931c-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!NZv9w8rtFb5ni1zqQs7y8loVNvbrbW3d1pBi4bA_f_Tfh-pegcni0iK5642QuK6FqCBCaOUfSGgkKj0$ 
> > This coincide with scenario #1, where OOM happened with
> > CONFIG_MEM_ALLOC_PROFILING=y
> > # CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT is not set
> > # CONFIG_MEM_ALLOC_PROFILING_DEBUG is not set
> >
> > >---
> > >
> > >v1 -> v2:
> > >
> > >- v1 fixed the bug only when MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n.
> > >
> > >  v2 now fixes the bug even when MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y.
> > >  I didn't expect alloc_tag_cttype to be NULL when
> > >  mem_profiling_support is true, but as David points out (Thanks David!)
> > >  if a memory allocation fails before alloc_tag_init(), it can be NULL.
> > >
> > >  So instead of indirectly checking mem_profiling_support, just directly
> > >  check if alloc_tag_cttype is allocated.
> > >
> > >- Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202505071555.e757f1e0-lkp@intel.com__;!!ACWV5N9M2RV99hQ!NZv9w8rtFb5ni1zqQs7y8loVNvbrbW3d1pBi4bA_f_Tfh-pegcni0iK5642QuK6FqCBCaOUfwfwsQlE$ 
> > >  tag was removed because it was not a crash and not relevant to this
> > >  patch.
> > >
> > >- Added Cc: stable because, if an allocation fails before
> > >  alloc_tag_init(), it can be triggered even prior-780138b12381.
> > >  I verified that the bug can be triggered in v6.12 and fixed by this
> > >  patch.
> > >
> > >  It should be quite difficult to trigger in practice, though.
> > >  Maybe I'm a bit paranoid?
> > >
> > > lib/alloc_tag.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > >index 66a4628185f7..d8ec4c03b7d2 100644
> > >--- a/lib/alloc_tag.c
> > >+++ b/lib/alloc_tag.c
> > >@@ -124,7 +124,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> > >       struct codetag_bytes n;
> > >       unsigned int i, nr = 0;
> > >
> > >-      if (can_sleep)
> > >+      if (IS_ERR_OR_NULL(alloc_tag_cttype))
> > >+              return 0;
> 
> So, AFAIKT alloc_tag_cttype will be NULL when memory profiling is
> disabled and it will be ENOMEM if codetag_register_type() fails.

Yes.

Or when memory profiling is enabled, but a memory allocation fails
before alloc_tag_init().

> I think it would be good to add a pr_warn() in the alloc_tag_init() when
> codetag_register_type() fails so that the user can determine the
> reason why show_mem() report is missing allocation tag information.

Will do.

> > >+      else if (can_sleep)
> 
> nit: the above extra "else" is not really needed. The following should
> work just fine, is more readable and produces less churn:
> 
> +      if (IS_ERR_OR_NULL(alloc_tag_cttype))
> +              return 0;
> +
>       if (can_sleep)
>                codetag_lock_module_list(alloc_tag_cttype, true);
>        else if (!codetag_trylock_module_list(alloc_tag_cttype))
>                return 0;

Will do, thanks!

> 
> > >               codetag_lock_module_list(alloc_tag_cttype, true);
> > >       else if (!codetag_trylock_module_list(alloc_tag_cttype))
> > >               return 0;
> > >--
> > >2.43.0

-- 
Cheers,
Harry / Hyeonggon

