Return-Path: <stable+bounces-69761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E195908D
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 00:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249EF283CA9
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1671C7B87;
	Tue, 20 Aug 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Kyagx5FB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GbcZPQlk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iv/Z7gAk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5F15C13C;
	Tue, 20 Aug 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193502; cv=fail; b=t6F9VNHlbgS0zbRfM1i9mpsB0eO/teNYUnGe9AanLX69YYE9EhyDlak2XZxgUk1MYPGZzhR91DKohlk80XwS4T8fXBdfcgwrTWJWBVYdwoaVFowDpTkCIFDWf4F3RHamunooB/EFpx6vwjWt9Dw9U+kg+eS4cWAZZOdMorfP5Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193502; c=relaxed/simple;
	bh=w/EzPc8gNCBlPLYmcwpIHTK1+U53RQ0nrOeiVaGIiZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlJul917Q9LZ2ZLsVIcf/6mRpRX0W/8947LlcT1x97qXc8HNER4kSgMNa+o45axrCa7I6vg/wqNIWtU7OLo6Hfulry6yk4lWWgm0HmMWGBDIzLwmLiCuE2+b1gezwImquwkIYQ3stqPC7O/TXrLRKPk+siXAxmEDswFVMS9kgEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Kyagx5FB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GbcZPQlk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iv/Z7gAk reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJl8a020379;
	Tue, 20 Aug 2024 15:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=w/EzPc8gNCBlPLYmcwpIHTK1+U53RQ0nrOeiVaGIiZc=; b=
	Kyagx5FBi115z3ZePFplopUR+9XKQp6eWPjl6OnYaCRG1JfVb9zn1sxlAjvynoKY
	ASrzz6nmNsnm3Zoh6zWYiUVv/t2jgTgey1PSQ+cIqtM7qSEaHXXq+EHL3A8/GDp9
	+gecrORqFY6ZAUJaJwCJv+Ferkxzo86wRWeodzec8QfJWWS+hY36Dd+MKEuhhu/n
	RQ7YBzDSiUcvKZu/j/b8jpZS5hvWj/XdaoDwZTN+FFfVJD239temh7hjdH/C3eEb
	+zhITQ2a6x71A6z+KOW1EBZP7WcNJIzgIdbZluVxqa8o0o5dB8CWALOGABWNEFV2
	5vAbZZG35PxwwGUzP9zPIg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 414g8k5bk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724193488; bh=w/EzPc8gNCBlPLYmcwpIHTK1+U53RQ0nrOeiVaGIiZc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GbcZPQlkJh+NMRx7aCxjFaG1NhgdGjYnq3wUy2QnQ+yvQVhZqArpRPYl18VEi5HnT
	 SnvHz0w6fKD95xaqBYLKBbZZ4qHPNbiLC7LzfCU28ebePbSb0tF1XtBoDrqJI3T2PW
	 21lciEGnEoDPhmTpAcCfbasqNBjKz7JfuDMmFsVMKxHeW4m8JSnJkn0GQZkCjv/UXG
	 fZijwhaNozhnxq+T2C9GFDQj3xmLWOvEgy5ERANhcoo9uhJhBnzJolleCdpRD2/AGf
	 3/OpU1dgd/UPnAJ32gyqp40BieWtIAlsNraXwT7pKQ6bP8sMO+76g3k/T/Ibx0pyIw
	 7nPsQsTNuQ5xQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1D9E24028D;
	Tue, 20 Aug 2024 22:38:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7A775A006D;
	Tue, 20 Aug 2024 22:38:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iv/Z7gAk;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D656C4034A;
	Tue, 20 Aug 2024 22:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAdVTc4NPYoSvmxqD415tWana20CHe7HL++rYUfVR3GnRG4KVu8CYYhTgY7Dx6KsY+Pzb8mUHmwyGzW4FQjO4iI408V4uaN6dRtRy5nj5u1VQSpiLGhRG/IWbUHZmwu4iXKcsqwCr20lNG1w+731xijZTJY7rtEiurtTaAzBeuy51U/2dA0sq5dutDp6xRicmQ+d4dVeU8PZYVKN7NNKjeoUT2JyWUBoiyUMmvIckADjoyxTu9JzJegrJNmKHWzuD1M26t1AthHffaRrxYsgyPf/0vTA4b05pSPOSmvjR2oxOknNq5szC+hKrJQWz9Aqu58XgETQxBEQszDwqSE/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/EzPc8gNCBlPLYmcwpIHTK1+U53RQ0nrOeiVaGIiZc=;
 b=ulLNuCoSkqn5OPCjM1vroeLqI+ENoDO6Mlr6H7cSE2wdTXCNm/ycisgHLn3N69E5boIo6rwMkhTQyrgElAG5EadtGSJSuaRMXqEwWmDi5MUR6T+ruOsTOYQXTHZA0lYpGtc+/XfoUSEeMAEyhaS3LRRDwVtdQJU3GOepUW/6FtOFLEoXDhFewdink1oqwNesvcbz2GH1R6dIkORiMUw6VMbvg/wXVul5ISDXji+Stxg2MaI+8JBlTQYUcPJLwHwFYwPi0fpp9JIbxlkTY4W0iyZdZ/jmpmGkda8KcMM4H3W8OMWg2xHlff+dpNfVcVzjBpyqc4ibI0296yd3ncX/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/EzPc8gNCBlPLYmcwpIHTK1+U53RQ0nrOeiVaGIiZc=;
 b=iv/Z7gAkus82aVDsaYB0VWgxTZ0jcSrlpFlTrfD6NrSCdCoBRZRTNmqx3IOyfeetNwPDEHaHIV5d2Yx+v8tfCj4ph4DABteznd/5T+PaT5lmeOsjtUwXoMaW0mC+4kOe60vVJF2cuy2MuvUzgzf9dxFKzfQ1lvICWGzNC1tCoDc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 22:38:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 22:38:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [v3] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Topic: [v3] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Index: AQHa8vq04mbOlJq9L0aXUQ7UJhJ+qrIwvUMA
Date: Tue, 20 Aug 2024 22:38:02 +0000
Message-ID: <20240820223800.zt52jaxedijbvskt@synopsys.com>
References: <20240820121524.1084983-1-quic_prashk@quicinc.com>
In-Reply-To: <20240820121524.1084983-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB9254:EE_
x-ms-office365-filtering-correlation-id: 9f4683fe-2df4-450a-eaf5-08dcc168c076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0ZEVnFEbnd1R2hFSTIrYkxTRmlnTUlLODJCOWFnYWtvYU8vUG9mVTh4eGtx?=
 =?utf-8?B?b3RpcHFxUzlsY1lYYW1Kd2FYdk9XZDI5TEV3a3huTTZPUWFqOWdPUktxN0FY?=
 =?utf-8?B?U2ZYdUNQakxVU0RFUHlkNmdJUlV0L0Rwc0NuTWVhZXpBUW5Ic3dPOURxMnBV?=
 =?utf-8?B?Wmc5OXJ3L3BDd0JhM0tZbnUranpFTHNEeVJPNU5QMXAwMzZMUGJyOGN6L2NW?=
 =?utf-8?B?NDNLNlRodjNwcFpYMHlTUTVYSHVaQ0dNOU9tcFZvNlBuRWsxam9xeDVFRlI1?=
 =?utf-8?B?U0dPUnZIc3VoeWVTb0s5U0R0b0xEYThUNURocUNxTnhHNDJBTGYvcld2R3JO?=
 =?utf-8?B?Qks1eGU5aFh3T0tQUldvcGZFRWZSNTZNVEQxUi9QVVczZ0hOYXlTZzhMUGJY?=
 =?utf-8?B?STByV3VtL0FZdW1LTTlPT2RQQXJkYlZXMHJMdXkxVXJuenpqcnV3enJtZE10?=
 =?utf-8?B?ejloTjF5bXNhRmxTL21CSU1UWE1QaXE3ZjVFUERhN1ZnWUI2VHZUM0E5Uk1h?=
 =?utf-8?B?WWZyVWZqanFZTnpBVTdIWExVSUpGM2FNRlRCUm1jcFYxZm4zYm9Za3poYVpS?=
 =?utf-8?B?WTBQQ09jWnhtaXMzSkdJaDZMaWNPZTBhbnVmQXQ4U2R3dm9vZTRqRXNyV0dR?=
 =?utf-8?B?WFRPejd1cVIySnFCaUhWZzkrNlBPaWljL21pY2FOVXo4cDFTalVFMUYyQmRE?=
 =?utf-8?B?QkNWQnlUNm5MUHgyeXhuaG9KODNQcjVHOHdUOUg2YmhhZ0tuR3dHZjVJam81?=
 =?utf-8?B?Y01qWWpBNEcraUNWUjc1UkxrWkptckpKVzhDb2wzVXk4UlhUWk1XdGZXeVVm?=
 =?utf-8?B?aEVUajNtWUx4QllqUVBGV3VHeFNLRHRFdlVuMzNqeU8wZDZaMXhWK2VXSUtE?=
 =?utf-8?B?NHZpNld3R1U3QVhhMzhnMmdvSnUwQjYyaVI5U3gvL0RNdkNKUXJ2RVpGbXFx?=
 =?utf-8?B?UVlyV2czT1JmVlFIK3FoeWlPVTVROWl0WlJGWmF2RXNySk5pbTMySjJXSC9t?=
 =?utf-8?B?ZU9BTUJCcE1DNEN3RTVZK3JtRkpralA1N3lxRVZ3TS9YQitLRE1BSE9TMTFY?=
 =?utf-8?B?OHAyK1BNUE9Fd0NjcWJwZ0ErY2g3dmxRSm5PeGx0NEhIeENDK1loV0NOeThN?=
 =?utf-8?B?YkMxSGxzRFNUZ09iNjZmRzk0djdoRENkeTZUeGRuZmsxN1ZldDl6d25yWXJX?=
 =?utf-8?B?UEZDRjAwWkdUYnZoSERZbUp4cTVjQktNbFV2OFhuazdmWW8wd2lrTTlYRG9p?=
 =?utf-8?B?cnZ2SlUyODdwUWE2ajdUSmtmakV6TkFqalpJclhibHNqOXhIK2ZZZUdrVG1z?=
 =?utf-8?B?bDM1d1l3WWFPeDNtaTc4akFpSFhnTkhMaDdHcU0zek1HQnc5QzlCek9zbCtV?=
 =?utf-8?B?bjNEV1hsWnNzMnZkU2taaHVSbkFldk1nVVRXS2x2NGJOaG42Y21iWGZ4RWZw?=
 =?utf-8?B?MEMzZnlySjYrRGJuN0RVeXVHanhMcFoveEI1QUdZYkU3MVFFMnp4c0VYTm5J?=
 =?utf-8?B?eFVraTNNOTJyWEVmbUhDd1RoUC95aHNuMXFHTWZTdllEa0JUU2lMM0JDZk85?=
 =?utf-8?B?U2xqWHh3bXFCRFRITkduSHZPSzloWVJEZUVzQklyeE1pZ0FQYXVIMDk5UkZu?=
 =?utf-8?B?SzNqZGkxM1FEWjRoU0Vab04xNHZXVTdQd01NTkZjQlFMS3BTZHRFSm91V2hI?=
 =?utf-8?B?a0gyVXVza3hKd0FheVFPVmcwVnBZWW51SmE5S0xYanZyVHUvSDhtOVBrU1FU?=
 =?utf-8?B?eDNQTHRjb1JENkVKOGhhOU1RNmp0VzJvWHRiMjM3RWJidUZ1cFlmanN5dzBv?=
 =?utf-8?B?djdZTmxUOE5UME5sWVlJYzZESnpaRjdCcEFkcGJGN3pqMWtHVzNOZ2VPbVd5?=
 =?utf-8?B?ZnczaXlISWxtdnFpVk0rS3hZRVF1UHF4ak4wWlZHMy9Td0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU10bnBqSHBXMXJlWHppMjVwVmRsVk81RVNFSnJFZXpTekhOaHk2RW9jall4?=
 =?utf-8?B?bmd6aWI3WE81eXE2blR3ZlM1TnFmZmh3SEdUb3F3elJhdEk4NnJMZ0VOSFF3?=
 =?utf-8?B?RjBiMmVKKzZFcWsyNTZlNmhaY3k0QUlEcDRvNEVmbmNGbnRiSFdWdVA2bSt3?=
 =?utf-8?B?V0Q5Yk8xWlFCbUNYWnF4VGVFbnA4NElrVys0Z2hqWis3QXhRemNSdXV2dzN4?=
 =?utf-8?B?Y3JhZHE2ZlFoVXFSc3E4K29LS0F0WU5MOTVnN0JHVmNTb0hzYTlycGF3ejZw?=
 =?utf-8?B?cGp2K1M4cjhFdU1PM3Jiay8wNU1oUjAvUmE2cVRtbEhHR0I4Z21EcCtiaVBF?=
 =?utf-8?B?N3dIY1p0U05zTUptTFZtMFFZcVlQUXZaeldub0FMODRZRmZxUEhvSmdSa3li?=
 =?utf-8?B?bnRYcVFnemsydHg3dUlhMXJJb3RncFd5VmF1MUxFMGZNTGl0Yk1NNGdGVVFO?=
 =?utf-8?B?bjdLN1FQQW5NRzJXKzU4RVZyaHEyNEp0VGQ4MGJwZHp2bjB4RWVSa1BNUVFW?=
 =?utf-8?B?bGxydVBmcCs1QitLTnljNE1CVk1HdkRYLzB4V2lyV3FJTmZqUHY2dzNUT2RG?=
 =?utf-8?B?bUFYWkt5Vk5RMVZYVTFnNjcweXhsVHFpQUpOYmVOMGZQaUV3dEZlWjJ5d2dv?=
 =?utf-8?B?Y29RNEt4c3IreXZiaUErUzNnNnFOdnRnZXVxck5OU1JxTnF2NU55Yk96dlhl?=
 =?utf-8?B?U2Q2V0U2TCtpejM1bHgwUUhVdkFLcGlMd0tCb0hqdjN4cW5UVkRTZVhhdm5i?=
 =?utf-8?B?TVd5bGlOem5QVlBSOWs3K1BqbndXTjRVMWM4czBlWWRoK0d4VS9hM1FuTlEz?=
 =?utf-8?B?QWJiZ0ZuQnpnVWZZV2NtTWNSbTJOS0tsMmxZVFd1MG9GV3FzWmhQVHUyNUJh?=
 =?utf-8?B?a3hhbzVGZWhEMWo4NWZLM2VKUUFEQ0hCSEtyTzF3cFplTE1td1pwSEJDYW9W?=
 =?utf-8?B?RVQ2NFJzOGhPSHYvNkgralNjdUErMUtCc2tkcWxMWnl3MldmK1p4M0NDTVFQ?=
 =?utf-8?B?Q2hIN3FrS0NYNFR6aTRyZ1prWTk4SWljaDdHRURYVW1nL1dGMWlFVndwUDgv?=
 =?utf-8?B?TUdmSWFLTjhFeWdaOFZCNTFXTy9LYVUzdjV6aFBBQ3ZtamN5R0RiVTJTdkVZ?=
 =?utf-8?B?QWwvMDdKdFpyMXhHb014THlLT0tuMkhLS1J3WWJ2VTRmS3lpb2JIK3hkRjdB?=
 =?utf-8?B?L2RKK3BGRHdhTkxCMEI1a0w2T3h1MTB6OG1xdUwvb3J4eXVkek1pYWlSQ2FC?=
 =?utf-8?B?MDhjdUhDNlFBQTFWQm1XN1EzMTI0TTZITmFmTk85RnFDNWUwMDB0Ui8yU3R4?=
 =?utf-8?B?RHlPcnFTd2JyZ3hHTmRDcHNmQzJRNks4cmxuTmJBNDV4QjQ0WDlhTVRFUHpB?=
 =?utf-8?B?aU1oMGI1RlNMMEhQUkoxSDgzTFZkdkxLVi9TU0xkVjBlS1lITUNxN25hRmNt?=
 =?utf-8?B?RDNTck50RjlyVnFqQ1FJM0JvbFdzQ3NXcXVWWlBlQUxtYXJsYk4yRW1qTXhT?=
 =?utf-8?B?ZXIrTlRuZitnQ3ZlOVlQOTQyK3dxTmNqVjI5blI3MkE4YnJGc1hDUU9SRFhH?=
 =?utf-8?B?R2w3cXhtdUJNcXRaaUYvUU11dndZdjhOQ2RHVi9yUVZrSzhsbnNGT2xzUXJm?=
 =?utf-8?B?dGpwNmR2cDFSSE5Fb0t3UTJPYTlISkJmdG03UXFldGpIbHNIZVVMeXM4ZlpB?=
 =?utf-8?B?dmtiRkdkVTFkQnNvUjczK1A3azZJaXVwVjFCNEJCUUxPS2VZZFR3MzdvZnh4?=
 =?utf-8?B?bWJyd0VVbkhrS0xHMFh6WkYzM1F6TnNodUpidkpkQm9HNmw4d2FIN1Jzdjhk?=
 =?utf-8?B?UGNjaWJYUGNreDRlOHY5YUdGUG9JZk5iaWhZdzhrMmgzNXNPVnlRWm1IcE5P?=
 =?utf-8?B?MDMreWhRcC9YbGY3UkQvcTcyQWQweWpBL3hxKzJtSUlweDlvdWwraGJnNUpu?=
 =?utf-8?B?eXVMNE1hVDVCbGhtb3k5TWRhQnhpYmxWNWxpR293dUdaOFgzQnViSmNOUUNl?=
 =?utf-8?B?dnVQNDhGK1F1RmJyNTF6S28wbm44NU9iVHJIUkUyS3BWMTJBT3VvRlZJeitt?=
 =?utf-8?B?b0VwclBqeXU4WWxUS1p2cXMyZmw2T0lsb21zellNaUIvbkJQUWRTMGJhb1Zm?=
 =?utf-8?Q?lbD+rmumt6/n6E2d4Y2lVOMAv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63FE86E01F18AC49BF8CF79FD855B1F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uHr5HYqqtBDwpaaK8Co81D7KT28GXl6GHftmqysBGt4sSDgeLQTj4Qs/7aVs4t3TrY7okvgR6OriBEOpUuslVs5KPGNr0A2g5ooQVnFgSP0z0wMinP3FP8TojLu5wk31taE3kW6HqyVy3RF4p2+0SjPvzc1B1pSYGwIxywTK2VNCD4TLu3kwdEpwyJChEYQY7kfQZ3+RFPHEsPOrQ57xgSYAWwr5HEPBsI2KQbORgYbo662sC3eXjfntgLON3UADhPLioEmmGcyfRawVUumR0ZfWEAV4PBksWxeIqqSahZ5/fp2NZvUsyXVD3RF9HO/Tmq/vVQQznWyFcMSfI47k3PoY5C/O64QDj5d1wHnv2S9Dzvm7n1sBYwNs3oXbBRV6yXz2/3azEjFIc8lWlzqV/edtslnb4axdFvfHoFh27P3sFQDuRoY+zM5ek1Q8itAUdyRB1DXW6qyPgKp9p294C4SVwuFJiovWlrTrTaTiBhaSVGQgh1uryr2Ps8Ja8HtrnVCm2vpNDlREezJWIHpnfUsvHEY+3jK8HbTuw5GnAa5zMZrSlKcRKo6FxwDM4k8AkGG/bRVyXDJ5BlLjXACpx3LfMwUQwfHdDzmO+r3RINm+py+Rzp3cJuK2oWkN1li2T1aq+s55Ua5eShjJAUv98g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4683fe-2df4-450a-eaf5-08dcc168c076
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 22:38:02.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qD6MXpZiMl1JS7KtqU+qjycGQP2IcRM0I2W8sFHOo2G5Rjn8WOg6iTfpOBTM8vPK+zLSizHKnDhQcXEp6tActA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254
X-Authority-Analysis: v=2.4 cv=bpgeB1ai c=1 sm=1 tr=0 ts=66c51ad1 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=COk6AnOGAAAA:8 a=gyDTvpGelrfQk6yjG0MA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Lf5xNeLK5dgiOs8hzIjU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XV8sjsT5eyYaHP3Jq-7tStbE9iBulJRj
X-Proofpoint-ORIG-GUID: XV8sjsT5eyYaHP3Jq-7tStbE9iBulJRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_17,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=961
 malwarescore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200166

T24gVHVlLCBBdWcgMjAsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBXaGVuIG9wZXJhdGlu
ZyBpbiBIaWdoLVNwZWVkLCBpdCBpcyBvYnNlcnZlZCB0aGF0IERTVFNbVVNCTE5LU1RdIGRvZXNu
J3QNCj4gdXBkYXRlIGxpbmsgc3RhdGUgaW1tZWRpYXRlbHkgYWZ0ZXIgcmVjZWl2aW5nIHRoZSB3
YWtldXAgaW50ZXJydXB0LiBTaW5jZQ0KPiB3YWtldXAgZXZlbnQgaGFuZGxlciBjYWxscyB0aGUg
cmVzdW1lIGNhbGxiYWNrcywgdGhlcmUgaXMgYSBjaGFuY2UgdGhhdA0KPiBmdW5jdGlvbiBkcml2
ZXJzIGNhbiBwZXJmb3JtIGFuIGVwIHF1ZXVlLCB3aGljaCBpbiB0dXJuIHRyaWVzIHRvIHBlcmZv
cm0NCj4gcmVtb3RlIHdha2V1cCBmcm9tIHNlbmRfZ2FkZ2V0X2VwX2NtZChTVEFSVFhGRVIpLiBU
aGlzIGhhcHBlbnMgYmVjYXVzZQ0KPiBEU1RTW1syMToxOF0gd2Fzbid0IHVwZGF0ZWQgdG8gVTAg
eWV0LCBpdCdzIG9ic2VydmVkIHRoYXQgdGhlIGxhdGVuY3kgb2YNCj4gRFNUUyBjYW4gYmUgaW4g
b3JkZXIgb2YgbWlsbGktc2Vjb25kcy4gSGVuY2UgYXZvaWQgY2FsbGluZyBnYWRnZXRfd2FrZXVw
DQo+IGR1cmluZyBzdGFydHhmZXIgdG8gcHJldmVudCB1bm5lY2Vzc2FyaWx5IGlzc3VpbmcgcmVt
b3RlIHdha2V1cCB0byBob3N0Lg0KPiANCj4gRml4ZXM6IGMzNmQ4ZTk0N2E1NiAoInVzYjogZHdj
MzogZ2FkZ2V0OiBwdXQgbGluayB0byBVMCBiZWZvcmUgU3RhcnQgVHJhbnNmZXIiKQ0KPiBDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGggSyA8
cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiB2MzogQWRkZWQgbm90ZXMgb24gdG9w
IHRoZSBmdW5jdGlvbiBkZWZpbml0aW9uLg0KPiB2MjogUmVmYWN0b3JlZCB0aGUgcGF0Y2ggYXMg
c3VnZ2VzdGVkIGluIHYxIGRpc2N1c3Npb24uDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8IDMxICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
IGluZGV4IDg5ZmM2OTBmZGYzNC4uZDRmMmYwZTFmMDMxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
QEAgLTI4Nyw2ICsyODcsMTMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1
Y3QgZHdjMyAqZHdjLCBib29sIGFzeW5jKTsNCj4gICAqDQo+ICAgKiBDYWxsZXIgc2hvdWxkIGhh
bmRsZSBsb2NraW5nLiBUaGlzIGZ1bmN0aW9uIHdpbGwgaXNzdWUgQGNtZCB3aXRoIGdpdmVuDQo+
ICAgKiBAcGFyYW1zIHRvIEBkZXAgYW5kIHdhaXQgZm9yIGl0cyBjb21wbGV0aW9uLg0KPiArICoN
Cj4gKyAqIEFjY29yZGluZyB0byBkYXRhYm9vaywgaWYgdGhlIGxpbmsgaXMgaW4gTDEvTDIvVTMg
d2hpbGUgaXNzdWluZyBTdGFydFhmZXIgY29tbWFuZCwNCj4gKyAqIHNvZnR3YXJlIG11c3QgYnJp
bmcgdGhlIGxpbmsgYmFjayB0byBMMC9VMCBieSBwZXJmb3JtaW5nIHJlbW90ZSB3YWtldXAuIEJ1
dCB3ZSBkb24ndA0KDQpDaGFuZ2UgIkwwIiAtPiAiT24iIHN0YXRlDQoNCj4gKyAqIGV4cGVjdCBl
cF9xdWV1ZSB0byB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1cDsgaW5zdGVhZCBpdCBzaG91bGQgYmUg
ZG9uZSBieSB3YWtldXAgb3BzLg0KPiArICoNCj4gKyAqIEFmdGVyIHJlY2VpdmluZyB3YWtldXAg
ZXZlbnQsIGRldmljZSBzaG91bGQgbm8gbG9uZ2VyIGJlIGluIFUzLCBhbmQgYW55IGxpbmsNCj4g
KyAqIHRyYW5zaXRpb24gYWZ0ZXJ3YXJkcyBuZWVkcyB0byBiZSBhZHJlc3NlZCB3aXRoIHdha2V1
cCBvcHMuDQo+ICAgKi8NCg0KWW91J3JlIG1pc3NpbmcgdGhlIGV4cGxhbmF0aW9uIGZvciB0aGUg
Y2FzZSBvZiBMMS4gUGxlYXNlIGluY29ycG9yYXRlDQp0aGlzIHNuaXBwZXQgKHJld29yZCBhcyBu
ZWNlc3NhcnkgdG8gZml0IGluIHRoZSByZXN0IG9mIHlvdXIgY29tbWVudCk6DQoNCldoaWxlIG9w
ZXJhdGluZyBpbiB1c2IyIHNwZWVkLCBpZiB0aGUgZGV2aWNlIGlzIGluIGxvdyBwb3dlciBsaW5r
IHN0YXRlDQooTDEvTDIpLCB0aGUgU3RhcnQgVHJhbnNmZXIgY29tbWFuZCBtYXkgbm90IGNvbXBs
ZXRlIGFuZCB0aW1lb3V0LiBUaGUNCnByb2dyYW1taW5nIGd1aWRlIHN1Z2dlc3RlZCB0byBpbml0
aWF0ZSByZW1vdGUgd2FrZXVwIHRvIGJyaW5nIHRoZQ0KZGV2aWNlIHRvIE9OIHN0YXRlLCBhbGxv
d2luZyB0aGUgY29tbWFuZCB0byBnbyB0aHJvdWdoLiBIb3dldmVyLCBzaW5jZQ0KaXNzdWluZyBh
IGNvbW1hbmQgaW4gdXNiMiBzcGVlZCByZXF1aXJlcyB0aGUgY2xlYXJpbmcgb2YNCkdVU0IyUEhZ
Q0ZHLnN1c3BlbmR1c2IyLCB0aGlzIHR1cm5zIG9uIHRoZSBzaWduYWwgcmVxdWlyZWQgKGluIDUw
dXMpIHRvDQpjb21wbGV0ZSBhIGNvbW1hbmQuIFRoaXMgc2hvdWxkIGhhcHBlbiB3aXRoaW4gdGhl
IGNvbW1hbmQgdGltZW91dCBzZXQgYnkNCnRoZSBkcml2ZXIuIE5vIGV4dHJhIGhhbmRsaW5nIGlz
IG5lZWRlZC4NCg0KU3BlY2lhbCBub3RlOiBpZiB3YWtldXAoKSBvcHMgaXMgdHJpZ2dlcmVkIGZv
ciByZW1vdGUgd2FrZXVwLCBjYXJlDQpzaG91bGQgYmUgdGFrZW4gc2hvdWxkIHRoZSBTdGFydCBU
cmFuc2ZlciBjb21tYW5kIG5lZWRzIHRvIGJlIHNlbnQgc29vbg0KYWZ0ZXIuIFRoZSB3YWtldXAo
KSBvcHMgaXMgYXN5bmNocm9ub3VzIGFuZCB0aGUgbGluayBzdGF0ZSBtYXkgbm90DQp0cmFuc2l0
aW9uIHRvIFUwIGxpbmsgc3RhdGUgeWV0Lg0KDQoNCj4gIGludCBkd2MzX3NlbmRfZ2FkZ2V0X2Vw
X2NtZChzdHJ1Y3QgZHdjM19lcCAqZGVwLCB1bnNpZ25lZCBpbnQgY21kLA0KPiAgCQlzdHJ1Y3Qg
ZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyAqcGFyYW1zKQ0KPiBAQCAtMzI3LDMwICszMzQsNiBA
QCBpbnQgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWdu
ZWQgaW50IGNtZCwNCj4gIAkJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNG
RygwKSwgcmVnKTsNCj4gIAl9DQo+ICANCj4gLQlpZiAoRFdDM19ERVBDTURfQ01EKGNtZCkgPT0g
RFdDM19ERVBDTURfU1RBUlRUUkFOU0ZFUikgew0KPiAtCQlpbnQgbGlua19zdGF0ZTsNCj4gLQ0K
PiAtCQkvKg0KPiAtCQkgKiBJbml0aWF0ZSByZW1vdGUgd2FrZXVwIGlmIHRoZSBsaW5rIHN0YXRl
IGlzIGluIFUzIHdoZW4NCj4gLQkJICogb3BlcmF0aW5nIGluIFNTL1NTUCBvciBMMS9MMiB3aGVu
IG9wZXJhdGluZyBpbiBIUy9GUy4gSWYgdGhlDQo+IC0JCSAqIGxpbmsgc3RhdGUgaXMgaW4gVTEv
VTIsIG5vIHJlbW90ZSB3YWtldXAgaXMgbmVlZGVkLiBUaGUgU3RhcnQNCj4gLQkJICogVHJhbnNm
ZXIgY29tbWFuZCB3aWxsIGluaXRpYXRlIHRoZSBsaW5rIHJlY292ZXJ5Lg0KPiAtCQkgKi8NCj4g
LQkJbGlua19zdGF0ZSA9IGR3YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+IC0JCXN3
aXRjaCAobGlua19zdGF0ZSkgew0KPiAtCQljYXNlIERXQzNfTElOS19TVEFURV9VMjoNCj4gLQkJ
CWlmIChkd2MtPmdhZGdldC0+c3BlZWQgPj0gVVNCX1NQRUVEX1NVUEVSKQ0KPiAtCQkJCWJyZWFr
Ow0KPiAtDQo+IC0JCQlmYWxsdGhyb3VnaDsNCj4gLQkJY2FzZSBEV0MzX0xJTktfU1RBVEVfVTM6
DQo+IC0JCQlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dha2V1cChkd2MsIGZhbHNlKTsNCj4gLQkJCWRl
dl9XQVJOX09OQ0UoZHdjLT5kZXYsIHJldCwgIndha2V1cCBmYWlsZWQgLS0+ICVkXG4iLA0KPiAt
CQkJCQlyZXQpOw0KPiAtCQkJYnJlYWs7DQo+IC0JCX0NCj4gLQl9DQo+IC0NCj4gIAkvKg0KPiAg
CSAqIEZvciBzb21lIGNvbW1hbmRzIHN1Y2ggYXMgVXBkYXRlIFRyYW5zZmVyIGNvbW1hbmQsIERF
UENNRFBBUm4NCj4gIAkgKiByZWdpc3RlcnMgYXJlIHJlc2VydmVkLiBTaW5jZSB0aGUgZHJpdmVy
IG9mdGVuIHNlbmRzIFVwZGF0ZSBUcmFuc2Zlcg0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpZb3Vy
ICRzdWJqZWN0IGlzIG1pc3NpbmcgIltQYXRjaF0iIGZvciBzb21lIHJlYXNvbi4gQ2FuIHlvdSBs
b29rIGludG8NCnRoYXQ/DQoNClRoYW5rcywNClRoaW5o

