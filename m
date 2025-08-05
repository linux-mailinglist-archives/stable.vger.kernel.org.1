Return-Path: <stable+bounces-166556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB828B1B394
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E33018A3D3D
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD17270579;
	Tue,  5 Aug 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/B+I2Nb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dJ3mrjRN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E42212B1E;
	Tue,  5 Aug 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397562; cv=fail; b=nrdAvpxrbIbFtXIm42LmNuclzTXoal/CKjYlbLLMjYnWJMThtB3L5Yls7pd+Djmmt+c49zXy0Dr5UAtfFPtMTgW2RNPfj1wRDIV5ivbSKTyYJgwQDgq8C03q/OdP0BOlU/JdlxPOS065TNGU2Pj7HCzgBERgX8YiUSc7IPlhEHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397562; c=relaxed/simple;
	bh=zBCgf8nI4lneed2zAzavNLsVJg+pWlu5bXkCrS+N3L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dbq09MopADAclqeSTEaWdiLuM7EEHf8GtkAVx2BewW9kCFk/JxJmCaMYbg4nlg0kMMZAWqeqXbziyQ2C3J4dYuHB/tFkNcxoeVBJeg2V3A7pxw1FdTYzQ+qy5w0WHvKhbMiZeu8sNe+6eRnZHtLB6nDCJAXehbJrmlk4GpU0OVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F/B+I2Nb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dJ3mrjRN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759H7fB028448;
	Tue, 5 Aug 2025 12:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JoqXgWRTKolMeuLRqr
	qnMC+WweWkuichDFFRvW9pNgY=; b=F/B+I2Nb84lS3rFW0UXFs62MlhRlxXjo1k
	ONTQaiYCyPYaD1ufPXvlzpHPMUnbzdcR4dR9mEbPEBizUBnNr+FTLzKS67LpF8ak
	u6rxkD+lU9uy9nu//P1vv9ZnjaaIJmniq9faq2ALpMVscQiAhl0HVlMKZ/FebJTD
	mswIY0aRP9LZVz3vBEILSbYiSgP79R73EuhplAMmrIDkR3N5KhqcBbpK97KX1JLf
	xVV114pDXsOH5EO2/I8BlcXfdvv76zNUwYKhNh2F/wgsOX48RRzjcm0QEgxAqJvC
	fqYUApd6b21pdrlp7ornkeuFL3JGuZ77MmFrhDBGOFeBjDX5ts+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899kfcqdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 12:38:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575BxdFo013472;
	Tue, 5 Aug 2025 12:38:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7msppur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 12:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJXH2sMjhYdUbtLBp1xs4pfC5VoRfYVhQ3EH7sbx0nYsxRJzg2NJR9++RL/g8PjDKOcAwgydldENoFwH9D+FEee/wyvaOmlFNzMMjXkBFryjNZH5P+Zy9CS2IZJ+Jc3jvtp90h0AONIcpISasO2ySZtTX7ETGexZEgbN2k/GqbMJX51rFoHCr4dGLkFot7kziTvDL4jzcYs/C815pa4Xxp7QtQKuj6d8eBJpapZjuKGgw1qp9XVnCo7kr2i2s6J4FSnEUC1S9HOIHRPlOCZJ0EoPiuhjbOSneradJoi/+mrd3wLN/3cVj5A7zI349iJbx64l7Cajk9TH7/4GodAH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoqXgWRTKolMeuLRqrqnMC+WweWkuichDFFRvW9pNgY=;
 b=kbKmFHorbqxc/5ANi4VaJMOuAyWmVy1jc53YN618jjccTw6uQ/KXjJ1Bq3h4QHkRZYnfAUlk9t3fFMYxWIhs/ECF+MiMuKwgskRQOQ3OK/Zw3pawaN1fsRELL9j9kRO7FoFuctHv/YrWRalWjWsYz0+E9IVJP3pawsGNgs/2F9fULFAOtDlAQrC9N8Nbz/ZyAnhOO1hcgppThnNGiuXuTnHzFsTHJgXXKp8huPKZJe6TzajDPIHauBQfKBjsyj8fKvDgJPqPIsxe79rjOuhwu993D9AHtFp2TOQC4ZJbP8o3A7TQy0s+Ao/MWRF0r9PP067B2tGpVHkWTqHpXy8X9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoqXgWRTKolMeuLRqrqnMC+WweWkuichDFFRvW9pNgY=;
 b=dJ3mrjRNcLU3klnPJJh0sgpOw+i53c8qwCqZrwjHjOVB324/iImL2xFK9t26RVzyfc+99Po1wvkFSf9Ou0wc17tUa0wnQikB9zT3bajMG/DTfYfnykLCMA7UdrBAIrXOK/h1vOx5x6TEvB1pLiBzxO5nX67OmvA2PcNgpI77lA4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 12:38:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 12:38:50 +0000
Date: Tue, 5 Aug 2025 21:38:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Li Qiong <liqiong@nfschina.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] mm/slub: avoid accessing metadata when pointer is
 invalid in object_err()
Message-ID: <aJH7VQzyPwbKayQ4@hyeyoo>
References: <20250804025759.382343-1-liqiong@nfschina.com>
 <a5fb57c6-fc32-4014-a4ef-200b41ddd877@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5fb57c6-fc32-4014-a4ef-200b41ddd877@suse.cz>
X-ClientProxiedBy: SL2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: b082ebb4-472f-4e8a-21e9-08ddd41d07ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tVe2CEU3ZhJDd+ipSKX353/3I5s99Ob24p+cd/yxhwjZ1bHS47y+FnXX/DDx?=
 =?us-ascii?Q?7FETsBlizAIWb48cJS5xEjoHJeXciMaBJk8X0LSKYpu72KIYPDkGTJuikvLd?=
 =?us-ascii?Q?2rrqS8OQINvwkAxYpmHeYwp66wYJc/+wSV0Z5jmC1LvmKFeCc67nN7Idd6ff?=
 =?us-ascii?Q?gpBMyx3qO/4yXdmdNE3v1famYsBgVAYOU7LSWei74imPfseWDh4RoCR5d8gy?=
 =?us-ascii?Q?7qDs9DLSW5P64tslMsBjoJv1KviihETEzqOhvXpBqZm5t32o8fYIy5O2ioiq?=
 =?us-ascii?Q?fHuwU/GSF1KptDzhM8f8+eaqA2UFNT/6MPuQzLuqmsdYSQKoSlQAQLhEMGq/?=
 =?us-ascii?Q?euY8y2f3nApPt43zh2t3Hl7QIJPiI5HboZHTkhGWsJ748zk14OLq5smIVN29?=
 =?us-ascii?Q?Zazzc9tR4S3bzeWij61LTIQaDE6zE33+xQRnKDrrPhiMwx5w4uoUdAxiKTjY?=
 =?us-ascii?Q?MpWLvSGWA2KTc791JDYjVFtNoxbyos+IoDn8wgx7hjDBq2CEz4Ohk6BYmbdl?=
 =?us-ascii?Q?1x88B/S7NFY2heWi2dAOQXKL6ALJ4w3DGWZ/rSN6Yde+z2+Vl4NA57zeLu7o?=
 =?us-ascii?Q?Y1jgwTxxkSoN/rRDTdU+547/ti6lQ+o9XslHu8ZzQcqjHs4PDvF44hpR2X/J?=
 =?us-ascii?Q?penQvWylEGvyvjsxjzqKP/7AfqEWS9Agm93+rka+GYRu5zNgy4ngGtD/MGrh?=
 =?us-ascii?Q?pq5oB6ajmopwdzkD5K84ARQRybGIAw9rTdaeDZsqUJwN3HNxnHXq8T5v3ywL?=
 =?us-ascii?Q?bKUOP/sFRFJDwmrPSI9oYu9qZcA55rvwdhNBKl0LG8DH2rY1S9sgxHPn99oj?=
 =?us-ascii?Q?iyJL14+jPk/wLzaEp6EugibesjxBE5xLOsxBAwojyk+3rYJ1Hm3O3SBRmGAY?=
 =?us-ascii?Q?6ZiVHyNAVZV2KblvSNTUZsn0HFoDAMgYQogzCzMwWlc+RkFzzfQ5Pt0KP1U7?=
 =?us-ascii?Q?elt76AZzzcWdlezhX5ZTaPke8+Gh+8NuivdZQ2ZSto8E8b1jNw1FTVnY9yoJ?=
 =?us-ascii?Q?ovGYChYbfgQIBrWJCfqpBZexspyR1GDFsnZ0FiipY30mOlCl8vTpHQPi9RKQ?=
 =?us-ascii?Q?GbXgI+yC8Gyu4VBjqt5PMFtrf7VDj0mzY97T80SgArq2tICifTLoscLfJkjU?=
 =?us-ascii?Q?/6cjlrePdvhj4CqaSl89IDwgxC5rVPRg/fMv8Y+XlHN80TRqNmoXQ0PUfSB2?=
 =?us-ascii?Q?uCksO6ADlKCwqOlwewmj47W8HZDEiulo1sJLAWTXJot9XwCtemDMcHO1/+Z1?=
 =?us-ascii?Q?RzOb34ry0Khym61BqqIx8qSF7izm99cRbWtejygY5MlMa5B5JvDHIQuknhkb?=
 =?us-ascii?Q?27opQF9tDyubm+zD/7jcDExOe+zZSHVFHmhssCe+wYRam8RA6ePeCW2isgtG?=
 =?us-ascii?Q?hf+x/EvCV6FbA33XnXKHfvakFAGugEMa3Q6PTr65hotn4JLBlBlWrQmCUl68?=
 =?us-ascii?Q?er4KxNBb4jU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/0VavF+4HVm1liE5F8Q3Jy5G4EV+wJLpTWOdCiRBCHaPskW7ThTJKa77+Sw?=
 =?us-ascii?Q?WAjDJ7PinrHLy5X5DuyfysLqHsdThUrwWs30BZnUqdSZ1pdgWuWcZ0G65C/e?=
 =?us-ascii?Q?pOxU2PWs9uokmjsS3EGCi1PrRQaK7WMhK7NXCsLGf2mmNmFMqH+zYs7Es+/+?=
 =?us-ascii?Q?4SyNqzOmSwx3yxkTUXW7o2PdapW+CVGd2YSTByYl9wJobBxDTx9xPXzQW9A/?=
 =?us-ascii?Q?Bv1S1/PsCenwixm6jIXtDCfbAHno7Y6LgtpHqLMXBQjcLwCxgzp7xcNG5z2y?=
 =?us-ascii?Q?GJJsFMlI2iPUtmhoQjglM1Qt+aoHDGA0xaZGJmtNoYxFotgINvU9cF6dHKrL?=
 =?us-ascii?Q?KW3mCja3ITQD8Nb8kYxCMzcEl9QKdC0KUbSkUpZrCiPlPpaaDssjIGAGpQbl?=
 =?us-ascii?Q?TBov9cb8Orpr8dTcR2+RvntMp+ZqjC2hsimCfjw/e56ZrEzd4e1BWBT1atmp?=
 =?us-ascii?Q?wsgo+dQmmVsRfIMlGZ8r98mnoSkpdQEWnJaEYSnhIrEAyHs7OlEVcP+a+969?=
 =?us-ascii?Q?5dGu2dLHkNwqKkidLGgyb3QrBxtlgFvFlEtTFkN4KKkiV/0Bds3XW1fRpOF1?=
 =?us-ascii?Q?egosNSj/eIdHBczhtpMFbFHviH4jQ+4ArBc2rWS/o+AsiwMcX8dOoJ4Xn8nc?=
 =?us-ascii?Q?vpw1dJusry419YlMbpR9ucTYPxviI5w1sllNsCzDUTYLqu8KAKmi2djEUa1X?=
 =?us-ascii?Q?mANJvOVciMGg6Zt6gJjqlRIOWn5kGJjYCDjw8jZ39KIkhLs7oauQ5xyLLeyk?=
 =?us-ascii?Q?Rcw4x8o/iB8nDIbd0RppbSO5ua4EQuIoZ0Pg0my8Ls6lbECs1dMO7peZEXPc?=
 =?us-ascii?Q?Bm3MXY4BiLpBkckq9/MoGs667B/CwLg2klCJ0vDxOwjXYyq07m61S4qJRtOq?=
 =?us-ascii?Q?gZC7SMHvj+0KeRKnBR67F0Ax0d1pIyvxdLnZ9R1punp833QA7qQIatbmkdf+?=
 =?us-ascii?Q?sO5pcW6THfIYcZxCEmxj//BYfgT9d1u7xDzqukdl59NqLMzd+4ripH/4w/9O?=
 =?us-ascii?Q?vC3/qX5G4LbXqOXAKewPjp906vgK9EY4hKb9CZbxkVTL81ZKvdI/islEQXGS?=
 =?us-ascii?Q?t1HH0VeXYi/ugCzpQIHBGTuwg78dDcS1kMBCmM/j5VEgOl0SsBH0dls5Z5+4?=
 =?us-ascii?Q?1oGhhcxmKhHsF1H21PRkdJ+SbkZIyG8s7uhqN0cjTfYp38QbPpgbQLRAa1SG?=
 =?us-ascii?Q?kDrOaTRq9NSHtApH//DM57fCb09TeeiFjrL9NZywB0rWAd0Cq1z3DsWAzF0x?=
 =?us-ascii?Q?VJVq3DRV0YxSxwwzCtLkOzjs7ucqFlAdxX9n0L8YsnY7L8fHQ9K37FqAfI8j?=
 =?us-ascii?Q?WstGj13qXjHy4z66nKpiqZ+E4FEUdkQMn5IQvZjFSkuo4J0svfLjaXa0TPSY?=
 =?us-ascii?Q?joXOw8G/yIPQm/4QxW0NhHkGhmPX+OQRO/X0VSWqu3aegPZUdESp2adZyCiN?=
 =?us-ascii?Q?C4OCLTgVIhefA0fdO5Ne9rJUCGX0v1GYU8pWYiDLrVSvRj2qVDrVMeUdmed8?=
 =?us-ascii?Q?iOEHP96lKd1WJuUmyFxEHXdocxXApPynB+u3xR/v5oA1bIZpr8iIaYLF42+c?=
 =?us-ascii?Q?udIY02OZrcW1z4ccV0pCvhkd9b0EqS95GJ4Ooklv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sgDjYRvY29pXlPb1o3HLMcTqVu7YUxE1KhCMgpjG//UNwzYkRAxMmGuNCzqD3qS8d3rrIE4Y366dqEnV5RDCf2pXDdx2JmsZo1bGHzJM/Q4E778a9HYKNWLfwyBoHyQ6ahLgEsn0248c6sdkqTmEbnLyRPdN8RGOrmgc8KLLY7H9wh1Omwm6+hqTQqS4YsxONa2NW0dFBBGbjSob9U0ZU3NO1tIF9KQMXqSxImPLSRCBsJt0w8gZcGrAi7FYyQ43bW6nAOkmqMkuTFPAV75LqHaN+xwTfhcPJfmv1lGGZP3yNhPJpF0YX+yYX4Gxx5Y2SDZDpK8jfokmWs+ZXNqkdPpZVcn3xmlA9K/by39ctH1Hnjiu91VUgoRbmVA1+6HJJnhnUnnlj8fi7quytfj4T+3rPgHZtrNj7pXrfVVVM3HrEVrr9X0bS1CVgenC59YDGSslvqwEQLvULM17zuQ8lItyDEBiOCWBuNKTqc212BikEEQcU8jNPi6FIP76rzwsh4ns+3qloAtO3rE7WPSREEkKi/8e/+BNEltvE3TrxoyzP8osPPWdJlTWYFSjcNBL/tPIQRo6x0DrvlFe0Ud6rSuWWXxSBcQOlYwMm/epwKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b082ebb4-472f-4e8a-21e9-08ddd41d07ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:38:50.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eru8YL3wnN4RHDyeH+p9Fn89Q6Hgkv/l20cW2ILKhAZ4q1JSE/I9Wu5Udk9V99WqQsQ90KI2mZm/plQND8t/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MiBTYWx0ZWRfX/rC3n5CIW3ez
 Vot63M91OPfJ6D7ZbjAAAWHlme7tbpU5GTNIpDUuILfiu5ICW3nrEHVREAMNEMzRfAa9FqFX7zZ
 AYGHnbOnTt6bNloZHLP1Yewrkt1ixx2hs5HhsQ+bYSNniWjH44xeotwFaolwLj4L6h1h8j4W0C3
 f267S/yD+eXoucdWjLnw8ZP960AzkshXh/LhP047wx93YCLwaRpdOd7Ltj+31RmSB1M6lhU13Iw
 /Aq01EI1IXVnoKWyIg+TzvJcBl9HtqTPctBcl93yYjFi84zBxz5jhqWtrDgXCqgySu5GTYNNnse
 /Ye3eoICpj00lA1/N+jRF4JAVUUe+Bt7FbiUTgl8324/04BSbBZ6Zl9VdgutKPzjZK9P4IVo/b6
 ws+gRZRDhvi9/GZ0PXqCKZ6LDIg6ljx6F2FNi3hVCYwzfIc/3YP1u43d+792fdyT29ExiMI5
X-Proofpoint-GUID: 3NdxYO9iTAgSgCvWsMbp2nj-SFU0UTG-
X-Proofpoint-ORIG-GUID: 3NdxYO9iTAgSgCvWsMbp2nj-SFU0UTG-
X-Authority-Analysis: v=2.4 cv=VMvdn8PX c=1 sm=1 tr=0 ts=6891fb5f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SlVAvriTAAAA:8
 a=yPCof4ZbAAAA:8 a=dDGc5PFsvujXrbFpz04A:9 a=CjuIK1q_8ugA:10
 a=qesGs21RGGeVIEdTuB6w:22 cc=ntf awl=host:13596

On Mon, Aug 04, 2025 at 05:19:59PM +0200, Vlastimil Babka wrote:
> On 8/4/25 04:57, Li Qiong wrote:
> > object_err() reports details of an object for further debugging, such as
> > the freelist pointer, redzone, etc. However, if the pointer is invalid,
> > attempting to access object metadata can lead to a crash since it does
> > not point to a valid object.
> > 
> > In case the pointer is NULL or check_valid_pointer() returns false for
> > the pointer, only print the pointer value and skip accessing metadata.
> 
> We should explain that this is not theoretical so justify the stable cc, so
> I would add:
> 
> One known path to the crash is when alloc_consistency_checks() determines
> the pointer to the allocated object is invalid beause of a freelist

nit: beause -> because

> corruption, and calls object_err() to report it. The debug code should
> report and handle the corruption gracefully and not crash in the process.
>
> If you agree, I can do this when picking up the patch after merge window, no
> need to resend.
>
> > Fixes: 81819f0fc828 ("SLUB core")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Li Qiong <liqiong@nfschina.com>
> > ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

