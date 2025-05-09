Return-Path: <stable+bounces-142974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47CAB0A8F
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FD1BA3905
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651B26A1DE;
	Fri,  9 May 2025 06:28:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E26A1D9
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772107; cv=fail; b=gR0wbMJwJoMQT/niWLV2bdw/R/igGnA5IqX0OXrnnfRe06S46HeB/rFItLEkRT/Dxp+dxk3YGUnjffR6d/rA0QLzznf/VHV22nGf26dNMqY4pCnHKzLQRJFCqQhDKrlqbSnKCf5yw8FJO1puWtaqF3HJEuUlt2Hd5NQ6khdg3iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772107; c=relaxed/simple;
	bh=tb931ScOo8GO+shIA/Zd+LE3V12I7jwEOh8jD8ECmAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ohhYw3WqsGLOvAKPgtJ3mNSMTGytzgH3HH5Fx0ixCs5YNBlFVELNBmMDRUJhApEJb8xZRNuqsg14s2SRWELm421Q31IqyVcIY6mhQIAKZwhFg9HRp/WIWLHJBCUXoELEQm/dGm/5yaKXgE2Y+cz5Ske525EzVT+Zq/AJK7iVleI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494bbWs013638;
	Fri, 9 May 2025 06:28:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430p7a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:28:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsyLRqYo1sYEgaHI/U2YglHNwY0QC1Rz3TK9QMVJg+39gwRur6c4PvsdcQ1XWPrAOyuyvbssgoXqzH1Gebl6Vg+9zQmJ/c57AIo08tN1aON9Yo1MIEJVaUPQv6dkWX4vyQ7lSyl/LUimQoIpovsmnLwdgOXUICpGk4mQHtPFu6z6WneyCw7FVbh+Po1L9BxQYiX52oyIYdQPoSlLZQR5wyVuz+VTGnfIwxOFhWeacfZtJO7JMXGcWlqmV/9OVsqKGKUnSc2YPkVMiwuaWL4McKEEEVEUP5VMeLT7IV/X1anujeritOwPY9MZolZP7KbZZGG2dtx/5kHU255Umfx7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKVw0OrTWSxMbQHU5usgT1oiwWVRN9SYGflwooBfx7I=;
 b=H+ZlnuLPQJazBqRTn0hvL6TVBv8xcRw4h9K5D+9lHaq6eTXnHRuZw8uFYWWdPzg1Rk6mKrZO9qu6SzmVCvg6FDy0wAgatQvTCNOH5v6KAhy9D8lnNeX6BViqEmtqGuQofi5w924N/eFtB3yDRk/8bZ2tHB5u6jsvWykf6KNrIbLlvj0LJqehPXKBUVswq3w2bYKX82FVG13pecpImS6mfbkPVzWEIWG8TKWOb0bRd2HM6gcnRQQneUfwqiOregGG/5jxGcCh6Y1+7LfXBw0N9Q3A8SUBBzTu1AsRktUwBkar2Cf4AC050fDKOPKjRahOMiWPJny9GAL2AkGEQPZisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 06:28:18 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 06:28:18 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, dan.carpenter@linaro.org,
        bin.lan.cn@windriver.com
Subject: [PATCH 5.15.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Fri,  9 May 2025 14:28:01 +0800
Message-Id: <20250509062802.481959-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 173ba90e-d712-4ad0-4d67-08dd8ec2af97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+1ifk/S88CSJ3ATSnG1jZ+4rtb+SMhNJqg+tGV0cMhZzBieAL2nwWbrArp9W?=
 =?us-ascii?Q?pxUWNDRhQAHi3RmPjEK1vB7/j+Q23HVguxPgTUIfhuRiHXRasuEgdvbDigUK?=
 =?us-ascii?Q?3hPvVbUUJKKM5nh2Umk3vzO9sS+MD2dKFmK7Gcagg/dXgvIGQ/sS9RROVOcu?=
 =?us-ascii?Q?ZGW+2OARc4R2JQzQVR5rpV00glW/Dbb4CLuFAZkOXAfVQgDL65SSHAC1+5+H?=
 =?us-ascii?Q?ZA57mHrykm5bypN5uIoOJC6cKlz0N26e8T2xLcSyz7EIGIFVvLnjwhR78bnI?=
 =?us-ascii?Q?1Yvetxh5tTGP3ee34i35tpvNrTHrnXkZkew8bYqoCHET6stlJAxd2cETVtWV?=
 =?us-ascii?Q?i2Dx4mElrO/J4qLfj2t+VQxZIb6lHE8+oGozvSHdjlZNojCaf1zoCwdgj1vK?=
 =?us-ascii?Q?0NmRms0Ia/DKQcyfxJDTM9ONiKkeZs+yOD8D/PC4D8GFhNKyFNRj2MWu8Yie?=
 =?us-ascii?Q?n5qN3+BL6vGPi1qjnfDuH+d3pJ8BT951pyx42GMJweB329O0181K6VBNMMrQ?=
 =?us-ascii?Q?ozR+PkwjU6kM3XgN3ulRpQwWUyBNsX7xbE7CXQ2vnKKah7wZsfUPyEA4bA8v?=
 =?us-ascii?Q?6iFk2GEGgLKgZlsln0wTdWshbmszYPlcRb0Kl25jR0HlOCfegfu9lLwGPkFq?=
 =?us-ascii?Q?s5TG+skKawtk1XMGppGlGR7jaVuUaMqv9QmY3ktXzB5vRE6acYlrsUOeP4xu?=
 =?us-ascii?Q?/xtOHFyZV5TEwsoKFEOT7EpUx5aoBIzVnD2D9tCEEYILGW640at8+75azM6U?=
 =?us-ascii?Q?IW4X8BJWYfTEwQSBPMjH0bqy/gT7cURnai3pVWvA+2BJ6kmIVHkodjFY3uPB?=
 =?us-ascii?Q?SekDmeN7Il3EocaErqXyFGU3C7GuAnrjGHC2fl6LwW0OCYJyr/AojA9rDCEG?=
 =?us-ascii?Q?Tv+Hn3UnAF/ltE1InrHVP1cGauoZ2kCOobrGk+ieaBBm2relMUVa2QuCWuT2?=
 =?us-ascii?Q?BL29ihaqpMYg93f56lHAWtjTXCFQAozp8uev8YCy23PRM5wopr+4OtIKHvIt?=
 =?us-ascii?Q?u7/UpSUaDjrEXxlb37xmsV3VF9hDXf3L+KLJVERLJwOwup5b3UvG8J2oHz9R?=
 =?us-ascii?Q?nHzIslidTA5kZq9SLJtNux8eaZ16cFivn7R7sA+HGTE5ibhpKBv+qCWO+qhh?=
 =?us-ascii?Q?cTsQJ5zQZvIo+kHgYhLdAi2X25Ijhb58DJpgh0zKrlMKo9wRiWLW4CSlTway?=
 =?us-ascii?Q?T9b6VAFmhTOW0OPn2ClM5uIuUxucfkLToljqzCCmfx5dLypd1hinG7n1UykE?=
 =?us-ascii?Q?FNxAFVK3YICWlJmGAqiyd1iwX8C71nU7uVpv7dhmPqzYxrM/g1ocMIWPK+0U?=
 =?us-ascii?Q?HvVS0El+qlPW/Ms7TbVmhaIARVET4GWXtP57LHSJV2e76irxrenawQv8a+lS?=
 =?us-ascii?Q?4GsVViYliPaHEdvmFJJJUZtzckgbmvpHJ+2EmKhMLSeaLwozj5O7NzUueOlC?=
 =?us-ascii?Q?21bO5P4Mh0PTMcrbdQMIt/yP1/HhCXiu8pMaWU1C7P8tPSp8+JRF7W9GK7hE?=
 =?us-ascii?Q?fYOIVX3/lZLxvNY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fysEtrTczLQVUzjaI8kXZJZnsAs05YymoRbQFhFY3bXu6phUMptrZbx5zoCP?=
 =?us-ascii?Q?dAYPFTYUUm5TCMYVzuJNU9hOzNV67lP73E1Q0AaCJjjCEB62uK/IO3PIR3+d?=
 =?us-ascii?Q?AjH/awIRl/iZw5rQ22cB6POwQC6R3ziKyIPVQ3R+beIU7xk7FkBzGJwSSxFT?=
 =?us-ascii?Q?DjuFtHBGrzDto7CM+jWJIgFyLXWltGR8M5Xb/KB5qdpOI3fuJo8CFK3sQjou?=
 =?us-ascii?Q?gAGJrxBzyyLBpwtfuuHJcKd4QbfT7lvWC19exxyAaTECS1BE4CVR16wEWang?=
 =?us-ascii?Q?dQKJR8nrDaGcQtMxHI1rzwA5iVkQ3yIOBrP5Z3BnUhVhYrJlWPjYZue4/mum?=
 =?us-ascii?Q?m0vy+jdzXVwbV+AudX/tbobMnozJthmk5S7wYyjGd/2tAJcMAvWOi+9gdWhZ?=
 =?us-ascii?Q?0Ogmh3rDPeuFnZlbwNVugZc3bDI+apFmLYms8OQHPg8Ld4nDTY91mo64j5zc?=
 =?us-ascii?Q?jG3VzWxFhTmUkGWg+1ZLf1lwNe1eTJwif6/ZVBSKAwPvZNAa0xXmMlCdv7bu?=
 =?us-ascii?Q?93Fesh9deILCVl6DLY4GlUFtsfi51HYUB/6JHdOQqxXtMP0wJFmhZgDfIRYd?=
 =?us-ascii?Q?KRgXqZbXhhJBy8OgmivvCa/bVE476vGYsh4ihuJiuyi9oxK5W3WdWlgPN2PA?=
 =?us-ascii?Q?Nv1Cq9Nmbio1JjxVJzVDDTRbbwpTBxMKdd693ADzVeyzAlSFqG/BChE1g0i0?=
 =?us-ascii?Q?pHfBuqKFlug9kaPb6FyLwhZn8mBC6ySjxVAWoxuNDWhq4oaphfqqyxR8g6tX?=
 =?us-ascii?Q?BwrVD5yAAL0A36NhkZyjUNlXqkM4QGTeNOFrqjVHw7/DLAfNhvEuJs7KoqXr?=
 =?us-ascii?Q?oLWcDswI+XFgZ6SbeJVDya4v0b4usFVVI7/KpgIMKtGYb1RqmRNqcX5qiA9r?=
 =?us-ascii?Q?aLnTb+kfVEW8N9evwFRa0dOHly6+zHe+Vp7k9JbP+oaRy1Ul7lsWfzttk3/N?=
 =?us-ascii?Q?e9gAbDDBjHgMoYxWkyEUoQrz19v3Urr8mInw3ECCIxHXeEFQKD59XFMIET5r?=
 =?us-ascii?Q?FinJTE/krAhAXmKCVDi3NIxv+oFF3Ps9LY2VrPT5NUCGgPrrSFP4a6aTs12C?=
 =?us-ascii?Q?enMgpV2JZVTnEcZdAHMJDdnQNIjpxjro6LVoS0+UkY3Co1tC+r8/soSmZNMo?=
 =?us-ascii?Q?68xNPp+NIHxw1TyYPkCiqXsX2X1Cs2rtTzEKI52UvnfIEcat2WBb9lrjcGHC?=
 =?us-ascii?Q?PEJ62Np7rWpiNRDt0qIxWIEX67Zmp9bpUga+MtB77RiFTdmd7T4JIaMcbmiN?=
 =?us-ascii?Q?/d6cUUIYC4aXFdfGp8XYWgSlU9NPZEz/8UCxVPv2qD+wwfX5Tkz+DNmNSNjL?=
 =?us-ascii?Q?132xAVQrBqJIBQynPspRGLq0aph4lR9eydiBT+L6LJMrPfiJHEfZjpXfanF7?=
 =?us-ascii?Q?BPWjhlMpMFRQBZHxCXTje8ReN5ZxSmN948acwK6WQ2UxZN7tB7zrvTWoVlzI?=
 =?us-ascii?Q?KNCuGmY715MpXpr53GG/sG/ZqYcZLkmKNJ5LY237ndDO9xPD8LSLQ7euNTcj?=
 =?us-ascii?Q?LWyis1HIchb9blT5XhlRf5gDV7fbcR6ggo/jqFuCFt5BMImtzUdtKPUNGlVi?=
 =?us-ascii?Q?Sg/32uDRQ3r0oQScOVfxw9p+0aE8CBdfCNJCu4f3ELcmKxHKCs0GCa55W0rX?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ba90e-d712-4ad0-4d67-08dd8ec2af97
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:28:17.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PoknIimaCUrkc4IfwAxsbVjm6hgjzhU9LU+Yb2+n7VQSucQk5m2t3RXnjuc0L4vptBI0epzwnpATsOq8Zq1Eop7BUlOCl3UQq8aEoiviW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681da085 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=uc3al3VmiIQHG6Bas5kA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ZDsxHAsEI1zhGWKrGDjEYxF7fYQ5i_ur
X-Proofpoint-ORIG-GUID: ZDsxHAsEI1zhGWKrGDjEYxF7fYQ5i_ur
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MCBTYWx0ZWRfXwfx73qm9NYl3 2KliYg86ZjH6taWdXz6tRbhYoTT4bTKi0FYVNOW/6EmbEi1lcbUjg2xIJ/s3lIonlzDMYCe2WGE ITUUK3V7ZbAmCdut2yvG2hkWEeK2eNG1lT91KzVK2woO4QaKk1v7G+dg0KTWHm7YT/YPfd3ar7M
 TUkKxWd16UoR+JxqCGUFG3F85nisHCJ3iIbFG8LLKCj3WRHyx6MTnyrLeihYcIUktT+UGUeOW/V knZdM4UsIa/LR99dPY8ucDUGo7XDhdkh6EuR0EQoj+i7HUoBs3Q55w+tmvNz3zoDHjZJP9P73+o f//4TpZe/r+rk9xW6DSuxeFMkfZegocUn1rjSJMRxE2LG4KpU25oPIhljoS9fUXgRb8BYBO8XlZ
 cREbyG+eMf+oOSGvo4Yo1/6ULjtSqAXAmBb8ZuF9Q2Bkxcb/U8YjGRVierMEEEsYQoKeKdfW
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090060

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e56aac6e5a25630645607b6856d4b2a17b2311a5 ]

The "command" variable can be controlled by the user via debugfs.  The
worry is that if con_index is zero then "&uc->ucsi->connector[con_index
- 1]" would be an array underflow.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[The function ucsi_ccg_sync_write() is renamed to ucsi_ccg_sync_control()
in commit 13f2ec3115c8 ("usb: typec: ucsi:simplify command sending API").
Apply this patch to ucsi_ccg_sync_write() in 5.15.y accordingly.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index fb6211efb5d8..3983bf21a580 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -573,6 +573,10 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		    uc->has_multiple_dp) {
 			con_index = (uc->last_cmd_sent >> 16) &
 				    UCSI_CMD_CONNECTOR_MASK;
+			if (con_index == 0) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
 		}
@@ -588,6 +592,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
 	pm_runtime_put_sync(uc->dev);
+unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1


