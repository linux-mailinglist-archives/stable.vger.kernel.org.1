Return-Path: <stable+bounces-198160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19AC9D90B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 03:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F23CB4E11EB
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00612222D1;
	Wed,  3 Dec 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dr9TuaoH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E9pteehz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC072BCF5;
	Wed,  3 Dec 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764728334; cv=fail; b=KrN58c0+jUls0dbTUzjflyQo3LIyhQ1Fr382Io/4lxZyolw3CdJ31VcEWSo5vhTKEyzdwKrKJ1PksfcuKUyN2N84eS1dzJ0pft9hFT/XIMwzVS1UaiH5IXdn0WZvcZ2K5cCf52WslYuPwjzeetg6XVFaXsbhhh2yuq22kqRor8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764728334; c=relaxed/simple;
	bh=EeDAyD9dAEijOOr3IfR4xNP4wqr9hQKQLZ4uSTU0a+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oNfVjX1ZIZ/A/EGwv6vcq3oRpUSpu1QPCbtiG1cefpDY00B6Bnk52AsQrkWDik54ifns38d4fyWy3kYcbj7l0IQYQqmhn6MXq1307cp+MbXeBNSG8RIIH6HvksaGBh6EjioIatW8NgUJ8Bk500mQOhBjk4AwuZsiY4pqKNhjrkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dr9TuaoH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E9pteehz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B31NdrV1570511;
	Wed, 3 Dec 2025 02:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pRP95LEuFnmkb4Sxs2
	HnYG+9fnk3G31Hg3wO9rwvWq8=; b=dr9TuaoHQN6zrQzftQxb7lmG5cpFgs6ybo
	XwHBXEijas2WlVD/UNvyx5l0wJig9A6sAxxwUd13NLBh4KwTQAHPeJq8rgRzTVqd
	eMEntMoh1dZRoRIUVjn19M8NykyxxmFN+eTi5iWk9ci4PqzlP5Qhkqm9ehqKFxHO
	qHmFpJ0w+3CsGGNSVd+YfjLWQEsDK8WGKBMQibknqrQSTn347Vm0ygPSa1uhEqpO
	D+oKUHr6Rk/ilbQOOt0FYNY8G55AkXBaG2Ri+h0BS48K5vgFDF87JZ68gN+bDOeT
	u5ltI4zS/OHh7r4mmMci4b/IJw7gZu6PfFCwf0tN5k/Vrzwe0wJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7u7vdhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 02:18:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2N4fh9015054;
	Wed, 3 Dec 2025 02:18:20 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9a47ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 02:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNgZOe7+xpjwUaK5yA8+1QlnJ7f/foEGJLtiy+ydVZTzX14FqvV18640IIXjS6g8vhTX+m9U1K0FYKxPfEJd0qQhDtSmDGD26q8DEA66Udyv/Se/MBdXpBhZibD0Gx6AKBEpDOE5x3kLT480gOkZ02fz4zQrxX3hn4FTQifFPfqwxhR3WS14XMVldCGppSqj8Ey4z3pIqYIJ72fDViRjqQELbOW90a//YK9e/CFdUwdIihLnUTXD/xTt5JMAzsRu31aHVnHH4ON+1TkhMJglnft7c9k9S1rvXecyO4p5vsFLxjm99ADqd8pE8D3ticdv/8cZ5onkNHmLYmLxOkMtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRP95LEuFnmkb4Sxs2HnYG+9fnk3G31Hg3wO9rwvWq8=;
 b=PtBS3IT0gprWemEpwfQ1r1BZpb59UAtoijdvZWfbY8pj+ddtTE7wgVAG5tbclFqClONqEbFta8bvOyiK628zUU75IzsTSgGsqZrEl5BlWlf2lAnCQXi2RsKD0n42Dq+/cRRHRXWYwOL+C1IN9p0Qd2//NelwqPRNV6IiFJkUkgLPW+PfUAJqje3VqbeiKagTyfGd3RLN7ctdDiAkMfFjG4DoUPDx7nbrZCZESLxp/Mng0fzLxU/cgVNHVI8YhYpTLkJgCnE9wwM6rNqLq41AehIL0ahYcvIEH4x4F/TTid8Cd1T3s+6nZ8rhlPPRfmmbCAlVhdRi0AdSMKuTJe94fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRP95LEuFnmkb4Sxs2HnYG+9fnk3G31Hg3wO9rwvWq8=;
 b=E9pteehzarlNPzY596naU9R3H9FYUf8hND7u20411aAWxA2lKDg+ezNzGWdr/kBonzb8nhHYLCh7r1/JVFLB0ENsNssItSCPuDG0hQz16yK6ECHkzDwZiZ3Mwy5Nd8eKu9JnBY6sGG4vH25zRxn/Y8o2dLgzrBu+IGATujb+AnA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 02:18:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 02:18:08 +0000
Date: Wed, 3 Dec 2025 11:17:56 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: vbabka@suse.cz
Cc: surenb@google.com, Liam.Howlett@oracle.com, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
        sidhartha.kumar@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
        atomlin@atomlin.com, lucas.demarchi@intel.com,
        akpm@linux-foundation.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
Message-ID: <aS-d1OaCZ0TBVewg@hyeyoo>
References: <20251202101626.783736-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202101626.783736-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 504592b9-30cb-440d-c40e-08de321232e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sqDS+PyI6QkkeVcsltZ4rZSFNW7fc7dkhRKYyq1WU878F2dU5SdJfcwpBi2w?=
 =?us-ascii?Q?ZVWWcsedgbXxd/AmihzGZVGHUDGghttDu0uL1r4yAzz6+9TgNCRYdSL0cZks?=
 =?us-ascii?Q?IbHq9wcDsvFPDpiNZo6e0Upjv9CGslbFCGRpHarMELt65lSZWWlxEYYhKlQs?=
 =?us-ascii?Q?rvLv5BzrKttYuya11DJn173IBzKDtcHp4zQziPMGzy0e5Kpea4sl0e9XK6iu?=
 =?us-ascii?Q?/hzy13bMmVtwqUIRXRuC0590y1lLdEC/hj0E5C85COQWwihxwPc1M89u8CCG?=
 =?us-ascii?Q?aP7WBP9IlmSqJNta4a0IDH39/rFt6Ib23kk/LF8pSm9umcHiKeG7dbOBHz2V?=
 =?us-ascii?Q?wMZ9n145wXz1FcaepaqBf7tvRxM8/ChSiTrqZqwkOUducrgCZOXrtk4YQs+X?=
 =?us-ascii?Q?I0scnM9JnRm1kVGvvLqZEu76yieJq3qD7GqP0GD3SdlV2oXnmhWa5el3Cdpx?=
 =?us-ascii?Q?IBLDXCAKg6+/CYDME3JtywyX8wyc+Fx2fg6udgU8IJjgRmfoQkLuWs5PmP6N?=
 =?us-ascii?Q?WsBike/MUUZDpsQP/N+TjJnQBMuxApudcRtwDU4csKRwHYSGMD4WT0NjYsKR?=
 =?us-ascii?Q?CFufaZ1U9epPaEN8G0I4WBOmpszXOgbzHGCvoojeCRR/V/n1xc/P9AtmnE7G?=
 =?us-ascii?Q?mcg/2B7GbZLMw9pT1Z1yMA3XAToLkXjHf0oPpO2FszUruFdshfQFHAzzYbIr?=
 =?us-ascii?Q?E1vpBG6DOVR5BXKZ8pPhqJjMVoIPgUpfaYO3u542GOqST1oH0ylZ+XdTayCn?=
 =?us-ascii?Q?Gmic/T+TSsP6O66DygaonINY8StajeHfradvHgTbNqa9vz/t0VVJKJUAlS3/?=
 =?us-ascii?Q?KQ2nNa7DpjvMUu0Vlic/JWfhE9EvRhzn3WDAxV/410xnrytzT4fZKLbY/NBm?=
 =?us-ascii?Q?08vpbBvZtxYbpXOLRLZAHW/tyfCt9O1RHd+EA6oMWYwo8DEZyHkGtXekEhTo?=
 =?us-ascii?Q?3v0l8pNBOc4ixzIdeHzS0D/2JMfyBBoxbkMS6YpIwIZNsZPTBhZEKaNq6Yzy?=
 =?us-ascii?Q?M8jOOTF04ix8CRraqVXht6RiH9NW/GmZpe8qAZIkJvLUNtS4e7Yhb/pDqQlq?=
 =?us-ascii?Q?ijZUN3T/y+vs1Fyi2cVImCOEwXlOMXgkZNFfCUhlzZG+hWDrgq18M2FPUmlp?=
 =?us-ascii?Q?jLoPc5NrhvINC0eiBbOEBJ56kq0qic2R3uev5aPl9MGAqEwiLV/MItgzFGnf?=
 =?us-ascii?Q?UUrkoRz464uXPdzDHEib80MLodH+IfhFW8jokMC2NYvRaY/puE6JP6HeRnFX?=
 =?us-ascii?Q?WJqw+FbehvQXge3xuGIxDcZanhGw4c39qLZNtGAfo2CIJR2OcEyYvy0vewFi?=
 =?us-ascii?Q?osos4BlnSYHE44CVAYmrG3woIq+bLBmIwOCeAv0gSpWJ4zrn5F7BhLoAbhxT?=
 =?us-ascii?Q?9yGDCjFNcROz563RJho8TXSNhEiVmlh6EKzH5cKO4c6otxC1YpZjt5Wu4ccN?=
 =?us-ascii?Q?5oBxFWKi+ffqwvv85qhsPg0qlp5oAFma0Fl8HTZLGttHic+fL5LpCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rubGdEUzPHDfTA4ZKI1t71I31jP6srxfrwFxUF6Sy7hW4sOolHkdSHPj5TE1?=
 =?us-ascii?Q?n4PWytJ4idYozYPmCCGLLFSV133T83Wg51BsrGgobSG6CLNCFZ0Yg6oCETu0?=
 =?us-ascii?Q?dqFzNJtO6UQDl7JDO4pHY/AcFzbOMO0VCVTyQakE/q2EudCcsbfFqcz0Ftew?=
 =?us-ascii?Q?uNxEN/EjO9dNPKu6BNYhpqisEEa2rYqFYRgaBAqdWfZBqN8dfuDd9MjvO9kE?=
 =?us-ascii?Q?s7v1XLJ3aGDk1n66A9tFfZ2BRhBdz70aLi2eQgIEbUCAC90L88xUa+VlxTbw?=
 =?us-ascii?Q?fijuRyeGAwcJAugmNoVLC1GkmRajutjcnfR+IOaCvi74s4A7GHnHe2WA8m/Y?=
 =?us-ascii?Q?tQ6/ltyjERzXmFgupMr22AWEFKp0WU8mbV6TgnvkiZH/itQM5oMPJhFP3eg2?=
 =?us-ascii?Q?A5ZSMQa9eW/IohwgQcdgJEFAHXj5n4WZE+KIZTJPCdrkAigySrVSYeLSX9lq?=
 =?us-ascii?Q?QMKEds5JRs87ub7SuqnR3Z1tkZz4OomwTeLaZfGbIXkcvA1hBpfqwlIIMB/T?=
 =?us-ascii?Q?m+EtE9Oljkk3hJaJdtQ0h+ieYtXOUpzcJ/E7suEHekhyG4l+C7BkK6qZuzSl?=
 =?us-ascii?Q?BeQuy2dhustOihxTknK96kxciAy0D+ExaIwEkSqrf4y78hYbyjViGETle4lB?=
 =?us-ascii?Q?bKDSj+vqmzRkN5uQ1wvnphhcXgrHh0ci0yeVrBtWLuxgZClTI8x3BW0yHaQt?=
 =?us-ascii?Q?tcN1VduTf2focY0HFoEfnFwb9vg5DBAyletfpLwciMPld3pQCGbz3etntBxc?=
 =?us-ascii?Q?QwNqQCsdB0A2+w0SaEJW9/GnnDcySHLDGCAF03uivHZXQL/A61e7y1vBdD0O?=
 =?us-ascii?Q?yTOqYciBfu/wZXuxJjxEluISqhp7dCrZicJ7IXlBt1VKHE9be0G+u4WIJQxD?=
 =?us-ascii?Q?+PsAOGAdvUDu1o9y6YHT1yO+xRoCNrT8yOR6ddQNFSCTYbnsVq+TadoZz+G8?=
 =?us-ascii?Q?bVmZRYTWrLHZMDsjq6MbIPG0QRJUfFncdiSgGOJmGfPdUsCAth4Sr9FDVHg7?=
 =?us-ascii?Q?2pb/hqiLoDPqasqkiDl6IJh8dxRRRPmOC+xPHt8uy4j/0EHxwlXXBSGRw8bZ?=
 =?us-ascii?Q?Aa4cImyqyacYsS4F7uPTjHfe0maz857igO0pR+43trfE/sw45r3IULkm+H5u?=
 =?us-ascii?Q?ZGjR+0OYsQeJpVs2XVbmvLnvhVds7QsTKxTNExRFpUNfqhDUJlDXWJ5PjyP3?=
 =?us-ascii?Q?dvJWz00riO1TzaILjIPcUNm8i7/d+zXsDwlKJnFsQKX2sidVmYuaeV76O6Hk?=
 =?us-ascii?Q?7DAJbXfAOBMoNrIgWqQ4vUpdpsug6UmLuj1llakbsjZ2v9E0w41C5aIDLyzQ?=
 =?us-ascii?Q?t9jM2z0gllgZm9xFzUYMABjpL83jrZx2l28tSwn0cqIqilC7Xn65l3532cIA?=
 =?us-ascii?Q?NzAx05M0LU5VjiEUES9uYFBo/JgyT0/NldNG/+X5zwaDRzYcVpiik91yExzj?=
 =?us-ascii?Q?EhqeVbsxSlMZVT8Mr8OJfU8l+4PbCw9ILtKk53uBv3yKvzAffZN5qpqZXl5m?=
 =?us-ascii?Q?MkjtsZA2g6CkqREV9A8tUwH8+/XjKGE7Q4ih5lbAXdI7BabNr+8dulHXgnck?=
 =?us-ascii?Q?v7AkZeCycLbSvFn+iGFAR1a+/9HcSE30gOgI5Nzh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2gPyAU2deaSvM3R7cV7tCwZoSvn4dkBTOJ1SHV7YPTRzKufvTfD6fvv+14Ydr4Bnp3CanIL/ZFKpmdl8izjn+f8aNnEUaA9mNSTtaChQaCrvfiJ7Vqeom8DllEyZuwmsTemkt8ukPYnEclFnrNuAfNSCs1n3j1NTZUKH4j191vE8hb7hD0YG1DVmT7031HtsCspnNajaJrUsrXrivo5avQ57BAp+YWkr/lnUxD40t2QT0nNX1HydsPzXEJ5Bs1EkV/mPYZOlTXEkMGKV6qq9ednmCFciysDRmL/BIlZFsvHzN4x8k/xWl/b2ksYrot5GgYZhEykwP5JGp01FGyYA/c8uYJynEs4MHMw1fKN0n8bW2fXXR8XbZB0bAYlPwdGoPz8j0PjRiNYLUA9AoGCYhbDzU1PvzJBI7w9TcvlxnUavNQVz88KK2wBIJhCygMsMdl3dgBmkJTPzdA9BZ2QDMhmrBtqppKjPuhy1OQxk2G9y4e8M5DvaisY13u2i2DWJ/brLHsmzB4xZle3RwzzZaVXO+9U3LRoQXj2yPpjvw8c0fFer76cgAnBNnnVk8h3Yy8Dr20HaJ8e3B1/ipE9Sg8XZkLO9lRMoEZxXUBF/i4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504592b9-30cb-440d-c40e-08de321232e9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 02:18:08.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85uIHmK/yjB6pUt9tyPsJhC+Zo+Z7TNFcmN65yFe1pYeQ4nyjHTwCnlADD7PpcJoc0QzS88DPkAXCvnr8V1nlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030016
X-Authority-Analysis: v=2.4 cv=Rfqdyltv c=1 sm=1 tr=0 ts=692f9ded b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8
 a=mjkPjPdUx_zNjNJ-uPoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _fK-SjkYkPbIjwERVZsxMzMycL-1t2Ab
X-Proofpoint-ORIG-GUID: _fK-SjkYkPbIjwERVZsxMzMycL-1t2Ab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAxNiBTYWx0ZWRfXyYpze4B4OZg6
 vC8c6IBxuI64tMiETbrAlWfZHSQWOMml4tAAl+dWwij40OjXXFY4UfGf7t4k5/TsSzgdinWxVF9
 K2eLjA0uAZevxzGGTSGo4eL6WxXLJAEOj/Fe9iW+wUrTo9DUMZp2ti0vdsxU94kYiZM+6Y3nGA8
 MC8IPom+FIur3nLxm729t5ISjyo3Syi7oZJoUr0MCOOhCPPDw1JEodjwD0YjnjAwOF6LiANb1D1
 EZmsFGgn8QSFXf1RJNQ7ue3qEsvaR8i/yJ6E4DMIMEudgcC2yUSFMT4wtkN8m0gFLp1MqadJJ1m
 m5ydD9l/lWWjEcqMPnCjCatFYcdQ6WgbtmBBiVSkv8YuVE8pt1tDcl7FKPEZFnghn9B+1hcNpfx
 hye0CPCEE5HciS1OyBGPa45PYMVZYQ==

On Tue, Dec 02, 2025 at 07:16:26PM +0900, Harry Yoo wrote:
> Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> caches when a cache is destroyed. This is unnecessary; only the RCU
> sheaves belonging to the cache being destroyed need to be flushed.
> 
> As suggested by Vlastimil Babka, introduce a weaker form of
> kvfree_rcu_barrier() that operates on a specific slab cache.
> 
> Factor out flush_rcu_sheaves_on_cache() from flush_all_rcu_sheaves() and
> call it from flush_all_rcu_sheaves() and kvfree_rcu_barrier_on_cache().
> 
> Call kvfree_rcu_barrier_on_cache() instead of kvfree_rcu_barrier() on
> cache destruction.
> 
> The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> 5900X machine (1 socket), by loading slub_kunit module.
> 
> Before:
>   Total calls: 19
>   Average latency (us): 18127
>   Total time (us): 344414
> 
> After:
>   Total calls: 19
>   Average latency (us): 10066
>   Total time (us): 191264
> 
> Two performance regression have been reported:
>   - stress module loader test's runtime increases by 50-60% (Daniel)

So I took a look at why this regression is fixed. I didn't expect this
is going to be fixed because Daniel said CONFIG_CODE_TAGGING is enabled,
and there is still a heavy kvfree_rcu_barrier() call during module unloading.

As Vlastimil pointed out off-list, there should be kmem_cache_destroy()
calls somewhere.

So I ran kmod.sh and traced kmem_cache_destroy() calls:
> === kmem_cache_destroy Latency Statistics ===
> Total calls: 6346
> Average latency (us): 5156
> Total time (us): 32725981

Oh, it's called 6346 times during the test? That's impressive.
It also spent 32.725 seconds just for kmem_cache_destroy(), out of total
runtime of 96 seconds.

> === Top 2 stack traces involving kmem_cache_destroy ===
> 
> @stacks[
>     kmem_cache_destroy+1
>     cleanup_module+118
>     __do_sys_delete_module.isra.0+451
>     __x64_sys_delete_module+18
>     x64_sys_call+7366
>     do_syscall_64+128
>     entry_SYSCALL_64_after_hwframe+118
> ]: 1840

It seems tools/testing/selftests/kmod/kmod.sh is using xfs module for testing
and it creates & destroys many slab caches. (see exit_xfs_fs() ->
xfs_destroy_caches()).

Mystery solved, I guess :D

> @stacks[
>     kmem_cache_destroy+1
>     rcbagbt_init_cur_cache+4219734
>     __do_sys_delete_module.isra.0+451
>     __x64_sys_delete_module+18
>     x64_sys_call+7366
>     do_syscall_64+128
>     entry_SYSCALL_64_after_hwframe+118
> ]: 1955

I don't get this one though. Why is the rcbagbt init function (also
from xfs) called during module unloading?

>   - internal graphics test's runtime on Tegra23 increases by 35% (Jon)
> 
> They are fixed by this change.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
> Reported-and-tested-by: Daniel Gomez <da.gomez@samsung.com>
> Closes: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
> Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

-- 
Cheers,
Harry / Hyeonggon

