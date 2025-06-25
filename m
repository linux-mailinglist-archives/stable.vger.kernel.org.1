Return-Path: <stable+bounces-158486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63BAE767B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 07:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797731BC4446
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE01E51EE;
	Wed, 25 Jun 2025 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PSPhQJyp";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bItxUCte";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CP5pWbZI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C61A4F3C
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750830643; cv=fail; b=Ev1MHHSsKjviCni0SnAV5UWXevrujl5mLbYS9aNaIiMOkm67CnO5/00bFpDYgLYXQHm9Rbdi9/wn+8KWiHqRo/E/ZK70DYjDCWYQ5+o79RpfxT0sId0HIWomGUasR2gvGxzGCyXKO/IQrRvoeVVzSFm8vhbSn6dF2xZ1/CuQl0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750830643; c=relaxed/simple;
	bh=IXMD1EidJr5mo8j8m96YdJlGt9p+hxIMDbAK8iSjgdQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mri8dL2Yu+WfrxuolvCiW8jSs//tt/l9VK2o5ynAli3fqeCeNw2VssPcSSdtr0weCvYdyTVu9PJhqPVJ1MXJzGfpMh+mQWotjMzx/E8xfbHvMa1kCMibubBiykLpeRbi5/1SOd/EUZyTFxXIEVGZEaid4/tsVdJny2ff+DiMzTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PSPhQJyp; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bItxUCte; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CP5pWbZI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P4XNVf031897;
	Tue, 24 Jun 2025 22:50:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=PLIGIuFVghwrwDm70Ea
	oMxI3OHIqjQ3WwdFIxs6quQg=; b=PSPhQJypAKhYcW0cUJb7xZEnCCCxGMaPm0o
	LVa9u3a6jE8meG2/lHlIKBQJ/xLuQwT9cPRW7aiTAnJKPKQqCRzIAT6TDs2uA4kH
	kPMj9MLPsk9Zj025jD2yKBlC3enBP7LNopxZB2UNMRgqGoFjfb9Rkn+kgqzFleg3
	rs10QxUMEZE1EMa0EpvatlRWpObLX3cwBhOjKlH8jTcTrsoWCzvItR0zbp9CrdWl
	zWrvBcun5ZLTM/XtYLTNzhTbFootII+/QZ6mXkp/5TcgF3ksYpY+SIKkNWlbu9Mb
	ehN37mICgZWPvwKTFybkZsLJMfKnFek1H60ylsMxQDPmCaxxqwA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 47dunxqcj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1750830626; bh=IXMD1EidJr5mo8j8m96YdJlGt9p+hxIMDbAK8iSjgdQ=;
	h=From:To:CC:Subject:Date:From;
	b=bItxUCtee6bOVffvqFXyXNhEtKc/FPwm/nDmSb+2NaS/Xq+p7k/AanQRgC8S5u8wa
	 i7jpWUrAcswzSCi3USaUSGlzKj8XbAAreUDfxJKkjA7VSZBhmaiHPhRoJ2WDi7f833
	 xChVg8Ubam6b7qxVNH9T0Tin4WbXUPuE8cbFqJul1dyEPtCzc2d/V0qfTehtuqg3lm
	 hSm2wz18xt0EjyyPtjtfPX/leGCaxWost+h9Uidhfa7ffjrtUYw1x6StqoON7FrtMT
	 w+yNi0KXHU8I0A8SL15G3vICERkTpOSiefrHdCbDOE5a8K7Hgq4Kz1JobLtgP7Pr2j
	 8lNA1Hj8SAeTQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 87776404CF;
	Wed, 25 Jun 2025 05:50:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 01D4AA0081;
	Wed, 25 Jun 2025 05:50:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CP5pWbZI;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5214940519;
	Wed, 25 Jun 2025 05:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIT0gGrOogZa1dG3ZzHWKhMZph44bEdkHckxMzM/s4WPF+7H6aWL60y7FAr5RLUD5B95IJTAqDhKA6gLRkCQ6BYz5cghB5h3kDZsQryI3u8a63dQNGiPA34E4We++xmyYacYfsLeETGiL2+azVtEOhqdMB/GF911+mBA/1PDOikZO+eJgggp5C1m/EaTku4D3MEqePU9VgBpTaHsmqmU8iWf34RHl9hluK/B9gs0sOFIDRLdLrMEsjkSLsKqprqDplQdPOeV+1JVKsKT5llUqcu3jIOA95TwdLtM1RsfaIFP+XoV9UAiGnIjCA/0cGSdwzDp6CiBNEwcVC1qjYuovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLIGIuFVghwrwDm70EaoMxI3OHIqjQ3WwdFIxs6quQg=;
 b=tpUedQjaic+WxNVFAfUIWEos/lNpP/HJBMxB5dYulibr7SR82+F90VCOj781rW3KwNzOBQChW8D7vLQPXbRYHbMrDdi06TYn5zM8O6xtHZ6lWuNYp42zO5JzjgP8+Xm6jK42hcEXYg0LAtKDEebmWL5FEeRSjdS2vL9Und93LRPo452z9DGuN/x2lvpt3OoENkUxcmhKQLltWXLUjwhj94mBSyGsHsROvs7pdxb6PlbUbznBc591fs93HzZh03WxnN/XKGmzexBUWZW51Rz/6DRpKWOZ98zx6J3t00VZsDuwrhcSzUqr5CQDoaJ1HEkOxXCZaARBeFvG1Vc2my35xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLIGIuFVghwrwDm70EaoMxI3OHIqjQ3WwdFIxs6quQg=;
 b=CP5pWbZIrnq5Bi7Qzc5uD+12esH8URiADPtZp6YxQt1scC7CzhSjYCXbc88OeQna8+WcOtYNnfOGfe9sQ6lWpZpsrvhAd47Vhj0cV2Yjl6NTrTXKx8VMokPCbOP8PQo5Bbat29fby7KXkRSBsuKdM/sFr+emavab02wE4KYrNrQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 05:50:21 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 05:50:21 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v 5] usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY
Thread-Topic: [PATCH v 5] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Thread-Index: AQHb5ZUJzDmWXDbbekyJ/6gMZJjFAQ==
Date: Wed, 25 Jun 2025 05:50:21 +0000
Message-ID:
 <7cbf0262dd5f9a98824b573b27f724250ea9b2be.1750769936.git.Minas.Harutyunyan@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7512:EE_
x-ms-office365-filtering-correlation-id: 9a5dadd9-8a70-434e-595c-08ddb3ac2c38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PmBV8LjTcCVRUG7bCZJeOECmgrWMPmo79zGi7lSE1AT7I7a+0lJCytdhZF?=
 =?iso-8859-1?Q?BfIiImj+ni0HKbEmxIllmXwCbcZknuYVeCacqVKgt6I8RlHoMYAPnSefDt?=
 =?iso-8859-1?Q?6vd4J6bIccNPamq1gjWIZgnz9kV0If9iwslETcyqT+YOUCYWGXnM/YV6R2?=
 =?iso-8859-1?Q?GwEBMxywJmRjgtC6etEekhX+jP7D8254TLmFgQ7mHrj3pUU2vA25YN7A9c?=
 =?iso-8859-1?Q?dagiFcv+4mAv9e3w++85sdGMWhcqkwpUJolIrLSF7X7EA8W7dHH3C03deG?=
 =?iso-8859-1?Q?x7/JJCXniQz3I2eRrraK7bLVLJa7tVFYfo3OHR1srrzwib9W8c/PjIbl0l?=
 =?iso-8859-1?Q?m2E9vTQWQMYU3mMY9AUlh28LoWuKw4T6tlt58kypLvon/fQm4Ji24TaC8x?=
 =?iso-8859-1?Q?ZoG+1QWiqTt+NpF47TeLT0HKBF4u57DE+oPjJhAdLurUXPRboMlhpXnaDW?=
 =?iso-8859-1?Q?AFlYSn8OwqCNSzU8sr0d5ox3hsk+yF1vWIirrqOGCcFxArPWolon3c9ope?=
 =?iso-8859-1?Q?Qj0vOl0N6WWMYXrpooUywdIpDudiH/R5m+jwZPOD0NlUjRaT15Zv+2gn40?=
 =?iso-8859-1?Q?QnAXrDNWsZJW1l1Rzx9DNEdiL8H1CaG1T5MRRTbGSjnZAee5In0+6vwV72?=
 =?iso-8859-1?Q?60CPIhGzQ8di8egUm/CLtetXDqMAXGE8UTTNZuVWUgAY2F3BpkZw0ax0tM?=
 =?iso-8859-1?Q?FRPgMPmPFIa2VnmSfi+hJ00TX10QAYCGzD/o0nVoL9wSXqN0k3SyOtBfBr?=
 =?iso-8859-1?Q?Gac2IadWhYudpu2pBmzC+lSa/XAE1840eavWTGYZAN4M5ZUrGvXRNsF8nx?=
 =?iso-8859-1?Q?ylDFm4wrxIJcT15Xyf3yTw+lk4EyhEoucO2VdSp3yNKB1Td2Z4DD3lNCNu?=
 =?iso-8859-1?Q?zTPAC98Nax0fszX1G0YgPXb04aV7/qeKN2I1GgksK2eNnpW7vLm+7B0IP9?=
 =?iso-8859-1?Q?fvbupkLnB/ijZrKNyQp9T7TgnoBRsajHh/NC5nyqLWC7+0UaCu1C3R6myF?=
 =?iso-8859-1?Q?4lc+pZXuDNy7wapcV+eejKIetYUf2SZyh/7v7jXOMnKjUGtkPbVNEH+78m?=
 =?iso-8859-1?Q?fWTvHMEzJ4MnUaK8hfnZmbbkB4H1aKO29u2TmVQphSJAdRta9gi3gpGmvY?=
 =?iso-8859-1?Q?VQGBwdyjNDmC3FpZTfH1VKhwZ8S29x/gnRQbcau1UJysIpiJDuX07N6iWx?=
 =?iso-8859-1?Q?mphjsgH63IH9BJyCiwL3dHF74IIxEi/96uUOIwFfHRxHS4nbEqbfw7kvz1?=
 =?iso-8859-1?Q?JuloUL56sHMZAaUEZVIKF8VZXE0J0yXWx7AEblKoo3U+YmJAPbjY90dx1n?=
 =?iso-8859-1?Q?5AUD8yYZOu3ipHIsjbH7DrGrMR9HXiftj0IwZPC86E4bSsOTCWtGeBeHiL?=
 =?iso-8859-1?Q?giLfINTwvGs7v8zDHchceEoS4Z39VFNIxBBiHn71uJz9OWF03pv/Gmxu9z?=
 =?iso-8859-1?Q?s6ONsuMiA4/DhFYmM2worlQbfbcqDODXYnrZD0yyWUQWxnmi4IffbTrVnE?=
 =?iso-8859-1?Q?XSU6zenJoVIOn1lvanHr9budUnGk96w1zQWwQfo+Rj2UdsZKujf4VTMtyt?=
 =?iso-8859-1?Q?+eh7viM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?50r6TBCKdYXw2hCugoGjfs8lSsSdPNyNZbPADSRtHdgDAeFBEvcH4x3sG/?=
 =?iso-8859-1?Q?3hRX56xNb31YkzOwU4rYbJMSNLAbVUdUhs7XjEPxzaQI+Kvs1IIiXjYH63?=
 =?iso-8859-1?Q?1PZdA6/xnk0ypvAEc6aEiDJwekZ+H+FBaNquIxPW8mCr+aOq5oxfXUIz8l?=
 =?iso-8859-1?Q?B1h9BKicwSlfTmwAcK+H1aDJQtGON8B4fZpSs2f7gNBJkyJsyqbls/4XlI?=
 =?iso-8859-1?Q?beAvQUM1SeK5hw7A5C8HLyxT7ZHAx08ZIfCcCGoKXu2oKTEDgiyVO7bH7y?=
 =?iso-8859-1?Q?UjptBRusPWk+uKA0Mkh5LQmBd8oJYngoc7rWjrf16JscTchfcVCpudN4Lj?=
 =?iso-8859-1?Q?4l79hj488F4UiDg2avKzxjBaSiUtYfE4CMDTw+oBM7bUObgs6OXRfdUOZN?=
 =?iso-8859-1?Q?wcvMO39gMjA3lfGYBKsVWfQ1UuRSNv5BfLfFcrZWjYGq/63I919newGrwo?=
 =?iso-8859-1?Q?ZqFhOpygVLdT7a/u/XgVdN88h2tkMK1v+uGfsalPPp6jEWDAqIbCbW3Lrh?=
 =?iso-8859-1?Q?NI9vskNXDwC6GUy7cX0Way28mrcsVsNmKaffHJJZQ8JxSv3sGhSFDXgWix?=
 =?iso-8859-1?Q?X2npvGvjC/poLk6iuVKEES+osJD26QXbN3faDwmbWIGkBjl7o7uLSeGtkT?=
 =?iso-8859-1?Q?kv5lQoXLdqPuMyL/EHOcCiigFcHxzbeW1UOwD16YTPfFZF5a5DKVg7TVvu?=
 =?iso-8859-1?Q?RyiNOOeb2++HuR0EsmbKhPcTwLJ1+gOv+Ly62eZttlxm3j2YhNG2Dl/R/8?=
 =?iso-8859-1?Q?fWhgYUILqnIU041HcKAKKagaTi8KPUpNQ5ANShrwJTw5d13fuqsA2NUQDD?=
 =?iso-8859-1?Q?0GxliNhJqXUtuyGAMizhCK9rU0B1sbgV8vXyPtkUVfdGdfhyRRpFs+f2vb?=
 =?iso-8859-1?Q?Fd8LYgteCiyrGeS1ugK50oS2gbqwAnV62s5rYLgpic7I6k+fUwf2OrgDKE?=
 =?iso-8859-1?Q?HUYSJ3rr3V9syO91IvhbB+yswgnNi8aro3FvqVtqLmhzlSdkEeSXw4tE6X?=
 =?iso-8859-1?Q?gYyhGXv/X1tDTO6LPyYuybR8TUlBChNFL6A6g8nl7R7Vr1Qt4lz0jgvAkx?=
 =?iso-8859-1?Q?emAdt/uY/bcxLbLPklSHzBf6uLUKqvYGmsVQt+pJKQMsmp3976jeFBQHhn?=
 =?iso-8859-1?Q?4c4PEkDlj2Ya70WrE3/vtb1snNIvpRfsO/KiT6FSGnjfacSGymgSE5dRQ/?=
 =?iso-8859-1?Q?lkjqfL7JpfgoIew5zlgDYlK6AUyoPDg6C9e2NKMgogczYxYvLsLoMtmhQZ?=
 =?iso-8859-1?Q?ry+TqeN5T4gpRz9JmjczE57HheK07XqAuFIJGJdK8YRDR+MUyKf9IWRD/g?=
 =?iso-8859-1?Q?2OMrP+PX3IcKA7ZxyECtFg4pRvEJ4wXUsW/QU7SpxxtaRDWkwianGZvN21?=
 =?iso-8859-1?Q?0e8Qx94GFycMVGLPGtKtkf+ntQvC4jyTwoU0IzINnieTr98och/S/0ZCaz?=
 =?iso-8859-1?Q?xnbfJANRGtOEbk2e96gUocmCgud8QhLcX4dwE859e6qMsvu+fTn5IU9Fw/?=
 =?iso-8859-1?Q?3vT26qPRYjvI2IeGfsrPv7E1ldoNCtZ5jtog1Nq6sgfkCwAKWTsvKu41ae?=
 =?iso-8859-1?Q?wZTOZ0WYXnMqt7yz0t7SUA4rc/OBQd2OT8aCqsrLqxBXEh+tFTA7gJrcYP?=
 =?iso-8859-1?Q?oLKC7D+Iitq+dNsKoekWNJ5PGl8+K+kPhV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W8rxydc5WSHSUGEe+hy9bnrjxJgt4ApC4Ifd0SVtPysaUxsqYKP0JdpqcZd7oJnoVJSsNXoc1q3jI4lgysmSRiO76DiGOtKW0d5drPqztcQk9OkqT3GD1AQrRl1e5fwKlkqrQ6jC8PVN4QkJ/Ly4Elx8H36AXvD73GhTxRY5wuIRkCsUNpfWpbEcHdQP7t5Rot0h5l1MvMdnUfwNJudSk/bCLfquxBauK14kEO5X9vYh0UOQXDShI6tcgn1b0oHRx7uTJh6d4Iwjn4ohAwCa4c3gh/0HAz+DPckW1WUKpauHtsbfaNf5+FlydsXIhlBXZ5RmFMJcIOToct8/PLC5MM+/EdfeIo75lcQVU74pv+8q197QTafO/vsJp4b8Xso5gkBbOJpPLBPRNO15+7D6RY0xzfU4SslEuV1vxg3F6WBg2If97fDeV4wGP8N2nHGBIiw2DuZGpsT3I0JgyqT1XwX7ypr5b658zPCyCdeJsq9fruZ579YezGSWcEyyFwbBlTFoWPBa6gIxKgSZkN9mdNdfImyfGQttM/+engx8AIrOMqmKfjjG5rR2YrJVshR1Nc/DgslfXNwpeHa/3OJt3M74qL9zP3HzfsFYSMfNouiv+FAXVA1dYLofxavLJufNtxj9wJsORERTZOA0hKAlcw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5dadd9-8a70-434e-595c-08ddb3ac2c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 05:50:21.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X75BL+YlqqoOd2TiVsFKw5xELcwdkVgY3G2WqQk2EvrZDLKA2DdW2bHIHkCCN2ArLBIzi0gtIytPksAq5/J4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
X-Proofpoint-ORIG-GUID: W_ubTi5tZ8-djjd5vUePW8WZecyrjlje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0MiBTYWx0ZWRfX1kA0uAw/aoU6
 APtOb/RE0AobIN6RnIEK8Opv1QLz2sLtlGBphvgmpCjMRY39YQ1gIolZO/MvExCQ2J39cVSVQJv
 mXBufo4X2wrJTHu6bsk46xes+od+T/LMv303rrbuBoB0WHIeXK/nC/WHhTbG+AiIiGa/Pq8vz+P
 FGu6kx6dC7wGq4g/JrPZmtarwo3W74rY/u2qdbqsuRNKVYoiQT7G8L6lleUYDbsLe0fqvBlzYAs
 T5Kd31iJ5E+X35W9vG8lwXI/jd5svTq5wZ0uMhpJAyTzHvFlr0i9bYdMfqNSIr/c5tRV0EEsVgB
 huFH3UXWthgTakUFQoDWeft11/NvG1TiRSbJU/lWLcmAcdsVPPrAIEmHXNEN6Xkb81fY3Op0MSH
 /7vB8+HqvTZIK78vMOO86Uk/W+AnVwvedMcmcVg5eQ8LeHuccslFQHmXM+DBe2pwMhACLjXa
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=685b8e23 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=1nkadCgX71emagpZ3AIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: W_ubTi5tZ8-djjd5vUePW8WZecyrjlje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=755
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2506250042

For UTMI+ PHY, according to programming guide, first should be set
PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
Remote Wakeup, then host notices disconnect instead.
For ULPI PHY, above mentioned bits must be set in reversed order:
STOPPCLK then PMUACTV.

Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 Changes in v5:
 - Rebased on top of Linux 6.16-rc2
 Changes in v4:
 - Rebased on top of Linux 6.15-rc6
 Changes in v3:
 - Rebased on top of Linux 6.15-rc4
 Changes in v2:
 - Added Cc: stable@vger.kernel.org

 drivers/usb/dwc2/gadget.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d5b622f78cf3..0637bfbc054e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5389,20 +5389,34 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
        if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
                /* ULPI interface */
                gpwrdn |=3D GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
-       }
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);

-       /* Suspend the Phy Clock */
-       pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
-       pcgcctl |=3D PCGCTL_STOPPCLK;
-       dwc2_writel(hsotg, pcgcctl, PCGCTL);
-       udelay(10);
+               /* Suspend the Phy Clock */
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);

-       gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
-       gpwrdn |=3D GPWRDN_PMUACTV;
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+       } else {
+               /* UTMI+ Interface */
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);
+       }

        /* Set flag to indicate that we are in hibernation */
        hsotg->hibernated =3D 1;

base-commit: 7aed15379db9c6ec67999cdaf5c443b7be06ea73
--
2.41.0

