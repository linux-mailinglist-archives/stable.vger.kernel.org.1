Return-Path: <stable+bounces-144614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813DAB9FB4
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FF616AA8A
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931B819F120;
	Fri, 16 May 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Zuu/4Yz"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AB4B1E63;
	Fri, 16 May 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408716; cv=fail; b=RmWoeRV/kaDdJJRRY9rFk6ZdrdR4lD5HxRzuxn3XxrJ2SD3rnPhEjJ5VYKcn6VIrvrBMPdeuUkrhzQKwTNfLD46Qke9qkNYK4OKeCoWf3Gc90V3wssdE5NMrK0+yWsHsxSxDj0220ud4w8IWMAA1lXS98JL4TqtHmP0OP6/L2BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408716; c=relaxed/simple;
	bh=29kaNtxHeyLhiRMQBN0I9Z2i7+Ltwlm/+xH1/U6KHGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f2PqOn2Ht4QJm00qcZ8Fo0W41vuNBT3gNOQsr1UYPVTRFhWB24DRZeo29jIt+n99N+PYjHaIz7A6LNqMUBFjWkJSxcviVQle66J7MV6lbbS9xg6ytDKvmY0NQbZtSoLH+iczCecnJzObkgNQJsKGObu7FRpB9b9kjg74RTJbxqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Zuu/4Yz; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ7Tq8fwY59fkxpBW1Fbf/stTDrUmuGlsu+a3vxfsXCoE9wOOhXHQseKoSLbYQiBz3jxdPwB4n9+oP9qks69jQP/dZq6LrhlrlTk9YxjwM6hizcXYmao48xCNuKbAUKEKFBTZ+Y0NIYXsjmr1orSbxf2fGpSXJpbqiArtG/ZsGGcjvUa21jqNYwn8WDRGG5Wu0GMq6N8jAOjpAu+tDYS1kqHLHAWlCxz8EJjTFMQxo1UdOW5VouOWZhSUx5cTMu9r59pTxOeAdQDNp/fDk/9YxaV5E0wudKDvQut/DgCfmIVe0+0mRU21NIaWe6IcDwTrpfqiLKCpYnNEx8m9PtKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29kaNtxHeyLhiRMQBN0I9Z2i7+Ltwlm/+xH1/U6KHGk=;
 b=J3wulz/CHLyl2EJjb8+O6To40i9GwdzohFFspRQwu7jlJqBIEuL9vLYdJseTHJwMIQPGdod+zfkQUEBfUKEbz21/Nx4meFa2Wg0g1QzDGi5VMYB3HgviLHdpVVLkMLC5+6zT6RqROdpGkS31z7j6lfpLyUMb5knQ0VzI2IbkhDmGXMet6VzF4BJv+7qe1usfBPGq6+wh6Ai8Pq6EUm+EgfeH1e+ceR912SpIcHwsEEMchSLurKPn/tZPBTvLWKlznsC4MFH7ubUzyo2XPlUqxAhRs4MtB3K3eYtwEeK4B8XAMm60D9qE9uH2eCyix1+mgL/7fNGGA0LEFb2tmF7dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29kaNtxHeyLhiRMQBN0I9Z2i7+Ltwlm/+xH1/U6KHGk=;
 b=5Zuu/4YzJFnQ6bZIFWJ7NlGs6s2arZL/pJHmnxaIXzomPLOSJsawPhr/l0Oh5ENm+EGRlkfFAzrsVPzUKa6+abrrHLveF/HQdNbTwE+LnAimzBm/SwFA+7dHMNcpjD/rtYvzGl90vlSvc3ikTBZKTk0eseQuEvs3cai3tCFdKmE=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 15:18:30 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%3]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:18:30 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>, Suraj Jitindar Singh <surajjs@amazon.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/bugs: Don't WARN() when overwriting
 retbleed_return_thunk with srso_return_thunk
Thread-Topic: [PATCH 2/2] x86/bugs: Don't WARN() when overwriting
 retbleed_return_thunk with srso_return_thunk
Thread-Index: AQHbxjbvlgbYs18Ez0mTRbfywoAvb7PVXfsw
Date: Fri, 16 May 2025 15:18:30 +0000
Message-ID:
 <LV3PR12MB926587E1175B9450C34C17829493A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250515173830.uulahmrm37vyjopx@desk>
 <20250515233433.105054-1-surajjs@amazon.com>
 <20250515233433.105054-2-surajjs@amazon.com>
 <20250516074806.GAaCbttptX_H2Gn8OZ@fat_crate.local>
In-Reply-To: <20250516074806.GAaCbttptX_H2Gn8OZ@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ad206f8-4f0c-4463-8aef-b1f2582693b8;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-16T15:14:23Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH0PR12MB8125:EE_
x-ms-office365-filtering-correlation-id: 54b122b5-52a7-4a31-cc40-08dd948cea87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2ZQdDBTdWVTQVNjQzNiNm9TL3hKb2RVVWdLZjl0cHErWTlaUzJrQTVMSHND?=
 =?utf-8?B?aVJPSXE1QzJxNHZYZm42R3hLT2F5eFFpbGlGV2xwOGVZTHJEcmdtTEZKeWNx?=
 =?utf-8?B?Z1hURmY1aWFsUExWU0EyQ2RSQXJaTGp4UEdzVGJZZzA5ejNuZ3lrSW5mT1Nr?=
 =?utf-8?B?UTMwTEFTaUtIWHJUOUZWT0NBbG04RmpxM3pabU9RN2tlUkFSRXhpbXBVZ1Jw?=
 =?utf-8?B?cEFxS2tpRlNBMXY5dkpLRk9oV0VOZlZHdnJjZkszU2h2dFRVNDNUR2VlS2tt?=
 =?utf-8?B?b0ZDSUtsMWRxY3dmSS9vckVWSTNqYk9NNVJ1Y2s3bE1JRDRMSm9FTXh3cmR5?=
 =?utf-8?B?YnRBYiswSnNFZXJzaVlhL1pIMGRxQ3JmUnpzcW54U2JyQXVISUVLOVI0bk5q?=
 =?utf-8?B?SkFJVjc2cXNWdVFReUpKczF5WnRYR0poempid05GR2lPYk1wTjFBT2E4dUc1?=
 =?utf-8?B?dWRJVS9zWXl6N2pma1EzcXJkK1c4dGZHS3lBdmc1UmxLVWJYaE1IQWZ2eHhX?=
 =?utf-8?B?SVpOdmppRU41MWxJcmJCd0tkNGtpVUp0aEtIUlBJM2hPMHQzTGRzNlk2Nkd5?=
 =?utf-8?B?Qi84NXRUVDE4VWRFNDNIYXhOV3pZRjZEbllsdnBCU2lyclVuaEczWXJScG5m?=
 =?utf-8?B?NHd1dTVXN05idjdHWFFhamZRc2NrNkx5NmNqNzVvQnhWQlEyRWdmekNCK1Zi?=
 =?utf-8?B?SW9UVlV0Y0VmTjdhZDJFaTVyeGJwVlpZTnJzMkRlc3hRUzNHYlArb1dISWVa?=
 =?utf-8?B?aThrSDFQa3hPeW1QVVRqalhjb0M5ZTRteWNNNVlCd3phRW5vVHZkaXE2andz?=
 =?utf-8?B?WjVNcXFxZDU4dGJLaXRudlZDTjQxR2taUVgrRWlCKzd4N3lESGI4b0J0SGU3?=
 =?utf-8?B?bmJRWm1meUM3QVlLcWdGZHllTkVWaTk2THdMOC8xaFlUTHRHSUROcmdmZ1Rp?=
 =?utf-8?B?ZnZPbjd3YWJNZEQ0dGhmenV6eHFuTFhsYVNIa3dXak9UZ0ZpK3FGRHNvZmpB?=
 =?utf-8?B?aUZEb2RFTDBNbzlHblhDSmVZcDNRaGlqYWVjZmliVEdCcnN6bVMwZkZZQVRx?=
 =?utf-8?B?NVVQd1pwejBTaTJ5NGdCRTlyV3hkUVBjbXBNZkZiVFJVL2Q3Y0htQmZxaEFu?=
 =?utf-8?B?YUNQbDJONjlRa2psaGZ2dnNXSE9GYVpPRUxKaEw4SkxYUWk0ekU1NjBuRm1T?=
 =?utf-8?B?Ky9hUTBhdnpNWGVRdytkMU84eThnejRpdCtKMWY4TERVU2VTOGNNNjI1a1Bj?=
 =?utf-8?B?VFBNOExlVkFFMkQxOGtLTGpWRHNnNWdnakZJYk54ZXgxQ1FQeU13Z2ZOZElK?=
 =?utf-8?B?OFRwOE80TVA2SmUvQjQzaXJDYitoZVZPRitvazJMNjJabEM5eTc0dEtydFBH?=
 =?utf-8?B?c3Z3VkozNEdaZlRsOWhxSWhTRWZMc3VsTlB3UnBZTSt3VjFpOFA3SlpqM092?=
 =?utf-8?B?V0hBd2NtalBSdVdZTnJzU0pEb2Q0c1VCUTZTSzJTNEtwWld6M0NnMjVVMG1U?=
 =?utf-8?B?WjVQZEdrdlViQ2J5dGpOWkRsRmZybGVGTlBjMjBYWjFNMDI3OFpsaGRJcW4w?=
 =?utf-8?B?WVI1TWxEUExxYjZiQ2l1czUxMjBEV21Fa0luTlpXY1IyTElMdjNnTHZqMW5W?=
 =?utf-8?B?SU9kNGxoUGRvQVZ2anZPb2lGNjgwVmZ5MWJNc2xFTkljdW1sbVVlZDV3UzBr?=
 =?utf-8?B?Y2s5ejI1Skp4VVpNdGdBNnhtcnVWR09yTVZibmZTT05zT0E3R25YUHBNZm5P?=
 =?utf-8?B?a0YvMjYzY2dlb1BSZmx5M0dEZlp5TmE5cXJuVVBEWWxZRjJDWDJjcytmWVMz?=
 =?utf-8?B?RGVrR1pjVjVzUFNpWlBlNWZwNEpLMlcwT3gzbmtqTG9YTDNHa1NlSG5waGZJ?=
 =?utf-8?B?OXR2dzlEY3ZyYUNGaHg5aFg5VlV2QjhVM05oYnJRQWhsMG1MdHV1NThzeFdn?=
 =?utf-8?B?TUovSVdneU0xb08vclhDRTVmUU45eVB0ZlZEcGs4ZHZodnBlaWVIUGo3ZjN1?=
 =?utf-8?Q?7BwOTDe/qYhl3SgsIpdbSRvHvbPxF0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTBZM2pxZENXdGI3STljYksvSSsxUkpQajc2RXFPMGpEMW5YUzRkUkxBcEJR?=
 =?utf-8?B?UVNOamgvcUF4OE9uYW9pSjRGTTlqc1FYNGF0cDA5SzNpUU00WEtZUGZ2TE96?=
 =?utf-8?B?TWVVRXdVYmhua0xqY0FtYXZwaU9ldGVuZW0zTXVoc09oenN0NnByR2h4blBL?=
 =?utf-8?B?TmJJc0Z1K0lkb243dWVVblh4NWs2UG1UM2V3UnVnMnRKK2QzekNCQ0xaYmMy?=
 =?utf-8?B?LzJlOThSakx3dlFXd3ZDcTJZN0RKU2JqTEtPeUVYNEpYalZGRVpMM0x5dENG?=
 =?utf-8?B?MGV4REN4SU9RenM1U3dnMjkxdG5jODlZcE9rODJDVFVsNGc0T0JuOE5LN3Rr?=
 =?utf-8?B?RWIvUmFFaE9IZld4L1d3L2Y3bXA0ZEVOMWJ1d3BjbnZVdEo5dzRrUjJ4WlRt?=
 =?utf-8?B?eGJXYVV6T2I0ZzhvVGR6SFpBMllYbWw1VnFGby9FNFdGcFllV0pULzRsYkhx?=
 =?utf-8?B?UkVITVRnQUtJNlovcUJiTHl4d2JsYVpFVGpxaUxlNjhsemRrODJHU2wvZjFU?=
 =?utf-8?B?dURaY3lid2YyQVVRbU9hWHlCamI2RFVTZ1VjZU9BY3VXWXR2RG5VdWtRbFB4?=
 =?utf-8?B?UGliaS8zWko2a1R1cVVqU2JaUGhIMGdiZzNZNjNrQ21rUjJNZGE3SS8yaUZq?=
 =?utf-8?B?QXRhUnBsejBaSEVUVmNva3E4VU9JSkNrZlk0R1BIVXZUTy9uTkdDMllTaWRX?=
 =?utf-8?B?SzFWQzAzbGpadmNhbVdXa0R2WUpZbHJ2U21ySTFwS2RtRXF2MTA1MHNYZy8z?=
 =?utf-8?B?d05hSEc1WGJudlFKN1lnMlJmOXFvWjRHak5sRWlSejNGaFlkMU80TW9QeGFS?=
 =?utf-8?B?aU9LNlE5SzI3Yld2RWhOUnlEV2RHNnQ1M0pldmRJbmFvc1RxSlNuRUFwdWpT?=
 =?utf-8?B?NGlGajNvNVgxL2lqLzk0RDlRL3FRZWFDNW50WjIwaU1MUmV6djM3dGNRUVZ1?=
 =?utf-8?B?Zlh5N3ZGYWVQUWFUQVJhQVIrWWVmN3JsRGk3enkyQi9oa3BWOWhBVXI3OW0v?=
 =?utf-8?B?WXNIL0dveHRLTStvSFNnRExPUlljcDd4RzJFQ0lkYTdpUWVkL0poZmUyYTd3?=
 =?utf-8?B?ZG81OGN4NnJGcFQrZ3ViV1hhcXNHRjNjVHJiTjMvMFFBSVprRzUycUxIdlhY?=
 =?utf-8?B?TkJvRTV1OHF1VnJaVkkrZFluRFZOM0hoTStZdFYyalZPdjhUbkZ1YlUzUUU5?=
 =?utf-8?B?TGRwOUUybTdiOEc4M0VGR2t4dm9Qc1psb0VlRkhSL0xGQXNwaGRhbk1NaEhW?=
 =?utf-8?B?QVJSSXpabjRlWHNxd01tVHUwZy92dG9ic0xYTzhLZi9mN3BUSEhXMkNvQW1L?=
 =?utf-8?B?UzhqYkw1T1lUT25kRVpDaHk2Vks5VFNHWlg4QitVeWZwTDFwQm5DM2NxNkZ6?=
 =?utf-8?B?cHR5VW50MG9pbXZFemJHSHJvTFkxdXZ3RCtrTDdKbnNQR0tDc3B2LzRkTytN?=
 =?utf-8?B?QnhBaWZOUmtSRGtGVDFyN3B2cUxHdDhmYXUwYUVvQkJyNnFkdDNndGRuWUNm?=
 =?utf-8?B?ZGNzV0FHYURIclBCQlBpMHJBbktzNC9rY1ZRYnV4RlpMNW04aW16ZjJvd004?=
 =?utf-8?B?czZBT0xQcStVbTI4Q0xINUk2RXZQa1hESlVCYjhvaFpFZ3lqZWlwSHR2dlEx?=
 =?utf-8?B?TXVzVnNQcWZLOEJnbE1JM3cyY0RHWTU3c2RHZXJJdDBjRlVCRDgzTXNwL2N1?=
 =?utf-8?B?dDFYU0F2Qm12VmtubWd3N1ZJOUVJeW5GVTBuY2psM3NFc0liZkdjUlJMQkpL?=
 =?utf-8?B?TVNRMHNOcmN3MXlYTzc3Q3o2eUFiMkdQeFM3QzU0aXlTMnBwRjZjMy80QUZG?=
 =?utf-8?B?TWFOY3V6ZEYvWGpEYWJPbWhyS1RpWk5UZEFnMDMrMlZWaXZrOXIvS1hSbitr?=
 =?utf-8?B?NSsxWnAwWTdZUkV0NURycTA4UGNBRy93MUprNlpEZzZucnZrSTdjbnVoL3NG?=
 =?utf-8?B?WTJneEIzRUVvWm10OWxaTHFxckRsSEJKWjRoMlhxaUNtYWVoMVI4S0cxOVJ2?=
 =?utf-8?B?elRBdVBqa1FQVTFFd3UyRVJqQ3c5ZHVGTmpLK2tJN1k4WXhKSlNUS2hIRGpC?=
 =?utf-8?B?azNCcCtyR1ZrbXcrMEkwb3RtY0pXQmNGRWJtdlJjOGF6WG91VFJQamNpSmho?=
 =?utf-8?Q?pmNo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b122b5-52a7-4a31-cc40-08dd948cea87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 15:18:30.7154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJszinRvT0mHj7I89RMvHXOQtbYZRG14q0POA/3i1B/rgOT7CBYR3zqEgQLY1PjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTYsIDIwMjUgMjo0OCBBTQ0KPiBU
bzogU3VyYWogSml0aW5kYXIgU2luZ2ggPHN1cmFqanNAYW1hem9uLmNvbT47IEthcGxhbiwgRGF2
aWQNCj4gPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7IFRob21hcyBHbGVpeG5lcg0KPiA8dGdseEBsaW51dHJv
bml4LmRlPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2lt
Ym9ldWYNCj4gPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQYXdhbiBHdXB0YSA8cGF3YW4ua3VtYXIu
Z3VwdGFAbGludXguaW50ZWwuY29tPjsNCj4gSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
OyBEYXZlIEhhbnNlbg0KPiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0geDg2L2J1Z3M6IERvbid0
IFdBUk4oKSB3aGVuIG92ZXJ3cml0aW5nDQo+IHJldGJsZWVkX3JldHVybl90aHVuayB3aXRoIHNy
c29fcmV0dXJuX3RodW5rDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZy
b20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5n
IGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24g
VGh1LCBNYXkgMTUsIDIwMjUgYXQgMDQ6MzQ6MzNQTSAtMDcwMCwgU3VyYWogSml0aW5kYXIgU2lu
Z2ggd3JvdGU6DQo+ID4gLSAgICAgV0FSTih4ODZfcmV0dXJuX3RodW5rICE9IF9feDg2X3JldHVy
bl90aHVuaywNCj4gPiArICAgICBXQVJOKCh4ODZfcmV0dXJuX3RodW5rICE9IF9feDg2X3JldHVy
bl90aHVuaykgJiYNCj4gPiArICAgICAgICAgICh0aHVuayAhPSBzcnNvX3JldHVybl90aHVuayB8
fA0KPiA+ICsgICAgICAgICAgIHg4Nl9yZXR1cm5fdGh1bmsgIT0gcmV0YmxlZWRfcmV0dXJuX3Ro
dW5rKSwNCj4gPiAgICAgICAgICAgICJ4ODYvYnVnczogcmV0dXJuIHRodW5rIGNoYW5nZWQgZnJv
bSAlcHMgdG8gJXBzXG4iLA0KPiA+ICAgICAgICAgICAgeDg2X3JldHVybl90aHVuaywgdGh1bmsp
Ow0KPg0KPiBUaGlzIGlzIHN0aWxsIGFkZGluZyB0aGF0IG5hc3R5IGNvbmRpdGlvbmFsIHdoaWNo
IEknZCBsaWtlIHRvIGF2b2lkLg0KPg0KPiBBbmQgSSBqdXN0IGhhZCB0aGlzIG90aGVyIGlkZWE6
IHdlJ3JlIHN3aXRjaGluZyB0byBzZWxlY3QvdXBkYXRlL2FwcGx5IGxvZ2ljIHdpdGggdGhlDQo+
IG1pdGlnYXRpb25zIGFuZCBJJ20gc3VyZSB3ZSBjYW4gdXNlIHRoYXQgbmV3IGFiaWxpdHkgdG8g
c2VsZWN0IHRoZSBwcm9wZXIgbWl0aWdhdGlvbg0KPiB3aGVuIG90aGVyIG1pdGlnYXRpb25zIGFy
ZSBpbmZsdWVuY2luZyB0aGUgZGVjaXNpb24sIHRvIHNlbGVjdCB0aGUgcHJvcGVyIHJldHVybg0K
PiB0aHVuay4NCj4NCj4gSSdtIHRoaW5raW5nIGZvciByZXRibGVlZCBhbmQgU1JTTyB3ZSBjb3Vs
ZCBzZXQgaXQgb25seSBvbmNlLCBwZXJoYXBzIGluDQo+IHNyc29fc2VsZWN0X21pdGlnYXRpb24o
KSBhcyBpdCBydW5zIGxhc3QuDQo+DQo+IEkgZG9uJ3Qgd2FudCB0byBpbnRyb2R1Y2UgYW4gYW1k
X3JldHVybl90aHVuay4uLiA6LSkNCj4NCj4gQnV0IERhdmlkIG1pZ2h0IGhhdmUgYSBiZXR0ZXIg
aWRlYS4uLg0KPg0KDQpIbW0uICBTaW5jZSBTUlNPIGlzIGtpbmQgb2YgYSBzdXBlcnNldCBvZiBy
ZXRibGVlZCwgaXQgbWlnaHQgbWFrZSBzZW5zZSB0byBjcmVhdGUgYSBuZXcgbWl0aWdhdGlvbiwg
UkVUQkxFRURfTUlUSUdBVElPTl9TQUZFX1JFVC4NCg0KcmV0YmxlZWRfdXBkYXRlX21pdGlnYXRp
b24oKSBjYW4gY2hhbmdlIGl0cyBtaXRpZ2F0aW9uIHRvIHRoaXMgaWYgc3Jzb19taXRpZ2F0aW9u
IGlzIFNBRkVfUkVUIChvciBTQUZFX1JFVF9VQ09ERV9ORUVERUQpLiAgUkVUQkxFRURfTUlUSUdB
VElPTl9TQUZFX1JFVCBjYW4gZG8gbm90aGluZyBpbiByZXRibGVlZF9hcHBseV9taXRpZ2F0aW9u
KCkgYmVjYXVzZSBpdCBtZWFucyB0aGF0IHNyc28gaXMgdGFraW5nIGNhcmUgb2YgdGhpbmdzLiAg
VGhvdWdodHM/DQoNClRoaXMgYWxzbyBtYWRlIG1lIHJlYWxpemUgdGhlcmUncyBhbm90aGVyIG1p
bm9yIG1pc3NpbmcgaW50ZXJhY3Rpb24gaGVyZSwgd2hpY2ggaXMgdGhhdCBpZiBzcGVjX3JzdGFj
a19vdmVyZmxvdz1pYnBiLCB0aGVuIHRoYXQgc2hvdWxkIHNldCByZXRibGVlZF9taXRpZ2F0aW9u
IHRvIElCUEIgYXMgd2VsbC4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

