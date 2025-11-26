Return-Path: <stable+bounces-197048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A9C8B5B7
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 18:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1684534F538
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BA27BF7C;
	Wed, 26 Nov 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="it7P2n2f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uyxDauiL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D94279DAB;
	Wed, 26 Nov 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179797; cv=fail; b=QgQLfd3GJk1U/UDlBrcDl83b/LsGb6vNZz/jQqjyE1ChDyg+NiVJ1s2U/lzFF4HEn00gUhrM76xcgbKUCW+xALOdKI/j1ynzsMR5YYtUlH0zOPVTQkoBWDCaVHby/tm/DqlIMiqrtAU+DTfqbcyfuBz11ZXVy18VSNcIZvERSMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179797; c=relaxed/simple;
	bh=7fgSsnQq5dT6PhtrZmfyoXBlCPkBohmKJVNxPyay6+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huZY09W6/tq3UyrthB1G+gxr6BFJ9hEsM1mkXY72YzMOlenoc2OcpFz5Jw1vxsh3Xx6ZnzYvUOWYWkTKzGFdXiU9HIJXSSRNo9JfancBy5jSQqqKhjZKyLWVzV7Y2Gx9oscwHBppDaouETmz6yydZVYhOtymZegSqK7dXogwydw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=it7P2n2f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uyxDauiL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQGGm0O2650994;
	Wed, 26 Nov 2025 17:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7fgSsnQq5dT6PhtrZmfyoXBlCPkBohmKJVNxPyay6+s=; b=
	it7P2n2fqEY4vlDDp7EmStNK6h6jS0sT5ndLOFGw+ggJY1a87RD/HiqsCFwbBIAS
	sRIWXBH70NE53Gc7EgBQSQLZz//GFCMcOBkCkpkL0ahP84QvXdH46NuUGE84Evtx
	E28W+ZCN2sACbLmYdU+cIvx2nCqP0gCG/puXNe7SEQHqWibEOZQHXTsO05UGlCtc
	17Wl+2v8OCbuY/RLFbx912IdxpxC485iOzg5T2XOINN+JQSJwScwfb0R8USTjtOJ
	U1y8rG7STf+T8mrd9HsOPsxiFffz/iBmaUn83jYBy47/RBZ+vqx8LXP2yYJmTklR
	RDT2O8GFnXmJM/4HSBHmvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhvymm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:56:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQG6ama018896;
	Wed, 26 Nov 2025 17:56:31 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mb9xaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RazGXhjN0QLYBbdxladgA6Xe4ZK5codsUXjQqRjamKaWl5tq8ARQtuUtHG54TjI0/kMVF9wsUomdJjV1tUwf5YyNzcCahJk9oEWq8KN0dGJJAYa6PcfOZKFUx1K2FmRQ+HBOEGQ5KBBpT59GgCEi/SBgv2ZP8UZkWeriDvT+XE+nWzG9dpCBZ0C+KOOAgzWZ1hmj3J1Pd6rIlF2riqG/BfiZ7UCNXYU3o8fGZP48cMlFlP1aNpGPL4fRvQfoJKUGPWGqjc6Fz5leuK3Rft0fAczcPZvrsaTGDiGoV7oC6DwDGJUAHYLafeo2rTfkc3VaNUZrHMWpohWgldYnAZnySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fgSsnQq5dT6PhtrZmfyoXBlCPkBohmKJVNxPyay6+s=;
 b=pMetLk0jpEx/1HJy2PzwmNcrCoEfYG5xRWiwJbBY13P1BZSpZWTm0rbaBCnduiWm4sNXqUzTVFX2lbrtRHLLDUzcmUCsemjKEiPkoH2eAFVxE/YFrMR9nQRkRUmt+1STT5ACd9QE5bFEL7NY42F/qEm7afp+9/kxZAYbzroc/xMLo4k2eqYHv69ZnfKOkK3TjX2iJiia6DYpVNm3uzXOc4SFsItbEQCf4sJMQJNv3sBDTmfjNBKv+MuecupMxPJ3Vzqw33qZGDyCaOG0d8AhXvVYEWdT8+ZApSzXy9/5gGA/JGzChXtE2GIGMO2yunoSiz75UtOhcfbwfDil3uUDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fgSsnQq5dT6PhtrZmfyoXBlCPkBohmKJVNxPyay6+s=;
 b=uyxDauiLka57NCVyRCVvp3PY8eYIx9VVv9NkeunywaoLi33Xfk0i3N3Y3Sv6tODqfAUm9NByXO5tsD6q2gGVGNy5rU5P6W+2p8zyn/N67u3hY7H5SnQJaO17r2p2gdOvlZY3pClvJ2DPwbrHladLVixkQzyeTsifi1adY08thwk=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 17:56:28 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364%3]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 17:56:27 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 5.15.y 1/2] Revert "block: Move checking GENHD_FL_NO_PART
 to bdev_add_partition()"
Thread-Topic: [PATCH 5.15.y 1/2] Revert "block: Move checking GENHD_FL_NO_PART
 to bdev_add_partition()"
Thread-Index: AQHcXqZoh0cbkqshDketzixUg0xSRbUFPnzQ
Date: Wed, 26 Nov 2025 17:56:27 +0000
Message-ID:
 <IA1PR10MB72405B045162AE80C28EF01E98DEA@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20251126072316.243848-1-gulam.mohamed@oracle.com>
 <2025112603-depict-thee-b774@gregkh>
In-Reply-To: <2025112603-depict-thee-b774@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Enabled=True;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SetDate=2025-11-26T17:55:46.0000000Z;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Name=ORCL-Internal;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_ContentBits=3;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SJ0PR10MB4782:EE_
x-ms-office365-filtering-correlation-id: a6e7c868-963b-441b-3a9d-08de2d151f1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-7?B?MHo3UFV0S0M3bGVWd1pVM3ZEY2tERVNKaWs2TE9IQzdnU21HUjBLampXMG5G?=
 =?utf-7?B?TkYwTlZWMThFWjROQ3R6TENvQnVrU0Vabm5wUCstbjk4cDBuQmlEZ3JJT20=?=
 =?utf-7?B?Ky1uUWxlNmhIZ1pNZm4wZXNoV2xKVUVPeElYbzVzc0NYZmk5M0hQdUdKQS9R?=
 =?utf-7?B?ZUFwam5FbXREbi8wd0RRMURWcUtjd1REY1c3M3ljZFYyQXNWcEhFVVlnSWVX?=
 =?utf-7?B?VGJFL0ZUL2lxdUVDbDZaV2JWRzhHemlxNistNmhoWU96emkrLTVYOEZybW05?=
 =?utf-7?B?NFp5S2h1MUgwa3poQnRGejFlc0dKTHh3Vm9OdW5ST3RJLzVuKy1wbXlZUERN?=
 =?utf-7?B?c0NGc252dDlBV1Z0MVNCdVJ4eUMzaUZCRWtzOTZKMystWmVGRDhYNzRkdDdq?=
 =?utf-7?B?TktNVzE1ZUdMNystYTdBRG5vTystOFAwMEhjQUNiSVFIb1hVaGQvL1AvaU1U?=
 =?utf-7?B?RGdzQkRqNUEyRldZbmFqMmNHOEVHVHBqTjNUUG1neSstQzhIOEFXT21OVTZi?=
 =?utf-7?B?ZzJ4MmUzbkY0eUQwTUtESGdCZ2p6bENjdnZjbEhjeGxzL1psM3hRM3RTRHhZ?=
 =?utf-7?B?b0FYYm1WeEx4ZVJWSWM4aVdpeVdEMSstVDRVZktwaGEzdjNTT296Q2RabUpD?=
 =?utf-7?B?a1JGamFlWVp0eXFVMzk5Qk5aNm45OVl0OFdBdkFOWDJWdlI5S3FMYmoxSSst?=
 =?utf-7?B?c3lLTDhObEpEWlFpSjZ1TDArLUZLeU1XeTVxMDQrLTFJUU9rcEdaa20zSGFt?=
 =?utf-7?B?V0p1bXJrNnRuVzVYWGIrLVI3QXFEck44UUZvVTZVQW1nNWNCWUtCdkxxUDBj?=
 =?utf-7?B?UGtqeThaaDlqRUNUbUEyU1VFQUM4d0lRb0UvQ1BIcVRTT2xjbTdoS0xPUVJa?=
 =?utf-7?B?U25wdEMwV0lkWjlENDVNdTNtUUFpYmlDOTJxemNoNWxOdjRmSXdONkVQVThF?=
 =?utf-7?B?Y1J5TG1TV0xkRTlYMjBUOHBVWmhITzdkWWxjaTA3MWRyN2Rtek8rLVA2Z1V2?=
 =?utf-7?B?NlA1TEhGYkNlSVlBTGR2cVEzaEV1RzFRV1BwamwrLU1kOUlBaGFuM1poQkdr?=
 =?utf-7?B?TTRyUnUvRTF0cSstbXNWdGZEV2grLSstQ1czanRxZm9EblpxMVhrOWdBSGkx?=
 =?utf-7?B?WndYeEU4Q21Td0FyaW5MSEU4WkJsVFJEa3BDMlpBaGttWW5zOFdPRDJEWFNk?=
 =?utf-7?B?MWc2c2VSdDg4aXNCUjBmUlV5WElxaW8vb1FnSFNXSkZwUkZ6NjNYSXU1RklW?=
 =?utf-7?B?aE9UcThsalY5Wk1uMWNRUnlrc1RuZzJMR1VRd0RCN2htR3I5WGJ6WE5pSWZ4?=
 =?utf-7?B?UXlvOFA5SngxOXhsUUZCVWpwanlKWnZuSDNpQmk4R01aZ0J3MThIKy1OOW9q?=
 =?utf-7?B?clBsZG4ySkZPcmtTQ002SlIvRm42bi80a0VpaHcyWXRZci9OMHk2RXFKZ1F4?=
 =?utf-7?B?N2VKc0o2VmpMdFczQmZTVUoyNGxNbUJSd3NRYTBKbmJMbGxWeU43VzYzRUoy?=
 =?utf-7?B?eno5S09xNTNvOG8zOFJXdHIzL0pEYjJyMmtQSHNSb3UrLTV4MWNob3lGSWMv?=
 =?utf-7?B?NXZsdystNzNiZUVneThwalk4UERaVXJ1cnVwUTZQQ0xJTzBPcistZ0l6Z2Zq?=
 =?utf-7?B?Y0QrLTVSTmIvZVRSeFRKb1dwTkNDNXNyRjNHQS9hY1lVU29Ed3F5dVNjVTM5?=
 =?utf-7?B?cjA2eldDSnZMdDRMMGlCZWYxa1g1c2ZrTzBuRUxSTHUwSHhmQXZ2a0JsYkpL?=
 =?utf-7?B?YnZaTExZTWluMlZjaGgrLW5hTVJEa3FTa0RDZENMVmR1WjZLVnVqdXVLQ3Zj?=
 =?utf-7?B?bG15MVBVUEhIeUR1bE1oa3dhdE91aTRncWlNZDI4c282UE9DQmt3SGh6UmRB?=
 =?utf-7?B?VWxzS1dyQWUvM1B0QjJSQVVvS0hvazJiNThGYkxHQmJGRFB3REZBVloxUGw4?=
 =?utf-7?B?dkxKKy0yWmx1VEJMNW5XTk9ZRjhHTTJJS3dUQ1NCTklHQ0dDWUtZVHRVWWRx?=
 =?utf-7?B?TDdtZTh4eEtvSENaTWhyZlFVa3Z1YzZueGc1cTdYbUJEVXUyaFZsSmltbU9W?=
 =?utf-7?B?UDdoeDRYQkN4MTVJdXd4eUhoSHVPbVpRWlkxbmkxZ1VW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?RDdwVGQ1NzNWa0x5NzlCRTIwWC9pWTh5YWx2QmhMdnR1TU1WT3gySnczZEsw?=
 =?utf-7?B?M0E2ODdtaktXR2JLUXhlRjRxQ0hTaU1qRUFQNjNpWlU1WW9sWllqUm5hOURO?=
 =?utf-7?B?NUxhams3YUtJWjkwYzRxMFFRUXZheTJCQUphUUdHdkRUaFRqR0FLQkFaSTJQ?=
 =?utf-7?B?ZjIrLW1ITnZrTGtrcnRuZTEydTJNeFRHZnlqOTMxMU5SRFN6bUJDKy1nN0Q=?=
 =?utf-7?B?WistWjdzTGtxWXJQeUVSWjdDV0kxRU0rLW95aEVFanMxMVZvWS9iaGhESko2?=
 =?utf-7?B?YWNkckR2ZzgwVUdYd0VsRWhpWmtlVUpmaExmQ1hHYzc0NmRLYW5vcEp2Wjl3?=
 =?utf-7?B?VHgyRTR4TFBvRGtGb05IbjVwRmZCUystVUxmcndHVGtRYTNWZ2pWanZicUQ5?=
 =?utf-7?B?cUZYa3dUOWxlTlVFNlBSNThMaW9RL3ZIQjRSYlZTeE45eVd0RVVjd0NLVjdh?=
 =?utf-7?B?bU9CbmprbHg0UTU3ODNsQ0lDVEtadzFjdDRCVUNpYXJRMnpDbFBwOUZHKy1N?=
 =?utf-7?B?M1QvQmZOMVhacmJ4d3p1S05aS3JBMzhDd2RDYkFaMHovS1dwaFpHYU5HbUh4?=
 =?utf-7?B?MlI0TWVEei9oMGVZWUxocW9XT1BlTmY2WFBwTWNUYWhQN0F3UnZiMWU2ZGdu?=
 =?utf-7?B?NDYyby9wNHZHS0dIa0JqcHVrZkZ0YXAyY29ta2hLUGRodHRBREFMR3Z1VDkz?=
 =?utf-7?B?L2J0enlnNlZrUGJLdnJOYkNpRjltUWJNa1FDTXlRN2I0Z2VoZFFaLzc4Ym50?=
 =?utf-7?B?dDJGcHRNczdpMTR5MmRTSlNQMEpuYjBtNXMvY0pFQmNIanNKZWNWSmZFZEJq?=
 =?utf-7?B?aHlEV2l2WTVod3lJdHovd0cvd0tONVppWlV1RFRyUEJyQXQvY2cwRnNsRyst?=
 =?utf-7?B?WG5sZDFJdTV6ZmxtazBGTExIcGRkTlJmUzA0WUdlSWcvNkZ5L3UrLUpNa2t1?=
 =?utf-7?B?UVQ5aGg4V2JnMHZpdk50eFdydmpaR0NHdlc5azByUi80MEZ3RkFZUHpMaVFT?=
 =?utf-7?B?ZmpRNUhhaGVYeEd6Z2xiNzVzVEVpczVsM0dZOW5zUnl4OHdnSnljaEFOOXNq?=
 =?utf-7?B?bUF4QWNxOG12eU9UWjNRU01tYktacnB3aG9hZ3dxRnRMYm1zZ1V2aSstNWVl?=
 =?utf-7?B?Y1NNcTFRSWZ5UWRWUElOSzFFdmd3b0RzSExMNVBHaUduaXc0MXFYUmRqdW4=?=
 =?utf-7?B?Ky04Z2Noc0x1T2pkd215VEMzMERyeVk4UGZIbkJsTzBpZjRjUHBjNHJJNG1y?=
 =?utf-7?B?djVxZlNFdUl0aVZrVGVwS1BhVDJYcDI4UistMzR6Ty9PME9xSkF0dk53OXhv?=
 =?utf-7?B?UFFSZW96bExRTmN3QUJCU2Ixa2VYNXRNa0RudEFhMHVPenRPbDFmVkF3ZlRC?=
 =?utf-7?B?WGpvNVFJbDVaOFF5T1I4NWtZeGx2aDVKd3JzYS82bVBweWZFZm9QOWlpbUJT?=
 =?utf-7?B?bE1xblZlNjJuby9UbWJvZFhWS25QS0NtZnBVbEdWd21DSVd6SGE0MmJxMWlW?=
 =?utf-7?B?ZVkrLVFrLzNGN0FTeEEwYUIxNkV2dnYvTmd5NUNCMVBrelRxNmRNQVoxeWg0?=
 =?utf-7?B?eHJiM2Q2TlhIZlB4c092Y1FROXVtMEo5bk1OOTVPNGlONSstbi9RM2xUNk1t?=
 =?utf-7?B?SnhHVG1wSmx4RVY1UHZWb0VLZ3ZSS1BPaWtWZGpnNEhyNEtYTVk0ZzZJbFBD?=
 =?utf-7?B?SC9kcUtWQmhGWDZEdVRrTG4yTEhQMzJtQm9TZFRJaGdZSzBYb2ZGYkFMNWhC?=
 =?utf-7?B?dVk0TDRCQ1p6UEphWnVtcndzd1FYT3p5TUdJR0pQSGJsMElhOXd0cjVmcG1O?=
 =?utf-7?B?ZThVc2lmeXIvSGNxUFdZZHlpeCstV0dYbmxzZmEvWDNXZGlWU1kwYkZxc2hy?=
 =?utf-7?B?azlhSVd6SGEvR1BWZERTd09ZR0hUTystNmtmZlJSQzFKUlRRKy1WaUhGeEdj?=
 =?utf-7?B?RHUwTVFubGZpMHNMTWxhaHRENkpDWkNCekVnbXVwN016NndCbEZlTWE2QWVK?=
 =?utf-7?B?WWlYcisteFRPUkhudWpMQ2VhMTEwQW5kbnVoeDQ2SUxHS1FteVdMZXNVYUZz?=
 =?utf-7?B?OTRzRnZxUDQvRzZKbVQ1UEhuMXh4ZHZqQTlFcystTU1NMHlpTVVUeE4yN3No?=
 =?utf-7?B?cnVxc0ZlV2w0dXNYamJZS29udUJ5L3RXZDZQb3R4NjA1SkhZS0xXeUp5bzhw?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gs1MrzrHDTa82j8D4V/BkWbYB0mR73Hh6XdLCj9UwMo4YHLPYxicMXmXXsZTDo2lXK17Sr+TvIg6rUOSARgFFk2DNL8yi3gsF8aJDBiLgFCczJLibNhk3vsD02SmsAyYxBcRbdoKGhHAjjnxqtPQv/Gb1YGtNMIA9wXfl+1n7ojWj3y3BLDLFiVgwhx96da2LrMPUjjdrRmpSe5IpwjsVGyPszxQwmmWWp4S+vXW8zBx+5bVIjKCzYHuVmhGnK0x98nGUetvATjeko41XszqxFQLHu9gpb8NAmK64ClRXMkAcqfHCjQmACqWYSIpR7aKGSHm+s3aiDOT1BILv0hI8YTe2gDyzyFfH3vQhiAYBmwc8J6T3ZNqRZIyX3SysFP3UtN2pvX6/V/Z7o1oIjXAsbrxCffsKGBqIhdFSz4yBCaZ5QvzdVt29qaZZbkk3wVkgsGHXOrGWrGFH1IIW7lIQ9vfWCwBvi+a+VxbjFEGwJVtXBI4rp64ysYyEMzjZUBWq2vzPB3C6xDcjRB1mOJ4GxZed805WGjh+5zm5/rQnQTPqebWAb1qBOc26nC1JkvcimtK0VRkcyJSCMPiU/rTWKPBi/VtYTD0wTv8tIZpV/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e7c868-963b-441b-3a9d-08de2d151f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 17:56:27.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DloG64BwH3/ZjYfa090YHfBj8oiiUOUwfeYFzNicvrrBJ8d8sF4ERYYshRpT9tysUESCzjMIOMpjMUYLuyjeLVTY+WFNULWHChI32YmuHOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260146
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69273f50 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=WJJPNcJBAAAA:8 a=mQvHCebiAAAA:8 a=aF30hra-kt2OPs1DsDIA:9
 a=avxi3fN6y70A:10 a=zgiPjhLxNE0A:10 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=Orvq6HXzVWGNNdQUjdZg:22 a=wsrb8zZI_WQ3QAEBCXTy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0NiBTYWx0ZWRfX8T/TPOgF9P1g
 JQ/83+nREwui1bcoZ8FIZjDErlY2fI4kF9jtidPayaSTVNUETCvC1KHCs6XATTyA5tt/UF8ifve
 yhQ8BrIG5WQpqNRseYOXEb2O7x1T++7EAzPM6vbPAQoW+j26TZanBLuS7R8wD/BlcnrRTKTGfqo
 c6IMyt3/GG+taq/YmYs18hhmry7QNMUHs2HU6dU3c96MYCM87ybvp7O3ES0h0CCRJZlYPPPputP
 LeYQNISTVcZm8jO1Kvfo3R2g0egdr8+xfGfuEyakIHu8/mf7HvhelBtfFotV0plavoNVF38X/Cq
 0OF3SnI532ekrKuYdDzmWgtulza6fik8z80hGQ+H+WhiBf35NC5fl1eKfHnwmzq+j2+jddHWvfU
 2I0NEbKP2+KKA8sU+dHICaLPf7qITQ==
X-Proofpoint-ORIG-GUID: MFiIZ2YPZuAzzB1vY-VMfQdUA1FbbBRR
X-Proofpoint-GUID: MFiIZ2YPZuAzzB1vY-VMfQdUA1FbbBRR

Hi Greg,


Confidential- Oracle Internal
+AD4- -----Original Message-----
+AD4- From: Greg KH +ADw-gregkh+AEA-linuxfoundation.org+AD4-
+AD4- Sent: Wednesday, November 26, 2025 12:59 PM
+AD4- To: Gulam Mohamed +ADw-gulam.mohamed+AEA-oracle.com+AD4-
+AD4- Cc: linux-kernel+AEA-vger.kernel.org+ADs- hch+AEA-lst.de+ADs- stable+=
AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH 5.15.y 1/2+AF0- Revert +ACI-block: Move check=
ing
+AD4- GENHD+AF8-FL+AF8-NO+AF8-PART to bdev+AF8-add+AF8-partition()+ACI-
+AD4-
+AD4- On Wed, Nov 26, 2025 at 07:23:15AM +-0000, Gulam Mohamed wrote:
+AD4- +AD4- This reverts commit 7777f47f2ea64efd1016262e7b59fab34adfb869.
+AD4-
+AD4- What version is this series?
+AD4-
+AD4- Always properly version your patches :(
Resent the patches with proper version.

Regards,
Gulam Mohamed.

