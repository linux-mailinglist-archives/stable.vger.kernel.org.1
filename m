Return-Path: <stable+bounces-45409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596448C9176
	for <lists+stable@lfdr.de>; Sat, 18 May 2024 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C93F1C20C5F
	for <lists+stable@lfdr.de>; Sat, 18 May 2024 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551022EE8;
	Sat, 18 May 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MtUeYyHr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ROQlClWK"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754015AF1
	for <stable@vger.kernel.org>; Sat, 18 May 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716043843; cv=fail; b=Jn2hRYkqL6eN/ya1w87XwtUKI1EwaGZm/Ui1CQleytBOrc6MZZZcUZrMViF+w/z3OFtIfWADKiQQ2eVdodoMvVF14JEFC6DJlEev3oqHerE9UKpxFH+7zHujpE9PcR/0kVpXp3Cs67igCTeldAg37kRH++M17vq6fpTGhGqsLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716043843; c=relaxed/simple;
	bh=YLRun66u09WfcYcvHLMbi7KL0PXMgpyQV0gvJ2fUzgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OdfAG/IxDeiVAFF40ShkfwRXsJN5CnfFgKMEso7psQhny8IOWhjNWeVmvIbGSzBkL0wfJAOvTqSEX5c8YFM4xjYGZ2cvsZM7Vtc8f8J30gumXtP2EGr+bzS1YcUcB3gKk6jGkiu51Vaio7YU2phzk7LuHbs0oMUUpjD7uyzA9oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MtUeYyHr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ROQlClWK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44IDNZEK024939;
	Sat, 18 May 2024 14:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YLRun66u09WfcYcvHLMbi7KL0PXMgpyQV0gvJ2fUzgc=;
 b=MtUeYyHr2rwtZKFT4RoKXv72Y0yBgQxk1p0BvHFJzF5xAoG3xLZy5cqRO90NoQjrpWjd
 BE5cOrC1Du0sAAGq/z2zhna9U43AGg1Q0c+FYPy6KnbroWVWSZ7Bs5lrrCy+ybZmm1vk
 2YpOQlsO7fMBQ8YLZ+CSsR/V7k+JmlsYwPzQeku8++TMboEFTErvUgwvKEQWNNRW27O/
 O6Ras5UjRUEhotLiFC01se0+EdEOgmy62RIPo+CDcmghIoQc6tQdkCJsAe5nFFrb58Pl
 yp8lsKoITg0q6VwOsa/4hPTgCXwyopHspHmHI6HAlu0cu6SKCs/IZq79zZ/ktE5ctIFN 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d0cmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 May 2024 14:50:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44IAOOga013772;
	Sat, 18 May 2024 14:50:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js44afb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 May 2024 14:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGI/+KnNUyWYwgMgE7x1VUFyGDLdqXqjjvFqEXTc8tqovqiZUF/RRwEMujs0nTht2+RUP8XRwvbL34/Sw4SCUsEmKE10oEqeQbL7aRBkR0x4WKfllVjW8uRr9kW++SJvCZB2zHywdEHD50pDBXK7G2m094AjeT5Qqgfr7/LolW/5cT1gU3mQXhNrn41aQyyLFql8lsxBMa5aELBB6nTAT1AvT0zb10eGOnAoaDUOrYEOf47q1Sz+8IOPqdEm6ghdKIeFEmXY5pMzu2onSeh5UnMaOM//uOIuhqTMgikSVNwGkz+RTTxx+Gsp3i+MqewRfQM2C8Z1aoyFZJo0HgBHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLRun66u09WfcYcvHLMbi7KL0PXMgpyQV0gvJ2fUzgc=;
 b=QzUi/aPLPb6NQAhibDmpHrmqomoUqRzLK1vW5PZB0x3qWTN6LejPAmnbmgpiftUFLRiPl3s5ks6lOWpLQSR5cJISHw5x4VcykTkN61zuGhiMP3GQWQ48bU8syFuX/x/pXKNBNJ7rEf2gIaiWU/tSPNfpf+K6aBeAWr4z86IejXKxfj34R5Qej/QmZwgbY6PRtSZR4LrVHCovdIh+Jby/YrwX9LFAWwpWmQxJNH4gLXj6oJvgN0Vber2OUXYzyVp1UHii2XgMWl+KEjCDPd98ASlDs3D7rQwRFTgQddJ0Y+7T0CxzNt+B4ZuYxByXEPHcWoZdTkFx/jPmN0SwioHqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLRun66u09WfcYcvHLMbi7KL0PXMgpyQV0gvJ2fUzgc=;
 b=ROQlClWKX3cYgGgzyvKJnJOZE8b5R1DO2QN3+j21jJCeRW22OdWxryRdO8NDpJQNzR34ToalFXzHmFLsPql8Cu8a5cselqrM6sU68fxetk8I8zzk2+wsKp/QnV+kPcplfnbJNDDqI3fSkpFW+Bmvv25/JhMPK44Bogrs1DrSfKg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6652.namprd10.prod.outlook.com (2603:10b6:510:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Sat, 18 May
 2024 14:50:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7587.030; Sat, 18 May 2024
 14:50:29 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Chuck Lever <cel@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-stable <stable@vger.kernel.org>, Neil Brown <neilb@suse.de>,
        Jeff
 Layton <jlayton@kernel.org>
Subject: Re: [PATCH 5.15] nfsd: don't allow nfsd threads to be signalled.
Thread-Topic: [PATCH 5.15] nfsd: don't allow nfsd threads to be signalled.
Thread-Index: AQHaqIQOvZL3xIPq60Wgh0hUutPh3bGcZCWAgACwOQA=
Date: Sat, 18 May 2024 14:50:29 +0000
Message-ID: <AB2A4522-7E62-4E40-AEA6-E41F2F835E2F@oracle.com>
References: <20240517175930.365694-1-cel@kernel.org>
 <2024051859-fossil-exposable-722d@gregkh>
In-Reply-To: <2024051859-fossil-exposable-722d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6652:EE_
x-ms-office365-filtering-correlation-id: bbd37e4a-879e-4633-8139-08dc7749dc48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TUtrSVFSdkJtVGVVeGZ2eStvL0pEZndLWEZUaG9vazNGeVloWTRzUVBWKzRl?=
 =?utf-8?B?aWYxYit3OUpPVlBKeE4xVmZLRE9UNHk0bmROaytubzVqTmRVMFVPeHdBaTJX?=
 =?utf-8?B?Zm9NWm9XL1pLRXhaS2RZSG9kNEkyZDZ2MTI5TC93aUZkSjh4b1pjbXg5QWtE?=
 =?utf-8?B?K2ZUV1pKRGhUZ1F0QWRyUlprMU9ERlNXRnhGRWlsbkE1TUs4T2pBdk5PSE8y?=
 =?utf-8?B?eXA2WDh3Q0d0cVJRQkN1N09QN3pMLzBqWnpUNlVhZ25ndUkzVVArRVlaQVpk?=
 =?utf-8?B?ZTJsMC8wdjZGZ29jRnI5L2YzcmVvbEJQUVphY2dVemJtSjVtQ1JVaktJWjdw?=
 =?utf-8?B?TWhVZ01RTy9EMmIyRFVKaWxTblhsS2FFdjhBMzY4dG1CaEdSendZNlRYMmp1?=
 =?utf-8?B?ZTVUZEUvNUFEaTU1a281aXpyRGdPbFp5VUxJRDY3RjdQVllSOUUzQVJMUVkw?=
 =?utf-8?B?cUk1b0xSdzlyWmVWR1VqMm5hY21TdU9WWWdzQjFtNTlVaGhYNFVBQktjQlZ4?=
 =?utf-8?B?QkcrWXdnTERlc0dvc0p1TVA2NzZlVzVtQ3BRZmpVNFBubFBkOEZoUEQ1NXVT?=
 =?utf-8?B?SkNhdE44WnE1UktlMTFncHZyN1ZNRUpNcTdNSU9LTXJEZ2MvV2hXMHQ1Q05Z?=
 =?utf-8?B?cE5ZM3lSVGk4aEhHSi9LNUQyTDU2RWx6UE1QblZ6VU9TMzlpakttdW9uU0h2?=
 =?utf-8?B?R1BZMDd5YVBaM3dSZDR0N1FLUitoYkNISXVwUExiODhBbW43QnQzWHNLNUlr?=
 =?utf-8?B?cVVJc1ZTUWp3RDRGMzZpY21pK1MzeEdxTlphN09CdURGQ2NuK3Y3RzRQNThL?=
 =?utf-8?B?N2FnOXVWQWpBblJRWmlzTGVkSk5VMWdpNUpES1NwQ0o1aDJGVTk4KzZTNmYw?=
 =?utf-8?B?T3lOc1NDV010bEwyZUNqRzlYYTExcHhnUThDa21rT3IwbVRPWHhiOUtNdTQ1?=
 =?utf-8?B?SGxhSTY4TG5pS0RTUWhkN0hHSUZSY3VvS3l5VmpEd1J4bXpFY0JMWkl4SFF0?=
 =?utf-8?B?dHNRdzZyYzY3WkZ0U21KeUxNN3FxclJWa0tCL1d6TUNCeWFQSGNva1FBVjlZ?=
 =?utf-8?B?dWxuOFg3OEhjRHh6ZzhScnp2NHdrZVBaOHdFMlRiT2hsVWUvZnF2aGhIYloy?=
 =?utf-8?B?SzlESnVTQXNVYnJxbmdVd1Z3ZlVJNzE1YktzU3FmU0ZBeDBmS1JTdU1FTEsw?=
 =?utf-8?B?aEh1Snd1cmRZWXhBZ3lGTUprZno4YXBUNXFVekVxcTNrZkF5cGY4ZktmTzRh?=
 =?utf-8?B?SnhXSFpyT3dMOFZLNmtjZEI4bGhFblVlZjh5c05jRUdkVmRnWUFuZnV0ZTFX?=
 =?utf-8?B?NzdxV3NzRTF0NkxHclVLMzFtdjd4ak9KS1JIQkFVM0tMVkVIYit6MExLWUI0?=
 =?utf-8?B?enp0cHBpZlVrQ0ZBVXp4aytvajc1eVVCZmtNS3RDcGtOMklKZ3IxR3hFMlhr?=
 =?utf-8?B?bktScGtWTFFZYzdwQVVXd3BxdXNhdkF1L0xCRzhYejlKV2R6OTlsNGR5WUds?=
 =?utf-8?B?bmo2ZE1sN2xSd0ZOWExsektwalBySlVJcmxBTkwxY1hwcUhBR3RVd3BsR3VY?=
 =?utf-8?B?ZVh0cVZRUFFYblNuM0hlQ1AvS01UQUxHakQ0Smw0bXpmSko5UG90NDIyNFg2?=
 =?utf-8?B?TXFyQUdEL21oUnk0QmNJaHJncUtnWmw1RGk4VzVIaVFsY1NzTVRDaFZodFgw?=
 =?utf-8?B?RUVCeHhaUXJwYlJvY0JvSnJJRjc4dlg4M2F3MHA1WWp4TGt5MTZtSk1Eb2hY?=
 =?utf-8?B?MUxKVms5MnhMMkRqS2Y5ZFhTNk44NU0vTVZZbVRGaWJ2eXpnTVdyWWZBZnl3?=
 =?utf-8?B?Sko0TEFVYWVLTXhnWEhFQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VktHL2hLQTRyQXRPSG1kU0llUkNEdzZ6SmhKcTlQZ2xxRTJjSUtEdjNQbGV6?=
 =?utf-8?B?VFR3R1ltV285UkVOK2dHNjE2TkhEYWsrUmxVWEVSa2pqb1VldlVHUTFZZ3pu?=
 =?utf-8?B?QzhuNHo5Znl6a2V5QitCQTNUdlJzcEV0ZHU2TVdqRDR6d0JoemhNNW1Od0pN?=
 =?utf-8?B?R2ZPbTRXZEttQ2NtaVQ3dDNVb29nY2Q1eVZTbUp3eko4cWxJeWJPeTNOdWJG?=
 =?utf-8?B?VGtkeGZVSUNLaVdqL1o2cDFDalJZZ0dRODRzcW1CbjlMWGd5QVovbzJYbUFk?=
 =?utf-8?B?ekhtaFZ3TFJTeURTYWRRSTBodVcyd0hXczFxV3BSWVVNbEZYRW44aENMeExZ?=
 =?utf-8?B?dFIyaE80STZBWkU5akFXMnZlY3ZuZXBuaUZSTU8rVTNkSUNPTlgvcGRhdnFG?=
 =?utf-8?B?dm5LSEVWYUlSSVhDNVZabGR6cnFQcUNFK2ZBcjVuUDlmdzlXdXZ0d0NjTVFl?=
 =?utf-8?B?bWdtRjJsNDA4MVV6SmtBRFJ3VmRqcEM1blZ3a1M3d1g3YitPWldwQ2EzNk91?=
 =?utf-8?B?MG1yMC96N3BoajdlSm9aYkZxOFRJbnNHaWFPOUFia0JJbDdHM3pJc2FkQTNw?=
 =?utf-8?B?QUE4bkNTRTh2Q0d1TURxTUhWb3ZSTCt4V3E2aFJkalp6eWJTcnRCem1GakRr?=
 =?utf-8?B?NnlhT1V3VExuZVBDZnNmMjRwS3gvSjhXSVVjT3VMdVlkb1F3bXpnUnRKcDIv?=
 =?utf-8?B?MDJPSVptQ3BSTDZmamZHRlBQMm9UY1lXbEFRQjZHZ2RCVkJvOWtpdnEreTVU?=
 =?utf-8?B?RG9wSW9zUnVaQUttb21QLzdTY1lUNjNaWXU5QmtyQ3VJb0lBWUY4azZFWDNT?=
 =?utf-8?B?aDU1bEpRSEJiWU5YbE1KclJsQ2I0cFY5UEF6MUNyaDIxVFNLZmU1RTI4Y0Yv?=
 =?utf-8?B?NVEzWHlkYUVhOHBFSVZZUlUwalZiV28vZkl3Um0vMmNGYWRCUks0MC9HM1oy?=
 =?utf-8?B?Tmsza1RvelhIRzV4WWluKzcyTkJSbkRpZE1NTXFtZlRsUkpBQmE3TXZ6TFRD?=
 =?utf-8?B?cFc2M0pBYkF6L0J2cVlvcllKOEFNRjV3bkRUOUNPT1hhaVdMK01VekNYRjgv?=
 =?utf-8?B?T3dlUHlGSzEwZFhpV2hLQVdmTGo2QlMvRlJGMUg4eStxUEw4bkxUMFF0aHJ4?=
 =?utf-8?B?akMxQ0lNYjhmenA5d0o5cUtSVnA5L0c0K240K3FoTDEySTZ3WG9nUmJNY3VJ?=
 =?utf-8?B?eGlXbSt1Q3RBUEdxeTFmOHlLYUtzRHNFNVNFaTZycjh3T3ZBTzNtQkNoWlhO?=
 =?utf-8?B?RHM3bEtTNDh3OGtjRWNEYjRIUWd4Q0dIUUIyNlV4Ni95N3FueVFpSkVaYmhp?=
 =?utf-8?B?TlJodDdPeE43MllIWENUeXhJV0lab0VUNHN0WmdpTTlzQnM1ZWU2enVMV05E?=
 =?utf-8?B?V0JFRDgyWmdJbWZmajVVcjdtNndBcEg1NmdpRVYwSHRnRVBYZDgwK0RyMmNN?=
 =?utf-8?B?L291QUhVOXVBZHdkYkx5QktlSm9iMS82UCtHdU0zS1UzMHYxUWhyTG1qQ2VQ?=
 =?utf-8?B?c0xOM2pXQUR6VFd2QkRVZlQxVWVzTXFGWUZmL1ZKQ016SEtGQTdDNWsyNkdE?=
 =?utf-8?B?TnFjT21IeVNjdW1UOG8xRExhbnpEaWU5Rm9BbnRjZ3ZSMEZWTHRqWUt6WnF0?=
 =?utf-8?B?YzNPeUh5S0FRL0hMSGhrQmIzZjIyakJPQ2JpNTRWbmx2VnlPWkhrZG1TOXJW?=
 =?utf-8?B?d1NIdko3ODhmd09BTWM2cVFhRk1RZE9Bamh2bWxUVHF3OUNPekk3WXNRSjk1?=
 =?utf-8?B?K2hteVlXYjJvQ29jaVVnazZzM3Y5YVgyNWRxVDZBRlc0cGxhYjNOclRtVW5j?=
 =?utf-8?B?clQrNEtrdWVzb0pSTzlPZmgyTUtjRFNQMXhIZGRIdTNSMXdqQTJoL0NIdnJQ?=
 =?utf-8?B?VStuY2t1K1daZEpmTGg1cHZqZWtzZGdhL0cwNDB4d1NaQmxVMlpDWlNSSHJO?=
 =?utf-8?B?dlkzRnNMRnVaVEZjNHZvR0F0ZTVhNUMwMHdvZ3VWMDZOT0RVYlI0K09WSjA2?=
 =?utf-8?B?NUI1akQ3cjRGSzRwald4R0V4SGhFeEpDczRlZk5HWFNWcjNoMm1sVGtSbjRW?=
 =?utf-8?B?ZmxNdWl6RWYyZk5IRWcrbFJyUkRnQXNsZGdRQ1hEanJxcURsWWN4SWxxWTF3?=
 =?utf-8?B?QTNCWjVHSk5zVXRFWm1LK2J1aWFxK3BzTEJwQVh5S0c5VXFzR2ZCQVh3dVNx?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9275DE343AACA4D9FA66F35509EE839@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aaKwlumTcCUMAwnQ/pxCW/QjHFVG1sI0FXuP2lV5BEo7lgULlSSmGuSdMMzuUpkNaSrh5gfw3plvrW7E53p4FTbUe1nZpw8TPxsVhuC8Lbf9eHCUKR9YRsFiWvvBTgThj3JmHKhQsIhh2DHg3X44BAQ5wl7HT8ERwxigsTb13alYJjKfaEI6m9o1cGodJBxdQyiy0KZ1wq94MaiYoV4hWGDk0VYklhAsBHPSb/OOiBwljrmz9kfKKyxWmqNLOt9U2nYTS0m/xLVb0eoNSC0ItUNQEcFQ6aIGZZrD0zVyQGxosJs6q2HzGdUZDs8FavffVQKcMZXUum8zT9IGfpUJknDTnbO2ECJ+ZYd49JPMliPpoTiMDOaFJepXz0qxc1o1lwABKRCQW7as9jTatohzfN+EeXWIhtVRUxgwtIIey3mGVPRXNtjwC4v9+Z06d1X9U83UKo7wt/93jYzVM+tRthTgiO2i+SnVCTd3P1CozF2tnYCiGSQFmznl3OqtFzD9vQKOg0z4qzspePUqjf3bwX2C53jb1TX9notc6uqQo+FtEc3svbR+DTiGY8cfQy452NlbQu/sd4VuPYu2crpUHU5iw5JH5E87ucWVS6k1ZxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd37e4a-879e-4633-8139-08dc7749dc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2024 14:50:29.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+WjE4fkGagiT++o/7uOxnclxnyapwyTubKcFhk2nQOqA322+TRoy2hgIKFV2VXS9QBFqYxCCmWWI2SgJvmPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_08,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=864
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405180116
X-Proofpoint-GUID: qXUtFC6MGUFX6kZHShUpOAa_piPJkOYQ
X-Proofpoint-ORIG-GUID: qXUtFC6MGUFX6kZHShUpOAa_piPJkOYQ

DQoNCj4gT24gTWF5IDE4LCAyMDI0LCBhdCAxMjoxOeKAr0FNLCBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTWF5IDE3
LCAyMDI0IGF0IDAxOjU5OjMwUE0gLTA0MDAsIGNlbEBrZXJuZWwub3JnIHdyb3RlOg0KPj4gRnJv
bTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPg0KPj4gDQo+PiBbIFVwc3RyZWFtIGNvbW1pdCAz
OTAzOTAyNDAxNDUxYjFjZDlkNzk3YThjNzk3NjllYjI2YWM3ZmU1IF0NCj4+IA0KPj4gVGhlIG9y
aWdpbmFsIGltcGxlbWVudGF0aW9uIG9mIG5mc2QgdXNlZCBzaWduYWxzIHRvIHN0b3AgdGhyZWFk
cyBkdXJpbmcNCj4+IHNodXRkb3duLg0KPj4gSW4gTGludXggMi4zLjQ2cHJlNSBuZnNkIGdhaW5l
ZCB0aGUgYWJpbGl0eSB0byBzaHV0ZG93biB0aHJlYWRzDQo+PiBpbnRlcm5hbGx5IGl0IGlmIHdh
cyBhc2tlZCB0byBydW4gIjAiIHRocmVhZHMuICBBZnRlciB0aGlzIHVzZXItc3BhY2UNCj4+IHRy
YW5zaXRpb25lZCB0byB1c2luZyAicnBjLm5mc2QgMCIgdG8gc3RvcCBuZnNkIGFuZCBzZW5kaW5n
IHNpZ25hbHMgdG8NCj4+IHRocmVhZHMgd2FzIG5vIGxvbmdlciBhbiBpbXBvcnRhbnQgcGFydCBv
ZiB0aGUgQVBJLg0KPj4gDQo+PiBJbiBjb21taXQgM2ViZGJlNTIwM2E4ICgiU1VOUlBDOiBkaXNj
YXJkIHN2b19zZXR1cCBhbmQgcmVuYW1lDQo+PiBzdmNfc2V0X251bV90aHJlYWRzX3N5bmMoKSIp
ICh2NS4xNy1yYzF+NzVeMn40MSkgd2UgZmluYWxseSByZW1vdmVkIHRoZQ0KPj4gdXNlIG9mIHNp
Z25hbHMgZm9yIHN0b3BwaW5nIHRocmVhZHMsIHVzaW5nIGt0aHJlYWRfc3RvcCgpIGluc3RlYWQu
DQo+PiANCj4+IFRoaXMgcGF0Y2ggbWFrZXMgdGhlICJvYnZpb3VzIiBuZXh0IHN0ZXAgYW5kIHJl
bW92ZXMgdGhlIGFiaWxpdHkgdG8NCj4+IHNpZ25hbCBuZnNkIHRocmVhZHMgLSBvciBhbnkgc3Zj
IHRocmVhZHMuICBuZnNkIHN0b3BzIGFsbG93aW5nIHNpZ25hbHMNCj4+IGFuZCB3ZSBkb24ndCBj
aGVjayBmb3IgdGhlaXIgZGVsaXZlcnkgYW55IG1vcmUuDQo+PiANCj4+IFRoaXMgd2lsbCBhbGxv
dyBmb3Igc29tZSBzaW1wbGlmaWNhdGlvbiBpbiBsYXRlciBwYXRjaGVzLg0KPj4gDQo+PiBBIGNo
YW5nZSB3b3J0aCBub3RpbmcgaXMgaW4gbmZzZDRfc3NjX3NldHVwX2R1bCgpLiAgVGhlcmUgd2Fz
IHByZXZpb3VzbHkNCj4+IGEgc2lnbmFsX3BlbmRpbmcoKSBjaGVjayB3aGljaCB3b3VsZCBvbmx5
IHN1Y2NlZWQgd2hlbiB0aGUgdGhyZWFkIHdhcw0KPj4gYmVpbmcgc2h1dCBkb3duLiAgSXQgc2hv
dWxkIHJlYWxseSBoYXZlIHRlc3RlZCBrdGhyZWFkX3Nob3VsZF9zdG9wKCkgYXMNCj4+IHdlbGwu
ICBOb3cgaXQganVzdCBkb2VzIHRoZSBsYXR0ZXIsIG5vdCB0aGUgZm9ybWVyLg0KPj4gDQo+PiBT
aWduZWQtb2ZmLWJ5OiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+DQo+PiBSZXZpZXdlZC1ieTog
SmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IENodWNr
IExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBmcy9uZnMvY2FsbGJh
Y2suYyAgICAgfCAgOSArLS0tLS0tLS0NCj4+IGZzL25mc2QvbmZzNHByb2MuYyAgICB8ICA1ICsr
LS0tDQo+PiBmcy9uZnNkL25mc3N2Yy5jICAgICAgfCAxMiAtLS0tLS0tLS0tLS0NCj4+IG5ldC9z
dW5ycGMvc3ZjX3hwcnQuYyB8IDE2ICsrKysrKy0tLS0tLS0tLS0NCj4+IDQgZmlsZXMgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCj4+IA0KPj4gR3JlZywgU2FzaGEg
LSBUaGlzIGlzIHRoZSB0aGlyZCByZXNlbmQgZm9yIHRoaXMgZml4LiBXaHkgaXNuJ3QgaXQNCj4+
IGFwcGxpZWQgdG8gb3JpZ2luL2xpbnV4LTUuMTUueSB5ZXQ/DQo+IA0KPiBJIG9ubHkgc2VlIG9u
ZSBwcmV2aW91cyBzZW5kLCB3aGVyZSBpcyB0aGUgc2Vjb25kPw0KPiANCj4gQW55d2F5LCB3ZSBh
cmUgd29ya2luZyB0byBjYXRjaCB1cCwgdGhlcmUncyBiZWVuIGEgZmV3IGh1bmRyZWQgb3RoZXIN
Cj4gY29tbWl0cyB0aGF0IHdlcmUgYWxzbyBuZWVkZWQgOikNCg0KVGhhdCdzIHdoYXQgSSB0aG91
Z2h0IGF0IGZpcnN0LCBidXQgaXQncyBiZWVuIGEgd2hpbGUhIEkgd2lsbCBsZWF2ZQ0KeW91IHRv
IGl0Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

