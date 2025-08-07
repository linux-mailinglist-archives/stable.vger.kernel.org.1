Return-Path: <stable+bounces-166808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBDB1DE53
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 22:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F0E72150C
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DD1F0E50;
	Thu,  7 Aug 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Lj6zlb0o";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="COTQvskh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9695CDF1;
	Thu,  7 Aug 2025 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598796; cv=fail; b=WYr6pN0snw4VMKEJDUI+I7m/2KRHo6eZKrlztJT1eTNujGyOSJZ1v9/wcL/fQ2zo1GIjP9/bUYkTC7Nq5a0Rgmrb1QFHlAxlQjRNvJ5dXZGvFn3jX/BJdY0liLzpqRfHYyIMy7UPT8STY8REMGs4YFmVXxvbBA08zrVlbUzFQK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598796; c=relaxed/simple;
	bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+Pnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxWsnpRbCjIUZwjioGXaK4gFY8unrBcOC9PGIc5lSR7eJMgSBDlnVBLBNRRSPx/2VT7a5N2QvaXi21SP+ZrlSYW2w5OyZyIajBD4T5IJoXFkfxgLMuHiqE/WPIQ6sFqh0THuelqvp1EAPIgMnyuYDLrCJls4Te+uQPDQWNpKHME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Lj6zlb0o; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=COTQvskh; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577I0OJJ015315;
	Thu, 7 Aug 2025 13:17:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+P
	nc=; b=Lj6zlb0oQ3Ezw5rE94m0kZeViy7vGTXZz9tiJksC+W2TWYBxaLxB4lVxr
	f2qnoU4EY5foo8UfGgTwiZxw3YA+Ix7ce4af5r1gKUrjKtZ+ErZMC46Rm6XRW4t8
	tzMs2DDDqioH4r9MSy/4/esigoS4ilS29NNXDN/P2aF7WGQF19zbmL61dzuqW3yo
	050MlyOjXW/ZdfwyNZPARIsxXhfDYF4nufCCsA8y/z9VGSofX6VwlVXyRoos9DFk
	NqZEqyICdsbCKsHHWla3+1r3u23Smjfy1scVU/m8rMqqU2+4mbfRsEXI5WCxf6j6
	KtEfGO1l+svjhcaNrFJjVYn3Mp+KA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022080.outbound.protection.outlook.com [52.101.48.80])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48bpxr6en7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FftGj3vaadQMHHw8y+nvcIHL8Qmgi15IRidIRPmW1hZHy1BoUHN9Q2W5rGbJscVaSmkE1bOhtRPupC/L9Y7T/S4yhX7xZnwnTd5jAQkfpG6m6ILxUzjNXSN8trsxhv648Fxlt2FAOVsRW0/oQMhhg908WQmfWo3+Kja70iHiQ9UVKDb+DB5yKZdZGmGn/LhYiu/+TUHe9x0rrQm4CAU6i9ieLOEmt+czFIX/3BX2Toli77mMAucunc0mupnF/ZAtFesNIsR+L5f5nomry/r8QIIolrbiikqy4YNBsxTs3SKAsdP6DgExL/xN8fmwCMDfl6aX8rC5KvKDAaIiHGPl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+Pnc=;
 b=bNdcm6RIcR689szVm5gAAJ3/AsdtxSUnfJ+uXZnUozwGjJa5pvy1TLRnqC+SeRlqn7NvaiwkTgAgVoj66Hnh5lMmxGl3fBfSuUoNowNIAepLdL1sHeC6Sjhn++UQ1dnQ2ayucrlCA9heWnW2qveFihaLObT0w0XEfBHrIwbt/V3bOgpV+nil70X6pOboHp+WRxDJ94iCgnqNB7fD8mGYcYPs+lDPz5TSexVQxe76+ivJ5DXiq2gvquwF5LKEuAPA9VuyR0x7GT7zOeSSbgYs6syTDdS+2yorZYVRIAOYDIOU8P0NE5k8RkZM6fkfVi/14CUt6Gqx/TSLvnhVg5NUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+Pnc=;
 b=COTQvskhp2e8LsYdn3Znjgyxiu4vdL1Hy7DrxI1PRhB16m68XHdcjgD3PARq4OwWRr1DJxvZMiXSg38NpMH5y+63D4Z7hYUDcxFSTY8RaOFw5VQszQwVMJ/khbbeWiJ00mozBWwUV6Tn0xpAJltGVkmpr0p5WqbhZlmNnlnwrsP/BcrzsbLJ5ZZsmYxNbHY4AFSY6C4DB2tRndDFXAApC+eZGRl6ccWkpckPsos9H8CqZOs/CG2mbfMY77O5RHD/f6Lnm8QRBfKjKyd+xkhBwOPGhkUWrZcXOJQAudTT/rEKzmSPYe1A1bsHcEduVZJwcX6f6TmM/Ufext5FijGXRw==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SA6PR02MB10597.namprd02.prod.outlook.com (2603:10b6:806:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 20:17:15 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%7]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 20:17:15 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider
	<vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/deadline: Fix race in push_dl_task
Thread-Topic: [PATCH v3] sched/deadline: Fix race in push_dl_task
Thread-Index: AQHbqEHDoNXScEWh/EuHrNyOcSFdgbOa0PiAgL2FwgA=
Date: Thu, 7 Aug 2025 20:17:15 +0000
Message-ID: <57DC8B3D-0FA2-4836-A476-4C3104046C88@nutanix.com>
References: <20250408045021.3283624-1-harshit@nutanix.com>
 <Z_YGW8IrRQfhfdM8@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z_YGW8IrRQfhfdM8@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|SA6PR02MB10597:EE_
x-ms-office365-filtering-correlation-id: 2faa4a41-6d10-4876-35c1-08ddd5ef66b9
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFNvMGEwVE5ObENLdWlkU00yNndqWFhpanJoS3J5QTdvc1NkVWJJWk05TFRG?=
 =?utf-8?B?WlA3b0lVN0p2dFVPUmZzRmthU2FxWjFtcXNhUjdNUDBveUswb0hqaERsY3pa?=
 =?utf-8?B?SHlBbUFCNVhqU1FzQ3ZJblIrbGpvZldWcWhUZy8zVzdYYy9yYUVtUkV4bjJY?=
 =?utf-8?B?VFNmVVQ1Y0RUL0hKcXBhMGVBNlJmMER3Vlk0OVJ1M2JHSkVrUGNZREpTeDdI?=
 =?utf-8?B?L05tTCtZNGhRdHlEZ2pmcEx4QVNhRjF5U0FLREtFa3B3UGRkMkYzTnJ3NzlL?=
 =?utf-8?B?T1RkSEw4ZENKRlZkL2l4V1I1akl4dm1lL0lYZkZ3cHdDRkJKL0VtQVh4VitM?=
 =?utf-8?B?bzE4SEpQSFRMZDYyelFpVWdiU0h3R0NPcDk0Ulk1YWFxWVM0SjdEWDdIbHdW?=
 =?utf-8?B?RU9Sb2czUkxSWGtTeEdTQXlCMmJ2NHhlVjJZUGhINDc5aFZaODgwRE15WFFW?=
 =?utf-8?B?MVJqMTFvcWgrQWQzVWhTRG80cm5rbmxCUlVxTzVZY01kMWFMSWtMSzE5dkZn?=
 =?utf-8?B?NEwzNUQrdVU4V1d5Vmg5eW5TS3hkdDBHYlhwOGFUQUZsTDZubjRCczFvM1Jn?=
 =?utf-8?B?bVVGblBxWDA3cGFJRTVraHZwbFF4REFWVTRnRDR2Z3pLSTN4NFJkVTJGZjFG?=
 =?utf-8?B?NGZpMGtneVR5REEyNEFsc3JOdk1mc1IwZmFkdjNiZzBYMUFjdWxiNlZDWEV0?=
 =?utf-8?B?dDFXdFRkS05kSVdPZXV2R21CdjJZdGpmSm1BQnRwM0EzWHJqMDlGa3lDL2Z3?=
 =?utf-8?B?YjZOdDM1Q0xGbHlnYmlINlZMajJHUEV1MnNHaE5aaklnTU1sbjEzR01sNWNr?=
 =?utf-8?B?U2hWNGdLSkljcGVOTkM3MVozOXBUOXdlWGJubUp4SXhVaHVuQVVQQTduL2VM?=
 =?utf-8?B?YVdOaFExS3FyVTdCWXI5M3k2TjFUeURXOUR6Q25rUXlNUlFQWmpKMUN5bklR?=
 =?utf-8?B?SVJGNE0wK0V3WjBWMzBSaFZKczJQMkRqd2d2QmlwejNtQUo1OGJUMElvSXkz?=
 =?utf-8?B?eE1GQlZibmRRY29lQ1YwZjZoUmNET2Z2NitDR2liU3AwRjJvZjlRK2hjTmZ3?=
 =?utf-8?B?aVFkWi9aMVJlSGZqczZvZzRaOHJYL1p3ZVFESS8wVkZDR3pZUUpSQW9SZGgw?=
 =?utf-8?B?YWVJNHNGSnYxL2NCUCtUS3VZeFJkeGY5MUdFTTZONkt4cFh5U1k2OHJGTG1J?=
 =?utf-8?B?WjZMY2pSejNCN0lubUpoRVduRGJtcEYwMVE2S0lqVWM1M3hha3hGMENvOTVN?=
 =?utf-8?B?QVF2enhWS1pDUHR2enIrbERKdHREUm4rRWhKS0JROEdoa1JWYUdYcEFrSTNw?=
 =?utf-8?B?Z2xYdjYydmJEeURwK0NFNHNubHpsMVdhZlRxS01LeUdEU1dSdVdwN3RZVzhS?=
 =?utf-8?B?VHQ5a3dST296bkRkZEJnOWwreVBRYmtRTnNpQlI5T0Q4MityeTN5WkVKbHpO?=
 =?utf-8?B?R0NHTXoxcTVCS09vNUE5ZmdaMzA1ZTI3UVhYR0xyVzdMdXNnS0gvQ1VVMWtV?=
 =?utf-8?B?YlBLM3lzL2RYV0g4aDhyOHR1SksvVXIxeXZGajJzR3RaMnZIZ3hFd0FZYXI0?=
 =?utf-8?B?b3d6Ry9vQWRIb3ZNc0Z3RE5IcGljUWRMQnZEKytRL3NzOXpUc1U0U2VVMDZi?=
 =?utf-8?B?TW9ORVZUSUIwaDNycHNFMzNvNGptRzVsTTZJeThTOTRJU2E0RElZUWl0TFNK?=
 =?utf-8?B?d1huTThLb2dpRTk4bkZZLzduR0NzQkFWbVNmQkQ2QlhiRlRGM0FIdEdQdnBI?=
 =?utf-8?B?SGNRVTJxVHBUWkVhRGoxdlN1V2dnS0s2SHNHVlBNTkkzYzhLYldZVUtQRnpU?=
 =?utf-8?B?a1ZWcDIxaDd6QjJKaUhXYTBDK1pCaVdlQlpMYUhlRG1JRFQ2YVdnTXlFVjNs?=
 =?utf-8?B?QnREVDMvNTg3YUxGM0lwUXNWU1didmtXUU5VQXdnSitzOGc0QXkrcnZMMEFs?=
 =?utf-8?B?TStteXVNUkFNMHByaEF6b2V0UlZ0djgxK2wxdXc2QWtadjRZVGxMVysraUdu?=
 =?utf-8?B?VkVmcUpqNVVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TU5TRnhPY1h0cHJVUlNqQzU2RmFqQnR3eEg2Z1hKZU05bGxrenkwSDI3VFFI?=
 =?utf-8?B?Mm5FRW5xcy9iVktUcEVSWlFOYWxoNE82b2YxQ1RBT3RKaXBLL2RoRlgxb3M5?=
 =?utf-8?B?dEVBeVVldm1wRTJWTWN3LytuL285ZEw1RDZhQ3Y1d2pzUmkvRDh3bjN6d2pz?=
 =?utf-8?B?LzYrQjlwL0FKcGNzOFVMSGlrYkY3UE1qSzZhYVpkZkNzMDlqN2JIT29VUzNa?=
 =?utf-8?B?N2ZiRStJWEpYbXkrV2NuMDRBdmdrdDJKWkVndXZkNkxFaUNCaWNKSkFIelU4?=
 =?utf-8?B?NHJwZGdBdWlTMkZLR3BkMFNJN3h4VHZVbm9zUE1jWVFESkk3bEowb0xkMStn?=
 =?utf-8?B?VERwaGY0TDZ0Yk9iYS96T1cvUTBrZ2QzLzJnUERtUit6WGRYQWdDQlovRkVB?=
 =?utf-8?B?T1RJTEIzZU56Tk92S3hGdzN4V05QdWp6WDZFV0lOcHIrN2cxb1dodWVCR043?=
 =?utf-8?B?cThEalhtekU3UEhBUlRqaERJV3c3VDVZdnZ1aFI2VS9VZWV2QlhSOEFmejJl?=
 =?utf-8?B?VzA3MnVyZjJneURsOHgyMWxjckFBdCtEY2JDZTF4S0UvWUJrWTA3YWhwRkdG?=
 =?utf-8?B?MUJJV1J2V21xTkgyc1FOckxmd0VBVlo4VXYzWmJsckRRM0M3Znh1a3pJamtK?=
 =?utf-8?B?YlptRmhPWFpyYyt0VWJKUUR2U1ZXejJBRFQyV052WEhUcURhb1MvZFJYOWxh?=
 =?utf-8?B?YXNaN1pNNWVJOVFOVU1Gd25BREhaRFVPSmQzcXhaMTVVNTJsdHBiNllZdm9S?=
 =?utf-8?B?Vk9UV3UrNGgwK2RselpMZlBDVnRaK0piYXpKVlpiNGdtd0E3UWdtN29UU1VO?=
 =?utf-8?B?bDh5UkI3RlAxblNPSHpBT09iaUJySUc3dm4wQ1pLakNwTDdYMzFWV1prbC9a?=
 =?utf-8?B?RlBxWkZaTFZ3TGZYaHBBV2htMkpXT2taY2RGMkZ3a3YvaXdtZGNDZTZ2cEpa?=
 =?utf-8?B?T3prQnljZkVDZXpldkw3eFNna0EzV3BEWDZKcHc2OVRBTGFoMXVWL2VXSzBz?=
 =?utf-8?B?YkZUdXNtRnJlZUVmTndrNTQxaDF6VC9uZlpiNjNCMW56Y1k1WGRjMWlCOXBE?=
 =?utf-8?B?REV5dTVWVzhqR2NVUW0reDFZMXlESHhnNXJXQlhvOEtheklBbkFUem9ISHdN?=
 =?utf-8?B?TGR1UTFtVnJySWp1ODMyVFhITkdFbXh4NU1Ub3JFZ0o0VnczLzlIbDVldWdU?=
 =?utf-8?B?UGN5V3RjSEcwRGVXZnVMaWJTN2FXTXo0YkxtVGU2YkEzdEIvWUhiQmVjclFw?=
 =?utf-8?B?dWFOazB2MjE0SHdNRDJmVUVka3FzeVBDMmtnbEhkWnlJQm9KZ1BTS1RjakJp?=
 =?utf-8?B?RE5PaTFrSDZFaUkxRDY2OFBpU2ROWi9xNlM0VmlKNlgvcElHWXo5UG5xT1ZQ?=
 =?utf-8?B?NnVHRVN0VnV5Vllkbi80R1BQckNTUGhsUnVRK3RwRk9pUS9RWGJkdXU3SThT?=
 =?utf-8?B?SmJzM29mZ1p4andpd3NwWFl4RFM2dllQTE1CV1ExclhpWVA1K29scmt4NUkr?=
 =?utf-8?B?MitxVEJCRmFuWDBPcUpCcTNFRjFmbWhFTjc4cjYvNlA2ZUpQd3pJUGNLMHZn?=
 =?utf-8?B?eXFvRjMwZHpIa3dsS2JqcjFuWTQvMUYyb29ZTk5adCt1RGZNMFZaZkR1blJF?=
 =?utf-8?B?YmtUZ2F5cytVRGJaZEpaTXJNcXFsaVhvclpEb0RHaVo4RFFEVEZpUm5yaXN6?=
 =?utf-8?B?R3RPNXl4WWJtRTJuNUFrKzZybU5aM0h2UnI5VVBFcWZBQm5HeEkwTksrYk0w?=
 =?utf-8?B?Um9MS1lWTVF0SUlpN0tkY3JPcDFsTExCMm1majB3Y3BielBVMUh5UVVRYXUw?=
 =?utf-8?B?WUZ1eERTTHhDMFpNa2EyZ3Byb1BkMUJxRVBaNTU3bmNoSUlBT3lXQm9FRC95?=
 =?utf-8?B?bmRhTmZzSTlWNi9rMEppZFVWVUN5MVZyTGNQdGJjWTU2MU8zYktZMDFwMnlV?=
 =?utf-8?B?cGJHY1NrYmd1ZjIxNXI4c2wwWWVXOFo5dHVCaFh0QlMvb2FsNlRpdTFiU3Zp?=
 =?utf-8?B?UEhLdzYrMVZDTkhRcEdpVmRtSWt4cWcrZCtZbkEzZVFuKzBGc1g4a1h3cUxD?=
 =?utf-8?B?dTU0dzczOEhpN1Zaa050M0swMzMvcitsTUNTbEJsV0JpampmNytzMFl2TElq?=
 =?utf-8?B?d2FFRXZFRDBCSEFpb0Q0RnEwWWNRNkl6Yy9oOFMzRGZteDB6T1M5OUJaSExz?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AFA39464AD5014A90E5715272D55900@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faa4a41-6d10-4876-35c1-08ddd5ef66b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 20:17:15.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhYSQM8qy5fkHlmMTRmPIOERkgOixy9e+IVpTsMp1o6+ImuOBAN1l9PhOcRozqRJUrR/7n8DeF94+noxEEDqkUImemNMIIwKZEUIsiJqfFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10597
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX6YGzx/QkpkVL FYp9xq4TP9DdNavOCaJZG3SqMsz09y5XRPnlsljDVOIYgQu0+YV0v1lWAJrNgnuH0qp9mCWp0/m Zbc87cnwN8AwPR3UePoLwNflsMqU1MsJkaii2S6Be7dY3b5wnzoy9tLvuQkg7iuvo8LXk+hzzMT
 IbxTA4ZC4jXJmY9z9IVHdLBS354HAVle42GrjsOXs1y+n8+0TxAPzDZFFpTySa5RiKK+B6pHrCF Rz/3CktCGBhhACUzObeDVTyY1GIcS6G5yGZ3/Vqtvs2Tf9WcXawf1UwXXQui6sjiPdkgOf5XF0C mEbfVDIPIRm+uX0QwL2fykXMghqFMZOnuHi2magEPwJYHoJ/yDO5q8k4Q2yH9OJ1kfm/2dJ0t6p 8GKuvhTW
X-Authority-Analysis: v=2.4 cv=IO4CChvG c=1 sm=1 tr=0 ts=689509ce cx=c_pps a=l7AlRFJyJD7ZaDWTaO3eeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=8FvfGRrCr9yIXM-yq5oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -9GxWTtKMty8mIarp3EgcNorwOjCe8Ir
X-Proofpoint-GUID: -9GxWTtKMty8mIarp3EgcNorwOjCe8Ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

SGkgUGV0ZXIsIEp1cmksDQoNCkp1c3QgYnVtcGluZyB0aGlzIHRocmVhZCBzbyB3ZSBkb27igJl0
IG1pc3MgbWVyZ2luZyB0aGlzIGRlYWRsaW5lIGNoYW5nZS4NClBsZWFzZSBsZXQgbWUga25vdyBp
cyB0aGVyZSBpcyBhbnl0aGluZyBJIG5lZWQgdG8gZG8uDQoNClRoYW5rcywNCkhhcnNoaXQNCg0K
DQo+IA0KPiBUaGUgbmV3IHZlcnNpb24gbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFNvbWUgZmlu
YWwgbWlub3IgdG91Y2hlcyB0byBjaGFuZ2Vsb2cvY29tbWVudCBtaWdodCBzdGlsbCBiZSByZXF1
aXJlZCwNCj4gYnV0IFBldGVyIG1heWJlIHlvdSBjYW4gZG8gaXQgaWYvd2hlbiBwaWNraW5nIHVw
IHRoZSBjaGFuZ2U/DQo+IA0KPiBBbnl3YXksDQo+IA0KPiBBY2tlZC1ieTogSnVyaSBMZWxsaSA8
anVyaS5sZWxsaUByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzIQ0KPiBKdXJpDQoNCg0K

