Return-Path: <stable+bounces-212792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAOpFZiOe2kKGAIAu9opvQ
	(envelope-from <stable+bounces-212792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:45:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D3B2618
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DA283013EDD
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685BC344DB5;
	Thu, 29 Jan 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jR77Mx2y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jpFXlRFA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675D344D9D;
	Thu, 29 Jan 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705108; cv=fail; b=kWz4vRRaQkxRP5Osw7wQNHKQ6izIqM5S/EvNQmnba3xzg+DyAHpMlR9XPixJZoEXy9rX7cEU/M6Kc9hRW4LgacRtvLH5R/AFbuADrd3WYZkVyVB3LPLoVc8MX5ZMin+aOM4g1ayjZiM6ArIeAt7BgsKHLAsfCfAxTo1hgGkueDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705108; c=relaxed/simple;
	bh=3W7vjDTwCOvetTuHeB736GsxemnbGn/Oabs8Mb8nWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n86hC6Y01at8lwX0FDfGbLFpGzUImSbYTiaR3htMFlV9PVsNPH2ROpja64SFiH7AMajFY5EkJBDJzNawGDeqHbh8TlIWzieDXA9TclkTcwqx8ljRKGsHw0f/eMOQynGkhUt/4YmYn+9E/Ep07nw7mxDFvHo3RgzEXWPYUwER6L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jR77Mx2y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jpFXlRFA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgLPC299137;
	Thu, 29 Jan 2026 16:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=T//YAfnJVzO6DVf4k3
	ecrSKiaXRDycpG04lRL/qoKYo=; b=jR77Mx2yEFTRwklzzzFub318mHsEeiYj9x
	KT+uOEmkjZjiBbmRStqU57oTw6xT8zCiDH6Ke/Cs6PXPOszf91PqyJjUZZXjC+IL
	7HnAf/AFCN3EHaCjB0Y5PaxvclK5I7ENNWUQVEDZ0Il9puuWXePXepwZPc9YdOqD
	kG6sL0rdJQs9GfSVo8ERWgI2YN/q5DBIYLd2VxVDGDlfXAhFuBHb75pjNl0Mpjlw
	/kuAEFCy/lIDO0dX+LUisho0oe43FM2+OSvl2+LKMNu53TPFpxYSf6JqaofSnVer
	URbD/uCm7jsiZYjbityk7zGcz9J4YojReRcNBOqnRm3uF2yq6UEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by39rbmp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 16:44:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TFhF5R010020;
	Thu, 29 Jan 2026 16:44:35 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhcjnt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 16:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHNPB8d90wMGO41DW0nO0baUDofbXQEeyKniT9nOPJU7Q0wrlc/ME24M+Ssw4mJZSUH8QU64mh4eW562nEqWy7QJZCgbJ5HQivlCqYedPHl/idTWQ7g/GEOIHPrMdmGZwXnMdwUvswkdPsC75NDV66g+9ElPRl9GEiSXhzi08ZL0JzaRLr641OdVCsMDr3bCp/MBi2HYo7NDC1cK1A6sKq/cqqMP0Ah4ct8V497AamrISy9ifQkW58yWZ/ii7E639ijsckjHqEERjfBrrlMa0GceFDJACgKtQtbQlI7EhcUe9La50Nn4iolesDKNJav0RbVk3Q9s30gq7U1KG7Tg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T//YAfnJVzO6DVf4k3ecrSKiaXRDycpG04lRL/qoKYo=;
 b=wsCoWzi/XQMktp7gAd3rMOQxX5++N0bpVKz/BZWc9+85JxWBzIbu8c1rYiq2iR+JV4TK7dFrITFcHDINbLxVuHvdi6dGcj0rTb1rupVjXkr2m/2XcDP+o6OT3Xdv4uY6Zbhh+CfD4XwnI00Oy7BBvnAjYCn8ABMFV68n1tqS+7oCuuSq9xoWPhuSZJyiCoWle+UhbC8n9wgKBHZXgoANBmbP9pnXvaQuvoJKXwfUWQIuN+kN3uP0fAWu29n1Ymo+kbzPD1/GZyz00dCefXMeZHGDt08dAfCUiPngqJI6vUo4w55P5U1A0E9q+PH5V3CAWUtTOijrrWIdJLlfJ0vz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T//YAfnJVzO6DVf4k3ecrSKiaXRDycpG04lRL/qoKYo=;
 b=jpFXlRFAabL3xaWFTko3H7SFsNk8s7DvStjbRLsOuBtRfMyDsllMO8m29fk4Ou6vDZP2bJ4TckNs+RMPanur3YpmFNwnZrfiaDmKocj1IJybmZWTLONdmuZDpVOCzWKv4UVG1k23F5E+1o0OhNZrLW7nhXDacRclzZqrOJWC+fw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 16:44:27 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 16:44:26 +0000
Date: Thu, 29 Jan 2026 11:44:21 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <aewj4cm6qojpm25qbn5pf75jg3xdd5zue2t4lvxtvgjbhoc3rx@b5u5pysccldy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Hao Li <hao.li@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com, kernel test robot <oliver.sang@intel.com>, 
	stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
 <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
 <aozlag7qiwbdezzjgw3bq73ihnkeppmc5iy4hq7zosg3zyalih@ieo3a4qecfxg>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aozlag7qiwbdezzjgw3bq73ihnkeppmc5iy4hq7zosg3zyalih@ieo3a4qecfxg>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 894ca28b-bd61-4ab2-8d41-08de5f55a9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zhjZLWvUR38ZXyh0PAnXAtJXkmYEjrWqpduOrm4Zl1eGgRJkQTgd50aDZvM?=
 =?us-ascii?Q?q8/eeI1EWlnsa0RJQOlcEt0+kLlu382obqMFLH8bgepPydQuaSRAl+WCHkU0?=
 =?us-ascii?Q?ECqFheHP1pYaQNv6jcmEmyhZ75Q7PcA7HeZ2zm9pB1+r7nHyev0HTfy3wDAt?=
 =?us-ascii?Q?Brhsc7ZH07QxQZh/WMMUKT8FFlC4h2clp54LgqSxqVEW1R1ndDJGvnrJAhR1?=
 =?us-ascii?Q?gfwWmOY4RU4aB7Sx8fVvN85v3ehNbH01oUtW3LWvHNYAjBbd7rIIofsHTt0+?=
 =?us-ascii?Q?lgllW3SHpio2FQEkClHbLZduidNZBMpMp602INUJp1fcC9yMDrVh3KpZtLRf?=
 =?us-ascii?Q?NW6XpBhezFRxAZF6c2uosM7Iy7ZadU+guQsCExeivjtLrSOmroUZvrHk3LI0?=
 =?us-ascii?Q?LC0R0rwHB8HPILsAZX/fMPeWyxHUpVzOyMu/6EefCkq6D6f75b92Yk7bYUYK?=
 =?us-ascii?Q?iX47k6+FhECvEEYiU+3BzSCvjWVxBPa+H1AlqUKqgyercPmNKDijvqT3uIwZ?=
 =?us-ascii?Q?Bk+fkiUc0NeRube7uS7tlt0Ni84ZD6gLQ4FlkPMfHVNKlhJdVHXKjhK+c0TW?=
 =?us-ascii?Q?JfwIILYIe1qCObig5y8OU1UaD/QqizCFAYLoJG4G2/qYs+1txQlgN5yb5x1Z?=
 =?us-ascii?Q?RlLiiCeFaWNmhls4pGdaFMK9kOG/xPgubG1uqfuOmpmzH+U9yC4zeHb8R26S?=
 =?us-ascii?Q?Yxoq30sbUKoa4Fivmd9poR5HTvzIoBdgkzn8QI24Bk+PIkgk92D0aqV5eHJr?=
 =?us-ascii?Q?2mSAb3HWHv3lreIfts6keNzR01I/kmbgcey0+MsC1Vjotkk8vl8yAVwKDfDz?=
 =?us-ascii?Q?HOeOdYpozdGeI2QQXuZ8G7ji/qcKDxk3s8o5LJ6ghagg5bf9h68QGmC20f3t?=
 =?us-ascii?Q?IauH8MadUmeskrgMNaF2RzQzUYIfWhT/eKPnTya71g1gvIF6P243sVvSrsrl?=
 =?us-ascii?Q?0XgFaPHFcvmGRU9vdy1F/qbfuVnW/4RhepPvFSleHyF+C30pNBafsjqO9P+u?=
 =?us-ascii?Q?THOMyAsCsryuDQ1Lz0rgo+BsR4UHA3dw6zRewDupADay9FZ5zWIJ/nzPYl9O?=
 =?us-ascii?Q?56ImXjr8aw3s4VJX+IfckDqqRgd7bGQy4WpJmDeqB/LgNNaO09avQuppDHy4?=
 =?us-ascii?Q?my4NnH6Fx55ecYwcda9JhHYXZT/r3f6vUfxw2rcgDF/Iz1Dwv9/hE9pR1ojp?=
 =?us-ascii?Q?qDkIE0Gnmvg10az7ireiW1u+L1MUKVXgow4enjmeIexqloiEQmuBICSVmTi3?=
 =?us-ascii?Q?QL0kCfXdybdOomRD74ZBKO5jft7iCN6YG3Gc5Nejd7tPgEh/Q/a+4GaASppT?=
 =?us-ascii?Q?4VV/SoRqy42Yv/rgexmnJQ4bF6M0UdsVVN5fKpYZiOj+swNX2hRc3Z/Gaq5w?=
 =?us-ascii?Q?4LViSQRQXb2L4glh9UIF00x11DSG6d0FzQ8njpZCqPWzHjcrRQACT4fXGH9k?=
 =?us-ascii?Q?LqG3Vo0x2LxzoeV4a4uRSJCvqeEgtd52Y/wWATAfEH7gYdTv7uMhwnvyGEg+?=
 =?us-ascii?Q?UObUEEgg2rznNENWw+C93Bh+ewuGiySLqZOnnXl9RPEEbd0AZqFbTtL++uUN?=
 =?us-ascii?Q?l0XFHIhSZmkKFmINynE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8BcMrlGa6/VECXyvRzwpxlEcjwduVDfAJCVzO+GgLmP4N6B9GvcwOrPaz2jb?=
 =?us-ascii?Q?cwnYfKSmw9Yp9ucNP5vgswTOn8kB3R1Wzb4OKDXLS5OaTzj+pGPRIQviVo3L?=
 =?us-ascii?Q?D2gzV1bLlgAf4e8ygruJAAxPqZg97LhQeVRwsaxl2JJV+gVFLO4UaaLg/ZF0?=
 =?us-ascii?Q?YRv+I31trX8N7ZInCnFo+0E8uewMhbJjfZGBIsnIj6ggsVaTAENEA+eoiYNv?=
 =?us-ascii?Q?t91g9hA7Tupi/Weuh3pO9OGWzRkuwj1mUaelc7UOHoz6ygLpsQ91IEQ0jUTn?=
 =?us-ascii?Q?uVdq7GyeSvjo2NTqdbJtz2OqZnzeaF1XSvzP4uI6SfEvCxqAwigMgGf3HaXn?=
 =?us-ascii?Q?J22nE4eI2bDhE/LoEELHq5AAXdKQYzr9BdUL3GPIPcqq2mz1FMfn5bbt56Co?=
 =?us-ascii?Q?cKGBOJdnHgmOcwvSoFS/aKBbSXcGG4x86TFg5iQyUUZNNZ/3cIWyoo/d9gS5?=
 =?us-ascii?Q?8IEVTUnX6/s50ea2ru+HDze/pYLOY7R+V1o5XAkxtbWxr41SsLAhzfq4fAhR?=
 =?us-ascii?Q?ZeWqTgoFM/O4Re9Brjg5ytYr2qSDq4njLS1ftfuSsfevHdorcdLrwyFdEntw?=
 =?us-ascii?Q?+XaTXgRemK5q09rQyhcYt28qbpUpzQ+XBt5wDKAMtf91Yl1haA73M7m3zpFF?=
 =?us-ascii?Q?ih1yJlU/dzLDlLCyL/CuK0TbLUWRWX8LRGIAjYlEUzU4/5EXC2cBdzeEfsuP?=
 =?us-ascii?Q?4yczbJ+Fbjr824evcY1augO77ZArQOAlODbABeiMRmk7KSjR21/jOUiWAzro?=
 =?us-ascii?Q?hkwqgWxWkfR0cHmBtfCInkFnvsrYPqwOqTdNcRjsX2Sd8LnTKmcXy9U0ykEc?=
 =?us-ascii?Q?UoCYiTCrLXQTsLn9X1V7iNRSDsSr0BHlndf67oqfokuhbQHyP/YoxJgdVrAG?=
 =?us-ascii?Q?osXny3FqrIrSiVTyDhuNVAvJjw1zvIUpw8BbdSWeClBPA0/0doT5daROUMDx?=
 =?us-ascii?Q?YGPfDlyuFhfKLmcg5bRUpV1DehvemSQm6KaL20SYbljH1EJ8N8Cg7Sq6PfJG?=
 =?us-ascii?Q?XZBDnrx0glhSL5rb3oWwQvRf2JMb+wuGrNOHs9zTW3MYpD0iEIcSL/pQwQaH?=
 =?us-ascii?Q?QrVhGltK1ACvmuLqRdKXbsxzWipdSCdI+hysIKu8TH+Q9mZyJU1UiGN9hq3f?=
 =?us-ascii?Q?SbygLWlaoVmI0UgrmKEAROikddSfB8qzBZpv10BXpKIckNH/yq7SFwS+ng4X?=
 =?us-ascii?Q?nKE7r25v0tD9OnLAXt9WvNFMlhlYHs0Z1OMA7hFBDCreQ/JEdoOiOdhBIwqi?=
 =?us-ascii?Q?0vs8l7Zdhd0APgziSi6Dp/RAhqJO3itXNe5vvpq/AL9uTeV9LqUvnpNreIOc?=
 =?us-ascii?Q?YbzLltd2GeeoVz7hHpoaljs3SPFFpwtB2KC4nRVs77rQrnAmGa2mmd8bWVbm?=
 =?us-ascii?Q?++oNZzmr5NZR3cZlgHd+NIlhBrHvhjVKFDFLzXvGjPklGY+M9IEfZsBVyvcX?=
 =?us-ascii?Q?UZoVH5SfvCALeqXCY1sKvc8fHyBggoag6xoBdNp0AgjZuJaQrtL4d8eyZlfG?=
 =?us-ascii?Q?fFgfXuUc0E9DvJ7rDlhJpkGFWlRCCaBPylQpOQbML01lsu+ndSOWv9hpS3PD?=
 =?us-ascii?Q?rKJRjmq2t11oW1A2xqD/JkJWjbP2NA4ssK1IAXLLEZXBCwBpoFQJWH1dy2Vx?=
 =?us-ascii?Q?efMNeAJPTOeuntfRnXK9+/wWV2ov3lkSPNYax7lS5QDJCxiJQkCHnAHoXSDi?=
 =?us-ascii?Q?MJpF07Tve2Gh75Lp8SNHY2bsiisa+N6/lUp7E0RG9JhoNskEc32jedb2MmFd?=
 =?us-ascii?Q?z/QRdWJiPQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LStf2ajFj7dTSogWEtcSwcdLIX5B+I5RZ7rbGtLlLTJ4m0oNwf2CZLXoJm+QMVEhDuzmHP2EMB4qFiVBnsxQSLOBM1qSseEJJQ/E/pmGjSglUcoTRjN/MEgO3JlGpC+23IIRrQA3+s5sCUGxIPoW2nWsDWgc7LUiQfGbzuBn25K4DzHc8jL5v88hJHCVGj5H2+yKVscQE5sEivA1meuus/lo7qq0uA8nWESWcCstSRmkN/eyFAhzmDi9657yibUq30kmzrS3mgV2Xx9uHKR0uP5y20+zOqo3ri8VH7Aru4h/FrDoFDcWG9b0jclE8vTVVtBgsb9YEcYeoS7aPhvFMo+YZCVB0iCKmLyfQkq3oLDxaLQTAlcsjdNGsWNbbhOiRmNqDtB2xn32u1Fnt+9cj3iQ0Fz/kPKfVhtrU3CLkr3xhKiHD3+7X/eTLaFfs2/VaN/FivbWbftGN+aFUpXvFQyjjLnY79UN8S2s/aTwuSar8+bqqX7rkmskvQY4t6uDt1gwp1gm0Q9YqqES8UrT39Fq1GtyYxJjCsC3V+BSuVG+xEXfzw0Xub8Epd+KkYhetXx+s9Tr4JctCVcWdYlZ2C7mlYX2t+ZugmeNvExH5Lo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894ca28b-bd61-4ab2-8d41-08de5f55a9c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 16:44:26.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE82nWmvngBFPPJYYAIH5+KaZ1DWuxCpKqPSB++kk/GkEnGrZoIR5zHYKHhhr2XpSI1qRagT7T2YO9Z4+ghGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601290117
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=697b8e73 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cd61lHIqFd97GbbyCNkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5RGPxr0kEKOqoVAFiMqfPbSJsdC6Wwvd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNyBTYWx0ZWRfXzZfQZV+WXQoa
 avmYFuaPfnoVMC77YlmZTHr3gBFkX/tLFR4OY8eY5xz/ejDcdUASkxQI5iEJ1xWitMvS4v2t7hh
 43lIILUvZyyLKvBGSLK1/k70oVXrqbONsaVH/EUUkLGlVCYBFHhDFMPeAp25efia4j8YIxYugfy
 bfRpQ8QeFoNtaP7NYo+J6mT16zWL5j53WZhB0571/XHg9IuBGg06/4PY60MD0n2chMOZUFPmrVA
 yjGkDOTkOIazomfXyPpB2Y13aFvFp0ADzlnBG61dRZXtpjTZXqgJra1IIjGfb0lR7kVl9lVdTGq
 1qoircAsKyzPIo8BLLFbQ2WunNko8pwnrYJy5e+KPz5j+1MaDB8qz6pX1SMRy7C/KP9EMfS4Lc0
 k9b4bgefashpW/Vmm+WnSa/qGfVYeHRBgsfqDekVqMXJkTZjZv3K03IXf2I7Om2NKhJ2P/lJ03n
 pqpaU6SJx2cp/ZC2NQA==
X-Proofpoint-ORIG-GUID: 5RGPxr0kEKOqoVAFiMqfPbSJsdC6Wwvd
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212792-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[suse.cz,oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C15D3B2618
X-Rspamd-Action: no action

* Hao Li <hao.li@linux.dev> [260129 11:07]:
> On Thu, Jan 29, 2026 at 04:28:01PM +0100, Vlastimil Babka wrote:
> > On 1/29/26 16:18, Hao Li wrote:
> > > Hi Vlastimil,
> > > 
> > > I conducted a detailed performance evaluation of the each patch on my setup.
> > 
> > Thanks! What was the benchmark(s) used?

Yes, Thank you for running the benchmarks!

> 
> I'm currently using the mmap2 test case from will-it-scale. The machine is still
> an AMD 2-socket system, with 2 nodes per socket, totaling 192 CPUs, with SMT
> disabled. For each test run, I used 64, 128, and 192 processes respectively.

What about the other tests you ran in the detailed evaluation, were
there other regressions?  It might be worth including the list of tests
that showed issues and some of the raw results (maybe at the end of your
email) to show what you saw more clearly.  I did notice you had done
this previously.

Was the regression in the threaded or processes version of mmap2?

> 
> > Importantly, does it rely on vma/maple_node objects?
> 
> Yes, this test primarily puts a lot of pressure on maple_node.
> 
> > So previously those would become kind of double
> > cached by both sheaves and cpu (partial) slabs (and thus hopefully benefited
> > more than they should) since sheaves introduction in 6.18, and now they are
> > not double cached anymore?
> 
> Exactly, since version 6.18, maple_node has indeed benefited from a dual-layer
> cache.
> 
> I did wonder if this isn't a performance regression but rather the
> performance returning to its baseline after removing one layer of caching.
> 
> However, verifying this idea would require completely disabling the sheaf
> mechanism on version 6.19-rc5 while leaving the rest of the SLUB code untouched.
> It would be great to hear any suggestions on how this might be approached.

You could use perf record to capture the differences on the two kernels.
You could also user perf to look at the differences between three kernel
versions:
1. pre-sheaves entirely
2. the 'dual layer' cache
3. The final version

In these scenarios, it's not worth looking at the numbers, but just the
differences since the debug required to get meaningful information makes
the results hugely slow and, potentially, not as consistent.  Sometimes
I run them multiple time to ensure what I'm seeing makes sense for a
particular comparison (and the server didn't just rotate the logs or
whatever..)

> 
> > 
> > > During my tests, I observed two points in the series where performance
> > > regressions occurred:
> > > 
> > >     Patch 10: I noticed a ~16% regression in my environment. My hypothesis is
> > >     that with this patch, the allocation fast path bypasses the percpu partial
> > >     list, leading to increased contention on the node list.
> > 
> > That makes sense.
> > 
> > >     Patch 12: This patch seems to introduce an additional ~9.7% regression. I
> > >     suspect this might be because the free path also loses buffering from the
> > >     percpu partial list, further exacerbating node list contention.
> > 
> > Hmm yeah... we did put the previously full slabs there, avoiding the lock.
> > 
> > > These are the only two patches in the series where I observed noticeable
> > > regressions. The rest of the patches did not show significant performance
> > > changes in my tests.
> > > 
> > > I hope these test results are helpful.
> > 
> > They are, thanks. I'd however hope it's just some particular test that has
> > these regressions,
> 
> Yes, I hope so too. And the mmap2 test case is indeed quite extreme.
> 
> > which can be explained by the loss of double caching.
> 
> If we could compare it with a version that only uses the
> CPU partial list, the answer might become clearer.

In my experience, micro-benchmarks are good at identifying specific
failure points of a patch set, but unless an entire area of benchmarks
regress (ie all mmap threaded), then they rarely tell the whole story.

Are the benchmarks consistently slower?  This specific test is sensitive
to alignment because of the 128MB mmap/munmap operation.  Sometimes, you
will see a huge spike at a particular process/thread count that moves
around in tests like this.  Was your run consistently lower?

Thanks,
Liam


