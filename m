Return-Path: <stable+bounces-86795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF3F9A3934
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F10C1C25944
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADC18FC91;
	Fri, 18 Oct 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X6gPgssR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ej9DHC/M"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EC18FC80
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241657; cv=fail; b=qlQG5Gl3eyi+jUy4YSh8fIW6DnE0YPuYgBpiBW2Ivx4iohfw6kcC/YX/2iXz4jHCkzdr+cYDH0obC3vqULcaw+7XPWJMVuilXE3lj6mQjVONrHDHWV89N2j8cYvMkiTLh8qxDczuYixiJqHpz/ubG2c7m6ubALvB29Y9Xdt2edM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241657; c=relaxed/simple;
	bh=nL5j/YkdkHk4s94navfRwcIt77EUNLRmZGO2iOSo4Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mbGF0uRGSa4vGpDlGMSaJmDd/A4Csa2rIh70pXGX4sdWtW9jxiie37N/+47DQlxAa3kM7esk4XZZT6LRkUTGtJxvafTcX+uMGSDbXrww29MERmM1Do9DLacBqCb/mkFIcsZ1TheEQtxLj++MY0isRxiRXBn7sH8UP3xMLf0nPzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X6gPgssR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ej9DHC/M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8fciT002626;
	Fri, 18 Oct 2024 08:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2ceYNlO5a6pupqlJBHLui2wm7VgIoo9eFXxb2gVz0XQ=; b=
	X6gPgssRfetrQQdstAm28PWOkGBjhRSnOp3g5bkHT1fPZlDc9QAfz+6/+13ziDzn
	Ku5W4U+djR0sp2Z1moN1Ruz/w7vabq4LJecjUhKwWDdwaUQi57Ad2H38ybaoQGBb
	GAwWNhIlWLm9YrNklINaKULeX2gaIagXkM5hBu3FTpxrjVDZOXfxqVWJjAq864tR
	admi5cOzx6bnPGTq0m23zc0rKCFrFESGQfLMtcoN8NWuT9u9mHg65s5jHja9eloq
	xCsEdoMnhQ028bDLNQG2n9bTJ45ICPhIhXf7GGGB2t2o5IpWQ/CaBMgihxY+vt4K
	IQaL446lm2lHOxiARIxsPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2rde7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 08:53:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I7Algp027123;
	Fri, 18 Oct 2024 08:53:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhy0u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 08:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDlsQm2scXpD/wZFCKtWeugw7cAWeBncBS2TkHuXsNFCu/sNLF0EIkIh0HZkCQO9AnsIjEqNS1wqPFrUqzCcM7+uqJILMoTlR9peZ/t1wHoYbCFRYr1iFLlXG7SfglivZMfdotkzxw+M7YMzeJn29GOvvKogfP6zc5xdhLFS60mu09ZXrPGv/BJ94i9DSTp4j1A8ccqeTExkyNp2mOJ1dODtiHQ5xFi7Zj0r1lVL6muExMNgLe9w8Xpm4Y9CQzHNkf5lGIYcObAp21sJDlKVv0MCo1IkYIuA9pmjucW+xpREmsHrJUJz/2FJMpJTRFbFE1T5scsvPz1oVbfRkIIMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ceYNlO5a6pupqlJBHLui2wm7VgIoo9eFXxb2gVz0XQ=;
 b=dBOH5+PBFXLuoUrevMol6CyZr9DVMLD5R2qHgNw6tiUonovexCMJwi62+YY+EWIaIunoyaGHxVnbJy0717sIAfgPvbfkav8mfN+wBwow/gtz8S3CRw0iG65dho6nTkJIS9ZJSOsHvy5my+cRM2zbxiJEoEgUXL0FcuXfW0K4cVftC1G5QwRv6IqNvhnG+FLmLanid/c2BhkQr6haeCldLwaPAAGyAgT2uVyYXLjPBOJyZd7hZjRg9G0fmVG3z360bnqWVfbzOGjo761tfNMpSxFnO1/haQewR7TNxTmnLQj8I8lo12BcmVnrXbm5VmmzIRNgQmT1XuH+PQLBXPn4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ceYNlO5a6pupqlJBHLui2wm7VgIoo9eFXxb2gVz0XQ=;
 b=Ej9DHC/Mq8bWmqULbvKQVA84MOV3KiCJTijCeifTqEp/zc0DGqLHi3qkWC17DuhC64DDEfuCEwC9XqCEYjk7TfVfLj6V6axvyQ5qoNYyvfat5/SVFAiF2WEWHdR53aWaPjiDVHfZxe0lX61gKuUbhatCmDr5I/X7YDUAVlcd7xM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 08:53:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 08:53:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mikhail V . Gavrilov" <mikhail.v.gavrilov@gmail.com>,
        Richard Weiyang <richard.weiyang@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6.6.y] maple_tree: correct tree corruption on spanning store
Date: Fri, 18 Oct 2024 09:53:38 +0100
Message-ID: <20241018085338.51275-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024101818-ducky-dallying-2814@gregkh>
References: <2024101818-ducky-dallying-2814@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0174.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f74723-5c0b-45a6-888c-08dcef52659b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQsXwMOU0MaQ72YIWh9gf7qXoU1k7TNlskUnipI6mq2ERixV2wrLA1kBLJMU?=
 =?us-ascii?Q?a+V+XQZ/gNDFknZGPy0PDuWxfzM+LDqc51/G/uNfQD9JrOCR+zc+Gkr8A2u1?=
 =?us-ascii?Q?3PO0NLP+Pc4AbaYIITEs3vJsRmGQITitx3D9Ap5HMRZzXjeUAIwLOA0t4eqv?=
 =?us-ascii?Q?n27ZsEAZXVzwu2WDxcIwnI9Quof39KIwOwbPbRCKjlCMQ0+fGfNO+nyhChdJ?=
 =?us-ascii?Q?9O8HfMd4JW/t+7WDJnnMBJOChZyi0Vr1JjuouIeQt87K+ECa/D5RrWNX3a8k?=
 =?us-ascii?Q?Edwd7xkTegGuBcfcu3Y2Yqg9jOpYlKWo5rVf4KyzT5/cVV0jB8QB8SHt4IZr?=
 =?us-ascii?Q?6BEtxmCiAQZZxJfm8RhZpBfbmRo9aMiPblLcram6qTX3XWgEBQnov+3Jyy1V?=
 =?us-ascii?Q?8G1/PN55u/7A7z+i5ZC5pE5Zuo24OnGpxJseZLwD0XVfa5uOvlsz897e06Ne?=
 =?us-ascii?Q?bdbfvqBtoAeZhQHpH9rLMOL9cCd/aHt4oN7J+161QJsmQTRQ2V5COFX9ihFT?=
 =?us-ascii?Q?NZ5xZU0mIcin7jaBTqLUWeR+XaMzuaRgGDO/jXsVME5euK0BI9M62MSbl/h3?=
 =?us-ascii?Q?ozjAPxH1b+/2+/TDxTentnqG1ajFSzMb7lL0vlAirASj5KdOi1Fe7nogCJCe?=
 =?us-ascii?Q?1MKLjDZ7rsdFjTD6PjOpATFFnNMEGfreYFgI4jtms3dDyexB5q23rbc0Sldj?=
 =?us-ascii?Q?V2OGfxdhhUXxszi0wLjARWnm6oSsQ7iNLB7eiGfp81pIdW1cxSDQSsuquNjM?=
 =?us-ascii?Q?YQz6yZpmTtiIsqOdwnjtbrc/mBFJhzQWFJ4TidLb08NXvh3IY8s84wqV5CPb?=
 =?us-ascii?Q?LBztvUyPuIBzciCtB3XcaoDIZ2kx4Rvs9LFoKEFGsDuonrb02hnFDwz0287o?=
 =?us-ascii?Q?pW/bQ8JXaAhWwueVyjRjRus0fbuKuWZglTrvgnJF9ihkjcCnJrXVvBq2PXei?=
 =?us-ascii?Q?iRH1nHYag+zOR2nFgm0zlLXxg0NmhfmntFUjk2sMkNTP1AbG/fB/1IDRyfCn?=
 =?us-ascii?Q?fyu6ayEXiHLPi7ll73Y7HiJeOr0WQnNFmkEspz4YrdeDQIwJEAJMUefPm8IM?=
 =?us-ascii?Q?52a9viq8pQOq9bWrLwXv0WKB25xYuLNWFZQhNluAD/Kc1XhiKhacGu8nsyrm?=
 =?us-ascii?Q?GFYnKTJYfpTn9Z8m0HE/YNLF65/i/IR3nLRuP/x3qsQNz1zMtyUlzWzhdthO?=
 =?us-ascii?Q?teGuns9OJxsO8HlVKPg8lWkGzlePID4lIEccSIAiV4FNrmLWYGkJwtdN4AL2?=
 =?us-ascii?Q?fwynKaO+oLQb0uoNE1gt5zg8YYZpuRmJkeUAJgitCdlVkkXoIB9CWe5yX/Xo?=
 =?us-ascii?Q?kzSLSnZ6rdbQuPeTzvA6z23u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBu53FnGyrwuhp1NhIGq0jI6H68CtFmBly3V8BbWSqxuZLarEzD58dZioe25?=
 =?us-ascii?Q?Cp2YKTrkBB1b/HyDH2w7lPGYdAUFmTN79ppJj6WkK406ZCwOW6nV+sAb4Fjm?=
 =?us-ascii?Q?aY4ksUWc3Bava6xXkrVnfU4c1J+RV9KmlSfGJaG+UfLYiPEfI8wdP0n+x45d?=
 =?us-ascii?Q?4F5tEQxlFe/VMVA1OetTclHakcfpqeElsXhXm55n/wXZ59YEJJRQHHvQlDqj?=
 =?us-ascii?Q?HDMpblOohrYUxEp3qg+5QEptj84MFK9YrSJkqvpEfs/KmuqsaJkw1yhrN/hD?=
 =?us-ascii?Q?5t8o6/HORC0Xov76dWlwwIyy3EJxXclTo3qA08Nqy/RiTHo+76UssZgYhbBi?=
 =?us-ascii?Q?ZEVfdZJyHTUrNaThSNG0Ilzh/wFZygfLSRPVRrp7kVGDFqZswqRdD1E6XosT?=
 =?us-ascii?Q?xMq+oYF9OKK5Es3mtw8wZ4fftnshNzQJyQK9+qZtpY/R5mKsYViqfKFY/PdJ?=
 =?us-ascii?Q?n/r68mWf3Yb60GL5AN74aofk40tGGgDz3MstppX8ejmgLQZY4YHUbjJ99BCR?=
 =?us-ascii?Q?4IWYC8guuKpW39I++pyYcLEyMf7DVTNSoOmvnTC+LQ5MfrEcELZ1JpD5YW7U?=
 =?us-ascii?Q?x8V7o7n6u8skkvVrcFa1dxF0PBnCZz0lcHbij+qqYLKjej1dgG+UMovvIood?=
 =?us-ascii?Q?HWxignd1s8/ouwnJe1I0t4DbJRcVywm4vpRG+QvyFzJEULtfjoifkPCXCM5a?=
 =?us-ascii?Q?XwcVQimugB1rGFbkzBdddqXfU7USmFe9Ya6PM+Fy1fmZZiurHtK9mw5Uz0g0?=
 =?us-ascii?Q?ee1y1ovRLw8simBdaSODnTBiQNh8E4p5bMskdzvsNaoLHhh06YJI0vg4PtoE?=
 =?us-ascii?Q?CaXnaHC1j51Pw2KY96Tuv9xChYtjQ0lmSsbsp2G73c57ZVnbT2UkmQ04rfFh?=
 =?us-ascii?Q?geIFEXNDuWBnlLHgOTxTlT12L27G0whmaCmbhHigX+/ZypyngKUXNBkQ148d?=
 =?us-ascii?Q?fq4OLophUzaUPPH7uxYAP7eoCY6OnMzESzuADlCNmMCDyRRXtqY9ArXD9rKI?=
 =?us-ascii?Q?G4/qUhktZIJjL31Wz+6Ti0i1+/+nxmp2//qZI0dM271VVGH70v8mxKsuBE0l?=
 =?us-ascii?Q?/R1TYS5CKoc6tx6dEZZ89grRfTGsR38mDkAOPNB8tHaTAwPBFpXjAmkgRDSh?=
 =?us-ascii?Q?60zHWeVDBJ1NMT9H1t6YN1fD0foyEXcbAF0dMEmmPECZQm0D3TQrEElc5BNc?=
 =?us-ascii?Q?HT7Vwol6/j7VX4HYUda2SZJor2khoJtA+nTLpRNRglLl1aE0VXuecwyplfis?=
 =?us-ascii?Q?exqaM8RgkuEdBgSJKLrRYLJxA6jwm8Q/b2WY9htVc3fvFhOh799Amg1DSAcm?=
 =?us-ascii?Q?jFCVfDdI0/BiiCH5yP9XiJdsGpj0TcLDVEcik6rIaGx2NrXHl/EX0QhR207v?=
 =?us-ascii?Q?bHjaHRorknT+NAyHpUFLBiH5XnqidY59suWofZ9e3Ho89p8GDKEnBXYWWlEh?=
 =?us-ascii?Q?jq/JsXbsrTw5GKvtJW3PmMOv60ZRWdogyyEkAWQSFALjH3LdGri4blelgAwj?=
 =?us-ascii?Q?k5gH/PggZBpb2qCnceJ2mgBfZv5dinZ5UazZmeNTHFDpUoWSd8XCkcGJ00Ei?=
 =?us-ascii?Q?+Jtvs71u5ZfXSoJ4/JdqTT84m4jHzGe1ma2NLs/Ge7CoB4JD8hBYf0+qVEYH?=
 =?us-ascii?Q?A5xQ82ho3p7bPN/pQEfeyYupuScVj7G9jKZ+tPoPPZEmytFP2XRRYMJNuLJ9?=
 =?us-ascii?Q?gs44gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqZX2wmjDbkZLZ9PSnWvqTuFXLZjzDWNLOC4mhjG5eTtIU2ve1DZUaQviKNiym+zZ9Gl44D/nkRRmHTl2sDxAJXlP3DZUq6Zbl8rQnEqeZxyBual5pbZPHzcP/R/bH+lqOk/SylU4KxJimt9XeDxFBvD9pClBUHl1WdZ+yc7/+JdobklJjsRcy31jtccKQCtd46xwnRu2M6AIFIsuc9Az2ae3cmDrXvP1BJQgbwYdQhbHmo5aeKSiLPvppaOsD+JcUuDyOi38mYZDRH5uv1phXU1SV9X7RChvOwatyKFybgOUuM76H1gzK+Lg8i9zKdqD9jGgjP0EO8AOTexcZYpxlwVDlckpDFJkdF19/fFSATqftbaAVO0tDu000bwYxUzJAxZ/UOjuyhjLyUbq3jcf9aGhCjUHmRDArEj92XEP4544kB2lGCFN6K76eESc+zouppTqegdq5HhEWRh/Hz4SvV31XnjcSglcOm8GZEBq78F5Bog/XhXsi3OQRoSF3nCA+84IlI9LbiISpF/4WzKcuPnjRZC3PolO7Ti1L/ZI8Cbp1Pi5aM6ZPcBruzkTA3Rp/0BOWW52UqzWzxNOAPYmmnyN24henLhEb5lbu/guj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f74723-5c0b-45a6-888c-08dcef52659b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:53:55.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biDoZgww+qEEun/5eX8JVRHUZIDc7k2tWxZowR+/0HFjg0zQO//qk8VIlpmqzH9ffarGd/vhvPDwr1Qbfk94P8afErZs3ACfdIVg8lqSP6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_04,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180056
X-Proofpoint-GUID: B76rpvb7SzJo-hiLtMBebDxMhIbDJhBM
X-Proofpoint-ORIG-GUID: B76rpvb7SzJo-hiLtMBebDxMhIbDJhBM

Patch series "maple_tree: correct tree corruption on spanning store", v3.

There has been a nasty yet subtle maple tree corruption bug that appears
to have been in existence since the inception of the algorithm.

This bug seems far more likely to happen since commit f8d112a4e657
("mm/mmap: avoid zeroing vma tree in mmap_region()"), which is the point
at which reports started to be submitted concerning this bug.

We were made definitely aware of the bug thanks to the kind efforts of
Bert Karwatzki who helped enormously in my being able to track this down
and identify the cause of it.

The bug arises when an attempt is made to perform a spanning store across
two leaf nodes, where the right leaf node is the rightmost child of the
shared parent, AND the store completely consumes the right-mode node.

This results in mas_wr_spanning_store() mitakenly duplicating the new and
existing entries at the maximum pivot within the range, and thus maple
tree corruption.

The fix patch corrects this by detecting this scenario and disallowing the
mistaken duplicate copy.

The fix patch commit message goes into great detail as to how this occurs.

This series also includes a test which reliably reproduces the issue, and
asserts that the fix works correctly.

Bert has kindly tested the fix and confirmed it resolved his issues.  Also
Mikhail Gavrilov kindly reported what appears to be precisely the same
bug, which this fix should also resolve.

This patch (of 2):

There has been a subtle bug present in the maple tree implementation from
its inception.

This arises from how stores are performed - when a store occurs, it will
overwrite overlapping ranges and adjust the tree as necessary to
accommodate this.

A range may always ultimately span two leaf nodes.  In this instance we
walk the two leaf nodes, determine which elements are not overwritten to
the left and to the right of the start and end of the ranges respectively
and then rebalance the tree to contain these entries and the newly
inserted one.

This kind of store is dubbed a 'spanning store' and is implemented by
mas_wr_spanning_store().

In order to reach this stage, mas_store_gfp() invokes
mas_wr_preallocate(), mas_wr_store_type() and mas_wr_walk() in turn to
walk the tree and update the object (mas) to traverse to the location
where the write should be performed, determining its store type.

When a spanning store is required, this function returns false stopping at
the parent node which contains the target range, and mas_wr_store_type()
marks the mas->store_type as wr_spanning_store to denote this fact.

When we go to perform the store in mas_wr_spanning_store(), we first
determine the elements AFTER the END of the range we wish to store (that
is, to the right of the entry to be inserted) - we do this by walking to
the NEXT pivot in the tree (i.e.  r_mas.last + 1), starting at the node we
have just determined contains the range over which we intend to write.

We then turn our attention to the entries to the left of the entry we are
inserting, whose state is represented by l_mas, and copy these into a 'big
node', which is a special node which contains enough slots to contain two
leaf node's worth of data.

We then copy the entry we wish to store immediately after this - the copy
and the insertion of the new entry is performed by mas_store_b_node().

After this we copy the elements to the right of the end of the range which
we are inserting, if we have not exceeded the length of the node (i.e.
r_mas.offset <= r_mas.end).

Herein lies the bug - under very specific circumstances, this logic can
break and corrupt the maple tree.

Consider the following tree:

Height
  0                             Root Node
                                 /      \
                 pivot = 0xffff /        \ pivot = ULONG_MAX
                               /          \
  1                       A [-----]       ...
                             /   \
             pivot = 0x4fff /     \ pivot = 0xffff
                           /       \
  2 (LEAVES)          B [-----]  [-----] C
                                      ^--- Last pivot 0xffff.

Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
that all ranges expressed in maple tree code are inclusive):

1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
   determines that this is a spanning store across nodes B and C. The mas
   state is set such that the current node from which we traverse further
   is node A.

2. In mas_wr_spanning_store() we try to find elements to the right of pivot
   0xffff by searching for an index of 0x10000:

    - mas_wr_walk_index() invokes mas_wr_walk_descend() and
      mas_wr_node_walk() in turn.

        - mas_wr_node_walk() loops over entries in node A until EITHER it
          finds an entry whose pivot equals or exceeds 0x10000 OR it
          reaches the final entry.

        - Since no entry has a pivot equal to or exceeding 0x10000, pivot
          0xffff is selected, leading to node C.

    - mas_wr_walk_traverse() resets the mas state to traverse node C. We
      loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
      in turn once again.

         - Again, we reach the last entry in node C, which has a pivot of
           0xffff.

3. We then copy the elements to the left of 0x4000 in node B to the big
   node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
   too.

4. We determine whether we have any entries to copy from the right of the
   end of the range via - and with r_mas set up at the entry at pivot
   0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
   pivot 0xffff.

5. BUG! The maple tree is corrupted with a duplicate entry.

This requires a very specific set of circumstances - we must be spanning
the last element in a leaf node, which is the last element in the parent
node.

spanning store across two leaf nodes with a range that ends at that shared
pivot.

A potential solution to this problem would simply be to reset the walk
each time we traverse r_mas, however given the rarity of this situation it
seems that would be rather inefficient.

Instead, this patch detects if the right hand node is populated, i.e.  has
anything we need to copy.

We do so by only copying elements from the right of the entry being
inserted when the maximum value present exceeds the last, rather than
basing this on offset position.

The patch also updates some comments and eliminates the unused bool return
value in mas_wr_walk_index().

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma
tree in mmap_region()") seems to have made the probability of this event
much more likely, which is the point at which reports started to be
submitted concerning this bug.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue
discussed in this commit message was occurring for him.

Link: https://lkml.kernel.org/r/cover.1728314402.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Tested-by: Bert Karwatzki <spasswolf@web.de>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit bea07fd63192b61209d48cbb81ef474cc3ee4c62)
---
 lib/maple_tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 41ef91590761..4e05511c8d1e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2228,6 +2228,8 @@ static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
 
 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3643,7 +3645,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
+static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
@@ -3652,11 +3654,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
 		if (ma_is_leaf(wr_mas->type))
-			return true;
+			return;
 		mas_wr_walk_traverse(wr_mas);
-
 	}
-	return true;
 }
 /*
  * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
@@ -3892,8 +3892,8 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
-	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_wr_mas.node_end)
+	/* Copy r_mas into b_node if there is anything to copy. */
+	if (r_mas.max > r_mas.last)
 		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
 			   &b_node, b_node.b_end + 1);
 	else
-- 
2.46.2


