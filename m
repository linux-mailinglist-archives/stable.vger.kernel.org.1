Return-Path: <stable+bounces-67620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2195186B
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D92C1C22615
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C4A1AD9D0;
	Wed, 14 Aug 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b="OyKve6TP"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA11AD9C0;
	Wed, 14 Aug 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630230; cv=fail; b=o2tTNMgcG2EdHbEn7KDCha5QuL97+0OAZ6D3iZSpYA1z90T+oKEUu+2P8UazZmjWhUt8HO60f8QFH9xuiaw/eKRbafIl2hCF8uvvDc+OPw8wxovFdgRUAb5MBKuECHECuJsf4T3RqF6hngErq+zZbNTRP1l/FpxjV9VugIxBjzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630230; c=relaxed/simple;
	bh=tITocF/7SPXaaKqCt3scYqOY3BuyCzqgj6dIqCfJs5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H67mJMehCOU8YTRJUgXCLy5HBqGQZMTNwa/Keb8IgtgwH1jlcJA+Pb4IYat/ceauLCJpnD7h7mT1e4nc4vmdrbhqZaBlBvL5lM5YcwzHxzan/F5motse/QYPKATP6XMS4zlidMnFyosFf7wMsqzAT2hQyRgIIEu+0IqIaAInN5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com; spf=pass smtp.mailfrom=cloudbasesolutions.com; dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b=OyKve6TP; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbasesolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG2N2EN78LSQ4KVPMugbmfI6uyWqys+HTM0loUU6CDGZgcEi5WOrl2J84Kdj+ZXbmsbdveHqdqG8LX3z/mKD3O7H1Ed1Xy9W3FN8/Da46yzaoeXhQMtaBIUQJ5x3gefuU+HUoA+Wl86AKuvcOqI5EuGlYvARttoSgCivFUyvnTEfkbVsYP1zG/4eN1RXsFY6knGNUbjylEg/NPYfcEAS4exZJW7dHME/EE1xsAigsMt+DkMHJ7UXsHShtGEM6YNb6VDvpwC8bRQGNa1aHhHZ8MTmQ6FoJNDVT0KjfWZnSD9hLjEjirQzYOny8oADWPodOmY+zyrcIdM392SIgl+BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tITocF/7SPXaaKqCt3scYqOY3BuyCzqgj6dIqCfJs5w=;
 b=lVdp16Dgs5kdJpphi/p1MdbLIZLGDD1FBfZxIfzx9xH6IcOTz/Bou2MVs5HIUFc0wU/0R3jRXa21OlwmV5RU6QIf4HaSRObGNRy5oJDfMLsfcDX8C3e+GU1pilMc2vCQH2P309EfjLkfPcwwdeqh3YGHT9fR8AcdXO44RGBr53iui8DVV3QP6Z3Jiqb3EDuu8m5+IWzYx0KqcoCjFknPUnK5sJ3xszmTuehl6khQcsA2TaVM/gn4BAh33yTXsXmBs+ltAl/f6xyYWlam1WlRKiU9nuaV04qWU3MCKB5o5xugrG4wMH3ZuX0IXVve0eXGfWQoT+G4QBHuFwgAb0iuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cloudbasesolutions.com; dmarc=pass action=none
 header.from=cloudbasesolutions.com; dkim=pass
 header.d=cloudbasesolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudbasesolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tITocF/7SPXaaKqCt3scYqOY3BuyCzqgj6dIqCfJs5w=;
 b=OyKve6TP4/6We9C1mBTM2d7k+csGl0us2QuQ61TrwYgifTnJYYESgm88ubN+ceCNVVzOaITiQdIoay8aOZ4nlXWg7pSnStzD+/u9UT+YybvZ5dEg6l4x8fFzitE448Mg1j6jWLT8CZ8s5Rju8sjvIFuXgLpYO48M/vJFcRMsYtM=
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com (2603:10a6:102:17e::10)
 by VI1PR09MB3710.eurprd09.prod.outlook.com (2603:10a6:803:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:10:23 +0000
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc]) by PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc%7]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 10:10:23 +0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: Christian Heusel <christian@heusel.eu>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: Greg KH <gregkh@linuxfoundation.org>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "alexander.duyck@gmail.com"
	<alexander.duyck@gmail.com>, "arefev@swemel.ru" <arefev@swemel.ru>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "willemb@google.com"
	<willemb@google.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Topic: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Thread-Index:
 AQHa535pYp3Bo+hqVUSg9rCQdbX3j7Ib2KaAgABJUwCAAMoxAIAANjkAgAlsTQCAAAJeAIAAAvsAgAABH1U=
Date: Wed, 14 Aug 2024 10:10:23 +0000
Message-ID:
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
In-Reply-To: <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cloudbasesolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR09MB5411:EE_|VI1PR09MB3710:EE_
x-ms-office365-filtering-correlation-id: 8573f447-f913-4eaf-1669-08dcbc494fa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rZwlfgJqllBqVHucwq8iAXfbXnDRVG3ILi8RH58bxQdWpF70LV1/M+6KxW?=
 =?iso-8859-1?Q?NmMTC+jzrZKjLacJXOcSq5X3z4FHbcHCWYNseEgNZIo4GuvkWHIbQml9Vf?=
 =?iso-8859-1?Q?nQstt9NfILH/lLZ4Ewvd3rIT3mrHLjf1U+lAf7t7gJoG3hIPuu3qBahmRt?=
 =?iso-8859-1?Q?20JY/IQ3pPsGl1zRQDXeJbvcKqY/RZgvnl9SAhp4ScqdRtMKBlfZau8PRd?=
 =?iso-8859-1?Q?cdMFOjk2CA1xWd2+DwVP/AK9mr1ffO0wG1E36x5FiQdszvgdTBIUjK8j5E?=
 =?iso-8859-1?Q?ACySlhBoV1vK3vYYSEQksSgM/hzWMyfG1WCTr2Tw3XGGailtOw48Q2+Eqo?=
 =?iso-8859-1?Q?oQkoKP0ZRr5np9ajw61BnSYJl4vv8t/AKpF/4yQwhZNOx6S9GODHCuGbFb?=
 =?iso-8859-1?Q?l69/fiNyc900DHberZJk65YNN4pmXO4JpSmOaC08S88pblqyF8vwrzPk/v?=
 =?iso-8859-1?Q?Yk5dYNm/abwILwzcd7AvXmVWzxWlRNuKyla6zb9tv8GPolg6uX9z21aVfs?=
 =?iso-8859-1?Q?yQsE4Wcrt0L8Dei4BioUUf/kpi5IRiAcnYdrVTTC+uI8OlqGzS0yjmQRt+?=
 =?iso-8859-1?Q?AqRdaRW3HNxReGfC+3Z68kzpMwKRqnfZpmWsVARfGP8NcHml7vrNkmMOlJ?=
 =?iso-8859-1?Q?Dz6dmsKvK631qoE+CZooLukm8cIuPQhpMLxBwmxgpMy2Af3xgfYzcgBGel?=
 =?iso-8859-1?Q?tRgZnd6LhgLWafgOI+AJTR1aILX1BYEdK/5Vb0jQ7gKcMGVkH5/1FJ9faC?=
 =?iso-8859-1?Q?zw6UF24Hzzn5BMQeppCRr4cC4LTbL0y8ZV2eiWWlLZL7jL+xUtPYHcKqIO?=
 =?iso-8859-1?Q?nveC8XHqsTyFe5Bb0Z2e+NKNSShV1X5gkUwE8arxZnVaWfuz4+xvuQOQQX?=
 =?iso-8859-1?Q?rzRG7VLZWfVk61O6i4dBQovvk2rU7yk0FsLieDScpQP9A5Ie3k4Web5Oph?=
 =?iso-8859-1?Q?MKPs1NpKIh+BoGZlb0XatMUKC/yQMUcTDefCl6/am7IMJrR0K9c+f35y5E?=
 =?iso-8859-1?Q?3xVZViB+4vqkZn5aXC5X7yEHyWAnEf+/WQyU0yuG52JMBi7TAbuWQ5EHgF?=
 =?iso-8859-1?Q?BXipAaMrUXXGQNp66wOo7q8um3I9//rxdt9UY9WogKOLLAlZSgZ6ACXwlG?=
 =?iso-8859-1?Q?llSgpBO2z1u2p93VT8RMFF3IRbQlKCobhKA1Lc/Nz/aklNe2okdRaFR4sJ?=
 =?iso-8859-1?Q?7khNAlo40KZMA1elXAjftMqWFbmYgf5nEu503OZj8MEZ5PpOv1qQzoE/x1?=
 =?iso-8859-1?Q?qDgEoy9uhaxMeAZLW97OJLlXUZMzMqdbVdR1t9t2rdnRd/VrS+f7vhk+S4?=
 =?iso-8859-1?Q?/2DpJTvSSju+hLavaX4yA6HCb8qhxjcaLT0Csl2tP/kd2icJbVMFtCg1+D?=
 =?iso-8859-1?Q?RsvgmR9uCZOrrQrtW/MzduFjGvBkNOZ5gUMci8OWfFnbUGtsY4Me0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR09MB5411.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yg2K6ww8DSplyx0vGOplVv+HqP5fbrxWoZX5k4xMsosBL7T+bw2o7XE8wP?=
 =?iso-8859-1?Q?4JIaaXVCcwM/7ochzaeuKyhRe91zKv+vmacojbYYyvDausqgAiqF4s4MZj?=
 =?iso-8859-1?Q?i220+Dmlf1IsvAQFF/g18DrnqVGSi85NAich8515W5KRh+0O3/aipkgwmA?=
 =?iso-8859-1?Q?1kr1M/Ie7ah6Z+rYvWNefZkZ1D12T/Q4DpT5uUPOhkfwUIyOGGkAE7gWbg?=
 =?iso-8859-1?Q?UeApuC7xVZmudhSBCEnkVkfvVFht2skjgOwOpzKitVgmh0O866o5vurbhd?=
 =?iso-8859-1?Q?F679cmW9AMBEMVf9o/FUYGZWP6FILDV/zOhqiW1lLMCdtlInHueOblnJvh?=
 =?iso-8859-1?Q?bTwd20KmqVBPEbxZbq3RG1LzGgzVNGpxbguvXOtAVjpFLt2k1SEuovMcaM?=
 =?iso-8859-1?Q?nFYYTiFirubsUQCri0ae7+r5ThGV6egahkx8+a5IB600Jk8v2i+mkefpwO?=
 =?iso-8859-1?Q?2nBauOCMT0/RHUh/ky4i6/43W7F39069rIZfk4dQuIiFTW/KoQ9WCdhw/o?=
 =?iso-8859-1?Q?5/4S6QcN5sPGRjvrjI+laHf6oXAxXj8Cgy2xWYubjsvs6AKOjh7F9ZQBHK?=
 =?iso-8859-1?Q?HxZnOttpvhEKaMeqaUc7rQvQxsiKefJc8YjQkjOYEl1CQvU69ERqXHmVkN?=
 =?iso-8859-1?Q?VmDPvVSylc9TTPQv5FL9OY7UaNedohrq95tQZ5lun0ddYe2JEDhr1LJMI5?=
 =?iso-8859-1?Q?3t4B6XzaxMX3cAUGHr8jfgNsul9tQ6n7/xYmHfq1Uh3jyFWoVsuXRBJsSa?=
 =?iso-8859-1?Q?kJk0VxOA0Q7Hu75/kMEpffMXB54msvJEk29DcuM+sBHGFJxSQqjoCMnTG+?=
 =?iso-8859-1?Q?T7cL5gZ55eqaWRgMajnQV8M2o7WFBqWvULRFqouLy/uyciRPIstH/r02ID?=
 =?iso-8859-1?Q?l8dl7Yc1hWtsKcas+kKf2pOUk/kIFY//YVmeX9DJlXqea/Bmk3Js/ju23H?=
 =?iso-8859-1?Q?Nz658ZcdxNBVoP8ggG//zh/TYsmmYtIk7TvfuaDCIouP3+UH1UNzCdheJT?=
 =?iso-8859-1?Q?ceT5b3YAxSyIJa1WMW3wbM2F0allV0LwyL5b7ntbKpl6WvqdwTO8vnGUxT?=
 =?iso-8859-1?Q?6ttxmlr6BK2nnwMa3blCtrK1jVK0AKxs1mPcZialyiuBiwKiOKdrs8/azd?=
 =?iso-8859-1?Q?0sXCMyVvQloHJjXlD1z5VsIEd5G/tr2tjB6YFbJVMzRzRitdA6wQLkQyuk?=
 =?iso-8859-1?Q?fpvqUlxh8IZxgXTL6Dq8/PKHRWogQDZ6ytJvuJ3rEovf9Jx3+aOTFNoWy5?=
 =?iso-8859-1?Q?HB3yL8zDn7vKAmZk1d6SRNyxz9MbENH0x1ldJX6NGXEC9faBXIHDOdFrgx?=
 =?iso-8859-1?Q?deVAI/Q5ZaroRLkhoZP8fc9Sx/NhN+Pncadd4ZdupFwCn9uQiOYI/97aW3?=
 =?iso-8859-1?Q?8LTnZ0w7gNQqeLYaKDPUqqJ04mDnyDpWiZO6OH/v6fky3MZOBwu2tO9gM8?=
 =?iso-8859-1?Q?GWiq0sAw90JH/23JnWHp4qIl90a8c84Q1UW4S+WSAIN2KzAixCu2jgiTr1?=
 =?iso-8859-1?Q?A1xNsXKDRLJAV06cfgMqAG6tz06I4i0GMOlVzuIvzD+glnPBpa7C+Vtl5V?=
 =?iso-8859-1?Q?FZrsFaubKy5q+/0sqhUmz7DPfNlGpwV6MVs47qUgCTo/EQ6yjrdMQvg1lV?=
 =?iso-8859-1?Q?fGbqFGJWAJljuLqufhryk5+vG/miDV4A/S48i06xeDS0RJnZPQmtqp1g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8573f447-f913-4eaf-1669-08dcbc494fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 10:10:23.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c94c12d7-c30b-4479-8f5a-417318237407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl3gpUZqpQKzSIfRZ35dKotOyHMt4Zhm61srnnOXS5yxvxqw75RslVldyHb03n5zyTMeHVGtulKcE+Z/m1eZa8K8ITH7H1LmPmTI9E0buVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB3710

Hello,=0A=
=0A=
The 6.6.y branch has the patch already in the stable queue -> https://git.k=
ernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3D3e7=
13b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.=
6.46 upcoming minor.=0A=
=0A=
Thanks, Adrian.=0A=
________________________________________=0A=
From:=A0Christian Heusel=0A=
Sent:=A0Wednesday, August 14, 2024 1:05 PM=0A=
To:=A0Michael S. Tsirkin=0A=
Cc:=A0Greg KH; Adrian Vladu; willemdebruijn.kernel@gmail.com; alexander.duy=
ck@gmail.com; arefev@swemel.ru; davem@davemloft.net; edumazet@google.com; j=
asowang@redhat.com; kuba@kernel.org; netdev@vger.kernel.org; pabeni@redhat.=
com; stable@vger.kernel.org; willemb@google.com; regressions@lists.linux.de=
v=0A=
Subject:=A0Re: [PATCH net] net: drop bad gso csum_start and offset in virti=
o_net_hdr=0A=
=0A=
=0A=
On 24/08/14 05:54AM, Michael S. Tsirkin wrote:=0A=
=0A=
> On Wed, Aug 14, 2024 at 11:46:30AM +0200, Christian Heusel wrote:=0A=
=0A=
> > On 24/08/08 11:52AM, Christian Heusel wrote:=0A=
=0A=
> > > On 24/08/08 08:38AM, Greg KH wrote:=0A=
=0A=
> > > > On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:=
=0A=
=0A=
> > > > > On 24/08/07 04:12PM, Greg KH wrote:=0A=
=0A=
> > > > > > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolut=
ions.com wrote:=0A=
=0A=
> > > > > > > Hello,=0A=
=0A=
> > > > > > >=0A=
=0A=
> > > > > > > This patch needs to be backported to the stable 6.1.x and 6.6=
4.x branches, as the initial patch https://github.com/torvalds/linux/commit=
/e269d79c7d35aa3808b1f3c1737d63dab504ddc8=A0was backported a few days ago: =
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/inc=
lude/linux/virtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b5=
6c1b64b0775=0A=
=0A=
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/commit/include/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f=
6410471efc1dd71b33e894cf=0A=
=0A=
> > > > > >=0A=
=0A=
> > > > > > Please provide a working backport, the change does not properly=
=0A=
=0A=
> > > > > > cherry-pick.=0A=
=0A=
> > > > > >=0A=
=0A=
> > > > > > greg k-h=0A=
=0A=
> > > > >=0A=
=0A=
> > > > > Hey Greg, hey Sasha,=0A=
=0A=
> > > > >=0A=
=0A=
> > > > > this patch also needs backporting to the 6.6.y and 6.10.y series =
as the=0A=
=0A=
> > > > > buggy commit was backported to to all three series.=0A=
=0A=
> > > >=0A=
=0A=
> > > > What buggy commit?=0A=
=0A=
> > >=0A=
=0A=
> > > The issue is that commit e269d79c7d35 ("net: missing check virtio")=
=0A=
=0A=
> > > introduces a bug which is fixed by 89add40066f9 ("net: drop bad gso=
=0A=
=0A=
> > > csum_start and offset in virtio_net_hdr") which it also carries a=0A=
=0A=
> > > "Fixes:" tag for.=0A=
=0A=
> > >=0A=
=0A=
> > > Therefore it would be good to also get 89add40066f9 backported.=0A=
=0A=
> > >=0A=
=0A=
> > > > And how was this tested, it does not apply cleanly to the trees for=
 me=0A=
=0A=
> > > > at all.=0A=
=0A=
> > >=0A=
=0A=
> > > I have tested this with the procedure as described in [0]:=0A=
=0A=
> > >=0A=
=0A=
> > >=A0=A0=A0=A0 $ git switch linux-6.10.y=0A=
=0A=
> > >=A0=A0=A0=A0 $ git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0=
c50e=0A=
=0A=
> > >=A0=A0=A0=A0 Auto-merging net/ipv4/udp_offload.c=0A=
=0A=
> > >=A0=A0=A0=A0 [linux-6.10.y fbc0d2bea065] net: drop bad gso csum_start =
and offset in virtio_net_hdr=0A=
=0A=
> > >=A0=A0=A0=A0=A0 Author: Willem de Bruijn <willemb@google.com>=0A=
=0A=
> > >=A0=A0=A0=A0=A0 Date: Mon Jul 29 16:10:12 2024 -0400=0A=
=0A=
> > >=A0=A0=A0=A0=A0 3 files changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
> > >=0A=
=0A=
> > > This also works for linux-6.6.y, but not for linux-6.1.y, as it fails=
=0A=
=0A=
> > > with a merge error there.=0A=
=0A=
> > >=0A=
=0A=
> > > The relevant commit is confirmed to fix the issue in the relevant Git=
hu=0A=
=0A=
> > > issue here[1]:=0A=
=0A=
> > >=0A=
=0A=
> > >=A0=A0=A0=A0 @marek22k commented=0A=
=0A=
> > >=A0=A0=A0=A0 > They both fix the problem for me.=0A=
=0A=
> > >=0A=
=0A=
> > > > confused,=0A=
=0A=
> > >=0A=
=0A=
> > > Sorry for the confusion! I hope the above clears things up a little :=
)=0A=
=0A=
> > >=0A=
=0A=
> > > > greg k-h=0A=
=0A=
> > >=0A=
=0A=
> > > Cheers,=0A=
=0A=
> > > Christian=0A=
=0A=
> > >=0A=
=0A=
> > > [0]: https://lore.kernel.org/all/2024060624-platinum-ladies-9214@greg=
kh/=0A=
=0A=
> > > [1]: https://github.com/tailscale/tailscale/issues/13041#issuecomment=
-2272326491=0A=
=0A=
> >=0A=
=0A=
> > Since I didn't hear from anybody so far about the above issue it's a bi=
t=0A=
=0A=
> > unclear on how to proceed here. I still think that I would make sense t=
o=0A=
=0A=
> > go with my above suggestion about patching at least 2 out of the 3=0A=
=0A=
> > stable series where the patch applies cleanly.=0A=
=0A=
> >=0A=
=0A=
> >=A0=A0=A0=A0=A0 ~ Chris=0A=
=0A=
>=0A=
=0A=
>=0A=
=0A=
>=0A=
=0A=
> Do what Greg said:=0A=
=0A=
>=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 Please provide a working backport, the change does n=
ot properly=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 cherry-pick.=0A=
=0A=
>=0A=
=0A=
> that means, post backported patches to stable, copy list.=0A=
=0A=
=0A=
=0A=
Alright, will do!=0A=
=0A=

