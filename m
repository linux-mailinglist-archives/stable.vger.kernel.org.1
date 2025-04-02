Return-Path: <stable+bounces-127405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25BA78B9D
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 11:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2158716FD41
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27D235BF1;
	Wed,  2 Apr 2025 09:58:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029842356B5
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587893; cv=fail; b=Guc0UwzLMvahzjMnV4d1Ssy1rRTVPhAi1ZIZwilrzzYnXquepESYQgGYporkpm8gTT3xwvO9BoNBypeDkxmgWzFWiR2MjcPUZWUmQ/c3YxFqEsSgD0NcuLaG5AAu5re+4/dtER0wmXXpiQPer6YPQLpZrfEEDR0vrE8XOpG5JA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587893; c=relaxed/simple;
	bh=HXhS6HurpW1irZyA9k1ex9gcXwewGBcuAsU4r54c+D0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=snlcts/PbGkRnMOQ3sOgdU5+UUoegpz3F9XUUzy0EdRQeFnC5//Ere4LjI6sM3Cz0MW6iFSZExd6u1lvAYxBshtbHBS9SKPlNuKo2leJoApZNmXF25qZ82XmAqZgiBLaWPH8xZJgJlQP5dc1j1jmw/7I2pliL1W7W3eNm+LUcxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5323e31Q028041;
	Wed, 2 Apr 2025 09:58:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtd4rmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 09:58:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMrPKrZkJkB2G6rTKlAw9p0sv7RA8e2PTBIMeKORvWh8Iu+RAQCpC0YW/KC3pcjjDVz/pGcaFGViYRuS7FjPhCRbciBQ701P4bI1J85IClAXlTs8ARH8OcPm9Jm34OVQXVi2vBafYevz2udaQ6cDVRBze7+g61rqlrE1qas79lwZVrIUI7h7iH08k9gOF3NfapWqqjly3skmq1cQCJHcxXdtSuBkUOfcMF59GfvZm7KDlAd0Hv8dcnmKP9QJrDqVUB6CKP+59wWgSevwRk2ty4Jy3GNlxnHnfUiTh/qS+k/Y4Q5sWKoRtmRIKAHkQ936QGd9ROztaumizyk7CfmfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tBi0zm2q1eCqYM/wDIBaSfHnXJyLJxVcdoEmBqiL4o=;
 b=aSwfvlhPQRnlWYC36m3cZBwDa+wrUDgQK60PCe2r2TAS/Qq3p91pS5/nCo7N3vPBofptryFjw8KOOac0ITpjdu/HNSEMt+fJvZgTyIdi6XnEXvrRXN175Sc75O5fASxxJ9jX2Cw4fD4YKvNb70uzDoH2f/PRpwKUtI9zmaaZdc4ccJ6hYP2/HowT6W9m9rRWTy258l5HY7o0PbLlcuxWGIGGYuK5qRlIgJCYAZQaEjShEQLSC66eRgxiZrzbyPVena+ekBowwk/1Hl3+1hvqhzwjBbTPg+vvdDJLAMuzfNB/DOMXbGMD06h8S1M1wO/P3I6zb55lo+6xKxTf7Ru2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:57:59 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 09:57:59 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: pc@manguebit.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.10.y] smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
Date: Wed,  2 Apr 2025 17:57:50 +0800
Message-Id: <20250402095750.1813300-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0075.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::13) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfecf18-8a86-46eb-c8da-08dd71ccd9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqXQjFVNzvVs/d3R6EN9YaPgBKNLsB7lmbn+nQLXpqtEokUfaTHCDktRmTMH?=
 =?us-ascii?Q?bbaqsUZXdcO4zEeWy2Gpzzv8cZNvCE8nKWtBKWUIJJaqet8sMXzzbzYzJZXD?=
 =?us-ascii?Q?04RJzCgbcqzYbaIcMn4dL4DRtAd5sUpGQfq7XGSg3B8fx/Q65WCMDS5UEdvy?=
 =?us-ascii?Q?Ou6JDOJpTOsZvSexhfSbqCFM1xK0t54751kkswkPQkW9c+Z8zK9y9kKlB+Rf?=
 =?us-ascii?Q?VzWzLMrXd1iB5RSFmNQdpEaNex732WYQr2GCYHR41jPL1i/orbEJEjxR16VV?=
 =?us-ascii?Q?Lpg88OwzLHiBd/sKAxoDinyKAGiyuSivE2ZeBrCavlagp1RpWcEf6IpsxwTG?=
 =?us-ascii?Q?TCOI1jo8m3xIm8J6uyR5QU5s+rzBJwXQmdVXiEBQYEucGpV6o8q4L7Di+D7r?=
 =?us-ascii?Q?cnxBO4uvByP3iaC5YIxBTS2bDwFLVbx8mHzz/bzEcwbG+NEW9iND7A6AEtmS?=
 =?us-ascii?Q?h79d7LJhMNIC+A6nVemF34ISwP/CFXv6GwKBtLpxx1b/AcA8xF/eypDRGq0O?=
 =?us-ascii?Q?Z7WUicFd1fuIARCvd4Wh9SQ498o2o3cQFa6wfu2/f7hCg96D/ayrzOOT2W2g?=
 =?us-ascii?Q?6HMXk1vqYuff3Ge4NhupQUjNrKdQEgwWtzM8DQT3KjmnSNR/5Z9LrHHNspdS?=
 =?us-ascii?Q?qChGjwS56bokgkjxi+Wb/2S/oNG9PxMjxa+JMzzanP5UbmqX2yA/Sol3TRNa?=
 =?us-ascii?Q?ukT1l4agx9h0nrwG4wYFFuACpgBHTC83NuV2se8b6kwbzsKYGsfM/FvppZ2R?=
 =?us-ascii?Q?j5xp7zKTXZx1R9tPe4ygHYxQ0Dwqf+0OGn5OtcRd9/LtOysxVtDzUJzXXoYg?=
 =?us-ascii?Q?W+/0Ts/zYXQAcNWTdZaiXnskEnpHbuMXB6DT5sncWTjFtqbrYvo05mFbodun?=
 =?us-ascii?Q?l7uIhmd9Z+uGoO33p3Ax1sLCDppiJthHBO4Y2/GJdkezdB5NJb1nKbUa15TY?=
 =?us-ascii?Q?K2bsNZse2asMfcjeQCy5oIZERvOoqhTjr1iQmrA1A4qFPgnGSilbh1cwb7Aj?=
 =?us-ascii?Q?d2Ev0NpeYXHsotorl39MymXMkQeuntuVd7EGlSCYHqbJXArxTlRa2i0a4/yu?=
 =?us-ascii?Q?WZolQ2YFRqc53WUGnB9afJPZm+CFM5+sNlpyhGVTVAallnqfkNHnxotjH4jK?=
 =?us-ascii?Q?7Kj6nyGofk31zLbkSvxiAEPIjXTkgv58VIUJlKasqIM4LGm2rkluu/FdOP5Q?=
 =?us-ascii?Q?rxHAYDlPxq4W2r/uR6XQVNwV88Vccl15nOfZZ4S4bKctuYS81oJqj7kgXQs8?=
 =?us-ascii?Q?jz5fi2Tl5ATtoFWTCwl/VoHJ8wJYK18scgRphKny6+tj7+CbOEumzxSFS+fW?=
 =?us-ascii?Q?A2/4l43Y22sx3g0ajmTlYJXiNabN1luIDmpfzzUpiNIz8H5ZlREVgP7906hz?=
 =?us-ascii?Q?o1bpvWcZAi9ZTmWTAdrqzwSQqREvoMPbIH8hNzciJygsDyaw6vo2jR3e2c2y?=
 =?us-ascii?Q?MzAw/ZuLEVIOg1cYgErUa1CXCBHxdb00?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyoCVcrPuePw6NY7fluySbbTKTizMtqPvmCtTN9OxaMasBcCOEfOtPQLRH+K?=
 =?us-ascii?Q?vlWjxyyJwXGLbPt6fpbU4s6evw8xFsCH76nwKjyOw6fb3AK4yzbCGLe40KFx?=
 =?us-ascii?Q?swQJsP+GP5uhARxnp3/zg1q+qBaKkRCdZ9uTHT9ahC4uHmzhVY09KRPjB/54?=
 =?us-ascii?Q?UvU7bnTnmMil4l7dg6KWvBZoZxDIpUX+0NaiSOD+WtCCOF5F82jKMQM+W47P?=
 =?us-ascii?Q?x2O583XGoo2j6YBafBFSQ2OC7WmI150a27XCvi8NlvXjxRcWEu4L86swzLYi?=
 =?us-ascii?Q?F2LTcCLxxG4ojet/iP2BFaHWQEhDdhe1ve2qttzgX/w3wRzpatPLMqoIA3mh?=
 =?us-ascii?Q?iZvdgYqboq5mz7UW5O/pKbLRj1csxYaiP8NRvXwYnFKXNI4U0uSMetJtMW67?=
 =?us-ascii?Q?KyLdW+avKBLz4dTIBnFOMsApQ3aA+lG1++4GyR+J4NGaOLng9W4rpBfZ4WXH?=
 =?us-ascii?Q?x8jZJ7SujvSYoNMvlF0uAzSilmyig403S5KSAOIJGtfD4FtnoX6usAPHY0x3?=
 =?us-ascii?Q?/XBFZy+BwoaIlxEO810SEg6MfvxeEEQZqq2ENPQDCpEaXMiWg3piLLFZvrM9?=
 =?us-ascii?Q?6JbWw3Oa9IuFkrBs0lgE2HbQQZNIlStJIM/PiMnc5Ty9YwE6M4s6wge0U4ZZ?=
 =?us-ascii?Q?UEx4ccsGS5VLZ2A/pK8LRqo+r161tPpiXyz0j+zBysxFPMZzQO7t4qDFBH9J?=
 =?us-ascii?Q?HHj80J0XytDrP+Ift0JfV+Faj1sHsAIQzLFJBqX97uvknlqbruyyGTfz29ne?=
 =?us-ascii?Q?7oKAVdfBAN1JAZE47yIPKedMw5JwSD9SVTcA7f2qRBi3WLtTuml57Nf74nyN?=
 =?us-ascii?Q?Lh+iRijkbwR3191Op5XEUAfka8EX0AnzjZoU+GSxkqMJUBL7hdrm4FGBlBzU?=
 =?us-ascii?Q?/yBWp78VFSEuH/dg3mFs0m2OpZQU44xeZo7R8flieqolCpujLPBG5oyBm0s7?=
 =?us-ascii?Q?X4IvaKn6bhIA5rmJFHO6ZEp9xow1+5owUFQ38I+p0cc/0HAB+sIyVEWQOM1h?=
 =?us-ascii?Q?gto7lO3+Xg9CSiLGuL+QSDQm1nqSpvKOFSx1XZJGNh2U6tvFEH5jHyXJRpfw?=
 =?us-ascii?Q?DTWMWzH5+WnagIHR/0F4PJYIG3DlOwfi3A9Gjk+07+8SxD8U3YWg1tP3m1Ox?=
 =?us-ascii?Q?UH2PIR1hDm1je/GUi3XGpWxtGwO4WgqXYqeTr9UshVttQVvJUrb8DhtO/mCb?=
 =?us-ascii?Q?Evt5adoac1YYfu6X1dMjmEeRKnMYIpe7feE24nZwCiSvJ0sPJXnAtFxrNf+E?=
 =?us-ascii?Q?el2pA/8AWRt6lflRWCfMfGJK35fc7AmTeEtvysBAZEBS10l6TQjeceWEN6qX?=
 =?us-ascii?Q?xyT4uStLN6chNVd1/WaUV7SZRVpALFGL0uWBDKhkEJjov/5rU0lMFrNQfon4?=
 =?us-ascii?Q?uxLCpuy9z3erbxPgyiUca4pAQL6evrWcnLiP/ucprxwoY8QFIigZ9lrEcjbD?=
 =?us-ascii?Q?wfrfPggQJPRNR6GasPayrKUso7szm3mmjE9LhNfXdwd2iPzvxVN9cCqDG2C/?=
 =?us-ascii?Q?OTupNsYF0do9CRKrVrq5xwfVz2TieX2HCZ5bNnQww62TPXeRL8+UVEdHKdCm?=
 =?us-ascii?Q?4twjHaDEbjnCJWKosA89zqu7y8st+STg2D3NcG9z7RKWhEaZ58ZHNrEx3Qsi?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfecf18-8a86-46eb-c8da-08dd71ccd9ae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:57:59.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L106Ji6HEEwFkCa0N9L0d5GYid6mmIcRJgjiuY4tjpXAOhJ44WWUCwiCFkehZpD9hw+oq4odad6HL6TSe25oabytzVYfuDgos/H2oqx8DuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-Proofpoint-GUID: ZJyCUS7n3IYZGcyjyACza1CPyQ_lceF9
X-Proofpoint-ORIG-GUID: ZJyCUS7n3IYZGcyjyACza1CPyQ_lceF9
X-Authority-Analysis: v=2.4 cv=famty1QF c=1 sm=1 tr=0 ts=67ed0a29 cx=c_pps a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=Li1AiuEPAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8 a=LtURZ7VY5-JAUsOYMo8A:9 a=qGKPP_lnpMOaqR3bcYHU:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxlogscore=981 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
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
not present in v5.10 and not ported yet. ses->status is protected
by a global lock, cifs_tcp_ses_lock, in v5.10. ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 fs/cifs/cifs_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 53588d7517b4..5ec4788341c2 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -356,6 +356,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 		list_for_each(tmp2, &server->smb_ses_list) {
 			ses = list_entry(tmp2, struct cifs_ses,
 					 smb_ses_list);
+			if (ses->status == CifsExiting)
+				continue;
 			if ((ses->serverDomain == NULL) ||
 				(ses->serverOS == NULL) ||
 				(ses->serverNOS == NULL)) {
-- 
2.43.0


