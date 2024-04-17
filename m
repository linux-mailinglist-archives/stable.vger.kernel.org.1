Return-Path: <stable+bounces-40131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8E8A8F3C
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 01:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78490282971
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6258527B;
	Wed, 17 Apr 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W/0fz8NT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NAavk9SH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wkxqf/W4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BA80614;
	Wed, 17 Apr 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395676; cv=fail; b=vA+T9F4xxtDP6/0KfUUHhMNh0nl6Q5Ln17cZK8xlA0gy8MA+hb7HqYWcHFHxP25ygOYGuOSGdUsJ265naFFswGxyKFCE1VbsHHE5tzpWZCoYO7HBki4GFoRM/Wri3avmpsEgvJBWlGJxbZp2ITRHgh38enMnyagN0YoTOfJ/nSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395676; c=relaxed/simple;
	bh=LBCu6xMYPp8v4rW8DlZ/6gRO1M5gUUuBdEV08uY4WIU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gTZo47OEyzbq6CyPMri/m9OBfWwfLbaOs9P2vnYZpHWP7Y4oaKVCiRv/inw/fC8BaO1jPSuSgZCwB+Iba3jfg3bKIvCS/vEckwkMpUsMFlIZyz4SyOdcYWCDkOjk0t6nhd9uzUowRzP/KfZjeEo2CmOp1fTNHMhGq9VrxPQ1a1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W/0fz8NT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NAavk9SH; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wkxqf/W4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HMZsak008289;
	Wed, 17 Apr 2024 16:14:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=LB3G
	nKFmMjtZs5/JJSlWW27Ih1FIhC/7Xor+Px8bepk=; b=W/0fz8NT6KJ57JfzDNpB
	sw5R9luomAHk9F1Igb3WRlL0pbnudf4Kl5Cb4AgtnaAyKlHqiqiJKeGalD9fjAHs
	LrQucY2ZH+kUY3W7501aLT61nMu0hwXeTGYuUXxSY+2CGoDIB6YQLqJmye7FO/E9
	l1HToGDLB3IeA1ObDh4XaNrLsoUnEnZ2mIBzqGgS+i9cBUYmuTJNDT2cN0+uNBGO
	I0xnDjl56sHdXI3fIT1L5Ignb9hGZJqs24foQjafnrKHvrxU6JUbbL0b5uGGx/YX
	xV6rsWLN/ryANOulatxGgjrgkGbUCSw+UK6Epust/nbbwHCKIIM+CUDRolcDwDU6
	yw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xjgkta7wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713395670; bh=LBCu6xMYPp8v4rW8DlZ/6gRO1M5gUUuBdEV08uY4WIU=;
	h=From:To:CC:Subject:Date:From;
	b=NAavk9SH2/St5AgBvzu0fZJrVOm4bx7NQ7i2sbvyXCKDUSeL7/aAwiYo3Ea+cWhC4
	 EO5+QBkOnNjxvW8gBFmqBCoLEFI25Uon6kSqvy3OvDStop2pvnJxkXcmlv9KE7Ip3y
	 G4H+hPXdibso16O9aKOqmafOt6XcSKCmydLOCAfW+Id8a7aszVCUpbVfjnF6HJhPpi
	 h7a7CIx5DWCfbIfNHmRo6LX6z9Pg9PNYK7u4/H2rTnSJixxU3buAMMw0p7U9FrtJHs
	 1pUjSOq1EQ36x9Q0XvLz2bvdZlD0iYn+BiShcv0CLj2cNn4+jcPN+zDpO570kePnbl
	 qHC4tcDxS42Nw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 797204045D;
	Wed, 17 Apr 2024 23:14:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2BDC8A0076;
	Wed, 17 Apr 2024 23:14:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wkxqf/W4;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9879140349;
	Wed, 17 Apr 2024 23:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMHpPCra+X4FvccklZBIxsl7pgeQ99BXyNhV/jJ7q/xMUp6tzyVRMxkAY62ZCBlwDwJ9Cch3QHC+ECsODB5YqmhihpLXtmmNVNa/eb6SFKy1y3Ae3kumyA7YyBzooAo4UPuZokOaz2v3vGxl1mRMsYGM9SlQaZp7f4LI45YMhpnF3mGVVQxt8DzBLVy942CEJqoduUtn2Y78e4ndjONTbG2o7HXAv6oEPx67a1tEqIOFQbkyLeHggw1fwdcRjFklLjeu2PRuuAdvcPEJfopIJyHR4sPR6LNtikhnYzb796i75zyD9G5PBvVwG0X5/xFNj7p+i4sQw0h4ut1dBF0UjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB3GnKFmMjtZs5/JJSlWW27Ih1FIhC/7Xor+Px8bepk=;
 b=UrTa+Yp7qszMgSYz4pi1Skj5153FW4mkXa9FVmFaga73RYwY8BwuukZBsdrOE+7TcXYJ7E/VjkTUrN6f6LWMgH2wKdSLBirYXIp3oAQD7W9L5CX5p4lTOMZPYX1IHi+pKeclPnf3VBdxWrhAegDegN1GFGgQWNqyQgR2Sli6XLhogKeYcW4awDCq+/77GgiaDkDgC6hsoQrikma7ulWtl3BmHLF0SKMrjI8QJ21/JizNJ9t2uFYAXWO4UayPptxlqYdj0K4BSMaXzBaw+ehY+jVYAk68ZtfZZREB1aeS1AyqV4/3Gj1DnDxq0IoqMG8b05JpSxczPjdFF40aV0GkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB3GnKFmMjtZs5/JJSlWW27Ih1FIhC/7Xor+Px8bepk=;
 b=wkxqf/W4DrSSXeGgciLOY5RpUpXtGLXT0miVEDisKegDHkddWz3szQ+O6ei2+Bc9b7Irdpjq5vUAO3SfRVq62ZR8Xt0G95khKRxpoZtM3SnizXAeEYCqSErOaBfE3+ygTA/ijAgSX00ygCe+FG3BcGGeuxOwbuuILQXwNgDgS1o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 23:14:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 23:14:24 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 0/2] usb: dwc3: Disable susphy during initialization
Thread-Topic: [PATCH v2 0/2] usb: dwc3: Disable susphy during initialization
Thread-Index: AQHakRz8L9NOrtU42E+s4HQlUxHBKQ==
Date: Wed, 17 Apr 2024 23:14:24 +0000
Message-ID: <cover.1713394973.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8320:EE_
x-ms-office365-filtering-correlation-id: d9fe3237-2852-40bd-5877-08dc5f341f57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 48D9aW0rNSPQC5Il9dxwNrV+8E/jseCeNM5i9NzlGypzj4XRvgpSwQFHWpaZ1kY5Yrff2PYKXkATnjYrt2fqyLU0yNkb3WqtaKUlBOcWulZAQBdl6uZLKHaipEl39ZOfNRDUZX+Ij5G4N29JYmC+V5O2cVspZfonxSqR/C9BJg8b8GMPngbB4SMl6S14GgDW7zsgDmhPmtCbUzGkXaQf9krODQJPOelASl0fQg+bLDn2WeP5RHSd9RfAANZ/CBYEYo75JOus02HI2NhGjLbj7Kmw1QAZLDX98llLmGHeoNwxdnYMd3P+8dTOj4IDRKcVdrCFuyY4hWAhORG2/fnhYYRNjmn7kNqxDWlGk0F0575hf9WNcDKVzB4N8XBxg6FeFrbboOO4SP2WMtXwpiTlVF84ofGEBluKETSs6WzoewvqzR9wxBU8pSgfYUH/PjbUc0Ong0d8BWuphreRMmojoGM357HlKy124xMHWzkp6swCty6GZZOx5RI6aJs8igJRnei9FkRehsj95Bw7lKkc6sT/XXaccDHyJIu3FAHfSzw/4RakLx5V9nccC9f19l1D6DvBwdrT1zhuHlgbKI3t5Munl59KiaMgxAxBfZU3CNt4Fq6U/1hx24tONOgc4dbVm0KB9j6pIKw16oHv8vUs1JoeGBSaWr3DFHHAoqxPr+j27HaWLOVr7ADLMeco9E3t4wm16ZSjYwrESkq0Fpmqo9kqiEkKcisb7gjtylmeEgc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?+Jli1dHHn5TxbNqBauQO9jm6hhXuWLLeA3NkYkY8YMZyZ/BWLpe+o8XKgS?=
 =?iso-8859-1?Q?M0M+DbzSO7WUrJwBju90B/8c7nsnbfLM5EmvpKW+SZMz5htwm5A3gKZKbn?=
 =?iso-8859-1?Q?0HWZK4KVLNM9AsVqG7lRP3PYom0dcIPUg5XTOy3Yacdr0xxjs4VLoKedaV?=
 =?iso-8859-1?Q?WN5n8S3ikTq2Wnw+NaiAkhxLSngr5aXMqArScUuhK2C9pkZMvKLEZaXKUH?=
 =?iso-8859-1?Q?gDoIC26jCVbZyRQl6EnVVMR0ymzBx9b+EURu2rm8xbONpV4Rh2mNdSFFcK?=
 =?iso-8859-1?Q?q55CauOJgYi1aPIlYmavnRpg+CCaNzi1hSXPKsXoocMP8MpvBBOrzFc/X7?=
 =?iso-8859-1?Q?Q4i8LPPB20df8MvkB5VOw4zS/0dV++5Uj5DbLXhd36NhKNlzp5Eb4EusqX?=
 =?iso-8859-1?Q?hRpvm7ykAO0aXvxzEiVo8UCSxP+/kqF2pZr2iLV77fKi8p0pkZHrguQKxz?=
 =?iso-8859-1?Q?aYKhnYbhuiQHbE0wV43X2/VlOx9e6bxemWVz8phRiS6IB9T0KLxHTWCGq/?=
 =?iso-8859-1?Q?OKHE81fsTynlF1V3F/jsHOZbNMNKWh+bglSqcGaffBtrlO0enkr3+5b/uE?=
 =?iso-8859-1?Q?Hh/u1MtOvMJlSL52+Ol1/uWWadmPdZeJctL8gIMeZle9vRz7gPKjDAEqNz?=
 =?iso-8859-1?Q?XjbQJWr3TdWIpPP9sCOzY+R0SHoUxLzFtYvfmPi0ohfyLuH0v2WJhsVhqg?=
 =?iso-8859-1?Q?IcV1hHgQ2Yj9CtR9gsKM7vQiGD+cPqohzlVyxjCr7zQVXAAP8p8Gy8LQnQ?=
 =?iso-8859-1?Q?QBVOwXu2X4CNXONCwGY5tDOKig8Jca0T2QVjFIy2WQEIMARXAnrrvrB1jC?=
 =?iso-8859-1?Q?K/UbyC9XNKnI7V1zgX1js2L/qcmFkcfb1Gf9honNoOH+liPc8DnewOt2IB?=
 =?iso-8859-1?Q?iAJ/QW4WH62Keh+OHMRjeK4jSFiCRQXZx+akBFeS+xOSWl4B7eVJ7E3dvc?=
 =?iso-8859-1?Q?5af7NchlvYx4CgGti2yNcY+HZwwi6ltgqdBaTdsz2on7+kaRDdd25jBC7W?=
 =?iso-8859-1?Q?Bcn2rT1UwbwLIQRc1UEl4b3+tbJA+9Cxv/mhDNuNnRWkcyoQq5/gU6dh65?=
 =?iso-8859-1?Q?3W1bBNljGNPXatdhPuqP1es5qQ+jLAS5giW6AVPiN4La2De/QMU24aXE1m?=
 =?iso-8859-1?Q?N+7G0sL1OveX/mcX/gkMkdDZATvVy9AZaGimnfPm7MXnBOYXAPUqiZKwl/?=
 =?iso-8859-1?Q?AWcJtiZ0/RygWt0USvS4iVrBha0BadjEL14EP1DzQlA6L4j9IReinFcM3i?=
 =?iso-8859-1?Q?Wfl+rhbf7CFM3nEaFP5eLEGWJYivWWixanfZ2AkB5qAH1FZcPaqFK5F6Vt?=
 =?iso-8859-1?Q?ruESFiNGbNiDwb0n+IcJ6KqNgEtP8gqF+JmdIM5bP1hv+3R6fcFLZ/FgFi?=
 =?iso-8859-1?Q?olX3Cmtj8vumraPvGdy/sTkwv59ImpDMOXGuUGpiw29Qo0iTo/T1BrLTku?=
 =?iso-8859-1?Q?E1qVbuaCe3yAhnceHq2IzHI/Z31Sg8YMjEhUQhCq0T3eJ6PTduzuEinLny?=
 =?iso-8859-1?Q?AHt2xDUJZSdTNAdXGtNyMvvnNTn5MWIuG8pF3RV2zqpkaJly3htJWPt4Ny?=
 =?iso-8859-1?Q?XBMkE+VKxI20lFRJDfvcnjPryXpwVQ1OaZF/quGfKvJ4z1NAOuyJAGSViO?=
 =?iso-8859-1?Q?CQRGJMdl71MnhHikS9zm088/JrgbdMe0FR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G6IdF28+LoL3Na380v95X7qFOv44HU0Ql3vMeOfW/JGMZ5q84PzUXzp/JGZ9Dd8J3lnXNh+CUfyIQ4yK9Y5Arxk+79YAmSgiS1TKfsLbDQQwbVKbdlBC6r6Z1EuOQXDmyHJT5vXv6MViTcP8LnjdBHdMpXKm5/P/IuMOrpM4SgD0zHALzWVrWmBXnkvR+oP70M9hKtXOSb9j3HHd4Z5M8/4fLmNLqUpybp8vY2Y4WGhArIEBvNUuRUEu99Z/chuFPVqdXt2HjX0c4q+H8a4LKU3LC9/ovn0WUw836pqO9djIza+JAb2d1QzrWdhGw+oYiJ7W88RGqaaB21/WIoqWEVnXpdg+YYK3QlupJEw2LtDbm6T9zPQBVk0fuHXi+B8I7sCFGfR5txFoKqZ4UO89pydK0s+Bi18ikDf9c18uEEJK6IuBcMq93+zMU2UssgTnvSD6GdFwWrZGOjwSi7GeWlIZbdAc6MVm9BAy0QtR8/q6Ij9j8zic05udDYUdP+ZcaTqcK/BFxbbHBMhfdzyn/u3eQTG+XXG8g84RdFrCYdQQCRIFV98VAGySqJ/IlgZoo4aFTDnyDnfQT6ou1HB1rtBK7gTJ69a9caOfu/lh/2s3GvcOtAYLNv7XmMAfUCWlWDk5UrvSIunreiGWWjRvQw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe3237-2852-40bd-5877-08dc5f341f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 23:14:24.7934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LIcuccWlKAXfgpuKbyZd0kNb+fKZUZdWiHefzg/IhoBPRP2tyqBoxI7JS8H3DHKmS04bt7brbm2hDd179fRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
X-Proofpoint-ORIG-GUID: g-W4ESmOdmy8YRNz2FyecyKIPWIsEWHa
X-Proofpoint-GUID: g-W4ESmOdmy8YRNz2FyecyKIPWIsEWHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170165

We notice some platforms set "snps,dis_u3_susphy_quirk" and
"snps,dis_u2_susphy_quirk" when they should not need to. Just make sure tha=
t
the GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear during
initialization. The host initialization involved xhci. So the dwc3 needs to
implement the xhci_plat_priv->plat_start() for xhci to re-enable the suspen=
d
bits.

Since there's a prerequisite patch to drivers/usb/host/xhci-plat.h that's n=
ot a
fix patch, this series should go on Greg's usb-testing branch instead of
usb-linus.


 Changes in v2:
 - Fix xhci-rzv2m build issue

Thinh Nguyen (2):
  usb: xhci-plat: Don't include xhci.h
  usb: dwc3: core: Prevent phy suspend during init

 drivers/usb/dwc3/core.c       | 90 +++++++++++++++--------------------
 drivers/usb/dwc3/core.h       |  1 +
 drivers/usb/dwc3/gadget.c     |  2 +
 drivers/usb/dwc3/host.c       | 27 +++++++++++
 drivers/usb/host/xhci-plat.h  |  4 +-
 drivers/usb/host/xhci-rzv2m.c |  1 +
 6 files changed, 72 insertions(+), 53 deletions(-)


base-commit: 3d122e6d27e417a9fa91181922743df26b2cd679
--=20
2.28.0

