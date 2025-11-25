Return-Path: <stable+bounces-196858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0FBC835CE
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F40D34C856
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70BE1F8BD6;
	Tue, 25 Nov 2025 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FacYv+zl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mfXomQAx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7FB125A9
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046569; cv=fail; b=XwhHou8ofMG1fLqj5aqRQo2huPvCZeGrhD8bi9ACGXA4m0L3PM8W+RELAOnUahmaHmG0j3+H2YmU4lr3RTj7+fB3ExMRWIEY2I83xcPBBw1bCt3KOzVy6WwrYGb1OLVPXKDmVJQEdaRR3NW7f/ECaIRMW0YjMqsupuDI1TFa8+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046569; c=relaxed/simple;
	bh=LN9NuxLmpjGWlXVMxqd0nHhkkVX5O4iZKcAoO7saECg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sC3d4X77Btdy6o8zNyKc4E+NT37pSGnPk/hyKtyq6irPN4qtsCXLpY5JesIcRs+z+OmeKOi2hoMdBal0fFSbIl5v801ATrBsw1QzpII3AjIg9rSZrrOb15DUF0JRPgPqO/r8GgIryXlSwQbgLfO+4qBe2gkw+hR8G6HdUxo3NK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FacYv+zl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mfXomQAx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1DSB22400130;
	Tue, 25 Nov 2025 04:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z2m+L4BbthXAJcgJrboJy2yYyiLKmI+OJuFdIkVMfko=; b=
	FacYv+zlcyEo0+6ppm1Qoji7oU1IooY+cABAWTxBq1Ji/tEyUX3AhlSs7kMaquF6
	TjSornW1z0FUVsHgeSSRZfwFXdDc4KyHNp8qt9CBUllnHB2OraCCkem6evskxzHZ
	laj29Uv5gbUvINFILa33cDEhKAVo2ZY31pBNP3TvNIKxfmCOOjtUrH1NV6MfPGlt
	2tl6QpnMHZzvUpJwGiXAtctJ/JG1bLZLJO1sxgsrJStYfgCMxT6XPdaWvdiWwDEN
	YkIn6A2R+854fUMTj+3UhgVR9YBoOx9r5uC2bjPQ62Gxlb1aefK5ceZg+/CcF7QA
	Ouo/dyeIMhmKMzwblj2YrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddbfmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:54:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP1646f022455;
	Tue, 25 Nov 2025 04:54:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mk023e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0w+BWLb5Yib/6MbRy6S+jzAFZUcXaSQ4TSyS3SiytvKMaSygbFLmiRHxJQa1CCNHT95BPYraZyJZt4swf1lrq1q+SbUy+S0yy5SDI1HW9CzkMlRUjlH71WcMqbO/jSRJkSDGIP/ipd5jtMfCVsFM6F+wM9Zl7+qIXGoYC97KhJDloJoOWd5C0WRLNYc8XcdQNJ5MkWHfPA73zTKHRXhUE/P/yoP0rro/AtTFHkb8zOGBr8zPMhd7U7/ovK7T+hsUJs/23mUgpm9/XFyWHPze1ifnarBoQrtT6RsCbWupjV2FZRTBGg4HLINyWA68qqe1hLaVqKMAHDUNQiyGUqOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2m+L4BbthXAJcgJrboJy2yYyiLKmI+OJuFdIkVMfko=;
 b=Ze5eHA37kC1D6watJ04xvbtCWsKSVoWeoNSBLGhE/3z9mtb61+1yYj+7bjNGbunFG3VybFMQk76KPVj8e0q6ce/3/Woxtzq8HC/ULmLcqLzxo/gEPvcjGXLN34+Mdko000JIqc2UvwzmAgR2DI3Y4N9aVHWoBCaI0tqEvJCFpDeKXKQZ3gIIOe4PGIqam/ruS9EMvogWsLdj0aP33tRvgedmpt+teJHwfn3ySrVWid69f81PKTCIjyoiaGWw8moxDQStvfcK4TLNVkivW7X4CzfZnbWwfFMofRn5aoXPc3R+4Kpx+B89so3luf9K1HFlMjcPMf3hKUBJQmydcpr7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2m+L4BbthXAJcgJrboJy2yYyiLKmI+OJuFdIkVMfko=;
 b=mfXomQAxF9EzCQRJQmGvw53hkaDEnGys9dQmr9CRnox42GAItZERgaEaO947TL2T+5ihNcNgIQv3T+lHrG3cOIQpvXs8Rf8/dNaUJ4GQNk5z/2ki8mkaPc4FqsJOFcjL0aWZr9zeyhgvjYJVwEua3pEwkJfmBgsj+XUmuRhGaYM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7216.namprd10.prod.outlook.com (2603:10b6:208:3f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 04:54:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 04:54:55 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Alistair Popple <apopple@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>, SeongJae Park <sj@kernel.org>,
        Song Liu <song@kernel.org>, Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Will Deacon <will@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Zack Rusin <zackr@vmware.com>
Subject: [PATCH V1 5.10.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Tue, 25 Nov 2025 13:54:42 +0900
Message-ID: <20251125045442.1084815-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125045442.1084815-1-harry.yoo@oracle.com>
References: <20251125045442.1084815-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e6adaf-a165-4e65-a803-08de2bdec701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHZQTzk5R2Q4MnRNOEtDN0tuYjUwT3k3blVGYk1hUFpZZ1V3SjNjR1lIUlBM?=
 =?utf-8?B?WlRvdGJWcmlYVmpoWFBwTUtBc2V2VTNWZ0hwMkc5VXhkc1pkSkZuQWNtcGdq?=
 =?utf-8?B?TWxVNFpLMVZZZE94aEdUVVJnR2dscjA0TXg5enpPeFhRbm5aK3d4ZEdsV0l0?=
 =?utf-8?B?Zk5Za29Tb3UySUkxOU1MYjVPaGlmS1FNc3o2NTdVUlZEelBUOEhZQ0JWd1VC?=
 =?utf-8?B?WkwzT3hCUzFyNTUyS2ViTmZwWUU2dUQ2Wk9IYzd0UFRoTURvazc2TkN4dndz?=
 =?utf-8?B?VFhvRFFmKzh6ZTlWSE5BYUdyM0Vlc3lnMHJIZ05WTmVkbHpUL050ZHRERGth?=
 =?utf-8?B?ZGZrb0hrRi9WcHJzNjlvcFhIQnNRaGlXRUN1U0VYLzMvSVpZU3NnYW5HblVL?=
 =?utf-8?B?TTN2Z285UHVGQ0hSS21RMkkyVURTeEl0NVFnRFZ2TkdHb0Nmc0xpMDFJWUQ3?=
 =?utf-8?B?bjZUQ3NUd3ZuaXdxcys4bk1XOWdwbDJ1a0MyakhIL2dNc1ZMS1lZYW5NcWV6?=
 =?utf-8?B?Q0ZReDhQNklOTFBxWmpBWHFpRStwOUt6RFRTc3NyUnhwdVdzMC9GWXNQcE0z?=
 =?utf-8?B?MFFpeEFLdDlmVmhqNkgzSGYzcTJWZ3l6MVlFN2NaeXVUTjA3RmtrVzNibFRB?=
 =?utf-8?B?MU1Iazk4K3VwbWw2cFpZa1ZiRjNVbUp6M1c4TE1SZ1pDRldwcDdEZHdUSVZ2?=
 =?utf-8?B?RG92OVB3WVY1SlR1WkVMQzg3emhacElWZDNpWVRlOGJTY0QrTFpERytnTEJF?=
 =?utf-8?B?Z1ZqWjRua0ZPUWFZaTF5NUx2M0MvTis4MExWazVRNzNLZWVLWXp5dTBvU1N5?=
 =?utf-8?B?QjRvVmJRUzdVbWVrdXZ3ZlZ1bEdXMEovVENwem9qVTZTSExPQ0F2WXVSQ25K?=
 =?utf-8?B?bGRCQXRVaTdVMTFIWTBpRTRLSGNCQTQ1VFZKVUZta09kV1dheDA2RDdWV3pX?=
 =?utf-8?B?TTFya1grcldTWUQwOUtLR3F5U3IzaXVrNWZsakcwU0RsVk9FbTVBSFFyOXQ2?=
 =?utf-8?B?K2x3a1ViU2FvSzZKcXVPUFZHa3p0eGJuNmduZTNHK3BMbVBFZUh0Ry9nVFRq?=
 =?utf-8?B?NVQ2dHh6cFNBL01oR1AzakhWM3hHVXphUWl3SFNlMUZHd0xQNzdKamh3eTB1?=
 =?utf-8?B?TTB3U3JCWXpEc0FKTHJDM0xodmhXMlRheUZwWFFtRlg4eVF0Vll6ZjBweDZh?=
 =?utf-8?B?ODhLaHBUUG9xY0Y1bGFnSUlMdHI1ZFZ3RVJLWTlLRFNNblBiVDdvcFQ2SEc4?=
 =?utf-8?B?UytaUnpQWkxnc1Y0RjRTNFFaZjdaR3ZhNDRqbkZDVUU0cDdUcFhIdlVBc29B?=
 =?utf-8?B?M2pCdEVWVmR4ZWE2L3I4NVdudUMwd0hkQzJYanFpZy8vV2t1cU52MDRoTmZt?=
 =?utf-8?B?bUNrVm1rV01GVE0vV09ockx6eExmcnhsMTZYWWtVTEJoVFNLaC9KclhydjJt?=
 =?utf-8?B?Z3o1N3p4dzB3ZFJZcXFXcFBCSUhaYlFGUjJQTSs2Wjd6cjVIM1ZKYmtPYXpW?=
 =?utf-8?B?dU1nL3pkUUVjVnREMlk3ZU5SWGZWUFNFelBPclNhaW5LeUN6VllVdUhiL2Rt?=
 =?utf-8?B?eEt4aEZqVk9DMUducHd6TGtoYys5YkZXS1hGenlTdGcySHd1WXc1K3ZpRGg1?=
 =?utf-8?B?dWcrRzhYV0tKcmJweitLYk5qSmk2NnBzaVF2YUNhZXkxZkcya1k4SU5rL1ZE?=
 =?utf-8?B?WkxteUdSV25sVFpwNmVlMDNNaWdXaGJvSFJ6VytCSXl2dWZWTnY3SFROWGZZ?=
 =?utf-8?B?NXR4UVVUNFJ2SDRHejFDa0dBcWsvZkF1NGtqbDRVUlJMbm1CT0p0RWhVWTVa?=
 =?utf-8?B?MkNpa1h5eTRBWktDcC9RZ1ZPQ0tuV2JBOXZhdjU5ODFZT0dEcHFNa3dyU0F3?=
 =?utf-8?B?WFQrVTQ3ZzhtUWhTeDhid3dIQ2V5M0xaRFVNczBxNks3U251MGFtV0c1Z2ZQ?=
 =?utf-8?Q?Sj4IQtxhkVJ2GRxXLWLlDaNPpXSbid3G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVRTUWZ1a25WYlVJWFRtN1QzUHlLS2pmd214QTZua3FubGxvY0h1VkNDcVg2?=
 =?utf-8?B?eU1rWDFxSW5NUHRWOXhPVnpEMlV4bXc2S0FIcTU0d0hQR3ZpY0crZ3ZRdVRT?=
 =?utf-8?B?ZFFadmhQNjJ0eVh3VGdEYkRsSWFyaHpvcHg4UVFJYTlpbDFrMlREdWl6ZUcw?=
 =?utf-8?B?a0ZuUGxIRk1iK0VsRDk4bFg2YVl2b0RJWjRuakg0YmphMjRqbGNjNEluSkhl?=
 =?utf-8?B?eHNrUi9MTzBkMk5Xd1d5M0tnY2RzZWlTVGhSWFBXWk42emV1c3Z1aThReUpU?=
 =?utf-8?B?VFl1UjI5VVV0djY3ZGthSk1vN0h6Ky8vakhUV05LU0gySVluZXVTQnlscVQr?=
 =?utf-8?B?dE1rUThxWE5RbnVDbGR0NnE2SXRQek0rNGpBaHlQcGVweWlXbHNOZm5tMUxO?=
 =?utf-8?B?eUlkdU5zdGJJK05KY2JOV3BOSStPSDdCa2FHSUpSOU9HUDRFTUhYQ3dvWUJO?=
 =?utf-8?B?WkNJSmo3OWxabVRSTmVmSFNMZEFmZzlLVlBOTHozdTJ4QTE0eEFuTkZjTVhI?=
 =?utf-8?B?RjNrajNkNEhxNFJYTlBxRTFHNCtJdjZReEhYZC9ZUHkrMkNvSDE3YTErdytz?=
 =?utf-8?B?MWY5bHVuK3R1OUM2TEdjOTFtbGtCSVQyM3BodmlDQVNBcHljSkhHK0lIa2E1?=
 =?utf-8?B?VWVEU3dWaHhuYmVMcUp5c2RXY29laXRhZEkyR2lJZ0ZRZ29sYzNIYjBJK28z?=
 =?utf-8?B?TGJVdDBEd3ZBcXRiQnNvRUZzT2NpKzJ2YWw1ZUZJLzJyb1pEQ0UxSnA1VUVE?=
 =?utf-8?B?SDJ6dEdsQ0dIOTJhSmxOYk52V2R1MmJQL0pDSXNaZ0xIbkNIOVlxWERFd2di?=
 =?utf-8?B?YkpNY0R0ZUxvR2hVTFg4R0h3SFNTbDBYWGJPNFhGWDE4R216SjNvaUswMUc5?=
 =?utf-8?B?bUpUQlpkSEFnUzRTcVRVMmFTaW43S2hsWWhReE93QXIzVFFRUHA5azhSRHFL?=
 =?utf-8?B?RDhlSnFaQThEYTVlTlV1RFNzcmJZRzNiUmd0MWEwbUtTTTVBZHdLc3hER1g3?=
 =?utf-8?B?ZTNCS1hvRkpIb3N1OUdtdWtUVjBBS2RKdkNERmgvT1pubjl4elNlQXpCMkFL?=
 =?utf-8?B?akpuakhLOC9oREEwbzFZQUNkVEQweUdnTnEvclhrMGFBWWpCNWdZbWV3OGRR?=
 =?utf-8?B?Sk5SeS9rZW9FRWdhTW1iTnlIVGJ1OGRPeUIvTzhNTThxckgvdWVNMVZzQkN4?=
 =?utf-8?B?ZUgxd3FUaFVRUVRNeTF5Y0o0aTU4Zk15elBxZmhQai95aEN6OGpuc3B3aXNW?=
 =?utf-8?B?MWs4dWRNMU8yV252NjBRTER2T0cxN1V3blNpVU5qd09pdEkvUDFKWUd6MEdu?=
 =?utf-8?B?bG1ZTVlKM3hmQUdrR3NyVFRmNVlyZ253UFphL3lFN3JSMWUyZ1c3THZIbVVH?=
 =?utf-8?B?ZW9aTExDdmp5VTliUVcvTDd5NTB4c1VCQVg0Zmk2RklSMVQ1bmV0RmUwOXF0?=
 =?utf-8?B?R3pmakE0YWRRRUg2OVBZUkJFd0duQXVvQzJlK2k4ckpoRlY2NUJtenBPNXli?=
 =?utf-8?B?OHFaN3N5cHE5SXZ0Y09zR2ljSkY1MXNuZ2JlbWpkWU5YRWdzYkZLVjNlRFlY?=
 =?utf-8?B?YXg0dDdwUHp4N3V0Qi9LK254L20xcEVmNmFpci9tRmUwTnNGMWcrdVBNNDFH?=
 =?utf-8?B?blpXdnhXMDhlU0hVVk8wdHRHOTY4cXZZQURwZEVSalFmVUtmMzZVMjZOdnhV?=
 =?utf-8?B?ZFQwUysrdXhWbjdoVTVDblRQbWREM0x3cWx2MisveTRKUzh1UEhCQzBsY2pZ?=
 =?utf-8?B?dzZ3TU5EZC9Xc3lhMDBidnRuYkFOQ2k3TWRWT2hsQTMvcCtOUXJYWnJGM1ZB?=
 =?utf-8?B?WVhLbG12Z0RBTHgyY2M4cUZlSWpwaGhmR0ZDZm93TTNiZ2xXMVVVZEJRVm5t?=
 =?utf-8?B?ODU2SUpKaHFVKzRKa2dFZ2U3OUg5MTRuRGNLZEN1c1lab2xjdTJvdDBUajF6?=
 =?utf-8?B?bU9PUE9QMmE2dTgzdHJ0ejJxaEtkQzIwUGJwYW13S0k0TXY4TG9xOUVtM0N2?=
 =?utf-8?B?b1JYdGo5WXhHUFJqZXVreEdBZEN1WDB5NDdCVytKaW1aUEhvcXFHREZmRm5j?=
 =?utf-8?B?bS81TmNxSVp2VGNqWE1PMGoxQWhuUEpoZGhnbTh1OGxUY3FIdkVBN1liQ1VE?=
 =?utf-8?Q?7ikvArPl4wtXhJt8S9vJV3W0k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BRTOSF041fb2R3cytmC2WuG1O3h3T7FmV6JOMOVpMjT7yTHns7OGrxMMUou70kTLw9zjb2PTQZoNCj7fetKLgWiK5tTfbdcMEYr6yl/EEwPeRPnr28Bj08VbGAfU++fnPnhZu593/zGh0U5i0+bxxDYuaYnUoVbyAJZdpJWLHqrUArSjOL4DbFKQ7fL/Uxj1jUwX29bePJzmuX4nTBoerUjK2q1KHcM03WNq1Ezlfb5s49L45qSvtsQfa7VGVVF4+CSR/Ve2aU/OzB3/fVKmpOLQUkx4AtjLFN/8y5iGA8paSDscFIb4nxX7+wBzn1y+Cezne/sbOQLDkEZnPj3q/RMGNU6aGXsejwXNlHynWEK1J0oCF3iE5JlQqtAc19MYxXCQMGRyVV4wOs5e50Sb8CoPU5kfKzMsZLYN3fQal/JNW2PVvCRkyJeZDwj3rQFa4LtJWDPw25ymnjWZZr1SkK5SKq9H30kM6KErxqgVYZBSLazO73S9hQ/GiSj0Cu56Zhs/8l4YJRURf97pU3GLzaDfd3FxBYSnwRZQ+Dl2Cs9T1QCHdUBFznHUv/AC9OB4W4+537OEZuhZKq8aIGHwBLgdVZgz+rDm8OJPTDbRfr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e6adaf-a165-4e65-a803-08de2bdec701
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:54:55.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6r+WJptniq8HxrnzlrDnzRCI9+WiypqleBVDeVOOhrPXXKLXcdMl4RJJ/zqdqf5nQY1ZUigdiW3BAxRT75qug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250038
X-Proofpoint-GUID: 5HaZ2O-eGt44wP7j7VwKn_04r423X8z6
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=692536a3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CQSdrXTAAAA:8
 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=nrACCIEEAAAA:8 a=7ipKWUHlAAAA:8 a=968KyxNXAAAA:8
 a=eh1Yez-EAAAA:8 a=Z4Rwk6OoAAAA:8 a=K6bJOSjN_L0kULG0WO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=L2g4Dz8VuBQ37YGmWQah:22
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzOCBTYWx0ZWRfX6z0h2hHD352l
 pvnxAQm8yUvLLHxjGuwFwCSfUWPHGsNZ7/FwLCeXkXT3uEPNsAlZz12jgGtVyb8SfzkkBmc8rSZ
 /HB5vumArFGxZpRAAJtkbmzL/ZhA6aC5p7Yb84MfV51T/z1FjxNVLu0W8daYe+C0qyW4E7qPlgX
 FIDdez3cxrNVEzFF699ZqUU5NJ3dw+FHWzuW6cWtzMYKNU40kHEj4Miqdtf0mE5g8UGUy/a5hqT
 2akdbORQMcDvrbhTpX1TnyzS3/h76JNqxFv3Rv6XHEW2X3alzBh+++Xz7RwMi0dGeyeUPgDQMkR
 T9m9z/9ne8n5q8pwTieNmm91oTVju4ilvK4kyvNItVTIM7QE67Oi8Ulh6cnpypLl0rETUvfYgYC
 SRToGh4/QP4xfFXE2f6T3joyT/WVRfMctVkInUIxmECIyeyCUv0=
X-Proofpoint-ORIG-GUID: 5HaZ2O-eGt44wP7j7VwKn_04r423X8z6

From: Hugh Dickins <hughd@google.com>

commit 670ddd8cdcbd1d07a4571266ae3517f821728c3a upstream.

change_pmd_range() had special pmd_none_or_clear_bad_unless_trans_huge(),
required to avoid "bad" choices when setting automatic NUMA hinting under
mmap_read_lock(); but most of that is already covered in pte_offset_map()
now.  change_pmd_range() just wants a pmd_none() check before wasting time
on MMU notifiers, then checks on the read-once _pmd value to work out
what's needed for huge cases.  If change_pte_range() returns -EAGAIN to
retry if pte_offset_map_lock() fails, nothing more special is needed.

Link: https://lkml.kernel.org/r/725a42a9-91e9-c868-925-e3a5fd40bb4f@google.com
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zack Rusin <zackr@vmware.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Background: It was reported that a bad pmd is seen when automatic NUMA
  balancing is marking page table entries as prot_numa:

      [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
      [2437548.235022] Call Trace:
      [2437548.238234]  <TASK>
      [2437548.241060]  dump_stack_lvl+0x46/0x61
      [2437548.245689]  panic+0x106/0x2e5
      [2437548.249497]  pmd_clear_bad+0x3c/0x3c
      [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
      [2437548.259537]  change_p4d_range+0x156/0x20e
      [2437548.264392]  change_protection_range+0x116/0x1a9
      [2437548.269976]  change_prot_numa+0x15/0x37
      [2437548.274774]  task_numa_work+0x1b8/0x302
      [2437548.279512]  task_work_run+0x62/0x95
      [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
      [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
      [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
      [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
      [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

    This is due to a race condition between change_prot_numa() and
    THP migration because the kernel doesn't check is_swap_pmd() and
    pmd_trans_huge() atomically:

    change_prot_numa()                      THP migration
    ======================================================================
    - change_pmd_range()
    -> is_swap_pmd() returns false,
    meaning it's not a PMD migration
    entry.
                                      - do_huge_pmd_numa_page()
                                      -> migrate_misplaced_page() sets
                                         migration entries for the THP.
    - change_pmd_range()
    -> pmd_none_or_clear_bad_unless_trans_huge()
    -> pmd_none() and pmd_trans_huge() returns false
    - pmd_none_or_clear_bad_unless_trans_huge()
    -> pmd_bad() returns true for the migration entry!

  The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
  pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
  by checking is_swap_pmd() and pmd_trans_huge() atomically.

  Backporting note:
    Unlike the mainline, pte_offset_map_lock() does not check if the pmd
    entry is a migration entry or a hugepage; acquires PTL unconditionally
    instead of returning failure. Therefore, it is necessary to keep the
    !is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() check before
    acquiring the PTL.

    After acquiring the lock, open-code the semantics of
    pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
    if the pmd value has changed. This requires adding one more parameter
    (to pass pmd value that is read before calling the function) to
    change_pte_range(). ]
---
 mm/mprotect.c | 75 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 28e1a8fd9319f..4daaa75b3f12c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -36,10 +36,11 @@
 #include "internal.h"
 
 static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+		pmd_t pmd_old, unsigned long addr, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
+	pmd_t pmd_val;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
@@ -48,21 +49,15 @@ static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
-	/*
-	 * Can be called with only the mmap_lock for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
-	/*
-	 * The pmd points to a regular pte so the pmd can't change
-	 * from under us even if the mmap_lock is only hold for
-	 * reading.
-	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	/* Make sure pmd didn't change after acquiring ptl */
+	pmd_val = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, pmd_val)) {
+		pte_unmap_unlock(pte, ptl);
+		return -EAGAIN;
+	}
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -223,21 +218,33 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		long this_pages;
-
+		long ret;
+		pmd_t _pmd;
+again:
 		next = pmd_addr_end(addr, end);
+		_pmd = pmd_read_atomic(pmd);
+		/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		barrier();
+#endif
 
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
-		 * check leading to a false positive and clearing.
-		 * Hence, it's necessary to atomically read the PMD value
-		 * for all the checks.
+		 * between pmd_trans_huge(), is_swap_pmd(), and
+		 * a pmd_none_or_clear_bad() check leading to a false positive
+		 * and clearing. Hence, it's necessary to atomically read
+		 * the PMD value for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
-			goto next;
+		if (!is_swap_pmd(_pmd) && !pmd_devmap(_pmd) && !pmd_trans_huge(_pmd)) {
+			if (pmd_none(_pmd))
+				goto next;
+
+			if (pmd_bad(_pmd)) {
+				pmd_clear_bad(pmd);
+				goto next;
+			}
+		}
 
 		/* invoke the mmu notifier if the pmd is populated */
 		if (!range.start) {
@@ -247,15 +254,15 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
-				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-							      newprot, cp_flags);
+				ret = change_huge_pmd(vma, pmd, addr, newprot,
+						      cp_flags);
 
-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -266,9 +273,11 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-					      cp_flags);
-		pages += this_pages;
+		ret = change_pte_range(vma, pmd, _pmd, addr, next, newprot,
+				       cp_flags);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.43.0


