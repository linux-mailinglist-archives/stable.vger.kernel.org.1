Return-Path: <stable+bounces-211812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH+gEc+/eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:38:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6094FD0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCC1307841B
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2142676F4;
	Tue, 27 Jan 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2gtBfBV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uXz64Yr9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2F3090C7;
	Tue, 27 Jan 2026 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520903; cv=fail; b=vGZNSDHBh0N9v7Vde+p+RF1EVpO3Dh3HSDGVfP1T+rqeOxxW9JJYvKpQ6toG8gVL1aTFRjF7mtlXwJvu8XImcJoc5U+pKK2r9M3MgRaXzZ8YKR8tQCwlMMFNF8L/BNDCqbj+dKKLatLl8zNzeaAZrQ7IZ7fEjygzzsCPZU1NDMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520903; c=relaxed/simple;
	bh=i0nJ7vj1gEbA3uCeuBm73uHqEoME/hC7XrromBchYKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LyNJpTLRazCrxfWdpcBOGIQRti/xlWNmHFyKHS/Y/jUNo601KnnyoljtKzuL2B9zzQiQvrV/c8hVB6BKWMKRixG+HdILUprQ0sbZfoJjEO8xvxEkOJr8Yn421DuZ+SYeaXM734UAjLhT4S3uDWYQHE7bjyfSKe9JR94k9QZC5xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r2gtBfBV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uXz64Yr9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEQrb3922871;
	Tue, 27 Jan 2026 13:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LVBtH18jChRQLmHvgP
	kNJ9e/TpSuwoBM1URK/iBmFr4=; b=r2gtBfBVSZZr5806eqdirXdFLbWYQgCIpk
	2YTpQilh81OadgavLIfz5RYoEIdSPU7QDHDJppcMnr7ysv614/W6jzDg68Hd/S/9
	0Ew130Xj0a1aNzwayDPHwoTnNdQuSKaP/xECACxH+htxCfq6uGyM/DdewwIPHrLC
	2YFjy8XfK8e/jZsrKaOyQ67YMknqrTGYF/4OfwcoZR9hMeskgnOTj9K70dduUDqP
	J/xS52NEniIxOb4c5/N1j0UAnhCrQ85cCLDj6AaGhX+jrQ8M3fx9ok3XPLbUCc0d
	xLCZH+SS4VNNvxJvIhovfTI/Yrald4VIlDR30RmlDJEOaZl2EhsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmgbv0h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 13:34:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCVuXt001744;
	Tue, 27 Jan 2026 13:34:04 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhdxr62-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 13:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ixi0EZyqPFIQZrTP9p7Gv6gYivVyQ9Jlo/oBOW4IfVriC8ejdrBMJNyh0eGzTJ3loulx4WtJ4O8bDJ8bIBxTwiuB3Kjy7pIrAHmoxawcp3T38HXjv3J4Yyib1Bb0yDfUV8fTSgRITpPfg3IhBp2A/OjicQ0NTsl/SZ+jdBmdK3GBFYbnHm+M9gMw9gfwhjnKEx2jxWCNYOZKVUZ6bYusU3ogCFXiJcX5BdtSPy5gcwlMn9voUiaSoswzLAAC/8khx1ItkzqNlTvA/FA4hSmMSZDfYgukRi4vQTnCwUQyCvOXqjLbXWpMwK8/TV77cbX4WE5WKj/5VW+1mEqoAOF6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVBtH18jChRQLmHvgPkNJ9e/TpSuwoBM1URK/iBmFr4=;
 b=vafOq+GpfLLnX4Pxlc3SpegCDXj2DC5AyIwk6J/riRw00P2eFHVAMXkeq9T01JJTtyuMOk4uFnqlSPMrKEJqERyX+i5Ab1lXklLG0zYQ5OiG1ZfVF5GWssJ/rUoKIatGUTM+TgrcWFZRI5Sr2tDMs+NUiB4ttLUjQgoBX6QL4tbTTrHN+aO6QVEuWQSgnHyzlzhbKQXWKfIrnDdpYLQabG4DzTbrCBCElogDH9mDJI2/1UInO8k7EVMlmumLMr83IQ4nJagj2dsX8en53x1gb7v/ZFfAQlKEW9H6eQk0GRQuAs5F14RUWfJ+LugzPZFSrq/6mbVE2SaJj8byaQyrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVBtH18jChRQLmHvgPkNJ9e/TpSuwoBM1URK/iBmFr4=;
 b=uXz64Yr9zCaWza+LtIlV6QesP9+DB+2Uqk/QRpQEOYCRL49dRGdZ9b3mS1WrGCLV9d7WDIaItAP6LSuYVKFDbE983ngszUeNfRdcjbywQrqO7uJoyjbWUydwjBQmu9qjSTfDTmkcnGp21zkKNCsvq7S3I/GcsU6Ax3pV3cISTw4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 13:33:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 13:33:45 +0000
Date: Tue, 27 Jan 2026 22:33:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jane Chu <jane.chu@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
        muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
        linmiaohe@huawei.com, jiaqiyan@google.com, william.roche@oracle.com,
        rientjes@google.com, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, willy@infradead.org, clm@meta.com
Subject: Re: [PATCH v7 1/2] mm/memory-failure: fix missing ->mf_stats count
 in hugetlb poison
Message-ID: <aXi-r2P3OJM8neCp@hyeyoo>
References: <20260120232234.3462258-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120232234.3462258-1-jane.chu@oracle.com>
X-ClientProxiedBy: SL2P216CA0172.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 11de9c44-40ae-4504-f50c-08de5da8b202
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?R1EVw2WMfJpUKPNFQK3HOYtaJK66Hj5Rtu4HFtQ4qLVSSmB9k+23gMa1vO+V?=
 =?us-ascii?Q?6AFSmMwWAwDJBz0WnWTogxH7iRVM/N5J9BnIWYu2/N7K6dPdubE6D3BVkOFP?=
 =?us-ascii?Q?eX/tC/jBuMOQgUoH5QlPr5rnHTC5w/snKbhRgJknBOCzZMM2bnSrApNn+MIy?=
 =?us-ascii?Q?i7E4CAYdEd+hA+k2LuUuQ1Y5q1RLvWBjuOI6qAPrV1tzFMcRJwGEsgiZ4UGw?=
 =?us-ascii?Q?45jF0iUW8GFbVg5RPUSCJgi9w75+pV5ZtNeZSnIAoyEI4avmpp//nP1EURCJ?=
 =?us-ascii?Q?bEa3T7nhT8gyI/U1bOT73k0EElnf0SSKbkGQjEGcJp9l1BWueg9y2NKlRask?=
 =?us-ascii?Q?KyIaRN9JMmFYVD3Scif4/SmvoBPp/mrA92L8gRQJFUcUC55yYqhWZuzvw3hV?=
 =?us-ascii?Q?TrsU3P8F5eT9v6W0nQBbmSZI28RyrCOMVeumPzS//V4dKa4r2CObgG+NL3ae?=
 =?us-ascii?Q?zxkOVWNZfJInCqAuCCheGB6H1IOwYbKWinySoBLSZJXF6qO3UXFTbYvFvCZq?=
 =?us-ascii?Q?xjc/UcbrKueeUzfZ6vJqJbKPjvktdZHJ1fXgbFHta2t34ZbmoXEtqyXQLy1M?=
 =?us-ascii?Q?j4ppwDZrz2DPN80892+M3XBLDkjOY9BoLhvhmieUHrKTm58/+d0r6CpGQUw1?=
 =?us-ascii?Q?KXZGvIvpvnrfyAjkq5K6i1NUJJNk+7bRlZsSvVAM/C9z49K6Z2JZ7Vq/i2Vs?=
 =?us-ascii?Q?c5ICqxbQxxjKOzXiXjT+LwTASxXqOk6RxkN+7NmXe/wmkpTkr/dRa+0Skifv?=
 =?us-ascii?Q?d/y4NeS0sTLXipdkBqmMwM08Vj1NkIqDExBDljskbwpa1tJJENnXP5vMp0G1?=
 =?us-ascii?Q?/VyxRIjFf4832hNSVKhaCfLtu5zrP09APVcAfOc5N61CnqO4ZqPA5PefTf2H?=
 =?us-ascii?Q?0XLhuO4wsuCZxkoHHFmcxaUohdbe7BslYZNFgf1DSTaHvFq7TQKmpmbn4ZR0?=
 =?us-ascii?Q?cWkjvrar10YL8bs+4FHHo3WKvjfZQENVRbV/3nAeacI6ZpSqwZR/T2vdaxt/?=
 =?us-ascii?Q?9JWjd3cS8ihZHyZsZy+cGgrbk0tGRG96Q1+VeUQjK/jeoHJS+LD0/13O0gAW?=
 =?us-ascii?Q?x+58/WyeSPo+dXk4ne72p3nvt8VnEO4btWWXhokyQQMVcQgv1n1vBuGVdafA?=
 =?us-ascii?Q?5UTjlSvX373mvgCJuWwKZ5hXfKHWY+bnR9t0gtRxVVRM2Mwxn0+tKeII0Mjx?=
 =?us-ascii?Q?o4ZR97jwXmT/OmOcO8y/sAyHtHcK9ySX13zV95VtfXKTL8Axw0iTRkW67C52?=
 =?us-ascii?Q?Hei7oVa9xOIpizbKzokfd3hBDi5f0a+VSDUvkqynlkpkEM5SE6RBGDxoeGxT?=
 =?us-ascii?Q?DE4KLGGV/oIeISAK0669fSDiXvVLOgrpJRvFtG2M98S0AWll+T8anpchstT0?=
 =?us-ascii?Q?b+Ykx0+i0c13/6iceBxTpnNpazkUjjiQQxcJeX0MCBPcpN11+gSyjSDTPOV9?=
 =?us-ascii?Q?rPsylR+SFonkS3yOc4qjoFf/zryAj6vjdzaWrq1lHJxfDTciBMKRfzZMa+qp?=
 =?us-ascii?Q?w8c5d3Ram/lvRgq1LGJBJgRcVBBkthYXoTY4uVlouRN4CGuVrMph1D7rTc2p?=
 =?us-ascii?Q?ouVoadeWqvWGblJOtdM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?u2UKtGAnsqUR9Ym2EFD6Hr5Vb4Fhbgd1odtJa324nD6RDXBD+OufuyjYJ464?=
 =?us-ascii?Q?f3tyCzPLNdDp1izuhMA7jRTuGS9agKr6uPl6UftG8mv+XmHYdHzOyr1rFYBe?=
 =?us-ascii?Q?bAeBUSfzUoOyyhotAR7uPL7M3dQ4YCqaDE7+xz0DZpQZg6rrLD3W3dIssP4c?=
 =?us-ascii?Q?l7aMgA/h8tjHB2LGK1vO72W2umoUTv3Id05VG0j4xL467DlBjpnHMC6B8uuB?=
 =?us-ascii?Q?KN+s3IKZfDmB7pvxf4w/6CFD9Ea3Rk0eQRHMUPCklI7JSLIJsgTy7WfHdR1W?=
 =?us-ascii?Q?Wzer+FMwXcD5wujW4pqcokQKePXtuZzn9fD4YlLi7UCOMENlNwDtTzs6lheG?=
 =?us-ascii?Q?STnpLNrIW+JqcUdjOfUzQqVH5zczXzHFv8bB+JufO2yT6/bWWoaN3Jr6R1fA?=
 =?us-ascii?Q?u3HyjoM1P0sSkzsk0xSO+eLKUmFFqwoH5JKFbndqRbA3Q6lFFXVxgK3b/EV0?=
 =?us-ascii?Q?TQEj5GDyfp8ftK/N23EmhXm6jDhtiNzLfU6yY2V8ZPYOIHcbEuREQyMygj8C?=
 =?us-ascii?Q?+VCeWGFVEcbRbro1CohFIFRHSAvMDAcpV3WLseTvLMTZB+mTTLi6ZP+gfTU1?=
 =?us-ascii?Q?3aAn4lAYMtKDfQ19RTe0HqsDifERe/2FqrjmtafQFDwEoFL8RIudqsPl/HVi?=
 =?us-ascii?Q?xfFp904CkUZhk5mBCrjXsedunThDPX1dkGae+E1VQqyTHihP8gkpJ41TkKf1?=
 =?us-ascii?Q?HP41bBdsDuL0Z6K/55cpBeyRAbJGxvqcYoWZ0KV8CXP0xTErY7Xltu8RyKZ6?=
 =?us-ascii?Q?2bZt/56g5cAzsDb13/z9fcL9rCEAktmZF67vVC34FvYNLgCXsLmnI+kTbbU1?=
 =?us-ascii?Q?V7keEZB13a3M5znvnWnNCXHLzh91nhVcCKFIGG4EYGeJfdXYCFxFPZtLVUKK?=
 =?us-ascii?Q?c5L09nb5zhD21v0CM713sGxeLUPr9ojhPDrgzDRg+ObM2Mign+PyuQ3CS95w?=
 =?us-ascii?Q?LHpuJ47z2OD/mqioZZEO8piVC/S+H4BFcpvhM4IwB77gfVosvMOUa299c9Ao?=
 =?us-ascii?Q?LBwkmJ8FkEyG4Gao4/4Ks6H1Zc/YgpgzgCBclnWBxT5CtEceG+Ukvr/xFt7d?=
 =?us-ascii?Q?hiejNJwIcbUKtVdq1YHEZxbQdwTJHVo7hHIf6sauGd0uUbWjxl6WF7nnCDp8?=
 =?us-ascii?Q?3xMYhUFChlkfx97Ops7pyg3l4bDCCM7dSTeR1VkK8l2hPxR3tpBGcY7/eQoD?=
 =?us-ascii?Q?gD7a4zZznDtDeGSC3eA/cmXQEQrLEtq6hg4frHoxU6urPLKKY/5A5WXD4ncM?=
 =?us-ascii?Q?Ghjy8g0ysoIgWNlbzPqZ+ZzmD4Y1PZl36X2Tz3dEEJ3O4vm4Xa1zOv6RjQIg?=
 =?us-ascii?Q?QoNvkofvbbY3+H8q1MEmGzfQhWusT1C+JpMndn+hFgWXxETiHtdCZ5M4yqTc?=
 =?us-ascii?Q?k8K0HN2vD/jpq5s1wvQRIpcGCko5DCHORQ4BCIopw5PcoDITya0V3SXHUbD6?=
 =?us-ascii?Q?jxdqUyL8pzuviYNeDEf70VCvpDTgTAI2Nbc94xc9uWrzFYI28hy90ROVEgwC?=
 =?us-ascii?Q?ABn0GpOJyGqijDMzjrJLw+JsfP+7E9NbQxyaRAi7B62WpnrD3ILvBzslrKh+?=
 =?us-ascii?Q?l+VCjXlonMVwREwanKRx+eTwg6IuBBhpNiPHn6BNVmngTHciHU6RZQ5FEfGs?=
 =?us-ascii?Q?c9D25zRUghZROfQyuzbroKox7AzAUaecuyAF0CReuXmONnDWM41cAuIaFS/T?=
 =?us-ascii?Q?i5Hf5sBZhp0TqOtmE1wRBosR0aJ7pLqH7C6a8BPDSGzfNmZm6lDBegRI903a?=
 =?us-ascii?Q?UecL3tiNKg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3kNSWlaN2NMW0NxhCefyAYtBkzLaWaEV92CnDWFZrF77JpJory2eAv+4olVd0Z0spszCmGvSJxOWEA5TPbYSv2nQ0dZ+9b4pudeXLWiIIZNm2s4JyZrp2Essrl1io6ErKfgQzU76ifPOKofBaxPtPxQ85KlqT450Qk2kb93OB8k6bckuLqg6FxWPivG5nnHuxKIezIP+K9MUYnvYguJAO8oOsD2iMFdvZlJJORNpFjOVyjf/vqVn1HOZmIY30ma/P+QcIlFRM7vaSjzh0+KQMwa+gqnEZaVXkErKBysl/quepsx4Q+34vJfkBof8n1R+oGnwLcIEHkCYTRZyh3xk5fSSFu8dAARXgkqE9KgEb2HbiZSSoa+DW6Id8Tw71HylLqsS0JzbwtjhiTZu1Hv07Haxk9lGGLAzD86678JJMJwhtY7ld4/e9eNDnudwyfxGnzcgARyE0xzYyvxkzp38vEo19egCjaH74nZD5PErkPiVifa0umgMh6D5YbeBf3LeAGyz5Ud+FHIp7bMoukiTKX2/IirWmE2hhnMWi0bi7OjCuuQXjLc3HoG20AiTMseMr4zMwqRqaPwsqo0uWMpCyZsE82WOAoqDbgfCU99yFoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11de9c44-40ae-4504-f50c-08de5da8b202
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 13:33:45.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDdPRCB8QqPCwF2ph5LoB/qzHRjm70WFohUccYJomGL80jHT8MiZNes9ya59ImUDAMYw9sNnHdLsmpi1dfNzCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270111
X-Proofpoint-ORIG-GUID: pkWhOjfrtE8AYuXaixYshIRUEFklFDbK
X-Proofpoint-GUID: pkWhOjfrtE8AYuXaixYshIRUEFklFDbK
X-Authority-Analysis: v=2.4 cv=AqfjHe9P c=1 sm=1 tr=0 ts=6978becd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8 a=UkdEhG3Za64IPkOVaLgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExMCBTYWx0ZWRfX5JJj3uUlPM2r
 0+HHS0Qdpd6kyolp8xpEPWSMqmiRbQlXCTnvLD4GaY3QLmwDIxSfIm/WZ5IJtrjoCYrUqTheYHo
 DJMLI31MSNZPoEiG8q/nb+fkQbtawcHasXRvjLHQtf2g073Yg/Inrxnb/o+RhzBRLPo81rWO9kA
 fn0BZVyFsUl6HhwwdmZwdfwmW0tyzjR6T9UJ/EnIN7DuUDDtaZ4RW5fxzaiwDdF01PypjP0TOWR
 nJm6MkCQbsWMU6EbTbpc4iakqGa6QyDo5ZYY9m18jTDLmy5YqrCitvU6Lx4Sb6bb48jT2PfG+Af
 Dd6ntqYMVGDdZVdkIdGSwfSkk/62KH80sxKvreK+V7+E0GACziNC0VqE4AFZP72afeoy3lXpsSA
 veLw/P5AdLRUuYEskaVinMPnttnqbzD6bTy23ioCwmPKacCL9pdu7y2zH1Q1QHxjbTBKQw7whuu
 b2KF5UkfkL5UBUAUkJ3jw68bVnAbTVk5AaUgf9rY=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211812-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9FE6094FD0
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 04:22:33PM -0700, Jane Chu wrote:
> When a newly poisoned subpage ends up in an already poisoned hugetlb
> folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
> is not. Fix the inconsistency by designating action_result() to update
> them both.
> 
> While at it, define __get_huge_page_for_hwpoison() return values in terms
> of symbol names for better readibility. Also rename
> folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
> function does more than the conventional bit setting and the fact
> three possible return values are expected.
> 
> Fixes: 18f41fa616ee ("mm: memory-failure: bump memory failure stats to pglist_data")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v6 -> v7:
>   collect acked-by, fix nits pointed out by Miaohe
> v5 -> v6:
>   comments from Miaohe.
> v5 -> v4:
>   fix a bug pointed out by William and Chris, add comment.
> v3 -> v4:
>   incorporate/adapt David's suggestions.
> v2 -> v3:
>   No change.
> v1 -> v2:
>   adapted David and Liam's comment, define __get_huge_page_for_hwpoison()
> return values in terms of symbol names instead of naked integers for better
> readibility.  #define instead of enum is used since the function has footprint
> outside MF, just try to limit the MF specifics local.
>   also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
> since the function does more than the conventional bit setting and the
> fact three possible return values are expected.
> 
> ---

It might be bit late to review, but FWIW:
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

