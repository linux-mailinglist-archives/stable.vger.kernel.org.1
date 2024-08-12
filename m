Return-Path: <stable+bounces-67378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CFB94F770
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 21:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF06B2151F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41273190047;
	Mon, 12 Aug 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntzf2vqy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mYwCz7ST"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4E13BC02;
	Mon, 12 Aug 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490646; cv=fail; b=CVE0KhjJb+g0bqc1EDCa8R5ZaLMPqKioMb/ifKvT6/nPoZIw2UO71yq/6mWaEb+8lcI7nj96hnuCACs91XWgHmhsbsF5xovfCzRsBbetiC93wD27GOUA4XDlij2U7JNnrzAB5HsmQW5uOUH9Pmcq1lIk9slAEXaVlVxRzUePVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490646; c=relaxed/simple;
	bh=+LIcBAQ86rqxpE3S5ceWZSXsCOL/EA3PnzrmJYAmSYI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=J9fdfTfGiqRqGGHTtZPOTIXIfehW2WlP446DCwKSsYm3EbWqAUFsI3nu2wcbhwupPDqkW/bZ9hAyK3HpDlOU3a3P3hjX/ywmbFq7HGzRdwDPdgYFDXBoL1XS4NfgC5EEfvV+8v1zpgJiBPAvc2kwEDQ8tqTjpGt8+cdr28Q6fvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ntzf2vqy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mYwCz7ST; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXr4J009958;
	Mon, 12 Aug 2024 19:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=EwaTZ35R/S3p45
	RUR5s/sQ1JNmvooc5YXQtcLViyS4k=; b=ntzf2vqy5SwpStLxzShbIiOyv8de5r
	CeRxRb/XNh4U4dTuVEdsYum8CTeqZLPNHuFMwdDpIFDiJ8MM+FoJo5MBVl8HQ/98
	kfFfGyu8c0y/FNu9uwc3X1gATTEIFmK+OsAUqu9CfpaMOPKPHeapQrd4JeazbeyY
	E4LiNU+u0vSYqEhw2pyyy62k57iC7wBkyvgM3Vy0tJ3PZVMp3Vyjmx4CC6Qkjozd
	r8pGqXlisjR8kf+nFgf2JTjDPtACNEGkbSFlKuDnIn0AY5ZgHKeldxo2ZQRLtPsE
	QVkQwZSDWaTWdSD29AsMYr292+O2HwCAVwhVhe0SDbcbhI17ZbV83uEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0ug2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:23:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CItkLR003340;
	Mon, 12 Aug 2024 19:23:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn7hh65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/9I8HuoCYHLAtFV/En7Op/4rPFaUaKkrq8S9mHag/euH2LGgCIA+weUFmK8QxQ/fNFn8iy2jiHSmp+y04yCH/oJKDFHovTQDVHfLufrKiNhTsdP6QY2xnlpiKx7pgUBFhiuHI6hGishjEgYpk99qNSU5S0JbTy/kytMRnIkuJQZJvVkamt1/mHb/LaOh4XWoKhEsadgAuPJYNNZqy21SItnYa4VpQZuAviYVpI474A9Qwbw9YFfqT6CutNEogpCtC9YtRQ5e0Ripx4c48JEuFcMpQy/yGF1rhoKLYC+5qxiCio2f2TWK5Zv/4N+n514hO0UD8lhscAAAZ9le4fiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwaTZ35R/S3p45RUR5s/sQ1JNmvooc5YXQtcLViyS4k=;
 b=oKqKjeYHqk37xGBOJrk3rRLRdyAlXOjPyudnSBOyuB5DPNsGzjdlabelFxJ+r2Kxj+olJwmEDGK2/kuj/HBrlfcKq68YJO21Kkc6kUOkyzQ8NBoCrJmeQ02RloQSoeRdv5XZ3TLQnuTwBv/2UFc4GnyfrigoLeXWdPb6oxDVQ8DiOcYJ9U0naJ2rGAByu+d/fFBZgxIT4byNeUwBi01cwRHzwxL9JKY50O6zx5AY8Y42b+5hyxJqHBzV3k+FxUOkYqmzw1CTI+ywBg42XhcJBKd/So2amLhmciqy778tYOKCMMvI7FqNWO4V9QvSX3CfT9BKfmJfVdbd6BRaXXp0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwaTZ35R/S3p45RUR5s/sQ1JNmvooc5YXQtcLViyS4k=;
 b=mYwCz7STFcOkNsEakIAkESFPBQOrqI20sNRFhDqxnfyboHHyjSZ3s8mS/6+GZhAYVVt/O7XFmH3qHANlBGXCv//w7NSMfq7nNyTG1lA1dfA3FVabwS/DkzOnu/aVptY23Ip/5GjJ+NblGrR/hHuus+Up8OqQol3rI/wUZvB3YFE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB4949.namprd10.prod.outlook.com (2603:10b6:408:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 19:23:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7875.015; Mon, 12 Aug 2024
 19:23:31 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Igor Pylypiv <ipylypiv@google.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        stable@vger.kernel.org, Stephan Eisvogel
 <eisvogel@seitics.de>,
        Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ata: libata-core: Return sense data in descriptor
 format by default
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <ZrpXu_vfI-wpCFVc@ryzen.lan> (Niklas Cassel's message of "Mon, 12
	Aug 2024 20:43:07 +0200")
Organization: Oracle Corporation
Message-ID: <yq1ikw5zgx5.fsf@ca-mkp.ca.oracle.com>
References: <20240812151517.1162241-2-cassel@kernel.org>
	<ZrpXu_vfI-wpCFVc@ryzen.lan>
Date: Mon, 12 Aug 2024 15:23:28 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dc28aa-a5fe-4848-85f0-08dcbb044011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6McQl3WSLmF/92f4zAp4Izm2bS0bDRO1nkPCnbgvMr0OJAALY6lCXuaALlB?=
 =?us-ascii?Q?JjKh3FVBgUs0debwESGorAes7zUWJC0wFBLRto7fUPxHleyaZBziHq29vprr?=
 =?us-ascii?Q?ifgpVlroYYTaBPs6f5LakMWoPW/CXlBn2A4ZUwLpGKawp6dZ8AjZG7XsAFm7?=
 =?us-ascii?Q?RqWb5jA3gyxIwaC+j4P3PxaWEc+XBVGO5J0E8rOI31Axm7ycz4nz6seHNqgZ?=
 =?us-ascii?Q?zDUkQR3i/1Ug5rgbdJIqqLSsfE2CnPB655Q4YF/jYNq3IUmFnzBDaCUdHxJ9?=
 =?us-ascii?Q?FnAoongFf1kRH3gIsmVHdmk1HA6H1/qrlxf1CJCoQI9JYOwaeGc/Fzk6Sv7Z?=
 =?us-ascii?Q?8WAYGc2OsdjBZynyn8S7/bAaz7B85V3Kv5LLamEhiogmAlzPVjS+EHb59o2V?=
 =?us-ascii?Q?RlfbUh+D+ZOxYmO4QMziZ8sJq96Uo4WxL1w8D8EbpWUhAsyOCyK2qQbqZ27x?=
 =?us-ascii?Q?K8W8hNf4lGQ/6prGS351AYWv1bF+uiwdrcy6HnuWRMrLBFN65uzt2yePs4eY?=
 =?us-ascii?Q?9ghM9lgZYQptqEYejPH3Nn80pke+yMKctXhzoILlEHVyZz6HXx+TeeHxE4bn?=
 =?us-ascii?Q?2OUccZ9ndFMVWUCnM37t/wVZbacfCMsfOlTLi7lE/v7QxcE1xXN1BuONefAl?=
 =?us-ascii?Q?3VLvnsBLW4XPI0WKbI42zMj/wwrusb8XuBV3ukQgsd3u9WnbhUkSEF+tPhWU?=
 =?us-ascii?Q?jCEyUfhFNTB4Z/P3u4NQGo3uzaD+m+8L7YdPhcaTd410NtmTXiKM0XMKSlCj?=
 =?us-ascii?Q?lFuNRnYLsRqftBQbZJlQjIs40qDNaPd3w9FVkTEHEUvwHmL7L1rgGXfqIJ02?=
 =?us-ascii?Q?xrLIonW/inziSdSZn+cSPbBvSq/sO3JZwOSZwpsVpcnEwVhc9twRj9s7tDe0?=
 =?us-ascii?Q?0kwQ9LtN/PGfza1rAf7YvsjmyizymoIktXyUk+OYcFm1mpjNm/V6pF0v0ToZ?=
 =?us-ascii?Q?g7PgUg7nwzOIBWHGotwYeSuaZ/SvbG0Q3pck4MtWfjBpnpTLXilbQYjczZED?=
 =?us-ascii?Q?Ih2w7OWjM7CH4nFrZxkOp26bcKTsBR462EOMRLLQeMcxTebE3wo1jUKL/S51?=
 =?us-ascii?Q?ddUquinebZ+2qu0dbonDA07DxUT1y/gCP72ITb8TG4tCIeedEKbKlmLLTbT0?=
 =?us-ascii?Q?nrzocmYzTBrOK5ErAg0aDgxJv36N5Udnlyn9xtNR93ShAL0Nu8K/3znnZvkN?=
 =?us-ascii?Q?H/MtfMDtWuP55d9I95OdomD+lCqW3jSi80fcKyMnNkihZkZ1YmTvX/r07+b6?=
 =?us-ascii?Q?K4LMwH2UF0PzstVSL9e85QH0Dh021PXfRuMR/sreSQTcv82DfrzUcYAFTAvm?=
 =?us-ascii?Q?VapV7/ogK4tAakPTn8y+F1kCzQKuagvZkNZNq4R5cu43Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8l3R3iME1Em3jRirfp60RDMESmmRpmAD7HgqM0SF9R/Db8c6EeXrX23bqH3u?=
 =?us-ascii?Q?MVoqqxKqA8giIR1ALD6fE+WRlr1B3yiRqFXYugGti+bE0THkYosLV4/F6qAQ?=
 =?us-ascii?Q?zmXeQEfZdQpvC21hJ3eaHPT3B2Eq2nkyKTsz/Edy3W9UUCNvT5lIIulJitBV?=
 =?us-ascii?Q?UdzTI5Jb6Ja9Cs1yBTmjf7Vftra0F/EHetvoFO5edGaqJIxRHfaeUr9MzQP4?=
 =?us-ascii?Q?7JPxa6CQbK7V9AjGdHpsrf5j0sMu/Uzff83aGGZsTjKiMx/cv3h+iQa+6x5X?=
 =?us-ascii?Q?u38TPz3Je/yKl+GZoI7ISeNAPxsXw/3FnwuPUZ+yxoCI7JkKYE7YC9sWyeOI?=
 =?us-ascii?Q?3hoHtn0yYQJOye/1EHxjetUGZBvA6asmqS1N5sIYUrR6sk13EorNCIinjs/0?=
 =?us-ascii?Q?hwebovOIlFCEjvDUavDf7dVgOE15Gz7uvRUBFMp2tU5ptiZ1m297oFIdxSOZ?=
 =?us-ascii?Q?S591k1XzLtdk6FWLyyPk8CSnqvkto+lhwQoZCe2/2txzrGJKD20YMnG9mrH3?=
 =?us-ascii?Q?1Ccotzm5WfayiwTTp8o8YBEShuohM8NMEWlckvLITGCS39gvlCpXbzitRdsB?=
 =?us-ascii?Q?/Wih+dlLwOvG5ZXEktbfOT/2xcZ+OfOHmP6KND5z4tQn3JRsLjcVhKZoDDG4?=
 =?us-ascii?Q?ex6CG2p8h6qv7KuKwWRmINc+jrRwTJcqky2mOYFqf6Fvpt+xdLEhtJU3sEMP?=
 =?us-ascii?Q?DZsnaxy2t3FjQatonmuefAW+2o3FcVq9uJZA4bDGGOqeoZTRkcgAjf2Ca1q6?=
 =?us-ascii?Q?ZPxq9Xlx3C/WlxTI3ucLQmzd3vtue3dPaB1oPx7p6+oDvM85m5wx9Hs45ozK?=
 =?us-ascii?Q?Z1uGM4yMn3Y009ms15Iagapbi0uPNgRx1jiCcC9uuZFHZlqNvfcEo9lpWtU/?=
 =?us-ascii?Q?FHFQ5CUBAasm76364/aG08lNblQZheL0pBqrCnRu4HF1EJryGPrHUh4Eo59t?=
 =?us-ascii?Q?DLSFWzTD7tNLEmOSvQ3f+dUfG0yzekjp+c8BDxL35EoM0vU2/6cCb+azawZD?=
 =?us-ascii?Q?36Ei5HCkmhT3Sq5xAOPa2Bn1rBW6irIF0pEDDVT5d87hyl05nDSi7q+jja4q?=
 =?us-ascii?Q?2T+qGg0dYPYWsGonvfg7gZXiZbKVowm1iPFw8WblZcGGJAQhvhpWyIAbH1YL?=
 =?us-ascii?Q?FKAvEXHHEJR+r4raSdwSMeW2KuDavuhlZ5uAKXCXibpVDbXh4lV3MtMeqrDl?=
 =?us-ascii?Q?i3n22J27xMoqYP6TS8beqvJJBe01oUVoh0svU5amj9s57JiX6gGgEypeHMXz?=
 =?us-ascii?Q?H2C8bteg4z2U1EOaqCQ0lliNfDJ/b0nLYWECH9Hoys0Uz+gD6LwqU8K+vfcs?=
 =?us-ascii?Q?qsHrFmMtNW8/zxewic3zoOd+8LW54gH8JOQq7EM03wQJyHJ56DIR5vBJTb8K?=
 =?us-ascii?Q?82TbiK0P8wKvgm7WngXtwKQ5ql7QaFAD6Dk08xgU4cMthhe8Rz76HkimZZ5n?=
 =?us-ascii?Q?yjhfxzpyR451qNiy6Vk7tAaVsW4pWdDBy4fzs5a0ALpzoPHDSBntTqv9B6Oa?=
 =?us-ascii?Q?T8ZoHLmXp1g6ona0heWijnmFDOxyVsZAUd2ax2NFDyZoFHWn38eouWF9ymPx?=
 =?us-ascii?Q?t4dyYCb86fWi74P9WXxUmmdnYg4Ox71ffJ9ijVIXCbiO21+CdPC+Pco4FKt0?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FA25hhzHl/k+LlOsDYKl7uvT6lMnTCBZS+wK3Ef2pOjpc5/rUqx/ddO2ixWx+244z1MRNfKCslExGrdythmaxFPsKlV8XeKeDfD1yY6sLi3ZStBbWdzEX4ZvXVNd4aXcVtyVn68jB4GQi9bWpzvLXVALPUeAnQKutDSYw3llnMBTOCM4oTve/De+Odl6pzcyekR8koFohOddJq36y8uDeDwMWlZdvY23/yw55aIZSjEng67WPzylxWnbZcZ/L13DVm7rt0OHwJKOpH9Hdv94b2Op4dM7s0uXXFmg4JFXtg1IfbS4FRO6YIxDRlBoH1qvywPBVojmTEAVaIO2N/zlhBQYXYGo52uU1PGweOUCV6IDCLMG9ICuwjHwUa2cYhR5OpvsZxB96MO385AEWJsygGR5ESEEbnm5S0fiDVQOm+MJvplqkAaob/6huQ3uwwoBAPn3hFQdxMYJ2P0nOBtjgfWrRpV/XgtrLU/MpPtJ5PhskEVmhPIvfnBRO6ZQHGx5XHRQlCQ9fclD1j3YZRUgON2fe5B4XHD8qKymp1egaiIgyNEy9KPo8Q/fYpJqH9lK72NrCMG5tNtHLZjAnSbymxTXoTK4rHtWek5nf1wHfSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dc28aa-a5fe-4848-85f0-08dcbb044011
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:23:30.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5I5WAui7b+5riS6+d/Aw9HeXmMVsg8YZ82xl3z83Qp8w9PgOc7MVxLwRL5vctNIU9fXtqBvIEtY8+Tihf/Hz1dpitGiafE6SGZAzhhb1sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=897 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408120144
X-Proofpoint-GUID: cRNYd2-2lOWlHDoCBYp2xsadtk-Tm0XK
X-Proofpoint-ORIG-GUID: cRNYd2-2lOWlHDoCBYp2xsadtk-Tm0XK


Niklas,

> My personal feeling is that passthrough commands should simply follow
> the storage standard exactly, and if a user space application does
> adhere to the standard, tough luck, why are you using passthrough
> commands instead of regular commands then? Passthrough commands by
> definition follow a specific storage standard, and not the Linux
> kernel block layer API.

Yeah. I'm not sure how much of a problem non-ATA passthrough is for
libata-attached devices. But it does seem messy that userland is making
these kinds of assumptions.

-- 
Martin K. Petersen	Oracle Linux Engineering

