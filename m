Return-Path: <stable+bounces-93539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A448B9CDE83
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1151F22F40
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7054B1C07C6;
	Fri, 15 Nov 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVCXG0jz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WMPMPZVR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8A1BC064;
	Fri, 15 Nov 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674565; cv=fail; b=E3X3SF7JCyZNnNGuZ86YLBO56GtevOZwc2mUbdL8iz5XqCk4zN09LCzRw/RyFEwfZ/Pu3XzNL92hKSHuxwhEWjGsFfEJrgfGtyvYpeFuF7LnWixkvTV0lOn9mUJL5TysOjAOaPYNZ6bXnclaQPj8HRthZmcSn0CUcwiyf9Kk4Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674565; c=relaxed/simple;
	bh=uLQYpBq1iO+Mf2/e4Id0no0b8V9EgNxCwufQfycSqrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hErf1gyXS5RigjdRToGbbmWG7cyImSIDzFvmaBpvbO3neSQdf0NSCRxCGofLAwValdo6md0ddr2xBuVTYXBDaHti1071Rz389FLrnSNScKJKuxxriw1rKe3YY9mD6Jms3i6OGZmkFbmciRISxl7snlW6xPsyLUbgSQzpNtLp8QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dVCXG0jz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WMPMPZVR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH0Gr014175;
	Fri, 15 Nov 2024 12:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0TwxBJSLcC4galjZladP3skso+2UgAA4dyxp3qrUK9g=; b=
	dVCXG0jzMDL0qrPPbJBQYZSch02bxa61nvtDqVwb1R065qeNGUlS5dyDb7FwC3px
	V77ov7Ja6Ukx/HVEp45Xd/5Py/EIOMf80z6Z6c0MDmZ685CY6qxMDwXJ6Pppk8HA
	JLkLFrrZsNEGmxyeYgCX+EdvdaZ3pOdCgV5WE+VpCuSs72MIL60vkO1A5Bhzxcrk
	a9VoFjV+4+KSQh8LIoEaFwYtRpseEQWPGk+jl8zgo4h1s6DHPAKTafBRh1PXZKql
	KbThgQnpfuZUdzeRLV1XkK7164KJ3CHdAQ+ynD9im+Ng5ixFXmhwbf1/FjreR9V6
	K50CloRg6B+fTIyQjc8YAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5k5yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBtqeb022740;
	Fri, 15 Nov 2024 12:42:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2mtnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t52z7c01UOjJ5bJ/324plUaSmuFrQNdInzxtI8jUAVRzv3hcaGPqJC089Q3me3SvF+2tYao/9seGFdzYCsQCHmYVrNke69e0Eazy5ne4xT9PSCYm1zlJcDBFCU4J1PJeej+LlIESb9MYY5obHB9aPoi1icepcuemZ3N3tXs71DyN6/g+eIh1ijjBcYAV4zYkYcF8s/LIZfPhlyzWBEyaVahmQUqI30R1/O9k/1gPcDtUmNamBQpBHuZyZHTMeX6fCkz+QNgPFGOMON+sQYte7yJ8jOf7lHijDNGuKKAdo7G2OlULBVodwPMHrJNwC+gXsKdgEQ7epmsXhl9QMOStug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TwxBJSLcC4galjZladP3skso+2UgAA4dyxp3qrUK9g=;
 b=OWxZYKGpN/CDYuE/kGLCM4RECBkkbeyoM0zm8Kgpy8SRODSp8PWmy9M1iMAgoH2VAryKBz95BY5lDa8yjfJD7DutLnuaxfZvZoBoMz6otOcpluk/Eaw6JT2abfieIdP/9KMVeyahg2z3OhV+kO9YpilN7isaYp0+8rB4zBuyaj653ZMlo23oeUFYLwys5TWu+qgAaLI/5UJFosYwyVJAqD1txhJJHHT/8f90rHy0xXq8iGKSSpnkQE/LbHebtcY9b4J4ZLbtvWsr7ZUwtny//jdCxJguMHQ9T6qeiEfbUzSGtMPq1QNB3PYzGnATCd6+i4y1gLMJJM1bWNG2xgGT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TwxBJSLcC4galjZladP3skso+2UgAA4dyxp3qrUK9g=;
 b=WMPMPZVRMbgbO9pCwuNHV1QAtBblWk1x4KxscvLJgI7hAPOT9E8Lzou+ghMGGDfwrp4SJkUKKM2aQXibirFjUYXBBIc+UBveeMduunrxnSAMkX3RuFKrWBABs/DFxpw3yr/DY0dhXbmhKNnU3yd0vwqBBZThdmWNnE68LMQavi4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:42:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:42:19 +0000
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
Subject: [PATCH 6.6.y 5/5] mm: resolve faulty mmap_region() error path behaviour
Date: Fri, 15 Nov 2024 12:41:58 +0000
Message-ID: <b71c37d3a8b40fe1e07a085101f17b77bf293039.1731672733.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: d4067e71-2fa9-4653-36b3-08dd0572f166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnM4R5DjMiLmA+papYF1WUsA7g0XnYs5natgwjGSpp/3bpoZjUYn7qiRLm1V?=
 =?us-ascii?Q?kWIPQQXmh5fvBZfXx7SXS4cfgrwo0+ojM5MFpjDIkqDATouCTliRZwAIVdhv?=
 =?us-ascii?Q?RbaECLcbq+aTb+aERfsrCxq6H13GS9HuJ2WRgddcrRm5CQXa7WDQt/ihxDD1?=
 =?us-ascii?Q?A9VJ/4f9QOw1+PdG7BI2OPve08jCUgWGjoA7hNNaOB6Notbb9mmaoJViaTRZ?=
 =?us-ascii?Q?GkzYgdPrp1KKqca4llrZOWAmdlBkUVf6Iv3EaDctluuMyUCWer+OwbQx8RFo?=
 =?us-ascii?Q?wauTrg0VusWC6KvZiXULy5Srgsn0chOLL/cVn1GsnQeknTYUcX+z7vz/Sfv7?=
 =?us-ascii?Q?xi2+mShzegwNlDtN6jvHQr2wZXx5PsrLw2bGt0/9Yn7jlalDLlwZ8MOZe/lD?=
 =?us-ascii?Q?s35YACtKvT5hQA13FapobGtmJRo+Z2Fny4VE/0vtvPWMw2P3bkAa/0dhwVR/?=
 =?us-ascii?Q?YtET+mkyt4Bs76kvyeEAMtlKKNY+hCCMi13LRd1inKdH9kt/PAxA5c9dEGkr?=
 =?us-ascii?Q?Kx6TqOYknDCwVVOOgZe8udPhC8RAsbvjwngSKLT5zJ81XWMbIQBtOpnP5oGS?=
 =?us-ascii?Q?t8jksqWzj2q0Ae9TrhqW0BFc4CuxVZA4SkRIPOlyh2yb5DA3ZJcFcLVOF1Ni?=
 =?us-ascii?Q?zP1jr4/zDfwbbcLPlptSLRbZZ+IMlE070gB/KiU4qvKvdrfXCg7ffdJh6pRz?=
 =?us-ascii?Q?5qMxo+AQQXYkfYIWa23PNg5u00Ic8Z0VaMksgF+VSNGc9GaoTk3qdIu1sqOA?=
 =?us-ascii?Q?jTB30aTPg3dA7AIVSS9xWjhi1NxvkG4dNCyk1nOBjIt/Nx8iM/AupJhpcA23?=
 =?us-ascii?Q?ga8b1Jto4pjTdyHBGbl5j1QVuHEglBWag2CUPd6jKqjRyVkm1F7F+3digGT1?=
 =?us-ascii?Q?wbrbkvSvsY6GKQIfSe7Tm1j370fEGkjJurmrsRpH5wYEYHEY+Dn7aeNQAwQO?=
 =?us-ascii?Q?Sq1cx2/e4Wu6zCM+RNVUQ0CGhDyx27hHKdSWhjMMGS0yTQj9rxZaM4dwyEKr?=
 =?us-ascii?Q?7xFFHWvqZqJBPGTXPsX9MFs1wmoRt4KAeL7t/YUETJPx8VwcJU41MoKfDwZf?=
 =?us-ascii?Q?4Mx+wrxjr3CuvlXrIBi5JbTVtmm/ugq+CCkIIxEeF2PhGR0dAUX77apuvDAu?=
 =?us-ascii?Q?XqK8xhMFtzMaBJSbiih/UaV1/dlzAgRu6mo0DsjVQWs6wkTX9lte2L79CuYh?=
 =?us-ascii?Q?sYiEu2KBEnFj4Kra/3+szlsV1qzK3wbPMXVaaDMgnKqXUsa6dyNEfyc7szR8?=
 =?us-ascii?Q?xKR3VIgr5Cz7yPShumTGyoHaR6fU7bjxgVpfULaPwwRGl75fVIcs9yimAjpl?=
 =?us-ascii?Q?tecwjS1j4akf2aa5f+j9vTMY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVTTCYSNTol9yfi3dgu25fbjFqd82rgUyQbtbipDCnWtd5FjdmM+PAlv3uuN?=
 =?us-ascii?Q?FucKyp/comdQCHfMrC2UKCxSR1vOdQYfTaIz+wEAKIH85a07L8ILYRzNqrpi?=
 =?us-ascii?Q?D4MUeY2oXyq3vK4+XvRxkEEWI6OSufJhjKQoLqISLrnRBobxt5Z9pCL5Vmc6?=
 =?us-ascii?Q?jDvI16IEPsiIFYtW9bFPNm7u5z+AdLHP33oKy9JjqGR7AFk+F2ynQwEOetSZ?=
 =?us-ascii?Q?qFdougchRj62MEgl9A/ZsYIZ3wu6PXe4IpJge9N/dQuUZdACIegJOBSGhPVe?=
 =?us-ascii?Q?jSIBUORF52NhtLQiKhsZNbwRXQm/cUlDlsSw/gIbis4ommT4Ju/V8GW0aakP?=
 =?us-ascii?Q?ABj6Yao1FfC/szGNIkSo1L2IJ9YcChsR+qRyvbH55zu9q/TLBLe7UDB8dj/q?=
 =?us-ascii?Q?DgJ2dy+27WFkTpL4DwQjdmTInQ0ODfid9PuzYcRRzmAUCeVL4i2C50ThRfRE?=
 =?us-ascii?Q?IyoW32/4wae/tgUJTd9rb8kEKIWXHdzJ73d/fwv59NPoPVeziMQb67ybHTLL?=
 =?us-ascii?Q?brYqb1dJt+CYmwXvoexszXXh6RPTGk+Pmwr9G2y7YFQxxbRQTwh9AjLz8MqD?=
 =?us-ascii?Q?ArWSqR8H4qAg/n7w4PPMJmR/RUWVWffDuVAtGokynktOZimvqzizcTyCn+Xg?=
 =?us-ascii?Q?botvlo1L1cIK8AYK7DK5BMxrM7CQERnEHlq147Y6a/GtEEWKFojd7MfNh7rq?=
 =?us-ascii?Q?RsrRJgBHH1BWNNBwWOvVfJT+iE+LyQ6INzvMRTYRaB8OkZCPF15LY36vjxMw?=
 =?us-ascii?Q?SDUMIJ6YIXbRAwT6kfFfa/FCRlnyRclpjrwp6abOrZGs0Wwl/vBC5Mo/Uwat?=
 =?us-ascii?Q?fYaLN/eAn8amGdlASj3rHBHBJ5CT1LHk9OrFNw1su1249+PPaEoMzvv5kvfz?=
 =?us-ascii?Q?IxFOO7Xx8bj8ZJG4Sxamqm1WvveWOxEieQtDMk7m+MosH2dXnbPFApAyOC5z?=
 =?us-ascii?Q?lfFuTzRD5etKyosDEGVfEHI1VGhKE3cfWdkOuKO2clywrLK1uKKAHxijVVf8?=
 =?us-ascii?Q?qt+aAH/FbPZHw6fGZNc8oUfx2vgriB4QSm+nj+Cy2PgwOqBXTT9vStS0+bmr?=
 =?us-ascii?Q?DopCISyYsfJR8jpatxaZdVYmLMpZmlL9yE/uN9jebSrEEVM+bXfSHLlceX2Z?=
 =?us-ascii?Q?EcKJkNl40lekO/3oDNyVkcS2qIqzbHgcABN/jzYnxNCOmrbjMa0QyeU4N6+e?=
 =?us-ascii?Q?huhUh3Zh/VUwJZXDDo+IeRScMRNpjQVYBk7H/WLG6aEbRCfobgT2KXFol8EV?=
 =?us-ascii?Q?0CFBG0q67WUjIgTtXRE4IyPIH69khnp0+yfpaRPv56Nm8YZ98lvllEuVEr0g?=
 =?us-ascii?Q?71JhoJllTHjzbDkMxoZR5X1H9AjemdiveLw1fW3idzNjCY95wbqrsVXfuHqp?=
 =?us-ascii?Q?qqiKM2aaiiYUr24ynHCoxhAPxPe2crPFaY8zZvmRNtMt3dTfP4QlPmKUVGr5?=
 =?us-ascii?Q?xBMH4KxigXbTQA1Kc8FAnun4y+ijLb2j0HHhmpOKTpayj6tx5xELccIoD/pH?=
 =?us-ascii?Q?EbWzCxLzp4f+HGWqpLkxafdE7jfZOVtAbOLPmwp6o0XpY5tV/lNTNI46lxew?=
 =?us-ascii?Q?V6rYI4oIqO8pv+6h2yObqrMa/rLf+EMRGHcpH58usMkebPLqZLOsxgEHanCH?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6u5CO3oMB+f63mcFWyXXQro31n8bQS5+W2dZsPOlhtqJbIfUhkeiORF0F/maFHJEi7tqXxoh/AeHjdol8RCMUi25B3Sc80LL1wO1MPQG4YLFODeZCpxj6oqNixwmeVGMvunbX3VHNzJuC/cdoQskCa4u4Aw5OtL02h17fDkqgcVds8OTpqiTofH0RgYhSeY2UMZJvegfa2ObMnoAwJj2YS4czz3ybxVSKAq5gT69DEpkrH1RqVQzb7xAxa6D2yel80TJd7wxK5XsPdY+I2wux+nsX/NYLrFuABa2grXMKgP2PCYl82rwAo5nIVNnRAnXeUWktoENgeArBhMV/O7UQT6n51iXymnbGoAAswn2VwZPNiFwBcQm9I53yOtjQXqkSywhNdm/ioy9N4y8UoQkmSSwSM2uGuD5T0UTq9zkgptzKno6gWVmpFh1dK8rIWaeqx3x3ARpxZeNqasQlmjrPmi7yUOsmyfgURffgGSQUHLNXqk7cigQ18+eASi2bSXajyW7aDYCSXLXrmJ97MVd75varfQVLRo+0u+prucAoqF43Q05FW+F1kfxfoTWIRLMBe3lnJYDFXvl2WW4NFOMH7Kj7RySK7wqkKrddQIEiAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4067e71-2fa9-4653-36b3-08dd0572f166
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:42:19.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXbzhdledHIS3VEXMI1wuELdsBBlJFf+oLZB8L9I+dsnNT+m6hSXMLBrxj+OU5vGO61FkmjDAnoruXVIh2qqYSWz+GUnCnQ2VCiEbMptJgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: tmQ4f_OegXEagwmH2a8LtWiayz_lGjGB
X-Proofpoint-GUID: tmQ4f_OegXEagwmH2a8LtWiayz_lGjGB

[ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 115 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fca3429da2fe..e4dfeaef668a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2666,14 +2666,14 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
@@ -2770,25 +2770,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
 
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
 
+	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
 
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		error = -EINVAL;
-		if (WARN_ON((addr != vma->vm_start)))
-			goto close_and_free_vma;
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
 
 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -2800,6 +2801,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				    vma->vm_end, vma->vm_flags, NULL,
 				    vma->vm_file, vma->vm_pgoff, NULL,
 				    NULL_VM_UFFD_CTX, NULL);
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -2813,7 +2815,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 		}
 
@@ -2821,24 +2823,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}
 
-	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
-		error = -EACCES;
-		goto close_and_free_vma;
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	error = -EINVAL;
-	if (!arch_validate_flags(vma->vm_flags))
-		goto close_and_free_vma;
-
-	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi, vma))
-		goto close_and_free_vma;
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
@@ -2861,10 +2854,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 	ksm_add_vma(vma);
 expanded:
@@ -2894,33 +2884,60 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
-	validate_mm(mm);
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-
-	if (file || vma->vm_file) {
-unmap_and_free_vma:
-		fput(vma->vm_file);
-		vma->vm_file = NULL;
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;
 
-		vma_iter_set(&vmi, vma->vm_end);
-		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
-	}
-	if (file && (vm_flags & VM_SHARED))
-		mapping_unmap_writable(file->f_mapping);
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
+		     vma->vm_end, vma->vm_end, true);
+free_iter_vma:
+	vma_iter_free(&vmi);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
 	return error;
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Check to see if MDWE is applicable. */
+	if (map_deny_write_exec(vm_flags, vm_flags))
+		return -EACCES;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
-- 
2.47.0


