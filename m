Return-Path: <stable+bounces-94014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76D9D2817
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14BA281FE7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328081CDFCD;
	Tue, 19 Nov 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mc9ikV3K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSYyDorX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84414658D;
	Tue, 19 Nov 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026377; cv=fail; b=uDvscsI5zGllVvgcG0V/+fk6LvEPLsOK6gMjID664HxKkxGD4/LVuwkpUaiDMS4hv33eqSnhNwiE+QIJPvBItA8bD47RhwXQ1EBtpXpPBQvLPyCqDaQkhZ4YMj0L9C0DBomcqKhKZTd0Rgcwd+CDG3QBiZsziQajKQrljbrVfAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026377; c=relaxed/simple;
	bh=J7rYY5+mBT+hAEstCQrduvctsGEtj0vQ3QSnu6C6IgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OEhd2hHC2RuAfd0p553QssuF1Wmopt9RW66z2s7Evbeq/dy/1xzw8B9UEDp1E7SHHMJwJIgXRkKXdXvnfCrB9t7YoYMwRmazhLqSztFvfNb1BPNrSm3JuAUiQRkr0MwEUid6g+iXAKYJfleW4RFQILt4oIdX9NrvgwwgY51x95E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mc9ikV3K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uSYyDorX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDho2r028729;
	Tue, 19 Nov 2024 14:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7l4CmtPWn+80oMX+2u
	caei1vsBoCxKGLAllcgU70oG8=; b=Mc9ikV3KK7r1qL1yobs3TVZXI0K05OYFXW
	6zbCda12Dk/0Wmd5ioE4RCXjgjFVUHXtONmti5zVxZrEE5g8X1hyICal86rDLONT
	YucCS20bfeWHqPo/Ad/ATcy+Co3au6Erl54NV89m8NsPfUc91Zqhu86Gv9uoAjw2
	PDg6N0SWH9kXZ4eAiyl0tZBd9ojLp+RwnHoUvzZ5eEAOiG2eaEzimt+5zZ1y8lsV
	gfhDrVfp35aXzkkEaCbmfZdmOONmJnyy/qv3MMAjoNBWACGoYrx4HpDHIhySX2en
	HwUOMrpSCVEWGL4+w8SOjI+TdVxXYwyOPq3fsHROA7xb2/pd3dnw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr3g5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:26:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJD1FvH007848;
	Tue, 19 Nov 2024 14:26:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8kg8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4NMn2j756xElNIsMhOggyAxOpzRgck/T59Jw1ZQ4RlAYMHJf7vXjOatA+7UYfKNsl2JeEE8lt4J0oZk8aEQZ6b1hQEzQKd/8jIr00uCRZhRu+EBuHvRL26yxdopTUh+6H0M35/X/X6gko8/ApPQ9CldFgV0OX2buV0ohM9haykJAeDVKxFCA4qx+wFgc0a/pf/wYjka5sh4e0fMB2JOyhxgC7NawaviIxfS4W3grfNF8TxcZ+paIyK81J2H9HYvSCKOgVyEiufSyAyAsqqaY0x4IGlfIP7AHYCNScmmb47AYRNt7pJZXX242rrcwQIMa95SlyhAjsT0gc6rMafmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l4CmtPWn+80oMX+2ucaei1vsBoCxKGLAllcgU70oG8=;
 b=RZbSG4yzgaNcoI35u/CheXGNciuh5tt8ecxYS9ekIwwkiUUvYUoptnHthxeXhx5IleYuF4z1VASeKJcj8Z8QBK4GKxh5GsTRZNQD978xpoJMZGBZOGARMAUSGH5kalf2Z2I4lm9WtEMpBvabmYTBnymx5ilkbLFe/868XOXRGBGuOCXTCAGk20w6JAVgoOxSruZIwlVOtHX912ESuxPY2UnfLe5lTJ3feUegwyiSExDGpmPnISa6PaKOg1vMYFeZIxmJ8XPiJ2uuEFkiAY4mgEd/y4U0VwtrejMlJ7J3tuigpzmizMCI6MJXdrPhNvbliTXe7aZ59T9KpDDawPm8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l4CmtPWn+80oMX+2ucaei1vsBoCxKGLAllcgU70oG8=;
 b=uSYyDorXiqJca1HOiAqv6c0lm19NOdep/zSvp2R28UPS9huI68mTCqJ+N7MrwqG8M/LkvgjejQ276MAa7lKtks9ie+MlYBRF8LtLJFxq8HZMzUkniNSQXg0VVrtwh5ABsFEhn3FASvKhWOhdmGIlXXQEILtWWcNHNJ8TVONHhXE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BN0PR10MB5061.namprd10.prod.outlook.com (2603:10b6:408:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 14:26:02 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 14:26:02 +0000
Date: Tue, 19 Nov 2024 09:25:59 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>,
        syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <6m2hn4wzvvgozrrvvivy6brxiafx6g2qaedkrcicxnmflcopzg@7idyf4fuymff>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com, 
	Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
References: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
 <qmmd4lujbzwyhxmjf3wagmfakbirjleufgkh6ozh5wbled3zp7@2z6trp6xlci7>
 <2024111935-tabasco-haziness-b485@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111935-tabasco-haziness-b485@gregkh>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BN0PR10MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: e33b3802-847e-4476-8f59-08dd08a6186a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQYn46f+W9SDuM6wf9QfEABjD8hckVGPtpgoTgehxr5VIi9Chtx4S3LMr6C2?=
 =?us-ascii?Q?Nl38YuamsDSorwdkGnHimvceMBEeXH2HDwaoFVeR5UwYjc/hPFU5qzma4xoa?=
 =?us-ascii?Q?kuHar/uhXxmYg2mcc8p8i4XJhvEyR4VfEgsn/ZaGQS9ncXGxIhUWygyQ7ajK?=
 =?us-ascii?Q?V8JINCo96+P6vpHT17Ro0pYAOADkPQCtRsvOojd2uVV3laY8aEOhje+aJsUs?=
 =?us-ascii?Q?p1lsckTO63cBUSGWh0dCZiIgJRJ4Nh8VuFT4V17K6IidJhZteXO9maUC2DA1?=
 =?us-ascii?Q?xQn5U6rnEGRzsedmYW8CYGyJKCTuzLV7ca0ouqwp2ZfZ6vByYwXWzZO5stUw?=
 =?us-ascii?Q?7hDY3e2rSki54rNk6S/jjA3YRuNs6i1aA4m3kPBvWpFtafWJkY9Df+5ZeT4E?=
 =?us-ascii?Q?Ds+bTCCm8QA/hwTLdooj8LEu1Bdd39wHwcgT80gF9V66t+DetkQSiUw2kNzK?=
 =?us-ascii?Q?d24PVnBfJ/fniaVXOSd3ddIdw8bD1Eau5Qw09eyXkOfGgv2a8+PVaGlkpJYM?=
 =?us-ascii?Q?8Rfi2ihrZLo3c1EkrMctYg7UPPzKFybeNMt9145rgppHyUsvDluNIuQQlRjU?=
 =?us-ascii?Q?ZsqkmsYqjW2aN7227PNhW91xxyvmG3phkQS/SSpAnDg+ZApxnCquu5iX1yZ4?=
 =?us-ascii?Q?k8HQCIeeAyLo2QKRo3nci7PW09SbbzJv1uKekxXhXhO6wuK5LWAhhgUvXxnB?=
 =?us-ascii?Q?GyBhVnk4aRjWPjxHTMt2JuNGPBE6Ffc6a72J9YoIbTFStBeyaAJH5XJwoPIQ?=
 =?us-ascii?Q?APYKWEyQFDsaIl20zWRomU1AyKBqAqAHjsi/Uzn7xNH9rT+eumI46WkIxngf?=
 =?us-ascii?Q?cuziJ00xPwwCT/YKJO0IgelccGQZu7tKQlrOEUOpUng3e7oNsezWnOgnrA5Z?=
 =?us-ascii?Q?vDg1L7H+wSsrKgAB65oBOqOhy+o9dfJf7qoEieH79aqBl0Pt0kBuk4cKp2UO?=
 =?us-ascii?Q?OsikWDlsdO1Trysu0gtogV9P/ZBE8FxVy3uDo3sBAJtNF3uFls44pBrKNdJn?=
 =?us-ascii?Q?uvGmvuRLOY/bbtd46UQnLUaISFK00HC3pmHWhvdu2X91waOlCnDvI45wQo/J?=
 =?us-ascii?Q?5EzbMdaE+MUGpt+AHj89w9m8YgkvVbBZKDo4gLh5S85nwqU/I25Rg8SK3yDd?=
 =?us-ascii?Q?+DaoAlRIqOGEPSRVoI1TXj2o+kNdqqGEPId3HvLK41wIlLIiCgqWHNPQtwbH?=
 =?us-ascii?Q?5MVw5bBHtBunKYFCyp2UN4GrbI+9xStKnXZS15SAd9RjzjUCBdJEAAmdzz6S?=
 =?us-ascii?Q?oOV9AralqlNW8AieUPgHt9eEvTs28jrOP4qKXJUYyQhUmj7ynX44riGS5n4q?=
 =?us-ascii?Q?xAS31JbjLRl5Y6pOlWn6YHrP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQ1cBQRUzr/E6acUK1Ywn+mwSrs7Ven1HJ2DuvNU69999Mk8gPXyIp2/l/+c?=
 =?us-ascii?Q?pb0opmuTqmXZeb5OHSDNPYwLnupe9Zpw41guHge4nKfq6r6JTsA5pnCSE2dF?=
 =?us-ascii?Q?bQDtIuSDfFokmNHiOpEDNeKHaheGLtcX0ZJroqftzcbTN4Tjo7M9LN+xi9/J?=
 =?us-ascii?Q?cY+kx86vI2z8y0MnLfmwpp0q/7BzzTTbJA9UcZhcByulf47LX9mvLi4xm2+1?=
 =?us-ascii?Q?425/3jTAJ1HlsQpcEQBZgddsICRaKdn5gZAqeb7N3f3YkTx4ooUONAHh/lWg?=
 =?us-ascii?Q?GpQSRr0Qv632jrlr475mwK/9CMmCgc7f7zL9qn2h0ONfSOpGSxPJafb23DnR?=
 =?us-ascii?Q?ClEnvorQlf0bNdCxTOMwWImzjWWrYXhpYDcHMUwBIFjgGYmR5CRz//YTcQTy?=
 =?us-ascii?Q?Zzqafj/HNhGDKoPXuRPV5Vm8Fij1Bx8rIV3nHPNKQrD0xR001nmZb0kClr17?=
 =?us-ascii?Q?w5s83wIe9WdpBugxHC4K2UWeilXbxIx9slLXC0REF6G1AZYhXbJTlLN4ywoe?=
 =?us-ascii?Q?Si2yksvYqXZ0hygpM+/Husq31919hCC4NgaLwXNVIplzPCroarR4cCxRCJVy?=
 =?us-ascii?Q?T4lCAtehWkXscvErv+hYHStF2n8ybWB/pv7EWzJ/YMJifg3h4fvcEXQ/9Hdm?=
 =?us-ascii?Q?ziY78WvpP/JR2j456gZQvrD5NvbWWCHm16rdk7c90qSo0djQxeP28drNnSnD?=
 =?us-ascii?Q?dbKcLgL5QICH6t4e8grCGzaUFmJFmOBErKxER4JSJDZkcuNeUzmnyFwld6Kz?=
 =?us-ascii?Q?0f9sK9HNZHX7w+dCr08OTYbVtvQvks7U40xQ7KYnYP+Bgoegbma6O0/NvZ4u?=
 =?us-ascii?Q?PVcJQU8yWMJq1f6Lf8XXEN8MZ0zi9OlSc6BdALA9tGnzokPbhDT0bgRD0JZo?=
 =?us-ascii?Q?lEER4WTa5aP+u3ki8SDmHVxK+e+kzs/boi78XofuAUltXsEXZfaUTfRlyPqa?=
 =?us-ascii?Q?UJZ2IH6ZfNT6RqBY5kDgGRKjk2i80IwoBLL3lmi8U+9l7Ch5eJvtPtv8VgUT?=
 =?us-ascii?Q?0uDTW5LO+YOmKdfinbMcPjVldpgKcnGnfRxAolecs0EjlQhu11IPcU5ERele?=
 =?us-ascii?Q?P3AK23ogXIL8FwTDMfLp4/Q17kMWaBPieHqhWI3j01XtjPB28MvNoL/r7czK?=
 =?us-ascii?Q?mf9J++GnprDTqVgZipasAB/j25XW9MwV+xqkFGBG1Sauufp41xbYGBL2Ggqi?=
 =?us-ascii?Q?XQidTVM7wlcZSUtQRkLr/sOjAyN89C1YOBuRh5vZWi40a94iCgWT7wXwn2vh?=
 =?us-ascii?Q?uVB1PLg5/yosgBiuCRnUY9Xx8GnaRO/AJE8bhQSagp5OwaZK90tA6KEXT0zy?=
 =?us-ascii?Q?i8t+c2fuO84PCNefWGnRcIUkeWBzvftQduGqj6/CvOUPRAQCWrS082X9M8nV?=
 =?us-ascii?Q?aojyQ822tblPvPhb5C1bGGbhWCPCayz72G+EC21fEcVhq5V2GsUR+Klei8qn?=
 =?us-ascii?Q?Bgi8wdVK9cRP267J+IKnG/VXt9VCFsGf3LFRsTafeHy8WLRcWTLIokE2DMQs?=
 =?us-ascii?Q?eRTYLxI95ZC5nosA+gHFKV+AF8J3uQCby28GIjUaKlKj8KXofqKTI+DBOAyD?=
 =?us-ascii?Q?e3kyGDnNqyVgqklZof+P/owE9V8RsTrLGr1IUDuwvDJOxGxuyPl30vE2xIhg?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6x6QCu7JkHD7WAO5SLiCpTlffOg5Bp8wJqRNOhaZ3V0IerGiJcN+QqtzEvZHuKTYhunzsmyDQYHs21RzQ6R7ypWzDxKy2JotnxfwdAQlYnqmuXQghZT00qaNhkHzf0Oy9uvkQ+h536RZtdnf41Zonj6Zm7IlTPDfAY3ir7YbgmYhKNPX/ruu215S7DJFYvuaMCEyx/FQKwNPXH/xlvgzKL+spuE7IYdMgGnj2pFhKWG3oX9InYpp+oL39Wh3Y2iwO2yb+NcVLuJAisRjccDqf3NS2OwQK2xom/JyCkp4HaIQ7cvgZxE4eRdpoxT0BWhMB/chZdEk/UfufGZsWI+WAlmTlgSVI95tZdm9guHjnc3UgSkozrugH8pL5IS+iJX0ymQgqjEqFA8wN3rJApE9xMFmv0dklbc7XbPFhVhbg0hf55lMaD1/wvQLfX/XbUEdsz0L8QIODyum02cHvMts1HJ6hZ3IlPiH2DEIocI8bdpoEhLnUow0fuwwfj7rCALGT57+VypEp2aoMPzyrDVqsfFxCPtPDKIP9UbOZ5hVSeSn1y9o/JtFFIzmkoEdNDgNBO96cR/bpKkJ0gGfHJGKZC7NE6GOAkZiZPije09mL6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33b3802-847e-4476-8f59-08dd08a6186a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:26:02.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOat3FnE/ZnK2d8Et9u/MSxpzu1bfCA0vh/z5+TemYLCvc+NmTjBCE8nnljed26W65cf0fax+/tEHuwTwh8LSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=554 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190106
X-Proofpoint-ORIG-GUID: CcYfTawVSBh3BvrRUNXzYHMm2nw2KpQe
X-Proofpoint-GUID: CcYfTawVSBh3BvrRUNXzYHMm2nw2KpQe

* Greg KH <gregkh@linuxfoundation.org> [241119 09:17]:
> On Mon, Nov 18, 2024 at 03:32:14PM -0500, Liam R. Howlett wrote:
> > Okay, before I get yelled at...
> > 
> > This commit is only necessary for 6.12.y until Lorenzo's other fixes to
> > older stables land (and I'll have to figure out what to do in each).
> > 
> > The commit will not work on mm-unstable, because it doesn't exist due to
> > refactoring.
> > 
> > The commit does not have a tag about "upstream commit" because there
> > isn't one - the closest thing I could point to does not have a stable
> > git id.
> > 
> > So here I am with a fix for a kernel that was released a few hours ago
> > that is not necessary in v6.13, for a bug that's out there on syzkaller.
> > 
> > Also, it's very unlikely to happen unless you inject failures like
> > syzkaller.  But hey, pretty decent turn-around on finding a fix - so
> > that's a rosy outlook.
> 
> Why isn't this needed in 6.13.y?  What's going to be different in there
> that this isn't needed?

The code has been refactored and avoids the scenario.  I'd name the
refactoring commit as the upstream commit, but it does not have a stable
git id as it's in mm-unstable.  So I'm at a bit of a loss of how to
follow the process.

> 
> Do you just want me to take this for the 6.12.y tree now?  I'll be glad
> to, just confused a bit.

Yes, please.


Thanks,
Liam

