Return-Path: <stable+bounces-144293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C25AB61CB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54FF168B78
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0F1F0996;
	Wed, 14 May 2025 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="k1wrYfVV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="o90aE+Xl"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E61EB36;
	Wed, 14 May 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747198507; cv=fail; b=gavRu3MfH4Cip0S6G6v4i9SCV9UphUSmudi7uKQ353wCsHM5yRAoX6CGk+M0dcveJiKNUrIuUHQF3P9IL3PLq4TDhrSiVW+2h+Nd0xNr9d7k5TSYtuHn4ZEBnBoUULmMQBAhPj6XSjuIHnCDG+VcfASkw4w7xbS3zJ3acnpBX3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747198507; c=relaxed/simple;
	bh=ep30IuXtYiIGvbILRkM3BQxykZMvIAHYtXdIwhGTH+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9sApWsq00XUHrOx5wIYW04Mm5QIUo3KUbCuoj2+rDG63+AuCHrNCk3eV2FciU3hFu9kdLlCk73x03byz5MPqJ4wT9lc7cdxzZNZHvLdfD5YB1+qTmmdlpIXnVRT2skOp1BMFS60qzb/aIW2c7buri5x4AnNr4yn13vqFLXvQRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=k1wrYfVV; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=o90aE+Xl; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E4XVLt030636;
	Tue, 13 May 2025 21:55:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=fs1aG0uKaWhu8kqxWhlSoMVWw8esVrfgthpjzV8tApM=; b=k1wrYfVVuAiY
	df+kfdsnjjFBnHnI7YkWVqMRbIgoosGsm/M418nhResizN0Wa96I/n6GtGHhCOIN
	4ZB6VUTqWnWbv1dUqWH98v+XOp3eZSLWyTDSogeK2mGtKX6nqyc8k7qUaBIL8Dz2
	wFkf53vFumagMWWy5ddkv0Xovn18j6zSfNvQIVzpx/6wjZptVzA283hDLWzcWz2W
	AIfsj6RKv3xDCkj3lP94GdQTgQ8Wlz1BtGUEQpSeDAzCl3ddD1yqsqH0sUy3/WaN
	MeDlo3yjTt05zezddqCN/et49mdF+71lSueYidXbt/24sHjJUmVo/bhh6LMHZIV3
	E+YHzaC9Mg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 46mbe0t4b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 21:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpDedwCK4GcBHIG3Ftnnj5UXglapQ9W26Pq1zVAJ7HIaiKuQ6XlMfhG+45vUKcUhN3DADN7UBtEsyNm47tQoZFF/ocZPB6BoZXtjVfcrjqoW/kjKgLF0JmKHNoI90jTCifVaB6WpLANnie11PFZhXUWZy0EoSvjMwpsWyxOU1UAFcMLog9o7fMiC5mj8HlBK7C6kXNPvKI/N8xDR6eJDLmp38zZRZqybRfqaEDsV4nTS1cTr8wwGCubZovK9YUQ+HYobav+fiYpX4d8/GHKcPx/XSUGP+nVD4SIAMz7/8iNtmDtmCc1Yd3oJUN/a9Difmf76VegCEdXpf/FcRAbMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs1aG0uKaWhu8kqxWhlSoMVWw8esVrfgthpjzV8tApM=;
 b=H5b8ZKlIQbKvMuAjbYLwmjkduxVKxYSfUJ+lIRct+tDNfc5DQrTqvYXc9mBY+elw0DM19MmF+W2SRBcH/ShkZAbacBLCWxdchulT39/Vf7XAqhBeeIcVe+6/eS2dggrH4fjP9Imey+msxPkB37f9EOnEKUTIaDoS9WGS+8HcWltscCpOT+CYOmlUmqnqKhb8wb5cijEdfb950aJbNyoN+c8FEZprhpmLrzFSc1I8ibfTnJxG+ftFWIbjXzk559P7Lo0gWgmXx8LVm5LL1obiE+gOx88X9rUb8DTh40V+M75zO7REvVwUGF5lhkqjzyz0f8Bvzxx8aaBa+lZvf7zHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs1aG0uKaWhu8kqxWhlSoMVWw8esVrfgthpjzV8tApM=;
 b=o90aE+XlV9iCv4QjBGHqkGmAQD5hmzrUzZx6UmqkRuE/oVt7kMTHa2AUkw56tJ7q/xjAJjPkjMoq2OFIvdSLT7YgI6U6PuD9EdlWdlmBq4+IEbrehEM8Lqio11As1OKeaq1BmtCoja3Y9X4lZWosHM0/KQCdHqPV5kWeZph+D8k=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ0PR07MB7791.namprd07.prod.outlook.com (2603:10b6:a03:287::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 04:54:58 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 04:54:58 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] usb: cdnsp: Fix issue with detecting command
 completion event
Thread-Topic: [PATCH v2] usb: cdnsp: Fix issue with detecting command
 completion event
Thread-Index: AQHbw8efzs/izhLR3UWYE/4/Cfc6R7PQCADQgAFO3YCAADmAEA==
Date: Wed, 14 May 2025 04:54:58 +0000
Message-ID:
 <PH7PR07MB9538ADAC2E132FA1AD380EB5DD91A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250513052613.447330-1-pawell@cadence.com>
 <PH7PR07MB9538AA45362ACCF1B94EE9B7DD96A@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250514012627.GA623775@nchen-desktop>
In-Reply-To: <20250514012627.GA623775@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ0PR07MB7791:EE_
x-ms-office365-filtering-correlation-id: e020fc3d-9651-4ed5-1cc2-08dd92a37a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RS4LR9N1ibiQ8EuEIIRqIlIA1nxbeIyqm8Vvot+oqHDSQxkyjzu4QbE9OEdu?=
 =?us-ascii?Q?om9hciUyb9wkVFakcD1FmFLYcmGusR6Lg9aFWl+bd3+5DWcEXalMAIojr+Nj?=
 =?us-ascii?Q?EOFY31j0nZY8cfmlk8bxneH/LRCvnNgQA5iAqTRrAFPgOl9PR6tL5555Cw5Q?=
 =?us-ascii?Q?jWIA6Y95XhGHWeJXgAfR1GJNaPFhS2pRbwjFb0mKsrHF2bDDtTKtU7o8CB/d?=
 =?us-ascii?Q?Ahbrob9pvHktM3TgLOUQ+yGO962Iv/VLa5tjHEcSs3Jp7S8Hn6TawXU8OqYo?=
 =?us-ascii?Q?exP5Xx80sbmUNXvgoMkwxzju6+KNmfUNRPlWwpHWVQ+15WgshwxitgFb9X/L?=
 =?us-ascii?Q?eGa7V2C37R1xlAzq4+Cu1o4lU+1/q/Y93/F7ZSsfqrkPJnJkr2w4wkFNomit?=
 =?us-ascii?Q?XyyZkaO9HbS4WfcUSzoS9GbpGwl6Btqe8M+H8FHah/taeiP8/Ct95iwG5V/R?=
 =?us-ascii?Q?2lIUWLJ0/OnLlbtbz3pgsvm+qftH7ofCf+YxKSkFaZmBVJ4wPnuXPwBv3VZi?=
 =?us-ascii?Q?cn2scO8hNG2EH/gbGTQ06WM7PETX7xV0tM1dW2jOfzzjCYFE5IOwXHYk5lqr?=
 =?us-ascii?Q?b7zk2BGcX/dxcwzyin2AWPBzacZXAulfTeG4aX3LZT5mVOIRcS5q/OIZuKek?=
 =?us-ascii?Q?JvoIPvQ/M8/8gf+Nu12qwJ0H6tW3eLcBdxoA+ST8N+z6IQUcjE2pr6NG93Zh?=
 =?us-ascii?Q?ktZV2pV8ImuKSR/0PIvKzWC7lNTTEUu+2YP6tX0rCUZGZdTuUC/QIHX9z5a8?=
 =?us-ascii?Q?drQnTUpjTcfBJK193T3T/KFWaeu0cPFa60F4BPJ/nZOR4lX7gcidbAPao452?=
 =?us-ascii?Q?O6MkUAx3NYHwSvrewp1RqUgCI/tPvvNzkkDwFu+SBp80oG0DUpzsh61oNIU+?=
 =?us-ascii?Q?j0VDZzG1cL5uLIaKluhM+5UVo3iIM8LU5z1BwkR7e8DNNH907gkhMaXgnbKx?=
 =?us-ascii?Q?K9srNlBlTvt00cl+i2HPg3jAYppsyY3n4gnxZZubj3mjFM0lAuDjWnPOkim0?=
 =?us-ascii?Q?oIu5awbbxe1KCNz7YIfHbQpjwbT1lLPtJLhJHvmj9PrLp23KmSBPFTMYNOFR?=
 =?us-ascii?Q?DLxwt1TajZQMU32jTfjbePpjlgGOSfmzOa+Bh7gwgDC2suRh56L6+urMPb60?=
 =?us-ascii?Q?Ik+GssvonTIWb6mQwLvQ/wmf1f7i7wc8vSaloe3vh0Ly63E7LWCst5oAv23z?=
 =?us-ascii?Q?4RVqXDWRzA4OKftBNwqJKkjFsPTK/dpAVT9IqFScubklRe1doeIRZjv5bneR?=
 =?us-ascii?Q?PhE8LOceDf42esGP/oVEc4Um47WKXtA5qg0ZbbB1GVGBTMmSuNlNOY6IqUOz?=
 =?us-ascii?Q?mpy6KIJ0rMidX2JBUYyMnU1XdPc7KsIOSzscldI/EeKIVMXyK2H3Nf1ixEuL?=
 =?us-ascii?Q?3TKSiCEBiFZrCJPYb268TEnwXm6gdXLvGordjK3gNgjunAG1JSsFxC0MAYsV?=
 =?us-ascii?Q?SZkMKbupV/IaqbtsG0dgTJmlK/UzwWJcnSyJsRvKu2WaN9danUsK5NTc7Aoi?=
 =?us-ascii?Q?sqw2vxzLnQaUmoU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?62xkA5eYjciX6Sjjlzn6tCtq0VPrS5YkLXugqpKjnpl/MnZ7d3eVrygrFEF6?=
 =?us-ascii?Q?J+nYQmv/cCWbUy7ZvvVTUt9sS4ZKeChAQFliFiP0r/pHQzL3k5947mndIkKi?=
 =?us-ascii?Q?zO7RUBu4qdUa0EW5UU58tTdfiJflJQmzHSG2kx3dM9EcIt3+IXWJ/umWJ2y2?=
 =?us-ascii?Q?qnXqlDlqUYDa12YRouMMNnQwys/W9KAh8w5lFlPpeYF0o86eZrBAnSFewO3x?=
 =?us-ascii?Q?+Mz/I7Vqdjq+1vJejIDBMlzKR4Ya4tWhyQ/Samzk7se58oEuRyicwSIcSnuX?=
 =?us-ascii?Q?wy7/Y0x5OS8rEvmgIrTJ9tNmp/NDY9xheLMGzLhC3GKdklV6t24YmgsFA1CE?=
 =?us-ascii?Q?tkspRCe+/ol2OpqCwyVXJMxl/HjAHlEfnd1wQSb4oNHbl66rIYkkd4cG4C/u?=
 =?us-ascii?Q?5sKmn7jGXpigoCu7AAikE7tIsMLnrsNHTpm1UYIkHugKFaC76U30lAXzFm+b?=
 =?us-ascii?Q?eI7ljxP1sCyYKymHb3ksUL8cfH0+GFGDL0iGe68EnbXEYOwCVV+8Nhx+JPcF?=
 =?us-ascii?Q?o41tiO86B1iUx/KMykyt5chMNSLmUaZf9fLvqkwEOlmnz1Fw5F65p29s2NGx?=
 =?us-ascii?Q?k6fqSU5wRyqDYCY0latxV/QPHxQR85XCEc704Zluq7BVJo1xPvc18ZLr5AQq?=
 =?us-ascii?Q?9gTh4OrenyTEVhgvf/+kMNKT2jAMELOcJZKyXQJsCa1KpmzJJAQNNBeHkYTr?=
 =?us-ascii?Q?AYuSffTSVhv9OgHzmClGzi/8B9ohHIhzA0chKraa/npnjQoNvaFscprFaKu3?=
 =?us-ascii?Q?vJtkdbr8SXAt1ImX03quxwIeDWEeI/vLXHr8/uIriZNwWSQZGO+R8TckrJ7a?=
 =?us-ascii?Q?k9iw1ZkFqiOqdAzJMF7iNuJKkpiF8g2T8/VT/rSi2OsCNBQHOlZQ+oDf9G7c?=
 =?us-ascii?Q?gFtdFNcqOFDvwC0NscyVhbV6QMbcs26l2GwrLJYQOvIAU2z79Nxqi3sje3+y?=
 =?us-ascii?Q?CYsl/qKRAW0/ga2FGnf4xAlhyePO45yeobGh45lEt6LFsi0NSuj84CBFgWxa?=
 =?us-ascii?Q?q1/OLzuOoTlqKEsAAw89GH1akcY/oAeVQydWrNKkvASt4sAXahhHg3x0jFQo?=
 =?us-ascii?Q?QCPTL5ivHZ4ytVHW9WlIKt/76Cg6tadT5hjBBGsfSzZKOGNnesTsqT8C6ne0?=
 =?us-ascii?Q?U0VLRiwK1mYl7TdhRrbThFSN2u5l+Kjbz8DQlao4w8jzJI3EQdyAIllmEWmh?=
 =?us-ascii?Q?HXqGxtVP3NhBKCDwjXmOKUFpDTeiXWR0+LM3mId8vfD6CIcLOI1KkjhSe1fK?=
 =?us-ascii?Q?6Zz9AitGI1TvnqEuHNkeXTdH4+odb+RyyI3KR4C0A3MpcxDfR0Ti+LaAOPJ9?=
 =?us-ascii?Q?uGz+iP6sjvkVcR5Dv9X3+fjW+OUI/LL2ZJUvWU7WNMTUDElgDbzoKoeaQsg9?=
 =?us-ascii?Q?SbR4CEaRV15+MorM9qWLb7RUIhYvm1zXDl+qTHdaXYFeHYUIjTS3yw/zNhyJ?=
 =?us-ascii?Q?IVGzFS09pzTiiXxxZCq4JfcMxEcljOAThHpKMns0va4eK3kkGgVQr+TVTKFs?=
 =?us-ascii?Q?DZq9ZV821RSLVCFi3kJ8d00uLwmzIO1ygGrqLHm8TO/VMEVPcZyPo/RToLRd?=
 =?us-ascii?Q?IKo9GDMVw57JK/4aIkxTbm9t+gEhxxwxw8cV2/CV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e020fc3d-9651-4ed5-1cc2-08dd92a37a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 04:54:58.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8rsJsju7tQqNnPkaVgdVqC6rImMMBtm+cUh/uYQHvZNND/mfUKBLKCoClsrcFqpMon3j/zavCs8ZEx7fh7PBdqzwuexpfEBnRjcfN2vStU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7791
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA0MSBTYWx0ZWRfX+GNJh02Zh1/N 6rOp58j0EUGVfANBvp82gGALbXZLUHusjM5TWZ3c0K0p6Sc2f0F7wHqlnaFAPQKnKJOjne40UOJ h+/jZWOq8NpsJtNQBWHkGqS2gAH8kNQ3417ac/7mlSlXaRjkPL+f0BbWPW4+6IOiumXW/WM0XoR
 nwTYaBvLRC8nFxYp5v7ecJK+V00JRAQcnn9jPcXj/6cOxEi0TZoCrzucGxbHkry6+y4XaO53pbJ cFi2cP09y2W9VX/Cb6+vxj4qIsiw+usdbHSRVMnI6hlVwJjX9nbeEmOCpAXxMmNj0abYBUw4X/G tkrfCGdgLU3FeXydabd3zomeFMH97+VoYg9RNPGyWVeJBoPBrq+UnfTqmqK5IxndtIOkUOQwCYz
 iBRNZqfwQmWvAXFyUnTYfKe/Fl32mDXYdBD8n4dQTjsGWo+ov4wwGnMIef+68eoXv5wKXwo7
X-Proofpoint-ORIG-GUID: VS-4Vz0XIpXIQIlwTOixpQqLWlo-gZkt
X-Proofpoint-GUID: VS-4Vz0XIpXIQIlwTOixpQqLWlo-gZkt
X-Authority-Analysis: v=2.4 cv=RLazH5i+ c=1 sm=1 tr=0 ts=68242225 cx=c_pps a=Al84TKQ7ImdPUwhB59KusQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=LP_5SdIvrxA6-xwsqD4A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140041

>
>
>On 25-05-13 05:30:09, Pawel Laszczak wrote:
>> In some cases, there is a small-time gap in which CMD_RING_BUSY can be
>> cleared by controller but adding command completion event to event
>> ring will be delayed. As the result driver will return error code.
>> This behavior has been detected on usbtest driver (test 9) with
>> configuration including ep1in/ep1out bulk and ep2in/ep2out isoc
>> endpoint.
>> Probably this gap occurred because controller was busy with adding
>> some other events to event ring.
>> The CMD_RING_BUSY is cleared to '0' when the Command Descriptor has
>> been executed and not when command completion event has been added to
>> event ring.
>>
>> To fix this issue for this test the small delay is sufficient less
>> than 10us) but to make sure the problem doesn't happen again in the
>> future the patch introduces 10 retries to check with delay about 20us
>> before returning error code.
>
>Does the ./scripts/checkpatch.pl report warning if the delay time is 20us =
for
>udelay?

Yes, it is reported:
CHECK: usleep_range is preferred over udelay; ...

But only for checkpatch.pl  with --strict option

Pawel

>
>Peter
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>> Changelog:
>> v2:
>> - replaced usleep_range with udelay
>> - increased retry counter and decreased the udelay value
>>
>>  drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> b/drivers/usb/cdns3/cdnsp-gadget.c
>> index 4824a10df07e..58650b7f4173 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -547,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device
>*pdev)
>>  	dma_addr_t cmd_deq_dma;
>>  	union cdnsp_trb *event;
>>  	u32 cycle_state;
>> +	u32 retry =3D 10;
>>  	int ret, val;
>>  	u64 cmd_dma;
>>  	u32  flags;
>> @@ -578,8 +579,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device
>*pdev)
>>  		flags =3D le32_to_cpu(event->event_cmd.flags);
>>
>>  		/* Check the owner of the TRB. */
>> -		if ((flags & TRB_CYCLE) !=3D cycle_state)
>> +		if ((flags & TRB_CYCLE) !=3D cycle_state) {
>> +			/*
>> +			 * Give some extra time to get chance controller
>> +			 * to finish command before returning error code.
>> +			 * Checking CMD_RING_BUSY is not sufficient because
>> +			 * this bit is cleared to '0' when the Command
>> +			 * Descriptor has been executed by controller
>> +			 * and not when command completion event has
>> +			 * be added to event ring.
>> +			 */
>> +			if (retry--) {
>> +				udelay(20);
>> +				continue;
>> +			}
>> +
>>  			return -EINVAL;
>> +		}
>>
>>  		cmd_dma =3D le64_to_cpu(event->event_cmd.cmd_trb);
>>
>> --
>> 2.43.0
>>
>
>--
>
>Best regards,
>Peter

