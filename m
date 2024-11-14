Return-Path: <stable+bounces-93047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B89C916B
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E085D283241
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC41925BE;
	Thu, 14 Nov 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BTmyRZ9L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DSlQVe72"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F9190073
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607699; cv=fail; b=YBvj2uJymRw3dubsaeL8c5dxIJ03k02xI21xZ39PtFWIBgnXQ46/jXu2SpzopkuxynBxexOMCIPoItLHFIJ73Cnj8ONSIp0BpFyNUXTzMD3Q6PNPjNtCLnmlQwQCkkWnY682btpFY8BrlJFDncdRqZBmscChbv3uFSiVYimNqn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607699; c=relaxed/simple;
	bh=Q74m4EMdTrps6zXQ2VwVuXj+yzgdaE9whuXTLYLWyNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T58uDrXt0tFikAAx2SroHk9lrIobZXVwEFk+vG+5Pnw8VS9ZvcCI8hZF9MBnRvaGfNNfE50a/9tKPeccVO1UVfXulHzMevyo6wOW1oGKmJlK+jmyUbmW6prRC6Ibse0hk6YfElDYOT8Y1tF3xmDY92d/aP6g8xIq1Pfyt22nUGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BTmyRZ9L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DSlQVe72; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECSjdE008280;
	Thu, 14 Nov 2024 18:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gMzsGP2inJf8HpUUEJxnx9FexVcCYZ0DTLQDFkDrbUA=; b=
	BTmyRZ9LlCrZK2f5AfwyB6JiNCQAIAzVzo65oYNQ5VXnhd8Jddy+fgP6aEJZBM5C
	BWQSBDX93dXg514iXHS+99eTEk9RBvUp/Mk8LxMrqqT7TZoow+bQxZdheqx+M/Ia
	i5ZGR1MvjLyfuMvOfuXhmTOMWLUcbqo3kd8tn/zOTCp4ENtJd69rJSPkFBdW2Jii
	heuHadBXGmQy4jniX0rMc2pg6DvZL/ywC396EXBhQlmCwdxJ9k0xP+ltAVuy7MgD
	BqnU6N4LQ2lRfGmJI+LswmX5itsKu4HqEpFTQA/ETIGAs1h530l3jNF4p47L9CUY
	w28DiCc0qz+x3QL1RcTrSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51v38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEH52nd022776;
	Thu, 14 Nov 2024 18:07:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1ns9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlApWpm4q3+1SzBTNwfK7XeWEk90Q1l4z6PIIQk5RCgOR2AK265EjB6n+SuFisqsnPyLSzIKGIWBb8NbBCxOB//7mbggUqwTDgU+Sfxa2xd6dN7+3xv6N75o129lNICImHO4jOHOQF1IQwO8XM49crKbCIBZ7H4zC5Zm3wRofOZr7fkgGfE5VxRE6WVji7SrkWNxGXcU81Ly/+p07aLSK1ZeWl3A+mL8gs4y0Fl0835wb7AiO2lFyFyIAq4xwjKT2P5gM+cTzcui9exNDtT6L4S/8trpyU/sdNLj3AMRxlC+DHbV8Z1E/Qp153C+M0eJ/WHhDPcHd5h2iwuyUCu0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMzsGP2inJf8HpUUEJxnx9FexVcCYZ0DTLQDFkDrbUA=;
 b=Uvf/vs0uNwAuud1ZnRXMSjWjhWoffEnmD2Hwl7PK9w0RA7sUVB6s4Uysya0d9965zOXWOH+dLnAKp/0eAiUTrVZPwEp+M7NqEgkvDgsVHxERDV7Lr42crzJOVGRWiB1DOjbTg7GfOC3DQODvQvAKYHBg+UtSvgZ0JTXTzZB4tR42w9qDiz1DDbTp0rN+ZW64ew+UaJXhvvHXWrv8OIVha/uhEyvTSAEVG9P/q0F9IT0FObXR1qcrICHItp6pWfetnombQawk7wYhHGVhbHuhwBFtmuGaCExRrCPeNEPzyyf6Gm0M8omTxdAyr0WneAYpXwVA2bOZdltvcw4tIh8PjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMzsGP2inJf8HpUUEJxnx9FexVcCYZ0DTLQDFkDrbUA=;
 b=DSlQVe72GvqJXDQsslcQZh+NXcIDZDxp8jc50wiL+GO/L4xrfM2Xrw3hIcWXSF17DtTwfS+XK/PrnT845qSlBf7DZAPDr/Ar6vWiiw8mb3wqLGXzHX3kmKenGEgUY8uxFxFIVrYQ3c5488VS4qIw0et2fFjti/b0m83OyFSs/X4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 18:07:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:07:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: resolve faulty mmap_region() error path behaviour
Date: Thu, 14 Nov 2024 18:07:46 +0000
Message-ID: <20241114180746.807229-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111150-kinsman-t-shirt-f064@gregkh>
References: <2024111150-kinsman-t-shirt-f064@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: a38263bb-db48-4890-2982-08dd04d74001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IuP4ZD1+79S1C1h0ddBPIAT/1D/fq6iA+1VSZuNGWFODlOJQzkj3eov94To?=
 =?us-ascii?Q?rp7B1v4MlQMuqNAD2WwO/jGpNBQJZfbOnCvRkEttRIiFrdQ5ZdzsOoMgwDTz?=
 =?us-ascii?Q?ABERkJeYyXxA3G/21HsDPk5WE3ke6j1202m3Qh+5ddtZf5aP7EI58PXzJocF?=
 =?us-ascii?Q?GfRfScVJdj3CWBVfEk8TLNbw0HuJOMkeq+mz96sH7yslvDDwD+Gx3oHE9GYk?=
 =?us-ascii?Q?g/bxFg+zoNOhJwkvHs+jYOoWYiFrXhegyLv5Z3gV6yioBElW0x5iXpI79WXq?=
 =?us-ascii?Q?yxd/hicIMoLwAECwCXrsxmFE1gH78sL9uAde2Zn1kcRqHSYp//alHhU/tqJ8?=
 =?us-ascii?Q?XCxC0y6NHDwKdMW+YeCZcL0CfO8MOQ+CkanjknrWpzhHl0jaz0ozxVDsluOI?=
 =?us-ascii?Q?vgknYEtjmeKkOoKpTm5Eyg8dmy4zAPnnsWAE/DlJibuwzWBaaeM9HyW1owuY?=
 =?us-ascii?Q?NzlDv65RjlWT+dC5WkmOD1qZK0In6abRqCmiVX4FpVy/FTEJKI/YH9aKUgR0?=
 =?us-ascii?Q?ytQAXGA0SbQanGQHjncuueKtmLsQoXCfwZ5oKuGrmg5706V1qs6iIXkNvChr?=
 =?us-ascii?Q?nhPrXJIy1X+THNNlQKaWNU4gljhwJYyMDauJGzZ7YVPdyQL5OEzRSrEKtAZm?=
 =?us-ascii?Q?bF6wf3s3bkUmUjaAsrjhg5FCgAdmTQWcwgPOz6mkeDGhJUSZkK2DycYr2PDC?=
 =?us-ascii?Q?jA6KFqFAdziBSpSAsTQ+bmLmeFW+qGNui6oR6n13iyMQS6YfzRL4xUgPUAxz?=
 =?us-ascii?Q?FIoYIMZv1MASS977jm+uW36qOCu01eseIifEhB6eYpMhRToVWGGLDgih/g6d?=
 =?us-ascii?Q?UfZE3m+r3Pi6z67wtNoFegB1B9Lvk0+ZsqqFerPYpEgsVhZOpHqGwOAiqvQC?=
 =?us-ascii?Q?G6D+YLz9aP8Sn21xunOW3QAr2ES2XU56m69RyDgY++fhgVz/MBEKANkbk/yY?=
 =?us-ascii?Q?s2FbHb+vTz/e4AzSccAnexziBJoX+gBAMmulPOhfC68e8J/OxCPgDbFFWYrA?=
 =?us-ascii?Q?MsLlocQDyiM1yg91vAl8K2IcX1ccQZkL0N+Tku5I2Zo4WU/D0nVoWN/3o1dy?=
 =?us-ascii?Q?mrBs1HUoPkklIS6d/Kt70/fNSTk6T0tcEgVWIUz1FhnEVQqIHvaPuyOblzLh?=
 =?us-ascii?Q?LXz6UGOTd0y9vLEMboY+vbfwQGqrHf4BMGxdU4bVWu54Cnhbww8zheMJD2vF?=
 =?us-ascii?Q?sp8226zRAO/FOPAkiSdfO27zBD1f0JUwLKV3RnqT9sVJG0U8NXF1MJ56A6VN?=
 =?us-ascii?Q?Kwc1t9qb/W7SkRaT3YVfnIbdmcPNigckZ3M89BEeaRVEYHNMfU19MGJriA3L?=
 =?us-ascii?Q?cb2PIU6dgL0zH3nAV6QUEBjd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9h35vMjYKL1OWR3N5NZK1u3b2QthgI7dMozB9KD7SVio4lz81/T0oB8qOGcX?=
 =?us-ascii?Q?Siy/AKZXOqfRKMqTkZTpbCbAVqZPp9z7Rxmd7/QTyR4ty0NvJ0BF5EWfG+QX?=
 =?us-ascii?Q?Azc0LRYW4R5/5wo5GQvgtpps8w5O1UbDA8pBgRVyQB5G32ynCG5w1kO7nBgZ?=
 =?us-ascii?Q?fCgLbbEJmDA1nKKZqzX0zQvnNhSZxuTy4N1dlu3IlKJJLTn5+9CLKMMCKfYu?=
 =?us-ascii?Q?yOQdZmwLukYrRrBj9rzLnE0jIKZ4GzVGeh2tOlYh0ldmbc6+i6IUFLnmKIlw?=
 =?us-ascii?Q?U6N+SUtlQZsecGLwZOAPW93Y8jBxa39VMmjnKLSnsQqZFmXgFVZEGye1nddY?=
 =?us-ascii?Q?DOTwPDsHf1c4w3Fla2foolVOGHM5UcjqgfydEqSpTOutbKTwAky9u52aqNzo?=
 =?us-ascii?Q?0Wsxod+yX2hWj9+cXLzrp8k2pLbgBiCYE34NQ/o0CqPBAxgZMSYQczKdy2H3?=
 =?us-ascii?Q?AHIbyI5ZymJulS3wkAzTOkSJWmWNYk/PRK4WkI11wgn4cezzFbFa5vN3PANv?=
 =?us-ascii?Q?f0baMHghwW3mGGdpLgW22F3hUubBs8j+V/7dZNNfqK2Rxc4+nu/jtOqh/IuX?=
 =?us-ascii?Q?c8g4cRWMfP93CRqPPs2TL07FvzD+rzRAJNUp4wo0MTDLupwwY8ItUqIi8Gc2?=
 =?us-ascii?Q?NtbbNwE25kK4UFpf5p9Xe4Mv1Humy9oL93RdtCawzaR5HbRBiRMHYikcQ3+2?=
 =?us-ascii?Q?9Z9IUcYR+H1yS6B8m3oxFXtCDQ6778QXDbD/8Z9senDgVIb8TvYBmDV9wLps?=
 =?us-ascii?Q?zMVuuE570Y1s18QJ4Uo4Ww7R+gCkYxYACDni0n39HequtTIzUUhDnTHgSFFU?=
 =?us-ascii?Q?Z3/MYp4SjjXgKaqMVCg79mn4sSOCtGtrjJ0ofWAWwF2CPjHudADghcfZVrdu?=
 =?us-ascii?Q?M/rm3WmcuaeDbQdRh8Fqpp/4vvB+lrnFG+9fa+UefChy39Qr1u8nrsau3J1J?=
 =?us-ascii?Q?D8U+TIQEAdzmlsjod+n3CopDALed7Mj5XFgXNT/LN2jqbyjccAjyprGc+wBm?=
 =?us-ascii?Q?rRHe45QGZl28U6GdblmF89JErtXyMpDPlW9wcYLf3b8IqOXRI9rd0HueebvL?=
 =?us-ascii?Q?d2W8qwbnOSWuf5lEguu5tXGFhNYTPOtERqetkpAtarZXUvLYhTOLkUaRa1kz?=
 =?us-ascii?Q?I36khRToPjBhGOlYJBTPdTIdw4kLWlRmTVur+cJUuUUQ28FKBA0gL9M7Nc9N?=
 =?us-ascii?Q?JuCXN6uTx8qh2RzprHq9/eFNIjuF5ysLNAUCy5eYOuwSCBANKFNjytxe+e+G?=
 =?us-ascii?Q?lk74QZzGWPcv+VvkVeBDFj381X8UxgqrL927chTbT/3zlnBEh6fl0mFvP1hR?=
 =?us-ascii?Q?earnikew4el4WtyMH2bvp5nY+LJVFfYRlOdCWVpL+qSvCAg6zqbxzKI+gzAI?=
 =?us-ascii?Q?KTGU87y03Fjxl0Q+SQ/n3ELcVg48rYvt4CXK40UzyXSafk4QnKkZGRVtT0nP?=
 =?us-ascii?Q?t1t7EcGujY7DW3w52UpiVBAJ/uVt1rFk/1ugIq702Kt5TX9s6fcVTMefRTOQ?=
 =?us-ascii?Q?LTUDhn1omY0x9b4NVI20O7BxMIXH/2voChhDRDThogJlf0d813b0+nsd1hzy?=
 =?us-ascii?Q?Q4OwFhzLt84OQN2PUsKTAobzD0AwvucV3IeW2uCu8jRVDgoty6YD1U3yMH6Q?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mH+qmyuO+t17CUkCXH5Kq0fQ3MwEJQWZaLtlxQqHwZ4kfsgNOaE/kIjBQWk6ItmvE6p5nj2ZZe5e0gtmkRliwAQCW2edLE+8gFaha/LI/4ko6oVAifAtrsh1CaEZZ3R5Ei+xPuwt29/YDPoiVY9E8ExNCI//sLGaQpjqS0n0HUbWxk3SzNxYfoKlJ1ZxM2MoCUs7HzMdNQDQI1RZBs5wGE3JE7KIoInoPvBTzbSpyFuIiDhCMHpi55bsFg4io0G/pNGRfjaI/ci0irW5wZ3fRyVdZKpGtTNjdmOoSjG82vrXB3PlWrSLceDAEfy5TTWa8lxR/cf/Op0w3BEtLeHkERobBMS+w8lXSQDwoBF10jYRTM0z0HSDL9cH55qF+3bEY8vWvlq6jc1adxqZ3QfIyxG4uJPQpwLafqYgrE8uCdNwUs0wD3MVmKf64RcBVIQpb+qK0z0cOAFdrkL/OTOcQyBpaOPtQ/MlUhw9CZ6yWSjETkOzo1Un4wfjQKh6UzZhjkTSTlnIxvEhgxnFXwCu/ZT+WBl8J0vq5ofHBOS6C8n9uETWCHVpIwjk6wzH78g4G2vwo9zODGUtQHAbmaV0fihw+iHc2GgfoMoEblkVZlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38263bb-db48-4890-2982-08dd04d74001
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:07:49.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9bGfzlsnh6Ef+zHdxcpSoL0AvtbU/X/XP1W9Ck8UeYuZBrvK2TRLGuyfdzFEEfLNn8b7RjmcgNyemS0uEtUwFzBb7ttDH19ikzsnZY7TCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140142
X-Proofpoint-ORIG-GUID: y70ZxsfIbktpsJjPKKqBTmdMnkyPylUC
X-Proofpoint-GUID: y70ZxsfIbktpsJjPKKqBTmdMnkyPylUC

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5de195060b2e251a835f622759550e6202167641)
---
 mm/mmap.c | 103 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 322677f61d30..e457169c5cce 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }

-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;

-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}

+	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
+
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);

 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		mas_reset(&mas);

 		/*
@@ -2792,7 +2794,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 		}

@@ -2800,31 +2802,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}

-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error = -ENOMEM;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif

 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
@@ -2847,10 +2833,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);

-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 expanded:
 	perf_event_mmap(vma);
@@ -2879,28 +2862,54 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	vma_set_page_prot(vma);

-	validate_mm(mm);
 	return addr;

-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;

 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
-	if (file && (vm_flags & VM_SHARED))
-		mapping_unmap_writable(file->f_mapping);
+free_iter_vma:
+	mas_destroy(&mas);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
 	return error;
 }

+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--
2.47.0

