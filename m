Return-Path: <stable+bounces-148154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EB6AC8C07
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386ECA2081A
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA7221262;
	Fri, 30 May 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUmhD/bW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gF1A2Ba4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A961E1DE3;
	Fri, 30 May 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748600538; cv=fail; b=UvCb+2/6JKIi5mhtST/NiLes4bmUDWo17N6tcFua+zTzTdq8Id8pPBH1ht2T3MG8KHwjfE68Dh34hwB6R0MsQwMbZYbhNOXYc1OgYaBpA6+ijojGGi0orfAejH5O5ZGQPCRPk8oYHMWNlqZEs/l5CTQpGn5GfmEiA3pyqjQ8/70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748600538; c=relaxed/simple;
	bh=8JaynXdBeSOV9Qfv76x23KwG2c4h80nqZQINKNFl+8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fw1bDHZso+Re8Bi1eHm6c5IhObu4KRlcgmNjGzie5cNUmQ7+5Y8voz8FIZ8Jfjk/7ivii2oawdjuNDEOp9s3rmDE7XzFKvTJslb1qtYjZYOuXukPwba2sIxTVrl2xPoSdpheEc9TNuw5Wvx0a+Dyy1FbwzIuWswHTM801ZmLlic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nUmhD/bW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gF1A2Ba4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U6ttc2000677;
	Fri, 30 May 2025 10:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GhJ3NZfAR+hL2gDBjL
	oeKSjE8nDhfKkL7k2fu4ZzkGY=; b=nUmhD/bWQh0/yb2Uj506yezAzLFcdOKe6Q
	sSkN+frg7WUPP8bmCkV0Ac3Zu/1CkZOwr53hbBScWcEo29utxWnkUosjYghM0gu8
	yBM2clx1e/mB0H2qIBAzWCigog/wg7ILGTfBN8p8Lp3v/Icp292wKmMpWBBqGKMG
	/o8B0egyPKazr6g4JZvSichh/8XL0YW5qg8zgVFBaEOROwqmIbzTP1V4vWzu76eC
	h55YEoyXUzZ10wBvKvd0RP9+IkmLpL//PPinCZPC96opbpKV3cA7a2ZWKoroVOr2
	CZ6CKTQMXX7wYhuALG2DhqOiFcO+xAyMG3/xT8BUSoUyqQWOGtnA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s9u9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 10:21:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54U8aZQs019465;
	Fri, 30 May 2025 10:21:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd43h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 10:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+SphPmL0SA1wOjh81vPK33geQvUON8TgKuL1nmGuyINVRylscx4S4H0lC8DGfs/Jd6rZU4gqipcW/l0qXznry3ixjwb2uvJJ/9ZW9Wou3lOOPLu9iFpI1b3f8t9kw9i+ERvqYzXU3P7N03/ujNQXY0socPEb/ru/U8IJaUId+w4mRde3GSwpCkT5oS/Eqi04SmJgzd5h4RMM2YLwh1e4UQeaVZLzpgkophuHEpKqB3EiKUaJOFsDyxjPgiD9KUM3386UgE8MvbeT08HhuLTw/RTFDEgic9Hx2HRq9h8BfLsKY0Ok64Jqs4F+ge6JRIPoZPrl7vL2AH7/HO0uIXSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhJ3NZfAR+hL2gDBjLoeKSjE8nDhfKkL7k2fu4ZzkGY=;
 b=GzIj/UXlOqEQi6J80QgGI2Ua4qrWJeMN4hHTs+UDH9ADrOfNn2BfTuA1GSNCzsV6fbw7bAFzvBrmrD+wY9nvQwuSgI9qiM9jra6+9VUcUUvgBYOXhed1gOjSl7s/Y9hBIyRgY6knuRxIlcyK+KlOooc1wxJB2+isKifH93JlIXNQ8qe613wGIXtePpL/lywN6qM4PMkNkN1//sdnEJfyU7KHLhXllj760o5sYr5saYQiJvYsRgMVV5OxlpHRcH0P15NEqBeFLB44VFABlUNByTLj+k+qsqUfa1e14RzdR8XldE+LDez66gpG2vn9IBfkHbOqxHRsboZpGkjadsD/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhJ3NZfAR+hL2gDBjLoeKSjE8nDhfKkL7k2fu4ZzkGY=;
 b=gF1A2Ba4W/rJvIbgGeIvDpvZZ24Fe2IBtm9kvBcJID1hC5kRp+sfCSETSxa24ftcg3ZEI3iWGkfnQYh99IREI3rAo2+RZhbk8saB2yu7MyVq4cV5+iaMbZ4Ge5S9oIpwoYE7CRbpKu/jnVDKu5q9vtU68/kSjUjPky9s9FEQziU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF717557185.namprd10.prod.outlook.com (2603:10b6:f:fc00::d29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 10:21:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 10:21:41 +0000
Date: Fri, 30 May 2025 11:21:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH v1 2/4] mm: Expose abnormal new_pte during move_ptes
Message-ID: <ed72c0c8-a511-483a-be44-edf7432a4782@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529155650.4017699-3-pulehui@huaweicloud.com>
X-ClientProxiedBy: JN3P275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ca::19)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF717557185:EE_
X-MS-Office365-Filtering-Correlation-Id: fac91eec-4278-44ac-e7e5-08dd9f63c4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPxbKSpVAJRGGoxfk68sj853Z7if24Zuc+lLy70bG1fkLL5ecPCpYcLm0Ov8?=
 =?us-ascii?Q?VA/dY0xp5WxQ1HAUERdgcNXEevCr1uEjZSmeBYIrXbtqAIgLRWiYZxJ1csT0?=
 =?us-ascii?Q?fgfDubwXV4SYVb2i2SOETBhpHjj3aiGHX82BOJGnCIyQNX7enkm9JbJCJg0W?=
 =?us-ascii?Q?BTyM4s+EMoTBcJZ8E8k1q6Dv/IblnrM+7hqfKuRHsxAhMLsEVbogGHXTFnHu?=
 =?us-ascii?Q?M03FxTxIFjR/VWTZS5/B7p+0Wdc/+UzHOFBdvOxX0FkYuHzOoLZl9T5RhTTG?=
 =?us-ascii?Q?gwzsYdy9BIdTIPGKER3iV5IHjXkFzFJU+7N6lTX8rdCXrvbpgtdZOSe17VJb?=
 =?us-ascii?Q?YMBlLQbMxwv/cvWFeJjIR7IDQE1st9P7Ys/YdC4lrVOHOb82lRe1cUfASYN0?=
 =?us-ascii?Q?c6FSBFrIVCXRDGhOzCt7O5mqo7e7Mza/V6Cz0KZjmoPgB1A8PwKAf3eAcLhp?=
 =?us-ascii?Q?mnNbcFDo22PsepnusKe4RnehscPbCHzJewdhmc4bYRsnTHkiEWc9ieCciHsj?=
 =?us-ascii?Q?4WDPU/PXFc3fv70X7gAi3woL6qYjXz7WhCOGRDFWEei83TWwvedVe9JIi8sK?=
 =?us-ascii?Q?BO0wLmgo0rgMDCK2L1OFeZBr7Fy9eN0XL4Ol4dFeOqSCdtHv+qZ5/1sGxZLO?=
 =?us-ascii?Q?BseWIaBJ8uifLzqQsDk3Jj9w7St10ZVYYLYjR3bXL8JPVf97EYl9iKRl8xLp?=
 =?us-ascii?Q?ANbXhmR0wboXOPczmOtZXPmXXcMYuq5Te6KBzanw1UCIoUCKsQ8qDgIWPxRj?=
 =?us-ascii?Q?+8AOYQSDuXy1AchhgCoXLFXzu+XsTOigvjxwSlZwabLRt19YdjcflA3Uui1P?=
 =?us-ascii?Q?4OQytsRmgPWrWseAsqY8R7N1V/kZ2BoNnJm9tORPMhvo1GxSm2vBujzrddzy?=
 =?us-ascii?Q?buFtDqz5fwYPk59R5bQ1kN+bXI4FFWnwopijTXIMVQlv86L2KGlJFEIcVYos?=
 =?us-ascii?Q?9UG4HoJNv9l53PqRGzugqIZ4X7zzcuLVkM/XTPkgxHGnaGmG9We7qd6waHId?=
 =?us-ascii?Q?MXJ5/u/JhjqN0Fo6Q7tdSSvggA1Ys8BHDvkQCrrsXVB9/lUH0M1y+JaE8nFL?=
 =?us-ascii?Q?tef9rQ7GBc2KfYb/MzeLfapJA1yoNBAou37UtJ2N9066xEKObfuKdeozW+J2?=
 =?us-ascii?Q?Aea36Xtt+ymjv4cI7AOKR43KFw+Vb1+AnpTaPxjZfmaUpXUrfLs8HVSmaKFD?=
 =?us-ascii?Q?q377ZuTKQPUIcdmefSP7FWTQKYgDitAMiD+mOfhUPKOBnWI7I25/Ugk248Ai?=
 =?us-ascii?Q?UueMLIg1duq8TtMzSvQEpinRuF9xwMa4mTPn0I1uui50H6TigXphECkPPp1S?=
 =?us-ascii?Q?HkLN2pQGfjI4Tn1NSw907c+WZt8rMVxGfGhLHUgCaUW/Zop7dXkcyLefNqbq?=
 =?us-ascii?Q?3sWMS8Yyv+8qNmeqIrtDdPh+TBnc0LUaKbV6TBiLyHV1nqHwPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+QbFUJRwXmY7ioyCxFK55FlOGWy8qeTMPPBhworrZQwYdVVZqXaQbjx8XSL?=
 =?us-ascii?Q?8N2RrrPQmJ8x6HP1TJGdNIxpjf/Mbst3q34AOKiCNVPpCZpRDgMkG3byFp4z?=
 =?us-ascii?Q?gLUMSQx2OOfk92IfS4KBPXAtEhCI6UIm7dW/3mBI/OvYKrFp/JrS5W3351FF?=
 =?us-ascii?Q?EJq07Lt2oWbqIigHz2icx4bqbl5vVsYiVmM3ZKiH1shiqpCbupIwlBoIEQ2t?=
 =?us-ascii?Q?xdgMYhiMdNYxx26pTqkDpq2TnxoE/UcZLzo4gqIQZKh1N/RJw8ILr3zdirgO?=
 =?us-ascii?Q?ziUtRi6UN6h9P+GS+sYMcr3uNKs8ffx0v2QyTwbwT0Imh757CvipAj+gLwVZ?=
 =?us-ascii?Q?5DQxkLI9veBgRDtb+J2QHnjTHqFYqrdRQSFsDJCQQeG/sFHs5PqGI4Wo+C4m?=
 =?us-ascii?Q?02sIiduk7eHN6mSrgNsNIQgXmoCL/3cuH2iaXDJXOfoYdGkZMzlOSFCh7grp?=
 =?us-ascii?Q?ybSUK+iKm51Wr5GX0q8O9bK5PDvwJCm6BXNrIb/7iCAuF/xiYoLYxzaZLNzs?=
 =?us-ascii?Q?c+A78ic3p9FIvwcH481i1rWh5olMT+QGHCyXjvzQwTgcRYWglOwDJyjTfdNL?=
 =?us-ascii?Q?cPdMsQw8M5iK/3SKWvXf9vNkJv4bSHigP9gtqVZi4XquFVTPXTiPoO2Blv6o?=
 =?us-ascii?Q?YH8Zu1AIsu8HD3GCYyyiRzsHn4q95sZpDBaxja3TMVfxZ3hVV2E/YshU2nop?=
 =?us-ascii?Q?JsmdS6rGDPzkAa1oDqlAVbWIlSVoHVFlD8cIOVW7RbAvu0iGs6S6NX0ELvar?=
 =?us-ascii?Q?sGP7fhFf6wQbdnmCADcyeby/UpySZFlwMD3qFVgoEUNwcEDKWWI1u7MzSvE1?=
 =?us-ascii?Q?4298NlTioTYuQ4dbgfBpdGWhicyXmai4ApN+vh+ZQdeYKwBxyU3AGDPNGjBT?=
 =?us-ascii?Q?qQFAjUrkJJBiVuEVMbcVI6Gr2zfZ4d74BwV+65B3mATup458FBMFAaJ07/H3?=
 =?us-ascii?Q?hMDFGjJ/VC89y+TsbzreBbp287V9cY0W8MYxZ6aRPbYcjKikEr2BM8rSnjU2?=
 =?us-ascii?Q?ezmcyWFmMtrN1MDKQWmTbKgHIE8NebDQsJlMNUTYp+Zg7Oi2g18feUedh0Sd?=
 =?us-ascii?Q?ZPYK23rmtA3hflvgBbKaWYOLmh6DDMJ1FjRo8DzkRzLSZJ/SWs3erUvfKEVH?=
 =?us-ascii?Q?g0ZZc+4hM2sFGv1lxyMcGKFZYP1AZmlRmU7D96lcb+6o7GR6/RWjoHUWGyYx?=
 =?us-ascii?Q?Vpvb0gMfROTOmGs3GAAV30FYpNNKcPx9cqUlvJqFqswDO0IpTlEcadtUcuV7?=
 =?us-ascii?Q?SwFLsKTiDe+8S3RS28UcUFuiX7mw0LSd2VdOWG4eRjVKsqZdxkZqGAoHglxd?=
 =?us-ascii?Q?d4tohUh7o8ksYHxSG62j44sjQVQTKYUhpvT7mu80HPevjUf/DQlKQcAc4DLy?=
 =?us-ascii?Q?e6C/28ENtaePTMsq9eAog2npZ5z+xUs5Bu1T5MiVThWMVHIsHbAFOBpqJQy/?=
 =?us-ascii?Q?O93PrLitDFMwcec3Hgfm1rU3WwaMnVH8JiqjXII9/+UGPi8eHrKBemEI4Et9?=
 =?us-ascii?Q?SPwKC7XhQ/3sDjiyNgJqyT9ls9BPaK1wS2kQrO92lHR4Cxbg0AhIBFZDkcUG?=
 =?us-ascii?Q?zXQ9s+Qyyt7Utw4rhbcTp6/hfIiDMHegg0rBPHwEWbSoU9sKnDCvfdlz6VBP?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Vn0KGF7OMumTAdVzmHbXZ6rxCqUi/R9CAEpBZ1iBpEagOjTqtUbdKRz1D25KOMpg9fBZGxMvodCqt/SmnwBt2GKXoEL/PnYMcyAFwlSrY2DossyyWSuCyu0lxrSFR/h6j6rO/QefP85ZjWjCjF7B/70QL9jMti7Xd14BD3AR7zocLUsooK4jzXypMyaB3w9Xdw0lDFtFB6W9ypey2RscWuLHnFJ9wQsg+/bHtNFxiqDdPqoc1SePHH3YqDEboWZa2c8KzDz3iRSMiOubLA5DN3K8OB6OsVfbNjQSgYBCkd9dzZMARF68B9dl6EV52Y2cNuxeM/pqxweJ1evFamd68ZwL5av1+Dq4LwtBzBlCy6JqlHIgxT48OFmeMtlZYfnvbHalRXhe16Tph7NwtBrZDY6KmACKUEpnZRHjdr4IAE8jIAwAV5rEiZenJzHIh4WTO1hjVAp9uhG0JOGJkeck6Rgtyu72idDHl1tVXUX5AJufcZeyHnmpPNngSP8do3qtWkrO9R0lbjsDaPffnhNJi6AEl3vCqpXOy94481WqePNLSksv/Sw3eHcBbIyFvlW54uqSUsVDnX+Jzdck8vf5/KaEgPL/OP4kGawMHovfeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac91eec-4278-44ac-e7e5-08dd9f63c4e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 10:21:41.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmicIsgwpCnQ8/oie/OEVyH/rA2OsYe3L7YdOg3m81NBHJCt2o8OuZOzu8hlMxOn4iB6jQyLLol5wDbUohTruuIGOB8DjI80e3iJq0QSorY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF717557185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA4OSBTYWx0ZWRfX6u080+2JoTke w4R8eLsUpdb21B5WC9g8Zub7XQT9qF8OFevlJsmPe0nYjATOAQa7z51UXwvUm8ie92Y7rpjksV3 mPQwC/SYvhSFSwieeERNhCJs9Z50o4U2H/O49+qxnzfOft8QZ3EfSCSjhCyGjvzEZ8xLf6Wp5BV
 vml0XBzT0Q5/3ymzK8aR+aDHDsAR7j9hcZBt1ZICC0IFnTJoTx3ZUfR7cIDd1xGcAlu3ETEqLl6 sR3431/p9J77HnN2li9AWUTXJhRGKA9KgqarXKAurqnFVhswsO6JfB36G0RBQDOTt4YdluyXwVP +pDlX14i01nO8utNB8iW3H42/NGwihFvtdPMLzJcORd8ORHuJjOKqyMKHFsRNmUK1Jvy1jV0n54
 D+RJz3WkeSZ+zofCD8BZBF2y02EeI/6YygkB3PIuZAz0ett0klzKm/weNXNp+McolrvE9WsC
X-Proofpoint-GUID: cah4SK2yg8xjoEQn2tvOVK_Ppz8u2JJx
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=683986ba b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=pdG_qfMyCWuCLcrjtW4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: cah4SK2yg8xjoEQn2tvOVK_Ppz8u2JJx

On Thu, May 29, 2025 at 03:56:48PM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> When executing move_ptes, the new_pte must be NULL, otherwise it will be
> overwritten by the old_pte, and cause the abnormal new_pte to be leaked.
> In order to make this problem to be more explicit, let's add
> WARN_ON_ONCE when new_pte is not NULL.
>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

(both this and the amended version :)

> ---
>  mm/mremap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 83e359754961..4e2491f8c2ce 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -237,6 +237,8 @@ static int move_ptes(struct pagetable_move_control *pmc,
>
>  	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
>  				   new_pte++, new_addr += PAGE_SIZE) {
> +		WARN_ON_ONCE(!pte_none(*new_pte));
> +

I mean, we really really should not ever be seeing a mapped PTE here, so I think
a WARN_ON_ONCE() is fine.

We unmap anything ahead of time, and only I think this uprobe breakpoint
installation would ever cause this to be the case.

We can make this a VM_WARN_ON_ONCE() too I suppose, just in case there's
something we're not thinking of, but I'd say at some point we'd want to change
it to a WARN_ON_ONCE().


>  		if (pte_none(ptep_get(old_pte)))
>  			continue;
>
> --
> 2.34.1
>

