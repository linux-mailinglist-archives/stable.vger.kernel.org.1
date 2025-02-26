Return-Path: <stable+bounces-119750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD631A46C47
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09B8188D21A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1511256C95;
	Wed, 26 Feb 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AwPJmEic";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GZMqfXJR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE66256C77;
	Wed, 26 Feb 2025 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601437; cv=fail; b=PSWHUnJsJralsm6OHPTeDPsGlzQ6AXbDvMtOKFMqDj05BgE5VKIytp1J/NKBMCry0RS9RZJZ2z6PcqXqZsKqg1AlxnNi9Na1yjUJxScpMOhlkLq0mmYY06sKnShbKhUuIfiWF433GTEH1tjarScFK5vJB0zcYOI93o8cjRBo9dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601437; c=relaxed/simple;
	bh=iVlpCBzruQnEMepfAwxBL4pTTHoOCH4vYQAkgC56anI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HqiCDgxgpLylQJsOeZa5PvPKoNUNKOCmIWftJN2Rcc+4z3VSiG41ppTdhlBe3frTxYIS7VNXVFNO8F/E5ovSp8nFRkBmnZcx1G3aXKqs7C/MaihfffrSwB3L76Jeptcw5GEr8Hhw9OFxOT4mnWrC3bekWzg1ur+SlJLxL8jWI/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AwPJmEic; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GZMqfXJR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKMcp2005171;
	Wed, 26 Feb 2025 20:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TaHrcyS5WcKp8ZVvuy
	Ncd1jbIf2sCLn5pnMaxnxE5Qg=; b=AwPJmEicJY/EDzJ7/sE8YQBsj77syKcnR5
	NUd+n0LItcmt4JBsp6iaPDQ7XnWRpgYS2yHbO3X0XTkOG5BjGXARFrLz9ZjO4PSf
	LX7BCsPmJRiazajtvd9YHpUjViQ6yYXfrJHDM4We7T+YT1/WxwD2n3Aytmp8+7Jk
	JUBAWmh4SuH5IlXSjRuYJ58ZwIRBrtXaWQQPKf7PmcaFtLX6/n389/L+QSWJS0h7
	PaaRcd0mzwMf1P6bSjbeqMIcp9UGecVwUCsHrfWw0IxC2b+ioCXNnZt/47eomMGY
	zMHuHgsWu+pPrRU3gT0D2wmdthx77M9B3yBVxvglpDnRjJ/W7upg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psca4jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 20:23:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKMPob012630;
	Wed, 26 Feb 2025 20:23:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cep01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 20:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF5g6CzKAJu9php2qidq+HcGYS3+Ccf7OMaRWeTpWpAcDEhz0d6Arm2+h+Gq8k0lMLt2GnnHa5n0MkS+D+5C9CCXpBK+J+QKztKiPO2+FaWmNYoZTaWafb/JR3DPxDzKAajpf6iepU2qLgDQ0ydvvclH9Dbz9dFv25t2tZfkGlQ9s+jO0RHaOoew10gH16JL4ngN1fdwalMXLdOaAA+aruCwhprp9JSLyRKkzkp+x0qI6MgGAqpZKthBUI9J6MbRt94/mFRGZK+G67SfDXJd1HvAUUqAdcpOWdj/lijOoUfTbyAPkcGAwQKZIRIVURSnUHmVQpYyDmmkGUcWA39QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaHrcyS5WcKp8ZVvuyNcd1jbIf2sCLn5pnMaxnxE5Qg=;
 b=me1N7I5ampY9LrhniiKV+q2s4oSVpTfVcaZYYh5AIC8GKkuFMR3QqkD0Rh8AD2eEGR+iBS1UMgHESj5y2z583HGaiuLuP0y5fszc3Lckuqgu4Ng2oi+OQ7ybx9WLLJfkkLvmyD0uPMkQYLT1EMYTv9teV1ZBmQNqpefoXMBlOvwBf5Ra8M7zp1imqGKXri3dBkOQTRs6oJR2P7AM/M32bky+PWkxPZr2ALTDcQxhP+FHiMcdL7xBuplhH1eNpwAQK2nhmKRvCS7W5VkSt17JLLa3W8Kj5bhB8jOHgYoItfhydBEtYWrrHDaxm8WVrd/BL2Vyb1/TP59GQv/6ujVrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaHrcyS5WcKp8ZVvuyNcd1jbIf2sCLn5pnMaxnxE5Qg=;
 b=GZMqfXJR/uZpZC7aDsVOb13M+d7EUuphY4OPHSGg1oPjOCq4anE4DPXAsYXW5bc5dtxpRmvwqPsrqTyO73QaQb6VDsMJdIBrz9iZZRGrcqVTL9/gr5sH/9onjhvTLw1ImYoWIZ3YPoIFNSQ7LqKWzegz56CnT6b5RlNlx4q84xQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN6PR10MB7423.namprd10.prod.outlook.com (2603:10b6:208:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 20:23:35 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 20:23:35 +0000
Date: Wed, 26 Feb 2025 15:23:17 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com,
        21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com,
        peterx@redhat.com, willy@infradead.org, lorenzo.stoakes@oracle.com,
        hughd@google.com, jannh@google.com, kaleshsingh@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] userfaultfd: do not block on locking a large folio
 with raised refcount
Message-ID: <ow7clyrac62xam6u2saasghgfky44yso7uldq2qqilapnp5ojv@rlx2cra3zk7r>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lokeshgidra@google.com, 
	aarcange@redhat.com, 21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com, 
	peterx@redhat.com, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250226185510.2732648-1-surenb@google.com>
 <20250226185510.2732648-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226185510.2732648-2-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::31) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN6PR10MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: e420fc5c-5a1f-42e8-5edf-08dd56a3720f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zE8Ygt8ny79YmoPLPfTMQfOqpTKXEh+3EcmPBk5pK7EnTCeUUHqpH6N6CBDG?=
 =?us-ascii?Q?4yBDpSDblaTMcDlJlHocuZkoatMkG7HSjEYlonzkxJq7iNpHM+RmYUbXUAJk?=
 =?us-ascii?Q?bV3jH9CfuuZGKF+KUu4KJeuV884dCfDrnlc2DvftAV2sQsYcxR3OUpKb421N?=
 =?us-ascii?Q?HS+bmHS+QF1ZhgZ+TOyEG7jLAtJOjmVvH08R9MNhgE5w1hWTkcrfSOwkOu8U?=
 =?us-ascii?Q?kbeOvsMRdxAkB5s897dETvXZ80hyvoZZujQ1hXIIvGm/kuwusBas0Dk0DW3J?=
 =?us-ascii?Q?xuzimf1SXzD/fHamEZ9oR3+lkYCKccMejePHh3I02p2fV+YFN82NJDA1vyhu?=
 =?us-ascii?Q?9pfmfD0LcuoeLXZkWDVuOGa6fFsKdncXMQk4Ye/18DX3ZwrKvNm81zZ78vW2?=
 =?us-ascii?Q?GHIbXv++OdH9inRH1rhyWH+G3L17BpQN3xR2NULAvDLa9C9IcthOVA7Oe1uO?=
 =?us-ascii?Q?31C+OHqyghvoZfh1K76woIX6+uoTn3p7kbDsE7ihiExTtepELKy5XqZvoRa4?=
 =?us-ascii?Q?MxRioXnS9QleFx0vabSiLYMEUOgJzi0eqV7SGfbOe3fn9BMSIvlbcqfKu28x?=
 =?us-ascii?Q?SO6206CJAvOEO7ieQQIz67Fdhrt72MzwDDA0BwV69HyF4bp31WKDrzVpfQa7?=
 =?us-ascii?Q?d95RH5MDuRz5ct8tq/bT7oxwyfwBf8ffXczBmuMiOXGrAz4TwbSsPZcmvPln?=
 =?us-ascii?Q?HvC8swzvEFg3ju8JaEwbw4LIZaK860cRFlxRv0erXyBKCmSnxceT986Pxqv7?=
 =?us-ascii?Q?+daOphGhsGRfq3dUIejx98V4JwC/Q9hjTiZqDx0Qhu34o8k5hVI7NxuHXSB5?=
 =?us-ascii?Q?Z1a2ac41r3qIdoObO3GXYhx4lSJiBhWT6b1yu22oLdnydsuvt38mzm79pPec?=
 =?us-ascii?Q?+g558MuFmX5gPuQ6EYcNrtxEiAm+S4GaCXmfQixO+MjOBU/iYDjeN9wuzDNn?=
 =?us-ascii?Q?HB9XqFH2slpbt8h37IKuNklq/u9Wg1+7SuNDTEaRQNCODdPxJ180WXddT9S+?=
 =?us-ascii?Q?SnoDRVGejvmiWH2c83TpA8HOUVi7j0ibBuaOX5l1Ybm73HfKvtru8exezq4B?=
 =?us-ascii?Q?waZBntIJ+FGqUIT3jbPXgElSEQAk1iBbTnVIh54FR0ootl2oJ+wDo38t97B4?=
 =?us-ascii?Q?+bhSCXHkKdSaT8RTHEmMwjYtkASCQ0Zt5nwN9MFk8Z78To333B6gH8LjOYxT?=
 =?us-ascii?Q?8T8Le9JLwl7BZI8Bsugx7CkLpiL3R6LtGfBz/xnO5uLdghkJlsQAxfHGBEfN?=
 =?us-ascii?Q?Hqgxo30m4P7hobS//l8LDjJSJxXkeW2OV1Jel3oCwxBOzJrWivraYHst4hqy?=
 =?us-ascii?Q?41pabGVynfrJQmazzP72piD374MK3cnVzvQxOdFZg+Uu3RhqQDWrgj30RJqj?=
 =?us-ascii?Q?LTjDwblyEQVhq6ki7JatjSjIUL7Un1IPLmMwdY0v2aKz8ITYeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siye0YY/lAh4xO/Rns38DiJQ/BxEevniSGP9OdAvVz7s3vdH6QK7f4FQLr1Q?=
 =?us-ascii?Q?kb+oSZmviuOcNnUffLKaC0q8bu8Kk/7UIzvjVgDWBu5ieSf0TZaRuehNWQNF?=
 =?us-ascii?Q?P31p0bdxou9kp6ak8fHI2Y+Q3+PdlQOi8MKJJzWUKIhXTBHWLgNROqfKXznt?=
 =?us-ascii?Q?NkmOeWsBlQWe69qHVDa9/mXdHjHSmfUcoYG6FC3CLRcfoWrN7OU7LtTgjk5T?=
 =?us-ascii?Q?31wqh/4HG4tG4RBMItW08fCXKWp8wCG7x1xW5Gukn3U4Q6HFayDFvyUj+wng?=
 =?us-ascii?Q?TfPeX/2IQvXkkKVoA/M1PnuoaHn5iUYwSyT9ufgILIZaXMGbOhQc7Ytk3aVs?=
 =?us-ascii?Q?EMlfj5k4iOkLXB1tQ/5WxRx2bdtcIgvRw2T20yeZSxmiRnBEQkI/20DuF+Uf?=
 =?us-ascii?Q?5TI5XshCwaG1HnnPruuhrpRLLY4KDompJZto0hT+urNLXcLfgRv//zCtg6hP?=
 =?us-ascii?Q?17W/qC8wQgDEUnbsDwCxK7rznNdADIiG8WZowuRTcTzU0fiHBaYV7UDkJNqB?=
 =?us-ascii?Q?tOK4ATsqNkEJ/FfX930Tcsvl43B3q4IsK/yUXXJV7T9pmpe98beQrtCaiPQI?=
 =?us-ascii?Q?E2wLIgSYisfoePAR8+XFr90uz+U1GC6iBJEHqyLmkDZbtSklhOkwpU5gtChC?=
 =?us-ascii?Q?9KFJpKsXAsGwOT96XVtxMFTHKifIHAiiZyUUskKgthBJ+l/7tMarr3LqvWkS?=
 =?us-ascii?Q?mkYQzPSGQF+24Tn57cxuUDOmyuFW4EgGyxjXwsakVA89pNvIbkIrsPxhq0gS?=
 =?us-ascii?Q?qOJY6tOHebZlEoBaDWr1Kyw/2qzEWq8fppk2bb041lJZtR7luzmrP60rvFJr?=
 =?us-ascii?Q?00N9eplpyTP82RrxKUd2xZAbai0hoILYEfLo8+URs0MM4wc6tjY9wCyypWeY?=
 =?us-ascii?Q?Icm7tNX/FfS3oW8KnehV72aVyd/7Y8s7WJuU/I8Uihy3186jqUI4aEVAspN9?=
 =?us-ascii?Q?MwKBuJioz0+GVAHSN6CZw6sXeopqkDY+77BtgXhGHPK7X1/K+T3+8DjSZ0sF?=
 =?us-ascii?Q?A0gEKQ8WB9K4GwatnR8GDM5uwYDFMbf7A+uAgftO6AUh6sXmpBkl8rWA9Tgy?=
 =?us-ascii?Q?BRaGqj6Dn+wgiYypQczPyT/FhurbSKWgc4WEi3KKJ0URxdI3FlkELujN45cw?=
 =?us-ascii?Q?LHwGvp8MsoJkJSUYNENEq5CIrtyA90M1Isyb4cIp3oUrbdGUToJo3hssNTAL?=
 =?us-ascii?Q?GX2O6rQ2PeTGNdf8SAY4HJP3vqiMqiUz1n+mV8+XxT+cRG+AutpiugtyYr8p?=
 =?us-ascii?Q?/V+rYZv6YtwRCybRpf7pPNb461ZDLXOay0S6h8ZZ3v3pCjnm4GrSGoeUaPEj?=
 =?us-ascii?Q?n7pD5aT7cmvod21afdNs2l8dq+8gp5z707B1CRgUKVb91K9+S0z0m/+9I3vv?=
 =?us-ascii?Q?xQZiYKXB3Mry01QKISaaZ/jf9sjER6y3QHvzA4ULXdjB6t76kb0F2kWAE4O0?=
 =?us-ascii?Q?XLc1+xzgRbZoa/E7lkCTUZ+r7VT/KjluV2nC5Kpvyw8QRC5gKURztENm87L4?=
 =?us-ascii?Q?emuporn5ExrB0WmsIDKhpPHYKfxybFeDi87EuWKe8GWn6tVYhngyGbCOUKSm?=
 =?us-ascii?Q?q1KrCccTylgfUUpV+n2NK0et4m9PpLb7ans/DxL6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gpfn5ifWgvHTi6hL3g2647x1NT83QChkWvp+MI48DksT39ZWWJgfExZgT8PsFUoBBVlPKaAK3MJn7/TilW6CFFSLpToSc9hdxWXpQB7bAkDHIpytEHqS2Yk6tiMyQmHLhq3tvr++CnXazCQTFeWerOdHip/0ELZ1aRUKr++nYhjJRFP3RAUjZiPrEj1SelMGpjQlGhHDCUFmVNdXvqyCHk2K1YehJF2W/RIQt11jejkwApO8MTPoNfjEgmnkqrEazka1p6qKEOR/a4hwIfElsqBUb8xTk4W91PbSl0V0d0XNRPfx+wDIDOM/0tjoDluikcgmYX8qTmVFyvzGZRUCW2jKb9s1iWP+nSZ3S8fuQPcBRHJA6fTfi1aCf0Tw4KiOuIHQEPnjfV4A3QikDnYIl0kMhfojf4YhVhXLCLVGlCZux28FqaNbt7LpTcjASzGrLei7HSy2tXAwMdcSIRr1lgRGNdWk5BK089qNcct+MaQruEqnsWI2gaZgPUnhkny49PgHW3JiyAMxEAA2mHvAh/lYKOnXjb/sx54KWLUa+//3gVPKwpAYR9gBUj72J38EVGoulgAAJg1bDMEyY6oYCe35oonybFkcXC1Ar5oo2fc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e420fc5c-5a1f-42e8-5edf-08dd56a3720f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:23:35.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEQQs7uX5ezOBcsi8AI0wZdp4MJuvbaD8gJU6uqo5umnrxVDX0mcJAHXa0+4lDkEmiMZQzgkaL1g4ttYafKWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260160
X-Proofpoint-GUID: JvFBIObZTQUAc6_7hDys6Bb3JX1Vd3P8
X-Proofpoint-ORIG-GUID: JvFBIObZTQUAc6_7hDys6Bb3JX1Vd3P8

* Suren Baghdasaryan <surenb@google.com> [250226 13:55]:
> Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
> state when it goes into split_folio() with raised folio refcount.
> split_folio() expects the reference count to be exactly
> mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
> EAGAIN otherwise. If multiple processes are trying to move the same
> large folio, they raise the refcount (all tasks succeed in that) then
> one of them succeeds in locking the folio, while others will block in
> folio_lock() while keeping the refcount raised. The winner of this
> race will proceed with calling split_folio() and will fail returning
> EAGAIN to the caller and unlocking the folio. The next competing process
> will get the folio locked and will go through the same flow. In the
> meantime the original winner will be retried and will block in
> folio_lock(), getting into the queue of waiting processes only to repeat
> the same path. All this results in a livelock.
> An easy fix would be to avoid waiting for the folio lock while holding
> folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> acquired before raising the folio refcount. Since we lock and take a
> refcount of the folio while holding the PTE lock, changing the order of
> these operations should not break anything.
> Modify move_pages_pte() to try locking the folio first and if that fails
> and the folio is large then return EAGAIN without touching the folio
> refcount. If the folio is single-page then split_folio() is not called,
> so we don't have this issue.
> Lokesh has a reproducer [1] and I verified that this change fixes the
> issue.
> 
> [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: stable@vger.kernel.org

Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Note this patch is v2 of [2] but I did not bump up the version because now
> it's part of the patchset which is at its v1. Hopefully that's not too
> confusing.
> 
> Changes since v1 [2]:
> - Rebased over mm-hotfixes-unstable to avoid merge conflicts with [3]
> - Added Reviewed-by, per Peter Xu
> - Added a note about PTL lock in the changelog, per Liam R. Howlett
> - CC'ed stable
> 
> [2] https://lore.kernel.org/all/20250225204613.2316092-1-surenb@google.com/
> [3] https://lore.kernel.org/all/20250226003234.0B98FC4CEDD@smtp.kernel.org/
> 
>  mm/userfaultfd.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8eae4ea3cafd..e0f1e38ac5d8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1250,6 +1250,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  		 */
>  		if (!src_folio) {
>  			struct folio *folio;
> +			bool locked;
>  
>  			/*
>  			 * Pin the page while holding the lock to be sure the
> @@ -1269,12 +1270,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  				goto out;
>  			}
>  
> +			locked = folio_trylock(folio);
> +			/*
> +			 * We avoid waiting for folio lock with a raised refcount
> +			 * for large folios because extra refcounts will result in
> +			 * split_folio() failing later and retrying. If multiple
> +			 * tasks are trying to move a large folio we can end
> +			 * livelocking.
> +			 */
> +			if (!locked && folio_test_large(folio)) {
> +				spin_unlock(src_ptl);
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +
>  			folio_get(folio);
>  			src_folio = folio;
>  			src_folio_pte = orig_src_pte;
>  			spin_unlock(src_ptl);
>  
> -			if (!folio_trylock(src_folio)) {
> +			if (!locked) {
>  				pte_unmap(&orig_src_pte);
>  				pte_unmap(&orig_dst_pte);
>  				src_pte = dst_pte = NULL;
> -- 
> 2.48.1.658.g4767266eb4-goog
> 

