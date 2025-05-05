Return-Path: <stable+bounces-139676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD92AA9248
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB28D3B6998
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E170A1FDA6A;
	Mon,  5 May 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="Vnd48kbf"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21FEAC7;
	Mon,  5 May 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445730; cv=fail; b=WyKqTVgXhpvNu3MVeB1OcvBHlkXI5d2AAk5TzPlMaMqP9vu6BT/Kf++Pmx9q7QY8Sc1BC+V/joxVe80sVSqm4zpVfghkphUR1GxIlrfCtl/lIAyTbc75llTkJFqs/cOA1ousF5Oz375K8OFrvAf8Zb4FOmZm5bRb02loWNH8oIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445730; c=relaxed/simple;
	bh=z1w4TJe71LSR4od6vCxCxedWJhyTcbL+Inet2E3tvuY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A3bACMdCasdkN6ctIFXsNxg0DbBaKOjBxJV6lfNcd5PgduOA1DQIbE54iF31AbJ2Qgs313+SBsCCoS7P3QH5mVqTRVwWF7m512WaKwAvrKoLFWYentT9tGfJLFXSVII+Jf86i38090JrYvxAWfO+P3dzeL+2fKz8+GANR6p0m+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=Vnd48kbf; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1oaEyA1xPLDLEXuzP3ZZXfwKjzUSrxhEVmNv1pO64ETt+wG1uHcJW/ipmzXK+GdQi4LqurphACuAK2TYFuBx38ft5ETGwnIp0UCFGDk7H5v0j/gMnlPuN8QnA8FInmL9ilSj3AejIe+vHJ4n1fSdNKuugtJxJSAYgbApp8nJctRZW1KSw1C187lKxI98DLhiJuLj6nwwe5cjBq1eahW2ZIIfsAtQIqwZbU0hEPzhsL0Uddt/J/RVCw2Lze28XBA4//G/RloDpInYKkHULLREL8ioC1upIzvuBxcjC6hkYGVA1zIsjm+K6t/2dTw3aHp4m6/0IGU8Gz41A4Nw46p/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1w4TJe71LSR4od6vCxCxedWJhyTcbL+Inet2E3tvuY=;
 b=uS/y0A8lRwwljgH1ZHdmeYj1HZ0mocWsCTjGFczHq0XQA/Yi9jvDFlhT3SD1tAiLnNeVQpExRkeTDQldClIgNis+qKtVn+oCg/7Jilw+gkvTjBGh5uu0p25d2p0WOeNDTwqiKRlzqoZ9v22TMCjlGcnLwlTHC7J8kGQqFPX2qayxu/IPBtwSNCZcR/Lrir0/7bckkYFtdY21PgLCAQBtDVg8EEq2qrawaJp3Hvi7Dzz6Y/CHWDV3995T4BdosEfLijsdmRL69kT89hh8I5gGAg2xzRrrwcfXTNlj+KlfAw9msiUX76SdsZDQInrMPxtsiweHhrOmFc2ENNP2Efa9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1w4TJe71LSR4od6vCxCxedWJhyTcbL+Inet2E3tvuY=;
 b=Vnd48kbfGk/yODIKIrOiHydLwia8YZEfrKo33I2iAJpIxbt4WHCz4G4vAqGUcs2JWJM/KpeEb3WY1fbk3NhZyzUh+r88jnegMnLYyzDyZg1hRbRp6Pilyah9q7LPSMC1jaJsXrQqoxvRmRXLAEzW0InCeZS7Mb7eXd3Y6m02KzJTv7u5pdY2w27ZBOqaWWmEtAaoqwki1HB17rGga0kO3LD9ybTD4wu2u9urfKOXDHs9dqLY/1txDFUOY0fVpNhdrUI0vItt1daGIXF+Ss+MxaPUVnwrrbdpIfxMe5DRaUimuGfC8sQq+VEY9mCxI3T3uB2/8n1iZ8ybdTEg5/BLfA==
Received: from AM0PR07MB6196.eurprd07.prod.outlook.com (2603:10a6:208:ed::33)
 by AS8PR07MB7958.eurprd07.prod.outlook.com (2603:10a6:20b:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 11:48:45 +0000
Received: from AM0PR07MB6196.eurprd07.prod.outlook.com
 ([fe80::7cb7:ff63:d358:1a]) by AM0PR07MB6196.eurprd07.prod.outlook.com
 ([fe80::7cb7:ff63:d358:1a%3]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 11:48:45 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-stable
	<stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>
Subject: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core: Stop
 using of_property_read_bool() for non-boolean properties")
Thread-Topic: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core:
 Stop using of_property_read_bool() for non-boolean properties")
Thread-Index: AQHbvbOn2IVyqXPQQUSxlKelpmXU9A==
Date: Mon, 5 May 2025 11:48:45 +0000
Message-ID: <7fb43b27-8e61-4f87-b28b-8c8c24eb7f75@cs-soprasteria.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB6196:EE_|AS8PR07MB7958:EE_
x-ms-office365-filtering-correlation-id: 2f804ee3-dbe6-41c4-972e-08dd8bcaca6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekdJcDE0bGRKZWN0TVQ5VVk2UmhzLzkzTDFsZ2dRTmJhTnpQYy8xbjNQNE5w?=
 =?utf-8?B?b0VuOTV1SHlhOTQ0WUQzdkg1ZnVKR05mRktzZVEyMlZIM0JtWGJNSGc0SUZO?=
 =?utf-8?B?YUJxZ294WXhXLzl2OGxzam80VE9TMlhiTDVqUWtEZUV2WndvNXlrVEpJQnJH?=
 =?utf-8?B?YnIzK29DSHM4SHRlN20vNERaY0tDK2l4M0hXWnNhaXp3NUp2c3NrM0o3TkFi?=
 =?utf-8?B?OWZ2UEY1ZnpLemNLRFcxQ2RUaVd4TVQ0MnVnM3dyQWxRUE5nOHZ4RVBNWTRw?=
 =?utf-8?B?WVVjMHU2MVJQdnd1ako4NWN4bUp2S1RKNzZCYXN4VXBCV3NGcjRpOVBROXJO?=
 =?utf-8?B?dkFCUzFmVFNJS0lneS9ib2MxK3BKMHE5bFlYYUp6L0N1TEJBQlhRYXI3K3p0?=
 =?utf-8?B?aFYxdzJoRkgzRXRwWlVzRTBpSGU0bmMySmlhVis2VzAzbnJaZStTVGtjNFU0?=
 =?utf-8?B?V3NocmlNMmhYZzlDYjl3ZjZBcHk3U0hPSjMwNEtwa3ZMM0taU0d5S0FXcFRj?=
 =?utf-8?B?V0dWSjlvcGQyK2ZiZlhOSWR0WEFRS3ZuV0hBVTd4K09YNWJQVHFVbjB1ak54?=
 =?utf-8?B?b2xwb0hxY20xMmRPRFV6YkJqQTdCNEhJeFY2bXk4ZkNTR0NLaHRwUnM2bFJi?=
 =?utf-8?B?eVlCOEM1WjJNdDlSQXR5Unp4MlZuRTRiRnhQQSs3blpBM0RIUjV4T21iQzdE?=
 =?utf-8?B?OUM0RG9yZmhKTndlZ21wTU5WMS9WVmZLTmg5TFg4R0QzVWh4Ti9oUVcxSGFL?=
 =?utf-8?B?VE41MC9LSVVYZytUUmlnLy9DMThLSy85STBpTDNCNW9YNFMzOVBaVFo1OGFX?=
 =?utf-8?B?VXdvM1JyVkZkWFVKNXVaUkVQVHkwOUJHUjliOW95MnNDTFVBekVWd3RPRDVG?=
 =?utf-8?B?WjRReUZGZDdid1gzOTlWRVQ1emNnc3FQWG5DK05ndDFHUmJ0dCtoVmJpeUpP?=
 =?utf-8?B?T3hrQ0ptR1lOTU1EcElBdUZrSTVmUHdWSUFITXVTT1pBS21jVlhCQ0Z2bUFJ?=
 =?utf-8?B?R2F2bloxdkRzWjBuazBwOFhkWThBQjlJQTgxanQ1NzVFUlJ4WXk2dmsyNUVQ?=
 =?utf-8?B?dy9ERUIvYnI1dnVNMW0yNWZmdTF0Nm5yUlM4NHVDYXFHbUI1NmFzdVA2QVNT?=
 =?utf-8?B?SFlaZG9EdlBzSWVQTStsZ0txRU0yUFRIYnMxTEl5dC9USVhUakVkSERGb3Ri?=
 =?utf-8?B?dUdKMG1rZWY1QzcwWkh6NWxwSmd3bTBnaXZTSC9iQ3ZOdVlpNzhsaXVJdmZN?=
 =?utf-8?B?bkZ5Nnd1TklRcFZCc2dQbVZqNEprUE9mS3BpRXJsLzJ4Q0RncHFDYVdNMENV?=
 =?utf-8?B?NytvTm1IWjkwOVNqSWJqWmhSYzhORU52c1hlVmxIdTRHNCsxZ3pGdW5vVWNi?=
 =?utf-8?B?aSt4NGJJNWFlWFh5RCtGVmtlQURsbk53aWJVaEQ3US9BRzNoaUtJZU16aVZJ?=
 =?utf-8?B?cmVYQVkzYWwzR0wrWE9uNTVEVUFJWTZ6M2w3aTAvR011K3h6amVUOXlOcWo2?=
 =?utf-8?B?MVRTamxodGJ6QkRXYlVPR2w5elYzZEk5d0w2L0RXVlcwRDJNWnErV00wSTls?=
 =?utf-8?B?KzgvdHNnUGp3VncvQVE5YVdjcS8zdXZYRm54RmR1MDZUc0ErMFozWVc5Tkds?=
 =?utf-8?B?cGtsQ0hMNjgxUy9NR3ZFTlZyOGdYeWJldnljSjMzVisvZWwxSnQ1SXNjKzd2?=
 =?utf-8?B?UVFyclQyek1hL1dQU1ZEWkR0M1A0VnVpVGxEcUptZ1lYMjkwU2t2Y1VRbWEy?=
 =?utf-8?B?VUtTZmZkTWM5eVVtdnVsMW8rUlg5RHdTbVBWZnpoL2s0cUplN0kzWEhacThE?=
 =?utf-8?B?dU81bkZUZGJiVHVRNi91RkNYaEpVelZuVXJlYkxZVmZMYUttMkVrcnF2SHlX?=
 =?utf-8?B?TGN1Vm9tVUNFVW01SGhueWZOM2NmdW1GQm5IYjIweGpsanFteFNUUWxQbm8x?=
 =?utf-8?B?UzVLbEdpdkZBY3VCSUErbVZzRnd1TWFlU3BvOG45dmpJNnZ2Y0YrQUlPSUkr?=
 =?utf-8?B?MTRJVTk4M1ZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB6196.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0RHeks0dXVLaHZFWFFlTHhGekRidkt6WmpvU2R2WDJ4NkRPTDNtK2VNWFZx?=
 =?utf-8?B?bVk5di9MZlZqV2xTSFhmVVRRZWJZL1hrYzhvVU1iRldZKzRZeFAxYndiVXZY?=
 =?utf-8?B?TzNlcWw2ZG1BNFZqdXF1aUk1WVZnNHkwQ3pTNC9kb1BJN2ZvR0cwT1p3Vms0?=
 =?utf-8?B?RGE5MGZaZTFaMDJvTjdGekt2QzEzRm9tYy96b0svK3RKakJreXdCR21aTVpk?=
 =?utf-8?B?SGRjVVZKVXd1bHZtVUlRYXdDTHpQVEtLaC9EUzhMVFVZTEUrWE1leDV5bGlU?=
 =?utf-8?B?N0lJM01QWHY5UDRoV1VxT2NjcG54WnVncVFtVzZaOTJkWHZBTXd6dS9QZ3Ru?=
 =?utf-8?B?Q1l0WFZxbURLOU4vWWZIQnc5N0F2bDZkeUwvaU1HSkNrL0hjSlk5bStsQWNB?=
 =?utf-8?B?L2VBV0FvZENrREsrZ3BPNWFRWkxEY0g0YkJEalI0MFh0Q1JnL2JseGVwK2c5?=
 =?utf-8?B?UTBXQzRrSVZXczVxWm9rd1FlVWZDdjI0Z1lEamx6VmdHZ0lNbkFQR2hCMXlW?=
 =?utf-8?B?WFhYZkVtKzhMc2NqOHBlRHJoZ3k2a3NSWW9IeFc1RG5ZVnZGWi9zQ1BvMVZO?=
 =?utf-8?B?NENsSnl4SWtLVkhTb2N6NGVwMVpWbzRtZHpYNFlEM1lJaGY2d1ZleDJsZitm?=
 =?utf-8?B?M0I1Z2x4UHJqUUd4U21GZEhLYlJRZHJFZHU2eFdPdUhXUzdYTCs4ejFhdTJn?=
 =?utf-8?B?YzExbVo1ekFkMUV1ditzL0Vyc24zR3QxNU12QzBnS3c0TmIrRnN1Z2pzeisv?=
 =?utf-8?B?bmViZmVxWkdoVWJqTytZcEkwdHh0K2JCNU51Nk5veDRGbWZmek9QSG1kNElW?=
 =?utf-8?B?ZkpsZFFKQ2JBWGlYRStiNHBsUzFoKzNad3FBbEJXTTNtbjh0Qm9LOWNESThL?=
 =?utf-8?B?L2p5VG85L0RtSnFtS210Q05MWmUyQjNOZFNUTGc4eEJKR3Eyd2tRalRaaXJE?=
 =?utf-8?B?dzBJYTlFQkJEMlRpeFNJc3Y1bWxxb3c1c1dxc0ZTZzhtMThGditFYTNtWmI3?=
 =?utf-8?B?N2xRN0lBaUlsdHdTZGtDMHBwMnM3clFkaEhRNkVPUFVlaFcrdlZqd3FOWVI5?=
 =?utf-8?B?djd2VVQ1UUNGM1BzT2xGS1l1SHBabllLS3pDSnZtZ0QyYjZKQ0Z2TUQ3R1RG?=
 =?utf-8?B?SGNTdlZUc3BLYXJIb2Q5Z1d1dUhsT21ISGlyemhZQTcxbDYrVFFucHN3Yllm?=
 =?utf-8?B?d3dOd1UrU0R3eW9hclk4NHl6TjJTcWplZG1HNlMwS0lucFNYZ056dWtMYW1Q?=
 =?utf-8?B?QnloYllHZENjSzdET0lwT2JHVkVPTjdGS2FvS1k2Vnlsc3NsclVyTU0ybzhr?=
 =?utf-8?B?S0FpZDM1eC9RTjNnc3UwTEFGdXlRem4yL2ZsL2orV2s2WlZHbUpBT0hkVUlE?=
 =?utf-8?B?U01zVmNWSkt4YmZXN0xoTG5ZMjlqNEcva2l2WktwOGM1MWR2NE8vWGdjN25M?=
 =?utf-8?B?QkZTdzJNSU9OVkJUelo0a00xZVVUb1pCTk1GU29XLzV3WERHQzYwbTNwR0w1?=
 =?utf-8?B?ZFZJcE9qbit6L1YxWGNMaWJ4ZjBxNk8yZUluRjN2ZkNQbks1VmFSRmNURUJP?=
 =?utf-8?B?SVFPeXE4N2VicmVMTlNtcVF4RVpsYldqc0VoelJWUHlabXU5cTdBWENNNW5D?=
 =?utf-8?B?YU0va0U5bXhrck5JR215QXdnK2JZSm52YVdYdzRvemJOWmpWWGF2dEtZaTU0?=
 =?utf-8?B?MytvbDBIcUNUL3E4V2lJeDQyZnNYeUhwL0U1Y1k4ZGYrRnd0WDRKZnBrM0FW?=
 =?utf-8?B?bGJMcTRYVHNLb1ZTZDFFbXdrT0IzVkdtcGVkZzROdGZ4aTVaVWgwNlRhaFAr?=
 =?utf-8?B?Y0JIOVpLUUFxNzlDUzkyT3FjdHdsam43aWlOUDZ0VmlyU2FOYjJ6Y05oMnFW?=
 =?utf-8?B?TDFGaTloT3ExWTNzUEtEaUs1RkhvaW9aa3BXbzdKUVdYSUFMQ0RGd24xRmx4?=
 =?utf-8?B?Y0tTb2l2T2FDWUZmZ2V4V2NUUXpqQzg5TTA4NFg0T3NlY0Q2Z2Mxb1F4YXNp?=
 =?utf-8?B?RXFBNHhuNzQxMkFhdzlLOEpNb0duNG5IdjcvVnVZbGpUYVdKYkJiNnZ1cFZa?=
 =?utf-8?B?YjBNeG5UZ0FjN21veWJTSFNoWmFhTUkwdWJmZDNqdWd5YW15NEQ3NVgrbmhR?=
 =?utf-8?B?bTlSZCttRFAyOGxSS1A5MHROMjFmYzYzTFFpaUxvZ3RVT0pRektBM2pNZjZh?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74BBCB9C1FFE8A468B1D26396B05CFE0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB6196.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f804ee3-dbe6-41c4-972e-08dd8bcaca6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 11:48:45.1741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swEPeyjoQUGB4796RIvg1lt4/KYYKkXzHZbscBbCkmEkYPA2ppGvEc8V3aBSnl7dqTtpqU2288y/QcvzxBu/acOGVt+bzWyypgY94+gGDkDICW62uaz68o/OrYn7fR6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7958
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB6196.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS8PR07MB7958.eurprd07.prod.outlook.com

SGksDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgY29tbWl0IDZlYWI3MDM0NTc5OSAoIkFTb0M6
IHNvYy1jb3JlOiBTdG9wIHVzaW5nIA0Kb2ZfcHJvcGVydHlfcmVhZF9ib29sKCkgZm9yIG5vbi1i
b29sZWFuIHByb3BlcnRpZXMiKSB0byB2Ni4xNC54IGluIG9yZGVyIA0KdG8gc2lsZW5jZSB3YXJu
aW5ncyBpbnRyb2R1Y2VkIGluIHY2LjE0IGJ5IGNvbW1pdCBjMTQxZWNjM2NlY2QgKCJvZjogDQpX
YXJuIHdoZW4gb2ZfcHJvcGVydHlfcmVhZF9ib29sKCkgaXMgdXNlZCBvbiBub24tYm9vbGVhbiBw
cm9wZXJ0aWVzIikNCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQo=

