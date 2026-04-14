Return-Path: <stable+bounces-237936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFhcCq543mkHEwAAu9opvQ
	(envelope-from <stable+bounces-237936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:26:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB923FD0EC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C3D3062E48
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D54387341;
	Tue, 14 Apr 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZVPTeYM5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0293ED12F;
	Tue, 14 Apr 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187534; cv=fail; b=NEnKowwu5y+fALSGT67PJnYWt4g3jAOzhx3krRe7nst+5er9H5Eh0VS4MaltJiZEwDd2gMQNwaldo9SeArzJ3bbyH+egWVGsguPNAntquUa97PRgpscCSusOQlSMCJGLeGNLwWDsa1gyN+crDayBe2Ep4sKe6muQEwFtaBHOmbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187534; c=relaxed/simple;
	bh=kCanw1QbU1dQhdbEReSeaQZmdvg9OuOTeJXx7OlayQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1+orYonJJ9NM3HwR4x7pi70FkVnR6+0F4VSkhUBVzIQKHOhLAP6nJJb66C68pk+5f8JUkJ00JbPz6bOwvj4VqXoz1pKdTVUlr+Thc+lAuI/P5qMwnr0Pb4YyOqM0rKFvM7ntF0HpZnJtjcWgPyGnbviJO7LLGUQfKaA1eSCu9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZVPTeYM5; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EEraAs2228977;
	Tue, 14 Apr 2026 17:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=/f
	ZDWetiEz1hhmc1R3iGa/zErT4dJyDhyHxiyay4rK4=; b=ZVPTeYM5DquP1KT0Xz
	mHYBV1YmoX7Jfbca2bFZ93hV13rQ92Nqp51TLsMOv2w+3asQUfTjExh5img+MJLO
	DfkAfrnbql1ia/z7FNGF7h8IsZL/yOi7LcP1BfQHTdo6/U9yjYv22OrS4lMF7HZB
	J4TjnuWbcaLev7kT2sspu9IudhH7nkB1/Mytm6ziqTVykngkczUf4/LY+1bzdZ1j
	IHZbpNakKkFl5uO41DM4ZLwxSBg0n33IWDfCGWI0M2tfNm9OsmNZ6D0h7NstZ0Qg
	qzjxlBLoY2OrZNi2hL8dJRmePca5SLSOH1IRBX9YFZki9I3EgslWyJFP8K7I1AsV
	UNOQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dhqr8hw55-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 17:25:17 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 73909801718;
	Tue, 14 Apr 2026 17:25:16 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 05:25:16 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 14 Apr 2026 05:25:16 -1200
Received: from CO1PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 05:25:15 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwMc+eG5nLogaYIGdFTiibpgusroXFvA/NBJ0vsGkRrWOP9zepxwq5W8EgkYJvoqPiiDhKxSDHZ42/3LdyRXHXCvOF/6T9sRAa0mNq2rQiJttOzJAp7lyVSXTadqMRDhBFrVvrJBWuOiqgS5dsKQGRiOssVJRIhHtqjpEZqC1a2iKM6w8Q7CHPAJemL4EwBDOJ75R45PVj3XoQbZ8d4vk4r5/uFQ/55lPOeBh8CBc+nn+zdZVyJnSsvfSdvK1B7tfRYVrp47Ilx/d2UBSU/mnNvPnm4GFYoAg/QJ7nIc3EMsmBi6qbOOTe+pFTlPAx1IeoolKLOajrb0/D6Q/9H8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fZDWetiEz1hhmc1R3iGa/zErT4dJyDhyHxiyay4rK4=;
 b=OYNky1WfbJ9Mpe71NqonBkYaIlrvddeeaLBAC9KId2xt/QgfAumYfme1FdEaxH7OXYeOs6cwMe4mVyEpUpzM/i6qQUVXzxaxfDH6pPBU5roFQuLBi/9CUz/Gf8bXq4oPlhTdIDHzv9T2vepKLyYPIiSIzvOwy6hz44keExBjgunwpeYJBpRKpvwZDY/TrtpsFB/Tb6opeQOOBw24Tg47k8/FMoqKz4A/S92m2YH4VbJ77HFauhngTyfvv9TZmgUJ9h1fP9kRNEWg/38m6cwBRZ4IxZLVkXiqoix5710g9c7HetEevb2ZVY2Nnz1yesxxSa7JCFOKRDREDAfvuFlj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by IA1PR84MB3034.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 17:25:13 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:25:13 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "yangyccccc@gmail.com"
	<yangyccccc@gmail.com>,
        Sanman Pradhan <psanman@juniper.net>
Subject: [PATCH v2 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in
 trace_start()
Thread-Topic: [PATCH v2 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout
 in trace_start()
Thread-Index: AQHczDOmygJZT4Wbbk6RCzR2Ky8hBg==
Date: Tue, 14 Apr 2026 17:25:12 +0000
Message-ID: <20260414172451.14331-2-sanman.pradhan@hpe.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260414172451.14331-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|IA1PR84MB3034:EE_
x-ms-office365-filtering-correlation-id: 1fffaa48-f045-4f38-b6b8-08de9a4ac95d
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: uVKocaRF6P3oAf3lMcM/fAo1x4lTALGPlDBLEfX7Gl7Qni9jWLc6QV9ZR0mGsnMYGidRRxWNjMJaNf4ppakElXYfznumhZAEC55yFksL/Wr70gDkld/v6WOmuuNiizqXjfFY3/a+vtkgDt5MH9TMSpXA8fkc/RwYpOQdXN4cvNvnBexmwy/EssWlb5T8UOfgYYoqMLCStKD4mMFxQ7GOwyUoGWkl04EZgprZ6kHtp0xrWAu4PzgYldYNaLLuruRcZtGp3AgjuPKBRcNwLEHD0XVdmY9CEJ3cSGYezly+u+Tx6Kjb2YTb4JomUF7nWwqdqssHzPUl39NQcLxAI5NjmOGzqiz0vl7YmXeqgjF+vjkFoHe4WvLxNwM/P58Ip+XAHNy12uDSXGB8OW2mAQ3KOiqPEC+vy0YPGfqmhtEiByJp8Ux4VLyjk5Uem1cKD3DblVY8YAExqCnk8K/V39Pgjb77xLpq8awWnH+qRL63lSwcgwq56v//qcJZ945hHsFebN4aeReq9aNnnfcrLYgFQwoT91E5Nz29cW6l4Nx9fXkgRWbvvvlk1Gvz2WS9KUsNCeL2IxBpucX8Y9ONmjsNx84qP1GqdUx4JZtKxB1TE3D46jH3INEjdstS9g99WysJiEauZZRAukDyI7sakrI0TM5hly4bjTJZNJO5VIemSSRvWGeuIuuxQnPTN7J7A12n2coNUl1XO1P39bdsk6nwB7bkuly19YS6N6A+rBNyzeiEEufjrQaFVCrF0lF/U2M2rJPc1obv3dvDxK2qlMVDwnMP71WQtBtXzw4J4Y54Ydo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iOsxe6g9SwrzZP5TaObn5uQ1qIHp/t1Cl25VMNiU15AJvReyu3p2p8RBMK?=
 =?iso-8859-1?Q?DBu34HtZmLnLC3eNDp/VEyCbIGatbi0GbsgBB+u+Q4F6rTzFECPZKTipt6?=
 =?iso-8859-1?Q?lA2xHrQlRUxaXBGUv8LdqPXFXavPu1HZH937G7AEWvdFIeMpwp2t3oxO7O?=
 =?iso-8859-1?Q?fgpLYsejzZ2KOoAY71n2Gh1YJzsSIPse5Sv83yxNZ/NXgKBERzOS6KHCVF?=
 =?iso-8859-1?Q?osVCnVGea4KVL9gLMkIOc6WQ8SjF9Bo3rbuhJjCWNNDh27GVtuAFkqj3Dg?=
 =?iso-8859-1?Q?3RyDpeza7yeDNdow7xmUSAqIQ2td1rgh4ugWcl397ffyJLoJmHoDL4SRjn?=
 =?iso-8859-1?Q?r1JozEvqmmjIGk5dbrfxp/m8FAsLo6Xv4O3Yvb/u4SRnagTe+4OZhUZck4?=
 =?iso-8859-1?Q?HOfEDlnqLnRG9/yhHoF824Ml3Ju3sxEY1qO4MGmdM7xpKYILyeVov/fvYF?=
 =?iso-8859-1?Q?TWwEi/LbjkS76Ac/6aftabrdMrXDsacQdf2zyUmaQi1JTQ5AmB0a8REEml?=
 =?iso-8859-1?Q?CsnXjYe/R2v7ip/UrHn5YQ2MYCnis/RCIapmvHeTmFLpbroHMAGcWqRN/G?=
 =?iso-8859-1?Q?eQAX5F/kHkLJ/x3VVmq7cyRyDaIAlmmaQEH/wlReOKLZ3n5nKxMGfZb1MB?=
 =?iso-8859-1?Q?Qek+48RSQ9cuJ8abLORoRbABPKHMVAt3lonvYJnZGsRL1YTjOkjgdnQ3w4?=
 =?iso-8859-1?Q?1zTd32Q/KR5H2eFFLdIx+ZXF1nwaBIhXHl8mWGFWcydXqEn9V7ajdmHagA?=
 =?iso-8859-1?Q?jtOu7uy8Eb0sFgKwhLSTLu3hW6HkThdiPYYMBsSTW1hv3+aO2wVQcUhm1e?=
 =?iso-8859-1?Q?+1C9wvfadjrxGWcp0ozJL8Gms2GRtnq7e7CwDpE7lhRJPzZypb+QV3fqeo?=
 =?iso-8859-1?Q?BQ+UFkOViVXKOj5M2RDrIEKgdX35CiLPrDwnASTnMKKq7y+RDla64eMk2l?=
 =?iso-8859-1?Q?38u6aCc1sxERKQKKShNRlFbHDhCdins0dQloy6LCAyUMSsxC25G53E5N6E?=
 =?iso-8859-1?Q?+afultBpV44bZ0z+MOrsnSnV+OLOKnUDnBZnTtxbNILsUSeqvyIPOq/XNA?=
 =?iso-8859-1?Q?SXUkxZmq0naTbS55uuZVavTuwhMS15ZIq9Te2aAyBmIknWqXtyfqGZShHB?=
 =?iso-8859-1?Q?OfSfminuyTaFEpD3he/L9JSK18JnvLtklZukt69q1HeD1G2lNifZPaOWuT?=
 =?iso-8859-1?Q?Ukup9so8ebClIbaLfWQ+sqLsearqAdJemcbjHSJ7DOV7T/DZXy9PcUTTQP?=
 =?iso-8859-1?Q?qkSxL1mJEfDEvThAozhU/vJhv5GDZX53TvKlTE7tONW8Tzzn5ieyqEPJU0?=
 =?iso-8859-1?Q?apUBgshmtFhQUn/iz37OuxyHDKJmLDS7QzVoxmeycfL9nJ5FSI1uaVVnVz?=
 =?iso-8859-1?Q?GkiYrnR6+DGWaqoGoWJBPBf6mP01Xss+cG0SjRnu7/Q3B+sh6AHgVkCxiJ?=
 =?iso-8859-1?Q?dY6qt1koIEFx5n/oUQVyEenIAki64zAEV1QJDzRYyVkmd+j1267CJxwpuZ?=
 =?iso-8859-1?Q?j3hQySgyIK5kKhK+Op4TJA0awfvPD/RoNyTJgdWrRkwC2k1UIj6gJau/OF?=
 =?iso-8859-1?Q?UJ/yjZCOqO4q6fy0u1qHiCswNLQuRtRdoqpLAL9jGJUZ6J+L6qCtXYMC1J?=
 =?iso-8859-1?Q?UgZ82nBlQb7Y8UNzx/lLOK1A0rvG71URskqmvbUyc6SOMEGeiK1iaR1qAZ?=
 =?iso-8859-1?Q?Z9VUfZ9HuFKm3tYMTwdr7Zel+yr4O1P5SUXlKHVyuHq0tSbi1EugDvZXzU?=
 =?iso-8859-1?Q?1Smq6zVj2f2FCRJNOBgyWY9crGbosjstRvdOo/1tFgDl1X+opEj/EG45Pt?=
 =?iso-8859-1?Q?nGNfJy+7Qw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wp4UC8ayxTLWOIHh/a3uW2cl2aMAYGUlz6aCiJqctera92eRb3YiQgvM9S04ZDFowhPbR/Ge74t/HfVo4BedN2ENK0yuBtfEqoaVvjpR1uwoX3K3cztmuGXeYB4pLUVRMJkr064ITUjqHFCcP0bmX1bsXDsuXio73Vlq2Tx7r8FIt7oLCqdZ39CMcXwP7wnzuDQailN3yI1RroTGNy8m9xJ6c2KMbZb08QPc2u1lk81alA0VG5JuifLr2ISeqn7te8r1RufwmiU/8OW/QI/oPNSYiEflAiElT+I8XWXNgX5kx8jaKWUI22vMggx2H5VlRODyLSTJhua0JaV1Ab7t1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fffaa48-f045-4f38-b6b8-08de9a4ac95d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:25:12.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIKuETC26bCmVwy3NohQILpQVyNJur0wSzmTW2NV4fFCGTXXPBKp63hx89wEE7nk1ptwQCAwnIF+WNQGqj3UeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3034
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 9OliZ7uZPz4tBBBZOfJjVFfytiwiLBFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MiBTYWx0ZWRfX2mETvYHLNRIk
 QXn25iH1gI+TJmesVNPQODyvz166JQ28NUVX0MqjmQvlXuXIg65r2D4bUrTS4ZKrPpLxE2TnQ5q
 k1BJEOjVyz7AEaX4TJZ6QQUiQjv0bHG43xx93JvbR8R6P53iVJd644/eAFWZAyGg5gBdxrAfAuk
 hO8chxh40Ykr3R57NlNFB8jTopRFqNm4ngafZQQNNFDi1EJwtxgiChuMD1TDqHhwnQf7IEzhmds
 kBMQ7ukgWkEx3n9r+/HWkuOw40c2Wnu26Sk9q2MVpz2SZXh2e40Cla0khgB2pmjX/Rzu0vJaRkB
 yWawCqrduVSF9q8KNgddJVIsVLLF2gGA1vBh0V0jh/gwOMKairv8mmvVLvgiCwHvltCUUufj/q5
 aD7McpRwGeSNKlVzRWwJnWh7o9Cl4GWZXq4j5c18nryNEhsV3/cc8nYDYF3rxSVC+2DhfWCz94T
 A+95+iQAngD5EXA5TQA==
X-Authority-Analysis: v=2.4 cv=dLyWXuZb c=1 sm=1 tr=0 ts=69de787d cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=qmpG_aKWHCrghYwzNWEA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 9OliZ7uZPz4tBBBZOfJjVFfytiwiLBFm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140162
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,gmail.com,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237936-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,juniper.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9DB923FD0EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
hisi_ptt_wait_dma_reset_done() discards the return value of=0A=
readl_poll_timeout_atomic(). If the DMA engine does not complete its=0A=
reset within the timeout, hisi_ptt_trace_start() proceeds to start=0A=
tracing regardless.=0A=
=0A=
Return a bool from hisi_ptt_wait_dma_reset_done(), consistent with the=0A=
other wait helpers in this driver. On timeout, log an error, de-assert=0A=
the reset bit, and return -ETIMEDOUT. Move ctrl->started to the=0A=
successful path so a failed start does not leave the trace marked as=0A=
active.=0A=
=0A=
Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for H=
iSilicon PCIe Tune and Trace device")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
  - Return bool for consistency with other wait helpers=0A=
  - Add pci_err() on timeout=0A=
  - De-assert RST before returning on timeout=0A=
  - Move ctrl->started to the successful path=0A=
=0A=
 drivers/hwtracing/ptt/hisi_ptt.c | 20 +++++++++++++-------=0A=
 1 file changed, 13 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_=
ptt.c=0A=
index 94c371c491357..b5d851281fbf0 100644=0A=
--- a/drivers/hwtracing/ptt/hisi_ptt.c=0A=
+++ b/drivers/hwtracing/ptt/hisi_ptt.c=0A=
@@ -171,13 +171,13 @@ static bool hisi_ptt_wait_trace_hw_idle(struct hisi_p=
tt *hisi_ptt)=0A=
 					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);=0A=
 }=0A=
 =0A=
-static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)=0A=
+static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)=0A=
 {=0A=
 	u32 val;=0A=
 =0A=
-	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,=0A=
-				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,=0A=
-				  HISI_PTT_RESET_TIMEOUT_US);=0A=
+	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_ST=
S,=0A=
+					  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,=0A=
+					  HISI_PTT_RESET_TIMEOUT_US);=0A=
 }=0A=
 =0A=
 static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)=0A=
@@ -202,14 +202,18 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi=
_ptt)=0A=
 		return -EBUSY;=0A=
 	}=0A=
 =0A=
-	ctrl->started =3D true;=0A=
-=0A=
 	/* Reset the DMA before start tracing */=0A=
 	val =3D readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 	val |=3D HISI_PTT_TRACE_CTRL_RST;=0A=
 	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 =0A=
-	hisi_ptt_wait_dma_reset_done(hisi_ptt);=0A=
+	if (!hisi_ptt_wait_dma_reset_done(hisi_ptt)) {=0A=
+		pci_err(hisi_ptt->pdev, "timed out waiting for DMA reset\n");=0A=
+		val =3D readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
+		val &=3D ~HISI_PTT_TRACE_CTRL_RST;=0A=
+		writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
+		return -ETIMEDOUT;=0A=
+	}=0A=
 =0A=
 	val =3D readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 	val &=3D ~HISI_PTT_TRACE_CTRL_RST;=0A=
@@ -234,6 +238,8 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_p=
tt)=0A=
 	if (!hisi_ptt->trace_ctrl.is_port)=0A=
 		val |=3D HISI_PTT_TRACE_CTRL_FILTER_MODE;=0A=
 =0A=
+	ctrl->started =3D true;=0A=
+=0A=
 	/* Start the Trace */=0A=
 	val |=3D HISI_PTT_TRACE_CTRL_EN;=0A=
 	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
-- =0A=
2.34.1=0A=
=0A=

