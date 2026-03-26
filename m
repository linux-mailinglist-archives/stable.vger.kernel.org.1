Return-Path: <stable+bounces-230474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMIxILZHxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:50:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E775D3370B5
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCC7B31B887A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8F1ACEDE;
	Thu, 26 Mar 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="AqguZhIP"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023095.outbound.protection.outlook.com [52.101.72.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D23366806;
	Thu, 26 Mar 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535676; cv=fail; b=HpxfJdTdBbFx3qxuEk8JU6CrPIm4UmyYWqtEQhoknYLPxThwyEzNaVqRDYCjoyMSX49RsQCrPGtKmbaVKJNTS+PsRR0/dkRxpu2mI8cylaqZnOQUhhKzghsyjoxC09FXMn14O1Sp+Eh0tnKf8ixv6Y/okXtgY3eew40fJPKQV/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535676; c=relaxed/simple;
	bh=eluFFoHv64TwPcv2oFp/UWnOmFAEMI+yYJD0U5TV01M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iBEqzZjMBmlKfzqXWflJlZKBL6XDZtjrFCdI8Feh3asjRltlV0sXTHlnQ33jmqwRFrTa5ptzmGAOMn+EVsM/5xQypi/MotIirRnB2jQXJ1EhPpqL6PFAv8udmhWZQ1wc3tzr4j4AJvpewfLHztql8Ec/GdrAu0ix7+QQ/sDCxL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=AqguZhIP; arc=fail smtp.client-ip=52.101.72.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq2E2BAQ9OCoN5+QDgzRP1uoBEjwIvr8k3ilsTu7Cvc/bnR/8F6ZLEDTcfR2O32LYfThVBq75pjWZyC1jQnKkRotdAWMv9xaqMPdTHYr7nayyiOOOKdIZSFcupucJKnCebeaKRfTxr/ZQhBGlvURzZHC+4bhtsEmT++WsLBz2BoqrM1Tu1RTbwm5tUC0GCfI4ZS/oix/XnFUEhBwqmtRyRI8Fl2Z/t0V03XXb7BFQR6dqhhzFvijznSb2GMFbr5iTRFOi6YlRA4FiRBbqRQiMxkbDefS9XS7pEB1KoJ8c0RqOD9+4Po9rBwb6Ts8HBv2Rf1UqVj31Gy7VLH8Re6YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eluFFoHv64TwPcv2oFp/UWnOmFAEMI+yYJD0U5TV01M=;
 b=lKwpZHpU8+onOw/ZSmd3rNTNkofN1LmHUQUmzKX1nVbRwX9MpDtdF3DDDeKSPOEZfkxJa8ImU/ZSRbhEA6k68FMqbXRgvPrlL7pc4a07Nv1F+zTqaItQ+nLTUfHrJcI6PhKjBU2UepjKAQhnaqm44gt+zW30DLPCiqZY/oIfX6PTj3Pv5D7KeLALbjyhPvlK4RsdIrKpnDh+uM3Eyufu0LBbPH9jaP9NZl4CUqsX2omYv+lVQLjcKpohw/GuWLEPG/j7qZ8302suVMoRF0SFrzv4kVIL0syhCPEhzy14CyGtyc2Zh870hj0uhUHq6z03yhlDKLr/CaxfZn2wHtRJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eluFFoHv64TwPcv2oFp/UWnOmFAEMI+yYJD0U5TV01M=;
 b=AqguZhIPobAlzdd1P/71o53LDPnRTW6Pw983jT4uBj++jy6AyQuM2rhopSZ0NB2pbhfRbsV+70yaKqQquIMRVV6jv5hWQ4dig4xUH1kzToBRIsaF0CPeSTOfx6pXRzi9+dXjGomsFCundB6vlYmF8x8dvMnV0a1veIg7kBioTtMTYuFZU71wdFOOntfJPmbUs4pv2J1bgSSQOp6hLFgJPupC9VYh1VplQDUSIl9CLvy5qgwOfQgbb7LWOQsohH3F8EKf963bJ5kvd/MDxYKb5bVxBPXqSUxYakiRxf1zRWxNfDJ+ksmoPAtiVSHVZ7oAbiGXmsepMugzozNFWG9Uyg==
Received: from PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20)
 by FRRPR04MB12596.eurprd04.prod.outlook.com (2603:10a6:d10:1d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 14:34:30 +0000
Received: from PA4PR04MB7679.eurprd04.prod.outlook.com
 ([fe80::7e8:b5fc:9762:7a6d]) by PA4PR04MB7679.eurprd04.prod.outlook.com
 ([fe80::7e8:b5fc:9762:7a6d%5]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 14:34:30 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v4] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Thread-Topic: [PATCH v4] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Thread-Index: AQHcvS2nfkQGIg1FOEayhp9F20qKgw==
Date: Thu, 26 Mar 2026 14:34:30 +0000
Message-ID: <f0d72bf42b33441991665b23e293c879.security@1.0.0.127.in-addr.arpa>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7679:EE_|FRRPR04MB12596:EE_
x-ms-office365-filtering-correlation-id: 665c4a86-c640-43c0-36cf-08de8b44ca40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7055299006|18002099003|56012099003;
x-microsoft-antispam-message-info:
 M+DEU7Km0ukfawFJHMLKxlHxiejhAClXNGmhZyB+U2KiCexcjMl7W8FxgIHQ0IfChBhjSC1YI/lYtIreHAaZkYV/nv73MKCKcPtPWnfcO+IyA09shabuPEw687ueIqPuVejoEb66zSTnBFeLpD0k+ZTIX4KEajtnlt0L4gmzKuqXKNS/gt4II587U/B0zV0LENp8HN4+CGUuaIkJWo6o8yt8FkttEUsswwDSD0GpuMG5awBijGUIvvugXXI9UHEsMmixBfjBJpcDAR7pfCz1a8ABgaaMMYg6ADmPQNEHm+qsDSBanSSnIuYMY4QmvWNW+61igXGFmQbo62QsC0wwBKa3zZMshz1yszlnFi0/r6nwRE3fMNibr0nOMrgQQ1KYPCPZhbTZGtDfqwIOctxtHRnJa3AKDs8KsfexkmpWnqc6SnW4Hyr7QvwDxnqQDa5Jfq60Yk6kpEmnXns6X4u+mV4YLfGVrFNFppnoQrFLcblw9MXoQ7OTng5uQoV1awAcz5atYBlYCGO05GXG2DipyNJvoFQqcNtYVcRvjPCZD1i8izsTEA6KfxcLqflZ3qq2AHKDBhKKObK23J4OrxYEPrG2dpVyksPfwElvoWvTmrIcOjdtg1o5e2Y+7zvR5Co83PKfh8a2UfMoOlIOZ1/WiRk2yBrxtODPf6lEoLERjKrWu3O8h9zDCZKgKLJWNZJyOeDK4lr95u1L5P2CFIRTsRl2zrK3sEG/clDAfhIDmvPJdYYvqQG6HL7CD/M4mkUM8d8HU9XzZ4HS+OMCrTfDSs/fDKa6BQ1qTdxgwp/odBmGhlcn0bx618tQlsqGcRy+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7679.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7055299006)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0RHQTVoUVVrdWxoZVluWndLazdnRExKUnNQcWhORXlROWVxVzVEY1htQktZ?=
 =?utf-8?B?bkU3QTNrU2s0aE9NNUZ5ZVZwYW8ydTZPTUVlWlhFVnYxNml5YjZjekFjaFA0?=
 =?utf-8?B?T1pHdlpCSjRhK1AraWl2UFVobTdmSDZLT3VPdUZ6U3g2Snc4RkNvYlZUWnBl?=
 =?utf-8?B?emgyOU5RaFo4K1ZKUjJWeVdVcnpPTXNaM1QzcGVNRzhXQ3lQd1N3aUFJRTZL?=
 =?utf-8?B?Y3BXRTN0R3F0eFVYWlhKbDlCV2F5ejdGR0lOaURwY1NESzMvS0QyQVZlazdt?=
 =?utf-8?B?akxoMWxuTUw5NExWeGlNVWI1ZnZHQzZJdHJqSkpXTGd0Mkc4b0Vod3l1cHoy?=
 =?utf-8?B?T1dVbDJiL2pVNnZNaXgzSzRRWFhxSmhsUVNsd1g4dkFMeW85QkNDT1ZZWFln?=
 =?utf-8?B?Zmgrd1ZFNnVxcEhqWmx0dXVjVGhFRFBubGxHMFFIWnkvZ3A2OS9iRmVJVkJV?=
 =?utf-8?B?NzhhUGlObFIrVExEOWpSZGN0WnV5RjVYSGlENjY4WHRXQitneUJMQnhaWGUv?=
 =?utf-8?B?UXJDcDhYQ1B0QWNrWnNRaE01OE4vRDhqcE9OTko4RXZZL3k3ZzBXdjhzc0R3?=
 =?utf-8?B?YStqTDd2T21DKzhDZ0wvc21uMHAwNys0Ujc2Sk1SNWVPdlFUaFY5Q0hSa2dU?=
 =?utf-8?B?ODZmUkgyb24rY1lHQzdyT3dVSExCL2pLNXVwcGxaSHIwYUxaOFRRNFo0VDFp?=
 =?utf-8?B?QWtKQ3pyTXdNWFB0OGNXTGFackZoZ3Q1Tng2bVNPKy9vR0pmcWc0WWhaSVdw?=
 =?utf-8?B?b0U2NlZsTGYwMG1iOG9PSFlTa2xKQW5NSjJSN1FES2NGM29JZ0NtUmdlcXdE?=
 =?utf-8?B?OGVvQ050ZXV6NE9UWkZudnQva3VqNWNjcTJRZjJJUTJSVG9qY3MrUUpiUEZ5?=
 =?utf-8?B?YXZsMTRlWFI3L1RtYlVpSlJLN0JaYXoyWS9ScGVxenZaUmdsVEpUazNIY3Fw?=
 =?utf-8?B?VmtKL3VmNHgza3BNd3hmUGkybmlISDJvcFBuTG1tVEw5RGR1eXRwVnl4c0dG?=
 =?utf-8?B?clBHNnppaEpsM2tpcmZwcjhvengrRDJFRllKTXBKTVRUaklLaXFaVG5uR01w?=
 =?utf-8?B?ckxnQWtVWlNYTXNYK1FMOG5vTWFxSlZ0MWh1TXN6QTlIYWdJbnViblJnd21B?=
 =?utf-8?B?bE5heDlRbjlFRjZ3WHduYjhESjJJSmxuaURDU0l4NG9UM3ovR0gva1ErZnB0?=
 =?utf-8?B?YUxrbHIwUWx6NE9rYTgvK3A3RWNabVJRaWY5bEY2ZUtRNjVIeHE1dE42V0ZW?=
 =?utf-8?B?d2NmdVdsRlp4ZFhYVUE0Zi81OU9Xb2x5b1FpRmpwbW5LTFlhZlhlVDZpYjBT?=
 =?utf-8?B?bGhjaXhGbHJvdHg3VndhTkpCY2ZuR3F5Sk9MUUtVY1V1SkwzWVhTbmVBRTdq?=
 =?utf-8?B?aWlJeEkxV2xXR0wvQkVROVBPdm1XdURZMlB1R0ExdmVMb25nR3JGWExjYlBz?=
 =?utf-8?B?ZGlMd0ZHZUFoZUZkREZNUjNodHEyUHREMXNWRm0rd0czTmN6Mm04a3k2RlNI?=
 =?utf-8?B?eXpkUFFWMUp6bkJKSHMrTUhHUEN5Y0l2ZTNXMnVBd3d1RklTRzM3SlErV3Ru?=
 =?utf-8?B?a284TktuQmlqd0V4eWRwd3hFVGlvRjRNYXhRdTJ2ektpKzJQeHZmUlFURnZt?=
 =?utf-8?B?aU9YcndncmljM0pCZUJpeDAzRHN2NU9yMVpQK0V0SGlXNHR6TTgwR2hWQU1p?=
 =?utf-8?B?Z2pHZTMyYXhYRXdjU2IwRkpmbVZONEpUYzFwSjlFSENhOEMrS0Jzdjcvd1gy?=
 =?utf-8?B?RGZxRWlGRzNiaWtDNjN4bk4vb25vaTZVcmY1bmx6ZHJ1SXZkR3RKNUwydS9S?=
 =?utf-8?B?SWx0NlJ5NUNQT1FPcTBRVEtEelNtVzJwQkFtWERRcmZDQkoyNlZpY2dGS2VW?=
 =?utf-8?B?UXlrMUhMWWJFMWdKNUIzcFRSdmgxYUdJVnE3ZDB1LyttYmw2VVZiUUVUYXQx?=
 =?utf-8?B?SllmRmVGZi9DcEVGbDRrN0J3NUdiVlpQWlpKWFNDWE8yOWZlWkt5bnVVV25G?=
 =?utf-8?B?aVFkWS8vSEJMSXRSTExvNVVFODE1b2dLcElRZzEyZmkycjgvVGhza2ZXSjMr?=
 =?utf-8?B?OGpNeUtrRmNCbkt6NVhQdmFFRVFGNUw4THZUMlRGaWZZUjZjUWpVVVYvaVBM?=
 =?utf-8?B?N2FGZDZOSnk3UWg0aXF5d01RWGQwVHhuQ3dZSDQ1L2pvWE9ITHo5cmdDWXFL?=
 =?utf-8?B?Ni9WTnEwUUoxSTluWnBhWW1zTVQvVEFCUThrOUY1SGdvYXhEYWdTZmNxR0Za?=
 =?utf-8?B?WVdKbFczYWVOMkxGL1FIWjJnTW5QUXFUMVRlREQ0UlBRdXAvRUl5aDV4elF0?=
 =?utf-8?Q?1JfqF4ouDwSuqiON5y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E353630FC43B14DB0B9FE72A056F72A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7679.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665c4a86-c640-43c0-36cf-08de8b44ca40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 14:34:30.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqDZgAvJp4M7i6GpIcVRRLMyz3MCWBh+NGsw7xezbUobgd/67msFzmkYsSHLNQUooiovmgXW6uE87uR/xjbhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12596
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1seal.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[1seal.org:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230474-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[1seal.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,linuxfoundation.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: E775D3370B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

aGNpX3N0b3JlX3dha2VfcmVhc29uKCkgaXMgY2FsbGVkIGZyb20gaGNpX2V2ZW50X3BhY2tldCgp
IGltbWVkaWF0ZWx5CmFmdGVyIHN0cmlwcGluZyB0aGUgSENJIGV2ZW50IGhlYWRlciBidXQgYmVm
b3JlIGhjaV9ldmVudF9mdW5jKCkKZW5mb3JjZXMgdGhlIHBlci1ldmVudCBtaW5pbXVtIHBheWxv
YWQgbGVuZ3RoIGZyb20gaGNpX2V2X3RhYmxlLgpUaGlzIG1lYW5zIGEgc2hvcnQgSENJIGV2ZW50
IGZyYW1lIGNhbiByZWFjaCBiYWNweSgpIGJlZm9yZSBhbnkgYm91bmRzCmNoZWNrIHJ1bnMuCgpS
YXRoZXIgdGhhbiBkdXBsaWNhdGluZyBza2IgcGFyc2luZyBhbmQgcGVyLWV2ZW50IGxlbmd0aCBj
aGVja3MgaW5zaWRlCmhjaV9zdG9yZV93YWtlX3JlYXNvbigpLCBtb3ZlIHdha2UtYWRkcmVzcyBz
dG9yYWdlIGludG8gdGhlIGluZGl2aWR1YWwKZXZlbnQgaGFuZGxlcnMgYWZ0ZXIgdGhlaXIgZXhp
c3RpbmcgZXZlbnQtbGVuZ3RoIHZhbGlkYXRpb24gaGFzCnN1Y2NlZWRlZC4gQ29udmVydCBoY2lf
c3RvcmVfd2FrZV9yZWFzb24oKSBpbnRvIGEgc21hbGwgaGVscGVyIHRoYXQgb25seQpzdG9yZXMg
YW4gYWxyZWFkeS12YWxpZGF0ZWQgYmRhZGRyIHdoaWxlIHRoZSBjYWxsZXIgaG9sZHMgaGNpX2Rl
dl9sb2NrKCkuClVzZSB0aGUgc2FtZSBoZWxwZXIgYWZ0ZXIgaGNpX2V2ZW50X2Z1bmMoKSB3aXRo
IGEgTlVMTCBhZGRyZXNzIHRvCnByZXNlcnZlIHRoZSBleGlzdGluZyB1bmV4cGVjdGVkLXdha2Ug
ZmFsbGJhY2sgc2VtYW50aWNzIHdoZW4gbm8KdmFsaWRhdGVkIGV2ZW50IGhhbmRsZXIgcmVjb3Jk
cyBhIHdha2UgYWRkcmVzcy4KCkNhbGwgdGhlIGhlbHBlciBmcm9tIGhjaV9jb25uX3JlcXVlc3Rf
ZXZ0KCksIGhjaV9jb25uX2NvbXBsZXRlX2V2dCgpLApoY2lfbGVfYWR2X3JlcG9ydF9ldnQoKSwg
aGNpX2xlX2V4dF9hZHZfcmVwb3J0X2V2dCgpLCBhbmQKaGNpX2xlX2RpcmVjdF9hZHZfcmVwb3J0
X2V2dCgpLgoKRml4ZXM6IDJmMjAyMTZjMWQ2ZiAoIkJsdWV0b290aDogRW1pdCBjb250cm9sbGVy
IHN1c3BlbmQgYW5kIHJlc3VtZSBldmVudHMiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpT
aWduZWQtb2ZmLWJ5OiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2VhbC5vcmc+Ci0tLQp2NDoKLSBy
ZXNlbmQgd2l0aCBwcm9wZXIgaW5saW5lIHBhdGNoIGZvcm1hdHRpbmcgZm9yIENJOyBubyBjb2Rl
IGNoYW5nZXMKCnYzOgotIHJvdXRlIHRoZSB1bmV4cGVjdGVkLXdha2UgZmFsbGJhY2sgdGhyb3Vn
aCBoY2lfc3RvcmVfd2FrZV9yZWFzb24oTlVMTCwgMCkKICBhZnRlciBoY2lfZXZlbnRfZnVuYygp
LCBhcyBzdWdnZXN0ZWQgaW4gcmV2aWV3CgogbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyB8IDg5
ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKyksIDYwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9ibHVl
dG9vdGgvaGNpX2V2ZW50LmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jCmluZGV4IDI4NjUy
OWQyZS4uYzBlMGI0YTFjIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jCisr
KyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMKQEAgLTgwLDYgKzgwLDkgQEAgc3RhdGljIHZv
aWQgKmhjaV9sZV9ldl9za2JfcHVsbChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IHNrX2J1
ZmYgKnNrYiwKIAlyZXR1cm4gZGF0YTsKIH0KIAorc3RhdGljIHZvaWQgaGNpX3N0b3JlX3dha2Vf
cmVhc29uKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAorCQkJCSAgY29uc3QgYmRhZGRyX3QgKmJkYWRk
ciwgdTggYWRkcl90eXBlKTsKKwogc3RhdGljIHU4IGhjaV9jY19pbnF1aXJ5X2NhbmNlbChzdHJ1
Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAkJCQlzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQog
ewpAQCAtMzExMSw2ICszMTE0LDcgQEAgc3RhdGljIHZvaWQgaGNpX2Nvbm5fY29tcGxldGVfZXZ0
KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLAogCWJ0X2Rldl9kYmcoaGRldiwgInN0
YXR1cyAweCUyLjJ4Iiwgc3RhdHVzKTsKIAogCWhjaV9kZXZfbG9jayhoZGV2KTsKKwloY2lfc3Rv
cmVfd2FrZV9yZWFzb24oaGRldiwgJmV2LT5iZGFkZHIsIEJEQUREUl9CUkVEUik7CiAKIAkvKiBD
aGVjayBmb3IgZXhpc3RpbmcgY29ubmVjdGlvbjoKIAkgKgpAQCAtMzI3NCw2ICszMjc4LDEwIEBA
IHN0YXRpYyB2b2lkIGhjaV9jb25uX3JlcXVlc3RfZXZ0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2
b2lkICpkYXRhLAogCiAJYnRfZGV2X2RiZyhoZGV2LCAiYmRhZGRyICVwTVIgdHlwZSAweCV4Iiwg
JmV2LT5iZGFkZHIsIGV2LT5saW5rX3R5cGUpOwogCisJaGNpX2Rldl9sb2NrKGhkZXYpOworCWhj
aV9zdG9yZV93YWtlX3JlYXNvbihoZGV2LCAmZXYtPmJkYWRkciwgQkRBRERSX0JSRURSKTsKKwlo
Y2lfZGV2X3VubG9jayhoZGV2KTsKKwogCS8qIFJlamVjdCBpbmNvbWluZyBjb25uZWN0aW9uIGZy
b20gZGV2aWNlIHdpdGggc2FtZSBCRCBBRERSIGFnYWluc3QKIAkgKiBDVkUtMjAyMC0yNjU1NQog
CSAqLwpAQCAtNjQwMyw2ICs2NDExLDggQEAgc3RhdGljIHZvaWQgaGNpX2xlX2Fkdl9yZXBvcnRf
ZXZ0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLAogCQkJCQlpbmZvLT5sZW5ndGgg
KyAxKSkKIAkJCWJyZWFrOwogCisJCWhjaV9zdG9yZV93YWtlX3JlYXNvbihoZGV2LCAmaW5mby0+
YmRhZGRyLCBpbmZvLT5iZGFkZHJfdHlwZSk7CisKIAkJaWYgKGluZm8tPmxlbmd0aCA8PSBtYXhf
YWR2X2xlbihoZGV2KSkgewogCQkJcnNzaSA9IGluZm8tPmRhdGFbaW5mby0+bGVuZ3RoXTsKIAkJ
CXByb2Nlc3NfYWR2X3JlcG9ydChoZGV2LCBpbmZvLT50eXBlLCAmaW5mby0+YmRhZGRyLApAQCAt
NjQ5MSw2ICs2NTAxLDggQEAgc3RhdGljIHZvaWQgaGNpX2xlX2V4dF9hZHZfcmVwb3J0X2V2dChz
dHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAkJCQkJaW5mby0+bGVuZ3RoKSkKIAkJ
CWJyZWFrOwogCisJCWhjaV9zdG9yZV93YWtlX3JlYXNvbihoZGV2LCAmaW5mby0+YmRhZGRyLCBp
bmZvLT5iZGFkZHJfdHlwZSk7CisKIAkJZXZ0X3R5cGUgPSBfX2xlMTZfdG9fY3B1KGluZm8tPnR5
cGUpICYgTEVfRVhUX0FEVl9FVlRfVFlQRV9NQVNLOwogCQlsZWdhY3lfZXZ0X3R5cGUgPSBleHRf
ZXZ0X3R5cGVfdG9fbGVnYWN5KGhkZXYsIGV2dF90eXBlKTsKIApAQCAtNjgzNCw2ICs2ODQ2LDgg
QEAgc3RhdGljIHZvaWQgaGNpX2xlX2RpcmVjdF9hZHZfcmVwb3J0X2V2dChzdHJ1Y3QgaGNpX2Rl
diAqaGRldiwgdm9pZCAqZGF0YSwKIAlmb3IgKGkgPSAwOyBpIDwgZXYtPm51bTsgaSsrKSB7CiAJ
CXN0cnVjdCBoY2lfZXZfbGVfZGlyZWN0X2Fkdl9pbmZvICppbmZvID0gJmV2LT5pbmZvW2ldOwog
CisJCWhjaV9zdG9yZV93YWtlX3JlYXNvbihoZGV2LCAmaW5mby0+YmRhZGRyLCBpbmZvLT5iZGFk
ZHJfdHlwZSk7CisKIAkJcHJvY2Vzc19hZHZfcmVwb3J0KGhkZXYsIGluZm8tPnR5cGUsICZpbmZv
LT5iZGFkZHIsCiAJCQkJICAgaW5mby0+YmRhZGRyX3R5cGUsICZpbmZvLT5kaXJlY3RfYWRkciwK
IAkJCQkgICBpbmZvLT5kaXJlY3RfYWRkcl90eXBlLCBIQ0lfQURWX1BIWV8xTSwgMCwKQEAgLTc1
MTcsNzMgKzc1MzEsMjcgQEAgc3RhdGljIGJvb2wgaGNpX2dldF9jbWRfY29tcGxldGUoc3RydWN0
IGhjaV9kZXYgKmhkZXYsIHUxNiBvcGNvZGUsCiAJcmV0dXJuIHRydWU7CiB9CiAKLXN0YXRpYyB2
b2lkIGhjaV9zdG9yZV93YWtlX3JlYXNvbihzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTggZXZlbnQs
Ci0JCQkJICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQorLyogaGRldiBsb2NrIG11c3QgYmUgaGVsZC4g
cGFzcyBOVUxMIGJkYWRkciB0byByZWNvcmQgYW4gdW5leHBlY3RlZCB3YWtlLiAqLworc3RhdGlj
IHZvaWQgaGNpX3N0b3JlX3dha2VfcmVhc29uKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAorCQkJCSAg
Y29uc3QgYmRhZGRyX3QgKmJkYWRkciwgdTggYWRkcl90eXBlKQogewotCXN0cnVjdCBoY2lfZXZf
bGVfYWR2ZXJ0aXNpbmdfaW5mbyAqYWR2OwotCXN0cnVjdCBoY2lfZXZfbGVfZGlyZWN0X2Fkdl9p
bmZvICpkaXJlY3RfYWR2OwotCXN0cnVjdCBoY2lfZXZfbGVfZXh0X2Fkdl9pbmZvICpleHRfYWR2
OwotCWNvbnN0IHN0cnVjdCBoY2lfZXZfY29ubl9jb21wbGV0ZSAqY29ubl9jb21wbGV0ZSA9ICh2
b2lkICopc2tiLT5kYXRhOwotCWNvbnN0IHN0cnVjdCBoY2lfZXZfY29ubl9yZXF1ZXN0ICpjb25u
X3JlcXVlc3QgPSAodm9pZCAqKXNrYi0+ZGF0YTsKLQotCWhjaV9kZXZfbG9jayhoZGV2KTsKLQog
CS8qIElmIHdlIGFyZSBjdXJyZW50bHkgc3VzcGVuZGVkIGFuZCB0aGlzIGlzIHRoZSBmaXJzdCBC
VCBldmVudCBzZWVuLAogCSAqIHNhdmUgdGhlIHdha2UgcmVhc29uIGFzc29jaWF0ZWQgd2l0aCB0
aGUgZXZlbnQuCiAJICovCiAJaWYgKCFoZGV2LT5zdXNwZW5kZWQgfHwgaGRldi0+d2FrZV9yZWFz
b24pCi0JCWdvdG8gdW5sb2NrOworCQlyZXR1cm47CisKKwlpZiAoIWJkYWRkcikgeworCQloZGV2
LT53YWtlX3JlYXNvbiA9IE1HTVRfV0FLRV9SRUFTT05fVU5FWFBFQ1RFRDsKKwkJcmV0dXJuOwor
CX0KIAogCS8qIERlZmF1bHQgdG8gcmVtb3RlIHdha2UuIFZhbHVlcyBmb3Igd2FrZV9yZWFzb24g
YXJlIGRvY3VtZW50ZWQgaW4gdGhlCiAJICogQmx1ZXogbWdtdCBhcGkgZG9jcy4KIAkgKi8KIAlo
ZGV2LT53YWtlX3JlYXNvbiA9IE1HTVRfV0FLRV9SRUFTT05fUkVNT1RFX1dBS0U7Ci0KLQkvKiBP
bmNlIGNvbmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAsIHdlIHNob3VsZCBvbmx5IHdha2UgdXAg
Zm9yCi0JICogcmVjb25uZWN0aW9ucy4gSXQncyB1c2VmdWwgdG8gc2VlIHdoaWNoIGRldmljZSBp
cyB3YWtpbmcgdXMgdXAgc28KLQkgKiBrZWVwIHRyYWNrIG9mIHRoZSBiZGFkZHIgb2YgdGhlIGNv
bm5lY3Rpb24gZXZlbnQgdGhhdCB3b2tlIHVzIHVwLgotCSAqLwotCWlmIChldmVudCA9PSBIQ0lf
RVZfQ09OTl9SRVFVRVNUKSB7Ci0JCWJhY3B5KCZoZGV2LT53YWtlX2FkZHIsICZjb25uX3JlcXVl
c3QtPmJkYWRkcik7Ci0JCWhkZXYtPndha2VfYWRkcl90eXBlID0gQkRBRERSX0JSRURSOwotCX0g
ZWxzZSBpZiAoZXZlbnQgPT0gSENJX0VWX0NPTk5fQ09NUExFVEUpIHsKLQkJYmFjcHkoJmhkZXYt
Pndha2VfYWRkciwgJmNvbm5fY29tcGxldGUtPmJkYWRkcik7Ci0JCWhkZXYtPndha2VfYWRkcl90
eXBlID0gQkRBRERSX0JSRURSOwotCX0gZWxzZSBpZiAoZXZlbnQgPT0gSENJX0VWX0xFX01FVEEp
IHsKLQkJc3RydWN0IGhjaV9ldl9sZV9tZXRhICpsZV9ldiA9ICh2b2lkICopc2tiLT5kYXRhOwot
CQl1OCBzdWJldmVudCA9IGxlX2V2LT5zdWJldmVudDsKLQkJdTggKnB0ciA9ICZza2ItPmRhdGFb
c2l6ZW9mKCpsZV9ldildOwotCQl1OCBudW1fcmVwb3J0cyA9ICpwdHI7Ci0KLQkJaWYgKChzdWJl
dmVudCA9PSBIQ0lfRVZfTEVfQURWRVJUSVNJTkdfUkVQT1JUIHx8Ci0JCSAgICAgc3ViZXZlbnQg
PT0gSENJX0VWX0xFX0RJUkVDVF9BRFZfUkVQT1JUIHx8Ci0JCSAgICAgc3ViZXZlbnQgPT0gSENJ
X0VWX0xFX0VYVF9BRFZfUkVQT1JUKSAmJgotCQkgICAgbnVtX3JlcG9ydHMpIHsKLQkJCWFkdiA9
ICh2b2lkICopKHB0ciArIDEpOwotCQkJZGlyZWN0X2FkdiA9ICh2b2lkICopKHB0ciArIDEpOwot
CQkJZXh0X2FkdiA9ICh2b2lkICopKHB0ciArIDEpOwotCi0JCQlzd2l0Y2ggKHN1YmV2ZW50KSB7
Ci0JCQljYXNlIEhDSV9FVl9MRV9BRFZFUlRJU0lOR19SRVBPUlQ6Ci0JCQkJYmFjcHkoJmhkZXYt
Pndha2VfYWRkciwgJmFkdi0+YmRhZGRyKTsKLQkJCQloZGV2LT53YWtlX2FkZHJfdHlwZSA9IGFk
di0+YmRhZGRyX3R5cGU7Ci0JCQkJYnJlYWs7Ci0JCQljYXNlIEhDSV9FVl9MRV9ESVJFQ1RfQURW
X1JFUE9SVDoKLQkJCQliYWNweSgmaGRldi0+d2FrZV9hZGRyLCAmZGlyZWN0X2Fkdi0+YmRhZGRy
KTsKLQkJCQloZGV2LT53YWtlX2FkZHJfdHlwZSA9IGRpcmVjdF9hZHYtPmJkYWRkcl90eXBlOwot
CQkJCWJyZWFrOwotCQkJY2FzZSBIQ0lfRVZfTEVfRVhUX0FEVl9SRVBPUlQ6Ci0JCQkJYmFjcHko
JmhkZXYtPndha2VfYWRkciwgJmV4dF9hZHYtPmJkYWRkcik7Ci0JCQkJaGRldi0+d2FrZV9hZGRy
X3R5cGUgPSBleHRfYWR2LT5iZGFkZHJfdHlwZTsKLQkJCQlicmVhazsKLQkJCX0KLQkJfQotCX0g
ZWxzZSB7Ci0JCWhkZXYtPndha2VfcmVhc29uID0gTUdNVF9XQUtFX1JFQVNPTl9VTkVYUEVDVEVE
OwotCX0KLQotdW5sb2NrOgotCWhjaV9kZXZfdW5sb2NrKGhkZXYpOworCWJhY3B5KCZoZGV2LT53
YWtlX2FkZHIsIGJkYWRkcik7CisJaGRldi0+d2FrZV9hZGRyX3R5cGUgPSBhZGRyX3R5cGU7CiB9
CiAKICNkZWZpbmUgSENJX0VWX1ZMKF9vcCwgX2Z1bmMsIF9taW5fbGVuLCBfbWF4X2xlbikgXApA
QCAtNzgzMCwxNCArNzc5OCwxNSBAQCB2b2lkIGhjaV9ldmVudF9wYWNrZXQoc3RydWN0IGhjaV9k
ZXYgKmhkZXYsIHN0cnVjdCBza19idWZmICpza2IpCiAKIAlza2JfcHVsbChza2IsIEhDSV9FVkVO
VF9IRFJfU0laRSk7CiAKLQkvKiBTdG9yZSB3YWtlIHJlYXNvbiBpZiB3ZSdyZSBzdXNwZW5kZWQg
Ki8KLQloY2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgZXZlbnQsIHNrYik7Ci0KIAlidF9kZXZf
ZGJnKGhkZXYsICJldmVudCAweCUyLjJ4IiwgZXZlbnQpOwogCiAJaGNpX2V2ZW50X2Z1bmMoaGRl
diwgZXZlbnQsIHNrYiwgJm9wY29kZSwgJnN0YXR1cywgJnJlcV9jb21wbGV0ZSwKIAkJICAgICAg
ICZyZXFfY29tcGxldGVfc2tiKTsKIAorCWhjaV9kZXZfbG9jayhoZGV2KTsKKwloY2lfc3RvcmVf
d2FrZV9yZWFzb24oaGRldiwgTlVMTCwgMCk7CisJaGNpX2Rldl91bmxvY2soaGRldik7CisKIAlp
ZiAocmVxX2NvbXBsZXRlKSB7CiAJCXJlcV9jb21wbGV0ZShoZGV2LCBzdGF0dXMsIG9wY29kZSk7
CiAJfSBlbHNlIGlmIChyZXFfY29tcGxldGVfc2tiKSB7Ci0tIAoyLjUwLjAK

