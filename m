Return-Path: <stable+bounces-233607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FdFOmcV1Wm30AcAu9opvQ
	(envelope-from <stable+bounces-233607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:32:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903413B00E0
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69E6330201B2
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5928B40E;
	Tue,  7 Apr 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YUlWj9d6"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C302206A7;
	Tue,  7 Apr 2026 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572263; cv=fail; b=eg2ZeD3bJLMThiX9KvhrooYxU06jQb5VgHQgA0xqn6LqvsVSGtoOuk+/kTRwIG6Dc7RehEtU+JTSSy+bbxLAvjxK6ttvteIx7kJ+7OspZPEgldYmiU3benmCTa8c1KnLJpxPpuIP7iyfRlEzWM5+Zsa5Ch+7HV8JKYAfBETKOts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572263; c=relaxed/simple;
	bh=K9O00qhMdA05JCSEuxgzd9/xVfY7CdPhirpnOk/y0wQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rE8XmFFzl86ydcg+6KSxuAH2tzpURXIUCSSw61z7XgLOQ3tUEMupC9rUcogPvy3O1Eal903JpmP1bH6UGWcVEyYs0LQuqiDGKOdBoLcIvdhCIyn4+oNWKGLCR3Uy1ZkL2dPrrb7ZysrvyWhNdnZL1IGlyErWQAd0rFjuPLoIeuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YUlWj9d6; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnI6hqEG1z3gqJGLZKPI0pwgDJiUxztrJIAVBGxfn6jd3PVI3m7uD0OT3Ohm/gUKHXiCdeXFc+tWoE5bVseM7wMscOgdyTFzraqoH6AKP8AoO09W0K16GMkvwvMcdkLC0dkESAO8hiwBqcuiNMensO/ifZLDMj27apnLtGWz3A17pr3mijtJhTK4r7x3SamkWrcKEnZO1cNsZPLefpOEynZE7GlSmUOZ10dae3NB9d2vvyFtaqs2jiOGUvx3Wlkzj6iBraXPwS/lz6kNha3y0tMT+TMmqZZqFf96U01euLg9fiJfYaqAgVa/JJr86o5qoNvRO5jVLHJOB50n8HNEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9O00qhMdA05JCSEuxgzd9/xVfY7CdPhirpnOk/y0wQ=;
 b=V11vJaz1NRtyxpiTg+Y+baeL7VmvM5hdzVYAGJFuB6wByI/Dgg98reOhmjbZwL0+ZUbGOKm4HlQ9526GucrcM3XQP5kZrF0Gh8azcATf/sxvy/4bx54O3yQugfMJafQKNwkGTqKCHxWplja7w3TMm2IjuXmeUlpVf0I28n6j0ZhW/x5ZanlGR/mA71yKlEHvKL1Voz5rWM2ir7Nd6Kyea5tOAnj9Fbl2dFeh3yCE09I9UKZBvUGfsDpGRfqOHoUoQidYBSOTEj9rGhEetUV3b5uB2lGNb+cEzGD7eKGvFhyqJJaSTQUlyewMC/a/NMGxqcfzZo5TjblScEKPkm71jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9O00qhMdA05JCSEuxgzd9/xVfY7CdPhirpnOk/y0wQ=;
 b=YUlWj9d6xMzkUplvElw7+Wabjm5qzXwdrGfmyR2drfLXawS7gsSV9CYm41KK8U+oXiutWuIRLSWAg8PTc7XYQ37bavuyHqN14D4T1c2KFdj8itcB/Fdg0Xl+rrGyCIiU5g0pKhIE7DxONGZ4TE6VwgZ+GNSuV50srXo7jOT1LFI=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 14:30:58 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 14:30:57 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Christofer Jonason <christofer.jonason@guidelinegeo.com>, "Simek, Michal"
	<michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, "O'Griofa,
 Conall" <conall.ogriofa@amd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, Victor Jonsson
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index: AQHcq7dnEu4MVLVXG06oIZXnf3P2bbWjB/QAgARjkoCAIuly8IAJhQiAgAAEGeA=
Date: Tue, 7 Apr 2026 14:30:57 +0000
Message-ID:
 <IA1PR12MB7736D5B150CA36406ED7384A9F5AA@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <GV3P280MB00657EB1524612E9BA0142DEF35AA@GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM>
In-Reply-To:
 <GV3P280MB00657EB1524612E9BA0142DEF35AA@GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|BY5PR12MB4099:EE_
x-ms-office365-filtering-correlation-id: d2e11d38-8bae-4e9b-0523-08de94b248b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 XUq2qYwUQKRCtZh5GRnLxneNZoHyhlHzn8OFMZN4bNMdRuWSGyAawfufZ701O5kg0GsZPEQ+/GcyexjolR2FH/yhv9KXd1+eAsjGeg0WIEjlj4nzTyh8hEgUO0deoi8ZjtA10HkTXuwPp/LK74bAHexQFWViySPtG988P0Lq0SKTbhIamhUUiGL6QxMvMaVg2n2g9TuKvwFUz9oHBw9qAyVV7+qoWdz2guVQ60Ti9asdSFfIoqpK/DxjeIagsKEJDx68JHmPcQ9TdkhVOSybkaVJPszGJPIExwQ+ds+xhYsqt3thuEa/koxmJNMR5j2xuMiv3O4zBuwj64F6Rm9BRwHe+Sl8/uk4V3OWDzmgG1fcRVhfJYW8JoF5/Tb3SmZIfuD4j/gMNxBSLvCs6lraJ2U9LktecR3mrtINCtzvbcV90E3Gh2V/MFxkH6ZCGJRG8QcC81gkeuPd2B67gQADSEGrG6XI6hnLBBiKUbe9Oxbcyj+o8HyjM38KNoTs/1byKj+0Dwv/+dPlOXiHW9lQPewGzLlkzMttbQdR1YU++MGuoyGfrTWEKMyQjBKdWGipqkMVhA0zKcHPVU7v1Y0A8yhrIU0YwTWvq5JWLK4md/bJWsJ9RhLwrYJR9v5uoC1yGA1BcLDxy2UFAc5HZkYQ1kWeTK+KrByI9ugn5rGhwWc9vI4/9g7bBhWe589pFKCg56EEhTGscQXYQs35Fd0SC5OqGcGqgeMmdc216zS25no9QEpHoblMdQqfCFg/GG94P9ef3ZveUZAiSxtVrztc7vcJAswkORUyYaTyxpT5ZmY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?viHVkO/Oz/iLa1f1yiYDEAa29+d+lJXyTVMKHErRTAP0z/IBhjb6HNpvhyIK?=
 =?us-ascii?Q?qFnuc7Atx/gb2NFoGRZ87ng4Q2pK7zhUAxL572KvLoWZuUFQ4JJ2AMlxNuc8?=
 =?us-ascii?Q?iItppqId+hu8QqxVPGgIlypLv/mqeRnw+77c0p5p55zb7tE9Wcwj4jO6hptV?=
 =?us-ascii?Q?zOM8IzrW+1AIlWMvcunzrj1UebHtIm5vR87oAdW6gFTGcQPkPt6dKWSLg+3e?=
 =?us-ascii?Q?6zCI68MDhs8WNo3JQvZq8F444jNn2/aI21bk9Ff5KamwdNcURYutQH5xyU5t?=
 =?us-ascii?Q?GrX+u+FxCcIbVYWwNar7kVlkdoXM+ejU59/7jlt2r/MpAYxvNnOKdoF7cQPv?=
 =?us-ascii?Q?enlEA8HiUozJwHdX/PK8ZLTbh169zKORlpN58gRUtZZGg43UnMJHaaznPVhG?=
 =?us-ascii?Q?2dORY8NFheg6JzMrCtEo8KRqspwS4Ehd/qviMsEW36GsSHHjv/Q1gwgQFxnS?=
 =?us-ascii?Q?WMXtor7F8ALpZaXf1J+Hu5pJf1kvmyCetILXSABpG+QsoKREYkRRcQ9m8FTN?=
 =?us-ascii?Q?I8uxTyqBeYFjqe5+bhWQWJObx7ZHEAuTerN2P6mQ/G/901oZKWxhxmBwQOQM?=
 =?us-ascii?Q?NMhEu4tSRcsFZLvMVG6HtZP5u0E3Se3fcgk8+h6hNwJ+Sde1zhbcQH1Ddj7U?=
 =?us-ascii?Q?CWAHHsr2hWf6ZspCBOD7klRMvPcxRESlJuMdVrTeW9151sz/3tRAPEJS9Emr?=
 =?us-ascii?Q?xltiXckVPqzfgUQxTqwqcx5b7uLq22CALnwvB9jNvB88kTRbm0d/L+WRUdkA?=
 =?us-ascii?Q?b+FeMpvdosX9t2I3FDvbIhVub3ET4r6/KPRLA3fyytgruttSG1WICyFPVlMP?=
 =?us-ascii?Q?Zynt3HPxNX9Ea76wZq4upAg/CGXo6rzrtLLKywDNDJFqgwTzkQdRykWM7gHo?=
 =?us-ascii?Q?cR8sW/lGrzkjnBUHaQIS5C0wq6BG6kd+UhUZqS7mItIb1sOyfoht6lzFerKR?=
 =?us-ascii?Q?6jT6xOuHZ3YHOJrBXPFs2krlAG/yOKpG2V5iCNvA4OqsZ6v7cq2MRTzp69oV?=
 =?us-ascii?Q?xEwdXtyIA3UNrnAxtuSF9EYsDQfmYNfs+nM5zl9HUon/KspnkowfLTPvWdkL?=
 =?us-ascii?Q?WESSXegxRlSxD6wxtqKIXDTzgCD8d/eAqEGxv1OYt5XGQ8DYXlFtWwE2eohy?=
 =?us-ascii?Q?fkZy1eoX6BYhMUtX56sLMtw1ixouQDCzIrX0lFHKsJgOkOc6DF1pVPfopYZi?=
 =?us-ascii?Q?qZW6I6MD5KJ5DKoMcvHgOveyJlWruttm72EcaKk9Q337UthiNxU2ysSEguNf?=
 =?us-ascii?Q?B6uOq+VxA9HIxZtCows1xPvXA7obRT3Kt3EKtWq5rIWSHO1qDC0p7fn/nHeS?=
 =?us-ascii?Q?dKZScdVaxpwfhU1+lSlqiLjlMRWe3s2pExMlLXuGCYtIfHbeGhtiYIuZuvjS?=
 =?us-ascii?Q?ltcZSyNBEp/oNMPdyRcM5UyWx7uifHepBfe9WxQ2+MQm279DCEPqVdO1j00n?=
 =?us-ascii?Q?+paBMdvM+MuQ2D7ghnuDty3uebGI0HdAIccFm4AYD3/3ao3IDkULMWEf5ojb?=
 =?us-ascii?Q?x0jy50AL3zJHgERB6geJtd5Jms2g0WFEzVhnYeIM8Oiej4kLtxvCdUjjufR3?=
 =?us-ascii?Q?CbfQu9fGEIGjOziDAXUdKm3mFUuvAnoYiubkMnQE+Dn7JzYw6rdp1y1AxykO?=
 =?us-ascii?Q?br/nUmzWkY0ro8qhg880z3ZO1DlGUlF1iZJdFb86+KURAJtf9qUzwINJ66f5?=
 =?us-ascii?Q?0G/4FjMKTAIZSc6aPE1w5vUudEe3K3Ks8UkisIadDsgugQqV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e11d38-8bae-4e9b-0523-08de94b248b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:30:57.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeeQ6SCEAFEAiILFYvmTSMVlJRw7x3fs4oEqrpTQpgeSbKjRpn1oHLbJHCa5dPWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233607-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Salih.Erim@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim]
X-Rspamd-Queue-Id: 903413B00E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christofer,

Thanks for the details. That confirms it.

Jonathan - this one is good to go from our side.


Thanks,
Salih.

