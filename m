Return-Path: <stable+bounces-232781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM5NJRIizWnOaAYAu9opvQ
	(envelope-from <stable+bounces-232781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:48:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADA37B830
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268453050A23
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E953E5599;
	Wed,  1 Apr 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FPz/hPQb"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E23B895E;
	Wed,  1 Apr 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049182; cv=fail; b=YSndbt94fcFhY4ZKZ6d7CGYnetocPJvBOOQM1OtgRX4cvCzK0RdQu8XhfUFT2TenrSfrfZN+WjUc+zO6mnOcgOal9eXrxE/62+SPFP1/Don/dLpahgRRMRs5DjeXTXqXxLpn1RXbXrM2HlNYbYyvqARrMmNymd73ZKAY9RskcVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049182; c=relaxed/simple;
	bh=0ia214xvNj2376Ei7ShXkXqF94n1ZHCdHxm1lurWG4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfEr4NfA8a4ndtR+wDyOG8BnIBmZ7t2LqjaiofaL9iPEkcfncN3jlctTRzw+D8ZeNVhpbNA067dA0FK/d0c6N/JW53O7iOPrhfGs+EElz8gkgrNQIj3ywGuDOYC+W2aSFo70BiEnA4Oc4UVWumVGz/oHKSiOdtA2Jb3WJZb6qkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FPz/hPQb; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkXKbEFAFGoXgZ5KJhkAW1lNNWcrDnSiMGK01XCUZjvYfFjGiSlzgiWfr0NXqEMxCo4exC/T4KY49l/KhpWJl9vfOH5/zyIbXtiveK1nIf63hazc/CZpXWKpnmLWJdXEBcqXvWhbI6x1yPfnqcqc4wmVnbdH7vUXnbT1RX9n6/sGr/ERONpGNb1t6yhRprEVHe2T0GpDdVw9rnUrAdYENTOOP/lu13UuMcc2E0/u27f2fakpkebSUaZFjG11H59wba+qhMLfV7h2mXQdWyrtf7Qysy4uO5VEWrVqyrN4nJiN9pS2fq+R0KREZvfZtTjYXGBaIAUDPn8xtRMfmwGk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1705mp9qP5lp1ejyR3nOSjroMhpKmvsYjC6kwCyl31k=;
 b=F6xrBverCichO34ReMg9LthHONCpc0zJ7apmtiv7dyAhyEOY3PNhNaEtgSOrSHYAJHgbVknQL7x3p4tKY+BBcuvZNevQH8v677Q5tXp9C7xqLuUXRnf4icsBCDeSmSFzgO45syAKNCJDRBCfrFIAQFs1EPu1rRMEbmlDc3mfEsqMCWURr8bHHWf3lYzfoYmL67pEXpF7hw9z2I1nPrqfm5W/w5ZV07Bsj2Lcp3d6L3ua54xghWB0MevFGOUTZUBdQGWZb0uxbRh7mgPull+d9Er8zrFbaV+FqCYYqN6MWbzE5lBBQADGxxjEuQElfAyNVj6yU7TPXSclptztm+BeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1705mp9qP5lp1ejyR3nOSjroMhpKmvsYjC6kwCyl31k=;
 b=FPz/hPQbvHDz3j0II5ZqV6JL5YretkRLgl0T/t0uE/5qa1XW3RomW5DKFabAylDg2E86sFAsQQItdIZEJm4cyqoTHoi5DajrYdgRIaD1bjFY5RGo38k8lyihMtm5sp6Lp+qPwU4VZ/fkau/Ga6Oz4g2dUu3OMkm8I4oU8PqHwx8=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:12:57 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 13:12:57 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, Christofer Jonason <christofer.jonason@guidelinegeo.com>,
	"O'Griofa, Conall" <conall.ogriofa@amd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "victor.jonsson@guidelinegeo.com"
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index: AQHcq7dnEu4MVLVXG06oIZXnf3P2bbWjB/QAgARjkoCAIuly8IAABfbw
Date: Wed, 1 Apr 2026 13:12:57 +0000
Message-ID:
 <IA1PR12MB77361978ED21FF22F079034D9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-01T12:51:04.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|DM6PR12MB4332:EE_
x-ms-office365-filtering-correlation-id: 3b7e58a0-0a16-49d9-d623-08de8ff0648c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 icqrRrYEBlI+4WjAoeo95HiIPh4iDYYWZ+fLgynEquO/Z5IbKWwSKtHCRrOD5FtgVd+ezh6Kkfi94O57AbdQ56yY3XJyUFVhk4woiJMQc4wtIGiH7tIIdJN0x83KCaw1Zn2e+LX/oiHCIR73Fv3vjPORgCZmrbNwVr/GeX6FaAhBIEuL+DHHZJhF4cxCR9Nk8OjUuUb/fB/nIdftefoN6P+kwO7ahRilHnruEN46qmvwpWBmJC8cv8AV/WlEMYCvfWMdVAbKcAvvM/yBSwjnAn9MfjvQQ+T6z4U0LELdbyrL13riSRy+fjIK5nRJyuvEco/5W9YVRF80aRCrMeOzHeEpKpptZ/x1rDcppAitUujHIGquO973+WpPDD0Mku3lS0lR8k1UPbAQ4DE5uPDafZkqa5lJ0W0fJwR7nOfLP4muM3RfyWjcGbyLv9OWOw6+GR7DJVSkA5mML6wmrmH2sR4LRUH8drbZVLUmYKfYPQCq//nleSUkKm7BNOOO7Hz7dcoVZVSNFxwy4zrav74gcnhxCjJsRqfaSNlJDb1MxTLR5MmHOL2uCsswA1i03JQW9gKK+jLv7LzLARlCvglDAqXVAg3wSbA23/Cu0BHdr981TLudIL25fHA0MaybRSHo05ShzdxPJtOhjKJRc1huUhUU6iGgiuwAF8NCqPnYhES26G6cZohNH7KNs/qc0BMY2zKRg/CiyATzGB4ClnaFzH4u42BGdAoGTJwn1CbFYRCZ+olUxCbsymRNeD7ivTwaB/IdIKgmoSZs5Xp06n4StbVxAM6dMAHYOb1Lti9EvrE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JasSGEDlbT/ACqudqn9KcGhaJxLpUEiUlRaviY/niYo/AGGfevUSdptkPA1y?=
 =?us-ascii?Q?XMmN3uTU8lR0r9lm9csTC+pR7OcqDtVdsqe0XwyWZ0VPR0m31n4LD4LH4Vx9?=
 =?us-ascii?Q?jym0TiF4jendXsXXPF9rgSDmrEGKjP7/1S9TGuHcM7t4FbLlKMwKLTDuUEeS?=
 =?us-ascii?Q?Dpn2O0DaItICcCCxPdeagp7OSN3lgEwWq+v7CW/2vDT2L6ArZv4hCXOUjxoq?=
 =?us-ascii?Q?p14Swgooh1o9qF6rCYD/ye3pIil6PzK36VVOrh+tR+n8/Uf6vgLIt0LQRFHI?=
 =?us-ascii?Q?m4TK2I/eP3R+uUT3kxyj6benexO5Np+8/X6yn1W5jNYgqk3yo0s/ixToJ5UY?=
 =?us-ascii?Q?7xfc4BF0EjNLxhLv1DsNXPind4HtJrImBdrsrHImmuq7gfUjVhzXHDjVwX5H?=
 =?us-ascii?Q?FiclhVVixRZcis2ps80Dxek/hTG78SILRNDF6lT1xOx7Swn3qXrntA9kHHzW?=
 =?us-ascii?Q?zFfh1IvJWpAaCT2BXZ2gG42BDdCDF2CcZ9z4fA9tD3/ybU+haE0cNyULUFKk?=
 =?us-ascii?Q?Q8WYZKi+qRkdaEU3jVz53ftzkLXmJQ6JGqYqJfdqUDVChoTDyqyR7H7ECeNx?=
 =?us-ascii?Q?qbjTfxBsZaco4mGGE8IvNp9zI/pyqG6moN2luwdvc2Uz4ch+1sBMQ1ceg168?=
 =?us-ascii?Q?ml6rZ5xa+VEhmhOvKWxvqjUrBLXvQo0SjzEVqmfjQsbOi7ecVR6fHyPLEEBw?=
 =?us-ascii?Q?zKmvpyKJFC4sPZuQgQ1ubF1lochfP2Y0PyvzZ540b3KNwDi2EI5JtGnjERbo?=
 =?us-ascii?Q?ml4fZC6BUDJNtJpNhhNy8XrPTjNV+8Uiy8pTukcPPwCanO6I/dedC+cr6Qes?=
 =?us-ascii?Q?uE2rAH4HPNlJpqMszI34vjDdWlta5WfsBILCdUpBDdyr5ZNwk+h1lUK22JM6?=
 =?us-ascii?Q?wX7R8b+ypupRj52lU2KQkAECuJacatoBen6MMH/d4aCJV6+diPBTe1ElNbOn?=
 =?us-ascii?Q?oZAzCpHJ5PKk7FFcXm/3hSun141qhz33qjK5y3QGiB6xHWup47D/LoERSs6z?=
 =?us-ascii?Q?M5P52G+KavVaQx4PzKlyk4FiPOccnx370ECH/Yv+xAiI6EpYScMV/ePaaY4q?=
 =?us-ascii?Q?sXGLzPVhfIX/fLk60MABJ7rQmtsdsPpMd+ei2AAtNOE3rO2u1yLzKR5lV6y0?=
 =?us-ascii?Q?sUFaJrDjv0FsE8rUOM1Fsd+PyWC9eZ+8FF5Jv1Po08smrMF/gRIMfai2Buou?=
 =?us-ascii?Q?AcJ9vS0ozTLCERYnAujpAQ9bnjW7gIu3AFSfQAoqVO9QvN33Fv9vomu18m6X?=
 =?us-ascii?Q?pudGG+KKZpdIe/gToEp79VXpPTjf0oGHie/xqRnwcxWGN/hFCPSraAC64tS2?=
 =?us-ascii?Q?MF1H0TBT8IBfJuZ6zbKcIvpKKM462FtdAg7ieS/F2Q0U2o4UBCFSWJfd1yMW?=
 =?us-ascii?Q?smLzzIVpYuUL7yQ2spgcEYA0wJ16GyGB0JFFRzLP5amh8QQdl09yaX3D9xNd?=
 =?us-ascii?Q?eGYx2sryrY9c+GYE74UpQ+yy7VRhyFSBwUTvceD6WnJm094yIRH7cQ3qjaFE?=
 =?us-ascii?Q?pcylyK2uReU2rUdC0TnVP8q7X+7dgZls7ppKcaH1yu3FKz29l/SeiK7KyEMi?=
 =?us-ascii?Q?AYp9CKpFzILR/zRU52+7GNvY4sbBLytZYGguT44qv9ErCkoPuZ0ZIc4mH1hL?=
 =?us-ascii?Q?GPFXWirpYIuXLHth6YU+9PfYOMtstXiiCiBbAFFtRolli4JITy3JWODNrUh3?=
 =?us-ascii?Q?tRtlHPrR5ZFRUeRXd+0IsFzf234cqEvzygIyXr2D9uqSP5MC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7e58a0-0a16-49d9-d623-08de8ff0648c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:12:57.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkKGYlrMRzvmSJYUPL+mZid1/6rfvMiojjHSgPHE+vvl/bKW/QkviIwOiu39igFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232781-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Salih.Erim@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E6ADA37B830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Salih Erim <salih.erim@amd.com>

> -----Original Message-----
> From: Erim, Salih
> Sent: Wednesday, April 1, 2026 2:12 PM
> To: Simek, Michal <michal.simek@amd.com>; Jonathan Cameron
> <jic23@kernel.org>; Christofer Jonason <christofer.jonason@guidelinegeo.c=
om>;
> O'Griofa, Conall <conall.ogriofa@amd.com>
> Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;
> andy@kernel.org; victor.jonsson@guidelinegeo.com; linux-iio@vger.kernel.o=
rg;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in post=
disable
> for dual mux
>
> Hi Christofer,
>
> The code change looks correct to me - it aligns postdisable with preenabl=
e by
> reusing xadc_get_seq_mode(), and the scope is limited to dual external mu=
x
> configurations.
>
> Since this is targeting stable, could you please share what hardware/boar=
d this was
> tested on and how you verified that VAUX[8-15] channels return correct da=
ta with
> the fix applied?
>
> Reviewed-by: Salih Emin <salih.emin@amd.com>
>
> Thanks,
> Salih
>
>
> > -----Original Message-----
> > From: Simek, Michal <michal.simek@amd.com>
> > Sent: Tuesday, March 10, 2026 7:43 AM
> > To: Jonathan Cameron <jic23@kernel.org>; Christofer Jonason
> > <christofer.jonason@guidelinegeo.com>; Erim, Salih
> > <Salih.Erim@amd.com>; O'Griofa, Conall <conall.ogriofa@amd.com>
> > Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;
> > andy@kernel.org; victor.jonsson@guidelinegeo.com;
> > linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
> > postdisable for dual mux
> >
> > +Salih, Conall,
> >
> > On 3/7/26 13:41, Jonathan Cameron wrote:
> > > On Wed,  4 Mar 2026 10:07:27 +0100
> > > Christofer Jonason <christofer.jonason@guidelinegeo.com> wrote:
> > >
> > >> xadc_postdisable() unconditionally sets the sequencer to continuous
> > >> mode. For dual external multiplexer configurations this is incorrect=
:
> > >> simultaneous sampling mode is required so that ADC-A samples
> > >> through the mux on VAUX[0-7] while ADC-B simultaneously samples
> > >> through the mux on VAUX[8-15]. In continuous mode only ADC-A is
> > >> active, so VAUX[8-15] channels return incorrect data.
> > >>
> > >> Since postdisable is also called from xadc_probe() to set the
> > >> initial idle state, the wrong sequencer mode is active from the
> > >> moment the driver loads.
> > >>
> > >> The preenable path already uses xadc_get_seq_mode() which returns
> > >> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
> > >>
> > >> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> > >> Cc: stable@vger.kernel.org
> > >> Signed-off-by: Christofer Jonason
> > >> <christofer.jonason@guidelinegeo.com>
> > >
> > > I'll leave this on list for a little longer as I'd really like a
> > > confirmation of this one from the AMD Xilinx folk.
> >
> > Salih/Conall: Please look at this patch and provide your comment or tag=
.
> >
> > Thanks,
> > Michal

