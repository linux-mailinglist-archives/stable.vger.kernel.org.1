Return-Path: <stable+bounces-232850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MALqMzVwzWlsdgYAu9opvQ
	(envelope-from <stable+bounces-232850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:21:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF9F37FC67
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BD2300CFC2
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925931E822;
	Wed,  1 Apr 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IjrXSunC"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054703195FC;
	Wed,  1 Apr 2026 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071279; cv=fail; b=OXpJRmivkN3sH3VjimnTl9rodjMJFC5PNI6tLk2EgRMes5Cdlr0DkWxRi0U5zfm6itUH4Slbs3cU6BU75MyA+20LYCmUrJmGfaIPhvmCvqdCE4oZLY2q18BH70UwOYFVJbm1oxxEUBMqSZADPG27k2f8e0gGQ+Gq/z5EWlnfQ4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071279; c=relaxed/simple;
	bh=IyUvyt0wH/kJoHArS9boG/ALzviiMsBFRbefRPUnXOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYoRYcOA0urLQlJ74J0VlxdsYLx9kXlVdXkIKKPuHI/tnh+3Q0iHApWQ8eYUwk1ZvHxPwJ9uP5B8KnLKTkfetgG7yMnnHoo6RDy1HCoeZRZIOkhL6REsvl3J04cbSBtiFbb6325GMHayiPJMRNCnS0OdnObTl9NQd6e2GRcWBE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IjrXSunC; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2AKJoZiiVKwIo5oN3lwWfmp8A4GA4Kw0VEc87n79FkUML25r06LwNeDrveFv2eRu9YT9PZB5+R0njS5U4GkL2xJNYT4k5MfUIeltjim4H46FutAA6SZ1xMYQVBEdgXlUDyDgDz21l2m8rmFfuofLL0a6X1yRa+SY3kD+fAPjoIsXqqnDwn0Qp6agM1Aet9DoxwpgZmjH4eRT7Kx9remNQesk0o0faVt//EzSk+oc4uI5XUvpqhAuMcv7d/xOht+9BWEDYxfVUDFD8urmzr//2DkYy/NbYV9zgXKAY8S5sHNWn4MfRKkhUAbgGYezaLDOU9Jbc3Hg3YeXpK8rBgZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AySzku+xt5/zNZTjs6vJquwA23ZpdC604HkIRblMbRw=;
 b=XrAG/9IA9uaPGPxR/Mxbia03GBak2FA4fnoukDk3cxb3Un6YLQmLdGXzKqnGmZbhAwCgUL6y0EPhMIzhlZUoLKd8TLuTZU/fTTtFm9FwrKlp6jhHGw8sbq9dSASvKlzfhftCMWWf3Uv5ppUr+89S5lPxcJt3YV9nHCbjy3LRC0x/0ePrdn3zN/zMpAPAKbsvGcIs6RPOvDCsq6KZyxiWNFwpbwq9veIjPWphrhj7k34xB3KHsnSdr4N9USTXd1va6GKdM5QJtEfQZo9IVIaoDdY93qWEYWeUtM8E051skF4ObxoLoMQLkTbdVtmLHD9O0RskFZCa910qtW0g4j0TMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AySzku+xt5/zNZTjs6vJquwA23ZpdC604HkIRblMbRw=;
 b=IjrXSunCOhxfQpOOyHTyI5u9Kj1weWr+V121iLeKZs09YmKnsGGQMXD6eMK+2rBaMLrwth/FckV1REEpuFL9cKIabZImMxPjImj8b2vlQ/a425HELfUz1AeVHDEvSFASOFm+lZIMbnBf4lfiuBOrxojg/U6uXLBcxilW0dVzOO6T5TOVdA3ccOeHkTYKoI3z0/OgJ8EIb+J6NAs2D11ZwN+wmj7MD03KvEFrsMnrhLYQGje9tMluQCBWh15UAiiIPKm8F5UjrGtJHpF5pj56QIPqbDh5IgWiuinyY8X7D7XlgKXSbTWEDtVwa2nE+JRTZ+zQ2hTkupv8K1Wp9JsKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Wed, 1 Apr
 2026 19:21:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 19:21:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, richard.weiyang@gmail.com, usama.arif@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kartikey406@gmail.com,
 syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/1] mm: fix deferred split queue races during
 migration
Date: Wed, 01 Apr 2026 15:21:10 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <C4A8301D-C76B-430B-A6A6-8B642B80FE2E@nvidia.com>
In-Reply-To: <20260401131032.13011-1-lance.yang@linux.dev>
References: <20260401131032.13011-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f57cd3-7468-4ba0-14f0-08de9023d6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xVxlGVZxux2CrBVEKJi4m3jUXekXjyzA9LHdpf8YdBtn781FfhMhFggWR/PZKyO1rxqeiQhso8SMpa/cIZ9iyH3uxBKhmst0Ptbh4NH0G5nWZ+LjQea0v9XHgFEZIqX7Ik8t0J9rwHdWC4GgS1G+HyvByh75dj9XU36oNS0wfCJZhtYwhLpU2doK8DzUxmS9/NBeIuJmuE4KvUeocKktWjDAK66yhFbdJF+MRQSrTRBfxl3G6VnnnnrFh8FIYjmy2QhNt4UGodfaCRsWCo2jwmdMYgn5pS0EJmJpw87EIMIg6vyj1JL+Ao+PJo+M0V5VTqAWcE701ycROuVoYzDLgCx12tM+JADnose9RJwZaSyYAhp5lHJfklNeS/g/xC2D9k7ETmhQ2t9eawA/nU/339M8D+1u2DWdqUKUiFYhYIQGZH64OzPfCaAu+4c7BoY7BWU/56uXPCm3uAj2pC9QQp4b/7RAdN5KxntuSzKYWUsPdzcuGqBq0r+AdVmpyvA1g2MC87kSfYQP9fv6DgrbuuPjzs3x7Hx5bYCjc2SZkyYhpezWxk9QYEGsCQ0/36QdnYSIpzYqnBGegzPsXnMRgPGMH01Jb1Vn84T8RnsN09BeyRmWDVSupRzxFJ5a6Pz2eGhBUZscUww67HFjiz8VhIjtq2LTqX4blFE08Q5mf/QT7VygclrUL5aRCNp0JyzntOXNGQn3wF/PAbZsfs6kjg/wlxkADPuwla5PPTaXOGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjU1ajNJeUZmM1NqYTFvOTVSNzVyOHJxSlZXT0JlVUhvaEtUNUZUaTRCK05H?=
 =?utf-8?B?SjVOeW9SVEd6N3dIc0U5b2FmOEJ6MnY3OHluUUxnZm1nNGhITk94MU11OEZE?=
 =?utf-8?B?UTh3cHpzMUN0QlB5V050cGVpczc1b0w3dWNYUDN3eCtTWlpPd1dKS0JKRk53?=
 =?utf-8?B?eVdaWExWSVg5WFphZUoyWklTbW9acjdweDFTSDJzTHNaSVdJUmFOR1R3eGQz?=
 =?utf-8?B?eENRL1UydHB0NG80OWpqMW4vcXNFalgxZ3pZN053Rk5DYkVHaDJwRFdZVE84?=
 =?utf-8?B?SUJwWC96YzFPMTg3QTBuVnBEU25nOENYNkJFZjEyNzQ4L0ZFbVRocElMME9p?=
 =?utf-8?B?YVIrRW92ZUZObFhvU2NNK09XM1p0bmRQWmZDS0tkMlJwOCtvbzlFVUJueFoz?=
 =?utf-8?B?a29RZGltajRRdzBYZG1uQlNxeVJKU3Y0dUwxWlpESzZ4TWNCMXJ1by9SQXZq?=
 =?utf-8?B?ZHNmVmZZVUZ6a21TRTBqVjdVUGMzZXBjOGphallFT3EySWpaTG5ENlVnNnRp?=
 =?utf-8?B?dmdndWs5Sk56WWNWRk5IalV4K2gzMFJkQ3FxYUFXN1NGTFNLTlhXUzRkS1hV?=
 =?utf-8?B?ZlJOS2J2NlVtRmJybFdpOUtJKyt2MTRTMjlZeis5TDlheTEwVTZIQVY2L3pY?=
 =?utf-8?B?NlIzRmdRNVllUXZjVTkvMjR3NElVRy9WbU5FOXAwVjJ6dTQyUzRmOVlFNGx3?=
 =?utf-8?B?OVlaQ1JlTUo3ZzdXeUpwdkNHU2ZxUGpFMUI5alFGdXFscU1SOEEyaklFM01I?=
 =?utf-8?B?Nm93eGRNMkppMUpkd3pFaG9kb0ZvYThja2VYTk80a3FoVDBpS01tRmlzM0FE?=
 =?utf-8?B?WStnNGJrSlluUXZyYWZZeUo5ZVNQM0x4VHIxMzQzcmoydFU4N0hwVWdGS0ZG?=
 =?utf-8?B?MFBhaHZ4eWlhTldJRWdvMGE1dHpSckhqaGNFVUxQaFYxV2pFMDRUVjdoVng0?=
 =?utf-8?B?V2xsbkZpbHRxc3QwTXI2ZEdBejNEd1BVUzcvVFVkOGY5MkNrVWpIcUY1V2NP?=
 =?utf-8?B?Ly9PWGlOaVhNQmV5NDVqbzVrNHZQVUpQMWJ3OWtHZy9xRkg5c3VhRWxlcUJL?=
 =?utf-8?B?c2lNM0FsSkd0UVRaVHhNWFZad2JNcHgvM2pYZ1JqbE9pYmdYNVhRM1FDUWhD?=
 =?utf-8?B?cDNzc0RiaWdnQy9QQ25GTXA4b2RoVElXWlNnTWhkZUVXQW44bEQ4YmpKTXdx?=
 =?utf-8?B?aUM1cm1id0hZeFpUT2N0TFI1N05KQ1VoZGtuMERiUHhEZUsrakxzYVlPekNZ?=
 =?utf-8?B?em1QcWR4M2h6L050NXFmcVhwQlhpbjRzUy8rVEc4VFh3RFJMMFN2SmRwdmw2?=
 =?utf-8?B?L1Z1SHBidDRSeDFRdmplVk9uUThGYjFPRk91bVpMUFM1MUIyUkpZTFFEUzAw?=
 =?utf-8?B?VWtWOWlhanFjSGtwTndqSkZBOURWU2lFWVJ3dndHNFkzdW5udjg2cFFlYzNs?=
 =?utf-8?B?N0xUUXhDUXArdllEeWNMTFE5dS9hQUwzQTdJMTR3aE5admgwSzUwd08zb01F?=
 =?utf-8?B?a0djenNzUFZTbmcwN3VYelFlNVhMQjBEaWNMYjlMVlBwQVZpK0kzcWs2VlAv?=
 =?utf-8?B?THRmV3V4bU5vaUtQejhrenpxVUFGcGhJcTh0anJsbTZaVGxmUHQwSEpXS2xn?=
 =?utf-8?B?MXRvMHErRVVFSExFSE9WUE5MR2ordXNPMmk3SGdFZWMrYmZqRlRZOGw4dGZk?=
 =?utf-8?B?TWQxQzR1aHJNNVdNTzdkMHVJS095RHJiV00wd3lDQmt5VUlrNHhidkk5MWYx?=
 =?utf-8?B?NHZmQmlBbzRoYVlJanlMblNIYm5VdmtMWTQ4clk3WEYxWXlWK0ZoQnU3cHdq?=
 =?utf-8?B?MDZmSFNHemNXODlFVzlkdXlkTmUyajNpeXFQVStDaFlRZWNuK1J2OEZTNEpW?=
 =?utf-8?B?OEkvMExadGFzSXNmL01QUEkwTmc2WWVrdUpFcldXOHR0QnUrQ2J1eGg5VmNn?=
 =?utf-8?B?bDN5cWhVakNSWjRPWkpieTJ5MGoycDBrRW9GNEErS3FCTmpJMU96SUI1SVN4?=
 =?utf-8?B?R0JtMFFLaEE0VjhPa0MvUUlpMU00MXp2ZWNnT0RkZmtmZWhQSjUxUHhhN3c1?=
 =?utf-8?B?N0xUQUg1VHpQeXBTM2ZJNG9qc0lsWmJyUGsyMzdZSThRSHRBektEQnJLa0xu?=
 =?utf-8?B?djlyTmxieFM4ZGFteEtpS0xqeFI0UDA2YmgxY2J4L2xndnlXRUJicEFFZjF5?=
 =?utf-8?B?ZGFFQ1FmKzd1N0dGZ1ZqbGhuMjJJY25ocndRTEp5RkpQaDVKWEdyZlhvbUxL?=
 =?utf-8?B?aDQwSTdpYUdFWjV6SzZvLzFqNldCdXhyUDF0elVmek5UZGFOak1YWkp6MXp3?=
 =?utf-8?Q?/TMMCJo7IEAqXi9a2e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f57cd3-7468-4ba0-14f0-08de9023d6eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 19:21:13.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qomdTmiilO/YRl1Wyy1Lboj3uTxoHgvZoXyuUTTrMVurpv86PABPtBFtSL3iwuP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232850-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.alibaba.com,oracle.com,redhat.com,arm.com,intel.com,gmail.com,sk.com,gourry.net,nvidia.com,linux.dev,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,a7067a757858ac8eb085];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,linux.dev:email,Nvidia.com:dkim,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 4AF9F37FC67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1 Apr 2026, at 9:10, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> migrate_folio_move() records the deferred split queue state from src and
> replays it on dst. Replaying it after remove_migration_ptes(src, dst, 0)
> makes dst visible before it is requeued, so a concurrent rmap-removal pat=
h
> can mark dst partially mapped and trip the WARN in deferred_split_folio()=
.
>
> Move the requeue before remove_migration_ptes() so dst is back on the
> deferred split queue before it becomes visible again.
>
> Because migration still holds dst locked at that point, teach
> deferred_split_scan() to requeue a folio when folio_trylock() fails.
> Otherwise a fully mapped underused folio can be dequeued by the shrinker
> and silently lost from split_queue.
>
> Link: https://syzkaller.appspot.com/bug?extid=3Da7067a757858ac8eb085
> Fixes: 8a8ca142a488 ("mm: migrate: requeue destination folio on deferred =
split queue")
> Reported-by: syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/69ccb65b.050a0220.183828.003a.GA=
E@google.com/
> Cc: <stable@vger.kernel.org>
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>
> [ Backport note ]
> This patch is a follow-up fix for 8a8ca142a488 ("mm: migrate: requeue
> destination folio on deferred split queue"), which is currently only in
> mm-stable, and should be backported together with it.
>
> Credit for this fix goes to David, thanks!
>
>  mm/huge_memory.c | 12 +++++++-----
>  mm/migrate.c     | 18 +++++++++---------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ff9a42abd1b6..ac6d823e351f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4558,7 +4558,7 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
>  				goto next;
>  		}
>  		if (!folio_trylock(folio))
> -			goto next;
> +			goto requeue;
>  		if (!split_folio(folio)) {
>  			did_split =3D true;
>  			if (underused)
> @@ -4569,11 +4569,13 @@ static unsigned long deferred_split_scan(struct s=
hrinker *shrink,
>  next:
>  		if (did_split || !folio_test_partially_mapped(folio))
>  			continue;
> +requeue:
>  		/*
> -		 * Only add back to the queue if folio is partially mapped.
> -		 * If thp_underused returns false, or if split_folio fails
> -		 * in the case it was underused, then consider it used and
> -		 * don't add it back to split_queue.
> +		 * Add back partially mapped folios, or underused folios
> +		 * that we could not lock this round.  If thp_underused()
> +		 * returns false, or if split_folio() succeeds, or if
> +		 * split_folio() fails in the case it was underused, then
> +		 * consider it used and don't add it back to split_queue.
>  		 */

Should the sentence
=E2=80=9CIf thp_underused() returns false, or if split_folio() succeeds, or=
 if
split_folio() fails in the case it was underused, then
consider it used and don't add it back to split_queue.=E2=80=9D
be moved to below label next?

Since =E2=80=9Cthp_underused() returns false=E2=80=9D is describing =E2=80=
=9Cif (!underused) goto next=E2=80=9D,
=E2=80=9Csplit_folio() succeeds=E2=80=9D is describing =E2=80=9Cdid_split =
=3D=3D true in the if=E2=80=9D,
=E2=80=9Csplit_folio() fails in the case it was underused=E2=80=9D is descr=
ibing
=E2=80=9Cdid_split =3D=3D false and !folio_test_partially_mapped(folio) in =
the if=E2=80=9D.

The first sentence matches the goto requeue for folio_trylock().

Otherwise, LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

>  		fqueue =3D folio_split_queue_lock_irqsave(folio, &flags);
>  		if (list_empty(&folio->_deferred_list)) {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 05cb408846f2..8a64291ab5b4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1385,6 +1385,15 @@ static int migrate_folio_move(free_folio_t put_new=
_folio, unsigned long private,
>  	if (rc)
>  		goto out;
>
> +	/*
> +	 * Requeue the destination folio on the deferred split queue if
> +	 * the source was on the queue.  The source is unqueued in
> +	 * __folio_migrate_mapping(), so we recorded the state from
> +	 * before move_to_new_folio().
> +	 */
> +	if (src_deferred_split)
> +		deferred_split_folio(dst, src_partially_mapped);
> +
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
>  	 * turns out to be an mlocked page, remove_migration_ptes() will
> @@ -1401,15 +1410,6 @@ static int migrate_folio_move(free_folio_t put_new=
_folio, unsigned long private,
>  	if (old_page_state & PAGE_WAS_MAPPED)
>  		remove_migration_ptes(src, dst, 0);
>
> -	/*
> -	 * Requeue the destination folio on the deferred split queue if
> -	 * the source was on the queue.  The source is unqueued in
> -	 * __folio_migrate_mapping(), so we recorded the state from
> -	 * before move_to_new_folio().
> -	 */
> -	if (src_deferred_split)
> -		deferred_split_folio(dst, src_partially_mapped);
> -
>  out_unlock_both:
>  	folio_unlock(dst);
>  	folio_set_owner_migrate_reason(dst, reason);
> --=20
> 2.49.0


Best Regards,
Yan, Zi

