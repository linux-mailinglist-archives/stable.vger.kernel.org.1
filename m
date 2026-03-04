Return-Path: <stable+bounces-223105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP4sCxhuqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:38:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20020541C
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F183C303B353
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED013C6A20;
	Wed,  4 Mar 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bIhE0ZCF"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215E3CA481;
	Wed,  4 Mar 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645748; cv=fail; b=IFsP+Nk2+XCUc4NBIFPxBF45lnDn/p09pw/Ko4suxLZU8dICBgljwpsxwwHenFOajj+YqnSu7ZqAik/Itxfw37rsi4HtlC9bJavDR+k5DHRmK8elCbQ+OOIoshyuZhqINExsrVcSE2quiBTcnzTaFHUzcxrUPY8yUXk285tBSpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645748; c=relaxed/simple;
	bh=J0+Cwrx2hDWJK3/rgj+lj4vbmgQG6YzO73Q8Ov09GRY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O1U5ieeZv25blWHInaqP8fmUZhFsTlkRYKTJ3QJ8jwkSvd5KViLn8SYhrLLUuXRSdWUSINqw3MSKPvouVOUY87ci3d+62QN8xAWejyRqv9j58ZAz+MxccigpNipA7U1JCZBa9MK6SqqWbPjAlu5kci7c01iOwoCTLu6wCwzD2v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bIhE0ZCF; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXpz3+JYwxThzU0rg5ZZA4xNlZn50+G9oZv1y4OpKId1kFUd53faa2Wd+BMtnQYIrs4NY0qg2ClK5GKO065UCF18fKTI5aELKuTbkBHx9ovhCssUxuF2JTFc4K0JUyHUZIsjRqscPEvSCqToYwCEFoPYzuMil6NIk9zTjz8oJnwDuxw8D8AKJdBRjt6CQkpUZjyMKo7GOMyZiNnoBkQsqU+2D25ASGwomFjLppyYk2OmQHXNJczatcvlAlp1UlmV0WixrKCsdIYofs1bf2497Y52nQaBb4MmMGGMMt2Cou8VqOJvVIBmUC5r9LoNBHgtWb0/0ZtxsJbCEIDz2H4Ckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNnOh6ZPM9aBsCv/ndlEkbmMGVbJ+4qjudduJko5Orw=;
 b=x1iT7t0M4eBrzUaktweHgHN8EO0v1wua3zeq9sXykSqfEkbe5t3oux978IoJhshNvyntXRs7R7DW1qstD/qwEDRDuVEX/9t9hkPs3ViETT9xXt7PIugG+bpOZvTJNIofcUnegSDMbrfcNMWIqtrSkoru6D86HN+vTRfnOd7CtVC98RiyKriVrQMDUrlqRTCGLLxuL6Voc4lj6rKKkfTQyqF0Ib9NZfLmoL+BRnmREIjZo3s8yDNwDL4h+GZhausktjQughW/zsaLclc6v2ViAE4QI7TGR3Fc1irnhBkAuMFdzqMk3dQ2DSQMbH7whXiSYxhTRQdEFLLSd9PxR32ecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNnOh6ZPM9aBsCv/ndlEkbmMGVbJ+4qjudduJko5Orw=;
 b=bIhE0ZCFgavK4vuo8HTvUn7j3D27OgwyiZCQ3NZVfVNqolAjPbzkKyQagyE4I6S77kLWyoy+sSXqHsPIe57u4y96fv2KuZVet2XbvoLqkEIW/R1bK+MeIbTQz51jh+Vgqpd/C2JCMpy5naLTFcW/oddo1eMB2IXgGWBmI/0OtIZ/j7yKd2uW4PdjnXhZE9q3zwAHsGhMo1mKowcLOtCAzr33RQ86NifYFG+S+ScZy1J/B3OB+DLltFLr76IgqSenwcOGbLay/uGpUIFNgoDTpGoWF0LkeJOsgVrGoqhZmj4mMOooT3FwT9W1auor0g3uW9SaDbq5s59V8kWKZUfdgg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MAZPR01MB8890.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 17:35:32 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 17:35:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "zohar@linux.ibm.com" <zohar@linux.ibm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Harshit Mogalapalli
	<harshit.m.mogalapalli@oracle.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"graf@amazon.com" <graf@amazon.com>, "guoweikang.kernel@gmail.com"
	<guoweikang.kernel@gmail.com>, "harshit.m.mogalapalli@oracle.com"
	<harshit.m.mogalapalli@oracle.com>, "henry.willard@oracle.com"
	<henry.willard@oracle.com>, "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz"
	<jbohac@suse.cz>, "joel.granados@kernel.org" <joel.granados@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "noodles@fb.com" <noodles@fb.com>,
	"paul.x.webb@oracle.com" <paul.x.webb@oracle.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
Subject: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Thread-Topic: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Thread-Index: AQHcq/1MP8Eq+Ikw2U2JfmA32VghVg==
Date: Wed, 4 Mar 2026 17:35:31 +0000
Message-ID: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MAZPR01MB8890:EE_
x-ms-office365-filtering-correlation-id: c66600e2-e56e-4fa2-3687-08de7a146ed6
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|461199028|19110799012|15080799012|31061999003|5062599005|8060799015|8062599012|1602099012|40105399003|41105399003|440099028|4302099013|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pTuorKx4B6N3D4+hh5yS70ntEvv9x35SKGIsQxCkzNHwG7iRUE/53c71jrIA?=
 =?us-ascii?Q?PQ1HVEJ4mgSBulOsw80Zgf4CMpR0ZpU10U021UkC0NA4VoSEfdZIzEg3HDqZ?=
 =?us-ascii?Q?Ax1joifjhNo7JaK9f5/SVRyVAzRcLRL0RbT3O8cAU8UcYEZqqjEX6fRiUomY?=
 =?us-ascii?Q?Wo/OINmoLDrn3rdMHjMt3yAXZJ8IcAZ46nZcSZpwNw65uTeHbBJ0sevPSaIm?=
 =?us-ascii?Q?52WJM4k7goToXu1PPgbE+uBLkQVcR6cxT0gykxiS/uoteU8VPDKleoLr0ius?=
 =?us-ascii?Q?9XH3QQVBxteuP/PQNhGHGi4pTfmNJjN8BDgFka9elTj2K09loj3fFQm9UJkw?=
 =?us-ascii?Q?NBBjmzS93eiYb7czooA+loiLW+MucMGV56URGIs9JJy6S6Z+yIFtQQD/RmRK?=
 =?us-ascii?Q?v9I6htvVzecSkogGGyy3dsCYAU3zNanNBCJWXQvB/+oH7lhMDHA4o8NMTi/o?=
 =?us-ascii?Q?6krQSj2BqD9nNy4wS1Jbukg1aovM7NfjICELvBFhsO/w77o/nsFRyyztxXtb?=
 =?us-ascii?Q?MVY7GGq5MAaAUtSxtd8RDJDy8DjM/rbpnSfHnyEgZMXAfZaZ4J7LHbYcwhCK?=
 =?us-ascii?Q?iFK6Qzz6tWVqdKXAInRRWxdWp92oXU8/1wYBYEE4gNGOu14cOXg3hCqXjsp2?=
 =?us-ascii?Q?o+uBgJxf/bNmFJgp5Oa4WUBGFfNWWLdp+KbLQRY9AR7JUYoiGMhkaZJcX80j?=
 =?us-ascii?Q?RoVleGGFTbDkENs2E2e2ZVTk6KOsKMgnSo+Gvdv7zNdkK5HSXNTIvhJNzCgx?=
 =?us-ascii?Q?rAc6w65WzC15qoDCjA2ki7wubN9U4KrxlunAWn1jWKTwTgSr+Kj408PzZpel?=
 =?us-ascii?Q?ZL7RdgTkS/xz9gSChbBkicop5wtir5j5aTiocFqgVolRToHdi+cHIkc5qZR7?=
 =?us-ascii?Q?2Wc0b/owHFq1+1apFPGoB+yb+2YemM4ixBj5Sfv0/rmNPtDZaavC8yOek+kx?=
 =?us-ascii?Q?IPqPiij3rZsj+luPbTh8ud/yUTjqoq7V8LKZbmJAdagTerLzq/x6JQW3g9Yi?=
 =?us-ascii?Q?hd/zC6YeRuxfFKpzWs0r0PAviuJbDpkc9SXsX6elZ9m560TuxGILXNdfqVWK?=
 =?us-ascii?Q?cNmpexY6KJX7tAiw8bDbPTeAbbDFJBVm9jpvmgEiGrL3cqL1Dl0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PQAxZd90ED4ps3p7jabXABuu+kE40OaQuTb4UIu6rwfkS08mMkKDsu5UaEN/?=
 =?us-ascii?Q?6YNAY9zLefDB7zOXm8tIrQI56wAEUweNKv7kIyZ+o0LiJE7u389yQv4td4Av?=
 =?us-ascii?Q?WLYus1Spre8earv1t47cXQRLDZ3AFwPuFW8hukXBuWCl3IbXXZXrahOpFJQW?=
 =?us-ascii?Q?kITUHmf2e5udLRqHXvw3+mCoO3zKfmawt+GZTszHDr2Q9K3LensLIyV0dkdV?=
 =?us-ascii?Q?JJq9WHRj1qWCZyOhYtTHNQC0gM+sigbnlTJ69CMVWWTbIU8M/i3IvgKdwL8o?=
 =?us-ascii?Q?5AdgOFQAi0VChd0I+WllK0UWzbHRs0gJ8YsEaewMaYDmW5IvbIoWLOh+Agp3?=
 =?us-ascii?Q?ppPYekzR+v+pu1U97agL11BAte5aHr/TSCroV9jvkxojw5txQdiEAjYnPf7L?=
 =?us-ascii?Q?rP1R0o4ZrWztw9hWhBRaANSSjaAHKNm9/jjZt2Yn0ua7T7CjB9cu6mrG55Mz?=
 =?us-ascii?Q?NZCYkmeqY/R3jSSjHe2tfI9FPclT6huv+Bo3q0Y+PoD6yMFMRgH7u05y4dQF?=
 =?us-ascii?Q?8Up3Rihw9gpb3OsTwFmqTe8qVa90P5197nbUVTjCSc7YKlFeAUcI1nkSW/ii?=
 =?us-ascii?Q?Uz3QPbKUUAizG9vEF5ryk3TddAF3KBlpOAKxiFOSc0u2KtWI50QozBpr5MDi?=
 =?us-ascii?Q?sZR0ISLu3EnTWptzhVDVtYOrXtwR9hbosDCTHXBcHQCqWJRC1TGkuVGgbmOQ?=
 =?us-ascii?Q?saU+WVXWaDVq8UznOF0C4KKCDnUAxUWi4eEkXRgvqfIZRSVp5kt0wqTeoVOZ?=
 =?us-ascii?Q?0/W6LIzknx0ylob49QKMdCicMgvTgz0d0JKgPUd/RqRqTYn8QTQeBz58N8sE?=
 =?us-ascii?Q?Rqa7+N1vjbqa1zffs6rdNhM9kO77c8ur4GdSHr4Q1lYKEjauMaFSMSzZ+kxE?=
 =?us-ascii?Q?W7M7trWFoXr2fMgCOYh1xMPpISiVKBnwtOZ0Ky4TR3VN1038tBmxIrkF9oyV?=
 =?us-ascii?Q?QsaFz39B7+kBR0vWbeYCyzFTE4zy3thURdk2UN7GDwAVON7Rw2CkQL4aTKYU?=
 =?us-ascii?Q?ORE85cnoXTz1utOM/r5HwAm3fUDaP2a00LMvLkGPB50sj59lOxwm3V3wUDU4?=
 =?us-ascii?Q?ELbDS05j6jKc1VPVUN0ox+fEgvLAWTjCI9xe6h963PsH0dTTtxO4I/YAS68h?=
 =?us-ascii?Q?PShahWdzoGK6EWpF+e61HU9cMe/eLnjXPSU0O5d7U/XBz7MLGlHXho4JE6OY?=
 =?us-ascii?Q?iQVVl03awBwwfeN6GPPEVht9Y9cxkVf3rllJeRDTdDufzjOYj+0kF4zZRLVF?=
 =?us-ascii?Q?kdgCuLti0GTMfH1BPXq4W63b2npeoppBp3t4AqJ5NOps6KKfZGRSk+g5l+49?=
 =?us-ascii?Q?27J+MTAAA4L3QoA5xrNZCgZF715YiG0Anj5wc3I7UULtgAsW+LFP10nGX1T1?=
 =?us-ascii?Q?4kPG3LgPqjV+jcEoItkagTH9EuU99omHHm4pakkx/r3/851XtfffmZ1IOmP5?=
 =?us-ascii?Q?uZfW526Ya2xn5OTqxcD38OgiSAttL2M34R7my/JW2Q8B+S5QfzxuOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E43091702983E438EB6E7E97D026EC5@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c66600e2-e56e-4fa2-3687-08de7a146ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 17:35:31.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8890
X-Rspamd-Queue-Id: 0E20020541C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[live.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-223105-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,oracle.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linux.ibm.com,linutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[live.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,live.com:dkim,live.com:mid]
X-Rspamd-Action: no action

Hi

I found out that Linux kernel 6.12.75 failed to compiled in my automatic bu=
ilds. The compiler throws the error:

arch/x86/kernel/setup.c: In function 'ima_get_kexec_buffer':
arch/x86/kernel/setup.c:380:15: error: implicit declaration of function 'im=
a_validate_range' [-Werror=3Dimplicit-function-declaration]
380 |         ret =3D ima_validate_range(ima_kexec_buffer_phys, ima_kexec_b=
uffer_size);
    |               ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[7]: *** [scripts/Makefile.build:229: arch/x86/kernel/setup.o] Error 1
make[6]: *** [scripts/Makefile.build:466: arch/x86/kernel] Error 2
make[5]: *** [scripts/Makefile.build:466: arch/x86] Error 2

Upon searching a bit, I found out that failure of this patch to be backport=
ed seems to be main reason:

https://lore.kernel.org/all/20251231061609.907170-2-harshit.m.mogalapalli@o=
racle.com/

Looks like this series itself was not properly backported.

I am not sure if any other kernel version is affected. I currently build 6.=
19 and 6.12 series for my use.

Thanks!
Aditya

