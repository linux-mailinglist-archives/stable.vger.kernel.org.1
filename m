Return-Path: <stable+bounces-125613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468FA69D9E
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 02:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1900D1887D02
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 01:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339601CDA0B;
	Thu, 20 Mar 2025 01:28:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB912AF06
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434137; cv=fail; b=PbWejc8J4B5ISf3YFGQZhP36/OW/WTrdAT4RQUDt+ptGqBgV+VYgWrwP3qaCB2txHRQZlYoIvdN7W68TvD10DKVRRytbrytKoD3c3Pe/FH2XFvUuj0QvarjLoe2nURF1TtoG0QZM1zunqoN7HP861ofzd7DJKLP0z8Kx3VKgNkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434137; c=relaxed/simple;
	bh=49M3MdGMa8VyQqSSKrT1AGkS/V//yWxXyP+EXt++594=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R3kah8PouQ4Rd4aqMgPBHW7fBpN/GB+ZY6/+A/t01pZJWn7NSIphoD+YNgrmJvjfcC779+yYHpxign8syUBLtNbqenxYJjW9yasHud9ATRC5Wdnmsf+F/oMjZYmltCvukTHp6+fod0+jucDwBP932vpQk9A1m7F0WfWwVojOIWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K0I4Uq032359;
	Thu, 20 Mar 2025 01:28:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45d0h95auy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 01:28:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBkt/qj33oI/9eAdgcnNPqw83IiLS5QbaYiCb/CskiKR0nU37IsuOJBDfZbt1rOYDh9lFkSNFhi8CCKSy0AL6u2cvIZFcTaFM4JHYwr/JgIF4QFIyP21sU1gMD+eeHzWIkXAEBaNAM86wXBVUd3VKwuHhsSupFd3n8Wohjgj5YtMpYLwPG/AIj2ZeKTfgIi9qlhVyMLxiBk9yjnmpgVLR+YcZx7JyvtAOiy5lRvhOtbVIAsXpleABioSg7igpwTLnn9ZDrlbqQueRnw/zzq6t1ka05oVBQiIAz/b4/a/ZzEaDsMEbvVd2NIw8Y/zZpOUfUe41EES2kDFqtM8bU41Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W26V907DHMhxLGDHKH/LQXMaADCMYPOPphOTKUu7XD4=;
 b=ghltmBwnX6IUEd871Wf3N8oFQDswcVQ4DYlasK/RNu257jA+2LzbVJzpQQbGYD6QYQ/kYC9kNdJZRCEdy13zLfbmDO4LA+YAsQ5oAkRy6WMBlyAkN8Xrm9Wx+zDIf0qeuDgGbFvx93TZUxKCrB7MSArVjHwlc5oRsJ2NTR/iz8hVwI9P+sU8mUHzDsSOPDsl3tkWBK6fVOCQcMnP+zc2BmTGtVd/nFhMxlPm9eBQkneqeJjY+34TuU+XtZYWLfncSmbZ/qciM1fu188iI84BaS/4wDzAruZjPYsACl58tZNdJNDalTqvrrVwCdPyHbsxU3nBlqjuGJHV105r/ljq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 01:28:30 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 01:28:30 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>
Subject: [PATCH 5.10.y] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Thu, 20 Mar 2025 09:28:03 +0800
Message-Id: <20250320012803.1740284-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: aee832ff-6fb9-4443-6a12-08dd674e850c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LhRnUmJsKEjnHchT/nPmfh4mLd892O6BSvGVe0Yr6hp2oMZyElAjBJh2toEc?=
 =?us-ascii?Q?XKpEL3g6CYihzozk9XKKv1zNi1QxkN1on0Q0MIbDuHkOX6U4Mm13augbobB6?=
 =?us-ascii?Q?MogwdgDsy78+EMEMv2WV8RVM8C2E8kd7NnydDOC+6iGVwFRU3pxAhkvSCGRY?=
 =?us-ascii?Q?khHgRWspFxd6lF/9kglYbZUnD854hz0qd5Kb04slA1y1K9xpOQw1zvHnA0KA?=
 =?us-ascii?Q?BOyL+eGr/D8jKthvkqCaUIMXXlbqA1NuBaoCyFYxf49Gv1/fgcgLfeTCA3wp?=
 =?us-ascii?Q?uuzq9OXUVGmz/EzL2rtaJ/0dXFhUrLprEfBimbHvTjGLVCz2m0owStq6EhW3?=
 =?us-ascii?Q?I6H7/SQ7Z+WpCzTuxXDR+FzSOx91kqQXkblznnU9oUTXZ4zACvMBitOupKhz?=
 =?us-ascii?Q?rTCCsliGct7CCSFPY9iMNAJs9n9+8ov7KAFDH5mINSEjmT0txYouy7N7/D8b?=
 =?us-ascii?Q?E6qGnHjnwGg54h8c4BOPsM5f3p6JBiuTr54xuzPvaKFUYmJnqVCy+2/yJ4S2?=
 =?us-ascii?Q?BujqDMW6WuQiYXxs+fSCZ4NNLzbiLyfrMrPetrCYbrGt6DvkxjeghPSt7rhs?=
 =?us-ascii?Q?pYeyt4uEBsx5ZXM2jmilocc+C9nZiThZdux2gyOzWh5m/5+1y0h5GN3FT0xx?=
 =?us-ascii?Q?1nJnKYhDF4KsmSuKK1xu4EggW/UWTjQ9RU9ur2RjbZjfuNrbkVZ19/KxJI9j?=
 =?us-ascii?Q?NpLCq/bkFDwT9PXY5kH6uhm3AQnioGEnD2ZiRvEHlyK1efK4tqGMcJMpoWgQ?=
 =?us-ascii?Q?50jMdfmiy2rqOs31zWnqgmzCbWWiS6SdzaulWJdjyHizjGhCOkqvRuvtjWPD?=
 =?us-ascii?Q?DAqSIVAbWqVK3rymrY2AEJxbzVuu+xVrewFtmcJkYgy17P0a98myp2ykipat?=
 =?us-ascii?Q?Qve6QpSG1dvK98dwbYCJM1xc42+Bqbbnr8U2ZyLmvofPPq2qZ/uHsBaL01db?=
 =?us-ascii?Q?TMQBACGUDjcVN53YviNhDWAcU+xEXT0uVhvCkpOK118vyg5OVYD/zNZ7Ylmi?=
 =?us-ascii?Q?C18BZsd98rwC0ltnlGQyJPPnUiFzZQwLXRRp4yvpz0zwbYrQmwL2cWLXP6Fa?=
 =?us-ascii?Q?7QJ3WlBj8kUOiZz5C9J7nT8okPiNwxKcxtaoc340xRS66taR4x+g4doJaXXL?=
 =?us-ascii?Q?Y0IPVQQOuIY90yHkGRnhqwkYB2fDccV9ziV21kV+LAWZzzkmluVBGTeJ2ctZ?=
 =?us-ascii?Q?E9fJu24RxnlpN1bJnOGVwCnlWzW/wdVK9AIyqupb4/1T0TSVAc5rv6POf4rd?=
 =?us-ascii?Q?wBnfYiurePajO4WxhhpREAVIRjZSKEof083hxG/T0db76K9VqiM4W6opiSW6?=
 =?us-ascii?Q?1NPqJrFeOX80ncbhXAdlhEHlwsc39SVaiwgswPjXuyZb/jO3wy6ntImihDi7?=
 =?us-ascii?Q?NRT6x1xj3alCzhdgdDcTXotpgYvr6uJJIQ+70amhdloaMOds+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+UN30YDfD8jntTglxJWYjs4Q9zfDPM2lMCkfOjDBaVllj+jfks1WKGdlYAu?=
 =?us-ascii?Q?7dUGw20YF/G83/JCCEelau8xxQjIF29eMAogZHGDlS++/SRJ7QRyaL+WO++F?=
 =?us-ascii?Q?iVFifwp5Y4ZdnRMBlK2t/T+j/GovkE1CyH1Ty0hIQxRgNUbAmepjFlUqnBON?=
 =?us-ascii?Q?t3jV9KmS8Sbay9uLgfSC7TQKZxktdPE7lZsIQhzdWAaMxK9rcA/mZsE1xRiU?=
 =?us-ascii?Q?00Z4nJOVYNj2VQEIf1BgTK6ph6KiLDHtJNqhFr4YMIiHhxpB6smTfZwlSA0u?=
 =?us-ascii?Q?ykndecBh71xHo3doMq8ygJkK7BY3p0D2ZNxfrQWpS+5xKgPp3LCa/AnSdbCU?=
 =?us-ascii?Q?DmOKEu66ASBotqwOxgcp9GgJIPIdc9YrR8zUHtcQe/VQcg/AriQzJglxPUnZ?=
 =?us-ascii?Q?EeFyfd95a2bVthNms9ONT5EMsLqxcXeVPIGWo8kbrl1iIVpVAJr7huP2fRWO?=
 =?us-ascii?Q?irDpMEoxSBgodsrELEld3dggKCN+YTwCoZf0J9jNmwQofeBWR04sNLOGWp04?=
 =?us-ascii?Q?QisdKzPROD6sbRs+ET5jcibbtEPXka3OMoYxE2llUxaHoUa280mvp9uJS1GV?=
 =?us-ascii?Q?tkw16RULwV873oTFffDhRzcaKc1Ye6BWaH6JfDCJkRYx3rgxmbGMPTqjgM9o?=
 =?us-ascii?Q?wgs1I8ZMgbZPWC332V+zaKcLj9olVjFn61tPS9gVgegysVfNq8qGfaqRBJEt?=
 =?us-ascii?Q?vKxym7VhWTBd2o47enNeQNWdx2nRkeSE09McJxNPyx36MUqAMW7jF2BCET5D?=
 =?us-ascii?Q?DdQjfwZQvOOBS6aRlBs1J9FVjzv+qdLUqMTMo95//MNX3rjGer9ZiFqEw86g?=
 =?us-ascii?Q?3q/ohNCC24klsyW9KGhya8W/aHt1PfsbiFmMJ9Vkf3HCscB9EhL8sGv2XgYF?=
 =?us-ascii?Q?eEfWpbjp+pTrBizyWIFkdnY+rKCRjeLjH2o430YG2Pbh8hOj+N/N3LKCemg2?=
 =?us-ascii?Q?xkCMr6Nse93UXWfsfaG4YAPs1c3SjiZtACPOfHBiW/BFpp2Zj7yF2SvkCUqM?=
 =?us-ascii?Q?k+XVHh1LMkdCKPcblCANae/+RbmzalMq3ZSDYILIBa5+dMajNMoyQ3Y7chfR?=
 =?us-ascii?Q?XryxL0uiB5nDrRT5EhdU/TKTyANtsTPAkkZ8WHvAR/5o+Fj0pzmw3W77RDUZ?=
 =?us-ascii?Q?rcLVxZlVaMV7FgeOek1H5eHZRRKDf8TufNXvvHl+WAcpB+PLcUw28Zd2Yei1?=
 =?us-ascii?Q?QUMMhgoRq/3ymIkmKZzrZt3DA1RUAjQO3CNSNwwT6cpa+iKubtS6we1CJKsq?=
 =?us-ascii?Q?2jyi8Cpd5SYFoRQ09HhBFta45nn+0U6yWtl34WCNrexmvThiVkQt0RA6u4+I?=
 =?us-ascii?Q?WKvR38i7IjPLxpeSG5tghcSk1a1Vw/AUncxwNFRvzTYP/icJEKYk9LEQVLnd?=
 =?us-ascii?Q?jItRtfqHcFJHMVfi9Gjpy3GlfBYT8Pje+WH37vgW+jSQnXMNJtuI013LTXL7?=
 =?us-ascii?Q?AuGcnf5D9Y/tY/O4JFENUJIuL9Swy7p3HgAomZLB5jqu+gXsF+GgckknSKLx?=
 =?us-ascii?Q?jj4X6LuCn3S/L5foCEvI/1EaThpQnBn8FSOKV2jw7h8fhRDb2arfNY2YD7gm?=
 =?us-ascii?Q?Smpa7JVVC+xXizH5goS4L/j56WhlwLUhd9ay4YdBOUM+YKxoqU4zUlNq3U9N?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee832ff-6fb9-4443-6a12-08dd674e850c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 01:28:29.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjuAYlyyLlVB98X19qVdjuEn+qYZrZdn5xTKcAMbAXdYvp07RU6rwm7mzS8qpRxfs9164HTB+Y2rU/Qks+ibu2muoJ/rX4Yn+OFxciM6+GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-Proofpoint-ORIG-GUID: lzzk-yp3iTKPbkTF8bZzUUcsjizkeYbP
X-Authority-Analysis: v=2.4 cv=ROOzH5i+ c=1 sm=1 tr=0 ts=67db6f43 cx=c_pps a=tyvwN2z/Y66O58r8mq/nTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=vggBfdFIAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=s6DitAzefgfKiWfrPfQA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: lzzk-yp3iTKPbkTF8bZzUUcsjizkeYbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503200008

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e8c526f2bdf1845bedaf6a478816a3d06fa78b8f ]

Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().

  """
  We are seeing a use-after-free from a bpf prog attached to
  trace_tcp_retransmit_synack. The program passes the req->sk to the
  bpf_sk_storage_get_tracing kernel helper which does check for null
  before using it.
  """

The commit 83fccfc3940c ("inet: fix potential deadlock in
reqsk_queue_unlink()") added timer_pending() in reqsk_queue_unlink() not
to call del_timer_sync() from reqsk_timer_handler(), but it introduced a
small race window.

Before the timer is called, expire_timers() calls detach_timer(timer, true)
to clear timer->entry.pprev and marks it as not pending.

If reqsk_queue_unlink() checks timer_pending() just after expire_timers()
calls detach_timer(), TCP will miss del_timer_sync(); the reqsk timer will
continue running and send multiple SYN+ACKs until it expires.

The reported UAF could happen if req->sk is close()d earlier than the timer
expiration, which is 63s by default.

The scenario would be

  1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
     but del_timer_sync() is missed

  2. reqsk timer is executed and scheduled again

  3. req->sk is accept()ed and reqsk_put() decrements rsk_refcnt, but
     reqsk timer still has another one, and inet_csk_accept() does not
     clear req->sk for non-TFO sockets

  4. sk is close()d

  5. reqsk timer is executed again, and BPF touches req->sk

Let's not use timer_pending() by passing the caller context to
__inet_csk_reqsk_queue_drop().

Note that reqsk timer is pinned, so the issue does not happen in most
use cases. [1]

[0]
BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0

Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
bpf_sk_storage_get_tracing+0x2e/0x1b0
bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
bpf_trace_run2+0x4c/0xc0
tcp_rtx_synack+0xf9/0x100
reqsk_timer_handler+0xda/0x3d0
run_timer_softirq+0x292/0x8a0
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
intel_idle_irq+0x5a/0xa0
cpuidle_enter_state+0x94/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6

allocated by task 0 on cpu 9 at 260507.901592s:
sk_prot_alloc+0x35/0x140
sk_clone_lock+0x1f/0x3f0
inet_csk_clone_lock+0x15/0x160
tcp_create_openreq_child+0x1f/0x410
tcp_v6_syn_recv_sock+0x1da/0x700
tcp_check_req+0x1fb/0x510
tcp_v6_rcv+0x98b/0x1420
ipv6_list_rcv+0x2258/0x26e0
napi_complete_done+0x5b1/0x2990
mlx5e_napi_poll+0x2ae/0x8d0
net_rx_action+0x13e/0x590
irq_exit_rcu+0xf5/0x320
common_interrupt+0x80/0x90
asm_common_interrupt+0x22/0x40
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

freed by task 0 on cpu 9 at 260507.927527s:
rcu_core_si+0x4ff/0xf10
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink()")
Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
Closes: https://lore.kernel.org/netdev/eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev/
Link: https://lore.kernel.org/netdev/b55e2ca0-42f2-4b7c-b445-6ffd87ca74a0@linux.dev/ [1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20241014223312.4254-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 net/ipv4/inet_connection_sock.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6ebe43b4d28f..723aab818b52 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -722,21 +722,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(req_to_sk(req));
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
+	if (!from_timer && timer_delete_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	if (unlinked) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -804,7 +814,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 		return;
 	}
 drop:
-	inet_csk_reqsk_queue_drop_and_put(sk_listener, req);
+	__inet_csk_reqsk_queue_drop(sk_listener, req, true);
+	reqsk_put(req);
 }
 
 static void reqsk_queue_hash_req(struct request_sock *req,
-- 
2.34.1


