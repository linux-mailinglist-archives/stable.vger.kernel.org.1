Return-Path: <stable+bounces-113986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F7A29C07
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BD718889CE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E662121504A;
	Wed,  5 Feb 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3T5rhL2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lUlHA/69"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF16215040;
	Wed,  5 Feb 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791680; cv=fail; b=Uh4rismuU7jLAhkW0zSVHoVGTDQY3kMct3wmlwuO+C05OM3laPaZ4+yO+HqC7VBCr7yS5PGBv1EQ4p4XxJB7sot7wd4OD62FXGn2URUefu2qUdBxaCdN7+aF+hYn8CXbenuBAEXnKmNbrkKjNJomyFdXbSeDqrJl6E7Bc0VCAZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791680; c=relaxed/simple;
	bh=A/lww63gAbJ36By1qDriGL55xjOPx/za+agM/z8YIU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fA0+/vQ1Sof6c5HrRGoqKPzRAXN0KeGfQQZQhjnYIQjURwG33naDPmKwLGHRyVSqeA7g8mpGucpgvLkWvXtCcqLvkCNUndNnLKIE1+Cvu4k4oRFaQb/4Z8JBJjOrgQYECst57wZWM3yfwt8Pk7HUo6Lm7RN94ByMuJHrmchT+a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C3T5rhL2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lUlHA/69; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfjLf000962;
	Wed, 5 Feb 2025 21:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lb1tIoSG9mYXpE/yj3ONZrQBdkIeoQaU2ibWOtJtiP0=; b=
	C3T5rhL2P9+IRnf0uBTz/KDVwfREur+/JOd6U8y4BqZ59E2Hx7msVMcBTAIRElx8
	Xevyt0EaJ/Ff9w7wiqU2IkKcL34zxLy0iTfbMTpYYDV2D2BoHxzHIx7hZygka3W3
	etcea/ZcaMyOGuqu7FJX3kQujjYACgUfYl2CBEQNrp3viVA+K+Mf0z8bsrexYEBc
	wNBKo9bMTSCo1MkjgEqkff5Fs7zlFCwEGOLQafyvzr5CaV5NLnGYiCzC5JIVaP/6
	x10anZ7rhfi2xZ25pdT5G/EMTMkRt7RenmPB7yRIxDGuBlNDY4vHHjPwdFgueKDn
	x5V/AqlkbJJ4ENPO/+1yxw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy880k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515KrVDp027880;
	Wed, 5 Feb 2025 21:41:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p4yv5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5p0yWIKsMM8lGPppZ/NX+MFVcvsvBKnP39lt5fysQpA0L7wBqbWS2123lUF6zamzbdElJzc8eTJ5bB59LrxzvdIjuRYTQc/3TdaqLFstpLtzzGvfzrwfK85IUGhRwNUv841xogIYygZZRQV6xcCA7vrnpdYvR6rzr6CoS2Sk3Tiptw68LIjyUY8jdCXSY6u/gXdb4ebFy5PK692QaXMVXjOJ9zV9e9mDlZGc3fFM7EM8h8ISs6VJbiWXy2a041nYz/Dkz3dvcCA2pxDVZNtuvuv+iTBQnsdNN9aMb6iVdsRlGZ0NyRCImLd8fPCAB0RLjGMdr/OamrGh3ALwiyeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb1tIoSG9mYXpE/yj3ONZrQBdkIeoQaU2ibWOtJtiP0=;
 b=vH2x4VxnZuwtTV6oCaF6aA7ZfSWwR89hZo12SYpQvsOGTtMV5iJjZZ1U62g753AlWAaHdTsJTIew3jtjVVIVqs4j1qPEnyWNLTBViFpcXFMXzv2FI4UEEesgitxctpN7ph7E34WvLJCD+w8fk19KMiOrUXlBXKDAIx5uqqiMi092+l6S3BuDhJVu2RWyQNz8NPyRHOnqrS3mo1HW00FhxvMMSAoYw7evjMm4krjIWmfvuQZg4NS7ty8lhG9ausdOkME1Ol4kQMcCaRmGFEcYzAGFdLck0LZN56SxHDBD35wQucXsa5QWQRA+KcvVsHWLoy/iTwk51shaZSgJ/5C6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb1tIoSG9mYXpE/yj3ONZrQBdkIeoQaU2ibWOtJtiP0=;
 b=lUlHA/69zxDtMkT6nn0grPL6SHB/s+1dF/DyDkClSFQ9SmMKhPZ8wxt3rW2ILVKgFGZsrtELBPefkFGGSubIuqiZS0+/B6la6mMhYS+j92FjYOi1LOAUwbz9URy1w36AOJnRQF67oy2MAjU2ZmCvEGhyIxgaz+4wapeaIsteK+A=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:14 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:14 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 21/24] xfs: update the pag for the last AG at recovery time
Date: Wed,  5 Feb 2025 13:40:22 -0800
Message-Id: <20250205214025.72516-22-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 587b4b10-0969-47f3-a226-08dd462dd047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKArWwxFVZQ2Zz2pWQN5zpzUbGwxWmqqhlndlpCb6kk5HkMI72GdBFbOpntw?=
 =?us-ascii?Q?+rEVsDcBCHoMl81oPsXdg01ywWIc7dpLNfAPdtTimRtlPBweb/SLaSK0uO0k?=
 =?us-ascii?Q?cX5NcVqkBwori79SSdQ2BfcdtYtOgrlx4BjTq93tr2elN4daBaZB4ADplkPY?=
 =?us-ascii?Q?Riz2QAU5ytVk3jXI7U4k9XndxvOSelG4fkac3Rv0GNsTNdr1uF0UH7VzojV5?=
 =?us-ascii?Q?xok6rcU4+DCO50Urs0pKktd1K5wHrll1NxRFistzFTzQNeq7RB7wbZYx6yqS?=
 =?us-ascii?Q?FWKwz/ZCWOqGqSlT7WMztRvGFCBHlovkdNmq5976rO5S4kOQXxMXFDCWHphP?=
 =?us-ascii?Q?h5aRqjEWp2weVnUQC/v5RaooNjqj0vVk9Pt6g7Lk+Vd/HbG3ygN1KFNBJ1S0?=
 =?us-ascii?Q?hUuJMBd05GxltkAXNC6Hx1c0le9wl0jkz1d3amLnV8xkbjdz5nSE9rh14ArV?=
 =?us-ascii?Q?BQLRElb/w3P6jfdi36IKdeyoVS5yelse4kLlOH7Y0UUoRGLQ62gXvsjMsA90?=
 =?us-ascii?Q?rvhGsyolM7oMWOvz9y8nchTgTmkah3oDydaJBWkYd7dbmDNxPMUQINRCh2jf?=
 =?us-ascii?Q?BSYW5OKfodtdvastdbAiIU3/z0blTLg+qzPr2M1WJfWyBUOIER/xSr4HcDyP?=
 =?us-ascii?Q?fCwOjj7qsxzx56LJ86zIswI27K3+MMISXx23dz9uq0QflCWG0xjQYSFS/7aA?=
 =?us-ascii?Q?Ct30dz9/Y6EchaTMKVIBXBE/zs2KQ6U3cGks8UGcjJDBUs4lLpbEM908JRAg?=
 =?us-ascii?Q?Ac13YZUCgXjgcNZOGAxswv92iOO8f15BwIh4kO493WF1jB2aqXUagodOlHBS?=
 =?us-ascii?Q?ZarFtb46+B88TMYd6w08c3PMdSfJ8oYHWbDEJ/GRlRYa8t8aH4ICzuRAOW/h?=
 =?us-ascii?Q?j5fsdolflufVLgnVRwD6FCNlZCP2C7I9SFUNwjYwcuQAcTAbKlNGqkZSZrh5?=
 =?us-ascii?Q?z2CpWYTVWBxaCS7roksvPBlJ600a1WESkyL7hVbnJXy+Q3tEDqDeNFg+0PWY?=
 =?us-ascii?Q?FWvz/1p+cdNpoIWP/M9KCoXB5NnCIQgDx8akGlT39uSBfwZkrKobVwC/kmiR?=
 =?us-ascii?Q?LE1MPtTUHFFxrMI20SKJfxM2Jjfn2XsHHTZdZdesT7X+varbt/G3mewnHDhM?=
 =?us-ascii?Q?g64CQD7CdUclhrezjC7yb7GY4fT4BdJ84bZE+X3GMv5gkbQKrxY6GSo16N1X?=
 =?us-ascii?Q?E+OrJLRjWYI4puIjIqUL1NXDx7cGRX4STf30lc3NVNy7Kk+IqiVJF3y8zA5J?=
 =?us-ascii?Q?Wvbodw2nJrUMJUXfdgybxZ/CSB6orBEFuq+3dgSz1AD9KvVFbkjVFBhU2taK?=
 =?us-ascii?Q?EZksTH4iXAbYN0BXbj8LOmhf4U+ARA0+Chf6DheZ8uc3ZovIi2ISmnKtHQ4g?=
 =?us-ascii?Q?7RcBYoFdatNdByKHL9Ekk0dVTJ1d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGo131aUVOL+WApwBeD2sb42TNRSSq1vSUgmk2qoyZeLa0Bx4aF9PNa7zlJu?=
 =?us-ascii?Q?IhtmlSNSAl7hIGb1yw9h5gKv/wzn7hW8acKSF0YBwpeqTcKBhupDfQTQVX+e?=
 =?us-ascii?Q?FB/hjGO2GF1ZxODXKGKSRuxx4IOQxhkI1LeblFkJPl7L8i24ax2boWi5HEIX?=
 =?us-ascii?Q?bYv0CslNdOQR2ED/pG+n9VDpEvALeI+2sYD5chtBPsHpg5CT15sXWA6Av7Nh?=
 =?us-ascii?Q?iiUyQzwz22tFpo9PEQuLfDYqBkr7dOytjrNLaNh9MrmBjSmJeoUiFt/GKCrm?=
 =?us-ascii?Q?HTt17WzO7rXlfrRZCtBlxCMq/W7cI7WvtU4sXc90ZUiRggVVmXdzjDH6LHNc?=
 =?us-ascii?Q?eLJ3KGyUIkxoEh3cy5HInyHQLNtJzYH34KOvhuhbtX5lJZRDB0LabxtW5hyW?=
 =?us-ascii?Q?PANkdVr0GaOQVt9W4QZEPPt/S/BBdMO8kpSPGVPSnNiQMvP5WVzrrqMh5amB?=
 =?us-ascii?Q?nJdLCHY/rJ9oJ24CJWs2xTPAodI2mTKgUEAbrm/z3ognGK/vOm2KfbNNlsTm?=
 =?us-ascii?Q?qgOdHYrSrUqqOO6Hi70Ds+rEyIc6Z+LgppDHqmQpkCnuD6GrDyu9gukIYg2f?=
 =?us-ascii?Q?DDO7wntHwyOKby2kqHWII7yTJR41ELBrpDZB5iIMVqG0782KAp7eVk4Q4m5P?=
 =?us-ascii?Q?VKlqBzw40XCn84KUd/gWcmvHkg0IBRlmzikeLPrf3eOaHS8gaCiC3Y6ldcfq?=
 =?us-ascii?Q?CATPVtAM/3NCeM3c/tSBCVHgX+CV1ZosjUAKWdr22YUUx+6Xu5qFEBaH6Xd6?=
 =?us-ascii?Q?WfZvVZwDX6dh1e9mF/E+aQGJgpd33hNCqiUPIyRlAPOZySo2sOoxrqRUAs/y?=
 =?us-ascii?Q?FIynh2KSI2+p6MXiosvLdAFa+y2briME67aiC4OHr0e17cZ6R4I3un4FAPfJ?=
 =?us-ascii?Q?qOf/v4AvjafA3JcYD5NsMQ8nsKtNEYFdvVwpyeYtl5HqjL8p9lSPE7ouX7Vd?=
 =?us-ascii?Q?7Htv4Z4GZdOlxJC/rWSBOYYMhozt45Xbb7POBAXIBnw/bM+I58+LNOxmwokF?=
 =?us-ascii?Q?hTDmRsGYdHowTs9bZZxahXeQ3vsmCu0oiUi9xCAZ123caaZFAtnDsnTkkGFc?=
 =?us-ascii?Q?aFLWepaLUXkso7b9t/0YSvLWOzidyTjJ45gk9nEx1wd0vuCWF31Iv+oYmja0?=
 =?us-ascii?Q?i7OZl7Kqj4qR2P+JXkJaWuF7GcQd4cLi4Rois9JYu34EW4D5Qstr9Bo1dCug?=
 =?us-ascii?Q?/eqF+lLf06K8QRVqZkxxogfIXNn8BqNuvtZ5ObNt+fHuEuDwknr1fgRu3zdh?=
 =?us-ascii?Q?Tpd0ZpC4u7SJDnwTZRGwX/nGsFD809x/DsxSXc3KQhM5m2vhz41ZMRBsab6K?=
 =?us-ascii?Q?i/7iYfHqYD/nR16sawTmdE5YAMVFOjstvf0nI4YDN1+O0cCqDsh1jsEoNLOR?=
 =?us-ascii?Q?NA2YAut4iJIUye0hVnuZFTYjh9NKcSDAApJYnrrzQJNq64K35oDGc3/Bc0Xq?=
 =?us-ascii?Q?2JDDJqO1SgwI67gZCy/halg9w14Gc8hiT/hCvcfNkmm2l3OG18dGxNHANbcA?=
 =?us-ascii?Q?tPZ7KPjDS274P8d7Rm/BcksGZV/cv2oj2tBcem/kSHUi2X7n7AbEVlkoVLgG?=
 =?us-ascii?Q?5KERS3BAO5OzityzHqONtSynVxTK/epYlaVFlDDI9v9LOnaNVWuBAqaz/6v2?=
 =?us-ascii?Q?3MOGuUxZQIyMvRpvq7zh+VQuJQdh8mtaxWXP8B42SC8AI6Z8aUxejOk5diiB?=
 =?us-ascii?Q?ioVrOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hsOMOYyFpsusU9LWKdJGadPPstBTbESgBN8jsdQuIhrQR7hFbMKsclAA1t4SLBS/q028Im/Vx0B4y3TeHAJisml2TQnEXl2Tf+40i+AySNu/5xm1+QlyG+6O+HN2RtYJ2BKUXyQ43zLTATcTwKXesoT142nTa59uMLqMEH2xJ4EQm8jxEZuWnU24XZivq5Mzpd6+gS+vdaKd1wjgR6tGCD0dTyHrB6mAekRgdcdCSFjXMCIL3kTA53gFN/QwLSUayJX21NkqSSjAg1dMhIlWiLOl3J40xjB9bkIr9oXIvSOT8UMvmYsny0yFRMoq6IoBLoR2enV3gk+hvdvaM/xPEC2uL25Awrbq+46Alu5g/ufXcBSbvIjN6EtHmLHAyTJhmHrZJQeOCwFkyzb5qEGPoT2Sy2I6HKhDqXq59XUYxP0sX6tMTpbbFcrqhd9itAsnHDTiqItKdDRnbM9zTNTiNBwSO2N+9wZUDGLEjmAqwDC+FPAY5bNmgfcxoXVS3yUzHf3hiNz2kViEHT0he/tmIL285KN+VdqfLG1AxXSo8e2ntjntvxs9hQvWI4vcAyHugztw0xgwprpLlb2UoNJsv64fjJgv06InqEfoXvhg62E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587b4b10-0969-47f3-a226-08dd462dd047
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:14.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4iz68LRYj2LUkEk8ncn/M4BAh47y6t7z5SIZL0hxICtyDNBK7lhjSrtKsAa0RagzW5a9adcbPLIS9xPjruEtdaCME9v8o+ElewnsqC9JWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: frXkz4jMraQBiVMi0OQx21CACg-nDhsh
X-Proofpoint-ORIG-GUID: frXkz4jMraQBiVMi0OQx21CACg-nDhsh

From: Christoph Hellwig <hch@lst.de>

commit 4a201dcfa1ff0dcfe4348c40f3ad8bd68b97eb6c upstream.

Currently log recovery never updates the in-core perag values for the
last allocation group when they were grown by growfs.  This leads to
btree record validation failures for the alloc, ialloc or finotbt
trees if a transaction references this new space.

Found by Brian's new growfs recovery stress test.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c        | 17 +++++++++++++++++
 fs/xfs/libxfs/xfs_ag.h        |  1 +
 fs/xfs/xfs_buf_item_recover.c | 19 ++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index ec875409818d..ea0e9492b374 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -357,6 +357,23 @@ xfs_free_unused_perag_range(
 	}
 }
 
+int
+xfs_update_last_ag_size(
+	struct xfs_mount	*mp,
+	xfs_agnumber_t		prev_agcount)
+{
+	struct xfs_perag	*pag = xfs_perag_grab(mp, prev_agcount - 1);
+
+	if (!pag)
+		return -EFSCORRUPTED;
+	pag->block_count = __xfs_ag_block_count(mp, prev_agcount - 1,
+			mp->m_sb.sb_agcount, mp->m_sb.sb_dblocks);
+	__xfs_agino_range(mp, pag->block_count, &pag->agino_min,
+			&pag->agino_max);
+	xfs_perag_rele(pag);
+	return 0;
+}
+
 int
 xfs_initialize_perag(
 	struct xfs_mount	*mp,
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index ebebb1242c2a..423c489fec58 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -140,6 +140,7 @@ int xfs_initialize_perag(struct xfs_mount *mp, xfs_agnumber_t old_agcount,
 		xfs_agnumber_t *maxagi);
 int xfs_initialize_perag_data(struct xfs_mount *mp, xfs_agnumber_t agno);
 void xfs_free_perag(struct xfs_mount *mp);
+int xfs_update_last_ag_size(struct xfs_mount *mp, xfs_agnumber_t prev_agcount);
 
 /* Passive AG references */
 struct xfs_perag *xfs_perag_get(struct xfs_mount *mp, xfs_agnumber_t agno);
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 66a7e7201d17..c12dee0cb7fc 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -708,6 +708,11 @@ xlog_recover_do_primary_sb_buffer(
 
 	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
 
+	if (orig_agcount == 0) {
+		xfs_alert(mp, "Trying to grow file system without AGs");
+		return -EFSCORRUPTED;
+	}
+
 	/*
 	 * Update the in-core super block from the freshly recovered on-disk one.
 	 */
@@ -718,15 +723,23 @@ xlog_recover_do_primary_sb_buffer(
 		return -EFSCORRUPTED;
 	}
 
+	/*
+	 * Growfs can also grow the last existing AG.  In this case we also need
+	 * to update the length in the in-core perag structure and values
+	 * depending on it.
+	 */
+	error = xfs_update_last_ag_size(mp, orig_agcount);
+	if (error)
+		return error;
+
 	/*
 	 * Initialize the new perags, and also update various block and inode
 	 * allocator setting based off the number of AGs or total blocks.
 	 * Because of the latter this also needs to happen if the agcount did
 	 * not change.
 	 */
-	error = xfs_initialize_perag(mp, orig_agcount,
-			mp->m_sb.sb_agcount, mp->m_sb.sb_dblocks,
-			&mp->m_maxagi);
+	error = xfs_initialize_perag(mp, orig_agcount, mp->m_sb.sb_agcount,
+			mp->m_sb.sb_dblocks, &mp->m_maxagi);
 	if (error) {
 		xfs_warn(mp, "Failed recovery per-ag init: %d", error);
 		return error;
-- 
2.39.3


