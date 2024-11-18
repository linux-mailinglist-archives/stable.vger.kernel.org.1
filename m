Return-Path: <stable+bounces-93809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11B9D152F
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CB91F2334A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BD1BDAA2;
	Mon, 18 Nov 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C9Mw7j1y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e1FzDHBy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B21BD508;
	Mon, 18 Nov 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946739; cv=fail; b=gHJDcHOQXVAU9pz7z5X7Qumth1WyKLzeOEuTjWXLc8b/epovbqjz2SvWwyvGyq751IFapkQ4Z/WmYp0XVZDnl4o58UcbAsBOh9dzfFViXgupOkyGmZ7I+EdS/06CkpLuhVDLyuFJw6G3AVO/dmy+VV6z0dl3Zo9meS3M7WBszBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946739; c=relaxed/simple;
	bh=rMgzYDuGzwEGx9C3I4Iw+T/QnZblXTcyHcZv6bj9U+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UlxLZWGXekDXpW+hoN4euVfEC75xPsXjTqjjqycWH7AP/DLC6DkaAor6ajboeRyIDJvqgYkJS6uVoquFN9ftAUJf7x2yDkSv/wouvF70vo5EjpLfg+8B2O+bpCGlAVrlMJTZ5qAmj5USc0DWl5i/Yye6jHhCjTI8uQeavzdlvck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C9Mw7j1y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e1FzDHBy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8R2ub011100;
	Mon, 18 Nov 2024 16:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n677DzD/vofqdaHKQpPiCq3teUv8/eVlhrcSr5BSnVM=; b=
	C9Mw7j1y4KtZ3qckz3L2nDH5GF7OUQw7njWsmGRKwmfE0vDlC36kRaKvqsQKlPue
	ckEdFkLcC+AjfPbsNBFw3QA6zVfltn2Vsp7MozjM2YyQDVsa4W0W/kD2GvP7/zZQ
	f1TpxHAm+ZQUNpY3xhatSVF1cddPxCiNOBNjixjlNd6PBigMjhnUO3tlMnLl8yIx
	e/A97sqmQCj7QHrzOb8X9TelctkPXRXAe4wmLKEGCK7Ma5L01rjdC3VX4DAcxs7G
	RyN4y+MpqlHSD9Kjrz0uqsCswmi+6l/+0ME5XXdEFy1qXmv3q+SLnVxStEM6HbOp
	VMKd43tWWDJLsELDQjPwBg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc341d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIFPi6R039269;
	Mon, 18 Nov 2024 16:18:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu78bdx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Lkp3Phv2GNO1HWDoSqAkSi+feWCIJk4sosigJGjvO2sFzg9HR1/vYsewBW38Td1GhBCATJwE38W+7w9P5dlAaUrkZrH8NC7qP3KvmQ+8HSQ/YdhVUUNRjenm5yixQPQIIsjiicJm8ym8jVSEgk1S34EWGDcWQhe6bpxsjByr3WM4UCV0pXvhjtFAWqdYBuoA+EiwzIgj68Zm0p7N+j1dlbST26hFvAbv/xKl3uy8OnkonZiCW0xaDzSbhVbimRApikD/5EJJt7DJGq9QcH9H0BAygy4CRfJ4osoIOHI7XH/3MUjYfdLKxJrpyBLs9R5Uui1iiqWVOnzb0XiYhpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n677DzD/vofqdaHKQpPiCq3teUv8/eVlhrcSr5BSnVM=;
 b=daYf5txv0qw2+KObYNtBXUISXjolKfg4dEqrxhnMhW7mI9uolysBfqN7umclxxMtzp98/C+Cd0036HlFPXCqZ5W0eDcFXAHMJDMbyhTLvZ2OOGT9N6s8NCIWRIf5WzJDi0RG7OLKh8AyI/sgVLP5Jn/qZjj3BYbwom9WvpzSgawLwVueBUmPqFBKnq4ftAVbjfRN6hUSiUfDFEzx0sNLScGT3PZ4kMJIYsAsfEp1ZXsaxn66KaKPZgUAe68JH8FsgJFPes9w0ICbvtaS19CUxRdMOtdGtEBJzTHuCHhwXyHE56ipZWUPcrwoXaXkZ8+mbVY72hJm9jWYAaoh18REeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n677DzD/vofqdaHKQpPiCq3teUv8/eVlhrcSr5BSnVM=;
 b=e1FzDHBy98dxMyeMfON+V8NSVZ/GSY5GMzitf1KxasSB7VXwK9F6KowQFemA/w+WV/itDESfwVJGcN4yIRp9umDtoC/0P/pSy8e6hqw/3zzaBMtMDvSuPSspIdBKPIxPaus6xGV2vQ1F2Q2jmre2h1ll52NmGrdNkUgg7fpDYAQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7619.namprd10.prod.outlook.com (2603:10b6:a03:549::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:18:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 16:18:15 +0000
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
Subject: [PATCH 6.1.y v2 1/4] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Mon, 18 Nov 2024 16:17:25 +0000
Message-ID: <d1cf846c2b9c5a2d9767ec128bbafedeaa6d2856.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
References: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 73313726-e6d1-4e96-20f5-08dd07ec9af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLJ0lMkVIz1E+3mcPoFq2sgaVaU8NyJl/TvdHQ+tCIeqGCkcvnt87puxwfIM?=
 =?us-ascii?Q?Rr7ZUK+du8w2Am5QAWB6lUrVlfDW/d6tuk77Z6QuGJx/yFcohOIiFKBqLSYy?=
 =?us-ascii?Q?qVEGEOpHaeFivLWWAO08qcLUQJ0bUjHLHaBA0ad8cGfmRy11jswpVUQQ88Yc?=
 =?us-ascii?Q?tdIFcme3L5AT302Y1ry277tTR/65DPB5x7hRIGr7Fvmjfgiks3VzKBLMyxX2?=
 =?us-ascii?Q?dS8vmeW2Tb5k/vbnoTZBn0+N9nj91WJJQ9RsMVKZca3FnOmBEKULK7wR9+gv?=
 =?us-ascii?Q?IgguRnO8F6TCmRNa+qIC4vwowMnGy9bb6E7eiw/yh5aqjnNxs1YXSuzILwWG?=
 =?us-ascii?Q?NjoSG1E5+2utuOLx697H87icFlW9PJhwRHbb1nR/mpjQiLDwr0FNd/hjlyLp?=
 =?us-ascii?Q?sssKqW7WUGNKZbFIe8fDniYsQFcvqdG/BcgEqIQ9aPogvs8qmPvZB2ZlAdM7?=
 =?us-ascii?Q?5+iadzbvRJ57hnAOFFV19C1W5itqyNL2s6rh8ccEjmhkVKGJMlqCZqUZdTLj?=
 =?us-ascii?Q?9enXekd2PTgaV8EiSSS4/foeXOXS7fKopXTqWyaepzi6Dy0g2gfoUdd/CnLW?=
 =?us-ascii?Q?I6YIJTVi5kZimnreL84bnxA0Af/JzA/BREVchHGI7bb1mVkshY9MkXkcqxJA?=
 =?us-ascii?Q?LTcd2vZ2kHsTGxSaWtplCgU/YJc0C20ORViYeXkFQuPNtZE8k5fBuh0zk+57?=
 =?us-ascii?Q?NBhn5fqRMZV2Q3EQ1pRD/NEHzIOrIVLn1Qwi3NtuNWBcRai62vdD/utPTzaZ?=
 =?us-ascii?Q?G6CjiAQP8639YEF2Q7swttML4rvNMz7DZ/T1kqgPfy7k2o1OP2K+Ojb1Myr/?=
 =?us-ascii?Q?62AipSiJmfj21F12TEkhHGflIkv47qujrPkAKRa+r128/bvnl/R6+R4zGP5a?=
 =?us-ascii?Q?whxHL5BWN6oTK3QA5lHTx1X6Al42FLhROOm2CdoUjzvgQn0gpr21NqP51hb9?=
 =?us-ascii?Q?FJWtczITPgmi0sfRE7gxcCFiYq4pp5xkkZbbUvvk92BhpqZWJFS221/4sJgv?=
 =?us-ascii?Q?veERHXJ7OrgfWfZ6jbCTvSJai93QVQZyoD007nMvinbtdxyPoMSg7SDtVFKg?=
 =?us-ascii?Q?LUJ8te1b3oluA6fkh5fopFElaHChdvAFqPAowLVUldxrGX8yAqt2OoLYvZuK?=
 =?us-ascii?Q?lpXXDGAtlkOIAuZiRfFRVqQ4ugNicdomicXQ5LBHzfGyzHMgYPuQBTJS7gIO?=
 =?us-ascii?Q?NZtKwBqgK+limXAKREuJMJACyqk929JyyC47M4qtEsbkx6w3RD7ZzTsV8W2K?=
 =?us-ascii?Q?LbhZKtcJK6dDBIsAiLvqQDGOThlD23tK+Te7F9gmn4rmbPWEvxemQVHOg0s5?=
 =?us-ascii?Q?XIMLlMVc4uZkAp4aQvq2qBbb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qwdCXglZeY0MW7NO+1Nd2YxlrlLRWK2EpSl6/HRFIQBNwwm5nNxoXY1uDI+I?=
 =?us-ascii?Q?eb5OUQKpujsL9DPw7aBlfL5am9Uf0nDOuZvWFiDHtFAvMd9lC+CEGdoIHsJm?=
 =?us-ascii?Q?qlh2Yk87tySjFbubR9bXNfefeHR0mwpRaEYSOQUVOjxiLLWfSqgIdTKAfiQp?=
 =?us-ascii?Q?rICVqJBcCd/Q8BgBgdhZmkvjEIJAsD+krd2BFdB+sTIf9p76Ba72ylJxFn2K?=
 =?us-ascii?Q?SLH0W7JUxVvxceqfR52EnhzOSPhrEoxUG24ZoWBqbtXdm7LO6DRRK1Bhqt8v?=
 =?us-ascii?Q?FwdhqrDqTbTsVL3ss/s8iNP1+bugFBHkg+pwqRjP+hWO28i3VD0oY/16psS/?=
 =?us-ascii?Q?eKf8AqXLWuaoaYVNCYF19O21s1AjFX1ldTH8OUxgrVAs0HxO4hkhSYrGJjdu?=
 =?us-ascii?Q?erLcWhO+NU5oyNJPsmHHTekOUP9F6Tl1qjdukR20byJQbL628SVIDBPKkpCi?=
 =?us-ascii?Q?+StUDr4LTcae7dzNBxl91XciT1k50z5InoLaT2z9pHNg1GBHlZEBxsN04R3t?=
 =?us-ascii?Q?hKHIo13wn8M/grhWVbzZx8M8zwiv5NzLDDDCE62F8A24b3LHBQKgV4CGNZm8?=
 =?us-ascii?Q?TfqKC/B7H88aVCO/z2g27K2UWg3zka5A/yMrgnc7llXLS1nBZMEZa6tfJF/a?=
 =?us-ascii?Q?9b0mJXxhW1YRektJDn4sclvj6Oq+HZiYPMYGLR/xMzVCDOjlHGglGjgyXA6I?=
 =?us-ascii?Q?RgaLGSl1tCt2WKCHA0Gb4C7Kk53qeDmpE6h7MszcvRywILPgOXNM452U6fcI?=
 =?us-ascii?Q?7S/k/peTaleGlYXWYFogbEGLgc1vluF7DaHZa9RQJ+iYvR06moljxcjI70gF?=
 =?us-ascii?Q?Oxmj6MdVOOo/UGbVokjmDMNlJZZzaQq9WEGIodgmbd4OvPrTTlDjKUTtIMwO?=
 =?us-ascii?Q?12UlTfuY3xofEUR1ya9MtpsG6AqOpw8aYDGNCdiZ3pjWJG/TyJfeiEebY4Qd?=
 =?us-ascii?Q?B6xorBQuR/cEtyh5bFWE3QWBbwcnLfYTGtj8ckWXyKfNllEoAgHVGRBsb5JP?=
 =?us-ascii?Q?g8HKI9yaZGhBhHxiQihy8lWGCctN53NDVp8cwyDBeC7yDdIdsBZfAGCRTKv2?=
 =?us-ascii?Q?IboqLtad/T5nsZEOJf1RUsG5/rg2P/r3YO0QxDYc4ogTz7W9Gkwf+t2tPpia?=
 =?us-ascii?Q?P+FHPwL/iSa0u8NKLSNmO6biig38/V7PH+8rWUKCXjslst93xTHo2NrLPEdW?=
 =?us-ascii?Q?T3X0cLd5Vr/U0KIN8vkxQVGIf/6OhSTea+ZTru+rwdEwqtzSeBX+Cu3lKxR/?=
 =?us-ascii?Q?8lYQUSvZ1a9b+crmLefIF8jb1bi9t7+vYRptiU0TKmEv168GIEyHxGMPL5OG?=
 =?us-ascii?Q?2T4B0oYLUI0YC3dg0MRjeeWOaCLfm3dobaCDwt25hKfZ7Lve+I6UzO/W4VrR?=
 =?us-ascii?Q?cxixHSHM2AEgwKLzbIb7iS3QFjaC2defhtCIyxeDiwCm0L6S+XUqMsgZeEFR?=
 =?us-ascii?Q?96D0mPHx4CN+sVlBCkOTVGDsaAea0FTFFl15tjxFRCvVXuUhixl13ZRvhl6o?=
 =?us-ascii?Q?fLGo21ECNsC7bjT7tlSJCGhfBcy1aS3ht99lmRfU8adrq/oSI6+K0LuJotUE?=
 =?us-ascii?Q?ZWKiWNWTn4cJC8vDwVOUiEx4y9INu+cZfIQf/LgAm24U3s1AjgieySp5zcSK?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C9PvO/plObP3PHclyxX4YjwjHhUMr+npa9MCysNO5F3ZTSa9z5LQhANNUN74ykqiVaZYLMLHJSv1mVA6DFhvv5mINtvpEdTyc9Gvq0dOc67BmZS3y4FdVXborE+3p/FEQA4LN2zh/5tUDII1pwOgp23HGrJA1uqAioZ58e8qVzGrsxjozYwRyezJb195hX6T/ghf3bIV5gAK8lE07wucMuGzbHgdoFbBl8GQWHTjiZpA6I0AnQ5a1bgpMxpQ4qVcgQgTosDxdmYguogPW5acPtG0iTJ2quThszR/V9/Mql/yFEepp3Asyty7NvB26Tmx3j+Ucm4bRUJ/mb/brb0wO5a3tGnhtPLN0hJ03/W4bh8K/724ejUjAEK12CJl3S4PyCnWM2pSNRAnOo0z/34tOWd1MOeMtoDoh+B08oU5sazussp2q1RiUr/En3Nj56fDJ0qspcLhkTxm4tofXLyNq3ngPpeF6yklhPdl52mF0/nGHTSwwtUu2cY2xv6siNQvo4vn34HmNqJuAy8jz19Z9Xt5Gp0Mj/G+UD/45KYTL68kxN8h+wdG+nzHUFI6iF/+SbGjb1gqGdzBVuPCCvbGUB6cgPep3BSncCrxdxGpUAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73313726-e6d1-4e96-20f5-08dd07ec9af0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:18:15.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sdrATx/udyTeQ2j+bXhdn/r62RaKTdzucerfkxJyuXmBFuGO1ET3J+Tkiw3jg9az0K/Eq8bqbATo7HQknuffHuwHjSW63cf46sCs5cTqys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180135
X-Proofpoint-GUID: qGUQBavZK78VVyz307kCXBkpWgCsEw4l
X-Proofpoint-ORIG-GUID: qGUQBavZK78VVyz307kCXBkpWgCsEw4l

[ Upstream commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf ]

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
    function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
                            -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 mm/util.c     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a50bc08337d2..85ac9c6a1393 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -52,6 +52,18 @@ struct folio_batch;
 
 void page_writeback_init(void);
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+int mmap_file(struct file *file, struct vm_area_struct *vma);
+
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
diff --git a/mm/mmap.c b/mm/mmap.c
index c0f9575493de..bf2f1ca87bef 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2760,7 +2760,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -2775,7 +2775,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_reset(&mas);
 
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 8e8fe491d914..f09e798a4416 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -939,7 +939,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -970,7 +970,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index 94fff247831b..15f1970da665 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1103,6 +1103,24 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


