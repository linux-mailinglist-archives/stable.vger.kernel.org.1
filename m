Return-Path: <stable+bounces-105517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DCE9F9AF0
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 21:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BFF7A246A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5322259D;
	Fri, 20 Dec 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bDlNVGcv";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b06ogoTd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nnfQAqnz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C3224887;
	Fri, 20 Dec 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725720; cv=fail; b=rqbdYxxvfzj7e9OXspwoghE7mQEb2mhp1fgP+b3X6BIP/KZeNefCDyQOuMfnRnmRwfrzfn8JezNNL7OUSJy82qZIFxTiQsK3JlhNKlaVJFgNEFToxDzLJLV9R5CerFyc50UneRL9y81LNH+q3N7hNngMwAdD9+e2sUd8d2IflV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725720; c=relaxed/simple;
	bh=5HMjUYhMQnjQ0+gdhYQfkWC1zMX/6MCkqQ1Gn5hIsxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4KE48WHDQEAL4V+248uNM3zWS2u3ndbHejjK2RoehzbwSuqymCSlaC5QL/PSw8uTHET1TLKWsbLy3gNnrLpJGzIrxV1Tb+KJqACbCKuSCkrlvAkw0XXGGjpR3ULGm7QR3rbwZOZ7QEuTN8zTVmcDX4nkEdUbf96P0Vn+RTKVQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bDlNVGcv; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b06ogoTd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nnfQAqnz reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKGswGZ019511;
	Fri, 20 Dec 2024 12:14:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=5HMjUYhMQnjQ0+gdhYQfkWC1zMX/6MCkqQ1Gn5hIsxw=; b=
	bDlNVGcv2sAMOdLHtYGvxRphRQzXavXGGrChXMowZB/JCFqLXkgAdW8hMWVqN3XW
	+7xoPdcWbbO8LBjZq6QCQ9AozNkdAx/fKqoJkGSX3xjdeyGtcU+jCW8irfsGoWqQ
	OgMw8j2mWIiiqHV17AHGLyEqnTZxYXsTuRZyBiJY2LXX5L348ODGz7PrK+/4w2l8
	dwsx3ChHEdhEN/wsCclkMaafoLwq6QzRyhT5gV2dAMtKA/XyfXmG6YHKxZqCjrgO
	ydlEpAU2LSBv9HVwxuifVL4UeH+NsrGAavqZsjO4YQ6VZrNcRTr/1UppvKlrhgIf
	BphglpVt3sN3xAcS1ZeYHw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43n6h1tv52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1734725691; bh=5HMjUYhMQnjQ0+gdhYQfkWC1zMX/6MCkqQ1Gn5hIsxw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=b06ogoTdt+I+MD6I+TrJrXGKWu660QzrcOdpn4ECaEgYV1mzjXEYFYYRZjf5NKq0F
	 QpjP7GE6+d0E20RSVz0C7fcJdBrNCUHIdYXHgLPwE01ZbDI3lLMu0l2CFJXI8vuuGL
	 KaLmwFOTVv08TDnzFq1tuEffjQedfUkal2s9VOTNmaqcHAZAraCh4X1uL28m/Xg8lz
	 rPrQCX7IvmA78eiXCPdU24gROxgDPDRWZOyMjKA5Pv8ERv9i1FR5M1EqiSfwzBBFo0
	 xkgRAUEduFaW5Xr/czew/vLOGMlYqXtNPPaO0kWmN5RB298aOgzCWG9GzffO9mk7AA
	 VNnURSW3xmWQQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CAC0240230;
	Fri, 20 Dec 2024 20:14:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 328BEA0099;
	Fri, 20 Dec 2024 20:14:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nnfQAqnz;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9C0E440AF0;
	Fri, 20 Dec 2024 20:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObYsRKCEJRI0Bt0W3QhWhVLUdceWEtc4FahG2jQrgd3eT/iWKB8GwHxv9GInR/LVIY19GfU+aFLDwam4jPsj/EkxyFmlmqeXZRk/ASEqxDE4W3u1Gg0E5gDYz+X/MgaohLYnXjmZnoQPgiAREmZitjYuYoCddCTrDff12VwDkvTZjJbU+M8cWtxiF5dNs0do0xRlIcdrKa9ochFAZf663PJE4mUcuNXJTFOhxny1Kx/eXBVbu/7kn6d9SscfBWC87xb/tGPSphGisqfRGH5J1GfKzDq9ZowGBn5YfxyCRlVYGcthOcVqWxGy+ewZyrMacvBL5nr8+34FysoR3OS+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HMjUYhMQnjQ0+gdhYQfkWC1zMX/6MCkqQ1Gn5hIsxw=;
 b=U5M0qHEUkDL9PNtOxBJddj6gl6x4ugxXQdH7vCS1PmtO4v88dxv7pN+yDP669ANGEpV5pYhdXLpH7R4lZL4eYesSXjdzfzKtHhs2WB+avHRqTnvRL0UHsg3hyD/qvD2Ma7AwM3BlYWu1OxPWmypOHIoTwDCb74TqQ5lIeut93pNGSuoJKGuI2AkqMFN9Ia4rWpYUXRY1UzpiRh5jCqgKpY89PPT6YoXkYOBMTePbTAoBsju4vHlNIZAL+gLATVSCUy2ESy+gDF/XJR78SmCL0mI77OhsjblwsYmi3/B7SYyjHjVel3Am7oecuthNCA9Pva5P+RmpOVnhvju5oCbAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HMjUYhMQnjQ0+gdhYQfkWC1zMX/6MCkqQ1Gn5hIsxw=;
 b=nnfQAqnzZG+b9yW2/3WJEujGDOOZoOaOXTga4R73cm1GjGpIK5mgYMsf07hiu9pUdR3jYVsmwK9cdtbHMTxU6wF0xfJh1CO7jtCefkW1aatlTmdHZuXdBZdBj9aKWitLJxslXM8l/EwKGwvx82DN8uOE3PK/kQ/RReRGd6MytJw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 20:14:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 20:14:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Homura Akemi <a1134123566@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Thread-Topic: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Thread-Index: AQHbS2QFjUURmKlzgkWNYg6lxVUSiLLvJyWAgAB5nQA=
Date: Fri, 20 Dec 2024 20:14:44 +0000
Message-ID: <20241220201428.id3mocw5erctxkto@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
 <CAC7i41Mqhfc7JOcF2SH4Mb2xm-Y1sD3c9Osty0SGxv7buYQYjQ@mail.gmail.com>
In-Reply-To:
 <CAC7i41Mqhfc7JOcF2SH4Mb2xm-Y1sD3c9Osty0SGxv7buYQYjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB5716:EE_
x-ms-office365-filtering-correlation-id: 8635e158-d97c-44ac-535a-08dd2132f1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjQ5UzgwMWpJK3lJald4ekdVOTc5bytvdHZUekNPNDU1U2cxMGY1VzB3T09X?=
 =?utf-8?B?R25GZnk3NHRNZXdJYm5RbFJpc0lpa0hGd2dTSG5NWXJsZEZqMW5FbElMcktK?=
 =?utf-8?B?QlNXNkJ5V1JGQzd0S29DemtBVCs4b1JlQndLOEhyMkJzMm0zb096TnlUZStS?=
 =?utf-8?B?WkVJS2k0VjhoUlVWR3d0QTlUSmpQekthNThud2xJZzh6MjlUV2xJWTBDczRq?=
 =?utf-8?B?TndFS0luVWR3R2x0UmZncWk0dWdWcWVPZ3FMN1ovQ3l4eVp2OGxURkxqdFNG?=
 =?utf-8?B?Sno0TlhyanFOZDBXWktmTDVGU0Q1SkhmdTkxTTcrR3FpYitnU25LeDloSTlo?=
 =?utf-8?B?THJPcFZEeFdPNXdjelZ0c3lnS2orMmZ1bFllRUJsUFNVN1ZlSDJEcnBuN2dW?=
 =?utf-8?B?djBWdFBMR3hYa2pwMll3YXhlMVVJVU4xcFNYK3VhbU10TWdsaVViT3BsVisy?=
 =?utf-8?B?bW56YndBdWFtb1R2N2Qvd0VpSDh6RWhhNWs5RW11ZTFaanFRM2JGQVNGdFNw?=
 =?utf-8?B?dDE1ZHhQdmZTbGt1QldRTDRpcUI2L0ZYNEhxTncrUGJpNlcxMjcrbmh6YlJE?=
 =?utf-8?B?Sm9zOW53dXpLN3luL01mbDg1R0RrVzBFdmRBTWpaVmc0STlreXhianhkU2RS?=
 =?utf-8?B?VXFla0ppUTdlUzlZY2FJWXBKRkZ3Q202eE1HNHFBY2FiazRKQkFxNkR4T0lo?=
 =?utf-8?B?aUJHNzROM1ErOHRVcXN4Vmlzcmt0eml6NCtUa1RTR2doNzNFYXVBaWtXRFhO?=
 =?utf-8?B?L0ZHMURHbXFQZkVEVFllVzduakNQb1lPajZJbDcyT082UWdKck5VMjNEWm5q?=
 =?utf-8?B?Q0FaNmZwc1R5dFZVTmp3djlWNEJIaEdwS2c4cDZleHdOUUFJTDdoT0hNZm5B?=
 =?utf-8?B?djNuVXZ4TGRYY1ZYM2lSbFhqdjFxeXJYVU5hMEZ2aG5rR2F2WlI2RlJadG1U?=
 =?utf-8?B?MTkwSTcvamdLZ0dHbVJzcWRrczZzc3BWZC8vZGFZcHlsd2cxbXo5TUU1cDdm?=
 =?utf-8?B?N0Y0eXRsSFMzdEh6bU4xUldrZUhZZ2ZKVVd0QkdveUQ5Vk9YM2NHRFNNTUZF?=
 =?utf-8?B?WlpQNE9DaGVKQ0dDWUUrV1JQeEREaUo2SlBGLzhkRUxVOFpicmRBaDVobG80?=
 =?utf-8?B?UUF2NXlrT1JVTGdWQk4ybDVWYmpJaERmQXN5V1AwRFdVTGg2VG54TXY1Y2pV?=
 =?utf-8?B?eDNyRk9jczJtQUhqMnVONjBDRjh5SE84M0R6Vnc1Y0lMRURSL0NRbGdZWGtV?=
 =?utf-8?B?RG5NMUNjRStmKzk2d2NFSWdlNjhibERVWlYxT014VFdLdE5zcStyS1F4N0Rz?=
 =?utf-8?B?bXQ5SWtQM3Z6azBCbFprOVJxREhJNUNBa1JxYUxmVTVkY2pBVlFIdVZtdjJp?=
 =?utf-8?B?UkRMYWFNU3BQWXAyejA1SFViWmVxMC9GWUtFc3hFMkZQNkxVRGtTYmY5OWth?=
 =?utf-8?B?M01NSjZEWEtTcmhSakJLSUt1SHFEVmJmUXdOOWFUcUhRU1VpaFlBWFRtbnNr?=
 =?utf-8?B?N2NzZGZQa1pXYnMzV0E4MWFucG5CMFZ5VEdQRmRjZWRpZVFEcWQwQ252RUkw?=
 =?utf-8?B?ZjBLWFdtQU85UG5KSGRha0tDRWhVYXNiZVNlU1QrTHR1bHJMNERrZGtUcm44?=
 =?utf-8?B?dllZcWwxcVIwWGhqUDdDOERZMXJpOVg2akVGakViNTBtL1RxQVk0YVZTOEpG?=
 =?utf-8?B?SjNublJDSm1ETStTWitRLzdaMERWQnhOVElyUHQxTnZKSytlT3hTOTdVd2NM?=
 =?utf-8?B?QXgrSmNENEpqQ2NDSy9PazkvSG1xa1lNbm5BWVFQSWtOVDNQcm5SS2xPSzJT?=
 =?utf-8?B?bWJQRDZWTm4zQTl2UUdsaUN1SFlCKzdIUUxvT0YxdHVDdDNGZkZ6L0lxR3ZK?=
 =?utf-8?B?dmYvL25yMThUbE9lL0haK2tyWG1oM29POXhnQnAyVGFtc1RXMkJyUU1Za05D?=
 =?utf-8?Q?eOQnVKFf7Fa2IMPuVEEZCxq88oSQTidz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnJZaGtzTmxsRWJMeFhscHczNDhlUXJFK09ERHV1MVlxMkFYQUNDMXgxUXlL?=
 =?utf-8?B?eVF5TzhqeWNYYkNvM0FaT2o5b3hqZzVLWEFzdE0xMVFzWVdzRGJGZk1vUkZt?=
 =?utf-8?B?aFVpbFM3YTcyblVlVVpvdEhLK2ZtZk5FVnRaaDBVMlhJSEUxWTF6VTArQjlr?=
 =?utf-8?B?ZVlUY3hZSXd3TXI4dWF0bW9hMW4rUjk0Rk5yeEpVSDljN01KWkxDbk5BNjVG?=
 =?utf-8?B?V1hUSGJqZmtnZEhuQ2J1RDcvbDlkM3lQdFdxMXB3NytjVzY0RkRjbWVmMjR1?=
 =?utf-8?B?MVJPZmpLNkJOZVpQbVNmclBwakUxb2RqL1owNUp0d1BadEp0elZnKzJZV3FF?=
 =?utf-8?B?UFN4V29WSFRxdlZqbTFjSkVabE8zdTM1THR0em5KdU8rdWNPK0c4UnpEWlAz?=
 =?utf-8?B?L3dGZXhMcmMxWi9iSTdUUlRUcjRyanhvWVdpSS9JVWovOEp0U3M3RHNJbVpJ?=
 =?utf-8?B?MEg1eEJ0V0prZVEySkpMMkdpclhNdFlOZm9WWEZsaTAxUE8ya0lyODBwbHdX?=
 =?utf-8?B?Q0RVOHVCeU9CS2NkUFVBMGpIN3doRFl4MmNZOEhjTk1WaytJWmEzejFZa3pz?=
 =?utf-8?B?MDZxYUlJQjBhbXEwS1pUVlZ6QU9oRFQwd2pwRmtWSEtFZ3VibkFPclc1R1Ex?=
 =?utf-8?B?V2RwZFR6VUdQRnlqOS92dFkxYmZRMVZVWGV5S2tkTjE2L1VJWDNweTZLczd6?=
 =?utf-8?B?Y25POGx1UjJyQkFENUZmejVDa3FUR2tPZ3ZuU09veUhLK1VZTDdYODhmN05N?=
 =?utf-8?B?WFVubk8rbDRSTVRkU1NJZ3psRDlOenVmbGgvUDBsZTRhajh6TkJiR0NvTy9k?=
 =?utf-8?B?UmYwZVBiZ0ZNOXBUNU1PL3ZVVjVUWUJudG5vOHFNNTdXTVNESnRUeTNoNFds?=
 =?utf-8?B?bkJsWTRDMDZ0Tm0yNUxVSjRJWEJrbmprL2RISkxaUUhCR0FzQVM1WExuMk1F?=
 =?utf-8?B?Y2l5QUVDV3UvenY0czYvWnhwZG83ZGRMRGU3cHpsV3FrMUE4K1U3VjNxV3lH?=
 =?utf-8?B?a3M2QzBRSjZKU2JKdi9JVThTSXBBemM1cnV4TG82RWgwZEx6bHBjazZJYWpN?=
 =?utf-8?B?dFJBeUF3bStXWU1sMUtCNXd0NHR3TU14cUR4aGtQSWlUUGlWN2MvUjNUMDZn?=
 =?utf-8?B?ZHZhalF6MTVFNGh3cFpyVTBjMjBMZmk3SzZxSndVME4zankyMVFxa24xREh3?=
 =?utf-8?B?NGxrLy91RzBKUHVCK1R6d09uSFNubXFONDVUaytvcEJYWmdSVHN1UG1vYUhz?=
 =?utf-8?B?c253N0p4Sm5iaTVXbEZpTm9oM3pzajZKbExMNEdHQ0pSeS9SS244bkdHYnd1?=
 =?utf-8?B?TkRDcFdlVk5uNnBkeU94T3pKdTB3YnZkVUFrYTM4dVNXY3lFeklVVVlxTTZn?=
 =?utf-8?B?ZEEvb0FuSEJ6T2VsL1M3cUQwaEVSWUNtL2NNTTgzNFkyRTJKUUR5ZGpEcWZh?=
 =?utf-8?B?MUsvQVJwQWVZUTByMVJsN2dhY0g2V1dpczFJS3ZiWFp3QjNGYTVvSDJ3ZkhI?=
 =?utf-8?B?YU9GSTgzcktVZ3J4NjJ2T2M5YVh4bjBOV2tIeU1wem90NDZpL3ZkM3BWejhz?=
 =?utf-8?B?bUl4MDFGT1RicFBkM0djSHA2ZGlDcjlOYzQzdEwrUXVNYy9VSDh2NTMzRmZz?=
 =?utf-8?B?MkhQZktKWHhFRTNtQVE2dDNHNVhTVld0ZFBPSXRlcitaQU9CSmZadHZNQm5P?=
 =?utf-8?B?dE9URk9OT3BLZkJUbHZ6VWlVWkdyb3pQSEFNaExkUW1pMUhndDlVaklQTk9z?=
 =?utf-8?B?RVlVeXVpM3NNV0E1VzJaejZCME5IOGFKN0Y4S0tubUt3Tk9RYk9YbGVWZHBa?=
 =?utf-8?B?dmJCejdCMmtIT3lZaVkwd2IrM3RYT2tYZ0ZNK2ROZ1FQMlRjbXRIekowTkkr?=
 =?utf-8?B?RWNHVzlRNGpieU4waFpQSkFyUHkwREpEMWdoZDRrZlR4MGR1eTBXTVhpTHBv?=
 =?utf-8?B?N3RrdkphV3VhalFRRC93S25tVmpsVS9CalVqY1JUekdtY0JkMlhFMlJLRHRK?=
 =?utf-8?B?cXhweGJSbUpNT1BMcStqcFkrcUoxbGRSdWE2d2hUcWxPRWNiNHlIQktDWjFF?=
 =?utf-8?B?Y3VmNDlJOTV3UmVjK3g1MXVRdTUrTWR3YkNwN1VidEFQclI2TDZFcXI4UFRR?=
 =?utf-8?Q?mZWAYkXWCFPr9qVTFYcnSWcls?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96C2BBD4BA7DE0499F1BD561D5D1AF80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qxWT4bynksDBeOCB09QmtRP0SHPQM+B5WV0fjYm16xqFXYqqnC24dCNqColXmQuXvUnYu3F5oEJbZ224CmYBArZIAmAO7ihDuWOzyX4b9oSpBVeoJW0jRd5DP8lsEbWZIoinyqfhSce7FIJvkW4QWvI+u8BTduGAq5Gz0DMnpqsEaftWaHf0kL9LUWEhneWfRNfnlF6yp6xr6zDgewVE3kInZDSuhtGgJC6qnxDXDsaQ4FJ6Ix3JQ1NSjafUPWEYTnnZoXPYU29BVHg8xTE92zhDFgtc/2ZzL+9rlXbR8UNM+uC+BDY9Y+B6RbC22ZaHM+pRi7d61ldvZh5177W29X992oYUO2I5tuaa6i0a2LoOE37+FkuWzLqPt6iFLCxfioNT7trPXVfstDwXz+EQSDy/g+XGKji04i5JtUYmM1VjbPtQAHRS0EzxR9bUFFP5YPePLDKyodwKRG+38NGSUSx3OeRePH3n0HJJjIByKQlQ88oVAHswzb5zeIg+fK2VIqj0Zy4MVpquCSRXuvRF4QV7DE1EDHilOQmULAoVT3ZS2jyTfLuIeiKefRYhwtvK9t5TeI7BJVzvAxAXjJKG3WL+rlfS+3g5qZP8BGfMFz+zPPmdUanLEwHhQodNbbJdIhYk7oy6kNnI6DcVn8kHhg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8635e158-d97c-44ac-535a-08dd2132f1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 20:14:44.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5+VwWSpjnVkOJCi6dhGEb2NTVnLX9ZEsgYggbStYRHL41jNsArKUDmj+1ENhdhTdakMOlBD7NVLBZyO55FcAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
X-Proofpoint-GUID: 6S1xoMqi1bt8HZZ5qnSvdr8UfQTI4KTW
X-Proofpoint-ORIG-GUID: 6S1xoMqi1bt8HZZ5qnSvdr8UfQTI4KTW
X-Authority-Analysis: v=2.4 cv=RrY/LDmK c=1 sm=1 tr=0 ts=6765d03c cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=8mPku44RdSMednfh7iQA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=651 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412200163

KFJlbW92ZWQgQ2MgaW52YWxpZCBlbWFpbHMgdG8gTmljaG9sYXMgYW5kIEFuZHJ6ZWopDQoNCkhp
LA0KDQpPbiBGcmksIERlYyAyMCwgMjAyNCwgSG9tdXJhIEFrZW1pIHdyb3RlOg0KPiBIaSBUaGlu
aCwNCj4gDQo+IE9uIDIwMjQtMTItMTEgMDozMSBVVEMsIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gMSkgRml4IERhdGEgQ29ycnVwdGlvbg0KPiA+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPg0KPiA+IFByb3Blcmx5IGluY3JlbWVudCB0aGUg
ImxlbiIgYmFzZSBvbiB0aGUgY29tbWFuZCByZXF1ZXN0ZWQgbGVuZ3RoIGluc3RlYWQgb2YNCj4g
PiB0aGUgU0cgZW50cnkgbGVuZ3RoLg0KPiA+DQo+ID4gSWYgeW91J3JlIHVzaW5nIEZpbGUgYmFj
a2VuZCwgdGhlbiB5b3UgbmVlZCB0byBmaXggdGFyZ2V0X2NvcmVfZmlsZS4gSWYgeW91J3JlDQo+
ID4gdXNpbmcgb3RoZXIgYmFja2VuZCBzdWNoIGFzIFJhbWRpc2ssIHRoZW4geW91IG5lZWQgYSBz
aW1pbGFyIGZpeCB0aGVyZS4NCj4gDQo+IEkgYW0gdHJ5aW5nIHRvIGRvIHNvbWUgYmFzaWMgcncg
YWdpbmcgdGVzdCB3aXRoIHRoaXMgc2VyaWUgb24gbXkgZ2FkZ2V0IGJvYXJkLg0KPiBXaGVuIGl0
IGNvbWVzIHRvIHRhcmdldF9jb3JlX2libG9jaywgdGhlIHJ3IGNvZGUgaXMgbGVzcyBzaW1pbGFy
IHRvIHRoZSBvbmUgaW4NCj4gdGFyZ2V0X2NvcmVfZmlsZSBvciByYW1kaXNrLg0KPiBDb3VsZCB5
b3UganVzdCBzcGVuZCBzb21lIGV4dHJhIHRpbWUgZXhwbGFpbmluZyB3aGF0IGNhdXNlIHRoZSBE
YXRhDQo+IENvcnJ1cHRpb24gaXNzdWUgYW5kIGhvdyBjYW4gdGhpcyBmaXggaXQgPyBTbyB0aGF0
IEkgY291bGQgcGVyZm9ybQ0KPiBzaW1pbGFyIGZpeCBpbg0KPiB0YXJnZXRfY29yZV9pYmxvY2sg
b24gbXkgb3duLCBzbyBhIGZ1bGwgdGVzdCBjb3VsZCBzdGFydCBzb29ubmVyLg0KPiANCg0KV2hl
biB3ZSBwcmVwYXJlIGEgbmV3IGdlbmVyaWMgY29tbWFuZCBmb3IgcmVhZC93cml0ZSwgd2UgY2Fs
bCB0bw0KdGFyZ2V0X2FsbG9jX3NnbCgpLiBUaGlzIHdpbGwgYWxsb2NhdGUgUEFHRV9TSVpFIFNH
IGVudHJpZXMgZW5vdWdoIHRvDQpoYW5kbGUgdGhlIHNlX2NtZCByZWFkL3dyaXRlIGJhc2Ugb24g
aXRzIGxlbmd0aC4gVGhlIHRvdGFsIGxlbmd0aCBvZiBhbGwNCnRoZSBTRyBlbnRyaWVzIGNvbWJp
bmUgd2lsbCBiZSBhdCBsZWFzdCBzZV9jbWQtPmRhdGFfbGVuZ3RoLg0KDQpUaGUgdHlwaWNhbCBi
bG9jayBzaXplIGlzIDUxMiBieXRlLiBBIHBhZ2Ugc2l6ZSBpcyB0eXBpY2FsbHkgNEtCLiBTbywN
CnRoZSBzZV9jbWQtPmRhdGFfbGVuZ3RoIG1heSBub3QgYmUgYSBtdWx0aXBsZSBvZiBQQUdFX1Np
WkUuIEluDQp0YXJnZXRfY29yZV9maWxlLCBpdCBleGVjdXRlX3J3KCkgd2l0aCB0aGlzIGxvZ2lj
Og0KDQoJZm9yX2VhY2hfc2coc2dsLCBzZywgc2dsX25lbnRzLCBpKSB7DQoJCWJ2ZWNfc2V0X3Bh
Z2UoJmFpb19jbWQtPmJ2ZWNzW2ldLCBzZ19wYWdlKHNnKSwgc2ctPmxlbmd0aCwNCgkJCSAgICAg
IHNnLT5vZmZzZXQpOw0KCQlsZW4gKz0gc2ctPmxlbmd0aDsNCgl9DQoNCi8vIEl0IHNldHMgdGhl
IGxlbmd0aCB0byBiZSB0aGUgaXRlciB0byBiZSB0b3RhbCBsZW5ndGggb2YgdGhlDQovLyBhbGxv
Y2F0ZWQgU0cgZW50cmllcyBhbmQgbm90IHRoZSByZXF1ZXN0ZWQgY29tbWFuZCBsZW5ndGg6DQoN
Cglpb3ZfaXRlcl9idmVjKCZpdGVyLCBpc193cml0ZSwgYWlvX2NtZC0+YnZlY3MsIHNnbF9uZW50
cywgbGVuKTsNCg0KCWFpb19jbWQtPmNtZCA9IGNtZDsNCglhaW9fY21kLT5sZW4gPSBsZW47DQoJ
YWlvX2NtZC0+aW9jYi5raV9wb3MgPSBjbWQtPnRfdGFza19sYmEgKiBkZXYtPmRldl9hdHRyaWIu
YmxvY2tfc2l6ZTsNCglhaW9fY21kLT5pb2NiLmtpX2ZpbHAgPSBmaWxlOw0KCWFpb19jbWQtPmlv
Y2Iua2lfY29tcGxldGUgPSBjbWRfcndfYWlvX2NvbXBsZXRlOw0KCWFpb19jbWQtPmlvY2Iua2lf
ZmxhZ3MgPSBJT0NCX0RJUkVDVDsNCg0KCWlmIChpc193cml0ZSAmJiAoY21kLT5zZV9jbWRfZmxh
Z3MgJiBTQ0ZfRlVBKSkNCgkJYWlvX2NtZC0+aW9jYi5raV9mbGFncyB8PSBJT0NCX0RTWU5DOw0K
DQovLyBTbyB3aGVuIHdlIGRvIGZfb3AgcmVhZC93cml0ZSwgd2UgbWF5IGRvIG1vcmUgdGhhbiBu
ZWVkZWQgYW5kIG1heQ0KLy8gd3JpdGUgYm9ndXMgZGF0YSBmcm9tIHRoZSBleHRyYSBTRyBlbnRy
eSBsZW5ndGguDQoNCglpZiAoaXNfd3JpdGUpDQoJCXJldCA9IGZpbGUtPmZfb3AtPndyaXRlX2l0
ZXIoJmFpb19jbWQtPmlvY2IsICZpdGVyKTsNCgllbHNlDQoJCXJldCA9IGZpbGUtPmZfb3AtPnJl
YWRfaXRlcigmYWlvX2NtZC0+aW9jYiwgJml0ZXIpOw0KDQoNCkkgZGlkIG5vdCByZXZpZXcgdGFy
Z2V0X2NvcmVfaWJsb2NrLiBJdCBtYXkgb3IgbWF5IG5vdCBkbyB0aGluZ3MNCnByb3Blcmx5Lg0K
DQpCUiwNClRoaW5o

