Return-Path: <stable+bounces-93037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4B99C90C6
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511211F23AEA
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91489188735;
	Thu, 14 Nov 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j09N8j5C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o442N9fr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90811C683
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605228; cv=fail; b=p8/PWONMaSAXa7fsaeojd7I9A3BYwIWPAV6VnC2Og9ElNDkOasHiCHRzUdoZNUKo/NuHc4vEZfIv8AcYZEtZxUhcLOqzeYBxXrp08QZhLtnpjNkQNDUpz1RT8nBp4Mztg1MTufcKMe7jAln9sXz4XLPIjbhYAbxTbcyon/6smdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605228; c=relaxed/simple;
	bh=t5BspuSOhD8w1rMmaTMMk4G5BPxKSPR8eCXqnCtYBqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Edi46UpYm5j+p6UbRZednkRh5RSk7NmpEdd1AC2puSrJSqZksXTQJSgrAFqqgbU7ROmK6kzxwFVeaDIBk9Dxp5WhTW2QYa5QbbIvQ6H8+sPtoknMXUl6nfxGHmx1jFicmGIDIG6Twr4tsQo0n4RKPGx0p8lVf37l3Fj6QPK9p4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j09N8j5C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o442N9fr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED6wYQ001682;
	Thu, 14 Nov 2024 17:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Tb6Zemvd/oVvNLIdqHdV95XMoQDes85x/8UkiUkNCac=; b=
	j09N8j5ClbO0Tnzd6anwQtD3HFsaPeBYB7eBKUvX///mXj4eUMNVJ8dmVXkuvypN
	sCyQneKVlO/1xbqRt2ujIcdqQ7i0GG2r5otQ3KkMfWknmjRtORkrR/Zwjflqhc8m
	/azWMq358PXpELmKJJt3vy/n2+4ZEBpXCoVaZVswC2UvUdskkV6wQkY2QAYzBdTn
	kCRqmXakij2Wwei+qndNHHoCgYKLaPlE3sxdV5Y1CV7E84f2HHKkwUTFUPDo8NcB
	n2QDMov17BBq7rwBEeV2BU3v0ydUhgqP+Zd4eC7xdKI/6TQk6HPjssc06qLGuRRE
	3hquD8JX1fzUR+zuSvPzag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbhv8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEH0YQQ000393;
	Thu, 14 Nov 2024 17:26:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpagnpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGaPgT0VTFephnng8ghr7Zvnp+ROmw0bb+RP3M/fbtXQtvpXVoD8N5KGL8mRmMlExINzjg//7lpMxlg46r6L5BPZjlMCmQbsPROq/Kx1IoDucoWKKGwij93+jXztmVKD2kgWlvrut0spC/bV8tkE/hiwNqFGHDmzKlEaCxgYHsGwCZXDnVXxJubsQB94rF10ao7aPvNMLEJ9wBeSigJEWHM06SdRQtfv8uNJhbfLqsp9PKAjzF9TnIxXRi7EwIQvYfKAicDcvAf+5LieLcYBRlpwNhmf6kIsdyiwmDQULI6j2JGTIB6TGGQ4ZRxFndFYzXteMU5QeZXSALwKFDXCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb6Zemvd/oVvNLIdqHdV95XMoQDes85x/8UkiUkNCac=;
 b=DdKUvueGOnLX/PrIDnhpAbLCxucDhnMbVuDOSFhI5DjA8kH6n0g/c9/DUtMM2wEwCAubGf/lFtMqFRqLouamB9ny9IWYKgjg2xYwdxFtdS6S3k/Uy44OGyQz9IczuDKoND81GWFqkQIcIH5ctg/dCP4i2lXCcglTABla/plOyiCGwXwp7YgwqLskZY+8rc1YpAWPl6TO2bzFzcsxwwWJWRErBXgp8I8/tY9YDNGhdyG0AYA6LxUVLgfXy658vZqcvlODJsrowo2E/piK/AnoHOGMuGg0s349PTXimbwQImkpslbnc4lIrjTY6mssvOhKgLi2LgpFzXnE2X9Ow6a+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb6Zemvd/oVvNLIdqHdV95XMoQDes85x/8UkiUkNCac=;
 b=o442N9frHO8tVMgtG69ZwxWEInDkrGywmcVoSojsVSGXpnl8kji7t6LfafUz51OtlZkoXHcCqzv/t1ZFN27BcrcHDTXkep7pAjPrYNV/4boWaVJVZ6NU6zvDH+ntJGof1+hNx3TpdfOUVhuc1uspSLFEzS3BPe1iildpyOCsH04=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:26:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:26:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
Date: Thu, 14 Nov 2024 17:26:39 +0000
Message-ID: <20241114172639.730918-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111141-married-verbally-bb6c@gregkh>
References: <2024111141-married-verbally-bb6c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: f5be9655-a6e4-44c9-96ba-08dd04d18202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LM1Htl+C/gmrbEOWy3g25HiLHBMFrI/cgL3ziioF5oNLTPaC5eq8lvPqFMyj?=
 =?us-ascii?Q?CGWAOm7H47qya4KrLbdoQ8A+wIA/tXsXgKShBqvIc1jzfjDsCPzysqgdaL1b?=
 =?us-ascii?Q?2UPu1rfOz6PssvCKqFothbBcnESTcb1REAvWrfiiXcpXfHUjCdgCoZSnWFon?=
 =?us-ascii?Q?m3mOd9otlfLpNPemqSsJvC15F04ZNSlsKTcK2vDKxbKpWqyciXwyvXgtO1u4?=
 =?us-ascii?Q?Cfpx6/x4pEIKtbMajW7v7KAgidG3qcKlv14aFHCVNoovFVRSCQsgyn5eEEQU?=
 =?us-ascii?Q?c9OJVDD77Jly2ssoZZodthvRThjNGAh92Y2Um4uKxAn6fdBsUK00QN0K7674?=
 =?us-ascii?Q?VHb67QhaOgWF+hGMYLoFGrpBrBDSfpK5iCpqyOFTlLZMF49I5cfhTVgMocnz?=
 =?us-ascii?Q?XM7zNzPA3mFtewgws0ekwYsgMdsihv+eUY2/6XwREzTh7a1lcWKPlkFU1f+t?=
 =?us-ascii?Q?DLhd0IWb9LPBKKYXeaylTZZ/9zmAdhrZOmJxTy+N+pGFQo2AJlyqMOY+jmH4?=
 =?us-ascii?Q?gi1v+5+juT7vRwfYOxZSeKT0s4yKl9CQtARtrhm5QRWnUYoSfYbOJ5NUTTUf?=
 =?us-ascii?Q?sCcqxGyou7MMIeefcv4MZ5FD5mjuxvSuJUcq/fF8p3EpF8bRaeBqQIdJZR61?=
 =?us-ascii?Q?Yhvev9sNOj7kgO+9J8KuYZ7IPaTingxJjodEYIKROipG3lLatDJ6H2Bnif4h?=
 =?us-ascii?Q?KJDwxYUxT2Umtg90sifK/mKr+2VRSDx0qWOYDfpTNEMpPEv1bCCIPM3sYPBL?=
 =?us-ascii?Q?eFVv9QUbST/VVasODYGmuqo4fLEgzICVawx8qthwel/i4UqY3LtfDjKBHJ/m?=
 =?us-ascii?Q?nqj6jOA2Trkd/lmEUnLJ9BJTY6nfVETBE9tsnlbH3tL7skwYfNBHwtjxUSZP?=
 =?us-ascii?Q?lYr7uOaK6/vKdyWZc/ELxuyaw8CAC9roemFk09exOR+V4L/NMGmHSTQvWsiI?=
 =?us-ascii?Q?3kpJyB6ZXjix4gvzYPVjkh3lwrTA1GS2Tvpt5S23TlCeSh6jwb0mnn4IiFvG?=
 =?us-ascii?Q?xod6kw7z5igr3g34U4jXY6NnRBEs1bN0u7AcPFPguCcBkFM6y0uXyooFZYdv?=
 =?us-ascii?Q?plPPnh++slBXEK33zVjyPwrMb8CJwOlWgwZDRRksJoGSY2iCSjIqvIw7RA9Y?=
 =?us-ascii?Q?DifB3pWQFsSz5hbuHuKIMzs7rtqvs5iqwyrVzn5tP57V9YUV7JcLSTPep8Y7?=
 =?us-ascii?Q?qwv8zFHFmwQImr39TLT+HbB7xPeP3cSiCKOGVJkofiQeTqHStBB1Ym/aw9DZ?=
 =?us-ascii?Q?BFksVW5VxlPPgLCLzoPerd/34fp7g+yT0E6Q9db7hoR1OpOa7A8v0+QlFb4t?=
 =?us-ascii?Q?ZdfT09vE/AIYcYvmEoR/Nxla?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uGdLMdSWumCh1Phr7WSah+ondT+dXp00rawzsVEkEHaSb30/nl9Th+r2Vvkv?=
 =?us-ascii?Q?hF/nGixrX+XDm39GaN8PpKtWg4OPnbz3sIKyIaS3kZvcICLXeNPYztPm9O//?=
 =?us-ascii?Q?7h/MaPx4sk01vDhcCqZhldk1VzEfNLgKncOmOE1qG8BjDN6P3J6Mz042BdOh?=
 =?us-ascii?Q?1J8pJTIZVBij3GyST6O6a8JTsPtt46QXRtHk3D6udYB/uh+A1U6NOxkhWgPK?=
 =?us-ascii?Q?12bxqF3tmLZnF66ikAi8mpoQvanVtqLP6tQ8ldcZtz7nqrptOSY7smii3uKv?=
 =?us-ascii?Q?Ll1F/fZmPofpP/55tP8jFFkU6o/ax0AfGx7uM8a5FTtZyNssFYN+2idOQHxl?=
 =?us-ascii?Q?mOGSjRDA5yEswSvy6ACRq9s2aiVDlysTa1hJPMQqweb1shUeUCyxj+if5Hb2?=
 =?us-ascii?Q?cS/Me6xRXX6Wc+b7nbp9N2F/h35oHgjMX9y4r0Wnwj6jJp4EnIYqmZS3reWo?=
 =?us-ascii?Q?BEw9tATClHMBGCi51/YWx0mHsyPudpRlAAIjrbNcFMnvaTTyqbvtzSOqIcKY?=
 =?us-ascii?Q?29bb3Liuov4OmOs5il64nnJaipLCAoZdLACQQ5mzuoNCwf/iR8YTQknewFsB?=
 =?us-ascii?Q?ZSaGIbPnPr+a2lpZdlQuwGi1p45ELPVRATYmt4kQN1zecwfgrA+bbGKi2apM?=
 =?us-ascii?Q?S44SN2Jd5tQ4IM6VynYj+q8REGBcVF+AeMi5VGnHhij/BLAfRXO+09c87kBK?=
 =?us-ascii?Q?JdzEF+ATc/EIHR1GF1fZRNRwTNg5Kyfta9NsjM1oFmovvLjlYvEhyaL9Caz+?=
 =?us-ascii?Q?HLwsOY76THDPNqrqBqUJREwSVcOhTJzpn06w3/B5nmsOF6JDY4u2qbP1ILK9?=
 =?us-ascii?Q?TtrjJ2oZFY1Un761qLJrodGEPn3GlmdZoenIYGKB2nxU5FnOk93Y3190Bfgn?=
 =?us-ascii?Q?abTA0brhjqXq4z8nglbCENpEyb/tbibfjvg4uCb6YfdEEDpEMEdXrK+26uHf?=
 =?us-ascii?Q?rBP9rhhhMRIz5Zfb0/CH4SEr5LNrnqF7VLJ5R0shC6Lc60McEDKnF8Lz5EpE?=
 =?us-ascii?Q?ERVfDL3G617ACKog7EruD2Jt0MwICKRHFp8FXyeO4gC8G/Hiu3GdG36aHh3q?=
 =?us-ascii?Q?Z8FIm44haNGm96O0+8p1GMaYRL7UJ9UJtyhLepfoOuWLlk4gBUMMlRAr9VT5?=
 =?us-ascii?Q?GOPGIaPybc8jV1RI4VYW8X3+Yavpq4Ddqcl6bDSdCIHYb7wfsDZgQTv/3+Bs?=
 =?us-ascii?Q?+Cr7lqaK6xjh5w9alx7J+Xa6X29wStjEYoR5JUjqTFdBYKrG5ScIWSbuvcen?=
 =?us-ascii?Q?mWF1zEPXDc+3M110LHCUOu6jz7rYQE+BBwkg9lcu5mxVaIH/HL6cGxoJrOCq?=
 =?us-ascii?Q?NqJ8VkRsuCxqYoGzYCfjEYPbJPoXOmMyGMgE5kSqp5COUPgaNvaWJX1PiWNG?=
 =?us-ascii?Q?KZfd2dOxsrxm5Pl5fmeWYPxUznqbRWPkuGGF0oMCI1vh/eW35XhZEwJQLt/j?=
 =?us-ascii?Q?xOrQNerB5Bxx27gqY8QxyVRVfjOezuhCu23/sWNe7FG5SuYNidTRf4beIjuh?=
 =?us-ascii?Q?g7Boe74xY2tTTdc6JRq5xyWN/paEI1g1jTqKPBTM0adeHFqagq5/XP5o+F1O?=
 =?us-ascii?Q?ZGsHfYX76pGdw3o5GXaeTp1r6u804ErVgUKh7HebOa3u6SjaXpivXQI9IP/S?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QufYQ4w0d7GiscAlZfO3Rp8T09QQlJ5dLFBYLROZddMf8bHzlRDFFK2H75fS2Om1sAwy0QtJDu/Q0FPLXPUMDqfS3ue9SO7RICKVGNa8DUk/UovCmLcFSbQYiv6AaCfPE/oZGIaUme0VpouqTF+sy94+pdJhAuw+sh4wXKhEP5OoyahAubSPGVX5U2gxewnIvz2fOQOwnr3NDeF5+HqZGtiOYDw+THEqNwPyt0F2JfyzuYuAjS7vIEK+kaywVaaosLkI5qpHjqmFTTuNFhG1/rnIaNHUuDVEbfTTnQQO1C7PFz44HfbzROz/4qUpcyzhgvDvwAS751qyg2ycAT3sHuLaoVhyHPMVrR57uXAd8Qho2a/yHWHhBRMKxQk9VTJGWkOqToRzINznpv5cwSbXLpKmYydsLat//jdhY2uzG47jKLvlQgV30SqEcIFikwyrbgdlrcK96MUpH1GOFdJcikJHoAmfZraFx2GGBf/OQOOg2OYeFMhOs/2Ldc2APjLJ92s7aA0UQNDQ1yA6QKJtfLfu4W4/VSoNbMvfm8U1UQYwHlvVaVMGd7zYi+gp3U8C1am38Y4m64sJXg+SD3fcoV6yX1KLqWaWAQq3HLONq/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5be9655-a6e4-44c9-96ba-08dd04d18202
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:26:43.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUJb61jdP/e5uSjZW7M55TeaYsiDhj/9pOLtjxEizscQx+4SQqoh8kITPs78jpWnpMxQBeWm4/pgq0xfUglKsyViuoaUGN3Vi6Xfrtkd8uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140136
X-Proofpoint-GUID: FntXMe1qx_2uBy82JPff3CKeoB71MPw7
X-Proofpoint-ORIG-GUID: FntXMe1qx_2uBy82JPff3CKeoB71MPw7

Currently MTE is permitted in two circumstances (desiring to use MTE
having been specified by the VM_MTE flag) - where MAP_ANONYMOUS is
specified, as checked by arch_calc_vm_flag_bits() and actualised by
setting the VM_MTE_ALLOWED flag, or if the file backing the mapping is
shmem, in which case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap
hook is activated in mmap_region().

The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also
set is the arm64 implementation of arch_validate_flags().

Unfortunately, we intend to refactor mmap_region() to perform this check
earlier, meaning that in the case of a shmem backing we will not have
invoked shmem_mmap() yet, causing the mapping to fail spuriously.

It is inappropriate to set this architecture-specific flag in general mm
code anyway, so a sensible resolution of this issue is to instead move the
check somewhere else.

We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
the arch_calc_vm_flag_bits() call.

This is an appropriate place to do this as we already check for the
MAP_ANONYMOUS case here, and the shmem file case is simply a variant of
the same idea - we permit RAM-backed memory.

This requires a modification to the arch_calc_vm_flag_bits() signature to
pass in a pointer to the struct file associated with the mapping, however
this is not too egregious as this is only used by two architectures anyway
- arm64 and parisc.

So this patch performs this adjustment and removes the unnecessary
assignment of VM_MTE_ALLOWED in shmem_mmap().

[akpm@linux-foundation.org: fix whitespace, per Catalin]
Link: https://lkml.kernel.org/r/ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5baf8b037debf4ec60108ccfeccb8636d1dbad81)
---
 arch/arm64/include/asm/mman.h | 10 +++++++---
 include/linux/mman.h          |  7 ++++---
 mm/mmap.c                     |  2 +-
 mm/nommu.c                    |  2 +-
 mm/shmem.c                    |  3 ---
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..56bc2e4e81a6 100644
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
 
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 629cefc4ecba..5994365ccf18 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MMAN_H
 #define _LINUX_MMAN_H
 
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/percpu_counter.h>
 
@@ -87,7 +88,7 @@ static inline void vm_unacct_memory(long pages)
 #endif
 
 #ifndef arch_calc_vm_flag_bits
-#define arch_calc_vm_flag_bits(flags) 0
+#define arch_calc_vm_flag_bits(file, flags) 0
 #endif
 
 #ifndef arch_vm_get_page_prot
@@ -148,13 +149,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
-calc_vm_flag_bits(unsigned long flags)
+calc_vm_flag_bits(struct file *file, unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
-	       arch_calc_vm_flag_bits(flags);
+	       arch_calc_vm_flag_bits(file, flags);
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/mm/mmap.c b/mm/mmap.c
index ac1517a96066..c30ebe82ebdb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1468,7 +1468,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
diff --git a/mm/nommu.c b/mm/nommu.c
index f46a883e93e4..015d291e1830 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -919,7 +919,7 @@ static unsigned long determine_vm_flags(struct file *file,
 {
 	unsigned long vm_flags;
 
-	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
+	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
 	/* vm_flags |= mm->def_flags; */
 
 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 8239a0beb01c..4e7d2d54dae4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2269,9 +2269,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* arm64 - allow memory tagging on RAM-based files */
-	vma->vm_flags |= VM_MTE_ALLOWED;
-
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-- 
2.47.0


