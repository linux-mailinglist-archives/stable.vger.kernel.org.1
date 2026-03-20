Return-Path: <stable+bounces-227611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PRgG2quvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CF2E0D77
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801AB3083026
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062AE34B1AC;
	Fri, 20 Mar 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="m3P0+Q26"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8D2C3259;
	Fri, 20 Mar 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038616; cv=fail; b=NhlUEF1aJ4I405QPkwACH7FQdJdHu43rUNtQVNfDAmvkteksqGHcZLDmV54B1ZViO2QneOyil6HXZjyXbXEBoE2x5Dl3EGz5Ug2E4RYxgyRkEZh6NvMw/HRVt/Buy8bKyO/ccsGR6oRsTn6FNeeWDv9Q9lGV4HvbnZt9i4eaYHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038616; c=relaxed/simple;
	bh=wmYF4WH7ixjvrtfuXMakh8tI/1jc4jrTf4yed7Uy5Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBZ+10yUgHOZ4AHSjCnADMdqScPj6gbLKzltXOde5OQ3dF8SpZSaFYazDIbsQkCX3NBV5eLYcNknw/KuD7OMPGlHhTuyxcdl3CiMqy/9oK/Q+/vjRJDnCVW1Zs3njtZOpfR1C3fSUkMSI7Ypy7zodq9ViGjIC6ciQRMwE1krRVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=m3P0+Q26; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KFNrUm1789288;
	Fri, 20 Mar 2026 13:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=njqy14XcOqN02+N/6emkl2FuBspuUoyqRAn/SBP7+SY=; b=
	m3P0+Q26RPuphxLdu2vWj9ORh5h39ih40qthD8oN8dRglZ6/a5f5nmKzGhCR9kGQ
	znLshZNlzzsw1QSIBHD6ToKAwD28TWU6RPxI7xSe37A8gwzQijLJuLk7vsNsDc3z
	/nSdHisqd2Rj11SLWtG55JCk6PQ6cQY6bw9YPktCsBdDKt7vxPPoXg5/EvftAXbc
	u8udqrns1PSsmimH8S2ZEif7aGQa2BKAxHwkFCxmoS6FpUaTcN8+VBmhtxVU+tAK
	4rKVzsacr32ErLP0F1dI43gU968UWS8UZXzF3fFicqFFTwYv3ST8Ojj8kM6Xfqe5
	xzNDPHtLxUrQmqsRt9qcZw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggate-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP71D9fKuFhXhvpSc5v5jaXZhvoQkYdjvRFro+5WGfq1jmNkEgMWERatsksxAnsJ3y1kX+O4CEtCGMCPMjjBI6UpDj7OXlp5ZZusmIBMWu4wAqgEbzm3gHxU0ZnjV87Jq4Rb2kd+frB+m9ix7wKZlbgz1ohlDqD/6ENYI6wvSHC3l0zIGYzzJK0QCvhcltDldU3Fhrnb+0wo4XdLCDX8B5OnwzJqgKKZ4y/by5QQDp1vpJNLJb6YJ5+IA5tvmuEdZVkg42kC6RnS32ghW0z+3ldqKE69gIMDoxkfFwzgdcBsqr51j96T7ATzf+PBOyx3XwjokF9Jf4Z8q8Xk5zN/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njqy14XcOqN02+N/6emkl2FuBspuUoyqRAn/SBP7+SY=;
 b=npInPzykY+FaHor4eLfJjQoZdrE/haMdBeOnc+Xa9GFtmrVfzI1IIwBa7fC7PI724//b4/NgKiPwT3kt20KJk9O5dnpraSnpIKe5miKpojgDfdo0x8qdqi4R/mDLlXZMO9cRYmTTXDyFkrFOJeOtBfjb6M0sVSg5KdhDjTuLInE4xztyIJoC7lFxe+ipUdNGc4OApb2xzIbJFi4v7Zj6ao0//xkGE4g12uOwyjIdUWgLWXqmUFST7RuNJTZLxDats02x3L1xRnZXETv7d8wFDpl8e+YC0RXJM3pzt/uc+BtGxNFlcMSw5k+Hz4gYfSNk3ut5vcxngRDrrnipPCErKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:30 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:30 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com
Subject: [PATCH 6.12.y 4/6] cpuidle: menu: Eliminate outliers on both ends of the sample set
Date: Fri, 20 Mar 2026 22:29:06 +0200
Message-ID: <20260320202908.24377-5-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2525425d-e5bd-4ca8-2d28-08de86bf63cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pdet0+RiYgv/uXO3KQigYtxVvBDMo8RusOxVR0gIARWJfpKHCF0lMhmyxMHZ3DgDNkGHXv4NmBFCsVvkFfUaZaVVINmy5ZkEeG73kUO0ikEFU/wD0+dNCib+zh7NssN2zjkXeQv2wAAiWXRTofBpkmlEOrWb86L5K+hFvhGKBIDcd5iwA7r8KFNBZvkzsCHYjl8OEoY/2Cvh7WPiIIm6lw9kXnjgnO72BJhxdUIRdVRp5YCndryLU/LqJSBBjv8hzSmGQt26UJDyOCqBRWp9nR2YWrG8a3Vvql/TavS9jzSfbRoJvA7CgnMLrKYNXTp+ZuXNUINjYU7/cWuI3KvXh/OaqCaI9gH3ECzHT6HBjpCGv8ZRwF8dt7oPVJ0KcDO/mJVfkFGqQ+ruvK0BOxrXJuYmnadmGzdL0umn+709rNGftaxIP/jAN/+TAu8vmNDDxVghbH7WxM25fmE6Qa8qtmn/eTGCb3tcTvqqxeijcZbE9F92JbRI0NY9jsqymVYBXjOxKd3/mkIMYJnOsmpjziZZ8CSWqX+vYO12uShIqv6Gehk8B5X+uKWLZa4no9OW/lhrMebg0nKb2FfdKnoYq0M5BGDraR/pyZOBR2FxPQQTAI4lOoXKAFVw6zrNz+/R8L4Vu3xc5nLXvAsmqLTKQ1fc2OBp2EJUi80dS0MHr9ccIQqKxoKnn6XPltlg5+Kh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7lHarlY/g8ZRssJnQxxFJOi8QP3lhS+8PvWREm1xDH0+P45h9WDUuKreUVR?=
 =?us-ascii?Q?dSDaHOVun/7+j0aSXUoYnENxdsYMYinrC+Aa2WKoe73KkDL79XoCFYDeKzFP?=
 =?us-ascii?Q?iovQRSgh+qfT4ussSgExGp5VjrPl9Wx/+sxRN2qFGt95ACYCquvnH5uPu5s/?=
 =?us-ascii?Q?APi0PMT9u23gMuRgzKbHefbsByprvtaabhEVOKck1kDZFkvyQfAJNWK9rm49?=
 =?us-ascii?Q?VbnBsVWy5zrmGuqtD6D7mvIoO+KvDPNIweINtmgSbME41c9LQF2Xdrsb4Yoz?=
 =?us-ascii?Q?2J6gy3v8AAqHrvrdpZX0D1kVccJZHPsoM7xxpgJZkW3f661fY4lduVawD5wv?=
 =?us-ascii?Q?OE0TaK9+icw6rB073UZmXP/ERaruuAUv0jyrjrsEkohhERTnx1TD/B1cxJWZ?=
 =?us-ascii?Q?V0/szNJ9jHCD9gVz1fAfadsBjsvETzXhthuAWWO+SDSFQbViB/zXPcwOgmEI?=
 =?us-ascii?Q?HWd/zRyrcbakTejZ10xhvaT8BxjLyM8kiK3RsxP+Rm9i12Qz1EpgPn6bdXTz?=
 =?us-ascii?Q?KcKTI/5LZxfXnaP9o2fhf2AZlRVurzGXGHogXjjRbMSA6fYiVMPCRejoORJc?=
 =?us-ascii?Q?9y56/Z6Jgj/YrgMS9d/hYUnrLORo9oa/DWruGu+J4Isn9q/1ZTuWro6zVnRL?=
 =?us-ascii?Q?Gq72Zo+AgvE68cuh08ljRLTjLWkJRo+UgaSbhFwgDVYpmWoMAubWnmcoxkFh?=
 =?us-ascii?Q?w/rJQMW4spxwFAi7BUUdPzTdV/mFQtTyY1Jhs6u15IyEYOc77pmY6ILSY+AO?=
 =?us-ascii?Q?ku53O5vWSWuO1dEbW/2rvJx21KpCY7zIGmkFoYbvLCNpOrxK70e2YRI62Njj?=
 =?us-ascii?Q?zBm5Rc6IfJxf3mRB1DwvvZ815JBp+WHxZCQTUcvPat4G1/rTiJ/gCvci2GBA?=
 =?us-ascii?Q?FL9kT5buim8asoEtKdqeVCYwHmX0/bF7p26D7cPoMLYgl03d0F1DD2kTXYbs?=
 =?us-ascii?Q?ugztWfztlkH8r++UumWcgluglkoJpPjyrEBrnCoTnVMWb98alr1tcgtInUcz?=
 =?us-ascii?Q?8puw7RGqWxBPN12YpK4nKFWIx9i2rVUIfNlUuhjJ0IfB8CTh20YAWBpHAHo6?=
 =?us-ascii?Q?m5gDDYQykKIjvgdRiYHQwGVZl0syiIVHt9lvyFXKCahtcYVzE3YyAr+jrvFx?=
 =?us-ascii?Q?U4fHZj1Qs+OXduwmifPXvcbB7AvNS0689CutdEocLmIqnimpDX+VKmyt0scW?=
 =?us-ascii?Q?/rnIYGJI00TjGXM4+6vsDDBCqmFFvuKABuQOJ8pa0k1PMolWy6IZxch9ytN7?=
 =?us-ascii?Q?SYvHJnLb+oecTedctKWf3H93kQPUOR0TJ5F5UW/Waw9K6bJN0TH0OuUjehd8?=
 =?us-ascii?Q?lrG5GdYXzvdCmFOlm4NqguPLoIDufcx3dp3RK5e4vTnvGpYiaU7l414S2J8i?=
 =?us-ascii?Q?hz5aogSWrL2UHZTL9bIkd8C3rerlfwCCa7APvLV5ERJKylRQzya72iM+86Cs?=
 =?us-ascii?Q?Chd4+u6ZVCB+v25FbM8wL3FFJaUYQHU+LuY+XIRBjn84ewZQTceWwQearUXe?=
 =?us-ascii?Q?DbX5yvbGXXVhA2CYgwD30Q1b0HHrTNlsMmMTtSYpOdg8FKd1JiVfBU2x9IK5?=
 =?us-ascii?Q?h2x79bzyq1FVovGuyNY02671gGCdc3evAk4PISE33LIK37NVd/tEXjBeJ3oa?=
 =?us-ascii?Q?kyn/FS2G07LoQGExJ4T+n8wQDVptxoSbH6dLowHBxSjVBtG6ZMJtO0Gtldu/?=
 =?us-ascii?Q?2ex1ZIc1iRfsSpJPJBleNPN1V+wTXOCLXX/kOjhZBLSJRIjC8HO1AEcb7eJL?=
 =?us-ascii?Q?+fu6n/kDrb50S7wiDSOBfwfG9Fe9AFFlsykoz3Ypl1lC+qR11ym5MMeufDFb?=
X-MS-Exchange-AntiSpam-MessageData-1: c191WFFo2qcFUGT58AhNqdm/1GWp4DJ91cw=
X-Exchange-RoutingPolicyChecked:
	VfLh2C4sLKr63uoNCk0nQl9Hb+zHg0yeJQiWbzJvHnDBRJmopZbxZQy3CICNzsQ2aLFRP9E5U+zwwWwggnc+WHV3rMiBEHJ/0AUTXwplX4I+zu4P4fuhwzTZIQt1ota98VXtdasV6cPXNrmJTHv2Z1FjixzykdauiiDtSgRi4fVzG1YO6bCzcsqQZy/FXr4h5iMuGyYJXAHgHKt+UJSNp6XnbW0UuG4+PwJjyKd8ntAzs4CKAmOtkLag6SIV6zqIS7WuN1xNbNqpzaKAUQXJgKHvPhgoBToGfRVFaMnWBYcnHxFskGAECBGUkoSEta6mElkkjVOOM84YnDbyRPbt1A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2525425d-e5bd-4ca8-2d28-08de86bf63cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:30.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkxLS/JYpVdw63h48QhTUIRh29xTV1IEVlfFrXeSx8OwbMrDIf4YMmxiKxTIOT8fR7WaqYWi77hkaeKKs1cd7eNS3NqKp5CKm043V4MCmkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Proofpoint-ORIG-GUID: d6xUgosyy70gVdfNYZwvSczPoh4r68M1
X-Proofpoint-GUID: d6xUgosyy70gVdfNYZwvSczPoh4r68M1
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69bdae2d cx=c_pps
 a=V6MklVWPegrOQeIbI7BYwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=KZQpO8rcAYRa_uORS6wA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=XN2wCei03jY4uMu7D0Wg:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfX/t58Q5owKhQp
 pjE05hhb290Rz1nzULAxeOruULi+FT2vTs5MWFqTAIxR8KSI6FB+WF7r28RARMCdmEpPTTCOJIp
 XkSEQDF3AL3x761Bt5O52Pl54AgdXApZO6la8+GN75MSO2yZnYnkCGrzJaeU2pYjfscQCCnUjXO
 I9ClAps7NmMIaiOOq6nuCcS2x8JgeeNCZVkeWMjQLVJm94V39y4TQu2360Ej8K5xy2HmmRNBcAX
 EmDQ1TcJip+Mdei65Soh+jw9ufDXHbX8+n+TE+lGrD3Wi8FK6ip6NxHaffKO+j+15kJ7kzhga2S
 Mx+yVgOJb9I8V9RSG74eGDHiOk3zD3lu3DxoQms5k5Bp15r9cefxFtUzPKbsaUcJMzAfBbbdWud
 LYYBUB6WSBbLo2Inxht11ys7Qzfw0qosZYCiO1EKZB8r5gtcrP8pyhTsjxntSReNrXKwHWoJDkE
 Rsr/eA0bO6U2oXxqcQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-227611-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:mid,arm.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D69CF2E0D77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Currently, get_typical_interval() attempts to eliminate outliers at the
high end of the sample set only (probably in order to bias the prediction
toward lower values), but this it problematic because if the outliers are
present at the low end of the sample set, discarding the highest values
will not help to reduce the variance.

Since the presence of outliers at the low end of the sample set is
generally as likely as their presence at the high end of the sample
set, modify get_typical_interval() to treat samples at the largest
distances from the average (on both ends of the sample set) as outliers.

This should increase the likelihood of making a meaningful prediction
in some cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/2301940.iZASKD2KPV@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 96bee77b8354f..8ab5123c81040 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,30 +124,37 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	unsigned int max, divisor, thresh = UINT_MAX;
+	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
+	unsigned int max, min, divisor;
 	u64 avg, variance, avg_sq;
 	int i;
 
 again:
 	/* Compute the average and variance of past intervals. */
 	max = 0;
+	min = UINT_MAX;
 	avg = 0;
 	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
-		unsigned int value = data->intervals[i];
-
-		/* Discard data points above or at the threshold. */
-		if (value >= thresh)
+		value = data->intervals[i];
+		/*
+		 * Discard the samples outside the interval between the min and
+		 * max thresholds.
+		 */
+		if (value <= min_thresh || value >= max_thresh)
 			continue;
 
 		divisor++;
 
 		avg += value;
-		variance += (u64)value * value;
+		variance += value * value;
 
 		if (value > max)
 			max = value;
+
+		if (value < min)
+			min = value;
 	}
 
 	if (!max)
@@ -183,10 +190,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	}
 
 	/*
-	 * If we have outliers to the upside in our distribution, discard
-	 * those by setting the threshold to exclude these outliers, then
+	 * If there are outliers, discard them by setting thresholds to exclude
+	 * data points at a large enough distance from the average, then
 	 * calculate the average and standard deviation again. Once we get
-	 * down to the bottom 3/4 of our samples, stop excluding samples.
+	 * down to the last 3/4 of our samples, stop excluding samples.
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
@@ -202,7 +209,12 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
 
-	thresh = max;
+	/* Update the thresholds for the next round. */
+	if (avg - min > max - avg)
+		min_thresh = min;
+	else
+		max_thresh = max;
+
 	goto again;
 }
 
-- 
2.53.0


