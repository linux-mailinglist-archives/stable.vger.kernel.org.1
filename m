Return-Path: <stable+bounces-53667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C390DE91
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1EF1F24C77
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44521178370;
	Tue, 18 Jun 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="q+t03pse";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Or9h3nlP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NQsxI1qb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFA13DDD2;
	Tue, 18 Jun 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746827; cv=fail; b=cRBi4yjq2WzoJD/ne5TPaetzO0/UyBIuCxqzlVRwJrNcLo4mmnKefAgGobBMFez9p0WhIxbR3koHhq+A00ZOW1qwltxJP/eBvtaeNIt67JC4AAOvHpnDAecP1G3SR/qEW2RxivUt2Gos59kLhEpiVfQxJomd1jxUHJtGPkUIKr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746827; c=relaxed/simple;
	bh=bDXy3xY+xWajS2itb7+2EeGJDBpV35eSZWOcciyiKdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJriibOp81IRog6ge+1hvBVwPPACj8B1pPS9cDqINNo5k6wmmSRkPC6htYfDWkR/vNGzj9GFGZ4DiVMsArvLyvn4xp7XYI0KTlsl1CwyV4puj25T9pbnlTWtvHLtn+FphU/HQzHBKlw5vJNqVpXLMHM8R78u8TqXnxwPNgH8ciM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=q+t03pse; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Or9h3nlP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NQsxI1qb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILbkuX006964;
	Tue, 18 Jun 2024 14:40:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=bDXy3xY+xWajS2itb7+2EeGJDBpV35eSZWOcciyiKdc=; b=
	q+t03psejzp9VgjlHg4kvWD4jZZ4Z9tAdA+DinSMt1kT7UhkCroQaUV4K6cN+/OP
	i2FHljQd2hNaC4BhWKpV/sJZSRVMwIoJ7dxEWYgielstiJ1fbTkVTYPoSCphSjIC
	T4lgADKdt2Army8C6Jj97P65FOGwT1AuokY8/+UIcNhN0YOTzF6Y2p9wRiSFt8HV
	hQAtwhZqwjHFouQ1yjJLlwTPRhg7lwM4WY+FFq1Z9l96FxPfId/LHyyHBRng93Tk
	MSr1r6DBLEFTbj+PHylEJD5K0ltDQAKrAZhgg8SMWDYTcLs3W2tf8m2mq+7WnAsm
	Uuwh2Vg5gkhm+JgP7thYUg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yujaq006h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718746325; bh=bDXy3xY+xWajS2itb7+2EeGJDBpV35eSZWOcciyiKdc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Or9h3nlPm+C7ZnRSUq+HB/LSakobSbLupZCOkKwwTGygV4ekigtj8DQFmQHggzwqK
	 BhdetpEvHCYDYoqw1t1aAf57p6vrpopMsZG5K8mHjIzkGfwE3MWf/Dlxts7DjHIoI6
	 d37ClhYiP2YMXn9ivlRfoCpVbr0iDf2i0KZxnyYcXR1yBVyU2aVdWRQE5qToDnWSfW
	 iguAPbKT9av+j7CMViEJwO9CuwYxx1QakksP2SHs0z39dsIbogMerJthI5mO0o+nuu
	 n6GBGd0UG3utrRh23RPN1ABmp1ngpMK1yFfTjp7PP1m3icfAlmAecdDPmUqRaT0Tlk
	 LPg9n67c6mh/w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5A4634058C;
	Tue, 18 Jun 2024 21:32:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 20022A0060;
	Tue, 18 Jun 2024 21:32:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NQsxI1qb;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5E1914048B;
	Tue, 18 Jun 2024 21:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD5REt4E3T4HZBz9BHGPkQxfWFEAaWJinn3vBo7rmsdvFUwVytnxqLl04aP9Ixisk4tZ2AzqmWlwRfMomIi2PXUSMZghVkJI6nwuFvoCHb/v7viZBeGKCjs1s/dDPiVu3kBiTRnj5fjTqNnOAVjR+qeevrD8C67A0oNaUgcc+0gBh4r5U3Hh1KjAasTbiPH0hFZZluYbF52chJls9pmHVwN4gp1MN1FuX4HbGSNMI4UO1G07cpcjgs+vnCcCFAaXK2Kgom3VxIFx2/bks8AHJ3US+vjPY7c6mVCe4FV2mpAI+iFf9t+YA01LnWG0BuqcZGExAzxRCM3MIYAgz5br7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDXy3xY+xWajS2itb7+2EeGJDBpV35eSZWOcciyiKdc=;
 b=ObhsAXonSFD+YzniaZepDOH56IUT99O61ujrhdcncl5Lwy12aIF/SXU7uYEhFzuDBQlZ8MokXCZATgnu5jQ7uIlJcA6vX/5BIj5k2R9Jno/CKUHdf5E5DVmxVS8noLmO/GjLVWAeJvafuqXCfzrCalhZcK2rx7wfPsBLCdmReY7k2Aclaj7jZVMprTbclEWgN3QnfNm/LdUhaPH/9zTQpgLQexrKb20XHnBL9kyWNKtup7NQxQfZbqi9Ersh0m39w+RZmw8jr8cUNxRllJW1/hNVqgFijCzChp201y07xoR7N/SZjVlEJ6BhoesReIzRrAFDjZe0jJ41jkOSUyt3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDXy3xY+xWajS2itb7+2EeGJDBpV35eSZWOcciyiKdc=;
 b=NQsxI1qbhVylRziZqMP7l6hmBHggroC3rQkfS406u/CFLY+McRlCVXRtj+eaD07H6MYXrYTrj0SEfWGHwgLtmCCgyOHVokWk+5UK1ljtnVWWCKn1Rj5rgEXTD0YsX6zj0dKpOs9s7sEyMN1tuQ+WvUSv6tDg2cgrYzT2fgPBgqI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:31:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:31:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v5] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v5] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: AQHawX0F1EZSxWeLEU2RGri3rHxy1LHOCugA
Date: Tue, 18 Jun 2024 21:31:59 +0000
Message-ID: <20240618213156.s5r7z7zg7q2dilre@synopsys.com>
References: <20240618124235.5093-1-joswang1221@gmail.com>
In-Reply-To: <20240618124235.5093-1-joswang1221@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB7695:EE_
x-ms-office365-filtering-correlation-id: 23751736-3911-4e01-4e40-08dc8fde160e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WTVEWTRZUHNOVlhrRnJDY053alVTVXRrdytBNzRKaFVYa2tmZlBGZzRIMHJL?=
 =?utf-8?B?RWxueTlSTlA4VDZ6c1BCZ2ZPMTJ6VTR0TXdMTXBiV0NyUEdPM0grQ3RhRkhE?=
 =?utf-8?B?VXd6NG1DOGI5bTJVbkFkTVBIcHhRT2dkQklQeS9LeUV4NEwvb1ZGWlNDdjMy?=
 =?utf-8?B?SXFNNnFqblc0cStiS3dDK2FwQ3dDaENsTXczYVIyVG1WNjgxbExDaE9qTmt6?=
 =?utf-8?B?RkdYUUIyV3Y5Y0dJSnpRMUxqNkR1TURvMkZpdVJkSHF4bkJFT0dwK0h6UXNH?=
 =?utf-8?B?d1FKL1huSlluOStudDRFY2tYMlZ3NEtsMENMNEhDY1l1aGZnOUVuNnliQUQ3?=
 =?utf-8?B?QTdIVXBLWE5CT1JDM3NZeFp5bGJ1RVBEOUhBcGszVjA5TXpoM1g0dFAwa3cy?=
 =?utf-8?B?Yk5vSUUzUEJOVG04OTNKZGxrNGdLcmVzbThQU21sWDR4UHFpUitmUC9IM211?=
 =?utf-8?B?c1Y5TnNTcFIwWFhrVjZ0a2tLQkNsZHgzcHFvcy9iaDVwdnJzcDdOa2RYOFFp?=
 =?utf-8?B?S2ZlUXhJVGtSOTJzaXU0ZlBKRlJ6QmpXYXR4Y21DSlJib3VOZWptdGZmY1c0?=
 =?utf-8?B?RytBOWtjTFFEOFFSV0krcVNYZ1gwNEJ4REUvWllKTVg3enlicE1aVk05Ukdw?=
 =?utf-8?B?NGhnQ2tCNjhnaWh0NWlIV0JMU2FKUk5vTXluWVJHL2k3NTZIMFE4dWZpOHhz?=
 =?utf-8?B?cVBUM3NIL0Nrb1cvZ2EyU3REUjBGVlJlSDVBU0x5ZE5WRXB1WCttejdTMWtM?=
 =?utf-8?B?OFRva2RLR2N3QkpmYW04bXBtOVA1N2Nodis1Z2xDVjJZRFppUXZYdCtjU0dK?=
 =?utf-8?B?a2RQbmFVSFpPYUZWb005dXNFUndkZ2FSc0RoYjBlUDhwcG9Eb1Y5aW1yRDZK?=
 =?utf-8?B?SGRTZ0FiWml6bjUrRUY1dFRHbVI0UHd5TzZRRVU4L3ZpTml5b3QvRUhMQUcw?=
 =?utf-8?B?bjNNZ1JlcXhVeXYrdmY5UUVHY1dzRkxqZUhmMEhLV0d0NjViWGVzVHJTQ0hv?=
 =?utf-8?B?UUpHOCtacWJWSjRuemg4NFNIMnhCWFlqdXVDRjE0V016MTZLRTIwMThKUlVY?=
 =?utf-8?B?cmZRYk8vczZ0M2hscGNNVGxkT21NMWxyTkdIWC9OaFNTSFpQOWhzT2R1UDZx?=
 =?utf-8?B?WXp3ZTREUzgreFRQc3J3d3RRWWZ6K3pZZUxEWmMwYzgwTFgvYUNKN3pPMUNJ?=
 =?utf-8?B?MTZsY1g5QTd1U0thb1IyRWVTTFAwbHk0ZloyWmp1dkVwY2NTWVl1VHNZMHJx?=
 =?utf-8?B?TWNMMzJ0RzRqZWJLVzMwcjVldCtiYTJ6Wjh5MUVNMk0yaU43KzdTZnUweXRq?=
 =?utf-8?B?ME1aTXBZMzU2ZkYzQ05Jd3JhRDFDcHhBTXpIY2Fxa1dXd2xaZmRMS1o5SE1x?=
 =?utf-8?B?YnNyY3ZZb09RSWI0K2g2cFBjRzZ3S2p0dlk2aHBYUVkwS2pPUjBBSXBxTDJH?=
 =?utf-8?B?V0xKajlwWDR0dnpYMkRsQW1XWS9KZ2pKb1hjOHA0bWFEeWZWdmRYWk1XSFQ2?=
 =?utf-8?B?NGtQbWZzcjNJRzEzOGdyR0tSTE9qRjZsdC9iM1ZsSmNZUlVoZVJjTVVvWHdR?=
 =?utf-8?B?eUdpTDhoVXVMYzV2c0ZIK2xEWTVOTUVTWE5GemVsR080OTFxZVlEazU5NHhF?=
 =?utf-8?B?YVFXQ1lReWJGckFURFNGUDRTMHdJT2tWdkxGSDgzQkZpeExjL2Vqb3JEYVNo?=
 =?utf-8?B?SXhkOUJBZHFIQ3o1UVUrcjc4YURWWHhCa1dBWjFYQTMrcC9MU0JXWU5lVzg2?=
 =?utf-8?B?RGlBaDZseXMzZjF2K0xsRURTQ21FYXJKVE9yRlpid01PdXFLeUZ5UW9VQi9i?=
 =?utf-8?Q?ev26VYIkjZjM+nmulJRvVkAsvXicRf26IR/e0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkoxeE5lOW93Z2xpVDF1ZXN2SDNxMFVmNi9xNW5YSGdsTTZBcGNzdm9rdmY4?=
 =?utf-8?B?cUZVTFN0WW5rNURnd05hclVZVEJVVDBhUWMrTTAxZTkvQUJwYUNFaFNGejNJ?=
 =?utf-8?B?WjJJRjJWQXhlRXY3NTNIcTdWYXErSG5vTFRhRFQ0eHBIWkpjd3hpM0FtUXNO?=
 =?utf-8?B?MmUzWlh0UVhiUUV5V3I1NEpRU2VHQWR0VTJGSzBFdnVKSW1SYmpFY2dnelZw?=
 =?utf-8?B?REZKUlB5RjA3eGxjSzRMcWU2TmtzYy9jQ0srZU52NE9YeVhKUnFHdGc0d2lS?=
 =?utf-8?B?Q1JaZzU0cE9KRUwra0xjNHZXNlJJc012dS9wSjBBRHlsSEQ0THNhRmF6LzVs?=
 =?utf-8?B?c1V1dzFadVFhQWtXTW9FdTBFN0N1Rkc3aUthUjBLVkV6ZjBJMVg2VUI0RE5X?=
 =?utf-8?B?d2lGaGduZFl4Z08vVUhhN3I0SE9yZThwRmp2bW1zUEtCRlJIZmZ5eXlDY2tk?=
 =?utf-8?B?b0RUeFBKOXlIK1hKRlpCNDgvc0I3dnN6d0hyNE93MHpVNnUrVDZLZDgxWmF5?=
 =?utf-8?B?a1QzOHNZNXVpOEc5S2NibUtuYlgxajNXZjNaRkFzWVhDczhVSzR1UmpiN21X?=
 =?utf-8?B?eFZCc29mVk9tQytUNFJpVWhDYW94M2RPVGlGUkdwemg1emRLS3dFS2xOSTVQ?=
 =?utf-8?B?azlvOGVmSk1vR2xzUGkwN0swbGR0NHhHKzk3RWkxM0U1NDZ1NUtWTXZIb3lP?=
 =?utf-8?B?V1p1emVtdmttcUIwNnBzdThuM0R5Ri9CMFNXYTkyRWRua2NJZFhObVhsWDZu?=
 =?utf-8?B?U0svdVIvbmtYTmpwZXhaUytvMjhXdi9NLzlPUE0zSEZvR0lFN0NxYW9OakIr?=
 =?utf-8?B?T3dBUTZ0OXozRmZOUGJZNmNXQytEeHRYMk1zYUxyNzljRW1lTTJaMGRXUUN6?=
 =?utf-8?B?d3UxeTEza2E5Wi8yVjlsRFByMitYZWdYMlhSVHFNZG9NUkwxMFdEVkRZeEtD?=
 =?utf-8?B?S1plSmdLaXd0czRNcDNITHRsVCs3aTcyV0pqSTcvM0xsRmowcHAybWJmWGZo?=
 =?utf-8?B?V2ovWTNEZmJQK09rK2JrNGh4Sm1QM2t0VG5BdGMxazFBNDBUYmIvT243QjBT?=
 =?utf-8?B?ZjYzV25BSWNSTER1bkNobHordUhmYTFhQWhITlREZzJiRnd4eVBzNDU3VUpO?=
 =?utf-8?B?cnZPTTYwMDJHd3Y4dytqSTFNVHF2aVdBOUhNalhnVm1HZWRMcGhmbDhzMXRJ?=
 =?utf-8?B?WWljZXNZUStXMlg4bmZpK2FPYXkxY002NUNIc3l0cmhiRE9BZ1d6ZTBJN2ha?=
 =?utf-8?B?NkdETFJtS2VIUmRzaXlsL0ZLaFRLZEtJNkZvOGZ2ZTliTmdBOGc4YVdEN3lw?=
 =?utf-8?B?ZjdZbkh1UzZyMDRCbjNhWVc0NTFlTHhaMTFYZk5semc3blFVSG0zRm10OWVK?=
 =?utf-8?B?cHRIS29rWVRNTDIzblN0ZU84ajIwelBGem5VemZRclhuMDVoOVFPSERnajc1?=
 =?utf-8?B?WkRhNlhEc3RXbHVEN2RGSmsva2kwSXUrUnBodTl5MDVzSkpRaUpxM0VYdWsx?=
 =?utf-8?B?VlVhWUlWMmlKejR2M0FtVlViTm5HbzVUaklrRWgyRkhtSURTMVFlbTgzREdX?=
 =?utf-8?B?Qit0SjZsc0VkZXRhUytqQVJSM212ZHFhM1NJdkFNNWVYR0dIMXNubjJ2VzZT?=
 =?utf-8?B?ZVdYelpIM2lFODVIL013OVp2RHFlNEtsRzhLREYzb0JYZEpxYkw0MFp1eUFi?=
 =?utf-8?B?QnBLTnh6TWJFNGo0Sy9nR1huaThPZThpa0pFbnpSSGFORjFMbjZQNlFkeEpr?=
 =?utf-8?B?eHhqYWN6Z3Q2S2ZzWUpzYkRXdW9zM2RVTmpoSitmbEFQb1lhLzJ0OXJ1VUhS?=
 =?utf-8?B?ekRDMVcvRnZVckJVTlR2c3BicURPZnpxa1FtdGF2VHNFRTloa1F5MkdSY2dM?=
 =?utf-8?B?Yno0b2dteUo2Zk8wU0FBUlRzM1B0K2lHVU1DUEZqaDZrbnY5OW9zSThkRmVp?=
 =?utf-8?B?aG8veFEzWmVTU25nV1Q2NnliYjJ1ZDFqUHQ2M2VBU0lFSE1DcGpkUG5HUFl2?=
 =?utf-8?B?SENzRmZkWVAvN0gxODhJbkpoTHlvK2oreTdZNG9vdTk0OWM5aTFMSmUzRUxS?=
 =?utf-8?B?L2lkN251NGFQMkxnemhIZ2d3UDNoM1ArUmVpaXlaYkxjbC8vaE5reVpmM0dO?=
 =?utf-8?Q?Ja4NfopstMfj4/2InXIScE8pV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99745348F86CE540A1E90EDAA1C721C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0GIbJ0XYLxuzGFhsPsM0BdwvtO5poInrJLVj8T09vJgEHdVo/6FzSx8SaMwLQ9kmCZXitGkWs/LnMS9EtngC22aIIXjH0TnDaPGaE6mA/Y3RwtMI74p2+rDeh6HH8UtSRDrY1JRB/rxueKGY/HD7KkOA1pLQGuabS/+M3eqgDFdmfwjeHMxLfpHOWVfbO1BxiuFKyj5vYJaFeeksT5yPUKs3x0hGXhITS3LjQZbpasrWQv91vapYe72FcxMKyCKQcFlXbMwfr0vESsek08o7Ioro14HtmdIi/0uw5bMC+A+WkAzHRfeQ66RtvOOV+d+TyPXY142Ed1hKTU+g7wMljBPh+2AQj3VUuYOQac8RiVi6o0Bm4gFXTI7dzeZe7+MpB7db89QxL0oHErIX1+NBNGxf22p6JeaREDL/FjksIns/KptMZXr9NYaHHQmOjo10nE+p25PG6qd/7IPtNQzDeyyLqxAnhGnF3D17w2wh4gev8XMWXvbHfLbcFl3ONKDsRLE2/+h6HauZu1VUuzt0mmBV/7sBFOdAD8wD9wij63FaNpVwOuB0nXyP+Pd3Af+lHMtTrLeFc1Qh0A94yqY5Xx8JjT9XEf7SFgE1LE6c+p8PnQ5T5rxBpttObxXOHTztjHuTtN66souua3MU0i4qkA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23751736-3911-4e01-4e40-08dc8fde160e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 21:31:59.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yN9qeeGM+rzs1A08AI1Qf5NINwSsxN/pU1bnfRAmPiS3S6LDqlN35r0vUHHannwi8jhGt4FDC8tsir4hDO0Pvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
X-Proofpoint-ORIG-GUID: oC5p1OFa6L8PCmgh5WPFYRSdyeK1iWAY
X-Proofpoint-GUID: oC5p1OFa6L8PCmgh5WPFYRSdyeK1iWAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180159

T24gVHVlLCBKdW4gMTgsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IEZyb206IEpvcyBXYW5nIDxq
b3N3YW5nQGxlbm92by5jb20+DQo+IA0KPiBUaGlzIGlzIGEgd29ya2Fyb3VuZCBmb3IgU1RBUiA0
ODQ2MTMyLCB3aGljaCBvbmx5IGFmZmVjdHMNCj4gRFdDX3VzYjMxIHZlcnNpb24yLjAwYSBvcGVy
YXRpbmcgaW4gaG9zdCBtb2RlLg0KPiANCj4gVGhlcmUgaXMgYSBwcm9ibGVtIGluIERXQ191c2Iz
MSB2ZXJzaW9uIDIuMDBhIG9wZXJhdGluZw0KPiBpbiBob3N0IG1vZGUgdGhhdCB3b3VsZCBjYXVz
ZSBhIENTUiByZWFkIHRpbWVvdXQgV2hlbiBDU1INCj4gcmVhZCBjb2luY2lkZXMgd2l0aCBSQU0g
Q2xvY2sgR2F0aW5nIEVudHJ5LiBCeSBkaXNhYmxlDQo+IENsb2NrIEdhdGluZywgc2FjcmlmaWNp
bmcgcG93ZXIgY29uc3VtcHRpb24gZm9yIG5vcm1hbA0KPiBvcGVyYXRpb24uDQo+IA0KPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBKb3MgV2FuZyA8am9zd2Fu
Z0BsZW5vdm8uY29tPg0KPiAtLS0NCj4gdjQgLT4gdjU6IG5vIGNoYW5nZQ0KPiB2MyAtPiB2NDog
bW9kaWZ5IGNvbW1pdCBtZXNzYWdlLCBhZGQgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
djIgLT4gdjM6DQo+IC0gY29kZSByZWZhY3Rvcg0KPiAtIG1vZGlmeSBjb21tZW50LCBhZGQgU1RB
UiBudW1iZXIsIHdvcmthcm91bmQgYXBwbGllZCBpbiBob3N0IG1vZGUNCj4gLSBtb2RpZnkgY29t
bWl0IG1lc3NhZ2UsIGFkZCBTVEFSIG51bWJlciwgd29ya2Fyb3VuZCBhcHBsaWVkIGluIGhvc3Qg
bW9kZQ0KPiAtIG1vZGlmeSBBdXRob3IgSm9zIFdhbmcNCj4gdjEgLT4gdjI6IG5vIGNoYW5nZQ0K
PiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiBpbmRleCA3ZWU2MWE4OTUyMGIuLjJhM2FkYzgwZmUwZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gQEAgLTk1NywxMiArOTU3LDE2IEBAIHN0YXRpYyBib29sIGR3YzNfY29yZV9pc192YWxp
ZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2NvcmVfc2V0dXBf
Z2xvYmFsX2NvbnRyb2woc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gKwl1bnNpZ25lZCBpbnQg
cG93ZXJfb3B0Ow0KPiArCXVuc2lnbmVkIGludCBod19tb2RlOw0KPiAgCXUzMiByZWc7DQo+ICAN
Cj4gIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HQ1RMKTsNCj4gIAlyZWcgJj0g
fkRXQzNfR0NUTF9TQ0FMRURPV05fTUFTSzsNCj4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMw
X01PREUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0KPiArCXBvd2VyX29wdCA9IERXQzNfR0hX
UEFSQU1TMV9FTl9QV1JPUFQoZHdjLT5od3BhcmFtcy5od3BhcmFtczEpOw0KPiAgDQo+IC0Jc3dp
dGNoIChEV0MzX0dIV1BBUkFNUzFfRU5fUFdST1BUKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMxKSkg
ew0KPiArCXN3aXRjaCAocG93ZXJfb3B0KSB7DQo+ICAJY2FzZSBEV0MzX0dIV1BBUkFNUzFfRU5f
UFdST1BUX0NMSzoNCj4gIAkJLyoqDQo+ICAJCSAqIFdPUktBUk9VTkQ6IERXQzMgcmV2aXNpb25z
IGJldHdlZW4gMi4xMGEgYW5kIDIuNTBhIGhhdmUgYW4NCj4gQEAgLTk5NSw2ICs5OTksMjAgQEAg
c3RhdGljIHZvaWQgZHdjM19jb3JlX3NldHVwX2dsb2JhbF9jb250cm9sKHN0cnVjdCBkd2MzICpk
d2MpDQo+ICAJCWJyZWFrOw0KPiAgCX0NCj4gIA0KPiArCS8qDQo+ICsJICogVGhpcyBpcyBhIHdv
cmthcm91bmQgZm9yIFNUQVIjNDg0NjEzMiwgd2hpY2ggb25seSBhZmZlY3RzDQo+ICsJICogRFdD
X3VzYjMxIHZlcnNpb24yLjAwYSBvcGVyYXRpbmcgaW4gaG9zdCBtb2RlLg0KPiArCSAqDQo+ICsJ
ICogVGhlcmUgaXMgYSBwcm9ibGVtIGluIERXQ191c2IzMSB2ZXJzaW9uIDIuMDBhIG9wZXJhdGlu
Zw0KPiArCSAqIGluIGhvc3QgbW9kZSB0aGF0IHdvdWxkIGNhdXNlIGEgQ1NSIHJlYWQgdGltZW91
dCBXaGVuIENTUg0KPiArCSAqIHJlYWQgY29pbmNpZGVzIHdpdGggUkFNIENsb2NrIEdhdGluZyBF
bnRyeS4gQnkgZGlzYWJsZQ0KPiArCSAqIENsb2NrIEdhdGluZywgc2FjcmlmaWNpbmcgcG93ZXIg
Y29uc3VtcHRpb24gZm9yIG5vcm1hbA0KPiArCSAqIG9wZXJhdGlvbi4NCj4gKwkgKi8NCj4gKwlp
ZiAocG93ZXJfb3B0ICE9IERXQzNfR0hXUEFSQU1TMV9FTl9QV1JPUFRfTk8gJiYNCj4gKwkgICAg
aHdfbW9kZSAhPSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9HQURHRVQgJiYgRFdDM19WRVJfSVMoRFdD
MzEsIDIwMEEpKQ0KPiArCQlyZWcgfD0gRFdDM19HQ1RMX0RTQkxDTEtHVE5HOw0KPiArDQo+ICAJ
LyogY2hlY2sgaWYgY3VycmVudCBkd2MzIGlzIG9uIHNpbXVsYXRpb24gYm9hcmQgKi8NCj4gIAlp
ZiAoZHdjLT5od3BhcmFtcy5od3BhcmFtczYgJiBEV0MzX0dIV1BBUkFNUzZfRU5fRlBHQSkgew0K
PiAgCQlkZXZfaW5mbyhkd2MtPmRldiwgIlJ1bm5pbmcgd2l0aCBGUEdBIG9wdGltaXphdGlvbnNc
biIpOw0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpXaHkgYXJlIHRoZXJlIHR3byB2NSBwYXRjaGVz
PyBUaGlzIHdpbGwgY29uZnVzZSByZXZpZXdlcnMuIFBsZWFzZSBjcmVhdGUNCmEgbmV3IHZlcnNp
b24gb24gZXZlcnkgbmV3IHN1Ym1pc3Npb24gaG93ZXZlciBzbWFsbCB0aGUgY2hhbmdlIGlzLg0K
UGxlYXNlIHNlbmQgdjYuDQoNClRoYW5rcywNClRoaW5o

