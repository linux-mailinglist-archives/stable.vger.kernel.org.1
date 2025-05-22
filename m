Return-Path: <stable+bounces-146070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF1AC09BF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1A41BC3310
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143702857DC;
	Thu, 22 May 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rpoF1ZLb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="0il8Vn9J"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775F1E3DED;
	Thu, 22 May 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909678; cv=fail; b=AdePAQM71/e/iOSzJP1nQs6JRoDPxI881W6VQOjrWjbaDxbFYLH67URG8a0q22j5iw4LXYlzcDayUQNNyrDDgzWGFK/hyOO74yxDZGkPGcJHA/syAzvzcI+mvRlcN/U8zcEHCQW/Hnke3yHbokxSa40SZ5/+U+DFmqvPnOEPU4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909678; c=relaxed/simple;
	bh=BhbRbMxl7VcMGNaQwFGwerSWAL32JdUM3izEHjFMdBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVpENOVbXnvYuvnCpN8v0OEZ/KKGEifZItWPpx2yj9pRGlYHdVs96pmxodmRvXftmsilYf4jSQhbhjCtfUMQEz28ae2+d0e0Gg2L4yPbDd3iViMgHBpRMHNxkCHrXM386WaoTxVXVNG1iooHsZaSUyRREMxwFV9qeCnDyPKahiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=rpoF1ZLb; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=0il8Vn9J; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M6ADHl003623;
	Thu, 22 May 2025 03:27:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=PIWIXQa5hm64sm6JZIFrFNkKqEL31fXodKLfENyIcjE=; b=rpoF1ZLbVs96
	EkY1UeLH4BjSr/KVFCjeN90T0UHtRRj+ppKJSFQt4rSSiQUD12ctrtMQlnJVD1ni
	6cv6WZQftXC9UChim7fJF7dQ3EDlDD0S9hn8AKnqCBZnx69ep4EENF66mYd9zj7r
	LiwizIA8Zatey+Tt/oKzrl88nWyB4V3A1XjXaoC1EgMJ4jiM8yg8UHL9h7KqG1H3
	4yKrgbDvIjUniFRhQJiUMsyQsDtljaoi06GzOdeEtI1F/6FoSPlmstD6QodskQ1U
	2MIKHp0cFJmuIti/OU+yFgacWMEauBqljVfGwl0yUXGK7T9RtV6EjE6+R9E5dnDe
	UlT/Kqa+tA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 46rwfq96sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 03:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=islVfwvfu4Rf9L1x2tH7x2gurvwzZmpjgiZyhACZ9YtksequTWwb4LulQcabOJdEesi4IFCFWf4ZTVTSYD8dvQSBJuJQisVjcxA5S/pF3d73GAftRyTY4hYbkaxt+I6gcKE8gDzQoNNhadsdphksaj84WrdY4gjO/gmYpRg22rPY8efCZoyzYijL6vOCvZfPxIZ7Y+bBd9o0m6F+oB5rn9UkkkGjjnTjcJAc98EXFxsHsca4UFzurvho+4EjgyDxN45E6JAwST4iT3kzAo+UaGuqeS/iEEsmwlB3e21FYBVdS83B5d8D2JDjl5N5vFdbuF/NWk/rHkHoHVCxwBs9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIWIXQa5hm64sm6JZIFrFNkKqEL31fXodKLfENyIcjE=;
 b=aTyHyMIiFhEChktxYAcn8CpMfyEP/oF3OAsYl9LO2o+r8MuS4+tEZsPHV27GkYVr1AJDYF5xos/VcYFMi7Mz0NCd6kf+IrWDGxSdohIyPooIZm8h9+jbwfLUi3UHy1LKuzc8ZXwb5Aqfqvse45DozOa1/tx6oQ2RF+TRwpFj4DOS+xNr7FOTgYarvAq04U6IMXI3HvobtKPenUwaCA0P8j6Ju7aQhTpUyurxawL2LPcn9VB6Iq8DLfnbyETX8A36rC4EnU+YVU2Fl0Sr/+3fP6lBRBYkJndFU/w3F/b3RJ6rGuKHfrqopp1TT1uaUoN5cwreZkhd3cc0DDE9ijZySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIWIXQa5hm64sm6JZIFrFNkKqEL31fXodKLfENyIcjE=;
 b=0il8Vn9J5JcjQ1j+1Wt27SUvrbb0upZ03fRoJVg+M/godETfG2to7BooXMDNUe1eSmhe0USr/zK6A+kUueA9gCA3QFFwDpRmrTkdK7le4TsMgjSqNLSgSLCfVk0MP8FrTu871STbINqlfEZc/2KCGHEUMs3g8A6zhJd9WoFVrhI=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CH2PPF2C798BB0B.namprd07.prod.outlook.com (2603:10b6:61f:fc00::25d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 10:27:36 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Thu, 22 May 2025
 10:27:36 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: =?iso-8859-2?Q?Micha=B3_Pecio?= <michal.pecio@gmail.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
        "make_ruc2021@163.com" <make_ruc2021@163.com>,
        "peter.chen@nxp.com"
	<peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Eichler <peichler@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] usb: hub: lack of clearing xHC resources
Thread-Topic: [PATCH v3] usb: hub: lack of clearing xHC resources
Thread-Index: AQHbibVtMdBQbgcSHUi7NaX2HmZ3QLPVfimAgAXvhVCAA4EhUA==
Date: Thu, 22 May 2025 10:27:36 +0000
Message-ID:
 <PH7PR07MB953881F6F9DFA2DCFFFA2F97DD99A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250228074307.728010-1-pawell@cadence.com>
	<PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250516115627.5e79831f@foxbook>
 <PH7PR07MB9538F4ED153A621B6BD26D5CDD9FA@PH7PR07MB9538.namprd07.prod.outlook.com>
In-Reply-To:
 <PH7PR07MB9538F4ED153A621B6BD26D5CDD9FA@PH7PR07MB9538.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CH2PPF2C798BB0B:EE_
x-ms-office365-filtering-correlation-id: a9beeb33-c199-4374-4d04-08dd991b4536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?oovDSbFS0I86M3adFAzkDSxBITJf3tmLTJ4rgXl9frf28paPe9z8QeHUM4?=
 =?iso-8859-2?Q?je8JVP78gwYOnt4JL923jqoJIC3DbSwqwoI2XBMQC1Mq8BuFirnZmkc5DT?=
 =?iso-8859-2?Q?rVlGoUYOdZoaFVTX4IkxLz38/tdjKvRG/3wkwkmws+riEQXeDKZ5c04SSv?=
 =?iso-8859-2?Q?vlqHM3O920Pg0uhRi9Ioy9LSkQeEA2qUqWRAZjJYDX2s423mygX0170ZsI?=
 =?iso-8859-2?Q?GmArGAydmn9gg9BmrcEVH/tIp7rvsZGu5PvBktfemutpPTzVfJj5JixHAP?=
 =?iso-8859-2?Q?cDT83Js8Er5aXConkh5/YoWTwazcAZwdzjB0LExLGJ+UubQ8WPz2oJ8Qon?=
 =?iso-8859-2?Q?vBUw/URCqJSeo88SC15yBH+kKb5ncogP691H1B9W8eNd+CHcd6RuC9ZYGS?=
 =?iso-8859-2?Q?NggKGsmWaXVycK+0uCpj1VA5OO1nkd6MzlVA25vpi3BUzj0HE3Pemy9ay1?=
 =?iso-8859-2?Q?wrtNQW3afleQsJC+/kYQUt0MABPO3ajjPtLS76ic456S+n1eO9jmkrB1g6?=
 =?iso-8859-2?Q?R1g8IRYG1H3cRTAFMtZV1MLmMjgAtFJV2spXMGoELbTzYq2WcaAZOzTgFD?=
 =?iso-8859-2?Q?vZjh6iDZCcWm7THwR/2EgFT3ouRD3j+AW8oA6EmOWK/lYiCbhVZysxDlj2?=
 =?iso-8859-2?Q?ijU7nLWDWDwJ5ZYFsopsruYeMSs5BOt+97T+1qbFkdPqX2PYLVXarwpRbm?=
 =?iso-8859-2?Q?/KyCfDT83JTvyW3jTf9NLq1Lb7WRof3MQEOx8leBUY6De7h5NVJuVAAUHg?=
 =?iso-8859-2?Q?JERC1L18sLPR2CFiSZGhuGV983zoNeR598e+IcW9GQ39+zEj0gcybPPDe+?=
 =?iso-8859-2?Q?BPV5EZLvFeAXyjRCJtnkVyOzNXUw9qDQ/rlkT3qkqYqu+79l/tMFZex00J?=
 =?iso-8859-2?Q?8XVmx7Dz9tMzJ/HQjZUqmzHLdgndK4pRRFBGyGXRmvO98v6MF993n5KtQq?=
 =?iso-8859-2?Q?YBjhGtPZ9V90v/hm5EXxWwDxgmyBrPr/SgMeW3YmxPnVMvNZ+9ef+vW3Lb?=
 =?iso-8859-2?Q?3MwcmFZTC0AcpoVLr8e2GGNRoTi/bwKqmukGdakPP17VRo3WsVKh1/fzcH?=
 =?iso-8859-2?Q?hZgBTMXXY/hbdcrukSdHpWsoTuTH4Lt+Hz1aCjHsHAVi9Um1DEzUWfGazP?=
 =?iso-8859-2?Q?1W7sdOHkshwas0WEqoRrXF0i2qAEgXpDmiL6ceMnr6U6Ns78WYXI/hyXe6?=
 =?iso-8859-2?Q?Z3Q2SebkgDkGRYZljx+9svXzoVLrOsz9SSZMqatjG5KD05CzrjCVgkW32H?=
 =?iso-8859-2?Q?Z+C/JfOsnYEQI9ErmkeCosfPIcVjN0ictNK4jqQOsCaWTO1Nr4nuE6kqk1?=
 =?iso-8859-2?Q?Jtd0OLqAFTks5LzswK7Js5yoKRv4YwnELO4QAcPy7aRCsF5AP1Uu74BqWK?=
 =?iso-8859-2?Q?Qq34e8tWFSpP3CJ10b1fzRv11gASrrinGIiVCrKP+5QpDJOku2wbCFrJmn?=
 =?iso-8859-2?Q?l3PR0nj7Vh9Mgn/roFCVffqS4qg/P4owax+6WzGeYeFOLyDO4XP48LKjhR?=
 =?iso-8859-2?Q?o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?rcG8dx9/IRF7aFeizTZF5yXnz5eG45BDT2vA5dHHQbyUjsZjkjQn9KXDyU?=
 =?iso-8859-2?Q?fDEqV6PA9vUdHQhmxL7cAH56c2blHEaWLZAdQc1TS2tUENO98R9e80Tl+A?=
 =?iso-8859-2?Q?nYTU4BG5/IbusB1UhmHGRu5zMquvWX9EdPBAonxoFpfKxknTrxb1tOx22n?=
 =?iso-8859-2?Q?f80vZYUl0SXB2nv1T1DBP3/7O9BFyMk0w2bKVDje94bUiIxjy4NY4kZGLJ?=
 =?iso-8859-2?Q?6kz3q+BiVV4chxf9CZjg6Lb5d7B1QvrTu8ALdCkFpPdmQD6jQOf+BXDQpi?=
 =?iso-8859-2?Q?4fKGiHY+rWzGfe95e2YSb6f6usVWWoYK3COGzmxOdFRjxzsmPCuQC92YyR?=
 =?iso-8859-2?Q?B/5Gw24lFqghl3RpMjCWhNOmF55+yTcG/HWJpP9LzjF+VNk+qDLl72SWKa?=
 =?iso-8859-2?Q?075dCQi/QDnf4fCXBojxRE+4m3C70QfSF1kVOk8yWig41NLFI4oSZwvh0U?=
 =?iso-8859-2?Q?zXnzutkclzbkLJVEm+MKNZ9Mm/GKhqq3w5R3OmjP7HSDJMxlSTROoK+n5N?=
 =?iso-8859-2?Q?FV1sQFvKcmL5WVpoqoUsmNzTVUgx42YPDThnh5VNp9Unn+dbtp/wcZkLhM?=
 =?iso-8859-2?Q?tUxH/mae1i4lNqcPm41QRH/qw+f/Jd429NiRUPDk91oWPcsU5k+90ERajX?=
 =?iso-8859-2?Q?7o1xXBeRunvmvzPYgBFhgO53Wr44o6ANG+fGsnV2M8Gg9rx6lqQlABwibl?=
 =?iso-8859-2?Q?a2FfCNhl/wA5arAm3ruJBIz3zpDoY5v8GtOrV5mR4kvyXuGeBjiv6NcNY9?=
 =?iso-8859-2?Q?t0JP8XYLJODhp973KQsKzquK3CW0Td8pg4+BK7iCJJaHcR3n16+wFsCyjU?=
 =?iso-8859-2?Q?ro/VoiOUe+G5R58unrUTxK7/uCupN/7CLwf27/0P0PpSbbHghwhJ0KLzwU?=
 =?iso-8859-2?Q?MW1a4Wj31Y5spa/Y10dV1ylXoSYlcoSTA4r0xS9AGGbfh/GFgrQ1iwr9ry?=
 =?iso-8859-2?Q?+zie9+qORE/BCyn8/ejreQL9TlyvWcwDYRw6KZyqlpvvpIBn6j5AtKXl2W?=
 =?iso-8859-2?Q?XkydWaWvZDlqQVZNyzobaqvlfNQi0M+4MBNh0EQGhzJ1k5Pdfh7Apfcf9U?=
 =?iso-8859-2?Q?Nvyi/HdDOc7sZIsAipT2ww9kTztWLsFQ7yM2xaMVImPNYy0G3M5PWB9WqG?=
 =?iso-8859-2?Q?TVB+ErNI3yV9xoqv0rukmcUxiJH5sJGsjksd6y50fvRr05B4GLPMLinPg/?=
 =?iso-8859-2?Q?Vzxm4n59emYtT2Bt7V+EgqDgAOlIB4CpTELiSMcinoPiH1qtHFm6bNrabf?=
 =?iso-8859-2?Q?Sy1JDxCcV6tfjCL2FAGtKl3STihz8XPDCW4Pz1btUNaziaf2KuALEanulk?=
 =?iso-8859-2?Q?lvf9uA2NogRcgA6Vm2uHOJFNF8TK3hs4v8urmky02mCNv+GvO5D7Mt3WWM?=
 =?iso-8859-2?Q?CHaXHJMnBgte9g/9qZe771IXgmk3Yd9vamkxDLAYYmm1n1hlJFEsl/SQs2?=
 =?iso-8859-2?Q?cVrUP8mc1jH6/ebQedAQVm2P+OpCs+ZzGr2bu3qFWS/1QovD1GPDyI76dP?=
 =?iso-8859-2?Q?jDZJtoghDBKVdV8jCOZvC2saQHOKz1RyWBkRmMxcv74O8fxpLxZCjTBoPo?=
 =?iso-8859-2?Q?reQpCnulRJgM2wqz5vLJD7yhta46zHNYaCYJO+B/MxNzaTRsbGmfGD5z8V?=
 =?iso-8859-2?Q?MIKybN0Nf5o187KCBsGTPu9utRLUD7MTOT?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9beeb33-c199-4374-4d04-08dd991b4536
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 10:27:36.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwH/vctfK1OHFjTn1eiwlgMN9BW6ABcpZwG3L6T2QB67JZmCXUs6zrFrXFrjHahroC1VI2dT2b/6B+UIgPqQ2sJhMnq22Wf3R0N4RSfyXnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPF2C798BB0B
X-Proofpoint-GUID: 5RqBnvk_J0rwPXioFmtpfOL1t6rDZQry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEwNSBTYWx0ZWRfX2jqaFBBGVnLC ropbvNx9k3+8sSEK5WG3QYeXVxYU5sMwO39VsdpUZWiw9a9ML1/4/YwU1tBL0R799vybu53LMU1 5+p9UZkuI6RBoCNBG9L+CQEpEP9v1dG7OxWNaruTg+RWHggGffIq8O+M3QItyciEie7HEjzko5+
 bV9CqtSyWIevotNecadwOe8z7ZPOUukbDpfOFaIMGN0Nlh01UkoUoM2JEDkDG2ClANQ3++iQgJt mAvvBPqDgb9RCPehfcGifUaQU2RbCXLRaKCtr4kd+AmtBGr5VafY/FBs3aPWU5+NWUnR3nLywe8 wvMgguhpQFTS+zXUPpb6DWnN6qsS06C7sbmuZOfo0t3F8rtB6zqsJfywTfF9f0ivo1zzBOFJpIc
 xMj+bKcpB3Zzs4ujGx095IKhr6XXygqNdGX1d0MDTTApeH17Y1pEpH6ouQKPrHKmgfEJ5ANc
X-Proofpoint-ORIG-GUID: 5RqBnvk_J0rwPXioFmtpfOL1t6rDZQry
X-Authority-Analysis: v=2.4 cv=XuD6OUF9 c=1 sm=1 tr=0 ts=682efc1c cx=c_pps a=rPWB9DPlu1VaKM/QD/CSBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=VGop_ogpvA3uZrVJk4EA:9 a=jiObf9B0YAUA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220105

>>
>>On Fri, 28 Feb 2025 07:50:25 +0000, Pawel Laszczak wrote:
>>> The xHC resources allocated for USB devices are not released in
>>> correct order after resuming in case when while suspend device was
>>> reconnected.
>>>
>>> This issue has been detected during the fallowing scenario:
>>> - connect hub HS to root port
>>> - connect LS/FS device to hub port
>>> - wait for enumeration to finish
>>> - force host to suspend
>>> - reconnect hub attached to root port
>>> - wake host
>>>
>>> For this scenario during enumeration of USB LS/FS device the Cadence
>>> xHC reports completion error code for xHC commands because the xHC
>>> resources used for devices has not been properly released.
>>> XHCI specification doesn't mention that device can be reset in any
>>> order so, we should not treat this issue as Cadence xHC controller
>>> bug. Similar as during disconnecting in this case the device
>>> resources should be cleared starting form the last usb device in tree
>>> toward the root hub. To fix this issue usbcore driver should call
>>> hcd->driver->reset_device for all USB devices connected to hub which
>>> was reconnected while suspending.
>>>
>>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>>> USBSSP DRD Driver")
>>> cc: <stable@vger.kernel.org>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>
>>Taking discussion about this patch out of bugzilla
>>https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id
>>=3D220
>>069*c42__;Iw!!EHscmS1ygiU1lA!FD7UdYLwKPptb8LI646boayHRFMR7zLGkto
>3
>>rhb0whLx1-CVUGaYVVgrG5Y6EyLj-QcTuuUHSpaZcVPaTTRM$
>>
>>As Mathias pointed out, this whole idea is an explicit spec violation,
>>because it puts multiple Device Slots into the Default state.
>>
>>(Which has nothing to do with actually resetting the devices, by the
>>way. USB core will still do it from the root towards the leaves. It
>>only means the xHC believes that they are reset when they are not.)
>>
>>
>>A reset-resume of a whole tree looks like a tricky case, because on one
>>hand a hub must resume (here: be reset) before its children in order to
>>reset them, but this apparently causes problems when some xHCs consider
>>the hub "in use" by the children (or its TT in use by their endpoints,
>>I suspect that's the case here and the reason why this patch helps).
>>
>>I have done some experimentation with reset-resuming from autosuspend,
>>either by causing Transaction Errors while resuming (full speed only)
>>or simulating usb_get_std_status() error in finish_port_resume().
>>
>>Either way, I noticed that the whole device tree ends up logically
>>disconnected and reconnected during reset-resume, so perhaps it would
>>be acceptable to disable all xHC Device Slots (leaf to root) before
>>resetting everything and re-enable Slots (root to leaf) one by one?
>

What about such fix:

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index cfb3abafeacd..46e640679eac 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6093,8 +6093,8 @@ static void hub_hc_release_resources(struct usb_devic=
e *udev)
                if (hub->ports[i]->child)
                        hub_hc_release_resources(hub->ports[i]->child);

-       if (hcd->driver->reset_device)
-               hcd->driver->reset_device(hcd, udev);
+       if (hcd->driver->free_dev)
+                hcd->driver->free_dev(hcd, udev);
 }

It will free some resource and disable Slot from leaf to root. Later during=
 resuming process
one by one Slot will enabled in xhci_discover_or_reset_device function.
This solution passed my test, but they are limited.

Pawel

>Are you able recreate  this issue with different xHC controllers or only w=
ith
>one specific xHCI?
>I try to recreate this issue but without result.
>
>Regards,
>Pawel
>
>>
>>
>>By the way, it's highly unclear if bug 220069 is caused by this spec
>>violation (I think it's not), but this is still very sloppy code.
>
>
>>
>>Regards,
>>Michal

