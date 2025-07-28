Return-Path: <stable+bounces-164879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED85B1341F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 07:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CFC1886D58
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB7219A89;
	Mon, 28 Jul 2025 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r8dve/W7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u5a9F7ps"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EB145346;
	Mon, 28 Jul 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680291; cv=fail; b=K31PFP41GHOaIoDRjS8yxCLV0vRyLR4lF4jSy60rpmEMQfRfGJcCGpAmV3/QcXSpUGsDq4AJ2xC2/UQX2EytM75lMGxazWGee/zANXyvtfR7izh5yoAAw52R6llQIq3aD6ZgjJ3CLjYjci7JzeHZgK7rrNjYwSxBQLIupl+FhHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680291; c=relaxed/simple;
	bh=t3LVgYESXNOTN6gi0PhrLLm6QMzIaLIYcEA1cKoK2DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZB5AL9s9KT0v1F9f7a/Pe3TojH8KUpAUHrW9Y4ljw/yMR3Wa60T/G1pNnlux1YIwqORlPvBHnvFU4brhQqtcyVgfUx2ajuciFdkvtOxPoerL1i3QoEOJdbkkeg2+yL9MZvThtH/AAvTYFgWBXOCj/qtIHkN98vnBhYo5CfiatU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r8dve/W7; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u5a9F7ps reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RHu5MP005126;
	Mon, 28 Jul 2025 05:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=enkHyzmGSbBtJ+hs+Lnx7nLie+CqJpydsGqzLBANr0Y=; b=
	r8dve/W73QATOnRmJ1qEyrgvsNJI7ChF7r+tHtnUIYh8PAY/jRUa6QvTVnaHUieA
	eJvnZgrNAw37qwv0qIcvpuArXcx3pwfvuhFKAUvYWCEscj+o+Mlg6WzkwUyUBrap
	M5vKN5THBQeV1jhOcirDZvwsW7gvYQAx5I35gFGe9EMvT5+iznf2im1MCTB1TX/j
	E0j80/jeu7vnUJ0R3EgfHGomosduadNnsui++umM5ls9Ga6PdSwVlKmpGnMi3Rc1
	uQEbLtKggwvroKiYYWSIqNU/TZvAVTZcETHwAClXgMGo3zqYge04Arft/ltxnopX
	+mOhBG2ycegKLUVKdt1edA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wjcm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 05:24:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56S2bi54011238;
	Mon, 28 Jul 2025 05:24:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nf7twac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 05:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRew4OUMlRtVL36tyfEaQUuz5vfdodMHXLOl2pxBz7lsV7Q5b/TCT9plKJGGDtC1psX00hiRyb1bmAxfLME1QJJKnC0PUxrFK1iS0AenjhsoUntdHejPPdnkzobQcFy0+NmLH6SuURH/sPn+vLTQR0iBbxe8Z1hO6y6yXvAhKO2Olo17wDaTcfifuiqVoM414NOua5rrz2jA1X6C33YS34dFSKFR53hoseOubZz3GXTqrSdhy1jIg2wWbBIOSc5yur4w7TMhN3/z3LiHaXxVXhUtP5lmy7nqIcQ5GvCPozvW7ID5m2HmZJo1sitivifSutpcPzwRdCxJlY1W36lbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipiF9MPgGExAsBBLcWv5CzvP2jmcH99aKUuTTonpLQ8=;
 b=MGKAE27g7+Ts/hn+FfZgUnCnrm6celYzdU5kCOJyHZ0wnNm9yl0PTQrkojZHeSQAVKSoLxqEjDWFm8mJg55Il0iIlu5BlAcdCum4lfj09+vt7jonU4D+UzV2U9qsVKtBWYHoFRpupD3XuEtV87sGx2RALmVrwpUkqbXdKu4HRq2DHGVCv389RRvQDiiiZXQxFQil9VyGfWSmoOktk5agRW1DDrXGsFQ6vlm8Yo4fzWpJ6z8nr/aBd0hGJWuDBsO9Lsf5MWb7ntjZdZ/EQlLxvtVxU+zbM45B4gLbBdmOZH5z6LfwNln8guG6JIJnqrKS62QUCNK6Y7FHKFpWEnpXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipiF9MPgGExAsBBLcWv5CzvP2jmcH99aKUuTTonpLQ8=;
 b=u5a9F7ps0mOu8yuKtjjHNer47XyNm1vK4M+R1K1yuk+2F4y6TgF0Qfne2m776Aao10TMbliTQ86Er4GRyBwNhjqzR0UOg2B583a5Z6m9Fcu3r/948tPzvTAA4erdehZ86d9sr/bvXX+qChrMG6UkU9bCEnAf1J7JrX+H4P0DQho=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 LV8PR10MB7750.namprd10.prod.outlook.com (2603:10b6:408:1ed::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 05:24:14 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 05:24:14 +0000
Date: Mon, 28 Jul 2025 14:24:06 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: liqiong <liqiong@nfschina.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aIcJdhoSTQlsdR5r@harry>
References: <aIQMhSlOMREOTLyl@hyeyoo>
 <e6f14d8a-5d32-473e-ba2d-1064ab8ef8fe@nfschina.com>
 <aIbuks-8-FOckIjo@casper.infradead.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIbuks-8-FOckIjo@casper.infradead.org>
X-ClientProxiedBy: SL2P216CA0119.KORP216.PROD.OUTLOOK.COM (2603:1096:101::16)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|LV8PR10MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 60060680-2646-418a-2143-08ddcd96fd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?KTjdYyXE4bX8XxY3enG9D4TJaIo4qABH03IcWXEbvtCzb5buZjUE1OCWdN?=
 =?iso-8859-1?Q?V5lc273rH1F8UK34erSAX4d4bHxZMvuG0NsyGoiNpaek+NnPk4k7PK/irQ?=
 =?iso-8859-1?Q?t6rbKvZ3foTMTSpDbguW67ugqPpiUtTld27yN/ePci1ksD/oSN687XK7RG?=
 =?iso-8859-1?Q?i34VAT01vDmm3Iv235BPDYT1DznsakyMO1Lpzvew18Y0D2fHHxSwaKvgv3?=
 =?iso-8859-1?Q?Ld1/bTtC4bbubtPKLOGGYCA+3IXeIokoGJFcDuLyUc1y1VRbsbIW05hZ4i?=
 =?iso-8859-1?Q?Wthv+ZECiwGFnsmCnCBp34UMvHAfpD9Y5uJpigosSRC9sBaQW2XGK3fQys?=
 =?iso-8859-1?Q?kMBO0GJNdLCIElvOHSpdOYczN+HeA6TE3yAcxDDuPwEgibhiqgCJchib2V?=
 =?iso-8859-1?Q?PyXtGXrTKuQrSzONp8bQnvfSbVcUFeqY42lRYYr8HCwjRBHDueob8eljtz?=
 =?iso-8859-1?Q?yVlV/H1A2IwksXPNsNfhb9VfEdqRrAG61JH4Bog2UZxQ/QPqaT6UYibdEP?=
 =?iso-8859-1?Q?dlBUZJbjM3jJDPOFym3ggCcL+SPMm/dCAYysXTORMFs3yb9GB//x5Cgs+P?=
 =?iso-8859-1?Q?J2tHSnpVvg1u+hggsRIs1HN5uflJ3ZHvM36tl4l59zPtbXnRDSp1GqzoI3?=
 =?iso-8859-1?Q?E/IimwG4D+lplYwjCCJo9/10I6rvsFRu4WKtSZPu60p8r6Bn0YrYKn9yUq?=
 =?iso-8859-1?Q?zYlH0wLvfAcwMDexvewSspfqw/ZWuQT6LBf80W8MNedBF/tqe8ZkSotao4?=
 =?iso-8859-1?Q?yuXK5ylI4OqZhNLhNNKcp5+jnu71A2MCJ5uWPeMdhHHBAEZihqu6F8ZYYB?=
 =?iso-8859-1?Q?bzLH4ykd6ckKtUN4k8wvve9FdRE5HzLM+Sjhw1cnD0PfEgl2aLTG78NbDl?=
 =?iso-8859-1?Q?Sz2aroebbuE3tHRE89LBysLedQGE6L55Iztvfd6OFTWmmlQ094Fohix3Wa?=
 =?iso-8859-1?Q?tHNVZ8t5TlS5nXLa0tXlZE/DUJSlS+cpmrQKytvkhVIjPByg7ZmTdJfMwX?=
 =?iso-8859-1?Q?bCCb31EVPOgtcCWnqcRGX2gfAYzt93vjGuc51HdLFSK7KivAEGAoPVRUMh?=
 =?iso-8859-1?Q?4jBYRLQpYG8vb/AeTFhgUEHlOT0R0oruuma7D/8T4MSXvxcrmIX+x2ozkO?=
 =?iso-8859-1?Q?6ETr04+LkWvODvLv6K2R2Rsk/W/M8MeVEhMtYqX1psapmuDYHjCeX8ib8t?=
 =?iso-8859-1?Q?OEyd/kuipt5I7+bQ6jVVIvNyyu+10YIhgblZiaXYTA/g/Ja3QlS8ULASbA?=
 =?iso-8859-1?Q?KYQR7oCKl/zESTtcmshMWBGvU2i5xJLrJU5zjr4LTnXLQ5K7xR0V0agQfj?=
 =?iso-8859-1?Q?DcwyTAE5hj1jTNvpBWBjcn1Kc46O+6wTC/tMUmTWKIFcFL/mAlg0HhP84v?=
 =?iso-8859-1?Q?S/Tjjk+eYSaEmgnqHRlLXRyv2X4ab1Yufh48od6capALU9SmdTTZyGz8ns?=
 =?iso-8859-1?Q?KvuKscHS6ZeWU/4pzNC2KFpxd5ZckvF0Ys3lzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uvIfPT7urPq15AgGmOUAGN62eemPIffSE3QmnzdFmqGF5Yo4c6SgcDUx0O?=
 =?iso-8859-1?Q?zssZmdwMi0YgHupe+xykxNiFsDvME80TP6y3SW8s5IGzIFphY3ffppazpj?=
 =?iso-8859-1?Q?oJRQfr9jAcFJ/0Y3aYjfXingFx+fLDF0dWjBT2qI7SfKqzPwrn76dQ73pH?=
 =?iso-8859-1?Q?JFY7XDaL3x3Wdr2TH/RhPncSfhkqxpND/PzM4PyFBBRqa5rufyt/sVk75h?=
 =?iso-8859-1?Q?2TCsHuXASExnAilZmYCzhQ4dqKvjwACRuPBoLf6NC+RD/UhxZTseaHcP+q?=
 =?iso-8859-1?Q?nYVngm5JaPoc9rqRcoV8Zb/m2EapfYMEvqqUbxi3ShxVTYV6uAGze69GJw?=
 =?iso-8859-1?Q?AS/9YjbVGTk1EL2HC+XfMdMrIbIogxFXsERxQylAClNevFzLT+7geUg5pU?=
 =?iso-8859-1?Q?4aLWFcvhAYpUiu7N6hgo/KdGDbWmOQGa+A95czPVTJIxy40A0Au3lGibsQ?=
 =?iso-8859-1?Q?hsnF5EyyOrzcLDwKyh3grHI2kXpfFSgA9OviME2OzL301BZir90K9HDxpc?=
 =?iso-8859-1?Q?CJwz5AxUxIIbgJnH/GqQbtOUQ+tN/pShBmTWBPs+H9/F5W1guESyj0yJYe?=
 =?iso-8859-1?Q?5jhAdOxCp/Rbi+Rr17OudRI9OgyABqDb0cp0v3nSXC/KlPqBioGmzcSADy?=
 =?iso-8859-1?Q?RGzuRoXpRNBzUINHZfuNUkVtEjUFdkC6677xT76fZOtmA1ABqHSz2oflzW?=
 =?iso-8859-1?Q?nLcwIYd5n3bAgTGdf7bVx8He88vvhaHaE2wtRt66H4PtuF3Z8mikGOX/cj?=
 =?iso-8859-1?Q?MTuN0QWDe1m4YxsD2SIW/iQzrvGxGIW7uzjMwEGoFjt0GF3UUZHtybYG6w?=
 =?iso-8859-1?Q?6bL7qfOzF7n9SQ3S4tI150rE/hDjNnCZeqWlXv+pMSD6FjDWqJnAHKR42c?=
 =?iso-8859-1?Q?dEf60LaGAefSozk4DY5DO8PyXXf6umMStOldP7L78Yc+S8Epctd6K3OypW?=
 =?iso-8859-1?Q?X3JiLF2Hpu5uJYpxewuQapOuQRqMhINRE2xKIY5+eKqZzwXqWmMKt95yRs?=
 =?iso-8859-1?Q?U1LsP8rTao/1VveQqowUiwww8booUyhTJwTjpAlUVYOmjBynYfKUCQeLNq?=
 =?iso-8859-1?Q?wkgZneDQ3tkz5RhsxkjvrEP1/7Hutrp9a5/1diQW+Il5AqCOIk3dzV1QN2?=
 =?iso-8859-1?Q?S+MDCQlO361P7uFeNOrIK2RCnOahyPISmcWbAr+x9PoCO3mIgqztfKIwXj?=
 =?iso-8859-1?Q?Yn4kQyg3cW9lvFti36EjbWrqa6zghFyIqCD3ESsra2ziZbTu8A3pgXk0Mm?=
 =?iso-8859-1?Q?Y2DabjiogQdu1TaN36yYEVEPNZ32dGaddZbwtIvVhWLeTlH4AID/7G25Rp?=
 =?iso-8859-1?Q?fkj7bdNUPW+r3p3/34LHWp8+t7NMt5DuE7MTYmtO2emX2gxIGihehZAD4E?=
 =?iso-8859-1?Q?8riBwgf2Nn+jYsY1LwfFjyVWoMetUU3GntWBi0GJ87/5A/ttq0Qo6D1x8s?=
 =?iso-8859-1?Q?YgRmFV82xf4OWV8RcfobJ20JSSBa839p0krNhtawQz4ML2CJ6jq9n+gjzw?=
 =?iso-8859-1?Q?gHy/Z3GUm6N2D3iS2u3RbDeq0vwgUNXj6wdMxZi3MvgdtEm/QFOcFTc0zX?=
 =?iso-8859-1?Q?hUPHtAmIWHCZIjRL/HPnka+zpfq+0N3jP1TsI83mg2cp77QerFMqIQgHLm?=
 =?iso-8859-1?Q?+0KBU0YSvaPznFEytuOt+FM2VRcylIJh97?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Il39UH+gQYgyROv/gmUZ0TZQ5a5/PeSdZ7/ME1MoKRjpPyKVkmaDv6s5TVsP3zwKLpsNuQKeHo/iDrwkk9wyZ6ejoz1GPb80Qg42FcD/BxecKLMfQpJuQ2TsjZvJDAvvSo+27nQ9IKT/h6nvAAcAuMRb2aI/JYRI44VTjdyPFY31J2HfpeJCMyrz622wnTpMnKEXcpqg19mCGZcUNyAEwDuWnJa9ytdyCfZOpGOm81LGqRh53D3urh7bC12FvgxqJT9R0296AXtycxV7JZQTfwSfsiYa/ERzl9GQi6mI3iRDE9pItaT4S22LeAsy32KZmSeECuUKNINX8FuVxzg7OTY0CQWxj/p7neT3l1rEOkfMncw/v1iYY8AzAmFTQ1lq2yvgLOY6g66LfmHcYCxMMnjLelicWcczvKBWoTnaolNBrytugpiQQc6PFYBBuXClmv335ljX5OMyIOdCEtbjYz1wkoPAQIS00d6eyhBr+d5MBRG9uGVfMV+rm7lKlwkLO6MEPlEfW+1uU14+y9UP+Ze3oyvj3XvOMeuQwzVgc+DXjejFxtFYceYL4vtcpYg9NirGPNUHJiYO3+TwrPo4kMdbuHlYP7Yx8nQpGI94MaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60060680-2646-418a-2143-08ddcd96fd82
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 05:24:14.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD0FKXk+V7kdH9emcfrRxMq+O8YBnylwqpUkFd7X5cSiTA/VDnSZ5IPz0xnvYv+Dw1rqyg7iU8c8OAUhdx7EQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280039
X-Proofpoint-ORIG-GUID: 7TckyrCMHD6pg7JwZBG8Vod7OIoFm9_d
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=68870982 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=Meyl5ONtwRgYlGyxCCYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 cc=ntf
 awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAzOSBTYWx0ZWRfXxmSCjlw/9h8c
 96lHJQmLNULonezdJejMcPEixRNycsyaH+U0HWDChNZwQt2GkUaWizhMUGE5CV0sLfPqdndwP5R
 qwlatznDJPnuPAXslf69Ryedx4STU2HVMfIFyTw5KO5nh10CE4+E72c+8olFWSUxz4UJiQN9pJX
 zUPVhnAkIMT+v5cz1ph8yL9HQByYFTYartvFJMuYw+kvTugtdTn3VJdcz4HSCSBk+xc4FV4pqDA
 qPR83n+lsbLkjD3lZBCpN6ckLm8RVZzjfKpe6bN5Ud6QzP2ebdGKvaTWwpjM0mp4WVEU9hfO6qV
 4AdWCm++sRi2fHQ0uEevF2cc/HQPuW1ItBgiG1U8/SBQhXQnvMaPuIt9GNCTO3j2LrqU2ZTbcoT
 HlqbRBMgj59xo5oa5q9cez0cwEAPaP2Aj1C2vPWtOM8RnkA1/LEXdk/tPc7iSV4Rt5+OtiU1
X-Proofpoint-GUID: 7TckyrCMHD6pg7JwZBG8Vod7OIoFm9_d

On Mon, Jul 28, 2025 at 04:29:22AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 28, 2025 at 10:06:42AM +0800, liqiong wrote:
> > >> In this case it's an object pointer, not a freelist pointer.
> > >> Or am I misunderstanding something?
> > > Actually, in alloc_debug_processing() the pointer came from slab->freelist,
> > > so I think saying either "invalid freelist pointer" or
> > > "invalid object pointer" make sense...
> > 
> > free_consistency_checks()  has 
> >  'slab_err(s, slab, "Invalid object pointer 0x%p", object);'
> > Maybe  it is better, alloc_consisency_checks() has the same  message.
> 
> No.  Think about it.

Haha, since I suggested that change, I feel like I have to rethink it
and respond... Maybe I'm wrong again, but I love to be proven wrong :)

On second thought,

Unlike free_consistency_checks() where an arbitrary address can be
passed, alloc_consistency_check() is not passed arbitrary addresses
but only addresses from the freelist. So if a pointer is invalid
there, it means the freelist pointer is invalid. And in all other
parts of slub.c, such cases are described as "Free(list) pointer",
or "Freechain" being invalid or corrupted.

So to stay consistent "Invalid freelist pointer" would be the right choice :)
Sorry for the confusion.

Anyway, Li, to make progress on this I think it make sense to start by making
object_err() resiliant against invalid pointers (as suggested by Matthew)?
If you go down that path, this patch might no longer be required to fix
the bug anyway...

And the change would be quite small. Most part of print_trailer() is printing
metadata and raw content of the object, which is risky when the pointer is
invalid. In that case we'd only want to print the address of the invalid
pointer and the information about slab (print_slab_info()) and nothing more.

-- 
Cheers,
Harry / Hyeonggon

