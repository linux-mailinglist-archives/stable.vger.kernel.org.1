Return-Path: <stable+bounces-100504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B99EC0E2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685FA164256
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAC13A8F7;
	Wed, 11 Dec 2024 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="msueMJm+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M+YJY5n4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sJ4tueQA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785E1E535;
	Wed, 11 Dec 2024 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877241; cv=fail; b=tgUmmGhoP80HffBcAayakS0Vqtu85H5V0gbGMlF8bBrtvzSwpDYMnBGjZD5elDGoy3XpD19RFz7Iu8VAydZnQASN3oIDamdtEW93BBZRRiI63jlmhFsahUlzQhwN41pFQPGaDEsOW6HYZolIKQMt9THYd4YXIzE0FxHuktGj0/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877241; c=relaxed/simple;
	bh=kAmiVuk7PagAnVgZ2SZDweujIjlFy3BJDWxZSCig88w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NrpHyXfe0ze/nGE+CMgxIJfuzR6EIWeTfFCLP/tp8SThvPgbWFHUzzGYAGk5fXis+lZ+Tehl1MyGyW9GPc52oPFxR/fsTvXV/5krjyUsRbH4CE3hLoWL7yTYR5Qsl+47Cwf/1k6LEQomkVeiPZo3VsUJFWS8nQvHCLRehp/QDQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=msueMJm+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M+YJY5n4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sJ4tueQA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAM2nrG017323;
	Tue, 10 Dec 2024 16:31:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=uW4ImKlgKpP1u+HuMBz
	SQHDWem/YyOTu4wPPjfhBaqU=; b=msueMJm+JymwxgR0eQllmKuZ//aQ5EcJJRR
	zOatk3AHo8RbqaexnZlnAgwpYBgaLdKqnzkYZC/GvHS9MuPJkDiInf/ecVeTO210
	fWYcoj5a88IiMpUrXb8nkU8x3p8W/0zYgY9gVJG//rNB0HgzrxD0CkdQ9bRtj8pi
	4ItPtvm/62gL51HI7/ae+bGeTpKvbxCWZ/Fn+r2Rw99wxAOwVk5SbbEPDLSWwbtS
	868hk5mSGs3MrgiPULvR9+492wiiZygs8wZCcmtuK4iCVCA0g6Msx82J3MeZLFhv
	EET+ZMdyktPus2icMrdpv9jiU8gZcyM+38AzaRgfbBta5dSRLbA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cp60t0u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877097; bh=kAmiVuk7PagAnVgZ2SZDweujIjlFy3BJDWxZSCig88w=;
	h=From:To:CC:Subject:Date:From;
	b=M+YJY5n4vGYF0x7GaQDwjsbh0rdXsXzhkzNuQJn92bIISriVijCP9FYYsOKhrB7l3
	 836LIvFuypad8qzCpTmj99qwjEzL+LSHiMydQWPyCEOsuu8KXEucBteXURXLO5A6S3
	 OkglN74iXkeyy/Ic7ksHTfTbAjZz60WDPIdLzbU1BFl7MOQSMhXbi/2uMjcTiIl0wm
	 Z6Nq0v5A1M0yCqYqoGecu+tDjcK37+SmX9KD5PTFWYMVdEz3wmVOmwMN67IwcoZGYj
	 LiY8+RFXL1op/VGQhK8JxLEvufns2Cl/BJDPZYdzEd1opyB+VJCqWve/0qbATzCA/1
	 Pe3WpG8+XDotg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E75A440593;
	Wed, 11 Dec 2024 00:31:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 915ABA005F;
	Wed, 11 Dec 2024 00:31:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sJ4tueQA;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BD6B44041D;
	Wed, 11 Dec 2024 00:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk8PzNNV+HTQtCEgit5og1iuGrXAivcUHkOxVkWS7/SV5/sgrTAPrUdaxLbZLKwXJ3A4voT1Kj1nOO6d5H5sPA2yhTw1h4/BkGd6IqIOtpppTteljOuThmL1N++0JIjXKa8W3cHen8YwmicXE3VYe2v0Q/b0TQH/02SowpPYtfQpMzdGUrDg/V2CIwNhwS2LB6k4MkhOAlkZNntU5VR9SBTwR4V46wwvZ7Y/yLLOsry8AEclyAf8K0SZVXQyp5/OkyfPk4TNyM8iEViyvfgNd0D3hlWoyD/hrzB9T9hdlwRdoO+idNrzAhibNe/k3SbA8M4+S4qLGhFCO9i3Di4pJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW4ImKlgKpP1u+HuMBzSQHDWem/YyOTu4wPPjfhBaqU=;
 b=YGE6lu332T+bVlhU6GPeJmcX6q5Z6zaqh3v+Y6fESeQJ3QB7JX7XaoucKjqA1YvPZWKGv39GDAzSyv3XyPN24pzLDIBYjjO8FhKUKaatrZODE0DBZdPt+Jh96CWt1qTtHtNJpL4+4HbJQl6A62g2zPadH+Tb0ULofMRw3UyS82031djP/3x1X7SsUUGTl9h08X6i9zOkbb9ks6DPh9MACDYeFb+GMlIx9dAYkMO/luro2s5pgOD/VhqQt8fg5GaESEKj2p9rCoSZ+ujB6fd1E9YGHXv+QfQGaCMDxd30h8KdbY/+I77WIZkunp46OMagRRaOxF9Gt9gsZZQA9E2F3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW4ImKlgKpP1u+HuMBzSQHDWem/YyOTu4wPPjfhBaqU=;
 b=sJ4tueQAfehkfWlX04Z7zg8fOEx5VltFLb+vqOG4I3wPF+j1OdBnf75jz6XyguJtMRtliaqUdaAMfIcm4oFFLJb6BSj7H+ks6HkqayAFdJ85jwkRQvNbmRMtvvmvLBgLzQevzgwuMPbVSSXO4UE/ne168NspLUOxojC93IZy7U4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:31:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:31:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Homura Akemi
	<a1134123566@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej
 Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Thread-Topic: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Thread-Index: AQHbS2QFjUURmKlzgkWNYg6lxVUSiA==
Date: Wed, 11 Dec 2024 00:31:30 +0000
Message-ID: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: 5ce6f794-fa7d-427d-71d4-08dd197b283f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rLo8YMIwQOdPAQFDj4P9F09UgIQGwwtsOvRgh6/WokNP/xQOE8kQgOAH7N?=
 =?iso-8859-1?Q?FGA8xIqrwJU3WvbLsmMO6KrTpr9Ki7updAlf0crsAYo1m0zXL3kBIUTlY9?=
 =?iso-8859-1?Q?XyiUnULV6ZMpmZuNEDfkOrenzyjpUiJyanPTc1AM7WdeW1msB06gp+OZSh?=
 =?iso-8859-1?Q?yLWNiYcHWdwgB1iwGf7C4tljrlXFMRoYBHuDpvnYTnJTmDB82JMpcT35o2?=
 =?iso-8859-1?Q?BluVHKAvoSS2QXfrsPNr473Bcxibe/9w9TyWP2/GP7V2xS+pB6A7v2Ch3V?=
 =?iso-8859-1?Q?FfFsXgGZCVPDT4enIA/C2upXPGFpu8B2DUdcJD9QUwB3rDW+cJsAApDf4d?=
 =?iso-8859-1?Q?X1QUOayudJVBNMklk05ZuuD9rFH3ABQV62MwiJ+hICZujaZyeKqp/Em0eg?=
 =?iso-8859-1?Q?37+bpHIt4SMsdam2PJnXpjwrS+v4O2h1VYCkT8R4etlfTU1Aqbb/UVw2u/?=
 =?iso-8859-1?Q?ulkFZxuAXvSxNwTaYANqgx+gsmUeMJl8dA63CPTmR9bigjIRtzs4CHlxYK?=
 =?iso-8859-1?Q?0kE8u1cNFzyHtRXPv1jxgJteczJNCgcaTD5VYdhDL00m+jiDYLcfUW4wzJ?=
 =?iso-8859-1?Q?YoDah0VccPZvT8eMwLOppLydp0QK0GplyL9wUkYEF1SDjxpPndYUnMoSNI?=
 =?iso-8859-1?Q?cTYvzf06obNlhnywQMLDe1KMk7EuD41r9SwUzuZMTgaa3o+zkaWqH+U3CT?=
 =?iso-8859-1?Q?2MTWKlqspToiBnEs5XxWyMRwVOLIOHFSfuEec6WoGF0TgVr5QXEE2wLZfa?=
 =?iso-8859-1?Q?xCAxQC+UhcHwPnyfhy0ziJ64vQph5hJP1dJz00bBTZIZeae1JqTQr87WsP?=
 =?iso-8859-1?Q?vzGDjwJB8JkbmnzWu16dF2ekUAbbywjhXFXx+mo2AFZtG+9dXpc6rssNZ0?=
 =?iso-8859-1?Q?eSBGlEadLDcQGlDzfKWtSfmSFb+pWlsJGn4f0sStdIZWPAO/PYvBBpMscI?=
 =?iso-8859-1?Q?v9h+JruMJbR3ov+irijaftEPiB7SVvnVV72hhbeWa0+aPDR7JPCmSicyP2?=
 =?iso-8859-1?Q?Ab4q3sD6Q+u747XGwLoOZgz+0eY1DKNqIsiRDG1Y3phEHpD3CC2Z0b5+YM?=
 =?iso-8859-1?Q?+wFhLpYUeogrIZd+MlBu0mGuv0raUmh0uuSuUwmYdVfG75x+ENfk+z4TKA?=
 =?iso-8859-1?Q?MwxEvSUp4tlSnhdhH6UCgECT9OTQ7DcPaMpWi16P9n+KpWAaO2ywxon5E/?=
 =?iso-8859-1?Q?1rYCybmHIZ7masQkiDZWaanANGI4Cu3bH8pLhHwbvhYf+sglk3heewv3lc?=
 =?iso-8859-1?Q?yFCT18694txoBWjmFC2PGlLNO7Y2XR7fy6PRNB/pUj/Mva9Vj6LfADcrTq?=
 =?iso-8859-1?Q?/8jwsEs1gX4vrhexYjMeTEO0WtfTjItyUqL3DLwPbb6NA+0TOVR+2Apc8H?=
 =?iso-8859-1?Q?EHepVGcWOO6/DaOOOQhaNJ3ruyTYdC8OSB2oGAEDVsHMtrgAegYvu4sz8s?=
 =?iso-8859-1?Q?Q7wtHoP+r5i8csshg+7N5blNDkXgdLNR+M6sJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cyHT+L0OcqbalmtmXmM5bNKqwZXD9pnptTIOXiFNIMOQlWool5tAgnd7ju?=
 =?iso-8859-1?Q?5mUdiGv/plfEoGHb1AJ0gMFNkgKqhjQt8cuzU+xKFooPZHKi9gF/mZl14b?=
 =?iso-8859-1?Q?mijCtOf1rZi6/C7NgPN97qnO74ktJ8d8GiiBgr0BbZSDvdYtbwMsVngDxY?=
 =?iso-8859-1?Q?qIH4mB156sQukwOKsZDsgakOFJHn5f2DL7xXgEyImxa2mR0TRFtOL71gtg?=
 =?iso-8859-1?Q?VUDdcUKPrvCxoxQ3rDUKUPA75VYVx5o9n2OFZOMKS2Hw7jMvtWn7oF5lkK?=
 =?iso-8859-1?Q?oPuehS96bap7tKgablln08HLPmOwp8uQLDFNx6QiySmCHPDeoRoPwT+QD8?=
 =?iso-8859-1?Q?TdubEMUE4WPWXVR90UjQ5x5YNly8idVgqoIhq5kFv8AXc76JEH5m7FdAP0?=
 =?iso-8859-1?Q?iDWxrWSoaeafoXuvu3Dcp1gNxOOmt7U8vri/kTYc9tVFGC2y5MKSXN9hkC?=
 =?iso-8859-1?Q?lXmFSGwswKMGE8/fAfXIkb0QExSoWP4dEMRfD7hk61l6NSvy3qrjNWO66w?=
 =?iso-8859-1?Q?hcyUoocgbGCgYBjNung/f7uCt5dUVjQ4e1zg9+G7SSVFszFIqJi912j1C+?=
 =?iso-8859-1?Q?gAdtLJWe53F0zcjiwMUemHiERd4Lubluey1TRS49G9XzwVOs3FHDdFQT21?=
 =?iso-8859-1?Q?8+qYXibELp3tCS3NJGELg7Lil3i9W9HNutmI3tI9Sb2T1Fqjf0P0D3IYGj?=
 =?iso-8859-1?Q?rBQJPZfkKPtf86tUTqAjhKXjQGT+XBo9zQNT3g75YoRVMwP9nuTlN9Atvu?=
 =?iso-8859-1?Q?ofuDWhR+sxg85BX3xsAm7Q3QQd/s1Iln6RV1miUsayWqGPqCazmKclBdCu?=
 =?iso-8859-1?Q?8b/toNjfB9IxtCaaNHeEeP+doEdp/VyJel8LBzOeysvdbb7huZXotVtlku?=
 =?iso-8859-1?Q?hQetOMJLLSXOjT1flcDkFAw4v+zBoldC7XY/6sITFLbnf7v1/kjfAs7OEY?=
 =?iso-8859-1?Q?z4iqNckRr3SSmVC6VUreoI/rXs+NahSWBUuwL6DUMHFxpu3DZkJ6Ojb7MN?=
 =?iso-8859-1?Q?NwgWACsuHtWTvyhsBJk79w9BCK3cVQ11va5fBa3nVl3S3JSBRxwa9i2vA9?=
 =?iso-8859-1?Q?rSPJV7pcy33dUgtQPeSdVuC8EIDejJ1vpML+foJZPPF9ayo0y8dGuvp8VT?=
 =?iso-8859-1?Q?G4amkeAIp1r9xJPHr3nJ94l2rWd1v5aGQZmPcbo/MvnyG9LMtxDpGDeSKK?=
 =?iso-8859-1?Q?o0itVfBI2kOg6I8ZAYtww+teze7a9KCkATEwb+bk6tQ2MO0KOPlSYIEwLO?=
 =?iso-8859-1?Q?VXYgB0rfvjWu5Fit4jjxJrzwnW1TpFVlVPxnQ/LYBoQkWnEqP4WApxlk2V?=
 =?iso-8859-1?Q?LfTsObm6HiMELRWegES46RPPe4SXjtgvhh5Ez4jnmpe/H00lszmk1zvW2+?=
 =?iso-8859-1?Q?lUcrfYFDcc3RQzE1DuTrVVF7Rb1cEDfbMW8ha9RCTGNkbkJl91lLExAnp2?=
 =?iso-8859-1?Q?CCdx9T1PrX2y34c3P0xINYeOwow51bYW8UT1jTcusHngNGNB9dX8p4lOf/?=
 =?iso-8859-1?Q?Ug4hgHwHcllEVdCabMzZwYhhIcrHmpUwkyd2CfJV8kihdJj5viC8q4SYvQ?=
 =?iso-8859-1?Q?2uP6Ep1LX9+eaFJbPQhhjuXkNDfAY41HAM8BKtKsSCgXsRtHrQrPOQcyhq?=
 =?iso-8859-1?Q?aYl5LKiFISfgmYU/IJz529z5wE8RF8c/Pj?=
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
	bMdBKuoOQ7SciSEhIyOMT4lmeLzdffTmn2GnkoSDpHyLDlfMn7eh7ecgGvdH4Ov61C4flMuFtk1TfJKWIRin7s75TQ7ueYM3+ggrIT9UkN9sVl+6XmlIvN0Kgmf4klwxyH8crd4pmyfT5ALfYWReBUPmhFdCJUoY0CmRaxBgbmaRAClzLRPhZg0bcxH3YwA7m/mjkbfQI+KCCbRjNt4y/mF6WpUdbwfLsQOY5gQXc/VA+yWAOdaR4WVvX18tBNFtQH5240uWz5I8m++YXzeFMHvaNghR+iqLJXcCLfj/8zRASkFmmivXP7LA3DT47MVwdfbwieL48QQPHiynGgBO6iteAAEErCgTwyfEXSFGNh8p37NAwbmGHQYdYGYsVIThVD6yUWztoYh0X/xuP7Y58+2l8mfbwU+aZ1dTsKuiZzv3vAh7nXWIzh/l8jOrWXgDHPi205gPCdsZS1gKWPsY8e2YsOWSG33Abb/Lnyff1oqmv1OgAAb2Ta9e5OYSCTvDOjZF4EZH0r5HofekZVA4Wi8yGL13w8wgAYVX5udJWVQi7eOxYcie7vUiq7Y8xzDQmqFx66M9yR2vtkWgFjhDnHGJGhonQNISVeCYbIn394rYqSNV8YciFpYtdMeoB/SEailuAysWjlqX65rqfO/quw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce6f794-fa7d-427d-71d4-08dd197b283f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:31:30.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHg/cFLWj14MGWyUT1LlL2+jS69vO+IjYFCMu0fbrniwJq8yBFP57+nL1a9Jqu+S1vx2VROhC7XeKYVCGrmHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Authority-Analysis: v=2.4 cv=Z9YWHGRA c=1 sm=1 tr=0 ts=6758dd6a cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=V0tzN9xz4lunQFGz6f8A:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: bY5KtUyrt0jPtdrj0HOvSOH8gkNhSRWG
X-Proofpoint-GUID: bY5KtUyrt0jPtdrj0HOvSOH8gkNhSRWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

Apologies for the delay; after two years and multiple requests to resume th=
is
series, I squeezed some time to push an update. This series applies on top =
of
Greg's usb-testing branch.

If possible, please help test this series and get this merged as my resourc=
es
are nil for this work.

Example Bringup Steps
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
To test UASP, here's an example perl script snippet to bring it up.

Note: the script was cut down and quickly rewritten, so sorry if I make
mistakes.

    my $MY_UAS_VID =3D xxxx;
    my $MY_UAS_PID =3D yyyy;
    my $SERIAL =3D "1234";
    my $VENDOR =3D "VENDOR";
    my $MY_VER =3D "VER";

    my $vendor_id =3D "my_vid";
    my $product_id =3D "my_pid";
    my $revision =3D "my_rev";

    # Must update:
    my $backing_storage =3D "/tmp/some_file";
    my $backing_storage_size =3D 1024*1024*16;
    my $use_ramdisk =3D 0;

    my $g =3D "/sys/kernel/config/usb_gadget/g1";

    system("modprobe libcomposite");
    system("modprobe usb_f_tcm");
    system("mkdir -p $g");
    system("mkdir -p $g/configs/c.1");
    system("mkdir -p $g/functions/tcm.0");
    system("mkdir -p $g/strings/0x409");
    system("mkdir -p $g/configs/c.1/strings/0x409");

    my $tp =3D "/sys/kernel/config/target/usb_gadget/naa.0/tpgt_1";

    my $tf;
    my $ctrl;

    if ($use_ramdisk) {
        $tf =3D "/sys/kernel/config/target/core/rd_mcp_0/ramdisk";
        $ctrl =3D 'rd_pages=3D524288';
    } else {
        $tf =3D "/sys/kernel/config/target/core/fileio_0/fileio";
        $ctrl =3D 'fd_dev_name=3D$backing_storage,fd_dev_size=3D$backing_st=
orage_size,fd_async_io=3D1';
    }

    system("mkdir -p /etc/target");

    system("mkdir -p $tp");
    system("mkdir -p $tf");
    system("mkdir -p $tp/lun/lun_0");

    system("echo naa.0         > $tp/nexus");
    system("echo $ctrl         > $tf/control");
    system("echo 1             > $tf/attrib/emulate_ua_intlck_ctrl");
    system("echo 123           > $tf/wwn/vpd_unit_serial");
    system("echo $vendor_id    > $tf/wwn/vendor_id");
    system("echo $product_id   > $tf/wwn/product_id");
    system("echo $revision     > $tf/wwn/revision");
    system("echo 1             > $tf/enable");

    system("ln -s $tf $tp/lun/lun_0/virtual_scsi_port");
    system("echo 1             > $tp/enable");

    system("echo $MY_UAS_PID   > $g/idProduct");

    system("ln -s $g/functions/tcm.0 $g/configs/c.1");

    system("echo $MY_UAS_VID   > $g/idVendor");
    system("echo $SERIAL       > $g/strings/0x409/serialnumber");
    system("echo $VENDOR       > $g/strings/0x409/manufacturer");
    system("echo \"$MY_VER\"   > $g/strings/0x409/product");
    system("echo \"Conf 1\"    > $g/configs/c.1/strings/0x409/configuration=
");
    system("echo super-speed-plus > $g/max_speed");

    # Make sure the UDC is available
    system("echo $my_udc       > $g/UDC");


Target Subsystem Fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have eliminated unnecessary changes related to the Target subsystem and
reworked f_tcm to minimize the modifications required in the Target subsyst=
em.
There are unimplemented Task Management Requests in the Target subsystem, b=
ut
the basic flow should still work.

Regardless, you should still need to apply at least these 2 fixes:

1) Fix Data Corruption
----------------------

Properly increment the "len" base on the command requested length instead o=
f
the SG entry length.

If you're using File backend, then you need to fix target_core_file. If you=
're
using other backend such as Ramdisk, then you need a similar fix there.

---
 drivers/target/target_core_file.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core=
_file.c
index 2d78ef74633c..d9fc048c1734 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -283,7 +283,12 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterli=
st *sgl, u32 sgl_nents,
 	for_each_sg(sgl, sg, sgl_nents, i) {
 		bvec_set_page(&aio_cmd->bvecs[i], sg_page(sg), sg->length,
 			      sg->offset);
-		len +=3D sg->length;
+		if (len + sg->length >=3D cmd->data_length) {
+			len =3D cmd->data_length;
+			break;
+		} else {
+			len +=3D sg->length;
+		}
 	}
=20
 	iov_iter_bvec(&iter, is_write, aio_cmd->bvecs, sgl_nents, len);
@@ -328,7 +333,12 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *f=
d,
=20
 	for_each_sg(sgl, sg, sgl_nents, i) {
 		bvec_set_page(&bvec[i], sg_page(sg), sg->length, sg->offset);
-		len +=3D sg->length;
+		if (len + sg->length >=3D data_length) {
+			len =3D data_length;
+			break;
+		} else {
+			len +=3D sg->length;
+		}
 	}
=20
 	iov_iter_bvec(&iter, is_write, bvec, sgl_nents, len);
--=20


2) Fix Sense Data Length
------------------------

The transport_get_sense_buffer() and transport_copy_sense_to_cmd() take
sense data length to be the allocated sense buffer length
TRANSPORT_SENSE_BUFFER. However, the sense data length is depending on
the sense data description. Check the sense data to set the proper
cmd->scsi_sense_length.

See SPC4-r37 section 4.5.2.1.
---
 drivers/target/target_core_transport.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target=
_core_transport.c
index 8d8f4ad4f59e..da75d6873ab5 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -804,8 +804,6 @@ static unsigned char *transport_get_sense_buffer(struct=
 se_cmd *cmd)
 	if (cmd->se_cmd_flags & SCF_SENT_CHECK_CONDITION)
 		return NULL;
=20
-	cmd->scsi_sense_length =3D TRANSPORT_SENSE_BUFFER;
-
 	pr_debug("HBA_[%u]_PLUG[%s]: Requesting sense for SAM STATUS: 0x%02x\n",
 		dev->se_hba->hba_id, dev->transport->name, cmd->scsi_status);
 	return cmd->sense_buffer;
@@ -824,7 +822,13 @@ void transport_copy_sense_to_cmd(struct se_cmd *cmd, u=
nsigned char *sense)
 	}
=20
 	cmd->se_cmd_flags |=3D SCF_TRANSPORT_TASK_SENSE;
+
+	/* Sense data length =3D min sense data + additional sense data length */
+	cmd->scsi_sense_length =3D min_t(u16, cmd_sense_buf[7] + 8,
+				       TRANSPORT_SENSE_BUFFER);
+
 	memcpy(cmd_sense_buf, sense, cmd->scsi_sense_length);
+
 	spin_unlock_irqrestore(&cmd->t_state_lock, flags);
 }
 EXPORT_SYMBOL(transport_copy_sense_to_cmd);
@@ -3521,12 +3525,19 @@ static void translate_sense_reason(struct se_cmd *c=
md, sense_reason_t reason)
=20
 	cmd->se_cmd_flags |=3D SCF_EMULATED_TASK_SENSE;
 	cmd->scsi_status =3D SAM_STAT_CHECK_CONDITION;
-	cmd->scsi_sense_length  =3D TRANSPORT_SENSE_BUFFER;
+
 	scsi_build_sense_buffer(desc_format, buffer, key, asc, ascq);
 	if (sd->add_sense_info)
 		WARN_ON_ONCE(scsi_set_sense_information(buffer,
-							cmd->scsi_sense_length,
+							TRANSPORT_SENSE_BUFFER,
 							cmd->sense_info) < 0);
+	/*
+	 * CHECK CONDITION returns sense data, and sense data is minimum 8
+	 * bytes long plus additional Sense Data Length.
+	 * See SPC4-r37 section 4.5.2.1.
+	 */
+	cmd->scsi_sense_length =3D min_t(u16, buffer[7] + 8,
+				       TRANSPORT_SENSE_BUFFER);
 }
=20
 int
--=20


Changes in v3:
 - v2: https://lore.kernel.org/linux-usb/cover.1658192351.git.Thinh.Nguyen@=
synopsys.com/
 - Moved patches around so fixes patches go first
 - Use hashtable to map tag to uas stream
 - Move target_execute_cmd() out of interrupt context
 - Various cleanup
 - Additional fixes over the 2 years


Thinh Nguyen (28):
  usb: gadget: f_tcm: Don't free command immediately
  usb: gadget: f_tcm: Translate error to sense
  usb: gadget: f_tcm: Decrement command ref count on cleanup
  usb: gadget: f_tcm: Fix Get/SetInterface return value
  usb: gadget: f_tcm: ep_autoconfig with fullspeed endpoint
  usb: gadget: f_tcm: Don't prepare BOT write request twice
  usb: gadget: f_tcm: Increase stream count
  usb: gadget: f_tcm: Increase bMaxBurst
  usb: gadget: f_tcm: Limit number of sessions
  usb: gadget: f_tcm: Get stream by sbitmap number
  usb: gadget: f_tcm: Don't set static stream_id
  usb: gadget: f_tcm: Allocate matching number of commands to streams
  usb: gadget: f_tcm: Handle multiple commands in parallel
  usb: gadget: f_tcm: Use extra number of commands
  usb: gadget: f_tcm: Return ATA cmd direction
  usb: gadget: f_tcm: Execute command on write completion
  usb: gadget: f_tcm: Minor cleanup redundant code
  usb: gadget: f_tcm: Handle abort command
  usb: gadget: f_tcm: Cleanup requests on ep disable
  usb: gadget: f_tcm: Stop proceeding further on -ESHUTDOWN
  usb: gadget: f_tcm: Save CPU ID per command
  usb: gadget: f_tcm: Send sense on cancelled transfer
  usb: gadget: f_tcm: Handle TASK_MANAGEMENT commands
  usb: gadget: f_tcm: Check overlapped command
  usb: gadget: f_tcm: Stall on invalid CBW
  usb: gadget: f_tcm: Requeue command request on error
  usb: gadget: f_tcm: Track BOT command kref
  usb: gadget: f_tcm: Refactor goto check_condition

 drivers/usb/gadget/function/f_tcm.c | 711 ++++++++++++++++++++--------
 drivers/usb/gadget/function/tcm.h   |  28 +-
 2 files changed, 547 insertions(+), 192 deletions(-)


base-commit: d8d936c51388442f769a81e512b505dcf87c6a51
--=20
2.28.0

