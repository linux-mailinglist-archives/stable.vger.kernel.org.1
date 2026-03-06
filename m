Return-Path: <stable+bounces-223316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOF8N6COqml0TQEAu9opvQ
	(envelope-from <stable+bounces-223316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 09:21:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA321CFF1
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 09:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1E44301BDE2
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B68372ECB;
	Fri,  6 Mar 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HQuuQoWS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE20371061;
	Fri,  6 Mar 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785306; cv=fail; b=olg+VgyDpUR0OkuL+zP7yYQzyGdWyYndKP5h/72AaJEJxR4oQPpncQKn5jqtmKN4//kDQyKss6Y2HCZtMYOzQev0Dat6z4Q8VYVBEZyOIdG7c7k2Y5VOXlQhad6AoBVka8JipOzvkgKDecU5e/AGbhc5mf0HqUMTOmw3K0xR4+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785306; c=relaxed/simple;
	bh=63UZeddyfkly95uAXHxYLNezWLSDFxiLOCScDQHjJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZxPPNtbwQCmEEi/akGbbfxV5hRqxkOkPzWzNxQU9jTp/SqM1bea46FeyB3ByMleKym0fwVnSUUxiLGhRlfyZ2Gt/Wm11R8ACI/DyOnLwcmh2BY1djU4KIIHaiouDDb0MIg12LX1ahGXCXjlPWruycLzYFRge5V1uc3vH9UGVfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HQuuQoWS; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265cDN93320685;
	Fri, 6 Mar 2026 00:21:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Xkv3wrRzenJm6LlytjmgdjQZxoHZcIVm+OWY2Jx/u+4=; b=
	HQuuQoWSe4LnTCGJeQf0FxuO/44fQqWGclrY9BwGjkeYc251Oe+e2mHA9Guo1Enq
	wOuHA1TMtvM38WO4WFUH2Cn5niWJO29imvUfL82DqMhTh8qGoqP34LgLWQjZTgQY
	Y57F4W5H78hRly0R/hpgl4KL3vkYGfnhhBCjJGPlA/ilRBttlvt48c1MmR4VbHfu
	tVQN/9cZWnjv1JroQQIt0f0HZ5ix6I4RrUXzdtbCTpjaIN8YhT/LoWOzI+m28Qw9
	UwnKH6C7apZc3zegGDcx4EHAfVPCD3TW09z6sopyRx4D+fNxDQhwqZFmM31ywhcf
	YCtk9bt8lv0OeVyR/MOvjA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cm0rgq60u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 00:21:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeWzZ11uLuPZczJPFM4118ZPWM48EoyRcvX7EP8g0gBpphUaFX6gXTOUkzExKiJAvM0hDR0LmYQChUppa5c1miFufTUPFIDRJiTwGuPd3nOnJvc041dw8F/O0jfZe52nHl8vZmjpKdyjfxhGLWwvc3PD3s2ogwhyHScRXqGFKw52QOXbZ0ABb+qbYnQulkNK0fxcFoWiC+YScHS+1PjE+utyJhSg88oEK9sPP+++SBwEHyMuk9dqJ8vG60SSzLrYnzyyDtKdc3D2WKEHFUGNXsd7Ni/GuRvliayhiSyNdOPwtabhc/vlY5SpC2EAOACXTLVakBrfroL0qu19Sk90RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkv3wrRzenJm6LlytjmgdjQZxoHZcIVm+OWY2Jx/u+4=;
 b=LHi9NGhwWRqc+iSYUOFJwvIQgMh7AGt2q6WoJVD6Ife9Hxws4ngxeqLkpQUugEpfEh0X6aVgLNiFucEAFTiNdAaAyoahkJrCV8CGUk+uUyo+6Wry0Fie/0DeZ+UNXZCeYcF8YDIUMh1u5PhoarlHVWhDZB5CcUkkDz9ngdE+2uEjtc0jFVzvlJEUJ64I8zfgRdLFbSCxjMhquhls2bmNHSgaXcooNx5uJjlUgsLlKAc+hCpH34dLjaURDER8bozTumScSw4CnSIiVbWP7mF/YZrYUk7FdduHrDQgkx26v6C+r5ouv4yz+kPocdxhitXL8XIlbwT08+zrXjDDjrv9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS4PPFA424F92C2.namprd11.prod.outlook.com (2603:10b6:f:fc02::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 08:21:32 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 08:21:32 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v6 1/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Fri,  6 Mar 2026 10:21:08 +0200
Message-ID: <20260306082108.17322-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306082108.17322-1-ionut.nechita@windriver.com>
References: <20260306082108.17322-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0090.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::43) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS4PPFA424F92C2:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d90fb4-1712-424a-b013-08de7b595fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	vpNjkaoUr/NCnvQhVkQgkBN5Afp/s6rfhOh5p4BC/oXpnDAiWzl3IZuOEjWILCKP4OgGW3pSHCFPmIoe6EUiXxUEXH0PElveB/tndASz9fFWML0TURKFbDkPRKRbk6DiOSOtG3MZ1HKhRGVqkVh8Xs4SfVUIE9sw+LIe/++FLJrlp0lAPZjwDVCPLwxcDEeskROP6LnycfaTQsr4kf40owsnkC9NCaa4lJVXKqe0zejO/E1VjJmx+fjNBnFix2tXcGdHX6R9AuIoV04yCITDThCdikABEmT89iTj+KSF2BwSJIMuao/17vl4EHIKplIS4DCbxbnZopHZRQQSnpgIqIRts4ao/mEt/muCTy+X74RnXMx/nR839G3z1R45CKZVSLNS+G0eaM15omLZBkBCIPjFBMi5nGIyszznkRA+gMiQ1BSmyoUtyysZYcIgb52VneZW5GJDe1xe4Emvl2oTd+pSaDn9PQSSAr7T5K3SQkDNfrT91aMky4dA5v315ivM381iyZZF6HvJL2ZUsxD/+Cxo6GCIUA1kcZaEKJqnReWKjunUxnBBikielDLH+kKIVoJQSpSMGuNkl6zL7Fc0RqHCKzOhNfid8imif6TstQzP6eTvAskXd9r0sr+AOsC8oQ5r0ISjVvhwR/o12lQV/hDlitVCUs2nBVmSWHSIsHSQ7td2PydoPjhnS3jkAvM7/bA8b1NI6WZTFn9uBW6a2Z9ZrdCgRUxpndeu1a9hOLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7JngytDa+LLS2l/qEFZkpf1oRTe3tJ7N3YC/0q0N+55Th7aJNd1PiZDkcAcu?=
 =?us-ascii?Q?lOfcOfXHZaCQsDzab0PJpBSmzdvRCg3Itysl8Yw/aeVi0q+kOhl3mdE35G9r?=
 =?us-ascii?Q?YurMgs6cs6nYAflDfv0Hb+iadqflzf7F194aci0MrQmvYIQfr3Eg7gJ/jIrS?=
 =?us-ascii?Q?Oca2vY2RNV6s/HtmNsHlRFeLFW9lAwQ+cD5kVN4lyShxPKjkWHS7hYSR0KUC?=
 =?us-ascii?Q?4OZLDX8SJjWxMQctnq3J2CHcghYaGO4KCCaVFngEmTBIsqkPf47zhuybqbuY?=
 =?us-ascii?Q?TVeOQ1ZRfSgNhzx4EkEAG8j5FZDcINoa868i+zMjC6rmIFJQKR4+tEicrpH4?=
 =?us-ascii?Q?V6dL59V6/QcqfPOuJaMj7OG4Ut5GaNhkxts7/F67MiPGOvOQrOEaSigN+CtC?=
 =?us-ascii?Q?jVDP/+/1BRW2QxpAJby6mbWAwzi313CjckDrfkdWxC38h6HWD7rTfuV3qTS0?=
 =?us-ascii?Q?SL+Y/++TkB3w/UvCSEEUospF7D73ivG7iTX8SPWSyiqakvl4By9ptY2BnoS4?=
 =?us-ascii?Q?YyllF9BIGnZ9uuV5EDkY3K4J4zgBrHt/RS0e4W5V/buuxzXQ2d/25mpJg8Ye?=
 =?us-ascii?Q?4yNB4ZWFYa/WIibtrWevTWrL2d6+iSAacw8R6CtSQbPA8oE/ywDHg4i0/9Zr?=
 =?us-ascii?Q?mCdNG7i6whUQiHrsYjk7Fg+hEVskcHr3d9y9yDWArAjV+LXlVapUnIRWRjAc?=
 =?us-ascii?Q?U3LqwD0ssHKYvvn9FC8Tcp4cHHcKENrGgkM2VpEG4bWJHOlpScUqj9aU85FV?=
 =?us-ascii?Q?RcwckAYODr/b8JqlZz17Vo0auDkfEYXSGuNZYsVH9Jbs+tRNGg7CHIdkzCY8?=
 =?us-ascii?Q?5Pa6MMsmFGjazbn+4ZWDyDXhJefShjwphPN9b/H42XC4OgEaa6KYcYqY6M4f?=
 =?us-ascii?Q?EJjordS7WgqIXUFI7Do6OtrBm0X/eyKEioaNwSYFTM26tcMdno5SjEA4nm5P?=
 =?us-ascii?Q?S7hHgeEDu49EkPfSkWBr12PiLL8ushZmVheC+uso3rIkaurBu1cF8mKs5abk?=
 =?us-ascii?Q?/BaFg+GoTED7COlnfefcCCEIThue1j7mkrFQDcu3wPB2gKBrMVR+irBwhvts?=
 =?us-ascii?Q?IUnocVjuYdDGKF/8IHly25zCCSShUJzXPeLE3kYqLBFhkWBUg49hJyHwJl5a?=
 =?us-ascii?Q?dEkVJN+Uxaf6zTEJSDYGq5KQRu+s8SZKdedX7rjXLyA7ZE7HTH0WvaPhXYqm?=
 =?us-ascii?Q?jqf4u2UMAdC1vuEDB9Th0hG6mcJEyX/kF/rObAhXJuzc0yHNWXupMafGUQ7j?=
 =?us-ascii?Q?1UJcF8X3o7zuavgA740S7sgW5eFOW9DYDR4txT3KyequriKs/pg6qyAGVsk3?=
 =?us-ascii?Q?L3s3QSDKMSY6TaU+oD1TZAYVlP/lNUMdOat2hAgCpMnN5ZKtIqpZ+L3ocYdo?=
 =?us-ascii?Q?DCin3gUDP7qtG8muhH8GNzsH9++yT3d95+UugU6C7LB4hOAY1uhaQ8IQCKuv?=
 =?us-ascii?Q?W1JR7HO7Av9OzmLJF4qu1s+sybWpu+7KWNJ3qCOw3veXubRTPjP4PG+WewjG?=
 =?us-ascii?Q?hXLJLLT26lqawxd3EhghzFaO2kTK3C1QHbZ+eVoaz5au2AqSCCLqiumYoG5x?=
 =?us-ascii?Q?kiEnQul1EC63kquzfkzbDQIfjAVK/zO3sWzuW5mHzfungZnYaoHusuGeDDnH?=
 =?us-ascii?Q?2Mj7IR9MfzWugmz7fh1/f4Br7G5eGKjNViZ6V6iHyyaMV0diJCNPYHWleACT?=
 =?us-ascii?Q?I/8tbLV8ylCLNGMahqLGrwYe5YF7nn7rUW2Gooe7CGAW+u8OZudcB8zf5TYw?=
 =?us-ascii?Q?USLzvYe8Ro44qOt0ysy5ztPszJSsAufEUxZyU5W4U2O0hK+I5kKMiiYhnVRO?=
X-MS-Exchange-AntiSpam-MessageData-1: 66vwxm8gs2amEpDawLbYEnUcNYj6J+Sbp3s=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d90fb4-1712-424a-b013-08de7b595fd9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:21:32.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPK62ATEHT6vQcgXB5YQQwEbipxQKCNP4yIf0Uk2fIsLkyQvuTGdBh22/mDY9VdK/SniFSIkScUi2xkAk1/TWihz9ysva/UaIc8ksyiehiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA424F92C2
X-Proofpoint-GUID: A9vurgsJognt9yuhUlhmmyum_yBYlfP8
X-Authority-Analysis: v=2.4 cv=Of+VzxTY c=1 sm=1 tr=0 ts=69aa8e8e cx=c_pps
 a=OTtHDJnq+OHIMh0/YV57GA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8
 a=6S3VQf3ZLieD-afqmuUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: A9vurgsJognt9yuhUlhmmyum_yBYlfP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3OCBTYWx0ZWRfXw4nhLbON42kt
 p8w7nxjlmDaDpGmosbGFclmk20FB8nPwYyIUCiYDvpBSrUqKJBSn0W3ihSOpqcWX3GOGG+OoxhV
 oJlSzRF+FtczDd1MOkT6nM6hOPJDrDr7NJLouKR+bmPBoS4P1iPfirg1WVVzoYyWiQ4zYrKf7bv
 Ku4QMfufQkUZbyL8haxGq//vQnKi7SJeWyuFzTtnKWMUex3urBSvG2ARp6rF6790skL7mgs/eLQ
 YE81n0TDkCPqwkyWCUG9LaNUmfDNEYdZZHiKAPOTd5riBFdzXcSbwkXtR+Cqs/CZgSDRMpokmye
 w5H++dNUAHJK4lilsY+5xJFvjPYGKMDwJ9lYMsrtJDY2CkRn97ON8hkNeqx84QHk9yQz71bnziv
 fNDF96VH6bnF5exhlAsl1uhbiVIkOotAEDAAhNBaGkXRNTdlrPbtUS5WkWpi8TxfeHGUcR9QUSj
 /8Yn2XEDGl5gPY+x+4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060078
X-Rspamd-Queue-Id: 81CA321CFF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223316-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,windriver.com:dkim,windriver.com:email,windriver.com:mid,wunner.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant using owner tracking and
a depth counter, as suggested by Lukas Wunner, since these recursive
locking scenarios exist elsewhere in the PCI subsystem:
 - If the lock is not held: acquires the mutex, sets owner to current
   task, and initializes the depth counter to 1.
 - If the lock is already held by the current task: increments the
   depth counter and returns without re-acquiring, avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, providing complete serialization.

pci_unlock_rescan_remove() decrements the depth counter and only
releases the mutex when it reaches zero.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  5 +++++
 drivers/pci/probe.c | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..aba2fb90759cd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -633,15 +633,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +769,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd794..c7efb8e1010d3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,16 +3509,27 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static struct task_struct *pci_rescan_remove_owner;
+static unsigned int pci_rescan_remove_count;
 
 void pci_lock_rescan_remove(void)
 {
+	if (pci_rescan_remove_owner == current) {
+		pci_rescan_remove_count++;
+		return;
+	}
 	mutex_lock(&pci_rescan_remove_lock);
+	pci_rescan_remove_owner = current;
+	pci_rescan_remove_count = 1;
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (--pci_rescan_remove_count == 0) {
+		pci_rescan_remove_owner = NULL;
+		mutex_unlock(&pci_rescan_remove_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


