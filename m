Return-Path: <stable+bounces-238373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DVrKbRh4WnbsgAAu9opvQ
	(envelope-from <stable+bounces-238373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19816415394
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971E53074078
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE5370D5F;
	Thu, 16 Apr 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fScVMLmT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cF0vQtje";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aEjzfTau"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D0146A66;
	Thu, 16 Apr 2026 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378284; cv=fail; b=TqLdLuCX+EpbBFuoj7ICHyF+7o1j+ERRoXvEbbk7QQFP6aWy4YCbqEPwQzFFgMcKWcBeq+2E0LyW19Tp1R4r7CRSsnJHbk90bOBNRpsED3LL0chCWIbIcLgLod8ocEbb9aCVtW+PZqRepHrPPrm/Ghb/lmzR23+woPNZU3MD7wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378284; c=relaxed/simple;
	bh=PN02DazRoxCfOzNxc8Mb2WazYy3x+Ajq3Dvkop2xPik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLs4Lim4FarNIT0ibFoTDPe/uiPG6kudAGODqeYi3Iqv6xkQXuxkiUHdzJbwUJPG4JkLjMr2tUfyZGMr9kKj92wZakkzSCUgLrFcXK2GIWb4VrX1MQr1yIZXTsK22IW28Tc2+IkcDrNMiiDKsO4c+PGIG35vgNE3ZyxxgDxGd0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fScVMLmT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cF0vQtje; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aEjzfTau reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GKhIL72418310;
	Thu, 16 Apr 2026 15:24:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=PN02DazRoxCfOzNxc8Mb2WazYy3x+Ajq3Dvkop2xPik=; b=
	fScVMLmTQ+xwwm2H3ig/w3Rt4JljAWdFlApStasEvTajwn/zeMervmg3oq6oTKQH
	hZn4bYqY24vhhEMwqr3uF2bxEXo8NMpQqAIWuH8opzerXy0icwR7VcFozQ1wLhSD
	ur8IVsaBVHNnPGIb+VUYdBZ4GeioQBMqx14vKI/t0OUxGSL12thWnvqKVALiCNvZ
	luz8NOdWSjJprInW4JsOXG5HlVF0YV8QubbyF/eHBTNZFDIXA23QB806K/9Jxpz5
	xoeCKQwmkMPwa2icHXje7tZH02q1B7uZ7VSon5Hrg8+etZUCqM+iNT7aQ9jm9d7c
	L9ylSJ4Pz4Za+fnA6MuX7Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4dk728rfk3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1776378266; bh=PN02DazRoxCfOzNxc8Mb2WazYy3x+Ajq3Dvkop2xPik=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cF0vQtjeu8TPc6HhR3MNcsaixajqPQZfzawZoQVfg+cAQQeQgc3PufmCc/7i3eDSD
	 t1qzpFzpNCNrW35v50fDnq2RAnmZi87UagzVwqTItq/wgxhn5K/pOIQ+qmJOMpbQCn
	 c778zPG9dUYT5STqziRTakK69xO4m8WPGTLLEq62C7sB2GgdzWFluNeKAM2G0QC8PI
	 UYd0ia8iwWOq9MHA/lCeBGM41yacttW4ndGqexFIoSIfFYT0/i2ENf6W1skuSwy0hk
	 fgkEOrp1SIaVy8ASEVneHobhQcIZ4nAJogbIIBknPz/TnYLTcryNpDBCeUij8jVxYX
	 GXLooDDgTYbnQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 88FFB402B2;
	Thu, 16 Apr 2026 22:24:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 10FF8A00AE;
	Thu, 16 Apr 2026 22:24:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=aEjzfTau;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00106.outbound.protection.outlook.com [40.93.13.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 71B76401EF;
	Thu, 16 Apr 2026 22:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEyJ1zSLlUz5qe2C1mErT9o7TDLZrIIrXXcOmHsEawV8VawGRSBPeKM77Q8Vj6oeqotmCDNdrktSkSeOYxT1jyeD4YaCO4JFBB6HYJaX0R2VwJpxcgx7k77SO/B3QHUhE+9lz6hMx/KrZgdJlERdPnbRM5B/xRmOG7R6lzc+0PioSQdRB6AH78AFEKB3oJ4P0mr2zbNAYJ3974B8x/BAE+MQEXohz0/BJ7rtbrggmnqBdlJkOYw5BxTrlASdbXNt5iM7dgzi4B9z0tMbb5u+T6emVsiDRwx8062efEOpYbGZh/z3m+D5QfxGvGzMmLsMP5X2dJtjNRFbcLvbU1wxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN02DazRoxCfOzNxc8Mb2WazYy3x+Ajq3Dvkop2xPik=;
 b=JdPrKq2wm+3yXqw25faupyEfHZS0cXRr8eeG9xL/wnbORsu4f4T1B8B5DIJ9LEqCQEDL1Y2wwMRFVBUsp5y+2zYnd1NDaN4IVmp3RvJVBo4X7eJUEk5rsCQOPcXPC5JgeAWZRwEFn11k1filQvUKz7eKuNdh4b82SDHaPuWNjmOXFXThih37ohcnQ+H01V2AiwRVKJD2HDKodrehVfh4uvwxEV159mvGMXfMk7l5glnOEN64+4I3z5QkkrDSIO29M8hDaNu6AICNEgz7gpjySK5XlWedcg9IjiQN8SlLvFkigc1IGWWH7NXyCPZNfUNvmkkWx83dngY0XXufEf01RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN02DazRoxCfOzNxc8Mb2WazYy3x+Ajq3Dvkop2xPik=;
 b=aEjzfTaukOLAt/ojhAAgIoHbMIPa3ZeCiaUPTi26u8HphJfTRt9iEZsuD4UY4eC4kFtwB+p1yc/mS+5LD50r43I7pYmIBY3XK/5n6i9NCliZhsKgJ5SFVIcxklRK9V4HGfnEbigz9IaxYeM5D3UUiK3v5VwM3pw4R2yRaMPA9cI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 22:24:21 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 22:24:20 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paulz@synopsys.com" <paulz@synopsys.com>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pritam Manohar Sutar <pritam.sutar@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Fix GUID register programming order
Thread-Topic: [PATCH] usb: dwc3: Fix GUID register programming order
Thread-Index: AQHcyLgQyzkLRpw34UCOsx3EE2u92bXdxCUAgAC4VACAAOVnAIAAVdGAgAKWWYA=
Date: Thu, 16 Apr 2026 22:24:20 +0000
Message-ID: <20260416222407.fk2wbjnrkgwsjj5i@synopsys.com>
References:
 <CGME20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec@epcas5p4.samsung.com>
 <20260410064735.515-1-selvarasu.g@samsung.com>
 <20260414010532.sxciijnzak3ldw35@synopsys.com>
 <d2be3f54-5375-4f1b-ab4b-e2ff81c43630@samsung.com>
 <20260415014620.mjmlt6w3ttlzosr3@synopsys.com>
 <242b06d2-7785-4728-8286-ff79a8dfaaa6@samsung.com>
In-Reply-To: <242b06d2-7785-4728-8286-ff79a8dfaaa6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL1PR12MB5924:EE_
x-ms-office365-filtering-correlation-id: 4037b94d-7596-4ac5-d9b3-08de9c06e7d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 MmykXT71dovJYFhNbxWY3SeudQDaOs8B2Au5rQ/q6XBZM8604bUZXXHPAxKvbcw+6Pk2BUnm8zC0xZum7WEGfX0lIgavZrxv0SSTZ75A2OsxUBl4IOA1X1Gu72rBG4EpF3Gka4Qq6WEw4a3qbOufCjM3CVFacwn/kQUsUo1T1BSHTY7s+/m1nFIkkPaoXQu27HQsG5U6/hDFGyj2HPMCTKLFTJKEF141vQ1WJr392iAQkDPBW62cKfhtf0lw1R+tBKYN09m2nBKECCQ9aht4t5uhMP3VaLpijrTRJkTsmB84LIXkKwzxoZThwtHLnwJrT8Zx1jf6L5fKcMcdq/CclZjni++H73hGgy0jRu9NL3Ag4fbPw7kvpOwvWLLDk0MqdbzrWBpI8FOnKS1hb2sFs4bcHFM+DMYyySXhFjGBlkV2u+t2K2S9teoHjnNoxhHCJ0rMlCviS5GL+c3oDNCou/0jbVVujrWJq/Z9S969+VNuiEB6uZJRm3gBNWAoysKVeV9mDnTOsKp/O4PhyoPnUCU8CGMj68VM8BgeE4a0GA38+AiBREgDrmWKUhnbz6yuSNlgN1Sq3uYX96rR/QDyd3Dp2bjfWtbJGBsMXQ6ukSfekzjBBLGysmDclTIuuBeu/B8v7f0de/uGb86uJPuHbh8FQruw+kTd/cEro4jQzzG1byGhV0lwKgS4xUpmazCgfC2XdwZVgfNJ3KV5ZFUo9RvFrcJmgkUOn8/395g9NQAIj71toP3wNSbmZvsUbIFf+YErRP5xxp8IBMHlwBMbKFP8etAUpXhNYZ2Jsdwqb6U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3Vqb0Q5QnZ4NXo3RjA1Rm1SdEhQQVpXd2xvYWc0VVY5aERJYW54WTVUYnl4?=
 =?utf-8?B?VGN2MURnUVV1UUNPSElEYnFtOXltSVF4bTZ4UTVBVHMzVVRLQjMrSHp5a01S?=
 =?utf-8?B?dmxtUW00WkxCb3Z5VVB4am1VSU9XR0JjQXFLRmRyRUVlZWhQaG5odVFrVEVU?=
 =?utf-8?B?RjUreHlkZXZXd25aYVJybUR3aUtLUnd0K2xTWEIzRDk0Znh1UzZmS09ma2dC?=
 =?utf-8?B?VldLUXphN0h4Q0Z4OTN4SEE4blhKUk5rS0JJL3JzYkt1ZTY5dmlyVDhFS1lQ?=
 =?utf-8?B?TGIxUWY5YS8yZGNvQW5IbGM3Zm9zTjVxR1FsOG4vZ2VJTnJtR3o3UkVvTXZl?=
 =?utf-8?B?dlVOejFRdHV6NW8xZHZ2UHlIWVpKc1VnMTVYbU9VZ3dRaWpCM1hFaStBTVJ1?=
 =?utf-8?B?MDQzaEtNMnlnczVpdHBiRzVZaU5nei9xYjlwVGFuZ0l1bnhpaE9IaGplMThv?=
 =?utf-8?B?clFwa1lINW5Bck9LblQvK2QzTUVCVWlwaHMwNzlocGNIdTdId0NkT1p2UGJV?=
 =?utf-8?B?eE1TZDFXcXpnVTQzZTY0YWhsNFR1UUxZaXlTeHVBSEtBTFRkdGU4cnczWkt0?=
 =?utf-8?B?ZW5SZEFsSVNLZ3QwaytCZ3FYdVJYYklNc2R1ZTNXb1I4NzZWRjBiUlhHYi9w?=
 =?utf-8?B?NXJEamxIRTdKb2JSd09BNG1PcFpoTDNmTmdJRHhDWXlEU2EvY2F2K1ZVTzN0?=
 =?utf-8?B?THZEeER1L1MyVXJOL2ZjcTB1dy9ISS9qWUxiRVVndmZPVUJ3c0JQcDZHN1l1?=
 =?utf-8?B?ZEdPWHM4bWZ6WE5jRTAwL1ZWdUNnYnV6bDdrcUE4Z3lBK3BnKzBnMEFRdHZ3?=
 =?utf-8?B?ai9oSTNWMFNDWlhIQm50SHUwM1JVWjE1MzJDMnVBOWFWbXBVMTJmZFU5amtN?=
 =?utf-8?B?SEtoS3hoY1JoU3NIUVpBM3ZpR245UHdoQlNHUTZYMyttMDhwVERUaXNPbWZh?=
 =?utf-8?B?U29IbnJXdUVMTjJyZ20yK202enNObmlITjYyK2tsczkzRUljdmlBZk9ocGV3?=
 =?utf-8?B?OTRibk1yZ2hBNVlZei9MNXNLZXJGekxEODZGZXUrN1JTWU9UcGs0cWZYUE9j?=
 =?utf-8?B?WVNGaEEyOUpaTGltMFFlZ0ZtdmJvRFNhUEhRVkdyRExLUnV6amtUR3hPZTZD?=
 =?utf-8?B?M3FNNS80djZjOUgvSWR1YVYwVUJmWXlHTjJTSXhIcTc0ZFV2R3FFRzR3Rytu?=
 =?utf-8?B?MDhObkNsRXhlbmhnMWsvSUx1NWYyVUt0QXRvai9IaE5EYVBoQTlob2pieDVI?=
 =?utf-8?B?RjRQYkpVZlBnY3pwQmRXMWtTdmZtSk5VSTJsaytYQkhkSmV1RkdzOUd2aXJx?=
 =?utf-8?B?RFVzUHZaVk04ZndKZHFZUldtdDl3ZUhZRU5vSUZweVdsZ1FzWlcydnBmZkpl?=
 =?utf-8?B?MzdFcnFDMCtOaTlGbisrVm9XSDFMQlZ4R3J4STgwRk5jcHRWYkh5ZHk0ZjlF?=
 =?utf-8?B?d2EvUi9iWjFmNmE5czEzdU1WUjArYzljNjJSTElrT0NVWFQzbCtwNWdIcE5S?=
 =?utf-8?B?aDg1MUhiNmoza1NRdmk5aUdUSVRtWlNnMTREQTJTblBhNm9vMDVqWTY2dFFs?=
 =?utf-8?B?bmFlaEtXc1JEWGgzOXprcHB2QkxsWHlKdlF1UWM4MkpseDFJWVpWelpuWDYx?=
 =?utf-8?B?Ni9NT2ZMK21MTERlYlFDNWRTR3ZaZkhGL1pwRjJwdis0UzlldXNpQWQ3Z21L?=
 =?utf-8?B?L2xCKzk3Rm1mWktXNFhGQWFyYmU0cXZiT0JQOERHS3QvUFg0dUIyam1FVWhy?=
 =?utf-8?B?L20xOCtsa0hORGk0d2Q0TUpiQTJzOERJLzgrRElrclJpdkpTTm56ZnJFdjNE?=
 =?utf-8?B?Q3c2bXFrMkFBSWhmeFV6ZGJMQ0VhYzZQaFVXTisxelJQUld0SjBsQVhSaHpW?=
 =?utf-8?B?K010U0hqSFN5dlo5eDJaZ0VRL1BYUkE4ejBTVE05dFg0R0dxOHcrSGtkNmRs?=
 =?utf-8?B?SDdJV3BtTDZ1Y2c0MnlrMkp3cVNXckpETmpDNkNvWWE1NksrRzJaMGNLZG8w?=
 =?utf-8?B?VlZzaWVSdEpXemZldU82N1h1RDV6MFluNW11eUl4MkF5ZzZjNFlEb201QzB2?=
 =?utf-8?B?cVZGSElMS0gxN2RmR3BqS0wwVUFSZWJNV0xPVkdvOEdkdzEzS2p1NC9jR3FN?=
 =?utf-8?B?UTNmaDJQRy90K01OY1QvUXYyemRIbFdLSVRIWXc3ckw1ZzNQR2Jzd2UyU1VX?=
 =?utf-8?B?cmk2dTlHRGxqQzJDcEowZGUwbmVQLzN4QXpMTW5waWJiS2NIM1ZjTDJvUTJy?=
 =?utf-8?B?Rk1kV3lOOGRUMk9rb3duTVBLRnJVYUNQazhmQldYMDRXMitQRkpBazA5YUpI?=
 =?utf-8?B?UTMxSFZ4M0JaS0Q2M3JlcDRab0lONysxOStaa3VUeTE5NFZITXl4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB68B2C4BE35664D88F6273CA8E9A784@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OD+q3VlHzjBbmF0BhkS1EA0bqM6CkN9pP2l1OhMsK7d9ZX+jbNtmPoGPEWkUDjiL9DhNDcrL5BRd6LGlKqE50MXzsZY0YwdC8rd9yefjeEn58QMj09ZgndVJU/Uwxs7lclYmMz/R+gB3zPgZgZocyHZ3vbNXLj5jpFFNAHUdBlURQBI/wC2PkoR5Rfm1D6SWKUnu3c1CU5hwW5hcDzmW+FOefW++fQ5WUICUCfvLZRVQ/vVYltYv3+BGMH7wPc7mlSoT1Ed+6cLZwfEbNfpnSW9auSwyGE/3UWy+VS1jSsX+h2a7sVbUz77PTedZuNGbCPF/Rm75nXdFwXnVlszwsA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZFDXqNisssHrKJ3OvATdJiw2YVUqPPdIiCkfAlS/T0im+auXgSUpaG8z8UFa5oCb9XHQSJzM7ThvHLqpNfSTJ389wmTKg8f8woqeNKeDUPfTAyGXyhZss6RaHsYYkP1MwdpQp1babUPc9K+Ez7GZa8+li1QouKMw8SqMcq2XPvCQG9mLGjDh1L3GUlDd0yQoCtZQbpX1l1MnlR6ZZDI4aOh+acCkBrze1e4y+4/NqyAx7ozSDquasqkitfwutYQTZrwkPgSaWgrsfYIMOdcJgyatLizb2ZSpADK4/N39xb9DtHhg/R2nEGyQvYI3KdiWRHq69FUrA+1xd65v9J1zKm2Qge5TUCBIF0wGSod++tmsS1RMRxy/S+/+NBF/dtEg7Z9nuEe07J8MwJtoxoZdyCgDHJMlR9Xn/8XlaejCg47KtxwYWzZ7ImHJrPwG5lLW8mw0jKUgzQl9KfuKSleGjeNbGRRtZ4KHBywFQGZwgygWgCCVbCNyt106EHErZHHPi2rDN+3gYB1eujUUCgTV7rzDbdzyBCy3/KsBLLrW/oJgTmg1swaEUgY7o8dlYttK67nFx/9KwaidQb9zOFIS2YvFs2IkSP//qrcpzu4b7I7vw8YGYaS0rfQ8oitbDNDAjUVI2jPkTxTYAOFGjIolGA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4037b94d-7596-4ac5-d9b3-08de9c06e7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 22:24:20.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzsN9JkJPig1lUf+VPn3HzGiQ3T2wPQFZtI1qqJJ6upO9K3rWOMEHDnY+aKXIpkMByDpbKGwHu0+8og0+5nltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
X-Authority-Analysis: v=2.4 cv=CqSPtH4D c=1 sm=1 tr=0 ts=69e1619b cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=xKlp24NoqlmsZ8y70KjX:22
 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=Qf5UMqwCPPN9QZFZJvQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kzE-zDWmLTWzgxg54ddouKlcfRWZJk2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIxMiBTYWx0ZWRfXxBbdbUjOEag8
 grg5mALNipTsSzgfAoPx5cZqlySk17CKTyuZR89H5lRNVBRavdhlI4CTjplUtSxnR82m37AUmeC
 /AriM5DT2FdG6i0/nUC2N1lmlTYZI/K4sPyHqnt2rE5wJjRGGiVhU08TjbVWEmZpx/gqdTynxFP
 K9niXizui36PYC+OKUnC0c1DmdRpScrOOpDb4CQqvzaOcAlbCb1f3/78CUPhyHoqOwp48vb48E4
 odV6ho+MXJETJqYdGRc/1bu2ttzMis8qsGrMhT7bN/4S6hXF2+mw6FY00TVq7whPKZtGLxYUChK
 +Am+5LdAdN48DAbA0nVGDiZHb8r5T7yLbxJd/Fyzg0D0vBZbrxrEISzQDOMVUwrbARBpoIcZza9
 uVxkohMyzSCC5ZlBlxxYX9o12gdjs3PVoHI0Z0xfZuxSKVHz00ps7z5uea3NG8Q4dwdx3M8BeAq
 YgGme4y//W8DGx7xXCA==
X-Proofpoint-GUID: kzE-zDWmLTWzgxg54ddouKlcfRWZJk2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604070000 definitions=main-2604160212
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238373-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 19816415394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBBcHIgMTUsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
NC8xNS8yMDI2IDc6MTYgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAx
NCwgMjAyNiwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+IE9uIDQvMTQvMjAyNiA2OjM1
IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+PiBPbiBGcmksIEFwciAxMCwgMjAyNiwgU2Vs
dmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+Pj4gVGhlIExpbnV4IFZlcnNpb24gQ29kZSBpcyBj
dXJyZW50bHkgd3JpdHRlbiB0byB0aGUgR1VJRCByZWdpc3RlciBiZWZvcmUNCj4gPj4+PiBkd2Mz
X2NvcmVfc29mdF9yZXNldCgpIGlzIGV4ZWN1dGVkLiBTaW5jZSB0aGUgY29yZSBzb2Z0IHJlc2V0
IGNsZWFycyB0aGUNCj4gPj4+PiBHVUlEIHJlZ2lzdGVyIGJhY2sgdG8gaXRzIGRlZmF1bHQgdmFs
dWUsIHRoZSB2ZXJzaW9uIGluZm9ybWF0aW9uIGlzDQo+ID4+Pj4gc3Vic2VxdWVudGx5IGxvc3Qu
DQo+ID4+PiBUaGlzIGlzIG5vdCByaWdodC4gU29mdCByZXNldCBzaG91bGQgbm90IGNsZWFyIHRo
ZSBHVUlEIHJlZ2lzdGVyLg0KPiA+Pj4gU29tZXRoaW5nIGVsc2UgbXVzdCBoYXZlIGNsZWFyZWQg
aXQuIERpZCB5b3UgYXNzZXJ0IFZjYyByZXNldCAoaGFyZA0KPiA+Pj4gcmVzZXQpIGR1cmluZyBw
aHkgcmVzZXQvaW5pdGlhbGl6YXRpb24/DQo+ID4+Pg0KPiA+Pj4gQlIsDQo+ID4+PiBUaGluaA0K
PiA+PiBIaSBUaGluaCwNCj4gPj4NCj4gPj4gVGhhbmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlv
bi4gWWVzLCB5b3UgYXJlIGNvcnJlY3QsIHRoaXMgaXNzdWUgaXMgbm90DQo+ID4+IHJlbGF0ZWQg
dG8gYSBkd2MzIGNvcmUgc29mdCByZXNldC4gSW5zdGVhZCwgdGhlIEdVSUQgdmFsdWUgcmV2ZXJ0
cyB0bw0KPiA+PiBpdHMgZGVmYXVsdCBzdGF0ZSB3aGVuIHRoZSBQSFkgbGlua19zd19yZXNldCBj
b21wbGV0ZXMgZHVyaW5nIFBIWSBpbml0DQo+ID4+IHNlcXVlbmNlLg0KPiA+Pg0KPiA+PiBXZSBh
cmUgdXNpbmcgdGhlIFN5bm9wc3lzIGVVU0IgUEhZLCB0aGlzIHJlc2V0IGlzIHRyaWdnZXJlZCBm
cm9tIG91cg0KPiA+PiBkb3duc3RyZWFtIGRyaXZlciBkdXJpbmcgdGhlIFBIWSBpbml0IHNlcXVl
bmNlIChpbnZva2VkIHRocm91Z2gNCj4gPj4gfGR3YzNfY29yZV9pbml0fCkuDQo+ID4+DQo+ID4+
IENvdWxkIHlvdSBwbGVhc2Ugc3VnZ2VzdCB0aGUgYmVzdCB3YXkgdG8gcmV0cmlldmUgdGhlIGNv
cnJlY3QgbGludXgNCj4gPj4gdmVyc2lvbiBpbmZvcm1hdGlvbiBmcm9tIHRoZSBHVUlEPw0KPiA+
PiBBZGRpdGlvbmFsbHksIHdvdWxkIGl0IGJlIGZlYXNpYmxlIHRvIHVwZGF0ZSB0aGUgR1VJRCBy
ZWdpc3RlciBhZnRlciB0aGUNCj4gPj4gUEhZIGluaXQgc2VxdWVuY2UgKHRyaWdnZXJlZCBieSB8
ZHdjM19jb3JlX2luaXR8KSBjb21wbGV0ZXM/DQo+ID4+DQo+ID4gWWVzLiBKdXN0IGZpeCB1cCB0
aGUgY2hhbmdlbG9nIHRvIHByb3Blcmx5IGRlc2NyaWJlIHRoZSBwcm9ibGVtIGFuZA0KPiA+IHNv
bHV0aW9uLg0KPiA+DQo+ID4gQlIsDQo+ID4gVGhpbmgNCj4gSGkgVGhpbmgsDQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSBjb25maXJtYXRpb24uIEkgaGF2ZSBtb2RpZmllZCB0aGUgY2hhbmdlbG9nIGFz
IHNob3duIA0KPiBiZWxvdywgcGxlYXNlIHJldmlldyBpdCBvbmNlIHRoZW4gaSB3aWxsIHBvc3Qg
dXBkYXRlZCBwYXRjaHNldC4NCj4gDQo+IA0KPiBGcm9tOiBTZWx2YXJhc3UgR2FuZXNhbiA8c2Vs
dmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IERhdGU6IFRodSwgOSBBcHIgMjAyNiAxODozNDowMyAr
MDUzMA0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHVzYjogZHdjMzogTW92ZSBHVUlEIHByb2dyYW1t
aW5nIGFmdGVyIFBIWSANCj4gaW5pdGlhbGl6YXRpb24NCj4gDQo+IFRoZSBMaW51eCBWZXJzaW9u
IENvZGUgaXMgY3VycmVudGx5IHdyaXR0ZW4gdG8gdGhlIEdVSUQgcmVnaXN0ZXIgYmVmb3JlDQo+
IFBIWSBpbml0aWFsaXphdGlvbi4gQ2VydGFpbiBQSFkgaW1wbGVtZW50YXRpb25zIChzdWNoIGFz
IFN5bm9wc3lzIGVVU0INCj4gUEhZIHBlcmZvcm1pbmcgbGlua19zd19yZXNldCkgY2xlYXIgdGhl
IEdVSUQgcmVnaXN0ZXIgdG8gaXRzIGRlZmF1bHQNCj4gdmFsdWUgZHVyaW5nIGluaXRpYWxpemF0
aW9uLCBjYXVzaW5nIHRoZSBrZXJuZWwgdmVyc2lvbiBpbmZvcm1hdGlvbiB0bw0KPiBiZSBsb3N0
Lg0KPiANCj4gTW92ZSB0aGUgR1VJRCByZWdpc3RlciBwcm9ncmFtbWluZyB0byBvY2N1ciBhZnRl
ciBQSFkgaW5pdGlhbGl6YXRpb24NCj4gY29tcGxldGVzIHRvIGVuc3VyZSB0aGUgTGludXggdmVy
c2lvbiBpbmZvcm1hdGlvbiBwZXJzaXN0cy4NCj4gDQo+IEZpeGVzOiBmYTBlYTEzZTlmMWMgKCJ1
c2I6IGR3YzM6IGNvcmU6IHdyaXRlIExJTlVYX1ZFUlNJT05fQ09ERSB0byBvdXIgDQo+IEdVSUQg
cmVnaXN0ZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRlZC1ieTog
UHJpdGFtIE1hbm9oYXIgU3V0YXIgPHByaXRhbS5zdXRhckBzYW1zdW5nLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29tPg0KPiAt
LS0NCj4gIMKgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxMiArKysrKystLS0tLS0NCj4gIMKg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IGluZGV4IDE2MWE0ZDU4YjJjZWMuLjhiOWU5ZDNlOTU4OWEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IEBAIC0xMzQxLDEyICsxMzQxLDYgQEAgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2Mz
ICpkd2MpDQo+IA0KPiAgwqAgwqAgwqAgwqAgaHdfbW9kZSA9IERXQzNfR0hXUEFSQU1TMF9NT0RF
KGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsNCj4gDQo+IC3CoCDCoCDCoCDCoC8qDQo+IC3CoCDC
oCDCoCDCoCAqIFdyaXRlIExpbnV4IFZlcnNpb24gQ29kZSB0byBvdXIgR1VJRCByZWdpc3RlciBz
byBpdCdzIGVhc3kgdG8gDQo+IGZpZ3VyZQ0KPiAtwqAgwqAgwqAgwqAgKiBvdXQgd2hpY2gga2Vy
bmVsIHZlcnNpb24gYSBidWcgd2FzIGZvdW5kLg0KPiAtwqAgwqAgwqAgwqAgKi8NCj4gLcKgIMKg
IMKgIMKgZHdjM193cml0ZWwoZHdjLCBEV0MzX0dVSUQsIExJTlVYX1ZFUlNJT05fQ09ERSk7DQo+
IC0NCj4gIMKgIMKgIMKgIMKgIHJldCA9IGR3YzNfcGh5X3NldHVwKGR3Yyk7DQo+ICDCoCDCoCDC
oCDCoCBpZiAocmV0KQ0KPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJldDsNCj4g
QEAgLTEzNzQsNiArMTM2OCwxMiBAQCBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3
YykNCj4gIMKgIMKgIMKgIMKgIGlmIChyZXQpDQo+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBn
b3RvIGVycl9leGl0X3VscGk7DQo+IA0KPiArwqAgwqAgwqAgwqAvKg0KPiArwqAgwqAgwqAgwqAg
KiBXcml0ZSBMaW51eCBWZXJzaW9uIENvZGUgdG8gb3VyIEdVSUQgcmVnaXN0ZXIgc28gaXQncyBl
YXN5IHRvIA0KPiBmaWd1cmUNCj4gK8KgIMKgIMKgIMKgICogb3V0IHdoaWNoIGtlcm5lbCB2ZXJz
aW9uIGEgYnVnIHdhcyBmb3VuZC4NCj4gK8KgIMKgIMKgIMKgICovDQo+ICvCoCDCoCDCoCDCoGR3
YzNfd3JpdGVsKGR3YywgRFdDM19HVUlELCBMSU5VWF9WRVJTSU9OX0NPREUpOw0KPiArDQoNCklu
IHRoZSByZWFsbHkgb2xkIGtlcm5lbCwgdGhlIHBoeSBpbml0IHdhcyBwYXJ0IG9mIHRoZQ0KZHdj
M19jb3JlX3NvZnRfcmVzZXQoKS4gTW92ZSB0aGlzIGFmdGVyIGR3YzNfY29yZV9zb2Z0X3Jlc2V0
KCkganVzdCBhcw0KeW91IGhhZCBiZWZvcmUuIEl0IHdpbGwgYmUgYmV0dGVyIGZvciBiYWNrcG9y
dGluZywgYW5kIGl0IGxvb2tzIG1vcmUNCmZpdHRpbmcgdG8gcGxhY2UgaXQgdGhlcmUuDQoNCj4g
IMKgIMKgIMKgIMKgIHJldCA9IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ICDCoCDCoCDC
oCDCoCBpZiAocmV0KQ0KPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJfZXhpdF9w
aHk7DQoNCg0KVGhlIGNoYW5nZWxvZyBsb29rcyBnb29kLg0KDQpUaGFua3MsDQpUaGluaA==

