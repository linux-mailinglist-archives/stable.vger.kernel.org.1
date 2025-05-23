Return-Path: <stable+bounces-146197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96239AC2297
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E4A209C9
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A123814A;
	Fri, 23 May 2025 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ateme.com header.i=@ateme.com header.b="LdwfSntJ"
X-Original-To: stable@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021085.outbound.protection.outlook.com [40.107.160.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F8236451;
	Fri, 23 May 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003060; cv=fail; b=tD/banPjtoE5/H8432YsSatdaCN+O5L5JzDHvse9HEH2viDe2xgszMqi9ZJn6Dd85xGcfAeksnmcVR0D38CYEyWpiJeOl7TK3M2iZMIe+gFPAMCfl8Zs1o5569C7cBRq8lO/QvqbAfNYoPX1aeGL+ZhhWYbZoCFNUpp8jeP2jfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003060; c=relaxed/simple;
	bh=oo98JQVaHYuigwWXspyJrdQrBpjuIpGv08x3PBzQwWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eATe4MKtjfrgqPV49c1MXNU+x6FeLpSHGpZuSAKDKp+CsTWCw6gWirFREeWvE8A6JCrcXvCPGItDI/jeT+UYoXLZcVJsI0d2PcJcfbgn4p5G19Q44OANhqWD6Nmdat0NEwyaCik1LWg8tVC7jMTDlTRYk14np3ddaVnRVu/S+Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ateme.com; spf=pass smtp.mailfrom=ateme.com; dkim=pass (2048-bit key) header.d=ateme.com header.i=@ateme.com header.b=LdwfSntJ; arc=fail smtp.client-ip=40.107.160.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ateme.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ateme.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imclhng/v54kxVzPb713JtNKA/bDtZGeyVeOwlLf3Nbu5xebGACoq1jmwtbNmN8z0Ngj7Bs4+4wkC9wh/2rphAFFew50BacQ5izsJyC15/1NTbOtT62mrL+XvrDojlA0jVTBTdN5uiB0xQL2o6wyh8RGgRPzOErQY6cmp87bcHc9MPnQlV36xvYZHEBs2zj1lSKXC+nHrJHC1mGEMCKffxVhTZ8fk1aQEWVcuOZPJV8+fyiawyW3zx/7tHxoghOf4Jh039NDCl9VuMxkY3aYiRIXkuFvFjm2DCjr+RaoJxBEMKz2GOOJGFuZLlpBBkZgQvLVZIXeYfJ1YtUHJ4LjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo98JQVaHYuigwWXspyJrdQrBpjuIpGv08x3PBzQwWs=;
 b=SAdIv/dz89XXmNXUSIKDQPhLI2ssYE8zNPBKczJWjyXWKRhal3dOTjOSadw8qCoYCGRSBNAnb35GDEKZ5yeNHYFq8K5zrOBG03H/U6ZVaEeRcILfi7DvN8AKo1ZIhTYqjxSRUOXYAJ4Ccq0ELdVgJegSxDR+YWdDniuurOzIu9Y62El7vhSM3lkJVOhvuPYu9rzevIU01vjBUrw7yxOeuaYer+kWXuxVbvue3TaumrL3X9cNDfTWPwpHNqrHQBtQ7sfmaYdTqqrMtFVWXc3KEtP1OnJerVaL1kqRPtesYg9BvFRzfVuyTiUzBrgQWXAAk4fu3QSYJTykxOcYKzZBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ateme.com; dmarc=pass action=none header.from=ateme.com;
 dkim=pass header.d=ateme.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ateme.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo98JQVaHYuigwWXspyJrdQrBpjuIpGv08x3PBzQwWs=;
 b=LdwfSntJJ81z8H7KO7RLHYSejOkoVXYRdEWeo8G0EbU/5QPTgV8adsU0tLBc6SRzxhr5QpovGXa/KMfaIpA/V4P+zDEMLyG08pK+zyRBW8gdCCFxH2zka9yM5MM3ELkmDMiipncWKjLEmwSqX54+85jUk8RppGvKYs5WDQrNVlhnarSI0EyQbKhNCapRUc0AJNhsbvJ33SNAd4po5dAPFvaY5VtQf3+ZPJ8nskAAV2Blam08y7XpfRPsxBVBmmzmhxWxnFTUQaA0aF+uSwwtw32oi3RbqrZogXQON5pZt1Wws++v51WcC0amhxj6zhFoyoJ/iz3rHdFzvl8SB9AkdA==
Received: from MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::18)
 by MR1P264MB3234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 12:24:14 +0000
Received: from MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e250:72c7:9cca:c5ad]) by MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e250:72c7:9cca:c5ad%3]) with mapi id 15.20.8769.022; Fri, 23 May 2025
 12:24:14 +0000
From: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Valentin Schneider <vschneid@redhat.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: IPC drop down on AMD epyc 7702P
Thread-Topic: IPC drop down on AMD epyc 7702P
Thread-Index:
 AQHbr9zhl/8RWJ02Dk6pHFtpBzdc+LOo+aeAgA/I94CAAz3LAIAH8N6AgAAhnYCAAC0kgIAAAbKAgBFGlYCACWn9AIABaSmA
Date: Fri, 23 May 2025 12:24:13 +0000
Message-ID: <fea6da1d-85d6-459d-9ac3-661d5909420b@ateme.com>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
 <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
 <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com>
 <CAKfTPtC6siPqX=vBweKz+dt2zoGiSQEGo32yh+MGhxNLSSW1_w@mail.gmail.com>
 <c0e87c08-f863-47f3-8016-c44e3dce2811@amd.com>
 <db7b5ad7-3dad-4e7c-a323-d0128ae818eb@ateme.com>
 <CAKfTPtDkmsFD=1uG+dGOrYfdaap4SWupc8kVV8LanwaXSbxruA@mail.gmail.com>
In-Reply-To:
 <CAKfTPtDkmsFD=1uG+dGOrYfdaap4SWupc8kVV8LanwaXSbxruA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ateme.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2587:EE_|MR1P264MB3234:EE_
x-ms-office365-filtering-correlation-id: a52cdc92-2373-4c97-d98c-08dd99f4baba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dElaejVTakVQWjBrYlM1cmJlMFdhMGFGVnQ1MzFVK09mZEQ3VXF4Zk1iTmdC?=
 =?utf-8?B?MEVqc05uZGozejFSWkNybG1qYUV5U3UvQnNRQ2dQTVFhSDY0QnJNQUtiWWxy?=
 =?utf-8?B?RHNwdng4TXdMMlBPV2N4b0d0ZkU5STVGQWxlNFpOaWNRUTdEMExyb3RvVnJt?=
 =?utf-8?B?TlZpc0E5T2o1aWRGRlJ2RHZ2WVdpSkQ5Z1l1TkpSaWcvYjVIRndaNitCcHpT?=
 =?utf-8?B?YndLOHBESlFKU0lUeG9HOFVydXpld1E3RlVDTHB2bmZNejh3UUpkektqSjZ5?=
 =?utf-8?B?bDkzZlJ0c1ppbkREaXQ0T2FkbGFFcTRrZmhocUloNVdsbysvcmlmYitoSzFQ?=
 =?utf-8?B?cDM5MUg0RVZiemxiaUd0dVhEb0d3MGhYa0NZK3crWmlVcmlwWnhvNWFSTDQ4?=
 =?utf-8?B?MEV6TlNKTmwyUWxnVGRCcjNENDliWmthZ0RHZlZUZUhjWHcxL09HRU1ISjd4?=
 =?utf-8?B?K3lyZ2VGQzNzMmdwL0lySE9wRGZhOWVPQ3ZxbmNTcVFoQlJ3cEV4bStEUkQw?=
 =?utf-8?B?VysyeGhjQ1lqUkZMWG1FOWJDY25OOThTeVZLb2todHdQeHRrOWVBN3FCYmFu?=
 =?utf-8?B?S3M1dVRNWnVGU1M0cG94K0lBSUN5WXdiZ2xBOGpwQU9qUE1nQnNvbGIzRVF0?=
 =?utf-8?B?SlQ5Rk0rbzlkejZ6UVBHcWpxSnltbG5uMnBJMnZBRkJ3bW1JM1lYYlltRExI?=
 =?utf-8?B?SEJiZVhUdDl2YnBIaGFqR2ZSUWNiNEtUNFJicG5MK05LSmQ1TnZiVFJHUDBV?=
 =?utf-8?B?MnlCSnliaVp0Sy9uN0lIejIwOG5EMmtSUGVpUUpUTm16YVQyVTUzRzFsVHFP?=
 =?utf-8?B?dzZndTFhR1I3dEg4N05QaFQveDhVZjVHQ3dkZ29RdnVMOTJjSy9GT2Yydno1?=
 =?utf-8?B?dlJya2xmcEZ6NmVtREI5RTkwczU3bDdHY2RoVXBWYlB5WVkwdk0xc3k5Z1pn?=
 =?utf-8?B?YjY2SENBTklkaENQY3RYQmdzcWV2Y1k0c0JtWnU1RnVvWnA5QUE3T2VkVEtr?=
 =?utf-8?B?L01ibFpOYUlsT2JFa1QyYzdsM0EvRTdsOHhWSUh1UEJTSHNOeWRsUXA3ZXEr?=
 =?utf-8?B?bEkzMHhBZmpVNnE4NUxsVWQ4Um0yaEFNVzcwSDVEdUtTb3RhTVpXZ1VLN2dm?=
 =?utf-8?B?dm1NVkpmVVhSc2wyc1o3VlpuRXlRMGFhS2RRWDh5M3A4TG52dkM2dk1ZSDc3?=
 =?utf-8?B?bWhiZUgrNVRhemkwdVBnVTI5OFNxaXBGOENjSnl2UGpNSFNBaG5wRzNyZkhL?=
 =?utf-8?B?Y3ZqaWxNa2RPSjVheWtSZWltZlNTV0NTdk8vbXQzeXk5dFRYYmZyK2VvaGFw?=
 =?utf-8?B?VmxuRVJUYlBBR0xkdjhJY3BqU2xzak1JSTFrRnh4RlljUFNlejJtdThESUVt?=
 =?utf-8?B?VTFtb2U2bDZmemNZR2hXQk9XOXlCUS8zSEdLdVV0NmtVay9CM1lKUUVoT3RL?=
 =?utf-8?B?QUNPT2VGU3lzSElOWEdxZm9WdGk2cmRrWFhqcFVUbmdIaGo5Qkdsc3dmVExT?=
 =?utf-8?B?bnI4UkxYbEhETXNHY2l5QmJUWHNHYXR0MjJwTzRQNWU3K0ZoaTFSbGFBOXFE?=
 =?utf-8?B?THB2cDNpb1ZlZGhBMCsrMUlsaFMyZUtzWHNGRVdZWjFzMzdqamozb09udVNV?=
 =?utf-8?B?d0dVdDJNYk0xbTg1SWU1REZLWUVSTVQyeE9KWmN1NWovSEk2MjdGc3p3VnV2?=
 =?utf-8?B?Y3FHV2U4Uk5UcnlCSFQ4OHpiRzY5TFovSmM2eVcyaDh1SGNGTHBLNjlPcm5X?=
 =?utf-8?B?bHlvbEZVQ25yUzF0UVkzYnk1NFBQOTRXeTBZV01nb1JXTEdqTk1uSElFUUlq?=
 =?utf-8?B?YTN5NVkwUnBKdThCaHZJQkhrVk1GekVtNWNGWElJWmluWDUyZThGU1J1WGFw?=
 =?utf-8?B?MlQyaW9rK3RBdVVNWGZEZmJjaFVuZzdSRkwzNXFIajdNWXRqRW9uTlZWY3BE?=
 =?utf-8?B?M293UnFnNEJHRzVEVmpLUWdRcllMRGY0MVlmTy82OGZ2Qk5kMmhQbHBNeHBZ?=
 =?utf-8?B?eGsrTjgrdThRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elRlNVhHbXNOVExkS1BwSW9vS084WG9iNk03TXdMV3lTSVdRbmF2c0VnTHhE?=
 =?utf-8?B?N2psTnc5M3NvLzRXaWU1WXVTbFZKU3ZjMmNxcjVvWU5GMmFiZzJ6TmJuTENU?=
 =?utf-8?B?WGNhWGNjVUdSdEd4K2FIcDBsTUxRVzZ4RzJ6TW5PY2V2S0hDSXFnMm16RjdZ?=
 =?utf-8?B?M3k2bUhjc2VHTzRrREo5U3UzNVFOZTZQdmN2cS8xUlA1cXJOZjVSem9pWUk3?=
 =?utf-8?B?SzRmaUcvK2FUcGZKd0tpN3ZydytVRThaNlMrSTBVNTEyMkh3K0t4Mjg4VzBr?=
 =?utf-8?B?b2Q2QXA4aVRoU0kwL0lralVwNEt6dWcrSGRMajhJRFpxWW0vcDJEd2FaUVpk?=
 =?utf-8?B?aXp6Y1BBZng0QmNqMzRxT01UZExXQ3ZTRUIxakwxMlZXVUlGNlVxYktJN29a?=
 =?utf-8?B?ak5uaDU0dnZFU2QwZlZ0QlcwVmV1cEhPeEVuR2ZFTVdrc2l1YUVnU1dGaTFm?=
 =?utf-8?B?TkNHbVBiNnEzd0V4Zmh5enhRUkx6WkVaSmcwM0JndUc3VWVRNi94VGwxVDFT?=
 =?utf-8?B?ME43K0RjZmE3b2hJNm0wbGhIZXR5OCtBWWFsaTZHMXZSeFF4NnJjd1NFT29w?=
 =?utf-8?B?OFdwR0xiS0lQY1NFL1hjaW1QS2Eva0dCMEZmeTZRRzh4RWpjZkt6R3BVMjly?=
 =?utf-8?B?OWxydnEyMVdWVU1uTkwvYnMwRlJ6c1dKcGU0REpTTFcxcFhOeXNlc3NUcDlI?=
 =?utf-8?B?NDV4RzRIQUtSRE9zd3dZUmpuVzhDTjhyNUthSmZrK042SUN5cDNlZDVnZkZ4?=
 =?utf-8?B?aDJwMkNqeG1SZmdaVEgvbnVxSWVOREN2YSs2TEtWdHNFVVVWZzlNWVkzY3hF?=
 =?utf-8?B?NmJPYU1RUmpFbFhmMEVEV2l1Tzh6WWg0WC92UC8yKzE5Z2RQSWNoZ21HVDgy?=
 =?utf-8?B?SVpHRXA2cnpCdFl2aWZ1N3JjeHgrdDBQeFFZT0JKSVA2M3Q3eDY1N29walZU?=
 =?utf-8?B?SEFnQUVwNlI0NDdzWUFuUG5kcVZLZy9KbHQzcFJSR0RleWRHVFFVZkVqMTlW?=
 =?utf-8?B?YWRMWEN0UC9sYXZ3VFdSNWQrQXQ3WW5KSVdZSy9oclZ2UUlNQWhxVUs2SG9v?=
 =?utf-8?B?VVJvbE1JR3J6Q2N2M2lTRHppa2IydzRHazh3MHdEaXFrNDRJK0xIR0MxdVBE?=
 =?utf-8?B?NG5jaWlxcWozVldkRmxja0oySXE2aWcxd1I0ZlJ0Zk50bWlwbWlhQndjVWgv?=
 =?utf-8?B?SWd1QTZ6bzJldlpYancrNk5OTDRMelE0K0MvMzlHdEdaT3ZkUEtITVNuK2Yx?=
 =?utf-8?B?elBzMjd1QVZOVXd0Q01ZT0hrbU9tRTRDd3E5WVVibVB6UklTOHM1am9KVklL?=
 =?utf-8?B?YTltd215a2tKaDBrQ0dKaExlaENnc01VOVFjd0FQZjRScnB0dXp6dWNIMVBJ?=
 =?utf-8?B?RzdIZWVzY0N1UW1nblhDNzlPeFF3ci9FUExTNUVFaGpldllLMWdDOFRrclk4?=
 =?utf-8?B?WDVuaHVWOHRMUjRDZ2ozSG9GUWhiUnlpSlRNZkJBNUxaU2kwd2xEWnh5R1R0?=
 =?utf-8?B?a0c1cU4wVzg0VzdHc3pDWlRlL3hqTU5aTGRXNHM4cG5oVVFFZDNtUG5XQnoz?=
 =?utf-8?B?UnVSTTBvMTdKTG5JdlJZcnc3WnpjWjRodXpaNG5RVHFteGtncHN0TjdrQ3ls?=
 =?utf-8?B?WnVHdGt1TVQ5ODhsTklQd1Z3MHcrYi8wemU1TzU3YU1SZGF1bjcxRkZvc3hH?=
 =?utf-8?B?cVNKM25KODFvd0o2RFZyaTJ1OHIzR1BoUXN3Z2R0L3E2cW0zNGhFOU1Nc0JY?=
 =?utf-8?B?cGx5UGgxTnBTaWhmcnB3WUxnNEQ1aWdvZE16SWJySTcxODc1dWRHL2drbHpu?=
 =?utf-8?B?TTN5b0VNWjFwWjdBQWZDRGVkdkswK01tclhGZE5FMTRCeGo2WlplUktjZTQz?=
 =?utf-8?B?aUpaeHZrdnYxdWs4QzdSUjBhbDIvcXZ5WW9DaVVSMnRtdENSTisrVTY1WDls?=
 =?utf-8?B?a0JtaGZYVTMwWWZjanJiSWVKZnVwQ1lXNkMydWlNSmYwVTJpOFZRVXArVGN6?=
 =?utf-8?B?bFlOdzdwOVE5NjNvTkpRT3dtZ1BuakpBQzE5cDJ4YWdKQnYxUXhLMEc5WW9R?=
 =?utf-8?B?UFNna1AxTzEzd1hMTWQyVFdYQVRTTkRlRkhDKzIzcmxjRVNMakVCTTlXdTBO?=
 =?utf-8?B?TXRzMXExK045dWxUZ1UwWHhzVWpoNzkxMXBJL2RyckpiMVpoZVRZOUR0TzM5?=
 =?utf-8?Q?gbx0TkqAO4EQX4vNyrK6Qv2dqf9hCsciVtxSZKNlrhqd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE9754F313CF4B4ABAAD1733B5A0EE05@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ateme.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a52cdc92-2373-4c97-d98c-08dd99f4baba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 12:24:13.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99ffcb0b-61fb-4a70-9dbf-700e3874ace9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tO7Aw+yxZh388FCqWHUuCRcni/Jekgy5swIh33C+u2lgoIF7/aR3pVJhmIqtuQ1ebMOEVbBkX/YTjiUDErZd6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3234

SGVsbG8gVmluY2VudCwNCg0KPiBBcyBzYWlkIHByZXZpb3VzbHksIEkgZG9uJ3Qgc2VlIGFuIG9i
dmlvdXMgY29ubmVjdGlvbiBiZXR3ZWVuIGNvbW1pdA0KPiAxNmIwYTdhMWEwYWYgICgic2NoZWQv
ZmFpcjogRW5zdXJlIHRhc2tzIHNwcmVhZGluZyBpbiBMTEMgZHVyaW5nIExCIikNCj4gd2hpY2gg
bWFpbmx5IGVuc3VyZXMgYSBiZXR0ZXIgdXNhZ2Ugb2YgQ1BVcyBpbnNpZGUgYSBMTEMuIERvIHlv
dSBoYXZlDQo+IGNwdWZyZXEgYW5kIGZyZXEgc2NhbGluZyBlbmFibGVkID8gVGhlIG9ubHkgbGlu
ayB0aGF0IEkgY291bGQgdGhpbmsNCj4gb2YsIGlzIHRoYXQgdGhlIHNwcmVhZCBvZiB0YXNrIGlu
c2lkZSBhIGxsYyBmYXZvcnMgaW50ZXIgTExDIG5ld2x5DQo+IGlkbGUgbG9hZCBiYWxhbmNlDQoj
IGxzbW9kIHwgZ3JlcCBjcHVmcmVxDQpjcHVmcmVxX3VzZXJzcGFjZcKgwqDCoMKgwqAgMTYzODTC
oCAwDQpjcHVmcmVxX2NvbnNlcnZhdGl2ZcKgwqDCoCAxNjM4NMKgIDANCmNwdWZyZXFfcG93ZXJz
YXZlwqDCoMKgwqDCoCAxNjM4NMKgIDANCg0KDQpidXQgSSdtIG5vdCBzdXJlIGNwdWZyZXEgaXMg
d2VsbCBsb2FkZWQgOg0KDQojIGNwdXBvd2VyIGZyZXF1ZW5jeS1pbmZvDQphbmFseXppbmcgQ1BV
IDA6DQogwqAgbm8gb3IgdW5rbm93biBjcHVmcmVxIGRyaXZlciBpcyBhY3RpdmUgb24gdGhpcyBD
UFUNCiDCoCBDUFVzIHdoaWNoIHJ1biBhdCB0aGUgc2FtZSBoYXJkd2FyZSBmcmVxdWVuY3k6IE5v
dCBBdmFpbGFibGUNCiDCoCBDUFVzIHdoaWNoIG5lZWQgdG8gaGF2ZSB0aGVpciBmcmVxdWVuY3kg
Y29vcmRpbmF0ZWQgYnkgc29mdHdhcmU6IE5vdCANCkF2YWlsYWJsZQ0KIMKgIG1heGltdW0gdHJh
bnNpdGlvbiBsYXRlbmN5OsKgIENhbm5vdCBkZXRlcm1pbmUgb3IgaXMgbm90IHN1cHBvcnRlZC4N
Ck5vdCBBdmFpbGFibGUNCiDCoCBhdmFpbGFibGUgY3B1ZnJlcSBnb3Zlcm5vcnM6IE5vdCBBdmFp
bGFibGUNCiDCoCBVbmFibGUgdG8gZGV0ZXJtaW5lIGN1cnJlbnQgcG9saWN5DQogwqAgY3VycmVu
dCBDUFUgZnJlcXVlbmN5OiBVbmFibGUgdG8gY2FsbCBoYXJkd2FyZQ0KIMKgIGN1cnJlbnQgQ1BV
IGZyZXF1ZW5jeTrCoCBVbmFibGUgdG8gY2FsbCB0byBrZXJuZWwNCiDCoCBib29zdCBzdGF0ZSBz
dXBwb3J0Og0KIMKgwqDCoCBTdXBwb3J0ZWQ6IHllcw0KIMKgwqDCoCBBY3RpdmU6IHllcw0KIMKg
wqDCoCBCb29zdCBTdGF0ZXM6IDANCiDCoMKgwqAgVG90YWwgU3RhdGVzOiAzDQogwqDCoMKgIFBz
dGF0ZS1QMDrCoCAyMDAwTUh6DQogwqDCoMKgIFBzdGF0ZS1QMTrCoCAxODAwTUh6DQogwqDCoMKg
IFBzdGF0ZS1QMjrCoCAxNTAwTUh6DQoNCkFuZCBJIGNhbnQgZmluZCBjcHVmcmVxLyB1bmRlciAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUqLw0KDQoNClRoYW5rcyBmb3IgeW91ciBoZWxwLA0K
DQpqYg0KDQo=

