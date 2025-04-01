Return-Path: <stable+bounces-127309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BFA7781D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F003116A29F
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DEA1EE7A5;
	Tue,  1 Apr 2025 09:49:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C51EBA08
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500961; cv=fail; b=oY9vhF7TeDQSb7WTGLzezZfqwm2lKSWJAXQq+6eJDs1KczxE4oC2K+7cQeczgXMkT1Sw+mlLNo7znhk05D0Eh2xvF5arD70L+ixyRagUwq7GbEbWD+cx/E6KET+JlaMDIzP7VgGuo/SBtPKxNG9KxURIWTDBdDE3evU7xkSL7ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500961; c=relaxed/simple;
	bh=l1Ak2yyAjw6dES7wWNKpz/EDXjjzsG6IDn0kbu4Hp0E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=il7iU78nxbcB2g5c7FN7aeTKPtTKDbhnKZasgO44ilEffnDxfEPm24OlAJIwBOrV6JfvuP2Nh6pyxbz4r/H3xEor0eDdPTXqSKANMvHZy+anJ5g5zDOv58vjlSopHcgg4VGbZLg6DRt0cayBYqLw1n7o9/5eh60wPv8v7WG97Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53167B74031520;
	Tue, 1 Apr 2025 09:49:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45p7u8u302-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 09:49:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ/4juxFf1ti0VI5OH0b21cM1N/AJ90nnaI0yT3S2afFLgUvdxnXjunlX+5RG55770eytmEPk11h0VDNzT210/V18k2S2I4fsLEe1Ci6AP0tqVBfnrjHs+NIyStOKxjw7PvF00aReimeg+tXr8/6L8zJd6LfCAMsU28MfnCXBZnNFEUFQQ0m/61+oEdCjKT62ahfVV+7sH/ty9vX0G7avQTtszXQCb5z/GO3l4NxoH2tbi2RWNl+MvWIUSmTLxvo2hJZyeob5qCMLHXu8HE8iBOh9hozdG1RSbbDi51EGq422ZyAYMIvRGz/1vlzhuZh9C6HUCmiae//Sip1ZpITmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcd30RdtaUm37nWxq0LxTzRAPUrWRZCNxS2a1XPYsQU=;
 b=OGVsuXoL7NSSbQgOGnNkxbTetSoVfsDWfHUBDRY/YeccVqUYuN7PQMkOIA6atDdHg2jGnc2LAuDbesPI3vR5drfSe7PufnDhyak0PJPt7SDS5YjbzoYTeK2a4hut4lnEK8zAX0WtbNNQu5d/27KXdJ8j0RUKG8LrTNKzJN6iTx3gxBwb6oe04Pp1FWChCMh7EhFe4oabUNg7K3rS+SyeEFmAOpTakUXYiNdxz+1CDYYzGaKzE98azPKr4xqUAd6oFK1rItimIjVorJY3e2q6UX/XKaTOr5LgnX7+V6EinmgZwM6dnPbEB8PFH6zPPTh9qCCnh+L/THrn9X1wETxOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Tue, 1 Apr
 2025 09:49:00 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 09:49:00 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: kuniyu@amazon.com, tom@talpey.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 6.1.y] smb: client: Fix use-after-free of network namespace.
Date: Tue,  1 Apr 2025 17:48:47 +0800
Message-Id: <20250401094847.976358-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH0PR11MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f528c01-61a3-4a7f-7e70-08dd71026dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/rG8sX9GlOf4MI1ZV6Jc4A89WTa4tVS4pV1/F5zQ+kvzVr/yleFDd1ndkNcC?=
 =?us-ascii?Q?AdAh91uPNYoGvZ2PLTZ7LoBsNOGYgSOEWnfhNl9QUcbNNboW3pTv4ILlzuHc?=
 =?us-ascii?Q?EqmS2lfsxb1dWJ0N/nHfCl8kLE8CToK3dGCdPZ8BAgOKAfkvvZI4pgG0H0EY?=
 =?us-ascii?Q?+S0a+sMq22SzhOZhwwFK/wfp+ymTb1+iuGPPUv9CiWGnbz/Sek++jzU5lnOy?=
 =?us-ascii?Q?mq9mM3VlKu7y75s8Ol012zMSYd1f7UQwzuTNOs7Xo4jKydBbldX+kSD9qN89?=
 =?us-ascii?Q?wEE8R2aLNmI9du5eldC10T1tip8Y1eP4+WPbRXifMMiA4oH9077KCJZrVJi3?=
 =?us-ascii?Q?Mnu6DORHBqyphYsL1TfmJXTQ00jPJ5Uju8SWHfu5Ja/onwjN+skfaHjQ/NgM?=
 =?us-ascii?Q?gVJj+z2f+ZkaGPds2+oAThiAXJUq6dT2w2YlQ5B9yHhvOGMEDVy7ASQd8n8B?=
 =?us-ascii?Q?ZJ8cfM0O+ypnDuAl0ZhSWrEwu1HF0KqyGwrgphw1uqTe/3XDkYsrTTsNQQ4G?=
 =?us-ascii?Q?0fITZJDx8xOJD0kPNDcDOpUz/lVa9mXK+2V7ZNnAlvjB0l6sNBo947IxBWUG?=
 =?us-ascii?Q?rnMIKMEJdS6OqYBikxgOPNw2/bdQS7k6QxHBiGJ5GhR92qlaW+gbIRhYp0Jj?=
 =?us-ascii?Q?Xts35jK9OmqFQF4LChz2W1/Gb4/vA7W4vo+xGtYSGjriOfcYKueZTNROjfhm?=
 =?us-ascii?Q?CPH8SBaofh3tixrEu0zjwwIHBc7Qqqyq/N9B5dsyRbVq9VIkgD1KBYlS0T8N?=
 =?us-ascii?Q?HSZdNOJnPkPFBwhrkuGD/7q1CBZLjXDOWRS5wbo3VKhHtMJvoL14kpJF8fkF?=
 =?us-ascii?Q?+EAcLc/NgOzpmo02pMnQf7m7S8BbDS4E/FKHi0iI868wSBWSFf+nKiO72zBz?=
 =?us-ascii?Q?pmQNTirhPzKzD3+5stjjyRE/Dvi5ZJSUUUKoVBVccuvKEC44cQ1sRln1BRKH?=
 =?us-ascii?Q?yhUGf9hB2EQiWqJghuAfGDb3fT3tJQ6I8XWX0fjozdgUyyYIGww9tVBJjr2M?=
 =?us-ascii?Q?7u5M1cIDLKsR9er2n/k4Qc6xbU9RkQXHEJSDUacaZSqlQ1svPm1XVeo7MYDD?=
 =?us-ascii?Q?S3T2jlLHWuIK3kukSy+CUMaaIT3MhNqSWvVqdHkUZ2FtV0v39FV/lJNUYwoy?=
 =?us-ascii?Q?/9mCclEmVEDLac6o8DFtO0G003A6nKuMrzFpR9JFk6fo3T/L/4rZHn4f6QS0?=
 =?us-ascii?Q?hJ3NUI7XVxNc4TH8ZSsg0aVIZslDxmdmkgO1DkaV5EObGZLz2ypXmayRzPuy?=
 =?us-ascii?Q?qWVduRmV0IMESEbG8YFE3RkewJpIsKFPY775JwuXGhF48l9v7WeXtOXxTvzn?=
 =?us-ascii?Q?JdY80E5wxv3lx62HQbyY5z2NSnBLaDlAaqcr8vSDTWLqioKQ9xeIuka9dKNz?=
 =?us-ascii?Q?Slo20o0B5x2zFCgdWAEuNONqmF4gUbplG/PPXYhaye01Q9O8yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TkeSYXgWsweAaX6bUtw4rZHW7b03PZOv5BW51JF6U+87b0VFzadWBMvjzmdR?=
 =?us-ascii?Q?ZzoWOVQICIksuLrza9QQMMii4LeKz8kkjNxbb4MGMQ7Gk2TGP+votv3mS643?=
 =?us-ascii?Q?NxPbVYzo2TWqFF3p3lnTO8sVsBjk5Oot9kB/mme5ygHu6STUl6/7IoL/STaL?=
 =?us-ascii?Q?2GtSTOMNAcT1NvJIqBXhmO5z+Wl0w2oPPi14UAho+RcyQhPiM5m479uj+pGo?=
 =?us-ascii?Q?UbefR3vrKzVqjy0JPp3l8CRsv2TmaAcH7N8F5AaCZHBJKAR7BYlFHSaQ7o9z?=
 =?us-ascii?Q?tgKYnZcmeaCLVVI/4fiCZOsAi/tQNFVYwK/1DacSY7+B5/JYGWy+FS+MNz+P?=
 =?us-ascii?Q?a+Km1sH1JNJSd4kTn0rYM82yvQuSNNJaAYlWFsW4H+S0IUOi+R/YA34Du0iK?=
 =?us-ascii?Q?RRgVuFfmkXVO9I11PVEB31SqiqEK9nD6T+1WsktexPFqjTB5Y4bKsnfVesl7?=
 =?us-ascii?Q?KOPd6VI2WYJIEdSOl4l9idt+K0Nusyq+7sWSQruI8qiSDEhcFVKBFuj9aglx?=
 =?us-ascii?Q?/bdtZTRgIXfTufxHMeyvPuQ9FSkXmYNomwb1pTdENltWB3Xxfd4I7mtFJVuj?=
 =?us-ascii?Q?LpTruGMQcWX4TFjAXAmG07nXfLHbhVVY2IqfsFOjOV8K+Qg3tWkUuxcPnFQs?=
 =?us-ascii?Q?Q2elrF0SsEhWXGuNJcx6SKmFXX08zoQzvOczRQn6m4uH/k1vP1tJWI4irO+8?=
 =?us-ascii?Q?Su5lvnIyFO8xwowo2HTfhAKCOOpVYdO/PLd2+BEI6BV11Az7iRd0eICa+ec6?=
 =?us-ascii?Q?Fvr7v/c7IZN9ZYFdjsxRQFqG5ty2+BfKfztBttjHWQJ+0HU1y6dEinp2eGmD?=
 =?us-ascii?Q?XzovqAamfrnmakPzEA7rJnijMJaeGuJJRmhbAXSMczQoQgzD2WWpRGUDR+Dm?=
 =?us-ascii?Q?a0OYwGfkknpSVjWqqPYh/F9eoz3yI1FHo0kssOY1CUpO08L/RbyvABOjI+AP?=
 =?us-ascii?Q?kaqVrVgA1W0KZDAw5z125gUMahdp+AJ7mwD1xGnoEeClendPpPAyLQz4CdQd?=
 =?us-ascii?Q?957BMDST4HPa4e6bw2eKb87VjaTOKTC/cyEZf5sVUH9a4XTlEDCbneHoQVMB?=
 =?us-ascii?Q?THL/cws6CayMHAOTOn8xbGyUAXJPUMpHl5me4ZnsNd6lOHneYjebVXh8fSVp?=
 =?us-ascii?Q?+XSuI4yqIHdxB4N8fyen9KVNq5GWxHYu5xAJTQ4sgpGiVLtpZGtBkERoRDc0?=
 =?us-ascii?Q?xSM9bOSEL49hjG4j9RHP9l6rBpfCjjgqGkFW5K6ugx/EeclLcDF7sCMg6wwW?=
 =?us-ascii?Q?a6zACY9faB8WkGEbu+dPVTfR2rT+3z1VIIQqNAAsuhTeBXTDrcBmrGTxQ6ZB?=
 =?us-ascii?Q?cGpcbhE/iMJN5Xcs52LEE9R6Tn0liVoMPL//DFZOiuxXH6JXlKoYHuYOnwhR?=
 =?us-ascii?Q?a6fN+t1agb7HCHiLr1gnZes9pRgnJ2fg19jmMSQzke44AOb5L4M4nprswbyg?=
 =?us-ascii?Q?rHBysaYB3dLJSkHQodIXGKy0YMNSGfPg76Arqcwnr+U6VmNYbVQ625n8h1tT?=
 =?us-ascii?Q?Twpjz8U8Rf4elpMJgQXn27RAc5RnXQwm3vihIoD3Ca8QXTQMtfui5o1QeJEA?=
 =?us-ascii?Q?lhLepQq4QJ4iFyFFIdb8XD8vgVIfc9CsmVHVHeKDBTuQBV+jKF4ZONP/5/L/?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f528c01-61a3-4a7f-7e70-08dd71026dd0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 09:49:00.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTflJPLsjIwhlvv4tw6wQQiGdVbTfwW83aE7wlJQoVTXr17Mo4SWN7JFVr2atTGvSwNHzuRCC+XIMbT5UxEmy9e9vR6V/EtNmXi/egO7eik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-Proofpoint-GUID: XjjF9OAasqI0jPI8_GxPo-czjgoA7grq
X-Proofpoint-ORIG-GUID: XjjF9OAasqI0jPI8_GxPo-czjgoA7grq
X-Authority-Analysis: v=2.4 cv=RNizH5i+ c=1 sm=1 tr=0 ts=67ebb691 cx=c_pps a=G+3U1htxrnhIFlrbIuZW0A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=NEAV23lmAAAA:8 a=vggBfdFIAAAA:8 a=A1X0JdhQAAAA:8 a=SEc3moZ4AAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8 a=6s1ZfWTU7Ws2phOeXU0A:9 a=5oRCH6oROnRZc2VpWJZ3:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504010062

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit ef7134c7fc48e1441b398e55a862232868a6f0a7 upstream.

Recently, we got a customer report that CIFS triggers oops while
reconnecting to a server.  [0]

The workload runs on Kubernetes, and some pods mount CIFS servers
in non-root network namespaces.  The problem rarely happened, but
it was always while the pod was dying.

The root cause is wrong reference counting for network namespace.

CIFS uses kernel sockets, which do not hold refcnt of the netns that
the socket belongs to.  That means CIFS must ensure the socket is
always freed before its netns; otherwise, use-after-free happens.

The repro steps are roughly:

  1. mount CIFS in a non-root netns
  2. drop packets from the netns
  3. destroy the netns
  4. unmount CIFS

We can reproduce the issue quickly with the script [1] below and see
the splat [2] if CONFIG_NET_NS_REFCNT_TRACKER is enabled.

When the socket is TCP, it is hard to guarantee the netns lifetime
without holding refcnt due to async timers.

Let's hold netns refcnt for each socket as done for SMC in commit
9744d2bf1976 ("smc: Fix use-after-free in tcp_write_timer_handler().").

Note that we need to move put_net() from cifs_put_tcp_session() to
clean_demultiplex_info(); otherwise, __sock_create() still could touch a
freed netns while cifsd tries to reconnect from cifs_demultiplex_thread().

Also, maybe_get_net() cannot be put just before __sock_create() because
the code is not under RCU and there is a small chance that the same
address happened to be reallocated to another netns.

[0]:
CIFS: VFS: \\XXXXXXXXXXX has not responded in 15 seconds. Reconnecting...
CIFS: Serverclose failed 4 times, giving up
Unable to handle kernel paging request at virtual address 14de99e461f84a07
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[14de99e461f84a07] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: cls_bpf sch_ingress nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver tcp_diag inet_diag veth xt_state xt_connmark nf_conntrack_netlink xt_nat xt_statistic xt_MASQUERADE xt_mark xt_addrtype ipt_REJECT nf_reject_ipv4 nft_chain_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_comment nft_compat nf_tables nfnetlink overlay nls_ascii nls_cp437 sunrpc vfat fat aes_ce_blk aes_ce_cipher ghash_ce sm4_ce_cipher sm4 sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 sha1_ce ena button sch_fq_codel loop fuse configfs dmi_sysfs sha2_ce sha256_arm64 dm_mirror dm_region_hash dm_log dm_mod dax efivarfs
CPU: 5 PID: 2690970 Comm: cifsd Not tainted 6.1.103-109.184.amzn2023.aarch64 #1
Hardware name: Amazon EC2 r7g.4xlarge/, BIOS 1.0 11/1/2018
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : fib_rules_lookup+0x44/0x238
lr : __fib_lookup+0x64/0xbc
sp : ffff8000265db790
x29: ffff8000265db790 x28: 0000000000000000 x27: 000000000000bd01
x26: 0000000000000000 x25: ffff000b4baf8000 x24: ffff00047b5e4580
x23: ffff8000265db7e0 x22: 0000000000000000 x21: ffff00047b5e4500
x20: ffff0010e3f694f8 x19: 14de99e461f849f7 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 3f92800abd010002
x11: 0000000000000001 x10: ffff0010e3f69420 x9 : ffff800008a6f294
x8 : 0000000000000000 x7 : 0000000000000006 x6 : 0000000000000000
x5 : 0000000000000001 x4 : ffff001924354280 x3 : ffff8000265db7e0
x2 : 0000000000000000 x1 : ffff0010e3f694f8 x0 : ffff00047b5e4500
Call trace:
 fib_rules_lookup+0x44/0x238
 __fib_lookup+0x64/0xbc
 ip_route_output_key_hash_rcu+0x2c4/0x398
 ip_route_output_key_hash+0x60/0x8c
 tcp_v4_connect+0x290/0x488
 __inet_stream_connect+0x108/0x3d0
 inet_stream_connect+0x50/0x78
 kernel_connect+0x6c/0xac
 generic_ip_connect+0x10c/0x6c8 [cifs]
 __reconnect_target_unlocked+0xa0/0x214 [cifs]
 reconnect_dfs_server+0x144/0x460 [cifs]
 cifs_reconnect+0x88/0x148 [cifs]
 cifs_readv_from_socket+0x230/0x430 [cifs]
 cifs_read_from_socket+0x74/0xa8 [cifs]
 cifs_demultiplex_thread+0xf8/0x704 [cifs]
 kthread+0xd0/0xd4
Code: aa0003f8 f8480f13 eb18027f 540006c0 (b9401264)

[1]:
CIFS_CRED="/root/cred.cifs"
CIFS_USER="Administrator"
CIFS_PASS="Password"
CIFS_IP="X.X.X.X"
CIFS_PATH="//${CIFS_IP}/Users/Administrator/Desktop/CIFS_TEST"
CIFS_MNT="/mnt/smb"
DEV="enp0s3"

cat <<EOF > ${CIFS_CRED}
username=${CIFS_USER}
password=${CIFS_PASS}
domain=EXAMPLE.COM
EOF

unshare -n bash -c "
mkdir -p ${CIFS_MNT}
ip netns attach root 1
ip link add eth0 type veth peer veth0 netns root
ip link set eth0 up
ip -n root link set veth0 up
ip addr add 192.168.0.2/24 dev eth0
ip -n root addr add 192.168.0.1/24 dev veth0
ip route add default via 192.168.0.1 dev eth0
ip netns exec root sysctl net.ipv4.ip_forward=1
ip netns exec root iptables -t nat -A POSTROUTING -s 192.168.0.2 -o ${DEV} -j MASQUERADE
mount -t cifs ${CIFS_PATH} ${CIFS_MNT} -o vers=3.0,sec=ntlmssp,credentials=${CIFS_CRED},rsize=65536,wsize=65536,cache=none,echo_interval=1
touch ${CIFS_MNT}/a.txt
ip netns exec root iptables -t nat -D POSTROUTING -s 192.168.0.2 -o ${DEV} -j MASQUERADE
"

umount ${CIFS_MNT}

[2]:
ref_tracker: net notrefcnt@000000004bbc008d has 1/1 users at
     sk_alloc (./include/net/net_namespace.h:339 net/core/sock.c:2227)
     inet_create (net/ipv4/af_inet.c:326 net/ipv4/af_inet.c:252)
     __sock_create (net/socket.c:1576)
     generic_ip_connect (fs/smb/client/connect.c:3075)
     cifs_get_tcp_session.part.0 (fs/smb/client/connect.c:3160 fs/smb/client/connect.c:1798)
     cifs_mount_get_session (fs/smb/client/trace.h:959 fs/smb/client/connect.c:3366)
     dfs_mount_share (fs/smb/client/dfs.c:63 fs/smb/client/dfs.c:285)
     cifs_mount (fs/smb/client/connect.c:3622)
     cifs_smb3_do_mount (fs/smb/client/cifsfs.c:949)
     smb3_get_tree (fs/smb/client/fs_context.c:784 fs/smb/client/fs_context.c:802 fs/smb/client/fs_context.c:794)
     vfs_get_tree (fs/super.c:1800)
     path_mount (fs/namespace.c:3508 fs/namespace.c:3834)
     __x64_sys_mount (fs/namespace.c:3848 fs/namespace.c:4057 fs/namespace.c:4034 fs/namespace.c:4034)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ cherry-pick from amazon-linux amazon-6.1.y/mainline ]
Link: https://github.com/amazonlinux/linux/commit/12bb8c57cead
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 fs/smb/client/connect.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index db30c4b8a221..13dcf973e795 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1062,6 +1062,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
+	put_net(cifs_net_ns(server));
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	kfree(server->origin_fullpath);
 	kfree(server->leaf_fullpath);
@@ -1656,8 +1657,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	/* srv_count can never go negative */
 	WARN_ON(server->srv_count < 0);
 
-	put_net(cifs_net_ns(server));
-
 	list_del_init(&server->tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -3031,7 +3030,10 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	}
 
 	if (socket == NULL) {
-		rc = __sock_create(cifs_net_ns(server), sfamily, SOCK_STREAM,
+		struct net *net = cifs_net_ns(server);
+		struct sock *sk;
+
+		rc = __sock_create(net, sfamily, SOCK_STREAM,
 				   IPPROTO_TCP, &socket, 1);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
@@ -3039,6 +3041,11 @@ generic_ip_connect(struct TCP_Server_Info *server)
 			return rc;
 		}
 
+		sk = socket->sk;
+		sk->sk_net_refcnt = 1;
+		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+		sock_inuse_add(net, 1);
+
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		server->ssocket = socket;
-- 
2.34.1


