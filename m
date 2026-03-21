Return-Path: <stable+bounces-227759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN3SKSJ1vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 220EE2E4CB4
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34695302C6C3
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02123254A5;
	Sat, 21 Mar 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="UyXfdchA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A92749D5;
	Sat, 21 Mar 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089482; cv=fail; b=KV8sbRNph1B0B6WQtIBVvMPp8aIfY2hZw/zNw5n/eUMbaFdq9YS3gSiKrkHpBPSs46R6ogMbZEWJqHdoK/8Zsz2uM4aCa2Ura4dw2I4I91ctqI4P8FLDyeVoT2q2/wrxpBsHffkM2hJqOdF4Ga512GIztHg9Kr3HTImJG41dCJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089482; c=relaxed/simple;
	bh=QacBytNIPQhzDoZ5ULlxplMRw/Pv6BgN/zTJJZ62Q8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyVDW5oVHKWi9KntFsFkqMFsIZk0oGV3hRGugqSJsXcmVLEw/QcghlJRTG4YV9lkwIV6UXv1otjL44VINMqFwlhcie5u8vHvwNbbkKSkkZotgmwAucuzsE8ED+1CnkILoA1n8G0PuPadebl7cI2P48yrsYa9PIsqCtYUKJWR0Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=UyXfdchA; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAKZjB2907964;
	Sat, 21 Mar 2026 10:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=nluQNYdKV/EUApC8Wzz83s/xsiQcyS9SSaUQXKLbiT4=; b=
	UyXfdchAmAm92xjvrifcix7CjhCihE6iECtmZZXIun/LcRrfMMWnN/l84sGspcvo
	xUQUe7vQEB22SJT0bUCcBZ1PWssknII6C6Uqoto+ho1rOfH1X+pMN0QwiKW9+S5C
	AhHR7Qgih+/RlOXJGaUvjGVt/z7WeWVFiiuxyUsY1d9x9JDsOYwki/JnmLg9naB+
	98h7QAvyxeDV5SnBPzX6mG5gvur1QiEFshbWsLTPBHbdbBZoKwNQlNwIHsO5+uBP
	q4SIH++MFJgfjE33uj6fzCvZtfcry7R8cbPLzMWMq+DrlDoKsQQM4N7p6ZJEmNEz
	cRzIusaKMXMMkSbDvs/BbQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj809pr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 10:37:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilwLucbJDSb3fMYz2X81XMQC4irh7UpTLp/o0nSyhzQNk5XKlJwElSct/a7gzCwUT9oLZs+4SePd1Em9IAjLmSDgmYH9lw/RPOSXYwoHsDUpE9WwpIAlerGXu8hPsZoBFcU05koCJrTHWLWSRw5DH7I/GlOpRnlYYVwjYjpqa45OgjEqarKn2Po9wMimOoihH2acAbpNfw9K64+cmPutKP4km15IkAgpvQyOQf9KTxDrtBdEHQvxNHqH3J0xir4g1TXuTvYWz2G4WUPttootPm/Cbd+rn8T96WLH4jI7hle3DtM5tusrwxxW9bOuqJJZzZjrluCTdu+/UJwZD9bQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nluQNYdKV/EUApC8Wzz83s/xsiQcyS9SSaUQXKLbiT4=;
 b=eLO+9kAAqpKNDwN3aVahqqJpMH984Oo0fMERi0K5tZpkxQu6mm/wvLcIDAIbZBRTpvpRLtvnI+mqf4iEWWpb0jCRVWGvyfEskQ8Cpb0Sh74ZRNGd2lzpu0HCg0eA2SstkO0R892C7DKFilAlGqDmcVdCflClth+sGEpqD0IJsXMV3CdgVPAWdl0dV9+XlltJIKqsrCtr6bl5BvCl5TaqXGkIWY3OY25hV560wwwBqSMmaNufr+T+nigWeQ2mdZ4PL17RIo0v2kcghG8L2p+dCbiVcasDWSB1IG8TepsonRLASH4ZV4Fj/E3KJg4omsXdrsTqGtQXLo4992zCq6Tj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:48 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 4/6] cpuidle: menu: Eliminate outliers on both ends of the sample set
Date: Sat, 21 Mar 2026 12:37:19 +0200
Message-ID: <20260321103721.35114-5-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321103721.35114-1-ionut.nechita@windriver.com>
References: <20260321103721.35114-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 3088a42e-73d5-488b-bd23-08de8735e4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XKUmW/PpdEDm8pU/z43IwSNrzkn3IZTRRIPQYIjjbY/zFi9HKvGdXbUr35NHAlvEW902AMhRr+JPIWw6FxkYLyBitBvvUdZVtosMrccysNX0FJZaQkqUIfjzDKpgb9C+N48+it1XVwkd+qyaHcQyr8ABQxWizKFzbOEsBcirPAITOf/xiAi/pxH2kAEOmzIXZv1lWfNtsiukwJp6RSW3n4+fVxobD7/wzpNjRZsBbyutOUUhcKz82gVYOCHbSc0uMIjyqO7FlLWlbJiUab292g1FafVKaK488WhIjBS49WRNnKPpGrxKO3fcWOy3H7YTFkwC0cMhRXrKQbDVzMesZpSfWoi0YJKpuV5yEqhYeH0TA8pfXdeqv1D7xYvJP+YUgwycpqGyzzdjHVT9eUQHS90IJxY9MCxp80vnTPCYbg7+xwHNv+wwDlNz7TQL14FlbVXq0N9CCIZ6/JlXwACPAfXLKHMwY2jVXpQNYLaAOsj6A4CEc8G8ePO37D9XxEprIyB5hA+pmrWDByhsthrx9DHDS5QAlOMnlGz2LrNvObH2/Q6djSCxxvcIqgRdMq1mRKKQ1N3DajWiC9JWL9z1BnU/0aw4fHnK9brZwnFWPfDg/cbmmJ67g8OoUoeiyjXpckOju9ME/6m5jqPHXR6t9laMnKXErk3aCLHXjFmK0dWIKOoV6r/gNNhxnYMLoNNT2UYYOd/8A4d6zFw4YaXbyPUxPJi/QYrhkuktkSooFaMTFCGaEPGoluFgpqlpTMPY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wIi3tO8kejeSzLZTt9WySjaBlQtF+d+rkt6MtcMuBSRsXnvefriter0VVztl?=
 =?us-ascii?Q?cTmMirl4gAljQMGDvuWrtXSjNX0WlbrdjAw0gfkeeBw0SwwrdDe32/XWogZ1?=
 =?us-ascii?Q?HHb5yx5K16pMx/H17Ym9Ul7fKpr08ane0ym+g7U+mDjIXt/8zCtBIxjm4fm7?=
 =?us-ascii?Q?XsTsGH9lpKv2D15gnc5vbNUfKRnGDXWIF7wRpKeiYJxpUwiiSY8zu//ccsh0?=
 =?us-ascii?Q?nMWZeBLEG07QITm1epE1whOvKEMYzpNkHZEn0bIQ6jLQgITUrdomGl5sErkZ?=
 =?us-ascii?Q?sGwpfiDHcViFuNoeIj0bEW6LnNbbQcxOxO9GEnjFBMvgAaVxwfI7MNsAQDHz?=
 =?us-ascii?Q?c4f7dlLnPwqujwCDZgbg0xvUICvHN1KLw2TfK1ivNWQPyLdo/9Kn6dYobQE+?=
 =?us-ascii?Q?devQ2f0by3bB69NJppH0szbYFJzrAviSIMzg1TI1FJrUOHT+RJ1ovVlPxR4K?=
 =?us-ascii?Q?XXtuWlxvTmd9HkRuBft0gyMRkiM/mO9pgdvv0aa92f3vtlQCuq1hLucH2ZxT?=
 =?us-ascii?Q?Cabs38PvrCQXJSkI1FsBAXeUQl16Etf1caeIer7bFFz1fVYdaObZuveJO+l1?=
 =?us-ascii?Q?EC95a3EkFLDeZ4CgSpac10AXjElsGZCIt7FKRH0V5jx6MYI4SuC8C2bClRi+?=
 =?us-ascii?Q?pBmvoF2ooTJoqXnjW3+dPGZIHOMR9jsLjpCxfJ161inkkJ3hH/HpdmXxzLQ4?=
 =?us-ascii?Q?phCdfmfrIh0XkG51MF4icMU/o4sr3VcAb+Cctxa72yxHNz/3JyqaTEPAMa3D?=
 =?us-ascii?Q?e+u1NZDnfeQuF/h0srvfps4A1tMQQBM6nd5wotLWt8hUMOtUy8Ubq3nhFOHy?=
 =?us-ascii?Q?hRpe1TFGFXM5iINm1D0LVNQz93DX1BHO3tymzI+B0wf+bfoaRSoVktwVQnXw?=
 =?us-ascii?Q?FSLDc0lou8FeTbBgpjFKrtnYUfVgdVI9/ZCUH3+A+srVFZH7RGo+6xKzTPWE?=
 =?us-ascii?Q?W6TK/S2j4Kwy5193NxqKc0OFL2Aw1hBEF60Y3GMfDyJ3OtnwIIl5S6E5Wrny?=
 =?us-ascii?Q?HKJ30pFGZ6R3DamFncuSX+jvtvAD4CBM/3GaWoMxuKGOAoDHIptV5hasLDYn?=
 =?us-ascii?Q?Y8jbZR4xCkrEevNIPt5NVhEo51pFOi6H9CQEY5RLxUHRmqDHof3FkGb6rMEF?=
 =?us-ascii?Q?35hGYfCAwl6f37bjPvLoTQlaQ6EqhrAF4kpBMTTYnTPFR14eNezRf7FND6xR?=
 =?us-ascii?Q?SQPAsKY2gEa9d+z0/Nxjy0a8lEZ4uatYPz2KS9qLfeD5nH54QpRiSxbYxFtT?=
 =?us-ascii?Q?zCBis31+6yWAJMs1MVQxTCv9fBvAYhQmmjj/eobl6pZDWiQ1e1n2iR1vj/u1?=
 =?us-ascii?Q?KfrK2mUCEaWFlLEVJOK0R4QKkynA0w0ssSJuKM+8jDFAjE58Ij/QZrFBCUvl?=
 =?us-ascii?Q?g+KWaxs4LP4aBgukwvNWsgyBdJUXgec1WwmDODJ9EZRvgCmBw+NeI40RGlhQ?=
 =?us-ascii?Q?+CB7B0mBrPPPAHtGc9m8LXmHXiEtGmV4OYpxqBOeOkUmeGjovpLKBDoZb3vy?=
 =?us-ascii?Q?aykMdnsvwuIfRVBAFdebNZnsW2vgeSCJmsp7ul6PQz/mH/56HOBJ0uR0kghV?=
 =?us-ascii?Q?f1ebRGw7wR4kxdBorOVMaML8rD3fKoC/ex8vdAflOgwgGUQ3xf68Ym7E98Fq?=
 =?us-ascii?Q?GDfcqMt1E6CIxaXG+yGnh2Tx08d+v19IgZxRhCdijyHk9RmCw0ZCpo5t+0KS?=
 =?us-ascii?Q?6kdLbcxdapfRNxnPGkz9YZCeTm/tC7qAFHjN1pqeDMFunHwfu3LDRZbvYjHy?=
 =?us-ascii?Q?2jsX29IlXRmdZjIa6JcisoDBkbq+eY0=3D?=
X-Exchange-RoutingPolicyChecked:
	YPBkydPc+qN8ch97Fb2Y0kPJNDIYzN8gRITmhfYGy9K/JsiuVSoxX8eZ6rFc56lmzFv2TKncywaTtTIFVuAqJ+Yz7Qv1J4JJMJDO8HxHvJFpAksZFtSOB9PKHtrNTAfgb2jEuuWVj7bszIbziSREKcfRmtvDHTq9GeJW4w6hdC3nI2eFj40pzx1PUwFlKFTyPUWk3RXyDg9wW8YWHaV/SzIUw1pKPrGEhckVI8/fD3gl8oN3NmUCmW64EKGZ6F20oR8aFCDcVkKKTKsHcw0ruIvqbyLsZKGMEKqPxvlxD8ZczD0j/ic0o0sw5WDdNfrdslcR9nXzoOGgT7Ysz7x0cA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3088a42e-73d5-488b-bd23-08de8735e4c7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:47.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+sfoWUTncXZQp8A3FGPMWLeOfQ9EcZrQFCVys7hNuqaTSn+wgKWheWvpwV6Z5klSnidZ8Z7yA8zuBXe6Bsg3lyDf+C3GX6GoJaPmUwOE7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-ORIG-GUID: k-8wY1AgPeWktw-bXIIDpfKskA5vGsB2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfX4tQQa41Agfx6
 H9SDMjMG6qLCrx7IORE0LXVXlEOj7UmiBTsupmeWHKQ1Q3iXcnp1QJpZo8tK9rnL3mjNb8VPhjN
 dOU+SdxC8iahYgX0+fT9gMxXkNCese18XqC6S0F4oHNfIy9fEfwdLcBCX5pBq7OHLKnzGbeIfZr
 sRRPCWgQA8GQ9p424iL67NB/ayNoIRJz4ZTKZ6hHx/DvimA9UlsBofTFofEvllEkzAflCih4+1z
 ARPFoBgV/cCWI25JnI0ba440qaiKrXHX8lLqVc4CSeSuqXoi2jaRK0zBwdaopgdpwtUdNY8aYZu
 teJliVtYoCde6/+mzSr0ntOf2wVYS2pM4mEkNTqUeQj6d6gcpvPUSKiqp6aXjI7eHqFTU5FDA5S
 dDJkKxF2xxQrb5yyRLrD5RPnTEDckJe9jw37tqP7m4LMNDjBjF2nAxhjT2sibF4h3y5xS5yKJeZ
 XOOlnnGi2V/89buB3wA==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69be74fd cx=c_pps
 a=UPJ12yLMGL5ZZCNrBMA7tw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
 a=VnNF1IyMAAAA:8 a=dN5uq0mwV8BBApe8OCwA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=XN2wCei03jY4uMu7D0Wg:22 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: k-8wY1AgPeWktw-bXIIDpfKskA5vGsB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227759-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 220EE2E4CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 8de7606f0fe2bf5a918fe97d425e16e190a24fe6 upstream.

Currently, get_typical_interval() attempts to eliminate outliers at the
high end of the sample set only (probably in order to bias the prediction
toward lower values), but this it problematic because if the outliers are
present at the low end of the sample set, discarding the highest values
will not help to reduce the variance.

Since the presence of outliers at the low end of the sample set is
generally as likely as their presence at the high end of the sample
set, modify get_typical_interval() to treat samples at the largest
distances from the average (on both ends of the sample set) as outliers.

This should increase the likelihood of making a meaningful prediction
in some cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/2301940.iZASKD2KPV@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 96bee77b8354f..8ab5123c81040 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,30 +124,37 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	unsigned int max, divisor, thresh = UINT_MAX;
+	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
+	unsigned int max, min, divisor;
 	u64 avg, variance, avg_sq;
 	int i;
 
 again:
 	/* Compute the average and variance of past intervals. */
 	max = 0;
+	min = UINT_MAX;
 	avg = 0;
 	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
-		unsigned int value = data->intervals[i];
-
-		/* Discard data points above or at the threshold. */
-		if (value >= thresh)
+		value = data->intervals[i];
+		/*
+		 * Discard the samples outside the interval between the min and
+		 * max thresholds.
+		 */
+		if (value <= min_thresh || value >= max_thresh)
 			continue;
 
 		divisor++;
 
 		avg += value;
-		variance += (u64)value * value;
+		variance += value * value;
 
 		if (value > max)
 			max = value;
+
+		if (value < min)
+			min = value;
 	}
 
 	if (!max)
@@ -183,10 +190,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	}
 
 	/*
-	 * If we have outliers to the upside in our distribution, discard
-	 * those by setting the threshold to exclude these outliers, then
+	 * If there are outliers, discard them by setting thresholds to exclude
+	 * data points at a large enough distance from the average, then
 	 * calculate the average and standard deviation again. Once we get
-	 * down to the bottom 3/4 of our samples, stop excluding samples.
+	 * down to the last 3/4 of our samples, stop excluding samples.
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
@@ -202,7 +209,12 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
 
-	thresh = max;
+	/* Update the thresholds for the next round. */
+	if (avg - min > max - avg)
+		min_thresh = min;
+	else
+		max_thresh = max;
+
 	goto again;
 }
 
-- 
2.53.0


