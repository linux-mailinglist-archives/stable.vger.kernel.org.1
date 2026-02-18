Return-Path: <stable+bounces-217303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEHeGDHhlWk4VwIAu9opvQ
	(envelope-from <stable+bounces-217303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:56:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B1157850
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F146D30060A7
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE291343D66;
	Wed, 18 Feb 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F52HzXmG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n6isBk1M"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC4342503;
	Wed, 18 Feb 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430185; cv=fail; b=F1HZGHcdl3+zvmbGXKfRuTOHNuv2PRStDfupQOWYk1+m1GLk3gBf39fUTH9ShMrOoIyrir71utGZRcBYPNVof65qrlnwwMQbM3/XBPS5W0cBZ01+pHBb/B8pEg8TOxD3rWPh+laDE/JExCrMkAS3dXhofIo4otWf8rb7T9ACuUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430185; c=relaxed/simple;
	bh=z1IkUi0ST7cIAhfLEgLH6PjL+zkdjbh1G54N8Aabqvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNjaEPQ5QgcDv9frs64+1zaf63OcxXOptwbaJkNGb3CqEQGdnjsvKAgAj9UIheo8DREcDn4jfy5/PzbX7WHL1yLFHjHMk1W7+reDXtIKaZMxNXcuVvVG6fa7Q/GZKJFFNdg0pj6R9cszccyCJtSF/HjuzE9CwQhOMKODPJxPEXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F52HzXmG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n6isBk1M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I4BNTL389949;
	Wed, 18 Feb 2026 15:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gvjwznfQzxjjaBC50p
	WzLYZ178K4dygveFvi+y55vNw=; b=F52HzXmGd5BNaWyGaCHDDS5ObuYEHCP0VQ
	Z2Qq138o+IRKTjBY173wabdLxb2s7bHZXXzCX2YAdPakqMsfLwQg+rjfxopM+IdA
	4m7UaD5FXwYaRxk9g/OuJbUSqoez4Uk/1/2W/Z6f4gHPHksM4voZOSNCSU8ky6By
	hYqXQgTXkOzf8mtd+VEilz1K/MsakY/vBD55c6+Mho0Wz4mQP8Fk42cK6b55E/7X
	yz7syqeF8pGR5j2FY73XsQ+QyH7Nq1VEG1Aar/b8uNRsjr4e6fOeSljYpqwqS3wN
	cBJjBc2sfn7J+rHmDDQ0iREheSJULTCQqxMjJsW4LVrmG7vS/+PQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj4awpsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 15:54:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IFsOIW009875;
	Wed, 18 Feb 2026 15:54:58 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azlp17010098.outbound.protection.outlook.com [40.93.23.98])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2a85a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 15:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk/qr8/QM0j3IwyfCHyGoUSeHGC3kpIrClloDh+P7FKTm0z3hi2/CN8sIxwY3EnvZMtOXTV33X81r4GI192NCdIbh/EkQkcHxKrpQtuSz84y3hWH3uBZaKzEC3vf7Qy7PpiLFkH5yu2EEfoGqgCSsyWhznl1AIrZsKgM4RJaMjAUJewZ7Etb3aUO6YnwezBfY03OyQX3vmlZhj2axJK59dUZIaPc47H9/X7Xg19mv5UutcpoZQbMN6m++9feK2cRkKZVBPTcnkNA2XdtcwJ93S6ZTTuOwsichdPtxbNQb8HQGCdh3BZUBDLXc9IsvuljMr2ZQpeGT5H2z0/ccL/DGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvjwznfQzxjjaBC50pWzLYZ178K4dygveFvi+y55vNw=;
 b=BNocJ8nkdn/D/HpVUa+ZreKHmztEqeq5REIBh9Vf2dupGKk+1imEDoGius/uXtqWV49kLYYeH45l8xh45AnNYoninrxIqJEhkkdHwPsXkeQmNuw0na0kijbYCSIR1frln77gW0td6qSsDHt8qMz9gyhfWq9HA4HC7KjXljJYmiN5qxlHlh08saWWXTyNXybN5am4qt2WPf9vmT+QbOv6mim9TYYbTC++qwfIrZGJD7Y0nJbWxdrf130ReuUVEO871Hqkq6qj1OF0LUvd73kOcw7KCMZVpoGRKkmILEN58TZMWpcOLiA6o02wl8qE+/ZaVWt5Wva0zkrOiteWUXsdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvjwznfQzxjjaBC50pWzLYZ178K4dygveFvi+y55vNw=;
 b=n6isBk1MDaZTLrfP2JiF2ngntkQ7+XWNn4dHcnICtwvRlx9KxAKD5cdpXb29htN+Iosl9spCuSPcdd1yzXKso7IQwsuNInm2CtvZ1Tt0/RXskJWlPIiIfX7Fp+pCT45fEMsnTg8ZciMAmfMkk3ApO1xbByQy/RJI8AmGmy2joyU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB997626.namprd10.prod.outlook.com (2603:10b6:8:315::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 15:54:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 15:54:50 +0000
Date: Wed, 18 Feb 2026 10:54:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust_binder: check ownership before using vma
Message-ID: <n2nq4aypj6hgafy36z2527tyvetgcypcrn2v3hvs6dws2mtwnl@jiszbxj4mrog>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB997626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfc6014-5eb3-4fdb-125b-08de6f060c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WCBik2cPmqhO4tJW6Ijlac+hmqVE7XCDT1kHU+b7FJsOOqYz1TY1jbqwkh6?=
 =?us-ascii?Q?ck9YqBmi0ApD1uy791YH7ocA/dPW3FMeCI5LmY7MPoElQTB3gGSMmF4c6tXI?=
 =?us-ascii?Q?jvBjMUbOC+NmMsQpScE9rCGsGxG1X2hBYyqEKVJhl3CgV4H8UUDki3sbEC1T?=
 =?us-ascii?Q?K3bD45yUy9tf49yXjIfarVERguXRaNDlhrsdRn+746e5momzWXGK937hOE4y?=
 =?us-ascii?Q?ywLifrr3e1L8Mbbgr20twMpor7C78rUGr4ZKqYrMM/0Wsfzak//+fp/l6rck?=
 =?us-ascii?Q?4Y2zD1KW+mGQNvZdE5oXk5Bfaq8X+b+GDq2MRyV4NZ6QE0DCLgMLrBMssK8V?=
 =?us-ascii?Q?rPEsVBfo4f3qkB0Mm7OZuted4SUkMOe+CRIl2U7IMDGswYLde3l9s3A7ImKt?=
 =?us-ascii?Q?Bf0Ok0VL3hNuoJFcORuZAzCzvrX58cyI54DeNKB2dP9y0mwspv+gytBsLqwH?=
 =?us-ascii?Q?4asEDuyLYDd6PNMTQuQCvIldS9wHv3Slhw++ff7OZc+fVZweVokA+3feUC2T?=
 =?us-ascii?Q?+2WjkXqW7yvE2+Tq0GJU8QI5lXJw7IR21i+QvHfnRJaDBS2+vWr+S9AJZUqg?=
 =?us-ascii?Q?5VAm88d+pBQ+8RVm3XrMzdwACt83d7ipLLNJ6NIhpVwnHsXAU2lo2ZEEG1w1?=
 =?us-ascii?Q?qDfqFGg7PBFb6QNopOj2x4mv3vX1b70MBt2DPCJzOynAxrOk4/vY++LfLzIO?=
 =?us-ascii?Q?yvBZ/E/B4BvRvElgeI7OBBOCBRBpnJiAKT1kJD40a+xf6N6bCnfaLIsB3EZh?=
 =?us-ascii?Q?HVfMH1Yyz+FdCTakN5N/pp3qgc7Amq3Gy/aszGh4wtGZQVBdb2CBpIt8eELo?=
 =?us-ascii?Q?Z/QQ+HcaRGPzlxxnh9JpKi3fqLJTaKCN5nt05+4wpLVkhEmKqVXp2nNHUPK0?=
 =?us-ascii?Q?OGfZF3FRXQNDWBd+XRe9yd+R7I7SDSnp52DpB7+mJA1rNmhzKPqHO8zMHUc0?=
 =?us-ascii?Q?XRbNRkLg5b32PpSNgMVaW5pROjaBkrx+VOGPd5wdWtI2Y2EsLJoolXTNMHMw?=
 =?us-ascii?Q?u51OT0qSky+PtOxC6fK8906ro94WtkPHH2dAXXoMAJVmskHUrBW5AQ2gGeKX?=
 =?us-ascii?Q?uba3NasOC/q3Y2Z5em0Ydyk2ce29zFdehcatEgGitpjNYRgIKGeYGcer0Aln?=
 =?us-ascii?Q?d964bjztmIMQD7RV0V2cl0TqoU+WOjft2EHwY252LzmKIgpsOGp0VWZoVSfW?=
 =?us-ascii?Q?lGj1tJ5BVEPS1O/8LR7yuUTvBg6EKPm2eI8xNLPgj6GWeOQPhxuV6+1ti+Ir?=
 =?us-ascii?Q?zdJTlbc9jAyPcJ9ZjumLGU1h/zU5HUZPx02YK0m656cGJMjUp1N54I7W9Vt4?=
 =?us-ascii?Q?N9jU58PsQE5gK917LAioOtUN0X5OI4kizdPeFtXdbL5ZjzTDSUZpTNtFfhD+?=
 =?us-ascii?Q?cbkUiByo4ELvC7oJcVakFBVOjOHdYnYLx9sPkZjxrFEoxH80usnZ6dEGQDlt?=
 =?us-ascii?Q?uiK7E8kimxp1Or8oUfgP8rIDXuisyBKC5W7bkXI0dcG/+sp98B94gsPh4VHW?=
 =?us-ascii?Q?FRmQLiJtuVxVFsgNpRJv1h+jPKwfyhaMk+VoMUpskgk0azM39x9ILuDiaI1+?=
 =?us-ascii?Q?zqyIuS1b6z2bMv9ecEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?saw8lSKrTdKYx2sKXFj5KIbj+bwJnwKmcuWd281iwH7VjWmNc5tu1V+1/ZOj?=
 =?us-ascii?Q?r7DouBXP3ceIJtOQoxWutf/Q0GargZ5dFaF59+d6vaJY4gktPwVA1rIeMQo3?=
 =?us-ascii?Q?VODE1+YMwR0iIn6l0hN4NQXlzG7HcgvuauITIqpRrJIj9vXoZyEC0Ta9Fe0t?=
 =?us-ascii?Q?jMh+GWXx1G598SdTtGgUrpWemdRyteHHofivwSXtSsRZM/acgQBkqjfXL64A?=
 =?us-ascii?Q?W7YUZWrjNmfA8RT5qfGYXdDePbqROoINqm+oyERCaWWIX7ORjWFoL6hWGI1k?=
 =?us-ascii?Q?veKqR2yZTZEfdboelJvKV6HI5KOHLggLD1dkkUUjOW0vq/HfzoiY8WFsTZ58?=
 =?us-ascii?Q?sVegwoednse1YB0Q2Ut3JOOdAsOKWD/QNb8k9zoyFgIk7vHjTp7Q4HYmHQL5?=
 =?us-ascii?Q?bfLUkw61UWEjVvHdrsZavQrSgPDT5hupNsCGjFkVCe099oqolG340GK8gEpL?=
 =?us-ascii?Q?/SIycYq+WDufqyAW7LeMYjVYLE53QzH5hHqfvrknsFaQ5r5ZyS/kLzeaOEY1?=
 =?us-ascii?Q?c34FuOSXiNvXqcYGrSnC8GDEg+Lc/lbpqR3w5/bTYfyiSRbLyU43nApAdJ8W?=
 =?us-ascii?Q?Lz3LW1nnxz7e/gYZ20F9ZwRBTyjbkjZhed4kGKvV+0fZw2CW+vIM2exJ/uDU?=
 =?us-ascii?Q?8hVcJ1WNscX9bTqqm/zIUa7jgLLZUsmXlBCZqgnOxvwkq4ZPkRL2ddUiPRve?=
 =?us-ascii?Q?Mtb71HNVzj8p2rNxNo6jGdZr16nrJWG+26W3/7XuBRz31LkVPu4o284ZF7hv?=
 =?us-ascii?Q?KQhnFFFlLYhBGU8q9W71Qk296iXCmnSIJbF/MrB8MT+TzmwvQQpqnvcBb9d9?=
 =?us-ascii?Q?HcnIXS+nK/Di+jWR03o4XWSfUdfmlt28hRJ3R2J9jsqcqR7zEq7M76bUCHC7?=
 =?us-ascii?Q?5qYCFxviWZq0R0gn1sV+U4i4WlOjSDER8gKhn88E2ize8FMLUhB6brswNSPS?=
 =?us-ascii?Q?eT1zgW2y2FvoUiwCzPSITJfrmOKlZ/hnGKjH7b43U6JxSE7u43BaFD8DE0XP?=
 =?us-ascii?Q?AX9hClUy3reM8ESc3d5CzsbZ62QcqN6jM7gUv/gKnk1OGHS04FVSYSSa1PEy?=
 =?us-ascii?Q?jIXHkd7VnuqpysQIKeLZaqoS74p4pDrwC10QFEgNXkMY9ezNj+1Zc7sHoDhy?=
 =?us-ascii?Q?f6JzjPkDtOtiADnIymk+4w4uOqgvq0yOLA3nClP2VeuCzFAQu3fMbV3xspgQ?=
 =?us-ascii?Q?VSaj6BKE9eRbDER7awF2a4zpmRBuNCYFcHdgxPBTizjE/zhHKakR3xdO0hHP?=
 =?us-ascii?Q?vD+jPbGz/8vMuSEc2KjixWlrBHVflP4HCBgeKBk3lgtgo8bEiVHDEAWRvAX6?=
 =?us-ascii?Q?OxzyXB6GlQTd9PmapUVd/mVFvFMNdsvn2oxBsalkvyV7Cm3GjxoITISIV+d5?=
 =?us-ascii?Q?rbTKFu5OMCMX+iTBIkgR6d6RPHvlDeyL8f8gLlicNyNA2OqPsrxrtDUYhTwh?=
 =?us-ascii?Q?RmM/Fzq9oVgn3ORwUka5VmnzTdbAr4ltnP9EeJB1LhMCkWg0wTsgUNd7EGG3?=
 =?us-ascii?Q?r1MG0j2cjILiuQJe4JrSa08vxP5v8h74xhUNxy5JNHXKipEnSF2lQqejpHiq?=
 =?us-ascii?Q?zX1xub+5ZHzEcJKOj25Rt2vAfnbxILmZSYJg8dzL8m90geEPkEkF0GxfMQX1?=
 =?us-ascii?Q?06nho0BPGe0hA+2SnocwiQA8HxNO8O1g4jsjOUQCuZbsLdQRjJvXQtm85B68?=
 =?us-ascii?Q?E+uZGo0mrd6ux0CEuiYbab2PRtJvoVTpP6Qaxti3nijWUS8Xfuz/GVzp46pT?=
 =?us-ascii?Q?Ra2il6Pldg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BjsJ3f587paewTEISb1k8xGo9iBgUIpdntitognQzauP76MrPbKjec9jDYh2b1ofx6IOFn8aVkXoJIpTTl7ba8QSWsdSQhBgI29Mz1gCd/VOCt7PueMffmXHvyBDXCIZ7ftZSvWs9ryx61aIAGk8Zs8ik+xWeFfiOF4y1t59Je0wGrICRcQvsQ+JnD3loqjcPjJs8KlMtxvE7K7pt6HTkaNW3+WSUiOPbhkVA0ql0qbL7ZzGcNXdaK7VeFnmfBjauWht1slPJenniH39aCHGNVb5KFa25o8gSM/uFidKYa0BcaKwB5N2MBC9jPTtP+ANICNKiApHtZ5jvQXeCeIvAYOO6PV84bydwAn/P+rdGbwljEFCSIqEZbwX2Bfq5m92L3hpFVsHrqWjjLyL5MY1fAU3WSc0yYxTXgDNmTvCFe8kE4wQR+pVgUGSYkMzzdVG9NMa0mdQTIt74OxQEjgkk7B3c0DspMGbDPdyVqAAYV7sOyy7/pYGcBYvmi/Rsjhv5C0qpYrTxrAGJXieWm81LM1wLEw4EkLUId9OHiEfXAxznqcIEz2N01WeeTFO6XZ46aSxetGKSmsrRFw/wmJJpdcERCW19GGKfipf/Eu8XPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfc6014-5eb3-4fdb-125b-08de6f060c51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 15:54:50.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0yaqFOzQ3LBhFoXMk8c1iqmYSpKScru+0U2xDX0du2X0bxyXwLXj9GMPy8doCEAHWaqwmMsgh+a0L2f9seNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180135
X-Proofpoint-ORIG-GUID: y8O7GuyN3PiF0-zd-8QZa4YjuEOuARiv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEzNSBTYWx0ZWRfXxjcWaWuXFj+c
 xckpVuBa9KRTwpPdK7Sftla5Ps+awaKdUuGGeibFSpjDK0OmSYsn336Gq3U2TTvFcGsN/pPjXQu
 lf+HzsQ7aWGzpQ/8n8FVOoQ1tEsKP4ZGuivMspaft/ljzwamrMS87dchLCQ36WgkLtSXfU5IJaz
 8mhRvfe02nJt2VMaqRfFnP1lvuBqnU9rmwEAFINj6qDKzmvBE1TLy2A4nQRqICID9jJu58i0GDM
 reZCzOLZkp6TFTTKu0vMoyXBa6FXyYAfyiIEg1UyesoHu80ViwOKBpun4CoYJ104cKpXahnV/jO
 oLuIti0o1WbKakugNNiYCkLpN7vH4xwH67TxY0euL7vSAYb+D88hzE+7EcuLQRNeWYk2VmHGhN0
 HcPt50VXKCkeBVelND/dcesN4MCWYNGmYvv+22CTd5SwUPeBQejAi5DojepZQXX7tjqOaiVmRb3
 3vYSfiiBdqckJlVvEatboNUfC89HLscKGmufWMls=
X-Authority-Analysis: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=6995e0d3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=oB3NgvUJCHmWyFRDt-cA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13801
X-Proofpoint-GUID: y8O7GuyN3PiF0-zd-8QZa4YjuEOuARiv
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217303-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 786B1157850
X-Rspamd-Action: no action

* Alice Ryhl <aliceryhl@google.com> [260218 06:53]:
> When installing missing pages (or zapping them), Rust Binder will look
> up the vma in the mm by address, and then call vm_insert_page (or
> zap_page_range_single). However, if the vma is closed and replaced with
> a different vma at the same address, this can lead to Rust Binder
> installing pages into the wrong vma.
> 
> By installing the page into a writable vma, it becomes possible to write
> to your own binder pages, which are normally read-only. Although you're
> not supposed to be able to write to those pages, the intent behind the
> design of Rust Binder is that even if you get that ability, it should not
> lead to anything bad. Unfortunately, due to another bug, that is not the
> case.
> 
> To fix this, store a pointer in vm_private_data and check that the vma
> returned by vma_lookup() has the right vm_ops and vm_private_data before
> trying to use the vma. This should ensure that Rust Binder will refuse
> to interact with any other VMA. The plan is to introduce more vma
> abstractions to avoid this unsafe access to vm_ops and vm_private_data,
> but for now let's start with the simplest possible fix.

You probably already know this, but there are a list of ways we can
ensure the vma is stable, listed in Documentation/mm/process_addrs.rst.
Check the "Lock usage" section.

I'd feel more comfortable using one of the described ways to maintain a
stable vma instead of rolling your own here - we may break your way by
accident, or it might cause issues with future changes.

When do you think we can move to one of the standard ways of ensuring
the vma is stable?


> 
> C Binder performs the same check in a slightly different way: it
> provides a vm_ops->close that sets a boolean to true, then checks that
> boolean after calling vma_lookup(), but this is more fragile
> than the solution in this patch. (We probably still want to do both, but
> the vm_ops->close callback will be added later as part of the follow-up
> vma API changes.)

If I understand this correctly, setting the boolean to true will close
the loophole of replacing the vma with an exact duplicate (including
private data and vm_ops) but with different write permissions.  I assume
that is why we want both?

> 
> It's still possible to remap the vma so that pages appear in the right
> vma, but at the wrong offset, but this is a separate issue and will be
> fixed when Rust Binder gets a vm_ops->close callback.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  drivers/android/binder/page_range.rs | 83 +++++++++++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
> index fdd97112ef5c8b2341e498dc3567b659f05e3fd7..67aae783e8b8b7cf60ecf7e711d5f6f6f5d1dbe3 100644
> --- a/drivers/android/binder/page_range.rs
> +++ b/drivers/android/binder/page_range.rs
> @@ -142,6 +142,30 @@ pub(crate) struct ShrinkablePageRange {
>      _pin: PhantomPinned,
>  }
>  
> +// We do not define any ops. For now, used only to check identity of vmas.
> +static BINDER_VM_OPS: bindings::vm_operations_struct = pin_init::zeroed();
> +
> +// To ensure that we do not accidentally install pages into or zap pages from the wrong vma, we
> +// check its vm_ops and private data before using it.
> +fn check_vma(vma: &virt::VmaRef, owner: *const ShrinkablePageRange) -> Option<&virt::VmaMixedMap> {
> +    // SAFETY: Just reading the vm_ops pointer of any active vma is safe.
> +    let vm_ops = unsafe { (*vma.as_ptr()).vm_ops };
> +    if !ptr::eq(vm_ops, &BINDER_VM_OPS) {
> +        return None;
> +    }
> +
> +    // SAFETY: Reading the vm_private_data pointer of a binder-owned vma is safe.
> +    let vm_private_data = unsafe { (*vma.as_ptr()).vm_private_data };
> +    // The ShrinkablePageRange is only dropped when the Process is dropped, which only happens once
> +    // the file's ->release handler is invoked, which means the ShrinkablePageRange outlives any
> +    // VMA associated with it, so there can't be any false positives due to pointer reuse here.
> +    if !ptr::eq(vm_private_data, owner.cast()) {
> +        return None;
> +    }
> +
> +    vma.as_mixedmap_vma()
> +}
> +
>  struct Inner {
>      /// Array of pages.
>      ///
> @@ -308,6 +332,18 @@ pub(crate) fn register_with_vma(&self, vma: &virt::VmaNew) -> Result<usize> {
>          inner.size = num_pages;
>          inner.vma_addr = vma.start();
>  
> +        // This pointer is only used for comparison - it's not dereferenced.
> +        //
> +        // SAFETY: We own the vma, and we don't use any methods on VmaNew that rely on
> +        // `vm_private_data`.
> +        unsafe {
> +            (*vma.as_ptr()).vm_private_data = ptr::from_ref(self).cast_mut().cast::<c_void>()
> +        };
> +
> +        // SAFETY: We own the vma, and we don't use any methods on VmaNew that rely on
> +        // `vm_ops`.
> +        unsafe { (*vma.as_ptr()).vm_ops = &BINDER_VM_OPS };
> +
>          Ok(num_pages)
>      }
>  
> @@ -399,22 +435,24 @@ unsafe fn use_page_slow(&self, i: usize) -> Result<()> {
>          //
>          // Using `mmput_async` avoids this, because then the `mm` cleanup is instead queued to a
>          // workqueue.
> -        MmWithUser::into_mmput_async(self.mm.mmget_not_zero().ok_or(ESRCH)?)
> -            .mmap_read_lock()
> -            .vma_lookup(vma_addr)
> -            .ok_or(ESRCH)?
> -            .as_mixedmap_vma()
> -            .ok_or(ESRCH)?
> -            .vm_insert_page(user_page_addr, &new_page)
> -            .inspect_err(|err| {
> -                pr_warn!(
> -                    "Failed to vm_insert_page({}): vma_addr:{} i:{} err:{:?}",
> -                    user_page_addr,
> -                    vma_addr,
> -                    i,
> -                    err
> -                )
> -            })?;
> +        check_vma(
> +            MmWithUser::into_mmput_async(self.mm.mmget_not_zero().ok_or(ESRCH)?)
> +                .mmap_read_lock()
> +                .vma_lookup(vma_addr)
> +                .ok_or(ESRCH)?,
> +            self,
> +        )
> +        .ok_or(ESRCH)?
> +        .vm_insert_page(user_page_addr, &new_page)
> +        .inspect_err(|err| {
> +            pr_warn!(
> +                "Failed to vm_insert_page({}): vma_addr:{} i:{} err:{:?}",
> +                user_page_addr,
> +                vma_addr,
> +                i,
> +                err
> +            )
> +        })?;
>  
>          let inner = self.lock.lock();
>  
> @@ -667,12 +705,15 @@ fn drop(self: Pin<&mut Self>) {
>      let mmap_read;
>      let mm_mutex;
>      let vma_addr;
> +    let range_ptr;
>  
>      {
>          // CAST: The `list_head` field is first in `PageInfo`.
>          let info = item as *mut PageInfo;
>          // SAFETY: The `range` field of `PageInfo` is immutable.
> -        let range = unsafe { &*((*info).range) };
> +        range_ptr = unsafe { (*info).range };
> +        // SAFETY: The `range` outlives its `PageInfo` values.
> +        let range = unsafe { &*range_ptr };
>  
>          mm = match range.mm.mmget_not_zero() {
>              Some(mm) => MmWithUser::into_mmput_async(mm),
> @@ -717,9 +758,11 @@ fn drop(self: Pin<&mut Self>) {
>      // SAFETY: The lru lock is locked when this method is called.
>      unsafe { bindings::spin_unlock(&raw mut (*lru).lock) };
>  
> -    if let Some(vma) = mmap_read.vma_lookup(vma_addr) {
> -        let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
> -        vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
> +    if let Some(unchecked_vma) = mmap_read.vma_lookup(vma_addr) {
> +        if let Some(vma) = check_vma(unchecked_vma, range_ptr) {
> +            let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
> +            vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
> +        }
>      }
>  
>      drop(mmap_read);
> 
> -- 
> 2.53.0.310.g728cabbaf7-goog
> 

