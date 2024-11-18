Return-Path: <stable+bounces-93778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFC9D0DEF
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970A71F229F0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17AB194AF4;
	Mon, 18 Nov 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5x+3Qkd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ni2YDv8c"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C5188A0D;
	Mon, 18 Nov 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924658; cv=fail; b=Zqf8BoEPDzTtGDM4BttAzb7QdJ/haKxQZqgjn/ehwt27tmN/n6pjD3R7ETSGtDkALiJP/bMMumT73IF42pAJ6D8pmA7KeQ60X3sLn06bfH1uKf+OyY+hJtPFkNrkqxJPHIiMleKFtY+frZ2EkwybdJlUhb4p3jgJqfbq98Sluj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924658; c=relaxed/simple;
	bh=CAFe6L5zA0+IvcegXpQ/jQtGZFlInDp9633OqE7F5ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YeRe1ERnUVopfrOXAYMUvIZUQsCREjFSyiachEHB71pCDL5w4DjlMdcM3ZUOPAG7uCc6DVLJs1s9dSslBZ6Gp6alUUfGxyyNsn/EhgGW28bQ7TjDb+USoMMqoirMrlZ87ykTMlLL/Jf0BU4ESsh0cwPDF2bgZ2eKOGkjfqevwxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5x+3Qkd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ni2YDv8c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QYQY009457;
	Mon, 18 Nov 2024 10:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pS9Twx2CCUdLF6RF0K
	GtsU3NuEt2VjUBLgSGh0zZDEM=; b=C5x+3Qkd/LETLx5FzELlhJKRnhsHXS1J4E
	Odn9yRz5WJT8cxOuIgvvS/UjNvGXz/UspEY+GBZ1uQyTSvERv8N7WBlKfXLMJk8j
	1qirC//bbpMjWk08VveV5A9od7nXVFt2h/y2vM0DsOOs/o8lZIoGIaEtjznSGp+Q
	71/NTRkzxNNwRdUhttd9BGa4MojWrQ19SEOJhMlC+HeKzba9q/4IM2/jeRJSHvFa
	a4hT5WO995qrjg6+icEk20jrdgRRT9tKm2wRyxiCa7o/aryHuu7aRRxaUv7S4Yda
	z21Dw7QdEztYqGlvVehwkAR222Tpjr4KZy7GC/ZXkOqGAH64JBZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc2c1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:10:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIA08av023380;
	Mon, 18 Nov 2024 10:10:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu78cr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xwq4NFZoEzVWNS3Q4Y2oAIaajOaZgGdQHZTPn/bnofW/nQS6nIexi82VGDHmRPn0cw55JQMgqVlTF3hXN0RQGzIdglXjHE9L+UIYf6qJfGiZa6rqv8teflUWb5YfyDBrdu49+8D9S90+v7LfYerUk3y68ZGbOg2SYdLznLYSbUR91Y3sp2saEiTE2DnVrMp97xSbvVnSDv2uw2Jr3KciT9x/Kg3y7Uz9NiW2G/4qxtNM2E28qaYuspvO1byuwOQ+8ZgVU4ayvVyASUvTHe1+AJKXzblL5eSSMj+f27p++4HaRMKcseT82yRU5w2OC0eMK42p5as5XbNixAJae4Ih1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS9Twx2CCUdLF6RF0KGtsU3NuEt2VjUBLgSGh0zZDEM=;
 b=vj6i7tRbmzfcKLqy1ULapTgg00EQKcwYvTG3lekXMBvjpSi0/WEMjCDoe2QLy+CvveIK7TAykjpVx1ckCHBE9V+KzmvqCxpn/QTDLKZo4caa6RmLadacT1/VYpQUqegSONCpuR5o5j+a36ClXR/Ug+nIwzoM3LXsXJBs1zSQtpr1ud+nFHKISfsjU3nfvRy6KXnD8OXkmeJ7rnlUSWVzizL0If+mSNMp3ZvkZ+aivaAGNj2M3otkTXMRcax57fdRMrXepJgLyrOlEAYthK0WFttyGohwIuanWGzw/J4Mz10yXiffdq2P7YCzhzwCUbv/MnqzELiiH2Clqy/6VEXgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS9Twx2CCUdLF6RF0KGtsU3NuEt2VjUBLgSGh0zZDEM=;
 b=ni2YDv8c/iBDiqdmVVo6rC0E9+rs571FagB9jILKnROZ7trrGAPIQFMluNqntoQ55OMgzKgTwnHBlxDsWsuBhRhM9e3/QwZFiVn5dZnwdXAlDcFrAy3/Kf2hxRKF3w7BXT5SzaTk23M6P0dwExTju39olkomPyxhsnwFue6/ppU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5748.namprd10.prod.outlook.com (2603:10b6:510:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 10:10:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 10:10:27 +0000
Date: Mon, 18 Nov 2024 10:10:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.1.y 4/4] mm: resolve faulty mmap_region() error path
 behaviour
Message-ID: <85b345d4-fafe-4117-b147-c91d6ab24664@lucifer.local>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
 <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
 <2979df31-ce8c-4382-ab01-7e66f852099d@suse.cz>
 <01fbc3f2-bccb-4694-99ec-2ee8e9ff6e4e@lucifer.local>
 <2024111713-syndrome-impolite-d154@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111713-syndrome-impolite-d154@gregkh>
X-ClientProxiedBy: LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::32) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ef6dd3-70f7-4305-68a4-08dd07b93980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?meGW3+UCiIRblSO0LIVAlcPgIVARmaAWcxRCo0IwANuf1os0dHdWRlNkVF6D?=
 =?us-ascii?Q?cLMNCS+STaaO2evyYb6i/bz5iO8IOssbm82eWC6pBPgLjw/WKq/a94y6e/8p?=
 =?us-ascii?Q?d4IM6TlxCV1jAQbfA5cnhj2e646JgXAar4kiH2rksEr58F+cHadNXo8nicmG?=
 =?us-ascii?Q?IspYn8ii24rDUVNxkXkzHWgSPEnYn3lm8bkGTcxts798JX99ht6K8cFWaYy9?=
 =?us-ascii?Q?033tqX+rLHLwipJJaExRXObB8kfw7vzbbd+xqdX05zsAy5jtbjSsugRSZa9Z?=
 =?us-ascii?Q?m7H8D3dowfKTDecXzyP6cFLEVBN5miI34Zw7WE7GGwmphn2C3Z1fGL3QEFO5?=
 =?us-ascii?Q?f74v4MhYeTD38q2iVO+mbX9IxxsUbL02H5oRX4djA1H6rF8VAWok4sO1xEAK?=
 =?us-ascii?Q?19oLB9w15tlRBCv6NeRQjB7sorFN5oMZWEAlFKzp2XhF06l6DAGlH70O+yuE?=
 =?us-ascii?Q?AgrVlEZTgiR7xQam/qbEaNu1w6O6HanHbO9y2FVs+L8wSTDxe+tuQxSoVYd5?=
 =?us-ascii?Q?Op624ETAv6k8NXUKxpY079i81afHQJdHur9GAXehVdahX90MdOZ8Amuw28Zv?=
 =?us-ascii?Q?WkJENeTrK0OLQ57D/yjsRYw5X77GzBOY1bBnmdixnuGwr++OeI6ovCfgDkqu?=
 =?us-ascii?Q?WMXrOUIy+WgfPeXfxDCdJE538verMUDra0rifI5ADRV0fDr+3GgAEycN8flH?=
 =?us-ascii?Q?5D4xR6wG5SEYinc12D1BJP0dZL0Smzn1sSnnejEvE1kgFcID+uaaFiWr0UZT?=
 =?us-ascii?Q?KvjD52ix2jd5j+qCTvAVD6iUWxryCT8TrlDlvHBszbxvU3UjPs0sZQBbui3R?=
 =?us-ascii?Q?1cf8TFF7fbRiR4CM6DRAt03jcn9yr1mcvArzQESJ11j6FGR9oafZ8dBIOwau?=
 =?us-ascii?Q?FzgO1QQCesuiaCIhaBjzB2/T35jmjUGNNCU9xtdcfDgwK2Jr3uvIFRl6Stv7?=
 =?us-ascii?Q?W18bVSOgJk/pWtoDazWlFnlZyhvAKIH4irp2QvXwgNzu/+U1xS6/uXyoHJdp?=
 =?us-ascii?Q?putFYkRjNyQt6zB8IvCDEy7KvdpNiaUoWe2vYNkVzsgBgUwyfiGLlygR5Olb?=
 =?us-ascii?Q?99T7XXD/QMnx5vUSzxCag+xtcxTXvKHIZVPwwNnEHV555b3OfUrUMsytxGCY?=
 =?us-ascii?Q?l6GqRru6gXIYD4qRsKbVHuYRFASjPWu3Wxa/s3Saa/GQgJLvYVXBUrDtC+fu?=
 =?us-ascii?Q?YQeaUTfMQysKlVb1voWLv4xy0AWqO4plJEVW6SHNFWihqghcSdvTUdd7y0DQ?=
 =?us-ascii?Q?nYUGNj7qn/NG0JwsqH3bihLjo2vAFQtv+Z9xGrJFwJvWOSglYog0GsJdZ+/i?=
 =?us-ascii?Q?SVAcwzQZFgbI7EWY6cr5CU3x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+wCeQ0GHZbwOt7wXwPnmaDPpAXKd2DWAH4asOnKT5eeWpkp3yNTtndbBXNx?=
 =?us-ascii?Q?sYE2be4mal1UqSzsjhO9t5Ql6gpK37XiGz6aAr6KPotJ+vpGA9H4sHejZ1QE?=
 =?us-ascii?Q?uEKjdc268ILJSHqdIK4FDzCqSBlwvzlapJQPvB1SW4ObHg+OY0uB4sGtIwpG?=
 =?us-ascii?Q?uNnu3ILHcQPshnqgI1pos9+IYNmpYBgZ+VO1v3qM+b/4BfPDZMhFzCjPGrke?=
 =?us-ascii?Q?Sjl7xKHwWn7B5aMZDMw5fCabF8waOmB5aQfaYS1zlmc6FSkpMQK1eycPZDXA?=
 =?us-ascii?Q?cWvHb07GB7GO2KHLBI+XMz3JvdlSr4xN+fMkmLm7HPxI3pNyAOiDJYOfqceS?=
 =?us-ascii?Q?/J8qEF/Rz8Ll55jx3UeSoAp+LEtKOjdru1mHry0uc7Y0NM4ZfpLNO1ewhkL0?=
 =?us-ascii?Q?NwQ9Yi4TARMPJV1ZO19iXqCwLUsTL2zdECIF+kOSjHeNnQhnw46oakqIMQHx?=
 =?us-ascii?Q?4dVFCedaU+7Fxn3k33zSbHy74yB7qFV3HfPOi9H37meoUtnQwYrf7BOlQ7jr?=
 =?us-ascii?Q?EK89eiNRbBxhChXIsv7JE6sGnLzpoRKbA3dbMt5+McT23yGABd0EkZIUSSWG?=
 =?us-ascii?Q?Tl32ib3GkmmxLGMpCherxsL7Evu9ffq2yFh36y+FXEllNbzXPGoRRZzOi2G2?=
 =?us-ascii?Q?fg//6xMQu9Vsv4LAiqz//maelk7gn/Bvt0dLhaS6xyshSOpiQDQ4cmAu3UW5?=
 =?us-ascii?Q?bqOIe8oqEz6plp1h7r0ye8d//+bjmLgzJLv0fqPo09sZpfnSVfZqKcReNcvc?=
 =?us-ascii?Q?1s5u9lukK2fJg0agFK/+3x5g0dkC/MJSJ1RVFv+hBUDNkNuDKdbggioP/yr+?=
 =?us-ascii?Q?6cF1lwCwADYFaqn/+W6Rzz+32BUsJ/5z66dnul2xqmPYRdPCPISvfneEqvmc?=
 =?us-ascii?Q?QldrQIxGIsthDk4WE1221nUOKsSiIWhI75aH/50M0k2DWnxaqOY5ZcyaP2NA?=
 =?us-ascii?Q?B6NrqHuKmXJ8+IxkjiikYfkBTqSum8A4xTT+QOlbsHc5hveV7bEZbkWRYAea?=
 =?us-ascii?Q?C/TdY00Sgf63lRagJEZDksM0R9X0XzF8pl6LWCytCh08PM6SI7aj0xQPluc9?=
 =?us-ascii?Q?lzXHnJ1PUiZ2+C571Q5fu9+tUmnd3kucY82gdZppLeNEwy5Zmz5kSom9rMpq?=
 =?us-ascii?Q?Nx1mMF3LlnmrXCHpnPfi6dihYvJWAroV58UJRjYVNlCAWnBeXykdeP6M5DpW?=
 =?us-ascii?Q?MxwG1CSQbOLQXZxOxn6NmZKPmHEGuSJ/2uP1VvxUC/rr2o05M6JfVzQoUurA?=
 =?us-ascii?Q?AkmPGwTztin7+Ze4VtUTR9owZmKmixFwY0XgxkizTJ3olhyxMyoXK/Udh+Hy?=
 =?us-ascii?Q?/11bNS27tIPpwfYVU1dKjiNAAMk0k47ZEm6L9ntsypqkLiPrfAFq2iMlf4oh?=
 =?us-ascii?Q?QY940KBgbIt5Yb3UKUsvzT4Tj8s1Fz215IqEV02wuslVzmi0OyvaALOtI9qq?=
 =?us-ascii?Q?3PkGcM38Can9fPAXHA1yYq5qZrr9bwpMOwy6pA2UHoTkAFkG5KJ4rqW7Labg?=
 =?us-ascii?Q?PRPxhqD8y+hoGv/BE8SNRVSOtWgqM9+qvWWHuT5vjLUCGNlvllACt6UdmpNE?=
 =?us-ascii?Q?sLEUbP9IHjXcEHIGU88IjBVquH4aDrylixNHNXPU19IjZsLhcckLenr48Ogy?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AjBzqZVi7aaKd25W44MIUlx8e/LKyvtwjewNEweBRgTWlHNsXhi7HCgJbXLPjGPM0A9k3O06v5XLqxNIb0VugacfeLYhE8OxeqJhXrlKeYBc1K0YTH0mo7loHNcrALVMLZub25fEuHkqG8QeGArvMq8/ZeP2ObyL2BIJPqmokYg0tQCiaariEO6JOEFdh7Vwxng1I3LDJvYxJ9Vi2w/8j62p8LSMuvAPjmZCuXjeZLkylkYnhOkF4i0gftq7MFbo62kPsQeIhCAe2hyFBrhsrxx5duKtrLDYUu4ssZ32UNv/lQuY7ShaR6BtcGZVbILQgp/0+hXFhsBe0/g8xVsr/QQa/eIdEX1o8EzHAFASe1V79Zz6pHrSG4x3zaa96gK9in0SnGN49lQr2LDedv7AY7/6wvn0XLGQTuMbUxWTxud9fuqULlRsm3CTC6zeYPIKN5bQPa0EcvLdx7QLCrxfqmRLOQDZ3TJprljRBZi19dfsA+AQXAp0uL030muXwMaT+Hw7ghasZ4HC28KAy98nBylypxxMOiHfWL218ZmHzYpKy8c0E3j8uJXP+qrjVfCRCpP7/MFTVeN3dFVOyPCfXzXIlBoTTlL3OLIO5C3oJAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ef6dd3-70f7-4305-68a4-08dd07b93980
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:10:27.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHaBOGkgemDLf4D+sJgnUc4dy+LDkzQI8ZxGEYpAtTzl1zZPtgr5TWjMx+PRLn4aBbKdb8GgUaro2L6/Ies9C0YGciHKyuckcjkbGu7rpW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_06,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=551
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180084
X-Proofpoint-GUID: 59mepGqr1mUrbcVh7ZGi4usCVNXkGTRP
X-Proofpoint-ORIG-GUID: 59mepGqr1mUrbcVh7ZGi4usCVNXkGTRP

On Sun, Nov 17, 2024 at 10:11:47PM +0100, Greg KH wrote:
> >
> > I'm not sure how anything works with stable, I mean do we need to respin a
> > v2 just for one line?
>
> How else am I supposed to take a working patch that has actually been
> tested?  I can't hand-edit this...
>
> thanks,
>
> greg k-h

Ack. Every tree is different so I just didn't know. Sorry.

