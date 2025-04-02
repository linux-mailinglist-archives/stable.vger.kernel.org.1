Return-Path: <stable+bounces-127404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D366A78B98
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 11:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EC018931ED
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F612356BC;
	Wed,  2 Apr 2025 09:57:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E47081C
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587876; cv=fail; b=EiY8zkVGtMAC9o9WQEDIY8I1uePVxviRC+qOiqp2sFKpMMfU7qPmgbgjTFsNImuZo4YKjwIWUedq2oMPu4bvQHJMD3JldiBBXEFsTpyv5bG8X5MzVRSIvT6odGkH32eSZf6b52CObrIzUM1Uxwos4AcHn3Dp0DsZh4RdNfzIzq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587876; c=relaxed/simple;
	bh=JaGrcmTVMqLMEFd6/UHuAaxEuuwWiKThWU3ZlH2clhg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qHUFDBL337mx/brNOw4FgQX9h03NWN7pOKn/vKtLU48+UhgwxZVvtEH/HqjzSwAnU/O5/9MMkwh13BZ8j3T1d0cfBFDTTe3uY5jVIVwW7u8nIpKQUhlhJC3uIcrpbUcxck8zk6ZnNajmInRaz9cLRSQNUBRTg4oQdyR4RMsiL/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5329U21T017307;
	Wed, 2 Apr 2025 02:57:45 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtc9rmxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZaC5XtcluVXb5WxcWDnxVCvm+rr7qyAR8rjlVca/U2NYkn+JrVlKCW7UppifzuACo3n3IHdWd0p3PUYj7N96+Otmrw5/wufZLEjr5FEoNqUyfzFFclAG6PqSNr9TDjmh+c3S78UPJ3S+EaYEfjE94OqaWQ4H6qkxp0h9e6NCInBlXC/S/BrjC/D0+u2UwkXLPNUgcMWVpEl3iq/I+wT2iTTsIIsb7Hc6IcjwQh9K93b4Db0tqzQvqQCr5zaO61e4TtnYu25+8pt7sKE411TbxyzqFQCIlO/JgtL4XTunF0svJRo4K0N+p/+P4DogEALcJhMlENvRlc3lXFKNxgIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxjVnYIz93CUMb4OXDBqwzq0nRJhfoo66nx6FxqOXrU=;
 b=fifee3hCT1Wuzb+05juNZC4RzmrTvE/9NfwxTyIy8bHR/IUJZ3ylIHJsCoit1zYoD0DhNVMgwLeKTWiNvoskWxzJCvF2gfF2H0som0r2yXeRxeJFxxfGNpE9RWTkmdnR2qresJ4yO7tAYbpz/JtJyPdxYBVowgEVc1kfeDR7kJbMxpSo28jloBbzMT/OMHDqwzbfi1o58uTtoGgAHJZJrvYMK8QbV+pTtYH3QEJAmbMMMHTZ6K8lQpCDDHkoWuO1Dlt9Qj0RcO24C2p9iA4DGTBZ86t2uO2e0BIk1SK7138ykfFEBzZ+0vtLeP1VKtE1M94CansdQDAVhfVXKPzl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:57:41 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 09:57:41 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: pc@manguebit.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.15.y] smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
Date: Wed,  2 Apr 2025 17:57:31 +0800
Message-Id: <20250402095731.1813286-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcae697-0587-4112-7649-08dd71ccceb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lL5hx5zSeLDxzHzV/sEDhAu225ijL1dhVgyoyHg/FGl28msowibrk5r66c9y?=
 =?us-ascii?Q?2BWAJs5OqptSRyWxbuQHAfItLhNRzjy+0fUU7cSHqGOyg13CQWTUUg47aD0k?=
 =?us-ascii?Q?xv8fYuf73Then0t4RQjHpcArrC6Ze6/6oJJFDG7yHeRQj3EoqRWl7Tv4oGOM?=
 =?us-ascii?Q?D+IvXGzpUJ+Y4JlyHBoSCkHY7zr7eoPTHgVsnUEuaAS+616lG7EysxDC6hG3?=
 =?us-ascii?Q?UvUDEE/aGIlxga/OTfXOLxi8Kz4mbhYSExpwf/k1t1j5QVacxTxASwu+CmSq?=
 =?us-ascii?Q?MwqpkdK0NTR/bqW/ss44MGnphaDZXfI/yIbmJUr2gCpbDVRsMAfSTuTudmDa?=
 =?us-ascii?Q?jmfIEMzTODw5jJVWImwhUWi9nDhZbHvF1mFdHCVYV97CNexUx6mthi84MU5F?=
 =?us-ascii?Q?TOJsyltfBWIpiE4qJ2n9OBVooUPX1k2uYukm9CfueNgA6jxjzPS9AhTcc3vV?=
 =?us-ascii?Q?9ZGYOGcFA6eQfYYuLECX0sksR1hg/iltqCexI35c9jTALC/9oQvzUqAlyx/x?=
 =?us-ascii?Q?igmpjm14VioSMEdQChH076q5GJ+bUMJvsePRHnph6VmnkUWELzNByqwVF+1q?=
 =?us-ascii?Q?LwmNg9pBOd6leAoDw5zMURKEHRNuRoWvQlzjgHBr1eBeFlZZmKQdU/UpGJi/?=
 =?us-ascii?Q?//sIuUNJLBuZhA1DYnrUtHpIaJyAFgffDPuhxFizy1kQCIy02GDRzce/m8yR?=
 =?us-ascii?Q?CJ6wNATSvyK/U/LKvG/y0/U+VfDoJieOw+3t/14nHD8eVZitZ9xLV/DNjlre?=
 =?us-ascii?Q?r0OnM64ai/XKFSnwNlgHN9cOCK7im3R+zt0kHLA2njrzukBU1UOru/x5OE11?=
 =?us-ascii?Q?/RXRkgGc8joOwn0p9kt60hZ7YiYOSQvgL057mfxqWseaijyomMktxt6FIDsy?=
 =?us-ascii?Q?6OogZqp6jzYWpW8V7FlFgnY0DaBCSqPzU9zh/ohtkl4zr5f+0WQQldxKsp9Q?=
 =?us-ascii?Q?m9XIuoUQbstJbNaWg+DbOOsbs4szWd6hoUo0FuTy9yvAet2sd0RPI1R8URPw?=
 =?us-ascii?Q?TfyU/u6ySl7vVBkiRi6VxmTgfzc4d23DKI0sHIbNZgoin9x+1cF1CjG3HwND?=
 =?us-ascii?Q?ov7CKjPiFnMHClJ3gKv2x46SNfUalLnglQE8/w93evo3mHM0XWLoewh8dlX3?=
 =?us-ascii?Q?j4xopGA4e/kfcGVgTx+cdCKRjThBbx70yJG/pDwjr1jTUM88DDMhIDq2rkVy?=
 =?us-ascii?Q?tRnYpdEAsSsBCjGWhhWApjDxvNUwAp+a+ToDicdJQCceFc2TtLw2V0Gd9uXj?=
 =?us-ascii?Q?u5QFMKmrbPOv3Gvp/uZFp+B+tYDH+DRy1uAyW6S11KuWiHaB2F0yQ3Bp9hx/?=
 =?us-ascii?Q?hInI269/NyYLLLqmq//9mi6Q2PEj7GDW8gPBTeC8kBFmZFj953cYyYWlr1wg?=
 =?us-ascii?Q?R/5uuMR5nWycujioHNClLLyy0P7FfjQ/z1lFANVsKZhR7yPBlpXuLwiug+sW?=
 =?us-ascii?Q?u5kvyftzbrFmWybmyOTlNzv/J1Q4GwDM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mzM1Ivo9l/VtAFCRF5M1JYCxkVtnZTI3Rcd/kqdCBARzbr7O1OTTzOvRwRrC?=
 =?us-ascii?Q?i8V21e2+lAopIsnh7XPF2BwX15y+G8VKn8M0khcaCpAl2AQafx4WSEiX/Rbw?=
 =?us-ascii?Q?jTALy+GeRmcppdcj6ft33SpqAPAHMmkRMuqvPe0F/9aSIL1KxrgtaKvq/P7F?=
 =?us-ascii?Q?ddyk5KD/xjlC4/bRFVPK4dUp4OY2vFKFi02qQWzSA03V46OTw1zGtm7nC/uG?=
 =?us-ascii?Q?HyMIlI3jXCycPtMJnrLxDTMpBmhc45Ce46ViN66nMV9ihz0pzVHxYNxUiDZ7?=
 =?us-ascii?Q?snSShIRJrIo/Bu+ERUWJMQoUb25Hax7yTv88YREZSXt/CogOmnsJAJPzXZYZ?=
 =?us-ascii?Q?oGC+FRw2NwIYwIqwq91Myn2p65bbZF+kGrl8mhpnkIKDji8xgTgPYxjmbOY2?=
 =?us-ascii?Q?e44Kut+G6HqrKa6I5jwPy9QmIbYhv3xxnMu5vsHDtfQzsUlC4n3qPjmsrie6?=
 =?us-ascii?Q?689BoT0EHyC9jtFVzniUzDBPoIwzfQ1YZ0C5DJeRXKwCqo1ztfokEw8XCWzo?=
 =?us-ascii?Q?8ySuxPjqnmPpymqReBQ5sHFHBkbFFON0LyucJjj3xmG+dy4G78Nzfoh6iJ/E?=
 =?us-ascii?Q?WatRrDTlNfxIrbSMpI1MZ0ECssIzITQq76wOzY8FwtXe65uQSOFUyCAnk6MR?=
 =?us-ascii?Q?vDaooEVh6aRW3iWQVZ1sUNfG4tGSEVJr5PWxJUgsGYL6KmgIxZLrZGSod3GC?=
 =?us-ascii?Q?aS76c9JDUlyjON9jEkqVGj0ZVvkg2vXrLcpESJWe9ap3+94nmj+3J8B5ljHN?=
 =?us-ascii?Q?ck4jkhj7BEsJAGgR7XwupJYlP5rEOuNJ9w6zpmahX4wA5rbrncJKTOJQl6Dt?=
 =?us-ascii?Q?8sZqy0B/S9W1sFp4kOeCNJ+zn/rZYdcpiUq58vjZYFWRPLUMQIz/AHlLqZeV?=
 =?us-ascii?Q?7TpWr9/h7foqiii3d5Zv7sXjTeLBe3F87Xq4EgXS25r1ussoM+/KzXJli7zA?=
 =?us-ascii?Q?v4ofA3heDGxW1kHu0GkpUfcn9ECaFtR86jvYW27wtyI/P0+1kkVtmX4hZEcL?=
 =?us-ascii?Q?XBtHmaOE0mYwIu1IXErtKTWh3X/3DVcYJ1p++eol0dHVa14idk1/0xkcLuTD?=
 =?us-ascii?Q?JV0YEye0p5RWPZypbnHOzyMvviLgpYUkgGvNiCQkLL8POU+8wAZ6wS+Ljoj0?=
 =?us-ascii?Q?MiACYE/eEWjSIfXwSrSRwlDjs9ufCNixWXevxHjrU9uM1ahAMrzUEhUY/Dqp?=
 =?us-ascii?Q?ldYmufS3wbbXmAlGRd//Wxl61lodcpYXqRxCXg4VPdjTs4/xt1RLr2eUEKKF?=
 =?us-ascii?Q?rJ+04P+gWGNm1JqRCXplWTB3X19vG71ov4em7Z148KxY236bZqSNOReus4s4?=
 =?us-ascii?Q?o+9yiC2GBGMBPmlyqC6yBNd4u5/CGYAKl4blrLdEmvzXPMD5n0YQ0WqXSWQU?=
 =?us-ascii?Q?d0CXUpkObuoTiqe/M01pMsFxlJcLSS9b7FACurkJgi59VOinjK1fXZ8Twzpo?=
 =?us-ascii?Q?U+XdHF2Er52S9xXT3y6o1sUq+IqiLBFZV2mRmTYhg4sMWR9U7+lMlXrssSxV?=
 =?us-ascii?Q?jDeNMIh3uGr9qjYGreCH5eVRjCt9RQty98iC229xoB5q9KBxvFXMim+J4whQ?=
 =?us-ascii?Q?iq3Nl1xCWOoxIkevR6ghdHBebhVVLzfbVu0brBb098LbeuYARWoN6ZvVtT1g?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcae697-0587-4112-7649-08dd71ccceb6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:57:41.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S92r5Enz90IoiF3hTWbbhVYJRZ+5U8b6n0YNyllGnVpKquXwCv+5zr/13c9HA3WJta4JrLo/EuAPHxe12m/tzPWHMNTHLSkfTrbnPCWH1Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-Proofpoint-ORIG-GUID: 4Kfvw0jkJfs4DEFGSMdb4A5_yr-n7kjI
X-Authority-Analysis: v=2.4 cv=Tb2WtQQh c=1 sm=1 tr=0 ts=67ed0a19 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=Li1AiuEPAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8 a=LtURZ7VY5-JAUsOYMo8A:9 a=qGKPP_lnpMOaqR3bcYHU:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: 4Kfvw0jkJfs4DEFGSMdb4A5_yr-n7kjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=981 adultscore=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020063

From: Paulo Alcantara <pc@manguebit.com>

commit d328c09ee9f15ee5a26431f5aad7c9239fa85e62 upstream.

Skip SMB sessions that are being teared down
(e.g. @ses->ses_status == SES_EXITING) in cifs_debug_data_proc_show()
to avoid use-after-free in @ses.

This fixes the following GPF when reading from /proc/fs/cifs/DebugData
while mounting and umounting

  [ 816.251274] general protection fault, probably for non-canonical
  address 0x6b6b6b6b6b6b6d81: 0000 [#1] PREEMPT SMP NOPTI
  ...
  [  816.260138] Call Trace:
  [  816.260329]  <TASK>
  [  816.260499]  ? die_addr+0x36/0x90
  [  816.260762]  ? exc_general_protection+0x1b3/0x410
  [  816.261126]  ? asm_exc_general_protection+0x26/0x30
  [  816.261502]  ? cifs_debug_tcon+0xbd/0x240 [cifs]
  [  816.261878]  ? cifs_debug_tcon+0xab/0x240 [cifs]
  [  816.262249]  cifs_debug_data_proc_show+0x516/0xdb0 [cifs]
  [  816.262689]  ? seq_read_iter+0x379/0x470
  [  816.262995]  seq_read_iter+0x118/0x470
  [  816.263291]  proc_reg_read_iter+0x53/0x90
  [  816.263596]  ? srso_alias_return_thunk+0x5/0x7f
  [  816.263945]  vfs_read+0x201/0x350
  [  816.264211]  ksys_read+0x75/0x100
  [  816.264472]  do_syscall_64+0x3f/0x90
  [  816.264750]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [  816.265135] RIP: 0033:0x7fd5e669d381

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ This patch removed lock/unlock operation due to ses_lock is
not present in v5.15 and not ported yet. ses->status is protected
by a global lock, cifs_tcp_ses_lock, in v5.15. ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified build test.
---
 fs/cifs/cifs_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index e7501533c2ec..c90f51c12fb0 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -380,6 +380,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 		list_for_each(tmp2, &server->smb_ses_list) {
 			ses = list_entry(tmp2, struct cifs_ses,
 					 smb_ses_list);
+			if (ses->status == CifsExiting)
+				continue;
 			i++;
 			if ((ses->serverDomain == NULL) ||
 				(ses->serverOS == NULL) ||
-- 
2.43.0


