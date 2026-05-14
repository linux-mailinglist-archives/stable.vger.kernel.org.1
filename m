Return-Path: <stable+bounces-247114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CxFByhYBWomVQIAu9opvQ
	(envelope-from <stable+bounces-247114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:05:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C053DD3F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 665393032F4F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3876377018;
	Thu, 14 May 2026 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qdwjdudr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886841F131A;
	Thu, 14 May 2026 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735138; cv=fail; b=oEQxBCEF0dFoNuXFLy2nD0oH+L7jahPnSUHGWHHCSa4F4EMKMGpIVxdtCNcYajme91lqPqVeBKMv5hQQxtb2sm1GaZUjkntsP8RIBOOtQFfxfAY01HrfBJbg00dZ+08TiBzAs926sADJgINMGOnWsI5cbCpt8PgT91VcCi8ZbUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735138; c=relaxed/simple;
	bh=xFgeAN9Ih+tgCfLR9Obkw0UGoc68cFWjeXMp15GQLGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oSkthxudBQuyI4HO8HE352am2m42Sa0lOwFiSyHzejHjBihrtwscnOzLCKVjRyJd9/DqctV//BRPjsU6fCDruRGENgg0003STOyGSkkbuNkEzQZ8Ynwzgvws5XJZxtgy61TVRxhdyr7W/L4mdIg/udwMwkOSyi3PwOQRYVOUVMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Qdwjdudr; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E2Abqp2549951;
	Wed, 13 May 2026 22:05:11 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022123.outbound.protection.outlook.com [40.93.195.123])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e45ybdxfs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 22:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtJupvDgtwmTnZLaxQCVV0O2WxsDVDJ2ab8Mlhyq06WhcVAC1JXqNwrTK0vF41KheXfOIzJRWvPe4a40B6MzV3SmM54QG1nXlssyx4ilvZUVybAN5o/rwAgj9julS2eqgMTE8itjnI9yQOtyol5naLCvIZ6+LgS3SmKC3AeIT5COaDtBk00lPcOyUr98lcRb/Msw9d4tqxX/VYkxC92JnSd8Ody1hDyT5OpSwsHtoMUdm7ZmXKJvuObny9h4tNaDO1yrfBVQl1FsHDNO5WADBmFfZRBTpDuTj/BX9xak7Ywm6QA9XoLeV417tmo4GQuFK8BJY/GAcyAb1nwBK04saA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2USEzmqjNm705s5DFrnzw7ToNq7Tfka3XXDqQlpXfYw=;
 b=w6oY7JWxtI+WtO3XsgoTVi3zYutQJgAi6XlZIWNWZTKI/9q4zcSoy7zm5AkcgphJASWmyOrWbl67IOZwEJbFatBUXyFRrMa6Iwo/aLud2KUpfnmIxvmygC+d/Gjz4YQwZo11SqxKvCuc1Gq32GeLwOBmqop1Xxx/WEkcASI08GsbQJ0eNUP14CROVoxXRgocnX+oIYrRHjf/3Uful7iCg3olf4oXyUNlpmr4Sz8ep2d/zU634+RJohDqLgZHqC0hos60eIb2ILkn1VtzBJ+UvJvLv6XFw1+OwizogRe40sxHn5yK7uWJNUhIVWDerkTi2DscOYMbJnFSCb1ri3WLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2USEzmqjNm705s5DFrnzw7ToNq7Tfka3XXDqQlpXfYw=;
 b=Qdwjdudrz0ZJq8tiMx1C3+G9QQMOwvmNCXzAzwR0IFzXJmHEcavlTmLshBb+fy/TEF+d9EQLRcxDG37Ih/Gy9utcqGvH/pYPNBOGsGcwC6e3FfJ4jp0zfnmsgMCUNnteIFkrkAbtJ254p7eAqZW0uISZA7kOgPXRkLYQKDcrcdY=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM4PR18MB4286.namprd18.prod.outlook.com (2603:10b6:5:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:05:09 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%2]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:05:09 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>
CC: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Zilin Guan <zilin@seu.edu.cn>
Subject: RE: [EXTERNAL] [PATCH net] octeontx2-pf: fix double free in
 rvu_rep_rsrc_init()
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-pf: fix double free in
 rvu_rep_rsrc_init()
Thread-Index: AQHc4ushn8dBz/8/rUmwOej9Ijr3KLYM9LGA
Date: Thu, 14 May 2026 05:05:08 +0000
Message-ID:
 <CH0PR18MB43393E20888A207F4E3E90CDCD072@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM4PR18MB4286:EE_
x-ms-office365-filtering-correlation-id: 4ae7db8c-7375-4e57-ab32-08deb1765ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|38070700021|11063799003;
x-microsoft-antispam-message-info:
 qCvgQF/b1qK5WQxI81tOva0g0Q1E1GxOu9HfnWu2Dx6rMs38tmQW3sVfrYhXw9yFTu6QECuoBzGVTwCtANSeg32OgweAMaHGR1FvOXpHALcJfBPMADMFCkH0QQHotEjWw7H+QSI+x+U787bVJmoYjN6aFjjgq/LwwL6fremrNMLlnZqAG95RmBzaPkD5n9jrmDlveH5W8Rfdu8ZPI+rdHCZZ4fdB+zQFugx07b95l5zxjlrqhEcBFLLuxGUzfh0ft8COrV8ldB5MOW0Jc0JmjgCLNsBP2nEd1PKualqtmIx19Gbyjpn1LV/w4+FJcDSqSt692W0DFt+7ixM6fpqWd9/ctiRDvKb5LgrGKByfJCfu5qJdlJEzmWVHdWCokuqA94PbZ69sXbx0zFHCp0e9I38IUJ3V7BBV83bsYJbXM5TZUlYFtVicoaJ6KbJNexE4i71kvjNHVlnidtJUMwu3B2zFiQobLNE+u3o3tEFd+s6M5ji29Xhhsgp6bxJxqe+5RUZ2JbNRjPgn4l52lCZCZYstvmuHLg3zUC8oCuYm9NuN+SUspXow39xz53AQlKIL4IxeLROv+e0jO1zRUz4M0Pq5eujYozXIttuCRT1SQYgmm1JM2DhpLDJ+vFJWop9InmqSn7tkfjgjxRAfLFxB/w6TnDv2gYXguR6B4C8o3PD8wjM9BKPP6/sWpa3W7gMdhCscaY03oZ4Xsm5LHYrw3jlHjEz93U/iwc36aP8C2Z8irOqtArmnaBNbhSyTqYYe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(11063799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6TNxPlfkJka576jPLV3Z53iyhSqAqFS7qX21LWh0C0k2Bc9C/F67gWg5Cb9Z?=
 =?us-ascii?Q?nvbG8vdJQBF5fpNcYjthCy4EP24LqtoUWPB7RxbL1ICrEcNereTKoZNmI3S4?=
 =?us-ascii?Q?XlsmVetPi8EEzwaespo+HAnCevcForR/42l3u7jRVq9v9p6J1mfKwDRAgZH6?=
 =?us-ascii?Q?uvJyabeqMztehxZfrVWZSgtnVScYR36cismaBq2eOmuMFn6nEOzsAdTV/gtg?=
 =?us-ascii?Q?dBA1yPWBVsHNzoA10K01jmraR8y/kOkzBArnR99BcUyL9WJaZ9wJFI2kg1Hv?=
 =?us-ascii?Q?o9YW1hBm+cZyZNYlAmrgks6fz2QZDRjccVJGQ41Z0F42JFUUPUhGgR+jlvbU?=
 =?us-ascii?Q?c9H+724TavjcS+0BQu5Fh6RmWUP05s6D4Qb2XAT32UrjwMljC5P5cTnnLNXi?=
 =?us-ascii?Q?VPX2absSdfPN9vJFhVDJ5p5GkIvOse9LVmFFY3/pIHBw8ItjRVcf/Bw4kPhJ?=
 =?us-ascii?Q?adcDxGyT9qvNLSXRyFoamFXUf4uuHgum838RkYmBazgDFbNy/Zg5HqeKO0pl?=
 =?us-ascii?Q?qEcchlg7SDVy0tzK2X1+cQymOHfUSaL6pgHkibHI1oJThlgdY8kr/YWSJsn6?=
 =?us-ascii?Q?ajxgOctP4X0n9VILGCcC+3cIYsdhXfVwWGXGe2s36wAOSo4QmwqoNLE5Bfme?=
 =?us-ascii?Q?Ye/mFhsYi+Nj/nUlKWjTCqqyhdJkrOeUo6S17wGUTAbA2j/7IAZYW1qhyyCT?=
 =?us-ascii?Q?P8oZlIzImXvx6k29YoHN6GYZ7gQtOxwajmlZC4r98p+gngK3ZOJ4phPiIoW2?=
 =?us-ascii?Q?KNAxDdQGsL0Rlt2cPHiDsbsILuF8qGgEni0rk7z7H4uKFg7QLhLSyXJc7k2H?=
 =?us-ascii?Q?uBgcv8A9rcSYeJm4gxq8SUnQMnmlcIGKyEar2DybHLDQZsGaMjskZ+DCpkIp?=
 =?us-ascii?Q?aWMTHaODBPhCH9x0xS6wOOzXmuNdS1K47QFnDrKwFOkXLxpSXNfg6wJDG7AM?=
 =?us-ascii?Q?0i3ZVxCEysuY6h0M1Yt5NjJ+iWbG6tsTpoRDVjU47wqxwgyA6f1NeFCoWSJ1?=
 =?us-ascii?Q?IrrCLUuehRXOjNi7hAHNb4fMXB6Vt26nfUKc62LZ8gVzfjubzYt1a7ijSEvg?=
 =?us-ascii?Q?xwkbS07+M0+7pQiPPNoqCRNjCH/vrOXGNHk/Y8VX/a2xGWvT3g7ZBGEhmkja?=
 =?us-ascii?Q?ygXRnICVLGlesPVIBHmReLm08QNzFTQ0flZjKN6PKhhAo9u5Wes/72e4Ic93?=
 =?us-ascii?Q?SPiCS3betpRZPLYrlFaX3Z7WVkH4p+CQQp18ymw/WU8rGHd/spr3AOrfH/hj?=
 =?us-ascii?Q?pbAUBsp70m4LrWVYmhJa/LVrhdE03hNLmRMDnlxdcg8bIwQGQhIaLdDlBcd7?=
 =?us-ascii?Q?tX4n/MLOqThmHV4dLgY5zqoiTtihx5DvjFYcIWWSZ1IuUz1GWSVYd4H78Vk9?=
 =?us-ascii?Q?e4LujwfNd1rk+eg+sdjEpzEffy5UdI3obZdfLrXrNiFb5JjnGHzJg8nKOtk2?=
 =?us-ascii?Q?v7DNwG/vD44tdefrnvWtQYt+CRE7d0fafLxM0v78p9I5jGD+91dwyQfZKXCU?=
 =?us-ascii?Q?/IZfiTG2tDVF/mGtKN5NC87jtNHu25Uxzaq1iLXVHnsa1z7STcPbZbK+veZ9?=
 =?us-ascii?Q?j3iFzliJHMbQ3MUKsr2R6w066Abt2zcJk+eLOhEbNG3wwR79mUIOFYAZwUVq?=
 =?us-ascii?Q?nPETx3I/Ly7m/wFMXrWQNCM8aNMqD8JtG/ErK3DzvtRvaHgafbdIM8sVrXlF?=
 =?us-ascii?Q?ag6qTbEhiPGpQCUpuqdjsTImt60bnMYU+62nS5WwyngXbgut?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PrabkQTGJb71MmcDq62AUPGk9Te3IrA4U1pkQjvG5mWZUPrZWueCBnfGHR/sHLiLHwKDJ40VQ9c+4LnpWGF7yHm1Q4FvKUqslwQlISnJQw2OCdTmErH5zmW+Symta/vQa/ArHbRcvmlmoi23FH88ZFfGgTqOohz9LdfqsfypsvsZCSHGV1vmOmf241tvgEvokAKsTVt74Vhiw0ppyfx0qBjkwmnYCJJ1HgBlKrr04D0xXsWhXsW1W1PPsKvHquFpgE/7YeilZxsqF7LWsWcwdhG5NOSEOdat3YpzNOk1DREICpET8reZmtBKbsQdlp3jS4IcZigxN+Evtmzi9DMEjw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae7db8c-7375-4e57-ab32-08deb1765ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 05:05:08.9549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHNmJyyU5eHqWB6+m3v6yo/N216r4VijPtsH+RrJwkSyGbyWgCzOQZ1FkCNPxcaDKLNvQgqSHa2vfi9rGkVRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4286
X-Proofpoint-GUID: OR8KFgLes0A_YCslJ8z9RZEY9Yqb9ibg
X-Proofpoint-ORIG-GUID: OR8KFgLes0A_YCslJ8z9RZEY9Yqb9ibg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0OCBTYWx0ZWRfXwf48F5hIquuC
 78+Asz63p6FXfvdZpOCVSyErOcP3gaLHeNBpez4gp/bCGyM1vZuDGmQf6HEkn33TLQW9AMfZ6Qb
 ggRk6s8zsL5ZJkvSMkk1l6k3D/9uS4Rvz+p+wEko6qJWRbKtBYmlVukDrPAIbPiAiZkgEBpHCXG
 BLNFIo186wr3fXgNSmddIbVUKYGsS4G3vO1ZhsXh4jBySsn08qOAX28XrA6lIFgsbOyV+Kaq53o
 1CS/7JCzt68HdVruLzGa3P73V60dEVxJbYWm7CUVyV0dDUVFEZhv4IHVC8yxK0ND9SSLpkbL0K0
 d+izfkfP8HDPSUWCGnfpin1iHHeTWj8RwwH9V8f72xEdSYSHDHKiOHWcVE9hfuvqOsxGY6G/Mrz
 AzkgS4Tl0o0fLK7AwwqEypZmxESk0y6IUdArpcV1tUy9bDS4UR8ArfoN3Xv78YpzQ14X0tywaCk
 +d5OgNigHbspcZbbpBQ==
X-Authority-Analysis: v=2.4 cv=ZtTd7d7G c=1 sm=1 tr=0 ts=6a055807 cx=c_pps
 a=ZllXB5KXBtO1w8B7B7qn8g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=nbfCV3fgA0K4_cTL3XUA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: AF9C053DD3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247114-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,seu.edu.cn:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gakula@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


>-----Original Message-----
>From: Dawei Feng <dawei.feng@seu.edu.cn>
>Sent: Wednesday, May 13, 2026 8:43 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>Cc: Geethasowjanya Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Bharat
>Bhushan <bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
>davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>jianhao.xu@seu.edu.cn; Dawei Feng <dawei.feng@seu.edu.cn>;
>stable@vger.kernel.org; Zilin Guan <zilin@seu.edu.cn>
>Subject: [EXTERNAL] [PATCH net] octeontx2-pf: fix double free in
>rvu_rep_rsrc_init()
>
>rvu_rep_rsrc_init() allocates queue memory before calling
>otx2_init_hw_resources(). When hardware resource setup fails,
>otx2_init_hw_resources() already unwinds the partially initialized SQ, CQ,=
 and
>aura state before returning an error. The representor error path then call=
s
>otx2_free_hw_resources() again and can free the same resources a second
>time.
>
>Fix this by splitting the cleanup labels so that a failure from
>otx2_init_hw_resources() only releases queue memory. Keep the
>otx2_free_hw_resources() call for failures that happen after hardware reso=
urce
>initialization completed successfully.
>
>The bug was first flagged by an experimental analysis tool we are developi=
ng
>for kernel memory-management bugs while analyzing v6.13-rc1. The tool is
>still under development and is not yet publicly available. Manual inspecti=
on
>confirms that the bug is still present in v7.1-rc3.
>
>Runtime validation was not performed because reproducing this path require=
s
>OcteonTX2 representor hardware.
>
>Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")
>Cc: stable@vger.kernel.org # v6.13+
>Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
>---
> drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>index 94f155ffb17f..0f5d5642d3f7 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>@@ -609,7 +609,7 @@ static int rvu_rep_rsrc_init(struct otx2_nic *priv)
>
> 	err =3D otx2_init_hw_resources(priv);
> 	if (err)
>-		goto err_free_rsrc;
>+		goto err_free_mem;
>
> 	/* Set maximum frame size allowed in HW */
> 	err =3D otx2_hw_set_mtu(priv, priv->hw.max_mtu); @@ -621,6 +621,7
>@@ static int rvu_rep_rsrc_init(struct otx2_nic *priv)
>
> err_free_rsrc:
> 	otx2_free_hw_resources(priv);
>+err_free_mem:
> 	otx2_free_queue_mem(qset);
> 	return err;
> }
>--
>2.34.1
Reviewed-by: Geetha sowjanya <gakula@marvell.com>

Thanks,
Geetha.

