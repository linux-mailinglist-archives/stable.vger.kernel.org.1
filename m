Return-Path: <stable+bounces-179066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853E8B4AADA
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737201C61C1D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326D2765CA;
	Tue,  9 Sep 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQmht3FG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cuZoZiIc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FE9463
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414484; cv=fail; b=a94YuQUhcQcgqLrfSBiOV5AoA1/reKywFY77UytzoHCWyJRUdqo67n+wLmuxQYFcBiX8ZmMyLV0IHHYSF+Vf77GnsxoVyQApukuOJTpJCGDSNmdGEINXQUg14nea9iAdEAbn+Wz7IaHMBkafa+vmjSDFNwlTJwQghaJcEqRPb5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414484; c=relaxed/simple;
	bh=9GiSudeqCqEjK9Z+dykI83HyxQo0RlxQWermbQdbwmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AERza7DG0BpbiI8srgG2yDUi1erEt+hemDKzb9CeK6b42psNTLnxiS3i+KTXCSDoWUS4TZtqBLDjF5HCzPOeuUYRPINxu0UbRZjCO9vMSvIhu7y/AUJIwYycJ94s5mKKBQFk+1hUQ/87SDAr3HTtoHsatmV97P1pIna7axuzJX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQmht3FG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cuZoZiIc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897fnqQ027343;
	Tue, 9 Sep 2025 10:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wCgGa7bgoDoukmD/gya/w9ZwFpzYu9HTsQ21bEeuQu8=; b=
	AQmht3FGRGWGF9wTEL5AXYIlY4ZxeibywIH859ZfFomaGsNswxf47bNIAQU4k2Ir
	LgFLTLm0JyPjOW5nePSbKICKppKszHYDMClsE0/GEKekJJzfpDwr0uQPq/kbnc0Y
	WZAkjL8WPko0maMVnstomhKzyS36htKwCv24Te/3qnp8KeK9ErRJcmsg1ul8i1Zw
	ngdGFNjts9SSizKdgYfyOFAeiz6gHOuRRCbX/Oa6AgKnSuZFxTsLMnvR5ZauTZ0v
	p3uUD1f2u+btuH0K51pXp6z5xY5DMZuQ+0mwz5/qUP1wL4aHhIaVNiw8tZQZP4Zj
	kntFqXeIGNm5bsOv8/2kcw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sskqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 10:40:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589AN7UV038958;
	Tue, 9 Sep 2025 10:40:31 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9ebj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 10:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILG64zJQ6sfucd4IcviSW80/s4S96AFWYhEgF7VlJyJPKxvj9nqdVX3zxEBrNjuDE1RYLIjDkFpzK5wRqwphSzXT0rOMtczy8LC91wu3+lCQeZAVqj/PDV0SDZAsYWgWa7NY8N2vn99LJj2LaNBD5v3piEI4h5AmTYws1gNh+FZ4UWxHvs5SVlGZ6nmg5NNsxC9UeSqVHTEkQksf/oow334h5hleJA8cc1QjMxNrht0WMngLpLxpG5h9OgQkDd52EDPpgiyXnaXyc+IuL2EGX9gZkmwP8HP4OMOEDK6NWlE7LJ1RCqbhMX2kI7L16PGY6ZgrTGnFq8vCUTb5brSXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCgGa7bgoDoukmD/gya/w9ZwFpzYu9HTsQ21bEeuQu8=;
 b=nymAH8jc8n6odrxxZOShBffxC0hvKSKduIj3W/g2i6m2ZheafQyjLd6K1CUdQLTTWpJqpXmjKITgtx/mreL2nCm7146DDgSnL7fPGay17vJhpwOJ56Hgcn6eZtthMZ6/1WuYgK6ZOXb8a5M2OwfWhu4hrg681ram+yYqtYLbgRr7lBoUpYUGhpUlSj3uucCwR+5hbzUSpTWPZ6VMfLqkD3uX/k8E8qDC2wVdIZFxK2QPAGLQBTq2/8WTBAmQYsq8HVMumi1pOtqH7KX7na1i6ZJPpw54xsfKRZ+tWUVOEl6056OdpaLMr/C1VzaepRYk9up/sLNi6i13J2uOVvuskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCgGa7bgoDoukmD/gya/w9ZwFpzYu9HTsQ21bEeuQu8=;
 b=cuZoZiIcYmAXcosVFNHMT4vlfQrVZEJKwbFdbrssfe5BClaxkL1pM/3MeSA0wmLwKh7Rqhtgqdp9GpTUuUtn+SKNx7zudFpAS9AwQbbwFYRz5kt4W+JkzL6mj7FTWGWSLctWpb4HJNUPzyaQboLbalK9k8IaVm4mtAYdzJLxf5U=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB4983.namprd10.prod.outlook.com (2603:10b6:408:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:40:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:40:27 +0000
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
Subject: [PATCH V2 5.15.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 19:40:20 +0900
Message-ID: <20250909104020.6219-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090608-wages-saloon-a401@gregkh>
References: <2025090608-wages-saloon-a401@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0080.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b03c61-4de0-4696-d4b5-08ddef8d49e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7hKJILJk6b9C43rrJOejPVPfGqApD1xWDOSDYLTc1zraYybl/Hq2/cf4hm0O?=
 =?us-ascii?Q?m76gh4AGFPNybzNmQNv65+ERkazjZJbVn+nEDrnQt3aeTPdm/MZMmYF9tZwZ?=
 =?us-ascii?Q?uwO50IAyZhQhlrV+MbYKmUCcaqrnliEDMknS8oXBeYd42YEeLEwhQ2DQa10t?=
 =?us-ascii?Q?UvVFhH9ko1T4jpVLCEdPdoqZayfar+NZB7ZcMtRoHPseeNpwejBwzVZMLDPm?=
 =?us-ascii?Q?2+h4pPa3bpn6XsxM8GL8xTVwcB13uLIa9SV60l7CgOVMVxGiPXSo3b34ehih?=
 =?us-ascii?Q?WzJG1uQXtbPgurB5CWEKOQWnTkDpXESwOudg/l94WO9IW9+FWiJ+L6gdjre3?=
 =?us-ascii?Q?es5shI7JU/ZoVF2knHz2WU5B1WPZmNeEiaW9FekZ/qIbc8BLWvgEzp9x9oXu?=
 =?us-ascii?Q?WvM009e6OD+j4NaqzkHQkl7c7c4Tlxa9vVbdk7YDaC1BiZ6oJYiVj8BlD9qE?=
 =?us-ascii?Q?FKLuvQUOUtlNJdnN5I2gIcrdUmyn0zyn5UuU1SxQnsuyqHg9vxbw92OG0n3w?=
 =?us-ascii?Q?CocuxsY4l2AeuTUuXojVoX9l5sagwiUHv7t8zzNlYe/nFwl/OSxZCSK11lzD?=
 =?us-ascii?Q?sTDV5V2Rt4aGqTJq0PjAO5BxbWGuNtLPZ7tyOSeonGE6CYNc4kBZcBvZTdkv?=
 =?us-ascii?Q?Ey45zCkA7SWqpvoN5hJvXoIKHI8eQzTrvriZmLaw7LNfgaF8rKvl+TON6sOi?=
 =?us-ascii?Q?wQQzPvLUoeyDH5jbj5HAh8ORqIba+A/lWTmKSvpdRT5uKRTMRkZefVCZsXMf?=
 =?us-ascii?Q?s5ake2AcNeytgxvwiaJ02KDsr8iXTJiWrZ86siamSsLJltNjDOWWROO5ud8Q?=
 =?us-ascii?Q?mTzp0grDxDwO464QNh7PF7TStE5EdohF8sob4H897Z6lZcZ5DDlBaGUF50Uu?=
 =?us-ascii?Q?hKSoQpRbJhvutOWlTPkA5ZP9Xj79xjYkSZTtzsRJZSpAV2KByPNfE1H3xnBD?=
 =?us-ascii?Q?TbNCBf5OJ2rX+ZZQbmP1GNcskrvIsGjqwpBcniR6XpFN7MNx1AsAlouw7hgW?=
 =?us-ascii?Q?B3bGuz6lVNYdQidKC7jpR/KlJ6+2wanTOf2STwPgMlZhp3MKzpZX4Ff3nHpF?=
 =?us-ascii?Q?q0uvk01zmMtyMY5U2qsdna2dUfmOOGqDXNOob/mMySjQl48wXb2UYzqgirOf?=
 =?us-ascii?Q?oK4sObJkxvjVs8rRjPXZS965HH4ABtmz8b8bXdTub10Mb3dEGo5qvfk0EeJe?=
 =?us-ascii?Q?Xpv4/dKc9Vhup/Fh8uOqWMNRsYqVY3V+trSNn2j7JsZT64gAMdXIcYM+HUxN?=
 =?us-ascii?Q?1zHmME1MYcsF+mx3cdZibPyYEalUxIe1LTVCnIIWcodz3XfZGMks31a+yts/?=
 =?us-ascii?Q?h7fhnaiUwbjkxllkqwNOGBTzdOr9PaKbezM4n49FT9yDKECD+KgkAiCHBek2?=
 =?us-ascii?Q?28vCBn8stHq/AcbjK4I12SGeeoaQiRlQ9rmLGB36IQfFw8011TwQl9NbfGVB?=
 =?us-ascii?Q?OurevMnIvOCdCusq48OHf85P5Di7LbtV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+d74Z5vmar3mJNZWQ+QkKwTR4MdtOQv/u/HmQMLvzoyf2n0vBaKHQEY9C6sS?=
 =?us-ascii?Q?LDgUYR9kN965z6cm/pHsA8ajhCmQ9IESYlz+S3nL3jWOS5R/0jtH+QKKoeuV?=
 =?us-ascii?Q?qACew4Dk9M4/qbM8QcAfgZWKtrsPvf/BmYx91vS3UpZhwIT/PsTH6fThBBE9?=
 =?us-ascii?Q?SNdA5iGcz0bipnflQhKYaqoFDkmz059wKkyQ6MOQz37vCwiDoVNu9GqN6dHu?=
 =?us-ascii?Q?1DrYXfLxURifB6ziwM69uxSpQzDqjYt/j0Ca0DMyezC5/dGK6Gmar8w83Mo3?=
 =?us-ascii?Q?AfCkLSpiHIgxTaXCo0SgjB/Ix6dd11O35NaQhe1pBO/s6VRCD/EJK/1GF8A9?=
 =?us-ascii?Q?0dcv/8QhqDxMjL0BeGIyaaWOS+56QDMKrNQxGwPLWSip8ZldKKLwAf4TMfIG?=
 =?us-ascii?Q?WmwaH99KKqcgwt/UY7o68+Z7u5od5lE+g9tP6COw0+Gvk9PXTAvx2XkNDqBu?=
 =?us-ascii?Q?zOg0nZh1iZ+P2tIxtPN0gfpVSFbV6n0MsiZcCJdhFQTuKpKCmWTYMgg+Cnb9?=
 =?us-ascii?Q?9vXtg8CouCzZoUkZn82vekb6upF9P0KKwQW1x2SPq3+rIbu042WnP+Z9Skq6?=
 =?us-ascii?Q?NFESuaavZPWuzbzw4xduwMuBtGfT3B8Dnvx0qfjCEh7UtxtibPWtbINFmgub?=
 =?us-ascii?Q?LyfkDDYKCDA2BB8z85RlaetGmx8L+tLh8h0t1DZ4wCWHEws7iqlj4AU4D2n9?=
 =?us-ascii?Q?wjPd28cJCUe51dNPQV15qLUfbBZKYYh9bMuOrvuXlVZO1kX45hBj4TgOXgf5?=
 =?us-ascii?Q?lmOiWtimFzbrGboHHrvlxLFZikDdrhGcERviRQfChFdpeAaNdTplJtmaRjD3?=
 =?us-ascii?Q?UvcMZ+ry0SxjU+0qMF4uWUY8ouHULEUezIxk6GXKJlYjdRG/6sz5xc20q70L?=
 =?us-ascii?Q?env/PPCAOzM0aVMC9j5dt4gqOSMc0tzquIGUDJ2AWtQQVZBCCrcqRjeRqbCs?=
 =?us-ascii?Q?7/1Gsr9b6R3H6ngqI90lWo8F75SRZ6BTA5KElppDAezXws3YZdaLjEf4k/4t?=
 =?us-ascii?Q?gCBqAYYy+5vJvC4Yk0ThRGy0evu86xReSjba+hXZNaZChE8EZ6ZH8BpCJa0t?=
 =?us-ascii?Q?33CurCltI68f5imWvXhYVtcmywIiWvYm6VqMT0G2jGPAE9YZCaXpAcDu9PuV?=
 =?us-ascii?Q?LjthfuM3qtpwhBtnDsdenLTaqcVmT1Q4Pby4CIK4jnRf8eqlvAritrY4s/Pf?=
 =?us-ascii?Q?ez44P/l9RZl0VTq5CCRjdzVoCTtSyB7WR+jy5I1FBLpynv7Nfihgd02ht/AK?=
 =?us-ascii?Q?Jh8yd2anmFFborIULPv6FDZ0zUzOQEBPySd+5TItp4DWozmKGhxmhF5w/48o?=
 =?us-ascii?Q?8oqBOJvrkvhb3HnTgf4Z1me/vl07/P66bUviljIvarYKDdDJb97KKpX1wMXQ?=
 =?us-ascii?Q?iP/dLeXsPzqOo+mNLkSPYAyHgxUsSEsTO38YF0flDdMmp2t1L2Mjzv7t5Jfc?=
 =?us-ascii?Q?AUq+UycoBaZ3QlhQAgFWTpXi64XTCCimessyMFk1e8cWJv03pCPzppV9hSA6?=
 =?us-ascii?Q?DAksCRvv6xIuxVDZBLtWHmjuoUIo/2laNzZA116EgWonZQhmzif76RoAc9NK?=
 =?us-ascii?Q?A07075UIerVkWXPLAXv3bfSYnyCo5rMHVuiyyRou?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	poFeCWsjs9q4lWzasfEu9pBYPHGOSnUfGaGbYuLjAFFQvVmVJxV6PR8xTC7gWpxOUotE01nZJsrcBRY1kuuxdxShV/vGMW2CB5y9i3jvF8WUqEf7dA+TiIKgLNJYHfeouMpo8jX5XAynPAt64XcrID94tvmY7tlnNu/qTk5RSj+grq+y+zf7NnQ1pkuMjBbj80NWHfjdL2+f2jWhoTIbiIfDxsgZjNRMvhyRUCMtwne225JV1Qif+7N7lePgQYCobCtc1hYHUuQDuH3f9KEwP7CmD7P4pCtACeT6SNJPqiv+uP0GzHRXeAI5UXbEh72KJWGalrZjudczAc89CXr8PmtnNi3UZ01nu/KwXRzvWELtAWteaRJyXwsiSA+Deaj2HwkJCNGGDmXbGMNUtQoWC879ZviCiybyvhjliooONIUsyE7y6m7X8dbwAS6Nc32y6sC78ixTNzjw+disEJVY4LQ06zVT2w4nA+XHnpX7Nvk6YUf5R0Eg3cdqNHg7mqQ6CzRIsmx2ao5TJy1H1TiyK0zTq9m/rHTablTh1BrN1lNpHGl3x1p0BY2qJFREKbG1m2/KVFaE5/Sn6S0dRXNn0Eid9Bl5DfzjRw8eqkzCFwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b03c61-4de0-4696-d4b5-08ddef8d49e9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:40:27.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTODPWm/2TwNOOOeUdk0XFwGp3ao+i4USwyehrkI+mjqAAS6Xjx5M6cWQXkWkKGvpUIxX+3Cl9gTdDBucFzOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090105
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c00420 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=fXIjmmjfsnuEW8ROR_UA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: 01at81hzSO7LE4f4laq3Ae4bMMJDvFbQ
X-Proofpoint-GUID: 01at81hzSO7LE4f4laq3Ae4bMMJDvFbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX6afAt0/tLgav
 q8ZWsj+XRkL4UwX6IOQ87PKtuEzSFIzydIf9/OKaLCPqPZnz3baplwI2EIKZWkHNC4jsf8GWBsc
 GssUvXmghUkM9fJWy5VrSUE8A3H3duHjq6aRP1AiSFzD5/00wJd+ECBcUvN2WDhgXib1sho4vF+
 mYtvEs54aoF1bG5sJfgrhA6IfbT4BIk+wU6s5q7d6DCybEjmtuXuWrla1fowtvWM1zmQXE7DzYp
 kg3pF4y/NoE5rVPx90pi262g/REFq1eEwzo3u9iPQ+ZXSSrt2HQTWQc/mfIpTp17L1FwJy6OCKw
 wkD/NbziZz81zR0lV6mfCO2WMdoFwI4CYMKbxq/xSJCsIjUYp9SOIdgK4isB7Jew3jKlZV29xn+
 X3JY/cPWQlnTiVr3cm7efNDVtrrhrA==

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
[ Adjust context. mm/percpu.c is untouched because there is no generic
  pcpu_populate_pte() implementation in 5.15.y ]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
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


