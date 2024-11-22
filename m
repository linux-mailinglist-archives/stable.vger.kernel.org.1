Return-Path: <stable+bounces-94615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4A9D60AE
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E891F23C1F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C560890;
	Fri, 22 Nov 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9rCY+SG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q7Qe8BB6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDB79C0;
	Fri, 22 Nov 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286676; cv=fail; b=OyJCTX7rxJDHW7EbClxajL837LimlRDHBjTzlO9RPMRcp4xFDQJBa0qvIEx8+xznqU5HqJlKo1CpfhK8i3YadEGmdsIVb+d7iaI4y7yl9vIWS71mvMC177c9Mrue2jnufF5pmWoiMBHRQSWr1lbl+CZcOtP/Y+iM2cZ5kk/ZCIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286676; c=relaxed/simple;
	bh=rYqrVABrZgB+H3yvTBcqRDOtRbuLMY0DQcaRjrxNL1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFeE4dYQnEbow4LzdJgJjs4ercGdWfpBrX/OC8mxBoc/gOJdqhq9vxXnLg9DfDayNAoRucnfiSP4+uFtJz7yOP9JIHoACv0YuaIUQQMbuOt/nmWJBNvPJKSEYm+V2vEnUvTqHfRHy11jWVOwwjrJKuyPJWeuMoWLCy6srBlLqt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9rCY+SG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q7Qe8BB6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDFJZu018979;
	Fri, 22 Nov 2024 14:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ELZwtnjR3gh8jq2JQn
	OU/aJZf7wjkWWuHtwYYN4Mr8g=; b=a9rCY+SGAP3YaQQffFC4jyGfoAFCrkyL5P
	nMWIBKFizJCSiSOjKz6PfZC0AKHdkq1+KQFEPfU/r92/eBGOdnX0VbAYhUkHnfh/
	w8+JluQE1aTaqZnr848Y59ry0Ar5yZOUPZTm/c49XXGVEtxeTte5K+1Al9Q+TNEq
	xJ1QTESEGO13oLBNlPAU8VY2vFNwAYHrdrK/jC1aY572ROfseJY2O6OBY9TwIMag
	3VCaiTbbuYsvil1p7HFyLY3aP+itJkDMdk69ZPOHowWU2q6UI30LEh98je/sYvop
	6LN2rhXZo+zFprJBXGoBJ+wO4EI/uI7MnV4ZgPUgMmcAEu4zB1dQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtcc6eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 14:44:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AME8vZ1037199;
	Fri, 22 Nov 2024 14:44:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhude0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 14:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJA51Ba/7RsTFzfTFY6uy+pAWT2rBBoXep9eAyjoDst3i3iYHEt3cqoWS7i5Q4jXjZHRxuZn93gQyePMHqk1+c7shdEdYSTK5zL5C0FyEKDkbsi1GwMiS9n/k/xMz56zCLclGokaWFp6iAtX15AeqrEx0a2EzWPojDsEUOv2jrjEVLNmBEMYlLX9E61IQshUX5qqFTlZqc3D6EGI8gBBDdx5RKr9e/gSDbkHjKmuaeygYgT1BbA3kt13CMltJ6gux/reBWVWakJ3UUvkpgDso2FcgtD6Jq6jtNGM9vh+9S4kN0ObTr10bVgg0JMGBsCWj1SY86rW48REbVgSCUFiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELZwtnjR3gh8jq2JQnOU/aJZf7wjkWWuHtwYYN4Mr8g=;
 b=qN0CeJ0WGM2JNAtdjmTCBE9fZAYyG2FU19BXTfW8/HQzxQWsrOm7Foajl7yKb4LcHEIbmNaR4G+1newqcLPIPqiIQMldnPivIOeu8s+vI0Oy3eHf86kNPbJmx5IBHqDI7oo2SBIKp0dD1mpGS4vlt/abtToOUFivQX/5LM7a4ihkk17hS3EuBCR7LhP50Jd5M4GZxTr1NQHjL8x5FmN2ryI0JmFgy5xwv803FuZsElPk/4Bl1gOMf+4sYHr+UAyyZDM3JEWqK64/1TMLKnQuhBjC0/ESk+A2uG8YSc0HUGBaLJN74ZtlUBEYxRPT0mgKSsdjVSevB5TtHW7EtOhxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELZwtnjR3gh8jq2JQnOU/aJZf7wjkWWuHtwYYN4Mr8g=;
 b=q7Qe8BB6T5MTgjbwGNgZlgmKpNo4/iAgpzB1TJWy2l4L30LqwjHOukEwcrvbOTsxxLdciu245BOaGX9Idt3Nl1iCZQprxjWJgeUZCVixXVK7tO8bJg6LFsU/p3zcbW362hTiAO0TPedTCISmp8pYDR2XpKcnlWACWqGgfl+NGiY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6749.namprd10.prod.outlook.com (2603:10b6:8:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 14:44:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 14:44:17 +0000
Date: Fri, 22 Nov 2024 09:44:12 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v1] mm/mempolicy: fix migrate_to_node() assuming there is
 at least one VMA in a MM
Message-ID: <m4p5ngz7l4hgavwysczmliqrgumlx6dxg35jjwlpcmqtzrpmsk@q2wwxruumhrl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com, stable@vger.kernel.org, Christoph Lameter <cl@linux.com>
References: <20241120201151.9518-1-david@redhat.com>
 <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
 <20241121221937.c41ee2b5e8534729e94fc104@linux-foundation.org>
 <608c7f17-037b-401b-9336-c26bd45d3147@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608c7f17-037b-401b-9336-c26bd45d3147@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d9268d-e1ad-4e68-323d-08dd0b042465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xgrbm5+q+xSkIKn/UFRyCEY0pASLQppZB0lTmfK1N1UT3fYMT1BO7bhczXEf?=
 =?us-ascii?Q?7FwJwd/X7K9wXQ80h9yGKFw/VKAU7OqjPdNxA14ZfcQTMiH68sdx0SEM+1Iw?=
 =?us-ascii?Q?PE3E3dDuti5IghXPqf8i4axv66tQsM8jgP7f35jnvd+8ELiOkjvO/4fTqW+F?=
 =?us-ascii?Q?FRKVUPUCWIpspJel06atvMCWemjfdulnCd1m31lWg1/myHEdpgFu44kWejfL?=
 =?us-ascii?Q?Teb8ODjzSI/5KtZJdYLvGqmPKC2OyvId4PkRTWY+CnKHI+Foct+V57R8x7KV?=
 =?us-ascii?Q?s/nbk/9xRb0HPqZgKxcByrNKdubAwHW+ce05jmRamwMc6AZww3HLFwer5oGH?=
 =?us-ascii?Q?LGggTmgRNexpqdNy3pEw3beziX1yfFJjLk5Pvw1bxvbBtEsM7R6u6Xau7w7Y?=
 =?us-ascii?Q?90SFflPO4go6oYwCbc86o8tl9p11mBLZrLnmN05qO/bylk5oAnwAFSojWWB4?=
 =?us-ascii?Q?bYLVZLYESCd4CZzEvKq9qK7ZCKCOfnBhtOPU69nrpb1AWLYF+nfkKM1V7CaC?=
 =?us-ascii?Q?cWRJOY1b3J/J78pC6zu47Gob6LR6RjJqnvmPWfrh/60TGcKUVKTKzH9T4lSh?=
 =?us-ascii?Q?k2Hh49NCiyVqLOxBhg5BB+hzroGREU6ZsA/5nlA2rbHZKzzOBOVekXa+s46E?=
 =?us-ascii?Q?viYKBlPL5/w/pc8gUIMFdDEC2ssYdqvgeTuQCkknkPvYAzRIFaSElYw1rmgn?=
 =?us-ascii?Q?2aPIfipvjjO8AL1Smsg1LKR6wRJN9qaMnXTCmmp2HypYcL0usUt6cvwLddG4?=
 =?us-ascii?Q?wWI5paaU4WH/eEnN/OuV0ifIGeBbXPi+QA7l5RfUhCDy/QyKVCJZsfLqUW9C?=
 =?us-ascii?Q?XC8Hjql7HbENCFCyK+WDAGL/JhANaHUDo0Ht5KUO4GZqZxOegI0nYsasDINo?=
 =?us-ascii?Q?PDCe7be92iHZ9G+8A3tHA4Nz5Ue1LXyYx636MGRtrLyrH36AR2XmbuRLZ2fl?=
 =?us-ascii?Q?ATliyehpHZIQm5RKYmzc+gjK80oIbCiRp162sgqFd4QL6lxwqhGFznMUWVRO?=
 =?us-ascii?Q?0NTPm9nou7gWFtFg2i2wQ7QWQ4V2QSFCOGVY12DBmxgrbhLMfUhy4cJh2nrF?=
 =?us-ascii?Q?/YXcrwoIu3v9ioAGndYh8sTpvgFHoh5wT7PzmrNK5LUia0ka7/DyAtDnSGCs?=
 =?us-ascii?Q?HLbbLhAQ38vIfHIyLjxjaw8wZxS2/Ch6HIy8OwtQHWWKWyO3QTAa9JCgf4re?=
 =?us-ascii?Q?rBpryM8X5t8JR3tX86srymqrj3WyXA/JmQA/DOQd5/ccdeYmX3h1wAi0cVxO?=
 =?us-ascii?Q?rvIVaCi/wd/VmbcNVskq1T6DIvy+ZkmBnRkXxiqreNPfKEDwPICZVmgy+UZU?=
 =?us-ascii?Q?WAtLDpiIwAiZkBTjOO2TDpSz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UsI4fRKPqhhAjVZrEgTE7YYm8L1eI43eWLdK/dLznHUrGp0yAJR0zPZvD81E?=
 =?us-ascii?Q?6APmo2sGv/xF6+f6wM4u+S+YykcMkT/2NLB79p9EnPOtBuHB1ZRB8SO/mVWh?=
 =?us-ascii?Q?/zzMW6gpA3btd6Axs6/AQpYmlv/qLKT9L6s7y50dmWccD0/IuU3HcaSCgMco?=
 =?us-ascii?Q?5LDTPMYm/Tvpn3kzRs3Vsdpi0uWGQmCrqq3jD9yOWX5hPiCARr9BmOdwbfyS?=
 =?us-ascii?Q?NsccOophDi2MBBHcuTAgQuIm4QbvK/KxjoaKioxku1bLVWde2I2Z6RM4Cqu0?=
 =?us-ascii?Q?YvqBmcCi6yt2EzI16UOBuI6kBh5N35iV9DeOuz1B45EwgPNCAA8RMJYWzk0E?=
 =?us-ascii?Q?CST7ZgQy+twv4coRd37rng3F/CSWRKJ5IbVieK/0/2ivTjW2g1pNIzmb7flj?=
 =?us-ascii?Q?q0oh1/8GFMQBFKvZfSTwuktGUEV/G+XWDI4of2nHl8BUYPCY0f4C2vN14mSg?=
 =?us-ascii?Q?+ya9ERND8yRmdPNC4clg5mLPQ3ermKWviGC4IDX5DXsjMZQ5SrG5nsslgz7c?=
 =?us-ascii?Q?0G7qY+mRzMHF+M8zmS7poc5ABO4e2cdZmLEmOerIxsaJhrmSQVQrHr2cjRAm?=
 =?us-ascii?Q?CZF1M6VrQP60K++B4sUDLvECFzhyVJbb1nDVo8OesNGuWMizbtZspNHVT51x?=
 =?us-ascii?Q?lQ0ESd96Vc+ub3Xg0NrcxICdjV7/zsovmsv4Ra/YYl/S2e2Ks57s7+4neRX4?=
 =?us-ascii?Q?Za1GspgME24Le9qDHVuXCU6vjAWhbPl5HOSynJJYi9RAooN2rMt2/p4iX6Ty?=
 =?us-ascii?Q?l59oB8VKSlX9uHyPpB/WYEZ5Rozy6FteNK6vGoEv0PY6npoAjQi/GGTwi8Th?=
 =?us-ascii?Q?H3rDb55faEmZjLFKb8uGU7qwzcNo8eGjuuME23lPxmMzcTVCJsJcckF7/07z?=
 =?us-ascii?Q?SkrvcyrMcbRNDEUVLu90O4ywVGjaHt6BqzKY18kuMYr/JOFHKUfQoDAtyY2z?=
 =?us-ascii?Q?1IuHbCGGdqGrO7NmOOvfcw9UBdqpWiaeZysrM2HlQ8+NVXGogn25sDI3EYyp?=
 =?us-ascii?Q?B3mqVTueZfXqoZDYlLV2RQhYYEt95Wmac6pKGLqZ6dNGL2CxQbr4PoO7sd4k?=
 =?us-ascii?Q?A8KqJJQogLp9qSdABBgVaIggyleckhHEpqa/cBCrioJCHWOzYct+gsz/57gC?=
 =?us-ascii?Q?FLZ/5UoZBy00e2aHo/mjJcOK394nLve5ldjcfE1EMLjWUo7FPWZEGP38NUp4?=
 =?us-ascii?Q?tIE8FO34rfRjqit3oQYdfdtClO5e7QNWDmXUNaSCIwB3KsRP2EaEETJB9OEd?=
 =?us-ascii?Q?HsIKlHmliV+ePtVEJ3GXKRpIZPyNsfcpvFoFb3iWsIbtxTlt9DVM9ZkvXlxv?=
 =?us-ascii?Q?u11XiUhv2QF52GAMpW1r+hyRIscHpXia6p2v60HIJ46w96usQgzkDc4Po6O0?=
 =?us-ascii?Q?dmmWBg1Kr0PxDZFs8GTvs8flFwzPgcsgngoljIXfZJWCsIYxOH6DpPn3qvXI?=
 =?us-ascii?Q?dW6nt5pQbMyuTc+9kA3n8qRyxiM8yHf4oMaaurA6bxIe9FUG2VN5s+i6Fqlo?=
 =?us-ascii?Q?B+RdueuFJUbgTq3y1vc9zsQWRZc9FYoiG96aLKXzM/O0a852Y7feSzu0wbzi?=
 =?us-ascii?Q?zBoKRru6rc/yefbVA5VRYhiqpfWPCwyPEJ32vPD8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IDF0UcNPIp/StjsNQM9M6LhHvWzJPyswc0FiIKRz2yE+JkIB6tGIRN7UpgSUNBqjjjyp1+MgOjRVFh8yKh2f+gWPH/PgNoBNUC5TLR/Q1EjZ9qV+KO6EbQvkgJcfUI0eMJldFOolI3ec8De8E56qlZAgtKjsRA9QsW0sT4ubwOY3r2WB5KZfKUxhYNouNpHWXy/KRryB8JEK36INo0gaDOJRdNd1d+epKzIPwRBKg5xfXFTbaEwIMjIhMl3XcHvRevSC6/wqYr4Utm9N2HCHiWSKGru6K5aFNZ3tD27GzWaHIz0Bt9mzsVW0maBq6A7bkb9CUswskTa/ZtVTqTl/n5IRkYcPVcqV04sVpnPFO60OU0XARIqPVWesN1px3DVM+VAa5Jcq2I2wE2fDUmufDC7rvXbW4IrXn0fxngPUGk4G/+DkhO0611GPzUFPvqrBnT4rcJX8na+v4HIbPKUyIXXT7ZPiZn2HqgsEoCfRE0PCFDhZLS3E8Mzgwz5Vi0Ng1JKpVhb7bMP1M8sDWvuxL115C0wlIrwo3nFw7NXqV84J/+7XrSEy70wJL3Cm7EzirQMg8PbvmjIzuqYTKUBzQo1XK6EutoatOekOAz2UzFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d9268d-e1ad-4e68-323d-08dd0b042465
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 14:44:17.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJB76ROVJT5ggKXbv9a8sSitHk2pLY1s9n815zxWw49CU7eWwYcj7JMKJIp/zfVO++UPSmVchhq0ruAWrHIwTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_06,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220123
X-Proofpoint-GUID: xtt_ZSoJP6QoHrxkRAcnuPk1J0EYt5Vh
X-Proofpoint-ORIG-GUID: xtt_ZSoJP6QoHrxkRAcnuPk1J0EYt5Vh

* David Hildenbrand <david@redhat.com> [241122 04:32]:
> On 22.11.24 07:19, Andrew Morton wrote:
> > On Wed, 20 Nov 2024 15:27:46 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > 
> > > I hate the extra check because syzbot can cause this as this should
> > > basically never happen in real life, but it seems we have to add it.
> > 
> > So..
> > 
> > --- a/mm/mempolicy.c~mm-mempolicy-fix-migrate_to_node-assuming-there-is-at-least-one-vma-in-a-mm-fix
> > +++ a/mm/mempolicy.c
> > @@ -1080,7 +1080,7 @@ static long migrate_to_node(struct mm_st
> >   	mmap_read_lock(mm);
> >   	vma = find_vma(mm, 0);
> > -	if (!vma) {
> > +	if (unlikely(!vma)) {
> >   		mmap_read_unlock(mm);
> >   		return 0;
> >   	}
> > _
> > 
> > ?
> 
> Why not, at least for documentation purposes. Because I don't think this is
> any fast-path we really care about, so expect the runtime effects to be
> mostly negligible. Thanks!

The next email we get about this will be a bot with a micro benchmark
performance drop.

Really though, I'm happy either way because of what David said.

Thanks,
Liam

