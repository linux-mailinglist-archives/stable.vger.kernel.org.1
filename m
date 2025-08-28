Return-Path: <stable+bounces-176616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD48B3A215
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714773AB9F0
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CC930F952;
	Thu, 28 Aug 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aLtVz4A3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FxyTh+fa"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99522DCF50;
	Thu, 28 Aug 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391675; cv=fail; b=FiFqngPOc0ApGqAaHIXCK8NwvupYn1IkhJ1hgDRpSqV7Ld2k0LAPLEIWzSVfAap11FA1V0MDFy0o8m/TCtrrLg6wCH4g0NAIsYy84I0i9rLAaMdzw4+mDYyw8Y3uxUOHXVKvb8wTk4HDV5v+Idg1BaIWW1kgXDYpmksnqPQhhLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391675; c=relaxed/simple;
	bh=o+671r3ABa4LUsM0ldDm+Wn35HvjoCYfJENXVas06UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTXmad2fI5NZBtZAxs1rv5yKfJcPWp7MYiOXwJrkHA8i0P77IppKx+SpFx9iRpzCDiymZ4HipiI1YFLK2hKH3MKlwAjG4elHoDc0/8Uexr6eXsHlBZoJOHQJEB4ATLHPzAQcD6aECaLDN0JPly84BDHjla5xKKoEBjXhpBM0kU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aLtVz4A3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FxyTh+fa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEN2ct031235;
	Thu, 28 Aug 2025 14:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wBavTSeZH0xJ6Ewdqq
	YCcXcBlpx9icGsrPzH7ez3+No=; b=aLtVz4A3qsLFOdDZJ1NakOlymwnAqA1Rd/
	PV/4pz1rB/VhaKEG4BCMsedP1E3rpqPJylaAPyaC+fp1kHNn7A6lN0yc+MZCDCq2
	GyfiaSzOfon0Yky2Wbp8Pyy0pBzKPt2+YxZE4tkt1xT5UjAiun0sRLMGlQXOFSm8
	m3Omvl7/JLZvrUp6X2JjC+H7QIvkeVVSqcnpF5jPiKW0nHdPUkV5bDahhipD5cca
	Ul1grTEhKC1emYgiKj75QjlrIaMsCRUmGzlveMkoz5oZUgn7nPa+amzbGM+kOgE5
	6uDNCIm5VriAc5fp2YgI1oxkctfob4QsCS0xr0UQwFW2Vnu9WTig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e28s1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 14:34:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SE2TOx004978;
	Thu, 28 Aug 2025 14:34:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c3hcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 14:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXNnIJy7L6NoX2cJ6TV/ul5HdX9HK4g5vxBmAcMLG3GMm0iqd5Wwcsl/GDw7hTuRxnXcIQJ7wgKSLZiQUpiyftorFR1L3iAjnYoSRX8fQRgZWJZpg8HgzlF9ZjFJbWYL6rW4187YwqqqIkMEzwp5JxBYzwNLUdO/jBZjyXfy+BktJUkfm5HMCDf2nA0Mx72hkdjVnCb1bNEc1gedLeSiMsSIUYEVLJNykqahVgA2WoXJkCWlNor+hOOyHELPW4wWGCkE1tmdeB5hPOddnXdtaxiSUYU9RMInZebaOkE6B6JMKodI4NTIk1ex3hqikzBmU+iS37+hjifUczlloak4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBavTSeZH0xJ6EwdqqYCcXcBlpx9icGsrPzH7ez3+No=;
 b=ap/Qff9OzZCKSCeWj+f6yEnmMSxTdudGKC3tiC60JKJdGYywSAR0pf3p4zMuUucae28Ez8LM9U6cwRdl01YtPy9AUKMHp8aB2IiAnnecJw7VOV0yjLR79E95GFxz/iaxc01UJNFwCst5av/p9mZbNIXY5U5uUZXhMO5EynkdY0z5SPxU3KRr+22mhHtVzvgXr5KSNptdQXWuaKs73feA7FkKTMeHg+fNDnRkzQmmZ3MyO3dz86W/GmmLDDlP/t4TH7LX2PnVW6G6L6WxZl9uYAmnUwgWvVsHQ+UoYElI6ryHJz3mXmAEi2qR5EfDzEQjXNiJKsCTRpVlLdiutR2c5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBavTSeZH0xJ6EwdqqYCcXcBlpx9icGsrPzH7ez3+No=;
 b=FxyTh+fa3Pq1z94Bvhvokkvcm1aD77ZX6zj97w7QY3/uhj6gg3POVWm/XHxIP0It4I5rkkKVhULjQ0RU/mNLWP5XCqNHWJkWcVHXdcexrwz6vZ7hIuGbrA3/M4V1BzweUI7qAjEn8J0NcbaYGuMPdXo40p3mIpPLfiy+DwDjbkU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 14:34:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 14:34:08 +0000
Date: Thu, 28 Aug 2025 15:34:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/mremap: fix regression in vrm->new_addr check
Message-ID: <df7c9ca9-4e5a-4109-b3ed-c86fbc9cd002@lucifer.local>
References: <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>
 <20250828142657.770502-1-cmllamas@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828142657.770502-1-cmllamas@google.com>
X-ClientProxiedBy: LO4P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae3c3a2-0854-4015-73a2-08dde63ff2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qqexxct0m+mN01oYdb1Pg1VPCO806Rje0+qhRKIzGp9ZoRiq96WY8oCHiymS?=
 =?us-ascii?Q?yOotEkMG5mvfEKJlNBfLUGz0TKoOAwrPkWt9G+P8SzximkYrSfScds+YW7Lu?=
 =?us-ascii?Q?Hq17e9DH/5E2+4kI8sXKayjfGsTHL1kNz0p2tyQe26WLyKWUlkaq8UvgPnL2?=
 =?us-ascii?Q?+WKrKKxjaMTNim5wQkMkDO5cL5eJmjNtXEH2tXmmYw1rayh/AudYkznyJqG2?=
 =?us-ascii?Q?uySUT7IMHbBE45Qyu/DmmrLPMTADcnJBNCGYKc579YwX2n9uIIgx1IRncmus?=
 =?us-ascii?Q?HlVVFRKoV8BslqRfb/iwwUxFhJKrLSG6nVH/EsypoM6VATE4b/fsGJlJDk01?=
 =?us-ascii?Q?MFbXbhAKX6AGGfd784szHN+mU957H2+yt2+D04zdcMFiWN0Q4a8Ia6BqkzIE?=
 =?us-ascii?Q?unwUd0qXv3yZfJ0KAhbo+//Wy4LK+KM4hO0Rk+PWWODW9BNqtRDwYIkElaGt?=
 =?us-ascii?Q?Qc90l4Arc3UDagFX/RelrbMm2XDKkxK/1vNyJjoP74KpjWL4rpvKbogazZcy?=
 =?us-ascii?Q?HwRn4cDHTYvG/DC39jOnFBdB/ouFc+ibMkahFbBvRWhzgnrZR+PI4Pty53v6?=
 =?us-ascii?Q?iTHbPVbTNBSvpR3D2u3Z16PyHaMtlsJDH+XWsW9+qRiZtgUODqoHYSwHFUB3?=
 =?us-ascii?Q?XoZXjTgJjA5Ksq0r0/76WCkk5EcygYnPAUT0ODp3y4OGZa8RpNe1T0dKuIfW?=
 =?us-ascii?Q?OdfPgAmW9kB1D0H17xmU103eAUeJOYWmL/co+6NVMnwtouFQZQ9snhlH1LuX?=
 =?us-ascii?Q?m+9THGpohQugGeehkuJSyhRtDQvpluPiexq3jp7ayUw6eywZGdSdsWWkhDpn?=
 =?us-ascii?Q?vLTjE6CpLA1ZJHN/dHfHuMr3eCsWh9lCvwHgOx6fk/R7ntepLTF5bmxGt1x5?=
 =?us-ascii?Q?TO2RONiUrc4+KM7dwUh199zHMdwDbYlDUr5iSOc9dSvUBEQIlw/kcfKWXmwS?=
 =?us-ascii?Q?dQ51E14O82WHkkkARKSQukz6Dq1pGctO+SU3tRANCE8Mw9zvWi9zDDvHtsZa?=
 =?us-ascii?Q?2uTy1pR1UGAu2p7bjMNXjBlp8s/XyvEmuqXxmUo1AIU7OuUGk5gpkOCkJy6j?=
 =?us-ascii?Q?mx9a1hvFMTtI/4Ifj3MEZ/ecE3nohiQtLTnFT9pjMpQfKuGO6jJr2+ZSzJeG?=
 =?us-ascii?Q?Jp9JXIgnN0VdbmjKWHxVJniurhZUCJ9Z/ofIp2lzI/l4Z1DLgEl7zg4f/G/6?=
 =?us-ascii?Q?StZgNEA6+xDEYgttZ++pfUVxcNQAztek1C3q+j5FE4WIvUBS24OQ6QDSKaI4?=
 =?us-ascii?Q?YE33F2dkstUeYFQU+BZ9RM2exWGibsFxHtW7n8ncu+lWprnqBLsqFcjxmCOq?=
 =?us-ascii?Q?t9x4HtJTOqG4HTYG2sxRU+DBIxl6J91uGG4Ff0zqCY01qoJKikd6UiNK2h4p?=
 =?us-ascii?Q?nMA60NOzunfcEAS34hFqgdeRzhdptDHpWsba5mnwq79asspj5x/N73kfd9eb?=
 =?us-ascii?Q?dcq5WTjuYfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ImolP6ifSEIjh/TfpUJNOIZmH0I9jsAHkp9Mkrubt+R1+RbrUn4oql34owpo?=
 =?us-ascii?Q?uwPyREYs9rKv8CWqlLxxVYyiSLS5bThAFRgqKYO8HDRDcLL3fgkGh7V1C1vX?=
 =?us-ascii?Q?/5C7UerjfRQYmb56Rs1dMuiBkxhJecNgjoQYvitf8hrMI8f+Mn0l6osAuzZq?=
 =?us-ascii?Q?fzyiKdSXCymKDpQV1St0qIkR9Lk4Wyh9MSzDoky4JRMXcVgAPvbDPyPQkuHC?=
 =?us-ascii?Q?cyn5/M/EXyqjiRYjeOZOwyJF+EJtNx3qT7vUF+erEYAQXYTz/ZEn8QVsO8/a?=
 =?us-ascii?Q?KNo8f25E2WgRRtb2KlVJqwSGyqLOLej0qZR/QwDDFAGzKGZC2VVNjHJG0pHC?=
 =?us-ascii?Q?5oF4A+vI+0rH/0hmWSLwuPZPNzlM691FvthuuBU6eOyq0n8flPAnbYCbMJWB?=
 =?us-ascii?Q?b1VvrPYZN5ATOMA6Eq49iWZIXpqCOevSKMWGMseCX1VI/FZRu2tNfaYI2I0V?=
 =?us-ascii?Q?QR6SKa1qBNQP/1eDgmC7DEHSiQRWvbvo76dmxXbsEFumO2yRNwdSjaw96zU3?=
 =?us-ascii?Q?C6neUZxVWo6wzxxoK+36H0uQa8AMA/UyZ3kmbY+R8ScqjsG4cz8nJvEd4D1l?=
 =?us-ascii?Q?rtPCMI4ZLX5IAZbyCMm5iFeHHWUXyff13xWn2xRQqyiBtDMK7J+8UO1VGW51?=
 =?us-ascii?Q?YZQavbdge/XRJx9eZJ73hyuoWo8SKNTmR0lmVXo4IGxv/nk1auwfEAMRpfee?=
 =?us-ascii?Q?mRy10YuWzje9bAP5PcPlw6Npmjys9VelDnMdILXqF8fbq2P4wpxXz2W8SWLL?=
 =?us-ascii?Q?KGevvKrwas0T5Uuh6GCTCsxrMbu81OfsO2HY8H3kuAWxnDrb0d+bWTv9XWBx?=
 =?us-ascii?Q?XM3DVxhP9/WWaqnbc9S0nChUppFI89DkLWd6n13ncBWSHXTEN23lNsMozCXA?=
 =?us-ascii?Q?H+PreXn7mJazcGBHXNvxhRobzfOEyJ28nSVp5Bgee5WzsJpLVn4yXA+cDMex?=
 =?us-ascii?Q?KAxactWEttM4DZegVgXY3ZjkBJQgv5TReXs4VGXw7R5HGwRf9iPMOvhppa67?=
 =?us-ascii?Q?/yUMPpT2GzuzVm0suA+GKGYGbq8Vi+HUtEDF0Y4ds5BHmP2pPjBICJFv6QT3?=
 =?us-ascii?Q?A6e+UrSooj89dv8o+wsvpV9o2xsWV7MTQSLgsIZAEUpA//J2FTCjYl0ACD8C?=
 =?us-ascii?Q?GGEeZO74cZKa7CFyDjFZcIkmx7hzXx+Yb+E3GrJpkcI+gKyWX8Qtf+9mPcKb?=
 =?us-ascii?Q?Vizgu3KN8b0TSG81oSLSZ+zYKJXmTnNJcWHNhQNrVFyoMM+hdvHyCYtiZyDQ?=
 =?us-ascii?Q?jgBsKDX3EafLsvOqvCT9bxCi3ghuHfN+l/pF6hYOGnmNfyquDdMVzwMn+bd2?=
 =?us-ascii?Q?0j6k70NrERJoJejk/MvwCiHv9H5iOqUDiD/zRTE1h/MR+XZVx4WVXHuFa63y?=
 =?us-ascii?Q?N/SWEhAVNF3pJi8V57cuO5Zddr6k6ImD3YbsqWDSPjSMPcCznf5vSFOk5MVG?=
 =?us-ascii?Q?qBqdPQ/dlQ6SMIbsKcS4R3HAy6i5lzPQMa7YtzWNcc2VftInyorFGVPvs8NA?=
 =?us-ascii?Q?A2IFiDxhZ6wm/XFasQBu8i3bnhcAnEukRAxJsbieOgsPWTWAwVGAvTEJprPP?=
 =?us-ascii?Q?WdRu5rTKGExDsZhp9gD3RtnNzWsuPZ3JbvziRfSBvOvQPlz5JpOHSashtf1k?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PezSARHFT822D/RZK04r5T31nXRocInWljbiszDtLS0mUNJLOR3D9K2T9PI2QTddKNmWNVcxy95UYRorU302kqWFnw7uRMBtD6tZ6uFU8EoWaHmgsrg+9nndImvNf/DArqaLF7TJRcQp7dcZGpWfUmpSTuzOFLIEKBEZsw+S+aWJSe9rUBH5bqf3/S9hYVVGUzkmIg+zXPlr56ChxsjzFIhpq2PZmQtYq6fsGTcE8d2+VxBInrFytp/oawaVCMupkW+MjlJoo3vTZ/Khb/gQKu+nP00Axx7nW11XB0tLmhNDKKS5oAnoVN0SHqbqlP+/TVlkhBG5jG/jAy3EmwBUv6S+ys6iavAfovkm47102O1o0oUJ+qOrWPPoggAOJYi3XRx+fpX8FiYmAvecPfoNgcyxeZkNptAkUeQmgrsiSFy/nNXL8Kg0j9KPYayk31I/Bf3umcBJRkNUeW0ndotVlCNIrwDBeZTwh5U8ZtPjvWwAHsuYUKXvFseh09i7WADnBujw7jv19PAzuV8t9nf2gTBjrRF9KFuaJfEcaaAf6TlvhezUrNszeMkIzCHuLqc6tT2Y0PH27zK0KGa1Xy6im4vuFoAiCSbgicCnUkD065k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae3c3a2-0854-4015-73a2-08dde63ff2a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:34:08.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiEENM89xQJaAem/TkztEysOOAzRH6esX2CAyXdWFzPBjVjcuBlVtEV9YrcTEskDKQ8a4ZPDyFhCHJfSTJogQjygTkZPwBKWcinIIDiP9tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXwMXkqWVMIjdR
 cY4u5jhnG0HidiAlDhNXxJVFQWKDs3g1AXYwKrcoUTv6IHLio3DHPTeyBtBriOldpHk4nJe4PLc
 nyP+tKk5ZAjAaGWaSzDlirUqwzphRjZnV6Jz4gCaK5a/KsfVEVVfEiy4VdwAsszKwjgdxBqrszB
 KIcU9QibWr4K7T+96JG0kQZq/tmuWUtMidBP1oAxxi3DOCVCaezVj+PegaN08wmye7dUjPhFgQG
 Dpn/2kuW5vCiri9sPqpCr32TS/fkrEBu4WUaAF9Pf5pKUy3TKjEz5nKIXkOKKhQU9IlqQBoXWDi
 WGdJrEjgdu704rkWXiLLOK80M201Hv+APaNyK90lrp1HJb+f3dgVHBFR200Q6KMCxjmlUbou7K7
 vN9Whky8
X-Proofpoint-ORIG-GUID: P2RBnlvdH2beXuSMCMersciM98hTBVub
X-Proofpoint-GUID: P2RBnlvdH2beXuSMCMersciM98hTBVub
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68b068ee b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=Q9k52ML7tkkhpPhGPtQA:9 a=CjuIK1q_8ugA:10

(For future reference) please send separately rather than in reply to first
:)

Otherwise harder for me to find your series!

On Thu, Aug 28, 2025 at 02:26:56PM +0000, Carlos Llamas wrote:
> Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
> checks") moved the sanity check for vrm->new_addr from mremap_to() to
> check_mremap_params().
>
> However, this caused a regression as vrm->new_addr is now checked even
> when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
> case, vrm->new_addr can be garbage and create unexpected failures.
>
> Fix this by moving the new_addr check after the vrm_implies_new_addr()
> guard. This ensures that the new_addr is only checked when the user has
> specified one explicitly.
>
> Cc: stable@vger.kernel.org

Yeah oopsies on me suggesting this :P losing track of my own patches :)

> Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

And again thanks so much for this! :)

> ---
> v2:
>  - split out vrm->new_len into individual checks
>  - cc stable, collect tags
>
> v1:
> https://lore.kernel.org/all/20250828032653.521314-1-cmllamas@google.com/
>
>  mm/mremap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e618a706aff5..35de0a7b910e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1774,15 +1774,18 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
>  	if (!vrm->new_len)
>  		return -EINVAL;
>
> -	/* Is the new length or address silly? */
> -	if (vrm->new_len > TASK_SIZE ||
> -	    vrm->new_addr > TASK_SIZE - vrm->new_len)
> +	/* Is the new length silly? */
> +	if (vrm->new_len > TASK_SIZE)
>  		return -EINVAL;
>
>  	/* Remainder of checks are for cases with specific new_addr. */
>  	if (!vrm_implies_new_addr(vrm))
>  		return 0;
>
> +	/* Is the new address silly? */
> +	if (vrm->new_addr > TASK_SIZE - vrm->new_len)
> +		return -EINVAL;
> +
>  	/* The new address must be page-aligned. */
>  	if (offset_in_page(vrm->new_addr))
>  		return -EINVAL;
> --
> 2.51.0.268.g9569e192d0-goog
>

Cheers, Lorenzo

