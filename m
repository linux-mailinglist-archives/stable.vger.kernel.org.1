Return-Path: <stable+bounces-227356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO2SLrc1vGl3uwIAu9opvQ
	(envelope-from <stable+bounces-227356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:43:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89222D0301
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 209AE3088640
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B137D108;
	Thu, 19 Mar 2026 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MHaaYJ2O"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728F389471;
	Thu, 19 Mar 2026 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941564; cv=fail; b=BSIOYQt3qbzhuiVmpPIDedN8B4mNTeNcNnwYDHd/qxz43NmSD7C9t797gRHxi5mR7hrdguOoPtD6e5DsIa32cnhAoeOnshP0KDUIzJJcoiQsYzY8oVqL3luuGjMdQYlk4jeu0QP4Dkulcwmzq0CBhZDMiFltQ0YbNoshOcCEzV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941564; c=relaxed/simple;
	bh=VB0N4hJNd8vEzCXfxluJk1lTqrSf9pyq4roPiecyiTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7TvrbWb5RKBnu8jFjqAjZulg2txPC/dgW8Ji9/uPeZxRQLSggrxd/53r43UckVNafcuuHpdUFivtK8rky9zGnqyp3LZojRpKJSQ/13iGzXH2KnojzZ6k2bknLmK6tQV/euZfVGOAOCaV1d2GsSrCE8HBhgCBxDPgUmffq7D8pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MHaaYJ2O; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFhELS2463419;
	Thu, 19 Mar 2026 17:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=vr
	U0ZM4KtH8LwcTEt1KR7BmFq/p3vc/sKeeLmXTwwTA=; b=MHaaYJ2Onj7HETx/rx
	F5emRv3LYnXKrdHG8YGkq7D8rSG0ljDSjH68xZeH6jWCUA6qF/5KWpGOxB+k1XE+
	jaTQr02Gm3HVIzWFQ3vbI+1y8QChbkHOiuwfaTwspeDl6tAJp2ViVjhLpqD+sErt
	TVCmXOiIqY5kkmsT0+bx/c72BxbeV6F1iWZvKnT/c4R1/IWby2xhEzFUTHeNfu13
	8TdvYr7DLySKdZ5iYlacLdEbLrLoq8iXRcgyGURWIyxXRXzJu4BiebgvAQUhgqTE
	EZwrbKczJSsC+d2dQGfEB25/875wY7JrXcmAE3/QiGZqskmJwpCVygBLWsQUl+E5
	kVeQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d0c7fy8ft-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 17:32:20 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5193D80170A;
	Thu, 19 Mar 2026 17:32:20 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 19 Mar 2026 05:31:30 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 19 Mar 2026 05:31:30 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 05:31:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdzPrzt2kLqd0GDLqmkPe3wKazMAJhTJ9USNvlF514iGUt/VLHYLvdyWNmiw7EPzBVqiOBI99eTlxkDkSatyLiUCwgtjoEaT2mg2wVey/b8rvTOMoIoZOiAUetzexqbLH3B2BWlsaKwK4okW3yG3PGqbdDYNjyMHFv5KsrBf6MSWY8HsPs0bavy2iE8yfkFCB+hDuufwNE3hLN1RkwVBAAz5l/OnrxvJ/72NYCuozVAIsCUWHxJCZIP3GM5EQZckgAcquIlj4ammqe44q0S795sbAC+DyGp3GeZOoRYarrMpXXw9IWB35tnuuuUy/vE8yMiiawKnYCbG/e0VEts3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrU0ZM4KtH8LwcTEt1KR7BmFq/p3vc/sKeeLmXTwwTA=;
 b=xKR+GQyYBdxewqo0bSj8Jd3rZNltrZvSqFI5qEZDcP1cVqKqh63bhhIRgmn6rLTMwz+tzSlLibnRYe2j4RCMgKVaBX+EOXzeIGdSyZ4IMOde6F7ER9XRTUdz6IvDxbA3qe3/GJ0b89TzAGrJQcTdl2w0LXZiPRw6Fm0r7oahdy4pJsBcimlxG/nCpyde3JhWOpYxPzP8IqIXWm4smlXHI/vMc476wU31NZp2c5blT3kjqaJO7Zf+eyNM77tfqOhH+qOhxNG6r3bqQUuFDl7z40CZLmWep/eNNsU1tvnjII9uXMIJD0eWY3G+SltLdIBQpi/A5Xe7jO/C9v/6NzRBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV5PR84MB4049.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 17:31:29 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 17:31:29 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 2/2] hwmon: (pmbus/isl68137) Add mutex protection for AVS
 enable sysfs attributes
Thread-Topic: [PATCH v3 2/2] hwmon: (pmbus/isl68137) Add mutex protection for
 AVS enable sysfs attributes
Thread-Index: AQHct8Y42bPyrlSvvkiaHrgTvKpO2w==
Date: Thu, 19 Mar 2026 17:31:29 +0000
Message-ID: <20260319173055.125271-3-sanman.pradhan@hpe.com>
References: <20260319173055.125271-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260319173055.125271-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV5PR84MB4049:EE_
x-ms-office365-filtering-correlation-id: 377718f4-5c57-4733-224c-08de85dd5aea
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: xjI6mGgFvEyOzBG0AiaUxZiYsOpYPU6sNAkoth1q9R9er2Mu6uCOIUKb5tk+7FxdITGiw5qgVuEpOXAH0EtEpoCLFMuxFsdLTD6EYodUR92DWoRrwaSRRz94dr9b112qRGjwhHCyL4p+MGOwyfDAaj5x4m0C0jri+dbI8TuertbOM9gkX+RhzrdY+W48eUDG+xrctiaFCKn/6/c9z8fkpqlvW56HUiIYVdzAGj1Bt6cLxacwESqIcMWBikUhoHTi2NtK4kQ7X3Ih41vGhDBCoiOG1e5EY1DgIGBDUD17yw+XSS5NKZA0X+0gbl3C38Prr8jX1fEAvL8z7ZH+SYu3eE1Dd038ASDp8XnQVrR8fBXh2/ydiHxWqSm70NfEbBMguJMMDMPsVKZxfVb8+uAlXf13F31u/CVzqdh63sHxG1NynyzemRJRPENmM9pW0eB0H87GX7V7XfsTgPUP6fk1/aT0CmScaNX7+Rx37yjJxxVHmX/ZVfuxNHKVUjDt8TTc39rVN1ZuKOdmiYCD3frMtlqFeYub6LaEJ60Jrb2KSUf+lir6Q0V54YL78sfPCbpOldRdDJPDomPvJ3e105USGEorkHTyyp/QO54RAciKPq/BAxfP5Juq6p1naqqm9G76Ok7F8XF1CwQr+mOucvBvnzkfERViSUWMxXJ/IewXgZS5R7rvReotlTa35ygYERbk4F2L0Fu2oVY5slffYs8+Os08QXV1iPg+a/2JRk0j7j/U5Qq5epGCU1GGkhFoJlYtehY17H5Ni6eUf7TgHsbCRTgUOhyw3oFiP79nQq3vdbQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/wok8kx1cs1716CWnwp1l5ZXuxSUpP0P6jjjTFcCVFi4Q2WI7tfR8F/+20?=
 =?iso-8859-1?Q?sJG4W3GN3qK7hlRinjOFgapF10sb/ohhMg/7pj8QHFNahhSpA6CLQaRJEh?=
 =?iso-8859-1?Q?4ZcP8V3XcVkdJG6TIGP8IUacjnKGho+ztMcQLWD5Vi/SIOVP1g8D8FbGmz?=
 =?iso-8859-1?Q?wNE4B+STpfGPq5m/Lq4JyGgNzqrQA0ur//bBzHLzQatsigXxYNaWsnmA/m?=
 =?iso-8859-1?Q?jiiphtws3OsvZ+hjwmt00mul5G3IKeffjiKFVQc2w19CGjyEoYXza0ybJV?=
 =?iso-8859-1?Q?5hu/iPbLmZp1BNMcBkMrBt5Eoh6mjxIyTPKXjkz4yg7UGAcy+j86/ZRAkU?=
 =?iso-8859-1?Q?sAvPIpiOVLQ9wKMzjudGgDbyXevhxWSxb+IDLZ85BpzsVeN63W/vhByI3q?=
 =?iso-8859-1?Q?YRB4acE0WB3gnr1JitE7CW3E4OI7f3w/KAC+3fpYVMI5JnMMxLDzQpmJmW?=
 =?iso-8859-1?Q?H9qVCZU/+1wXnVUFH6VKgNoHG0eRyuJ57t8Dr+NhTBiS+LTiba+GaAEfXd?=
 =?iso-8859-1?Q?HDFsk4vF462bEe894Tsv7Ihns+69GwVp6gBt2AdA2wSsID8m/QUMqoP2Nf?=
 =?iso-8859-1?Q?TDJ3WPHGV2ZROgZxU6OFiv3HfghyrKEYlC7bTJMtmfeV5y+JmOjuTks+Dm?=
 =?iso-8859-1?Q?c+M9lSdauzldmErDnyUjN9sf2JaIrSnezlvCvd6wx8h99H8kVT+cANLt5I?=
 =?iso-8859-1?Q?kKvpzjPp9D10qTXjbEGpouwWYAADyOzGRXnrTvjVpVLrSpb1yrxKoJdhN0?=
 =?iso-8859-1?Q?s19ZdYiEtIU/a/oj7gRJx8Tr5n+tcl5UomUzAAmlEd6eM8BuI2aTHeJqCh?=
 =?iso-8859-1?Q?yMjn/EDzgzwEDi9TwAVNe4nxpYFfcd+aejtW+Qwoyh2Q+3C87xZDR6DHuP?=
 =?iso-8859-1?Q?vP1B1PKJM3PfL2/RoNWaodFFtVDaCWn5QnVVHdhnmPZrTKUnmaFWO3WBRM?=
 =?iso-8859-1?Q?Ti34SjPciPs+rnEyoo49Quq2RnhRbdGWjbZzDlsyPJJbGaxT9jKQdo9ai9?=
 =?iso-8859-1?Q?+3h4+r53cFSHP8C86JDdUzZb4+GySCQoltUG0a8mTZDtl0hwQ5QR+Tg3Dz?=
 =?iso-8859-1?Q?IvU2r0lQBSJnaIXM3e+DVWTJPd6R5nSJ6xb89H2w/gf8EwzEWGGzzP36lJ?=
 =?iso-8859-1?Q?q+1+OCnHK9Ne1SGrV8xukOWd2iyVwQp8vQkUA1jqlWNFGqPahdLgJ7ROQb?=
 =?iso-8859-1?Q?RAWRx+6v7SgN1rkmSZCCA7BwuzHwEcqooFAey28Zar7UZjZRxCA33WOgTG?=
 =?iso-8859-1?Q?U/il70OgIkTNdIN2/21pE3FqaYRxj3t/PRGKpOP0b97V4ebxAtQkNPSjRf?=
 =?iso-8859-1?Q?xJClAum833t6PkQfIiK6H+mZQIEXonb1Z0WOlsaBL7Y69ipj3mAwM1Iagt?=
 =?iso-8859-1?Q?t38mrGUYBNLiQdKQQjRpU+GxxjLbo4DNiaX6unJEZ/vavWLXOObfiufOIv?=
 =?iso-8859-1?Q?Itg0makjXXCQuE4PAC7D8yrvot5mSbVMjILACWhfIQGL/hqH1XN1+X714o?=
 =?iso-8859-1?Q?mBHHpIXWDpCdxtN3OUW1ciFXUjBYVNXpPdUmd0CIE+uOncAGnwRY0NNrFe?=
 =?iso-8859-1?Q?5+8goZcGuvUA4slw01vafzKjSSbqDvrP+G5E5vGgk0U9YjUXKJc4cKavUU?=
 =?iso-8859-1?Q?bK556fCp9hA9YaqoC3aZG+lwT+TkdL7CzSFUNyIgIHL2eRXNK5yu1kW3JI?=
 =?iso-8859-1?Q?z8OE9kf4vsNtsKnqeHM1RUizGPuxoG80ruZkfVuSKvqE6kxqCesZB3p/ok?=
 =?iso-8859-1?Q?RaTbwbK+e18E5v0biBNSpdDj8y4VOVz+gCR4cgGXwb+ZPv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PJRavmdnVno6LQ2YCCu1cf+GVPOmhIbzmrKyIdlMb/zGsT+EZhLRjuk2jskMyiiJGxHM7jF0ACjjono0dPijAeGOndMdOqhr7Xz2kI1aA0KXMdlhq6/UYcv5So9Tu5B23AGraS0/lVyI4lvbMDuu/44QBG4tBLSEbLKc/umrTedySdrGvtBfk6+ri4Q0Xir8miR8+OHpOmlHk/BfBAYDmdGwtxOK7NgyRbEKZLslnusSFT3wuKDQZpHWfrrGuCi/1pCJCuT/EfaAL1cQ5i4xD69YjyYAvW4MxfLtYMtHEf4LjT4NfANwCRJtHKWs2D6wo+Ci1d8x3jlZ1z7XTBT71A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 377718f4-5c57-4733-224c-08de85dd5aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 17:31:29.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrOmjK9jchRn8DXrW3r1nJNd3V3Uz7TKE0FDu6gIv7RtajB53cXS3X6Rp73wT92QBwdkAPsquQr8ABYs1rC7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR84MB4049
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE0MCBTYWx0ZWRfXzMvpoLFmTPJs
 w+x3pvobwQXuNs77Yb/vnKQk1Ux1BIqrqoW8nP0WhH7pz++yV1O0Y2vBMk/dheJ6B/eEPq6K3zY
 2VksQb/uFw9HCjhK6V27q2DLbmBx/fXf/EqA8WWU8scfd/oosnagfhdGj/bB4V+aduecLwDx/TT
 A0u30tFrw4t2tDOObJ3TNr+TVliQV6/HUGv8t/dzOJ8BiBfk8VObbd6HB94m5yqqbFeGJzh2ueH
 wjuDFrso4PFT3zp5VcTd/iz1Xsu4SS6aqaOkBai/79I4ZTZd7Or/N3f6iEUwAqnDaoCf1LrY8nF
 Qc+qIgIYWi591TrGyFz3BPswJzDMGp7hPrNz5pYCliBvT/mzFbFiZeUrkhzb8woZnKb099aUSsJ
 zYITFdeTQP1ArrSzrJ06LOYtuxixXm1WMNpzvPBvzMDsMYYvAzTfNZY6800xEg00sScmJsxh9rO
 6mwqs/5ILizLQd+xz8A==
X-Proofpoint-ORIG-GUID: hhrwFZjDAIWVl36nJ5WjJbasrM3xHheI
X-Authority-Analysis: v=2.4 cv=f4VFxeyM c=1 sm=1 tr=0 ts=69bc3324 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=AOC-8cYSqdMoWEE4awIA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: hhrwFZjDAIWVl36nJ5WjJbasrM3xHheI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190140
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227356-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,juniper.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D89222D0301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The custom avs0_enable and avs1_enable sysfs attributes access PMBus=0A=
registers through the exported API helpers (pmbus_read_byte_data,=0A=
pmbus_read_word_data, pmbus_write_word_data, pmbus_update_byte_data)=0A=
without holding the PMBus update_lock mutex. These exported helpers do=0A=
not acquire the mutex internally, unlike the core's internal callers=0A=
which hold the lock before invoking them.=0A=
=0A=
The store callback is especially vulnerable: it performs a multi-step=0A=
read-modify-write sequence (read VOUT_COMMAND, write VOUT_COMMAND, then=0A=
update OPERATION) where concurrent access from another thread could=0A=
interleave and corrupt the register state.=0A=
=0A=
Add pmbus_lock_interruptible()/pmbus_unlock() around both the show and=0A=
store callbacks to serialize PMBus register access with the rest of the=0A=
driver.=0A=
=0A=
Fixes: 038a9c3d1e424 ("hwmon: (pmbus/isl68137) Add driver for Intersil ISL6=
8137 PWM Controller")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/isl68137.c | 21 ++++++++++++++++++---=0A=
 1 file changed, 18 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.=
c=0A=
index f42b13fe9fc18..48059ac4a08be 100644=0A=
--- a/drivers/hwmon/pmbus/isl68137.c=0A=
+++ b/drivers/hwmon/pmbus/isl68137.c=0A=
@@ -94,7 +94,15 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_=
client *client,=0A=
 					     int page,=0A=
 					     char *buf)=0A=
 {=0A=
-	int val =3D pmbus_read_byte_data(client, page, PMBUS_OPERATION);=0A=
+	int val;=0A=
+=0A=
+	val =3D pmbus_lock_interruptible(client);=0A=
+	if (val)=0A=
+		return val;=0A=
+=0A=
+	val =3D pmbus_read_byte_data(client, page, PMBUS_OPERATION);=0A=
+=0A=
+	pmbus_unlock(client);=0A=
 =0A=
 	if (val < 0)=0A=
 		return val;=0A=
@@ -116,6 +124,10 @@ static ssize_t isl68137_avs_enable_store_page(struct i=
2c_client *client,=0A=
 =0A=
 	op_val =3D result ? ISL68137_VOUT_AVS : 0;=0A=
 =0A=
+	rc =3D pmbus_lock_interruptible(client);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
 	/*=0A=
 	 * Writes to VOUT setpoint over AVSBus will persist after the VRM is=0A=
 	 * switched to PMBus control. Switching back to AVSBus control=0A=
@@ -127,17 +139,20 @@ static ssize_t isl68137_avs_enable_store_page(struct =
i2c_client *client,=0A=
 		rc =3D pmbus_read_word_data(client, page, 0xff,=0A=
 					  PMBUS_VOUT_COMMAND);=0A=
 		if (rc < 0)=0A=
-			return rc;=0A=
+			goto unlock;=0A=
 =0A=
 		rc =3D pmbus_write_word_data(client, page, PMBUS_VOUT_COMMAND,=0A=
 					   rc);=0A=
 		if (rc < 0)=0A=
-			return rc;=0A=
+			goto unlock;=0A=
 	}=0A=
 =0A=
 	rc =3D pmbus_update_byte_data(client, page, PMBUS_OPERATION,=0A=
 				    ISL68137_VOUT_AVS, op_val);=0A=
 =0A=
+unlock:=0A=
+	pmbus_unlock(client);=0A=
+=0A=
 	return (rc < 0) ? rc : count;=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=

