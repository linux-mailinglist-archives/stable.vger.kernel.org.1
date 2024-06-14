Return-Path: <stable+bounces-52243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81B9094DE
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 01:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41AB1F21C9C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEE18735E;
	Fri, 14 Jun 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b="H/0Nj9vB";
	dkim=pass (1024-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b="FWqnhiMr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002cfd01.pphosted.com (mx0a-002cfd01.pphosted.com [148.163.151.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9786645;
	Fri, 14 Jun 2024 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409197; cv=fail; b=fHoiWU9FI8pNU6RjRGNvcmoeHo9fheWRYarxn7Gy1BNY5129j4Jc0DGiS7bz/rTchD1oHS0tY6VS9hvshemZLf43a7VxEMPUK+YyEG48nFHC9EPw9QMJiTLUlgv8PJpicKOREyYhLzL/MOZABS/qyOjkPnbDg8h0zDfyLjAvP+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409197; c=relaxed/simple;
	bh=n63JjZA5PxcYGOPOp2NKqryXloAd04h5un12cvZCRA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j95T5O/MmjWPYEvdBjoK9f8n/DZxXurgvrMsq3mjLQQDU7ymfYgWD3OFxAbxDbFHMKzFyuD8beCiM5oIQ+JSQg0DdH2aKeMwgaKbrHBnvaed3oZ6+vdu4CBlA0uUNRPeRYRsC3iacmDzz0UU5vDimYqtCsylTH4k1j75eR64wnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buckeyemail.osu.edu; spf=pass smtp.mailfrom=buckeyemail.osu.edu; dkim=pass (2048-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b=H/0Nj9vB; dkim=pass (1024-bit key) header.d=buckeyemail.osu.edu header.i=@buckeyemail.osu.edu header.b=FWqnhiMr; arc=fail smtp.client-ip=148.163.151.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buckeyemail.osu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buckeyemail.osu.edu
Received: from pps.filterd (m0300658.ppops.net [127.0.0.1])
	by mx0a-002cfd01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45EHQG1K012676;
	Fri, 14 Jun 2024 19:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buckeyemail.osu.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps1;
 bh=ify80w/AQ7DDBr0YEet+6n7LYHbX4IxJjAD05elS8do=;
 b=H/0Nj9vBO2wPyStpyeAFiVvzXXnkbzjtkv6p3FbKrxJEm2sF5vH4BpXuLF3dkXfHHrAK
 xTM3LoPBVLmGU8QCB19EUY8ZAlL/eYqi8T57J5nMsc+MJyEI8H3xTWagMTNQ+28FYv1u
 MrsIVGjmDRm/4jb2uEgHMHPovSd5sc1cHuKYEBjiqsk6cd/U29slC/2CtXRaRQnFyNSm
 o56xiW/UqwmJ4xSAC9YED/IMTyFGG4MsIjUcRRdXWxAHcI2wAwgoQ5LvFeZntZ8Rstcy
 LX/6gXak8s5wQbWTRHp8HcM2PvoyCn7sdcDrmaUTSo20X4u4k1lbIYuHpd/Znb7ZlTjx mg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-002cfd01.pphosted.com (PPS) with ESMTPS id 3yra1uprbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 19:52:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2VBWX3/smc8zPYG0ki/ogG6sexIeM/oONkmoZ/GgQlWUb9FK8MA2STH+JRbS1xtKjl9ddQKyvyXXM9aQ0pQN0Yr4KoUcQDmSowxcgUFw2VxoCtgoJSk2cHmAwDDUQ7tq12CiEcDAQHwyGGxy9zRdtGslRbha4OTRJF2veB/eiClji5S+fylFVPQ3ncoQpspTw/ETRW38hRd/osSWzqRWBJqi1oQvwcPzpANIBWL5WuYoR4NjZzcM1q0ldct7glbZguPX7dUN4ohZFZEe2WbAhfcpYcCfab/kuejIvaDTlJqO8v48MjhD0B1cB/L2dnU/BJ2FRHZySXPlsuyTuxrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ify80w/AQ7DDBr0YEet+6n7LYHbX4IxJjAD05elS8do=;
 b=ZNp4wBL/3KMeLPbsjco5agEsd+GtbfYCjSAZBDION6vtcsQrIeBsSVUy1PhPJGQHfSmBj8BFze4n7HUO5to+e6fAQzyrEVye/zDVRFTOGzTDDNO8u0AVKjTWuCKDVtAXZju/h5Z/Eh9atCqUh34gsVFlQtd/Q+WTXqf6qzGRqZwCXWAsj+eWNLVm6ZCyKfM7X8jLCyiKXcTNXAMo7/cWmWKxm6mefDoHOgsP0jaEEeG3jHa3gAmvkTRsN6OAjMaTObB5ceCyQyt2wFKy3EamlW0KzA/3pewnyGhgTd9TJG9Q9IdsWRY31Dnxdpb/TX49wD69TQOobtKARJ6DZODFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=buckeyemail.osu.edu; dmarc=pass action=none
 header.from=buckeyemail.osu.edu; dkim=pass header.d=buckeyemail.osu.edu;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buckeyemail.osu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ify80w/AQ7DDBr0YEet+6n7LYHbX4IxJjAD05elS8do=;
 b=FWqnhiMrg5Winb1QVSqLcrL8dv9uhTAQlq82rJbe1iWrOCC7pPKH5qBfy6f/n7DKIv/8glJNtgy//mbZtD/HL4ns2G/uWwQaDKtLAhAI4rFIuR4pzmbEHCATNLQniZaNUQ7aGu5Miu3iUQbIK5zjvAmjGgWClmofXhdGoi4eOuk=
Received: from DM6PR01MB5804.prod.exchangelabs.com (2603:10b6:5:1da::13) by
 PH7PR01MB8641.prod.exchangelabs.com (2603:10b6:510:30d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 23:52:08 +0000
Received: from DM6PR01MB5804.prod.exchangelabs.com
 ([fe80::acf3:583e:e776:4462]) by DM6PR01MB5804.prod.exchangelabs.com
 ([fe80::acf3:583e:e776:4462%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 23:52:08 +0000
From: "Pafford, Robert J." <pafford.9@buckeyemail.osu.edu>
To: Frank Oltmanns <frank@oltmanns.dev>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team
	<kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam
 Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and maximum
 rate
Thread-Topic: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and
 maximum rate
Thread-Index: AQHavqzpBgj5D7bkhkG8vcHmuBIAebHH7mBA
Date: Fri, 14 Jun 2024 23:52:08 +0000
Message-ID:
 <DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR01MB5804.prod.exchangelabs.com>
References: <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR01MB5804:EE_|PH7PR01MB8641:EE_
x-ms-office365-filtering-correlation-id: 2ade018a-9339-42ea-3475-08dc8ccd0081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|366013|7416011|376011|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ep3tStj4s90Vi6w29loLDyo94cv136/ehu79Njf5xzCuKO2/+9CWE4qb6F?=
 =?iso-8859-1?Q?9gNxas50wCeu2GSMw4pLWkRqUJxjUFyVGCCMV/Bi+zV8ecnzRuHPjlAFMg?=
 =?iso-8859-1?Q?2Bg5LFt/Hg+hIy9ya4R0qmlchMsG1Q4khw6Ca/hz5dIxkgaXy3n1iN8nLX?=
 =?iso-8859-1?Q?xi403K3QTSQDNTSlxYkmwOHVx6+Hv1mjp2iytd+oNmOfQmC83SLusirzC9?=
 =?iso-8859-1?Q?4Y8rxNQ5F9B9yNq8ADOTKpPZdx3RJlj7WbLd2XpoXdojvyJ64ZScvEz3LO?=
 =?iso-8859-1?Q?JjRVq2AtjeGo5v+LMeyUwB7Zl8jrxPDtQcfvyvebhDEBUzyuNBO0K8+Z9E?=
 =?iso-8859-1?Q?0nRXREWhEGOwNwyIvSYigbNIJui4c6k4qNZaDfxb6mhkkEpIQPdM7VvR2P?=
 =?iso-8859-1?Q?0x0GLY4XyvRVR98u9gbXo02ivgK+c/5pLSiWjrL2DqxxeIdaXG2Il/hvLW?=
 =?iso-8859-1?Q?x1IWycUnQnLvUvEFchrSGlZR2zuMUCLkW7dAcdTvk4Qq2JbV7rCn4758yv?=
 =?iso-8859-1?Q?rmvK0XLT5m8YSlrTTKPAgrNqUooQCHtfr4vfmLpYgJntY+4WhKbT22DCjN?=
 =?iso-8859-1?Q?Cry7KDHzsnOq+w6fS/L7WmRqSpy0yqJ3tNYzgCk3TvAtPEQ9y/lS+KVpwy?=
 =?iso-8859-1?Q?+agCWIiq4f6+CTvqhyUjSp5CUHRcSS8H7bfzCvZMO/g8SYbFLSjk6YO13D?=
 =?iso-8859-1?Q?zUoxEA/iZ5WKQnBO6q73BkE3EYQ/DEY4cdgQZWJghD74FkbWpSFGzQ+ZiT?=
 =?iso-8859-1?Q?T5Npd0LhY3yUDWaBx88o0qWWUGZnFrms6aZZpnnEn1FveP8vJkL6VPi55e?=
 =?iso-8859-1?Q?5csDtWblQ3q5iWUJJUkP2c0RUVS/7rMCAN7OaJcpv1v42sbkAZjWsQEjKW?=
 =?iso-8859-1?Q?HRG0KvkAqOlSkO3HOhmhGIdGxYBojpsJN1U+1cOA0bBLnpYRRDLbQlXcMd?=
 =?iso-8859-1?Q?AZikzKIcqMPsE5JOeL3MuySE7SHo38YKy0z8/QT3fODGr1bj0A/jW8BRWh?=
 =?iso-8859-1?Q?IJBDawaMk3u00PqUPF8RZcDgEnCj2rauiC2U+dtAdTDjyQOKnYmzZ1Qyi4?=
 =?iso-8859-1?Q?8bB9bD+mDE7DEAHM6180ApQJ17hiutIoRHQXfk+WgVoPjtSJGbZu7LufUb?=
 =?iso-8859-1?Q?SOk6HKriPmNEiDxQ7+7TnFf8A1W0n9RUSSLMi/QtVhy+ceOcaDqk5hpKZZ?=
 =?iso-8859-1?Q?Z6zs/tFnlE77gAk1zcbAo1gN2H2WR0+VZ6y9qzbW5f7ogLyffhOwvwJ7+p?=
 =?iso-8859-1?Q?+K0vJbrtECF1uv3+z018YWGuEWUJER9SL80SOpucqLTSvxwue+NFTcmQu4?=
 =?iso-8859-1?Q?LPbWlbYXY4aF9TOFgH9tbnolwrEnU5gRjuLUJFJpXXvVs6ovbH47BLTxAT?=
 =?iso-8859-1?Q?3Ib7hK8U+0ONQsy80YpU4ycbflHmtIiVaP6M9JNWeCKhLZdfyhluM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5804.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UacKGhvvhfVikjvF95hLAelKy4xgD33ebyTTiD9g4u5LTdqAf5KkMLY5aF?=
 =?iso-8859-1?Q?pbncPS613VUoMCRs9+J+zgvF4SmHrDcrY1dxrn5Bb1rjhTbDAvtXGoLZZV?=
 =?iso-8859-1?Q?Ef3OLec2a/JCpFBW6C73Nvsu6PuM+3WDyXR20vB4shwhjHzlpEkO7FEA0b?=
 =?iso-8859-1?Q?SnpRdH49ipdFkdvWTPndz6n0LvqhN1pTqrCwcRQgec0yI2kPVyQlW29fEv?=
 =?iso-8859-1?Q?7+/xMDvSBmkuZB/74E+K16IHtcU3yiNZMzjfN/w9YXiri3gRUUh8KlSHmZ?=
 =?iso-8859-1?Q?LgHKJKNOnbiGx4yF2vYetENOpj6uvBqe7sbiWCel/Ru3fLrYqUwPrvjSzC?=
 =?iso-8859-1?Q?xKww43rOD24Q9VB72bqljX3kk6tUn5Co9pwP0vTqSwbfBUSSpW9KNmBA4c?=
 =?iso-8859-1?Q?/QA/qlNLJwOrumQxf9bgWHq6oB7PngyYQfQqQ4kAqMXGm27zyZ+FTVq0Vr?=
 =?iso-8859-1?Q?spIdqWvtfYmkAY3F1yB8TtBxktx+7B1W/IkB/by9obI3Fm18dzDse1UIFj?=
 =?iso-8859-1?Q?uCvpB71dBUN8YPJkSRLax356MDSO2jKU9MkfZ0EEicurFITBo6TINGziKt?=
 =?iso-8859-1?Q?PhAk6APWkjbexFlZKRstSgyFLSGVqt84andu5fWCDlo0BpS/59VJJhR1RK?=
 =?iso-8859-1?Q?D9WsWzCsb0iCuMxcpp6mE2f8MhM2A7kR3QC+CBZ+2YAWGL/gq65gZjoVs4?=
 =?iso-8859-1?Q?u9NYB5HRbzsKn1oGaUpLl0+RzR1D1t1rxF+T8l75QSmX+J+0G4A+0Glj/T?=
 =?iso-8859-1?Q?moQpdkEzjAVayQru3L4oJb5OPAOsgB0LY8Zn5GX57KyXR42kb2/4xaNILR?=
 =?iso-8859-1?Q?VDOSsqvGk8cMyD1FrnDfkFSha1VOjKMEfYgZtmtHMCPY+wIm2hMog32/Jp?=
 =?iso-8859-1?Q?8oE4S0X1+RPEKNotCIovHZcmHf7hs5uBdv3Ql3tyb702MUuTh0Q+CavsGD?=
 =?iso-8859-1?Q?LoS3wwavDhXXqSV40iU7y80f5c+xAQgR6AqooWjG9gQma7VdDAx3fO1esq?=
 =?iso-8859-1?Q?QxtSbSB4OJY+7uxOGWxIHkio/48fp58uQv4lbTzIdCBHSAOGtwhlTQhiqc?=
 =?iso-8859-1?Q?+VW1KhqfpumiuG2cQ8P+UpUg5xa0bDuC7SzP/anJahqt50WB5XVbQB27JS?=
 =?iso-8859-1?Q?Zcw1cEKjOpqMp8MYDZQ/lWz6JpWrXxs2oLC7D9jBZ/ekLteo77PsxlYciG?=
 =?iso-8859-1?Q?W+JBhFvpDEXrg2nuGwJIMjqtk0aPB2wPnEp2sfaqxCOMvhShTd9Io6JdX7?=
 =?iso-8859-1?Q?4uBs/qJ3vrsctliV1Eys8VNdaHWWhuwfoDO/MrYuADwpLiznMqHNhdvjYF?=
 =?iso-8859-1?Q?bcP5LsZxzRLTuSmsDXSW6WL0eqjWZKA2kuQpVzj7hdB+suU1i3dUW9k5Zr?=
 =?iso-8859-1?Q?/YAct89SrJ/y0eFMu5trkk8AyG4kYbuocBO5avw/iEISFUSc8UVAxvqiCv?=
 =?iso-8859-1?Q?MrGSGXUZOCzETNiLcM3wPkOuek32C1x+3N4V2VnWL+fDkmex+HPdOQWjor?=
 =?iso-8859-1?Q?Q0uxNyTEKHovZRy2yhducBSSS5ZaKKDFueYFIk9z9fXIi0BkKIiGmCqr77?=
 =?iso-8859-1?Q?x7hgmMMphSmCkpKGlyxcr7p3z0oWikHgmgzK46s6fEi1o3N7zM5H6fsTgN?=
 =?iso-8859-1?Q?hDs58p9GyZcDM2OeHK2Y4gtBpmWgGT4U2xrmXfKkSWtT9MqxwZWsrbIZcz?=
 =?iso-8859-1?Q?i9lPzQk9Crlql/fW511trMK8jPwAs8FhnFYDMD/FeaflONjI8q1w/uZoll?=
 =?iso-8859-1?Q?sGyQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: buckeyemail.osu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5804.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ade018a-9339-42ea-3475-08dc8ccd0081
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 23:52:08.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb095636-1052-4895-952b-1ff9df1d1121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTftNKdFFnFnlAcZK88Bu5Ab9EJr1oRps/0t71T1tK2f1uO6IBDI34zPSPMYPl7McvPI/qRKmlMpz/kD0+1Xgfzfz7n2cJsR0LKzO3QsFSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8641
X-Proofpoint-ORIG-GUID: NVqjJh1e50a4_lVTbuvouUhovuXAfUfc
X-Proofpoint-GUID: NVqjJh1e50a4_lVTbuvouUhovuXAfUfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_18,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=907 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406140167

> The Allwinner SoC's typically have an upper and lower limit for their
> clocks' rates. Up until now, support for that has been implemented
> separately for each clock type.
>
> Implement that functionality in the sunxi-ng's common part making use of
> the CCF rate liming capabilities, so that it is available for all clock
> types.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> Cc: stable@vger.kernel.org
> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_common.h |  3 +++
>  2 files changed, 22 insertions(+)

This patch appears to cause a buffer under-read bug due to the call to 'hw_=
to_ccu_common', which assumes all entries
in the desc->hw_clocks->hws array are contained in ccu_common structs.

However, not all clocks in the array are contained in ccu_common structs. F=
or example, as part
of the "sun20i-d1-ccu" driver, the "pll-video0" clock holds the 'clk_hw' st=
ruct inside of a 'clk_fixed_factor' struct,
as it is a fixed factor clock based on the "pll-video0-4x" clock, created w=
ith the CLK_FIXED_FACTOR_HWS macro.
This results in undefined behavior as the hw_to_ccu_common returns an inval=
id pointer referencing memory before the
'clk_fixed_factor' struct.

I have attached kernel warnings from a system based on the "sun8i-t113s.dts=
i" device tree, where the memory contains
a non-zero value for the min-rate but a zero value for the max-rate, trigge=
ring the "No max_rate, ignoring min_rate"
warning in the 'sunxi_ccu_probe' function.


[    0.549013] ------------[ cut here ]------------
[    0.553727] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:=
155 sunxi_ccu_probe+0x105/0x164
[    0.563153] No max_rate, ignoring min_rate of clock 6 - pll-periph0-div3
[    0.569846] Modules linked in:
[    0.572913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.32-winglet #7
[    0.579540] Hardware name: Generic DT based system
[    0.584350]  unwind_backtrace from show_stack+0xb/0xc
[    0.589445]  show_stack from dump_stack_lvl+0x2b/0x34
[    0.594531]  dump_stack_lvl from __warn+0x5d/0x92
[    0.599275]  __warn from warn_slowpath_fmt+0xd7/0x12c
[    0.604354]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
[    0.610299]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
[    0.616317]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
[    0.622681]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
[    0.628542]  platform_probe from really_probe+0x81/0x1d0
[    0.633862]  really_probe from __driver_probe_device+0x59/0x130
[    0.639813]  __driver_probe_device from driver_probe_device+0x2d/0xc8
[    0.646283]  driver_probe_device from __driver_attach+0x4d/0xf0
[    0.652216]  __driver_attach from bus_for_each_dev+0x49/0x84
[    0.657888]  bus_for_each_dev from bus_add_driver+0x91/0x13c
[    0.663567]  bus_add_driver from driver_register+0x37/0xa4
[    0.669066]  driver_register from do_one_initcall+0x41/0x1c4
[    0.674740]  do_one_initcall from kernel_init_freeable+0x13d/0x180
[    0.680937]  kernel_init_freeable from kernel_init+0x15/0xec
[    0.686607]  kernel_init from ret_from_fork+0x11/0x1c
[    0.691674] Exception stack(0xc8815fb0 to 0xc8815ff8)
[    0.696739] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    0.704926] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.713111] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.719765] ---[ end trace 0000000000000000 ]---
[    0.724452] ------------[ cut here ]------------
[    0.729082] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:=
155 sunxi_ccu_probe+0x105/0x164
[    0.738518] No max_rate, ignoring min_rate of clock 9 - pll-video0
[    0.744730] Modules linked in:
[    0.747801] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6=
.6.32-winglet #7
[    0.755911] Hardware name: Generic DT based system
[    0.760696]  unwind_backtrace from show_stack+0xb/0xc
[    0.765768]  show_stack from dump_stack_lvl+0x2b/0x34
[    0.770859]  dump_stack_lvl from __warn+0x5d/0x92
[    0.775600]  __warn from warn_slowpath_fmt+0xd7/0x12c
[    0.780668]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
[    0.786620]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
[    0.792664]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
[    0.799035]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
[    0.804901]  platform_probe from really_probe+0x81/0x1d0
[    0.810229]  really_probe from __driver_probe_device+0x59/0x130
[    0.816171]  __driver_probe_device from driver_probe_device+0x2d/0xc8
[    0.822624]  driver_probe_device from __driver_attach+0x4d/0xf0
[    0.828566]  __driver_attach from bus_for_each_dev+0x49/0x84
[    0.834237]  bus_for_each_dev from bus_add_driver+0x91/0x13c
[    0.839925]  bus_add_driver from driver_register+0x37/0xa4
[    0.845441]  driver_register from do_one_initcall+0x41/0x1c4
[    0.851123]  do_one_initcall from kernel_init_freeable+0x13d/0x180
[    0.857335]  kernel_init_freeable from kernel_init+0x15/0xec
[    0.863022]  kernel_init from ret_from_fork+0x11/0x1c
[    0.868096] Exception stack(0xc8815fb0 to 0xc8815ff8)
[    0.873145] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    0.881332] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.889525] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.896165] ---[ end trace 0000000000000000 ]---
[    0.900821] ------------[ cut here ]------------
[    0.905471] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:=
155 sunxi_ccu_probe+0x105/0x164
[    0.914885] No max_rate, ignoring min_rate of clock 12 - pll-video1
[    0.921143] Modules linked in:
[    0.924208] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6=
.6.32-winglet #7
[    0.932308] Hardware name: Generic DT based system
[    0.937102]  unwind_backtrace from show_stack+0xb/0xc
[    0.942173]  show_stack from dump_stack_lvl+0x2b/0x34
[    0.947254]  dump_stack_lvl from __warn+0x5d/0x92
[    0.952004]  __warn from warn_slowpath_fmt+0xd7/0x12c
[    0.957081]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
[    0.963034]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
[    0.969052]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
[    0.975422]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
[    0.981288]  platform_probe from really_probe+0x81/0x1d0
[    0.986607]  really_probe from __driver_probe_device+0x59/0x130
[    0.992540]  __driver_probe_device from driver_probe_device+0x2d/0xc8
[    0.999002]  driver_probe_device from __driver_attach+0x4d/0xf0
[    1.004944]  __driver_attach from bus_for_each_dev+0x49/0x84
[    1.010606]  bus_for_each_dev from bus_add_driver+0x91/0x13c
[    1.016286]  bus_add_driver from driver_register+0x37/0xa4
[    1.021785]  driver_register from do_one_initcall+0x41/0x1c4
[    1.027467]  do_one_initcall from kernel_init_freeable+0x13d/0x180
[    1.033679]  kernel_init_freeable from kernel_init+0x15/0xec
[    1.039356]  kernel_init from ret_from_fork+0x11/0x1c
[    1.044440] Exception stack(0xc8815fb0 to 0xc8815ff8)
[    1.049496] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    1.057674] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    1.065850] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.072471] ---[ end trace 0000000000000000 ]---
[    1.077106] ------------[ cut here ]------------
[    1.081734] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:=
155 sunxi_ccu_probe+0x105/0x164
[    1.091165] No max_rate, ignoring min_rate of clock 16 - pll-audio0
[    1.097441] Modules linked in:
[    1.100503] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6=
.6.32-winglet #7
[    1.108602] Hardware name: Generic DT based system
[    1.113404]  unwind_backtrace from show_stack+0xb/0xc
[    1.118474]  show_stack from dump_stack_lvl+0x2b/0x34
[    1.123564]  dump_stack_lvl from __warn+0x5d/0x92
[    1.128288]  __warn from warn_slowpath_fmt+0xd7/0x12c
[    1.133356]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
[    1.139283]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
[    1.145318]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
[    1.151680]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
[    1.157537]  platform_probe from really_probe+0x81/0x1d0
[    1.162857]  really_probe from __driver_probe_device+0x59/0x130
[    1.168816]  __driver_probe_device from driver_probe_device+0x2d/0xc8
[    1.175278]  driver_probe_device from __driver_attach+0x4d/0xf0
[    1.181219]  __driver_attach from bus_for_each_dev+0x49/0x84
[    1.186908]  bus_for_each_dev from bus_add_driver+0x91/0x13c
[    1.192595]  bus_add_driver from driver_register+0x37/0xa4
[    1.198103]  driver_register from do_one_initcall+0x41/0x1c4
[    1.203803]  do_one_initcall from kernel_init_freeable+0x13d/0x180
[    1.210006]  kernel_init_freeable from kernel_init+0x15/0xec
[    1.215684]  kernel_init from ret_from_fork+0x11/0x1c
[    1.220759] Exception stack(0xc8815fb0 to 0xc8815ff8)
[    1.225806] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    1.233984] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    1.242169] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.248818] ---[ end trace 0000000000000000 ]---

