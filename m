Return-Path: <stable+bounces-227618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMy7MASyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:45:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D265F2E0F96
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10A34300F2BA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6E3644BE;
	Fri, 20 Mar 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IEYuNagP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85227363C77;
	Fri, 20 Mar 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039550; cv=fail; b=A9C0rjqlWZjiDCiOb+wFwjchS/jWLKeN87FfkDgK8lKdZezoKgNEVh/rqCUozJnjNIoem5zNbwM8Z4SAoLyKV6aEXh1JxRmzNLgT4MP7pZ35nsmwzlynF6mtXWbIChJGRTtdMVKAPb39CSTdXW8zPxaD0PM8BgccMBrCpPQS0CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039550; c=relaxed/simple;
	bh=uEab41qPzfNO+/wftrcLb20H5Kd0PHtaw9v17jvhvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W6fR/6ODgEKkV88sb50rP1K/VaFVR1tzJI93J79Vqr2hdmQpW+cdSZ7ILD5tAgEDRwCMByT5jQ/0NUieupsrRHx+AmNgT8/+3PpghW3oy9GcsT4XBhumEf+YP/wgcgWV1Q8thiSPELSX0YjYdreCHKRH1pFy/71Skd+VEXvBHO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IEYuNagP; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8ad4I947177;
	Fri, 20 Mar 2026 13:44:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ib+XAmTBt
	mYhRbPC2UYkJ9b3Xjrc4+EZnAbNUbw6c/Q=; b=IEYuNagPe0XMOR4SE005gc6Q+
	07109X4jXoNj8ZOMjqHCe2mDJZIxNAkNFa1KNbKpXvq00BKVFcRWFG+5a2ydRMGZ
	DLrR8111wjlGWrQs+CrPrB2K913G3GJaALyzu82fSieqnIDcM/rSeZkZgzjfZ0I4
	8LdlCs0j5xRVPiQirOuiHOPSMW8GyFTDPso2qgAKfEgZO+sLIYO3tFtx7cjDSJop
	RDJjK+Ftmt5WlIhAg7dfl/6S7Yb3vWtSkso3PizZPe22YWyj3+fHtuodIH8fneK6
	DBac5Y35Fn/sG31Dvy89O0Hjo5qhW6yn1BqRcqnsGBIp6ynYKz4cxbHlGiloQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y18k1q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu7kjHZsCCJ/r8JP25qKvJnJSWRW3DF8c+kJYytfmnreF1Mr8L/k1dWZXMZFEvoXHP6M/3rXsnpwlnHKHdbN8zWnRqrMo91Fh3qTyhR+FTbi456M29OoCe8rtXaXBIkY195bOYMto0yfB5NpGe7yk6bNP9wX39WO6LqVKVo4KnRZm4dCYnsrozlFK+I1nTMLSIDxdszHryKZq/Y7HlxXIIJ15ECl0FScjEWuvzH+dABwsZxE3e61BAiw53KQ5TaSZ6X+bsxvVL8q0t/CVBZSaKWCmBIUpVpP5tyWrBcf2krnTPoO5FSb1HQYeQk6VRaUX3vLL1cZOMjLENDsBw8V5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib+XAmTBtmYhRbPC2UYkJ9b3Xjrc4+EZnAbNUbw6c/Q=;
 b=YAfLJlbgOikjCu8Ao6WoiJHjx5H4qU9mIL6jlvgPRrAtV4wpkwW4kZaBE4A91hSpyn0WqCstlhgUkR6rvkp2FA9Nj4dg1pFu0Z+ObeovDr0CkgsUDqr8Ve8nAY1uLTP7E59A/wxnvfzKWyCsjnh3emO5aLxt4eWza7ShQKD2bh7giPQpbfisoF39jMn/8CZK+42MQASeT2o0PEVXb2xCSjF1b3qib/PBpcmqO1DJ8a/vgG9xMBG59XBhK0+7dxB2Qwj9C7jG7grMWCbm4iYzr00zNdYNJEeUl4CxstLBxONfwO1HX6PptrvHUhPC4llLgug6vrBYTm5Xg+hBu2BhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:44:53 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:44:53 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        "Ionut Nechita" <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 0/7] timers/migration: Backport fixes and cleanups from 6.18.y
Date: Fri, 20 Mar 2026 22:44:35 +0200
Message-ID: <20260320204442.32901-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a3be71-8f6c-4e19-46f7-08de86c189f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2OFjJD6SXoqax8uKSLIrKyof5Vp4TciJnrSNIl1ZH70PEu1uE119iRZeWFjQEcP+33pS4/VnUmVXdDIaxy+N1w4x3VqF13aulwsYEjcryy8hG0wt8UPGCK+BJNb4LAYeOa7ICs4nqGwZmmhtpWsxSf8wN99oHY6lhVheUI7HEwqju40Uhha4plGS1707Ucxh3W8BjYu2PEASIyi/zt/eC/+go8/sYn3kDUZRnAJAwgS3nPA6JFF3HYBZpYq+InWRBPkBmkTusX9g99ExZVMGJph52zIXqgxygNkph+R20viPbLLkFY6r/d19vVkaTRVrHNEPrF1UXK0B7QDtBviuUO2TgJ3FTaXn7J3uDFeaCzydafqCAJMeZMI4nXTFphwPFpzI/VskB+NwGwl0TDrJY09qth+i9c12bGiCmyMri7TYwnANTVsfzzeqtOT0X6x8L+zFmEgUWaiE6c6SGeuRqmfKQDWQBCGO8Zzu2HP1OHP5vIuDwHZb0El9LLvARzu7CqMgyg0F0gZlkb8IT1XqJ6626uwa88W9M9LSwCN2ApQyiJMfytWIS+dFXYREsRvclZxtIRtcDEL+Q1nn7uNT+Q0D0vVssJARjojVyA0dlwi92jBbmfx541EHmkDdcsaYtB2E+eNeNZcgiCYJj7pKl5lNT3akuq4L/8JH+80YwyhYQqYMsdsup+sEqyluuFbbGYAyYhDzBkCDk1JNOPF7O80GfxvS2LaFY7UmtXZqvU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POwLdKX4YKi4VjDDone9+M6AFAXZb+LCMK2vf2wuBTlvDmkGM3jIzyDsKSjq?=
 =?us-ascii?Q?VJAkreUpam+lAbyMo2Qd7x717zHoRc3lFCAo+9u/hYhejYjCv1o7v0K7KqcO?=
 =?us-ascii?Q?DaAmjWvJuVhMXs9qquD2cbxFfUcfD+n+7ZGVWYx2sBJaIUTE+2ntQ3vAr8oH?=
 =?us-ascii?Q?qucrxh8+QW5LqFC3kfj3W/1hhKrDx6tx+s06Vrl3YpGbWh2hA01DDHX7/qmW?=
 =?us-ascii?Q?ofDAyEA1hJMClgKq7wePjfs2ZhC2AoOHWpyc6nd8CwIz0MZKEvDsHYEGkVeZ?=
 =?us-ascii?Q?udnrHM6C21Cy7AHb7WBFcfdbyIraHK9QuV60yvzl7iu9bAgk3ElFiOS2mOqq?=
 =?us-ascii?Q?e6tdcD2K7Aznzf2I+yus+76XlUo8p0LHqcnQoPGymx+6y11snMvXhe2Tu0V7?=
 =?us-ascii?Q?3V+GcaKbnA65RwfuBN2Wj1SJ7EOIRKmBUtSv/2IocETAQLgqdnH8/UqpLsTC?=
 =?us-ascii?Q?Och3O3NZ5oT6xp2jVkiaT9meIouHOqHtBpKH1REjt2DA809/MBbiFNp4xm3o?=
 =?us-ascii?Q?hGkpHPkdB0KID9twbdxfVyJkhOSfueJvD67BorPwqj9V4SVG5DjlOsEl/tEq?=
 =?us-ascii?Q?RDM0MZnqzR/EKf5q14xKog4dOI0wrUCdSL1vSQuwxbb/w0jKcfQ7l8pJWeYu?=
 =?us-ascii?Q?eYoBnsVYp1Qgf1sTHQDOR1zUSpDdbwfqZPzCHkCqLU8WG7p7fWXk7HXnwq6C?=
 =?us-ascii?Q?McfQea+W9mAco4vRexkO364FjvuJ5K9VzkhrTZ8jzRZIu1N1yXVVjcl22qjL?=
 =?us-ascii?Q?2cHLNGXnvG4+4vjgZqIdIG1ZP5qv3mpNip0iZVKYHPdbiHI0RBd0tCi9aF6c?=
 =?us-ascii?Q?P0Ea2Xio/peD1fOxfbFLNjW++Ma/Vam6rxD7rkJ3QVFUXfAea+PHR/Nu9g+k?=
 =?us-ascii?Q?9SxL5BHktLce4VhV1cK+Ef2th8xei+j9ObOVPi0uZAcD1E1wS8Ak2AXjx6+I?=
 =?us-ascii?Q?E6AxTBhGs5scP4W9x2cFO4I/oMOQSuMa0UZSoO054BXz4/ighazPyuuQTsDl?=
 =?us-ascii?Q?xhbd8FpTpqPyNlbTPDL2fM1KtItNGAhpW133MsKaOiazacDKX9LHMo7nCGw2?=
 =?us-ascii?Q?d0H6V4chs6MtZ4o8U6Clzk+zlJ28PGDNj3PZ3coaT1ZMe1oQnOKogyp3dLxI?=
 =?us-ascii?Q?SAcxTRbSy4lg1xuZi7vHMDK4d1K49o95Iv/Q0jQZAD6A7L0BqaFAWW+7Ud9B?=
 =?us-ascii?Q?/cm26Xa/Qkh4bU90PYrMpIVlmyUM25uA6Ici9gvC9D2gEG4x4QZ7vCS/xWCE?=
 =?us-ascii?Q?moV+JH7PokxfzdOVGyjnaU3Rr8qI2XJtZVayySIAx/XVg8OquMc2xhjTbDf0?=
 =?us-ascii?Q?TU7dsLQhu2g6VSzWXhYmmKxDzRh12VBNs3F7YrwGC9Zb3tTMMsP/pWuVNShJ?=
 =?us-ascii?Q?/e+cGvzH1xyiYJ69GkmHzBNGRhutdC4QjSSD7yR3ZcChHhTIVm+kjJfvAls7?=
 =?us-ascii?Q?WrFQXtJ+7gesZvaIdOWSCzn2k1QqbYWV/NQ6dAuiMkG//SdpRwzWn/tRcnh+?=
 =?us-ascii?Q?+Nju6isAr8Sk6Ju+G1Mfw5CZprlAf5kNu9YN9zzlWhgYWRjSM8YiNNSP3yjv?=
 =?us-ascii?Q?MhuPNjf9/np0bkLm4WXrp3EZnpmw04q8J+9lcHx0B/Kxe6CIFwrRoXMUfjfE?=
 =?us-ascii?Q?neJfl+5n7Yuk6IYS3ewoa6jUNLTZGyW6zRZ5U4pTcmfxguP72fvlJ4XiVZ+e?=
 =?us-ascii?Q?AIBFraNF4IEL58QPpJLXtj4uBp+M56pnDWS2j2XAqxGcc01kspazZJ/JpI4P?=
 =?us-ascii?Q?jf09R7sOEbvjwsMXoNki4PQIQtX4bYm7vNTGVBtYtEcZPv1omhi7Kh1L7pe/?=
X-MS-Exchange-AntiSpam-MessageData-1: hvVHtjcQi81uNVbPI2VF6hn4YjqbMss7urc=
X-Exchange-RoutingPolicyChecked:
	KrlZxYnOUDzTl5iuC56BzcozmF15B6EYEIzzm9A3bCfMq84zssvwbJZSm4wzsskQ4KorEXMmSINvLW8lgiqLFMTaTu0MH/PD1lmE18lhye9rh9vSnJ9tjXzBnetRV3dbSsPUcobgh1FRoyNmjKIJRuWrxlu1yKdgRWkSe3pAgWJYcJNNPywKjAgYYPlhkbNwzlpxlCiFymMDmUqU1PH2k0bMMt8bLleU9lvLxJeZGwQQYS2GFnpVMxHweCKq86ffhLIKXB0iTa19W+FYeZwXSsKgKo/9xeeYhSNRT+CHoTyPGVQGTnWoOlNI29v0GIP9WaY4exOohPGwesPm1Be1pQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a3be71-8f6c-4e19-46f7-08de86c189f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:44:53.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPLIisENap51jSg+fygIvRHn2VkvZfDPrr/YbW83wUMJ5oKxte18nb4f7M1rtY3EgJepKvKuQ5eeENo2+iM9jQUXS6/MdyGkEMjELM5o9QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69bdb1c8 cx=c_pps
 a=OGRNNHJcR/XwrOfql3gobQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=RBo3ehTTX1hcqx067dEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX5TeWlH+3yY2u
 YfU/zkayKkTUw8csNWAFJ915r9TB2M9/RmorWVt9Tf983ml/raBE09AET0X4wjMqkGrLd3W8vEP
 APBZTHAmBr+0I7xFKX7aPqeGqk0X1vh/JtRl8OgE3ZALHR2cJ8kHetet8rZM7qS6+/UfqQNKmj+
 b5KO/12XCDiaSgBXd2ccBoYGcIyXILaR2YOWR0rv0B2+z03bU/Jy0jRP8F9DQcGLSg4DkSB2xDJ
 k2UIBFAM9cHZACmoHS9p8O9R2v2iPHuuFHqfcy6e1Qy0L1klufijROdo598XWG9Xsjd2JmYmblg
 TR1zhshuj7WhenpgvxCKZb/bfyBptneLbQqT+4YEMihawX+qIoTCrwgVKw5bXz7WyVPEPBc0JL0
 p9+1ZhPcNLKxBZsvk8X+kRbt8e3N4uAp3Y/zpZtgc4g1h+wUI/4pk+H+wCi0VZM1RZiov//wwTu
 NILKx7biadZFXGg9ITg==
X-Proofpoint-GUID: SqMT1RUBlYs0BZ46aO3laFS81bRqjafq
X-Proofpoint-ORIG-GUID: SqMT1RUBlYs0BZ46aO3laFS81bRqjafq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227618-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D265F2E0F96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Ionut Nechita" <ionut.nechita@windriver.com>

This series backports 7 upstream commits to the timer migration
subsystem for linux-6.12.y stable.

The most important patch is 7/7 which fixes imbalanced NUMA trees in
the timer migration hierarchy (Fixes: 7ee988770326). Patches 5/7 and
6/7 are its stable dependencies (Stable-dep-of: 5eb579dfd46b). The
remaining patches are cleanups and annotations that complete the
backport.

After applying this series, kernel/time/timer_migration.c and
kernel/time/timer_migration.h match linux-6.18.y exactly.

All patches are clean cherry-picks with no conflicts.

Upstream commits:
  4477b0601471 ("timer/migration: Fix kernel-doc warnings for union tmigr_state")
  922efd298bb2 ("timers/migration: Annotate accesses to ignore flag")
  dcf6230555dc ("timers/migration: Simplify top level detection on group setup")
  ff56a3e2a861 ("timers/migration: Clean up the loop in tmigr_quick_check()")
  e21665bac15c ("timers/migration: Convert "while" loops to use "for"")
  cc25b81fe0ea ("timers/migration: Remove locking on group connection")
  d4b3a4c2aa7b ("timers/migration: Fix imbalanced NUMA trees")

Frederic Weisbecker (5):
  timers/migration: Annotate accesses to ignore flag
  timers/migration: Simplify top level detection on group setup
  timers/migration: Convert "while" loops to use "for"
  timers/migration: Remove locking on group connection
  timers/migration: Fix imbalanced NUMA trees

Petr Tesarik (1):
  timers/migration: Clean up the loop in tmigr_quick_check()

Randy Dunlap (1):
  timer/migration: Fix kernel-doc warnings for union tmigr_state

 kernel/time/timer_migration.c | 296 ++++++++++++++++++----------------
 kernel/time/timer_migration.h |  21 ++-
 2 files changed, 167 insertions(+), 150 deletions(-)

--
2.53.0


