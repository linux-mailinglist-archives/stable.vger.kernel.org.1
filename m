Return-Path: <stable+bounces-229968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPvcLRF4wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:27:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE12F9E9E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4711230D8B38
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082263BED29;
	Mon, 23 Mar 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="dOnkGGOx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FC823DD;
	Mon, 23 Mar 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283730; cv=fail; b=Wx0pxFHcBZG/zajrNE75SdpoDaGm1w7aLiUF7qBJ6NjL34m6s+Lv+a1CZ6XEsxRgTQuYnuv2XFJq96Y0JA82aDc5go6NRDxtaW2THRKAHsfeRro9NCxfvlbN5IKEuVtxMXGVRaNQ1ROIK0OedOhmLqvrQBI7UUMKjgykHOm2A+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283730; c=relaxed/simple;
	bh=/yFvt/prDiE5erpnNLaZuHeQLex/jwSI48mqmtetPZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWo7MG/nDZSkbiWo+he6DNVmj3IyHMnCynBYWCCDo+YcewcpMbQRP+BwgurByiA3ni1kUCIVJ84Znyic9SHZB0UnIWjcZQCofRot+5HxCZuDOP5ERPw40jVylau0+yXrbfpQH8w6F7hFDG01ut4CCJeuLdKzEVjg/2N2ISGsoCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=dOnkGGOx; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NCBAAQ2636062;
	Mon, 23 Mar 2026 16:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=SX
	+a5PW0yIkoRZTx68V97PWA5Zl7rPbUq2LyZzrymQ0=; b=dOnkGGOxUhxgUfHvrO
	KJddZXvQUtq2yN8M4wAQut8hG7K/4x26Fk2l1CM6GKtMfdvWRf2rFYJLIS7Aer3l
	i2wBDnFJJl2vcXfv6VmLz/uFc8m4GN2AGd9ycacJp2mAKbcQEiLteQBCS0wZl4fd
	Jn9urdxVX//4GpsyslISZX7YhAwZ/n7y+PD2BoofK3Mut9V58Q/5PN6+pCj9pZRF
	y+mY0ftWvo8AQCevSl3OlmtViBcl9H4H17lpr8CQrKvxV/jde9wl+ZXrjTJqBNVG
	2gaEcUx/v3xKuOlwzokprDZ2DvtLMuJ4m/27DtthvudOnwy12mzHlhUcKP5L/Db9
	pR0g==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d35a6b4pd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:35:11 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D711B295F0;
	Mon, 23 Mar 2026 16:35:10 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:35:10 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 04:35:10 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:35:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8JC9yUk+WjKbMo7RHTf0bmWYRpRIFv8Pav6e52ugErV28fwjJg41MVdAnKgIgQYpZ/W7lmslV81xpNsy9NBT6gPrchtUMi07LSH1rQOVH12aL9FMG5BKoJFCas2ke6git/v0Hb76ARZK3V+l6uh816QUx3Uku/hd/bX+617AjrsijFDFVqAphWi4Hlh3AGRIfZW3K5CnwTyXE+2HnvFCiE6JzZ8V4fnZuhGuQ2PadYpEcpmwwjHwyJ44fIkOdwUsRtI3K6EqUzErhzB2Lzny8WtM20s+KDpHxy93JKPx+VRwWdHjP39344cMDvurn9vJz55owqa4ZVIz4NRD/kMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX+a5PW0yIkoRZTx68V97PWA5Zl7rPbUq2LyZzrymQ0=;
 b=TGyWcxvtAmSyPXm3U4F/HhB1FGtcoblmkn4sEbjW8b+Qzn44vl/rFltdNeKShTrxdL9fkDvR6VRF8ZtNOniHAzLj5BcP64130e5xqRDrKTwulPwybhqtIf089uR+uX5ChUTduWpPnqfoiFHMjGOtNAzBx/FxYrHPGIhrWmPXI/3gVTm1fnVCxTgHy2ZTttczQ0t3IHlLB6Kt7gIX/nSLxYyZk2+NvhncLku6RMG6arEUtNhTA1YSsTpbvty0yUAyLtC5SKN4bYRxAw7YzrY2jPyRu3ADufDMKk25wQ275WVGncBf+skPWeg9e0CN7wJnMf6Tma7hAWG8gnnSgtdecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:35:03 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:35:02 +0000
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
Subject: [PATCH 3/5] hwmon: (pmbus/mp9945) Replace raw I2C calls with PMBus
 core API
Thread-Topic: [PATCH 3/5] hwmon: (pmbus/mp9945) Replace raw I2C calls with
 PMBus core API
Thread-Index: AQHcuuL/+J1oRpHH5U2ocLyUH3BPlQ==
Date: Mon, 23 Mar 2026 16:35:02 +0000
Message-ID: <20260323163343.183186-4-sanman.pradhan@hpe.com>
References: <20260323163343.183186-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323163343.183186-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3819:EE_
x-ms-office365-filtering-correlation-id: 4704ea71-99eb-4596-8e9a-08de88fa2227
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: NzYDjd4rTDh3oeWeRLtjMuvUs9O/6xCF1bU+9q/jEhN9Mh+aYpVRsCmd87lJqXFkeMOseWL/rZfv76WTPAiQXRzxnUaRjZv9VGMnh80b0Yd7b/TrXewxbJN35bovuP53DSOicPNH+hN07GjAA+sDdFPjcUj7Wx92wWYtMHjvB/irmAT1HrDo+TW/ZZtR1D5YW+QKyJrLAE2s6tJEEkqaypKwtZbF1L/kVvAHZuj4d9otu7BtIeXBJBPSYstT/kSVp/t4eQXUDA5fZbhwMauia9+8Gz6a74UJqogrfRTqbbzkixgzNT/8ITI/FTAljEzKla/plXDFG+4plCZyM+/vz+mBXNWAZUFfOAUlTidAcHe14Vyuny4ZHBvY22S8fsx19sFD1Vl0TgqE/eRJUriu4q0NxBJvNQ+kemYCIjL+fNDGblBjMpUXnyyuBch1upafDDcnvIsAFvF8IM8D/eJibVhFJ8/YUdFqpLhfAPJ2xeQeG5NTpR5vtfVbLjcgHLsCUGnCyuWddrMuVC83FWeWvp6XkAN/21KtVNlxQ6nSr8qWr0WQZDR3x/Oz2KxhTSV6226lq9/Xxnw+ER0xY/62go7jKhVxQExodn6tzuyr6UAMXV0QYOw1qGb5dgLQJM+Ok0vjdqBtqFoz3Tvp5slx2kSPTVe6gMPwE60t+GSWz5u0Tyfi2RL8gnf+U8BIFYVmZNhEN7q49F5g4VlYVs1su+fCloMi/WPuBruo1ZzqNyT00tp21lp1xaI8BXi/Yu9e2LbOHetTdNbpWGYIGolUfpKyeaUg6gjokj2Sa0vrVhw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qryCzRGpMRaBD+gPy/gPcMyzRclPgAtJVUFPIXzjeMQ/GtUUMWCRBkEDRo?=
 =?iso-8859-1?Q?ryQNNfKKZsiFX9AJeszfgmMs5AENb+PZAkCj4urkf5KzJTn3YeSODIv79G?=
 =?iso-8859-1?Q?0cGHyaan8aOA/FdK6W/jBhrLTWmm7myDGup3iZsJWzdju9TY1mKiwYZkVT?=
 =?iso-8859-1?Q?iD6BFMWEKD/3xd93d9BH25iEZsFsjGgxSZOHh4GWAk3duZtHy1M0D4Rsjj?=
 =?iso-8859-1?Q?FyEQoqbLfgtCtuN24uGJXv+n+6ZtnSrjZsTiu8TlMkCOilPoGiMrw4Bybw?=
 =?iso-8859-1?Q?7fFnjGind+B++wjPu0343BnT3KtwTDt9vOJ0bsmtEVzGyYm5oFB6tyjPQq?=
 =?iso-8859-1?Q?kWhwNFMgv7EYF/Y2ng8qNBNi1a9X9xKg5iDqOmEnRmu+qIUq+a+Zg/sVUU?=
 =?iso-8859-1?Q?3c5BJMvtXn0o5OKUsRSdGt8vibcl5ifzCy7qpxqbyHMBqORz7kmzxQwRN5?=
 =?iso-8859-1?Q?WGQemWbZ1duAsSGK0oTt42breMSDfVD2dGqZOsC2ojItqIi8hxnWys4gOj?=
 =?iso-8859-1?Q?UEsIPKYiVDkfjDZWXsYcq+xEo0ffWIgxVR6kr7pQuq5vIQszKs6/84PUYh?=
 =?iso-8859-1?Q?9dCUKek5EmbLK8TVFDh4ZKRJmRZh7lCxhSaaU+s7hIUNLx3qbD9Oauf/+3?=
 =?iso-8859-1?Q?Q1sEXZ1LBIaxKNrwPw4/gsH+5DIaA4yQanOReXT8tRP84UVGkJ45Qag/d6?=
 =?iso-8859-1?Q?EzMklM59wxAtdpsqleS7PwE3RlLtDozVl1OJH8eeSGCybV7kqqbAoqmFmQ?=
 =?iso-8859-1?Q?UGxN8SyJJQSKpv7HoxVImgl057M+byicbwvoj97MOOqNSjcWwtRnACzdUv?=
 =?iso-8859-1?Q?4d0aTb8y/qj6H/o9/2+LuBsImXcgIM92usFn/FQQTE6b7mVdCRWDCcFs8L?=
 =?iso-8859-1?Q?XUbM+Huj+w4VKPU437uN11o6vi7wZtH02LAYS997tDiSESilS7hLfZPm5O?=
 =?iso-8859-1?Q?USxs/5weGMiUJdoK46YoPGLxXl5eps3wI0YaZIuaK78G+jpe5eDLwi/ONx?=
 =?iso-8859-1?Q?SrnWcv6Nkfnlnu2Mq6XNHL2Hud/rRdBekitKlkASyQKhhh8VTGDHIsiKNr?=
 =?iso-8859-1?Q?7m1O6lgPNNPH3xXSgSet46TRMPKl4ymLWDrDzQccddnpGXlGce6O99AbMq?=
 =?iso-8859-1?Q?6RHKk2/vUFyBA3QSvvKrMlOa++Z3G+w8CQXj4kyksVDYyfXQ4HNmjmX0l+?=
 =?iso-8859-1?Q?qCPHHwsNC5BZQRukEEc27C/XcSqr/7gU8ydJYnDrka1FO/4lRjDLfN1GlD?=
 =?iso-8859-1?Q?ZsStoAHdtu+hr2VDW4nVxvoHF3p8s9/zgWdssqs7HkGKyFXFFgk3RnroUw?=
 =?iso-8859-1?Q?oXLfqLws04gPiOeVjgNEpRm5Iglb0TGNqHcqpDqcSRWqtsU0a8rRwPtdMj?=
 =?iso-8859-1?Q?FHISDwu/3ocFbZnRVFSOvKpkkLIzcTE1xmwAjPFNXwH9ZOQ4dvwZSQBVky?=
 =?iso-8859-1?Q?yBaPk4+K2CxkxPwnbJaX40wBvCGTL79NCqZ9+VNmhCe1du47o5sF6wtFqO?=
 =?iso-8859-1?Q?D0u/FDz9VeJxp71ceiCQ0aiYviaff3JdLFqVN9mK7o/FvBcdc2+7fhzIzT?=
 =?iso-8859-1?Q?bvh+KUyY9Ce8b1+zWKY2jrT6ki78DWiUZkw1y//RErux8cRGuDk6gLfIFe?=
 =?iso-8859-1?Q?nHrsibIrsapYpqOi5CA7y9Kjz3DVoEz8mm0lRJCVzdfdgyVoBJScYMi2Qd?=
 =?iso-8859-1?Q?vJwyseQEk0rarPdUWHcZi6rx5efNyXvaBgYFyk6/0iFNZiy8K9QgWKqlWA?=
 =?iso-8859-1?Q?jGIz0ZfOeE9w9XrLzpDQAwK6tgXt5j93sZNBlqJBd/69KT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fkLnj46Z0mrJCTkxOpSYda7O+dd9O5buAnZPLICWz2a6ud4KAQBWoFRTSpX1RF5rDhMluyYDoTEdMPnUbVtLHxyoy+OkLQpPJMcSUhsHmqplk5d9KL7IEC88yqcwfk4jBYONyZZZPIWgqBHE/3Q1dBOkK6hzKXXuEccFZ/OlZYApwcrDUQx8SpIGdXyAWec16QBnpYDFgOgWEpSwdQDiLhEQYGxNKMCnigoGmkg33IT46ESNyLwlbAk50mf/U9gorqVZIwW0uR9R3OqTZ15DsxibS55Owk2uxfCzOPS9YS0TCK2nF3G+rdP+UK1HwYqJA3OJ6iSXPwKUoHBNXCw2gA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4704ea71-99eb-4596-8e9a-08de88fa2227
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 16:35:02.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpQWoT0lY61S7+Hd+J5JnWCJYPZUyfxLozy8gy2TOW+0zDKReqzqUbSmFReG9C8ZywAJ4qYh6ii8BCtxfrJijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3819
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNCBTYWx0ZWRfX45tfSZAvZq8/
 5OESe8cpW1uBluvtOCZ2Yfx782JgOUKyEPpWEGEp5ScoaoWBVXjRMAIuHqBUyinHgrc5Eyg7iSY
 p9x+mLWzF67eVQkLasJMvGnzsuDLSP0GKPZsRttUgYU9n05u5aQr5SclUZZPzQnZv0oTmyJW3C1
 ztnkgiHoGcmIiZ72maGBlk0eaqXwl/Z+BA2xP2M4lIQJx6KvmCw+Son6RNn1leezcqce3QUYImF
 jZVkbxraU+95y5cgu3yP07uWOtvZMagWZMxOG2cLkDiWqy4f6DIgU3oP/H+3idr9jylP1IuTMZu
 yqpx8jEKjjrw9LQ1Whq0iuMI1qmHVFCSjQE3uVHoXk/2Uw9ji49s+AeZhydKnebIwYP/H4Spatz
 9oKrtRmfKZjI0fz8baeUXPXK/fHrPkKKVwTV36qdQiLVGA4lsnCYFDy7aGujUk3P6iPffNXcxJt
 pY1ifuurtqfzKHuAyLw==
X-Authority-Analysis: v=2.4 cv=eaAwvrEH c=1 sm=1 tr=0 ts=69c16bbf cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=whyYXC9HAFXPZnEe4DQA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: bzpMAFpRZdHsKoj_rUW8i_FjKhZgLmrO
X-Proofpoint-ORIG-GUID: bzpMAFpRZdHsKoj_rUW8i_FjKhZgLmrO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230124
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229968-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 13BE12F9E9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The mp9945 read_byte_data, read_word_data, and mp9945_read_vout=0A=
callbacks use raw i2c_smbus_write_byte_data() to set PMBUS_PAGE and=0A=
raw i2c_smbus_read_word_data() to read registers. These raw page=0A=
writes desynchronize the PMBus core's internal page cache: after a raw=0A=
write to PMBUS_PAGE, the core still believes the previous page is=0A=
selected and may skip the page-select on the next pmbus_read_word_data()=0A=
call, causing reads from the wrong page. As a secondary benefit,=0A=
switching to the core helpers also routes all post-probe accesses=0A=
through the update_lock mutex, closing a potential race with concurrent=0A=
sysfs reads.=0A=
=0A=
Replace the raw I2C calls with pmbus_read_word_data(), which handles=0A=
page selection, page cache coherency, and locking internally. Remove=0A=
the now-unnecessary manual PMBUS_PAGE writes from read_byte_data and=0A=
read_word_data. The identify() function retains raw I2C because it=0A=
runs during probe before pmbus_do_probe() registers the device.=0A=
=0A=
Fixes: 6923e2827d58 ("hwmon: (pmbus) add driver for MPS MP9945")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp9945.c | 21 ++++++---------------=0A=
 1 file changed, 6 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp9945.c b/drivers/hwmon/pmbus/mp9945.c=0A=
index 34822e0de812..1723ef84eb0c 100644=0A=
--- a/drivers/hwmon/pmbus/mp9945.c=0A=
+++ b/drivers/hwmon/pmbus/mp9945.c=0A=
@@ -43,11 +43,12 @@ struct mp9945_data {=0A=
 =0A=
 #define to_mp9945_data(x) container_of(x, struct mp9945_data, info)=0A=
 =0A=
-static int mp9945_read_vout(struct i2c_client *client, struct mp9945_data =
*data)=0A=
+static int mp9945_read_vout(struct i2c_client *client, struct mp9945_data =
*data,=0A=
+			   int page, int phase)=0A=
 {=0A=
 	int ret;=0A=
 =0A=
-	ret =3D i2c_smbus_read_word_data(client, PMBUS_READ_VOUT);=0A=
+	ret =3D pmbus_read_word_data(client, page, phase, PMBUS_READ_VOUT);=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
@@ -73,12 +74,6 @@ static int mp9945_read_vout(struct i2c_client *client, s=
truct mp9945_data *data)=0A=
 =0A=
 static int mp9945_read_byte_data(struct i2c_client *client, int page, int =
reg)=0A=
 {=0A=
-	int ret;=0A=
-=0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_VOUT_MODE:=0A=
 		/*=0A=
@@ -98,17 +93,13 @@ static int mp9945_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 	struct mp9945_data *data =3D to_mp9945_data(info);=0A=
 	int ret;=0A=
 =0A=
-	ret =3D i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);=0A=
-	if (ret < 0)=0A=
-		return ret;=0A=
-=0A=
 	switch (reg) {=0A=
 	case PMBUS_READ_VOUT:=0A=
-		ret =3D mp9945_read_vout(client, data);=0A=
+		ret =3D mp9945_read_vout(client, data, page, phase);=0A=
 		break;=0A=
 	case PMBUS_VOUT_OV_FAULT_LIMIT:=0A=
 	case PMBUS_VOUT_UV_FAULT_LIMIT:=0A=
-		ret =3D i2c_smbus_read_word_data(client, reg);=0A=
+		ret =3D pmbus_read_word_data(client, page, phase, reg);=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
@@ -116,7 +107,7 @@ static int mp9945_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 		ret =3D DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * 39, 20);=0A=
 		break;=0A=
 	case PMBUS_VOUT_UV_WARN_LIMIT:=0A=
-		ret =3D i2c_smbus_read_word_data(client, reg);=0A=
+		ret =3D pmbus_read_word_data(client, page, phase, reg);=0A=
 		if (ret < 0)=0A=
 			return ret;=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

