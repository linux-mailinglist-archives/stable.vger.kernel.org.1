Return-Path: <stable+bounces-32445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78F88D6F8
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 08:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5123D2A476B
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B228DA5;
	Wed, 27 Mar 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f2i8RGML";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="idlw6ZUk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nNmiHHJ6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82971F606;
	Wed, 27 Mar 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523021; cv=fail; b=CtMb5ZIm/3FGpd6bODmk3k4Xzayf+YZ7X9sLkGtz6PXCroBIKZtL1zK9C4k8Ysyt/ciLtGrF9zppoatZVBWhNkEBy3BDvXNF6h/3TunX0yDq+P/3K2ZVDHCXMuvszpyGVByIddur0b11ianVRv3mto9ZLlUr8QsY8UcqJO3AsO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523021; c=relaxed/simple;
	bh=dGxr2r+mDfuY8Y5asf9MBS05Cjlq6gS6E3pFHlo9MoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oxNf8xsf49BfNGeJZVAUuz7UQPPjPBGKYjJem3KS09wkBRWPuIhFXykftHZ3lLW9/IpWZkdjwDEKetIHy3/tfONU2aXUABNdUlJy4AmHJafaykojN0B34GK7CJ3I+h9ca0gWJePW9QpV52cQVJOiIBnSNfbp8Q4nfZg8B50q350=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=f2i8RGML; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=idlw6ZUk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nNmiHHJ6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QNvjGV000894;
	Wed, 27 Mar 2024 00:03:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=dGxr2r+mDfuY8Y5asf9MBS05Cjlq6gS6E3pFHlo9MoE=; b=
	f2i8RGMLjl+wUpzZtcomo0GYMvBQjPWPzpep2f6oVPjUG7bR4M0p4hh/rgGRqQKL
	/FtjJAiV6uwsW7Lfvj73eOkr/o4MVQymubWw5gfIhQ76bJsPeDqX9vJoR8AHmIvV
	wx1jsYBgXOBxlw6jLC7C+52Xenn9nCqD6L2KnjUEWHbS/ketF3EOo2f5hgbr4Ilb
	uFBfCm1dtTUqlCgofIHNzvo45A5zhT4O9WE10GL9AFYjZM/PLofbpNu0TIS+Ou5K
	An4DpXbcHmtc8v6NrtV/VpMitI1ywKAmxNJoFVs6G1Zty6OtoSkIhiBOpqeHvqbH
	lIyyDCaoVGtKt5Ho9d4Ejw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3x3b6g4cn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1711523015; bh=dGxr2r+mDfuY8Y5asf9MBS05Cjlq6gS6E3pFHlo9MoE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=idlw6ZUkHkXvKvA6+Yf3zc1hf19h9E9O1oCEe+xI92MQ3NXJXwUYqVC0NnGlJqzFb
	 AEd2UQYqucyNxomgaX7SdjXaspILLjVJXYUIXMwnUV7QSjO8uwpGlHKiQQcrUp5cna
	 BjxaXLFhjnbzvR44CyuHm1rgqUCQ8cnrVCG8PtoXHszH0ZC0HXvN2O/ZuvqBWKCLHs
	 0flBzsxMFmW5E7TkSuLfcUj2FE9t9UESEMLsV1d4kNC3gH9hbasImlBkAYeuNkDaSz
	 uXNMiCWqL2S7iGPU0vmrAg1ZOqR7MaE2DH08+3XkZooWIMcoeZpiNmiBks2JcNEzr+
	 j/Imhf0Rn7eXg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2FD524044C;
	Wed, 27 Mar 2024 07:03:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DDF61A00B4;
	Wed, 27 Mar 2024 07:03:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nNmiHHJ6;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id EFF9740407;
	Wed, 27 Mar 2024 07:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKOnPwUGPt40yElMef1PLHhYYfPlT22vYzTrpVP+SD0Aq0DLCqfdj2cMmQE77KRmIMK0zApkdM7cbZgwu9dL8vlYwc6BB0Hna3n+Ans0gf5s/RHhXAP+M70BHHEsB4CCoy1SzgYox8Uuo44MCnX7zJ0nz+14QPEULmO/u8l6hAQr4mzJA95Y2C+7Z154ck40s4mnxG90EKtUIR+p7IWssZ0S5la08/HRQ3S61L1WVMjJpVNNHQbCEWbYh4pqRsFHM7FG2iccqD9Lf6uXlOiy2KPChCFiShF35U8lTX/9+368kw64DWn3Fcc7zebi10vO4J3D7hb88zRbw/BMfKKxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGxr2r+mDfuY8Y5asf9MBS05Cjlq6gS6E3pFHlo9MoE=;
 b=VKnsBY9afmPNSfKnGEc8FRQiDvaRp85igqPoHpu1DQ8YIZqDDs2gYg6F66nVslnglusJoxRADQGjvqwHEl0qDncTC1zVkyv3GWPClZbcQRqLBT46VWt8BTpCt2niwRydajCJSAChv8o+BNCu7Ryd+RsYiGfIDZozNwaqAdl4eFZzqexgipzx1Ok3VOGTd96WAveM0q/+F1B5ieoh3mZH5Vi3nt0zVlbL9lHNkQTrtZhMnImsKEAXpELpd1lVJPGR4F/FxaZkTLHwfOMUojs6sUK7zZK+k3WSARDtFW/Ys3MCkWZIEWACaOtqiXZIsmf0EFOwSqhBjEZw2Cs00es2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGxr2r+mDfuY8Y5asf9MBS05Cjlq6gS6E3pFHlo9MoE=;
 b=nNmiHHJ6JM8jxpjA18zCDVNitG/JDRqn7PseAngfdpynaNHrMGOxl8vCeFen3ZgSTB/AQZxi5ePJyo6bRru0JP2r8iSvCR8pQfIFEwaH/JNo7z91gq1OmXF2+UsNeY+AC16ZPDlrHXm7Y40UaQzkEzaPwLHxxkwsYvcBK2cjedk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 07:03:30 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 07:03:28 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc2: gadget: LPM flow fix
Thread-Topic: [PATCH v2] usb: dwc2: gadget: LPM flow fix
Thread-Index: AQHagBJ0uahD3pjlD0CC5zMYbqnQZ7FLJ5GAgAACBYA=
Date: Wed, 27 Mar 2024 07:03:28 +0000
Message-ID: <22953a98-8b2b-be45-9505-571f1042dcba@synopsys.com>
References: 
 <c263e2ce619774ec73765e33a1851a5910797940.1711520623.git.Minas.Harutyunyan@synopsys.com>
 <2024032737-monstrous-elastic-4c42@gregkh>
In-Reply-To: <2024032737-monstrous-elastic-4c42@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7533:EE_
x-ms-office365-filtering-correlation-id: e664cf00-1e6f-41c9-6c55-08dc4e2c0165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WsxxUG7+XuMlDZF/y7hu2V9SfeMakcvcAXzPvEgFdmyz4A/q6LZVR8Awr/sm2wduapae7N0AJ1bK7pgHmP9cyOyxnK/FEqA6GzENKCgM0mq+/i7w3GLhRwElzlxn22pOg/ak2bPdEGtOo7J4v8C/Gwcae5NNblBj5FcnU1rQ7zqty9IdI6OsUPPIQlrrBlcq9QsuE1AUNzuYi2Gxez5rD0Yj4CpCBqqxuJnu7ct5hhYWsoWh01DXQbPoVC89RQqkJtl1EXRrysVNaHIFDwQLVATzi+85AGd6hATDatweuAweJp56c9kpqAIlDvJxK7kE8ZOmX+ryRge/uqzGS9pQZMjGXEw/z/h6SQ364betLjoNNvcHJT++ziGqnQtQQKFZnttcmXpe65puq64SyI5C82HqDD9/RjkPVjYzkssLcYQ1LkoIeE87OfslR9qJQ6rHCRB705SCdcnkywh9l3ApDkMM/RbriES9q3cT9BL8XqC/yvY5Olsr+mEjC+E1BK7XTRFYQkO2O6W1LY5O7LRb+xhYRIT6C0OXBjPmdyEzpRCPRDDZZLAilNnZc6lS0DdaQnzulgVDsiK1le72AQn7/vhUlmCQRzIiCmgO/y6bmNdcwRG38dJzwOUtP66Fy17d2xo34S/F60R3wUUsHjL9C62y6elmOR+IEJCB9bTn6IuWRX4lkwLeIga9dKeReryVZfOn1iQ35GyJOUghmMvm2FozR5V86UOqHlCm1cbofXY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RExLdFM0QW9qdkw4WSt4ODFicU9DOGhKU0tvanBFZUlxdXR1MTNjbXpDNTlJ?=
 =?utf-8?B?Z21OQmg1OENHKzU4ZnY4ZkVML01Da1J3b2xScjNLMVRtcUxkYjAzdFZvaUpQ?=
 =?utf-8?B?S25OZ01WaEc4NUxRSWJXcUVnRG9RK3o0a0orYUdzRi9FVVl4cTZWdEd5bGZP?=
 =?utf-8?B?d2FHbVRLRExpUkNLM3J1SDR2UjNXQWVENzJBUlpGelIwTm93ckxiUFFYTkhy?=
 =?utf-8?B?U1J0aEMxODNhNHJrZkkxYTZTKzNEbyt2ZFFjNjA1eE5OZDdzR0gxSXNJVzZs?=
 =?utf-8?B?bU1kZU9KaGpYRThNNnNiTzBDR0tRMFlBN2tTVXR1aVRkVG9JNXIzMmh2WEdK?=
 =?utf-8?B?SjZJYnl5ZEwrbU5rUmpBa1ErVzlXa1ppdWZOSk5QTGJTTUhXL3BPVDRoa3h6?=
 =?utf-8?B?VVV4N05BT2gxYzV3aFhRSkROZG9zcFdmR0c4eDBHRTVSTzlKMTZHSnVqUkF5?=
 =?utf-8?B?a2N1OVEyZ3EybVU3WmVnS1c2TDB4VDI0SG9ObUdmdDFZbU4xdnJVOFlYQTln?=
 =?utf-8?B?SUQvSm9xZDEvWnIvU0p0M3U5M2lzcGd6bGhPN3pJY2twRHlBN1NESXhLZS81?=
 =?utf-8?B?eEVuWVFKK0Q0QVRGWHUwNHlTMUltMWEzVlArMm5EWE5kcWRUNmJyeVE4ZG15?=
 =?utf-8?B?U3FMT0RTWWN6bkhCSHFHVUI4c3oyODh1dzJ1cE93aTN1MjRXdUZsS1h6VkVI?=
 =?utf-8?B?ZXE0cHI2YjU2M2hXUGp6TDBQbFZaeDhFQk1GTXBCTnBhWFlxZlBReXY5MUdX?=
 =?utf-8?B?Sko2RzVrRzlXSW9oN1F1YWNoalk5RTFhcGt0VExqUHJ2ejBobmFmNHpZd2ZP?=
 =?utf-8?B?ZnVoNUoyTVhuMHpYL2c1UjRXZWtDVGxoT3U5MkptRTJnRExLaWdNSU10bHo3?=
 =?utf-8?B?dWFyQWJLNzIvUkJIUXpPa3luSnpINkRaTW5udVQ4cEI1eElyK3M0cW5wSDlP?=
 =?utf-8?B?QmQvNy9mWHB6WU9TUmRPRDBmRXJRVFVoeUhLcW9rQU1waU5ZWFY5bS9WRVQ3?=
 =?utf-8?B?bHdtVTJDTjJZOFVCMG96emhERFJFWTN0OHljQnhja3dtMGdZY3lGQnFlS2Za?=
 =?utf-8?B?T2YwMVVJeHREOEtvU2xQb0hrK2l2ZTFKSEYxbnpiVlBsTXNUcXJVNW5YZDVr?=
 =?utf-8?B?Y1N5Q3MxNGE1UHNlNmpMbkRQTElFd0dJMm0xNVFFODFJclJYWVlUWDVJaGtt?=
 =?utf-8?B?U3pWaUNhd25ycTBzU2dBM2ZNMUJuVTZVRnptcERrekVsT1JIYUFQbWM5R0tO?=
 =?utf-8?B?VnlIY0EyYzF0Q0dFME9Yc1R5VDk0MXlkeENONjNaQ0dObVAzOE03WlZpUmdh?=
 =?utf-8?B?R1hwZWhUTzFEV3RNc2FPa0VGbGNpMlJ1cnN1NVcyQThQdTlxay9TYnltTUk2?=
 =?utf-8?B?ZjhUWjdDc3I4WHVqd0s4QWZRWVQweFZOdlZRZkhuc1JKMGZKdnFyTUNrbnRz?=
 =?utf-8?B?by9tSktmWmNOR25UZVRoUmE3K0JpLzlGQUNMbWFPTE9hZ3NHcm1Eamh4aUQy?=
 =?utf-8?B?Z3dldjNyWEszMmJ6bnRHeG5tS0RJYjU3UDJxTVI3ZTNCWVBhY2JjcDhEc05n?=
 =?utf-8?B?WXJoN0czZnBYRFZqZWN4SGtXaEJjNGNVRDljU3ZYMUoweEdjRzJQSUFjTlRr?=
 =?utf-8?B?QjZreGozekJwZWxUOEFpQ2IyRFg5T3Q5RFFCSWpnU1Z6OTh1Yk9NMkpWdzFk?=
 =?utf-8?B?Ni9OSVJyckpCMVJINnVCWmVJVVBwelZHUktmV0dFTHUxY1k4dWk2bGV2eGdw?=
 =?utf-8?B?ckxHVW0xVloxQXR4QWRUYlJxQjZqdjJaYzRqRFRPQVQrakZ6T1dwTFYraVZa?=
 =?utf-8?B?enJiUzFoUkJqNEd5YW1yTU5yMUszdEMxaFl5dlJ6L25GamltdlV3WmRGY3VQ?=
 =?utf-8?B?aWFwc1Z5VVZwcjExeklOOG5oOVJ6L1h6ODFMemZwRzNDK29ibjN0aSs5TnNu?=
 =?utf-8?B?U0hOckxNMVpNYkdTOGFiZDVzR0ZxcU9PVnJPRGZlTENOSE1hdHpuZm4yQ01K?=
 =?utf-8?B?SVR3YitzTWRyclZrZ2o3eE5IK0tnZTVRVU5wL2pLbm9wRlB2MGJZMGlMeUNW?=
 =?utf-8?B?UU5CTkkxdk5Da0xicjNkK1ZOekszWDJ1bU5LMnNMWWFYOHRYVGhuZlFQZUpH?=
 =?utf-8?Q?Q8qPxbKZ38fDyP6QuW/6XSFgr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A86727C67C194D8A2B4399C2C5B29E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	clvRDE8sdjOYoF1kROtQ0wuslb8fnFUJ7qnrhf5IPV9CWPy1xNOp+de8wVuYnMBLIdqjLFz9OvD21iTfVf/NaPKbIY1I4AHzKak/v4tUKu6nHhd5MGLO7UYrTBxJGilP5fY+GH8ad2vS/hvBb8vwg96a7uvPtL+AjA1fsHp1CGB3dCRose64yMASRvVKS8HufUeeeHZZbJoY4MB5IZdTvHAx8ROlMnRgc5WVEqsDWiD4f9YeO+4qbvP3DwSwyKJCbsRDRxWOVoH4KNu1dGAx9Q7ZV9V/rySAaD/rTBWWwZgZAzzKh7M1R/FHJHya/sZMwxUj+3HtNkfHcl0+WTRbRo1ZnC4fuxJ5X3hqiQW0xkMyKDqrpN07z11WbixgcIy/cnrDibphiBhZnaH3Xn2RTLcRV/J1IdQefTJJDXXi493p2BKIj/ioLsT5Z1aVF3j+tFcHIcn78E+t33fQukxQc/Q/d+5YaxAOzNC61WMYGGCYmAhg1+8b6ASLnjZStW38RfpQGLGYhHv8t7JUzlJt8/26/5zi1jdwl0rGG/imANfI4uTgAlN6usLx7oFyuBym5lM9f4hoyDg/ygZJbfnvsVudJX8eBF1ujGFtDqLQrvFe3dtNHomOUxXymt+8jdtZz0kOq9DnBqslcMrJSDr/BA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e664cf00-1e6f-41c9-6c55-08dc4e2c0165
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 07:03:28.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sBpCBiCn2fYJZt89uyJUL07tmMkXQ4jIHSi4tYDyi2rBhlItvi7PFJ2JYRNyktY9yQ7Hjn5o5UAKrPF2yoKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
X-Proofpoint-GUID: ktgNDVWKXynqONDtDY0aqEWgWPbZIiqe
X-Proofpoint-ORIG-GUID: ktgNDVWKXynqONDtDY0aqEWgWPbZIiqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxlogscore=824 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403270046

SGkgR3JlZywNCg0KT24gMy8yNy8yNCAxMDo1NiwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0K
PiBPbiBXZWQsIE1hciAyNywgMjAyNCBhdCAwNjo0NjoxMUFNICswMDAwLCBNaW5hcyBIYXJ1dHl1
bnlhbiB3cm90ZToNCj4+IEFkZGVkIGZ1bmN0aW9uYWxpdHkgdG8gZXhpdCBmcm9tIEwxIHN0YXRl
IGJ5IGRldmljZSBpbml0aWF0aW9uDQo+PiB1c2luZyByZW1vdGUgd2FrZXVwIHNpZ25hbGluZywg
aW4gY2FzZSB3aGVuIGZ1bmN0aW9uIGRyaXZlciBxdWV1aW5nDQo+PiByZXF1ZXN0IHdoaWxlIGNv
cmUgaW4gTDEgc3RhdGUuDQo+Pg0KPj4gRml4ZXM6IDI3M2Q1NzZjNGQ0MSAoInVzYjogZHdjMjog
Z2FkZ2V0OiBBZGQgZnVuY3Rpb25hbGl0eSB0byBleGl0IGZyb20gTFBNIEwxIHN0YXRlIikNCj4+
IEZpeGVzOiA4OGIwMmYyY2IxZTEgKCJ1c2I6IGR3YzI6IEFkZCBjb3JlIHN0YXRlIGNoZWNraW5n
IikNCj4+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBNaW5h
cyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KPj4gLS0tDQo+
PiAgIENoYW5nZXMgaW4gdjI6DQo+PiAgIC0gYWRkZWQgInJlbW90ZXdha2V1cCIgcGFyYW1ldGVy
IGRlc2NyaXB0aW9uDQo+IA0KPiBJJ3ZlIGFscmVhZHkgYXBwbGllZCBwYXRjaCB2MSwgc28gSSBj
YW4ndCBhcHBseSB0aGlzIGFzIGl0IHdpbGwgbm90DQo+IHdvcmsuICBDYW4geW91IGp1c3QgcHJv
dmlkZSB0aGUgZml4dXAgcGF0Y2gsIGFuZCBnaXZlIHByb3BlciBjcmVkaXQgdG8NCj4gdGhlIHJl
cG9ydGVyIGZvciBpdCBhbmQgSSBjYW4gdGFrZSB0aGF0Lg0KPiANCj4gdGhhbmtzLA0KPiANCj4g
Z3JlZyBrLWgNCkxldHMgaWdub3JlIHYyIC0gbm90aGluZyBpbXBvcnRhbnQuDQoNClRoYW5rcywN
Ck1pbmFz

