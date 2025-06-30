Return-Path: <stable+bounces-158989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDCAEE64D
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D4174DC3
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2552D130C;
	Mon, 30 Jun 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inYcVtw8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QinY+Q0G"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D382E62A9
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306320; cv=fail; b=BZDEnZsd1Q/Xq6dgpZUbk6u4lH/dbmexZOm11eX95Yl+nsq86XvP8ioX53mHJqw4RKLHkxMEm3nDJjTZvhak5e/QnFcQgBZ4pvDuoIyWCiS8jkNofHVBnvHSJ25io6J73oPcsfEL3Nor8+DYtXcWmsc8yp9RvUYP3Agj7SxSjTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306320; c=relaxed/simple;
	bh=USVEIPn5V5Lqhf0vsCyOgA0McT3uv1s0IC9IqgXTRvM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WoOYlKn/04UDuSkd7AAQIkNbiACVYxARTt2LLK0k3K2Yqcamo1zyO8TeQWkeNPHCp0XdzL6APesu1dYax7IdsUY5tg15FGI8rO50ue2LNMMPp82b/A470x+yaaBIPCgpczmWQra8C6YbzuvD/tFqBodZG057/hI9vTb71oG3Kmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inYcVtw8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QinY+Q0G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEkrnP026520
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=madwb7AKTJYMgQDj+gsOUOJWCoYONm1dK84RJSQ6Vv8=; b=
	inYcVtw85/4GE/AjSnmnRZDfJXNoRUxpw247EDw6njGt4a3XLneufsOh4c3Ej5fz
	eCjN7oQfZB00Dv9js7ywo7FyaRt6Lkf8zYfUWFD16K69kEDfoTSA/BtWmHkn42yG
	/tHw0IzDsQDedRi9vicRC8ZjBEFWSH2Y0QHTuncH+ngzxHVhOb1K+XQdPai9w0MW
	+UDSg1Ln5rikWey+/OwQypl8/XoHmsttjoomVuBz1I2xhdBlPr4cJnmIi7PLMKqV
	o6wIWlfujcZvNJszisAtV2++EdP1zBqTiuYYcdIkDjLWhjumNI8yOhX9thFUu7ZZ
	Ktf2wa4mnPLTI3pGo1xy/w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfb379-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:58:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UGvD63017543
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:58:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1ddtjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzcmUofjN5jPhviAAeyxwxPBpd6k6TgAKitCmllSeIZuIyEaJxTdgHHp6nYT6unThjaDqY+nONG9aKGui7+iXeV87IDJUZsHLOAiwx70qVDkmFLYWdc5lqGbnVBvsk+rZkERxhapg6kmxqIF7DjVEPDHChfp0OIQoe5yldwQQa/PIvNTWrgq964URndOp0Mj07jqdaXbl2+LPzq0vSQNet+W9xg6sGbdTlTYGVJWOsZgL2aV6PvkbwSaXkTOrfbd+GkUXmM+gF1a8/eiI2D480wLbKsJBH+Bk6OUS196LD4rxCYchXPSXxgSvzOmTzMo4s1qDnPlhzAxyJ4uy4kV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=madwb7AKTJYMgQDj+gsOUOJWCoYONm1dK84RJSQ6Vv8=;
 b=NHZ0Tb1TtzarFiHYKTIqWV9MqA79ZfQEtoZNfkh8IMJmVQVrl41TbQ+Vj+jX7nyX0QjaExa3KSUjYwOyVmNNGqkwlFWZjTNC78LVGvrmukTin1EMy69X4osEbMfAYgJKdEwkk/nJUu8VSOV6DwWTwXP1IbHrvBhBLfE4Y2Oi+UqnuA7HtezZCQDEPjZN44xOt+w87aHhyVpKbn5GpR93oN6718sSIagO3J1R2WYpMTGJt+sE+tzR9VAvIL48tTOzfVzXFp3D9KJ0A717+nInb9L+VORnCDAJ2/Tybc6VeCbmcH/tN2kHRuxJLo96fXIEovYprWiwU5qNvmvYlM2X1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=madwb7AKTJYMgQDj+gsOUOJWCoYONm1dK84RJSQ6Vv8=;
 b=QinY+Q0G8X6frCBmlLW/ZFjyPreltFx/M60itOriktrq0eO46mL8QaP5NXfdCy5RjNmVrBSSSZDh3OEx8nW/nGqSnwrhqztWQjOvwZytTXD/rneLMTRotMcVs65KO3Z29DoH5DTOyMeKN26H963gHuFrC4x4lUZkQ5yTeUiURa8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4984.namprd10.prod.outlook.com (2603:10b6:408:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 17:58:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 17:58:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] mm/vma: reset VMA iterator on commit_merge() OOM failure
Date: Mon, 30 Jun 2025 18:58:17 +0100
Message-ID: <20250630175817.164918-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025062053-gills-deliverer-bafc@gregkh>
References: <2025062053-gills-deliverer-bafc@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: c151de7b-df02-407b-f83e-08ddb7ffbabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0r0W2iBYljzkve3v0YulAw2HINDO9iVxkhbTbP6NvsFjNN8J1qx3dzlwmy7L?=
 =?us-ascii?Q?d+eoa+liCfipy1tOpiI+9tDalLxzrGhT0sMrYZ3qe1W+NA1bCHYTcTLaNXgl?=
 =?us-ascii?Q?QcRkSQPk0Q/u3EGPlCSDw2NlIcuESyXezf/Tewki9HDfMVYckL4NJ+eXdvVN?=
 =?us-ascii?Q?HPW+8W//6F2TkLLfwu/yr9njblekpqwHSSrJGnzgTzpJz2Zf0h9WoT0q2qdd?=
 =?us-ascii?Q?D08iUKa/2MeJO4vJy8XnWrXqFxOhnH6s9X3IFukNd09eV9nOShqLzl4SuMxj?=
 =?us-ascii?Q?RblMhPBHVWTAgZ9zaLrSB+8jwiiICjd9Qe6JpcDtlR8SYoPWHxpcx4dbh2Dc?=
 =?us-ascii?Q?z1IXQpcwub/w252LB7zrfTHifpAMpRR6hrFSiQR7M972DgG72Nifunl+7+rc?=
 =?us-ascii?Q?BrdMBs3Vi6fF9fcohqKlalz+Dmi4KSu8/RpCY1cYyS59AFe7jH1Z3xTd0Jox?=
 =?us-ascii?Q?yi8qNYW7ieFXSM86KtCiVz3XyTQ3WrvLXrX08GvzlZy/gET8ltEcRBGJ5ReU?=
 =?us-ascii?Q?2y60/tjduxw60C1eqTUepWxBo+jDWhF55JBZHBQ5RPS9Q0PuxX0o53hmCyoY?=
 =?us-ascii?Q?sIIf5EKW1R2g6/PESG4vaEgY1FLSBRMizLPeHkWJ7rnZPKZWTvq6LspsGVSg?=
 =?us-ascii?Q?ZLHGHnH02c/7AqiViOf9deujyi43fTgGpWMZnp+X/ZsQQx8jbZmCLZHTraCp?=
 =?us-ascii?Q?FaYV/h5lFaUdFddTfbAMRaxb+nRNvbDcS0HAm8ZV5wwTu3EqsXJH7B9ZjvYB?=
 =?us-ascii?Q?rGtddugH0WLhoED4okzLDcCJ8fK8QmhhXfeWTMpzW+/poxzYZU1xOh7TXegj?=
 =?us-ascii?Q?LfTulAYNAnqy5wNuCf9dVVogMGksozjWhXPlv5okqSX9+nGOLkM4dKUYz1BO?=
 =?us-ascii?Q?m9E2ulXYXv1wtq4Ll6bmW+5s5Ojaqh4pkKKdb0CIeW68WtA9HAdAqwB+fXr1?=
 =?us-ascii?Q?Y1BZNQT1cPzdPi8eot8YmTlmD/crzvt0CckdbQ36z6B1J4sdnluXHxYNP+D9?=
 =?us-ascii?Q?xrc9AqT90vaHClt1pcOgceYJUyY2ZniCSPoIynd48PS7SdyQxI4tEfFt0HPI?=
 =?us-ascii?Q?Hk/juQY1dF1yY/Lh9tCwNePiKdVEaoEu8JRSuuuwotXynzMQ/NdNuvKwO5X5?=
 =?us-ascii?Q?PsS8JRJv8PswWX1iG3yBFT2rF7ihpNS2xtnu5I7LzeQvA3kLgMtJRs5/XsKE?=
 =?us-ascii?Q?OLOzV79m8HWY8fdZ1Gs4RQ/ytBA9eo6cWuOJpfyztClUPqRHwGbr5juOQJax?=
 =?us-ascii?Q?bc8bVIa8Vy7suA+AztmO/iAGlQpOiHEzgxvT7M8SAdvQ5AO93sb1PPNIz1C4?=
 =?us-ascii?Q?mdj+kr6p2HaiyzuRkq2Lxi5iIsCG67d4aM9cSVRBxMnV5SXYTVuuac9Gj27a?=
 =?us-ascii?Q?b75/KtjMd7ca6jUcAXW5fZBVF4cctTMb6aalea2/GDmpWM68BfqzF835nl9a?=
 =?us-ascii?Q?9YmV3Qn0Z7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UNXppqPimErshimNDKcG0RE2tAwfgHf3NXzBIcCHUm86bseVU465u6oGL4O?=
 =?us-ascii?Q?NZltNDPHvkI+87t6fasQhI0qWy22Bl0puj/KlRLLHlOsVSHi9w8ueVFNW++5?=
 =?us-ascii?Q?WYnsbRQmsPdNHnysaQqyyyHQlq0c+dKT1cMih0rW2FSoM4k/Lgxyocx9jpj6?=
 =?us-ascii?Q?glA0ZjH4Xzir+J9e0xQB9kdtHsdwyEy7P8Bp51s3vMIqb7GxP65tCHYxBlKh?=
 =?us-ascii?Q?JWNVVeLPi0hXIBR6KyOFwYcmwAdSG9AID+W90m6CQM/c3GH+32GqHp14uW4W?=
 =?us-ascii?Q?3+VPyL5wZhgiDpUh27Tnm64aid5ouMqERUTzxahfs+kfDTee4U7zsuhENA8w?=
 =?us-ascii?Q?/n4afm/aL9CCyUQFhI+T4yTWuBx/6jmajzQBbB89W/Edew3u7zotLIsSQ/vo?=
 =?us-ascii?Q?g4LAiyQrUVit/arh7DCnnvS13mFZitdJWismp4+/TD50s+mVnhFHGsOPYOXL?=
 =?us-ascii?Q?n35rfMMDTRBVo/7I0iJjnQTTijqTgSOYcvRJFZbWpmQFHxCFqy/BI49n+WDq?=
 =?us-ascii?Q?V31tnlXf0Th1VLYY+KQgPwF26ZVCUjS+Z+Mqz53hg8/iFxhDb2ntDtj5YUk0?=
 =?us-ascii?Q?NhexQop0nimYTwX3sZyam74Nq8cAk0PL/e3u5hKl0sMzKeXuoULwGbubnOWA?=
 =?us-ascii?Q?T8hDlu1MGQnWPqOQ3vgsx1EuNNosbZ6FHmxcEbMKVEIgFbDRzQo1ZdGluVNd?=
 =?us-ascii?Q?hEWy7NK/DavPMbuBzTZSZ4/cI4jFkG+R9258tiEz6WF52qFXyJWGOm/0vhEI?=
 =?us-ascii?Q?ZxQMZs00buMxQcpQUsaLeukkVhx8GLbZKMBnvHKdWhid14JSzRwis9zw7Bfw?=
 =?us-ascii?Q?No3F/cymci5LxWdK7iE+p/HyK6HfMQfxuTl2rm6VMJsveki43B5GG7nSjF0I?=
 =?us-ascii?Q?agmh7cG/WWDfEuqRjDBEoWM6NGuy9EQvhZkVE+RpdA9mJKR8R2WohPw53I+r?=
 =?us-ascii?Q?KaLJ1/hlR2gVU2wBe9BdSgbzBbS/qa8/c6VWk92EluqE/l0WLr3QWOxfqElH?=
 =?us-ascii?Q?LN8+8HeILJsP9jab1yaKOjiGePJSXb6VNpvBsacnOwmpjgANaz9KH7WtoSt+?=
 =?us-ascii?Q?0phdrlEzJWGflARlx0q3uX0RCFNW7Y4XfAA6rQxhT2F8kSN2DyWARKVrR48Y?=
 =?us-ascii?Q?gS9dlfNnleYY/swHqm5WJGUppd0wlBIMAaGqFrlJ7c45lGjzmWihPUUj02jL?=
 =?us-ascii?Q?1fpiBpCSKhDSkFY0JOt93OiB8jwEBCu1OZg3LgEVThyTF/unNiPUj0vWLTvY?=
 =?us-ascii?Q?6JPEcVOGXFJgRlgCr/A3uxbDeVJqPccnHlGrnm04SeYWWxTnujsnGWCdGuii?=
 =?us-ascii?Q?1NYquBwvsN0TMxD+YZ379Z5uK4DwQicDe8QQNQoxBIt8KXuezmbgR8F4+xrS?=
 =?us-ascii?Q?9vBgu5uu9e0E77ncJscaWUVXyrfOFeTfEPjKKHxG99sSodE1QTlV0/grYjuC?=
 =?us-ascii?Q?+KaM8hhcyARetli6MbtiyoYmmu296Gfb/ell0rIjhdrM8OmBsH9Y/fi+BU3i?=
 =?us-ascii?Q?W+pMJ+q3WkaVkNBR5Nx/oSUCoFdOJ/5A6P+Oe/NMCguxRJT4IbA2DIm15nbK?=
 =?us-ascii?Q?JhsCbGxbBysMEVjtXzVuI0gKYnHC/MKOldtmFDU/6C7qixCUBEM2/E2MFIIi?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VmudAXmLZ5a+usPBnGuF5yspsUt80Oq+8dqP3Xj+dxeXefjru84b3IcSqsAMGAYj0eYPsproaRXS+DiZzsOmkVWGyEgSHP54C1re+YDiOpKY7Ll6KymF7wAcqDvu5I5266dB7xTqFgIlAaA3PKJsSR4YF25MN62v6aWdvdIUcjjlpfm8uf54rJU8Sr1l/6WwSBwpsO6eEZbOq4Urj9NWYBnjjThM5eXJWsFEv4D9KCSg/EQdGEQ6O8OVJcXW4yg+bheVRZQKwQabZ6NfRHpj+mzueRs3+HxM+tdbDKsomNalTr5a5HrLPvF9CVelHyKzslnSF5OrFBR40s72T+qOxsO71OLFrQ/7s0pzcxEKZ3XpOTS/7zi2lec1D5eK7UWUaUHH2vkSzIdsDse6NVpPLTegkhHhk3Ov55xahL7aJT2SjHI1iIm9Mo7yV7saYP1Mfa34/j/9BlUkppj765wdo9JX78nDLMhAEprhy0bbsTg4XqizugOOoLoHw5EmpHxGAvvqQhOlqtHkt+dCqfJILbeg1DlfTrKlYlaK/7O6cyskpt0LVgMoaDpIhlHggIVol3LCMxHiQ9WSePo2DrPIV2jmo4U3f3p5ZJsozh6udqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c151de7b-df02-407b-f83e-08ddb7ffbabe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:33.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDHqQQgk8ga7fhAJ10NMahVMEkRwYqxyaPXrS1DpG6lxGsaJTT19l5UO8n2axg3vCIOF9lOcjet0LfWscF4LAmALKpsEMNO7HO04WP1+pRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300146
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6862d04c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=Z4Rwk6OoAAAA:8 a=fZjYlUoGh571faCR9hQA:9 a=cQPPKAXgyycSBL8etih5:22 a=HkZW87K1Qel5hWWM3VKY:22
 cc=ntf awl=host:13216
X-Proofpoint-GUID: dQnn_JAfOY7xczof16GdYWxllM949snJ
X-Proofpoint-ORIG-GUID: dQnn_JAfOY7xczof16GdYWxllM949snJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE0NiBTYWx0ZWRfX75mIJuGo/sqi lohgGjwILKtNNtE5zLhEqmg/gt28R4R/4xMq+S8hHga7c6jFmWb/CB8UzAMvpylE98M5acbBDpv 2VJ3Q+zu9Z3WAkhLOxcMorEqYWIwga1fl8Bq2TRpIiC9h3fo9MTvnLXg9im1DcI2UyWu/EG1jcT
 0dU7zFUYzRSXjBrQZaccG0dDojKPYYhyq0DLbkvLz7qD+IROzbx1Nlcvt75bS+8sWdgaKtSxBLb /cZCX1+OeU1mUgYbrep1nyl1SFbjLwyeBfAO3Mq2mcoL8qtXaYVuEhuy7q08gRgw4tvSu3vD1pH EZKAhKntH31gTcZKEQvHe6PHS8LBPupCjh2ey94AkGHrzErg8R0vrPDmIrcLzcH67ixTp/HJqRi
 UcwiTn2dVd9tKNh3QjzqBqNCQOiuDGUB4dRVlv1+xKD4a9s5APi4bB58eEvG/ipv208uh/g5

While an OOM failure in commit_merge() isn't really feasible due to the
allocation which might fail (a maple tree pre-allocation) being 'too small
to fail', we do need to handle this case correctly regardless.

In vma_merge_existing_range(), we can theoretically encounter failures
which result in an OOM error in two ways - firstly dup_anon_vma() might
fail with an OOM error, and secondly commit_merge() failing, ultimately,
to pre-allocate a maple tree node.

The abort logic for dup_anon_vma() resets the VMA iterator to the initial
range, ensuring that any logic looping on this iterator will correctly
proceed to the next VMA.

However the commit_merge() abort logic does not do the same thing.  This
resulted in a syzbot report occurring because mlockall() iterates through
VMAs, is tolerant of errors, but ended up with an incorrect previous VMA
being specified due to incorrect iterator state.

While making this change, it became apparent we are duplicating logic -
the logic introduced in commit 41e6ddcaa0f1 ("mm/vma: add give_up_on_oom
option on modify/merge, use in uffd release") duplicates the
vmg->give_up_on_oom check in both abort branches.

Additionally, we observe that we can perform the anon_dup check safely on
dup_anon_vma() failure, as this will not be modified should this call
fail.

Finally, we need to reset the iterator in both cases, so now we can simply
use the exact same code to abort for both.

We remove the VM_WARN_ON(err != -ENOMEM) as it would be silly for this to
be otherwise and it allows us to implement the abort check more neatly.

Link: https://lkml.kernel.org/r/20250606125032.164249-1-lorenzo.stoakes@oracle.com
Fixes: 47b16d0462a4 ("mm: abort vma_modify() on merge out of memory failure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: syzbot+d16409ea9ecc16ed261a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/6842cc67.a00a0220.29ac89.003b.GAE@google.com/
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0cf4b1687a187ba9247c71721d8b064634eda1f7)
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1d82ec4ee7bb..140f7017bb63 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -836,9 +836,6 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 		err = dup_anon_vma(next, vma, &anon_dup);
 	}
 
-	if (err)
-		goto abort;
-
 	/*
 	 * In nearly all cases, we expand vmg->vma. There is one exception -
 	 * merge_right where we partially span the VMA. In this case we shrink
@@ -846,22 +843,11 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 	 */
 	expanded = !merge_right || merge_will_delete_vma;
 
-	if (commit_merge(vmg, adjust,
-			 merge_will_delete_vma ? vma : NULL,
-			 merge_will_delete_next ? next : NULL,
-			 adj_start, expanded)) {
-		if (anon_dup)
-			unlink_anon_vmas(anon_dup);
-
-		/*
-		 * We've cleaned up any cloned anon_vma's, no VMAs have been
-		 * modified, no harm no foul if the user requests that we not
-		 * report this and just give up, leaving the VMAs unmerged.
-		 */
-		if (!vmg->give_up_on_oom)
-			vmg->state = VMA_MERGE_ERROR_NOMEM;
-		return NULL;
-	}
+	if (err || commit_merge(vmg, adjust,
+			merge_will_delete_vma ? vma : NULL,
+			merge_will_delete_next ? next : NULL,
+			adj_start, expanded))
+		goto abort;
 
 	res = merge_left ? prev : next;
 	khugepaged_enter_vma(res, vmg->flags);
@@ -873,6 +859,9 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 	vma_iter_set(vmg->vmi, start);
 	vma_iter_load(vmg->vmi);
 
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 	/*
 	 * This means we have failed to clone anon_vma's correctly, but no
 	 * actual changes to VMAs have occurred, so no harm no foul - if the
-- 
2.50.0


