Return-Path: <stable+bounces-113989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C500FA29C0A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B1A18888D0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FCE21505D;
	Wed,  5 Feb 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g2ikgmAf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vxbt9ZTC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDC214A96;
	Wed,  5 Feb 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791692; cv=fail; b=eDjJnofMXhbiiQKskdPflkq+M8Jitv4JCiFguyUNUjJ7InsMna9pVOi0HB2YZT08ZwRvh4w7iPSLrKgsSmZ9XH/uqucdg2izr2y1S1YpMuDBMzL63D3uHGk8dnM8vMxy7cAhXlyPSF+90FcIftlm2f2uEAnLN5rJWrBFSpZLKnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791692; c=relaxed/simple;
	bh=jNABDkuSa/MWGCeoafTdvP7HsHBkPpjnm0rjupuE+lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqS56EVNFvKgmga3GRpHWoeUVlYr8mKUj3Gg8sq6mk13xqXTH2c3tTwmDuhDeI6ozfmIjW8hUmC4IQtdQQS79YeA0n5r72hi2BY3tfxt71SO2im58vIiuL2idupp59mOJNPvLZwEgWVtfYaV1u7yCuCSMVUhUKKps/mRTwkQA9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g2ikgmAf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vxbt9ZTC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfkRc005725;
	Wed, 5 Feb 2025 21:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3X4dw4P3bhQgtveCAughrYZZy96d9QuXBZ++SbijaXg=; b=
	g2ikgmAfZ0edgRsYR2qsmQsTD4Mjai5AOxKuEAa0i5r9zAYzf6Ns+UT3YQErCaop
	hwTEzEga3izPoTWXNUS81E4thhf4eOlmCTPzZlq4Qg7uKK7Xy0whGgF9hra1SzLn
	3qH8Lp7K5TGyfVuPg0k+GvK6TgBtOfTtRE/o23Lv8RXhGLDVrNeLgW5sGlYHBfBx
	ppHMyokz/MdSCVtqoRApWx9RJpR2iddYt74Ev/hFuPnYwo1owqS8/xWqteNJ1KqZ
	y9CTyS8geIEO0xeNyzEpylYw4bT1Q15Juj1ZCMJOdgmYCLvt7//d/o40gAylp3GU
	jOWM9hb4jVlUSHQIEYUkNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m58chg5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JtpGp020717;
	Wed, 5 Feb 2025 21:41:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr08ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK9St+rTzSB/BC/Q87JkRMuVwKDt7mGM5GKjOFiEg+q5P8xNzbgzMXB5gZo3c66wJCSVTPZ7Sr1FMU3c2Zg9CZDNXvn89esbefTZWdqS7CZwQsARr30pIYSzMDaEgOaXyyEDPuUnZirxQWITvhDhWHgdhImUVFOhm5kETVXiTfWlAcwuJ+xtqS6Niyuu8RW6chLGLRAnVDpn8rZ/R4VJ4YenqjFc1A2mmQ+tk+Fiok3SqWA+s8eGZY5Qw64os5JEI6wCAHQg/LZkngqpi0d7ii5qigEU1t9okpOr7a7zvWaEeNQOm4ajQRo2f64SMbzg9CSpXEch2dOafZMp377XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X4dw4P3bhQgtveCAughrYZZy96d9QuXBZ++SbijaXg=;
 b=TEoYW1Tqp3vgFGLo9rlJkfOLIcX4cbQ8q8glxBMcRpVOuqGbPWqoPM1X1EqO0Fi+gvKkVhShos1PaDB1+wVgoPFYYwoHuD1SnRe/FXQZJSQ7oaOOfyLayAM31zhYoY02o6zsi+E1GDgF8WnAm5A2k53eudHqBs4yPjIIxYjvdfc+NP83WzEaxBFq4nc32zf4wGVHaecSENAAQqz9MdfySBfcaZcNm6Xf1ajB507h8KUUaoxNPDo066tiJ8Dj2+lqjFCbX4IRXoYPZ+Imx9S3j8wzjkuSWSU1jshIkP0TipSJzgKZ3wA/MJs1xoWsFqSxzr6tEF9K8EdVMCMOl7VIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X4dw4P3bhQgtveCAughrYZZy96d9QuXBZ++SbijaXg=;
 b=vxbt9ZTCOari6PK7wdUWYkiLLkvvpj40xNfUrUKl74ZDkNEGJL5Bd5sET3ef7LVckZHXx6nDWruy7sxgjGDtD9K9MvF6HDJxZ4bag0CavPZh+b/hdKISdQYF+bt9X2Fd9HIyLRAriFZZ9XTYfQcFcUqeg/B9aQtFWeV7YW0lPkg=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:22 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:21 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 24/24] xfs: Check for delayed allocations before setting extsize
Date: Wed,  5 Feb 2025 13:40:25 -0800
Message-Id: <20250205214025.72516-25-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: c909267a-a39a-4550-2d7c-08dd462dd463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KhGV16s3+aFNeYUTNif4JnXPqerCMl3fmqOEzIeA97cC/oLhChuHp1K1ukDn?=
 =?us-ascii?Q?AwGJXZymGd/R2cE8/1HWljI3xlFB38gbY3xDNJK3khE+XCklhLLNp1F0TPdT?=
 =?us-ascii?Q?iP8rIs/R+fPp8b0mFPDT0XHlJYzaNn1AWoI2aX/upL5AAC2e94UYgJPJZvvt?=
 =?us-ascii?Q?wF9SlUu7UXW3VLK0zYOkIVoegUgwqaUuO1SVzRNydirOPJbccexenwm4gBjr?=
 =?us-ascii?Q?eSNvvwa+f5SV3LL+9grk4h5mo10ex2oggtq4itYoIxCDM4LpPfSpmOqRI6B0?=
 =?us-ascii?Q?3bxVcuuOGXrhaNU1vi9Xy2ZMbSmZIwKejYgNgi0Da8sgJ3GrkXAeSm6sWavY?=
 =?us-ascii?Q?aRP7Cah0k9IKywfCIYRND93iBZyV6FXFk8DA5IXg6R1G2k5oUG9fV6xFDFmc?=
 =?us-ascii?Q?bLeZNBSStBIcY6JuzZQUjFUbKZSynbduz3MGIRHLZzik1LTI5Sy13gUmeD+N?=
 =?us-ascii?Q?o5qZN+/28n6hmLJiL8LtKUJN2Xss/DhkOxuHZu+yVUjXMKq+gT50LEDghKrP?=
 =?us-ascii?Q?NXjRbgLivwYkroKVlIs7rlnNhx97GJ2NU9Um+IiGMl6pZbMyfPwUtT0vamKh?=
 =?us-ascii?Q?HAnqAtU9FGxuOgmfZ7xrehmHpzKCVJ3Y/nFV2FRSmDanSRHcwSg/2YZkRXbG?=
 =?us-ascii?Q?Awf9Aezj6D80EcGZkrAXWhqvosizwyEZhCZA2MbL+gcrJ441lzfjLoK8xF8h?=
 =?us-ascii?Q?gVN8k7G0VEId22Ss4TJib7w2xhR2Bw8tGDb69pLiFf5rfdMjnaJ9rUpghJcz?=
 =?us-ascii?Q?R1/Ojtlmdbt5qRhgOQ32yceUZdMlVog2cSZbCLkCDoO+gjXPLlV0pjQBBrZn?=
 =?us-ascii?Q?lTKr9iooN9fNw0PhOMCEZ86tzEs6ppwJspj8Hxaz0AtGRPf/cVxsGV0jZE+r?=
 =?us-ascii?Q?6J+Z77nj7Rqgxc37TLXfSj6wzRB3FfnEBrCh3UMA6UAtOLZMpchV04pLn30o?=
 =?us-ascii?Q?vSi/KZWX528RZvX5XL5m18Zm75r1UlmVbAcMOjHYJA/nQ7QkBFkTyehONZ16?=
 =?us-ascii?Q?7GyKgJaVUD1OF/RIZv0hHqNBdTcOZu4cxPi2LoJyIxPs/j0tKf9/n2aLXVZs?=
 =?us-ascii?Q?OuCk9+0/2kMGEpObZOanmMxVcIJyMVaVIqgGiS7zy+sGKDHtsg5mQJ+qXTbz?=
 =?us-ascii?Q?o1002ndgkuAcHfel6FqrxkiFkztgwVStSQ7ugAvYCOLamQq4eIs4BqgP/WJ/?=
 =?us-ascii?Q?Bq2wVXJmUjOwe/UxUiYHN5jsscm6pyvRsA4BOyuXiW6OBDX1Zs3MxFZMEgLD?=
 =?us-ascii?Q?TTt9RngRFGbG5zaEByhzbw4H3KfumsV2IxU8i3eOX0/4WN+p6jSrSe7WFVp2?=
 =?us-ascii?Q?OJSy8j2z/5hLEqg2671rGUKFdeO7f8K6XaxnZ2pkwC9Dfc5iz1vGsj7HOFYz?=
 =?us-ascii?Q?Wz9dfWGC2FwHgAxNdVDrWG41xOqX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dRFJAhqHHZsJjHV65tdssxLZhfbr5eOQdf3UWR/RWUrclNGMvZ0jeai90RR9?=
 =?us-ascii?Q?u1jMI7vtlWeoUuiyeLPndLo28LDmtYtFbBHIzQDxNfL0nnAHhWfFmOKVmYp1?=
 =?us-ascii?Q?xagCynVJ1Y4zSWSTJdovpeIsNby0UHr0aOaCq80qMoo/5nyc+D6c8KSOCHZY?=
 =?us-ascii?Q?7wF5vSp7juv9AMCzFMwbvn/1RngOVfEvVc4s+4VeLvxCdqq38IFx+Y7rq3+L?=
 =?us-ascii?Q?I5iHOMN1bDQuR21Gr+3FxE8gxIKCgA1rxKO3Zt5zkus34Ir/nZgTlzygjIxP?=
 =?us-ascii?Q?QRxWxWCNKAsMd8a25hQHmnaYGp18bbXVyLKUhZi8IX1QFFpKd0F06EeLiYFT?=
 =?us-ascii?Q?5/H3o1hKyjww5zzSpR0XCM8ttRnj/vmbPQZUNlFDp6HYj+JrIZlSmPucK5Fz?=
 =?us-ascii?Q?ADXZN/GcIh2wung054dnlXY8dXadqj7Uid+Bq7VuP8x4IrihYVO5K7jcBCvW?=
 =?us-ascii?Q?YiM3c2wTG95mWB92HQvfttnPDJfYNQ2vSnjwOjabX3l2TJe8WxomIpuPcwfW?=
 =?us-ascii?Q?D38OgQ36/fbKwnv22Wx9Ld4F3JHTSPtLEp/x6jm0ik9aku+CFZfShhObiFem?=
 =?us-ascii?Q?r6dkd7ckcV8lGI5r1jD1p2UfDPRumj+gTwDHKvSb3yZzgBHvEWLYDn8u6pER?=
 =?us-ascii?Q?Te0n72KvMZc/w1cafcn0/PGQxdxH7mGGZe1VzeNvFmE7sTI+IaSDFsfqu4QS?=
 =?us-ascii?Q?X9wXJPG/0tmn1x/kZiZVaDqaLTZDPh3e++3AKtHGid6PRSfZiUacoLJSmK1x?=
 =?us-ascii?Q?xRB9AxLqVHBcmyI4OHSV2XrP5vKBlmJ2F5CVFVGmTIhBqm455p/p9Nk2dcOc?=
 =?us-ascii?Q?0WazFg0iq5yA67FbtWcxV5JOnIkWmRiI9/xfrr0L4fn/oczpzfskqem7qIwW?=
 =?us-ascii?Q?A3Cz9a8xPid5arYZSwuT9wyRJ3mq5LFfB52nT0o69BqI+hyRiGj8XQd0QdO1?=
 =?us-ascii?Q?o5TfU4LMlZpezHgmyZmRFMttMv5wtkngwJHc+6JE2DKKzEczy0uMhPtCNKcb?=
 =?us-ascii?Q?+0E6ttINOwdbQXN+TzbEZVRH6OpU9WUtGnwsL/9Pls+d1MtQeujfeXHEchYp?=
 =?us-ascii?Q?feM9MCfPok+DcFWV+4VEZ82s//kn/OYQ7NdKtVzY3ReV8Z8rWDdKqIAMmhuB?=
 =?us-ascii?Q?I/lH4rR6158uZWcq90EelCPDAGIFNeF6Fieu3Yeoh6loRFVjiITRD47JoMo2?=
 =?us-ascii?Q?zkXBL+d0nui4NerCZjjaR/RZGaGOX5NlTKH2zryNR30ONc+JKtZ3+33YxJdc?=
 =?us-ascii?Q?TUmUpVCHxXJirp2q/6ZIL3DN7OeyyZo+ZJLUbIdKkhVV3pPhxJ0lMPgS1a9B?=
 =?us-ascii?Q?u2fReoYDNULBXTHbHBjPVj5WhWPdk4v865TxS9kVu9GZ3qYXqKZsCe0htwEs?=
 =?us-ascii?Q?Q6kl5Uevw0LGEyY/0RWW3wwU8OVBEM2nGwfJBW0ihBtlVelcKT6F5CcPvtb6?=
 =?us-ascii?Q?/pO5IiQKwfGO8u/9939+FxQSL6yMd1LYZMZEYHdgPntQ+gqrIfbwJ5eX5Oyb?=
 =?us-ascii?Q?8bheDZxz48Bcq4t0u2EosAkBgMLNBcNkIHwCzynZVukkza+8NDTPoU12aOG+?=
 =?us-ascii?Q?ehUonv967HCSuDuHU9YjBpKJVhTvHE1WgWb0tsXxyvnfPEa9fiexuSZZeKNO?=
 =?us-ascii?Q?krG4LHiADV523QJJwA64Xm21TfR+k1vZeZ/5PG+AT+luRCMtFv9tUr9zByfB?=
 =?us-ascii?Q?9e9+CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HJO3E4pP4iK3Vrjm+doNw5JSnm2hBJxynaO53DOlLPUil8t7ZG0YK+AjeER66HsBZ5hXH6h93iZk6RE50L5x06svCylZJ+NHYqW7bl3EpMdQ2NdcI7Sta/Y8C+PSggoEAldaRkar3cW+SH9x+KBQrZ1jEbW/dobMYZF3tybrWLamqD315VWWiSmXV/31W1VWgd2bHrzElCGD5HiTTw08+A2ktbCVhPhnx6GM0Z17uJ2Q4rp6nVSxmKp663v+Ni1cAF0JROXKGJWiTgwqmryNZzRUlk6WE+7dlLxMN+iKD1qTDRQIfFSpobIOIfKV16Qi/4o12UsMXw2xO3mn8M9H37DfeeWW3jBEqQS2F1td/0mfT4I808epTR3qXPZmEtzx8JWgvwK2JlHZQYO6DWdylovPllusUFFwiXpc+NPAQoaoB7ZMew1F8shfQ8v84qYUu6EjEIuMtrbGPAkVa1FA1qhZsAP1vcAc8S++XGLpQSwETH9LSP2TlAyZU1Rc1lYHIQjpxdfzCfOV26yl+CfVvxe6NxUnZCYGduqSra9E7JB7/JZdS7/4XrlHM7amZkPM81aDj6k4WCiBqnqsQb6zQJw58S1zjyNFRxzyPIPnPLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c909267a-a39a-4550-2d7c-08dd462dd463
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:21.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXZ3aPMi7uHezjav9EhEtoNFrKwasG4qh3xLCqW6ptfyDUMmDTQaljdnaTYnUy4xZeMz1GSI11tovS3MSsr93HYe5TfVPTc0Cd38HUSOWGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-ORIG-GUID: HSG8FNixeYt0EJjsUN0beVe6HxH0OgPd
X-Proofpoint-GUID: HSG8FNixeYt0EJjsUN0beVe6HxH0OgPd

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

commit 2a492ff66673c38a77d0815d67b9a8cce2ef57f8 upstream.

Extsize should only be allowed to be set on files with no data in it.
For this, we check if the files have extents but miss to check if
delayed extents are present. This patch adds that check.

While we are at it, also refactor this check into a helper since
it's used in some other places as well like xfs_inactive() or
xfs_ioctl_setattr_xflags()

**Without the patch (SUCCEEDS)**

$ xfs_io -c 'open -f testfile' -c 'pwrite 0 1024' -c 'extsize 65536'

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0002 sec (4.628 MiB/sec and 4739.3365 ops/sec)

**With the patch (FAILS as expected)**

$ xfs_io -c 'open -f testfile' -c 'pwrite 0 1024' -c 'extsize 65536'

wrote 1024/1024 bytes at offset 0
1 KiB, 1 ops; 0.0002 sec (4.628 MiB/sec and 4739.3365 ops/sec)
xfs_io: FS_IOC_FSSETXATTR testfile: Invalid argument

Fixes: e94af02a9cd7 ("[XFS] fix old xfs_setattr mis-merge from irix; mostly harmless esp if not using xfs rt")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_inode.c | 2 +-
 fs/xfs/xfs_inode.h | 5 +++++
 fs/xfs/xfs_ioctl.c | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 6f7dca1c14c7..62c3550a53d2 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1755,7 +1755,7 @@ xfs_inactive(
 
 	if (S_ISREG(VFS_I(ip)->i_mode) &&
 	    (ip->i_disk_size != 0 || XFS_ISIZE(ip) != 0 ||
-	     ip->i_df.if_nextents > 0 || ip->i_delayed_blks > 0))
+	     xfs_inode_has_filedata(ip)))
 		truncate = 1;
 
 	if (xfs_iflags_test(ip, XFS_IQUOTAUNCHECKED)) {
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 0f2999b84e7d..4820c4699f7d 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -286,6 +286,11 @@ static inline bool xfs_is_metadata_inode(struct xfs_inode *ip)
 		xfs_is_quota_inode(&mp->m_sb, ip->i_ino);
 }
 
+static inline bool xfs_inode_has_filedata(const struct xfs_inode *ip)
+{
+	return ip->i_df.if_nextents > 0 || ip->i_delayed_blks > 0;
+}
+
 /*
  * Check if an inode has any data in the COW fork.  This might be often false
  * even for inodes with the reflink flag when there is no pending COW operation.
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 32e718043e0e..d22285a74539 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1126,7 +1126,7 @@ xfs_ioctl_setattr_xflags(
 
 	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
 		/* Can't change realtime flag if any extents are allocated. */
-		if (ip->i_df.if_nextents || ip->i_delayed_blks)
+		if (xfs_inode_has_filedata(ip))
 			return -EINVAL;
 
 		/*
@@ -1247,7 +1247,7 @@ xfs_ioctl_setattr_check_extsize(
 	if (!fa->fsx_valid)
 		return 0;
 
-	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_df.if_nextents &&
+	if (S_ISREG(VFS_I(ip)->i_mode) && xfs_inode_has_filedata(ip) &&
 	    XFS_FSB_TO_B(mp, ip->i_extsize) != fa->fsx_extsize)
 		return -EINVAL;
 
-- 
2.39.3


