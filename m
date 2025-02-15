Return-Path: <stable+bounces-116501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF3A36F9F
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C80188E1F4
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13841953AD;
	Sat, 15 Feb 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9/rgmGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IaVp7qr/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1FB672;
	Sat, 15 Feb 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638928; cv=fail; b=Ojk9FrcnOoQYTHOVpXZD3iX7r3dbLcg5DUpGxSav5Tg9fDtL7IN9O7fBY8kXZJDIwZP0rCe6IjBYPvkewCrIiRXHWNWEvmiu78W0B2VGeuH9hDrt+d24DnLO+ovfduJGHKg0vFnKPSCwgutMZmoXcyl8kijSt7VURpA+UOU1zi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638928; c=relaxed/simple;
	bh=w0q/TU/n76pyRN/XNgcG4cPH/BDjC4PI8iRyAhLlaG0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=caDCv9jG4nd5rKGhOL8wB/qMSqv7H4376Cwmf3gf5lrvWg0Ckzinxq13srSjw+Ve+gvp2SG666ELrsEg0HPrznnFYESwZnJohcUcR9lsCgO98+5vX5nCDanHnVK6B7fc5cBDtEbPP/1hXXLhDYFb0vEJjoRN8vcym3TeF49e3Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9/rgmGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IaVp7qr/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51FAnfTR015113;
	Sat, 15 Feb 2025 17:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=w0q/TU/n76pyRN/XNgcG4cPH/BDjC4PI8iRyAhLlaG0=; b=
	m9/rgmGQxS2OBNvq32wN+7cVKo8yq2s44y/wcdgmrOdI01IlUspZPMlWiR/vYM3b
	y/WpcOFIJQntrU5dqWY7vgW1TA6nR+wgjrgzmhmb/otfdk6ttj6x2wRtZjmuVsL7
	1SXqCV2WLSfJMA3+dtPeAcRc0TIC96YPKID6f9PhWYeXwC3gjqaiF/Kul+E3ZLrJ
	5o+p+B0hiBeh7rNTX9HkAm1g456NIHaJCRgi25pag7IffeX9RXZumBOIWUvNR28o
	tTIH+bb5aIn0Iy7wMb8hLauSYYZ5K1W1Al9IWNDnSWvf+gC2z1TC6RSs/9/vYv1I
	S7PpH+rvShyXkkmt4z5bQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft0h9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 17:01:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51FG0Nj8036718;
	Sat, 15 Feb 2025 17:01:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc6dvkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 17:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUlFXkdS9ZQCJ6Q8NPk6f5HIP4EPT5dnAu+oNFr6yEWOF4H2kRJIT6r1QXKvoI21ZSc0Ol8rBdGvqZZAO+z+Vh7olC+rARpE8ntpEYXcugqzxd8DH9Ub5WRRx9FGh9Ak3CvZ+OuX4oiZDAz9G+a0C3TxH/RmeGcndtagYau4xTFOdPeQ58G1G4oJqeOzkcimYxefMGQ6deRzpVCZqpmXFQeQm8dvNaUbvmNrLa1cbK0XVfiuvbOa3nqLyMCW3it5Ag50js9jS7S5RreozyRRi5M9yuG/O2bFZFBLaqkJmBa1456jItvBuqT9VeK9Um7aRH3VZGsdJ3xhCnC0a0WFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0q/TU/n76pyRN/XNgcG4cPH/BDjC4PI8iRyAhLlaG0=;
 b=qCGmGISPDQNmLhRsjVQBBqFWfnlVemk/6wf20K9KW6l/QNRWF9TPT4953G75pQWoviCbH9il/itg/7+R7UVjCdptom75DO2R+HaiNg4ILFo6KMM5nwgp/4+xhwqkbnbZeKfptb8wb+r+XbJVX6z8VuovfKIcgMn39qlBU/YBtAJjW3Aheqf0JKzw1EFYBlZnr9cU4Z4nmegrC3+gtoYKquG3VoT1z6+itVJF2JHWJln5R8scVeb+aSNRkDSsRhvyaAIlLPYXNkaFXHj4/+KPNmeDwWJsnCrKO/kUMzVc9j4w3ylegVcYMvn+UAeqqCaPxiZ74M/aDMjMVOYROXTk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0q/TU/n76pyRN/XNgcG4cPH/BDjC4PI8iRyAhLlaG0=;
 b=IaVp7qr/ka+PcjI56wxrQAwqeW1SJjRcMgMXkn87XADh6qux5bqB4tf3JaaiQp3n/F5GiDDM13fohjhjXBiQNPU7cRH3Cilqv498uypW8dHdJpyCnKY2g2hILdm41DAHexGJKoQO3mCAHaIyIPgdFrVuJ6XAYknRi8qkiiim+bs=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by SN7PR10MB6449.namprd10.prod.outlook.com (2603:10b6:806:2a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Sat, 15 Feb
 2025 17:01:12 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8445.013; Sat, 15 Feb 2025
 17:01:12 +0000
Message-ID: <dc9e7d6c-e7f8-452c-94ec-c4b3c07e0aa5@oracle.com>
Date: Sat, 15 Feb 2025 22:31:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin
 <sashal@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Radoslav_Bod=C3=B3?= <radoslav.bodo@igalileo.cz>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
 <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
 <2025021548-amiss-duffel-9dcf@gregkh>
 <74e74dde-0703-4709-96b8-e1615d40f19c@suse.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <74e74dde-0703-4709-96b8-e1615d40f19c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|SN7PR10MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df45a6f-8c4e-417a-4905-08dd4de259e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGQ3aGFKdERJS3A3SHN0Smxja29wb0F4b3A5UnRCL0Q0YnpGQWp2cDE3VWZw?=
 =?utf-8?B?ekFIaENjK0l3dms0aldMSXZQMFUyaG9ucnoxVzQ0VDlUL0RXTGdRelBFcmdQ?=
 =?utf-8?B?SXAyLzQ4ZjBkazVZYklQY3A1cDdadHd3ZndXOTgrTEdjQ2crd1ZLM2UvSm9Y?=
 =?utf-8?B?ZGlXYVlYV0pSbXdtem1YY0orRmRuQ205L1RGUm1KcWY0YitPejJRMElZZVIr?=
 =?utf-8?B?NFFPTGJoT2VZS1BiL0cwSTIzL3BIMEpKWklyMm9oaDF2Q1NyaHYrU0lpOWJI?=
 =?utf-8?B?TDM2N3UxaXgySHdSR0YrYXpGdmk2aGJNRlhKNjFrY3dZWTVJMVRMYmN6Sy9V?=
 =?utf-8?B?NnloOEtJL21TNW5QS2IzemZmQTVYaXFFU2RYOUxzMHlvRS9VS2VPQVN4aVVH?=
 =?utf-8?B?QzRySktPc1ozcEE5MDFOTmdNS2hsOVozVHJtbnkza0lrWlF4dFNVTzVSMzB3?=
 =?utf-8?B?bmcrbnByUXlJbnFLUUdwMmx2eEUzNmZpVkY5WnpkbmpuL0c2UXlSNjBTTldM?=
 =?utf-8?B?NDVEbFBpTU5MTG02c1JjS1N6cUVpYityRGlyOUNIMkVrUzNaMzd4K21RMDIw?=
 =?utf-8?B?cFJYS3F1anB2UU5DbzhubUJXR2M1Ry9JZSs5MGhtaE0ydWhtWU9YKy9BeVkv?=
 =?utf-8?B?NUw3WWN6VElEWXdQSXl2ckkyRzhQQnV0UTBGWUQrZnl4M3QzYkJ1cXFLNk4z?=
 =?utf-8?B?VnUwZDFJbUtNeFRkbUZDQk92UHBIWmwvTUFqMFlJVG1zOWRXMHNOek9LdEtQ?=
 =?utf-8?B?Nnd4aDJEdktzVEdnaXNzNThQN2JGQVpBeXJQZWZvcUlDandwSVh3a0J3aFNX?=
 =?utf-8?B?K3VGSzRvd3NXMFl3bnJvNmNFL1RPZzFyS0p3OXZXYklEaTRKdmNxNXpxYnY5?=
 =?utf-8?B?ZnpKL1hTcjMzY2IyYmFVRHRPcnI4eHd5MURETVR0cTF0aU9Sd20yZmQwbVBI?=
 =?utf-8?B?SDlET2ppQitjMXNZWFlrU0dka1Yva2Ira1kzd3ZGaEh2WnVYNlEvLzg0eXNm?=
 =?utf-8?B?ZlZ5cC9GZjZDU21JeEI3L2JDWFQyWDZrNWVNbGVXWkNxY3R2dC9vNXU3STd5?=
 =?utf-8?B?WnZQR1FKY3MzNnI2Tmc5TUFadXVSalpMMHJJWCtQOTVqdHBmY21KVEQyaG5v?=
 =?utf-8?B?VXNVcWJNTkVpM3djVU1meTR4SThnOXhiY3JRdHRRNVpsK3pXNk1RdmU5V2xM?=
 =?utf-8?B?Q3JyOVNGelNJRCtqYkFNSzlyYjREUUxOcVlIejNxRHEwbXdGNnZQTzRiTWls?=
 =?utf-8?B?a2pYSkVKbnhMZnc2U1RUb2RTMWhKbHYzWEYwU2NEa2NwSGN5WXNhNWZINzFy?=
 =?utf-8?B?cDBQbVJ5NXBMbXlLNkdkK3luNUFqQlJOenNvQ2ptV1cxN3psWkx3WE1ka3V2?=
 =?utf-8?B?YStpN2h2QXRNcU90YTNFMUNETWQwY1ZtT2ZnaDdCSHNGYkkzbFA1dklrTytF?=
 =?utf-8?B?YUhHenB3QVdNNkFLNGFSWmc3T3BUMUlvVk16M2p2OFpuekJPamtRL2VkSGVa?=
 =?utf-8?B?VnBUbGtRTUVmWDhXNVNYZS9lRThsTU5RbzV3RFhCZ1AvOVMzR3lzSld6WmQw?=
 =?utf-8?B?Nyt4ZkdaZEg5enNUUzZiam5BWnJZaldScGRCZXhZMGd2SW9DclMraHd3U0pG?=
 =?utf-8?B?M3J4Z2daT3BHaUFlbm9Xb2t1VVVaMFBhL1hNMFd4NGFsazJMMWtSeG9hV0g1?=
 =?utf-8?B?UlFHRmk4b0lRbmcycmVOa0ZOWnJIZktYczA0OEUrZHhvZFpqVzM0OUN5TFhE?=
 =?utf-8?B?ZndKV09YUkNPU1BwT21rMDU1KzdQYmtuZ0JVTW4wV2wyRFNRUlNXRFhOZ2hU?=
 =?utf-8?B?T0dlL1NaQ0hUUE9TY21tQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjgvYTZYdnhJcmFmV3NiSzF2WnYyZDRRUy9pdG8yS2V6UEs5UTdyUXRDV21a?=
 =?utf-8?B?ejVJQXJkeGhxd0x1eUZmcGZrVFZlTkdiRFpxaElZUVpFa2RHNllnUzUyZDR5?=
 =?utf-8?B?SXBDaURhSHVXUmZlcTB3d0hBTDhhQStBS3phSnJlbTQ3eTNyeUNIWkhGTUo1?=
 =?utf-8?B?cy9mQ25pL29oaElrcFZabGlPaGNucWFFdVU4c0p4T2V0M285TTBVS0hMdTVS?=
 =?utf-8?B?cGdidUNQN1hDNExSU1JVWWcxT1FFTEUvK2tTcTBYeFNIZWxiKzhtMVdybmhy?=
 =?utf-8?B?U3crWEwwNDVUMGo5M1hoOHVqZzJCa2Q4bkk2cmZ6WHdzNXF4aURTRFVzTEpr?=
 =?utf-8?B?YjNOcldNZWxHM3lrQ3VYNThxZEJtbzhMcDh3OXk4WWFDT0grb3RUQTdjZUhz?=
 =?utf-8?B?Q3lFdmpRclJBNmY1U1FuYjNWVDFldTE2LzU0eHNWY0xwVElUbTlPRThxSWRl?=
 =?utf-8?B?WkJSN2szRGRPdWNRV2Z3TnRBdkdWcFE5QnNzMWg1N1Q2Q0tmYXVTWVdZbWRL?=
 =?utf-8?B?OUxCNnVLc05mRWRHWVQwcGJheXk3TnZXR2hRMFB2MEU3NjB5bGtuQWJud1NN?=
 =?utf-8?B?VE1YM3RnMkRlNWxKSmZWNHNLY3ZlTDZIVlF2WkxLMTZPRzk0UzVRdnZSa3dh?=
 =?utf-8?B?Ris1TTUwUFNtYW5VWEx3Rm9kQ1lOdHBEZjJOTkRhdVJYZW13djN1Wkh6UkRy?=
 =?utf-8?B?aTV5aGFjRG5iR2dTamt2Y0dzeVNjN3pyYXRGL3RZTS9QNkl4L05veTM5QkUy?=
 =?utf-8?B?NmpURVpjdzZsOElINkRlVWRKM2xmQldySDB2b01kTlphNUs1cGFkTDd6REhL?=
 =?utf-8?B?SXM3TTgwTHhtUENYbkhBc1R2cU1DaGJHeS84MDRwRko0NENHVHpDcWRCbkI0?=
 =?utf-8?B?aWNQOVZMRk53aU1yVjNQczdKVDQwNlRNNjZhTHNsN2F2VzFrS1NSbHB3RG8x?=
 =?utf-8?B?eDFtWFZORHYxSkl0WmZ1UW9sMTFMcllyaThGeFRBc3R1Q0VqaXlzOEhmZzl0?=
 =?utf-8?B?RDBhN3BoNDdhMjY5MVJVSlF1NWFvNWhFRHpPeW1Obk05d1ZYaHJRU2JZYXJr?=
 =?utf-8?B?S1dkeUxJQVZhcktLbm1Jb1lQTHk4b2dudFg4cFdyUUI3bTV5UnFVYmNwUm1J?=
 =?utf-8?B?RCtWSnQ4WUdoS2VWeURHYlBzQlZmMk5uMmp3QnJBd0t4U3FqUDIzelZ5dS9S?=
 =?utf-8?B?NEhkNlBzdVdHYmlHWTd6ODhNTmk2K3dVaGdwbmF4R2tVUXhvTmd1cXJhQXhC?=
 =?utf-8?B?RU5aVUM5aFFEL1A1YUpPaEJ4aytqKzF0a2JieG9RT1VqWXRJUjQ4OFk3TFVG?=
 =?utf-8?B?M1hmQUVRUDBBN3hSeHRDNG5tVjQ4c2VoZ2t1ZTVJYVhydDdKSit5dWVRZSt1?=
 =?utf-8?B?TUxhcFNkbDdvQ0ZNUHUzbTZ2N2VEWk5pMVJxejhjUFN3ZzVzZlVxNVBwZmRk?=
 =?utf-8?B?YitMS1JuRHlvSFd5NkNqTlgvNVh3WW0yTEJ5cWwrL0prb3ZNNnMrU3dBaW14?=
 =?utf-8?B?eEdRbVFFeXEzQ01RTVZvQVVaQU56WUswNWgyNEs4SUF6VU00MmtDMEVhQy9m?=
 =?utf-8?B?M3cvV09TblRsSG96c0FlSFplMEdXKzUzV21Na1EwZVI5L2txS0Vtd1BIZmJ6?=
 =?utf-8?B?eVMrYjVNQUZHOFlSV3JGNk5vdlpvM0ZXb3RRZlREUnd3UHBNY1h5SXd4MUh3?=
 =?utf-8?B?V0RvbGNXM0JiWnFjWmhNZWl1akdxRFdGMWJpQmllQjhvQUxRV3VERGphZTRS?=
 =?utf-8?B?MlJoVDlQVjh3RkFiNEtFTmROcThXVGxpZUNjaU9jSElqUXVoM01kZHZpV0pC?=
 =?utf-8?B?bVlvYnU0WktQTmJWTzZqMGpMNmFBN1dqMC9Td3l1b2NXZkcvM2tZZW85dWtD?=
 =?utf-8?B?MzBEUFlqck5YanFrSkhXalkreVhHc3UwclJlbXB6QTZOblN5a0ZjVkt3em03?=
 =?utf-8?B?MmVPYlhTQy9BazRsM3JwT1lCam41N1Jac09jZE50Rk4rMVFYSEgwa29ERnZa?=
 =?utf-8?B?MjhCcmt5YjNlMVdoaThaTkFvTEdFVC9pSVZQZEppSFlialNySk9jYzRyWi9v?=
 =?utf-8?B?K1BQM285d2dtcjZvOWdkMXlUeldPMk5DajRQSEp3R0I4a29WWjAvVjVONVFH?=
 =?utf-8?B?eXQzMGk4NVZiY1RTSHJ4Z3NDZkhhY01EOVVGTVdNeGh5elc0UzRYRlpEcDVu?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2jiFzKYCFMVkXThoMW+Ngv06NDHCbpw8gUD9YQuJgI9MlsLE4vwcb2ASBkkZRR+4baEnI5r5eOhKfjNw/JzCHtEh0qDYjGYz6fKe8ryO2x1WqDSzOnZgLSADytsIbx7UQ+2CEQR6FTFbBPx6jMN/eELQQ1ePATTaJS0XjBMb3o8v1UN2qO7OZRIRf6L8tzOLDQrBV32oDDlYAvV3syX2PqbTyhD3R3P4zSvC3ZCn5OZVMbk1EKbAEpDD0U8hlTPmhQVz+Oe8rX+z/X7t1dk4Z7H2zlUfSZo5qrKnaPmJcbqUyud9CdXXROuTR/vQ5s11ds5eOcMbBk7Yh4GFxbBcbMx3a4Vb8RKzEn/dpDiAQ4ULM3kEZxA5IbBKj+SOEUvphUlf4QGIFXM4A99M6+5USvG0wEgrJIxRQQMN4nQt60Cam1CrVF4M725IyBUb2M1vsQR/YXDkAHtJxRwRx0ISM48fscku4ooc0eCkWC+VAvXtn94hICKhbLQzvKV0lgl1M25d+vGDfX7+ezX1KbyvDYZTdI9JYA7XwNhFciQa2m1vgOMyje9XZzDaviH4W0NVOEAdvBvVhShwSmJVhJjaP87y/4hV3IJKt2oF58FWNHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df45a6f-8c4e-417a-4905-08dd4de259e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 17:01:12.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZQUVJtn2b3gmaUr2QD74PzFOzscAzz+QEvexy9GYvb6v4B+k3H3DtsYZBEVrMtUvRF0uunpoZnkca6yElGkKPVzq73HOPibYFz8BkYUuWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502150150
X-Proofpoint-ORIG-GUID: 0rXLLecxP1OLjv2KQgm2nUq9UZJKC5EN
X-Proofpoint-GUID: 0rXLLecxP1OLjv2KQgm2nUq9UZJKC5EN

Hi Juergen,

On 15/02/25 7:09 PM, Jürgen Groß wrote:
> On 15.02.25 13:34, Greg KH wrote:
>> On Sat, Feb 15, 2025 at 12:47:57PM +0100, Jürgen Groß wrote:
>>> On 12.02.25 16:12, Harshit Mogalapalli wrote:
>>>> Hi Salvatore,
>>>>
>>>> On 12/02/25 00:56, Salvatore Bonaccorso wrote:
>>>>> Hi Harshit,
>>>>>
>>>>> On Sun, Feb 09, 2025 at 01:45:38AM +0530, Harshit Mogalapalli wrote:
>>>>>> Hi Salvatore,
>>>>>>
>>>>>> On 08/02/25 21:26, Salvatore Bonaccorso wrote:
>>>>>>> Hi Juergen, hi all,
>>>>>>>
>>>>>>> Radoslav Bodó reported in Debian an issue after updating our kernel
>>>>>>> from 6.1.112 to 6.1.115. His report in full is at:
>>>>>>>
>>>>>>> https://bugs.debian.org/1088159
>>>>>>>
>>>>>>
>>>>>> Note:
>>>>>> We have seen this on 5.4.y kernel: More details here:
>>>>>> https://lore.kernel.org/all/9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com/
>>>>>>
>>>>>
>>>>> Thanks for the pointer, so looking at that thread I suspect the three
>>>>> referenced bugs in Debian are in the end all releated. We have one as
>>>>> well relating to the megasas_sas driver, this one for the mpt3sas
>>>>> driver and one for the i40e driver).
>>>>>
>>>>> AFAICS, there is not yet a patch which has landed upstream which I
>>>>> can
>>>>> redirect to a affected user to test?
>>>>>
>>>>
>>>> Konrad pointed me at this thread: https://lore.kernel.org/
>>>> all/20250211120432.29493-1-jgross@suse.com/
>>>>
>>>> This has some fixes, but not landed upstream yet.
>>>
>>> Patches are upstream now. In case you still experience any problems,
>>> please
>>> speak up.
>>
>> What specific commits should be backported here?
>
> Those are:
>
> e93ec87286bd1fd30b7389e7a387cfb259f297e3
> 85fcb57c983f423180ba6ec5d0034242da05cc54


Is there a plan to backport a 5.4 variant of this series. I tried
backporting it to 5.4 myself but found a lot of conflicts.
It doesn't seem to be compliant with 5.4 swiotlib. If you could guide me
as to how you would recommend backporting this for 5.4, whether it is
via backporting multiple supporting patches to make the cherry-pick
clean or manually resolving conflicts in the patch itself, that'll be
highly appreciated.


>
>
> Juergen
>
>>
>> thanks,
>>
>> greg k-h
>
Thanks,
Harshvardhan

