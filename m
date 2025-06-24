Return-Path: <stable+bounces-158352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4622FAE6057
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1457A89FE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337E27A445;
	Tue, 24 Jun 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KT6NHc3t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JCyxWk70"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2A2222CC
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756291; cv=fail; b=H2322hLIiKwQfvJA6RZHRgZJuahYwGWUg6ceZLg2aKXM3y6evsTgKx28Hrab5y8PxXTv7dXQbyiDKKtmAL/eVIRFypFHgWQooxo3pSvpg2yHjEx2NQp0U8dWzwJflEFSrF3PCYBcm572QixCrCM2Bx6me56iPQuNf0Y47hA49Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756291; c=relaxed/simple;
	bh=VC6oNbnvLjB6KFCE4sLOtPV/f5JRbEMoSbjbWWFJ3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XfJw/vfnO8ZpaeWmeEO4aSguNmrjM29GDyCPZfyUkpH7zcM9oTW3HuQ7QD15kaBJOFRYCmyN7K04KPwuk4L6+pjqYt2mGcnmGcoadgQU3x5cL+yqQKmfvtghXF3is4kdAQgP3RM4EqdbUz/mcGIHeEaNNPEByqvWH+DPDHtkQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KT6NHc3t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JCyxWk70; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8icAa028837;
	Tue, 24 Jun 2025 09:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+fvj+gY8KM4H+4dtDg
	U3BEIfEM80BECt8dCydx6uD4I=; b=KT6NHc3tOM7wae/nwZjOuLkSVZliFzlAhe
	JpD2fl0BbBAkKzw2VQMryqYrb/ZBG/7UvqlKNPKiqHQAJ5Y8Ge+7zqjvUMXZEY71
	/bE94yOmihH/dLFuNjCGRN8jYVn0lE0rEBOfkYBjFwtcWX7soMWK2hu+yCIOwwyd
	04h0hcN9TOlW34J9CTWrk+rsvXypUMlCR78wxd9qv7j2HfXFnv9r9nc8fvBNr4e+
	LV02md0sJHrl0oe5hQNI9fC10Y9rIEJLzox4UIVIpUjkwavXXwK4JVGyWjeP8q4q
	/prf1t8oN+7Q0xsaBCuNc9NOiopiHvcVLZGFCUWFACVXAzJpT8AQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uvp23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 09:10:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8ALoF025253;
	Tue, 24 Jun 2025 09:10:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvvw86t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 09:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyX7SRkNOCv3+QmALyGwuxxkHKs7s87/31jNWCY29nunDljSPAyINgFSUaFvYybe03t7LldAM9RyGzJ14Byx1oUenMJ7mF3lTGSsWe+7gQLvNcqZDiAeSfIIdYaMMcfD7szr2VXj/Y7cThjp4fGAyy+CxTFrabDOZW4VJ2DrTVXi92HIIgYW7qO75bs1SrkSID+6eX6teoil7PugzdeP7GhgnRS7Y66sFyEyi9Ffm/fsTQr+hab1KUmKkJcf58TiXmxeTYMoi+wPZ8WOrnR6/Ud203/32u7G2bivvrtM3vct/zcXKiseDIlwMaWBQYmKYcGkm+HDqHFzYdiCEfh/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fvj+gY8KM4H+4dtDgU3BEIfEM80BECt8dCydx6uD4I=;
 b=Pse8u9KFh6DXeQnW7WyIfy3uWt0dEZ7H5l5oZrjhjITVoyyhkViZ6QIj63OUSwvafRUh/iE7k7NCRxVxmyNgSUyA0rkXEkIY8JzYZt2HkjDyxdRfyEZ1gFUomQf2R6Og+lnC/qQdc0qbpwFaEi30427usbz5R/1oVB/hATc5doU2agZKiHCDHC9OwsxPvGVs/ASFotyP1DFhVjUbmPqMFWqZuvBrCtqCpwTu7/vcJLuIhH6frOBJzyDmINBcjnkVZkcaCHF8aCQUxhtY3BrnJpT3WSgxhqtJQHVxL1cxYPtTtadiJl8c+ZMVbgEtZDJNZX/EpbU4X5HZ++Jwfc5/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fvj+gY8KM4H+4dtDgU3BEIfEM80BECt8dCydx6uD4I=;
 b=JCyxWk70Z5ZUar79H7oXFLow6zEb+gjLyPP5dQ/gglE1nfZOoTWZSoDx6S/lh2a7Yhel/1uHm6+qC/7q9JLR5nKIHTqBsBbq+Nc3SSYUh2RanTt0kNgd1IcXHq71mIxG+Ovu8sUNWRHMNI2EsotyYX+Hzst5OKSqDRhrQKuCAbg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6658.namprd10.prod.outlook.com (2603:10b6:930:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 09:10:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 09:10:08 +0000
Date: Tue, 24 Jun 2025 18:09:54 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev,
        oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org,
        oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()y
Message-ID: <aFprYu5H_ztouxw2@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <4f12c217.7a79.197a1070f55.Coremail.00107082@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f12c217.7a79.197a1070f55.Coremail.00107082@163.com>
X-ClientProxiedBy: SEWP216CA0018.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 795e8c52-5c82-4b33-3967-08ddb2fee9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PVTAQCggZrXsLxym+4aegpr76jAwYQkUuI+0btJVxtA16+nh0SDtpsKvFvUE?=
 =?us-ascii?Q?MUB6BQHDbKAyehu+tjl/aQKr61E/rOkcABCA+QYT/R5pN6rHVgVQsTC902AK?=
 =?us-ascii?Q?EY2dpUAYZ3Y3MfOVrrFQPxNRgps2OmBZQdAgVbeZxiwLivmxyPf9/+UFZmza?=
 =?us-ascii?Q?RBOmuiBNvphak6AaYvWjCGaeFi/S2d3FgnSxZW/Oe3jo5LEtRbKoVAcDqixi?=
 =?us-ascii?Q?MFnBRgEO6+9+Xpn5Vx8JnWtaWQHSPtAq3lsCZX5kA4IJ2dEQ29e5A4z4Qr/K?=
 =?us-ascii?Q?nCqvzMbCOW7IyAjzTwhFQwR9I4Xw2j8PNm6o3rncttXU8KKVffDcW582mLhD?=
 =?us-ascii?Q?tmX+2jLSK387C9mVI+F44IhvUO4OIVhEeQTXbNKc+oZ6cauaIOtzENE8xKPd?=
 =?us-ascii?Q?FAqg1GxD+RcwHrfum3+ExP7nv5NEDv65jTFiki4Q7cWiBdbF4KWZhHcw/b4p?=
 =?us-ascii?Q?d30dssgYYcunRLvoskvWhiBYSF1LGjYYBs+5Rz6WiAtQU9+qOQC1+Bc8EycT?=
 =?us-ascii?Q?qnCA15AbIHs1AbGsEWuogVmOvPC9u/0snzbiXJWrgchuEfZwLKx0JNK+esr8?=
 =?us-ascii?Q?XVBJMOpJQK0que7QPgNAToCdZVO8BdhYcltrgeMFTx9jbjx3pcOcwdeygAx/?=
 =?us-ascii?Q?dDC+J9p/zNP+oMYgcEFNjyH7K0wKTy2jOt9BNWtV7M0RrZlxNwn1SWXZX8U0?=
 =?us-ascii?Q?u90oSiyg8Fd7MXypSpOy2JDKHZqqISUkgOGkZtERrVaM0e2OJrbUOKxXPtyo?=
 =?us-ascii?Q?2F2Ch3339J4/50xdC9RTMIRXlk9OEf57dkp/JIW8A8nH7VX3fMMXVuuODxxI?=
 =?us-ascii?Q?76V8Ufg8pzulMvll8tWnAIDO+Ck2Q6yT8yoD3esRahbNwRIYEolR7fupuJx5?=
 =?us-ascii?Q?W0r9ggDDKdZMVxVthJanvY7N4KUvUpDkzt4HNRGNn48Xx1myqchDT2qlPPX2?=
 =?us-ascii?Q?94AhRnZPG+jA4Y4x39gnMPZIY6gZoqn/kZ0wlQ4fL0Zk+FzWUP+vwdJfr6RZ?=
 =?us-ascii?Q?/Q750rJW8Wj4FFvIjFKjbJH1ESMawoAC9zl3KU/3fyFOmnQ90uDsusHe99Bw?=
 =?us-ascii?Q?b6jcfgBobBa4xIGBnd7fcxNa4kKT+AuoZtB9EgwmLwbn/P6FfqlQb0KGToxJ?=
 =?us-ascii?Q?ils5TO4gZm2SXdhzC5wUm8M4fOZDOtUXt+saVFMpdFhSeBctOw6n/2W1DvoC?=
 =?us-ascii?Q?eSdNuU8bz59CqSfBA9ex/5zMh4fftIr+gGvYmRNt+5h6hWdFgfvq+r/A+l1u?=
 =?us-ascii?Q?OwmfWaccWYUcdvaeG02fciPSPjY7aEh/71nGKdXaRJniNQYzTQUc2J7gFbwM?=
 =?us-ascii?Q?6FBUBV8/QoK0GP7q9zFtfJYH+uNO2n0biL8/VdWOvRz7DtTSoAkhVJXLvHaa?=
 =?us-ascii?Q?AmJDqRyZlP5dENkD7VfBHX84EzEBi14f3ZRrV60JsQo+4BOaRf8gxBtX8Y/O?=
 =?us-ascii?Q?wKzsCmO+VzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wc0vnR64x5OxUc2vwaZW7d1lHHnnNc1UvHSb6OAey5IsZX6I5WkXwiOtpGPW?=
 =?us-ascii?Q?B1nE0AXlamx+evjUSwUtMLIT3x7dXo2+nQcdH0dFiyFps5vKHCNPYRJ6HtBn?=
 =?us-ascii?Q?mRv/lUcEMjARSRW2AL22jXzWANdHBz+9YDGN2hHaMPyYplaAca0ThAiHr7DO?=
 =?us-ascii?Q?qWaF6zMrE8EbKymZPPPN1QvVc4HdamBoV9pxOwvWMDQEz5CBrjSgBjBm/rR9?=
 =?us-ascii?Q?Y9GHjkBsdx81+jScoCTYYPtuNyeUkCtTgfUWbSNdXUSTg7oLTZEdrfuzVW5c?=
 =?us-ascii?Q?rjtJb3PlkFJrI4AC871Pb69fwr5ctvgjpOwfWuEJqUTF/DsEQDrfOBewfyI5?=
 =?us-ascii?Q?4eSqgT9zaQ5lWdWARBszsTTE1TCHfPoEOp1QiRCfnYjhfe9Uh7qLp28ElU3e?=
 =?us-ascii?Q?x5/GDmBiBQb7WVOcJ9gzf9YsLrb5Xof0tK5lAHRmCPJlW7RieNq2i7eD2f8f?=
 =?us-ascii?Q?Vw54iveE23XTRFs82znMpXENtGzow3ee2jcdmSqvc0jXVX6psHJWGZJr7gLD?=
 =?us-ascii?Q?PLcFgPJKsiiaec30h2evTw/tZIaEub8DjezGMBekdIrm+EdMBAx7zSRb45ba?=
 =?us-ascii?Q?2iCEmuDdtxM8Xy+RN202hepjNKHBN7XW7i10xu1NlNnTleefeuuxkRudwsNG?=
 =?us-ascii?Q?JRx5xDOZg7/iIV/+YLjurhTNcNM2y2ql8+EvVSPg0CAHQhWeAorhB0ZJBfZ4?=
 =?us-ascii?Q?tM3RCZtRCUHsSKDSaFpiOcAB3xsvCFEpY3ZpzY7XBO5t7LhXSxxp2WnTtymz?=
 =?us-ascii?Q?Jnbok4+4ymseHDebxI0n1AAN9gW9U3KJXRGleBmiTRs9cKPVK/ZaR2QPHFi2?=
 =?us-ascii?Q?jLYTk8JKXLIPfEmyF/VEksfoNXcJh6G2VlaRjc3VREo0hLo7AnUr7DpUYwNK?=
 =?us-ascii?Q?ArzWBd8wNO7b/s6lK5tKcFTDzNDS9v1xVfwEUHSO068ocOVIVvog+0RgwGVL?=
 =?us-ascii?Q?nZulL7l8UkA9EsfLrXbyjhGVHnsEl55T7GbV2tjeyAU/0KxSmGqChTigWvbE?=
 =?us-ascii?Q?uvFAcsNRu1ZAWcwHpVK9TdO/VQ98UbtpTnze4QktkBYuu4rO0NT66QiHwLNc?=
 =?us-ascii?Q?wKsI+liyjiG0+FLQ1LVLjeN05xxwI09gwP+mMOhxzoGq/iiC7iXMacGKG5d6?=
 =?us-ascii?Q?6lCMOFAUjBhuEYUEzgq48OYjpUmdejeI+WBXoEHIgQJ1HfYJr3dFouJwRxxP?=
 =?us-ascii?Q?u0N6BWwUJ3oQW3S9dX675D0Qh4kr0nWDWpjqsv8YiwFnTU2yVMEncNwnfzC8?=
 =?us-ascii?Q?u2KFvBoHPJWtW1Lcik4accTSfcbh9A8Ep+nXZ+Yprk+wV15nprhZYlRQlUHN?=
 =?us-ascii?Q?OksqOM7nXRsR/1FaQJyAmhzV9+eRFyhsiULMiQ7rqK68QpVtM112NFl32m+S?=
 =?us-ascii?Q?+ocR76q/RwePqimmUUu2cFcoAijebpCxvQdsl/39MgoIsLsigaAIMBeCQHR+?=
 =?us-ascii?Q?TmZU8ROj3YcZJacqnURtDUi5TltsKHqUuk5F7+/y6JniaHaoJokSui4wQzHR?=
 =?us-ascii?Q?SPLuckOZ49CZXRt+0YqolpPCJOEnHq6auCEDb/w8wvsYPZIiRd1bBfdJUO4A?=
 =?us-ascii?Q?ghbIP4oEzCe/uM5RyPSoC85jgN7hSqoeFMx2qlOK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4bm4IdC3gRa7tapVjFqpSR+xKhHOQAk4OQ4ZamDJ1Bu1UuxtkFXtKeHk8tZdULwlicakcP1umRT1aPSjkyUlw4rcmstqUh93yDXRqlp8m1EPbNxPGdk24rr9Is7N6M1rchdBu8Wg0VAdO9RBFvSdaLk4rEWZAHHROXbdYxY5S46XPEJhZUh0ezIpsik+Y7usL0wsDN4ADVpFKVwzJ16KHei7p9d+PbdaGKWd1nuuItT9WqKq2q7lIiKxmYBnUPC5WAy/VYqoftjVIys+Rkc2NuDdTWMoEE6GzWg1s2mwzZNSNEiNow/rBn+1DX3RR1Lka8BeHW3RdaBME0ra36jUH8X/LODpV+N3PWo6vL0zeRmX0+b3JuTG54cuy3mTxEmFbs1ovi3LrBGHEGszh2fVgYhIl//+E3pBFf+NX/6P1HhrmVL0vZ8dZd1eifX0PrL+pbg6O6GZjdnZupvmyf52XbfvRzMUIGMrafudYZYHZ+Ve6o4icGEIs8icEG4egxEumIIaDo1Vre56282UjyqLO/yCjEImyISCOfbqgZAQAJek7sD5qhOmRsYaJVNWWGUM9BLE0yt0qB1mDAkTCUucYjcf5WO3smHo4Yt3VMhVxhY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795e8c52-5c82-4b33-3967-08ddb2fee9fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:10:07.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5NcHLAowWdPA5aDUMRoiDMwtxWFz5noXv2Axtd5pevJI0jVL2Ttho3CdSYW2wotws5XaSiHeGjXY0pXkQDC7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240077
X-Proofpoint-GUID: 4bn4MLU7tegqAfaDLd6mDpd63GKUKhFU
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685a6b74 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=G13zY8NQ0wE9Wk4UL0sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: 4bn4MLU7tegqAfaDLd6mDpd63GKUKhFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA3NyBTYWx0ZWRfX1d2J8joLfdys U2sJzNkqGeF233ge7i6SpwP23PeYpxmfv+lVxEB1vQRzF6mFYHZpGfI/xzPphf/uieWqXha4SVp 5NKIrlv8sTxulEP2qitL6T5oslC/Dp5qpP6Dnmf3dvFZ74/fjKZVESujJSkOS01dic9sUqX0oBk
 kN348nAL6TjoGSBaV82ynxtu4Mgy6SkqPpoqWKWdujGF9cbUkQE9jw/7WjdPqQsHsjTyLr6jvKr Ng4OdkGrA2BgsC9t7V9E+M3VxzTPsplcr8+bvv65kduyihmzfIWeVzGWzyv7Mll6YZf9qA/pjmG TidULQr7CdKMfZhzOtiLBlgf+UPjze8WHiYT1rCCWPnGvUIXZ4aaMXc+gJvOvTO75YnpuVmEM/o
 DTJdoBMVhjPeMeBBYRVqIR6bWPo9wVSLNLAiEeR9410pN/Dh62ZJg3dTrvmwJ8obsdAVxqb9

On Tue, Jun 24, 2025 at 04:21:23PM +0800, David Wang wrote:
> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >even when the alloc_tag_cttype is not allocated because:
> >
> >  1) alloc tagging is disabled because mem profiling is disabled
> >     (!alloc_tag_cttype)
> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> >  3) alloc tagging is enabled, but failed initialization
> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >
> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >
> >This leads to a crash on memory allocation failure by attempting to
> >acquire a non-existent semaphore:
> >
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> >  Tainted: [D]=DIE
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> >  Call Trace:
> >   <TASK>
> >   codetag_trylock_module_list+0xd/0x20
> >   alloc_tag_top_users+0x369/0x4b0
> >   __show_mem+0x1cd/0x6e0
> >   warn_alloc+0x2b1/0x390
> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >   alloc_pages_mpol+0x135/0x3e0
> >   alloc_slab_page+0x82/0xe0
> >   new_slab+0x212/0x240
> >   ___slab_alloc+0x82a/0xe00
> >   </TASK>
> >
> >As David Wang points out, this issue became easier to trigger after commit
> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> >
> >Before the commit, the issue occurred only when it failed to allocate
> >and initialize alloc_tag_cttype or if a memory allocation fails before
> >alloc_tag_init() is called. After the commit, it can be easily triggered
> >when memory profiling is compiled but disabled at boot.
> >
> >To properly determine whether alloc_tag_init() has been called and
> >its data structures initialized, verify that alloc_tag_cttype is a valid
> >pointer before acquiring the semaphore. If the variable is NULL or an error
> >value, it has not been properly initialized. In such a case, just skip
> >and do not attempt to acquire the semaphore.
> >
> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XIWpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdBwKgJ9_Q$ 
> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XIWpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdC-7OiUsg$ 
> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >---
> >
> >@Suren: I did not add another pr_warn() because every error path in
> >alloc_tag_init() already has pr_err().
> >
> >v2 -> v3:
> >- Added another Closes: tag (David)
> >- Moved the condition into a standalone if block for better readability
> >  (Suren)
> >- Typo fix (Suren)
> >
> > lib/alloc_tag.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >index 41ccfb035b7b..e9b33848700a 100644
> >--- a/lib/alloc_tag.c
> >+++ b/lib/alloc_tag.c
> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> > 	struct codetag_bytes n;
> > 	unsigned int i, nr = 0;
> > 
> >+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> 
> Should a warning  added here? indicating  codetag module not ready yet and the memory failure happened during boot:
>  if (mem_profiling_support) pr_warn("...

I think you're saying we need to print a warning when alloc tagging
can't provide "top users".

And there can be three different reasons why it can't provide them:

1) alloc_tag_cttype is not ready yet or mem profiling is disabled.
2) the context can't sleep and trylock failed.
3) alloc tags do not exist.

I think that makes sense, but it should be a new feature (as a separate
patch) and not a -stable material?

If you're interested in doing this, please feel free to proceed.

It will look like this:

sh invoked oom-killer: gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|_0
[... snip ...]
Mem-Info:
active_anon:467412 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:872 slab_unreclaimable:4769
 mapped:833 shmem:49252 pagetables:930
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:15416 free_pcp:7714 free_cma:0
[... snip ...]
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
524158 pages RAM
0 pages HighMem/MovableOnly
22064 pages reserved
0 pages cma reserved
0 pages hwpoisoned
No memory allocation info available: Alloc tagging subsystem not initialized || Context cannot sleep || No alloc tags recorded
[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[    105]     0   105     3065     1003      402        0       601    65536        0             0 systemd-udevd
[    171]     0   171   775610   418124   417661        0       463  3416064        0             0 sh
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,global_oom,task_memcg=/,task=sh,pid=171,uid=0
Out of memory: Killed process 171 (sh) total-vm:3102440kB, anon-rss:1670644kB, file-rss:0kB, shmem-rss:1852kB, UID:0 pgtables:3336kB oom_score_adj:0

> >+		return 0;
> >+
> > 	if (can_sleep)
> > 		codetag_lock_module_list(alloc_tag_cttype, true);
> > 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
> >-- 
> >2.43.0

-- 
Cheers,
Harry / Hyeonggon

