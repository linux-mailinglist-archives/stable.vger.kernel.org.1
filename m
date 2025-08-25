Return-Path: <stable+bounces-172835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66887B33E8C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E871766D9
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4912E62C3;
	Mon, 25 Aug 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="ZsVu7pwO"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020127.outbound.protection.outlook.com [52.101.69.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7F2C3745;
	Mon, 25 Aug 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123128; cv=fail; b=G/4x7tSelMqjmNVCPs5v5jIowMirw26Ah+ELJVvjeJYx3ETqoXeYaDWW8dXtacREWPA1QlLWxUOi0wYEeOfvZmBRVGTAQ6pEerCEbjSvBdx0DVAmdYMid/LStwJv0TdnRxZPuSFvqz4cpj5OgyrouYi8GXAUwWYveXw8FqIMEzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123128; c=relaxed/simple;
	bh=eqWamp1ex11NkxQ7xqgxrz/GDob2BBJSO6V9VK82p/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6akMmNPFerbQ7Jd5hFd3+/Rp5gk8H+Vm0HDPJIsS81Nzx80yccCU355BuIol7LzkLMl1+ATjVWj7rGWznfrqab/7CviT5fUIqPd6pP/Frh0wJP2bzdIG5Tu/9wp5xRvT0eO9TD2NgeYCLu4gDU8X/OM2E61iearj+mtrX/qDOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=ZsVu7pwO; arc=fail smtp.client-ip=52.101.69.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcrS6Uuihcq4NSAJc31vyONVJiPriqGTif/nPQUDhQ34jRbrxkJ/LoMLXfV6VsnB1SKvl3PD9P/ehCCeYU/Mx+1f56YZW+mVGZ2oM/aZHyhZob8cJpGPcyQcCGrdVzJTaBGe/gBqbw5ApI5S/dtCDlyPx5iunPFYUpvHoDQO7Zd9m1P8uLpJO9JyYT6IW0D5Ue1G3+yIBeNbQmgFHOshYcR5hxiUMXHzAJdNWGvF9b8R8jBORAuNKukpg1ph48EQzVg/yq6rgYjqpZJDh0XWKG4C7L+lFm0YFEcBkkzFMfje28iJ+6SyH/nqfkPE1F6VihtxeV3cZn+2dX4f8OHPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqWamp1ex11NkxQ7xqgxrz/GDob2BBJSO6V9VK82p/Y=;
 b=aJibwXRwtRj2lvM+OJllqZKVXAxcR0vO0OA0fXEHlLiCFYO8Rc+T3YCYbdh36LOKZj6ZQCr3R8IJ1wMXDFoIvECWlIcW5Oka4gf15cm0DNWHia5N+7sdHwNAxnjcOsZbLn4A7EypSOQdWNBe+psH9ybNW3llyaGktikgBb5gbEqLpiV7YPFzk511moVxGDIcbGZRXAv5XlYC31hH9YVPDyGCDjIzlTbvWkTNe9KfXW4/zudcArBl20raw17/1dczjGGbM/eS5uOF+aUdV/E7X0gL6xu6Dxx3bf43L8Crz/13yDEFRxUX6SewZeCWo8MWl/N6gwjCDLiw15Ykj2JTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linutronix.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqWamp1ex11NkxQ7xqgxrz/GDob2BBJSO6V9VK82p/Y=;
 b=ZsVu7pwOSOzLfAH2doHUVqm6vkQeUaGhentg+jp03HC9M4D94wMwk622lqEjVkdJQlI6OarfzawtK2Se8Pse4jRFwrTOC9L54Z5XI66gYI2HgckyZyaC8fbLuTWfbjDVcGuSfmZ6uj2JMjJblqaSE8JcyOPMOl1uom06PG/zpjyDSTgdsfPeU8eRf0xqPMfxDqrl02xcSJbKM/qLKB3a06uWsCqbRg2RcbtORdkhQJKI+G5iL3J3SArrqFj3iOWz92o+Ws10BirJ8XblGrTlJ8jA57ivhebrMaDpFXBv21ctEuNreL73X/udO4pi49D/jdH/Eu7mvHxuikdM99D0jg==
Received: from DUZP191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::9) by
 GVXPR05MB10983.eurprd05.prod.outlook.com (2603:10a6:150:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 11:58:39 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::b0) by DUZP191CA0066.outlook.office365.com
 (2603:10a6:10:4fa::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 11:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 11:58:38 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com (40.93.64.26) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 25 Aug 2025 11:58:38 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 PAXPR05MB8176.eurprd05.prod.outlook.com (2603:10a6:102:dc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 11:58:36 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 11:58:36 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Martin Kaistra <martin.kaistra@linutronix.de>, Michal Simek
	<michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Thread-Topic: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Thread-Index: AQHcFaH1MXEkZYlaqEGWd2GEoU/ke7RzQQgd
Date: Mon, 25 Aug 2025 11:58:36 +0000
Message-ID: <DB6PR05MB4551C55567E135005F7E6E95833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <20250825092251.1444274-1-martin.kaistra@linutronix.de>
In-Reply-To: <20250825092251.1444274-1-martin.kaistra@linutronix.de>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	DB6PR05MB4551:EE_|PAXPR05MB8176:EE_|DU2PEPF00028CFF:EE_|GVXPR05MB10983:EE_
X-MS-Office365-Filtering-Correlation-Id: 21694bc5-defe-42ef-cb3a-08dde3cebaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?NPf2+hGM3VE7U5aLztdRlRsrnJBVcfWnPKlFQzfAjIEBjR4GLpEniUmPoQ?=
 =?iso-8859-1?Q?lnflvJZbFExuQtdTlQHqzr5cYc2f1VACeVbZZaazpoSsvZokTEq+cKpnju?=
 =?iso-8859-1?Q?uUEE4LjRmMAKoVb0ekjfIECcXesrmbAWztXpLdkd8+w6sZv0EmS5KbcqsO?=
 =?iso-8859-1?Q?PE4ssKb79V1X5c5ycWaqbPELYr1+v0YrnUbDNhCNN/5GEisYKOLlkl+pyL?=
 =?iso-8859-1?Q?99dbTrij/dFHpKnJql9YcMYBSR7kIFrEP2OV3fHglC6+Tcu8Udm5ZsJCCk?=
 =?iso-8859-1?Q?tSXoVjyDXTkG3jmV+9ZtaEFrQodg8CMv1O4dQa1XQizyHFsZcOxOE1ZDlM?=
 =?iso-8859-1?Q?pRfkvdJRtNlG3HWbCzdE8kTlL3lsQPMspZqPQBRAulwDbcvMSIhl4Fcz+6?=
 =?iso-8859-1?Q?q9IlUHlQ2daGe5k/lt8NE8Q6JCYu8rzpi/L2S4k0yW+HqIBHovh2rcic2F?=
 =?iso-8859-1?Q?4AfhiAS/NHUxs31HFadpaFfyqZ7V7HaYSLQdzEr2okx11GfldcrR1Q485u?=
 =?iso-8859-1?Q?7kN2mlHd1e05XSuhUSsPf5dLlJZ8dNJkPxdFE0o6euzv0cqihwLWH1/c/7?=
 =?iso-8859-1?Q?yngFYw1OQ4CX3FDoU5RYg6KFulyenNm+AM+OYsOAZN8ES2KOO4IJwbvcYO?=
 =?iso-8859-1?Q?AShB8VuB0xlf5k0u2ugoCk4GsAGUfezvweTECR8rHieQnelDLTJ7fKTqyq?=
 =?iso-8859-1?Q?+8RFYZrSyRWY1NMk8baStzdASUDwWpubzA9m8yUp1U5uPsEUPAoAf6J53S?=
 =?iso-8859-1?Q?4bOk5SuVFcyZNZkofP0VojgrgInWOCASUkC07CQoizCZJfRzmLkXeF1dzh?=
 =?iso-8859-1?Q?H9nYd/IFDeA9QRUkSlz/vplNLhyBRf6i8LZvnQEgFvJKmDzzVscsgDnfee?=
 =?iso-8859-1?Q?eKAPOCtUbZTNmOBGowCxeyBqQfxnYezOjZdy1/y1sAast/zKiVtrV+g5AS?=
 =?iso-8859-1?Q?luy1PkwJXTtvX+uhzMH7+2kz0MAGIllG65mQTvGn5qHuvk2Pbgf0WMv4t1?=
 =?iso-8859-1?Q?A92sbw6r+MO2z2gwGWPhm3jSWf2Tj/RPWoae1dymOuVw0FFjGC4yXOjUD3?=
 =?iso-8859-1?Q?vOV3rsBYr/qu/TtOtbmI5B5wm6ims13Fdx9xnzWhg96bZVd92PymaYCYGb?=
 =?iso-8859-1?Q?HIyknBCNsvhf8eWpzZ2ElS+ZKU8cDkBzJmM3ApXKTF4apc+XwzkH+9EzbB?=
 =?iso-8859-1?Q?wmxAJPGB4gnPp7XKIzwJU2/HBIJuh+3N5y1ZTpwC9IN52TmZBpCeX0p+kR?=
 =?iso-8859-1?Q?FXCALjTD50leXKN7a+T1i9nzodPdvSvdP/HXmrzebgQH2ymOA7MUDZIZzf?=
 =?iso-8859-1?Q?3hIf6BUtMsHJsDOhTNUU7P17hnRip/Qp32PRtltm64+8wKG1QJFfGd8iiz?=
 =?iso-8859-1?Q?l90b3aYFFn0PsxU8qvqC7Ce/ppX6jR/v0rmMeLEinhXbbjYEwZtiLrxgmx?=
 =?iso-8859-1?Q?Z1/YWQK3UsLeUhew2FKFD5Bcxa6p8HTlMbUG97kVj8It7BHmkyQo/N755k?=
 =?iso-8859-1?Q?0eCHhuv6VptoZs5DXB/gadYscy8z6GIZVP8woIsZdNpw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR05MB4551.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8176
X-CodeTwo-MessageID: 2578d3a2-5d06-4e66-bb67-154206b5475a.20250825115838@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8f609af1-14a5-445c-b90c-08dde3ceb926
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|35042699022|14060799003|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?wjOWonpg8zUosFjyzmVQ+m5XJZ+TPrxjCXkfg3UgSLpxkVlE+zKi9Pv5nX?=
 =?iso-8859-1?Q?dbk0n0WWaTxsR7kQQ1xW01I1vfHVZJR9dVjPjTtfePuKy1mZvvOjTUpchx?=
 =?iso-8859-1?Q?mSvWkIYXXKO9qOicsKZKFZUWcL4S/jGWE9xS6dm7OXR7bcyM3nD1CVwfX0?=
 =?iso-8859-1?Q?ks83Jf0F9QcABbLvUkILAqrl2jjk4Vhn9rfFSv92OozYs1M5aMddeAQ7go?=
 =?iso-8859-1?Q?jxb0UPePz8mhApH4JIw3rzzECQDVTEn9BwxBpJIHt+10feYU8VLKdR0+W2?=
 =?iso-8859-1?Q?lXOvoVnl/NNZvxmSDvaoth7bcWkhiTmzoJIJUq4kf/OCKl7Z7i3Vy/ymLg?=
 =?iso-8859-1?Q?Yczn9mWWQ4BpMkIFMKRDHo8eyg0w3VJjD+CwlaR010oxhU0wFFkYqfLC2F?=
 =?iso-8859-1?Q?fkD5L2qOEqgcRdQhlCaZ1lfU/moIF27u56Rs2WXZvz3Opi4AupXLVZhqjn?=
 =?iso-8859-1?Q?lXPPGQZ3/uhPwC3bkMzWFP/SHvIiKKwnHjSuvOxo3b/dB8oI9FrCsWzBKI?=
 =?iso-8859-1?Q?kJTd4hwUfzTZdzxSVRXEZtXb8XxCzIXMcuVS+Jxm6KIrDwTaAABezsDfYl?=
 =?iso-8859-1?Q?xwViePaUA7K0uDSXYOKnB6Bm8HIh+tCjJV/x6aGUIAOxg7I8+ReSxnMbiU?=
 =?iso-8859-1?Q?jnxKlqdF99kAZ+FzT3QhRAdwjjROElG+P3oNxEhHc2p4uSItxFGdPJwvhi?=
 =?iso-8859-1?Q?7ip8v8Dblquubs3z4IWEgX72XGH5qSbv9bXZzAmv0zCgqzcah+AdU7grO3?=
 =?iso-8859-1?Q?uf8mz6LvxqazRzDdUTAbWttXDlqR4ij/5W4pLtKhU2BwTyDFsrH1ID7mf6?=
 =?iso-8859-1?Q?8STSSWaCiyB+F/u8DhKK4775ZM1uh10YQ3lKWs9/gRsmH9ULGJlD4RhdYU?=
 =?iso-8859-1?Q?Onh/LsVsy7Ea+gJ3JDEsrEwVCbWiz1R4M+HqHP2OmqQYR2SuGpx9dOoZJw?=
 =?iso-8859-1?Q?N2V59teZ2Cx2JyCfOPJv3K1tGRaYo4I3e4Y4f4CLh7n0/IyJXQ+E6y6KIO?=
 =?iso-8859-1?Q?DRkV26MbATS0IbEUwdzBYFvtgEZvAcWzCg8rGtDorLERZIMaDV9T3228Rz?=
 =?iso-8859-1?Q?EJTA6plEmPflUDfb2iETEjx+h2WwFFKjGPQEm3IFTZIsXNPLIWvm8Bh0Qn?=
 =?iso-8859-1?Q?zKeBOAwghBMwrHOcuxMzHK2Avbw8/muenO1oYUu24mQmGTQjf5Tn58DWaT?=
 =?iso-8859-1?Q?RM0yolmCzJ9MLiHOsOnapGG9Z9ZqyCYYT8+7c1Qjwt7e+lk5Y8o+GiKQeW?=
 =?iso-8859-1?Q?D0UuqT57FMn3QOJB+GVbXOxWOhhohXA9lqJtR4rUe25/AfjOhK4eogyflx?=
 =?iso-8859-1?Q?YmfkTQFNJBLUfSFjhbS4ODQIQFQRGUpoRgualnyeviPvlrOetR1XBei8Lt?=
 =?iso-8859-1?Q?kg+pliQ+hyynWWsMMZUxDSUtORg4/Ioh/bMjGbk3ZGBYk/58/LjhbGFJdV?=
 =?iso-8859-1?Q?b1V7eu8YVJCJya5Dc0IVOoRcs4wVzft5ARRqaF8F2deRiRuND3Ocumn1nE?=
 =?iso-8859-1?Q?rDLZ0TMko0r/W1Q5SQwXXkZCWSza7gZ6IU7aeQ29j3G1MDsDfw7b+ADjS4?=
 =?iso-8859-1?Q?MEwFXYJuOK0VntY/m28HGI83j/73?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(35042699022)(14060799003)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 11:58:38.8822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21694bc5-defe-42ef-cb3a-08dde3cebaa0
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR05MB10983

Hello Martin,=0A=
=0A=
Why not just start the timer and check TEMT after it has elapsed and restar=
t the timer if not empty?=0A=
It would prevent busy-loop waiting.=0A=
=0A=
Kind regards,=0A=
Maarten Brock=0A=
=0A=
________________________________________=0A=
From: Martin Kaistra <martin.kaistra@linutronix.de>=0A=
Sent: Monday, August 25, 2025 11:22=0A=
To: Michal Simek <michal.simek@amd.com>; Greg Kroah-Hartman <gregkh@linuxfo=
undation.org>; linux-serial@vger.kernel.org <linux-serial@vger.kernel.org>=
=0A=
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>; stable@vger.kernel=
.org <stable@vger.kernel.org>=0A=
Subject: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO prematur=
ely=0A=
=0A=
=0A=
After all bytes to be transmitted have been written to the FIFO=0A=
register, the hardware might still be busy actually sending them.=0A=
=0A=
Thus, wait for the TX FIFO to be empty before starting the timer for the=0A=
RTS after send delay.=0A=
=0A=
Cc: stable@vger.kernel.org=0A=
Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driv=
er")=0A=
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>=0A=
---=0A=
Changes in v2:=0A=
- Add cc stable=0A=
- Add timeout=0A=
=0A=
=A0drivers/tty/serial/xilinx_uartps.c | 9 ++++++++-=0A=
=A01 file changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c=0A=
index fe457bf1e15bb..e1dd3843d563c 100644=0A=
--- a/drivers/tty/serial/xilinx_uartps.c=0A=
+++ b/drivers/tty/serial/xilinx_uartps.c=0A=
@@ -429,7 +429,7 @@ static void cdns_uart_handle_tx(void *dev_id)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct uart_port *port =3D (struct uart_port *)dev=
_id;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct cdns_uart *cdns_uart =3D port->private_data=
;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct tty_port *tport =3D &port->state->port;=0A=
-=A0=A0=A0=A0=A0=A0 unsigned int numbytes;=0A=
+=A0=A0=A0=A0=A0=A0 unsigned int numbytes, tmout;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned char ch;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_s=
topped(port)) {=0A=
@@ -454,6 +454,13 @@ static void cdns_uart_handle_tx(void *dev_id)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (cdns_uart->port->rs485.flags & SER_RS485_ENABL=
ED &&=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (kfifo_is_empty(&tport->xmit_fifo) || =
uart_tx_stopped(port))) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Wait for the tx fifo to be a=
ctually empty */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (tmout =3D 1000000; tmout; =
tmout--) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cdn=
s_uart_tx_empty(port) =3D=3D TIOCSER_TEMT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 udelay(=
1);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hrtimer_update_function(&c=
dns_uart->tx_timer, cdns_rs485_rx_callback);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hrtimer_start(&cdns_uart->=
tx_timer,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_M=
ODE_REL);=0A=
-- =0A=
2.39.5=0A=
=0A=
=0A=
=0A=
=0A=

