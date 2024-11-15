Return-Path: <stable+bounces-93503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AB9CDBDB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFB2283633
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC2C192B81;
	Fri, 15 Nov 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cguZPUhB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LzsA29j2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850B1922DD
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664299; cv=fail; b=OP3dF1w70joJlV5Uq1FwJjchEI2vEh+vrIDThZcPDXejHnJ2wP1D+D2kkNYsBOwQEfqAEj518Ptxc0B1mvV+NOsN7bvJL7n2J05vPjuQXRdrunXPAOr5dyPMjDnqJ6fJTrY1xu0L3z0Gu7lID09rfRFVp6271DfP/zdt9puLO7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664299; c=relaxed/simple;
	bh=qxf3DQLarYgopQ/XI0U+A9WmCDeTL+Xc2awKI2/mg7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TnQGFAtSD6Ok8eADhL2T8pohkrFfPxmXwWg2Pf7zFhzBSHQ7Wl7yDYCiEJPIDzN3zmd+wWOEgGXrikOQ6JmNOOsEGy1VXpU8EJyKpDZv/qMRIDywVbOb6DAh2kQ92fOEPoECIQnEYhIH0eqvgvKkDf2rf+oVI5dHGTCKY/Qj7Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cguZPUhB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LzsA29j2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8v1qb001552;
	Fri, 15 Nov 2024 09:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=sZ0YEFrDANXEsrd1Cf
	SfqfTC5ueYfn+ts5jUqD23Zmo=; b=cguZPUhBkgqLuY9zLRe1uM0HSD+7Ovys+I
	s686tZq+tyDRNp4i8lMerm0F4HYJqqZYNfUsMNbbzkKc941hgMY/3UcZT7nDORpZ
	ErfVCtbOWCWfe4mJApUWHrJ6cwfS2UQi+IG/RxbAf3v+NRoa8EJoWTzhDqXF/1oY
	5U/RYPaT1751WEFgrgO+ltbuB34Cs44LoLl0a4JZbU2Lh5qxeoN2ucTticU0ZZEy
	0Ec5nIOtQoyDNAzDBRYHykdeydEsq6othv0D1+ul+8bGpdZBT3svP8nlErXae3UH
	Y84cy379aRk6dgD/PS112MqRkUVKh7ON9dwsRdN5GiSxB1UbP4zQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hety4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:51:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8tcth035969;
	Fri, 15 Nov 2024 09:51:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c03sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:51:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MW6si2Fc4UOvKd4jQEqrbrAlZifx6zvQt7Wbz9sv3Pa6QghqLdFCUyvmFt0WJGXYbkcpBcGu4hR/6KKBEcVuxQ3KcvLqizbXfpBpWwNQmQpBw258BKk45xOjs/n/PsnlRzSiWVlkKzPyf1EXbm+JYCLOzF1vt6OeFJ00+IiJqVRNrX5e+ICZXEnA0NEaZJuBnkXQ/WydDTqmFpK1o1X0pvS8GA7obTC0I3qQHcgBEFJqKU8J66LeULtO6Cc6OFgSB/w7ePnHbJ2wl5LN4pxz4Ttt4i2eVsv2nxW2zsN6UI8ZawRPuYqCzGk+NrB9MMAkJ7WAeW90InLneFIf6hYHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ0YEFrDANXEsrd1CfSfqfTC5ueYfn+ts5jUqD23Zmo=;
 b=KcQb69PlcIdanwvjL0ATCBl+eiCp3CZiB8f1SghnsZpGlZwm0FB41aOsiIosAaonDkW0dy2sCm8vvUWv63BcZkWutMBwy7ON0UogGu2VHRl6AolbEWacTzqHeHjhlBNevNOd3teFL4cYcjh0xPeHdb2rYpRmENtg+c3ARw5iClk2NvrbzlkGttWWK6WUdkynZRlRWt61N9fpggm4SP1tes2JZtVeMz9pnJVMkqcSZBBlT6jSlNxa0gPWIFwnoREHJzbAfZyTq1bOikqXeLMP+PMjDcTZ3foyYy9cOI6lahSKHskh0ea7JMEtVZ3GdJcFKcIXpj73kuMfzPpdOMOtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ0YEFrDANXEsrd1CfSfqfTC5ueYfn+ts5jUqD23Zmo=;
 b=LzsA29j2YmfWoAft9R1AsVnBUXsgqPnxa+3NyDZQVsLA+SzUwW69x2gJFT5P+0Chg4F7djYxn2zwMWAzhVx7ed3iV4NlS+Vfv0nptrLx6tZ1wmEMM28io7MmLhcG6Os9Lwpo6kVJRetFn+8aUiWqd/Ck2tRKVjKOTBg1I5ZyhuI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 15 Nov
 2024 09:51:16 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 09:51:16 +0000
Date: Fri, 15 Nov 2024 09:51:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm: resolve faulty mmap_region() error path
 behaviour
Message-ID: <7ca7e682-eba6-4c6c-baed-13e95b895bc3@lucifer.local>
References: <2024111151-threaten-calamari-7920@gregkh>
 <20241114173032.731265-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114173032.731265-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: cd258296-1e7b-4f5e-2da7-08dd055b0c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jlMJgrMquQOp5v91TfhKzk8w635zHAGso5CU7iio02Q74A7tOMG7LqcWvzDz?=
 =?us-ascii?Q?UAoLx2Bz75jhzpvctr7H1NYj7AhXhFIJB3PUd9LAilDYcSuKJqbAQE9ITOKK?=
 =?us-ascii?Q?2dpluEk8QZWmMVJdLPIyw6orCLr/Mp1fVtolxva1acFpWTZaeUlkAoXZmvg8?=
 =?us-ascii?Q?zMb/4oqcZ4qsovnnG8HyEk7q6L2G7QaDBRoB8NiwImWByo5r7TsBy8J+Iv0L?=
 =?us-ascii?Q?Pvz2lhBF+YrppDdCF+UWHFhFcboIKonRmMV0k/ZEfkPrZ5AUROqKAl9ehUKS?=
 =?us-ascii?Q?n8L/dTJFZ+Z6dkmRHZEnLYmfK/IIOTGL4pEq1wuy/1OxqikmzPTn7bWyFTzP?=
 =?us-ascii?Q?PIHJ5PRxpS49vnl9bDeDRYBlP1a+QvbXOBinqnFdfOTI+s6GnOANEWvfhAO4?=
 =?us-ascii?Q?+fl/6lV3knGMeEUoBkueV9gRVxDbuR2n0SkYtY8USIy36n6Gq44qsqFecBSy?=
 =?us-ascii?Q?FwFCIt31THTCSWF/lzBxfWCwQpGa8W62ywv1UQ9j85OmJG0GmJnfAswn9OI0?=
 =?us-ascii?Q?hwpj9PMVj4sPGih6WJjmrwQJIL8jnj4a3aPyoisD6xKxRQ4Mrj4HxvRd4coG?=
 =?us-ascii?Q?svOOaUGrVaahQEuL2GMUKYpef5DEEoki9PdZajmSQD2csbyxaKs4yxyRFLQR?=
 =?us-ascii?Q?vqbSxz4jtGhDZWU+jOX+mlvmCsFoOqNhB2ccWIjzev7aFIHpGEjPylFn/9pW?=
 =?us-ascii?Q?22MEdesXcQ+fS7uxA2X0mPvZEMZ/JDLL5ZVQde8pPmSRV1MNiF0MebQMhpLv?=
 =?us-ascii?Q?mC7EER4cQdhTvZ82/6RnUxUbwEq32MBluZCc32+v2mfMnOb1pdD9qTnIu1zx?=
 =?us-ascii?Q?fgAhQvE5acF5jakTZtv5hIEORnG2OS/tDJ2CRLVYx//Q09khLmEKQTeyM5aw?=
 =?us-ascii?Q?Lm9fUCJZoh/0WiIAhuMTjHWjXqPEpoEt6+PN08wk++mG6RwaU0PMhD8bf/fH?=
 =?us-ascii?Q?uyIA+pTHxdD71lFiUTpRkLcom4F3axf6cSxHejBoH544hbAgWBRp0pKx4fLj?=
 =?us-ascii?Q?Au4dPphp+8xYXQZuWoyFQ1Go5Ufld1KK1n2EFvx7ibEowmsDKf62tWpXl+sh?=
 =?us-ascii?Q?MLOecto0ArxyBCgHxCT24T6PJWQ3nS8jb4E2llued2yQI8z08X2iAmQOzTfy?=
 =?us-ascii?Q?zkH66UqIs8Y8WmAlMi7E8riGiyNXtQPXc3CNErSXFt9htNfDlY7mkIMSdHEd?=
 =?us-ascii?Q?niod+OiGy+sSjpo72G/YmQ7X6pH5ewIpd1o2EhuKd1CR9MzSDO3uZVb9Td/c?=
 =?us-ascii?Q?TN/uAY/dJsMlj2eIm13spKY0R+/54Fx7eq/EOqopi2tsYFApl3Iw08Vpb1Fv?=
 =?us-ascii?Q?v5F1M5mJGFN4mOB4BA+Rn6+b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpqeGVIJnPf1dGHn5UAlPmahOK2T9Rwq6keL9ES7ynJS4E51vKEdQ/3OOm8L?=
 =?us-ascii?Q?UYc1dycmnkZB0SIptf3kEENPVS+kH5L/Gw2blKUpxTv4cvlLCxkkPEYd1AB8?=
 =?us-ascii?Q?bhybdPSaQeTU6pbKrXuYp/6kL5HPmdOC9dO9lhKJy49bTSxXwXzuuF6YpD69?=
 =?us-ascii?Q?KLxp5y7cGS1x4C5G9qNB1KKbFgzRIFclXNn1LtatXwvCVjZc/CaS4Nzas4wO?=
 =?us-ascii?Q?gEtShoJD6sB+o/3gcqrSw1/2SUV5PPt59qAUMdJNx3f2iUcARQ+S8j18YB1Z?=
 =?us-ascii?Q?+C2M1kZQLtezUJJ/V4my05xAbI84QB/6aHR3PMAkF1Hw4Yobbt3iQYK5Nprq?=
 =?us-ascii?Q?Nm91d0fzxL4zIDDHUdMJGFNdG36Aa7mhCyGBVteaz10Uj4Ifbw6lbF6EfXYT?=
 =?us-ascii?Q?tVJuF9z2cbcjusgvTLttp5gngMhGfS4yHr7DbI2PImDkreWFg4hBwb2+f7HF?=
 =?us-ascii?Q?8z9/543TQoYMKR4wXZ7og/RWTicb26RXfox+rqZWk7vXjSIsR/nez6fZJxMs?=
 =?us-ascii?Q?8/thEh+2lIlN8kLZ/xGIbrUyR/QGP7rDJkL408eKBRCoHAay7fh/hxkp6GK/?=
 =?us-ascii?Q?++ZKnVuHmrW3jrbUkXqaVwXgj6O3SnEx8Dt5yqobsMnYTTxoaByxpUq3nwzz?=
 =?us-ascii?Q?FJ3uE5j0UjBnZqKYqJ2GsVEdt+8/gMjwRTVWFcdjVf1CCY9V/hcU9CuTE0PN?=
 =?us-ascii?Q?sbPje4jdmopWpoP5qnMy4syDP7LmcoAItaDKP1Wt8Ybgri9eAyOHG5ug7q4e?=
 =?us-ascii?Q?DHWt706R4YsJf9mAsKXiAsIRS9CIfYcrFrhmLroLwg48L2T3/VnT/8i/4r4Z?=
 =?us-ascii?Q?ll7tyvQ0Qk8yzv0tk0jUzR4x/yh+EKylNjTdZ50v/sIpjqggmiTgFPSl40Xt?=
 =?us-ascii?Q?HLVY1WxnMYHNbmVLuZ5X++Oz5eOufuj80En5FaPdO5Ihwjp9MB6F3IaNRmQG?=
 =?us-ascii?Q?LZD6KSdaDYnlPsepGvj1BlWdMLyYk0FPV40bFo1Ll1ZKPAPyOmnrlxqw+EwJ?=
 =?us-ascii?Q?B9YG+57Lc4IBkaDcmwdwGwQDOBDkB7P9v8t3BYugvzvjTbW0wc4L0yiFpfpO?=
 =?us-ascii?Q?gct8fFZngflh6Nd6gZjHlmxXkikbhER0B5d744+pc69cptnec5h9zxU96N47?=
 =?us-ascii?Q?DShD0bnnsWmuYgu6Wpsdo5LRHzEkFsakEC/X1vvBtXszcdoW+pb0HdHZeTQx?=
 =?us-ascii?Q?DMZc/Y0StPdGoWxvZZZ+CPbq8FAWPWivNJcqwuBkbBjAXppoFzP8iLTlboSV?=
 =?us-ascii?Q?iZlQV4zHPFrPUJlmRF2e9R60E3ZtgCcEhRSIGGkeuWzt81e7oUwJbyw/N8me?=
 =?us-ascii?Q?CjX+5NheLu7F4aur4qEEhgLIm3DVT4AMppOFoLdIGux9sEoKygO6Wv7jYGq0?=
 =?us-ascii?Q?oLO8qbhNIKeYkPhwjxrLYiBLt5CKKH+lI8DEK8LDKtmo3CWPjj3Q7NhNyHRr?=
 =?us-ascii?Q?yBNeWlrr58U/dr5og6Fyy8Sb0cJdIcAviDA4dJHPoDXau6/wJuFinAJrX2S4?=
 =?us-ascii?Q?sJwbhKqEUqhhQkkvKzsbR9VLQmlf+D29oaNU6z0h3tIdNnc/cIfI3kwdzbXL?=
 =?us-ascii?Q?IGO8DihY1JDco/HhmS0u+6d8fgIu7bh2RfZixpH4aOd2QjhK7wQibn4htU/B?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3sl0Ur2I5ufnAlRuEINoBtX32/X87vYj/THLhvqPUpi7J6FqevoWzEyKVN3eMp99AsSliXaJijOgMgaXjzjgl1Aj5jv8a3bEJRS1Gai5ULkt4tQ+GyMYEFw3/tjXLHQmEVhxpY8L3NfGc/EuwILg6b2LiXk3u9SAUz0kIQo/sxco2dZsTPW1AVsl28199FG/nP+mXer4ahTbGJZkz248NaGEs66KYXTv5B2nW4OAUdDsy99y7X9NJum3dGkn9KNsk7yNvvk3gwEdmUDPJ5RkAuiUxoeEMl4sKctgQndr/AeZQSWh5CQuxtCpt9BhqPOKZEfuxS7PWUZEdhA2AVPL9cpZrADeaIJBbMGWhl4zyfvLLMqLiUvMfezBahmvWX6nwGKtltZJ2rnqKd8JyUGkmsohMeMHn2UFe/sKpbwdrL6NMBC5I+p0ZkdQn8yCe90Wl0YSjyOBCmt47pul2sYpaCkB1OzX6VI3OUkwj1es00DTfNs1cgjSBh6ApCjwxLOIZd3Cgp+E9icEB1fYhF6OKWo4qBLH/oOJs67ZQRSYpmdYvCw1lXuJTJR4oFUXxWiDj6C3dbDG6TG83ZfkXPkwjaQTUPcbpkHmz60C8RlYMao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd258296-1e7b-4f5e-2da7-08dd055b0c3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 09:51:16.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8a44mg6vRDti8fClBnr74eP6r+eL1lPBaIewH9sEDAcCZnk1gVMyoZkTjHUTaqoUrIKsZPLHiWy1ykyyrJH07Pq5zfAq3cjkegDJVIYmGUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=856 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150083
X-Proofpoint-ORIG-GUID: ynMLODVLNfk0XfxymJ2nJ6jBe8Fg-d3a
X-Proofpoint-GUID: ynMLODVLNfk0XfxymJ2nJ6jBe8Fg-d3a

On Thu, Nov 14, 2024 at 05:30:32PM +0000, Lorenzo Stoakes wrote:
> The mmap_region() function is somewhat terrifying, with spaghetti-like
> control flow and numerous means by which issues can arise and incomplete
> state, memory leaks and other unpleasantness can occur.
>
> A large amount of the complexity arises from trying to handle errors late
> in the process of mapping a VMA, which forms the basis of recently
> observed issues with resource leaks and observable inconsistent state.
>
> Taking advantage of previous patches in this series we move a number of
> checks earlier in the code, simplifying things by moving the core of the
> logic into a static internal function __mmap_region().
>
> Doing this allows us to perform a number of checks up front before we do
> any real work, and allows us to unwind the writable unmap check
> unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> validation unconditionally also.
>
> We move a number of things here:
>
> 1. We preallocate memory for the iterator before we call the file-backed
>    memory hook, allowing us to exit early and avoid having to perform
>    complicated and error-prone close/free logic. We carefully free
>    iterator state on both success and error paths.
>
> 2. The enclosing mmap_region() function handles the mapping_map_writable()
>    logic early. Previously the logic had the mapping_map_writable() at the
>    point of mapping a newly allocated file-backed VMA, and a matching
>    mapping_unmap_writable() on success and error paths.
>
>    We now do this unconditionally if this is a file-backed, shared writable
>    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
>    doing so does not invalidate the seal check we just performed, and we in
>    any case always decrement the counter in the wrapper.
>
>    We perform a debug assert to ensure a driver does not attempt to do the
>    opposite.
>
> 3. We also move arch_validate_flags() up into the mmap_region()
>    function. This is only relevant on arm64 and sparc64, and the check is
>    only meaningful for SPARC with ADI enabled. We explicitly add a warning
>    for this arch if a driver invalidates this check, though the code ought
>    eventually to be fixed to eliminate the need for this.
>
> With all of these measures in place, we no longer need to explicitly close
> the VMA on error paths, as we place all checks which might fail prior to a
> call to any driver mmap hook.
>
> This eliminates an entire class of errors, makes the code easier to reason
> about and more robust.

For avoidance of doubt, NACK this and the rest of the 5.15.y series, will
resend.

>
> Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Mark Brown <broonie@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5de195060b2e251a835f622759550e6202167641)
> ---
>  mm/mmap.c | 73 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 47 insertions(+), 26 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a766b1c1af32..f8a2f15fc5a2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1716,7 +1716,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
>  }
>
> -unsigned long mmap_region(struct file *file, unsigned long addr,
> +static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
>  {
> @@ -1780,16 +1780,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_pgoff = pgoff;
>
>  	if (file) {
> -		if (vm_flags & VM_SHARED) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto free_vma;
> -		}
> -
>  		vma->vm_file = get_file(file);
>  		error = mmap_file(file, vma);
>  		if (error)
> -			goto unmap_and_free_vma;
> +			goto unmap_and_free_file_vma;
>
>  		/* Can addr have changed??
>  		 *
> @@ -1800,6 +1794,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 */
>  		WARN_ON_ONCE(addr != vma->vm_start);
>
> +		/*
> +		 * Drivers should not permit writability when previously it was
> +		 * disallowed.
> +		 */
> +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> +				!(vm_flags & VM_MAYWRITE) &&
> +				(vma->vm_flags & VM_MAYWRITE));
> +
>  		addr = vma->vm_start;
>
>  		/* If vm_flags changed after mmap_file(), we should try merge vma again
> @@ -1818,7 +1820,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  				vma = merge;
>  				/* Update vm_flags to pick up the change. */
>  				vm_flags = vma->vm_flags;
> -				goto unmap_writable;
> +				goto file_expanded;
>  			}
>  		}
>
> @@ -1831,20 +1833,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vma_set_anonymous(vma);
>  	}
>
> -	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> -		error = -EINVAL;
> -		if (file)
> -			goto close_and_free_vma;
> -		else
> -			goto free_vma;
> -	}
> +#ifdef CONFIG_SPARC64
> +	/* TODO: Fix SPARC ADI! */
> +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +#endif
>
>  	vma_link(mm, vma, prev, rb_link, rb_parent);
> -	/* Once vma denies write, undo our temporary denial count */
> -unmap_writable:
> -	if (file && vm_flags & VM_SHARED)
> -		mapping_unmap_writable(file->f_mapping);
> +file_expanded:
>  	file = vma->vm_file;
>  out:
>  	perf_event_mmap(vma);
> @@ -1875,16 +1870,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	return addr;
>
> -close_and_free_vma:
> -	vma_close(vma);
> -unmap_and_free_vma:
> +unmap_and_free_file_vma:
>  	fput(vma->vm_file);
>  	vma->vm_file = NULL;
>
>  	/* Undo any partial mapping done by a device driver. */
>  	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
> -	if (vm_flags & VM_SHARED)
> -		mapping_unmap_writable(file->f_mapping);
>  free_vma:
>  	vm_area_free(vma);
>  unacct_error:
> @@ -2907,6 +2898,36 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return __do_munmap(mm, start, len, uf, false);
>  }
>
> +unsigned long mmap_region(struct file *file, unsigned long addr,
> +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +			  struct list_head *uf)
> +{
> +	unsigned long ret;
> +	bool writable_file_mapping = false;
> +
> +	/* Allow architectures to sanity-check the vm_flags. */
> +	if (!arch_validate_flags(vm_flags))
> +		return -EINVAL;
> +
> +	/* Map writable and ensure this isn't a sealed memfd. */
> +	if (file && (vm_flags & VM_SHARED)) {
> +		int error = mapping_map_writable(file->f_mapping);
> +
> +		if (error)
> +			return error;
> +		writable_file_mapping = true;
> +	}
> +
> +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> +
> +	/* Clear our write mapping regardless of error. */
> +	if (writable_file_mapping)
> +		mapping_unmap_writable(file->f_mapping);
> +
> +	validate_mm(current->mm);
> +	return ret;
> +}
> +
>  static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
>  {
>  	int ret;
> --
> 2.47.0
>

