Return-Path: <stable+bounces-73158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A996D26A
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664501C231F6
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565D194C69;
	Thu,  5 Sep 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YN4vjaWJ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SdT/lLqT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64759193409;
	Thu,  5 Sep 2024 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525970; cv=fail; b=uBw58bHUx10wc850aRHpR5W/MqVYc28tfNE82CKHeepHAuQPT2pl/Jrb/W5CpHMNKXLvX2gO5CNO6LUgZKw+MRbrT5afGCnu7RLvpmMk4jO98APDAVJEOcTrePjnju+216+3VD8hlIv3j1Q/yk3X3+LJ1wfLjqnjuRq1sdi0SRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525970; c=relaxed/simple;
	bh=5a2glb/NXmNhGN8WdaSbtsBhOLTgCncJVJ+ZsF4UWmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jmrswco7oz2psWgYq/xHe9kQocrjvXAuwggSFRIgItYXqXHhvcRZUo2llc1rlitBvxQdlA7C+/yIu1mAJZcxmtucgcMTUn3zG0t3n0zLwUbbbY+uzIVtvWV9m6UFne5J2jnIyGqUjRIqwCgtRqanb8qjfH56lMjH54twTPdev6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=YN4vjaWJ; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=SdT/lLqT; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484M0YTr023969;
	Thu, 5 Sep 2024 01:46:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=RE2eRKRI8IxD/ow9stc3xruOSx65H1KV6KtNgYvx8zY=; b=YN4vjaWJCuAr
	oa6VwvAoZwQhTEe6U65LJ2sUcqmXbFuCkWRS0efWfj7ijnewD7nLGowErWeqnLcT
	2k8bqKkKFfkHCVoiR8iOu8hJL4ZJnhdR3ZpP1/e5n+ZAzyDuakuTcC0XbX2Davbr
	3y+w8OmrXk4oaDZIjXmBhrq6+puIFzgfa2LwqPC2pR8Y58IlwZmuviFq4prf+Sn/
	PwufFn1u6smv2RoOqQQ2iw1xCRzfSkm5VTPo+QFFq6FoyI3S0SbjgRV0Nl9E93dK
	fPfUSReIQVUrnHSiwyL8fS28Exyqv6itUyPSt8JejlQXsacQ7EWqTa7dGvnCWyBW
	Ydjb+/KGLQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010002.outbound.protection.outlook.com [40.93.12.2])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 41bxrvh9n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 01:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3Kpnv/YROVUrNcdObcWyT9TniG3z9UgIMkm2quD5jQFtMyuchmUHFuHJ3G0z2gkVKo1CK0FXkaKr3VGWZy8GeL+FQLIbPk7F0DeEhWqsk4YCi11lLuV+pufMre1VZcQMyFxRHjrH1NYPX6hpCoki2mKucRv4WYU5YyMqDkihzQtuSfZyWwWd7NzEWX6M0Mi6LAvuvl18TikYI8PTExHS0oddoZiUT3ie+jDUecS6INPBVzbn7R5WKqVMYsGCbx25sFWUii/6mKSMKPN/HiZF53+9B1Io4IgLJ12XWrs6h3jLBHY8jqq9ZsuRwKXwF6qR0ACi+8rnEf8FD88e+HBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE2eRKRI8IxD/ow9stc3xruOSx65H1KV6KtNgYvx8zY=;
 b=rWL2n8g1eiX/2viu8j6NtQ7VZlaBwRR9bef6+1fsrV0nFbSkUyemHdxNKwZH3c6Qj6zpx88oLjWZd+QpHX4inK9u9rvh/HedfedO1pTlEG9dxrDho/D2RNQMop1nkMBGGt0Bs1BAVzm+eeXuwwINb6EY4fgjD2rJ7ShcK0oxVU2gMyICdyZCcsFJPnLxPWpt6lSN9f5+w+0oGnjGUY9D0JJ63O6pyJbMGWmLNV13duBsyYcxIKLaeV/jSvgfrGlaKlFNqaUOF+Uz7bHx48W0HU9WFjeeGrSx316grMXrfE6FuGIyNWLyWuDSOaqebotE4Y42r2V0F2BNe0BnLXxVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE2eRKRI8IxD/ow9stc3xruOSx65H1KV6KtNgYvx8zY=;
 b=SdT/lLqTgjIbFLjdfMsc91/f5pOpZx5PnR2VHVCKHkcaWb8QAyDqNhPSOU+p9CZjnELxNnDCy8ujanFXAJFTt4/2orI0GYAF3Tv/NWoxNx0poZjziPEpsQ5q78U5tz+K5rnlAFqlYhITDN2Vm5dQrkdUhHvvcM8tB6D9fsEv0hI=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CY8PR07MB9593.namprd07.prod.outlook.com (2603:10b6:930:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 08:45:59 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:45:59 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Peter Chen <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix incorrect usb_request status
Thread-Topic: [PATCH] usb: cdnsp: Fix incorrect usb_request status
Thread-Index: AQHa/2Tn03ME/LN6AkWudh1fxcnHPLJIy8/AgAAKNoCAAAX1oA==
Date: Thu, 5 Sep 2024 08:45:59 +0000
Message-ID:
 <PH7PR07MB95383CF665431DBDACD73B65DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240905072541.332095-1-pawell@cadence.com>
 <PH7PR07MB95382F640BC61712E986895BDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20240905080543.GC325295@nchen-desktop>
In-Reply-To: <20240905080543.GC325295@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTQ0Y2VjMmQwLTZiNjMtMTFlZi1hOGI1LTYwYTVlMjViOTZhM1xhbWUtdGVzdFw0NGNlYzJkMi02YjYzLTExZWYtYThiNS02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjQ2NjAiIHQ9IjEzMzY5OTk5NTU4MjI3MjQ2MiIgaD0idmZZYjhIMzRMdTBhVzh3ajRVbEpnejFHN3E0PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CY8PR07MB9593:EE_
x-ms-office365-filtering-correlation-id: 03f4a145-41f4-41de-8f07-08dccd872a89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gd4HVGWluzzAbOk5w2DzJxaK5Yt6sl7k9b+rkoivekbhlr1T3eLpBQeGSQyN?=
 =?us-ascii?Q?GbZ7oZs0m+5wxRyaijBdSrUEEAPyeGuLL6V10Txbre+VDVjutBgqV9HkCK9b?=
 =?us-ascii?Q?+ondyZZcCioCczs8l9BH+jX0qS2AOWqUDpwNHoaCTovK495fkOz/+oX6metu?=
 =?us-ascii?Q?DgTaOHVUsqhXn5Fgz6LIWvtZTNYJ2BUEexIkUXqh65HjPOkcJNXY1xTcH9t0?=
 =?us-ascii?Q?wevL6NrusfnBLAvUXTM0ymUKKKTyQh0Gd5V1WGIOHrs39bb71zaAXr/+e+IG?=
 =?us-ascii?Q?PecRS7rAZzg19Ckr7eNCUlSisbkE6LNpBhwBCfdl701pmx5hSSvh2Gnn1Y+A?=
 =?us-ascii?Q?XRdDNmsyRQsM5A1sLMV+CF+zgBdKthlFQEmZf/L8kuuIXaz0d/P07MF497Hk?=
 =?us-ascii?Q?ZnW4NCjuxUFgds7LiyvPl4EMSoRMRj6YUPH9RftouQL/VutOU2k1ln+uQ+v1?=
 =?us-ascii?Q?SCyiGoNtqYBcFESqkRvTBS43H1HZ3kKOi05xOysUjIk6lBtWabe2eMOVM/kh?=
 =?us-ascii?Q?z5WacFeMjdB8bi/WVij1eE7VVriaJxAuax1fXw11lj4ME3/4r+tO6hp38yVz?=
 =?us-ascii?Q?MYoiHC5AUtmGwb/RTPllM1ZLdVFiS1xv0HAeiDXcqgZdqaw95zCt0L+Hhxp7?=
 =?us-ascii?Q?8j7r0FzFT9xg6kRH5nLg4xIcgVFV+b48dEom9fL3c4SusLcV1SCFX7DjLmvv?=
 =?us-ascii?Q?h7FbzyY9md/SKC43mHvmeT6ewxF0euri7T4uF8BM45v66xg4OYJiPEF0gBRO?=
 =?us-ascii?Q?14hTRmkQ/2rfbVsDTjGd04MfTfG0XjJhI6dSQpOtG/G9WMYxs6F88uldOCDJ?=
 =?us-ascii?Q?RixpbSK6r4gVh2caoNf07VEjIKu23IYxfb+nICtULgdVyouByaWRGf6e7TiP?=
 =?us-ascii?Q?jTD1RcilwGtn0auzEjei1bAeSy3sMJ4MoMIn9obgaekyEX+XOUU9h/9H2am9?=
 =?us-ascii?Q?CuopDizjNa266CdfwF7QsH4z7dwM/GK+1vG33Hm048xudYhm01FQHmTsrRqx?=
 =?us-ascii?Q?6zYX6vm4ReUnga9CdT/Y4shmy9LR4UwMQ18896jjz2wpdDvp/Z+qZPOipzVR?=
 =?us-ascii?Q?+4Qh3mzEUQHRx0aUjFVKTPBK9VIcCdc7/V4p0m/+sgkR4+RlUuLBmzu96am2?=
 =?us-ascii?Q?XVDl/vcrWuJsgHXTHrp7Ng1oaNPilbfybyjviXKSW9daNxoGz/iHFhV7W8CA?=
 =?us-ascii?Q?rp8bXkM5AMvP1wE6ByRDRUBKhQbCwFZzaEx8vvPLnJrWrV3/hTvHWfzN7dDt?=
 =?us-ascii?Q?eBg1LU+m85y9wCJmIIstkKDYZMoSEYbZPIKglIf2TsOZxYsg9iuVEKU0NUIc?=
 =?us-ascii?Q?nKPhGgPDy8tsAgKFpkueBDNRyvecL36Fvnf2/vWLNCMVATxwEcljC9oapRT/?=
 =?us-ascii?Q?6n1Rie7MWdE6ycweCv+1H94yFOcQkrZMFKLRdfNruDR7E5fkTA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2Ltka+XPrNl5LUqw1ippaYQNGZxS32tghj4saEjurNM+TiTXN90Xm/RlHT0i?=
 =?us-ascii?Q?dMU35O7ofpuaCBXGIGPK5y9p34rCS7nscF9lnG8kbbarl9LPBWp6uOvvMoCo?=
 =?us-ascii?Q?cbdd42mid5hvjWPQqvQ4e5+KBaiGtyUg1ubaaBB9pvU0Pxu/fZ3Keb/PUwZx?=
 =?us-ascii?Q?Z66TiwjodVVBdORk5d01k43YCdVbJxJi/P9v0YyErSYSvHaH/mBju9L7Q2er?=
 =?us-ascii?Q?nRIWAKQAoaGqdrCpvG8KXtrWDYTy8R21/EhGd+2zCJFbnFg4gkoA79nMc1nl?=
 =?us-ascii?Q?jImaj9xyHvsmRvXwGcqiyJsMWXpxmWaeFmr4bu5Put99BoZOI0lPz9DZVZi3?=
 =?us-ascii?Q?cgiaPeI1vwl2ubUtCDeP+H540HqbZZr0bu1edlkgwK9DTPSIZVsOWX1Q7Imu?=
 =?us-ascii?Q?okY5NRFKTy9wEE/KC87RwcWGMyO+ZOryXu/boL1VpnHQkwsrNloZpeje6PSD?=
 =?us-ascii?Q?bvq1J+stU4Xn/yqffb0HiBsVJ/1DwJoffzqnUBkY1Vbjfif9YzNtWhYJDi1Y?=
 =?us-ascii?Q?U+Ovz82khF8Pbqo90DIYDtoaOGg1bNkoo1hO9uor/HipZr35jTvB4KaD2zr1?=
 =?us-ascii?Q?0/zehS+Tum2iEvHUukj+Im7NIx4vnRPSqAwssM1Sh4fnrcjpy4YnVCQ0jnCx?=
 =?us-ascii?Q?o5dP9rrsGtOmgRtbNb8CZvwcgd4Sp9Ezbc6Dtb7WVLAFt9HyKrwGkNntxAlm?=
 =?us-ascii?Q?+LHrJmR/9LwPsENPXLzxEpPRIxzOdQ5Lzlt0EDcUQ9TaN5WSnRyP+JBzfM0K?=
 =?us-ascii?Q?sWTPFNYJwMDQzf3kMfbm0Na6jtwQRnzWn2TTA6cF98DToLMVTPAa/yXK/ODp?=
 =?us-ascii?Q?u0fDWIJA00wbOui0X8K6R60pRmb4T4pYjma1wwuhFAG14MxNtCPbSCMka2R8?=
 =?us-ascii?Q?saAvS4mFuOCRYguGF7Ymprwhi6yvfAhhhLgeZrW/Ac2OkNTAE1MG7TWxX7wE?=
 =?us-ascii?Q?LPdMssTLAKcoJR0E1eIxTea5jxNVF7VWyD9gqvhvkYlp7NTXLwBhFE3DTxTX?=
 =?us-ascii?Q?Xivf23/UNJanFIatmH9P6T5t1aEoNKprFKDVDAznT2KXeAMvjkGAHFBKzJLT?=
 =?us-ascii?Q?dAsDlwGknFLgb3gasSXNqhKa0gXT2LhJaEy112kmVRriWtroqmSDvmguVVj9?=
 =?us-ascii?Q?akt4ldYPMvY0tFYvBvlMf7HCHAtX4Z1cz+GI2IlnY7ORf3shEZJj6BtJ3lG1?=
 =?us-ascii?Q?mzSID2mPqowXBDGEYSzyc3PX8bM7BCyUHyo8OK3WGcR+Iezat0i18SNuBryz?=
 =?us-ascii?Q?HZ2F+fcM2CFPLjyoAp8tCB0oWt0qgeFL8jzwo/GaJA1A3AQadl4VFnnP9IxS?=
 =?us-ascii?Q?p5k9VjnYK+CIjuZblCNUGL9qi3Qkf+IIBzNq+o7ZHFruxpFpSFsChbsB+Tdz?=
 =?us-ascii?Q?1Jpkko0fvwlWhtZ2/GssyNfo6cOgUyqIxSruK2W6YFO2KwQy5Krmsku75LzF?=
 =?us-ascii?Q?x7Likz4m0Rm88jfZVFIwQtKmz1gXKHKLWTePWTLUitNgGjZgNvw4HVMNJvV1?=
 =?us-ascii?Q?L7148TuLAey268gq1Tpuu7gaETh6LlUuq9mdLJW8HirYkVt/6/YwHvHZJop2?=
 =?us-ascii?Q?m7p3+u8qM34XzjHXOocGDCWBazym5S17bYOOOzi7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f4a145-41f4-41de-8f07-08dccd872a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 08:45:59.7489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcf6T9PJQnpIExi4cWiCWBoffHcZ75BeChQwWkmEqNXSFcPO+yJy8NvrFgXw0r6+k2g/RmIU/Fxlnf1n+jtrGBo0RrJy3Zgb5lWEhBQmaXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR07MB9593
X-Proofpoint-ORIG-GUID: yXB_UKK0AxFuDKTI-VAGCxRSORcBPOcw
X-Proofpoint-GUID: yXB_UKK0AxFuDKTI-VAGCxRSORcBPOcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=669 mlxscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050064

>
>On 24-09-05 07:31:10, Pawel Laszczak wrote:
>> Fix changes incorrect usb_request->status returned during disabling
>> endpoints. Before fix the status returned during dequeuing requests
>> while disabling endpoint was ECONNRESET.
>> Patch changes it to ESHUTDOWN.
>
>Would you please explain why we need this change?

This patch is needed for UVC gadget.=20
During stopping streaming the class starts dequeuing usb requests and
controller driver returns the -ECONNRESET status. After completion
requests the class or application "uvc-gadget" try to queue this
request again. Changing this status to ESHUTDOWN cause that UVC
assume that endpoint is disabled, or device is disconnected and
stop re-queuing usb requests.

Thanks,
Pawel

>
>Peter
>
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-ring.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>> b/drivers/usb/cdns3/cdnsp-ring.c index 1e011560e3ae..bccc8fc143d0
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> @@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_device
>*pdev,
>>  	seg =3D cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
>>  			      cur_td->last_trb, hw_deq);
>>
>> -	if (seg && (pep->ep_state & EP_ENABLED))
>> +	if (seg && (pep->ep_state & EP_ENABLED) &&
>> +	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
>>  		cdnsp_find_new_dequeue_state(pdev, pep, preq-
>>request.stream_id,
>>  					     cur_td, &deq_state);
>>  	else
>> @@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_device
>*pdev,
>>  	 * During disconnecting all endpoint will be disabled so we don't
>>  	 * have to worry about updating dequeue pointer.
>>  	 */
>> -	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
>> +	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
>> +	    pep->ep_state & EP_DIS_IN_RROGRESS) {
>>  		status =3D -ESHUTDOWN;
>>  		ret =3D cdnsp_cmd_set_deq(pdev, pep, &deq_state);
>>  	}
>> --
>> 2.43.0
>>

