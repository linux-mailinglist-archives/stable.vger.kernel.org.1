Return-Path: <stable+bounces-244532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLDGNtNN/GlOOAAAu9opvQ
	(envelope-from <stable+bounces-244532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:31:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1E4E4D4E
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D33A0300AC99
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1634A76E;
	Thu,  7 May 2026 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZA4N5KJE"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023097.outbound.protection.outlook.com [40.107.162.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B84388E6A;
	Thu,  7 May 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142338; cv=fail; b=jYGObF8P2eMEqPwb/YSjGTQwcRyXjT7bTjvgSy/JP+Y7/N2hC9dI9sgur+Gfzz5jz2UXr3AFdvSmUGVedeBQ7V4Ry4tgb1tqt+/B2lwrcEXmewTL3tW41yT63lHur4SR82w6PnEAAGE9Xd9bxLg6VVg6BBQVQNXclJ7aATgf7Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142338; c=relaxed/simple;
	bh=aP9t5yx93zUAZryF6l5asA1INJ8scw16ervFBDLc+vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EX8GQsWKviN59gqS+eDspaIIRO1e+CxjgJ3X9R8a2KZxSLI25Wm8KRVlREpjcw2S4uOI0LhFTiV9s/z9lXxmUu/sTdNV/xevNK2XcQGtgXPxkg/ljK0nX31EKpoZ8p1kV/oRjWj4zPNhjU178YBmEGnlqyj3cl928i+pEG/Ctyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZA4N5KJE; arc=fail smtp.client-ip=40.107.162.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOYBgFH/RiqZfTNDW2EnL5o9KUmOurF/sMTAJ4v2/Ypn8FeQWUA+1ZiLd4mH2HduGUXVDS6b7NDIErUadVo5Ji0yYwbuQ7Vv3vztDUaeHDh5l8RC96oZwFRqBSRWcAsdKYMHmz2uWjbrVIWUPDbfcilG04hwkubaHX9dZr8fWdABflz5vlDHkRbHR868TXqj7W5B/+vZi2plQMlwMy9BZ2xXKzy4yGQKJphP4gNGQBEPcK97OmIV/pKKeFGQC37G+ssLx+JTcPi41IZJk6gA+xaENi1Om8d7Uc8g6nMNTnPXubv9dysHZpjkKSK2xII5QCsfqAcv84gIlybmuatnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5enEFJRtE878pWt0gQJ+BbdNdbU4zjKVb852buTicnQ=;
 b=ZPFZlogPBf0zEZyAAeAXjJgY1jcAqErqrzSk03K66G8qTIeaJ9Ilms251mc0242HiY5SGuAEmZEfWQla7NE3hKmOUs409u9BsIb8hRs8cNHmbrSmH8C9skaLQwJUKmMXlrjONxZrC175dTztAXaIvz3p84vNb4oVmHYbSogGhIdKzus5sMgYoUQVcmMM5uju0lLGXIrGYH6eDPj+UhBZPkqEJ8j+zb0mzHp/nDVNtY6r4gbNGYr2c3Y9xnmb8wTuxrlE4YK/CEUpywrgeK6z2JrDpduY26HTPYhAV7eWPKsSP5TgH5F2ORCxY1KoVjzFj+acVCMJGeu8f2Bi2aspbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5enEFJRtE878pWt0gQJ+BbdNdbU4zjKVb852buTicnQ=;
 b=ZA4N5KJE46NhlQd5a3NlCDZog10AIjYen8CBhjNATa/aPc32qixrDlV1C2uGNQwVTxHEmwzetj8mswaIiRXI6PNnH/b7VNJCSObAXDse3ziJzICj0ZFhye5Jm791bkmbqQnahswxmCLsXba35iDcX4euvi+ke+YNTMBawsAP+kyXxRQyPdjkfKyA2dqWmrfgaGRXBbborUDPnBHixu3K9/KbVy8O9SPOXQZLSX0hvUVe9j2agboQAwenzt9irivKq375Fnw0yZS1/+G03w1CET2MEUyIOlqtdD11Vgm75AGwd1hmBmgKQIPcDXHybOyT9ByBmt3Z4Vm5LUdTCxZLEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by VI1P195MB0511.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:157::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 08:25:25 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 08:25:24 +0000
Message-ID: <d0eb7931-bcbc-4ca6-8ab5-4c12d134545a@phytec.de>
Date: Thu, 7 May 2026 11:25:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] arm64: dts: ti: k3-am642-phyboard-electra-rdk:
 fix USB clocking for compliance
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 josua@solid-run.com, matthias.schiffer@ew.tq-group.com, d.haller@phytec.de,
 francesco.dolcini@toradex.com, joao.goncalves@toradex.com,
 emanuele.ghidoli@toradex.com, ernest.vanhoecke@toradex.com,
 rogerq@kernel.org, eballetb@redhat.com, robertcnelson@gmail.com, afd@ti.com,
 u-kumar1@ti.com
Cc: stable@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 luis.parga@ti.com, srk@ti.com
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
 <20260506141040.1368918-3-s-vadapalli@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260506141040.1368918-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0139.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::23) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|VI1P195MB0511:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d88632-4534-4758-9a1c-08deac122fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jwbUz/ezEPTS8jQR6XeEt4XvM6AjptPxe3tpeOg8ZoUplBVR9xGo8KIZJ3CtsIXaflnck8Rqj+M2K3IY7JEEZNOxggzpEPmlOCD0/i3yDhsFL7VohixBy+9joYmr1Sf5Ublw5PTlUSsdof7PWtVXp876QSY4S7TFnxm/Cdcuh3QnnLPLuPxNSKhXMup8O2yGfChMS0YwraSvA72xtXW/b0VdCII9dvzb+9xY0AkyQdF3gIxS0cZSH9GG178mDxsf/Qg6ESBliu+eXfdR3sJpXXgJw3ZQP8xwsVcASN+g3A7XQwC4L39od7zMur3+tnNBtHE//B5rh1/dEpCIMsrOdpDAyBnI5D+GmIRLlH+rcs8/mFvivIqJBLQCqHg0wtgAtSCY0KQgsr2qAmIQxRxT4pRPZolqbGlGq3elQ8Yfl3rWmMf++mS95qvEeZbQoM7uz5zbMDRfoULAQaodg4G+LoW17YedgpZ/Onjjc7WK/5dcXjimz2sgpFK/itMjexRniJq707LehgaZOBgeU2eA3riH2BwXmfj1Eph8xOex9pfshGpNxT9oPPmvzqF32uGxBS0yg2J8bmCcEj5saZiz3J1o44M0+CUD1klG25/CKaTRxbeJmJCX8nd7USI6rkietuklh2MGxDRN4ldJF5ntsVCbHPMMPThS0NynOvyNl+T/++KWbDj988Z0W0WYa52WAS3UjQfwqRTuXfSL3i68rhmLvzeKZT5h21wkOqZVkFtMXj8sUO41balZCFJ9tehn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2hjWnppV0FXNWVhMlJXNXJCa24xU1hWNHBqN0tyOEY5RFhMeVo3SDducjN2?=
 =?utf-8?B?eERZN0ZBSnhMWkc1Y01rcVJwbkpLTTBEKzFTVTNReTcwWmkxWjdrRVEyQXAw?=
 =?utf-8?B?QmZQTGg3WmhrZGljY0ZGcmtqSmlrek9XeUNlK3UwZ1ozQ0U5STBPNEwzeTIv?=
 =?utf-8?B?MU50UnJ1WEJxTHNQU0FKZ1BjUzZTRllWSjc4T3EwY0h1aU81eXRPM2JYcnFJ?=
 =?utf-8?B?ZFoyY2Q5Smh6SjFxRHRIbk1iUlhGOVA1VG1UVkVvVHl2SjJWd1BuOHgxd25G?=
 =?utf-8?B?TkJmWnF2b3lZekJSaGt3M0hEbDFhWDhkUDRKbXphbWUwYXYvV2hCQkMwQ2Jr?=
 =?utf-8?B?MEdtRUVXOU52VVRQcTgrSXlwT1NGc1ozWnhHUlVyNVhVbnZMNVJTOVFDQ1Fx?=
 =?utf-8?B?b1NrZHJPUVZPcklzd0lDUHUrSDNDNDlXQmdtTnhjbXZVbUFtVGVZL0p5V3p0?=
 =?utf-8?B?YzU2SDFLTFZ4Vy9XOFR1RVZ1YS91eVBXQmFpbU9WZTRKREE1QVlBZlp6N0pI?=
 =?utf-8?B?MG9qQk1lT2ZsSkRmc01IUUl4LzBjSU83M1hEYXRqWW1Bem42UzFiZW1yRkNk?=
 =?utf-8?B?dXNySFZDeVdlbjBUaHloRklDU05BRVVNdVpYQlFSenpkZitET1FkYkZJcTB5?=
 =?utf-8?B?WVdDSnpUOUhUdTNQdXhzbW9NTFZ4Um5hTWlPUkI5Nk5aOU9vd3pnUXptdTBT?=
 =?utf-8?B?YWRueVgxbWVYVXAxZVdibHRwMWxPUk9JMDJYRlhNaDh2NzBYWUtMdFUrY0pI?=
 =?utf-8?B?MU8raWZ4SFpJb2F6Q2hVY2pNZGtqRkkwUVNwbFg2cGVvTXVWVFNwRnFVbUxj?=
 =?utf-8?B?YVJCdnJZMmdyMlpiWlRHbXB4bi9qZG5HS2tDZGRRYXY1OFcwaDdDaUhsVzZu?=
 =?utf-8?B?TVp0Mk1oYnR1T0RRV09scGpzVFVMdGZPdzZid3haT2ZBNDBLR0dzZjFqV1N1?=
 =?utf-8?B?aEJ2bHEraW5ReWxqSitLSUFJQ0lvVEhiejJxcnZBcnFjcHlnd0p0VnJmMTBx?=
 =?utf-8?B?N1BmcTRWT05CQmgwcWNkb2lqMFZYZE5qSmFlaWZxa00wUUdkQjRqTUFpMXpG?=
 =?utf-8?B?cmo2NFdFamJOVFE0NmRWVm9rc0sra29DRzAzOUsrOTdjRUpJUUdtaEsxRE4z?=
 =?utf-8?B?VmJ0aGdvOWRGd1lreHFKUnlESzJQZDBVZ2RrdDlyQTJJcDAwSWQ2SGxFbWFF?=
 =?utf-8?B?VHVmekdxWCtvcjI1SkozL3RDeWV3UDE3UUszbzVrVjhWUDQzMG9QZCtzZ0Zh?=
 =?utf-8?B?K3VoYUt2d3FUWEJzTUwzRnhmMEFGVFlIUVd3WHhXUmdUWmJnaVZacFFKaXU2?=
 =?utf-8?B?OTBXcWtuak9ONFlRQW1CL0RVdzZuRzhDNWJlUDJBUVNRYXZXVWhUeWwybFUw?=
 =?utf-8?B?cUg5YkVkUzVGaTkyT25pVStsY3BFcDU0TzJ4czBSWW1TeXcyejVsazQ0TTJp?=
 =?utf-8?B?c1ZVTE1zdGk2dnhhZWw3TUs3ZFVsbkRYckhwaFNyZ1FSZGRUYVNzZklkWm1l?=
 =?utf-8?B?SXVCT3ZuQXZaWHdZZmFLVERKbmplRURFV0wzZ3NuV3MwVnVjS3FRRmpaYjdO?=
 =?utf-8?B?K2VEK0k3SnF5RXZrUUhOcFJrbXVXT1VLZVZCeFkxMmtCdE10c0lBRFgreE1a?=
 =?utf-8?B?Z3FhZWhtaGhHbHNuL0laeFhoQ0pzZGs3WFhtM2pGYS9rNkxQaUdKUHcyZ0ZJ?=
 =?utf-8?B?d056K1dWUlc2dWxPM2tqTTBHZXE0SnM4dlJNNjVGdTl2ZlRxQWtkZDhwUnJi?=
 =?utf-8?B?b3NXNVNsdGtjVjJESWF1aFBudTN4dGhuWGRuTytkQU03Y1lBUTIreis2Mmg2?=
 =?utf-8?B?ZUxHKytINnFjdTNFcXMrcHZkazRITFJsT3pOWTQ4UC81Ny91MEtMbHJ6b250?=
 =?utf-8?B?VHVYUWgxWkNZcWdYbWpkbHZaWjY0ZzdsMTB0ZDc5L3Jzckk2NERnckp3czMy?=
 =?utf-8?B?WWcwU2VpSjN0VzJmZFVWOWVmRFdSVURPbzVISHBTZkYxWmdPVXo2bWdSdm5U?=
 =?utf-8?B?Z05Gc2pPeFRoTGMwU0JMNWxXK0FTa1dXbjFyOXJiTGJnay94ODZrb2xFblFK?=
 =?utf-8?B?STlUQlU2aDFyMFRSMkZHSEorbm96NWQ5QjQrYjVpYndYakNlY3F2bGdTUG9E?=
 =?utf-8?B?eVVQK3NtRXVab2FvaE92UlVqY3B0VUhrT01sWWpNMXZVOGVnTWVWZFprUHg0?=
 =?utf-8?B?MTZ5TUM1YnZEdGk0cTBpVEFBRFRuREcrTVF4amhFMVdLNnhMb1NEZ0E5Zkd2?=
 =?utf-8?B?bHRIRTFPQWg0Y1B3WUdYSDRyeGZ6RHBacjJqRE41ak9JVUwrL1E3WjA4VFZr?=
 =?utf-8?B?Zmx5ZUlVUmg4OSt4cHJJS25OYTlxSzBzbldubkNWTHF6TkVFZmhmQT09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d88632-4534-4758-9a1c-08deac122fd3
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:25:24.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0QeQ+XoCnwYscF2TF8hksKadpRCqcUhqtiGgYRwqCBtENVPiDLgsoXRFMLVxbGQxqPv+RLJvYyOjf2z3RkZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0511
X-Rspamd-Queue-Id: 9CA1E4E4D4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244532-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,ew.tq-group.com,phytec.de,toradex.com,redhat.com,gmail.com];
	GREYLIST(0.00)[pass,body];
	R_DKIM_ALLOW(0.00)[phytec.de:s=selector2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[phytec.de,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w.egorov@phytec.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[phytec.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_SPAM(0.00)[0.745];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi,

On 5/6/26 5:09 PM, Siddharth Vadapalli wrote:
> According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
> the USB 3.2 Specification, SSC should be enabled by default. This protects
> against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
> 
> Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v1:
> https://lore.kernel.org/r/20260505110631.1144200-3-s-vadapalli@ti.com/
> No changes since v1.
> 
>  arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 793538f94942..a85d7d08bd1b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -439,12 +439,21 @@ &sdhci1 {
>  	status = "okay";
>  };
>  
> +&serdes_wiz0 {
> +	ti,core-clk-sel = <1>;  /* Select internal reference clock */
> +	ti,ssc-enable; /* Enable SSC */
> +	ti,ssc-type = <1>; /* 1 for Downspread */
> +	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
> +	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */

I don't think the comments are very helpful. The property names already give a meaning.

Regards,
Wadim

> +};
> +
>  &serdes0 {
>  	serdes0_pcie_usb_link: phy@0 {
>  		reg = <0>;
>  		cdns,num-lanes = <1>;
>  		#phy-cells = <0>;
>  		cdns,phy-type = <PHY_TYPE_USB3>;
> +		cdns,ssc-mode = <2>; /* 2 for internal SSC */
>  		resets = <&serdes_wiz0 1>;
>  	};
>  };


