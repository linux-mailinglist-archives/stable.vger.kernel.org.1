Return-Path: <stable+bounces-100509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4E9EC177
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2465F169550
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65D13B298;
	Wed, 11 Dec 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uwx0D4TE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GxGOAvnf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IjT7I9QV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106778F59;
	Wed, 11 Dec 2024 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880037; cv=fail; b=pNeW3LFkKmn+1pX6Y6jnHuIOrSluRLLARs0LPvbVrx04Y/6oZk3Pv7JLqhIOm5Kqc4YwVVsUPbZdBQx9sQBs+twLxVDZWPX0D8Q1a8bhjRzJINRzQynVeQsa8QeUhbqW51iuslBAaYAuzrSRknIMTjAx73VmjPDkCsmlCn9gVvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880037; c=relaxed/simple;
	bh=01abjqtU73ydHJmeeq4hG0UxruHWB5j+KUYyqYpYc+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OK3RD8rm25cjuoHciPSifKBJBWvZMx1BZDECwcY1Q9cLTDDd84NF8/gdOvR7X/8+9qWoQPOcw1RH6PQM9OUtbwZ+4IePiaIIlmIcfy5ezWdZ3YURnMbjCBLohPacDuqU+jqoCB47LjyQL5xfUX3azOVXr4yWYcqi3Mn2EqyrboA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uwx0D4TE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GxGOAvnf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IjT7I9QV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANAfGF010838;
	Tue, 10 Dec 2024 16:31:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=o70eq8Wi84u98H2mL1OU2J7lHDMgdsir59kNkeW66Ig=; b=uwx0D4TEqlis
	D7LRcTII0JUVGbcRAXtT3mBF9TexZQj2HRAln0NXjFyLwr2CyeTeFGJYyj/J1OdG
	aJEHDB6jfJexjwVqxpMoQ8A1+8fvyX1n3GITxB1lcCbkU2FInZHN6WxqhmfQet4Q
	Anb5SOiLRGCGWNofh0+yORkQyflxZxzLjIyq3BsnG5cZPV/XwVwgrmxFqFjf68vT
	oiGhfDRTffl3ewsCAcH7NNKUlJZJQeuZdCz4K6AQtA8vzexRnG5REAbHhOQ9+aS3
	aCQYlksTDyKilxo1kVSm133AjEJC/7EVYfA9pS/YUuly1SPmJH7CeFEyBg+As11U
	8RyCS6qMBQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cpgb9ptg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877118; bh=01abjqtU73ydHJmeeq4hG0UxruHWB5j+KUYyqYpYc+Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GxGOAvnfFwJf0l8F+svQ63VzR46CLuVodd/8xfV/52RXsB1H04ClkWPg7W4nUd2uj
	 oGBZMWN8BTXNUJpS1uQLxJQmhnzAN9r/nYTajpU3Od4qeX0tKfVDe5r9FNehtNRcKc
	 yMerKOdN/DEkBVFzN2h20EK2y+UGI6ut7cPUZQFhn0zazqU/iVltuGusItsriHKng2
	 n4d1/HlElklMBJuQnGree+ij8atYvIvhdDq7M5bAvsrzVaTokYMAVoCQG3Ozd8hLWv
	 L/dV+SK2BIdAYc/wBIbOsCAfBvoZzz1u6wOgYS2OoFIOkTCSrS4TBmRymEgSGPn/hZ
	 84hhQnRcxtUqw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B6E5E405EA;
	Wed, 11 Dec 2024 00:31:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 96137A0078;
	Wed, 11 Dec 2024 00:31:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IjT7I9QV;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 429524052F;
	Wed, 11 Dec 2024 00:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqKmsiDve//zjp9TiNQbQMxyNQACovfJktgTTgr1Bo3ksTtp2JUBkik9uS9iWf9paZQwd0W5mipFo58Bsc7/Te3PoTBJODjT1uVPYHY0jpX74TiU4L6fcvf7MNkTdfNgJ2eJB1bbbyrloMPGdZFQfIEf1Vk6hzaG+xaWPmGx21snhcj9RKrQTeZlgJ1X1NOJYsqDZQcyt0BaFmyuJebXuEsrJUuu3yKADLHZ1z1yrPRi8VClcYPqht7/PbTrxdO9FLL7gLXeVvSeBISwLjFDyS1I4le1RBcWlDDFrYlsJb1BA3fd4ECQRj9voDmzCqEfdUg8Eur60BsGMVryZ0lnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o70eq8Wi84u98H2mL1OU2J7lHDMgdsir59kNkeW66Ig=;
 b=KSzPRZuWqRjI3h3KI4B6yqr1Y3OqhqYgURmF7o/PDpwgyDOyz3eLGCrk9SDzE5MvvlJEC2/kWANCsNvwxFL/IsbGpokgAxvAhWirOJ9Ma25c73A+JPm1p99BPUZsVBMobKz6oXapfjtu7cHZtJlHMHRjpW4zvKQXm7Y5IpO8NdossffVqES6E3cXnyenzOaz+ai56nxLik1Oo++X92mOEDmrOVIxlRseaar+NrcoVs9MnjVYTmz5GY5fAaas0Pa9U70seCBXJXp6UZTr1mXX9Oqgz0JKqxSZiJq2oF4JzIY4QdH6X5zyGHqlvevvLUhNdL84xZjXIIqPOZKm99mGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o70eq8Wi84u98H2mL1OU2J7lHDMgdsir59kNkeW66Ig=;
 b=IjT7I9QVD23a3pLuX6jfK0e88ZXMjreuz0mWNQNIoaql7F3bFOTUfWbqrWJRpeQaLj6N4/nPJx4nzHVRmycZW/JzSvoEz0QulOzdgNDM0sBR/2Aoa1fpbIrYvJJawnWqNPKrnG6P7exugNp2hSPE1ggcLKdMfeQJP9GphOs1nD4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:31:55 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:31:55 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Homura Akemi
	<a1134123566@gmail.com>
Subject: [PATCH v3 04/28] usb: gadget: f_tcm: Fix Get/SetInterface return
 value
Thread-Topic: [PATCH v3 04/28] usb: gadget: f_tcm: Fix Get/SetInterface return
 value
Thread-Index: AQHbS2QU9/q0tySWeUmFeqAe0EQW+g==
Date: Wed, 11 Dec 2024 00:31:55 +0000
Message-ID:
 <ffd91b4640945ea4d3b4f4091cf1abbdbd9cf4fc.1733876548.git.Thinh.Nguyen@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: f6575bc7-8d7a-43f3-1cca-08dd197b36fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bwWCANdjWpLCk6RSTuFr68mtbcRcbdrDYVHXx6UkrxA6TVwwfeTSohWR6R?=
 =?iso-8859-1?Q?yrGMwx7FXHHohgCnzkkYMvsQAy1PKrHZdMZp6NF54KbqI4NdH7TzXC3Sfu?=
 =?iso-8859-1?Q?+HQLcNlUErAlRuDXvi32M9KKV1SHxDtuCPQckCayS5U8MNF+NvTN5osjFM?=
 =?iso-8859-1?Q?yMhggAYOmJa5lc9ySU/gbSaxtjsqTXXKjFcLF+SXVMN4Z/cRF5nyCRXp3F?=
 =?iso-8859-1?Q?BaQDHIIcSMbN4Q7G8AMJI7LzBy4m6g0z7qBYA5McMJKUfTvdmfjCi+3+bW?=
 =?iso-8859-1?Q?C9sxwDL3RlqysJZcmzKblneetKkx66EEgBXL7j9nf2Kd4AwqSY/3tW2cMT?=
 =?iso-8859-1?Q?5AIFeZgKazktYT9BU2BC5QzRsXvIJv02CX4emQhqP3l3hYD1PA2PRF1E+4?=
 =?iso-8859-1?Q?43z9qgrgTu9Ey9Lm5mUBO1fb05L0f44kDFirj6ZGC6UFcDnXZ4vYNL127t?=
 =?iso-8859-1?Q?VsXmyUQt0c/P3QY1fpaSPlqIEkPC2NJcxsfVfa4cKE7+l8WACaqI8F7HhQ?=
 =?iso-8859-1?Q?CK/0FCmtazWsC9gv58IktZgkp5QqtK4187xe6COCUOgLjeHDBlGVRuPz5T?=
 =?iso-8859-1?Q?S2O1LplVe4PP0d7L5gr+3vVErOmp0bU1AI7dkIskPwPN6UXYGvqQ1SYd+d?=
 =?iso-8859-1?Q?oxdMyh77s4El7qZV6e/eTLJ0l1ssdGhfECciPQRKe8BTAhi880ZNYyHL/W?=
 =?iso-8859-1?Q?3t98nTimcOWNsu3altMsevPXC8nVewbtX3ghL/5POt7B27pJQs4KOJErqm?=
 =?iso-8859-1?Q?ufaPCopZnogUScfZ2a/U9/y3K/GZGXI72OGUkwDFKU+KqEd6MvtSH30+5F?=
 =?iso-8859-1?Q?vKApNY4/xJof0WygbxRLSaVaTwrR0akZXmxbUn3B/hLk9f0k46kWBHxtZp?=
 =?iso-8859-1?Q?chQuVuxR/BfkBw2fSemWz945G8x21S9MBnX+bMoQttf9GG1mKFDVN0Dt0/?=
 =?iso-8859-1?Q?secJEYtQXjhEUL7Q7lh9In5kWZgR9nzv78pFGQmWPT4w1I/whv3F3XpDam?=
 =?iso-8859-1?Q?SHk4w9kAeWktIleuyM1eoQWyKV4LJfpfFw7HApEqTyS+fhqy925krINXCV?=
 =?iso-8859-1?Q?BZwi+PGisP8BUK97W3eJIgBJjGwC0HYz4JFqat5ez9hABQChhFTQ+iKzRu?=
 =?iso-8859-1?Q?EXELPbkSayx3GpRGTOm/fCC1FOfaB900uzetAarQLvsPxLF6V9vxwzmJ+c?=
 =?iso-8859-1?Q?009zeDX+bTNG0udAOANRQuHkptwkascrx1E8d9geir0a9miJwge4ceJsDn?=
 =?iso-8859-1?Q?jLxfzhh9HOXycx44loLx4w0K0YXmu0YrpFMpqkzCCaX6JnUcy2O6koBD7f?=
 =?iso-8859-1?Q?Q2rbFPpSmP6WK+l0fV9NcuGImPh79sNneq1dkyW9O7kGVjFPLuv+u9jFvy?=
 =?iso-8859-1?Q?HoeGgX0cpMyzYviWTLNPWX/3AS+LC70ruvQb1na6rq2ypLeP1eQ+E1HzM1?=
 =?iso-8859-1?Q?n/wcNOuwB3ZbvSfqxGyrWoOh7IhMf1WsmtFQRw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pftWXWjSGf45sET3+qYbWBKPiYTvm87oG6W+aXd9upXTpvJsQO+0Helz4i?=
 =?iso-8859-1?Q?A6p3OzNPapBcgzfC5lb6YRnGKOaisDrznqfYRn1TiKgCPgDEKhkovSujB6?=
 =?iso-8859-1?Q?1KG3MowdJa0aEYxd5pxaz/aUlk1NDMporXi7Du8JypjbnNG86taWW/gerH?=
 =?iso-8859-1?Q?KhhDzR9IqGFw6dV9/ak06N+RADWeKy5eR2kTsICvUeCOb4pLPYMQN2h64y?=
 =?iso-8859-1?Q?v9H+GuwF0LVoIcC98/y4tO9wBP+Irwqxf+uaEtycwmUJhjEbHqs0oWvP53?=
 =?iso-8859-1?Q?xHnOVDrFc2TlkfIRgKydxxbr2VltOnSbO2+XPSHSQlDTKCU3yV8zNGwBJ/?=
 =?iso-8859-1?Q?B3FP5tovYYKMclIRGWA8OMuPLtwX6bNCvvzVu8CQmQBNWnD8JO0EIR7mDF?=
 =?iso-8859-1?Q?5mRrU5VBD/H1wwkwM1i9Sgk0UNk5gzrmuKQ35NLHc0hDOx6ujmqFwpup2j?=
 =?iso-8859-1?Q?mZaSCMqbeg3VNUhAPkvlsoqaXYsnJgFZQl4SY1zTnErj11WLkepxEcWrtR?=
 =?iso-8859-1?Q?h70pVicXY26SFNIbhwZxhk642JFevoijbBORLWDvODPhotzpd8cE12MYmX?=
 =?iso-8859-1?Q?pate98m5tgg8bNgzAJfGBVx+/BDmlGiorpTiDd/IWjfKmtMuAYgSusaHXo?=
 =?iso-8859-1?Q?k3znIGi0iduFrc8f1lu80rwjrBRWy1nAGGndJ8+Vw5ffx+zT3qUu/TFYqe?=
 =?iso-8859-1?Q?c+OcEVY+9uo51vaYwRI1FMhvwBo9YQjdOhbhvxLP/gC3FG+GjL2eEk5u+y?=
 =?iso-8859-1?Q?EN3OZoY5f6RvCKNbeQT4PG3OIOnk335dN8M22tRVxEyjNj+mpVBHkKrgqL?=
 =?iso-8859-1?Q?yVbeir6hgDOmwgomqvqhcajwKeFpqYfIf11+7Rig0E4OuoQmJGHtRfcpBG?=
 =?iso-8859-1?Q?HPBzMqH3qgV324xxIk6O/NncG5t1d7CtBM6H8IWQR1M2aYzdNKREbPwxvH?=
 =?iso-8859-1?Q?PiobL5zJ2E+zi4UoFRwVLh3IvPZmpe9XUtt+8kPt7kfYQWSujOG0hCxS6b?=
 =?iso-8859-1?Q?zmbULM86RxcslPKAgPHBhzJCtM0xIP5ZleEq3vdihmrtW2ubAlexWRJcnJ?=
 =?iso-8859-1?Q?fZMEhLzy1GRQrDYP1rmWVp7Px8OLfYpC9PN1WkmGKXMqiVjbWR6UIsLlpq?=
 =?iso-8859-1?Q?kX7uOhik6nXJOekl0Q+Md0vcJ7gmWugWcSWZ7QFSgHfEyAbqYFcFYWO4ra?=
 =?iso-8859-1?Q?smpY2AfYG95aBiycJRY698oWOyWujGOA+QOR7A1AXWEl5buZAI5zHtTbjP?=
 =?iso-8859-1?Q?raWYWY4ux+RTNBDhXBT8gkiSn7Q2Q079b5Pw5CW26HUtjc+utX0SOSQwEa?=
 =?iso-8859-1?Q?ST+djHWBt29LNzZx+tki4/935M6Tikki1i1gBbyOkMls+RdyDwgy/l4Mc9?=
 =?iso-8859-1?Q?HhBQjY+P0XLI+L7T8Vb1LdYy7HmJ8ilAnT+vos5cF/V9u14SzzvVCKvAOQ?=
 =?iso-8859-1?Q?vmfPbVzpdxCQ93f6i6aCAu+yDknYDEHiU12jCTnEejK35/yF6IM/AjmY9U?=
 =?iso-8859-1?Q?hsSE4U69Ll0rilmnQJ8UkrQR3IzUv+Pt1NSwyOQPUipbue9/ltqVEDswXE?=
 =?iso-8859-1?Q?LCSut+Q1Tm+LA2RFdHB0YOys70bk+wsLX4K3eo/jqDmyA8ED7jtqERgk22?=
 =?iso-8859-1?Q?pY1N4ACIuWTnyoXi6OKUabARBP7QHGtath?=
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
	mhKsRvT2nnN3CBxiRka3Z/oUvDot61zpwD2YNioDRryODK9yvgUn2XFLyWwSSgMUbNdrdkilSJikgHOeHPILEZelxOnJBY+QwoPgqD4zsPwv9/4ugSa5EfIsCtMTE/7z2JhqDLDvRuDtXE2ERTHTq7Q0WkWo5HiweICr2eKxSWU6j6OlVWccGNqkzS+16iSEYo7RxaYOn0TuNakj1met2wncO7GFMN6vCb3Nh7qAMOBEuFJK/R19qHUx6lqVfKb+CfAsroaPrUq2VWIFSAe1YBobqFDUqUkIhmepJLM41iyFTw92XYDPGKGNI+tGnQAdaoHAz51tRTHPjMytbGmxihtTQnGS+ow0FDMKpTFjO4e5wXT8NC0KBC1aNHBOh7FUWSRuqADg+um8OFYtvPb+01V5X0UStx0/hLUDZ4bYgbQKu94DKxVj6lPbxRD28RjXMSMzHbmUHIlaCWGdsrups/C3QS0yZHEbV9o8rS7uEHTl7Fw3aTbMywVz3IDxCGm/RQ+Ev6zhdocWdZ2whRkasDTyDAtK8K00CP5HoSTMDGxerLnpsRaTz7RwArGFqcRL7RYGeLcDcDlhcaO04Ot+3d5zB7ug23IBfOB/oBOxs87ajDqi4//EaNO2njkcUPcGmJ8J0HoX4P5TyoBo3zvGwQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6575bc7-8d7a-43f3-1cca-08dd197b36fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:31:55.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: st8fqijvpdAnnWwc6i4xVGLiBImxZXSVK0Z39SJlPNRlH222bE6An+Zmcm91NXQppVELHJuFngflg7VyJcRGng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Authority-Analysis: v=2.4 cv=d+8PyQjE c=1 sm=1 tr=0 ts=6758dd7f cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=8ypM3a4PBwIcZ7bM9bQA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: FN5BzpjO27UOXWklEzHUuir8OLC5fxWh
X-Proofpoint-ORIG-GUID: FN5BzpjO27UOXWklEzHUuir8OLC5fxWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=857 suspectscore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

Check to make sure that the GetInterface and SetInterface are for valid
interface. Return proper alternate setting number on GetInterface.

Fixes: 0b8b1a1fede0 ("usb: gadget: f_tcm: Provide support to get alternate =
setting in tcm function")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/funct=
ion/f_tcm.c
index 5ce97723376e..f996878e1aea 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2046,9 +2046,14 @@ static void tcm_delayed_set_alt(struct work_struct *=
wq)
=20
 static int tcm_get_alt(struct usb_function *f, unsigned intf)
 {
-	if (intf =3D=3D bot_intf_desc.bInterfaceNumber)
+	struct f_uas *fu =3D to_f_uas(f);
+
+	if (fu->iface !=3D intf)
+		return -EOPNOTSUPP;
+
+	if (fu->flags & USBG_IS_BOT)
 		return USB_G_ALT_INT_BBB;
-	if (intf =3D=3D uasp_intf_desc.bInterfaceNumber)
+	else if (fu->flags & USBG_IS_UAS)
 		return USB_G_ALT_INT_UAS;
=20
 	return -EOPNOTSUPP;
@@ -2058,6 +2063,9 @@ static int tcm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
 {
 	struct f_uas *fu =3D to_f_uas(f);
=20
+	if (fu->iface !=3D intf)
+		return -EOPNOTSUPP;
+
 	if ((alt =3D=3D USB_G_ALT_INT_BBB) || (alt =3D=3D USB_G_ALT_INT_UAS)) {
 		struct guas_setup_wq *work;
=20
--=20
2.28.0

