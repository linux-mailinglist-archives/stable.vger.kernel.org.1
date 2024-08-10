Return-Path: <stable+bounces-66296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF694D99E
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 02:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4234B21C78
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0322083;
	Sat, 10 Aug 2024 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SX8kWSR/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A397ggio";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IRrtmxsJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3831CFB6;
	Sat, 10 Aug 2024 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251436; cv=fail; b=PnO4PD14DN81goc99rUudTxUu93XdiA+MQRHdrsYfXoDz+z4skopPhHEMi9mtD31iW6X4heB0nwhO06IKwY384HlJ2cQ7mqnlQoyX0jE2LpvpQHekq00Q8fYFpb7a19Vz864qSkZreFYP3Ixotl7oHAaL2cVJ9F6dMJvh/maZyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251436; c=relaxed/simple;
	bh=HO2qTVVqQl1eIeS+cJm5PnmWYJ6g3lYNtDFMo3VLtnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLsTeXCA8VAIjoO71vNayuiaTMY4XTWUxDb3BLyjyyvfH8jwt3XdIja3uZymi+lGf49EK5gKBGRMGRB5gW3M+HPomN6gZjIak0EgmXwR6wZed26jkJm4ohFzpBEPHAFokRdH0g7hmtS8C6rUMZOuGs8pCgMEyuy+Mu6mHxPPlXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SX8kWSR/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=A397ggio; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IRrtmxsJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479MC2Z5021890;
	Fri, 9 Aug 2024 17:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=HO2qTVVqQl1eIeS+cJm5PnmWYJ6g3lYNtDFMo3VLtnw=; b=
	SX8kWSR/V3vw2lLMYZ5+PUTi5zny851PNmEIIzlDRdcKHIvb7W0Yl4e3Hz3uF2TF
	7/ctKj9yRinXDjstvnNTEY+vUJ1dm16j0vkq7wvKkkqIniY1Jsr0qOvAj6nnsEcc
	it6/g7pNfgP0pr8SACA7LcoyVaYRKSrSujO7yWdngbKK1/UD0KW7V4AB8FuQ4s75
	ZNN6cvxVaK33F/W2WAI/jBrxom/PqTdffD0nKwOXzLAYVwBf6ojy7tIeJ4LUbzzb
	Rjogy2HJCUSVkeMObdcw/wMa35NPOl/Qjl0IPsNXgR0R/1+1JEmEYK0DcQI/Oetk
	6DTtVnzVyf1CC9xwR8EoYA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujatjw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 17:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723251412; bh=HO2qTVVqQl1eIeS+cJm5PnmWYJ6g3lYNtDFMo3VLtnw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=A397ggioXipdchXsssEfc98MHpz2pcoQXAWgLoS8svC8o2NEqzSer2Yj9gtHmTpl0
	 olcHfeeivNrhnSv+gaIKbX+IHvEoThfwgrxVz0Tq+myKmQUnNwmOb1Vba84rocEAoB
	 Jxwd1bO9lIStXU7l69t7HPkQwX39yOBZYDzsyUKuh2CVxEJGqS5sKZx95hK6tj98iX
	 Npc4ojx9ccZ8i+O4xtlC6EsUnH2tk7rqKxZ/nVHUrcW9ErMvFccg1s8uee1JgrEVHf
	 GQhj1FAcqWV3s8/OYMFgcXIIUXsxgUaAJK1FYlEzo1zCbTx0Ts31+0P484t7Uv1iJS
	 PuRDJq/Fs08Gg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 277994028D;
	Sat, 10 Aug 2024 00:56:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CB630A00A3;
	Sat, 10 Aug 2024 00:56:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IRrtmxsJ;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 03BE8405A9;
	Sat, 10 Aug 2024 00:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR+emUhqBAUTGePv1Lb89CkF6bTqP/OBOZD3NMdIT1jJljtPeGyrMb0pZpzLpkEzOt5n7Njr5D4C0Zmftt30cFEbT3vrEz9XYUVlTrbtegYqjvuhb9qIWLac0OLnkI4P9D6DjdKZleE1NKrdqG/ICbTHLOshc11z6KlGcdDjSgMpJ/GVjYUQ5rcRJPNw4XcLui+xpZYLaqHgGPCQJiQCJDKI6I057+2OAPeODcjAo3hq+Qpgg9Fettrf22rnttd2hPJyZrDeP/luI+kDlfIBHVFZkbK8kmK2m3cnNceKKMgsDhq64/At+TuDgAKMNZirKXIdbuVfojBzT0Fto/acCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO2qTVVqQl1eIeS+cJm5PnmWYJ6g3lYNtDFMo3VLtnw=;
 b=RcRPVl2Ro6PV+34h95YuLUtDQuTljnzJJS+X2vw1ZwZ7gcUkva812+jHn1kT6NLkL9y86W4Ba6tnNpbxiYozyt6FnOMl+rDMCMiO8wtRsNvpfYWxMeThttFlzroD88IMMdBbFZZW5/6Dd/uPQvuoyfe95YiYJKCZfKBNyWDvYXZyGYCmXu2svZeONmlvSlEpdRFIhOwZxViuY5MM1eXeqCwoy8zJVeSmHhwcyYd98ka7EN/73hw2OysBJRIkezw2MmztBN0Ms7LMK5uwhPVdTj3DWLUfRZy7cBYVfcJZrSe0TOlkBrxT0RBciZDNXxK2WMCz7xQmY+geJuO2KnIaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO2qTVVqQl1eIeS+cJm5PnmWYJ6g3lYNtDFMo3VLtnw=;
 b=IRrtmxsJkKU9qPXeeIo9zXS2vMH5Pad9HYfMLxQIZX3JP6Qg9YFCQoGoEpsaBlTJJ4ULLLvEgVs30RoNSszzt41NEC3JfRli10Mt9728nX/1Y5PtUWJJ4whpicI86FzEMUMRxbbjnCgwwpG00ArRNHAB+SPCjAQqeoAXnus6c4g=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sat, 10 Aug
 2024 00:56:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.014; Sat, 10 Aug 2024
 00:56:46 +0000
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
Thread-Index: AQHa5krbJOjr5sXVeUWyTPcKNhufO7Ia5CIAgABVFgCAAWFSgIAAwdGAgAJXWQA=
Date: Sat, 10 Aug 2024 00:56:46 +0000
Message-ID: <20240810005634.6ig2e3hdsgx3wkan@synopsys.com>
References: <20240804084612.2561230-1-kyletso@google.com>
 <20240806232836.52rkn7u3g5uiotn3@synopsys.com>
 <CAGZ6i=1v6+Jt3Jecd3euNnumVK781U9DQvRz7cHWnxi8Ga6W=g@mail.gmail.com>
 <20240808013743.tgvfjqgdtxluz52i@synopsys.com>
 <CAGZ6i=3aLx2h_cqes+=EN8JCCgiJVjRKHHXvA54gcq5WKhUnCg@mail.gmail.com>
In-Reply-To:
 <CAGZ6i=3aLx2h_cqes+=EN8JCCgiJVjRKHHXvA54gcq5WKhUnCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CYXPR12MB9425:EE_
x-ms-office365-filtering-correlation-id: 741ed4f1-2e21-478a-5eb8-08dcb8d74ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUNtdGdLVDU2Uks2ekpZNGkwWWs2NVY1c1M4V1VENm95eEZsVSswM2NFcWhZ?=
 =?utf-8?B?NjhJdU1ZZGhGOE1nVkFTZ0pscHhrODF3d1lWYkdvZm9UTkJ3dFFjNGtKZkJo?=
 =?utf-8?B?Mi96T2ZaMCtYVVA5bmIzSnZoTWh1R2o0OWY5aThxNTZobUF2M3EwV1FnRkFw?=
 =?utf-8?B?eFZoZEN3d00vY083MEh4MkJNTHJla0RMbzJuei9DRjR3SmlLWVgzdVB4THQx?=
 =?utf-8?B?dW9mejQwaU0zTEhGeEtWVkNhQi95M2NUS0lJN0NVMmtNYm5RekJXQ1VDdElv?=
 =?utf-8?B?Qlcxcmc5eDQ2MTNFWmVkdEpiTkJtR1d6VnltNk1PU29UVWhnbWk5bEJKZkho?=
 =?utf-8?B?ZEk3MHFiRGxoUyt4WjZXMzRJbXNOMUJGWjFRaTFTQVBrdGZzVnRmYU96L1hF?=
 =?utf-8?B?UUJoc0NqR216SG4xekJXZ1o4VTJpYThHNFZLRlpQRmhHK2h4YkRmY3VpVnc2?=
 =?utf-8?B?YllraXdwcmNncDZPaGtzNFpJdXJaMlQwNGIzbmVYbmdTdk9SMTg1ejBnZjlz?=
 =?utf-8?B?TG93OCszb2RPeDduajRxZzB6WFliUzB1TnNuMU96c0ZCN3F5N2dnWXJHalps?=
 =?utf-8?B?L2hraW5uSjEzczVqbm5IVFJKZGIwbHhDanpjMDZhVTQvcU92a21tTWplWWVo?=
 =?utf-8?B?VjFWUzluL1VWSGZwS3Z6a0thWE5MK1YxUkJFbEhmbFJUdnc5Yk9WSkkwbTBM?=
 =?utf-8?B?SVJYMUlRYWsyYzB6L1hiZ0hLTnhSNzgvL3hlWlRQdWZrVUd5Yis3QjgvRnZs?=
 =?utf-8?B?S290NVprMjhoSmlUNU1sNjFvVDRHaHhJbS83SHp4QkUybzg5SzNGYTZqNnFI?=
 =?utf-8?B?djUwaDdlekRPYzd1bHBJMi80RC9sYTVYQVE0Vk5IOFZMVklreTNrNTdjSHg3?=
 =?utf-8?B?K3dVc3ZYT3VoQ2NWbThKQ3JWNG9IYWNYelM1WVByVzRaMVh2N0ozNkMycFM5?=
 =?utf-8?B?T3NJaWR3S3ZXZVQ3K2xZWjNnYU1taW1qaWt0OWd3d3REQzJyQkFPTEl4WnV2?=
 =?utf-8?B?SURPdDM2WTFNZFgvRHkwOUVlU3VyNWZDZWloclpCalNhYml2L1FFNit0UGw4?=
 =?utf-8?B?YVIvdWZXQkRKTVF6dWU2T0Q0YUQvaWZSZEtUeVdzdEV2T05vOXdiUDV4Zks0?=
 =?utf-8?B?aG9IOVJXS21DK0s4eW9CbHNIS2gvVjZJVGRxWEw3TjdialovblFJcmkrdk5n?=
 =?utf-8?B?cVlMMFc5bG5aekJ2bEgzS2d6ZTY1NHpGZjZESStXM3d1SnhNcmc5WHpDNUVX?=
 =?utf-8?B?WVlUK1l0TGpGTmpBMmdqWlBmd01OVE1iRVd6QWxqdVBEY1BjQVUzWUVwSG4w?=
 =?utf-8?B?TmlZeTh3VHNRUzU3bG12WWtvRStzdE8wRzNvc0VWS0FPTWtrWk1HUzhnTXRV?=
 =?utf-8?B?bmxiTzZmbENCU01RRTk5bHlvY3k2TDNwZUFHNkw4a1hWRVRzSE9wWnd6N01Z?=
 =?utf-8?B?K2x1cDh3VW5sbnhxMnRONXBQRkZpMXJSZ05WbjI0VThzdE9Kb0lDNDVUT0VP?=
 =?utf-8?B?K1ZxQ0thK1BmUjhINTZLbzc1bHdFSkFVTkxZUXNyK1ZQWGNHR2JsOUx0TVd0?=
 =?utf-8?B?ait0WWtIOXp3aC85SkxwZWF6aWMxMStENkxLSEUwVEJwZmlVV0NwY1Y2WTc5?=
 =?utf-8?B?UGQ1eUVoRmVEeGhqblIwSC9aLy82UWMybmNsUit0MHkxZWR6MFZxRGFxVHRv?=
 =?utf-8?B?R3BSdzNPVUNyYmFGdUlsWnB3TzNXYUkwek1qK254djlkQ0FncWVvblFjU2VW?=
 =?utf-8?B?aldvQWpwRmhoUWhieW92MVlRNTMrMWNhbmpkalI1UnR5SkQvdmhPKzB2STM4?=
 =?utf-8?B?TkV0ZjlaQzczWDl3L1cxa0NnYWdkem9RZjhIMzhEejZOaWU3V203YVJtZ1Nl?=
 =?utf-8?B?YXN4NGh3ZW1sc2hvK1JQSnUxaHVmcFpHV3IyWFRRaGtTcGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjVnTDFzWVZqNUcvMCt5VktaTXFvY0NNYmo1UUJwS1dPUkZaWk0xTEdHYWFw?=
 =?utf-8?B?QVQrTlVSMDJHclhDaXZqcHpOWUdBNEFXV1JQRGlvbGhJUVlUQTY2cUJqa3No?=
 =?utf-8?B?SjBrQmg0SHFPaElWY1BLcmpIRjVxNGIvbzh0NG5INDZ4QTc2WEJMMHRnSG9Q?=
 =?utf-8?B?S0dUcGZJWmo0WFNmMHJ0blJ5aTM3ZmFrRG5WVUg2NndsbGZCS0FNbFJNZ3dD?=
 =?utf-8?B?RTJ2VmFyKzR2OWR6SW12bDRvbEpZMXpmT1laMWFyMlBVWTN0NjI1SGFzdlRh?=
 =?utf-8?B?SWxlUVh3eVdsdGJrTkxGc1ZYVUFZM1lCMnRqbE9iVC9FUjJYU0dHcG53SDVr?=
 =?utf-8?B?a3pXYXBRekVNZFBqR3pYYnZPcFExM1k4QWxubTFRcytpOHNXcFM0b0o1c2hs?=
 =?utf-8?B?WEExQ1M3ZnZDRlBjRTAyQmdtcm1KK0lUZHFvTFZ5T2djVjRvemppWitta2JL?=
 =?utf-8?B?Vm11WG5ZdkwyV2s0ZEg2dHVDTzRINGhtODFnVU5UM1E2ZkFLNnBYTFNydkxE?=
 =?utf-8?B?TW1JSFVOdWRQamdUS0oxWTJ0WVp5T1NQODJVQy9JemtuRDZ2N0Ryd2pMbTda?=
 =?utf-8?B?a3lacVgvYjVXQVUyZWFvQlhJcHBoRUlsRzJtZ2EzSXdLSHJiU1ZpMi9Wa0di?=
 =?utf-8?B?OFZHdTBGUWRvV2svQ2kzRGJVL1RUSWhzVnhvaFBqL2xvTFVYVFJ3Ry9pc0JO?=
 =?utf-8?B?Z0ZtK3d6OU1KYUNqQXkvUjFVUjZCcXdmdklNK1dDVEhBSDNuQ3FabkdTZTNU?=
 =?utf-8?B?T3hzamYybjZxQU1mVHNZRWxKZzdlSFJHTndZMlFoUzZGeWdCOFM5RGFuSXBB?=
 =?utf-8?B?WGVVSmZPY0RTRXByeDNBaGMrT05pamgxWmpGVE13Q2h2aitGUjlzVlpEb2tp?=
 =?utf-8?B?cTVMbDA4MFRkMlRjdXdBcVdZcjc5TnBYcXZoN0FIdFMvcklncXhWOXdIRnU2?=
 =?utf-8?B?QjlzUEx4bkFUV0hDSlpIbXVGVmNuWWlxck1Cb0taQzh5OGFFTmtob1JWMnp0?=
 =?utf-8?B?M05xV0RnR1pRcUZSTWtEMWlaVTNranJPQXorYTVUU0N5Sk9BQ1QzZGRtNE5n?=
 =?utf-8?B?TURJS2pnQlJRWGxCTzdTNVMyT1ZJZHEvMWRqWjdtUWlNVS9Mak1od0RPMHpT?=
 =?utf-8?B?N1VvdERJc3NFS291YTZOb0gweTI5Ky9veloxeVNqaHBDUEtiSWNzVWlkTXYy?=
 =?utf-8?B?TGUwMzYyNGJ6R1JCL2J3azhFS1pmellXL3ZhOGoyWEtiVkpNNHg1VHJiR2dS?=
 =?utf-8?B?UVFUd0JMemliOUE1NnNNUUQ2UFRja2N4a21kZFF5bGtZbDlzWk1UL0FUeTVR?=
 =?utf-8?B?Mi9RTVo0ZjcybDJwKzdJeVZHOWVCYUZIVmIzcVNMOGNDM3l3clYvaUIvdUUx?=
 =?utf-8?B?MGJRdnJIMVJKblNRWTZaczFrL0d3Q08zNDc0RDBoWEs0UjAwc3I0cVFqRUE1?=
 =?utf-8?B?cGowZXpoVVdEWElaV0pnTW5sZEZtRTBpTEFwQ3o1SWF4SkwzYUcxMG4wZGR2?=
 =?utf-8?B?bTBlVW1ZNDMxTk1oaDRDK1BaVlFVRWh5bXRoWjIwVkducEFCdE9ZOEdvYkZl?=
 =?utf-8?B?Vmp5V2pXZWkrVHdRZWZnOGVickUyQjlpOTNQLzArZzV3K1QvckloMUZuKzdw?=
 =?utf-8?B?LzU5VHFWcC81WWROaTlUeENPNTh1MEpneUtwNUcyL2VpQ1NPZCtKT2VBUEd2?=
 =?utf-8?B?eGY5U0ZSYnUxdTZWa0RkSDBxOWJrNHY0d2laUVVLK3AxR1NDZDl4U1BPY0pm?=
 =?utf-8?B?YTFqNnY1dVRtVitWaEI4cXdLN3FuajRjMHNhbSszQlkydWFsUiswRW5sdlV5?=
 =?utf-8?B?Q0p1N045VXMvbmhNem5yTEw2cjNUTG9KaUpGd0MxR1BLVHdPcmRqZ05aVUlW?=
 =?utf-8?B?MXVvbWxrRDhnSjdZMzBkMytIVFpvc2paTkVoejJ0OStVemIwNWpZQlVmZ1ky?=
 =?utf-8?B?YWtnczhYRVBoUXQ4U2dJWnMrNDR0QktIcWY0M3FYZ3F2QTB0bkNHV1d5aXFN?=
 =?utf-8?B?azJsRTBKSU1TZ2NETENqYjBWTitnKzM1blNsdUlKenMzZ2ZVSUZmb2Y0azJ4?=
 =?utf-8?B?eEdPUXFnRkpHRGh5Z2p3T2U1UTJsN00wOVVNcEtnV2g2dkRZMjEvK2xsKzZr?=
 =?utf-8?B?RWo3ZEU2R0VQUDVabmlRNEhxS2lQVm1FSk5GaGw2WERHM0c0ZmtmUVY2N2pn?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43136FE159D2544A5A1F44DC7DDE3A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+aPNBmbSxB2nOm+JDkfSi1JJnZ6zXBz57+sD8JWG/dI/dClZlYxu+lEIB5mO7l9PySvvl7ckIMPIYtw9K0dnrPRDk9+tU59/wCFiAwZDTvSLRbNMojWTYvRIBj0/IbqizXSVNFUzXMN2EXrH7coKq+tb24Tlyc55M9txKPB4gcQo9Xw3u8aYRZeDLv4Zu/orWhUdXGXKmaXBLJcdM9Fsbh+v6v3S9hDbcRPoCxgG3r2oJf5cWVyU3pXnv0CFwiTmUPxd+j18AkNVMCq3UMDkUNYIz19yWmNSQnjB5ydtl54A9JMaib1ga0UfPIc/bpJK7x1a+GA+Yl+X3Sj1Vg0EExAkp6JoD3y1ED14KS68mHe1j1kVenNKBr6KDDVC4MJNPxkHP1Te+CPb+MSZvtjql3BjWRZFy2OdBnIsC2W5XNazNcCHQpl2BCacewjg8wifo62PkZFgcUwo3l3HcSo5p5AqGtGglII+di1jT0IvyNtzCedTHLgcxRLSP0IxXyHEq35hrfJmasqlZw7GahBVTD4EITvrHqbO1NbwqMLKwo/2v1rb3spoAvrGh40Cv3TBIplutdkg++Um1eSwjnOiPlGm9nU4M5FKoy3Y9KPnHQCk2ijiZWwCeiSVrSU+gMnlVMF1rQwdr2HiY5JcW/Ff0Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741ed4f1-2e21-478a-5eb8-08dcb8d74ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 00:56:46.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XMocvL+Ddj/iBC/EMLrDc0vyL6T07DUryQBnfJ/46BlzEYMdUQaqpzPOtgpgN3sIVFXvW7PC6FFVvMrTW+CXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
X-Proofpoint-GUID: nFjn_vAfFIZusBUZ7O05d49hd86gdGkW
X-Proofpoint-ORIG-GUID: nFjn_vAfFIZusBUZ7O05d49hd86gdGkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_20,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408100005

T24gVGh1LCBBdWcgMDgsIDIwMjQsIEt5bGUgVHNvIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyA4LCAy
MDI0IGF0IDk6MzjigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBBdWcgMDcsIDIwMjQsIEt5bGUgVHNvIHdyb3RlOg0K
PiA+ID4gT24gV2VkLCBBdWcgNywgMjAyNCBhdCA3OjI54oCvQU0gVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gU3VuLCBB
dWcgMDQsIDIwMjQsIEt5bGUgVHNvIHdyb3RlOg0KPiA+ID4gPiA+IEl0IGlzIHBvc3NpYmxlIHRo
YXQgdGhlIHVzYiBwb3dlcl9zdXBwbHkgaXMgcmVnaXN0ZXJlZCBhZnRlciB0aGUgcHJvYmUNCj4g
PiA+ID4NCj4gPiA+ID4gU2hvdWxkIHdlIGRlZmVyIHRoZSBkd2MzIHByb2JlIHVudGlsIHRoZSBw
b3dlcl9zdXBwbHkgaXMgcmVnaXN0ZXJlZA0KPiA+ID4gPiB0aGVuPw0KPiA+ID4gPg0KPiA+ID4N
Cj4gPiA+IFdlIGNhbiBkbyB0aGF0LCBidXQgZ2V0dGluZyB0aGUgcG93ZXJfc3VwcGx5IHJlZmVy
ZW5jZSBqdXN0IGJlZm9yZQ0KPiA+ID4gdXNpbmcgdGhlIHBvd2VyX3N1cHBseSBBUElzIGlzIHNh
ZmVyIGJlY2F1c2Ugd2UgZG9uJ3QgcmlzayB3YWl0aW5nIGZvcg0KPiA+ID4gdGhlIHJlZ2lzdHJh
dGlvbiBvZiB0aGUgdXNiIHBvd2VyX3N1cHBseS4gSWYgdmJ1c19kcmF3IGlzIGJlaW5nIGNhbGxl
ZA0KPiA+DQo+ID4gSSdtIGEgYml0IGNvbmZ1c2VkLCB3b3VsZG4ndCB3ZSBuZWVkIHRoZSBwb3dl
cl9zdXBwbHkgdG8gYmUgcmVnaXN0ZXJlZA0KPiA+IGJlZm9yZSB5b3UgY2FuIGdldCB0aGUgcmVm
ZXJlbmNlLiBDYW4geW91IGNsYXJpZnkgdGhlIHJpc2sgaGVyZT8NCj4gPg0KPiANCj4gSSBrbm93
IGl0J3Mgd2VpcmQsIGJ1dCB1c2IgcG93ZXJfc3VwcGx5IG1vZHVsZSBpcyBub3QgZ3VhcmFudGVl
ZCB0byBiZQ0KPiBsb2FkZWQgd2hpbGUgZHdjMyBpcyBiZWluZyBwcm9iZWQuIFdoYXQgaWYsIGZv
ciBleGFtcGxlLCBpdCByZXF1aXJlcw0KPiB1c2Vyc3BhY2UgdG8gbWFudWFsbHkgbG9hZCB0aGUg
dXNiIHBvd2VyX3N1cHBseSBtb2R1bGUuIElmIHdlIGRlZmVyDQo+IHRoZSBwcm9iZSBqdXN0IHRv
IHdhaXQgZm9yIHRoZSB1c2IgcG93ZXJfc3VwcGx5LCBpdCBtaWdodCBiZSB3YWl0aW5nDQo+IGZv
ciBhIGxvbmcgdGltZS4NCg0KWW91IHN0aWxsIGhhdmUgbm90IGNsYXJpZmllZCB3aGF0IHRoZSBy
aXNrIGlzLiBIb3cgZG9lcyAid2FpdGluZyBmb3IgYQ0KbG9uZyB0aW1lIiBpbXBhY3QgdGhlIGRl
dmljZSBmdW5jdGlvbmFsaXR5Pw0KDQpJJ20gbm90IHN1cmUgaWYgdGhlcmUncyBhIGNhc2Ugd2hl
cmUgdGhlcmUncyBwb3dlcl9zdXBwbHkgc3BlY2lmaWVkIGluDQp0aGUgZGV2aWNldHJlZSBidXQg
dGhlIGR3YzMgc2hvdWxkIG5vdCBjYXJlIHdoZXRoZXIgaXQncyBhdmFpbGFibGUuDQpJIG5lZWQg
Y2xhcmlmaWNhdGlvbiBpZiB0aGVyZSdzIGFjdHVhbGx5IGFuIGFjdHVhbCBkZXZpY2UgbGlrZSB0
aGlzLg0KDQpUaGUgY3VycmVudCBsb2dpYyBpbiBkd2MzIGlzIHRoYXQgaWYgcG93ZXJfc3VwcGx5
IGlzIG5vdCBhdmFpbGFibGUsIHRoZW4NCnJldHVybiBhbiBlcnJvciBhbmQgaXQgd2lsbCBub3Qg
YmUgYXZhaWxhYmxlIGZvciB0aGUgcmVzdCBvZiB0aGUgZHdjMy4NCklmIGl0IGlzIGF2YWlsYWJs
ZSwga2VlcCBpdCBhcm91bmQgdW50aWwgZHdjMyBpcyByZW1vdmVkLiBTaG91bGQgd2UNCmVuZm9y
Y2UgaGFyZCBkZXBlbmRlbmN5IG9uIHRoaXM/IEkgbmVlZCB0byBrbm93IHRoZSBhYm92ZS4NCg0K
PiANCj4gPiA+IGJ1dCB0aGUgdXNiIHBvd2VyX3N1cHBseSBpcyBzdGlsbCBub3QgcmVhZHksIGp1
c3QgbGV0IGl0IGZhaWwgd2l0aG91dA0KPiA+ID4gZG9pbmcgYW55dGhpbmcgKG9ubHkgcHJpbnQg
dGhlIGVycm9yIGxvZ3MpLiBUaGUgdXNiIGdhZGdldCBmdW5jdGlvbg0KPiA+ID4gc3RpbGwgd29y
a3MuIEFuZCBvbmNlIHRoZSB1c2IgcG93ZXJfc3VwcGx5IGlzIHJlYWR5LCB0aGUgdmJ1c19kcmF3
DQo+ID4gPiB3aWxsIGJlIGZpbmUgaW4gZm9sbG93aW5nIHVzYiBzdGF0ZSBjaGFuZ2VzLg0KPiA+
ID4NCj4gPiA+IE1vcmVvdmVyLCBhbGwgZHJpdmVycyB1c2luZyBwb3dlcl9zdXBwbHlfZ2V0X2J5
X25hbWUgaW4gdGhlIHNvdXJjZQ0KPiA+ID4gdHJlZSBhZG9wdCB0aGlzIHdheS4gSU1PIGl0IHNo
b3VsZCBiZSBva2F5Lg0KPiA+ID4NCj4gPiA+ID4gPiBvZiBkd2MzLiBJbiB0aGlzIGNhc2UsIHRy
eWluZyB0byBnZXQgdGhlIHVzYiBwb3dlcl9zdXBwbHkgZHVyaW5nIHRoZQ0KPiA+ID4gPiA+IHBy
b2JlIHdpbGwgZmFpbCBhbmQgdGhlcmUgaXMgbm8gY2hhbmNlIHRvIHRyeSBhZ2Fpbi4gQWxzbyB0
aGUgdXNiDQo+ID4gPiA+ID4gcG93ZXJfc3VwcGx5IG1pZ2h0IGJlIHVucmVnaXN0ZXJlZCBhdCBh
bnl0aW1lIHNvIHRoYXQgdGhlIGhhbmRsZSBvZiBpdA0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlz
IHByb2JsZW1hdGljLi4uIElmIHRoZSBwb3dlcl9zdXBwbHkgaXMgdW5yZWdpc3RlcmVkLCB0aGUg
ZGV2aWNlDQo+ID4gPiA+IGlzIG5vIGxvbmdlciB1c2FibGUuDQo+ID4gPiA+DQo+ID4gPiA+ID4g
aW4gZHdjMyB3b3VsZCBiZWNvbWUgaW52YWxpZC4gVG8gZml4IHRoaXMsIGdldCB0aGUgaGFuZGxl
IHJpZ2h0IGJlZm9yZQ0KPiA+ID4gPiA+IGNhbGxpbmcgdG8gcG93ZXJfc3VwcGx5IGZ1bmN0aW9u
cyBhbmQgcHV0IGl0IGFmdGVyd2FyZC4NCj4gPiA+ID4NCj4gPiA+ID4gU2hvdWxkbid0IHRoZSBs
aWZlLWN5Y2xlIG9mIHRoZSBkd2MzIG1hdGNoIHdpdGggdGhlIHBvd2VyX3N1cHBseT8gSG93DQo+
ID4gPiA+IGNhbiB3ZSBtYWludGFpbiBmdW5jdGlvbiB3aXRob3V0IHRoZSBwcm9wZXIgcG93ZXJf
c3VwcGx5Pw0KPiA+ID4gPg0KPiA+ID4gPiBCUiwNCj4gPiA+ID4gVGhpbmgNCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiB1c2IgcG93ZXJfc3VwcGx5IGlzIGNvbnRyb2xsZWQgYnkgImFub3RoZXIiIGRy
aXZlciB3aGljaCBjYW4gYmUNCj4gPiA+IHVubG9hZGVkIHdpdGhvdXQgbm90aWZ5aW5nIG90aGVy
IGRyaXZlcnMgdXNpbmcgaXQgKHN1Y2ggYXMgZHdjMykuDQo+ID4gPiBVbmxlc3MgdGhlcmUgaXMg
YSBub3RpZmljYXRpb24gbWVjaGFuaXNtIGZvciB0aGUgKHVuKXJlZ2lzdHJhdGlvbiBvZg0KPiA+
ID4gdGhlIHBvd2VyX3N1cHBseSBjbGFzcywgZ2V0dGluZy9wdXR0aW5nIHRoZSByZWZlcmVuY2Ug
cmlnaHQNCj4gPiA+IGJlZm9yZS9hZnRlciBjYWxsaW5nIHRoZSBwb3dlcl9zdXBwbHkgYXBpIGlz
IHRoZSBiZXN0IHdlIGNhbiBkbyBmb3INCj4gPiA+IG5vdy4NCj4gPiA+DQo+ID4NCj4gPiBUaGUg
cG93ZXJfc3VwcGx5IGRyaXZlciBzaG91bGQgbm90IGJlIGFibGUgdG8gdW5sb2FkIHdoaWxlIHRo
ZSBkd2MzDQo+ID4gaG9sZHMgdGhlIHBvd2VyX3N1cHBseSBoYW5kbGUgZHVlIHRvIGRlcGVuZGVu
Y3kgYmV0d2VlbiB0aGUgdHdvLiBXaHkNCj4gPiB3b3VsZCB3ZSB3YW50IHRvIHJlbGVhc2UgdGhl
IGhhbmRsZSB3aGlsZSBkd2MzIHN0aWxsIG5lZWRzIGl0Lg0KPiA+DQo+IA0KPiBJdCBpcyBwb3Nz
aWJsZS4gQ2FsbGluZyBwb3dlcl9zdXBwbHlfdW5yZWdpc3RlciBvbmx5IHJlc3VsdHMgaW4NCj4g
V0FSTl9PTiBpZiB0aGUgdXNlX2NudCBpcyBub3QgZXF1YWwgdG8gMS4NCj4gDQo+IC8qKg0KPiAg
KiBwb3dlcl9zdXBwbHlfdW5yZWdpc3RlcigpIC0gUmVtb3ZlIHRoaXMgcG93ZXIgc3VwcGx5IGZy
b20gc3lzdGVtDQo+ICAqIEBwc3k6IFBvaW50ZXIgdG8gcG93ZXIgc3VwcGx5IHRvIHVucmVnaXN0
ZXINCj4gICoNCj4gICogUmVtb3ZlIHRoaXMgcG93ZXIgc3VwcGx5IGZyb20gdGhlIHN5c3RlbS4g
VGhlIHJlc291cmNlcyBvZiBwb3dlciBzdXBwbHkNCj4gICogd2lsbCBiZSBmcmVlZCBoZXJlIG9y
IG9uIGxhc3QgcG93ZXJfc3VwcGx5X3B1dCgpIGNhbGwuDQo+ICAqLw0KPiB2b2lkIHBvd2VyX3N1
cHBseV91bnJlZ2lzdGVyKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSkNCj4gew0KPiAgICAgV0FS
Tl9PTihhdG9taWNfZGVjX3JldHVybigmcHN5LT51c2VfY250KSk7DQo+IC4uLg0KPiANCg0KSWYg
eW91IGZvcmNlIHJlbW92ZSB0aGUgbW9kdWxlIHdoaWxlIGl0J3MgYmVpbmcgaW4gdXNlZCwgdGhl
biB5ZXMgdGhhdA0Kd291bGQgYmUgYSBwcm9ibGVtLiBCdXQgdGhhdCdzIGEgZGVjaXNpb24gYnkg
dGhlIHVzZXIsIGFuZCB0aGUgdXNlciB3aWxsDQprbm93IGFib3V0IGl0LiBJZiB0aGluZ3MgYnJl
YWssIGl0J3Mgb24gdGhlIHVzZXIuIFdoYXQgeW91J3JlIGRvaW5nIG5vdw0KaXMgYmFzaWNhbGx5
IHJlbW92ZSB0aGlzIHByb3RlY3Rpb24gYW5kIHRlbGwgdGhlIHVzZXIgdGhhdCB0aGlzIGZsb3cg
aXMNCm5vcm1hbC9vayB3aGVuIGl0IG1heSBub3QuDQoNCj4gDQo+ID4gVGhpcyBjcmVhdGVzIGFu
IHVucHJlZGljdGFibGUgYmVoYXZpb3Igd2hlcmUgc29tZXRpbWUgdmJ1cyBjYW4gYmUgZHJhd24N
Cj4gPiBhbmQgc29tZXRpbWUgaXQgY2FuJ3QuIFlvdXIgc3BlY2lmaWMgZ2FkZ2V0IGZ1bmN0aW9u
IG1heSB3b3JrIGZvciBpdHMNCj4gPiBzcGVjaWZpYyBwdXJwb3NlLCBzb21lIG90aGVyIG1heSBu
b3QgYXMgaXRzIHZidXNfZHJhdyBtYXkgYmUgZXNzZW50aWFsDQo+ID4gZm9yIGl0cyBhcHBsaWNh
dGlvbi4NCj4gPg0KPiA+IEJSLA0KPiA+IFRoaW5oDQo+IA0KPiBJIGFncmVlIHRoYXQgaXQgbWln
aHQgYmUgdW5wcmVkaWN0YWJsZS4gQnV0IElmIHdlIHJlbHkgb24gdGhlDQo+IHBvd2VyX3N1cHBs
eSBjbGFzcyB0byBjb250cm9sIHRoZSB2YnVzX2RyYXcsIGl0IGlzIHRoZSByaXNrIHRoYXQgd2UN
Cg0KSWYgeW91IHJlbHkgb24gaGF2aW5nIHBvd2VyX3N1cHBseSwgdGhlbiBlbmZvcmNlIHRoZSBk
ZXBlbmRlbmN5DQpwcm9wZXJseS4gSWYgeW91IGRvbid0IG5lZWQgaXQgdG8gZnVuY3Rpb24sIHRo
ZW4gd2h5IGRvIHdlIG5lZWQgYWxsIHRoaXMNCmNoYW5nZT8NCg0KPiBuZWVkIHRvIHRha2UuIEkg
YmVsaWV2ZSBtb3N0IG9mIHRoZSB0aW1lIHRoZSB1c2IgcG93ZXJfc3VwcGx5IHdvdWxkIGJlDQo+
IHRoZXJlIHVudGlsIHNvbWUgc3BlY2lmaWMgdGltaW5nIHN1Y2ggYXMgc2h1dGRvd24vcmVib290
LiBUaGlzIHBhdGNoDQoNCldoYXQgaWYgdGhlIGRldmljZSBpcyBkaXNjb25uZWN0ZWQvcmUtZW51
bWVyYXRlZCBvciBnbyBpbnRvDQpzdXNwZW5kL3Jlc3VtZT8gTm93IHdlIGRvbid0IGhhdmUgdGhl
IHBvd2VyX3N1cHBseSB0byBwcm9wZXJseSBkcmF3IHZidXMNCmZvciB0aGUgYXBwbGljYXRpb24u
DQoNCj4gaXMgb25seSB0byBoYW5kbGUgdGhlIHNtYWxsIGNoYW5jZXMgdGhhdCB0aGUgdXNiIHBv
d2VyX3N1cHBseSBpcw0KPiB1bnJlZ2lzdGVyZWQgZm9yIHNvbWUgd2VpcmQgcmVhc29uLiBJdCBp
cyBiZXR0ZXIgdG8gZ2l2ZSB1cCB0aGUNCj4gdmJ1c19kcmF3IHRoYW4gZHdjMyBhY2Nlc3Npbmcg
YW4gaW52YWxpZCByZWZlcmVuY2UuDQo+IA0KDQpJZiB3ZSBsb3NlIGFjY2VzcyB0byBwb3dlcl9z
dXBwbHksIHdlIHNob3VsZCBub3Qgc2lsZW50bHkgbGV0IGl0IGJlLg0KDQpCUiwNClRoaW5o

