Return-Path: <stable+bounces-93595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA29CF52C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CEB349FB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6B1E202D;
	Fri, 15 Nov 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WYPBAbDm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VBacvB8c"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD81891AA;
	Fri, 15 Nov 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699490; cv=fail; b=ApvP9sqHE1DtBiYKapcj60Z/zILsXiY93tIZrw6Hk3TiqyJQr6Zs4HPwS1s22aJqpGbDsdSrHnofyrEsj0tsKox8fvUiSD4/Lx1f9POWRikGkXOe1fEFLPlqU+bqP9UvL1QRVcW83+SGpAx1pvu1eL2Iqp9V+FwDyKEtHDZtTnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699490; c=relaxed/simple;
	bh=hjsAuuhDGvdwyTTKoAHze92B7dJDLu97Cbk5QHVWt30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KkVZXmE22tQs7jdpWrWa+0UcJEk1gnp/q4g3nIlBkx03kHMWoBFMZs1awvxWJmTFnvq/keiwet0zLJb/te+AiTfj9WZDX35HkfqFraCkNAujiF+1VgRrz6nyBWs2f5fsZYK382c94nPg/ME6i8Kubwtiw+0Jqr4D0w9fa3fyStY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WYPBAbDm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VBacvB8c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMmQ4005875;
	Fri, 15 Nov 2024 19:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+ksVV3BHUwV79puu6m
	WVIW1KOq/9oWPRJI+4b2aMOZA=; b=WYPBAbDmMDxe+4ErrmroP8FYmyNA5SDkpk
	5KtxANGpgMO5rDX24E1PB3uC1KLtwktneT1aZaVGGyzZPGXTIIDj9csy4eDMDdEu
	ajXwvGHF7Kd2xhEBzCRdDycC03sksnAtjZjr57CpErBYszshCZuotmiOHVHxDW3I
	yYLBHQ9Cjcr7ltltgYGaUmOqA4Q2Ok0EMgc6ZGYFWcL8BF4aT4b5XzSdqkxKctpf
	hPSf2y0NsGOznWhOTSyCh8pTr4glww3nT+cxqKlVSPulkaWQiLnQL4axiviFFbW+
	Ji5IULShRRvKfiIOh5VFE1qxVoaTkbg2jZJF+vLyADigsCIshlgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heuyes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 19:37:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFIttlr023918;
	Fri, 15 Nov 2024 19:37:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw33f7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 19:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oROnGh3Wwd3BzEYnz8WpZsv63lAr0CR/vyg73m1wlH5IiT1lvuVjssAnKeovBx87TdDyzNhvWoPinH8IRXgjiFAiPWMF1B0ozs56sfsmr0cqZU1Bfh/5+xzuFN9XNdIkCiuY/gFT4VyRY0GYTxAa8gFYUO5GBgBZgNFTGUuaTHdRZqqbRTwOSx3gWe5OpjwRnxzTWimgcpHhqbuYblNj2Fozj0aMqKOTVxASeqi3yWskCHZBgvHUhnSfVUkLwCXR72+YTmBUOwBW6tIyh1QVRdOKKJ7nn5/40hG3im/aWB1PBUJoKBJp5CIqUYiJbgwdDgAx8efhba+Ml3K3r5CRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ksVV3BHUwV79puu6mWVIW1KOq/9oWPRJI+4b2aMOZA=;
 b=KLcQ6URzdxIk2G/kFHTw18/8r4ZTT9vl/uLi22fk6us/Hu+fGq0KuvtT5zve6FJEPmv3wSwNZOCs1vW5PaQ4ox38c8XSjFzE//EIf4XnL0hI49n4FTx/V+C8nE/+uF2tef03nzMr0hgUQNzQ2owtoHNAgpR9TjKb9Hn/ZEQOCu42/axr1q8hIOGZjZ03/8pn1mbEp3CjAeCxFSADFzG/i8vsIg52EsLj6MPTaO4ePCrOEPyjIT5Iiwzx0LayxGf/jxNgXHXoKjgOeyB9WUSAWY7wVZcn4XMcfyWUMnen7AX5hbICY4mw/6o1Lkd4O1rE7vKeChFVe0WqCVVJk4xhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ksVV3BHUwV79puu6mWVIW1KOq/9oWPRJI+4b2aMOZA=;
 b=VBacvB8cS0LEMZCfMfOT7fdOpS5aTwPRKAQftN7pKMbMyMcvnhHuZTXW4wzb33PviF7bvaSHc0MO10XNFIKm1KSFFr90YH00B4Mrd3WRzWVNhKKAHoZ7rJsiXKE7J3Uf0cTgq8DxWKEwxkQbammDowW6Q3gdPMMXoHPYtu4niT4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CYXPR10MB7899.namprd10.prod.outlook.com (2603:10b6:930:df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 19:37:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:37:43 +0000
Date: Fri, 15 Nov 2024 14:37:39 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.1.y 4/4] mm: resolve faulty mmap_region() error path
 behaviour
Message-ID: <mbje4rgn6vnltg4g4brhlkesiqzlbninomzktx4v7enfsbofrz@2uf5ryi7y552>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
 <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
 <2979df31-ce8c-4382-ab01-7e66f852099d@suse.cz>
 <01fbc3f2-bccb-4694-99ec-2ee8e9ff6e4e@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fbc3f2-bccb-4694-99ec-2ee8e9ff6e4e@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CYXPR10MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 991d5312-3860-4119-efae-08dd05acf932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XvzHtydpMXtnmt3KZN4hTtzKtqLk8AxzAvJh8s0eRTwpMS4GWKK+7RfYRvEy?=
 =?us-ascii?Q?UdwH11hMoQrDN3C1uvnlHSCAxG2XZFV5aRSTmIHJuELd1l/MeRFytkNcRxuQ?=
 =?us-ascii?Q?+sjSN7achsSnJU/f9BSZmLKd9rTrmi6lpj/SxRMYGSlSPM6UVHtmXi54LOgg?=
 =?us-ascii?Q?ziufCo4kAcwM0t6b1FkNUmsbR/dgjDUi4wMflHYqWmLv3hY0j9w6MvnND8za?=
 =?us-ascii?Q?ffO64CiPlnFdkk5ByHMUcMymaACpP3Cdi5H/QF4Z8rJcgYKkwgOdz0AqxsMF?=
 =?us-ascii?Q?7RnK1WxrzUYngEjlco3TEooIV+3Pct1Tid9rGM7FRQx/mOkoPXS5vaJ+aJY0?=
 =?us-ascii?Q?oUJvBjXP+HUg0UlBNV4LGiB4L4JvhhJ6U+hJAJ+Pg/skvwiFJaL/hDERO1ZE?=
 =?us-ascii?Q?iHNBogaJAjLG5WwT01Fjd6du/g8XZl/fqAYK6wPOxyoIsjhx5g4JWpgoS8hA?=
 =?us-ascii?Q?CTSuDmNNQS+KhnlUO5pmtxDFl4oeiniuiJ8HHeF/gHiohoNBe4ohKiQE45g1?=
 =?us-ascii?Q?/mrsuF9i2b1hXIzjvVu7VFrtsRUcv2OhLLEnCOtCX0W8xvuCk34oEguqCUGx?=
 =?us-ascii?Q?wn4ZHJLrdflOqMVuwvycQt5c90yiJ2i3twtKpDfCiau1zLZv8tQXTIWG3uai?=
 =?us-ascii?Q?PMK6kl8pIwPaqBoyBnl7IcbEHzaKw3/KhkR5sXOQlLiXK7dNGkRRR5Bwu92W?=
 =?us-ascii?Q?RHYpl09RimF1/nIPb3caMnu8dRdFsviXB0zvavj56JdbGydkErlriYdwHMuA?=
 =?us-ascii?Q?NOJEuZPX8wr/ycqNX+u1qLW4n5Fte+aJDxGxl7zo7uWUyQHfRrqkKoN0T9fc?=
 =?us-ascii?Q?Zgp46p0JyZTRqVnBGw/o8qfCx2zoI9SDuuxmLbNspFN+K9zDJH+zzpEWrMQm?=
 =?us-ascii?Q?N3+u1OXlEfZ8aa+Lm8wjZo6GCv8DHmh+yM5bQSGzIPGnco6yZ7VdfQe+pJX5?=
 =?us-ascii?Q?gJl8IWYCo+UWWQ8gmBxKYETxM6KEvJzyoVmn4flwwALPaaxvNLi2OGqdmyiE?=
 =?us-ascii?Q?ynMw8HVeNHKsBtz+pt52TlrAOdHsDQ0c2RF3ezLZOynaa6JC0qtE5ragTJDm?=
 =?us-ascii?Q?EgaPh+ihrNPJH51JmeSD0/WDU4/z7a9IptBBb0mclvcOlzYYfITZ6QGV0Ard?=
 =?us-ascii?Q?BBay1kqs3s2+0F/8ryp3q9ZkUOKuOXQu4l0TvxeWw6txwct80FszThdVVx9T?=
 =?us-ascii?Q?whrdjMAbQVoF3391kinM03hh/c3P5MKeL0sDScEuhTGTauz3rkEjFmM/p7qL?=
 =?us-ascii?Q?VZe/oGs2a5xbtVRpCkKyxul1aFUFlPMtWeotThbEA7TNiuOBCXgYL7L86FOt?=
 =?us-ascii?Q?StA0grKhuqJgDk/fYSj+Nlaw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpzfK22fEsO4tJ3DWS3lPuEhF15yNNTyvGtvJ8ij/s6YK0G7GvtqygY3C240?=
 =?us-ascii?Q?tAACDUMGigdJnLsMGgE7IapGedRZ//tp5Yk5Lw3O/kt/disDvHanvhjkwKeJ?=
 =?us-ascii?Q?ivoREFYdzG8TLnoCJBlGo+M6DHbiiHfkDz6Cjf1doVqphAAhZjhkWro+VOQW?=
 =?us-ascii?Q?sWj1svZEetNeJ7Q3yq164gpJQii2pVPClrwyKE9ae0fUU3MLDUdd5LH09IJp?=
 =?us-ascii?Q?WlDh4lP0KuW/bs20HlWJRai73DDDI5UYqVTj2PQZ59w7Yk/zFlN9uYXpw/fj?=
 =?us-ascii?Q?ow+pYzIGyH1uue4nmFZsZ+mnL9gt6O3CvBmmzsKs5tASMNPwh379dQYZgJG3?=
 =?us-ascii?Q?5JcJTMIgBLErVO+4tCjezBr7QPhmmy/qWRBI6/C2G/hvO9TSjhlq0NjS1+RN?=
 =?us-ascii?Q?uWuwdIgByQRARokgJz9ISR9sdlnpLQC1nqxSJFSXQSan0TAjV9bdxCfdobDg?=
 =?us-ascii?Q?IfdMXzNNijOAnlewee+wWRk+e1Dzq4OSfByYXoyinoupwhA9Xyz+PsySSVI+?=
 =?us-ascii?Q?3k+LuDcxfz/ih4Sh/IrQmIYcjeaGd73nRTEzLHLKAGQy+NdA0kRtBP7gsYp3?=
 =?us-ascii?Q?8uKmbjxOTS5ElZAD1Vgvrmk0e5ma9hyIG4A7O1yxEc/VvgPrXfyoeiEL2yy6?=
 =?us-ascii?Q?GEMDDI/UOOKQwGPn/Izs7mhGUtxJ4SWnLD+kpM13HAVJyrRK1k2XTP+ea0en?=
 =?us-ascii?Q?0RuS9qeCAcxJ0eP5S646c1gZZaDt7+W+xYvfeeqQolNK945NwNyePHWYYqg3?=
 =?us-ascii?Q?z8/OVnSSUYw30l/XPJH8H1TpfkbZRSW9hMCBrSsnP4WCZ3Juo8xuf+WE4KkZ?=
 =?us-ascii?Q?hk/f2me4/2j9dHSBTIXLgJ8+FpNFKH5p6mU2Z2oIoBFI4jxeu2jEEYJ3zOie?=
 =?us-ascii?Q?nZwcFU76P0d+agKQmpmiRVKAyhyeq9JjhCslzqyOO4i40324jC/G5/Z9y+WD?=
 =?us-ascii?Q?Qw1ZepA968vUO+RlhZgk3JmkNNrmBWvIOiJyMNgiaV2XFhofLZdviIHUJKxu?=
 =?us-ascii?Q?rehHrDZaQSZ78WqIfAEifHqpshTNfXj62J2CInhh+S5zPAQX7fQXmS7biEf2?=
 =?us-ascii?Q?9ejjbDqFVDIDeDXe1pHRG3+WmTHGRYFyooGHwbKeOGwDHyaRtgm2j8MxqNqv?=
 =?us-ascii?Q?e7Sx0Ajr03nfoG7ZGSIw1g3+jNvKfM/LbC4xjlSxHwwMtO9fGb3N/+xSR7FB?=
 =?us-ascii?Q?JTdeLI0XbFIhaGzQviukba2Wr3N2U4TMQIyUvg6vI1f2hZUK2r7qVdC/sLE4?=
 =?us-ascii?Q?zCe8MGYRBAJp4KS9bJAfh63ICT0/j9zgzmisC63Mqcv0kYBskIvsdo43Pcv8?=
 =?us-ascii?Q?R97m9SJXl6n+4O+Eaq46e3V/990K9I+Mtth6y025tWVYLjTpRfurk6V6D+KG?=
 =?us-ascii?Q?m60NsmUHM7eR6CgcQuZ53FhG4PgmHrX609Ru+zN13pOs026v7J8bSBsEietB?=
 =?us-ascii?Q?mTKvsKZ8g6/hBWKaaeDnxVdGb+0bKiT1brBHLaxb69bkWIa+E8PYMp8UDTOb?=
 =?us-ascii?Q?Sav22i4rOOVcR2Yp6MwJROquzIcqRaYKUI0gjv3UPLKkdfBJh92sEeuJ82pL?=
 =?us-ascii?Q?gslSfNQaN9WPnfMYQw4GO3iEwDmJ64z4m1YHXLCF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yj4RgIg/jfqN4pxmuIW1BUYnGU9GPcHCVLqs8B5MxQcF6fUM8h/zV7Ah2CkL0j9vy1xrh+dA3Hp4HD0fJSDLrnBSAgh8pkIuR8uK67csf7czPdhR17NW4ajVaNHKa1zqSP18a+fJl+TFDRo2GIzX76dw0qtY56sZFC9oabm92zjAiOEH9mvNBK9DQYZ3FOxdz9iYnLAa5oMLxb40a6WG51dBLj0p8Tt5XIHzS3WBspbuZbHve8eyGG1CvR7fMsenxHTQvbboZ66lwlmXI74wxK0Vjfnz2hvJDRhO0ULwCMo9XTaTHsOTmI4wnzlLGpPu0TtA820wxqdC+DmIFKdNgdbWJlpKxv+Q2MjVbC6JjnYUUugDdF/waUYEQNieUnCQ6S7FGediYl3NEotaBK4I7yRKvpZOSKnPzMe134a23Q2j+mt8ZDDHdDQoEtXQx2J0X9+UFtWC+IuVmjqW1rjKqiJPQMDJghu9FnrpvepdtdQVLnpFJo1aIqOQ2+gyfTiM8/i3AAFubYAgik9Fqlj25bpAYBzRQuGWv0verVcNXFWt4uDVlCIBpPtZpbFxfh6L3L7qnm6myTa7fmCMHS4e2sklvglJLhzRgDSlDHlhehk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991d5312-3860-4119-efae-08dd05acf932
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:37:43.2262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHg3RzFqNWpviYeDz7g9GjDJWvyAlUpPiaacSkyu2xhZN147XhCm6rm8dLTmmqlHV20AhM40RPDPeas5XDnlKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_06,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150164
X-Proofpoint-ORIG-GUID: w-GHXoCc_SkDdbsZAjQmx63u6uXwGmG0
X-Proofpoint-GUID: w-GHXoCc_SkDdbsZAjQmx63u6uXwGmG0

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241115 14:28]:
> On Fri, Nov 15, 2024 at 08:06:05PM +0100, Vlastimil Babka wrote:
> > On 11/15/24 13:40, Lorenzo Stoakes wrote:
> > > [ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]
> > >
> > > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > > control flow and numerous means by which issues can arise and incomplete
> > > state, memory leaks and other unpleasantness can occur.
> > >
> > > A large amount of the complexity arises from trying to handle errors late
> > > in the process of mapping a VMA, which forms the basis of recently
> > > observed issues with resource leaks and observable inconsistent state.
> > >
> > > Taking advantage of previous patches in this series we move a number of
> > > checks earlier in the code, simplifying things by moving the core of the
> > > logic into a static internal function __mmap_region().
> > >
> > > Doing this allows us to perform a number of checks up front before we do
> > > any real work, and allows us to unwind the writable unmap check
> > > unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> > > validation unconditionally also.
> > >
> > > We move a number of things here:
> > >
> > > 1. We preallocate memory for the iterator before we call the file-backed
> > >    memory hook, allowing us to exit early and avoid having to perform
> > >    complicated and error-prone close/free logic. We carefully free
> > >    iterator state on both success and error paths.
> > >
> > > 2. The enclosing mmap_region() function handles the mapping_map_writable()
> > >    logic early. Previously the logic had the mapping_map_writable() at the
> > >    point of mapping a newly allocated file-backed VMA, and a matching
> > >    mapping_unmap_writable() on success and error paths.
> > >
> > >    We now do this unconditionally if this is a file-backed, shared writable
> > >    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
> > >    doing so does not invalidate the seal check we just performed, and we in
> > >    any case always decrement the counter in the wrapper.
> > >
> > >    We perform a debug assert to ensure a driver does not attempt to do the
> > >    opposite.
> > >
> > > 3. We also move arch_validate_flags() up into the mmap_region()
> > >    function. This is only relevant on arm64 and sparc64, and the check is
> > >    only meaningful for SPARC with ADI enabled. We explicitly add a warning
> > >    for this arch if a driver invalidates this check, though the code ought
> > >    eventually to be fixed to eliminate the need for this.
> > >
> > > With all of these measures in place, we no longer need to explicitly close
> > > the VMA on error paths, as we place all checks which might fail prior to a
> > > call to any driver mmap hook.
> > >
> > > This eliminates an entire class of errors, makes the code easier to reason
> > > about and more robust.
> > >
> > > Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
> > > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > Tested-by: Mark Brown <broonie@kernel.org>
> > > Cc: Andreas Larsson <andreas@gaisler.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Cc: Helge Deller <deller@gmx.de>
> > > Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap.c | 103 +++++++++++++++++++++++++++++-------------------------
> > >  1 file changed, 56 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 322677f61d30..e457169c5cce 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> > >  	return do_mas_munmap(&mas, mm, start, len, uf, false);
> > >  }
> > >
> > > -unsigned long mmap_region(struct file *file, unsigned long addr,
> > > +static unsigned long __mmap_region(struct file *file, unsigned long addr,
> > >  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > >  		struct list_head *uf)
> > >  {
> > > @@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > >  	vma->vm_pgoff = pgoff;
> > >
> > > -	if (file) {
> > > -		if (vm_flags & VM_SHARED) {
> > > -			error = mapping_map_writable(file->f_mapping);
> > > -			if (error)
> > > -				goto free_vma;
> > > -		}
> > > +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> > > +		error = -ENOMEM;
> > > +		goto free_vma;
> > > +	}
> > >
> > > +	if (file) {
> > >  		vma->vm_file = get_file(file);
> > >  		error = mmap_file(file, vma);
> > >  		if (error)
> > > -			goto unmap_and_free_vma;
> > > +			goto unmap_and_free_file_vma;
> > > +
> > > +		/* Drivers cannot alter the address of the VMA. */
> > > +		WARN_ON_ONCE(addr != vma->vm_start);
> > >
> > >  		/*
> > > -		 * Expansion is handled above, merging is handled below.
> > > -		 * Drivers should not alter the address of the VMA.
> > > +		 * Drivers should not permit writability when previously it was
> > > +		 * disallowed.
> > >  		 */
> > > -		if (WARN_ON((addr != vma->vm_start))) {
> > > -			error = -EINVAL;
> > > -			goto close_and_free_vma;
> > > -		}
> > > +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > > +				!(vm_flags & VM_MAYWRITE) &&
> > > +				(vma->vm_flags & VM_MAYWRITE));
> > > +
> > >  		mas_reset(&mas);
> > >
> > >  		/*
> > > @@ -2792,7 +2794,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  				vma = merge;
> > >  				/* Update vm_flags to pick up the change. */
> > >  				vm_flags = vma->vm_flags;
> 
> As far as I can tell we should add:
> 
> +				mas_destroy(&mas);

Yes, this will fix it.

> 
> > > -				goto unmap_writable;
> > > +				goto file_expanded;
> >
> > I think we might need a mas_destroy() somewhere around here otherwise we
> > leak the prealloc? In later versions the merge operation takes our vma
> > iterator so it handles that if merge succeeds, but here we have to cleanup
> > our mas ourselves?
> >
> 
> Sigh, yup. This code path is SO HORRIBLE. I think simply a
> mas_destroy(&mas) here would suffice (see above).

Yes, clean up your own mas.

Besides this change, the patch looks good.

Thanks,
Liam

