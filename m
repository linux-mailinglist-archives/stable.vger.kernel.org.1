Return-Path: <stable+bounces-100544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC89EC690
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAD0280D3E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9C1C5F22;
	Wed, 11 Dec 2024 08:08:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A278F40
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904503; cv=fail; b=s93fX+W7e6dkZdDh+TSKpTMqME/Fr9laoH1GUDj7IE2El6KrHcU6LXVMri19gqAh5BpX/RTLL5Vjvz0Y1yYLKeOwSWC3zOBbadhYoC9g44A2NqVHbN+4sY7lu4Pa6nrR9J1jwEw9b+sFkzMWRh/xZmTdigNYJtsFfJjpIR/SiSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904503; c=relaxed/simple;
	bh=kgtr6bdnE0j+8cQpto9Ed940dwyxqUIuu222vwJa9Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h9GMfyItYUIcBVGjn7CVCMPgRvF6G8NW6I0c75WRty4Rl1nnXrB14CNzLnYlVNDJhcaX2Pw8/N8VWPqp2Jq5GWk+iqGWKjM784ZcVyCiznmkCMaKLqlORqgdFc/MaZVARdCF+7qFDDhN1DwQJ0ZphljrDbfokL2+tAl27/XiD88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5CHpn023873;
	Wed, 11 Dec 2024 00:08:20 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1ux4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 00:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge8cecBy+9i5XezUUEwnb3GqxP9KP9JD6wbRgt7dr606/pqbxb7ewDuqSJAXWs5TojhL+Q4A7K+weDo8Xqo6X84R/9rfnrfmtb3BX+BQgMP7pPF2lKWMDBv3TiOM1zMGWFZFUiac47uMIppGJT33l4qk+Caybe2Pl72y2v1ueyFmmzO48UV3mI0Kl0XhrbIRiy9Uzy7K9WyTrmpflD5T//CotdkW/nK6ZD2l+snk9/M6S4bJ3q5JEAHs+268y1tV7h2WRDczt7ZUNtDVKKTl7zZggpeHb5PPv0kPged9ULynj7TEhapd9tPlgCkMUUfMrQ2hitlWROA63Xzg1mULog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgtr6bdnE0j+8cQpto9Ed940dwyxqUIuu222vwJa9Ac=;
 b=Nr3ZVu1H34FQ2zJp5NfwC7ozXQ4H3BZ69AOamxVlXqVb9U7EbZBSdvqYRx1Whao5v5ruyay4NieqNpDR3LI7sKbrdPKwBx3S3sbAe00QiobJU0aRIdwo5i++IoQc4XzCvbCz411c2CGChCL15j9+ZR9tFei1N8OpG+4+hSmXwu4kGSbGY9EgrOymCdPeVsM1jGUyDrJBF/6V/JbIeP+PIR3XeSMoGpZ0+vfPDsgusfhvwsMZ3GhWhuc3ixRa80/DURfa3F7oXMhaVd83oSFHtG801qzOOyD4DHObPRjWZXCpU/E2BNgNj97sZcqvIjDD5edpfSSUxXuOn41E0NvfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 08:08:14 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:08:14 +0000
From: "Chen, Libo (CN)" <Libo.Chen.CN@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 5.15] crypto: hisilicon/qm - inject error before stopping
 queue
Thread-Topic: [PATCH 5.15] crypto: hisilicon/qm - inject error before stopping
 queue
Thread-Index: AQHbS43Kujq+bmvEzUuqDezvxBp01bLgnySAgAARRvA=
Date: Wed, 11 Dec 2024 08:08:14 +0000
Message-ID:
 <BN9PR11MB5354C14DE8EE6DCC3FBFD4F7DE3E2@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <20241211052959.4171186-1-libo.chen.cn@eng.windriver.com>
 <2024121131-huddling-selective-f114@gregkh>
In-Reply-To: <2024121131-huddling-selective-f114@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|PH7PR11MB7430:EE_
x-ms-office365-filtering-correlation-id: 7f818c11-f3ee-42ff-9795-08dd19baf667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ls7yzFWD0fEeH/cljTOTojGsdzKcCyjcoornkf3lk+uNFAtMCGwD1hHOy5y8?=
 =?us-ascii?Q?XHwbj1Jw3jAtlCx8+TfjPyPuf+qb7fG8Jvl5u7bHEgkn+4d0UztXmiqzO5pv?=
 =?us-ascii?Q?sDxUEy5e4HcFRvMT3RBbO7f9HdViuKT9Ohnxp94pcJ5J2Ib75ZQNbNmLkWOR?=
 =?us-ascii?Q?mxjiHeyHWZIcw/8TCxC1UwcxV+nWZwfxbGf6fPZLNzA6c2xTBawIQO2UUIbv?=
 =?us-ascii?Q?lyFAuRrZh2iPHlKZM998oX8R6FDoryStBBu1vq40YBYgKnOk49IKk3Qd6k1I?=
 =?us-ascii?Q?0PDhva/68L4cgyp0uQmkkGYGPmUic2g4TdpWYtQT9STdDxsTVhU4WE4Meivb?=
 =?us-ascii?Q?JuEYYT+XWa6UpCuc2GEZxXsIj6/9Lqmxu7fdct4DBTAxuz3u/V0334NftLbT?=
 =?us-ascii?Q?c7ZiDpG2AkKGs+bCvZlmGy5QkZM5g45U6rmknAE9v7xKx71ulctsd9+JM9uF?=
 =?us-ascii?Q?5ZGYeqTQd9CcCrIPccTwbavlGOMRP+yC34MA3Rwu0KTq6tWMppQgffJuZ87g?=
 =?us-ascii?Q?tH9uWHFQTkPQZ6pMznZ2pw3WTA6YiOxyGxUwPHFqsSuFUXd+8Fyt41lM3WAv?=
 =?us-ascii?Q?39NJ+DWEWQRVEgbRxsw+qV+FVv3EppFx8GgrHHqNs1uDjgD+AaQqsnhnFUh+?=
 =?us-ascii?Q?1hsXJo6Nyb7/21nij9QXu2qtJ3Chysf+t4dOKwg5ujGXuYPRVaSvAiuBOI+p?=
 =?us-ascii?Q?hCZFTev6sze3frnzvDw+3tWAM1Nn2sfsVzv850jIobsIGETT9nBZRHU8XLdS?=
 =?us-ascii?Q?4zJgohxH066++phHa/VgSEB8zKhSg3VORfixzpTT8hS7qv33gjg1mS2Rowf0?=
 =?us-ascii?Q?g66T/W88xUCKJ8k8eThXiio+Eq/wnPSccRNa1JNwZLVweN2OnfaHy80GUgTH?=
 =?us-ascii?Q?c5QGNtWNFpi3j5zevGDVBHsHBi3ZuzXiyycQCRyLmO+yD+wEN5FXuunr1ily?=
 =?us-ascii?Q?sfmVd+V2i8XYSGghIlDlFe3jhMjOeg4f7RyRPdz9eGGcQDK/Z/v02H2FirAy?=
 =?us-ascii?Q?+Nfvw/5BUgNof9UChlLet8S38YJavzjqe8l0GcV53ot+lJGxWQouYMb6eM7r?=
 =?us-ascii?Q?krPYE1cVLknus/q5FE17PTZFQj2vELDeSEYVffEgX3FihbhtcXwGSZxl4INi?=
 =?us-ascii?Q?aa5a0gisItRtbNdEDkavIA5Kc1jj8vqYvHm6qcBhWIlStcK1FKiFlA/vWElr?=
 =?us-ascii?Q?3ye+QvRYANtqPipfbEqXq+0mS3R5Hwqh9jC7oB2p6MOfup7votf4V+YwYQaX?=
 =?us-ascii?Q?lkug01Xnlc7h/AHLzZW3I3tGUbtvtx7X1y8t/srN8AupVbxKRqNFEmMDAAl0?=
 =?us-ascii?Q?LZDCVx8qy2Gl4zjV31hr0bxujpngWW4iziS8MGTZDx1CqS1PJ733YBgSkz+B?=
 =?us-ascii?Q?4p/h5z5XMb6PWz/1UICqey8Bof+ekwzKNc2Em+P18kGjeXobhQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C9yltapLjsFgnvO0d7CJy2uvjLQYqLt0uhaTQiEG29MwsR90UDUH7o6jHxMk?=
 =?us-ascii?Q?zKD7R3ucpm1zF7rb0Jb5ZVpeXmpNxqKoPaWy+enToD1Tj3LBozBM5o8p4agL?=
 =?us-ascii?Q?84ljO72f6DTsvZdS1YUrIorQRVbI6QdPxJy9ZZs8jPsAdCujrso3qEAT+p0D?=
 =?us-ascii?Q?znfYzFWSITENT/em4BKixb0pj3Bf3x35/ZnVagbD3Zbomqgn7qyA+A3oAxTr?=
 =?us-ascii?Q?Y/hMndw2K4DSm7ENLk6Trh+dHEogN1sXoYAsnajytwFULork4WMS0896ZA0S?=
 =?us-ascii?Q?4UEWCdjwXNcUnnKq6Tp2GP4IMmSS170a3Zk5t75ptQsb47Z7Gr5B8AEoJOvQ?=
 =?us-ascii?Q?wD9g1wj8xbhOklJ5xOO0Sv/eBEGfm2D0d6AJBF02/QRYzW4AIGmpVCqKx9i9?=
 =?us-ascii?Q?hqsq4tr5MkvELc+R4kth9tQ7w0bzfQiMSpii5wigj7fDzVD/tmpJc3EW+vON?=
 =?us-ascii?Q?AKYt2AjEXgIpWPsdC7Kjo6keYpjE0D4jEhXGSc0+3IlnRH1wOlTlNJvc349l?=
 =?us-ascii?Q?mFRHWsd6lV5xlpaH0yJALJol1A546soXdUSQEvNCR6Ese9cn9u5lObPfv2TM?=
 =?us-ascii?Q?tHXd9kvGzNcctZwYQ2HZj8iFIDh6Hrl0FGs6/z62KzUdwohMkFWzMVDxM4YR?=
 =?us-ascii?Q?It+il86VEyUlXGdygWDFySr/k6QaZQ2yVfGC8PIemDbxnTFPVZQIuQom9rCY?=
 =?us-ascii?Q?xCd0xr9LQU+6ckHWL1T7iRaa9oMbkSRFh3Mj3urNHK1sksAsA3H3ToCO8fNk?=
 =?us-ascii?Q?PevBVfmAIxWXn5u93YacvABVXkSzkAK9bkkWa4lGjwkYYNad0xOEG4zfVDYj?=
 =?us-ascii?Q?MfycgYlq84lh3074C81bsneQl2pgrosfllo2mw8HsNvfIx3qscwFFlrpdmaA?=
 =?us-ascii?Q?DyqvFuuXC1ZaOHlMHC9qXflYoEDBcNrP4T03PQ1E4uxXjZ2Xdp5I/Ska0rQK?=
 =?us-ascii?Q?JPqM0qI5p1JytTIOMPkZJ/nLAtWSHmsCpe/Xkpzm7A1jEODmnmmeVNTfBnHd?=
 =?us-ascii?Q?7IpszimjJ9pQ+a9VRFSdBKD10fYGACNluND4LHlP/GlMvHb0EtbtiaXrIcIt?=
 =?us-ascii?Q?BwBAPEdiY4Z6q3ro828Vrw04ITYMtTEvN4Io9/4OxzWR0indT24eTXpmV5Tp?=
 =?us-ascii?Q?kap/xaZHXfKGOjBt7kipLNI2ui74flZhxW1+AMzymq/Q0dyT+X6Js9vGU4xE?=
 =?us-ascii?Q?wiidgQI7bPV5N6QEh2AcDw+NmsXCFxQD/lZtus4F+8sga0Xv0XJlrLtOQxoP?=
 =?us-ascii?Q?q9XlE+NAJmc97Bdwgl556R7NWwkgUEjNHIIywYnhCBFxZzLW6TqoaeZDKcv7?=
 =?us-ascii?Q?H/n7ktaM2quPe9P95KjaYyMhaDHaoYBHAkaZu/AV9Yp3mvjpbzdqpV7ZSNQe?=
 =?us-ascii?Q?xlECe5bBrAoLOFvudk7aYwuEn6yzH1VpBnIfqUDh5jgOt0zG8X0zTAcFTAJ+?=
 =?us-ascii?Q?ICc0ljZsmJ73+3S5ej0kgg6i0I68npVlh7Ov93XsWz2fhf3bRBYGl+ISbf4g?=
 =?us-ascii?Q?qRZAM+ED1fIPOeU0HT3Fqw6SUXyr2SjDrxbRCfTorz4aAjjlcohroUO+Rj34?=
 =?us-ascii?Q?qjW3eGpzGrVDojORFLf4eNjTLS7i82IMwXPYledI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f818c11-f3ee-42ff-9795-08dd19baf667
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:08:14.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUM3/ZVB/1Z/XEwQ+ePsT/Oo3/3LwFkTFX6BNGhyWAf5M/MKLcjaJ5U7gOUOX5h9ylciqV412pLHwcmUvzAdhiVAHe3xwwQIePkiotbWhzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-Proofpoint-ORIG-GUID: Zf2h4EHxk0Qjul3Sv49inp9eynTGvyuc
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=67594873 cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=ktOyJPztaX449sVuNHoA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Zf2h4EHxk0Qjul3Sv49inp9eynTGvyuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=889 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110061

Greg,

Thanks for your comments. I will send V2 patch soon.

Libo

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Wednesday, December 11, 2024 3:06 PM
To: Chen, Libo (CN) <Libo.Chen.CN@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15] crypto: hisilicon/qm - inject error before stoppi=
ng queue

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Wed, Dec 11, 2024 at 01:29:59PM +0800, libo.chen.cn@eng.windriver.com wr=
ote:
> From: Weili Qian <qianweili@huawei.com>
>
> [ Upstream commit b04f06fc0243600665b3b50253869533b7938468 ]

<snip>

Why are you not also cc:ing all of the people involved in these commits whe=
n sending backports?

Please fix this up for all of these and resend.

thanks,

greg k-h

