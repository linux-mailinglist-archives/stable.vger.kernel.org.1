Return-Path: <stable+bounces-45587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA088CC47D
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB8FB212ED
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3C22EEF;
	Wed, 22 May 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GULwHivX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wNHFm2Jx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80395101EC
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393135; cv=fail; b=i1eju1y4b3Zv/CA6SSBVA2j6hOYX2DeWp3tUlS5OaK6fbrZ1VFpBhkEmFYoAmCPgWWn60DQus7tjthI2gHKpJJ5AAohDr7wje7lt1wFz2MkK11/6hq4iOHvisx6v8cp9iAS5ZCiGiOFD+LXI6QVQt09TrASD5bspq6d+EtFSsVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393135; c=relaxed/simple;
	bh=Bv/hLboKobYULs5vM0EttdahyOC/tfk0eSUe2GGE0AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SriesFZqOT5NEOOkd6/iwvnrDUZMzLFm5BtJHSnPKAAGw+qS2OnuuMGMPRa34Nh2ZI1zMnEpjNZKJFsA1L3VxphfUxupGGiPlWep96DQX9CnNLmNMX3acn9NFLbbaPLetRYiFuIscIIbrCIoUZY9SsUj7z/ETfEp15SaBl34PV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GULwHivX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wNHFm2Jx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEnwWN019030;
	Wed, 22 May 2024 15:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Bv/hLboKobYULs5vM0EttdahyOC/tfk0eSUe2GGE0AE=;
 b=GULwHivXlVE/XxbP0/OzupNrLZLB8OZ6z8Qhje0zXaFz0rsLRpMRdPt4zYREUxfDR7hA
 uCm3qFcc85pgoHSpWwhWTcYgA2XTq1jYv9GgYkIdnJnUxi5e0AYgIQxBOJC3ggZNHiMg
 o5jmoBBuoGdbOIKodfTBzR+oOHgc1emeRn59yhhLHQEgCy3lgU22e6icOduytvEatARo
 LbOiKC8hFXNl0wYnT1nDGXmY6SwljATy54ndmcUWM4GdGD7H43XRkSD5+CVYK7dSVCh4
 9AoEVXKJi321YypCoCyWAkH4DQWOR8h2VKQXW2+vDPtYjzN4ztizFmjRV4T+6mt4xbQg nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d82dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 15:52:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MFRxIi025734;
	Wed, 22 May 2024 15:52:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9pfn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 15:52:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HITlNC2C07WtaTqZkvhPvFv15PPvoWVVKmv53w1aYOZactxVClf8y2RUX7Hpi1qGMRc3NaJ7Sw95vT8FY0Rv7OMklwfIU3FUSm74z7QsJ8uHgNn1o9uSWI/2jupwsD6f92f4xZaEbQ0uryUqZ85IPXmLSAZ48R764wXjvhuP5qbhMHVgMKcNhDkMfyArpEHam3J17WcS1lR69myhZ1d4k94Z2rkpTIe4mPJ8HziBGIXhBK92H2Xj6PbcZX6mAXPIImtafmaxf2gqNiy8cr/hmv3afIjWD3Vos5s6tLQTBYWZ/thEpQ33ZLZPx7mbYDavnrjH3C6iJe8JULaH57nTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv/hLboKobYULs5vM0EttdahyOC/tfk0eSUe2GGE0AE=;
 b=UCY53BzjtH9O7OUnLwk/xf7gH0UYia8ABRahsGrfNLxCp8O9K43dyH0pLhQqNAxQ/Z8uJoCdHX1QCy+Qn8HKGW7wOsbqWmOikkbtS6HikOI8hdDiaHt2QOnUrf7OsvhNJz4LWlWlq4fQu+LZtwaNGbM+eCbUnLTqYPA7CgX9wq3OmHKi3IIS4Y/JpypsZb3AVb7bciAs3/QZuogmx8kGyZII87FWSQzgBdIYVK4loVbk7mTJu6p+vmEvUrhfwCvnSGuU6UWpRqrGZpg3OlUvn0PAGwylFk8XD5tLnwtH3qhaKWwiVwrfJx9RYll1mZln8soN8IAxyMUPUCNkGa5lHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv/hLboKobYULs5vM0EttdahyOC/tfk0eSUe2GGE0AE=;
 b=wNHFm2JxZaqdmsl07XUKAfnQjFx4sKVdxXntePwvSztbH8jC0uqE9YjgnfZ8HqMCX0JEHjNpEqCRs8ILjnwcOZtTOYbuh3U1XqeF9z1FDaDcKptCWPuv9BwA46KDNEOpWbDOOq2d5Facx0LbMHVIA9knztqvhY0gL5qH4nmfE0Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 15:52:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 15:52:04 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
        Neil
 Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5.15.y] nfsd: don't allow nfsd threads to be signalled.
Thread-Topic: [PATCH v5.15.y] nfsd: don't allow nfsd threads to be signalled.
Thread-Index: AQHarF/XXZnaHkimmUOufDLDktuOqbGjZy6A
Date: Wed, 22 May 2024 15:52:04 +0000
Message-ID: <2DF9BAD8-66F4-45D0-B714-079E07D65932@oracle.com>
References: <20240503170000.752108-1-cel@kernel.org>
 <2024052217-unguarded-cardinal-a639@gregkh>
In-Reply-To: <2024052217-unguarded-cardinal-a639@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4557:EE_
x-ms-office365-filtering-correlation-id: 20cd19a7-f6b7-4411-c2c3-08dc7a772053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dkJTWmV0d0NTK1NUcU1ka2NFYVhtVzdOaXRpdm5HQ3hGZEdLTXJyMkdWdmNU?=
 =?utf-8?B?TnZPb2V6bGtNV2RwMkIzUFo3ZGJydnJ5ZXhjSzUvYUQ4NHlsN1dLRWw2M29k?=
 =?utf-8?B?YjMrYnN4ZGJnazZ6YUZDSEZDYU9Fc2xSZHo4RVRGSGRieW50dGkzeXo5WnpI?=
 =?utf-8?B?YWQvMnF2bm9pdlNmNVpEMUd4eFp5WEFGVEdHK09LM2o4dGlqb01lVjB0bkNx?=
 =?utf-8?B?N2hTaEJUci90WmdCVzBNOG1zVklMayt3S3N4aEdmUVBjR2ltYlFYRjhlWmVh?=
 =?utf-8?B?SjNubFBvYllDMjVGSWtrY2Q5SEVTdHo5bFJqS1hkTi9KVWw2Y05YNmNLOXpi?=
 =?utf-8?B?aitrd1ZrS2ptSktwU2pGclBpNTZnSlhYMmNWOEUxWThGS0s5WHc2S0pVS29w?=
 =?utf-8?B?blJKYjQyVnB6bnN5eElpNkhGaG5udk5leHUxQmU5ak95cmwweWtFMWg1Y3gr?=
 =?utf-8?B?L2xrR1VKQ1MwamtFTStBN01lbms5cEpUMjlWZFFGeUxVNGk2ZnJ5RHJSNGtW?=
 =?utf-8?B?Sm93Z2RGSndnTnAvOWEzcGYvYjVCVkJOcWNjTlJkTDlZOUFOSnRHUGF2ZExP?=
 =?utf-8?B?N0JnRjR5a1ZnL20wSTNJSTdNbXlmVjVVbnlyeGRWR29YWnJib2g1aFAwdGFP?=
 =?utf-8?B?ZHJnUU0rTXdMRnY5anVLSEJweHNwNWJYd1Q3MitNdHI4VS85c3ZsNkVkL1E5?=
 =?utf-8?B?MVZtZlRodkQwMWdJS2xjZFpvTlhGSW9rNGpobHNCeSs4UGp0U0J4Vmk2T0VR?=
 =?utf-8?B?dWtQNjFVUGJRenY1ODRNYW0vZWQ4SDVCWWwxUWZWaEJ0T3had29UQWQyMisw?=
 =?utf-8?B?SW9SYmRhTkVBVUdzZnpGNVBXSGRmWXhVTzgrSWJhQlN2S0RkNTJFSGtBS3BL?=
 =?utf-8?B?U2kwZXBSVVVYNmlXZnBnaUtnTlNycXJnVGYzL0JVLytoeEVrUUM3ZVhOeXBH?=
 =?utf-8?B?VlNsMHhhUU1kRzVmTWJ1VUpDU1p3b2NFZE5vUUVtRGhkQnBkOVpNY2xUWHBW?=
 =?utf-8?B?ZFFWWTIyc1RNQWtId2xTTDQ0UnJ6UUtMUnZGc0t6VUtPeGFVZXhCek4rUW0v?=
 =?utf-8?B?WEY2Tm9yV3RCSzg1bWs4SFJZeWQ4Vzl0UmVtM1J4WEVralFiT0NKNEZKdkZ2?=
 =?utf-8?B?d09vSHZTdjhuUk1QRUw3LytMTmNuYjI4ZEpFTTRaYnFzSkhVNjZVWmMrWXF2?=
 =?utf-8?B?TWVDRER1N01LNkFqUDFKR1VlN0o5UWdzV3lSWHBnNG9sTTdpclQxOW5FT2wr?=
 =?utf-8?B?SjF5amQ3YktCYUhkSXhBWElBeCtPTFRVaEhqaS96dkxrTzRndi9DME1HVG41?=
 =?utf-8?B?blJoWkUvU2RIaUlyTG5UOEhCeEIwa0M1UktDQkFGeGs0RmhPKzdHdFRmQ2tw?=
 =?utf-8?B?NlVBVWdVOTNNOThQcDdKWmdOa29OVnZ5TnB6eGN6b1g3TUFWd1hMQzMwc2JV?=
 =?utf-8?B?aEk2ZU9WVDBrVVRSZkJWcW1rYnZEdjdDNVBHTUc5M0NZYlphaFh2TTdJM0hR?=
 =?utf-8?B?aDVGeUdpY3pvV2lHd1o0czE4MWZ2WWI5Q2JJaDl1NmhzTWx6ekJqWVBkMzB6?=
 =?utf-8?B?d3JWK3ZNaHUvam9hQkRraVhUNlJKeEdwdjJ0dlVkeGNPYklTaW9uR0Yvbno5?=
 =?utf-8?B?aVljZGRXVzhWNjh3RkQrOHFtdXZBNmlVUFNyNncwN1BXd2J4bUtmbi9YQnQz?=
 =?utf-8?B?ZzQ0YktPMHc2NGFtUlJXR2lLa21nUUYvQUhFL0VKMjEzdGNXY0hGVlZnQnVl?=
 =?utf-8?B?RmRhOXphcDN5RzdhZjFROS9yalJWMUJEMkZ4NmwvRElndms1ZzVWZEJ1MHRV?=
 =?utf-8?B?V3AwUHVxeHQwbXJYeDNHUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a2xaL1hNRXk4NUx4M0JpUEhjM2kwaFZYMGpodmRzaHRqdHBWYnNkbC9EcDg3?=
 =?utf-8?B?TzNUNksveWQ3NnR1ajU5RHROWVptK2tSMURxcVhGNzMxeDFOQjlvU3pQekd5?=
 =?utf-8?B?Tjk0SUUyMHJIZnllVWk2eXM5enBjMC9XRERrYkdtQjlGaWpYZzNManhwS0l0?=
 =?utf-8?B?L004ZTNBS1RldkdQTElvelQ1MHBwaVBVUWVMN0d1WVFYeWw3azZzVVoxYkxi?=
 =?utf-8?B?bWp1dCtSN1d1Q1FNSFgvRFNnOHZZMzVVK1M3ZmcxU2w1S3BBYjlYeW5kZVpn?=
 =?utf-8?B?UnoxNjhFa0dwbzZkVStPYW9oZDhjV0FKdVFSOTJvQnhzQUFBQVNwcHRWL24v?=
 =?utf-8?B?QTBqb0ZyM1Q2RkQySlAzNTliamZBK0RsdVVaQkxVaG1EbEloK3RFSmJDZTBM?=
 =?utf-8?B?TE5OWHllUy9mMjVBaTZPTEQ1YUNhV0laZWdHaGdSZEI5OUNHc3ZFbXBla2FX?=
 =?utf-8?B?ckRpK2RNaEJvUk9NdDQ1K0h1Q3RpZSt5YmVVTE1ucGU0VlR0bE9WQyt2OUs4?=
 =?utf-8?B?WmpPU1pkRElUdGlXLzJyaXZmOW10Qk5ScXNleUdvRDVEamFSYnlWQ2Rxb1ZV?=
 =?utf-8?B?a2VJdzJCWjNGYWFNbFhndElVZHVQaktrcVMxbEpoaWxVditOdmJwb1ZITVE0?=
 =?utf-8?B?M0Ywb2JUL1ZwN0IrdmYyZEk0K1FncGhMQW9Ob29FcG5ENUVVa1YzVnhWbkV3?=
 =?utf-8?B?UW1SdUxaeEpWSzlVSU15K3cvZmNhT3U3a2NFVEluNE5EVmh0SnNoUCtFcGh3?=
 =?utf-8?B?NUhDNEFleWlIZ2dzdmcxWStjc2FlaG50WW13VDQ1bGlrdFk5RmdCTGlBUHlZ?=
 =?utf-8?B?WU9aazhOUUhjSVFsVlRScThHSERCZEZ2U2Y4aFhSbzRnTWR2cTlqNU5MOHZa?=
 =?utf-8?B?OVpKUC9ad2o3bGZoQ1Bsa0hLYm9nS2ZVanFMZTl5N29LTXpXb0JtUTRKWTRs?=
 =?utf-8?B?NE55dk00REZDa1I3S2hLUzE1VWpiMU9zSEl4NFdTa2UxMGdOSWpTWXVybkJ4?=
 =?utf-8?B?b3JEbUliWTQwQmd2WVJnSjV1bHozb21HTzFsSDdwUkJVSFYyNFBFOGlxMDk2?=
 =?utf-8?B?M0dzRnVzekprVVBSekkrOTMxL3h5Wk1iajFoSC83dEdxUW8xWXlZQlpwRVZW?=
 =?utf-8?B?RXRXREdqOHlVbXp3TVM0bjdZaEwrWkNuYUJSY0o4RE9ZU0dXdnFoQUhWTC9t?=
 =?utf-8?B?YWFRbncyTzRRQnMyajhNQmpVVU1Ud3podHNxcnJzVE8yYytSM0lCNVZXQW9x?=
 =?utf-8?B?QkpKWlJ3Y1pLOVFEQi9NdlNPcDNzMlVsejdEbUxyUDB2OFFrYng5SUczY1dV?=
 =?utf-8?B?bEpVUW5HbStROFp1UWdQd2pabm1XbC9ueE44K2hCTWlUN3VUWGxQRG5nRGRw?=
 =?utf-8?B?UC9hMTdVMHMvUEg5UmNHcXRHWDhjVnhrd1F1NnM4QmhXVituRTB3YUVpWUg3?=
 =?utf-8?B?d3dVWld6VGR3Smc0SDM0N1E0WXNISzlncTRadmp6YUxuUmMvTGY1QVYxR1BN?=
 =?utf-8?B?eWJ0RGw0MkZ5KzViUFY2V3dYMDBUZ1RYUVIrdHNLNmVreDZuaW9RZ2dHYkd2?=
 =?utf-8?B?VFBsWnFpaW1Ka3JzYXVqRUw0cjF4NzRqVzI4L0Q0Z2lGVGR4cWFTZ1pXWGJF?=
 =?utf-8?B?bWxDLzRRMEc1QUtUOTBOVHFHK09lcmlybWFRajhXMFJSVU1pZmZ2SjNTNTFy?=
 =?utf-8?B?VktLSEFzSy9WV2ZEbW5VUmswdDUyUy93UmhLWVZVclE3QXZndjkxblNCT0NB?=
 =?utf-8?B?V2F5ZzNBWEZCM3FiT1UrZUxpYzJKQVBqK1Y0VVhXRStOMkNhNStIeFdlNERE?=
 =?utf-8?B?YlMzVzFYc3J6T3lxLzhqcy84L09pbndza1pLU2g4UGVhcnAwT25saEpwL3o3?=
 =?utf-8?B?ZnI4MVVRUWZRVS9xK1BHcEFpUWJHZGdQVjViWDdQcno1NVdtSTNDbVh0VXBL?=
 =?utf-8?B?Q1R0ZDBvalR6SE43MWs0UnBhbEhjZTU3YWJ0MVk4TnpCa0RraXFJMWZtcGNn?=
 =?utf-8?B?Z2ZUK1daN1c3NFU4VE1KVzVROHFaQ2paUWdjY2tDYlp0TjIyazI0MWtsWldi?=
 =?utf-8?B?R3p0eS9ueDdybnI4UkhrUWZQdDZIOEhBQVVWSXp0U1Q0YjFMY3hjVkZ0bnhW?=
 =?utf-8?B?c2N2UzlEZlZRSHhoMC8xSi9XWFczb1c0Tmo2T2ovOGJDQWFUN2RGd0x2TU5N?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B58C68E2AA2FE5419B956675C4C339A9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l+OAeH6QxuYTZPLMn9NCzpOwk/bdWNkQQm16XSKsh+bu4roDfZuh78/FaKLUoiIlgin/LXSsPj1XtnIQsO+lk1MUm+uEDumRq/doCalJVa6TKMGg+ofcUKhdKNwaAVwLWIRacMQ77Rw3ofW3qYcD8DQLBZ6vNSZ8MRF2iRvT9hOFm2y/M7GatCtu3UPIjz5EEMPUsuBhZ+XWgomKdmiy9rYxKxlZ7m7KoCd1/Odqdd1G6oTNrMx5yMgRs8K5lLvHR6lxjNoyJRD5YlDYrCEsK29FF/ta7Ou7qTfv0PZbuDn5gnD1NjCNX3Rlj60Ea9eadCEiWOrqxRNvhUpsyuwfcsz9hOhL2fHlAEzZEEKiAxB05I02QOqzpfrZuSR8lqvUvRi9XAahoSdXEw+0vcNrDanMgZSqUVH6mNvtHKyCOfHjDDhfF5aAEK6Kzecb0JMVNYDjQpebcq4Q/ODKGFbAHD1pQsPA6v4HtAqj5dEFgLf193c5hl7ePxM5+KVdJwp6KJC7yIREvnYJKN8gEGcaun2Hc6meTsHNGQEwFHn/qxrdUrn2+b6dk3xiVDjl4zCXjL5VSlyYbU4W9B2R3ljwPSs1oyKW799yqjFIq6xZJpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cd19a7-f6b7-4411-c2c3-08dc7a772053
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 15:52:04.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qjMjwplB5hGlwnY2qMtAoT+0npo46ALqu/rm6azRwOKY1rak1/QJLpl/VrYphydKlO+lEvTXkuPzgLm1vJSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=866 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220107
X-Proofpoint-GUID: gh_zwatrDsqhux4yCXezmTX0UsV5p6q9
X-Proofpoint-ORIG-GUID: gh_zwatrDsqhux4yCXezmTX0UsV5p6q9

DQoNCj4gT24gTWF5IDIyLCAyMDI0LCBhdCAxMTo1MOKAr0FNLCBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE1heSAwMywgMjAyNCBhdCAw
MTowMDowMFBNIC0wNDAwLCBjZWxAa2VybmVsLm9yZyB3cm90ZToNCj4+IEZyb206IE5laWxCcm93
biA8bmVpbGJAc3VzZS5kZT4NCj4+IA0KPj4gWyBVcHN0cmVhbSBjb21taXQgMzkwMzkwMjQwMTQ1
MWIxY2Q5ZDc5N2E4Yzc5NzY5ZWIyNmFjN2ZlNSBdDQo+PiANCj4+IFRoZSBvcmlnaW5hbCBpbXBs
ZW1lbnRhdGlvbiBvZiBuZnNkIHVzZWQgc2lnbmFscyB0byBzdG9wIHRocmVhZHMgZHVyaW5nDQo+
PiBzaHV0ZG93bi4NCj4+IEluIExpbnV4IDIuMy40NnByZTUgbmZzZCBnYWluZWQgdGhlIGFiaWxp
dHkgdG8gc2h1dGRvd24gdGhyZWFkcw0KPj4gaW50ZXJuYWxseSBpdCBpZiB3YXMgYXNrZWQgdG8g
cnVuICIwIiB0aHJlYWRzLiAgQWZ0ZXIgdGhpcyB1c2VyLXNwYWNlDQo+PiB0cmFuc2l0aW9uZWQg
dG8gdXNpbmcgInJwYy5uZnNkIDAiIHRvIHN0b3AgbmZzZCBhbmQgc2VuZGluZyBzaWduYWxzIHRv
DQo+PiB0aHJlYWRzIHdhcyBubyBsb25nZXIgYW4gaW1wb3J0YW50IHBhcnQgb2YgdGhlIEFQSS4N
Cj4+IA0KPj4gSW4gY29tbWl0IDNlYmRiZTUyMDNhOCAoIlNVTlJQQzogZGlzY2FyZCBzdm9fc2V0
dXAgYW5kIHJlbmFtZQ0KPj4gc3ZjX3NldF9udW1fdGhyZWFkc19zeW5jKCkiKSAodjUuMTctcmMx
fjc1XjJ+NDEpIHdlIGZpbmFsbHkgcmVtb3ZlZCB0aGUNCj4+IHVzZSBvZiBzaWduYWxzIGZvciBz
dG9wcGluZyB0aHJlYWRzLCB1c2luZyBrdGhyZWFkX3N0b3AoKSBpbnN0ZWFkLg0KPj4gDQo+PiBU
aGlzIHBhdGNoIG1ha2VzIHRoZSAib2J2aW91cyIgbmV4dCBzdGVwIGFuZCByZW1vdmVzIHRoZSBh
YmlsaXR5IHRvDQo+PiBzaWduYWwgbmZzZCB0aHJlYWRzIC0gb3IgYW55IHN2YyB0aHJlYWRzLiAg
bmZzZCBzdG9wcyBhbGxvd2luZyBzaWduYWxzDQo+PiBhbmQgd2UgZG9uJ3QgY2hlY2sgZm9yIHRo
ZWlyIGRlbGl2ZXJ5IGFueSBtb3JlLg0KPj4gDQo+PiBUaGlzIHdpbGwgYWxsb3cgZm9yIHNvbWUg
c2ltcGxpZmljYXRpb24gaW4gbGF0ZXIgcGF0Y2hlcy4NCj4+IA0KPj4gQSBjaGFuZ2Ugd29ydGgg
bm90aW5nIGlzIGluIG5mc2Q0X3NzY19zZXR1cF9kdWwoKS4gIFRoZXJlIHdhcyBwcmV2aW91c2x5
DQo+PiBhIHNpZ25hbF9wZW5kaW5nKCkgY2hlY2sgd2hpY2ggd291bGQgb25seSBzdWNjZWVkIHdo
ZW4gdGhlIHRocmVhZCB3YXMNCj4+IGJlaW5nIHNodXQgZG93bi4gIEl0IHNob3VsZCByZWFsbHkg
aGF2ZSB0ZXN0ZWQga3RocmVhZF9zaG91bGRfc3RvcCgpIGFzDQo+PiB3ZWxsLiAgTm93IGl0IGp1
c3QgZG9lcyB0aGUgbGF0dGVyLCBub3QgdGhlIGZvcm1lci4NCj4+IA0KPj4gU2lnbmVkLW9mZi1i
eTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPg0KPj4gUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9u
IDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gZnMvbmZzL2NhbGxiYWNrLmMgICAgIHwg
IDkgKy0tLS0tLS0tDQo+PiBmcy9uZnNkL25mczRwcm9jLmMgICAgfCAgNSArKy0tLQ0KPj4gZnMv
bmZzZC9uZnNzdmMuYyAgICAgIHwgMTIgLS0tLS0tLS0tLS0tDQo+PiBuZXQvc3VucnBjL3N2Y194
cHJ0LmMgfCAxNiArKysrKystLS0tLS0tLS0tDQo+PiA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+IA0KPiBMb29rcyBsaWtlIGEgY2xlYW4gY2hlcnJ5
LXBpY2ssIHJpZ2h0Pw0KDQpJSVJDLCB5ZXMsIGl0IHdhcyBjbGVhbi4NCg0KDQo+IEFsc28gYXBw
bGllZCB0byA2LjEueSBhcyB3ZSBjYW4ndCBoYXZlIHJlZ3Jlc3Npb25zIHdoZW4gbW92aW5nIGZv
cndhcmQuDQoNClRoYW5rIHlvdSENCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

