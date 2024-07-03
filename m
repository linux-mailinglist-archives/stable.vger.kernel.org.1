Return-Path: <stable+bounces-57967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C94926748
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 19:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98BE1C22F93
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855AA1849D2;
	Wed,  3 Jul 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dRH6Ym6G"
X-Original-To: stable@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011027.outbound.protection.outlook.com [52.103.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B654181B9F;
	Wed,  3 Jul 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028342; cv=fail; b=tcnh6WNDo5XlZf0D2lMP8adoV/ugphaYERTrYo3Dqy5Wmcm3o3Qu0+8YD6lHGcjOverGif2foZnwNbecK6miWVKX96P2VLsiCTp54QwLsmSUs4N/2tCRfLkwWWLSYe1Y64TxuXi/Rq/AiH7kOkyozb+Kg8/Naazc9PKx/6pLPXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028342; c=relaxed/simple;
	bh=Aufh20Ld/hGh0HLN2HOuPrlOks46cvIwicGr1mP9Cls=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJKqCDqVFEUHfO2/N5WnQ1M+N62YsGwj2bB2PpvkQBevFaLSfxhkUgaeB8yXqoeMWIJP4GzmnjUmnZTG4ifIGB4sHkQNwx0D1WvkFK4YJS5kfh7Cr+XMye23K66seDjOcueNCDUYrTIwVk2tqR6ICVg4BcLGiV6DFeLS5kZPkmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dRH6Ym6G; arc=fail smtp.client-ip=52.103.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZYAzqe165algaQNbYMLQcS2dQTZyyKkY89DR6+5LmFqlbFb187UMFwBY9yzsS9j9iULdy9d+BuC2qwvXk+z1xLLcSgPLkzaKcRAf5EolxdjscYzUVz910Q47jHykuLEsEbJA7KlrHa+JpKWxynU+++eHn7bLeGKX079ncFsQP90JWD/OOXCZxvgaG9bOeylXQQ4xq3/UdSCi+mCOlz0oEJDNxXYYY+5RYtWj38BpCjCCcBve5d4ULo+JTbNy8TiGuDnxr5LgczMdI36v2QhmEqI7H12dRzM2ynJ4x8oJgMbt1Y8yBr21uS9NUvjekHGnVpzpKW2cUPZWJ5BoBw4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aufh20Ld/hGh0HLN2HOuPrlOks46cvIwicGr1mP9Cls=;
 b=IzvL/6nv7rOV6P1EvRhB4U2Ko5tfMMuEfNMxEPgEBMLzI2/rmcocTCudK38xFx295QvGvg1zPvOkfe9oP8xFHwjdav5b+YgcUProzNqDMs1iL/TJGEALeaMEh0677VvB6uuWoahgIceZISeWaRzV895Xp0fso79r7HYGBtJjqdIVdJe0ljEhStGeDEsj3Wo/dzgqhQP3Ppa/HUWQKNxGhypSW+/Ff3ZAuZKzXAAqEw1uIc5uyMPGyzKywttiSiCpV1ECecHlxTKf9bWR7ZL/Bca0QFwNmFaIctXPgtmxan3qgtGzTx4Aoya+3UTUt0AM5HghGb5LI/xEjjJu9DxT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aufh20Ld/hGh0HLN2HOuPrlOks46cvIwicGr1mP9Cls=;
 b=dRH6Ym6Gt9h+lIIo+qaRkl8lDtacs5nj/Y/P4CVjKQe++pZGSi13BW87Z/UTjNnYt0KBy8PBOfrjdgnsPRcOzKjvphBEmno23UFtUFDOC5r1exA2RB2n+yIuD4aUsWJvJX6jIhk9Duf8PLRjXXDiCJnHcqEWt5TecwuZ7rFiAaoLKEsR1j66uZMqc23YyO9bf3I6+e8fFZzse0zaHDD8kdAYEgdXqHeKvd3L2xYfaTg8uZ2cX3JVLEdo8qs4C3uuHvErvDDtjxSPtg41gUgcEcC6lTr54/kr1JFjgYSrnvGw120UIgNuDflc7MyxiUa7u9nRAP8rFxg83TeOf3wzMw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB2162.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 17:38:55 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 17:38:55 +0000
Message-ID:
 <TY3P286MB26119C0A14621AD8D411466A98DD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Thu, 4 Jul 2024 01:38:50 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, pablo@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, Elad Yifee <eladwf@gmail.com>
Subject: Re: [PATCH v2] net: ethernet: mtk_ppe: Change PPE entries number to
 16K
To: Jakub Kicinski <kuba@kernel.org>
References: <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240702110224.74abfcea@kernel.org>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240702110224.74abfcea@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7eYjI62tq2hmBOSczrM0xbfC"
X-TMN: [ar3CV+Rr3uiPrWUOhflbG1fRR41UQc4hhvUMdwl4tk7VD5rGUpuMon3V3+kDu2GH]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <3a3f0b5d-3b92-4077-b07f-d5278f6fa83c@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2162:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d0e178-b565-48e8-32d1-08dc9b8702bc
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnpXB0xcNeDVdJIgd0h0Wm5oDRfh+5EF2fUegZqKgcNYEOmMYcDUor9AediZULGAVc/WhZFnHsiBFrdheiFSQcDyVjIp16A9OiSzeZ/RNvvtAsk2kAbb3flJc4Wjyenf/D9mzdPWNHGwyxI8cdaUfUjdu6Lcc8/Q+2DY5wG9yaKjHiBGC96QKiSUa4qnBJC36T7FuPjI3UngiqsiRD9J0OKWw6ZcAj+irAyoYPn7Nz0xDBlVwYmzpivIhUOXFR+aVafFpUI+Hdgyo+whXFcZcvH/fjDcVuN/1Xt/pPJNN2Vck0eiyU7eW53WJTB5Gn4RFyntaQu6lgPmmTzNazww6j7ZVS0v2lOA0+Wp+9KaPYs4JFUm3cWuuv71GPYhUKxDWg4vbh6p8FV01vK+yZFhM0LOX66i70ZLJGEclJusI3mJQ+JfFwnRCyRk91IAT9aBKp/TFF3bZry8eUJQ1CnU97UCgnMlPkhxg1YoJzp/GzL8ehZa1twCjPbw52MfF3QXL0+5e7Qy8X59BF8bU6rkOLyOCZGe3AWux8fZM2DjKB5lUmgYxjZiAkILz+LwgFIypaWhdYkP0yYZgbCKrHcYRTP78yFa/SWYghhG53iSuDGVc1nnMD/UsFjCXWiNE9CXt6Qpuw7iA8D/0iDr8hlvHH63nw5scECLjnvY0AYLbxZVs2pVgIKdocWDgPu7BKFHcVdKjAihNMzVXtHau1safJKqEOb1WRjyi5ktSOgsebcl7s90F75KDcXmlWjagq/Ueoo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|6092099012|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	RyriUE7/A06Mv8kqwZ1Y+OugBbAOhpjqiTX4deVA79Vp4ejfXF6ZoBFH6R8EGmEgC9X7iYXYeSSYSW8gO8Uw2UFhnFARmJVqM4w5Pzrh/uPFluyE1VchqBab8AGRFyOevaLLuaMpdfLHNFrskRf7OK3HofuN65NI01eYnBgVh70AJZuOynrFrnFHgZhq30ZDdOUqFCU35APMKYcmmnnnVZ3y4g78I6mF0UyRZW6wK7P7s5ruvSgqKPSTFtoINWNpThuA8eYwhP0hkMQc8yNTBFp+FjcfnW3DQ2JdDks5sJb3RcKooB/GSzB5rBMux2uF8QCghv6pywxD3JIEBIH1LMAlvdcIyrdXm5MPMisngZ75FFKM6Gcs4l+FsVuco43GdO1uITcLOfzjF3DxfblDXSGBhvF+qjY4ooeioFfI+KFZWjRK9LUUeB9Glx7l4Vr4WkZ74CVZbd8glZyJplOIUPFYyI3fnvvUsD0YJsc4taAdFiYN/Qo7DvTM5vQQx+ZdZRZ8FAAP6rleAd9/ikW4KCWAo0ha/YtwY49dQ2rywyZH+Vm6aMWwyHyk1Dy5vASJOuSRNuD8e48hby/U5UnTYaUSIk7Hznj4BPlc2pI9r+mpFws8umGgG/OAnJSixVg7uG+MYt4XB/r0Om+fva04EKCqwhfGogotz77Q5CLkRLf3bpMCz7inN03yyLyprAXi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBORWJ1VHM4RWJ3Mnh5Yko3QmVuTkhjWkovc2JtbkRNVjRZQTMyaWUycU92?=
 =?utf-8?B?V084MVpRRjRScDlSVTREQy80R1VYOSt2WnZ3S3BNZ1F6amFtRUxxZDdXdXBu?=
 =?utf-8?B?K1JsbU1UL2F6TnBVY09ta1JWL25mR1dTaXllOXZqM1lRK1JmdU05b0IrNkls?=
 =?utf-8?B?Zi9GOGZocERMbmp6UXFibllzRjBQUFZhMnN2TndpY0drU2lid0R3MWJDSmVH?=
 =?utf-8?B?WHBzUUplWjVtNy9FZU9mbjBjSFV1cWlSeUhWbThFbGtRcmE5a3RUZENKbnM5?=
 =?utf-8?B?SWlBS1NKT29nN1lhejlVN2U1VisrWXYvVC81NThLYXVaQUhoUkpkRWZuVXVq?=
 =?utf-8?B?K0txbGtvM0VpZlFybW9hQTRLalpMLzQ5SXFQaFFJdHZrQm9Od3gxUXBGb3BU?=
 =?utf-8?B?aW9qWjJVcFZGS2lRQVJKL3creUQrY1FjamhyTWVOSXdWbGs1WkR4UzBNSHhz?=
 =?utf-8?B?YlcvemhWWWljUUE4S1RqK0lPa0Z4a29QNE0xTWcwRHFoOTZ6ZmpNZGNiNVRu?=
 =?utf-8?B?U3ltZFhWcVhYNVNBYnhKS21BUXBRZTE1WEpteVBBWXNneUlQVUNHUEtVZUlU?=
 =?utf-8?B?eU9uWFM3cDN1RFk1ZDlHaUZZMHdRRzFvYy9kYTQwZXFXNTFHeTBNUnJmYnl1?=
 =?utf-8?B?YXVuQm1UbVdqMis3UnVHaE1PcERmSXM0SFFLVzhMQlBibk5KMWM2Y3VDUlYw?=
 =?utf-8?B?Y3IySWkzN3NRcXJWcjBoT21nL3lFWmtPaGFqb0Z6S29zdEpQOUpxblczSnVL?=
 =?utf-8?B?SEdWNmdxNGxFaWtFL1lIQ3h0ekxyb25Fd050eGh3SWtnWi9hTG5Oam5UaTJq?=
 =?utf-8?B?TzZDeTU1NzZucUdqVG9KaU12R1lKMlZuSGxCRnBLbCtVMUt1OUFvaXI4MVBP?=
 =?utf-8?B?ZVIxc1U2Mmx0bkRqTkR2dHR3Z0lHYzdOMTlzM3NqbzRjVDIzQzhKT1cyYnJV?=
 =?utf-8?B?M2prQUxHaWVmSWp5cFp0K3FnOGtyeVR1SWp1UmNmTk44a2pJR2lhbldWUmhU?=
 =?utf-8?B?OXRsOWRteHdPQmkyTHJ4N01rYThiSnRxQStUVlY1QUdKTUNpQlYxZ3lLWnZW?=
 =?utf-8?B?QkhwbVZITnZ2cGtaNmNPNnhmUVRkTzZoMFA0cDNQeWUyc1I1ZjZyZE9QdVhr?=
 =?utf-8?B?aGFBc2VMTXFITDhQRlVTREM4R3plcUxJSTE2NUl0SFN4cTExVEplQnRiT1Ns?=
 =?utf-8?B?aXhXY21ZOEZ2TjZ1Q3Fva3I2U2FJdzc4dWFZQzVJQ2lXVG5vZFFTeVZ2MTQ1?=
 =?utf-8?B?NkJIZVFtRmNjM01hekowTXBCbGM3OXlCYmVGTkxVYmxxT1pML0EydU1nQjZR?=
 =?utf-8?B?YWdDVktIdkM2Zk1BemdxNGdFWDlyODNJNDBPY2VHeUJYOHdBY2cxRWl4WmND?=
 =?utf-8?B?TTJMT3g5dFIyZTVPMFlpb1A1T1FxWHFjSTAySWdqNlhwNkN3RkIzdXpaaXRS?=
 =?utf-8?B?OXEzMHFzNm96M0FQM0dkMVVKNVcrcnFOUExJbGt1Sis5QWdvbUtVL202cVVD?=
 =?utf-8?B?VldqbzNjVXhvcFN3SUtrSldEc1U4bnB4eXJJVFo4NmcvWGpKUWw2NyswQ01B?=
 =?utf-8?B?cWs1a00xeWpGZ1JnQThHQXFNTlN4TS9FbVNvMmxsenhYVHRwMjNhOUFQQWhE?=
 =?utf-8?B?Y01mMXBRdllDc0N6S0tRbjNkZXBGRUl5S3hmR3FFYVRyZnBYTjdKVENsVnlN?=
 =?utf-8?B?enp0eCtNd0RMOU1HMVRtY3ZzekwxOEhSUUNIbzlsc1lkTy9rRmZUUUM2UVFu?=
 =?utf-8?Q?RmKpgdiTH5J7/KZc4E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d0e178-b565-48e8-32d1-08dc9b8702bc
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 17:38:55.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2162

--------------7eYjI62tq2hmBOSczrM0xbfC
Content-Type: multipart/mixed; boundary="------------G1RbEShLKlQcM5pnAPp2aygK";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: wiagn233@outlook.com, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, pablo@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, Elad Yifee <eladwf@gmail.com>
Message-ID: <3a3f0b5d-3b92-4077-b07f-d5278f6fa83c@outlook.com>
Subject: Re: [PATCH v2] net: ethernet: mtk_ppe: Change PPE entries number to
 16K
References: <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240702110224.74abfcea@kernel.org>
In-Reply-To: <20240702110224.74abfcea@kernel.org>

--------------G1RbEShLKlQcM5pnAPp2aygK
Content-Type: multipart/mixed; boundary="------------zhj4vS5hQXciw88n0VjxGtjp"

--------------zhj4vS5hQXciw88n0VjxGtjp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkJUIGRvd25sb2FkIGFuZCBQQ0ROIHdvdWxkIGNyZWF0ZSB0b25zIG9mIGNvbm5l
Y3Rpb25zLCBhbmQgbWlnaHQgYmUNCmVhc2lseSB0byByZWFjaCB0aGUgODE5MiBsaW1pdCwg
b25lIG9mIG15IGZyaWVuZCBzZWVzIDUwMDAwKyBsaW5rcyB3aGVuDQpob3N0aW5nIFBDRE4u
DQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0K5ZyoIDIwMjQvNy8zIDI6MDIsIEpha3Vi
IEtpY2luc2tpIOWGmemBkzoNCj4gT24gVHVlLCAyNSBKdW4gMjAyNCAxOToxNjo1NCArMDgw
MCBTaGVuZ3l1IFF1IHdyb3RlOg0KPj4gTVQ3OTgxLDc5ODYgYW5kIDc5ODggYWxsIHN1cHBv
cnRzIDMyNzY4IFBQRSBlbnRyaWVzLCBhbmQgTVQ3NjIxL01UNzYyMA0KPj4gc3VwcG9ydHMg
MTYzODQgUFBFIGVudHJpZXMsIGJ1dCBvbmx5IHNldCB0byA4MTkyIGVudHJpZXMgaW4gZHJp
dmVyLiBTbw0KPj4gaW5jcmFzZSBtYXggZW50cmllcyB0byAxNjM4NCBpbnN0ZWFkLg0KPj4N
Cj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBFbGFk
IFlpZmVlIDxlbGFkd2ZAZ21haWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU2hlbmd5dSBR
dSA8d2lhZ24yMzNAb3V0bG9vay5jb20+DQo+PiBGaXhlczogYmEzN2I3Y2FmMWVkICgibmV0
OiBldGhlcm5ldDogbXRrX2V0aF9zb2M6IGFkZCBzdXBwb3J0IGZvciBpbml0aWFsaXppbmcg
dGhlIFBQRSIpDQo+IA0KPiBuaXQ6IEZpeGVzIHRhZyB1c3VhbGx5IGdvZXMgYmVmb3JlIHRo
ZSBzaWduLW9mZnMNCj4gDQo+IFRoaXMgZG9lc24ndCBzdHJpa2UgbWUgYXMgYSBidWcgZml4
LCB0aG8uIFdoYXQncyB0aGUgdXNlci12aXNpYmxlDQo+IGltcGFjdD8gV2UgY2FuJ3QgdXRp
bGl6ZSBIVyB0byBpdHMgZnVsbCBhYmlsaXRpZXM/DQo=
--------------zhj4vS5hQXciw88n0VjxGtjp
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------zhj4vS5hQXciw88n0VjxGtjp--

--------------G1RbEShLKlQcM5pnAPp2aygK--

--------------7eYjI62tq2hmBOSczrM0xbfC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmaFjKoFAwAAAAAACgkQX75KBAfJsRnX
Iw//Z16YTMwS0NaZih1/GEVUnidskHqdNmlHcesFmSeXukx+yEv83Z5mfeQsiQDhmvA/3FM3VHG+
zasXZBmh+iXA+RDEmsHxkgAG4wCXAhHbFkXHsRr76SvB7kWlOhhRrEGWT6QzYt4W5nVaeEI7EOSf
Ghy643AWsQ8p6h7qFC7+P6tXOVeHKiLSXKfxqQJyOydaGLrNisr9G9LIL44s9vPuo4YFts468mKt
XqxtZYilQKpKiqj2BeIEijx3KtGn/u2so6NNcdNQi1vdlw5XoThdoDQp63T0y3ASqYskHCpbybuq
c4YtocoPxpsgJTaRKB5netnqtNX3ZJ0NJr0ywreZk0KysVG9EU4YocYcrsbLebVE5DslSSfenihX
LfAjQGV+fiTvEmlg6J6hZmfdye8+onocVYghEZYc3G2aOEhoR9zXIx3vE0IoNAjHeCVs0+a3ipM5
m6mq/tgxLpx4il1LPRys8FFL6g7ydpGqt82Hq/Ipo8pTCHSgDpBTxm+mW3OfjaCVXUE/cOI07VDt
ho8bmSWgggZL7BEgiS45Pv3yMFHcRJSaLmokFbchtd2S6Ukj/o+Kw5DetO+P61ezCVtRpjeeIRsB
x4n8UUY+vtdLsBrfxsVn6GkGVUXNAZSRgrgxSNTqIyYstwXwoSSuBv6FusFcF2v6kkNPPSMuyMJW
eJI=
=7SW5
-----END PGP SIGNATURE-----

--------------7eYjI62tq2hmBOSczrM0xbfC--

