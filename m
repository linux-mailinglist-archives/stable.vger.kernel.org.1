Return-Path: <stable+bounces-230769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL1bA4Rux2mXXQUAu9opvQ
	(envelope-from <stable+bounces-230769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 07:00:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251234D758
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 07:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6371B303DAC5
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE171299A81;
	Sat, 28 Mar 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N/YU5LO2"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9318C933;
	Sat, 28 Mar 2026 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774677624; cv=fail; b=n9JthqYRGr19dwx3HlecZP/OSKHReBd+mdjAUxPXrBntj+4h5aynLSxuh1Sx/zgDtPIWfQM8Ks9IN4YriAIbRc+EOF7hY7C2ivdVvScDZYkdngpErtskGyBcy611x1alImsGrSqnJH9GGxR4XfByFnNTyPIrGmetJZiPDoHiwPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774677624; c=relaxed/simple;
	bh=bUbJDOpSsRrYsWyA7/KiBJlOoIfwMDDbc9OtMS1hx/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADsXs27B5kwyv922eK17HtXCZoybKnDGlCa7UaDFNKvJSSzWKiTaPVGoGSNqcVNX5k5Desx2tScMONVbf84EE9ZvgeJB+xkQbEWoosGEh0syN1n3qiKu2Rc5ZbfFAG8w4GOIdXJc+18TQ34hVNhr4k+YWrsRkHsANxcsqTJLFTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N/YU5LO2; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzsWU9XFv/Q4bcZfiGW95zAvi+5sDQ/U+HcC+lAWPh1ktdcGF7/y1hIvDFhi2X95GOoTkX7CZtAWR8h5LzzXSmXixdLD5f2yDFxGcHTQDs+wUeMh3BpZuXEPlQX9w6ACR1iDs30zVqTAF82JTu5V+S3/7xNkSzQIUfWZpsqYsN/bP1xl30BLvHb5Is9T91pHxCkl0ninnqSqh5U7K6gKJic9l/rmttfwAUAwDe/HO4+HpXENW2iqm0cg6snjTYIglJ/NtzdNtgxA8N2C0EZQjqYEj3Fhrze9r/CZ6rRuz96/vXhrGT9f2U1lju4u4aWEtsD/qi/cq13eXT6SXGAFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH+23Xp8D5tbCzrGCH3UM1aULDYJObUN3+DWq3wdtRU=;
 b=ZD8vP5Gs8pB5PbcZfx97p20V4uq3n83+vGMcoF/2PjxcchQ7yYS7yvZPnSROqxf3/kIe2ZUw9rGs/XEnFQ5RJXMQ/wlkp+PURCthzKblh4YhLrSJx1Vv8gPNumZDPiam06lbwlVYr6lygARrcX9i3GXkyjtUT3i/pbimPdx0JAF0cf5bw+bp9gyuEkUeTTGrpuyaLda3C/86yrL6cfV7YcJqBvmZQACqpGfqDnsqS4Qr2gciWG/OoUys4IJR2JcfadAjjvrvfE0LRX3EBVOxyc4o3THYxEmRli2antvJRboFURoeQxIMCAjHVss1tXqltMmkpuunpwfk+WTXJ3qiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH+23Xp8D5tbCzrGCH3UM1aULDYJObUN3+DWq3wdtRU=;
 b=N/YU5LO2VHHlxyis2sMJ/qda6SjovOSjbliRLcnif6gxxC5ojpyQofbZKfGnVotQxqULsTcp+YkSus5l5AkdUCdDt8hJRYOqGHrPQ6GE1HCZZAqQWuamboSRKZ3efTO8T7IXY7K1mzfWHSHiJBrHHqCwENhiG5R40ce8XSYb+doKwais9kOsou3EaoxcAE3uwIWfcJGUb7UCxLCAP4xARXvluCCaIYwLMJgSMXH+RMIJLlJHsO/9R+Vl78HosUgVdwsyYQ9fOSGR5p9H7OZ5w87fk97FFOtFDg+9Gq3RMO9/cY8PKexeCFcRORa8VUUo3LbOJ6X8S/o5cTWak0YcSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Sat, 28 Mar
 2026 06:00:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.023; Sat, 28 Mar 2026
 06:00:17 +0000
Message-ID: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com>
Date: Sat, 28 Mar 2026 07:00:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 florian.bezdeka@siemens.com
Cc: crwood@redhat.com, namcao@linutronix.de, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, frederic@kernel.org,
 vschneid@redhat.com, gregkh@linuxfoundation.org,
 chris.friesen@windriver.com, viorel-catalin.rapiteanu@windriver.com,
 iulian.mocanu@windriver.com
References: <480f889c1744132f39983178fbad90ad11e081ed.camel@siemens.com>
 <20260327183610.594667-1-ionut.nechita@windriver.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260327183610.594667-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3182:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8dce57-0578-400e-4c68-08de8c8f4944
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BOvKtX0nyKQn0Nwb9+b3erwdluR8ZKVaXGIyoS/8RdrF0R7va/BIgI8SH/Jmst0DuzcRhAfcZHdGw/HcL1UjUtaAq6oQ+x4fRMBCPFjMnIV8wM+DHEIalbXcjbNukqOBrTRtkF6N+uKGmxjg3p6H5xnZZ+aqb8BJ6PU+CdZ5Pef8aQPSA9cRiL3C0TUnV5pH9TiurWkRcRLOzK/jV27pMH3CKM22QPiSI/1Znx/zzt9CdcS9se4QqfI8a7bV6Kw9ohkaUaWTxfjZrtu4PvQViRh5wiM0iqD6sADyUrGfQbxUE81fJrAdpsbxWcufKjus8RYHmM1hSOeNG7GGFMZTknVMJ62Mu8+hAhDfXI9tpyM9GMlMPJ95WDCu4YzswD4kteu7xKXRLPlnZbqCuGOMiE7420lR2YbZVfK9okGfY9I+Nu5e+yNm2x2nCm0OvkEhiYLhcjXuXR2S4elS7h8oACNf887riAmkYWBgpqKuTUJFd/LdCw5lgNYMZhfm9c5+jqvIRW8RzowgY8ycR0xwz/Cc3hzkZMhsfYO3OmvdFANlIczSpRquXkMECqM4T8Cfl2+C81FwrogM2elvDK8mWKTbZ/t+pNiISrj7BuwzyWkgd0dxrrQbsviRUsGDxOxOFehxsXa7gLpf4DYHvdKRfkPZIUtITwWLYI+lmiWsi4x3ARzkae1b3VZZCIlmim/lOhS1+9Qd5oTY11h9a4bhGudx65HVTSJjqTf2U91y+8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFE1WWQ3eFBHbWxKODg5TGZwbEtZa2Rhby9BQ0NoNy8vVVh2QkZaM0tkZmVF?=
 =?utf-8?B?Y1B6ZmwycnovYTlmbnVVTjViT0tkaU9LVVlCcVhKSWorMWxTbWx3MGpPWW91?=
 =?utf-8?B?T2M4NjI1QXhVVGpLTWFCM2tNNXdFVnFtTW5DQi9WRDRRSjlYMldEWE1ra0RR?=
 =?utf-8?B?QmhpMlhoS09MYmtPQVhvK3pLbE94MEtURERaRC8weXFVQTlCOUg2VjRBTEVP?=
 =?utf-8?B?UExGQ0k0OGcyc0M5elh3cjNlZkFBYlhnNVEvODhRSlNBeStXVndiWmJGbVR3?=
 =?utf-8?B?OEJ0bmVpRG1ramlWak5kQkI1WWFMK0NrTUNjNzBncXBibmJBdm44TXZydWw4?=
 =?utf-8?B?eE9WcWV1a1NxVjYyZVJKVkpYbmpzMmRXUXlnMXo1Wi9IZS9yRWhpM0p5OEl2?=
 =?utf-8?B?bXUwNGFrUjhxbWF1cm54eGxvc0c1ZHJVT1VvT3NBczNlN2tpZ05sNHFjclJY?=
 =?utf-8?B?YkxheGdlMHU5OGNOZEVpZFBvOXJCKzVaK1QyZGllaGQzZlpid1RMbnNPNnNv?=
 =?utf-8?B?K2RSWmx0RWQ5ZkQ4dFJ1WUpURStQcHZQcGd5UEkveDRxdThsRm1QWlNQZHpr?=
 =?utf-8?B?eDZBQ1psREp2WFp3bC92VmxKL0xhU0R3L3NJbzJoQ2dLYVJzeFhEZjVFa0wz?=
 =?utf-8?B?aUFSV3JTQ1EzOEJiTTdHdDVWS1JiSWcwQUZ2cWlyTHdzNnRIdXh3eTJGUmVx?=
 =?utf-8?B?MlpGRzBDb283OXdKM3pjWWlJeFk0TE5TQU05eHY4bVJwcytVVk4zVDVYc2Vy?=
 =?utf-8?B?dXA3TmJhTUVvdlJvbTBPNEVVZG13WkdXanEveFZEalFYcEx0WW83d2MwbFly?=
 =?utf-8?B?MWszbEk0TlhvcWloYisyaCs5YnNnT2dlZ25FdGNWYmFBTGlNMTlrb3NBTERs?=
 =?utf-8?B?bk8vRjlZOW13emdKSWxvZG5kbENDb0F6ci90Q3gxUTdiYnZaa1RadlFjekNM?=
 =?utf-8?B?OEEzY1BvOFhrdFZpckc5b3BJTUlRWjlEdFVsNmxHYU11MUdzandVOVlSdElq?=
 =?utf-8?B?a0NJWEROSGJScE84Ukh3VzE1YW9WY0w4Q3k1aXRmZDVieHE5MXFQeXhsTDhH?=
 =?utf-8?B?SWM5VGNSeEMybTAvWHRSK3ZWWXYxSXZ3QmlaTys1Q09NRTdLVkgzRVc1Ynd5?=
 =?utf-8?B?SHRvR3RqY1NXY05sOVFaVUFzci9lQm1DblR3UGFrbGJyZjJ3bmFiVEY1RTJH?=
 =?utf-8?B?aHkvQk83aTgySHp3Qk42amF5cTVyTUgzYVppRmRwS1k3UUVONUhCSEN3ZXQw?=
 =?utf-8?B?K2pWRzNRSXYyejhBUkRabXhGQVNnOGd2M0JTZW9WaXJ3SVQrdnZEL0M0QThY?=
 =?utf-8?B?T3hwT1BVeVdWUmtuTWJsZmQxOE1wRDBpOXc5ekdMbW1pUkpmNUVvODBvZGlv?=
 =?utf-8?B?V2VtdGoyNDhjZ3BMa1NBVEZvZjkvRUNjRVNmbVpYYU1JVWxoaVlhbnRYenY5?=
 =?utf-8?B?T2I2K3pwa3BtTTc1YXl4dUc4SGVYa2RUN3hhZVFPOStzN09lYmdwdVRPWlQx?=
 =?utf-8?B?RzQ1UjRadEJzNjBvOFk3RlAvYTFSYkVzQ2NiWHZzZzZWdEVwTkI4K01mSGls?=
 =?utf-8?B?N2pqMDBtdW5mUDBWVHZaYmk0NldtdUdWRGx3TWxKZkxJdW1wVkVsUThjdEFG?=
 =?utf-8?B?aVpQcWs3UG1hbE5VdmViU1NMcDJHQkVyVEd2MWEvVlVUcTJWWXZjVDdvRVk3?=
 =?utf-8?B?L3lHanZCaCsvOFpZS29sRUdkWFhmVGlGZytYTGVxM3k5SThvQTJDcjdhSXFQ?=
 =?utf-8?B?a2o2Q3g5eXdDN2ZnNFk1TTgvTEkzN2hVTHo5MnR1cFBUUTg4YjdjK0w1WmQz?=
 =?utf-8?B?SWFoS2EyTlBERWF4WlBMZnlJQlZra3JMdFMxczI1ejdMN0MrS29RZzdOYXFp?=
 =?utf-8?B?UytPc1I3OE9Panoyb3MyV0FERWZXK0RhQVM5KzQ0RFlTdjdnQ3lWUmhpOGF3?=
 =?utf-8?B?WFZXem8yZXhhaHIweG00SGdNY0pOY3dML1lKMHMrZUE1b3UrdkhjNXJwcCs0?=
 =?utf-8?B?dGN4ZjJ3QkowK3liWTVEanFLakxneFZpNW5ZemsweVdXY2Zpam9QWlE4WVdq?=
 =?utf-8?B?U0d1cjV0WGtIR3JuSlVSQ3EzZHlBWThQNGRFOFVrTlhHdU5IWEl5S0p0N3hn?=
 =?utf-8?B?ZE9SN0wxc0xSWkVmNGd6UWhzQkZON0Y3K2xsSG5SN2VxVjBUWnJod2pyaXNs?=
 =?utf-8?B?cjZGZkRIdHA5NURLYWpmcDFFeXpJTlllRGRudWJXYVZyT2VqNlJMSUJna3J3?=
 =?utf-8?B?ZlFWZ3N2MXIzVXpQVVNkQnJUNmpMYTRUdC9JL00yUEJJQkRUTTRJdUdjZlVB?=
 =?utf-8?B?Q0hua05DVDBUU2JuakZTeEZxczZORXdLcGdhQmxjVUF3cGdYYWdSdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8dce57-0578-400e-4c68-08de8c8f4944
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 06:00:17.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfCg08MLBHwTiUNG+ZpSm9jlPK13zHRGj+V0H8mNwPlaX/4cvZjg5fqpFQQRNgSRge8uFqeI4I6iEkVGHJoeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3182
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230769-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5251234D758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27.03.26 19:36, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> On Thu, 2026-03-27 at 08:44 +0100, Florian Bezdeka wrote:
>> A revert alone is not an option as it would bring back [1] and [2]
>> for all LTS releases that did not receive [3].
> 
> Florian, Crystal, thanks for the feedback.
> 
> I understand the revert concern regarding the CFS throttle deadlock.
> However, I want to clarify that the noise regression on isolated cores
> is a separate issue from the deadlock fixed by [3], and it remains
> unfixed even on linux-next which has [3] merged or not.
> 
> I've done extensive testing across multiple kernels to identify the
> exact mechanism. Here are the results.
> 
> Tool: eBPF-based osnoise tracer (https://gitlab.com/rt-linux-tools/eosnoise)
> which uses perf_event_open() + epoll on each monitored CPU, combined
> with /proc/interrupts delta measurement.
> 
> Setup:
>   - Hardware: x86_64, SMT/HT enabled (CPUs 0-63)

I think Crystal already asked: Are you disabling HT then by taking the
the siblings offline for the isolated cores? If not, the measurements
are a bit questionable from an RT perspective.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

