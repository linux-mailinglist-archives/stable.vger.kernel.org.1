Return-Path: <stable+bounces-93041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBC9C9105
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B347FB2AA01
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EE185955;
	Thu, 14 Nov 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDSGflo1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tuTsLkal"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB9183088
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605457; cv=fail; b=Fyi2JgiB6/HRdWCzayMowl06W91RQgjQQ0dmbRUnbBxwA2MyKdpXOn9rXqJi09F2/uO9EMECN+bQpL6EfDdVnN4jPld+SYU3hAABj6GlBvcgxXps2VbtsFzt8GmUy0VN9M42c0turQOk9EPn+vSDARRoNf2B05+4q6yDH+6J/G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605457; c=relaxed/simple;
	bh=Awkl7mEj6nNpBufee9OYCLcRh3oQMq7NlAGXeRUb91w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzNKhp4pDrvd7BuvaggcyaACei9IMY50+V+X9/LjuePR8Cs9TIJ5ptqZ2RDzAToYfgs4z2uWXCXBTH5j5DX6xxnNroeg98HObuLQCLlxqVKgKZMBlTYj7zqvbpcSgPp3s5guVMnyeCUgNVgnztWMcqtUv0izmTImnSjFtxM+zEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iDSGflo1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tuTsLkal; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECwwVB015665;
	Thu, 14 Nov 2024 17:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pYKbWLUQz0PnXJZCYqtxgBBAp9tVGXT4UIaQ9J1FnOg=; b=
	iDSGflo1wJ7a71h7rpSAbULTN0T2d7IPrJnvpyNAXF60viyfKWqOPDsCGNVunX5h
	hxhIjuo6E56xM2OUuMwW8d6yTf/+MkJA4SbrvxhrSr1Dq8mHb+A9ahHyzItPBDw+
	ybbhM8/P+wIQD6v8zJ/fVZKbHa1Nm2cC9eC/ANdFQf9M+ySsAtMVJzN8M5yA5Mex
	TEVJfG5ek/4lmfSVF41lNOSMzNwYPeReOfCV48HNssdRzF1gYGy0mLf6Bfy03adJ
	Lt2DJygouvbiY+fIOkFw4aTEMdB5c0p9MSjnebLBkwcg3oT/0x9b1cdk6Yi80dS/
	peHRCF+igragZcrVX6CDBA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k29rd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEG0RLK001163;
	Thu, 14 Nov 2024 17:30:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bfgje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT/OCKZhROMu1DeC/5jgLwsdHJMRWyMAMdzSO+hxtLMi1ZGa2IBsvshRnduLxMdT+HNs05WZJJ3eM3EcmGY4qXnpBaemwZEx6HEVbQhAPRS2WkrS8iXQ9Us9uzFBfHG7nL5VjeyCF1VK4hkxi6I4cesMUeZ0x/uRy70mIEL+hzHDXkMz+WOdrkxh8xcQzoVr0MdT7Tif/XbxsQGe7AEpycronRYE3/VWGPReayg81ruiSs/4j9ksG0g9PdIbm5RhQ07wuxznREmjDtqSBCmsoUEkWFDx1cvQVcHgLlmuUcnqqWRGFjdfpBwQuw3BcU1Cedz8OWU/5dZknq5vpjHdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYKbWLUQz0PnXJZCYqtxgBBAp9tVGXT4UIaQ9J1FnOg=;
 b=cV+0ZwKFSpMYZluMh3fcdFNWW3L+xP235UPrDQ04RR2WKeMrwZXUvA7dfsg0qBsacB8+nktPd4T3uDzhRH2cgYZn0MiUoaBxfiTS7jYkMtwQhGp4lGx1MvJM5DCmdGW9DgdTHfUGjYd2szasef68Eu+z3iZc4rDsFzdjbO6vd9T0grcE0n5q5IXHGstVo20ODbKQcLECPqT9NKxAW9WJvj74TMKny+0CL6gDU2P71KplnjU3ufNZskcEeocnQci0dOsrTTG+is6b6DhlsaFB3Y5NqPuJV6zYReNjIDOnSqKvYRKUlVcQjl5OwgBl4W1OqD62Ztrt4mKb86E6eoR3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYKbWLUQz0PnXJZCYqtxgBBAp9tVGXT4UIaQ9J1FnOg=;
 b=tuTsLkalnb39ryTOgtOqejdKfN30//l0v3qrVpMs5uYhu56EvWMfyGlLccBwSxWszV1LjU9SstXUgW5ygD7lBHFq5N/qU1/GQ/q1X8plOLEIIdQaMk0dyJBhf3QAUVsH/gPPTZAjbMyzQ5LB/HrWf1Y8wuW4x9yQZBWBgDbfhDg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:30:32 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:30:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Thu, 14 Nov 2024 17:30:28 +0000
Message-ID: <20241114173028.731247-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111139-gladiator-wavy-a9d1@gregkh>
References: <2024111139-gladiator-wavy-a9d1@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: ddeccf49-8d5c-457a-0245-08dd04d20a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2FF95/LNx+fKgdL5h0X0DIR0TavnUWUxMytUeRR7xupAEmTOI7c90e/oJKQ?=
 =?us-ascii?Q?SP/p2wxoyoT1N9uwQS72QVqST4tbGPIzp0p0+EY1HhLWSD1aHeiF4geFoUXm?=
 =?us-ascii?Q?ARCDfFPZYGtsf4bTRoE8zbtb6wkhAWI113+LKW3ZUAkhqQyDF/oATJSdynk+?=
 =?us-ascii?Q?cu6PCg1AIt0WXTTUOQJFDGJKtxmGJ0SQiQ66OPpNCF+TDsBck1OSI1jXHtee?=
 =?us-ascii?Q?DoRNNUQHlg3M2Min9zqxEow93bCksAObEWl0vbV+r+8qRP3ZVd4WaAfKIIUm?=
 =?us-ascii?Q?lSVbIsfMdmgGvH8v9xBT4AT9QR1mqTDpwCcMh1TJLwNnfiMrqq9MJjitSb5A?=
 =?us-ascii?Q?IN0GuRRE0ExzGgWnRpvRsuM2811E3EKVIdexZE+imK/PBEIu34HB1hrR51KI?=
 =?us-ascii?Q?REydtXCs8fYN9VUe1gziOI/sPf4StWhHyOBuu9gKHItQ52FOcXLLjh1Qsuzd?=
 =?us-ascii?Q?IYJqFmwsvJMdSrH7HtslfbJ51OWwuC3S4VitpPEeQZrQiwDY2oBJM+IPah7n?=
 =?us-ascii?Q?Ppps+xdZKAa8c2ebGUbVUSXJGXOMk98PWhyLWaKjFCXIs1qtQclFXl11Zh3C?=
 =?us-ascii?Q?yGTou7Agc/Ny9IaueZUNpyLppfcRLLA/JHWHfhTOkw5mmi3EjU1BBjKoER1j?=
 =?us-ascii?Q?Rd9QEeMsRfol+iLOJnkOGrI76en0Okim82BiQI6zHOvhsC1LjorCiSaQwzsy?=
 =?us-ascii?Q?82QHjEje5Qv4SPGYdv+1bR2uKz50B0bHQSL4Fahf3QjbTgZIYI7OCCzhW+v6?=
 =?us-ascii?Q?uVcKgqqn5PSYpYO1LjaRzFiM2rFYhCJjFTw318yR5g8SNa1XHbT+tThH1U2y?=
 =?us-ascii?Q?DoZVKckMrVeuIJz/ROTLLABjGCYvX/TN4RvO/F+g8Ykj1u2m/3pIaiXG7QTn?=
 =?us-ascii?Q?pfwOH6Yg4tu455gZKn7tDHLT+/C2hSzDX1yGafFhhtrdpF8i+lsbUWlp8xyO?=
 =?us-ascii?Q?sB5GhVTSEEBYfDJlY23r/W5ACnIXuSWj020ZMVL0cnTFwnooe37TOzMoNydH?=
 =?us-ascii?Q?OGjuZ5fpLQ3Mfv6mjkoQRElH4/kcTG9FnVa8SF8ORfhYcQFiN0ZQ0REkL6de?=
 =?us-ascii?Q?YFKZvSJQYkon6AFQOX1yQcrWSIVgRTu21R/3nr4XggxXr++lEiknmNlkQOLN?=
 =?us-ascii?Q?b88JqnyFXfn2n/IC3g8e2XQIs2U6ipYU8E2cgc8uMSw8LcKQAMKKZp5Rqbky?=
 =?us-ascii?Q?Ma9SnXFTiLVWKuRl3f979RiIrOs9N1ipeC2oucHVwDe6JsiPkKnblGELyCki?=
 =?us-ascii?Q?H3kry9oANglW9gxsQkGmjo5RsXPzvzlwqgQ0Oq3Cf/YypH23WGGdyrctRicd?=
 =?us-ascii?Q?tJmTbaemJ0jS/aAnU1f7UXWg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAEwwwTUrsQD0tsqgzrB9BkvaURKnAotKLC8cQI18D8QHJOBhppcvCMUu+BT?=
 =?us-ascii?Q?87nRlkiHjs5fqvuyJRQRlMoHRLNGmStkyfkY58QVxQxzO0rGtui7acan+TZY?=
 =?us-ascii?Q?ylFNOAx3tlWjYn4Q4fWkaUhXWlVxZPBTqUACSCpt0VwtNbbNvgBwOaj9xf1M?=
 =?us-ascii?Q?QwSfElQlduZURctC3AI50UsihYzwBWOjfWSncCB55Rk8zt0xNlKybyqnWMmt?=
 =?us-ascii?Q?blXpe0yoBA62ySxlErKcOG+4uGVeZnUob6VjCq5N9hD0hO0nVKmwdWunFrVG?=
 =?us-ascii?Q?abAnoHiVDqEX5VlHF2pvVdHgNlOdMhLkSv1Y1EUzPU3pVY/+7EdqmnEOk0yo?=
 =?us-ascii?Q?3K8LcTWKrHyNzZsa+iuSP+bbAeale+jyC3TtHtTTwc2ycmBKgfEyFYemTKKn?=
 =?us-ascii?Q?Cz3xmGNtUoTSValE15jtRqeIimnmkhU+6SYmikt2KxkCD0rF4xjOzI9oOBKs?=
 =?us-ascii?Q?7xYgbY4fiAFcRxZjjj9VJUD59ZIt0VxBag7qzV7rhf74HTOvUDmIqpwJa5we?=
 =?us-ascii?Q?usAVeU4fLYhwoBS3K+vLeAoxt+rZb0ItDXZmDqZm2kMTRvcSFQP9ys+KXXE3?=
 =?us-ascii?Q?8s8vzXEPSqAu1l1F9r5NY/UIGs/izlkgwkqIdgfCxDHv/X8kQIojh/4oKwBd?=
 =?us-ascii?Q?pTNd2TOMCfVeAdKCmWUvW2tl8QMoNNbBpQmELtOUIyPUt0k9BrCO/FEWjulD?=
 =?us-ascii?Q?2f6REJMLucFEnucL2DaQj489rGNBIj1vVV3vFQjCQ35mLyJiXBjQDaEveTUG?=
 =?us-ascii?Q?vIndYuykz2Qw4mfA594L1zfUnyEQXBwexq//6DzFzn/QaO37Ma19rhTg92Ga?=
 =?us-ascii?Q?aZ2UvVGeODeWRGaaS5XOgbfHRUcBVERWPf1lN9mdCpegmKMEM0DSnAyI8bG/?=
 =?us-ascii?Q?e+4KFdWtdaTCNJ2G7Bn1kVl7VWteQMcQXc6t0sFTUQE3Fv4LazdufL7tXUtm?=
 =?us-ascii?Q?mux8vnkU7EwFCHJ0LmICY0UoWxqunGLZlxm6edCnon8R9W0Jaj/fUB7bY7O5?=
 =?us-ascii?Q?mtYqKVpU7xeASo2tmEQ7UZ6aLRDDfen2/5R3rFIF14xMz5ennitWudpmdW1D?=
 =?us-ascii?Q?0XLOUSOcME34iIbJA1TpIeGcMMTC9eV2yWP8ZE7sGv1/c4pOQefAb0G2znwa?=
 =?us-ascii?Q?yhQGD033NSDEB9fbQHdOaaMJGotlK2LwY5nOPKbawhMMgcNXTbzCHQ6Luga8?=
 =?us-ascii?Q?FpZBghIRLNzpOEHkuJMknX+nWj7A00hTB5g2iCpNzaks5xBffDYo3guD5D6c?=
 =?us-ascii?Q?Rx9TquJfDy09MnGKs24ZrnnmuP9LMYFWUv/uvffHCB+HdxUW96uN9KYksMhv?=
 =?us-ascii?Q?DUqi3yTbfH25HfXQ5X21d72vzOSLkCPASNFtsctohEwB1yuL/bBS1S0Zxk6j?=
 =?us-ascii?Q?+gKrgaVJAuap6Fgp6eFL2Xied2G0Fqk02UBH2gF4OZ58y0kEnPtJraBsftJ9?=
 =?us-ascii?Q?a6s0971VsSS7OzO+8mLX5/imzJWAy/eADR3GBQ2iJ/KRTq8XuchhCGcHwqLH?=
 =?us-ascii?Q?IZK+OLs4SNOsNjsfFY+aqnBzQS+c4qwizWqQyiY4vX8zbMF7UjUfW5fxZ+GE?=
 =?us-ascii?Q?pafbOU8JX8cQvTTDyDENazL7e5/4neyl9bOevhKklH2GzSSukt/jhtMZ9VFh?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ekofcuRYoJwIpq+Rr4BEhUkHTDdQ1pTobaKBFfDi8d/7JxefUswZk7HfRBR4Y2hYTGGI5fDN20BtVzbx0cgD8e4Jg41ms3/13ctsTdDIHThNgJYXv+p0RW+eav2xdqW2tA2iLZ5oQlWNZ2dIidzZtU62d9ghz+MlesRHjTEpYSPletUhLhvoul6n1/Vb1hFgjGkLxTamGlIwx82hkQJMjWWQlMeqMKAcGcp9S029h3miciZ5HYen6zQnOQLmo+Q8aVVeCt3ta4F05FU5KYPyE4l+/KebkIX24LsEh8Ijz8kwkmMSMKkyA0jgxt0Lt0YJm7bUopVR4d+RTlU4iL4Up4ITP+KAyBrT9TlVixQnlRUZsPttuuEi8Xdj4reaJ+ztyqKw3OWtygBaEQCfjnwuCI0G9qV1Gu8cHm30bIyshlQIQ0KWOacgss6Xm5ql90r02K06KTV/oj3+xWZu9FCZkTSTyi3R71DmFW4aDw9I8fidKTBizSCjyBqD3r1ny9HFlp9ooNWU7JyiUZ5yiL6V0tR9J2zheXK+d+N9YYddklHJ54yNhYaZz9SemAOMD6q9xhDU1YY968rou3yGuYxea+6mkU6ZXep7LZCYF29DZQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeccf49-8d5c-457a-0245-08dd04d20a29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:30:31.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgrOpIOVuCocbVYtIU9+poaoMf4RmfWV019nZ5LaHdiDDuukeGDn02UjVCh53HYaN95O1Yh0CkKSV27Hj9KBFr7lK0p01zxtwbY43yyvXuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140137
X-Proofpoint-ORIG-GUID: u4o_2zKfXkb6JBKFasNvPnpWbNj9CffN
X-Proofpoint-GUID: u4o_2zKfXkb6JBKFasNvPnpWbNj9CffN

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
(cherry picked from commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81)
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


