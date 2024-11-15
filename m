Return-Path: <stable+bounces-93523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABE9CDE5D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367202829F2
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496E1BC07A;
	Fri, 15 Nov 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NqPYSABS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FEasZOxu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAF1BDABE;
	Fri, 15 Nov 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674265; cv=fail; b=GAorbNBcAtJYus34DKAKC/UCOxISVsIet9SY6ME/mnN7+gAccU6OzLqLELWn1uzJRPBFSe1zPcqxCbXGMLQgbgdiZ9FGX+B9OIXxi3e3sACFXPWvz4PnVX6ppSNzjgaNVvIgpQapbYidNrx0XNLAUGt6MBwr4sCGu+aYziBaxR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674265; c=relaxed/simple;
	bh=QcHeEphsStiaSFUqI6D2rzYW7B/9r+g4Gz5kJlYJ+oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMiyKkWWKlUliNXLK82ju7iexhmGeH1qyv9YLSp3Rr+vQVKAsSLJkGIXSuHEUFhI6Kl5sVflYijWkeQexZJAn5eMs6ICjzguub+MVqi4E2fmZsfBfvFyN2gBqApGd4U8MH63GT4H02qE9hX8gjj5S4y8ytA1spppMN0QIAtyTsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NqPYSABS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FEasZOxu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH1Um025789;
	Fri, 15 Nov 2024 12:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HLLzt7YUAlhV3V4zmpe3bPdi4KwZJIGMsntE4y/q8EY=; b=
	NqPYSABSui2LA03XGgtSmfPBg8En1blAJWgeKxzuM/4QDJkv8f+U8UGncxJ1volI
	eSmE9cnMXPXKPEKUahLhqaQsTWijBSNHzBKUC/hpy5yq5I2laYvgdb5Rm0knaaL6
	MOgM+jYAwVtGOgF7EdgEySFORFGtL0HMP506xCbbgkZo6RzCaT1gR3SrSvni0NY3
	wHuMpDUKYx+zh8pWJcRS4YJbMTlEB8zRjd98wmrNASXfccrnfh2SjOK3YrL3SSC/
	x/jF/oPE0vmhue86DDGuqexnEuh83+2AC9AVpvhB4+eROTYxahw8y28U8KNnyV3m
	E03du9qvrS5DClJlKsaUuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heu6c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBXWnd001273;
	Fri, 15 Nov 2024 12:37:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ch2s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYt819jmfsGGlKuBUSotgXm+BvAPflHJsKu2o0N2HBC6X/k/GLxppqw0xZT+8w1ltDXX0oo53kJ+c1izfRezluaAGHEM9/PlrR/IQJllDepGmDNa66gUkknhVLgn031rkY/h8BOgQam0TlXabmNELKTa6EUM86+OCTGTfmx9+MpAOvS+09Cdzw1oERF9a2SVzD0U23kxjTnpMwtrjz5mMuAkL38VVxuzc6S6A0Ei/bqoQexSWHJZBcDnfZWpKqy6ZP04iwXTRXaSbPsgVEvqrEAvi35HckLlnTncknkQURUiRnwMxNJsHYoWMSBtV+q+u2mOsb49gBMUAnAnZKfWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLLzt7YUAlhV3V4zmpe3bPdi4KwZJIGMsntE4y/q8EY=;
 b=Zl/MGtYaDHxidCQh94Y9vw9GGfddfe76elTVNo917SY0tR1vdgDUo6bu02GdscYiL9GgNL5RxT8tEcydswLFkhi8sWf+z7KXJTE0pfJBdOL7MloX2TpoOFnnH/XIxr1MXz5sjeaRpLLc8qcJ8iZxtOXBYsEotIMUiqK+X2YIJxeyJa2PtoJ5WceB/fOoo0fuQxEwsAbp+vya5378PZ6eY4tKiox+nvgGPk+d72sds9Od2G5W4R0CSDG5OdRaDbTplKOYCzX9HcVDFtU2Zi9sjU0s/esKcr2wXxCmUjVRn5lT1EPAxplNSsAOxeHbtTqWiXQG5rr5I4ZrhL2oT3ueAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLLzt7YUAlhV3V4zmpe3bPdi4KwZJIGMsntE4y/q8EY=;
 b=FEasZOxuV9a+yAKUVKMybysnQR0rQb4Huk6/dJGGpo9cZvQo+7K2bcrrA1q9RyCWK3jHc67Zb2aV/WMa9Wo9EjGUCNaVSD6LCzgnANYzIidMQLkg4PA7w9xABaPTeIm1i5u0rJq/QCw7i1WqdgS/yBaIBPKi3hCqBFJmalxELqM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:37:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:37:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10.y 4/4] mm: resolve faulty mmap_region() error path behaviour
Date: Fri, 15 Nov 2024 12:36:54 +0000
Message-ID: <99f72d6dc52835126ca6d2e79732d397f6bfa20b.1731670097.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
References: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0438.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d98819e-3e35-4b34-3281-08dd05723b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u2wHipCiP+4lY6bqNN99FcZaSPHSR+9u+cPZW3Nz85oSVOpDsLNxvJDnuk75?=
 =?us-ascii?Q?tRmj+EWz/HaWtHElzZLMa6cGz9xGDrIUm09uCh+wUvQ868pfd2LTm1Z0JRaC?=
 =?us-ascii?Q?2xBakBc4Oz37so7kKnC4pG+6zHrZXsdXCeYv6B39yavxJlncCXT2m77C5hOJ?=
 =?us-ascii?Q?A18JvYlm3npG6RP3Mi+ywtealp5ynyBErodW54SAMii0IIc31zdAyhzymX/c?=
 =?us-ascii?Q?21VI2JDA7YqraRd0bhwE8MUKvat5UC3G811wEuM6m0zpjjdbGfCYss45ZCpm?=
 =?us-ascii?Q?y9QnMybwvijv748j7QbUvHf3cnTlRfWgzmp1WBxj1cYVUypDod8X1jO5axDf?=
 =?us-ascii?Q?ABim0SMyAxjtMxE7tXH3jyLDiWR+dTTrIUKyoZNirpME4qcBIe10idm9hf3G?=
 =?us-ascii?Q?Vw0HZWdsdR0u38ZbpV0v4Af76XnlYpN5OPJmPmw83zTtUTB2apsIq5HKKAuR?=
 =?us-ascii?Q?1r9N97ivksaA3GFlKxptsg5afdmW6pPOHCXpJDBTKk75q8O0eGm/hht78pyv?=
 =?us-ascii?Q?ScPq+PeRrKmHOeMA1Cp5uoI1WpwWw9Zll9SyCa9rtJwCPHcL7aYRDAxBrtbc?=
 =?us-ascii?Q?eSIodGEVg1fmx3RsEs+nZKW+JXujYEM/oZqc8vsaWs3xt9XQeg7UKbzj7i4K?=
 =?us-ascii?Q?8y1rZ2wjwpzcV/HM4vMykKSTGKc05p1seJXgVY+6xBV5vUd5sYoA9W9M8Its?=
 =?us-ascii?Q?dVudU1+l+/yETbxEaczax6T/dYobqaNnPh/K7s2UgcsZ/vUxr8Zvb2VO9Io+?=
 =?us-ascii?Q?xWaONcJmyYHZxWhDzHT/J4FJ/qDxM7mcIFzdSNQfx1CRp7o79pBJCiuFlGjz?=
 =?us-ascii?Q?sSypWFXwE+poe03qDKJteWYJAcw1KfqRt0ZEZpp5cvTZJzERTq+8VVgORYz4?=
 =?us-ascii?Q?tPh9VQ3TbS/fZzkeZ4Az/CvUU02Wuh+BLiDstZZUkpHxHus72lKhjPD7nFWG?=
 =?us-ascii?Q?X0tDM8D97MBMjbTHImxOrnhO/uYu5NT/yrgwOGO427BQgfdcwS+gGaaGGkdg?=
 =?us-ascii?Q?MDA8LLXiAd64pFmONf4dtZjbsMlva6wzct2Zme+f2dORZWUmRSwrNqG11kZ0?=
 =?us-ascii?Q?TWNNyrQB+ODGMh4jxYJtzkNHHNCoyORUcBFKZBQFFcLAYLyepQi1tORmYyh6?=
 =?us-ascii?Q?I+b84kGMumCLho4tnoTPhMtAtLOdT8EQkk3uYSFwL6dQ6C0mMRDSkb531+HJ?=
 =?us-ascii?Q?kyR0K9ajbgyYJC4atC5ZkGvfWxe2fB+tq3c7+QvdsG16PhWEnzyr5ppkvTjC?=
 =?us-ascii?Q?N0dUjXgAJEyhCvV6XYY3x1YWzKe2yGo4pTQzarRdHhNPRFg6Zyh3E3IrKl8O?=
 =?us-ascii?Q?b8apnyWlM6xbm8YCnYfApAiz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVhyVI+gmDkwdbfqCZXRwIWdMhjJurDfT5glQSJLHdACZ/xaV35Zr6WoVgdd?=
 =?us-ascii?Q?ZovXock5SeztTzQhxMxhW3KTXnGoplVweFNq2zfzEc/nzcRNIhv0l82KDd21?=
 =?us-ascii?Q?FvzqpudblF8rQvhZoTtkuSxd8IS5qj+TpFxHPQiopiuh5XqmCR16ZTpx74QI?=
 =?us-ascii?Q?lBA84BKdW2ag5DB5FN2r8k2D4agCcrzEXkcHoWFUWWF6RW7Dw9OZfKmXRhei?=
 =?us-ascii?Q?REzIfwSgvJUn2oN3iKPslQoedkwwnqL960SFTwmN5jB4cduzqaSL5WHuELU6?=
 =?us-ascii?Q?53bgYsmTY2GQzzj9hlIgUB8jik1PntgcP7PaF7SrJqz6S0KPSPTanNr9+Xb3?=
 =?us-ascii?Q?u4ihW6N0TOLGCu+TWyxJjUM25PultvU1DUm19VZqZ+uBb21Upel8P2+VuJU4?=
 =?us-ascii?Q?OcdMA2CS6vhsRO5ctUTe6xgo7muPCbNP9MKHFsKq6gb8UGa7olCUPXgOUs3v?=
 =?us-ascii?Q?/uX1GGb4hP/gr+QNF2M2UKkrJwEzh8wO98gKh9W3PJXd6MYINia4Cnpj3N8u?=
 =?us-ascii?Q?GUpeaTXZVcT6To8CYPhFgberepwhPE6bME5eQVhz2LwmnKKq0btqP5p5s8i4?=
 =?us-ascii?Q?BeksOAHww4QYAFfQatlY/avYbZE37OvnWPw7QZMmtFctGh2/P2cSwo59Yp5y?=
 =?us-ascii?Q?WMYMHwRRgbvuk8Bz5ttYJv5Hpuj8CB0Sb2XrBRxB6TWeDJawQQG2EenDcbpV?=
 =?us-ascii?Q?g80IT8JhTquy85OvcibFkkZe1w6jzgz20/O5qJavLRX4CB7RTbJ02dL3WgiM?=
 =?us-ascii?Q?9wDZzgtf6+9BHw+TBWyEkSawrmtkkdjtEpL5G00tL5lO9rcbl4q4C9Lp4xdu?=
 =?us-ascii?Q?4n213tRcO0/Nq888Nau+3udx4jkgLIDXv7goLTyT8ie7vvKKtKp/g4Xk0myo?=
 =?us-ascii?Q?aF8+zC9WswZJJsYVKylg83kvnCBQUqVi0RN5x2hdZuMHN9mtNA6bTFrUKcKW?=
 =?us-ascii?Q?8HRx76/WUUtw7WXi9P58edwtCoCKc5EFYinVinWdYvxJ2aFe+QwxyDnZgIcW?=
 =?us-ascii?Q?dxdnNOwGn02z3eUWbWlzK39b7lsrDWbVXHbrtSU5wFdaq6y2DcIx4gOxg6P6?=
 =?us-ascii?Q?KXz9OKIcEST3/jeEarmM03/Xk+kaJfzgZ9lo6TbFh1HJBeo/RpVffTaKvtll?=
 =?us-ascii?Q?d/TSJhujjsR50wPY/J//knF85UG4IB9UaD4Rh4c5mVYepFfQNDkA8nu3UxGA?=
 =?us-ascii?Q?BlIZRtZM5KzoZvd+/OFRtfMFTjVYKHZirfgOZp3rAn6R57ZNX709+7h0dhgG?=
 =?us-ascii?Q?eWUXhiH/T83aZ4TzH1Whm8D2MnAcJwC+dk3lqKA1anDnNV17Q17+87YyGlwF?=
 =?us-ascii?Q?Fj9G/n9wJ5y7phxhhTP78ox5gOwhMo/QG6MSdddU2aA7Ch4/v5+vAEiziIaw?=
 =?us-ascii?Q?rBC1JEQmWqEXsu0N0C4x9sJLk4kH2IfDIm2cNGPNBhZt/lpM3dUxwzRTF+e7?=
 =?us-ascii?Q?q/fk1yZfiP0pJXlm2yM/zMaf0S5TIUyc3Muvr9Z3KigZkR5b9QktCVAYo75r?=
 =?us-ascii?Q?RvT6T3g2BFKKcoDdQ8BMwmX4r8XfpbGAYPY1+D23hFRTOu4NSoIQ6bUILo7/?=
 =?us-ascii?Q?rNwn80yYd/mpmTuhNamkLQfa5IF3PMRWaE4i5dm2CLuX1Yp7Mie/LESQHNYZ?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3znoPqeMNJKbVpFw+7nxQkAZX33HE4rzsGwPK4bqG/o/75meRWALU62ulbytqJwDxK2hLGBltOAyhJ0nKnh/9M2CZBYKhClVj97W/TQcUbe9qIKYo4IYuSTljBdJ8K3i+9qpbH+v60pYg4nKebxw8AIGrPriF/EmJdxIp6Zlgw1uuon3JYCEtCrbwYMmyBi6Ueb+ukeTNBBKtjwr6eCTAXyYot1KIbeuC3lIZfLDjCmbbWlFuJFhYNydz0c2je1w4fbcVLhogzDVAbDe9MH3xovGne7tCeacbM+sFOyV60BqE7hWdXIaew4frxEqHcex0BSGeiOYjleDogmjgdmrVWrpSyKDENhOCJ8tNYerWIMKMH+6faflLW22SbElOyCm5f7zSQ87286d7UZX6aV+jviQtdwWcB2Z/17VdjWeaNFBsXqXZUR9VkjMd1Co0OeaEVqYBwyNS3Ci0CB7+8Cfrr8v7z+y68nWeWio6/0UO3V8U5NHbse4OOmtLLwKhOIbxmJocc+frkXm/KqVveXEVUZ+CivONQN23hVYLDP5tfUDY2NF6zjTJhwzMzxbtmK3jQLnK+rLfdlLJ0NH1WwrlEFiu+40WQnBEwJ5ih8BjHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d98819e-3e35-4b34-3281-08dd05723b3c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:37:13.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY3bTqAhRD5JTDOpBSLLyc5X9uFi/1nW9+K04S4DhAOgnBjqLXsM2CVLP/iYJa+ZyZQzsNy2ie+d6BD7oonhTSEx42TFBuFA2AL1C1Mm1vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=945 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: Vc0Y4RYwVnXxdBo-ske0bG6ydEnz75Oa
X-Proofpoint-GUID: Vc0Y4RYwVnXxdBo-ske0bG6ydEnz75Oa

[ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 69 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c30ebe82ebdb..9f76625a1743 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1726,7 +1726,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -1795,11 +1795,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			if (error)
 				goto free_vma;
 		}
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto allow_write_and_free_vma;
-		}
 
 		/* ->mmap() can change vma->vm_file, but must guarantee that
 		 * vma_link() below can deny write-access if VM_DENYWRITE is set
@@ -1809,7 +1804,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
 
 		/* Can addr have changed??
 		 *
@@ -1820,6 +1815,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
 
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		addr = vma->vm_start;
 
 		/* If vm_flags changed after mmap_file(), we should try merge vma again
@@ -1851,21 +1854,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
-		if (vm_flags & VM_SHARED)
-			mapping_unmap_writable(file->f_mapping);
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
 	}
@@ -1899,17 +1895,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	vma->vm_file = NULL;
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-allow_write_and_free_vma:
 	if (vm_flags & VM_DENYWRITE)
 		allow_write_access(file);
 free_vma:
@@ -2931,6 +2922,36 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
-- 
2.47.0


