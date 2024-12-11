Return-Path: <stable+bounces-100505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64C9EC0E5
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B791641FF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308A17C8B;
	Wed, 11 Dec 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E/OwNHdm";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P+0Lvhps";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jk8YaIqo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5C3BBC1;
	Wed, 11 Dec 2024 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877243; cv=fail; b=rQyD9Ku2440IXh8aVNVTUtyKJNFk/Fu2/ZY+b2ToKh7DTWCZ2CUnDb5GN11xzkgkW6PP1+hxkUU2t15XIkvTL5mvN31kYlkqeOWkngSwV1+PPiT5k690CdcDC6s1HAo7sFStIukxzJ4OELFX5jOTXYAIQTH1lWqiUtG2UUMAR4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877243; c=relaxed/simple;
	bh=sSZcQgfa401XPqf7oUhu6X0w/bnPJ6vwltPa6jXWtiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKvTABZ/rYJ9DBZzf2OQkpcGWd1LGuPpR+Iy+qq4dZXZlznDNUtMtQRsec+y239YxE7A/zw+Uh3Q+UjYPxJxLTCgUGfriXdY53Reo4RRExlp2EliEDL8AMgY2pzE6OrrAl1BN9ze4tKgdEl29BUA+fjJIKYNdJ0sP3ICFB7kHyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=E/OwNHdm; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P+0Lvhps; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Jk8YaIqo reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BALFNFD000621;
	Tue, 10 Dec 2024 16:31:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=PJKDdsTF0kra+pLyUPR388wNz+mZlI7CvrfoFFRCRFI=; b=E/OwNHdm/Nm0
	rXyCaQvqO5Fekr2+N9/IowZn7plGhubnxVZEW2Zwf9El/MPHx1nQQ46j886W59uI
	71sbQKIVPWLSpqJwBPi669VlNe+RcGSNOYYyAnrxGa8jzclrsUHRH6XPOUKBb2en
	aMP/Bm9lTwIzfHGdJHEWpN8EY9dySI6169bx13jRa3rr8Ifje65FmHlzKW40trgK
	/VDnzuflfgXSFjk1ym85Q4btlhgiigMxr86Ij4FOgX+7FghIn/kG+Qr/daffQ2vF
	+hi1nniN24jrujyyW64GK0AfsX7dK4b+sKmcXjPclC6ipwoow5PfF86hlqx7TcFc
	6sME6kK6Gw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 43cnvka12c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877113; bh=sSZcQgfa401XPqf7oUhu6X0w/bnPJ6vwltPa6jXWtiE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=P+0Lvhps7AY7oyEnBIQfl4nFvVw8xIGxw5F4Tao3KCp9mISXqF0NQTUSD4ZKrYNn0
	 2e7cQJ0w5IoIDDyl0Oro351uzoix4hhmcV3/ukJ0zSoAlULttvndrdjmQw5BV+GYB7
	 q3sOOEhV7/Fn1YLFrKCUZ9JO06Ta3JL/Huv9bzuABgdbQ6tZkClm3pE2fSh9+GwEkV
	 7fpGsBTDyxUrQtwN9OSAR/Ai33iZTvXxayRbzoC51G7c/PwaVvTHOMELerUMFoHKvy
	 OJzl8DzzdT4hE8YocaoX4WeeuHRS4tJ6ria+ZYhBYWKVjbUKQp/ZyfrCeZoCzkqUaC
	 iGtwoOdt4uLOw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 217674012B;
	Wed, 11 Dec 2024 00:31:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1F052A008E;
	Wed, 11 Dec 2024 00:31:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Jk8YaIqo;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A52AC405D9;
	Wed, 11 Dec 2024 00:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeqetPbO2xi1OTfU8kUU/1hcsowfK7MTZKn4C/ECtvIWjpQipknNcIV3jjIS+3okwavPQzR1+w1a6CblBPmSOyv4FVUs5sL2uBztrsd7jp/5rYTS1ySJeJS89v5nKuuBUifICi4ntDF4oL1OhrKAXJ1z8z3uOjf+FcZgR3GzBEVFldU+ulSpVpXOoJmY9o9kEUh7VLIBdV5b+JF9MBwmg67er7bXwM8+JvJWKSep1z6isJRVheDckoWQKbhIoPlm1W4tZ5PupU23+a7Ga+AkUVTtfVGivBpTqJNWkDh+GLQlNF0motEuwUCAIqAXZacZFb8lRcbdsjr5LGIOjTdaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJKDdsTF0kra+pLyUPR388wNz+mZlI7CvrfoFFRCRFI=;
 b=WBXMMKh1XGVjHyMXETwvNQ7zcT0uo3+BQ37urTF7Lf/ognn5v9XXXx67tLenSrSS0Jn8LGK+oYrJu8rEf6aZmmSrdHeCkHYoZMTn2kg443fh/zO3fhjsDpjct+K9ZO6RCwSMlBs2/rY8DaqRQzR1cJCHN4OBN1zqNq7HXK2qtGgvdyEVHVoQ/wNvCGN2IF2lADWXPZ3WHzfLrXdNbO4z/W8ya3uz7M6LfiP9Z2CZmufPVuT7q+2ci3frTc5zhEyBuf3nFXpRhBtB1JC+wFebLgBBYldFjzuQU/5eWq6yFj4A2HcIB4weUDxM6Txj2kql0RcgXTye4TFEU4TumCEzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJKDdsTF0kra+pLyUPR388wNz+mZlI7CvrfoFFRCRFI=;
 b=Jk8YaIqouY+/XMqHPfO9x0AMfjxjFAWZ9VXx4mQKUoi2fLO4UR8hWk/PSiIIPlK4+fd2O2yBZScGhGG/1xE/lCJEgX7l4ygdZyAVo2A3pAJtbK8lko2WrGAH69wuKqBlH7HSuPxP8k02338MIvCr1ImJO/YFY2JDztwoxunADpI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:31:49 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:31:49 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Homura Akemi
	<a1134123566@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: [PATCH v3 03/28] usb: gadget: f_tcm: Decrement command ref count on
 cleanup
Thread-Topic: [PATCH v3 03/28] usb: gadget: f_tcm: Decrement command ref count
 on cleanup
Thread-Index: AQHbS2QQ+qdsN5JPhECrWm5VgZOR6g==
Date: Wed, 11 Dec 2024 00:31:48 +0000
Message-ID:
 <3c667b4d9c8b0b580346a69ff53616b6a74cfea2.1733876548.git.Thinh.Nguyen@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: 86281425-46dc-469e-31bd-08dd197b335e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?o4vEmysh67kjf5QmCB+EUqSN4VjROq86KPHJD6uWVWFXZJ2+VWQWqcGHS8?=
 =?iso-8859-1?Q?s2Ftnuv6gRjoUGSflab7ri8gDUKNcTpgkfqGOTvy6Q3PdKpUXyU2bgX8mF?=
 =?iso-8859-1?Q?+V8ZQWH46MqsjNEYNhio7uWZp87vo/LZgcxZzFIxRweyHYERZ7oLwotCzm?=
 =?iso-8859-1?Q?CdmQW0BlOs1GbjhdKOo1OUF5S9ENimYVc4kZwox977Yk2MnjfahD105BFk?=
 =?iso-8859-1?Q?gCBZS39n9ZtLF3DrG4cQOL2fXXtbos5IZRTE545brryxScVQ/VkgJnrQ4I?=
 =?iso-8859-1?Q?ow/2pmkhdSO2bOHWb0JRh3MBSCdrTcbxo/xq63rhuu+WZMc13OyKOO7tY7?=
 =?iso-8859-1?Q?hMx2sOMbj28hfX7XIbn7JWqSZKca69GKXvFsRdtCvLHSAMulPGIzgsZTiK?=
 =?iso-8859-1?Q?iCGicwn6Aon+ChlYjB33fNO95MYrQD+FHBxMGTcGiw8NuromBwHPABI7+v?=
 =?iso-8859-1?Q?YgeefhXkm2TPvs2Kkei4DGAT1tJXI/l7+WkqkB0KesyQEtsyLv2m805tBN?=
 =?iso-8859-1?Q?YgkvBeDcxplHqbu/O9GHpAUIp5nwB5L6UnG1OScRUDbrEUwn+BZ79/N8eH?=
 =?iso-8859-1?Q?jlh2gB/DtvG4r/xzyJts3mDJSjWT6AF6T0wyM95BYOtug94GzcMnTBJxsW?=
 =?iso-8859-1?Q?WhMGTIWZZm08uzwKj3Qb4QBv3B7q3s3tc1bYO4jjAU5Zf5H0MIoPiCixnq?=
 =?iso-8859-1?Q?VpX9KQ15mHE868afgJ79fgzQusdUaY6UBiwh+jB/GJNYpZaRW6JlAlGkx3?=
 =?iso-8859-1?Q?kXSjBixgmI2eKQZGXGl0bO7gJePMjNVWO5MLh6quaYaqw8c0L9QDrOrPPX?=
 =?iso-8859-1?Q?LB+Qm4tAq8rbJ/wY31HsTJ2Xel9AufvzRQi2eiTR2CpOx90/yu3MxTQ0al?=
 =?iso-8859-1?Q?+vdH5vsVeqnUmoGZftlHLDHsm7xMqdi2tKvi/+2RSYQfrgFv0gxBnl4uRT?=
 =?iso-8859-1?Q?tulb8jECgiLYwSOiAuBLzWPg7tbACnQ3cr5Nzy7IfzOuekkZgOytyYtAye?=
 =?iso-8859-1?Q?JFqt3bz/z8tXs9C4kXXCGC/kkHizQrsiarML17j1YAOfdqHpHumDMQEB8P?=
 =?iso-8859-1?Q?AxEe/zaX86f9CKG4C1YzRGlyNjvkTNKJsYl6yQxqASICgScXzul7I2i4sD?=
 =?iso-8859-1?Q?bTP3pSudEIXNdcbavDHluuYekmYfzIWwncMLGQEa80U2wpMypgJ1k8Sysn?=
 =?iso-8859-1?Q?fX3wLkCvPnV5Nh3Ww+/USsVrjoxD1lwMlgoYqHocpjzxlFDD1f0t+TqDly?=
 =?iso-8859-1?Q?1jNI0QyIav+/fvrzATxt4QTzjaZsTZXoQ2NnnJKq0WNW28Cf9FcysGvZAW?=
 =?iso-8859-1?Q?E1s9Gdr90FfMXkYa26c6QUds34Zu9LFN/7Z2gVpWPUTG3r86e0mGk6hrMl?=
 =?iso-8859-1?Q?JZTL2MGZcam8dVjMG6SorFWPJfzD5OcqRuNbuEHcB5HkL+osedGfeVwVB1?=
 =?iso-8859-1?Q?5nO7KNcDNsGppoaeJ3OsOuxe91dHDCXdYDLk2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ItNhfQ1RpCoebqUE9WdwBGIYFEVbxtPx6jOcUB8U+JZi++pE5NFWi5728I?=
 =?iso-8859-1?Q?TdYWIhkcuABGijU4/lQteo3Vb/3Vlnwrjhf/MuzRUyl+pKShSYYyzFf9I6?=
 =?iso-8859-1?Q?7LL/XkyTfp1tZq39zSNqhev3HthrNP+hqrRcvFygdi61Ygy5rA4Mcp9b9B?=
 =?iso-8859-1?Q?EkLJmhRYak5nu55OpdEywDeV5T9mt1tRmTY5f15pxuQrEFodv3oO1sgQqN?=
 =?iso-8859-1?Q?Q1RyBcN+JBbyjTv5oakqQ0dQIzpvOQr5bF4y/QQcb7I2XoXVY3yx/t52fM?=
 =?iso-8859-1?Q?lw0LlKIpaM7ECK+g7uOmVUvWbeI8ua6t8JIxTQOhUo1C4pSdIZSVdlSnrO?=
 =?iso-8859-1?Q?GPWUYgitsfp9Vkrvz/KG/gztS/oxSkV8ghDyiSTALM6VP45OfZL3cBE+Vq?=
 =?iso-8859-1?Q?DmRuBu0CtJfGpymZ4l0LCCjIRoVAhrQg/6WnZ4movAqC64C2FHbBvUe2uK?=
 =?iso-8859-1?Q?tJBMrPrOZKG1rdezxTOkU4E7qaSNItlBlAC7sK6ktq/1RUwpuooc6GCyo9?=
 =?iso-8859-1?Q?YQnYzhdI/06/dU33uQIrZLytOpwnnKbhBPBQim7wMcNs/QXt6/Ukmv6iOC?=
 =?iso-8859-1?Q?/wkxe2qe9/MpzkqMAzKfmZ+vD7Zad4ce9AxGt266j/1Y5sGJU+Cap9O0s4?=
 =?iso-8859-1?Q?jVfJ8E3rjc3Mwd1QIrJ4nLh/4X6iSzSA4B2ltXnngVvsdfsHFhclTAlDXG?=
 =?iso-8859-1?Q?i0XrayPc/iEv2YLbQgLjofSmhwq0nbTgDJfHuZeYOU+bAkUooybQMRYOny?=
 =?iso-8859-1?Q?k6o208oEiyUbp4faSqV3r6UQ1XJkpztXlQ44wHr3nYGDVL2ZCkZT4OPsHg?=
 =?iso-8859-1?Q?hdwebKNH9bUPCEk1kT3gVBNlx86gujUUAa0hh4rBv9gZuSuE98TTB44+qv?=
 =?iso-8859-1?Q?d0ooFx1brJMd7t4JRPAMzJLX3F3ofqv2AapggzZ2fjrkW2evV9o5E36khM?=
 =?iso-8859-1?Q?6KQZb+O9KY4r/9FfLLJkUZa2W68NVDGAyZEEva4rRCC5ikgfR5/Gp3wlKX?=
 =?iso-8859-1?Q?oVxjOs8ASfhS2c6guoqDetVYr7fVjUwHGeY+a8PRJYn3tmUwTFJzyYuSjs?=
 =?iso-8859-1?Q?g6Ap64d0fGJ7mNzktBhX4pdJw3itz1jufQvtelRQT7LtV4DWE7lNRyOw70?=
 =?iso-8859-1?Q?mJ2bLylZfdU0Q/3+TWg0NY+19QQ1m2X4/s+PoUClbzsS3ncR26+CI6yF6M?=
 =?iso-8859-1?Q?+mg9DX8/n66N5vdOUUubb3H/aGuSf/Rqu9R50tc5ZZ6pFyJiTP80JUlEnf?=
 =?iso-8859-1?Q?EWYETSlyTXd/fWqWb0JU/w25UJ4iVsiKCejvciyUJ9DBlNxPLkiE+KlEM/?=
 =?iso-8859-1?Q?bmXZQkaHJo1uhB1u8ETUS8+12Ssc5l2kvoG8/wRPhNogIenw7DAovzmLuA?=
 =?iso-8859-1?Q?pLR70cd0JMfgpCPzncgjcwtZswTWx1x7wnSOBpv0WgBOfTKGBRa+Nu9B6U?=
 =?iso-8859-1?Q?M5DVa4AnZYNWVlTJfXkPQk+gJmOXNGJ2QY46dPtlF3NbsadGSj369qftVt?=
 =?iso-8859-1?Q?yFkBEZJWHVXRSP/ZHFnzL2nSQ+kn7K3QKCPL2d82bl9MylfqW4UPOXAOtm?=
 =?iso-8859-1?Q?6S+LoG1fucf6Z7Xjer/lhHQvvhoOynts4AmpHqc1W8xx4nBK3/gTVPYOaA?=
 =?iso-8859-1?Q?pvoDqvJeTHRM9MSx6RR9IlAXVdCGQOEfXd?=
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
	wKMa91mBRQgJdwpnhlM5mzmN1K17x9SqrqHxlgwe9NFP72TWtKxEriO0ZUYWizvAP4zOEo32y87XND46jBZTHrbPCh5gGbXDLsy5i0rwMXOECkouduN1DF10TpBmIed+WxTA/KfDGmOdde60AOXd6+uVMGwR7uGGqkfD7zfHBbsoJxY81AffgXHZ9cFti/v0SrhPA4y9Nia4vI+neK+n9t8bI4LzRvUGDV+dLJDiCGSk8ki11k52xg54ofP66rVZn77LxZf3CSIvpUaJwsULuL7gWLRD5OV8Kz7N+XSd/E7LHDqQgh1AYogCEXCJv7NfiokLpYL8rYL0W9yJMOwJC97df+sOHnLzzVFU91+dJz9QQcHA5EwDd5j+yNB5jk/K1CyIqrr9hBMfYFbINQCPjH9ehAj7j8hDN7R2UVFGpF+y1yT7jqy3M1CJWUsi1oJAevYahtmpl4/vED3/gjHk9oKvDHm2C5DRBCT2xRn/Nu9QbLfvUrg7hUFHF1bA94UthYpsd7XYwShEPjDCsmEAsr0PAgEJWVZckbUSxMY9W5cVFa+4lxzkRaCI01b8AQ4cGElvlctuazynFvyzDpX+VmfIqIx+BJot6jrX0hLiVJyW+6NFYu6RmP+fdCI8FL2zgkiCx/LFIj19uP92QnHYuw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86281425-46dc-469e-31bd-08dd197b335e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:31:48.9717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMGmKSaBUJb927g6YebhslvUloXFk5nrexlLDkZZ4qpJ5txEaK/faGjWxRcyjSi5UGAUrfEOQ9QTiMcbhUzOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Authority-Analysis: v=2.4 cv=fNPD3Yae c=1 sm=1 tr=0 ts=6758dd7a cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=0cASoJX2RylK66VWcoIA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: prSskLNdXrIn_g-u-pBfA9yMXi78fes1
X-Proofpoint-GUID: prSskLNdXrIn_g-u-pBfA9yMXi78fes1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

We submitted the command with TARGET_SCF_ACK_KREF, which requires
acknowledgment of command completion. If the command fails, make sure to
decrement the ref count.

Fixes: cff834c16d23 ("usb-gadget/tcm: Convert to TARGET_SCF_ACK_KREF I/O kr=
efs")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/funct=
ion/f_tcm.c
index 88b8b94fdb1e..5ce97723376e 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -969,6 +969,7 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, str=
uct usb_request *req)
 	return;
=20
 cleanup:
+	target_put_sess_cmd(se_cmd);
 	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
=20
--=20
2.28.0

