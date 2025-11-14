Return-Path: <stable+bounces-194809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624EC5E92A
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDEB24ED7C7
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD02D061A;
	Fri, 14 Nov 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwJWUxWv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tzv8pkNC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5602D3727;
	Fri, 14 Nov 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140733; cv=fail; b=O/OqWp2O5YFlsBw0/jT3G53hJCYdnD5QenFaZd6+Kt7HrCUmgcjK3clVbmLrnwgq9u113H7MB/kJu4rYzmijJTI5scVJ79YgUoQckePdZCOo0SUWuhp0DAA21/l2pw9ObHWT1sN/VQtwDR/aAMMW3FArM3TTIpb6ScZd901zwgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140733; c=relaxed/simple;
	bh=WqPijZhpPnKDJ81XhrgPvZwj6OXe7J4DG2dADB/Ands=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QrQJLmlaAAv+IGVuFnV8h8Hjb7GoXLJBxmU9pbIQJM/NfoiXXTgjmNBhw7sylphmcS/tbKWsd2fqc8puuF9C90qBHE+y4C2wLean3dWmf4DftqwNlVVs5TfptCrXOwoMbVBpqDDxF7bCklQSSaNUnxWRMT9km+jk03wOeMzAmo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwJWUxWv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tzv8pkNC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEGuIeC015308;
	Fri, 14 Nov 2025 17:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qIbFXfjwBds44nvSKJ74LgKLVgp6kaxNLbsC/a2vw3g=; b=
	WwJWUxWvwLEbZ6SIkG57tgqfxPLNopZT5WRz0fN0DmOqDgzNJXpERNuL7It31I59
	sugbJvo8KbAHs1kjdr9STiNS276u9Fhe4H87N9r+WawLEb2aB8KiYyf0MgVKYaK1
	F/IuWplB5aYO8BzBgPLa/J3wK8HJSrEmY9VOZ5mjdsXK75UG+sOJ2fuOF9bUB+Ma
	6D/Qsqs4g41V2Jlp8spA8m5M10/TCu0uPG48DHL5oK9BR9jFHQUCEcpk9YxTwM46
	3InpQjQteHqdUtiD6mDPWjkcUDRLmbfVCVcHXqQCmTriHtb7p3p9HCxu0+6zdRTR
	A6/lipbx7ts6JRlK82qYvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8uhk18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 17:18:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEFduNr000425;
	Fri, 14 Nov 2025 17:18:29 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vahbjae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 17:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbwagJS2hLnlBiz2GdDGY6q1tHUuJ+ITQeALRScPdB95Q0o49taafwCXwkw7/J5HtX/oqKDJFTnIryr8QKryaEkKUa2c06bAEuzjCbLNt4cMfq8OfcfqPNW6ZR2GhAci+CJWlDZ8kg1OAFUsvVpVGJL2uaX0WCSSclFA7Eilmm2SLyEHqhf3CSAgzYs1uwJd15vFaSg/+QdXY4/5cBypuyZowju57fL450HDJuH9bqq/vi1jha4Rbu12P7Xxg8n/kzecLgumo1RrW6WYiDax0+BANgd6PXO9oCqx0UiNYRYwMJyzfjcDus1PtUzEyjnDEkxOsQe5uFCLKVeSZYRqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIbFXfjwBds44nvSKJ74LgKLVgp6kaxNLbsC/a2vw3g=;
 b=lX9BlalXoYrGRe8pCzCvcqrpOVN5yhDClNBBJ6D0F3SsEnqbaCNieJiPFUBroUUqLUSaJS859lE4JYBX0HbiUop5CgdosDxg7l9rAxI/AS016fgYzL2FORjK3JgqcfNNnX8gikXrzjtJv5K1EtIZWE7VkY5EeB1ZYVClbD1OmliT08ulBMFLQR0TCxbrtOks/RXTymU5n6Srhr67B/Rzcum6httxHFIw03ToiJJwnCsNVRsFB2ggaXsfLQVdKbTCh9t936Xa+YszQxwURhE4M2pouuS8Xj1csN5qdlI8HYLFnoW8YmWFLB6VPlQSLxSfOwuH4dU2+gK+TnBtxOc2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIbFXfjwBds44nvSKJ74LgKLVgp6kaxNLbsC/a2vw3g=;
 b=tzv8pkNC31yhLAQ2S6t5mxvcpQZk/dCuSvfPzVoPTaYbmua8f/aHdm2bau6isH9cY85wRngjVnh11OovTtqmIPRZPqi3PT/HJ/kMzfRofSn9rKRr6ZKF6k8W7qW1kGjYw2kBfkh1tsRwdCtz38dwNrKHSi8sFWtfJg+7UNgAhbY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 17:18:26 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 17:18:26 +0000
Date: Fri, 14 Nov 2025 12:18:22 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <67rs7sdyfvruaykw3xdap35eopeaafbnqw2szcubq3bk2rgrrk@oq3yd2zawoej>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, stable@vger.kernel.org, 
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com, "Paul E . McKenney" <paulmck@kernel.org>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
 <8935c95a-674e-44be-b5cc-dc5154a8db41@lucifer.local>
 <ajnzlk33uzmbt5tdrv7m7cr2hktt7acuruunx4s5fwwvroc5ad@7hnx2ys6gj35>
 <1885ac9d-1a5e-45a2-90d7-f4ecb5848937@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1885ac9d-1a5e-45a2-90d7-f4ecb5848937@lucifer.local>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT4P288CA0026.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d873e87-8d1f-4e5d-bf96-08de23a1d249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cf6KC5gUyiWRwjCPBidZPmIvN36imXnUsFFA4pwcoL8Gk8B7kYaqspH1UBZW?=
 =?us-ascii?Q?q1EinLRXUGiJVzD5Isvgf9dP6YQzpKHuPEgJJi9VC4+1pd4KDuvKWcj+cr2Z?=
 =?us-ascii?Q?eBeP9Zsl03xZq/A7p9tAxbg76eYI+DEYvHlbLJB5I3ZP6V2IsNlUsXVsip1N?=
 =?us-ascii?Q?cxWc/1JVLRdYikxA+bJFeGIwlsAWLTs/HbBHQOQjECNQbLU8BPG/3/ToLRpj?=
 =?us-ascii?Q?p4ppLvLDL94Li+5Yewn5QVtOHJE0vmCtqDGaw2iMbfXsPhgB7kH0ypluc9gb?=
 =?us-ascii?Q?0C7Q5iA4JBY5BAawlGmNAGoxhnRgSi9e0AHOhRh6I5GWY89iwiYsV6YzyBXS?=
 =?us-ascii?Q?kXY7hspMa3wknwRf24aNvoB3U5ZxrKcSlcHP6/faWvy0f6UwNtT/eBq6G8Mg?=
 =?us-ascii?Q?fhfkJ6szPR30QJjQAi4mPrAt/jooMX8RrADxxKuVWyXYyWRd2o/rWp7lJ13h?=
 =?us-ascii?Q?+U81R8si1giQ0OylkkMBJyhRBAhaMJ76nqKeXwRdOjQ+G0ukPRsRdjpM5imQ?=
 =?us-ascii?Q?QSyVDOiHwiJ0i51D+scsAkn5BFcw4YHaU2dnkPFpl3QR0d3Re+autIsb+5j9?=
 =?us-ascii?Q?V4431WGMStA6wSmGlEhe/yB+LY0RjZ+4QQ9Rnaf3Sl7hJFRTuzvJm3IN/6QV?=
 =?us-ascii?Q?nMwrfA7NGBinesP5oA2F4oxG29y070uXJ6/vhmbxHyjaOPLqDmSV6dI9ezfV?=
 =?us-ascii?Q?liAJzsMrzF/PZZsxTTJfB2j+wN7rB9SX5oce7pwt2ZfrB2vpTcvf0l2sNpwO?=
 =?us-ascii?Q?VGwI+g9AluO5TSN/B47RCWWJk715eik3RkfMtYSKrLqzko3edpVt5ngUCcpQ?=
 =?us-ascii?Q?jL4OlDec5gIdHlSKUmCabLVT90pCElQic8c+fH2ylUi4ppb+nkd03yBzODjM?=
 =?us-ascii?Q?JsedUmYy6W0LYl00lL4f/xD75dBP/lOKnLPHLf1D60QlZcGe1ZKOmZPeUDCv?=
 =?us-ascii?Q?5UlBDaTx0JoKwqv7X+sulaNZheEVE4L9aonxsIzAMSOusid0VZR8BgIlBVzl?=
 =?us-ascii?Q?gQevJLvjbpnrVWAZcAPTBSHIH+3PG99n8YDkjN9klqxBqeFvG6M7WXAKhABQ?=
 =?us-ascii?Q?7ABoM/ZDelG6IBqJ0hvly+FUMPXx3axlFK5/zUq4GyD6lfFpdjUzPdOHKRbR?=
 =?us-ascii?Q?sbPbctx95nghmF01ImUApv2zcFxXvyODeRhvwah2xak8jkKGRJrDKIrukVOk?=
 =?us-ascii?Q?qQNjwEkuZpaQFHntEzGM7KqLJ2G/aiXX0Su6uIYkY/m9VUpK8/P8sioUsvxB?=
 =?us-ascii?Q?QNT7DPxjI/b+PXN3xA5OkdRlS2xv91wpem8c0E6bPum289188PnjY4Pum22H?=
 =?us-ascii?Q?SSEWPD+Z1lDZUlWOoel9OmtFTLq+WdHhxkEWu8qqSj4IQU04jIaxv6g4ai7R?=
 =?us-ascii?Q?GYrbzsMbPM3uPf9XXUi0PaMQ2Bl6o+axQ54g7RjuWmYy4uAoLdhWbaA7V3tR?=
 =?us-ascii?Q?AHlVVXQoSIEEtHobT2APwiu0Pso9HN3A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qdj4kjEoPVJhBScO7jK29RML6Mk5E+VLZRX+1x6pov8rZfVVEUlaDrn0Fyq1?=
 =?us-ascii?Q?ckPm+7+ElY+X0+8wlGBreoNCwFKkXsV03s4Tnz20/u2N0Puv/NhmABDWPeNq?=
 =?us-ascii?Q?IDyIRfF8puTZj9rOGkWUol9ab7fJ2cXClcHUYYaHf8IMLpN6GGdEqmZMbCPp?=
 =?us-ascii?Q?jey8h45v24yINT9O+ut9tv223tIEdY0ErZQ2LaxfcEYYAwRJskq/3l/kQKea?=
 =?us-ascii?Q?fAg0e/PLkj911WLx+LTR6bBWLy2RqZ7F6wzPTSJN/1makK6b7XdYD1FC6GUW?=
 =?us-ascii?Q?0Mwpq+EE+JyPtOMInmQjUkdIgqvH2OEe7Owhhc19lb+SGb+e27Dp1jIwiNo1?=
 =?us-ascii?Q?i2aamkDrtByOLUw1tdoxFQVEmt2MvFkbcd+9W1cPANn5a5wIzPMaKPWl1FaH?=
 =?us-ascii?Q?9NYSAkesHqJFsniIzG5n5fNcTEgQgKpLobsUjr7ELO6GbWluayjLmYGZK+zL?=
 =?us-ascii?Q?nCWf9zu0LMUGLdF9+RBKazYL6ZHOreTbg7V80Z+/S90cPjfFJU7RnJUgglis?=
 =?us-ascii?Q?WYLGr2RbPtWrB9q/5Mcdhrq+0OMb2DGjbX6ptZ7W3GuwzOa+7V2NIk4x/LPN?=
 =?us-ascii?Q?C49LNzngfcAV6br8UtX5vy84T5sbbVndEupz8JH0mac1g6TwxhF4MDcqyuog?=
 =?us-ascii?Q?MwCpWPcUJnDuoeXSgIRQKRhOt0gc0av1ST6E52MXm0u+O2kQ61/aE/sgNt9b?=
 =?us-ascii?Q?SYnpRs5+g5g9XAc7eDqIWPPQ64o464vJsxo11xbzNSpCKaIrCZxNdkI+wIwF?=
 =?us-ascii?Q?3dQ5Xhg/JPzxWq96XBwlK4s/K+aBsCXLt80oHSY/nM212N29Sok7SflEa/0w?=
 =?us-ascii?Q?8OArLrziHb+mdMvyzyfF254dSzkpLUVPj1NHAfq9J8GO+SV8lVsrhaskFDLQ?=
 =?us-ascii?Q?P29DsTf+VVRwQHMgeB+YcpQpsiTxNnHI/8eqHDSn9Ph87s57DBrCuiNaFZNZ?=
 =?us-ascii?Q?KpeeXSczS6NDT2SuJEWC0s4J43TQiCbzUXt8tKKZs/GIG8UWOLPRAA5uZOzp?=
 =?us-ascii?Q?ervTr0eHCYGu3J0SCehFMquyuapBgAhTKXZGTZIS/8zyUz6rcWhzP2/0Przl?=
 =?us-ascii?Q?AupiV8eM8fk9gotKCs8tnP0yzKGMCJx6psNctcVY9LraAqbO9Jom25KqnxRG?=
 =?us-ascii?Q?sruAzBsoHcHdiJZLXf9K11uMttJgOgh2oA9u3+dfSiXjUQAnrLZMr+MNH70C?=
 =?us-ascii?Q?WAz4XDNwDXvVlmkLHrT7JrkK01QedW51Q14iKA8G8tD5ic9SmVeIMgiLAJAa?=
 =?us-ascii?Q?gV6ARtzdHJ7Rg7ZMQp1rLUkq/iCeNtPskrNEuktJ/UW+7KfQV3YXzGMlL9Yj?=
 =?us-ascii?Q?K28PZ3xFp639abXDebl9ujtPBHWNWCoa+dG6Z6pYctcil9Ncs1GRaJFrJ77j?=
 =?us-ascii?Q?AthCG7NmSchUONux7+bpoMI1oqQfTqeqrqi8g/wwuN7JxizvnyYxqVwuAE4J?=
 =?us-ascii?Q?rsXcOWDrX2f+ivPmQNNAawabEVSwW3ZlXKGfE4q3ZQF2e4YIi6QrTaVjtHSf?=
 =?us-ascii?Q?n2wDQqMVVhGNb0InVluucPiMdHnXG9y6ybw4hAtOooel+cM2D2J3nrQ1+FfD?=
 =?us-ascii?Q?3CDS49Eu7q9l0N4B23/JZOSGRJtELyeeMtgvoV71?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QuOUd2OPURv06FDmY8+hso+X4VzaGq75vQ1bHZw/WV0u03sHqncxbBXZMA7jYf0BR9byBawDSPIi8rFSVkn89Y8iB4DN+VvSHTiavwF0zqhOxFDj1YmCvVFlJe6VCO1IMt3KR5rbl7BBt3q7tbF3jLAHNgDNCl0Ivu1N6drlyxVA+RGoPM/nOKORNuONKBtq/tRr5BQFmLhyqZsluHCeXAXsXk93bHH9k42fE87ks/mSJT4z7ICyv5j+J49LKjvXbCiLZH2mqPoc9oxXLRTVYNK4czFKuIg34EK4r/hPeg353LE8s34JFmQqvuceJTJXM4GITH23fJc9KN+qwtmYd9TrUZLbj89ku8giQx01MH4Q37aDc1EgJYU4MYkzbHraj3KIqO5bzlGBUz+TBpa9hxUIyiI2q5VDseA9L4ftlnMuEqYL9XJ+HzwCFeUbaUdzCfag4yVPnD3op8iU8ychrZNwfuzItrpQD1xoC7H0wdDnxvLrPvHTSVDFWsWY5YCAhf7pAsmxRHqtCAYOKizeoQT888bHnEmKqChgnaDvoOIn/ZJfA9DXAWw7spCX0Grp4jxYZXtJxAY0uEcznZt9MP6Wju5G/X0vGwxBm3TMK30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d873e87-8d1f-4e5d-bf96-08de23a1d249
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:18:26.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKxev1jAUzdyrUxWh6MMrxzBwFtxjwPFNIYNjxHDlLKvmMU+VEzIxUGrJ7Yc7/YfM8AdSS2MoGx70Plc2V/wuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX5GnuAPCVmpjp
 vtDBfx0nYd4olj+AO5mptC5ur7LMwdXjV9lywQ2EJMcb/zB/JI4D1vS03NdAUFD7KXf00ogup3E
 pjOncXDzoxdTVM3vFn69S1Vn/CRlZa+fK15HeMjtQf03f99ufAg5Dly3u6uJVKTznHXlJ1bkIhu
 cymAn6GdKZW+OfRpQO8ONnT0GSWGUTG1UkvbxkzDLBxUeHD7gt7e1V3JCtYdV2fDAURLggmSEnf
 i7ZHGN1V9x4dCIAHkSzDdjZIgG3HpASL8mFUveivbE5OdvG6rEl+pPk7vBwdOa2RrfpAYDXCSu1
 iUHL1hYsp17gll57v/txshfau/JL0fsbL71BM7cKhvV5/+MdvXf46W5ztK4EmJnMF7ASSpT7CQ0
 Yq3deW8+9IunJeulxbmmtXg7wL8qeVA2Pw75NQYaKogGTPxL7eQ=
X-Proofpoint-ORIG-GUID: X_GJQemciKZ5cD1-nv0TTwGVzAYX6RVk
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=69176466 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=5WB02uL4bhdo-hY3U9kA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12098
X-Proofpoint-GUID: X_GJQemciKZ5cD1-nv0TTwGVzAYX6RVk

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [251114 06:51]:
> On Thu, Nov 13, 2025 at 12:28:58PM -0500, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [251113 05:45]:
> > > On Thu, Nov 13, 2025 at 12:04:19AM +0000, Matthew Wilcox wrote:
> > > > On Wed, Nov 12, 2025 at 03:06:38PM +0000, Lorenzo Stoakes wrote:
> > > > > > Any time the rcu read lock is dropped, the maple state must be
> > > > > > invalidated.  Resetting the address and state to MA_START is th=
e safest
> > > > > > course of action, which will result in the next operation start=
ing from
> > > > > > the top of the tree.
> > > > >
> > > > > Since we all missed it I do wonder if we need some super clear co=
mment
> > > > > saying 'hey if you drop + re-acquire RCU lock you MUST revalidate=
 mas state
> > > > > by doing 'blah'.
> > > >
> > > > I mean, this really isn't an RCU thing.  This is also bad:
> > > >
> > > > 	spin_lock(a);
> > > > 	p =3D *q;
> > > > 	spin_unlock(a);
> > > > 	spin_lock(a);
> > > > 	b =3D *p;
> > > >
> > > > p could have been freed while you didn't hold lock a.  Detecting th=
is
> > > > kind of thing needs compiler assistence (ie Rust) to let you know t=
hat
> > > > you don't have the right to do that any more.
> > >
> > > Right but in your example the use of the pointers is _realy clear_. I=
n the
> > > mas situation, the pointers are embedded in the helper struct, there'=
s a
> > > state machine, etc. so it's harder to catch this.
> >
> > We could modify the above example to use a helper struct and the same
> > problem would arise...
>=20
> I disagree.
>=20
> It's a helper struct with a state machine, manipulated by API functions. =
In fact
> it turns out we _can_ recover this state even after dropping/reacquiring =
the
> lock by calling the appropriate API functions to do so.
>=20
> You manipulate this state via mas_xxx() commands, and in fact we resolve =
the
> lock issue by issuing the correct one.
>=20

The state is never recovered.. it's re-established entirely.

What is happening is, we are walking a tree data structure and keeping
tack of where we are by keeping a pointer to the node.  This node
remains stable as long as the rcu or write lock is held for the tree.

If you are not unlocking, you could see how keeping the node for
prev/next operations would be much faster.. it's just one pointer away.

When you drop whatever lock you are holding, that node may disappear,
which is what happened in this bug.

When you mas_reset() or mas_set() or mas_set_range(), then you are
setting the node in the maple state to MA_START.  Any operation you call
from then on will start over (get the root node and re-walk the tree).

So, calling the reset removes any potentially stale pointers but does
not restore any state.

mas_set()/mas_set_range() sets the index and last to what you are
looking for, which is part of the state.  The operations will set the
index/last to the range it finds on a search.  In the vma case, this
isn't very useful since we have vm_start/vm_end.

The state is re-established once you call the api to find something
again.

This is, imo, very close to having a vma in a helper struct, then
calling a function that drops the mmap lock, reacquires the lock, and
continues to use the vma.  The only way to restore the vma helper struct
to a safe state is to do the vma lookup again and replace the
(potentially) stale vma pointer.

If, say, for some reason, during copy_vma() we needed to drop the lock
after vma_merge_new_range().  We'd have to restore vmg->target to
whatever it was pointed to by vmg->start.. but vmg->start might not be
right if vmg->target was set to the previous vma.  We'd have to set
vmg->target =3D vma_lookup(vmg->orig_start) or such, then re-evaluate the
merging scenario.

I don't really see a difference in mas->node being invalid after a
locking dance vs vmg->target being invalid if there was a locking dance.
I also think it's fair to say that vma_merge_new_range() is an api that
copy_vma() is using.

I do see that hiding it in an API could be missed, but the API exists
because the mas struct is used in a lot of places that are in and around
locking like this.

I'll add to the documentation, but I suspect it won't really help.

...

Thanks,
Liam



