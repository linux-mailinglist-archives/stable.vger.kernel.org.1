Return-Path: <stable+bounces-69363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C49552B2
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD061F23576
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B551C5792;
	Fri, 16 Aug 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X+92eWpO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dyTOyxRQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mptajtzE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46F7C6D4;
	Fri, 16 Aug 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845007; cv=fail; b=NqIIbjV1MHQQucxQ6XElNqKnURGAjm/Sed1z7ASBUofAf9G/hVgUGZUOVIr6MylQ7QjR9LDEzkgXoKuPLwsDG0Ha7NoZwdG6Xr0x38TKQxcm/pLnp+Z00ufOmNrfOYQkHEHu+vHCeoy3wBH4y6D5Zf1JBM0xppMRy7HcwEDJ6Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845007; c=relaxed/simple;
	bh=SyR3ix997Yk8Pl26wgc6dXjHjY7Dj+kzD4NG6zDwDac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6SNNQah56mY403rYQB41gB9AqzhuvIYz/9zi69v0GzG9MleHrebU6W01kiB2EG5DaoZZxvVAOkgJZ0t458YT0HaAsoSAQL0Uu8NCUqCyC9z9XZq/BIJ7YScDV9XiXMVzkFvOoy2bC6aC1oKYWzUPVih2Vp6fqC1PeYc9Vv1neo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X+92eWpO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dyTOyxRQ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mptajtzE reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GJ25u9006431;
	Fri, 16 Aug 2024 14:49:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=SyR3ix997Yk8Pl26wgc6dXjHjY7Dj+kzD4NG6zDwDac=; b=
	X+92eWpOy+LZOcfPrU6WNKdeP8Awn3JYpw0QzNIcFlQ+P0apk5saJir3W732mUtU
	qAyv+7UR1E1CzxfW9U81+K4518aQIemxNcABwQ0Yjt3zYjTKHrkDztdboWDjp26P
	Aso5wo/kQ6VkegYlheon9lujZ5VByWztDLja/kv5SgHLmso0h+daqDnl0+k/mUJI
	lXx96Epl3zhJ1wAO35tmQtjiAizqcy0i06Nw2pIsspCz3c1ST9Qis6S5i+ZUaqs7
	7oDJdYO1w7LR4ZBKrkZALrjKvlRQUk136GFiy9e3JCH3uFb9PpemxqqLDwCXyEpW
	2AQQR7vbZghbH2H6KGpRlg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4111crafyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723844994; bh=SyR3ix997Yk8Pl26wgc6dXjHjY7Dj+kzD4NG6zDwDac=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=dyTOyxRQNyYPHOBIYSWSjgoknU4vJeAZkQe58/NccsOls+zot0TFrsFwS9WmvsATd
	 cW4hI4HkWMdeSVeRNK4oUZQ/5FLUu4U+tn7XIO+Y2zcpJAigMVwpMd3Nck1ff8Ol4/
	 U2gsbaexuHiB1AHOXusAp3MRKkPtD65Jt5Lp5zvSCQqzD7w/swBcEm4rL+0PDKcISa
	 ZJlITKoYp7tYz7bzGBGS6ghUbYGhrXt5aEr1AMc8UXzbVhct32FSDmf/g+x2VyMTIy
	 MgOGJrPOOSwQlkPo+L+Qxiu7rlbi6XPC0Kw50aJTw4STpTJW4APMpBzcAMIu+ZrmvA
	 pmSrNNWw0qr+g==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2457840467;
	Fri, 16 Aug 2024 21:49:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A474DA00D6;
	Fri, 16 Aug 2024 21:49:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mptajtzE;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 287FE4035B;
	Fri, 16 Aug 2024 21:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGx7LFmTlt7HpQARvR7yVyVgrpfetqljLtvGIG6dvdCIzGeF9jhh+CTVlgHVaFEur7iSEvJye5rEROrICEYDBDS9TQU3g6XxEKYBrVRo9gatEDuX2rlKSMagDTRJpZ0px1DtRwzO0HFzLnfWoiU7tBCSTmpzshzcO2j/th7wv4++5V319zwitRTf/U6brofgMvY4dvMX6w752Utlc5DJwzFX3ocf+f3ARGYyN3nYY81LkOV5vtVkfw5qo11mwQytsg6xQgJzeTqif9z+PxrDQoVXVh/fT/5MsBLlVZJnntyZKl0Hm0XjnyWaMW2RGubWNjc6EWg+D4vZtfIhZKhr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyR3ix997Yk8Pl26wgc6dXjHjY7Dj+kzD4NG6zDwDac=;
 b=TCrvVqdxR1s8xGxLi/4ug93QuCabKzjgmWNF8LpCnTwwRcXBNYm/0Bgmf0WcRGDSaJzdEoiH/u1KRyc9uiPXrYpdtAIwJuj2vWH+PdIT0akv/bwBOSpHp+GO4n0wOISWvdEHRcyrebRJAAvEcL8Qmp03OwTgHuPWQyk6sb/yvT++7LmqU8udv5v+UC6kJRrvQGKkt+C/QTiVVfdtclbs9BYnoufp+cLXkXMXEX+hhVOJFqIVe9gL4H/hj/0lI93JsydFpHlplu5g0jNB8cnSgJ6Fkq3C3R2JK6LjRBeVmNu7eTzrJ0b+TqkXX+EQNT2B6hjv/btnBP+xO+NXu29P1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyR3ix997Yk8Pl26wgc6dXjHjY7Dj+kzD4NG6zDwDac=;
 b=mptajtzELv+9iLiwOhGRRN7jKB04oI3y4YieGkdu+n14eJBHm2Ca3UwGGQNcn0GvtU1enhXEjxGKcLEKj32RaIJ0Nl7vQ/eGNICGSRUDm3tG2ANHcst+asEgyaTbSC8Yg8hdazLMDocJmIYwMxdt/k+T95x1aUv+OYnSuJfV1HE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 21:49:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 21:49:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [v2] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Topic: [v2] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Index: AQHa76Rs7E1JRmgzG0Wr5p//kEawrLIqbRyA
Date: Fri, 16 Aug 2024 21:49:48 +0000
Message-ID: <20240816214941.l3el46ittrugxqp5@synopsys.com>
References: <20240816062017.970364-1-quic_prashk@quicinc.com>
In-Reply-To: <20240816062017.970364-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4211:EE_
x-ms-office365-filtering-correlation-id: 2e6152e8-9827-4a2d-2ebf-08dcbe3d597d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGUwcFg5RFhER2h0NFIzMzBBVzRWMklNaUlzcVgyVjBEcUhEcUN1Y3Iya21H?=
 =?utf-8?B?T3UrL1U3WGRYenpMdDRPME9xVndqbDRadTZwUUs2bWhTYjBzc2FSOGtaVUhS?=
 =?utf-8?B?YU9LTkQybTl0dWNxaDF1L2RGRCtMbnRTWmxJYXdZemNRenBCQXR3YThyYW5L?=
 =?utf-8?B?aVduVTl4emJneHR2RTRQckN3aE1Gb0NrV3k5cHhpN3NaUTBmdTByMnVkVkV5?=
 =?utf-8?B?WGFhZHNLRTZzL0IwV3lkL0RRc0UraFlBQWZTS0NLNVU0dHZ6UllQbHNSWGt4?=
 =?utf-8?B?L1oxRUFXUTJRZm4waGZidGVjR3E0eEpHUjc0bDF5Slo3dC9rUmpBb2tMOFZG?=
 =?utf-8?B?TjhxRjNvbzhBa01ZZXAvY2x0eHhvK2pqMktBMkJUOElJWWFzVlVSekhnNUgx?=
 =?utf-8?B?WUFLVHpEMHFTZVJzNER1VnBabWlCa3IvNS9hNmJvaXJSTzYrOVFMYUtPOFhs?=
 =?utf-8?B?dmZKVkNuRFczUldlcjE1ZXV1MHBDNGc3aHQ1T1FwYlQzVmg2b2VTeERTOXpY?=
 =?utf-8?B?SHVPVWxqVjJON0JObVJuRjVva3FrcG9Pc2o2alIyZnlldnpiakQ2VUliOUo3?=
 =?utf-8?B?OGxoU3Z5NFhGMnZlQ3NJc0RzSEUrZWsvamdCRXdTTHNyVXUrRGMxb29sNGIy?=
 =?utf-8?B?S2ZYR2VUY0kxcXdSZEJodVhhQWVuV1g2M0JoaG5qblJLdWxLekZrd3QvVWFT?=
 =?utf-8?B?YzQxOUhnRlBkb3hNSmhuZ3VyNXJDMG5UdVZtSDg3aVhmUFF0R0tXZlpSdzYv?=
 =?utf-8?B?dysxNGtaRXg1Y1k3RStqWk51a2lzTEpKWlNIcWpFSlJIK1BHcTlWUG1SVFc3?=
 =?utf-8?B?Skx5Z0d5V3JxV2E3a0YybDBmOU9kZmlZaW9jalFLQUJtWHJUUG9vMjZldU96?=
 =?utf-8?B?ZmxsQTRqNDkwWmp1cWVPckNaYkJKVW9EVFpLY1JUZm5QalBMNFhDZU1OUGha?=
 =?utf-8?B?TUlBRS9hMnh4eFNidWVRM0huaS9NVUl3UjE4QndKdWl4ak91QUU0ZjRtMUxN?=
 =?utf-8?B?ektaWjZURWZNckpwY2lvY2h4LzNyWitCeDd6UjdUeVBRUkVCS2NEY1lNUUIr?=
 =?utf-8?B?eFR5eXdLVE9GbzkzYkxBMlNyT2RLckp0akE1bHYyTTROWGJIaXVMUEhvWmRa?=
 =?utf-8?B?d2YrYml0dzBaNVMwdjBjV3Z6ZzBpd2FEQWtQRkNZUmNwTWQxZnluLzZuTEtZ?=
 =?utf-8?B?VjFQeFppOXdCZmMyaGpDLzlURjZBYTFoNFNaTGU3bW1jRTkxK2czRHoyOWZY?=
 =?utf-8?B?WXlwYU1zUXNDeGorUTVWblBxVzd5YzNMeWtDZStUaTBDZ2FuQk5pb2tMUnp6?=
 =?utf-8?B?dU9oOEt2Mzl2azBkN2gxSnIweUJ6d1pKSkxLMmpmMlA4c2Z1U2tadE5YT29X?=
 =?utf-8?B?SmQyU0JjdGRZZWZHdFFlT3J3TTRTazB0T2F2ZktpWXhuTzRzejdzaFdlM2p4?=
 =?utf-8?B?emFPekFqM1RDRlNHV0NETWxkN29sOFFNY1dzK2lWUWZNL0F5a0VjeUxzcUR2?=
 =?utf-8?B?c09QSFU2WkFLTExPZldEK3BzUkVZRXROV3I3ODJyNHNLa1lTR1hjTW1FN1Bl?=
 =?utf-8?B?UHY1a2xYTVYvNmpkVkQvOUhSOGxOamQwS255SGwyWFZGTmNxcU8rNnJ6Nmo3?=
 =?utf-8?B?dHpjNkcrcWxsTDJvYVd3ZXhieWd0cXdhN01QR0ErN2VLcmtpRlV4SkQvcVVG?=
 =?utf-8?B?eUczRkN1cW85OW02c2JpMWxNYjAzVzBzaWp1VzRtM2FvUVh0ZlgvMkZFTUt1?=
 =?utf-8?B?NHptVFZkUWlPWHhQVWZ4ODlmWHF1M3lLUzFXMm5NS3pUaGNHVlh6a0pUbURJ?=
 =?utf-8?B?TUR2TCtZZVlQUzZNNGZKaXlhQzRDN0puMEY0SW9LOU5EdkRZNjJ2TGZ3Y0k1?=
 =?utf-8?B?dmorSHI4N21NMXBhdk5YekhVeEtWaHZ1ZldVdHU0MXpYdUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGtZV21qNldMVEcxZGdnMmd1akRLS3dlUXg3d3V1WXVDSU1vUGRWS2ZYUGhp?=
 =?utf-8?B?UnVwK2l5VWppMXZOaVZtTWdiblh0RURLbzQ1TjNVUTdMMUZFVDV1d2kwaUhC?=
 =?utf-8?B?ZU10SnpldzZweXFLRzJsK2UrTlQrMmROdkFsSUFLaHV1ZUd1ZUlBOHZWYmxj?=
 =?utf-8?B?YWdWNnVvdW9zZUJ1bDZZQkN1RDg1M1JUZUtkNUc3cWpNOGhFT0k4QlJrZnFC?=
 =?utf-8?B?cFRhdGhzdDdHVmVNNkJwc2o3MG92YlR1aDFHU3dxWHRNWG9DeVhUa2ZMbkFE?=
 =?utf-8?B?bHFoYXU0MTRPQU1hQzBvTzR6QmhWbGxGT1VvYm0zT3ZjQmZDSDJYY2ZVYUwv?=
 =?utf-8?B?Q2NoVWIvVER2WE5VV0M0SXlnWXp3azNxbGdHRFFndkdnYkM5aFZMQU5xaFRW?=
 =?utf-8?B?d3NpWjdVcDJySER3Nm93R293WjhITFZiYnVtUGxhNXRqNDROY3djN1c1ejlT?=
 =?utf-8?B?VVhlNnRDeW1iSU0wT0VBZHF1MHVEWGNLenQvTkVOckxCc0lVd2YxSHNvUjlZ?=
 =?utf-8?B?Y3ZQc0EwNFBxQ1kwYmF3dW8ybXFoTWJ0ZFZ6aDBOanUyei95cnRjM28yZjBy?=
 =?utf-8?B?ZUVuQWM3QVlXNFBhcU9TbG9YRnFnbmV3dFV6K2dtSU1wMW1OampoOXNESmNv?=
 =?utf-8?B?NVl5NTM3cDlXOSt0ZlZaQWhBRzBlZWl3WmZxYVhuNktteG1mTk9wWFMvQk9m?=
 =?utf-8?B?ZGxXSFQySXhpZXl4K3U5OTVPbDlhbERxc0tqQnlDaXJLVm0yNk5rU1Q5UHQ2?=
 =?utf-8?B?RWpabTJ0eEhKUFlOSGZRT0VadmkrczBOdkF3Y1pKN21DT3hyckcybHBoMy9U?=
 =?utf-8?B?aGtwUVIwODRucGlzK1RUczdSKzlCZnVYVlQzWjNRNUljNGdaZ0RKUHAzSWc2?=
 =?utf-8?B?TzlZaDB0Tk90MnJjQzJhMG1Jakx0RDgvQU9IZm9CTE5TZmRUZDRLb3pBZUR4?=
 =?utf-8?B?UnVZbDVUMlRMNnAvMUNQeExyekh5SUIvaktrK0l5NUZ2aXgyWS9XL211ZGNV?=
 =?utf-8?B?ZnMxQlc4dHl3bGxxNDZVZXdSQW5lN3V5cC96VlY5aHF5Qi9MOHQ3dElVYWI3?=
 =?utf-8?B?MGw2QzJETmhQNkxwMml1Sno4Z2gvSmRqaFJtcWxiZ3pzQStJUjJjT2U5dzJo?=
 =?utf-8?B?ZUtYNXF1LzJKS25WYW5uclpxQWNRa2Z5cFJ3QXY0Qi9UdkZ6UUs1a0JWa21p?=
 =?utf-8?B?b2pmVzVUK1Bya2JEdC8yM2IxUXg3Y0Rid0hsdWVabTIrYTRWNUpNd1ZkaXor?=
 =?utf-8?B?cmduejNSZUJmWk8zRmdNcFlGUGg5S2xZUGxXY1RPZEtWYkMvcGxxdFRGZm4x?=
 =?utf-8?B?aWVObFBSY1RhTUFVQzdobzJ5K0xMTzZrK3hWeUlsdTlwZkk1NW1EL25yZEFU?=
 =?utf-8?B?K2U3MWpJY2JYNWwzZjh2UEZ3KzBxQTZJaDlFWDg2UUk5UUIvd0JvTmZRTE5z?=
 =?utf-8?B?WlhqVHE2SXJGdHZ0cWdRRllQMURRK3VOVGkrZDZ4V2NpbjJLWjJXN0o0cVY3?=
 =?utf-8?B?NGU0a1Mra2g5MEhCSDVibEVUV0l6R3BIK1dHWTVjN2NlRFlTQWNjRGlwWkEv?=
 =?utf-8?B?T3NFZFdlckF4SmI2WmxSMlhiTkJYZ2ZxY1lERHAyR1MydWpxN0kveHh5dkxi?=
 =?utf-8?B?dkRyMFN6ckxRNkd1NC80U3JQajZ5UTRybVRDeTlRVk9pOW5HdzdzZ0VwM3Bt?=
 =?utf-8?B?c1E2OUNYVXNZczg1bzNqY2U1a1kwR3pEV212MW81RVV6Q2N0TzBQNldZY0N5?=
 =?utf-8?B?OU9CK3VlTys0MXo0NjRGaldoZWNWTUo0SW5seFhYVzI2MXUyZkVFMkZkdUdD?=
 =?utf-8?B?ZGNyWkx3b21kTmwwRGczcEZXOTJLc1l5SmNRcTJlQ2tEbk9ZalBER2RtS3Bn?=
 =?utf-8?B?RGZHcWN3Lzl3eXB2dFU0UGVjRnFOWUZZeXJxSTFCdE9ZRWNrVklkRlorSVpN?=
 =?utf-8?B?NExvcHJnZ1V4YVlzSkFFTzQrSUJUSTd5ek9VTElma0l5QmIzeWFZdExSS0lJ?=
 =?utf-8?B?ejlUZjB6MmtJZ28wa2Z5ZmE4MkVKanpremtKVzBGRG9GN3FLSGZZdFoyYlZV?=
 =?utf-8?B?TDRqQmNEOFJ6R283MmZqZkdtc0w3SSt6NWsrS3hHMkJLbTYySmxYbjJXaDFh?=
 =?utf-8?Q?iSyjvtRAzPIbcFwgp/8JNNUSY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <435708FD908A9D44B190A2C91B64DD77@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eLHI2DCYDa41kOj2HfVlcjdkdeDz4a4+kd1QoJZABww9myN/m+RR+ac8qucHduNcQydIB3I5v7L1Lc4q8nQlwy0vJHBuB4YAyNKDJnhyY/RLmd7akg1GEmASjJuJdEvlKxBT9SZOfcWxNEUD9wzlBiq6m7k+1XyOm+mZoDxxcf6mq1fbf03Q1Oe60VfsoZMoJsMiN80PVS0PqW3SLuzZf2WeEUZ5IJNHU2Nit9yx45hr9wICE4gdbxsNg2hRKpJZ4EY4XnS00yxB8GN6sMKzC7i9KavKFdEl5VGV/G/A1kZUmBObeXqkOzMv12qXTvL00R2eVWD1ZunfWimh/Fo1k7Le6412EI1iCIrXwsquUkSJcBb07NJu/BblqWhsnKZpyvgNFzPS1RuuaH1B/+Msl+yinacF36YlpOzxZlzMkbPsWBeK+K3JByP3cX63dwNiIX40VyNs2QkrgYpL8Jzbr4xJGHASvA0FrncMlG9mIIrnBAG+IxlmYtXkGrEMRlijDCUt/ssOriJUk8LcRPgnsV5/5/05Ooo3MY2qDY+gJEL3rR5kZr+q2bgJRaENtGFcU6HmjOepHVp5pxyd/gcM5y5ej3AEisHVQNX1F6Prtg5e9yfoK4A3CVeiNXC8hVU0ERakj0U8t8Zl+BbLpcFsUQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6152e8-9827-4a2d-2ebf-08dcbe3d597d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 21:49:48.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22ZH1Q3/Xu+eJGEXMFtgwFxWlJudC9rH3N+QDTocxWKmzyqQH/JzwOuyQ9talsA+aM4klJ1Lr74MKiCzr/qyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-Proofpoint-GUID: HCFeFoHt_CBa23L3V9OMuVi6azikdN21
X-Proofpoint-ORIG-GUID: HCFeFoHt_CBa23L3V9OMuVi6azikdN21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=482
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160155

T24gRnJpLCBBdWcgMTYsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBXaGVuIG9wZXJhdGlu
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
cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiB2MjogIFJlZmFjdG9yZWQgdGhlIHBh
dGNoIGFzIHN1Z2dlc3RlZCBpbiB2MSBkaXNjdXNzaW9uLg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgfCAyNCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA4OWZjNjkwZmRm
MzQuLjNmNjM0MjA5YzViOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0zMjcsMzAgKzMyNyw2
IEBAIGludCBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZChzdHJ1Y3QgZHdjM19lcCAqZGVwLCB1bnNp
Z25lZCBpbnQgY21kLA0KPiAgCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZ
Q0ZHKDApLCByZWcpOw0KDQpDYW4geW91IGNhcHR1cmUgdGhlIG5vdGVzIEkgcHJvdmlkZWQgZXhw
bGFpbmluZyB3aHkgd2UgY2FuIGlzc3VlIFN0YXJ0DQpUcmFuc2ZlciB3aXRob3V0IGNoZWNraW5n
IGZvciBMMS9MMi9VMyBzdGF0ZXMgb24gdG9wIG9mIHRoaXMgZnVuY3Rpb24/DQoNClRoYW5rcywN
ClRoaW5oDQoNCj4gIAl9DQo+ICANCj4gLQlpZiAoRFdDM19ERVBDTURfQ01EKGNtZCkgPT0gRFdD
M19ERVBDTURfU1RBUlRUUkFOU0ZFUikgew0KPiAtCQlpbnQgbGlua19zdGF0ZTsNCj4gLQ0KPiAt
CQkvKg0KPiAtCQkgKiBJbml0aWF0ZSByZW1vdGUgd2FrZXVwIGlmIHRoZSBsaW5rIHN0YXRlIGlz
IGluIFUzIHdoZW4NCj4gLQkJICogb3BlcmF0aW5nIGluIFNTL1NTUCBvciBMMS9MMiB3aGVuIG9w
ZXJhdGluZyBpbiBIUy9GUy4gSWYgdGhlDQo+IC0JCSAqIGxpbmsgc3RhdGUgaXMgaW4gVTEvVTIs
IG5vIHJlbW90ZSB3YWtldXAgaXMgbmVlZGVkLiBUaGUgU3RhcnQNCj4gLQkJICogVHJhbnNmZXIg
Y29tbWFuZCB3aWxsIGluaXRpYXRlIHRoZSBsaW5rIHJlY292ZXJ5Lg0KPiAtCQkgKi8NCj4gLQkJ
bGlua19zdGF0ZSA9IGR3YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+IC0JCXN3aXRj
aCAobGlua19zdGF0ZSkgew0KPiAtCQljYXNlIERXQzNfTElOS19TVEFURV9VMjoNCj4gLQkJCWlm
IChkd2MtPmdhZGdldC0+c3BlZWQgPj0gVVNCX1NQRUVEX1NVUEVSKQ0KPiAtCQkJCWJyZWFrOw0K
PiAtDQo+IC0JCQlmYWxsdGhyb3VnaDsNCj4gLQkJY2FzZSBEV0MzX0xJTktfU1RBVEVfVTM6DQo+
IC0JCQlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dha2V1cChkd2MsIGZhbHNlKTsNCj4gLQkJCWRldl9X
QVJOX09OQ0UoZHdjLT5kZXYsIHJldCwgIndha2V1cCBmYWlsZWQgLS0+ICVkXG4iLA0KPiAtCQkJ
CQlyZXQpOw0KPiAtCQkJYnJlYWs7DQo+IC0JCX0NCj4gLQl9DQo+IC0NCj4gIAkvKg0KPiAgCSAq
IEZvciBzb21lIGNvbW1hbmRzIHN1Y2ggYXMgVXBkYXRlIFRyYW5zZmVyIGNvbW1hbmQsIERFUENN
RFBBUm4NCj4gIAkgKiByZWdpc3RlcnMgYXJlIHJlc2VydmVkLiBTaW5jZSB0aGUgZHJpdmVyIG9m
dGVuIHNlbmRzIFVwZGF0ZSBUcmFuc2Zlcg0KPiAtLSANCj4gMi4yNS4xDQo+IA==

