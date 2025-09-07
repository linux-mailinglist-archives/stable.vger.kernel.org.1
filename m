Return-Path: <stable+bounces-178033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD7B47A54
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 12:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA0B178BDF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32B23372C;
	Sun,  7 Sep 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="tR8N+4Mo"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA4315D45
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239470; cv=fail; b=C4AFkPqmyOlWgBi20lr91EkYJP8STggcDSQBvgJX14eEANIUbaXRmfCtQP9jF/ycHlRcwd+uVBdTF1pNIoh4SQnfeD9haQmEof3tMcMyC3tS4ZHKKKGSkoOAZ7gEfKBxmd3SMDcIRwIMeL2Fw0SkAOW8jr1FBba69JSRNLkPtlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239470; c=relaxed/simple;
	bh=Rxsudxjqbvz+2dhpWfHoW8FHmtlsz7R5h7Xx8Bsq/nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tjEet8Y3Frpkv9ohuBionhwy6u02uyxSaGXgI0daR7dSuKN7Gul/b8tMQ/lTHO0qPutNjU0zH62USOiB91m9cEGdRFB/EqA//LPpC1eDsgYdoVoR0jgN7/WqST1wVzlmtmMY1IOgyGlgYpfwGMJHfObhaWkrE44hCLMqGFZ11tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=tR8N+4Mo; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757239468; x=1788775468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rxsudxjqbvz+2dhpWfHoW8FHmtlsz7R5h7Xx8Bsq/nw=;
  b=tR8N+4Mocxc6fmJxl7PbEhdf0qXP5vSi/ZjizrneKovIgY9Gu13rBQ2t
   KNIdCbim9p6nLi75ltJnFZAv4dxfNdWZRGVjIvmOSr+eKEJKvYHGQXY5j
   z5WpLpQq5airO8uHAAh4DUXsZFo0TlNdhp9FWlnD/wCzhMQX/dXVhc5uv
   aAxFfYsgQ+LM94TqI9mZQ/jdl4iIZ41kr2hlQ3xznPrcDD+RvZHPTSm9x
   islFcn/LzZgomvQsaBnFbgbOLyaIfFHuUVOGqAYhpQWlrHfZeYMyjIksr
   xgcQ6iwr2lTn7uTJzGpsG4rhwQvSts+9613wxUCirI5RE6QwDvO2V5I69
   Q==;
X-CSE-ConnectionGUID: 3Ayz/grYQPmJPxSojUWlfA==
X-CSE-MsgGUID: MeaSgWcvQcaoiO3ucW5bAg==
Received: from mail-sn1nam02on2117.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.117])
  by ob1.hc6817-7.iphmx.com with ESMTP; 07 Sep 2025 03:04:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH6beUzmq+0GoZERT4cz950SR3HZT60ZfOrM63LJeEeL2X/OoutMPLMd4hTVdCiGvL+txYw2TMx0x+DdKjM2HVy3ukVRXmm/JGakSYOkui/HsTregh/bN9FH6au+1JDip3eWmFkDrif2RGbsfbOVXwSae4t6zG5NYGQeW+Enc/ffluqCKGipU5lLXn06g0fI5H737nOBdxFXIa1+I6fGZQv4MMCM8NkRDA8q8YVH/bNRwpnNj7UCpHPfgr5oxCQQeMOgOZYcxrkXxyH/SWbeoxn8GBVs4Q/O8f3et1NqkRGc0ilh8iP1XEQJOoncRQbUMKikWL8kiDYGRZO5lam+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMpIjJbCWoFWk5EbLIvBCLs2Fv0eEOyNCIhf4rvwemM=;
 b=eWssi/xgg9frSQIuDOc5fBS1g7dhVQCpTCuskmWXujZcjhovCtDLrHlI/rd8RRsuBaUdrYQuYtUK+dTOuFKxUTF1CErYR55jnKm76PquXSfyx2NUb3H4YX2GJdsX48mg/bD/h+f3A2Tlnkz8uT4WSN43D2bG9u2kli47UAeYUJ93dBB6Lc9NYtZojGq9etnTV/mzyppWImwrmuYzhjBH76E3oeDLx6zRaNidXisWQD1VsFnqYfhRMM3EWn93DyyRGDrU2o9eD9RD/Epil3IGb/Q3MJAhSFwihAUUOKZfYl7lRN35C2WNLtMTJa2neSlQWIibkUTuIqF/UrC+mSkP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by EA2PR16MB5674.namprd16.prod.outlook.com (2603:10b6:303:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sun, 7 Sep
 2025 10:04:18 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 10:04:18 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Emanuele Ghidoli
	<ghidoliemanuele@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Jonathan Bell
	<jonathan@raspberrypi.com>, Keita Aihara <keita.aihara@sony.com>, Dragan
 Simic <dsimic@manjaro.org>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: RE: [PATCH v1 1/1] mmc: core: apply SD quirks earlier during probe
Thread-Topic: [PATCH v1 1/1] mmc: core: apply SD quirks earlier during probe
Thread-Index: AQHcHlZZE4NxF0w4r0mwpZu/zz24erSHXskAgAAhy7A=
Date: Sun, 7 Sep 2025 10:04:18 +0000
Message-ID:
 <PH7PR16MB619686B2E04AF241DB797DE0E50DA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
 <20250905111431.1914549-2-ghidoliemanuele@gmail.com>
 <2025090705-rumbling-twirl-81e2@gregkh>
In-Reply-To: <2025090705-rumbling-twirl-81e2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|EA2PR16MB5674:EE_
x-ms-office365-filtering-correlation-id: c84879d1-5c4a-4164-964a-08ddedf5e8bd
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fqgcA8mDT6KBPlss/VzYT9kKfn1qG3YDTF6iVr7HDDPOvNU1sZ6i/cg9Qo9T?=
 =?us-ascii?Q?INe8a69XJ2pTrImnoANTjotvDngeYWt1k2Qh+EalMbbzlK/pSLaY0dUeJBhc?=
 =?us-ascii?Q?XKGRhUVRiO8b8jRk6bUMuagTAg5/f/gdn1rF5l64j5Pfgd93LUusaTWbWwAX?=
 =?us-ascii?Q?17U4J5fu08KNBBsGvPwCp/uiIn02Q+82AM1FpaTlo8QCcvtNZnayX/U7y99k?=
 =?us-ascii?Q?8df9nVYkWsqQxgfcmkygRQD91hyxUmWLptjAlUJdapcIgIWodXCpavu/aYwi?=
 =?us-ascii?Q?M5UJhJ0bSvCC4uzJi3Bea7RuQ9UQGhh/PjcSiu8fnLzse1CnX+Omp/iiNoWl?=
 =?us-ascii?Q?/XpPNdc9n/Pp6f6ZbHlw7yKl6uYzim52Zik4h4wHrg7kkP/WyAdOzWwlB+K+?=
 =?us-ascii?Q?L9NwD7fdCVv1cIaWBn8wyK8XOyR0ASvj5ab1bNNheMCfZqqrZtggN8dQ+Som?=
 =?us-ascii?Q?dp0DcUYTvc3I85sYbOKG8ZBU2eGVFrDOph2x3oxWRv/jTGaFA/mc0bH+DO5Q?=
 =?us-ascii?Q?dWt+rVOG2tvNWbFlEOye4hA8N3wDUZtjFdCjxlkXHOiqz7+gLll2lyNyaLiL?=
 =?us-ascii?Q?VvXLQDLP4Lam2zLeor7CpHZcoDNcr6Td7F0Kp/+WSF05TAP3j5c4/at+0UMB?=
 =?us-ascii?Q?XUj/0YP3/rqi9KopcPCJWqzjPJYVjKMfePmVlsVlHXwaiOofnwysADk6N/2P?=
 =?us-ascii?Q?7aKgQWLNn+SYXti8F9gQyiTVTjw+aKCRX4FFoBqgsF3L9BaRdlnfNMN0wFoP?=
 =?us-ascii?Q?KBcAoue/ZN8VC08QnaWHxaXE8KcqMP8JD9zQtAci5YjOfNBziEv0/YE+zzs0?=
 =?us-ascii?Q?Xo+M/5JwiPv7lSe13RDkM/44c2CgesbaOqTLlzDcLLvbT0/aUuozC9ojUtlm?=
 =?us-ascii?Q?6pHCv/hra3+cbxhh0JpQNs12P1804h7Irsx4WKTQk8C0RAF4/F9WYjjs+cNz?=
 =?us-ascii?Q?NDkkEi3WY5U7rv1djvSePi+Z0fpdc9QEO1xAe1OBsjyCJVw44CItxvNR6vsw?=
 =?us-ascii?Q?9qD0sxr8IXO4CSn2nKtyhIcPtKr714wBgaI7MHsyOP9yCv8JqvS+Sw000GWu?=
 =?us-ascii?Q?wMe7JdKE0Gy3yf7QR3+Toy/b1EopgSwILQn+12BumtUc+bJ1yFCx6glOKy7O?=
 =?us-ascii?Q?HouPMjOIuOMzRGrkInl2ulOPVNjDeq/bNQ7H9vgzGels4pdgLzVd64T988R4?=
 =?us-ascii?Q?cM865Q8YAO0Zmdvn9CmqROpWoYWk7ZO/oc90lqz4r6Dwah+zbH+hMxB8GUmI?=
 =?us-ascii?Q?SHkkO5uPLAMRbAoW/oW7exkXR7IFaMKx6xGxVaCeavzUbXV5S96mU1ZwVc+y?=
 =?us-ascii?Q?gbEw+DR4L0H0HXhbCFqXFRovVZaicZVev25VXOyO2Lde+fMk3n2e0wpCW1iD?=
 =?us-ascii?Q?AWRXp13Nf/H2zY2Wc7PO66ThvmuqzHUwyXq3IubRHULvYUHLAmmIg+e4pXb1?=
 =?us-ascii?Q?OtHWy+u1xR7+SffEfeHfgqx+XNSH6GmSnPhdseJs0zMYx0FHexsdh0d/DSvE?=
 =?us-ascii?Q?AwCkGmaMlUdcuCc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Crdiz0wRUtbMOeRA2u+/BxknnuX6/sBAAgwwweKNlLAg/kQQ3Eam5kXWw+AN?=
 =?us-ascii?Q?5OZnqNAHTIuVZnrlkzeRbqDnLvPEGRFc21Q9ZgQYzv5knLWl/cpEgtDVzGpv?=
 =?us-ascii?Q?ej23ApheMIVJh+Oa6Q35AWMHvU78ZN1QDgbdcUztEzBjsEupCG23Hpy7nbdO?=
 =?us-ascii?Q?21Gz2yTD+76vUonvRM2HzDsOsTbI0/lEyvTDlEFiy3dgTarOGnj/+IspV3KN?=
 =?us-ascii?Q?t+X68I1NPPnyaXEu2VvrPFygeGFD/V39L+4HlOzVdYMqSYhJBUY4oaJJXqLV?=
 =?us-ascii?Q?UJeNLOyPnLzDKbKqNI0k33I1Fbmbzoh4i3YRGWsGycMYTGzLMZJ/++uNpex1?=
 =?us-ascii?Q?p68n892k5wKvpjTn0P5ln4O1uaFYOa2O1qAeG3NKudpX5PP60tKzDMA7CHZL?=
 =?us-ascii?Q?UxsE7EQqCGqPNKPF0VzRWEzv5nNl0sDKZColt10bbHEkDgh6Qh8kYlkmFuvv?=
 =?us-ascii?Q?RFx1xGXTkpwE0kz6vE/fyrgYjMdY4qtZHvgGYDftgb6Bg2l2e+xjcpo28Xv2?=
 =?us-ascii?Q?aZ8pK4TiJr3ujW0tc59tfPTYgthcvI2C0trAOEYRya5hJ+/Ovd//Lbtv1wVd?=
 =?us-ascii?Q?7uMq4bLhxm+zgNWzpEk2f8WhPRohEluxvJXyGjwgCRmgk0fI/5WR2vDRgwVd?=
 =?us-ascii?Q?CLhdWSYZaqLeqnNYgXkN2MTkV1T57SvTvUHPCfhRNsN1FgvKIAEnxJw4b/7u?=
 =?us-ascii?Q?SeR3xkjzOBTxLOqrwpYv4aSgz3kUfZpi5s31F0PFtuIA0NQNLCKeY7oDB/JJ?=
 =?us-ascii?Q?g4W2RNBOHa+GOnv3CTEgp8+WBvL4qOnB3SEIlr873VN7vsfE7Mg1DC2QTH6y?=
 =?us-ascii?Q?FmokqXNQ3cy2QpXmab0lAIrnIDbZJ6+CUCDiTwiRYj8Gu77Dy4dLyLke1mwB?=
 =?us-ascii?Q?A7IoZFEuEKw9Yr/XQpZ/wDNYxtlsMNA/TcQQ2KqH2/324JwQIJr6cqApOVy8?=
 =?us-ascii?Q?k0kPbReuDoN7QHIUs37ivCcYvbam4Lh57i7vwCXgTrmr04gOgWNp3l11vqkN?=
 =?us-ascii?Q?ijlMSs6ETsoAUWjXzRrcJml0HOsarmttAhUc+hTLmmuFNi2wAOTI6gaFY4qT?=
 =?us-ascii?Q?9MfaBKNhMYoN7FB/L7Ue1A9zSJ5EWC7GDNS9J/Hu5zc5oPwXnDEk5uybRStZ?=
 =?us-ascii?Q?cqUD3B/Jmt95hQE/n0sqlTKBSIZrVxQJ0YnbUSTFDOMZC70XRsZesqmcpywj?=
 =?us-ascii?Q?OaJo/azMiHIwV2wpYav4sjYQc8i79c5AN20sq0VzfqBge+r8rUem2atxAc2l?=
 =?us-ascii?Q?jCywin0jF8eTxtxRp/kEC+DfiXZe1S/ihlMtPR+IVlCzbiuMYuwQslbPcbU+?=
 =?us-ascii?Q?qsg+Cd54Ixz+kxCPPnzK04hcU2w2t+46Z8IS1k8q+2trdt+A1fF6BXq7uNtN?=
 =?us-ascii?Q?XHzjjWslj/hf8wBAW0MAy3v0vldnqWUyLxiJbVH6mrCwskB7S2XTvNK49XTf?=
 =?us-ascii?Q?QAvoCawwqj9j4WDj81aPZbpoIpPE47hNG+zcJXqIVLMCj/k7TizvoBUOgE07?=
 =?us-ascii?Q?kRCXEk/VtqHXhH/3DhndoQb0OSDE5YvGIasddrAAQWgR6vsOVZgGWwVHPVn9?=
 =?us-ascii?Q?bOKITuA1VzwmvKFiTMVyzO/XVgzBYdxjALsVzHbw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l8AqDiPXwfeOlNXD4Y2hfeLcs0yg7GOHhBTVG8AbnZ1nfH8PH7umXKBNjP5kjnmvB4Azz6OkRRdD9gwPG91X+x0O0WuFiRW2hD6vWOiz0G/SJ0DrFdgR0G4H/tDbKflnOtlnVemkz+JrKHCvdZP4ZsGJtgeDNtoE7M45R/pzFA36nHI4ZEkhViy1L4fSvbfIaDxG5muPLbo71PlnG5/EefiFtHFaGHitKUjeDYyEjSziroKLrL/3Fspafip2VGAIEdRlUhJUz2zmt0XjCtzu5mvUgqvLlkvz8ITwxZgQuQcoYaIq5e8Fq4bgn9pIIeh3H5QHlvhpv05tkRHGsxnZsL+cEUHsCzbA2euDPPx76Xv2mWP6pDtZJ+icJa0ZjsqtmlPpIKaG4LdQ333nljtkRPBWZZMTlGSBNqcVBbgz0bdU8EpCsqRfO+sq8zJCZQbX7a4FzKhjanpzJkfIed4YoPKTrksfqIfQvuig20JCyAGX1IUr0deo9H1owZ4PvsRoUlR9yQBJdu4rASC+fRQdoIQ0Hz+4QADTNY+n0pD9kHXQZ6ic45q2n/W/NIU834+iPn9KDMUWp9AhYz2mZzwg2HG6ecPtxB9BCh7zTaqelNeYPvKD6dtAlqct8LuAPlY587XJR+Mvy6JhZt3XkHmsSg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84879d1-5c4a-4164-964a-08ddedf5e8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2025 10:04:18.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+CzaN7IXJS/I9hqe0W+U6VGwJ/iaGmNIa4cl3xKY8EZoyt5DJq2Xr1+mHLOuE2V/yhE0tjk9iCb7NiZidQcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR16MB5674

> On Fri, Sep 05, 2025 at 01:14:29PM +0200, Emanuele Ghidoli wrote:
> > From: Jonathan Bell <jonathan@raspberrypi.com>
> >
> > Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD
> quirks
> > are referenced in sd_parse_ext_reg_perf() prior to the quirks being
> > initialized in mmc_blk_probe().
> >
> > To fix this problem, let's split out an SD-specific list of quirks and
> > apply in mmc_sd_init_card() instead. In this way, sd_read_ext_regs()
> > to has the available information for not assigning the
> > SD_EXT_PERF_CACHE as one of the (un)supported features, which in turn
> > allows mmc_sd_init_card() to properly skip execution of sd_enable_cache=
().
> >
> > Fixes: 1728e17762b9 ("mmc: core: sd: Apply BROKEN_SD_DISCARD quirk
> > earlier")
> > Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> > Co-developed-by: Keita Aihara <keita.aihara@sony.com>
> > Signed-off-by: Keita Aihara <keita.aihara@sony.com>
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20240820230631.GA436523@sony.com
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > ---
> >  drivers/mmc/core/sd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>=20
> What is the git id of this commit in Linus's tree?
469e5e471398 mmc: core: apply SD quirks earlier during probe

Thanks,
Avri

>=20
> thanks,
>=20
> greg k-h

