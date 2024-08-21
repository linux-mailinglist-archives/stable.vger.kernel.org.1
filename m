Return-Path: <stable+bounces-69779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA495945F
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 08:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BF11F21487
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1E16BE16;
	Wed, 21 Aug 2024 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Gk+3ePod";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="xsTvryGF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1A168487;
	Wed, 21 Aug 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220473; cv=fail; b=afEyPgMmga2+8s1QQ/umtb6l5ZEC89g87mkUktWQhJcc5Mc1mfcH6gbDGZp/M9kk9xC5yRPy0TSScSdAlqO1UlgZYuJIOjsoDtADCjycEZVwGBQ86uZUf8byWXD+5t6vFNclhhsH2UmEAiFRM1vW3lLMbZ7z7d0BZoO8hMzSwd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220473; c=relaxed/simple;
	bh=5E3tAPEKlsO2D3j3u+Y/VpLMzSVDStb0qgkpCYOPzjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JZl9EsajFqI0xqJxbw6kATepZ8k2eo66PGdIqKathUgU8dqMZOJcJvu0szg2w/1tiXSev2B8Qe3oLCIz56GqmubHb1AZgHf+4OlMGQfQ9Yo52+Psj+N4awjs7s8lyv+wVLZf09RnmF4i78J6zvkNDHS+mXUyapY73m2Xq9TD69E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Gk+3ePod; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=xsTvryGF; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5LYek016350;
	Tue, 20 Aug 2024 23:07:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=5ITdK03MDP+MWW/0fZArboWUQrANrXQv6DOMFoFKKUo=; b=Gk+3ePod7RpT
	59GBoWMoBJOhSRGpAliLuFHgLbXoBowv6eT6CwirYaEXt9RuWolgmgwWWoU37R0S
	DBBHEfhg9nzm8vhgP4lGajNja2yZPLzXbNXY90ZhbvEVGEFySX1vKA3ZAW9SalcV
	dS80+qdolSQPDJ2NvQpL9R/ZmcS0gs2jBHPjh55by4Nk+ma/Nq0Aeh9jS/PTA2J6
	BAmuywcTNlAx+PQToePGMO0VPom1ftP05NLf9+MovLbPBacwaoYfq7F7HV4HYapD
	dXSKZAue6B9XfnY+ME3OmpB6gUA0Cd2nh9U3mmNf8WXgdeeadgyhUUBsE/1VKcte
	HvFSSvZysw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 412rdtxxfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 23:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JySO0QbBj3DCfGPKokxseWnTGHPMyZ7ETsAc59ON5ehzTC5JwsXZl7xjPigyCeESHUReyyloUBpLxhG75YoklBm5xvBl7yxmsXIrghzd4ofXnx8gcawamPGl0yCRATWwhKA80ly6FVK4uELjaS3qHv/7yOxrkhFm3vF9D9KfyUQ8j9rWdULYgG8z2tO3Ru0giYkF0Tiou3QyWGkXub5Udd5S06p4JVeuDT4K2Z8C/KoKqy2HTICltDcAET30bqmKwXPhigjjqnNZzFaJY4ftPwEfV3B3fBWVQBNLF8DKujN7Z6UqyAjgdJxE0Om0yTVRHkflYoYDjnjZVVuwU19R6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ITdK03MDP+MWW/0fZArboWUQrANrXQv6DOMFoFKKUo=;
 b=DP6L+/rGcQt9HF7jzS3cGj0mEsb9v+vCI/IEVlFI+exWY7icLmgT4y5Weps01jZfdcjp0ER0c5XG+w+aR0CJiuTVsmsQrI35oUpR7ml++ciY4ynkc/zmwPi1ZzgMqkG/9dDfunXk0ptkFHH7+wdceTlhimUqeX89Apw/iHb201JpbUUTLxIgIIJ3ie5V/cDmq4q2bMqNa/F3NGgwe7XptOuNPRXRsH8mVYxVX6Wn64mrn2NSSeqIpadMHSrUc7VHY1Px62dB6+GxV2j2AzoOe7O3jtVL8SwICHgbpESkPo0OauAUebQmGMU+vT1JwB6RzosOyPbASQpTOTwex1PcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ITdK03MDP+MWW/0fZArboWUQrANrXQv6DOMFoFKKUo=;
 b=xsTvryGFBYcwm1BS/G6tjHChI0Tv160p+uqZ6sdZjmvvVujpoPREH5yfRz58R63FPy+JgbtQhlrG3oF0UauOw6KykY2ttSKRYuXtFzjKun0fUkimExnK5Xn5b07Z38Yi9HRLAgP1NSBXeu4kglV6ddxxVxd7T3FdbnQhXEjynCA=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by MWHPR07MB10738.namprd07.prod.outlook.com (2603:10b6:303:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 06:07:43 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:07:43 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: cdnsp: fix for Link TRB with TC
Thread-Topic: [PATCH] usb: cdnsp: fix for Link TRB with TC
Thread-Index: AQHa85AgOPYdRptGMkiuacc87d76fLIxOXkg
Date: Wed, 21 Aug 2024 06:07:42 +0000
Message-ID:
 <PH7PR07MB953878279F375CCCE6C6F40FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240821060426.84380-1-pawell@cadence.com>
In-Reply-To: <20240821060426.84380-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWFjMzM4MjUwLTVmODMtMTFlZi1hOGIzLTYwYTVlMjViOTZhM1xhbWUtdGVzdFxhYzMzODI1Mi01ZjgzLTExZWYtYThiMy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjYyNzQiIHQ9IjEzMzY4Njk0MDYxNjE4NjA2NCIgaD0icGFQaHBsZHNRWmpPd1pDM2xhY0JabTIrdXo0PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|MWHPR07MB10738:EE_
x-ms-office365-filtering-correlation-id: 5b12c3e5-0258-4417-735d-08dcc1a791d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2VunikvlXjo7s6NARD8wrxuOqXU595BNdKRNutP7qE6dH+v1uU08n49vihnL?=
 =?us-ascii?Q?cB8DfHnR8IatNOwaUmlZNiPPptfG0EMiELSANOwEKsH63AtW+MailMX4eMJB?=
 =?us-ascii?Q?TslD4GScmy4MSX3et4pfxDihZUjL3XfopvUL3ANbmIuiY3/z9uHnSH1fMenI?=
 =?us-ascii?Q?wYp+Ad0vbwIq3wilopTbqMtzMff4JKHG+U29UhUg1aLZdKF9jcettBF3rYKP?=
 =?us-ascii?Q?jlHIlR8+cYIacKeDwr5eeAR2XjkCMaY0etUKxjnVAbV3qwyKy1edrwn+8OOf?=
 =?us-ascii?Q?hZNCcKSZv0eCy/leTQlcsLm3cGGW9nwUuDg9I0MuCT3qSyFbquY3LSdS1hJL?=
 =?us-ascii?Q?c1oaczU6OydVSD1UkJDsUnnAUZaNJyxwHyIV+BfTBYBXWYpVf5EmOllGSP2A?=
 =?us-ascii?Q?sjN1xrJkOTtaTC4M0JrVnB7pt8mVaBQs4UBktj6zjS34I41urOLef+fF9Y/t?=
 =?us-ascii?Q?3X7fL5Qmen2/T7BjlEcHlgi4xmiFgPsstgNYysdJJZPzCdWyJ9bXpYX+e/8m?=
 =?us-ascii?Q?7caum3m3DpQZrWnD3BA+t03+c3Spp2KwE1OqL+k9EzwcJ/q8JesYKpTk25iR?=
 =?us-ascii?Q?CcJ4yBJePdqxuvqJ50jhwk55e5wn5SoVhip3jyxmcWP6JGXOZEZO6Cu2JJUa?=
 =?us-ascii?Q?bavbn++zY3tign7Oa1VaXw31p2Q/oi0JeiNbMVpGwZTYf3ZNE18shJ6jKmP4?=
 =?us-ascii?Q?v2s2tNRE+Ho/ab5IopWhvduwb1Z7DjIF73bIAhQMx5TCgT7BeAZT+rUYRX5K?=
 =?us-ascii?Q?QjwNSOK0q2XZEV1iLSnucISGymHd3XnC9adP6JJVZOrdS7M/LNwMrevp1Je7?=
 =?us-ascii?Q?kYPAZJVRjp2yVSuVVRJRnhMEuZ0UGX/IJBI3/87lbVY6WLBdD3uJRHEFVGHy?=
 =?us-ascii?Q?h47zHkAgaw448Xdvq80GQ+yDBlX9o6Tt3jJA1vSdaZ+vBtiYZ8qFVsfzfa9O?=
 =?us-ascii?Q?u+KjfmWwhJ28GYT4ciwP8ZjFeb0jt/Xx6+SYPly1vkAyDmi4lEZFdEK3m+s7?=
 =?us-ascii?Q?0l2Pt5DtghEx9qBxfPJeuotVOjfL6AKfTj8mC8ujHR0kvirH5cASwtS6ViEc?=
 =?us-ascii?Q?zGnJ0HyqRgSKXRL8QHnedu6rNsyPNwlVUJTTV6HJgAFpCTdRdr1WCQoNU9/t?=
 =?us-ascii?Q?gw4MV4tznrAF3Sm2UCYZFOQZHytbAM8FWStH7NCz2+1YF21m+k63CjBYQbXG?=
 =?us-ascii?Q?BUlnH4+FRiJbHs/lFtZaNxYdEqx7/u/Otvq9HGgd13KyLMWq4/RPOZvKQ5LV?=
 =?us-ascii?Q?8Bc/unQPPeYxuicNgNXs9hq8QqhRe0iKhnGm6gxDBbN+2iJJTbODFFSKSlFH?=
 =?us-ascii?Q?B6qODBsAuGKgMZpBkj1texZh1MuSzY3voF4wV/iKi+MsPclwLbAEA1Q2Iaw4?=
 =?us-ascii?Q?N49cnw8gfbNFkatp6girpW5akvgBnq6ZkVdBy1+joN8/yZXSPg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rf9+BROc8uutRpRU14G2i+x1BVp/0psvvytS3nAhvtN/ktUdgOvOoNb+34tI?=
 =?us-ascii?Q?EBpAnvx8YCZJPoDj3wodFr8wSGuDtO0XfyRE+ilTYOv+F4Eb+sLFyk5hVj2k?=
 =?us-ascii?Q?UZ7SpaULif3SdGIioXIlJwKmWKhvriZHceq9553KZyXLtzZte352xLvSibWV?=
 =?us-ascii?Q?dnCNJxY31tu9N3oXNlEr6LMWsQE9gGoIVDPvjjmw0cVaPYvnTA6mjVDVRbLD?=
 =?us-ascii?Q?X3PLo7n54BI1HfWMk1f4DhqrqKJE8i3v5lC5MumPeaK5Z1n2/B9gZYLhh8fG?=
 =?us-ascii?Q?SWLOlw0yCabe6tGKGryb19+UsK0iKGMDwYqx7Osk0Nu76E/D2xbFNnMhXk6M?=
 =?us-ascii?Q?xSkakg34U+UUfPJqQKsf30J6gyD1cKuO9KGWlVk3hdEW9w/XRwdggPnq4ZfH?=
 =?us-ascii?Q?QmL1tXHg1TjDmzo2p9dMhloVOjI9Vaf/vshYLTV4I2Un4g5L32UxqsMgfA3y?=
 =?us-ascii?Q?9fFg5eE5cydfxjkB/MV8e5kBW6Tsr7qVj/To+33cN3Hfuen9ohosnrhmio/E?=
 =?us-ascii?Q?kfiwgzVIigjAmLL5GgLYNw0SRY1TFQYuufSkV5Mq01FFuubqPPHyzGlIkSnQ?=
 =?us-ascii?Q?GmPt51Q/jQBXQyMyoURo6n6LNDvUrbeQAZ3RmLVcNrzqkOzZKENhgzPbDNaC?=
 =?us-ascii?Q?wvRAslg4ZJ7MgSZrf0BcXEwM1c20CgJr8SecVvRpruXn4hQ8Y1mg+304x8LC?=
 =?us-ascii?Q?V8GV2kKEVp+ks/WfU3e0sVMkdZOQkk5/wFsc/McTXjoogfQd3fIUz14Eik7U?=
 =?us-ascii?Q?dXNBSAltsMBfktS38M5DWpyu3AjdGy9H31r44PF2uxMFx41xGDmvxetFUj8G?=
 =?us-ascii?Q?TSkRdi4RDQVFAjW+pm3fHiZT13XieB2Stu1d3mcwG8nodP3M9oJB+nOGfq6Y?=
 =?us-ascii?Q?YqWJq7AphfIoV2rXwDiLTbscjmB9eV/dhYpGWWsdxjfECbxOo5bqVSJoHJP7?=
 =?us-ascii?Q?2CW3pNulR1HHSqImExdAfCzGnyb1vK2UMwrRoRMa54ox095vPZFN36ZYqNEq?=
 =?us-ascii?Q?J+C207DiNvKQtBgnN9fPKcx3tyT26+FeuDCZ15+OE8qdSyF+2xwZf215FX0O?=
 =?us-ascii?Q?PzbhF5FZlspMp/oSr53EgJAhDlLLSmRgxef46nd/q2YmRdEDmves3I0h4RHb?=
 =?us-ascii?Q?Sb8t+VSfOEFS59TDDYF75q4isf0oUEpcATJNTNlNJA0LQjQyOOP49lFgNIm+?=
 =?us-ascii?Q?kpBzsTVcD8CfUhDcZwQVoHwPpTW20ubXLWeafQk4VJNa5xeUMEFYRTOZku9K?=
 =?us-ascii?Q?qDtIPLltA4UjziftPFhS83KOaJ155vJVqT7DsjudbNcY7AXDwyeG1YExRp+8?=
 =?us-ascii?Q?iUL6bKU60MA25AUWbJQmcgldGFiB4x8+aW3f0O6Cy3SiPhmgH6UhFvQOEr1W?=
 =?us-ascii?Q?LXMfJNA9rzzHCI5N89rNdEAvY0reP9SmApVc9TfWKH1RjSAfmonM0RmWCl3Z?=
 =?us-ascii?Q?ZGalp5DJU+J8nC6BKZw58gMiUBPAMwCHL4VcoVe24TI72tq3NTHpTLExx5lW?=
 =?us-ascii?Q?JDMASYN4qShPviJZLe0vIdUz40JE5dsheqPeV7u0tm1e13gLlKGrOrlWY1v2?=
 =?us-ascii?Q?qLWdX/0JkKnP/LdKF+YL0HtOLuJb56KImH0Dc0Re?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b12c3e5-0258-4417-735d-08dcc1a791d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 06:07:43.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGzE+PsjNjGXDe/4W0+OCpxzRK+rbnFMSYuNlJR2HM9PEp0EtSAX1nNpvr9uth6KEiSue7/QN7BiqhGeFbUE8U+qiLAM5Qe7njXgTi6C8S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB10738
X-Proofpoint-GUID: IZ6DpmwiwzGE9anvncjYePOyxVLADicn
X-Proofpoint-ORIG-GUID: IZ6DpmwiwzGE9anvncjYePOyxVLADicn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_06,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=810 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210043

Stop Endpoint command on LINK TRB with TC bit set to 1 causes that
internal cycle bit can have incorrect state after command complete.
In consequence empty transfer ring can be incorrectly detected
when EP is resumed.
NOP TRB before LINK TRB avoid such scenario. Stop Endpoint command
is then on NOP TRB and internal cycle bit is not changed and have
correct value.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
 drivers/usb/cdns3/cdnsp-ring.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index e1b5801fdddf..9a5577a772af 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -811,6 +811,7 @@ struct cdnsp_stream_info {
  *        generate Missed Service Error Event.
  *        Set skip flag when receive a Missed Service Error Event and
  *        process the missed tds on the endpoint ring.
+ * @wa1_nop_trb: hold pointer to NOP trb.
  */
 struct cdnsp_ep {
 	struct usb_ep endpoint;
@@ -838,6 +839,8 @@ struct cdnsp_ep {
 #define EP_UNCONFIGURED		BIT(7)
=20
 	bool skip;
+	union cdnsp_trb	 *wa1_nop_trb;
+
 };
=20
 /**
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index 275a6a2fa671..75724e60653c 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1904,6 +1904,23 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, s=
truct cdnsp_request *preq)
 	if (ret)
 		return ret;
=20
+	/*
+	 * workaround 1: STOP EP command on LINK TRB with TC bit set to 1
+	 * causes that internal cycle bit can have incorrect state after
+	 * command complete. In consequence empty transfer ring can be
+	 * incorrectly detected when EP is resumed.
+	 * NOP TRB before LINK TRB avoid such scenario. STOP EP command is
+	 * then on NOP TRB and internal cycle bit is not changed and have
+	 * correct value.
+	 */
+	if (pep->wa1_nop_trb) {
+		field =3D le32_to_cpu(pep->wa1_nop_trb->trans_event.flags);
+		field ^=3D TRB_CYCLE;
+
+		pep->wa1_nop_trb->trans_event.flags =3D cpu_to_le32(field);
+		pep->wa1_nop_trb =3D NULL;
+	}
+
 	/*
 	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
 	 * until we've finished creating all the other TRBs. The ring's cycle
@@ -1999,6 +2016,17 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, s=
truct cdnsp_request *preq)
 		send_addr =3D addr;
 	}
=20
+	if (cdnsp_trb_is_link(ring->enqueue + 1)) {
+		field =3D TRB_TYPE(TRB_TR_NOOP) | TRB_IOC;
+		if (!ring->cycle_state)
+			field |=3D TRB_CYCLE;
+
+		pep->wa1_nop_trb =3D ring->enqueue;
+
+		cdnsp_queue_trb(pdev, ring, 0, 0x0, 0x0,
+				TRB_INTR_TARGET(0), field);
+	}
+
 	cdnsp_check_trb_math(preq, enqd_len);
 	ret =3D cdnsp_giveback_first_trb(pdev, pep, preq->request.stream_id,
 				       start_cycle, start_trb);
--=20
2.43.0


