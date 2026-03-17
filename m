Return-Path: <stable+bounces-226108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMHeMQl2uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:40:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D32AD314
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC56230ADD55
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914D3EC2F6;
	Tue, 17 Mar 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="h0SSld3J"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759D3E1203
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762017; cv=fail; b=BQVfU6exgBYbqA8BKusuYS/xmMA3+RKr82bikHp3RWN5eBsqYc+aJb6p6c2Jc8wJXQqqdLVy7eJHYIufNqxulZFYuWyAkb3ngJgpyTP0IG98UC5frJWovz5q+xTtoFKU3mi+XsUAJNZ+w8jDGG2yJ0n3dt8TWo620WFBhEGu/Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762017; c=relaxed/simple;
	bh=glAdVYYZHcvrke2htk9jdYG4Xwyc6HQAC3ScWziKNS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hyCKpTnJhi8Bpxh+Pnyvwth6VviOlGUPdsgUb/IH3oJGcId5iyCVBSQtOOf/Glh8heRTVQ1kx5e0uoSgZ/8U7zML0MjJqas8/1zlJIGVC2WY282WrXylPdq2cUv2RAynAs0RbYjfrRWQUWqMI13arNtPCo5zr/m1jIkmZZKwjMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=h0SSld3J; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HFQsJp4093613;
	Tue, 17 Mar 2026 15:40:03 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazon11011057.outbound.protection.outlook.com [52.101.125.57])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gt9yc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 15:40:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAu0mgW6i8Osj7TiC/4ib6Wz55bkTLZAYw2Ej5U9n09WbeBFTWXUEeTZakR2JwqBa4cjPF4SapocQYUyaMXWhrKzMj33JYs3UUYUS5+09rRc2HW+c4PwnpaDZGLHHlqY4Rzk1z6UGUjAU9vwsfPfh0lvjmQg+NVfiT4+Ix/HNu0TTHBAMY7nbJFiX3xshLfkWF96ZHypM63kp45sR6M0zSy6yEFBgSBgrgBcpqjgSxt/JYgSpJEwY1M4zcJAzgt5INguwjmF4evHFkTJ11nkbY282S+WcY4tMtzEym0ueMHKux7kvYZhJhLhCAsuk2Zm7qb/u66gFgcSsmLhOCuCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r70mkxKZKc5AFIBU6sxE8MZBAC+/dDH4qM8FDRLj7xs=;
 b=XvNITWIYvw6pLAvV7JMDiWpx8ae6StgbW8SZF1SoTirEtTZXe7bfEoL6rOAL9Z1SHn+wvjv90cOCrNrMHIsrMoEbWOaLy+iQgzDaVvRXLnrV1dQGXMThf27SaKdiWY0UEUSMIbySO4HjZl5cQnJJQlCV6VRvfrbWI6D7fEwlUhe5yY97ZLeeJdm00dpZFfwpWZNAhxB9R0xIbY3eyCQfE3danBHX/UecgAhRahpLnqD+1srNKTAs6Nkopu0Xtxn1mjE1k4j2AbGHwpltQdTuudg4TZ0fd8fm+D6RUiSyENhx15o1fR7aq9oDhtyxH5pjf4R+Drvv4yY8BWqrT9JPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r70mkxKZKc5AFIBU6sxE8MZBAC+/dDH4qM8FDRLj7xs=;
 b=h0SSld3J3e0DBu1xov5+6Q2nhE6sCDzmseiq48Ffjl3Bt3pI7THPeW6FFsFM6gWErHgBUbirc7stA5e6L5WkXAYOu7Uz0pPtpzvToNKB+5TMbGhML6x6ECFu0Gf/jz59BaEoIWt86OWvf3Aqk+amzCZc69cROnhr961sKHyRvSYaBZoLAU2l8wmiFypjuENAvnYMHujFWV51Cx4uHWMRSv0rEjf79XASti4inIIxaCJ/RkscWYEJvHLWSJF5qvvzdPBbyUx+IRp/NQ5rCgjdnrh75uYbbNjB1bhJQMpEqKklIam/I/FI36LnioFXsg/FlvYxRtiM31+i0bbiFBF83Q==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB6130.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:39:58 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:39:57 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 15:39:43 +0000
Message-Id: <20260317153943.637315-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031737-trophy-prison-d009@gregkh>
References: <2026031737-trophy-prison-d009@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0284.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::10) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb57c57-4cc2-46f0-8df6-08de843b71b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|3613699012|38350700014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QX4wyXtoHuENYjexJdk4V3YH1yl8GokzVo6fqhZVcoSuOaPAjMnyY5OdfzgODv2oMm8FPy8ehyV8sxt/2jzRRbU3vWfcoFAbnzTETkvMkPLoq9ZMkGAv/+puTHFfxiAQbizC+E4fjBvlJqZ/CRzE5WX5xPcZhrvUKyDAKnOseLqLkqSnZTRAk40WSZD0IgZBIDM/xjrlnbqI6E0+KeA2LMfBIr7l4apfPLfq4AgwCykTlIPEPR0P0qbg9MVDwHCCFuYJWBp696zSHqgrrXba/FeHl4fKbbtBIVXYP78d6aK9BokGTGY1ySX/vcHd7H/rQQtQwjYx5qVl8w6vmQhA/3pzDOe3qBygrgEFbA3LDj87WZ/CNFvtZ4m+xrbm0RtBSF38DHT+91xxRS8Kr4WgFMgn5e+OjtfRVOCzTZHP8TxiBuJbB4Kh6XEAJRarU4uKb46kDxdnJacBSCh7jNEMyRDy9i56Wi0+keINwmYtVCx5ld8BNTtFIbpmzAj6Wcn6VQv6ywjGe3i2+2+vtU9TC/5lwQfOz7a1pUwvGI6AslVKjTF52iE48xNyRROBe5/7J8k5B0q5Cbel6/tePzY5WfDkchv/5p906l2mnjvHEmXnnnYgaBGt+yrueI82yYW9pJ1XOKPaKzCXHZD1ySONyf70O/iW6Z+SGXjL4pmgfZue/tIa0zkAd/MqVwMS73aZBrQIylBATbAKbQHHMFvCrWXbLPAOqDrHux2i3JDj/OqxvNS9JTU1RqlkRmZ1aUVhOb06uoZtO1fEe/ybayuICBcZ9UIJVxlCUApcrNIbaVpSKEU4M+vNtv8xmhpaF3Bc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(3613699012)(38350700014)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0HbIX8tlnCGz4jQYL6GKqG/gXwBVOHiTFGHFp5NWfYUNFDkOsErZ0MtpD6H?=
 =?us-ascii?Q?kNAOG4324jt3DRwyw1rWsWbgZGlw99XvBA7l1mRfonMFJhfDluSrtRLgklZZ?=
 =?us-ascii?Q?SK4ECVM7t35o4ZRqkokJXJT1RFba1Wum72gqiKMswmVdL3sPHS6Vzsztd8mX?=
 =?us-ascii?Q?isVUT+zYHlfz5/buepz/jWSfhZWx+QdcB7sICWsEjnwl2RFnV1HznsKwgOCY?=
 =?us-ascii?Q?z7nP7/zQpgTUsKe7EZ5XKE5Xs4tMNLyQSF2n839fNOGSwVzlt4VMxPutgJRo?=
 =?us-ascii?Q?mHm5AgimpPwsHyoKNczODetELyg8TwyXLUt19PrpHmIR4KnDsBTFJwCooNvW?=
 =?us-ascii?Q?zxzKRZM113PFXchLBvBmi6pWrCxJ2+fPyxZ+1FWhPdWZ8rWqxUfbpgT55xVh?=
 =?us-ascii?Q?SQkqrsOAVEupcbKSs6azDUX64Iq1pncDeIYlx8le96CbuEyBqdHlPO02I6M2?=
 =?us-ascii?Q?ngy10A7owHhrfE1SuxStL+ZbXy26oszZiLLajg1MKBxwW8PIchwT2YHRXa7c?=
 =?us-ascii?Q?7+cOgBKPAXmkH9Jha4s7glPijoScKW0caWU78VvsmXymCuyBnbrLlDFYhcG5?=
 =?us-ascii?Q?fWBwCMhctkGsetuHsLSDGX2zpCmOAw8Qr+39TEtwfC4cBVEagvszMpIR462+?=
 =?us-ascii?Q?2gPsSa6fn0w7HyD89NKr1CHiS5UQmUfNBMJZ++cgU50RLFpSPqt+xRkjDoFG?=
 =?us-ascii?Q?nVQzZw+9f2yZmi70Yp7sGB+UClYlvTQnA/kFPWnMa3ljPqzmJ7FHHP2Nrnsp?=
 =?us-ascii?Q?rJqP19wq6NP8X9An9JBct4gKGlpwvOuL3MXj3bs5Z+tXL9aco/I0WFOwR94T?=
 =?us-ascii?Q?FTtOvwvXlbhR3+WHI87dSuwJbsIQtEkjz51ZHiOXevcxF/pdgF3uNxqlysRG?=
 =?us-ascii?Q?lRYVnu8heKbV5FFgnmLdXklPMlkkIONDE+Iq1wsMPsukNh0uQYG+5JhYnRYO?=
 =?us-ascii?Q?+hy0TwMyZPHk+clpNUTyaeefW22E7GkrkCJQuclCqQNdC9TyRJPZdBjMvj8N?=
 =?us-ascii?Q?zdR8az+yv35TG3DG4uhPKc21D5XaYi8xXpe07fLXTn4E+qSGTmfNsSKxwgQb?=
 =?us-ascii?Q?v4RBRkZ9tXj8zzgHz3XWzZ1EOYQKCaqpxG3TNxP00VuD1Y5UI3e08ogft3Te?=
 =?us-ascii?Q?KlH3TV8geALa6VRD0Noi5T9yUpS8959z/qoul3JycM7CwBuNMwb6WCXYNNLJ?=
 =?us-ascii?Q?PGvUBtwAzjnxOrFEBqwT9gBYWGPv59UT0LWLumF4h4lRWzKdkQGLV5BVBiJy?=
 =?us-ascii?Q?+7LsBp+efqivJbmh2euqHBsUUbrH1t1wu8hmmxiy9xiX/qoZzp4o99BxNbJN?=
 =?us-ascii?Q?D/ksqowg+EINXAQHJkwxl6rl3C4kJ1IhedfymyzKfFmACi3ny3+sw1qaUzKR?=
 =?us-ascii?Q?tkvZA0/JwDG1oGSRLObt5/uaKIRhNPkD2nZoscPkcveOTctxul8ayPqU8SG3?=
 =?us-ascii?Q?7Ubw8eTtu2HWg/gLBhcwthmftGgrjar7Rc0y+hLGyCOj2Apztuv5FwWSvL3Z?=
 =?us-ascii?Q?3CvrIm2l2HcJjjXhxceTBjXMcTjVHJVQEbrMpjb0r2DLXjEv0PRg2uec1OsL?=
 =?us-ascii?Q?wPbOV6gcDuwtKjmt3LKa2CtxB3qe0AnfkxnJkadBD0zzu7pIj0RqvN0mWJ8L?=
 =?us-ascii?Q?/MmTIfJxUCO2yf8y0EFpzMPmfFqXYk7cDA4dxwX7Rhkbmpgy7elAszILBCil?=
 =?us-ascii?Q?HTkRVMNZO4ILha++ZLnnBD1Dy8tzmDPHKBpHX2tkxifk6dlWCUiwv1ZghJbm?=
 =?us-ascii?Q?GgUTjZeJRQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	u6+wNyZdnmhHnTW6WrCZeprYhZGxaG5Mu9Hdr1WspDMeilqMRZYjJY4EzPq3wkuh+DwKZ5kMDtEIKr6f7caisjcBI/OTjjQ0rfAceZs2B0wLfFT1pK6doBfefGSEdaOkMf6gKAUmM5es90AjrPcXlAKlVEcTCrJwPRukK7QgIqsZep7H4Yw5dMsvbtjnf8YnoGug1TZqyFNqgWiEuiHWKM7I8/b7tR8omfGrT3uudHtcKs3g2Oqj2DnDEXpbrM6I92F+j4xNJ/ha/yeF8H/G+IMSz60UUlmhbrRO9f9HzA4udkoIJkLizEhyrBLqnwF5koYXF+Q/zftmxGFMniq1eQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb57c57-4cc2-46f0-8df6-08de843b71b1
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:39:57.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuIiN4fQ4xC2ax6vUukg6Dz5AFwdCifldbvim2UuZeOOYe3WXjQgusOq4P4Ak6gPpzsUJvh5pU4gqxNThVL0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6130
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b975d3 cx=c_pps
 a=n6CzJEy3OCT3LO5pcrzoJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: V0xHNdkeSDwZXwHZ1dyL_JvHQSwvgcp6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzOCBTYWx0ZWRfX2EveDcg5Yue5
 0DhKojnIsYaotx0aLedfT7QiprEY/wGKYzmvO0SmoH7sU/XCqZPtaRyWUC56nRgE52xAWUkE0w6
 bFX4EMdofZwJ0Y44mEGCUaimfVMmPLQhJgxA2rq6z5bsIUihZ+v3tet0vHJ2qht3hTFHlHGyGQd
 8mpIvsnBxEiym2YH+yLEMjX59GWEVKffh26JQ07/E7kQ8AgZBiueQzqsLiEc7HPqHpQmDO8EfFB
 WMoZzMEfy0iV8QQE3Zwm6biQYrF/glCiQepf4imjKR0vVJqdxmAx8FZQRhVV59d+ZDNxKH+zqG9
 c4lgp7rqdnkQ7g1sgxX6fnitjyZyHOaPtp9L+T3CtArojikltjgIcSMG4dwRFn71hDuG8OtMcuF
 geYbP92EZ4rIB/JBugyPZM8nLvYDeMnJvqs+RpEpjDCNl3YffwudTlVZ+rnAsuox0gYqNQgJa+2
 d7tW1HjiY2eHWOUEs5w==
X-Proofpoint-ORIG-GUID: V0xHNdkeSDwZXwHZ1dyL_JvHQSwvgcp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_02,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170138
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226108-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdk.com:dkim,tdk.com:email,tdk.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5D4D32AD314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..f29c3e8531e6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -377,6 +377,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -398,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


