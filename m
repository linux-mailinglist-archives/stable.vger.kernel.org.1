Return-Path: <stable+bounces-166257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18223B198C6
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2BD3BAE56
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D91DB92C;
	Mon,  4 Aug 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ER0qxJxZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ls1HTwOf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803217F4F6;
	Mon,  4 Aug 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267783; cv=fail; b=lmbcqm73fHvtGc1bAk7wN6AEPoZZqhwtP6EKuU6E3AxIPBqiY5H+9Tq6U6d4wRteNYYcSX+jJL92x70evd76S2p4qXK9SCky1SlIthSpolp1JljEBpvD52EnKqTesGKNkuZBRsPGeN9vNvVV1rTLzAPtpniSb42pgamEUKG8EVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267783; c=relaxed/simple;
	bh=tonJTCCoiN2w+s6EyK4upKdJUc2Us6P5jFK67IWLy04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZ95xH5senKebxfhor2/UvZ34s3IhqCXd6nT57eS6r1wRq5NpI+vKFCZ+osspVliHKSTf6BZQwss7NwHVKG1BvLGzHcppEhPXxeSAuFQN8tJ1umnYXIJN5WEL/1un9+E8ZWiaezyAk0at43QN1cGsfmKTAJqesbPpY1tK9P4QGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ER0qxJxZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ls1HTwOf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MGj18027526;
	Mon, 4 Aug 2025 00:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PrQCNB82w2HdPzoHwJ
	+q7jhCwbGeLFyZfT71P5agGxA=; b=ER0qxJxZT8ofiUvWfTJZ2Q9uMyr5i2ePaJ
	c0phNw+w2ucqPfVjX84tKKTsqiW0lvM/sIBgDobd0bgwC2hrj9kCDQh9SspAIFry
	tzqmKdTyhoppsbh+2T5SdaLiqzChWgTdJOGBRd9F2O5bNmpY9gxHvzcVRyk3D3dl
	B32WVo6zInNyFCHBVb4d8dGILcoAqeM2ZUeTEV6Cfyp3zBqjbatEayWnhxw59kjf
	+WearYcf7bCAKlPb2RVUtyaZ6MrATgTgyOtIWqyFSE6XRXNy2AHyfsFH1Xo1cFu2
	Uh3jkBSAK0cw46Of6trh1FqQbCfTtyIZqXC2BfMlG2fJEgSV0m+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vskvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 00:36:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 573NOk6H014546;
	Mon, 4 Aug 2025 00:36:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q022nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 00:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pta+pw9mYr7Bx9zhHkZaRfSjgq7ZKpTIiafPUA9npcn1c66qnmexJfxeC5lkjtQoZM/FPqX7fpMZhR1Aryob4+hUC2/gPDpZQiMju9ojLPPd4GkhNxJN157CBRghc6ZXB4ukD+4Yk7xj/I+EgRh7gHvg2v9Z6OqBP2EJDyow0qwoBEWaVONH/8Ebwlk0Zdx7NXhEu7XDV6kBd5zbrR7GflW727syid+yuSQWS1IEnaKmvnKSjF3cQboweLVVeVqvfSjjqC+3crImgehFnK7HpIXib8S3yuT7RRR00Mvz3P6FMGJNF5Ix7QKPPhefRIpgJ2D1np8osHNA4xMDRGJ84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrQCNB82w2HdPzoHwJ+q7jhCwbGeLFyZfT71P5agGxA=;
 b=anabPYDOi7K28F/1P5LaD7/T2wCHCy3bGmUjTKVn55K14To8QvawFDq7QecyyaElrVA6yI8mZX8LwF9dLRjnli/9uQZyyxb54CwmwEexpfuILKvP24/hynQMvRGwCHhJV0taWdl5KS3UykcLRJBKOCNHhxF/oP/hVsD9zbpT0e4pBOVmh4+LMYaVYjRsA2pQQqq5YKRpqA8mWX+e6rHbfzNjsPgsL8JxHPz2MTlEXcTZ2d/qXR79bxpY3AX/EXENhkl8+zC1UfD8bDgsMJzBRQ4WESpvnwTYV+senxkVM7rpzQ8z5XeFCGhNIIwSqatrlQxAduucte9cpLyKYpaxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrQCNB82w2HdPzoHwJ+q7jhCwbGeLFyZfT71P5agGxA=;
 b=Ls1HTwOfmbUJ0yOE7AHvMOa8hWWv+69QwspfTlA0OnhgZB/pAu7htpn7xezmUyiGQDzQC7PqIEHKfIuUyXHAgsrioawks1HZ48oZVgGZf/VKV9jfMJz5rmvCj+Yff8cz8rx/y0+8yXvryI7TezG+NEq5Lj2ZEbLVHcNV/6MRmD4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 00:36:02 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 00:36:02 +0000
Date: Mon, 4 Aug 2025 09:35:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Li Qiong <liqiong@nfschina.com>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: slub: avoid deref of invalid free pointer in
 object_err()
Message-ID: <aJAAVIoytyZroB6p@hyeyoo>
References: <20250801061036.528069-1-liqiong@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801061036.528069-1-liqiong@nfschina.com>
X-ClientProxiedBy: SL2P216CA0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 2001b289-7a68-4053-d99e-08ddd2eee3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CAAMU6d4yFT4TW4FiJbRvZITwZQKvVaGWnEcQxXa9YBIU3jTxPwdTAa7Vgct?=
 =?us-ascii?Q?CzCduarEGvgEMiRPiDPTqAlyIDw8f9kR521R4QJSReM+CLTM4cSFKo3T6+os?=
 =?us-ascii?Q?VGRhi7n4nZX9uo7QNPE57XIgv4k6NGO9VXwOeZ0u51o6yc3gWhM/LheEmkzT?=
 =?us-ascii?Q?SgK1CoNCKcg4i9h8uzTxMbw97zXnS6MW1eZNwzo+57IayOHZy6jw40ivez4L?=
 =?us-ascii?Q?IpUDql7oCJ7lxxY5vQdiznG7UHQWVVfMq1jPN5teUtk8iPqDTQj5Fc98n/Tq?=
 =?us-ascii?Q?plG2JvPUho+6p+9YLakzIQ4ZGcSDgpBLXINQl1sF1Nn4lIk6X9rPckPHgQJD?=
 =?us-ascii?Q?2ekLbZu4n90/bwA2fTYyyYxI2S6tumm5HckjpJHEciL5FAew8ckqUtVrpy4f?=
 =?us-ascii?Q?svRxLGxrVueaJxZdjIMVQPFS9R3slhhxgW+I66CiYjS3NCnCcVXHuHNp0AHa?=
 =?us-ascii?Q?iUpkqORlZOB1hj+P13zp6SO1Z5jouNz1NyO0JWb7IRikLHQ5HuvJlahSDQCP?=
 =?us-ascii?Q?gJqWDacNSegx5Kej2zqRzLQ3mvO+NHsZpnYil17tbLydraDT/lP97ukvA0pn?=
 =?us-ascii?Q?HMfywFHSVYiRQ91NmSyNLDQmXVTFXsX3d8ocssLRCHh1l5kJ7FBdYAQabcms?=
 =?us-ascii?Q?6QsIRaVw/twvk2PXvV/6X8wnI/eD0YAeKQIJsVJXPI49F857pGUwQyddJAiK?=
 =?us-ascii?Q?RqzGzf50s2WdeEfFPDt7MdZrWtbmWYhxxKPw7ip5uRIlpa+KBC1gwKr9uzez?=
 =?us-ascii?Q?Or2FMU6yCF89goFWRvmRA1+34W/VsHIiiw1CfeOC+5/I6I9StIl6yEKTxddW?=
 =?us-ascii?Q?FM1iUa8bmwEpk/SQtn9Yru4FGvoq7Mm/OLYzMnAWxLzYNqqsNRlmth++FcMx?=
 =?us-ascii?Q?qjsJSQjvOR05puFNQaXFvORDX+7lm73cQEfKDF9hdo+9VMvVphCbHkdQWSkt?=
 =?us-ascii?Q?6WIfezbt3t7yDyTih5iWLEFaQ8wNc9zgAD6P7CX7x43ItX5F2tyikDicwXMk?=
 =?us-ascii?Q?8siZzPwUo2JVNReoGWcaoHIx0URFR8WfXChhVocFHy0FHqYb7xNQQXdi/8eo?=
 =?us-ascii?Q?h6INWBok8QBMHSWA5vZo657Gu6uzKqHSFPysMGqwh58bV908wxNfL/aM3yZS?=
 =?us-ascii?Q?wF9S7la75vjDfGOvxwEUr8IYDZMfpgIRGOPmbETwugPtDpId6vMko95dP82b?=
 =?us-ascii?Q?vNr8XPMZsKmkiJZgXZq/aZvh9TYEZfVX8mmQsT6VH7TkMq7uFi27+35KKith?=
 =?us-ascii?Q?wSQfvnItMr8KCjxQ3I+WbMWBWhuQFvRHgjiAKv2X0EL44dRxOWVyKDGPpLNh?=
 =?us-ascii?Q?pYE0oMf7tx0KRB1H+PpmIPcHouLYwUHC26GT0YI6byD645LWyRDVo6btcHGe?=
 =?us-ascii?Q?PvPmB1f3G2dZ+p+JwlnW4bMZ6ZTJaYMtkCm/Jce1ir+EM/WEtqQciO3GQWDo?=
 =?us-ascii?Q?rWFHY4xi118=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zymf7d66tuRtP0/XXZwBo5DtURFgTEs3lB30IXlhV4e2OIAvh4jMrjI25BPR?=
 =?us-ascii?Q?T22VSiAVvROu0byPJOYaV8MV6ECyspmNrdbfFCLToBcZ5Qo6LtawBVGpI3sD?=
 =?us-ascii?Q?YrWFEQZMuJMmCqsMiLdvZ6FWukqFUTlg6WIHOM9jhFkkZzKMMeEQ0/MuzjBA?=
 =?us-ascii?Q?zSSbOaBWD4rYbQvGZj1ddUyS2kNGdnhzcOytycyhdPwTwYk5mAu9Bwc83bLu?=
 =?us-ascii?Q?BMPRkUIR2m+ieAgYkUVT/ErPp1XiCH57l/SSF4O5gW0LE9F9I1PO7q+Rs6n7?=
 =?us-ascii?Q?luunrWLvtp3a07T4lUUXJOV0MRTj/rglZZwwxYUXJHKFhdfndvQLWZ0fFviF?=
 =?us-ascii?Q?rYLmK+uzKG+VdvfIox+g7fsOsFlEkcWxXI0DlK6/qc7W6d0OTvxKLaL4jKie?=
 =?us-ascii?Q?URMb+X4yPb2Wr4IDfRl5swAf2Arph/a+98oX6F8Tn/EpVyO0PFzS2LUcFk4l?=
 =?us-ascii?Q?GjsnUJ4Qq8wtRTF84surGqnKAj+kM9zBxWS+bw8iWkpdAZThuqGLEhgkkq3T?=
 =?us-ascii?Q?0NdPHG0uS/4kwOTTr3+GnQFzw+2UR4PCxC1ssaoPvp+6xtdM9Mi1niJrXnCt?=
 =?us-ascii?Q?KY78wNYiXsFbdaURQ+gByj4HYS86Ni7+EbIfunUq7V5vH2K7G+PKLtI97l6B?=
 =?us-ascii?Q?UubxJVQrWqXqCUd2YdyP2estlGBLcQvW7NFzxU3bSEi78PGqOG7RwwVbmRqn?=
 =?us-ascii?Q?qOJw77dro+xueAoAZWWX0Q5GBIXBrSi2cRoxtwT2g2lCicuMQN1x3C6tH/Dg?=
 =?us-ascii?Q?1Sv91I+PP+eFXPDoh2ZYyGL/biK/kDkVmqUVofUDMfx7IoP5hULibxM2D9J1?=
 =?us-ascii?Q?cAUHQKI9G54q5fHNkCeS+o1tgmGkal1jOCOZo10i9RdYfaiqsULNcuCsjhPn?=
 =?us-ascii?Q?LEwVorXHE681Va1m2hQf9Bs7ttiXZBLdfO3DcKNB8MRmTJyAhkEUo5kw50sq?=
 =?us-ascii?Q?w6rWu0knEGyqtqmWwMdhmI+uaLtuKWasOdPL2XvcH5HRGeAHnL1gml942MqQ?=
 =?us-ascii?Q?0YqR0V5kYcXNSCYSiG6gDMDv1BiU/Vt3y3b/4rYD3kVenYyofuhGrqLTmSU9?=
 =?us-ascii?Q?Iev7qmewqIKF6/jrluj8G//8CYdpIdlCYiDoqPh3gcn5Ov2nKJIffOzsP+Ct?=
 =?us-ascii?Q?MQBg0agCo+5b8LikT3GiP4ZqmkO7h5bN7+fZRHsqBmeQMDTVl7XhWRijY6Ys?=
 =?us-ascii?Q?8P1PlaVaGK7LzkZmSA4PKH/VQieIacmLY0cT1Odxl23qbb1au9H4f3VtBRis?=
 =?us-ascii?Q?U4NOi77JP3hMPY4g1h/LxL152HJ+hT5MsW6oXzWWq0av1OsnXvLrjodf7kda?=
 =?us-ascii?Q?D+uVaLnJy4uyDT2CnawKTLVMapY18PqkbO01aLzVCiPLNgVqdfsjYDNmYJ/n?=
 =?us-ascii?Q?zkyruJyZBglAsUdD31tgR8AC5eMeDC6KM2NoPb2I4y3bnsyc+yKZI901AOkw?=
 =?us-ascii?Q?X/T4fwYKZmzHAut0W7S+AvSh6GcIrPcbAa55pxS56Gan3c9eX7om6YFOhKdf?=
 =?us-ascii?Q?tsgmN8743ZHwRNM+0XvmjiVILp+vbnRH2XcpVrABasuHaVIgq020sPznNiZ0?=
 =?us-ascii?Q?W1UCJo044d+2Sf1o78agSqrDBpNEi8Pk/x38GLAK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uzeagbo7JnpfOuJBWcpFj4gYnAcqNwRQMJQIPnDKKhqnZqqKPIlKYp66du3C8TORTXsYLza+Yi2TAJcJRjYeaqnsm+nRhuJjS7/0mXI8jQVm1S4uAxfERilxY2xWEcRxICnUiYnPHfLmVjtiGNjQZNE5lNE27le/4HmGMz3gfzCZgTpToQYr+lN//QgCJS/c75GhDdhJxdSbtxRqemnqukNL5bWIxmzc7+NbSSvILWczgflpWGgjcbNb0jmCtBQVnxYbKox2iba88c/yOh+gw2nQFE3iQcY1IT6ggX2sGOQ8FDW1VioqiVlL8hxJjmlVKgVWTum96bVb2A3eCSJulE+MF/guf89wCZRnD5HMBaVkTiSNUvhb3jrsIw3vHvIbkoLvlw5vkkKehTaZPcP7tbrHe4GG0lkItkWI34Qx2RmJO4F2/f2w3Eolroy7bK6aBfyjC8XlI5CwWy/1M/0qLj31bGxO1XSp7myxYL3Y4cvQcPy+Xqh6qlaiELdUBOosjCV4HvIk6AfX9enUEhrDhvXe3nVEuqvwJ//XA7hD6ncOSWj65MoRCTJMFi22Sf/HQWn54NRffGBxFViYZiSFRq9vBHUa0qru5FkfjrwOGAk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2001b289-7a68-4053-d99e-08ddd2eee3a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 00:36:02.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cA+i3fK2VFzKMCQZGxNXoEfvjohjUmusYUq1Vhl2sv13Xngw6V5v7GKaOHJM0LFpBuKiYAIDXFE8ob8kY2CYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_07,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040001
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAwMSBTYWx0ZWRfXy6Vr4cWWmCFw
 0dM5FNW7G0Lq/tXxI1M3UL0bqLMScOx8ry5W44koE/3t7PKimEs8jr1P8bFG0rQTAunDQff6yH9
 BSgZjJJo2TMD6UEObbUqbunnk85rd53VEtcef2Rqm4Y8YvMa39rP5QvKudKkvl4chN3EVCngYfi
 aNpmM3OnwuSgNfNcCBq+QGGrtaJXcgn4E4Sq6T/FX0hiGYiAKi+lVWPhShuO8auifyRJZCzm384
 hhxrjttnTa8X0cuEbm6Q+epvzBEU3U+yeyxkK8Nc22mydD+kYMFlhb6k0vwaY81KfM/4ufOrFQd
 r2iJe3Hii9Qvns1kC8vdKNB4tGr8VQ2k7ttrcmvVrW3IPzkAyJpmGynHd35JP84HnqjtUajyRfi
 ZiMZD8dq44/6kegYzbi7N8i1QOK43T3BmCb7R7hCbCDcYxghYCHC14BoNu+SlmL0sIzHQM6U
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68900076 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SlVAvriTAAAA:8
 a=eG6IOfSBTsqboYkHfMQA:9 a=CjuIK1q_8ugA:10 a=KpMAsf9diV4A:10
 a=ftr0zfsHvHYA:10 a=qesGs21RGGeVIEdTuB6w:22 cc=ntf awl=host:12066
X-Proofpoint-GUID: j1XymlvHWUPmXDefxGbwedjRnrZTSu8y
X-Proofpoint-ORIG-GUID: j1XymlvHWUPmXDefxGbwedjRnrZTSu8y

On Fri, Aug 01, 2025 at 02:10:36PM +0800, Li Qiong wrote:
> For debugging, object_err() prints free pointer of the object.
> However, if object is a invalid pointer, dereferncing `object + s->offset`
> can lead to a crash. Therefore, add check_valid_pointer() for
> the object.

Because this is not only about freelist pointer but also include other
metadata, this can be improved a little bit (+ with a slightly more
detailed description):

mm/slub: avoid accessing metadata when pointer is invalid in object_err()

object_err() reports details of an object for further debugging, such as
the freelist pointer, redzone, etc. However, if the pointer is invalid,
attempting to access object metadata can lead to a crash since it does
not point to a valid object.

In case check_valid_pointer() returns false for the pointer, only print
the pointer value and skip accessing metadata.

> Fixes: 81819f0fc828 ("SLUB core")

The tag looks correct.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
> v2:
> - rephrase the commit message, add comment for object_err().
> v3:
> - check object pointer in object_err().
> v4:
> - restore changes in alloc_consistency_checks().
> ---
>  mm/slub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 31e11ef256f9..17b91e74f7d9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1104,7 +1104,11 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
>  		return;
>  
>  	slab_bug(s, reason);
> -	print_trailer(s, slab, object);
> +	if (!check_valid_pointer(s, slab, object)) {
> +		print_slab_info(slab);
> +		pr_err("invalid object 0x%p\n", object);

I thought you were going to update the message above based on previous
conversation, "Invalid pointer 0x%p\n"?

> +	} else
> +		print_trailer(s, slab, object);

Per the coding style guideline [1], an else clause should also use
braces { } when the corresponding if clause does.

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  
>  	WARN_ON(1);

-- 
Cheers,
Harry / Hyeonggon

