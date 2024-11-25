Return-Path: <stable+bounces-95345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771659D7B8C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 07:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7380AB21A81
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BA2AE8B;
	Mon, 25 Nov 2024 06:25:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604D2500D4
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732515951; cv=fail; b=I81F2+XVGv6KZMxbz+GKUizYJVjGpxDwVoqaJdkueJvFZ0oqGI7s7+6xPCadaO6liLpWltWLZpzHKAEAA+nWhZwoA56wwx7d6U9Vy4G8FqbQoNZZ/zvsghtWssJlcvaqgaxfkDrjNcjtDmhGDtAfW4ZaFCJLJbb1Y1G6UbzkFjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732515951; c=relaxed/simple;
	bh=6wg+n+wbQ1meKH3HF8er6dxuCVmYFGJOSPf6tewfYTg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r7NfLPUeQkEXj8c9hzmwOsMeOI8xpMpqMVoyAxvmRs4CQNMUR36nTtNA3MNF5Pbm/fj8sJrb5SKTBvdwNhhag0HXdSI5UmmchTFMuMLETV0qq1fD/5tIn9ZerSWeavBQb3pXm+czgrLfJaoFcvZFOGSv8ckIsGRL23Ny2N7M0fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6Phx5004042;
	Mon, 25 Nov 2024 06:25:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4334919qn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:25:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXeDU7879UzxW/rLzg+DHLWhH0TwGtk7W+vLTN66tGwxv7j4B5STiRuKTCtOt089TmHVVbYUczF3BoZbZPrlAImgsObEIRTqF5Lx4qydQscghbjqO1Zk2W7mwq3j1z7z8h3pnWxtSjgHkwJi3ouJt/SujfUJhA7z+ZN7Xrs86VLw4b/1KalEOixlgzdukUgOt1E/S9Rj90A+Kerbt/INbArmews0LUnLC4W2maOGUqOBIxl4DYWrAf7O2LIRkYGphN/3oBvK2EDHFf0IIld8Zy+nMB00b6r0KndrHeCXJX0O0VaTUBSGiXM3PMo8kYHQGx9W5CiDVH/nwGdjpS0UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9GowG15DgrAWBsUCNOnn/mKOzLzvx3nqGZSDBtDXlY=;
 b=bEvsJ/FgGpgFyK3zA6LAt+xOEt13FRC9SLDxJZZgvwNAJjDiQuvk5APBXqLTwXaMV8/RJlB3s9XVJaT8Ux1DRdFMx9GaiJ9Sa4NZkP0R7p2nmWp+8sElBZNddvBAe3SNkJzjJ8o4oT8IcDk6W2MmnverHhGfsJiYXSkU/Aw7ckCgS0oGZae37fePVo7usvIsGLDYCngweaPdFhqiYtK2fmsZ7RxB1w8xOizFUimMHwz9OEp74Y7f3Mw4JI4JDdfexsT47tfhUq5OdOshMvGmmWIeY0c0ZhNx2h1ZEs1YLfFbufdpUCPW4hwPpC5JmSStlNJqyKa3DNJC5kS/sPFXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 06:25:39 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.024; Mon, 25 Nov 2024
 06:25:39 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: gary.chang@realtek.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y] wifi: rtw89: avoid to add interface to list twice when SER
Date: Mon, 25 Nov 2024 14:25:49 +0800
Message-ID: <20241125062549.2525431-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e750eef-6e4c-4046-962d-08dd0d19fae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKE6vrGi94KnrOCVsDU7dSVEgENAPU8nb1AMvoAvhz08TDMjw1zrSEe/sFPZ?=
 =?us-ascii?Q?Ldj8kriY0UqpDG1flEA6LucLxRth83EH5Ohzf0w8jmktSZSb91E191nVQ1PG?=
 =?us-ascii?Q?V7kSQmGswGOqdJEt2zZ/toMnnGDR3rYoIG/p6O/ZCJo22ldAd2EjM37I3Dxy?=
 =?us-ascii?Q?UYSIf9XnPPG7IVsNgmNfeovfh+ULhkH6rsCgTBnVZJ0YkpaPkvctTbNHzPho?=
 =?us-ascii?Q?qisFQhOdSWlv6kYH6Qwk8Nf2BAcgEwvnfGUPreuJfZ0tnjRzZyF/jw0siN+0?=
 =?us-ascii?Q?dI2hFgvJ8MkijQn4s5ckuXpxfClg2vdmw+c/UUjYlXoDbbrdkPJuvGnZx99n?=
 =?us-ascii?Q?OFlzTaTyiN7Uf8IlW7NaivJb7HkEmE4s7TO3Ifie+tQkqWYUSDV7yyQ6SCjr?=
 =?us-ascii?Q?Q3qODesK6gRFLZrlDaYxpcG9+CZaAnwlWyzMsQVumNb3NNWu7xH8923tfUNH?=
 =?us-ascii?Q?lq3OnrXvlyWSAvyARUEbemhhX33naB5Ha2yL2F2gL3IVIRtc31DO9B2rHUo9?=
 =?us-ascii?Q?GHQuXgXolnqLI23rmadnnOf1jKBeoM8dDu+D5mSIZZWj6Mmkag6qYEqA6OoE?=
 =?us-ascii?Q?4eyKCpH0Qn6ysdq0DzT639rUeCQ9wkw7d/R3AmbFeVDMEtr9s1rybWWe46nC?=
 =?us-ascii?Q?RqtWmNsAPNIagOgJnZILsmoy05CCKitJP5HF0kJ88KidP2X35OEgF0/HIZUO?=
 =?us-ascii?Q?tj5vNxxkeKC2H5BkNeMn9LrYKB2e3HgTfRtSn1KGls/6qvhxhEFwujl7xD4L?=
 =?us-ascii?Q?S/MP8iUMob44yOBI0ioSIwjPy5JIYPUL60l9bOHDXoWnu5bL5kAWt1dz0GVF?=
 =?us-ascii?Q?SjrL6C7XkYHCSxJMVZCDOLYUubE/aPU6tJJf2ROM53sQqt+fh21rKhhEaQJb?=
 =?us-ascii?Q?vOMPZFFpXU+iocg7+Raa7KuUuuqkiEuXrxUZpj3SiX3zTI9nHhz+iW1mJ3aY?=
 =?us-ascii?Q?3w+Px+k5He+LbKll9cENW1NXcq0okapujqseJRre9z4dMxuSrAiFgGsDfLY1?=
 =?us-ascii?Q?RblF0NLsgOQsWMwoDyGIh96XAX9+4azeFribW1vxeTFNX6sAPScEKAjc6Gbk?=
 =?us-ascii?Q?npgrScOb6tbpf9tggOUdzLL7ooe5ncYyvIQ0ytQk4QFIsJvKgaedgRXE0Igr?=
 =?us-ascii?Q?A2H1sxk03posrcyw7exwwOtMe0lQfZ/fOHtHYSEUl9gQn2r6xp3tcg+w52Lv?=
 =?us-ascii?Q?3KzCKPt5/431g5r+Pk/gc++fXRAdN+0gaeMTREpDMSyEoykXTKzxMoa6jrSh?=
 =?us-ascii?Q?kTFmZ8sLDSSFrj7OMYh8ugSPBjov8dzeavFW6NmHNKH0wQOMLR5ixpR8Sktt?=
 =?us-ascii?Q?PpILu/yNAySsu2/g04ZpK/wzfetPtfHWadSdO505pK3tai2/LweSlwXQqoW7?=
 =?us-ascii?Q?OIdH5mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H8QPyrQZfweR5hZjatTRSs6oVyeaU52UHrCinMfYMAhDLcHr0OphczNH5smJ?=
 =?us-ascii?Q?1QrgIKWjyoAaTNbLyz7j/9WxO590ujKdwgA+l/47EsE3S5OgZ4E8xzfINtTN?=
 =?us-ascii?Q?ipA1loRjGoGe+CWWxxLOADSWuqvXYB3e/0C6F91UeDMBsm1ezb4TOy/4e1nK?=
 =?us-ascii?Q?RyRZG630n03kTkEUVOesihnXOLEil9CoEPA6+Kq5FnHvU3XPK3SGTwOP8mrG?=
 =?us-ascii?Q?d3s9wXycUPqzncFZZLqjnEsKjMCUN8pC9LcxrKtov7KWMqj+IyCmG+j/csZh?=
 =?us-ascii?Q?Eugqn9bM4b1GnVyqHcFcw42HiTlUFLiibufy4AFnOUCSRFflb/URycwYbxmg?=
 =?us-ascii?Q?buj5mFvOes7npBTO2YrcF4918DVmCNTMtyeRCZ2a28hHzfU+ayOthac81Y1c?=
 =?us-ascii?Q?gD4icx3HN+E04P2l/Qjw6GrXBDYX6wYHR/H2y8znGUTGW/ssuU1nOb/VB+AQ?=
 =?us-ascii?Q?ezHirjLS8cySUx6Ub2grxYe3L57ABibBGrLAQLUTldEreKNRXhD/VVgtSDiZ?=
 =?us-ascii?Q?IojQn3TRpH8DvxcD5wPdS2wr1mIFR1JC03wUGIDG4Uh60YeVLL8xC3fY5n/K?=
 =?us-ascii?Q?KB4VD8JrXjp6RJU+2fHnKlKp8XWbSW/0t/YjsaBPWrnx8wM4oDM0Yz0kpShP?=
 =?us-ascii?Q?AZUU1cEmBRuk2oUKcy5/MCLoh7NF761kN1XZz5lq4o1vElbqsgjjwcbW2kSp?=
 =?us-ascii?Q?HIxe8L0Q1zVM5hQBx4LvvK3j8zXQNhlAX8sky3KpaJIZPS/SPqcK58Gqhchj?=
 =?us-ascii?Q?loisdTPixBl7i39K9oWDW7E8iB8NGeDD3wN/ed0VyaeMC5JzB5G+wcrsDXQT?=
 =?us-ascii?Q?SuJnblo0dldJJOiOLwlPCrXmGITy4trF0CgbSTW4A+vDGzCb/li/laxn3s5e?=
 =?us-ascii?Q?LLUaRGXVZ01fXYpJCduacmBJMya+p3+/ErtXL8xKZ6eoK7AZc+W57pNkXO39?=
 =?us-ascii?Q?VZU3tSaI2dSgwef7nx3qKjyREe43pMWrLBuWTbe69+KnODPAVorULKophFlS?=
 =?us-ascii?Q?a53Y43vW7svRlFH4+wB8nJLfyOeLpPGy4KRWMX27olAFMZ28b7OPHnbO9S9x?=
 =?us-ascii?Q?yOv5Ya/toZYZyvtuS8FZwHPwoKrNSZ4SQH9gHr5X4qG1uRr2KmDbR1v1Dmr0?=
 =?us-ascii?Q?2JeaNyS1fZceRnox0Wwu+OscOnoUcy1IFmbot1QU5bIkp0YyZ7JN96fkbbRy?=
 =?us-ascii?Q?eeOfJYgk/boCdqni2QAZ4IUWJ0ASFShw+zd6Ty36K9vXMTpWqHOo5BuAWjhQ?=
 =?us-ascii?Q?BEqRUw8VQl26g42QyiGenEsSAPLucgmQoUsZ59ZWEZd4h07WR5MYVJLmA6Ss?=
 =?us-ascii?Q?lngR6CHcv6ZBDEIumkpi1FdK0oVkChV6yXjgHBOzGmrLiZFaimvV7RSU6sY3?=
 =?us-ascii?Q?hb17BjP0f+jRwPSAKY6MaYEuUD7Zpc3LvOyU92wNQtv41LmTUeAG0tZu1VpJ?=
 =?us-ascii?Q?DCt1xDMIZGtj+h9BEjWQ6iMlGOYdZFwcIccgr3O+rqN/vhFh8KKD6qRsmd9X?=
 =?us-ascii?Q?MkcpAm8WlLvyPyQ3zXPd00TjE19EIn40WTWJr+7YDbczi+erkcKFd0v+4oJm?=
 =?us-ascii?Q?Jfw5AmIYLLjkIsBZHUJ+WPrTydq8es4c9VvkW2ZpwgD7IrRFc9rLmOXdfLH4?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e750eef-6e4c-4046-962d-08dd0d19fae1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 06:25:39.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3CLlytI8xrI4jjXggcld9ecaBaPGnYbIG/Hgvza5T5tcyWbu0rxnQuYVeQ1BCeQpz5l9LDvU5yB9D9ZpKyrd5J2wL/PfQOWbgR/ZSyPaXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=67441866 cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=bC-a23v3AAAA:8
 a=n9Sqmae0AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=0LNt5NB-kHVTqQhhKekA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=UmAUUZEt6-oIqEbegvw9:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: ITIa9SNVMzEBDRO0NAsbkp6lec7_MG3B
X-Proofpoint-ORIG-GUID: ITIa9SNVMzEBDRO0NAsbkp6lec7_MG3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_03,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411250053

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 7dd5d2514a8ea58f12096e888b0bd050d7eae20a ]

If SER L2 occurs during the WoWLAN resume flow, the add interface flow
is triggered by ieee80211_reconfig(). However, due to
rtw89_wow_resume() return failure, it will cause the add interface flow
to be executed again, resulting in a double add list and causing a kernel
panic. Therefore, we have added a check to prevent double adding of the
list.

list_add double add: new=ffff99d6992e2010, prev=ffff99d6992e2010, next=ffff99d695302628.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:37!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W  O       6.6.30-02659-gc18865c4dfbd #1 770df2933251a0e3c888ba69d1053a817a6376a7
Hardware name: HP Grunt/Grunt, BIOS Google_Grunt.11031.169.0 06/24/2021
Workqueue: events_freezable ieee80211_restart_work [mac80211]
RIP: 0010:__list_add_valid_or_report+0x5e/0xb0
Code: c7 74 18 48 39 ce 74 13 b0 01 59 5a 5e 5f 41 58 41 59 41 5a 5d e9 e2 d6 03 00 cc 48 c7 c7 8d 4f 17 83 48 89 c2 e8 02 c0 00 00 <0f> 0b 48 c7 c7 aa 8c 1c 83 e8 f4 bf 00 00 0f 0b 48 c7 c7 c8 bc 12
RSP: 0018:ffffa91b8007bc50 EFLAGS: 00010246
RAX: 0000000000000058 RBX: ffff99d6992e0900 RCX: a014d76c70ef3900
RDX: ffffa91b8007bae8 RSI: 00000000ffffdfff RDI: 0000000000000001
RBP: ffffa91b8007bc88 R08: 0000000000000000 R09: ffffa91b8007bae0
R10: 00000000ffffdfff R11: ffffffff83a79800 R12: ffff99d695302060
R13: ffff99d695300900 R14: ffff99d6992e1be0 R15: ffff99d6992e2010
FS:  0000000000000000(0000) GS:ffff99d6aac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000078fbdba43480 CR3: 000000010e464000 CR4: 00000000001506f0
Call Trace:
 <TASK>
 ? __die_body+0x1f/0x70
 ? die+0x3d/0x60
 ? do_trap+0xa4/0x110
 ? __list_add_valid_or_report+0x5e/0xb0
 ? do_error_trap+0x6d/0x90
 ? __list_add_valid_or_report+0x5e/0xb0
 ? handle_invalid_op+0x30/0x40
 ? __list_add_valid_or_report+0x5e/0xb0
 ? exc_invalid_op+0x3c/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __list_add_valid_or_report+0x5e/0xb0
 rtw89_ops_add_interface+0x309/0x310 [rtw89_core 7c32b1ee6854761c0321027c8a58c5160e41f48f]
 drv_add_interface+0x5c/0x130 [mac80211 83e989e6e616bd5b4b8a2b0a9f9352a2c385a3bc]
 ieee80211_reconfig+0x241/0x13d0 [mac80211 83e989e6e616bd5b4b8a2b0a9f9352a2c385a3bc]
 ? finish_wait+0x3e/0x90
 ? synchronize_rcu_expedited+0x174/0x260
 ? sync_rcu_exp_done_unlocked+0x50/0x50
 ? wake_bit_function+0x40/0x40
 ieee80211_restart_work+0xf0/0x140 [mac80211 83e989e6e616bd5b4b8a2b0a9f9352a2c385a3bc]
 process_scheduled_works+0x1e5/0x480
 worker_thread+0xea/0x1e0
 kthread+0xdb/0x110
 ? move_linked_works+0x90/0x90
 ? kthread_associate_blkcg+0xa0/0xa0
 ret_from_fork+0x3b/0x50
 ? kthread_associate_blkcg+0xa0/0xa0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: dm_integrity async_xor xor async_tx lz4 lz4_compress zstd zstd_compress zram zsmalloc rfcomm cmac uinput algif_hash algif_skcipher af_alg btusb btrtl iio_trig_hrtimer industrialio_sw_trigger btmtk industrialio_configfs btbcm btintel uvcvideo videobuf2_vmalloc iio_trig_sysfs videobuf2_memops videobuf2_v4l2 videobuf2_common uvc snd_hda_codec_hdmi veth snd_hda_intel snd_intel_dspcfg acpi_als snd_hda_codec industrialio_triggered_buffer kfifo_buf snd_hwdep industrialio i2c_piix4 snd_hda_core designware_i2s ip6table_nat snd_soc_max98357a xt_MASQUERADE xt_cgroup snd_soc_acp_rt5682_mach fuse rtw89_8922ae(O) rtw89_8922a(O) rtw89_pci(O) rtw89_core(O) 8021q mac80211(O) bluetooth ecdh_generic ecc cfg80211 r8152 mii joydev
gsmi: Log Shutdown Reason 0x03
---[ end trace 0000000000000000 ]---

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240731070506.46100-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/util.h     | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 3a108b13aa59..f7880499aeb0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -105,7 +105,9 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 	rtwvif->rtwdev = rtwdev;
-	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+
 	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
 	rtw89_leave_ps_mode(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index 1ae80b7561da..f9f52b5b63b9 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -14,6 +14,24 @@
 #define rtw89_for_each_rtwvif(rtwdev, rtwvif)				       \
 	list_for_each_entry(rtwvif, &(rtwdev)->rtwvifs_list, list)
 
+/* Before adding rtwvif to list, we need to check if it already exist, beacase
+ * in some case such as SER L2 happen during WoWLAN flow, calling reconfig
+ * twice cause the list to be added twice.
+ */
+static inline bool rtw89_rtwvif_in_list(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *new)
+{
+	struct rtw89_vif *rtwvif;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		if (rtwvif == new)
+			return true;
+
+	return false;
+}
+
 /* The result of negative dividend and positive divisor is undefined, but it
  * should be one case of round-down or round-up. So, make it round-down if the
  * result is round-up.
-- 
2.43.0


