Return-Path: <stable+bounces-113988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE95A29C09
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926C81691CF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A01215061;
	Wed,  5 Feb 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebchXyu+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y7p7/5W5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6D23CE;
	Wed,  5 Feb 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791684; cv=fail; b=HiUE/yCH30e6SOlxw88a0Vx9idiTJmFKOW4MlMUdfSpEHWHPQCgt+NYhQuQs5LtACXYqpr7zodc9H8s6wnmd1ucHvPbqHuDtH4r7zvpuAR2ItE0D/MVaBThsuHM1+pGB9fkR0FU/Cg6YRvv94dhg318yRE2Sfu8vET1OlKx6WKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791684; c=relaxed/simple;
	bh=KdGAGqfoR11xFrBP6L4X4838B9VRzu6lVMOPQYcn7C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtuEQHhOR++/zD7tf+4kWexfJQGq+gCDvO62Yty4h7nRTmCpDX/J3fExsY1LKyVwoRif/gSlq5vj6jC24KBAuGQiROHfLfQMGwURxkb6L4XKCeUnOBi/m4RDPb5O5YCmxTUuxv1dpTHjH7Wzjbi9SFcoULuTgs4gfo5fWFiPsx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebchXyu+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y7p7/5W5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfmck001085;
	Wed, 5 Feb 2025 21:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XU5edNamKvYbNJQUgn3zLYPrMCrYla8PZSQl9rHbs1c=; b=
	ebchXyu+SxVT+dh9NpC54XyhkX9Aqy/Ehz55pHezhi3hB3wASO5f9v5bgmExJybT
	49MShiM8tdW/2b+giS0NBJl7LGNVDEor3KfQk+No3YeapIAPO/TIqKhIZ90M+D+6
	FTbFrYjlcBMlC+lMOfSu6DhaVqsWWiFtEFIz1yQwYzgUBaqRDaH7hb5GEvAhGjk8
	MxWlr3a6qd7+CQvMtIrMtrm/BL5c+f6TOYetmL9LJojYvtyQC9PiHBdwbwfK3bfi
	3i004xc6L0y8gEanoUrgwvRRu+cpD/ZXWtQ172h2KCi7lBBwjMUuA1KMHD90rGBZ
	6hviH4OREEREY/7+RnMm0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy880k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515LdL7b027891;
	Wed, 5 Feb 2025 21:41:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p4yv85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXlSu6q8fovgzT2xVmDuTwIaDL0OadZtaWKFlGHuRrdH57t65RV2epExlz18nvcaVqdNnL0Urx5xq3xNSGMrnT+2h9HlWI0AsgrQYzT3I+ub4X5MQqIc0eesGn2d+Gr+vbrN4Jccdsc7V24FrZXqT+8F0gfT10v6nLSP21iR7JODRUxahcVjSgNkUrww+3NpV0s9naD1SfoM381qdLxYciBDTuUha5q9rfhx6QmETB1cE6IANRu4NnLffjGzHYwtQVAwJ+QWxUa0wfuXD93fdZ/YC+aYdxUBlj3/00sz5HSAMt44O/sFsQxrXWDQNYHUgpJ/0oNlxCiBnE5lqzGFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU5edNamKvYbNJQUgn3zLYPrMCrYla8PZSQl9rHbs1c=;
 b=wzKisLliuUMlxUbBffUFzyvbhDqLWObg6ZkG8t4+huYLaXSudwc9YsUVsUZmY9fEN5iVO/gUYM86HpCbZWeJwKaeokcCuNDuu3VpPZ2xNnAgGzK3U+leU66CsRWmX9NSozGs0zTOOsaf9CXmmJ0GgJoNpa/e3WIDjYpgrp1KVvmQtd0sXWg5NgILBn3XliFDXeIZYCvQGmzR00F+5B/Ri4XKd8YBM5uI3esn2goIeBbCyP3tq2+8gMrvIn36CffjsRY520bBm5013sb09Xdiz3u8X4fF6AEFAVwzW7OtCoj5lB4NFavvFqc0NVX0XvWON6yU1yqwIOOK9husoTRn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU5edNamKvYbNJQUgn3zLYPrMCrYla8PZSQl9rHbs1c=;
 b=Y7p7/5W5L1aPv/PAb1pT+S7c9c0LLHIocqPhhuxs+GnpRrijvBWH9yofN3hgT9aoDT9dhGD+AbIPELnNjnh+7/tsvWRWSCh00OuQzAudnjoepdGZzYlqHHHqtacANXNO1jOTiY8q0hFHlkiGIAQ8M3cI4XriL7gZ9GitjCftvtk=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:19 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:19 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 23/24] xfs: streamline xfs_filestream_pick_ag
Date: Wed,  5 Feb 2025 13:40:24 -0800
Message-Id: <20250205214025.72516-24-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e113e28-4389-4126-b3ea-08dd462dd2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B826TqzRrN9m7N0UjTlxY1a++uhJ1mGokfVyRj3tLTNQ2WVt34dZn0pJXdUo?=
 =?us-ascii?Q?XxxQu7XJhXWwHmezBzAwc7fQtw3//LccqmRuqjNk3kvMnEuwmCjqkF6xoNcr?=
 =?us-ascii?Q?uXBH31YeTC1Ah/EdMT+PUfyPUoimi4MWAPNT0qePBH6vzPMOUa2hSB6IdX+T?=
 =?us-ascii?Q?jRI/d/MebGs36P8LOAFDvAu+3RbTX/ONA9SkavYGyHX3GOawoCtkC3pJo38n?=
 =?us-ascii?Q?3vbu5PNkm1yG9U+OHD/ly6CLe2agGM8Lu88OZmD1bP1I9I8K4TXDM3irxSc3?=
 =?us-ascii?Q?1l6DIOOMCOhb/8ZpTkMUBoCIYfYqYOMryl2XaoLNWNut0Wm59NvZSf8aKk+Q?=
 =?us-ascii?Q?z1ILZcv24zsAgm39DqqjWD0FkiR0iX2KiIh4NYTF4dKsM+tLeMQz4CjVitZf?=
 =?us-ascii?Q?PFaAZmXX+9/AgQAFUAfuZNkgreICFkq/3JyGMsHHMkZPQ1tW57vjcMZjimbx?=
 =?us-ascii?Q?M4AosBzIS4wezTin4qtFCG54vDVzeZbxfcFW+sgPvDzyrGjf1LFLv/NGxfH3?=
 =?us-ascii?Q?VOnBa8gQXFLbrAfjPXyCfp5UxN5jJ5pe2Y4kgrHNAFBiGs9j1mzk4fY4W48+?=
 =?us-ascii?Q?ZRW0s1F08/hBOfWTzyyBkxFIXPsMFxUyrKLCiOE8nkEW8oZGC+fUQ7k8HFiT?=
 =?us-ascii?Q?yRiuAt1gvXPCPet6924IJqxyzih9umelT7WvPqJp/bzGRLbAgMfUEnD5Y0Dh?=
 =?us-ascii?Q?JKFnT3jMH/4gaKmXwZcNXIHR5Z3eEf8Z5CFePWpKXsUWs2vVBnIBmJdFcUV3?=
 =?us-ascii?Q?7Dq46Nh2g4DJdYtnvZ4TR5PQ9HkyrVQUatr7zyW6hjRiTfuuZUcnVvZFKxET?=
 =?us-ascii?Q?CU6wsVHW5c8s5LZIFgbN/z8iv2c58tLFx52KZ6StJkLI/3VyFUm/Q3p9tw6/?=
 =?us-ascii?Q?laNZCzBXKxJDOhA3k0WaoUHZ0OVhIhWetLYmenOvvrKd7xizfQsOR0Vwwf5Q?=
 =?us-ascii?Q?gQusnjC6vs5Tx47hW/ya886eL+XnKCV+zOd3jA03BgR4+r8wKXmbefoa43EJ?=
 =?us-ascii?Q?70lhDcG/bSK4Y59JJiZuzT75ykuFCrioDKnypWzFBfeDM0crf7m64lzT4CH7?=
 =?us-ascii?Q?PAL1vwBXF7GT+S8fVwLdyoqfaN8ygPMlXjoPFOMtikrPpfDoFBdT4oJANK0O?=
 =?us-ascii?Q?TGd/OoK4ahhZvU+LnprwT9iOpGfrbGxHViZfjvTbEM77/48D/MyKtewgIp+O?=
 =?us-ascii?Q?/sTd3Va3zRmTqPRx+LLRjrf8EtLxDnWQ6DemNhB711Yb1o50mpI4mUQRS+gT?=
 =?us-ascii?Q?k+uLxkxeBHx4++I4L9kNoJB99hDaE1fwTi5tGzueNqosK8kOYrwW/vnVAAWF?=
 =?us-ascii?Q?AzSI1mIN5ZFcYXewIc9U9MLwyal7Ko5ef0u9zYu4LR8upYSNejynAPIFthWA?=
 =?us-ascii?Q?B526Z57fZ78fLPKkcsPB72ov9UIx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBIuYMOsO6p53Ec/5YXQ7ot3Jc7FHktQmUyO6fmDI2Ie2ahr+kTaChjUeEp5?=
 =?us-ascii?Q?HEUUCqJOBbYQl/v6FT9bK6qwUGub9cIn6xqcIHsBZSsPMLvfz3l1KLmmHNAe?=
 =?us-ascii?Q?dhg75RbLw0tO5YjNJsxZfRPiFrnyb2RdCLpSB8EJxcIizhOxA7ggbwL7zuWS?=
 =?us-ascii?Q?4nNcAipP4nmq7QjvkZowt88/7YGKta/iGpMGnpRfLD+AnzKgpnIvTJJ1yp9F?=
 =?us-ascii?Q?AYu/2YBtS7oe0gUCZGjKu0dSGiKicu3dYUL+AhKvn6xXWM+RNztkvXKtI3iq?=
 =?us-ascii?Q?JBouBASo4YFqve4jxVI1SPV7bFu9PEuirJ7BEbJ+jFH0EicbSR76hFptY0yw?=
 =?us-ascii?Q?8Ba3/zlVHgCjlN92FVnCG2bN6s730ROcM8gqKN2yEMHh9wX4Q/3CVfyR62kk?=
 =?us-ascii?Q?agoPS/8CNsd/G3vZURzxyU3PKgE2mKj8R5/5Xdy4ty5tc9emwpXWbbvoajIA?=
 =?us-ascii?Q?iTd43ELj7mcmyEixEPXezr32dUvelpfZDrJbiiETlvdtkqQ0Jvuh/D1dCEQO?=
 =?us-ascii?Q?epr8yk5I1oGdHBo2wRcBwapjDEovQBZZ0efHiUm27qYM0OvncDItpIGOYhIB?=
 =?us-ascii?Q?LpvkOZxK4Vjhz6zGc/nR0VoKgmG2wMRmAiKaYPixcHH05aqVcAGtEkxWW6W+?=
 =?us-ascii?Q?el7iLOUJKuqdFRJYKrACELbVEGAP/hROgUm/UA/Mbc10oFl/Q1omi0XfCI9Y?=
 =?us-ascii?Q?5f+EaBMb6zF/B+GXb+xjDElQhHxaoxiofGxFjEIqXyHOZQcTG5bO4i+vzZyK?=
 =?us-ascii?Q?FxpUYW5d6Cho3bBxWvfc7+xTUcS2LoDPkgUo2LscXuh+vnntx++31U2bzSwr?=
 =?us-ascii?Q?5pbB8/wNxDfDA9ZQ5Mp0wuAYbyF9l6th7cH8Kvl9h/vnE6DP4QSWBOzTnAJ7?=
 =?us-ascii?Q?LYd6Jv9hALNpHVzNIp/B86M8lP/r6cFa43Fd8xhf07Dh0sVb6SSgLBXz3UBS?=
 =?us-ascii?Q?opWiyNm//WF0goL1Cwp7f/P5PAeWlu22Wc37T/AytZAltcIKfBhFoUbKVWgs?=
 =?us-ascii?Q?y7J1OTx91P/KRNx8yDNUBfxs5llshfqTZlj8ksJ8+B2KroI1snqsPbzWzXau?=
 =?us-ascii?Q?xFJSqlHrKpsqP7bxL63Xh+g5wHbecCbXbXnPIccAqG/Rc0nxLLXEV/t89Xmy?=
 =?us-ascii?Q?2loOionyJVnvXg/4zm+p8SqTf3wPL+E0nhw7UQLQmmIjoqdwCTS8628K5gN+?=
 =?us-ascii?Q?ON/bzD7Hr3WRFvJy9Y6Yob2ipx9mNSPiVpykZUYRB0Sj7b461OnCYK3Hn43n?=
 =?us-ascii?Q?fXS+zCXJ9x3EGxRT40/cvUJvWUwmYPXsRC2sJsw1Y4bZQTtlLNh7736VA5Se?=
 =?us-ascii?Q?ep6Ggmk6FEzYeg38c3ekZX7IDlPdqHj52oKADG7pW/mzSsrDPl+XCdYPIGUJ?=
 =?us-ascii?Q?0jANAXCTyJFQHZwRL7CL5I5vztd7Q6GjA8dOSXN0T8QBD4rvAu8WNpuvvceQ?=
 =?us-ascii?Q?lgCZeqUsUpRqlvVE5KqFAF2quhbbHnEtC0PnJF48Ko9u49p3qYOI6i6F3d4V?=
 =?us-ascii?Q?DOQjZnfbPxzS2N60kvpq1pclPcahI2O82eltJnHISBzN6ogyy9yG2F1TFwqA?=
 =?us-ascii?Q?f4m/YagTTCTm7j/S2vdizI9LeEZyyrp5ZS+PmDytEv2FdNi7Z8Hhn+G2Cj+9?=
 =?us-ascii?Q?Gn3ms2s0XfY93YJcj4T+6q8zSWGV7HdvwCNTWk0tqbAyBPrtAyH+NdCEK9ce?=
 =?us-ascii?Q?k4shKg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eXk9qS+40jrEImiMZ3/YUqhN0IdwBcQuwB4Jdj6+OOE/66jZp8QMdq4IMbCo9HB5NGcIEJP1ViyUxvongBkxN0LxztiRDESFe6Rh2Ats3NntspjFZ3KaZ5DcDgT3CxuyEO3DMLEUendP9B4DLoOY6LD0uOvyq4Ur/CrmOifUNBjY5i9XnGyBMhkuBPYfIQjP823VHDyIdi/oIvMVLoKn69UgdtKUQifL0UNIFFRlG8CKekSzI/FUcPqOtq2De2lWxga6pmGTwNgblZoHE0HxGNZAWlx57J/iagfWmCfQmwQvFIi2i3/QZsxTtedTQvdNDkI2IbIif3egs1vV4tcvX+T6EB5TghF+2UQPp+oXltq3rcxnCx9OMC5ix1t0sJC7ErfcKgh1V4D4KbOTDBYaRinj+jtERghFsg4p9AZnALDrUB6GVzrrf9DMDkR+BxnvCKolCPn/8LdtmtjgDoecvgDuSQfhdjmDeR1BRbeagpfbXwzzllBLGPl9vx7WG/cUzPF0Xx6vgHt1gChWsNXY1AVEUhYLANyKcofSUJZ9R5dm+17+UoRtiGxHV/0FGcJGf82/8cZmLAGyJgKFoe0jZ9FbyW060CfBiodEN/NDX0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e113e28-4389-4126-b3ea-08dd462dd2ce
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:19.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEBggAb0k/v6Sr1uvm+j9+byujoEwKGkDj2Vq+4LBvqX0jEG2mUm4hvCgeDphnYeEVnNKawFhHhfuvRIHBMKPbKUZovo9gRyXKYP+4So1gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: 9bgQ2iqclm9HsGrWBD79cC7i8gKzKlVY
X-Proofpoint-ORIG-GUID: 9bgQ2iqclm9HsGrWBD79cC7i8gKzKlVY

From: Christoph Hellwig <hch@lst.de>

commit 81a1e1c32ef474c20ccb9f730afe1ac25b1c62a4 upstream.

Directly return the error from xfs_bmap_longest_free_extent instead
of breaking from the loop and handling it there, and use a done
label to directly jump to the exist when we found a suitable perag
structure to reduce the indentation level and pag/max_pag check
complexity in the tail of the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_filestream.c | 96 ++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index f62b023f274e..4e1e83561218 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -67,22 +67,28 @@ xfs_filestream_pick_ag(
 	xfs_extlen_t		minfree, maxfree = 0;
 	xfs_agnumber_t		agno;
 	bool			first_pass = true;
-	int			err;
 
 	/* 2% of an AG's blocks must be free for it to be chosen. */
 	minfree = mp->m_sb.sb_agblocks / 50;
 
 restart:
 	for_each_perag_wrap(mp, start_agno, agno, pag) {
+		int		err;
+
 		trace_xfs_filestream_scan(pag, pino);
+
 		*longest = 0;
 		err = xfs_bmap_longest_free_extent(pag, NULL, longest);
 		if (err) {
-			if (err != -EAGAIN)
-				break;
-			/* Couldn't lock the AGF, skip this AG. */
-			err = 0;
-			continue;
+			if (err == -EAGAIN) {
+				/* Couldn't lock the AGF, skip this AG. */
+				err = 0;
+				continue;
+			}
+			xfs_perag_rele(pag);
+			if (max_pag)
+				xfs_perag_rele(max_pag);
+			return err;
 		}
 
 		/* Keep track of the AG with the most free blocks. */
@@ -107,7 +113,9 @@ xfs_filestream_pick_ag(
 			     !(flags & XFS_PICK_USERDATA) ||
 			     (flags & XFS_PICK_LOWSPACE))) {
 				/* Break out, retaining the reference on the AG. */
-				break;
+				if (max_pag)
+					xfs_perag_rele(max_pag);
+				goto done;
 			}
 		}
 
@@ -115,56 +123,44 @@ xfs_filestream_pick_ag(
 		atomic_dec(&pag->pagf_fstrms);
 	}
 
-	if (err) {
-		xfs_perag_rele(pag);
-		if (max_pag)
-			xfs_perag_rele(max_pag);
-		return err;
+	/*
+	 * Allow a second pass to give xfs_bmap_longest_free_extent() another
+	 * attempt at locking AGFs that it might have skipped over before we
+	 * fail.
+	 */
+	if (first_pass) {
+		first_pass = false;
+		goto restart;
 	}
 
-	if (!pag) {
-		/*
-		 * Allow a second pass to give xfs_bmap_longest_free_extent()
-		 * another attempt at locking AGFs that it might have skipped
-		 * over before we fail.
-		 */
-		if (first_pass) {
-			first_pass = false;
-			goto restart;
-		}
-
-		/*
-		 * We must be low on data space, so run a final lowspace
-		 * optimised selection pass if we haven't already.
-		 */
-		if (!(flags & XFS_PICK_LOWSPACE)) {
-			flags |= XFS_PICK_LOWSPACE;
-			goto restart;
-		}
-
-		/*
-		 * No unassociated AGs are available, so select the AG with the
-		 * most free space, regardless of whether it's already in use by
-		 * another filestream. It none suit, just use whatever AG we can
-		 * grab.
-		 */
-		if (!max_pag) {
-			for_each_perag_wrap(args->mp, 0, start_agno, pag) {
-				max_pag = pag;
-				break;
-			}
+	/*
+	 * We must be low on data space, so run a final lowspace optimised
+	 * selection pass if we haven't already.
+	 */
+	if (!(flags & XFS_PICK_LOWSPACE)) {
+		flags |= XFS_PICK_LOWSPACE;
+		goto restart;
+	}
 
-			/* Bail if there are no AGs at all to select from. */
-			if (!max_pag)
-				return -ENOSPC;
+	/*
+	 * No unassociated AGs are available, so select the AG with the most
+	 * free space, regardless of whether it's already in use by another
+	 * filestream. It none suit, just use whatever AG we can grab.
+	 */
+	if (!max_pag) {
+		for_each_perag_wrap(args->mp, 0, start_agno, pag) {
+			max_pag = pag;
+			break;
 		}
 
-		pag = max_pag;
-		atomic_inc(&pag->pagf_fstrms);
-	} else if (max_pag) {
-		xfs_perag_rele(max_pag);
+		/* Bail if there are no AGs at all to select from. */
+		if (!max_pag)
+			return -ENOSPC;
 	}
 
+	pag = max_pag;
+	atomic_inc(&pag->pagf_fstrms);
+done:
 	trace_xfs_filestream_pick(pag, pino);
 	args->pag = pag;
 	return 0;
-- 
2.39.3


