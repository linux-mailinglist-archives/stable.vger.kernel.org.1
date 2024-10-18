Return-Path: <stable+bounces-86829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32269A4084
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B1C1C2277D
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33FB9476;
	Fri, 18 Oct 2024 13:54:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7C18872C
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259699; cv=fail; b=dcCHq4tfDfUsNLMLRa1DpA3ysndwEhaSMpLkAgdmMv6kKeatAxHNaLmzPo1w2jqWbj111xDnmpuR2AqyPt9M4DgN11rcTV3Pee99K6JBIcyjWHhoBy4/GmZc5ajnENDtIpO+Q31G8dDZ1JlWKmQWSWv34QcO5lXtLu7ughiMtDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259699; c=relaxed/simple;
	bh=B2X8vktJ7x0CAsUW/e6tkoCTg/cDRMMb6W/gZKQM1EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePmcg2C2Hq0CC7xFC8SHZKWiApc4Btnxj748FF5oDY3fOdc9FBHzN73FlgcYaTNW/iitMeYQl99bi7Y6V6l17CcYsCG6HRcIOgQxOyCoJvh9NI7sDQNc1qxOBiT4tqONhZ9vB1nWI1aaAhzaA6h2vcPqG/0rVg70qJ3eCe0Pu3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I6bOug015585;
	Fri, 18 Oct 2024 13:54:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42a3eska7y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 13:54:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI70jl0otVCuCGjrteuiURspIRrIvFqdbBRBvPWpiF6fRNqNFlAVByZkl5QrT4A3/zSh/n0MkvGwXjL92Q7YAP/+ikgrfvBi603Ovty9+QuFvZZbGhYmKNCDSu63DH1TLFUGzj89BruWuOVV9rponsuD+ySY0C8S6Iyl9oggRpCErst0q224G/4QFezRmFE3HXrRAA8ncoqPvhLd38msAK5uCEuHGtRs9oEb4lEXOxc2nsAJK+8xjqAQSdvNmo7D8hUqnHQhZGtw7t4V4JpWQu8yop++QFQGby8+HjZ50a5ozcjUBz6YP3dzFGwuPdIOXtX8H91AUT0TmvbCBmX+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAyTACtwdBqD4ovwoGdE5WK+yloIt6IkYZtRwfaBSjc=;
 b=qLwHnzaGOdhAVhU4s2pLnXiWIW0LDGqBrNpET85/L986aDx4afjyTB764UqB8kbteXXXlFO8B5qTGCGXOY1fZ+kyd/ptuwt0gl48aRDCQ58D8tMWF+5jrQ8RE6BxBRFCtSrw56h1dGaAMrMLvN6E+nUd5lfDCh2k03gqI8fDZqRQzC8BYT7NDrr/RRcamJI2qJQIoJQSeYcLOWRcM4yZt4APWcVQ3P+IjMTyJGHSYbJY/q1kdYelldJROb+M/1tY6s/rT5EnnBXErwOrBTplJV8n59gnx1Ojg2ZSYtEn7vz+Do7AUg+b/SQxRhcbbumz1NoIqbH97lFADulRCG7c7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 13:54:47 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 13:54:47 +0000
From: He Zhe <zhe.he@windriver.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Fri, 18 Oct 2024 21:54:25 +0800
Message-Id: <20241018135428.1422904-2-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018135428.1422904-1-zhe.he@windriver.com>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f9df0a-a789-4deb-6c65-08dcef7c6dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqcSHP5XhcEQfF5EBFAnKjN7AcTQO1fdJ7Qp9XQZiNxq++G+kBnfShS26Wbn?=
 =?us-ascii?Q?K7Hm3t5dsh8/tnY52mMNJQbfXQAnGoAk0+K3258ltGsEpV4HlLOZ8NammCPS?=
 =?us-ascii?Q?Xipj7wgieFWDt4cHHlUjyzVQt1NgkNDD3aYSwlUPNepqSCUCxs4Rvo7svJek?=
 =?us-ascii?Q?E/RdbrggQ8OOurPIUUT9uM2zvAevM4ZtnFdTHssuWRKGKbMuWL0XSq25cueQ?=
 =?us-ascii?Q?mSZdMvLrkZ90YneQujXkQEnKGePZ80/f4mLowGaZheUb2gAnhySyMBvWLE0j?=
 =?us-ascii?Q?qe1Xm+XBl0pT15YTktL0WTTgZxFSI+SDSrf7+ABiLTTogSanDcgKwpB2GLrK?=
 =?us-ascii?Q?wMPGoFR+6o7nH+8DlLNneD86pbYt5VtdMQJ3PNpROZPgEaF156reh1FCtkg3?=
 =?us-ascii?Q?jfiBn1UkBvlpGJ94wi+idHO/l9Q6KISeOlORoTbW5HsWXQs5odvhfQOKuqHi?=
 =?us-ascii?Q?OJxAXyj4K2LmYIUYQzDs1aIb36RE5iM2HC7nAnVHsvLn8eu8DErO2DZ0jqGn?=
 =?us-ascii?Q?SjsO6vQBHawrDt707x2itm9FvfRkM9WTgbjGq324Do37KCjVlozBzclfJETL?=
 =?us-ascii?Q?ouwLTyvHWWCYqjWRUn62V7eFYJALiY/lOxX4ZbDjQx1JwMGDz1u/8oPWPwZT?=
 =?us-ascii?Q?xqTI3CbqIeRN3IdLRq+UOlmc1980V7Ozayy9vwe91X/HCYqqaJg/JCL4mNKR?=
 =?us-ascii?Q?pGCHQTWwoMp0v9gczs5avcZSu2RZhuLDAMuFis5NtLW7NlM+vsrjGpXI0WJi?=
 =?us-ascii?Q?r2rlphRygBalNZooH8u6Qp6f65TyJPZXWCz58/wylmvvrZl8ARb9bJVcYpIg?=
 =?us-ascii?Q?VogH9rrKB/id79PHme+t7mRhYybvHqnfwMwbJWkTXj7FBfEePqD9McHxnyAg?=
 =?us-ascii?Q?CVHiwkBhC7C6lI+6uU1fLQMfmNLgvERxmyUfBK0W3MKteAjKoSV2QIxIKonR?=
 =?us-ascii?Q?S/YUq24bP3b2PFeKaWyybZ7PNNNn8xT05JiRWbjjKBFpy6YZqFk3kbrqxbuY?=
 =?us-ascii?Q?hfo4m5zSf1P2l8NDmC/DIgWDI5EzKwTMoA//GQ4LnO0qMwN5ScfbtdSuInEU?=
 =?us-ascii?Q?kXZBGtKZM8e4cMeUiFgGJPTGaX7GVGTXZmy4L1vrzGewGZpeGAQsgT9MCLdN?=
 =?us-ascii?Q?fzHs8NMYN4mwlqNOFTl1NW0VmYGWJI8X/U3c7b505VhWIMG0xhmYv0eRmxxM?=
 =?us-ascii?Q?VjoEGwJQHQf6wG5wfFT+S0jNy12RhUgrw60LxIaoXlkFUEz74ObSIhkV2UKr?=
 =?us-ascii?Q?54Z4IX17rjriTnA6vQarGszDC8D59vt8hJ+67iVdcYPP2rlztjcyKNa6N4ej?=
 =?us-ascii?Q?LaayWM2UxD/zx4ngziCf+yG8wLzOJIRopOSAjVsQr1fxWf3ef1xg9THJ9/+m?=
 =?us-ascii?Q?2B2PkV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HdGk6oLE3Dg9eAX3uLPILTIyqjB9id9FWPsIfv3f2kI0BP519I2jaRoJJVQY?=
 =?us-ascii?Q?UUcJFD8wEZ4pzhjtNzcQqt9utpLxYA7S5oK0/PR4DkfG+Y/x51qfYipRDiDO?=
 =?us-ascii?Q?nFp4iy1d6UY/L5wzsT7wJSOazpPFb7XRb9po0kXSaTvCUqdTPREXnm9E+XXQ?=
 =?us-ascii?Q?DaZ2fxEzwDew/S/PpOhEvrwnJyQyOVFYW5rt8GZSvTMivnF3YmWi6GsLCkxZ?=
 =?us-ascii?Q?LQBXvuLbCFtjqK80WCJKPi94pS7kIUr0FPHVaiRhJOvB55/2REks5wZmUbfg?=
 =?us-ascii?Q?JvT+sNi6dSxyOXJOgiJ2XaDmagceiecPZHxHKrr2LJkeCqOGejAaif5lPjzo?=
 =?us-ascii?Q?0NCukyWMXxnchUlPiXpERKFCHwFlNShSS0HfJHUkU37XkSF9eK08IgCnGVYS?=
 =?us-ascii?Q?729Olqq5bwJMTHbvtirjNWa3Su6aP0GNGzHlk+yVCS987StLTqqan40qIeOj?=
 =?us-ascii?Q?z2+uG5FPHeCJehIbcG3pDXv9auC7OiwWlC1ARUljd3ZWWccmRayhiV5fLT3M?=
 =?us-ascii?Q?7LUCGFY8jufhs9pjAmn7OnhC6jt+sGidw+clSNyxX+KJE8O/r2CaXO9j0usP?=
 =?us-ascii?Q?8u+LkFj/DkGPTr9WBaq+gpq9+UL4BaJy4CWw38V27NUU+C0bAOklWOjjYe+s?=
 =?us-ascii?Q?zqt2ayt/z7SG8evAiQ1enjfSj7oggLOsJMpXrYdbMJwsiWD/mXId/qzcS4dH?=
 =?us-ascii?Q?lfufSDj0cBwHqfDYlrmYRmth385X9kO+Yqabv7RnisuCM5OOCz/NsSJ9+rqy?=
 =?us-ascii?Q?WHaE4rV3ECSenWnsl2KCaoK9ABYD9RZ0UofX/zWrEgS9P+r2mq0buifhfK/u?=
 =?us-ascii?Q?5Xo7ikKoS8owKGn87cvtFpqzHkuS6o8Wxxae0UN2C1GzG/CMRlkd7hohHyW3?=
 =?us-ascii?Q?fnj+cTSj7I4HHmEFA4eNNZRbLMMMg3lF8qc3lwANzIpbsRtumU5hvUJspXq6?=
 =?us-ascii?Q?faPOwn1ZWHBH1/lDo2stwXwWS24U+QMgam7/GWugk+Z13TA+AMRVyYLZHtT9?=
 =?us-ascii?Q?EstBwkjaYl5vE9cuyyWkg3xO4c/stRr5GDtOhMR3v2oI2sggYxu10o3Ycldm?=
 =?us-ascii?Q?LBhvvYY3R4v+VtfOeGmj2eC6BFYqbHmaFUycyUSyShL4TbZbt9c8u82IpQEG?=
 =?us-ascii?Q?9Cz45ndiRY+Ap9rQo8kpQfJcgDNhe/Tq0uFtad/77QPxkOT1evo0mM7eKljc?=
 =?us-ascii?Q?jmCtEHg49LCMWe9TTAKYfDmHZVmNx+QJoy/Vdjd4RRxbj94RjAKDAZTCa7CN?=
 =?us-ascii?Q?UFhDHsBJPGhVVbgGbmRIcJ7o7AMREvQdyoIErkx0BfUsb//BiS22CtHZO+fc?=
 =?us-ascii?Q?5/npt5cd1ZbCana7vqdOnsqr3GVAufFEWxvVsAthWUwkBoRpR5qvkYpBktjC?=
 =?us-ascii?Q?/UDdfGoZNTAyrYuUi5rOnrALhPCta+EqRm36UrQpOV0MXam82mrjgW/032SD?=
 =?us-ascii?Q?p6o0X47InPwTZc0Jz7szN6JSQ55Gan4aZYZasZ5gWgPlmwTqqit3/HBOSisZ?=
 =?us-ascii?Q?jgP3CGeBZPFXmUhS5uG0tKq3i91wuS+/C+ak9K9OEkzeVjfC3YHiW9dTFzu1?=
 =?us-ascii?Q?coubQ9tlGh+Fwb3o19HVlV0c0Rru2qXwocCB2mPm?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f9df0a-a789-4deb-6c65-08dcef7c6dcd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:54:47.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8zjnQ31XKtdyNqm8yuI+Cj1KDuTQT9t0QrI9L655vTnvQHnu8Rrt3vmt4elOq2kgNXugXjiYaSQCb+jPiCyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-Proofpoint-GUID: wg-5PP8r8NHA0iXrxwYG8SlXOja7VntX
X-Proofpoint-ORIG-GUID: wg-5PP8r8NHA0iXrxwYG8SlXOja7VntX
X-Authority-Analysis: v=2.4 cv=cPWysUeN c=1 sm=1 tr=0 ts=671268aa cx=c_pps a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=uMrHg8amAAAA:8 a=HH5vDtPzAAAA:8 a=meVymXHHAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=7G26uIm9ebSsEPFjGacA:9 a=GsS5VfSoVBdxg7MoEbKx:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=2JgSa4NbpEOStq-L5dxp:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=777
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410180088

From: Nikita Kiryushin <kiryushin@ancud.ru>

commit cc5645fddb0ce28492b15520306d092730dffa48 upstream.

There is a possibility of buffer overflow in
show_rcu_tasks_trace_gp_kthread() if counters, passed
to sprintf() are huge. Counter numbers, needed for this
are unrealistically high, but buffer overflow is still
possible.

Use snprintf() with buffer size instead of sprintf().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

CVE: CVE-2024-38577

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 105fdc2bb004..bede3a4f108e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1240,7 +1240,7 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	snprintf(buf, sizeof(buf), "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
-- 
2.25.1


