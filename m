Return-Path: <stable+bounces-113985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17531A29C06
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE203A79A3
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA421506E;
	Wed,  5 Feb 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OtUgJ9Y1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bk4VKkXs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFA215062;
	Wed,  5 Feb 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791674; cv=fail; b=gTIK2yYcaTcHcTd4kXJZaqdWQizu2+3U78vRmN/4IuPiQsDrSPLfCBK//TmjP4B7V78m5dJA3pWyaXBABMxj4aOP8x6mUkY+whyZt9SLJafRK2RLJA272hG87mu0LP/EJW4Qx0GY0BMXoM0e2f1cREnXS/FETMKPWJfnvsnrASc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791674; c=relaxed/simple;
	bh=d3yimYFL4zJCGm9G8/7qjmulT9XGZ3vEFmm4RPA2fyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C12EBCf0zAJhoDQpDe9H7Bs2xni1sZUHedSNSCwwy9kb+2QASBtDGM36L0EYYuBtFlWlKpJrIp7e8z5SvAdvRlKOzMxvAjOq/SZRZRYKRuRrWUV76m2OVVa/iLfQL2gU6IUrbhLqxUVAvbgBy9DrcQDpIE721Sfvv1UJ6nWA0aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OtUgJ9Y1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bk4VKkXs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiK4009607;
	Wed, 5 Feb 2025 21:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h22MQ8wjUgTq8CsgpLn06slkDaM5AC1wsSs/apLUpxQ=; b=
	OtUgJ9Y1pceHFKIOXcRwOMmkrrWI1wye91ffcJF6PwmyNqjhfw/dvxHxnDh1kjDj
	f8ZseU7bUEBMb2amFQe3nX8dTdNJEeEZ8QT8o0zyo2G/b899SWqNJrDaDMaBIoH1
	t8aP51r8ifvmxiOWDoP18nMrpNxxQOk5sZ0fklkB6MJ4sr/ZqA6hSHjfxoDEllSa
	/E67erCPaOm5BALaoUxRFWBwJCSwugYxqe103QlORuRH/bzofG21/9t1iEUG45ZK
	Au4gavx8Bz4BIEziL3AArkWJmLpB+s/NlrG3jRvgvtufFqbLv3RPnQ2JZrFVtnRt
	9/D/jB7XsZjXsrHOZ3gagw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ube8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Jqqfc027802;
	Wed, 5 Feb 2025 21:41:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p4yv33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D82LaiTK1UzdEtb+Tcp9I+0vneiJbFs0VOof7MOFkUaZRhDQbUBAirj8YOjAKTsACSpQErNLU7ntyqrkJhCTAiirWWD7nSUTolohnVffQyEhgrrZGI2sWrfSLLFfBpUYEAwJ9hNftecOk69xuvNPenyGNMAcwUE/LUvlL+pafZfbEz1eUlJ7NlCqL2HlQyM6kzJQ/3ndqgIkOrFTeT0wWor+yAiwyKSlg5INWTrr37sfQYRW+ZqmcWGcbsiOd18z/UXDuQao0n3pdf9j9+HAyaRXmBHybXbNvVOfagX3kbSO36/1FvCRTNLEbTsz0Q6Pmrx8qfMf9oBKIyCYc4/pFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h22MQ8wjUgTq8CsgpLn06slkDaM5AC1wsSs/apLUpxQ=;
 b=xNTC47ElOGGdaYv4hExJeXJlgmPuz+GF7aVwJV+SR2ZqpaGl0GqVdWeYtq+Qcl2HxAWL8bOrviM+kDShfY4ajmPwKMCsyIEup2oCl2jkpzAI8YwLXFhiMpsrxfCoFfERobPnAfzP3/74Onr2mqlD8zqj5+1dAGOl8r2ZvIC7izzG8llrlkf6/As/tIbabXZi33/4X1WO/cYvVguGMy+vRUb1o1cBQxaXiS/+JBBX0x9+ScOIZ9Fc0F3I3QLxxOvoS8OZQfZo05WK+dOi2MD0z9/yS8VgOe/cSYaDlW6OmnCIYAjlMxWwjPPFSLcqiCykcwj/nThYq+fTrUCXJcbJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h22MQ8wjUgTq8CsgpLn06slkDaM5AC1wsSs/apLUpxQ=;
 b=bk4VKkXsginjBdi8h3eXCAscDuAGnlGhEjmnQCuWrHPiEmESxQWVQVM2jsgt6Y9NhL93hzncTHDKEu72JAmZ8EwfoHH1Uq50pjY1TIu46+R2PFDMpwiF96C1VFA3agGu4iBacYM89rN/vaF8fJHcLkH+1J8f45lA8qin9I9r44s=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:10 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:10 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 19/24] xfs: error out when a superblock buffer update reduces the agcount
Date: Wed,  5 Feb 2025 13:40:20 -0800
Message-Id: <20250205214025.72516-20-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e49d550-ba68-41e8-9ee7-08dd462dcdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ovZCvA3/GowV2iBbUekqcNcQJbhbJhGoN4nQV9BD+siNtHcPZVaI5ueqwRfY?=
 =?us-ascii?Q?6BlHWem9CwEJymDCEqY3qAb7x2MwyKHrVYCfZl6IO9DthV4RDhkT4Tr+SHKp?=
 =?us-ascii?Q?ybcPBOfz36DsWYAHgRZK57Y3LRhWcY/u42/K6pRRjL5ZuMMbT7+R6yrSl9fk?=
 =?us-ascii?Q?qmFKPYnjcX5GLDdS8a71Fv+sRKlJZpLes8jB9cKTHHnP4YdzuKdILzNke7nn?=
 =?us-ascii?Q?EFs2j9NykFpuNxS0lWLCRL6O2tfx3LCH9ivIoACmhRjKZHJsJZCUm3chOE3/?=
 =?us-ascii?Q?fAKedlJlCoL9I2IBun6kkRyTgS5IfUllfFXsL7VhN5IaboM+DQETSmtxwNaf?=
 =?us-ascii?Q?+UByqrFN0jv4oKbtSjfJW34hIayKLMoQuHSAsJr+sjuL0ui8qqlLKLCcaSkt?=
 =?us-ascii?Q?kI/savB8FblQndq5ZJQZk3R+DPjNmK5kBhXF8ZcxwmY+KP+r/Y1D4f8UQwzo?=
 =?us-ascii?Q?vWjEE+F+78iyblKsa/57dW3GNSS3nYbxch6Ph+dNoaHfyVVxq3IIOJdHVs0y?=
 =?us-ascii?Q?nQEVhauxu+fEicQmIPR7/sNWcZEYVJZ+Daqv65m/hjAR3OWp8bOSiGoWhqmy?=
 =?us-ascii?Q?y247+bfv1OofdG4jW1Cx7miXbfhfKIwpL/nUcbYnnr77FNsAgN8+dg31Fa7l?=
 =?us-ascii?Q?bXCKWE+PFtTo1BBdm7OYmH0zYrAa4tjQbWx4dbhSJfCPQ7SR5cNMETP2GxC0?=
 =?us-ascii?Q?dfn/fTxXACqDeoPDpJi52vktrRyIL1taD4TTX8hsDQDwuaVn81kib/87bEVn?=
 =?us-ascii?Q?9ciJQkhf0hPwXmoleu9vaXoHXeJgH9cd0n1b8hv5FnEYJq+Ba73fX3Nl6w4E?=
 =?us-ascii?Q?DTc5BmdyLZwJ5zW1FB0Ha7HwhMWw65EvI4Hu0Qgr7buJHoKR7KDAopae3ktW?=
 =?us-ascii?Q?5nN6H4oqMpy6SRk7d6BNSuYa5QRl8gY82Al04wEy6sbIKDhU6bZyiglUCmFJ?=
 =?us-ascii?Q?7y6nL1VBINnBPOUSEeMG8CucntRzAsFKUnfdNnn9MEhyWaT/nH2ivmxuT5Vt?=
 =?us-ascii?Q?cLdN+eSAMdEJMm2yMu2GA57tilT1NetqnmXKN07hi/3hkhJ1/x+2Gaa+OSWA?=
 =?us-ascii?Q?7PGJTLsol/xjsnO7tuxKB/VQo3At1siVFRvQEkavDYyoPNqn6OhXX2s1pWtN?=
 =?us-ascii?Q?i97/Dmp4c7YwquIw4fkOy1vVsKwRCj3BmZNMkIOrtaAZCzfURuYNMWXYpkOe?=
 =?us-ascii?Q?riLrabzR+fS9US71E5xA7BChbvQoCmrFmFQOYVV+zX5m51rp70eDnmhURy52?=
 =?us-ascii?Q?Fr05VsdOE4xhNHbPKxAnqd6gk0UA0+KO110OYW/gHZFGhDjyHdkz/HTeah7K?=
 =?us-ascii?Q?C02HZPOuWrMwWoLQtvCBWekzj+gNQ7xppnG0WQQsyeVWuTsprkoVMl3j4XrC?=
 =?us-ascii?Q?h98QTMZPWkv3yJfn8EPu7jOlRvkn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gO126cCY/TP7lqZ9c4ui+oX72T2vW4bqavOa+Mi2my8fA/c9KmBsfSu+mcVo?=
 =?us-ascii?Q?Y9lIqmryT/7MwDybiVILj/a2j3hLjjPsjKeCrGkhOyD6G/1upNZ3NmbvNp2h?=
 =?us-ascii?Q?FKQG0FZsq0ajgi6/J5QydZyHmVXYELQycYRbFhZ+UzLcMwiaVJiXZy6TMS8w?=
 =?us-ascii?Q?pNPf0nkjdD6TQSL5cpDf7WfrNLp5atZUF5lA2h04i9qnFhLpwZ6Ic4dbKCZr?=
 =?us-ascii?Q?/bs4PW9lFk4BGXzMwow5rDEKoKT1TES8PBKf+C6s45PSZVSaDCnWZF96tDq2?=
 =?us-ascii?Q?gGNbx7CygSOvVCGkRCwHfrRPJ+x/x7qXghG4JVbV9PtNf/a+arAXaT8dewi2?=
 =?us-ascii?Q?VhUH9GnvUD8AZO9n+oiN62vLmKhgB8IAGBV6+w0GEKLQD4+U5h9kBFpMce7R?=
 =?us-ascii?Q?Jh0SgridXkjzSYOPTlTAqLqVEFbOdtItY/BF1tr5RkfyoVtCL8FYhG2nntvm?=
 =?us-ascii?Q?sdcuPSI8c/S0dl0rmd+XX20fdYYjVVALuYg8FemtrVzXIS1LOtnHBcm2oKtc?=
 =?us-ascii?Q?U45GWC4CoSigGofv8TJvqRzHMXDa75Kk0tW0HuK4ZkVYipxwi0HpQmyUFWv3?=
 =?us-ascii?Q?ydvpycaKw/7Q4Lt38PSxHaw/zRyr1TdFsLJkx3QuWSy8WCHA8BsGSwczrReB?=
 =?us-ascii?Q?I+J6KgujAQGP15IrX1fiZ3jlvreZer3HMoNB62xU6lnEOVyB5uE1U9ipb/c3?=
 =?us-ascii?Q?6oDLs4sDakNdELfFnTLhDf1HORYIwQkZGaDwq/LxYUJBZPEHvKW9isW34hJy?=
 =?us-ascii?Q?9MuRZ940OGtp45EHRb7JfJ2CeZPsFko3tpgRH2z4ztqOqojUim3prvLhJJ+j?=
 =?us-ascii?Q?N7qLhPtyLeB6dfxsHKF81j5CzvCcQv+1I1Uqz6u3fVStZqG1tsNWPYKNgCP4?=
 =?us-ascii?Q?rMIb1pSGKSm8+CB4CeKXGwghLpQ1CoK9NO5sbty6815WwSSGBbW70SznrKte?=
 =?us-ascii?Q?vRrcJECKeKLQhc7wQgf2o6ZgBKwF3MAxcoNvjG5sxJrbceKX6Bx4Za6g1E89?=
 =?us-ascii?Q?fEdj3V+XvmJDORUtmcaDvQRQsPDyMy+e2HMBvzfAm3Hi74tvVvAphH7TwP8/?=
 =?us-ascii?Q?MjKLtBzwNkyFixV6GUXICBqQHUeQfRZGevyU7W9YUD3xGkwNrP9gvyGqF1ZC?=
 =?us-ascii?Q?r1Tk3V8b1XPFWOf6p8LiLtoL2+Mt1p8sGs7w65rzFzM5jd6o/OGgInrHstkc?=
 =?us-ascii?Q?uu18h8olN6cmurdC5/8b/5T0sMRZdCssXyO932a9oNiIYlprrqEZjX34hLYu?=
 =?us-ascii?Q?Tix74PsQOYY5p7yVz1I++dUd1QoWZ6xI+T+x4PiducRq0mDrCTgFtzK3PnWg?=
 =?us-ascii?Q?tIh4gY9ltJ++2y32ckFJHqfGqovwxyHyzQ8NfXYU4qxQOfWtcq9nDPmrA3zj?=
 =?us-ascii?Q?YLf9XKlg3yjN/jXkPi2tR/RP8T60RTtr6ajJ2Z5iPR+s3TDDE3xv2IKogLz+?=
 =?us-ascii?Q?mz3yEHsVfSBASB+9/5+gDjMY62QOC13QDh77oq19GiQBLhEejMkXNleSURpV?=
 =?us-ascii?Q?dPMxz7we9PZoViExoSjF3ctrWg8Yfefo/WhJqI1NJH4bixoNdOlXIhmWlWGR?=
 =?us-ascii?Q?N+LpwNjF5+Oh0nYlrtD6vhBuDy7M2rolmTKvAsQqKn6odJDayxPSS3841oSq?=
 =?us-ascii?Q?M64ErKnRX5g25TVz84Ch7+h6TtA53kxF6FKSsLlX2bb3lLW20XtSgHMgYtdN?=
 =?us-ascii?Q?2+h8Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B1H4+o2wiinfVmUCGJvOuN9GKBgqohTnjL+wjV4FkvpjsgcrVndbR9tqxb7Mba6OrPxaRtN0XlwGJmcaGJwRsum8ZvIzwQD/05YWSiMCP13mViEL1oERHqmLax5KsWs7S/8WxiHaBS34fIAVmKDX6HAri01nIJKi5a+h1f+F+RJUDR+p90WRTeOR/Uc5nzkLEatm7xlgLqCwLJ/9kZBhw0g5uy0YJh4yzv6WllHVlxuaKc0q82j9i075T8xGOKkahqMEJz9TNZsuH04dA/xHJmCEeyCE1RM43S/Yn8pfRXEWuWajfm1swRBcASf/bYiZrxhiJnwfNlWFXD+VgaLi+0JSpldqG9mHeJ3TdBsK8o79KmM9QSDQ924gSIXTnfRF/9XNLxmGf9jUzGUTWKHLwblxrs88WsDDlhl8zqFaIUjhYBsHMsbaXcT8kTqk8EmwukBFLI7JvQOeYdP8CdKZ0SKfvPPq9bzLGCuRjUhZZdgz4wPbY5CRMZICHc7On9wSIQYp64Ar+YW5LNoxwBC74dvWTplXRvf/bZmNYK9sVDh1hElZQ/rplk9OKV7bPvY5HUbmNdscqmQLsvx6RyLc1VlX2hdFoc+FHULY8JjLhhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e49d550-ba68-41e8-9ee7-08dd462dcdcf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:09.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBLDXlvYenmxmEPsCsKzmzfriwX1DrlIeXUsa7n6LIYcO1DVmxz4Wu5dkzlEZG8dtZFi3gK4YcwDjVApcNBCYSI2sul4CwN8RO5pWr6po/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: 51T3mvpNkde-ReApve5t_AvsD5x63YWj
X-Proofpoint-ORIG-GUID: 51T3mvpNkde-ReApve5t_AvsD5x63YWj

From: Christoph Hellwig <hch@lst.de>

commit b882b0f8138ffa935834e775953f1630f89bbb62 upstream.

XFS currently does not support reducing the agcount, so error out if
a logged sb buffer tries to shrink the agcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_buf_item_recover.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index b9fd22891052..66a7e7201d17 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -713,6 +713,11 @@ xlog_recover_do_primary_sb_buffer(
 	 */
 	xfs_sb_from_disk(&mp->m_sb, dsb);
 
+	if (mp->m_sb.sb_agcount < orig_agcount) {
+		xfs_alert(mp, "Shrinking AG count in log recovery not supported");
+		return -EFSCORRUPTED;
+	}
+
 	/*
 	 * Initialize the new perags, and also update various block and inode
 	 * allocator setting based off the number of AGs or total blocks.
-- 
2.39.3


