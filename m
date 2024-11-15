Return-Path: <stable+bounces-93489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016179CDAB4
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860D71F2543B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818818B494;
	Fri, 15 Nov 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I+VOPoS4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kI5lbIHb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F92B9B9
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659918; cv=fail; b=Uxvq26abA0ngg/J3pyoaMLL37O0x8lhp2ucSjtmk6/On0GBirafpdkUNMEIj+te+lHzvnwiOWJFLSXuYEcYmjYZtO+eS1ENKAl03DoFwzvovnR+8H7hCnaR2RCQCLpcvwF6lQgRNs5Am52e69PHZfXlAq2YVMNw5ACtfaCheDWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659918; c=relaxed/simple;
	bh=A0ARH33QwBu1cuK06mqXPfiQhpf1v36XXUbrVv7z5lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlRAFOdsSdUyo7eX4pbz/GLnWoj3VfJpimDk9sAsdRzSgigv6zlFj6Sx/2DjY8wF5ZZDfrOWeOpk6BI/CEc9MrYd8pzBW1JjYp/Y+ZQY2SgJr0bRpa/lDWkP2ySNUp7nPpLgUlx+QcfUN0iqLQdb5Jhh/UYXhH3fk+fMTHif8XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I+VOPoS4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kI5lbIHb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF7dP1h014316;
	Fri, 15 Nov 2024 08:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oHrrD0MPHl8RNx29ng
	nKyPtdx0Cjb7jf+swrWJlbcas=; b=I+VOPoS4uxj4xMWHVvWMhXwA5zQKpZU6QY
	FqpBOep9Ox/OIvfdN+jQ8BdldHsjciEUz5cra+uiWcyDKhH0qlE9vW8xtO0RPhfZ
	DIrmnxI46F/DeyQdLDzsmwI6Ty9s+0qhl4LiXlc4l6DZFCn/Kd/awa+PFphoQAXN
	44T2gbojkVeGrcxg/p510MSkV4l9n2l3MDmthY1wIkV7PB9jw8jORg6clzQyGHCF
	yegm82Oc3qoaO57sYuHOR8eQBp0A9gX1/ZN4mJcFHHihN7JkmzmEpkwdfTlH5Aln
	YDU3aStARwRgs6GXkKgLTHc5I/NLu9raDB+Sx0e2KVDJFSDjZuSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbk1t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 08:38:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF7CHbW022877;
	Fri, 15 Nov 2024 08:38:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2dy62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 08:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frF1dxHwhshlW+rFmTXknX1fajEFBu8JcTUW7VXOWBjH7AXcQfAfK3aYaKPBRzTtigO2vckrA8XclDcdiE8fy5R3wUs50XetJYYBVVS2hG3ePOm2m3JF7cBj/tztfhdDg/IQ8EsXQ5IVAQsc2pOLDqicmI8+opT9+vVXDZrhkN4o5wHX6Wfaw7si0bwGkTg2oTfZ8Yy0Huw9vrxBw714pCUx4phVYrPWmxtTLQc0WctgBvap9U/nWwhXeNf/5g/MG55LJoWO1jfsv0D9RTeHimkwQtigvd0SwTn6MQMU81Wj9SJrnLhJ7RZ1AxN3CDbiffhzqKcZZCT9mVRvcHZs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHrrD0MPHl8RNx29ngnKyPtdx0Cjb7jf+swrWJlbcas=;
 b=yXSbeRDLkYeX36IEvw34uZC0UBzFt0ygZQNk29lCOaFrenU2TXHeA8RT0l+umCzrJsBNaEXDthwqW/fsTEP7CRhX8b4Yx/Q1AKCOddOfbNKe9yMlYokW7Kij8n6yPzxyO2+H6+aqVVp6nadBP/eyYODoBXnEytk7lgaGgDm25PNZe4nsqhPGPd6kTXn9BX+6hRL+/BqcHCOkMeqe9RseLBvH/iQkh8Ju/V4Y7ixvQpzrDa5iwAR8gFjtuWujTznQaau9v/qduRgUUMo5CO/k79Kn41LFloWJcUBqbsqCBvdlM+ClFOkrSQzf4MkKQGpUXo+vTKMfFuzMiDHVyqLnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHrrD0MPHl8RNx29ngnKyPtdx0Cjb7jf+swrWJlbcas=;
 b=kI5lbIHbkt6PuEiD5y+gaRcI0M6rrQA9flQ3O+ORbPoox4OEi74FvJeGfsWif0hkp6nFoy0CcpvS+SYWNlRZBY4PV/3DVBoiVZHADvplO59QfEvudg34kZU2vayhTipquYgCC6zeUQqtg5LEt5yhFTMom+0+jYIFwcXgJkO2dhI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 08:38:03 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 08:38:03 +0000
Date: Fri, 15 Nov 2024 08:38:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.6.y] mm: refactor map_deny_write_exec()
Message-ID: <64dc674a-1152-4107-a382-b1167cdfb202@lucifer.local>
References: <2024111110-dubbed-hydration-c1be@gregkh>
 <20241114183615.849150-1-lorenzo.stoakes@oracle.com>
 <2024111540-vegan-discard-a481@gregkh>
 <bb420574-76ab-430e-838f-18690196b175@lucifer.local>
 <2024111520-freemason-boil-f2de@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111520-freemason-boil-f2de@gregkh>
X-ClientProxiedBy: LO2P265CA0429.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::33) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 8837a309-da6c-4a2f-d889-08dd0550d1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUxg09bq8pbwz6k5cXZastwAodMF61YxvCTqoUjsgHu3hibvUEgwJh+MYBR1?=
 =?us-ascii?Q?JFE6caR3/gVs3jhPPDTT69DrWQhV/b4Df5+04S8SExurPsZ0pbMDeBYFTBuW?=
 =?us-ascii?Q?vbnHflFZEI6lhzHOmaeHBztVo3L+K9UN4l7EQXjuOPSBVNbNXP2xWIzduS2M?=
 =?us-ascii?Q?2TuMrwvbOp/AtyOgbZae/xlJf2VVrn8+7qgRGE2k2oQ6HaYB1imLTjTViJKR?=
 =?us-ascii?Q?vN65L7GX/2ntBuCkfG7u4EudjknBDYyGH03kbbXLX7daU94a9QdFpixekDLl?=
 =?us-ascii?Q?AFCtN+qQDc+N66pZCIHwr7Py186+IRpGuuDNTA9E49271lHBTVBwaaKojrmC?=
 =?us-ascii?Q?C5rkTrGz7eYozDHDlu/flViVWFDYHFkD2t8Wvcv3Hx7RI+Opxm4IYHLPxyQW?=
 =?us-ascii?Q?zNwKwDCvCH3RthDndb3BLQiPqf43f8WZUhre66F5eoOUd+SvyWYbFUW9LL++?=
 =?us-ascii?Q?ZRShtzTDqArUpWK58OjtSRcobE1o5u2uZhGugO4A8/KH2g2+528mhYzMePHh?=
 =?us-ascii?Q?iVfn/JcAEbnGBc6kQ8ecv2a8omCis/2KMWjvrKlaw6X7cnRiG0hArVO+BuEC?=
 =?us-ascii?Q?ntJw4Dz7ufhbxJ7GSEdH8VtjFMXo4zcBRJe+s7Da4AXrNf5xC+qNGjxDDIrc?=
 =?us-ascii?Q?3GJlCjOwZ5U7xQvl+5i4bdTrCpnAe6ga34BX+LJWR/htODtuoZJ2EdlQhQJO?=
 =?us-ascii?Q?Y1oAkYy482NaM2ciYb2S3SzSugVYBWDXYy5TCYjnOyQvqZq2MCm1fY2wLedB?=
 =?us-ascii?Q?dZYA4Ogv68orzK+Jv+5x7RvRwzWpPgyvb6PCA0WowP94iNtV7yOcYD/yCM72?=
 =?us-ascii?Q?lm6izFYdkP6gQmBAooNUnJXJcLdUEg689CjLdfRoUQK1RF0w53rBLxhQcNCI?=
 =?us-ascii?Q?Di/CdkOUUvf3diYIPXpebWFH0fDUfXnA7IdFQiEqFCBa/Etx0WNJH7DDV9l3?=
 =?us-ascii?Q?2piJbkohUgXmzRWY/uZKWhIVaj7CV+zhfYGMJYXIEnT6RxvmC7qyN7JYmHXx?=
 =?us-ascii?Q?tiEVNNnKQh8fTbV5PlizURix070/uGqlNFguUdjDKsMUuSP22e/Jw5fEv8Kf?=
 =?us-ascii?Q?ks+YxFzjONVUjoiU3tkLKosY7vTCdNcmBjluy8wl4XFVA3YOZcHv5cvNj/Sz?=
 =?us-ascii?Q?1IzeARU+tCoT1TcmknY+POOz8gqy+lDxQmk8p9KPx/X+klCCJ97LEfXTgllF?=
 =?us-ascii?Q?H7LpKRNCi4i4veKoywV4Ll22UzNh7DdTFaXCzwQglnc2BxF2R4JHh+2ZLRVk?=
 =?us-ascii?Q?c9i1iBAAzHRuqycOmm/Nb+4nWLfojAykQ/KpT61Q6dxHt9Ai5TSVRRsRA5nT?=
 =?us-ascii?Q?KTpv8Ske6t6DBT9RgIu+qvPF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBnszygZ+usBY/EuOycxPpsmpTRV/bK5KQG0b3561fE0eI3a+OgRuNgqctII?=
 =?us-ascii?Q?x+AKTpgfkfLWqK8XqdXUz14M+Cx8WB7MFk4ju/iAsN8sHVJjj21kKkeMupjR?=
 =?us-ascii?Q?Y+adhLHFc8YB9zZ++j5Kapg+hlLM37oRBC8gYWPmAANZv9QXY7WPoKjcGDBJ?=
 =?us-ascii?Q?9lWOQoQvt9rD08KYMWbZcQIdU6kJvuAYoi5YDS0z6Kox2mPX3sRpM7NqX9xZ?=
 =?us-ascii?Q?73KajqiKXUeW6nnllOEBrsmQYKRuO9gy3EaTAyPE962Q0wy2QiWIGnbSOjqT?=
 =?us-ascii?Q?J6rAn0fPeaAjTBK/uHjhdljKOl6MLQ3GTOQ3FhunjsU83w7c+/esmQJWZHvZ?=
 =?us-ascii?Q?fkOfNnTtstKgnScubD8gxN6Th6pJDfPyIo5uGL3BSh82iw41ZaIpwRLMJOwn?=
 =?us-ascii?Q?Jriag+zBx0VcxqzWXQa4pA9MZ4cbvs2VLgOz4PmC9UNEqLPSDWh9YBao20IB?=
 =?us-ascii?Q?zHbzJKI3Snh54LwvzdJdBLbNGMmnZio2DpglQ1tLk06PFwIzFD4Xv5a5xRxg?=
 =?us-ascii?Q?HpzKCYS8zAUU/iPMNiKyD6eDZ3T91+Y7BoGDGgFhcN5hgejG2Nh3XuQfcQII?=
 =?us-ascii?Q?MyLqzUl7lcsLO4mNX9RFh6fl+c3K/slYFgcmekc4aCu1OVWWhpM4TsYPu2Dy?=
 =?us-ascii?Q?tHCAiNiqkcvo/psI78q2pBnSRYJFiBgmYxmvExkyt6+fmdAPO7phomrQlws2?=
 =?us-ascii?Q?esb3jjwvZT7RoX+uIE927D1OZq/jlOn8i23OnNIfKsCygQMliJRtUByOmvNh?=
 =?us-ascii?Q?O63qLuHVUY0u/eqUeJB6Sye2+gDcdPFfLx7KCqlNZQGwJZNNMFlR7owWIpGq?=
 =?us-ascii?Q?rdSae/52cz8sD7A1Vlg+5KCAn1xdROL1AEKcDE+BeDJk2Yjj2OewRq/pukvU?=
 =?us-ascii?Q?I3CjrMfXIUfvFnqCLyUiYBTCaTn2psbMnBYkni/u7xnntD4CpQAvzRH7wqa7?=
 =?us-ascii?Q?GpM32RSs8be2NTWzXVmUkegFy1PRv7V2XvlXLJWtk9JIsTW/Fi8YYuglG9YK?=
 =?us-ascii?Q?oz0uJqbjOEc5f1Q3LZlmfAoTDNCzBhURllqkbnn/9JdHRyWrMbDCIfiEe7ik?=
 =?us-ascii?Q?AKCNROhQJMGZXwGksUuDOOPW9j0LzsfdGwe7e7hDQvpanDmXhW9H4Jt42B5g?=
 =?us-ascii?Q?F5z0O3P5D0OgzJMfZFFA9/tlk1wMoTnAB8adlITQ6pTYmCSIf9kV5e63Xp0a?=
 =?us-ascii?Q?+3QlsOpQVk+Feu0mypXik8e/USTw7+NH86IOIRMKI4CvvwiU5E+YT+FULe3V?=
 =?us-ascii?Q?ns9MKqbQ8ormYeko12vzb8o0nuBnssmS5yMLS6zTRqsrHT+3Ak9JoLCiW4gy?=
 =?us-ascii?Q?1ENB396/cNsBM4CnVVeEwsCrRb9gNRuVpfUPHP1Kc0oInfS6GrEDDiropUjh?=
 =?us-ascii?Q?tSX0ijX4GkwQR0gZeotBR7tnCU6M/qBi74/jovLpB4wwCuYlhn2IevLYcQ8A?=
 =?us-ascii?Q?b5Xu00hqf2p64TNjxcKmxr9pwQphLo31K7XkHsh8XQbWmfSK1g40r5AOxXvr?=
 =?us-ascii?Q?uFYr+lbwV4rl0PX/wEZhvMu8m2ZTzxY+sNg6PRTVyD19g1fBN6yaeSme1SoL?=
 =?us-ascii?Q?4c4gz7UW9V9Hafc0eibm5QYZ6H7LeYmP8kWl5cTerwcpLXMOBF81fM6pGzYA?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/ys40g1j0kfsV5nl+FJA3iCKdStMzIypFI1lWZYTd3ft9PqW5ait5OTFv4YkqvQ62S+xdB+ZXVX5fnW8EceW++BwGp1lqciOIM30pCG4NVJE5Xt5wl8iGGy/EqpOtb2xbB9vknSFRotaJ/iDdvKp1whugekp8Owl75TlDxU7Vu/R16af1OYNUWBEgDZ6hmbn2pgF/gxgNTMDXVpllqCjUc8O4Jmeioks2JUk8236xlPjr7svknyinD/go3sDnL/v9Rgp2aKLAtmgb5YkzqlHOBa+Ng6Rg51byZD9KJ5gR4cKm287LW+d2owb/eMZvk8s80PC4fP2BPMy2fgaJSInYXrnB19dh7ffRz6IyrcaIqob+qli+gdJI/tCpUoZpYVpdJOyszA/pMqz77bktsG3F4lhJ3MRwHfAUwtnVcRMH8Ex9+zwlcLv61IKsGOfgaNSwqcX20ioS0NKfl1KKakBcXD3m9/l4VahOwV2IhzC1zcdBhkvMMQVuk+og4oXvoLY5DvV+duVs3YkPg7Hd0BOw3xU3Soi1V3Bu3qddLxmXlCHoHuDrvgjX2T3NXCg4O+oRFrwG5RZmXKemJqJryTDU/hh3putlTeVeUm1u0g5Us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8837a309-da6c-4a2f-d889-08dd0550d1a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:38:03.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2P4gN1H2AgM4diAUInSgE0WqrPO7796S0UJ934aObieIEafKijHh/CG4xoQIXdk6daT1WY/iVCfZYq2FbvpexPropyr8swJ386WrQDkq60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150073
X-Proofpoint-GUID: aja4E3YjODihVh2eEV6MiKMaoI8cofOq
X-Proofpoint-ORIG-GUID: aja4E3YjODihVh2eEV6MiKMaoI8cofOq

On Fri, Nov 15, 2024 at 09:27:22AM +0100, Greg KH wrote:
> On Fri, Nov 15, 2024 at 07:52:26AM +0000, Lorenzo Stoakes wrote:
> > On Fri, Nov 15, 2024 at 05:02:29AM +0100, Greg KH wrote:
> > > On Thu, Nov 14, 2024 at 06:36:15PM +0000, Lorenzo Stoakes wrote:
> > > > Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> > > > parameter but rather to accept VMA flags parameters, which allows us to use
> > > > this function early in mmap_region() in a subsequent commit.
> > > >
> > > > While we're here, we refactor the function to be more readable and add some
> > > > additional documentation.
> > > >
> > > > Reported-by: Jann Horn <jannh@google.com>
> > > > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > > > Cc: stable <stable@kernel.org>
> > > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > Reviewed-by: Jann Horn <jannh@google.com>
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  include/linux/mman.h | 21 ++++++++++++++++++---
> > > >  mm/mmap.c            |  2 +-
> > > >  mm/mprotect.c        |  2 +-
> > > >  3 files changed, 20 insertions(+), 5 deletions(-)
> > >
> > > There's no clue here as to what the upstream git id is :(
> >
> > It's in-reply-to a mail that literally contains the upstream git id,
> > following the instructions you explicitly gave.
>
> The instructions explicitly give you commands that say to use 'git
> cherry-pick -x' which adds the commit id :)

Right yes, missed that, these had to be hand fixed up which is part of it.

>
> > > Also, you sent lots of patches for each branch, but not as a series, so
> > > we have no idea what order these go in :(
> >
> > I did wonder how you'd sort out ordering, but again, I was following your
> > explicit instructions.
> >
> > >
> > > Can you resend all of these, with the upstream git id in it, and as a
> > > patch series, so we know to apply them correctly?
> >
> > I'll do this, but... I do have to say, Greg, each of these patches are in
> > reply to a mail stating something like, for instance this one:
> >
> > 	The patch below does not apply to the 6.6-stable tree.
> > 	If someone wants it applied there, or to any other stable or longterm
> > 	tree, then please email the backport, including the original git commit
> > 	id to <stable@vger.kernel.org>.
> >
> > (I note the above hand waves mention of including original git commit, but
> > it's unwise to then immediately list explicit commands none of which
> > mention this...)
> >
> > 	To reproduce the conflict and resubmit, you may use the following commands:
> >
> > 	git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > 	git checkout FETCH_HEAD
> > 	git cherry-pick -x 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf
>
> See, -x, I think you forgot that :)
>
> Anyway, this normally works just fine, as whole series of commits that
> fail are odd and rare.  I can guess at ordering, like I do when I take
> them from Linus's tree (going by original commit dates), but for when
> you resend a bunch of them, it's much tricker as the original "FAILED"
> message doesn't show that order.

My point stands about rewording this, because I mean - I did what you asked
(modulo mistakenly not getting the cherry-picked-by thing) - and it seems you
are still unable to apply these.

I would add something about 'if there are a series to be applied, see <link to
stable process option 3> or whatever it will be.

Because presumably, even if I had got the upstream commit ID bit right, you'd
still have had no clue on ordering right? And we'd be in the same position.

>
> thanks,
>
> greg k-h

