Return-Path: <stable+bounces-92122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FB9C3DA0
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4840283598
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70B18C32D;
	Mon, 11 Nov 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k5SdbJVR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o1lnGgJ3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA0189F55
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325394; cv=fail; b=jw9Xx3al3qNvgSLCdAPemn6Z3flEf+QxopWd5obNhF4R0eGMtbvk66bThYOAXvdPaI5EeNPl5ltiNUVf83jvr0NiOqLxCushjVkD4R1B6OcaTED1jtRTB4ho/jIe8BD8ivLZt9OEduJ9Zddo2KepbBuHmWb3tnPoBALOp5kNJos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325394; c=relaxed/simple;
	bh=NPyszHr03maWT4B47FShpy53r7Bpr6xAkaxezW5Tgys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jl7ztF4sfOVqRo4g7s8JvMMUpd+KxO560pxSBZRjq6uhEY7KGGLRGGGPDUWLy7u8ovHA2/BkT/lcDzrAUfrpasFzeUK+dTITtOLdePdWXTTmrEORQEyAK2wg5pG1/3Davh5vftWlu56VULeuc7uNtzjJC686M+D/As8T2gqbmMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k5SdbJVR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o1lnGgJ3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9srtY030180;
	Mon, 11 Nov 2024 11:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NPyszHr03maWT4B47F
	Shpy53r7Bpr6xAkaxezW5Tgys=; b=k5SdbJVRckgaeK/J14BZeuE+2EfjhporlS
	b/PYvPzIki+jLRZ0eegPm4qgz635z9FL7X1wvjgx2WdR6Fpq9pHvex9eKm9AycOV
	DhxMbJIhUM5ZRT+Yohbh45wbDFYbikzkEmKlU8MpdhgKTbn0D/IZlqLjJfncB3eZ
	TMOEHls2ZIVrSCiu7LwUkfNRuHFPtRD8xNzjsnd2EJT15/YQhYawBwOYSR/A+EeP
	7NQmBgIc+Fobe2iGTpwyrJg0WtFw34Q6IrtMLN7qX2AswJxlkMRHBq2X2xBXYbOJ
	noH2Dr8IwbwhOExp3Oqso06d8IXwB5G2N2Yc1Ffao2SKQnbQJV2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbt8w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 11:42:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABBB5RJ026442;
	Mon, 11 Nov 2024 11:42:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66u5f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 11:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCPuugkilytW0jJyIjJ5OkLMCTUExn3VERRjsqCPGNksuUDdE0LxOnByQbEIswF4UEqXRlYBOcSJYDmPBhCkfKQHi4qhmqcHThxUr5pJ1wWJJNQXgq5jkW7d4+lrDobmqtXmwjhsIzXrbzXT3lf5oPtrQdAuTPmg7hoMBLXkucz+oc2rJFQPxmTbFniWXvurSykufLpHW3yyuGEhOywA6Y8kyqZlvcy3nBzV0m3ue6MNDtlt4KWAJyUIYodM6Mh1KRKrVRbkwIdgmC12KrsR9pZrf5eB2imu5PwAlpPLPdS++cNpdvBXoA1B9ZbcYpv5i3W4ChGymRUuQu2YhpiMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPyszHr03maWT4B47FShpy53r7Bpr6xAkaxezW5Tgys=;
 b=RrTkwX/TrTeRz/Nnd0vMJppP3TvvrQ65Mo31f4gOSJi8z4W/WelBfMivcjB9llwy2RDacIXN9TucDqf6NPhtvdBEBxzOJNnfQSD959iNCikgkTHzTRUxOzq20HcvUNoyPw3wJCE7KAEtCz1jrg8YkP4DEP5Msc4LDy8gi9h6v52ULlMpjYei/+IdmNqZR+7EaRTjB4dN6cCH8EenXAOS/+9IVV4A3HP5+A51aZQhnIXbXWCEM+q3E4KgWPseOM6NMvSTmcWxzqnfgrKdNGl6NzaTD3YDRRp1ldkHhv48lpDJoJNVDzcyPePCsA9nS91rUsJhgEuEIs2P0phFakdlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPyszHr03maWT4B47FShpy53r7Bpr6xAkaxezW5Tgys=;
 b=o1lnGgJ3LEyuZ8iEy0V25CD4WWaPgx7sF593zLr/EVdFKFj0C9dlJ7wGvqWT2b8fAvTi+VpjI/jqXdXRz87D7jm+IHGYLOYIkTjj2BRr73pr6Dm7iiClBMinV6fvHZV6exHU5LMus4t9Iy/6HtBhvH43POGsxbBK7hbbdCzzpfQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7734.namprd10.prod.outlook.com (2603:10b6:a03:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:42:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:42:49 +0000
Date: Mon, 11 Nov 2024 11:42:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: gregkh@linuxfoundation.org
Cc: James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, andreas@gaisler.com, broonie@kernel.org,
        catalin.marinas@arm.com, davem@davemloft.net, deller@gmx.de,
        jannh@google.com, peterx@redhat.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org, vbabka@suse.cz, will@kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: resolve faulty mmap_region() error
 path behaviour" failed to apply to 5.10-stable tree
Message-ID: <02fd718f-76b8-404a-b5ec-97fd57b7ebcf@lucifer.local>
References: <2024111159-powwow-tweezers-dc64@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111159-powwow-tweezers-dc64@gregkh>
X-ClientProxiedBy: LO4P123CA0612.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::6) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: b427b357-77a2-468a-6078-08dd0245f734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zbr5kfD+sQByay/N32dh5Z41iiK6qgsFq0bD8cUItn5UEomIyTQ3JIRF5bT6?=
 =?us-ascii?Q?OtdQo5sDpx/JD1EJHqai6xZ0TiD0pSc+JaRmUk4Wc0STp0IX2stwmYFrTkb1?=
 =?us-ascii?Q?htUOlhA18n9jZWAVzYrYfzUUjBNVtvSayAoZLjJPmi8EdnM+VxOb3OZH89V1?=
 =?us-ascii?Q?UnGpF2Jy+dNyr13/BJsHSifCVpfmu9oRdafrc/cgndtI2G7e0ymENSa1XouY?=
 =?us-ascii?Q?wh1T4e8+SdthLjwcaJ4kmKiP23wgd6De7jFLd93WsQ+eCDPmljRTjSg9GKQK?=
 =?us-ascii?Q?nhO69WmuZdjMUnXs7tt3YH7RgFAJb25sqCwbb2VW+3u7pk2wl5/qTiotLcRp?=
 =?us-ascii?Q?YRbxQnfOw6LeClxeCgXCTOOwXX1ZXZ7NcEFGYUX+cxRl0aVznbhw+RmRShXC?=
 =?us-ascii?Q?I0gQ3my1iOTCi7uxEe3IPF10AG5Z7votPVnjTvAc5BCTtw0IscNVaPkPcU77?=
 =?us-ascii?Q?j8XMfgisc39hIO04SMxpFIFLy85GtbZomuSKFhitf4lpxBYT4TtobADN4wRa?=
 =?us-ascii?Q?nW6x+S3j03ql2oy38N7M68PW/9s9DefbDRrMJbesu5VGiP/O16oOeZro2gmJ?=
 =?us-ascii?Q?TuBFZKHMvL3rfZUSGSVtA5xwrVlchjIsrRcS0DI5Lq6i93qeNcCIEIRkXglt?=
 =?us-ascii?Q?LRqIYBCVaUBO/pDM0coCPnpEmhXVHCnonm63FsOcs83mNhFwCocexgFwGHsT?=
 =?us-ascii?Q?0sdfPyJrLx882A/FajkcmJpgK1gF00IJrTqISbrqqBSeMcRC8dVqwNpuCj64?=
 =?us-ascii?Q?zvjFj2T28QP61CEbWuVSMs1X3X5ZRtLXUS0zjcVsOogbMFzuIdaOTyCXHkyn?=
 =?us-ascii?Q?Bv5tScP8+G2vmLp43JRYjGDqa+7UKlaxsKhTNWtminzDBYscBSGXjLrvLxhH?=
 =?us-ascii?Q?8UWzPcMmIF66o/TnOz+ryqEsF8omnKHWeVa6VdQe4qtCdd2aUfXrKPK8sf0s?=
 =?us-ascii?Q?foaAp2V8IP4N5Gu5/tj1XwlKQAQZelREoD6D2WenR0CtSWBwcw/ITqPCUxfe?=
 =?us-ascii?Q?4xUBUNvWnKdQhwliV5iFj7R9t0u+UzoFy0hkNnBMnXmuc3VQYe9OC2fpdipY?=
 =?us-ascii?Q?N410vex+1PSpp4oCaNn82jnovmsHwOtATSRqU3G3z3FBjuIFn3F0oWibssEZ?=
 =?us-ascii?Q?cWw/egpNAEfBD9IPDXkPtZx+b/uKOj366CFE0kd5xF2+zWSPaBds9VZZQJhQ?=
 =?us-ascii?Q?BMpaF1iM/zBCMkojxasm87dBkVQp+MCpfwnUY49/HaZJD/Z4wAEthxsN92nJ?=
 =?us-ascii?Q?vGWKta09hw0CaPVf7CVoPzolm+X3FMG35uebc4pv2qVM3CY+mY4NLlpwN7Z/?=
 =?us-ascii?Q?z9FH2H7Uk3pVwOvitXJz3V+7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dT3eif8jpFttxRbaV6mHE9Cyn4A48c0ldEVkyX2uwdtIDbEdAiEbOPN8bRf?=
 =?us-ascii?Q?EHs0DyIyfGKPQkgh6S3r141sni2EOiutSGZ4tNRwZqz46xttgesiIEoCRTtD?=
 =?us-ascii?Q?i6CT+iptiIXU2Iljo14uMTVZZOVanfMVuULBzS/SZEoh+5/fjWwKkk8wg1zs?=
 =?us-ascii?Q?SbQVGEtXlIsZoexv5blkfyrxIKD9rdMcdvyWf1DwBVUZ4kf/F0YUCpoi+xUQ?=
 =?us-ascii?Q?FDPTLICi99XzXQ4w0soyg3k+DLZkRVqPfRRorVrIZ59SqFeYx2tkzX9T6vg4?=
 =?us-ascii?Q?/zq7MT9K7mxuU9XS3aizlBYqr4OjoDjKU/g7oCMCJ+mZU44S23JmdCDzCOZn?=
 =?us-ascii?Q?sD4AqO34CtGUHJbYmjMOiPIJpKU2cKEmFoU4tnLUnEbuykV60S9UAH0MLeyj?=
 =?us-ascii?Q?K0bvM01wUo0RlsKvmUUtke7DWXelviShh7CRUOv9taEAV0q1ZzTpErO6nN+f?=
 =?us-ascii?Q?KIj1iHwdzAc21wjpCQnyhyWDBHh/cVcNVSPSj/gsO7YPy6I/MNaB8xDDP05/?=
 =?us-ascii?Q?r2pXpdTv3DE8sgCJUTaG3ISmZCngYWYSQ51aKUdw33sIKdH7EpLfRBBNVcpK?=
 =?us-ascii?Q?5pAyhlh26ObrybtCOsz5MFCS21hk7P/o+5Wou9QHgCq5YRWTH2AQqgbJowwj?=
 =?us-ascii?Q?NZfTA6bXCj/1QTtYSA+0pJDXbVvv8HcK9UKBI59a2xI0m90Svoj3pI0sgEcp?=
 =?us-ascii?Q?ja7fRtc7sRuS+XsOR8Qqqrs0mJ0bBj1XqdPzOznQ0VBrOYc9SkgRUGrW9MiU?=
 =?us-ascii?Q?RVL45AdgqLZUGX/H+Pav+DWJDatz/ilYD0AFMKlirBtJT8jmnQyyACUsXeLb?=
 =?us-ascii?Q?lGgEkGBpZKLUVRb+Wuh9L+/8gStcXRb2f+KAcXdjsdqgmlJG0ED6bJ5tGXyQ?=
 =?us-ascii?Q?Ykzj+L3SHyh9UVPSMfbV4d0sJ618ohRRFajEzrBDbIhfalhksftktYE3z6Vo?=
 =?us-ascii?Q?YmcMMaiA7OEugWcbiTlvVf1N3mPm1bG1/sPMRqFgZtEJJXcCUt4xU8IAU4l0?=
 =?us-ascii?Q?+AnmhqCHkQOOm6g/ZzSmmoxWTriFMoW9y+2rYDmMPaKqEycHmFpOvTx2P2IK?=
 =?us-ascii?Q?cQKqFFMddXuuhm5kxGOtd55s2HWEAHsOptWp6e22B2/P4qXuW6/gpfPuudg3?=
 =?us-ascii?Q?m9TNcwxBQbnFDI3Q0MV7gHtnJuMuim84UCB/wYSEe4ULi4JgTGrutt+npWvD?=
 =?us-ascii?Q?A3ZXzA56+HWLm2myCSBowIVNKUrrnVSDMiiycR3NIg8l/KFZ348mfNh/8R0x?=
 =?us-ascii?Q?AXG0NtWFXZMP+dMgfHLfLZE4rxg8igf4g1ZHWUuvP97Iqppp4qpoUXsRsw9w?=
 =?us-ascii?Q?jWg0q7/mBM+CnFADH+zn5S2fWeNKido3XvcNbWXr5aqteQgOMucF5k/8i88G?=
 =?us-ascii?Q?cJ6fqsMomPUrM0DFpJUtkBQ/neClc6H19odarKmI1KGFgJqkSODzdHbk2WIv?=
 =?us-ascii?Q?GVwwHFitdKK/tvBhSPvMPHBLQpsJE7MgLuYT2+MJIeGY8zEnnbM7BHRDMVsd?=
 =?us-ascii?Q?iBFCP+/pLvmt9KDNVJQX/QbJ3mEupREI0DNE6s82m/NVLJZEoZfd//4MCrbo?=
 =?us-ascii?Q?hY95wHRpcET50og2QGo9M4VXZQFvsjaAWvl7sMlTOljw5nS8HVwCTLXAJ1Sy?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V6Ga2t75HS57Af1iH5DkMlAwN5Xv2cGZFjZ5O3RoYvqqum6XEHmYoXSLeFTJCbLfmESaDmNvKJde6iLaJ9joNlFKJH8gCPleibOxrnIq/OUXTVCJy/7EM9Mge9hBDjjfe1OKIjYQeHbXrbLuw47pNXD7Hx4BlXbt/ywCvUIxQhycW9kMKvkmf5de5EGTQIigCknSjKHKHUEESM+me6cqJs/bO2c+NKAVS4KJHfjyFe1ZJ99FSRfLaJ6ll/Zn2MnVKnTEhzUaDCvBkrP9Db5bTdvoePKSDmz7XCUrboIGziloDDrHVoiqFFSsFJwM6WLk5oomqmyzRztoNRN2d6VuYlNpvWGmByOhtrA0m8nBIT5gNc2YwcJCuGBnInfxtu8cHEQU0g75b4i9+e0w0F6dNf5pVgmP5LWzXUVpDQDA+ra1/d7TxAgTdKVMHgLethbKrx4bMKCS2nhgOiRTu7lFKu9MvYvoaa24WVM2qvzue8rBAzuJPeEeH71MINxtUiNvSUiCoMfjuOXVcNOyDeXTemELzt7c2SkzqhxsSXNrMSAm/RR7yKSbDBtsFxMAorcJiaOWKZPc0sBmj8Z+U3aIYUSHG8PFBW2dk/d6rb2CJmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b427b357-77a2-468a-6078-08dd0245f734
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:42:49.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3iFPQ0+vGx+8266uBP8qOCuUYSZP0lhDY8WDranzSsTTEWJJfiVhJPdzhxduzlUXv7kdSABsUOOc/Hw1Y97mLiqZbRDkyi9lbXUG8TsTyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=842 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110098
X-Proofpoint-GUID: PqLBxaHwtmlBDvDQrzMasuK5fyrtCSI2
X-Proofpoint-ORIG-GUID: PqLBxaHwtmlBDvDQrzMasuK5fyrtCSI2

On Mon, Nov 11, 2024 at 12:39:00PM +0100, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Re: this and the others, this was always expected as the tip tree has my
and Liam's changes that previous trees do not.

Sorry for noise those cc'd, I will be manually fixing all of these up.

Thanks, Lorenzo

