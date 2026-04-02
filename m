Return-Path: <stable+bounces-233097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EiGOoO2zmmApgYAu9opvQ
	(envelope-from <stable+bounces-233097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:33:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD638D296
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3CAF305B5EF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750939E6C9;
	Thu,  2 Apr 2026 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C9OUyMgz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED7248896;
	Thu,  2 Apr 2026 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154795; cv=fail; b=pSNKQeIuhVi0a8uAQcpFdi6X2xZv1wVpiqO7vv3Pp/SBC6IyNO3K4IWWGX4W6NiJ5i18SEawYZFjATK5joOhzIILteEJFXPVsci6flNAumsjXdkBq9nJMR2YntQpu+LggzwHcB/sTuTpEQejfcIzkYHmQfRwJwHZDGjiUUyZNHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154795; c=relaxed/simple;
	bh=bE8oEEaFVCVoKcdYLqUXEecRX9A4pHV3C3Zl7kHE1Zs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=dqXKzFFEZ8nNUhubbVFN8QVTtEpX/k+cqBbAH2DQ0JQMTwEfH4aBeY3Oj+hh+YAxJerdPtow3vw9zBKDoro3SZy8UlGipu33em7fpKy2OKJeirRoZGJmiwwbmf+NMJM9o4yhI86ZDY73PGloDrtrWMwY8/gsTpUsBf5ObdUdXnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C9OUyMgz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Ej1Z83595897;
	Thu, 2 Apr 2026 18:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bE8oEEaFVCVoKcdYLqUXEecRX9A4pHV3C3Zl7kHE1Zs=; b=C9OUyMgz
	aJJUBZ7LBLm2VM0ZPsqEUMVNKxM34cOcTONkHpVbeS6mlCheXzzQRsiExP80a/gY
	ra6EFYakv2hO935RdCdh6BAPwxk6DL+MNbJcDtIpf8ia7PaYZNTE4j0skdiZOVAo
	Q6ba4QMgL3TDNY6ijgeLbS26jRH4kRKMOhpg6+cCe5lqK9XBc4SkD0wQUO33zgs3
	gyc36vIbaRbnHp6NqvOHq5rDrDjCKGH9Vi39w4zDx6kgGKQRm7npVYNJjTp/S1K9
	ejN7ckIHQzN5fhNeaU2sHZRdVN3HZzQLlWZ3fvhWtdYSsz6p8/uQMBqls4AgyR1a
	3d1pWRgym9nQCw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3e2s1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 18:33:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UldNxV4zvJseCvLGXo2WuGPbIpjUvvTmfDzP+bR5cfVsRw5ED3PdmEfWYWylVPEIaUSplEVJQiU//gJPwzcKeHa1d/J7xfrMIVnDN3UUw4yNpI0K+e+y74FZ1zuB5sq6GM0dKHYt9+ipbGpsywHVQGd0pXfocP0466D1wSSnlSVqR59BcezvatNoJy1xPv1NGFPoN49UuWf21UgIHY4dUt2I3ktjbtV01wP7aueWyhABDy+fN05X2/dzM8OAn6Mus7W2kXzJV1JnxYLrLrq7mCvnpsw33IJOOuDRf+ZDw9wSsEFQrEVOTWz+6DIoBWgZmqehI/H+tyMROe4UaS08vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE8oEEaFVCVoKcdYLqUXEecRX9A4pHV3C3Zl7kHE1Zs=;
 b=dgg3jTMdBPmxMi7PA3pJfWqhkKDdWuH5jgMY+0yFVeegjJUlJiHn2sgycvGZCIxIO3tooiIcj1aHllZsviABdHR8ANaH6hp4XDUqNa8Dj2C7RAc7q6gKenf5tcW3xX1WQF5dj0gCGKmF1PKYQGmVTXrmsMk8JOAWOOBXWnsa/IjTc6GMyk41sh9jZepamA+aE6dN6l6ZEFS0VrUF05qk/FyEIhMxgMf9ITbsPzd8psVQ0nY0LFQu9CPqy3zdr2kkz0/TRzx765Iqd4VooKeNqqqg226XrU+VdWqKLMBxqX6QgsrO0NtToh3ENM1qUgbI0xWZma/uQUdx3y+jmZ/28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4625.namprd15.prod.outlook.com (2603:10b6:806:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:33:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 18:33:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: only d_add() negative dentries
 when they are unhashed
Thread-Index: AQHcwGczdLET/MkZjkWLja1B6qa1JLXI31oAgAM4G4CAAAYHAA==
Date: Thu, 2 Apr 2026 18:33:07 +0000
Message-ID: <f44aa779a1b28a0321a92dcf9af78b5c14340003.camel@ibm.com>
References: <20260327162308.1118621-1-max.kellermann@ionos.com>
				 <765945680a8b83b26148430752295deedea831e7.camel@ibm.com>
			 <f8c25bcd64be6fdaafd4e49507ea9e04110d56a5.camel@ibm.com>
		 <93e1f2a995ad4c8977e1519a542f9b7b58f47894.camel@ibm.com>
	 <cae25009b37ffd152af27c1c10f75d7258983aca.camel@ibm.com>
In-Reply-To: <cae25009b37ffd152af27c1c10f75d7258983aca.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4625:EE_
x-ms-office365-filtering-correlation-id: 64c60bb8-115c-43e8-9a58-08de90e648f4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 L0eRcSfOL/mVuDga3ASA9BqMAWYcsNsorA4Hxbt/oGkYvMPFLYZH1YdoPMbLUQ4Axu24qWbUsyLHNSDQaekaaOBNEVtGt2HHmNl0b3RsB0EKduzeH/7CBmwG1uP7qpqbnE/cXq3c4SpJvD8Xce3wm6u7gWyR1ENzYHYxhVG6WvhxWtgaw/DQMOUKKgq3CitxhXXJBTOF59LHGXSGALjmFIN76K1RDQuVnlfJOPZrz2EtuFkt6acAUiDvM9iXS48lTkddgyntTyXt0C3vHdAN0mK9qVU1mPevk9rpvMWd7hfOISo6XYwY48cLU8o9sRjemESErtH4y9DlS5FuJlxviCDaZaZQN1wQrXsOeRGHs6iFI4kA5ehf4eJqTMfR0IehmKSGvQr9zcMJYWL/MxgPsEqPDKOSTNRp/ByCMYguH+aJ+4P54dcUExGriU/vLzDUdbNR3/NAplVA88In6TfzlPoHpfOyFvZNGSsXpnErVlU7jAvjNaVTH1K/jxOFTVdt50UlUQdWvwMeHHetFzyv4CP8J80BsaoUZu+loMzSjxZlSNz/7CqhBev4T47/CZBvGQRxTxBK8oha7/8iABRkQcIf4A4vrmrHQy3iz3LcJ/QnMriOp1e4Yn1MRoQvoB8nT7djQ9vIpmjAQr0GceQL3Gz0aeEHsKCvNTC+gr5/lTYnZY+zroHpsWeQjuYlLTE7v7m8oMLlfDH3GpJlgkjJ5FZ2by05Q19h08kjvd8HlY4hozN6RWQCiKHzTaHod2yQSXue42uRga2Rz3pmdcoRf4/iDu4T4t4FeWShI4gUtjU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXd5cmtaMVNEWU1tNUZaYnRHUFZYTmtrQmdJdFRxSWQ5N21rbXJxUnh5dUo3?=
 =?utf-8?B?UUk1MHFEaURrTWN2UWtVc0VsRVROb0l1RnFVOU9IY3BLVnIxYzdZS2JFL2U0?=
 =?utf-8?B?VVVtdDRpeGJrSGRUMVhpMjk3dXlwWjc4ekxlVU5UUDBPcTlhSVJpMFVLbWNs?=
 =?utf-8?B?WTEyOXJIekRmcHI0bnRWRG4wTkdqUEhlK0duZU1mYXNKYWpDUXBnZUJsdEgx?=
 =?utf-8?B?dWhwSmRhd1psVnhQU2RlQnVSSlpBYzJCUVcyQ0R6RVYvMEJ0Zk9CdzF3VHE2?=
 =?utf-8?B?SXROaEdYazhER2xJekcxQnI5andRVEVPc1pJQTdpckRSYjkwRUNXWW5ESytC?=
 =?utf-8?B?Mlhmd3AzSWllVmdXUXhHQVBxTDZ3MXIzZ295dEZ1enZCcFU1VGJzQVNvODBL?=
 =?utf-8?B?YUJkOVd3VURuZWo3S21wQkZVSXZ4NkNWMExadHhGZDFmRURabkNOTDV5OGhu?=
 =?utf-8?B?ZmdMcExBRU5wV09MRjZGTTJnRk9iVHlOekdEWXRDUjJSQzcyWjJodi9rdWhN?=
 =?utf-8?B?Qmt2bVFJdHUvdC9LTFRIdnpGTFY3azBlK2hVSGdOUHZ6NlNMNDlXZ1V3OEhQ?=
 =?utf-8?B?YVY3WDc3TlVIaG1QOVBHdzFCNDk1Z002M21HVjhJd1A1cm1TeEVWTDJpR1FD?=
 =?utf-8?B?eGJ5dGYvR2MzWUZ3NDV2UnFYV2tscXNrYXFKYmNzOHc5TnltYVU2d2dZRUNN?=
 =?utf-8?B?N083bFRsSjl2NjNjcGMzNWFVRnIyd0YxR2lBZUhPSDBHS1Z4WkM1MTFlVWZk?=
 =?utf-8?B?ZTM1d3hheENNUDgxWHZqMHZyekNqT09qTEdrdVJIbThPWDhpcU1sZlR4K055?=
 =?utf-8?B?emdTVTVyeWs2SytOZE5OZHhsZUQrcDVhL3BNN0NDd3ZFclRRNnhvNk9BbG9v?=
 =?utf-8?B?aWZwOWlIa1JwQW1ZWnk0bkF6NUV1R1pmTXIwZHNWWWlEa1VOd1NESXoyc0ZS?=
 =?utf-8?B?QjZESnY5aE1QM0NKYjd6Q2gwTHNZY0FiOUczM05aOStxSzdjTnJsQzFLSjRB?=
 =?utf-8?B?VUJtV3FGK3pzTytYMVlPN0k0VWN3RWhGUnhCc2hMemZJS2lMNWRIa2xTeDcx?=
 =?utf-8?B?bWQyb3dScmVMelp6WXYvN1M1K1FFUURlUkswOWwyWWE5Tk9pRUIzSm8wdEFI?=
 =?utf-8?B?NjR2THEzekNRUWxZcU51Wng0NXd5ZU1VYkpVWTI1TUMraDN1ZW44WGJyaHRW?=
 =?utf-8?B?ZGNCQldoenZzNFg5a3BpUXV0VXBjVC9SRkxISmhUcGRRN0phMHYrUEJaa2NQ?=
 =?utf-8?B?Ulgxd1BFdG5yQzdadHo5UE44bi9kcVN2RzBWOXNBY1owbHhYWEdKaUpjZ2tv?=
 =?utf-8?B?b2lHZEQxVlN3L0VjSGNuVmdFeHNQS0JUY1ZlZUhZNk9wZDllZld5SE95aEUz?=
 =?utf-8?B?bG1ERlZnSVg0K0wrY1ZCcWxxaEEvZDV5VlRyQVJneWsxZUJQZnZaMDhEQnZH?=
 =?utf-8?B?NGQ5dkN5b1dURElCL3NBNmJVa2RjUXhYL3daZ1VTOTBSbHNLZnBId0EvYUJV?=
 =?utf-8?B?MVRpY1A5RGxSM1lES1h2ZGppMTMzakxnNFlkU0huR0pYbDlmTXYrNkpzZGdH?=
 =?utf-8?B?WlNCZlYvZkEydURCaWt1dktDU0dkdFNKTW1nYmpyd09ELytURnNiKzJRblYv?=
 =?utf-8?B?c1YvMmlqSXVwRXVFZk8yaWVjblFxVW9Maks2MG5FUDdvZG1OWVlOM0ZtaTlm?=
 =?utf-8?B?MHZ4aHFnS1JzdTQ3VHMzSExQZU1LQ1hzUkwrcTI4WGpUS1haS0dQbFBEQ2R2?=
 =?utf-8?B?ZVd1OXFJQ2JadGdwZTFpU29XTTN3ZW9tQnRndG92SUh3RnMyYzlnanFheFpy?=
 =?utf-8?B?TXpmbFlKeFMrcXpadHdhc1VadFhxcGErQ3hKY0ZOcUFzM1VpUmdBTHorTE8x?=
 =?utf-8?B?Ny9SSTkrT1F6UmRsNmhGdXVGWXRrVm1YMURscXFpTjYzZ0szUWIra2VDaUF6?=
 =?utf-8?B?aWpOL0tWejFTV0l4YW5idDgrd1I2bFl3ZHFaM3lsY2NMTmRQOXpRRlM3TjJx?=
 =?utf-8?B?RDZuaS9SdngzZjRWaUxEdHNTQlVTZXFTY05OaDg5S3Nzd3hLdE1PSmkwSkFZ?=
 =?utf-8?B?TnZvTXFGYzBVc3JyQktvcmx3aTAyRHIwcExJcVBUa2tnU3RkNHVTYjROOGwz?=
 =?utf-8?B?UDFpSVpUMUdiNWk4djMrTHR6QWZKYWZvekQ2Tk01ZVVzQkxId3VlRFU3SmNx?=
 =?utf-8?B?T09mUHdMVzZPSzk1V2FiL0VKK01jOU5sSU00a3dhR1FKYWdIZnh3cmdLTU5U?=
 =?utf-8?B?WVJ0MmlNNFpZMWY0cmZ5NzNaUnhCbUNoZlRLK1IrcHlxQVM4WHI4OFM2WDhW?=
 =?utf-8?B?eUl3VzlrblhuUUlwS2phb2J3TE4yWEovU0pKaEpMNWE5TWxyenFCUHp0SHRj?=
 =?utf-8?Q?Dli5eV4a5PTosaEpzPzK3Arqdqd6iTKKCt8Em?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59C90B1D31E5114B8D0577E64E7AEF66@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OJfFfLuRP7rg4ZmKb52ydrlfz9AeZ5PJVx23WKXsJqy/kV7yZZLjuZNO3YjdCw5G8lfomcyVmrinZfI61CmfbfTjsNFDHLTXjfJdvguDI5nX+bwKt44Ee4ZTONTKbx835vDu4IhKUct0efiuyu2khhvlymt5Tcm4BMQNF1aSaYrYPfaAusInGqXrqH38rxeg9m+ULK3PQlgMtLSUYZGxVPHhGtV6k5rimc5ru4B3G8aheYBGHKvix4pe+b1sLKlN0NdUb5qGqVJLnIpG4YIL3Vetv9IQTwzhVQC83sVVXj7isYnYAKjaj2eYs+HADxqJMCo49Mx8BMZpbyhY5ehlHw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c60bb8-115c-43e8-9a58-08de90e648f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:33:07.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/0nKE3P1hGxdEp1HHKJWS8T9nL7ZQtkPORMw9l6OwCIpQgJwfHDBkl8Cxh7F0UE5OPfdPh7x0NQqfZcRdtLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4625
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IOKCgh0uKN5hn0YY3PeUeKKE5qzvtGzS
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ceb666 cx=c_pps
 a=5zjvB78PlnLPEzvzEo0MXg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gn92i6_2cngksNQ2t-UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LZwFHEVwdvxvcyTKlOXUbDIo23WVd-7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE2NCBTYWx0ZWRfXz3dKNthkGqZE
 82peSgsvta6Rw7v5B//zSoYFDn1jM4bPncJHOsfMnT897iI+siEH2PkZVFkchRMxHvAFS7QH35i
 /T4MwY+H3s77ln3j2bcEyNGVM5NmdMf2doO122+B7MjG+yS2J8Egips79KKgloGTQB+x4fzYqtd
 yb/gsS6/4aL/ADxzy3X6F+Xj97afpxP4rGp2NJmaF/EwjvS5uArSxj2gGCPBbSvBwjdkthj7YQl
 3WNnpdoyugR9P0amO0wcVhHn1sjPSaq3edNf+y7o/ZQ5MdARGh2quOURupvv6hjcmrrtzNO44V8
 8/pasuEVuIOF8VrLKA91O0JOmV0hvyLibh8W9463Z3A3N3WcAGFhu5u8RqXFjoQj4qikOBdqlsu
 XIrhJf4JsXApvcV2N/Vsc8iqN9UqZ4OqxsBoSQHx5S1tSDG9wn4IuX3yBpSOUvpShiwJD+fWgb2
 CoMIQTubjOmM2K7gTzw==
Subject: RE:  [PATCH] ceph: only d_add() negative dentries when they are
 unhashed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020164
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233097-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63CD638D296
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE4OjExICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFR1ZSwgMjAyNi0wMy0zMSBhdCAxNzowMSArMDAwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNi0wMy0zMCBhdCAxNzowNCArMDAwMCwgVmlhY2hl
c2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gT24gRnJpLCAyMDI2LTAzLTI3IGF0IDE4OjQ0ICsw
MDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMjAyNi0wMy0y
NyBhdCAxNzoyMyArMDEwMCwgTWF4IEtlbGxlcm1hbm4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4g
DQo+ID4gPHNraXBwZWQ+DQo+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBMZXQgbWUgcnVuIHhmc3Rl
c3RzIGZvciB0aGUgcGF0Y2ggdG8gZG91YmxlIGNoZWNrIHRoYXQgZXZlcnl0aGluZyB3b3JrcyB3
ZWxsLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSBoYWQgbXVsdGlwbGUgeGZzdGVzdHMgaXNz
dWVzIGR1cmluZyBsYXN0IHJ1bi4gTW9zdCBwcm9iYWJseSwgaXQgd2FzIHNvbWUNCj4gPiA+IGds
aXRjaCBvbiBteSBzaWRlIG9yIGluY29uc2lzdGVudCBidWlsZC4gSSBuZWVkIHRvIHJlcGVhdCB0
aGUgeGZzdGVzdHMgcnVuIHdpdGgNCj4gPiA+IHRoZSBwYXRjaC4NCj4gPiA+IA0KPiA+IA0KPiA+
IFNvcnJ5LCBpdCBsb29rcyBsaWtlIDcuMC1yYzUgaGFzIHNvbWUgaW5jb25zaXN0ZW50IHN0YXRl
LiBMZXQgbWUgc3dpdGNoIG9uIDcuMC0NCj4gPiByYzEgYmVjYXVzZSBJIHdhcyBhYmxlIHRvIHJ1
biB4ZnN0ZXN0cyBzdWNjZXNzZnVsbHkgYmVmb3JlIG9uIDcuMC1yYzEuDQo+ID4gDQo+ID4gDQo+
IA0KPiBGaW5hbGx5LCBJIG5lZWRlZCB0byBkZXBsb3kgZnJlc2ggQ2VwaCBjbHVzdGVyIGFuZCBJ
IHJhbiB0aGUgeGZzdGVzdHMgd2l0aA0KPiBhcHBsaWVkIHBhdGNoIGZvciA3LjAtcmM2IHZlcnNp
b24uIEkgZG9uJ3Qgc2VlIGFueSBuZXcgaXNzdWVzIHJlbGF0ZWQgdG8gdGhlDQo+IHBhdGNoLg0K
PiANCj4gVGVzdGVkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNv
bT4NCj4gDQoNCkFwcGxpZWQgb24gdGVzdGluZyBicmFuY2ggb2YgQ2VwaEZTIGtlcm5lbCBjbGll
bnQuDQoNClRoYW5rcywNClNsYXZhLg0K

