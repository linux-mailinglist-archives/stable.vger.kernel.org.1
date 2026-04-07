Return-Path: <stable+bounces-233707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPbfIgJC1Wk73gcAu9opvQ
	(envelope-from <stable+bounces-233707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:42:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 369893B27E4
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2B8930D4325
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E959344DA2;
	Tue,  7 Apr 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="bMKB+S07"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B873537D0;
	Tue,  7 Apr 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583502; cv=fail; b=W4YENS6rLn7prTIzwVxR2umG2ORBqln1aNXn14uaX4qIyT88il9gHCIZJF+QSDjxP2NILRZpC+4ZOPlI9b8yUP1kK9eECVnWQTWio9KmlwE5lKytUQM9zItAsov617za2G4TAxZUVA+2abhjSLpObmS9hH3zWYNzEJPJMcxJtmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583502; c=relaxed/simple;
	bh=0Rux8w3ODimPW7kaO5cMPYJj0ggWR6EPNwoGWFRCyIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AV/DnpMhdePUWKw2GoDg9v1bKah2GBiNKSZ8rhqsVR5HwCEo/bPtiulzVRqaDRlbi2vwuOeAlG2mWE6tls70kknbwG/pozXw6SOq25Ni3ebaeQQP4Hc7FyDiLAq39nfgfUz7WIA2QfqoYdeeGA67M1i8UjvQjGg245UByTZel8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=bMKB+S07; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637H2JoV2480179;
	Tue, 7 Apr 2026 17:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=C4
	MUSdMG0OfdimNG+AjqPEvfS/aLdk9ghWUj6fcMqMQ=; b=bMKB+S07izxx/EyobN
	+UD6nQaX2I00AlPru6Llx2rq86ciYMDDq3fh9LsRIYHfFk3hM22JB573WDV/kXjQ
	3WQPJfDWWXqu0nahCtOt1mHcBFumPnwfT8sAxl7ah43PNlqeDftXv5uy2lnjKJ39
	GKjCrUInJ1sOXleVABbzEOk6XVoXeAqRuWrUqEA2JGDzHK4gu0gtzl0W+ujH4ZKi
	3xu+BL6WvJeGHFQVYUexuXN5cccP1J00FP4cfhaKLyU6PLq/YTnQ8fkXqEFe/qgA
	l6uohbg+ylCpcf8OIdDsLL5dX1esv5PuIKciAfq2nUNYgXIHFgc35wSHce3fnyud
	VZYA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dd0qn55rx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 17:37:54 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 54A32801707;
	Tue,  7 Apr 2026 17:37:53 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 05:37:38 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 05:37:38 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 7 Apr 2026 05:37:38 -1200
Received: from DS2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 05:37:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N67JJZ5jAEiHIfncVArJmxcTVeLrKwrTBUCQFjKWw9nZdXv+MwwIDq+f/gnH9UUk7vUC1oWtamCJ0bhUfKSGGpfncMPq9JVxyfxBgniizoNvqV09+IaY62xjpOuDhStr3ZC4HGk7uEF6C5bRD83CqOf6+CZhaCT1V1UYoIDaMIpG7vjlDkQXMAsAr0+kOZ5wPVs3atXY7ZLDm6oIvl+meeQARisNS0IW1RkXwVKuHhRihe9cP6Ud9TKHqUpA5kU7tIDzL3bghjkaO5QOAN/9bBQrE3IHMItnrzE7TnLoASIM2zce6dpYvRtVyBK0LvMXkij4t5ZIKD361hX9sBJl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4MUSdMG0OfdimNG+AjqPEvfS/aLdk9ghWUj6fcMqMQ=;
 b=ns6P2scPqyppcr61cJArPls/E8jjUOKfLKEs4cnuV1dCho88rololOfFh1my/q8LowkW1rn7WS+OJNb9mIbdL7Oo587Qxfke/sd1H4HBbb4OMnZQsI0Uy0wb6wy92lhaQSPKM/ZZuRQdCyOBgssPL8fP12eggDOFSk3oNuddjRIiepExzl2aNBz5VC3EAof3kZBXvLEQdc86VgB/ZSdU5Dr047f6SzFhgVQFGLtLW2GUgHi/X80ovfUs9JxyPthSn0w5vU8eyuht0yV1keU/Mdi4iZaK6bXqSdSv8VaL3Mv7NObFjtsB6tBYGpWjKplXQk9t0NHYse/SatntKaLH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DS4PR84MB4043.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:37:35 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 17:37:35 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/3] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Thread-Topic: [PATCH v2 1/3] hwmon: (pt5161l) Fix bugs in
 pt5161l_read_block_data()
Thread-Index: AQHcxrU4/uxAbS/lZkeYptDgqmqvtA==
Date: Tue, 7 Apr 2026 17:37:35 +0000
Message-ID: <20260407173624.247803-2-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260407173624.247803-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DS4PR84MB4043:EE_
x-ms-office365-filtering-correlation-id: 78e52216-7be0-4cac-9297-08de94cc5b3e
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 01nrlc8BIK+1NPrzaCEMVcmX3Xm86F0niVThu6xjeprjl/rO4gbUzxHFkGdShCvYU0bsfIcZAOtoFgO0Gpl5lJcIIXZeIMe3VHmbLmLSc0GiPDx65t4cfvijdb+3pfkeOr3a9Cz8M47D4r8s3d4PScV4KtoTwbA0N4Q217doacPozSTyMiJn8Mj+iX5e81sLTstiPzoQ/XI76ZgsuGqIdg6p3G6jIAROmZ0/Vaf+nUBoH+PtgJH8dfObdbScqeZou5QZ80pBvYai/SakZchAtM3IE8IANhMJSolQoiaH4CL/JIlhnawcqPVDAt6fcXA1m4a7hgHwb6JsIfe4TO2Q23O8iRB1tAIKe+kY8OcafNPEMKkxdFHF2ZYnrRhIb503nfgWBdPkuR6KuZfVKzZBxlBCtJBI41j7LcpYtM6P7ohUSqk1lHqSaTInQkm+nJooA94nANQ5/zQ+R8gO9XdXDLZwwib2VrvBQ5kmz13y9DURhveNAfUirCLn67nSK71CzpRMNlx7LXmPXr4Be/Y+0vM7AC881EXPDRjxkJmH2GdK4G8HojFCDej+LUx8gD4DIQTK/C6a0QvcAp5FznNz7wmD5qElwquaCvvcS/ExWMXOcgeQDoB3EvOW1ED5JWS9hnTfXQj8dYXUuziScBMoXfRQ//+JQQQyvwH7yL945OznHWKYcq3//DdZIIRwVM9MWwR6l7S3ekj+NuIC5DDmx9JfXb7kB3wDT8/IpL4POYqz46G35vzuhTbwNv/40Vw+bL3K+W/8110HQsA8dZ7U4JuV4yTbV9WVtMkpaGaXFxo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?owjh7kAE428kU3Lr5Ys6qL9v4BqkuT3SVCVjR/Uw0kmpV9L1N/j8TX+G+U?=
 =?iso-8859-1?Q?osA22GD4KNoI7nXIJn8Lq0zTyN1BZ9Rzq1qJVhrsZDw+8Thnn+9XmDKTrx?=
 =?iso-8859-1?Q?UrUbSMFWiqmdWB+3tXaijcrWmzF+PNiPKyi+MV6RTZ6npPwTmTD6lUfqeH?=
 =?iso-8859-1?Q?8JcO4JA1gvDOS8drRU/Y7FFNr0HcCsCsQ2hUUeYdMElFeDkpBG8USNU+e4?=
 =?iso-8859-1?Q?IoyADKPx2lOeAEez5XAXkXPc1EiNgf+KtxQaNQEvEJmgGtATMstZPnRbVV?=
 =?iso-8859-1?Q?PCGzgM6a4/n011Qpr+h5qXxtDpQTJE6VDsT2bwDzlVVFfgowUUOM63IioE?=
 =?iso-8859-1?Q?7YyOBPHqhbueyeJVxVvwEpehnfaAgvQh5YHHrpJxpN4keGXvu376lUnC7O?=
 =?iso-8859-1?Q?93gWV22Gb6gGZL2hrbxfxQxKL6gF55AOqmw2wzO0AoLGnw++kd9/G2yG3n?=
 =?iso-8859-1?Q?9cMb3/bkrisqAM0Zxs9nTDSHZppNCwAEdrs2GlIuNbVAkrDcXmfzO6gnbI?=
 =?iso-8859-1?Q?QjbTrIFEVRLH8AHkBAWh23Tv0wCHW+AJp63jx0RCGoJG+L5gDtGxpE3hkM?=
 =?iso-8859-1?Q?AkS3/m8fwX1BJUAZxCFq0N/pNlE7xZeSeTS3CC/7dSX9C9D6t8eamNWFF1?=
 =?iso-8859-1?Q?CoTvEY86qMEvpNkyf44n4newXHSh9oJOPVL2GeHcQNkXx7g88x+a3j5RB8?=
 =?iso-8859-1?Q?fwwbyC6AFA5p9FyQjOnNx6OcuMm8nw3C6xvce63EF5MY5YTYelkRNz6JPK?=
 =?iso-8859-1?Q?GMeeIo895NirKuF7wf+PLVSnTZ8tSsIGgra711saOkSIeWxKJRRR/s3nx1?=
 =?iso-8859-1?Q?+hO66mu0906sh74lW8oDpFEEfI2OAA403wYArSIdrZVUzknK4IXKccJLpx?=
 =?iso-8859-1?Q?+IwAtIW9WKxNp1hX+OKkhdPuU9BZaxVKbpSIx9k9xFKZUJ0vdwtRmyFI6c?=
 =?iso-8859-1?Q?oIfVk/OzlVE1Wf5/otZD6/wbjkol4oagc0swoTkwGu7zHNz+aur9wBiTaM?=
 =?iso-8859-1?Q?EOVzVg6pFSRWYWM6WWDIKKdVpMtBrGVR8z1foCcrMg7paOzhQ7AU5AVj4m?=
 =?iso-8859-1?Q?QWgOVH3zdGRKOYnwvXnADIE/fONRdQuubhtXZx//IPe5KjZkxC8b8ghHgZ?=
 =?iso-8859-1?Q?6u4XyPfCZ0Jxi+MzNW/VcBCuGfa0M7D9nFeu9IQwoJXeWAOiWo773npw8u?=
 =?iso-8859-1?Q?jn7evUGREh1w0C0Ih3SqOGaAyrKHDrfRK9EScMMNkjUp/KL6B/yUtJlWV5?=
 =?iso-8859-1?Q?bGGB8Us0UtYbLwMMax+DaVZX9Tt4ee/ucSJ2XShbxWtoWi3Yngl5kD/wOo?=
 =?iso-8859-1?Q?MspqhnnwHk7jIdiULvO63C1zGUunQSLpVIm9KMCULR0OsgF42+HzsrvMTU?=
 =?iso-8859-1?Q?p025jEmMWq0PTdMutzoPJtVHcdHvNEyQhcQaZbxHb6dscDftqlXpNY+0IM?=
 =?iso-8859-1?Q?JITLUqA8JYgezQytiDqfNCQJN5Y8uljGUlyJEA1Ih+FWmBGYx+a8R9HTs/?=
 =?iso-8859-1?Q?+ZWH9j94PlIS6LVGb5GqjA80nX611xkdpr6AqRaqu5YnVsVLlisapBzC6+?=
 =?iso-8859-1?Q?XHwPw4r8prByERPK0vj8Eb5a0RuP2i5zkU03ARtkpndqMAEMtsN8v2560m?=
 =?iso-8859-1?Q?WeTz32ER1S+fXcfh66r9P7FnMOvcRDudBehxhKiYWjUSBbaBAPcniOszj4?=
 =?iso-8859-1?Q?UX0B2V1ODt+Jch67kh45M1bJjdJJEx1pfiDZh+vPJSclFT7VVsg/Ty2Uqy?=
 =?iso-8859-1?Q?XK4QUlJv6AZtNl931I5+YaE0fbBWOO5hVAxuSIoJWPLi9Lm8MH2pPaMezm?=
 =?iso-8859-1?Q?XNBNvHyfEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eqyPG235XGQBjGAZNmntJVNW0Bz9lTlrvrdo0E++oRkSdHv6q7GO54OsacY5RSb+a0V8wtPFEYe7bpXQUAjSwQ5RhZoOszhiZxqJLQqB4D+ieBfma4vEaKiTHhsiTkOPQSPj8R3p/awenNiiQj3uUqTUWlfqXm71Jm44T9MORgLuN3WDObHoH/8TIW4EwCBqCka+n5FYSiemSZUgLA74KlWY5kLAf9eGuWQfd18cuLWUob/e1QgouI4MjMs4KztXMFlQs33q0eueE7XNaUZAsZxGz70XQAaEH1eWueZrRUTAH7G2DjKoDrdfs7vf++aV2kx5oF1tynq6YmwZ4webzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e52216-7be0-4cac-9297-08de94cc5b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 17:37:35.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xD5e/9FAQZfmtHEkS+4eGYcoHCRlWA85wrtXfusF2fW2mN6dXXN+8uElCCvzfzUigoauxvUxnO0Bt9oefD0qQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR84MB4043
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: t6ygkPr4IVD7o4ALl-GXZt0RBJ2oVrxm
X-Proofpoint-ORIG-GUID: t6ygkPr4IVD7o4ALl-GXZt0RBJ2oVrxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1NiBTYWx0ZWRfX3poBMDtoSLNR
 48cy3AvfaBQYNbhxnaMVkdIZ2n6P3+dQc4gy9fpRLcSChdWT23jrBlVWYABkVBL3cUuP/FJE4sB
 wpPxlVWbJpSz0rOrcQKlL/Pf/uHFdT6g++Hm5xlVbkX92MxI17nVtlgKdZWhhyNyBwmY7LJbmJC
 2mRIODnwoWnancLpaQtbXmPeX6hVTS08qjCPdz+dUSa77jjADhCPY7Kxv4Iwud2QH2VVxKBFela
 YkFsKnngJbB+RWklUhwObApCadsDOJrtz5jUUeJvKQXDK8qcXdT6J8guuyUPIucQV0de9l+1BMh
 +SvTqrroqDQcWl2NfySL5k977eAU5cwCP/Imx8Gfqrbghs+Krg2RGVdBjVXTxv5CK8L1C0p8BNl
 1z5GIjHUWfT9b+a6M5l/77o7v4BkS1DKlmWCnj4afn9mcguxSgfaa66BRLyaS5WKnnbG8UrKTMQ
 doGmkp8lwzF0w2GET6g==
X-Authority-Analysis: v=2.4 cv=Zojd7d7G c=1 sm=1 tr=0 ts=69d540f2 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=2miM9txUn0MiwXLCYL0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070156
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233707-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email]
X-Rspamd-Queue-Id: 369893B27E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Fix two bugs in pt5161l_read_block_data():=0A=
=0A=
1. Buffer overrun: The local buffer rbuf is declared as u8 rbuf[24],=0A=
   but i2c_smbus_read_block_data() can return up to=0A=
   I2C_SMBUS_BLOCK_MAX (32) bytes. The i2c-core copies the data into=0A=
   the caller's buffer before the return value can be checked, so=0A=
   the post-read length validation does not prevent a stack overrun=0A=
   if a device returns more than 24 bytes. Resize the buffer to=0A=
   I2C_SMBUS_BLOCK_MAX.=0A=
=0A=
2. Unexpected positive return on length mismatch: When all three=0A=
   retries are exhausted because the device returns data with an=0A=
   unexpected length, i2c_smbus_read_block_data() returns a positive=0A=
   byte count. The function returns this directly, and callers treat=0A=
   any non-negative return as success, processing stale or incomplete=0A=
   buffer contents. Return -EIO when retries are exhausted with a=0A=
   positive return value, preserving the negative error code on I2C=0A=
   failure.=0A=
=0A=
Fixes: 1b2ca93cd0592 ("hwmon: Add driver for Astera Labs PT5161L retimer")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
 - Also fix unexpected positive return when retries are exhausted=0A=
   due to length mismatch=0A=
=0A=
 drivers/hwmon/pt5161l.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c=0A=
index 20e3cfa625f1..89d4da8aa4c0 100644=0A=
--- a/drivers/hwmon/pt5161l.c=0A=
+++ b/drivers/hwmon/pt5161l.c=0A=
@@ -121,7 +121,7 @@ static int pt5161l_read_block_data(struct pt5161l_data =
*data, u32 address,=0A=
 	int ret, tries;=0A=
 	u8 remain_len =3D len;=0A=
 	u8 curr_len;=0A=
-	u8 wbuf[16], rbuf[24];=0A=
+	u8 wbuf[16], rbuf[I2C_SMBUS_BLOCK_MAX];=0A=
 	u8 cmd =3D 0x08; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */=0A=
 	u8 config =3D 0x00; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 *=
/=0A=
 =0A=
@@ -151,7 +151,7 @@ static int pt5161l_read_block_data(struct pt5161l_data =
*data, u32 address,=0A=
 				break;=0A=
 		}=0A=
 		if (tries >=3D 3)=0A=
-			return ret;=0A=
+			return ret < 0 ? ret : -EIO;=0A=
 =0A=
 		memcpy(val, rbuf, curr_len);=0A=
 		val +=3D curr_len;=0A=
-- =0A=
2.34.1=0A=
=0A=

