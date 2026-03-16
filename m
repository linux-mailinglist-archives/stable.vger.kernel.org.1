Return-Path: <stable+bounces-225714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPiSJmyJuGksfgEAu9opvQ
	(envelope-from <stable+bounces-225714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:51:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA32A1BA9
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7326A3056D86
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EC37417A;
	Mon, 16 Mar 2026 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FwBHjmhJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F9366559;
	Mon, 16 Mar 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701192; cv=fail; b=i/fzCu3jJbINVxRGUzkwekk8sj2vibcHhLUQEjeSvm4nEmn9rIjjnnJ+wGgMCUo3mFb04Aesv63aSXgUum6VlTf1tDbQcnLnkLiYBiZaXxeMySxuuuIRsa92lXIf6+LHTEPAtMwutY3je0C8QESDiZ2ISASCVi6r6Azu49/BDuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701192; c=relaxed/simple;
	bh=MT8BWFg9CYFaT1J8iq9JiVS37nW5sXeUmm5VyVXBywI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Agf1xDabGaMVoid9/pH/NTX0FELFuJXx66b0EnMRUAGYyO0eowoSjq7998hjqFEG8jzTZX/gDznqQIO0WAZSeHjXT8712HuzkwQ8mFXSr9LNwjDkkRz6qZEcbeb1cqQDUOQ52qxENSu99Ho4RfT8r8RhitwZBhG9le0T3wckxh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FwBHjmhJ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMUBnF3709441;
	Mon, 16 Mar 2026 22:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MT8BWFg9CYFaT1J8iq9JiVS37nW5sXeUmm5VyVXBywI=; b=FwBHjmhJ
	In00IP+jpGqEgCOFs0TLRqN0fCnrllS5U80EOdCi+TXPO5o34OBkRULNREJ5TAoc
	ylUiox2doQrkMY5GADAaS1Gh3fjUfichih+oSTEwCnTWXEj3hFJlfnAYaun8/Dju
	PsysFMnARZkCVGEl5nh1L8ksqdKA8VaAAPhGeJpSB29IDGU1yZ5HTGVlVWoIGPPB
	laplE1L1E8+NPG16lLTPN+Q2nrvqLhIYKxO2oLcFn51dgMzYAEiarauVVkMob+0Y
	BFkEFu+naxdau00eEhI8btvFyTYb1ywEiqKzu2hhVO5d4dri74gZ4GQEIlBuq3b5
	0/fK2WyGvlChdg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3csndv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 22:46:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vydt+7C/2YwoNSJ+bmbJoyVzoKq2ftatnluP8hnbLfYVULL9JYlei0SZ0Jlj41Q64xrnbsKk+o0+FgkwewZ3FIUk3PV0efp4sWbu095LnT6iNvdLIucx0B3pr7XZRnmcR3R8SataLZSWYcwilI7jsPX5uJQm+zYT4pIcF1MelX00hY1xYKX9K3C2viTQSZIZWp2LcCUFYQb5Zz2n3b+w5cnU2fptxRohf8+xF3bIoyQg7H/czVv8NQRZxGLfkLAYyN4Hdm8+xOw2daWlpayUB0dcaUr0fbdYe5vZbKUfXHBVEyw0je8dQcJ9W9PQ/35c1ZCxDpPP4YPHfaeJn3zsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT8BWFg9CYFaT1J8iq9JiVS37nW5sXeUmm5VyVXBywI=;
 b=w3yXOlAu9m0HWn6bwGbYlh5L/4ihYK6ibSapFz0BFT0pWeO0L1FFPvNIGvqZMtkyiAwYjoTYYGzfxVAogw7eVPy63AszBZ/2yw3yxtF+pPw0Wdhnsu0DRYrkf72mNSxuikxdht6ugBi6EOL9Lwyrovur/RoTNZHWmqhssG1Ej97mdc6JPs0c7KVYX1M4yF0vJiN/bQedAtbRIcyLg+ZvU61GCusBzFIILkW3nOhoxsWDYppN3MYaDBhIMXFv5M2DyigLSjjXIJvQPWKiFDZFG1i8FQ+Dd0E2D7C/zaU+qVAjPBl/zbZW4h9C+UrIgj2ZG+b1PedBydnnQ+7V8hvBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4951.namprd15.prod.outlook.com (2603:10b6:806:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 22:46:15 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 22:46:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "zilin@seu.edu.cn" <zilin@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "sougata@tuxera.com"
	<sougata@tuxera.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Index: AQHcscZlUtL+PntFI0i7djFUt62CeLWrKgGAgACJzICAARm+gIAAlkWAgARmBIA=
Date: Mon, 16 Mar 2026 22:46:14 +0000
Message-ID: <054d2ebe267ef9c13468a05557cb099c49a0b872.camel@ibm.com>
References: <74c78d0e14517ec28ad269113244562c081722a8.camel@ibm.com>
	 <20260314033603.14211-1-zilin@seu.edu.cn>
In-Reply-To: <20260314033603.14211-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4951:EE_
x-ms-office365-filtering-correlation-id: 9937198c-d0e5-41ed-0fc5-08de83add466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 JQDPF943Mpp3fjqwOOZxNAbYcO/dUUwTsBPMKLxWJWb1RWTxe949nrJm9UFByvDhklNj/3cLhCxeadtzagjkFUloSimBpEmW5WHZBOKSNg/5MT/X+SQVBm/4qDYU8782/6kQe6x1WjQQmq1VDv52N68Pd/nAFQwmbsgwCxDv4po/uqSIZrD8JT0beagsh/VgnvPADQVLSFEVlYdcFwjdIcxgyUTGMsiG3Hsc+p+3xazeY8hLM/8mGjUthg2r/zcHN/o2QLHmQlJ87SIv2QxoIKlr4UQFmPsdY80N3SAMV8bKBhFZJPo6KprZZVm/Om4+M+XpJElncEPMtpGbJbIN2msiE9mzrSs0aZyDepQn3/eu7+wox9pUi5vv8d+DiPx3yrvooqWJv+RNE6brWDVdJb6n2E/OZEVkgvRsbhH1ec6lhb3mn/ZOViQxtWV4jqnq26kbSOLeluFf+ZQs4RfDiwZPEViLdQToZg7V9woX3mYbtfiACKcmS5n1HLMPCr/P6jvBl257pPuC2nZUg39e7CPUW0vh2FLiYEk+AR5k3QH/HV68l/ytuInzdrFe0bT2uAZbxTaO02MhidOa/TPOmNhwHeFE9KYTcWvXosMwKXRBAKZMt1F6ZNcOdUiV0KSmdDGv64h0ExC4UJRg9xkxmnqXOwo6bpPpF1WFotYD9yIjqhe69wPJiMBi1fmj3c+COFP1fLFgrgl/TWuLmK8NXenwMA9giHNK2sPQnp2cP8k+gxlXXeePNCnqBaKk48oNZ9W4vlg3aWeW6rEckyLbEnXYQSogU+2ADT+UZmJWdvY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmFvTkdvSEJQejBKTU1sVXlMV2t3UzhodDIxS0ZObjMzK3U2cjArbU5pckM5?=
 =?utf-8?B?S0Q5V0hWTGt5TWg5enJDT3c2Y3UvZUdhc0MyV1lsZUREU1RqckYxVUcvY3VT?=
 =?utf-8?B?RDVla2UrbC82QTFRV3kwK0FrbE1tSWxNdlp1TUsya1FRZmszeDBqL2NNUTRP?=
 =?utf-8?B?K3hrOXRCY0pEMnU3WkNJQi8yRUREaVBTMUpkem5BcThpSmpuMjI2aDFRNkxV?=
 =?utf-8?B?M2RHYjdacENOMHhNekZNMytrSldaeG54Mi9WNGJnTzlkbDFTdUVvQUdSay9M?=
 =?utf-8?B?TXRYRjRoR0E2RzN4NHN6dmNVRXNObU1YUERzSDhoVGEya0ZqaXB5ZWJUUHJk?=
 =?utf-8?B?bm1vYmdMdXQ3Z2Mva2hhb3RSMHRDSGRoMW1JUVlFeGN1S3BHQWp0Q2I4R09t?=
 =?utf-8?B?ZVZJUEFzZWd5NWVPZ0lNNmRQakgrNHJBYnFid1htUlJLSWp6dnpwSTNMbzZC?=
 =?utf-8?B?dUIzQVF6cEo4VGlpZFhsZFQrcEFNNFJWU2E5NkxOQ1Q0bDNjeTZsS0pqVkJG?=
 =?utf-8?B?b0cyUXplNUVMTUptWExaek1VVEhKaUZlNG0zWDFPb2FPaVNNOGtwOVo5L1dh?=
 =?utf-8?B?dzJDYU9veTZsMjdiQmNUV3FiZ2RGc3oxaXFOODJZSU4wdjF5S1EzZ1N6dGR3?=
 =?utf-8?B?bWN4UElxbXBYdWlaUS8wdk1saDA3YU1NT3p5OFNIL3JzWnB6aG80NWc0SDhZ?=
 =?utf-8?B?d1EvTHdiYk1zbEdqakFDRldwck9TZnk5cmdDcGVxL0krWWxWQTFHTDlUN09y?=
 =?utf-8?B?T0owS09JbHc5ZlMzQjBIeEJhbExjOWlTR0RXc2JlMGdZWExjaUkvdFpoK2pw?=
 =?utf-8?B?NWpNQnJ4dWVpMzBxalJ4YWdFRkl5dGNyTjFkcWFNRUx4TjY0WUp1Qlp3OC96?=
 =?utf-8?B?TG5Tam5jMkMvTFFRUUxpVndmcXVQajNQaCtrTGIvUkcyczVwNngrQXFUVEFW?=
 =?utf-8?B?Zld0ZzhGRGNtK3BIdDk4UktSL1FjOHNUVm5pblZwZTdva0dUekkrQXpXeXFD?=
 =?utf-8?B?QkUyYjJtdXFvdHNlZ1lkS2lUZUZWWThUTEtuS3FzQmZiUTc0YVJNT252UHM0?=
 =?utf-8?B?dmZlZlVrekdLeVQ5SmtXcUowZXppM0NXSkRjMTRQa0dhdG9DVzVXTG8vVkhr?=
 =?utf-8?B?dEo1TTVnUXZUenNrc0M2RDRBZzhIU2l5VEdFMnZaQ3pIaXBHWFhKTm0wMUVP?=
 =?utf-8?B?NTJtTkpNSWlKQVhhSyt3eGg3YUhLU0dZSUFac0FmbEl0dnhRdUl1N05hejZG?=
 =?utf-8?B?M25pcy9NTGF1SXg5aWk1SWRzdzh4Q3FXTGUwRlZTNHJSc2ZyV01Gc0oraEE4?=
 =?utf-8?B?WWt5aTM4ZEJkUUxIZkU1WnB6VkNSaEgyZlRtOXBHaVI1UGx0Tm8vVXkrcnkz?=
 =?utf-8?B?bFZsemdBOGkrejRpY0E0UkJvaFhxUlJmeU5XVUlGSUVUWVZTN2FIb1BSSU1K?=
 =?utf-8?B?a1p3MUZNS1BBN1FtU3FQRVJvUnltT0lUc1ZCZWlYK1lxdHl0TlNOY29ncGFE?=
 =?utf-8?B?MmNoOVYvQ0owaGh2b3plWGJVSlF0V0UxRnVadlZhOHY3bUZwbDdnTldZQ2ZH?=
 =?utf-8?B?bXVFcmtVQmtxbkV0SHgxUlZCS2w2SlJUS01oNitCZ2pSSGhLdFlLbnprVXJM?=
 =?utf-8?B?L1RNckhVbEhrOHI2T280eVlPb0Q1clNmbERuQ2NsWFNHYnFDdEtBUEJZNEgv?=
 =?utf-8?B?V0VjdXBmN1gyQ09IWE1sVnBUZ3c5ZmhJMFdldkpzZU9vRUtnTnF0NFREQnpE?=
 =?utf-8?B?TkFHZHp4c3J6QlRUVTUwWnI0UjNuNXQrMWxwVTVZQXF5LzI1K1RtMW5wbnZi?=
 =?utf-8?B?M0xvNHlUNTFjbVlsWDdqaWM0d1pBQnZPNGZ1RnhmTEdDMHdYQWJBUEkya0tG?=
 =?utf-8?B?cW5Xc0h1RUxsUUx2eGEwUzB5WUtNM1RscndDb2Zob1E5Q1VvM1F0TURUazIv?=
 =?utf-8?B?RGhialR5UU1nN0tWZDY3eXpySGhXYkd4RUNSczM5K2FlakNyWjFySVpiT0pU?=
 =?utf-8?B?ZDZENHhmSmx3aVRuRFlUeHJxMGR5NllSUFNrc2hEcUJ4OVZJVEYrdmRKMkhT?=
 =?utf-8?B?elVTcTA0cXp3MkhwTkNhbE0xTTBhZjEreVdRL1phRTVpSVc2ZXhHVW1nVnZZ?=
 =?utf-8?B?SVlmK1lHaUZxMFZnWkVTcHQ0cC8wZ3doZ1BRRk93U0FVdDNnM3VLRVAya0hS?=
 =?utf-8?B?V0c5VFkvYnYzZUNTbDBYVWJ1WjhUVXd6TXZteTgyMVR3ditmbGQyYVk5Y0w3?=
 =?utf-8?B?SmduZVZVSjlnaHVJYVdIVnhNOEx2SU5Cckp4eGd1dUlKczNkMlRxcGhrcVBa?=
 =?utf-8?B?TmZUVjI2Mm96dGdiclYzS24xWHRTY2twN3g2QTFwRnE2ZW13anZBeW9Ga3pi?=
 =?utf-8?Q?LPQ4Z53vwe7VeSwxrWfSFPBAlXXkHz6fnAok+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A17F123AD07B408D4C06F81698B56A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Q4k14nCNAKdC4sOnrn7h5ulo+1/9h279iT/Dh0DMUBp6j8wXIlpi2A6S+YKRTkotPhYTk7atj7QsFbvpGaDM+eIDEDgrIhkRfLD6DRDEQ3Yx9m1SdY22CT61cGHFSSh52p/09DeUpk4pFPvl3yovRPXguZt9FQGm1/9b2piW1WovtwgO0wruieG/l2x3jMDEX6l/69b/IUszVYI3y3uE5i73xoqDTwfci8cFEwnkEO5h3z8MXjJA0Maqzg4rSPfIZxavMkz7zJXKB+XICP7/hKBb+5ARdWsT1XuRLeYrEUcEZ2FH6f3+zzsnURtjVBfY6CCGs9lwkNjVik8HIvS5eQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9937198c-d0e5-41ed-0fc5-08de83add466
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 22:46:14.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeW/i6DL2DM9re+AFC4WAkz25HD9dH66/nwNDYOjr1zQwGMG/aTs4cG8WL2cy0l28JR/QNZy0K8aBfTijVd+UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4951
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b8883c cx=c_pps
 a=gTn3qzDU66SAkKtIq75K5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aeY5Uc4LBi5KrMi6YUcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE4OCBTYWx0ZWRfXxFVJuwMIZaVJ
 slmhaljOBsIbvS3YKz5o6B4KIBtEfGOFBSPPwhHfFpLIdO8mhtzhDP/DuOLoqZSg/Nq9I7leT7U
 nmfsiDNTrpY8g0u+T8CU2P1lGi/l/YP6rv4XC56YMJ9+PQaIXzh9/J/qwzdI30wMmiMnCP2fUhG
 ailLHvu1p9kQGUKbJlBCfRNzZfrfPYJzdtg6UH7TcNEc3ed7uqaoWoLUQ9zT1OOLEcTa72B4WHX
 6WW6EiqWCCOisPN7H8SChqKjtk5+F3CFCtzT4b3v0BbYCapnsVLZE+Q8krnN0emV2Q8Q9T9Syxj
 /JWYURyRadAfG5tBOmiZJNr4xD0vo1ySZA97TrgMIZdHlLbvw3XhJ2FaGyTursmzZ8u4eSVMx1G
 XCPT/7N3iZpo59SLBdCnG6Jd+f8arrRN11R3EGet3BOJahkan15pPDskiGVEx8eMZD/3N4oXKTA
 Woa9vNqLCNIi+gtHlIQ==
X-Proofpoint-GUID: 6BX6Vpc-2qaEquYTUeUcaHcLzz5hakw5
X-Proofpoint-ORIG-GUID: 6BX6Vpc-2qaEquYTUeUcaHcLzz5hakw5
Subject: RE:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160188
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,folder.id:url];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-225714-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3AA32A1BA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCAyMDI2LTAzLTE0IGF0IDExOjM2ICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBP
biBGcmksIE1hciAxMywgMjAyNiBhdCAwNjozODoxNFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDI2LTAzLTEzIGF0IDA5OjQ5ICswODAwLCBaaWxpbiBH
dWFuIHdyb3RlOg0KPiA+ID4gSGkgU2xhdmEsDQo+ID4gPiANCj4gPiA+IFRoYW5rcyBmb3IgdGhl
IGRldGFpbGVkIHByb3Bvc2FsLiBIb3dldmVyLCB0aGlzIHByb3Bvc2VkIHJlZmFjdG9yaW5nIA0K
PiA+ID4gY2hhbmdlcyB0aGUgZXhpc3Rpbmcgc2VtYW50aWNzIGFuZCBpbnRyb2R1Y2VzIGEgcmVn
cmVzc2lvbi4NCj4gPiA+IA0KPiA+IA0KPiA+IEkgZG9uJ3QgcXVpdGUgZm9sbG93IHRvIHlvdXIg
cG9pbnQuIEkgZG9uJ3Qgc3VnZ2VzdCB0byBjaGFuZ2UgdGhlIGxvZ2ljLiBJIGFtDQo+ID4gc3Vn
Z2VzdGluZyB0aGUgc21hbGwgcmVmYWN0b3Jpbmcgd2l0aG91dCBjaGFuZ2luZyB0aGUgZXhlY3V0
aW9uIGZsb3cuIERvIHlvdQ0KPiA+IG1lYW4gdGhhdCBjdXJyZW50IGhmc3BsdXNfZmlsbF9zdXBl
cigpIGxvZ2ljIGlzIGluY29ycmVjdCBhbmQgaGFzIGJ1Z3M/DQo+IA0KPiBBY3R1YWxseSwgSSBk
b24ndCBtZWFuIHRoZSBvcmlnaW5hbCBsb2dpYyBpcyBpbmNvcnJlY3QuIE15IGNvbmNlcm4gaXMg
dGhhdCANCj4gZXh0cmFjdGluZyB0aGlzIGJsb2NrIGludG8gYSBoZWxwZXIgbWFrZXMgaXQgdmVy
eSBkaWZmaWN1bHQgdG8gcHJlc2VydmUgDQo+IHRoYXQgY29ycmVjdCBleGVjdXRpb24gZmxvdyB3
aXRob3V0IGNvbXBsaWNhdGluZyB0aGUgZXJyb3IgaGFuZGxpbmcuDQo+IA0KPiA+ID4gVGhlIGhp
ZGRlbiBkaXJlY3RvcnkgaXMgb3B0aW9uYWwuIElmIGhmc19icmVjX3JlYWQoKSBmYWlscywgdGhl
IG9yaWdpbmFsIA0KPiA+ID4gY29kZSBzaW1wbHkgY2FsbHMgaGZzX2ZpbmRfZXhpdCgpIGFuZCBw
cm9jZWVkcyB3aXRoIHRoZSBtb3VudC4gSXQgaXMgYSANCj4gPiA+IG5vbi1mYXRhbCBlcnJvci4N
Cj4gPiA+IA0KPiA+IA0KPiA+IFlvdSBzaW1wbHkgbmVlZCBzbGlnaHRseSBtb2RpZnkgbXkgc3Vn
Z2VzdGlvbiB0byBtYWtlIGl0IHJpZ2h0Og0KPiA+IA0KPiA+IGVyciA9IGhmc3BsdXNfZ2V0X2hp
ZGRlbl9kaXJfZW50cnkoc2IsICZlbnRyeSk7DQo+ID4gaWYgKCFlcnIpIHsNCj4gPiANCj4gPiAJ
CWlmIChlbnRyeS50eXBlICE9IGNwdV90b19iZTE2KEhGU1BMVVNfRk9MREVSKSkgew0KPiA+IAkJ
CWVyciA9IC1FSU87DQo+ID4gCQkJZ290byBmaW5pc2hfbG9naWM7DQo+ID4gCQl9DQo+ID4gCQlp
bm9kZSA9IGhmc3BsdXNfaWdldChzYiwgYmUzMl90b19jcHUoZW50cnkuZm9sZGVyLmlkKSk7DQo+
ID4gCQlpZiAoSVNfRVJSKGlub2RlKSkgew0KPiA+IAkJCWVyciA9IFBUUl9FUlIoaW5vZGUpOw0K
PiA+IAkJCWdvdG8gZmluaXNoX2xvZ2ljOw0KPiA+IAkJfQ0KPiA+IAkJc2JpLT5oaWRkZW5fZGly
ID0gaW5vZGU7DQo+ID4gfQ0KPiA+IA0KPiA+IEkgc2ltcGx5IHNoYXJlZCB0aGUgcmF3IHN1Z2dl
c3Rpb24gYnV0IHlvdSBjYW4gbWFrZSBpdCByaWdodC4NCj4gDQo+IFRoZSBpc3N1ZSB3aXRoIHRo
aXMgdXBkYXRlZCBzbmlwcGV0IGlzIHRoYXQgaXQgc2lsZW50bHkgaWdub3JlcyBmYXRhbCANCj4g
ZXJyb3JzIGZyb20gaGZzX2ZpbmRfaW5pdCgpIGFuZCBoZnNwbHVzX2NhdF9idWlsZF9rZXkoKSAo
ZS5nLiwgLUVOT01FTSkuIA0KPiBJZiB0aGV5IGZhaWwsIHRoZSBtb3VudCBpbmNvcnJlY3RseSBj
b250aW51ZXMuIEluIHRoZSBvcmlnaW5hbCBjb2RlLCANCj4gdGhlc2UgY29ycmVjdGx5IHRyaWdn
ZXIgZ290byBvdXRfcHV0X3Jvb3QuDQo+IA0KPiA+ID4gSW4gY29udHJhc3QsIGZhaWx1cmVzIGZy
b20gaGZzX2ZpbmRfaW5pdCgpIGFuZCBoZnNwbHVzX2NhdF9idWlsZF9rZXkoKSBhcmUgDQo+ID4g
PiBmYXRhbCBhbmQgbXVzdCBhYm9ydCB0aGUgbW91bnQuDQo+ID4gPiANCj4gPiA+IEJ5IHdyYXBw
aW5nIHRoZXNlIGludG8gYSBzaW5nbGUgaGVscGVyIGFuZCByZXR1cm5pbmcgZXJyLCB0aGUgY2Fs
bGVyIGNhbiBubyANCj4gPiA+IGxvbmdlciBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZW0uIEEgbWlz
c2luZyBoaWRkZW4gZGlyZWN0b3J5IHdpbGwgdHJpZ2dlciANCj4gPiA+IGlmIChlcnIpIGdvdG8g
cHJvY2Vzc19lcnJvcjsgaW4gaGZzcGx1c19maWxsX3N1cGVyKCksIG1ha2luZyBpdCBhIGZhdGFs
IA0KPiA+ID4gZXJyb3IuIFRoaXMgd2lsbCBicmVhayBtb3VudGluZyBmb3IgYW55IHZhbGlkIEhG
Uysgdm9sdW1lIHRoYXQgbGFja3MgdGhlIA0KPiA+ID4gcHJpdmF0ZSBkYXRhIGRpcmVjdG9yeS4N
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gU2ltcGx5IG1ha2UgbXkgc3VnZ2VzdGlvbiBiZXR0
ZXIgYW5kIGNvcnJlY3QuIFRoYXQncyBhbGwuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFNsYXZh
Lg0KPiANCj4gVG8gbWFrZSB0aGUgaGVscGVyIGNvbXBsZXRlbHkgY29ycmVjdCwgd2UgZmFjZSBh
bm90aGVyIGlzc3VlOiB0aGUgb3JpZ2luYWwgDQo+IGNvZGUgaWdub3JlcyBhbGwgZXJyb3JzIGZy
b20gaGZzX2JyZWNfcmVhZCgpICh3aGljaCBjYW4gcmV0dXJuIC1FTk9FTlQsIA0KPiAtRUlOVkFM
LCAtRUlPLCBldGMuKSwgdHJlYXRpbmcgdGhlbSBhcyBub24tZmF0YWwuDQo+IA0KPiBJZiB3ZSBj
b21iaW5lIHRoZSBmYXRhbCBzZXR1cCBmdW5jdGlvbnMgYW5kIHRoZSBub24tZmF0YWwgcmVhZCBm
dW5jdGlvbiANCj4gaW50byBvbmUgaGVscGVyLCBpdCBjYW5ub3Qgc2ltcGx5IHJldHVybiBhIHN0
YW5kYXJkIGVycm9yIGNvZGUuIEl0IHdvdWxkIA0KPiBuZWVkIHRvIHJldHVybiB0aHJlZSBkaXN0
aW5jdCBzdGF0ZXM6DQo+IA0KPiAxLiBGYXRhbCBlcnJvciAtPiBjYWxsZXIgbXVzdCBhYm9ydCBt
b3VudC4NCj4gMi4gTm9uLWZhdGFsIHJlYWQgZXJyb3IgLT4gY2FsbGVyIG11c3QgY29udGludWUg
bW91bnQsIGJ1dCBza2lwIGluaXQuDQo+IDMuIFN1Y2Nlc3MgLT4gY2FsbGVyIG11c3QgaW5pdCBo
aWRkZW5fZGlyLg0KPiANCj4gVG8gaGFuZGxlIGFsbCB0aGVzZSBjYXNlcyBwcm9wZXJseSwgdGhl
IGhlbHBlciB3b3VsZCBoYXZlIHRvIGxvb2sgDQo+IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0K
PiAJLyogUmV0dXJucyA8IDAgb24gZmF0YWwgZXJyb3IsIDAgb24gbWlzc2luZy9yZWFkIGVycm9y
LCAxIG9uIHN1Y2Nlc3MgKi8NCj4gCXN0YXRpYyBpbmxpbmUgaW50IGhmc3BsdXNfZ2V0X2hpZGRl
bl9kaXJfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCj4gCQkJCQkJICAgICAgIGhmc3Bs
dXNfY2F0X2VudHJ5ICplbnRyeSkgDQo+IAl7DQo+IAkJc3RydWN0IGhmc19maW5kX2RhdGEgZmQ7
DQo+IAkJaW50IGVycjsNCj4gCQlpbnQgcmV0ID0gMDsNCj4gCQkvKiAuLi4gaW5pdCBzdHIgLi4u
ICovDQo+IA0KPiAJCWVyciA9IGhmc19maW5kX2luaXQoSEZTUExVU19TQihzYiktPmNhdF90cmVl
LCAmZmQpOw0KPiAJCWlmIChlcnIpDQo+IAkJCXJldHVybiBlcnI7IC8qIEZhdGFsLCBmZCBub3Qg
aW5pdGlhbGl6ZWQgKi8NCj4gCQkNCj4gCQllcnIgPSBoZnNwbHVzX2NhdF9idWlsZF9rZXkoc2Is
IGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9DTklELCAmc3RyKTsNCj4gCQlpZiAodW5saWtl
bHkoZXJyIDwgMCkpIHsNCj4gCQkJcmV0ID0gZXJyOw0KPiAJCQlnb3RvIGZyZWVfZmQ7IC8qIEZh
dGFsICovDQo+IAkJfQ0KPiANCj4gCQllcnIgPSBoZnNfYnJlY19yZWFkKCZmZCwgZW50cnksIHNp
emVvZigqZW50cnkpKTsNCj4gCQlpZiAoZXJyKSB7DQo+IAkJCXJldCA9IDA7IC8qIE5vbi1mYXRh
bCwgYnV0IG5vIGVudHJ5IHRvIGluaXQgKi8NCj4gCQkJZ290byBmcmVlX2ZkOw0KPiAJCX0NCj4g
CQkNCj4gCQlyZXQgPSAxOyAvKiBTdWNjZXNzICovDQo+IA0KPiAJZnJlZV9mZDoNCj4gCQloZnNf
ZmluZF9leGl0KCZmZCk7DQo+IAkJcmV0dXJuIHJldDsNCj4gCX0NCj4gDQo+IEFuZCB0aGUgY2Fs
bGVyOg0KPiAJDQo+IAllcnIgPSBoZnNwbHVzX2dldF9oaWRkZW5fZGlyX2VudHJ5KHNiLCAmZW50
cnkpOw0KPiAJaWYgKGVyciA8IDApDQo+IAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+IAlpZiAoZXJy
ID09IDEpIHsNCj4gCQkvKiAuLi4gaW5pdCBoaWRkZW5fZGlyIC4uLiAqLw0KPiAJfQ0KPiANCj4g
V2Ugd291bGQgaGF2ZSB0byBpbnZlbnQgYSBjdXN0b20gcmV0dXJuIHN0YXRlIGNvbnZlbnRpb24g
KDEsIDAsIDwgMCkganVzdCB0byANCj4gaGlkZSBhIHNpbmdsZSBoZnNfZmluZF9leGl0KCkgY2Fs
bC4NCj4gDQo+IEdpdmVuIHRoaXMsIEkgdGhpbmsgdGhlIGN1cnJlbnQgaW5saW5lIGxvZ2ljIGlu
IG15IHBhdGNoIGlzIG11Y2ggY2xlYW5lciANCj4gYW5kIGF2b2lkcyB0aGlzIGNvbnZvbHV0ZWQg
ZXJyb3Igcm91dGluZy4gDQo+IA0KPiBXaGF0IGRvIHlvdSBwcmVmZXI/DQo+IA0KDQpJIGRvbid0
IHF1aXRlIGZvbGxvdyB0byB5b3VyIHRyb3VibGUuIEFueSBmdW5jdGlvbiBjYW4gcmV0dXJuIHZh
cmlvdXMgZXJyb3INCmNvZGVzIGFuZCBjYWxsZXIgY291bGQgcHJvY2VzcyB0aGUgZGlmZmVyZW50
IGVycm9yIGNvZGVzIGJ5IGRpZmZlcmVudCBsb2dpY3M6DQoNCmVyciA9IGhmc3BsdXNfZ2V0X2hp
ZGRlbl9kaXJfZW50cnkoc2IsICZlbnRyeSk7DQppZiAoZXJyID09IC1FTk9FTlQpIHsNCiAgPHBy
b2Nlc3MgLUVOT0VOVD4NCn0gZWxzZSBpZiAoZXJyID09IC1FSU5WQUwpIHsNCiAgPHByb2Nlc3Mg
LUVJTlZBTD4NCn0gZWxzZSBpZiAoZXJyID09IC1FSU8pwqB7DQogIDxwcm9jZXNzIC1FSU8+DQp9
IGVsc2UgaWYgKGVyciA9PSA8c29tZSBvdGhlciBlcnJvcj4pIHsNCiAgPHByb2Nlc3MgdGhpcyBj
YXNlPg0KfQ0KDQpEb2VzIGl0IHNvbHZlIHlvdXIgdHJvdWJsZT8NCg0KVGhhbmtzLA0KU2xhdmEu
DQo=

