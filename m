Return-Path: <stable+bounces-196859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2281C835D1
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF81C4E274B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3192220F21;
	Tue, 25 Nov 2025 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CAXzGaS8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BBLtZQzY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D321D3EA
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046589; cv=fail; b=g27ahBlyN9fKavCh0T9MP4e78qS5zZzfe6WzXUnBF6Essn9Qun80xAJgj+/DzOqAcp4ipdNRhSnWx0zMi9HCFBph5qDeft7/OgclZK6LG/vCAodTc+2tFNEZcYD+50qaZXgswX7tEogh/hTqaHdnmdJnPgp+tvXaSr2wywS64zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046589; c=relaxed/simple;
	bh=2u14Zge2AS1VSo6MCZwTAj+efadjHk8hntsmy1nFvQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+2UXTp8f8MEEj9SWt1sOGPR0dtks6i207nSK1JFyZaGs+TQeCfbyxgBu2eY0nVnzR4SJ1wO3+vhY3wJ0M4CPFkTtHH79ljUSQe6B+jKNPhrjC/n5s0XGy+ogHuhX1sz6M/5eJHHRkSJBM4FgOwPq85P1jYZHJ3YRM0nYoaU0bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CAXzGaS8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BBLtZQzY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1DvH72400689;
	Tue, 25 Nov 2025 04:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gqteqCc4VLmmRwSt8vAFEBHtnC9rpuX9M9VHCk1nOaI=; b=
	CAXzGaS8bWuE5iYvPo0RalWatZ3UwxMZvbedKslCnmeYRatkD9dxH6+htalAlbH/
	dHYg1EdeZuj2Mh0k2hSNB4p2V0qIstQRIckHDW1Y6nnIjVkpek6gThLM0w9czi0i
	D074pZcD2rsomMvDyexzC1tq8ZEdJnSc+zqQluftX5xpEAUo+y4hMOg796DR0ArF
	IQErm7ZkjpzVfOy5DfFAREVkXYBLB0vCJp7snGcf4ZX7szYC/pHlyCOBfCVAZfMB
	tjALJdm+O5eBiBscDkEnv5Eac+n+SGzzAzoNrXECZvuH4Qq5B6POMce54TE9VQNe
	MdyubBE+SSSdmEBF62qhUw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddbfmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:54:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP1vDjX032664;
	Tue, 25 Nov 2025 04:54:53 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8yb3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWzWOE4Uz3W6/UXorT2z/jCqprPHf76YFKVWm8Sc7AxDEFP0nP/N8sNl/8Kl5Eb/EnIEbUCK5I1tMMjwYlfqDzQ7IhxslNpFcMdWZ+1aPDuX20Af7RXNu147tuQDQIunNtx1+M5ySeD/0sk19hmwyGp0W2adsW6v6NxEUSntlIZxeZYn6cL1/ZkBgZMewtpbsLEm3R/Ds19Z5lw6uzGQujiOkQOV0jl1bjOWATIjKqmR5neX0hgVMUrQZ8COmGQdGUYPe3RD8W6Qnhfn71eUS9UM0MZmjFalZEn7jyVhbTVFs/+Cx25IRHx3R7WXIRFNoc9l1JNcktiBWyoKD04pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqteqCc4VLmmRwSt8vAFEBHtnC9rpuX9M9VHCk1nOaI=;
 b=vsWEHYGprIX5Q0D3AD67/Rw8EyS7oIZGq66fPAS08T+GvK9VUoAi4ov/2iPHPjjCMS7FcrwohDZY/nJsguiDpJGjHS+6518G4DVK0eI5WpwvB6RtZYIhuNC3ZupWeEPcKpAUJkS+gbKfmM0pw+zR5d4vxM4qlpzbxYZYKTTCKf+rKkIk0XL5wtwQQ7/CgLNv3QIAcqjarbsgyGw+NVKSNoXD0/WBv74rV7OBXAmjew2xUS82phWLoOoZR/Q2ExCEXNGisQLyPzu2ZXpXHgvHAz4+3zblQCWlMN+TnOgdce/5GcFzle9eZ4VgkDId2yqczzYwfwGiHMscnFry0vUJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqteqCc4VLmmRwSt8vAFEBHtnC9rpuX9M9VHCk1nOaI=;
 b=BBLtZQzYPNaZimBn9N8gY/gXywWFaDvtc36pNpgiCKW7W7KMGUL+8c4H+DpYcFr2oQBBLJUQahY86DuOCgj9vEvZ6+Hd5PhDhGmwU5+Pp7XKL0oZSjTNUqFBtfMGCv/s5guo2OlmAxY63QyaJyh1Y/kFK0L78GlKH+W6ZtC3pws=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7216.namprd10.prod.outlook.com (2603:10b6:208:3f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 04:54:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 04:54:51 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 5.10.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Tue, 25 Nov 2025 13:54:41 +0900
Message-ID: <20251125045442.1084815-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125045442.1084815-1-harry.yoo@oracle.com>
References: <20251125045442.1084815-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0039.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 632f5a97-33c8-4b13-887d-08de2bdec444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y6sMohmSVQ44/W0fk/AhbCUiEF28VXEi+1WZWbZroPpiCozniM0sUn/QVc0b?=
 =?us-ascii?Q?GoITg+zxL2qAbSYvf14km9ab8TBPMNXAGAsmRRg3mvD+iK5A0QeeUeyXt5ou?=
 =?us-ascii?Q?+4M0ShuiL/t/fLAoco8o6MKjXBBeGseIOv03vVlGZ797ZxpuaBu0J+tAOMBk?=
 =?us-ascii?Q?czPZcKA+T3hhzyGQqLv4AUXVkPcqLyjUqwXQc/Qa/9SnUjuMQXpDrcOow1fU?=
 =?us-ascii?Q?6si/dD82bzRRvMM4cYP4zhQHCuUH5Yp/fpljb4AJV65FMx7nZIA4BXmk6Q9Z?=
 =?us-ascii?Q?epEdIhhvSN1nJUBIMo+oFzqcX9cSA7NbNg3dSX1dp9cHQITQFTMig3sSJRkb?=
 =?us-ascii?Q?yqhi95UQvQu5VelOu6IIZ/052FVCvRIg+nb9XEH/b/VsLXtcMp6q04tLUC1X?=
 =?us-ascii?Q?dXIcRrIqxQf4uxwhtcRlqLS3GFMN3qdsQo/MwdHFh8vpXTmzQY21Z/LSJoo1?=
 =?us-ascii?Q?yufNAci2DaIDxWT7gi6r4fRvVZUGNx9bxSb11pvUPv/r5ZQG4Z8+CQ6zXu6S?=
 =?us-ascii?Q?VI5rHbjyEFlW+CoZYFL++bvnRS3bEeGiC4U/B+v41G6t4oAhpTi6eWKVhUP7?=
 =?us-ascii?Q?GI4qi1M3ax8Jx48Rj6ZKeNhHN0yQQQDx2WZvdZb7eNijaf1t13NzfQg/+NBY?=
 =?us-ascii?Q?J9YfxqE1AKF/kucRYymWPBKMODqYEHo/ao3RvQJYGiYH8K6hey7FncieLhKh?=
 =?us-ascii?Q?KgtGv3qJULEkxMcGr9D73om/UKil7CxQRgf3zM+E0NggNWDuTLcMmaOaVl5W?=
 =?us-ascii?Q?+Tj1+FXiLsU0Bn2O2Vlpruw5fKFEnBuIKZh/6a9Hsovump1ur9iWOJ7S8e5H?=
 =?us-ascii?Q?3MggFetX7tMM2gJPCVDIIpJ35Rp48yHeNJFIozdsUchYEck4ZGIeXMuEYOwr?=
 =?us-ascii?Q?jrIV3uxQcv04kCzPdT+r89hMMDJQFdz3UJLQW2RhJHazVYsEVEkU8p7ORQwR?=
 =?us-ascii?Q?1tn/WPZ5st65RYZAsZWhqHVnaqaxvXtXs4UZat8PiwELMmmY4ewHH+/eDdVA?=
 =?us-ascii?Q?qrE/rPEFrG4Kzjx29NC0Jw6lQ1fHh3ufF3MbS10maURYY7XM4+/YOZDa3aff?=
 =?us-ascii?Q?Wr/i05Wk/W0b1eHQh9fl6YCpRK+SVSy9jE2liUcBFiU96yiLWy4k6VNhB6Pv?=
 =?us-ascii?Q?aK4C8gV647AjqbRR0HCUrjLnZSKQHNkfeJ6Ri59WsYtPeJejZ1ZbmISjUasb?=
 =?us-ascii?Q?SKwryMK5nG5eehsyZiOnSf7gfYjon7OFtuL2+wS2yTGCatwQviCbUJ2KDB4p?=
 =?us-ascii?Q?AU8Kd0xIuoIOsA3g9E9wGorRlOPgkOLCcH8MhI2wL49a4SVuCJSioEdQrfmj?=
 =?us-ascii?Q?g3PkAlTWVDiLoEFbz6IFxjUnsp7GNfmNefvy6Kg+iVvc/B4Dz0OuhifUR7N8?=
 =?us-ascii?Q?HUE/K8/Wjdn8nVM+3WP8Tg6fZ9Umjb6dkBAgGfkmptoXWmWoWl8PT+32RkXU?=
 =?us-ascii?Q?Y1AsmJJaVKxDfdywesl6gUaisBBkPNwf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5EAdUIArdI4jWWHSej0wxYkB5tlaWwHr8liX7pdMwNzyirmxTs9V0RBPj7Q?=
 =?us-ascii?Q?pzkn45LeBFPza60oGJHC46Fdroi68qiXPLeqoJ3Ja281M542SDHLiSEsEw/z?=
 =?us-ascii?Q?cXuN8GP7rgpRt+b95Z1m4Ncli3mMxlpSeocqfjHTcvt15dHkbwujbGTBzOAF?=
 =?us-ascii?Q?/tRONdbSjP3ZCs30U01i3enAVrw/p5a85ICcEHS+k20R/IS7tx8Ifg+S8KY7?=
 =?us-ascii?Q?XI6Squ9HzIl+YPJbfPNZfIEmV4QpD1pvqZAK2LbIijkh96B1/qrvEvRbm42G?=
 =?us-ascii?Q?wC/HIXRZjCQSEfxMqV3GAnhdxHg3IxgQti08KRcl7hk9w8NKqq1XlxMO/c5l?=
 =?us-ascii?Q?5oYS9XCVH3+5SZVxbRAg28d2mBSaMM1BpBVL4qOzIINyIm6Yly+8bGyEos2M?=
 =?us-ascii?Q?EgpCjl+P6Y+QIgktEAKZnRdrbpscmr/ruVC/2EzsFLmv7trSufMMkP/eegvm?=
 =?us-ascii?Q?gXIa2sFvxktA3lizh4WGQnVSEhBe6qsq6Qt8ntx9NqklRCsZNQTvCEYmqe2f?=
 =?us-ascii?Q?IQ7nz968OpRHjIPmrkWAuG+8pFr0MjX7QtGm7Z4DBhlNM1ri1yHI6Sr19FD/?=
 =?us-ascii?Q?sSUlSj3FF8bdBxpHvQtnD1KeEqLDC6MlWHpqdiNE2/UN4GcuMqlO5dMasaTp?=
 =?us-ascii?Q?1Uyiz78vWIOWfjVOP9ny4N0VkihbMSiwKf/GzmUnJdj/FSU5owRZLD9pjzOP?=
 =?us-ascii?Q?emkb5dVcgUctOu8OgFcGwRovq4qWyz/BuaI2Eu2qqmDZBEk7mJ81vPNeDKbD?=
 =?us-ascii?Q?EFnD9hQi+2zQ5iJGC3O3NOIxZ6HMc8qzdrA1HAVMojAM9zjFQtDHm6ikoQ/A?=
 =?us-ascii?Q?el8GJlJWIf69UHrEvtTpesDGTjDEWH44zlaNHtO6QxT7nf2uPJgfe81Z3o1j?=
 =?us-ascii?Q?s1gs7NOon6BRkw5RD4txOK1xT+8AGCTAkayoWXe6tVppLhvLMk8vfnJnbrLF?=
 =?us-ascii?Q?wkapGbnvhdEaWK3OYfve+AJ4JMXS3MBexokb041X656G/UrRWINIBPfOHlBJ?=
 =?us-ascii?Q?Z2PJKtSXvqDrVOedYc52K3T+fT46c/Ajb6z810BdXTz9cEAWhnU1izF0na1+?=
 =?us-ascii?Q?Jv34pgtZcP7mUpFhtq31YSU5gCzLQcII8wd/eX45GMGomPU27cM6fynVlpxE?=
 =?us-ascii?Q?MCYu94hIEjE/pyNUil/msVitPCYDYFxq5YQxKtPzqMHKAQQKuK8LfDcl9QGD?=
 =?us-ascii?Q?+RfECn8gEc4ih0FYDmeKXwmSL6bwnGfdK6x4D8umoPD9djl6LZuAgFp99KgC?=
 =?us-ascii?Q?HFHVh4AeH9RY/lL1ahQMy6VJByyqHE2CxmJGpNoKFXnyHPJH/XSAhZys0ftL?=
 =?us-ascii?Q?UGDk4fBcnXge0SKMCuubW7uRa9tHk1fbwy3WGHKwrw+Hly2hkFzvc+RTb0NQ?=
 =?us-ascii?Q?8I5vma5G+Le4IAXF5EXSbsNsJkzdniEUMuL1wI9dFDygIAuou2V6GFiXME4M?=
 =?us-ascii?Q?XyFh6ouKBh0qnI4+foSiGEvzN91tLwUinFGdpDNsgJNIO3GyClbgElVWGykQ?=
 =?us-ascii?Q?HqwAgblhJhO5WwxeBpxruOpa4TL+r4eqf6vtZL14ghzDn0fY7hmXDHxhWt91?=
 =?us-ascii?Q?NaIBi7I4GKCVzpjKA2Y8v/fvrZNL7+1rikUTERR6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LjHdV4O/Qoju1jC/U+K2oZEJ9Rv2tVnURzhvq+mUK2kaTp7zClzUnyLE7Daz53ChKccRyLJCVWOMyd7MN9CIhZaTe4aCVqOid7t35KxdI1VyrEOTM5oa3B241OtRLALCFDfM/Ut9EbopmnqJTiRGikfaA7WBhS//nW4ZQgslQheONHI2WV+twOdGJX+ZOlv/7gSo7d1cU4rEJ0n0o4uwUw96FE5L2EAaLO+s0oj19de706P53gbVbFY3q4s6ywbOwqsAc7MOpEYKSL0OCxzJ4l4P2BhN7qfpijyWyj9EF3tzaGLwWXktkWdhM5ycqzNBbQBLkXZYdClq5MdYOmez4/w5e7lxP9TDcwhXlLLdYrF9L8WkL1lmQf7wq//hW3Wfh9qpkWZ4Xw+TCbWQDv3ma35ZUYAIUsh5vgUflkJRTyVKW3ihuxknFymtajzXo4rKxmqNodA+MqVZ/zt3KxVBvbZdX4cNlUJs06WQBVAAD9VKDJYiwlP/cQdcVZBQ15tohmd2SaOyE204rczQsQBqG1AWiW88nwfpc0DjvGSo96hFSKr8ot5W5ClLz0/t6xhqPxMxMFfidGV97kUYYQBKUYtZZLbqecaBRaUZ0ByKvmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632f5a97-33c8-4b13-887d-08de2bdec444
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:54:51.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+VwzDLI3p89uRjONhmFYEQCd25MbhBUXXUI26os+4xrPr39mktnpuJyYwwpRnWmr04YZdBLqHXLwr9yLc5OsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250038
X-Proofpoint-GUID: Y2C3c9-Rm7a-wo8cL7WBOBudCw3KE4vb
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=6925369e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yhwE2cpgGALx-dzfzvsA:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzOCBTYWx0ZWRfXzxJVBjdB5XzL
 GvbdfcAstGQjk2wNJYF1HYPxzsaz30UhBniZ4WklIhkj+nmU4jwIJrvZk5Ac3hyAnb5e/MqHRfq
 9LmIhn7AMhTUuz1qtx1VtxgAqNfIR8RVlgu4U7U2dX/ndo/Ssm/bvR7zZiq/xAvPSFFTmLyTtTA
 YWoF4WhgPkrhtnOf/e9Ur/onN5UrBKaxbzuQX+Adz42u4jFUBEccI7RYpLV/q7qSTc1oedHBqrA
 WIoaZnZ1s23sojQvB6fcVHSXh5z21GUyEi0HkOZZPfpWxBLPhAEBjizxAEH1JkmYpFDKcpp5dtJ
 3W/qmXIEFgOC0B5Jh8pDluZtZ1NZptIeY52lABtRymUKvz/5XoR9vMypPavI5CMa5m2VaykwqDl
 BX1lA2Z632sFC3tuzELhEIhV8EILeA==
X-Proofpoint-ORIG-GUID: Y2C3c9-Rm7a-wo8cL7WBOBudCw3KE4vb

From: Peter Xu <peterx@redhat.com>

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 34 +++++++++++++++++-----------------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1c03935aa3d13..f4d20096959b2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -184,7 +184,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
@@ -342,7 +342,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e168d87d6f2ee..0d5b9efc73389 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1876,7 +1876,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8efe35ea0baa7..ef181edabefe5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5051,7 +5051,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -5059,7 +5059,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6c98585f20dfe..59ccda77d2fca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -653,7 +653,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;
 
 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7ea0aee0c08d9..28e1a8fd9319f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,13 +35,13 @@
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
@@ -209,13 +209,13 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
+static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -223,7 +223,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -281,13 +281,13 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
-		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline long change_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -301,13 +301,13 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
-		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline long change_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -321,7 +321,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct vm_area_struct *vma,
+static long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
@@ -329,7 +329,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -351,11 +351,11 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
-	unsigned long pages;
+	long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
-- 
2.43.0


