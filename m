Return-Path: <stable+bounces-148096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD8AC7E65
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37438177422
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94B221F18;
	Thu, 29 May 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l3a/sI69"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050FB4C9D
	for <stable@vger.kernel.org>; Thu, 29 May 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524081; cv=fail; b=KVV/eQti/AO8REQ435DLsPm3hWzW9NmvALSU2VDiYYMDuscdavtAIF0H7lh18HcpUrzwdepaIEwdVdf7fd2cY7fUGQ0T+7prDyfqblLUQcsZPHwXI8vbh3U00l7fcYz3/8JWSMRyZW4gL1p1tAOQokZneXEKlj8ErFAVbOnLdZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524081; c=relaxed/simple;
	bh=P9cglhpiwKriL7XvQgYLvADHW/gaGa5IJwK5Yl2oTy4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J563dE/Dh2WombFH3k/JolBSfx4UNFXdve/sikNG2cEGT37d9sZrHHja5MOOADky33329OW10t96gz9RmhjuCRZOB8/72JNxbVBwAyVKhX738UaaJNttvytGn2cZm13W6BV+Vheex9hldnhzqkbKrjJxHoqu/cW1xx1tTxOYMok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l3a/sI69; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAcySlBl0AiBTSvXrkqIx5wNgZC6kisreh4Oyi53D/X7CRfvjEqfibYBrRegDj9u41Pn0bbktQ1eUneOro1UX+Y7/hDytzx4j1ql0NpbDIP4hX0QcwztoaCBbxGB64h3ZsgC8v2fhmUt0TdwFogGO1RN65Wp+fom7tYmO0iYjx4vvRgJWRFByVNgLUcxDtO4v+OsdKIr0j6hUHjdWx7d9oJMmfc9Pt5JVTSoQAis1KdV7p2SE5NnHw3k1ZfccEw1tZ5AAyszxN57oyYkC78Jgjg+2xPFyNFQ9fOY40ubw8akYvKjxAeHM8KpqiLxEd48oYWa9U6XaKmPTyPGuE6zJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9cglhpiwKriL7XvQgYLvADHW/gaGa5IJwK5Yl2oTy4=;
 b=fwVD1Yzexllujh8GWSkC0HomUmXVmrv7tGXP3DJheqnLDcBumFV7d0IQhgspQWb50E+0xvaJWl1iD14zLhDUnvjlaMOnZ6AcciCAht0lbc7lrwUXi81bBU/ejzOW66wc2WXDpR3g/azHh/iI0qatMjVXXFHLWbzkGQdI3MGAb/2jzjVEwaP+6QJZokOBVjr7M32PINj2xHTfxx85yz+0SbFHYpA9mBiBcWzN2AO6QYcAISyy8pl9fBU95IeZ+fq8C7tJHGNoZ8MOCCkISI0zjyZPh3oeRqvsBsCQHY8W+oxAxvAIE+qJ3GaHogf21AlfOEkjxrcGuGdWa8B5FlH1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9cglhpiwKriL7XvQgYLvADHW/gaGa5IJwK5Yl2oTy4=;
 b=l3a/sI69PctfBZewyOi72HpaCS0eiaTnOvo3JTE8cEw6CpOYZMBQ4u1Imr6vLSFNYfxE9YPp8eqMz68TMxjoXA3y2pLl+IWlRJoAIdTJ747LPw6GyoLPHlab+Ac4clCGeCicmzFoDpbVhfMinKkNEhOElKo8zCESfOLR0jGE+CM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 29 May
 2025 13:07:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 13:07:56 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Rainer Fiebig <jrf@mailbox.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: 6.12.30: black screen after waking up from hibernate; bisected
Thread-Topic: 6.12.30: black screen after waking up from hibernate; bisected
Thread-Index: AQHb0IkpdzcMfPM6ekigRJAqaV08P7PplFAA
Date: Thu, 29 May 2025 13:07:56 +0000
Message-ID: <a46d63fc-3012-4bfb-8e88-aa7acaee5c36@amd.com>
References: <884d3e56-1052-0ca0-2740-f597ba7031c1@mailbox.org>
 <BL1PR12MB5144454EC2C17C206CC68992F767A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <bcd38e08-d1c4-ee9b-e96e-ef369bfe280d@mailbox.org>
 <2d23038c-1dfd-678e-d0eb-2a474e84dd1f@mailbox.org>
In-Reply-To: <2d23038c-1dfd-678e-d0eb-2a474e84dd1f@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS2PR12MB9589:EE_
x-ms-office365-filtering-correlation-id: 37eb4036-8cf5-478a-5abb-08dd9eb1d451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2ZoWWZET1pFL2dXSU5pMTUydmVJbENhZDdvNEI0cmpGNjZVM2hkR0tqdmh5?=
 =?utf-8?B?Rk9ldXRka3ZKWWFCUUp5bkxRampwOHQ5OThBL2d2YzJBN1NxZmdhbjVSQnRO?=
 =?utf-8?B?QWc4enA4QlhZeTlMMXJqNGtKNW84c3Y1cGpRNGlZdHUrb2ppbE05M2ErSGdu?=
 =?utf-8?B?ZmowMXVmWGhNQ0NuYlFJL01HbFRPNzUvOTM3RDVzNWpOM3g3cVFBMnpBZnVL?=
 =?utf-8?B?bkRqeEF0MWVTdzgxUjliUVU5QzcvVWltaCszWmVneFpNNTA3WGhlYTlsRzNs?=
 =?utf-8?B?UmhUSXh4dENWYUNmTTNkZVo3cnIxSVpVUlQrM2JIOWZ0UlVoREgrUHNDdU9z?=
 =?utf-8?B?azljaURSS3BZbkh2L2hhY2JPcWlqd1AzbTJyYkh5K1NMWmZYQzRVRWJTNDds?=
 =?utf-8?B?T2RkZVowN2ZOS21UNVRKNVhrODlWemRFMGJOUHlLcmd5Y1V3TFI4TzY1SHNu?=
 =?utf-8?B?Q3VyRXoxZmpJVW4xcHJiSmVXNkFuYm5YcjRaT1ZOWXlSTGdBbldnU0Mxc0U0?=
 =?utf-8?B?YjE0Qmw0azRsc3h4R2NuVHBUaFU4ZXRMcTlvcnk3VUFVS3FKS0ZQRW5ITVZR?=
 =?utf-8?B?cm5pZkI0QjViTy9PdDdWc1d0QnNEQmo3LzRJL0twTzhTSmVtLzJrcFFuYy93?=
 =?utf-8?B?Rm5KL3JEMGlnZ25aTVh3ME5nTmdzV1o1VnpTajdKK1pRQ1QwODJPVTFrRVVz?=
 =?utf-8?B?UHNQS3JhTjBwdGRxYTVSUGluZ1JiUmZQaGNQMnNPcElhanpUd3ZNN2oxQjRw?=
 =?utf-8?B?S0VrK3hGbUpxREErdFhaazZEQVQ2RlNQUWQxaWJiYmQrTGRGeGNHL2pNdjFv?=
 =?utf-8?B?bE5Sc0Y4dEJtWWJVSnQ0RWtLcFd1OSs3L1pDNzhMRGlyaFZad2tsUjRpeVF6?=
 =?utf-8?B?WDBkeC8vUTB0dTVEQXNGWis1TG5kRzFveS9udzU2c05SNWFnZjVwNVkxL1E2?=
 =?utf-8?B?YUczbmRPT0RLZ2NPQ0JaRVhBS2c5MXFsamUyL1BhTENqWGtkOXc5bW1ETnBs?=
 =?utf-8?B?WFc3dGxETFNvblBaSXM2amxnYm9veDA1TjY4eUo5eFBUZnlXbU1sR3JWN2Ur?=
 =?utf-8?B?Yjg5U3BDeEVyM29FdnVIK0E1QU9JMjlaUFlNWTBGQnIyZCtPZTRJOHVuYVhG?=
 =?utf-8?B?TG1WZ3NaMGp4RnRuanJSb3hRNDhFbG52VVhrRjJNSVVIL3FhcUtmM25aNWZT?=
 =?utf-8?B?SnJFVWhkMmo3VjNWTXRhQWVHNUtwbzhNMWtNZUEraFhQODU3NldQK3NNTDRT?=
 =?utf-8?B?TlN2aytqYlg1aVFoVE9Uem9UU3EzeW55Uy91TUZxUTdMbjJtLzlkN0d3ZHlo?=
 =?utf-8?B?dUxKeERTa2cwazAxU1VaYVNoVHNvVVY3K3JIZ0hpV0NjclUrZEFqZGd6b0JK?=
 =?utf-8?B?QXgrSHF1OGFHaFNPS1NoVUx5cUFqaEk2TE8rdVBTd1ZIWExVUFEvN3oxQ2NC?=
 =?utf-8?B?VkZoUUVxaFFKQkZGdjZKTUxIL0VZNmI3RFNrSGRyZEVqb0J5TUEyYkI5THk1?=
 =?utf-8?B?WmtJMWJCYWxJU09XWUEvOTFBWHBHTFhyclJkUE1jaDFFWlJoZDhDaEovQ0tx?=
 =?utf-8?B?cmViQ3AzUVhNNnlCM0lmUnpJeGFhQ1I4aXlheG5DKytiRG45MjRkcWszb3VT?=
 =?utf-8?B?U04ycDZSQy9HdGswV1QvOFdFRmhjS1BiTk5kM215cDhyZ2ZSaVZ5S01EUUc1?=
 =?utf-8?B?eVhaMllzQzVOcFRBS0ZUMnp2UzVNaHYzU2Y4dTQrZzl2ZENSQmY5aW9GM2g0?=
 =?utf-8?B?TTVsc0RzcVlpVTNiSUZUWWdEamZWeHdkdmJSYkNPK2JXdS9wWU5SZjBvODJN?=
 =?utf-8?B?MG5ZYlBNVjF0L3dVUUhCQ29rbFBYRGJRWFRONWp0QWE4ZmtKNHREUDFjL0hO?=
 =?utf-8?B?NkR0eVRxT0ppbnBPL1RTc2Q1OHpMSlpxYUlucUozNGNhelBtR24wR3JWUXdZ?=
 =?utf-8?B?bHllU1d1dks0VFFDVXg3Z0J4UW5tcnZsMHhWWjJvdlUxTmp3elBWV21QcEo5?=
 =?utf-8?Q?DV3aLLhDb74WOirwqAJLVI7UOI/ydA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmVtcjYrZ2FxYUEySDdUaTN6ZVl4cHJjMWdYN0xUd1BuUlgxaCt2U1huVUtv?=
 =?utf-8?B?OEcrNmp3bGk2a01ENlVvUUJMTVo1Y2tRZ1BiS01jd0kzSStNSzdrNHExWG1j?=
 =?utf-8?B?ZEZrbFFDOWU5NXFQQm5FaEFGRWQ0dWdzbVc4a2c1SDBOTVQ5Y0JvK0hXblg2?=
 =?utf-8?B?cVowcW5zam9HV0FFeTRSZ294eVZtaUt6cUhNQWNaejRXQTI1dmRHeDFvSkMy?=
 =?utf-8?B?V2NYZDc4aG9uVFpmUmp6S2pQczFCRE1ucXl1dHh4RE1BNWxDaUovSUFMM3RM?=
 =?utf-8?B?RzNxTzdEQ1JXSHRoUnIyRVR0QVhkbkhWSk04L1pLZ3dlMjY3UnMxZklqcHJJ?=
 =?utf-8?B?WFA0eEhPSVJaVEswbk11cUp3dEFGbzNrYk5FTDNGcmYxTWNSVTVyQTViRVZO?=
 =?utf-8?B?VWlBcnpsamJYUzZTVFh6RFAwR3pxeGEwWVEyVEJhaVhvd2JrbXlTR2xvTHI0?=
 =?utf-8?B?cmJsUVdpcjRDcEpzeEJORFZZNVJ4YkNkTVJ5RmdHWlpZR2tNVXRob09MMnZ0?=
 =?utf-8?B?enJHRzJveGk4U0tOL1RBeC9ibHU0dDhYOXozMHBvV2hiMnpXWjdjN1pIRkZu?=
 =?utf-8?B?M2FSTlppenJ2S2g1bG8vb05DaWNPaGRydXVwU0ZVbmI3Z3FDc2Y4SjFtZjJ5?=
 =?utf-8?B?QVVudUs1d3lqWVhnbTkwUGQwN1RRdmxTYWkyaFVkVThQZlptU044TzRTSHN5?=
 =?utf-8?B?bnQ4UFpIZ25odjVRQkROWWIwNWhuRkl0cHdOSElqd09XSlRZeDNXYmc1eTY0?=
 =?utf-8?B?OUhqNkEwTDUwZFhVb2k2THVZY29Ta1ViZTlTZVd3WVVPNHEweXFpNkNYb0lZ?=
 =?utf-8?B?aUE5RmphUEhBbUkzcndZSktnNjF4VklNTURqSlNmU2V1b2ptTHVSaUZidEFt?=
 =?utf-8?B?d1NHR2JjZ2R3U0k1dmJjNkJlUTJnZVp2bE96bjZnRVErYnlDTVFiSTI0bytv?=
 =?utf-8?B?T2lvU0k0Yy9QL1lXZmxxZDVaOWNrdzlhRnM4c0RPd0JGenRLL0c5a2VCS2Rx?=
 =?utf-8?B?U3ppZEwyeU5GMTZ5M0EvWisxQTRtMlhDbUEwQngwanhIdjdGcE1oVVNHR0la?=
 =?utf-8?B?cUhKMUx2V3luS1pwdEw3MWtPeDUwT29tTVJjUTQraTZvUnhCS1NXUEVOMGR3?=
 =?utf-8?B?bGtqRDNPZXp2T01wd08vaDhsa1ZDcHpmZmFXc1d6dzBoYW5OMitKVmMvZE02?=
 =?utf-8?B?a1VNTkNYa283OVlIVWlNUmZNWnMwMk1KQnJBbzB0Z3lQOGFia1pnbUFYQTRp?=
 =?utf-8?B?amhobTFrejhjU0VHcXd4STdDSjJvaHplYk50YzBQTjhBdTRHTU1tV1E3V05P?=
 =?utf-8?B?OVZ4dnZnM2kyU1NMa0UwdHA2RmpROHhXNkZISUUyL1BsT0F4azBJRDNlejh2?=
 =?utf-8?B?SUtXQ0d0c0N0TThlb0VBSE55T3lHc1Ria1JoM1UyOXRxdmUvcjRYNlJXTnox?=
 =?utf-8?B?REkwWi9JZFpsSkJBNEkyZ052SXhibWhWU1lVRXZPZjhaQUMzT2hIQ2t0bkJ5?=
 =?utf-8?B?cGo4MTBEbVJmOVM4bEdrN1M0SUpTY09YS0FBZk9KU1J4aFA2cTc2dG10R3ZN?=
 =?utf-8?B?M1ZkYzF2ZTJoZ3hOUWZzZjVhc0p4UTRyWEluWEZuSkc3KytHelM2dlBBaC80?=
 =?utf-8?B?RFpSUnowTWFPbE5zUHk3ZWFDVU9vWllVVDVuR0c5TGFzUU1XV2NaTWlRY1Rk?=
 =?utf-8?B?anlRTVMrdis2dzhPNndnY2VIcnBnbEgxVUFaL2tHYVdiUVo3WTZ3bkdNN1Vx?=
 =?utf-8?B?UGNORVM0Smcwb2VYQmVVdVJJTU02VWs5UWY2d3lFY3BublErbVpTelg2STJ5?=
 =?utf-8?B?eHhadTRaTmJCMjhDSGhVelVZcGZ3RXVrQzFEUWNkZWNnZ3QyQ0xORmVkdksr?=
 =?utf-8?B?OXk0R1ZEcXJOZnI1UWQ1OGdyUnU3OVJxa2VFN1ErenhrakNNQkRiK3drVXJV?=
 =?utf-8?B?QUR6eWQ2MFJrYXRCanZiRlRxb0FiNDV6UVZWOTk1Y2RpUHc3M0dhRWtEbldL?=
 =?utf-8?B?WGQrYVpSSVdXN0dNNGZMZHNkSEFrekJ6emxvNDVnSlVYTkFDUHd2VUFKN3VK?=
 =?utf-8?B?QUVWVWxMR3hyc01yb2Y3SWR3K24wbUEvZk42Tmw3REV6SjZockJBQkxWVkF6?=
 =?utf-8?Q?9ZkM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D69E49EFB02664B8B7D1735E5FD1F7C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eb4036-8cf5-478a-5abb-08dd9eb1d451
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 13:07:56.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lP1qbP8e7p0Ytlid8OymHL1ZU0ZLeQ/Vzh3LLp8wUK3eqh1P58s2PFU1qrIo2l1NrQU+bzFBWwyelfkBN1CJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589

T24gNS8yOS8yNSA2OjAyIEFNLCBSYWluZXIgRmllYmlnIHdyb3RlOg0KPiBBbSAyOS4wNS4yNSB1
bSAwOToxNyBzY2hyaWViIFJhaW5lciBGaWViaWc6DQo+PiBBbSAyOC4wNS4yNSB1bSAyMzowOSBz
Y2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoNCj4+PiBbUHVibGljXQ0KPj4+DQo+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZyb206IFJhaW5lciBGaWViaWcgPGpyZkBtYWls
Ym94Lm9yZz4NCj4+Pj4gU2VudDogRnJpZGF5LCBNYXkgMjMsIDIwMjUgMzo1NCBQTQ0KPj4+PiBU
bzogc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPg0KPj4+PiBTdWJqZWN0OiA2LjEyLjMwOiBibGFjayBzY3JlZW4gYWZ0
ZXIgd2FraW5nIHVwIGZyb20gaGliZXJuYXRlOyBiaXNlY3RlZA0KPj4+Pg0KPj4+PiBXaXRoIGtl
cm5lbCA2LjEyLjMwIHdha2luZyB1cCBmcm9tIGhpYmVybmF0ZSBmYWlscyBpbiBhIFJ5emVuIDMg
NTYwMEcgc3lzdGVtIHdpdGgNCj4+Pj4gdGhlIGxhdGVzdCBCSU9TLiBBdCB0aGUgZW5kIG9mIHRo
ZSB3YWtlLXVwIHByb2NlZHVyZSB0aGUgc2NyZWVuIGdvZXMgYmxhY2sgaW5zdGVhZA0KPj4+PiBv
ZiBzaG93aW5nIHRoZSBsb2ctaW4gc2NyZWVuIGFuZCB0aGUgc3lzdGVtIGJlY29tZXMgdW5yZXNw
b25zaXZlLiAgQSBoYXJkIHJlc2V0DQo+Pj4+IGlzIG5lY2Vzc2FyeS4NCj4+Pj4NCj4+Pj4gU2Vl
aW5nIG1lc3NhZ2VzIGxpa2UgdGhlIGZvbGxvd2luZyBpbiB0aGUgc3lzdGVtIGxvZywgSSBzdXNw
ZWN0ZWQgYW4gYW1kZ3B1DQo+Pj4+IHByb2JsZW06DQo+Pj4+DQo+Pj4+IE1heSAyMyAxOTowOToz
MCBMVVgga2VybmVsOiBbMTY4ODUuNTI0NDk2XSBhbWRncHUgMDAwMDozMDowMC4wOiBbZHJtXQ0K
Pj4+PiAqRVJST1IqIGZsaXBfZG9uZSB0aW1lZCBvdXQNCj4+Pj4gTWF5IDIzIDE5OjA5OjMwIExV
WCBrZXJuZWw6IFsxNjg4NS41MjQ1MDFdIGFtZGdwdSAwMDAwOjMwOjAwLjA6IFtkcm1dDQo+Pj4+
ICpFUlJPUiogW0NSVEM6NzM6Y3J0Yy0wXSBjb21taXQgd2FpdCB0aW1lZCBvdXQNCj4+Pj4NCj4+
Pj4gSSBkb24ndCBrbm93IHdoZXRoZXIgdGhvc2UgbWVzc2FnZXMgYW5kIHRoZSBwcm9ibGVtIGFy
ZSByZWFsbHkgcmVsYXRlZCBidXQgSQ0KPj4+PiBiaXNlY3RlZCBpbiAnZHJpdmVycy9ncHUvZHJt
L2FtZCcgYW55d2F5IGFuZCB0aGUgcmVzdWx0IHdhczoNCj4+Pj4NCj4+Pj4+IGdpdCBiaXNlY3Qg
YmFkDQo+Pj4+IDI1ZTA3Yzg0MDNmNGRhYWQzNWNmZmMxOGQ5NmUzMmE4MGEyYTMyMjIgaXMgdGhl
IGZpcnN0IGJhZCBjb21taXQgY29tbWl0DQo+Pj4+IDI1ZTA3Yzg0MDNmNGRhYWQzNWNmZmMxOGQ5
NmUzMmE4MGEyYTMyMjIgKEhFQUQpDQo+Pj4+IEF1dGhvcjogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KPj4+PiBEYXRlOiAgIFRodSBNYXkgMSAxMzo0Njo0NiAyMDI1
IC0wNDAwDQo+Pj4+DQo+Pj4+ICAgICAgZHJtL2FtZGdwdTogZml4IHBtIG5vdGlmaWVyIGhhbmRs
aW5nDQo+Pj4+DQo+Pj4+ICAgICAgY29tbWl0IDRhYWZmYzg1NzUxZGE1NzIyZTg1OGU0MzMzZThj
ZjBhYTRiNmM3OGYgdXBzdHJlYW0uDQo+Pj4+DQo+Pj4+ICAgICAgU2V0IHRoZSBzMy9zMGl4IGFu
ZCBzNCBmbGFncyBpbiB0aGUgcG0gbm90aWZpZXIgc28gdGhhdCB3ZSBjYW4gc2tpcA0KPj4+PiAg
ICAgIHRoZSByZXNvdXJjZSBldmljdGlvbnMgcHJvcGVybHkgaW4gcG0gcHJlcGFyZSBiYXNlZCBv
biB3aGV0aGVyDQo+Pj4+ICAgICAgd2UgYXJlIHN1c3BlbmRpbmcgb3IgaGliZXJuYXRpbmcuICBE
cm9wIHRoZSBldmljdGlvbiBhcyBwcm9jZXNzZXMNCj4+Pj4gICAgICBhcmUgbm90IGZyb3plbiBh
dCB0aGlzIHRpbWUsIHdlIHdlIGNhbiBlbmQgdXAgZ2V0dGluZyBzdHVjayB0cnlpbmcNCj4+Pj4g
ICAgICB0byBldmljdCBWUkFNIHdoaWxlIGFwcGxpY2F0aW9ucyBjb250aW51ZSB0byBzdWJtaXQg
d29yayB3aGljaA0KPj4+PiAgICAgIGNhdXNlcyB0aGUgYnVmZmVycyB0byBnZXQgcHVsbGVkIGJh
Y2sgaW50byBWUkFNLg0KPj4+Pg0KPj4+PiBIVEguICBUaGFua3MuDQo+Pj4+DQo+Pj4NCj4+PiBG
aXhlZCBpbjoNCj4+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD03ZTdjYjdhMTNjODEwNzNkMzhhMTBm
YTdiNDUwZDIzNzEyMjgxZWM0DQo+Pj4gYW5kIG9uIGl0J3Mgd2F5IHRvIHN0YWJsZS4NCj4+IEdy
ZWF0LCB0aGFua3MhICBJIGhhZCBhbHJlYWR5IHJldmVydGVkIHlvdXIgY29tbWl0IGluIGFuIGV4
cGVyaW1lbnRhbA0KPj4gYnJhbmNoIGFuZCB0aGF0IHNvbHZlZCB0aGUgcHJvYmxlbSAtIHNvIGVp
dGhlciB5b3VyIGNvbW1pdCB3YXMgYmFkIG9yDQo+PiBzb21ldGhpbmcgdGhhdCBpdCBzb21laG93
IGRlcGVuZGVkIG9uLg0KPj4NCj4+IFRoZSBwcm9ibGVtIHRoYXQgbm93IHJldmVydGVkIGNvbW1p
dCA2OGJmZGM4ZGMwYTFhIHRyaWVkIHRvIHNvbHZlIGlzDQo+PiBpbmRlZWQgaXJyaXRhdGluZy9j
b25mdXNpbmcgYW5kIGhvcGVmdWxseSB5b3UnbGwgZmluZCBhbiBvdGhlciB3YXkgdG8NCj4+IHNv
bHZlIGl0LiAgVGhlIHdob2xlIHByb2NlZHVyZSBpcyBzdWJvcHRpbWFsIGluc29mYXIgYXMgdGhl
cmUgaXMgbm8NCj4+IGZlZWRiYWNrIGFzIHRvIHdoYXQgaXMgZ29pbmcgb24gYW5kIHdoZXRoZXIg
dGhlIHByb2Nlc3MgaGFzIGZpbmFsbHkNCj4+IGNvbmNsdWRlZCBhbmQgaXQgaXMgc2FmZSB0byBz
d2l0Y2ggb2ZmIHRoZSBib3guDQo+Pg0KPj4gTXkgLSBwZXJoYXBzIG5haXZlIC0gc3VnZ2VzdGlv
biB3b3VsZCBiZSB0byBwcm92aWRlIGF0IGxlYXN0IHNvbWUNCj4+IGZlZWRiYWNrIGJ5IGxlYXZp
bmcgdGhlIG1vbml0b3IgX29uXyB1bnRpbCB0aGUgaW1hZ2UgaGFzIGJlZW4gd3JpdHRlbiB0bw0K
Pj4gZGlzayBhbmQgdGhlIGJveCBjYW4gYmUgc3dpdGNoZWQgb2ZmLg0KPiBUbyBjbGFyaWZ5IGEg
Yml0IHdoYXQgSSBtZWFuOiBpZiBwb3NzaWJsZSwgdGhlIGRpc3BsYXkgc2hvdWxkIHN0YXkgIm9u
Ig0KPiBfYWxsIHRoZSB3aGlsZV8gZnJvbSBpbml0aWF0aW5nIGhpYmVybmF0ZSB1bnRpbCB0aGUg
aW1hZ2UgaGFzIGJlZW4NCj4gd3JpdHRlbiB0byBkaXNrIGFuZCBzaHV0ZG93biBpcyBjb21wbGV0
ZSwgc28gdGhhdCB0aGUgdXNlciBjYW4gdGVsbCBmcm9tDQo+IHRoZSBzdGF0dXMgb2YgdGhlIG1v
bml0b3IncyBwb3dlci1MRUQgd2hldGhlciBpdCdzIHNhZmUgdG8gc3dpdGNoIHRoZQ0KPiBjb21w
dXRlciBvZmYuICBOZWl0aGVyIGFuICJvZmYtb24sIG9mZi1vbi4uLiIgbm9yIGFuICJvZmYiIGR1
cmluZyB0aGF0DQo+IHBoYXNlIGlzIGhlbHBmdWwuDQo+IA0KPiBSYWluZXINCj4gDQoNCkJlZm9y
ZSB0aGUgaGliZXJuYXRlIGltYWdlIGlzIGNyZWF0ZWQgdGhlIEdQVSBpcyBzdXBwb3NlZCB0byBi
ZSBwdXQgaW50byANCmEgc3RhdGUgdGhhdCBpdCB3aWxsIGJlIHdoZW4gcmVzdW1pbmcgZnJvbSB0
aGUgaGliZXJuYXRlIGltYWdlLg0KDQpUaGF0IGlzIHdoeSBhbGwgdGhlIElQIGJsb2NrcyBhcmUg
cmVzZXQgYmVmb3JlIGNyZWF0aW5nIHRoZSBoaWJlcm5hdGUgDQppbWFnZS4gIFRoaXMgd2lsbCB0
dXJuIG9mZiBkaXNwbGF5cyBiZWNhdXNlIERDTiBpcyByZXNldC4NCg==

