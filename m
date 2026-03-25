Return-Path: <stable+bounces-230286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMjeJFiow2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36532203B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37D8B303D6EF
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFE30FF33;
	Wed, 25 Mar 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gpPMQJTO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241C322533
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430292; cv=fail; b=IxOnbF3mqlA8kkIQJJPHPRuzZXELP7O2H7FRQNvoMQNIvLOJ+bP8+hR9KJxdIZGR9M3TfHgqwld+yBvn6vCOe8uTyc7ExA2bAdBLzeRzJEFeRhVP2gddl3hxIy6lDqOG/kRf3Lxf7hCpEJW3/F342xXtmeOfwkm43enr0GVkfyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430292; c=relaxed/simple;
	bh=bLqD8GgUlpLpCIHOtzfs1leH2DEU/cA9vMNYDFqLkKM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kqFL15K8xIyvEIwBYC+TdSwyo+9jv8jpkielA5Ds/apHmxYaISO3G8LOXzrfFdx2XylRRPP5QlCR7xHGDyt2KpudXlgn+RujYmroI98kNw7QsnKAspEQkZoUqz9FHkYeFNtUApd/5Rv8FQ0ScVxOvd6v6+1As9TLmYqphI1C3cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gpPMQJTO; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P65la72107281
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=7dvERzhg+lYiNx6JDzjT
	5qsk2UTqizhiKDtav0ZrK+k=; b=gpPMQJTOGnVAMQDPJYUQJJe2Gk0J+yR2Apfz
	HM/zleDXfYUj6xvcciregCP2fmXq3467p4+ty0dcIkcTTJDY8TKWXBU6qnJVF/ey
	xEcCgOqcnz/F4qiUDuVwQPnzmUJJ6ywo8HcgLXpahZ0a+pfy5k7n2NRF8ToJz20z
	wwa38S7wlI2vwPtQc+wY24upDAjRL40DwTdC+Qt8+C1B8NCEp2ZguAB6uzyuzTAN
	T0F+BXMd6otN9ppw39UG3NOXlepFWZhXbp65tjhPOAGYgwBbVnMj0HZo0isO7qjr
	ThVmfKnN9DO41JrFd4kiqglbJl5pf2I2snTjY6ahIAXWorfgrQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vr6t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBEl+xhR47LB7feOMfIKgUzk3ujpiB4IBHHNrRJtWSLOdOjlyKMT2mMHRlLbhUxWxL9KJDNCT1UXt06Gi6uKEVHMndzGZUpnctztJ0+9FDj1d9DJTI2/ljazezJAqGzqnLpkpiIpOlJmbXIoq15NHWG98oirQpwzlfj8KigKgDFDlnXtIq6pBQxeIFNJYgIb95ZRYmcQZoyq/fRy7yQZPSsohNCRfQvZ30qqv6LlSkLXgdaFSe2ktYBs/86nltK0MbE5rOAgDSRYiy0zCw2A/AnspZCjxuLt5i++5LXBf3ypJFds+NsFN/suDT7lov9qhvY2ngUdVdcEspPjKiat1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dvERzhg+lYiNx6JDzjT5qsk2UTqizhiKDtav0ZrK+k=;
 b=k6yP8hajzODJO6Aex5Quv3+d4W3klGt4Vygj9m/14nplqUOR7zjQazMm+XaBO28E7o3yVbnip0USS8N/ZbNtWnVn5ngvbUynqs7pEp0D/rN9oiyN/8SrkQo7Ks9dibTufRY3FFnXOrz06yKJODz7JokazK/XSW+zEUxpkdv8zZOij+/CZJ+zJIi0/TE3GaLdJd9W3ZUO+L351JBQ+g1Cg3qvZ7hrl6Cec1FCRCdzI3Ys2OQEj9HAWtNi7YamFeA7ykdIwaK3qHD5sFP041IMTtiWPuWay5ouQwCgz4FJT9iP9nh6LfExt+1a+601BZOR2risW4VqSymByLRfjNzbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:18:01 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:18:01 +0000
From: liyin.zhang.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 0/2] mtd: spi-nor: avoid odd length/address accesses in 8D-8D-8D mode
Date: Wed, 25 Mar 2026 17:17:38 +0800
Message-Id: <20260325091740.941742-1-liyin.zhang.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: fc746152-4c3b-415f-3dfc-08de8a4f698b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+N/VIGLw0E/t4agnSNOBZy2mH1gZDY6W++Lvao62C7uw03+xG2YQk346yNxkgibPzHIgy6+PDlBVxv8/Xo9hm8/peQyQQvwPGxkrmRhb5PSe9uBLI3sNn827+J+tU1qm/CHyYYuw7TaNvPrQzh41HrC4GwxzulwAQW0Hcvpwyjee8ne2Nk6ffscW/s5GqiR5b0XQDaULsEMeinerp6ANaDuZhapOzaEtWaVTRdAGOizjmrIE9YgSTXA6yK3jk4bffhuaRZWu0ubp3q1nmQOQZ/R5rLDn1XaepBgttu3htOXJQPlVBj8NxZ8JYFbHuWK9Sb64I8g8ANF6HHdSSKmC6pdxjFk5Jqli2S+7VZSwOely0cgUNLOzvezzjAk6Mx4875yyNeUesPy5u3ZnTDbxRyUPFWmi0uNCDApZdHcFdq304VtD1RGLTN5VoHcLkIVRXAPxl54don95Yha1lEoKrcfK5x0moJjodI+N2IC52PbVpLuhWZP0vatk8obIHuofUC8joqfrZsny9KH9U6Yr+bk9w/jHVj6+77ku/Zc8DdlWik6gm/McMHXwgbOIF3CpVMpQaN0H2952N/aIApK9lGjPdsxKfluU8RiCmqwtF5dDSYUmm8mKLyh8qdEpPE7R53IftVEqAuMmeSmWAcbu+wcLCpXxOEgU5OrVQt9d2rmVX/RR+e0lHlsUEnsgYjUtQSe0Jobp5TF2nvMgvjaBywW9o97LSljy/AU8bLC99XOwEAsCryiEBe9ZyNZEeNUkIG8huNSRdBCKCfXEGqOEc7dD1Dwvblac1EorZL4VKb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SChEhjs11VGwtb7qieutR2QI7DzeVeRKIle8F50IPAsCyefLHnyevTvZYauG?=
 =?us-ascii?Q?Dc607WyqpIK+PyeBbOMUhWOdNhg1fVxMUleD7T/YFU6wV/ssQkkLVdxTLTfz?=
 =?us-ascii?Q?gFiXq0+fvT1GcG24xiaeUyXLj5IyNMvCdT2PLBBnE68Cw/1Y0WbPghjiHu28?=
 =?us-ascii?Q?H+zlzID9woWALNw1wv4nrofl6mFh9Q/lhWCDSMdNZcfN27JBqEJjSRbmnCL3?=
 =?us-ascii?Q?dQk7VXlwBtWhqUuuHV2p+lhH5oLMEp4mFOzetgwYtZ/UlHwipQ+INpW2PDc3?=
 =?us-ascii?Q?VjlsFzyaNlS/R6qQ1M8/7nbw6I143yysH3nYbDEP41a8xDep3mHA7qtG2TFj?=
 =?us-ascii?Q?GvKVwB+YYPc57COQqezUlF03nFVSTnpc6AHNbv2g5f9GU+dGIQbAgRoyRYGW?=
 =?us-ascii?Q?/AK2xFqAKviaJ8bBLPJ6vXGZ2MB8G+n6s6XIVRsaeJJV4XmhpwGtisPWFhuh?=
 =?us-ascii?Q?5L/zannKPXh9Fzgx1u/O+yzNMxK3s8/0l2MmOAiOpw1JyJe6XqITUrdFQ4Lv?=
 =?us-ascii?Q?SCDNWW6LImxxft0GI8VfANbslFwKt5wSNA+ko2wvqZf1Off2VYZE8IWmjPd2?=
 =?us-ascii?Q?QzdeulC3+Bjra/WnETWxl7hmSZAJqTHV6Ks8HIk7eUqsef49RJ/e4i4YVqRA?=
 =?us-ascii?Q?nXrKeB3OZy4UrRm3B/wJxSTI/eP83EpaREj2K8eG2eZXakkveF2xoq4+0Zpc?=
 =?us-ascii?Q?fiK0/4dsGCNP41TpV59p+g7r0J5K/hlW3qIAGlsqhbnZ4nLuGJbLrpExIXfr?=
 =?us-ascii?Q?r8mDkvu5QwoDbv+VLLlcZ5By+gOrzrila4VyJz1GSHI8JUgmRIBW8nyDlPIV?=
 =?us-ascii?Q?AAqbE7PVHApoGprOFxnY2kzbPNBM3d8q3L9x27vx8oboQz0iBio8ulSU7usm?=
 =?us-ascii?Q?qnHcq2NCVl4Dbr5/JKGE6+UVjIyL12tKW/lUwCRiAj27mRI/iH8NMNdLH/6Y?=
 =?us-ascii?Q?KjTIFxUKEFWSOIMA172uFzuZtDY+aUhDyRs5TSX2H65W6NGOnAWFXUO9Ue8j?=
 =?us-ascii?Q?d6U2pXuIQUsYLP0RKAiMYD/0woA+CFkxAcs3zZKQFLM1/ereQkPCBt4o97XG?=
 =?us-ascii?Q?cxwPVqxskFEpOlATHlc+aeMm6Yt/M++NaNxuy58adzzOiXcQsaWbblhLhea8?=
 =?us-ascii?Q?bGsvXgTc4hBNcvFk2eWKJWhy6hZyYhZf3g3fiBL2t1YebvcFmcP0Bsl1SsHX?=
 =?us-ascii?Q?M08W1HmGcblcJfTZt/nJ5Ubf46Y9tkbQ7EcA7vtDH2/0upJOHsSdP4Ex3nw0?=
 =?us-ascii?Q?Ruq8Uleri7GD8dMXlmbiwUjg3kJsfJUdgtlkYhNXLphNvgKafJDEOsAsKdZZ?=
 =?us-ascii?Q?GC/c8Jbgg6S8FVjHNzUYg27jiNI4YdSRl+btNJddOHBfWQCQSUt4MnJUMkSL?=
 =?us-ascii?Q?BOMom0UXN4B6tawFS7SyR0bqCs0ZcdrI3LNBidNikluPKir8isvlOlhvAu3W?=
 =?us-ascii?Q?3y8jb5xLgijEbw7Bd0eLG47tgbfw8PEFPImMsqYkk6LGXSQvYGJ3sHjzs98Z?=
 =?us-ascii?Q?iI4GkBJ45sxnSIZnSJV1OffnhD0iIYeTK4Ik+Zh+uaL6PzXSed5QQNUJTYeY?=
 =?us-ascii?Q?q/r8PW9jxXVDsXRp25WbeuCJT2Z/Xi77gKeghcpVNJZ5zJqLoAfaOjA9LUGu?=
 =?us-ascii?Q?L/N3ZsJWdgrfhBA2zEPWNkUm0Fui8rAGKfxZ5ukmcFr74LZu2rUrKbT5NJ+f?=
 =?us-ascii?Q?YBWv2hWe3cOCMlWkgX7WkQ4eiTUwKZ5KlX+WTnlhHuvoxwUbgOW8mM3fte1h?=
 =?us-ascii?Q?G8t8zl/d1x0zFr0W8BM/WdUg/ZCh+lQ=3D?=
X-Exchange-RoutingPolicyChecked:
	c2xQKJIu4K+5w8iwo/beEbRkdoTof9PcHW/qgtXBx6tB6Ui/AJyyZZGZyeWDIy2iXb0/p0W6RAgQorxYOO+KS4Z8+/KcRqbB0ydyZ0uOx8eNEYPwJ2Wk1kY+32LxffmPjRNWuuchBc+2FJHu+dlvtQgmNheQ9YlPBMgKo/jrs/MvjfKBbw9cnXZbMT3qQI9WRZk0DL3Op7hErd/jv69Y0d2ATsZnJCsLTaW6UHO11Uyad7tWupKKQBdNeeMZBW81Ip8M39mmBuvfqh8+gtFk8B9pslygH9OPRb75iTCm06aFbMNMhi1q8NKqycTLPsyRPdoyaZrLX4Yld1gV5bbyjA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc746152-4c3b-415f-3dfc-08de8a4f698b
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:18:01.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e1G1wRq7hc/LL3qSXrXg8tnS28w72xYt+tpwx1mO/+AwB+DLlxUoWBPTRdTTx0RnwLn7S6CGnSN5DFdVG2iQo7BriPgI9FghIC+Hha8MPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2NSBTYWx0ZWRfX9kgzCtguMTC9
 j7H/4FoGH1yzHdR0ZVRRsXRAuC1Sahmoyc5Cm/LV3vr8sANA6sFVIt6H9HeU1DI6IvCcRj29yG4
 yJeO1LF0ognPWAfbcwwn7cJ4lUBXFNgdLvZweD8W3W4UwBE7zV/htpqkZoiLRroo92v+u2u7bz1
 87xE5/mAw6BU1Ef+QonLL+VlFHb2dkmkX58gNV7pkM2IRAQShrsbEJ1K1sYOK9dhAfckJ+KqmP1
 rUtYVaxXa3aIlrcrkokxRsKJE6lxCS7jOaOYjtYeYgaUHNjIbC4bcWAOvUeQglQ7iCf5SUmZdqp
 Uwvk6QEqb+9sYEZZ+zVJ4pvWHLZZjspf+sQqfMe+21o6ZiMnVFR3SFwXqZV5kEOSZjqcq7nHBYs
 zs1ZYzouHp8c052RJN0bb+juLzlB615lB6ztpkBdQH5g5YSPbOGCT0KPzxRk4Lq+Vj4D1FnVWJN
 5WfqBeIgdxeRBFtzXFg==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c3a84c cx=c_pps
 a=TKURuYQIacZDyiG+Utq8vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=Z44AufGueorxBKJd4XQA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Wm_kV-JLxPd0jd-B-thuNNu5nTOYIpIX
X-Proofpoint-GUID: Wm_kV-JLxPd0jd-B-thuNNu5nTOYIpIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250065
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230286-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA36532203B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Liyin Zhang <liyin.zhang.cn@windriver.com>

This series backports two patches from Pratyush Yadav that fix read and
write issues when the transfer length or address is odd in 8D-8D-8D
(octal DTR) mode.
And we actually encounter the same issues on different hardwares which 
supporting octal dtr in multiple earlier releases.

Now, both patches are already present in mainline, 6.19, 6.18 and 6.12 stable-rc. 
This series is for 6.6.y branch.

Pratyush Yadav (2):
  mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
  mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode

 drivers/mtd/spi-nor/core.c | 145 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 2 deletions(-)

-- 
2.34.1


