Return-Path: <stable+bounces-116663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AAAA3935D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 07:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7688F3B0117
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 06:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975C1B3920;
	Tue, 18 Feb 2025 06:19:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5462753FC
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739859543; cv=fail; b=EzdKm3c9UVnNXi22cjSzA+jSsPeTwkPsbF/nQ40RsBuFV+nldIkbzj59zCIBjI9nvbHlrZ9wYbnWwDthWv9L/esSbYdMeQKDugpKm4VEnZaPGXhLuQKVI/KhrwlLa1Uuc1IKaSFUObeBh9uePVNIKTq2sPf0sWgtnMGpYrSvxUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739859543; c=relaxed/simple;
	bh=PeJzMNRSoRM6w3IT3Efc5wJbjkV6UmgYa5Y5tdzPCjM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ebqZvCIew4C4aoRl/Sut6n7HMXPvjF15v8wmOf/4SKCH+MHG7+DFNJWCm8gGCJJew1XommIhc+fNd4MtL0ax4GMxpO5v88wA4Fc1S+uFKwK1Ex0jydM1ERwbR5luSp+us4/BTxHdU3YIjgc9Q7ZL3fxIWWCKaHRnwuuNc2Ent8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I6IPmx020071;
	Tue, 18 Feb 2025 06:18:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44thw92npn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 06:18:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1YiyFeIq+2eylqd42TyowSK6fXC8POiuiT56iZ9jlykSPwIOrFB3vv8LZZs+Kk82WzQZEbi4vJomOIAgsMXUdVKRy0tOhvxKU3Av2H3PcH1PKAHborFijfqR+8Yojaa1n71ohsH+w9CYBLINwO/RLiaGUJM0rB3f8vlkxa2GHGdQQ8mpQ5zLQHhrWos4Xwyzg4+vSi0Lywtckvyhj16sOkxQBN9qd4kjgIDQT0eJDkm6wEVWZihX9N6HNXmNTnlnyOasbJFyqFdHCU0nGGsxTAvSZKe89u2s8gUVCrocNnGKGRtSa0ln7jtoRXHrrAXa9wypCfBKjNj5aRwEibEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHPstn7ET5AQzgQ60VYpza22tmljw0KAvUjg5AsYfZI=;
 b=NvlkMQG7tuZZ/EtXU9/NEYUNcegEwOH9e4Jy4VPB6xrY43fCtbNOshvv7Q/c8nlRexHtqknVG/6QFWL995G5UTx6q7pV71xthezJUWOeNN10rtvPVduz30a1I5VagjGHKZIOfOSuU41W/pzl/6M5YuoA1XkOIEdANpEe98fjF+1x//IQJw6o1s/LZnOmj25Fb40kjObhyAnjQFMyjbGhcIl+3afgdBk0UDDFwr5eorTx/qy1lJU90RWnO9Wj9Cl5c8uSwFpgIl/vsP0fazmlTTuYWAKwuAeeBhjByym5sr+567J9SjbEuCw2vCfuRQuoAR7z25kJnNiD2+v4pJr7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by LV8PR11MB8535.namprd11.prod.outlook.com (2603:10b6:408:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 06:18:30 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 06:18:30 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: chiahsuan.chung@amd.com, Rodrigo.Siqueira@amd.com, alex.hung@amd.com,
        roman.li@amd.com, aurabindo.pillai@amd.com, harry.wentland@amd.com,
        hamza.mahfooz@amd.com, srinivasan.shanmugam@amd.com,
        alexander.deucher@amd.com, stable@vger.kernel.org
Cc: zhe.he@windriver.com, gregkh@linuxfoundation.org
Subject: [PATCH 6.6.y] drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer
Date: Tue, 18 Feb 2025 14:18:18 +0800
Message-Id: <20250218061818.3002289-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:1::19) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|LV8PR11MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0ee36e-0ad7-4721-8deb-08dd4fe41049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6rdYAUpBX4veMhm4aDJdEgam8VQ79gFJAcsJJ+RTrNy7x6HarecgzuafbfNS?=
 =?us-ascii?Q?viZuP+hcPXhvYYm8URZYj98BlDRluJfRtwYAr4JvJmkqs7bbHumqWk/dEGMP?=
 =?us-ascii?Q?CobwMeXEnmkIbb4o3lKrsHdLvEqkWDJgfZp8DbT4pzxz2m2rBwI5WZ5mmrFd?=
 =?us-ascii?Q?DV8XKGQSSGpMAy9Oe8hmzXuK7n6pkVh1iIZIgAXUPYI5jAC1tiXwQu19rf8q?=
 =?us-ascii?Q?n0C17OsDHOx3O4DzyzFX/pTWE+W9/ruZ9EEIjav+lIZx7iFRz8Lz+/Bf93hN?=
 =?us-ascii?Q?sypiwYiKjhmZpoPrAK60wfbZiGIaRsjLWHqN7XhqVxHU6ovp5ZeXMoDUq+1x?=
 =?us-ascii?Q?T+LAT1gqNWaWtAPPtjjPNPfBiA90TTsqEyyF+xoEjAhZWI5cpQVK0kHMcgL6?=
 =?us-ascii?Q?0j5MaWR/xmC2RgfLHby8ISH/MWl3B9+lphvOin1yQOICBRKeuOm8mnU7HNUH?=
 =?us-ascii?Q?qnKylQfHG6TWIGBImTCE7S9+l4oepZib7HWXbAHjAdBruQh8CqvxvslsgYBG?=
 =?us-ascii?Q?hukwJyOlMGWUd7dD2NfP8EvAq2fiq5bFG3tpFLL6tBdxcM9GSMdAwEXzos7c?=
 =?us-ascii?Q?5hVvLXPo5/NJaBR0PV33u0h6QjjGnFY6WgcXoP6Z4dNJSURZIFuNvS90/t0a?=
 =?us-ascii?Q?9uf2lGep0nyiqgZxax+AcKzwgLfsE/1Qz9qTfdm2S8snc8byp5aVxKdJDOHc?=
 =?us-ascii?Q?Pjb/xdT4WewPwHrjhKme101Nr64KTSmyJopMzhO63z84EwSMg3T63VHkBX/b?=
 =?us-ascii?Q?96LLS8owHiIcZzlQ9+nlEyFWbdk1z/alflvBdY5mNf6ZHEOhs34SYc02dYu3?=
 =?us-ascii?Q?YfJLxyaVIwCC/9+5CW+fxj9sG8ImyiLeE8C4JyVesgPxEjOTWWl5siNVUJDG?=
 =?us-ascii?Q?k2D5aeFNlQaZ8pHZ50bQk61MBi8zyF6YQWcUdbQEY/n89V83N3fheEI3ZcGZ?=
 =?us-ascii?Q?Dkbk1VOGybImC0ZZSJzF/7nFfvuDtcK2KXqkhe1EdHEinJfsjBkxHmDXliug?=
 =?us-ascii?Q?3mJGEF6863+exw0Pua8U6HHV9Cr+WHrv+uQcUKJVomqgs92KQGm0gmPTSJGl?=
 =?us-ascii?Q?nnFILd5yCVT+g0fKQ/YuOiIDYxu+z9D7RW99YTHHODp6C0cO82oyN3b7HVck?=
 =?us-ascii?Q?B6G+GIljQddBgGwm1Z4KeQnlx7pz6vHeh8wF+Gx2T0g7aXt0B5bnoUQDOguh?=
 =?us-ascii?Q?BFKUi18h3qp4gKgnLdM0kc7ilzDHyfCmkFaExMAwfDgOr7hjbyQzS6ZOu1lf?=
 =?us-ascii?Q?3MWCDKKUuSFhNpuviUJbOLVjz5QK3lrEq/hPuTMN4kNP+K6kJHgBsqiGMr+r?=
 =?us-ascii?Q?ZapXDdpWmEvza+4S4cKRwP2VIbj393OzM8a0hqf1QPbz+MGl/hq4b9tFhy9G?=
 =?us-ascii?Q?V4V+Kin8Y51v3olp2yfX9DxcTPSwYjncpZK2tpIH4rK4DqnVLcHa45bYjuWL?=
 =?us-ascii?Q?kLxUm+DkG3av6VhmzbriPyVBoAS4aRHd5WWau21lE38vgjPuw2Iy4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqRwDS7gHgUvcowH0ddoxgpAA1hPZnLCIm+4iXoa4AilzC78onFFkZtIC/k6?=
 =?us-ascii?Q?mggtDdVyu8OjEAthHkgP/iqivaNQjwHGfUhK1vB2AccfCx3HpdXb1qDZogoq?=
 =?us-ascii?Q?aHDC9fE8w/UrxtNosT15nRKpQVIiZhTrgmW/SiqEFmgEku7U+6IQKHTst3UA?=
 =?us-ascii?Q?bW8+vGZSw4+CT/59mnIeLICGokA0BLUkXNOkKkhfu5ZgGoWQ59iXuJIkBEKh?=
 =?us-ascii?Q?z90RPLpPWzB/goqXnsxTDoj/JTvoOfA9RgWLh4SX58NctTFB0NsKJkHnYE6s?=
 =?us-ascii?Q?evJ/2M/ywPh38/U0FnjQdsVW+CZbBlGb24vd35G9DE1pc3DSfxQJJUzC+Ogg?=
 =?us-ascii?Q?NfzclzN5mXqhqf6zFjim5TfVB8ByMWJ88M287SELAtTmedRnX2VRM6x96fX+?=
 =?us-ascii?Q?c/CZBa4OvzGLBQoYBlZYjO+H8czK7crnPHqelW6207vZnY0HXlm+ldtcR4gH?=
 =?us-ascii?Q?At1s36x/q+8Px4W2bSl92QtISjcBTtLTbR1Ztxqzvk8gK50LhKN+GlZSy7d7?=
 =?us-ascii?Q?NGWuZLcJj31vS5ZVOTfy5g2x04UMmv+V376IxkRMWFMocfVH6K0e3MUaMIWu?=
 =?us-ascii?Q?dQZK5ihAdKNROkWMbbuqf5BX35mYOY4s7w6xVF8zSsaNMKXniKbysMVcVMY6?=
 =?us-ascii?Q?sKYAS+F1FyFCYFvrJCTtqS5UvWwJkUtbtWjoQgtFv2VLcp9Hoyav40R0Q/8c?=
 =?us-ascii?Q?T9PApr+qM3IPHFDLV1NoY56j0xxe83hSTZJsxvccBHm8Zf3aPpPW4+u4AA5j?=
 =?us-ascii?Q?O/sYTVcrDeR7+eHjYJ4G4ax2X69+8simyFnH5lsXW99E1dDuNttPi+hg9SjM?=
 =?us-ascii?Q?1lqP+5QmfYFR5IMFW9AOXCLzabs2IjQ3QBaPBZJEWq3w5EG7MwUT/1ufMicG?=
 =?us-ascii?Q?7dEjq5PvpwOuRLpmXnrcdw5FyJUevpdbF/7JluT/CN2+gR5b+atqIJUGe7pF?=
 =?us-ascii?Q?5edktATAi+k91oXGlJ/oZBQVGu5sHyPAp4r/qJ+3PWHtDvP2C5aFUz83mnjF?=
 =?us-ascii?Q?fZAGLHQ9N5r8gjFNghB2YTi0U/9SK86etbgEtik1+7C1Xff4eDzqbFQvZta/?=
 =?us-ascii?Q?y5cUyuN8eLb+cP8YwqbP3czBSDze/dBG8HPPk1V1518sl4kSY2fyJTmXDNXe?=
 =?us-ascii?Q?RrTSDkhZiGzNMvbNM1IPFjGsWkAiM0BF727g3xFhE+cmfbvhkWM4kMaKXQoU?=
 =?us-ascii?Q?/6XCGdfrH+LNHe0RoG37LEW0kcRatEoerzeRg3y3FWYSDunyoRAG3+bIwrSQ?=
 =?us-ascii?Q?wV8vsdzEtFNCoiz4YD4WMuwcdbdbwf2brF+Gsqsn55hsKKzwSGnpgfz+/CUF?=
 =?us-ascii?Q?aDGnzJBrApQ2FJASh2ODPB3va2lzOb7s6ZH+Qos+xkSHtG1HluwY69FXot0c?=
 =?us-ascii?Q?209rrGzrlL0xcJCG8cNNXehIJtNlmwg51zMJCbcmYHT6jeENuQwJJi+efZqz?=
 =?us-ascii?Q?opjrLwojVObexp15Xa2S3Wjrj+Iqt17M/IXpmURao73+U+JLdlXx4l7BygLk?=
 =?us-ascii?Q?fW7ROZTVYcPVjKpp4Xnq/3XZjZKxtbfwPKn0wWkXjyPzYVf87IivoNlEGuYy?=
 =?us-ascii?Q?AlVPFkak+Z+nGUDg2hve5C2Y5A9b+t8n+XSO3oNol6UDWU2Mp02dCokS+PNS?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0ee36e-0ad7-4721-8deb-08dd4fe41049
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 06:18:30.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBhgle2UAaNQkUYZVjKuVjcxx0Fn6cPcB12BQhhA+fwORDDkviPFMb0eOku8SDVhbVxwEpp4mYWjjB3oyJTOa4o86TFi8tanushNpaNqn2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-Authority-Analysis: v=2.4 cv=CZzy5Krl c=1 sm=1 tr=0 ts=67b4264b cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=c_TfHYqoQU2dlLI0moYA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: I7NQYIQ9sdrjYzhMQ0Sx5DvrTuILUkVR
X-Proofpoint-ORIG-GUID: I7NQYIQ9sdrjYzhMQ0Sx5DvrTuILUkVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=907
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502180046

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit f22f4754aaa47d8c59f166ba3042182859e5dff7 ]

This commit addresses a potential null pointer dereference issue in the
`dcn201_acquire_free_pipe_for_layer` function. The issue could occur
when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[dcn201 was moved from drivers/gpu/drm/amd/display/dc to
drivers/gpu/drm/amd/display/dc/resource since
8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
The path is changed accordingly to apply the patch on 6.6.y.]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test only due to we don't have DCN201 device.
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 2dc4d2c1410b..8efe3f32a0e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -1002,8 +1002,10 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
 	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	if (!idle_pipe)
 		return NULL;
-- 
2.25.1


