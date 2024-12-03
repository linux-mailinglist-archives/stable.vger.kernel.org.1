Return-Path: <stable+bounces-98129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465B9E2853
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4564D289C4A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC31304BA;
	Tue,  3 Dec 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b-data.ch header.i=@b-data.ch header.b="nWb5SDtT"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2126.outbound.protection.outlook.com [40.107.247.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF51F76CF;
	Tue,  3 Dec 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244989; cv=fail; b=EOf5lTrb/WYmfU4uJfyGiGtbKv15H31MtbeIZTVrbUdpW9Fw/u7D+WnqLLPz3X+EqA5WQJezHAByJe9FdRNRSvSzxrgpOABRygAvvwto4r4L1rgoGIkAMjVLWMyxGauiGqpwHeLZDGbR39UaZudL914+0RicOE8xazH/ySjgfjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244989; c=relaxed/simple;
	bh=UYfb++N8VilgZfBoVa79+u2XOfSLkuB9yFetvHq9fok=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BgZW9vgkBhWSFNm4c7mItWz14S/3+ApQbCIklvAbMZgNbmWazemMx+VXeJpJxDpBSoRldf9pyvhSK7swa3HMf2QUnvEDAOhxmbFkERu9B9tas+f3qoR5IbaQazJnCPRp+fh90yHgAddu1U6jwDmLflc2E0RPc3m/u+N73M5xBu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b-data.ch; spf=pass smtp.mailfrom=b-data.ch; dkim=pass (2048-bit key) header.d=b-data.ch header.i=@b-data.ch header.b=nWb5SDtT; arc=fail smtp.client-ip=40.107.247.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b-data.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b-data.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV4DrxS63VrmICxw7HRnNi5aemf1pXxDjZil/+Ea93Ae8eCeOpBR0yCW6MsT/d8LnRTbBRAStrBZceTMOR07d6ufoJkWGszXuvm5x+oUdMDVS0cwmWWATPbtXIXyYPlKuZxDjn1QfC/vxs5SzPbP2qDJoax0ucfuimOWjBpaTg5Tq+wKpqGtuSBVBZxN3Z47gokgsuMRatMpxBXmKRdn/9MhiLHXieqqWDzcq2GmP9fuMZBnhEKqG954pq/ttvuxWqKB8iqUj4/FBn7rLdMsv2xd1nbfSLRnbRdMc1iz4PlPVtG3M/GS1JmujSfu2rs0ED/QTOpv5k7aE8zoyg6tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkW+k547bv/Z4NPDslH/dFNpwmWDopwHXI2mLp343+k=;
 b=PtVUikg81GOX72R+kGz2S1GY2Cs662GjjbWKtZb1PKyzBJTDfLOcVHT26AFnGNMFsMKtuMisOZhBmXuz7jEfjYC+KjukQNLZUNM58YgiPqy4q/2kV7nyMlUwmL6nj5mTkcEWsbOuQbPOODFxUMVKyHj1vwVbNfbGJwqyDgTBm5EgBxDe3GiR734snbq7QYybBfujjYNesWQ6m72sh682nSt3JRGyNsbPtbPHR4p/pMciotspUm2aS634prAYzWIh5Z/Ag9KpzrdyKZZgom9SH1bEOY5+TyX0vNk6TbFQ1mPfGyQmtu1O1C1EYS8I6GohT/MXkDL3KgNHXl0wmMLh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=b-data.ch; dmarc=pass action=none header.from=b-data.ch;
 dkim=pass header.d=b-data.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b-data.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkW+k547bv/Z4NPDslH/dFNpwmWDopwHXI2mLp343+k=;
 b=nWb5SDtTaIGN3XPRyoG5OdVgG7V3TLqK26/KPenOkHcr2CIlIMKs5JYCANoo2CcWfkQyopsTsDrnHq7cyzG9Pv5dUyG1Dolrlq3xKKtw17T8ZAIY/Y5d8stqZwABqZLfW7L1Ln+fAWSiXCLI4nU/6P791MC0wKI72yAkKX8wq4ObJsbQmkeexocrCgz/tT6HIdEYKqduRSEaBPnp/nzhYHe/qMWNGuF2pGu8x6cJCeN9MLkKTRH2cFruALdCunxM5rrmDNod25iolSJd/pAFyHixBSfky+Ge1C7sUQEpY40yStc4AdD5soPQaASEMsbSxrk9Shz3tY0aGBHr4gQIXg==
Received: from DBBPR05MB11225.eurprd05.prod.outlook.com (2603:10a6:10:538::14)
 by AS8PR05MB10757.eurprd05.prod.outlook.com (2603:10a6:20b:63d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 16:56:20 +0000
Received: from DBBPR05MB11225.eurprd05.prod.outlook.com
 ([fe80::88d:e0f8:6a6:22bd]) by DBBPR05MB11225.eurprd05.prod.outlook.com
 ([fe80::88d:e0f8:6a6:22bd%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 16:56:20 +0000
From: Olivier Benz <olivier.benz@b-data.ch>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.15 209/214] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Topic: [PATCH 5.15 209/214] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Index: AQHbRaRGb5jBIGM7tUuWCGr5rveMHA==
Date: Tue, 3 Dec 2024 16:56:20 +0000
Message-ID: <5E724FB8-8844-4F92-B1D5-423E6174E996@b-data.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=b-data.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR05MB11225:EE_|AS8PR05MB10757:EE_
x-ms-office365-filtering-correlation-id: 0292c322-84be-415a-ed28-08dd13bb693f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mGowYi1NcfJp0Ab7Fm1B9KkX0xGl3vxOvxOD4pYXkQJRKlB0Ip4Ngt4PXewX?=
 =?us-ascii?Q?wFWUuO16phjL8TbdDLJZPmraRQSuru7/hUEs2LyH1bvQ0I7PaOF617iD3mBw?=
 =?us-ascii?Q?vk43bwRlTfVLTmYfZlItnqH+/OHgsGzslBMffi6uee/zSxfOn1ajx5Zt8ngI?=
 =?us-ascii?Q?29diQO9EYxj1ABb3uj5N5xhavzV3iXuWYJGO9m8l4nM8LC37aybdkZY37ohu?=
 =?us-ascii?Q?YT1HEzQuSeeQrEDS0BG2crpLUAx6NCnIAB8Db7uIyXN38y/m4sqIO6U8FzU1?=
 =?us-ascii?Q?PGWrAQBnN3veM8Cnewb4K3X5OYPnBLujYxKkQ3cWXLn13Gq0nVFRnXNDfR69?=
 =?us-ascii?Q?x1rLa4oQZnwcG3u58lWWEFVN1/vHHq2VjxqrthjgyBsyrjAdE1gFIveJkko6?=
 =?us-ascii?Q?Ju6R/4PfVog9Nb37vhyelGvgSbAyS5Ot3iBMDt3N6JBdPvWO8UpgzKFKRwaE?=
 =?us-ascii?Q?zH3uha3ehqdDplzt1siM2y7xDK6T+wOfXYzTt0W6So7jImOFnzgt5UtYHXjC?=
 =?us-ascii?Q?Enj1u3zfka6vQZMt8jiw/+Sk6vdAx1KDT4mKDKncZLO1jKU9T0V/9+oZC1UB?=
 =?us-ascii?Q?xHDlB/WQzhpAfLoEmU0/PwxKyIpaSlP4nvxlDv+TsavoCHMeTJH0oNLzqQg3?=
 =?us-ascii?Q?ZGhHDEx5Y9wbLL+PLnS4KeKC7ykfQYlZnmmHClwZ1tW0OGDv2+7dD3jHi8g/?=
 =?us-ascii?Q?+YL4l5j2t5aohYiaAaollIiELWLmKOTTrqeKsXEaPn7MDdE8mTzX64jc/cxv?=
 =?us-ascii?Q?4jH+HMvOx7HfpPMhNu5Zki2WGOvZz9Yq0FoRIb8pFXzBz+cXdBv6qeCs1b7u?=
 =?us-ascii?Q?SOeBWjd5pKWNJQduCDOdECyjkNCcputR5uOJatO4/4YZQ2NfDoPT7Idufi25?=
 =?us-ascii?Q?w2zYT+HBqlyIRkBWj0uZK2s4dEdROxJIKv3gFdu47BnlD3szz0jNJIme98iO?=
 =?us-ascii?Q?vG55K10bJnp/+D+8pb40AKX4uBAZjLfApbAk+zbgyysWQT9gLMAIhqyuHrfP?=
 =?us-ascii?Q?KD2YOTDGYu5H+9CHWiU3RhLuHE6B9KBxThcxZEU19eOrFbgMNLm5WfIwTLRf?=
 =?us-ascii?Q?6PmjtGvnV+owJIkP2FfIrFyAh/eqQYgGxtFbL6KovWCZ/dYNVvB9tEi6GOe6?=
 =?us-ascii?Q?WhX4mfWY9Qyg6b4RiV0f9IaNj20YHEUeGTYoZAPcm5UXpA+v7saSJwxbuhtA?=
 =?us-ascii?Q?4CcVZQGBZy66qN9CeJq5zI2KHEbhlm214aUPDHr+JphMPO/lpATHL0HVfNiB?=
 =?us-ascii?Q?pOpq4vu0B9lCh2+2qt7QE+BWEeBXZcgD3G5rWMABNBAfPqIN46aK403EixT7?=
 =?us-ascii?Q?rRukvUNEMOZncGZ3FPjCVvdKKh0/b5k8xjA4kjIBxU7RplLbAvaEP7Ol/hVe?=
 =?us-ascii?Q?317P1CLrIQGJoUGLtWkdacrvgwQWOJq89Dt4oab7DfnNUuGq9g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR05MB11225.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4Aq6YCFtLEo4hJU7SzIbLYriH9dngbHRgoHQqp79onPSzqt72tW54ecRa3/u?=
 =?us-ascii?Q?o/5AyBjU8LmIkIvx0vnCN195XWV8jJFEGIAO1WaTdG4LmgYY26vwgiRDhklu?=
 =?us-ascii?Q?/3Y3d3GTTOUYjVR+Jrz3NTLGnROeo6qR4Q/352qLl/8Raxj6yhkSjqEu2iBq?=
 =?us-ascii?Q?7kscyEDNd7u9eN9L7YZ6HIoUX0+iph5qwFKCemfabrrgfdJ4bNw/uKZSeb6A?=
 =?us-ascii?Q?r6sYcFvNJDMt08r0AHCQN4Mh2SlwVnWskx/tDHCa8Fwjc2rQOR47rIbC1eCS?=
 =?us-ascii?Q?EMOgcIENlWdztkdfJe9vNE68c0OyF6KxWgdcEbQDSAa1Fs7ts65fdN7uXX2+?=
 =?us-ascii?Q?5QsWalFb818so3e5044liyHlUL+ml/dHvSbrPbd1oXy8XzyTu0wqCMahIJB8?=
 =?us-ascii?Q?KJj3XK8UNpbQ6AKOjDxvsMWPxBZqkn9IWqptJo4OrZDY+G1ZXb+wkUeTLZw/?=
 =?us-ascii?Q?qns6R8t/oquy3NEJcGDmV2fN0OcrDeW41oYukDniGoNzwM5nFw+8gFr1IE+z?=
 =?us-ascii?Q?BGJAUv8bv9mdy8AHuQFAvkyYh/rCUfSrvSQYlENykpBfyySg/FqEDH1IoVzs?=
 =?us-ascii?Q?U2JHPbw0U1NQzgUiVSrROs7lLVpQaHmISWYjciZ75TR3dBNXEmexqSRijS+2?=
 =?us-ascii?Q?LMo/5Z6n1k5zlIChXRN6ykVKqCOFKtiVWHnLDf9uQl8kripYaSdUBFy/YhW8?=
 =?us-ascii?Q?iMfbOzxf5Zomxl4jfHpNOsJmrWrFjrtg4uzbnWVt/M6geagLbUiG5ynb5ejP?=
 =?us-ascii?Q?nurmfs24x0Oy1ND/d6rCKv09rmu/Cp5CBEGD5AtsaRjCZib2aTlycTKlKEpi?=
 =?us-ascii?Q?FSWvOHwxFnzxjBRb7q3uEHHiO5Be5h1oxZXMsuoigvyLG6GoP81nU8/U2zRg?=
 =?us-ascii?Q?LkPNUA4iSY0eWUKGa5CMTx6Soirqs7CTC3VvX0Ytf7ES49JJ2G3bySjvqKUB?=
 =?us-ascii?Q?C3rGT8b5fONyzXArp1jY05QfLrwnsspTQlKCrEkhIbbL1EvaKlAE8sXb5GBp?=
 =?us-ascii?Q?+qPH4yHenuP4IzKHl32+Ucvoqqb/uwSs8sfgSEw+LGqWTSRJjNhN4pAkx60d?=
 =?us-ascii?Q?SN2eEXje5Mskq7QH1y6/awXPb2l3YzxkKGPCbkIHYMQKx1XmgnmiNUpfUpaq?=
 =?us-ascii?Q?O/UImWetcBUi8BmQic+TYGDjVJl3/oxRvIqQ2LMOEzO+pWL6dnyBKTNPFAEE?=
 =?us-ascii?Q?83wkcQZjdV7/ZIdZJh7coeqCz7aj4hEa1jjUh9sqYozd8SJnJBM7q+hjSLNP?=
 =?us-ascii?Q?g/c841TmnOwO3fOD+DdMX5zPdQEsIWiXWYa7o+EiFJNrcgk281O+OtmxINjb?=
 =?us-ascii?Q?T+wwsO//Nvu5gprf2GhOux6wR+8obMAXdPLiIBifUP48Q46RycpiMG0dOQ/z?=
 =?us-ascii?Q?CRw43uzVTq9QGgVODwMEqEJ5ZLEG2pLz4+jDzPtVuO1vlu7YTdkeMdz7L2fL?=
 =?us-ascii?Q?nLovNphL2/aKgrWpLmofBQE0b69KBqh71jazatZeBhQreCB9BDWVL8+qVAfd?=
 =?us-ascii?Q?dKvALWjNFXsVXNvldTmMpVUvdFuyjDIRVeNyzDQ1RNHhjaRgeLMeVEsTz0sE?=
 =?us-ascii?Q?vJBvKH0DlpuX8/RLTQ43ZXJXoRnjTFtbp1fPE0luysu86Pxo0joGNe44y6Sa?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A5A6B9639D74D4486C69F1FB8D7ACB8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: b-data.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR05MB11225.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0292c322-84be-415a-ed28-08dd13bb693f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 16:56:20.1489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5d63ff8-4e2f-4fdc-92bd-8efdc558a764
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRCXImGdqermUiK5EhNrQBP8eRu4wSZvd9XAi6i6Qr66CbIYWei928RfcfAOTuAWkWGy3bQ5vltinpH25/foMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10757

Did https://lore.kernel.org/all/20240910092607.040498134@linuxfoundation.or=
g/ somehow backport https://bugzilla.kernel.org/show_bug.cgi?id=3D219129 to=
 Linux kernel 5.15.0-125.135/5.15.0-126.136?

Because I needed to rollback to Linux kernel 5.15.0-124.134 due to

--- snip ---
...
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.433876] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.437561] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.446613] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.451143] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.457727] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.461367] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.467091] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.472057] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.478908] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:18 ags-vch-3021 kernel: [13368.484023] ens160: bad gso: type: =
1, size: 1448
Dec  2 12:00:23 ags-vch-3021 kernel: [13373.495946] net_ratelimit: 486 call=
backs suppressed
...
--- snip ---

on VMs that are running on Nutanix (using virtio net devices).
--
benz0li.b-data.io | @benz0li | olivier.benz@b-data.ch


