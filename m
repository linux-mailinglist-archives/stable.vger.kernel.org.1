Return-Path: <stable+bounces-135071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE5A96401
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6818B18863B6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D01F131A;
	Tue, 22 Apr 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TV9zX1Nl";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f0lJU4cA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UzMN9gxG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4921F130A;
	Tue, 22 Apr 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313433; cv=fail; b=o6XlFd/4JAsbGCZNW6bJUguZjEFNu1xfK0OMOIclbdySwMCDBxh5Khn0SAg0zOO0xQ9AAon5XEAhM6bTnPhTmtHld0ccXn6wqVukFaxGIxwRimt26u6wqxPTEdusUmgL3tFeNmVlj9E76kHL+MeWa1aPyuZvG7X7/eo2GTIVcrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313433; c=relaxed/simple;
	bh=5hWiUnhATbQkTODTeFjvFW0Fz0B6KLw5d/XXxULXjRo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ntr0gOsAAWcVg7+dLz1lKg3IkL1tMLD+2OUvpRV08cWi7AYRGavIWxorF82b6ZuZpX4+VVxlOJRmm4CFs6rRg9l0EVx1pGVeCwWswCRqge5h5uiHMyemG2rToCYk+39Ju9nOA1YwtsaBJDkJwvPcjmCvnU+Uvv2ab/mOsRwOm2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TV9zX1Nl; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=f0lJU4cA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UzMN9gxG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7LkLA029950;
	Tue, 22 Apr 2025 02:16:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=7M3uDR9r86dhgBbyJlK
	5WpqwB0KwcinO6CX+iI4gLO0=; b=TV9zX1Nll4wr+FpPo0dukF/AgXyB656PBwt
	PFT67UYrr0cXmk8BYm5nAUjaKc/x72wn1LW1hZN461c0gIgyFQ99Naj9oDNKLjX2
	CpJovEIdT9ZjD7OocVBy1FUbd3ilcFjMbZ9SDl60amKMj05aZOSnyv3TegoaLogR
	LKmTfDZgb7sKAP/AeBFhoHEH5iir4GzNkxsEuAQzkGfFO8Job1QB919zR2s5eLCo
	Vdwj+0APRDPSl9KIJ2uoDOff2utvBXX5USpZFIOuj6rJnwu0YgNrVmXMO7ytYWnV
	VsNDoTLK25j52yLv8RFykrYJc1RJwxE7x6P+cQYQ8TLIhzhfShQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 464b37j4yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1745313417; bh=5hWiUnhATbQkTODTeFjvFW0Fz0B6KLw5d/XXxULXjRo=;
	h=From:To:CC:Subject:Date:From;
	b=f0lJU4cA7u6Mo7xdffqZxVYY8WwTPtwPoONa5SXfFQ5LldWZ7gjK3t46W4Z/lUd2S
	 SXvv9QftN7J0NLAuzB3hUwovO9ghbZRhGW15812y9NcAN9X3zbelAxrfv7uxgEfn2+
	 aWHD4gK2BM6rbC1yeAeahs3Z5dlAaVivO0H7Ns9cnKs1h5JCPIRM8nQ3yg1q7s6KV1
	 zfsNfEeh8ezV5UgNQ0jNOodGPdoMf0xXPfQqe16rerAzT4qsOB067GWqRSonDIeWTG
	 k9PZItbCm1HK3l+Cxxr0sZj2nW2QHLm3+kiCmNr7/Q1ZNi46l3ps4PL3Gw0N+oUqkH
	 6IPCZORbHVWxg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 158DB4013B;
	Tue, 22 Apr 2025 09:16:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B275FA00A0;
	Tue, 22 Apr 2025 09:16:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UzMN9gxG;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6122404D0;
	Tue, 22 Apr 2025 09:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtM22pyFXt4cEe4cp6sEw3CyzOf7sbM633cs9jxumAa3Sooc5rFmid2IpisOH8l6Tmg2JGiV4JtKVMyNHX5+q6oC3KkWESkm7iHDthFIF/VbSmbca6FwFpzhTO6qwzzmJDxo6Q02DCOqy0SB4LeKZu59tlOv1c+WoHaETmSBXHv2ih83Gh4Gr9pgP3pYB1gnINAkwC01ki1P+5YddeTo4BEFwPt0l83zFKKUjV5t41TyACqiavLljatdgzlxerTIAvBiAdaCnro+k0vKhzqbppbhRtHRCWDDJe240E7jCegNM2mGyY8rt6McVrNkTXXfDUeAJ0v+X0FzZ5+zaDrq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M3uDR9r86dhgBbyJlK5WpqwB0KwcinO6CX+iI4gLO0=;
 b=i2i2szE+PlEorWEVJrq/sD2UyEkAAmQ0rOtEbvKVMEHaV0C0Nmcl6DBUz5FxZJh3xFXzWTfeU41uAJ2nMOQv0UdeHI01d9swVTauzVKmnM/3SeTaYiGkXyMs5yZiOqPAapTdHLATTfh99HDlBDls2fbFZET4r4hoDVa+S6Dw4A7ia2+FUz1qSc5gkJw9O1rVEVfQX9KgtXuvuDvXdZBZuXsLYV7Or8Y9jT/bRW8NSKYDxndhLCkwYhnbdLGEa7xV8qVpHNRl5+w1+fRTSI9wDvmdAWlscmg/nLO5ChL4ZRLOTOLIq06TPnwmGNCpU7BS+U3IdK3Ytqfagj/sG3ZQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M3uDR9r86dhgBbyJlK5WpqwB0KwcinO6CX+iI4gLO0=;
 b=UzMN9gxGZh7dRcxI3Y9cvnzZRbCYYV/C/S+bk5ATqp76WsTnoFHU68/iGmyy549coNuXu1kZJYSBilXDPQD7bk/kggUe7dvutvCcksdRgcJg54trANUGEG0OevLqwMxrKyqxLX9UW+VPOokmdaAk3F5/z7NCoPDx2hkx3HLA7Zs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 09:16:53 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 09:16:52 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY
Thread-Topic: [PATCH v2] usb: dwc2: gadget: Fix enter to hibernation for UTMI+
 PHY
Thread-Index: AQHbs2dJdWecVjhD90moy8hZebyDyA==
Date: Tue, 22 Apr 2025 09:16:52 +0000
Message-ID:
 <8bacf7428d29d7fc2e5a94e5931f12d7df60c732.1745312619.git.Minas.Harutyunyan@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7607:EE_
x-ms-office365-filtering-correlation-id: a94247b9-95d2-48a6-a401-08dd817e6b9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RYrv+xG+gfdVjsVIEweOaAkWKBZAFOZOEnCx0LDl65pXKasEsjOgMVZ0Gz?=
 =?iso-8859-1?Q?eykZVckgCRT0mePpvz/YSY+wfMck/tByfxy0gD+r246PsB6tXdNdVGt4Np?=
 =?iso-8859-1?Q?ul60MJ1JhBec0iKfmvWq/bSm+Bn912fj0MpDhzc3DwqjldP+rGFJzQbHTh?=
 =?iso-8859-1?Q?s3BqhyyPK8RRf1LVxVogAgqlbPjPVEiERwDauLrGH75dVcWZ/MlqLgWvXN?=
 =?iso-8859-1?Q?nB81im+9HLftEbDM0eAlJimabQkNPM0I2giflr8Oppa9b5MaMVGBBO/x12?=
 =?iso-8859-1?Q?lYWTypfwSL0wa+SvQ28j3kcqOF4PDOxp245ITtb4p4V4m/a0O3mZb2YYOB?=
 =?iso-8859-1?Q?rTgo5bcBDGhCZjzKP7mF7ABAamIi2kIlo4g0JbPYHGpVnBVA17+qh6PYhs?=
 =?iso-8859-1?Q?XO8qejgzzsfDcgk6kRv4aQv/qtQP2PPHYMU5ffclJ6Idmt5h2q91NPd7pL?=
 =?iso-8859-1?Q?mqq+fN3FnSxNtk08DMCQ181hW1wSSOWcfoFZRDnMQycry0OD2lXZagwi8y?=
 =?iso-8859-1?Q?Fcs6HBt9DOJeyTCe75m9d3500xDa64Cet8r/M9XOf7jvxyYywpvvjinkHT?=
 =?iso-8859-1?Q?uYqQuN+p6Tp0Jk+gfLPGr6/mbqQ5+VLZAyg0rh0mllPELAu5LuGQMHDCcy?=
 =?iso-8859-1?Q?ePaJKx/y27/aNeadadCjbAWSxL7W+cpKoxAUoKIsvQrRfWZTK15A1nFV7x?=
 =?iso-8859-1?Q?Pn98VLfopIi0JRJSvDlT61eXbgQuGy3yIYSQJ3rFZ+Y7BBZz7eRjT84+rh?=
 =?iso-8859-1?Q?nuOuoXugiq8aOKQhAcK0CNDTNecNj1TjrG30QHtaM5tRYGgjd1K9IJDkL1?=
 =?iso-8859-1?Q?jekn6O3veyTDTlKCsqVzojL5oZSY6CQFom4AZHQWBmi4sNJb1ZnOhwp96l?=
 =?iso-8859-1?Q?B+nuttpeIVn7wgyof2D5rjsX+LnWFEqAF1Ox5Bg+XaptQTqQVUb+Er7zod?=
 =?iso-8859-1?Q?ZlISaqyCPCy/oHofZkKhTIlrWq6hL9X5Q3zWu/m+OavZ70/+vZdWo0GEIa?=
 =?iso-8859-1?Q?oHBo+6aUo1ESshAIXvazCrC6U6F1HJj7mL0MBla+ifAyjFTVzqhNrkL2Q3?=
 =?iso-8859-1?Q?2pS/zFV4GTlnIcJNmytlTR7gX42f4DW1bmJ0Repvcg+6aCUhMs1cxMDMYA?=
 =?iso-8859-1?Q?tk5RszGJ6CHaGTlc8viNauC+J7WHq5IEMzX2ot4xgzf6IDO7lygjjon3UB?=
 =?iso-8859-1?Q?05QbFsuo0bsvOpC10SCtpT3CPZoVfmild/Y53UK82UHJMyu+mPnvnKzJUz?=
 =?iso-8859-1?Q?FkKtDSvi81XYagBjlcIFL62U/p5x1kSq8tVeXwTpzcs8BzpjcUFVVe+Bwp?=
 =?iso-8859-1?Q?ZG41vkYs7Sa4nFkXZC/1JvkgDfPNeiwmlAmpOvpKP6a2ikcmxzFzY73KPi?=
 =?iso-8859-1?Q?QfNVH9CoLOzkBIUPE1/PRbAgQFtpWgOMS84Uj169/R6954KaFDWqzqUzcc?=
 =?iso-8859-1?Q?1HX+Q3pg6B0ejgJfYlnWwhmLCVRa/VLiz0sU1C9yNgZTrU6eL2OvtljgfK?=
 =?iso-8859-1?Q?1+oyDg+g0a4Cq0TQ9RBRLg/lrFdxSRCjKSqhx5i11CDQGapBas74+H8Cv+?=
 =?iso-8859-1?Q?dBLbJKI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kyQwVbfODFLLQ4hfNujqvbQ8RgzvRTd1TaOJYgXzHugqUGQCKTqlNM/z9i?=
 =?iso-8859-1?Q?CuilR2jEAPoxCD8PHS2KZhIfiskZxjwTUOig4CgKOpTn3X12oqqr+yBUWS?=
 =?iso-8859-1?Q?Fyi8ooJ8H0TYfXQYJIkuL+fNUhAAUVTlyRTXbqbubUbFzW/oCqQP+xC/F/?=
 =?iso-8859-1?Q?lt5CR+q5IWqsAtlhi72GTzi0DVHOrhJAmtYKTfHMbsjKCVuAuuAQgumuaB?=
 =?iso-8859-1?Q?GyWlfUe4XCzXJI/lK2UjcCWS0ACcFHLWvjV3fi9jKc7/1AfJ1Qkdna3VQ8?=
 =?iso-8859-1?Q?xc9ghcsjnC+/X2VhMybMk/ZlJrZCvgwkYaaXIeLWcNl1tQ/rY3Ncq3Lk13?=
 =?iso-8859-1?Q?RhvErvfmzeUb7jsBoSihVghAXxQeOIgB9iL/YNks34gzMmeeSijNtjIe8w?=
 =?iso-8859-1?Q?bZjP2irVV90uL/qe8JAe5BjG3sn+aV05sn1PaJVLmb/dF9fxFvjIcqVWpP?=
 =?iso-8859-1?Q?LXeYPSNzP4Tt42P+KFQo13mmJ/M4Mdpyo78LF4ZY9wwu/GVtzcSXV4HxSn?=
 =?iso-8859-1?Q?2ghS1QHiOg3tWzi+YlCLPZjwMFQQPQXSUvg9oeq5m2gALkUooaxQZYLSrH?=
 =?iso-8859-1?Q?xlyFx1zy3zpfySpfSET54iHFOYnkAVWgFso5ttbpcnPLcyycpPFYkMMBe/?=
 =?iso-8859-1?Q?XSrlG/WndBnztA677nmVOm1kUbVyleQUsq4qlnZEqb4ao+VrOt2cSLtLKW?=
 =?iso-8859-1?Q?eXnCJtT+eXKut7JJHW0qfgN00gZsdDPS1obBL4hgTi05ZRzQcATDkzwWlg?=
 =?iso-8859-1?Q?yF7e791MmKq8IhjugwBSEtqZqZY1D07HMcd2SfvKhz6/QMBtkU87/4gMDR?=
 =?iso-8859-1?Q?7sezKa3zd0Eru/OUAhP3wF3EQz+ofwl5m4afxrtbVuu/qrvas4JYn/YH/P?=
 =?iso-8859-1?Q?qybRjKAeYiu1MYBC5A2caWe2s/p07oTGzRDacOc23gCDXl5cH6JMBxz17j?=
 =?iso-8859-1?Q?vh03xG+frWI0EcgZMlIeY0pi5HjlwavzKpEkxo+w98q6bEDIUt8Cq1A3Rq?=
 =?iso-8859-1?Q?SI/ZS4Z8FXj9/43YZqPFjtvqxpNmEk/lHGhU3HW+RKKP4msTb/ta5G+VrO?=
 =?iso-8859-1?Q?bZ1iduXQrJLDhSyZ53s4EreCkROXjeHqa0oPav6yf4a5papp4nB3VmzYJV?=
 =?iso-8859-1?Q?bxtIyOHZ6BNfosVPWYGjiFSdzIZqoEk60dLFqlelkYqE4pvykleXMkVcpP?=
 =?iso-8859-1?Q?jFlBPkroYAsufPSVptPTb2vTygBeqBVF1H/2o9V5PIS02cbCCaipRvoUHM?=
 =?iso-8859-1?Q?qQOVvtrkCvBH+9j/PWWl7bjEYVqRevwoocndlQ6+rnlDBHm6TL8DU1F46s?=
 =?iso-8859-1?Q?A1U9mxe3JW37KRm2Qnzrcv1pXIRaGP7u6yHbAc9vcIS3RZAktQNyvMCoCp?=
 =?iso-8859-1?Q?S1mN6vVlh0PokszBDaHF6+xQgxai7dOim4qUfsub58/RaClZ9SQs5FrCFL?=
 =?iso-8859-1?Q?F6VWupcB9y47sSOCfa809P8657dDTFOXe7vPyW0k/DyK95PITLTmDLduln?=
 =?iso-8859-1?Q?0cu/dxytZuGNkbYtkpkW9j4PegqXzdwiRW6O0vwU0+imNXaO8NCJOLZfRk?=
 =?iso-8859-1?Q?8n4qVoXsay8kS4xLnKetWL5NCKIWz/rEeMGrnHxjVK3xBVEjlJmFwyCwbJ?=
 =?iso-8859-1?Q?zxEdav2QqPHkPIB/g2uIN4rqP1rkBY8tYu?=
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
	5SCw1LRvPde1E41xUxVjDxd3Zim8Z+4FzAkukyEEtaUjx/strADaQfnMG+VnSWb2d2JvM0TYXs5kNNZZ4SAAZtxfYLHs+2WgG4VQHcTz/HzNR8/hJFpH/vsMBi41b+gKJgkYWbg/U71LIBfniXY8P9UcLX8cdCat5YujTi9kIEUPjHAAU9HwWDhmofojJ3Ft2XjUpfSkhrqlOCFK0erlnJ3VRrW2EIIFWdHwozC+3pTM8jKCe8vHflfjqEj6wvhpwN08F8Tr+YeHw8pvugQf0x2t+HnMw08VK0VAbdLuqXXNezQVNVyiXTMKlCJ3E27Eqka+2mn4SU88J/Uffo8wQ1A2WgwsmDozka1b+VG02izJoZWzFwTuxMdgAq2KRiwND71cD3LHZ1cR5MNsApUEBvmceF3ZDbi/clwimnMqHyCYsrLT2Ve3szrGwuI0oUIvaSDMBkLcq5fIoKWCPUYvGgsQYRjihBV+wQea/zjmv3+WjyyhFZPfP1db+uPzOS27vRN3yk1EexaDq8/b7BfmMBkijwTliM6Sxpc4qwPHKoheuFYr91GlpritQsc8Dqkn/HCujUaHEEdqjepvGUcXrf5+m2j9QWJvHGMp4tj8X9ulruNPAX0uGgXDs4JS5Jqt2EPyDJJzTE7zUEBK2RhHdQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94247b9-95d2-48a6-a401-08dd817e6b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 09:16:52.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs1juYbJ9X8+jld6uNJG70+Q80XI5bTfubaFMHwqWjDPL4pgsn2aZstahGYlhHlaqAx0Kp2grblj6CeZ4yPXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
X-Authority-Analysis: v=2.4 cv=KPJaDEFo c=1 sm=1 tr=0 ts=68075e89 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=1nkadCgX71emagpZ3AIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: Hl7WOnAnrRVPikhf8OLS9or_0XoUhyO_
X-Proofpoint-ORIG-GUID: Hl7WOnAnrRVPikhf8OLS9or_0XoUhyO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011
 mlxlogscore=747 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504220069

For UTMI+ PHY, according to programming guide, first should be set
PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
Remote Wakeup, then host notices disconnect instead.
For ULPI PHY, above mentioned bits must be set in reversed order:
STOPPCLK then PMUACTV.

Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
Cc: stable@vger.kernel.org
Reported-by: Tomasz Mon <tomasz.mon@nordicsemi.no>
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
Changes in v2:
 - Added Cc: stable@vger.kernel.org
---
 drivers/usb/dwc2/gadget.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e7bf9cc635be..be6b792e9a7d 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5345,20 +5345,33 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
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

base-commit: 12393996c1b28cd944465d2f55500ca84399a7f1
--
2.41.0

