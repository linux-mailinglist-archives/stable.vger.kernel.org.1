Return-Path: <stable+bounces-93829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34309D191B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B72281C37
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3E1E5037;
	Mon, 18 Nov 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/JoWf1P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wxEQ2C/1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C731E282B;
	Mon, 18 Nov 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958895; cv=fail; b=gjJ3/O20C3k9zUxmytXV0bbN8Lse0JqLDPb1F+EpIbpLosKGFh9WLsy4j1+ufRWaaJthWoSMxq1IeVgGqMq24wfF0HDC6YIsirZHdC8GwZCNsCNep5LUOP6MFzhOThU1QiRVRHZBR6abttr7ys3v9m/KBMbuzw3wOceo1SUR4yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958895; c=relaxed/simple;
	bh=PM8TW0Tn3Qe1ylLPthRwNPiWgLM1Gcy5Pzt1/XCjCzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uD3mVCx9POO+jazgStOszwHCFQbBbnN+ziIAjMkDLyDW5CbzBVQykS4Jk4YWeSEM/ZLr1lc3AMEIddCI0phSF3vZF9b59pAsU2MKlRzE2SqKmtl/XL7CtCIKRCW5ZyHfK4ZLWp/thqpENdST8kJ9v6DhroXWlXJs3kJs7ST7bMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/JoWf1P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wxEQ2C/1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGU4C8005616;
	Mon, 18 Nov 2024 19:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=uHZb8Yvp8n2iUkto
	lZgGWVt58BkKJtZRhofsnmQhk2Y=; b=K/JoWf1PEv4g4MZtLMxREyG1blZjV05A
	i3rcLFQvTxBv6ynMOsKoRE3Kpre6NtoCZ4AhFiihtzLHlpkUJbH8wVE8S0HpW0fZ
	mfTV4JCCh4FpZl9by4g8KsApg3Q3M1uyenC1lgCSJfWWY3kSkIkDZcRC9x8sqN1q
	HCp9ivzitBhG1iVZHEO11t7hGeRzhp+jMgIkFxtwWy9/oTOXTu9M4jQCywqJKMj4
	54VhmKLIXb4CHt/WFOOEJjwel015KWpRpyu5saqrr8zZBFxyz+leveiDySu1kgE5
	XG8SvXzlfEqjaPF3D7ykX0d0IVRos7YFww4UU+jVwB85sljMHCi1sQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr1y8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 19:41:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIIG1tf037247;
	Mon, 18 Nov 2024 19:41:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7rhsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 19:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laTrVO0HeMA7lftRuaYs0lhOZ0/D4AGdY6KoR5bqaDV0UCRKW1+Wef0FEI8J5LVKAzEXoF9kYty/eVIaNY/ezp1lB+lpbBdT1J93aHmMCZ3y5M246R1ps1GS5+10HtIXNYcpAOYoWoXZNU4YB8JMZovhkOecoc0FC0Vrw9WjDPSO/P/n8AEEm4EzfV7G/XDks0V28EH2Esr25qFI5N5kRooGMnfG4Ki+WkRWg2SOn3W31DRIbl77DoQxrVGisoAn3ep06yIHF+4MSfxmQ5E3zwS/9q6L+QLTZifKACsmkqBTEY1+nEsmss6W63MjFUIiIzAASxjJtefrFc4Lh0326g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHZb8Yvp8n2iUktolZgGWVt58BkKJtZRhofsnmQhk2Y=;
 b=AL37BpU18Fypr4YNt9kR6v2LtRXLUm69li2JKD369QOns5CSE2XlrODuNOvnhFz6kAPbEtCFg1ChN8Wx/8w+vQPKUMe8FwfutW4vEbAY61hf4UvyzjzQoJZW/4HQrAfPPPV2JyGygF/UkHbGJ/cfwS0oLpQSaDuv8+hIElJOrZXyLnfJGFCROhbSsEr8gF4NqA1OIGnSQBpFCwF0BouMFks2XjjL3nbwqzPCEYJFbGkxVSWK6S2YrLjUjPhZpsl2FneJEY8WQmXKBaOHkTcna4J5MHajITKanTaEvfwPwsLB8KV29HFiZ648Lf2+jC9Hy+phIYx0A/4pSH/UKSvvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHZb8Yvp8n2iUktolZgGWVt58BkKJtZRhofsnmQhk2Y=;
 b=wxEQ2C/1ReqY/HyS2K7AicKbqkJK/wQf211iWQN76M577pcXTMZ1OSMpoEuRgM0etzx1vs8HhY5khVB/GMb4AYT6mmtMQUzqVzIlxIKLXROwLAXKBQqYRq9cLdlcU3G6QMw0xZ28wnnJHt8k9QlaMvIO0LMRMD+KC+Sh1A9RIFc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB5073.namprd10.prod.outlook.com (2603:10b6:208:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 19:41:19 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 19:41:19 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in rare merge failure case
Date: Mon, 18 Nov 2024 14:40:48 -0500
Message-ID: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ec565d-89c6-4622-1524-08dd0808f923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j4dJ5lVjTpvKD6QPcvxs8Ko1wtidzD+a3IUrC3IHZTZiTnqSjjv7zbTFwjjE?=
 =?us-ascii?Q?p+uqGIH0Zijz/IJeyvQafW+9GWt01l8KL5k/3eSxWyDyGkTIzU2vll7JqjRi?=
 =?us-ascii?Q?PG7W0+UomNyWCjPVN3iO8gZphsaP7I2wW6dyxZMzCiqXB/Cv/H5Zf//wstL2?=
 =?us-ascii?Q?V208kkrT34FVimyLNXuzcKjFxxAbm1ovQvaYK4bd8DgaLIRZ5fbM4GDMx8/y?=
 =?us-ascii?Q?L1ITM3TQ9YLC8kW7/gw0ZHq4ZYvFf9WY6pUdeaaQKOypKoIYbtF2D52YASCT?=
 =?us-ascii?Q?d6uPzYx1fos2Thh9kblcq/UYrIZVzoCYM4ACT3XT0XFRuHtYwBwM3KcO4YkU?=
 =?us-ascii?Q?Y9BgWm1AUFJUHGZCnVempL2DNcHizxxN0URiMdle7iNjMOqjpkBGt03ovyfx?=
 =?us-ascii?Q?55mJD1/UkA97WXoM4nIQ5O4MKpxIfFsvF6ZmCbjMX+YiPOs9x3T4ZBioYp5/?=
 =?us-ascii?Q?HmvuGE/WEGtggvZn/B4WzhRR5ThUMtoy86MM9waycr/NEeRGebq9D8PWcWH4?=
 =?us-ascii?Q?UXqOwnon0BKxv4D2r8MByt5uLkVRWuRWGO85idxgZfmL+Le34FoIDkayhVyz?=
 =?us-ascii?Q?eZWS/yEehLCY+AQTnG0sXB8f4tFh0U65HMtI2Gan5d8xVGfHI1cqVhcrA0o8?=
 =?us-ascii?Q?fXtjtHLoiNXTv7ScdlsicCG80SsyHzsh5MPNwk7gINfu/0Cm6Nt6bH9W7DUV?=
 =?us-ascii?Q?55+IqQaJQZq+W3adXbfxJN+eoSY+HdOVeyipXlNOnKZmF5XqhuJn4sfkLtxp?=
 =?us-ascii?Q?4PCmuUrOkootWyiu301P2ipfTJ/4vTXvxWUC5otFgOaUCnlur5t0TLRvyEG5?=
 =?us-ascii?Q?mTsneI8/fIw0gS9qFaDpnd7mmxA2/C90Rwue9CFP6KMYg3ta79f6W80PygiG?=
 =?us-ascii?Q?RjnZz+Q+3ISQ7QSds44MjqMEfIf1dP8jSBSfnULTip1WPwlMO2hD/tAwQ4AG?=
 =?us-ascii?Q?7xrEqxqBnzRobRqjdRpylaTDmG1T7V5vSG5phVcDiM+CpCjvO/65emhWTMvf?=
 =?us-ascii?Q?aKX38YqcWmbhB+a4nVluLAwMl2qyFxfVMHK/zqz4tSmeKHnKtkH34TapD5yA?=
 =?us-ascii?Q?oZlPfDl+fhiM1gTU1jNyLtakWv0HUGr5t5Vzuku1RbPyxJ0dosnda2YWJBud?=
 =?us-ascii?Q?U4cehfONyHfkHzix5kPlZMYwPbMbzIWROQa4roQ38bPNnr5bcttVkO0SY42q?=
 =?us-ascii?Q?EJGG9ztJJbPWKZYJMUIjOjE0zQ8TuYES1xOXjNCvSb0MNH9a6gt89aAviQ9K?=
 =?us-ascii?Q?KrEOVV2LCnvln6QiWSSw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XkSNwYkv0Jh9MaTcaBn4Bk2Vtk+n2Z1dAN/w/ZM71D4v0iVZtQTE6Gnh1keo?=
 =?us-ascii?Q?LmDesiZV7qLzoLckCtxPwMJk5p7tIprh4u1uKXdQRB0Vb8jT8YiwlOdoKmLq?=
 =?us-ascii?Q?EQDeYL9awhH3MazzyhbWRIR9YEj5ZLh7rxjEgYkfsdOzC3VvcoZ4Q1wCvWBq?=
 =?us-ascii?Q?OS4cahV1akuyqDONh2zGdK9841Gw6MmdFJCh9YM7+L0W27UND499kUfZ2ppl?=
 =?us-ascii?Q?wBw0E5m7ZNmikTrJUZRmbXoxH6nB6mjiMEO9XSr773btpwB0tPjPDV0MMz5n?=
 =?us-ascii?Q?f6cF9EJcHQT9AErp7SHH/wwP58kSM+7Yz9nsnoCeSsXGsYnexsvbsPszDKlt?=
 =?us-ascii?Q?vMiMwgwz+r5uO+wbpf3vBo+Ud13VyeHU72NhR9yTAP5/SuR9oCLpld9yZdXt?=
 =?us-ascii?Q?pgATRcWL30QWzi+cyb49+9iUE2WXgwUbMM463dPZMDkBV954cyebPgHnR0jg?=
 =?us-ascii?Q?fBTBsntnKTxhUBWBlJnonRQ/dMqwbvRN2//4ZLceeEnhjz6CUOMn2qZFvJpZ?=
 =?us-ascii?Q?5fEEXNqeC/9nKtG7PGzXEwJPdutxd6p2sjyKPeSODwXkkGSacmm5E2MWKpnB?=
 =?us-ascii?Q?Ou47ZhAwvB5vrNMvjR3FrCSJSpoaWQRCxFF6cQyQzK0Ky0yAEu8/a+kuv+zP?=
 =?us-ascii?Q?813qHs9tL63uUyySsOZw417DWdho0xbO7OgiWnmqY2i1QvXXjisJ/hVQ7BCM?=
 =?us-ascii?Q?U+MnP4Di9HGbO0RCVLRiwdfhbM4PTpAqBHtsKMVMG/qh2NskS5PXkCamCFDP?=
 =?us-ascii?Q?WvCW9qhs+uhJkkKdlroLKZ8EqT4PRRgN+Bu3G20uLe1XBf+dp1nzPNZnrz4K?=
 =?us-ascii?Q?x03ltV8tSKAjp7jmAZP74ROK/JukBfhgBrCN1gROoumwmk483DnDNXPzl0eK?=
 =?us-ascii?Q?bO4YZSfnnRxXcwccRGZZaTkbXK74nDpDqiyC+hyJbyrgYaPeiQs4AnqXVavP?=
 =?us-ascii?Q?x9sesCD10T8RAKbF/a1ccPZaTn8GpYEaAzOVHTvnoA9VllL6IYjUeEQzyl1U?=
 =?us-ascii?Q?vT+X1SlJ4uOh4zZtneEqWfIWFQcfIDszdBi5xvYfC0oWlXec3P+Mjg2wlhm3?=
 =?us-ascii?Q?0224k2mEoPXIozgIruMb9PWTinuYKB8fNLbIcQ+wd7w6cl0+ti+3GTYyuUA0?=
 =?us-ascii?Q?Lo7EFoLZAaJ3Lp+q0fH3HmI+2mqBpaJJXcq2Wvms1vWoVO1H5Z4UcovI93Yk?=
 =?us-ascii?Q?KwZGSDRr3TawfeEoqFYtr+b986DiY2BXg9PDr6fcWAX1PLfw3Qe4/jfifgdH?=
 =?us-ascii?Q?NzSKVfvi/nFBSctUEoVWMoVyYCMJlI/pmbCmVI7eGZ8+G7e1efuatYRNW2j5?=
 =?us-ascii?Q?tncY5EeTJ7sr6hHRIxzZO1mDZFIAtJiulINk9D+DEjjN+I3TeYm9OAN0N0cr?=
 =?us-ascii?Q?NtXWeNiREkwBFYAeHN4z/ry/yc3L+dkcaqAmDpv3EwjJHZi/rpEyxypdxeDH?=
 =?us-ascii?Q?+olC2Ux61OoPBxAXo7pt0Sl8aEjE0UXaNh14mERxhsoJ/8g117MFJBfa2n8V?=
 =?us-ascii?Q?ayBhGP5L0sp0UtF3IHw0XKHaV4ThRMkyfi1YnkClM+8QjVntAKP45BmIHesP?=
 =?us-ascii?Q?1RPoBHgz+PrrDpOgBtprkZrNoiKWSRJC/p3qZD7+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dRpc8boVzLlrWjT8Pz4gcYpeJKkmup2/m9PSPz7htKphwIOzEhU2JzV2z5K68ySasQLuaNFMHZ7I1MsjTS8eT26y3mEeXS6mOO+r6Cenj4/iQgD2vM8e6WUALlyMYVMIxNxKKBpeOdk844YfKjXCdWBY1uyuSLMP1JcfSCoOLh9pzSJXy6L+9Y61jQD5omuEjI2CSvRujlQw0avLq/0hLlkQ6J777HR+OmY/ywcKMt5rIIj7lGCJXvrzm9PI3mP5+FuZxvlygYA2MbDOrfwUgYU5qKkbZWyCLV2g4AhbEchHtqEEMYqQqWT8J+j8ZuPeCqD86J5hjgxKi4Qa4955sCS9z/LgGWB0NezkGGMMJm7K63bW4HpeXrmh8weaCeOLNn8GrM1kqZaBXYBLbvtX06fsh/GKvLkczRTlpgsYPPMSKiqzBdyUwPAyJkppUWndYysWhrz/XCg4lWxHmLCZNCXUOalYQ8w+nF7+DhlCKN82kZ/orddd9v6tlXSeNW9ZH9A4DYrgy1FqY3gjTymR2A1xcjD4rErmnASxUnJoH0APKd5QuacYOfvfijV/Gvq1qFNnOHlSJXx+e3QHd7xzbIJ74f15KzWE6WBVShJxKG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ec565d-89c6-4622-1524-08dd0808f923
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:41:19.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7yMb9NRUzQ6G6WYHlRqlUKN9t/L45eQBV7+XIxCTxK956OiY7gxaj5PF17xL818ckaCiEXU3ZcQun2cz1Y+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_15,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180162
X-Proofpoint-ORIG-GUID: 1M4v3zPBqjpDm-p2bdWW4z0afv39f4-y
X-Proofpoint-GUID: 1M4v3zPBqjpDm-p2bdWW4z0afv39f4-y

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The mmap_region() function tries to install a new vma, which requires a
pre-allocation for the maple tree write due to the complex locking
scenarios involved.

Recent efforts to simplify the error recovery required the relocation of
the preallocation of the maple tree nodes (via vma_iter_prealloc()
calling mas_preallocate()) higher in the function.

The relocation of the preallocation meant that, if there was a file
associated with the vma and the driver call (mmap_file()) modified the
vma flags, then a new merge of the new vma with existing vmas is
attempted.

During the attempt to merge the existing vma with the new vma, the vma
iterator is used - the same iterator that would be used for the next
write attempt to the tree.  In the event of needing a further allocation
and if the new allocations fails, the vma iterator (and contained maple
state) will cleaned up, including freeing all previous allocations and
will be reset internally.

Upon returning to the __mmap_region() function, the error reason is lost
and the function sets the vma iterator limits, and then tries to
continue to store the new vma using vma_iter_store() - which expects
preallocated nodes.

A preallocation should be performed in case the allocations were lost
during the failure scenario - there is no risk of over allocating.  The
range is already set in the vma_iter_store() call below, so it is not
necessary.

Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 79d541f1502b2..5cef9a1981f1b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1491,7 +1491,10 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 				vm_flags = vma->vm_flags;
 				goto file_expanded;
 			}
-			vma_iter_config(&vmi, addr, end);
+			if (vma_iter_prealloc(&vmi, vma)) {
+				error = -ENOMEM;
+				goto unmap_and_free_file_vma;
+			}
 		}
 
 		vm_flags = vma->vm_flags;
-- 
2.43.0


