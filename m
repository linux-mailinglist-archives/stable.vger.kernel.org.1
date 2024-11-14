Return-Path: <stable+bounces-93035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7739C90C3
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B15C1F235E2
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4D189916;
	Thu, 14 Nov 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HY5OzxfF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ey3QGrL+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C70170A1B
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605224; cv=fail; b=J6irktdrL/z2ck08fjZW5gZNBYiGczHPAg4eNhrLe4Dn2WAngrznrQT3Yx4ClTMzU+XEwZtBDos+IcvIWd7dXO4HsIkrV8Z/SjE7F/U7rjVDLNNZPvQGwH+58CniaTLeSus2b1vtZkJ7+SENNRMjCqglWfYfjjHuJFRzTrWn/J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605224; c=relaxed/simple;
	bh=FS2oRN3Vix5wfIAXkCYhy9FQGk8UI+3c32D7a68/VMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k1uvTTf6MazZBYgsp/tHYlW8ZtBb9KZAKI5FEAbfsJrXtpOfBnJa1UDz/1P9/lHKUMC4LLSMrUmfnBy06Pq+Oanv9FLNscuEN+X/yxq8RpDtAVtBWeKeZWDZAwvCIPysAmBoBILvFD1Ty2vxc1fkKSvXnJBAr8dzkZJP8mzYxI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HY5OzxfF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ey3QGrL+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEB5RDN008313;
	Thu, 14 Nov 2024 17:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4TCBPvMcyt0RtNePcq1GGO4DnmO1GticmFtRU7yWr5I=; b=
	HY5OzxfFix2xdeazIkHoPZzOFLco//pOCJsjXyS3yp3T+/cOW95xr+95VgokUVhC
	DL9G1MvmcCepjuXmzmI5xo1afLtZ2DmwALaETjMx+079OOCz3SD08fN342KhhGy6
	VLJoFtH2+XsAM7tfPVwkV0fM4VlIhGIOu4pw06Zf2yGTb2m+Fbk4yFMciC6nJOx9
	RrkwtsXpiRf220MdWG/h9D5snFuwExbW8A8dVo1bYNvgR6tETu63ekZN4qINgH5M
	entxeaZknxPooLowPOvJtU6GopO+S3L7clQt9NCn5QUeCWSQrxlAzD8Gb7EI1U1e
	lQy+Lst/aKeWnSFM1qsWGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51s95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHBNWN001146;
	Thu, 14 Nov 2024 17:26:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bfawb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQdQw7LSwonrzrONM+1fVkH+iV5RLe2A1/MPzM3F0kiLN1Ts4w+X7QqsQMNWr+4jdVmdHB+Fu10GpzTD9s3FySWtNwvYqkUcB4YS2eXLtt1huhOSID1MirNrVcNhkG5f9sQiLO4bMSVUCCPq0b20hSQflWKozKI2EQpu7khjvV+/QJUvCKxhC//AbpeUF5AQYajO3CVThy9lUaSJYDwYLOK2lTkkZx0hU+6wmuQPiXpRHza5T21YgQxQWqm6UMk9gkj450wMXssnkarmqm3JcGtcekx33lp3jZXfdkf+VsD3HqQ00oD+J9VC3W86zkxf/LZjGYZ+CeLRTfGTDdgIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TCBPvMcyt0RtNePcq1GGO4DnmO1GticmFtRU7yWr5I=;
 b=e4JMFWHdqlWle8qy8eEChUBTapLOV4c0zfm9x6N36/vKpDTiAfFljan0ZenSegMvgN1I11nVOVC/RWkj+MJA2bw/iGQXMgQFG4JQFUDl3IYUniNMZqbI04oMP94mBOXxhKvZs5iW2nTafUfqdgoX2Caox/y+Zj+hwzrnK6iHFe1avwtLtnm9zrR4bhOetcB3hBoYSpIjH20G4osOQLJqaVzr2CjdXuuprYQMJGiwrVrsRhYw82UPgj8bJTOurfUYWsU431G6j9JG3AYwKnD7ZVV1mr86efWZD+yHqwla3xYsoGmlR74X8QiFMV9sTew0eo2GkL0504c8jDNBT2PwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TCBPvMcyt0RtNePcq1GGO4DnmO1GticmFtRU7yWr5I=;
 b=ey3QGrL+1gK8GAgQlNsAofCwA7f690qptyZ7jr0t3dSu0QnWjHxd51Dl8u00Q1Z07LkVcAe9S+5FlB4zqZWKJ0/gZj7HRGERBq5NhZu7V27QkFzg0Mu97mP0Scl4Vo5NA6kqagcSQ2Ek7ja+OjCamVharZ7zsqt/lw//TO+/3oM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:26:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:26:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm: unconditionally close VMAs on error
Date: Thu, 14 Nov 2024 17:26:35 +0000
Message-ID: <20241114172635.730902-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111157-muster-engaging-dad6@gregkh>
References: <2024111157-muster-engaging-dad6@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6299ea-f12a-4bcb-35c2-08dd04d17fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eHVucaP8XjzpmpxlagC/x6ZwOs4xffNmb4YFU4wiKwyFqbRGxNBsm+zWVhGA?=
 =?us-ascii?Q?q3uBe0szv1Ci4aSXFaJk0Jhlyfdj80OhqBjg/z5LxBY+17iw2PJhmajZM9C/?=
 =?us-ascii?Q?Jbja7NEASkle2zpDbY/4dZa9StQFRLXFeeeB4Tw9X4xwigQg+SYxqcB2chpg?=
 =?us-ascii?Q?VGgfIfHv0Us/9okNp6emy0KoM4Bl6Kqbh31UM18TDvbiNkr5PuNjeDQVBrxO?=
 =?us-ascii?Q?xtvU6gNgmQM9apf+a+nEQuM+colu5zQk1Tl2ai3VyRG86YtGzu0oDSx8niwy?=
 =?us-ascii?Q?7CIenk/MESnk3/E6m07kTY2Q8/BNNjrkT26DfpXLtnOYwoXNOViNnAXLn4Yq?=
 =?us-ascii?Q?00RFrTWGFpoKVd31hgvkz9618junZ0+GgGGwV+V8XY4evxz3qjM9lGb26FUj?=
 =?us-ascii?Q?ffSY5xhV/ihyfd99RxcJSBhvUXO+r7BvQzZPJr1uBgDmPJDBljfovSh0JpkK?=
 =?us-ascii?Q?qIg3LsU+YgAAswq7HOBBShHwtNFYEsS6sQXq6or2tSNytsJIYLP4kp162cWS?=
 =?us-ascii?Q?3Y0CJ+VMnqJmoxK94fMPGfY0xx07UwK9PESD0baOF9ZcWhSB6929HwgETw2I?=
 =?us-ascii?Q?HSL+yNgsvE5LSpQ0DRIjg1G6tz02QL+UqYmbRBXorkw+hhXdlq/pan20OOyQ?=
 =?us-ascii?Q?KdD9EekSngb2qUXBO0I0/hHOmUM9yVGfOE/5C8VXbMfXZ/WHk9IC56+AUZj5?=
 =?us-ascii?Q?REpTv4ZSpOKHhhvEo5pt7OdmIURWwWorrepi6SQeD4UiAqOQX5DeYOnuOH/j?=
 =?us-ascii?Q?zKYGX6UnYbxOX2ibUmK6fOsoXCCzgZe3ykhi5+YDJ86Wcfx6qmn/T81t4UWW?=
 =?us-ascii?Q?wHaCqX3wr/JWxSDGLnXhidULoBUwToV/TBO1udb0q8u6T27pKM8wHhBH93N6?=
 =?us-ascii?Q?HIawi32mDt6baa6Ky873xuO6LZ4okwN2FCd6oFrfWEtfSL3hHxTcDEEEWAPV?=
 =?us-ascii?Q?jBqodnOoPSbXCwKqWU8Tpa0YSmAR2OMpb4hAIFLFAf/3n8zWjJ5zyqJPs1c/?=
 =?us-ascii?Q?v1cg+vx7BOGwehC7aYFsnjOlGnfEvi1w6DViiajD52xtKIQX7JdA9tVGpte2?=
 =?us-ascii?Q?rVdX6ZkM8cbII2QlIU98KHGQnkBLSUXH3JbtOayUOtXW57oCxgPVz8JXExNS?=
 =?us-ascii?Q?9mdwMP7S7SUat3YYu+HCDhf3soyw4vj7zZ4h2bVYHNxmZ4EE/eNJ8aW9DsC1?=
 =?us-ascii?Q?gLj3McdYvJLifagxS+eeB9axPvXw/eCs8IbJtkKcpoxjFtkwdV/54rEqNmVL?=
 =?us-ascii?Q?ktEmCuvTidz4AY1jorjoERWlUb0v2mCApVwNX3vJjT0NXAkfru+PKy+NPxDN?=
 =?us-ascii?Q?mazEOP7YmPdw2TXXiGvmT4ZG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/gOPlVXWUqYnoTc+10cbsN5x/GEzaiLPE4m0fydUGGvrMaiUiU1I50gnRRg?=
 =?us-ascii?Q?A+lKEyMziEbuvSnQcYzaHFRwqIqc4zxN15gkAbrCAGGBTjnPwzrlqS0QBEQo?=
 =?us-ascii?Q?KSb/flyEKFh5UhZpmUHu2slPJvJKUCLERbmrFdaPqb9+Y7R0JGevOj+NwSHX?=
 =?us-ascii?Q?wtAJezemroh1EhtFuKF83lVD8fHWH3Ev96y1fX1Y4F08xHVaQ3MXi6CNnstJ?=
 =?us-ascii?Q?/4jzUsG2BgjcZ9rNqgut1a4+BwlEao7i50Y1o8CeiwrGUP13P5TwqLkAiCwP?=
 =?us-ascii?Q?NZKQNObQgN/TBiaJsrAtOnvNEtjUqO9dD5j67d0rbbMGpgCaG/c+ueX0kqd7?=
 =?us-ascii?Q?/b0f1rjUoxfYs1EDlZQhEN0KkCdlf66IwJCIjmIbawa1P0/QRaDGC86gNLMP?=
 =?us-ascii?Q?L6+EouEDVrnlRtjxGnAa41X12WcTOPvnHoDPihpE16pLxdPaFBDmXptAJnFi?=
 =?us-ascii?Q?DHRtIJuzkUlMsrHNRPi/4Hln0miGDqum0X+hhEi/0g4sHx/Sq3RJ2QmGDJ+D?=
 =?us-ascii?Q?/T21BJU8I4tI1gCrmbOqrCvd3AcKFpn88Xs46bH0BLbt0HtGjNJt2MqDN29T?=
 =?us-ascii?Q?Bdp3/5BgWbihUFTG7dmHQTT8PiwKhveuypYdPhkxOqkDr/Qx90BwOXi/eZTy?=
 =?us-ascii?Q?9MmoaZqT6Qt/btvIU1KnBkNWj2jPQukTlcwa9YAcpIAdG3ENP1I3v2GLyKg5?=
 =?us-ascii?Q?7HhqNlYI5TtGAJ3P7JBWOyvyxfPSWZ9i2F7HAJjXoKwCbAWVVhttlo+jRhfb?=
 =?us-ascii?Q?YxRMDFCsDkjYDG2ankbk+UClhQTsS5MTpv+INC1BsHYWpKxIt5/OLC7H/Lp6?=
 =?us-ascii?Q?r8eE9RENMRtN/a0psaQ+y79n5vwhm/yCYrU3hQtJRcwooTcqyl0W7Kgsa6Zz?=
 =?us-ascii?Q?t1qtaLMd5EwSk14od5nS6tIWS+NuUokDpQ8Kfp9LCJ8H7p8qvDcHosbij9Iy?=
 =?us-ascii?Q?DIrif82v+C4SbDajJP0eAMR7oGcZ3+EwpX3Ku7sX9a+NDnb5Hw5fdhp3uqQF?=
 =?us-ascii?Q?AOI4gGTqQ92NBAyykLdd2SSIOUK6GfN7Xlq1P+XHDZwpno/8ylThrKWgMrGD?=
 =?us-ascii?Q?yXtoy/7YivNZ+8aam6jT9AbjlCf5VZvD/eqFlgPIvOM4MMnbDDjts5LilfKQ?=
 =?us-ascii?Q?8t/XHzDAaRVHpXh9ORcbUP0E10F+SFwY5CtnO8NXMa8MIJE82JltixQdfJVP?=
 =?us-ascii?Q?rZlpN6pQgLtoL+Gt5AQh/cUiZ88tjtn3pS8mg3Pk1qwx3v8B9P7G84eMgmEa?=
 =?us-ascii?Q?KCLZZL/93cFCQMLedsMy6ALZv5G7iNytjb0JsBeVzdzNys4/E6EiyOxKooDp?=
 =?us-ascii?Q?odmcVJlj2wNTt1rPiidxaxgmWr9c806kR3x1h0UurPE6ThaVTTQMZ65jTL1A?=
 =?us-ascii?Q?M1fSGmy+LclUW7s69wR8yomxqY9RerwLU9reH5He7i9gVK5ZcNks8LCilVzu?=
 =?us-ascii?Q?fat3N22BMm/4wsS+cmh4X0/6Fhviq7HQyK6jcmGkVbYfSqyqHw7Zn+IjCfL1?=
 =?us-ascii?Q?dvVXd7uDXyYQR7KoGF3VIYYomsDkxrCwB2AZ2FIaRUIyoRopHgwbYHI2l1iI?=
 =?us-ascii?Q?bo0FXoLXdW4DZt90+dWbWie1G+5wLefTmJyNeaiZbdkSxrFosC8ketHa6syY?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4y9LDCjzEoEGISrRYj5mP4n00N/yBEjp/XoN5GGK/5Gy3FhyoiNpGW5zzmYMkW4ddbB8fAFriS6pYQKsMEM05w96Z3XNt19RyfPIv3zvG3HLp/b4qlIeW1qZYH7Hh3gTCGqSbwWpPApRe1CiqE4jrV+Vq6JpRQiTwKtC7S8yvZZBcDXea7ksLkazJ1s88kocwcUUlB9HlLaEnHXxwvHnvARruU73Z73D2PaMxJt1Hqk6DA0nFlXbiTJyLXoJc0pdolrrH0t9KHN/Tc/yRKkv1Um3oRrIraZTPJrHqpMNgnuCz7WVkraL5bjpZYJZdPopFtz8ISMXYMeCuTBMkfP9R/WE5TEFd+wNmBGrEc61ett/Rio5jMuZC4NS48nlexT2srpMcwIqVWDM1OKm3bZUKdCDzRjsUkKwZSyieO6vRTzzf1+GyCgyL0K51yivlo5cIsRfuUaexwfETFwi8Ysesm4z8SsdqAFopbuZutqG5UCExVec+efNFwXZWlG0NUmaIBuulEIDao/4qS5+t69EgNHR/aCtoXCz+Or7K9r4r+exVzZvoUO0LtNbHR3Vy9lMKSuaA7aGfwkqIjieCy2WAJw5yhtv/bch8mMirlJWrzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6299ea-f12a-4bcb-35c2-08dd04d17fac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:26:39.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYZWJCI7CN+5Nd4OdV3/LUfv286kyyIKOqb2haA2ytgjefmxuE6HgIb3h3MIGNyqm+zpiDk1dul5mCdpOkSgp3I4YdANhcCORTtUHqLog2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140136
X-Proofpoint-ORIG-GUID: qzhwRU3A1LN-vdEwHy2DbIkhRn1Wtg0N
X-Proofpoint-GUID: qzhwRU3A1LN-vdEwHy2DbIkhRn1Wtg0N

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4080ef1579b2413435413988d14ac8c68e4d42c8)
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     |  9 +++------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e47f112a63d3..df2b1156ef65 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -46,6 +46,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index f4eac5a95d64..ac1517a96066 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -176,8 +176,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	struct vm_area_struct *next = vma->vm_next;
 
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1901,8 +1900,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	vma->vm_file = NULL;
 	fput(file);
@@ -2788,8 +2786,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
diff --git a/mm/nommu.c b/mm/nommu.c
index fdacc3d119c3..f46a883e93e4 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -662,8 +662,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index 8e5bd2c9f4b4..9e0c86555adf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1091,3 +1091,18 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 
 	return err;
 }
+
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
-- 
2.47.0


