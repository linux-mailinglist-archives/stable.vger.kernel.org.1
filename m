Return-Path: <stable+bounces-88032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2C9AE3BB
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36191F224D8
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524A1CDA1C;
	Thu, 24 Oct 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JBCRCWHd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BeqytYAy"
X-Original-To: stable@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF51CFECF;
	Thu, 24 Oct 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768948; cv=fail; b=PogLgGOnw1JQWXv2l9Z6SknX3zVNBw0M8S9G4WGp/ppwtGiNoxzm7A5qNz6V9M4slz/zb8ue4HC6OXujDPbkJjSn1vUmLf4efQpBj3q3XH23mx8A+FkA+oga6ytLPjFIVUI2Grdaz9Z2RYurHhs/t1f/wAJJ9eQ+oRH+CaRdL3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768948; c=relaxed/simple;
	bh=CpsX92uoLLva/mVCP/wpBBxUpQddEZXwKTdTYjuS36o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWdfA7p7DsW0j5yNg9pQeI2afNWqwS+BoKuaFXAAKStqEnUgB9RCzLml+O9gOlswTnKa3uUpj42W67HlxiopnNeF1apcPLEGfF40EEQj8yVKtgMs7B2h+UMR3KUUA8EPbKZOXcy9QVlwK+4+8l1k9e433eD0+S+ruilXVlys8I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JBCRCWHd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BeqytYAy; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729768945; x=1761304945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CpsX92uoLLva/mVCP/wpBBxUpQddEZXwKTdTYjuS36o=;
  b=JBCRCWHdiNNCto+E8FsKzfdi8r0KIyM9NpRI0VNEOd+mfuwCSSi/6msS
   W2bRzqmfcRUpbLxBrOXFW0py+Q90BU2duPIgiXO4wbpWn9TicB4jDzr5q
   gIYqHkZbZUp2x5X61cPDgb4WoZKxB0IZryNmTB4rl7hSAuvOueDb+4ojw
   MGXAC6bgpwg3cF1yXfqqFYeMUvRqQ58g+5KtgLtehcfnjiRaT23IB4vBE
   kx2E/ZUcomgoXSmw9qGc4VzeXokVmRmX0L4/GIFeYjmh2fw1/zQxuTg0w
   botrMGGM1u+N3kyelHdfq514ygGeEXh3mNgsFq6lk72BXJi3I3kh19rDV
   g==;
X-CSE-ConnectionGUID: t1MbIGhSRvSYlQDTSUL1tw==
X-CSE-MsgGUID: JPFknq7rSMiq+rAbi1P4Ew==
X-IronPort-AV: E=Sophos;i="6.11,229,1725292800"; 
   d="scan'208";a="30744488"
Received: from mail-westusazlp17010005.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.5])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 19:22:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqTsBw26k6zTun+xHVRNSD8tXZYRHvegwOVRAphexYQoRSNM3XfqphmKz3guCWWFxlw3NF86IBKNl+aNcgwsFFlcuOn5opscWRkZX2y2Ou0s2DLjyvQDpaehpiqIyfdKbh9W4dnFw6z+XFyiIE7CmOkIZsag3c/y0HO8sL5RL+V0NnDvkLwu8zKWdDugG4u89dSMn7YWDNQoTSagJC2dUlp52gpkbN9KxugIBw58YbvyY59uOF1xhm2mIoGyqsInJnUWoYS5aFKBBjXKoZKW0NU6N1q+0JlvvWM+S15ePuD22/D0oz13e8PpawHv99+7W8wrf7YOU/mInCvsXD/Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpsX92uoLLva/mVCP/wpBBxUpQddEZXwKTdTYjuS36o=;
 b=ddqhggTNSvmRCaxDIkAXmchfjgPtGT5VVIhMNvBHptBGBlI5bmooXy91Z+H4CzROxvS+iVZomQw5Dx3/020U1tJ9WInxBgCAKjf1jZ62LF3g54AZhXsqmbPdu4GPNxBtCfa8SecbVfkjn/K1nppFoaHIAAOp49ZeIHh9ySs65AvjGAmdWXFWNWPSUMdrCGQTWrLRpdQwzrnFbGN1jDnPGsLFfO9z6UyYEh0pzIuZXyb+OcQBAFyVMLomYNjf3HjwWyTM0J5ceYKIYMG+pubtfZ/tmUEerSRqHutHOzRSMup2LkIyZtZWd24dhDwHESGosRXSq7u08HdNUMkRZJxKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpsX92uoLLva/mVCP/wpBBxUpQddEZXwKTdTYjuS36o=;
 b=BeqytYAyDG2LCDysBFZha7LgIcHcuvh8fAd56rgAZbSx9vHuXDeJV5vpNK6n1JWG5lCryKz+i9Pbx+cUFHXpJvH07JeiX8Q08v3UF3b9D2rUQo99yA2BBCeRmJGcERf34YCM6YEyjhaJMh4n82qOyCQWFKu+YF7w8d9/fh5JD0M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8395.namprd04.prod.outlook.com (2603:10b6:303:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:22:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:22:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
Subject: Re: Patch "btrfs: also add stripe entries for NOCOW writes" has been
 added to the 6.11-stable tree
Thread-Topic: Patch "btrfs: also add stripe entries for NOCOW writes" has been
 added to the 6.11-stable tree
Thread-Index: AQHbJgZNaWTNLHJMpEq1E6JGmZypW7KVwekA
Date: Thu, 24 Oct 2024 11:22:16 +0000
Message-ID: <3e66a465-6502-48d7-b031-1619052a1e66@wdc.com>
References: <20241024111713.3025523-1-sashal@kernel.org>
In-Reply-To: <20241024111713.3025523-1-sashal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8395:EE_
x-ms-office365-filtering-correlation-id: 612235eb-66bf-469d-c7fd-08dcf41e1e00
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjlJY0pPckxISVg5Qi82bmNaTUVXNzhyS2NVS3A3ZHpXT0FBSy9Uc3pEUUo2?=
 =?utf-8?B?K0MyUjNvdTgrWTFLeWZ3MVVLTUtZUndJWHZRaVhNWkJIendCczY0ZmpSQWRl?=
 =?utf-8?B?cjRCSGpTR2VzVmNIQXpGeTRhVDBaQkFlUG8wOUZabG1zTG9kbS9qSFRvVUNv?=
 =?utf-8?B?Nk9rc2RNMUkwTUVMbWNvS2creVhYb3pYYUVWVTl5NHkxbzJCMFFoR1NFNFRC?=
 =?utf-8?B?SW82d3g0SDFEeTNwMWV4M1g4T1NCMHQ5MkdsQ1RlNk9PYmxtMVZGdElUYlNJ?=
 =?utf-8?B?bFhDSm1lWTUzaFNydW5YY2FuZ0FhWU4rdHRvLzdQVnQrU1RMaS9GSS9nUldD?=
 =?utf-8?B?akhOc3pBM1BicjBNUWdDY0dYam1wU2lYVVNKcm5iSnVNRnFubmVVc2VDRDY5?=
 =?utf-8?B?cURhQTRud0ZBRlFyWXV6QWxrakpMWFg2SjltaUw4TzJaUUNKQVZXWExoRFFY?=
 =?utf-8?B?NDhveXZwZDM4NEt6TGZvNWRPc1VaWWU3QVNtQS9tNjk0dlhRRXl6Ky9SVVAx?=
 =?utf-8?B?ZFIyZDlSYng5U3JrNlgxajRWVE00cmErdlFhcUEydWs1VDV4WVBlaEhJTE5S?=
 =?utf-8?B?UGJXNjBIVHlreTVXaDh4UlMra1lvNitXa1M2ODhjeTdiMGJOM1pla0F3aEpK?=
 =?utf-8?B?eFkrQjZwNWdHK1RKY3V0THV6WC9PSnZDMkJKZUtkdk5weGJvVlJ6OWNscDR2?=
 =?utf-8?B?dHd1bDFEM3YybTZQVFIwWU1zUDBQMzlrOU1BMlN5MTg3ZDlTME5aOWN6aXdv?=
 =?utf-8?B?Y040QTFCRzBTSDNiemJqdGRTVndQVTh0dUlKUXJlVDRvN1F4SGpFaEw4MHV5?=
 =?utf-8?B?Uk51NlhFWUpnT1JlWllrVWlGNEhkalFzdld0VGdLVzF1VnpsWWF3TENDR1Nn?=
 =?utf-8?B?dk1qdDM3d3Y4S2JvNWtHTVliVkxDc3VVenJhSUVMT2lNbjlXZnF3VmRLVDd0?=
 =?utf-8?B?NkFMVmVsSGZkRnhQVGY4ODZVQytJYVdzbUVXUkdEZnhYejJXZC9ORnpaVU5j?=
 =?utf-8?B?OGNaWXVmeHA4VU5TVDF3VGZhUEJ4VnBWV1QwbEhLRzM4YU14NnV6b0xaWHNu?=
 =?utf-8?B?VzQ5Uk5RLzY3YWJES290bG1zQ29vNWRCNk1ucUoyYlRIWjZReklicWhzUDR6?=
 =?utf-8?B?QjFtOW51emdkbklHd0htS2dJaEo2d2tBWnBkZ1pRMWNsbXozYjZnY1ZZUFJa?=
 =?utf-8?B?RTM3UkQ4SnRrbDlOZUlOWDYxcjk3UXZyb3VSZzRMTE81bW5VQU00YVZ5Vk9E?=
 =?utf-8?B?WHNkR1ZMa2JaT1VLOC9SdEV4MEFKQThucU0waTRuaXdTZGpCaUFFbm52ZXlB?=
 =?utf-8?B?Uklid2NhUytWZGtlR3JPRHY2ZDBWZzc0RVhya1dhOUpNbkVJSDBITUdvQWZJ?=
 =?utf-8?B?ajAyK096dXBLR252T25zQVRMZkR1c25LZ3pnVUZpR0VOcEFvaklBcEJkTE56?=
 =?utf-8?B?emRtamdUbGxGblZyYThJckxZNE5BcTdFYkV1UUtINHhVcm9neXJERHNtelo5?=
 =?utf-8?B?OXNNbFQ4K280OURVMlVqRmpqbDdVd3FrYUNTeXJTVWZaOTU1b0Y2dXBpNnI5?=
 =?utf-8?B?WHhwbk9kMStTVVVkQVZLaXRFTGhiOUF5c0Z1SzlEbjhYTlhJMHl6dzRHZTlX?=
 =?utf-8?B?MmlhdG12L0FDeU1TSCtIMzNLU0ozQ0loSmtsSFN0dHJDSXArZTdmUnlDdm9q?=
 =?utf-8?B?OWU0K3hOUWxjak5RL0JoYUhUd0k3c1RmVGEyZ3hVSDV6M0RPeWFwMHBKb0FP?=
 =?utf-8?Q?b7/kxMjHCDiUdYg4nZFoRsjPryZWjx29bp1DdCO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M29Vb1Y4b1JWVTc5Q2NHc2QzRnNkK2tEY0xIYTJaMkh5QlM4QTVxNUJGcHh0?=
 =?utf-8?B?c2IxMjBMdWltWS94bGFvWi9XQllYSUxvd3lLWjg4dTlmRDByL25neVVtNU9v?=
 =?utf-8?B?VWxxU044R0t4VHZIc1lZR3RXMzFuQ05pK3FqRUdZVytSQSs1RVFBYkRSOU84?=
 =?utf-8?B?M2dlcitWeFlUeFRpcUlMYzU4dWNjeE40WVZTYnNkQytiTlhNdjZuQlBaSURz?=
 =?utf-8?B?VTFlUWl3MXJ1L3QxY3NrNS94N3lrSHc5akR1V1luWUNrTFg3UHM3bkp2YXpN?=
 =?utf-8?B?aG5XeGJLajlGYmJSbnVPZVlqMElScTlaNzhKTEkvQUdwS3RjcllxbGdFWkpu?=
 =?utf-8?B?d1YrejloMkN0NXAySFVGYlJ1V202UHZwTDlUMkhNc0trUEZ4VStzc241Yzht?=
 =?utf-8?B?T1lZK3V4THhtd2Y5SzRpRFgzbEJXMzZnQWE4TWhWV1JrRVZPdE8rdHdPRVFp?=
 =?utf-8?B?L2dCbzZPdTRsU3RUZmc4MHY3amprdW1jcHdYWjdBZEE2WnpFZVFSRkZneUFP?=
 =?utf-8?B?SlU5WkExMmlGcU4rTHhjNWtBYWNsbTNTR1ErTUVRNm55T2xpRHFYaDkxSHk1?=
 =?utf-8?B?VEZPcHpoK0VHcmkwb3dlUmc1bFFCL1FNMk5pc2xPV3VBaHN1T09Fb3JkWTlJ?=
 =?utf-8?B?Q1diTW1MS3U0NnNpQnhhS0JoNHJZV1dtQkFTSldhaDU1bDhNNTVsMkxoUmsy?=
 =?utf-8?B?R1EwSTFBOTlSajZwYnpZaXJkOUZCV3BYbVhJcDRKSVlFMWwyWHZqbWpyTk0w?=
 =?utf-8?B?Y25aM01Ka0ttZDUxbno5RUNkdjdIQXpDcDN0SzJiODROcTgyUUdFd3A3R2lB?=
 =?utf-8?B?Q2xOZ2t0UlNHcmJ5WHpOKzJrTGlMVko3M01tVlBRSkE5QTR0OWEza0VGVFE4?=
 =?utf-8?B?VWh3aVRzZ3JCUFRmMmx1THZCL2hOa2g4MW4yRWJpWFB3M0tEUmtjSlVYMVow?=
 =?utf-8?B?WDZsQTNBS01hM280dWpqSmFkcGZlTkUwOVRlM3gyWUxEbWRCMmlYSmswaVIv?=
 =?utf-8?B?ckFZKzNON1p3RGFab3lKNENwNjdIc243OGRDQllqeS8xbUlOdkJWQWt1ZVlo?=
 =?utf-8?B?Q2QvODRoWWdMdWxiZHpmVzRtdmlScUs4dnJtREt3WWVsMXBYcy91NGZYTWpj?=
 =?utf-8?B?SitPSEc3SVNwYnlTQjV1T2NLVDd5UllpbThBZWhHdy9jVTlxV3VOQ2ZsdHZQ?=
 =?utf-8?B?ZFR4U3dNQjlQQWJ5T3dyWE1mRUU2MHF3aEVWZzlLK2M4ZjNPaDM1Wnp5Rmpw?=
 =?utf-8?B?ZXZjbERQeWExKzM5SHBwNHpKLzJpQlhuVmpxblAzeTFDUnd6SFIrSnIya0M2?=
 =?utf-8?B?Q2hkdXNid0JCRzhlR1c3VVYwS3NqWkFtVXB3QzRrUjJGYUpVbGJ5QUxvMHh6?=
 =?utf-8?B?UTNlS3g4U3ZGWmd3WDR3eVJTYjRpcDNsRFQ3OERMZEtFWGcxZC9LZUlZZW40?=
 =?utf-8?B?TFFHTmQ4RXY0MkphL2w5WXVkNlFtOHRHd1ViWjZkVjNaTnVjUU95UjRPcTNP?=
 =?utf-8?B?MjNDN09wamlaeCtXdFR6MmdTdlEzMFRlbXZ3cjdBcGhYMGJqamsvVHUwYmNi?=
 =?utf-8?B?ZGlVa3V0S1JsL0NpT2JIcmJ3K1NOb2RDSlJ2T3B4SVNSTnFlemwxS0dLMGtR?=
 =?utf-8?B?ZFZkb1l3UWZkK2tENjBGQmppTlUzSmNwQ3p0cGlUd0VZMEMvNm1jUHhjY3l4?=
 =?utf-8?B?R1NnVWhrdFg3aTFJcHFHaTJ0Nm56amJaVjRwMWtvcGx0eEt2SjhnS2Fla2Zi?=
 =?utf-8?B?Q1YvenRsMVdHbG9BLzVwZm9oM1FQYXlDM0hIZ0puTGFHY0djQm9CbW1VcmZy?=
 =?utf-8?B?dUw5VElNTmZGd3B4a0dNUk0zM0JjMjgvRUJJMlE3ZThXK3E3MDRHOVlaR1pj?=
 =?utf-8?B?Q0VtTEl6TmY2dFZWY2lkSHU1c3hRUEpsSWptdnhlaFplUkxWaTJBaVMyWFhi?=
 =?utf-8?B?ckJieTVPS3VkYVczMVV5NnFYV09SYis3M2lZaTRBZEtmaFVISmJoZ09KcW0x?=
 =?utf-8?B?WkFENEljcEN5eHkyQ1RITFZrazEwRHJBVWJZVEJ5MUlLa0Y5Tll5TU5tYXA0?=
 =?utf-8?B?SldUTFRzQiticjMzVXh3MkdFK3AwdnlWQXVENUdWb1RjMXhqQVNCRCtjai8y?=
 =?utf-8?B?cDh4NmptN3M1ckIwcWtOSkM4UjRYaVUxLzNCWndLZHo3eUp5bXRZUHVINkps?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E663A50C978A6499C0D611339F8BBF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YQ7VEQgB2YVmKQeAcIdsOgz3cSbRnCOSMYy+J5FqMWzleeP49yuFu1Ibw188W1ckb9rU4vm8QHJ8FRKnUAC02MlI746VGcA5xZ1FH3Am8GCm15NkrgYtflKptNwLVGR8dEZD2xPwSKulIKhBdDx8KpX1oaOtPSicnRVxdaTiq0Eg46UnXYcZXmdR7FvY1VE1FI7YaRVWkaIAKKocZStvQeXnl/XIACHCaBN/QyLPSKu/UF+aLpRJFn7rtauRwKgX+2AkepTU1ZRDybChi+s36L8bG80xRz5t+NpeLiPPQ9jUlihWElYsdJ3bU6HO21faPVQm377Vttk8dr0ofWmBkNA1YAP1xMAX01raZgWuiO8RpHZR77/t9GC6mDD+SC4oaL63BlzqiRUYziWePNkRHZCwhOvtsw8EAYLfe1FnGLzqOYo3urpnNLmK1FFy4resHD4bukXG5o0tgSR4zwFAkN1+j3UQA97twbI3XxMbZng6nSrV/JH6u75dkodXmBcRjh7e2qF4YXUHdaUgo6HdvWl/XCP5qngW3kPLToud0MSGwhBQ7fJxNgbsCr7FIcsoNwrzn4TUVWJogrdEJUkiNNjGTf3anCXw/ROuICmWgMAupCnxbAu9Ec/IjwKd7+pz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612235eb-66bf-469d-c7fd-08dcf41e1e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 11:22:16.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHt4lBy7DwMwt4fIx9dc9fChSX1wEDPCPVUfIvojklXC14kfk3dI57s3Tmru8c9odyx4qoBgs5QpckmE+pXeQ5RJ6l91Xue72UjscT5AVWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8395

T24gMjQuMTAuMjQgMTM6MTcsIFNhc2hhIExldmluIHdyb3RlOg0KPiBUaGlzIGlzIGEgbm90ZSB0
byBsZXQgeW91IGtub3cgdGhhdCBJJ3ZlIGp1c3QgYWRkZWQgdGhlIHBhdGNoIHRpdGxlZA0KPiAN
Cj4gICAgICBidHJmczogYWxzbyBhZGQgc3RyaXBlIGVudHJpZXMgZm9yIE5PQ09XIHdyaXRlcw0K
PiANCj4gdG8gdGhlIDYuMTEtc3RhYmxlIHRyZWUgd2hpY2ggY2FuIGJlIGZvdW5kIGF0Og0KPiAg
ICAgIGh0dHA6Ly93d3cua2VybmVsLm9yZy9naXQvP3A9bGludXgva2VybmVsL2dpdC9zdGFibGUv
c3RhYmxlLXF1ZXVlLmdpdDthPXN1bW1hcnkNCj4gDQo+IFRoZSBmaWxlbmFtZSBvZiB0aGUgcGF0
Y2ggaXM6DQo+ICAgICAgIGJ0cmZzLWFsc28tYWRkLXN0cmlwZS1lbnRyaWVzLWZvci1ub2Nvdy13
cml0ZXMucGF0Y2gNCj4gYW5kIGl0IGNhbiBiZSBmb3VuZCBpbiB0aGUgcXVldWUtNi4xMSBzdWJk
aXJlY3RvcnkuDQo+IA0KPiBJZiB5b3UsIG9yIGFueW9uZSBlbHNlLCBmZWVscyBpdCBzaG91bGQg
bm90IGJlIGFkZGVkIHRvIHRoZSBzdGFibGUgdHJlZSwNCj4gcGxlYXNlIGxldCA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4ga25vdyBhYm91dCBpdC4NCg0KDQpIZXkgU2FzaGEsDQoNCnRoaXMgcGF0
Y2ggaXMgZm9yIHRoZSBSQUlEIHN0cmlwZS10cmVlIGZlYXR1cmUgbWFya2VkIGFzIGV4cGVyaW1l
bnRhbCwgDQpzbyBJIGRvbid0IHRoaW5rIGl0J3MgbmVlZGVkIHRvIGJlIGJhY2twb3J0ZWQsIGFz
IG5vb25lIHNob3VsZCB1c2UgaXQgDQooYXBhcnQgZnJvbSB0ZXN0aW5nKS4NCg0KDQo+IA0KPiAN
Cj4gDQo+IGNvbW1pdCBlYzUwOGE1OTMwMDI0YjQwMDY0ZDcwY2IzZGJkZjg1Njc2MGNkZjVkDQo+
IEF1dGhvcjogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4N
Cj4gRGF0ZTogICBUaHUgU2VwIDE5IDEyOjE2OjM4IDIwMjQgKzAyMDANCj4gDQo+ICAgICAgYnRy
ZnM6IGFsc28gYWRkIHN0cmlwZSBlbnRyaWVzIGZvciBOT0NPVyB3cml0ZXMNCj4gICAgICANCj4g
ICAgICBbIFVwc3RyZWFtIGNvbW1pdCA5N2Y5NzgyMjc2ZmM5Y2IwZGUzN2E1ZWVjYjgyMjA0ZTQ4
YTVhNjEyIF0NCj4gICAgICANCj4gICAgICBOT0NPVyB3cml0ZXMgZG8gbm90IGdlbmVyYXRlIHN0
cmlwZV9leHRlbnQgZW50cmllcyBpbiB0aGUgUkFJRCBzdHJpcGUNCj4gICAgICB0cmVlLCBhcyB0
aGUgUkFJRCBzdHJpcGUtdHJlZSBmZWF0dXJlIGluaXRpYWxseSB3YXMgZGVzaWduZWQgd2l0aCBh
DQo+ICAgICAgem9uZWQgZmlsZXN5c3RlbSBpbiBtaW5kIGFuZCBvbiBhIHpvbmVkIGZpbGVzeXN0
ZW0sIHdlIGRvIG5vdCBhbGxvdyBOT0NPVw0KPiAgICAgIHdyaXRlcy4gQnV0IHRoZSBSQUlEIHN0
cmlwZS10cmVlIGZlYXR1cmUgaXMgaW5kZXBlbmRlbnQgZnJvbSB0aGUgem9uZWQNCj4gICAgICBm
ZWF0dXJlLCBzbyB3ZSBtdXN0IGFsc28gZG8gTk9DT1cgd3JpdGVzIGZvciBSQUlEIHN0cmlwZS10
cmVlIGZpbGVzeXN0ZW1zLg0KPiAgICAgIA0KPiAgICAgIFJldmlld2VkLWJ5OiBOYW9oaXJvIEFv
dGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPiAgICAgIFNpZ25lZC1vZmYtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+ICAgICAgU2lnbmVkLW9m
Zi1ieTogRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPg0KPiAgICAgIFNpZ25lZC1vZmYt
Ynk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4NCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KPiBpbmRleCBiMWI2NTY0YWI2OGYw
Li40ODE0OWMyZTY4OTU0IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9pbm9kZS5jDQo+ICsrKyBi
L2ZzL2J0cmZzL2lub2RlLmMNCj4gQEAgLTMwODcsNiArMzA4NywxMSBAQCBpbnQgYnRyZnNfZmlu
aXNoX29uZV9vcmRlcmVkKHN0cnVjdCBidHJmc19vcmRlcmVkX2V4dGVudCAqb3JkZXJlZF9leHRl
bnQpDQo+ICAgCQlyZXQgPSBidHJmc191cGRhdGVfaW5vZGVfZmFsbGJhY2sodHJhbnMsIGlub2Rl
KTsNCj4gICAJCWlmIChyZXQpIC8qIC1FTk9NRU0gb3IgY29ycnVwdGlvbiAqLw0KPiAgIAkJCWJ0
cmZzX2Fib3J0X3RyYW5zYWN0aW9uKHRyYW5zLCByZXQpOw0KPiArDQo+ICsJCXJldCA9IGJ0cmZz
X2luc2VydF9yYWlkX2V4dGVudCh0cmFucywgb3JkZXJlZF9leHRlbnQpOw0KPiArCQlpZiAocmV0
KQ0KPiArCQkJYnRyZnNfYWJvcnRfdHJhbnNhY3Rpb24odHJhbnMsIHJldCk7DQo+ICsNCj4gICAJ
CWdvdG8gb3V0Ow0KPiAgIAl9DQo+ICAgDQo+IA0KDQo=

