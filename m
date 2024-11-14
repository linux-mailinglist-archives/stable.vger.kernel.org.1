Return-Path: <stable+bounces-93052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6969C91C0
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078201F22748
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05B197521;
	Thu, 14 Nov 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BA9kfpXD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TbgvoeHd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F47189F3C
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609399; cv=fail; b=LbH8ypE78wecSWjADLhRCPgvWCcAw6NmbnbRoID/P63HGMJclyVgETNOYkw/SLfGPe43I7+3uDFBvK+jZttwthjcYPh84w6Bq1baijZPevFBas5ovM8XGkKlF327B5DlGO9fXmPsnXe4iT/eoOXYe4ia5udrLxG+d5ko2eJwJGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609399; c=relaxed/simple;
	bh=ez4kFEGw1JXQJ58KwH9GV/wmWR5fs/mEtrFBCsHmyDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxNhHayL6b1x8poxzI9bRcLWcxv2OkMi0XvnIzcDSGRxNnQZxuMlsCq6GOATrbHr6kRgNrK74KEr4GQ1XR0c2NiZuYns7U+rCXGEzEqZzJPf/YfCK/AhTWRl670qhklRp3hAzx9NpGK+40PHKLEmzl37twhkapdHwoJZAqeeG40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BA9kfpXD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TbgvoeHd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED2wWZ024966;
	Thu, 14 Nov 2024 18:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VdZd3qMZt1k6HVVHsdkD432RpXfxFj7GlCDekIISanY=; b=
	BA9kfpXDeEAc+PFCqVuS1JnHyIPVJChYdhJriXHMt0g0YtIm0UTzzipjQcCVXJ9o
	zlSqsq+AjUXj9ScAwMnL45LDFoNoNaR1rIFgEgxduszEEbDOeuBB5cTTT1ddqySM
	OxJmNQGxHnZyIfvNfOuDDwHO2HL/cX+I4OFhdaNcifQ/NJxY6TTM1n8sXeCDMOM4
	+dIQbBZuE2WQxsFIxd/KMnclhaKyvExM6c2+TIO+z5DjvBjsmbu3W/oAR8oBweEw
	5CO3U1IeC6uP+VS0/vzA9yjIleq3HnRhArEw8d+sa89y1wRq4vSNQoJd+DzRzTNZ
	ea8wlK38jeUcq7Ef1ck0Tw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hestds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHUDKx005686;
	Thu, 14 Nov 2024 18:36:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bkf3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv00G9oTHxhwUlQirjZyrg7zzjri+kYam2PXwcZ8VhLF0Xwjo5UeXqL3uiR9pqsYSwC7U2vDO+5FwC88SvKPVMyRsYEpm9vKMAtAo0dnMkePFIZXkM+vcSFAPkvYofe7Y0LaWwkkmYvN4F3QdVIM/pNwRPlk0Jcr4g/+eP7FsgIe2FuRO+lOpLmIYk8chlcTnS9UeurvMy8r/fPwb308yOQAXwwZAm1fXVub7gIPCd8jG39skZ6INdCmNjrNWYFvVneFFlYhyZGquOEFxyjUSNXy+Uoqrcc4t+vp5dpquv23giSu/e8HQ2IebO7T6D9XnvdbHEIIkZVItEIa+UMEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdZd3qMZt1k6HVVHsdkD432RpXfxFj7GlCDekIISanY=;
 b=JAx43AQynUJSaLooOLeE064MNTZ2ugcKsX2Tk4+7IUALfP2Fp/f+Jx918xb4TtfPnAnrEEnUQ48kvCrEpgN7pkDeWb8uXB6Cau4xN2YkzaiA5WB+mWcm/yknFtIIjXpouV8M+zFMJZOYXyx91lrsH1Or+XmFAGR+AiK6v1cpxD+ISQKgodSi02N4cd9Il1kKUU5zd+mxQVWEYwucRIN6H9CY/7vx58LypHVF8La390VReakXOOpfsSPEE3oBVoqGigar3oXrIVVxj7sVwQtWOMLU8g4q9aOtUaKB+xVD58DIbTT6PyIX3J37Nb9zr5RgfRyyqcz6DrxVMosiC8bHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdZd3qMZt1k6HVVHsdkD432RpXfxFj7GlCDekIISanY=;
 b=TbgvoeHddOMcgVORfep8uk4+kZPv6MWqGf9j/ii6BOavbJANF/2fYuRuUMU9T3OIgmUkGQ1OYh6tvQv7tbJ48a1DLmxAZn4OXz28EAbQ52QsJIyD5RUatJvceykI42Mfjn+MJ0LiEsqR300aQxM2HFQMQEvzTCpF/Z5yr64Nioo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:36:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:36:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jann Horn <jannh@google.com>,
        stable <stable@kernel.org>
Subject: [PATCH 6.6.y] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Thu, 14 Nov 2024 18:36:19 +0000
Message-ID: <20241114183619.849168-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111137-kindling-sesame-e74e@gregkh>
References: <2024111137-kindling-sesame-e74e@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bddf1d-7988-485f-00c6-08dd04db3d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Zp5FDPHfVYWLeDJi5laoF8CJTUkUb9kcaOxhVmo9yCwkzkMDnHLjq/oXI5p?=
 =?us-ascii?Q?HQkT0BNeBDxA4qhnME1rZeMp5TRuHtiASMfsxDlNQQkA5FZ/Tpv98dpxMx0I?=
 =?us-ascii?Q?BcSoDeldJtFLqzV5qdJkS1iLuYb711F7MenjgfTaJuV2uLGe0qxRd/t3UjkN?=
 =?us-ascii?Q?RwM57H6bwX/vhuAwNcusY6ge1Hs/40MpB2h2DjXgxrJiiVzjA7pK9mme/7Bb?=
 =?us-ascii?Q?PhmoeN0ZABGAEI2wl6InV5lI7SG1lmjCCJpk4fGHA2CPwPMaWEl60BgHSr/w?=
 =?us-ascii?Q?w9WLLymt2lXpttbxZ626rsIxngDNRSy3wIijtAOexXGMK0g5DJdVtPgFXIAP?=
 =?us-ascii?Q?qRILJKRL3SzGBSIKInL4VedgjtjpO0h4QypxckEj6OSI63BJq9iMplMTA0+l?=
 =?us-ascii?Q?2iKvuQOuA8SesTq7P6svt+opuwfDziUzPlE46dxClNm0IDi7StrbS8FIrD4j?=
 =?us-ascii?Q?NL92E6FFtvpGBgWo/zatCgUtFiQXeZiyBMDPK470vf3CQT8TXoWFj2rMBu+u?=
 =?us-ascii?Q?g13laNleGtDdbCisJSL+7hV+4UTxsJjeY1So1MdqwPXYYzGXKBKyxRORI1k/?=
 =?us-ascii?Q?H1eCWz6eRf1xcFogEPIoR7Jg26pkkAlQXMvJzzuIovYyyZN31lGAFYMaNFi5?=
 =?us-ascii?Q?qFZy+rQqdwu/qE+0swJX+aRwkqk2ssTGXyoKbe9UWKb0ZHickx+fstWmS+ey?=
 =?us-ascii?Q?XoAxF3DLJXQ1dB80qVf0rVqMnRNsB4UbTIyN9v+/BM8vRlus718zItE4zz34?=
 =?us-ascii?Q?7SAIJ0B+1D0jGs6UMAwJpptKgen4SHENRj8sVqja2l4A1HH5ThO+UcfPPKzK?=
 =?us-ascii?Q?sB7gaBs0Ejv1EROvPfeDmYRLoErrWGHxWIb/YW+n8YRbXDW+9eJktEI18swA?=
 =?us-ascii?Q?n5k7Mw/SdynlDb8iQhR4A3HkNSz60RWz8E3s+9/E9/wqPOANCKCuhErJduq+?=
 =?us-ascii?Q?IkJStpP9sDSpf319hDHJdUw4yV67Twkl4W8d1B9wsQR3rNkHtiZsjvLb/ECE?=
 =?us-ascii?Q?ZUYgC+2iX8tzftfcXQ9Z0S7KVQVlLjyOpsfqwnczDxeF+NLnQezlvrVnv6EZ?=
 =?us-ascii?Q?UioLm+cSWdpgxz/Vux0FhvMQUs6Ue7dUZ9MVSbmn69mgA4FRdFl9NQpXnaLC?=
 =?us-ascii?Q?kMkHdu+Z431h2Gizbdlw22wbdnTJ85sFdcDX0gsyKgBnoj1qhiUozdhgV1V0?=
 =?us-ascii?Q?U0cNyvhdAV1Xk0H2JrTYS1Wz7QypVWE8QyaaIMbdV+UGE02d6AWiHVMYm00V?=
 =?us-ascii?Q?flTkeaWBi+PbmOMGqf8vxHMMF9HELoTsPkYv4SzUXHu7xKjNCp3XxRmXlZpV?=
 =?us-ascii?Q?YR+kRJFnqRKhyBlwoC8K+/aL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDC6o+mHKkXiJfnSeYljD4ns37zuAy2tDHMBLRi8Cy7wnJnVzVBM5nxlRvk1?=
 =?us-ascii?Q?raiQ9C2jRC0EQyEnGb0LQKf7iJOxixXAPvDGZQycpJYJro9COfuuJAExTZ0F?=
 =?us-ascii?Q?rvS4EyWd5EAAdijLjDCAdvOI0TvGYTISEaCP0AMmAdXVV6NMHhGtAc0i4z+R?=
 =?us-ascii?Q?XzKdaLndEg1rYQ9fIlGBe7iaHEOgLTatv8EyuON+p5pHT+/tvy8CIW0vUYKw?=
 =?us-ascii?Q?tFEPlc+RVu3kUyjQoMsyJy6nCJ1W3NaJdUck+cC1KJe08f0/vYwFp/KqLj2u?=
 =?us-ascii?Q?zbuS7XNCxQFKG9SQAGlEdz6PdUaRT8Ha3X7XWcdgfu7l16MJRuyEVNHsp51O?=
 =?us-ascii?Q?9IkAk/sftvRtR7h2nrpbEK/noqMby1oJRP8WvEi/9F3IrBUGzu9rWUR3ht32?=
 =?us-ascii?Q?2dlEvz4SzoD7SD6P8vCRomvbCZRc8zbxxcyTMP0GwQ6N26VPpwtWuU5EEPxo?=
 =?us-ascii?Q?rAnhZdQPQOs0YbM89pLek6ZCp8dcCqs3y1K544Z/ZGD4uImKDMos3+gmxraM?=
 =?us-ascii?Q?EKEvWzt9X5C6kau5usLR3SLVfCK0bANGfB1j+hlm/sU/ReWabmceEeM5yFsC?=
 =?us-ascii?Q?PXZc1bHqYMj+ai8xhWy+hDZAk7fjWpC9+VQFC++8JWDfTTDKIDbIuymY3a2y?=
 =?us-ascii?Q?egthLAeVNLwsFys4fB4qZgDPLmFsOxV4q/lnjijm4Wv7CDhkF/tdQtmZ8Hjg?=
 =?us-ascii?Q?t4px1hRI0gyrQXlVDE7Mof3umyD8vgZNfmdSwS5cm0qtX3BGa5GBuI7xHGXv?=
 =?us-ascii?Q?i/8++tithZi7L9ewBogewNks6jX6nn853qxKdhkj7BIP7agLf+JyuBjl48b+?=
 =?us-ascii?Q?aeQn8NKtE8iOb7VeowfnYk3qaaONgOwzO2+4bHt8Cfl6+9o6bTnoVIXg8sT1?=
 =?us-ascii?Q?+G4+wIdeVW1em2j8rlGsk2QjDHofOJuYES9+2SG6NI1d7OYm4E3XEBXrDIXt?=
 =?us-ascii?Q?HeJUjp76uwjaXTx1QbnNxPsFUqFnzJ0S2upfC18OGFnwi+hY7N9o4JpIIFmC?=
 =?us-ascii?Q?mZM9NHTK7mNUdJ9sBzyWEoH0Fj81k68zY+QBiH/a9LgtCAvkSyjStPi8smQ8?=
 =?us-ascii?Q?INdCR7u8eYFUNeEKq1PcpdCAUBE47Vs+2naQFgyjSBFwqR9glV4I3AJO4f5s?=
 =?us-ascii?Q?wYtBMhZfntDXDExKrV3vTgIsYqIziyfu7DIGQFkvctMwK6FvkOibzrOCrrjh?=
 =?us-ascii?Q?LeXdv779wmOZn9m0/GcKw7//XoJeSY1r7nLZXmUuV7hDvHyYwoZ0tkAnhAGa?=
 =?us-ascii?Q?x7a3nnv/9GBUITX8y7zrYXsKmPWVnvCyWhdkfUsC6yddQwDgQo1UOwMgtkHQ?=
 =?us-ascii?Q?ifMUc9ey2LjPTgwaA0eEQRxDkwnMZPjuUKikObg+6j6doyKs/N5Oqb27tOhi?=
 =?us-ascii?Q?WeWQAp8oxmieZ684TDEQN44mfyuDodNLS0MgLlkbdSodfYxXEbBbF/S8ANS7?=
 =?us-ascii?Q?yVGzzNIfbD2E1TujpWxq6P/hN+C9AodJCnHzZiG5Swxlr6abwwNJiGX0tpvG?=
 =?us-ascii?Q?DcgqxuoldexYgVH06ZKFDPPWEBzSrE8V+tXEuc0BP99qIX+zYqTLHRv1lqRn?=
 =?us-ascii?Q?eQjVowjxr+aGzbT0/aHrYqF+RQl3QijQQZRMQBYpAspcPpdqWU5f902hFKOj?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z7qdXrYs09nULofT2esKUjRxmZvxWRejj7AtlWYLdP0NZ1Oq3siH91v9QIonA+t1wLwtXYdLOJuAGTh3aaWNGR6Ry4KhFhgQRd2pxsfNlrMMrwWSR41+cK3qJK7rQf1CcHw5J8o4mh/Bk7l8uJX++5txYgDLvUxdibFCdPdHXpbK39IFABp9FE6zhc3CMVQxGXxvrrvTekHAsHH25iFiBmnwcKYwn23g7D3ZhrqPweHjfLLw3IlyIsl3O/fgQNe33P202nRdGrrDL4pFHr9LP77E7OppvuWLOH23BUZIWxSSya3wbB997zCVtHN1wvaxzBuf8sYS4X8afzruphqyN1FFeolm4sTXx4OerK+QzyYeH57SO5ODHNiIHt+r2a2AMFoB4mCd2XUsQJOPnCMnMrWFicFT+Jirwe6+Jz1EPWISI2WOFzkknYkUK7C+ER/TR4hBo+t0sCphRPrI20lzWhj0N7vFy+L6MTJZ1Azk8oVTZkLwXytwGbePS6zHkJ4Yj3UAZoeFwpAiPARQaKHNWkAWNC82O/hvgQQ2iLllztrvfzyG0SDnOvgScoX3dTPi7wEMigRk0wz1Qw+z8T5ZOGax1JNOx3Yj4s8rETnB7pM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bddf1d-7988-485f-00c6-08dd04db3d4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:36:23.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPz0GUahQXCBXGO3SOCo7seKCc9hfrvvEaWa9ge64E817yAL3POcDN+mkYwVZie/78rwuHmYtjzxMmaJIQ1NJEoB0CULo1ovXfAgLmrC70w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-ORIG-GUID: YzK7an2M-NH2b6y5hrybjnCGEtiGj1pv
X-Proofpoint-GUID: YzK7an2M-NH2b6y5hrybjnCGEtiGj1pv

Currently MTE is permitted in two circumstances (desiring to use MTE having
been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
checked by arch_calc_vm_flag_bits() and actualised by setting the
VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of the
same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/include/asm/mman.h  | 10 +++++++---
 arch/parisc/include/asm/mman.h |  5 +++--
 include/linux/mman.h           |  7 ++++---
 mm/mmap.c                      |  2 +-
 mm/nommu.c                     |  2 +-
 mm/shmem.c                     |  3 ---
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ef35c52aabd6 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -3,6 +3,8 @@
 #define __ASM_MMAN_H__
 
 #include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
 #include <linux/types.h>
 #include <uapi/asm/mman.h>
 
@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
+						   unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
index 89b6beeda0b8..663f587dc789 100644
--- a/arch/parisc/include/asm/mman.h
+++ b/arch/parisc/include/asm/mman.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_MMAN_H__
 #define __ASM_MMAN_H__
 
+#include <linux/fs.h>
 #include <uapi/asm/mman.h>
 
 /* PARISC cannot allow mdwe as it needs writable stacks */
@@ -11,7 +12,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 }
 #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
 
-static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	/*
 	 * The stack on parisc grows upwards, so if userspace requests memory
@@ -23,6 +24,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 
 	return 0;
 }
-#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
 
 #endif /* __ASM_MMAN_H__ */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 651705c2bf47..b2e2677ea156 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -94,7 +95,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_validate_prot
@@ -151,12 +152,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+		arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index d71ac65563b2..fca3429da2fe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1273,7 +1273,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index 8bc339050e6d..7d37b734e66b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -853,7 +853,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 
 	if (!file) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 5d076022da24..78c061517a72 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2402,9 +2402,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vm_flags_set(vma, VM_MTE_ALLOWED);
-
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
-- 
2.47.0


