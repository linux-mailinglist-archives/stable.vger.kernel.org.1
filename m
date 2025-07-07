Return-Path: <stable+bounces-160355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D19AFB069
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B171AA156F
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7D2746C;
	Mon,  7 Jul 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QhQjvPsw";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XwzqSV9w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nBuLBQJx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1D288C35
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882083; cv=fail; b=JBXnDSHKwBWHhdePfeg9SJg1n5w0EFB67Pt4SBrCFJZbyIPqH+TTGZYhTjWFWJdyZHmqnuKDd7NbPR45eaOv2t7EXLP+DAf5hhho15UHGfI1LYmf0wR0P84GZlpWbq2xZa3c72zquRQyyBxW9MI5HVFdu+KGXE5AySZEdjHVL50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882083; c=relaxed/simple;
	bh=kHksF5yc8yzJF1aSrBw8nW7XoVkcJROTEpg0yiEtzeY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QgPt6YP4pEWOZ0uxaTGXz9Rb1IRCH51srT/ZFkF34hnAu+QihP2g1aJW0jm3f069WFQcgMrbibmuHYVGZXy7FGACwlFVehfNnvE/I/qEOQHdQHyXNs2OL99a5juaO1oiGeu1rNu8j2ueJBm6buD0q33n1ctoatPZOpdbZyLW6Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QhQjvPsw; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XwzqSV9w; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nBuLBQJx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56779NEg000660;
	Mon, 7 Jul 2025 02:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=B4OvyR10xr7q+wmW8//
	5dE/zTWg2juVPFeW2vGSRsxU=; b=QhQjvPswgId6wW2bOJykkAhmjWgWPw9S0nc
	krCGirifNjYr+o/q5k0JJ5LNZj+qTg6KS2DhabBZGozwb9YnMvqqbdS9CBEY6RvR
	rD6IrOg0S3Jw+dBLfkPPsu7lrX2n3Ki4yZXzle8UeNi7ZU7bkcRVOJfJnxUS2yv5
	UaK3xFAPEp8c/ATWOoFZLP9GFIPr2JqlFihZfctI9ou4aJzCGfIaAqZ5VP04Uzv/
	pReMbDb8Ed8nNoXqx8AuGABf9PahbS8gq0xXH0VYy9qzf1Sqwm+VfptYb9ECJ4KI
	YhELPrg2O1OghVP8o2YJvwHjnRzDw7ElN/dx0nKbrtNplBc2wDg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 47q2ph52bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1751882067; bh=kHksF5yc8yzJF1aSrBw8nW7XoVkcJROTEpg0yiEtzeY=;
	h=From:To:CC:Subject:Date:From;
	b=XwzqSV9w2Zv50UJIugLnGjXVovsRfCP08K9tUEHTO0jScLfGsqquZ/DxNQ7NFvYMl
	 WJc3DexfqdTJLHg+Y9YUUFp0a0zfvgZvyyMA8MFAwpm3O8JVqHHxbi7jHawUc2Rkcc
	 wxpgXcG2xSL9C3xD1XWDyvPD715lCzDe213hBVBDroABdh3TbmoAvyXQgD2Cv3VH62
	 1QeMwJVmAkAv3LK2KGliXmCIPZbt4ryJ2yBv8K1bICpLRnaYRhbF/WCDO7vflYr7Yj
	 zr5ZyjsohzS9iezg4ZzzyivMbdTOGNsYWtNQv/HQ6iqQCcFfF4SUwBuKYcBsBB53Vz
	 2zxJCAYCUn78w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3117240343;
	Mon,  7 Jul 2025 09:54:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 46290A006E;
	Mon,  7 Jul 2025 09:54:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nBuLBQJx;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B5D48401E2;
	Mon,  7 Jul 2025 09:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzME/K4TQMekMtE0PWaUIZ8U/a87inLYfk2Um8Za2dwu8zrqDHij0NCm/E0OlDJ7ioHxCZVcaqnQBY3YGNzB7WZwbpi0Ouv0dN1+IxHL/xfRSUF5hUY1lWBtbdpDay7Fj4AsopvjUZTqSupWM6tc+RFi32xpFhIfv3KEa/HEueRwO4ZBcge5VSuKTnZ1DRglmgqOTU48/J+gUN9zcP5USCFaaZCWSL8T6a3wqJiLIp3qgaog+AF75yT+pa+AggqZXqGM6z5N1vb0bHR1m9v0/Icux8qpe9NO60WHWz7UHvvY7zGyyB0jWasuTGA48urLTjimHQF1S7ODqndr7EWlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4OvyR10xr7q+wmW8//5dE/zTWg2juVPFeW2vGSRsxU=;
 b=wDBkLf+y6d1kIuZ8ET9vXd2SZWeRQxCnSzj7AG2PrrO0fc2zq/oOmTH2lmsJZpzjZcmNdZIDpNz2hBkzqmSKheZ1OcO0TldKBhtCjVRrvmiLR4T0p7rNGHCps7siKcoNGtwF0qN4ZpgJEVW8JYxKp21jALd+9qImsig9lMXyLGJUd7uEPMdW8eot8vVGwW+AquO2LS0bz3n27N30ba5EYpHktcW5nsKU0oYWS+vXrObglF2oQBxJP+tnllTKhb3cLcR6wIJEAWJQNeXs9NKfKTgzr+YYefjSoHM5m9ApvVzSiSuvAco+p6U54QfFSTEQBhcn1tCWkhqu6EDnspyRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4OvyR10xr7q+wmW8//5dE/zTWg2juVPFeW2vGSRsxU=;
 b=nBuLBQJxP0zQUp6KbTa65Bs7DDPCFeW0SDHlgQZi0eATj+qTt4Y/vFVa8PAjasp2R1YPBYSFbq1JK90j/vlA/dtE+vj99L2mA2nG/EkKWhd0jugBQ5uJ56Ae7Jj7tpO/oo/N792STH9BUVN2UH0xy5Faid1fkBAKPQDiO/e1yHs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 09:54:19 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 09:54:19 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v 7] usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY
Thread-Topic: [PATCH v 7] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Thread-Index: AQHb7yUb87HtgUb9Xk+c2tdGhmsc+w==
Date: Mon, 7 Jul 2025 09:54:19 +0000
Message-ID:
 <692110d3c3d9bb2a91cedf24528a7710adc55452.1751881374.git.Minas.Harutyunyan@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB7439:EE_
x-ms-office365-filtering-correlation-id: 70d45c5d-9421-436c-53a8-08ddbd3c3e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vkN7akaN7s512HELJ2tHYCKKxKHeO3/M/DxnE/HxUfYoCg+lUJ6pamIbCG?=
 =?iso-8859-1?Q?3mUZmpE5LYz5s3KED5AqzxtbqBJnkgtwKcDDjJlN/nnNytbHnINA9ct3NQ?=
 =?iso-8859-1?Q?Ds4+tJYFTxz86lAVgJPq15Vei8BNwohWv+7Kh1WsdUyNuaOSqQYJ3JyrxN?=
 =?iso-8859-1?Q?uL3PlU/MMQVBxZYKrljtICnXUcJ3u9U+u8gP14HYzHtJ1Ayfk1IDxbLo6V?=
 =?iso-8859-1?Q?Heth5LoccurrSdWwPz8mVQ53U21PxXANODYuDwOS0HNuBMaixIWP1jwL/T?=
 =?iso-8859-1?Q?i9tyFOSoyM4j+SX4Sf83j92T1MFrZLVtsdp4vTv52/HGfwJTjcAMG3B5QS?=
 =?iso-8859-1?Q?TNAjIM4q5zldbjdiodKPa7bjbhi1rVOpYdIjJyuVAraeYJVhs2Ar7CXU7h?=
 =?iso-8859-1?Q?xJIGqGlCngzx9KaqRBUz/Zp/VxesWvACyV3d/PLWo2ijWAu6ORiZXKe64D?=
 =?iso-8859-1?Q?YIDRf7ESAJ0Q4CY4nlswFD5BHNPk2dj3BBQJJ672dm5nqpmwvL+D0eBrEz?=
 =?iso-8859-1?Q?XnRXy3aa0u0URpM2AuL+dO+fwtVwtx7onbQWZZUM0VJg57xRBwn5PmEZ7E?=
 =?iso-8859-1?Q?8VhPid3nWqnbL1YPXzWvCDEtJBraNR0woUWmcVUyFU+uTrxoglFjgZcPxW?=
 =?iso-8859-1?Q?1N48hGuMMo/A1HRcLYG0FEYpjhds70Byvob5OxwuWKwgo6OAWZwbRXvTXg?=
 =?iso-8859-1?Q?KSAftXwCYerCXGljgXvI7KVv2z+/JZFRPw/RJ0PQTANNTAKXz4UqMCAF81?=
 =?iso-8859-1?Q?ErrYXrNhhEkwv0SIQB6sGsczlI1FW8geG4fgKxRB46wXWg7m2bq8qyI5X+?=
 =?iso-8859-1?Q?MuvO+HjsjLP87MAJhYNFkp/Qvn3CbbRHt6s9IzOjG/pILiTdLCdP/j7CWE?=
 =?iso-8859-1?Q?aeuDpMbOGTtCiRuSn/kI+OP+tUrYW9uoalqI2lpA5fGB6fmaFZXm2YXEJu?=
 =?iso-8859-1?Q?TCiXOCBSoz6FfEDzZ9ICysrqCpEPSHbGJihctFRVWURi/IvAWRD5tkh1rO?=
 =?iso-8859-1?Q?BYyPRoNahxwVTvV+VtQA+a4lz3fkssA9KiZ97rXdDs0zhRM2f/16nNpPr3?=
 =?iso-8859-1?Q?A/TL1EeMAMZtyzbj6xX+xaiEpWabdIB52jn2MEpffsmvB9pb58rrSj70mq?=
 =?iso-8859-1?Q?EyQAXJY2ULay12x6wRmlA13zQGb0fvxEXuG9yiS9K095niy3zuBYN8kqBg?=
 =?iso-8859-1?Q?pylquMvUzkNqmG7Jb4ZcuQSsJGWfwZ+sNEI1wJvBwiGomOWxMNmbcZJXjN?=
 =?iso-8859-1?Q?Y64lbjRAe8tgKFcdPEsxk/YYGqnLRuJm6DSgpr2Z2HbuxHRDSy5CMZiCAb?=
 =?iso-8859-1?Q?p9AHXF2R8x7ylpRr8ZQpKldce8NaG+hChNnUOTpoaivm3e32ffbop/Ego3?=
 =?iso-8859-1?Q?twEwfhibppB55T44gQPy/GsOazU8Hl2QGW2v1BNunnywm+RGN8Kn7m7jVR?=
 =?iso-8859-1?Q?A+OKqmKDH3GmwCaSs/VeQ+P/0WrERfmLnU3XyjWzf0R/wh7vvhdNvAbD4X?=
 =?iso-8859-1?Q?LblgcSrkaugHLTjxnj2aTjGCnLaRI665dnk6jH4NTj0w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TsJ7Qd5PY90bOxqKIsGVmIC1auf2dageSXRdm3k6ZGKpQcf0lnojZ7GxLD?=
 =?iso-8859-1?Q?bG5O8uGqpplfvXG205DUtISNArDjQ6VDV7DDOk/4oWXANFkTB5aXvuj+17?=
 =?iso-8859-1?Q?bWkzv0/eLDssCYZThORxt7tEo9FpPpITKDoXSFeGPMTOR8/y6e9/HkWnGn?=
 =?iso-8859-1?Q?Ha45Y+D7bkfIu3o7aW25u8Y3orvsPUy4OC1HjENQXaLNlxRAfpJkCdlqio?=
 =?iso-8859-1?Q?L4HY0zLKfPUX1YQVzoy5OFMAIEWjIpXsQvjq4zMQ3UDBLoUDysrp6U8g8t?=
 =?iso-8859-1?Q?DWDyf+RCmHUe89BmyA4JAuRChmBQKPe7G5QxyELJftum5VuBgow5HOQ/nn?=
 =?iso-8859-1?Q?/1WkDowoVF2uWqIWhuip/qdJM6PYfi09DsMI7tobqGorUoKgpR6I83jY/F?=
 =?iso-8859-1?Q?Y1ahOiczM5I58K3aPzSUkubFCBmh5SdxsxjVyGee406J9khhnt9xVLrQ59?=
 =?iso-8859-1?Q?TradpUVXBKWYgq6FT+Lyim7ukMQuGZunp/FxcJWK+9CRcgwZ8a1nBV7TNH?=
 =?iso-8859-1?Q?NyfDI+o4e0T9LaamchuvFUFdF8WT38Pxj2ua/uNCy7BnO6MIeKnGg9XjAq?=
 =?iso-8859-1?Q?XNzyRp6hMFph1lA5P7pKlHQ3dQ0+S2Gdhqbpikwt/K4Zl6aEmg6bRDxKJf?=
 =?iso-8859-1?Q?zdlyheU7OaHwswWamyXGWxzwmwafMyxsH/NyWGnRIZioadBlQBKTD6soP7?=
 =?iso-8859-1?Q?SP2fJ2nboY6jBUByFwngpYw9QKzXuyKgKJiGVjHn8YJRC4jgj2uCraVfi5?=
 =?iso-8859-1?Q?GuFFIEWGhYt8mTW151e89jCnSR6fARbkXmxZX5CovNdDt8Cm60JHkwCQfx?=
 =?iso-8859-1?Q?wl7k8DdnDOv8yILgAKHht913JSm5GHhx/Ft/NR57Xc3OmVASGAJvmx+pr/?=
 =?iso-8859-1?Q?E0FTwB+vZSgwWpCjGTi+vFgoA58KkYeGRUNtmLxY1+5seEO1mZeb+taBpb?=
 =?iso-8859-1?Q?4NAK27vUYrT6sraIUAFzL+k64lmysfdXoKfwsqutlIOJ6OJTFmcQguS1XL?=
 =?iso-8859-1?Q?VknDjQ64YWuQfp1ufPqNpvgxzUXbsu1Pr+6vZ3dyJM8zkezY21TgTO8g/g?=
 =?iso-8859-1?Q?BdDrBxUoEsrteTg6o8A/WHmLmqZzJyNRkk16A5XdPAKOBmHPiTuzTH9aUM?=
 =?iso-8859-1?Q?+qDvpzKvMpkufnFu5fv2zxOPtl2EgJlQCTK3WUVhalj8+A6FBUgbgFOrwF?=
 =?iso-8859-1?Q?khsYChR5VwrQMZ+0HsDb/j2x4XPVWibxNbXxb/DnAgUdVUm77+SeOqknn/?=
 =?iso-8859-1?Q?aOUMCQ6cJxq3HO+pNFkqAM2nAM9oauDU34RIhorePADc+8RixTt7J721vS?=
 =?iso-8859-1?Q?C7fG8HfVcIbdoG66AA4mydJO1EFsgV0jVZ4jqnyLZyXnJt5/kU/Kn3jXbH?=
 =?iso-8859-1?Q?spucGFbj9+ZYo0AIqaVudiR6hjae0S3xdcelXT8iGOPIT0AEomGMyhaiSG?=
 =?iso-8859-1?Q?oWGV4/DidNx1fP7gl9/gW+gINk70Un6BxBDXsUJ/57EULKBjAecKXtcSbv?=
 =?iso-8859-1?Q?W9bCjGG6ahH2U2CHlnnd8RSntrb2s5wqM9wABInRspA1vzXh4eJ5xHchos?=
 =?iso-8859-1?Q?308IgJL8veLubokZSelHA/IzhBDA6oGTDwZ81g8x/zk9bCsC9La860WoNY?=
 =?iso-8859-1?Q?rVBTMUBXTAo8gLnCifkyq2SAuSQ8jm/vM/?=
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
	GJECkpKOZWh0PfeI2WLFJIOBCMn7wDXn0AEsAywWdmUSSum9/ka8tE/ANzHcEHSLjDHPqyMSVpVXNUIJab4aettCbI43n+h7OYwDse27Bgtot9ZLgkMma2gCK6UApgb8XDCMQPTu/5Y40/623VcoGIXVYQEpDK3VaywiD5V8r3mE8xNRCfQS/gSKVa7ISbTuIAyrRDNwEnC7Mdd0Te8OHPrYqd3mml1umS6hMVmav9199046i+MLP2JYoM5sxbQUxUF8wbs1pTYS9o8GqO0kTotYk7F7/u0l5s/+ZTejQSYe0Uj/jqqgSmbYzAIArtTzdcyt0kCN6FWGfqmfo28k/Dysadr0l0MsYHHZ9iYOL6B7Wg0FlTXlG2tAlSjd3WENYm9ywMf09I0DfzsQwMycopH12KZQtUvC+MS9yrX286vrG51NHXcpQR4Muuv/BO9uwZRrl+A0KxGc7E7LAJsRLvIKJlUIDnJFQ1iKf6HtWuMFycq5CuV94o9sqPOKTcr55xus5kKRQwQ1yX5V2m9IIdth50p1OhLj71utZNTq8A67gaRgDlcilXX4coMVqMZnEB7qiPnd4X2Jip3lZQucolV5R0LL3s6VFl6NGBaHh+/1t4JGOedbdzTZGTGfixDW9+CS7eo52ga1Suj5v5CPpw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d45c5d-9421-436c-53a8-08ddbd3c3e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 09:54:19.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgbbS845dMw1jhwzdDCo/TpvygZb6oEq16brVUWrxtnt0+0i3EhNgLm+4xVF+agIMQGWlTrhGK5A70A/Z3ze1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
X-Proofpoint-ORIG-GUID: 6DpqP32Z4f_5ihpxV4AUxTj_mY_uHJlU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA1NyBTYWx0ZWRfX5zYBaR1kSIS9
 1rlI+Mj0DD+NuuutXBnnnGBjgOTsuFgR5Pg3QluCwqC6cCYDTTka3x70v500XDxaVRsWRUT1ENp
 N6qBTbo5dPyGAVxTc0TP0oLXIIw8OxoCVuAccjHcy198J1+3NvZz1EejqAr+M6F+/cnnEGOrY/Y
 jmRaEN/Jd7BYmLn4myBEAfCAWSZFctMplFmEhVXcc15Fu/Dg0W0K6cBXGhfXauzLIKdEw398zd5
 js4emTrlQT/ej+xT6+/Nn5kL9hi3n5XktphF/L4IcTnMJecFlQtVgDYPK+1mT4hSqmBOG6yP4sF
 xjvc90VAjIDTegObP0zsC6qqFU3UYr3QItGBmYGAKwtm6LRRAYB980AxCUQ2AiCeezAe3LTAJpq
 G+4iyCMSgXRlRDGr+95UqOjkC2Ygg4FapKgfB4SUet6Ju0aV6EEaJIH/1dFsObat6OZqzvdf
X-Proofpoint-GUID: 6DpqP32Z4f_5ihpxV4AUxTj_mY_uHJlU
X-Authority-Analysis: v=2.4 cv=ebg9f6EH c=1 sm=1 tr=0 ts=686b9954 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=1nkadCgX71emagpZ3AIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 mlxlogscore=757
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2507070057

For UTMI+ PHY, according to programming guide, first should be set
PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
Remote Wakeup, then host notices disconnect instead.
For ULPI PHY, above mentioned bits must be set in reversed order:
STOPPCLK then PMUACTV.

Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 Changes in v7:
 - Fixed email formating=20
 Changes in v6:
 - Rabased on usb-next branch over commit 7481a97c5f49
 Changes in v5:
 - Rebased on top of Linux 6.16-rc2
 Changes in v4:
 - Rebased on top of Linux 6.15-rc6
 Changes in v3:
 - Rebased on top of Linux 6.15-rc4
 Changes in v2:
 - Added Cc: stable@vger.kernel.org


 drivers/usb/dwc2/gadget.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d5b622f78cf3..0637bfbc054e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5389,20 +5389,34 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
 	if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
 		/* ULPI interface */
 		gpwrdn |=3D GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
-	}
-	dwc2_writel(hsotg, gpwrdn, GPWRDN);
-	udelay(10);
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
=20
-	/* Suspend the Phy Clock */
-	pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
-	pcgcctl |=3D PCGCTL_STOPPCLK;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-	udelay(10);
+		/* Suspend the Phy Clock */
+		pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+		pcgcctl |=3D PCGCTL_STOPPCLK;
+		dwc2_writel(hsotg, pcgcctl, PCGCTL);
+		udelay(10);
=20
-	gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
-	gpwrdn |=3D GPWRDN_PMUACTV;
-	dwc2_writel(hsotg, gpwrdn, GPWRDN);
-	udelay(10);
+		gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+		gpwrdn |=3D GPWRDN_PMUACTV;
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+	} else {
+		/* UTMI+ Interface */
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+
+		gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+		gpwrdn |=3D GPWRDN_PMUACTV;
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+
+		pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+		pcgcctl |=3D PCGCTL_STOPPCLK;
+		dwc2_writel(hsotg, pcgcctl, PCGCTL);
+		udelay(10);
+	}
=20
 	/* Set flag to indicate that we are in hibernation */
 	hsotg->hibernated =3D 1;

base-commit: 7481a97c5f49f10c7490bb990d0e863f23b9bb71
--=20
2.41.0

