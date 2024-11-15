Return-Path: <stable+bounces-93502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE819CDBD9
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F11D28360E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7AF192B81;
	Fri, 15 Nov 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtOQvLDc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OE2kmotb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FB192B75
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664274; cv=fail; b=GW5VFiDRNA6Pv2gIJKsMrT/AchjFlToL2z1WeXNW2B1Bq3eyF0/Y7vetw3e1PJQfWuW0An5VAaNBbJDR247iTdJRV1sWCb3E2XwzB87ZRfHhAxBuB0s9Z2HJNGzBwRWVuWktcbVg+f0eD0Yn+d442Nr4X5gXMxPjH7N4GgQ/gcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664274; c=relaxed/simple;
	bh=rprNsWuVmaX8/BByKR9RmRi1lUez+wuA4U+imscSQpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P4YDXC0egfe48UHXfF1er/I5w8XzmmgGqb3Ewxu/dYyOg1X+5kovNsSEV6UBMoD1yBeRgrsRRanppqQpP4z8doJRls6tUkidhlkbBq4uLdvrQEE+xN2eqheEujBGb+T5aTpD7s/YgBzs0OLfu/qwc1kqfsDa05mzpeU6UjraA3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AtOQvLDc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OE2kmotb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8tbn7001667;
	Fri, 15 Nov 2024 09:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jYD3UKFonyuci2Pvpj
	OGGCSs/WkRyQoTfhYksGa01Uo=; b=AtOQvLDcvsfrQqTiGlheLlLMgc7rpRSCa5
	Lvsy4uiEGhBGTTbaxEOOJsTtsbAQkKpt1dcY4di/GvMFq57F2fA3SgriAapnOmrL
	ZChM+I+GjUI/venUw5nxVxsZYlA/FypN4MPqkgCRxyM2m9TinwM5sL+vt2t4tXjZ
	W4AwsVswcydCo2pZFUD1yflX145WY0Jpq49sjR7oUNGAbxK8UoQW+aAwIszDAL2I
	2PjCgz79d4RYq5I20VkekGW6Za4NTfPoQS4FCh+EMlPyWosMD6DPxfhKSPJK6bFI
	mmWvJpsgU4yn1ZCcSHCOzh+RxjPT6f5rDVgXcyPcMUme28cfYm+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n532hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:50:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8PQsx000345;
	Fri, 15 Nov 2024 09:50:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbda6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4xOmv1pwHHOon4m9hhvNaRZSvl7jrXCeR+KQeMA+s1DjmXNkW1pcLMUN+GhodiDwlWBFFjZZ/DVnp3jmHZtEX+AxryZWvj3I77/w/DrQCi+FaLNHNtm7C7vCZeN1KKsiLbg7AZyvg/bHCUqA5+hUC3IJoDjh/ZP2FwOZUReX3QdrOA59xSXpzvPgoL0D4vW6Qy9iCbd6kEDwwPYbIoJ+uZY9lYCvShMw5engKzzoT/QtEsAcJ7f3+q+TG3jb7J5wJTiEZg5MGDyr+O40AYPUPUVNh4jNvDr75JWsMElQSXIUk7YHUSn/crh2Yhug4cAWZtUGoP6cDqr8ppU0JfMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYD3UKFonyuci2PvpjOGGCSs/WkRyQoTfhYksGa01Uo=;
 b=vzFgBfNHZKuqCml+SBFMC94c0wAgIwsgToVE8UwEsyZOo8SSoCPrM+GBYtTVonyX9StPDAAUkuewHdxSr7j/4xGZcXMOYWcQwMZsaxvLJjU1Zpn9rf/TkrUP2h+vN2Xc/9qA81+pj04GvZ8N+ximUUEV0ufwdgoNiF5XvvM16jiqTMeFgafTCWvoAqIv8SVieGTD+D7+WH/l+vSo1N9UuoKyYAQ/X9U7USF5K+2bAPORagXrtuz+iU1QEBM4zRIFSLfxD8Tprcw0nBQaGHdpK3cikcf8rFSvxPMuiMW/VXJfO+bM0YJwwBIu+rEShjGVB/8NWEmrHMYoANOXvcwqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYD3UKFonyuci2PvpjOGGCSs/WkRyQoTfhYksGa01Uo=;
 b=OE2kmotbpY70Gp84ECgRDndrQss5DaeFoDXmZYyrmpKutuiZg5QwbfIaGyf6a67iD5rRJnMvamAMF2tXLf7A7XxdJobr9kp/HwLZsA2ZXxhuMx8LbVMR039ssZunpsfUaDWMj2Fq2EUikIn7DFOcFuwLuo0wTlj3wiF88Ky+2gU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 15 Nov
 2024 09:50:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 09:50:43 +0000
Date: Fri, 15 Nov 2024 09:50:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm: refactor arch_calc_vm_flag_bits() and arm64
 MTE handling
Message-ID: <fc0f0003-0e3c-4023-a415-f7a6854b14da@lucifer.local>
References: <2024111138-moving-borough-7e09@gregkh>
 <20241114180741.807213-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114180741.807213-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d76b78-5d49-4464-a1bb-08dd055af897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UzPuI0wLxYoQgbzQ9V5W88nWnO+rPJaJMHkf5CVDExUsNusZfsFnrZiEZTT?=
 =?us-ascii?Q?i4mFa5rZ7R7O7SBnk189oVBUL3nBHVaPDaMaKWXvvAH9X5CM9zf+QFq5rwI0?=
 =?us-ascii?Q?OdS07+3AfNbD1wBhht38JWiB/fFyS9Qai64HnbTd/ze/bLqWwunOXcPDrtZf?=
 =?us-ascii?Q?E2kIfKJCG+SAdDlRVhW85rfsJ6PEbio2J+hzM0/A2SxBVpkl789qmoYknBGg?=
 =?us-ascii?Q?PVSsmLWkignfj39iPv/2i0pQR0oNOvlGezBAuz40QWy/Enl/EQ4TS+1RKQTh?=
 =?us-ascii?Q?dvSiIn1m+PtZVppko4vUeP6Et/q4qS0o83dN21H+9UDFLJSeuNDd7oru5G6s?=
 =?us-ascii?Q?q5lUH/7KTszdBYOGAiUCfLW/GS/Y97RxFu2UE8EU2xTJpfoYyFR9uwxTA0bL?=
 =?us-ascii?Q?5C94TMP8azfFf7gfGGKxzfmV23vU4Lbr2ocscr2BOAH4VJ7zSZ8VRrObcv4H?=
 =?us-ascii?Q?GGN7HV8Fx80C107vTg/DScrwYmQOIoBmv7Yd+Xor1CTU9WtuVA+TUBKnlGtR?=
 =?us-ascii?Q?DBf0E0N/FnPBbbPum2fC4jQJGB8tDgva2LRgVoS9KnvIKbtJGsg8+WHRB/ma?=
 =?us-ascii?Q?+yiBvyPfxdgdcmFH5Tr4jZulcGnuqV+Nlln7pfhZyv5VF/GO+9I1IZvBZqp/?=
 =?us-ascii?Q?YrFqbbMC2/nwqNnIk+0uthVhPq1vEGOU9FqLG98bNkcyMipawe1q+QpDS+HQ?=
 =?us-ascii?Q?q/0eqkKDJZBay2WvhPJPx9NMotJCbWPSEp5hqV4P5D81Mn31SpvEyeIbqSBS?=
 =?us-ascii?Q?r9mTfM76vIWM7qUpOcI2pOmKH9Eer5UG3RRHNaIMmtmS6o3XzUYOLB0y7DD0?=
 =?us-ascii?Q?BUjhGeq93PpKVb5MwCm8BjNQntXZbGGEiPCNeR2xnFCeTsEQ6rJH4PU5jwi7?=
 =?us-ascii?Q?UZH2nMznM9M0Cl+95gIO4iJ8dOY5zBGEHPiTYs9Gl8ZxaURveqxDaVIEn6sf?=
 =?us-ascii?Q?7JwboQsdJuZQkblRFX0NXM11xzpmGD32/pau5ILgNBfYkgrItsl9QkBcjSmE?=
 =?us-ascii?Q?5RmzkfscecYTw4wKZIHqyVzhbkM0HkuRVmYIBrEoMlhNQ6s6iqwoTkgTc3Cb?=
 =?us-ascii?Q?9G8PYxgvYbGH0JaZ55eDh7zSmXxcLk/5T3jwabGhuigtivIYKQXeznEcLj45?=
 =?us-ascii?Q?VJEG+3RlOMORBp8MjziAUgsHZQCE2zByHPeMUf4GXceJH9YLom4viD3aEv9h?=
 =?us-ascii?Q?at6esFlClDUi3RZCpZSEN78I5IjrlXDCbKi0d4Rs4sRLalnqMkEtlk91B9G0?=
 =?us-ascii?Q?lfFJOAB48SvxaFXpTcOVs0gQxSjN6tG72C0FxyrT3SdvHU3IQqP+NuMd51+w?=
 =?us-ascii?Q?i1LIUyRL4RzPmXI7++SHmH/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?My5jTxKpXPTvnTVKSW+zvbO4ICJSbEFqh59UtpL9Odw4G5B3tTftgGp2qVLz?=
 =?us-ascii?Q?2/rGr2O/7n3WfGM+Ba4uGCjyhx3JTOWF4eMm1AibEhuxZhCtw8fxhJk9g2Lm?=
 =?us-ascii?Q?WAfCA1crPtGJAsVsaQcRpBW/9Ia9E9gSvoU2AFJ2eT0bTA1CzyU7HbbzIJxZ?=
 =?us-ascii?Q?3ouBdSE0R2Z2+/q9bYn2YLXEaX9MxFOOEohzn7i1wRXkv5kGy3hKkjiGw04p?=
 =?us-ascii?Q?mPLCdxQLgO1SKjzhbrw/xQ0L1qgQ7kFNL3ayTXxFaI+TLB1L22Lk0zWjU/bk?=
 =?us-ascii?Q?zfXOkE+LdNalxc2GEaKJsUWpSr13FAwIqPnB5dKait4dSETbpXkUqAD0lyTx?=
 =?us-ascii?Q?UcXo4P2WvdamAffhQ3Fj4DfQ4zMJ6YCGZq15cRkZ35cQ8BSWXK4edOSe/NqY?=
 =?us-ascii?Q?lKGqC37mzxt/V7UePfleXhk8fPnGX8fPx6EzTXRMbLbPSNJ1XXaVrZgO5feS?=
 =?us-ascii?Q?7TKRvBBBhbZEYvZYrR+dIBIufmHh7TpZzmrrGgn1Lyd9CVLTf+rNH4UCyGw5?=
 =?us-ascii?Q?3ZWDAV0aHpyoVgoKuTDzSrZOquStHzSQd1K8sLPQ6AjEzzzfvzBBmnR4++m3?=
 =?us-ascii?Q?0Y2AcnRxSiIgvQ7BoSsAl8cBrxK/BTqEJxCHNWJhXizS7MWX/+YExXFtppyo?=
 =?us-ascii?Q?B3VWeung7wGqWH1hePcbvNejL5RK90rgz9xD7Yz2ZC9qtF+VzSdXOHtLAS4G?=
 =?us-ascii?Q?Nvy1jQmJQJZEbVoZvOOuB6uJfG8kyC0fka6XBf38bLd2s3gQeQoZu2EfwoKp?=
 =?us-ascii?Q?ZvMHInY/hnYAkZwPZ5i7AlTQttP1DRhFJbROzQZuOBTKjS6EwvFNKlBYzN6I?=
 =?us-ascii?Q?ylkdmahm7sbxv3pglfHHO2vyIbT2RRE5PFTQe2rKnZjnMj9nmZIBuKRtd4f3?=
 =?us-ascii?Q?KQFgQ6Z1zaxMKLu2GrvK4Dp0ghCZK23KbZNBpLe0WSkCEC1aVP3LZ/99yXIx?=
 =?us-ascii?Q?Y5/hNyoJ7BTRvrBwc1s6zOS+0noAYpsPF0BTGbJyhXbRPypd+RPGicXyjOru?=
 =?us-ascii?Q?8L/KPTSXchU36yyEBEZ4zXbX7IqjvqfQaOB4luwF2W1FB7OgacT9DkHr3SCr?=
 =?us-ascii?Q?MYcwQ8DLgGOpreUIIes6GvvfDfMooWMMNo2NoSoZRQChbobyAobzDWh3xku6?=
 =?us-ascii?Q?qc/YgWwweWisreTGnZSACe5ey9G7QIGy0rYpleajErlOu41/JTblRJh0J7bx?=
 =?us-ascii?Q?sTFZwCNNgPcIMxCEn3a/NYt8roy0noBIJWTmIK26xMQdZPKx9vIjwXTX+awX?=
 =?us-ascii?Q?cv47EJ4WJXvT9y7CWdDPUgWnCjnIEUSgH9iCJW1U79xSofvqIw9JaUxvV/Nh?=
 =?us-ascii?Q?REze+ir0IA5ld1XHptYCJ+yNkmDfl3SvQes7gL9FyW8xoYWYSncLELGOmDfW?=
 =?us-ascii?Q?IjU+Wz1Ar5iI8r5XZSdPONpN+QcPggAmzOYXunboZ3fpAujaziieML6tRqEM?=
 =?us-ascii?Q?3LPOY2fUvMMf+jCNjFu7LBw+eP35bc+1rAIgfTpGmwZXRMG3HbumaWIRlpe1?=
 =?us-ascii?Q?nn6vJaP8xXOotLSu4iAOh9Blst9PjXTEwRXEqd3za6wJ7NuI4v4Mt6K4s/Y+?=
 =?us-ascii?Q?NNvLx91SoUCgaC0GgP/JVPRSVT9Q1l2a829Vz1QI3JKIVpFGxJslD1zJoC6L?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WAMkSYaByw/A0Im3CQPBZ3FOC2kX42JyuQrx4Y5wMUCtJVODWJRMA8rfOKX+s8QSFdB3TeP71RLN4FarpHTk7vArCKd9ELnXHdtWKomn0bO2a2J0vxheSs1FbquJzeBmWKK4KM99E4JaqSrZ+6LFo5uBwOssrNxf9fXCyzHjdb3LQcVxXvcRd2MgvkFtbZnafcNUO9JF8lDnkpoB0u/0qrZpJH9GX/T6Vmxk8HaAPX7/KVj/Rv352fT60tTVx4mFLokh3hBKUlylySy5NsCCO+Y0y/H0gqmZu3dVeNnG4wLp4jO0ggzNf+GoK/h1i6f2nQBA0jsa2OjFbaeXVLjbQI0h0w3GXzKDWPc9t5FTOvSigSyLErV7vQjC9ndBLWUrUSeYv9bNjCZt/sOneAyrzfmwGa0QXkou/97n/tl+zH2UQmXAFdYi61rCUhmhfPEgbBf0j+pw0xxukhl/edM+egjNRA+rxl9qsMNyb+yhKm4mwNzdmHENsqvC3DVHkXGjKUovAOPqhvOQZu67js3nqSavKTqhfefC44cbTJFoWLvTNCgtdaVWcJVxicj+xfbcAcB6un+kYSqJKqn7AK9vm49Vn/xyUxEeCmafq1SfsO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d76b78-5d49-4464-a1bb-08dd055af897
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 09:50:43.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPzi6+LUnq7ve7f+zjjnGzXox3FuMv1wSAECdc9tzX0anPTrNgQcfXf7kOgHtxRb+p7+Cxn6toKUUkZTbc25HJAaZsv2HiPWwA3yXE0OG0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150083
X-Proofpoint-ORIG-GUID: L8uJOnEDOORGCB0FapaFYY38TxCsrwXq
X-Proofpoint-GUID: L8uJOnEDOORGCB0FapaFYY38TxCsrwXq

On Thu, Nov 14, 2024 at 06:07:41PM +0000, Lorenzo Stoakes wrote:
> Currently MTE is permitted in two circumstances (desiring to use MTE
> having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
> specified, as checked by arch_calc_vm_flag_bits() and actualised by
> setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
> shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
> hook is activated in mmap_region().
>
> The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
> set is the arm64 implementation of arch_validate_flags().
>
> Unfortunately, we intend to refactor mmap_region() to perform this check
> earlier, meaning that in the case of a shmem backing we will not have
> invoked shmem_mmap() yet, causing the mapping to fail spuriously.
>
> It is inappropriate to set this architecture-specific flag in general mm
> code anyway, so a sensible resolution of this issue is to instead move the
> check somewhere else.
>
> We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
> the arch_calc_vm_flag_bits() call.
>
> This is an appropriate place to do this as we already check for the
> MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
> the same idea - we permit RAM-backed memory.
>
> This requires a modification to the arch_calc_vm_flag_bits() signature to
> pass in a pointer to the struct file associated with the mapping, however
> this is not too egregious as this is only used by two architectures anyway
> - arm64 and parisc.
>
> So this patch performs this adjustment and removes the unnecessary
> assignment of VM_MTE_ALLOWED in shmem_mmap().

For avoidance of doubt, NACK this and rest of 6.1.y series, I'll resend.

>
> [akpm@linux-foundation.org: fix whitespace, per Catalin]
> Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81)
> ---
>  arch/arm64/include/asm/mman.h | 10 +++++++---
>  include/linux/mman.h          |  7 ++++---
>  mm/mmap.c                     |  2 +-
>  mm/nommu.c                    |  2 +-
>  mm/shmem.c                    |  3 ---
>  5 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..ef35c52aabd6 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -3,6 +3,8 @@
>  #define __ASM_MMAN_H__
>
>  #include <linux/compiler.h>
> +#include <linux/fs.h>
> +#include <linux/shmem_fs.h>
>  #include <linux/types.h>
>  #include <uapi/asm/mman.h>
>
> @@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  }
>  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>
> -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> +						   unsigned long flags)
>  {
>  	/*
>  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
>  	 * backed by tags-capable memory. The vm_flags may be overridden by a
>  	 * filesystem supporting MTE (RAM-based).
>  	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
>  		return VM_MTE_ALLOWED;
>
>  	return 0;
>  }
> -#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
> +#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
>
>  static inline bool arch_validate_prot(unsigned long prot,
>  	unsigned long addr __always_unused)
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 58b3abd457a3..21ea08b919d9 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MMAN_H
>  #define _LINUX_MMAN_H
>
> +#include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/percpu_counter.h>
>
> @@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
>  #endif
>
>  #ifndef arch_calc_vm_flag_bits
> -#define arch_calc_vm_flag_bits(flags) 0
> +#define arch_calc_vm_flag_bits(file, flags) 0
>  #endif
>
>  #ifndef arch_validate_prot
> @@ -147,12 +148,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
>   * Combine the mmap "flags" argument into "vm_flags" used internally.
>   */
>  static inline unsigned long
> -calc_vm_flag_bits(unsigned long flags)
> +calc_vm_flag_bits(struct file *file, unsigned long flags)
>  {
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> -	       arch_calc_vm_flag_bits(flags);
> +	       arch_calc_vm_flag_bits(file, flags);
>  }
>
>  unsigned long vm_commit_limit(void);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4bfec4df51c2..322677f61d30 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1316,7 +1316,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	 * to. we assume access permissions have been handled by the open
>  	 * of the memory object, so we don't do any here.
>  	 */
> -	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
> +	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
>  			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
>
>  	if (flags & MAP_LOCKED)
> diff --git a/mm/nommu.c b/mm/nommu.c
> index e0428fa57526..859ba6bdeb9c 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -903,7 +903,7 @@ static unsigned long determine_vm_flags(struct file *file,
>  {
>  	unsigned long vm_flags;
>
> -	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
> +	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
>  	/* vm_flags |= mm->def_flags; */
>
>  	if (!(capabilities & NOMMU_MAP_DIRECT)) {
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0e1fbc53717d..d1a33f66cc7f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2308,9 +2308,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
>
> -	/* arm64 - allow memory tagging on RAM-based files */
> -	vma->vm_flags |= VM_MTE_ALLOWED;
> -
>  	file_accessed(file);
>  	vma->vm_ops = &shmem_vm_ops;
>  	return 0;
> --
> 2.47.0
>

