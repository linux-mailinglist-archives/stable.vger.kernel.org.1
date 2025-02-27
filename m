Return-Path: <stable+bounces-119818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B7A4780D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD151623D5
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37768225779;
	Thu, 27 Feb 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Yu4Zm85x"
X-Original-To: stable@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454813A3F2;
	Thu, 27 Feb 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645662; cv=fail; b=hKKs55WG19ntFgBGFHexeJxhHbGU+NS7nwqTVGKMLgQznW3Bkj335+hmccrpVlCBu/uMNNZP+JQfYxYWL4fuivU8wBxQI9V+n7/s0h5rdG6t/SMsmIt0LBNxR2r2uxqyxIzrKYyYxB/ZL/q5Y3Q7sB2HooeDGWfh1RxOKn20ZEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645662; c=relaxed/simple;
	bh=d4TVbe0r04fDfgLXigsGcXbkEQOtOhSIQw3Yvq0YghI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NlhLcsF3dWeflX61r2XwjAcm87KWqxPOdlXmelb5MU6pUY4A4delRo/g6fivv3+4Q4dPYUctBlbj/iSBJhUjxlCvFB1w7zjXnHsP6VS5AYDEHOnJKdBconCBxyC3HAKEHAj3mrddkE3Yd1yNQiBxoUpza/t0YoN8nveTF7ssQGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Yu4Zm85x; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3vciO000837;
	Thu, 27 Feb 2025 08:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=36JPQIiJaIe7AyIHvJ6LIi30A548b
	/onD9/Igt6HwpA=; b=Yu4Zm85xdCnjd7UP8AcAy3HzdU/s3RIpYzLYxt8TgiAyG
	vszt4XMFIbjD7cOlBSaczlW9yze/ssOGtVaqSTkWnJnMnHCItNg7iah4Le+waiaB
	DJ/x8jT3wRChNhFnk8NVzqyNpt1aqccpkjsphPy0TTUnREOFlh0q8Fk7w+DDNe0X
	cIkiefD11VvCJH4Quvo7Lg0NKzEH4LFv/uQ6l7oWT0+6ITTc21gnFwRLe30m8uEH
	gi2QGL3yap7kEKb789TinwEth3uAJbMsESxxr4AaxUkR7gkkUJfm46432Ycu59nr
	G10iPr5WGyhqvoq/GyaTCpAUqFFeHLQIS7a5RQniw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 451pt0hjd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 08:40:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoxNwyzlQikJdqA0ZADtqcUBTOOpCYrPApMCeJmgDrXNcMjIf+5Ycb6gYrHi97EB5NMoSdGnmkRNmINML/V8cux2zTQlke/xhMk2PjYCnuhQia7gqoAO/ArPJpHo/C1qsEySB6b4SGHVDSMsTecLRfCXbTH95LCvR+rBHKT4Vn2PEpqKdZWKvk8STErtKIhIkhjHRH0aLnguAdAEuk63MpyScbyjZeKhjlQn1uT8ZsPievvG5NrbLII4+5ixr3PHwLZzuHeSVW00z2aMiG/HuMGQ2xSrvutG6m7FeUfjqHbZhWQQI9xKwVl+2OfR0z6RxK+Yai2frPpJQenLh9ki+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36JPQIiJaIe7AyIHvJ6LIi30A548b/onD9/Igt6HwpA=;
 b=WZBOFktyZLnsAxwm7yl8s8J4+RgGdRX0iY88qHnMDyvUriW66HmMd7VoM4SOiRtd4RTpnQ4gwVdee9y/UT9RnOcJIR/P5V1CkZkbd1TM+99LysEdSp2UclnNZ58lzCECDKbhk9ym6l1XPGYaG+TnXGzQtVT3XrheZWd0SinmZrNlT8Mrt+K6HpP6+xiG0HVufl2UVKMrPNz5VXqGbbsFgf6z5dlG0KiI8hvGwWVHDzns5l5gYrFjmHM3vSkBkFtvYZk++c/ySHe9up45KOnuhypW853eIaXeJ4nyHaXXNua0wGGroVqFDjiSt4YI3W3K65Ciya0E2tK/czKx6jVbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from SN7PR18CA0001.namprd18.prod.outlook.com (2603:10b6:806:f3::15)
 by DM8PR13MB5240.namprd13.prod.outlook.com (2603:10b6:8:7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Thu, 27 Feb 2025 08:40:48 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::19) by SN7PR18CA0001.outlook.office365.com
 (2603:10b6:806:f3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 08:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 08:40:47 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 51R8eI8j012359
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Feb 2025 16:40:45 +0800
Received: from [43.88.80.159] ([43.88.80.159])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 51R8eGf6014809;
	Thu, 27 Feb 2025 16:40:16 +0800
From: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
Date: Thu, 27 Feb 2025 14:07:46 +0530
Subject: [PATCH RESEND v2] Documentation/no_hz: Remove description that
 states boot CPU cannot be nohz_full
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-send-oss-20250129-v2-1-eea4407300cf@sony.com>
To: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Atsushi Ochiai <Atsushi.Ochiai@sony.com>,
        Daniel Palmer <Daniel.Palmer@sony.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org,
        Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740645549; l=4585;
 i=Krishanth.Jagaduri@sony.com; s=20250122; h=from:subject:message-id;
 bh=ajPMwB6QoB8KORl5LePP2aCGgx9j/ygKbLrv1uMt+jQ=;
 b=H6TIkKJOMgEkm9WrOntCW4lzjKyJV6Wwc92NRZsusJPy/J0N0e0FRqtMOt/XuaSiUBNWPotTc
 h4dnF0EP6f/CpvRRj/DjSS2KvEQoAZjtJStwk3gGek2gH1XJ11f8Y3v
X-Developer-Key: i=Krishanth.Jagaduri@sony.com; a=ed25519;
 pk=lx2tvWPqsnFN2XCeuuKdm7G2bXm/Grq1a1KTsSpFZSk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM8PR13MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1bda88-5131-4467-4828-08dd570a6f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1BsTWo1TXVjT216bW9RMDVKNWs0MVpKNlRROUN2TGswTXZRUUJydWprTXBG?=
 =?utf-8?B?N2h4MzlkbDVxVzB4dmtXaWFHRGtURUVqdW02MkROUG9JYXF5ZkEyd0RQOGRV?=
 =?utf-8?B?NnJ0YkpWeDQ4RE5OQnQ5cUhrVWV6YmVjVm10dEpMcHJBbWthaDZTZDdCVy96?=
 =?utf-8?B?dXNCbkg3NG9QRXc3dFhOMTZ2U1FmS1J1bDVHV2hQZDZBQW9Kem1ZOE1OOFpE?=
 =?utf-8?B?akc5amxhVHg4Zit3UCtZcU5MSUtHd0ErandPZlM3Q2lHeU45dmkxaS9zVEgw?=
 =?utf-8?B?S3kzcjNiS1VadWpKUzgyMGZCQUVQN0xKaG9hTWpBWmZkR1BTTndlUEpjdWpC?=
 =?utf-8?B?Mk5MazA4NExuZzJDOG1FbUU1N01BNEZwdTF0Qm1CdTZzUDMyamFHRndvWnhs?=
 =?utf-8?B?RTdKcDdpMUROZk1HbE9raElURkZGY2N2NytMeGpINGF2TDM2MGVkZ0VpOE92?=
 =?utf-8?B?MnYxMFFnNVljNkFONE9pd2M5YTZTQk1DKzdESUtLMVRJMlJ2UitnVEpGR2t6?=
 =?utf-8?B?bWF6dkl5TEhoR1JMeTIxTmlTYk84TWRTcEp4aDBXdWFyZ092cFhIcmdUVWR5?=
 =?utf-8?B?ZUhiVWVTZEh1Vmc5RytwdUpvRTBocGJJUGNJRXg0emQ1eUNuMitLZGpPOEFu?=
 =?utf-8?B?bkZJaHpOY3hQR2NFV2EwdWNJNUdNNE1CN1FpYmx5eWh3L21uMEQwZXNxck8r?=
 =?utf-8?B?d0xKa2RGRVZNOUhjTk5VV2QyK0pkRkhYTnV4ZitOeFJBNlBlMG00SGNDSFQx?=
 =?utf-8?B?UDFRZHJFTUt6UGs1OTNiQWlOYnorTU9JL2JndFhoTUNxbXZ2OVRwelMzTEF5?=
 =?utf-8?B?NnhZZEEwY29PL0RYTHpNbWJpekw3QVZPT1R4Qno4QjdkYUN2S2R1ZzU3enBx?=
 =?utf-8?B?eFdsVjZDVktMYTJOdG9YMC9BN3JkcWhCc2xjOENjVXIyVDVpUnhLRzFrcGFY?=
 =?utf-8?B?dUo0SkVETyt0bXl2cTRLVmtkN3NPZmF0cThNZk9mZFAxNXdNM2NqQkFVVDQ5?=
 =?utf-8?B?S0d3K0hDSEFDWFNTeENPdjkrU3dlcHB5VXlsL1JRQzN1R0h5S3BDakdnTndj?=
 =?utf-8?B?eVc5MUYwNVZ6M2NYOGtHTFFvQ3pCRG55aU9FOWl1K1JjeGdTWEptZnVWNWdC?=
 =?utf-8?B?cllZV1BXUHZVN1RpUWJkUFFEWVJLOHNkcTE5ZkJlRGVQUGVRVURVSlpTS1k4?=
 =?utf-8?B?WGU0aWcvV2NKcnBZZnZrUmhSK3NkV0VhYVhwTSs1Nkpqak9oRHYrTXY2VU9C?=
 =?utf-8?B?UjVnUlRLMG9wRGdoVU5kUXI4bVdISUphSitrbXZzR0hQaWQ1em1hd2tKWmhU?=
 =?utf-8?B?UlIzNXEwaHVsOXZ0K2xWOUphaStKUzAzakdnWXplekRWeVJmRi91SWkrMkFZ?=
 =?utf-8?B?dS9YbnhNTTVNaWpnL1o3YzNDRjhna2Fia1VuTk94OWxXZ0x6S2k0UStHTHBR?=
 =?utf-8?B?Uko1UWdubmh6NWhlb3lHZ0lWa21JaDJQaDNrbVFGYUNsak40TWU3MmVoODRt?=
 =?utf-8?B?b2pyemhYOEZaMmZCa0hrR1V3NEZ3ZGtuVFQxM1JSRzltVnBZNHFkVkV6VHpu?=
 =?utf-8?B?L0VGOGdPVDBVSW1ETi9mVUJkVFRscW1NaFZDUkhLYkJPb2I1eU81eVc5S3E2?=
 =?utf-8?B?THR0TTgrbXVwenkxMFM4Q0dCc2U5NmgyTlpReWMvMUNMWUNBOXc2eldEdVp3?=
 =?utf-8?B?ZnhJSTFXRWRxbDFRQ0Q2alpRaXFLQklZbzhZSFZZSFVSR3ova3VGWjdCU1Nm?=
 =?utf-8?B?Vms0b3NBN3MzR3I3ZVRvT1lxRTlPSlRkcVNXMjc4Z080ZDcrTk01d2hTOEZB?=
 =?utf-8?B?anF5Wkg5K3VRODJjNklscHRZS0EwaVpvNWhPc3ZmOFpWN29Ubis3Mjh2bU5B?=
 =?utf-8?B?OHNsM1NoVC9xS1Mzck94S3lsR1VndnJmT0MvNTB1NkozeFBKKzZOQVQwKzdC?=
 =?utf-8?B?RHo5cDNZUVRXS2x2TTZjdTdoYms4Q1pqVnlUOEpKcmlzMUM5K3lkMGlFcjdQ?=
 =?utf-8?Q?Zv8zW12FB40/wctYxwxGcqPahrDXjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kKUAYULgXlvqaGv+1bbmhOkgtSmxmLuYncU1nfJrI6pInpeqFZfwgIDYmujdgA8l2sKvshW0uAihCgczaeki4g/G0edafeqtdxhjfm50dDEna2ETK3TG95Z0UxpGDOl9zFrwfO4QMgPwbbWd6mx4q7MQk7pHrkSLnLvgcJf2Xt++FohbAzuVZa2lEJtTmDv+RDnPvjQ+hs/FgMryUieD75p2c0XBu4JUOyljQkItBdjgdN4ahDKIpw7oUrP68xMMqBZ85zpV5A4d++2pmn8LjbLHqCVlPoRUkYetG+ZSqawRLOFq3zRMHhmsiu/KF4QqmVJw+WMzEhHTnFVheC4ezXQg4hYAxUDncZj5vo1BG/eOlGK+7ihAHOvq9iXolU1hMlCcf7g4VLt9eY2rjg1Mbq70D88QbIALF6vCmq8joBJeK7hZ2ClufSLDD6Bv4ddDRl2060ZYc7rn1JQIUAG7Ueirc3M5aaS+efQgKXw1vKrds6uFahlNzf/oBkgdYw4NSc8ifC5pDj7q+bv9ylDOUnuTeGI7WBjfrL+DFsvJatdYLvQsdSJks08fYNLSeVoq5rD4CQjNESAHurdxjMWAQ1hCTIQ8GTbxgmbouHE2uUvukxND9jWIy2ic/8mv2vPu
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 08:40:47.4256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1bda88-5131-4467-4828-08dd570a6f0e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5240
X-Proofpoint-ORIG-GUID: PctiUtpBVgQIPWwLpDOi06fKJEz9q9tK
X-Proofpoint-GUID: PctiUtpBVgQIPWwLpDOi06fKJEz9q9tK
X-Sony-Outbound-GUID: PctiUtpBVgQIPWwLpDOi06fKJEz9q9tK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01

From: Oleg Nesterov <oleg@redhat.com>

sched/isolation: Prevent boot crash when the boot CPU is nohz_full

[ Upstream commit 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e ]

Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
include the boot CPU, which is no longer true after:

  commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").

However after:

  aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")

the kernel will crash at boot time in this case; housekeeping_any_cpu()
returns an invalid CPU number until smp_init() brings the first
housekeeping CPU up.

Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
return smp_processor_id() in this case.

This is just the simple and backportable workaround which fixes the
symptom, but smp_processor_id() at boot time should be safe at least for
type == HK_TYPE_TIMER, this more or less matches the tick_do_timer_boot_cpu
logic.

There is no worry about cpu_down(); tick_nohz_cpu_down() will not allow to
offline tick_do_timer_cpu (the 1st online housekeeping CPU).

[ Apply only documentation changes as commit which causes boot
  crash when boot CPU is nohz_full is not backported to stable
  kernels - Krishanth ]

Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240411143905.GA19288@redhat.com
Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
---
Hi,

Before kernel 6.9, Documentation/timers/no_hz.rst states that
"nohz_full=" mask must not include the boot CPU, which is no longer
true after commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be
nohz_full").

When trying LTS kernels between 5.4 and 6.6, we noticed we could use
boot CPU as nohz_full but the information in the document was misleading.

This was fixed upstream by commit 5097cbcb38e6 ("sched/isolation: Prevent
boot crash when the boot CPU is nohz_full").

While it fixes the document description, it also fixes issue introduced
by another commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
timers on queue_delayed_work").

It is unlikely that upstream commit as a whole will be backported to
stable kernels which does not contain the commit that introduced the
issue of boot crash when boot CPU is nohz_full.

Could we fix only the document portion in stable kernels 5.4+ that
mentions boot CPU cannot be nohz_full?
---
Changes in v2:
- Add original changelog and trailers to commit message.
- Add backport note for why only document portion is modified.
- Link to v1: https://lore.kernel.org/r/20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com
---
 Documentation/timers/no_hz.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index 065db217cb04fc252bbf6a05991296e7f1d3a4c5..16bda468423e88090c0dc467ca7a5c7f3fd2bf02 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
 online to handle timekeeping tasks in order to ensure that system
 calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
 (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
-user processes to observe slight drifts in clock rate.)  Therefore, the
-boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
-"nohz_full=" mask that includes the boot CPU will result in a boot-time
-error message, and the boot CPU will be removed from the mask.  Note that
-this means that your system must have at least two CPUs in order for
+user processes to observe slight drifts in clock rate.) Note that this
+means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.

---
base-commit: 219d54332a09e8d8741c1e1982f5eae56099de85
change-id: 20250129-send-oss-20250129-3c42dcf463eb

Best regards,
-- 
Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>


