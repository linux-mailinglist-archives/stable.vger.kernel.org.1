Return-Path: <stable+bounces-150653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458EDACC112
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665761886AC3
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A912686AC;
	Tue,  3 Jun 2025 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jYGEEhbX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c9j+kUgE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OnM/sCrx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC119066D;
	Tue,  3 Jun 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935007; cv=fail; b=hmcuUEIaFV+0nkHLTb4Wb8yjMOC+ZPnWm12N63BjeDunzkqegLAzaT9K/NF1EnMfhycof3ZB2Dq7qB6kQsIMa4NSSF45f5JtEWetZRPEAr+LMNLhtZhlRRPT0RmpEJw0uldpGY5coyZT51GvmWGfi6OBWKlL5bVxr/Nzs46eITo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935007; c=relaxed/simple;
	bh=G0SmCgzC1N0k8JYaMYUbsCeW6I/X+UFRNKMhfBuhQmw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M9cjiFnFG+GUYU01WtU/rTbKGKxWHx3kbTeb5aDsl9kKcjtm3iHuH2Sr1iqkp72/CLDTzcRmw4KFn8d9jE+R0ygZZsgFbEcZWaFjhDWczH14WDU3g/a5SoKG0NzHmZSHl36JLlhurx5NRKN4CdGXw4Ma5QxiY+7G6s81gNwbh18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jYGEEhbX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=c9j+kUgE; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OnM/sCrx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5531BViF016087;
	Tue, 3 Jun 2025 00:16:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=5zuX7Tqpi/b+GljH7qQ
	1m+JldJVgprO19sCVe8zCKc0=; b=jYGEEhbXAaEYbikdPrYgA6XMuxiR0AeGVLF
	JtjQxvzO4XHIX77m6B50up9Men6s3MGpfJlnvZ0fush+VrolaGklEP3IQnWzORk/
	NJNbDFgH1ms2JwocSAIG0rf+omrCDzyQfOIyncHKtRsWwPjG7O2ASJZ7C4GVa+pv
	c2XFefVt7o2lqJ+9PZRz0Xl1oKp5u1CXn2jiYJGzh8MhJMnvfpSpRhhzCKeTFWQ0
	oN0YZ6QGyjTS6IohVQ5JSsz92+m+qQy9GWaMctIISe6kT1Fy2GUukELQggK/Amc6
	Z9ebsakZ5BGsbIUrr+4fiU4FAjnHpyDYSExUERgwxTjASxZWFsA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 471g96arc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1748934998; bh=G0SmCgzC1N0k8JYaMYUbsCeW6I/X+UFRNKMhfBuhQmw=;
	h=From:To:CC:Subject:Date:From;
	b=c9j+kUgEqh5/3HNMXQX7Rwx6t50/IST96Pw1w9XLy2q4GG5Ya4Z+IZlU5Gjs+ivCh
	 oyGMfcGsoc/HuOvXLX7hzHaWLBMNc5K9TsVdMn1Vhh9sHmdtAwbPUotFjTtNakt/7b
	 mSKmDNjCxMEw1XlmoHP8GGdbtiDvsVMBXbGkZhxjp04u6uRDOxeTZZGzfmtjLw7ZmE
	 ugGVFe2D/3mEiVmk88bHJt6oRCdbwjNe7jgTGVhwpKc9R1e1SwcsN72G0KFic9MQF/
	 8nnnZ56vrNmaw1SjE3uPDaYksn4T+zhqkUkBg5htOgfNkhnUiW81r7eR4Lzhu/bit9
	 NEvezy4wgauww==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EE0AF4052F;
	Tue,  3 Jun 2025 07:16:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ADF25A00AC;
	Tue,  3 Jun 2025 07:16:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OnM/sCrx;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A0EEA40112;
	Tue,  3 Jun 2025 07:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYcUe7K7IUAm1fX0tzZyyhNt/bWRv4Hqt8HDTR+ZaJqH4dEKpfO0k/Q8dIzb5XQTFRYXgdhJQUXPsMtw5Ni1KkSoI83HX4oKJ5AVxQvW1rVxsEJNcrS/0ooiL3AkS4xZJcM884zT4OK3Ly4kzzlD/0+bpq18jRMZ15YAg8+rF9LiIchuaDXHUbBQArIYdtI5qJbohSN6HUUrfSFZPrY6MJUsFDjOfYuLmYXZwpNlNMRt2k559sbLP5wZuZHD6lQypIai3qgKTzJLu8II0AehEH6lsaqigP9NlJ3Glfb3vYWUVQ6AyAKWHn/7B8BC/sNnkP+9kcP/s0FWapaH1YLj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zuX7Tqpi/b+GljH7qQ1m+JldJVgprO19sCVe8zCKc0=;
 b=k5R6oZ2U0tIwuF0S8OTD6ZV9Ag5p+lA98gpxmRZDrPUN20Sq63qllR3IQ5Kxs5t8oG9wmp4bcbO2eC+g3ifBb+0ZOG24X+F+uenXNEf60/bYDB9770gm/5epAY7N/346E35vYAP0Qua7IrIFlhBGxStTebZ17/EQg+ndTFJgiOnP/fOML5A5ZlWB1TetkN/wdWq0l/qaIf8k0tLmFZb4iK3OfFsTUbXH0jIXunSQzoE9hP4QTnug7vVAPdybQyMDNZxdxpg4Y6nWUiE5Pe1aTQBOByKVkpIzGBZ1PzLvkCveR70+ZGL3CugwTmbZY4BsWtirepCo7HApQsk/phyXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zuX7Tqpi/b+GljH7qQ1m+JldJVgprO19sCVe8zCKc0=;
 b=OnM/sCrxxqGaxtgY7kFhiOeANSwWofYy94U5KHfB64robqpu2TnM9SQjHs1Cy5O6plW3GDnln3790wO+c3q+cFSlMVV8pRrtKc6rubDN4TdNm5+c+5yTsc3QlzwXdPYxO25TQF3McdfrSCIw3EGT5AxWI7HUa99X1gewhXDMbXE=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 07:16:33 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 07:16:32 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v 4] usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY
Thread-Topic: [PATCH v 4] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Thread-Index: AQHb1Fdu6pBuTYXQQkqgiuKMH/dL/w==
Date: Tue, 3 Jun 2025 07:16:32 +0000
Message-ID:
 <35036b774510b46191500985ca6db57390d4a246.1748856956.git.Minas.Harutyunyan@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BY5PR12MB4098:EE_
x-ms-office365-filtering-correlation-id: d5513363-d643-428f-f840-08dda26e9143
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rhb9vO5L81gWOA7KFFYgVrUdnhMozaln2hFxolXz79zMxerlvzd4pjYBDb?=
 =?iso-8859-1?Q?8pi4Uz/YOFUmZvSbPRMCCxV5qpHchIQxAoHqPwTNZ4WJ++aE9v7CsTl9Av?=
 =?iso-8859-1?Q?YRg48Dt/d/gM3EWtC6stj6kntqnWVLz7o0exx7VDdQ8fMvnoPDU6IvYzZF?=
 =?iso-8859-1?Q?vHfy4l9sqA0tJsgagSb3ZGE/o8d2lXLJg9Y4aOd3FfNvltozMcL29/0N4d?=
 =?iso-8859-1?Q?GqaZb4eXiFCL0mt1/6RHWjKZlRj8K1BZk8ypWP38Z8mUKGs3/gnzLbZB0s?=
 =?iso-8859-1?Q?tt7x2dYFw7Xyjnn+4h7SXQPxe0KuwRz7PSPSi+zhobSQ9nqMQL/0lasvnG?=
 =?iso-8859-1?Q?hbNkHRX9mrqgttuyWIBazT4Ob0K9Os3VuafJMxXwvTuh3glhIZyE4Mu/P9?=
 =?iso-8859-1?Q?UeNtjAWrrAtfgqlCJ9TvaKN4l45YnTTVcduB/UrGikYnCWvcLDxJ/XTSWC?=
 =?iso-8859-1?Q?RrxtEt34vya0NoyeG2FJ/UCHdOdT64xi7QIRAvEIdNuHP6NFRijjuu9Q9i?=
 =?iso-8859-1?Q?bValmsiT0VgrCze+EWRPj9+3JuFnUB6BjO3xYnTGtSrJxfYBnCbczfQr1K?=
 =?iso-8859-1?Q?CNYKmr5LlMp138NcOUf1DDRwkEn0/e6KAasfaTRKD1LkVWANkoUOs50Eiu?=
 =?iso-8859-1?Q?dyCWDMq91n0R10VLFbmJbMLQmuH0Ixjy7AaplWvYNOlAJxZNNipECOxTeP?=
 =?iso-8859-1?Q?TwP2lZTCekEQcVKCB4JChM1+oy+L2vboR3C2PNaOctrJIQmzq9kjMeA1U1?=
 =?iso-8859-1?Q?mD9dk/8i2LwrA9fRMotGkqGRm83Srwrxa8nTv0HxC7TiTXkIsIDF4n2Emz?=
 =?iso-8859-1?Q?sec+ttRkX6VtrPpijHcTBky8/B1KdW9/rg6tfmy216M8cPWGOAbWIVj+nt?=
 =?iso-8859-1?Q?s35nINgg5IotKJRfakJk23i5OmvwRpzt6QCU0w/EHNgZpaB2/IUJD8SfL9?=
 =?iso-8859-1?Q?DAEQq8lcQ9nZMzeuaft3IVQ8bw2toBm4zht9B42I4MYDgXb6jfvZC7zVPG?=
 =?iso-8859-1?Q?8GJx2bB58PlxV+iIFunAInPnRK+fXEavbYEcV/L80gyN/IyG+D70dctgdp?=
 =?iso-8859-1?Q?ZLvP1LUMAtKKMNLAPD0jN7JIF00KsnL0zmgxIIAvat14gTlCmza/h/oIV2?=
 =?iso-8859-1?Q?+/Wtn7tUuc2lYflzyEv5ryXzalcDg5vJwV1welmKn82mjX/dO3WMN+BUvV?=
 =?iso-8859-1?Q?LtgeipuB8GMGkVhRkBTX4dqYbRuPSDntj8nD6NloGkK12OgUaawYcURLnh?=
 =?iso-8859-1?Q?JSWqhTWH1vcTsL0HZJmejoWtF1LSjcIjI7Ab6F/gftKjGO4chVWXOu34G1?=
 =?iso-8859-1?Q?1tvqBpMCHBggRT0DV2Fo3TVa2C2t5uk0MK1YMp/HpHlv7nhE8XYN5EqGFh?=
 =?iso-8859-1?Q?lhmwS4GCEbvrNIpQbYAziXMbjJNnSM5zg5C4E8zaTXCP8XXuPeuOQ6wIZ6?=
 =?iso-8859-1?Q?x2LYIxmyryEJgiyTKDC2+QFttmvdmhslHrG59FHzb/pslA9WCs57pCFg/g?=
 =?iso-8859-1?Q?YLDMkyvjtz1dCU8RLtzs68CGUpnJf4nuJ+NBW/ezlku+aJBAWGf5BvNMas?=
 =?iso-8859-1?Q?pm/H2ys=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jnMWZ0d0zVAT/13oqHY13/4DTYExkmNgtiAMFjAbVlyjfzxvuHC5/+jMxx?=
 =?iso-8859-1?Q?wtfXn/Qi0Gu2QmT+qmDDXTUQe9vOdNbhu/PSnTUv3XkfTLsKlEHk+gjjnO?=
 =?iso-8859-1?Q?aOEwc5Ew5fn25BE3ulvXQ6nIOSoX0tf05sCyG8k/1jUh++wxQtlBcAyttE?=
 =?iso-8859-1?Q?/NrK4kpcZqFYVcyLKcWVee8Z4JzZKv46uQfV6tFJCktiHpNJACyZdKrc0O?=
 =?iso-8859-1?Q?IzcPyw28G6sc4ic3zuP6Bj5dl7ccc4JvDhcHk9eVeckKXpLer+Wmdhyh1p?=
 =?iso-8859-1?Q?b56EuI2sCl5cJkwdULkEZOKPWnC0T0vSvY2GQuEM7H++oDP1Ez+JHkkP3d?=
 =?iso-8859-1?Q?GMIZDbsvdNOKwPKro6tAV7t0jG502HN94ma03WwMdQ/WcDaQ0UNYd5TqWD?=
 =?iso-8859-1?Q?w45iUPWyOjxZTE2xAZ9RLEQAOWXB3gUHSRY9fy7ORNJs7/+ah2Ec3Hvbhn?=
 =?iso-8859-1?Q?XowqeQtvDgU75o22dnKDrUvwCCTsxNKkMhvxSWhH54B1E56A3+3iN5kC43?=
 =?iso-8859-1?Q?yOzFbZ47upOs5HrTTESJN0P+8aaeFOsxKB2p74GgQMlt1h0YhR/rZwq5m4?=
 =?iso-8859-1?Q?6Kpkzq9crJoDAWi2Q9po2xr7Jp1BuGIFHgKEJ4SNe/GwN7D4lbw+uy7rob?=
 =?iso-8859-1?Q?vwD0XAq3UdtdzgGsQstGIOq1wRgJH7bfVOcS2i1iQwp3bPh5cOnkSp4skb?=
 =?iso-8859-1?Q?jgyWHEigiZUIpb8xWqFi+Fu5VdIyhGNgyUt9y5cC8+czbgkjh23Jl+P0OT?=
 =?iso-8859-1?Q?iMwPo3n6j3B/wIpxwDP5wP/58Xe+jbICmVSMKSVBgjpwaTv+MRKo6R56gA?=
 =?iso-8859-1?Q?KvMLqhFIXg5IA/7GpHEvKIVjPOEhgshgHBohjMvhEKmPDmyuBZmgHLu6Sz?=
 =?iso-8859-1?Q?fqpARGMQ/PXVvgEC8H4QsNdroo8oAzHcPAa0i8v9sM42m9e4KrNdnV/bLr?=
 =?iso-8859-1?Q?9YAARVWRcXeBHvn17HcMVPBbhLEkvpxkPgfmBHAXltTxhxTBpY1KAEJyrB?=
 =?iso-8859-1?Q?h85sYVXGLBocUr8FP9loBfDhPjW3N2HOwPEu0WlWQZVUa53kibMluma6bO?=
 =?iso-8859-1?Q?9ZdUxZgyaAvJZXMCUzlKFYuSseN8vPNwT2C+I3S/nkx9I+QwDF2ZbVSWSH?=
 =?iso-8859-1?Q?A6giRGCAIjzuSeY8vrgo74Nr+tX6P5DQcIDxyCHf19hsTiTQdpTJBb+ENz?=
 =?iso-8859-1?Q?G0sU/SPrDoAdVNW3uGY0nuNxX5sGCNgwBSsKdc60fLiPhLBKzLHhStJqtU?=
 =?iso-8859-1?Q?20BDry0s+QnCUwFvFfqSP4YP5p8m/5ysuveUr6MVO1wYJ2fAPYc3qHm0d4?=
 =?iso-8859-1?Q?Eo9I8f3Wj0hEcpZQEhaw8tiXWknOOQwwF/6KS+QY0L5aOnum6cj2r05H9H?=
 =?iso-8859-1?Q?/SKT8+HS1vQgWJHl7u+9gycHCmsMsx3Xdq6W+HFnKNa0aotL6d697ogInM?=
 =?iso-8859-1?Q?gu97m0rOoUCQfoaddZwL59CwkxFGeVv5kUyMODtXvc8htNSoLaSTA8o8F8?=
 =?iso-8859-1?Q?aXrajE7oCLvkvdT+0A3Rb4e1NNR1mNmanBuY32pp/onj2O71hxFH8pbmbM?=
 =?iso-8859-1?Q?mrovsZPzGidjSmbWxVtNSK8WvLono6O0SLRDhX4JatUbiXCNID/dwXMIW3?=
 =?iso-8859-1?Q?M32dcOaxjMmQpLwNCksRYlWmIdngutQU7l?=
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
	Kh/THoG0Szbw5ZZ75Zqk/CY1YikPwQDtV+Obpx2WtAb8CvYVjfC/qLp8Rgcyvm9hsx8vT0hMBxUibo2FPR0+Ms2j1e20MIElxkFRV0cRBGS8+98YaIjgqrTWQh2xAfSueXTQlJYE8zIipc4bKvVOL6/iYDK3K3PYa5zaLmGTwjNSpF1pAAlM9ydXSAC71TBkeio0kuKN7vwHH+3xDAt3+b+yzsDt/ZT830J/qnlYqpFNZGIPJZZu/uq4ug54pF3d1SgejfdKT11Px4Zg1gocm4tZEW0VXy8eOTjvcM0qOn+sxZB7IR7iOEyNSwlSvon2U9fC3LaFVFJC1oeSlmMuCm3L4I+Hq2eb3kRGn/JW18AB7Jblphc0j1oHr04WF8m3sTTY8E2sNmwp7AWgmXEMKGJNaRHjZNNMzq+8J8BVH4QGNJ4Q7HETMZuoHC1ZgxxEQZCbPpnyuBRCbHjbz0T/LS5fdCmWvxVqdPol6mc+jkmtftOLa/g0e1S7U0YsGro+T3rF2vRcnZWJqGCTaAvXS+EHf85G41v3YY6ybBm/ldHwORbv4n08PJPyUxBYMd9eVqfvCiNRD17wytr39GbRBOMm5X5Lyj67NZGzYM3XX+hMRuUtXBvmpOjsojBeBv2KxxGnn76ep9WtHvy32nfKDg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5513363-d643-428f-f840-08dda26e9143
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 07:16:32.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3q5xj+/TvFMJta4PMrkAekvSvfh6tiosE1+0AFQ+bftoUYhLICDcjJSXCx2x2ZBJCxsozOcqsVSLIQypMKPNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
X-Proofpoint-GUID: ZZeXyxQdfMolDACk9REL0IhaKVHQ0ziq
X-Proofpoint-ORIG-GUID: ZZeXyxQdfMolDACk9REL0IhaKVHQ0ziq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA2MiBTYWx0ZWRfX6Q9YSPP8aLlY
 PivEiZUiaR4KRKRZ4aI7Cf7UFun5p8URDvBo8sMxkNc+5yWBeAatPwhgqt2av2+olD6weErdgba
 ly+mN0QJVGMAC23iyuf6BWLzQwYw5gN2dAP18GxHcAgEvj0XcuqyU/bzoShNjtE/oUuSDwGTIn6
 1MjjfFImeFSEzzWL9nuD/5XLI7aSC0JLPPXU/PyqVQ1mrbw79SofIp6Kj9bwSxoGDazniqyVo4C
 hredqfz68mfzvNta730TCDKXm/+qY+ainvX3ivV6R4WoTOTv+cyZ3+tNZbcXe/nBuYq4E5pT0e0
 emZYrK1xJ7JtnADUhQKBefNHP3mQ0gIAfjMdlTdqLnmacBkuqLdGunpptOtel3XYR0Y17T4sCFH
 qxfkg7VjG449q+jhR+HiwOuh1h+jZqEvCvzCuYxFaUthTAfivmQHyPgcY8byLM/8sjq8/Khv
X-Authority-Analysis: v=2.4 cv=VIrdn8PX c=1 sm=1 tr=0 ts=683ea156 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=1nkadCgX71emagpZ3AIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 mlxlogscore=709 phishscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2506030062

For UTMI+ PHY, according to programming guide, first should be set
PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
Remote Wakeup, then host notices disconnect instead.
For ULPI PHY, above mentioned bits must be set in reversed order:
STOPPCLK then PMUACTV.

Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
Cc: stable@vger.kernel.org
Reported-by: Tomasz Mon <tomasz.mon@nordicsemi.no>
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 Changes in v4:
 - Rebased on top of Linux 6.15-rc6
 Changes in v3:
 - Rebased on top of 6.15-rc4
 Changes in v2:
 - Added Cc: stable@vger.kernel.org

 drivers/usb/dwc2/gadget.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 300ea4969f0c..b817002bdee0 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5383,20 +5383,33 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
        if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
                /* ULPI interface */
                gpwrdn |=3D GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
-       }
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);

-       /* Suspend the Phy Clock */
-       pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
-       pcgcctl |=3D PCGCTL_STOPPCLK;
-       dwc2_writel(hsotg, pcgcctl, PCGCTL);
-       udelay(10);
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);

-       gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
-       gpwrdn |=3D GPWRDN_PMUACTV;
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+       } else {
+               /* UTMI+ Interface */
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);
+       }

        /* Set flag to indicate that we are in hibernation */
        hsotg->hibernated =3D 1;

--
2.41.0

