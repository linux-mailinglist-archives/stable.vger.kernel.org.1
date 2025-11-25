Return-Path: <stable+bounces-196860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF8C83605
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDC33AEB15
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CEF4315C;
	Tue, 25 Nov 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qmY58gJK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b+Oqd4wI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD9223DE5
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764047426; cv=fail; b=RLUI7MTv0f2c/neyBnMwLAzZ46ktoqrUv8forQSsRb8gziFD+4pOb+K4/FZR4jrrr54Z4devZK0W2QrrajVBRCRHDUph9Har1XQGGfimLFqL1jTB7ELrwLft/30AkuhSKgr0a4nh8Dbwpide1CplmZamLJ+Sue5lQPw+BbLK5qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764047426; c=relaxed/simple;
	bh=BZUWyDfetyoykUD6mVeyuCxEzX8PAeRgY++JQGqbSv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cT9+kHYyfvAD7vjp6wNfZ9HR5B3j2P6BegtLd1fN6l7M49g7tIlo3or9a85pQl86V74O5dUiLUdMnXdaDOUXF3KiYQEXGS3SzKA10MtB/kWTwotM89XzD5uhzaOvWreU3ogXeeArMD6j51SmD1e7ua3REnqzcOXvJ+U1mpSumA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qmY58gJK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b+Oqd4wI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1Cl8G2363853;
	Tue, 25 Nov 2025 05:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MYPT6bKLN8pyzJH0gnIuu0J4QfxA0tst1H9rPW30zPY=; b=
	qmY58gJK0uA68G/I4fYcF9NGGh1Y4Avha38HGdzpGFNUJn7jwFsuFFfcHHXfJupo
	bD4uZfX45JNHIRr9dza4q2LPzz6MuIOhI0vPfVzc9GZyChbYbjNeDh7KRuHjlAQY
	5jvk1pNSO90RtAI/dy61E0WOtvMe3zhxuD3RSlv5gac9Ze/nno3W7BFU4/Rd56fb
	8PKL8dtwnOVM8MM+f02V6ccVAcMY3Xa4QokuYIXztYuBZakYAgus5yPicFB3lduK
	euQSkgwoKvaEtf/rhAH4zPrx/m1+XcBSXPiq0yNKN36lDKHKNpgNv+AJghw2LDW1
	o2UyCeqWgwd0HDfnXhCZqw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8d2ud8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 05:09:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP55TdG022237;
	Tue, 25 Nov 2025 05:09:43 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mcqutc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 05:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+5BErScHU0olPSkNdcsASGT4TUaiCjIDd+BID0nPWkDfGUaZMLqON84czNuwrtoXy0cskpiCpn/pPjKx7Q7s+4ikhCnr+1UGfVJHsWmCktVo2tZePPRn/caoR7WamEfz7GtqHDctZ3DTJeyAQKE+fzzRwgd8tW9nJsgAtkZnHAEH7EXCklvoHipukbcfAzRn++yNQCkttUFKUjTi1SGfWLNoIMWOb/NBrqeKgmupKpGNADDfDlGib37BoR3My4/uFHgd3hD9sVA2hLQwspJ6lUnY1U4Nz36cUzXJFQCqbZblq7FddoI96es6CfyitLFCYo0iZ8e7iUPKN9qxRJlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYPT6bKLN8pyzJH0gnIuu0J4QfxA0tst1H9rPW30zPY=;
 b=jD/SDVS8CJ6lGngoFt4nIfIRqXd5q7pD/JCpQGoTbHzX+lRXsMMjNQdVmGjvjjRUDhVX4AvS+SZ69cBTOameBMGVgaxJ6mP8WJVIu2SaluFouqiHX+IGFxhDjwC/KtgqpKmaVPmpmpBhVYznbmhIHV05ztgm2DEr8Zoh/5MHyLYo5asvLegSkL0uNJ/lGopyk+CIBWri7IjL/J5RaR+rClTS8/4S1NAJTO6zhC41Hn/AobecX3mr3r5itWUWmkHEi7U6iAfPgry+7OlQ4xXhLHiVyAGDGL9zt+hEpc5j1ZBRNK7XR4FV1v8NYDkkcDEOHNAMVCOdxrf/d55gWm7zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYPT6bKLN8pyzJH0gnIuu0J4QfxA0tst1H9rPW30zPY=;
 b=b+Oqd4wIvQCyJRAQq692hpBLR6203jIHmvcO08X1mmgQT1W5+vgA5+Gmmh4Dd3b+7spp3gxlADovUYOkbZ5qfEdeHfk1eUE0QHGAU3i1Xz9bTZHWIEup7FnPwlc89YyVwOR3h7fmdyFgy9oXyjHJhygaaJCkBKRzcM5H186L4Mc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:09:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 05:09:40 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 5.4.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Tue, 25 Nov 2025 14:09:25 +0900
Message-ID: <20251125050926.1100484-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125050926.1100484-1-harry.yoo@oracle.com>
References: <20251125050926.1100484-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0016.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 451a650b-b42e-4212-9d5a-08de2be0d614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PqXlRdrlGXEnv6OPTKroZuYgzh/Et2slZe7FdEmYZuk7xUYiSa3F+ZC+Dev1?=
 =?us-ascii?Q?Bb9LRaMaZegd68atYCTJyfEmfA9DYvKOZMyKClhWPBj46EeBvMy6faWH7UAT?=
 =?us-ascii?Q?Kebob96cW9ix2VrA5luSeVbMEpBx9CtojAlB0bwG8t6WF1/17pnqS/YAH763?=
 =?us-ascii?Q?eKSQ4WTM6KZ0I6Si4kSVacQKlC8nb7QDNjPSVFyuUnAMVLkzLRW+OWhCBC6y?=
 =?us-ascii?Q?LdAClFpyQ5XYsl1Nd63bWVB17qbfD3O8s/mmpui/MB97EvvMKAF4o1YHyjgG?=
 =?us-ascii?Q?7rHK2ZCWUW68xHYNoXYHRwQFkHs4Ub9HmJIledLTmk2Lm+1oPL4n4ZUpurru?=
 =?us-ascii?Q?s0uPClLzSooXO1lfh0F6xl2qBZarlmCJSi2/bj9eVXqTQOsQrrzVzwx1xyen?=
 =?us-ascii?Q?VN7pzk53DzCNnDuVzeMCvFlthr+1k0AEArmuow8X5VGZ/oCrrSryKn9qbOJC?=
 =?us-ascii?Q?TKlCEZ+xRbxlpMbICnVWZEEe2AV29pXIjrapt9IyC+aIU3jOKAhiGW14F2/d?=
 =?us-ascii?Q?ArmY4ziCL9RbKclAy3l54bFQS6lEV7/02Npm/DWq7lSzX1/FDvfgIWAxQYCj?=
 =?us-ascii?Q?2MiYolU6+ZV3JtfeFLGuYXqt+TgLZ2wBrw3BxuLgeVVrHeDzdGZ4wS2O8kZU?=
 =?us-ascii?Q?FNKZqfKfBdTEBsgewhCZYlwOp8QgaGJnaMTyKm9HrhSxlmRJi/UGPROVJidH?=
 =?us-ascii?Q?uaAWx3+voCbUOvgTSe1+dHluMRQHhoYMltJt0173+/eXuOFza7WHijwRVQej?=
 =?us-ascii?Q?lr3TjkqBMY7NzYLE06zNvPblj2aH909tR+++zqP9YQEzjx4zmQc5N5wCFa9G?=
 =?us-ascii?Q?EhbMXbS2sxKfOqtHoYA4DMHSp68VpGjEtQMJSJxrD7aqE78ey1+UxKXG7hCB?=
 =?us-ascii?Q?WWnpCY+tyVvjL8VOMQ2u85bKj9uoeWNdSMPi5MJR8lWE2Z46obHfWGd7h4wx?=
 =?us-ascii?Q?fp6dNLoXTGkSWeueOLA92nvqxf//OtSTtOJbI3T+gOK1hxkdmeTQLxAwqT16?=
 =?us-ascii?Q?kMpwSyQvl6tciDGRBFavvIOvFLgL13/BTuM+gFPgT8Km5V09cP+wPB+5ywNH?=
 =?us-ascii?Q?6fmpo7k4CVjbtgj+YhkR9YXEX7T5MMBfT9N+5IM4Mlqp0hc84Jxxjg1xwA1N?=
 =?us-ascii?Q?yET+WikNUcVtCIaUJmELxvgTDR/T20qXcO4JYU1EYYZiE+em0d7Qy4i6GZvn?=
 =?us-ascii?Q?VkN/Po5EZmdD3DC1cVryAvcC8aag4gNmd4rM4eXYXV8xG9M6AZiYO9bpq976?=
 =?us-ascii?Q?t4SXJ5wDcQ9BE7eJOHcn9axhhTGt8CisxeXmgKoxkpGUTzroI4iG6DAFiVUs?=
 =?us-ascii?Q?uIuuB4WSd17qS/HX6OYXZm74+/Zv75HPwSxikSFwdwaQH4YmyfmG3RbjMBgq?=
 =?us-ascii?Q?FvChIAWf6mYanaIaoFzwOuzGGPDoCWUaqAebUTZi7Z8QUl5luqbEut+1e1xy?=
 =?us-ascii?Q?WpdlYLKCsZcDOHf3O2W4I0PU4N/cDbJI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XtgNOIAaSBPMsHJBvdymJntGla/7sTEC9klmLFUNAXyw+xSFoytf5DySfG4?=
 =?us-ascii?Q?EI9vNiKJtiXZi1eQgzSsoudrm1MWeqAiwJx86b7tPIGHwaJsTtA8LGzGxKGV?=
 =?us-ascii?Q?rsVhoi8bWcXH63x1RD8LbsEurbIV6da6FdOusubDtzwh26WLacR7mYDwWfmx?=
 =?us-ascii?Q?G4OLhsrsoKO2gHokLygSldz1dTzMQN6M/42io53SLSX9MXS+fLvUYPkqPij0?=
 =?us-ascii?Q?rQQJuARWCB3akLLKp8n3coSSVpTi/agSOmiexVLwhMYZnUqvrmuQfiO1GCAe?=
 =?us-ascii?Q?oVwqqKrC5XzrpMQ4fqkJQJ5RYKEe1XF9/Z5IGeXx6CoCVUKaTafMZOpM4bBc?=
 =?us-ascii?Q?5rNo9nNRscJAVjjEra73KYT/mERGDNawQFlKMPv3vPcqIrm4t6za/wZjcvup?=
 =?us-ascii?Q?TpLFOhOdy11zdFlKFHOHnWZ/FmzeL/XfgW0EGER7jJqNNNiY/ZnWPS+vCcD/?=
 =?us-ascii?Q?T+EeAMevJOVQjAssYuVR00fzf+nRSRPjI2/AdnJsIBWyoFj/pAqDLkYRedlq?=
 =?us-ascii?Q?HOh7NCNwVrT5ZrwTbjNU+13Al49XUelenlaAWlyNJagNkm46KqCzFsstt+R7?=
 =?us-ascii?Q?iaKsAbSfpdB/TypEB4AuTj1HUp3A8oUVH4iTldbgONyK+JDMxPkJnrp5IdNQ?=
 =?us-ascii?Q?RhuqkiEFrVuzl9o2kviENTjLNdoOQR68fAsKVyvXJZaB5BaTaxyatGGT4FDV?=
 =?us-ascii?Q?BH4DiOnKWbK2yTNiU13eG9Lq1NDDyWPjGxHmvhoY1RbsbQXzfKwIB6K/pIjc?=
 =?us-ascii?Q?ccZD0Ugyp2sYG9EwpICUw/JehZ89hVQ27NsHKO/8BTYLctMnU9ql2CHlJ/o7?=
 =?us-ascii?Q?ou0JQ0HVzjfn77feh/Dg62Xo6FAUo42csxN9F7tjOFduqt+cWsWl6siQsIV7?=
 =?us-ascii?Q?BTmeMVaChffSREuTFO8kCCCVMAnayZ+EBVtNeWrd2V1NgvxZaDfvfMGHwshm?=
 =?us-ascii?Q?ZdEdtkUdd1DZWaJNfeG8GmrskTw671amwKDff4cyUrZ9q4aeVO9NXUz//8eZ?=
 =?us-ascii?Q?ambfCsOOiUmm/ZoBzsLa64oWNGBJFAe5hnOEuAkojZ+TLLmvPvh1Y9FjDCAS?=
 =?us-ascii?Q?M7OlEbQ614oFeed8GPJq+8CdLbULssPPEakZDNmYgOWy9mMF397gegxT7tdk?=
 =?us-ascii?Q?Hhpv2Z4CG0s9bjBvl+9LhjM6YntsXRkAbfyoDLaMwv+235gL5QbqAEa1huCH?=
 =?us-ascii?Q?6fjyQ9ip8l/V9RXsH6/RFsPP0T0/vZzX6vseqzd6HDbX3Lx+e304ENCvBtx/?=
 =?us-ascii?Q?hqESfHqjd6pMWNYyK6JnSrwNgHiEWWZ7W5yC+4TySk7Z9scHgJQdgxFI39bo?=
 =?us-ascii?Q?2tZlH/q4dPsQpeoeG7P+/p+HshXBa5KTwlFF5jMA/FdtxtCS9tyRo67KLy/I?=
 =?us-ascii?Q?JFdcNrSf/630b/NHcQtqPnWV3UQIITxv65xlySMms0K3PH5dKisxwBl69C3d?=
 =?us-ascii?Q?6civ7ONYjedBbpKBFL+yTar17WWILvRTi2lgpxGoAQ9YbnJzOrUtK5iTNBg2?=
 =?us-ascii?Q?7ZgkyXFecHTXYdurxxq7xyxTr0L745J9FltfOiJPrYofFZeuNbQKahNlSqmF?=
 =?us-ascii?Q?IzsSNvuE0s1UB6MyD7CxcEITAf8p+NvJmDZgxk7a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x9lbHYDN3qYEiyBTTnSCf8rp87JKT4p1O+zFqF5jYHmbUxHa1xBU91YJg3hTXxLlztG1kIA3GK2p4CzOPxqnsgjFNfI2Bzz/uDQmPO6QwT8Y9t2NX7ZE/jrDMUqe5C/Zt9ewO/sAus0MDDpbuYb7HqiCzKOPwisFjVIf5Bt/pLq/9otTpEAqVeQ6U+Su5VHSh6QjKkS6MY6zzLHFLi+xPtD9mZgJgygNRisMx6p4Shq+1hU94gZRpHB7c67Vq4VJI2Oyu21JmVuJox7VepT/7jk0t/6AFbZbzW1Aft82h0mBcKmd8aURFoHiDuek6Gwkhd0vaNHKgvGCVpW31aFlP0WSmZHEcRE+8PdqJQ7+iwaw3h2vQiDlUhfSpl+IlCutrIywlDi4Rhzie2ssn1pT3MPWdDdt89lDFDc1r2DiHB0PL9taSaXkTbEfyfIonmfNXufioJaBZWLvEqIp3k1QCVsHh47CJbbtLc5Gs6Km5SiU1D1Kr7ALuMqZCgYipDzKOeZiXu0MpUxqCvcWH8370zeVwlPDhcivUuemxz8jyr/lkkbl0tFJM+ShzBeMDcB5X8k874EU6PKi5fSikpqHj97eWzNhYOq8x9Wg7qZBINw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451a650b-b42e-4212-9d5a-08de2be0d614
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:09:39.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVXWhCdWVicGc8bX8Ia9CiCNtp8H8a1puJkBL+7JVacru/ez8BOw1JTO9F0tyOZrCy/qVeOVLxAPSHJ1DhWdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250040
X-Authority-Analysis: v=2.4 cv=QPJlhwLL c=1 sm=1 tr=0 ts=69253a18 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yhwE2cpgGALx-dzfzvsA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12098
X-Proofpoint-GUID: Ruunk-2mUpzIIDxiVLM9ApS8IVqgCTN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0MCBTYWx0ZWRfX69y4sBdrTaUT
 dxOj5GFmeXjl3a/xL1taZf4qAgoMT0uiqHT/Jo01zIWEOh6Jb0spJ62dLAJUBBeFEot3gt+aHlW
 Sh1YFMBN3gJTBbQtCQXLnzTBHR7Xux5lOKExHiLf8l1dnh/NVHsLysfff3gW1Zn15oLPlIHTPJL
 eGx6daM4l1Kq8w6VCBSC3ZRyxPx8qeUwgjL3PPlRHoWqclWg3bItjUrzv6+FwrX8xCNDiGjOSl7
 r16LEM5EZ5RuoxBxOluYLB+drtc/XPTj1YN7x7bL3ey6m/x2V4VPLylsdJvohGEgbBlklAq1EFV
 5uWeRanJJzh+pGNSNME3oXcLxskmBwbx9+0GRPGPeSOLzNtBM10a6sgJg1x5hhMhMwLu58QGM8v
 BPVa+sr8xldsPYRnEgm8wmzq154NI0mDqarwF/s/laFPvEDNeic=
X-Proofpoint-ORIG-GUID: Ruunk-2mUpzIIDxiVLM9ApS8IVqgCTN9

From: Peter Xu <peterx@redhat.com>

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 26 +++++++++++++-------------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 311dd8e921826..e94ac3f6d9ba4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,7 +137,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
@@ -195,7 +195,7 @@ static inline bool isolate_huge_page(struct page *page, struct list_head *list)
 #define putback_active_hugepage(p)	do {} while (0)
 #define move_hugetlb_state(old, new, reason)	do {} while (0)
 
-static inline unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+static inline long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	return 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57cba6e4fdcd7..575b68a47fe55 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1657,7 +1657,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks);
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      int dirty_accountable, int prot_numa);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e83563b9ab32b..fe24be944e585 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4635,7 +4635,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -4643,7 +4643,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2bf4ab7b2713d..576b48984928a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -595,7 +595,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;
 
 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 95dee88f782b6..f222c305cdc7c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,13 +35,13 @@
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 
 	/*
@@ -186,13 +186,13 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
+static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -200,7 +200,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -258,13 +258,13 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
+static inline long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -278,13 +278,13 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
+static inline long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -298,7 +298,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct vm_area_struct *vma,
+static long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
 {
@@ -306,7 +306,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -328,11 +328,11 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       int dirty_accountable, int prot_numa)
 {
-	unsigned long pages;
+	long pages;
 
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
-- 
2.43.0


