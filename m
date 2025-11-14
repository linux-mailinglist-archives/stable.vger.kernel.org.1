Return-Path: <stable+bounces-194788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A5C5CF5C
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2A834E429B
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166D314D15;
	Fri, 14 Nov 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jBWlsU0f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zPWu4WFm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252D3148B1;
	Fri, 14 Nov 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121195; cv=fail; b=Z3ZjUsiOxW29Zm/ZfsYZpcJ1UL9rwgUkZc8RnMpy3GOnmIGx6dHog6pOMl16qp6yLrG8BRtQo1F0m4slGR4dg/+UBxw5gbIRDDEQpocN217iDYM4Uvzqh0KRLC1NgAUAva4zQzO8mv/VYcI/X+QL9S4CfbknV4dz6JcbRjuU6Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121195; c=relaxed/simple;
	bh=eRyrqblJEaZCay0BCoeTetVZUNCvTrxw4pm1VLfTqJQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e3rxdl8YHoqzVMWOvfMOiGXoJNNFbclcHnzsfOFR55McV+iuNFJ3S9FdNuU2J31ieETs1rTXFUsBAeoVJFpf+GBcoNG0VYALeF2o4BxiJQHrfYglwFn05ZFEvdAl92hAlqDWOYvMEVchwWypwjN4xXo1RLxXAg3G5wU/KCguyFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jBWlsU0f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zPWu4WFm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AE5RgTB021754;
	Fri, 14 Nov 2025 11:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LxlwXzbWaEQfV1Sr6f
	lTrJ12/n7wbxkVl9QoYN+jeeA=; b=jBWlsU0f5TjmonLtYN9FHPxPqJkbMvpi1G
	3tfj1RHsx73H6aYtZvp3mgm1S4AGBQfI1aC8GU9n4Lz6Z9ed7BOvF2a2Epfp0gAS
	Dz8/Rn6ylXfRTeAHkB/xqycuAKfjjdtiWNBTic3rLY/HbbftVBdfwXBBjE2m9ibJ
	mI9ZQ4L0necL4bFpnb/6UAWuoYyMHGhX9mfJ0OpwXoI3BsxKe2Oi2nwvtPbgj/vb
	Zbbp5zxHULWe5k87vvAXubBRu0AEvnf9/k18qfezGvNCuZPGnhMhNjZbt551J+zh
	AmAhHHGaKD5a7sIRXhUo/8az1InlFa5GGmvVuT3+KBYkUMAsR1Xg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8ss0t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 11:51:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEAIuLH000546;
	Fri, 14 Nov 2025 11:51:17 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vah01ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 11:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llB8x2IwQEuqLPk1ZRUCZLcKMD290ebhOywf/wx1K4lynlv7lHDtAx+nhl94tqpPwLqA8VR/Gqk0IgSvAk88mA8ydfSU5Eouw/TkYDpawu60ORdON6b95bHHoQYwrKZ426mi0YJ0+TKk8tBHzPCfVL9T8T+Vgay4dNQsw4LTzb9tOMpFWkxnVEUQP/MVbzL3OP5zyEHqkjzUsX2lnS3wt2X86adKQnvft3FyL+ESp0gW3yATvz71rW+RAh5QVbbZ1L1ode8n/jGxVokff+mCzdSZSjAb6y2NlWimIGnEtj50yZ+ZnzsABqjcrnbNeOaf54ORvVnzLGGRHb+mfGe0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxlwXzbWaEQfV1Sr6flTrJ12/n7wbxkVl9QoYN+jeeA=;
 b=xjS+/3Znk8BlLKVNgQAw66Fgdvc02yKjdfAnmYU7ROaqKuyWd2r0DCPJ/AHQUFBK+GatBk7XeQdJfN2Y6e4CJNEphTonBE0EVeth0/V0P9hyjb9XNU5VhxS1vyCTQaGARX7l2qdh53mZ2EyMMqWPLmgHY+uO8HJnKUTrI4NMIsTSju6RrISYOmNUsOfDTv/U9TdwTb1JG91q7afyfXEXyHrpnjmIeKpfcQujEjewzfjUO0znmfhpqux0h2FV36rYsWLmhoPHcWH6f0XWL8rKnBdMuzq9QyABrT3TrsRZeekyDkLcfAHGGqcN4cbKuUTdEJkQehTmmAC4TAVwuo/0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxlwXzbWaEQfV1Sr6flTrJ12/n7wbxkVl9QoYN+jeeA=;
 b=zPWu4WFmTbby4RdAmgLf7nEWNWMWEfGTqHQUUx4UHP6JekkfGEVmbWUmfHMg7M761wLztWmtDTwG/VzHfweSjTk3qDpTxxSustrG7t42Jct+dxv6Vz8745yARwlev29rJnhoCbYIbMZ5Pu2dTmKhLVyjcV14in1lISBrn8kNYcU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5787.namprd10.prod.outlook.com (2603:10b6:a03:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 11:51:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 11:51:14 +0000
Date: Fri, 14 Nov 2025 11:51:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <1885ac9d-1a5e-45a2-90d7-f4ecb5848937@lucifer.local>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
 <8935c95a-674e-44be-b5cc-dc5154a8db41@lucifer.local>
 <ajnzlk33uzmbt5tdrv7m7cr2hktt7acuruunx4s5fwwvroc5ad@7hnx2ys6gj35>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajnzlk33uzmbt5tdrv7m7cr2hktt7acuruunx4s5fwwvroc5ad@7hnx2ys6gj35>
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4de7b9-9243-4367-8a1c-08de23741ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ErDTG8kOe3QuU/BAOSNuZh6NSlool/kEUUmrqOLeWQXqJ1fcittGbGtDCxKj?=
 =?us-ascii?Q?JhNWAKQtOLHmr4Dg/kBUIhCxyctefLaoSuIkQnk3d5sEOuYeAU82OFVWu8bs?=
 =?us-ascii?Q?rXZw6E/141c9shyInys443P8xmRBqcSQRLyDmiAfj9J/FWPrXoa4bUBxKgiK?=
 =?us-ascii?Q?+cl4ItmXlDwtrRvS7NbFaborP8fx28MxK/C1kySVpQbGUAZ2hacbQ9Mbel3G?=
 =?us-ascii?Q?IG6jr4w0+xS98DXfEV2eQoNCxHiF7Qugm8uHm1a+34hl7SJJje+KdsnPk1ta?=
 =?us-ascii?Q?G4WJoHLbrD97cIuIp4o1O2KcnLaC32TnXSuddWV7Ov6bHv6TfqdwD/a72T4/?=
 =?us-ascii?Q?ninbXz3dAChMwzq/nSzM8R2GNTYQiglRTx4eabh+/+obxae4UfMbPPMHxO05?=
 =?us-ascii?Q?8u3GrQJGuv+SqiAeFSKbsZ9QyV3PZuHVZeS4JOjP4JBEUETIC5H4OW2yiE/h?=
 =?us-ascii?Q?6R+zQpHqpxd30Dpo19Vlsogqp8dRq1xi72ev/F/5G0imjuHX12DmhGasSjZm?=
 =?us-ascii?Q?cYOR29mfvTQ6dQtKYVnyRH6XwHuRAmgHAL+tEIfMwLjee5tHGJug2GLmGRLm?=
 =?us-ascii?Q?vDLYeniryjkSR5Ls8aip5desOnp9Q/tuMtNZgr+55ktkQ/gM46W0SOpidgZ7?=
 =?us-ascii?Q?15UuBzwYxxYzrh1QvN9FAlrPbESnIQ1GCHdoIx73cL4mwPnJLvKF7CIvmdNc?=
 =?us-ascii?Q?JubKf6gxMAo14fFCBLSg+DUrRCYWcQI+3pwtJGooyNY4rwD/Ve2BBXLa3FE0?=
 =?us-ascii?Q?XjgHWVVNBNnjz7KlXxESXJYmIA1WS/2il7P5wSa5kITok1jnm/MrPLQmJGNw?=
 =?us-ascii?Q?Y21yIPzlGGq1momfKH6npsvhZ8rRBM0/qhd/WPez71AHI2JiXB2IWFbPCxws?=
 =?us-ascii?Q?TEQpaRcdtg1x/AVrIBiVsnDI+oQCMaoCrkyZYHGs3q9D3MiQNpCMRh4bEZA/?=
 =?us-ascii?Q?zaYmgxOTqEJN6cSr9sUoPgdVCVniZQOEBk/PfairmHd0+t2RxweiwcyKXH2n?=
 =?us-ascii?Q?amNADvnHxBZYmOfRjm5eRB5FAU7NqoViY1bq5fPdJVnJFFqK0H8+Riptjjc+?=
 =?us-ascii?Q?6yed577m6Nj83mMacsTtFgN+3fW2AwXhuiSldPCoiKkpGA7EzVh6dUMJ2HYz?=
 =?us-ascii?Q?0zALRrIIeu1hWNHqONJx+EvypgW3EvGTrOJM7oD5lT3jUzjusW9vv5AybpE3?=
 =?us-ascii?Q?ej7HiOlKG44I/4UJTblHpDvYzeKouSBTjw+Wvxvi0BC2fLrIhEQUmttKYhhk?=
 =?us-ascii?Q?paQ9rqPAbcA3ft5YuVZomYR1lhf3EoI0OMgb9wT7Vc/WWMA34dhRFpmBrmwf?=
 =?us-ascii?Q?+ahZC0DBp9qWI0HrNoxMjf2J/Daj00bDkHw/bHFOgVGWIaHABDa5lV/K1zv/?=
 =?us-ascii?Q?9XJuIbLNvTLJG+FIX4kMRRI08fdb1fsE5z/xZldHNRPbkn0Gh3AL9jt7sOKw?=
 =?us-ascii?Q?48eY5yImBOFfBZ1EoJgNsa2RAjNOsViFb7ppq8969isnvt3r2Vm6zekZ407m?=
 =?us-ascii?Q?zSWs4GNsoyF1g6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4STHFctf3/w91Bwlk+dej+XomW6m8Fu7g3dvA7ICiuwv5Qt8rW4tM8UYV9C?=
 =?us-ascii?Q?LtTSDwp8KiQ/ZpOlbb7L+1XAjpXxoA/sh8+nrDangwiXrNTjL7W8/bSIfTwz?=
 =?us-ascii?Q?0nIspvMh7sbMtLlJbt2DJ3iIWd+yUlLrPz0iGfMSIvHcDRa7WTlh9qJEAG38?=
 =?us-ascii?Q?RgdIPM0msxo8Nduf+8c7nzGJGVFU4CCqT33M5E95RFdhS8we+/vfNhZS8VgL?=
 =?us-ascii?Q?Ad4YG/j+I6GhBryuiDoa5IeF3MFvTxQ001n1GmLE7p56n3D1lgYPB2zLB2fZ?=
 =?us-ascii?Q?Ws1R42T2PGbBBSGL6DC/Z8kfE5nHxDDiTrDFEitSGIBbHxje92gu3/hxi5mV?=
 =?us-ascii?Q?pzdyN/TlBVP5nwBryN3Ckp5wpMPMTFVJ6P3WUgAwDVGauA4bG0k3b8Dnxuos?=
 =?us-ascii?Q?zKHx9WrVpZ3ZV19i9NiU7x9CCPexVoGkgt2CH0/Nu9UE8UaxeJoefIVmnCGk?=
 =?us-ascii?Q?wvzhZ8wyyjpGVJTVnXhac+oX6GtxAykGtRwFOsnbUcu8mRdFIEkVWICBWWU6?=
 =?us-ascii?Q?0Bk5IzeSkfewCeGqKKo50RPe6qVsx09TXwI2zNLdD4+erZrsvZ8WdaDyBkr0?=
 =?us-ascii?Q?XTcYT4M7gn4tceXRiGAkZoTc+URg8iuV7zutB/rjjqZSB+aW/pw0LQ6iKMmN?=
 =?us-ascii?Q?5U0PEh0I5ZFZDApW9+9aIg1snqST4x27NpBXJy1hFgNszg/wTqHD040/cqez?=
 =?us-ascii?Q?es0/6oLBffJWrVQYknUlYDCR9a2EUmH9CKPKeLa0zYjMu4Pw4/o8sHc9+8+X?=
 =?us-ascii?Q?gTej3Foh4e2xqeyBZjQltIIeBnDfLgHEfW7o1Tf4BBCvm0s3ph5QZxAuztuZ?=
 =?us-ascii?Q?TvRppXVUe8ntP2r7rJtDtZSAC7Sto+hzuFolYxnVujuNNB94L3StuV/VKUo3?=
 =?us-ascii?Q?C7+Cm+Tfdm0ncu3pJAHojXnH2LSjMsR0B4l0l4KbHG/iD9akYGLKIKmTWl0p?=
 =?us-ascii?Q?dA1Y2AYfkWE9AYYC+EMjAmzbDFZK5JDe+4oAVX/WV9ApfGl/3GqlwmOUY5ft?=
 =?us-ascii?Q?7aV0tUXaVAbzFZiVzLDwRSLzdtz9XBoxwzozy+zzoqqcAnohr7B+T+eTzcDt?=
 =?us-ascii?Q?jXmR1FcvAAkiXXYIWxAo9M4Pu+yZaB9k6ca3yDXcKZc3TxMlH/5+PSvEbYGE?=
 =?us-ascii?Q?mHsMluVlBvda4ko5RGMitlfAJjzpmQOqnT2UWB80e0nI1pztyzC/DKdOULF6?=
 =?us-ascii?Q?kLExeFFi9mVSaOk18dCGVwJwtymUaF9fIoo698qjj3vMefGyhINnxYTRVNRt?=
 =?us-ascii?Q?zHmKrDS+nrHel9AOjoEzixClT7cny8Hlo7+Pb1mwewJXtrGsEJvpgaubaS1f?=
 =?us-ascii?Q?tuAlg0U42Cwlv1AyM5X0EdysKuPknUAiWdZMGlS7l5rXkc1cY1AhVEsq3tvV?=
 =?us-ascii?Q?j5o8vpohAazJLXZMkXgzsXXa+FIQvzwzAdNYR/cawC9ODMTWdcKxL0sR4MpB?=
 =?us-ascii?Q?omEtJovqh4AATSxK9A8zndusYhBdSZ85GwY0drErcpijY6VZ0Wl35457SVzr?=
 =?us-ascii?Q?yhDFYj+Fb4dliB+zXQA9lnnZCer71AvZufyU31lyjh2NNmFVKCN9gbt+xD1j?=
 =?us-ascii?Q?R4t9f/jQLncx73nz73i0c3I5iqDCELHEAoT8/P5JwwTZDm5BdHjgUNaUf5yu?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zW97aBbjRg3rC9WJM8094G2m/tZ0rfd/LK8yrPAbATqRnNAYhZPFPlNsxVFsS+7/gT3NvARsvCqr/Rru/7rO6ZaEoVJgsNptB3t/PAToIEU+TVbA043hkwU+zmfmO9+KKE/CjFH4h1RhjZNbGHQ/3PUrN831ZcQq/DTn7B71/JH60O6c/Napc/5uOLd/ANSv/txgT+is03pdTbXrQlS3uSTdCod7bFJgsunLoUJBfrl0Kf91PDmdkfrDc7mYy/uE5tYrZYEBDg6B57x8h+wPac3Q7a95KWs9e/x/jC1aSpohYx8bzBgVy1FA5p1oalBkjLu5K/yUsmYa2gd/XUYucok5aybt0BiNVzijKOErgKLpPmg+iPVuScRjIETwI/ntA1cy5aucwtHr/buB542VeFAWLIthk9x8SUlvmsuL17FcrIgplysvMiFHOBR2MUVKq1HXvg/5WIgaNlXI4nBD4W5fcxXSQXGDkn4CQpn8z4/AQF4N3cHeJ8KWCnumQzYIkVUm6knvv6CK2CD8ElKnATGaX2MSI07qsyF5y7oHtEACC6o5pet6EV0Wd6EB2L5grn7kJ233dLaVLvKoDcqt0vbntrxmlXalDtcbCc5kgXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4de7b9-9243-4367-8a1c-08de23741ce4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 11:51:14.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlzGMBoDDkNU+G2pv50X6E9RgwI6p3YwWdNNAKC+AHc/NhrjeMZHyekHRQxKwZjTaYIOViOKfftYHGFPy5l2HpPB9jIDddW7pOx0ZomrUEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX1TbveKndgU2B
 pnoHJmz6qAGEWUClMnJKYp+dB85w7j0jfc/jhCXIWuzFpN76NFNBtXq7ndMDUEMqzU58dPcXqxP
 CJfWjiQr1sZWpeEVoXoCcgdu33nVYNBT42D+sQFYyiirLf2JsG0FLxlFjvavEMOEj6iSHnsDuvc
 oYu9dlzL9cQiP+sfgKICTG5itwXL+avoVMvv3IVESd1qYxfsnRzM6esB/MUvPA1kG+2F/T9InBQ
 lxJZ6Q8lnFewU84v1wVzEwNNeLIgSMExMtzyTlWksUz6dzjwRLBNDWbaRHA76scxk1XC4b4TulO
 afzQaLdSsxTISAslLkLJdHxG8Cb5J4iJweGfhW8XMb3eLTCLXbP9xWoKiRv0X5j6+4ZlxC5FHEh
 5El4v0QS+69mO870NsLPuF3tikd48aOdOhi54bEOyhzIpt5C/5w=
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=691717b6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ppERTZZ3S2zD4a8lFBIA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12098
X-Proofpoint-GUID: FpForo53IZPB0_b6Mg4N28KoHsXDhN0U
X-Proofpoint-ORIG-GUID: FpForo53IZPB0_b6Mg4N28KoHsXDhN0U

On Thu, Nov 13, 2025 at 12:28:58PM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [251113 05:45]:
> > On Thu, Nov 13, 2025 at 12:04:19AM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 12, 2025 at 03:06:38PM +0000, Lorenzo Stoakes wrote:
> > > > > Any time the rcu read lock is dropped, the maple state must be
> > > > > invalidated.  Resetting the address and state to MA_START is the safest
> > > > > course of action, which will result in the next operation starting from
> > > > > the top of the tree.
> > > >
> > > > Since we all missed it I do wonder if we need some super clear comment
> > > > saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
> > > > by doing 'blah'.
> > >
> > > I mean, this really isn't an RCU thing.  This is also bad:
> > >
> > > 	spin_lock(a);
> > > 	p = *q;
> > > 	spin_unlock(a);
> > > 	spin_lock(a);
> > > 	b = *p;
> > >
> > > p could have been freed while you didn't hold lock a.  Detecting this
> > > kind of thing needs compiler assistence (ie Rust) to let you know that
> > > you don't have the right to do that any more.
> >
> > Right but in your example the use of the pointers is _realy clear_. In the
> > mas situation, the pointers are embedded in the helper struct, there's a
> > state machine, etc. so it's harder to catch this.
>
> We could modify the above example to use a helper struct and the same
> problem would arise...

I disagree.

It's a helper struct with a state machine, manipulated by API functions. In fact
it turns out we _can_ recover this state even after dropping/reacquiring the
lock by calling the appropriate API functions to do so.

You manipulate this state via mas_xxx() commands, and in fact we resolve the
lock issue by issuing the correct one.

So it's a problem of abstraction I think.

HOWEVER, clearly the crux of the problem as you say elsewhere is that we are
using the 'advanced' API and handling our own lock, which leaves us open to
mistakes like this.

My thought process here is around 'can we avoid a bunch of mm developers all
making the same mistake again'.

In this case I mean - it's a unique situation, in some already _very_ hairy VMA
lock code, that used to be much simpler (*grumble grumble*). We're paying the
price for rolling our own mechanism here in general.

But I think more broadly, perhaps there's things we can do here to help. You
need to be able to go on vacation without having to worry about what mistakes we
might make with this stuff :P

>
> >
> > There's already a state machine embedded in it, and I think the confusing
> > bit, at least for me, was a line of thinking like - 'oh there's all this
> > logic that figures out what's going on and if there's an error rewalks and
> > etc. - so it'll handle this case too'.
> >
> > Obviously, very much wrong.
> >
> > Generally I wonder if, when dealing with VMAs, we shouldn't just use the
> > VMA iterator anyway? Whenever I see 'naked' mas stuff I'm always a little
> > confused as to why.
>
> I am not sure why this was left as maple state either.  But translating
> it to the vma iterator would result in the same bug.  The locking story
> would be the same.  There isn't much to the vma iterator, it will just
> call the mas_ functions for you.

Yes I understand it wouldn't fix the bug :) I'm saying this as an aside, and it
leads into the suggestion I make below.

>
> In other code, the maple state is used when we need to do special
> operations that would be the single user of a vma iterator function.  I
> suspect this was the case here at some point.

Right yes. And perhaps so.

>
> >
> >
> > >
> > > > I think one source of confusion for me with maple tree operations is - what
> > > > to do if we are in a position where some kind of reset is needed?
> > > >
> > > > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> > > > to me that we ought to set to the address.
> > >
> > > I think that's a separate problem.
> >
> > Sure but I think there's a broader issue around confusion arising around
> > mas state and when we need to do one thing or another, there were a number
> > of issues that arose in the past where people got confused about what to do
> > with vma iterator state.
> >
> > I think it's a difficult problem - we're both trying to abstract stuff
> > here but also retain performance, which is a trade-off.
> >
> > >
> > > > > +++ b/mm/mmap_lock.c
> > > > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > > >  		if (PTR_ERR(vma) == -EAGAIN) {
> > > > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > >  			/* The area was replaced with another one */
> > > > > +			mas_set(&mas, address);
> > > >
> > > > I wonder if we could detect that the RCU lock was released (+ reacquired) in
> > > > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
> > >
> > > Dropping and reacquiring the RCU read lock should have been a big red
> > > flag.  I didn't have time to review the patches, but if I had, I would
> >
> > I think if you have 3 mm developers who all work with VMAs all the time
> > missing this, that's a signal that something is confusing here :)
> >
> > So the issue is we all thought dropping the RCU lock would be OK, and
> > mas_walk(...) would 'somehow' do the right thing. See above for why I think
> > perhaps that happened.
>
> But again, I feel like we could replace the maple state with any helper
> struct and this could also be missed.

I disagree for the reasons stated above.

>
> I'm not sure there's an easy way to remove this class of errors without
> changing the basic tooling to be rust or the like...

Well I like to be optimistic that we can find ways forward without that.

>
> vma_start_read() is inherently complicated because of what it does
> without taking the mmap lock.  Dealing with a potential failure/retry is
> equally messy.

Yes I agree.

>
> The locking is impossible to do in a clean way since one caller does not
> take the rcu read lock itself, but may return without it held in many
> scenarios.

Yes absolutely. I am not necessarily in love with how complicated we've made all
of this and I am not sure it was justified, but unfortunately I didn't pay
enough attention to the VMA lock seqcount rework.

>
> >
> > > have suggested passing the mas down to the routine that drops the rcu
> > > read lock so it can be invalidated before dropping the readlock.
> > >
> >
> > This would require changing vma_start_read(), which is called by both
> > lock_vma_under_rcu() and lock_next_vma().
> >
> > We could make them consistent and have lock_vma_under_rcu() do something
> > like:
> >
> > 	VMA_ITERATOR(vmi, mm, address);
> >
> > 	...
> >
> > 	rcu_read_lock();
> > 	vma = vma_start_read(&vmi);
> >
> > And have vma_start_read() handle the:
> >
> > 	if (!vma) {
> > 		rcu_read_unlock();
> > 		goto inval;
> > 	}
> >
> > Case we have in lock_vma_under_rcu() now.
> >
> > We'd need to keep:
> >
> > 	vma = vma_next(vmi);
> > 	if (!vma)
> > 		return NULL;
> >
> > In lock_next_vma().
> >
> > Then you could have:
> >
> > err:
> > 	/* Reset so state is valid if reused. */
> > 	vmi_iter_reset(vmi);
> > 	rcu_read_unlock();
> >
> > In vma_start_read().
> >
> > Assuming any/all of this is correct :)
> >
> > I _think_ based on what Liam said in other sub-thread the reset should work
> > here (perhaps not quite maximally efficient).
>
> No, don't do that.  If you want to go this route, use vma_iter_set() in
> the error label to set the address.  Which means that we'll need to pass
> the vma iterator and the address into vma_star_read() from both callers.

Well that's what I'm proposing we do re: passing in the vma iterator, so it
seems we're generally aligned on this, but sure we should use vma_iter_set(),
ack on that.

>
> And may as well add this in vma_start_read()..
>
> err_unstable:
>  	vma_iter_set(&vmi, address);

Ack.

>
> >
> > If we risk perhaps relying on the optimiser to help us or hope no real perf
> > impact perhaps we could do both by also having the 'set address' bit happen
> > in lock_vma_under_rcu() also e.g.:
> >
> >
> > 	VMA_ITERATOR(vmi, mm, address);
> >
> > 	...
> >
> > retry:
> > 	rcu_read_lock();
> > 	vma_iter_set(&vmi, address);
> > 	vma = vma_start_read(&vmi);
>
> lock_next_vma() also calls vma_iter_set() in the -EAGAIN case, so
> passing both through might make more sense.

Yes.

>
> >
> > Let me know if any of this is sane... :)
>
> The locking on this function makes it virtually impossible to reuse for
> anything beyond the two users it has today.  Passing the iterator down
> might remind people of what to do if the function itself changes.  It
> does seem like the right way of handling this, since we can't clean up
> the locking.

OK, I can put forward a patch for this if that'd be helpful!

>
> Thanks,
> Liam
>

Cheers, Lorenzo

