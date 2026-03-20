Return-Path: <stable+bounces-227614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PSbD2OuvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E052E0D61
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3835300E273
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE632572D;
	Fri, 20 Mar 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Rfl7Ul7d"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B7192D8A;
	Fri, 20 Mar 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038620; cv=fail; b=jUnG1fXIGgL09aQzkqyFpjTEi2TkSgF7P1rRuIibdPDKXDZdw7p+Wrnk8+28N5qGkHQH0/R2KtMUtM8OBy6WtAWRBAyKwZA/Dt7anfrn2oWPpJMj/+rqx+9OHHWalCBD0f8H8BsBP2DXIkjIfsL765VcAmkuaGPgkfnnSmg7QLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038620; c=relaxed/simple;
	bh=PjAqXuzy9Hm/HoimhWfuCbyswNd6TAcVUDwv3QC0RCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CI17XI7pXTLJq2FY1vo7B5C913hB+SoZ8qmE9MIsOAUpVPKV9uCvs2dV6vj20nIem5XENtJr5vupdPfzRs7W+Q7v3AoHP6enaWHRLaVcMqpMnFU5QXYnYJ1Ngc8kZwSgGIciB5pfueR7+rYHphIk9RGUlxU3xYjL1OZFQaN5d3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Rfl7Ul7d; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8qba0324122;
	Fri, 20 Mar 2026 20:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=bg1MSeWsaylI9oncR1RP5yIgbmKkSBJxeiHNIngjTGc=; b=
	Rfl7Ul7dHwBUDO29n9Ll/OLT9l93rhCuOJ+XQiXGAs9sxQ8oRAoM13euuTjgz6/9
	jGlck/LJsAx0W1o8I9WmObQtD56QTA4wRNNxDvg8SLYDTPQGrYjieKNTYlHV/OY7
	g5+ocS/ln3RzdnepdBmk67oFyOqdZ9iFOIcuqTeC9nT8nLh+YdbI5/dygMR1LYu5
	gZ2ewZrAmu8mHfQi3+CYxFlUBcuxUtYdkThEOjfZPE1winEBn10BWcw4eS45WSTA
	mf1uwfrx+3578gVCwniJvIJuISAfKEl+HsA18cQ2JTvxZwqGHxFVegochHzwCFCa
	UNrTBtSkNq50OWebWv242w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9anw33g-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:29:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtCUK3RVn/UCmJ8FetNOYy58KFCzEeuquM4Z8m/wg/i5NhIeL5Ut3fjxDJHSKuJMOVna87cBv1OdPbQiQLjYFIbHOJI9MEC7FVKfw/5kla3T6rOC/DZRf1laafBFrWLs1NZBy8A9Cs0oxzgMU9t8RRxvifDISjZoPT3krItzl5QiHrFsoXkZExZU3lXlg0Kxn2ywz46toNlH55qrMxC8nn2n6K0uY4YyYvyeDIaZq1E81Vrd7fRgz5FWZBMgL2wpE98jVpP8IHF/f9JwornK00B3VvLqPnyQBwAo6q+trDjSoGSXGC17tG9SMbiAk+ezAPnDOTZKCXT4AnMUSLDjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg1MSeWsaylI9oncR1RP5yIgbmKkSBJxeiHNIngjTGc=;
 b=V0u2NK4IDf5yO8nyXL1iqsbtEtwqcyFjdNyE25euSAJvJtJB5UpFPwTaD8P8e1+Dj2+2HG8lQ/Jv4X0PjKx+3QWuXpUn6PMxzIBteyaT1txhc6Qb3bfNtOA2LWmVbpqHDCCY8GrmKIkB4diapRcitL16XNltA74SlA1v0eZa1WZfJUWzZHSn2TJuGFMlktnE3MCqYv9nkgtliWKfjkg6UhbSBwap7choMgivtY5mD66/WvGo9uNJjzONxu2LwYwiG+aejhCVK0rG8xGTb8r2UK01+dBWbguqtx82Wh7ekd7vOKaEMrCWBDDZD9TA9aacMW4Dpzwi+UVIwaEk5K6JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:23 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:23 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com
Subject: [PATCH 6.12.y 1/6] cpuidle: menu: Drop a redundant local variable
Date: Fri, 20 Mar 2026 22:29:03 +0200
Message-ID: <20260320202908.24377-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320202908.24377-1-ionut.nechita@windriver.com>
References: <20260320202908.24377-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a48c018-baa9-4f79-a3c7-08de86bf5fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EsN0Qf/T9BwwTCuF7myHwqD2zAyJ2pcYRp8RL+nkuLh7eP9x/sIYUg4At8gO5OX33qnTy2wEcMhNqetSChUQlzuP7mqhr+M6xQ0LQ9r2cOkeMRDQTQpjRqxoGL5Nd6Z95CAsIOcM1LdkaWvNNLw/T8/phlZJk4D4Cc6K1d+gRvHhcx2yD+7zQsERIIdSXQY4oaiyAbapI80+uKWb1frfE5b9w6JsJS3egR3ljipDiuZ6SEMY5BBP89KcPROa1saxxg18fmzOxE5SgnixT38AXEggSa53Ou8HM/oWanLXhfGPIca4yOWantyQBcqMqZKrAN3gLHiL+lrpgDKTgQHrBuaLyICWLJ5ayCcEI4N2xPZ2dC0e1SeL6GtJ/DgOFdRxMuBUo5iwrXWoRdpN9z2GSypkekXYpMi/2S/rn7/M7S37OzrTeV7Nv19f30MzmH6kUoqMSTCEPewHf26jmT1TLzKbwDI/8Zen5gwPojqVLoHq+pr8VQ1mUsHxOk3bw7QduVngvqN/WaD5NSOB3b/Ltx0yEzPytLPsNvbini/P96AAIS5zwXUue63C+R6y8pe/itqnF7APFk7MOKCvrxjaPwAR1kfBh3t7rbPjBzEUm7Yj6y+bIVwlZ3SowlQ/PyZQzb3NvoRsw3wG+vvivrc6mbVuRMFRxRSDJT/4Ou+IpkjoZEGuR64tdhpYfN1e9haD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/cBfJuXPIjquUHKiXsFTk2uPABcoB1dDuvLazNjJ0XKWf/lJt5QpWqh7GvH?=
 =?us-ascii?Q?DURJNvX3mi7Y0Gt+VJnoESwWZYZAoF3I/pf1oA4ckpPv1L68duTlJLG3MrCm?=
 =?us-ascii?Q?CdBX0MeoYgYHy6Od00eZQLeQROzBsjEA5z3+nkPMQw95vi3TcK5+sgVJNUda?=
 =?us-ascii?Q?MbIl6cFNKPmUGlshMZijriTFIe6loIXmF3crlzP69qvKV5lkqEfQ4MS6YP1J?=
 =?us-ascii?Q?vgn37LkkbTzocGcCmuOZqWAaYLGfT5H0qtHfgccLgJQ7eoFLxJhwxCfV8l4/?=
 =?us-ascii?Q?bwYF8n0l10AyZc6//T09sDy3xvanSzYYL6ABlp5Rc+ZBjLUjvk+GAm1BG179?=
 =?us-ascii?Q?fkl3XMui0JnzlmM55Lm5dzROOtQjTeHU4epv4cF2WQwGFPq0p9mlJ51ghI4w?=
 =?us-ascii?Q?a+1jhKd3PktexGyN4/OEp81e5oIEjtquW/b+F68KabLuVeQoDUyAQy938MG1?=
 =?us-ascii?Q?wWkiWxhXN162CqqOeg7LbWXnqWb9LzUh/ZLSZH3T4uXuMEIWV6elcBfTWaDn?=
 =?us-ascii?Q?TyU9P5mky0KYRGpoaGhU/coN3v8ZNuI1AbKx45jTdMPZBEmJ7wCTCBl0kvXN?=
 =?us-ascii?Q?D57bNjKc3u7+cCDtO0GkYsqUjo0ZexvqWb9SNihm2x7CTkPSbjR8B43WWIkr?=
 =?us-ascii?Q?ytHmQmlRHQYj5rtGDqxknVlbCt8mWeEo1p8zEqSqEszJNFKFitBdkzmdwGwO?=
 =?us-ascii?Q?yWCmqEleLbEwVkTEBX78Qk5981Jw4aYpCWAMAVzDDfiBbDgmRCdNArBhuLXz?=
 =?us-ascii?Q?YFwCaLOI/raRDlpLTpExOjaLvXxuQWSf9zov9ZqjFBMJbCqF4+KPNz8Jh4V3?=
 =?us-ascii?Q?ivG6HUC3Hz4dAcrKGIdS/DtaOY2Lt0pRCVEVuMYP2dDcwaLBtBYi6k82SjeY?=
 =?us-ascii?Q?ruqK5OSfpMG5ZpBKB7/azN9jHuhDLhvVIprSoCQyBKNOBx5HPVLvtNT8dr68?=
 =?us-ascii?Q?BTb0MnM7xTcGdcl7vHCeYCRGZgftQxzAY6ytxWTh4ks98FV6EW8oOg9CQjUU?=
 =?us-ascii?Q?/La3rWmzqYvJ7WH8RyP7mKfy4RYzOqRb+jEk0pd10/mgPD9bGcgnhLlSYDdK?=
 =?us-ascii?Q?IFqovlnOE9jUyqVGf7Om6l/r/6ZkCz5VN6hNqPjrWxxI32qPdzRyhGjR/Aoc?=
 =?us-ascii?Q?y4XfaHI0RcKB+rW/ArpKrpVaIVEVLVnIqFou8trWN2Hd+5c1TZDh4wUd+ugC?=
 =?us-ascii?Q?S9bmJCTTE697+ky32fOoR9rjsMKgr9Nm/yi4274HesxU2/gTHCwCUk/5vOYY?=
 =?us-ascii?Q?U/WbO95R+Z7pwGI1JnpcQ3RrPGCwFrJTm7PNP+XnocWFv7coTDLh5UKHdLt5?=
 =?us-ascii?Q?gXxXAvQGpW7JD3qmE0B6IQOnWNLx5HQ2WwGCiVY+lSkPNvEz8TrLqv01nzbN?=
 =?us-ascii?Q?SCtYQK5PH9wPWxhZJH1LQFyMhN2SjOfqIU4yNk/uuSZbQM2cx/GSbYlLot47?=
 =?us-ascii?Q?kzECNuF4N83rlz7FHOY2UwaX/Ne26a0uT2PO0HKxzKR00oGoM7mWjG8RtDlD?=
 =?us-ascii?Q?5JrSxBtqJHk04hLCE2eQY7BlFdiMZnbE6ZwddymG6qdaJ0tz8e4Ap4wyt0Gi?=
 =?us-ascii?Q?aFVkGT5lqInuYpNFJqxLARvYVfNgmZbgJWyCawFEY+mFuDLsYdOxY4bCuFL0?=
 =?us-ascii?Q?nHJxD4HuUyjoRTBELAGsd+SL8xvmsxdBzvdlJuqYI9XJiXXiwKEyZEXptcIK?=
 =?us-ascii?Q?6CiXLoCrnTHzD+TQL9g3LhJtGdg7R+fxEbBkIK6en041EQNuS4SiLFlln/09?=
 =?us-ascii?Q?5qByktcRdmIwINJVIu19YUSOmW5yjDyoXnepZ7tj9e+3gEbwhNG0ppshP4bz?=
X-MS-Exchange-AntiSpam-MessageData-1: BOtllIh7J8szfgU3mzn7W+yo2Ofxnp9Hzgg=
X-Exchange-RoutingPolicyChecked:
	d2BLhfzHzJKibXeVUjx6i8m1AOcxzv4UptW8aleiTagTCsOnSziRYGCoNDrzxtG7k+UvtOaO/pvSt2WqraQlaeJMbM1iZKfeo7H9ZN29jamaGJSb4khxLTQh4b6AGRvGgsm3172G9ZP7gzOUm5SqysnC0DdZtcLJYczOtuyKeWChUMQ+yovhvR+UqKSFflR/woYZDsYa3cSpqj1aBi4Gq4q1LYup3JsiHsJfzkp1Ax/DQzr6axoMu6Dslw1c6C7LJWi9NlmIH+8Vo0JMQJxlSYtquvZP0oxFBhbbuMFo42ZEdIkYugxw8O8OyHs3iz/gFxrAK3ud4TfZG+WvoG7gqw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a48c018-baa9-4f79-a3c7-08de86bf5fcb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:23.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bj/N3pW3EoNfIXQETwUJ/msCc0kcHwfHtAwIUBFQitoyPIF5iq9ORnBUFXDljvVbrFN3UgdQmvNYOXkJvqj5Z6Kq9SmpM4EvhE9vJ7yHX2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bdae2a cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=JwQh9QrzZwKQFfJApo4A:9 a=FO4_E8m0qiDe52t0p3_H:22 a=XN2wCei03jY4uMu7D0Wg:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: cilSau21ep0nsNT2z80uFyXzwsTsIJtK
X-Proofpoint-GUID: cilSau21ep0nsNT2z80uFyXzwsTsIJtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfXy4TG7qHchHkA
 cz6TQNA6SPRWNi2ZSg4fPeKdkHqxHB8mDCPQcx8Ne+1hiPhxa8lEIusqhnis/d2B3eANcSgxLho
 K2zH0oNHZudQuEfazlsYm7Gj0k7J/RgVqPtQdz1x7Gw0FybgyVZ6JHFTzR06uVztLCxelihAzei
 B/E4k2KU+mRm28wWJsJZgbwlmANHZt8nL67ukddS4u+u+qwUl5iR7IdsEC0HSrX6I+soQow2Blc
 5Z1Oy17UJX+3f7qKDbOA3Vh/zKpI3OfQJrTzIBRlzW/efdo7+9RqLg8iB9k4nVy4Q0SMXwMtQH0
 NeFFMVq1Z1BSX7Pt4/aB1rAEkPHzVxQHndBMnlOMvlzOv/QkqrQUq5QSFZvc9n31Qv2fm4PIR8/
 mYXOcZTvrosn+GH+8LfBXyfAIH4pfe6zWWg37Mk9/1L7nQxLPPdIhXUd0V/aTDRl5BwGrjswDM3
 gQ2pmVENYnfIVmnz9Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-227614-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E3E052E0D61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Local variable min in get_typical_interval() is updated, but never
accessed later, so drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/13699686.uLZWGnKmhe@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 0ce7323450011..dd7e2a965878e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -125,7 +125,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
 static unsigned int get_typical_interval(struct menu_device *data)
 {
 	int i, divisor;
-	unsigned int min, max, thresh, avg;
+	unsigned int max, thresh, avg;
 	uint64_t sum, variance;
 
 	thresh = INT_MAX; /* Discard outliers above this value */
@@ -133,7 +133,6 @@ static unsigned int get_typical_interval(struct menu_device *data)
 again:
 
 	/* First calculate the average of past intervals */
-	min = UINT_MAX;
 	max = 0;
 	sum = 0;
 	divisor = 0;
@@ -144,9 +143,6 @@ static unsigned int get_typical_interval(struct menu_device *data)
 			divisor++;
 			if (value > max)
 				max = value;
-
-			if (value < min)
-				min = value;
 		}
 	}
 
-- 
2.53.0


