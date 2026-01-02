Return-Path: <stable+bounces-204517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1DCEF697
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 23:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE2BA300A9D8
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64D2D5923;
	Fri,  2 Jan 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="u/53pWOa";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z487n5u0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZxQh1sS9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73A1E5B9E;
	Fri,  2 Jan 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767392456; cv=fail; b=V0SdxijpTfsPKUqc4YmLX5rJfYRC/Po744sJE0K5VY3RfmMR/zt3dgo3Zd1Ug7Ri1Bvs/49Y0ApJ7+pyr8sAAJdvzDuuPN4pa/p7SDFXzEWYJIcktfXxqx0hmq2DB0bNc8D++ObBGYtOS2uxCFsBf9o+q6ZNuskom3nQgFlrM90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767392456; c=relaxed/simple;
	bh=Z2URGZbtAW+6wdC1NWo1KZLSImqw1fa2I4g5Un7ereE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mR1VUUKIrlJ5slZ6B5wy+hVk4V0kvZgkp8mXpDkHpJyLWLx+T9EWSVNEAj741OiUGm1eWH3xXVJ4L7I4ZIhe/XvaAKsn/OoQhfh48fejQgpnIc9OTtzpWtHlKE6XXPvEDwZTo+z/SY97ROWtQWlJzSBhRvvmMMdSqiNwS2F3XAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=u/53pWOa; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Z487n5u0; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZxQh1sS9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602JIlP63235640;
	Fri, 2 Jan 2026 13:53:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=gn6tLMkPBt4BDNpTHBf
	qWZKJaxBucReOviuPzs4vU4I=; b=u/53pWOar6v9jAWS8Vx2guW1Sqi48c94tFA
	G8Pzzm3TLJ1UrTo/mh572n4LhqMqrhPCVg8vhtjTEdL/WVQmeL5sjZ1XS6YDmBPC
	D1jwFnQ75dTPZg0TfUfNu0YQCaNl/Ly6mhS7pxcae9xh8xJt7riDYfdAGwd87W8l
	cmcENwvWwrCZeQ5tKdZ9l3Pz86FHwiWNICELe/W13Axzr8jGG2qyzA98mE1nVzro
	boBr4i4tf6D6sTC5N1dc9ZBuy9P3E0i2LHl5JqB3HBj33IkxoTW3Uf06HTLoj9Xm
	bAxd+AKiXF7YpY37G5BSRM43t44mhwF2Qh45gXCceCt7St3u/vQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4bcy60yxnr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1767390832; bh=Z2URGZbtAW+6wdC1NWo1KZLSImqw1fa2I4g5Un7ereE=;
	h=From:To:CC:Subject:Date:From;
	b=Z487n5u0oHKaIgrUlGj+KcRksDwcOE6AkldMvYd/FOviwLRgXgPX6yyHUH0ShCkfZ
	 /Kmp3dntbeqE2y270IKMeVJCZGqdx+biYtRfhCF7d2z4lGvwjxeJZ+oHNoEgI52pvX
	 LqHkmTn5FJwPxwTxyuh3ERMlcob6esdtQJovx88yUthZwNfwRii0eicOTM8rgKvJU0
	 88fdtZ0KGUbeQ3qRvyOU2xWi77NrB+j/6MhZ5WZRC6ukLrAqYsgw52HieKxzNDZ4pi
	 /F4eCGt+AXjA7+EpTVzfORbu4IMTvpAaMuuLfuBPVO1HbPK3J/hgt9MypIWgL8uF7Q
	 orK37lkA9OnaA==
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3522F40517;
	Fri,  2 Jan 2026 21:53:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 63B82A00A1;
	Fri,  2 Jan 2026 21:53:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZxQh1sS9;
	dkim-atps=neutral
Received: from BL0PR07CU001.outbound.protection.outlook.com (mail-bl0pr07cu00101.outbound.protection.outlook.com [40.93.4.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2F28640525;
	Fri,  2 Jan 2026 21:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB7XM+wV+ulUrUCrahvUarD6gt0c9i8kYUS+zoqIu5Us0qg0KjH3eHfVwD/Mk9kmmxze73t7Vg8w5xKrQ0zSXSi7DwXULri36GKcg9BImjG+J8TfhsJU8Pi9W0EDaen9yMLZESOX3GYRJwpdaHBnUFAfpIe7FiSIjRsuswOEtA2jlowplemIf2w1E/Kswoi0QNRohA/g4K19AcnQWY+qAEkj1R0jQZoISIpK/jqe06Nos9Fpl5/m2dQ0HJHOBbO8evWkCPBKenzrP7xhDTRPHX7yLKk7xV22UAR1QzgzxaiV+UNfnHeyiygCL/XTUD02amPz7bftwEU+xHaTxNzI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn6tLMkPBt4BDNpTHBfqWZKJaxBucReOviuPzs4vU4I=;
 b=Y7pwJC60B3zPYVx9rmTOxHeEhlK9VXxuqky21+0NpHvUasLRyLx2dqZ7h+hsXmP/h6v+/oUT8gBHd76yecKvhWQ+/Eq2qXPRaz0vOjrn+veXp5H/lW/ODe4D8571Y0bCHrHD4NGKVmXq3th+dShD5o80svStREUVCIuzyh1jhL5JOe1nO7Uw/+mNKWaY1MPKb+QCN6lr57fokHal/lWUJmJwgSFtqtUV1jzvDtyN8IQ/Iy5toRLrkCjqWwGemMF8WfKP8YlTjUxXv/RCD7IUxY9203m+Gyf9ZFtKh7tYdM6uQFi9lAzdtK/VaIBU3DwXSzf9LKKOr7qR5SxqLeUioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn6tLMkPBt4BDNpTHBfqWZKJaxBucReOviuPzs4vU4I=;
 b=ZxQh1sS9ld31wd40xFOjIsEYi9UJnDQQTiwyVKvzBEUwaVcQqzeYYDNPlxX6rQOwFQ42mGHNUCnxLBAs7ioW7pcHF4Um/eqQAEjEfPXzF2f0ouNmnuVUYssOrZ9CJ410vzK/tdXn7A+emW5zEpnXfA9a00tePV/3UqIV0M8wko0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 21:53:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 21:53:46 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: Check for USB4 IP_NAME
Thread-Topic: [PATCH] usb: dwc3: Check for USB4 IP_NAME
Thread-Index: AQHcfDJFanwM3APynkKbEqECWojSNg==
Date: Fri, 2 Jan 2026 21:53:46 +0000
Message-ID:
 <e6f1827754c7a7ddc5eb7382add20bfe3a9b312f.1767390747.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB7318:EE_
x-ms-office365-filtering-correlation-id: 32fec2d9-229d-447f-c962-08de4a4967d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eJ8iSiqGO9eJ3Vjo+lGjh197SGwFxIXOKwEyakTWHPFsyeRVCrcd/7u3Qg?=
 =?iso-8859-1?Q?CabHwBxnS9DyNjtjtajqtDPTpFPLFRk8AJcfW7lQC9QJDbmTUH722crQos?=
 =?iso-8859-1?Q?/BOaQZFHGFEOk8n2ZVxHQWI9VxOdtLUvElsAo2SC8jpqT/f5/fAg9XbcKr?=
 =?iso-8859-1?Q?oALskvG99A7Fp1ms46zBvnnBESX9EICpDGTkRnkdvS3Jb+rDuMiCyzqnti?=
 =?iso-8859-1?Q?BitxMcpNdQa4fwzNDwE2jcV0aRAJj0FQzV5DfpJgGdZzXidd2y6N2AgbYg?=
 =?iso-8859-1?Q?tMl4y3nociXqBfLoNh8epP7i4GfHkFxSLIFgxfUy4Ebfr/mO8R5nBqRySG?=
 =?iso-8859-1?Q?H279LMeUZ736yLirwlvdwCF5exWzsaJFVMs39VHPDO5ocU2CZIlv/14u2E?=
 =?iso-8859-1?Q?LzAA1x6LmEC6D1DgC7aaRcyy6/ji9fRJpDUMNs0XfYVbfcC1AzEfHks9Mm?=
 =?iso-8859-1?Q?BuEYcLTGgW6p+plXGUt5j6IlbujT5iDIe1HNRwW69l4wcYYHVHaJNKdzWc?=
 =?iso-8859-1?Q?UsE1qZWMUzZQR5I3K5rZ2WPJ78f7292jNnyvx2LyOfo4h7Uy1fQSyEW3kO?=
 =?iso-8859-1?Q?yow2Zg1w15Ha4GdlHP6dvL0rSbdks/+yr+hgGSrpObDFshrKiD/Gwoj2Sj?=
 =?iso-8859-1?Q?pG7lzThTAmB204Ax+NKSBBI0aD1H0ZGfCgTBcySRqellyMIGITR2GsdJPy?=
 =?iso-8859-1?Q?tPsc8ObrDJ8VjOtUtTcPannCwSfIKKLY0TV9OVxrPSuA5lq6AVd3HDn3f5?=
 =?iso-8859-1?Q?omrzkkh3Ojd8xKKvGh8wu2KnPIgBloM5icC5Dr4IAgBm+GWFnVZ53L9sP+?=
 =?iso-8859-1?Q?e7qXgXUa5KW1/q2FGFD+67lljqFkyMnY65TzASkzOy7Nd1mUYgjQXnLiCU?=
 =?iso-8859-1?Q?kRJvqQivqbkfZKknMTPj/dKnwFjsDSgMFwlZKAp80QICM5zwriC4h58qiw?=
 =?iso-8859-1?Q?u5hf7MNvODW/tMZXS0AoMnB1ZlaGlZQck5oZtd9WyFPQDl0fnB9SG6kxv0?=
 =?iso-8859-1?Q?hW1tAal5KgrLQw/MmqGC+ZT5G5hAQNUUuAMrK/AOB5U5PqWYZYBwZFzS0n?=
 =?iso-8859-1?Q?Ou1HhfpXfGCA0S22/S4GNihME1sLGeHtuntc/8e6EAEb+t9SIaEvlMxwbQ?=
 =?iso-8859-1?Q?0BVO/xKTJPa3bKmNKoc4UdlhAk3VKMLcSgYYhNRzZdZA1FwBwrn0quAhY0?=
 =?iso-8859-1?Q?nM/+pViGCzquYL65I2FDk3Tv0nIn8xKRLPamaOyGQZYiuBOw1R0EkcGPEF?=
 =?iso-8859-1?Q?A//VyA8fdOMPJJIC4x//bNiQ/wpzlwMoVtRquNA68mUhvXoBVtg+4bRGeH?=
 =?iso-8859-1?Q?FNTdxSeboFAmviZU1mVHSjPLdSMUF3oh8HxEDHZu+PlDprLRg5OtpyRVAo?=
 =?iso-8859-1?Q?Gtsc8TM0hiZmXbuRyva0ojThfkoIG866abc2irF1ZSv1fd+Qgi6Ir7n8NG?=
 =?iso-8859-1?Q?1WkEuvosDJm13wgj0FkRMysf3Ii5e57/WPgBmZ/yMRuh2a/8IuAVAZ4wQx?=
 =?iso-8859-1?Q?o5ctFPuhwtm6odxpOdbpNFXO+ca7yZs/XA8TMv+5OPTf9xzGmuSuZbuvpq?=
 =?iso-8859-1?Q?6Ni/8WXYNrVB5mvJBCT1mthr34zG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tIwV8n17MXjbv4bknDEFU0+ZcP6A04wzMFHIVEYrsUyK/Pp6rNEpDkiKmR?=
 =?iso-8859-1?Q?B6Tukht9zD9GzTsZIAAMXPuctq1byEmCx/FjYQ6zyIfMnPsk4TFQcl4tbT?=
 =?iso-8859-1?Q?ZkPWe5iPcrgaBNkarMyu6YXAerPO5XAQEPXvsJnvCzhZ8z8yXPBkW0lzjw?=
 =?iso-8859-1?Q?IySFveVlI4N87wTkCF2SNp3k4cpzVMXPmkMu/grIGUj1OTSTYFXduB+Bd5?=
 =?iso-8859-1?Q?rXlAUgBhAYGDA2WFN00o9t1k8qzRprMeca3q49HNoJYyIS2rxBnLinLFAU?=
 =?iso-8859-1?Q?8aV3/q1apUXtpxYy2vZvY8D6MNmGCGV2UOTXUfG/bVhyfJl/lzBiVjRraR?=
 =?iso-8859-1?Q?T/Tb2IS5YloCN461Tm6kbT1m4CNQjurKBx3Kbkjq7DqGYlgbamsaf8ffNB?=
 =?iso-8859-1?Q?htC96g85LXvAJJ0zZQnKoPcWHd9j7Hu9+sJtwAGpV25yM+2KwJbYKMmbML?=
 =?iso-8859-1?Q?l36MQDoubrRTkCQKxMhkVH0TtcCrYozt02S9FF8uCVAmWN9ZKlJ2NKn7YD?=
 =?iso-8859-1?Q?gnJRgKlZXgEXyoru+FcAvm9z6jQaKWl2OKPV8uRT2JROkrzSy7bEBslmtb?=
 =?iso-8859-1?Q?dgCwIGyDhphqvoZZ1k+E0Q3s1ctEGwBOy+KgdfR2cn/XoOwgbZhDO70hpA?=
 =?iso-8859-1?Q?ijYuanxsAKyh2WGQltjkJ/7OMsyHaQdBO0eFWF+cEklRcx03yA1PPdbeBH?=
 =?iso-8859-1?Q?dxzyYMdiE/ny+kbwQpnkcoqqDLLyjr0q87JEsaQmJ6K3hGC/LW0j+2Tv6l?=
 =?iso-8859-1?Q?lfOCEzsRLCD0qgF9T7bJQfmPgtPJji3PSBQ2lfYNL9IEx3nZ8e4WBFov9t?=
 =?iso-8859-1?Q?kK3M4HsOVJWNM3d5axgC+pJmZE55eNVOHC/XW+z+7rNXrFd1lYez+I90Hu?=
 =?iso-8859-1?Q?aHlak/TNdM5SHpwsOk/CY+Pzw5M9jOM97Hs0tlHAQwiWKYP5MuGsBQfPas?=
 =?iso-8859-1?Q?N2/jJe68U/DserycEbZfhz62xCibmQyQcrnoFhZhfExDCXAXHzUOxvVd9p?=
 =?iso-8859-1?Q?GrtBYsu4HIAntaUkqdvkdaLp4R8eIWxn3GIwNasj++OZaPg+QHbViu2k7B?=
 =?iso-8859-1?Q?FUIIPORxEqsQMIcGXyWZTIhTbNkh3tcAHVHrz9IZHlr352QBdH2nsYvZPM?=
 =?iso-8859-1?Q?WrK99oQzdDXT/LNTi+SAw0/Jf8XNLNv+QvR+PzBT6+ASJ6jTIPHqwv4FZ0?=
 =?iso-8859-1?Q?Q9kxnnAuLOvSahfrKQVBQn5Zml2JzV6TUoKsNSYf41DHv1BlKdpLQy73sv?=
 =?iso-8859-1?Q?4yBYMJfNNRUwU413Jz1uFD6Dw+RRa4Dhiel4dsJ6V1qgX2AUTONDa8CAHS?=
 =?iso-8859-1?Q?IwIEMwxi9zQOpWqwFA13wC8EUEGFy1kj85DKsLzt4rS3RIjpVbnBTOjlEU?=
 =?iso-8859-1?Q?2gg4QzCw9vWcrLTJVn6xLpB3bybZ4A1704wJdHVE4t+0u7p4m3MVuxp3YQ?=
 =?iso-8859-1?Q?qX67vVSePkexSlSSqfmhS75sCYKaT+QvKPVtH96dYA5yjMnaffvmAViFra?=
 =?iso-8859-1?Q?r+fFleJ/YXszysBd/pwZP1RY/XvQfABLVQrc+MlTLH82XgBEIXE2eDMRs7?=
 =?iso-8859-1?Q?acTyKoybyg7ySHXTz2P101TsBxE6L2gHAVt0YqOpEhCR9x3plgFGrE+lEW?=
 =?iso-8859-1?Q?k9gJZrGEI1p+Ggcf0jgiRCuq8jSI19vyivt9Hu2XNV0E2Vk7cpLSMeYtXW?=
 =?iso-8859-1?Q?K0jKK23Nx95s0bTThQVcQQESa4Cr4D1YJGy3jkkGwm6I0KUZcMVYQFElDD?=
 =?iso-8859-1?Q?dcvbKPgrOzrxOBiIvPVR7oqu4V+/F4Y91YwDWyFARxqL0c/jLKXdheb6f0?=
 =?iso-8859-1?Q?XtwmstZIpg=3D=3D?=
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
	X6dcbh7r9zfYY+5twMDV79hAFt5rrmY7Wlm7406IO3NqYaE585TeuRez3jkFt0X+6HxnDXPiYfjT2K3j7WDCW9WXc3uPYa5hM/e7K0a+2qyqy9+c0Ja/mS32RP1mhMlQwlOTOaD7MCI+UHNzPyvD0oEbp3ESNbqkcl79DOB+t6u5NKXwWx2gWRyXg02jZZyBoDVqregf3kvRvb4ZXLSxklw2GJjFV6Hncyapw8Nkdn+UOdmV8Xtw7belLdwO+p6ITRmvT9tplOjrLGczf84dVr8bRFjY8SdAqGEXdXXcBmyz+ZlOKz5bFrf8GIv/uhmoSgRcECO/mJHWCA5oGLDA5i/k1ySX3DYCkj9uJtprRrcVwyg2sFidhjiZFbi0z8zrIQMwSkj1/tYU0pR7Y2E2NsLzX2wPtif+UBHNED2Z2QqDeZRroYwGLkPEukdBkOjKtQZS739WGJiknYC5MVHDqP3iM04di3TGbax/qcnxagGXWa5YWHFKT8KZMjCemRiIOKm4cByMCRS+cCwJ0yvCHwyVogV3QXCBtmpiqxgKJVv5sg8vRRexdv3OX4f1nskyQZ/QCMxXRYPtJKz6c9pMW7eMHcIlhR3UtlQ5UA5wyzpatAgrKyhANMuwA91rU5CeuBxxeBuJ6LH4FTFEMzh9PA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fec2d9-229d-447f-c962-08de4a4967d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 21:53:46.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mAU8Rxuub1/GTJwPgRP1MM6FMq3HEXqunA+KgWLdGSIGLM5w06OGIA2uFp7i1yuLtUNpi77tM5kk28OWJ4N9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
X-Authority-Analysis: v=2.4 cv=Vfr6/Vp9 c=1 sm=1 tr=0 ts=69583e71 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=8g9to89W0xqCd_2YYlIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: jYVjCgD23g4k8a7EsL36jSeKOhZDVihT
X-Proofpoint-ORIG-GUID: jYVjCgD23g4k8a7EsL36jSeKOhZDVihT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE5NyBTYWx0ZWRfX04JTvYGHGkGv
 E0B2mD2jCmcz8OjZ2kEitQgN8GC5gx4w+qQ/yYqYcDoT5f6XGenwSbeV0yQPd8pPxd7QVWemF0q
 sBDuCw+VK4zwXNRkz4dnu5e5ltAuyPSc56OqY6zx+Xo1xUb9cTNzP+SRHJG4BmVn3VWZdPjUKWx
 wN2AW0UCLD6pqVkafifJvQ+gVC7fL9D88oZ/8VMXs7UcTFJvi96SFrswCq82TpdF/ZXCbrkb1lD
 cDXoy5YJN74lElTmltlS4/eIfYKO3zf/QterecNVQ0YSw3tl9dhXKYjBCFj7/YOAtAf1eMxQ7ha
 kPGXP7XIMwenZGhjWRLPk5pfZ44VDvo9VoJTwYzVPzkXbPDDUuS+tArCpchezS45WkL1Yv/vqvx
 MImu3SaEUMpaoXfz4poDzyzLTB+fik7/aAG2L2JY5RZHTR5nWxqgnWTdYwUGsFE1F3WhgzH8e4H
 7fvNMfRFHyTJ+Jp4p9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2512120000 definitions=main-2601020197

Synopsys renamed DWC_usb32 IP to DWC_usb4 as of IP version 1.30. No
functional change except checking for the IP_NAME here. The driver will
treat the new IP_NAME as if it's DWC_usb32. Additional features for USB4
will be introduced and checked separately.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.c | 2 ++
 drivers/usb/dwc3/core.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 96f85eada047..f71b75465a60 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -993,6 +993,8 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
=20
 	reg =3D dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	dwc->ip =3D DWC3_GSNPS_ID(reg);
+	if (dwc->ip =3D=3D DWC4_IP)
+		dwc->ip =3D DWC32_IP;
=20
 	/* This should read as U3 followed by revision number */
 	if (DWC3_IP_IS(DWC3)) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a5fc92c4ffa3..45757169b672 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1265,6 +1265,7 @@ struct dwc3 {
 #define DWC3_IP			0x5533
 #define DWC31_IP		0x3331
 #define DWC32_IP		0x3332
+#define DWC4_IP			0x3430
=20
 	u32			revision;
=20

base-commit: 18514fd70ea4ca9de137bb3bceeac1bac4bcad75
--=20
2.28.0

