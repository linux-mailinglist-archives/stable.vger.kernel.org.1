Return-Path: <stable+bounces-151484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E903EACE771
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 02:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986C37A309C
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C684A24;
	Thu,  5 Jun 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WgL8vUpD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kKhTXzk3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FPDQ4yKB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3E1C28E;
	Thu,  5 Jun 2025 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749082753; cv=fail; b=sz3cOpa5HRiEcaJv3+LbZQDvpxKRsjit8R9m6Jo/D9urCYRZxCwuRXqlI4gt9dk/MWZEC7Lsb/0uQ5hjSJrCElvWaSGGqous3JAqd3LOutIGJ53GLiaINAy68j6UdnYWZnY+C/C12fjQfw3eAP8MezBicCGBxpVhkbMvebElf30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749082753; c=relaxed/simple;
	bh=shUQA8G4baRGZQssNAdZ94M45v/yPmjNrv7F0vUZJsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X7mWmSF+PI+Xqh8CDRGz68w5934jyFAvLsYGxSKhj9LXZeoaSQ0pYeorhg9s0HfWh2Yqo5qtXFUKb6u+Qq4/F7SfbbGYXGStZDJySdSP153j9k4fbQ9DcaPh97gmWEqdmNEqJVOsl8Bm8Pp6L4aWEgro6cTHGSMpiE/e4dU9rV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WgL8vUpD; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kKhTXzk3; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FPDQ4yKB reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Gv3jA022384;
	Wed, 4 Jun 2025 17:18:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=shUQA8G4baRGZQssNAdZ94M45v/yPmjNrv7F0vUZJsA=; b=
	WgL8vUpDS5Xv6dYDd/IgB/uOa6nHjRiZzbq1uSEpeMdYY2Tc1enajzBQcr0OIzlb
	QvhjNz/W77An0DqkakojP4AUZtSrEIaT2SgiE16BNgGVnrKg9tl3WU0FV2jnLwGb
	N1ZuYJxkNaf7955azUrLHGDa+n07ejgaDQF9krGn9rSBdmwiXAHv+VaawJfB31EK
	qhJ4YgS8DkZttKaHmHNIE2r2a7ecymEto9PtTQZlP0AdQlYICAEGluwy+CnvejE8
	HnVVlEUb95wmveKYUf5hfqBpE8xfGDLqheC9G9Qctkp7UsqGCUAM26kKK6T7en1V
	kT+TEWS4bY8ItHRgnqVpxg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 471g9jvt2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1749082736; bh=shUQA8G4baRGZQssNAdZ94M45v/yPmjNrv7F0vUZJsA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kKhTXzk3B26Y9FfBggsaP6TewijA9vkP5B1qoLWH0pgb4F91NW45pyZOfHxnxJqHG
	 Gv9EH0Dx+C0cBr1R7oejHbSrwEZryf07mBwrGN5jr+bMO1picL/TG63caa0rMlk6FW
	 jhZzYOVSs37wDW5viRcAqju1dPjIxcEjC7nkxc78O/mdbO4hzL8E1gMHkPK2h7zUYZ
	 SiULNeZPiDO2D1EzC7fSHpeYlLf/L0dylLHXY1F52n1M4vI6sv5nCcbRsIiucQYSCP
	 cuOcCGv2RdQPH8FQv48btfeRvAxvIBRUn7mjPju6AxtNwE6PLiQbulqbDt5P6lCNB0
	 Xx0OQHhZv72lA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AED6940114;
	Thu,  5 Jun 2025 00:18:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 036DEA00A7;
	Thu,  5 Jun 2025 00:18:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FPDQ4yKB;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 289D54056B;
	Thu,  5 Jun 2025 00:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUwNOsh8vHN0bwSfYxRXFkEfntYaB0qcxm/qpp4KjpoiezZHeZtDscUokaGrbiu2RqotpvyyuJ1IEvtH2PEwS24lIGwSk1VSIWdlyvx4sst3bKuE9lIdiJUNJ0D+NF+EYakjeT8UVXXwo13OwcFmm2zMIMRec+r4ck8oVg99EfVTWQiv9vlaA/6yPPPiJiNpaXbnJQN4neJ7vilq97G4G9beJOY0ELj/CNkr5qSRLcYp0BKDxdZOH+OrC5gjT1njnwevWTHhB/YGuk/tDixq4acDoANls0aZ3G+/yPHKo9opkau+vcQgi5qsdfYqo94bLyDIF9pVXbevcoIPceHFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shUQA8G4baRGZQssNAdZ94M45v/yPmjNrv7F0vUZJsA=;
 b=sOFDtzbH3gmR+rBBYqBOJlNZjIPtiq014fUaP6zhP8o1hiTt9Gl7XzDaR+i6wn8SQJMme3QJduTfPp0CSyz+1xa8HiqCarkZiYPH2QEzI04HulQcQykQJjISz4LVygaiA/FBp8UoJO4qqj40eqmhSgu4V83GsiSIlf+Mj8LdM1zWKFtFpxFIFkw2XPprjoG4Q3KiQy6O8Sp3harwrKLbjo58LLZJpD2TbDwMZQHVXSbo3WAwLe6v8qugR+kdyntXpBFmOJpnXDLFuQ4vJBYr+SogjeuLPNIe4hna5pblbgVo0m8twXAuzRuZa+EHyH+sLlJHXiql4CKDzdLQOcCdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shUQA8G4baRGZQssNAdZ94M45v/yPmjNrv7F0vUZJsA=;
 b=FPDQ4yKBvTDTlzWpHm9nfx56VOMyEoT8BZtbJLDuR08ImbBUCG5YCgascHdaSYwmKC47+CxfxZSHuPAq+Mw9dfvvAAJMtzah2q7+odkQmpP0nlc2LUQJJSVKYVe3iduiHOpMLxdPSOFUkzkSPWDYmk2ZlswBAGEA/fP/A1C7rK4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 00:18:49 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8792.033; Thu, 5 Jun 2025
 00:18:49 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Roy Luo <royluo@google.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.pecio@gmail.com" <michal.pecio@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Thread-Topic: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Thread-Index: AQHby00IO9kpIg0s3ESarCv0vYf2UbPg2AyAgAO0D4CABExBgIAKR8YAgACoCAA=
Date: Thu, 5 Jun 2025 00:18:49 +0000
Message-ID: <20250605001838.yw633sgpn2fr65kc@synopsys.com>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com>
 <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
 <20250529011745.xkssevnj2u44dxqm@synopsys.com>
 <459184db-6fc6-453b-933d-299f827bdc55@linux.intel.com>
In-Reply-To: <459184db-6fc6-453b-933d-299f827bdc55@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB6927:EE_
x-ms-office365-filtering-correlation-id: ccd7c803-6f73-4da5-c4bd-08dda3c68b80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjBVcEEyU1YxZWtHaGE1dWtqMHZqSDQ0UHd0SjhxZmRlTnFHQkFKUDVyWkl1?=
 =?utf-8?B?dk0yV2NGb1YzVk5SbUpzbVloYjlZUmxxcktHdi9zcnVoN25yTmdrTTlyMk9X?=
 =?utf-8?B?eDU4NlNnZitmRXdPamh5S2Zzb2k2TCtJb2pqZlBweXBQWll3RW81R0hnNGxm?=
 =?utf-8?B?SlFKOS9NRmhMN0sraEF3UXBLaE9hUzZ2WUFPSmRzbmN0dnQycFBaNG5ic3hW?=
 =?utf-8?B?bTlMZ29pdlpZL3FSU2oxSDQrT0hXeDZGR2RvNHV1bGVqVGpsOVNoY3JCbUd1?=
 =?utf-8?B?SElxR3FzaE9NaG1WZDM1aGNpRmhQdm4wNktnb24xNkI1V0NBSUFKTHVzT3hF?=
 =?utf-8?B?dGM5YU40bmk0Rkxxci83RmhGWUNWbnpPdGR5OG9IRUdmc3VHdXBHUWlhWW1u?=
 =?utf-8?B?U0E0R0Y0U0dOZE1KU2VUSmJ0ZUdZV2ROa0lFQ3hTQkVYQnlFRW5IcnBycGJu?=
 =?utf-8?B?bG9EdzhaVFhLSEoxN28zWGEyZ2xIZVlDWDgvb1ZyYmNidnhhcjRraStDQkth?=
 =?utf-8?B?QTRuV1ZZOW56bGQ4ekptaWlHWnpJTDlCdUJDVURMdHdVcHMvQ2hBaHNnemxl?=
 =?utf-8?B?a0JTd0VjNEtxbDY5TXBYMHhLdUU4WGI1TFBvUlZYcmkvQUx3Vm0zRlVBZk5j?=
 =?utf-8?B?UmRpclBTdDE2YUlLYVlrZDk4cERhU2YvOUV2SS8rSThMYXg1RTY3UFdaZmp2?=
 =?utf-8?B?U0J6ZUpKVWxoSTgwekFDMnA5dHdCUXZPd2dDN0xQb2RBOFFzeDNsSWM5bHlT?=
 =?utf-8?B?UDFzUW93ZkNHMWIxMDU3SUcyWHdCNkJrSmtycTN5bVhBSXFYOER4N3VJemw5?=
 =?utf-8?B?ZDh5Vll2UlZ0WEMyZGxrS1N3djNOR05WYmQ3elJuTzg2ZmIxQWcrNENINTUy?=
 =?utf-8?B?QTZaL28zQ1ZwVG9kQk1vOExiMHJTSkIySnBOQnlwd2JVYW1iUE52MGJTdXd1?=
 =?utf-8?B?RHd5cVQwelBXVllLVU1hSVpQcVZwNTA0SldCbnBsZDNCOTBaaHc3ZE1GNDVM?=
 =?utf-8?B?R0JHajZZOGtxM2FtYThvUTJHSkxDZHdLa2I2eEI2VmZnemFKOEorU1NIS1I2?=
 =?utf-8?B?U0p4bXYxeWFEV0JvaDFPUHZzMHYzM1JpajZtV2hibjBCeUNLcTFrUWtXcWlP?=
 =?utf-8?B?cEtoOVNhd3dteDVmaWJwTWRGVHhxNnhmL1d0eVZmU0I4OTgxakxpUXkzWFRj?=
 =?utf-8?B?aTF0RElEREsvY2h2ai9LNXdncmxVeTZsUzI3ZGZQT05tS2hHS0hBeDE3dFZ5?=
 =?utf-8?B?bitHMEtjSmNLcVRUTUJ4WEQ4YUxHTGRKUGx4UlV4TmczS0ZhMzgxVVI5R0J1?=
 =?utf-8?B?eTk1NlBJVGYyNkc3QUtmUE0rQ1ZmdmlaRmFlWHhjRkc1OHNlOTRXY0xSZTIv?=
 =?utf-8?B?ZndJQTROYlBEODhRV1V3NUtDVjJwMnhQZXA0SjJnQlpDaG8ycHA0bitIbW55?=
 =?utf-8?B?eUlreUJ2bjJVZHNPMXNJcTRhcFhBZE51N2NlOExpMWlwVktlL2M2a2xkQTBi?=
 =?utf-8?B?SWNMMThsZ3J3WS9hR3lyRGZod1VvZFpxWUxKejQ1cGlUU1dVY0gwMmYvSW0v?=
 =?utf-8?B?czZvb0pVdGNnTFgvZzNsQ0ROeUloS3FLYjZockIzcHM5ZzFyV08wUXR1NEpq?=
 =?utf-8?B?UUYvTHREYTNlbUhTRHdsbTFRcVdEMWxSZWxDS1gwTFBrdmhpZXBVQzBzVkw3?=
 =?utf-8?B?bGtwYnJhUUFHejdGdjBiUlBFOWJzcWkydzh5Yy9mNlJYWTIycnVWU1V3T2FE?=
 =?utf-8?B?cUVpWWNzOVV2T3l5cWRJMTExMXg1a3lrbjVUMlRnRStrYUQzcGtxaDdTcUMy?=
 =?utf-8?B?YUJtVDN6TzNqVko2aUFPL2FGNVJzSkVCblFNQm9VNnJHWkZNMG54MXBkN0Ns?=
 =?utf-8?B?Q0h0OFFBNDZlREVqVTZrcnE0ZHNPa0FKa080R3RZN0VFRThRQUdEcTREVC8x?=
 =?utf-8?B?UGlxLzJSSENGbnd4Q2JsWkZZVDhrelE5eUlJTTFIZlNxNGlua2ZuMFlRTDZ4?=
 =?utf-8?B?VHIzOThDbmtRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3N2ODE1UUdJN3EwWHJUYWhDWGFBVXE3QVVUcklsVHY3eDhyVVVVcGF6N1RD?=
 =?utf-8?B?elJwak4rYnpvaFdyREVqNFk0YXRjV25CakpzbUNLL3p5NGRxLy9meXlRbXFR?=
 =?utf-8?B?ZURRMDNHbEQzbHN1SUVyQ3VYV3lBWmRydktHNW0vZElXc2NWMzg4UjVHellQ?=
 =?utf-8?B?end5KzJoOW5sSUxEYnkreVBQbFFBTzZSa2pPcWpRaHh3cWZTdlY3WldHS1NL?=
 =?utf-8?B?S0E3eGJkT0pkV0ZuTnU5cjY0RVhKTDlNU2dYTUN3a2VLWGNCczRrZlozOXdt?=
 =?utf-8?B?VkE4VmhwNEU2TlZQMFh1clovV21vKzdYQnM5L2dCLzlVM0hVVEFRV056eUxX?=
 =?utf-8?B?bVlEZVVmSThQKzF0U2VrVERxQlczQytkQ05HblFZdWU4SzBhcFlsb240U1dY?=
 =?utf-8?B?M0tGM0tldVJuQ3NDM0IzQUNaeUdKaUFEdW1zVktnRkhpcDBETmhYQmN4dDJt?=
 =?utf-8?B?OVdLazJuMVVzZHRhYStCdEthZVdpSzgrekJOQ0pTSFcxSStOVWFuWXJ4TnFK?=
 =?utf-8?B?SjJSd3RpSmZjMU9RMGdvclM5SG5CYzh6SDBJL1dvZUxFaXZ5WG0wMzJNSVJ4?=
 =?utf-8?B?UGljMDVGMEV1YS9taDVqZnFSWmdIVi9ENzMzYjFJK2VPelRxSDRtcGpleGU5?=
 =?utf-8?B?cDlzbVRyUUhhL0dLY01CNTBWaXRhREc1MkhlSWJDK2N3UjBTV245dUJ6MUVP?=
 =?utf-8?B?RmxtZGxRNmtsQmRnTTdvZjRuZWdQcnJhdlBTK3QyUXMySEV3cUxpQmhzbHVz?=
 =?utf-8?B?R2tjSFhJKzIzS0RySlVwOTFVTXQzMklCYUZMSW1OVEM4L1RPUVc3aG9pNjcr?=
 =?utf-8?B?K0Q0VWcvYWVQU2o0Vit0QUFuTk55RUF4VFJKWXVUSWg0ZWZURlBRVDFCbHNh?=
 =?utf-8?B?MVdCWlZ2c3pHdnR4WGo2ZGxjREtaSFFOOXpveWROWHZXMHdaSjJaTkN6N1Z1?=
 =?utf-8?B?b1NFOXl3ZVZrcU5lczlGMldmb24vbFl6SnVMVEY3TGJyOCtWV3FGRFVIdDUv?=
 =?utf-8?B?TlhtRFdWNUVydVYxeGFRQ1RxM1o2UjVlRXRwYmJjeGh2eXVPdUZXQWc4OC90?=
 =?utf-8?B?dHdPeDIwMEhIR0p2Tk1ZVXY1R0QxT2dHYUJaT2tyV3AzRU54NzB0aGlzTzdr?=
 =?utf-8?B?YTUrVldSYjFKQmMzUnVWVUdTVUlvNmZsWjcwellMZ3dGSHR3bmdqbTNnekpJ?=
 =?utf-8?B?Mk16Sk9NZm1ya1VVYW1PaUVEaHlyNkYreXBENXVST2FWZUZZR0J4ZU0zaHZt?=
 =?utf-8?B?NDFDcFVhR00wYndYdnVGV0plMGJxQytaZ3RxbGUzRkt5T0NqaVFDRm9UUnVt?=
 =?utf-8?B?aXFQWTE2aDNrMnN3ankybURqaEM1aEhSN0EvaFp6RTNjcGtKMGtleXRGOE9I?=
 =?utf-8?B?MnRBc3JmaDNkbzV3cmV0M2phYVVrblZ3UThWdXpnWGRYcXVpdkpXQVFFbSt4?=
 =?utf-8?B?T2gvMTFGU0hoakJiQkxrdXVpUW5vb25Fa3c3S1pVRHlzd1V4d2FIMGRyRk5X?=
 =?utf-8?B?WmpvYjVVZ0pOZlJvOGljYTdHa0c3NUtuOE5EMy85TjZRUHFOMm1BZUdpRkJM?=
 =?utf-8?B?N05LSDZBWGZ5NE9wMEpOT1hVNWE3MncxdHVZdEowVUR0cU0rdjVRbk5WeStp?=
 =?utf-8?B?MmkzYnFnRERpcFF2RGlOZFlFNjI5bWd1NFkzclREOTIyME16QjhiVC9MejQw?=
 =?utf-8?B?SnhXcndlMXBkK08yQWp5UVo5Um5naHNSa1FtcWlPZmFYTnMvSzhjL2lsWHpv?=
 =?utf-8?B?aHNWVW5zeXJiSElhVTZxT0lYRWdSR1c5WGFPajl0YkR4V2MvZlZCVkxIL1ZB?=
 =?utf-8?B?emIrMlBoVjgxYVlFckVVZElRVTV6Y1gyQ3Bza3p6aDZKTlBkdzl5L3o0VDNQ?=
 =?utf-8?B?MUFWS1JybHZSMDMrNlRPeWY2QWo5TUpCNU5vQXNmcjd4MGdXZGhrQjZGOGNT?=
 =?utf-8?B?SE9QWldxVFFxYVh3TTN2bHE2ZmprOUQ4QUJjOWM1K2JqdlpZeFlPTnJIdWVR?=
 =?utf-8?B?Qmc0bVM0YkgrZEJhdlM2RUxOUFU0bDZETWJEL2lLQzF5Yk1ZalhLZ2drSUxE?=
 =?utf-8?B?RjQvODdnTVh6eEJRZld5YUhZTndIakFjck5NRU50V25yOFE2TmptUzE2S1JQ?=
 =?utf-8?Q?4yCKuyB4+m2PLyflah2cfj8tb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4AE499CC311FD429008BCAF23331FCF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/GUzQtnLQta+oNcePPmDZEk8e9G8nAGGeSeOVD7wDIK5BLN9MkcMgkt79WCUmhCnSk7JmullVAiW3AB9QCZmZdWuBu9ANj2IY4AfAH6pOmi7VKmJtZG5xgjWspSZm7axwNRJXBKPCktSh9eh9s+RYqDxu9Rf9+rNFT/GndDXLmHLbeJjPKBVHb7B7EipwS7yF/RkIy2wbuIX2Rtb0twcLPHqnfIklj12yV++HTsRb+G282bak2/mwHUOT58EIqcZRqcYLlPy3Jd+bwNFT7ooGt0X8uHQb5gRielbNFCwkMIimv2huAFRo/oKvMch1ykoS5rQQlV7LjcNrryU0Sgohu+SNhnFZXnvLhDlX69pOE9FSO1G7IjyDCLO6l3SAN6xocykL8c7ga93NuZ0KEJ7MCzt+CWtR9BNRuOQtW0nUem3mH1rSV5Tu98V2mN8HhuJcX0Gwj4w9GpvrWvVe8f3mR/gpz/qR1DKVsR+2LJ2+13/jLr01Kd8jIogV47QHUa/2yp/iZhetHAWTuptIjJR+RMgKtTvNhnoKw2Yc0lW2tZBxTrx92fOOdNfKerwTe2K5hNvxsboPEgvv1FOZFfXQ5Y49UAElhgbZGa9GsTFgVzujVAjGy1rdxkkdp52NgB45gmL+kVBxkCBFa4+/i5I1g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd7c803-6f73-4da5-c4bd-08dda3c68b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 00:18:49.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1UqvRfA5DpdaEeMs5J4YeuNSkUCTnCZoS9Zgo4rqFSc0j8hmfvhlzYZGVHHc4JJoDCNnsO8q59pBNjnmJXO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
X-Proofpoint-ORIG-GUID: B4vsjL0wz0fzWDvsldG5-1SUGmrA3F3L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDAwMSBTYWx0ZWRfX+J4AVv1MYRjF
 11KzkWoiZ41SvcXyhp9LnWBgRt7OhMMalqclDea57givy2yROIRtDf3Ey8AfRH89lzck0nVfd6S
 4xXD7QxzfDrq0/j9eE4h0pH57FxGNKaJ90OSZjbg5ZYRGbYVKIWAgXvaUQD3k4tTY2LzXj8F9CH
 pwKTak4qEY4wMtzE2kb+G78lWXI6ey6lpA+sEcP/CkduY7rrN2b81QzHcRu3zlp4PH5XO+E9376
 xmx2Eco/VCFw3Dm8lnABY2n+AX1iU/5eKH+vUaBJ//iwdjTDnySRgty3AibLpsbhthEneO6hrxH
 PNL2ijU0bQ5hvUfyugc2xP+h77lACusg42J2tmuZc6AAVocqtKMX7U78mItYnRnc57JjxC9RZx6
 YyBNKd6BKNayCQSNhFt7X8u0R92jTtcJme6Yg55qDmQBoEyZRsBSNDqEPqeN6NZIZKSxTyCy
X-Authority-Analysis: v=2.4 cv=VoYjA/2n c=1 sm=1 tr=0 ts=6840e271 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=8QUs_LkkJfGFSG9qAuwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B4vsjL0wz0fzWDvsldG5-1SUGmrA3F3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_05,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2506050001

T24gV2VkLCBKdW4gMDQsIDIwMjUsIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+IE9uIDI5LjUuMjAy
NSA0LjE3LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gTW9uLCBNYXkgMjYsIDIwMjUsIE1h
dGhpYXMgTnltYW4gd3JvdGU6DQo+ID4gPiBPbiAyNC41LjIwMjUgMi4wNiwgVGhpbmggTmd1eWVu
IHdyb3RlOg0KPiA+ID4gPiBIaSBNYXRoaWFzLCBSb3ksDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBU
aHUsIE1heSAyMiwgMjAyNSwgUm95IEx1byB3cm90ZToNCj4gPiA+ID4gPiB4aGNpX3Jlc2V0KCkg
Y3VycmVudGx5IHJldHVybnMgLUVOT0RFViBpZiBYSENJX1NUQVRFX1JFTU9WSU5HIGlzDQo+ID4g
PiA+ID4gc2V0LCB3aXRob3V0IGNvbXBsZXRpbmcgdGhlIHhoY2kgaGFuZHNoYWtlLCB1bmxlc3Mg
dGhlIHJlc2V0IGNvbXBsZXRlcw0KPiA+ID4gPiA+IGV4Y2VwdGlvbmFsbHkgcXVpY2tseS4gVGhp
cyBiZWhhdmlvciBjYXVzZXMgYSByZWdyZXNzaW9uIG9uIFN5bm9wc3lzDQo+ID4gPiA+ID4gRFdD
MyBVU0IgY29udHJvbGxlcnMgd2l0aCBkdWFsLXJvbGUgY2FwYWJpbGl0aWVzLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFNwZWNpZmljYWxseSwgd2hlbiBhIERXQzMgY29udHJvbGxlciBleGl0cyBo
b3N0IG1vZGUgYW5kIHJlbW92ZXMgeGhjaQ0KPiA+ID4gPiA+IHdoaWxlIGEgcmVzZXQgaXMgc3Rp
bGwgaW4gcHJvZ3Jlc3MsIGFuZCB0aGVuIGF0dGVtcHRzIHRvIGNvbmZpZ3VyZSBpdHMNCj4gPiA+
ID4gPiBoYXJkd2FyZSBmb3IgZGV2aWNlIG1vZGUsIHRoZSBvbmdvaW5nLCBpbmNvbXBsZXRlIHJl
c2V0IGxlYWRzIHRvDQo+ID4gPiA+ID4gY3JpdGljYWwgcmVnaXN0ZXIgYWNjZXNzIGlzc3Vlcy4g
QWxsIHJlZ2lzdGVyIHJlYWRzIHJldHVybiB6ZXJvLCBub3QNCj4gPiA+ID4gPiBqdXN0IHdpdGhp
biB0aGUgeEhDSSByZWdpc3RlciBzcGFjZSAod2hpY2ggbWlnaHQgYmUgZXhwZWN0ZWQgZHVyaW5n
IGENCj4gPiA+ID4gPiByZXNldCksIGJ1dCBhY3Jvc3MgdGhlIGVudGlyZSBEV0MzIElQIGJsb2Nr
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcmVzc2VzIHRoZSBpc3N1ZSBi
eSBwcmV2ZW50aW5nIHhoY2lfcmVzZXQoKSBmcm9tIGJlaW5nDQo+ID4gPiA+ID4gY2FsbGVkIGlu
IHhoY2lfcmVzdW1lKCkgYW5kIGJhaWxpbmcgb3V0IGVhcmx5IGluIHRoZSByZWluaXQgZmxvdyB3
aGVuDQo+ID4gPiA+ID4gWEhDSV9TVEFURV9SRU1PVklORyBpcyBzZXQuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiBGaXhlczogNmNj
YjgzZDZjNDk3ICgidXNiOiB4aGNpOiBJbXBsZW1lbnQgeGhjaV9oYW5kc2hha2VfY2hlY2tfc3Rh
dGUoKSBoZWxwZXIiKQ0KPiA+ID4gPiA+IFN1Z2dlc3RlZC1ieTogTWF0aGlhcyBOeW1hbiA8bWF0
aGlhcy5ueW1hbkBpbnRlbC5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUm95IEx1byA8
cm95bHVvQGdvb2dsZS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICAgZHJpdmVycy91
c2IvaG9zdC94aGNpLmMgfCA1ICsrKystDQo+ID4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5j
DQo+ID4gPiA+ID4gaW5kZXggOTBlYjQ5MTI2N2I1Li4yNDRiMTJlYWZkOTUgMTAwNjQ0DQo+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMNCj4gPiA+ID4gPiArKysgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiA+ID4gPiA+IEBAIC0xMDg0LDcgKzEwODQsMTAgQEAgaW50
IHhoY2lfcmVzdW1lKHN0cnVjdCB4aGNpX2hjZCAqeGhjaSwgYm9vbCBwb3dlcl9sb3N0LCBib29s
IGlzX2F1dG9fcmVzdW1lKQ0KPiA+ID4gPiA+ICAgIAkJeGhjaV9kYmcoeGhjaSwgIlN0b3AgSENE
XG4iKTsNCj4gPiA+ID4gPiAgICAJCXhoY2lfaGFsdCh4aGNpKTsNCj4gPiA+ID4gPiAgICAJCXho
Y2lfemVyb182NGJfcmVncyh4aGNpKTsNCj4gPiA+ID4gPiAtCQlyZXR2YWwgPSB4aGNpX3Jlc2V0
KHhoY2ksIFhIQ0lfUkVTRVRfTE9OR19VU0VDKTsNCj4gPiA+ID4gPiArCQlpZiAoeGhjaS0+eGhj
X3N0YXRlICYgWEhDSV9TVEFURV9SRU1PVklORykNCj4gPiA+ID4gPiArCQkJcmV0dmFsID0gLUVO
T0RFVjsNCj4gPiA+ID4gPiArCQllbHNlDQo+ID4gPiA+ID4gKwkJCXJldHZhbCA9IHhoY2lfcmVz
ZXQoeGhjaSwgWEhDSV9SRVNFVF9MT05HX1VTRUMpOw0KPiA+ID4gPiANCj4gPiA+ID4gSG93IGNh
biB0aGlzIHByZXZlbnQgdGhlIHhoY19zdGF0ZSBmcm9tIGNoYW5naW5nIHdoaWxlIGluIHJlc2V0
PyBUaGVyZSdzDQo+ID4gPiA+IG5vIGxvY2tpbmcgaW4geGhjaS1wbGF0Lg0KPiA+ID4gDQo+ID4g
PiBQYXRjaCAyLzIsIHdoaWNoIGlzIHRoZSByZXZlcnQgb2YgNmNjYjgzZDZjNDk3IHByZXZlbnRz
IHhoY2lfcmVzZXQoKSBmcm9tDQo+ID4gPiBhYm9ydGluZyBkdWUgdG8geGhjX3N0YXRlIGZsYWdz
IGNoYW5nZS4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBtYWtlcyBzdXJlIHhIQyBpcyBub3Qg
cmVzZXQgdHdpY2UgaWYgeGhjaSBpcyByZXN1bWluZyBkdWUgdG8NCj4gPiA+IHJlbW92ZSBiZWlu
ZyBjYWxsZWQuIChYSENJX1NUQVRFX1JFTU9WSU5HIGlzIHNldCkuDQo+ID4gDQo+ID4gV291bGRu
J3QgaXQgc3RpbGwgYmUgcG9zc2libGUgZm9yIHhoY2kgdG8gYmUgcmVtb3ZlZCBpbiB0aGUgbWlk
ZGxlIG9mDQo+ID4gcmVzZXQgb24gcmVzdW1lPyBUaGUgd2F0Y2hkb2cgbWF5IHN0aWxsIHRpbWVv
dXQgYWZ0ZXJ3YXJkIGlmIHRoZXJlJ3MgYW4NCj4gPiBpc3N1ZSB3aXRoIHJlc2V0IHJpZ2h0Pw0K
PiA+IA0KPiANCj4gUHJvYmFibHkgeWVzLCBidXQgdGhhdCBwcm9ibGVtIGlzIHRoZSBzYW1lIGlm
IHdlIG9ubHkgcmV2ZXJ0IDZjY2I4M2Q2YzQ5Ny4NCj4gDQo+ID4gPiBXaHkgaW50ZW50aW9uYWxs
eSBicmluZyBiYWNrIHRoZSBRY29tIHdhdGNoZG9nIGlzc3VlIGJ5IG9ubHkgcmV2ZXJ0aW5nDQo+
ID4gPiA2Y2NiODNkNmM0OTcgPy4gQ2FuJ3Qgd2Ugc29sdmUgYm90aCBpbiBvbmUgZ28/DQo+ID4g
DQo+ID4gSSBmZWVsIHRoYXQgdGhlIGZpeCBpcyBkb2Vzbid0IGNvdmVyIGFsbCB0aGUgc2NlbmFy
aW9zLCB0aGF0J3Mgd2h5IEkNCj4gPiBzdWdnZXN0IHRoZSByZXZlcnQgZm9yIG5vdyBhbmQgd2Fp
dCB1bnRpbCB0aGUgZml4IGlzIHByb3Blcmx5IHRlc3RlZA0KPiA+IGJlZm9yZSBhcHBseWluZyBp
dCB0byBzdGFibGU/DQo+IA0KPiBPaywgd2UgaGF2ZSBkaWZmZXJlbnQgdmlld3Mgb24gdGhpcy4N
Cj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIGF2b2lkIGNhdXNpbmcgYXMgbXVjaCBrbm93biByZWdy
ZXNzaW9uIGFzIHBvc3NpYmxlIGV2ZW4NCj4gaWYgdGhlIHBhdGNoICBtaWdodCBub3QgY292ZXIg
YWxsIHNjZW5hcmlvcy4NCj4gDQo+IEJ5IHJldmVydGluZyA2Y2NiODNkNmM0OTcgd2UgZml4IGEg
U05QUyBEV0MzIHJlZ3Jlc3Npb24sIGJ1dCBhdCB0aGUgc2FtZQ0KPiB0aW1lIGJyaW5nIGJhY2sg
dGhlIFFjb20gaXNzdWUsIHNvIGNhdXNlIGFub3RoZXIgcmVncmVzc2lvbi4NCj4gDQo+IFdlIGNh
biBhdm9pZCB0aGUgbWFpbiBwYXJ0IG9yIHRoZSBRY29tIHJlZ3Jlc3Npb24gYnkgYWRkaW5nIHRo
aXMgcGF0Y2ggYXMNCj4gaXNzdWUgaXMgd2l0aCAobG9uZykgeGhjaSByZXNldCBkdXJpbmcgcmVz
dW1lIGlmIHhoY2kgaXMgYmVpbmcgcmVtb3ZlZCwgYW5kDQo+IGRyaXZlciBhbHdheXMgcmVzdW1l
cyB4aGNpIGR1cmluZyAtPnJlbW92ZSBjYWxsYmFjay4NCj4gDQo+IElmIHdlIGRpc2NvdmVyIHRo
ZSBwYXRjaCBpcyBub3QgcGVyZmVjdCB0aGVuIHdlIGZpeCBpdA0KPiANCg0KT2suIEZhaXIgZW5v
dWdoLg0KDQpCUiwNClRoaW5o

