Return-Path: <stable+bounces-94046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBD9D29EE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500F5B2A956
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560B1CF2B2;
	Tue, 19 Nov 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PcCjSG5a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b2/V+F9V"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D371CD207
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030306; cv=fail; b=oj3iCuQvLSwn2BZbpKLD0d6afO1VR4sni8Tjc2s6XvRPpGvtusuRusMoqbBW38D/ITM/ADGbXlPvuJRf51fBGh8HA4cIRChv+xHYDTi8/8fs7z2RJLP/0JJrzU/g1FOKF5anb7mr/EpwYJsNoj7j2R0k7cJcLhB9D2mGhZuA77I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030306; c=relaxed/simple;
	bh=ARcO5+02bpiqq0tbLR3W1QMMUX83LUJBVQ5K2xOXonE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OFAGr9yl187yN/M9SWz49l3bolBhzsuUaATofGs0vFu94IGnvY84zlXE0gRBJ7TR+Ch84pjT73oni9uctoFd7AWdOBIU1nQ1Jf1E/lQ7UakCuPWDTxi3Kt3a4LzNu+o4pOxh6yfUzF20oechXLsfEDs9NKVWnhdmN/avHSFGkcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PcCjSG5a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b2/V+F9V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFP0XX013242;
	Tue, 19 Nov 2024 15:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ARcO5+02bpiqq0tbLR3W1QMMUX83LUJBVQ5K2xOXonE=; b=
	PcCjSG5acDt+GTiNQXt5uMmy/mfrDYPbJR4oFSkSeJqV+RChTYodotAsKxJU4oWI
	X/5Yf/hmQFVRN4fmsaLv45nDEbjhIbEyiWpYZ4iP4s8cxjl3qNn57yJgjYJQlabc
	t9gJHhAcC4RB+WQyoFQXlyFO5wxs4MuKgiHEGWAQA5JOBteedlM7FtM5sYJ1+o59
	UOdZX8rablthwWw+mOzdgpebbc+in5+fWatIasCdHOKTggDTjlCs9J8ExgkMu4Lp
	Icc+Rr6QvrJF/kCuBu3Dzixg1XB9EWPTY7d7cQbaucOTShcvzh8Y2kGgZHL4EQMP
	VkQl5FNu1jBCjTgy6PdrGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98n42r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:31:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJEirCf023137;
	Tue, 19 Nov 2024 15:31:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu93eya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCj5XWDhMQ4HyMxdynWBC0c8H2ITGSUGy4ZP6aMTjkE/5w+iSs07QZsZ19hy0uqJ0JVdRi0rGli/VJ6tnSCZHYLDhrLE2aMw1+RVDkFvcBhKXkJGdaIwrSajfJuaTefGjO+JD4dYUqA80fdnb1HJVoI35fAks1bYcLt1N4LsTy+9gEsanCHpxDQFp09ANCsG5kIvSxkFwYg07BHGzyHNREg/lEJRG8rtcOA/gtlQNrJuCAypA18Icqbm1VC0EdRulX+zDx4QvwzZrl3KBUeorwr0wwTGioPxWmJ/VMltT0IZUq8OGXqStbFcE5XfwLLE0lL6BVMFzH+tiB/m2EegUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARcO5+02bpiqq0tbLR3W1QMMUX83LUJBVQ5K2xOXonE=;
 b=Dvv1zEnnHQwg3eqJMfmmn0XXqIUKLDuuhYbZ4nC7XdbFJCGc0thE1T9W44l0egdAQjWeolZrJvssePITt/Ialdje8+G/YSZyVfkndvwRYES9dFlJyQpGYKDiAt3U+OsjMzqOzJVp7l4gSj3+0p5zjBlKu/4rmuERTlkfuIFH+JnZsn26MW+2iHaiX0H/lfdpN8JtG837OEtPBG+WFeROnLWZ0GXjPyCGqlCsyUTKorpbMJ9KGBTzrOylZMrdubXXJOYFxQktTGE2BIHUs08xqRFk2GvlTusITZO+VJVolx9XPplwe7exVACY7qocO1Pg85fuMXsSVZDNOZe1pcUjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARcO5+02bpiqq0tbLR3W1QMMUX83LUJBVQ5K2xOXonE=;
 b=b2/V+F9Vb8UC3iOwVoR3sM7PYJVC2kjZWRE49fYX6J5DVyZEdlM4dyIz6+PcYCIrVtgSyqH0luAHggt/QSiLQqZFaBl7mge5kNJiCM3858Mb5FXt/QtAGN1P73WHdB0YZW7ERQj5+rhxdB3FxJA47iFgFb2clfugjuALFHU5+Rw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 15:31:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 15:31:37 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sasha Levin <sashal@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
        linux-stable
	<stable@vger.kernel.org>, Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy
 for use by trace point
Thread-Topic: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in
 nfsd4_copy for use by trace point
Thread-Index: AQHbOf+IlAYjis8IdE6C07MPvqlh8LK+UKmAgABV24CAABVTAIAAAFmA
Date: Tue, 19 Nov 2024 15:31:37 +0000
Message-ID: <07D207C8-07E1-4D7E-B427-18811BFDD9E7@oracle.com>
References: <20241118211900.3808-2-cel@kernel.org>
 <20241118211900.3808-2-cel@kernel.org>
 <ZzybZplCfSkWKsyi@tissot.1015granger.net>
 <2024111915-annually-semisoft-c5d6@gregkh> <ZzyvAnV1p00w5f2_@sashalap>
In-Reply-To: <ZzyvAnV1p00w5f2_@sashalap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4298:EE_
x-ms-office365-filtering-correlation-id: 46162859-bb56-43df-99a7-08dd08af41aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0diRlVrTXRPTmdLcEQyNGppRHVXZThPdnovZmJDdzZOL3V4bzFLc3YrbVUw?=
 =?utf-8?B?MzNGdHBsZWdTREZIOE5TUTFIOFY5c0pNMHc2U0ZHWkhaMlFZdWsxUCtoQTFu?=
 =?utf-8?B?bEVvQzgxSHpBNUVhQzZUOFM0bktHQjBBdnV1SHhveG9sSVJ0RkpnejhYeFB1?=
 =?utf-8?B?SzRBZ2VuVlJNRlZSUEdYZTZyOEl1c2Z2UWJFNlJnclZUTjFRdTRFcHIwQklC?=
 =?utf-8?B?UlUzYVo3ZVBUcXpDOHVuakljTHloRzMxWVoxakJXUjVJa0Y2WEYxa0UxL2dW?=
 =?utf-8?B?b043d09EM2tIZHVZZUdZdmR4TXJRVVVBRy9Nek5DM0ZBRzNiTVBla1FHTVVi?=
 =?utf-8?B?U0EzRG1UWVRhYTN6eDNwTStoMFFDd2k2QmZCc091bWJTb2pvbjdiM01Ea1pX?=
 =?utf-8?B?MWwxeDRxMlVtZ0dCS2RGdkVUUk92VzRRZFV2a2REVVdNK3hibldJR3lVTmVF?=
 =?utf-8?B?VkdDZ0lwZ21Ob3RqZkJ0RW9BaWFCK3hjV2pIV0MxME43THI0ZGYzVXJhcUJr?=
 =?utf-8?B?enliV0d3eG15ZHNsMnpqNFlGVnl1WmFpVUFzekZ5UFZMQVBXb2I1b1Z0bzRF?=
 =?utf-8?B?V0FwYWpEcGNxMHZuaUNCd0JBb1Z5MG90UTZwM1RnUmNOQ1c4b3ZxdmVrSGR0?=
 =?utf-8?B?K05ZZmRiZjNjc1pzOG9jZ09Jd0J0SVVEcEk2U25xbFBoNGF6aWtwcFh2V2tw?=
 =?utf-8?B?d1dlWk9sQ3psMkNZL2tNVGVINFlNQ1pWSXVoY3Z3d202RDNHTE11K25Cejhp?=
 =?utf-8?B?ZWVFUVJVaDM2UjdBOWxUeTNrZ0lXTTRldW9QYTE0QlJDR2RlUExhSllmeGp0?=
 =?utf-8?B?Uk1HMTk5ZndRTVA1SmoxbHIvZGdkT00rYlBGVTZ5U2c0VUJ2SHhUelJFaEgy?=
 =?utf-8?B?elpodFBadit6K3pmRSt5dFFPZmp5SGRqY1BCc096aUlUNE9TRGZ3ckM1QkxH?=
 =?utf-8?B?N1EzbUNwVkkyQ0JjRnNLWDdEM09RMlEyTzZiNjdtZFdmV3JpVWZwRUNsMFB2?=
 =?utf-8?B?bHAvbEVOS1VpRFpYYjkxRUtvR3V3SU1BZlZkeDlzclhuQ3hZSnZSdmo4VDBK?=
 =?utf-8?B?Y0dpZTIwNkgyaEtuNENLSHhpaGhySWVWM0hIWnJ0U0F2L3BvdlVjZFF0VVhB?=
 =?utf-8?B?UE5ocS9LVkdYU0MyNCszK21FazZFMUtUU3draDVUQmhRUzhmQjl4OTBvZ3FQ?=
 =?utf-8?B?NURhUzU2NnJ4cVdYQk0rSS91YWtleUZ5Z2ppU24vQWRaMjRkamxSOER1bGZP?=
 =?utf-8?B?cCt4TnRxVERWVmlpdEhObFlVV1dFQnU3TjVsY2g2UFVyanFYQlFNUzNtTjlU?=
 =?utf-8?B?eFpaZkZqZDJlTS9MbFdQUmVTeXlCbTlZQ25NcmRmTXp2LzVnVi8rZWtlRXVT?=
 =?utf-8?B?Q0Z5cGl5SGxjQWFNcDc1VXBuOHNrYW85M3EwazFBa3lsNVlGRmg1TzVQanJI?=
 =?utf-8?B?dVpoTXhDT0FMUzlWc2lhVjlIOE1YVnlOM3RoZmlBVCtzYjlVWHJwMGt2azNI?=
 =?utf-8?B?SHJqckl2YUdvY0VkczUwUFVrVStGN3JGN21TeStzWlRhdEJkQUxvSDJPTmc5?=
 =?utf-8?B?dXl0ZXFMWkVvRFdTUURpTHFNb01va2dEZUsvUjlpeEVyclZ6NVZnR2lXclpD?=
 =?utf-8?B?UTkyM0pGTURTRUhtQUNrbnlINURWL1k1aUEzd2l6L1h1NVZhNUdidTUxQm94?=
 =?utf-8?B?S0p3am1qY1ZPTkx0a1dUZy9FZURtbE9IbU5hUXZjSDdYZlVtV2dzaW9nNVQw?=
 =?utf-8?B?T09Ednl2RFBXd3FlYml4SDhrRHFFSEovem1rdE93QmNpMVFwQnRDZlk4VzFQ?=
 =?utf-8?Q?pLM6YNxFh8rK/HcQ4k8RXpnrZIsUQnqOx9ErU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZlZzY3T1d0cE9GdzlrUGJUTFU5akVycTZKS1dEc0xuVkgwVFEvV1piRHc2?=
 =?utf-8?B?SE9IUDhCQ0l6bnpObzRFTCtrRWpubW05ZnI1QkJwOGZvSEkxWVBwYXgzczNt?=
 =?utf-8?B?SllPd1AyaThONzdERzBsVnhiRTkxL1gzb056Umt1dGR3TkVrUFo1cTRycU16?=
 =?utf-8?B?a25hNlZXMlp5MjFZTE56SmhzRkRndlcrTmllNjFuVVkraGU5aEtVajY2dXFZ?=
 =?utf-8?B?QmlVNS9wUUkrSW9ZM01jV2M4dUpXdXduQlRRMmdUeUlFbXJFZDR6bGx2RklM?=
 =?utf-8?B?Wjh5aWFaaEdNazhTYjlHNDRsRUcxM1JoSThNdXYzQS83enc5UERXQ1AwaExD?=
 =?utf-8?B?UVhSWGdNN2JDMW9GRE5tendvRlpZbHJXVDYvMWlhM3VOZmt5L2hpWU5RQW5r?=
 =?utf-8?B?akJWWWQ0Ry9qb2RDdlhzWWdRL28vWVd2RFNpaEo3aGM2cVZOdlorY3B6YnhP?=
 =?utf-8?B?SUsyUzNpeFlxd1hUVGk4eGlCSk1uaDRGQjhGM0tDSDdYamdubzhaYXVPR1Q5?=
 =?utf-8?B?aEc0c2lTanFUQXNudThzcjRBbXRzT3hjMWUvUHJ4MW9XOUVlQ3dDOFc3TExv?=
 =?utf-8?B?U2V6VUovNGJGWnI4NGw5eXpTUW5RN09pV1V4dkZNakIzR3FjR0JQbXZ1SDFC?=
 =?utf-8?B?dFhZK3loSXYybGlRT21GWUhZUnZMVXI3ZVErTjExSWlzVXlQd0FEeGd5NHll?=
 =?utf-8?B?NEx3VE5aeTZRVVozdHNqWTM4eWMxSHUraTNUUDVDaHJBKzFTRy9ncWQ1dlli?=
 =?utf-8?B?bkZicFBKQmlFaVpOODMvYnM2QzZsbHgzM2k2RURLK0JKTGZudy9iM3N6a001?=
 =?utf-8?B?azUyZVhTdWdQQ1pQcXh4K0ZjN2U2Vkk3amRqU3NYUm5UUnBSVDNVWXFraCs2?=
 =?utf-8?B?U0p2QTVoeVg4Y1k1Rm5DNDZNZ1Irb2tXQjF0RmpFTEZrbmdROHR0dnpBTCtz?=
 =?utf-8?B?RGdjNEdUVk82SEdsZnJJL3FpcGRBa1FUREs3SUhXeVoyZHgyK2RPY2htSTVs?=
 =?utf-8?B?bk1IYUN4OG1WZTE1aTlENzhVL1F3SGJyVVZIek9rRTNxU09BWHJUZmhqald2?=
 =?utf-8?B?VFM1S3YyK2xmMDNLcG1yOWlUU3hOYUg3aGUwOUZkcUlzUktJRWViaGFBZm84?=
 =?utf-8?B?VSt1MmJUU3kxUFAwNlZwQ1M0Z3ZPUnBtakZjNVNBL0ZuUkRrK2g0M2VueWJN?=
 =?utf-8?B?WnpRNlBFLzYyRkg1OElXdklyZExoUzgzNWdROFUxYUVOQ3F3Z0FHUVVUMWow?=
 =?utf-8?B?UnREaEdXWG45T01ndmZQSHJoWE93ZUhlaTlQM0ZsOWlPdG9WL3g2YXUwY0h2?=
 =?utf-8?B?YUJFMjRMQ2luaEs0S2tvNkZHejg0L0FreVU2NklwczVDWUhqU292MDJjKzZ2?=
 =?utf-8?B?SHVPbXBYTmJ2TFRoWm9relBzZU5tYUY3WUsva3dKeXZwQ3lJT2lFRGVwWmVu?=
 =?utf-8?B?em0rd1FQMWJiOEEyM3hDcTJiemNLc09yUXgvTmwrR2Z0OGdsN3NETzBaWUdt?=
 =?utf-8?B?QTZSSC9iZVZHMnpZWDhGNGQ5Q0lsakl4MFNhTmJIQ1R4TmlMb2tOTm1WWHo4?=
 =?utf-8?B?Y3UrMkZKUFc4Y1h6bFhFUFFSNFU3ZExqYm5JOFgzOXRrY1JkM1I4a2o3Vy9L?=
 =?utf-8?B?R0ZkV1ZJSjY3SFlzWVVyeVBYQm1MTG1YWEpOK1hzSStLd2pNbXRzYzRja2JZ?=
 =?utf-8?B?VlpjZ3NtN1JiSHV0enptM01reFA1eEpCSjVPUjFBUlVLZjBOTGpmTW9tT0pF?=
 =?utf-8?B?Z0hRQUYxWk9ib2hpbEZReStHbU5tYjg2dHYzQUNYdm5yd0phSzZrZ2RrTnMw?=
 =?utf-8?B?eFV3dEFYaDFPR0pVN2taOVVkM0w4VzYyZTA5TFZrZU1uQUNCRDEwa1ZTeUxQ?=
 =?utf-8?B?S1B5NlU2Z1hyc1gxMnZiMHI0ZXFDQ2pVNFNleDVjckVzMXJHcVBRTE1uamFN?=
 =?utf-8?B?bHZQM3ZqMmVEbHZmQTRsNG9rQWxqL0VzL3h1ckhqZ09GRFhjTFZpODBLcHNI?=
 =?utf-8?B?OTd2L1l2N0cxaFUzdlBhdnoyNHBuRWZqVHlNMW5DcUlMcGdGWjZITHJ4VHNL?=
 =?utf-8?B?cGxtNHk0S0Z0SlV4dWh2UTJwU3hMeG5IU2dZdGY5NzN2VWdYTDRYeTI1ZWRn?=
 =?utf-8?B?d3pqK0RQYU54RnR1Zmx4blhXMDV6SGx5Vmx3dENmTFZ2S21WcmJLaFhGM2NQ?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1903DD8C01B9144383E638F16AADFBAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LSUcQZwKr7ln2j6jKbYRytBVygv03AW2ZaAWLNZto9CJNEK6LXzHoY5R0asI4paElrWkumOLqKXSl2RNxHLLxjOsAhJqPE30SUQqqDRhabiNuddAGQTLCIvq7F4JU09Fn+LO6Egjm3hWiqqodeCjV2fBjJ1+RGM78vPTUO9SVjTRwumeqz+xvvVnrV4fUqyrUWTTOSofV6S/qmZZmUTiyFg3DlToehSw2eiXmTmGKTjXkeIr1k2Jc+D3W8dlTRgPRrnU4iZ4t+R4Im5kkjXgqjJtibuIHqu/JUGhQ0nJNWJB5aGu6OSlz6RF9bTabFhjA2w1eSAWQKYr/KKYI9Bsls0DGhNY5i49GbkOS2F/KggQPVyBtKd439tsCUelNQDcuSpk3jQ3zVEhJLDEroQnT/KW6hcobpJ2cbRvh0mk7pokuLfwD56Twi77WR5dmGGvX2iA7Flnd8l49w8FGtzGbBz0GyHkQdMu/7cpVBQ1T1ILCrWgSYQs3pmhJO+cWsEP3IKxttORVwOKBIzERUwS+qb0qXLpMFgqsURHXME827KduTKMq/thttOUu1o+12TcxnmwhUgQL3UBMvJNsXNctO9+COUwjPaQGJkZO23snmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46162859-bb56-43df-99a7-08dd08af41aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 15:31:37.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K294HxzaGghenrbS8YzPRkXF3ipk85Jcxbw/uTy/8yyKqoasndiXKPRCCRKQdhOVFjy58TL3gSilZhO/mQOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_07,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190114
X-Proofpoint-ORIG-GUID: owd1N4cYD5ZnSL4x21tRGuVFrIwemnG-
X-Proofpoint-GUID: owd1N4cYD5ZnSL4x21tRGuVFrIwemnG-

DQoNCj4gT24gTm92IDE5LCAyMDI0LCBhdCAxMDozMOKAr0FNLCBTYXNoYSBMZXZpbiA8c2FzaGFs
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMDM6MTM6
NTFQTSArMDEwMCwgR3JlZyBLSCB3cm90ZToNCj4+IE9uIFR1ZSwgTm92IDE5LCAyMDI0IGF0IDA5
OjA2OjMwQU0gLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4+IE9uIE1vbiwgTm92IDE4LCAy
MDI0IGF0IDExOjM2OjE1UE0gLTA1MDAsIFNhc2hhIExldmluIHdyb3RlOg0KPj4+ID4gWyBTYXNo
YSdzIGJhY2twb3J0IGhlbHBlciBib3QgXQ0KPj4+ID4NCj4+PiA+IEhpLA0KPj4+ID4NCj4+PiA+
IFRoZSB1cHN0cmVhbSBjb21taXQgU0hBMSBwcm92aWRlZCBpcyBjb3JyZWN0OiAxNWQxOTc1Yjcy
Nzk2OTNkNmYwOTM5OGUwZTJlMzFhY2EyMzEwMjc1DQo+Pj4gPg0KPj4+ID4gV0FSTklORzogQXV0
aG9yIG1pc21hdGNoIGJldHdlZW4gcGF0Y2ggYW5kIHVwc3RyZWFtIGNvbW1pdDoNCj4+PiA+IEJh
Y2twb3J0IGF1dGhvcjogY2VsQGtlcm5lbC5vcmcNCj4+PiA+IENvbW1pdCBhdXRob3I6IERhaSBO
Z28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4+PiANCj4+PiBJcyB0aGlzIGEgYnVnIGluIG15IGJh
Y2twb3J0IHNjcmlwdD8gU2hvdWxkIHBhdGNoZXMgYmFja3BvcnRlZA0KPj4+IHRvIExUUyByZXRh
aW4gdGhlIHVwc3RyZWFtIHBhdGNoIGF1dGhvciwgb3Igc2hvdWxkIHRoZXkgYmUgRnJvbToNCj4+
PiB0aGUgYmFja3BvcnRlcj8gSWYgdGhlIGZvcm1lciwgSSBjYW4gYWRqdXN0IG15IHNjcmlwdHMu
DQo+PiANCj4+IE5vLCB0aGlzIGlzIGNvcnJlY3QsIEkgdGhpbmsgU2FzaGEncyBzY3JpcHRzIGFy
ZSBhIGJpdCB0b28gc2Vuc2l0aXZlDQo+PiBoZXJlIGFuZCBpbiBhIGZldyBvdGhlciBwbGFjZXMu
DQo+IA0KPiBSaWdodCwgc29ycnkgLSB0aGlzIGlzIG1vcmUgb2YgYW4gaW5kaWNhdG9yIGZvciBt
ZSB0byBzYXkgInRoaXMgcGF0Y2gNCj4gd2FzIGJhY2twb3J0ZWQgYnkgc29tZW9uZSB3aG8ncyBu
b3QgdGhlIGF1dGhvciwgcmV2aWV3IGl0IG1vcmUNCj4gY2FyZWZ1bGx5Ii4NCg0KR290IGl0LiBT
b3JyeSBmb3IgdGhlIG5vaXNlIQ0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

