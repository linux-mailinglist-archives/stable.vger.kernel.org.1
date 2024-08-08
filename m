Return-Path: <stable+bounces-66019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A594BA38
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 11:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F302818A9
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8DC18A926;
	Thu,  8 Aug 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b="oa9bdbw2"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2121.outbound.protection.outlook.com [40.107.22.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED79189F48;
	Thu,  8 Aug 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111035; cv=fail; b=r6MA37mIdQWYL1sp3Jmgwzi7rynP9l1swLeK8HkJy23wBM1VP+SyR35Xh4+AY+J6+8/OHlIdTOx7oyo4Wbe0eB7bIiJf3SXbGqrhS4AdG0VXmMvqnQZT9NKTssOtdRG8qAqAxOozkPbAx9Kpu33q74NL4132cH1d4TzVdan2v0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111035; c=relaxed/simple;
	bh=dui1uI01MyuKkCKLWiRbpHcndLwCO1JmAEenEfbE4Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gBZR0ZjIeLLPnmv0woOEG6qUq7YRIRdcKaaYt1NzbBJImmFSYxR6cag3vQxoNbI1d/xeJDJyF1juaXdo+n4edkmAUyUAFLfToqJ0wHzUzCemQrTgwRSUiu8zb8pPUJUn54PhbT02a80MWxHIqcFiA/qiVcmVWilaZCGCWYS0784=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com; spf=pass smtp.mailfrom=cloudbasesolutions.com; dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b=oa9bdbw2; arc=fail smtp.client-ip=40.107.22.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbasesolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c84rsth+xOBSBM1bG/+Zg37CRM3uBUQpRMYM5DX+Y+4vnh5BeQfgOqcD2wxPPu+l17PcqVm/Drkyix1hNsmnf9YuMTHorfuEuawQSx5XmiLX9Q0EEgOl5m7gc5S7/cn8eoi+xzuz6bB9GoUomp3q3aCl6Xpn2/7I6nr478cJcnoT3xs1S6r14CPG/hjnx9CLEb16Uh/899p7HfANNHHa6y3BuIarwnsUYml1M6HKdVXCrirBLJSWTY9f15RVXKouOnjbbpTT+HviQcioNINN5BLcDLNWMbS8xz3oFNAc2uP+aTOgZ+ynHTJyB8fmbvO2MVMW7BOlhZ207qCmRmasQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgxMkgFC0+7N8rgdzOs9I97ZLrZJcriYLaboXrjMW00=;
 b=daoVFgvzR+YYzWF3bota4mOTARIAsa1I+9ws37g5RcOmr9lr9MVmkbtv3KMPYu7gSt/geIramZkvoaEuW1onZYxNMHHpKMT4OKM5sOGwgbNJZWNIgEal5ulEHQxN7Q6AUJ7bFP/TcDkAlgMl1M/PzCOIT60ZHNyhaxbuckQnBvm4kqU3LXzu0R1xeRSJ+htOX+oGY7PMnytk0cmBhcxq8H0cg/p/DUqpt9T6EtlvWZYcF5bs62weate+F2TI9wD/Qn4M7vzt8dmVKEOiZn95Oq9SHZ4YfF3kDgGl8nNNh5XB7zifiRHYz5/ShfM7AkSOtsz/XYRG6aNzSFoJdUBhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cloudbasesolutions.com; dmarc=pass action=none
 header.from=cloudbasesolutions.com; dkim=pass
 header.d=cloudbasesolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudbasesolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgxMkgFC0+7N8rgdzOs9I97ZLrZJcriYLaboXrjMW00=;
 b=oa9bdbw2XHHnaln0CUjLVRdLQlH1jJ4cmreHZyqe52CPFCumwBXlIn63cfqpnet+B8NterguxMqhX8KYniLOE9HS/nkOg+/3OZgmeIxlOCR0p0L/GVoh0eyTKsfNyWWMeucbO/CBqd8/1h91gsdJUxxlZPF3Ydw5NbA28UtKGxo=
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com (2603:10a6:102:17e::10)
 by AS2PR09MB6632.eurprd09.prod.outlook.com (2603:10a6:20b:591::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Thu, 8 Aug
 2024 09:57:08 +0000
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc]) by PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc%7]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 09:57:08 +0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: Christian Heusel <christian@heusel.eu>, Greg KH
	<gregkh@linuxfoundation.org>
CC: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "arefev@swemel.ru"
	<arefev@swemel.ru>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "willemb@google.com" <willemb@google.com>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Topic: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Index: AQHa535pYp3Bo+hqVUSg9rCQdbX3j7Ib2KaAgABJUwCAAMoxAIAANjkAgAAAN/E=
Date: Thu, 8 Aug 2024 09:57:08 +0000
Message-ID:
 <PR3PR09MB54117A0827E6A7A9B7D7D1B0B0B92@PR3PR09MB5411.eurprd09.prod.outlook.com>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
In-Reply-To: <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cloudbasesolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR09MB5411:EE_|AS2PR09MB6632:EE_
x-ms-office365-filtering-correlation-id: 45fae9ab-1ad5-4773-7c7b-08dcb790773d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dM57AS1XH+WSb2UgiK4fJsNHxfC5pmP3zEw9o6WwH9YZMXvTX2Uf5+lYI1?=
 =?iso-8859-1?Q?mQryEyFT06vA38jC9EtdSHZMldHm/U0aqoU/SAnABfxL37shCw90nQfFEB?=
 =?iso-8859-1?Q?NTmThbJZhJznmByu/yxLNvBK084bDt1MpTZEehy4bfH/v6+4ETd+b8PCm+?=
 =?iso-8859-1?Q?b5gwXK/8YZY/Hc8pJG0FaNQKCgwLqYmrAkZRHBxNGrsSDjq/j/z6EefrVM?=
 =?iso-8859-1?Q?nPxknIfsM7aFGpnXzekh23lJh0FV4pydVyndjmjSwKMcq4NArn6aaJdRcg?=
 =?iso-8859-1?Q?jlpDVtvnp/GOSxLInmL2QJdSwDF4OREEAZeDCfJs++szCTaCNrrOWxGYyY?=
 =?iso-8859-1?Q?Vwii2ticMUPj25+h2fvNzd7Rsgqxj7ID+xr0I5RBVy0jQVcotTf1eg71sX?=
 =?iso-8859-1?Q?EOC/kQxESki7QWWbn60t+kWqWfM97cIeP6E80eQGnQcMMmb1JaYH1w7uob?=
 =?iso-8859-1?Q?L+8NaqgVXaGR5l70VxAmfaHfZde2hB+9wADnOqKxzAKrbUCLNf1w4QgQVV?=
 =?iso-8859-1?Q?qCsH/g+A2oQP92xKW0GnAjeZW1YekG1zd7ju1ltg/k6tRS5okXqEsl8pz7?=
 =?iso-8859-1?Q?wa2+C6vgtsx0VfDc4dXF52j85zguOn3cefppufWJNfZRYDHkJAfzVtJg3O?=
 =?iso-8859-1?Q?d6DKb39SFpzR/pIPGiaz1v0jqfaLRp+P1DTyT7U3CkUOQu/N4ONmnDngC3?=
 =?iso-8859-1?Q?+5Wbtie5M9nGYEAl2+2t95rNaAxzAr6JdBOhP4BwrEO5u4VqnQWdyHG9r2?=
 =?iso-8859-1?Q?Oyy83JNa+CSaGvTFdvj5MRkseOjLzLPCsXSz37eilKMVZ9Gu9rXQ9tnLIl?=
 =?iso-8859-1?Q?KM4d/cgBAr66/AbrZ38kMKhkfFPNz4E4pSKSUy5HjY2/j4JE4ABk5mxuDw?=
 =?iso-8859-1?Q?kuiIZySxsS7tjwg6u6cRtriUQzx6YLHyc2I5cjA+6lNEqId8se8UkBI6m2?=
 =?iso-8859-1?Q?QtPjI+Adacd3qM2GlhOkF0RGajL1G9LSIWK/NXRJqqE1sNcIwB4PhsfuUU?=
 =?iso-8859-1?Q?9IGPTgQqsFcvmWxTS6U/IsOfxP12MVWezfWuR+8X8aoIwNNFjI3wSBG+w/?=
 =?iso-8859-1?Q?QcHQH/M8F+xSRCDS46RdFAHr6lufwelhUvUiZg4zhMM1KfHqDvAwXaSWdJ?=
 =?iso-8859-1?Q?LKvnPIlRfYKCD3BIGYQKogJxnIdoBLdUz99qEWSAr8BDaHHaHftp4t2deP?=
 =?iso-8859-1?Q?x/lnHtfK7nMpFscTAzL8UChFnswqpgVj/klQYr6BtK4o53YSB1S7l57KTr?=
 =?iso-8859-1?Q?+pvFbbt1shttiYVZBU05Jp5VTNEFO741STAq+m4dGckx5xnb8LHcJy/RJa?=
 =?iso-8859-1?Q?cUlQz39b789DcF22k2KnRurAfSEbW8Ei4q6d3zswicDEE8OBckl2QO3Zni?=
 =?iso-8859-1?Q?lTrxJcro/kL0HtM31qqoVkOe+6gb1g9WVr0HP4sR26TlLBXPtjUgo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR09MB5411.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?V1Q8ngeIaitER+J/X3COeAU8mYixPCNonaKND3sP4OGe0P2Hb7dgfQrI2o?=
 =?iso-8859-1?Q?B98hUkO+H5jYi10efGOGlRlcxKR+/yTpDqhbAPpZG3pl6XmIoirMmmlg2I?=
 =?iso-8859-1?Q?LhUhHiCbea4YXnIsNoty4pEVhyuTbNtEr6FGajoWcynp/XLPxHzQQU1N5V?=
 =?iso-8859-1?Q?HN8vtC5VPu+TCLNp5VYvVPcoJNxDSVch4EfTIk6EPocTy1k00GWT1Ixghe?=
 =?iso-8859-1?Q?s+DS+WOlu5SRR4H1LZfQcPakWF09ynqbaK8WauJRGd5OrefL12BF8jw1m+?=
 =?iso-8859-1?Q?A66hWko7F51Ek/VW44lseIW4H2pQryUAf81hZ7QxPawfA3F+JPWb9+ZiA5?=
 =?iso-8859-1?Q?Dm9529t+4d2EAo4zJbCu6RDKm8ot2TqmSY2+WZ7XbW/uMLzKrFsz2y9r3N?=
 =?iso-8859-1?Q?JJAfI0mJtitjN04hW2CnDMWoYRr1itvhDfHMwpH/2uXibxusJfxjWE3jeq?=
 =?iso-8859-1?Q?rDyYkkvzxDVNaH1pn7ubYs3Ina0Tv9WTPZRhrZPdm92r95V7tV9amYwFct?=
 =?iso-8859-1?Q?g4MPYo21Uc19OgUUDzRJQICQ9DZFy2Buh+HxfC/k39+fqQyhgVqLb/E6YI?=
 =?iso-8859-1?Q?OLuFaWWRfLwasSvoTFP7aukpYljNw3QHEES6wB9zvTe7X+jYPnhDimeSpc?=
 =?iso-8859-1?Q?rsOrQPy6c5IUJbKB8JAgGYXVaZCq62iNbpduNcarrCJeP9pt78qT5RCDV/?=
 =?iso-8859-1?Q?WL/+TrrrUQeYZq40QczF8tnIz5V2+cWs5zZHIi4kFqri73kRJ1ebgyy752?=
 =?iso-8859-1?Q?FEZW+v+Je19bWF36H4SckWeNYjvuQTEuHGGqt9iFKwfAmQHA72Z0b0J0BW?=
 =?iso-8859-1?Q?yci0u/BqL1dWQe4VZyHrf56VDDE4c7AsQ3bgz7nTM5c9rhp64RfaRs+xR0?=
 =?iso-8859-1?Q?Jxg3qntlTXQR041xgOWBJ5bqWrPYNutzoGWbKywpKVwte5XBrqjJL1N5t7?=
 =?iso-8859-1?Q?6NXZXVUCKhPF67lBLB6tKJtJT5BSc8F3Vd4CcepoAmVgGDm15z8cmLWwaZ?=
 =?iso-8859-1?Q?ZXxxqWIPpo4Ua3b4eFEx3U+90qv+drhY/Ei7mG6h0U49b8+F3vIl2eFrA3?=
 =?iso-8859-1?Q?coPnQP1mQa0BF2isa4sZGK1ILQNw1Hc91GhGIppBCyvILzVS4LLdS373ia?=
 =?iso-8859-1?Q?6bUivL26JnUPh/ipMNvD9Qbnoeg3xYPj45oefwcMhq8GQXxVP1yI9IrLcM?=
 =?iso-8859-1?Q?NjGFbdRyKO7ztoPvjquPdo1o7muNxGmUA9XnvW4wxKmSrZfLH9HtBPlhjh?=
 =?iso-8859-1?Q?ZwfLAvDrx5OoUjOVag+9vD9NVlyOQbVCwWYx6hWm6ljmZVg58WDCBA/ELf?=
 =?iso-8859-1?Q?5tdXLGwlN8DVrLpsHcHEUNBPMOEhsopW1hRRXrA6s0F2UV8O8l7c+W5hoC?=
 =?iso-8859-1?Q?q7adEvPPurEPRubo4Cg3CPc+yb3TvlbDahHhaK3tXeRcavB8VkkSo2YZdD?=
 =?iso-8859-1?Q?n2ovdQkztAiqJJHCdjSio8bs2w+5ceUk1TdvXbfE+370YkwxDb7UlLFPXX?=
 =?iso-8859-1?Q?7TlH6jTLu44NLLDPyD11iJnWAefEEUjK54lO7ICM9mP+g68knlSQIkCbGM?=
 =?iso-8859-1?Q?ZTFBLcpGRbKLPz1W4J4RhhVw/tMp4ys4K67xAoeSyh6SB0B9xVIJhW7F9V?=
 =?iso-8859-1?Q?TUHdYch+1/HVPDVASB5lDAHWgW6Dl8jnCwNqSXgi4vU5QqXr9TUpKdgA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cloudbasesolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR09MB5411.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fae9ab-1ad5-4773-7c7b-08dcb790773d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 09:57:08.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c94c12d7-c30b-4479-8f5a-417318237407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoS5honOxKwAz1E1DdxYYwvXegxsTqb4kQ1AEpiXiKFnq+b1q8i0jRjJmrdOrpkHxuHa/yogQWT28Pxz9Ylmm59dpnebH8i41mQGbbFYV4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6632

Hello,=0A=
=0A=
Hopefully I can also offer some clarity on the issue in the context of the =
Linux kernel version 6.6.44.=0A=
=0A=
Regarding the 6.6.y case, this commit is the offending one:=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-6.6.y&id=3D90d41ebe0cd4635f6410471efc1dd71b33e894cf=0A=
=0A=
With this commit, Flatcar virtual machines using Linux kernel version 6.6.4=
4 running on QEMU-KVM AMD64 hosts started having these kind of messages in =
the dmesg while the network tests were failing:=0A=
=0A=
```=0A=
 [  237.422038] eth0: bad gso: type: 1, size: 1432=0A=
```=0A=
=0A=
```bash=0A=
$ dmesg  | grep "bad gso" | wc -l=0A=
531=0A=
```=0A=
=0A=
We observed that by cherry-picking this commit https://github.com/torvalds/=
linux/commit/89add40066f9ed9abe5f7f886fe5789ff7e0c50e on the 6.6.44 tree, t=
he failures were fixed and patch has already been sent here: https://lore.k=
ernel.org/stable/20240806122236.60183-1-mathieu.tortuyaux@gmail.com/T/#u=0A=
To give some context, in the 89add40066f9ed9abe5f7f886fe5789ff7e0c50e commi=
t description, it is stated that the commit fixes the https://github.com/to=
rvalds/linux/commit/e269d79c7d35aa3808b1f3c1737d63dab504ddc8, that is how w=
e got to testing the fix in the first place.=0A=
Flatcar patch commit: https://github.com/flatcar/scripts/pull/2194/commits/=
33259937abe19f612faac255706d5a509666fbc9 that has been built for the Flatca=
r guests and successfully tested on QEMU-KVM AMD64 hosts.=0A=
=0A=
I tried manually to directly cherry-pick 89add40066f9ed9abe5f7f886fe5789ff7=
e0c50e on the 6.6.y branch and it works fine:=0A=
=0A=
```bash=0A=
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git -b=
 linux-6.6.y=0A=
cd linux=0A=
git remote add upstream https://github.com/torvalds/linux/=0A=
git fetch upstream=0A=
git cherry-pick 89add40066f9ed9abe5f7f886fe5789ff7e0c50e=0A=
```=0A=
=0A=
Related to the 6.1.y tree, the commit 89add40066f9ed9abe5f7f886fe5789ff7e0c=
50e cannot be cherry-picked without conflicts, and it requires more careful=
 attention and testing.=0A=
Related to the 6.10.y tree, the commit 89add40066f9ed9abe5f7f886fe5789ff7e0=
c50e can be cherry-picked, but has not been tested by us.=0A=
=0A=
Thanks, Adrian.=0A=
________________________________________=0A=
From:=A0Christian Heusel=0A=
Sent:=A0Thursday, August 8, 2024 12:52 PM=0A=
To:=A0Greg KH=0A=
Cc:=A0Adrian Vladu; willemdebruijn.kernel@gmail.com; alexander.duyck@gmail.=
com; arefev@swemel.ru; davem@davemloft.net; edumazet@google.com; jasowang@r=
edhat.com; kuba@kernel.org; mst@redhat.com; netdev@vger.kernel.org; pabeni@=
redhat.com; stable@vger.kernel.org; willemb@google.com=0A=
Subject:=A0Re: [PATCH net] net: drop bad gso csum_start and offset in virti=
o_net_hdr=0A=
=0A=
=0A=
On 24/08/08 08:38AM, Greg KH wrote:=0A=
=0A=
> On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:=0A=
=0A=
> > On 24/08/07 04:12PM, Greg KH wrote:=0A=
=0A=
> > > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.c=
om wrote:=0A=
=0A=
> > > > Hello,=0A=
=0A=
> > > >=0A=
=0A=
> > > > This patch needs to be backported to the stable 6.1.x and 6.64.x br=
anches, as the initial patch https://github.com/torvalds/linux/commit/e269d=
79c7d35aa3808b1f3c1737d63dab504ddc8=A0was backported a few days ago: https:=
//git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/l=
inux/virtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b56c1b64=
b0775=0A=
=0A=
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmit/include/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f641047=
1efc1dd71b33e894cf=0A=
=0A=
> > >=0A=
=0A=
> > > Please provide a working backport, the change does not properly=0A=
=0A=
> > > cherry-pick.=0A=
=0A=
> > >=0A=
=0A=
> > > greg k-h=0A=
=0A=
> >=0A=
=0A=
> > Hey Greg, hey Sasha,=0A=
=0A=
> >=0A=
=0A=
> > this patch also needs backporting to the 6.6.y and 6.10.y series as the=
=0A=
=0A=
> > buggy commit was backported to to all three series.=0A=
=0A=
>=0A=
=0A=
> What buggy commit?=0A=
=0A=
=0A=
=0A=
The issue is that commit e269d79c7d35 ("net: missing check virtio")=0A=
=0A=
introduces a bug which is fixed by 89add40066f9 ("net: drop bad gso=0A=
=0A=
csum_start and offset in virtio_net_hdr") which it also carries a=0A=
=0A=
"Fixes:" tag for.=0A=
=0A=
=0A=
=0A=
Therefore it would be good to also get 89add40066f9 backported.=0A=
=0A=
=0A=
=0A=
> And how was this tested, it does not apply cleanly to the trees for me=0A=
=0A=
> at all.=0A=
=0A=
=0A=
=0A=
I have tested this with the procedure as described in [0]:=0A=
=0A=
=0A=
=0A=
=A0=A0=A0 $ git switch linux-6.10.y=0A=
=0A=
=A0=A0=A0 $ git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0c50e=0A=
=0A=
=A0=A0=A0 Auto-merging net/ipv4/udp_offload.c=0A=
=0A=
=A0=A0=A0 [linux-6.10.y fbc0d2bea065] net: drop bad gso csum_start and offs=
et in virtio_net_hdr=0A=
=0A=
=A0=A0=A0=A0 Author: Willem de Bruijn <willemb@google.com>=0A=
=0A=
=A0=A0=A0=A0 Date: Mon Jul 29 16:10:12 2024 -0400=0A=
=0A=
=A0=A0=A0=A0 3 files changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
=0A=
=0A=
This also works for linux-6.6.y, but not for linux-6.1.y, as it fails=0A=
=0A=
with a merge error there.=0A=
=0A=
=0A=
=0A=
The relevant commit is confirmed to fix the issue in the relevant Githu=0A=
=0A=
issue here[1]:=0A=
=0A=
=0A=
=0A=
=A0=A0=A0 @marek22k commented=0A=
=0A=
=A0=A0=A0 > They both fix the problem for me.=0A=
=0A=
=0A=
=0A=
> confused,=0A=
=0A=
=0A=
=0A=
Sorry for the confusion! I hope the above clears things up a little :)=0A=
=0A=
=0A=
=0A=
> greg k-h=0A=
=0A=
=0A=
=0A=
Cheers,=0A=
=0A=
Christian=0A=
=0A=
=0A=
=0A=
[0]: https://lore.kernel.org/all/2024060624-platinum-ladies-9214@gregkh/=0A=
=0A=
[1]: https://github.com/tailscale/tailscale/issues/13041#issuecomment-22723=
26491=0A=
=0A=

