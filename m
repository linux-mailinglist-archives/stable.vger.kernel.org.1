Return-Path: <stable+bounces-243904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOpoGAP5+GkG3wIAu9opvQ
	(envelope-from <stable+bounces-243904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:52:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92194C35D6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECA123020020
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53E3FA5D3;
	Mon,  4 May 2026 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdpUEY3v"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4235286D57
	for <stable@vger.kernel.org>; Mon,  4 May 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924347; cv=fail; b=bSihvLnwB7kCkwlDUZI3XhzHPOUrV3VhUfdvVlxhzsVxqtX0cPlRG9mMSiFK7rmHlm+e2Dvdu5va9BGRD+D1PutqCxo8TI3WdicJDNEOWGjQFLfzdy79qHAsPUuDVU15w1WYtVcZw+sAfBFaoLznqvw4zrLjtwlkILDeY8stXac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924347; c=relaxed/simple;
	bh=NPggAnITFIXMeUUPhHKrlMxh0vuoiCYXMzbGEPJ5YoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IlVlttQmH3uGw8FBcyOjuCIHX5Gxo0pMmoJAZNDaBABdhy6sPVkyli9AVjy64rg0MbtXVq/Llj5MKDFWUaZi2fZJUuoP+t4V6BHgioddeniItWPT1yzJ1vKRYuBckv6V4G+LCNwnSqBnWuxfYF7mw0WEV8DlpIvEDxZVbuvdsP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdpUEY3v; arc=fail smtp.client-ip=52.101.57.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0ZpAuc00cQDMxoBcZb7NMASPpKEI1PDj5ijS5+j+lhQ4nHn5uFx5aodmc/rMHCCMWgIOQ9V3zWtQXOP5QFm0AFhdf9Kow3nCXFvSf4xN/lnEhSReY7sK7fgMbN4avvBDf2aiVGKebUgtYprg/L86iX+01N1BUpo9SNtyGtP55y8mz/K7c2HaquVgL+QolISGU7z6F30uekDL4hPH0I9Pg911I6VBWERV2m0jpJYM/lQDc6h4Nvt3G1pGt3mbYErVlTkkgR1TKXx0zIoS0gVAADNFkKs0OFOfHA1mSOQ80c9zez2w99NFUsigVpkt9AmtZSy7HgqS2mGfymYsb/Z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPggAnITFIXMeUUPhHKrlMxh0vuoiCYXMzbGEPJ5YoQ=;
 b=iBWJ2or702Ilqq6aCFCUcPkIxzwJCvaDvgB307UMfzVotw7ztXkA7QLiZne3wD4Jn5TnEAdkvM0dWJqn2uWJymIxbnlXw2q/5pTIXB1Qqln3h32bf6hUSAVNFwhqqrsl/kOiGrfIluMhohWD+9z3QxyiLF6W2p/Z6h76cHEjvqBtKoOvJZ/zypE/qKKZAuIcIY8ZK/p+PjIDW68faFb5h8z/SgCHeWdnXQTiLp8K8rKTOVFDeDPEevLD2PjLaXHUySQ5DS9RzvOFqdgLqjOpyskoLMrgAodbrthFwEe5OhJ8uge+p05PIjdU1OnPS26hlNZD9cvqozzM9n1Ef8cXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPggAnITFIXMeUUPhHKrlMxh0vuoiCYXMzbGEPJ5YoQ=;
 b=LdpUEY3vpaqR0EkvwetEfqrYZScokiJ+AA0smpWqy5cMu4JiV3k2Wfx2YNe1vFAxvPb4y0unFtVz7WV4AVyEk8uc6T9LEa500bb3cam4+gYOQfIhOf0/RwA8G9aPa32kZa4R7PMJRmQCyB7yETBfYXvx7k3ahQkYrZr+8fA1P4U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:52:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:52:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "mjanes@netflix.com" <mjanes@netflix.com>
Subject: RE: [6.18.y] Missing TLB fix for 6.18.y
Thread-Topic: [6.18.y] Missing TLB fix for 6.18.y
Thread-Index: AQHc2/47DE2tGklf4U+NVI9FtwY907X+ROQQ
Date: Mon, 4 May 2026 19:52:21 +0000
Message-ID:
 <BL1PR12MB51443EB4D300A93B30F97AE9F7312@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
In-Reply-To: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-04T19:44:58.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB8028:EE_
x-ms-office365-filtering-correlation-id: b5a83bcb-b75a-4532-74d0-08deaa16a806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 F8E9F65jyCb125+1iheWfxe4YXcsYPiHLv3y/liheNsZmwieOPU4urEAYUP9k2yyOeylSunbwwZfVDVL8V/THbOag61U9eD1ok9DRhtw1B6Mgug0hiR4SINOpP314fMm9PREXSvsPDz4tfsiBvmeNw5YmayexzQFSZeATFXwYQkG++ik9Y1QHI/4IWmodQaFbgu+xt6HP0e2JlC3lQbJN5EB6g25oZbnpXky4+6mOnBmbplttCHhiML4EalfhNKlkc+PIvtd5c1aEV7+QlQ+iIY4Ty8pxRcbmXW19/pGZ9Xp/ER+NpPhdx5HJhJ0s4U0PyImd9ob+WyQ9uC1BRfA5CsjQMy7UELe/uLzIvz2VJxhDYPijbMwVGTKgKvfrAggW9lofjxdFIIN7/+YjjelJmxUkx6nQUzae6UWxKv5mK/+gsUhSCJNGlB8FlaxwekId7QLZZJzgEgNK8LwrRX0CBy4u0lneCij3uka4XJxTbJiPTHdghHphUKrxBQOnjcnzBC5CGHQNeStVSwRaYKjuJX08hxLSI60tniZx21Z777mA4wmNMkl1eJyO4kAm1fv42V6ZkcAbHmMCssW1cHjJndC4C7tblSO/OwtfawQKLZZIqX1v63aEpUdQXqTcbyMT+5crR/Ai3NHFG5Qaxy9bgJJkxO8UnEdSfGR0lJH3ARu71oUx5pfD/mtZgXiLcw9Ig6kFpRM1totw8A7amyWwplYLG6pTr858lNNSZSbeo0G7LUCzunw9AK4QLvLEEHW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3ZDYjlxOFNsTW8yTFZmc3RpY2dKbHJlNzVwcFJYVXRuLzNmUXpWdjB3L1dG?=
 =?utf-8?B?eWNOKzhTVHZCM3psTk90YS9hRUNWdTYrY0pQMm04UzFzc3pVUWZVWURGQS8y?=
 =?utf-8?B?UFhVcEIveDBMa28wTm5OL3BOdXpEWGE3NGx0LzhxWk45MzBJUjBaeGdmbFZq?=
 =?utf-8?B?cTBlSVJwT2lTemNjaWw5OVpKUWtwYVpURTJmSmo4MGZXUWpSdFdPUENKd0Vr?=
 =?utf-8?B?REszTE9IVysyRVdtWWFDZFd3eFZUZ2tQVGtlZEY0MG9qZGNWYTFxRFVCKyt4?=
 =?utf-8?B?YVdzNkU2NGs1eU5UVzhxWVo5ODNYaVVHVXVPaFpPbWxHSnlFby9BUXc1UWEv?=
 =?utf-8?B?VGxQdmR4WXY4Z1dFTkNyWkh4SUROSmJEQ2VIM0s4dnJuQ1dFeGtiWFVKNWVD?=
 =?utf-8?B?dWNvbER2YThTaXZ4Vkpyb0FJVkZmYW1zcXJBdzhqcHJsd3p4TERiai9UNzBa?=
 =?utf-8?B?cktMdTUyOWpvdmdFNG9PUmZyVUpNZ1pJZ3VTUnZOM29renhhR1ZsbFhoTFBq?=
 =?utf-8?B?d0JOVEQ3S2tOYWlWNWJzTGxOanFIall6KzBZd3BEdkplU1Z0bHBqejN2MVlj?=
 =?utf-8?B?dm1xTHd6aHpvQkhXTkwzZkR6UVdDM09OdHhidUVoRlNJK200bUlyeklmSWN5?=
 =?utf-8?B?VjlHL3VqZit5UFRwL0FWdjhGcGJPamhpcE5SVk0rc1FyS0YreXAyY0c3T0E1?=
 =?utf-8?B?a2N3N3JtQ3h1WHQrN05iaURtTHJmSHVLTzROWGJaQThFR0FROWlGRWw4VnpM?=
 =?utf-8?B?d3BvWDdNOUFxOGR1ejdQd1lVUTNwMEdSa2NlSlJsVjJLWGthc2hMNllmS3d2?=
 =?utf-8?B?UEd5ZkpHWWRqQ3ZaVFRqYUZZSnI4bTRJSElnR2w1QkZHQjJrVGVtamZjaVk3?=
 =?utf-8?B?TmNMMDNaWFpQcjFKRzF2TURsV0pnOUtYR1NGdFMwTU1QYkFsRVU4WnlkZDZ2?=
 =?utf-8?B?eUpFS0pVaktERWVpWHlnR293Q2psSVd6ZDhyUVYwbGtEaHBFWGQ1bWtkR2xx?=
 =?utf-8?B?bitVVXBrQzlGeUhjZDhQQmFPQ2dtcTJJL2laMi9yZUk5cUZmL2JwV0t2cUJs?=
 =?utf-8?B?T3gyRWdVakJJdkl5NmNkVHlrL29lVUdSNUZBWWU3cWpkNFE2enA2R2dNejJR?=
 =?utf-8?B?Z01xNXdXay92L2hqbVRyWW55c3I1MEk2VC9YV29qRGxUZktETWx5dk00R0xR?=
 =?utf-8?B?L3NVNVo5cHFaM2JFdGhydlI2cTZMS1BuQkEwL2hERDN2ejFqQ1lOL1g4Y09G?=
 =?utf-8?B?eStJQ3c2MVRlcGJmQnR2L2ZRUEFMbUZXR2ErSEtIcE1WVWI2bkJXbUdsVzU4?=
 =?utf-8?B?RlcrWUdtNUo0RDRMVzZVVWZCTWN2eGFUelpKa1lldnFsUzNraTFXZTlERDBa?=
 =?utf-8?B?Vkd4TjN0QVd0c29nbkZKUFJMUFJ2c2JoQ1FLVklYZkpTZWFkYTkyMDdjd0xQ?=
 =?utf-8?B?OWxUWmpWVHdDS2RDNXNCY01lQjJYVElvU3dtU0NiYkxkZFpORVczTlp2NlFw?=
 =?utf-8?B?d0RpQXo3dHZVMkQ2QTU1eFBrcDgvb1ZHa2FrNUZFVUJxTndud1lWQ1VTS3VT?=
 =?utf-8?B?VkpISE9YeWoxd3IrVm1WK29FRHQ1M3ovNi9hcE5hSkltblBtQlphaU1KL085?=
 =?utf-8?B?alJiWE9ZcklIYURMeGovSUhTS052NUFPRnZSSVNNd1FwUy9zdktFYmhDbFVy?=
 =?utf-8?B?Y3pOaTh1ZEdVKzhtelVjUEVWY0ZFWW9oTk5MZjg3UXh1QytiYmhVVGp3QWVz?=
 =?utf-8?B?a3Q1Y0d6d2NGTG5wbU90aVFsaldxOU1uV1JQWHhGODlOdFYyamtEQ0RqeFEy?=
 =?utf-8?B?bDVvMVJpUGs4WG8zK1FFeG1Td2djRWdOQkZ0K29TSkFFWWtJemg4dkZtMGpZ?=
 =?utf-8?B?RjVSYkFxQ2JKSTRmMnFUT09OenpPQ3libEJOa3FQcFh5T0pRK2ppS2xmaS9C?=
 =?utf-8?B?OFpUYlZVbVRQMFlScnVqUmRqWWUyWVlFY3pKY0Fib1dhQzVIbEJrMEUwcEVB?=
 =?utf-8?B?QlZ1UWVzeTRmVVRjU2Z2THpJOHlCUWNQeEEvSWdYbzJkeGIwT2RYeUdBUjRN?=
 =?utf-8?B?dHc3RHhOOFIxRmwzblMvSXVFazRjS05pWjFtTG5BUjJRamxuOGYrTjhETkhm?=
 =?utf-8?B?Rm9uaWlIMXZVSmdjZ2trYnNiR0JXL3FLdGZzS1hHUWRPcHh0MmZXU2cxVVMw?=
 =?utf-8?B?WElWN041MWZIT0lDb243TW4yUVdFQlM0MmVsQUVMNElObjRxSVc5T0t1OVF5?=
 =?utf-8?B?d1FoeUtTMUwvM01RdW1BNjA5Q0wwMk5IbmR5emExRXlidG1RQkJpc2RPTVFR?=
 =?utf-8?Q?AoCb3yVdio2X1K4Cqx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a83bcb-b75a-4532-74d0-08deaa16a806
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 19:52:21.8169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CTAb4lHTlJsGRyMVTowBb4UfunJOuVGMnygPl0hza+BezEA0kzX8W8YWWuhRfz5pJUjBw+C4Hi2Iexu61UXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
X-Rspamd-Queue-Id: A92194C35D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Deucher@amd.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email]

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE1h
eSA0LCAyMDI2IDM6NDMgUE0NCj4gVG86IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1q
YW5lc0BuZXRmbGl4LmNvbTsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPg0KPiBTdWJqZWN0OiBbNi4xOC55XSBNaXNzaW5nIFRMQiBmaXggZm9yIDYuMTgueQ0K
Pg0KPiBIaSwNCj4NCj4gTWFyayBKYW5lcyBub3RpY2VkIHRoYXQgY29tbWl0IGU5ZjU4ZmY5OTFk
ZDQgKCJkcm0vYW1kZ3B1OiByZXdvcmsgaG93DQo+IHdlIGhhbmRsZSBUTEIgZmVuY2VzIikgd2Fz
IG1pc3NpbmcgZnJvbSA2LjE4LnkuDQo+DQo+IFRoaXMgd2VudCBpbnRvIDcuMC1yYzUgYW5kIHdh
cyBiYWNrcG9ydGVkIHRvIDYuMTkueSBidXQgbm90IDYuMTgueS4NCj4NCj4gVGhpcyBpcyBiZWNh
dXNlIHRoaXMgd2FzIG9uZSBvZiB0aG9zZSBjYXNlcyB0aGF0IHRoZSAiRml4ZWQiIGNvbW1pdCB3
YXMgaW4NCj4gYm90aCA2LjE4IGFuZCA2LjE5LnkgYXMgZGlmZmVyZW50IGhhc2hlczoNCj4NCj4g
YjRhN2Y0ZTdhZDJiMTIwYTk0ZjMxMTFmOTJhMTE1MjAwNTJjNzYyZA0KPiBmMzg1NGUwNGI3MDhk
NzMyNzZjNDQ4ODIzMWE4YmQ2NmQzMGI0NjcxDQo+DQo+IFNvIGNhbiB5b3UgcGxlYXNlIGJhY2tw
b3J0IGU5ZjU4ZmY5OTFkZDQgdG8gNi4xOC55Pw0KDQpUaGVyZSBhcmUgbWlzc2luZyBkZXBlbmRl
bmNpZXMuICBQbGVhc2UgY2hlcnJ5IHBpY2sgYWxsIG9mIHRoZSBmb2xsb3dpbmc6DQoNCmY0ZGI5
OTEzZTRkMyAoImRybS9hbWRncHU6IHZhbGlkYXRlIHRoZSBmbHVzaF9ncHVfdGxiX3Bhc2lkKCki
KQ0KZTNhNmVmZjkyYmJkICgiZHJtL2FtZGdwdTogRml4IHZhbGlkYXRpbmcgZmx1c2hfZ3B1X3Rs
Yl9wYXNpZCgpIikNCjkxNjNmZTRkNzkwZiAoIlJldmVydCAiZHJtL2FtZGdwdTogZG9uJ3QgYXR0
YWNoIHRoZSB0bGIgZmVuY2UgZm9yIFNJIiIpDQo2OWM1ZmJkMmI5M2IgKCJkcm0vYW1kZ3B1OiBy
ZXdvcmsgaG93IHdlIGhhbmRsZSBUTEIgZmVuY2VzIikNCg0KVGhhbmtzLA0KDQpBbGV4DQoNCg==

