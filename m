Return-Path: <stable+bounces-106832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42033A02421
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 12:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DF16414C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D31DAC97;
	Mon,  6 Jan 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avHGql5n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T+mwspJ5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C8B676
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162384; cv=fail; b=JAivgCMj+WeN+ayPretG/S88WLcWOfo+zt9AxK8XH3zXTy/cDH4IFUSN52wg8/CF1k5D2dQihJJIX9SmzlaJdmEWNymtlvukQf/Wo2L32okmfR5mzhnmeyE/XVYdUfFfGG3HUNE1NZ4jg7q2UFQfCOG+2+8pQP4t4XYakhFwzE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162384; c=relaxed/simple;
	bh=acXweHRiTg4oegPLVnpYNfLe9/cX7RTIJCcO3hbavsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXUfeGa2r81N2moz2w2N5piIN34LfuHYOZN1IJIhzbT+X3jPTBrmJKIEyhtGPrzFhFCr0fmI8eVRDTI8YI3OKHxY2ti+cfFJ49rl4usGoG/K3IhCRuqRVlFcVkrAE2X0FODNoIo82ndEHbLhf4VBLctqbPxzXdXPmS3lRT5ulEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=avHGql5n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T+mwspJ5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5068trbc010436;
	Mon, 6 Jan 2025 11:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eps1akctSZVHBZUZac
	BgIyiaQGQSpM2RJ1jl1+iOUL4=; b=avHGql5n5dSQLz7k4ryceU6Hu/GOSIauZB
	KPIMcZyObmjZNbe5OAE1P4FidQY2pBosvYg6u3T6Vno82ZQiQiEn7g4cMwSAgGLa
	iGqc9kPtDba3BY7zEn3ptvbGbC3fXF/iKfPqh1pIhz58lQs2wNveqxyorbGPBC/p
	V5YqF9bbIpL7c0Tdop3Frqn+1QJFnjXa2xLaPnoQdma5CEUPX8KaQ0vank2EUiQ/
	Km07tBTEFNo7d/5qqI30TX62aWWhy54a6q4DgdE+TYDqskdLfvvfjl6z+8SecGU5
	Lhvy44n2LhW3tTaOLfNkpslpAstclgXHvfr3ywo6sfnJvX7so6sQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvv923kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 11:19:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506AQJom011068;
	Mon, 6 Jan 2025 11:19:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue6xb3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 11:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9nAGzYl8mfqUydkyTroUS1o8vgWQZaAKy5OpWyfAnZp92oEYQKbm7GBRSXz6FMXMKkKn90wSQ0xik+Plgqw23iaXb429GuE2mPLsEDQ8F+xDLP30UPiMrjqN6holr9sWwkzWohx+yisWAHU5Yiw4TXgqOPC6yJU7RU2RlQwg+o4yCclS0SkN6gC/kdQIjoPGBHfeaeXAc8r4AofoLCzGfpoLF0OBuYizUCqzJBhS25nQrUbwilUROVUysYhWxxwk8nVtnWb1oiwsGvNjY482NrUFs1AKxmo8FxoRI+2D53cobG4Jh+lVzTedJow7YMjrhzD/YPknvs5dhGmdpaVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eps1akctSZVHBZUZacBgIyiaQGQSpM2RJ1jl1+iOUL4=;
 b=YAzYQmrHglItAQAvxImO9Uv/Wld/d4mKFVCp0Dgrz8W1RkD7Qn5/2zivV6y5lpUgnSsRRfj+EE1+umEwuIrGHXU87dkoLXH3DLVm0GtLexgAvZyh5SViEkdzk44ZjAvPpMTzjfMPIoOQneKGV4MP+LHfRe54yZUCBBQmf0r6Jw3rbZyY1R/1QdwZuxVfUy/7Rn5A5J4rayzMLDigITiDY5ODVvmNx3JUXzcOy3oEipOR0B3wu4cG8hxMTxfhUAJjreY96u4nV9e0gPd3IoaMY95peXdhzBi/RQm9QMnaNWp9rgGSantOc81EY/9JrvmYPtSeRD6Y6NrnzrM+qj5GUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eps1akctSZVHBZUZacBgIyiaQGQSpM2RJ1jl1+iOUL4=;
 b=T+mwspJ5LOmlexdvqoMScjfuaBQUY06WXyHQM3dQA8a6vUWOHcwoPp8QXftdd1lXpwz24qCeIshfbbrGKtK7B958bpSoX2S9VC+ZC08c+gYdNGYnfCGQ7RJIbmM5wMkNWexLJfR47w1sUpTk2XSzQbkNtn0iRI5NEYojvnB/jOw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 11:19:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 11:19:23 +0000
Date: Mon, 6 Jan 2025 11:19:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: gregkh@linuxfoundation.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        ju.orth@gmail.com, shuah@kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm: reinstate ability to map write-sealed
 memfd mappings" failed to apply to 6.6-stable tree
Message-ID: <5c77a26b-9248-4f04-a5cb-256186dfb7f2@lucifer.local>
References: <2025010652-resemble-faceplate-702c@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010652-resemble-faceplate-702c@gregkh>
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea66da2-de05-4048-850f-08dd2e43f8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9od07SwpvpziBCgR53vqp1Cdsu+FtYvYZPn5zYvuaO4KTjHimbJ3rzM9V3ia?=
 =?us-ascii?Q?tWXKlImHa03IAlyo85hr/HDrxR7vsW12AKWHEhhQ0l2bVXlyGW8g53ocTgRy?=
 =?us-ascii?Q?NAXZ0w6+h8kDrr0vzphcXanPGCNvB1Jw1hFDSosLH55rjKuVwL8VX9kyxIhP?=
 =?us-ascii?Q?Mxyx3QCDLsuWrHNJY/NwNVVS/zwpJ6MWKDZcEaYiks32fR8fmCcx7mCmndwX?=
 =?us-ascii?Q?X/x3GU6C05t1EfnxkTjruwGqaskP/4nzyPtJHJqmOQEb0DwBv55YH04D/TNW?=
 =?us-ascii?Q?qerqve62m6ha68aWMLxoyXxPPyo8zjz0chojmdJ3FlOZqdNYwoQUujfCS37z?=
 =?us-ascii?Q?0Uxmu+wLUd4VdRrLBu+2ra+quRjMAyELhDKYApCGX72mE8kUagSibQWhM6ze?=
 =?us-ascii?Q?08KqyugFeWc6qcgdR7HbxorzMu5j7Kn2/K2CpY8j6SzNee/Wifm7a4ZamtJr?=
 =?us-ascii?Q?4JhxxOLOUxJxt3JEkW27ObPXvsgeiSQiAfuYrYK3ETsdNRSolc79YRm7wNOh?=
 =?us-ascii?Q?GUkd3Fnjv13BvvN0iHOsyschjxKllDWquIB5O00CyJmv8d/PPyj5/c4riJlp?=
 =?us-ascii?Q?D5mrUA1F7YlXVYm7atUVC3BGg1Ko/U1TkxyE3mPf62fsQHAtqOp/q9J17jN5?=
 =?us-ascii?Q?deC186TTV7lPHtmI0dWq/Q/ulqaVggQeZ3ilNlQiYKmL54qiLUmkjLT+hYbu?=
 =?us-ascii?Q?+RNiL3i2/dSNqFtCUsciCldvACcwSbv95GR8Mbhtd7sq94cNId0ijkBB4Jjz?=
 =?us-ascii?Q?vOLtCT/h1l3yiwcFQD8Dwry/IThVNkH+fEyD80ViS38nMaJv70ZegHGlHI2N?=
 =?us-ascii?Q?nLIbad/9FdBetBa5C7kYz6d+t9FXFshwRy16sLYFOH/djaUJG5mA6nglJgoD?=
 =?us-ascii?Q?1ZABpycIoGllBT7GaFK0Eot1XDIqHQLmk4ZkE2CZ37pIieCh0F0zAzjVOnD6?=
 =?us-ascii?Q?vJo3hx/GOKcupO03Pg0PItk2ngKaM+jZ3dAFZVfJatFl7qUHNQk+RdwPCLvZ?=
 =?us-ascii?Q?nGGZaRL0UGnRx8AXPZpiTCiveGL4o+9muJAXs1AMTfI/+Ef05ReOdtxRAwdc?=
 =?us-ascii?Q?X9tKonE7aYE4aBzyhJpRngi5Zpr22MKxsTPD8AhEGbkl9v+WYzxm6rFj9ZTF?=
 =?us-ascii?Q?NnX2v8ML4EeTdt8dpVHuqsct/rQU+vOn4nnGrbjpj9BwDltvFJPZyBlPK98v?=
 =?us-ascii?Q?bnMkdW2wS747F5eTrTzjVq1hGEWDvM5JIQun8dqffgW+1XbwX/gXMJ3OlIqW?=
 =?us-ascii?Q?mgx7hk6UlNrwLh4o1D22eehi5quIf4Nkc/FjFIhw3LXU6HA9RgRWsdZgSuLj?=
 =?us-ascii?Q?/5Xy8ivnCnBFI6mJXJOa6BHinkhAxSDoZ57l5ccgdJpY7fusExMlvMmgDEkk?=
 =?us-ascii?Q?Qoqb/6EcHvgbrR9fB/vqWcRPP3OqCnPNz78UC+8MAWOtIeFpDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmTY6VGpAiyytWM+yW/hnPtOYKZVRg0lnrYnroXnxDzG8aSx+dEpQrf2b0NJ?=
 =?us-ascii?Q?5v71DlPBWanRofAR63QZgzO3dGUtRvrFmyLKtuARgv4gpjgygPTxqAD89XIR?=
 =?us-ascii?Q?pXFZYo6jz1Sc+HmdweD/4QylcmPloD68TaEOC7ePib8fNxXMZu5WJhXzg8BK?=
 =?us-ascii?Q?1DMxdF22N1X+cC3b/cFEzdfQQgvj1mwn70Dtu3MmdtXdsRHM6pgVy4A2sNkL?=
 =?us-ascii?Q?2U/5pQZBNUJ6cjcCmje75xRauUCCqUR5VylnkSvq4DJ7+CnOctHSBt6qsrH0?=
 =?us-ascii?Q?MF/VKzluLtnU92V8JuqDeR/4TWplGGEFPC+hNKa82FkdfAK7g5/9Q5Tvz2+R?=
 =?us-ascii?Q?5kE6TYRM3mIgdLiyNFMN9W82ze5wcpl0hNUFlk0rrbvLhe1o0ZCQJl3K3gGj?=
 =?us-ascii?Q?PM/3MmKeLtPptYytHgVT+mxC1x7sx/aEjTfMUbWCgJWO73JIZnITeQqSuv+r?=
 =?us-ascii?Q?XuytX+AQatzYvk3bpuNoSc8DHzM1dEaLuu3UTypxx6TNOvOPf5OxFv7p8FLh?=
 =?us-ascii?Q?TKN4hWqScYph9JTRv9PEsuhTLird3Ek3n+Lne9zoizIBRRoqJLS65wE3oMk/?=
 =?us-ascii?Q?VJW+Qld2TxXQrhI7IweAxEgc6lud0NCAlgQQPKnGBuvWz7INlSppK8QOuTwz?=
 =?us-ascii?Q?8JY4SxFcUtXIcnfUIono3m7NEgVakUeYUb6TtXFhiRfmBE6ysWl5vXBPqoQA?=
 =?us-ascii?Q?9AirQ6spNQigFL+uvW6whGpX34s95xfVJeFquO4tAQ6sTOsCrYCrin9nNOXh?=
 =?us-ascii?Q?7D0Q4b/KameomC8lhLnyVtLEJDEHreZGxlXUkl7PYSQI7+SwUPuU9U+gPFNP?=
 =?us-ascii?Q?QMOI+Fz4vUU4MxKi3rH+zq26SmbVROBp595Z8dbbAAWJCNFsvcdiNtGMzSHi?=
 =?us-ascii?Q?taWD5dyU5nafhPTv04YRbb+fYNQIP4uRSSaccD1nYCUUomg4edw7z6tb/xeh?=
 =?us-ascii?Q?YOrrd9czbmn2yw+GsvGpFbgiIeHFTB0WQh9v9ROGjtlVUcnOtRDeAmCRmMTG?=
 =?us-ascii?Q?elrOd1u8uHjH1Wyk+M+kwKdUPtN8SJ6yWLPqexT+Fntc9SNIiAAHEkjrOY6S?=
 =?us-ascii?Q?dzNrgMooG7tRj3GltZIwVo58gijKZG5Vc4KXL1AlcIiSCZv2lCEH97PwAITE?=
 =?us-ascii?Q?0ejhEjM6Jvbll4B+hvW55C09JRJdwLbn4oaIgAnj3jX0e2MgVRml+hJjLYB5?=
 =?us-ascii?Q?vIPz15M3rzLO4njjEVhvoEPWfdv92Zn1QF9YIEi+demdc8hqgnl+AHcsOpxq?=
 =?us-ascii?Q?x4aQyJtrkPvATqsoCG1ePJZGIvjDLO0aoX4eLUWjCRY191dwwug8or68nG4P?=
 =?us-ascii?Q?F6pz77Jf0KczQrS7wb6iPYpPlkKDR4er1M+UqFnJzJHmlzunU/6wLiw4dvvB?=
 =?us-ascii?Q?E9nxnDfZ8LRKW1m3GNZfOFzb9C83vuxuxs0QNM3bk7z+4toHnstQt6MMw/0l?=
 =?us-ascii?Q?bzTUzOBnQqy1y5ttBmhBR9EmkEi4B4epG0CrbJcgy6bQJOVqbAzgHsBLCTlV?=
 =?us-ascii?Q?vm6PwalceHeADLYPH4nPKtYhh2FQdrOaIrrcaDFjdRXOZxJrCrQolf0iBoSc?=
 =?us-ascii?Q?9HYReQe3ZMHN146caEqfwfoQQ9OHyof9E2GI8BH/Pqj5A86+B643yYkIKAUL?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JZ9jVvslwDQN79tEZPKrTk6WkyRmXkQNZutMHmM8KOU9wo4D1flOqFce0tHiEGJ6b3KWcGvCUOVJI33dekyt3w2jaX19i8O2aU8IVg1Ia5EyEOvv9L3jfDKVEDuuE6p2EZ2A8PEtW3Lvi3xnrZIOyMqidN2Xi5d9p9HaAXMSTmFKW0ZKFvAj8JVjCFna3DY9ki32c2Pp26waGV4c4alp9SgeugZZXOTF5fQksUp8GEmopFWtdw4d7q4Is6CqLylWKfL9k9RFIPfu9DZYbxt1OCLlSwjck82qspej4o1m5fR0IEcfRhNrqcAfVk5JElo7qGjilhVSl14EmSsNYwjuQ47hu54WbxtCRPnWUfFSQu5/3ob1Rl4QHtyXzCdxXyK8gssU/Bg011JpDVE3i/aLkRrGrjH9+j88m1Rbm1Is+14H2nkrdFivsFpbCZYMTDvSSvHX1+t/rxyTvU3BuAW6+ggJkHn2MtfKimHpGrj0Og5INp25sUsg2BTBwj21AanAZUQ0l4Se/+07JHsZC+TN2QaotWv+oLCS2h4tIIs/EPtSrOBRRh6XTSK5ktAGIykk0ZgK8DvPPc7ptTRpw/OrVaGb75QaqLX3ybxbo0QAeYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea66da2-de05-4048-850f-08dd2e43f8fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 11:19:23.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxHjxJ9wbL/sccAiXEvfPmVugOsZAO7anavuFKT4l5POhTRdkeP8ye6QhQO5RzXhnwGSXa246oF2fe98bFJ3S250E3mejWLArMgz4ArtZDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060100
X-Proofpoint-GUID: fAs3ne7EOvjNW3MB6nlpswCwYMjhcyAs
X-Proofpoint-ORIG-GUID: fAs3ne7EOvjNW3MB6nlpswCwYMjhcyAs

On Mon, Jan 06, 2025 at 12:06:52PM +0100, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I actually intentionally didn't add Cc: Stable there as I knew this needed
manual backport (to >=6.6.y... - the feature is only introduced in 6.6!) but I
guess it was added on.

Now the auto-scripts fired anyway, can you confirm whether 6.12 got it or
not? To save me the effort of backporting this to 6.12 as well if I don't
need to.

I'll send out a manual backport for 6.6.y shortly. Older stable kernels
obviously don't need this.

Thanks!

>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8ec396d05d1b737c87311fb7311f753b02c2a6b1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010652-resemble-faceplate-702c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 8ec396d05d1b737c87311fb7311f753b02c2a6b1 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 28 Nov 2024 15:06:17 +0000
> Subject: [PATCH] mm: reinstate ability to map write-sealed memfd mappings
>  read-only
>
> Patch series "mm: reinstate ability to map write-sealed memfd mappings
> read-only".
>
> In commit 158978945f31 ("mm: perform the mapping_map_writable() check
> after call_mmap()") (and preceding changes in the same series) it became
> possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
>
> Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> behaviour") unintentionally undid this logic by moving the
> mapping_map_writable() check before the shmem_mmap() hook is invoked,
> thereby regressing this change.
>
> This series reworks how we both permit write-sealed mappings being mapped
> read-only and disallow mprotect() from undoing the write-seal, fixing this
> regression.
>
> We also add a regression test to ensure that we do not accidentally
> regress this in future.
>
> Thanks to Julian Orth for reporting this regression.
>
>
> This patch (of 2):
>
> In commit 158978945f31 ("mm: perform the mapping_map_writable() check
> after call_mmap()") (and preceding changes in the same series) it became
> possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
>
> This was previously unnecessarily disallowed, despite the man page
> documentation indicating that it would be, thereby limiting the usefulness
> of F_SEAL_WRITE logic.
>
> We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> seal (one which disallows future writes to the memfd) to also be used for
> F_SEAL_WRITE.
>
> For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> read-only mapping to disallow mprotect() from overriding the seal - an
> operation performed by seal_check_write(), invoked from shmem_mmap(), the
> f_op->mmap() hook used by shmem mappings.
>
> By extending this to F_SEAL_WRITE and critically - checking
> mapping_map_writable() to determine if we may map the memfd AFTER we
> invoke shmem_mmap() - the desired logic becomes possible.  This is because
> mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> have cleared.
>
> Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> behaviour") unintentionally undid this logic by moving the
> mapping_map_writable() check before the shmem_mmap() hook is invoked,
> thereby regressing this change.
>
> We reinstate this functionality by moving the check out of shmem_mmap()
> and instead performing it in do_mmap() at the point at which VMA flags are
> being determined, which seems in any case to be a more appropriate place
> in which to make this determination.
>
> In order to achieve this we rework memfd seal logic to allow us access to
> this information using existing logic and eliminate the clearing of
> VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> instead.
>
> Link: https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
> Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Julian Orth <ju.orth@gmail.com>
> Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 3f2cf339ceaf..d437e3070850 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -7,6 +7,7 @@
>  #ifdef CONFIG_MEMFD_CREATE
>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> +unsigned int *memfd_file_seals_ptr(struct file *file);
>  #else
>  static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
>  {
> @@ -16,6 +17,19 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline unsigned int *memfd_file_seals_ptr(struct file *file)
> +{
> +	return NULL;
> +}
>  #endif
>
> +/* Retrieve memfd seals associated with the file, if any. */
> +static inline unsigned int memfd_file_seals(struct file *file)
> +{
> +	unsigned int *sealsp = memfd_file_seals_ptr(file);
> +
> +	return sealsp ? *sealsp : 0;
> +}
> +
>  #endif /* __LINUX_MEMFD_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 338a76ce9083..fb397918c43d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4101,6 +4101,37 @@ void mem_dump_obj(void *object);
>  static inline void mem_dump_obj(void *object) {}
>  #endif
>
> +static inline bool is_write_sealed(int seals)
> +{
> +	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
> +}
> +
> +/**
> + * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
> + *                      in which case writes should be disallowing moving
> + *                      forwards.
> + * @seals: the seals to check
> + * @vm_flags: the VMA flags to check
> + *
> + * Returns whether readonly sealed, in which case writess should be disallowed
> + * going forward.
> + */
> +static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
> +{
> +	/*
> +	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
> +	 * MAP_SHARED and read-only, take care to not allow mprotect to
> +	 * revert protections on such mappings. Do this only for shared
> +	 * mappings. For private mappings, don't need to mask
> +	 * VM_MAYWRITE as we still want them to be COW-writable.
> +	 */
> +	if (is_write_sealed(seals) &&
> +	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
>   *                    handle them.
> @@ -4112,24 +4143,15 @@ static inline void mem_dump_obj(void *object) {}
>   */
>  static inline int seal_check_write(int seals, struct vm_area_struct *vma)
>  {
> -	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
> -		/*
> -		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> -		 * write seals are active.
> -		 */
> -		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> -			return -EPERM;
> +	if (!is_write_sealed(seals))
> +		return 0;
>
> -		/*
> -		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
> -		 * MAP_SHARED and read-only, take care to not allow mprotect to
> -		 * revert protections on such mappings. Do this only for shared
> -		 * mappings. For private mappings, don't need to mask
> -		 * VM_MAYWRITE as we still want them to be COW-writable.
> -		 */
> -		if (vma->vm_flags & VM_SHARED)
> -			vm_flags_clear(vma, VM_MAYWRITE);
> -	}
> +	/*
> +	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> +	 * write seals are active.
> +	 */
> +	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
> +		return -EPERM;
>
>  	return 0;
>  }
> diff --git a/mm/memfd.c b/mm/memfd.c
> index c17c3ea701a1..35a370d75c9a 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -170,7 +170,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  	return error;
>  }
>
> -static unsigned int *memfd_file_seals_ptr(struct file *file)
> +unsigned int *memfd_file_seals_ptr(struct file *file)
>  {
>  	if (shmem_file(file))
>  		return &SHMEM_I(file_inode(file))->seals;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d32b7e701058..16f8e8be01f8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -47,6 +47,7 @@
>  #include <linux/oom.h>
>  #include <linux/sched/mm.h>
>  #include <linux/ksm.h>
> +#include <linux/memfd.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
> @@ -368,6 +369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		struct inode *inode = file_inode(file);
> +		unsigned int seals = memfd_file_seals(file);
>  		unsigned long flags_mask;
>
>  		if (!file_mmap_ok(file, inode, pgoff, len))
> @@ -408,6 +410,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  			vm_flags |= VM_SHARED | VM_MAYSHARE;
>  			if (!(file->f_mode & FMODE_WRITE))
>  				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
> +			else if (is_readonly_sealed(seals, vm_flags))
> +				vm_flags &= ~VM_MAYWRITE;
>  			fallthrough;
>  		case MAP_PRIVATE:
>  			if (!(file->f_mode & FMODE_READ))
>

