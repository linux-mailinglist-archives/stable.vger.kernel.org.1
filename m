Return-Path: <stable+bounces-227871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGCYEmSIwGlfIgQAu9opvQ
	(envelope-from <stable+bounces-227871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:25:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D503A2EB40C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47077300901C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382EF18FC80;
	Mon, 23 Mar 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Yk8Fh4we"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71017DE36;
	Mon, 23 Mar 2026 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225494; cv=fail; b=A7vnQWZVCx2bt8mMNjX/vX/GawJW56yAAIdaEJSeItMYdndVZCj5TPfG2L8nS4o1B4xjyEtLoOmltXthu1st5UaRmNpnahdOFG8302k+4SZCAm5tybvXdTqZKqF6CBOdv4L9kmKndF2AOA2rna6y51BrIWscuFaF68Zx2PMzHPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225494; c=relaxed/simple;
	bh=POP6oYXGED6TtQ24Z8ytP/gMMD096C+87bXGHWUwTWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FcHzz6o7GmDNvp8BWM5Z5fDzc1HxPdJWbb6vCV80D4NUKs6ztdV5uMYms8mzQlPEQ/n5QcN51PpNAb8zVdpiAUadwLiEniCtIHYKf4P2aE1JeTuUs2kFoS2PX1tJdWP103o8vHka6Ew+EAXyxLKVXPJir/rGzWjhPu8/INskugw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Yk8Fh4we; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNXMsB833453;
	Mon, 23 Mar 2026 00:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=8i
	cBZGLc7dvKKEflOULmHxFAiIIV1U/XjuoJ9Y1Gbr4=; b=Yk8Fh4wejfCHW9MbkS
	4uYk2Clcaw5Icra4H7MBsbfpU+wyakci11iBjEgKoCRZUEidyukWxC0ImbUoBhOD
	wpNOKx8ySA191ANeA+ZKLTY6+XDj7Ef+mRPTR1c6q4emx9Wz3LuM9H3G8vHpOkyL
	HjmXzrr9slR7HUTyl6lkICwv25RHhZurgZLqj+BKYsDcXvZgyiRsHnOtMsFhdTyg
	RKUDr5h44zJr7hYhguqIoaZlZoMT+S2xNuWKTsJDLnSU0YhQQbTpxIe2vqISTj9z
	mfH28WK8o9F+8ivbWdT0BjF0q9tVHCSBBBYm9SaHXVYful6NCTXrKalistGMSHbi
	JNTA==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d29awnp4v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 00:24:37 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9B2E7295DC;
	Mon, 23 Mar 2026 00:24:37 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 22 Mar 2026 12:24:28 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 22 Mar 2026 12:24:27 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 22 Mar 2026 12:24:27 -1200
Received: from CO1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Mar
 2026 12:24:27 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDhR60QIqro8gihoYht2u1OqQmSiBiVGqURO4V0E7hNplJPc+wF8uZbCNJWFs6FiJV30r0mhHS9MRSgTfcmqNaYk9i0VcdQ5wSgfKBvzMGPIc8JkSPWxh4McDu2C2uD4Rb2mTDi1lwRAlsni9sUILoMQoU+Bs5bhesID1wvKkmKnaW48SrGu4lak/pvkQLSk+H1nZV/6PBtntOB1Ey0Q5GwaF5tUwL++lN87+ACtm7wuSSE1aGxRk47mMc4eSUoIwd1urRsjmJHEpjjtVuY0iT+BQxN+bkcppLIDCnLwSk2VNZglLvnS5xw/Sk25CQpOw6okPnyQnux5T8CQMRSxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8icBZGLc7dvKKEflOULmHxFAiIIV1U/XjuoJ9Y1Gbr4=;
 b=EMH1t5H3tsy5c2dVTKIqQaNRzwSgzqJ0y8U8UMOHC2DB4BHgSM7QKp7tlte+QqRwtr8rxmwtUhRY8XBJbl4AXYsMqi2ujFB+1mFvvCbIwsUcMyFK7cQk4FLBcwRcs0Qmje7UBo5EOMsFPPh9loCsE0tyfy0NtpYNxjeVeMQBE/ypRDUNmMTAbaRvk6vhEysyO8yEzUI16cMUdDyY8/BntT2ZXfVi4sA2QmhNcpYRbJG5XzYjY8hubTkracFuIA9o20EBRU7F/XlQawOLiWCEWTJzu9IMfi7tzr09s1D7PPsimKnT809uyIMk8iD+wMFfOirhN/7eGlr77YD3ky40gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:203::11)
 by CYXPR84MB3741.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 00:24:25 +0000
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6]) by LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6%4]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 00:24:25 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "iwona.winiarska@intel.com"
	<iwona.winiarska@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/2] hwmon: (peci/cputemp) Fix crit_hyst returning delta
 instead of absolute temperature
Thread-Topic: [PATCH 1/2] hwmon: (peci/cputemp) Fix crit_hyst returning delta
 instead of absolute temperature
Thread-Index: AQHcultnH2T0SI6M2kqRTk59nn2xqg==
Date: Mon, 23 Mar 2026 00:24:25 +0000
Message-ID: <20260323002352.93417-2-sanman.pradhan@hpe.com>
References: <20260323002352.93417-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323002352.93417-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR84MB3535:EE_|CYXPR84MB3741:EE_
x-ms-office365-filtering-correlation-id: 1835790d-a926-4b31-7cf0-08de887289af
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 5NnFBxj5Eo6MQGI2fRWooMr1kVTT4sOHC/9UIktQuuwbkAGR0yJ1V0BuvAkQHbj3ozIPzZyNgiBsLMfSV6pgTyaBpdaukj99lXD4hAiLsQ+1y3wT7++y7s6NyWI3NzIi0ClpKYqF5c6xTjd/C4gS8MD525WeslYreIAsH3lzMQZXfJZSmzHt+pia1nDjFN3NqJ3zktOF5O99C+7c3wuJWQDnFTMOHQr9niaDfiUW/iRZHJcNaxO9PhhVb5JER2BgeoDPHOOM68mVOnsgW+IODm3lrWFCGe3TRr0cWvXDc3j42FsYiAyIJ9Ts0UIElLjQuhF1+5zuQIVATApYQYSh04x0joRSRO7wO9xIuJ/3GA97pmOhv1cn3PfekAUvcfGKewPi4taXjiYdYkfIuSL9b5vog0eACjliEH+8GWh4Bx/3RWIuZ7g+3e0MPaZDUlZQ03Q2bReaAWktGQuP5EPP0chf4PNCjEVSbaYBtT+yo2VTuNLtaFLSDtRqaiuGnuOEgqRoKZt9kIlZ5A3LZPGRwpoD3iEiGtzrNv+rR93xpDX6CYXz7A/tP72xHPIZrfzgQiHsRp+gzaV/Kry2URXylNqZzqFr49FNkLTJK1mIQv6igIBBwyXMk4ZsrQkz/jYAh3CzqsRh9lR2mC/MldrdPdNi6MoDHI3k3nlGCAmN/mfddeB1eD+aWcHLzTqSFH117IovtDYWXwFvPhCwSfaYHSl/7/ZZ2eQEYZX/k757nObRJHdhA6OflOyLS7uxJFWmxjKsOerGv76lmgP3gmJSYxqvZHTrHwGV6Fiz+v24pcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p3W+dG1gQ2VZV0vdsAKyac69UrgpA+PSVQPOSugWxMir2mnKWRQwI9XYt/?=
 =?iso-8859-1?Q?5s7Ot4QfMkzJIXMlznrTYqgE91Mefgj4+Zb4nVJhHNs0DB263Mm23RxZCh?=
 =?iso-8859-1?Q?0OgyNDtrEZYn0Jtw7OVDHYVGVNXxsE8ASpBS5E4ffxe6PSu0sPnU5yqh73?=
 =?iso-8859-1?Q?iOUy4TIq/VwvJ0D66Zefvmx0eF4LmjiGwXX6edueBXSiNglEKe6m8dexnj?=
 =?iso-8859-1?Q?uxKBau0+HpvONckedPnbJUn3mH92vv1SEaNkCG5pr71SNkZG4tb3a5chw9?=
 =?iso-8859-1?Q?BSmkUhQ4NTqFp3ZwQLxlZ48lhJ3cYBH1qAcpr36HdtkrZeotcvCnEGPNAp?=
 =?iso-8859-1?Q?ZqFSlKTbkvoDfEcoSAvnOid87j6laD7zzlAMXkad4o6+liBBrIs7e6lXv/?=
 =?iso-8859-1?Q?IKFHguQSAoep6iHjphdKWJNplxibkRDiWzGCArCOkl3t2HQhM299M3e/f0?=
 =?iso-8859-1?Q?THa08d0wefLIcQbJ3LXHprLAVDb4uM9mIxypxnFmVsapCQ3wuT2nx4QHtB?=
 =?iso-8859-1?Q?FcNxuxxeOzG88Bk6AIyoRTpHyZqf3pqfIQtzzUfYOVczUXMA2jP1lehAjF?=
 =?iso-8859-1?Q?704GxpH7aWLYImkiBsGLlWstEWhPp9O6PWJ2RZ1S7KM0UsIqiDNc6e0pH4?=
 =?iso-8859-1?Q?iOFdopvqiB6VXJ9WqFdVHSLg8XPbKhME3tTRYL5FV8zAYvVitvsoYmhW50?=
 =?iso-8859-1?Q?jJX52Pbg5QEQcv7j2yuBgMw/s9kGsZZDB7qgVTTGlmmCXaBX4w+Rg61of9?=
 =?iso-8859-1?Q?S4IkLy+ZJRBQKoh4/N1WUZfChi3qqLdND1Ska+1bYrpl8lO3l0oPM07ygA?=
 =?iso-8859-1?Q?G9PAphNTMsh79wJkG1KOaBWNgU5ZVIySX9JRPfsZ+pVwkKoaAkGzEcWRTs?=
 =?iso-8859-1?Q?HIHuNQJHIm1nk1lkzvQxd6IT74WLu3PjHcBUs+kN2FJDac4c1JVRHSjB/+?=
 =?iso-8859-1?Q?IPjjM39MKtJHpGA1kgdTCdPbiS6+ZucdSYn4gn0UNLM5yqwEc8zrz0vDSo?=
 =?iso-8859-1?Q?Z+K/0Ufvu34lPv366rffbZWuwwJK08JIFHOEsQGtrfL3AbNEYFYR6LPHUy?=
 =?iso-8859-1?Q?fmvmOFOy/jPcEAASW5Kusgh3CBwojnE+bJ7HMH1uxOEfHGRnIxedPbO5b1?=
 =?iso-8859-1?Q?+XJpILF0EmCi6RBphXiRpv1YpqU7YecBrRkGdr2zRRVhnPnirEhPC5pfGt?=
 =?iso-8859-1?Q?btiWGi6YJfdN6DbJqAsfiabEYTInldoFIM1SioGnwpDPxMnbte8NlrjXA7?=
 =?iso-8859-1?Q?GBl60u2OimlmYPPjFjQyLVl7/OtmkDg9dNSVxy9htIW2ZpIxot0Z8U6moE?=
 =?iso-8859-1?Q?8eN2RGXtv4y2FgSXKGWjH6lBE/iICVU64C0NcmSballFRwSWeLfu1xG7W8?=
 =?iso-8859-1?Q?TueShZX2si8t4evTBa6yWMUZ8520CxglzE/glzZ3JsNeqf+DWzaTZlU66c?=
 =?iso-8859-1?Q?oZYrX+q28M4q6P2hVOeECu7CPxsZANizxScBBJ1scnXV4dmbzPl+zOhlud?=
 =?iso-8859-1?Q?ZjvgYw6VJq42K8TiG9UwpHnK4aaP2T3R/Up+cr3IsYa0VXAZGSgLiGl0XY?=
 =?iso-8859-1?Q?9SCUuhfz5Cz0iWVEKu5XOpKNnDUp+5vyGp6S8aadxxuxuOGu4W6RIJoqaO?=
 =?iso-8859-1?Q?toiBj+aH8+ndjgSItNCz/fGMx3ex1pQ3+dvd48C6zL9gHfO2Ix5ZebKJN3?=
 =?iso-8859-1?Q?JBSI+6xNJpYIh9WPpmVWaEjdXRfWU4cXZU5uhHGAuuEITGgrxqKr5XSH69?=
 =?iso-8859-1?Q?moB33Sw97EIoIKXLG61UA7DeyRMawKQYKfHPGjLAvJgh7Z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: is20GLZHfO5F7O/z8V/N58I3ou34tSJgCKNnD17yXKPG3tr9HxEana2vpS7tVby9LMIDyTxgucXiVlqNISL2/Y/CK37EWdtS4tfbwNuDe4HPP909k1tMp84kZ7BMWU+thhQKr+IYwqV39QsxFDOwF0UU9r73cGSN7gHyadrbBLkki56ubQXTeDMy/ZK5IGR5bfWrKq9xTdCaf8jUmqxEcIPyo/hSpAtb6p3Bdic+kqXYsERJL8KCK0+9u9sskCdML2ggsdBqIdKbheRqf5VnTr/dngFMZotpXC50w1eVKDPDeFgYiLGgnKnvjp+oSyNchjE6u3NluDweLlhDfRxMlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1835790d-a926-4b31-7cf0-08de887289af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 00:24:25.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kETw0vDnb4/RR+/aU6gCbfqUoPe+I6BFr/yS1ThqhNSw0giBZSrdyhMWFsoVo3m787ro6KMqUjGbo1f4YhZm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3741
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: qc34_V7ArFAOU-CiQnwViOOQT-hEKMNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwMSBTYWx0ZWRfX0udd3V66pLp1
 0+VVoEZE4TsXpeNOkfaXUSjsKA/FV3y4Zg6CwyexZWn2BKQ09IJEB77T0nz8mTkp8CX2rOBHFi1
 4ZjD/Ej7+Imx1wIpSsd5FByUMxn9MbL4ySib7fujDbVsrWeW8rFnjXPczgJaWLwU3H9cfvh6FvY
 2cBQlu/DDlqibqFfCXzF1qiiBmXh4tXGoQXjAgCA2WbLZSrpxmHI+5CvyLNYJ6Lx8cUSdmCobfV
 l6oeSsXZUhdxX75LJ9ltQ/kxCDMwHPQEC+6minfGO6myEbP2csTyofVZNBrLh0mSBS9DOxaMQhF
 2B/GmHEEkwEvgXcGYSqExXY16KkX6eYul2TmwKImbNbNNVJucmapah1nRYBtBAhttpHNagU5y84
 yR0l7DBIocDTOjzbY3tyBB5Jkg2jfRlCGaWmLwXygJHNiuNypJABxdMiCgk/D1V7PeublcQXy6Q
 8+vPcxrYwBv94oKeoDw==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=69c08846 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=4rKMkRhNZKWQXe6QfQcA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: qc34_V7ArFAOU-CiQnwViOOQT-hEKMNF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230001
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227871-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hpe.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email]
X-Rspamd-Queue-Id: D503A2EB40C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The hwmon sysfs ABI expects tempN_crit_hyst to report the temperature at=0A=
which the critical condition clears, not the hysteresis delta from the=0A=
critical limit.=0A=
=0A=
The peci cputemp driver currently returns tjmax - tcontrol for=0A=
crit_hyst_type, which is the hysteresis margin rather than the=0A=
corresponding absolute temperature.=0A=
=0A=
Return tcontrol directly, and update the documentation accordingly.=0A=
=0A=
Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 Documentation/hwmon/peci-cputemp.rst | 10 ++++++----=0A=
 drivers/hwmon/peci/cputemp.c         |  2 +-=0A=
 2 files changed, 7 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/Documentation/hwmon/peci-cputemp.rst b/Documentation/hwmon/pec=
i-cputemp.rst=0A=
index fe0422248dc5e..266b62a46f49c 100644=0A=
--- a/Documentation/hwmon/peci-cputemp.rst=0A=
+++ b/Documentation/hwmon/peci-cputemp.rst=0A=
@@ -51,8 +51,9 @@ temp1_max		Provides thermal control temperature of the CP=
U package=0A=
 temp1_crit		Provides shutdown temperature of the CPU package which=0A=
 			is also known as the maximum processor junction=0A=
 			temperature, Tjmax or Tprochot.=0A=
-temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of=
=0A=
-			the CPU package.=0A=
+temp1_crit_hyst		Provides the hysteresis temperature of the CPU=0A=
+			package. Returns Tcontrol, the temperature at which=0A=
+			the critical condition clears.=0A=
 =0A=
 temp2_label		"DTS"=0A=
 temp2_input		Provides current temperature of the CPU package scaled=0A=
@@ -62,8 +63,9 @@ temp2_max		Provides thermal control temperature of the CP=
U package=0A=
 temp2_crit		Provides shutdown temperature of the CPU package which=0A=
 			is also known as the maximum processor junction=0A=
 			temperature, Tjmax or Tprochot.=0A=
-temp2_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of=
=0A=
-			the CPU package.=0A=
+temp2_crit_hyst		Provides the hysteresis temperature of the CPU=0A=
+			package. Returns Tcontrol, the temperature at which=0A=
+			the critical condition clears.=0A=
 =0A=
 temp3_label		"Tcontrol"=0A=
 temp3_input		Provides current Tcontrol temperature of the CPU=0A=
diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c=0A=
index b2fc936851e14..badec53ff4461 100644=0A=
--- a/drivers/hwmon/peci/cputemp.c=0A=
+++ b/drivers/hwmon/peci/cputemp.c=0A=
@@ -131,7 +131,7 @@ static int get_temp_target(struct peci_cputemp *priv, e=
num peci_temp_target_type=0A=
 		*val =3D priv->temp.target.tjmax;=0A=
 		break;=0A=
 	case crit_hyst_type:=0A=
-		*val =3D priv->temp.target.tjmax - priv->temp.target.tcontrol;=0A=
+		*val =3D priv->temp.target.tcontrol;=0A=
 		break;=0A=
 	default:=0A=
 		ret =3D -EOPNOTSUPP;=0A=
-- =0A=
2.34.1=0A=
=0A=

