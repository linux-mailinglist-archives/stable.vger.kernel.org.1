Return-Path: <stable+bounces-152692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD17ADA972
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 09:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553C67A2F14
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 07:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637E1F4701;
	Mon, 16 Jun 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b="JGFxqqam"
X-Original-To: stable@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020098.outbound.protection.outlook.com [52.101.188.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201D1F429C
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058916; cv=fail; b=KBGlzg0ro5l6WBh6KAWs0ZzayK5ifs5SDK6D9GkF3sg1ss7NSFFqw8yOqEFpM12ESL6jP90lWlQoYq3OunF6s92q+WJqhe0OVzZHpPWC7GRMOxpAfWPCoXo4L78LGm98nq4SW+r5hiWdR1Ar0lrSAZ7RvKTCBctn6lU12zAIkXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058916; c=relaxed/simple;
	bh=wNgRMEJnEl4P3PVW2vgNDWUauFbYH6ptmGE35ujlltM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mrXMlwFS70xqwPWr1WuVcXRE6dYWz9IrMA4kG/AjhoZUpj8Ue93tke7iy7iw4HdSmH8jDEVDor5pCd2PX57o4YCf7nyghcK+/O5DK3WDPX+PaeyKm/xWygBFxxQOq3qt2dMBdMUDckaS0yYdPmT4R0yI3Q0uMeBp3cAq1bnhPZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com; spf=pass smtp.mailfrom=konplan.com; dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b=JGFxqqam; arc=fail smtp.client-ip=52.101.188.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konplan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O65jNquZtNF9tHB/iFFqdHlVSiynMPQyNweZVJTr70F/Vt1VRhGx4LU6MG1/LdiquySHxbA8gxMGa+8hsptFRvvvZix8YTBsxh4xhwpdlIZha4vEUsnqZMCXnuuDFzHSQHaZocrZdGutbjCOcakUAgh07MrNge05rFAULHRqLNDPZd5rVHjFs4VPRVwWso7f5UJvnpM7dCTag7lmMlWjtpLZOoVuzK/8X3u29v70ZDhjFZ2n8R5NkVmDfhFH3nW0tHGZGGw7J9lFF0yFG5zRy1im+aWa9JJ6jbhmM9dBY1xpZvktPYYh5jkqfbf8cpGwsPJytqAqzGGaCQPsOIOKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNgRMEJnEl4P3PVW2vgNDWUauFbYH6ptmGE35ujlltM=;
 b=oZxKF/AeZSCe0MtSjgkKDvSklpCKcJmO+ePp+0eQgzXtuWXhjYNq96GU+JLA8b5FE8Rly2ymYTYkPZb2CUCwDi6o4o+lwBp/D0qy2U6ccrpEIbsL3saNHU1ZXPGTzm54EsoDCqe31Wu6OC2O8NXBkkLuG6vWhcIvMHs4jUliSq8bgYnMfBiBzyBTDQfMI+VILRxYXaFOSgiumi/EbvIBKpQh5BCvVsqRylwn3qFXIx4Ljaaz4evYJiNYd0C0F0JcxGkpcFOeSfdJzzcCaOV2rkLZC62OKj9F0Hz+GaEBCQj9aZuAwjO+XBysw8BXWNs1eyeoRf7LYMOJ8mKexMf86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=konplan.com; dmarc=pass action=none header.from=konplan.com;
 dkim=pass header.d=konplan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konplan.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNgRMEJnEl4P3PVW2vgNDWUauFbYH6ptmGE35ujlltM=;
 b=JGFxqqamPV1gqTdISgeFBDBObv8YAZEFX+viLyoaKFAcEXOm/h+u7nHtHkskBnQmCU+yyREG8gzJWwFsDlqCt9l7ZzjvWRfrqg1yFn3KJO+fgS6IeirIt+Yq1sAwGAejgwzOuY6I/1o/khG78FjJwnWwGRcG56EgWatOa6yC+jM=
Received: from ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::12)
 by ZR4P278MB1801.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:28:26 +0000
Received: from ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6070:46a8:c0d3:1e19]) by ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6070:46a8:c0d3:1e19%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:28:25 +0000
From: Sebastian Priebe <sebastian.priebe@konplan.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Topic: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Index: AdvekB6VDQOyY8zdQ2OLKqU1kdTP4Q==
Date: Mon, 16 Jun 2025 07:28:25 +0000
Message-ID:
 <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-bromium-msgid: f6724ff2-4854-4f6d-823c-97a2e2d5f5ed
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=konplan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0974:EE_|ZR4P278MB1801:EE_
x-ms-office365-filtering-correlation-id: 093b6953-f928-4279-7095-08ddaca761f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TnBS9bbQyk1aLBY7Hcx3bSsnak9N96SY61mIy3iBkmBJ1RsB0p3aZ0IhOfCG?=
 =?us-ascii?Q?rAWPuVxENxnJCRnxa+htg9OAumvaq81CvKSVsfBeXhu/TyIggm3xIZcbcQe0?=
 =?us-ascii?Q?eGbduakXIPAh0MAwTK1+lP9f7/FZ0V63L1l5d3qsTytpfrsORBrD98yAOvV5?=
 =?us-ascii?Q?B22Z6bjpeZbVSF62TOBFsEejqU4f91gLoTvJODm4oWZtKqPw1cnfCJmSlFRy?=
 =?us-ascii?Q?kT4RH4oc9QhHkuahf8dFL+P1yZ7ECbViLQky2hNCVhNgpLeP55ZRDKc+a+T0?=
 =?us-ascii?Q?5gMsxH7HeUu4AhMi3m606EijlW29XGfYJ3EHPjqsBirFkYKUZUAgWVcHGDlF?=
 =?us-ascii?Q?5W5t6RgcH9EqKHiGJTUZj3Kqbg7VXReXXLTw0vgx4XsWNYRxk9uYA06aRedB?=
 =?us-ascii?Q?pyRq3EA7SpPlcferj48mQ1FQTd5rfQm0ysNXyQUEB89LOkiNy5jMPgQa0n5W?=
 =?us-ascii?Q?UxQEjok9oMoR9drEMdvsxtkVL7fzodCLyZguxXxDF/xKEge3teK8SlHGE86e?=
 =?us-ascii?Q?Tv1q2HQiZ7uDh4MCw+HUKXwpydoYKFe0U1ScHP9oqZAMHlhs5r9WpiDspz2v?=
 =?us-ascii?Q?ZmdkVSalikhryqXeBNnhDGc+TsWqHQ9hQhKsDsswoxyQJp2dvfUbVUHkqLZx?=
 =?us-ascii?Q?YNbhEDb6fprnEAEMho70F5FH5Y+W1iiBdQaAKHnhsmr6gS0DRv2kvREOESj+?=
 =?us-ascii?Q?jR+nr6d3vXkY4gr957BtVQyhaFj6TgKYn6mpe7VtcBYbfriAIP9nwNxEKTyA?=
 =?us-ascii?Q?tiMrDuubKCXvyvyyr8uul8MT9PhSzwYIOc9sE8PH6hIglDtlY7RHNSrwIbS4?=
 =?us-ascii?Q?MueRbMF41b7HZHrHHqG0avxvQZlF4Iwdm2pYOLtAt0xh14BlT5BjDw0hnJwr?=
 =?us-ascii?Q?JsFBJy/RJ0hotQhikkGOsoJPirr4rtTfn0nTKRxVelsUTNOENGyP2qTnI79J?=
 =?us-ascii?Q?leog75OxlidgmHxstNNRIr5uFm+pAow1wvczjdTKEbZ9sqApAywceWWg4iWv?=
 =?us-ascii?Q?UuhI5YHMSF5Vc6T90MFMfKcI/TD9aPww4hFHbwixuRis31663CQRIKE5aliP?=
 =?us-ascii?Q?lFb84EubXrPM7WqjIZHt2kzka7NOMkQiMzgTtEURHDIXRn79QXXDmyWurZZN?=
 =?us-ascii?Q?dKsj+hpCr1a5hAjjCP1UmAEEsTS8QO+UE+h5LAdo7iJqA7tAqsymlkr67yMp?=
 =?us-ascii?Q?Z4NhHes2ZajlfekHQHidXLlNbrCA4rsJHxRkCko0kTzbgvJm6Y0TToa0u847?=
 =?us-ascii?Q?oqn+9hWBBLMdt2/jfMAtFeAft+bIvOjSR7c7iMd9Mr/B6Vlx5AZJrYbZ6ewR?=
 =?us-ascii?Q?xSrWf8iiKarsm420KrZeR7gEBGBffCXZqlBtcdTQVjt8MvApTStrtK9kpslc?=
 =?us-ascii?Q?qJDQ2sdTAawZljtEcmlcbkJk3BhWxeP4Nw5vBgtYVRltYyzWHqH/bmlxk9Xn?=
 =?us-ascii?Q?9En1uTBIIylxmlK2Vj0/+PX3UHBHcKadn8HZkpeVd8pg7PSAbBpdWg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rJLbfNKrgp2kfbY/SHIZmIyDpk4ECASpFCfeVgHtBXFZITjBHxes85ZqLLn/?=
 =?us-ascii?Q?C+rl8FZnJWJhCTBgt0Lu2yXgmOZ09/ObsOEz821FUJAzj0cZCyETgSTsmtvE?=
 =?us-ascii?Q?KFFEEmZXqirqwNgAyCqrLfnOORBc49tD0xRcNWjH/IXa5rDaK+HywQ23snZ+?=
 =?us-ascii?Q?i+Xiytaj5KrP9EmjQlU9BMgWr7nt6s0TZHGsu1jlXwjjem+jMMk/ilE0T9dz?=
 =?us-ascii?Q?Vev9mg9tQD9M8YTm7HJ6OR030bhGoj9cTbngto/LYIE3oj65sy6+9yuQ5xi8?=
 =?us-ascii?Q?UHpAyGBtJ2hYcCiUcXjhHrrPcwnBu8SVeeLY/tTQ3Fe9T4h8P1WYhW5nO+dw?=
 =?us-ascii?Q?yReM20TBlyl7WG8iZzBOQQfutDyP3w9+E872KM/LnIqfT4fwLVeiQaJO/Egp?=
 =?us-ascii?Q?4rZS9h/lL2Cm1fxMOD00AVO9hTiHC6YzbPDRq/qs+BcToilep8TKGJDDO1dY?=
 =?us-ascii?Q?BR9i/9DYml8o6Qemij+a5zNQ12AaKPxDYPn4FyUhRFhgoJQRjC8K5R9p8x44?=
 =?us-ascii?Q?x6rETIym7L5iy/Dbk9r0S3+a3hj2U+OfxMlGP8W0Yv7bX/28WmQ56+/IkguC?=
 =?us-ascii?Q?HwZN/0mxExXfDdB88ZYdeAkgO/0Uh+1D5JmcQLtx14O37EWtMMZ6EioEQKxd?=
 =?us-ascii?Q?XvxCBELwBMKCgtSDgBT5PtjXGHUJD/9mN1XX3uU3tBcv4sFTFwbQWjB2w7Me?=
 =?us-ascii?Q?xtMjgqxGVmR+QNdKMPOwYcFgsF4Z63L5XRXGbaxNMLA6NMg263a9+Tmg99N+?=
 =?us-ascii?Q?Facan6A5cVGLb+nnG/TaQJC/SuCAI51bUK8GpoB2hAFPZtBouPM99nziBnTl?=
 =?us-ascii?Q?KS6ekb7NfuP3vP3ZQVJ1ANGc4MFODMfz7bjhAH/8VKAKAuY7tHy6u8AbCmRD?=
 =?us-ascii?Q?uySdOaI04ocabeC7LjP5c8FL1WmXLX5kMjBvfFpqooeGsRu3BsuW69+RndrA?=
 =?us-ascii?Q?5/FIOMd6oaj5HYK82ZJA3XdT+WO1LfSaq/F3lszxDmMKyr7LqcljX338u2oN?=
 =?us-ascii?Q?yPI+WBH+wGx1l0N+L2Ovf3hgItbFR5sA+h2ety995vkjCieQrhAk1B+D+p4V?=
 =?us-ascii?Q?0JvaC+UUsQFWpSnlBMYdkNcb/W2yx9QJsZWvE+lFextr/jCNLv61K/IuepZC?=
 =?us-ascii?Q?5s/PJMSaClllJqmpWFmlN1tHShlC6yKpRqzlx7AR3t6Rbnn93z9R0hhYXRwA?=
 =?us-ascii?Q?VMyA9GwHIGdoS5iIsksrYBjvZsgqAnPPoC4Nn5T7GladgARSgyb+nRzs8pU8?=
 =?us-ascii?Q?PiBhPb6wrm2hUHXAEZC9pGhTU5J8V0WLe12QuFR3d7aptuW/lSYUMQwSC4/Q?=
 =?us-ascii?Q?31gZpSGvCP5XCECOXARPOwQwRpbMx5dd63JAgPkfwB6WI5OzFp01IyaP+RwC?=
 =?us-ascii?Q?aBD0bU3yyR5q7kGaYy/BNCuVnMearguT13CqX3IOQrPGvTVLVt8+bgMYA9HM?=
 =?us-ascii?Q?Su0+z25gYiJshSZALmjwT9K6hzBasBU2Qm9XQe+RPvyHHo1XuEKEO7024tUF?=
 =?us-ascii?Q?79BrFwlFf7BibAsRlim8T0r3gZpZYcJG6DnZr2t+DVvJF/PzXZyoVuyTPxbt?=
 =?us-ascii?Q?kS3u/YH9Xa0y+hgnrSA2G+XvCDQQBG6CZFszR+KXhc/tM+4QiRna/IcBwRw8?=
 =?us-ascii?Q?+/ncKqGhmRpvfOfFkLuZDYVKYsh5nIUtFAqnchVHoraNJpVSNoGeilarpuU9?=
 =?us-ascii?Q?kBMCuw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: konplan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b6953-f928-4279-7095-08ddaca761f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:28:25.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b76f2463-3edd-4a7d-86dd-7d82ee91fe05
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUpG/wr0svXIG44fQcrZBR/HvyIhqE566N3IXTcnM65SecGnTFRgaHX1N2eGzncGXmibUSMb/+8r05XHsmntuIM94vDptm09rOZwDOh2Jr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1801

Hello,

we're facing a regression after updating to 5.15.179+.
I've found that fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296 (block: deprecate =
autoloading based on dev_t) was merged that disabled autoloading of modules=
.

This broke mounting loopback devices on our side.

Why wasn't 451f0b6f4c44d7b649ae609157b114b71f6d7875 (block: default BLOCK_L=
EGACY_AUTOLOAD to y) merged, too?

This commit was merged for 6.1.y, 6.6.y and 6.12y, but not for 5.15.y.

Please consider merging this for 5.15.y soon.

Thanks.
Sebastian

