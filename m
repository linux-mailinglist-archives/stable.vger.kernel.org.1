Return-Path: <stable+bounces-216038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNCOB1rzjmk5GAEAu9opvQ
	(envelope-from <stable+bounces-216038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:48:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537A134A4B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F28308F2D2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACE34EF11;
	Fri, 13 Feb 2026 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="F2vT8u+7"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222134F256;
	Fri, 13 Feb 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976060; cv=fail; b=QGyqclUy8idrTwIuJvJ9xmnRnwI/MdJ1n7IRjSVaZnr5Cajsq4eZN8oHWUOdibPFfdDMglWLWvgyCIlD/iV9A1ZmXat4a7wxgfiDLq5SoUSI5bCBGWO5+nK4PrcImUYvz2lFq9NUZG0BPzYGqZtBBg7KRY/ij0koCq6pZO25In0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976060; c=relaxed/simple;
	bh=6VIqbNvGs6FYrAys/QuJfMFGAEyOmfm4PLllvXkPSUk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PkvwjNCbbppsfGW41lRZXcwjF/Z3DtO8UjQqCrO5WBGtD26Ai9HjdHoFGEkBTG05jYRiHEIyorYRBaqWBsueCIdwIiJL/mzr0SGoLDLV0BtWKpYc3tlvK6C+G64AcbHDSLnDHUoa/Or4b1XtXleSddK+V96ww3LZcF1aMw+aLhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=F2vT8u+7; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVo+H4jn+7TY9ERVnNrGZ6Uz8ezXx9QZR9Gh55qW1lgFF5F9g2ddW0p0DkF5p7l33GTXrmA6CoLRDMTlOBQkVUmEo69fOwdx0kzI/iamAxCS0vivqd+QfmXIN6kssa1nbhGStcGDualz5T7o1940kYrcOsvjx5aaOpaIBSA3e3KP9IL8QPWWC4LYWBrhwZw/m+Sx9Yte9O6uZdECnlWKZLWgp9hDG6IISyOyF8bCJO8OrHGT6f7sB6fpKHqsEcmTLz8iq4QwW/l9eNrYN2t7FkrkcRG4497cFqu+ONAfY4NdKB5KCQqq9moLB6vogXIMOebB1CF/bGMUt6XvwkNOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhy288md5Lef23hUC7HftY8L7GpzVT+TiqytaOBfzYc=;
 b=jKpjgC2BmMofhjuD53c7hMGlulJgLZSW8wKJZLHahRd/Oa/yOlYif4vrvCm2nCuvYAUWs448A79+VZO2eAyqznrLI7OrsGl+9sLJbjTnHKPOr8ExhNKrdCyqnJFRBKVGQNmC1JpOsnXuxBNtpluQZt9z83v9V9P5SYl4QrYz6J5iXvMO0msbL+Z9Wb56vN1vAIVtjBP3GjxnebnDoYsAXbeZ1YUNEw4Sgm1G5OyK6J/ACPwSF+fJhtk0lvW/9d2ZNPJNUtaKJHi9k8oDrPIo2PK+JNK3YeZ/Riamr6De+G85urpICLOKRE+FDbRJINTl/lqUmSb2ghY5YGMaLTzcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhy288md5Lef23hUC7HftY8L7GpzVT+TiqytaOBfzYc=;
 b=F2vT8u+7lRJTuLKn0htWu2SZrSb/+hS9XF2Ldt0L0mNgtZx0Bgdp8yOpb7lVBZiM/brnDg8sj7YrkkPgCiy+Cy47HLINV5x3Tfv4MlnFIBAzfIaFvVxDTKCjiSWstl95P6CclJyVw8Q/8/ETpJhiv4CB47ZNlBDXJJzn1hMzqDIcrOBCxmj8eXeyJDPWl69MVr2uYFkGONYWZCJzZIKOTUq1yawl5h+t93hsgXJ0mIxYR+OgUBgqvzhOto7bS4e+ezURUSyNACWOA2E5JJRguJm50aLz0587vuXrSqkM/LFWgMlb7EgcG6ATqdjZ0QzIYGcaOoAF+Oh02bsqii59Vg==
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com (2603:10a6:20b:2cb::15)
 by VI0PR07MB10840.eurprd07.prod.outlook.com (2603:10a6:800:2d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:47:35 +0000
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef]) by AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:47:35 +0000
From: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Philippe Belet
 (Nokia)" <philippe.belet@nokia.com>
Subject: [PATCH] uio: fix uio_unregister_device
Thread-Topic: [PATCH] uio: fix uio_unregister_device
Thread-Index: AdyczTOwZ9hpJI5oTQOYiXyEW2r4HA==
Date: Fri, 13 Feb 2026 09:47:35 +0000
Message-ID:
 <AM9PR07MB720434A2B0CC99BC0BDCD74E8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7204:EE_|VI0PR07MB10840:EE_
x-ms-office365-filtering-correlation-id: b3b3b501-b24f-4ca1-979b-08de6ae4eac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S+rD8b2NUEXL2LeG/a/Q0U+mFmZqD0DbBVthvTDYZu52wgd//aE3BrFLyJae?=
 =?us-ascii?Q?+RqxUjeYybSF5IpmUso3e+C1LIOzU6yk+ScOxjgFbbdb+OJUNNaOe6DFZ48i?=
 =?us-ascii?Q?Z8Go5SRdxkZag1E2t6zcTgNKaY+iHKLXuznEjqNAqbRLK3X1GvRnRLV1sXd2?=
 =?us-ascii?Q?0P0hmEwpwjM+CytLt1ckfUggQ7adX/qyXSL0GQ8qFxzh3GyOBZJMwc6R0fYG?=
 =?us-ascii?Q?lDkDawoHTE285aiJJAM5qYrjEAay4Q6z02qbkEDb7AOd9Z8jxYfjiXjvU23I?=
 =?us-ascii?Q?KIAeasAQRF2fNzylbAFxdS48mNcN718hlzyorAC8bEYzh4D8hDQ1GraFEcFZ?=
 =?us-ascii?Q?0y8P4QiqtMJ2Qxa8wsOLS8/7YYUIveK2spIux+/NQ5pXoKdTFMsyT+jEuXIP?=
 =?us-ascii?Q?puvmIaFfOweGG4w9Wt+beAYn3cHezZnQZIDrYGWqRe771KViAILW2dQ7B8bs?=
 =?us-ascii?Q?3v+jXEB+Onj24GkvkNWNGIYiyPoECVHmdMi9pP8YyRHOxJ74PQJ5gD3NHu/z?=
 =?us-ascii?Q?NZ5SKMrNo23LT39e7X7lmfBkycBBsSWIQ++e6J9JsHqVCR16ozI0f339pPRE?=
 =?us-ascii?Q?TuL2wZXTAUB2pGpW1FEBG40QM0B0nKSossX2FPOK3z4GpXxzj6H8xVxRBGrr?=
 =?us-ascii?Q?WimaNfMJbZkDU5acd/2eHIqwngAQ6jT5ktrab2KtcdvQwF1AH2rOJy71kb0C?=
 =?us-ascii?Q?pky3kLHmbTLUIDrGbJIUwKdeTKmFKNvFQpoK8c6rxO4IVjOP8ITlq77/NYm/?=
 =?us-ascii?Q?jRCskURR0OjluaO1Z+eTaSYxXKpwqUvN93oWLzc7csrm4MoqBibXnB7eVCjG?=
 =?us-ascii?Q?+VT8sZvomu3K87zuF2dEcZDNVU3aZCtIqR9KCNPD4KM2ynFshO7PkfKIgg3a?=
 =?us-ascii?Q?OIfC+YGpUFdXPCraqHLpFZqAIpet2y0m/F86MNGL0qdWAuejqQdgM0g2SJe6?=
 =?us-ascii?Q?DTrYm5VEcooeHOXT2KxJIQHYL7jjI2a05G5+8QLvC1Y4ggcDwegakdhYE67B?=
 =?us-ascii?Q?8tayl1cZnRXtz/Y6dIBANC0nDDgBRc4X5dt5Q1bjZgJOWPedtqMpdfYVO9Et?=
 =?us-ascii?Q?io4le9+PULKHQ+As/Cyr+vDWGA6Du4ccAJqZULz9zZY0q9jKLdLI/lgZetZd?=
 =?us-ascii?Q?HLylkMEPjkWpAsb2CUCvus5vt6ubXbd9mN7kn28y6r63biMlz7tfws2A6Gkp?=
 =?us-ascii?Q?k/yBAXAJNd5dJ5BN1jhHJ33asWD3Yy1s7K4CJ2mkbDYZ+Uz38NXaXw5yVe5D?=
 =?us-ascii?Q?HL10BAltcSPeFH1BMuMETsM61Js5D5YPuEBjTD82nv9A9bKycajVIaCYj6Ba?=
 =?us-ascii?Q?JKE9SqhsvuVj8tqpePN6cJpPblRI9fn3GSZsyWUKdGf4maQm9oK1zMbF2n5l?=
 =?us-ascii?Q?X42lAdGqhO9DQFXNYRklUQ0PpKw0FMv0UvD9doMM4Pvd/WOyUJPIbH+DbMhv?=
 =?us-ascii?Q?W+KhPDzH7O0wmYaRvHm+BoAX/FaNkZ7GnQTGUuHZ7e2Ce1zp3J8AoeYkVJxZ?=
 =?us-ascii?Q?papeVhavG1B6w4xHEI8X6yNjcuhANXdhGVFjTXVouJsM3T36HCjn/ocg0XOE?=
 =?us-ascii?Q?AWDj63/JfFnbsoyL5d/y+E2qCOBUC9xABu6eML9W/nQPjcog6OAr5wIIKpoc?=
 =?us-ascii?Q?5SISIq1ix7YQrBXEzLUTku8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7204.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uKLbYq31nBJwU7cIpKwEWWBQlCh1HYxOZntCLiRoj0gXcNMVrKyhadtu5dDh?=
 =?us-ascii?Q?vBHSt8G+U00ZIle42aO6jokoaWqs463JqIN5K1cLq0rruIj/LCEHERGfMbvt?=
 =?us-ascii?Q?jGnf+IcXSx7hB2HSR7W4DzP2+XesxO7KNcDjtvh4ZfiAythIz0pCEbUkXwlD?=
 =?us-ascii?Q?rHLFXqEMSqQhDDbKUj5DQHeXHbNsKV+5k8LeSOpecj+2nBKW+UH06WbL9bl0?=
 =?us-ascii?Q?gZR0nhvMDe3PqMI2YC20Yyg3zpxNyzfHpyykJmuu/RF78L3W59exILgAV/N1?=
 =?us-ascii?Q?jVeFPs9Fg9drpiasXTHYjnfM1/hHN2ZGix/O4SN4Ko9yyr4QORxCOr7d9FoL?=
 =?us-ascii?Q?BOr2/DS7C4KuprC0w0FZG1OvWojwQevUY8uetmU0Lx0EtGWQQtqofSS/qFP8?=
 =?us-ascii?Q?v81pcsqA+9NNf/9X1OlWzC8Iu3aXAiMYZOWfv1aeva3/H3hwyHU7FAC0l5Fc?=
 =?us-ascii?Q?oYOFeP27z4iQJ3p7DGigqePg0ryzfozNmfg7iqsjgljfWAi3OxikrCSs4jbv?=
 =?us-ascii?Q?I/3R0qT3Sq+7L8W6CGQiGRnX+KyzJHDA/R3silWM/zBBti7GHO5iCvsXmC0i?=
 =?us-ascii?Q?ZdjmekG/2ukyd8jyzwxqhGxNN2EU62jFkbllqYz59Uhmu0rmjLBoo2tTmNiC?=
 =?us-ascii?Q?F9CV7LLzyQclkbqTy8ey9sZWuXUHMCK1oq9vm1ABLCtOM9caDBhYThWvj20w?=
 =?us-ascii?Q?Iw2cFfx9W44OSWDTZ0id2YIF+k/qFGn4/iUEHTklSf/FmIlazbieRSXika3c?=
 =?us-ascii?Q?/WVht8DH5otUWllUmm4KmT235Q64C7wtTs5IQi0A/EePus5GMjF6eCs/cczX?=
 =?us-ascii?Q?LOuJtNJvO30jCOUfHbRg5QkwbYgYwww9sprQlCaA0hO6r78sUIMH20ocv8bi?=
 =?us-ascii?Q?lx6e62Xn+2oIHTuGM+jiQri9axIKhK0uDDoOcCvU2k9aTS/bwqy/zBFnZZUE?=
 =?us-ascii?Q?R6kUQGvrPKUTxY+NVHKsTEDYO3KtiuZx/rrrNDt+iNDjrKmiJwGYi4vcHeDz?=
 =?us-ascii?Q?SWSqtin1C+zy9419KXQ5tEPMgdgVPtEqQbTkgAzEN44mcSWkmmWoriYoHgG1?=
 =?us-ascii?Q?+tUQBQDkv0nlsVrdnqnFhe3trCeoAc5NLRkRJg1c05TNYIeheKsWwGVNroc6?=
 =?us-ascii?Q?uoJWqNYmHqDIX5uosvGyvPgvlFW/KwcFNsNGifi4LLx07mfs2Pm1kN+M8s/Q?=
 =?us-ascii?Q?olUM70P3jBdltdcXcpOrqfZpv2wZFA4WD++DGzn4lJug7GUdhdgK0VylaCuO?=
 =?us-ascii?Q?xNKmX8k/gIleBBzjaFBy12ry7vfMLDD6HhN+v9S5Nw+0olBnBY1fy6rnTKoM?=
 =?us-ascii?Q?SLqgE6VsepFMUw367AnPyPPi56RShWx8V8jqanmes1bAxXdqUOMAuB7ligo9?=
 =?us-ascii?Q?gaVTIsqCWZxvunnRJpEQ2gUqj9pyaqg6/k+Za/MeXGFK1VWKJUhX+Iak/0Cu?=
 =?us-ascii?Q?LqtdlEMlGPPtnGMgR4amLXScvo7zQ3QfAvkkdysWeQJR8EfVmCR1p8wTLh42?=
 =?us-ascii?Q?eXgpcxYVevio4wpYj39KDu9sKcUYALqu8XN7cz00NZuv/pZnYqIGNcaF0+9w?=
 =?us-ascii?Q?DEM5Yxhdkx1t7siEkySz+nD+ejki66ZZXNb1qHBAqhEp+vZQm2RPzf4CXzlW?=
 =?us-ascii?Q?SnBcdByKcmRJkfEXFg5N5p6nRYaeWBZiFXst/h7C0EGH0uIgcMCWu/YykEja?=
 =?us-ascii?Q?V6j7L6rcRs0HqtEzg4FfG7zeNqNfLWxegZ0aaeaAGvpkDC2+1ObmZZUonmAR?=
 =?us-ascii?Q?R7iLI+p7pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7204.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b3b501-b24f-4ca1-979b-08de6ae4eac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 09:47:35.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODrC8fRCIQ67rGNJ9rXgEqDOj+H9SwC32dvCEVj7qPg/L63EsLV7gG96FCrbZ/eiN4Ofqvh0OpXb3U6BFNTFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10840
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[igor.klochko@nokia.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-216038-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nokia.com:+]
X-Rspamd-Queue-Id: 9537A134A4B
X-Rspamd-Action: no action

When uio devices are created end removed in parallel, then we sometimes
encounter kernel traces along the following lines:

  sysfs: cannot create duplicate filename '/class/uio/uio899'

which stem from:

  sysfs_create_link+0x24/0x50
  device_add+0x2f0/0x780
  __uio_register_device+0x18c/0x550

The sysfs directory creation is performed synchronously as part of the
device_add call. The high level sequence for uio registration is:

  1. uio_get_minor (idr call, in critical section)
  2. device_add (leads to sysfs directory)
  3. manage attributes (popuplates part of the sysfs directory)

For unregistration we have by default the following flow:

  1. clean-up attributes
  2. uio_free_minor (idr call, in critical section)
  3. device_unregister (cleans up sysfs directory)

This creates a racing problem when we are in parallel creating and
removing uio devices. The uio-minor that is freed when calling uio_free_min=
or can be
claimed by a subsequent uio_get_minor call. The problem is that the device_=
add
flow can end up triggered, leading to a sysfs directory creation; while the
device_unregister flow has not yet cleaned up the sysfs directory.

This patch cleans up this problem by mirroring the registration and
unregistration
flow correctly. After this patch, the unregistration flow becomes:

  1. clean-up attributes
  2. device_unregister
  3. uio_free_minor

Fixes: 0c9ae0b86 ("uio: Fix use-after-free in uio_open")
Signed-off-by: Philippe Belet <philippe.belet@nokia.com>
Reviewed-by: Igor Klochko <igor.klochko@nokia.com>

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fa0d4e6aee16..5dd137a85576 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c=20
@@ -1125,8 +1125,8 @@ void uio_unregister_device(struct uio_info *info)
        wake_up_interruptible(&idev->wait);
        kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);

-       uio_free_minor(minor);
        device_unregister(&idev->dev);
+       uio_free_minor(minor);

        return;
 }

