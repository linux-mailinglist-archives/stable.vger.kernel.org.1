Return-Path: <stable+bounces-93527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DA9CDE68
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A4FB23E51
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859621BFE00;
	Fri, 15 Nov 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mezBQECR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="at8foYZX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F81BCA1B;
	Fri, 15 Nov 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674349; cv=fail; b=rjehO6Q0u2OZQHN08Te/BwNjKcfogqG6fOl6v9mW64l95xPXiS5pUwxURMnPFZItgT32cE0gLvyZB5hKC3PRyM3VepUys1nCjfpwGoATVZBtvIkTr38YA4I0jp8t/DMNGpPWrKyYAqSqH7M0g3acMz3Ou3uEkQabW0XtsuFyBXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674349; c=relaxed/simple;
	bh=9yoifrh9O/uj5LEtXOMU/Jj+kHY61eVyJaDqZ5fOcgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhEBEoTL1pdNC26qMqPz0pVxQXC1lB/SXjlBBYboy1MxXZTrwTMlZVa4IrU9aHLPHILZKsVbdjHVrcG+iL5Pz1tcum/CdBJaxquE6znDMoHhGjZucj9YncorYM6vYlMlYFJkR74vMutwT0BzDDdthW9dnUium8JVzu5lrEWWmjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mezBQECR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=at8foYZX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH4VW030282;
	Fri, 15 Nov 2024 12:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Fm96MfUl2UnxcHP9gVllVpK7rAL3yVbYJSzoyNNjI8o=; b=
	mezBQECRGc2IwiJCFxEJ3gs6yyC070s0LHbrgrv32qA/w7b5Uyo6fSGxlRiVsisD
	C26vTakYcNwsTF1/ptBIfGdT5kmBgtIaaN8coicqW3Jig4SJApDov2Y5Jh1tzrlj
	d/bBMrffOdb3Q5yuajai9k1QRuTcA27AaJFuDD3KrCe90KF2N76/66fjkbZVtbeh
	FhddNXpmfZwWaKs/iAnzyYyybt6oObaVOt9wosxNN3wM9PX5EAczcutlgrNB3/1E
	CC8sypgmE7i6c2HAI97v7IFo6Nr8YcbSxFdhlCEkAgKYWmH8xrK8rSHYxvJr4JsG
	H8V5LLNH4GfFLaJIH6bAog==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n539ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFC2HOA000547;
	Fri, 15 Nov 2024 12:38:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbje9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyWv9Z/4X0b1nBEHdoi/4im0T0FtZq04uir+uH8RZVlhlhf+EyFYxlnZr3mRXZzP04N5l/2/NEIIU8OY5gbEg7DBlmlDi0RfVAET3cmeCICUHmLSVe35CCNCQFC/bneac0YOzNjDDGWH1ovVmlBFnxG/srxi15UgNNN4DpwUzk+8q+POoHFpdwuDsrDlayA6tb4sL3BchA+u1PALcLeTzFWN2c4mjU6jJQom0PzCatjzPDfiDl0wNIPgXG27nlVd0UaRioKh8BYk0NFa3Dqm+oA9t0YI8MYAYIVuqwmD2+JNCI3K+zMmVqaYcssXwOLHGaioSI9Q6HhFz9NwqshrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm96MfUl2UnxcHP9gVllVpK7rAL3yVbYJSzoyNNjI8o=;
 b=sWugTZyAefYBxYN2Rb6Po4ZC6Ir8XsgN93XKPn00WHA+fTBB+krUestFBCZXvLJBJu4HbcsJ+wkBFnGhC1W2Ll6bynDiP8A7McNWol17LDsMG1zlYXaEAshOVI/PYCYzwAFuoL8e9fDETrHbjUSNhGBexSnNrlm1cOtwU2sxOgG+WHqfX1888E830lzelpFCjBro63hWQdJW168XQzhz7/tdSKvQxwSQnv5pZ9mKmibcKwkeZjtzawkQxPLhpuh5ynP4hI+VvxrlpPA9U8l7luOcjNqQs6Q+60QksMwCmFddYQT3Nui+i7bJIw9OvwNoznFhzqpQvzovIJOvC0/mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm96MfUl2UnxcHP9gVllVpK7rAL3yVbYJSzoyNNjI8o=;
 b=at8foYZXJQVFfroYASm4HwgTwQGqfwd90AD6j07+Yyb/aLYWMPDUMPMIAfZFe1XzWQKQ9Mz0WOQvLPVxvwGWB88Xh2a7YYaPSSurv6emflcWLIrdUczBqP9KQhE60Op6uLZzjUu55R1lTGhRHDOmZnlmLFUxfUXfE2GdP0KibZQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:38:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:38:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15.y 3/4] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Fri, 15 Nov 2024 12:38:15 +0000
Message-ID: <6dc9d6d69584a326d7de66da9cbaade9ec64e4fd.1731667436.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
References: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4bea6f-0847-4cb0-b893-08dd0572705d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBbvKZXUTYonY97A1LWW9SsZwLZGzPocv3MNM8gBlDCWGCvCTaEn5nIw3cg1?=
 =?us-ascii?Q?lng0aT3qznKTIySaP830FQNvuMRdtD/zBSVw31ZIKIITkkTQpW9Sr3luKOFO?=
 =?us-ascii?Q?ygeij/ocOFTk0ol1TevyamaNDmVKHYNSGEw32RerIm+66ejj0uGqrLo5f8Tj?=
 =?us-ascii?Q?pwiNfGZvmlqRxfVjyejvbX/Ux0RiW1vPc/U8c3KpDMDRadSp3fpASKDFHw+0?=
 =?us-ascii?Q?iKY6vsi2pxH+TYMXhHIzqyuwHT17/bNsrwEpPWLfX45en2cb9d4gU5Nhf0gg?=
 =?us-ascii?Q?sXDCuhdzpW3r7sVDT/2GvaNyfxkSB+3CWuIgMv2sh/0MhIH4NvWA4UrV45Ys?=
 =?us-ascii?Q?p7VyqQolaiOuXGrIKp9GhggnOPb9QcfUMuphwEg+oqOFwa4yI5Ea6zd2iCPG?=
 =?us-ascii?Q?oEbXRfCf87fcBzAQhK4uRRwt6TxWCZV5OfrXGI+JLdnPY3zULhN+IZVQNfR3?=
 =?us-ascii?Q?EJeG0nmHWvW6o98oF0RPxCCMKWFE5Yexlqxn3sIsghiEsLBet0wcQabGZ/cK?=
 =?us-ascii?Q?FRwTkloQj7P9j78q8yoAkOmNusQnY6viqw+thpmwtFY5bioYCYQI8T99jxOT?=
 =?us-ascii?Q?6LkMR05jLx7LyFhqp51R7fzWpF86W7SuEm5CVPhOXpxBO5UW06H6gYAzBe5x?=
 =?us-ascii?Q?zxypor0cOCAyMZf9wuHD+ysQh9v4N5j92irKc33pwiHE/2ulF0BXroTMcaMI?=
 =?us-ascii?Q?d02lYd/BWDtwOh/avo4nYHoCMvVfCZeO74birtUqs5nKhblHy4n++IrkzGL1?=
 =?us-ascii?Q?IOkpdiKVKTdEZWZvkafNLG0DY8P1BrQxDW6Q1H1UMNOso6ainy64VWnFtOsS?=
 =?us-ascii?Q?xDAnC15tlqqswsxD6Zg7j8Bje1uO+Sf6rfkXB8mkRsn3WpmKv1dKVRUrpMgX?=
 =?us-ascii?Q?BImLmitKNS1jPc3noPa4aWW4QvQWqZgM4+/QB78Dj7jhx7kaes1S1CQJs7OF?=
 =?us-ascii?Q?W4gvzSC+ovSjfxvRMgQ052B1hvSbZzkk827Ufy3mTcXdyCqEB/bQ9TLviiZP?=
 =?us-ascii?Q?DdaNqjrFcdZFPPn/3++TVHgIR088xbabGTAv8Trcq5/1Hczg3IgiKEfC/rAm?=
 =?us-ascii?Q?mISKl5NGPqDl6veZtgnz+UWnuYU8VYUhDSvMEPCTnc+XbTKQhM5viMM4K3H9?=
 =?us-ascii?Q?JqWMlLxltsOJFu+AUdtMstr/UXct8OiKlKHyBmbd/HZVJg7JDRFkA0FbDREY?=
 =?us-ascii?Q?SSlzyFh5ixJFywze44sRRN+yTMp3q4zRfkgagGqb7QYGLSNGRE4Tu0D0OOfV?=
 =?us-ascii?Q?2ABIw683qyoGdVtzTNKD1gJ6VAkG4IANDCEdnUKugfwq8Aj+KK8z84yEuY61?=
 =?us-ascii?Q?oX+YsJ5PcVI31i7pyb+gZk2I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ho4h2/o0sU97GKjb/n8/X/12eetAKml0oaIbqL/pTEbV/tJvmbGKiPhRAz0R?=
 =?us-ascii?Q?ycSlVZ2COtReoqxXPQqtq12cNShrrlmfksdghfWSgNQBJ8qu7OuArVvVBsv0?=
 =?us-ascii?Q?KzMz3b5tyNM1hBCH9yHcxK9JfUV2rHC6g5GGmpcUL08EeyX3NVYskV3PD+ul?=
 =?us-ascii?Q?xfEPtM2RPlNrwIM3c3pjYWE0cgjAndUCNW36mh9Q8g1x5dO5cKgEtYNUJ91b?=
 =?us-ascii?Q?aU+hpdJEr4Xblsxh9OGgpxLOc+N1JuwlJeYaTel8EEm5c/PlgJpeaQu3DfF0?=
 =?us-ascii?Q?BEgkJS9ixo6xa8vON1h4rGyrp+ILqFSfvJhhTijf/aBVPZWk5WIsWc266HKJ?=
 =?us-ascii?Q?K8SBaD2GmXVcuP5jbzHUJy/7qF4/Uw8XCBde8UCBxl2drTuoI4CxiEdTGg2E?=
 =?us-ascii?Q?Pilj0gGt6IXex2FJbtbEXKsVFqS4veELctgw0tGMQaBNobO86y2okBXn0QMt?=
 =?us-ascii?Q?FdA7BhMunlCOyKL2sH9iXATTHuZ7l9lDNeqxG5b3hjvjL+xs/Up/hKF6dGru?=
 =?us-ascii?Q?hfExkau5QpeIVmOltoN07elKpnUmV78FKM0VWKUiNag7BVlX1DSMU1XNq+EF?=
 =?us-ascii?Q?S9P1VIZOMDHL32y6ODWAWGWVoz13vFS+Lru1VI8KYZESvC3bZhKEIcE7SuRQ?=
 =?us-ascii?Q?HYhGTn0sOs+FCUln29fGzsYufV6frrN3gyVBYRmGciDOuNpDhWD9EngaQD9D?=
 =?us-ascii?Q?SPHfzLT4WK6JCaqQs0R2iPBsPH0qCYbTn42DQ9zY5gxPWJ2qeKt93jyyx9u5?=
 =?us-ascii?Q?i5CRQ3mIGSgZalglaQHa+dK1sjQvH5VhofKIc0GBnhbyLyugb5K7/f+Fh+/L?=
 =?us-ascii?Q?u/FKdhHLrFsP1YCaaDK0m2GDXnJeTXfgJccgmpQmSlyRcvRUuPylGMQorecD?=
 =?us-ascii?Q?bsPK3vEsY0CG6L8XQNphL495g+T8uIAM3IskqzKoDl3fxbyZtC8IAoEWDHzW?=
 =?us-ascii?Q?FnOvsGNUGTXy5JzpCkyFyNd2nEKjc6T79sqtZkZhznb2r46wfz8Rr+TEAri0?=
 =?us-ascii?Q?X8TLzcIlkQK8XxtEKWBX49h8+4uGdO9iPZ9bSLGbpFDD1o9HczAGTht9m/qr?=
 =?us-ascii?Q?hhr4unwe0AdCvod49347l9ro3m/fI4CKBCh+AmiYJU58bpcTTTCQKP4wYT1u?=
 =?us-ascii?Q?V/j5JoCd4Q+203X1BCtlH/EY7RbqtOHuT+Ac7uiBlD/BjHhNRwXQrHEIuddI?=
 =?us-ascii?Q?hpTt9X6E2j7/vcYquk+fM/EPlPLNiDWLeNOuvzR6RsZzLzt9qNVuR44poPL2?=
 =?us-ascii?Q?4t+TSntnq/WkROyj+BN8375WXfQrceTw+7PMEEV3peIrUn7sfxOycGUzogPE?=
 =?us-ascii?Q?HgX/mlcgQ3V8Qv2MTcfrMe2fJ0C2eTHpEQHBwYaUKxjJg7Nrzm0EjEHc0s46?=
 =?us-ascii?Q?oEE+fFAfmtTKKTxPQ0vqRib8XMREpWWqiuz7g2qhhdbAoBJw3TxAYUfmrco5?=
 =?us-ascii?Q?JofC644NLYCZTkI5hSXaMXbzz7kdV67QNzAI1b3B5dIo/6ig9jGYukNFswRJ?=
 =?us-ascii?Q?n21THooh/plvMFPgCPyhIMZhB2PY5p1wNKv2UODCDay0BfmkPvwkXkOlBIMY?=
 =?us-ascii?Q?BuhXpCIyVPrrMy0vLJejnETG+9YYK08OgLXaz+wrHFucKl/6GGLP3r6OhyEi?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	284QLRzBHg60yERX2fvxnARsLLdrXxeEJxvxdBsAQd5h5JphhtAlxFamsXC657prpGRaMznEs0tNi2A0GJw6v0IrWKa7rdrkSI461NgnU41Sm2ZtyFyuq4FVg/VFlbmcO/HOffIbgBiYXlQU+qM7Ud9PAVmu8VSCgxOBxOReIwNOd58J8SqyJsiYgkPM0YQ6+MTHUFGgRK5gGhS89JNGX57fjZ2jEuw/IWL4U6Bsd1EvptVjHSR0xhC3sTkZG09n49B/JXlPXlOy4huDcAIbO2q/wgU20M/DLFSUOXXBf/Auqw4rpIWYKYSvVBAPpd4ioSQV9x393D+HmlKpAKRzE+UoUUiXzFnZsrFNkdirylw+Tiv/rF6T7DQgAb/OIr3OIeeKcO0BqlCwndfzLfQyrsrJIIM8f5Ad0j76ybJgmB2nXPP4Rptl6iFem6qTOTuLfA9FlhemBfz+0SND7Jq5+txkP9ZV/wcbccOuaumK3vkF6hcY8dxHbT1fNR4kgZ7UcUbu0rD5IM2DSikrtbFL9Lm7CXvjsAZVOyR3GHBXnecQDpvbrQk0Z5h+OqJSIAkI2cXcbbO+sPpW8D1q5kbS9Oe1Ryij3kabR+JtxV4uoVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4bea6f-0847-4cb0-b893-08dd0572705d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:38:42.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHqER+Lh+PzR/BThzsrOcp0b9sZJaX25HZWadk+nxRB9/jUdWqd8ppE5MDb+kitB7EKx2AscrwFnUgf1oDH8k8dYK+qUHkacvD4+ZpJnhqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: VpUPWNeS2cLght2ZiN1sqJPy2YAHzn9L
X-Proofpoint-GUID: VpUPWNeS2cLght2ZiN1sqJPy2YAHzn9L

[ Upstream commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81 ]

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h | 10 +++++++---
 include/linux/mman.h          |  7 ++++---
 mm/mmap.c                     |  2 +-
 mm/nommu.c                    |  2 +-
 mm/shmem.c                    |  3 ---
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..56bc2e4e81a6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
diff --git a/include/linux/mman.h b/include/linux/mman.h
index b66e91b8176c..c5569219de01 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_vm_get_page_prot
@@ -151,12 +152,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index d19fdcf2aa26..a766b1c1af32 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1466,7 +1466,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index 084dd593913e..8b5c95528b00 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -906,7 +906,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 	/* vm_flags |= mm->def_flags; */
 
 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index cdb169348ba9..81da2c3debdf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2268,9 +2268,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vma->vm_flags |= VM_MTE_ALLOWED;
-
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-- 
2.47.0


