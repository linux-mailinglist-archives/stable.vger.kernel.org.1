Return-Path: <stable+bounces-230032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEN6NanOwWnhWwQAu9opvQ
	(envelope-from <stable+bounces-230032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:37:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1742FF064
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C21730347B5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325F377EDE;
	Mon, 23 Mar 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="lTC3SjHy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1136DA09;
	Mon, 23 Mar 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308902; cv=fail; b=iFN+joHY4lMZtEtD2drR7AXhMifnKQng7GwIEIiYL8Ucfr9a4rFgjAx/NdjTRL/SUTyRuVQD1V+It3j0JsHLgj1osUUmRmLfrzqnEftcTGfrNV8pGrJPq69k/QeYU/aD/JLFAZiauPcFXd1A+0Fv3MYEm5AlxrZ2aQ1xHVEbIRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308902; c=relaxed/simple;
	bh=kFemb01h4Yp/YUXM1iHgSw8C1i1yIUjf5DcAgUIsRJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+pyipQ2lAx92gXH6bUaxA+4SK/qlDAyQUcuIG57r8BuoFmAqa4p98G0JP0NP92noLmIghhCDxJKJH7cOJ7RsDhGR261GEUMpMOCjxRCovaa0Fxyc0kQkWUWH2lhgseKIQuL22BIf6hlbJi6cIGV5B/ZdHbCKtQE68T8cwEc1qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=lTC3SjHy; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NKESWb2864994;
	Mon, 23 Mar 2026 23:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=wG
	y1eZM2v1xqB9SubDCd/+YhRreLQhBOCiGVwJ3Ou0U=; b=lTC3SjHynZ2s+iObBQ
	/ZhJKYPPlABt4dp2LdjDfDWA5J3H4rG/L+EDUjV68BrsvvLwHp8SlcWRWU/7AriH
	4mmIj5273EDvVBZq8tdn7ruYBHXPCrsaOzoVPIC89LkhLryPNbpvZCOJlArohLvK
	eFAJaxhqZ2qkcUNcCVPa4THcRSPnkxKbimKkN2ASpaW6QtIuSYJzK2sldI88vfZv
	Ym50M5y4rrpbW/8PePO9Fx9hbf4RH0gdSuDiII0ztXlFhgIMmQu197BE51UKk36l
	4tyGxJtobv6cxOcySyNSkLLWJel+//UtiCL6NjdJRXDlg5JV1ROgG0M12gl0JX3E
	w/Bw==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d34psqu49-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 23:34:46 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 72BDD80163D;
	Mon, 23 Mar 2026 23:34:45 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:33:48 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:33:47 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 11:33:47 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:33:47 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8pMgrPf7g7G1+8XEio+rSL46EPa3AzAbHodnDHOM5EIrOQ45Z88EMnLw0zow8vjOtpSABALA3Qgfd8+zBVW3zbmZ2hEPyJkLJfh86xG+nC5I7MXif7Cgwo2LzNBGoPd4MxxdM1Z90GTl9dS2pnGLbuOsdg6c1z3XhZLtHj8/xSSjblwu6dT+thpJ2TMqfO2TJ5uHBp6+kSIWdwF0v0Wl+1mgx1vVhsvqO0Vrd3a1dVTOPwsbEJUrt3v4RdrpeMUQIpEaaQIklSSbm6E3R0ZAptKa8Y/o6GcmaKSofDyECBqO0/2x1Jmz243PbdpBIam+7juHlLIup9tNCAxq1Y9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGy1eZM2v1xqB9SubDCd/+YhRreLQhBOCiGVwJ3Ou0U=;
 b=W3ISJ8J2LcR1z8dbq6MBeHekn95rFOOyHDmVCPhu84/233f66LryGXsXMI1BQdNwSXc/4Zr2GqvZ5lnq57JVeZl4v36WnA34xRBCUvwumzTLWcErKtpfTgAW5W46PP21nlTe4u0zyKh5AlsUmtmQOpdp444P+u53qIuHCSqAlWpqViHTdXGOoWFN21UwX1s2douli7Rmt4WP1HHufivKg/sZaz+DNEmsxcg5wNvU49hbM6f8ymHe1Z8xn37W7ol2e8NWwU569yYy85Ilf5Rp84E0s4SIhtutqCjDvDZ6xvZwAKP9l/+4L9/jay6UrmJ4yvhPV94jTVqpV1E7GAuI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CH3PR84MB3989.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 23:33:46 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 23:33:46 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "wenswang@yeah.net"
	<wenswang@yeah.net>,
        "chou.cosmo@gmail.com" <chou.cosmo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/5] hwmon: (pmbus) Fix return type truncation in MPS
 reg2data_linear11()
Thread-Topic: [PATCH v2 2/5] hwmon: (pmbus) Fix return type truncation in MPS
 reg2data_linear11()
Thread-Index: AQHcux1+4HUbx2nZzEqsqwhFDE7Seg==
Date: Mon, 23 Mar 2026 23:33:45 +0000
Message-ID: <20260323233244.201294-3-sanman.pradhan@hpe.com>
References: <20260323233244.201294-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323233244.201294-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CH3PR84MB3989:EE_
x-ms-office365-filtering-correlation-id: 3bc0fc57-5e95-4932-e1ec-08de8934a0a3
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: keV2SzwW23FMRrfFBEyjS4r79bhWSF0DsifkwLrOOUTwA9zTdTq3pR+WGeFI+4cb9Unpu2LlpnAxqkzhfHUk/2KGAN6JHo0abr/OwyJIo8YwlMB8Pg684GKBaAB0BccoIKIF/6s5oxVzC7PgzqcnMhvc3vDtw6dItqb+hG1lRP4L/qJOhaexBPDFM0QgMRQXY0gQ5RqFG3F05vj40BvejWjy2E+JtPItubtXhHad5soYh/kTHuhydNMAnmCLr6UZsVQK8jAvyvovIaLJU3/Mq0TIEfg2l0/NORhwrH+OID2IPNPQuKhf9eB5hjTRLFpDH+4bq4mMRWKU65noGaPH8ELfmCIXjuvK7NQp+dcje36S3vZ/1zPddSTQFAovoXHi6cKlrZzvutQ3Lg/Ky7XoF8LFG3Fx44zMhF1g/yPp0BBnJOfSPhKUvBLMK/Xy5preV2fIr4MHJ+2O95c1kLL4hKW1pHKjlz53hKBtbgkhyRN6EyDYwk7dOoCJ78MOmCt/MCIQe1DFAVQeSFsINDnnjFmTZfRUQlW01HBigi3mhlREIGmUrIbxrr+/mKHt/sddi8huDWPDz0K8bWPLmKfiUj9zMoS+UlQpSC/hH/lKrD9Cv0uBpvT+dzs3Yybi71sHt7hAO15vt2dcJwxE+2EEGz72VAyPWYVnIS+BuE8AM+Oyn9prqg112jfse21zFWAd4D5rZPEpZAxPtCAMC0Y4mStfMP8Vul+Wg0b1yYvz24/lGK7ivNCETQGkX0c10H72Gq61Lz/C6NOvdwLKESeJMvpg0wjJCCJ9p8nptYEbhX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XsZ4YGDIV/mBVRwNfSSkdMTGkU84pcbqSruSBYpgDDBNCytQDX+hb1O4X/?=
 =?iso-8859-1?Q?sACKzS6pR2ySu74eJeuR+dqVBLiMAoM9BwB4ew4GnusDJAMr1tIwhib9gG?=
 =?iso-8859-1?Q?lZXgctjCfPQ3VXvfnZnXHbQnIw2d3q4liAkl1/w7Ea378+aWSSaDahaqiL?=
 =?iso-8859-1?Q?OLjVHsPMDaDzmXQL5RgxGQWYdW2HyMrCzW7dfUgiejQMiddnfQixzuXHul?=
 =?iso-8859-1?Q?B0DYIEmiuMnc8anzI3FPSIiVX4We7Plg3+mXRdv/LNakxZH+yQ0UcbYxP5?=
 =?iso-8859-1?Q?Yytwh2mG38xibYMZtpsVHDbVr7ASq6eGRtFdVZ05q45zqdUYXupdiiGQra?=
 =?iso-8859-1?Q?XHD7wx+32QKFru4T7H/R7D0A7CAS+1KhC3oErjqbZA2ZOFw+L1uFktrZmD?=
 =?iso-8859-1?Q?AfrwWjj3eQ0O4DtFPDgZBZmM9UHEYV+Up3tagt/C8Ln6KT8yYSDj9KmFiq?=
 =?iso-8859-1?Q?nj27HyYKu6Tlei1Czpcu7IFML1qUBWcUJxVRH9drHtVvOBKYYVSHVuktqR?=
 =?iso-8859-1?Q?El4hcqvXP+a4ZbpWvCCI6vHTmJaV7UtYokUzeIICar8w8aQ05DKw46rMxa?=
 =?iso-8859-1?Q?fum75GNdYe1jI8H1SVFoLQzVZtlsXQz1JlnX596Sb1hP49U7vuCBj0ab1U?=
 =?iso-8859-1?Q?5B37m67GJZc3w4Nc0cOE73xo2XBRCX5EKDOH/vgIhuKmSQrAaH7G3PcDQX?=
 =?iso-8859-1?Q?e+xi9HXNZwvfx74D6Fs7HVYTt9WO/adpSkjplt7NSRLX1dtnkfdCcizFVN?=
 =?iso-8859-1?Q?Lmo1AhNahoLKdH5YqmFNeS39mcSTY9kiTFpsiNwh6hLx3zCdey5NsjpEyf?=
 =?iso-8859-1?Q?fbu1b/XKWJ/zKeczWMKFYs93B8FgU2dB+zLtC4nzm/GT9JG8pqC8NjjdBy?=
 =?iso-8859-1?Q?F8pmkF6nmDxzO5xsfcFv8CiOc6UywNYJmh51nKHPXSce0ca8Iy+1aDUHrg?=
 =?iso-8859-1?Q?jSAWOZLaiaAWi7ylPKI0ghIFz9XGYrjoCSshNiaO33I3nVAAbKNzwsDGEc?=
 =?iso-8859-1?Q?c9+Ud4IpGFDsjJc8LASuNVHHwNRsVN2T8ybnwgWLkq+qG8Tmieypp0RYas?=
 =?iso-8859-1?Q?6HdyiLTNsr7IQkg0jBYdtQzWwd5RLwXFLT7vA/F/UBIGWPySfl8M9Xyb0n?=
 =?iso-8859-1?Q?JqAw+0K2sZoaquLo3A+Q4EavVnuAwNkLlg5SxQUI6yO5UGdcu5lwh9dgXZ?=
 =?iso-8859-1?Q?gV7gERD5s+uN6+hyF1ph7M4USeX+0s246K0F3l5CMbJBKeJn6PddUXlkgS?=
 =?iso-8859-1?Q?zLgg3iWmveIGzdhZsYlxTj9su06lE6YajwoUTH8n3Y5D/htJLrTzbQCMRH?=
 =?iso-8859-1?Q?K+CAnLvdxrrR3qVmqFF9ud9TV4+nzWaxM0VB56yEZJq9A5gULuqKi5sJpk?=
 =?iso-8859-1?Q?lR7PcY0k5R6uA+a3JI5rg2VzmayNGQxj4kCEq26+vRIpo4Gj6t+tI2A8TB?=
 =?iso-8859-1?Q?PjxKUjZhsHEzUtZv/2cauO8aPBTMwZb0v4KropPzowxD9mxjB7ViQbANqU?=
 =?iso-8859-1?Q?iSVj5WPB8zZJL9s5f7gKprm35J7djpabcj95q7+XelYxaY9kN35LjaV7f+?=
 =?iso-8859-1?Q?x1dI/WUPertPGSKpnO+iLRC4KIUSN/NvYBU/WWmpwQMExRVIUhzg/ScC5I?=
 =?iso-8859-1?Q?2ZTT8bBHiS4ePCQPYogRfaGElUC6/mZRH6qBJh888gfHfYuIlWNNRqgoUL?=
 =?iso-8859-1?Q?XUjRW8ZB+7R8iMRBIHnxe1fY2nZ9IEPxrilxfYs/54YfAbCoSZiGttByVI?=
 =?iso-8859-1?Q?1uWtcGCAG0tveMn6iIJPQ4gJpwdZ29TiJkuMqmp68s6kKBspYLXefUTikd?=
 =?iso-8859-1?Q?fZCvdwfRaA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5gCXwlkKQ9H0nHk4whT6yUVrUK03YGimJftF5cJxEkBIWkH9Zk5FairTRwZLYaZIPhBnaViToRccKbfiHCDqEdfSYeyCAmWqyFweHiqBKA+JYmp/jT/7PTysxNJs+NGdKPsRgUJFl+CRIg/fh+e4lPqaOMqRFHIQu0fr/dUCrP9CFfhz0NCEczwHpqcDGdBJN9c45QKDNDYyOpEOc24BFEExb7Q6alPXXoXyxwXgeer7bDKQLUkNY9muiXMQjnBHiAScF9sT3Y6xxcZT666LonE6fybu3XE6GMXzt5jk5B0JIWnsUxk6klFluOTBPt4nA85D7lgukO42G/J+hc8rw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc0fc57-5e95-4932-e1ec-08de8934a0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 23:33:45.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrqAQq6zqTNVD1ijAS50BYP2F0bQWJOkxNIxClp+HNMK18Xpr+0oSl0NqN4HK8lNrwrSDvby8pknm82yXNjDdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3989
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: jVm--Wcjwj6_l3Vbq_FL2UQze3z3HB-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MyBTYWx0ZWRfX5/1/Okjx1CDs
 J+7tOSUDt7ElNz7vcLmji+b5WjPBF5hol9YOVve/KKq17Ovq6TMp1gFmnkrkdp4EUkcQRq46/Jx
 NrWeO/zMnstwwCunihBNQ7/ST7i70Sni222C0ANkYeaBlXi/oO/ymlXOHo08gp87uOzBNkElo1f
 8jXUUrPb6Sz+kJfbN4ZNYb0jaEt5hBvRSG6hkXzJszgffB3XrBQpE/hHSjdxyxEScwZKpw4fJGr
 bF97g6jfSF7Y4PcLEJlq1Gn7kkToDKa103SIQ9oxYkPcLQEIU222TEs6WqzESsAPDmHP8iFGP3P
 UydLBIb/s0ly/z+uF8Ynr86rYp/Mu0lTeWFvsyKkO8A091AaUH/RG0zijFtD14gyYo19I/oljKK
 0BLuSRrfC4n7h9CUfkJBowqSLKUNvxcKhq9vEN81xJ5QLLB+Y3AGDdR63JXJy+9kstJ0nINToss
 IW/o80GPaUhPvXy95uw==
X-Proofpoint-GUID: jVm--Wcjwj6_l3Vbq_FL2UQze3z3HB-R
X-Authority-Analysis: v=2.4 cv=ELYLElZC c=1 sm=1 tr=0 ts=69c1ce16 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=k7r4yCLl9DVLXMiQTbtC:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=Knx6zecuWxaYfDB9Tz0A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230173
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230032-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E1742FF064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
mp2869_reg2data_linear11() and mp29502_reg2data_linear11() decode=0A=
a Linear11 PMBus value using signed intermediates but return u16.=0A=
This can silently truncate negative or oversized results before they=0A=
are consumed by the driver read_word_data() callback path.=0A=
=0A=
Those helpers feed values later returned through the driver=0A=
read_word_data() callback path. In that path, negative integers are=0A=
reserved for errors, so successful decoded values must remain in a=0A=
non-negative bounded range.=0A=
=0A=
Change the helper return type to int and clamp the result to=0A=
[0, 0xffff]. This makes the bounded result explicit instead of=0A=
relying on implicit truncation to u16, and keeps the conversion=0A=
behavior consistent for all helper users.=0A=
=0A=
Fixes: a3a2923aaf7f ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series =
driver")=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
- No changes to this patch in this version.=0A=
---=0A=
 drivers/hwmon/pmbus/mp2869.c  | 4 ++--=0A=
 drivers/hwmon/pmbus/mp29502.c | 4 ++--=0A=
 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c=0A=
index 4f8543801298..fc4ce854c9c3 100644=0A=
--- a/drivers/hwmon/pmbus/mp2869.c=0A=
+++ b/drivers/hwmon/pmbus/mp2869.c=0A=
@@ -65,7 +65,7 @@ static const int mp2869_iout_sacle[8] =3D {32, 1, 2, 4, 8=
, 16, 32, 64};=0A=
 =0A=
 #define to_mp2869_data(x)	container_of(x, struct mp2869_data, info)=0A=
 =0A=
-static u16 mp2869_reg2data_linear11(u16 word)=0A=
+static int mp2869_reg2data_linear11(u16 word)=0A=
 {=0A=
 	s16 exponent;=0A=
 	s32 mantissa;=0A=
@@ -80,7 +80,7 @@ static u16 mp2869_reg2data_linear11(u16 word)=0A=
 	else=0A=
 		val >>=3D -exponent;=0A=
 =0A=
-	return val;=0A=
+	return clamp_val(val, 0, 0xffff);=0A=
 }=0A=
 =0A=
 static int=0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index 4556bc8350ae..1457809aa7e4 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -52,7 +52,7 @@ struct mp29502_data {=0A=
 =0A=
 #define to_mp29502_data(x)	container_of(x, struct mp29502_data, info)=0A=
 =0A=
-static u16 mp29502_reg2data_linear11(u16 word)=0A=
+static int mp29502_reg2data_linear11(u16 word)=0A=
 {=0A=
 	s16 exponent;=0A=
 	s32 mantissa;=0A=
@@ -67,7 +67,7 @@ static u16 mp29502_reg2data_linear11(u16 word)=0A=
 	else=0A=
 		val >>=3D -exponent;=0A=
 =0A=
-	return val;=0A=
+	return clamp_val(val, 0, 0xffff);=0A=
 }=0A=
 =0A=
 static int=0A=
-- =0A=
2.34.1=0A=
=0A=

