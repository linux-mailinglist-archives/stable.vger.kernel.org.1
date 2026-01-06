Return-Path: <stable+bounces-205076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA9DCF8241
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0F003042FCD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E88327C0D;
	Tue,  6 Jan 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dlwUI5KH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ipfMA/vp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF48312829
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700137; cv=fail; b=kHr7/Rw3nSuNd1u93fZMbj2PAvpJ3Ji7pOODhe+Fhi/KOvpeH0MI2ZNyzBTZWquFBfR+PEmrUIuHTpBe0WqnM/rQzdDoEBDw/ldwFNy2JRwYYSwcSw3lmf5rz+0cZDJAKhdYhgghi/sCSI1QkhRpq+8eUalNT3CF61QpjCvTo1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700137; c=relaxed/simple;
	bh=H4NMB0hzNJSNVh3G/F55Rn+HZE79OtelCavDGtmt4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLnlONFmsfjUCXUr+Ez+F5JN8KA+ccbTvuP7N5tqo5n+nG2VMxrvhfgesXw5B4AA06mmLfIH8l28t7TeOrcQ3Pfm8iKsNISlAt8zQwM/51fw9u33MEH9NCIgUaWaanIYPJhU2z6w+tO5dJVGeaZPfZCgL3y5qljiZcFt7fl+WOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dlwUI5KH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ipfMA/vp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606ATIZl4091076;
	Tue, 6 Jan 2026 11:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QLNEaU5qB9VsQ+4pbgMIvVXWW5s6j/JqN6UphUbZS5o=; b=
	dlwUI5KHTffKWVuM8dDq77d4Fuk/6BnOwu8JqA+4n5253LSnV1Cmh4TrVlZwZYhj
	t/4QMlVG7lmYVnbCiuw7pmdJqA44bSfnf7aMUx5gL+yyHwPkXlOVGAp0sb51mAxS
	a2/Oxgu2KV1+5IpDXkK+I3K0vav04kKNdSjO3LWzvVftydr4A1TTESsbUPepK3wj
	3Fc7QGl3lsM1qmA5v6IqOWEVzY6dfkL8ffMEduFTLrSjMwo9meAWZ3BPZHjeHXMT
	Faorh1I2twtNLbE925JxS2Of0QvGXkm6+dUsO4LyAdJ3r9GeuCxIBVr0EvRiC/hl
	iBKkJAb5fsDDdrKnd763CQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh0pd82fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:47:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606AnE2f026751;
	Tue, 6 Jan 2026 11:47:47 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj87yd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBjITf3KZdEs3k90Sw05bMEVPwO4a9kDW1VMclSmoSPUQEpYy6zKTDe62TWBPTBFm3DgRYofB89+T0zlj5KUBmlNLjs3CrgHpr+Sjp3H8nw4k3oAyLOe0JB05slmCBtQlZOGPGSbff++tezteaBJyBD0GRTh2PMUTWfOgb+8CpKkM/cZTmVmdZx1T6JiaLAdVukY6UbYtinTti041veJOaIrpyleSSDp1JiS6uncoNbVjZLvRRmKfhbC7ZrF8f6w+pVqNl5SbKKI8btuThjO+Bee33Ueiwun+W3JSMf2f9lZZuDjCD1Fak7B5MkqFpn1zvrJ2uMBFcSoOKnamUJIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLNEaU5qB9VsQ+4pbgMIvVXWW5s6j/JqN6UphUbZS5o=;
 b=wD99780xfji1QdCJr+/1gzrYtQf1IvgbmIMF+bje1yoCQubII9ghl+HWDaWKqw5yF/7RFpP2/ze1K37GCal9EAWcOIKG5plewqJG3rXswBqblLPe8QTdc8vCvg2RGzjyBFP890xTKis2ZtKusGfGQGXMw6rB7VYN6eAraltPLj1i/9aJyIU9XO/QaC9LUnJWRmmELBWs4Op8m/NS1r/Qk7+LHtc+2thfI5fH2FjurGE2R44v9gjju+hMB7xLjiukAM7S8rXIxidh02YTSxOZZlKHu17gF0iVjQbZxQaKwOOdxhlteJ7lndIo0dWD0qWF0npsUSNbHY1aO6nVTPoT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLNEaU5qB9VsQ+4pbgMIvVXWW5s6j/JqN6UphUbZS5o=;
 b=ipfMA/vpF+rtQsPFX6YlxmsNmvF/lXnVH3mQKvS66VAJWcW2Zhqit6W6XjiHJ98INzm3jogp9smHd3e/I6ENLyAlWF6pSfkmot+wEF0sUPTpKdsM/I9pWYlOcYyMM6C4BXA010dv4XWqi7Xe4bdYVLuEcVjVhArnDg2TI04t7y8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:47:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:47:43 +0000
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
        Yu Zhao <yuzhao@google.com>, Zack Rusin <zackr@vmware.com>,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 6.1.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Tue,  6 Jan 2026 20:47:14 +0900
Message-ID: <20260106114715.80958-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114715.80958-1-harry.yoo@oracle.com>
References: <20260106114715.80958-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0165.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 34410e49-7064-4fc1-b174-08de4d19670f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3ZQRHFPYTRnb1dyZi9pWGRtL3BUYXZrVkMxbSs4d1VMUzNOWmNiVEdJM3pu?=
 =?utf-8?B?cEdVazZxV3RTQjBrZWhJN0dPYi9zblNySmdNblRpUGdVZGdaNFRpL25DRzk4?=
 =?utf-8?B?MDljdTcvakRWc085OG9KQWplVXN5eFpXYm00UFltcXlER0dDTmlxZ0pONDln?=
 =?utf-8?B?QTIvM3FLOXpxcmFGbXdHaW9BMEJQQnk0NzdQellSRlRseS90R1lsVU1XZUdZ?=
 =?utf-8?B?eEp3c0F2WjJ5UzFDMW01QUt3aTN4QWljeTd6b3lSclp6bWxKdlZPYTBmTzZG?=
 =?utf-8?B?cUkwZUROeFBCWkpubUtUVkw1Nlk2ZVlBS2ZiYVcvLzJDUGpqRkFITU0zNFhX?=
 =?utf-8?B?NmdMNTErb0RVcmFpckovVEZRbkM2NzhQWkxoOGlRTDl3UGY0aTc5bXFqQ3Jl?=
 =?utf-8?B?VGJDN2hISW5QeVI5eEIwYU9PNGhscnU2QzQvNUxiNGlYMUpsYVdJRkpVUU15?=
 =?utf-8?B?elBBRzJyaEpGQUZNSGt5WDRBUVQvWTRkSEgwOWVqcVZDNHU2dGtmT2ZTTDlK?=
 =?utf-8?B?VXhwVHd3R2oxMjZiazNGZjZUWk1wOHYyUGxldWxIdUZJckErcWlKRWlxWk4z?=
 =?utf-8?B?TnRpSU5TVncrZENPUkNVa3EyZlg2Wm1lSWx3K0tYYVVMMEFPekNpWTJzeHF1?=
 =?utf-8?B?WmUrT2FJaEtqeUF5SS9NWmoxNmVkMTBiTHF0cnlTalB0ajZLWmNKT3VZRktz?=
 =?utf-8?B?eitqMk9VblBzMG5vNnM4SFJvSk4yd0FUSU5rNi9DREg2dnpibFNTK0ltNXB1?=
 =?utf-8?B?SW82WFpDL21BRVJib0VxQzVGcjJWekNXbDVlMkZRcXlOT1hhVjdYQU0wOXhz?=
 =?utf-8?B?ODNkVmkwTDdGTFB5dEI5c1NZbVJoVlNTd3FFQVB4MDRiYU5JZHpjUHlMS1V2?=
 =?utf-8?B?SWlnVXdkVk1JVzNRQlZUYXRRaGd5Q0YrZzZ5MXVqTFQ5YmJ6Mm5wODFKWXVL?=
 =?utf-8?B?dVJVT2p6YWwzcjM1UCt2ZmtyTU5qbk1FcUdOVVZFTEtzSWp1TFFMZ202Z3Bk?=
 =?utf-8?B?bW1pUXRtczI3RjNqUzVtY05mNVY4V2xzWHR1QmxJNkFOZ2VpdEdXTzQ1cnJC?=
 =?utf-8?B?VGFaeTRCTTRwZzRBNUR0cGdOck1CUjBsNnRtT3FQWkJqL2VsRzN0N3c3OWF3?=
 =?utf-8?B?bEh0NUtvQVpYcWRtVnVUalNWKzFFUm5kODVrSStwMlVoYUxPR3dwM0JrVWdx?=
 =?utf-8?B?OFI1TGNaQ1RtNHQxa0Q1ZG5LRU54NjJmZUpMYkUyN001YjMzTzJCdUZoWWNS?=
 =?utf-8?B?WWR1MlkzcGxZZlVjUjJ1RDhQVWNxNGplb2dFVXZ3RlMxUGF5MkdNZEU3a2dT?=
 =?utf-8?B?YjlNQ2I1V1QxTjBuejIwTTM0aHNWdkRHclZxNFo1VjFYR29tdjJVRjlwRWNW?=
 =?utf-8?B?RnlDd2ZrTUxjL2FPR3lhSXF4QStQQW9ydkRtYmcrWXkrT3BYQTV6eXB0bGdz?=
 =?utf-8?B?MG5sWVMrZ1lQU00veTVzVjBOck9MT1Fzc25vc2o5RG5adnBKRURjSzk5aHdL?=
 =?utf-8?B?UXVmckoxK004aFBOM2ZuQW5Pc0pnVjczM2F1YXZJa2k4MUFld2pKSWlCUksv?=
 =?utf-8?B?SjNZTDdEd3ZDNTIvYTlvUDhmc1VneVRaVUxYOEUxR1A3UnI2MXVVaFJLQUtx?=
 =?utf-8?B?Zk10amZwSGJaMDQvbFJsMndxbDNxSkh6UnRVbDRuNEhNR1IrTmxHSG9xejl3?=
 =?utf-8?B?cEhEa0JVSFVBbGZIdWtZd1lHeHI3ZVByK1JCMHBNS1FYSytEcWo3cEc0UjZH?=
 =?utf-8?B?bW5mWllvOSs5T1k1M0U5a0lIRHQwQ09uUUF3cVNLdnhrb3hlajZhanFETnJT?=
 =?utf-8?B?YWRtc08zYlpGeXpRSkFzTC9kKy9PTWhSZThwTnhMWHlVNVFTWU45bkVhM0lN?=
 =?utf-8?B?cXc0bEJqdXlFajBaMnQyeVNsS1NEQ1k3bUR4QUV0b0U5MnVkMXpDVHptMjR5?=
 =?utf-8?B?UWZDb3BxRGs0cUpvc3ZjdkpGRGpKRVBVcnpaakUvL0ZvMUZxYU5kTXdGNytr?=
 =?utf-8?B?Y3pyYzRqMHlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0lqZ1hYOE1PbVRCalI2dTY4cUk4UkwwZmxRRjdXU2hEL1RZREFzTkdDVTFn?=
 =?utf-8?B?dmJ4Tk4xZnVUSS8zdFgyY1c2VVlDeGlVTjJ6ZlFRRkg3czJmdHU1dVJyVURP?=
 =?utf-8?B?MHliaFhNTnNHTTNReFZJQUNiY1Qwa0pTckR4T25JZmQ1RzZ6c3psNUZHempD?=
 =?utf-8?B?QS9VR2FtR2IyVWdGMUtiT1FSbDkxSW1RcmdaQ2o2OUk1YTdvUjNwYnEzdTBJ?=
 =?utf-8?B?TkNaTjZpYlozTW9oa0M5RTVVN2hha0pYcFM0a2RJbkNnd0hocFBiT3UxK2NF?=
 =?utf-8?B?eXlLZHpoeEFxOXk2QStUanVjTFVNQmcyMEwvbWMxSHFXSjVHSkhWQ2tWU1lB?=
 =?utf-8?B?L3dEbkNrWGZkaUFhR1NBUkh5MHFqMS9CT1hxNFJxRFpPdk1FS0JPQmI4N09m?=
 =?utf-8?B?M29JZkpnT2UxcEZteVdkWGRuck5KM1JOZXVXVmt0MWdxNGtTd1BTSmR5aHBN?=
 =?utf-8?B?ZWJZWmQ3d3MvclJoZWMySHBFVXRVVEdKZGU4S0RNcjRuNHVRcnNwMVFzeUg5?=
 =?utf-8?B?N2VMaDE5aDZVNWJOVEp3bkNNRGFnZmVOYUY4K1p5aDV6MHZESTZUUXk3NU9L?=
 =?utf-8?B?NmJiaTh6U3FzdU1QaE03SGtXV01IWXl3dWltWm5HS1J0N2tDMVVFOC9FVThx?=
 =?utf-8?B?bGdReDlIdXkwc25xUFlKWTVRY1lXWUdZNFg4Qno1QlgrVHVobGZqYkd0akxy?=
 =?utf-8?B?cmx4ZXprcVBNbUhQcGdZMG1WU1plT2cvL2lRSTg2ZERMSVg4eThRNUNEVWhh?=
 =?utf-8?B?cTJ4T3JWTkJtNURteTFVMXJoNStPYnB6d1ZMWitHL05ZMVpLQjUwekFMSmw0?=
 =?utf-8?B?Ky83emlueHllUWkzZkVwdHB3OFJYeDJUWnZ4T1FtMGhud3FkVFVTWjZ4SWR6?=
 =?utf-8?B?Y0ZqTVQwNzRWdzRsWW0xa013QmZ4WlVOTGttVHUwb3l6OFBWS3duYWoyM3JT?=
 =?utf-8?B?UDFsVjg5eUJaVmRjeVNaVHhYdXJLL2lQRWVRdmRNZXlFQnRTSHVialA3R0Nm?=
 =?utf-8?B?L21WWW1JWlpCTVRYcnZkVkxmN3k0eTloenhTemZlcGd4cm5iOGFYYVhLdnNZ?=
 =?utf-8?B?ckN5aHZ0N09HVUxGaldiT1hVU29qSVdIRmxmSDJ0VmZnRitaQ0djY1pURG85?=
 =?utf-8?B?WkRSai84cTBrUHNPTjZiMEtyd0NIbVNGb05ENVBya0VBUnU4OTg4K0M2cUpp?=
 =?utf-8?B?a0dEajVCRnNsVUZZRklQaldjM3oxODJOcldnWFhleWxqaTlWa2FVemNYQm1B?=
 =?utf-8?B?QVlQVFhPSVJpK2V2WFlJSlhUM3U0M2J0bkRUNE9qeVI4eHpLbFd0ZlBxWkFk?=
 =?utf-8?B?MjRjNWpUUWxzUkhTRHN0aUt0bmV0SnYzSzdnZE5MaitUY09xZkQzN2dFN2dP?=
 =?utf-8?B?UnFjckl5N3lhVUR6WGlMK3daVTFTK3R1dm8yYitkVk1BOEpDc1NWUDIzSUFJ?=
 =?utf-8?B?TTVLTHFHS0drSWxYdGlWVCtCazkwcWlzY0Q5Nklicm9hdWVERFVVdWo1VlFT?=
 =?utf-8?B?b0lkRWw2M2piRjNRZ1hTSFl1MkZFV3BxZ3lrS0hQYktqVDRaaVk4bTY1MktQ?=
 =?utf-8?B?WnBGUEQ5bHMxYkcvS2pVVVBnb0JXN011NjRYbXZTZnVNckx0NEtnNGFtYWRB?=
 =?utf-8?B?bC9mWHU1WUtxakxVL3pwV3JhZzhETW11TGZibjNYc1RJZlVHV09CMFI1bzdZ?=
 =?utf-8?B?V2d2UjlIdXBibFR6QkZtbzNVZGpLcXFyWkdWSzhQUDBsV1hUeVdLbVJ5VGlr?=
 =?utf-8?B?eDM2ZzVJUFhuYzRqMEV2WDBYK1Q2OFlzWExpRGZVRk9uSTVoTUxWdDhkWkRs?=
 =?utf-8?B?TnQ5WjJCUzNWcDREdmhyeGZOenM2Ym5vV1hkblQ5UW1WajJzTEkyb0kraENp?=
 =?utf-8?B?Yzh5WEZTallsbnA1K1JneU1BdEpGb0JuOUcvcVhCZ3cvUVcwVEM1TnlrcXR0?=
 =?utf-8?B?a0JvZXRsUHJNdDBLVDFNd0FuS3ZwMmgvc3RtYnpKcDRNSGlsTGtGZ2NHL3hY?=
 =?utf-8?B?Q2dNSE5MMGxVUDdaT1VLSkhTbXpYdEoxZHlkTWh1WEE5UWpGTElDR2FhZ1hk?=
 =?utf-8?B?T2lLeUNGajJNU005ZVV3YzFvZkcyR0Jna1VaS1FvL0IxQW5ZM1lYbEkrdWdE?=
 =?utf-8?B?dFhHTm9EU3owN2c1TXZuWXRKUmZreDNvUTNYdVdMUFQySDFRdnNuNUdZZlRN?=
 =?utf-8?B?NS9WMEFhZUQ5dzhVcVRXMEdGamVraEprWUtxcWNmQy9XSys4YUxZeXpoVURX?=
 =?utf-8?B?QVFzaTZ3Ni9OR2w4Qkx4bzZpZ1UwL0UzUzlSTHJod3dzcWpERHdtZ2V3Qnpj?=
 =?utf-8?B?WFV6NXhrTVRlUmF4T1o1bS94bFc3U0hFMjJlSGlxL3I5WFVOMlp0UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z8bYUz+ozJcPYUAD4+sPh5yqU+pmcI7U6oL1MYPgOul27ow1F7gs9rapMVwBzIV1UL3DZNZPZJHSx3SfIlYMGS4xawZPi8YwFu+qPiZBwpd7YVX4g50tKGn6JZP0JwAFQniWgfixNLrVQy8Q+RK5nWy57YBgVtdxHBHNg1zKQ1x4Eufcum5jdoFLhCTSnosMEWUe3mrK0nOadbll7fqekdrr9HjNK2Mm5bXlQ+NB6baSuDkSI28kzVJauSuan3ZMzvLs1HIq7gHRoMrX/eTJRo5jXAM/w2U8H+2KicUjkMPATwpyrn+1zXH94oLrRNyWOLyTiF+X9KnDGxTUTs8l/bs4GQYaM+89AyuDL6Ig5OsEasGkYAj6YTzUCNyDiNry/hmnhYLpp7QrNNbDGywKXG85I0NIZhsFahL/EAeLWb6KLgWHhAT+jyitN5NuwU+zQ3eGbIVG6n3XuieM5Br0Vjo2icHMtzeKM77Pf1Ch1/r9bcwRDGVzAcO4x+67Y3c6X8X0lR8cmNyY6AkePBQHL/0EFwBQ58BkEqUtTTSSKGLNB7oRDBKixcpt177Lq1nnDwoXp8GMHgOF/aWJ+QDQpRiEtTyHYraLfxfEi3NQ5HI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34410e49-7064-4fc1-b174-08de4d19670f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:47:43.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb4JHXZg1AURgmx7AfsANcQHBV9060RSs6sKitdeQM/pbge/k+hbTrD0s/RCNxerxnVBSnyHG5Yl0MKJBimKKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060101
X-Authority-Analysis: v=2.4 cv=c5amgB9l c=1 sm=1 tr=0 ts=695cf664 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CQSdrXTAAAA:8
 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=nrACCIEEAAAA:8 a=7ipKWUHlAAAA:8 a=968KyxNXAAAA:8
 a=eh1Yez-EAAAA:8 a=Z4Rwk6OoAAAA:8 a=VIDqgc_yIPV4B56qbn8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=L2g4Dz8VuBQ37YGmWQah:22
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: CsYN2adJCHEfRjzqhizAfBBIu_z0OFNZ
X-Proofpoint-ORIG-GUID: CsYN2adJCHEfRjzqhizAfBBIu_z0OFNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMiBTYWx0ZWRfX6xkOUxxHwyvI
 q/Kr4fkVGDXMvRK8udsEy4K1bjmKQzpGraSPP43Y18FAR8lM2WuOhTs+vGzuJUaJz7t6z0vtKr8
 Sbd5iuBNwGFGOCts9cG4XRyQKukzoxA65Yp4Mt9N1/plVP3dL+F8LxW942emxLpsQdNjU012grk
 M9+ut5GD6mQSqdHXVhkQVvIxq8skInJaWud4x982gyxvcCUQOEqc+MDwEl5pGLLBcAv2vqkLsbG
 3cgd69i6Caa28XwQH00C7PA8f2M47JQtUslXO6hAHdBbAAntiVcJvMXCrHMj3cyovNyftfUHhri
 CbwI+mkz0mcoGCMXR/C9JqQk2667UzIJeyRGpvtOTPrYLtQHXFirdwKJD4y5gECq8BvBQueOT1C
 8u0e+sNoiAW+3xsQ0pf2ikIYkbI0fBMOoU77EjqDuKxKpPlqza4XACk80nh5bmyyq5GH3mgpic4
 W+oHM1wEQpnY0WzawIg==

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
    if the pmd value has changed. This requires adding pmd_old parameter
    (pmd_t value that is read before calling the function) to
    change_pte_range(). ]

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/mprotect.c | 101 +++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 58 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8216f4018ee75..f09229fbcf6c9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -73,10 +73,12 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 }
 
 static long change_pte_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
+		struct vm_area_struct *vma, pmd_t *pmd, pmd_t pmd_old,
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
+	pmd_t _pmd;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
@@ -86,21 +88,15 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
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
+	_pmd = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, _pmd)) {
+		pte_unmap_unlock(pte, ptl);
+		return -EAGAIN;
+	}
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -288,31 +284,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-/*
- * Used when setting automatic NUMA hinting protection where it is
- * critical that a numa hinting PMD is not confused with a bad PMD.
- */
-static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
-{
-	pmd_t pmdval = pmd_read_atomic(pmd);
-
-	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	barrier();
-#endif
-
-	if (pmd_none(pmdval))
-		return 1;
-	if (pmd_trans_huge(pmdval))
-		return 0;
-	if (unlikely(pmd_bad(pmdval))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
-
-	return 0;
-}
-
 /* Return true if we're uffd wr-protecting file-backed memory, or false */
 static inline bool
 uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
@@ -360,22 +331,34 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
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
 
 		change_pmd_prepare(vma, pmd, cp_flags);
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
@@ -385,7 +368,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    uffd_wp_protect_file(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
@@ -400,11 +383,11 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * change_huge_pmd() does not defer TLB flushes,
 				 * so no need to propagate the tlb argument.
 				 */
-				int nr_ptes = change_huge_pmd(tlb, vma, pmd,
-						addr, newprot, cp_flags);
+				ret = change_huge_pmd(tlb, vma, pmd,
+						      addr, newprot, cp_flags);
 
-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -415,9 +398,11 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(tlb, vma, pmd, addr, next,
-					      newprot, cp_flags);
-		pages += this_pages;
+		ret = change_pte_range(tlb, vma, pmd, _pmd, addr, next,
+				       newprot, cp_flags);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.43.0


