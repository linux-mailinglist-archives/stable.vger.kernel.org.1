Return-Path: <stable+bounces-93538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ABD9CDE82
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E281F23336
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24831BD4E4;
	Fri, 15 Nov 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GkttqdLn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DwsAraHz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B571C07C5;
	Fri, 15 Nov 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674564; cv=fail; b=L16IjFw4u7sM3vabAhJtQaa5uYN37rnc/C/qiCxhYRj2yVIm+Jz2DzU8BUE72oChSIFQsa9l0sjL9kXlZVxlTvjn5hCzlgwa3H0b2zwm090kw+QqnT1ZB+lc4x8pH+4jwIxAlEt9c520WPc7bp+4oItYjdQyY4cJwErdPwmZIRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674564; c=relaxed/simple;
	bh=3h/WOvLvl97KLmx18nzqvwvy1syzRiyUvzNQgOCw0cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jq4YlzKkMWRcrmTBjPwnBUjW85+fOA4gEvYmR6uXY4MDOK362INct5HMlOHtDlU4zUWtStqgtTYbp2mw9PjkGcRpv4Dc5TGTdJTjH4jLMdkn7nhdvTfTCMRADIY89TJQP8t1UNX3KALy+bcCcQuqhXCTrGZaYyONV/0A2R0rJ1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GkttqdLn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DwsAraHz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHBL1021442;
	Fri, 15 Nov 2024 12:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=spnAHCCRbHps3QlTZk9KoUOkxA5rCBm5i/Uk9iQm9cQ=; b=
	GkttqdLn0EKqwLEZII9F2CN9sId8EnPNvpKOkk8EnAJCMLwr61/npX0nRK++zoaU
	2S0V04UcrmbevrGRG8q7oOQFkD7xZFbVSG5HJ156XHipRu53bojL4k+kPlMhoGYV
	g9bdkiD9R85GZNfFUQkyCJ7Tuh+IAP4FxkucuKuVAAkubUZ1Ee56sFPBLBwT2xBt
	3aOjUb3oFJ6FfoVvX1KkIlgONvwBUxKIbbXLNk4bg2lPJvkTu76Dl2RPLzucPotR
	SKu7O4JU4hMwAG+JjxW9fNBzZx4S3kIzvRACgydWF2dbl5y1mH1oIFIkm97jDazF
	YYUoOqJ6/vd+vdu24b1s8A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4n16n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAe6R0005765;
	Fri, 15 Nov 2024 12:42:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ckve9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maS2x0Y6LiBP3PpOkYDiKfVOdDhx2XAjdzS5LiD8xETMFxMdkceirb8eu9mQp5yB8GxmDi3VmpleqFHKFqozX9MXmyzJaJvteJufsfZZpLaUJDIVqfZfSFf1zIOLA2rYsLJB7NkZWpSMgdZ3eH+JSE3+RkaOMXO8DGNoUghoDYwkDt3R79vJ4SWOvmzhdfLwNMlKIncIRC44pCdThz42EbMRwO54DY1OlLI29Wa1eK6qrQZA0FtOWGmW4DBTf1bBvXX6b7c4fv7cv0kpo4Wpq5dOjweCIJhATsYf+XU8U9l47ftUD5syaz/v4oECkQB3I9q805R+xMhzJ+NUbhYELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spnAHCCRbHps3QlTZk9KoUOkxA5rCBm5i/Uk9iQm9cQ=;
 b=NuN24qKlNFPM6WLF+ZXYivVvwOjJmFCBrCPp9MO5cku04Kff7aZFvFVIxBwrfSMjIK28lJdhXrxRf9GIA4FQBjIwiKUb21gKsj45Gphb741lL/8nMFXBu9x1/UlQPn2lHrVGZHpPHwjxKzD7Uzt8QwM+OCFxF5Q9id2p+hr7iKqeLkykgqOybhglVsH/XTQ6JBw+zlv+/c1ESIxshumrBFfYUOyo9E/CNbxPXL6IPVj5fd+2RidRhCf6fHT+Jq1oiVGm6FzCa+B31+Dcoivz719FuQtmYTd8HPK555KsYLJKp7eyYJ2ujQvAWT4ZEnVXHGo+aoZw7sys43+X5SzbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spnAHCCRbHps3QlTZk9KoUOkxA5rCBm5i/Uk9iQm9cQ=;
 b=DwsAraHzf/gzgipfJw0qWPlV5x8dDOxs0hew64hF0ZtJI1hvyEt5aOO4eMCBbJJn4CYqLLhFVVaWX95jPji64853ZzGvMm7WGa9d6EMIsyMbElOPY/7SOdaIEXjYvzE6a0iWjNwBD4Noc5PL5QzOLAbQaWm8VYVMsjqBLgHWno0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:42:16 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:42:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6.y 4/5] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Fri, 15 Nov 2024 12:41:57 +0000
Message-ID: <7c0218d03fd2119025d8cbc1b814639cf09314e0.1731672733.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0312004c-47cb-49d6-acfd-08dd0572ef9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgTI7/rkKOyZzNkmUhkYEl+nOYoBKmyWIqe6jDyxLsljNMmpMgHoMj8IlsGZ?=
 =?us-ascii?Q?CrvwmAK4PbFqAMpxWiRECfpYJG9fyuMfH9RC/PJAHZrPoeSPgIr47hWwFWF2?=
 =?us-ascii?Q?zsdH16IIdDzd81Z8gLZ59e6kZJY8PO8A1/8RLRmDTQx0iQGYWiJMCIn5bDTO?=
 =?us-ascii?Q?ttUN8ExyqkJEQMPtlXhkRgV2TjIBSYoMNRupuen/ScaxAmpMEFCO/n2mV6pl?=
 =?us-ascii?Q?fmPrwYbQt926w27XBSLB7IU1CUhJ6li0lyBtdgK40SDHhh/WBtLzLK/12Oxb?=
 =?us-ascii?Q?gwpm3stB3HZezuzXLuGM8FFKP61Kp2Pnm8kw/OzgWfAM1sTwRUxuUwTNB1dq?=
 =?us-ascii?Q?+pgT8qp/BB7b/E9Q0MYwKYBM8a5OPFXBAO85HaZgc1WIVt8aaHd6UNRKhRdP?=
 =?us-ascii?Q?opRTZje5SwdQiLYpXGE8GMmkreTDReBsUESbHmwD/ouY1N+/NrKBILDDotte?=
 =?us-ascii?Q?BMShGz6qmDOT+MkCZFA7Omd1UCV93eV5HYYRrXVfixV8USXz7LzHH4KIijFd?=
 =?us-ascii?Q?Ol3OlCQE+JPYoli3sjx06Bq5Ir6TDx2Nu+1XfnSB+fTALVMQ1SHCT/Qp/1hj?=
 =?us-ascii?Q?NIzyRGe4WImkAeO3JkwG6voE76FwXENEMUmDRVgjd0Us3gJWzE3hKe4j1/qD?=
 =?us-ascii?Q?h4pENe0dTZKXVBv57CfqPul2GjrjC9CBXmIDkYBgzTKklibw9HYFoohP1ZAV?=
 =?us-ascii?Q?Yp9JzAct890esX0zwT3GVnXb37Ac4umUXuCkah5KiYwPTwZePOg33mEgM1Bk?=
 =?us-ascii?Q?cAiUl9on090JmLbdzJyLP0rmgxOgPh3reD/jNdqXxSwI5xXtYOeb3fYTEuzv?=
 =?us-ascii?Q?tjyUgkfL5crZvBsiIc9rDQBJjqHSN3jOkAqOxsqr2wQlGwmWWTsWM6sn5/26?=
 =?us-ascii?Q?OgWIF7RllskFPnA/nahAgCSKcMAPOArCCtL4dpklEIuL9i713RtWtRJTwE9x?=
 =?us-ascii?Q?7PSo9rQiqF5Up6re2vct6O/DDn9zFa01lwWW7Ry5VFRFF72B37Sx5rY5AWB4?=
 =?us-ascii?Q?bKrePmRiqjWE6COhbe4jAIDjbqlOb6Ji+JJYLGIyUO53RwIIlMJgXtWYzAGN?=
 =?us-ascii?Q?+AGVnE4xJ2rSWe/k9u3nAzDVVYJ56PN9K9zqzVcveGt5w2M30S3kj5hDkk1E?=
 =?us-ascii?Q?qPmlu3ZLMkUCqTsYAmXijVYgvTcVKv2a2IvzukoSU/qrXiG9GoW1LkEtoUsm?=
 =?us-ascii?Q?RkozUzeNxpvzPV3b2RAMgqbCDDD4+r7H3rLR2p5rha6lYsdX/mGMhWAl9h6q?=
 =?us-ascii?Q?hRL89Qk/sYi0ODZc07P5Ot6GqosKM17xdWbRMh+0hGrLgYxjrd8H3kNEYIby?=
 =?us-ascii?Q?lNqZ2PAr5k7dFbrpH0KUBEXn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9HU+N19vEJl2+dCbk+mDd43BICK4Qp3E3uMCr5cl3kJuhVF75TXnCU160H5E?=
 =?us-ascii?Q?PnT2pvXmVWiGAOYBEyVduadxTp9u454nFg0k4y4Zr9RgmD7Lt3ZvGGuOFw+E?=
 =?us-ascii?Q?Yx3e7I0Hk0uierJf9sgOZsRIWOme4SDqxnv4N7rn6HSCa+0vhKCmqZeeMpit?=
 =?us-ascii?Q?MmN1Qys4XUAEnEHSSDw9ZS+YyXGCK2e+rM3Om289F8Omiuo2L3Zg1oL6Seit?=
 =?us-ascii?Q?+emqsz+w+Dt4z0IQFp0Y02df7qrewN87A78AKFlVnI8KAAdJaLzVFV6kOkwN?=
 =?us-ascii?Q?1SYHETx7E0pKsedFoWb9++bO3j78QVmynAeDpGm/UX556MxSeKbk7s9ChMV0?=
 =?us-ascii?Q?vMwRmri8rvAQu38XPfTvmcieKb87gJOdcrn3VUNZQJk7vmpVZBkyxDOJSZ8g?=
 =?us-ascii?Q?asngfGlVveZ7j9fcsRMY7PfulTYTYIveLLBwv9ImZywbJFVyK+hqe9jGQFA8?=
 =?us-ascii?Q?gYp37BOpmtxt/zI+oQFrYF7lRI9EF7PnUuOfdccQZsi9pkEiAZSnyg1ZgSSM?=
 =?us-ascii?Q?YC44w6OeaC6HpDAItsyGmrY1v4n3pPCBtHNpSx4sH9x7gxUHoG7odR31iJWL?=
 =?us-ascii?Q?w/YcT3eT5sqqTzHYNasb44/JNKcVl5rpk7TjgS5cS26UZpzimU+XoXdR78Jw?=
 =?us-ascii?Q?ETqMgueWoZRXq0Rt+Kak/WfNnZjKmENmRtWq6Q+1oJ9AC69e6WBvpMHDbYER?=
 =?us-ascii?Q?VupF+0SH3Dofj8k8aSOG656ejtURFrcSxfLfQiv7kxpJ+IR63lBFNNpDAyFv?=
 =?us-ascii?Q?ggsd3HpAJ6BnCrzgiW92xB+A0PI5YrRfX4Gohww6k6JF+NL9R3nCGFNPxaUE?=
 =?us-ascii?Q?JhBEqTaruL9ocjyEiSRviMabDcmK86ylR2lnPEsN+e9hJrahRg95fw4NF1Gz?=
 =?us-ascii?Q?+68kXfaMFJ2EODpkN7wHmcGGESY9QQhjnx84j2+qSF7TYVaGeAkPYxJMSFpr?=
 =?us-ascii?Q?wh1eKadAVcFyPA0JCJLugTKyioAQUFfGwTfA2bMli58fPepWzS+vFWsI9G91?=
 =?us-ascii?Q?Ze5ZqcTguanD9v/EnI6phdJHtZawJ6xkCzy9OQ1yaiDhSk7k/8KjEh9up6cL?=
 =?us-ascii?Q?LUkOlkEpGcl6rRVlmzDcXkcMMqX62L1DD6qF1pUHmf84daZ9SrySTbLbGlIK?=
 =?us-ascii?Q?Xj/RpXSjDIgOKUNVCZWtDFXmrMxh6ciJ67Pi7+dY9+IYicf+1SLy0QqORKEs?=
 =?us-ascii?Q?E5ItsfApd8SFxl2zqHpVwi/yMVUJ+nQK0+Rl7fsQMw7i9eV+pJDrYE1ShK+L?=
 =?us-ascii?Q?9+mDsX/LI6KE3/f1io62l7PN0AIYAOjZOIuuizy/yWV8qGlsTxxEEOomIzRZ?=
 =?us-ascii?Q?sv0HKshLv40LxDBepmkpWOprALBQgs8G3p9VNT0VmmzUoHKSltBfnC5HJ90P?=
 =?us-ascii?Q?X7Yo+VoEJDCtg4H5fyGrE6aX4YTGkMyoOEbFgfUkhRBcg2su/y2ZYrHQ2+Nu?=
 =?us-ascii?Q?RCR9w1lDOOrG2+aDN+ro0dV38vETNU+eodJlegoZsvjWmha8ZkFXSJnqU7NE?=
 =?us-ascii?Q?AK/uWxoqBiGvw0K+rlUu1NnC3Ag+dvbHAluopgMPTuOWjbiUkGctTBRhGRke?=
 =?us-ascii?Q?xuBNn2jvtr+GP45xZRn48p4wTNn3AQ1emBrZZRmKXnBcxKS/9tS/XySrEtcb?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TpCaOwC9/y5j8RpCCO35u3LRuiDG/P+NnLEy2Yqb1uMCcuq72l772GIq2coPkIgYMqo/27k5xKHcw7WBGHzVl1Px9aNn0dmoUKAmS6YDqQqOjhVnhT2r5C1NkMrnZ8DWCpS+21KS2tyKMR8mjTv1aQd0+Y6siA2Dvl49dan+ZDcwgGhKgFniKvbiKrCOwN3BBl+L5SlXCFqMBYZre4bYnGobKOU5QctKjVGJZWx5aCC8AkOHXBGDyVFk4s1MbZ0jEzNsY0u9nu0laI31c2Ddtq7R4e0YU+S0L1KElQpUQLArn2BVnPmZDAbVAtFKMZh+kN1YeALY4a91gjbDdQFtu5bJx6/q/YG1qFWyGHPsM4CnX+Yia4GPdNYB2QP1RVCTi/+TnP+cUWL7UKvwzsiZ2qi+RNCUnmptBQRaHiiMRDcy0S+Gnl1M+ZnCdyPOcGWK8mIVz/e5IiquzSHMh3D2Al3W54lQu7l3iZNKs1809xW6hYH4he96ReTMyNBXortzioZQshfJTJ5ICQ6kX5uFhfIdICSxKyt64mcHffaNu0ZifQqqpRkSy3dkxysvEtGce3RYIv6wR0tJAPo+hgd0H6WmuWk7MiLgr/S/gg9TgPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0312004c-47cb-49d6-acfd-08dd0572ef9e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:42:16.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMHfufEIIX2jE2jUTH++hC9ba0U2h3Kw9wiQ4EOagKiF2G0bDEHTDO2o+hWMQSed6gZOpG1jg7eF+4lsNlDLMa7nXsxOLdV38cB+SXz5pnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: RVwjD-P-eMj8lzbvHWkEcg-Xd9D5K93J
X-Proofpoint-GUID: RVwjD-P-eMj8lzbvHWkEcg-Xd9D5K93J

[ Upstream commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81 ]

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h  | 10 +++++++---
 arch/parisc/include/asm/mman.h |  5 +++--
 include/linux/mman.h           |  7 ++++---
 mm/mmap.c                      |  2 +-
 mm/nommu.c                     |  2 +-
 mm/shmem.c                     |  3 ---
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ef35c52aabd6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
index 89b6beeda0b8..663f587dc789 100644
--- a/arch/parisc/include/asm/mman.h
+++ b/arch/parisc/include/asm/mman.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_MMAN_H__
 #define __ASM_MMAN_H__
 
+#include <linux/fs.h>
 #include <uapi/asm/mman.h>
 
 /* PARISC cannot allow mdwe as it needs writable stacks */
@@ -11,7 +12,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 }
 #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	/*
 	 * The stack on parisc grows upwards, so if userspace requests memory
@@ -23,6 +24,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 #endif /* __ASM_MMAN_H__ */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 651705c2bf47..b2e2677ea156 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -94,7 +95,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_validate_prot
@@ -151,12 +152,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+		arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index d71ac65563b2..fca3429da2fe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1273,7 +1273,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index 8bc339050e6d..7d37b734e66b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -853,7 +853,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 
 	if (!file) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 5d076022da24..78c061517a72 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2402,9 +2402,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
-- 
2.47.0


