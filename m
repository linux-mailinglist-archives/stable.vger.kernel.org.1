Return-Path: <stable+bounces-103969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278069F053E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594FB1889ECD
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6018A6BC;
	Fri, 13 Dec 2024 07:11:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94917B500
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073867; cv=fail; b=OELrDdXhfTfI6pRzUupTeNdddI2PN6onJUlH+HY64g1BFKy/P1ixXZgdLz1JRu6F/NFeSpM0vIm+u9s5jNo6eHG8duP5SZZov0HwWwiIeXzo3oKLSlypsZQJa6PKc7SoTR0TrKtsiEoTsxzA0sMv13yB1ta8/z6G19CmwZWD2wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073867; c=relaxed/simple;
	bh=4K62PslCxbw4bPKQgoDBmz+jmXwA21b251WYRhLYsRM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sxJlI2WPx+lgFBSBJuyRM4Ro8uB2N/6nVjd+4uhyLuRKapuVZEEkuGa9dGwhVDHXsDxz/gOTo7nU+H6GB/ZCtVA1StsyZZCTKWCvwqyPLaxPNSdSq7ZMCt7fmO5uHtGHDBL4BeDCQeQAnAmV/BQy6FI+RZsLunjf44+Ha0Iscms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD5wxAm024158;
	Fri, 13 Dec 2024 07:10:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xesj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 07:10:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D39tm2bh+kle9aW531dwnTQ27g5fNkuBZfiKhZz6niyyhZ3rcZbVUHpdteD4dwDSc6hL2i1HJsI1IkQfgoBOvPYLhZu03E126Ag3W/uMuuhZMHYlLDa3Fk3PLb2nvqcF8JhnPAicoRS3Hq9rgHDmfUoYZstMAxMNUK/gdNBBd1g+KUpV7ySVr1kt9SmmNlHLRewI2YeIAzeGOy5okg91HeUGpU9bXcsjPcp+VZXgU6/wCO/TSEIjVoEDR0eieaFTsieTZ2hYuOWcEnFhpBXb3UKoxL4dSNoPNioPHWpRcrtB+qXi6bi2xE5fL4VVCtDfsBGAEwrQgnaXRV8+EwVzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLlPmFgpmXLQxakeAARowW/qxesXfEXyYdMHQ3wSftw=;
 b=vhQoEHgwpbdX+WbV2CnNEY+FfmTjx+cmBv+iNHdrblSjvNg2Er+u9MZLEhKb0Y/O3R0gG7mxGOTlwZZg18faw5AgnZkhTcrAzG/egzYdI/1EYeq3RjWYBIheJ8XUS+fZkJsnCgEsJrew353YAH1R6szp+3433PSxJtWjPYwq3BA2/MTp6ChqOKdwUJPzyQRWaGamSMuzjUpPPYO0FQMfHpBKQDiry0ltLFa9Cv2h+ANXIEH5AJ5sFA51J5X0/0nxVuI+TqaQjGsFA3IPyTkIkp3AcKmavoDLzOmB7D1ZiyGi0zGRk5BKaF4eYuk6H5V6nOTZn3ZKiVTQ6rwXF4h3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 07:10:48 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 07:10:48 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, libaokun1@huawei.com
Cc: jack@suse.cz
Subject: [PATCH 6.1] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
Date: Fri, 13 Dec 2024 15:10:55 +0800
Message-ID: <20241213071055.3601224-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf8abad-eef6-4150-434d-08dd1b454503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OxCHWKsTw1GvP5eLg1bZ2y12+arR4y2i2uMTwbjsgdBNG6L8abuKVo9koODo?=
 =?us-ascii?Q?7LkDI/vcizDFm7eeOW+ETciJ9XZfbEBaVcFx59Irg/RalroGT8gwt7J0M5w7?=
 =?us-ascii?Q?4XR/3UqEQibjAUpcJRksJzkjBVY7cMYyiEXMXBiVB/HM3N0kWSeJM9wM8q0w?=
 =?us-ascii?Q?0+xGORnVDOssCBjV1RLWoViar2L0qJA8ucq0IlM3+S918tw/WXSpRo+sSNfD?=
 =?us-ascii?Q?RWRkFHlRB5+UGvUNIfHBs1hKCQA3rLheRtf9e/jsWllwrmj5haX4s2fH2MQk?=
 =?us-ascii?Q?lCNYmWWIay8QLT/yDz/tJfzjJUSqsWbrXN99uU83TIQH2viawl65vPLyqYqy?=
 =?us-ascii?Q?S6yzsAGszLkOHJ8N02zfLYcgwQoOVSghEQJr2ZFPTGLDZa+8XNyr1jYJGnLj?=
 =?us-ascii?Q?63dMatJgWZMXJidosU138ZcD19VK+q6UfT2l3oPuYuQbQqNJ/3s3TgfzULCr?=
 =?us-ascii?Q?0fmYZm00wAXZ+JjDDX6f3H1RExWrZDUNg5W33zqOnddE9u+HWKRR4qjAKoDe?=
 =?us-ascii?Q?niT8Y8umjSw1GMcStBuydoZxWRTGMacw+iiwlEmecGQQ+zE69fE0mjFNbAf9?=
 =?us-ascii?Q?4uy6bAyXvPyl1qQeH0rEBv5R2R0amAAyiilnxL+caTlk9va0rVWQmXvi0We/?=
 =?us-ascii?Q?gZHr9NQeof8pmeTN3Hedkf6vKmPcmJb23DrhGW8BL88xFVHIrz6N8iyfWcfU?=
 =?us-ascii?Q?jxPFInK3D7rf8gA4GtgtVNhmyKvmsDglFALr9VTde9xJF1GnX5IO9LXLUbvQ?=
 =?us-ascii?Q?3yfPZPCJ1/QGRQVhUztQYGTzJu4YNnHPzkfZaIJK1/akwsaATqX2h0HBweKM?=
 =?us-ascii?Q?WmIFrrLL6lJ8lcYGsZ9zAWzOwWNMAL6+vE2sE8wSb+rE2bBRH0Upa1aBIQne?=
 =?us-ascii?Q?FbUIkDyMZUCwLWwU4fGhmQrGjMVsNM8I0XJaTy3x0MDb5xiUrt35y/qHvBvl?=
 =?us-ascii?Q?znFf5javPeQBzOUDcOcSnqZwIiZGX7cq5OrxWlAWB7H1sF9kizT+2E1gqPCb?=
 =?us-ascii?Q?+9NYp4UOwUIjyY/oVFrICBUTIa1rFXd7+pZFFzqFOkknu6n2RuwT5cwBhqR7?=
 =?us-ascii?Q?GO294uIfDItBwaZ5wyrBopv/qP6DquS5AyTTl7iIH/4tIpkWjbtRTJqAIlJY?=
 =?us-ascii?Q?CneOqBzMPI+StTSLGj/0IsWz3yUhLAm6Vv5Bzm9kzaGO/DgZlXOUQEhzTzdn?=
 =?us-ascii?Q?KceS2Lk+8PdnUdcqwUdJm7C7s9H6r2088s7O3dHwg9lltkS9C4WVXmwF9o95?=
 =?us-ascii?Q?Ww1ppQHSduwoAzNf0VI0G+CbdnuRHR/WZlFViLAYX+g21DuTmmes4/jvswSt?=
 =?us-ascii?Q?sZuNegNs07aJl45mn9esIPlZvOu1kUHKd2QfCiTXVptjBk6NJyg+elxD3f9F?=
 =?us-ascii?Q?0MVioF4GHY0VQyibQkRi4KwR20cuglLiEx7tAf1ZP8RcnX0pzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBer+yWWTWVGl0na+7/QYIsfEJ5sW3dky8jQdb5K6Omy8N6mrMYG9u9vpcr3?=
 =?us-ascii?Q?Gg+fpqmaq0GvOb7khv/6/MTermsQIu99m/Ygbc7c/Mqj+Ql3X3U0A0BGUswB?=
 =?us-ascii?Q?1LV5zIXYX7KAtwRgC/J87NYV7wpy48rNq3N0mP/nzJ3R4aV5P1pllMvDZf7K?=
 =?us-ascii?Q?u0fNZA7ndz7blNN6Lc9NdGwk61M7F4DJaZFMlzzFmJBB/yGKsOwG2PKrMPBx?=
 =?us-ascii?Q?LiYtgVA8+EBfMmGmaBqP+Syoz9lkuh/OjwuDwM4tpxONeIuwZdBRw28A2l53?=
 =?us-ascii?Q?Kg3QOpl7cfYbghx6Cfhouawba1T5tFRYqgriCesyTOgoPMZeeVKYZTD8JHZc?=
 =?us-ascii?Q?bLmmpY/W5dWfV9+509LbEH32o6SwPVg0d40U3HvovAMJSEUUYaHNX0+tFtos?=
 =?us-ascii?Q?koMWRiEcOnKHSzytYKqPm4Mj9S40DD+LPiGYMwgTw7DOkOxnaCmw9/QGhp3L?=
 =?us-ascii?Q?wtS7iJCbRXO64Sr/yRd82BvKOR560I0KuZvrQXKYlN2TLolIV729RaYz2Fm1?=
 =?us-ascii?Q?SQZu9YCyw4+3IWYMeX2q1KkByHFbjiGZQW2pxtAJBoJvd0el8DvnCDy1ulrG?=
 =?us-ascii?Q?FG9ZkVUNDKbZZj8H4+pA70Mk660p5wXc2Hm86YXz9cdyn2uz8B5BA3RoWKTo?=
 =?us-ascii?Q?ceeuAPo1vXdb0bkxvduifAx/dIGPDPE4CC/XM/wLbNkpQIvDxJH/pGV20sNS?=
 =?us-ascii?Q?muphmIV39jHhArQXQfl3kLy/9BGhRGqB1nP/Mhj8byb0E4jRJTLXnUN4T8q/?=
 =?us-ascii?Q?/stjZdIQTIqj2tzRCLTsHdAZ4vpd1GfsfBZphCvwy0ENNpe2aNyDNDnkpERq?=
 =?us-ascii?Q?/8mZelUk8f7JnRlGNgvMp52R/FIyrk7DeCrLsBOIXdM7FHsPRG+P27iBGDaL?=
 =?us-ascii?Q?3Q96YwkHdyHdt60paxtDY7piRvdRhfkWe81azfHmu+65eSjL0z7+vW/2SKRP?=
 =?us-ascii?Q?Sh31egwhfei5kl6AFq/t6qQxBooUb4zjgREX64bITZbPGUok4e2e89tUaNCB?=
 =?us-ascii?Q?L+HLoiMzXphcshnYs7uiSlMI3qrGOJrlJB4z7dE21Sk16YI7LE13PZxm6d2V?=
 =?us-ascii?Q?PhKwjvwFuoPUFU0CX9iTduJazb7/EQwU+sM/BtX/iOybvIdSc0SSuIj9ogv+?=
 =?us-ascii?Q?TbUmvB86ig+110Cz16rwCCzaeMtYTi6m3UsonEiXlRtzI5whDLwHikfaPp7u?=
 =?us-ascii?Q?7YvT3wwZjDwpW6MbBytoT5m6JvrzKk1nZpEJTChhx1/7wvRK9OWRQ0RQo6zf?=
 =?us-ascii?Q?EdYIp9ZdLvvZCippHX0IHHmqiL+JlaxE8L+ll+XgAk05XJ1FFGg0jrYygp3S?=
 =?us-ascii?Q?Zr47zgrLI1LXsf9NbCQIHBVIIJmmPLua4pHTkk5Xyx0t6bmCoKLJCUJsQ0Zf?=
 =?us-ascii?Q?CfSiqEk9hhedVRVNQLyQM68FGu5sOHs4ivWjb7PVk2tdErnec7xoWeXkDIeA?=
 =?us-ascii?Q?+R4F93bd8eC1vjmy1hko+vNyD2YwthILW0UdDYOdbLxU+YHuWfNWu0VQouJZ?=
 =?us-ascii?Q?E1dgERJKa+G+G0e6rqymRx6Rqnu8F/2wSAsWy6SbrgUFX1+yckylYJLEX/j+?=
 =?us-ascii?Q?v94AoH7vzRSCFZYIFfFo69EqPCF3BEmowCdqcdOoiEoBTSeL6Pb4HQN31YO9?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8abad-eef6-4150-434d-08dd1b454503
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 07:10:48.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TzfrYw/7ah4QcR35E8Wa1dryB62RHUEK9MrHQ4WZfyvZzyuGGynHSFpIZK0fkrVl0WIBTia0RBlmXTZ3QTXtje12zZkcJobIMJi6h1LeOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-Proofpoint-GUID: qW_iWAuZnTQ_jfjcQNacEU7Pm4C3VJrE
X-Proofpoint-ORIG-GUID: qW_iWAuZnTQ_jfjcQNacEU7Pm4C3VJrE
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675bddfd cx=c_pps a=IYePPuTyj3qIg1BHBNk0GA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=prOnV4MpFAw84sU4cfwA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_02,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412130049

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit b4b4fda34e535756f9e774fb2d09c4537b7dfd1c ]

In the following concurrency we will access the uninitialized rs->lock:

ext4_fill_super
  ext4_register_sysfs
   // sysfs registered msg_ratelimit_interval_ms
                             // Other processes modify rs->interval to
                             // non-zero via msg_ratelimit_interval_ms
  ext4_orphan_cleanup
    ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
      __ext4_msg
        ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
          if (!rs->interval)  // do nothing if interval is 0
            return 1;
          raw_spin_trylock_irqsave(&rs->lock, flags)
            raw_spin_trylock(lock)
              _raw_spin_trylock
                __raw_spin_trylock
                  spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
                    lock_acquire
                      __lock_acquire
                        register_lock_class
                          assign_lock_key
                            dump_stack();
  ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
    raw_spin_lock_init(&rs->lock);
    // init rs->lock here

and get the following dump_stack:

=========================================================
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
[...]
Call Trace:
 dump_stack_lvl+0xc5/0x170
 dump_stack+0x18/0x30
 register_lock_class+0x740/0x7c0
 __lock_acquire+0x69/0x13a0
 lock_acquire+0x120/0x450
 _raw_spin_trylock+0x98/0xd0
 ___ratelimit+0xf6/0x220
 __ext4_msg+0x7f/0x160 [ext4]
 ext4_orphan_cleanup+0x665/0x740 [ext4]
 __ext4_fill_super+0x21ea/0x2b10 [ext4]
 ext4_fill_super+0x14d/0x360 [ext4]
[...]
=========================================================

Normally interval is 0 until s_msg_ratelimit_state is initialized, so
___ratelimit() does nothing. But registering sysfs precedes initializing
rs->lock, so it is possible to change rs->interval to a non-zero value
via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
uninitialized, and then a call to ext4_msg triggers the problem by
accessing an uninitialized rs->lock. Therefore register sysfs after all
initializations are complete to avoid such problems.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240102133730.1098120-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ Resolve merge conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/ext4/super.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 987d49e18dbe..e6f08ee9895f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5506,19 +5506,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount6;
 
-	err = ext4_register_sysfs(sb);
-	if (err)
-		goto failed_mount7;
-
 	err = ext4_init_orphan_info(sb);
 	if (err)
-		goto failed_mount8;
+		goto failed_mount7;
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount. */
 	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
 		err = ext4_enable_quotas(sb);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount8;
 	}
 #endif  /* CONFIG_QUOTA */
 
@@ -5545,7 +5541,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount10;
+			goto failed_mount9;
 	}
 
 	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
@@ -5562,15 +5558,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	atomic_set(&sbi->s_warning_count, 0);
 	atomic_set(&sbi->s_msg_count, 0);
 
+	/* Register sysfs after all initializations are complete. */
+	err = ext4_register_sysfs(sb);
+	if (err)
+		goto failed_mount9;
+
 	return 0;
 
-failed_mount10:
+failed_mount9:
 	ext4_quota_off_umount(sb);
-failed_mount9: __maybe_unused
+failed_mount8: __maybe_unused
 	ext4_release_orphan_info(sb);
-failed_mount8:
-	ext4_unregister_sysfs(sb);
-	kobject_put(&sbi->s_kobj);
 failed_mount7:
 	ext4_unregister_li_request(sb);
 failed_mount6:
-- 
2.43.0


