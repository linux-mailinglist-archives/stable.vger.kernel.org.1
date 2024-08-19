Return-Path: <stable+bounces-69622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA589572BC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FFB284355
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CA184535;
	Mon, 19 Aug 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YgmSz2DS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HYDcDMxD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650911CAAF
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091089; cv=fail; b=ntEKdzj2h2mp3kbwSOpX3KC5+4Dc7/eOPdjJlvfrnMNfkb1UI7u+74GBKqxUJ1QLXFCzaqa3tcDVkbw2HFbo+MjvJxL7nStqyc7uyzsIgYNsQCUmc9RXw6u87xVKjq8EdlQzL4CHDVxjvM5GaeBvZwmnqZKaNxFq3zGJW8ETgLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091089; c=relaxed/simple;
	bh=eGDEXYvXlU5naCSDLFLNIJ/AGuVT9WbgOTqq1tLGgF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WidWZxUiD/zLPyMl5Tmbj4d7gyJToj9dKbPTuQlquSnh1Dy5ZJosHkUT0PP6VvwhjmF5crYHKKqN5v1A8nhRicxMUBdVGkrs+2FBWMbzEo+D2f6DfEr/b8Ky7ig/gvJ4/MyQbTJpmruySfTi0+NtpkaCQY+t9Cp8wwfwMvdKTjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YgmSz2DS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HYDcDMxD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6s86016710;
	Mon, 19 Aug 2024 18:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Bt3XSPEav41ILjV
	tf5I/5goBK9WnX9Bb+6L5RcV0ESA=; b=YgmSz2DSRnz7SNX60jq0R8xY02FXkn5
	Bg9obXgf4SeFU205fI9ocma7FjVLBFjzJf5hYQ+NtZKWKYpbW32D6SsI6/T2PdpI
	UERk+O4GFoM87WLnX5KkuurizNWeYFfHpHPEeKSUOZ9Mco+2/8CCf6WVJj+8mmbN
	IEASXETtmwaJsgMK0HWWUV42dO9A0eDDKWHidtBhgYgKBPxrijRLrjBRu8eqwYnV
	gubEhhjevtSsmdH0aLaDEc/jJBZJ3x9GjrFM/EhAJuL94Du4ug4dkhYJVBPZOWqO
	u3sj+itDMEwCyT8/vq7BOcpl+GBkFDQ6LNSb6NxwKyrfG2825rQixcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsu8pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 18:11:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JI4gQj018999;
	Mon, 19 Aug 2024 18:11:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h42dsgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 18:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxs1GbjnCjZ8nt+Uot6K1BTJfBn9Hmt+Jd84bvo2U1sZF54PgWRskjO7wezzFfh9BtF3iMCTSoCmZu4cQFjrpHgj9tgquewyfXkh44yLuqTn9BAsAKh1BQGPB2Pv0nzsf/1WmGNbOrP/K+BH/RMYfXNKkHi+n0+8WnVzZlrBTIqbbXwONit8ZnjuCawOHVSbjXrA+I72w9Se0rkvFjjbjmjDGr0pgBNUm9lqSkfnBvegWu1fNnZBkLt8CtOAod61ADPJHWspmJnCmPTlE1qy9HxLEIoAcICQkHNarl3v75v5oN5T3oNZ67YG0AxZn3EJ01VyPDtfD6KYjL1TskTzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt3XSPEav41ILjVtf5I/5goBK9WnX9Bb+6L5RcV0ESA=;
 b=kHstTeq2EB1JH65LIgN0PJ1K1pysJtijm978iFm3qiA3jQEh+bmSAH83OEEiVcuR3/KgJXZ6gIxgmJtccbQz2dzvB0xaCt3F1pU+vOhfZD3TmXMBLz84PWPN6guq8JDaD3sFyxF17FQGREUdc+9rHLAfo945lVi7jpCDErAdT6dMTPm+3aZ6++F42UtDhrJXT/XyhornmkedavHa1Y+6o59CjbdhGammEEq/Ve2JDMEeQpgfN4pvVMBuBRP7y6rCHUO2lPwqKt7q3qpxCDid8CVP/TylyILuIjFsQnwqJ7LOJoPWLIw/25yRO3e2hDZ47e7pVN8+8/coZxfm3WfVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt3XSPEav41ILjVtf5I/5goBK9WnX9Bb+6L5RcV0ESA=;
 b=HYDcDMxD4BkcaMxG9mlQpYCPIG4i/gpjXbs6prghtyYdisekNx0KL/A2RcxvVD7Ejwy5m7j3pmR2oEOBZu1oKNBhWuNMiQfWZfEwLO2ESH9AWtYb3NaIOC4TbNtcH6sC46zuLNHqDgd3Q0NqyUkik6J8hbikpnnGp0jyOM+tlcw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 18:11:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 18:11:07 +0000
Date: Mon, 19 Aug 2024 14:11:04 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neilb@suse.de>, Kuniyuki Iwashima <kuni1840@gmail.com>,
        Hughdan Liu <hughliu@amazon.com>
Subject: Re: [PATCH 5.10.y] nfsd: Don't call freezable_schedule_timeout()
 after each successful page allocation in svc_alloc_arg().
Message-ID: <ZsOKuAYNaW0CGqnA@tissot.1015granger.net>
References: <20240819170551.10764-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819170551.10764-1-kuniyu@amazon.com>
X-ClientProxiedBy: CH0PR03CA0410.namprd03.prod.outlook.com
 (2603:10b6:610:11b::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b35be3-fe03-4dca-c01e-08dcc07a4c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W2rO3YM97cbLz233SZK4QMsXijkRyW7QqNZrbxHnwwCZi3bDYIUNhurF8cqQ?=
 =?us-ascii?Q?VxiyeS620hk+wPe1G8Lax0xrF9Gh/g4NIlRRVf9x76FtIiu5TC6S62TgGhOy?=
 =?us-ascii?Q?XLqsa1GhLkxI3PDrkULBG/n5hprzoORxs+8P+q/GObKW06VBgLd5/CjpTvwh?=
 =?us-ascii?Q?HybGoR4+vj2uv3/HV4ofGg6+Qbf+Cy0cK8gVF5Sektv64VMMP6n6FkEG2TBS?=
 =?us-ascii?Q?muxCKKaWxC1Kw0++8lPsPYITVWd34a3PMLC0PGzBk2XFWoO4bZuM0GCzj8KM?=
 =?us-ascii?Q?DIb73zZYOixqiLvS7Aj9Xnf1J4vjNd35klTGiYq4AYx7L2aUrBMBvauxBV3t?=
 =?us-ascii?Q?mflr0FfxM36y+59NqKSyudkDKnz6T1vR53nd+N0kbc1ehVVGYE9q1AFRMdBy?=
 =?us-ascii?Q?KXHNFvQEgBol/zA4wQw+09k5cC6tKCmwEFYYfq71Z+93LFeMKKizdKwRGBRy?=
 =?us-ascii?Q?YAOfuXr4SCxiHxVFBfPFcobd2h+TeJt0iwz9uQXJNb6wOgrQGOMUhTZ3CDbf?=
 =?us-ascii?Q?j3+jeptxIZ7N9V1n+3Lu+GdI1bjVEJfK/ef6KYQI+eXGpKi66GKo9p3awMUb?=
 =?us-ascii?Q?saBMmggpc6hZQB0nnY6in+Zh6aO7JIFubX4gJ40styJ7AVcP8h+/uJ26OTD+?=
 =?us-ascii?Q?tHG98E959iaVoWl+mUoT7QSZH+xkYTe1nTSTBxfZKING0CCBccgSVxll6OeW?=
 =?us-ascii?Q?zkb7ZvMEqwIdiAAowHqREXyszaXsVhJZR6rc9UqmKztf91xcAksXEAPhcdpD?=
 =?us-ascii?Q?wvJLtadwgZFwjzzUJVaJ0Jq4YQtMyE8wabtmyW2XfL9OBLDsRbTDL4YgkMpO?=
 =?us-ascii?Q?TkaaG0mytEMniKuX+pmaKXsj2VQ9np95uA/n5fJOX2N4EzDJGRSx5ZEQu3Ez?=
 =?us-ascii?Q?NEs4XCObUwH4P1B/2UWbUhSAM2hmevDI4rv7G5STeQ/nhDN9fwd1k/Ds5GJ9?=
 =?us-ascii?Q?fMkolkVXyOmVRVdara4FmKqHf0xmCOreQzZQUfOrnZnbntbMrnjRagVhSdeD?=
 =?us-ascii?Q?fNBtn9yywbu1YKNNi98+uIle8+KZfoIv3eeHTktiHB0L/sqgiU3QYTV85FW1?=
 =?us-ascii?Q?RrRedy9bPVvMFMwCl6LQaSJHow+o1+RJIO+MI8Kp/AiRu0BHSj0RwUAU3WaI?=
 =?us-ascii?Q?m1v0b38DctDuwuJ2TNpoF1xApvFLkSimN66/YiV5HW4AkpcHAbSJIj/Wqp06?=
 =?us-ascii?Q?+wSsmikfcsaLGMJD2uTSN8+ZS3QE6otcEvYBCgSnDYW8tDYIPAprw1ZiKMgY?=
 =?us-ascii?Q?c/udIJP991Ffq+lnqF6iCbna4uszjQFeIQLkIxGgRO03kKRqdV1F2AKl8hbz?=
 =?us-ascii?Q?e9MhrBtIX3msUoAnphVd0wzK3gG3iSJ7hR6EF9fyCjpfWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2j7T6Qq5qqEooU4aon9gJuwvp9U7x0FGdp7rg9nRAJHKsBMbdsYLfdbSlwwE?=
 =?us-ascii?Q?z0T53DJAkJ/jo5qBCt6a55L+rSMfMWIKFRM+0e4VACuZbQyrJjc5gyOr0F26?=
 =?us-ascii?Q?aZ7iA1yLiZgzNbnf+98eflYquBhhUQfLaD9S4wYghOdQTKsyMBMfi6Cnxg0Z?=
 =?us-ascii?Q?bIuxkqS5RsXPPPRtey7bHVt4x5kN1K4S8NwS2ibCwXHX4OsfJTiWnPFmfgGN?=
 =?us-ascii?Q?e3O3M9WVFW1GGSJeXSj9o6wViSHOnacLSnkWVdGDT+AE8y/Gp2Wb0YJS0PoX?=
 =?us-ascii?Q?74wTqYYHc4d7cDyyUqxjTxJfvPvnPsojAV7GiQhAhgdEULhE1hmRt+xIeHKH?=
 =?us-ascii?Q?qHVMS9/r0fl36pc3zgWSf3Om/QZoi9FDDoQM/hDx5dQNKLCR8ST10dcCis++?=
 =?us-ascii?Q?FUHSmfJpwu5wEqGTyDTaKEHbsRjt/jcTkuZrW3T27lzbRh6NvDBqf6losDZN?=
 =?us-ascii?Q?57WrzFcUJK03+xqFpb5qhNTlYhMKsIbk2gzT1VpYLn8bi7VyG0enxcOGC6A6?=
 =?us-ascii?Q?ha5i5wbPX/CENIFgG5WaDguoSzF20QOKfDDLK27srwmhHZyFqY79KxteFKpP?=
 =?us-ascii?Q?Z/wIAM/PHPgMBBL9obO/lHfPUizzrkBkla3e0q/kQvL3UGFkW2I14w1xAAsT?=
 =?us-ascii?Q?f34see2wc6aaz5M2Z/K1nV80MVw6HJU8a/QhMViesHX4JHRLNpdIKwzUBKHP?=
 =?us-ascii?Q?JpzBlnM9H4MXn6hzQgp/Ih0VedLqVrLMEfeeheUIXz6bEHkrMkYmeCtF6bLy?=
 =?us-ascii?Q?P4isb4js93cm53CQPGyx4cUL8xFc4l9VxIKLqZZA5Ig+RGIYSFz0YGgXh89U?=
 =?us-ascii?Q?Qwt9KthcHbUvU3TGyutNBCmqEyOWToJygAzuL66WHxt/F77y+mODyausq4ao?=
 =?us-ascii?Q?sip6lBesLiuOETGeBmkS5alr9WZSydi2qXyEKITMRk4yfiPYiOyQiyiy7K0u?=
 =?us-ascii?Q?FFDNN5aCO/pKVJTBYp2+vu9BAWkGpjp4jBpP/1Qi3JbPhn2EiNcyzihBEu/x?=
 =?us-ascii?Q?HQt9awohKtEFqMy2WeVS6eIovdRDL5Kr/iqWMuo/H3W91UiAcBRGV7vebz9X?=
 =?us-ascii?Q?YiTkrLbCyLjABBv9NfYcfklsNr0A7nhXOMjqLdbggdARC/uwQcg9NlKfQRBU?=
 =?us-ascii?Q?/5F57tB9LG16Pkn7U1vAX60L60JBy4/fmzNZlAMsrp7z442Vi35jhk6t1WH2?=
 =?us-ascii?Q?OCIQWFV61zOrnH5cy6PBrjogPyb+gX5R+2oAcOFJ/zoL1J63RGEqVxzGLIgm?=
 =?us-ascii?Q?FedZcVu9q0iTIqqUc1+TwPQN9mlHKHxrhVbVdR2t+qbXlXZuvsik8ObGNfOn?=
 =?us-ascii?Q?8Cqee8CwmWBTaU/BUcChNmybAolZw65sPM1oDoQWa2EtyfkLJUGxu4Uw//ze?=
 =?us-ascii?Q?ebB+/Jsy5QkH+GxgTqFAv16Ui6iXrkVUrAiNNmdShn5aFiG8h/+5iHsXBlqv?=
 =?us-ascii?Q?wHYZV75+f/7Mlbz4UBT4r33puesmnzatztaF/5NbsWNt3qm9Vyc35yxZnliI?=
 =?us-ascii?Q?PzHMvc+t9RNADnuuF7pyFCObW+qefi1/hBdLxDvZk/Pg5r93Mh3w+ZgQ780x?=
 =?us-ascii?Q?4CiU6nTXfoe/px8CyZqtzJPk0LAccOMkxCKpcjT2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	psoPstmUjuiwJmqsoofyLISxCO9ODTQuZ0mNwx3dh6b+0dwSEwrLukqE5d66d/6u5+Z7424ajrsC93q+OVdh4A489VckuIvbkKZaR2eJ834B1hEXtcajhh7d+W2ralkjHHYSNCFU0btp28AyxQehyH59vL4weCQIYdIIzh4Y+IrM4dsxZZd0iIjoPBNJ8b9R49JZ63/PSgxQGKQHqp23JshFPwxgbnuOyhvtuba0ZSex1nrMMzTk8pdRJ2AKXMjgB9N/s7Dw538aENE7ByGrnQ+KwJe954KGznMtFWOewZOoPTXevoFtowszxPWfCXUAGo2KmrcJ1avIg7E4hIHWBuSgvV6VPavpViIkDmEV/K552QvfNO0bDnGjHXmHMb2Kzqv8BpNQe8qkTYunHpP9/6iCT4nw5bmbZksyk9gYaRez2N9o2PvGpVrVitUJNDtfW0DG6fcwFR3igs1W+vySioaW7yH4pNRoF33r4JIgda6Oa+JEL5wA9qBgeDPDQh6bSI8FDGvGIkx2XQPwggBY6PUClEKp6gvm+FPmn6aXrJhTIJKpOcbmghnqvzlLjsYMASt1hZob6k7joya9QWDI8ExHQAWuijWWB9y/vCSC3yU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b35be3-fe03-4dca-c01e-08dcc07a4c1d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:11:07.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY2fAogH50qsgFrMWvOtN7wkXlw+ZO7bafO23jRO5/RK2qBlv4ejlDeVMwnT1CRlbEhT85HqqtqWbzdj9E/Sng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190122
X-Proofpoint-ORIG-GUID: vPWdHBI8ECPeIIn6aXjioAxooAM1J6sm
X-Proofpoint-GUID: vPWdHBI8ECPeIIn6aXjioAxooAM1J6sm

On Mon, Aug 19, 2024 at 10:05:51AM -0700, Kuniyuki Iwashima wrote:
> When commit 390390240145 ("nfsd: don't allow nfsd threads to be
> signalled.") is backported to 5.10, it was adjusted considering commit
> 3feac2b55293 ("sunrpc: exclude from freezer when waiting for requests:").
> 
> However, 3feac2b55293 is based on commit f6e70aab9dfe ("SUNRPC: refresh
> rq_pages using a bulk page allocator"), which converted page-by-page
> allocation to a batch allocation, so schedule_timeout() is placed
> un-nested.
> 
> As a result, the backported commit 7229200f6866 ("nfsd: don't allow nfsd
> threads to be signalled.") placed freezable_schedule_timeout() in the wrong
> place.
> 
> Now, freezable_schedule_timeout() is called after every successful page
> allocation, and we see 30%+ performance regression on 5.10.220 in our
> test suite.
> 
> Let's move it to the correct place so that freezable_schedule_timeout()
> is called only when page allocation fails.
> 
> Fixes: 7229200f6866 ("nfsd: don't allow nfsd threads to be signalled.")
> Reported-by: Hughdan Liu <hughliu@amazon.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/sunrpc/svc_xprt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index d1eacf3358b8..60782504ad3e 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -679,8 +679,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  					set_current_state(TASK_RUNNING);
>  					return -EINTR;
>  				}
> +				freezable_schedule_timeout(msecs_to_jiffies(500));
>  			}
> -			freezable_schedule_timeout(msecs_to_jiffies(500));
>  			rqstp->rq_pages[i] = p;
>  		}
>  	rqstp->rq_page_end = &rqstp->rq_pages[i];
> -- 
> 2.30.2
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

