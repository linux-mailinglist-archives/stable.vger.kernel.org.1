Return-Path: <stable+bounces-195216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9CFC71C17
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 03:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 269364E3575
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5A26FA77;
	Thu, 20 Nov 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a8WEQb1Z";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DKGQellJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DoA6u7Zj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8326ED4E;
	Thu, 20 Nov 2025 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604474; cv=fail; b=CVd1AC/1me9wzcQ4hLyHV0P/Hw+QndISWh3wV3Ovk6UHv57iB/SQcRir3D8khz8lOKy/cRGw/iIEl/trPOw1OnIvLkGi8SAoS7xA6Fxuw+lg9iMxsSXVXx081nAfOmqhFfNGfIycCLmX7JRZ6G7a5rwspLwkTAF67wg1dz43lI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604474; c=relaxed/simple;
	bh=4AWJC4CiQ25e4Fn1ACyYXZbXjH0m8kBGoc25uwOh0cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=poxxnqN4GfGh5F9H5mdl+DC54lfq1I0syecJrAAPdlCPeoZIkUbee+bxFz+QxY9cBsWDedr1Y6I8fHy3Gx83W5S3UyRmIQQEWrNMtlBn9JiikNlI8DToUze3l7InNVAbAvXpO0wL53rvPyPA3xha4CdKOUtW4A4cs6/W9uoHF0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=a8WEQb1Z; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DKGQellJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DoA6u7Zj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJNbxaI532914;
	Wed, 19 Nov 2025 18:07:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=4AWJC4CiQ25e4Fn1ACyYXZbXjH0m8kBGoc25uwOh0cY=; b=
	a8WEQb1Zqc8uiNxpEq19mc4TxzuMvnURU+elcNi24ofCRJF/0aLrMHhmIp8kU1i0
	DklB44eL+kdYVFJMCd1BBzY0KvbshXHGbUjJ+3xCRkVioKlakkzDfrkooHUgcWle
	pQqgar26L+hPZtKE/noylNeMsQzYbrwgs/hzWPiPIkQA6ugkhWCU5E1C03EX4WOu
	Mpa1xrrJtuvgCHwJhNVUPQDsBUaLRGYKfgTKdFekYQyRPF90JOPbCOe8TiHtXK5C
	oYHUu1Ugib9s3e/adPB9KRBUDNKCRny9JbvyvjNX1ljpY4Z0Q1ITM7azyrXnOHwT
	vDYLNxOESDb14arNnLGpWw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4ahj8va7nr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 18:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1763604459; bh=4AWJC4CiQ25e4Fn1ACyYXZbXjH0m8kBGoc25uwOh0cY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DKGQellJVFLD2hLJxV4pwggTLP8St04IJgKfDWWvE35BbDwi3S7dXv090xWTyOncG
	 r8H/mRGpKMhENAHleP+gTtXGtOyKf0wx+zG8GnmCTWzITaWdVTl8bbmIKg/hbNQkCI
	 vpeDW9qG//5zOM2N9/tRstvW8XAhezJbW0J1KGSwuMTR2umpO5lUkhPA5AKTaLMEzN
	 6My5FjPMDlGuxGUF4BPjnagtfZTcMNj45d97pOt5jBUwJdXSWpy9kHKfMo75WiX8Bu
	 cud/rj/adm+A/Vcyth2AE3xyBpj4jgO+1NHKS7VKdPwSjdUkO/iqtP2loiH9dW+/z9
	 9KWsEk0dB9rSw==
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E0108404EF;
	Thu, 20 Nov 2025 02:07:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6F32CA0275;
	Thu, 20 Nov 2025 02:07:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DoA6u7Zj;
	dkim-atps=neutral
Received: from BL2PR08CU001.outbound.protection.outlook.com (mail-bl2pr08cu00100.outbound.protection.outlook.com [40.93.4.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D15D940AE3;
	Thu, 20 Nov 2025 02:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2PAMZ+2r7E4N8+G6Ywf+aA3JCGzLgAKanAfw8ObSZAZtQOd93U3kZMZBHHNqLm21G648wg3/TYHSgeAHOFvNbChzVVu9MKnRSK3yWd70w421pGBznAXkmdePlhCJWvz4S7J6ySPkhD+UIA2grX/dVXxqWgSMVe8jlums0/gJesCE+0Ku05qNc6h00MJ8f7qfWyBdC1uZiYwB8QTKQQN2xyu8TjcioGim8CTL8zk24/YO9usJZhfJXFRSuvf8FvwlhOgcRQhMbIIemQOr0ZftntRHKfQ5h1/gyrVakFU6pvY5kBCN/BQDpSBBjVFv4yI5SbgdqDeDBVT2I1lru3gvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AWJC4CiQ25e4Fn1ACyYXZbXjH0m8kBGoc25uwOh0cY=;
 b=uJf5St+P4D+1/zRkEzozLt/7cpemzPkuwB38zcZgTSWN9az9ozlmHAj3BhEHDcckgkUwVfAeeb9SAR6a2ZPQHqkVQxS5n+GjYhTiCklE7XOFHvkbd/eokFB1Ve69ph1W+5oW+2O1kJNDmtEdxpSVmvwy2wJN/ZQ8dIo9L6+9bSBV63nSJ+5m1eFqmqodTi7+CZAheTHSOph0VPxEN4u7IT7l0tzPUrhaohudQ93pgK8eURvVZQ0UZVtk3nPS+Lkqq27vYexgjDsz4LyGcJ6Lorv87h+GaVHsa5iMsuKgVgtzyeWEA9IPT7koKm4HVlrfwdiE5lu2q8RJ1Gj3khrP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AWJC4CiQ25e4Fn1ACyYXZbXjH0m8kBGoc25uwOh0cY=;
 b=DoA6u7Zj1yPtV/+UL/1xXsAmsX+OjOyfhTl42DhxaOHdU7A2IQmDKBRs0e1hW2WzLVUNBds8BTUYRxnyLAnKXHiyCceO+GY1yCYXYDUcr0k/DBaD42VwL3eW1nOv2jdKEnS/VBhnMWSTydBzk6fIEVVUZE6jxNeXN1j3bejV/GE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 20 Nov
 2025 02:07:34 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 02:07:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index: AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYA=
Date: Thu, 20 Nov 2025 02:07:33 +0000
Message-ID: <20251120020729.k6etudqwotodnnwp@synopsys.com>
References:
 <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
 <20251119014858.5phpkofkveb2q2at@synopsys.com>
 <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
In-Reply-To: <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7369:EE_
x-ms-office365-filtering-correlation-id: 1abb8836-e1dc-4a6c-030a-08de27d991bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3JNVEZ1M1pqaWZmWk9vYk00cjZrRmFoQTNTaVRldkE0Q25XOEJKM2R0bXdZ?=
 =?utf-8?B?N2NkYS9qdmJnaFRyQk53TEZSNUF6K1k4WngxWGVXb0JTeU9lSkNSaURpbG1w?=
 =?utf-8?B?Z0dGSmZnTm1QV3ZtN21CckxkUFBmWXloNHU1MXBTekVjU29nekI1ZWovN0h0?=
 =?utf-8?B?UkFiWklMdjdDWkJIMXk0Q2NzTmhUdW0yanJzUzRZcWRuVGNiQTVnSEVsWWsr?=
 =?utf-8?B?N3dyaWVRT2NtSlpmK0J6TThtVTJkUWVJd2pCcWFxK1YzMHBrd29hOTNkQUZw?=
 =?utf-8?B?VVU0c1hmb1M1STBVVXF6b3FXRkZZVWVRMkVGMllpOWY5bXBwR2pPdC95eWZD?=
 =?utf-8?B?WVJJS3VQM1BTbTRzRDN3dThzN3FhSUpta2xGajdNUStJemZkQmEwQ1Z3V1FO?=
 =?utf-8?B?enpZM2hnNWM2VEpiOGxaVEczRGlvdUVQQktDOVpzZWpWdjlKS2dMYUpTQlk5?=
 =?utf-8?B?YzU5WlRZQnBGdVBBUldvTHkvT1czamJqUEVobEFpSitLNzVScC9ONVBONksv?=
 =?utf-8?B?bTlrZmZ5alZMcXFKRTZ1M2VTbGxNTXEzbkFrMzZiYStydFlNTnVqcXJzai9F?=
 =?utf-8?B?SDk2bExiSTdvVmdKTFVmOTE1aDk2ZURUNVNxQkNhbWFzS1dVMU5jUWN6RTV4?=
 =?utf-8?B?TkZLbVpJby9DeGVXcjFNRms1SE9FaEgwK1ZOVlcwVGtmU3BEOEdVYkpaUFhZ?=
 =?utf-8?B?N3dXU2lDNC9adlBsVmlLV3U5OFpZR3dSaXZRRjNhMWwyQTBIZlpjTThZQXMv?=
 =?utf-8?B?dFkvZVhqcFVDWi84alVhTzRlUGtudFU0RWVNWmxMNnplUGQwV08ydVFPUDhn?=
 =?utf-8?B?cnZweCtHQVlvNjJZd0ptV3ZjVEpwTlNwSU80QWFQa1pRN1JCaUNHeURObGhy?=
 =?utf-8?B?VURxOWN0dk4yVzZpR0NLR1Q4SjNBNUN6SHRFYnYrdEpYQ3dvZ1AwMHN0MG92?=
 =?utf-8?B?cVh3UDBtQnJoSitWampmdG9WOGs1SFNwMmdOTU9sb0NoL3dSZmNyckdrQnNV?=
 =?utf-8?B?UVJzUHFLcmpsM29jbjBYNmU1bndjcVBsYWVjOHE0c1gzTG9VMDY5TUVCeWxB?=
 =?utf-8?B?ZlV6cndzNGUvdWZCNkZRK1E5bU9vMng3VCt6TjlLajZIbExHOXhMUlJOUndR?=
 =?utf-8?B?YlNnSEpZb0I0OTFIQ1ZlYmp3cEpZbHUvYkM2UDcraE1HZytUWGxGU2RWSS9Q?=
 =?utf-8?B?WnhPaGlsL0VpMWZrcUpqZm42WmlpQW5wa0s1VWYxVDU0eWJtN01VcnVHV3Fy?=
 =?utf-8?B?dWtRRWpONVl3RUFkNE1VWU5yNENtQjlIZzhIZ29EenZBZ29scVEwSHZuYnNa?=
 =?utf-8?B?N2tBRWtMM1o1TzdXMGRxb0hkQ3F5VjFsZE5GQVRTZDBURWlKUko4dUNCbThr?=
 =?utf-8?B?V05QRFBqa2ZWTGhIcXdNbGEyOXdDa1RlSm1qYklxRkN4Vms2bnRQbjIzT29Z?=
 =?utf-8?B?SzNzZWNiMmU5TWt1WGJMWU0rd1ZZcFBPWXk4U2ZiNjc2RzhIMVBqUHdoZDE2?=
 =?utf-8?B?SG13TFBuejlONFZESlZKMUhMMHhKUVhiZmxuank5cThiUzR5U1pwVzdEMEVO?=
 =?utf-8?B?aXRvMW1SbXova3YraVl4VERiM0pOSE5SRXpNZnNEQldzd3JQeXhWMTNneHYz?=
 =?utf-8?B?WXhkV1p6WXpoR2xjQ1IrSVkrckZ4SzBPM0NyVjdOTjROanBLalFjN2NGNTlK?=
 =?utf-8?B?VGVtUlIvaDdTOVlXTldESWhLbVNPUGhubmQycm5oaFl3SmtIWFQvQkN4Qi8r?=
 =?utf-8?B?SUc0ZURUWng4SlhmZm9TV0xsK25tYzNZaTA4ZjNRTjNDN2xRMUZnSzNta2Nx?=
 =?utf-8?B?dklHa2hFZ29PY1AyamhpUStaQ0tacHhUNm5qdDVXY0ZvR2tzZlNZaVd4Qllv?=
 =?utf-8?B?SFo0SjBaa0NTSjNzMlA5b1J5NkVUcWRUQzBQMmE1aXMzYnBXRzNsdy8rYWV1?=
 =?utf-8?B?dmhtYll2WGk2MjMzNTVVcEl0MXJzMy9aSWxlLzgwaVpEdWJERXRIeUZCTElF?=
 =?utf-8?B?Ull4NTZOcTdUc0hvWnJEUlpCMXB3dVFNSGRwTGg4ajVVbFEzSkQxQWIxZmdk?=
 =?utf-8?Q?gTFpV5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1U1eGtyUXZOQ2dtR3NhNXBIdm1KWXlvQWl4bFRsUG9YL2ZjYzJ2c3pMR0Z4?=
 =?utf-8?B?cW5DWWQxQzZBYmhZa1B3RG1IT21DNlMzVzFiZ2M5L21oalJJUnZFYUV3RTZn?=
 =?utf-8?B?MEJVKzlMczRNdksrNWg4Nkp2ZFhQN0lPRFFmZ3BsTlIyQzh5T2lFR0poN1Jj?=
 =?utf-8?B?M29sNXgwK1h5dlVNUDFFVGkwbHMwUWFRaTJuU2hHUU1Kb2RDMEZ4REJCUGxO?=
 =?utf-8?B?emZXV2ZmNUdkcWo4Z2FPZmxWZGZldWtOelduTWlkSUtxL3c0MkFDM05ZbmtN?=
 =?utf-8?B?Y3lWNzNmNk8zaHY0T2lMaFQyNUo3aGZjUFJVaUNYUXZ4dStRZHpBa0l3R1Rr?=
 =?utf-8?B?MXplQkc2bGo2ZDFyWXRsYmpocWtDV3gzT0paTXltWWZXek9ER3dVV29zZFNr?=
 =?utf-8?B?MEdUNmlTUS9UL3hNSklWbEl6elRyRjZKdDZLbHNla2RWUTZNRmJXcm5OZHFR?=
 =?utf-8?B?M1g1aUpQUlIxN29RWGxTbmZhU1dMdDNYbnRjZTg3Q2E2RUtBNnR3ekZZRXJn?=
 =?utf-8?B?UlNpclF4Qk02Zzc1d1hPRFJnYTBpbWJ2T0c1dCtXUW5nYWlUUm11U3BIYjdT?=
 =?utf-8?B?MHhraGxxeWs2K1k2QUpkM0RRbUI5MXdsOHJMcjlJcEtsblIveitSVlBkSUNH?=
 =?utf-8?B?MEdqTVdsU0xJbmFLNStoSElCZDhneUt3Z3pxS21rNEVQN1dKQ1VFZ2VKdDR1?=
 =?utf-8?B?c0d4a0xjM1lOa3lFdFJJUUV1a1VzUXRZSkRaem8xdURIV0JwYThRL0hodnFC?=
 =?utf-8?B?RjlxbDJFM3BNam9YYTd4RnErVkxBN29sRWlEMmp1akVwWTZVSTI0M0lxV2pu?=
 =?utf-8?B?ZGUwQm45ZjNPMkFQNVljZHhEaFRta0hiRUNyNk5pUVQ1cE8wUEwwZndIT3B3?=
 =?utf-8?B?RnlPZDg1MGlndkNlbHk1YkE3dS9lR3lqTlVKZEFxd3JFMXRTcXFYTVlxaUxK?=
 =?utf-8?B?MFFNK1Z4b0xmVmMveitMRDhkaDZSSEkwdlN6eENORWkrdDN1MEEwYU05SlRN?=
 =?utf-8?B?SUI5TVdHUmJSYThkMzloUXY2SUpxMGFuSW56dDAvNUoxY1h3VEQ0M0w5VTNS?=
 =?utf-8?B?eXQrY0VZRjA2SW9SRktodXNxNzRiVjV3cmxOcWJtMXdaN0hYYW5ZS3pxWEJ6?=
 =?utf-8?B?WU1YNTlKdXUycEpqQVlURjdYc212TjliOTE5ZmcvcDNFYnRuRTJ5WXhFVmpz?=
 =?utf-8?B?M212QU92b1lzeitTUlp1VkFTTVZ1UThiYXlCUllJaW53aFBhcXdSQWs3eXVS?=
 =?utf-8?B?WDlwbmExN3VmaUV6S2ZmbEVYdUxheFlIMTJoNFVZdnNjUTlRRDRndXFUMGhZ?=
 =?utf-8?B?MnhpaHlSVkx4Z1l3Mk9EbE02NlZrN01hODhubFNYcFdBV1VsQU5qeEo0c21o?=
 =?utf-8?B?clV1R2E5alloRW03TWMyNXRKV1J0U1RCemZGT0NOZGY1WlV5cnFRdTNHQld4?=
 =?utf-8?B?VFgvUExoTXBoa0ZaMWF2R0Vod1AvNU8yYldRY2xDNGtOcGhleTRiRjZoTXZM?=
 =?utf-8?B?RlBRQmFXUW85eXFaMHR6RHQ4eU1WUHl6M1didVJpcktsNHc1U3JmSlJNSmJF?=
 =?utf-8?B?WmhiZnp0NXV3bU1BZmgxSGpBcStSWkNqZ3poWFF6OStBSjFiTGNJMjRNRGVh?=
 =?utf-8?B?T0RmdWlLWlAxRndUb1QyaUNQbDNSN3JralBqMHN3VlV6cFdrZm1iaUdmekF4?=
 =?utf-8?B?RlptVFZBcnc5NUdINTVNVWNONkdrRzRqSWRENkg4K3JNT3YyS0cwSjhjZ0Np?=
 =?utf-8?B?S0N1SFpiMmdlSUY3Y0U4akdKUGVwNGlWVnBpUEtBQkthbE1MWWZZS2czTVh3?=
 =?utf-8?B?WmhoY3ZuYkpMdDBraEs4YWJkNVFiYWRHVi9aN01rSGkrc0ZZMk55MXk0Rjk4?=
 =?utf-8?B?N2hHRzRrRFRDbEJ5Wk9xQ1c2czVseVZobzVwcU1GdDN4NWFQM1JVMmI0dU5k?=
 =?utf-8?B?ZGh4cm94V2pObWgvVXY0azYydFRRd2hQaDFHQ256MUdNOGRpSXlPWThsL1ps?=
 =?utf-8?B?bE4zVm93U1dxZUZKL3NQTUgxYmNVRytVSnhsR3FVZ1ZEWitCdmZETnRaRVRm?=
 =?utf-8?B?MXEzVWFVNkFYenJDdXZzaExWenppVC9NRlZCTHRlNEVlQWZHZFJSVXcvbktp?=
 =?utf-8?B?WThVcjA5d3ZXL1JDOUxBZ2NON1ZnMFEyYjlaSFJHa3lmNTJ5aGp1VmRPMThn?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7A450F7DB25864988542CE830BA1672@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pfhmhpGFYGMX2MC8CGbF7TB07XnNSlIXgeiquilOgTxuD+WTdlQXghJdpAGvNqjedA94KE6euEBhVF1MdKqPBRHCSfUaIS85G78UlJyKNn9pJNCjKGBhBFx3qU5BKt+3KsHDhdRDfNYLW7qj0+YAwqCR0VvowtKDKWIJCfyAdSSZlhqcU+f+psSjAk8dVj7ZlPufOsLLVVSAYYYJ0aHbAp/WTrs+9v4Dijo5c4R/ooVygcXvgYTPzffo7EIK+lfKFQIKwtWOIgY98cxSZYrbqld+9A/27V3K5WWFfCfGihvDqDcED0u/HP2lcHXA3MKJMTMocFH2OOC2PCoSwO4XYuJm3EVA6Na3P82MqUK45goFSwx90fXmyVeNnK/gvLlLguSKCrugWMiQ8RasQ3r06h5rbDUdO9HC99V3djIK5uPP4Emp2TWfvW84alS8Y+SNER8cTOz94UFoCNHol6D2iK0nO0QL5t5bPq7MwzgAApJ1TW04a8Bkh9QuIyqOkEu87J8aoxN/SRO9+zoMkAnUGU6thcUSgcdEFtG3bCRdBxlmJBhCjOvQhIrMQhxIWry9As23+QevaWnk0xOaEDCYSJ+7oR9HfPePSdTpvkpMUzjGyhW99kMar3QI55cyDByoec7lBtRk0SEYfkHrNx2+WA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abb8836-e1dc-4a6c-030a-08de27d991bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 02:07:33.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pycbFfhWMM8/YCWsk1PoCQJ/HdlR6FrCnU694WO3tv6zqh/1ZMNbfPII5Xzy0fvsP7glhEENheNbE6tB60FTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
X-Proofpoint-GUID: nHD02QRwDZBxfe0Ks8accrkmUHXAsh4O
X-Proofpoint-ORIG-GUID: nHD02QRwDZBxfe0Ks8accrkmUHXAsh4O
X-Authority-Analysis: v=2.4 cv=R+4O2NRX c=1 sm=1 tr=0 ts=691e77ec cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Hcp2Y9Rg-lfGKPOTgAoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAxMSBTYWx0ZWRfX9ydp2iaJwOCJ
 OABbv3NddDVql3FlipoE9t/cctpUaV3/jIiV2AtFte32PO9dqs4VYaWO45nLB9SqUs4ZehqlWP7
 yh/ngesfKSSzya48qvHcbDFl9ZCX2Tu2hoZmGNVRcenhu05S56RTWgOnhabtKBIjHgkXN3KvD6H
 jWMfWBj1OCRhpe+7jxhdm/VoLgP9DwqXb8/ADHZwWWvQkx2f7jAhaR7DcKTt1AZy4rILGimcWnE
 CzDubB71t6YbE62XPsDmlUSwfhDbtsBUb3RyjOltuzeIhIUdboyNVhAzHE9vVXJb0rNXjymL4Ke
 PS0ZvJMUlOp5v+6GUmmCPQQO9+d1nM/YJqpKSQb77Yz7oDmhf9OGyZfNLwWg+kybpfB8HsP4Ohb
 9xfk8hjoe8RRXLAfly2jeFfVUe0kDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511200011

T24gVHVlLCBOb3YgMTgsIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgTm92IDE5
LCAyMDI1IGF0IDAxOjQ5OjEyQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBN
b24sIE5vdiAxNywgMjAyNSwgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+ID4gSGkgQWxhbiwNCj4g
PiA+ID4gDQo+ID4gPiA+IENhbiB5b3UgaGVscCBnaXZlIHlvdXIgb3BpbmlvbiBvbiB0aGlzPw0K
PiA+ID4gDQo+ID4gPiBXZWxsLCBJIHRoaW5rIHRoZSBjaGFuZ2UgdG8gdGhlIEFQSSB3YXMgbWFk
ZSBiZWNhdXNlIGRyaXZlcnMgX3dlcmVfIA0KPiA+ID4gY2FsbGluZyB0aGVzZSByb3V0aW5lcyBp
biBpbnRlcnJ1cHQgY29udGV4dC4gIFRoYXQncyB3aGF0IHRoZSBjb21taXQncyANCj4gPiA+IGRl
c2NyaXB0aW9uIHNheXMsIGFueXdheS4NCj4gPiA+IA0KPiA+ID4gT25lIHdheSBvdXQgb2YgdGhl
IHByb2JsZW0gd291bGQgYmUgdG8gY2hhbmdlIHRoZSBrZXJuZWxkb2MgZm9yIA0KPiA+ID4gdXNi
X2VwX2Rpc2FibGUoKS4gIEluc3RlYWQgb2Ygc2F5aW5nIHRoYXQgcGVuZGluZyByZXF1ZXN0cyB3
aWxsIGNvbXBsZXRlIA0KPiA+ID4gYmVmb3JlIHRoZSBhbGwgcmV0dXJucywgc2F5IHRoYXQgdGhl
IHRoZSByZXF1ZXN0cyB3aWxsIGJlIG1hcmtlZCBmb3IgDQo+ID4gPiBjYW5jZWxsYXRpb24gKHdp
dGggLUVTSFVURE9XTikgYmVmb3JlIHRoZSBjYWxsIHJldHVybnMsIGJ1dCB0aGUgYWN0dWFsIA0K
PiA+ID4gY29tcGxldGlvbnMgbWlnaHQgaGFwcGVuIGFzeW5jaHJvbm91c2x5IGxhdGVyIG9uLg0K
PiA+IA0KPiA+IFRoZSBidXJkZW4gb2Ygc3luY2hyb25pemF0aW9uIHdvdWxkIGJlIHNoaWZ0ZWQg
dG8gdGhlIGdhZGdldCBkcml2ZXJzLg0KPiA+IFRoZSBwcm9ibGVtIHdpdGggdGhpcyBpcyB0aGF0
IGdhZGdldCBkcml2ZXJzIG1heSBtb2RpZnkgdGhlIHJlcXVlc3RzDQo+ID4gYWZ0ZXIgdXNiX2Vw
X2Rpc2FibGUoKSB3aGVuIGl0IHNob3VsZCBub3QgKGUuZy4gdGhlIGNvbnRyb2xsZXIgbWF5IHN0
aWxsDQo+ID4gYmUgcHJvY2Vzc2luZyB0aGUgYnVmZmVyKS4gQWxzbywgZ2FkZ2V0IGRyaXZlcnMg
c2hvdWxkbid0IGNhbGwNCj4gPiB1c2JfZXBfZW5hYmxlZCgpIHVudGlsIHRoZSByZXF1ZXN0cyBh
cmUgcmV0dXJuZWQuDQo+IA0KPiBObywgdGhleSBwcm9iYWJseSBzaG91bGRuJ3QsIGFsdGhvdWdo
IEkgZG9uJ3Qga25vdyBpZiB0aGF0IHdvdWxkIA0KPiBhY3R1YWxseSBjYXVzZSBhbnkgdHJvdWJs
ZS4gIEl0J3Mgbm90IGEgZ29vZCBpZGVhLCBpbiBhbnkgY2FzZSAtLSANCj4gcGFydGljdWxhcmx5
IGlmIHRoZSBkcml2ZXJzIHdhbnQgdG8gcmUtdXNlIHRoZSBzYW1lIHJlcXVlc3RzIGFzIGJlZm9y
ZS4NCg0KUmlnaHQuDQoNCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgZnVuY3Rpb24gZHJpdmVy
cycgLT5zZXRfYWx0KCkgY2FsbGJhY2tzIGFyZSBleHBlY3RlZCANCj4gdG8gZG8gdHdvIHRoaW5n
czogZGlzYWJsZSBhbGwgdGhlIGVuZHBvaW50cyBmcm9tIHRoZSBvbGQgYWx0c2V0dGluZyBhbmQg
DQo+IGVuYWJsZSBhbGwgdGhlIGVuZHBvaW50cyBpbiB0aGUgbmV3IGFsdHNldHRpbmcuICBUaGVy
ZSdzIG5vIHdheSBmb3IgYW55IA0KPiBwYXJ0IG9mIHRoZSBnYWRnZXQgY29yZSB0byBpbnRlcnZl
bmUgYmV0d2VlbiB0aG9zZSB0aGluZ3MgKGZvciBpbnN0YW5jZSwgDQo+IHRvIHdhaXQgZm9yIHJl
cXVlc3RzIHRvIGNvbXBsZXRlKS4NCj4gDQo+ID4gPiBUaGUgZGlmZmljdWx0eSBjb21lcyB3aGVu
IGEgZ2FkZ2V0IGRyaXZlciBoYXMgdG8gaGFuZGxlIGEgU2V0LUludGVyZmFjZSANCj4gPiA+IHJl
cXVlc3QsIG9yIFNldC1Db25maWcgZm9yIHRoZSBzYW1lIGNvbmZpZ3VyYXRpb24uICBUaGUgZW5k
cG9pbnRzIGZvciANCj4gPiA+IHRoZSBvbGQgYWx0c2V0dGluZy9jb25maWcgaGF2ZSB0byBiZSBk
aXNhYmxlZCBhbmQgdGhlbiB0aGUgZW5kcG9pbnRzIGZvciANCj4gPiA+IHRoZSBuZXcgYWx0c2V0
dGluZy9jb25maWcgaGF2ZSB0byBiZSBlbmFibGVkLCBhbGwgd2hpbGUgbWFuYWdpbmcgYW55IA0K
PiA+IA0KPiA+IFJpZ2h0Lg0KPiA+IA0KPiA+ID4gcGVuZGluZyByZXF1ZXN0cy4gIEkgZG9uJ3Qg
a25vdyBob3cgdmFyaW91cyBmdW5jdGlvbiBkcml2ZXJzIGhhbmRsZSANCj4gPiA+IHRoaXMsIGp1
c3QgdGhhdCBmX21hc3Nfc3RvcmFnZSBpcyB2ZXJ5IGNhcmVmdWwgYWJvdXQgdGFraW5nIGNhcmUg
b2YgDQo+ID4gPiBldmVyeXRoaW5nIGluIGEgc2VwYXJhdGUga2VybmVsIHRocmVhZCB0aGF0IGV4
cGxpY2l0bHkgZGVxdWV1ZXMgdGhlIA0KPiA+ID4gcGVuZGluZyByZXF1ZXN0cyBhbmQgZmx1c2hl
cyB0aGUgZW5kcG9pbnRzLiAgSW4gZmFjdCwgdGhpcyBzY2VuYXJpbyB3YXMgDQo+ID4gPiB0aGUg
d2hvbGUgcmVhc29uIGZvciBpbnZlbnRpbmcgdGhlIERFTEFZRURfU1RBVFVTIG1lY2hhbmlzbSwg
YmVjYXVzZSBpdCANCj4gPiA+IHdhcyBpbXBvc3NpYmxlIHRvIGRvIGFsbCB0aGUgbmVjZXNzYXJ5
IHdvcmsgd2l0aGluIHRoZSBjYWxsYmFjayByb3V0aW5lIA0KPiA+ID4gZm9yIGEgY29udHJvbC1y
ZXF1ZXN0IGludGVycnVwdCBoYW5kbGVyLg0KPiA+ID4gDQo+ID4gDQo+ID4gSWYgd2Ugd2FudCB0
byBrZWVwIHVzYl9lcF9kaXNhYmxlIGluIGludGVycnVwdCBjb250ZXh0LCBzaG91bGQgd2UgcmV2
aXNlDQo+ID4gdGhlIHdvcmRpbmcgc3VjaCB0aGF0IGdhZGdldCBkcml2ZXJzIG11c3QgZW5zdXJl
IHBlbmRpbmcgcmVxdWVzdHMgYXJlDQo+ID4gZGVxdWV1ZWQgYmVmb3JlIGNhbGxpbmcgdXNiX2Vw
X2Rpc2FibGUoKT8gVGhhdCByZXF1ZXN0cyBhcmUgZXhwZWN0ZWQgdG8NCj4gPiBiZSBnaXZlbiBi
YWNrIGJlZm9yZSB1c2JfZXBfZGlzYWJsZSgpLg0KPiA+IA0KPiA+IE9yIHBlcmhhcHMgcmV2ZXJ0
IHRoZSBjb21taXQgYWJvdmUgKGNvbW1pdCBiMGQ1ZDJhNzE2NDEpLCBmaXggdGhlIGR3YzMNCj4g
PiBkcml2ZXIgZm9yIHRoYXQsIGFuZCBnYWRnZXQgZHJpdmVycyBuZWVkIHRvIGZvbGxvdyB0aGUg
b3JpZ2luYWwNCj4gPiByZXF1aXJlbWVudC4NCj4gDQo+IEZ1bmN0aW9uIGRyaXZlcnMgd291bGQg
aGF2ZSB0byBnbyB0byBncmVhdCBsZW5ndGhzIHRvIGd1YXJhbnRlZSB0aGF0IA0KPiByZXF1ZXN0
cyBoYWQgY29tcGxldGVkIGJlZm9yZSB0aGUgZW5kcG9pbnQgaXMgcmUtZW5hYmxlZC4gIFJpZ2h0
IG5vdyANCj4gdGhlaXIgLT5zZXRfYWx0KCkgY2FsbGJhY2sgcm91dGluZXMgYXJlIGRlc2lnbmVk
IHRvIHJ1biBpbiBpbnRlcnJ1cHQgDQo+IGNvbnRleHQ7IHRoZXkgY2FuJ3QgYWZmb3JkIHRvIHdh
aXQgZm9yIHJlcXVlc3RzIHRvIGNvbXBsZXRlLg0KDQpXaHkgaXMgLT5zZXRfYWx0KCkgZGVzaWdu
ZWQgZm9yIGludGVycnVwdCBjb250ZXh0PyBXZSBjYW4ndCBleHBlY3QNCnJlcXVlc3RzIHRvIGJl
IGNvbXBsZXRlZCBiZWZvcmUgdXNiX2VwX2Rpc2FibGUoKSBjb21wbGV0ZXMgX2FuZF8gYWxzbw0K
ZXhwZWN0IHVzYl9lcF9kaXNhYmxlKCkgYmUgYWJsZSB0byBiZSBjYWxsZWQgaW4gaW50ZXJydXB0
IGNvbnRleHQuDQoNCj4gDQo+IFRoZSBlYXNpZXN0IHdheSBvdXQgaXMgZm9yIHVzYl9lcF9kaXNh
YmxlKCkgdG8gZG8gd2hhdCB0aGUga2VybmVsZG9jIA0KPiBzYXlzOiBlbnN1cmUgdGhhdCBwZW5k
aW5nIHJlcXVlc3RzIGRvIGNvbXBsZXRlIGJlZm9yZSBpdCByZXR1cm5zLiAgQ2FuIA0KPiBkd2Mz
IGRvIHRoaXM/ICAoQW5kIHdoYXQgaWYgYXQgc29tZSB0aW1lIGluIHRoZSBmdXR1cmUgd2Ugd2Fu
dCB0byBzdGFydCANCg0KVGhlIGR3YzMgY2FuIGRvIHRoYXQsIGJ1dCB3ZSBuZWVkIHRvIG5vdGUg
dGhhdCB1c2JfZXBfZGlzYWJsZSgpIG11c3QgYmUNCmV4ZWN1dGVkIGluIHByb2Nlc3MgY29udGV4
dCBhbmQgbWlnaHQgc2xlZXAuIEkgc3VzcGVjdCB3ZSBtYXkgcnVuIGludG8NCnNvbWUgaXNzdWVz
IGZyb20gc29tZSBmdW5jdGlvbiBkcml2ZXJzIHRoYXQgZXhwZWN0ZWQgdXNiX2VwX2Rpc2FibGUo
KSB0bw0KYmUgZXhlY3V0YWJsZSBpbiBpbnRlcnJ1cHQgY29udGV4dC4NCg0KPiB1c2luZyBhbiBh
c3luY2hyb25vdXMgYm90dG9tIGhhbGYgZm9yIHJlcXVlc3QgY29tcGxldGlvbnMsIGxpa2UgdXNi
Y29yZSANCj4gZG9lcyBmb3IgVVJCcz8pDQoNCldoaWNoIG9uZSBhcmUgeW91IHJlZmVycmluZyB0
bz8gRnJvbSB3aGF0IEkgc2VlLCBldmVuIHRoZSBob3N0IHNpZGUNCmV4cGVjdGVkIC0+ZW5kcG9p
bnRfZGlzYWJsZSB0byBiZSBleGVjdXRlZCBpbiBwcm9jZXNzIGNvbnRleHQuDQoNClBlcmhhcHMg
d2UgY2FuIGludHJvZHVjZSBlbmRwb2ludF9mbHVzaCgpIG9uIGdhZGdldCBzaWRlIGZvcg0Kc3lu
Y2hyb25pemF0aW9uIGlmIHdlIHdhbnQgdG8ga2VlcCB1c2JfZXBfZGlzYWJsZSgpIHRvIGJlIGFz
eW5jaHJvbm91cz8NCg0KPiANCj4gTGV0J3MgZmFjZSBpdDsgdGhlIHNpdHVhdGlvbiBpcyBhIG1l
c3MuDQo+IA0KDQpHbGFkIHlvdSdyZSBoZXJlIHRvIGhlbHAgd2l0aCB0aGUgbWVzcyA6KQ0KDQpU
aGFua3MsDQpUaGluaA==

