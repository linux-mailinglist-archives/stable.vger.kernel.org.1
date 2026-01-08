Return-Path: <stable+bounces-206372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A023D03FA9
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12239301AFD4
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692462E62B3;
	Thu,  8 Jan 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IFCdRRIP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dzdRwX8m"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D131AA9B
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886455; cv=fail; b=nbPrvWSFq7a1JPVmOCAa+yHk/SOCkf+i9PpOTx1XSdmzap76JXVE4YBM2QwNm1eFZi/upoib5LIu0IFpuN50X/4oAHiw9mjYWPTHVI2b9RNbPqdL07DoOOIhlazs50vcL1GRIazbIhFQos8F/Xs6ANozyDlycmLTNyM4N63YuHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886455; c=relaxed/simple;
	bh=jUMx62PxfkNhJnG7y75cgMeiS3DGaRvMOgQ0SzOTOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sifR3RGsHCYamuHn/97QBA6NOmgyIecZqr2nHQIdnK9RaA92Jki4gyH2fqD7naclV7U8iaKb57jQW/BAoxN8axKftlqEocH4aoFO+0T+jMXCLEA0pPX26Q0rAKkQay43RxmiTPnoOLkHRe/6f1MDi3xCmqGVeh9OxM79Aoq6b/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IFCdRRIP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dzdRwX8m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608F5NXQ796464;
	Thu, 8 Jan 2026 15:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OWLT2ICiHeZ0BAhmLiabX99/Lowxeai7O4puH61qlJQ=; b=
	IFCdRRIPTb1dXU6cvuOlNmP2SrUZM1M6E0MHR3mUt6GVmB3vB7Qx3UurLT31EXXB
	yLYML/obaSI5bMV+kU/BxEkGHTWfPkA0ierRZ6cQvyITb+tjDQafsOEOKqyAzRlF
	QhOW0uUY+1A3a4MMVJzJd8tQLPuwkwM023g1Hc+iiWZ56+uuheSJTgbQw1hO9XJH
	qoncZUiQR6TGQyaIfL9nZPTbFLsdUse5igtCxDHjUYVbXjX69E9Ll9CI5iv+8PdI
	NjIeSYbpyfMw2rgzfObeDPYA7Nl4KEJ7YEVILYaSmcLItniTDAMgBd+h4xWHMFe3
	zfy2MwTHEwswdS6HLt616A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjewjg1m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 15:33:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608EKeUu020492;
	Thu, 8 Jan 2026 15:33:57 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjn81ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 15:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo2icPx03fhakm8j9u7HfK8EPzEfUsAH6tqbqVjqNxc2KSbXQBBdBlBXNg4zPFLGmQpUUzPSeGDpauOfJAHjK2wO+GTwam9pfs3c0m3oGsm4P/bjwB8Q55+/O4gnjl5hAdc/4vUluebWc+/nH8dBCLzd87Xq/GKjse2Sgdqd2pKz5RY7jFUJ9lbgC6NFxFjU5LKN6rWWUxZ/iO+AEMgcE6lUnlGUx6SlvGwxWLcca8HBk1qTPnjszVu2tlx30BJGbp+105mIY9dFKTvXjOymObPcRk9lRy+v3AVIItNVvRSIAex/d+tf5LquTHP0p72jdfFk1SJFvEGqo9v4RC9tPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWLT2ICiHeZ0BAhmLiabX99/Lowxeai7O4puH61qlJQ=;
 b=EIzpDHuP/JqK87u3uFX29gwyzG2KTVi5wV3Wq/EAevNKRMq0OQWa+Z8hxY3PFzjJtVwPobY0gR/sm5F+bz3lUc0cxi2H+U7fwWZUcnspHtF7+4TnvrUhA3lUCjrEBfNxJpRKyueV9XFiRJlusX16FZbz4WxL3A6l64vQpAU6T40FzcstPRySMpjU+9eT4gYDhuu9pQDMGIwyKs1bx+9UIDZQq2FAPUNeasvQG+IDCnY4Uy0oxJxeOgT0p3idSa0tUohXMiEDW6syqotovlh6eKTzbnIaImGE2+2j/ritbtwuxd6h5g0Ek+ec6dWejRm2DlZ544H8KXMkiYNmJdK8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWLT2ICiHeZ0BAhmLiabX99/Lowxeai7O4puH61qlJQ=;
 b=dzdRwX8mmf2D2lH8+0VNnjkeC7sSyaZfo9c/ZjQAeJAsycin9qtcW3oKaZwEfEDj2/8ubmbX1p+bRjMxB+n3bHan8+TEWVpqgfJDJBHLzxKTxL2so3ohljpPoof35To7+8h7/28tQEDBF4FQ1aGQpgzQR9AvKchW5rkERB2bSR4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA4PR10MB8494.namprd10.prod.outlook.com (2603:10b6:208:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Thu, 8 Jan
 2026 15:33:49 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 15:33:48 +0000
Date: Thu, 8 Jan 2026 10:33:45 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pfalcato@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to -ERESTARTSYS
Message-ID: <ux2hd37hjli2fxzovezellikqwpe6ep37xayihr2nzw7llnfpm@lvtkp6pw5len>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mikulas Patocka <mpatocka@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, stable@vger.kernel.org
References: <20260107203113.690118053@debian4.vm>
 <20260107203224.969740802@debian4.vm>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260107203224.969740802@debian4.vm>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT4PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA4PR10MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3fa8c0-abdd-4826-9272-08de4ecb5192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?rQwjh+el6EZDIcR9lYRsS9l1XeLj9yfMX6laUTZQaCQ/JM+srMvORUOJKD?=
 =?iso-8859-1?Q?srbsnArSS4VC7ILsocLSb/L12XBdYU4+doK1POV/cRwYYjJv2pexhS49bP?=
 =?iso-8859-1?Q?zDVSsIyvHBMN1dP/6oBw20ez5v3K/dtUPVJgvZc1pB48MdCjJY0/QB78XM?=
 =?iso-8859-1?Q?xmonQTm5nsd96iWPwywubi/bQnyQMrnfSvyEl2sQVCaI/pd7EvicwKnxEJ?=
 =?iso-8859-1?Q?7djbLufrAgvvNvozuJRL9UTD9agHHRRBRdESMb40Q2piV9lLrGZUTTgJpl?=
 =?iso-8859-1?Q?Ru9kVIQUtzZ1sP2r36GBkcbm+JvgXmzPml14i/D1mBROJSMRbxhuJTnTND?=
 =?iso-8859-1?Q?cYU5YzO7vqaAwGxS5W3iI5ctsG8Pe5HWRjCAtQiOTwUkWHVMbZOrD5uzfF?=
 =?iso-8859-1?Q?ka6RAEuPcitw7lUCYX7lLh3/RYJpkb9RbmAPowOPumt8gF2/6IR0e52VS2?=
 =?iso-8859-1?Q?qazAf2nEGTlPS32Xb/MYusyN5iyAWd1v6OSSlND54hkEGw3g6RpqjTb9FJ?=
 =?iso-8859-1?Q?I7IkHC/IJuH2sziGJfPIh0XmM4hm9sAgofs6vo2Kr1M5T1/0W2+EL/N+13?=
 =?iso-8859-1?Q?q7jxLkXSYu6lhWbJzVo0Ed86hSUcF2ZrK/2nC6LwzrDBR/PwprcH02e98R?=
 =?iso-8859-1?Q?MbuwqmkkbfdU2O6UpAFi7xpXHcPC54q/EY5e5u3NyGZkBEoRabZoJb+OC2?=
 =?iso-8859-1?Q?pVCI/zw5M/ZbzxLytwuFyeW73bzHgxAiix64EN3zBhDit1fq5rW0q6Z8bX?=
 =?iso-8859-1?Q?kvNUmGtqWE9zF2fdtgl38Wirl56exyzz9sciopM0olS09Ot57DEfPDPGPd?=
 =?iso-8859-1?Q?P0V8sW8vfDTnF0dxD3VLTfjcglyyTXwSYUiwQsQdkQ8BegxpBM0lfcxPFA?=
 =?iso-8859-1?Q?bUUxQQ76Nic0qL+hJoJXKc5vjGqxYTp3oc/NtMNkcl0s3zZHm8erjyLBcg?=
 =?iso-8859-1?Q?Xg7Y6iQG+Nx3MKEyV/ApsoPRFrOeASWOh4EdA4JW2QdbQbv4sQfQ+SZmPj?=
 =?iso-8859-1?Q?NMGUatNp1Lk+AovDGtk1BHCXhW/Qea9iXhr7MeTTCsFZBCWU7Y5/kBkaff?=
 =?iso-8859-1?Q?mlKIjfcuaQx1XgwJ6+DzOi3NnQvuaQ4AlY9/dbx4nEvk4OEolkEiZ1Hd1T?=
 =?iso-8859-1?Q?6w62P/ZCNiXLPW5/8deAatfA5nftNXvu+iA6u/TXce+/Io2cj7PjMAerE3?=
 =?iso-8859-1?Q?9aVENZ4Y5xytVjOk9pB2n6G0Yx0UCKvT4kKrXw3FT0kvLZuyPBH6OXKDGr?=
 =?iso-8859-1?Q?fpm0itpPw7VH6DQxwp7C6ezg42/Yn8A45px3M9UX47QdeKwT/4YG7gPeRZ?=
 =?iso-8859-1?Q?Dvl6/bWAiGr8g592T6foTr05030c4xzKKmBdWKwQpEEPfdjm51b+16vbgD?=
 =?iso-8859-1?Q?MRPgi2xFC2L3julKoh1Uq5njIOjxuJ6fwT1H1V8QE1nttYVuLOPQ81qNIT?=
 =?iso-8859-1?Q?2mKAwHeyrHrXnJjUL23sXa59wEivtrDs4wY0gXziwrRoDrFfoWUJlXfC3D?=
 =?iso-8859-1?Q?RrrzP6xHiFkIOVOSnpKvUn4gDiMozxESPAC8lLUBiB3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Tspp4Iyw28Nh3ib7lgDZShXllLR/cAJW8c5TZmz7PM9OqwokK/yUJRVNmu?=
 =?iso-8859-1?Q?6Y8WWBaY/Dt/zYLHCFY+khiQW3lNWiJ6ZBJYX8z05Ys10VDm1H9RzTQQo4?=
 =?iso-8859-1?Q?F9iWdBXoZZqBYQbbqxcRFBd4A9IIOCr2RA8A6KcUea1RgvyBncEpXMzO+i?=
 =?iso-8859-1?Q?2dVLKfkEkJa9SJMZasvVMNinh+YZmODPtEMJxZ81J43j+AsGfguDTVVjiX?=
 =?iso-8859-1?Q?YzyFRyee/TRX41hzGtjemIR4ggFeN++vtgKy28ioGR72tEUdP1E/dcjX6G?=
 =?iso-8859-1?Q?1ExuC1dLbbxO+MqGxSTfrvarwMXtJch365kFvzhrX6vYqz2LKUokx5RMlT?=
 =?iso-8859-1?Q?hNsCO69JkX+El3nSts2FYopKoD/LhSc4CRV0XBRueLXx2o2Ck5cqsA+P/A?=
 =?iso-8859-1?Q?5kLtiEvnezP/7BGWuWUQlKF+55uYvA4u7V0y3+ZMp1XXxG0H7yKzISc28a?=
 =?iso-8859-1?Q?9p5XZVVL5EnM9gPYAjIeMPo84KYh+HlTNOqqFv2e/OUyhfwAqeqJYKCdGO?=
 =?iso-8859-1?Q?Vuvuq6lwDW9DC2ZB6ARjVbVYCMEuwFPz1EsRD3+R7wfK6VpP5DqKM74KiT?=
 =?iso-8859-1?Q?eYtrDpUHUUKpqaL515LjQ1UVywLbk3Q0+aLv8I2agE1GjzYjP14V1u9qOQ?=
 =?iso-8859-1?Q?oDY+s5dxtBppXzTIAsOMLOI2wCJMRrvnRXoWWBwS6Cje6Yuw7orz012z1i?=
 =?iso-8859-1?Q?L1X6CWizc0fDZ9QrVNVDiV00xgZhNIvJT9WfTQD+3BJTRTp/KyJy4Um+Qd?=
 =?iso-8859-1?Q?Prd0OXfKQpsOYl7zKKbDS3Aw4wKHmHLf/mL6IQLcrVoCcbPgaBcljJnaN9?=
 =?iso-8859-1?Q?AkfLwIuW6IRQ/ynhP6Xkc07fSYH9zmsN0JFdF8TpCSpbkf2NxEFre4lD0n?=
 =?iso-8859-1?Q?nNtJ9knV4RcbarQ0CKkrIEE4iYMkCGJW5kSj6IEPlA7RpILTFPZl2zdgdM?=
 =?iso-8859-1?Q?aI/gjUFndpo78cIU+3jTV8sSkS+tutCamp9zZDAY2k4HPB81k7xBGJVjkb?=
 =?iso-8859-1?Q?IBEDlVZdAdKKZUIe/3m5YEzZtNsqvfFQ6IZMqtLw9/dLTSx0U41C1WK4jr?=
 =?iso-8859-1?Q?0+8o6FIOMvUjK30O1I/vSZlx7JlEbgl6bZes75PYKltmDgrcxe6TOVmKxv?=
 =?iso-8859-1?Q?amPaj3Sc4UqI3AMkF7iAKn7NdRc1+rDbLy9Ss8AdenrqU48ZewBEeNi2n+?=
 =?iso-8859-1?Q?DPBJWGjgxRN5N1c/pP8egU484KQMuHmisxQvASgnncE0oJP9cAZBeJFGX6?=
 =?iso-8859-1?Q?mK0AT0Q5+O/FbYb3UGWt9MaAvlEPxpqGeaZa+J2fuHzz5LOfaKGQ/aeLwg?=
 =?iso-8859-1?Q?dEHGhyQYzSkGtvZkD6weC5boCJlkTGq+8jI/mHfIBZvtci1Ole7K/oUvy5?=
 =?iso-8859-1?Q?PVfaCsixwbyMF9Y70/863TMCTWMuoCy2JFC4CD0vJiin0kvLVZgbHzfZNX?=
 =?iso-8859-1?Q?2AP7CMqT04raUqYS1Zst2jH2hvMzrOxFC4BQuZSQNFTi3/0UnYO4uwuFBX?=
 =?iso-8859-1?Q?I49talHL6ZAjO6r0UJV8EQLKPgOIdCoIH5g1UPmtNnoYxGBMdCCBDBnlYc?=
 =?iso-8859-1?Q?uUlH4sWygEwBJKl1BtWTqy8/HzVGULMxGqlLYNFVfoqwy573QmBYYBfaK5?=
 =?iso-8859-1?Q?KiqKwZ3L/eLG22hJIEPyODf84Id9F9magomPjc558pKcB6si1358vfDIe9?=
 =?iso-8859-1?Q?EgCxG8RjSO5G6/R9JAhEbXz/KDx6uFmLeQ6/WiH4iqRashmRH9Sv4Jj8CJ?=
 =?iso-8859-1?Q?LdFnoD+X/I1wiPZbVRaoToKVec5E0G7O1+W00e91/FjMHeTrX/r/QoZBjV?=
 =?iso-8859-1?Q?qdW7J1gqmg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZVVYdUu8Um+fGEwJKQkTmlCvJD/zrKBsLf96H3l//8rJp2Y/fQyP3+1rNY08QFCiKBrWqK0eWdNYtAH7d0jMUoxOVvKJrL5Iw7fEk4Tvty45Vvs/ulKcaQ19xrMaOzw0rq2k1N1ClerYUcT9iZBseY7T2bZGIJVL0LhwCA7IejX4SGyUzU6Ezujbcg1hL2qvCqe8NPv4/qtjqxPQWOJMsRwGteOsMoehz7fX2bphJgxPOKbh6Wcx/PBl4ZzQAlx2GvYd9jXUGOiY3ul1h5dvFczFv1N43zjyZ4dQ3hiE0FhDmwM+3xEQQpPKQUNDxnqGr3C3JzUOYtv27bk3j4dYhlffSPA6DAWYxQkBgexdPuN8x1ULcNOaGktzgpdSJznhs5ojd9tVgKEVAQUacEHSZDlM/xqLIxDDKZDDGgBRHRke3k5YyMG+xOn78X61oXGqeR3C6yDCX+ulrbkg/tDbTWuIl5PV47R9h78XQHH/CV7CC6vwKI43zN6PWDw6BuT/B8f8ZJjzQgvI+Mz8BXVWpe60o8D8gpnIjpsWMpHJXbTrq5P5Z55Zo/SftrP4ScNaEbRTfYZNsuDZMBMpTUecXDRYnnZc4eqeXsoznMoiFAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3fa8c0-abdd-4826-9272-08de4ecb5192
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:33:48.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm0oSPHqSh1HI2s4CEUJ2X6gLavObrZM5f++dzFh+uW6UyTuSEkZwWflHmk1cRqmSsVKx/VXseOFaWCTqDyouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDExMyBTYWx0ZWRfX80UpOdTeeckE
 RRWKaCk8kHU1CAT7cgXlyfnltzl1LYKDlhzARAZFMzK0H4cd3mqJr7lDw8wzVZ7OAWe4myMxzgS
 k7O0ytgAq8cgKnMIbbt1VZe3oHH/llpx1r+cV9YPRVtqCphaVeVWK0XSIhJG5/DML6l8w0XkkSq
 xx+0enFiOM+v/sjm/jTjZQevv/yxA6YbgcLwPdbFldhdOvA+VxnkFbTyitoCgqbriRtJ62YfTRW
 k4rYzevp/HaeelEq/dNdYxratzJs9UEBSNgqhZ6outp+G6cNDoE7aVLEhcu3klM8butsTP6KTnI
 MT7zNFx2sj+Z60UJ7z8A/xCMBXe9SK0ioQg22uZfgcpxDbcHFARei2kJmfUBA/h2XZbCn0RLO01
 /hpgP4Wq+t3QV3GvXXMKyKB2pHDSrqZEAO0azWiaonzIrozFvU1/6lGQO0fOEZmhYic5OUSV9Rj
 TqKPu7+32GmX9Wm2WWZwHbq6hEahl3zsosc9Wrzg=
X-Authority-Analysis: v=2.4 cv=PqGergM3 c=1 sm=1 tr=0 ts=695fce66 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=20KFwNOVAAAA:8 a=EAEhVk079RjGiGO6iX0A:9
 a=wPNLvfGTeEIA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: AUBebbMWdvr0t6TeMs4Tr9gHlaaF_K1R
X-Proofpoint-GUID: AUBebbMWdvr0t6TeMs4Tr9gHlaaF_K1R

* Mikulas Patocka <mpatocka@redhat.com> [260107 15:32]:
> If a process receives a signal while it executes some kernel code that
> calls mm_take_all_locks, we get -EINTR error. The -EINTR is propagated up
> the call stack to userspace and userspace may fail if it gets this
> error.
>=20
> This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
> was installed with the SA_RESTART flag, the operation is automatically
> restarted.
>=20
> For example, this problem happens when using OpenCL on AMDGPU. If some
> signal races with clGetDeviceIDs, clGetDeviceIDs returns an error
> CL_DEVICE_NOT_FOUND (and strace shows that open("/dev/kfd") failed with
> EINTR).
>=20
> This problem can be reproduced with the following program.
>=20
> To run this program, you need AMD graphics card and the package
> "rocm-opencl" installed. You must not have the package "mesa-opencl-icd"
> installed, because it redirects the default OpenCL implementation to
> itself.

What about [1]?  This reproducer should be fixed in the ROCm userspace
library, as stated by Christian K=F6nig.

1.  https://lore.kernel.org/linux-mm/5c8ccd03-9a3a-47c0-9a89-be0abf6c1fb5@a=
md.com/

Thanks,
Liam

