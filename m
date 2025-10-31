Return-Path: <stable+bounces-191801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259EC24733
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC64F4697
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AB340287;
	Fri, 31 Oct 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYg1sC+d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GBp4BSDS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A742EB87C;
	Fri, 31 Oct 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906304; cv=fail; b=Ck1pRb3XqccmFhPz6pXmgZxX01ja4IP5PFU+NHc6NGpfYcSrv100TJIXBh7BzJEJKDo0ZfeV2ydlZz81TjS/F+MXil5qWE8fA5EztiJNqQtCGNOE+1y9ZUNUWFOQChXH5zPtjbUwtxfkU2p391XPCJWm8cWLSE6QMLBhlzBUfDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906304; c=relaxed/simple;
	bh=t69LED8X4ZBIdM1eTaVwWukLHTSETshl5EjOL9Ugs3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eMM8lXe3f9vCY28d/tyWoT4lKWquDj4dumCEm4lXYLGknzWhUeW+H6koZSNoDQCNWbxP0FUGo+yXRqlkOE8q7KrV4S07cU/nKLCxhTtgbCjbJm+W0pFISqrZRGF7o9ro9zdkXVEax2IFGYQUsd9S1II/V3JvKxeY1F6mMoJ03tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CYg1sC+d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GBp4BSDS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VAJn9C013525;
	Fri, 31 Oct 2025 10:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=urji6fUwh+ym5Kk6eq
	3iYssGVXd8BiIQVJjnRlBtapo=; b=CYg1sC+dOMc7Tl/ikbuFkwxB5/+Q0+62Th
	jHl3cMUb3NWiQPYTau7OYVaKqG4OrNwUYKj+NgdlTI46KyaegsGKdze4A94eu05a
	j8MQdpepg7P46EYN1VAXlCsj9DKm7CGNwXWlZROfIylnjvko8eTvOcl+TRsPlHA+
	POdC/WkN8ar8CVJC+9VtnApfJRF8sftoLqOzHsURpwnZaRzVE54q+uoOJ/jzppkD
	VVIkq9rSEbsdkCwUD4qAAq7uNBDb0A+D+XfY9jfxUjS+ZsAr6UeLb847yvEv0lNw
	SBUejX0jn2EbXdYP5wobXGq6Aj2erg8+0vUjc+x3wV5+RqUvjUfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4tybr1t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 10:24:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59V9gtxf017308;
	Fri, 31 Oct 2025 10:24:36 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33y1u270-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 10:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owqBbB/7Gj9ROphZAQuMnlpgGhger+mG706e5Gc7ZCYHGokA+KaMqyqAlbsUKkMqHYnZPuxRSHFGrRjFO1Al5KSRZg4oc+GP1zFVaSowqu8PaiBr1lFpzDTqrACN95QN6l8YRvwMo4xT1hmxQPbUGK40I/KcVP2Y8T6aG0F3bROEuyh/rJNaz8fQR5CD/kWbDqacSPQ3N9UvKZoKx+Y7Dk3A258Wus9H4qgitiV+RIaniyhFy2Rvc0YcvHQNIVlAjDVv6OEF2uXRBT0vWGjksoWyC3i6SdQ/Af2t/wsPIw0DSU0TwLkhzhA8uCWn2WdNB4WVNhRuFaMtNW1hGpHgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urji6fUwh+ym5Kk6eq3iYssGVXd8BiIQVJjnRlBtapo=;
 b=sxZ9oO8LtV6NMMPunEDtkobyjLIXdNHeDRk5U+YoIJrXLVokXm/68VTMlyy509zoPk9ClvoMh0AGGbMofd5nPjMMZoIatUyw4tNIWDfFO0sqHw/Ee9q1WEjGZegNWZBk7sX7vRHkvwNIlhPnoxixkUGp9R4iFhrsJdx286vS9A1PDipnzIWldxfxmy0Q9eM1mM774JOrzw0yym7aBDLvOszsdXw9iURtiWhKqirNJZW7ItHFVNgHW+cM7bCnT9qK48syZsJCoQgkH+jxraf0GOs8r6RpI3v9Lybeh7lq74BkqtEavw82ZQqNUF+5zgD20jxqAopaYdjzwXSmBGB/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urji6fUwh+ym5Kk6eq3iYssGVXd8BiIQVJjnRlBtapo=;
 b=GBp4BSDS8oOfgJ3UeOX51WsAItvatIqS7CpUT0boT7QtNB7A/zonJ4EDwJzH4AoZdCXBlvuDxZ8O31QfN57bxR35+8HzmU9swKlONwY/upa/JyLCBn1gb/QCANv8+EGdZ2I7EEb4bW3DcAeJFQweYejEglfdKZKsqzHcou/S74I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Fri, 31 Oct
 2025 10:24:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 10:24:33 +0000
Date: Fri, 31 Oct 2025 10:24:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
        big-sleep-vuln-reports@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, david@redhat.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
Message-ID: <02caf80d-ccde-49d4-99dd-0ea3763a0593@lucifer.local>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev>
 <aQSIdCpf-2pJLwAF@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQSIdCpf-2pJLwAF@kernel.org>
X-ClientProxiedBy: LO3P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 190cf9f1-6fba-4134-7ae0-08de1867af2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ev/Xy9ehI9FT4kDSSEiq7tD+ymr8CODIuG5XhsACHRdYNp26u0M8USQDv0gl?=
 =?us-ascii?Q?zDV5aCzCSL4Ps0W5Jofq4ibZPtJSPCfUBCebp9tx7tOELv5/PCBok1+qg75T?=
 =?us-ascii?Q?e9+tl6NgluHssRAdlzuOOWnGaSJzgvy1svjT6Xu4G2Y9PLJEqaNSMSLp6MQd?=
 =?us-ascii?Q?XIxxB3+/DzqM73nEaT+u5kYauMl0rwYHNU4mwsNZLlZqIFDgM7j+wH4D7RBw?=
 =?us-ascii?Q?phyOVBwnWd509PQ/b2oaP3ry7k9XeIAqMGZv6aqqhgoig4PjNtIZxRDizWMQ?=
 =?us-ascii?Q?mqCQNftRLmFkf+Ur+RaLOnytgZfszQnW2u9B+e9Bm/2aG2cKvvT1+i1ZrAf9?=
 =?us-ascii?Q?nhm4wDpASNB4dZTf35M+VmcpX41CyzUDMpD2M3fiubuYrzylRIbbEoapzj84?=
 =?us-ascii?Q?644QwQjurwuHTwk8pkz5hKdR/nWmSkStBNa7Whclu+BwtZ5//sdnJSF2EeAi?=
 =?us-ascii?Q?/9enApsP/3hPNoM6l799T66m9GA2Wc4XJzjfutd8M9ojK9gJhyoUUSu5PN60?=
 =?us-ascii?Q?OtcmXUVluP3dqoM+0tW1osUVtifvbeqs4OYeAJIRUwKKYY4px/2TabIWY0h+?=
 =?us-ascii?Q?4jCHIz2cuuxtMhqwMlH+PA5cIH5xXg0tB/VcVlOxrLEMVhWaUrdeEJyF3oOc?=
 =?us-ascii?Q?RfaM+HNOEp9OuUYEsKjrflwQV4QFUXhFy/dg1K7IFIIQGjmIBaFvvBA0GPGy?=
 =?us-ascii?Q?kIByPMCR1EqqCtUYqaRsA0PMEIm4kZSYBIsMJBcov91fO8hSRCGXvwlSDF2c?=
 =?us-ascii?Q?qglhYeGMTbpWWR42cbMQTOST8OEtsDTPUOAtf3KUHY6KvDTwH8QdRFKf8gA7?=
 =?us-ascii?Q?w7ABmdt5vypz0phMdVJQCq3ZWsfmCaAj4DhvDqEmtOp8vPGhJ/gqxMC4XaY6?=
 =?us-ascii?Q?yNfo9P/gBdQOszTKWoAcnuKGVT2be8Oi49pSqpX/+XCbOGSewoSMxalZkri7?=
 =?us-ascii?Q?5ymzXB8xJo6f4uK4Um7d9a9VgdmQY0ewkYT+G3X4ylO6l/Ed6yL4RlXH3EWl?=
 =?us-ascii?Q?zXLETyD/gYgtWvb9pgN+v5MZDa06VkPt5MvBtwlCWcc+mpAwTj1Gzty3Sapg?=
 =?us-ascii?Q?wBRcABvVco6+A3W+MA/9JkVjvjVJWEfCG0mnyHaSxzq+9c2WfibBr7zmln+h?=
 =?us-ascii?Q?Abbo8dgXfcfT71k/yNW1+AA5diPHCjpQ79rv2kCU+2NqLOMy+PBogXI3T5tH?=
 =?us-ascii?Q?apgbkDoF92QsnVEuN+0hIVZGmawUwAulWsZ8vVQl6WSteMjuxd4zBwTXsWxk?=
 =?us-ascii?Q?HuED6o3fPBkLziWyNUyB1S5Pa+ptVJFBrsKDkryf7RWBqvP/vNaQJH5TSGJI?=
 =?us-ascii?Q?T7vHop4COrf8QLb1LJJ6ioR6FBNfmjrUu66HbbkfwO2BMtsg2MKQzAFNXzM4?=
 =?us-ascii?Q?HOYkv/W7AGVW344YncsgDAPzeiBQC6FjOmQh7UMX8wL7swC8jkw9aTBfyLpl?=
 =?us-ascii?Q?SEf9yEeGwIjKQwOdbYQTDLeBSFQN5b47Yhx98NLRqQ+tIiSi+2VEIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sU2InmD3EBKR6pXhGqk2aPxV0aSqcOwl5zGHKwz+v2dJ0sHDZIm+2N0tDTXS?=
 =?us-ascii?Q?eR/6Ir8pHM+1ds8t+DJCwNjr4tMJf94j7osNYfF5cxGeT0HiZA3TbnUVMbwM?=
 =?us-ascii?Q?Z1orJnHX/JdiO6M6vi7rUESpd6puIU7yOn6Qiw5aMe0yJIFg2OAuojA+1as8?=
 =?us-ascii?Q?sXkku6gM34dBEfE6aAV9NaD4X9nmcfAK0/S98YBx63brLxrk/tgGAYqSZ80+?=
 =?us-ascii?Q?zYP0VTeHJezDtwoIVp6BNckZ7/qXRgPyKsEmwu/VxXun6jG5FtlKLE2gJSbk?=
 =?us-ascii?Q?xvB0IZQbrOe73/LNXuau4Ggl2dNi7E1m/2ETiZJf33Ld0kOQC0fjIujQDhwD?=
 =?us-ascii?Q?KamAP0GfgG1wIg1OUhsfnk6PalPgt2PgiUwfux/9zou3+dvAVx/jncxhRZhR?=
 =?us-ascii?Q?NkQCAKR5NZ5Cfm1Ba4TTnhqtbMnDGwFl4G/mpneAQ2KQC32glFibMy8Sx90r?=
 =?us-ascii?Q?IKhzaMafhiGjQwZtZ8ARp7IM5y3ashWkDmMmBk20stUXrr6q/JrkwzNFw4wn?=
 =?us-ascii?Q?g+R/ZV63SUZR0HtJYAvZQoihp/hWUPUFmL6ie/2qNKd6hNUcnwR9VfmKdf9M?=
 =?us-ascii?Q?Iey2RA+2rzxz2TZtrK9sXHjLaiLcFsASSjYBUV1sRCTbMqxMgSGseowJjZoa?=
 =?us-ascii?Q?TYJzDS9lhNCwzCgAAlY1f4/oaEVY2sAFrZN9hW9RcNGlTmuJqT1of/aEg7nx?=
 =?us-ascii?Q?wankP3M5TnZS439k8/09pwL73Q/QlNou5i289cvLzyu7yRlUHwT5r8B0JHCv?=
 =?us-ascii?Q?o6OMy2GQO2BUtKmNt8qSzq4to/3ZAXPxy2mIZmv1EPvrh1D2LJ0usqcw5gi2?=
 =?us-ascii?Q?8Xit/uy92qwFEMJOtADbn8k5QIp9TW0V4vJxLRRwtsuKUV9hO61GdzZDPsRh?=
 =?us-ascii?Q?At6CRtKBafrE2GUhlecowoS7zWAAAPgWe/on1zStswJV2gAY/utmiItR6AZX?=
 =?us-ascii?Q?xlVKnBw2a6798NvYiJWfuMD8DQuUTqKXmUREHz86TBsr219MP4eZ/X0HD8Qm?=
 =?us-ascii?Q?UaRR0rqrT/i+/CHv0RVaLI6Fqz9GeutimF7qc9VcMiMzYvZxgdASOiLrFcow?=
 =?us-ascii?Q?gf/O8j3l7s6FldVnnllsVFHMeWukUzmx4LYyzhiFneDmmL4C6fl2GEqZhHak?=
 =?us-ascii?Q?ysKfayZQ8X51yFGT/Ru1JbqKp/Jie28bfNUEAaa/6ztXjgzVPnwYp9OwQUqP?=
 =?us-ascii?Q?pMizTRwoSOpAePjQGIBN9N1AfcOjY95uYdEMfK2FUxvYDsuidxi2fTUUPnDi?=
 =?us-ascii?Q?Fbk7Pz1y56YrmEL39ZakXULohCBXw25FXR3ENYH47NCdCTUzdzz1ZBUm5Qme?=
 =?us-ascii?Q?ODiOV496vSRT8XVJm7pm4enDQUk/WR8mB+gfE87WOzCHmXLE+psj0z4519uU?=
 =?us-ascii?Q?DDczULFUGUc01eZi4UT5XRpC9VG1RMu9vLv5oavLcReu1bp3Vrp5bRkKveEm?=
 =?us-ascii?Q?9ZO7FymE6I8Ozl4FexgZEdDS7Uez85K/3VNq0241VqGtWIJyBRXOGAS7Te/E?=
 =?us-ascii?Q?aMIomTp2Mga+wLNl7QyhewQ6rO8FwY7/YtVrdfF5Teda+mS3mBLlM6jZyhJd?=
 =?us-ascii?Q?87QXArc1H5cx5fvspRh2IBnU60Tx+q0lrbH+gE7TXr2ywPSESMvu96VrhOk8?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KXBOH7xdO6yqKQUBjaBKMHfK2LiznABkkAvk4G+OT9p4BOYgu6Xu+Q8IgHhUVzefyu3RCA004SsDqpJw+fyWvn7i/Rd1GoX3BdT4aIUh+wnJlPrwxgUzyCJG+CiAV1+vVaGGGnjMlq1CYmYrY87Qx5nfMe7P2xp921/+jNkF3HaPH5Hah1LkUl5y4GZRN8kqAvsW1LLpBAQP0R5XslvltkArIzUQlFsLM3NV1gMzh9I1cvDmkajnO+fs8LjfltiBElOBxI8zqSEPOzFRBr0Es5OMMX/LYvo81eqSczwEMLKvanLh+Vrc/uetltW+RHtuGomXM58l9Z+zrT+6eDQmRHiUKzDwYFqsN0LJ8DTFirKDzwA10hw6wNHxYXs6MD/1xgFxLufgkUf/wmJT0/Diq1hytqfnCgrbnufToh7yPY1QEMcpEK2YbPD5dzr8Bz/PqQekxc5Tb3xpx/WbpDtWgMRgLVPBBL0nj1puGrCUBZ65+VUXHRGhuBoFuW+9NNg3jhHJpqrPYNyQEJPX4NymUq3k/DiJh+LATlWWnSCyGM6Jr5k1jaUptuhPxR70Herq/hsPT/FmFALTagX+4d+l3Yc/HuZfB4GBbUzccUPWvDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190cf9f1-6fba-4134-7ae0-08de1867af2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:24:33.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7b9gCxgkEoMqsy8lOwRnCaYHCjsi7JnnTogFy2eNn3ssiYtr+OY3iZZbTz/8N1yMPAr8LvOaSwjYShSCDPze44flj7Q4qCyoENgrBysUw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310094
X-Authority-Analysis: v=2.4 cv=S6jUAYsP c=1 sm=1 tr=0 ts=69048e65 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=NLRdgWJtJahP8C8CkuAA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bjkax_ZPkF4Ww6-_A_gPxJ4UnWjQT-uc
X-Proofpoint-GUID: bjkax_ZPkF4Ww6-_A_gPxJ4UnWjQT-uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4OSBTYWx0ZWRfX7ciR/srPITwX
 Iry0iFw44j6e47oAlL1ojf984cDaQ4n0Q4PTjYB0XCk54BC4aSrDqf8BZ73dIQ5O+1wM4k4NUMW
 yJJ5+IgOSn4AASnmgeVmrNzvZV8MmeiqMhxe0Gjyfut++wo1fpp2m1kFuW/HVllLolFCirJM+FS
 lycYpKLeIXX8vp8MzzDZieZp1svAkOfbdYPAa5q/wKQGh+razgqPFshR1nzeuRXy6KznjhsGt/M
 Xhtio6afCs6xeRzupKHIve6r5X3N+ObfPkJloHSHtm1gjyPq9VuenifIfRtorUlGuBkZS/9PiqP
 Yh8ipudSS9+GT8NtNnwkIJB6JhxjKwrG5KxQtciOoIsFTiGQFhoQ2/AQIcmOc7zqM25dR29IcQt
 ujFkD8NR9ma/EhHfDW/gJtgaAAVFNw==

Small thing, sorry to be a pain buuuut could we please not send patches
in-reply to another mail, it makes it harder for people to see :)

On Fri, Oct 31, 2025 at 11:59:16AM +0200, Mike Rapoport wrote:
> On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> >
> > The error path in secretmem_fault() frees a folio before restoring its
> > direct map status, which is a race leading to a panic.
>
> Let's use the issue description from the report:
>
> When a page fault occurs in a secret memory file created with
> `memfd_secret(2)`, the kernel will allocate a new folio for it, mark
> the underlying page as not-present in the direct map, and add it to
> the file mapping.
>
> If two tasks cause a fault in the same page concurrently, both could
> end up allocating a folio and removing the page from the direct map,
> but only one would succeed in adding the folio to the file
> mapping. The task that failed undoes the effects of its attempt by (a)
> freeing the folio again and (b) putting the page back into the direct
> map. However, by doing these two operations in this order, the page
> becomes available to the allocator again before it is placed back in
> the direct mapping.
>
> If another task attempts to allocate the page between (a) and (b), and
> the kernel tries to access it via the direct map, it would result in a
> supervisor not-present page fault.
>
> > Fix the ordering to restore the map before the folio is freed.
>
> ... restore the direct map
>
> With these changes
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Agree with David, Mike this looks 'obviously correct' thanks for addressing
it.

But also as per Mike, please update message accordingly and send v2
not-in-reply-to-anything :P

With that said:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
> > Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
> > Signed-off-by: Lance Yang <lance.yang@linux.dev>
> > ---
> >  mm/secretmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index c1bd9a4b663d..37f6d1097853 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> >  		__folio_mark_uptodate(folio);
> >  		err = filemap_add_folio(mapping, folio, offset, gfp);
> >  		if (unlikely(err)) {
> > -			folio_put(folio);
> >  			/*
> >  			 * If a split of large page was required, it
> >  			 * already happened when we marked the page invalid
> >  			 * which guarantees that this call won't fail
> >  			 */
> >  			set_direct_map_default_noflush(folio_page(folio, 0));
> > +			folio_put(folio);
> >  			if (err == -EEXIST)
> >  				goto retry;
> >
> > --
> > 2.49.0
> >
>
> --
> Sincerely yours,
> Mike.

