Return-Path: <stable+bounces-210286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A018D3A2CC
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD8363002D3F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B4355812;
	Mon, 19 Jan 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hp.com header.i=@hp.com header.b="c/MHYA2K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D134403A
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814643; cv=none; b=VaJH/GdWDPDa5XMJTzBv6YgEUp+98ToQNLKm0CLip/u63+pRVpXwooapC7KC+JsEIS9WBaA0C30Sn0MncQt2pYLmwJHXheKODDJlwOho114JLQUVXr8zY0SMdksblp6YUNwegWjDom6duRUs2c2ZTLiwhMfZ0YEeC7NNLGruwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814643; c=relaxed/simple;
	bh=E77NR+SIlGnxutcVcNBIJEDngkJggLkMar/3SbeuWDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YLpvMiENZPkxTBfJ8+oTK6suEZ/G/4O05mZ5y/VWeudcx3Gyuvf98uGVjH0VtbRvEEDM57YGY4ei5jB9QonXWYZm1RHzBscuGiCkYZj84n6TDIGNeZWO/qcFX3jEtsfC5iGOb3qV/U7kzdE2xg2PKS+JNejY+E4FG1dX+vSGcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (2048-bit key) header.d=hp.com header.i=@hp.com header.b=c/MHYA2K; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20250822;
	t=1768814639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDwvrK1fEWAKPWiH4V2PVz2qXMcAoj0Nl0hTcCuPHUQ=;
	b=c/MHYA2K0KhEBB3B80NQCQpNL7WQikSMHt1CRc6g+Gz0tjbFyclEiCmwOPERehokenHh+r
	M1R78NNIk6aYhnw7PSO+NSHW655+HC7lIUNHaA+U9wzNcvAI8bmPsgEvhsWSSXjbDba9nS
	1jNJGZNWOsJASr6zADV6YTea34Y8fZudPlf3NZmYjiXgsjB15DUT50zaUxLa73y8sJxLCe
	OEe45AMEo8PIeD/WsRuC19RHCHJ7Y3lmiwkyqJE5RFDB1bmIY5k5GdhBucZUQAUP7bLNOb
	id8FuuSessJe+01B3l71uU8lNATkatGsPuS4mHVFYh/ukZ0Ir00D6aO8hjOZ1g==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-JOP6BgBFPLmniGpLvwXAHw-2; Mon,
 19 Jan 2026 04:23:56 -0500
X-MC-Unique: JOP6BgBFPLmniGpLvwXAHw-2
X-Mimecast-MFC-AGG-ID: JOP6BgBFPLmniGpLvwXAHw_1768814634
Received: from MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::12)
 by CYXPR84MB3453.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:23:52 +0000
Received: from MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b2f4:886e:d0c:a3e]) by MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b2f4:886e:d0c:a3e%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 09:23:52 +0000
From: "Wan, Qin (Thin Client RnD)" <qin.wan@hp.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"kailang@realtek.com" <kailang@realtek.com>, "chris.chiu@canonical.com"
	<chris.chiu@canonical.com>, "edip@medip.dev" <edip@medip.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Gagniuc, Alexandru"
	<alexandru.gagniuc@hp.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFMU0E6IGhkYS9yZWFsdGVrOiBGaXggbWljbXV0?=
 =?utf-8?Q?e_led_for_HP_ElitBook_6_G2a?=
Thread-Topic: [PATCH] ALSA: hda/realtek: Fix micmute led for HP ElitBook 6 G2a
Thread-Index: AQHciPYbk9/+K+ahYk6b7k9CablnL7VZJq4AgAAC6KU=
Date: Mon, 19 Jan 2026 09:23:52 +0000
Message-ID: <MW4PR84MB15161B06885B6F2E884BBBC98D88A@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
References: <20260119034504.3047301-1-qin.wan@hp.com>
 <87o6mq816j.wl-tiwai@suse.de>
In-Reply-To: <87o6mq816j.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB1516:EE_|CYXPR84MB3453:EE_
x-ms-office365-filtering-correlation-id: 5f51d0bd-482c-4e1f-1903-08de573c7624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|4053099003|38070700021
x-microsoft-antispam-message-info: =?utf-8?B?MkJtUEM0eDk3UXVFTDgxOVdoS0VxVjB0K0NQKzVoZGRQaTBvem53RzAzcFo1?=
 =?utf-8?B?NFpNNXRzMmRyYjNvRk5XQkhnS0w3alZtMjk3UDdDcFk5cmJtbFI5UkI5WlMy?=
 =?utf-8?B?ZjhTYlhocktBclhZaHdGWi9kckpJa3Y4Zm1YMW91bHIxOEZKL21xQkIzelJW?=
 =?utf-8?B?b0JJQzB3RHhDNHlHVndNSGtQMFdOUFZabjhWN2pPWXNVa2VBb1NhYThrZDIr?=
 =?utf-8?B?SVZUR0txTXdKM2k5WEtUR1A0ZUE2WTcwUjVTNGlGQ3YvNmJQT09oWGNsa1R1?=
 =?utf-8?B?SnNqNXlsZ21UeDM0enFPV1BOV1NYSUlvYnZpY1RBQlBUVGVrdXlUa0RJYkFw?=
 =?utf-8?B?eTBuNEk1TWtZb2kzdmkyam5EMWVlcHpRTHBHS0FJZmNsdVNhdGZCSytmbTRE?=
 =?utf-8?B?b3FDUTVzM3poUkhCSDNIOTVSMjREd0hwalkvakZZV0dvdTQvNzRjZGx4RHRO?=
 =?utf-8?B?dDAxYjd5NkFrWDd1c2F4SDY3YlBTc1JPVUZwQ2tvTHZNUElwSW40bzFUUzdt?=
 =?utf-8?B?dWxzUnpLTkxYV2Z0S21HLzhWeXhiVk5TU1NjWTVDWTRsQzI4d1AxYTE4RlpF?=
 =?utf-8?B?NC92YUhPVTUweEZaTjl1YytFV1d3bm5vbFE4Qng0UHh4OHRubG9uT3ZUVGxy?=
 =?utf-8?B?ejNOOU1UbjdZZVZHMWV1TzVpT0hVb3owZFIvTSt6aTB4VHArMUpDa0toeDJ1?=
 =?utf-8?B?T1VGQzVzSUhzdGJPUlZWVWFnTVBHOHg3NnBpQVo2V2hoS0JWdzVKSjFlUzBF?=
 =?utf-8?B?RU1sZEphZWh4aEIrYlZaR1NvMUN2OVV5aFZ4OU56RlI0V3V0WW10K1h6Y01S?=
 =?utf-8?B?ZEJkTnJnTS9vdThmYnIrZjFISDcyOWVaVVFTeEFjRlRkZUNxZ1ZucGZ4NEVp?=
 =?utf-8?B?OVE1RzgyWXFjZDZEbHVsWnlnN1pOQlNYQVVWd3dFdVZvODRNNHlJRFIxTytY?=
 =?utf-8?B?UzE1YUpkRHUzWGNHRkNSVlU1YnhMU2JzYkNaZDBVQXRXSWV4a3l4U0Iyd0Jn?=
 =?utf-8?B?WWwwSGF5emZrcHhZenFlR1MrT3RBeUU1OHdLRXduTjkwakYyYllaVXdLMUZl?=
 =?utf-8?B?OXZnUDN5L1NqUVFJUU9NYStrWVNJUHVzWmhnN2QvUEtCSkVJdXR5RktIWStD?=
 =?utf-8?B?Tld4bFJ2QS9CZmlJVXdEeXYrRmlXdmJROU5Cb2JXaUxtbjhuWlJ4b3VxOUgx?=
 =?utf-8?B?bWRjTXlYUnBxZnExUi9ZOXZHWHVIR0R0c3dzN3B1MC9BdWFldXRVUC9wbDg2?=
 =?utf-8?B?ejk0N1JpQ1RmUXFucUR1Zk1QSm1PdWs2ZTJxdm11QzRqQUVRekZKeVBxS2lR?=
 =?utf-8?B?cXhvSTdPOHd3dDBUcy94Y2YvcllpOWNvTnM2eGxhblRJQm9PUHNwYkU5RVlK?=
 =?utf-8?B?b3F4dUVrNXE5QzFyV2xjblMxSGErdUcrODBra1BwZHRLajg2dlJQa2RMZHVu?=
 =?utf-8?B?ZlM5Q21uR1ZBd0VJY0FpbWdJRmxGaGpNWjc3TURUZ3doMWRmZFdWbkUycm1G?=
 =?utf-8?B?eVdVWnlBendvYVZrM3FXdmFCdVU5Qjc5aFB4U0RvZjF6MUFyTlI3MzNGUE9h?=
 =?utf-8?B?b3ZkSVM1Qk1MdnJYYWtWQ3pUT1gvSDl3d3djSDNWdngvRlFDc1FiVE1ONTAr?=
 =?utf-8?B?WTh0dVg4NEpaMjFNSUtOanZmK2MrSlhPWHhVdWxXWjZ5djZJbUtNQXJiakN3?=
 =?utf-8?B?QS9yaE9MeHYveThJbUxBYVkrekM2UVVUVDErT2FMS055aElwV0d2eEp4SUdn?=
 =?utf-8?B?OHNYNVYrdStsMCs4T3JLMkZTbkNkWGhDdUNScnpiNGxEb2htK3BwQnN1K0V0?=
 =?utf-8?B?aFVwK3JndXN0ak8yK3RRdDExUnNtcHBjYTZLUno0YzNUQytnbW9xd1NGdkVQ?=
 =?utf-8?B?NGxDT1U2bUxYNW9PMldnM0JmeDJlT0ovLzFzcHJGaGZpbkpwMnFUVVBDTjFD?=
 =?utf-8?B?UnJpb0cwckFVMExGelNTQy9UU0YyMzJuZ3BUcVgvdGxkSE0vcW1mMi83Q1Mz?=
 =?utf-8?B?RFlISGRKa0VacGdFOWpRNkt1ZEpXK2cwMXcrYUp5TEtEelJMdHNwYmtzaGw3?=
 =?utf-8?B?Q3BCRTVzZGVGRitRRDUrMS9tdGc2SlNqUTFmSGNaV2VZWUFLVFFuZVU1NWNE?=
 =?utf-8?B?bktpM290TXRhQmpTVnJLN3ZMM2syM0N6bTl4cFcyOFpBVStnOU5aMndsTE1s?=
 =?utf-8?Q?OeYGKFl2c+Pouy3WdbYnrwU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(4053099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFJZdHEyY1Fta29yMFAyb2FxQlV6NGFQSlFKM2dTdlcwenhOb0hhK0c1aE0v?=
 =?utf-8?B?T3dJNkNWamZ2dzZ6bFV4R2g4cHdsYTZ4M0tlamg4NHI5Z1VGeWI2Mm9tMUZx?=
 =?utf-8?B?eitHaGFoWkZIMFVFR1JJakxEY0N5eCtsenQ0MDk3ZWI2K3VyOGgxa2lWbUFs?=
 =?utf-8?B?b295VWVFWVNtR3I5YnpTa2R6eXVvUk5OY2lsRUtyMlI3TEJkNndqSlorQkNw?=
 =?utf-8?B?alNTUUhPUG5NZzNwZUkyM0dScWNYNm51ZGljaHpRSHc2MTZyQ2h1VHNueVlP?=
 =?utf-8?B?UGtBcU5iUTI4T2V4Tm02emlDVldZRGEzVDF0YUxRTksxc3lKWUROd2JqbWpX?=
 =?utf-8?B?QlBkbEZWQ21tRXJnMmk5d0xZWm5ZOHRzQVpMOGZhdUF1MUVSeHhQdERMSlEv?=
 =?utf-8?B?R1kvTXdYNGh0a0plamFPd3lQYmUyeGNyWElpenoweWErTVJLRjI3WG8vU2cx?=
 =?utf-8?B?UDVoZytnUUtjMTU2UVR3SzlUMGpsODN4aC8wMGFGcURzTytERzljb0c4ejNr?=
 =?utf-8?B?R0x3VjVIWitEM1pudzNDRk1zMXNXTnNMQTBQWlVyd0RSb3J2YitYMXVkaUJs?=
 =?utf-8?B?RmFpb2pSbStldmtuQWZ6NVRtNVNZMGhQZy9Ib0l5Y2piejhKZWNTOStrUlZO?=
 =?utf-8?B?THhTYi9aMzN2azJONys3dllPSlBGSFhBbkZ5Q0JaQnhOVlBra2E2VU0yRGxt?=
 =?utf-8?B?MGRkM3VNOWRHZStRSWNEQnpNYWgzUTFQNVNmdDVGVEZWZU51M1k1Y0pDT0pD?=
 =?utf-8?B?dFR5a0tKclJZVjJ4Q2lIVU9DZGxtQk9ITVhRdjZjSVJWVzdCcFpDTkpzMnJL?=
 =?utf-8?B?dmQxeUtsZS85MUJJNlRhWUlaWGVsL3I5MVo2Z1FpNTVlODFYQXhzY3k4RlFC?=
 =?utf-8?B?aExLUkQxcXU2MFdOeWJaOG1DY0tpQVZ2NzBwdmhSMlZhR1cvRFM0WE1pb3Vt?=
 =?utf-8?B?SUpUampQUFAwY1hrUFNOUlFYYllLYWd4cFc0cEQwc0U0VDVMU1R0QmlUblkx?=
 =?utf-8?B?MEgrdDNOV2RldmJTUW5TRUVYblh6RUpPZ3FwN01HcGR3RmM1dUZWa1lsQXZQ?=
 =?utf-8?B?NUI4ZDh5NWxRSkJaYURpWlZUTFZ6VURYditaWDVzUFluSDVUaHE0aWRkSjkw?=
 =?utf-8?B?NzBVZVU3T3psZklWenZob2JMWUFkOVFoK00zRHF1R0ZVMUZGUkZPK3hEaVFu?=
 =?utf-8?B?bDdtV3kvd2J1eHFRblNzSExpT1d4NUplY1B0Q3lqWHU2bGFUWnJ3MmI1eGxF?=
 =?utf-8?B?MVNvY2l2NVUwWEQ2WTdrTWg4VEw4cjl4WS9rVlNkVE1uczFpU29tVHg2cW0v?=
 =?utf-8?B?NFlCV01JK0JPS044UGt1enJwZEQxb1ZJMUFmVjllbTJ5L2V6MkFVcGVIR1RM?=
 =?utf-8?B?YllYeHlHaDl3UXNzL1N5Z05Bc3RZMG9ZSTlGVWRYUUp0YjJvaHFCZmVjenlZ?=
 =?utf-8?B?TGR1TWNrNjhoa0QyQitCMlk1R1ZyOG9HeElUYUdUTWVTb1JGeVJ3YmhkT1lF?=
 =?utf-8?B?N2NEeXhHdmo5ZVJ5NHZ3ek1GSGh4aHBjZEo0Rk5hWmJ4NGtjbE54S1Y2R2t1?=
 =?utf-8?B?WWRKUVpucFBMT1FhZ2xwdWxvQnkvQU5uWk9jU0x1cG5kc2h0MmVEUmI1dUZw?=
 =?utf-8?B?RW9uWnYyWEE2YWY2TUx1bDY2ajM1WFlaS1RkVkx2Z3Y0cHprZ2htdm1LdkUy?=
 =?utf-8?B?dFR1clA3WXg5b3VWQlhlK3FWd045QnN6N0lUNUltdk56bmhSU0Q1V1dYZE1h?=
 =?utf-8?B?Vlhma3EvNmo4dlRIK3dQTWMrOEVSTjFETFMzRHlzWk1WVHFaVkt2TitOUEVs?=
 =?utf-8?B?dVYzbm5VRCsyTTBxZDIzaGpiUTJBdllKc25BcTVIU2tjWG5GZk9iYTQ0SzdY?=
 =?utf-8?B?MlUxamNYV1lORmtJV01oY3FKb1o2VlhmYzcveVVXam1zS0U1MFFidUhhSEZR?=
 =?utf-8?B?aEVmeDdBR3ZzSWVZY0g4Qyt5Mm9sRmR4Mk02dXlQUml1UWErUVJQNTFsUHZC?=
 =?utf-8?B?ZUhJTWRkSGlacEtuajZqT2xYWGs0QVl2Tm5yTHN3L2xOUVB0RHU2RkRRSTN2?=
 =?utf-8?B?Mk1vcDhLb05yTGNiWHZQNTVoSFhreE85UnVJbXRaZ2F2VXlwZERQWVRKQklh?=
 =?utf-8?B?T2R0R1NmQlYwc0c0M3VYd0RwZTU5Rm5pSmovYmxtNTZTcUN0bkJvYmhZYWhr?=
 =?utf-8?B?cEpCZCt6MThlWXpCQU1VaDI3TnZsVlg5M1kyVHlaT1FrVkFUZHorWnQyM2RI?=
 =?utf-8?Q?48GyvrfhkG9kq2w+fO7ULlMH5d1iij0e1b2Iw0RdLc=3D?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f51d0bd-482c-4e1f-1903-08de573c7624
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 09:23:52.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Trk2jab8E/1Su4Q3FN7VFi9hf8NlykQ/RQVJ0clZLP52Y+mkYQn8xhfDKHDuoHky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3453
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LT1U9EQQwrTIZcLpvJQFBljsY2PKlh8gIud18wI5op8_1768814634
X-Mimecast-Originator: hp.com
Content-Language: zh-CN
Content-Type: multipart/mixed;
	boundary="_002_MW4PR84MB15161B06885B6F2E884BBBC98D88AMW4PR84MB1516NAMP_"

--_002_MW4PR84MB15161B06885B6F2E884BBBC98D88AMW4PR84MB1516NAMP_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8sCgogICBJIGNvcnJlY3RlZCB0aGUgcGF0Y2ggYmFzZWQgb24gbWFpbmxpbmUgYW5kIGFk
ZCBzdGFibGUgdGFnLgoKVGhhbmtzLApXYW5xaW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCuWPkeS7tuS6ujogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgrl
t7Llj5HpgIE6IDIwMjYg5bm0IDEg5pyIIDE5IOaXpSDmmJ/mnJ/kuIAgMTY6MTkK5pS25Lu25Lq6
OiBXYW4sIFFpbiAoVGhpbiBDbGllbnQgUm5EKSA8cWluLndhbkBocC5jb20+CuaKhOmAgTogcGVy
ZXhAcGVyZXguY3ogPHBlcmV4QHBlcmV4LmN6PjsgdGl3YWlAc3VzZS5jb20gPHRpd2FpQHN1c2Uu
Y29tPjsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tIDxzYmluZGluZ0BvcGVuc291cmNl
LmNpcnJ1cy5jb20+OyBrYWlsYW5nQHJlYWx0ZWsuY29tIDxrYWlsYW5nQHJlYWx0ZWsuY29tPjsg
Y2hyaXMuY2hpdUBjYW5vbmljYWwuY29tIDxjaHJpcy5jaGl1QGNhbm9uaWNhbC5jb20+OyBlZGlw
QG1lZGlwLmRldiA8ZWRpcEBtZWRpcC5kZXY+OyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmcg
PGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBzdGFibGVAdmdlci5rZXJuZWwub3Jn
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPjsgR2Fnbml1YywgQWxleGFuZHJ1IDxhbGV4YW5kcnUu
Z2Fnbml1Y0BocC5jb20+OyBBbGV4YW5kcnUgR2Fnbml1YyA8bXIubnVrZS5tZUBnbWFpbC5jb20+
CuS4u+mimDogUmU6IFtQQVRDSF0gQUxTQTogaGRhL3JlYWx0ZWs6IEZpeCBtaWNtdXRlIGxlZCBm
b3IgSFAgRWxpdEJvb2sgNiBHMmEKCgpDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbAoKT24gTW9uLCAx
OSBKYW4gMjAyNiAwNDo0NTowNCArMDEwMCwKUWluIFdhbiB3cm90ZToKPgo+IFRoaXMgbGFwdG9w
IHVzZXMgdGhlIEFMQzIzNiBjb2RlYywgZml4ZWQgYnkgZW5hYmxpbmcKPiB0aGUgQUxDMjM2X0ZJ
WFVQX0hQX01VVEVfTEVEX01JQ01VVEVfVlJFRiBxdWlyawo+Cj4gU2lnbmVkLW9mZi1ieTogUWlu
IFdhbiA8cWluLndhbkBocC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEdhZ25pdWMg
PG1yLm51a2UubWVAZ21haWwuY29tPgoKVGhlIHBhdGNoIGlzbid0IGFwcGxpY2FibGUgY2xlYW5s
eSBhdCBhbGwsIGFzIHlvdSBoYXZlIGxvdHMgb2YKZGlmZmVyZW50IHF1aXJrIGVudHJpZXMuwqAg
V2hpY2ggZ2l0IHRyZWUgaXMgaXQgYmFzZWQgb24/CgoKdGhhbmtzLAoKVGFrYXNoaQoKPiAtLS0K
PsKgIHNvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYyB8IDQgKysrKwo+wqAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2Rl
Y3MvcmVhbHRlay9hbGMyNjkuYyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwo+
IGluZGV4IDBiZDlmZTc0NTgwNy4uNDk1OTA5MjYxOTllIDEwMDY0NAo+IC0tLSBhL3NvdW5kL2hk
YS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwo+ICsrKyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRl
ay9hbGMyNjkuYwo+IEBAIC02NzA0LDYgKzY3MDQsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBo
ZGFfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewo+wqDCoMKgwqDCoMKgIFNORF9QQ0lfUVVJ
UksoMHgxMDNjLCAweDhlZDgsICJIUCBNZXJpbm8xNiIsIEFMQzI0NV9GSVhVUF9UQVMyNzgxX1NQ
SV8yKSwKPsKgwqDCoMKgwqDCoCBTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4ZWQ5LCAiSFAgTWVy
aW5vMTRXIiwgQUxDMjQ1X0ZJWFVQX1RBUzI3ODFfU1BJXzIpLAo+wqDCoMKgwqDCoMKgIFNORF9Q
Q0lfUVVJUksoMHgxMDNjLCAweDhlZGEsICJIUCBNZXJpbm8xNlciLCBBTEMyNDVfRklYVVBfVEFT
Mjc4MV9TUElfMiksCj4gK8KgwqDCoMKgIFNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDhmMTQsICJI
UCBFbGl0ZUJvb2sgNiBHMmEgMTQiLCBBTEMyMzZfRklYVVBfSFBfTVVURV9MRURfTUlDTVVURV9W
UkVGKSwKPiArwqDCoMKgwqAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGYxOSwgIkhQIEVsaXRl
Qm9vayA2IEcyYSAxNiIswqAgQUxDMjM2X0ZJWFVQX0hQX01VVEVfTEVEX01JQ01VVEVfVlJFRiks
Cj4gK8KgwqDCoMKgIFNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDhmM2MsICJIUCBFbGl0ZUJvb2sg
NiBHMmEgMTQiLCBBTEMyMzZfRklYVVBfSFBfTVVURV9MRURfTUlDTVVURV9WUkVGKSwKPiArwqDC
oMKgwqAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGYzZCwgIkhQIEVsaXRlQm9vayA2IEcyYSAx
NiIsIEFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRF9NSUNNVVRFX1ZSRUYpLAo+wqDCoMKgwqDCoMKg
IFNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDhmNDAsICJIUCBMYW1wYXMxNCIsIEFMQzI4N19GSVhV
UF9UWE5XMjc4MV9JMkMpLAo+wqDCoMKgwqDCoMKgIFNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDhm
NDEsICJIUCBMYW1wYXMxNiIsIEFMQzI4N19GSVhVUF9UWE5XMjc4MV9JMkMpLAo+wqDCoMKgwqDC
oMKgIFNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDhmNDIsICJIUCBMYW1wYXNXMTQiLCBBTEMyODdf
RklYVVBfVFhOVzI3ODFfSTJDKSwKPiAtLQo+IDIuNDMuMAo+CgoKCg0K
--_002_MW4PR84MB15161B06885B6F2E884BBBC98D88AMW4PR84MB1516NAMP_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-realtek-Fix-micmute-led-for-HP-ElitBook-6-G.patch"
Content-Description: 0001-ALSA-hda-realtek-Fix-micmute-led-for-HP-ElitBook-6-G.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-realtek-Fix-micmute-led-for-HP-ElitBook-6-G.patch";
	size=1625; creation-date="Mon, 19 Jan 2026 09:22:46 GMT";
	modification-date="Mon, 19 Jan 2026 09:22:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNTcwMGNjMTg3NjE0ZTZjNTNhNmExZDE2OTczN2M0MzYzZDAwNzI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaW4gV2FuIDxxaW4ud2FuQGhwLmNvbT4KRGF0ZTogTW9uLCAx
OSBKYW4gMjAyNiAxNjozOTo1OCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IGhkYS9yZWFs
dGVrOiBGaXggbWljbXV0ZSBsZWQgZm9yIEhQIEVsaXRCb29rIDYgRzJhCgpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwoKU2lnbmVkLW9mZi1ieTogUWluIFdhbiA8cWluLndhbkBocC5jb20+ClNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRydSBHYWduaXVjIDxtci5udWtlLm1lQGdtYWlsLmNvbT4KLS0t
CiBzb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMgfCA0ICsrKysKIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0
ZWsvYWxjMjY5LmMgYi9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMKaW5kZXggMjk0
NjllNTQ5NzkxLi45ZjA4M2MzNjU0ODkgMTAwNjQ0Ci0tLSBhL3NvdW5kL2hkYS9jb2RlY3MvcmVh
bHRlay9hbGMyNjkuYworKysgYi9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMKQEAg
LTY4MTMsNiArNjgxMywxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9xdWlyayBhbGMyNjlf
Zml4dXBfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGVlNywgIkhQIEFiZSBB
NlUiLCBBTEMyMzZfRklYVVBfSFBfTVVURV9MRURfTUlDTVVURV9HUElPKSwKIAlTTkRfUENJX1FV
SVJLKDB4MTAzYywgMHg4ZjBjLCAiSFAgWkJvb2sgWCBHMmkgMTZXIiwgQUxDMjM2X0ZJWFVQX0hQ
X0dQSU9fTEVEKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4ZjBlLCAiSFAgWkJvb2sgWCBH
MmkgMTZXIiwgQUxDMjM2X0ZJWFVQX0hQX0dQSU9fTEVEKSwKKwlTTkRfUENJX1FVSVJLKDB4MTAz
YywgMHg4ZjE0LCAiSFAgRWxpdGVCb29rIDYgRzJhIDE0IiwgQUxDMjM2X0ZJWFVQX0hQX01VVEVf
TEVEX01JQ01VVEVfVlJFRiksCisJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGYxOSwgIkhQIEVs
aXRlQm9vayA2IEcyYSAxNiIsIEFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRF9NSUNNVVRFX1ZSRUYp
LAorCVNORF9QQ0lfUVVJUksoMHgxMDNjLCAweDhmM2MsICJIUCBFbGl0ZUJvb2sgNiBHMmEgMTQi
LCBBTEMyMzZfRklYVVBfSFBfTVVURV9MRURfTUlDTVVURV9WUkVGKSwKKwlTTkRfUENJX1FVSVJL
KDB4MTAzYywgMHg4ZjNkLCAiSFAgRWxpdGVCb29rIDYgRzJhIDE2IiwgQUxDMjM2X0ZJWFVQX0hQ
X01VVEVfTEVEX01JQ01VVEVfVlJFRiksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGY0MCwg
IkhQIFpCb29rIDggRzJhIDE0IiwgQUxDMjQ1X0ZJWFVQX0hQX1RBUzI3ODFfSTJDX01VVEVfTEVE
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4ZjQxLCAiSFAgWkJvb2sgOCBHMmEgMTYiLCBB
TEMyNDVfRklYVVBfSFBfVEFTMjc4MV9JMkNfTVVURV9MRUQpLAogCVNORF9QQ0lfUVVJUksoMHgx
MDNjLCAweDhmNDIsICJIUCBaQm9vayA4IEcyYSAxNFciLCBBTEMyNDVfRklYVVBfSFBfVEFTMjc4
MV9JMkNfTVVURV9MRUQpLAotLSAKMi40My4wCgo=
--_002_MW4PR84MB15161B06885B6F2E884BBBC98D88AMW4PR84MB1516NAMP_--


