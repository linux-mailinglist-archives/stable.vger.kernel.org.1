Return-Path: <stable+bounces-92786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD139C5831
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A945284574
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E813C914;
	Tue, 12 Nov 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmR5jFG9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XNqq5+w/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAE148FED
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415599; cv=fail; b=coBVlqqHuc3JHVlkHt9RTYBXYl49Fpq7db5x/jJ2So+5JDj0/KZWFFpvYTye/RGA7MW8+5IfPhUveIOoPTRagjMA1U9HTOEXpmBpK8m0jqBxzpQUw7vYu4j9acDYO3Q4OlH0NfbNKNh1Te5q+868nVjyFVjfh/BwQYPxaKLKojc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415599; c=relaxed/simple;
	bh=FoZXwH8tjAE2+3tDQQAlV3cwUsD+xlD0qhxDbWIgIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HYpX0bDdbfpyv7qsBMfeFcw+cZzeKKOgiziBj/yosiIvPO55reIWOiHlat79jDb/mQ0cszHIApiGHbqnnwiO1AL4NCBkYZRMjLdzoUWYo/YFW8bvBh+SQii5KS345VFIErp80cWANT1twRtSSdTYYcbygzDmGjgfdXEsxWc7r9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XmR5jFG9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XNqq5+w/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCfiP8030415;
	Tue, 12 Nov 2024 12:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Fxuh5GKQvMYMjDpA20
	VrebKA8bRUfDR6iC0KgfNs9XM=; b=XmR5jFG9YPrei2FOuhkBkUNR9stR+8C9yn
	J/80AIOWpBkNu6td//y5r29M3Dj4U3ZEj4HzPao915T8jHH6Judn40pdzT0gsSpF
	+TVxTKsRMwKryTjMasiLs5Pg/tyW+JS5MlRVyoyhKuX+wdiaGHhgp2H9a7rcWHHe
	eGOCJZKK/ePgYHx7Z/2S78oRLI6dJ+Mx1qtfKtakDCB8Bu4SJ+W5ixbLCiNQGNCH
	inTJeD6+bWr8jDarRz426asahUMs8wnLaqI4rFlp2HqAOXrthyl5Qx/eiiCbOp6C
	d8WlZJI+Z3JzKvepTAbLrDLnwauMELQuiRYZ1GOZ8Ep2ehpcaIgA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbv96q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 12:46:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCTR53000666;
	Tue, 12 Nov 2024 12:46:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp760qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 12:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKBGRkGDkf+EbhzBRknTHJqBjg7u+5KtZhxqMSCTNfx8Zlq9YQAdxJWtgVn2TqrQpGc0zp0C/13rQblXuGpdqAoYxTMO+/1vgdwzAprGa3vUwV5jhL5RM04IBigOo30yHF9+4U0p+fsNlBHgxyTjsW1lP0zc2X1GlwO23ZMF0u0x06eAgYXzYqBwrsXTHNh4DNdrmtQbRNbiozA8eEn3WgVpI1WiT8DRl1QyD5gbjA/sCs27XeRqxS50WQCUjxbLrNIrRjDy+Ss/j50PtUy4ZI+VVtggJ2fmgBN4Xp0XHioLwuUePZwjnpZFtqgWdcc1M7+3LzJetxq10unOcVaDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxuh5GKQvMYMjDpA20VrebKA8bRUfDR6iC0KgfNs9XM=;
 b=Q7Ths+T4pmMzm4pVDewg8h5doF3mgYFRiRvwYTf8Yz2hsofTfpRMHskp+P+ooxlgJrgo9bXsjXzRaHgT4zeRu86+CXk6GzxHLQ/Ddtlu/3Mrtqp8RDUbVkIh5wyckrj0rxOtDD6CrQZVpYgHq4blZ/J3NeEXK6couWKB31+t5iwnutakV+itYSivBRmzRbttnZe2Y95fLMRnvIm1HDysBgVo9le1Z4+cVrZ+8zfsZVhvnIKyJpQr1i36J//103wj7VPljiS6UOx7Gp6cEVzMsNrCEDbSWhMIbaDbJYgNRjOVxAYKfjNayDCc85e0jkKH4Q4fQmlCPQawTVVZ8C3K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxuh5GKQvMYMjDpA20VrebKA8bRUfDR6iC0KgfNs9XM=;
 b=XNqq5+w/b8jcAL02nv8vxQ3nfV0LSUsOVdm01kushywK0x4X1A/7PLSTgXh5x+flsKFJMbn513QSNTtbiXl9brc1iLfurV5wUllgk3mZQZK2x6TBhav3zXHpEDxf8OhCwd8kBGG+1zqh+aOSrCRw02IDM20YSaK09zAJoNGkVXU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB6794.namprd10.prod.outlook.com (2603:10b6:208:43a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 12:46:21 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 12:46:21 +0000
Date: Tue, 12 Nov 2024 07:46:18 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, maple-tree@lists.infradead.org, stable@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: Re: [PATCH] nommu: pass NULL argument to vma_iter_prealloc()
Message-ID: <uyvmziiho2gq2h2f2qwxob2ji7xztrkpxadhcso5lpdrplt24q@nyuqxxiww623>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, maple-tree@lists.infradead.org, 
	stable@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>
References: <20241108222834.3625217-1-thehajime@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108222834.3625217-1-thehajime@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 41564510-1afa-4b85-f524-08dd0318024d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9OOw+ovN48fDCOIMSs5yAlZA/8z3TaMAQHI/se/zR8sLd7h/5ojpxtO/dqH?=
 =?us-ascii?Q?0o7oLcHcSKJUlt1pZ7vlyc+U1adItRhvVrItx1CSqBicFNfIuztR7PAHIrqw?=
 =?us-ascii?Q?d+PxUxnNuxxJiu1z+hYbJx+BbgBlfi/a5u9nLiWyXuIO54grPldYETys2h9J?=
 =?us-ascii?Q?NY1TXFsBsA0x/Wp156ktO7FxEzHE17AUa1OkzD9C5FsoVd+uByP/3ov1Q2VQ?=
 =?us-ascii?Q?hiuKrAQSt2o6n5P7QJFB0tfi1qgF+Ju2p6c1QR5O4wdgVbn+rl0fLm9TYIIH?=
 =?us-ascii?Q?9XPfzsBGMwbB7Jp46coGbk2t+LqnOWmTCHtsWA3am6VcbtKnRCfhcQUXzIV+?=
 =?us-ascii?Q?JHjUSav5FNrfEci8ZkSVc09p0tvxvEHOZ50mqQYxFogH0BxZgoZYDHEMuOc5?=
 =?us-ascii?Q?twMu54KfGAlWjUMNXKUP6dhwgCh1wgO8uHQ1IiZpLUnSkLNKP5tB5VD/ShLn?=
 =?us-ascii?Q?WBEp9Q8TsMPsxDmLlbTI/QrWw0AemxpH/HDdP5U4Zlmk/8TiSTpHtry8qifi?=
 =?us-ascii?Q?mqyYPSmO/hWTScgtuk2WmTb+RAavUo++DVqCSWnKO5WT/YJbDmBs/Cwd5Ati?=
 =?us-ascii?Q?Nm2dpv5hZ3+/5htky52H0DO9Cwe43cWuJQjNmyyjaq1EtYWZHMCTn1SCwoc1?=
 =?us-ascii?Q?TJEUvckFUslTSigUSEhBhdRDozeMQkbWka5m13Z/FqbrsMNOctH8yf0d2C2e?=
 =?us-ascii?Q?Yed4IM1MekLhSAqg9/x7VS94JtHjyKU1Pecd08AT4f37ZVBXrfemmF+4jyeP?=
 =?us-ascii?Q?KjvkRcoae/BJhfbtL5d0b0MJCNVN1dnNqNwsb/c8bOm4zR5gVdSWb8hCLA0h?=
 =?us-ascii?Q?D6bT5gqXOTf9W+uWuHJAAtDHFYRZzuZwt1+XuPxfg73GMdo4avPjHWE4Tai8?=
 =?us-ascii?Q?JYEdUpSGOHDAAfkDyDaEOx4veZNLNaQpAk2PmOd9WWa6mlPFd2Y2Dn03rx8R?=
 =?us-ascii?Q?uY5K5R3s3rmzB3lxYow7ckMGSWhXGqV98MOMdKOwmYs4LBOtgnVYewXVzZs5?=
 =?us-ascii?Q?H2fKPCoJpVkHqSMHe0LsFTD+Y7irxcILVLXXTmvi8KqN/Eav83HK7Y0N7yY8?=
 =?us-ascii?Q?GjxuTnc//hU6Mnh+S4It0Ue0HPurfeDEo8UNXPe/WYa8g78XhhSeSUs8P7sQ?=
 =?us-ascii?Q?6WgCG5wTeA3UD40hl+4C9ZPJuhbbdJpdpYVuEMg0d+TyGp+52qdykY5kF92d?=
 =?us-ascii?Q?TCil4IrS0KzPQElp3X9rd3q5rEY6Mv5KoncmaRs94yscpxBW3QNn9ldAvUf7?=
 =?us-ascii?Q?yu0eWC2ttfgtieysBDsUXjdGRqFoN+KtqMOllFmBIOEe/IA+MjtejtqKpCp1?=
 =?us-ascii?Q?FDTWF9+TnPuaCFm8Kvkr3utw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuaMgW9g9Rqua9rbTRp/WTtRcZ0oWrM2dQ6O2ytwi08FL6XTWgOSQQZ+RfkG?=
 =?us-ascii?Q?StolSUypu+xPu687YBvVLQpWdmvcRzxDAkdFknDl2YuNPmYpwooAKT4Cd9Jl?=
 =?us-ascii?Q?zHEXgTPW25KSDOAXjNfZ2+kPZ7RNrymRgPEAcGlxc8omKEHrpKuCjamKVQy6?=
 =?us-ascii?Q?co6cCccDuAF6SqFVboerU8esLNf0+kcNxmQ9rCCgkPYVd8qVvnsBKkNTxhtx?=
 =?us-ascii?Q?SiPFOqP2cQZhDwSYk4uh1zuFiHq+aL8FjF05b1qlCC/7m4cviNWcNSzi+dV8?=
 =?us-ascii?Q?OK/OrYVuIOoj2i+HZnuyIkaIxgmA66Z7j2fD54yNh+AnatoygKX1M91pZR+W?=
 =?us-ascii?Q?lFIdoCvUGH+411QYytWYdtaA0cfFwG1AxzFMJiHxFRkno0GWaY3+MbPiRIMQ?=
 =?us-ascii?Q?Pbl4qzmY3MKAzfGjBXGfFzof8/j1rkG+pgva49PEKZrONxLPmsjCuQlEKpEz?=
 =?us-ascii?Q?1hQMOzZ94Cz4Kky2emWetLylzcT+l/6FrkCkH0tvkHosfY5+VgLB/k5s0+SE?=
 =?us-ascii?Q?dx2cMhSVrqs4p7N2h6M5gmOXCqEJoJeSABXSF14FL1C6dr+FsQ8K202OyeH2?=
 =?us-ascii?Q?f7tUieX66ZmdTi0ThHGPaINjkuXwWG9fYKBnIM+V9Bbqy8LcGG1hTIdMa3Pp?=
 =?us-ascii?Q?yO7yBJoBSwpDi7/8wWCfES7BEVDkX24AHUbbP3sYjMg/+/ri72gb2Kn3tcWW?=
 =?us-ascii?Q?ahVJKtiD8JfO5CMlpUETb4pPW1T7DJxqNCVL/Mp3/ZOO1mD149eqtiQj5yC7?=
 =?us-ascii?Q?kzHVKAqtxQ3hoZDWlTayFiMobHPfjtQN9GzHPbEjGMt4Ho7zjZDQEiN29y4R?=
 =?us-ascii?Q?d0sSyYMDrz5qp4iqkTvrwfg4hnCpYpb0BJJGKa4Vl0KTnKf9prv8M/oacVGR?=
 =?us-ascii?Q?uHi8xPKUvtOVDl9Ti85heg20AGYZQk9LgvHrx2k9F4utMvJVNNM6lk6GyMLE?=
 =?us-ascii?Q?2GF6Q59ZDP6UhdiANauioftce3NeQp6A5f8o9WCygtEcOVEy/suaF+7IHMpb?=
 =?us-ascii?Q?dA6m4hfu60JTz24xXV+gVT4R672XoSpK22kayxWdHVni2Xy3mf2Ti88Q+U3D?=
 =?us-ascii?Q?PtQ4ctojDZNYHaV0Deh/MgwFKFACs8aMznv2sB2rd1LYa5kiPELLHKJYXC6u?=
 =?us-ascii?Q?08Tmg0UUiygHnAiTl1oZpjB2x5hk2YZBNGo7T0S0zJEHQk3YxagAJ1gZPayL?=
 =?us-ascii?Q?Gh6ah3lTiUpznaHTYd6I2rnVY83PNS7QO1Gu79y7+CZ8NqiBkw3BbEW+hwWX?=
 =?us-ascii?Q?/gemLznd1a0TsLsl3dy6dJxxhV1y+mIGNwHc0ZJag4IXEe5wL45OH/ExSax/?=
 =?us-ascii?Q?5Bq3oqUPZLP/rXyDnQ17wvycOZSzrD05D/+X+OAKRMiX94Ng2ux84UmYaB9R?=
 =?us-ascii?Q?L/YtVaN0AgaWCBzncO6a3vJAntnwiMS0+Dt+bDk3gg339cgXjESs0GLMR6sx?=
 =?us-ascii?Q?IxhNvh+SU9xMjd1I/sID1gOgvPBlxgsdeCyCSM7stmsrSEw4e9/weoXlE+65?=
 =?us-ascii?Q?mglexLRQhYBotJw3Sli6xQqpbgzGLOf2kI5+iqrDAzgh3UMQf2WvetmmwACW?=
 =?us-ascii?Q?924/fbZ4xO7AtdxEieEM8LBYfWK02Q+r+z+atY/3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mi5tizqL8OlTPpyuqA4d4p3FBXZYxS8eG5gcjyy+uSQxxRZk+WHj7UAC5FjQpLsHB8hxD6pP+O3E0jui1UuILt9qJuZuvkn4MyUwXBZrEGn83ZRyIHaKcMK055/vVh/idPAy1JxV4BybUP4E29c/Af5XDf5yb3C1MbOVrZvgKScH4QM/SrfBXnFqWiZVfBCe25bneyHGF0lVY/ZRDxtDdLYUwgEQUyDZIGUP43MwaISb7kSUBhNiu8kBcLfE6jqjuH5OKGj4oRIQnb5HdrlIiklMKx1M65LBL+jEzHXqJg2ypL2K55qLVNnIjjiEAyv4rtT90NNI+3FixBb3IIYGGO5Zu2UbREB4NdGVH6SgCuGojaJbpGxsJtX+P1CUYCqGjjcnXZHHuqgDKt/vVI/GEvNoHymQCZGQTRTc0Qd4oSqURk7tcmX28BzJ7K0iVs+I8V1T1IQNDqMh+pqF5/Motf5h+rRaXvHGIYTS5wF3EOyCBAc4UEFSrdoDxfjQiXnU5JLvzNwmWk0SgP7tAd0o+sYz4yY3Tn4Bd3DEOvx8DKHaOiloqYATQ9l1jp0pp5omgVnnSgdndi6DRlm1GAtGAAkcKhJ+qurzyxxEJpUOF7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41564510-1afa-4b85-f524-08dd0318024d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 12:46:21.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA1FCyqE3e5qJUnxAQHnyEIvThTkFpPSmpxS9pQR185VQXkdPNL/FBIxCBzICH35q28ssIweTi62EpyPqbDH4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411120103
X-Proofpoint-GUID: 2tVYPv317YWmQGS8WUOP4qFLdLPE7bsu
X-Proofpoint-ORIG-GUID: 2tVYPv317YWmQGS8WUOP4qFLdLPE7bsu

Andrew,

Just in case you didn't notice, this patch was reviewed on another list.

Thanks,
Liam

* Hajime Tazaki <thehajime@gmail.com> [241108 17:29]:
> When deleting a vma entry from a maple tree, it has to pass NULL to
> vma_iter_prealloc() in order to calculate internal state of the tree,
> but it passed a wrong argument.  As a result, nommu kernels crashed upon
> accessing a vma iterator, such as acct_collect() reading the size of
> vma entries after do_munmap().
> 
> This commit fixes this issue by passing a right argument to the
> preallocation call.
> 
> Fixes: b5df09226450 ("mm: set up vma iterator for vma_iter_prealloc() calls")
> Cc: stable@vger.kernel.org
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> ---
>  mm/nommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 385b0c15add8..0c708f85408d 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -573,7 +573,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
>  	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
>  
>  	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
> -	if (vma_iter_prealloc(&vmi, vma)) {
> +	if (vma_iter_prealloc(&vmi, NULL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  		       current->pid);
>  		return -ENOMEM;
> -- 
> 2.43.0
> 

