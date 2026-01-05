Return-Path: <stable+bounces-204625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE04CF2D9D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 854453026F20
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FC33122A;
	Mon,  5 Jan 2026 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sR8MYo4f"
X-Original-To: stable@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011008.outbound.protection.outlook.com [40.107.74.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84177331215
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606184; cv=fail; b=dU4D98aVjYIb5u9HyGZ3Z52bFDHsxXoXUG6jvAzSoDRuMw8mOF1Eai+M5fow7K4xN58CBT1ndx44j2PqHLpbbbrDrmCVTL+D9DmC+DRpL10BhkKWGCnrS4Z5f2RulhXfJsZbT798G3fyqgBzk8KJ9SYwkiIzaE3gjnTAwrOyXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606184; c=relaxed/simple;
	bh=SXWV6HdE5tZcYOJt9K6fs9NiKtt1gvLfKUfzrR/aRRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Piuav0wtsYPxOzhLu94Ya+1tNi2915SCc13IK8v38QJs1CBkrVmdvG5rJKQ7kpadOQRqmcH+LwY7gL6AJ4+oD753jf3ekLCw7Ji6x5IB1ZDuVNI2vYtngUEMX4LYkaFcaAYCY+i7LxIaqoX5jWtJ57K+7Ghr1V3oAzzRf6fvLvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sR8MYo4f; arc=fail smtp.client-ip=40.107.74.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsPNa0ojwsbk/LZi426qcfbLJumGB4AUXVyTBJvyISZxYvEPQjtHYjCNKcN8x09kLpobGLVzhaxg2d1I2TutMaawCjIVfoBHbiV3HlDzBwlmtqhGIxa90+q12QYwUfw6DCkshbmnHZAdPK0x2e5AF3hOkv2CUGSPqEosJxoo/Ny/Ss0YrqVYev4Pt+ocWAH0yG0gBmuHOLVWipCaiK/Va+q4YYReWUwu8gXYTnfCp6ST7opr/n3t2qSH2xGN5PvCEpCFwYzqQGw5KYwzMV/3/6AZ68BRdWtJNAsojEpG/x767fUSUYD9pdimaNrYg79CY5VThGVfYtcqQDv4XAurkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhWaDMrw0IhWCBkL6S26CJnT7Q7fPnw50CDRYxpY4Zk=;
 b=QcACuPppdTxhmnvTszbQngEt2+9E/fgqiUDX2meitIYSQM11LlLrnaHZYAC19wN2Zfi132ltfpJbur06/y3kjsO2TIJ7LNsdgdj9kiedHY73SnRX3/0Qy1stOL3IZglBmnrM7PDn8VvR16G8a6I5jJdH+nc1jOp3z5bSjHTjwHbQQD6HtXd2Xdp05NhN5eJf0wZcAUJV7kq2N9Cq4nCU+w1PNXS62iFqF6sTmlJPczEEMOiV2qV9l9uYCZ5cMl+9EUtej4l44UlBXTtH6N/MhPG2w/vSiIxHlbiEiLm4Cs0GXDB9Eim6QCwgeYEOjXablVzqQRrW/FodlL5w1WWdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhWaDMrw0IhWCBkL6S26CJnT7Q7fPnw50CDRYxpY4Zk=;
 b=sR8MYo4fX6SUBsM1+GKTwCJp24hqCdQ9QEbFHqm9cDhc3tMjZQccmFDY+56YNGrUt4218iZYD4xuxxXdRSarp5b6qVgEjORMz4lycL46QJINT+ybIZfEFuaM1FIFztxyW9cGoxvTIGQ9un8YJvGl+sLibxxICqYvk1EqWcJNuro=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB15633.jpnprd01.prod.outlook.com (2603:1096:405:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 09:42:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 09:42:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"broonie@kernel.org" <broonie@kernel.org>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Tony Tang <Tony.tang.ks@renesas.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] ASoC: renesas: rz-ssi: Fix channel swap
 issue in full duplex" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] ASoC: renesas: rz-ssi: Fix channel swap
 issue in full duplex" failed to apply to 6.12-stable tree
Thread-Index: AQHcfiU0ZqWfunenJEKIsqJBDuEh67VDUc3Q
Date: Mon, 5 Jan 2026 09:42:56 +0000
Message-ID:
 <TY3PR01MB113469FD169CDAC55D7F07E6E8686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <2026010507-corned-slain-8ffe@gregkh>
In-Reply-To: <2026010507-corned-slain-8ffe@gregkh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB15633:EE_
x-ms-office365-filtering-correlation-id: 8abc138c-506d-4b30-2647-08de4c3ece36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7vkZ6n0ydAcvD/4zy3MsQ8HbS8US3i3t7DuY7Bz89T7euJuleNc0F7Bs8ADH?=
 =?us-ascii?Q?dEvf85qsFBhabGxpRUmyz/RUU0B/00G94iAW6a8+6BK8v45ySzgOvVMEZL3C?=
 =?us-ascii?Q?n8/6R3RmrxEMXJxX4ZU4+pzJgOmq80vUtwTV2QSU89erHn/R/F0X1Nn+KzZr?=
 =?us-ascii?Q?LbbCh1MbWK4TFJ3ZKNtaKMA/kAJc6/FE7Qu7UF0Hq8e2YQy7kWQ/zF13dGXz?=
 =?us-ascii?Q?Mw/z5V6MDH5G7avyb2SFgH5t/HnRHZTWvQUB7a4pku5SFAgebLBD5tRNVapo?=
 =?us-ascii?Q?jAwofylTjJFffPrVDA3BfpohIpkoD1/WFMyFubbQwiqRKDL0A7dpjEzViRsW?=
 =?us-ascii?Q?vEOglJxsFqk5Ngopd+w584J5KzY88lkZGj/GP0ccQOkTfsru1n3BmodcsMtP?=
 =?us-ascii?Q?M0cQcOItOK+Pp9cu5b+SH+9WUu4NyPNpNskgpmxOS86zCBX56w30FPu4Q6Nm?=
 =?us-ascii?Q?uIdQ5gqiPHXXBCuzmP/QSs0CGlxzznbL85isMgXw7GYahrmqG7gjlgDMNuTw?=
 =?us-ascii?Q?zrNiAnYB2NYwb4eNwrfvmh5hbhaOxAjb0V0dy2gHY2ljnglHi2sj/csWa65g?=
 =?us-ascii?Q?yipzzXdBsqIj7gJaDdmvPFNdzyxHFzBwgmGJdhxo8/9cEAJc5iIVa+KXYRGJ?=
 =?us-ascii?Q?X5RFlhpcciT2E6kB7J4WDyqtDTQuFncsyXLsSs6sDYUAfuajyYcMN87YweYl?=
 =?us-ascii?Q?1kH/U2yubEKzbIAtkgHFweFGRay7vZmonMsWeKGqQwMKTOytbZE6d9r3oEok?=
 =?us-ascii?Q?X0x73SP6QWSUSpQVE5UuSZrhIDLnwEcI2IZv1hj9jzhmQTjcwsnkj+n7loqU?=
 =?us-ascii?Q?rz4+++I5A0hd0ySndxOG0FJAxdkbCSHNtNY02PV+5bsdwMOdkFNhbk4RRa3t?=
 =?us-ascii?Q?xokFGetuakgpS73B/ECe9ssVG7tYvwdtgrqJD9vL4ZPkxWt3rhX4HicCDwbN?=
 =?us-ascii?Q?GJSpdJLXJ3AbnX92pMB584+h6ET5BTR7yO6atMtZVmbLTVkdTmiffiqaPSlY?=
 =?us-ascii?Q?p+XuQraQXK1zk6O+8Ye50rWBuIGKU2T/XHPwWvxvrrwl78tGWND/h20JxgJR?=
 =?us-ascii?Q?h0a+75Qo3RzhSBDMejLMU6lHqKhGk8UKYEPyb333wmm7yQOvF57yuTVJIZau?=
 =?us-ascii?Q?FfKUa3vEZ2q9qgG/jLiKLKKELE11ufA5/ckmRl1ZO/VzNew5IqEIV4YwaTRw?=
 =?us-ascii?Q?6iswJSy7DJzp4SZ6Lg7ixc98wnQKbmN7DPNcKjDDZcJ1XhPVOdlRi4ElOJ/d?=
 =?us-ascii?Q?glCOdHFbaGqwEQ8p7t1Behe+t9koiJ123X/A2LhcyRPa1H/+fXorTLU5oVDb?=
 =?us-ascii?Q?/nOzKve8yTrNXiva97QJYMwJTwrTxWIwYv0Wc2eci8nGMPSYMCmusFBJj0lp?=
 =?us-ascii?Q?xzficBufXFvKqRC3oiS1GKR7mGYleHUtcP5eJldUGDUfrP0DnvCjv8spNMRJ?=
 =?us-ascii?Q?5BSQ4CRaZ9xS+hG/c/3m7K9BbPcQJf4qfJkoqN6z+AK4sJDqJQ4sm3Nlcd9T?=
 =?us-ascii?Q?uY6M5AOkNEmrTWKp2dwdbCLCUwpKvaQJx1nJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kfWugCjLu49aroeCxOt374pf40sREvYd8lbyaTdUTXvtNU+pVX1kHi4yQEZW?=
 =?us-ascii?Q?1p5JDHnHgpHYVXJLJZos7GIR5AdHnTclBh0NA6h9oeYniVVo5vrzNsymUlio?=
 =?us-ascii?Q?KoSjCpp+qroAkxIBWYmwjpznGx4hsUSQa23caJ1JMhppeFtIZGe1hzNGFt5T?=
 =?us-ascii?Q?kzkA4H49r+ZmcKswL76ZvyGuUS7/+zrKQn8yq2PiGjBITpg/Rc8O6tdjFFh2?=
 =?us-ascii?Q?8/u7ixbKqLprxSDkIVsvIK5u05mjOQXd6JJ2C1Ikq6LZRQh4GPJHdSeA5GCZ?=
 =?us-ascii?Q?M9RGMGOUo9qJdqiKXPLkkMypmXg0R/857B7UYPYFbyqVupYY8lR9AVLLev+E?=
 =?us-ascii?Q?s9cYYRmhUxiJgrI30xxoxYXypuT4rynGiSQJtqX8n9dy3KPaGCwfI14za7hZ?=
 =?us-ascii?Q?bdbGEA3YTvE6yAN8lnCqtuqJEt+L9aLMkc0+Kvc4xpYmyRm5wDuPK6vSMe4o?=
 =?us-ascii?Q?udwCy2SwGUBmHTW3d2w42KpuLjtqvYJLQa6MH3oJD/0EsylqQHQeiNLIOqA5?=
 =?us-ascii?Q?CEfKhXZ6lY1CVH5+bSi/aPxdCxLtcL+jaXi7acsyZYZZ8CkgFtAv7sh33rtd?=
 =?us-ascii?Q?CYLWoO2OmamCEuX8dHPpDMhMjs6iLwiWtu02tnwpXLnrTFimysTYR6F+0Kbq?=
 =?us-ascii?Q?anJLvAF9KiW6kbnrnIJukhyUARe1rp2TfHG0fcux0t7m7PV4nXo1m0skutLd?=
 =?us-ascii?Q?avzdXUNn/BgpNjTJRHtBNSZEtGRDTlVr/qzj6WHSGov94DbZe5AdGhvqT3eC?=
 =?us-ascii?Q?Cr+U+kxj6NSFMl/Hs80rgKtD2F5Uwkm2jUZfjOczDsPr4eq662OfhDnIc80/?=
 =?us-ascii?Q?y74nVBDCY6Xvv8/fA1sL+lVRXV+wRypNTI/ru3fhdbHHC9dT42mC44jBUX5l?=
 =?us-ascii?Q?4oqS6klffQEYxEHnxfHWbqzP2FNwRzwAZslk8t5oQxFJQ3CKnvvFBhzBsbM2?=
 =?us-ascii?Q?1KlG9xElDxbBxxgNv9yZsOVoTi7GNPrkWMUju4CG2JF09fwZyWSbcn8UMxps?=
 =?us-ascii?Q?BSgC3ejRB+3gAuN6ce9WpHzr7cb8hNIBdIhq60331sQ/C0VvJJ1P5Yvk1iS4?=
 =?us-ascii?Q?ycmcSUQjHGxjuISYe1MhGP8tO5VDt0gKgC/OIQH5EuMFftHKoMsZ4gSPSELF?=
 =?us-ascii?Q?FnP9x322AtXfSMCkQ/zZXC1lGXefROatKMbQzJZPLSz7bAc/ZwmuXrkR7rlE?=
 =?us-ascii?Q?VFaxcugAncnBbr3LFhtjQURdyc6BntNdvgAsJKqHBcN3r78StlQ1xJGc085M?=
 =?us-ascii?Q?AWyjCVpc1MOLlovNoYvJT2KJKHOnnXONtYj6oJWLNXvLmvnrXcNojHhMgNFO?=
 =?us-ascii?Q?XJL2GD0wojFaKdJEAO+55PzckP4r6y8rrG43MDlv9LdcBU96Z1qsEGnvZbxz?=
 =?us-ascii?Q?NEvURzmNmIjwVmitdH7ZnV0kNC9i5rEl8Aqp4X5YkXmYG6XSJBoxEPsv4J8Z?=
 =?us-ascii?Q?gnD8YRWjFQ8wWSzsL3SId6q5CwfB8QME/rQugLIf5sg2khMbrUsiE9+72HX9?=
 =?us-ascii?Q?4HS037705YsJOODfgNEXoZlLnLWOh/k0U/nTxx5EZdUrOEYCvh3SYzn5YtrB?=
 =?us-ascii?Q?a3nFy/vppTisbCIT3O2vWkdLjgEVBarYIf/LbJB7KRFTJwnLmeLo6Bo1ht5n?=
 =?us-ascii?Q?3m3c+VBtl09k2tAjR88y2FQcUNZJ2Ea3oH/JOuRU2wppiIOSAjhzsU8C3Khq?=
 =?us-ascii?Q?WU9CW4DBcKGHsJsAkZQlLh90fRVWFo5Qt7Cp4QCDNVPvWD9pLmUCNIVqZdRB?=
 =?us-ascii?Q?xpeJO25Xfg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc138c-506d-4b30-2647-08de4c3ece36
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 09:42:56.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVGHuhhnmLpWLW2vrMwhd65/ohMDkAAklcz/o32bxj9VYdo5d5XXnlSpJMj05+PiwpZcxSTBW01t8nYdC98chVdRKZS+uaEexXwjVhoRV7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15633

Hi Greg,

I will backport this patch to 6.12 stable.

Cheers,
Biju

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: 05 January 2026 09:25
> Subject: FAILED: patch "[PATCH] ASoC: renesas: rz-ssi: Fix channel swap i=
ssue in full duplex" failed
> to apply to 6.12-stable tree
>=20
>=20
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm tre=
e, then please email the
> backport, including the original git commit id to <stable@vger.kernel.org=
>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y git checkout
> FETCH_HEAD git cherry-pick -x 52a525011cb8e293799a085436f026f2958403f9
> # <resolve conflicts, build, test, etc.> git commit -s git send-email --t=
o '<stable@vger.kernel.org>'
> --in-reply-to '2026010507-corned-slain-8ffe@gregkh' --subject-prefix 'PAT=
CH 6.12.y' HEAD^..
>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 52a525011cb8e293799a085436f026f2958403f9 Mon Sep 17 00:00:00 2001
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Date: Fri, 14 Nov 2025 07:37:05 +0000
> Subject: [PATCH] ASoC: renesas: rz-ssi: Fix channel swap issue in full du=
plex  mode
>=20
> The full duplex audio starts with half duplex mode and then switch to ful=
l duplex mode (another FIFO
> reset) when both playback/capture streams available leading to random aud=
io left/right channel swap
> issue. Fix this channel swap issue by detecting the full duplex condition=
 by populating struct dup
> variable in startup() callback and synchronize starting both the play and=
 capture at the same time in
> rz_ssi_start().
>=20
> Cc: stable@kernel.org
> Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
> Co-developed-by: Tony Tang <tony.tang.ks@renesas.com>
> Signed-off-by: Tony Tang <tony.tang.ks@renesas.com>
> Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://patch.msgid.link/20251114073709.4376-2-biju.das.jz@bp.renes=
as.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
>=20
> diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c inde=
x 81b883e8ac92..62d3222c510f
> 100644
> --- a/sound/soc/renesas/rz-ssi.c
> +++ b/sound/soc/renesas/rz-ssi.c
> @@ -133,6 +133,12 @@ struct rz_ssi_priv {
>  	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
>  	bool dma_rt;
>=20
> +	struct {
> +		bool tx_active;
> +		bool rx_active;
> +		bool one_stream_triggered;
> +	} dup;
> +
>  	/* Full duplex communication support */
>  	struct {
>  		unsigned int rate;
> @@ -332,13 +338,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, st=
ruct rz_ssi_stream *strm)
>  	bool is_full_duplex;
>  	u32 ssicr, ssifcr;
>=20
> -	is_full_duplex =3D rz_ssi_is_stream_running(&ssi->playback) ||
> -		rz_ssi_is_stream_running(&ssi->capture);
> +	is_full_duplex =3D ssi->dup.tx_active && ssi->dup.rx_active;
>  	ssicr =3D rz_ssi_reg_readl(ssi, SSICR);
>  	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR);
>  	if (!is_full_duplex) {
>  		ssifcr &=3D ~0xF;
> -	} else {
> +	} else if (ssi->dup.one_stream_triggered) {
>  		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
>  		rz_ssi_set_idle(ssi);
>  		ssifcr &=3D ~SSIFCR_FIFO_RST;
> @@ -374,12 +379,16 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, st=
ruct rz_ssi_stream *strm)
>  			      SSISR_RUIRQ), 0);
>=20
>  	strm->running =3D 1;
> -	if (is_full_duplex)
> -		ssicr |=3D SSICR_TEN | SSICR_REN;
> -	else
> +	if (!is_full_duplex) {
>  		ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> -
> -	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +		rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +	} else if (ssi->dup.one_stream_triggered) {
> +		ssicr |=3D SSICR_TEN | SSICR_REN;
> +		rz_ssi_reg_writel(ssi, SSICR, ssicr);
> +		ssi->dup.one_stream_triggered =3D false;
> +	} else {
> +		ssi->dup.one_stream_triggered =3D true;
> +	}
>=20
>  	return 0;
>  }
> @@ -915,6 +924,30 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *da=
i, unsigned int fmt)
>  	return 0;
>  }
>=20
> +static int rz_ssi_startup(struct snd_pcm_substream *substream,
> +			  struct snd_soc_dai *dai)
> +{
> +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		ssi->dup.tx_active =3D true;
> +	else
> +		ssi->dup.rx_active =3D true;
> +
> +	return 0;
> +}
> +
> +static void rz_ssi_shutdown(struct snd_pcm_substream *substream,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> +
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		ssi->dup.tx_active =3D false;
> +	else
> +		ssi->dup.rx_active =3D false;
> +}
> +
>  static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned =
int rate,
>  				      unsigned int channels,
>  				      unsigned int sample_width,
> @@ -985,6 +1018,8 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_subst=
ream *substream,  }
>=20
>  static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
> +	.startup	=3D rz_ssi_startup,
> +	.shutdown	=3D rz_ssi_shutdown,
>  	.trigger	=3D rz_ssi_dai_trigger,
>  	.set_fmt	=3D rz_ssi_dai_set_fmt,
>  	.hw_params	=3D rz_ssi_dai_hw_params,


