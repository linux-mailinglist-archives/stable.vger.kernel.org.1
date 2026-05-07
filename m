Return-Path: <stable+bounces-244568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLMLGKqN/GmIRQAAu9opvQ
	(envelope-from <stable+bounces-244568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:03:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 162874E8BF7
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B9493028641
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2713F23CC;
	Thu,  7 May 2026 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="OobXvUn5"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023093.outbound.protection.outlook.com [40.107.159.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAB30171A;
	Thu,  7 May 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158604; cv=fail; b=cYsOHpZNjIbpHtgpLWT6XLm/lvWimtZ8PpXdjjxN9ye8NK2xcAlXOmb+W6tZGpKupqAjBv+pdlHDMu+hdnmQ7eeeIdoVBvGJckiq8jaKqfQmYfrwdSK0Cjj8m55eyqht0fEpmryupczcbYwfDZ2FmoD7Dr47jWGy1JRZ/ojVKOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158604; c=relaxed/simple;
	bh=z4RuD9NbzI2bQlE11ywykie/Im0HLJUsyMis8npiqfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljBeeRzlJDmR+aH1p07pddIlGgz37h7Lcd30l9E5EHnuzYLWqtV63ZXOkBbbdPqR2xEp66QQ//nMmpYVcCrSL0DjukkX1S6s+zPePtntomqc+HHGP0RuxhpDuDUDNG+muaQIqDV+VV2MyJUExyPVvqwwQUHYA7+NJyu6RcjcQBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=OobXvUn5; arc=fail smtp.client-ip=40.107.159.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avl13UbHFEUe+qudjjqO0in4K9A+dHocrxps8hfMO/8mjlBbsP2UuZj05Q3JdHGq4U3wog5GyTIq/ByATZP2j/1LlAU7nQmKmvJGZ4y3bkgSLOui6oQUhpx2sAi6hkIZOreqAcZeQmlXyCOv6tZ6emui2AVBaHiKqZZt29OGyDKZ7fwoP66vBZTafOBo7EXzppM58G4jWzW8rEsBVaOJSOJGRLuRcQlVCoHubjUlGdK/cqR101BEMKxq8la9GfQMZ8rCv3hinCwFfHnb8VzGo34mPP7hJGU7O8vchEOXqCHZm32Q9ebRwF1l3zYK423lcetWgX5J6GVG37ouVYTHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToHG0ImZuU7qfiLVYyvzh0UYOmMSy3wf8sf14WtJAwU=;
 b=OShTaS2Qqs1nBWMNtHpKe2jH2z6ThRI8KxRNLY3PvbMGVXm04mfsE2B0lfJUHze6uaaSFpgGswQRfabbMDNCLJNXYkz5lDYGb8jmbi2FUEsT/syQgX/1yApIA3mty9HOVXQSTSqxVmipxLUhhhsyGoz5wCDjKkx9CRtCVX2AcgFuCF6T3B/fiJ/zYB3xsMreFkqcXslYw5+IOKh0g4V43GdSU6CudrzX+J2Oni1FFbR0OrQyZMl/XagX5xNybXjsMK2jVxZXSZQMwFp5QfJCwcQSUVoOKJVOkPU8KGYqUUjdkXSIHV/eg7KGnz1Qf9Db5js9SNz0Q9y+jxTSCdXaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToHG0ImZuU7qfiLVYyvzh0UYOmMSy3wf8sf14WtJAwU=;
 b=OobXvUn5IDiJzg8sYoeP1SKKGpDCuJ32CSyL2Iv6vlMKWUJycWlJYBvRGFzPkGMethEmvLbF36ivWSj3EIRwBpNhkS7O3syTCJKkI6nG1rNwfxjNaAqJsncBomYV9s86mKIW2K1kKNhDUWsRXA2EsFaA4Ny6XvAuFhzIREdgTZ/j1CMSx6GoFMtBVee6RdZgrrgEJuiItbc391mfjTdnRVrQf6hTChMS0V5Bb5rWvghWvxe5RRyV5FLvXkM1oJlDF6t6csHhbwrTHVZkdKgqMDZ1tY5Y/Xi0ThrJMcWFwZEMbkdLGZUCw5PK/7orc20xrQuHmiqurxzN6Yq4iw6T4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PR3P195MB0617.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 7 May
 2026 12:56:35 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 12:56:35 +0000
Message-ID: <8bff1c7d-e43d-41e6-8b1f-476e8b5caefa@phytec.de>
Date: Thu, 7 May 2026 15:56:32 +0300
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
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PR3P195MB0617:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d3c793-e3dd-48ad-6f3f-08deac3811eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	duhuxnouFYBoUdUnjov94AzNFx8vn3Z3r3fnSVHV/fk0x2yheFIdWb8KXOeJXdCgRuks5uE/FluumY09xTTTYppz4ldctCrC0d9cKWSlQ23+Q0ZamafQIigo37lbWQAYEeE1DAUKD7eXqxpbd+YNoZIVgVuyQFoH5jTU4axtM2zaOBp9BQIa5qU3F7+3nlOTmyCJfE/+AQ6Qj8LkcCzhUIewkMsdCWNmyzl7TGkbpnl/pc34dxgSyApeMtG/CGGjHYPRF09Bagp5FbBYhVeMaFk2dlqzPlxSgoSVL8T4aoMfADuNAvli+3KQxE4LxAHQ3N3vz9vkLeF8zAAKcDzXm+WrJwwjPbUdizH9g8GtNx0/0O6xO3gm4SlFP98UGJbJ36/rv05hatPywitqoj/M89wU9i1azliaYhTZilecH1b5Jl+hLO3P4ZIBaEnDOPiMgSs5tzx3ksbrF5aqV6Ux0qqa2U809AkwkRepYlGhv/jW1a/EJsSlWjRtnSNpssEVLPxEOQ1zLEj9mUZ3Q/pJgkZjpOE8mY4zQAD8E0qUmh0/yaCcRXNn5jzK1SypWUv34B62Gv49IRYsn69xUdlzICvcOPjLDwToUCjsokNOSxnlzEP8AagqKwrYc5Nk6pl0Ssa/0dqNa5pnJAFnlBX9P2r+VjEraq5RQJYxHzI5eNWgiYGMexNthNxamXI06+xXF6ub/sHB8WKwiPvNFXW/77vNOlRh3zOOhZClHTuWPKrHHx3dS+8w1C4om7iU5A9B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekF6a2FZT2ljNHp4NEJINDhHVE5PKzc5ZG55QUcyN25BRnI4N1Y0d2ROWTE1?=
 =?utf-8?B?aldaUThDcWR2MmxkOWpKVUVtdllKNlNUak40aWtnWW1SZkF2dHEyVlZITFRR?=
 =?utf-8?B?aTVodEdOajY4dXB4ZFg3eEtyUmhhZFI2eGpZN0FWQmhMZnBoa2dRMkJNWE45?=
 =?utf-8?B?WTVYQzZVY1lMeU9hdXh4NTJuRDF0QzNjVUwxaTd0b2JXNlE4L09lbjdZNDhC?=
 =?utf-8?B?OVZWeW80QmMybVU5aEl1M3ZFZDZtSGZ6M3F4ZEdzdGxxQXBJRU9pRXpxVTdj?=
 =?utf-8?B?U3BBaU45TExoaEYyazZFUmkwYlFhYjdKWFJnV1o2dVhzeEtwQ2htUDNzd0w0?=
 =?utf-8?B?TVRTYTFtd2NUdEgwRS9ldFI5TS9oUGdTaXpmdDloOE9wZ0tudUFTN05oNWxs?=
 =?utf-8?B?TnZ2bm9NWVFHTVd2ZDVCVnRpdGRuVTBoYTZnWUpTa0wrR3QyZVE0SUZkbXN2?=
 =?utf-8?B?cmk5UWhkeTYwRi9oaUU1dkQrV2FoSFRFVjkyemtWd0pmOW5kc2pLcWhtcEdm?=
 =?utf-8?B?b0Z3aDFGVi9yazI4YmhHc1J2bnZTcGJwSklxU1A0RVVmQ1dSRnVyb0M4ZlVM?=
 =?utf-8?B?TGQ0SzE3bnpkZzJybnNkUkVmc2ZTTklFaHNUYk5JeGp2UUx4V1pyVGI0MEFy?=
 =?utf-8?B?elZzbEtOaGhFZFBwam5rcG5PQWJpZm9Pd0FRRm9jakpDRHJJWllhRSs2eEN3?=
 =?utf-8?B?RWRtMFNyNHdXUkVIMk93cjlTZjZQa0hsNjRiUmpDaWY2YjVkY3hzc01ra09y?=
 =?utf-8?B?TllQbUtYNzdxa05idFdnbC9ScllrdEhFRHR4aTFnM0FIK3kvUStVMlRtREwr?=
 =?utf-8?B?NXZVYnprTXNrMzZ4NEJOclNrM0RYUnFrZWVMMVR5QnJBalZPZGhJNGVTa21m?=
 =?utf-8?B?NUQ5MlpVWC9WcmtrdkZiRXJHbERXSVVZbG52SnEvOUJxM3pnZFk2cWtmWk5n?=
 =?utf-8?B?RE45bkI4NlZLeE5ZZlE0RlhlZTh4SWhNeGRHVEFXMzY5T282UlFPYlo1RDZp?=
 =?utf-8?B?bGpvQytvVTF0Vjcva0NNeWFzRnlCVGtJb3JwY1ZCVFRDMHBvUDEzUDMrb2ly?=
 =?utf-8?B?akVseFE1MjZkUXJBZUtld3BCdTNWU0JzUnFzdmt2WlFyeFdGNHZMcVlBUmxs?=
 =?utf-8?B?NVJXenAxZWkxVW92M0YySlVqcUUzUmxMNVJLdnp1ZWpIVjdRZ0RSdll6TldN?=
 =?utf-8?B?VjFRMjZCSlM0Um5CM2R3OFpabHJqdnZ2L2Uvd1Z1b1R3TXlKTk9OcHBNZWZ4?=
 =?utf-8?B?UWRkWE1wcCtzUWcvSEhhT205Q1JuSXhnM1MybHd1Q3ppWm9ETG5wcUR5cllD?=
 =?utf-8?B?cjhXWDNhZkkyOXZQQzhMeWdHQUtlanpacEVmUkUwRFRTSml5bDVveS9SMHBV?=
 =?utf-8?B?VEpmYnpiYmEyRVR0ZW5UcGpQTjViTTRsaXdOTkZGT0o0ZVcvZWZsbi9DRHRk?=
 =?utf-8?B?UDZyNWlCanYwSmRPQ01Ud0RSWmFHbDlBTVM5dUNtMkhTZ0xJQ091SHc2bmtT?=
 =?utf-8?B?ZzdTOWE0Z3F1STJPQVZJUk9hZlFVMnlSN0hwbjBDVVkxYVFVVGdrcng5MGEv?=
 =?utf-8?B?SDBTMTBMWXYrVGtReTlDdjBqUGUvOXBjNEkzWlVWV2tlNXRFMFN2Mk50d21o?=
 =?utf-8?B?a3lzakVXNzlDTS92bzJwalF3ajhWN2NJRjNnRnd1MnN4ZDA4eFFBRkdYaVJz?=
 =?utf-8?B?alN0TjhjNEZFNHh3Q2hSTzNDOFNFRkFyYWdCWG9iU1NIb1N0cXU0RmtIdHZQ?=
 =?utf-8?B?cURvVUFjc0c2R29McDRSdXNLQzEzS0p5RTQ1YU9aWC9xR25OSFFrOGd3SnZj?=
 =?utf-8?B?cFpQdzFVdnErRmM2UHJLY2M1N0pVL2F4USsvenprYy9Bb25UQlQ1SDduUC9l?=
 =?utf-8?B?d0hsRFM2Z2dCUStJVjJVd2VrRWJQeWNYSEpOeTdoTDNTRU85eXdCZ3BKV1k5?=
 =?utf-8?B?U1p3Q2xnNjg3OHAyaTZtVXVQNzZiSTNTV0FjYVAza2FOdElZdFhydi9Wa1Rs?=
 =?utf-8?B?NXZlQnVmU2ZGSTB2UHdvZTYyVlB2WndpVVRlYklHa0k1VTA4N3c4Q2tUcjh4?=
 =?utf-8?B?QmlYazNaeUE2OE5uREM5SGxzK2M4Skh5ZDM5eTFNb0RTM0VFQWRqZjR1Qi9p?=
 =?utf-8?B?YW55cHgvUU54VjR0NllXY1YxSXMrUVRZcWxha1lpb1VEV0xZb2hBQndZa2Q3?=
 =?utf-8?B?NDNTTmx6REJ1ZCtGOXY3MUEvZ2xTNnRTMnJXRE9neVpOTHByZjVNUnd2UXlU?=
 =?utf-8?B?OXBoSWVzN290L29qY3BjTmJMY0tQNFoyajl0UHNnaStlVFBMdFViMThLM1FS?=
 =?utf-8?B?QXFVMytUV0lhNVcvRHZqSVNIU1hZWVhEZUdKa2VQZW5uenNwbmhLdz09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d3c793-e3dd-48ad-6f3f-08deac3811eb
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:56:35.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gEo4O8e0fEfwExVeT16oSysaqAgtuvpSzMg2c+mZyZotuMmP1CpFWDQD4TNiAJLJQ5PeE613iwiEKIg4/zbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0617
X-Rspamd-Queue-Id: 162874E8BF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244568-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[phytec.de:s=selector2];
	GREYLIST(0.00)[pass,meta];
	RSPAMD_URIBL_FAIL(0.00)[phytec.de:query timed out];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,solid-run.com,ew.tq-group.com,phytec.de,toradex.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[phytec.de:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w.egorov@phytec.de,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[phytec.de,quarantine];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.886];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 5/6/26 5:09 PM, Siddharth Vadapalli wrote:
> According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
> the USB 3.2 Specification, SSC should be enabled by default. This protects
> against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
> 
> Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

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


