Return-Path: <stable+bounces-126808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC96A726CD
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 00:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A03A17B122
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A971BEF7D;
	Wed, 26 Mar 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bTtpd1rT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cwW57Nj8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H9QqOJ+J"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524CC2FB;
	Wed, 26 Mar 2025 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743030095; cv=fail; b=Oh2rCEhItzf8ONhvz1Gdltv1LuvICPLIa+dTliOG6bXzMORzTsisadR0SgblQDgOSl62zvxtAV48UZHA/EpiUIdBc4H7e3e28FjOYijHodP3rIKlyN6u3Li/svM2vV5GCtIIYhOt3IKGoaZtUzimF5zYwO2TsdxmEkfS4rS30tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743030095; c=relaxed/simple;
	bh=l/vtI5YEbGsMlny8cBfB9uolc+Ul93/1GPUrgkeDFng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGORXAquYAuclVajOxid4cYsjF4B8UvutaYJH4flbw9CGCLVrMMhBtIl+vqo5DInLGHf3C89vnUtSnHdyM2XPViZl1fb0AOviIIVF/BXYmOC94D7tMeP3XBYw/Ga0E/B0GGQVBeSWZcKtUIgxjwgVFiDs83bRSp1uR29QrU1qCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bTtpd1rT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cwW57Nj8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=H9QqOJ+J reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QMF3dY009307;
	Wed, 26 Mar 2025 16:01:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=l/vtI5YEbGsMlny8cBfB9uolc+Ul93/1GPUrgkeDFng=; b=
	bTtpd1rT6VwQZf3dWgWtqrOcBiYRypHVfYkbRt9GpeYRpPo9G0Q5TiqZ2i4PGmKU
	yVsnIRajRHqSklaGQjOZxw3GKPjxC998N2bxD4k2eMfwZEBemMCdaZ1Cr9gfp+p9
	29cSEV1aU/BgGiSKv/bo84wdkWpr1qPaRD+0KfBLQXOH6AItoxURHeOjRilSVx59
	oIL5po2GGzSPKTrln5QmhSyUEAaiA2VyUNHtpHofwHpM9T6IxwnIxuymJvOm/omW
	RDH5hetCzZC9eNibJbEY8528fYksfSmSvW8ttBZBuAmOq1bvYmbqDyrORvSe3dUC
	wpNZUsITG8oIYHz79fEQ9A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45m4jcpduf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1743030079; bh=l/vtI5YEbGsMlny8cBfB9uolc+Ul93/1GPUrgkeDFng=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cwW57Nj8DNlgYHG8Q8Lz1eQH6CGQ5PFuvxNM9akfjITVLbsUc1WVeNae1+h+Glui1
	 qmvumqxKnrawzIOG36MlpdehRarz04qCzdHZmcTjwXZyFem4USwa+liJVhvfWGcF9i
	 AlbSewoHa2+WG/Aupy940F3u9585v0y+uA6lP8N6q1wmlzT1D0nrctLHYET42wBgze
	 5pa4QHaTyH3VJoJf4mtK2t89OK6+PeFQXQ0hObvTiIiOkCAACL4k/O+gdraCT2Sxyh
	 xm7NmbZHVSqK1frrB+U7sdRB5Zx9JW6vc0wSIWpREV7tpZkpuwe+QK5mU9uZCA13Uh
	 Nv1wVu4Xdc7Ew==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E86584052E;
	Wed, 26 Mar 2025 23:01:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 970DEA0096;
	Wed, 26 Mar 2025 23:01:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=H9QqOJ+J;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E403C4013A;
	Wed, 26 Mar 2025 23:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYD9dWKK3JGP4xRqSp1350x4HPoeMukHEWI9S/wpvQ207qgL9XilHN6ofUHm+YRPALoFutDPJAUqEIIvqUPS6b70ZEX5Gcx8U4I80A4wQwoL1sHk6HpWaHajhZE/fJM3Q05qnpm7PcuEXN/t25Rwq2Psb7Box1GRM6Wn/3qwb00ElGvakGWGMp68YLU9LeaIeQxHQ4Sma4Ee1NFPZfpSQzxgxbYl21lZBRPiXkILIaPBH5DY9fNUuhVhMjGFbGSduPEB0MRnqoP5TVS/vXV+4+04q00+/7LaGbITRXA0VbYKzHhXmEQWWzzKxEVZD9eOyf6JyKqcNqcf5BsiV4tkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/vtI5YEbGsMlny8cBfB9uolc+Ul93/1GPUrgkeDFng=;
 b=GbOxL/1u/rBzZOYI+/6oMRz0nMwoxh//WlQH0/7LvCNJsjoyALWJgMkU2AN9FlAhxaDGudSoxZrBAotf9dHw6b7RayiIYcZC1gc9FGHGao7tt+bqJ67yRcF89O1tsGsl0waFkp+kGMceEE/J7IGWdAvXct5UUiUw7dPpirxgpwTIQJ3V9PaJrnUV3+JmWlUnV3yB1Ry3LGwUDEYxD0uDg2sst55ZUeWOmDoAg6+k9LdrujTQC5Kz4K5mwvxCzhfdjvt4X7vZlSJXEbrXdZ84yCylzuVbvJ2VWikIoxGY9MMDt5GlAbHlq4DthjzjqlUh/SDHP0o3dy2TV6RqnpFJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/vtI5YEbGsMlny8cBfB9uolc+Ul93/1GPUrgkeDFng=;
 b=H9QqOJ+J8qli78u2F1Ka5YRQ8SRRNiJxJtDEIwSUeVbPbyfosjZZWjcyQxyt7iYOzJ9j+gT+2QgROAmC9h/KOXTOYXx1BImrv8//QrAdDsbgsiMXxkJRGpE9LAp+ksVJZVhNYJxIyLYs9BL9YX1jyn/bggEkw+hBRAwUMJTrz7c=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 23:01:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 23:01:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Topic: [PATCH v2] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Index: AQHbnGtrEDBrrqhzOEqY0dxgDti3n7OGDReA
Date: Wed, 26 Mar 2025 23:01:14 +0000
Message-ID: <20250326230111.e4jn3jy2xx2lrote@synopsys.com>
References: <20250324031758.865242-1-khtsai@google.com>
In-Reply-To: <20250324031758.865242-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4084:EE_
x-ms-office365-filtering-correlation-id: 90c58735-834d-451d-9dcf-08dd6cba1c24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnVDcHdYR3o2NkJCd2MyemlacEpYSGRhbUl4bSt3Nzh0R1VDWUJ0L01HREVR?=
 =?utf-8?B?aG5mNThNZFZYVHdWeElub0NqYzEzbFM2ZlM2Y0FsV0p1dWFHV3dCRlVsUzFl?=
 =?utf-8?B?aE9La0NzcDB6TjZjamdSeDZSMWJKSXZjOEh1QWpFY2Y1R3Z4WHZIcmcvZHdB?=
 =?utf-8?B?cUZlUnhvenZlU0F4RnJzYlNpTkhwMzFmS0RzcmtoWk9kemFJenhPaVdtWGFi?=
 =?utf-8?B?bzJWN00zQXZZYzZQdTBpNW9hcENyVWcxcU8vVnJTV3VwUWJnd1pYSUo1eDVp?=
 =?utf-8?B?MVRETGZ6RDlyQ3ZKb2I3Wm53RW5ybGVSR0hZWW9XcytvSG1mK3JjdlltOVQz?=
 =?utf-8?B?THJnWmMrS3NRUjFGWEtpQ3BTTTgyRnVXQSs0TkNHRTFGd0tFNHh3K0NJeDU2?=
 =?utf-8?B?YSt5UlJWcSt2ODJpNS9GQ2llQ1cvYW03ZjBzT3Q0WTQxd2FJSFowS2F3a25W?=
 =?utf-8?B?U0FkTmRIRlJkdGxjMmhnUk9KQkRyZVZhMi9hYnB0TnJydS9yS2JtVnZuTW9Y?=
 =?utf-8?B?ZlNFcTBhY2hZN2dwVG5DcXVRcmxIK2lLV1hQUlhKVGZFU0VEZGhBcDdDVTJB?=
 =?utf-8?B?U2JxVmI4bi9rSjlCNzU5UURTVVpuY0RpSXRkOVh5RE5zNmZHZVdndUJoRldT?=
 =?utf-8?B?QzVuc2xmMHVoejJ3TzdEY2R0NjcvbVpud0NDd2h0a2htVCt0QXZKaStuaG5x?=
 =?utf-8?B?d2V5NWg0NEJLMFQrK1VjMDV3Y1VNMTUrSDBsclBseFRsa3NYaDJqRU9BaGt2?=
 =?utf-8?B?Q05XVTVIU3dqNTZ0c0dHUVl1RGdhZnU3T3ljYlAvU0RZbFNmWlQzc1U3UTZz?=
 =?utf-8?B?TzdSaXNxbksxUnYzdmV1QTd5RUVBZ0M3NkU1QVVjUEZhMWY1YzhWNVFGMlNj?=
 =?utf-8?B?a2M1QkE4RFBFZ3FkZnNoVjAvN2FVdU9DczE3ZG9GVmZ2Q2cyWDdjZ25UU29E?=
 =?utf-8?B?a0l6ZlZCMjNVbVltallNcmFXZE0zSXFaQ09yTHU0dU94T0FQajd5eGorV2E1?=
 =?utf-8?B?WndVOVE3RGpiWm9DSDhNb0tIenk0YVhSUFpmUGhBSTMvNnNVOGNPWUw4VU1i?=
 =?utf-8?B?cVNjcmo4cXE5bERWMjNxMUpqSFVZZ3g0S0hWbnE5R3d5SVpZSGNrbFNob0J5?=
 =?utf-8?B?dDM0TDd6WmdXWG1LMDdDT0QrU1ViNStnYWlvcy9lcHhkMDM0TzBKaWF0YkZJ?=
 =?utf-8?B?Qy9jMTVKQmpEZ21YTi8wbmw5REdVc1RGYzRLVWQxVFplTEpNU3ZlaUJsM3pZ?=
 =?utf-8?B?aFppaW9kcDNhdWN4UTBFbDJ5b1Fkb2tRcUhUOHFETCtmeGRHeFpLNGNwb3dG?=
 =?utf-8?B?enBkelprb3lvN2E2ek5kOXY2NFJqYXl1MXhicWhMeVh4ZkpQdnpJa0pRaEZs?=
 =?utf-8?B?Y1d6Tmt3WUJZTWg2Qyt3WEU2Lzlkc1hBVVV6ejlMMDE4NXVSVklTRmIwWWsy?=
 =?utf-8?B?SzJ3NjNHMit6OElINGV3NHN2enpFUUJDUXY2SU52VDU0NWw4bDZiN1VldlNC?=
 =?utf-8?B?ZnRUQnptV0pmdlpRclNwSW9Ra0UxNFpPemIxUU1Dbkdtc0QvckIxVkY5ZzJH?=
 =?utf-8?B?ejhqWjIrYStrcG1tdEZ0aHdxSmVoQ3BDUmszd0huTk81UDVjNjdjMEJsTTV1?=
 =?utf-8?B?a1VnTXF5V0RmMmhaSUxTYjFtV0NSMUdjSDg2TXZlUkJES1VzSWg2NW1PSHRJ?=
 =?utf-8?B?TldNZUE1MDBDM280S2NkYmZJVVY5TUhJb1VqSXZZaGM0dndxN3Y1K0VEYU1u?=
 =?utf-8?B?d2RsQld5Z2lEVk5TN0Foc2xLQzcxazFYT05OL2RqajdzNi83L01rbUd6cHV5?=
 =?utf-8?B?UmM0eFI3V1NVblNFSmtLUFZPK1VTS3NrbXdVMndPa2FTRURzVWlJU3EvSlNB?=
 =?utf-8?B?VG1oeFlKQlUwbHJIUEVBSmRQQ3lwR2pNcDZUT1Z1MmNaODUzVnltaHZvRk1m?=
 =?utf-8?B?U1NEUm41Y2xncW80UVNXcmE4Y0FTRHRHcUdqNit3aHlmUTBDaEdMYWhkUFlx?=
 =?utf-8?B?WDhQblZZbGlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmU2Nm9vZS96akowRkdkb0k1UXNVZmdRS0FjTUJmNnZZeERIRW5lNU8ySUlK?=
 =?utf-8?B?WFRRNy9pZzl1ajA1VDMwelBnTGcvR2poYVJTTTNON1pKdGgxTE1DK3JWQ05o?=
 =?utf-8?B?cHNOeXFRMlpBUUZMcWJObkdhUEVud29lU3FWUTBRV0dtQ2d6cWl3V2pFQlB3?=
 =?utf-8?B?VG9SVm5LWk5pdzhGdGpldUNmcVFpb2VzT0NJZUNPZ1kyWWpNdG12VWRNeEds?=
 =?utf-8?B?V3FBSTluSGdJZTlneFhRM3BEQUx6emg5Vjh3WkZ1bkJtM1djWEJ3ZjR6NXho?=
 =?utf-8?B?TjdpbjByUXhRdHgzbklmT1lmbFBnOVhBdmRpNDdzOHlUK3NMSmtvTXpNUGlQ?=
 =?utf-8?B?dUFvSVZBTnpEN0JGSHIzRk5VY0piOW1rNE1aTS9LdXZjL3ZPOGhlYlZYcmZj?=
 =?utf-8?B?WXNKbFUwdEMrc1BaaUFDWit1OHhKckhiWTJYTklrcXRORDR3bHBTWXVUVWkw?=
 =?utf-8?B?dWxrUy9IOXI4YjNLWS9mRkZQbVRoazdLcHFCRFBJNkxTbC85UEo2d1VtT0xI?=
 =?utf-8?B?b3NCc1Y5ZUdwd2VtZC9EWEpDSTRWK3Z4RGROc21NRE50UVA1TS96dC9zanlt?=
 =?utf-8?B?ZzFHZDIyazFJWExsM1RuR0s5RzY0QlVjY2c0MXRack9GVUV4Smx6aFdnOXZh?=
 =?utf-8?B?ZDRFVFFSL2kxWWtaSThKNjdKSVRtNU55a3hyUEUwSDFidWR0dkZZbVJNUjcw?=
 =?utf-8?B?czV5aENVbkRvb3MwQXlmQW1HQmZ1WW9rd0gycGtjakpycklFMERDcG14UzRt?=
 =?utf-8?B?TFRtWUNlSVZ2eHgwcW5FcFZuMmx6MER0US83VFU1SnBQV0lLK2NIWTFXWEky?=
 =?utf-8?B?TzFSL0xXYXExN2trcHFJbUc0M1l5cE1iQy9TT0xSQXlQK0wrb0hwSjhScVIv?=
 =?utf-8?B?Zjh0WmVlTTVNVnRabHcwZ0VrbVJibjU3S2d6emlBeFBGU2w1dUxTc05QU0cw?=
 =?utf-8?B?OVVjZjJLclVXb3pWMnFMQlg2NlJVQVBxU1ZlVlpranJXdWdQT3Q0eEFwQVlt?=
 =?utf-8?B?b1FoRnlreGI0K2Y1TEg4a3NIR2x3WkM0aWdUcmlCZGdWMkNtYXhldzVDWHJG?=
 =?utf-8?B?N1p3REQwOVNXWXdOeExYd1Nyd2FSSWpDVUZBZDhGeFlXUDZRcEova0h4WmNH?=
 =?utf-8?B?N1Y5eWkxTkRUam5pam1HTkRKYnp0VEhlVXNUeEUyaEtLYW5wZVlUbUZ0M2lr?=
 =?utf-8?B?MHFmRVJNT0NUQkhYMkJZUEE3YVRuU013M0g0YXdHbGhsVEQ3Z2RXR3ZoK1VD?=
 =?utf-8?B?RnlvUHUvZGgvZEx5ejl5ZlBCLzlTMS9OUVVoRTB3dmw2TmZQRitsZU1CcFps?=
 =?utf-8?B?YldzMlFvWVB4VXNzdmJpZ0lBWEZ2ZFgwZTduNkJBNHBxR2RzUitwd0t0N2Qv?=
 =?utf-8?B?M3ZqVFUrSVJWbFRPRzQ0WGlPNzVhcko4Rk1UNW45QzViNGFQVkJMN1dqTXJU?=
 =?utf-8?B?ZW50OG9HUXNoQS9OYkhuODRNRjRPSkxaN2xsakF2RUhqQkY5dytxRUVjdFZR?=
 =?utf-8?B?bFVKZHJvekVRYi9vbDlQQnhvenBqcDFiVjFYUDJPSnlwMHoxald6NW1QQjJJ?=
 =?utf-8?B?dHBYSHVpaGprcEc5WGlJSHcxTGx2Qy9LVnJQYjZxWHdKWG5lbVpCZDB6ZG9F?=
 =?utf-8?B?TURtL2toVDR0dndKT1BXSlYxb0Z3c1hVazVHdk1lcFhGVWYyQ3dzNVFrNXR3?=
 =?utf-8?B?VHR2Ri9rMU1OU1BOMG1JNXRscVlONDI0Z3J4aTdFc2M2TGdYQXV4K1NURFI0?=
 =?utf-8?B?WUFkdUp0ZlJLQSs5V2VCZm9SUzVsbjhaT2QxUVdEL0JEU1R0NlNTSFJNRmhN?=
 =?utf-8?B?ME5UNjIzbHoyWEpXNDFVaFZsSWVwRzBvSkZLSVRiajRZWEtIWmlBREttL3Za?=
 =?utf-8?B?aXlaSDZhV3hLMVhLZDJNNWs5NnRoVUlMYXE3eHg0SHpOZWpaUno3aXo4Sjhq?=
 =?utf-8?B?elFiZy9uRUVqWU0vZU83TDNPMjkxQWF4dDY3dkV0dmhQLzVrWk4xS2JKaDVN?=
 =?utf-8?B?WTFyS3lKUnVqZUMyY3dpblRPTnFlYy85RXY0SHhhcm5NTWw1QzZaSmFmSGZS?=
 =?utf-8?B?ZDd6aDIyL0FIamxuclRqbWFwbEM1b3ByVHNpZVh5clJkczVGbzhaRm55dlJP?=
 =?utf-8?Q?6n0wq0ayxO3JovEgDaho96doW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62D3DDA8E991324D8D4A2601A0DB7D1A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ApKzncsHs8VOl6PnOGhdgYKpAyMLtBqKFm7WjQD8qG2dzTX4BJn7gMuej5nWatQELPPh6X/XC3VvTsl1yW9RIkph34HhSGlWHRaaBIBVgmaGEe5PJQr+/Rgfk0IDWMiHDcy9W9NT165AklIVSfngaxU3RJ1ItVDG3oKo0k50SjhlhLyEmL3524BWcPIkS0wUkiucFKm7K6lDqiZl9vMtMMrvruKYS1TSTupPaT0+8nKy5bp2uczrbSVO8PmRRMD2c0oM0TtPiOhO828llEao2Y4jddpQFTGGvevS1UnsJTYV0g3O88O0hDoByGwAQ1g7wUWxEhpgrZ/2UKh0itpUZw7yWp7JX/jly+cd4XGd3ihZVKnPrTyW2xv5k+hqsK+UP5HR9jm5Ih/x9Jrqjqu2Q/2/N1mJUBpFxufO/fvFiaLO2hcaZpdzorMsLklYujOOo+boyO+PzEGWeFAMto205i+frCHWgMC/DHu6/Akm800W5xUMH277iGJlhq+mOXE3KCWLD3i2PGlapi8O56x6QJlr0AmqZwxZjWBpKAAijHMKwoNTIkRkZ4WgU9Wo6oQDxCuyFlRqw6XbSNiHCWGCkrvGb3tVpszcS0kyM4oKNeDIXdmfSmryuwrZks+vaPGjSbOlbS7azIngm/Wp66yadw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c58735-834d-451d-9dcf-08dd6cba1c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 23:01:14.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lME0yd+7qa2+/3pIR4cOCTCVvx5WsH4PlSZveYHiVPd/sumo19nnQwLUM6MGhYbNeY9MiOv2LleyOZCx9Z7QFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
X-Authority-Analysis: v=2.4 cv=VKHdn8PX c=1 sm=1 tr=0 ts=67e4873f cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=JHzk6tn9kbUIW2eQ6dAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dQ69xf4Boc649jk82Uwh4KpQSB66J5zD
X-Proofpoint-ORIG-GUID: dQ69xf4Boc649jk82Uwh4KpQSB66J5zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=850 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260142

T24gTW9uLCBNYXIgMjQsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IFdoZW4gZHdjM19n
YWRnZXRfc29mdF9kaXNjb25uZWN0KCkgZmFpbHMsIGR3YzNfc3VzcGVuZF9jb21tb24oKSBrZWVw
cw0KPiBnb2luZyB3aXRoIHRoZSBzdXNwZW5kLCByZXN1bHRpbmcgaW4gYSBwZXJpb2Qgd2hlcmUg
dGhlIHBvd2VyIGRvbWFpbiBpcw0KPiBvZmYsIGJ1dCB0aGUgZ2FkZ2V0IGRyaXZlciByZW1haW5z
IGNvbm5lY3RlZC4gIFdpdGhpbiB0aGlzIHRpbWUgZnJhbWUsDQo+IGludm9raW5nIHZidXNfZXZl
bnRfd29yaygpIHdpbGwgY2F1c2UgYW4gZXJyb3IgYXMgaXQgYXR0ZW1wdHMgdG8gYWNjZXNzDQo+
IERXQzMgcmVnaXN0ZXJzIGZvciBlbmRwb2ludCBkaXNhYmxpbmcgYWZ0ZXIgdGhlIHBvd2VyIGRv
bWFpbiBoYXMgYmVlbg0KPiBjb21wbGV0ZWx5IHNodXQgZG93bi4NCj4gDQo+IEFib3J0IHRoZSBz
dXNwZW5kIHNlcXVlbmNlIHdoZW4gZHdjM19nYWRnZXRfc3VzcGVuZCgpIGNhbm5vdCBoYWx0IHRo
ZQ0KPiBjb250cm9sbGVyIGFuZCBwcm9jZWVkcyB3aXRoIGEgc29mdCBjb25uZWN0Lg0KPiANCj4g
Rml4ZXM6IGM4NTQwODcwYWY0YyAoInVzYjogZHdjMzogZ2FkZ2V0OiBJbXByb3ZlIGR3YzNfZ2Fk
Z2V0X3N1c3BlbmQoKQ0KDQpLZWVwIEZpeGVzIHRhZyBpbiBhIHNpbmdsZSBsaW5lLiBJIHRoaW5r
IHRoaXMgaXNzdWUgZ29lcyBmdXJ0aGVyIGJhY2ssDQpwZXJoYXBzIHRoZSBGaXhlcyB0YWcgYmV0
dGVyIHJlZmVyZW5jZSBoZXJlPw0KDQo5ZjhhNjdiNjVhNDkgKCJ1c2I6IGR3YzM6IGdhZGdldDog
Zml4IGdhZGdldCBzdXNwZW5kL3Jlc3VtZSIpDQoNClRoYW5rcywNClRoaW5oDQoNCj4gYW5kIGR3
YzNfZ2FkZ2V0X3Jlc3VtZSgpIikNCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2ln
bmVkLW9mZi1ieTogS3Vlbi1IYW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAN
Cj4gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEFzeW5jaHJvbm91cyBTRXJyb3IgSW50ZXJy
dXB0DQo+IFdvcmtxdWV1ZTogZXZlbnRzIHZidXNfZXZlbnRfd29yaw0KPiBDYWxsIHRyYWNlOg0K
PiAgZHVtcF9iYWNrdHJhY2UrMHhmNC8weDExOA0KPiAgc2hvd19zdGFjaysweDE4LzB4MjQNCj4g
IGR1bXBfc3RhY2tfbHZsKzB4NjAvMHg3Yw0KPiAgZHVtcF9zdGFjaysweDE4LzB4M2MNCj4gIHBh
bmljKzB4MTZjLzB4MzkwDQo+ICBubWlfcGFuaWMrMHhhNC8weGE4DQo+ICBhcm02NF9zZXJyb3Jf
cGFuaWMrMHg2Yy8weDk0DQo+ICBkb19zZXJyb3IrMHhjNC8weGQwDQo+ICBlbDFoXzY0X2Vycm9y
X2hhbmRsZXIrMHgzNC8weDQ4DQo+ICBlbDFoXzY0X2Vycm9yKzB4NjgvMHg2Yw0KPiAgcmVhZGwr
MHg0Yy8weDhjDQo+ICBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUrMHg0OC8weDIzMA0KPiAgZHdj
M19nYWRnZXRfZXBfZGlzYWJsZSsweDUwLzB4YzANCj4gIHVzYl9lcF9kaXNhYmxlKzB4NDQvMHhl
NA0KPiAgZmZzX2Z1bmNfZXBzX2Rpc2FibGUrMHg2NC8weGM4DQo+ICBmZnNfZnVuY19zZXRfYWx0
KzB4NzQvMHgzNjgNCj4gIGZmc19mdW5jX2Rpc2FibGUrMHgxOC8weDI4DQo+ICBjb21wb3NpdGVf
ZGlzY29ubmVjdCsweDkwLzB4ZWMNCj4gIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9kaXNjb25uZWN0KzB4
NjQvMHg4OA0KPiAgdXNiX2dhZGdldF9kaXNjb25uZWN0X2xvY2tlZCsweGMwLzB4MTY4DQo+ICB2
YnVzX2V2ZW50X3dvcmsrMHgzYy8weDU4DQo+ICBwcm9jZXNzX29uZV93b3JrKzB4MWU0LzB4NDNj
DQo+ICB3b3JrZXJfdGhyZWFkKzB4MjVjLzB4NDMwDQo+ICBrdGhyZWFkKzB4MTA0LzB4MWQ0DQo+
ICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiANCj4gLS0tDQo+IENoYW5nZWxvZzoNCj4gDQo+
IHYyOg0KPiAtIG1vdmUgZGVjbGFyYXRpb25zIGluIHNlcGFyYXRlIGxpbmVzDQo+IC0gYWRkIHRo
ZSBGaXhlcyB0YWcNCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyAgIHwgIDkgKysrKysr
Ky0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMjIgKysrKysrKysrLS0tLS0tLS0t
LS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDY2YTA4YjUyNzE2NS4uMWNmMTk5NmFlMWZiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiBAQCAtMjM4OCw2ICsyMzg4LDcgQEAgc3RhdGljIGludCBkd2MzX3N1c3Bl
bmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICB7DQo+ICAJ
dTMyIHJlZzsNCj4gIAlpbnQgaTsNCj4gKwlpbnQgcmV0Ow0KPiANCj4gIAlpZiAoIXBtX3J1bnRp
bWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSAmJiAhUE1TR19JU19BVVRPKG1zZykpIHsNCj4gIAkJZHdj
LT5zdXNwaHlfc3RhdGUgPSAoZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkco
MCkpICYNCj4gQEAgLTI0MDYsNyArMjQwNyw5IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2Nv
bW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCWNhc2UgRFdDM19H
Q1RMX1BSVENBUF9ERVZJQ0U6DQo+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRl
dikpDQo+ICAJCQlicmVhazsNCj4gLQkJZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiArCQly
ZXQgPSBkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1
cm4gcmV0DQo+ICAJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiAgCQlkd2Mz
X2NvcmVfZXhpdChkd2MpOw0KPiAgCQlicmVhazsNCj4gQEAgLTI0NDEsNyArMjQ0NCw5IEBAIHN0
YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdl
X3QgbXNnKQ0KPiAgCQkJYnJlYWs7DQo+IA0KPiAgCQlpZiAoZHdjLT5jdXJyZW50X290Z19yb2xl
ID09IERXQzNfT1RHX1JPTEVfREVWSUNFKSB7DQo+IC0JCQlkd2MzX2dhZGdldF9zdXNwZW5kKGR3
Yyk7DQo+ICsJCQlyZXQgPSBkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICsJCQlpZiAocmV0
KQ0KPiArCQkJCXJldHVybiByZXQ7DQo+ICAJCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2Fk
Z2V0KTsNCj4gIAkJfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDg5YTRkYzhlYmY5NC4uMzE2
YzE1ODk2MThlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQ3NzYsMjYgKzQ3NzYsMjIgQEAg
aW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlpbnQgcmV0Ow0K
PiANCj4gIAlyZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gLQlpZiAo
cmV0KQ0KPiAtCQlnb3RvIGVycjsNCj4gLQ0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gLQlpZiAoZHdjLT5nYWRnZXRfZHJpdmVyKQ0KPiAtCQlkd2MzX2Rpc2Nv
bm5lY3RfZ2FkZ2V0KGR3Yyk7DQo+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2Nr
LCBmbGFncyk7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLQ0KPiAtZXJyOg0KPiAgCS8qDQo+ICAJ
ICogQXR0ZW1wdCB0byByZXNldCB0aGUgY29udHJvbGxlcidzIHN0YXRlLiBMaWtlbHkgbm8NCj4g
IAkgKiBjb21tdW5pY2F0aW9uIGNhbiBiZSBlc3RhYmxpc2hlZCB1bnRpbCB0aGUgaG9zdA0KPiAg
CSAqIHBlcmZvcm1zIGEgcG9ydCByZXNldC4NCj4gIAkgKi8NCj4gLQlpZiAoZHdjLT5zb2Z0Y29u
bmVjdCkNCj4gKwlpZiAocmV0ICYmIGR3Yy0+c29mdGNvbm5lY3QpIHsNCj4gIAkJZHdjM19nYWRn
ZXRfc29mdF9jb25uZWN0KGR3Yyk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiANCj4gLQly
ZXR1cm4gcmV0Ow0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
KwlpZiAoZHdjLT5nYWRnZXRfZHJpdmVyKQ0KPiArCQlkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0KGR3
Yyk7DQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVj
dCBkd2MzICpkd2MpDQo+IC0tDQo+IDIuNDkuMC4zOTUuZzEyYmViOGY1NTctZ29vZw0KPiA=

