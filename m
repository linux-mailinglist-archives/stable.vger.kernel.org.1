Return-Path: <stable+bounces-72688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FF968227
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86559B236D0
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF681865FE;
	Mon,  2 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="RxuBFnrk"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2103.outbound.protection.outlook.com [40.107.21.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A44176AC3
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266271; cv=fail; b=EJIiUYxiphR1CjVNw4Xs1gm3TJ15eRRqQOAqIDKfX3gV6iq+ZlUtrEohKERG4aBhu4RSyF5Y5JnIvNg6DmSHg/whJQniOKiOAPkt4oMvBlzNOUkcL8cWqx94+Sf4hJ/9fJu5ZKrmGKmQQkVeA1V6qdY7YMf9cXvEtE0p6NgGWis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266271; c=relaxed/simple;
	bh=AQN7ySYe4f1QA7jp7OIXYw7dZOHoQug1DZhA17GHO/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKglPnyxzbyL4EtrO5Zg/auULv7MFUUiKt+s5GNuDyZ+4jt4ZVDA9WYxZxQUX+3pyIsfgZRnfPoiVlLb3gE6wu7eAHOU6WOvYKMt5zbhDB2Tq7cQ8tJK2JrU8uux480wZQWeKhtU8+TaHYbJuBYD5nYzXDmEH90+bKTVciPR9WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=RxuBFnrk; arc=fail smtp.client-ip=40.107.21.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxzvjSH2lVVT2e6Qiqg9tnvLC8sDcXNsM/yjA23VB7Vwt7tbwR30HG9PWuwM0fTL47edw2zRZnpwwi/yewmYmMp38aMTPuLQVa0rgVC9zvbL7UEl6U9ogb7t0+OUKHV1fe3gk+BU2Wi9jy0b7YtCGoMRrbs1LpxOC127rSVxIMo62/ihqoich5pAv+fKo9GvmT5k3ywviLFMMazgP0SFJOfVLv1B+0QmtMj6mcFnNDwuSp3lsfjN91U/AO0lyKVMu3m4xRN1STVSW2NVNyAIBeB6lCy4COSGXRw8X2UyXTvzu0Q+Enq9lX2QCT9FyWauiSvFwjlnNtmBzDaUyvBkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXBK5igq2GMy5IKFaX9WUOatDLaOdmmi3M/agoAZD8o=;
 b=hoHowyt9x9LDup/uxYcNkhiq2CJdO6Va82JUb2XOzJw8spyOD0H1rgJmakftaW6W25imKPR39vndvPkDKzYZKSyx2YMb0Tn2oASg3IugcDyr2ofcDkw0H5fxbGpufatlO5wC4xeU9fl29roPI6e789YBzRBNy6AS7A0VP+72qpkBNBSCKDigz5R5ITzQ9tFYlLoTd8b/LxfNgWIdAoltMbAstdnWivPXTEMe/C96YSpaZb5+jml+49IgMN5kKt2g6mJtB1/4wqbAm0ppYoMexb2JMhnXMZ4nNvN8T8wV+zHzBKQ+IPSwJotAMBJ5HgX1ZGF54Za/BPN25014DxX6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXBK5igq2GMy5IKFaX9WUOatDLaOdmmi3M/agoAZD8o=;
 b=RxuBFnrk/50KOHFwyA8o3er6qOdknDzvjRIudrXmFYXabdkYOdrMvAfbF4e1azFzFLFzqlEIVk6OYkAdyuE7icV0uG8Oeou6mFN69fry/3AkksPceDpst/+4M5UL/uTAf3khqQsLg6nia3T3fx6aILz+hn9pErxzFanF6oip1ZSynNi5e+ihGC/3IRyi6DkFP3Qr2BBKhRiTwjbn/JOo9HrQbXSYn4IJSkH3ZV4XKmVDIHXuY4puzIF8sniQ3rVy3/K+BRx8eu7nXMEP3e5glWihfJJhGNxgyuTAIqHGrRXHNsNBtbEmHdjVO6rdi/xVwEB83g6vGG5HlReWvKXRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by VE1P192MB0607.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 08:37:44 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:37:44 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Heelgas <bhelgaas@google.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 6.1 1/1] PCI/MSI: Fix UAF in msi_capability_init
Date: Mon,  2 Sep 2024 10:36:42 +0200
Message-ID: <20240902083709.6216-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902083709.6216-1-hsimeliere.opensource@witekio.com>
References: <20240902083709.6216-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::14) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|VE1P192MB0607:EE_
X-MS-Office365-Filtering-Correlation-Id: e53ef125-608a-41ea-8516-08dccb2a8421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RIJCZhiMKHH3TFmSV0XQbHrV0+DiJWiJJEadGyKTS8F0jMplrB/YmGI4I5Gl?=
 =?us-ascii?Q?HazVSf1Hoe4MM8R0ba/6lrIzBxaRa7osA9YDwDqcDFth2j65VxSJRGip4PoE?=
 =?us-ascii?Q?aslC80QtRTs+UkFg4xtAVz0tJcPXtqNMpIn8xMBzak1Q0yXe28Gc3/AcBrf3?=
 =?us-ascii?Q?PCi4IFNwY2UEGyuiL9E5UlehIO9cpBKt6rTtqaciStaalMQXHLmu0NJ3O1Ly?=
 =?us-ascii?Q?2JK1mCmjCCOfbJ0NuTKihIAeqHZy7xo0NRFCI0gVOig+Ir94t2uEVv+NhiIN?=
 =?us-ascii?Q?GeSuFRNs/LN6ftS9m2/WVgSCRRYejsblY929bE53yPSOX44xyR59nidHbg+K?=
 =?us-ascii?Q?6dErf2QOqUFT+uLDB+VX6Pj2m3aHoSs6E5iVOIEGtEm2JD2SgzaT2QKTZpJD?=
 =?us-ascii?Q?yI5GiOvspCQR8MKL9/6fd8Lenag7uVmYKfqZi2OZ+gUcPr4e1S7/Cl+zP/42?=
 =?us-ascii?Q?js6Wf/eaQTOQQjwtRGoIne7AAJht5muqtpT+LCQWLK0w7bE6Wq/dhQhsNagW?=
 =?us-ascii?Q?b6XaiW5zH5YWxjk5ba51liYJLPZIxHPQou+PeHZ1/EWfkyDMFGO50OFpHp4S?=
 =?us-ascii?Q?oZTOK+4r/GA3eQDpePewf0SwtzGAYgOJoMTMu68JaVDWXVvEXSHrFCWbFcKE?=
 =?us-ascii?Q?pZ49LrZkmd1CBhuhTqf2U7bFgBOSS7xSEj7WoNAQeBmfCUT3eB2mzEEwO9Ry?=
 =?us-ascii?Q?s2/w65UgllE6toU6BS+wfcKkgKEWWGU5tGQzB8ZGTozsuGlan8/guMjI87/G?=
 =?us-ascii?Q?uSRMGWwHlKhqyf5CE0zAPmr+1dTptC08otPItlV/3C87NZxMDGy3LKLvVQur?=
 =?us-ascii?Q?80URI2+ekzPV8OPC9GJppP1qoM3o0c3jqKjrJUxI+ZWH+OPTwECyGaMr8tw1?=
 =?us-ascii?Q?IV+k7KLoFp8UYeBudLdLhwZZ9EdOqRB+MIIejVmUXG8yS8luPca2cSEjxnQ8?=
 =?us-ascii?Q?kxs75XSn6xAzKBld8j9nk7P8prM9svjRcYZhbE9NIJ0T7zl5ZPTOpkhRUmL+?=
 =?us-ascii?Q?3qNxZzmY7Ko6etKVT8RmPaaA0yx1/xEkKR/Pc8ugnNyHqYFH8lVwb3wCKSoN?=
 =?us-ascii?Q?O0mcyOzn7stlb7irjyns2YGh2Kjr6FpLSIJWD40tHiwSY5uYfHctS52xqi2V?=
 =?us-ascii?Q?pK1jiS6Q+gSmhwL88LOc+0hlsuWBt4IzhBF3fb3sqHo1NU9+L0/8J1byRKoa?=
 =?us-ascii?Q?CTBaWcMwV3a0a42MPu18UbhAi0DzOYmlJqxWrmio/m0Siz9VkzOGqJarbNDI?=
 =?us-ascii?Q?dbmS3II4stmXn9QW449vjFbyD8FDVBakWljKj6xoz4i5i4u66bWp5AtIA+5R?=
 =?us-ascii?Q?QCmO1JpgAEOhPs+Atr57nlJMdTjXUoeLRv9u12IljZ2tesTr9kUGqj0ERZ2K?=
 =?us-ascii?Q?48EVXp+Qhwp8VRLsnEZOwiim6FyZdCcJAHnn21d+60z7gInNTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1M9J39aOhMp5ZKFPdbi0djZF8p4ESbZ+u973Oaa0TAa5IylrW8FZ9MkVJQGT?=
 =?us-ascii?Q?aS/Zs0nrFKTETJX59Qnv625DaHS1ZeQau5oyw9lIsY+OzDe1wOdaS6pPmRud?=
 =?us-ascii?Q?6oIjdoClxkfQvx0qhGt4Kjio5Zs9g69fhJEFBUV1t9QckwjJWhqdLNLibx0k?=
 =?us-ascii?Q?+lpPCLXsr5Ua/yHnCTufWv6pfbgXw+TAax8k0HN/jO4apxMoRgdATWMJpbtL?=
 =?us-ascii?Q?o+84B/Mkv2gYAmtCLi5XtLkehNLtobTJB+ZA8/ulD2RxT7RyDA0oC9heWw24?=
 =?us-ascii?Q?U5uLniKhaLuP9FMkpndxtqEEX6qn/uDuSQ8k0MnAUj1R0Ue5cfkzzwLZT7Zw?=
 =?us-ascii?Q?xn6Bfq4/sjCoUWLa1NQDUagZBNCtRSLMQ1l6zZO71BtWEbfpKDyI2CD53SOG?=
 =?us-ascii?Q?0bx4M0nLC5xB0GcfXdr2qPHcQeYHx0zJZdQijUoNLe7LbpfDvdWSeIFi43oR?=
 =?us-ascii?Q?ZA0WCtdPo56tqdDTeCEwATt8IguaPaWhG5uKLTb0DIjXzycFG3ldxGPW9r3+?=
 =?us-ascii?Q?L0ywkqPZQR1ir3I7vqTyZs8jVJFlwaZyll2TJ4qstJ6A/InAQJWEYismlgm3?=
 =?us-ascii?Q?FFZVrxj2Fyjgy9BtcI1pgtkXIWgGqmgDS8UdECXnQR+kLaoiTtjSY3MSR0PX?=
 =?us-ascii?Q?oKDIg7d/fGaL/SL2xn4LpzZ8J/anSnSxw6H2U5S2wNr3U7GF93PSZYpvynih?=
 =?us-ascii?Q?Fi1L80hTR3qiav8G2z7eFcbxqvQDss5gG/8j8ahq3yvEnh4TwzlrJgl1MSe7?=
 =?us-ascii?Q?TALwSEQzDDma5L57zLt8XuVw3plNU5lzAAvn4SIk/TyJ6+dGV0MHb3IBHdmW?=
 =?us-ascii?Q?oaQH4kUSkqy3Rj+rvddZxY4l5l/+cUdutxaVGyYZU0Fs4LBSB8k6TAMTD3xq?=
 =?us-ascii?Q?ME0XCyZDQ2jjwn6einxTsxotQ3DKAshZCfobMKDJVk1rlVi/k5iNbVI7bEZ6?=
 =?us-ascii?Q?uCBXTPOSr6Ce2vD4CMRROXXA2bKr6YsASzMw6tClX83GnZPEqhCr/eKhoZ1T?=
 =?us-ascii?Q?XSy1OpAyTGWxq3GAqmkZiA/KKxzfFTcQh/pN6NdL4/zjDhVj6/4/cyLJlmoL?=
 =?us-ascii?Q?hnbphrmB7dqdrdYSXheshxpjs+NuwuT4uEUCIjHJKjQa6fh6Wc95v9FXhuEu?=
 =?us-ascii?Q?DheupiI2I8fqdxFYnJzScx4CU0kltNGoEVXzkwEOEKmGSFZAON92kEISXgSF?=
 =?us-ascii?Q?2+RKBkLLcJZXK/G5DTXzR/GBx2RgSn00ObmB4z/60rU9BclzA+TzFfGWdqXe?=
 =?us-ascii?Q?Wn4P1PQuCo7IQeDV5DQmG+LOqsIEuIgL56jHYhFcfFpC6g8qY6JlMGPOkjfp?=
 =?us-ascii?Q?OxiPNA5LexwtT+e0EYE0CtwypCPtjMc5IzUI0oj4kn1nJ0SfGO9VyVP0HaAd?=
 =?us-ascii?Q?NSKm3n45okPGA5XUvlCFQHV1dkOz1wV/QN/m9HiPa69/BJVrmdlidLV2abuW?=
 =?us-ascii?Q?1OwhfCiCTOzZULm/FelwDY6KyfWHWvfcna0KuKNiFm+m9wYhWciSWkx3G1Bt?=
 =?us-ascii?Q?rAQIsLqWhxuOdiBp+9O7Trqm7wzxjC0+zx+Xffiz7kllXAXNWUtOPlCnvPWi?=
 =?us-ascii?Q?QgSnVmA4Voi8K6D8oQvLc+pdN6RE4WQPj4oXzNWH6sMMQ0uAL+ccdwq9cLBZ?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53ef125-608a-41ea-8516-08dccb2a8421
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:37:44.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwtTeZVR112sPH4qw6iCZ16LBXJaUK9wX7JGGgtmCvY9YfDlGEegbnL6cWulWXudG+pIgNrOnCRYrVWtjV87Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0607

From: Mostafa Saleh <smostafa@google.com>

commit 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1 upstream.

KFENCE reports the following UAF:

 BUG: KFENCE: use-after-free read in __pci_enable_msi_range+0x2c0/0x488

 Use-after-free read at 0x0000000024629571 (in kfence-#12):
  __pci_enable_msi_range+0x2c0/0x488
  pci_alloc_irq_vectors_affinity+0xec/0x14c
  pci_alloc_irq_vectors+0x18/0x28

 kfence-#12: 0x0000000008614900-0x00000000e06c228d, size=104, cache=kmalloc-128

 allocated by task 81 on cpu 7 at 10.808142s:
  __kmem_cache_alloc_node+0x1f0/0x2bc
  kmalloc_trace+0x44/0x138
  msi_alloc_desc+0x3c/0x9c
  msi_domain_insert_msi_desc+0x30/0x78
  msi_setup_msi_desc+0x13c/0x184
  __pci_enable_msi_range+0x258/0x488
  pci_alloc_irq_vectors_affinity+0xec/0x14c
  pci_alloc_irq_vectors+0x18/0x28

 freed by task 81 on cpu 7 at 10.811436s:
  msi_domain_free_descs+0xd4/0x10c
  msi_domain_free_locked.part.0+0xc0/0x1d8
  msi_domain_alloc_irqs_all_locked+0xb4/0xbc
  pci_msi_setup_msi_irqs+0x30/0x4c
  __pci_enable_msi_range+0x2a8/0x488
  pci_alloc_irq_vectors_affinity+0xec/0x14c
  pci_alloc_irq_vectors+0x18/0x28

Descriptor allocation done in:
__pci_enable_msi_range
    msi_capability_init
        msi_setup_msi_desc
            msi_insert_msi_desc
                msi_domain_insert_msi_desc
                    msi_alloc_desc
                        ...

Freed in case of failure in __msi_domain_alloc_locked()
__pci_enable_msi_range
    msi_capability_init
        pci_msi_setup_msi_irqs
            msi_domain_alloc_irqs_all_locked
                msi_domain_alloc_locked
                    __msi_domain_alloc_locked => fails
                    msi_domain_free_locked
                        ...

That failure propagates back to pci_msi_setup_msi_irqs() in
msi_capability_init() which accesses the descriptor for unmasking in the
error exit path.

Cure it by copying the descriptor and using the copy for the error exit path
unmask operation.

[ tglx: Massaged change log ]

Fixes: bf6e054e0e3f ("genirq/msi: Provide msi_device_populate/destroy_sysfs()")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Heelgas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240624203729.1094506-1-smostafa@google.com
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/pci/msi/msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index fdd2ec09651e..c5cc3e453fd0 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -431,7 +431,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
-	struct msi_desc *entry;
+	struct msi_desc *entry, desc;
 	int ret;
 
 	/*
@@ -452,6 +452,12 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
 	pci_msi_mask(entry, msi_multi_mask(entry));
+	/*
+	 * Copy the MSI descriptor for the error path because
+	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
+	 * interrupt domain case.
+	 */
+	memcpy(&desc, entry, sizeof(desc));
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
@@ -471,7 +477,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	goto unlock;
 
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;
-- 
2.43.0


