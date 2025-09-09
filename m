Return-Path: <stable+bounces-179100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E2B50062
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A664E7FE1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8F350D6C;
	Tue,  9 Sep 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G417eJeu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wj5+6Ft9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109D226D1D
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429785; cv=fail; b=ZolNC8pISlrDQ74epGDROn7X7kukNvhhi71UU4kvp1H1RQslTC8fY5clkKVTUcbt7hbIaW1e4Qklus9HKn+fkQrJ9TRgZh+huofJLm6/G5/RoHjFdLoSGqi9AhloM2OBmx8OsC05jvlzgJdsNaXUipOVdOFlynegCC+2FGTa/58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429785; c=relaxed/simple;
	bh=akGu6Y8HVX094EV2gZd+a/4CP8tLPaVnRIKoAH9S2qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FEFx7r8bATS55LrGDLagZyOSkyJJTHuW83YnHdsHfht95BjBpefpq/QOg4HJAEQInConGY2vFkGPFTqPy6cttbljDKncdo0IS3Rn7A5yLeExDte2+iyRsdZEQim4dA5MR7vmba6EX5Fb6aiLPZvBlLv97djvYabKyNVZ9VO4CY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G417eJeu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wj5+6Ft9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPH4W004037;
	Tue, 9 Sep 2025 14:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4MbN+REN97Lg6p76Lkz0eC9RvXbMtFzDX5yXX76JWAE=; b=
	G417eJeuctkxrirHfac4BT77jT/Bv+96wrbmU4EEAqtEQMx9IhurNDnXUK5CQZ4n
	QZHT7enn/YZskAeOhWvtXJHkQzblN9WrPX+bkQiBF1HLrhqg1zTKKnrgA7Fh66f1
	3jIpS/DkaVCY8QlGXcwAsd3MUsym8CwSnwZYcN48jY1kB4m2G2BjFqVDcc9WCLdm
	NJDp92RUVsUZhYG8kBs31hwTTnSwWASkDmtt6grB8grkhrKSxFIWPInuNanmoglc
	n+3aVALuI8/xAOj2v+LBMxO2I7J7JW4pVb9dwvW0Jf8mrc0ba+Blg+HyJ6uU5n+H
	m7qLf6nTm5Q3EesQimxZcw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1j9ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:55:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589ESs4v025911;
	Tue, 9 Sep 2025 14:55:29 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9r4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzfxHHU5oKvBogvXABPLEmBDQmsF2WmOUYb2MSG+kd61nXsnBp17qVuQo8elL5+pombZXpzLfXKMzusnodew0hf6yWv5UuCjxchc+aGM0nHamYYSKUfUJEGnOg+YARXt6oT0103iJAVdfRaPnIjgz7v1icXQFNaFYy43NpCrVW3SQGfvDmCzGR/ak/59ciKY+oHJTesmL/Pln0lpx6l3oqKDP0FJiPEc1ncVAHMA4f+LG96NkO0K5mSqeRKfNiRlN+QtN1Eo5kHzdUFcKvBmN7OiI46i6BXpfqdk4EVrBmx8/1IGW3LqrT5DgIeiaBBv9tAGk/1wGZu8tD67npjUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MbN+REN97Lg6p76Lkz0eC9RvXbMtFzDX5yXX76JWAE=;
 b=nlwM36jX+oKA37KdUtAWj7S1hSvTx6QeMr8V7k4jJYGxM0a+z6YeaoW53I9dp+kV8p2RqRP97mE82Y9wPRbrVIyTyFlDlxBEGz8CCUUrWu5oFVQvCPAUockDK3rqPIuyzODLTYThMehPmdH/7OVXNMYx6STCIjOhfHcMQcyJXNB15tufzPKm8rlj7emSZIJHydpExi4LEkig7DReD4/CICJYfwHZiAbIcDPMIrqD3mQJUemU+YjXbWHzH8vYcoLDnPwwUMoGSCC3X2++/439H5RKSLIURYyrRoJdmR5zpOkBUgLhyYB3Va/4XEkOLiBHAw4VwZorZnMJn+WqVQmEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MbN+REN97Lg6p76Lkz0eC9RvXbMtFzDX5yXX76JWAE=;
 b=wj5+6Ft9O0adcIJz7B+uUcuIF13TlimwpH1nRFUQ7L6WhNA6RTLt1b+Xcr2ss2DK86c89JQWTWZ91UU1lLv/3ijBjM0bftrNxi7wRFlfxe0z2kQ3TUu6J8/rknHgBANvCiz16K6C95yZ8ECeCYOp8zkW9n0AlPvE+8JN2UEXccU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:55:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:55:24 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
        Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
        Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleinxer <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V3 5.15.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 23:55:17 +0900
Message-ID: <20250909145517.260931-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090608-wages-saloon-a401@gregkh>
References: <2025090608-wages-saloon-a401@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:100:2d::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2d8a30-2195-4825-a827-08ddefb0e7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWHtXapAefg2sVXYC0ETVr1xtNvaY/Y+89wM4thrYxWcKjuN2Ca+qGnk9TIK?=
 =?us-ascii?Q?ENgHBa8q5MK1OXdX+ojIgWeTCLpKU1T4RxdFTmyEXyJT8LmlVlCCaPqBxeEB?=
 =?us-ascii?Q?32BfnuUF77V+IBpgO9iAwDmj5sOpICVb1tkOk20Zl1N6fDcwqyPoNGr0RxCT?=
 =?us-ascii?Q?79pL3SYHcfSdCCCrsr4WvKtHSRlbTY5KeqzRWNqUUUJRm/x9A/xPOxUo8Czv?=
 =?us-ascii?Q?I9ujL7ylm+z5do/mqiJgQbR95yTPFZiNqJKyh7q+ZurjpfYoqoguXwyEzH/I?=
 =?us-ascii?Q?ZVCsBR+kcaP33E5PoSa5B1Ed62inpzdTwUFp4BmNBLUGwN4a+7F3dgwrUbI4?=
 =?us-ascii?Q?QX4m4HHqmXsf3esq8tVqtQu5HBfo5jVExRHRkfGBScEyomd6DMJX99vKMApb?=
 =?us-ascii?Q?fiJJUastGvQtW8k4vDjoCPnuPWwAqGMsGX7FH2ssPpJZi3S3TBhOtxauh/Ap?=
 =?us-ascii?Q?CoEf4XLItbrbaY33RAqw8XtS/VAoIy5DwqF/usWrce6HDqmOInMeaBUZgOsC?=
 =?us-ascii?Q?VwC7LblhecHaUmJfGLX5plf3uLZoKrNUron43897WxpAQreuXM0gPB2NnDod?=
 =?us-ascii?Q?ngmrRTJjKTm3zwkCtOdAF6Ay6o1dH6LbVZGrhn1MXH03wtKq8tgW8dgszxRp?=
 =?us-ascii?Q?yjmlBl23sVVrjM/Fpy8zWdrp8IDG9R+429VEY9aRwE5OeX1HmUqmE6VDyR47?=
 =?us-ascii?Q?wCNvBuPqNqRDecQVQX//EGHFemDE5LY4x4S0to+Li31cCSRCDkrdjquX4Eb6?=
 =?us-ascii?Q?SHRgYsOiZH8vfcFtnJfFkJ+ewINRfffkbpljgE06iWbgiXFd7rj+y/5C1uid?=
 =?us-ascii?Q?yy6BwVZivkpNBmDdOlqCSRiFHhnNVSP7ENDIkhMympm7wegeaCRpjGgqLmTJ?=
 =?us-ascii?Q?n82yujvz+lWZZvXI7raVQmergFJP01u/6JQtsUXKrbhBoXA9ApoeAB8Sn8QY?=
 =?us-ascii?Q?8ceiXtwtoHpjqn+DEkaHJbuZNVB5ZV0P98Jg7QrQ2aLlqJ0ST68z3sXWr+Dh?=
 =?us-ascii?Q?Y1mMWTT+5ECXHpxbErdno1PNg6C2dQEC8Gktu6e0BDAFpdZeKjkV0obZ8DoG?=
 =?us-ascii?Q?4myVhIbTlr40V6zJtSNcedtuGbJKsFzkD3K6cTPwBvDbKZswCGHmpzH/UPhE?=
 =?us-ascii?Q?mlfLK5qVK7DK94zUj8LSQAw6jtQSGn8L2Zj0v8t9cDWHugX1SF02lYQKNleF?=
 =?us-ascii?Q?LJ6YDtP9Tk9Das0zWX3CGxOiZFD3tnTTfeCaG+XCPrq/LIphXbgegB3WJZ1T?=
 =?us-ascii?Q?OYjtxOCBor8QERQETGX4NkFCiZLrYZ1Nx800UEUe5qIbS2Xs4OTFeakiqQXB?=
 =?us-ascii?Q?aNno9KOj1l6nzrmFT/lOVTxZhUWpiaq+Lf3iHsQRHn1cVHG5V8sMt+ghhXoK?=
 =?us-ascii?Q?fcFfwHHQReZO0vBJWciaNkxWreSNGj6NdzTjVFQdyvxhe+TIRm8QLSU7Ge8e?=
 =?us-ascii?Q?FuVMGpc+DxtMupuu6Q1rPbFkgmea4JC1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZcClkDQeLhclfRI/q2PFPzSPPH2ZJFloKbgE3c03IGlPMGn1USKYIUP2Xx4?=
 =?us-ascii?Q?p/6oHknY3Qd32FfSk7L2B89d1w5YIkwLDP+ncfyNVphjjVuOtv5N6HVSDuLB?=
 =?us-ascii?Q?TLUgDAGhIarfchEBf6wP2y2o+aLiYKHcxAPsKlj3vT7qzf6IkJTAgDBp+IdA?=
 =?us-ascii?Q?39fdQVX+kP+KtSXyE9aWofN6SK8nBoRo/q/nCQQwOOYChO4Ec0NqRc7PnXDn?=
 =?us-ascii?Q?LzC0AnKcyXIYK30Ul8zzIebXb+8VB8WuN0gBNPaBFqjypWG7VWB8cyR8k0Bp?=
 =?us-ascii?Q?WVy4mv/LgVoIGuJ4l/DSHJ3Pfm6yu3pOeXAKb0vT+qmcMRPq3vSbi+zeICtb?=
 =?us-ascii?Q?beOrvNTyzIMd5NiCIiH9jfA6toN5maW2u+MMfMLL3LRjxiTLI/Es4P3IOX0V?=
 =?us-ascii?Q?TFyzJ8wbYzeerB+G34C7Nn6bKvnFfkO4LRk6CA+i3cV9aSZXgi6gbU9aBbjq?=
 =?us-ascii?Q?PVEXf8X6dOi+Mtg1m3tOEiPyvglFN7FkvkjZaKTE1FMkI1ybRVzmpljr2XmN?=
 =?us-ascii?Q?34OuNDvJBH96K62CTYsVCZFCspYAFcigGw2PBSwfjNeTf1yAHYwIUVxZeJkk?=
 =?us-ascii?Q?mzeYDMUplBcATUouo02D2hv1JDHqmPBWTkntNQ69HvnPzOkNZClBZABc/Pfy?=
 =?us-ascii?Q?/To+DyGcQhmAhJCYvzwn5jKm/m0JVRFuJAbTZ7tJMyxlzYXb3dXHJ0xmPuha?=
 =?us-ascii?Q?KOVW/5VLKmjcs9EAWHkyqRTBY9xyLs/LW5BIZTFA2pzn7XVNiG+0AyhIQKPK?=
 =?us-ascii?Q?68ZQxFvCEToK6xZNr/icvVjoHRIY9gej6URQgbXYRMMMyZFe+b2ph9YSyOCC?=
 =?us-ascii?Q?yuPLIaPS7dDcWnPaNA3DUS+/46UCoa8Z38az9N1g/0FcUUY0G4Yx/R1FCST5?=
 =?us-ascii?Q?AxHDa4/9TMiYBKeGYxxHvliybEMhBl9mZsqIulvCcKZTioPRUxxoJL3Y2MAk?=
 =?us-ascii?Q?AVp0qPp4A9fDyb/F7wDh2VBmRz+Si5T8xUsICAxBPzRE26yqOt6YtDiFQQXW?=
 =?us-ascii?Q?0I0RPmPIyNsZAiDeXZVD4xbDDXpjUl346ytzam0cJaA17AheIRCq+jfr9HBm?=
 =?us-ascii?Q?//Vqa9l0ceb+/xsElYlrYMYXL7fEbd4h4ZxjL3NN0FVnN7YDo5/54N9fjQme?=
 =?us-ascii?Q?qL12ZwpZAJe//dqNGjS/IPJs91LhSLS8iXd4yFGxmoe0FYfWlICDUe6VJlCT?=
 =?us-ascii?Q?ghAZrmruJ4Yun6T8p6+uV55uPn3rPMKPfymbqxzwFkoZzxDc7nyY+x7J+7po?=
 =?us-ascii?Q?nI4SgfxtTTD7/W6tgOAK2EcHKAvDTcvVlz1h0ImuZL5Gscr3uyFTn5Fk8WQT?=
 =?us-ascii?Q?gKHVATazePq83IW2cgQbBvXtS+d5BBHjA5v3LayHYEoUKzjEO3Uo/WQoOeC4?=
 =?us-ascii?Q?ea3Lt+HkRLaMZ9DNY6QRhUKPX+yVNcfSgPziL1r3X5RjrcDnFVmJYVQvM3GN?=
 =?us-ascii?Q?V5Zq4bc+YWYqToormPYlYID93FXBGsDqVfNKLkwAtuslNbALgToPksRNMnpa?=
 =?us-ascii?Q?IVE5yRrMejl8PErnwk3wgJztgiOiJcI2o2B1J7Vz3V6wVhhFqPGf1LtX4NOA?=
 =?us-ascii?Q?OB8MC7Y9W+eY9TbQNnidoNx626UBfGCdnNfSjbMq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3gLtJHmdlSOJFaaT4H9rjIf94HKAMzcMAfKCILPzpSjOyYgrJ02XpHF66BY8OC/gL9T07V9hJDraGr9t4Q00RF5s1sqr1xwxU8PlWkbiMranhfjZAmzcqrt1W9mzBa7wg18MyRcKO+RzaeXrTiP7PshkWrN1PmGSZHZuSX8vFuZv7DrZ5ZAq95p+/RVNnbGzHRjrWWrty/4aVtgoSr8q/Bef/P3FO/Np/NjseIkjblV335mRqjfRR9E8f1Nm3r/ODu23sfyfbfZcJa4m90SbsD5TREZeEooT2ecSGCQcMRROm1kiJBTcblpWFhKOBy2DGP8d4AyYOq6Dm9X5/FfKt8fCPylAsbMBY0zizVoO1aDWyD2T0yiCOeRCivmh/u366f64smAMUs3Utpzw6EvseC9l2LF8+D15r5vTy0dhp8cIdyBXngrmoRtIi+MSh2ZwyRD2guMFYbyRvtucvo4dAJVb9RFz6VA2C304xnOoUAWSQ3tG4e4z0NmXfa4P51krmsxNIDsKihmFy9nknXx2Hx2VyV9qZgr4M8MYYqb9yRSe9HPgp/VDhCGTc4Z+oWQnERpa4n4D1xa5o4tK9nt8TRBkg9udGCI2XTCu0uD9JeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2d8a30-2195-4825-a827-08ddefb0e7ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:55:24.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvUVnVMBDKsUD3w6NY/agt2WCbne82UH5/hEowRlEXAwQc7zdt6MDYe8HhBv0YY5u7nkL+0caMb1wRox+rjkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090147
X-Proofpoint-ORIG-GUID: NWgV5l355Asu1vojvufY9Bf99sysdVG2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXzPyY5PW3rOBo
 qOOIrzsniGe/iXV0MA5yYzQ9EZVJ3Zr2u2YMbxEDIEgnN4yQwbil16Ju1tamgocV8Klc9VvGdei
 dpnRpfGUmps02/pYMz9UJWcNcZguzr+6GJYweIWkt49p9BblN1f501GNs9wVRjo09o7UEAQdW1i
 oHldSIR4eFGMFyk/TlUS8lKCqb71IKhnvU3KcFvIlgCujmsuNlKPLgGczYbqhcdvpiLkOS1Od62
 MBOGldSsy/6DVow4L3lE7dJAl6A5wcIFD8+iBVCWQZ9s/9U+yMjyI8ZtP5RvhpfgnWhv42tMH5Y
 poJov9D9k+wcTWzWQas+vTmDxkuAVGMg5eYGtEz02KGNNKke8ddp9kJOtPCTFlOhaUh/Az/6n6O
 yuQDRwUbRfbNXdD5Us9C3P+2W+yqnQ==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c03fe2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=fXIjmmjfsnuEW8ROR_UA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13614
X-Proofpoint-GUID: NWgV5l355Asu1vojvufY9Bf99sysdVG2

commit f2d2f9598ebb0158a3fe17cda0106d7752e654a2 upstream.

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.  These
helpers ensure proper synchronization of page tables when updating the
kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.  For
example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.  These are introduced in a new
header file, include/linux/pgalloc.h, so they can be called from common
code.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by
arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced.  Currently, these helpers are no-ops since no
architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

In theory, PUD and PMD level helpers can be added later if needed by other
architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
we introduce a PMD level helper.

[harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]
Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bibo mao <maobibo@loongson.cn>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context. mm/percpu.c is untouched because there is no generic
  pcpu_populate_pte() implementation in 5.15.y ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 13 +++++++------
 mm/kasan/init.c         | 12 ++++++------
 mm/sparse-vmemmap.c     |  6 +++---
 4 files changed, 45 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..9174fa59bbc5
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b1bb9b8f9860..e9aad935239b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1382,8 +1382,8 @@ static inline int pmd_protnone(pmd_t pmd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1522,10 +1522,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..2c17bc77382f 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -188,7 +188,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -207,7 +207,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				p4d_populate(&init_mm, p4d,
+				p4d_populate_kernel(addr, p4d,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
@@ -247,10 +247,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -269,7 +269,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bdce883f9286..fa4070540111 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -29,9 +29,9 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/bootmem_info.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 /**
@@ -553,7 +553,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -565,7 +565,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


