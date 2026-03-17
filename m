Return-Path: <stable+bounces-226111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL2hGCl3uWnQGQIAu9opvQ
	(envelope-from <stable+bounces-226111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:45:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92752AD441
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F67A30CC1A2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112563EAC7E;
	Tue, 17 Mar 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="SdddmtEb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A63E5591
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762246; cv=fail; b=ulV0NC3s7tyz+MsMWQefME7WLdopPy/8Y8TPG3BqlG8PLJxblm3jaHOTxIk5PXCulRU8Z00VfvmN7IZYdUurjVYeTxeJkj9oZ2N+Jbn+Iol7nm2I/0qeU5Zm3vDsrdLbFqJmyoGhuLMyIis3edrBAoHE222Y1Wc18Q2BRRfvUaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762246; c=relaxed/simple;
	bh=glAdVYYZHcvrke2htk9jdYG4Xwyc6HQAC3ScWziKNS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCbtPN36MA0VL7ZRDxyxwW2X0LQ/wXNHg8KXI1S0M+5jf/9H0g+KUYE0o0Osdg33HgOVqCWHRJykZ/geLxEiMdwRUAx82YxW0GCMBe+D3DAbiyIyifWWZdOm5TWqFAjVF3jeUGtGkUcqU/+vK1Nzf0nArLFrpTB9910xhtZJB40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=SdddmtEb; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GNJGeD2339267;
	Tue, 17 Mar 2026 15:43:53 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazon11011041.outbound.protection.outlook.com [52.101.125.41])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gta19-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 15:43:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H34O//u3QjvTCyrcb3uhiL4tQAuuhEG4Zwhqc6Lri8n7oHDsXH3HflAsI9g1nG4Fa7IzUP7T4i/i/NU9KF+bA+mrtXENIxsvfFwy7DaRqcxbVoTG0YKqLZW76IxNuGlK5boV7ZNq/0rj2e0zPs38JZSSNGbB8R+D3w9Gj6EXuyWKQeVlenAZlDrAxIEBz2JfYukRXZMmwT8CaFCIge7WJDsHRL9yKVfBNdg67blLHG+fQ+5joRa3ITBi6UdIhoTzMAqgPiZQtafdyFxmw4ezZ0z/jKKFGucY2FHhUIPDOTBl4P7ozRnWE/dCcPIOg5oJ4NxXD4F1/dCxMDpsUz+KWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r70mkxKZKc5AFIBU6sxE8MZBAC+/dDH4qM8FDRLj7xs=;
 b=KZje3WOeNVIXIo9Z6nlEoL9zBOJzSHT9CaZaD5QEhVjZFp6deIXLhH4QNaSinFR3BqgwGJkmgdy+/2zxtWiQzLBVmjW8IY0DJMpL3a/wCGVzK3P69BTpSpu4JFDOo4LG3hg0a3dgmj1rEWUvAQ1F+XopzxyakrQc82FgnN/76uFbryviBM/Zj2kP5KYaTBuOxCzEPMx5fBin5EPJeA2xcWMDpx7unRoqt5mZtlfTcLoM5yG5cOaccgINwgcOznMiIwh+wd8fFgUpE+fGpX6l2HCRiIsBqvsJ+vTzh0dW1Ti1r7ahG1CEkBIS6MudMitS6cJrZHISHhNf82VEKcaC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r70mkxKZKc5AFIBU6sxE8MZBAC+/dDH4qM8FDRLj7xs=;
 b=SdddmtEblX9VCL+WMhyRFtwF7TX7/3nuu/R2IEm2b18OaL4qmp4mlf9NC0vKe5f/dQKdqQPSA/+ZS3zBQkcWvvcsKqdDZqkfl11hX0z8Zj7S/+/hPqilaTa8kkInLereFHP3U9LBJFHp84GSDxL7z2PCMoMfmpp0uh5W1Mwq+XGHHmFrGcMvkGkU+fo6APMyvmh3j3LxKMNQYfPZPeTanTMHHNbnWxT2aR5sImkPu2MLs83TI/qzwLcXHcMILoc/e+xzOb8J4265l272f2gQQ/2VYNIcbytlUgF/LEOj47jyTviM0N5xuasRJahQcaY2h2qtPbv65yGJxFwG7UZpig==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB6130.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:43:49 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:43:49 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 15:43:38 +0000
Message-Id: <20260317154338.637579-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031738-vacant-most-feaf@gregkh>
References: <2026031738-vacant-most-feaf@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::12) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0912e67f-7a33-4bfb-24d1-08de843bfb76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|3613699012|38350700014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	772SkSuQUZnllo2MZeW91kWsSE3jnsLqNoY77YSy9oLg2DY9hzA9XsDsM0iIl/oNAuvM9jxuQ0aOGG7ZHATayKChht3OUlZZycPtXTjSH2RvboajvIVHAFAJsUvijD6tpTA/pFrxobHgrsyq4auTjAXyqIfapkZZqG0LRUa2PxoDJ+DYu3Pqb1d+rvQnTOXr/AaLcDTXfmYntPsAFRjbgWyBtMovat1WNryEnNcOv30zlegcoqBQyyXiMcrwQ+/j4ehtIJflKbmLRBHWg8LNtZ5bUqlRHbBYPuDhSc7ZLK5U/yCqymaQKRiDhwMpsLTFlT7TJbizVjwSfNXcj0cWnUlHKcrseircwSBtb0R3Em98rVNonYLZhPaSlSA4FGRgZzX7ReVeJX8gLY8Tr7LWzhF5vyBIUGj2T/t/PhelOV58nABiKytcbSP+/r2gI+9uETbYhaSJs8L+v8yCZN6gIUM8TVhej++vkTOHrlTW3HW9nD4zif3ZXLC0Tx6/BvP7SLCTkjrChHIzduQXXE9ziJdCc7ma7wpKq8kla8s6X9YBKPJIGji7Q72HU8uEBP0mAjaxlxhErp7s7VFudraVUQw+3t4qxStN6fq5Y50tfQz1lPqCXUKDk81yQlx6pNL4Tk6ijDGoX9JSciCen4R3fjBII6sJio5WOwFEM1eambW+yuaRTwV9fsSzStJQBgmXCzNuBuMBnrAV0hwTySkDTJxUUbeeJrRR+qqzikyJ/G1eYZYyO6a0x0L3K6s6TaP4hIydow1hZcaNTbRvDJdwWkwR2+wwu1ZpS91IEGCqULAh1tcrrZJJV0AymXtHRtC+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(3613699012)(38350700014)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHw2s+ugmgdtk4tFmuWtnOUjpeNYOr7AdCqKjDxBuZ513kU4axwZWuMvQpnq?=
 =?us-ascii?Q?5lC21PeP4JrF34lV5DGAQgBS3q5b5Ybvq5b5A4d4Dz+JzdSPx5ux6cjFwcgL?=
 =?us-ascii?Q?QGa4eGfP0IizUtpNVmqsv9o4nrUh/HWsPMoNw0P/gdqcB0yl1BjZBzKU7nE5?=
 =?us-ascii?Q?ePjsyIRNx9/0MtTHedKRq5riZlTXG+2ezg5nq7WdBR8o3QHhslo6JvTQmoQa?=
 =?us-ascii?Q?MSJuDeDPhWuu0TGqV0d3tHH04D5DVbPmPrk2HCwiLpwD7eHcrOlx6FDQmKKq?=
 =?us-ascii?Q?IzdRj7iSG59W24vj2e9d0mVZVzrVmQ6qKOuDsAyR7Ww7c2+XsQ9Ne5R69V4F?=
 =?us-ascii?Q?JKwlThoQOKT0CIWc0r72gdOw3j6sa8wj06pHop2tbIV+fcTGQItR6cxzu0gA?=
 =?us-ascii?Q?aI+oA5uSRIHfHS2perUraruMs2Jfle+9SQmaL/4f7SuH9OofwZB509ZaG75l?=
 =?us-ascii?Q?R/sRjTCN7kagFaLJGstln5pTtPTxm0ae1i8LZuRxWlrIvPiCH/4BnsYBAWNZ?=
 =?us-ascii?Q?fXXqdt2ciNvLcKh65lTAjL9d/xqJR8QIkXZiIqUUkVRdBRDn4Ps+051Y6qU2?=
 =?us-ascii?Q?T2rBmoqoq5seIMgVxR5z+N/7O6Sjsk9/fgJQ9jz7aAXlxQCGWvx7EGlpUlKy?=
 =?us-ascii?Q?iV0FRNAvBaBKCVeA3tTlNN3AzyFjXVh+R64IZH2kELTZ3naGOGIAPpgz8AOA?=
 =?us-ascii?Q?3fnwowdcmodLv2Mt3K6CpBbNKKiUp8SJAeFAZ7AsS86mNteVyq8PyyVqdHL8?=
 =?us-ascii?Q?nPMQiveZWnLdCIrrq8qi8Hum5yzKFLVCBumKZlBFZtTgy1hJ7P9Dr2VPZiH+?=
 =?us-ascii?Q?NRHTB/HjreQGs6sPMVfawVFDPBwBXHzOAEFGubQPt5nx0FoFy6Ocuo9ycUPT?=
 =?us-ascii?Q?/xSTCT3vVCo+5FubLINvcwQfNLgkGDfhQxp1q5x/1rC6Jtv+Qb36BjF+ctvM?=
 =?us-ascii?Q?Rsn2hjYA88vtEnzcxqLzJ+StTlctfy0b2++AZ5mk3njsp4NjpSrJPwbyHLB/?=
 =?us-ascii?Q?SATWnA7VD+9YItvjr0DmTtzuGuIY/O8lDvcSsZ+N/JtbLJBGzInZWMuS3ONm?=
 =?us-ascii?Q?/G+ikcJqsyDt56Bp3Ar1Q9XrrM8XvtzfiUWtlYRJalTk2AfuGRMRcPK2fcFW?=
 =?us-ascii?Q?tMUZcPVIsuYqJDkdxY6a4MqjY/DeXsbf1G2HTjRnxqnZQ6tQLU0UzJKexrRu?=
 =?us-ascii?Q?cndvBeGu1m4O1gUTnznIdskGt3WkQQf11ep7u6anLWenbJl/HyKHCufNq3Kr?=
 =?us-ascii?Q?RBSwUKmaHjifpHT4t296DZfjLqzEnz0Rjm/5wLMt5m4lLiN1V7lqUz2nPKOA?=
 =?us-ascii?Q?Yp+phTm6lexMqJecxcK1/8qcEr5CFygKeY6TGVI1KXHfNK9KFduk8Gafv4dm?=
 =?us-ascii?Q?AdGN1/VeqJFyXUUubywDq8JrNQ86kS2eF/5a34QhNLHCu8H/NHRpM/r8awdS?=
 =?us-ascii?Q?n9Mo0PSQjZ2In9z5u4qsKLQdGR0KNydVMXRAmYTNJSg/CsQGKG0hlJzea0vX?=
 =?us-ascii?Q?xYPZbfnI0dZru3w5GoMm6cp4/iFc8fMv4iP2e4pJ/0fdln0llBAiWIkuJPC5?=
 =?us-ascii?Q?JeoG7vJKJQs9lG6P8BxevgKY/2sO49qgQQyjP+PSqv8lSsxH4BlodOTF7FT9?=
 =?us-ascii?Q?auEukkrpTNX/a+9DXtWhNt25adOQZ6S6wzuw1Ue2itU7ASTLBJ4tQGuqXKH8?=
 =?us-ascii?Q?1r5lsCWS2a3t5Kel34uZe8Sg7orW1rJd1gncZrU6k4UDhWiV6rBhQr3VIqf2?=
 =?us-ascii?Q?7tfwSrbwrA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	mtsS2ohgEmrOztW/z6pFhBiHQlIghBSmzvjolWqbglnIwFZgvZrBgLWB74tnb+kW9Y0bKiX5JcVsgJyMDgCdxB1iOzjiTp0nY5ufMB5r3iFqmFegJi0jyWGX9IfLHVBjcYW11jCQoqsq8+4oNOI+NEluCk7xBOX5hkktduJEYtB5eTAGdwvdZ9O9LIADEWANieDTPZmhU9SNSWzHNI7l412QpfQXzBHQ5FbjocNIgPfpoa3cPb+a1pakUgvj9rBn/F2aBIijjUNpyMR4zZjDMUeqOIS+c0h6F4gJtaqPAg0XVfmMyH5s615FmA9LqkVoBMf79GCsLlSrvIh7PLG2Hw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0912e67f-7a33-4bfb-24d1-08de843bfb76
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:43:49.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqpVaDB3s+xMhiYR4j5034mLEzQuw9UU+GKging8wNIvsg6SgU8sUAuFHUgFc+ASQZF3XoHB/OjySuxBQFhqOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6130
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b976b8 cx=c_pps
 a=slyL1VRLEEd2L0tPKscjbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: dsDH8C0-fDPiF0VINV6gowxQobzIUFCZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzOCBTYWx0ZWRfX2S9QfetXEDxm
 rQFOycvmvGIqajmyjWOx5CCxMptZJNHWrOz3z72iBWkY4I9hiQEuFD6aOGmt/NTPsLKnsuPvavH
 VVO09Vz1zEqUBJff2Di7ZQ2Pl9XCoIJCetuZ2f7MrqAevxgCq0lCMB7xLWN5Gk2WvzpQ5SXJ3oh
 4sbB5RK15+4tSiPHtmQJ1UajT8jB5yNZgwuLslVmCvgapggx1jf+/gQq/He0Qb/GOUcgV2ay5Jo
 k2oz2iEF9GiGbhwycNX0WvlQEkQQuTfF0T26souGtyEMngYGOBfVL6hA0ZGAG4RLpaJM79o/BrI
 ytgA2gFG7anx3SWJvdSCu8QTDRJIp6VBqqG+DwdORXzpq1XA8piUr3lKSPmGuvQc4zad0/laE3b
 FGGqufOIxxsWwezq671VAOi86h1DS3na96gnFykXs2OaYonWLgfxB3z/hAkHMTkJ3tM6e/vJJXP
 /la1iiZr0RAFxcXGPiA==
X-Proofpoint-ORIG-GUID: dsDH8C0-fDPiF0VINV6gowxQobzIUFCZ
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226111-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdk.com:dkim,tdk.com:email,tdk.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B92752AD441
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


