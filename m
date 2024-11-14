Return-Path: <stable+bounces-92967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E89C7FA6
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 02:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA612811A7
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885E1C3F26;
	Thu, 14 Nov 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tfqcnSw5";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UtLP9ZLd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fPGld+7m"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CC1C3045;
	Thu, 14 Nov 2024 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546136; cv=fail; b=vF/mGRthY1gHSW5DkLP7Ku/M56S2g0xi8xlkGyN7Kd0TuyfF0JGXAYiomWdUVo7Ovo8NPiyV9JejzxUxZdl/Ci6W+hM1/hdYQ6mA/FLdjF9AlHemfUtLZ0/diXhWXugoErNhKh0BqO1+9PG0+xThsQbzwftDNNcmDhTEFhnwY5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546136; c=relaxed/simple;
	bh=D9NrUQWM6ig3Xfgr9K9voYdPv1enmUGl50vaCUc4d2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fTFyEoaT3FvktwxLI1vEWKcCCqozWKPtkyqNujYM2eoi4TsAoprami7Z4UEY/0sKyzttq9AoruWBp1fQv7SsdNlGacghNCy+s8YWTBSPoRSJ07gbvKMxpyiXu6u8ImoCnDeIyaNz5Ix3pXr1RR6ZGSw67rNlXSUNspDD/VwrztU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tfqcnSw5; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UtLP9ZLd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fPGld+7m reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADI9D8j013119;
	Wed, 13 Nov 2024 17:02:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=SzRyBh8TktTqS1eEjX7Dq0+VO8Td4AwIXQKwKEanIjI=; b=tfqcnSw5gO9u
	d9xeLUjz9cMQxxOqx2QGgv42wkfLU54wNxd2/86JQsiQ5VIGDIBoGgyVzUPgDKxN
	la7w6zga2KEp8QMkN6W5b95bSD9HGI0qbwHfhYnXDqOCvdT9Ta4MQwsSldr2Rxp2
	7xf1mIZsxeVCAq7pHUskeZrehmHsmx7qqb/YNfIBpwlnprzVBdkG15uRqahnt+eX
	STT8xYZhqgGYMLvSvWt6gVr7MDRie0BltHdMhT7dyi6Dhmxo/nHbaUq/+bsUswo9
	FQBpeHJhrSXwqxDXXIW4iSGEl8RdQnwTkH1yiBETlgdPPmligJRhOD/thmRSv9Vi
	W0qrdj4pFQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42t7mu9yu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 17:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731546132; bh=D9NrUQWM6ig3Xfgr9K9voYdPv1enmUGl50vaCUc4d2s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UtLP9ZLdCUEF9RW9mJnrvVaKI53vhDBnXgMv+IZ5wB+kHVqSoplUyo4NC/udero3a
	 OYlv4wgLRojMjb3ZmSQ2cdvqUiAiPKsZ2TKnOVSkdBNHPquqJfF1yJt50aJ0wxZvPa
	 AxmySXWXloWVkn/1cjEuk2HEt/LAY7m3t9xd/vYVhmlicC2F09R2pnbF4OnVQZE6j/
	 AGsIB4R3/UkA5l4zmvoCDXyaHAQOPz7R6ghbUgCotxfP8FgH/LcSVl3uQI+GXsyL5P
	 ydimmtCgbNSsoQbnGytnQIRDG5aXvzi+rtbe8SBnZeSJmFDfPAMH5xG5wjoh1JKOU7
	 v8/faN5mtkkiQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A33614034F;
	Thu, 14 Nov 2024 01:02:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 218CBA007E;
	Thu, 14 Nov 2024 01:02:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fPGld+7m;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AD37D40424;
	Thu, 14 Nov 2024 01:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT7/v7FJFnfR4tZlIHxdlCeW79lTa0WbaEo1WdCVPit9XHhbD3RG644iOmtYNHoqYy5KyxSqwF/Y59pee0oYfXcp2XFPVCSi1sT+0DVxApLiCptMP0ouLHNwbIYihiusYTFcMCrqzQ43ZhyoaUTbUrAb8SXz8L29CEwQ20pYMBOkWuWbUydkfAfViXsM4UHGIjxtDk77l18udZFPM324Kba60O5qDJi8/+LJxm6zNWdYCrMlBUoGm6sjN+iCN6GVlgWRX0MkUFBU3XtdxRG/Sisv7DS/QDFQmCDOhWysoXfnarU6PRFkWw/82dRON1U0P8Cob1yLXw3uXUEOMa3NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzRyBh8TktTqS1eEjX7Dq0+VO8Td4AwIXQKwKEanIjI=;
 b=nYXbZu7kxROITiNYXGFN3p6CNPmeMupIkA/9xUVZdOhpoKI0DHpPMto1u0O7oNLEtspaYdE77/W/HRvMinV7SrORMGNBSvWZBgT+DDVglUg7+ADybxkQ0spVPQ1sQ4dTCez94i/KNA4/JfypDk8iTwNhi2e1gj36ezDn47reZhzN946nuZkwRcSF7w7+vnopzTUihM/Jy06HLRyUwAb0ToBLi8RfJHv0Fzsx6nEip5Qf1ZLBivX7h0yoRUH7UdWX6YgcM1V8qKLIeUfQ+oAKN8xFLjN39eS2qx7/UfrO74Rq1zKs0qUADvpz265p2upNUGXRQyN0UlCFkmY4+4qTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzRyBh8TktTqS1eEjX7Dq0+VO8Td4AwIXQKwKEanIjI=;
 b=fPGld+7mgWF4TxwswZexNMWu++ZvP2+LksMNjmo3HKpet0829CaL8Mf5LkwCW+z8KLpVTnzKquVEMKO1oMKVcOIqaT0QIdLTpfCRrhOJ3Is9QmR73INjp2+vfLT3WQfUOmk4zYqX7Xe/AKK8NBqHY9CS+/p7K98NCXVLqYLt43g=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 01:02:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:02:06 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/5] usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
Thread-Topic: [PATCH 1/5] usb: dwc3: ep0: Don't clear ep0
 DWC3_EP_TRANSFER_STARTED
Thread-Index: AQHbNjDTA4t+gtEQZEqWcTkch/A3og==
Date: Thu, 14 Nov 2024 01:02:06 +0000
Message-ID:
 <d3d618185fd614bb7426352a9fc1199641d3b5f5.1731545781.git.Thinh.Nguyen@synopsys.com>
References: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB7950:EE_
x-ms-office365-filtering-correlation-id: 7e2c01ea-6193-4e1e-aac7-08dd0447f58b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PHc3Isitl/zwK8vrmhOWDo15w7kB6vITjctEEAudml2lHasnigFfxUgqxQ?=
 =?iso-8859-1?Q?m7xyKbfgmm9AoFmwzw1+QrF7gfQpNt3HhNXPNKEz0pggY32eqN5JzyDrDD?=
 =?iso-8859-1?Q?G3IkRDKIAeJZUahyywrr/TFm5WqrEMdKgJ6OF4fHkDXME5jFEDgaf6XoIX?=
 =?iso-8859-1?Q?AMxVL280zhfYCSIVUy0EIN2UpbAHylRaNusAgp5/8CUeUXwQBKsEZUo3Uv?=
 =?iso-8859-1?Q?5j+6zPuVg0TnaGAxOo/dk/mz4dyy64eLJoRME+6I/der8MWeu44K2Ns+17?=
 =?iso-8859-1?Q?mjU2HHtU7RiFvXkrA2gjR7S5mk5g1qYA2veTBwcIpuzBvx4faiuJmUN5oV?=
 =?iso-8859-1?Q?a5drnkTbd5Vz95OSLu6S5ps1KBY06Bjkcm2zBBnoAbMuGrpv9vo2FnB5lq?=
 =?iso-8859-1?Q?gebGYk9jhnQ40NJG7U+YkhTVAJS/8BvazeJoPkC7pby3+fWna/xWoj/ixk?=
 =?iso-8859-1?Q?VcXdVZmGWownISy5e0SpScbwhrfxSDte9K5OFF3g+zSg5ePT50dTO579Fr?=
 =?iso-8859-1?Q?xJTXq2lyHJYpNgmd/eyPeT4IGGy3StlgIWdEQVnZhYCACdrMJsthc/8Wyi?=
 =?iso-8859-1?Q?thoyfh8nM+C6TAG2N/yQUXUw3EAkRRGFUzA12OGWemRApfxz1GMrQuXF8a?=
 =?iso-8859-1?Q?fOG6DWUIRlLV2HMFhYWz6mvhlNWuQaZYleDFDdc6hcZu3+hvd3Hynx2O7/?=
 =?iso-8859-1?Q?QmRY9kg7a1sYy+Qoof251KV3ZUEiE0sErwu8JE1sODQbQiGXv+GEtC5g30?=
 =?iso-8859-1?Q?heReIEDjmk12uOp9gO7YLbShatHmWC1vkeoFDsxsGqZ/xc7hztCAV3dNOB?=
 =?iso-8859-1?Q?zxB/W0aGNo4ioVjECGHcHFYaoSrMWf3+Gl3mcr1jB70A4pUrepoZwXowPa?=
 =?iso-8859-1?Q?s85/eON8RwOX+trdc+mT3UFtdIwXthmIkqLjil+vNrFI6FKoM/QF3TRwQ1?=
 =?iso-8859-1?Q?b7uuzHzrdDLjM0oyEL2iRnhJcYgWBpaSE/FKk43jJGoe3QfFW6ZMVc98ah?=
 =?iso-8859-1?Q?aZYCAv8niEoPE0xIWPy/FSvZ1KAeTjCJZ/IsMgGZgCBuiNjFonthi8ukKc?=
 =?iso-8859-1?Q?EEF/cjWx+hLo6abht6UiNWtO/p0rhKlSa7fqC1DFStITS61V9/PWHm2cYo?=
 =?iso-8859-1?Q?yI5AQm+rpHeB9BiJ15OHnFfWDgkyTSo0/x8JpIZ+BQhiZ9VYOTjTP/NseP?=
 =?iso-8859-1?Q?mKpoj1YeR1Y9CZp+cIiAyHTS9hYX8JS21Wz0C8ngzait7Qbu8+fy7DsPxj?=
 =?iso-8859-1?Q?dS/HwshtZTd9IawJ9YjRJNbxZMljIyl1+tICsCTGTACIdWi9sa5mrmB1Ru?=
 =?iso-8859-1?Q?FSzGnSAFroY4MjLkOka+2A2phcxK2bOVkVFYhszVNAarRcxKl/ti9/iflZ?=
 =?iso-8859-1?Q?WM4WVAvQH2EGiWat1P0lW3/yRJ4Fd2SC28FMAarapf2NiaN0mUJaA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3R1mMmcsG6mIQyPMsmxlDLJETcvhy32axytjJMOxnWVrmtqLIz3AAFXpdB?=
 =?iso-8859-1?Q?+BuHvh85U9qP5XuSdNWxoC/Zd+IL3RGliYIfDVuz7DyFiW9GneoeNS2AzQ?=
 =?iso-8859-1?Q?NWutyMcPMC1xbuQ5e/ILuLv9kQaJsx1TsXVImwxbEToFuOUFPyEpEttf+M?=
 =?iso-8859-1?Q?kWCCg//1fl8RHR+NR8jJeuJxEvC5xpgTV3B/Ci6MhL7ODN+L48Q9OfAi7s?=
 =?iso-8859-1?Q?2pdF1mzU0vq42U9HtLg/z2L+8BPrgJB87vmbLCzCNJNfQ008iweqPldG8g?=
 =?iso-8859-1?Q?jL6sQvYkDMpUiwtxjMMUrISvmXUW2mp5EgIJDEravR3/Xcx8hCYsuo3ZJC?=
 =?iso-8859-1?Q?E3i+M5l+yNdT6MNq7BAVFcpuZiPMVKv6T8nmEgHnaa2Rq7drrHcYbGKvl9?=
 =?iso-8859-1?Q?sfvh76svJ2BiQdsVYCJydqog7n56OQcmhNv2ReFBpTlxcg4dS7gZPhrcH/?=
 =?iso-8859-1?Q?7U2FfC89OzqT2g8Xgj/AGCf2XkoUk2xsSoqZvAHi8yOm7EQjFU02aU7B74?=
 =?iso-8859-1?Q?Yr70pGB18suW6PvN8LWnHtOuVfGEO3OCHLUDtDhBL26jAPyZz08v42AGHs?=
 =?iso-8859-1?Q?g97DgEuwlxdPnkvXQDSxR5rxFStDHhT3nvZNzmxvFYvhLBUSh/z/rylXQ/?=
 =?iso-8859-1?Q?BAT/kijPqTCexjOfuuKU5mRzVZqrerOPEeZv8ZhGd7h8dR3+mdVSxQ7y9A?=
 =?iso-8859-1?Q?/Y/f9Xa9KM7CLLHa3UuJSisiE2pv6nRG7b97nsfbr2PJsVYWhGNJgl4mOW?=
 =?iso-8859-1?Q?/xSyuD79XHFZiWTmKFFlP5qpBs/IPQHhCtTjvFH/s78wYUUXllSiysRNq6?=
 =?iso-8859-1?Q?Ob1TcdFypYWfDIp+iZjefLJCon7v9uGZ7DYnhbdhiA6LJfgZx0XyGmqmqG?=
 =?iso-8859-1?Q?xLvMhfKzMPQGvsosyYIBmJLvNRrlcRn3fuoHZJAH4zjMZiT7aIF0IbhWFk?=
 =?iso-8859-1?Q?R2kbEAOc1Famy9CThDd8Bi68SEU2b9o19+sQ0QX5l3w91j42feDIZyeF5v?=
 =?iso-8859-1?Q?cCct7a3MwBJWErX+D8Jjmi7koL0iIwYJxyJ4bVYifW5GXRyKNUXgtOwtfl?=
 =?iso-8859-1?Q?entlJ8l5zuuOKl2IBAb8HUrvD8oScGiCL8Ergi99qiLyIT2Ctkjcezzlk6?=
 =?iso-8859-1?Q?lHI8eRfCqLdBLzBatqUrDV02H4FX1PabVvedx4SSfYiaEe43HCkiIr7pCE?=
 =?iso-8859-1?Q?/M4sfraNsGDp3mAYFB8wADUnamReBnIFdOt8V3rmE76b0NmgSkw+T44KnW?=
 =?iso-8859-1?Q?4Skdg3mJWU6BO2Sdpx14MLtZIj0ynX1t456mIFCdt078y7ZC359GBUFMl4?=
 =?iso-8859-1?Q?RpXbOMHEgUg9EyuzpuObGs1Zkyjebh0per8uazo89e24YryRfjND8RRqek?=
 =?iso-8859-1?Q?QXkgBufZ7SjenUOYplGVXxr2s6tWrkcURy2UvdnKYam3Dfkv891rVHQmi5?=
 =?iso-8859-1?Q?XxriAfZWiN4SBoSaOboTD/ceEP+LNXXwo3VGXm/gOhOw+1+64chFu29JTH?=
 =?iso-8859-1?Q?g3H6jjQYPzIxxRCGVKX+QuLlVEQ9Ebo9limCPV/K2ZnrA6V7MxQ7jQDfu0?=
 =?iso-8859-1?Q?+H3b8ShMSFLV5xX2EOpVHOk48y5twjUSZrCFxV+YxVt2pFLBOH0HuvkdrC?=
 =?iso-8859-1?Q?g4JR1WAZXGU7A+JWwHTPPP6bAeZ9u4W1pQ?=
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
	j+ZorLAwpbiKMyUlKRjHk71bCI8mmwvobTQBOjyy0aJUr05/W2YW0yTihVZS/8RmSH8A04AhUOxxOB1rJ5PraPPfjsmpl3gTs9ZO4Dwd5NATC96ANaQ87hslwspctWPOW+9t1tCcxWNOhSgbOiT8Bd7ywGyMIuo53Rq98s/xT9pWY0g5D8J6EVMmuUT/T4ZcZeM1+VgjKRLwRIGpXvt03PVsFnDAhm/xBdGxltkWYuhlyDmZ4UPzof7U9t7TiIqgMoF2YhhS2YUnPr3/tfktN0ROOI0IssKs1IorN5kPWi1u3sTJ8XUiZaYGCNqZPaLGKbnjJAszn7Knh8roHf1FX6J6m2Kjz9fMw/U5cSIxAinXN249iT0tYee4CarCuxjzxi6Ie2MKnc0naqbhdWlxBat1Scl4i4MFwrpITwIjxZpQ/tNanenpPMgyRKLaC8+HG8osvz0xc0NKk7Bq6RskBB6wnIhAIHxs4z1k9HdmOevnYUBjsDxSjqK56uDNy/XCL0LOOedlfSwFlhhNpYMmjnUCF1Y9HXfAlxN5vDb58DC48/fFPi3gj55uw0+Pw5iZ3Pz10SrbtwFgR5rzZVmgTTHWf483MS6Uqb3rQxOG2ervVBybTKMN9+BzvkkdlXmOIKSenLkEz3p/9/ixW+RdSQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2c01ea-6193-4e1e-aac7-08dd0447f58b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:02:06.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lw8KpSBSaJv+YJU4yb4YprDOu9Zzc/8R3Zwp3ZHWAFSJEJFjNLz6INDtBarnJDmGx18QsnTpS7njT+EF3kDd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
X-Proofpoint-GUID: JN-pv9gGG3-VPz5z1TtCIJIx7V4OYVfk
X-Proofpoint-ORIG-GUID: JN-pv9gGG3-VPz5z1TtCIJIx7V4OYVfk
X-Authority-Analysis: v=2.4 cv=Y5mqsQeN c=1 sm=1 tr=0 ts=67354c15 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=ekUo5NEpdgRYIMB-EUUA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140005

The driver cannot issue the End Transfer command to the SETUP transfer.
Don't clear DWC3_EP_TRANSFER_STARTED flag to make sure that the driver
won't send Start Transfer command again, which can cause no-resource
error. For example this can occur if the host issues a reset to the
device.

Cc: stable@vger.kernel.org
Fixes: 76cb323f80ac ("usb: dwc3: ep0: clear all EP0 flags")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index f3d97ad5156e..666ac432f52d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep =3D dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags &=3D DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags &=3D DWC3_EP_RESOURCE_ALLOCATED | DWC3_EP_TRANSFER_STARTED;
 	dep->flags |=3D DWC3_EP_ENABLED;
 	dwc->delayed_status =3D false;
=20
--=20
2.28.0

