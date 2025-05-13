Return-Path: <stable+bounces-144124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E32AB4D6F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C851887C6A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB11F180E;
	Tue, 13 May 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JsM8DoBP";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NgVRGjOy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB9535D8;
	Tue, 13 May 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123055; cv=fail; b=npQgp4pERaQcbpb6hAB1t5rchmDNfXihgygp/lv7p4a2zRHeiaRVMrQUa3xNYS85ttimpHSni9gAvlhkYQJ2n79m/sh+Il7tIsFwI1zfgu6XmM2OIwfvXr2lvDuCdTFt8/9A2Vep44YKNuWNRD0TAhYXlHLj/TXYWYYcAyd31gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123055; c=relaxed/simple;
	bh=v1zCr2bIv2pQDRTT9i9to2E+ktB7xOlhDphwXEWm8do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryOqV6ragt61tNqn9t4V4fgHebOPRGMRrDQBj2dDHQaxktOUD4EV4vR+y60m57eUWi6zWQDPeb3xkaE2wIDgwsT/Y1pfqxQu55wsOUb6fo51pJ/X0w/X5LVsIUcLVJoRcSQMgFWJsvKMmX12eQA0qDKK3StKmreargXNowJZaVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=JsM8DoBP; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=NgVRGjOy; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D3B6ga009306;
	Mon, 12 May 2025 23:54:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=uQkXpa9pLFPOhETC1ftebDbN/6TqQf6uO8IrQClDpkI=; b=JsM8DoBPpGw+
	GCYp5pVCCN92Q6CpE7rbsr5cnURRGQ+Y7/kMe034IUKg/lbe0+kZGqmHO/AZRZPY
	miMDI9USABTNTNzKyGqc0EbbTlMib5D1/PcDQietNdkRHQ4pcpZH/cTsyCDk1MZC
	c+vYtnzvdXUoWFznABJL9wvedpDUArD9gf4EwZnnuFgz2WjZ3IV9gYXZd3isDgA3
	mRrvBd554yCFWnKQNgYnF6qoo5J3zaBO4iKvxdW2kbkIjp1wL7SGP0E+wHhLSQdb
	GxJIYQJbZrmxax7/Aol4N0hRxOoZlbTAOSF6Q/O5iMyxf6fO/xozV5Rxr1u/7ubF
	e0x7Z+7vSA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 46j3bx200t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKNFKI2ocEpHaAtBoJUEH2JFxJiHxWOaEvtAxTBhVcMCNU3DehsPK8JGnDxBKXLdxkV6O5d/gAvI/pcidYol3bPZk5vmESuFwQZGZmjYkhKSbkqLQ70ndGLs3hFz0cgGlo245oa3iSULm/Laslo4kC0ZDGZC2OV8YdZ8pJTwVZzcgP4QacATILYVf96yNU+cM2RurOKqmUBbfWI4VSzpdalMJ9gv4vTcC43dVOuPfA1S0de7zN5E8aJ1wtFJADZWS5OMUW8gMYAJ3O5W+dMAcgF+NFhGXeT6BmUQwtK2b9PXabyqOQh7/CrzFxroc966AC11mcDdJxXjYm71AUPRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQkXpa9pLFPOhETC1ftebDbN/6TqQf6uO8IrQClDpkI=;
 b=Tn7U8OREj0AwSjpKALGhc51OsYZpfAH5FPlRl+VWElu9504etbHRYcZdC9LkwL4l+x4Q7OgfqflXTJk3ocfsu6bN8FkxgRcSM3aX0Mf3uZPR4RWX7swj/YD5pDJWcvcJyqro9aQicYVaiZ1gevb8Mztv4LzFo57QHfWsBAnuno1WgWruz00tYiGj7uhc4+4VlQaYuG5TOKF9YQW2UGuE4D1uq35nV/Uhf07uhmR9ORiavY9x1zLK8mtdNq2Rd6RFDOsL1Q7crcANzfypbPFJ15az/r/GTCkYqtpoo/gQZ/JjWL76pCMiA8tOEPzkqESM840yWEkR+/+SqdzRZHzAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQkXpa9pLFPOhETC1ftebDbN/6TqQf6uO8IrQClDpkI=;
 b=NgVRGjOyjMKvuQ28SoawkET0YgMQBqMqgiyeK8kDRxeRGi6iiP3kBwg+LmYMgJwYY+b008ZUJX3Y0yQWfPy/pJXLElrh0/3JCbwPLJVjtxRIn7PLP5tCFFGSLQdQvaLbko3tHcwQeY4WtrsBiRJQec5bEMdF/+7vnnGkqZUoDR0=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SN7PR07MB9797.namprd07.prod.outlook.com (2603:10b6:806:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 06:54:04 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 06:54:03 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fix issue with detecting USB 3.2 speed
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with detecting USB 3.2 speed
Thread-Index: AQHbw9NdSvSWknw8REigopz/p7TvVrPQH8ag
Date: Tue, 13 May 2025 06:54:03 +0000
Message-ID:
 <PH7PR07MB95387AD98EDCA695FECE52BADD96A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250513065010.476366-1-pawell@cadence.com>
In-Reply-To: <20250513065010.476366-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SN7PR07MB9797:EE_
x-ms-office365-filtering-correlation-id: 6d782edb-8d35-4a4c-a43b-08dd91eaf2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wtEh2DuPMLrP41Er724MO7LPbPaSk2Oxgww2TUZilyfLweeznOfCPgIdEgLp?=
 =?us-ascii?Q?CJ9EQycYPCqm3GA4mkkR9uA1Fwf8YAewvZup/bVF17IyDg6hpX00lIsl6+W9?=
 =?us-ascii?Q?4us674UyMcJwW3AES0L/CGW+sGcBW87dB6jr7tFpHZ43faH6RzfJyE9I/ijK?=
 =?us-ascii?Q?0H8P0Z/0VtMfQ5N7/xrjXxD3WOlx7wA2oLw0gQ2yiLOBzeFMtFEGWtvNqCEc?=
 =?us-ascii?Q?s8dmF+Fc+geLa0Cn7z1vtES+8WQlFO1GKqQjtAK3Y0M9Sb06mpJwqlUNPEcF?=
 =?us-ascii?Q?F/fUrboTVjPqxDRrO0zKPLIGCw6FW3aE7eFK+AitoIRXIJHOY2YVv1uWVB98?=
 =?us-ascii?Q?1M+6J6epDGTSvs4XXwEub/aRYvCQJhRlwVpZiLpZaaTDB3M9bmeiUgXyS3Te?=
 =?us-ascii?Q?yhDwswx3wYAVgShOE5JKj9bewufpp7QzcjHQDL8SWARpw+vfYWkNWEhDlSYQ?=
 =?us-ascii?Q?vHuklZTqdLQGgEV+JQHCLyuhZ6NF6G+ovxI0YnMyUMSKN3w5LKvcyO/Y+pba?=
 =?us-ascii?Q?2ffwMuOyU7Rl2nbKG0kPWutZde9+6KtRg8lYHylcR5rx5PvP6WIYmHpKqqB6?=
 =?us-ascii?Q?kYKTsGLqXHtsBDI6QsK+Fj51q+eRdYtUOH7eHpKDtySSjof/Ojpx2LOGo0SR?=
 =?us-ascii?Q?fdwh1WcTaV3Q+D3bI+ZkiXlS/awPwl7OBBBd1d8HlHpXxoQ33KKjfiZwnV2Z?=
 =?us-ascii?Q?YjUnZRd5/xH1kV9d7kj+fWs2jrUsEQxsM6x8upPEfScPP/31SsfPTTEdMKuN?=
 =?us-ascii?Q?a5pKlJ1vunbJCtGa/ISGd2I4azkvJ4/LMxHES1JeqbrCAXejnt+zdrShq4wV?=
 =?us-ascii?Q?yCzeoVLyIUMJcDnl8aX0AlNVPBKkw/JctvQNmY6EqzHvqvg/DnU9J0PVx8/E?=
 =?us-ascii?Q?Kk21eN1DJQ9HIk3fKn6E21Y7PRT2UpC+RfJxZgsClgtDRmxbAqsG38u/Eza9?=
 =?us-ascii?Q?0PJOVs1faNWOYOaB8nhigNXisnT37VZLWGA7iYWqMtc4IEt8JPIZj4IHr3Pa?=
 =?us-ascii?Q?4RHnt1Ghf5xPm95l+a03UO0OZTw90/WuEDmHUDX7QPlBJ2oesfHvCQs3bE7B?=
 =?us-ascii?Q?gWS9FwfVd5Ej+1ya1W508w4HGUR68gpjTUSmXwMgvRQa1QTI8mE3CHmxArUC?=
 =?us-ascii?Q?jl/grwfmcu2KSBPU6pccm/dVemT+iRt9F6bUB+ihzVKjwNAkNdGm2GVQd07w?=
 =?us-ascii?Q?aznnXEn2m9KUo5gRpdI94Dfror5uwjy7KMaozVyXXfDklA8oVqpB1PaukayP?=
 =?us-ascii?Q?+veIFK0rqqCpWL8Y3Sai/jMCWGlMWbbUEuZaOn5r0ofOeE7zrN92WDuVm+w9?=
 =?us-ascii?Q?VEdAjRk0GON05L6hVwViuVaH2HZPf9+fZNHcGoPKrZdcrlwPvV/lsteFUcTL?=
 =?us-ascii?Q?FE31+XNunuj+f0zHFMP1e5nDiedy1D5qsANUGy7RG9I92z4PAKLITzoJdDSO?=
 =?us-ascii?Q?Uch+Co1a8wecUtdVChFjh4ZviVmPtyuZl3kKbE8GkyFspLT4vUxDZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7xrzH9D//UOEIa8xIuDB+1G2OzUNXFmD7zCQ2h985wIUQ/SPl9Sdeye+tXm/?=
 =?us-ascii?Q?7PLVC7seNC8L0064bd6wiNNllwhGZVblQTPzKYiGLwmEghmm7DD3RLGXgOLw?=
 =?us-ascii?Q?rvLnKLhTf0eTpH5dWjp6XeA1WVVWzu1OFxIP5BW0SXGH9o4svbdsnKJaGUx7?=
 =?us-ascii?Q?KZ90GkQ6a1HXs8kNJ0cY7LxcwsCaWQXMDKLYF0IzHrFMhTq4LfcxhrThqtTw?=
 =?us-ascii?Q?Kqyrm0lFhvOcTFM/24ZSxwfc45s+xZVwr2doY17WlNh5bUveQw/h2pEOBtP9?=
 =?us-ascii?Q?bQ7l6GcFRbVl9cTRerVMsQ6YhSPG9bdp8BgKFBn/Wn78GoEno9+zfWsA9Yvl?=
 =?us-ascii?Q?28/uNtMSsN58lT8LG7kB0V94qo/iko3+hwkTcVO1tpf1az4zTwFV7/s8nFD5?=
 =?us-ascii?Q?r+ZkSvJCRkCMxEfTCkcUyVwSUJwvkLWLiJYf1mEOxHQTGNnVOTin59mp7F8B?=
 =?us-ascii?Q?4ETvaIRWidgn4pmtAf/hwmeacE/+rpKnj/r8kRqjxrRPvFrMtwjaJiuum9hL?=
 =?us-ascii?Q?54fK856nsiTHyRZ3+vcixHTthgxQzvi+kMLrso1QcmexiuZrGVLipCLACDBA?=
 =?us-ascii?Q?E8pLQI7BJUhQMLI+RJUKA2+dL0LvzyQ/NJvf1GFkrgEjp/wMeCSUEjVIq44F?=
 =?us-ascii?Q?XFlHRKCp+9Habm9RZqp3CtlZ/A9FhGGAahJGruPGhZ5t5qVsdR/3vm6kuIoM?=
 =?us-ascii?Q?fCjr9nHhWKwxs43F1GC0mHJCKiiXcw+lvjfELUobU5FCW14LpKW4fCkfkvu8?=
 =?us-ascii?Q?vTH32SENc1gEGKbv99Ql4jtbqtBKIh0qwcE/MEUeFwL2ooGOq2uG+SjSdHMU?=
 =?us-ascii?Q?9C8SvcjXrulLeJJoAhYf27Zvx4OS22O6iiwpuwjYA17ZWC2lHqy/0yYXySEA?=
 =?us-ascii?Q?q5g5VQJUG8sqwm+bHW/MyQCk8+l8mpLEilT0LYxBGsgNVZXIA9Z7tZiYCSlh?=
 =?us-ascii?Q?OvbqU1SYEpnQKsDmPy3+UKeOqvXShNLk847/JsrZlkYkMwDiDW8Q65b3mlMf?=
 =?us-ascii?Q?HIgW3S3mtr3lh9kiaN6674sABYWqSh/slu8a/l11MCXFz2qVBLw9l95uziZf?=
 =?us-ascii?Q?tNLDGYxwPOubE1PzxUiPfdDPgEjRINQk8P54IMFhqUsMI7yxXJwMYy33Rxqd?=
 =?us-ascii?Q?5ZgDMZkd2kJxVkr8TQsyzTKkIaYObkJE5Jh1h3QBElx98TVuN2ulQ8UYolPr?=
 =?us-ascii?Q?xa+HpPr/pRZfJN6G8elXKTjXH8xrt8et/WCU1L5lJ3ASOZzGZc7VaJ3XUoZQ?=
 =?us-ascii?Q?0JGbJ9iiWb5cETxgHe+zHfOdqqjXCmVcu/kL2bSUV8/0G9kPaG8B5scDcwy8?=
 =?us-ascii?Q?gRemOnSuaFjn+gnU8q+Ut8nVbmHKsWOFecfXx/UObcDz9wIZl3Po1vSHpUw+?=
 =?us-ascii?Q?RlPCW9W37CQwiJElJ4ptO8jrelynE0yWa2e1KcOQEiyih/fssXjJXKVArpak?=
 =?us-ascii?Q?U1sve5FVVA3PEi9BTfri5Ilisq+cWu9US3MjsrtD5k/9q1noOPLMGMRNaR1T?=
 =?us-ascii?Q?13IbMK5XcCLDAbtcIYlUY5qt/EDuYVFU7ONSCbHbuu2hM6aN9Q9zOzhzPsQj?=
 =?us-ascii?Q?7Bz6FkIIEJnrzgiYgY3N+Y3oDrVrhlNTdsd2bvSa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d782edb-8d35-4a4c-a43b-08dd91eaf2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 06:54:03.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WC7zp3L0VqYT7W0HwmSTTmmSmcFgNY5yDJaz0aevGtFDTc0lPfzaS4+j8SmytBv86vP/vviYQZeQJsfAduVvtbESY0jHgETzz3U2wFeAskQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR07MB9797
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2MyBTYWx0ZWRfX6058H6P3QlHW pirEk+9Z2+tY4W9BWXrMhzoKMzqPqk1h9XXqzr2n5BP7ySAX+cUmtDg6wE0CAvFSxh4nqKJn6jN l0JtQ8Lf0Y0BMwEWOoh1SeFmxRAbG9rhQ4Tx+Bbcg7B54MRMERFLVMbWpy62EJCKlntTNNJwhhx
 4VvpEABKZlkE47RzkqLkI2g8jVUgvcO4dr7+qxVXgNeQkaKgYvcOJ4wlZOQVVz1jS5mmaZ+Gk91 lat9WK8irCeXfeOWWJkTozOCWAdpHavYBv3WNIPCT4zhLn6n7KnaHfsyVBX6NrsXTrO81d0FcK8 mn37Lum8z9E4QXuZ3o8l6FHg+FoSfx6Re+hVJHO8MgZvOAn3vS5v4Nj563J2jd/NYo8sgGnf8zK
 HepIgOlMorZDhuT4YFhJhAW6kXI3QEFCqzCq9KcCMWlOFtfnD2Lt8GJeauHKDICvOxVEi8wE
X-Proofpoint-GUID: rLYpgZkFRSKbBL5714x6JxhwAeuwnd9k
X-Authority-Analysis: v=2.4 cv=S63ZwJsP c=1 sm=1 tr=0 ts=6822ec8e cx=c_pps a=qdevHIbYfAzI1c5gbp2lUA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=8BwjEF9hN-vadGMTrAkA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: rLYpgZkFRSKbBL5714x6JxhwAeuwnd9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=1 phishscore=0
 adultscore=0 spamscore=1 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=1 suspectscore=0 malwarescore=0
 mlxlogscore=190 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130063

Patch adds support for detecting SuperSpeedPlus Gen1 x2
and SuperSpeedPlus Gen2 x2 speed.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 3 ++-
 drivers/usb/cdns3/cdnsp-gadget.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index 52431ea41669..893b55823261 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -29,7 +29,8 @@
 unsigned int cdnsp_port_speed(unsigned int port_status)
 {
 	/*Detect gadget speed based on PORTSC register*/
-	if (DEV_SUPERSPEEDPLUS(port_status))
+	if (DEV_SUPERSPEEDPLUS(port_status) ||
+	    DEV_SSP_GEN1x2(port_status) || DEV_SSP_GEN2x2(port_status))
 		return USB_SPEED_SUPER_PLUS;
 	else if (DEV_SUPERSPEED(port_status))
 		return USB_SPEED_SUPER;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 12534be52f39..2afa3e558f85 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -285,11 +285,15 @@ struct cdnsp_port_regs {
 #define XDEV_HS			(0x3 << 10)
 #define XDEV_SS			(0x4 << 10)
 #define XDEV_SSP		(0x5 << 10)
+#define XDEV_SSP1x2		(0x6 << 10)
+#define XDEV_SSP2x2		(0x7 << 10)
 #define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) =3D=3D (0x0 << 10))
 #define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) =3D=3D XDEV_FS)
 #define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) =3D=3D XDEV_HS)
 #define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) =3D=3D XDEV_SS)
 #define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) =3D=3D XDEV_SSP)
+#define DEV_SSP_GEN1x2(p)	(((p) & DEV_SPEED_MASK) =3D=3D XDEV_SSP1x2)
+#define DEV_SSP_GEN2x2(p)	(((p) & DEV_SPEED_MASK) =3D=3D XDEV_SSP2x2)
 #define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >=3D XDEV_SS)
 #define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
 /* Port Link State Write Strobe - set this when changing link state */
--=20
2.43.0


