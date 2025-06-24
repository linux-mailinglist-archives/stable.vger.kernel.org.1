Return-Path: <stable+bounces-158417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FDAE682F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B429189732A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AA2D4B4F;
	Tue, 24 Jun 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="siG7NKzT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cDDbjwev"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F002D3A7D
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774464; cv=fail; b=uKTEJSKKFSdw8EaKIdZZSZh8o6AVi6ItHLw8pHYR2sduxgWpYMHLxdtFazj1uhZru4dq5rS1ziZjdHLP3/tq21bRjKVsKdWe1dsM48MnGE9N2/TANrbUH8MGEUITQLI1DFxPk6EcuGL0VbD1rvah41AWAXM3yO+2ehOc/nRtSLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774464; c=relaxed/simple;
	bh=KBv0EDnZWyNezL+fNgQtvU+Zsb6ZLPGWasgOnzzkDQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0rqE/pJc8hZOeKs18NKEUNwd0zgez1ZMpaNmSVSwKg7pX706x/8jtd5JAsxuJdJkEBn3y6TqrKkiA7k4a6cs18SyKuQFKpEx/vN4ZxHK6NtRdieyEx0iyR6OI9ARZWtCjDgOfjEuSXVIHyQpMCx1QSbMqLmPJVZfcEYY7GaRos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=siG7NKzT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cDDbjwev; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCiWZW026209;
	Tue, 24 Jun 2025 14:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Nsy5CVBjVB86C4Fddi
	6mTx4Zow23CFoFewS+dGfg57Q=; b=siG7NKzT1ItANWdlp+k1emR6I5lOrLlpHz
	qVn/WBWfuzaYaxjreLtoj5dbr/TP0m/QgVdA9M863EKG+7GIo1J6O4i9lm56wkuX
	OGnlXwzNRxkk5PtYjMfB1hwUhsBXJ/ChPiSaG4rifypIghd19kP8C0wlJrYoLUU7
	IlFStS5gJeZ3mq5xepQxu5u2UF0eAfD1BeKsJHlNmUH8j2A2n+4RVoOSe9d4clF3
	2bdEA/6eU039ql3iz1p3Y9wQam2dcKlnHnDoJWfT2x2XlTA8w5jz7Mnehrx27eAd
	fVgklHDRvt7PorCcjamrNQ4XKy0HGVETICoSEhYIO3RdHHKvQtYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uw8rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 14:14:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCb9Gd039365;
	Tue, 24 Jun 2025 14:14:04 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr4pjwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 14:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKtO084I3twWnu9sq9JPLFVysJk/pg0HSPM2O4XQkz4ztv4AFCv60Mp/GvSTA6NdwKtWwi+8kgP/Kw/XNjvLek3KFcRE9MtSZg7T++Ig1sPAfCWyv7wLGLAUyxhLpEjR7TSK16hw4Vbj103szLNciTtkZ8iXO4SGXEq8NkGtQ2dCHpO/yeS51HJEb8KbcXbwTSzww+w7t+v89wanzi3Ht3Pod+dmYtKqpoz3hQZE+wWTFtGKiPh1ZQF2QnkCMzW6tmH8aG9gT97638dNo70NC/wma/zBqOxdrOUZ3gXi4qAZjvelgt1g95pfKKWrptChOo4BE+9AsarnhxFqzuo0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsy5CVBjVB86C4Fddi6mTx4Zow23CFoFewS+dGfg57Q=;
 b=uXr1N2etMTZEapiZrIyIhMdyfTNICmLpBmmcMsCTwH0eZN4s8NepiHksZKLJUkcKjFvcjl6cIeO56P9r7G0Acu34xeI/Y1lfO/axJt8vZFMFvd28djYR9iNpD+G7/rXXO+0+Yjop6OUag/ibSphEgj7yLa42SwTnnxo7X8Y42CwE6GtyxGgZprvSMRfuX1ithRVRU4bh5FtoK+5gtwRh4+M8IP+aS2Ug7zaqiJCR2IKr9dWpA/SUiclkEBZJ/2rCZmaBcNzoFEF2o6HGALIrNMNMZF5HFOjRPUFVTWXpGXrNkIjWWiW2Its9a5aK4IuPmuXQMR7jrAJ5/T1rY0PfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsy5CVBjVB86C4Fddi6mTx4Zow23CFoFewS+dGfg57Q=;
 b=cDDbjwevlrw21zTGVkv0PHscSQ8BmSpUAeUCReM6jIEzWbCkbJGAKbFUc6rHcbK0vLD7Ktrp2RryMIz3anx6YtIMt3d6KgsNe1NwVd3c5NkQVwPyMwTK4bF4CIrT4W3yl4f3jbZ+8MbkMu1dY7F9xs2r4j9mXMBLk67FzAEp68A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB6764.namprd10.prod.outlook.com (2603:10b6:610:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 14:14:02 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 14:14:01 +0000
Date: Tue, 24 Jun 2025 23:13:49 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev,
        oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org,
        oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()
Message-ID: <aFqynd6CyJiq8NNF@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
 <aFqtCoz1t359Kjp1@hyeyoo>
 <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
X-ClientProxiedBy: SE2P216CA0039.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bcfccc-689e-4979-a206-08ddb3295e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vzmul+bUYSbHOOPOYqiJBHu7XxW4k9YTgGrrZA4GMaGhSZkw5m5DdX3bHT7P?=
 =?us-ascii?Q?Z0hlfHjRaCKmTn9BvZHXXAVXnfFUNXQDs6YugL4v1z0ykPWf/dXJJUE1kPyn?=
 =?us-ascii?Q?i/9BdOTQWD51Fw6hOadz5kTw3XGlvE+V16QSMIVfGhRXZdhVA5ETilr6GYqj?=
 =?us-ascii?Q?NCzT0nI30C3R0P8Nk7UqUcoKMGi/KNuY13Yd4wetVsxwYS/Nu8pt9n260gZE?=
 =?us-ascii?Q?rQXaq4fQ/2tzlkVvFomglCfQNuy1W/t0J6q5Cy6nTL8Q0QD/Dfjxh7C9L8/k?=
 =?us-ascii?Q?PkUkNQYpZ1Ns2lYRXnyO+TAGXVdOBRzDS12cLepGH+fXuKo9yK0Amaa6Blqf?=
 =?us-ascii?Q?xwZNG/xtqW47Lz16vv0qDnd2ywU9yKzXIdVedw13b30rWhYrZVbFyqTNGgBs?=
 =?us-ascii?Q?JIGpjkxp3Yzqn/EQt9UrJMWrBYPOY+r5UecYz7E1YXjgBYtZbwKpdSPrUWok?=
 =?us-ascii?Q?bXgD6RaXSWdCBxRlaq9ZlZwrS4qrrrBNB/vI9DHcW9pkciAIoWcgKqNOsrdd?=
 =?us-ascii?Q?tcWAbZFzDxzyFGAeTDDFqBjFCI02WyXTvpoH4Uo19cjlwQStCXm0sZ9sn2zk?=
 =?us-ascii?Q?eWoHyLvl5Dn6xgVNGjRfdRoagXJbh/x444KjISfWenx3pmoDjGkejrKFXafH?=
 =?us-ascii?Q?4fEdJAEbtvOLTNYx7Cn+eQjPcgegJOkbaDf1klwkiIHsvJfpQIMq8Eo/B/NH?=
 =?us-ascii?Q?vDOvfMS8XiyYF23FFm2gakQEZpKBJdYffjV2iqt+BZUojNN6lutOG/30U6Uc?=
 =?us-ascii?Q?c2AMKeJqFXj8LtUGhoMM+Ox3nxInIgttTvZvJv4bZj8LuyJRer1XBcF+WFem?=
 =?us-ascii?Q?FGF7wGa7wd1IXi+UnIbXROsefYg02KmeMYy7yTiOOLLYfHUcUnGz7EU0iaCY?=
 =?us-ascii?Q?EFOzkBzOsX86iXnzFilmpVs5hQ6k076cqUYc9eWNrGKamYz/uYOCB13KzQLD?=
 =?us-ascii?Q?FN4HBcuv6HG6ZhrQhVgmo/MBmY5buJSEGJLfwHYwUfAZX2BpjuYsLc/xW/on?=
 =?us-ascii?Q?E41K4/yte2r0L3UJCwFb/kiIgTkDKYfWatJa/+tXRrCQlyboJV8qBv7gzEDi?=
 =?us-ascii?Q?2VFxj4XWJF4HXnyLMHQ02ohs/TsbYBzdzV4jYXWMOfSCj+JnGZnU+UwsO/Tf?=
 =?us-ascii?Q?yocSBdtZYbaFgiXamTgS2NNZ2bgyn1WzAdD0ax5FdHQXEWDbG4hGFrAJZD/Y?=
 =?us-ascii?Q?8a4hKZ94VWgbRuoskt5fArJKcG/oKhhLjwm0m+9U4yvHMOvQlDABqqexXA9P?=
 =?us-ascii?Q?j0Hi8S8Pikm0ORwWk29b2HTzAJwA0ufg0+xf8+8UzNkRLGzzuiVhawGBBatU?=
 =?us-ascii?Q?AVupypC2twHx71YWHW5gmQ6SurlQvo7xnUlyo6BS/ABYOk8Ft/nmcx7dhwkx?=
 =?us-ascii?Q?1wRO1FHq25anmZQBtXE9xvRo2GdzupT7OMzUdNE41iNuz2JjtCG94+n1I5JZ?=
 =?us-ascii?Q?8ltumSLpt1Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4dC0w1qqntHPJygg0hSjArtEIYPp3C//p7wa+Jlel8wVuMnjLrrwjgyVZ4I?=
 =?us-ascii?Q?JivU2FZohX9OGiQGU8bFymx731u+3CdsQH1xKVwRHfsDiCPBFO0IMTR7dvKG?=
 =?us-ascii?Q?cNiiIV5AEivuDUXknwLqdLXlktTw3kEASYAh7WvAiwFSmjMZtOVp+ipN2GnZ?=
 =?us-ascii?Q?zzn/n3YqkoMzovu4R5IrY6EKQroM2+4WuKEIrisyu9/N2bymhF4cy5TLhRF/?=
 =?us-ascii?Q?v8vzYytT4VxfErj4+fn8vDUQ4/29L9fWCy6dddXZWE5fT4l4wClMsFLJSO3w?=
 =?us-ascii?Q?q+4iQdbXjchw2+tngokZqb/DwhK6wBv+MdBNzR1J28+PM5I4/9ghndyIvUbI?=
 =?us-ascii?Q?w4Z7DFAPidsKa+lWkCKLKNEtopR8y51TyHa0REsAJeO9AmX6JgTrichTZLEz?=
 =?us-ascii?Q?gSCJmOk/GZOqu7xQI8pX1HFu+rgjoW4Hg99HH9OL88CGO5ZwJWoaL55IENFT?=
 =?us-ascii?Q?VzzKNSQw9GcwQ2hvp1sFCd4Skk/JX15QTyzchg8Bzp67f8jFRxSB1dkKpKMc?=
 =?us-ascii?Q?ivCefVRQ0DmlfAJqMDJ/bl6+mH9oDXIgUJlFp/cpOfn9LjxvBR0QyzWwdkpP?=
 =?us-ascii?Q?Wt/Ew7YvKvfyPsZDn3GANeumRGjJnB5KT0oYgwUsBtsm4fU3GUjiWkCuFi9G?=
 =?us-ascii?Q?+/sEUyTGefHjw8VM0axfSxJC1JPYPFc8iQCr/24UgufwMPXpcyQ6eTncZG2c?=
 =?us-ascii?Q?Wbxfksi0DdDcbjoHUQS+OWXReKKb8PiJskVyJNfxCtEZ/Z+vvurCYt8l3klZ?=
 =?us-ascii?Q?ATXu8+Hn2dHM1p96L9S6KWN9S9cw6IsQQT5ToI3NxOtGEYgZuMx6FEyW94/d?=
 =?us-ascii?Q?74fIiLc1kiZ38IEv3bVfRYiScO9RCyiTad/pVJ0btX5LCU7Iv0PMvYLpqsIl?=
 =?us-ascii?Q?hi6i8TdlGvrhtXdIZcaJjHhTIkwwAwSISLjEpualyc2HxNAX/seHGa3wBV0L?=
 =?us-ascii?Q?ECx1oMHODZl86Rs2lNJor3+p5qRT9b98wE37xFzNE7bumHDaKZN7TrDsvM6g?=
 =?us-ascii?Q?BnvXg5EHfVeGBaErG2VFifP3Xa1b6qBcLCehXl+Vp6089Dzf1UfsuVeqf7P/?=
 =?us-ascii?Q?sGIwd/3YmM9jS48VlYAA82FslcsbKZlLtBJHIT17oOv++NIBJj13If82cyXR?=
 =?us-ascii?Q?Z64vu0Rv4KoZbDo6K3lCq09xTjtv/zkU4Ja3LLhCzJS/kBlSH6C35sVaTpvF?=
 =?us-ascii?Q?kx8/s4W9M7hlq0NKGSWHREOky1KFOm1i9VRChdn2niX9RH89dTFQ3eunxEnZ?=
 =?us-ascii?Q?XRI/3fnb+57niS+GnDEp8cuC0KcFFaX5EhwyQ4r2gEFQRiD2dqwEWel0Yvgb?=
 =?us-ascii?Q?Mn8HZagWEn/OajaXfY9QCNtOJ+tGZAZtv/rvG5iQnLIGnp5p3k9xjwMkKgGr?=
 =?us-ascii?Q?IE4Zf7/dhyXPQCwmdVjG7SivBNQNcw0huzXupAFPqY84XfT6FlYJisIIR1Ki?=
 =?us-ascii?Q?jCQVUyqq51jQulLkziByedfc5AASWiXXFCxY0Y/G6UPoub0pGYBarwSB+Ifg?=
 =?us-ascii?Q?3w1eCY+BYNFzweLALuILPmHwmVURT60BjvRaV5NkJairqTxarwBtxlXKiUUU?=
 =?us-ascii?Q?nFTkTp9uCfBAj4xq7islQQGmdtG24cUrkl4OxJKY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QPDEOKmkr6GBhdru8mRGsBKKMYaFyzLS1xSx+a5XVLGD+m8UM4rrKmCAEIWVK9gxEsyM2FgfnRQ3gWcLC+MOPsP+LEQJZtd37hITy3WztcDxev+D44VX2OgyPeuP1aAy4RVZ7EfKQt6IgdggBzE8AlrcWkV0Lw+HONJypASfWh3wcmnhAwW8C0T4sCPkmuUTYV5dNFllI4dzV0DesNDxQqMId/Whdp0iwB5bQ4aObU+JW63wQCDZBP7+22vIRxhlshKn2rBiz9jMGthmGnLHUf5INLQh8IN7N3mkZsQyKtVmK9NY78gTpTGgzf9MYrlqTjjJgrGsCmElrbeXAEem2nYcDkAYqxnKEOzJNqWY1i2izhaRT8M1lgKfJqBB2md0seF0z3sa6qcTBoS8xQyYZxK3vTlKI4tCY7Q1XquFu0doL23LwyGuFFpjvHviOtqkQD8UHNbq0xH/wYQB06eRbhoFB5s01MBklKyMFb8C83pqOAGYkNK3Rq2auykRfU8U0e9uT1HXhHhq5erBJPeizGFqxqt+AV7LJATJPadQAv9MbiKNcq5xcn6HmDpdaiMYIgKfgjveF1jBIf80sAK1ItXY2lX2D+6aTzVnMO4W/Bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bcfccc-689e-4979-a206-08ddb3295e6b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:01.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWGq9Aws0dXt/bKgwmQv4XvBLrZHkc677GDnZ2Bww/6bFXfGI+SIw0pRKB3uWhV8/N7hP0nn4bCey1DzCbrJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240119
X-Proofpoint-GUID: To_Ews9B8_CA7drXhVHD6AOAAt0GkuhF
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685ab2ae b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=dg95Eq_0Dd7rm5TFEh4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: To_Ews9B8_CA7drXhVHD6AOAAt0GkuhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExOSBTYWx0ZWRfX4oYqFHMyxhJ+ IvYce8y7WWqbnCv39FrpeTZYbTq5K+OYH/RuVaOVRrXhnZUfQTLujtMpNA6s1LUEHuJ457xm6ro SFiMZ7E+BmDIumOy15aKgUwbVnvUBBRQrUUGJKQq1bFyWOnapmmGkA/KMcQDCUd9Kk+K6pp2Yy+
 hiXwBIFpCT6rl3Y6n6PWGZhlgJzv/5GCAxm+Ev/JTkL7nCbb7BC5g/OynKSOxqPY5eVTTyXDI/M D1Kbzmurf3hdTzi7Z3Sb4YoBw25at1KV69H49v1UB35ciwgDhujnAz6OuA5jizsI0s13RzKNmLQ Il0r7cegjTgedsBBKLYeO1baqcC7QCYPj4suH+3NOKfKbzxRD/kGOrZd5EXGahvMNa5CfKALu+8
 UHn7m3tWCGIIjuphZDxFFJUTB34M4h0ti16bukOZJbGjeeAUa++XUFvPDRWCYfzMh+LXy3Lj

On Tue, Jun 24, 2025 at 10:00:48PM +0800, David Wang wrote:
> 
> At 2025-06-24 21:50:02, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> >> 
> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >> >even when the alloc_tag_cttype is not allocated because:
> >> >
> >> >  1) alloc tagging is disabled because mem profiling is disabled
> >> >     (!alloc_tag_cttype)
> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> >> >  3) alloc tagging is enabled, but failed initialization
> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >> >
> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >> >
> >> >This leads to a crash on memory allocation failure by attempting to
> >> >acquire a non-existent semaphore:
> >> >
> >> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> >> >  Tainted: [D]=DIE
> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> >> >  Call Trace:
> >> >   <TASK>
> >> >   codetag_trylock_module_list+0xd/0x20
> >> >   alloc_tag_top_users+0x369/0x4b0
> >> >   __show_mem+0x1cd/0x6e0
> >> >   warn_alloc+0x2b1/0x390
> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >> >   alloc_pages_mpol+0x135/0x3e0
> >> >   alloc_slab_page+0x82/0xe0
> >> >   new_slab+0x212/0x240
> >> >   ___slab_alloc+0x82a/0xe00
> >> >   </TASK>
> >> >
> >> >As David Wang points out, this issue became easier to trigger after commit
> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> >> >
> >> >Before the commit, the issue occurred only when it failed to allocate
> >> >and initialize alloc_tag_cttype or if a memory allocation fails before
> >> >alloc_tag_init() is called. After the commit, it can be easily triggered
> >> >when memory profiling is compiled but disabled at boot.
> >> >
> >> >To properly determine whether alloc_tag_init() has been called and
> >> >its data structures initialized, verify that alloc_tag_cttype is a valid
> >> >pointer before acquiring the semaphore. If the variable is NULL or an error
> >> >value, it has not been properly initialized. In such a case, just skip
> >> >and do not attempt to acquire the semaphore.
> >> >
> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$ 
> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$ 
> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> >> >Cc: stable@vger.kernel.org
> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >> >---
> >> >
> >> >@Suren: I did not add another pr_warn() because every error path in
> >> >alloc_tag_init() already has pr_err().
> >> >
> >> >v2 -> v3:
> >> >- Added another Closes: tag (David)
> >> >- Moved the condition into a standalone if block for better readability
> >> >  (Suren)
> >> >- Typo fix (Suren)
> >> >
> >> > lib/alloc_tag.c | 3 +++
> >> > 1 file changed, 3 insertions(+)
> >> >
> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> >index 41ccfb035b7b..e9b33848700a 100644
> >> >--- a/lib/alloc_tag.c
> >> >+++ b/lib/alloc_tag.c
> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> >> > 	struct codetag_bytes n;
> >> > 	unsigned int i, nr = 0;
> >> > 
> >> >+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >> >+		return 0;
> >> 
> >> What about mem_profiling_support set to 0 after alloc_tag_init, in this case:
> >> alloc_tag_cttype != NULL && mem_profiling_support==0
> >> 
> >> I kind of think alloc_tag_top_users should return 0 in this case....and  both mem_profiling_support and alloc_tag_cttype should be checked....
> >
> >After commit 780138b12381, alloc_tag_cttype is not allocated if
> >!mem_profiling_support. (And that's  why this bug showed up)
> 
> There is a sysctl(/proc/sys/vm/mem_profiling) which can override mem_profiling_support and set it to 0, after alloc_tag_init with mem_profiling_support=1

Ok. Maybe it shouldn't report memory allocation information that is
collected before mem profiling was disabled. (I'm not sure why it disabling
at runtime is allowed, though)

That's a good thing to have, but I think that's a behavioral change in
mem profiling, irrelevant to this bug and not a -stable thing.

Maybe as a follow-up patch?

> >> >+
> >> > 	if (can_sleep)
> >> > 		codetag_lock_module_list(alloc_tag_cttype, true);
> >> > 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
> >> >-- 
> >> >2.43.0
> >
> >-- 
> >Cheers,
> >Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon

