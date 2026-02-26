Return-Path: <stable+bounces-219848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHxEERmhoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:38:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B74CE1AE776
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD6B030A04C8
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697A3A0B37;
	Thu, 26 Feb 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZSzmlYxZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BD44D032;
	Thu, 26 Feb 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134304; cv=fail; b=k+S5tKdJleycXu+dTON7HmQxdrOF+7i3+h+kS+oZcAHLugLAXrF1h1tmC+smZ4TpY7XALFuHENsmNkWO36OE3QvDwWzL+S/aQp10qQppB/73gXsQLNba/exCLH0tZGkChiWqsXF2Hlcd5PRU+w4/O2WYz4RnQULg+q1DTM0Jm+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134304; c=relaxed/simple;
	bh=Qb+kRHf0tm7JkmksUim7zLWe5Incs2yZHUkDbMYnS/A=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LYzlItKuZw2bjIqWom/PClb6/f9/5nZ7XD2Z0vJKPPbV5a3RoUhGpPqpd+ec5Dyiau4wrpNy5YKxiQ93XOaK3nRAXDphlEwNId1valkS7GnfNtDO4eukIvv70gEjujWEydSqnKVsBTC8qtMdRuv2QGxggvcrcYY8M3Z01Ta6b/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZSzmlYxZ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QG2DRq3273855;
	Thu, 26 Feb 2026 19:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Qb+kRHf0tm7JkmksUim7zLWe5Incs2yZHUkDbMYnS/A=; b=ZSzmlYxZ
	uA8TWXezWIDJ64d0v0KVx4yD802fuWYSWMJW5wFqVmHuDK/P6PBr7UY1VOs9mwJy
	JGjqcJiQysYiyQCrG44S3MHJXBBeH3MV0/bmmQN7N+KP0BpB7Yn/UdEz8yT+5u0h
	AP1pMNnJhJ+y1jelS2DwbFxkmOVienVMYVNKtYsV/a6kLI+q9yHGs7NEt8lsggY3
	5FLb+OgxaJHybJ835i8L/kYI6Vy1ZJCpG+GmHsHQU0VDh82oYzDM2xJsbjdyew1q
	h9+vvz8Kd+KSS6H8axnhlK7R2prOWmHDBU4K28TyBtcT8Ev3LtUTnIBvEtC1GpM+
	0D16w/6B0XgemQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4728qsh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:31:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQSqX5BdZFokvr9AB7eGd/Ol40/hd4djBfVpEiz9cUxZwJleoe+Z+ePE7YSF2RTcPiLZNrUq5gpKjPnwyHbXYrJCadKmEiXJ8fVm7K9D1uslqS2zM+4TGcSpsjblAmIL/3jPvEGwSQR6CFGXaqOuoViul0PqNxvccqvxgZCaSX+zMac3zdkXreJSpSqaDntJ+W9Irke7D8Nls52HqU/kfNeffcaWz/jvdqNgBs9wEEiEdW3JVIvOY7x7nPwNkJ9xVBcTZjiITje7KUqqw6KkbRABcrVMLQG9h6QaI4xI6SVc3Don5982qp7n03XlGicwnj4SVlFNnoNrMH4WNHv/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb+kRHf0tm7JkmksUim7zLWe5Incs2yZHUkDbMYnS/A=;
 b=mVe8dCrQSC/GbIxRFC7E9VW+uoeLjRaA3A9XsDo0U8c10l6OBtnoIODrYMIgVfvdUdDVoYJDPoBfK5MyPiZqjMCZL0CeHfS4lA9cUeP2K7kx7buTmyYOPF/5dJanEwuqHmjqQZG+hB6HwjSn8YnU3i9URgMPmi2JeMh+Y8Z+ztis3eSvQRUZOVu2QyzEcqFaaO3aE12sDDqnDTJg5zw8YN+yqdsP7oi6+kQ/U52/Y1DrIYJXqmdQ+SNGgzCHq038h9ymL0fauMYRubJEB6xM1L2R0rIGuBWXPTTPpBUHli9ffyZzDTYKwRIDoFEEALgWdmJdExIXLYUfl9Uyo0kmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB5960.namprd15.prod.outlook.com (2603:10b6:a03:530::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 19:31:17 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:31:17 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: Do not skip the first folio of the
 next object in writeback
Thread-Index: AQHcppgDS668W704B0iRyTKXxOujMrWT6I8AgAF3MwA=
Date: Thu, 26 Feb 2026 19:31:16 +0000
Message-ID: <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
			 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
		 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
	 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
In-Reply-To: <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB5960:EE_
x-ms-office365-filtering-correlation-id: f6af37dc-6766-485a-dccf-08de756d9c7b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 msdnh/aae6cyX9aD0Hd/6OVcAcr11zODLGEblr7AGygHPpogboXCXSIW1Pn4YN7xebkYDZTYaPGbttThwCsSx+GBiX7bbjjw2CrVAkVcF9YgIOWZN3j/juWSC1/qAxASbAy8mIML/f8nwzW5Cg9aDfneo1rMnn2+LqEwhYXLwzfH4BPh9BToBhwgCEhCIJ4zaZf8Z5D95ZZ1agbg9TDb5yVcx6a9jNI9WjxqECPQDE4Wc3BeeTOEsE5Z65ghPVtNh027VjdgrSBAwy+KTusmyCz8i26YKT4alEffosDmpYZAOq1hNLxTGb2wAIGdnYkYfPhciHwKVM1E1tQ2nhVKk2L/N8xx3I0lTVskWx9E1TFYRk3ZwK55SFh+1qRDsR7Bx6ZfRLv9q1tJIqGNdb4z5Y/qB9deuRloBpg1Nf4aQCk/RfqNe0FPNpfcAgjcOvHGrqvZLUsMDBqsXw4tsM+tHHliTpmp9hk7DYmpuPMi84cYP+atcBA8aGx9hdcRzOPgwkv5H2YV3AhM7LB9OY85l6YOZpb/BUoYGbm6vj5+hGCn6WCOO1D2ALkoiq/29W36ksZ+Bz2EaXXd+Rktn1CssIEV3bhs6z/n0K2dVBFd0qhBc2iVwg1AaHZQdeErCvoS0AWhdB6HMOu+118tDzl/LE89uS3ykY1cw6yRHWGtfGBjWHEo2s1T2cNnFDZqa2C0SdWOqwv+4UP6cqTkRZkTYXkO7rV+XgVtMZYaFsf6k1Nt6LIP4qrOKQgZ8COjGsZCGpCsCSaG0tk/pFqJvtqdrhNFxyUT+cpRQQOVfdTjguo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmlIQzdvak5oQVVQN0hqRVh0eTdJK1RsZ2U0aEw0M1NXdy9Pakl1NHNyL3lM?=
 =?utf-8?B?dEE4UEVYR3QvT2cwd0xSak4vY3RmajF2MCs4amFkL1UyQ0w3Yys2QTZZclBm?=
 =?utf-8?B?K0o0N3VReXlHL01CY3BDQlZ0Wit5bnVudXdZSzJndTJvTFhtY2FZSzJmNGVa?=
 =?utf-8?B?TTZQOUIwMjFJQ1Z0TmdYYkZWZ2hxRjBhcUgyR01yOWxCNFdyMkhidUtjQ2Ns?=
 =?utf-8?B?cm12UW0xMFIvV1Byc0tDekFMV2d0VjMwaVFQSUZieWU3U29SUGVsTnorcHd4?=
 =?utf-8?B?UmM2OWxlbkhrVWhsc3I3V25EeFRrQ3FxWGRKZ2N3TERGUUZ3eFlCVjNBcjBw?=
 =?utf-8?B?WFBHNmZNNHFMWkEwU3pOdlo0UDQrbWRyQVhoRjVPMjZpNlZUVGI0QVlYRXc1?=
 =?utf-8?B?R200aGh5ZUpudVJBS1RKQkhJdkNtR3I2L2hxNXV4clNjQlRzbGxvUjZ6WnJO?=
 =?utf-8?B?QkczYktKdTRUc1BXaVpyL091NFNwcnpvQkR3S3MvaVFEWFJPRklMUVBWTFZW?=
 =?utf-8?B?NFdGdzhLNjRCeCs1YXJ4SUo0NWs2b0lRQ2xPOURnOWRsblVYTDY1d2s5ODJh?=
 =?utf-8?B?YlZRamV0Wk83TlY0ZVRyd3hRSTVjbUFRRittRFgrdGZHYjVSeVVwM0Vwb0Iw?=
 =?utf-8?B?bUFid2FqT08wcVZHdlFjOCtFeHIrYnZLWCtybGMvS1VjU050N0lFQkRyZnlT?=
 =?utf-8?B?MzlQT3p6ZDB0TENsSTc3dXR4R0lTeGZocDZZcjZUbytKck1pT1RVUjNxZTRh?=
 =?utf-8?B?b3lFWXphd1hpSmEvSFBwTXBJSElQNnUwMEZpZUEwRUoxS0NMbnlTTFhQdXdt?=
 =?utf-8?B?VGdFZFJ6U2hxVm9ERHQvTHB0T29tc0dlL2oxSHlxVlZRWWQ5UFJtQUM2M0pR?=
 =?utf-8?B?emZDSnlEZWpNWmRxWUJGblpXdFRDVkt0NXg0ZmU2blN2UWd5eHJBUWlPQXlG?=
 =?utf-8?B?ZktVczdoWnlmMlJLNDhrbmJQS3R3TGNCOWdnRnhGQkZlSURnT1luWklTVEkv?=
 =?utf-8?B?UWpEZ0xWQWVtQmVXeXdpNGFvT1RMNk15aEZUQnRNbGpNNGR4TkF1WFZ5MUh0?=
 =?utf-8?B?eGN2dEI3YXJ1MlExR2M0cVhKMHlXS3dwc0VpTmdtVWpKNk4yUUtHZ1NvakV4?=
 =?utf-8?B?OUEwS3FVS3oyb3JqREhObElVQ05yRW91aTZoSTFnclpEZkV5bkwzeFNjaWlR?=
 =?utf-8?B?eWlaSldYMlVTNkZPNG5GNmJxQUxGRDVpSGs3citNcEZ2M21JNVZwK3lmZnhq?=
 =?utf-8?B?QXNlRzZoZHRIdWl6Qm0rOVgwZWV0WUVsL1VyOHQ1djFQUlBab2lLbXlJOTBs?=
 =?utf-8?B?UHhaTTNmSW95Y3hqbzAwNUFkZm1rQUMwWjRObHJuZ3RYWUJhNzVYQlIxU0Vt?=
 =?utf-8?B?VjJ2SWVxUW8wS3pJeWdkZVZlU1oyaWVMU3NtNzFmUUMzcGFlUkVnRjNIL1RM?=
 =?utf-8?B?RVFvcEZHRDZIcFZtRDdmNmRTaTMvanRLQ2NmL1Nxbm03VGE0MUl4bW1QYTlY?=
 =?utf-8?B?aDE5d0xOdGQyMXhqMVJqS2VvcFRRMktkZjF2cXVzSE9FRVpQSENXM21acURT?=
 =?utf-8?B?K2s1QlozZ0FzYnJWcTRxQmI2bE1Ca1loRTNNUEZaVWtUZWJ6OWk2d2J1V2FH?=
 =?utf-8?B?NjMrTi9RMU9yWE1OYnNDaGhqRDNRV3kwMUoyRVUrMHpGM1MrSWI0bkd2TEJE?=
 =?utf-8?B?RVFKZlFXUllyOXpMOUZubEUvUXJ4dHdyWmVWTEFONGRIUi9LWFR2V2tGQ2p0?=
 =?utf-8?B?Qm5KeWZaQ2ZFNk1XbE5VZXQ3b1VlSldLOUlVWC84M0J1NDl2emo4VTI2cFUx?=
 =?utf-8?B?MUFFbU92MVUyeWVvdWdxV3ltSC9qTGV5S2dFbXk4T3VRRUVaZGZicmV1bzZD?=
 =?utf-8?B?ZmFEdVlVT2V1a2tNU0JFSzRERnZHYnAxai9sUHdOL2RiS0cwL0JMeDIya0F0?=
 =?utf-8?B?WjdFODVyaHdodnV4NXozZEpIb21TT0xCV3lWbUVmbTg1dldTV0hmK0k2Q1BB?=
 =?utf-8?B?RVgxa1dYMUpIUzBjM2ZwZEdwc2FNV2tacVg5WkRZVmFLMUtXS1lxbHcwc2tq?=
 =?utf-8?B?STh2L096bTdabkpqeGJBY1Y4V2hQdlNobGpJVlFXRElCVE9rUU5DRXJ5QlRJ?=
 =?utf-8?B?OC9KNjJCSEFyV0xMNjJTWWlXN2RqTXMreit0d1Y2cUNPOXdMa0kvalFOeEov?=
 =?utf-8?B?SG4vV2srbk9jY1F4ZmR1QUpJS2ZiU3UrRHdHMGF1ZkdRQ0dIN2taZVN2VytE?=
 =?utf-8?B?SzlhZXErbGtRZUZRYnFvUmtxRjRJRkxwcmsrMjFMZDVpZlV2SVZ5MXJSamlk?=
 =?utf-8?B?MXRWU2ZaU20waUVOU0hiT1cralVYeitidjNVcUZwdWJlYkNBemsrM2dpL2FN?=
 =?utf-8?Q?0PUDS1hIgCNg8iEKzg0vsBtENxk/IdGR3EM+G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66DA22ABA5F52149991D17F11663643B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6af37dc-6766-485a-dccf-08de756d9c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:31:17.0080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8up5lkiQYB2RD1MIxz6DV3GkeUBh/RyLR5eW8s4+YTes2ad5guCCFbQbi331ACDrRq9JYA1TYIqYm83OlsShuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB5960
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jsB0ZnSlKbmzoVBeO-O29r0MapxXAImv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NSBTYWx0ZWRfX0dWtiJ5dSQkf
 PadoyivNm89GAxrXpobleHT1jtyqy+JuSCbi+SuqOrHIKSWYyuzGLffArnJgCAC9uXERpRNp3b5
 vYJm3+lnKdhZyWAcPn1f0QH2hsMjaorV6H3hpNe7HR21mirXftt5drLlw+yYwAVxB+atSYD3MpE
 OASqFkyWktfAnw6iBPlpUV1SGiIFkjxcTU5z3Im99jS3Z2lbrZ2J5J+ldB//ItAtOKqthy6diFy
 Rti6jDctxbkOo/7qpEO7snTI2MX12F3zk0hS0b9/IUljcyo4NC1dWwZ81iz/KhmlgxMA5XZsL6X
 fBamg7izZQis8GGQyP/ShLJv6mLVyjXkKpeKrORaovvtDudVPalc4n0bc9XvoQQvs5iGDuOHfBM
 /jHGUD17UUXhnb96865F+Xq4iryGN58X0Ebv/iuIUnDy4s4hEJRnekSJVVXScl9qtpvkRbvPYkC
 Ey3LJf/n7PQ09mLkjoA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a09f8f cx=c_pps
 a=St7v3kIWLLX4ycmTPR678g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=swV2VNnKAqt2baWD6EoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XSIgG_BPCo93AcMU8tfwOXOgi3RL9JRK
Subject: RE:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,dubeyko.com];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B74CE1AE776
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDIxOjA4ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFdlZCwgMjAyNi0wMi0yNSBhdCAyMjo0NyArMDIwMCwgSHJpc3RvIFZlbmV2IHdy
b3RlOg0KPiA+IE9uIFdlZCwgMjAyNi0wMi0yNSBhdCAyMDoyNCArMDAwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+ID4gWW91IG1lbnRpb25lZCBpbiB0aGUgdGlja2V0IHRoYXQgeW91
IGRpZCBzb21lIHRlc3RpbmcuIFdoaWNoDQo+ID4gPiBwYXJ0aWN1bGFyIHRlc3RpbmcNCj4gPiA+
IGhhcyBiZWVuIGRvbmU/IEhhdmUgeW91IHJ1biB4ZnN0c2VzdHMvZnN0ZXN0cyBmb3IgdGhlIGZp
eD8NCj4gPiANCj4gPiBJIG9ubHkgcmFuIHRoZSByZXByb2R1Y2VyIHNjcmlwdHMgaW4gdGhlIGlz
c3VlLCBhcyB3ZWxsIGFzIHNvbWUgYmFzaWMNCj4gPiBzbW9rZSB0ZXN0cyBsaWtlICJkb2VzIG15
IGhvbWUgZGlyZWN0b3J5IHN0aWxsIHdvcmsgaWYgSSBhY2Nlc3MgaXQgZnJvbQ0KPiA+IHR3byBj
bGllbnRzIi4gRG8geW91IGhhdmUgQ0kgdGhhdCBjYW4gcnVuIHhmc3Rlc3RzL2ZzdGVzdHM/DQo+
IA0KPiBJIGNhbiBydW4geGZzdGVzdHMvZnN0ZXN0cyBmb3IgeW91ciBwYXRjaC4gQnV0IG15IENl
cGggY2x1c3RlciBpcyBjdXJyZW50bHkgYnVzeQ0KPiB3aXRoIHRoZSBpbnZlc3RpZ2F0aW9uIG9m
IGtlcm5lbCBjcmFzaC4gSXQgaXMgcmVhbGx5IGltcG9ydGFudCB0byBjaGVjayB0aGUNCj4geGZz
dGVzdHMvZnN0ZXN0cyBydW4gZm9yIHlvdXIgcGF0Y2ggdG8gYmUgc3VyZSB0aGF0IHdlIGRvbid0
IGJyZWFrIGFub3RoZXIgdGVzdC0NCj4gY2FzZXMuIEkgdGhpbmsgSSBjYW4gc3RhcnQgYW5vdGhl
ciBDZXBoIGNsdXN0ZXIgYW5kIHRvIGNoZWNrIHlvdXIgcGF0Y2ggdGhlcmUuDQo+IA0KPiBJIGRv
bid0IGhhdmUgYW55IG1hZ2ljIG9uIG15IHNpZGUuIEkgc2ltcGx5IG1vdW50IENlcGggY2x1c3Rl
ciBieSBrZXJuZWwgY2xpZW50DQo+IGFuZCBzdGFydCB4ZnN0ZXN0cyBpbnNpZGUgb2YgVk0uIDop
DQo+IA0KPiA+IA0KPiA+ID4gVGhlIGNlcGhfY2hlY2tfcGFnZV9iZWZvcmVfd3JpdGUoKSBleGVj
dXRlcyB0aHJlZSBjaGVja3M6DQo+ID4gPiAoMSkgSXQgcmV0dXJucyAtRTJCSUcgaWYgd2UgaGF2
ZSBlbmQgb2Ygc3RyaXAgdW5pdC4gU28sIHlvdXIgZml4DQo+ID4gPiBzb3VuZHMgbGlrZQ0KPiA+
ID4gcmVhbGx5IGdvb2QgY2F0Y2guDQo+ID4gPiAoMikgSXQgcmV0dXJucyAtRU5PREFUQSBpZiBm
b2xpbyBpcyBiZXlvbmQgb2YgZW5kIG9mIGZpbGUuIEFuZCB3ZQ0KPiA+ID4gY2xlYXINCj4gPiA+
IGRpcnRpbmVzcyBvZiB0aGUgZm9saW8uIEZpbmFsbHksIHdlIGNhbiBleGNsdWRlIGl0IGZyb20g
dGhlIGRpcnR5DQo+ID4gPiBiYXRjaCBhbmQNCj4gPiA+IGZvcmdldCBhYm91dCB0aGlzIGZvbGlv
Lg0KPiA+ID4gKDMpIEl0IHJldHVybnMgLUVOT0RBVEEgaWYgZm9saW8gZG9lc24ndCBiZWxvbmcg
dG8gY3VycmVudCBzbmFwDQo+ID4gPiBjb250ZXh0LiBTbywgd2UNCj4gPiA+IGtlZXAgdGhlIGZv
bGlvIGRpcnR5IGFuZCBleGNsdWRlIGl0IGZyb20gdGhlIGJhdGNoLiBNYXliZSwgZXZlcnl0aGlu
Zw0KPiA+ID4gaXMgY29ycmVjdA0KPiA+ID4gaGVyZS4gQnV0IEkgYW0gc2xpZ2h0bHkgd29ycmll
ZCBhYm91dCB0aGlzIGNhc2UuDQo+ID4gDQo+ID4gSWYgdGhlIHBhZ2Ugc25hcHNob3QgaXMgbmV3
ZXIgdGhhbiB0aGUgd3JpdGViYWNrIHNuYXBzaG90LCB0aGlzIG1lYW5zDQo+ID4gdGhhdCBpbiB0
aGUgd3JpdGViYWNrIHNuYXBzaG90IHRoZSBwYWdlIHdhcyBjbGVhbiwgc28gd2UgZG9uJ3Qgd2Fu
dCB0bw0KPiA+IGZsdXNoIGl0PyBCdXQgd2hhdCBpZiB0aGUgcGFnZSBzbmFwc2hvdCBpcyBvbGRl
cj8gSSBoYXZlIG5ldmVyIHVzZWQNCj4gPiBzbmFwc2hvdHMsIHNvIEkgZG9uJ3QgcmVhbGx5IGtu
b3cuDQo+IA0KPiBZZWFoLCBpdCByZXF1aXJlcyBzb21lIGludmVzdGlnYXRpb24uDQo+IA0KDQpG
cmFua2x5IHNwZWFraW5nLCBJIGhhdmUgdHJvdWJsZXMgdG8gYXBwbHkgeW91ciBwYXRjaCBvbiA2
LjE5IGtlcm5lbCB2ZXJzaW9uOg0KDQpnaXQgYW0NCjIwMjYwMjI1X2hyaXN0b19jZXBoX2RvX25v
dF9za2lwX3RoZV9maXJzdF9mb2xpb19vZl90aGVfbmV4dF9vYmplY3RfaW5fd3JpdGViYWNrDQou
bWJ4DQpBcHBseWluZzogY2VwaDogRG8gbm90IHNraXAgdGhlIGZpcnN0IGZvbGlvIG9mIHRoZSBu
ZXh0IG9iamVjdCBpbiB3cml0ZWJhY2sNCmVycm9yOiBwYXRjaCBmYWlsZWQ6IGZzL2NlcGgvYWRk
ci5jOjEzMjYNCmVycm9yOiBmcy9jZXBoL2FkZHIuYzogcGF0Y2ggZG9lcyBub3QgYXBwbHkNClBh
dGNoIGZhaWxlZCBhdCAwMDAxIGNlcGg6IERvIG5vdCBza2lwIHRoZSBmaXJzdCBmb2xpbyBvZiB0
aGUgbmV4dCBvYmplY3QgaW4NCndyaXRlYmFjaw0KaGludDogVXNlICdnaXQgYW0gLS1zaG93LWN1
cnJlbnQtcGF0Y2g9ZGlmZicgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCmhpbnQ6IFdoZW4geW91
IGhhdmUgcmVzb2x2ZWQgdGhpcyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCmhp
bnQ6IElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBhbSAtLXNraXAi
IGluc3RlYWQuDQpoaW50OiBUbyByZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3Ag
cGF0Y2hpbmcsIHJ1biAiZ2l0IGFtIC0tYWJvcnQiLg0KaGludDogRGlzYWJsZSB0aGlzIG1lc3Nh
Z2Ugd2l0aCAiZ2l0IGNvbmZpZyBzZXQgYWR2aWNlLm1lcmdlQ29uZmxpY3QgZmFsc2UiDQoNCldo
aWNoIGtlcm5lbCB2ZXJzaW9uIGRvIHlvdSBoYXZlIG9uIHlvdXIgc2lkZT8gQXJlIHlvdSBjYXBh
YmxlIHRvIGFwcGx5IHlvdXINCnBhdGNoIGZyb20gdGhlIGVtYWlsPw0KDQpUaGFua3MsDQpTbGF2
YS4NCg==

