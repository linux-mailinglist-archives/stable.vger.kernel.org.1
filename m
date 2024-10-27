Return-Path: <stable+bounces-88232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DB9B1DD5
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 14:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E5281AFB
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327AF15383B;
	Sun, 27 Oct 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FQetdzGA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WNe6GXoi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3C817
	for <stable@vger.kernel.org>; Sun, 27 Oct 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730035984; cv=fail; b=OBOD5SOwps8hhIGD+j9DOaDuAwnQV1YyHDNcqEp3LNXFDhFD3KrjmrM7kKR0RVMIDgl8Xvx83+YzOxIBMCjfDf6G2LHw/Un5FSdgica6WDha0mhUuNukW/Rb2b8Hwo0f+KGzHO+PBZiB9x8QkpmcmfGAwsHYvbu6WHEIavBosgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730035984; c=relaxed/simple;
	bh=zQPFmEBrRZ+fwBaRDarVx4nKEi+e83SFsWJce7LGeg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nt8EszVyzrCLmCgJT80JNIfW0DkoQrgu0v1dRbYoRkBBYf/N5KMTpxp2SnD/HwuWmWGrrDZWAOFNTzYNb1ITB89+C4Nc9Vr+wg5mS1aTQMqsdXMxDeOek/jVktCQs2mBFbSl7gG5q+isLFfTLE9gjEs4Csbg8ZgiVQGLz4NcgpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FQetdzGA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WNe6GXoi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R5VxL8004592;
	Sun, 27 Oct 2024 13:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6HHTDB0whu26ET6JoE
	jY8pFi/Bfy0h3XQMHYwiqI3jQ=; b=FQetdzGALkuJcY3RwkhF0+8Nb+kIlJfBDG
	oSOoytNJLfSnq0XF35uHM5SGwx6/AgDGN9dFCyT4SCdjJ1liioXaqV9UKZ1FMG+v
	lSw296yf1Sx2E+cFG/efRwrfCd9jG2Dz4bjdeM7+9u5rWfoH8STc18oFF/HDoFlO
	XaK5Lm5s3NeCr1+FTS837ZxU2djuh5gpgr2yi3SNmDJnuK84h0ILIKTw6t7H59wt
	FV+CcxrZPoRWSI+4I4quCgcwkLERd6sfbgHGp3CtqcTcFnw0qSHX4yEcVT23LcWm
	XRi5QvI+YFjl/aCxs5oczR0atgp0NA7WQhQOBDD5MphuI7Mw2XOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys1amq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 13:32:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49RCBgNx012006;
	Sun, 27 Oct 2024 13:32:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hna9s43k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 13:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+lqBRLOhJdLKPVkgHC4f00IZ61VeighvIwD08UAufVdBBEUq8ogxsazWaWUVhd2KB5FVNLCSfQnRKW9EUW8HeVWRnGpFiJZSFu5JLTxie3vG8+xwMrKfvoWmaJK92svXXFg0HHIsWp+LxfFObdvfPChO4zRbwdzNnhdSBbABdHCUxYaduHDpFz8qqnT/LL8iOs+V4arGcRiAagkkzGh9GsOQTG8OEAfZoFZnVzNjFyW/rJDvg+kr1JYV5zINzr/T5rzWx8abiwSavawxL0VWR5F38BXgBzl0MhO/VpdrbBIAUn+gQEcjErslv3pxY4Ar6FXSgnEpJJhwuOs2z3hcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HHTDB0whu26ET6JoEjY8pFi/Bfy0h3XQMHYwiqI3jQ=;
 b=DZV2AkcfjkZ5cNQ+eox3hhp0a6f9d+7YUPAmIGIj+94XrfypuJj19zsTyUilmmoXQEDDQVzW0eE97GWSUu/jSDXuqieAfiUfTwSE/N8U0+GSYLOhjB9FX2n+I6JDAubnmt9WZ30bV+kHEkdk6AzMw7h6mo46QHBG7LYhWQmriHrtpaq6LtR/HMBrHbffXDI+jqZ0pfy90bc9bplDKIzpnxe+pBx512F9nsBsouczHq1tcmCUIKhs+0DD5b/Qq8giXi9GCedDYn6NuSjJPHRM5nXQamiC4YLf+dI4FeD1ztKu/myXOo5Y1aSkAqlVmbZDz3uIJCh8KO8+X7sniXIlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HHTDB0whu26ET6JoEjY8pFi/Bfy0h3XQMHYwiqI3jQ=;
 b=WNe6GXoiKz7u1huiV/n2gpO4qd3HP9PHIvywBmueTVHZVWyksYqkwAZ9kIn1dYHYOIV7w//7YVWJVGRaYNXTpp5/6vrscQLLy9buCjzRNFWpGv8Gk6VZKtQap1pd2y/vbuORdnHSQin1bkTn/45VfoyTSeqkgRkNKusxKLeig1k=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7903.namprd10.prod.outlook.com (2603:10b6:8:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 13:32:42 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 13:32:42 +0000
Date: Sun, 27 Oct 2024 13:32:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Message-ID: <18aea820-eb17-4695-90fd-5227a719a76b@lucifer.local>
References: <20241027123321.19511-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027123321.19511-1-richard.weiyang@gmail.com>
X-ClientProxiedBy: LO2P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: ccac9a67-81c2-41f5-5c91-08dcf68bd58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GL7hZ/sFU0IPX59QU3+sZHOwH9crgiGH4hRrpKrkaFq0ctgDICtDwWcyEQuR?=
 =?us-ascii?Q?JIt3lkE5yJjZy4A3K2o8qTs6gliXcdlNMl3WBx5mr4/39BEHRgu3C2o3QxOi?=
 =?us-ascii?Q?/K6+fO48R5EOuf8Brd/ZE/ARzPPLw+F+1BH6hmgqdMqQOALM5Xje5QKJL8pL?=
 =?us-ascii?Q?2epwivqaF4IDe7vsob17/b3G2WVUfj9LWv6Ie56LihosrD/vj/zPiFV0nNZo?=
 =?us-ascii?Q?C9MZNwsj8JcKGVlbZ7d6sc+yq6qrVPLkwykTmUajDymCc8ptl8aItUrirCgU?=
 =?us-ascii?Q?gM77a6znaTnJPk9+32jrRt4mmtqrf2ivKkrmes70d0CWMn/+LPKWm1K8kddL?=
 =?us-ascii?Q?CgIgV7KSnmP9U7UjAy3/U6jaxeQ2tw5NjgQwR4S/LMEIg+YnlYZF8T1C6ZH4?=
 =?us-ascii?Q?T7QdaK0BY1nXY8vYcmGTiySgs+80Zzara1jKIYFe2fZ6GcGpjnveaxbznG/E?=
 =?us-ascii?Q?zM20T5ks8mjk6REs4N7BEGVBDEm4IolvkqP4nddfg5W5tuN6Jjn4sJXUeO83?=
 =?us-ascii?Q?DHlKDmpUav6M040tKawhUr0EmBDo6VHUy5ej7/+HsN6OdCMyL5J/3W51AhuU?=
 =?us-ascii?Q?fEZ5/vkh3O9iFcfbROWjsE02wQG4EJlkhTlaGqR6gnOZhm3nUzvrj+XieQ1g?=
 =?us-ascii?Q?hJjvWgFyzrIAeU/jnbaN53mPL9bk/WSHgAebjvCtxD+JsVrMbKO/dRz6j4d9?=
 =?us-ascii?Q?/cdQaUnckBj4YCHFdyXpYdLwLGodQebo+305tnlT1le4JVnlfgi3qGT7UX0t?=
 =?us-ascii?Q?Zzr1tjQCz3SLRvLj/qK9mP8Z2ukcabNPoAYBeTg45rz5qypvdtr3PQCC46Q+?=
 =?us-ascii?Q?Nxiyq0fqUVWdz7tsXzJa1DQs29FlyR6zKAQ7Yw2s+3gPZiT5QPPNwngaLLkB?=
 =?us-ascii?Q?LglisiwTiXpiSvIFCZ1zBsqF0YmCKhVYIqojYzfEqTK1FyVb4QTOCwFvglZw?=
 =?us-ascii?Q?/hzqqyEb3RZFaa7Ofau+Q6YTGMmGO14DMBwidMhhm+Hmjg1+JphVNiOlrMHB?=
 =?us-ascii?Q?K1wYP+oasN/Ul1TZA2oZ4LdpL0cd0WHWZ0PJGHSUJ6gQPbgm/0aIqZtrqVP0?=
 =?us-ascii?Q?b8Q+LelIVzKrM1wu+0yIXpMfUF3XNUzKNOQ3l5+668cn3OioTSE65f08c5CL?=
 =?us-ascii?Q?1L+ZE38cP3bqYiQ85NNlnNTAcwn/N2EB3Ohru2JrgJplv/mXfc35Z4wR5xKT?=
 =?us-ascii?Q?n+/AEAza6jErq/hdO5vKerWlwi9oV9716eJ2mpPjtftxwsx30IMUs1C2HlPm?=
 =?us-ascii?Q?MKp4GCvr5VvFNorqlwDGreLzw64+qAW8ADtmC+yz6fTCjxPEUBkJalFURKNv?=
 =?us-ascii?Q?T/HfIRE+WYUX0r5IUvZivzw2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZL+0H3ctd3WCtg5Dfv9FyMubkEQUxBIPvBvE1i9IP5niVIDRSZ3gW10kUOi?=
 =?us-ascii?Q?uflOCHRhYY6mNsIuyTa3L36UU+zbf8aXaomJ6wGEpTDRRwCKdZO3BRMenswU?=
 =?us-ascii?Q?SixzBu9ffHirYWwfRroh7BtZHUTQCCdW5htataosRDnX2W+RxaKqrsqFlnbb?=
 =?us-ascii?Q?hU1qU4h9s8ThFGrkJ9AY66bplwRCw0goKHIDeE5xPPJXlRdbWicJxNtsOJCL?=
 =?us-ascii?Q?+Bche4R8nsAkllnek/pbPFKUNIfKEN1cPkei3uaQo7Nlm7YYP7oEJv5pA3wD?=
 =?us-ascii?Q?2OX2EnTiNIX/ug2cuSXwgu+5mKZsOlI/XUQpy1Ww4ksJ3D9x4pO6PJo9+IcY?=
 =?us-ascii?Q?AQo8iThYsB90y415wjoHVJRCAK0ydqmA3kc8d2h0l5x9IMKMNhts8MnBCZSx?=
 =?us-ascii?Q?yvsW0E0Na5LxzKJviDsDWrObnu2mLWV/ZegJa7+g0lHPuW/ZySbmztwASHs/?=
 =?us-ascii?Q?TylbwCzYrP/cSZCrhd1Qu1YtZeMCehhRz1kKoCc+qLdmScn3MNsq4fwWWdkp?=
 =?us-ascii?Q?vCooX0yIEF2xAXrOjYCdMK1M/bPNOKuJmdw8qTjOKUPM1hNBNYJvzWA4OPoV?=
 =?us-ascii?Q?tEykkmRkZhZZQkbxJs9oRgnvqjD6xnbrSaoM3FHqJkmUVmVoWI8IQQ0WCiy1?=
 =?us-ascii?Q?fcqeouBdjzbtUA75TQyDrtXE3ppicHt6lrOLgLgLetYhtMIycOToJqJWYZZj?=
 =?us-ascii?Q?XqCqyT0Z8g8kWG8FLtEBCSVuNgl5oZFkgMZXUWxm0fOG7ZR7aBrukxEe6hTD?=
 =?us-ascii?Q?iDMo88j3w/dRflbNv2UC7TxdhZRmqXGxgYZ/5fIlf/puodiC7EbseiAwb9tK?=
 =?us-ascii?Q?SHGemW08y4aeQQlSudbK0JBZjZOY9vKhkYO1+7wvbfZLbAMAV/DZUyyqmZmF?=
 =?us-ascii?Q?/Vw0IGDkROAuiKVRMlIlSNTIETQJtCu1505BURw/ZpgrQomX8KGuoP89/1jo?=
 =?us-ascii?Q?yUiKR2C/u7tnztZjAq1iIdmalTqOZl+0bTXxxC9wuZqc394FMnSnwn99WcX3?=
 =?us-ascii?Q?2CV5m3Z7xDcVfC7zbA52sx0o8cwIe2R9bkISl17/BgxLOg3bPJx8m5TybE77?=
 =?us-ascii?Q?jC0ZUebERpZ7rgFh7jhC6clXQjjLoUBCOFTewurC4frWJ37q2/v9+a4N6Qyd?=
 =?us-ascii?Q?SZOyj31qktLzL8dOzepG6q9khr+nOfC58pwioGv1FZrHlsfZq+/0mPEdhCoS?=
 =?us-ascii?Q?nknjTunBgqO/tpkl5oMDXanpJCQJdzP8iUVqtGj0RpBPZxPJ5TIltUXfCtoz?=
 =?us-ascii?Q?dP5TkSVBzA1IMgn4j2lcuO/iKLffRXMS4vtU8uaiKT5NW1bJoqCLB36BJ0gB?=
 =?us-ascii?Q?xXxgLY+mHy19Wdb/FVlAQQf/YqJNlJFdKLkTgLGPxVIAWqtMM2BSZjRBlSsR?=
 =?us-ascii?Q?AyxL791IUB/zE26JTxbS9pSE5Iz6adr8Wf8t7JMSTkcBYvoIoop3YNWSJAPq?=
 =?us-ascii?Q?FPxJrs5jqzD+Jz2jtQ3ls/GEqDf1IWKBsbT7GUmBDBxyOswjXX0T6VrfDeTU?=
 =?us-ascii?Q?ytz8YPOspWZ7PXtquEyX0xsYODuC1LQ17nZyqC88TuGyA0faDfCC64eSTGRC?=
 =?us-ascii?Q?OcsndwLctwkbabKnIhu76/GASG3W5qbnmt03c1fEjedMjmQPUxOYGd9Ox+5V?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z6kUYqax1Gbs1GOLflhjhYKD226dB8ro0eWnsWvh2R87tk3pn49r2XTpj8xiW4R6Ec5DnbtuqQJ3H+rM67KMP0z2PKe1odAs66PthLs8+N3TLooMmuSlwVA9BO7BQVdwlYgucK/0fMRNTjBRj/K5mD/Y7XIJU549f4R94ifIVkAES2cVGHOOogtYbLo778ppaYpR159/DLElATcU+ms7D9lOKQ4WB8zeLEEOiic9e2BNgw1PhqIOzjYbueGGPTvD2B/LDpsfi6O4uioeQltpVworxbAHgVf8oN+6AtfRiTG48OZELecsgDV6cXkzgwo8XqKj+6j1kmctQSNLNvhqPm5VnUKYLgDdPlq2TZbu6c2SlGD9MmroLFHMqqtYVaqdS9BwK96tZNHs0N+mBmMUcMUfEOV8uNTD8C9n0mlHp5GspYBqYn1JBf83rCFOvu7+NYu3XS08WBHwL9s96YGGeUjdQiVf/PsZkA8M98zCQXnJYaRd2PM3s6XOGrgzRhUHgizg8GsnGgTlWEHymMWV72CgssqWJ7vRXxlySDEoZymkt/uMz7SbuBNRAZ+YqASDmQf1Lg8/cYW23madwAf0FAPwckwfWlVGSBojkTfvMVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccac9a67-81c2-41f5-5c91-08dcf68bd58c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 13:32:42.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/+bGVDC6pRcNOmfhGfzKUs1YixLm5DXtlQhZigeY61LbYzn04dv4V6pp47QKajzhLfq2P2dRXSjG+rhxUOnJOhXZ8SaX69hhBdySoOpln8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-27_02,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410270118
X-Proofpoint-ORIG-GUID: u9anQgu3DkOXjxlTZakHtmmgr3qZAW0W
X-Proofpoint-GUID: u9anQgu3DkOXjxlTZakHtmmgr3qZAW0W

On Sun, Oct 27, 2024 at 12:33:21PM +0000, Wei Yang wrote:
> After commit 94d7d9233951 ("mm: abstract the vma_merge()/split_vma()
> pattern for mprotect() et al."), if vma_modify_flags() return error, the
> vma is set to an error code. This will lead to an invalid prev be
> returned.
>
> Generally this shouldn't matter as the caller should treat an error as
> indicating state is now invalidated, however unfortunately
> apply_mlockall_flags() does not check for errors and assumes that
> mlock_fixup() correctly maintains prev even if an error were to occur.
>
> This patch fixes that assumption.
>
> [lorenzo: provide a better fix and rephrase the log]
>
> Fixes: 94d7d9233951 ("mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.")
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> ---
> v2:
>    rearrange the fix and change log per Lorenzo's suggestion
>    add fix tag and cc stable
>
> ---
>  mm/mlock.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index e3e3dc2b2956..cde076fa7d5e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -725,14 +725,17 @@ static int apply_mlockall_flags(int flags)
>  	}
>
>  	for_each_vma(vmi, vma) {
> +		int error;
>  		vm_flags_t newflags;
>
>  		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
>  		newflags |= to_add;
>
> -		/* Ignore errors */
> -		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
> -			    newflags);
> +		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
> +				    newflags);
> +		/* Ignore errors, but prev needs fixing up. */
> +		if (error)
> +			prev = vma;
>  		cond_resched();
>  	}
>  out:
> --
> 2.34.1
>

