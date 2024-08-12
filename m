Return-Path: <stable+bounces-66546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E594EF90
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E68B23665
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B3183CA4;
	Mon, 12 Aug 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QzejfaU9"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E8183094
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473006; cv=fail; b=QvPlf0eOKOk8UpPENi1Rnd7UVdB2K8Sl7Kexm9GHjO8NH/LG68elVf0UffyxTGo6ADBXO27DAyukUy8iuyj5LKz2d60X4SZL7bSDKyY78Wo5zBDwaD0e2pQpAKqYpcNuPn4UcDvFJXcSKM1JsogyuECxEWSObkme2zYp4sjw6x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473006; c=relaxed/simple;
	bh=vDquGzY8qxttA7NN7m1xh84I/fssa/R6mDSFu+Ll0fQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SShnMKHI0oJTxpwpjbYLPR3xk/w7HN0o1rg8u6BuuRwzZrXdQDJiKRiyFlq45ly8FPoP0ZxH4ut2in62fySyfLkLRoQ0wn/5AOSaxE39+UztOtuZBV1G/usUojLT+TBNZ3U1skOuRTkFWkPgpDkI8gW128rIh10FXhYn+EETp98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QzejfaU9; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iodVv/18wfRI+jtTye3nD6yeqftfF1FBsRMz0lBs3EohLmrkmbDOl7lEWfKkmrSLjP4zSqKzUt2wz3vdqkQj4twelaUHPH3TYcJHMfhTYOn/jIxX9q1DCQxicqnUnkVhGx5kxUKWONabYqQMW2+FS2cWqeW2iDqbe2wBA/89nVUzAEire1kaJIcDhWAh74Hd8G9YahHqfpehbTTbjGxP+38tJX/UOz34WyhEEmTiKMnGIvQaHqI6M991YLUvmfpsvTc1DIm6viVYKbWyrk59XzGJ2BDw07bfRrKv7GSmxnSAdCnnj/aKvAnm1mL6Im5Curls+AW+I4mtO5fz3Pymgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDquGzY8qxttA7NN7m1xh84I/fssa/R6mDSFu+Ll0fQ=;
 b=kopTWboBxnbNa6UjiPJRT3JF/S/koWXx0GAOtuowbWtYTHr8M2FZ3cH3Hie36eUN0OK59i8EvSn+Bo9+cJz+C/D8HVKcl8o0iBh8TnTqCcZSiwYoGIf3Yl6TwB97IHdPT/T/1HF/KT/AKe3ZYI0AByhMD5Nq8OIxOOm6SRTDkk020+ordE2r/gZ4ROREE0haqD0PnPjG0xw93REhTogP8Jv+hZAv87hKhXTx43HaRWFMQ86D0dD4jCFgZdnf/mdSrnM/sWs78sN3jZE+mWKKcGIe+nwVX3yguLz8fyXBvuWywXYaYwOHG86TeadThXEZVQOQIWJ2gXxVnxS0kM6mKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDquGzY8qxttA7NN7m1xh84I/fssa/R6mDSFu+Ll0fQ=;
 b=QzejfaU9mx7VgjXKrJEsxqQ9zv7EaaOEWUN7X1l2WX0FIOWNSk5YAMfNOeOTRQNMwRMGb+EqrdwZYEH6XGMPs7+p1jl+xIjBRIFqy/7jfJiEj/P1pnUYLXaJatbeNxooDG5Wtnvg4FrRWx61hL69q8QGqVdxFh7hhtrXKkk4PHU=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 14:30:01 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 14:30:01 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/amdgpu: fix locking scope when
 flushing tlb" failed to apply to 6.10-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/amdgpu: fix locking scope when
 flushing tlb" failed to apply to 6.10-stable tree
Thread-Index: AQHa6NR1jToxWrlDN0q8sD+gOVZffLIe8ETwgALkowCAAd4gkA==
Date: Mon, 12 Aug 2024 14:30:00 +0000
Message-ID:
 <SA1PR12MB859927992245170E20E489D9ED852@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <2024080738-tarmac-unproven-1f45@gregkh>
 <SA1PR12MB85999CF5386E2AADEA301076EDBA2@SA1PR12MB8599.namprd12.prod.outlook.com>
 <2024081132-sterling-serving-8b4f@gregkh>
In-Reply-To: <2024081132-sterling-serving-8b4f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=a15102fc-d148-444c-9378-0099b0081a0c;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2024-08-12T14:29:01Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|MN2PR12MB4286:EE_
x-ms-office365-filtering-correlation-id: c7970300-ec0e-49c4-1d44-08dcbadb3fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JUGZ+/Xss9V+M78E1873S3YI0vdRAXosG/wZysEZ8W3ZsoZuNVraKPSjgDvi?=
 =?us-ascii?Q?rwwT9N7BkJ8ZrOEeBhlbu8fU/QQIrBSPyzbyGkPSakqv3njqDcdjXNm1XneA?=
 =?us-ascii?Q?KolPcBT3RYyTKyxZl8XK2rOMVfnyt13JhS/Fb6mn4pICry/SCsX28muLmeKb?=
 =?us-ascii?Q?hR+5+fZt93ozND8QrOov10uP9y5ve4LA3RdRN6IrEgwYrjPuksODyoplYTaw?=
 =?us-ascii?Q?G0gUEwZjNgNDdaS8h3z85l0+7TuduFDSS3COuGFjTAatXhG9xA42EdZ1bDye?=
 =?us-ascii?Q?J90GHE2DPhYuRgBXCSXSYKXzRjONx+ukoWuXfTk54io6zL8mGCIB1ZqOX5ll?=
 =?us-ascii?Q?WlLneysMklqPIfVbod/NCrZUE+X4FVM0d0y7H62JY+WrQ4XPjJEd/3V1gYoD?=
 =?us-ascii?Q?Ijt3cJe/XMtE6XLgC8+TeH0C2i3IKb9KjdCzZzZf6ZEgqMJrQ8VpGahHt8Oi?=
 =?us-ascii?Q?MeGvrs8etAvuRCTC9qeZoB4JFKaX9nhmqvuEIyrJ8kaH48pX5mzOoP6MU5nm?=
 =?us-ascii?Q?D7ewu/7gu/3iCiv3OBRHw0p+cpBZppTq7bZAYMAU0X4XrdjywEnGETgwua4w?=
 =?us-ascii?Q?OVMl+jQ6NKVlwwikgJ2bqXV1n/C+b6j1Ql6USEIqo/ra7kuupBPim6S2D5HK?=
 =?us-ascii?Q?RS/PeQYXWSRZu6I0qHTJByjR4mdNYqG2QoPz1BS6o1WRwiTBg4yHux9tpVer?=
 =?us-ascii?Q?ieTCdsDd/R4qSxROFjFoV6E/oBHSUrtbSMY7/0UMB3Q8fA4IxK4p1BZ8kAj5?=
 =?us-ascii?Q?IG+XbZH+8ulat7402lQbv61oQmIafa90wB4BngE811YDPZbLnYLZkmp7g/Ij?=
 =?us-ascii?Q?uOKoz9yWcFd02KdfYlxR3Y2/s9c7qU+G9V0y6v2Wv5PCQZOrsF2EsIB4NJWi?=
 =?us-ascii?Q?l5tJmZOxa35L5umIpOCZKpSQgksVXEqObJMGt7MQQ+KPZJV7UWGYhPbOOyoK?=
 =?us-ascii?Q?BTZS+juX1spycYyG2SYTGa/URi3un5JZLsr7FB8HZ1JDrwPvIdjd6wzCj0yw?=
 =?us-ascii?Q?tvyWgRGdx6eFBAApiCFhI4fpsscnY4v8T8nMnxYtjE48CWuIDSqeI7ydGT6l?=
 =?us-ascii?Q?wJyCLoaDw/pCdSQwzhwj+laa01weLM0tvLzAD/igkktGSUe3cs0Fcs/zNTrZ?=
 =?us-ascii?Q?z0GbyePYFbsN/gQzndR/+o+MEA7qZUyFypD6k1wbV43dP7hTAhypMSCMzyFw?=
 =?us-ascii?Q?iQlBlnu+1+qwsQ969t4JFA4RlHo8FjBLH9kRPF/0NLFrXJQXcfjPX+FlAbqa?=
 =?us-ascii?Q?OVMqm4PLaFtZ0aegwAg0kSiM62kozdLIA4WEq/bb4WSO3V5ZNqvEk8bOmJup?=
 =?us-ascii?Q?JhdjXjiMpI3DAxPsm94PMWcY+jhw+p1CFWe3w4tw96sAjMTKMu80aHsug+/b?=
 =?us-ascii?Q?GeFumtffdf7pd0Nb7UfYzJdXnQlfNaGtl8+jh6bMD6dH00/syw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pYXu8LLLJsH/ALNtwHj3aA5hFFUSSTxSiH7P7MpQ1uNRD6t99/ydjsFQl8v1?=
 =?us-ascii?Q?sNHASzNaUBEd8do+MvIxPzHlwOv2oH/Js0wN6M6XzTzY/iL9e84i5FcTw0Pg?=
 =?us-ascii?Q?2dpyTdEEPVHwje7y5LpplHsx6jakCpAYkaZLLiuhaT6n0tsaTUpApy3qvnYU?=
 =?us-ascii?Q?RMDCHWo3mx3uDERzdHlK40c9itZzHEbXJwKfy0j5qrqL1bpn4w2ENot6WKvN?=
 =?us-ascii?Q?6tvOb67r/rbry7JmMlZcpvw4ePWKOZ40JimlpTGugJZ29X/+aQ5a1yhqOgeU?=
 =?us-ascii?Q?h750gDGi3gE2xYSXl90AP5YjOpeY7lMYpnTR+xzv5w4idJ/DgktZ/n0M6hV7?=
 =?us-ascii?Q?rlYV5QpFJwMem+QSJsCDXzyG65qhW+I2IsVzK+TwsrsIoH8ozAnPEQuv66rr?=
 =?us-ascii?Q?zNMc0c0SlrR2wp7KG80rj1dq7ZXiFDeCaYialX/5QopjpVrWL8hI2bNDZzXX?=
 =?us-ascii?Q?DsuUt5LuY4Qd19Hl1sFVCUn2ePjtfzPyBZWl/iHL0/S1ocpFkXoi/nHJc8TA?=
 =?us-ascii?Q?fj1icQLpu37n7F36Bz+oWfCjA7hQUigzSJ7kxSoLMF8LIiEnx5BaqS9wA5MD?=
 =?us-ascii?Q?pQH+o3x6qyVE4vJqeAxARmcsdUgpzEmcQZ3VpCwzeNO7qXm1xeFeYr72U5B7?=
 =?us-ascii?Q?V6G3IVfWwrw6FRstEPVeivJB7yAmaW8aniTBPvKzeRwXYVHKMbXbH5M4vXcS?=
 =?us-ascii?Q?0Fxoy4/LN5tGwoMO9mQ3cQRqX/TeGINWYZXhusGXYTTaQuAa7Eoy+kz7JieS?=
 =?us-ascii?Q?CRlOa8Erpm5ShumwSroQwqoqVnj50GkcUcUYeOl2F4wOgHel1oZSc2JkZyd6?=
 =?us-ascii?Q?V/bu2qg1cjrG9h6PYXfGvmX2rrYyUNFYrH0p+JTXseqKIqKbBzPazMEQ0IID?=
 =?us-ascii?Q?0eJ3QXQnNOxTf8X8TbxAqRkPI/xUH73eXR1zVNskrsS6pkIuvo8/AFFg1Dvi?=
 =?us-ascii?Q?mxR047CtsYFuISo1zgEiWCj3TIOpJZ+CkpqyJdZ7eSSGlkaA/pYsjhRRxgyC?=
 =?us-ascii?Q?aw6syO9LCWG1TAFszgFJ3j2slCF5/0X4bpNaUIEXL92sbpMuVT7nZ0w8btFW?=
 =?us-ascii?Q?+b4c8VLKQcJmELPzFwU53TU5u1aF4tBRWduJ7TtF4TT015TxEDs8BwCD5Eua?=
 =?us-ascii?Q?azTblSuLhORxNIusHs0eD2rErPNJV/KgJjSc2WuO1B7wes+DIz+O2P7BIisx?=
 =?us-ascii?Q?o0LTGb05t8eSR3j7GzyzDTgcwwo7BbkAguDGrCTNiLvKiY9O+4iSHDssirfY?=
 =?us-ascii?Q?wtd6KHZarXV1zJpUrvxXhBCwfEo7asBkRjifW8GtG7h4nAfkoN56Y2dyqKO+?=
 =?us-ascii?Q?6vYDZUGCf2h1xOq4ErPT3L50cnPYzarekvfG2BXoL1yZNJJ43IuwOXUtZOy4?=
 =?us-ascii?Q?0C6nr6IHKw1+GXYJMP++/lx6ozrmLT0n5Qk7awyAd+Gtm4ZIHPODy0Kow9kG?=
 =?us-ascii?Q?nIYrJF/IhhVWATIXLXI1NhTRTz7m9VcPOEzPUrF/gEz+jbhJHw9R6uBBSqK4?=
 =?us-ascii?Q?A3qKzHs/ybE1q/cWUy6WJfB3e9sk+ulwSQdSCv1HPQ2G1mzIdUjpfk7LFvwm?=
 =?us-ascii?Q?3QMv+4dDEGqEEmAIilY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7970300-ec0e-49c4-1d44-08dcbadb3fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 14:30:01.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJLkbDTmAW9/6bWmpinC10ecHMOR3VsSHtDPetFwMi3Imj0rEJZo7leyQa76jUCdeZrxpdLbtn+Hidf2iFd3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

From what I can piece together with git history, it seems the patch was bot=
h in amd-drm-fixes-6.10-2024-06-19 and amd-drm-next-6.11-2024-06-22 and thi=
s caused the double commit. @Deucher, Alexander

Yunxiang

