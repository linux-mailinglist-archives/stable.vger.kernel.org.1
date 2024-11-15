Return-Path: <stable+bounces-93522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD69CDE58
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B222282907
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470B1BD01E;
	Fri, 15 Nov 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UPVYpGwC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cLkFFZoa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D191BCA05;
	Fri, 15 Nov 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674259; cv=fail; b=FG5/bRSI/+i0z8hm78E+hZY/66ZZqQZ95YGZhaieLGYZ3x1esF4ZKNLYB/OM6zlp0YEIOfdfOLO8Dc0KTNHpHlvbabbynS2HGXSMDvf6ADqu6amYFe/p6XpLpruU0RqXNa8Cfni9uFVihGrn2b4IekUtULolOl5aP/wPA9rx33E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674259; c=relaxed/simple;
	bh=dLV+ChrKahd+il9BZ4slIU0Fi8dDBMuXCzjeHyp369c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqMURi5Zs9fAuB1fCMeB0H0KvYcAY61TISOUdtLsE0fuMDa+vAitaoZLQxWtA67VignyQ4TFDQP2Ha0iJwlQ8i/cTN4qFtfMmvzjgRZvGumbec0AopFnIlgb8sDSwhQwQ0Vv31VyVT2mCd/ZhObNV6u9wmn12cmJM5M3V15tfvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UPVYpGwC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cLkFFZoa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHJUF011152;
	Fri, 15 Nov 2024 12:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XUrGdEfJG3BcCfoToxKpYOf/vzU5H6f7Of1TxrY7+mM=; b=
	UPVYpGwCbClS0OVbuxqyGCTOUMuZ2z5CO+JgszRmB+scbSmNC6qeQXkeWBhh3p/d
	GuI3sWHGj0eU0Imqqiy+mLPPWKCYnVbjAw54/ts2l5LkCRKTAdJJGtHodojb4vHp
	RV3ufkxy8oiON1KRI5awisIWWaMMto7kDYyYORhT3tX0SXhuCwRYODeGi7iXSHJw
	vxE+Oc6jUqGKkoyK9raphD9s1OeM6M0OGV9WyEDHyxWaJUJWlXNo9t4e1gLcTw3i
	mW965anxVoe0hZl6+NX8mFokxnq+0QjEGiLTlXy2GUsMA7c1pzXLvQxxyhCwSEzt
	3Rau1iVYNO9t68psWnf2gg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3da0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAVLFN000376;
	Fri, 15 Nov 2024 12:37:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbjcxt-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNAagK2KFCZfl57sBWnkH3o+6IYk/PGOw1dVM7YY+dy+JnStSLBLhvKdE5hnJMOH2eqvSl2TbBEUd5Fyi7kTvJhTkylWCizNEuKRuuevSMzgkNW9DK/p1+/WCwGZzKOV6OPXdWBh2Ny/lA9+MgSmsUf3iWdwHO5UYSDG1QdCZFeYHJgNOeILSyI0/uCY2YvzpIII3yr7gvx6QsypIhfTlzP894GDyYDi8w9TLkP60+dVCo+2BfNk4IZH1hi9OZ8btT7iMbh8OYypNXZ15sSH5w0pNWLBqUC+gdLDDfMuICJCscZIlbsIMeIhj5Q/FpZzf0klEfSQvgm1qjpOf8zHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUrGdEfJG3BcCfoToxKpYOf/vzU5H6f7Of1TxrY7+mM=;
 b=YQ/aORvKrF7wKiRnXn8ocxuvpzZ/LVsAYjr36qwZSeBCbvTGo4bSdjEn7xIUZgoOloqFH8/9m6K1f1glClbmt5vY4fLazFjhi1msbMi9ttQtlo4DccH+llGYI3HeZNVu4y58YsA75w34PzSx7TLIMQYM2O9XgMVd1VHVL8Vyg/hTYjJUk6TwJZJ9H5i7P6DFJT42IHeShcTp6siBKRsH3/uo8J0fqZGiVvKvmtKCaDlHURDmeZ1zmrhdFW28ff/qG0KrU3rA/tLqr2hDXvmjwPS9OtAZFP2jf0pw27JtXFDTqUWPWvYhChqG/SKz0x4TWuqUBHxQ7j4Rj0j+P7Askw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUrGdEfJG3BcCfoToxKpYOf/vzU5H6f7Of1TxrY7+mM=;
 b=cLkFFZoaTlqbevTvdR12QSu+8lu0Ei+rbVRkBXC2xhldwO5VdLSCTr8QhFLiDFi308EnE8lvd8RCxtUjA4qkTVKS0bEr5AWkBhWip0fK8fZtwUM6Lu9bH9Rd5LbOtADh5FjeDCnom4ljmZFGsamSjq6qp0LXqmBOKazoFK5V4XY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:37:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:37:10 +0000
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
Subject: [PATCH 5.10.y 3/4] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Fri, 15 Nov 2024 12:36:53 +0000
Message-ID: <df313f0663735cdaf2c129c4dc8ec87dce85ff04.1731670097.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
References: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: d70344e2-0cb1-4f86-f937-08dd05723979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P74XDdDEy3ry/gUR80M551O5lmuUJgzACc/xcuS8iRyr/xv45xKuLCX9xsEV?=
 =?us-ascii?Q?fxBAAJsBUuUd0QX9r5aHU1U/S3hbAw/n5yGDCq4+zZM7QOi/WPm1J36xufXp?=
 =?us-ascii?Q?LyxgQjsW6KUzKGfbhbzW2u5JnrM+cP2FYnb4b5iZ6A2kAtiNkIKo0GxB2xjr?=
 =?us-ascii?Q?7XYVCC7TyUkmrv0i6HYNnjFAVhxqhCwcA3rb0SJ6oIFKGrVOId6wRNNjaoQP?=
 =?us-ascii?Q?gtldqYa4FvcUhMXN3dSE4Gad7jeLdjV+YLZ6SHvWq3oOl5pdIrZbn5zbvdsi?=
 =?us-ascii?Q?/Q2UXvHdl0NXpGxpKYd5EM6tA4eLWSzb6965kFLO7U6MI2wUAOaVh3RGeum1?=
 =?us-ascii?Q?tkeEoHGnxdPepEAEuZpY4Z82GwgJZp2ntef9HYTixOrpCJxtpLDex6Fikqa+?=
 =?us-ascii?Q?KquJu3vMexlomWg/0q4tM972/SKuguu+lnzFnrUjpcqgTcLdfZiuSBcdnKBy?=
 =?us-ascii?Q?SJ7jsvm3TJ+GHtShJqP7QmkQNBsYr4atI5sLncD8hIdcVc4X8q9eNDYTJxZE?=
 =?us-ascii?Q?pi/HvauKqH/5nJZ84yKQ7Rj0c7f4bLLuAvMFERRsSEubFu20ixcjAy10Oxq1?=
 =?us-ascii?Q?vItQFLg0L7pkmF7cHzBejgE33swP1bnDcPJalqvMp6UbVNhrDwbNPdw8Nbdt?=
 =?us-ascii?Q?S+2oR8hx8JFbNXmElrzMo+4xbGED3GR0PCD0KGpvInbWwceFZ+ZOzkCg5Gr+?=
 =?us-ascii?Q?+gM9GfDQo0Z+7mvFn5w0bvY79Q84AdZ6iYVoMuv4NHytIAc/ZogG3qAoOmZJ?=
 =?us-ascii?Q?G0mHK5FaZwBtH15GZkkiUDxmhp9uxE75R9tNYUwzwRlIkBH3vzQbO2SszG7K?=
 =?us-ascii?Q?6pORfOaSCJA3qwhqRy6FlPTJKEPX/Cp6xfwDTDZhD/adPY5E/AMDVSC+mVQw?=
 =?us-ascii?Q?lLCsjIvhtCagYLQutdkyp2nbRtPsExSW3ux6aU/2Xb4Gxd2rA1hL7UK6C6RD?=
 =?us-ascii?Q?s4wTW/1uLnH1iBBs30xkFPeyu4yR/NO0dl8XIz0L4aLfQ2kiVQP+4DRzdmX/?=
 =?us-ascii?Q?IJgtuFqlYhxuV31Ozz3YXWXEU1CLaZuLZ19D2S0183gLZzJ8D9zDeLBo6mTX?=
 =?us-ascii?Q?l7KH/iHWcJtsFomXFaZlCcj9KpoBiSuddEV4aDXEhytSrCB48TdoRfj8pFnC?=
 =?us-ascii?Q?Hnf2tLJMzHzh106r4Cyyx8eQpjlU6P3ySfy554eXFybZCMFOYh8jfv77HZ+H?=
 =?us-ascii?Q?gcIjFGnZY1V11feV01NSt6vxoD/yRDVGRQXozYZbFvu5qVMx6P8emJqUaLdA?=
 =?us-ascii?Q?Sx4aYcncLk7Pd57EMu+Bl7hTHuOk4tlUqHgCgvTKY9LklhvCFCWSM3f+HK4Y?=
 =?us-ascii?Q?6Zm72kwI0zAw1rtFe/TwYaG6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQJh6tCjN9ZP3VC3CnQ8Nl0ghzLbuHNRkL5RUYR4PVelYj8fe4tqc3xBDI9s?=
 =?us-ascii?Q?Q3ngTo191+JtaNOoiEpK5PJ7t9w5wD7oRucbdg6+7Q9KL/aoSPAPz/8z1IIs?=
 =?us-ascii?Q?TxrKF9AU4gV/4QzvQXt08HU0+tHa5idGsE7+a/nMfkBgKB2kF1XKff0a9VxS?=
 =?us-ascii?Q?xGckQPz/cFB9TpRHACh+VjMzU3hsIHWPsNIPGO3F+OQn2xucko8d9ZrC+Nsx?=
 =?us-ascii?Q?JT3as8yhG2t/UHwCyVnJwH7DoAYv15Rt91C1sWlfuesQTc2LVxaSFg1Gi8D4?=
 =?us-ascii?Q?7kH7ZSO+g2mNQxWhZTGnaw/uhpouKapnI3iw7NO3QqMEfKK4EDFvEGBha1bQ?=
 =?us-ascii?Q?Lt6WIBBxzxV/yX0cPdqvTb7D94lIBgBCilvRBWxy9pyWsjs4FLn2gTNCphaT?=
 =?us-ascii?Q?gz1D0wCZp6QQlpFwz2IrZ0hzpuN8BZQ93CVOzuJBMoGu87t9gK/i3rqN/MLw?=
 =?us-ascii?Q?DBBcxv4s4jsta9i4Ep0ouefCmKsviiuMkyH6AXSvoyECYZjGqE36fa0Ou1OJ?=
 =?us-ascii?Q?XOaCyDC6rk7wifHKkw0Z2rUkcx53eGhfcwUlAfrKZXiHmwOQ1tCuGmWzaEpb?=
 =?us-ascii?Q?UbsqpQUg4CyIBEIkOAVPI58XLb4A6mpJs8dt/SMUfbovFOBpmHOKxijV75z4?=
 =?us-ascii?Q?EAn3O4/5CTdNbmcJYWbmnwBZHKQZsRrKLRMblwjXWZbdojecrD/1WxXBDW+E?=
 =?us-ascii?Q?hY6wbS9QvBVl7FqSh/BQosoGEMrAfVJK6wWAiwuRFXxSxL/s7fBJUsrpM6Hw?=
 =?us-ascii?Q?TFR2gCTeLYb2thBRg3q7I7EYd9cH7eIW53P6kmy/vNn6fGVdpMEONag2hucT?=
 =?us-ascii?Q?8MaS2eaj9zt2+f/4KIqmuNV/s9weTQkJfI9B2LzsvU/JX9Qas/P/JWgt4Cvg?=
 =?us-ascii?Q?NevFM4xCk+SG74+EG1eS7s99h/5yU0TWZ35jEYxBh3tm3Do7471hX7SKaliQ?=
 =?us-ascii?Q?iNQJxtUO78YpRDBQPejVPgHscOVCg3KZnNcBBCJ4nBmuO0qAQFHrEEOuXtU4?=
 =?us-ascii?Q?mGpU92Nzz2/LOD/D1hVD0EMmpv4IjzqsQiCBZT1qiI/dJYGa0LkgHrZQ6E6q?=
 =?us-ascii?Q?LZf/Y8MpaTzhycqOz9b+QxmPpbV8+xAytvcmDZFP/Tf1b3tF7a7RlZjs/1qX?=
 =?us-ascii?Q?6D1d8OS6ZOmhDafmdEd8witSdASCuaVlgXgFT2qQRupdvCtDTF5ptJofyhme?=
 =?us-ascii?Q?m96jeZ+VBEO3HK8XwMcF6LKJcym44kPyGd+oKZeWKb+SezF9IDr3i4Qc61oR?=
 =?us-ascii?Q?hGAhzSSdyaTrWkjpk2PHLO5y0NkR0hASlWWXQ/PWXidadLzz4U9Fzz7UXmXT?=
 =?us-ascii?Q?8gXO7UTIz/ShiYeadKxzCmcHdnedieuNS6ZdnV2fEKPRzeNR8nnRpjOkDK6C?=
 =?us-ascii?Q?0pVo8/IVkdmr7rljXiymA/2Zmwt0e9Zay1bSUPuTvWmUKIf6l5tn0aYS2hvs?=
 =?us-ascii?Q?LFnBJO5QBZfZgcJvnazv64c6iEkbDzz5zkedJXlrpz9t5yyaLH1BSnCiVO5F?=
 =?us-ascii?Q?6cx72+bB4+HhkxqhCODqZWPDmn5ynBc6ny2hlpBb4obPTWCMx2BszpgCGZ/m?=
 =?us-ascii?Q?7066UwveLSFidg10zs7rKbTh+NRvV+jmoDTc8ar8zRvCOQCQfAo/LD5sd+KL?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X8a2wp6/ngbNTBksLQchZHTZ5BiD8OQ3Rgn1V8oniHWYdmOpQetxydl9b4qzExy56TLsH2isgLB0KyIDodgCa68cAwfAXSmySaXhVnvpG+AeAW5BPrduGJHMFDyybxLVJTK5L5iBa4zMSCXxQP9b2HMMBO47HkuN1/TsxU+tK3HxGAAt0wj0KFneeL9onsLu6z/SRz94dAJXPuxkn0uyuiMXOFKtN32q8DFArY1yv1YqkhYbYB/1kqRucfzVbueeEXeIatgT1lh/oA6/2VyjxO0Jne52+q8WgxXcd+yFbWTQqMWb7/K9BGewC6dLfTBtEnyEOizpdxjghG5m+0zO94VuNs5w0WnwcUpn7QMQsCYT9gvIRJc7qTqjupEa9jYO4RlGAOMKsBLAmYnetdd5Dz4bFojVYyhNSuSS4qhXhGS1HIbdV8Td7B2ROR/+kRzxaI+cBSqDToptNs9Ve+QewJOPJmR0yRoBIx8jz1jSvYq5UKwhlo6yNpyTAJIdN0wWXxYVGLNXubuj7NSeG9LZx+9SwSzXD+7ZPegomRmWgoH+kkmz7mpEONtLKNhyvrd6C3T2w/PKU8NNIVL3ZJEYJyHAvA1vJJBq2Ds0EE7B7zw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70344e2-0cb1-4f86-f937-08dd05723979
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:37:10.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74EYEFmxzYXp9Hs8WmdcFOZCh+wYoxGgzO3dQojW7lreDWBYkrOoSBr9s5ckwuWuJJsds7ju9q7pUsjf4xWyd3m+8xFmoiU1BbvDkQSkCzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-GUID: mt6B6F85uTrRtoEODQDSqS4jDd8SV8xH
X-Proofpoint-ORIG-GUID: mt6B6F85uTrRtoEODQDSqS4jDd8SV8xH

[ Upstream commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81 ]

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h | 10 +++++++---
 include/linux/mman.h          |  7 ++++---
 mm/mmap.c                     |  2 +-
 mm/nommu.c                    |  2 +-
 mm/shmem.c                    |  3 ---
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..56bc2e4e81a6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 629cefc4ecba..5994365ccf18 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -87,7 +88,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_vm_get_page_prot
@@ -148,13 +149,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index ac1517a96066..c30ebe82ebdb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1468,7 +1468,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index f46a883e93e4..015d291e1830 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -919,7 +919,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 	/* vm_flags |= mm->def_flags; */
 
 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 8239a0beb01c..4e7d2d54dae4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2269,9 +2269,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vma->vm_flags |= VM_MTE_ALLOWED;
-
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-- 
2.47.0


