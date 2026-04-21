Return-Path: <stable+bounces-240058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMWKHk8o52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:33:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE97D437A41
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC77F30AAF8C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A33914FA;
	Tue, 21 Apr 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HBF/fQpA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA173876C7;
	Tue, 21 Apr 2026 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756061; cv=fail; b=JL1235HnAukaKw1jU3QYGUZsANlUW+kWt5GnCCQ/wihe1WqzPJd8EXHAwmPJgXVbSSl/vwYvXtJ2h2glYGl+arIQohaZzgu8pmYriItHvutA+TmH5/EeGCHNUb49BWb68OnExP8ZmtNSs/h2EKD5a+KNs0cmDth84S16qeZ+Zd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756061; c=relaxed/simple;
	bh=TbRnsEoV/zQU/lZ7WRiOkg51Aesh32FdloyvCvsj/5o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WZ0Sbe5mywS2tD9pEMiySy2GS8vu8aYhztiM3XMlVLBYd7eSRDinjv1WHpnMAJ6CxZQ6DTi653DKOEUhCa4aAIkju22A2o9y8yGOKJrNRHiUDuNYmDFyGxNdcOWA/ZJ7ic5YK9ygQQeTXckT3AWJ5EEQO8yRUseeStGPlFRtEYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HBF/fQpA; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L4P3ri791542;
	Tue, 21 Apr 2026 00:20:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=yVt1lXOjo
	qKJOt3Sluka4whKxntqJUUMLjccwd7PEZI=; b=HBF/fQpAojdE+V+oNwCbkR1Ch
	OUPJmTK5Q+LT/p7gfoJwWIi52UOIRAmwJTQfs2OjuO/4qeuefMS1Lt+hr0bBjrFR
	YvnNgrk4d75ly8ExXw9Y9LpHnw77dqK7nhvHwUQLnuYawRLE9/Fpr1OCTiYUB4pm
	5ow8L091bA66Et5LbbrBHJMtsAO/sNgZECD1cqS1D1w0UFp1sXx3aGHx4VZ0qQKP
	W4AygzZ3qBOeS+7hjB1Coj7VifWIzDgyjbJJ6h5aqkXMqHsnGgDY1Vlb7NbqSm8r
	/p5HMaDtGN3UC2DRiAlFIqazONOJ3JUahTbCxHxiOqJQe9iHFA3Lbl4qasn6A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dm9fctsbq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 00:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nab2Oz2umQVU1pOcwjNQKvD5YUw8gddzTPmsq6VFat8dzC4lc7XYr9RuDnqTXyelv9tMWtAt0B5wHTgvn2ltHmKHBAqDy+dRMmcNznw1WbHn3/vp0aPABWA7UPzaGWxf0p6FHH4uGQJqGV2tiDBdbLrMvhyymvaQgaBmwiARb10JlpG+ugwLaIMqMDyi4Se/wuiQ4K9FwzadC3PFoInm1V8p0TXp4rWXfEN/72hOhlJWUm+keI3eDTbYjXL59T6q/+jeJHU9P9L9upeKQwdTNreMbf/+ZiWWbwFP8F4VJz3aOmFeCEIa+BAlvkyQXDh/DbPwpmbylNw8hF6uoUBMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVt1lXOjoqKJOt3Sluka4whKxntqJUUMLjccwd7PEZI=;
 b=R54BbNeKLTM4KsApAd5spLQjW90mSQQpyl9wO+D+0tp0NLDjT2nVddA2Wi/ok2dUwuZDdwUR383xRCYoXqZpuERqUxTNZWsVsQaXXcvJPjLxSyP58G4qTfQDqhTsjqIphHMZ64BlnJKCqZfGr0oG803b2jds8R2hLFmEBbvTBXMSIe2B+pQIt0y2xhbE9LvhFqVMlgn4a7rFkm2ERSMgPO6Nb5osqwlnvknjYd/AIB+Uwv55Shdw+dq+RCMprBwtY6LtsVxr0pWYWa5tHbGZjNTG3nblsb3z7zm6LUxSJ5BsdLvbIAOVORUzm3YBv27f/Y7554VMQsPrfGvaSLlVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:19:58 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:19:58 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v12 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock
Date: Tue, 21 Apr 2026 10:19:30 +0300
Message-ID: <cover.1776755661.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIXP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac0bb47-747f-4f8b-d46a-08de9f76645c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|10070799003|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EYd4J/yDEaJDNXG7IZePC6wci94NAaJNEK256hSQrbRdexjbShUE4KjvQbVGGQVMKlssVu/YzSKrLI55ePvVyyqlxu3SzYLK7+QnTFbFnNijP52TBk8lf4giahQIeRKct3TfRC5cANlZulwFrrQxegdfznZUUb9d1bvIz3slHRvdQwr6b6pH5xcIoM04NDQTtRko9OkfqXb3oiVH8YGt6Mj3258eszws2MPBqyEsi6UT+dBRusx46nUD8O7M3bhiEv0NeDTZizALaNhiAr9VLc3UfmD/lK2n9VJed+zecbja0TXSDajnnBKyh6swR6OjXLszn5FpLK2yyRqTDJf0IC3v4vV/Y75rUj8V2W/8311/+rqeQHQeXI2B6GL6wiuiWE9xmLRV48bD3ANomKI2ImFDzKZkc52so2WnS7EcsokWzwC19jwEuEPJLRtH4e2Xt8bPXmGmOexKoRNY8uTGYbLQBXmR8Eh8W4b7ZPRKC8mr5l807ILgQJO7VM2cgQf5J6HMA7wtxXCNos3qOhQ+mZUAMOxAellrxBvR8+VZXMnDcI9ZzaaMjdKdmDcltbPw+F46YD2N0Q7Vgl0W0RjScDHsQrkGvuJqb8amBWcY/YucVsVnoLmnO53wxsglMG1pcM21fhRqkFGv7qvrjIB+vIuasgGEu/5SbB0cNi33jSzFYsmF9CjpMbTxQSkWvBrvs8UvssUoc4mRUgJgy8HqRIFLJcY8Hq0CPx1YxXyWX9C1fQJv27H8xKgJTWfZW03z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(10070799003)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ij7RJAUOjQq50AsRB0REiOGpItPbwoSwwUHrwOcXSA9EuDkAnhU4/Fky+egR?=
 =?us-ascii?Q?pzBpc+MMrDKhpY+hyQGD8BvtgKCdI/tSGtL33pwWGSA+sZ425B0srhpYXPUB?=
 =?us-ascii?Q?ZrIvrllCZp4S/hWtDfKeto/fadAL5qUmjyYgEz14u7ipMQkzazuYKNeW80jj?=
 =?us-ascii?Q?UifvFT9Yb+xP1g39Pa9bPcFIJbql4ktwmmdkOTUQ/2mso6bOjYztzIql+f+f?=
 =?us-ascii?Q?24nNf9L20XgiOxHPX5gDbl+aPWlePc5OSw+ct6h16EKFHdOuzDo4KCRoCm6F?=
 =?us-ascii?Q?mqrA6KWhH6TkV2B/C8HN4oRJnVF5wkOlcLiWN6p+Jmwc+ueIA881jtgyvhCz?=
 =?us-ascii?Q?moQjuxK/j0kjR9I3vzEeV2Cbc73ekTwpFTrR//f6nALv31Oe7K2yiOifi2BK?=
 =?us-ascii?Q?r11BkWR3IO/NlpJVxocuuFPk8D3jIdi1mPzhWLruxMv89bSznfNOU7fOt3dX?=
 =?us-ascii?Q?Pgm5ujwXC5rjF7CgLMkFqPlFeM4P4xR4EVLhG0cW/LuFmwQIHvNKQG36rtFc?=
 =?us-ascii?Q?77hyausjcA653GQOtwgZjEkOpPTffJDrCsa5/1un/N99lWtVhXJwbtkBOlty?=
 =?us-ascii?Q?XiOb5zw5P2iSsnEZ9elXEzh8cBKz8anOdvurKwQ7iIQuCuuGI2uiCuHM3HOW?=
 =?us-ascii?Q?rwvIGBsa+C0bCgYSLHZtAypXpEyKAESKSYcUjwdMaV2KIocWiwnOtBzEfIAO?=
 =?us-ascii?Q?c2rSDvuSbk0wsQiyacNJ/KCzXlzwhwwTNIeq+SpJOJ/b/SPJrkXYXDxJgo4b?=
 =?us-ascii?Q?4dvZy22Kk+VV5Gv9U+AMbur7vpZN/umbPlf3OrFJu6Hdli2zJWqTUkt8CwOl?=
 =?us-ascii?Q?NHh3iKcwM84R3nzNjihigC7ns2KIdynI2A1C/9LtEPa4rqmeE8CBBgM3a77J?=
 =?us-ascii?Q?PbJzytolcRQbX3sYLFx4liuzYrvo0a8VhQ6VFc1eq9YPReBi5VqlZ77yYPqt?=
 =?us-ascii?Q?cpXtWi3WKru4CKfRKdIwowMGvhXWnbgizSs42p+b/j65YMYJkKL+opVsccf6?=
 =?us-ascii?Q?naTNB6JZZEaXfdAJKMG/n0RmMXZcbpMGw74hExd/KmHutAK18+gExJTcKNFP?=
 =?us-ascii?Q?5tGkpBOSfmtXloMektRJV/epqTEYTYuy0duGm+UAI5GpTe1SP54lHRGxX/P8?=
 =?us-ascii?Q?gK5qDXEA8xR6RqJXhJd2sWRwEf8J3KnN+nOvmEjZoX//e/1BfCU+Z5Z4OHLU?=
 =?us-ascii?Q?+/vZ338ZpaDtbedClR3OCd3H8vLaWrKjn6R06w8sVzvkWzmXLGQKd7U4R+pU?=
 =?us-ascii?Q?KYVEZCeU3Ime80ijZirh4EbmSseRwgMZ+9WgsI5Gis2y8bte4Tz+uH+9kEL/?=
 =?us-ascii?Q?BDXRdEOcZaYPW30Y393UX/4BFZIt9JPItYGOttnQl+cvezzdVw8Z3Q7A7J2c?=
 =?us-ascii?Q?tqlFVd0/wIO/gi6t/dtEu237eiljDL6f1eDu+L5TVmzdplSE4EtFkLT1QIM0?=
 =?us-ascii?Q?m0nQnlsXQco7lH04PQCPtgZzjGw+5QwgWlVfdpAy7USIdi8sP8reOJlckEDm?=
 =?us-ascii?Q?Vno6bPdBg8lqqFaTGdd2vJxGoyfMou7EyfzhMeKU8QvXaNV/V4WLB4UC4YYI?=
 =?us-ascii?Q?B9ekyw4jhfRmS5qar4FlGb83gajb50ou5VLipa7slmg+aPsYUbkWAUj57DyC?=
 =?us-ascii?Q?y/p7srqPZ1IyCS4VoP1j3QDcidojOJ/eWIz7axuOCKf8mGCojGxwa+rMgyVU?=
 =?us-ascii?Q?LM/NmctAGjJK70GOPKpLXhwWq/FN8Tt2wwKOGRrZz5kUj0xPMJgz8MzR25p6?=
 =?us-ascii?Q?yI2KcycfzoFQCjqkezjAj3mM2n9ZA8tBKT9lgiTm+peFKBGvLUA55jB+C6ap?=
X-MS-Exchange-AntiSpam-MessageData-1: IRF/gzUJRgf9FCwjQ5fTDD2QMIT7h0UV1uE=
X-Exchange-RoutingPolicyChecked:
	Y47rKQZQozsnexzzA918Jw6KFnhQ9XRYf69r4E/WnxHnA6iNbJMD44lzij8/MBhiwYnGlPJWl+t4MLieXjY3uCzQ8oEbWwTXyXkU4/MdQgmxKxdwsck3jKIpeqJOfddOhvlfOj22fgARLuarcz2W1xeAITa4ESFa6fRCChJD3ByowC+BIjh/ImJNa8yyHV8aL7/FpJ7MDNpWvShF0nWWbGPlQxyrapLH58rPGzmw5fYvk8wwutE0Gd+0Z5UT1u6bdkNtBDtAyHuipIpRwSFOW3Bp/KLtMY0IrNHGfhhE5tDxmkWw8hZfM69nSQDCaZ0BXUSlRvr3K9rvAekwt3TSAg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac0bb47-747f-4f8b-d46a-08de9f76645c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:19:57.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6SyyJWbdN+BG3qLWcVqNKf0VxQEqdDMMxbGIhngnyc2HYmj1ubOnj0IWsz9rERUAY72ZT+e9ziQxhsBWAMMxQN0m/NlCZWG46uPzOhGDrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-Proofpoint-ORIG-GUID: ruGxn52gBBFYsz6Iylis3ia3enobIo7k
X-Proofpoint-GUID: ruGxn52gBBFYsz6Iylis3ia3enobIo7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MCBTYWx0ZWRfX3VKP3ENjozZH
 Jog+W8WZKhj8ImuBOLJoDkH+0TBclcv3aP5/cQMn7NicciBFEnLzvZPai7oMsHrVWf8bsQAIeX+
 bLkErA19UnBgD47QsJtohnckVZV5lShEls7EZJXO/VdkcTbjLBbqIJWeL3URbPzpczAGC6yli5t
 9MhiDWKU75Ea9ewWsVcec7A2bs/ehd37UgLe9nFp++VKFWAiFflly6hRvQfKDeWz3Q3CC849EEd
 33k0I5sKJVim8fYqFnnhFe7/ip+7svrz3tdNiNf8SfnOu7OwAxuaHrQC86abG+bPF9c+tE7uIBM
 zMuKQ+h64HKznjVfsPxrppJ+CsHH7QSvqfzf7/ZK6nXH5+jn+GA8dXT+xi6vwpGokJDmP6kzFIw
 pv8QsIZ9IOKUstda2BQBCF6151WiGn3eCS1ItSBn7hDZWMXFjseeMJCkhHSmuFPd4nm/1U/GGV4
 qRBUs805NBmJyWfsJdQ==
X-Authority-Analysis: v=2.4 cv=WKZPmHsR c=1 sm=1 tr=0 ts=69e72522 cx=c_pps
 a=eN70jGNn7EKSdYhrfilGAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=0kW7uK-nrfiYIzTTHL0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210070
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240058-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,windriver.com:dkim,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE97D437A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

This is v12 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events.

Changes since v11 (Mar 26):
  - Patch 2/2: added Reviewed-by from Niklas Schnelle (IBM) and
    Reviewed-by + Tested-by from Benjamin Block (IBM)
  - Rebased on linux-next (next-20260420)
  - No code changes

Changes since v10 (Mar 18):
  - Patch 2/2: added kill_device() before device_release_driver() to
    prevent a new driver from binding between unbind and removal,
    closing the TOCTOU race window identified by Benjamin Block
  - Patch 1/2 unchanged from v10

Changes since v9 (Mar 10):
  - NEW patch 2/2: fix AB-BA deadlock in remove_store() by calling
    device_release_driver() before pci_stop_and_remove_bus_device_locked(),
    as suggested by Benjamin Block (addresses Guenter Roeck's report)
  - Patch 1/2 unchanged from v9

Changes since v8 (Mar 9):
  - Added Reviewed-by from Niklas Schnelle (IBM) and Tested-by (s390)
  - Added Fixes tags for the three related commits
  - Removed rescan/remove locking from sriov_numvfs_store() since
    locking is now handled in sriov_add_vfs() and sriov_del_vfs()
  - Rebased on linux-next (20260309)

The AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Patch 2/2 fixes this by:
  1. Marking the device as dead via kill_device() so no new driver
     can bind (prevents TOCTOU race between unbind and removal)
  2. Calling device_release_driver() before
     pci_stop_and_remove_bus_device_locked(), so both paths take
     locks in the same order: device_lock first, then
     pci_rescan_remove_lock

Note: the concurrent unbind_store + hotplug-event case (where the
hotplug handler takes pci_rescan_remove_lock before device_lock)
remains a known limitation.  This is a pre-existing issue that
Benjamin Block is addressing separately in:
  https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/

This race has been independently observed by multiple organizations:
  - IBM (s390 platform-generated hot-unplug events racing with
    sriov_del_vfs during PF driver unload)
  - NVIDIA (tested by Dragos Tatulea in earlier versions)
  - Intel (xe driver hitting lockdep warnings and deadlocks when
    calling pci_disable_sriov from .remove)
  - Wind River (original reporter and patch author)

Test environment:
  - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
  - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
    versions)

Based on linux-next (next-20260420).

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/lkml/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]
Link: https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/ [v9]
Link: https://lore.kernel.org/linux-pci/20260318210316.61975-1-ionut.nechita@windriver.com/ [v10]
Link: https://lore.kernel.org/linux-pci/20260326083534.23602-1-ionut.nechita@windriver.com/ [v11]

Ionut Nechita (Wind River) (2):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs
  PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
    in remove_store

 drivers/pci/iov.c       |  9 +++++----
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 drivers/pci/probe.c     | 11 +++++++++--
 3 files changed, 43 insertions(+), 7 deletions(-)

-- 
2.53.0


