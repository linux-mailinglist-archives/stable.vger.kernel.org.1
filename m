Return-Path: <stable+bounces-227752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNwaDFNyvmmYPwMAu9opvQ
	(envelope-from <stable+bounces-227752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:26:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B32E4BAB
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87003301C5AB
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD5330666;
	Sat, 21 Mar 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="g0EYofs8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BD314D0D;
	Sat, 21 Mar 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088735; cv=fail; b=PY15uzWPPVS7Lp9YPl23voacSEyWj7uYXId6SY9ewXP3JliVAkkhtWyDR4SpvmC13NpPALDaEvAQslPW8STG+NWkT8x0EOjbsSbGpL4NNw17p6HvqKT33E4E+jBIapXc0zQlP7sOfyXbt+3ZhFnggzmp46TmeEOcayC6NLRvy3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088735; c=relaxed/simple;
	bh=IkjSWUFaY7ae6cy5AGfj3DpyOfYJsKOQW6xbb6/ODrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aaPO/9YWMBcMzx2YVPkYshY2KX6hcR1baoeT0bLKy91OkC6s6q98pvHDLjZx53NWb4Q/BcIv4cy8AfJBx5p1iKB/n+uzRmbfNJHqBLjiz7UzeKcIe2qNqBN8ZVm/DitBqDuysv2idZm9C66AKi5AEsAnSti/vQSa3uj/A2thK1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=g0EYofs8; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9tv9r3678047;
	Sat, 21 Mar 2026 03:25:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=dEbIYcrLgGHyzvkwKVA54JAge6PqkrZ6jGU3uvx4t+4=; b=
	g0EYofs80Mu2yXMDv0jAKYHn0hAPZr4vOF9M6FhraDqvV8z+P2lv91HNLfIS35qP
	P5MXyVs5JNhINt7hFiP5r/4QPGa/XzhMAtmNCRNEv/lWuwVyLlpBsMoWSI30X6tB
	Fh4sHPW6ogdpdBRTYFis0cQ7iBkytvBga5UGQwrF9syQ8WlBjqP+Zbm/kPFSOKCM
	/oK7Vqo90gxZh11DVRUTVxPUUOisJMGaHQhPhRU3Cvno8jBwrZ6Q6VuDU0IpqeVO
	U/MxjvfOFr1HhqpUpjF7uVGDvoVD+Ku25IwACg0Pk2JOdFdxoJ/447YzOJe/Ej+q
	y0yLpGr4kf6kaMPiebHXIQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggv81-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFEipTNm6o6jHIOJ/vwg6Sq9lc2lNwz99hrTR3sm9sgOe3Uxgl0KA06aeaHe4ql9IZ2Z3xdKiom6h1MMXxDUuPu1tO5zX+eqL9/qtumN5XiwpwGmAn3zFM6AEb1nTs/HdHeV2dtsOdeiztoEF80aOhkOT/j5prLvHK4f9P+eMNRfDjR2mJ+zyOb9Fbg1YuyZQ8+bRXo8UAh7eSw49IL3nlcLb1sNuz3EAtrXnVzvAfBv/KLZMZGXFlWydYTnO28axBgIDJYB6Nzoe/Wdh7k81L0EzBreZs/P1coVnlbxV9PF8KEMJds/oyteh+2MHUopvC4T3J9LhN5YVbZBjz734Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEbIYcrLgGHyzvkwKVA54JAge6PqkrZ6jGU3uvx4t+4=;
 b=oFvZwdeDYjsg9osGmeoPf/bDvJMUbCQeQTM/QJnMhhsMR8ppOTTiKHtJKed8woPKU83I10XDiTrTiQvRRFzohwTSywKphKJPMdC4rK8DFo8hC7ZTKob7xxpRzUvsqjLtYOS4Jwcs7GrhqooFcKigmxh6nQ6/WfpNed46D6TiJuPTYxwWVmwWucQv2p8+orb8WIIlRrUpfEpgcorxkhbaquhVovb0zQxltYO0yJKNRkPptzfFZ4rghFMvuQP8LkNW2G1BIhuJej+C3p+S+zxle4CBBSAiQ9BcGMCApgUUi07MBwIOuaf0ISdH0loA0MDXOOvqyN4JhQ5h2QAWQ3JM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:25:18 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:25:18 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 7/7] timers/migration: Fix imbalanced NUMA trees
Date: Sat, 21 Mar 2026 12:24:40 +0200
Message-ID: <20260321102440.27782-8-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321102440.27782-1-ionut.nechita@windriver.com>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: b142e05f-d60f-4364-fcf6-08de8734260c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Dw/1AuQXH39eCqV3WzMpqAnwtPk9eGM7NHD31+M0F2uJD95kcK8CkOIK9kqcuXmz7OnthDZb+o3MXYeSKthAibrHMmUntWW80GzAWgTWamcI3Pd559aEr2cd1OFin6wUG3Cy4OYo9dAaRgrCVD7lTHI0C+gsfDJrCyirLVRKIflnbn1aAiJg/l2phb02qyorgy50D9BThL2xgl9ejKuL9GBNe2YkXC/MEcbe7pr/37VSuYZv2XkXXWINV4TeuBfwxUnAE94Xo/Ed8g1N3+T66aoVUyEDTlIcQiVQs7dXdJEuI+O4l7yG9WgVkbJ/zZ/ww/Iug1eDyYbFbMEmgN2qFZH3DUcipfGsiRa0si0/1pQJmq51DfU056AiQcYt+k1+bPC2QpiPePDKtiED027XRRxcxrPH7bWQyJ8r7rul6Oa3lUmhicbcl9pdWKMmI6FsdZqtDj1C36aCgN/NPB64d9XJT2neweBYtbPYdYgpCDuwdYP6Od97F2KyXG2Koct/PckFyRBwaVXTZ8E+fhor9aG/sevXQyL6WeXq7vgF2QIpN3UPlOaVr/165x0sxL4ClxYw4iS7T5yFJXdp+MQnWYSXMx54m0HBO06VrdUMfnlfBOWsuMuVZcQIvzaVy1UXKvSC6lAVNYNrBnz8zhCSsC36niLCZemrVhilYAfU5gbfYIALTnM+LYKThKe+4kzM37CEn1mT9q/KO7N9A+m4PbQVSzziepsJMhkvLYjalNnmZInP7ZENV4YCJUyJjLwm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqLp0kPd59vkfyTQuYSTwk+FnKSOOR9H4+mPKJjic8nSDmaO5NWoVfJtq/Lu?=
 =?us-ascii?Q?1eGsueEqf6e4Ga8CddWXlaj9bKgbhhbFuaYCjO/HMvAAIosPs8n0gjGv1pd5?=
 =?us-ascii?Q?B70bUVWvtaIeIW8NpvzNH/BGzCNpFyoRp6DXylWlPQ+RnQKekuZxkUcPSfG3?=
 =?us-ascii?Q?QqrmLAsbuioyCLu9CFi1JEZkOR1i/jp4SKlWIB+f+mJ8ug6mn58nYVbFOtxs?=
 =?us-ascii?Q?JI5kchAADSlwGgJUm1v6Y1IZE5JZXnCG/EhzHD3243DoQY1iOUV41leVm17b?=
 =?us-ascii?Q?fD+1D4HsaQt8lJYtCXD0nt4I4fkvdHVxqIcxStX9S5IT66uhOA6CEsZHsK4P?=
 =?us-ascii?Q?Y19cM5f53aDX5J9RzAXHiwtIFvFHspOBF4TIMhuotL2pQzu81gd0NUSkXCTh?=
 =?us-ascii?Q?ZlPKowU13IOr4BsVd2Hn57BW4GBu2FZagv6G4QUYcJFV/+VQgdN6r8Zzv6iM?=
 =?us-ascii?Q?9jRPp3CvjwJhtYorUUeLqTcyTPMJoya/VbqB20ig0V5ngE3fzX6V2eth1mD+?=
 =?us-ascii?Q?eTtW1T4MHFIIffs7uWdorPRD1uhRalXD50n0HqLoJ9KuCSKR18KGngFJw1nh?=
 =?us-ascii?Q?eBVYBiAdu7h3Gr7x4+StywwEFBymxXrQGsEkaqAkwF5Bqai9iRpLESM7/zEd?=
 =?us-ascii?Q?8jn7NUTMVoNPsbS4Ci8c9hOJE7I+SVr8PIg8WsRnjR1L6uGd/nJzIrNPiAzH?=
 =?us-ascii?Q?pWkPfANFQorLw9q4xUofBZYJSer1Jnza3QiybDhXY5R1G7wnPGy8CDNMAPkn?=
 =?us-ascii?Q?ddrpi6o+3PFNzGiA7vOhghQdAyzej07jLm7BTazLE4PyZ7msc9rA/7y2qjp4?=
 =?us-ascii?Q?kukPFbu1CShsf1XkBnmf5lBwPbVuGueggPTgVZzo9B2e8sV0+xVrzelvQpss?=
 =?us-ascii?Q?JTO3NZBJW6uN/mJyeAepjBy8Fj8CA9v8Z/1za5YoPvOXYGne/ofOg0hLkd3V?=
 =?us-ascii?Q?qAZqxzdiqipK72AAFdhIBqzrDsZcNUCpwYhTy0GsFtZ39dNzl6PrtZRVyIht?=
 =?us-ascii?Q?wINyDZM29J/u8bl7EV214uBU+2yJfm5MdJrISkLdEL24MNOOzDzR/Xx+uj9V?=
 =?us-ascii?Q?7M4n6nspZ6gatrnGn/fdajhVFhyoNOaTpdzzGHu+XsUykAn5SYjvGIuT4cXa?=
 =?us-ascii?Q?CH4q1lEPVEUQ1buXRaIo+euMxdfZJcb6fjDKvVOfO3ZQi6tg2wA0l0cNpBdx?=
 =?us-ascii?Q?fYseaEC1IKRKNzM4lfyZ0lz9+BOXafI2a3tqnyye0frfEp78DHIJ/b+jiks7?=
 =?us-ascii?Q?iizM7tfLH+uhHiunZrIAdvkifD+MnPaUPJtiXaSGWdb08gUpa0DUQPJ415+d?=
 =?us-ascii?Q?Jh8/Gi1IWUuE1fu5axUTxzn0TQZIc+6GrGg2rGra/x7n/pDmiISXMs4c3nd6?=
 =?us-ascii?Q?Fv7gBBwpK8hzU5HTfAQuSrGpqo82LaqoLW0RAOhWpGRqP4uHq+pO3/NXlKmr?=
 =?us-ascii?Q?RgfNRjHh9tByPmBGUrNqZdakB2LSu9bzlBLcYgEbcFRKVvDF75ze1m85QTG+?=
 =?us-ascii?Q?/zG5oClLHmVXOa1rtG7PFPB51tQeCaib93wV8Ch41R2jjtKl9mdwtS0YWTKm?=
 =?us-ascii?Q?INECXs6ww1c9H3kjgUZGhw1ozW017wGgAxy7icgTPRyEDfyh7xwCSq14tSlg?=
 =?us-ascii?Q?nashDFX3VHjetGQkzYBLNB4DJuTSQdQSBTWHeVLNiQwXXn+aiYNRNZ2TNr6G?=
 =?us-ascii?Q?golb1T3AdzvAUZmhnqzlHgoui4QpIoce1JnBteOOQmw9jrYWGwetYDw2dc4e?=
 =?us-ascii?Q?f/eI7iPNyfnZtrFitcktSmMVYejesUc=3D?=
X-Exchange-RoutingPolicyChecked:
	F3dnNqHM/DwuvtzFa6ep7pwLGKLTTCjHeU66ZpvmKzmVP92KXTw790Kv0QF54P+mUI2tGKV39T33P+m/oA2fRkFBoYVYAYutm7N+BdEbTu0CJQEpS1zvPVivkyhwGjSR0Gp709rLYfpM3lCy5Vafofq6EDRiZqoKxr2ouHhB5PrdRTE1gxAPx+4RjAnUDGyPvqudvaDM4XwQW3dMmh4nK0Lq5jpUzH7ayaR2B/t7fLcfeizTpmKafFl7kogTS9z/+5VAKaS6Z38m1pZx7FATDHRWLhHAmO62ugfNyuKCncxCsG19a3uf4UtfCU5oVNcOSKbMR+a756yLJmxKNqgSjg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b142e05f-d60f-4364-fcf6-08de8734260c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:25:18.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KAfMxF9hkC/re5yC/+vhPZkvb/QJXUUdSxJAiajNj+ksP8gCcPqd0pABS8lEgYxeI0L31B6ugQnnFZjS8F4P7oZ+7/zAisLPAdodTObCBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-ORIG-GUID: Wv5xsf2aHhUvrR-fr2T3fVROWea-0AYj
X-Proofpoint-GUID: Wv5xsf2aHhUvrR-fr2T3fVROWea-0AYj
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be7210 cx=c_pps
 a=espmfoAAVKQgPoIy+vmhGg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=rPOk8Gav1BpNgUgkAfMA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX7AMDQnXooirp
 0iul12hd2REvIz+IGDHNugz5IbQiqhq48TQ01LibxXJUPNx3BOZRv7TErxvsz3H+fzzsCO9javO
 nzP9cRO9VcFrQ4QA+/STTgC+drELF9XRaNmfjXx+Bns1/NsRmYyjGggq/ytdooe/cm+jTJ5nofy
 tcw6x9mrPG75z0lhz78Ol0Pyn8C6qPyOCe9Sb3CPAbv96odTu6pZ57xUuQWTBOQXuwbqjFIOIfn
 PO8mQvdioQxituqmusYffEWfyOfTqNxbBXGgZKJZ1EJa20fHTrmV7GjvW3lRG2xW+ljxL81NcLV
 L9mFPeziSVfm6cTHyMmEooc53ylmHi5pmWB5ni6DyYSTcD0A5FyrZ7cfxE5rRqx9i9LxoYVsI6a
 VJpUmn/O6c5yhZs1pxu3TXRZABzHBwQwLjEc4uR4sZLZDak2irYNkjALdMvYJ3nsKfagvmBrKUi
 4h4cW9kCVtNModynq/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210084
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227752-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 254B32E4BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Frederic Weisbecker <frederic@kernel.org>

commit 5eb579dfd46b4949117ecb0f1ba2f12d3dc9a6f2 upstream.

When a CPU from a new node boots, the old root may happen to be
connected to the new root even if their node mismatch, as depicted in
the following scenario:

1) CPU 0 boots and creates the first group for node 0.

   [GRP0:0]
    node 0
      |
    CPU 0

2) CPU 1 from node 1 boots and creates a new top that corresponds to
   node 1, but it also connects the old root from node 0 to the new root
   from node 1 by mistake.

             [GRP1:0]
              node 1
            /        \
           /          \
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0                CPU 1

3) This eventually leads to an imbalanced tree where some node 0 CPUs
   migrate node 1 timers (and vice versa) way before reaching the
   crossnode groups, resulting in more frequent remote memory accesses
   than expected.

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 1               node 0
            /        \                |
           /          \             [...]
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0...              CPU 1...

A balanced tree should only contain groups having children that belong
to the same node:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:0]
              node 0               node 1
            /        \             /      \
           /          \           /        \
   [GRP0:0]          [...]      [...]    [GRP0:1]
    node 0                                node 1
      |                                     |
    CPU 0...                              CPU 1...

In order to fix this, the hierarchy must be unfolded up to the crossnode
level as soon as a node mismatch is detected. For example the stage 2
above should lead to this layout:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 0               node 1
              /                         \
             /                           \
        [GRP0:0]                        [GRP0:1]
        node 0                           node 1
          |                                |
       CPU 0                             CPU 1

This means that not only GRP1:0 must be created but also GRP1:1 and
GRP2:0 in order to prepare a balanced tree for next CPUs to boot.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-4-frederic@kernel.org
---
 kernel/time/timer_migration.c | 231 +++++++++++++++++++---------------
 1 file changed, 127 insertions(+), 104 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 5f8aef94ca0f7..49635a2b7ee28 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -420,6 +420,8 @@ static struct list_head *tmigr_level_list __read_mostly;
 static unsigned int tmigr_hierarchy_levels __read_mostly;
 static unsigned int tmigr_crossnode_level __read_mostly;
 
+static struct tmigr_group *tmigr_root;
+
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
 #define TMIGR_NONE	0xFF
@@ -522,11 +524,9 @@ struct tmigr_walk {
 
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
 
-static void __walk_groups(up_f up, struct tmigr_walk *data,
-			  struct tmigr_cpu *tmc)
+static void __walk_groups_from(up_f up, struct tmigr_walk *data,
+			       struct tmigr_group *child, struct tmigr_group *group)
 {
-	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
-
 	do {
 		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
 
@@ -544,6 +544,12 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 	} while (group);
 }
 
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	__walk_groups_from(up, data, NULL, tmc->tmgroup);
+}
+
 static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *tmc)
 {
 	lockdep_assert_held(&tmc->lock);
@@ -1498,21 +1504,6 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	s.seq = 0;
 	atomic_set(&group->migr_state, s.state);
 
-	/*
-	 * If this is a new top-level, prepare its groupmask in advance.
-	 * This avoids accidents where yet another new top-level is
-	 * created in the future and made visible before the current groupmask.
-	 */
-	if (list_empty(&tmigr_level_list[lvl])) {
-		group->groupmask = BIT(0);
-		/*
-		 * The previous top level has prepared its groupmask already,
-		 * simply account it as the first child.
-		 */
-		if (lvl > 0)
-			group->num_children = 1;
-	}
-
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires = KTIME_MAX;
@@ -1567,22 +1558,51 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 	return group;
 }
 
+static bool tmigr_init_root(struct tmigr_group *group, bool activate)
+{
+	if (!group->parent && group != tmigr_root) {
+		/*
+		 * This is the new top-level, prepare its groupmask in advance
+		 * to avoid accidents where yet another new top-level is
+		 * created in the future and made visible before this groupmask.
+		 */
+		group->groupmask = BIT(0);
+		WARN_ON_ONCE(activate);
+
+		return true;
+	}
+
+	return false;
+
+}
+
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent,
 				       bool activate)
 {
-	struct tmigr_walk data;
+	if (tmigr_init_root(parent, activate)) {
+		/*
+		 * The previous top level had prepared its groupmask already,
+		 * simply account it in advance as the first child. If some groups
+		 * have been created between the old and new root due to node
+		 * mismatch, the new root's child will be intialized accordingly.
+		 */
+		parent->num_children = 1;
+	}
 
-	if (activate) {
+	/* Connecting old root to new root ? */
+	if (!parent->parent && activate) {
 		/*
-		 * @child is the old top and @parent the new one. In this
-		 * case groupmask is pre-initialized and @child already
-		 * accounted, along with its new sibling corresponding to the
-		 * CPU going up.
+		 * @child is the old top, or in case of node mismatch, some
+		 * intermediate group between the old top and the new one in
+		 * @parent. In this case the @child must be pre-accounted above
+		 * as the first child. Its new inactive sibling corresponding
+		 * to the CPU going up has been accounted as the second child.
 		 */
-		WARN_ON_ONCE(child->groupmask != BIT(0) || parent->num_children != 2);
+		WARN_ON_ONCE(parent->num_children != 2);
+		child->groupmask = BIT(0);
 	} else {
-		/* Adding @child for the CPU going up to @parent. */
+		/* Common case adding @child for the CPU going up to @parent. */
 		child->groupmask = BIT(parent->num_children++);
 	}
 
@@ -1594,56 +1614,28 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	smp_store_release(&child->parent, parent);
 
 	trace_tmigr_connect_child_parent(child);
-
-	if (!activate)
-		return;
-
-	/*
-	 * To prevent inconsistent states, active children need to be active in
-	 * the new parent as well. Inactive children are already marked inactive
-	 * in the parent group:
-	 *
-	 * * When new groups were created by tmigr_setup_groups() starting from
-	 *   the lowest level (and not higher then one level below the current
-	 *   top level), then they are not active. They will be set active when
-	 *   the new online CPU comes active.
-	 *
-	 * * But if a new group above the current top level is required, it is
-	 *   mandatory to propagate the active state of the already existing
-	 *   child to the new parent. So tmigr_connect_child_parent() is
-	 *   executed with the formerly top level group (child) and the newly
-	 *   created group (parent).
-	 *
-	 * * It is ensured that the child is active, as this setup path is
-	 *   executed in hotplug prepare callback. This is exectued by an
-	 *   already connected and !idle CPU. Even if all other CPUs go idle,
-	 *   the CPU executing the setup will be responsible up to current top
-	 *   level group. And the next time it goes inactive, it will release
-	 *   the new childmask and parent to subsequent walkers through this
-	 *   @child. Therefore propagate active state unconditionally.
-	 */
-	data.childmask = child->groupmask;
-
-	/*
-	 * There is only one new level per time (which is protected by
-	 * tmigr_mutex). When connecting the child and the parent and set the
-	 * child active when the parent is inactive, the parent needs to be the
-	 * uppermost level. Otherwise there went something wrong!
-	 */
-	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
 
-static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
+			      struct tmigr_group *start, bool activate)
 {
 	struct tmigr_group *group, *child, **stack;
-	int i, top = 0, err = 0;
-	struct list_head *lvllist;
+	int i, top = 0, err = 0, start_lvl = 0;
+	bool root_mismatch = false;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	for (i = 0; i < tmigr_hierarchy_levels; i++) {
+	if (start) {
+		stack[start->level] = start;
+		start_lvl = start->level + 1;
+	}
+
+	if (tmigr_root)
+		root_mismatch = tmigr_root->numa_node != node;
+
+	for (i = start_lvl; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
@@ -1656,23 +1648,25 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
-		 * available, not all calculated hierarchy levels are required.
+		 * available, not all calculated hierarchy levels are required,
+		 * unless a node mismatch is detected.
 		 *
 		 * The loop is aborted as soon as the highest level, which might
 		 * be different from tmigr_hierarchy_levels, contains only a
-		 * single group.
+		 * single group, unless the nodes mismatch below tmigr_crossnode_level
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i]))
+		if (group->parent)
+			break;
+		if ((!root_mismatch || i >= tmigr_crossnode_level) &&
+		    list_is_singular(&tmigr_level_list[i]))
 			break;
 	}
 
 	/* Assert single root without parent */
 	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
 		return -EINVAL;
-	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top])))
-		return -EINVAL;
 
-	for (; i >= 0; i--) {
+	for (; i >= start_lvl; i--) {
 		group = stack[i];
 
 		if (err < 0) {
@@ -1692,48 +1686,63 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
+			tmigr_init_root(group, activate);
+
 			trace_tmigr_connect_cpu_parent(tmc);
 
 			/* There are no children that need to be connected */
 			continue;
 		} else {
 			child = stack[i - 1];
-			/* Will be activated at online time */
-			tmigr_connect_child_parent(child, group, false);
+			tmigr_connect_child_parent(child, group, activate);
 		}
+	}
 
-		/* check if uppermost level was newly created */
-		if (top != i)
-			continue;
-
-		WARN_ON_ONCE(top == 0);
+	if (err < 0)
+		goto out;
 
-		lvllist = &tmigr_level_list[top];
+	if (activate) {
+		struct tmigr_walk data;
 
 		/*
-		 * Newly created root level should have accounted the upcoming
-		 * CPU's child group and pre-accounted the old root.
+		 * To prevent inconsistent states, active children need to be active in
+		 * the new parent as well. Inactive children are already marked inactive
+		 * in the parent group:
+		 *
+		 * * When new groups were created by tmigr_setup_groups() starting from
+		 *   the lowest level, then they are not active. They will be set active
+		 *   when the new online CPU comes active.
+		 *
+		 * * But if new groups above the current top level are required, it is
+		 *   mandatory to propagate the active state of the already existing
+		 *   child to the new parents. So tmigr_active_up() activates the
+		 *   new parents while walking up from the old root to the new.
+		 *
+		 * * It is ensured that @start is active, as this setup path is
+		 *   executed in hotplug prepare callback. This is executed by an
+		 *   already connected and !idle CPU. Even if all other CPUs go idle,
+		 *   the CPU executing the setup will be responsible up to current top
+		 *   level group. And the next time it goes inactive, it will release
+		 *   the new childmask and parent to subsequent walkers through this
+		 *   @child. Therefore propagate active state unconditionally.
 		 */
-		if (group->num_children == 2 && list_is_singular(lvllist)) {
-			/*
-			 * The target CPU must never do the prepare work, except
-			 * on early boot when the boot CPU is the target. Otherwise
-			 * it may spuriously activate the old top level group inside
-			 * the new one (nevertheless whether old top level group is
-			 * active or not) and/or release an uninitialized childmask.
-			 */
-			WARN_ON_ONCE(cpu == raw_smp_processor_id());
-
-			lvllist = &tmigr_level_list[top - 1];
-			list_for_each_entry(child, lvllist, list) {
-				if (child->parent)
-					continue;
+		WARN_ON_ONCE(!start->parent);
+		data.childmask = start->groupmask;
+		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
+	}
 
-				tmigr_connect_child_parent(child, group, true);
-			}
+	/* Root update */
+	if (list_is_singular(&tmigr_level_list[top])) {
+		group = list_first_entry(&tmigr_level_list[top],
+					 typeof(*group), list);
+		WARN_ON_ONCE(group->parent);
+		if (tmigr_root) {
+			/* Old root should be the same or below */
+			WARN_ON_ONCE(tmigr_root->level > top);
 		}
+		tmigr_root = group;
 	}
-
+out:
 	kfree(stack);
 
 	return err;
@@ -1741,12 +1750,26 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 static int tmigr_add_cpu(unsigned int cpu)
 {
+	struct tmigr_group *old_root = tmigr_root;
 	int node = cpu_to_node(cpu);
 	int ret;
 
-	mutex_lock(&tmigr_mutex);
-	ret = tmigr_setup_groups(cpu, node);
-	mutex_unlock(&tmigr_mutex);
+	guard(mutex)(&tmigr_mutex);
+
+	ret = tmigr_setup_groups(cpu, node, NULL, false);
+
+	/* Root has changed? Connect the old one to the new */
+	if (ret >= 0 && old_root && old_root != tmigr_root) {
+		/*
+		 * The target CPU must never do the prepare work, except
+		 * on early boot when the boot CPU is the target. Otherwise
+		 * it may spuriously activate the old top level group inside
+		 * the new one (nevertheless whether old top level group is
+		 * active or not) and/or release an uninitialized childmask.
+		 */
+		WARN_ON_ONCE(cpu == raw_smp_processor_id());
+		ret = tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
+	}
 
 	return ret;
 }
-- 
2.53.0


