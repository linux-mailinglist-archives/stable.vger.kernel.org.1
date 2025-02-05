Return-Path: <stable+bounces-113987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B51A29C08
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1D1888873
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4D21505F;
	Wed,  5 Feb 2025 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R/bwjouW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lS9vY3WX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133223CE;
	Wed,  5 Feb 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791681; cv=fail; b=gecJt3Ef+kSHMk2BJeRt6uc6HqbTW6a6ykGl37Xh3Lx0qur7hhKQms9hRapinz2xsSUs+u50xK9rt3pOUJjlHR5YsQwu7da8HHio99SrfAZ1040dj+9KmROQ8I635eTIFIe27BaFjNcNEOV/g1ZnmWbHdWTSuDQP58l1ZsJxp8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791681; c=relaxed/simple;
	bh=4WEUGM1o2Gewfjb84nRJofFQEohJ+5Iu4xa8ln5MlB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dk/FxCQe5ylrYkZpzTn73TWMNsQHMREeqErYi7b/MFsaSUDpmIga3HkegrhnTARhUWqAJmu8vTri1ao2NeZH5dSK2Ppq8ZTUMCN273CcEJHH8T4G5DbshDuWQMn/ydKLJr9YTBpfTFGfiC8Z18/JBInap7Cs7uQbj3vcPcTzpdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R/bwjouW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lS9vY3WX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiPG009552;
	Wed, 5 Feb 2025 21:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RG8j1XlT+f70Vybs6tTdSI6cnQeXfKztvxH3RRpHVrk=; b=
	R/bwjouWmzmjK0nI3ozIWlvT00OVGpokflto97ORn6UNXmEeQL8KMQS3HwE52UuD
	ufKaos3e6mOk2nNwbOhaqsFU3IXAwcqvN/kGdLFexhhi2IJJ/1+7YOf6vzm4W8Gn
	6NBApCoXvYDVnZ1wJ2mLEERX0fF01pnjzsxVoqt1JoQ+zS6rV7N6ikWf0cGeGgIq
	WmyCwOGvG/LdUS6dr5MdE6HoKTRNyAYhbV+tg4XFvxTfNwmNDeeTOWfgErz2cSIQ
	Gy+DfeqDLHYMGfB019N/KAgwdd3wbxcHFY+YEPjcx8Ib3jGKXR8L2t7smyiThkMG
	HoKVjaKGgNSHqXVTgOyYFw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ubej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515KrVDq027880;
	Wed, 5 Feb 2025 21:41:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p4yv5n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNYIkHEPSa7JUIBe+jKodXlrOHrjYU+FZ3DeD4nezTq/8WdD+sOIBBq6liR5oh6sZJRwbYJkCwKjywMopSdfAYw4pXynFM5KWI2TVXLpbgjyB6ZJiRK7CLQGff4xv5hprv3OZKfNQepByYWzEyqbd4vRr4HS0AVsn0AUJUqD1wyXX53zKC3O1JUggFR3udI4vZFYNhQuE94wWQpIeg96BsUgaNRXZHbdbmG4+JZLtkJninABrhDPtsnmZ2bB+s1RTlKp+n6EgsHKoqNTfsVHbWnpZELqNPxrVRITkswbZbZXLY+SWqT4cSKqcOZX+YlZ1TA/NDf0zJx15L51drvFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG8j1XlT+f70Vybs6tTdSI6cnQeXfKztvxH3RRpHVrk=;
 b=HhHq75eeG3TvtaOHNFyXW/QUKKm9ufw7oUSKmbgoOkyIwkyxPCSv4FIr4nmuw6Ffh7Vepdu9td36dXQPOPAuvU510MipojL34rMZZ+wjzCrzMQ5pVPIqZCGJj54buG3rQxhvQLoQ8qwyBWORHhpD4BtZXljY6fhv4X6IPCiz7/DUbjINisvLopqZG3k8/ToeNB/WbwUcz/8FuGCyVTYMziW8TFGiijxpiGEaW1POlfKRIIvDRbhIGzwScQsP9LuAz47N6PLk40ajC3ijArikbF2F38lFqI17LO7ZfozU9ceIIMX04X5MXc3mY7pnAX/DF1mzW9560kUYgH+fffRL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG8j1XlT+f70Vybs6tTdSI6cnQeXfKztvxH3RRpHVrk=;
 b=lS9vY3WX7wlbVNVpqdfOKvBjA6BVAJTOgJJtFo/HfiRnfPIj1P8UG2lbcQVSAINMBizeBaAo8XeJd2zTVBYU3RjzHqxOr18sBa+mritKLrrtsqe7pFHxAM3U/80qNpyPVB/XtTS/1oji8Bff5Om6sMgMdP54jKs/thLUFBLq0m4=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:16 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:16 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 22/24] xfs: Reduce unnecessary searches when searching for the best extents
Date: Wed,  5 Feb 2025 13:40:23 -0800
Message-Id: <20250205214025.72516-23-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7da6fe-c9e3-4180-159d-08dd462dd189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfM1rhZJR8NaQTikYdzrLhjfQOJ9ZxA1NDn/tCBbaMfmjnMyURykqGwoUYQq?=
 =?us-ascii?Q?k1yGA5lzxpw1dQBGmYKiCStYwQKRi9qwAO/wCWKQP2RFuEcreSIrPiXsFx8i?=
 =?us-ascii?Q?+JvQQj1Pyeit7lkcSUPhRw1ukJaqke79VJNJYV+4PGMj/9Rw/uMZrSL6heP9?=
 =?us-ascii?Q?hO0rcB94N7WaSM0CiyWP1fh76kWTb6Tdjui7QXjHxDZVwmKEbEvWtMiXU1sj?=
 =?us-ascii?Q?wOCeeLuPUR3AHHe60ajmyxH6k0lci5YkQ0O0m1VAh5SMNaCrUzRZ+B5Fz6Ko?=
 =?us-ascii?Q?OpTMZQzdbiCRpP4CjVQcW4gkYOuHXh5QmDqvDtWRxzWvSv6YJ8Nf6sRzzGVI?=
 =?us-ascii?Q?XhlOk2BIK+JC1WMa+D3MQDC13MOx7DlQ6/tCsNplW4aQT1Um/R9megn1J9MF?=
 =?us-ascii?Q?kFbxzxVVx5rZts36cfPTzU1IFP0Zst6pTBB3Ufj6VyrkzlkpE4wlp42Uxn92?=
 =?us-ascii?Q?yJa0pQSuZuoRsuidCP2Tps47/O2v5/Nk4RnJQrmjHAEJDuki1I2OoQud7aNX?=
 =?us-ascii?Q?zd3RofbRG6Q4MMDjO/Qv7NMb2jaw9JzQneiL1Yp1Pw+BJOEyxWJVn0icAjbV?=
 =?us-ascii?Q?d6xDKn73IjCqr1eTyBESZ7irXuAWQQJOI/uX8KsuhBlHuQ+f4i3+XWHN1Lc1?=
 =?us-ascii?Q?Nnv813ivuNph9p1Smc0G6BdAG52FC3WLYe+YAoagvV52fhWsz0dulTLZ/9bC?=
 =?us-ascii?Q?kxDa3CONhPhTUwfK0Au94IgLc5bwtZyQLjfw1rwk7KY9KzgBpZxrmDmMCOJa?=
 =?us-ascii?Q?xoyR1IYONWwpybobgYT/tfMdZONnK4s81x8gc2QM8ugDWHmf1Em5fXx2pQvA?=
 =?us-ascii?Q?r2LvhC8+CmeiUPLmP8P/PJwxtd1omTNftxLYJKZ4r91d6ZPAXVKQcyrIuicB?=
 =?us-ascii?Q?X7clB2vxyEvc99TJlR4hI3nSAu9a58Wv04+D10EFkmST5QV+rjmSEhk/RnFA?=
 =?us-ascii?Q?RPfRZLM/htLYTmkF5mAB2DWWHAEc078w32HEZy3FTJapAjpwNuCyYCVyGurW?=
 =?us-ascii?Q?QG2MgH1YizUsqIz03fjeeDkcZPMzkQ8Q65C+6Rz7rxy9G0bDkxfGid9C5dqi?=
 =?us-ascii?Q?EJcEPhzt1pddr59H7J+W/uoneZ4OdwoJzHBjr3L3QTngxtSLzCc1ucGe3kLj?=
 =?us-ascii?Q?ecwbHRcH/f5nrVyZBaM/WNMIn2TtyOC0R9rdgL+KJ3VtP8GPGOncCw1PHWbo?=
 =?us-ascii?Q?/8xhcv4z7utxwU8CRSLt+JeObd+G1DYO27m+Mve3XpgULQTQqzRX0NrGifVo?=
 =?us-ascii?Q?LjWqDVkRDWOrpA1cqBBftSwAq0dd0InhzEm/bND2Nqn71/xjzzB8XNavd4b8?=
 =?us-ascii?Q?boTbw4FDegza1YTKL7fWRnWA6rD23almxG7KgZBC0EV602mbzFxfuKZp4kVw?=
 =?us-ascii?Q?3keAQ+ksBuJO19o2qzTfKmeMe/RI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ev2R7TjCMAtFLAv5wDQ/5OQvonZaHK37umWfbSjrMGEqED3KDN+d2RsrZSS?=
 =?us-ascii?Q?EInq9VJPVLWY5sFpv//171yYu+k2S5dKQTV6icGIwdKVyFM3dmrx2T/7DaCe?=
 =?us-ascii?Q?x5CWBPCvXnhUXM6uMeZvAmIYWAa3RLJzpuKlhjLYHEM4RPn/UlS7GD5C+umu?=
 =?us-ascii?Q?Sc71WuJaRt/NcoeA5xFBr9BGlF1UHlGdC6XWeu1UggLS0EicEpshU7/rqzI7?=
 =?us-ascii?Q?9HnzQd1piX/RkPuXa1up9A/Up0mLYwpue7Fq/mXg/kmgdLVO3k5Bx6RarQ4e?=
 =?us-ascii?Q?X/U+HrBvBHORmthnCtiPNuo7YcA86jiGOiW3EZgU7hh8QDAwz1Mguswjjjb/?=
 =?us-ascii?Q?WVppFRanUWKP6LMJqTup7KRvKnUCp/oHktcbvYIN1ptkJjb0DYNhjXJ/m0hk?=
 =?us-ascii?Q?mVIFRqfwnch9dt+9CCqMqVTWZH38ilDtRRYQXpjKRKHj+pJKDOA3yJ/Pceoh?=
 =?us-ascii?Q?TMJ14/rtW4evKjiIfSU97YJRlFvJRaNam277uQK7CAxtWbFdsJQ6qbCSqCgY?=
 =?us-ascii?Q?S1RRyvqskJAhPzKvCO+LSnCMcU/4r+YIfpcuBg7nPulwGnkD9hCzcZgVZES+?=
 =?us-ascii?Q?FffimfnzABxgqzLKel+BaxPmppDY7BccwSCt7Q6gKsX5raJJ8+45RVd9CeKx?=
 =?us-ascii?Q?JOKdNiaVXl4EzFVXZRCSHyto02J070ckTak+ewQKF7qmguE/eXC5dirPkLN+?=
 =?us-ascii?Q?HJHAkOHuf0XJ0Ob24lrpI7iQrr9v7PCEjk/CPZvuonVlMcsrX7FimC2RW3TH?=
 =?us-ascii?Q?Uv3fb/n3WwPJsuReZSoZzjnnPIlvhY6fbJhlIOycuuwhL13I5an0kt4m+KVP?=
 =?us-ascii?Q?okX1RjMjshHf8BTjoOJBg/esMKCvVWkc/xsA3crMzr/Hnvkm4feop095yP+I?=
 =?us-ascii?Q?qhPup3qb6RLzwsWbKiAa9BH5W1fiXurn8PnHt94L8wypjaprNcncLvWDrvjT?=
 =?us-ascii?Q?ocOpO+35x+9cWi2EzwdXICgBbhxEy2V/rtdNj1q2q31U7+F0hyLyyViYj3Nf?=
 =?us-ascii?Q?GBzREZajZ6x0C2TGF7TBwd0N/xBTTZvm/uFziKXJwKkg5EdhRdoK1tTGTYeT?=
 =?us-ascii?Q?Id+dtExms5LG4xW/EGBvcHCD3VKTEiK40g6ybI4TroDhFjtvejdpSQkJFfFS?=
 =?us-ascii?Q?YKvjR4DaYLcBm5sq+fBEwTltysOUFUDYD0LSTpJ8fEkg6dzdKjbaHb1JN6yh?=
 =?us-ascii?Q?oMxoViMap7Ev5ma14y40Wia2QWoVgyg/7Cyu+tv88SYgMf35A0XkbJ1xohvN?=
 =?us-ascii?Q?a/OWYfCSyctJc0g8JJptwjuwFhO3rPcxIfpYchBwiWC9m/TdQzDPIzm6+dPE?=
 =?us-ascii?Q?ZVMEGlnEhscBegAoV3aQ6EoPDuIe155YB3EBTvOfoHCt9cpEyIW9VKYjQ2rf?=
 =?us-ascii?Q?bSY1yJpE5ds3VIiIVsR+8YN4tR2dh6QxOnQb+aAliXfgXkH6ul3fXLrcSqQo?=
 =?us-ascii?Q?7oOsUagBnRIduUPVGAZQOGRW5OTsiBB7QgT4hi41tAyS/QU8pnxTnLe1ZndG?=
 =?us-ascii?Q?JJe7DHslii4t5R1RJhU5Tcb8pfonNC6KD1f4ddfFM3BOOJTAy+NUJps/NVp2?=
 =?us-ascii?Q?bKHr2ZGEDNoXkgCkswUGZVQAyxHktBusSH6si0fAJ2f6SdlIMBr3hlONyUwn?=
 =?us-ascii?Q?mpEV87668kQMgzOMIZygvjKxVZUdCzfWYJzsJeGvj5EkalWqyX1xThQul0U6?=
 =?us-ascii?Q?UPh1tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ozMCfL09YQ6IHuUo1ouGL03GOahcKcjrCIc5V6UsuCuXyGUk9GLMdPGyr/dvDXpQtsIgW5jTuX8E8+3hflgo/ezkGokcGpylYtM22ZcYsfxFF+69Ck1fVddhn7V1/W8+2CqoOfwtp6ubFmIyShL/WkpCooQO7xb9B9el7owAONAlJLeafCLVvYGW4S/hXJMZViALDKCDBe4GG0abteygtZqFpHYBkHVbJEGc206EkjFHp8/W7cu7BO0vTelnhb1B4JzejBXdMol39yH+N4oPLKpw+OHNvYDAMD2+TOcptfpiFxqnT5r+b+BBOJ/Q4H0JtDhp9nhlm6LAY7S+YQGE5SNPBkBpjKqQ10TAcgw8KN1rmz/qzB7k8kiBre/BaJa8pef920Xa55G8wX+h9OLElhTNm2xx6LlH3ZEMaTmPhoPFPV11fVtxVPAbj4GmFoUI66RAonp8QT7OshYUeXdP6pg51sgoEuBzMV8ff7ALyeKuB1eLRPsad0I6QIknwRyro3O6RpF1IYNfoIGsE6Ac/NSaBj26+AdQ6UePqi9DkjrvagH3D72jjFoh9C2vRqnx3Ihy8nHrGTJ9KZEriZbR4IoWmyuSUnsvB7wW/Xtn6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7da6fe-c9e3-4180-159d-08dd462dd189
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:16.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXJXry3sX0twSjhvnNhqLrXW4Esc1pl00/wqyXDyUTmQFlsfmTM7clShIBgYHo7kAEW2wCEKsDJboBDt8KzA61UquMA4pCtKT1pyvy3bJSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: ns0LbWriSOWX3afWpY50S-JjOKowrQW_
X-Proofpoint-ORIG-GUID: ns0LbWriSOWX3afWpY50S-JjOKowrQW_

From: Chi Zhiling <chizhiling@kylinos.cn>

commit 3ef22684038aa577c10972ee9c6a2455f5fac941 upstream.

Recently, we found that the CPU spent a lot of time in
xfs_alloc_ag_vextent_size when the filesystem has millions of fragmented
spaces.

The reason is that we conducted much extra searching for extents that
could not yield a better result, and these searches would cost a lot of
time when there were millions of extents to search through. Even if we
get the same result length, we don't switch our choice to the new one,
so we can definitely terminate the search early.

Since the result length cannot exceed the found length, when the found
length equals the best result length we already have, we can conclude
the search.

We did a test in that filesystem:
[root@localhost ~]# xfs_db -c freesp /dev/vdb
   from      to extents  blocks    pct
      1       1     215     215   0.01
      2       3  994476 1988952  99.99

Before this patch:
 0)               |  xfs_alloc_ag_vextent_size [xfs]() {
 0) * 15597.94 us |  }

After this patch:
 0)               |  xfs_alloc_ag_vextent_size [xfs]() {
 0)   19.176 us    |  }

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index d8081095557c..ad2fa3c26f8a 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -1783,7 +1783,7 @@ xfs_alloc_ag_vextent_size(
 				error = -EFSCORRUPTED;
 				goto error0;
 			}
-			if (flen < bestrlen)
+			if (flen <= bestrlen)
 				break;
 			busy = xfs_alloc_compute_aligned(args, fbno, flen,
 					&rbno, &rlen, &busy_gen);
-- 
2.39.3


