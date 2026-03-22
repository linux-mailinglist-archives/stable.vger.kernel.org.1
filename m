Return-Path: <stable+bounces-227840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fZsjNz4CwGktDAQAu9opvQ
	(envelope-from <stable+bounces-227840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:52:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FE2E9B92
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BFF13004C8E
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A82364046;
	Sun, 22 Mar 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rc5hgaAI"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C1940DFCE;
	Sun, 22 Mar 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774191160; cv=fail; b=dKGv1yqi5eLwLuDs7SJg+pEehv4UPqX60cVaiuvGvzWJSnUL9gPseVCETkNbaYMkFEOOvAi0x19o4FTnEmZuJTwSozAxzmQPbTrtmzt1X7JELTBbn+wSeUUKGsKTK6gnE5VPpA0CFi6wZelE+Y1fNrMyoGfSwJ29yhiZopKXxbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774191160; c=relaxed/simple;
	bh=Si9uL3rdQ9SU3vORWuuQ7MnDjCabr7f2VklTOW+tc/w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MzaoAOsGb70WHfiH3b6oqzMaFfr6dDnyEZdFKe9NqIer6uPp0ncZCZZfq+q1RH+CDe/DErySOtNiEtE887xUR1D3bz9ZmAY8mjk+5ZvJ3zmYL4wwSgPy++9EEmC9cTABtSQIoEiUqh64eNF7WsoWqqdcS/dkXTv9HChRErTQmks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rc5hgaAI; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0TjKjvADUnf6/bIYMleZHVgX9GfttcAs1IRjCyw5CdGDWNdLSGvio+5j+HjLuEcy3DT+E47w9z7Y1qWdsZXtbF+ULmEcL2HEO3TAAK/T76A1a2Og7N7iD4kHjDMOkqmuBooQCGFg5YfjsOt+oWog0d0krsvSrCNhV+lU9Wxe+7mBYa/Py5c4OcIMqJh769WL4yj47ZtjNJ192KDhN/wLN3k0q3wwsudpjnd5BR2ivwcplLz1z8I55UniYvZ4A3zLB/lhPuRFdAEb14OsPpOERsfe8DCmjd6UJF20r3p1wfG/OeuF/zTN30ALbYypPZi2gI75K0wdtWZ92A+bTbT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si9uL3rdQ9SU3vORWuuQ7MnDjCabr7f2VklTOW+tc/w=;
 b=Ykara/ltOzFGjUsxSdKxckA0gIl9Th6ivMWu7elh7qgzznoeOUrTtZy5Zt6P37IGKEpY+kmT7TU4PTV/ghyUk/s877XJP1zRmDA1O3HTPnellvll0l7w5Kh+9Fp4lMAq7SlZq/Xyu9rI/Q+XdRtCp3/F90ntgkFCGko8Xq8roEMrW7orXJ6ToqGAUx6dbMkyV2STY3Q5ty+wzCLOf2dV2/F1jO3T1tfEte/QBoATnSLpvNKIJL5srZvE0GVpN0nWREVQ04oQ1+0roch108yRm+3mErKD+bV1rWfPPBRHLI2kwFpe0SaaIYWKNPQclTZ0fURWQF2qTvc/RERjP7neFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si9uL3rdQ9SU3vORWuuQ7MnDjCabr7f2VklTOW+tc/w=;
 b=Rc5hgaAILJcDwylhooPFa/9NyO+hbiKvhsR5uhYNblzd2WU5HatWyCC9tyN8mx6cWiqumYfhC/7A/Ul7TRU2CmoGCCU43Y9/eceJpst1UB2+e7njBoAIYmv7rmqoCkyg5XlMkZwn5Juk+hpbL+s5gcWSP0ais7Pa/es7WlUbqCKScOkLqXm8Ut2qcDwZ/aF6KmKB/NMEvoRNB19VZSli0Zpxgq9zsZyTNd5WMBJJg+4lxV7oUv7dUU7EZ3UhBJcRsXGgeuCa9tyoOEhVMcEQtsG7JjAR4S5e6cW67mMdorSZfQkMngHEy5ohlg1Wp1D3h47AmUFTpFzl8SKSosPt1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 14:52:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Sun, 22 Mar 2026
 14:52:35 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Mar 2026 23:52:29 +0900
Message-Id: <DH9E9U6RVA1J.NILSW02GNOBN@nvidia.com>
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from
 public attrs
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260321172749.592387-1-dakr@kernel.org>
In-Reply-To: <20260321172749.592387-1-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0239.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a402f15-1a0e-4fe3-f44f-08de8822a699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	F4p0BpsBr7aT43/JKhtrnE5nyKnwP3lCOXolGhIMAzgxMLrtVW0tRwd8DFuwHao9VtA3RBpnpH6kr3dA3181shcaf7On3WgsPWy5VKL6jibH8qrqX16Q9cBg+Tsft5TpHJw/HqPP1MpcFz/tFqYGBiqXiyuI/P2sr9fu4Wdr6aDTRKx7pkNLNe7cRne3HUyhriz+G+H++eteYtwyIy9pS+vIEGMf9ZNtTGGqsJgMHvfZMQCTGfRvFnq2KnjzlBV1TiPu8a+faFUeGqdg9PbDSOzacZCJ/sqlALh+HKzjO2BmOnn3ZPjlBZEphzHCx1gcZ5uELz+RefqjPgGTIFDhxrpzKpunEwLErzghVup/TnV+24+PhePolCzaBudghwnaM0inLDnhMJsbPAP/hgnfVRGb2u9fbMj05dbvweyxhtLftnZKQ/eaFnIeCA0KvTjpxSVprwubQrePGa9HcEgOMBJ1R+/B36GJqCBCa6hYhBbly/O9ARyEneZ+MScCXSpWojZxR5Jo8kORwwbP0AKZyiaVD1/HaQOP9a+pv3fl111bMi05GaYYFEb0jj/vRby/5/AGZTchs5Mmlo1drnzGzKkem4w4pORoiGz3HmNwCQTE9NYH+i4Ms3tH8eypv8k+J5NA9HRbLkphRQVemOn5nMCoBU5kIERDZb9viAlLF77ndk+jv1gSw85XM5RVOAJjwS4DLIjLE4D099F8DFOgibXWrZdTDwgJe6tNQMl2pLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZMd3FwMC94OW9aTUVoeEJlWDA3RzNHRFY3Mjh3S3V3NlJ3WXpWTDFablJS?=
 =?utf-8?B?clh0ZzRKajBTaERLUnV1NVJDWTl6RnJkTEcxdkxwQWFHZTN2TFpwQk9CUGFv?=
 =?utf-8?B?TitUSWRSYjlvZDdsQ0o2bVQrSnJ2ZzkrMlpLem5sTW1yQVp4aEVDWlRLaUVB?=
 =?utf-8?B?Q01ZVG1EZ01rODJnUkhVS2dINStKaWJ3Z2pPaitsdGs0OHZQVS9sVXVrdEJk?=
 =?utf-8?B?TDgzb1B3dStxenVlRVlHYTJIZi9yV1VUUDE5Rk1sNktNbUltVW5CekFZVjl1?=
 =?utf-8?B?RFBmcUV2cDBXRWxqekRLR1Npd2dkY3NYa0RXaFpXSTFIa0JNbVF6bWZjd3BG?=
 =?utf-8?B?U1IrSlFHSVNDOG92ZHNBbUgvMm5aczlOMWZlOE1KYi9HREZEZGxvREZpaUx5?=
 =?utf-8?B?NXgwalJQbHBGNXlFV2NDR1ZVbWdmNkVybDNiSXc5d204UUt0REhvNnhEeXA5?=
 =?utf-8?B?Mjg5NldnZkduWFZYZC8reVJjbHFuQkdRSFZHeWFXN2ZybUMxazJvNCtTZUZL?=
 =?utf-8?B?ZEVZWGJjMFRiUkVlNjk3Ym55VGtiOHNMVVp2dzNocXRDU3FFSzhMSEhraWhV?=
 =?utf-8?B?bmJGV3MwUGJCc1V2MWNCMWxpZEFPUVdDYk5UTEdGckh1QUJjWXYxb0FnYVQz?=
 =?utf-8?B?cjV2RTZDcDgwWHdPSHBCMjN0RkIwc0h1bDc3b1BjQ3Vyb21WZmx5eFl1UkNI?=
 =?utf-8?B?NmE2QUFSK2VvanVHV3U4azF3M05mTERpNWN5STlLZzNDR3MvbkZUSVhzVlR2?=
 =?utf-8?B?cS9xbXRjNGcxSXB4OG96NTJyVDUycThwTmJEV0JSMng1c2M2dzVSaHovZTFF?=
 =?utf-8?B?bmhMOWI0dmdaQ0E4ZGxYcmZTM0UwZ1F2c09MdGwxYjhNK21sU1FmVCtlWmFj?=
 =?utf-8?B?K3BRNFBYTnFOdVVVTTRDRWU4RUhmcERoaWFwZmc1QzRSZzFqYUt3V0g4Mk5N?=
 =?utf-8?B?OUdFR0tGamlBVEpqWEU1Qm5lN3oySDU5RVFMelBtVmxFREZJQVJiOCtzbTZo?=
 =?utf-8?B?Ykl5blA2T0YrbzhnTkErZ0xmNHIvdlB3RmJhTzU4SXJtQm03cnU0S0M0M053?=
 =?utf-8?B?UVZKeVRFcjNYNVVyOFl0aU5lL1BTQnc0MzBuU3FBalM4YmF0UVBudXlXczVM?=
 =?utf-8?B?NGVnU3dHUDdVNmN3K3IySWhLVXMyZW44bWxPK3dIbEMrdnVVdDFqNDZPRGVp?=
 =?utf-8?B?NjZ3S3FLaWFiU09wYitEbDBIeEp4SEVDMEJxVjJnNzZZUElvSlRZY2xsT2Rp?=
 =?utf-8?B?dm1qRU5ka052MkdpYkR4emRWajEwdTdzN2FORUpCNVp4R0JPUEI4SldvOXpG?=
 =?utf-8?B?RkE1VFpWR2o2Rk54T0dLWkhwbVlXM2g3M255eTFmeUVNKy9RdW1UalFwR2tn?=
 =?utf-8?B?RCtSSmpyN1pFZnlmT1FQZk9hd0EzQ3E2VjNKd1BmVUNMSHIwTzgyMUZSMzhm?=
 =?utf-8?B?K01oYWtjVFpmcWtoUGtJMXlERUVrTHBjM2pKSTNGdW5jNHc2cjgwUVI3bmhY?=
 =?utf-8?B?dHl3NVBUVUhSMGM2Rm5pR0dpZzZaTi9URDJGSFUyR2hDWkZjUGZsclNwR1ZD?=
 =?utf-8?B?V3ovUmFRdXBxZVdURkF1Z2g0TGVSVm4yaXo0VEF6YlU2UVpMNmJKOVd0TExE?=
 =?utf-8?B?MGdDeWNVTm56ek1JeXMyQUVndjA0TjgrMnRlVVZPc1duc2JLR2tFUzM5bUlT?=
 =?utf-8?B?dFdIVFRlaG5KRmoydmJsczIzRThKaU1wZ1FleDUySzFCTWdxekFCNTJxL1NT?=
 =?utf-8?B?K09ORUlhdUVOSFUva3NhUjllbU9jcnNoWHVHOXFVZHM4ai8rWlNFNlluK1k3?=
 =?utf-8?B?WHhTd29CTVh3WjJOYTNTbEtjcDJlYm5SbWNLbEdzdkErZUNwa0dMUTQzd05V?=
 =?utf-8?B?c2h1T0Z6cUxiUmszbVJrekNvdFhJcWc1V25xSk1FNSt3bm9WN3Z5UnBhaDZU?=
 =?utf-8?B?S2VMU3k3UmZERlltMXhMNVNnbDBNOWxZaGZacUp1SHFhd1RFZ0N3VTR2M1l5?=
 =?utf-8?B?dFFLbzVKY1JVOHVIcFZkMXV2a1NSRWkvY2ZuVUZpUzNsMlRmYmZtUzBOeUpI?=
 =?utf-8?B?VWNqV1paVVBmT3Fia3Zha1JzcXNBWTVLT0lBMFFPeWh6bno1UzdmZkdqbk9q?=
 =?utf-8?B?MDJFYWQ4Yi9qK2Zja25nVjVxVDRqanppVWpNNzNnZ1ZwdElKTW0xRnUrNXpj?=
 =?utf-8?B?VjR3R1RVNENkVldhYWNjbHFvODJack9lcDdmOWtkYzhKR2xudHhiVDJ2N2xU?=
 =?utf-8?B?N3ROSlA2WTUyM3B1VW9LQjB1STJJd3k0S0M1ajRjcHNBZXF5bjQvRy9BS2tP?=
 =?utf-8?B?UkYxVHEyWCtQVUJRdDN5cnlXSVVvd2dpL1drZmFTb0p0V3hONCtsenhJcm1m?=
 =?utf-8?Q?rGB1iv6/y4RCenKhxrYImHF7XyfdxkI4jD6Tt3fGEKx54?=
X-MS-Exchange-AntiSpam-MessageData-1: gpOi7IVZjSPCNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a402f15-1a0e-4fe3-f44f-08de8822a699
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 14:52:35.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbzeifjXF/9m14Z0EcmNLCF8EI9wQRBwW83CdghsGi7OGYjUT/fqCP7fuBGdTIkO3wrjAeQQPGoxz3Y3akiomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,arm.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227840-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D12FE2E9B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun Mar 22, 2026 at 2:27 AM JST, Danilo Krummrich wrote:
> When DMA_ATTR_NO_KERNEL_MAPPING is passed to dma_alloc_attrs(), the
> returned CPU address is not a pointer to the allocated memory but an
> opaque handle (e.g. struct page *).
>
> Coherent<T> (or CoherentAllocation<T> respectively) stores this value as
> NonNull<T> and exposes methods that dereference it and even modify its
> contents.
>
> Remove the flag from the public attrs module such that drivers cannot
> pass it to Coherent<T> (or CoherentAllocation<T> respectively) in the
> first place.
>
> Instead DMA_ATTR_NO_KERNEL_MAPPING can be supported with an additional
> opaque type (e.g. CoherentHandle) which does not provide access to the
> allocated memory.
>
> Cc: stable@vger.kernel.org
> Fixes: ad2907b4e308 ("rust: add dma coherent allocator abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

