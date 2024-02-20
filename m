Return-Path: <stable+bounces-20789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E261B85B5C9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 09:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96547281847
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5095D752;
	Tue, 20 Feb 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GLeLqfbZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ca/BUdSP"
X-Original-To: stable@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC45D743;
	Tue, 20 Feb 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418990; cv=fail; b=nSHz3i9daXZzoF0uKZeDUJmPPIzU2hBt2ZmADrh7wZWsYdUcbPRrkhyAIHy6yd9hI7y9ZuIPvAq/yWD623Nffyaweou8OfYAXTQR1I+Jk8VdYyxO4i1F+UwpFxzM+6oiZc4sFEIi+qz6IN/7qWEj9JBSpmu/O7CgEc32kjvqztY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418990; c=relaxed/simple;
	bh=IY6Dngrt+eKciGuuGoZj1DM0+je2T2O/rPhowNH+1Mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=csoFc3ozP2UZaEC+B4/diZUntyavdU402kW24GlC7DNbdfJ8vm4DQaAuKaSLL+Pxv/xGiSumRkRJFxrvxQ/vL2CTGJt4dmpkVlbZKuZXH3IZud8JBJwaFi8txoW8MN4r2axKZN8ugUHJTS5NjCffWwGZyy9V24t5Aifde13DUqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GLeLqfbZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ca/BUdSP; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708418987; x=1739954987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=IY6Dngrt+eKciGuuGoZj1DM0+je2T2O/rPhowNH+1Mg=;
  b=GLeLqfbZndBinUtGOhmCUYcj4cJhzG0x4YZzVcybm6R51YcdNS397evY
   ZX8mWCutrqY/rGoDtIJSjmk0/EnePdH42FM4tkUIV21tvhfHjd2sfyNpS
   zGiPZxYtUDmAHa52ppVjemBfxexIi6kstItgBszpV0tD13oYtQiiApAuN
   +rSgkxY1+qKwXJS8nOw40qqKSmyH9+27B2wxM4OXTc7Ub6CogofgXzHPC
   FdGQlpZLsQq4KvLh6IvxS91Uxh92KZaIX+U/bvhmWGYr0jNvyxQc9tVbn
   BAoyaT50AK0fyXH8viF4jpI1FtB5QgzDKffJsIaittzY1V20mP2krIodg
   g==;
X-CSE-ConnectionGUID: xs95Oq2pR8KCC4aiSB3QGg==
X-CSE-MsgGUID: cSoaqp5QSlWcG2pPfQ7QNg==
X-IronPort-AV: E=Sophos;i="6.06,172,1705334400"; 
   d="scan'208,223";a="9602984"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2024 16:49:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmb3Q/6ax/aTqO4GFh+pIDqMgE2+xRQVwGTfdUpvuiCOvs/Lb2mBVTc15R8N7LDMYThsDbgIwdVNZxiiMwzAytgYPQTFmEaACc+Pyl56vSGjnLS9/EHyZDYptRtcSAKyw7WHsw0i4bbHaQXfV0hZWgZ3OVRmA3GwgbIfc7BMSK/rSaDWcQ4q/6xLuoVVyYouMkxG1cHKsj9aBEKstO/PMRZNaMI3MH3LZHBmJJncJjV/cJBv0YgOygRSy3hwWKda0NXvz9RLhRYSyAHjIv8epPxXnomqG+Q1SaKww53TfAtfRXQGfRfI90iwcRV5j1Z5sUQ9nzFKG62IOEW31waZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+uBCh8pTi3RhIp+sjQk3+iF/OQMutw7P5tI7GmbFRo=;
 b=FEsnWN0ntNxoJYG4yRuom+SUBAGsFlqep/YfAfcrd1Ksq4W51xCKxIbhuOvQrEDv4G2ODrEOQDT4FlgEqI6gL2MCLIfsG3N5JpG734iOJZ0j7fsr2HqHhv3p3JO51vYjuaelbOI7lEoRQHyX2aS7WbeY/oazFklpqxLNCbowU4DpFJxSqyrwsKn7s+COOWly4q3S8vBno/ORRw5wdouy+BAr/RFVhJJy48PjKaOTEDe3sR+7KBWKFJ2CjADUm7sybpOyEfbobTt+oPuRopNH+oqiugJptpZlKZi/k01pvnrq5Efv8Bj9qm8n7fMFV7MkKD/5XGeL9GULp1mcG64H1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+uBCh8pTi3RhIp+sjQk3+iF/OQMutw7P5tI7GmbFRo=;
 b=Ca/BUdSPpU1UyBV0abnkCQHnTvLFM5EELANGkXZaJz5D8dgABlzRpI3FIWeviu9+b8Pjc0ir3iXlkacIic4l/gxF+7nSwcpwS5LVuYvtncKj/6CSmCEbGZXEUu7JpAsoHEHaCHNBnUi9Ht7iA44pEpEe5+qZ+IzbaB09SgeMGxg=
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com (2603:10b6:a03:3db::16)
 by DM8PR04MB8021.namprd04.prod.outlook.com (2603:10b6:8:f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 08:49:36 +0000
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::a115:b72e:ac9:d144]) by SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::a115:b72e:ac9:d144%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:49:35 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support" has been added to the 5.10-stable tree
Thread-Topic: Patch "PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support" has been added to the 5.10-stable tree
Thread-Index: AQHaY5wpg0k3+y0Ck0axD4mxK+Ekq7ES7DsA
Date: Tue, 20 Feb 2024 08:49:35 +0000
Message-ID: <ZdRnnp2ql+jRghlZ@x1-carbon>
References: <20240220012839.518852-1-sashal@kernel.org>
In-Reply-To: <20240220012839.518852-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8326:EE_|DM8PR04MB8021:EE_
x-ms-office365-filtering-correlation-id: c0d24a7d-9f6a-4d33-5850-08dc31f0dd8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9cjcyIlIrYOSHoDbihGFlqII+XVuMDfZRXTyDaaBGBce2spBw4319LChFQXsK1MPlaNYJKTgOAqsbrJDKNZ8y0PYX5h0puB2hl/HSsjHS5bGW9r0gXjY7+jwdpCXBAzsN8NckJiyz5g3xyJmS2kFKGLkIqWLWtJacfW6jzIzeyopf8IZeN638GcuCO7Z/Ay41/dqNMIxEJt6IUTp8jK23XXYpdBldKYzELx0QpmN1ygUc68/3apmcn+Fxz4G+ueRHH1sDdmHvhO/uFRmLdWThGNbkTsYtJFSoOAiED+as3sBlfzoHyAmb/F+f9H4V1LtsNOUEPgxWYXXGRekbdpnwelSMWdOWPYD6mSD/NLrws4o9OGIgYF+Wz+ROtOLfHW/1UaP4nLONZ933p93Loq2iiI+oLkM8LdMUGd3sFYVTEljSWauBpINGboX2VAsC66MaPDhiMZF6pIX9opjebgYz/qSPNaxSbcNd4bKukSJfMHSeNuST7+mw5HiJowWwtb9JI5nY7zJdMQaL6rNu4hWRa2bs6i59NUmyUmVn7m9QLwx2ecQEFxaYXo5WkyCK8BGH6TWKt2d4GZLonT8fxCpHHlIpuzkoJ6mo/7g3/wiH6c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8326.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?TZLr0pPF/bn90i/T/2bp0lqpwjEgSMqhiWFlIe/0627XrWVh2a7zqsbee+?=
 =?iso-8859-2?Q?ZZCq1dYHba8lV6jAJ8ltdOKhyl3jqgJqODKS8ArPkEkNUqNrUN79j2G0Yv?=
 =?iso-8859-2?Q?gzgRIHBRfZ0zsLX/vh0djnYHMVtIgl38I8/xU8GGOk1bpt/1rFtMpmS/r1?=
 =?iso-8859-2?Q?TkJ8Mhmabu0Bd+Ho5KidAeRbA3E0IxEgL6w5zNeOAYEk2pAMDDrh8jMtXG?=
 =?iso-8859-2?Q?MUgdC0EQkeGqGHpe5pmiONbbU/lobLX/j0/P4baWgVTJicz02/lYfCqUDA?=
 =?iso-8859-2?Q?v2VIFSr0jQZ2oDqzNg2efVxl78Z1aKXlysrOHv7DFU9Dw6LFTz7cEfolNs?=
 =?iso-8859-2?Q?E0gDkvPOYACUWIDQ/A2qYiGInM3UZffYhQ28N8pC8HE/LKKCavijoycEmS?=
 =?iso-8859-2?Q?QEAL2AdxTC7//a5tQNDB0rVfiNXDhGRgnCQF32e02gwz6rJIfOOmdg1+P9?=
 =?iso-8859-2?Q?xGzXEcAXK0KdEJyqyYrmqAxP7KrCRYYdlylIS+NcoOIMjTW1/HW3yQqzSL?=
 =?iso-8859-2?Q?2fhqiggFIqC2YmXiy9sgGBF9sA6PQKCkNUd7iqApkb1KY9t7qg3Dbxo+G9?=
 =?iso-8859-2?Q?BbuECdL78h0c9uO5VZ8K1Ikn4RSZPKx4hCRVALbjZbt9tMX0RB98yTqKy9?=
 =?iso-8859-2?Q?EuZztngYNtg10oIUHoOGXPtgXJeHC316ZhVyowUTv81xMC0T3hLDH9dzH6?=
 =?iso-8859-2?Q?rbHUYwR9iDJ1BP+CwspPCPDXZMCZGESX+EnkF1UDHZDadzawau+BgOuwaq?=
 =?iso-8859-2?Q?OwQG8AXUsZJKTzZqsclekioFenz2qvWpOXu7/elLoXgrhZa38OV5q5Xnl/?=
 =?iso-8859-2?Q?LUnMkQwbbu0lwPPnMGj3OipzRt/ApFqogVLlLDLIeLMwfOgbcID1Wh5X4U?=
 =?iso-8859-2?Q?I41TrGPxfVpi5/LELh04UK+owmk/FQ9S9OGXtjbENayevAiKsqeRvep9ug?=
 =?iso-8859-2?Q?k2WvKbq7dzk2Oeddl7jcoa8uSMovGtJ/9QOeep/RLUiIX5wRqjiKMqmObc?=
 =?iso-8859-2?Q?8/rlxHL97sulNAqXEN2JuXD7XGbYdL5yR/kvb5iCnwT2V/ApCrdBEKRxKn?=
 =?iso-8859-2?Q?WRMeqMJ2NlA5lp45RE2d6xVASwfY7dklnnYKp2K1OmtSDJSj2mW5j1tSsb?=
 =?iso-8859-2?Q?Omh6JP3n7wcL9xlqs4ni0xH/5WczObh5L431L4mZJLi1Pe18ISkCS6ivMI?=
 =?iso-8859-2?Q?8bRGmPAWUsUMST3JmforBfApcsrYveTEtVxUcb+wIoCaVSpsBKXgwOl5pI?=
 =?iso-8859-2?Q?6QlHncpH7lgqOdX5RsGKWXOWmnX/tZTbNQWHFAMch/CWIwhfA/bt20Fn2m?=
 =?iso-8859-2?Q?dbRvBpEcwkfBjwYuLBWlMNSx9L0pLs8U/XaP3raYjjSpEQy24wll5K3XCO?=
 =?iso-8859-2?Q?/RwDLWjNosgAgM0tCBNKNXDpGEhwrUwOJ4fDPiQcjm21V8ZU5/BWZowAIK?=
 =?iso-8859-2?Q?kp5PW+UzViWuYeFKmN2BEJLndEy/RPPQvnLKWbFF8oOVBOpsWDgVwmpQW2?=
 =?iso-8859-2?Q?XtAZl4hVzWWC7tkkRlswKj9rw54KazEK8P9Qz/kbJAuxSykD6/lG+OjVPN?=
 =?iso-8859-2?Q?T/FmNrKFHIDL47ocxoQM3ONd3SRvNlG00HBp4rGP09rL8vFRUmUd6+YlLH?=
 =?iso-8859-2?Q?d+S8QaWbSUAA3gxcaxqm46PQOn7xH4TQ1PpSrf1Ad9jCR6vWlGQp//mg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: multipart/mixed; boundary="_003_ZdRnnp2qljRghlZx1carbon_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zo1Dr0MFCh8rISYSnGdZeSTMyxwa2Vsjn4THq6N4ruX45V+MSMIel/qkXeRdXpmOjzSqKjO+HXOH7IS45xKyifIjEJZYKNArVtgl2yMzfFHQdSfbsVJVdfUwo8PN/FPZftJ3efMf2ZHL+B9VXiFHKvMKb+kHf4ltH9hUDl21USYEcVGpvLBD3Ttd4fEEoZ0MO7gwjSu01TmsZa6x2rAjC734X6IYh7Gkf2tYU5y4Oo1ARmR6IZYK1ir8ryekyJIM2jMr/ENNXLnFn3awMnqV3cpBXoW8+YNAaKxkZ2iaTCXOKX/NGm3V20UtobnzEN3bpMxFejAxEOzPgHkI4BVS21lyGPfz8S/6uaxekkg7JIe18gEcW0PHK3IjGe0MlGX3vWF2KJYJJOtHK+mj9jILJa1vru3ab9BAcA78nsA043G4RJ89rvepkzfiwjfAzkKS3gJcdL0FE09lZOx3vrxhWRC/Hpv1QXoQ4swynjemyuU+Mi8O1R5FIbv7HQQEsxgchZ1OKo3HwmKXXbtnqLasbext5LTipYctIXoVkDhfEaoElRf/7uywmdkHsrFDAaRl7pRujdYMFLD5YKO12MmZH3uqcivJHAEsTqvluW+1O9t0Vy9v56ztxBEjYU4G8lCw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8326.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d24a7d-9f6a-4d33-5850-08dc31f0dd8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 08:49:35.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwuuPAq41Op/IDGAo/eS1ZTGBAgJpOMmANrJ+U0fvk+noULaF4Xfb403QVfyuGlDV0lKEpObdcwxoJwC1Zh7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8021

--_003_ZdRnnp2qljRghlZx1carbon_
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <CF366200A02F5047A4229C2FF8996328@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 08:28:39PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
>=20
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      pci-dwc-endpoint-fix-dw_pcie_ep_raise_msix_irq-align.patch
> and it can be found in the queue-5.10 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hello stable maintainers,

I notice that upstream commit:
2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignmen=
t support")

has been backported (as it should) to:
5.10: https://marc.info/?l=3Dlinux-stable-commits&m=3D170839241818847&w=3D2=
 (only queued so far)
5.15: https://lore.kernel.org/stable/20240122235754.541847685@linuxfoundati=
on.org/
6.1:  https://lore.kernel.org/stable/20240122235802.692374956@linuxfoundati=
on.org/
6.6:  https://lore.kernel.org/stable/20240122235824.991665077@linuxfoundati=
on.org/
6.7:  https://lore.kernel.org/stable/20240122235832.684822707@linuxfoundati=
on.org/

Unfortunately, while this commit fixed a bug, it introduced another bug.


This "another bug" is fixed in upstream commit:
b5d1b4b46f85 ("PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()")

This fix has been backported to:
6.7: https://marc.info/?l=3Dlinux-stable-commits&m=3D170836979506847&w=3D2 =
(only queued so far)

But needs to be backported to 5.10, 5.15, 6.1, 6.6, 6.7.

It does not apply without conflicts, so I've attached two backported versio=
ns.
(There was a minor conflict with the headers.)

backport-all-but-5_10.patch - for 5.15, 6.1, 6.6, 6.7
backport-5_10.patch - for 5.10


Kind regards,
Niklas

--_003_ZdRnnp2qljRghlZx1carbon_
Content-Type: text/plain; name="backport-all-but-5_10.patch"
Content-Description: backport-all-but-5_10.patch
Content-Disposition: attachment; filename="backport-all-but-5_10.patch";
	size=2139; creation-date="Tue, 20 Feb 2024 08:49:35 GMT";
	modification-date="Tue, 20 Feb 2024 08:49:35 GMT"
Content-ID: <FC7B0D3FF466364EBF120DCB2D2BC914@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjYmM5OGUzMGViNDcwYTkyNGQyZmQ1OWFlNjkzZDU0ODBiM2QyNjNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8u
b3JnPg0KRGF0ZTogRnJpLCAyNiBKYW4gMjAyNCAxMTo0MDozNyArMDMwMA0KU3ViamVjdDogW1BB
VENIXSBQQ0k6IGR3YzogRml4IGEgNjRiaXQgYnVnIGluIGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9p
cnEoKQ0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNl
dD1VVEYtOA0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdA0KDQpjb21taXQgYjVkMWI0
YjQ2Zjg1NmRhMTQ3M2M3YmE5YTVjZGZjYjU1YzliMjQ3OCB1cHN0cmVhbS4NCg0KVGhlICJtc2df
YWRkciIgdmFyaWFibGUgaXMgdTY0LiAgSG93ZXZlciwgdGhlICJhbGlnbmVkX29mZnNldCIgaXMg
YW4NCnVuc2lnbmVkIGludC4gIFRoaXMgbWVhbnMgdGhhdCB3aGVuIHRoZSBjb2RlIGRvZXM6DQoN
CiAgbXNnX2FkZHIgJj0gfmFsaWduZWRfb2Zmc2V0Ow0KDQppdCB3aWxsIHVuaW50ZW50aW9uYWxs
eSB6ZXJvIG91dCB0aGUgaGlnaCAzMiBiaXRzLiAgVXNlIEFMSUdOX0RPV04oKSB0byBkbw0KdGhl
IGFsaWdubWVudCBpbnN0ZWFkLg0KDQpGaXhlczogMjIxN2ZmZmNkNjNmICgiUENJOiBkd2M6IGVu
ZHBvaW50OiBGaXggZHdfcGNpZV9lcF9yYWlzZV9tc2l4X2lycSgpIGFsaWdubWVudCBzdXBwb3J0
IikNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvYWY1OWM3YWQtYWI5My00MGY3LWFk
NGEtN2FjMGIxNGQzN2Y1QG1vcm90by5tb3VudGFpbg0KU2lnbmVkLW9mZi1ieTogRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NClJldmlld2VkLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxj
YXNzZWxAa2VybmVsLm9yZz4NClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2
aW5lbkBsaW51eC5pbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFt
IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCkNjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPGNhc3NlbEBrZXJuZWwub3Jn
Pg0KLS0tDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMg
fCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMN
CmluZGV4IDYxYTBmMzNjNTljZi4uZmNiMWZkYjIyZmZiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCisrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQpAQCAtNiw2ICs2LDcgQEANCiAg
KiBBdXRob3I6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQogICovDQog
DQorI2luY2x1ZGUgPGxpbnV4L2FsaWduLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KIA0KQEAgLTU4OSw3ICs1OTAsNyBAQCBp
bnQgZHdfcGNpZV9lcF9yYWlzZV9tc2l4X2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1
bmNfbm8sDQogCX0NCiANCiAJYWxpZ25lZF9vZmZzZXQgPSBtc2dfYWRkciAmIChlcGMtPm1lbS0+
d2luZG93LnBhZ2Vfc2l6ZSAtIDEpOw0KLQltc2dfYWRkciAmPSB+YWxpZ25lZF9vZmZzZXQ7DQor
CW1zZ19hZGRyID0gQUxJR05fRE9XTihtc2dfYWRkciwgZXBjLT5tZW0tPndpbmRvdy5wYWdlX3Np
emUpOw0KIAlyZXQgPSBkd19wY2llX2VwX21hcF9hZGRyKGVwYywgZnVuY19ubywgMCwgZXAtPm1z
aV9tZW1fcGh5cywgbXNnX2FkZHIsDQogCQkJCSAgZXBjLT5tZW0tPndpbmRvdy5wYWdlX3NpemUp
Ow0KIAlpZiAocmV0KQ0KLS0gDQoyLjQzLjINCg0K

--_003_ZdRnnp2qljRghlZx1carbon_
Content-Type: text/plain; name="backport-5_10.patch"
Content-Description: backport-5_10.patch
Content-Disposition: attachment; filename="backport-5_10.patch"; size=2131;
	creation-date="Tue, 20 Feb 2024 08:49:35 GMT";
	modification-date="Tue, 20 Feb 2024 08:49:35 GMT"
Content-ID: <503DE78EDA6863488A90F8123554EE91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA3ZmY1ZGE1NzE5YzRkMmVmNjdiODljZGM5Nzg0YmQ4MzYxYjRiNTE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8u
b3JnPg0KRGF0ZTogRnJpLCAyNiBKYW4gMjAyNCAxMTo0MDozNyArMDMwMA0KU3ViamVjdDogW1BB
VENIXSBQQ0k6IGR3YzogRml4IGEgNjRiaXQgYnVnIGluIGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9p
cnEoKQ0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNl
dD1VVEYtOA0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdA0KDQpjb21taXQgYjVkMWI0
YjQ2Zjg1NmRhMTQ3M2M3YmE5YTVjZGZjYjU1YzliMjQ3OCB1cHN0cmVhbS4NCg0KVGhlICJtc2df
YWRkciIgdmFyaWFibGUgaXMgdTY0LiAgSG93ZXZlciwgdGhlICJhbGlnbmVkX29mZnNldCIgaXMg
YW4NCnVuc2lnbmVkIGludC4gIFRoaXMgbWVhbnMgdGhhdCB3aGVuIHRoZSBjb2RlIGRvZXM6DQoN
CiAgbXNnX2FkZHIgJj0gfmFsaWduZWRfb2Zmc2V0Ow0KDQppdCB3aWxsIHVuaW50ZW50aW9uYWxs
eSB6ZXJvIG91dCB0aGUgaGlnaCAzMiBiaXRzLiAgVXNlIEFMSUdOX0RPV04oKSB0byBkbw0KdGhl
IGFsaWdubWVudCBpbnN0ZWFkLg0KDQpGaXhlczogMjIxN2ZmZmNkNjNmICgiUENJOiBkd2M6IGVu
ZHBvaW50OiBGaXggZHdfcGNpZV9lcF9yYWlzZV9tc2l4X2lycSgpIGFsaWdubWVudCBzdXBwb3J0
IikNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvYWY1OWM3YWQtYWI5My00MGY3LWFk
NGEtN2FjMGIxNGQzN2Y1QG1vcm90by5tb3VudGFpbg0KU2lnbmVkLW9mZi1ieTogRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NClJldmlld2VkLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxj
YXNzZWxAa2VybmVsLm9yZz4NClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2
aW5lbkBsaW51eC5pbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFt
IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCkNjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPGNhc3NlbEBrZXJuZWwub3Jn
Pg0KLS0tDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMg
fCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMN
CmluZGV4IGUyN2JhYzYyMzY4NC4uOGI3ZWMwZDllOTBkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCisrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQpAQCAtNiw2ICs2LDcgQEANCiAg
KiBBdXRob3I6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQogICovDQog
DQorI2luY2x1ZGUgPGxpbnV4L2FsaWduLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mLmg+DQogDQog
I2luY2x1ZGUgInBjaWUtZGVzaWdud2FyZS5oIg0KQEAgLTU5Myw3ICs1OTQsNyBAQCBpbnQgZHdf
cGNpZV9lcF9yYWlzZV9tc2l4X2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8s
DQogCX0NCiANCiAJYWxpZ25lZF9vZmZzZXQgPSBtc2dfYWRkciAmIChlcGMtPm1lbS0+d2luZG93
LnBhZ2Vfc2l6ZSAtIDEpOw0KLQltc2dfYWRkciAmPSB+YWxpZ25lZF9vZmZzZXQ7DQorCW1zZ19h
ZGRyID0gQUxJR05fRE9XTihtc2dfYWRkciwgZXBjLT5tZW0tPndpbmRvdy5wYWdlX3NpemUpOw0K
IAlyZXQgPSBkd19wY2llX2VwX21hcF9hZGRyKGVwYywgZnVuY19ubywgZXAtPm1zaV9tZW1fcGh5
cywgIG1zZ19hZGRyLA0KIAkJCQkgIGVwYy0+bWVtLT53aW5kb3cucGFnZV9zaXplKTsNCiAJaWYg
KHJldCkNCi0tIA0KMi40My4yDQoNCg==

--_003_ZdRnnp2qljRghlZx1carbon_--

