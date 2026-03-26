Return-Path: <stable+bounces-230483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNBdKTBNxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:13:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F4337556
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53AFE30C4DD6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B43FF8AF;
	Thu, 26 Mar 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="Em5wYp+8"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021082.outbound.protection.outlook.com [52.101.65.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9463976B8;
	Thu, 26 Mar 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537569; cv=fail; b=E24dgKCAf/BP6/N/6aFEhCfSO1djPFBLf4cIWjjuQS00B6s4kwnuRxlSm8H9ybPdLYn8sLvi41sKejGhr+KILYe6vJRCS6GqHywZevMold/j2sSmnpztVmxYu9l5OvKuBhvYpV3SgZT215KzRaYKXso+f16DRcQhmhVz9AD9BQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537569; c=relaxed/simple;
	bh=z9CmOsCLzSTyVXQzgTUhTyW3BXjeXYB2Rl3KH0Sz22o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QPOUh6f77IMuwQ5k9NXygNE7Qnr8IMi51rNcaRXOywhj8/mQVaAA2nkMaP7/e6L9g5ykXN+Bd1uW6FKm39MF1DZ8jzCjeJXni6k4UfTNdOfdFhwZ7YgJDTHFxTj8C9ttLpUiDHRygF1WTbTkUBhFatHeOlz3zkJmvRtX0bGOAaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=Em5wYp+8; arc=fail smtp.client-ip=52.101.65.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH5RAZNZ8yb+LgFXuYc/U8nO2t6Sojgb/Gq4GEEUHbPA3nN7mGW/88mbvC52sbNrW48tOIVRuwpiLwTTThoqwYC2KVwDZ7m8CSnPLORvjsFawU/BFmImZFD82GhlmtyRSXjLFCNvoVTZRRBM8BDIdoJrEdWJv2QTmK6hGRaXfUQmPoMpHXqU1gzO78LcoI2qwrW1ZQ7oK4guLNR3JIlHunYX015xJKUWRgL8rjhrQnQavqcCS0Ujt2QJyWIZgCpxi67ROuIokBGO4kMu7NEvSarWiO0wPdYUb18gTDxaY5rUfRQR/boLzbyreQvAznzAv4kHbLJpF5VV1BrYh7lcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9CmOsCLzSTyVXQzgTUhTyW3BXjeXYB2Rl3KH0Sz22o=;
 b=QqjNqXiMYCtLqsdwC6Idj63JWUtfR+Mj3+W2VivAiit1IcGusIhoetyEczzrQmCE4UXHUazfQJDWusZzi09hi/bx/U6ZC2y34srI2tzD/oYBm/yKkVbatXYTbE0QWh6HxFAM4VZFZaeO8e5ZrqUJ2faVR1NAypp190Cd2qRin16go7oL3NRaGSOJp8VXsl0lVjL9dpxAErjoKVIKRzvfe4U+Z/JgMzVAGsaggP5xh9ISlYGv/E+Txit+JIF91uTi42C/wHMuRLgBGnQdkAjklpYZ1z17GDQpd1UyuIcVszbEWn/StwbKeQRNPaJtpclo8rV2vlnvqmTeC75FLuPLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9CmOsCLzSTyVXQzgTUhTyW3BXjeXYB2Rl3KH0Sz22o=;
 b=Em5wYp+8caR+5OAHs3DKIst9ajhJ/ASw8UbKi9BmjG6Iai/bEo3ghbKSmuCIlthiJbq9KpLsaLNkLZA6QdcC5m5RDx8Os1CICIpx+KPsOID2m8+7ZJaEEKH6nf7Dqo7nV2JHDKysB2fcfScfw2PXDHu1NzNl5PpK9gk3ntp+DCW+0ULlB0qqpmu0SlX4UvyeAkxbMxruujIgira4gSp8laGmeFJcuG/xNJkipOT6f/GARMsNjocBEImy50RmafyB+TGJDNRESaBjaioZHBdIdoEjSpJUSzIthKrKp+RjsK2/WCyeDpuB9l1uM2ocE5SIxldZSDdbgurFpMO+w7IaLA==
Received: from PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20)
 by DU4PR04MB12131.eurprd04.prod.outlook.com (2603:10a6:10:642::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 15:06:03 +0000
Received: from PA4PR04MB7679.eurprd04.prod.outlook.com
 ([fe80::7e8:b5fc:9762:7a6d]) by PA4PR04MB7679.eurprd04.prod.outlook.com
 ([fe80::7e8:b5fc:9762:7a6d%5]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 15:06:03 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v5] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Thread-Topic: [PATCH v5] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Thread-Index: AQHcvTIQQjLu32jq2kSvRD5j2rlHlA==
Date: Thu, 26 Mar 2026 15:06:03 +0000
Message-ID: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7679:EE_|DU4PR04MB12131:EE_
x-ms-office365-filtering-correlation-id: cead5286-e73e-4673-2257-08de8b4932ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|7055299006|56012099003;
x-microsoft-antispam-message-info:
 GS1ureHRgw6YX7h2l8X4AE857ctQV4GXX1bXDb7rOrktjTTQUpH6OhQqovR9fWz3xK9X6QKX3xIRUIRj449h87LN/ndozJshT9ZNUsLnzVmvHEp/lf0E1eQpNJyNtvkmokNWW0O90fqLvzkk2seRoLv2/F4wT6jooCoTbsd9610mvI5uwrVKMhhj1PSqGx5gGC+eQ662TKLHZjcVIFoIim0PeS4wQkDRjUIowZQuf7+HcZqKXG8FVtgVmtdE7yLN0MZWLxYfPGkMr5TeUu68RSXX/EI/kv++6NryGNbljQwyqygaiAEvfGgbfJiYdtY3I8XoCOtDrrNroS7fMMUJIOYq2p5wDZ8m5PFl83X0w+lxcs46CBdQ6cQporRPRt2Ri23echC9WUpVdAEqaN+6chn4pixs6t3TFrdm3WUlUXKAsAI71eXLX29cuodGQra0CQeddv35+CLysmEpYkhdU8uEPZRj7uYsIgsUW5UeHvd/Q1CTnuraESIyiYuuUZFdgANtg6Cygtwc7z8pAGk6Zj1kWK5tQWgJi9PFX+8bFH09x5IntkkNw2pzFfgcOf4K/V9Db85j78Tp18BUffYgA0sTSh9uyJyE35FwwUvWgaqT1rsHF74Lwj65tvY7GzDUH484X1w5d+F40/vwP5ce5Lye14IVrGiTWBmXoUlfk9Y2/aCX0V4CES2YcwxdUY05R8plNzuaBOT6HpLs4u+ABM7cI3RBPib+jjLmwih1A8ex30KSsMchUyw/wh9MUr+W3FKcn3iFy1urtpiY0to+q7+/pf5tuhItaH/BPBJrmdCxyad8r4YE8L35CaJMiltD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7679.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(7055299006)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk9mK3kyTksybHNLQTFNcVRDRytGS0NGV1FhdVpuSk1ISVRyOU9YN1k5UThL?=
 =?utf-8?B?eFV5aGdkVmcxYjBoOGxhUDZKODVhdnZYYWJ4bUhGSHZjMXM3ZkpyWVJpWFNs?=
 =?utf-8?B?YnNKd011OXdJUWI1Q0VpVldyYTloS0pwTGlzdmlIQ3BJWlFKZHVTZGgrbTVP?=
 =?utf-8?B?WnFuN2Q5VTFINlN4NDRsYXBNVThQR0hPUU82Y2tOVnNZK0ZPUEdUTWhJaVNo?=
 =?utf-8?B?ZWJuQlJRamsxUEJWMUV0RG9OZ1VKam8vV3dtUGV6M0dZYjBkWVRXaEZUb2Jj?=
 =?utf-8?B?TWdHWjRpYVh3dnNuRUVBeEdLVE1hQzgweGFDVXg0djZqelJnTXRab1pnLzEy?=
 =?utf-8?B?am12TnNPWUE5MkFZSjc5TTJxblV1aFQ2UEJpRGhBTnZPcVZDMVJNV29jM3Vi?=
 =?utf-8?B?cmRLcjQ4UE9DMjdXOVE0aTBRTU5Wbkdnc0cvTUdsN05IcGQrOWx3SStNaEUy?=
 =?utf-8?B?WGJxVS9hMDhSTHhQNFVNcU4vejQ4MjJndFh2MWR2Q0NsdTkzU0JmUGxKZzFa?=
 =?utf-8?B?MWptd3lhSXRlS1dtTUlWTzZtRS82Q2Y3N1hYTGlCM2MzamMxN0xsNXRxRHVK?=
 =?utf-8?B?SFJaSDU0QUFCcHA0OVFDM0FpZjdWeWVjSEQyNGRQSjJuY1krMTNkcWJ6cDFK?=
 =?utf-8?B?UFYxb0xzQjlXMjNYdTE2OEEybldJN1NaeG5ZQkdiOXZpUUhFL0dsUkpJeVpY?=
 =?utf-8?B?WlN2YjZKWHBZeHRhbGREY1pBdjZrRVloK0o3Z2RGbnV6UXdYVVc0TEptOExX?=
 =?utf-8?B?TnVYTnNROWM4dTlDdmV5MGdRbnc1bUJqcUhqaVBpRUJBT2ZldU51emZzY2N3?=
 =?utf-8?B?V2poNGJrUndtVlVnR0ZiMVhKRzc0c094WHI2eUxzMFZiR05mdi9NOXEwczNS?=
 =?utf-8?B?TVJpQmtpRzRPUmQ0VnNWL2JVeWxyellrcjFLRU5OYkpSWnZZWDlDejd5Tksv?=
 =?utf-8?B?Z1A3ZHpZNC9ZMGIzS2FyNlZ4L0VQdTcvQmp6bE8vVVdyQjI2MVdubVhJUVl2?=
 =?utf-8?B?V2xKMzNCTmRqTm9VZ2tUS2dyOEZseFd1UFd4NHJ5MXJOV29WQmIyOTNzbGtq?=
 =?utf-8?B?cW5GVkQyd1hqaCtWZW9uYkl2UlNwam1GaWN6aGU4akJWZ1N3ZTh4eU1lRlhR?=
 =?utf-8?B?NS9NSTE4bnZVR2NiVWlWUFJYTTU3TzdTWm9hZVd4V2gxSGtTYjVYZ3NyTnZX?=
 =?utf-8?B?Ymt6UzlSSEljaGFrWUFHR0o3OFd6U2FqMnZIQ09lYXp2TWNNQ1dHTFNpWkJl?=
 =?utf-8?B?QlR3UU91Tm1pQ3pCWkEyNHFWbGE0Qy9iMkZxdGhPVVVBbGlxMUFkSWlSdHh1?=
 =?utf-8?B?aFhENEprYm41T2xLQW1zbmFWcDVaa3NuakJ1Q3MxRm5Xcjl1SWJ3UW1wTC9B?=
 =?utf-8?B?V1h0WTR5TU1LVjcxSzZPRzZ3THlaWEw5bVo5ejhRY2FnZzJDcEhKdTg0U3VG?=
 =?utf-8?B?UHRsbjNLWTRpTVdzL2xmVWIyb2dvbWdyZnlGSk1NOU51eUZGNDZLRmVjTUow?=
 =?utf-8?B?NVQvd2VkL2RQV0F5UmgvNDV5MWswb0x0alFJbk9jcVpYbWg1MkwzdnQwalhm?=
 =?utf-8?B?QXlaSEhSVTJyVUFJbWdvZ3RCSFdaQ3dkUmJFWWg1M3NCbHp3aTFFeTQ3N0ht?=
 =?utf-8?B?MS8vTWZDendwTEpubEltVWd5ZDNlVU1lQ1lPeXVaTUU2S3VGR0o5VW5HRmZZ?=
 =?utf-8?B?OFFDaFlOdFY5R3U3TTdSVk5DeERGN000dTR1Vzh6bnZYVE9ZaHl5d05VcW4v?=
 =?utf-8?B?a3U5aDNpR2ROOFVaVGN3M2RpWFFOcmNTd3pQSUhnM0tLWUozWERBUUZxeS9K?=
 =?utf-8?B?KzRsRTZKL0M3akpicW1wb1hBTkJjQmF6Yzc3ZENYNWhEemVkczlwclRnUUow?=
 =?utf-8?B?M0V5czNiYUZnWUFTcGlCY2tYUlpYRzZ2UXN2QzQvRFFFSkRiRFp3TklSUWww?=
 =?utf-8?B?TW80RnZNamV4cDZJMnZEVWx3eExxVk03ajZOUmJGVGNzV1hMZ1FueWc2OE5k?=
 =?utf-8?B?dkFzb29Qbnk2ZjRCK2cveFl2R1A3MFhJcTQzRUtOeVVhMEh3Q3Z2d1ZKbGZ4?=
 =?utf-8?B?ODhucWlxUGQvdEJ3VGlBN0hrSThabmpBb2JoOXZTcG1lUjNLQ0MzZjJxQnA5?=
 =?utf-8?B?UmFrTzA0MmpiOGRPb1dMTU54K2RLN05wd21OK0tZbzlzNjRHWFJSeXpkbWdV?=
 =?utf-8?B?Mk1UbWpwR2UxUGJXYlpSK3hyenRxMU5ldUpTSlc3YkIvaC9GOXhwUDdZT2NQ?=
 =?utf-8?B?ZGE5SEZLQllMWjh0ZDdXdzV1b0FhekF6M1JzdVJlQS9GTXpIa2Z3cldTL1hl?=
 =?utf-8?Q?fQjH8ciVHCPC5KweEZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B34F7F85905634998E20EAAD308E599@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cead5286-e73e-4673-2257-08de8b4932ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 15:06:03.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FWWU/1nIMnURdgTk7H8e6665GmDy4QkV7WfNem2nYIaACkJwvwrl1TWFEbQjLW162UQeaeQglFyaiLGgesGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12131
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[1seal.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[1seal.org:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230483-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[1seal.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1.0.0.127.in-addr.arpa:mid,1seal.org:dkim,1seal.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D5F4337556
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
cyBhIHdha2UgYWRkcmVzcy4KCkFubm90YXRlIHRoZSBoZWxwZXIgd2l0aCBfX211c3RfaG9sZCgm
aGRldi0+bG9jaykgYW5kIGFkZApsb2NrZGVwX2Fzc2VydF9oZWxkKCZoZGV2LT5sb2NrKSBzbyBm
dXR1cmUgY2FsbCBwYXRocyBrZWVwIHRoZSBsb2NrCmNvbnRyYWN0IGV4cGxpY2l0LgoKQ2FsbCB0
aGUgaGVscGVyIGZyb20gaGNpX2Nvbm5fcmVxdWVzdF9ldnQoKSwgaGNpX2Nvbm5fY29tcGxldGVf
ZXZ0KCksCmhjaV9sZV9hZHZfcmVwb3J0X2V2dCgpLCBoY2lfbGVfZXh0X2Fkdl9yZXBvcnRfZXZ0
KCksIGFuZApoY2lfbGVfZGlyZWN0X2Fkdl9yZXBvcnRfZXZ0KCkuCgpGaXhlczogMmYyMDIxNmMx
ZDZmICgiQmx1ZXRvb3RoOiBFbWl0IGNvbnRyb2xsZXIgc3VzcGVuZCBhbmQgcmVzdW1lIGV2ZW50
cyIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IE9sZWggS29ua28g
PHNlY3VyaXR5QDFzZWFsLm9yZz4KLS0tCnY1OgotIGFkZCBfX211c3RfaG9sZCgmaGRldi0+bG9j
aykgYW5kIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJmhkZXYtPmxvY2spCgogbmV0L2JsdWV0b290aC9o
Y2lfZXZlbnQuYyB8IDkwICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDU5IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVu
dC5jCmluZGV4IDI4NjUyOWQyZTU1NC4uY2IyNzAzN2VlZWY1IDEwMDY0NAotLS0gYS9uZXQvYmx1
ZXRvb3RoL2hjaV9ldmVudC5jCisrKyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMKQEAgLTgw
LDYgKzgwLDEwIEBAIHN0YXRpYyB2b2lkICpoY2lfbGVfZXZfc2tiX3B1bGwoc3RydWN0IGhjaV9k
ZXYgKmhkZXYsIHN0cnVjdCBza19idWZmICpza2IsCiAJcmV0dXJuIGRhdGE7CiB9CiAKK3N0YXRp
YyB2b2lkIGhjaV9zdG9yZV93YWtlX3JlYXNvbihzdHJ1Y3QgaGNpX2RldiAqaGRldiwKKwkJCQkg
IGNvbnN0IGJkYWRkcl90ICpiZGFkZHIsIHU4IGFkZHJfdHlwZSkKKwlfX211c3RfaG9sZCgmaGRl
di0+bG9jayk7CisKIHN0YXRpYyB1OCBoY2lfY2NfaW5xdWlyeV9jYW5jZWwoc3RydWN0IGhjaV9k
ZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJCQkJc3RydWN0IHNrX2J1ZmYgKnNrYikKIHsKQEAgLTMx
MTEsNiArMzExNSw3IEBAIHN0YXRpYyB2b2lkIGhjaV9jb25uX2NvbXBsZXRlX2V2dChzdHJ1Y3Qg
aGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAlidF9kZXZfZGJnKGhkZXYsICJzdGF0dXMgMHgl
Mi4yeCIsIHN0YXR1cyk7CiAKIAloY2lfZGV2X2xvY2soaGRldik7CisJaGNpX3N0b3JlX3dha2Vf
cmVhc29uKGhkZXYsICZldi0+YmRhZGRyLCBCREFERFJfQlJFRFIpOwogCiAJLyogQ2hlY2sgZm9y
IGV4aXN0aW5nIGNvbm5lY3Rpb246CiAJICoKQEAgLTMyNzQsNiArMzI3OSwxMCBAQCBzdGF0aWMg
dm9pZCBoY2lfY29ubl9yZXF1ZXN0X2V2dChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0
YSwKIAogCWJ0X2Rldl9kYmcoaGRldiwgImJkYWRkciAlcE1SIHR5cGUgMHgleCIsICZldi0+YmRh
ZGRyLCBldi0+bGlua190eXBlKTsKIAorCWhjaV9kZXZfbG9jayhoZGV2KTsKKwloY2lfc3RvcmVf
d2FrZV9yZWFzb24oaGRldiwgJmV2LT5iZGFkZHIsIEJEQUREUl9CUkVEUik7CisJaGNpX2Rldl91
bmxvY2soaGRldik7CisKIAkvKiBSZWplY3QgaW5jb21pbmcgY29ubmVjdGlvbiBmcm9tIGRldmlj
ZSB3aXRoIHNhbWUgQkQgQUREUiBhZ2FpbnN0CiAJICogQ1ZFLTIwMjAtMjY1NTUKIAkgKi8KQEAg
LTY0MDMsNiArNjQxMiw4IEBAIHN0YXRpYyB2b2lkIGhjaV9sZV9hZHZfcmVwb3J0X2V2dChzdHJ1
Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAkJCQkJaW5mby0+bGVuZ3RoICsgMSkpCiAJ
CQlicmVhazsKIAorCQloY2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmluZm8tPmJkYWRkciwg
aW5mby0+YmRhZGRyX3R5cGUpOworCiAJCWlmIChpbmZvLT5sZW5ndGggPD0gbWF4X2Fkdl9sZW4o
aGRldikpIHsKIAkJCXJzc2kgPSBpbmZvLT5kYXRhW2luZm8tPmxlbmd0aF07CiAJCQlwcm9jZXNz
X2Fkdl9yZXBvcnQoaGRldiwgaW5mby0+dHlwZSwgJmluZm8tPmJkYWRkciwKQEAgLTY0OTEsNiAr
NjUwMiw4IEBAIHN0YXRpYyB2b2lkIGhjaV9sZV9leHRfYWR2X3JlcG9ydF9ldnQoc3RydWN0IGhj
aV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJCQkJCWluZm8tPmxlbmd0aCkpCiAJCQlicmVhazsK
IAorCQloY2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmluZm8tPmJkYWRkciwgaW5mby0+YmRh
ZGRyX3R5cGUpOworCiAJCWV2dF90eXBlID0gX19sZTE2X3RvX2NwdShpbmZvLT50eXBlKSAmIExF
X0VYVF9BRFZfRVZUX1RZUEVfTUFTSzsKIAkJbGVnYWN5X2V2dF90eXBlID0gZXh0X2V2dF90eXBl
X3RvX2xlZ2FjeShoZGV2LCBldnRfdHlwZSk7CiAKQEAgLTY4MzQsNiArNjg0Nyw4IEBAIHN0YXRp
YyB2b2lkIGhjaV9sZV9kaXJlY3RfYWR2X3JlcG9ydF9ldnQoc3RydWN0IGhjaV9kZXYgKmhkZXYs
IHZvaWQgKmRhdGEsCiAJZm9yIChpID0gMDsgaSA8IGV2LT5udW07IGkrKykgewogCQlzdHJ1Y3Qg
aGNpX2V2X2xlX2RpcmVjdF9hZHZfaW5mbyAqaW5mbyA9ICZldi0+aW5mb1tpXTsKIAorCQloY2lf
c3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmluZm8tPmJkYWRkciwgaW5mby0+YmRhZGRyX3R5cGUp
OworCiAJCXByb2Nlc3NfYWR2X3JlcG9ydChoZGV2LCBpbmZvLT50eXBlLCAmaW5mby0+YmRhZGRy
LAogCQkJCSAgIGluZm8tPmJkYWRkcl90eXBlLCAmaW5mby0+ZGlyZWN0X2FkZHIsCiAJCQkJICAg
aW5mby0+ZGlyZWN0X2FkZHJfdHlwZSwgSENJX0FEVl9QSFlfMU0sIDAsCkBAIC03NTE3LDczICs3
NTMyLDI5IEBAIHN0YXRpYyBib29sIGhjaV9nZXRfY21kX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2
ICpoZGV2LCB1MTYgb3Bjb2RlLAogCXJldHVybiB0cnVlOwogfQogCi1zdGF0aWMgdm9pZCBoY2lf
c3RvcmVfd2FrZV9yZWFzb24oc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IGV2ZW50LAotCQkJCSAg
c3RydWN0IHNrX2J1ZmYgKnNrYikKK3N0YXRpYyB2b2lkIGhjaV9zdG9yZV93YWtlX3JlYXNvbihz
dHJ1Y3QgaGNpX2RldiAqaGRldiwKKwkJCQkgIGNvbnN0IGJkYWRkcl90ICpiZGFkZHIsIHU4IGFk
ZHJfdHlwZSkKKwlfX211c3RfaG9sZCgmaGRldi0+bG9jaykKIHsKLQlzdHJ1Y3QgaGNpX2V2X2xl
X2FkdmVydGlzaW5nX2luZm8gKmFkdjsKLQlzdHJ1Y3QgaGNpX2V2X2xlX2RpcmVjdF9hZHZfaW5m
byAqZGlyZWN0X2FkdjsKLQlzdHJ1Y3QgaGNpX2V2X2xlX2V4dF9hZHZfaW5mbyAqZXh0X2FkdjsK
LQljb25zdCBzdHJ1Y3QgaGNpX2V2X2Nvbm5fY29tcGxldGUgKmNvbm5fY29tcGxldGUgPSAodm9p
ZCAqKXNrYi0+ZGF0YTsKLQljb25zdCBzdHJ1Y3QgaGNpX2V2X2Nvbm5fcmVxdWVzdCAqY29ubl9y
ZXF1ZXN0ID0gKHZvaWQgKilza2ItPmRhdGE7Ci0KLQloY2lfZGV2X2xvY2soaGRldik7CisJbG9j
a2RlcF9hc3NlcnRfaGVsZCgmaGRldi0+bG9jayk7CiAKIAkvKiBJZiB3ZSBhcmUgY3VycmVudGx5
IHN1c3BlbmRlZCBhbmQgdGhpcyBpcyB0aGUgZmlyc3QgQlQgZXZlbnQgc2VlbiwKIAkgKiBzYXZl
IHRoZSB3YWtlIHJlYXNvbiBhc3NvY2lhdGVkIHdpdGggdGhlIGV2ZW50LgogCSAqLwogCWlmICgh
aGRldi0+c3VzcGVuZGVkIHx8IGhkZXYtPndha2VfcmVhc29uKQotCQlnb3RvIHVubG9jazsKKwkJ
cmV0dXJuOworCisJaWYgKCFiZGFkZHIpIHsKKwkJaGRldi0+d2FrZV9yZWFzb24gPSBNR01UX1dB
S0VfUkVBU09OX1VORVhQRUNURUQ7CisJCXJldHVybjsKKwl9CiAKIAkvKiBEZWZhdWx0IHRvIHJl
bW90ZSB3YWtlLiBWYWx1ZXMgZm9yIHdha2VfcmVhc29uIGFyZSBkb2N1bWVudGVkIGluIHRoZQog
CSAqIEJsdWV6IG1nbXQgYXBpIGRvY3MuCiAJICovCiAJaGRldi0+d2FrZV9yZWFzb24gPSBNR01U
X1dBS0VfUkVBU09OX1JFTU9URV9XQUtFOwotCi0JLyogT25jZSBjb25maWd1cmVkIGZvciByZW1v
dGUgd2FrZXVwLCB3ZSBzaG91bGQgb25seSB3YWtlIHVwIGZvcgotCSAqIHJlY29ubmVjdGlvbnMu
IEl0J3MgdXNlZnVsIHRvIHNlZSB3aGljaCBkZXZpY2UgaXMgd2FraW5nIHVzIHVwIHNvCi0JICog
a2VlcCB0cmFjayBvZiB0aGUgYmRhZGRyIG9mIHRoZSBjb25uZWN0aW9uIGV2ZW50IHRoYXQgd29r
ZSB1cyB1cC4KLQkgKi8KLQlpZiAoZXZlbnQgPT0gSENJX0VWX0NPTk5fUkVRVUVTVCkgewotCQli
YWNweSgmaGRldi0+d2FrZV9hZGRyLCAmY29ubl9yZXF1ZXN0LT5iZGFkZHIpOwotCQloZGV2LT53
YWtlX2FkZHJfdHlwZSA9IEJEQUREUl9CUkVEUjsKLQl9IGVsc2UgaWYgKGV2ZW50ID09IEhDSV9F
Vl9DT05OX0NPTVBMRVRFKSB7Ci0JCWJhY3B5KCZoZGV2LT53YWtlX2FkZHIsICZjb25uX2NvbXBs
ZXRlLT5iZGFkZHIpOwotCQloZGV2LT53YWtlX2FkZHJfdHlwZSA9IEJEQUREUl9CUkVEUjsKLQl9
IGVsc2UgaWYgKGV2ZW50ID09IEhDSV9FVl9MRV9NRVRBKSB7Ci0JCXN0cnVjdCBoY2lfZXZfbGVf
bWV0YSAqbGVfZXYgPSAodm9pZCAqKXNrYi0+ZGF0YTsKLQkJdTggc3ViZXZlbnQgPSBsZV9ldi0+
c3ViZXZlbnQ7Ci0JCXU4ICpwdHIgPSAmc2tiLT5kYXRhW3NpemVvZigqbGVfZXYpXTsKLQkJdTgg
bnVtX3JlcG9ydHMgPSAqcHRyOwotCi0JCWlmICgoc3ViZXZlbnQgPT0gSENJX0VWX0xFX0FEVkVS
VElTSU5HX1JFUE9SVCB8fAotCQkgICAgIHN1YmV2ZW50ID09IEhDSV9FVl9MRV9ESVJFQ1RfQURW
X1JFUE9SVCB8fAotCQkgICAgIHN1YmV2ZW50ID09IEhDSV9FVl9MRV9FWFRfQURWX1JFUE9SVCkg
JiYKLQkJICAgIG51bV9yZXBvcnRzKSB7Ci0JCQlhZHYgPSAodm9pZCAqKShwdHIgKyAxKTsKLQkJ
CWRpcmVjdF9hZHYgPSAodm9pZCAqKShwdHIgKyAxKTsKLQkJCWV4dF9hZHYgPSAodm9pZCAqKShw
dHIgKyAxKTsKLQotCQkJc3dpdGNoIChzdWJldmVudCkgewotCQkJY2FzZSBIQ0lfRVZfTEVfQURW
RVJUSVNJTkdfUkVQT1JUOgotCQkJCWJhY3B5KCZoZGV2LT53YWtlX2FkZHIsICZhZHYtPmJkYWRk
cik7Ci0JCQkJaGRldi0+d2FrZV9hZGRyX3R5cGUgPSBhZHYtPmJkYWRkcl90eXBlOwotCQkJCWJy
ZWFrOwotCQkJY2FzZSBIQ0lfRVZfTEVfRElSRUNUX0FEVl9SRVBPUlQ6Ci0JCQkJYmFjcHkoJmhk
ZXYtPndha2VfYWRkciwgJmRpcmVjdF9hZHYtPmJkYWRkcik7Ci0JCQkJaGRldi0+d2FrZV9hZGRy
X3R5cGUgPSBkaXJlY3RfYWR2LT5iZGFkZHJfdHlwZTsKLQkJCQlicmVhazsKLQkJCWNhc2UgSENJ
X0VWX0xFX0VYVF9BRFZfUkVQT1JUOgotCQkJCWJhY3B5KCZoZGV2LT53YWtlX2FkZHIsICZleHRf
YWR2LT5iZGFkZHIpOwotCQkJCWhkZXYtPndha2VfYWRkcl90eXBlID0gZXh0X2Fkdi0+YmRhZGRy
X3R5cGU7Ci0JCQkJYnJlYWs7Ci0JCQl9Ci0JCX0KLQl9IGVsc2UgewotCQloZGV2LT53YWtlX3Jl
YXNvbiA9IE1HTVRfV0FLRV9SRUFTT05fVU5FWFBFQ1RFRDsKLQl9Ci0KLXVubG9jazoKLQloY2lf
ZGV2X3VubG9jayhoZGV2KTsKKwliYWNweSgmaGRldi0+d2FrZV9hZGRyLCBiZGFkZHIpOworCWhk
ZXYtPndha2VfYWRkcl90eXBlID0gYWRkcl90eXBlOwogfQogCiAjZGVmaW5lIEhDSV9FVl9WTChf
b3AsIF9mdW5jLCBfbWluX2xlbiwgX21heF9sZW4pIFwKQEAgLTc4MzAsMTQgKzc4MDEsMTUgQEAg
dm9pZCBoY2lfZXZlbnRfcGFja2V0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQogCiAJc2tiX3B1bGwoc2tiLCBIQ0lfRVZFTlRfSERSX1NJWkUpOwogCi0JLyogU3Rv
cmUgd2FrZSByZWFzb24gaWYgd2UncmUgc3VzcGVuZGVkICovCi0JaGNpX3N0b3JlX3dha2VfcmVh
c29uKGhkZXYsIGV2ZW50LCBza2IpOwotCiAJYnRfZGV2X2RiZyhoZGV2LCAiZXZlbnQgMHglMi4y
eCIsIGV2ZW50KTsKIAogCWhjaV9ldmVudF9mdW5jKGhkZXYsIGV2ZW50LCBza2IsICZvcGNvZGUs
ICZzdGF0dXMsICZyZXFfY29tcGxldGUsCiAJCSAgICAgICAmcmVxX2NvbXBsZXRlX3NrYik7CiAK
KwloY2lfZGV2X2xvY2soaGRldik7CisJaGNpX3N0b3JlX3dha2VfcmVhc29uKGhkZXYsIE5VTEws
IDApOworCWhjaV9kZXZfdW5sb2NrKGhkZXYpOworCiAJaWYgKHJlcV9jb21wbGV0ZSkgewogCQly
ZXFfY29tcGxldGUoaGRldiwgc3RhdHVzLCBvcGNvZGUpOwogCX0gZWxzZSBpZiAocmVxX2NvbXBs
ZXRlX3NrYikgewotLSAKMi41MC4wCgo=

