Return-Path: <stable+bounces-120376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F2A4EC88
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4FA7A61AA
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB36215F7D;
	Tue,  4 Mar 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="BiN9TRJL";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hWDvKGVu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA141E505;
	Tue,  4 Mar 2025 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114678; cv=fail; b=cu7SgY6pW7G9GJ6+g04ydZNVgdhLoHvMBwmBd/jGQV25pc0LXpe5s9EtYR820PcRG1ks1GoEGZBy8w8U7sEBVrom1jXp9e+6UsHinRLjxMxON9WYqxipjF6ccf+lDF696PPgvQgR/InYcw8HXkZFMaeNOojI2dMfwpqORYCcTOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114678; c=relaxed/simple;
	bh=lroHRt4tboAkj8I3hYPOVXTPabN9wzu+/zqvFf3dVe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6Nfp+A2OaYWbi0k75cLYHvMtaZHgBh4/pkvziYV0FB95xy+emX6roatFYFUbm77qoPR8mt6Ifwiaqrq9+8tCE3FJYtNcT8We+vbJb0OLoYNchm8n0oIck6bNLqyThTd/Al8g+8uEC50F68S0Hvjs0d4zW0vInCP5K315uOJzkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=BiN9TRJL; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hWDvKGVu; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249Clfl004055;
	Tue, 4 Mar 2025 10:57:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=lroHRt4tboAkj8I3hYPOVXTPabN9wzu+/zqvFf3dV
	e0=; b=BiN9TRJL71h9EXmuyxCPPFV1apepy/qGTw9BJ6AXEO5mIhDWtDoFCaP8R
	ITxENMXnBZX0LamopKnOOwiFwcD+rWeJIbtPa0jxOagy0u8M8ZTc5uV58SHivMdc
	G+Jl1idmHXB4LYQRvpmNXBjq83eAjtdAh1gR8clwvgg0pu/aSkbzVOl2x5OZzQLc
	9NjYDcBuH8oYf+Zkrx96U8zP1zYmUyijdnDZBqyeOdT+UvDu+wiG4L8aMYlFor52
	C9Fr0uwStgnD71RWIKTt8cGjX9f41h75LT5urVyNTbG4n/c2qH2/gUJoZRyYgZk3
	yr0mmdfsi78t06oK93D1QFjvaCS/Q==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.10])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45417nj8yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:57:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdAu3MUbBRy9xpMM/vHFpQ/5DPBJekieFnUY+CX0E0Ti0mCL2013B6ygekcFGSFUZUE2+JoQGuQkxkQmoP49ABn4PNDVTiJKYYQJ3nkyPQ4GDeiAGGkZFbHmyn/aDHpQrLrlaxRiBwbF8grT8JFKlKsDBx/hpCAZkyUueKDGydJlSVFdgEfiq3/0tJzF31UWCV5FXj+o1Pkphr1zRQWr+Krq+8lhELjJaPtFd0wvZeF2CSSH3KJYARFrOG1n9KgTW6RKQQQh1kT0i53p98/L0PkPkHUcx5/DmvlJIGlFCmRMzvexrFdu4LuGMHwWJYW2vBE604h1PfFZT4JCE1LvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lroHRt4tboAkj8I3hYPOVXTPabN9wzu+/zqvFf3dVe0=;
 b=ez3M3wOPnGYNkpDDlo6XNdAVZe59iTq58spAFRrSQpse6y5SnnT44tp7PzpoySNe7OZGYidhOTrmrNHknb+BbrwnwaenrA3X6a3xO6y3fkp+1LN+rDzXtuwecFutP8fSe0zcHkHwqrQc4RypUHCekcwVw8xU9GKtXfpxTRCVlzytuT/uqaBXxSc4Tk535xaZiQUeTRWgodVcCSbaqqaNgOC/MZtzgtAmaTAu3KKNzD/lfI6opz4a7G//scQHOYm3eB0Y25hd9t0zXINCWzWajDNIFjeXSikOorapdDxaDouriFNOipgQ5BaW40RwAWkDQMFSgVv1N6hcuTSKjaxgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lroHRt4tboAkj8I3hYPOVXTPabN9wzu+/zqvFf3dVe0=;
 b=hWDvKGVuyiZnAmuV7xOhSXpHPf9uHlJsL4ww22UuIgbGlsZUU8Wh4/Z/z+TWf8nZhIHc4co1btSO/kBz5mHrrWt64jkoO6vmgee7wxaMiDAO4Z6wnuaF9Q6BJIIXDdrfTZsqXFg5nSE/EOsVU9k84COBaUbd3alUp807kDG7X1C/C+qFzhW1CuNWhKJqyEXSgIOisCWhb321Ti4LOb7J+PsExjHRExiQ1zFwXrFUehfH7cygI5eK7eL4PfRemhBUqVl/45LSwfN5tAP/9JFRkPXDJJiEYlZWDNaf6WQW8wcaqvtnVOTQcV65AU743KZtSGa24OKkw3s87x7m6XE4Nw==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by PH0PR02MB7813.namprd02.prod.outlook.com (2603:10b6:510:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 18:57:29 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 18:57:29 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin
 Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jon Kohler <jon@nutanix.com>,
        Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru
	<rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbh7ASF98xRUPde0yBoaYiJ5HLYLNivLCAgABohoCAAA1zgIAALDcA
Date: Tue, 4 Mar 2025 18:57:29 +0000
Message-ID: <38470D92-7862-4921-A2D6-E8B37E15FBCD@nutanix.com>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
 <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|PH0PR02MB7813:EE_
x-ms-office365-filtering-correlation-id: 917c1021-caae-4aad-2839-08dd5b4e69d8
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUpjV1FENTRqdFdUeHRtMEJCYmxidFp2Z00rUFphTnM1OXBTQ2RodmdTdTd5?=
 =?utf-8?B?OWgzKzA3ejVVUGNRQzF0ampoZitWK1owTzdPT1h2NkdKZ1BBRkR6a3JXZm5h?=
 =?utf-8?B?T3g5OHllcGVwSEJVU3psaWtqYnNlSjNOSFI2SUJQcnBmbE9kMndmckl1K3dY?=
 =?utf-8?B?eERMYThmdmdsTVVVYTl4ZHVGYnZhZXlFT0V1cFJRejJOVW9BeWhIRXVGOFJx?=
 =?utf-8?B?dEpRbmpaUVBVTjlJTTJPdGY5bUNFbXBJSk8xR2tObEZVc1N1ei9DbGNlZkYw?=
 =?utf-8?B?RmNOWlZjU2N2WUs0bmhiUzBvR3F4TG9ZSzZxREtpWDFuNHdtaWdKT0lxQkxt?=
 =?utf-8?B?Y0N5Z21PaVgwTmd4REUyaC9jZERvTXlIaW9aR1JudHAzdWtGZElBSHFmZGp4?=
 =?utf-8?B?b2VHb0NkZDk3NXZaVjZtV2tjUkt3dGExdHM0ZVVLNGZRRzh3bnFGcjBrQnFp?=
 =?utf-8?B?WDk3RmpSbXgxcTFDWG9tZVBBeUt6N3Y0RG1MVjNJdU5XdEFzQXcycndLcXc0?=
 =?utf-8?B?Vjl2d0dNdnE1UFZxaVZYWmNiTFQwcXowMjlaRml3ZWRDTjRKQWpTbEZNSkR4?=
 =?utf-8?B?Z1hRZEs5L1BwTXh6TTE1Q1dUZUt6WGJnSnJHVFkzcG5UTEVyNlY2ckhjMElr?=
 =?utf-8?B?aVE0OHRtZDR6SDhZNndiQU9qQk8wTXdiVVk0ZC94RkxIdlpTdEhMWm12RG50?=
 =?utf-8?B?WFBDYWxhQXVBTVNFS0ExYnJFNEdKM2FnU3RzMkwzRkJld3MwVXVIS1dsUk1B?=
 =?utf-8?B?WTdhU2lLL280YTZDQS9hSVFQRWRab2tPc2VwUmlRU1FRdHJjTlMxRndJNHEy?=
 =?utf-8?B?eUR4OWVDYTU0NzdBVTB2dGllNXVkUVVOTWkwU2pvNFlENjRPczJZSkZ3MGlG?=
 =?utf-8?B?Y0VzdmZDUHZrL29mc0tHR3RnYjk5RFN6MFhBMTRqUlFRekRwRHFCMzdzSEpR?=
 =?utf-8?B?TWRxMWhMUHp1RHgrcnp1WUlyWllBeUs4ci9NUC85d1VLWW1JT0IwMm1zYjFH?=
 =?utf-8?B?d0VEQzFiZ2I2bHkwTHhKcHJDNVJMWXQxUk5XKzROUjQzMXlDU3BjVytxZTdk?=
 =?utf-8?B?eTVEUXlKN2I0d1BaR1ExL2ZJRmJmWlVWRGl0elVVRmZCTjg3eGJWMTJvckdO?=
 =?utf-8?B?RjQ2WXpJQTBZMW1QWURKUnQxTTZ3WmtwV3k5MWhDdjlUQWdURjhBZ0xjSVVP?=
 =?utf-8?B?cHV1ZUNYZHA0SXBpMEllTjM3WXJ0VnQ3NzV0cHovamRzeDdiVS9vUTRFRHdt?=
 =?utf-8?B?TWhsaGJXb3QyWmJaUDlxTk9KNS9JVUUveWNFR0xkYnNGY1lMQnZGMEIxaGkz?=
 =?utf-8?B?cC9JLzBVc2hTaGJnWkJpUGFhQVA0dGtGTjQwRFpNUjdTbFlpSWJYbDJCSkJs?=
 =?utf-8?B?MktsaTUxQ29CcGUxSmhrbUswY1VMYkZ4TFRYZEVneUFCRVN2WG0vTHRaTXha?=
 =?utf-8?B?VDBiVENKbnRGRzBJWkFIWmZnQ3RycWw5cDlmdEEyOC9od3N6VUd3OXJHSlg1?=
 =?utf-8?B?K2pSYkhPNGwrRmcxVCsyRGQ3YmtEN3lzbkVSSG15cFVjeW45Y0NnR0FoTGpk?=
 =?utf-8?B?T1E3cnh6MkhvV0VoMUhWZk9PamlDVFliK1JMWFlldlBka09zUkVKTkJ3SlFN?=
 =?utf-8?B?d1hDdFVWdGNCS3orcHUxdncvVWVIQ0FoM0tsU1djUXZNdVFQL1gwcHVORUt1?=
 =?utf-8?B?ZkJKVms5dG9NMGtpTTFHd2NOcTc5STB0R1NUNm00eWNMcENpUHNGcHJQYy9n?=
 =?utf-8?B?RmV0c29nVmRoQjhrZ2FzbUJpTndsVm5jQ1VVbGFCaEVTUmN3RnBVZjRkQlVF?=
 =?utf-8?B?ZXdmWHFxeDZXeDhPbjMzREY3UzZGWlBxRW1yUmRuTVRWeFlvTzBoVWJCelBF?=
 =?utf-8?B?RE5PUkRHUlIzV1NlWTNiVmVIZjZyUW1pMGV4ZitaQzBTZkxieURSM3FhWmw5?=
 =?utf-8?Q?GnTb8qm5MLcSh/7RtL9cMqHAKUL7vf/w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NS84UkIrSEhZZUdLM042b1VKazBEakJxZVJLT0MzQjNKSG5vbjNCVURXZEJt?=
 =?utf-8?B?czUrbmFOWXFHOXNpM3pqSXk2NUFVb3NGZzAwUkdNY3podkQvT2oxWncxcHRP?=
 =?utf-8?B?VU5jR1dEM09RRDdna2tONGNmQjd6R3FBUlFpM3BjRUxKTXA0QXFMd2tjVU1v?=
 =?utf-8?B?dVRiQ1lObmM1NWdOdUphZkdWUnlEUk05dHM2ZWlhaUtGZHk0bkhCcDFEN0Fq?=
 =?utf-8?B?c2k2aWRyekZzdGpMTnpDRjZZV2I3dExpNndiNFB6Qy9ubzZwcm5pOWg4Sy9w?=
 =?utf-8?B?aEdMSXl5NzdEWDFpRk9NNDdwVGVuTWYzaWUvOTRjQ3FSTHp6VnZ6dGI2bkk0?=
 =?utf-8?B?NHcyZ213NXR4RVBZbnhkT0swRDc0Y0U1VlBVMVEvUHI0TDNYb3RhVE1vNEs1?=
 =?utf-8?B?d1VycDRXU1JzeU9WZm14TllTaDRvZG5SZ0xITzg5TmdKb1J0Y205ajJlNUE2?=
 =?utf-8?B?ZkFuQmI2RW1PSkxRLzhvYWJuZE0wMDFzL241ZHExY1ErUnBPU1k3VzVYaHdr?=
 =?utf-8?B?ZW5JdmJIeGtoN2RIdjEwS3dtTlhIN0tiOEgrZ0pWOUpFQmVmMVptZDRzTEtZ?=
 =?utf-8?B?clFKaGh1ZWVWbCs3RXVNUEJ3UUVBU2kvRXV0TTdsTUorM2VPWXF1alJhZm9W?=
 =?utf-8?B?L0xJQVdzM1VJSkkzeWVvUm9ZY0lKODZlRVBFSVBMaG1oR2l0MjBJK0dRbHpI?=
 =?utf-8?B?a2xkN29WQXI4TVRkWTRDMzY4aHV0bVZoVXY4MldMa0duZksycC83OHdiTXBv?=
 =?utf-8?B?TXBYYXUvSGRzd0dVb1FzaGhmcFBNbmJiM0VaTG5jampqcGFjSURaWHBrQm9H?=
 =?utf-8?B?enpoMVo5QmFFTElQSkFLMlFUckdPd1IrSm4xR3AyQUwxd1BjUWJmcXFCbmtW?=
 =?utf-8?B?Znp6MXo2OVE2cDV5MmZseUJDMExScExNZHU3WXoybzBobS8zNkJrRlE1Q2sr?=
 =?utf-8?B?VTJodldIaDJuTklmRE1CM3FVeXl2NUVrK0E4eFZHM2VCUEl1bUlEY0xia1Nj?=
 =?utf-8?B?UVl0UDh2c0pYYTI0Vlo2ckhiOVNuclJIZnlWNC90bGE4RGZ3UTRyaDRGa0RB?=
 =?utf-8?B?VjhwVmFCWFcyT1l1Z3VLaDJkMDUxdmFEcFcraWg2ZnEwZ0c5RXFkRGZObEJ3?=
 =?utf-8?B?NEZObDFvYU5McUJVd1dtRXJzQVo2THJ5TWtma3V1TUxqUWErR0Q5ZklyQy9U?=
 =?utf-8?B?SU1DVTlYNnJsMmpuTmNVb2orNnBCOGFSZUVOQ1JORFJhRVpIRVhXZkpuMnJG?=
 =?utf-8?B?L1ZqRmJuWXVFRFJjYTZadGtnR09sRjd1T29IWmVqKzZCQkZHOC9SMWluaU90?=
 =?utf-8?B?ZDBwQW5PdXFTTkJ5VXFodGhJODY2ejlMZVprOVlRQ3FjOTExWW5SSEhlcXBi?=
 =?utf-8?B?NHJJNVAvWDdNVklEb1dMdWNpbzl6bnhFUzRmWFVHaXVmZHFCS2VqU0t2RUR4?=
 =?utf-8?B?UExyRWZGc3NHUTMzOVo4YTY1WEtIalVjbG1od2ZuK25zVkV2SVFrYmgxYmJj?=
 =?utf-8?B?TWh6Q3plQnlhNkx2aXl1WWpQUkdiV0NtM2l1UUgrNnlaaC8yRFpxRnpqMW9q?=
 =?utf-8?B?UkFvbks0Vm95NkFxd2ZZOTVoQ3ByVXljSVl3b1RPbEZNdkY1NjZrWDVSOXJk?=
 =?utf-8?B?Q1lnZkxYWlE1TjVNbFhOTzJ6N2RaVkJtVlNZZFJ6bEV6VWgyVjlnczNUc0x4?=
 =?utf-8?B?Y3BsTWsrUTRvQlZ2WkhUK3o4Q0g5VGhPNngwc2d5cnhFcStPMDhBMUZ4YkpL?=
 =?utf-8?B?QnU2dTB3QWRBYUE4TE4xa0dzY29pcCt5UGNqajZ5akhwSnNPVjBBRmR4TTlP?=
 =?utf-8?B?S2dmYjFSdUMvaUVHZ2twRnF5WkhQanRycmxVVm9tM1QxU1NRcmNDUFp5dHFF?=
 =?utf-8?B?V1NYNTdoRDFVNmNDN2ROYXB2bHZGK0g3Y1RFNGxkK2dUckJWdmYzb1Rjbk41?=
 =?utf-8?B?dGY0eVUxTGRmNmpZbTZ4R1JJOE8vbkxxRmhQSFVTQU90dWR1eC9MakNiSzRM?=
 =?utf-8?B?dTFsWFpnMytDNEFTN1h5YkhacktqYXppWnFodnU0RGMvQ08xWEE0M2d6VXF0?=
 =?utf-8?B?UzRUZ05xOWlMbSt6YUZlZzgyNTJSdjBBc0NjUlBqWGhRUXdUM29pbGYzc1Yz?=
 =?utf-8?B?TEJ6SEFLSC9RMUxjb3o4RnZ4ZHZGd25KU2x4L3lGR3RJbWR1YmF2WXdyanBl?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15764EF53F4E244A8EF22A6F651C06FD@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917c1021-caae-4aad-2839-08dd5b4e69d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:57:29.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cd1zm75Fd43ADTXb1cCjO58PBW6mWxIwiM08tFiJAXDvYSHGhO6l4R7bHALYkZ5YB4KnQBDrkVygh8GU0I858ZAZoZacVqeV1vpjEp8REiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7813
X-Authority-Analysis: v=2.4 cv=Ltxoymdc c=1 sm=1 tr=0 ts=67c74d1b cx=c_pps a=yMWSg8qzqeR5zS7X5rtM7A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=byNofd0uXsIOtTMM-lkA:9 a=QEXdDO2ut3YA:10 a=ardqhNu-6oL_yQwRi0m1:22
X-Proofpoint-ORIG-GUID: a5zLWwIIrvI1CfdE0AgYdQ3KSDiEqOpf
X-Proofpoint-GUID: a5zLWwIIrvI1CfdE0AgYdQ3KSDiEqOpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

U29ycnkgZm9yIHRoZSByZXBlYXQgbWVzc2FnZXMsIG15IGVtYWlsIGNsaWVudOKAmXMgYWN0aW5n
IHVwLiA6KQ0KDQo+IE9uIE1hciA0LCAyMDI1LCBhdCA4OjE44oCvQU0sIEp1cmkgTGVsbGkgPGp1
cmkubGVsbGlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJ
T046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIDA0LzAzLzI1
IDEwOjMwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToNCj4+IE9uIFR1ZSwgNCBNYXIgMjAyNSAwOTox
NTo1NSArMDAwMA0KPj4gSnVyaSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPiB3cm90ZToN
Cj4+IA0KPj4+IEFzIHVzdWFsLCB3ZSBoYXZlIGVzc2VudGlhbGx5IHRoZSBzYW1lIGluIGRlYWRs
aW5lLmMsIGRvIHlvdSB0aGluayB3ZQ0KPj4+IHNob3VsZC9jb3VsZCBpbXBsZW1lbnQgdGhlIHNh
bWUgZml4IHByb2FjdGl2ZWx5IGluIHRoZXJlIGFzIHdlbGw/IFN0ZXZlPw0KPj4+IA0KPj4gDQo+
PiBQcm9iYWJseS4gSXQgd291bGQgYmUgYmV0dGVyIGlmIHdlIGNvdWxkIGZpbmQgYSB3YXkgdG8g
Y29uc29saWRhdGUgdGhlDQo+PiBmdW5jdGlvbmFsaXR5IHNvIHRoYXQgd2hlbiB3ZSBmaXggYSBi
dWcgaW4gb25lLCB0aGUgb3RoZXIgZ2V0cyBmaXhlZCB0b28uDQo+IA0KPiBUaGF0IHdvdWxkIGJl
IG5pY2UgaW5kZWVkLg0KPiANCj4gVGhhbmtzLA0KPiBKdXJpDQo+IA0KDQo=

