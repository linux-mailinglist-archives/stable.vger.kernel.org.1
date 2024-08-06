Return-Path: <stable+bounces-65510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D8949C4D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 01:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6586B1C210DC
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC46176224;
	Tue,  6 Aug 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VpZkK4kF";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gd7vje0I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="foSvBvao"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD639175D36;
	Tue,  6 Aug 2024 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986949; cv=fail; b=o8AgUaU01zqxwyaPc0RMWTQM1AYmDzO35SmQd1GM0xZz9jq8MF7ceitj8pLldKbFKNh4oLqmEy4eHH3tTdjoDHV99TjgE4l7V2a3MpFi0cKRgnwYyS85PSnb9FrysGndv4yCpzaYyMc3+h9eVkmMwLl2P6jNwXlRf+bpdxAJfT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986949; c=relaxed/simple;
	bh=90vBcaz2y2Z5zTtpkMB4Qz9Wr7QvloR2mSQUz+PBeBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bN7vhJDXpXZarnnU/ahGRHRLckKOCxfcF8qIp1gpBbFkgOkiRcK7B/StPEAb+Ef7K1dXObuRtxV3I/f5ttDlpFNN91cqetxTcYJo7GRZYSgzl04J7w6Lmkrr8/lxen3FA7Q3olTflSXLWhZlSeWG1JJMwfY1016gW8hS18pUGsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VpZkK4kF; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Gd7vje0I; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=foSvBvao reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJhCS032283;
	Tue, 6 Aug 2024 16:28:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=90vBcaz2y2Z5zTtpkMB4Qz9Wr7QvloR2mSQUz+PBeBs=; b=
	VpZkK4kF2M+SkeYWVwa8lHu7lVWEmxGcO/8sSg6fLDF6YlHVZOCmTuvDd/kf2CsO
	P6KICAXUyt23GtVxQ/PJ6pXMkg7nt2SZFi22NB6JEFjSJVXdRdIryTcbb8r2bgsa
	Yliabg3kWOZLlGIZYF7JYvxb4O/oOkWwX5uf+JNRKZug15ELZooGH/3wIc0PfPB7
	NaPlmmwgykUhgogYv+MxASBibyl1EQYgYaDu6w3bD8wEflEOs1HR1ISu0gzuflcf
	PShDi1nZi2vtHqSG6lGAIxAHulCboLOAXwPkAkGXK6ZXVFH0jiezfRZ2Run8pp2P
	DDHPMzOa0Ft6E7Oj1qYlAA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uuja8crt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722986929; bh=90vBcaz2y2Z5zTtpkMB4Qz9Wr7QvloR2mSQUz+PBeBs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Gd7vje0IBhorJtb2gB4NjpH0thiz3rgHG+jqH44B4i1Dplp3NatFJ2iFW0O0pYAhV
	 RzcrhwVphPdQvIYz5s+oydMINhpXu6EEzKUrz3X2ViXwyOkNCUHg7TFciX9U8RSCO2
	 LsYMIoAydnoyav3ywVJnHt/OT6SX+fPuG+CENr71orFsxNbaM/z4iaP1a0vKZmWL/d
	 EjJMaYX7Eu00wqHQ1LTZaEgJltEOmkLzrs/lmc28V3pfSWvbRCu7J+Ob/k/4TYT2yu
	 C7oVsH/4DnYk76FnMIoKRVKnXcVeDkk8vvVPC6YFZBCdY7nE6gHIwKxcpJjqbqTzL3
	 9Vs4fLvLscQ/w==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C5AE240147;
	Tue,  6 Aug 2024 23:28:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2099AA00B4;
	Tue,  6 Aug 2024 23:28:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=foSvBvao;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6951B40211;
	Tue,  6 Aug 2024 23:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQy91z9TuqlLt4d8NDEitw1g+gOpOc+vi7yO3Cp52rBn3Yvlr9QnM+a33zzMMgE/DT9Dt3NJKV6iyN5aMSIQWn+F8RYPvEa2Y8FH7VHOOp0XaAv9EqC66+G95Zl3hej3ZP5W6MPVSgSj1SDbNeMWhx0UZVdv7OxHOaFYMnDvYHW7kCw6OFOTegjKRMc+dpAMfMfjvXNBdIPP61aefJO1jZ0+U7MgrRC3vR9ePsfFOol8sOx+E3bN8nW1wG6pr1OOPhjFohqDiVAWuUT+uHAHX9frvCdKL+Xp/Rp01MjqhQkMH12xHVTX9NxQ3OHszGx68WZpuAg8Pr+v7TQbw83dPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90vBcaz2y2Z5zTtpkMB4Qz9Wr7QvloR2mSQUz+PBeBs=;
 b=n6CxcvNu3Mmhmjd92X+mZazP0/o3JHEoESdbBmvlwJ5xqSkTP2dNGe4Rj8Qwq94UwQRwdy4fu62K72CxMs+5jacJJjxCcme0ERdWQPvaNtT55jiEcyH0HJb6u89liyyFUFPY59xhWQrE3H2EcTvKDO6muA9Po0rbeyckQceAEnBWNWvcOqASN57EO+OEHOmLHAiiwTGipMNPIs8n5Y+AwCr+bFYTpgNqsr/ShuviMwHle7MDsmXMchmVQfV8pkigCXMlJiDRN20nX78nB/9YUaPg4azXzvuNQuVp60A/H4Zh+DcfkfYIHKt9iQA3oWPy/vNopDkhMIIzZUZ7t+51Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90vBcaz2y2Z5zTtpkMB4Qz9Wr7QvloR2mSQUz+PBeBs=;
 b=foSvBvao/U7YRH40T84To3I4MWVP42p9TKK7ojNR3Gn7vgilHOuK4PRzbjpM4doRcm8CkHfeU2ypdC807iDTNG5xRtVhjPMvSJnFreFlzNJe8IX8f93KLfdHlKPNQ5yTjkaZxeLVdDlgAdVzo4Ml+csvvvzM3ffPPLfRSiH2U18=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Tue, 6 Aug
 2024 23:28:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 23:28:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kyle Tso <kyletso@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "raychi@google.com" <raychi@google.com>,
        "badhri@google.com" <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "royluo@google.com" <royluo@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: Runtime get and put usb power_supply handle
Thread-Topic: [PATCH v3] usb: dwc3: Runtime get and put usb power_supply
 handle
Thread-Index: AQHa5krbJOjr5sXVeUWyTPcKNhufO7Ia5CIA
Date: Tue, 6 Aug 2024 23:28:41 +0000
Message-ID: <20240806232836.52rkn7u3g5uiotn3@synopsys.com>
References: <20240804084612.2561230-1-kyletso@google.com>
In-Reply-To: <20240804084612.2561230-1-kyletso@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5961:EE_
x-ms-office365-filtering-correlation-id: dfa095ed-4c23-4a91-a271-08dcb66f81a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVZqUXgvZGN5VWZaNzRIanViTDZGaEpHaDFyY1h0WlZVT3N3NWdLQzZEK1RB?=
 =?utf-8?B?Y040TnZheHpDUVFiTmNjUHJQd3lIdVhTaVRNcjgyRC9HSm1rb1NFdExUVDdB?=
 =?utf-8?B?b011elEvdDAza2xyZFFuV0l2ZnBXQUNHSDJvZ05ZdDVsQ3N6OXVHWHBwZGhm?=
 =?utf-8?B?NVBNcUl5dmhxV0xpL041dGtzSnhFNnJ3U0FUSzIwTE44MWczUkV3RU9zelE5?=
 =?utf-8?B?RXZSUWNMUVNhTHEwekVWdUlFaGJMZzY3KzBSVEdZdDZGY1FUOWVONVhFN2tz?=
 =?utf-8?B?UytpYjREamFDZG5jMktjaGJteU5udnhCK21jWDQrbzJEaENySy9RRVdwc2lx?=
 =?utf-8?B?OG1VakVKTUgyWFk3cFROVnBwSmRDZEFDc3dLWXAxaUc5bkdqOVM5ellJSEtK?=
 =?utf-8?B?bFpqbGU4eWE2Tmp6T0drVzNkMlNHTmd6N0tSVnliNEdiSjNPTXdKSXRqL3dY?=
 =?utf-8?B?UCt4ZmFXbTJBNWVQUW1vT1Q2ZWZhaGVyaEhFaUpoRmp4T2RiZ2szZ1Frcy94?=
 =?utf-8?B?NDRFU3VwZG5kTFptVTJwTTZ0SlU3VGY0QStQRTdiUkpFM0hvbktEa2Z4T0F3?=
 =?utf-8?B?Nm5BeE5PK3U2RjQ2WmdsY0lWbG1xSVdOZG9oSzIxVmIwemNUa3BhQmwwODA5?=
 =?utf-8?B?cytFWDZSWklXWUova1g2SlI5cFFyRnBtK2hmaS9sdndLeXl5RXk2M2YrZjhT?=
 =?utf-8?B?aDg2NzdzTnIvOTNVWndUVzFtcDhkU2RjNFZUeU9FUEVsdHNvNDFjUFZPdFJu?=
 =?utf-8?B?b1dIcHlWM3M5WFJXdHVqTHdzU0o2OU9sYW15QUpDbW1lenhxWnpQMlA2OTFV?=
 =?utf-8?B?NDRiQXRER1VQV0hoemZDRklsd3dIU3VJWnRvbVo1ZE1QbnprbUZtZThscDE5?=
 =?utf-8?B?WVRGVkhDem40Z1c5QmVBMmwrMTBmcVRiUnFtVUpIRStZNXZMYW5nQ3VVUkJn?=
 =?utf-8?B?VmFrcCtyaDVWYVZtWmtvbVlCVHFtM0NPRVY1cE1DeWRibE1Ga0lTbHN5YlV6?=
 =?utf-8?B?eDZ5MEFLZ0NrUXhjajVKbGhjUEY2MXlUT0tXa0JYT28xYVBTVFlDSlRFenE0?=
 =?utf-8?B?Y3FZK1NKZllCTEwxT3lFME42MVdWRzlmUzhiU3cxbll6cWlFNU1CQVdLV0ZD?=
 =?utf-8?B?dWVpa0kyNWVFRUF2M0ExdkZ6Q3ViV3RMdzdYTnBGNGovUnl1Wk1BRVo1ZWYy?=
 =?utf-8?B?bE91YWRybUF0RTYxUFRjbktocyt3dkN1R25TeEF5ZWZYOUs2YVdEeUJPZm1S?=
 =?utf-8?B?SW5rVzhBeVpVOXg0d1ZYaFVUY2k2U2dJa2FNNjhPWC8wODN4SjhPY0RTcG14?=
 =?utf-8?B?WStkQmd0WTZldzlmSEFqUzk4SFp5SllhbVp1eVp6WFliVG80Q3pnMmFUZEw0?=
 =?utf-8?B?STRpUnlCVnErYitCbzM4N1ZVcDFuSGpsaGx1Q1FoVFlaT3pDOGNSbFN2NGtX?=
 =?utf-8?B?Sll5ckxxRU5DMWtpekZTTGFyd3MrS2oza0ErYTZGZFZCTlVDYlhwVkdVSThB?=
 =?utf-8?B?bTVPcENJZWlwcFkwSTBLN25Ma1RrZytJYklTazJHc0x6TmpBOG5ERjVSVWFn?=
 =?utf-8?B?cWFndzhIb3R2dS9OTnlMMTd1MUk3N2RNbFVaTnRqSlJVUGdrRXc2TnVxYzho?=
 =?utf-8?B?VzBlRUJiLzJZa3dDWVFRUnhEWEFFWi9RSkorcG1Ud3RnbjMyNFUyd0U0VVJj?=
 =?utf-8?B?cFA0ZXovQXJpSW1sNmpZaHFNS0dWaHVmdXJwbUNrUVM4M3RpeVB6ZFZReFVz?=
 =?utf-8?B?V2hRVUtoWWVEcXRLTFJ2MVNNeW9waTMyOWdiTFMxdi9LYVhBdjFZc0UwY0ho?=
 =?utf-8?B?RzlzeDc1OWtWK1pVZjBGbVBncGdSNk5Ndjg2dWFnNUx6ai9XdnFxVS9LSWlx?=
 =?utf-8?B?MSs5VmdhNWxYZFByNVp1eUNHZnU2QTJCeXI4WmNTeDhrdGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkNXS0NmcDA2d1VSZUt3VjI5THFxeWl4Z3R5RzRBQ2UxZ1RqYVBUN2NaajNY?=
 =?utf-8?B?d2FSZ1p5ZnJ2SVRyVk5leU9MZEJXdDZWRDVjSkdXbnZ6WnFydHVnRTJMYzBQ?=
 =?utf-8?B?amRRMXZDUkM3TzVyUnA5c0NSVTBVekErNG9vUXVTdUR2bjRWSDR4Z3k5K2pT?=
 =?utf-8?B?K05kdEwreDl6dlNmY1Q4TmlwTE1POWlyT2t6Vm5nR3g4NlorYmtIbWJQOC82?=
 =?utf-8?B?OS9UZG9oZzlUcnhrRUdaVXFEa1gwSnUxYnIzbzVkUnE2dnhObHRGUVAraVZm?=
 =?utf-8?B?ZytkS242VVVJY3JiZ2JHV20xN01SODdIeTRERFM5ZHFTcWxFSXhqRUo4N0ls?=
 =?utf-8?B?YUpsVERETCtpSTh2UGVvZzNWL3M3ZU15cndBU240UUM3RlJ2WHVBY1htZjlX?=
 =?utf-8?B?eExyRWVQbTBPVnZzcG84VU5YVWZpay8wajVLTnVIZy9jZEJwR3BMMFpuUkx4?=
 =?utf-8?B?UnNiZ0E5dWJWek5vTUlKSFNHcHlFZWt1WkdlQXRGWkZTUHQrRFZXcldORnhi?=
 =?utf-8?B?L1NrVkJ1UVVlbGtjWmNVUWsxKy9QZ0FldjQvdnRZVDA2aVdramlZVnYzdDVv?=
 =?utf-8?B?clpkWXJaQktDaUxpcHQ0cndFaE5GNTRUOVpZbEMydFRiZzZKUkt5bEFWeW5m?=
 =?utf-8?B?MjVhU0MyYzltMTIrMUVZUkhocU9tTWx4QzJYZnd0UnlWUUlldUwySGs4Tjdt?=
 =?utf-8?B?QWdwaURhSDdhallPN3dtUlgvNnk3bU82VzlsOWJjUWMxWkRoZGZmVnh6RXZi?=
 =?utf-8?B?OTc1bVhBM1FjU1VrVWN2d2xPRXlVOGIxRzZoQXZXdENHczRHOEdkYlkrL3ZP?=
 =?utf-8?B?cTNTZzVzY0tXVEVSY2FwcVFmV2FBT210Rkt3ZGdzS0oxZmRjNGdVQkJHU1VF?=
 =?utf-8?B?cW9KNWNsbGlESkV1ZmdPSnJIK210dkNTNkZKVUUzUXJqSUk3RTNTQVd0Mldz?=
 =?utf-8?B?WlMxWXBySTF3b2lFMHNRSEhUWEVRVUNnelZ2cVE5WVM5V2ZISHhHaTNqM0ZB?=
 =?utf-8?B?bUVHOGxQNzNFRXd3ckg0M2o4Y1ZIN1Y3SzNIaFlUTjJWQ0VvRjFiVFJqUDBx?=
 =?utf-8?B?RzBhYlB3OGYxZmF4MmNyaU1NM1pFVVZtWUdXOC9Rc3dGb3NNdTNISFV6dmJC?=
 =?utf-8?B?S1BaeGhUR09JTVJ1Z2NzdFJsMVVNU0MrMVBzOGNiWnpSVzk0SlJOY25PREdK?=
 =?utf-8?B?UWNYZWVzbk1XbjJPQjBZUTR4SnUzM2NRWlQ4ckVaR2Y1ejA2REcxU1VwT3or?=
 =?utf-8?B?TkZrc1p4NUxUMkhDRnBFSXgrNC9YOHVRb1A5N0ltZXFad0tZUVVTSkw5VkJ4?=
 =?utf-8?B?dncvWllLdy9ESWhQMXloZXp6ckppQVRLWnZxdlJ1dDQ0TXhFOGZKRytzR3JY?=
 =?utf-8?B?bk85R3A1am5RNk1Kd3ZpMWliZjAyc3RlVWRXZXU3ZEN6eUNsUldRQTh6TFJX?=
 =?utf-8?B?TTZjY25hM3RlYUJQU3BDblI2TnNCbEJsd01HOFIyREMzWjVxQ1Q0aDFUUGJQ?=
 =?utf-8?B?LzlvUTRNSWNIQWJZNmJQdUVFSVJBK3hFeWhDZVo0Y3hMVDhJWUFlZHZpM3Zq?=
 =?utf-8?B?bnNiVVBvZVBocWNoUU5ERmJuamhyNW8zNytoNTJ2ZHcvVm51RHp6TGNNRHVQ?=
 =?utf-8?B?NmpHdFphQ2VydFNEYzRJSm9BOFQ0L281aENybFp0NDRJN0lGbDROeloyRmxn?=
 =?utf-8?B?TjVTcWlOV2JZdktPa0JRRjc3VWZnQ3YzMVd0QVRQaU1sRjlRbEVFc1FJMnZr?=
 =?utf-8?B?YmhZU2hkTTFteUJKdnNrNm1mTFhEaGRCSEN2RzllSFd2MEIzU3p3MmNuUStN?=
 =?utf-8?B?MjlJWmkybGNGbnRxNmdVbys4UFJVOXNaSndYVG04bVJaeGZWTnFjMWlQeTRv?=
 =?utf-8?B?NkNWOERCZ1hSWWVYYTRCU3FhYWRKOTREWFRHN1JOTXFCdldZQVRTNjFtL1VS?=
 =?utf-8?B?VGlVRDBVTGxGaDFILzdKeCt4cFRRM2o3S2hCdExkN0ZoMCtKd0dlYndGeEo4?=
 =?utf-8?B?Zk0yVVVQWnBxR0xzQlc4UXRwUWVuVzdjd1FhTjg4QkRGY210VUFMOGZQZEtR?=
 =?utf-8?B?cFNadGxjU05jdGxQZTArUk54bHVUcEZjNHpGL3hENUVHRTVySjhObzdIMTBn?=
 =?utf-8?Q?rx2YfEmo1SrhIsqruqBN/apVN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E6D3AD3025FCB4FB8EE7790F74B48E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l+vILmL0vIofWHRawuqlZx1kjU2Zo2s5RUmFOPoEirUTFXeW5utNOQuRcKKZbys0EKTmbgEDDCF7iTsMH2fBe/f9p/E1XfNa5yAHDQMV4G8eiilpOES/0fUP8fLZtwvcfglc9tPt3avFVOTheKkU9yTpl+aOlIUH5Cfhd1mZPGiZe8iW3xDRBu0RRBtrUrfx5SwZ/T80JZX89F3K0vGivlGmJr4NBasuqKOeyY0phqCj4au9XEOmLagi0thFsnvNWk8+v5G99KrJ5eEdkWJqVuXIzOc0OirBog9YnCq1/vUCan263QGYxmCc++lz+uRwE5JLHwsd5jfHDa2SbCsb2icHAW7sKFm0hQYPjcqrNV/jtEyiPDTucCVv+9nSh0V3O+/ri/X77wFaYl+S4arZwqzyhQPeS/zyMaSknkVU7exoOdecGd3W7SOPPd4d3zE6bKRVu2+fQP9i5SZ+BnglG/aBFDyZ6QIPeX47xHxsUn1zfmjMca5CID4ww4wqSxE41kcWAcvNTgySKyAm0ZcYowivDkcEqezvS9HNzWwhYckOkGF9nQ/8d4eM1DWoJlamp3vglIMfJhoy64fNF/bHCw4Ox8OtInAG1AUrQsvELocUbQIiIILmjDgyBaQs2lUQCnfRzzdiPqotOJIgAPXnHw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa095ed-4c23-4a91-a271-08dcb66f81a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 23:28:41.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chkk2zDHIP02d548RRR4F4hRxvlizSXTMDR1Hag/FH+3d3RXglLqUDXLpA9TdXPo6LsN/nHUmrlaJrubqcQnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
X-Proofpoint-GUID: XFI4F9brAhlHwKLjgUjXI3GMdu7dUbjn
X-Proofpoint-ORIG-GUID: XFI4F9brAhlHwKLjgUjXI3GMdu7dUbjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_18,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060165

T24gU3VuLCBBdWcgMDQsIDIwMjQsIEt5bGUgVHNvIHdyb3RlOg0KPiBJdCBpcyBwb3NzaWJsZSB0
aGF0IHRoZSB1c2IgcG93ZXJfc3VwcGx5IGlzIHJlZ2lzdGVyZWQgYWZ0ZXIgdGhlIHByb2JlDQoN
ClNob3VsZCB3ZSBkZWZlciB0aGUgZHdjMyBwcm9iZSB1bnRpbCB0aGUgcG93ZXJfc3VwcGx5IGlz
IHJlZ2lzdGVyZWQNCnRoZW4/DQoNCj4gb2YgZHdjMy4gSW4gdGhpcyBjYXNlLCB0cnlpbmcgdG8g
Z2V0IHRoZSB1c2IgcG93ZXJfc3VwcGx5IGR1cmluZyB0aGUNCj4gcHJvYmUgd2lsbCBmYWlsIGFu
ZCB0aGVyZSBpcyBubyBjaGFuY2UgdG8gdHJ5IGFnYWluLiBBbHNvIHRoZSB1c2INCj4gcG93ZXJf
c3VwcGx5IG1pZ2h0IGJlIHVucmVnaXN0ZXJlZCBhdCBhbnl0aW1lIHNvIHRoYXQgdGhlIGhhbmRs
ZSBvZiBpdA0KDQpUaGlzIGlzIHByb2JsZW1hdGljLi4uIElmIHRoZSBwb3dlcl9zdXBwbHkgaXMg
dW5yZWdpc3RlcmVkLCB0aGUgZGV2aWNlDQppcyBubyBsb25nZXIgdXNhYmxlLg0KDQo+IGluIGR3
YzMgd291bGQgYmVjb21lIGludmFsaWQuIFRvIGZpeCB0aGlzLCBnZXQgdGhlIGhhbmRsZSByaWdo
dCBiZWZvcmUNCj4gY2FsbGluZyB0byBwb3dlcl9zdXBwbHkgZnVuY3Rpb25zIGFuZCBwdXQgaXQg
YWZ0ZXJ3YXJkLg0KDQpTaG91bGRuJ3QgdGhlIGxpZmUtY3ljbGUgb2YgdGhlIGR3YzMgbWF0Y2gg
d2l0aCB0aGUgcG93ZXJfc3VwcGx5PyBIb3cNCmNhbiB3ZSBtYWludGFpbiBmdW5jdGlvbiB3aXRo
b3V0IHRoZSBwcm9wZXIgcG93ZXJfc3VwcGx5Pw0KDQpCUiwNClRoaW5oDQoNCj4gDQo+IGR3YzNf
Z2FkZXRfdmJ1c19kcmF3IG1pZ2h0IGJlIGluIGludGVycnVwdCBjb250ZXh0LiBDcmVhdGUgYSBr
dGhyZWFkDQo+IHdvcmtlciBiZWZvcmVoYW5kIGFuZCB1c2UgaXQgdG8gcHJvY2VzcyB0aGUgIm1p
Z2h0LXNsZWVwIg0KPiBwb3dlcl9zdXBwbHlfcHV0IEFTQVAgYWZ0ZXIgdGhlIHByb3BlcnR5IHNl
dC4NCj4gDQo+IEZpeGVzOiA2ZjA3NjRiNWFkZWEgKCJ1c2I6IGR3YzM6IGFkZCBhIHBvd2VyIHN1
cHBseSBmb3IgY3VycmVudCBjb250cm9sIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU2lnbmVkLW9mZi1ieTogS3lsZSBUc28gPGt5bGV0c29AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+
IHYyIC0+IHYzOg0KPiAtIE9ubHkgbW92ZSBwb3dlcl9zdXBwbHlfcHV0IHRvIGEgd29yay4gU3Rp
bGwgY2FsbCBfZ2V0X2J5X25hbWUgYW5kDQo+ICAgX3NldF9wcm9wZXJ0eSBpbiBkd2MzX2dhZGdl
dF92YnVzX2RyYXcuDQo+IC0gQ3JlYXRlIGEga3RocmVhZF93b3JrZXIgdG8gaGFuZGxlIHRoZSB3
b3JrDQo+IA0KPiB2MSAtPiB2MjoNCj4gLSBtb3ZlIHBvd2VyX3N1cHBseV9wdXQgb3V0IG9mIGlu
dGVycnVwdCBjb250ZXh0DQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICB8IDI5ICsr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAg
fCAgNiArKysrLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA0MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNTIgaW5z
ZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCA3MzRkZTJh
OGJkMjEuLjgyYzgzNzYzMzBkNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTE2MzEsOCArMTYzMSw2
IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4g
IAl1OAkJCXR4X3Rocl9udW1fcGt0X3ByZCA9IDA7DQo+ICAJdTgJCQl0eF9tYXhfYnVyc3RfcHJk
ID0gMDsNCj4gIAl1OAkJCXR4X2ZpZm9fcmVzaXplX21heF9udW07DQo+IC0JY29uc3QgY2hhcgkJ
KnVzYl9wc3lfbmFtZTsNCj4gLQlpbnQJCQlyZXQ7DQo+ICANCj4gIAkvKiBkZWZhdWx0IHRvIGhp
Z2hlc3QgcG9zc2libGUgdGhyZXNob2xkICovDQo+ICAJbHBtX255ZXRfdGhyZXNob2xkID0gMHhm
Ow0KPiBAQCAtMTY2NywxMiArMTY2NSw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRp
ZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIA0KPiAgCWR3Yy0+c3lzX3dha2V1cCA9IGRldmljZV9t
YXlfd2FrZXVwKGR3Yy0+c3lzZGV2KTsNCj4gIA0KPiAtCXJldCA9IGRldmljZV9wcm9wZXJ0eV9y
ZWFkX3N0cmluZyhkZXYsICJ1c2ItcHN5LW5hbWUiLCAmdXNiX3BzeV9uYW1lKTsNCj4gLQlpZiAo
cmV0ID49IDApIHsNCj4gLQkJZHdjLT51c2JfcHN5ID0gcG93ZXJfc3VwcGx5X2dldF9ieV9uYW1l
KHVzYl9wc3lfbmFtZSk7DQo+IC0JCWlmICghZHdjLT51c2JfcHN5KQ0KPiAtCQkJZGV2X2Vycihk
ZXYsICJjb3VsZG4ndCBnZXQgdXNiIHBvd2VyIHN1cHBseVxuIik7DQo+IC0JfQ0KPiArCWRldmlj
ZV9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkZXYsICJ1c2ItcHN5LW5hbWUiLCAmZHdjLT51c2JfcHN5
X25hbWUpOw0KPiAgDQo+ICAJZHdjLT5oYXNfbHBtX2VycmF0dW0gPSBkZXZpY2VfcHJvcGVydHlf
cmVhZF9ib29sKGRldiwNCj4gIAkJCQkic25wcyxoYXMtbHBtLWVycmF0dW0iKTsNCj4gQEAgLTIx
MzIsMTkgKzIxMjUsMjQgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKGR3Yyk7
DQo+ICANCj4gKwlkd2MtPndvcmtlciA9IGt0aHJlYWRfY3JlYXRlX3dvcmtlcigwLCAiZHdjMy13
b3JrZXIiKTsNCj4gKwlpZiAoSVNfRVJSKGR3Yy0+d29ya2VyKSkNCj4gKwkJcmV0dXJuIFBUUl9F
UlIoZHdjLT53b3JrZXIpOw0KPiArCXNjaGVkX3NldF9maWZvKGR3Yy0+d29ya2VyLT50YXNrKTsN
Cj4gKw0KPiAgCWR3Yy0+cmVzZXQgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfYXJyYXlfZ2V0X29wdGlv
bmFsX3NoYXJlZChkZXYpOw0KPiAgCWlmIChJU19FUlIoZHdjLT5yZXNldCkpIHsNCj4gIAkJcmV0
ID0gUFRSX0VSUihkd2MtPnJlc2V0KTsNCj4gLQkJZ290byBlcnJfcHV0X3BzeTsNCj4gKwkJZ290
byBlcnJfZGVzdHJveV93b3JrZXI7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0ID0gZHdjM19nZXRfY2xv
Y2tzKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gLQkJZ290byBlcnJfcHV0X3BzeTsNCj4gKwkJZ290
byBlcnJfZGVzdHJveV93b3JrZXI7DQo+ICANCj4gIAlyZXQgPSByZXNldF9jb250cm9sX2RlYXNz
ZXJ0KGR3Yy0+cmVzZXQpOw0KPiAgCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyX3B1dF9wc3k7DQo+
ICsJCWdvdG8gZXJyX2Rlc3Ryb3lfd29ya2VyOw0KPiAgDQo+ICAJcmV0ID0gZHdjM19jbGtfZW5h
YmxlKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gQEAgLTIyNDUsOSArMjI0Myw4IEBAIHN0YXRpYyBp
bnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWR3YzNfY2xr
X2Rpc2FibGUoZHdjKTsNCj4gIGVycl9hc3NlcnRfcmVzZXQ6DQo+ICAJcmVzZXRfY29udHJvbF9h
c3NlcnQoZHdjLT5yZXNldCk7DQo+IC1lcnJfcHV0X3BzeToNCj4gLQlpZiAoZHdjLT51c2JfcHN5
KQ0KPiAtCQlwb3dlcl9zdXBwbHlfcHV0KGR3Yy0+dXNiX3BzeSk7DQo+ICtlcnJfZGVzdHJveV93
b3JrZXI6DQo+ICsJa3RocmVhZF9kZXN0cm95X3dvcmtlcihkd2MtPndvcmtlcik7DQo+ICANCj4g
IAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBAQCAtMjI1OCw2ICsyMjU1LDcgQEAgc3RhdGljIHZvaWQg
ZHdjM19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCXBtX3J1
bnRpbWVfZ2V0X3N5bmMoJnBkZXYtPmRldik7DQo+ICANCj4gKwlrdGhyZWFkX2Rlc3Ryb3lfd29y
a2VyKGR3Yy0+d29ya2VyKTsNCj4gIAlkd2MzX2NvcmVfZXhpdF9tb2RlKGR3Yyk7DQo+ICAJZHdj
M19kZWJ1Z2ZzX2V4aXQoZHdjKTsNCj4gIA0KPiBAQCAtMjI3Niw5ICsyMjc0LDYgQEAgc3RhdGlj
IHZvaWQgZHdjM19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlwbV9y
dW50aW1lX3NldF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ICANCj4gIAlkd2MzX2ZyZWVfZXZl
bnRfYnVmZmVycyhkd2MpOw0KPiAtDQo+IC0JaWYgKGR3Yy0+dXNiX3BzeSkNCj4gLQkJcG93ZXJf
c3VwcGx5X3B1dChkd2MtPnVzYl9wc3kpOw0KPiAgfQ0KPiAgDQo+ICAjaWZkZWYgQ09ORklHX1BN
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+IGluZGV4IDFlNTYxZmQ4Yjg2ZS4uM2ZjNTgyMDRkYjZlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaA0KPiBAQCAtOTkzLDYgKzk5Myw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkg
ew0KPiAgLyoqDQo+ICAgKiBzdHJ1Y3QgZHdjMyAtIHJlcHJlc2VudGF0aW9uIG9mIG91ciBjb250
cm9sbGVyDQo+ICAgKiBAZHJkX3dvcms6IHdvcmtxdWV1ZSB1c2VkIGZvciByb2xlIHN3YXBwaW5n
DQo+ICsgKiBAd29ya2VyOiBkZWRpY2F0ZWQga3RocmVhZCB3b3JrZXINCj4gICAqIEBlcDBfdHJi
OiB0cmIgd2hpY2ggaXMgdXNlZCBmb3IgdGhlIGN0cmxfcmVxDQo+ICAgKiBAYm91bmNlOiBhZGRy
ZXNzIG9mIGJvdW5jZSBidWZmZXINCj4gICAqIEBzZXR1cF9idWY6IHVzZWQgd2hpbGUgcHJlY2Vz
c2luZyBTVEQgVVNCIHJlcXVlc3RzDQo+IEBAIC0xMDQ1LDcgKzEwNDYsNyBAQCBzdHJ1Y3QgZHdj
M19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAqIEByb2xlX3N3OiB1c2Jfcm9sZV9zd2l0Y2ggaGFu
ZGxlDQo+ICAgKiBAcm9sZV9zd2l0Y2hfZGVmYXVsdF9tb2RlOiBkZWZhdWx0IG9wZXJhdGlvbiBt
b2RlIG9mIGNvbnRyb2xsZXIgd2hpbGUNCj4gICAqCQkJdXNiIHJvbGUgaXMgVVNCX1JPTEVfTk9O
RS4NCj4gLSAqIEB1c2JfcHN5OiBwb2ludGVyIHRvIHBvd2VyIHN1cHBseSBpbnRlcmZhY2UuDQo+
ICsgKiBAdXNiX3BzeV9uYW1lOiBuYW1lIG9mIHRoZSB1c2IgcG93ZXIgc3VwcGx5IGludGVyZmFj
ZQ0KPiAgICogQHVzYjJfcGh5OiBwb2ludGVyIHRvIFVTQjIgUEhZDQo+ICAgKiBAdXNiM19waHk6
IHBvaW50ZXIgdG8gVVNCMyBQSFkNCj4gICAqIEB1c2IyX2dlbmVyaWNfcGh5OiBwb2ludGVyIHRv
IGFycmF5IG9mIFVTQjIgUEhZcw0KPiBAQCAtMTE2Myw2ICsxMTY0LDcgQEAgc3RydWN0IGR3YzNf
c2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKi8NCj4gIHN0cnVjdCBkd2MzIHsNCj4gIAlzdHJ1Y3Qg
d29ya19zdHJ1Y3QJZHJkX3dvcms7DQo+ICsJc3RydWN0IGt0aHJlYWRfd29ya2VyCSp3b3JrZXI7
DQo+ICAJc3RydWN0IGR3YzNfdHJiCQkqZXAwX3RyYjsNCj4gIAl2b2lkCQkJKmJvdW5jZTsNCj4g
IAl1OAkJCSpzZXR1cF9idWY7DQo+IEBAIC0xMjIzLDcgKzEyMjUsNyBAQCBzdHJ1Y3QgZHdjMyB7
DQo+ICAJc3RydWN0IHVzYl9yb2xlX3N3aXRjaAkqcm9sZV9zdzsNCj4gIAllbnVtIHVzYl9kcl9t
b2RlCXJvbGVfc3dpdGNoX2RlZmF1bHRfbW9kZTsNCj4gIA0KPiAtCXN0cnVjdCBwb3dlcl9zdXBw
bHkJKnVzYl9wc3k7DQo+ICsJY29uc3QgY2hhcgkJKnVzYl9wc3lfbmFtZTsNCj4gIA0KPiAgCXUz
MgkJCWZsYWRqOw0KPiAgCXUzMgkJCXJlZl9jbGtfcGVyOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXgg
ODlmYzY5MGZkZjM0Li4xZmY1ODMyODFlZmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMzAs
NiArMzAsMTEgQEANCj4gICNkZWZpbmUgRFdDM19BTElHTl9GUkFNRShkLCBuKQkoKChkKS0+ZnJh
bWVfbnVtYmVyICsgKChkKS0+aW50ZXJ2YWwgKiAobikpKSBcDQo+ICAJCQkJCSYgfigoZCktPmlu
dGVydmFsIC0gMSkpDQo+ICANCj4gK3N0cnVjdCBkd2MzX3BzeV9wdXQgew0KPiArCXN0cnVjdCBr
dGhyZWFkX3dvcmsgd29yazsNCj4gKwlzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpwc3k7DQo+ICt9Ow0K
PiArDQo+ICAvKioNCj4gICAqIGR3YzNfZ2FkZ2V0X3NldF90ZXN0X21vZGUgLSBlbmFibGVzIHVz
YjIgdGVzdCBtb2Rlcw0KPiAgICogQGR3YzogcG9pbnRlciB0byBvdXIgY29udGV4dCBzdHJ1Y3R1
cmUNCj4gQEAgLTMwNDcsMjIgKzMwNTIsNDkgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfc2V0
X3NzcF9yYXRlKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dh
ZGdldF9wc3lfcHV0KHN0cnVjdCBrdGhyZWFkX3dvcmsgKndvcmspDQo+ICt7DQo+ICsJc3RydWN0
IGR3YzNfcHN5X3B1dAkqcHN5X3B1dCA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgZHdjM19w
c3lfcHV0LCB3b3JrKTsNCj4gKw0KPiArCXBvd2VyX3N1cHBseV9wdXQocHN5X3B1dC0+cHN5KTsN
Cj4gKwlrZnJlZShwc3lfcHV0KTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX2dhZGdl
dF92YnVzX2RyYXcoc3RydWN0IHVzYl9nYWRnZXQgKmcsIHVuc2lnbmVkIGludCBtQSkNCj4gIHsN
Cj4gLQlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGdhZGdldF90b19kd2MoZyk7DQo+ICsJc3RydWN0IGR3
YzMJCQkqZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gKwlzdHJ1Y3QgcG93ZXJfc3VwcGx5CQkq
dXNiX3BzeTsNCj4gIAl1bmlvbiBwb3dlcl9zdXBwbHlfcHJvcHZhbAl2YWwgPSB7MH07DQo+ICsJ
c3RydWN0IGR3YzNfcHN5X3B1dAkJKnBzeV9wdXQ7DQo+ICAJaW50CQkJCXJldDsNCj4gIA0KPiAg
CWlmIChkd2MtPnVzYjJfcGh5KQ0KPiAgCQlyZXR1cm4gdXNiX3BoeV9zZXRfcG93ZXIoZHdjLT51
c2IyX3BoeSwgbUEpOw0KPiAgDQo+IC0JaWYgKCFkd2MtPnVzYl9wc3kpDQo+ICsJaWYgKCFkd2Mt
PnVzYl9wc3lfbmFtZSkNCj4gIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiAgDQo+ICsJdXNiX3Bz
eSA9IHBvd2VyX3N1cHBseV9nZXRfYnlfbmFtZShkd2MtPnVzYl9wc3lfbmFtZSk7DQo+ICsJaWYg
KCF1c2JfcHN5KSB7DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJjb3VsZG4ndCBnZXQgdXNiIHBv
d2VyIHN1cHBseVxuIik7DQo+ICsJCXJldHVybiAtRU5PREVWOw0KPiArCX0NCj4gKw0KPiAgCXZh
bC5pbnR2YWwgPSAxMDAwICogbUE7DQo+IC0JcmV0ID0gcG93ZXJfc3VwcGx5X3NldF9wcm9wZXJ0
eShkd2MtPnVzYl9wc3ksIFBPV0VSX1NVUFBMWV9QUk9QX0lOUFVUX0NVUlJFTlRfTElNSVQsICZ2
YWwpOw0KPiArCXJldCA9IHBvd2VyX3N1cHBseV9zZXRfcHJvcGVydHkodXNiX3BzeSwgUE9XRVJf
U1VQUExZX1BST1BfSU5QVVRfQ1VSUkVOVF9MSU1JVCwgJnZhbCk7DQo+ICsJaWYgKHJldCA8IDAp
IHsNCj4gKwkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBzZXQgcG93ZXIgc3VwcGx5IHBy
b3BlcnR5XG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICANCj4gLQlyZXR1cm4gcmV0
Ow0KPiArCXBzeV9wdXQgPSBremFsbG9jKHNpemVvZigqcHN5X3B1dCksIEdGUF9BVE9NSUMpOw0K
PiArCWlmICghcHN5X3B1dCkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsJa3RocmVhZF9pbml0
X3dvcmsoJnBzeV9wdXQtPndvcmssIGR3YzNfZ2FkZ2V0X3BzeV9wdXQpOw0KPiArCXBzeV9wdXQt
PnBzeSA9IHVzYl9wc3k7DQo+ICsJa3RocmVhZF9xdWV1ZV93b3JrKGR3Yy0+d29ya2VyLCAmcHN5
X3B1dC0+d29yayk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IC0t
IA0KPiAyLjQ2LjAucmMyLjI2NC5nNTA5ZWQ3NmRjOC1nb29nDQo+IA==

