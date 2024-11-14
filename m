Return-Path: <stable+bounces-93038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C627D9C911E
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218EFB34720
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E4185B78;
	Thu, 14 Nov 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZ0xOaBG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ag2PbGgN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585451C683
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605233; cv=fail; b=Oo4hpEmgPS914Ws48CXYzl2NTWk4+SLTl5+f7wBP7u6ZQjxRhVenvTnBZvED7nlYxYDxtuoVOyPuW2ErlQdev43/FWEKDZqvHvE3GOq8543djlix/fC2DiZMvGEmrzGUNu7fdBaWudUEcq6Byvh6YwZRmfC7ydx3wwU84rhGoxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605233; c=relaxed/simple;
	bh=vJneffvn8HuAKILNxOBrlHA/jEUNX/4TwkvjfBBtNoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgLn04iDeU4AilR/oIvcRpjq0KqwfvDrGR6pnaTysDpiKzixyWr96dldXIj9mrd/XCexYmNT1gu0UvTGBCaoaOp80u4ir4GdDR4CkoAhaTL8Z5gaGJjwwWBk/CDNELiThxj2/rbX9mjLouAF/4Vh23V7lCSKbjVJ0Vzi73iycpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZ0xOaBG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ag2PbGgN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED8n2x002273;
	Thu, 14 Nov 2024 17:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ukfJmNZSrToN/UJxMw8DpVwJ2trfRQoGfQvnB2/N98s=; b=
	NZ0xOaBGYJfRsIN2C4Qp8BCirAypXBinTw8oCm7P4CYOWEtaqvQFYBLhKNHtJr5L
	gv9IB+KRInO11WZx4ueukuMa+waADJoStwSQUJOlhKp7jCxyrevFBHJmxBWJ/lfX
	5oQ8ExxVoYfsQzpZB9TNYd5hbWFaZjr52WYw3LV8a2Qf3/MNDCAq/PHoLIRqahtV
	lWzs9+cF327iZc1yuZtiXruvEqksyGNIzgqRspaMjjZGe212Vq1fHDM1gAWNiLTn
	yvuhnFkG6+Ww32rp7KNrWiPSvBvvio/K7/HSDhM06eIHP8Q3XAXH9yfZZPnVZVWl
	aM0rzXBdiNUQuYjqcMRF6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbhv8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGdBFD025918;
	Thu, 14 Nov 2024 17:26:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b4mdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+IV+L0slTFTaCsit8VrJNhZ+ViO7gBNwO6zEFCn9lFFsCKUOCpmWGAqTjEq6+Bhyl7+LiBUCHPsqPJk4oX3EaBlCwAdSvXgo2yD5+LCTHvavtFaVKyCNtMLvvaJpCM6PFriU0Tz0U29UWLx/Kd6g5B/sd4pZcHn800FM0zH/8xy7ho64nqttiXq/uGHP8yRApoT4fd3Mb/ELBi0f/6LILhxglFw300ynizoo+fl9mTvv13zJV747lk6QP9RHhM2FHMY+TiBfIv0OkbvodlDP47JC4qeIKlzeMZc4eXRpJBJlUvA9T7Y8r3b+d01sYBHRUJ0iA1juvyHgcCghoon8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukfJmNZSrToN/UJxMw8DpVwJ2trfRQoGfQvnB2/N98s=;
 b=wk5De3LkoI6EB2eW6DdfbXuuuIN89XEokXbVGnE3jVsGdION5pn2englKLp4Cb0dVOxXf6Xn16jIUg4nN7JYvGnSKrw8cS9k0Y/buBaHdJx+KbppsMlxzx40UFw4XCMASw/x0AflpDIiALKkT+ezn0DKXFyzAPuH5m11P9m4gD96UwUogQpLbgJfe14SsvuEZcgSTe70g7YMrVsEaQz2ipHYax9GM6+chxMyu8scf9ofWFIrFG7ZVEtPTELx2HLa9OeRfQN/r4fpZQkaXS8gD8l1FgU0R7kJEzkAOM+MzCYA3VXkA0jy7eKCXZ1B+Dsnq+M0srbJzQNhTpFUMgdbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukfJmNZSrToN/UJxMw8DpVwJ2trfRQoGfQvnB2/N98s=;
 b=Ag2PbGgNaW0PEpxjUXBWKo33eh68BVn5gRkXpYsNLQqAAbAx/X0J75xkHKsI4LG7kJFTPWcNEN8n/AjtH8ZDG/aVC8EtkqbFn6DfNgRL1z/1G08nqeCVzW6I70KP655CiWFoIwEtHlGCNXrT4Drq2cBkIxRi6zLiRB+cCzL5iVg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:26:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:26:47 +0000
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
Subject: [PATCH 5.10.y] mm: resolve faulty mmap_region() error path behaviour
Date: Thu, 14 Nov 2024 17:26:43 +0000
Message-ID: <20241114172643.730936-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111159-powwow-tweezers-dc64@gregkh>
References: <2024111159-powwow-tweezers-dc64@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: ede26b7e-177f-4c04-d27d-08dd04d1848b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4FUiUBgbA/0+qbXqDhW3enz0yu4KsXfY1PdMsO2B2KWb+Fvu5+bRvaqow5R?=
 =?us-ascii?Q?w+H+Uow6kICNBmCyvELFI8dGgCsu+oe/uLNwvbAkVxuL3j+de/43PgDbMfL+?=
 =?us-ascii?Q?r2efEHCa4Nr7e213AW8QxJV/r3ZL/FL9JTWvpOtfa22bFn/qXXHJgLznWvK6?=
 =?us-ascii?Q?Ol/cWv8cawza5Y7a7AvHL3+rDLsIYH34erb4q4CYAb57TuXIYj0he88HF6oL?=
 =?us-ascii?Q?an0kMb8ar1YP/OFxXWxTvGziW55gQP1BRYn47JsaMIzG5cvAJHvzAAX+sXZL?=
 =?us-ascii?Q?eLKLyCpAgn9/8n06Z+nx8DqE6MkDTarhcXcLLyMCkKoRg5IXyRKkOIQBJTI1?=
 =?us-ascii?Q?m531TeAr7nnmfubyBSZkG0NzigWrXWxQ1zmxeeMyPsQBq82UTbLg2Kbx8dNI?=
 =?us-ascii?Q?FsKh5w0CnvoRKWVr5QcUyY7Jh2d7eyJBNMHPdxV9u0wkQXJBTl7h17CpfzJD?=
 =?us-ascii?Q?V98d0cB0b3rgePBLEo1RAGKNdLgbEkIRTAJh+vgrAZK9mP0ve14AHXy5sN9h?=
 =?us-ascii?Q?SwG36vd27t1WBLJHrZ6ZxIPtdvizUIjrL7fpmgRB3jvklR2SNLidRyRZtXIS?=
 =?us-ascii?Q?bdYhVRhKlk2Xp3oPjES/OG26NO4K/M78lIEf4BEC6H98/PzrEtrIW9IMOIrJ?=
 =?us-ascii?Q?mxgjWMy3jUnZSbIVMKkVsZ26z9aG6U5Ug0pnoKAN4VDMXrkGpLLa15BZJVSN?=
 =?us-ascii?Q?5ZivEgshaebd0Z24GXSL9LTIze6XSRYbywc11ZOIcvGY8xM7kW3xpk5ne8m3?=
 =?us-ascii?Q?cbGW0c8u1PaBLlfWXTmhIYwODx/R6DWUDD465UM5zicRQYJftdV7r1m1WGoB?=
 =?us-ascii?Q?rGiabOUJAXBwXGO8w+urM88FwIS2bNcX7V9GLAjUt2M5c31vgKVqplibOvNg?=
 =?us-ascii?Q?QWkRTKTem7XUCwBN/vivIf16+zFyJqE0lnIwtTU8ZUlT6mDkDb+Du9HWD9a+?=
 =?us-ascii?Q?ROSXvIjVjwN1b51wmNEOgjmzOyOnPcxvBtJX79fC3L80+JXvRPxD2NDnXNyg?=
 =?us-ascii?Q?AG6AplQcGPqVqSw9L3h/LRIMprDrSNrSbX29yTD7qcMp8T0jcY0S6OJYbKgs?=
 =?us-ascii?Q?p9E5UrdY6koqOZUzyaG8jomT3aCx08Y8tQIP2hLsW/jBEIrQxEybwiswW00B?=
 =?us-ascii?Q?iJ4ikfW6LmqvR6LwueeMg9CZLTsaXonlpeiAFMsfnvgq9tnTo/rMsWjrc+nK?=
 =?us-ascii?Q?fQxMC02z2UxB69cW1unQNvsRbyJ/gIKSmvOD8PeA+UxuduALATQO1KgRLvpt?=
 =?us-ascii?Q?8E7P7lNrfYfC1nOzn1bMd5+Af+kaUSMOsjJoPRIrlFdkdom+RiBJToHNdiTs?=
 =?us-ascii?Q?+2zypPg/itqSAhAwPGSQsD3X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oht4g46p99wG40Fmss2QA8W6+8Eg0WbZEIX3ZfqmCbZ+HCXMml6LgGrMtymW?=
 =?us-ascii?Q?L72mDq/YKaBTNliZWiPCDlmftYLKx5cl4MMRGRSWD6O3559V7+42SsCkzJF6?=
 =?us-ascii?Q?RDWgJQd2qk/z0Mhz80B6Rga83ZdoAoaXVRRBw/vfk1nTjnnxpES5Q2aCpslx?=
 =?us-ascii?Q?ro4rk6k5gFnxL9c7YG8soib+JmVs/aqJ1H0eJUCbfBdHJAWvvOgE9jF8nxY4?=
 =?us-ascii?Q?YZNZ7/JYIDz1utSHd4yk8qlSeTNJEn0OlPwF4U3cZtq4MY0BGJnWAmR+se6O?=
 =?us-ascii?Q?Im2lZDMwReNud4ld3C9iQBThAKzcrFx8UiiLxGABrwxP2YjeFtpRTVBTCJKV?=
 =?us-ascii?Q?SttuzoIp8hb4eXR3hImkgk4Nb0QyIUkfqeXAqXJAh9sjJgqF+kMxPmVNHx23?=
 =?us-ascii?Q?qHL/8Bv5+pmWzV/vtfnNZbmJMqrl9lhcvBp5etCrnMKwLHuzfpNWqmythiLe?=
 =?us-ascii?Q?6wc8T2cMvM8HROUDJ+wrDLBhdKzpRFjiLZVoLSXm3yND3n5NYGWAL/WBTeCS?=
 =?us-ascii?Q?VY7hf7GyIO8QMrldQ6EkW+8LGrtq0Cbp6BzxjYSn7HRYz/Tp80pn+IZKPyII?=
 =?us-ascii?Q?21AHI4dQLGvhUXPtpon4oGCUKdyMziMiD9P3Il7z6NFtgrqt4z/JsX9YTb7U?=
 =?us-ascii?Q?SRKpig3pGMNh/Irw18k587sZ42K0ripm3mF2KBDmUWjzt6D1KSONMsRIxFEo?=
 =?us-ascii?Q?0/4MdaiDuaAEc9noNj6shv+Nd2sOiUQGcvH2bOe7aIIdhjn9VJdi5QQrPla5?=
 =?us-ascii?Q?WCIiykXgbl2mZGs1MRnhIkD8LQn61uQXmrgazsPXVuqedrRPGBLhbYVePczW?=
 =?us-ascii?Q?6+uRwntC/7djP52LWkuSbvkHveCNPX+5aq40hLcAOLCqLIaguez5P9LJuDb0?=
 =?us-ascii?Q?xAZenv4cgx0xxkaqSqWMkI86xTC2lu7TiceyNTPBy6Vu/4fb14G4n2SIZQ5K?=
 =?us-ascii?Q?6ugi/W/dIu5y+7XY4cEYY6M8F7sy21ltmMjgvpMao8b6j1RoarZxffqhMouG?=
 =?us-ascii?Q?BJmy8CCNymVO7ZVWMW3AT8csoH82peOH+nBJ3/0CdVUDoqTDbDGqiNzoud5E?=
 =?us-ascii?Q?v2moRKVL0bWVZk2h7MVRquQggG5nd6IVTeeWTHQrgrS4cSQHlP3YQiCMcJwJ?=
 =?us-ascii?Q?EWazFsSfYJYAQGSsWKEpYt+U7BCc9u/26MN1srmEhIyivRgcATilNdxN+6rd?=
 =?us-ascii?Q?lPQ2H8d0Byel94+278lUZroLhHoUGoQ2LCyEqQuMLCtsblXgYY62zWI4Y5oD?=
 =?us-ascii?Q?XHOyE7lMj3E4IjE5RXsY8KK0IY44k+G2xXTmdvwcEyDs5D7RBW41MvGkOO8+?=
 =?us-ascii?Q?Cd7POT/L8mPa1SKbmuoQUMvgPjCxuSsy9Li+8RdSGhgB8PLQo2Ws+U5yP2fw?=
 =?us-ascii?Q?5nK3NVwwwSQkjh1ri41R4Bq9wob57d65rfI69IRlvroKdYtZ+zsveo31MTQP?=
 =?us-ascii?Q?TPtwanvr0P16pUVJvmfYrVyeUhWOkVCRdJ6ee/pcrSecyNABSxy+wf+2DAFa?=
 =?us-ascii?Q?9fOAfxpPVJ6oM2C4KRIWdmwaKFWVOtk606r8U/RiD1LX4VoFxstKsBzok9cb?=
 =?us-ascii?Q?ipQ3UzDcn1hoNqOGs9fTeNyoMF6bas1qp6zSXPOJqj1eBMf9Ddck7iSDqHvA?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JqTAGMhydBHhQ1f7DgsRQoW+Q1XCpjujgU5A2Ce0Eh0aa9cUbk+XBrFUI/dXlfBxIsdzrsKelI/1y6vCfjLf9gr4NSdJ0uapERmEVlyosX3yjnXCAGmkFsydVJFS1Wx9dk9OlHqtDbIvFg8MmtCOwWud5UkG/9gJOQA3glDp6R3FxFbHjtMpS4TPLtsl0YZDAG0Bh5WAbVmD0gZesiaNlT/b1ty2BnALJkgosPaKGR/E/6YCT8tLn5L0gDZaTEcUkglXEvC6q33cs1kemBf5l98stZTL7cmfPh515IrfgvkHNiCeTXPaVI6GY1K+e/ycKI6kkYaLKOJmzR/G15LxyiJ4OyNKaWJB8UKmnJDLsq31WAtOSt2hpmmePRLfpbik7+csnEG5RN/vpoTPyU4UWwa9FxoytCUQVAIJ+FTBklqj1T10v4pY/8Wqa7aUnhnRREfwx0y8cVTMZhkAPBwEFgQkCJp3/15ELcM1pWa4ZBR0ThIgyyIFOsszDCKbNEiv/WY9TUrpwioQMTZ9LsiyrSMo+TVPJutCmAq8YEdlnjmCEOUansqYAjjjQ5QLAwCMhcmRUhPGIRrCdcAcTx9NmTRl+j4ldljEZxJ4lpP97Xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede26b7e-177f-4c04-d27d-08dd04d1848b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:26:47.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0txu0+jbGgsvvSFOkcJLcFZhc1vAmNRox4LDSehkgNx7jvuHf6BoI55Jt0zs4Mu8wvP/fgP8FMx1u1Wgc3rSiIr5eigs5SMDkspLSMwfE3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=878 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140136
X-Proofpoint-GUID: 9Tb0YFs9lij6HKFMGihm5ZRzVcupZilf
X-Proofpoint-ORIG-GUID: 9Tb0YFs9lij6HKFMGihm5ZRzVcupZilf

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
 mm/mmap.c | 69 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c30ebe82ebdb..9f76625a1743 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1726,7 +1726,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -1795,11 +1795,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			if (error)
 				goto free_vma;
 		}
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto allow_write_and_free_vma;
-		}
 
 		/* ->mmap() can change vma->vm_file, but must guarantee that
 		 * vma_link() below can deny write-access if VM_DENYWRITE is set
@@ -1809,7 +1804,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
 
 		/* Can addr have changed??
 		 *
@@ -1820,6 +1815,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
 
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		addr = vma->vm_start;
 
 		/* If vm_flags changed after mmap_file(), we should try merge vma again
@@ -1851,21 +1854,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
-		if (vm_flags & VM_SHARED)
-			mapping_unmap_writable(file->f_mapping);
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
 	}
@@ -1899,17 +1895,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	vma->vm_file = NULL;
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-allow_write_and_free_vma:
 	if (vm_flags & VM_DENYWRITE)
 		allow_write_access(file);
 free_vma:
@@ -2931,6 +2922,36 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
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


