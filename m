Return-Path: <stable+bounces-194698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39FC586E3
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A54304FB1BA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6B3559D1;
	Thu, 13 Nov 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dRbwpBCn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dA2Gp4J2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B63557E7;
	Thu, 13 Nov 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046979; cv=fail; b=bh9mWdRj5jEUJm3KEtYAhx9G1mfGdnE559vKglJ/Kd85H/MaOOk0vRlBno3QrTLv5RlGspvmHNpahh7qFiK+EdgjFAwQwa1z04oeyJaZ+tNWplCJCsH6buxV/GIeBxaHQn4fcTn0P9JcVNqNeSwXb7ERXv34ddbThf7O7p0/37A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046979; c=relaxed/simple;
	bh=R11KlaJ3i9dpQj1Vh0ocjHmW00ca3kbJW3kFQFBWGsM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IPlRMQ9YNARpykCurlr49lL3LWzGtxDACF8ZccqrY+MLP3YlB0yT7azh72dBBOfdUCVZHefHTfKZYzlvtVnP2hjJco/hC0UiWD6btQbm+/yMGS/nLonJgmHiLabUKmx+Q/Ya2wGXJzb1E+KSm8st5J2OmAjh2QUsL+WU5SqsoQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dRbwpBCn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dA2Gp4J2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9vBF024382;
	Thu, 13 Nov 2025 15:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cnm5BSdJEZlL7A993C
	AxQQzajeDlJDGOQqRRtRdNoOM=; b=dRbwpBCndnzXKxZBu1SlASyNwlV6Ik1x2U
	gHbcavlYZwUuEdeSOKnR1ksSmRLVRYOQvxncY8gyKIGCFREcvwI8V9yFLZc6QbfO
	dDhekDQYpCkPNiRVq0vk+5TKvt0kKMwhVGe93MIkO95+/jK9NyFc4WLmq1bD0ha2
	HnuvHEPN2yIqq3T2INi0bUiCiWNSSLosgMzN8BRtCeKW0TWFUOFNhUzqRrpzHK+k
	uOnEgAEff4rYR8pAp/TFWaVo51vHvqnwTJXjRARg3GHiYenIbJs3sy7B+R9LEEUz
	YMoZqT6ibH5VVOodWSgPPxkE56OPrBVBEohOUqtDm1GhCHYmwuEQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjt9wb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:15:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE8c6I000473;
	Thu, 13 Nov 2025 15:15:55 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafsxtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4715vPNR99uVYMBD4R2tIZCGFTM2g1u3M1O1o6c6WZ7HpFfsR03rYHfC7daPjjq77LVQgxJmTC+U8fvHcts0Q+w98POSx+h5J0wMsSNiyNN2WnRsYNJNdYGMRpHprC8DILaRXjvLwGmRn/urYvpXbxAVooykKbUXbdUYm/009ah1ePflGc8S5mRINWtqTpnBDybP4gqv5iJQw5SXdVSj32bzSRhSZ3qFQpY0n5e0Wa1H2LPz2h9t0iIFg3jL8tkTQkHLs1F8NaJQI2QwgwcK25JTGSM/n/SlZqbO049Vi+yZQmCVw7/xb2npe0ZR3wwjk+y2RE5UeDfCq28cw1lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cnm5BSdJEZlL7A993CAxQQzajeDlJDGOQqRRtRdNoOM=;
 b=zWWAkOAfNCBqpgrh73Gdbi0BkfClwbrQKpF/KVl4+4O10lreZAQ4aNXIkzLrcoqhl9VzFmLhnGbftlTUSJuPtYRYHtTAbAswnKjS1jBm/ugHC87RNtojo1+dDiBDgarpm5UZgKoLm4mkb6yw1UXXbDEntJToDby8koi3y8XLgqG7g1DaLKcyKBztCI1IRA1ULv1nArf+7M3nakPbdbRGRc++dovtVDBw73SFQHo+OiH2VRg2MqKkzOSvRRhjqBzOYmIOJiDURzN6IiL86O4AlWIk3BdGDLQ1v5lw4OkmyZEkDc02QI3ywsC6QcRiS+5lop5z8x7Lo/5ES9e4WOZZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cnm5BSdJEZlL7A993CAxQQzajeDlJDGOQqRRtRdNoOM=;
 b=dA2Gp4J2AOVqiagEWFK8KPfmARIEQbo4QUhYDwFEoBeZdKhCOULxO4GiAcPc9jjlAvOkAK0lUIBPaqyE08p92wuA4yy9X0PQgS0VMCoGTWjZbCZLJCX7Eyh/SOG4Nt0NVCXV1EM1Ah5PYhwXf7CT5sQBbg84mHQxtOet1hUfkq0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8491.namprd10.prod.outlook.com (2603:10b6:208:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 15:15:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 15:15:49 +0000
Date: Thu, 13 Nov 2025 15:15:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <87547aa8-9629-4793-8483-68408235ee45@lucifer.local>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <uvsjfodaoyikufskxriaycxcydhhgzndhs2hp4ydbwbgivhna6@h7svwhivantw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uvsjfodaoyikufskxriaycxcydhhgzndhs2hp4ydbwbgivhna6@h7svwhivantw>
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b1a2fb-3f11-4f0d-a35f-08de22c786aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NU4z8dCANiYsKCIdjHBbqJFTjwg1w5PPX/kWLPF2UktnqWWPjWddRc1zZUK5?=
 =?us-ascii?Q?VtPHuO7JswSXwtSz7q404d4aKmLP7myzpHa1RWE4ZAb1c9SoGg0wboBigVbZ?=
 =?us-ascii?Q?e7UHh3xgo9gnxKN5+P+yyX2Is8K1iu2YmoASAT3PxOqC/mX92FCVGbK5ZyvM?=
 =?us-ascii?Q?03bNFg/XaoDN2KALiz6bZ8aUD131JIfd1T6vBS6T6J7yPvnEl1bHTlR4kwbO?=
 =?us-ascii?Q?Le8KMvncrnz1l4LGyqJtNsw/h7u6M+tVL+Dcinw/DYS9hupVBqtA/IXtCy7C?=
 =?us-ascii?Q?OhVoNjsvJ3RxML/V8detiwfBKB4V2dTwSocoPl/B4lZdF4z+WSrkPW5Oadi4?=
 =?us-ascii?Q?dLaMkY/c6MnSlEqAT6GclrhDjLL8HTuLiOj1hp5XnxneaWmTt2DgBztjDO1s?=
 =?us-ascii?Q?BkXKEzE7nZNZWMNIHBlmIOC6U1mYBVPjDWzskpsea2Gi2KQxSys10HTpy/QQ?=
 =?us-ascii?Q?qwV2fBcU6727Ra9IlyV3J5CC8gJ23jg/LoaxMJEMxxuU5Nn+j+GPuvzCUmry?=
 =?us-ascii?Q?Bv9auk6ahDWXfdMsvcPFZdmMRNiGqpJHnT7WopGRE3m51xYMLU0+Hn24Ve/M?=
 =?us-ascii?Q?IojVg7fFjtqKgggWC3ke2BxoR4gf2mZSGjxlpRurC6NqKdeL+u4iIoVpDmYE?=
 =?us-ascii?Q?1h2szJn9JotD9ikGcSpY/DxM0d8wM1VYKkxMtg90Kra2CX73VWGtenN+EdEG?=
 =?us-ascii?Q?kDrbcyRp3wonpo0/D/EXx3EZTLg9P4PYIkGqKAiImkIsX+zBbaxt73bigab0?=
 =?us-ascii?Q?DSMCe0j7cri8AorHCTs0CyHaxkVVze4BL80bUha4n5NSlc+rVuAGSa0OYFEp?=
 =?us-ascii?Q?2JXJPi73YabQ4SHPwYBPaZqPUtEHQ50A1HhmRot2dqJIPPTEePqxtBs4Ui80?=
 =?us-ascii?Q?ay3P1zip6oEns5dl9ZsG6C6oAOB92oVq/BEvmrHVNIZTeJeQnFGglMc9iHOo?=
 =?us-ascii?Q?oNPSB0O28zk1kDvwzttU6EJRwj4uFpPe986E5CS/jaOqvJxiyzvwCSeq8OZW?=
 =?us-ascii?Q?tAeDd+U4Nbxc5pZunMe3A22616ta5E1QI7ZW+iWyt4agz4BykVdlvonaU8Yo?=
 =?us-ascii?Q?bVZXRFZc3t2H5Ya5OCR65LjTBPvc8VjszmYb115QaABCoweNtPibludOPCPD?=
 =?us-ascii?Q?ezfYcv/rIRJVtP4IVHjsZmmRARRAnJ4s5ad/bTgO8ZLB0wVm8t0N0Y96lGRo?=
 =?us-ascii?Q?hfzS73ptmYOzQg1i522hKkt9SXTyC86Tp3BwFrJO5UgFU4p6dY6FWPAj/F2g?=
 =?us-ascii?Q?vk1pr9oOqXaTMAKBCK0hInmDrdbaBB4xY64i8ddSINHxIcc3CdTRwL6MruK7?=
 =?us-ascii?Q?gAICvm2RZay7VOpBMUySY7HqHXhMH20QpDaqBc1dGNL9kT+ATAf5BAGS/30q?=
 =?us-ascii?Q?iXTEO2DPBt36VtXswCh4UrUq3KOGAsyq6Suy1c36QGWjeNEx4E/Mx9XB0Vxv?=
 =?us-ascii?Q?lNKxYgmOp8TAquU+epRNtVBbxkTJv6Fd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/Xd7/frycVF3xTLlXLDC+TVdsRig0FXiqw6snjgNLDVCR02Cr+NJzTom52z?=
 =?us-ascii?Q?VvtefdiVE/5j84QPQuO6JW5Ko9GzQuFWNVIUkZLuCGiNQT18CA+YD5TZhU3d?=
 =?us-ascii?Q?XlvnH+r4cGSLpcH6kumfRUpYub9PaDXwY3RmNkLI3ZWBpL//pFnrQG+8sLpf?=
 =?us-ascii?Q?+jbsjmxyy0eSJsGB9PgvAfdOPXrxqaD7pSjo0gXo/ia6t1p/ZrdkRxMeTYUx?=
 =?us-ascii?Q?GrGh7JDNxF4kkkVo0P6veiK0OZRrJgouuGHuxfUmJfVF0boYBjP1KnPyib61?=
 =?us-ascii?Q?PSOmXMig3rXIg2V8gbr5X6snJB3AgNNREyaJY55MLkrQRx03JxdH55Sl2Dx8?=
 =?us-ascii?Q?KsbOZBlZ9GyRNQxctfUsr9BP8sB95afAumm0aznrc9w/T1/6lsVgqMfYvRcN?=
 =?us-ascii?Q?GLruybuyYgut6+E4Yp8NupaQVSAdXUPQSK9L6KjTCCVwW70rWTVISynffOtR?=
 =?us-ascii?Q?EeWooVXS5UWwiR2ZFvfANeKXt9Q6TtAGibHhcDAxUl2BE6TwSEjGE7RbR6uj?=
 =?us-ascii?Q?E8ETTTmIQpIimhAO1X6ikFw+S6FCO0IOTzMhei5al5msyRtUMtx2xL6F867h?=
 =?us-ascii?Q?TifvgpKAwn2HJiLrcsPHYYeWDYL4TX/Nd89fuHwgID+o4gWjRMzBfmx3cgEM?=
 =?us-ascii?Q?5mSySZhMAcb5fNFDRif/OGfcpgy8rC15O2lKB0zvn/XblZP4+MellawnX8jT?=
 =?us-ascii?Q?jb52qGVgaShp8bdbZ6nvT0/YED1M2wwoziK97Z6dhRzTFn7gklB1GPmQ5ilc?=
 =?us-ascii?Q?NFF2GZyvbwp09og8pWTKybmXXAR850WLXZlW05ECdLwex014g+iIM69hylvE?=
 =?us-ascii?Q?X4YEPgVpObwdJ2ZplC++vmcm46oIomLU+xM3IzMPYDJNT/Unm4Im4BfeX8p3?=
 =?us-ascii?Q?KexY64jNLEbxO2JiJMsFKdKycKL8qYAFwQtOhCw4GRkG7sw9aRFDCUtU33+6?=
 =?us-ascii?Q?gDghhSTqR2dSrBePRwMx/hgiRnKorrvF3aHOaNlElygZx7Jn8WSuZt7QB/PA?=
 =?us-ascii?Q?5pEaKGhTDu8mZZhcs4bDDso1uYcRNqwTHyEIs8ksDxusr+QF26upslEvWMIW?=
 =?us-ascii?Q?WaXk99ckHN2I7XDXIlvP++d4yF09skpknl8LTZ4bST/lrvvID0t0mkXNP7UM?=
 =?us-ascii?Q?8Qh8LMzjjHALHmhjB/qZxGo1vXCOfLd7RE7DWnjTucbn7Vryy6jTth/ovDBI?=
 =?us-ascii?Q?j9ZHMNYWCUcqjk6Znx+xBbdWFxaCp+4xVf0V5K1mi2vY9FW7wt778mYIbC6d?=
 =?us-ascii?Q?KdRdqUmgfdltSn28w7LWunXu5JR6t9l0AWa/xzfqfa3o5zYNCTfFEE6R8M54?=
 =?us-ascii?Q?tjGL4PElQGgrZVHzc3owXreKo5+SKRW2rqPUVlEC/EMEyg8wJrEtA+xPfGAv?=
 =?us-ascii?Q?4q6zsTQNWxo109nZtAXJPYiil8w7acYRShiNsHrXHYBfRgRjwLEWUXBOLsck?=
 =?us-ascii?Q?nlwIGXv0/ggxH+E2aCCfKJsKZrfZgAwF+ESL6zuc9m0OrrCTeSIo2gNbEyVx?=
 =?us-ascii?Q?YURRayFUcgFO4nWtOX79BMXMo621MPaDbXGfnW/2JbZH9TWmnaSiSlXJ7n7r?=
 =?us-ascii?Q?9rUzbilCBHD1vehs3GhKY1dal+59thlzD4d9/WYm1eiKgdzBl0rdvg0F1ViF?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mJgiKdoFqQPUUKnr3lzREqyrsSwArlHJqPaKcoztbuANjSntM8T7MDULvaNkH10E2/C3p6lvyOtGQwbWBfmiAYihCCbdtB/yYWevAmmO1wo8bR4bIZsozNNqpk2hLbkPGCDlX9+BBDcJchZvrwAH/H2if34vjou0R6N/pN2oRVGq9EhaiPSxapJoMTJGpi2hSUdB1r6Zff/TmBLw3649o7nllrJUsdw0QwNXk5oJyDmReq69+fUQnWRaXxIzHIRpvO8GN+HnTB44hrad07XV2lMqtToKNN9noHFWN4hK33Mu0No5HVqlrTDPkfnjg/NDFyy64BfjM71RhwR3qweZZ6AOBXl0FKSuaq880LW8XdWwc147avSkB+yqN3Nxz7v0/TQ9OU0u//JOkcgSC9k21/hTURSfSiuNOREbzjKM1/s6StZtRmsGJoopAcDSTzCWALQF9PwXq4BDgDkJCvVyFqkrdCl9pq+22zWnW5gWX16fA5XKwq0V+LoGiktEI89cn7d12uOF99WmpWGxCmehdnf1tJb5UAbSyhU0UIBHcnGacKVfItL1+Q7veafi2vRe98+JIN+6vhFJar5vkhH3p8xw7v1MzHP8qJZIsuMnrH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b1a2fb-3f11-4f0d-a35f-08de22c786aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:15:48.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I35V1XhyzT6gETvwmFH5QoJt34xaTHzkPiHKpr+Vbw3qTmSmoD9JuTURXOC/LYc6knkwdl3DKuFqHZrhh06mKoLDPqMrhD/HrwMS91epL80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX5DFRBZhZuz5y
 aom8Cl5CRAeL83Eb39l+JqcyXI6WgGh5EUovC97Ocvwo94QTb2xfemrLsrqKQCNI8wGuLCAxvnM
 rENIKMi3n+8jZ7tDy0n5TiP22hWumKe3GFveJXQpTkdC/PmRkyIsekJ18y3fqWYJns/gE0RHnWR
 Lyjr/t5ir5b7vowLWZZmBGXNOX0bTcar++JMkXPZTGn6dWWrP1H8U60WAGCFTrw+jBQXXzvSj+O
 glOENkNXL99NdDNtcYfPWCVm1Z+ofSzFyxOWnnn/dZXE2nNnxmsOIbNRBmlA3T03MRMd/MGurFm
 mpYaCBuYHWnV9RrGniFcqjDNZAeUeJUyoDrfLHfd39TbyjGJYRPd+JRCfN+bStUt8eD6C4jM2f9
 geJIQyg4hkmFI6fkRX9gULxF8fPfpkmjfHtO/D03G319zUhLGsk=
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=6915f62c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=hSkVLCK3AAAA:8 a=kil812zkv2J3C1oyZ_YA:9 a=CjuIK1q_8ugA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: gtgaWhmru2E3DTu3ZEIyjgGczd_84POv
X-Proofpoint-GUID: gtgaWhmru2E3DTu3ZEIyjgGczd_84POv

On Wed, Nov 12, 2025 at 11:10:30AM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [251112 10:06]:
> > +cc Paul for hare-brained idea
> >
> > On Tue, Nov 11, 2025 at 04:56:05PM -0500, Liam R. Howlett wrote:
> > > The retry in lock_vma_under_rcu() drops the rcu read lock before
> > > reacquiring the lock and trying again.  This may cause a use-after-free
> > > if the maple node the maple state was using was freed.
> > >
> > > The maple state is protected by the rcu read lock.  When the lock is
> > > dropped, the state cannot be reused as it tracks pointers to objects
> > > that may be freed during the time where the lock was not held.
> > >
> > > Any time the rcu read lock is dropped, the maple state must be
> > > invalidated.  Resetting the address and state to MA_START is the safest
> > > course of action, which will result in the next operation starting from
> > > the top of the tree.
> >
> > Since we all missed it I do wonder if we need some super clear comment
> > saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
> > by doing 'blah'.
> >
> > I think one source of confusion for me with maple tree operations is - what
> > to do if we are in a position where some kind of reset is needed?
> >
> > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> > to me that we ought to set to the address.
> >
> > I guess a mas_reset() would keep mas->index, last where they where which
> > also wouldn't be right would it?
>
> mas->index and mas->last are updated to the values of the entry you
> found.  So if you ran a mas_find(), the operation will continue until
> the limit is hit, or if you did a next/prev the address would be lost.

I guess in _this_ specific case since we're specifically looking for a VMA
at the address encoded in the index we'd be ok?

>
> This is why I say mas_set() is safer, because it will ensure we return
> to the same situation we started from, regardless of the operation.

Right yes.

>
>
> >
> > In which case a mas_reset() is _also_ not a valid operation if invoked
> > after dropping/reacquiring the RCU lock right?
>
> In this case we did a mas_walk(), so a mas_reset() would be fine here.

Right yeah.

>
> >
> > >
> > > Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
> > > lock on failure"), the rcu read lock was dropped and NULL was returned,
> > > so the retry would not have happened.  However, now that the read lock
> > > is dropped regardless of the return, we may use a freed maple tree node
> > > cached in the maple state on retry.
> > >
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on failure")
> > > Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=131f9eb2b5807573275c
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >
> > The reasoning seems sensible & LGTM, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> >
> > > ---
> > >  mm/mmap_lock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > > index 39f341caf32c0..f2532af6208c0 100644
> > > --- a/mm/mmap_lock.c
> > > +++ b/mm/mmap_lock.c
> > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > >  		if (PTR_ERR(vma) == -EAGAIN) {
> > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> > >  			/* The area was replaced with another one */
> > > +			mas_set(&mas, address);
> >
> > I wonder if we could detect that the RCU lock was released (+ reacquired) in
> > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
> >
> > Not sure if that's feasible, maybe Paul can comment? :)
> >
> > I think Vlastimil made a similar kind of comment possibly off-list.
> >
> > Would there be much overhead if we just did this:
> >
> > retry:
> > 	rcu_read_lock();
> > 	mas_set(&mas, address);
> > 	vma = mas_walk(&mas);
> >
> > The retry path will be super rare, and I think the compiler should be smart
> > enough to not assign index, last twice and this would protect us.
>
> This is what existed before the 0b16f8bed19c change, which was
> introduced to try and avoid exactly these issues.
>
> I think there's no real way to avoid the complications of an rcu data
> structure.  We've tried to make the interface as simple as possible, and
> in doing so, have hidden the implementation details of what happens in
> the 'state' - which is where all these troubles arise.
>
> I can add more documentation around the locking and maple state,
> hopefully people will find it useful and not just exist to go out of
> date.

Discussed more in reply to Matthew.

Yeah I agree that we're doing a trade-off here between abstraction and
performance overall.

>
> >
> > Then we could have some function like:
> >
> > mas_walk_from(&mas, address);
> >
> > That did this.
> >
> > Or, since we _literally_ only use mas for this one walk, have a simple
> > function like:
> >
> > 	/**
> > 	 * ...
> > 	 * Performs a single walk of a maple tree to the specified address,
> > 	 * returning a pointer to an entry if found, or NULL if not.
> > 	 * ...
> > 	 */
> > 	static void *mt_walk(struct maple_tree *mt, unsigned long address)
> > 	{
> > 		MA_STATE(mas, mt, address, adderss);
> >
> > 		lockdep_assert_in_rcu_read_lock();
> > 		return mas_walk(&mas);
> > 	}
> >
> > That literally just does the walk as a one-off?
>
>
> You have described mtree_load().  The mas_ interfaces are designed for
> people to handle the locks themselves.  The mtree_ interface handles the
> locking for people.
>
> I don't think we are using the simple interface because we are using the
> rcu read lock for the vma as well.

Yup I don't think we can use this as-is.

What I'm proposing Ig uess would be __mtree_load() or something with the
locking taken out.

I have suggested an alternative approach in reply to Matthew anyway.

>
> If you want to use the simple mtree_load() interface here, I think we'll
> need two rcu_read_lock()/unlock() calls (nesting is supported fwiu).  I
> don't think we want to nest the locks in this call path though.

And we don't want to just unconditionally release RCU read lock after we're
done either so I think that's out.

>
> ...
>
> Thanks,
> Liam

Cheers, Lorenzo

