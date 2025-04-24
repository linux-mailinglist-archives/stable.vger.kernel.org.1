Return-Path: <stable+bounces-136535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FBEA9A5B3
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69D43AFB4C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1920D50C;
	Thu, 24 Apr 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="qvo1MJXf"
X-Original-To: stable@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022104.outbound.protection.outlook.com [40.107.168.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D012063F3;
	Thu, 24 Apr 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482839; cv=fail; b=b0hIXv8RZGZ0+jRmJRsVOCAj4mFUl/D0rf8Npmdrxcz1tnp9/iQNtJeVXRodXrwmJJQmbHhwsuhqg3Dh4tmtWTbLD5AcfM/LZQTrOh1yBwSpr/IPXVHLA/Xpn3GQcB4r2XIghn+NOVeuMllDzF8QS8niZwsE+4reBJ8CVGHmy1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482839; c=relaxed/simple;
	bh=w6ZDqJ8dgTi8t9L1j6TsEcTAoWmVWqK/CBEEcs3zuls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qjj4U6StTdVjgVvHcelKFrAKZRl1fAFu7ntkCdqS2lmMI4vViEuSY6GoYxKY8xFv916dcleGOzDxodbCJ5Y4j3HYqf2fXXmlNmcPpIITrWpwELdYCtr4zS3p/LeCXe/pfe3GuWhA1pp1HoGtGjCvjw7wTiExppP9XzhhNHV/lbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=qvo1MJXf; arc=fail smtp.client-ip=40.107.168.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHfqEsC1bEZxEcq29P+aWwHAhgU0ltYjbnecVSJrdbV2pCKxWmjN4RJwzNpMqnb2+X+nHnf4kL/36cQGMURUQTANmi4fOU8FKA62y4vF94rIiWlolJVek9Q3Q75yUc+I1vyiZ2if4HBexwFwg+RFRlAcXncylXBQ+XVL0GtM70NyR4exptqrYc3l4tQRhOKUOdWpvf45Uc5fNGWBiCGaM/hD8lDDyWbi9GRglF0QDglmyRTUWYnWBd/5WGuq2pXT5xZeZ/XbxavPi/V+UdpQYXqxoC4CiXb+OBEltW5+jAdD9hDRYwDkbUKZWpZiMMoCRvddSkf/+rRm47HU17GM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6ZDqJ8dgTi8t9L1j6TsEcTAoWmVWqK/CBEEcs3zuls=;
 b=rdrD5Tw2yQ3i7CFKRRVDZtC8oatt8zK2lemfOaGzLc5AiNIhxz/f7YtWtS9k3YZeIUln79wxMYaonpRHLxZwhsTsMi/gJbhDAqpZl9q8fqEps4JSXB6fl8tuTBtq762zpFYmFhFDsNYRVq3O+2CBAwWh9IWJamfBPfMRMeYAYzUuHpe2746ViLmEMgxl0qdNgDgTpJ8mu+qbZmc2POh4ys3SkXlhCMJKpbuC2bB69vyanZeelch/n3kW0sSrj0PDZpHnFLrgIybm4Hr9fTC9jDhVO2ajP61HPMw2Bp5zYFcjlm62TYLJa3+sYT1kefUfQH0T2y4NAxPWUeK4IIJqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ZDqJ8dgTi8t9L1j6TsEcTAoWmVWqK/CBEEcs3zuls=;
 b=qvo1MJXfshN95/QIdQd4jQB8XOB4buUNCUDVFcYoIxWCYUlmMmXll7v9FiK+cCQL8DwMlfuEBN4VTPZ+68l2SdVbDGXKGV94Q+9zwKPecmANHTYgALbJiliz+Ytp/KXf6M+jkPQ7kVXfrx4wA+elUgpkyCN1gKuoCkLee28TvlGAXlP88HNU1U2oS/q2bOdgFv2leS++cAqyHZQ/p4GH5qil6vKRe1Qo2amh45z+6g5HFTgvyRbafpCysP9xsyKm9vuj3rQnKBHsWQCMa0NjaImohaAye4omdMHXwuDe18AmCjK5R2Sff3nnwvN1xzFM0K6120qwa3hvqPy/Z3fVfQ==
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::6) by
 ZR1P278MB1328.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.10; Thu, 24 Apr 2025 08:20:32 +0000
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819]) by ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:20:32 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Francesco Dolcini <francesco@dolcini.it>, Wojciech Dubowik
	<Wojciech.Dubowik@mt.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Thread-Topic: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Thread-Index:
 AQHbs48w0QwgOvbFxkuKoITcJDMRw7OxA+uAgAAGkgCAAAFvAIAAESGAgAE8lICAABIoAIAAEJCA
Date: Thu, 24 Apr 2025 08:20:32 +0000
Message-ID: <ec0f5da5a4da6b2649373530d0103d65ea990c0e.camel@impulsing.ch>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
	 <20250423095309.GA93156@francesco-nb>
	 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
	 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
	 <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
	 <aAnXK0sAXqfTNaXg@mt.com> <aAnmZkpuaMOU0n2J@gaggiata.pivistrello.it>
In-Reply-To: <aAnmZkpuaMOU0n2J@gaggiata.pivistrello.it>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR3P278MB1353:EE_|ZR1P278MB1328:EE_
x-ms-office365-filtering-correlation-id: 68ba9b3e-a143-4341-df43-08dd8308e189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHdSQ2NjeENCTnE5TFM3WTA4OHdIOHFGSjhUby94akwvYjkzNGQ2OUY1NTND?=
 =?utf-8?B?VThxQm1XYldtT1ozdVdUc1BQVVgrSVVncmRQdUR2ckIzalVLeGNpWWdMQ1Yv?=
 =?utf-8?B?Q055Ni92UFRyc2FQaHFSRFd1NEhBOGNpUy9Pbm04cGZLdVlOZERacitFd1Qw?=
 =?utf-8?B?TGlUb3NpZ1FUUnZFelZSaTFZL2VmdCt0VWlmejlLQi8yS1BDVWUyOFV0RUF4?=
 =?utf-8?B?MWpqYlBwczNpMng4THo4M2F5VWVQK3B4UUViVUsreTlmSk1OVHIrcG5EYjVn?=
 =?utf-8?B?TUlIUTUzQ3NtRFN6dXhiUHAwR2lXbGxiQURSMEl4ZTZoVVBidi96ZzdJMWVD?=
 =?utf-8?B?TE9PaU5GaTNRODVNOTJoWnE5MllwTThrRE9vWWdySnk1Zy9kbXJSaXdVN3Bj?=
 =?utf-8?B?aG1WTENkVUNVaHBWSzJRNG13VEhTektHcm4zcEFUMjc4UDZtaUVJZGJuVUVk?=
 =?utf-8?B?cDNZUUgvWm1GSDMzMlhiQitHR0kzZVQ2RVpoL0kzQjBzalp1eGRhSkI4dndE?=
 =?utf-8?B?dW9OVmQzVXJwVWF0T3ltR1Y3T2NoNkVlbTBUVGJ0VXZiaHdPUWdSVmtnZHJG?=
 =?utf-8?B?VEpHckVtcmk1ZjVnZEJDWmljL1phdXRBZllsa21QM2duUXNkbmZ6QUFKczZn?=
 =?utf-8?B?d2tQNjJFR1V3TzdoY2lSL0tsbDhDSWJyUVYvdE1ETGRLcVc5akIyZkIxS0xk?=
 =?utf-8?B?SHZpcDBDK05ybkRTeWZoQzRMaDlnWnJFdVpYa0hMZC9XbDdBYm1GbTF4RmRt?=
 =?utf-8?B?Y1hWeXBrSDZTdHRhK0pDZnlQSHYxaktEMUVFdzZqYVVYUWZTaE5BWXFZUHpi?=
 =?utf-8?B?d1hWY3FWQzRaZTFBeEhnZmNzZFFYck1FcE51enZWckNGd1dOUVY3eG9uTCtR?=
 =?utf-8?B?dHFNdjV6ZTVTbnEybEl1a0ZrY3BmaVBPM3BnMkhKK3l2Z2g2UUM0QkduaEgw?=
 =?utf-8?B?S1k1b2hmSUFrZWJ1RjVrUTRIeEw5R2pvY1dkcEV0eW9aNkIzemVzS01CRTNO?=
 =?utf-8?B?RTJOdXpYL29aNnE2RkVyZ3RQcUpBQ0U1ekkxRnhJZitnakZadjN0ckVYK0VN?=
 =?utf-8?B?VGZWK3VhT3M4RTNQZXV5MzV6RVc3NkhYWS9zMUJqRXFVYndENmdLSDBwNHkr?=
 =?utf-8?B?RWR4SVQwcVFxaTlvVUNNcUtwVHFMcDZXZk9rN2diN05TU3ZhTFFnVFUvbFEx?=
 =?utf-8?B?ZUZIb2tGR2NjanRSUVNucGoydEJVVXJ4YjIvWEpvRUR1MGRQWG5hdE9zcnVv?=
 =?utf-8?B?elFTa1BYcUdxMlV0eGUvNFM5emE4NUxpaTJQRzdpMkF6QldjMTBaUGFHSDZT?=
 =?utf-8?B?aEg2VXlXSS9JeTZVTi82TGs1WWhGU2xqSnBWeTFpcE5qVVY3bk9sSGhRK2RV?=
 =?utf-8?B?dkE4eDFHbWVUS293M0c4c1EvTTlYUDVvRUdmMHBIU01MWFg4Zk92aCtLemJZ?=
 =?utf-8?B?R3FWeHRhbnNBZlJ4R2xDbzgySnNON0VxcGpORDdpV2s5MWFlNlJyN2xoeVlF?=
 =?utf-8?B?eTNuZ050MkpQWXZUWFFpWFFQTHBpYUh1bHQyTnVYcFhxRm96R3hEYVVSOWJl?=
 =?utf-8?B?WEo4SzVwZEtpY0YzaGdBRkJhZUxiQ29iZi9rM1NjR0doWXF4cEJ0Tk8yRUti?=
 =?utf-8?B?Y3gxMy8rUXNjNk5NYVZBczA0TGg5dlVJcGh3NnBmcC9TOC9SZmpMZk1CTlhN?=
 =?utf-8?B?bC9mSGo5WGdQT2ZqVlJaaEJHL1lLYzlIUTRITy9GQjhEK1NNU2xGcGpldTFI?=
 =?utf-8?B?VzdNekxyYU1xNkVWQVZQRDZzUjdmQnpLZXArdEdtT1hUMHZJVjAzdUNsQ1pm?=
 =?utf-8?B?dUtLcFd1SUJTbTR5Y3hlT1MzcXBtcUk5MFd0NllHbmdWNlM4U1Jzd3J3Y3gz?=
 =?utf-8?B?M0VNbFo2YUpjb2lNV0NHL0JJVUZzM0JJV0hTc0pOOUJQS3p1TG90VzNhakVZ?=
 =?utf-8?B?TXNkeWVZVjRVK1crUWRkS2xqbTVDbTVyTi91b0ZWenB0SjZrdkxvRVF3TFF3?=
 =?utf-8?Q?XdslEVSsdxo/8rPqiRDGjpl8Kl9VI8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1dkMmdEUVU3dHcrdVZZREdXaDE4V1l5c05JOEdxSXlORk92VjFCK0YxNHVD?=
 =?utf-8?B?M21vRzFqYmZWRTJoWVhiRDJOTktDbEFVdkxHRGNwSDU5azczVER6S0w3cW1R?=
 =?utf-8?B?V0N6Y0NkMnF3SHQ2SXBDK0t4TFVCb1czQ0VJclBLZC94WCtSYk9nbHpndzd1?=
 =?utf-8?B?OHhqcjBzbk9MQWxCV0VRMytvbk1ZUExjcUMwMEFRMzc3OUJLWUlmRlp0a200?=
 =?utf-8?B?NzVtYVVsK09iM3EyWW5neTZETmpkN08yNGNhTGIwa2luSTVRU3ZHRDR6czVo?=
 =?utf-8?B?M0x3Z2pEWnRMclZpL3FBT3Z5Z2RoWmlhaFV6TExoSXlRbFQwOVJ5R01SMkJp?=
 =?utf-8?B?NVoxemp0RWJzdVVoa05TTGE1bnlRcE4wanMvMTlxVDhoUlNJU1FHOUNteGV2?=
 =?utf-8?B?Ukx4ZnNzTENUTjBpcTd5Q0hWKzJRb0xLd1pPRlhubnlsdS9jcmtvRGNubVhQ?=
 =?utf-8?B?VlFDS2ZoZ0trdzN2YXpsTHBUUitQMktjQUFBU0dVVGxQV3hQMUlORzhqallL?=
 =?utf-8?B?VXBVSkNncFpWRzFJekNLeVllOHVDM21iQWJPcnBHQ3NuUUl0TWQyVjlDQTF3?=
 =?utf-8?B?NUhuVVdpa2JvNis4TWdOb0lRNHJkNEZFcUZKTkdacVI0WTM5Z0Q5Q3hNWU1s?=
 =?utf-8?B?ZEtSemN6Nk9hUmlsS0RJdVU2dTliWW84ckEzVkRUWEk1WSt4YmU2dXREUGQz?=
 =?utf-8?B?ZUNqQWlLQ0p3NngwZ1ljZGJvMDBJcHlTbWlmenZYTTAvZlNBOXNFL2FhWGVo?=
 =?utf-8?B?MEhTMjB3OVBYSFR2cHJTK0dXOGkyV0xaMFVFK2g2Yk1tTk5jVXMrc2xqZHRH?=
 =?utf-8?B?dk16enVHL1hvWW8zRVBnSTRCeVlCYkFaNGhoVWh6MTVOdUNpZXdoajM2eW1Z?=
 =?utf-8?B?QS9EKzhKdkVQWWJKakM1N2VYMm5VVnh3Q0ZvQlA5MHo4ZUVCc0tVOW9kQXg2?=
 =?utf-8?B?cVI1ck90eFk0N2xlVk9PaHBFWDhPczNQV0tTYWF2YXpMZ1plUU9nb1hVZ2hw?=
 =?utf-8?B?MWN1dUtKbkRWUTd2bVQyeUZjN3BIZlN3aEY0Rmw1TWZMMll0aGVTZENTQXVD?=
 =?utf-8?B?dTNGNUs2UlNQb0IzcW1xdW9tWmlISVFJVmpJZUtLOXluMG5lRmVRSCtRM1Vk?=
 =?utf-8?B?ZHRLWDNDOXhZUGtIQUdYTXlEdmlqRUpQeUdhZml3QVhocFpVM3R4T1hXVmtv?=
 =?utf-8?B?RWZUV3VIbFJ4RFQ3cld6MEdqa29iT3BFZDNoNk50TEpoeFB5UzRjUkxja0Ry?=
 =?utf-8?B?MVJkbVZOVW85VkhWNllYNk9vdHpJV1M0NCtDYkdkYzY3b0ZCRHNibFZtYkcr?=
 =?utf-8?B?K0drS1E1U0szalJ0NUFHMUVhYm1ZZ0ZzSW9Bbm50SU9EMDNVejJ1ckVGL0Zs?=
 =?utf-8?B?WUVXcExQM3hrTkVoR0RtWUEzTHlwK01tZ1FtalFpcUFDSjI0cXJ4cE5BQzhk?=
 =?utf-8?B?L1hVR0w3VElqQUtnWmdnNG5GUXcwWm4wZUFoTllvZkN2SWs4MkdNS0h3OTYz?=
 =?utf-8?B?L0NKaXFkbWIyWFo5QjhhRCtuc2JwT2M1MDFNeVo1SHE2MXh0M1Qzb1Y1Ry9m?=
 =?utf-8?B?N015Wm8vS3FkUVdvTGdMMmZBNERFRXptMnNDbHRXWkcvc1pYb0swclRQY0FZ?=
 =?utf-8?B?Z1BSSjdlemh0NGt6dEdMVjdpWm51Zml4em1yOEtIR0VYWkdjZUNmZVFaQkN2?=
 =?utf-8?B?VWIwZHJWdzBTZnhkTSt2NG9XOGtQR2l3d0svSGZqYWVZYzdnZncvR2lYNkVZ?=
 =?utf-8?B?MUZhakxWVGxVdWJCSm45aVQzUnhXMDFsSUJNN0hGd2RiditGTktaRDltblJG?=
 =?utf-8?B?WVRqSE5MTXlhYitpVmpFc3FHSFZiL0NuYmF1UGxEaDc5V3lmWnVER0dLeStq?=
 =?utf-8?B?ZGpWbHJyR0VSUGRDY2poNDRjaDQ3QlN2TkJQZlkwaCtReDhqU1VNNTRHNHpZ?=
 =?utf-8?B?RGY4QWUwU0pkOWZFclRQZGg2SXlHNHFPZVRGL3VZcnh0aTdVNTd5dVRUNHVE?=
 =?utf-8?B?OFQ2eWNjZExzNGNRcGR2ZEx4RGxBTFFuYldvU2N4WlRzaklVL1JLMEhhZEJJ?=
 =?utf-8?B?RWx4QWZVcWFDS1lFdkFCQzQ2OGswZFl6QmJDTFpJYk5idDRpUWhCN3B3SkEx?=
 =?utf-8?B?ZHZydThpSzk2MHdxcTR2WGl0T3VZdmgrQ3ZKM2labXNjNGw5bE9OcE5GTDFV?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-nipdIAHK/RJj56SsTPLT"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ba9b3e-a143-4341-df43-08dd8308e189
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 08:20:32.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGxHBaFgI4p/B7ptwhds2eErdstINaykYF5A+64ViaYnPIl48NDaKw38lsyITdsK2fDGb/cqNeb6sAPsWBC+HjNwXbnSsf0HH7Fsab8phBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1328

--=-nipdIAHK/RJj56SsTPLT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-04-24 at 09:21 +0200, Francesco Dolcini wrote:
> On Thu, Apr 24, 2025 at 08:16:11AM +0200, Wojciech Dubowik wrote:
> > On Wed, Apr 23, 2025 at 11:23:09AM +0000, Philippe Schenker wrote:
> > > On Wed, 2025-04-23 at 12:21 +0200, Francesco Dolcini wrote:
> > > > > >=20
> > > > > > I would backport this to also older kernel, so to me
> > > > > >=20
> > > > > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial
> > > > > > support
> > > > > > for
> > > > > > verdin imx8m mini")
> > > > >=20
> > > > > NACK for the proposed Fixes, this introduces a new Kconfig
> > > > > which
> > > > > could
> > > > > have side-effects in users of current stable kernels.
> > > >=20
> > > > The driver for "regulator-gpio" compatible? I do not agree with
> > > > your
> > > > argument,
> > > > sorry.=20
> > > >=20
> > > > The previous description was not correct. There was an unused
> > > > regulator in the DT that was not switched off just by chance.
> > > >=20
> > > > Francesco
> > > >=20
> > > My previous reasoning about the driver is one point. The other is
> > > that
> > > the initial implementation in 6a57f224f734 ("arm64: dts:
> > > freescale: add
> > > initial support for verdin imx8m mini") was not wrong at all it
> > > was
> > > just different.
> > >=20
> > > My concern is for existing users of stable kernels that you
> > > change the
> > > underlying implementation of how the SD voltage gets switched.
> > > And
> > > adding the tag
> > >=20
> > >=20
> > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support
> > > for
> > > verdin imx8m mini")
> > >=20
> > > to this patch would get this new implementation also to stable
> > > kernels
> > > not affected by the issue introduced in f5aab0438ef1 ("regulator:
> > > pca9450: Fix enable register for LDO5")
> >=20
> > I will wait a day and send V4 with what I beleive was result of
> > this
> > discussion.
>=20
> My opinion is that we should backport this fix. The DT description
> was
> wrong, that change on the PMIC driver just made the issue visible,
> the DT is about the HW description.

=46rom what I understand it was not wrong but it became wrong with the
PMIC driver changes.

My wish in general is that we are very careful of what is backported to
stable kernels. I do not want to edit my device-trees that are running
just fine. I agree and think it's good this is going into mainline but
I still do not agree on backporting it to every stable kernel the
Verdin iMX8M Mini is in.

Philippe

>=20
> FWIW, I tested this change with both v6.1 and v6.6 and it works
> correctly, as
> expected.
>=20
> Francesco

--=-nipdIAHK/RJj56SsTPLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCAA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmgJ9EsfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGlRXDADNw6pf/cvBovEM=0A=
5m+rEbXWgskbLjWX+xkCn69UKWInO31p6so69m1poYtM2BFiN6+QrKMevJmmla41=0A=
0ALFTFIBj2GYAMKT+CWr1bOtQOr8vjyAQ7XNu7Loe/XbAPxy9+tZRX6KOmBFFFkn=0A=
sXtCrMIu52MbP50fhPOS57qi+PAOU1UJs6rAkKh35og2DQJjZAeEeqjGklBV1XPM=0A=
7effKZFT7lGA9x6/IZSbClx1n+pIiovVLmXCOLaVRj5GriKw9vJZZ/gwK4ORcnOj=0A=
Yi0+88jJmgINSgGE7rtl7NWOouvuAjPblIOoZ58GEPwkRAxqsJsAOdc9aQkOCuqg=0A=
zqABf0SdBFPyRbslEh0Mz2RyC7xgOWYSRf/W9BjS3zNiA/X4EgwcS6CuZYz2OO0x=0A=
kBgfGrJ/UJmNfwRZE4lfiWSPZwECg2gfWWE1UrRCVpiZtJonvnLILGNY1iwXhJre=0A=
DIGko9DBoY7OGLnKa3rxwcz9fkjSlxKFjxB454p3iZloJGxkeMM=3D=0A=
=3D2XxG=0A=
-----END PGP SIGNATURE-----=0A=

--=-nipdIAHK/RJj56SsTPLT--

