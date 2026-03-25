Return-Path: <stable+bounces-230287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CPgCF+ow2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92BF32204B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F329303BD1B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169DC352C4E;
	Wed, 25 Mar 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lU4G3c2Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19D303CA0
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430295; cv=fail; b=t8yHtZW9/11OhnlT6CRJyS3TTONeOiMBlbnlKaaH+nSnTmfmqSoPse8GiXq0kSskY296UcF1TIGFwXVXKiu4TVxIDJpSrpC2KgMN7iN1CdxGeiUPC7SrbjOJnnFbbb/PkY9Oc7bSg6uSuUj29x/xnI5JLlMiWcNvvGm2xFxGMIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430295; c=relaxed/simple;
	bh=0jVbk2IWZksyAujNHCM8j7L47bBlax7o9BvwzqToStc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7RkdSDev9wqom7r1/filoGFqAeP8DZ0T7Zh5Gxc7Un0rmOGV7e4DiGdMvdJ/2tGc1Soucm5xvA0cTyJvOmvol7YXon7SYHpy9deg4cg9E+A8gHSs+vsw4Rmni64cIPxXzPjje4SZWnrhm/j7ZxKURYVtkvI1CQukEQJzNmrCaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lU4G3c2Q; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P65la82107281
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=K4ctpzz3Oe43SIp9zSWNyOJaTdRGmBm0NmSuIkR0hBA=; b=lU4G3c2QOztK
	vEzPmarM2wuUyH/rAsS1o/dYTDqG5iIOcr5D7koVLxBilXyEthEfpUiozpJY+xfF
	Rfn/QxK4VJCt1sEwTOm18dxG6f5KDHXyl7M4vBd4stxHueR4ls5b6sR9KSyBuNfd
	FXO8N+ogIBa1/jYEiILAn6s1M2D3qg/DVMwP7Shw6AaWvYTbtXOO5+Chcik+8dBR
	OTzTyNYyysyeSRFfUwCwuV0m/4Pz4eqiNEW66FrlrtTER+QyrHNsc6zYW1inLhFa
	XVegLXvXdyu+o/PFutC9qTN/suHB9cdQfyqyP7bfyVOuhEq2SR/RfLARCgtmB4Sh
	B3J+IlcqMQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vr6t-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaNP3kh8Pp8WJufIkxCjFbnwfmnyUPbyZAYZYzhLWAzAXHmwi5f8B10EDUt7JTKIWOFWShxooHqfscDM2HEMvLBAs2xrvveOjccJ6CsBVp4Rzjmb7QcBJ/w4Un7yfsandBsS7WH13xpYRzAp3Er/dnMyePEfLNGoNwTwkgwrilTsjy2XdpbPbO9cDNW75zjT9foSa4czCQTbLE51LPcGOvcsPcKjrTJ9du2EBtuL6OApSxaSxCQabhj4dpe/UlOsgUqzLvPskGlpEy3EaMc3PfE4TU0gO3FaD5JQfQmWODXqtckh4xZ2R5IXmyQxokd8B7MkaI4uvLyfTEwSDUcczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4ctpzz3Oe43SIp9zSWNyOJaTdRGmBm0NmSuIkR0hBA=;
 b=a57m+ErvevA+GxkS5rmGvz/HS2EL6csweC+xwRFYpupJJRSwCeaMWj3suyvGY9Q2wjKC7/IKgysXm0LbkDyjQG1bCpQnOVDktTHC2QWUEDWYSVNJaIxJkvOm7EmKbcmRknf2MywZ9weCcfGQLq2v3Gf0uz6ioMReAKw9Wj7kVdjiiFnyZwEs2Sgqn352eUrxfaPrhWASAMSu6wQAuvdCvvs3c+/9asOFjcyuQ+KLN/xhbmm5Q1HO/ym8dQP9SIHI+cNNEVKIXm2RxzCpcmbv0eywP/Mf63nstWfFmYVJZmTqg1rTWoDhB6FzN+uLYoTAK2fJl2kRnOU9UW7eTVgV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:18:02 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:18:02 +0000
From: liyin.zhang.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
Date: Wed, 25 Mar 2026 17:17:39 +0800
Message-Id: <20260325091740.941742-2-liyin.zhang.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325091740.941742-1-liyin.zhang.cn@windriver.com>
References: <20260325091740.941742-1-liyin.zhang.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: eaef7cf8-5b33-4360-f07c-08de8a4f6a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X5Fm5VB8XRiUpTADff6iAyv8b8bKQrqvX/puh/ihmT2Gri1frgXQq19q/8TNe3YdYTSSEDnxEPO/hoveYyjX4NDKaPeMYZ+urocjcSU1Qc/HCeBaN1L+a5oHHlBKH+czGmIrYmCi+e5bcAVJvVl9OSMs0ntEggPxOrRRYznMJARaGkUZxTcedpUtPx+ZJL0T0dmsmRWXsIU5rpGJ6bHGTSXqmOVt9fikgqvR4Tysll34vZvN+anMIr8b7gcnHelVEu7EKEQOoH3vkNRQnoaSKPSr8WMwXH/ElAeh7p2Bq0OgOxQSE9jV6HRaDZE1YINl14+QzUPodyLsbBr7f2l4sc+sTB4pslUXnWYs6t2t7f/lVL33vaczXzOAfpK8/UzD0DJCbUcCCA7gdnlPI8UGPiKlseS8GJn3yyE0STaJJj3ZyVNcKZq6J7tnSSe7O34vo1Z3haPo7ItFGy0sqAZYRT+i4XPai1tx0WvWmCr6tVXZHNHkWqShrjphSSJDVC4ugw5QfavXa/SXf76bgHULdBCPeKs6m8WCXRaJ9NqWNGfximwLLhS2+HUxLZkwwDdco2YbQe0J+bI8Hxta8ALNFBmy9BIgPjDoYiU6I6oznZq6oQ6lMJRC5He8hfl4w76VEDWOjjV6m+CCrdaVcl2RhrTMrji7TJhGFrzaSEpH7UpyXlu6txuHsuPQTWHlejBPh1zUIZ2UkJUcAVc+6BL+Kx64sXOvmNJntesyI1zqOG5FxnCcmP5SZu8UCHdDI/bgqTdxRmZDwVyynt5RDRPHgeqXVcTAfT1Gv4L0OzPRQ9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcY2kJGNXk3bIg5Xc6hqcdWRT0RbOKtEV6/BxvJN16INDSDdJr+U1gucTqGx?=
 =?us-ascii?Q?JhCT2NbU5dLh4oi2EuZiQPLXIZmAwBVXxD/jmhG1NKuQOXFQNxbhSz9wPxHz?=
 =?us-ascii?Q?Ams3imKse13MX9eSWIbmR/BbpwMAyQb3IfmSYhZbMdD89xE0B+SZnaizI46l?=
 =?us-ascii?Q?z2fj9+nhAXlfjWYg8ONHDx5ig7K70SPRsyhwXvmbWpJ9QtaGnXOLojr8daZU?=
 =?us-ascii?Q?fJjWQAatR95cHi7ydoB+oYBvsy9trjJdkSEQCcbZLCBaQetM9HuvIRzwdFBb?=
 =?us-ascii?Q?FUc035NR2E4LutrZbmANrBfUOah9VM03dNkPe/aoW83WVFUXGPHZyB1cCcJZ?=
 =?us-ascii?Q?CulQ37zhiAOQblO3MRRtqsuj9C/2lmHwDe27Px11DZboUVnmRAwM27KZpHgz?=
 =?us-ascii?Q?imsIPxrK7IzgXgynD/qQP/QcvnxGavXwVVBZDBk38kfmIwQn3cFX6io3XsAo?=
 =?us-ascii?Q?m/3hjcjlKfSDvEOzAq5263ddt/vMVjPvBUrPIzwynIjMh4hYdb9Uv6Q4uatd?=
 =?us-ascii?Q?+L0LLSFDaFntOsu2HBNnCT2SXpFvzerXW+p98d2JqCAfBe97i17QuYrx2aNw?=
 =?us-ascii?Q?j4OOxZmHZsMT+w5haUcId9/xb/2RSMUo6mf1XcTFYpARaQp95J2PdKWIHths?=
 =?us-ascii?Q?l5yhfwunC9PMAo6QQAnLmN120r1XCy1gFbL1tUalcuEk6Sv+hIbUR7V//N5+?=
 =?us-ascii?Q?5Ulu3TbTVsQGKvAls9+yM7Tul4ZLKbfVdclOPfkehiH407AIqzUhNU7iRnI9?=
 =?us-ascii?Q?vir0HrXPqR4xWdy0NCsEiFhpua0D76JCUQ+A1xZnFXPTPNzHem9vnve1Drjh?=
 =?us-ascii?Q?vGvKiTJjfDznVUf74s2ouanhLFrInl+wefhKQ7toj4mkeodnnQRfRmN7v9kp?=
 =?us-ascii?Q?I/jFL7Gi8EIHbIxrXNpEiVwww/PTEsDnMdgN7BzGkobEhfj5K4+f/j8zZFpr?=
 =?us-ascii?Q?2f2plBcPQk210bOPQfF+fiLW8Su94xC0YbBNtZhjZ5r+WYk8Z1Px3nn1uLk9?=
 =?us-ascii?Q?+IodEaD2ed9uZHDRXbQZuu/E6tecGcubqof27go0uEXfsEh7Dk+i8Ru5zbsG?=
 =?us-ascii?Q?ZLGVffNnWYiC03eek9XfaDdlKa9vmFe7L0a4Cb27LnvGQEvVVyNFNCo37g7k?=
 =?us-ascii?Q?XPJdeiSWaugXOUNvK4bRkArIvNZSPStejt+EuwZWtX7XnoNylO2Yamputkf+?=
 =?us-ascii?Q?t6qERaMR5tFeIlALYKABMQRnXHXZvUGYzB9fEmPE74M4WlNTdJQUo1pTIVG+?=
 =?us-ascii?Q?GLgNycj413QIGR1oejcCkMjdB1vANzVyaj9lMIwQwKIq2JzaS1kk5dNfqjsd?=
 =?us-ascii?Q?o3+wBbMI/rjbpjr7y+Hk6ZPqk1SoFed0oAsJ327T3WgQOT8PAu+rqHr1wLTq?=
 =?us-ascii?Q?U7pkgPe2I5ABjuuDbd6FgqzNQ9b1IyStlCDlTMI+jH/1c8wzKtzZBzzmyw80?=
 =?us-ascii?Q?kPsORF5vZIe1tmGva/lG0SuErt2gMB+RTdJ3SHU6f6iBSzbVGl1qI6sgFtrH?=
 =?us-ascii?Q?84BsjFJMvFj72j252LgGh74+A44M4IbazkBGKGJTg6Uoi+JvxLSOHaY8GzFV?=
 =?us-ascii?Q?HW+RWl4lBt14wW0BjTrdy1PjXRIUIHQ+HGVZuG+WjjTGxTahJORsHokZgB0p?=
 =?us-ascii?Q?esd/wbQk/4tDgk8HfrCiYbUlWIVJj/hDsMoCWKyx+FzRlWx4sGL7SfW+nG5b?=
 =?us-ascii?Q?gmalIc7A9dvjicQB/5wZXrAZ8XBw0es+3Ldwpnc5nDjb8HYZf1/ybMpHCRvG?=
 =?us-ascii?Q?hGKYmeRJo/eqIHYjTZoAXrqF86ASwvQ=3D?=
X-Exchange-RoutingPolicyChecked:
	c1a+vM9PfwdF3X947WbXsIGq77jttWvn9TDRmjGFt6MRqF6SPxVsnKvYYGvEain/c3XEKXut8TbDPjKMYODYIAyc8Kz/KROAK1mtZibQkSykP/0FznYNbs0Zqjy7eXtQvkhSuqA78WjQRzZRQTa687bmMZ5vxJDD5xi9zbj5ZHrggjuEwxERbNq+CgiNyWcEibni173BIOmYW8x7bRZcRVk/a0FdLhednLCr9jw672plhxlt80n6DtROouTiqimDIVmWkuiPmLpXZXNNsksZmXHgfjq6LaZ937+FeYFwCRcQfL3D5hdpF8JaKqU+PtylNYs0M1mP8G1zCpu1DmIeww==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaef7cf8-5b33-4360-f07c-08de8a4f6a50
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:18:02.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k73wylnn0BXLDIcVGyqdyFkVvX6MgsQYl9p+6fKIxPaYRHpGUHDT//dfH8yxzzMIM225d13Go0c51AmlBmsBXguXqU6nvMHAOOpBTEX6ZXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2NSBTYWx0ZWRfX02PdSSdYJlKS
 bjbCvBiTlxc8Z3+9alGe5g1fo2tRwbvBomOAH0Iy/dzloLpz3CcZE4wf1u40Ef/pmt9vWXcoj7R
 hJwat+Wr7JMMgqFH2nTVdXCj2WtiYJ7LQrU8jpnGD1EJZAC28I9o4V06mojr88uNaCv5LQkK12X
 56s+dqYKa/8J7leNqyZB6un87rvh5LE1ENI7iqWcHIhD8yCTP4de9zb1Tx3FjPv7j01Q2rRXNgM
 ubDZTUzXrybmtUQXcbU8f1i5X/cjr+NODW2BrH8yJEO4BrIR3kqGcKq0sozpOm/z9cj7F/C4HFR
 Y7elaZS0cKIdR20rcdc2MIvg6RKxWlm7CIoZIQ7h/UYNHb4X/iIJF287uIGy3M5laFCPHd8YXrC
 lwMfDowrcIYB/alqKD+ckasrSYyAkz9C8yimPTL/0nOP6nkYP085StOycNDRR/5NaX/s4TuCUAe
 +2xuMjTPR6zhA/+u54A==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c3a84c cx=c_pps
 a=TKURuYQIacZDyiG+Utq8vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=sozttTNsAAAA:8 a=t7CeM3EgAAAA:8 a=Wf9njZRE-XqjpBJJj7AA:9
 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: tdcf7FVXWW2QUkUMRn_iuHsZZbvXum3j
X-Proofpoint-GUID: tdcf7FVXWW2QUkUMRn_iuHsZZbvXum3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250065
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230287-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid,nxp.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B92BF32204B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pratyush Yadav <p.yadav@ti.com>

[ Upstream commit f156b23df6a84efb2f6686156be94d4988568954 ]

On Octal DTR capable flashes like Micron Xcella reads cannot start or
end at an odd address in Octal DTR mode. Extra bytes need to be read at
the start or end to make sure both the start address and length remain
even.

To avoid allocating too much extra memory, thereby putting unnecessary
memory pressure on the system, the temporary buffer containing the extra
padding bytes is capped at PAGE_SIZE bytes. The rest of the 2-byte
aligned part should be read directly in the main buffer.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20250708091646.292-1-ziniu.wang_1@nxp.com
[ Resolve conflict in drivers/mtd/spi-nor/core.c.
  In spi_nor_read(), 6.6.y contains a spi_nor_convert_addr() call
  before spi_nor_read_data(), introduced by 364995962803 ("mtd:
  spi-nor: Add a ->convert_addr() method"), which does not exist in
  mainline. This call is specific to Xilinx S3AN flashes, which use a
  non-standard address format. In mainline, S3AN flash support was
  removed entirely, and the corresponding spi_nor_convert_addr() call
  was dropped by 9539d12d9f52 ("mtd: spi-nor: get rid of non-power-of-2
  page size handling"). Keep the existing spi_nor_convert_addr() call
  and insert the new spi_nor_octal_dtr_read() branch after it. ]
Signed-off-by: Liyin Zhang <liyin.zhang.cn@windriver.com>
---
 drivers/mtd/spi-nor/core.c | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..9937cf3d59a4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2082,6 +2082,76 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 	return info;
 }
 
+/*
+ * On Octal DTR capable flashes, reads cannot start or end at an odd
+ * address in Octal DTR mode. Extra bytes need to be read at the start
+ * or end to make sure both the start address and length remain even.
+ */
+static int spi_nor_octal_dtr_read(struct spi_nor *nor, loff_t from, size_t len,
+				  u_char *buf)
+{
+	u_char *tmp_buf;
+	size_t tmp_len;
+	loff_t start, end;
+	int ret, bytes_read;
+
+	if (IS_ALIGNED(from, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_read_data(nor, from, len, buf);
+	else if (IS_ALIGNED(from, 2) && len > PAGE_SIZE)
+		return spi_nor_read_data(nor, from, round_down(len, PAGE_SIZE),
+					 buf);
+
+	tmp_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	start = round_down(from, 2);
+	end = round_up(from + len, 2);
+
+	/*
+	 * Avoid allocating too much memory. The requested read length might be
+	 * quite large. Allocating a buffer just as large (slightly bigger, in
+	 * fact) would put unnecessary memory pressure on the system.
+	 *
+	 * For example if the read is from 3 to 1M, then this will read from 2
+	 * to 4098. The reads from 4098 to 1M will then not need a temporary
+	 * buffer so they can proceed as normal.
+	 */
+	tmp_len = min_t(size_t, end - start, PAGE_SIZE);
+
+	ret = spi_nor_read_data(nor, start, tmp_len, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are read than actually requested, but that number can't be
+	 * reported to the calling function or it will confuse its calculations.
+	 * Calculate how many of the _requested_ bytes were read.
+	 */
+	bytes_read = ret;
+
+	if (from != start)
+		ret -= from - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually read.
+	 * For example, if the total length was truncated because of temporary
+	 * buffer size limit then the adjustment for the extra bytes at the end
+	 * is not needed.
+	 */
+	if (start + bytes_read == end)
+		ret -= end - (from + len);
+
+	memcpy(buf, tmp_buf + (from - start), ret);
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
@@ -2101,7 +2171,11 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 		addr = spi_nor_convert_addr(nor, addr);
 
-		ret = spi_nor_read_data(nor, addr, len, buf);
+		if (nor->read_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_read(nor, addr, len, buf);
+		else
+			ret = spi_nor_read_data(nor, addr, len, buf);
+
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
-- 
2.34.1


