Return-Path: <stable+bounces-172856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8146B3406D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18083B1661
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00811215F5C;
	Mon, 25 Aug 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="YlZ6sqtm"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6A944F
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127553; cv=fail; b=GXyk/qaBkcRnJi4tfLByxYFsbmxbKmSj34Ysy70JkMRY1bgxz6cPAEY+crW77PMAq3fB/p5c6q6kGtporHoi2ATPjuvJJiPZy+tNU3sRKCrRVF52jXKDo8BgsgPvL8XIITLnPvtEjVkzgF/BHIThx78OuQHApDoVYRwGSXeHmoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127553; c=relaxed/simple;
	bh=rK2I5cjll9eLY+i+uOz3MbHejzKox3YGrnC9OuDnyro=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SDJnHthHIIRi7B71ytUY3Iv+5ckrE+v0vsuLK3GmPGPTlpWQu/dbuVw3q8YntRN2657bETuYdh8GM+vt3pSH58Vl70dJ1Gb+HzWn8xtTUEzhbrWXdBZZOteHVVykGpIRswKWucll6jvGysWHuqt5RzNqR0wf7JdhOk/idCVPdRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=YlZ6sqtm; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns3SHKst21WXwktuAqs/J3VrDdVNxA9HdRCPj1RG/q95UlZugCYIaigTqp3bN2l3A9cutHtDf2SawZu1vpCZVaU/kynzuMvne+aVXJLC1l3wkftfpxH7e3qXmqK7qhiNI76iCDtMN6zwesi7PBBMmo/4LyjIYkq+3a9M8RTaMRK0n0UO6EjPcbbGRWyZaBncgpXi3KGseRPG7EznS/9Rcw1YbWKgsSu4cCbUCPr1Caf5+dPth3r3cM9gueW/QoJEe5hkKr+Xl8VciSQufSlkh/nUXAWMiLLbo3XJ7f9R9NKDu/32Dg/4lgkFB470jjIF7ZfrwD0uTpBt9lyisB441Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fJDHThggwJNbV07T5TtE3gbHYKMxs+wsSZiVDMLE9M=;
 b=CTUfrjuTPYFKphCdpZ2wMckRQ/iJyDPE+H5vvx6PP7Jzs00u+yuJgrew0pLm2mACWdSZmnpIdaVPZnYNXce23v8/EH1kGXB4cIonDvaeKM7633L+QMSv0J2FSU3mw8QUUqUOi/yPn8WEyglveQdQgyJ8CB/VCI5hljC6dovBNRS0Ntg851vpsklpzSgfGzNUn8K+ixxtH3HX9VFPnNdyoMpH5ebGtUtmDRj/VZUBl6poeEHnB4Ol0IPp8lwLHL6SOboGzb/N3yUaZuf6kPn6Oeeu2SbtWosd+bVQMP1iAwEo0j4iscbv6e2Ex6CEvV/LsWzmJPZXsJx6Cj9ltTJfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fJDHThggwJNbV07T5TtE3gbHYKMxs+wsSZiVDMLE9M=;
 b=YlZ6sqtmbQ+Glmk+4d5A/R1Vqc3L25y81l8/W86DBkRFbNLzBPMkKOAAEHKuBTbJkIYLykTXSMss554zQUuISKs+n59m2x1LBGeSVZfWVsVAWllXQC41MySdf8Xst5Qz6nN27qc6g21pWsL6eWdfKnj2TD5T3/PrkI4m+Ql6h5IYPOD5Wkbn93wwdYvGXnXbjrOkVFI3TjH6uA6dycpJOqO66MKVn4NtHdOmM+RH2yrSTnetuZtLdGf2wyevNsZyQdOV+vyb5efLE9nliULLwa6MuG27pOTJsh+roDxb2xnNL8W5pqKqvySLcE17+/ysH2GmKCn9bGyqUaRcd4ziXw==
Received: from GVXPR02MB8399.eurprd02.prod.outlook.com (2603:10a6:150:3::19)
 by PAVPR02MB9745.eurprd02.prod.outlook.com (2603:10a6:102:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 13:12:27 +0000
Received: from GVXPR02MB8399.eurprd02.prod.outlook.com
 ([fe80::e6cc:a47a:35a2:f6d2]) by GVXPR02MB8399.eurprd02.prod.outlook.com
 ([fe80::e6cc:a47a:35a2:f6d2%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:12:27 +0000
From: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "akendo@akendo.eu" <akendo@akendo.eu>
Subject: Backport of Patch CVE-2025-21751 to kernel 6.12.43
Thread-Topic: Backport of Patch CVE-2025-21751 to kernel 6.12.43
Thread-Index: AQHcFb+X2sIg1U0DdU6dPXyFMaS84w==
Date: Mon, 25 Aug 2025 13:12:27 +0000
Message-ID:
 <GVXPR02MB8399DEBA4EA261A5F173FE268B3EA@GVXPR02MB8399.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR02MB8399:EE_|PAVPR02MB9745:EE_
x-ms-office365-filtering-correlation-id: 042b8c5f-cd79-4443-27c6-08dde3d90a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|8096899003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6WZXsi472W5PgncQs82w9Opz327rqaAfeDDXEaJrcEOH12QFvsnWzmrHwAAu?=
 =?us-ascii?Q?HvjKePxuQzPrT7C3acK4C7yBQTTvEaFNSpFp3KNFuvDs7U5/uNZBO22AXo7f?=
 =?us-ascii?Q?v9+tQySP0gBVqZ4PnJMnkLl+MB/np6ZPvYQgY78sOWgisD0l+lEqe/em7Xul?=
 =?us-ascii?Q?4iNg6EmqcRSQxgCyCyZ2YHt1actykByX0PvMw6Wv6mSUMQEtgDlAmpy7BozH?=
 =?us-ascii?Q?j0mHMGjz+gJFUOP7o75b8cWlk2xvrhKk9e4y7YIph4HgRky9hwkw5SFoNshC?=
 =?us-ascii?Q?jqZJRy6tUONHVyZT1+HY3/Hw/qfKE0StYFzavkMtdxvALbcXXh9DyatLHVUB?=
 =?us-ascii?Q?Qki+4ZR91uXig3rT8Xb20UcPjQaVBcYOqQIlnvqnT/mb45LQkm4c8go8FShD?=
 =?us-ascii?Q?w4tYd74eYe2UYNZGPhDSZEU0uT3xzpnfQhIBqhh6utNa7xBxoax4Bv4aumIW?=
 =?us-ascii?Q?0tIgERrFE8AxjGGEjCl0EuW7JmGrlfUkTH3NvrI3iSIhvP18J2Rx37pICZcG?=
 =?us-ascii?Q?TF4lXtWCgpTiCBP45YyTLqQaaUN1Su1q69PB6vFFIx9RzsN8z26sdHrt9qwC?=
 =?us-ascii?Q?VY6/9PBg1K0YNJZSMq6nX79SQBUnnuoC53IYCcnFASytDQqpqctXhn5NP0zg?=
 =?us-ascii?Q?HQwGqFi8Njmy1JVg8xk32fESC4CpeqJohgNmhmpvAlP1ZoEzvVq7BTSnajc7?=
 =?us-ascii?Q?0Dv1RmsG7TbKIZO8bgvPs6LKiaYuENqDPqIRSx2AdIzhs1FoYl9U3o32jMzT?=
 =?us-ascii?Q?q6geBPNMZPFgj3qgO3lZdA1gANSnjOmGXdUbGymgrUyr1YKl4pT10h2xIBEn?=
 =?us-ascii?Q?Ueq18fUHFCeN4raC1uaDCex5L1G8BLJtgXOp0n7zk8swz79RlZcgl1ugqcDl?=
 =?us-ascii?Q?VV4OS+fYBWja59akoGMmvwTNznuakOAjDC9uosnJnVN+MJ9D0GKog4sB8weq?=
 =?us-ascii?Q?R+bX6CaPwaoel7J4kQqIv3Bp6StzRb1OwFQqjw1nAOYhVZ7bTCKmNHcsUQtr?=
 =?us-ascii?Q?NRWG4M+d3kIcIcIDGeodIeBNRg25T5aHMiWCznaCr4QDynnKhFdcBzW72f5e?=
 =?us-ascii?Q?hlEtoa0QCimXT2a4SrBIdSCxvf0K/WOcE4/pm12BT/oHgL2OOlaUNzlhuAx7?=
 =?us-ascii?Q?DFgFs+n4DeRywlOU9plReACRPTnzy8C3C4VO5mgsa6WFbZKPdBSu0mERM73G?=
 =?us-ascii?Q?yGhjAFihm8vvS6uVGpmR7xEezCH4KDpDVLnxc10dyig5gNUbI855c9DnFD/X?=
 =?us-ascii?Q?3CdFSLkJu59TTkHoy6OFS6xW/fwgmqYJxnBJHow1k101Bhd2ZnA11bwDpDWP?=
 =?us-ascii?Q?AYijhXNx4YA0hIp0y+vjM5wIGBw626GISB0og5UdBcryM/zmIOIB/ZmmscER?=
 =?us-ascii?Q?HCG+0vq0qYcc8X4JYeZtAkWo0KBKbyQnfnbP+HzxkzVT3XUH/+JkQljixFK4?=
 =?us-ascii?Q?L1Wx5WZRtQNQIRKXISGEzqgadCbBgCrFEpgV7g293s8Mcpn/4FoGHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8399.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XcHK9pWgTQX1boWkJ8ks1VWUQtcIfbrvlPdm3N5avKWof8xmBoJftGWBWo3X?=
 =?us-ascii?Q?bKIg1gcno5aWJZr5T/kUy/Wmf7QIqRR6kbO/kpeDcIwlzBxGHSrU6J9BQKBv?=
 =?us-ascii?Q?hfJIqueT077URKH4ZcH+zbSLBGt65fm+OxwvKEtd1emFcgMtD7ZbWwOo4J2r?=
 =?us-ascii?Q?Q1uaubsju5cW5mjqAeHkH6/8CENsKo7B0DgOKn31WqdBZhQjTY+P6O88ZmI4?=
 =?us-ascii?Q?CPi4QgJmkiAPOMgC6WUWrHBvqO5tS7XC1MWTheb2QPBZMFVfivvYKcfbWQmW?=
 =?us-ascii?Q?H8/GlXAMd3QIPoFmxqCHLy0O1558g7sgWPBu9gOnjsPdLhZEfgSDxZD0KXPT?=
 =?us-ascii?Q?pGhlShTAoOff191c17kCEet9kgKzcb8hJYgJxQkk3Q98U5MNgfihmDcFVPYG?=
 =?us-ascii?Q?NY1NUuBnExloZdItaWYvN5t+yNEunSLDq7yQ97h7gkkzQPkiojFVW/oQ4dKO?=
 =?us-ascii?Q?URGnCUoqxpHZQ6FrLSOie5JapNs1qRUVFt6A9Oes3giLrTs/WgFs93sly1v8?=
 =?us-ascii?Q?76PoZqCsIiRvc/tOFD7ZmkBeUgB6KPFey/jnZWdjxvpxprCR3wrDde+hmvgz?=
 =?us-ascii?Q?/LXpYWefJf/CfqT+IU21ocecUxPHyk7OICcWWOQHOJkK2rx4m6m3p4H85jWv?=
 =?us-ascii?Q?YZryCYF29IVJjiZaFf7VEv5dyhwijtQqbF2aMTcg+4/8zFrZW6ytw1kgGqv6?=
 =?us-ascii?Q?bG3mccMc8hOhQ/OUHMu2sA/S5aokzx2xtmJzA6rd+JcYtbM/RYI1bMj1J8iG?=
 =?us-ascii?Q?+T8d0UH1EsMbTNjf/viqMQF8avudM36fsfF7sUtlHLpf2sTR6RCgu2KilgII?=
 =?us-ascii?Q?vLpAfot+yu2m/JUeufRazs7xtWzMj9IeNjOdI4YpF6XPRvwY+CXog3o9Oo0L?=
 =?us-ascii?Q?exFt+8V9NItqoozB6LyakgE1Tz+xSD7R7ZNRj1Y87ZeEsaBOdozis8TOFhuM?=
 =?us-ascii?Q?SC5EEEXwa4D4KxdH8pg+Enyfgq0nv4v4ZXHQr15N3gblWrxsgIf5GdaUtf0X?=
 =?us-ascii?Q?9/QwkmhjxZ72jzj5A5ggH+spm3Gx6t231Ky5oHCmNye4WCjJHFSury4N2e4b?=
 =?us-ascii?Q?Ia3sGAod5z4FIkrxVtiyWOtaKy27tro9EiZ2U8zD4JXAQl4/ryEiMT9k+NIy?=
 =?us-ascii?Q?/PR4IxdDl/TTJq+4Fpt+iJssC6T8pf5X9+n9JWY8dVeToQ9J99KSLQh8bs/r?=
 =?us-ascii?Q?4rBM+Lr2xU3fP2JbZbTmnCD6+L3w3FdKS6hWmYAvE5MXtCvXV5q6rdZvKHs2?=
 =?us-ascii?Q?pHDXeIc0fbsqlV0eyiRuzz6V4C5pPCN4eBnc5YobLWYwELHDIwmIpiD8TmoJ?=
 =?us-ascii?Q?DorcWqkdvTirtpZIuBc1USfgdKEcoHzlhV6ULf0j/TZCukCCpJjKWVCWmuzl?=
 =?us-ascii?Q?ddOX8IY9D5AoMMumjfh//heH50deKpnfv9BR/dI72XKjNfKYlSLudvQb1JDf?=
 =?us-ascii?Q?pfO5Y92PGVcEercky8dxgP9WruIquZx+uRiWHpNXCViajTrxxxkd4wzR4PAJ?=
 =?us-ascii?Q?OMIphRehHZ3RXtcC8N7gLDdr0M3EfZNt0i44z6kiFbT0r8VHzjPiAa3FisgN?=
 =?us-ascii?Q?KdWqyOMUsw7nTs30YE+QXq0AJw0m2+Of8hB2KN0BmdNr6RAKi9tQ7rRJmGwC?=
 =?us-ascii?Q?WZWrxS59y6vw0qY/D22XAcs=3D?=
Content-Type: multipart/mixed;
	boundary="_004_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8399.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042b8c5f-cd79-4443-27c6-08dde3d90a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 13:12:27.2533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWv8LCaKIuZBOeXJ85xR6//ekBHi96Ewg/5jhdTJs2DmZNYUSb647PGbw3mC//0YxBiAIhfela/yQl+Kg4/DRK88RvU2SuNsYdJ2kQ4SLAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9745

--_004_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_
Content-Type: multipart/alternative;
	boundary="_000_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_"

--_000_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear Kernel Developers,

Hereby we attach patch backported from kernel 6.13 (as proposed by Greg k-h=
 on the full disclosure mailing list) to 6.12 for CVE-2025-21751 vulnerabil=
ity.

This patch was tested on metal and virtual machines and rolled out in produ=
ction.

I hope patch is sufficient for cherry-pick. Please let us know if something=
 has to be updated/modified.

Regards,
Sujana, Akendo




--_000_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Dear Kernel Developers,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hereby we attach patch backported from kernel 6.13 (=
as proposed by
<span style=3D"font-size:11.5pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#1D1C1D;background:#F8F8F8">
Greg k-h on the </span><span style=3D"font-size:11.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#1D1C1D;background:#F8F8F8">full disclosure mail=
ing list</span><span style=3D"font-size:11.5pt;font-family:&quot;Arial&quot=
;,sans-serif;color:#1D1C1D;background:#F8F8F8">)
</span>to 6.12 for CVE-2025-21751 vulnerability.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch was tested on metal and virtual machines =
and rolled out in production.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I hope patch is sufficient for cherry-pick. Please l=
et us know if something has to be updated/modified.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sujana, Akendo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"mso-ligatures:none"></span><o:p></o:p=
></p>
</div>
</div>
</body>
</html>

--_000_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_--

--_004_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_
Content-Type: application/octet-stream; name="0001-Fix-CVE-2025-21751.patch"
Content-Description: 0001-Fix-CVE-2025-21751.patch
Content-Disposition: attachment; filename="0001-Fix-CVE-2025-21751.patch";
	size=2448; creation-date="Mon, 25 Aug 2025 12:57:49 GMT";
	modification-date="Mon, 25 Aug 2025 12:57:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkN2VjM2MxYjJhZjIwZTIzOWU3YzQ4YmYyODNmZjJmMDgwYjQ1OWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBzdWphbmFzIDxzdWphbmEuc3VicmFtYW5pYW1Ac2FwLmNvbT4K
RGF0ZTogTW9uLCAyNSBBdWcgMjAyNSAxMzo1Njo0OSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEZp
eCBDVkUtMjAyNS0yMTc1MQoKU2lnbmVkLW9mZi1ieTogc3VqYW5hcyA8c3VqYW5hLnN1YnJhbWFu
aWFtQHNhcC5jb20+Ci0tLQogLi4uL21seDUvY29yZS9zdGVlcmluZy9od3MvbWx4NWh3c19tYXRj
aGVyLmMgIHwgMjUgKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWVsbGFub3gvbWx4NS9jb3JlL3N0ZWVyaW5nL2h3cy9tbHg1aHdzX21hdGNoZXIuYyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9zdGVlcmluZy9od3MvbWx4NWh3
c19tYXRjaGVyLmMKaW5kZXggNjFhMTE1NWQ0YjRmLi4yNzNiNGVmMTczMGMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9zdGVlcmluZy9od3MvbWx4
NWh3c19tYXRjaGVyLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL3N0ZWVyaW5nL2h3cy9tbHg1aHdzX21hdGNoZXIuYwpAQCAtMTY1LDE0ICsxNjUsMTQgQEAg
c3RhdGljIGludCBod3NfbWF0Y2hlcl9kaXNjb25uZWN0KHN0cnVjdCBtbHg1aHdzX21hdGNoZXIg
Km1hdGNoZXIpCiAJCQkJCQkgICAgbmV4dC0+bWF0Y2hfc3RlLnJ0Y18wX2lkLAogCQkJCQkJICAg
IG5leHQtPm1hdGNoX3N0ZS5ydGNfMV9pZCk7CiAJCWlmIChyZXQpIHsKLQkJCW1seDVod3NfZXJy
KHRibC0+Y3R4LCAiRmFpbGVkIHRvIGRpc2Nvbm5lY3QgbWF0Y2hlclxuIik7Ci0JCQlnb3RvIG1h
dGNoZXJfcmVjb25uZWN0OworCQkJbWx4NWh3c19lcnIodGJsLT5jdHgsICJGYXRhbCBlcnJvciwg
ZmFpbGVkIHRvIGRpc2Nvbm5lY3QgbWF0Y2hlclxuIik7CisJCQlyZXR1cm4gcmV0OwogCQl9CiAJ
fSBlbHNlIHsKIAkJcmV0ID0gbWx4NWh3c190YWJsZV9jb25uZWN0X3RvX21pc3NfdGFibGUodGJs
LCB0YmwtPmRlZmF1bHRfbWlzcy5taXNzX3RibCk7CiAJCWlmIChyZXQpIHsKLQkJCW1seDVod3Nf
ZXJyKHRibC0+Y3R4LCAiRmFpbGVkIHRvIGRpc2Nvbm5lY3QgbGFzdCBtYXRjaGVyXG4iKTsKLQkJ
CWdvdG8gbWF0Y2hlcl9yZWNvbm5lY3Q7CisJCQltbHg1aHdzX2Vycih0YmwtPmN0eCwgIkZhdGFs
IGVycm9yLCBmYWlsZWQgdG8gZGlzY29ubmVjdCBsYXN0IG1hdGNoZXJcbiIpOworCQkJcmV0dXJu
IHJldDsKIAkJfQogCX0KIApAQCAtMTgwLDI5ICsxODAsMjAgQEAgc3RhdGljIGludCBod3NfbWF0
Y2hlcl9kaXNjb25uZWN0KHN0cnVjdCBtbHg1aHdzX21hdGNoZXIgKm1hdGNoZXIpCiAJaWYgKHBy
ZXZfZnRfaWQgPT0gdGJsLT5mdF9pZCkgewogCQlyZXQgPSBtbHg1aHdzX3RhYmxlX3VwZGF0ZV9j
b25uZWN0ZWRfbWlzc190YWJsZXModGJsKTsKIAkJaWYgKHJldCkgewotCQkJbWx4NWh3c19lcnIo
dGJsLT5jdHgsICJGYXRhbCBlcnJvciwgZmFpbGVkIHRvIHVwZGF0ZSBjb25uZWN0ZWQgbWlzcyB0
YWJsZVxuIik7Ci0JCQlnb3RvIG1hdGNoZXJfcmVjb25uZWN0OworCQkJbWx4NWh3c19lcnIodGJs
LT5jdHgsCisJCQkJICAgICJGYXRhbCBlcnJvciwgZmFpbGVkIHRvIHVwZGF0ZSBjb25uZWN0ZWQg
bWlzcyB0YWJsZVxuIik7CisJCQlyZXR1cm4gcmV0OwogCQl9CiAJfQogCiAJcmV0ID0gbWx4NWh3
c190YWJsZV9mdF9zZXRfZGVmYXVsdF9uZXh0X2Z0KHRibCwgcHJldl9mdF9pZCk7CiAJaWYgKHJl
dCkgewogCQltbHg1aHdzX2Vycih0YmwtPmN0eCwgIkZhdGFsIGVycm9yLCBmYWlsZWQgdG8gcmVz
dG9yZSBtYXRjaGVyIGZ0IGRlZmF1bHQgbWlzc1xuIik7Ci0JCWdvdG8gbWF0Y2hlcl9yZWNvbm5l
Y3Q7CisJCXJldHVybiByZXQ7CiAJfQogCiAJcmV0dXJuIDA7CiAKLW1hdGNoZXJfcmVjb25uZWN0
OgotCWlmIChsaXN0X2VtcHR5KCZ0YmwtPm1hdGNoZXJzX2xpc3QpIHx8ICFwcmV2KQotCQlsaXN0
X2FkZCgmbWF0Y2hlci0+bGlzdF9ub2RlLCAmdGJsLT5tYXRjaGVyc19saXN0KTsKLQllbHNlCi0J
CS8qIGluc2VydCBhZnRlciBwcmV2IG1hdGNoZXIgKi8KLQkJbGlzdF9hZGQoJm1hdGNoZXItPmxp
c3Rfbm9kZSwgJnByZXYtPmxpc3Rfbm9kZSk7Ci0KLQlyZXR1cm4gcmV0OwotfQotCiBzdGF0aWMg
dm9pZCBod3NfbWF0Y2hlcl9zZXRfcnRjX2F0dHJfc3ooc3RydWN0IG1seDVod3NfbWF0Y2hlciAq
bWF0Y2hlciwKIAkJCQkJc3RydWN0IG1seDVod3NfY21kX3J0Y19jcmVhdGVfYXR0ciAqcnRjX2F0
dHIsCiAJCQkJCWVudW0gbWx4NWh3c19tYXRjaGVyX3J0Y190eXBlIHJ0Y190eXBlLAotLSAK

--_004_GVXPR02MB8399DEBA4EA261A5F173FE268B3EAGVXPR02MB8399eurp_--

