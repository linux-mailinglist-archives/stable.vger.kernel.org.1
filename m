Return-Path: <stable+bounces-93520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B09CDE56
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FF81F23134
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6651BCA1B;
	Fri, 15 Nov 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QH9ietNe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lvhEGq1R"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8921BC07A;
	Fri, 15 Nov 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674258; cv=fail; b=LrNeTLRFTZIGLNS3I8rGqURzJ2njN/TZBZaNnZ/cQafYBW1QLdorvEqLbrnq7qhg3yOIGC+nRV2gxdcIQJreMK3NQo3eCxQo7ZpAS9L44011SQX95s2oahPOHLv+6EuXoBvFN0/aUqgRkSzdEnoDExn4FbrZ99pFZIIRujrzgkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674258; c=relaxed/simple;
	bh=3eBHKuaFDX5a3pUiw815zR3ygDwr3z/dKY+rzPBiC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7vxLe1oH/lNOFuQhgrI4YhwFyinqYWWF4z0yApN+5rJz1XhvqFrPTwehRXSTSTfpq9HrQYeQvk9IPO73wkGQeUQ3oYzHmsaw4KNqDJxj28Z72InCxOBenLqR8W74s2JZ1SKkR8CqN+mMi3Lz+XQJZ5EwMLO56lJYLfdkfMaQ2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QH9ietNe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lvhEGq1R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHHHN030318;
	Fri, 15 Nov 2024 12:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lcqVyGR2Ie4RX5B2PFQeOoDGKUd4H35f3scPpB+0CAw=; b=
	QH9ietNeyYDtg8505G2LIz8MqSlrqw+Yl9437iMoV7gSq4kWT3jHOtOnurJ9AnTk
	rYyb2/EXEiBv7fsXfPC5RtMP2Uasz+Unp7BENqrhQMx0UKT8U/c0yh8hEPYrjgIK
	crqg+tQu2MW7eXBrYzC4yS1D9WunSpi07Y+DoDegJPo5LcvsiK8adQuK2g8jR0/f
	EigdgirQQXoPnb2uHGCsRFRMvMOnHnCSA0OHpNdk5V+vSK6k1lm8uVTeDYlOAiFP
	QZVK9QP0VuiIxuteG/hod1fCYAI6Xf19V8EkERiQsNjxjwgN+W5GhRrEGpKxRj7T
	HsmjhEo7C5+vAQjYpdjSBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n539t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAVLFL000376;
	Fri, 15 Nov 2024 12:37:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbjcxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaqEsaUZBgsLeUMM5LkOvfUL1X0V5CxFVXUqOlD9L2zokhyuDlZ8FyF1tPGD/3odXltrQnmeQuznkxvEIQ/DM+nIJTawBnN10oSjrS25q+kZYV/7nNQXZhpVrgHGumXFm6Rtw8YjALQq+t2uob0sZh2SxSnK/U7o9I6p9ZwxjogTGhoRqKNNTRwjncOZ4nZb95RjcHSLKoqSHO+zHY9cKEQeP+nJoCdgNG6YxJq1ogtA9abCVgNU6Cas+ShfLo7jW/qJDKtD2Eyu1dgo35+y1npRPdJ/OUVRB7L/XnZj+3xh/1a1tSY/7fVxAjWM/3TV4y+mnKnUJQOlDJgQ2a86Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcqVyGR2Ie4RX5B2PFQeOoDGKUd4H35f3scPpB+0CAw=;
 b=pvZxGwJg3TZq/y2VySBIpk/zglY9RFm3CCQR08FZvMrEKJJ+2sexqOJ3BiY6W0GxmxV+2nJ2TwBEJvdsXFEBRZ+UYnTpNuBM65ZJR6Mre6Z/IOgiqnfGvkYcSLfNp+9WbuVGv7WzyXcKJBXyMAdlW4td3V6fHqrKetXjVeOyrp3+hpPhegw+ejQvgKVTgYoqOrl/k46vrnvHQZjC6c4v7Usz1Dbq1Nv2AGcizJ0N7CcP99QvhzKj5+Yg4zl+CLj7DJ0go6vXJPzqYFEUekwCi2Pw4h2Vjq3r93tDEdIZ1RbPKopkyoTu0Fnmhczfzw3rpqKgZWE8Ac1qoW2a3tvWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcqVyGR2Ie4RX5B2PFQeOoDGKUd4H35f3scPpB+0CAw=;
 b=lvhEGq1Rk+Rj9yoEYJwb4LiCbFo9ohkp6p0a6Fj4STZF6jVSIeq34OmEtBpEd4Iqe5ssTNo6fI5blkTEKx24Enz38m63yE5fvWjXYbYEfNZaJZYvUdoWrQSBTOXKJvq1JthBfDhYes5FUVcqeWWh3hW3ZpVZft1DjIPe/1p0oBk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:37:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:37:04 +0000
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
Subject: [PATCH 5.10.y 1/4] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Fri, 15 Nov 2024 12:36:51 +0000
Message-ID: <3a4ff9ebcc085e0074711ae883fa5ea11e6d7a8e.1731670097.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
References: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ca1d38-1a74-4ed7-0ba4-08dd057235e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JF9VHHAz8zQdXGfBOn6oXH598n+rDaDmCesiJTAtYy3e+0jhAFqwFhCZ88Fn?=
 =?us-ascii?Q?7UAm0ZRlM0YQSS6g6UeiRjDE0Z0Wj73HT2hlDofwBNmZLNm9uSsqRSU9G7RO?=
 =?us-ascii?Q?WvWpG4kkJpSNIdIlOy3gEiLoOeAW/uJeTlb4nplZxyn9jEG0H0oxED1hiN5B?=
 =?us-ascii?Q?amvtUJ7O0GQFfOTkqhuRuqDzwvic4J0D8P3lMvf/CItQBXSwJtIil75uPELR?=
 =?us-ascii?Q?cMxZ/5SLT/xiiub/+Jb869o240Ww15uh31DqJk4q9iB5J6mvVVgqQdny9BoJ?=
 =?us-ascii?Q?eOI5kjqobgYB+ZbIaMv73CzmfcST5vtnJGgSVkq4+dqhaTq06D8DjP8q+6NZ?=
 =?us-ascii?Q?TR56/nNfPPuYwRBmXxC7ZSufv7gHe/fDykOLPsuxO0cqCYGLVvapo57rabGy?=
 =?us-ascii?Q?lo6HoQ+GwERA7iHeRnxTGFB+KsiSecJGXMt76QoOObM3J8ZMcTYGQKCwFcfG?=
 =?us-ascii?Q?kcq/4Xwo1J33othgTuTlpDMq8M1VaLXwtiar1lxTUEmi+j8NpThdcSnxOBS4?=
 =?us-ascii?Q?5HtiaIExguuQcu1w3ialy2D5UEigaXQjtnBwoqkcWBvJJjIWNjf6jsCK+gE5?=
 =?us-ascii?Q?fktssQe7onJ+ZVwmAqItHTnHYRIPF8YkEKxOeCid0aARG1uMyRuqC3ytnJQ5?=
 =?us-ascii?Q?4+wttjZJ9bcK75DsQHFQlWRrXhx0Y6hr6AvkpVXZIZvpHiUFBFAK41ZDuizR?=
 =?us-ascii?Q?zljD2nJxz22hjY53NASb7SaSE+pNkyEYi3ZYhpbv90vw0nDn9dQnDOkMWMvr?=
 =?us-ascii?Q?N0iFED9/WHunXOm9TD48dTtHtNVYLUAK4fNDVl2cqjrmK7w+NiDuH+vzyDG5?=
 =?us-ascii?Q?2QVy3RO6qWb62ZJnaFPspQ7E52bpXSNwGx77LI/qF/V3UuvLQR727tI/Lpf1?=
 =?us-ascii?Q?1RAhmPMXF/J7oIlEs4YhJ2BA4NFtZC7IjGQMBy0H5gcN7NPdoxWLaCdVh78g?=
 =?us-ascii?Q?JQG69aNcvravigv85m+rvlzlYtR1B10aX8J0GV8QNfNmFVPCmaAcU2hgNZsx?=
 =?us-ascii?Q?iRmvtGSgeJtlVq4gxD1DsMdrc0xJ0u09IHTZVXOlH7YO+/ci8ysN7bj94Yg9?=
 =?us-ascii?Q?wJwegq42CNxS9OI2PIJ4tAfW1avzTRIXY9uGjxhtrYDZk+c0pHB3XuVyICyi?=
 =?us-ascii?Q?PxQPTL0MwOalfzIEYUXfdYg3nhkJ6XFh95IEdp2g4Z7r3mGtDQELWeD4hX7d?=
 =?us-ascii?Q?ENnRcJAdzn/Y78mM9Tt2gYRKz9UuROaGNoloxc3IIUF+kE697jDfUsBsw69q?=
 =?us-ascii?Q?t3GkB2J9hIEbHQZjj5RvsPkRKXFM9dCLu3Da/FuPBn39mtO+Cbzd5ACTFiCN?=
 =?us-ascii?Q?lCV062n7iNKrz6Os7/ECvQLy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqwdnypkYd50oxRvFhzJ2zeMXVjDISfDZbHeRsp9RQUaICyi0rDngFNUGq++?=
 =?us-ascii?Q?826373vjzQ9FTP9ELLNGLnjyYu7FqXyVbN/07TrxKUeqCuxtjdxZdVpKo+kk?=
 =?us-ascii?Q?ouTSo2TXIsF/XhVB6AZARZ7DldTSEAKpkYCU08cslNmrh79W0M59BI3gPCQ8?=
 =?us-ascii?Q?k1yUCx3VPx/VH95WYsMXG7+3i7be84k+WBqup4nxKT/hkn2+blXWnsH22E2U?=
 =?us-ascii?Q?7ozsG4wNN3I2TXR+w1xo3d/dcTngiZ1a9I+NCew9GhHYw9NgXzCvvn59wc6P?=
 =?us-ascii?Q?FWQE52fPgpGTNOTfeu6syazbuZi/nJaa3s58Rvdkvrbf1LHQIdqJT8nq25ey?=
 =?us-ascii?Q?EBixqES8hH1Lc1R9PmGWgwtUJ5lPm4uTCk83R36MPqw3hRd2AIHytcRVySAa?=
 =?us-ascii?Q?sXrg8VaQGLM1gv3azXBtugL426cVCPes3FtlNT5MVcf5jlrBKDqyZ90FuUoi?=
 =?us-ascii?Q?3MSqqPd3ICUrI5ZAmC5CPvFnoyvbNLK8W8Sq+PGP/sbYICtUC7q7SMJtJtYF?=
 =?us-ascii?Q?Elfdq/RepJ7zvMtMcE7vV1+jiUF2rpmBiWcMOhqRlpeaiB6OvxQb1lVCm/q7?=
 =?us-ascii?Q?PDNnnXC5CgtqH+ySUKglrFBf90zugbb/a2OeuUNSII/srv+lLMihWVcq8OAZ?=
 =?us-ascii?Q?22TIlqpyiDrltoRUiF7uQmk1hGSc+Gmm2QCL9SACCCaBzAYe0E2LorttFZrB?=
 =?us-ascii?Q?oy6JcXSsb/eWg2nk/RGIvhPIvXxmmWQa/5pdBmb2jZIgBv9FA6+31rC74Sl7?=
 =?us-ascii?Q?wAHDFgAa0XBhqPhck7KRZ1B+BzHdil8LQ6SpfpgI0hrVBCP1BAtTq+YntGa+?=
 =?us-ascii?Q?eXEiXTfnV4e6HhZW0XKE3MV89GEBZeKQeF7nmwm5DAx6FA3K5L0hWQQYKYZn?=
 =?us-ascii?Q?nSVsKcHxcEy8WmZVZuqoGItHkSQ1635qC4HfGrsHY0r1S/oytLdQGz8sAJeG?=
 =?us-ascii?Q?i3q3JtsvKIs00BlqWUx+1vnOLu01A0B0gUIXgqolLP/48jiF4kRgXQ9EFm94?=
 =?us-ascii?Q?XM96mkCTi3hlaej0COwfGWmHnIS3iDcs3TkJuR9y5srvTAxySGseLzN6KwuH?=
 =?us-ascii?Q?OLdtXQsA2pgoNOBm+5V0sT0p4LMNuxjfp2kz0mtwmnQ9lZidz2H0xUtGwG5S?=
 =?us-ascii?Q?tzX92tPd8hAdObtREJDCK5wE1CtG/3D1VMrakfxywL6nej+Y+ftHV77YC3zv?=
 =?us-ascii?Q?R6cb2tdqJ66c4UnhLl0nayptGQwNxShR73H4LS6urlcxMHMh7iKAU7lXLXOW?=
 =?us-ascii?Q?fkWhFtOQcUdgCoYDzPZ16X8HHhU81mDvbIpq+8MPMW0yGZd3ALUWctL+e9lO?=
 =?us-ascii?Q?3H93yY1fFOnuclfWSt5kVUvgJGbQGIso0erfSN6PZjTNTbtYS32WTu4inyPQ?=
 =?us-ascii?Q?yU3sliOZ20a2jcS5uKckqj460vEY7XhGMVSrwydAWw/VN83FthRQ+vdFCQKO?=
 =?us-ascii?Q?NerTKoGrGLL0BKOFM1ezJxbQRjvjGvFmeG4qbGEvTGDH3pl+XzrBAIG2yOZ3?=
 =?us-ascii?Q?0XFtHqZWuoDjEb8Cf3bvsCkkoFaLzj70m/1pMjIj93FYVAwr59kqIvxuUpNn?=
 =?us-ascii?Q?PuLHOVbEPg439jUcTifUkDs99zeBik8zGXguS/Tpa6b09PjyAOzNRorQwrBa?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6YVoWqV6rPXkYHEFm/efmy8Zs6xf/bkVX1x3Env5Sgx4u8Tyzb+g4CW5mgODz9wEmLTIN27SpWHzaIWYZLoMtTXAKtkUxErjxZxTNYOByIoP+/jy7RNFZ0/UNdPna9CU0NERHnwvAIlzGwipmdvFvUn8oU5PRrAbPirTY15MiXjykotTy+Xupzd1jZjOC+yJ+Lux966+qX7Dh6cxdY3kWNyzLINW0b8ecQzKNv5beB0ycpwCX91z80K1lL/XWRiQHFMEklrs4FqU3oKXj+56vcg0U5dpQbDhjA3LRAyLWD/Iq7DnZ+yr8Z7aLxu8Bshqh045K38tkT+UO6RH/H2ZqEWBNcSI0Y462Ewrtp1hnWjBcu+YT48n6lr8Qz/ul8DtNx/xz3nDZxJW+PjLuVXVXwps+WtXOfJQb3F2SkreKLG+Lpg0bFKpyLFEnX27lvV3bmFBNHAq1ySjGW0fh7ep9etOwup45U8SzmCrPNP2kEpTZy4jb+ypHb9aQiWKFBArnC4vXevS9DVnIylKnJB51Yuu8I9dwB4ce1Pj0JcFkBRrFgX0AzBhwT9qU8NkKbCxRUjBdkW99yHWBexrNCSVwuCaOj6OC69z8qs5BzzImUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ca1d38-1a74-4ed7-0ba4-08dd057235e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:37:04.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfCQAmEElMFrFzd+lKA2DQ1yCaIanAMWmiI/0Jp1PtWx7rVWGNM+wrXpBhdCvV6qT9Nhf9OLHtsj/lAdOSNpED/UDHTGKT9dFZ5KCxFDBtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: dNe-1qRMSXA8Xw9ueu8mH48DW-0ogJiM
X-Proofpoint-GUID: dNe-1qRMSXA8Xw9ueu8mH48DW-0ogJiM

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
index 840b8a330b9a..e47f112a63d3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,18 @@
 
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
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 33ebda8385b9..f4eac5a95d64 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1808,7 +1808,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * new file must not have been exposed to user-space, yet.
 		 */
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1823,7 +1823,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		addr = vma->vm_start;
 
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		/* If vm_flags changed after mmap_file(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 0faf39b32cdb..fdacc3d119c3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -955,7 +955,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -986,7 +986,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * - VM_MAYSHARE will be set if it may attempt to share
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		if (ret == 0) {
 			/* shouldn't return success if we're not sharing */
 			BUG_ON(!(vma->vm_flags & VM_MAYSHARE));
diff --git a/mm/util.c b/mm/util.c
index ad8f8c482d14..8e5bd2c9f4b4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1073,3 +1073,21 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	kunmap_atomic(addr1);
 	return ret;
 }
+
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
-- 
2.47.0


