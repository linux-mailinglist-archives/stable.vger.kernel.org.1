Return-Path: <stable+bounces-219691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH3IETRDn2laZgQAu9opvQ
	(envelope-from <stable+bounces-219691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:45:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D96EE19C673
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4F9307E09C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A240392823;
	Wed, 25 Feb 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+1HwC+k"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7272C15BE;
	Wed, 25 Feb 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045019; cv=fail; b=Nx6/sIlCqaDFYzF2R8C/olb+NMXLjQG3U97k1PMO3bJj1Dfa17DgmaxjejFnKXQsfBCphk9gtF5yMVTCC1Rm9qeuC8C+c1XoY2InZb8Xjigb7uEFLuPAGcq6RZxd3sQ3pC/Q902RR0/K01Ln9KJOoMWwRNfyWVjgbWkrhRTBRW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045019; c=relaxed/simple;
	bh=oR5kXEFkB+JfeMfbpnC3izGWseTp6RaTZThHjl7c1oE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLGDSbgFIzpW0w3fnPeCUkoUgGggmfqnL/kwxkkoD/6CYiLZB8QhFPp/2eb83AZFczIFxlKJlTwU1xOuklOV8nVjhDbnlErhPlYdTRjU82wy0jxYU4YErDtVdP8xBmJ1WxXHiz7Tkb1wpa8Lb701G9AnWLK+0i5VP1oAP7shXk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+1HwC+k; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIdQsj62sQN17Bi1g01MO3W0Ymk+3YARIlWhvdsXwPsXWZ3+8YjKxxnIwqEHwJKiXwcmDejZvIbp06T9lfm1hBPQaWR/JmfFaVqMg1oMeJBPDX9WcAEJto4/XVQ6bGSL/ObpK6UEaijxBpT/Jgj3+ooLEYQgSDehzLue265ZqgRkz5pk/0aXlx82wvFn+hfIY7sfDf0paAOXcIPNxh7KGyUhgwSjqLC+H8jD+bQSzq+G8UZlE/dEVurZNEHcYqdLnvxUw+XGW9cf75sLB7PLVTlx9f68eahuVGjbBuQMs96zie/HjwsS10jen53cKfwCw9Cp6wy83QJ2OFxv0vq8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/8s97d4dOnjH5bDepWY6R4BRwZ6G+K6Vkzk04tBs2I=;
 b=Yf3xXQDWAKOefCItJv6HyiAMxOAzJN/WsdfGMNqAaczuEtZQSke3q7ueBclzTyK+F3EuXptvaif44TZNKeGCHACI3wBusMLo74k6wKAeiFvIKRBJ0AjXy2QUAABX6fTgMpeTFijIbz4NF8onEo61UfcFqOIikKBla7WX0SxbtmM4th3kN/Hbts7Dse7e0IFa/Whc0n4bssl63L7GWFuNicAqWYjyFa7/2OC1ccT2EvL4PK7q3ZVM20L1BKcSgIzfeA8a2Mk73/+TOZZSb3mvSdDSyM1mx33HPBt4GmUI9I+LJOz18Ek6MJ3+6YGGdc1oT8FdFTJbsSxtfzoUKpoMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/8s97d4dOnjH5bDepWY6R4BRwZ6G+K6Vkzk04tBs2I=;
 b=j+1HwC+kKeGD3gA9KWugDcYepGUhFaGVPwXAHCBv5Pw6dIX8j8oSw6t6uSOR7RADTqF92mgSbOZ7snFoNBi4okYzJMtsjXaSvWXBFhEzrt+Y17/H9DKcTFrQI8Py8Zk6tInpoLAApspQNuVnb9feGq7nMUbgtD9aE0SqGkWZOJk3eEWSdLTLO3DXqezlqikUeqFCKjRcJdWPAZwNzaTDWhh5Z/Zn8xP+zhyYqFayLkODlrBEta2wKxpwHFXNSyJDFRwYPFpjRvR3IKyJqPj84QyzX2c7A4Oce0HfhfPP3JJTojJLIPxYYsXaiZUe1Fo1cwSwzq7wwkTPfrS6zBoLHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 18:43:28 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:43:28 +0000
Message-ID: <4dc33cd5-cdff-4132-b879-68af8412413b@nvidia.com>
Date: Wed, 25 Feb 2026 19:43:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott
 <sebott@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Benjamin Block <bblock@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Julian Ruess <julianr@linux.ibm.com>, Ionut Nechita
 <sunlightlinux@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ionut Nechita <ionut_n2001@yahoo.com>
References: <20260219212648.82606-1-ionut.nechita@windriver.com>
 <20260219212648.82606-2-ionut.nechita@windriver.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260219212648.82606-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: c71893a4-bbd1-4b4b-0041-08de749dc419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	LxkJzbVmnvGaSojOuuhcG28hWleCnUsQdUW/If10KQJOBLTpMnAdSw6a+iVTxCJrYiN0+3csGZXL1VsiFd4j34aAtqV++hE8ipMVP8xUPe9RjRvhDkiBUstgjgRSK7awNcrSqkqJv/19fC+kFfci1MCT0LiYuwojT8U9aLITZ3EXl5h2mpQpHMJqLYrp/437tnp+0mXqn9nlAadot5L3ZVILouqeJr/4cpTXkyOoZyTsf4lS/Vj35GbvO72Mq8XdTqfJHrHErZZ+/1VTc2VuPBRocmnnD+SiJ+7AJWaVo48Ln+rxVTuUN7vwcVN0xmXtznlT2GAdf1ThHXUGOv9L2jpdzLRFib+GxeFEASo0Ku3bPOZE6rVezFFlkfljIT+e5/GJzkIoJpjN8NA72tqzHvJTcB10OzurHVzwFDOC91L2oNdsXvi/N5X/aLOCgyVJ2FjZbq4H8cj+hM952FRs0DyH2JKX1GDUY9lLbG2DctETY8RuvB+L4s504ARtnUCBnyY/aklHLSwV3+Z+3fRs9JZjH0c+GtDJYv3xSpDU7DDr/rPeVLTqAaJJgHF4dHqF90pTXHFdOEiVLOfpgfuhpXAbAFEJ3QCcuxcMZv22CsBZt3fN1NtW10CZDL8G7cq161jGhp9h93TUv135XkYZuGsaWpvudG/dbhTOHNolSSlBncYkMo2+DVFg6yH6vZZASf6wSpcsCrW1wTe0e5wQmL4OIEeh5f7RyL3691vv75c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWVnMVdVeDNzSG1UbHFYajdCb3JjenljWUQ0cDdUN1pXRG54RGFsbEFTRlZD?=
 =?utf-8?B?TDlSZjFCTTV1ZTZ6bCt6LzY3SysvS2FwYUpzSEdKbE4ySXM3WkVoTmdnZVZk?=
 =?utf-8?B?NXRRejcxTFZGZFl2a3FPcHZVTnUrazFNVGZxdGg5ZkNRb1FLM0Q2NDBFRXZt?=
 =?utf-8?B?M3UvOHZNRS9pSXRYUXpvUlNXdEhyRjV1Y21aQStsdUhUcTFaMkR1UFY0Z01a?=
 =?utf-8?B?bVZodVRFM1dTY3c5Y1krSlRvZ1FWMHVYNytPRGFpR3orUjR0eXlPYlJMdGpR?=
 =?utf-8?B?bFhBcXV1ZzFvM1l6RDh2eVo3UVBHNStwaE1ZcXpwYkhxSGMxVCtVL3BYcmg1?=
 =?utf-8?B?Q09LK2Q0ZWloMTZwbXByVHBjWUpTSEJ0TFB4bE9GTEg5elBxSXhrY3psVFU0?=
 =?utf-8?B?WElCRzlCUGttU2lTSFY3QkJQTktIazlLNjhUYU12SjRycUJyQy9lV3RsUS9O?=
 =?utf-8?B?b3FpcHhIS0xTek5WbnNhY1FEK3FxZVJMVGxMU3JJOW9OMFpuSktyZ3VlblJ2?=
 =?utf-8?B?QitQYTRhbS9Jb1c1M2hxaURqUVdudVloZEJnMVlzSm1OMFh6ZkRoMkJQV3Bw?=
 =?utf-8?B?VjRxTHZ1SDFUbDRzd1Z0TWtKMXRBODVFK3p4WHNGMVo3ejFYRmNwSVd5aHQ0?=
 =?utf-8?B?RkovM1VJTkZNcG9pRTJ2RG1XcVNLcWFMU0FoU3lJTHRtZFhaeEtsa1hpNnRw?=
 =?utf-8?B?M3dvdWlrNjVBd1h0VU1rZFJIdFpnOTN2R1o4VEowYVFhRUJNN25NNElzUXRT?=
 =?utf-8?B?TVJ4WFp3dFdSaTlKRitMVS84c2hOcmtSU29sTXBBSHlyaHlRTDhQT0NkaFdl?=
 =?utf-8?B?SWVaNTMyakJyYnZTL1FRT2ticGNkSUJLOGpYVnZSUlRPaDU4ZmpsUVgyaGhq?=
 =?utf-8?B?TFdmSjhMenBvOXBldHlySHpBRFhUYTIvVzhNdkJKcEh0akdncWFNL2JzTzE1?=
 =?utf-8?B?RjBsVmk4azkrTHptYm1ialdqeEN4SmhQZHdaeEZNODJGbHJqaTljeU9kWGZH?=
 =?utf-8?B?NjhueXlrbFRUQmpKN0RhbXozWUhQb3hsZWhTcWdsRDNyTnRuOU9HcnhrUkYw?=
 =?utf-8?B?a04vNDJJeEx4YVVDRTJaeS9tWmE5NElhdVVPaFBBNWs4SnlQMW5XeWtKMW5a?=
 =?utf-8?B?N3dCdUZETDVYWkNpcG4vY0NPcDgrY2FIU2RoYnpxVmNWWGhqR2FPN3docG5Y?=
 =?utf-8?B?OVFTTVRiMTJWZW9EaW4zcFV1Q0hUcWNsaFU4UDVmaFVteWJlaFVYRUdDenlW?=
 =?utf-8?B?QWkvQy9pN3ZZemJEbG83WW93SUFHVWtaZ09uMVY3WVIzYzhwTExRdkdzd3JB?=
 =?utf-8?B?OUhmanhlcHdleHB0Z1Z4eFFwVDVsNXNnblF0SHZmMXhmQUxpNWw4alJ3emJR?=
 =?utf-8?B?cEV1RnRxVHBTbkhmbXZQRmhOSU1xZVNOdkxCdDdaUGJhQzc0LzdoLzFMSzUz?=
 =?utf-8?B?RDY4bjZ6STVmZnFVMmhmVFZNckhqQ3BnQzhXd1lFYy90cEtnWHZ1RExDamZi?=
 =?utf-8?B?NWY1S3g2RUFNTUM4WjIrT05Jbmp5NzNTMDU4SlNkaGhPZ2xvTEt1bjdFWGt6?=
 =?utf-8?B?aWF5RmhQY3ErWTlPY3A1OTlWbmJJTkJTNzdOejdDakVNMmtldVVPMXo4YUpw?=
 =?utf-8?B?cFMwcVNZY2llRFAvL1lKVHdGamp1TTFmV3JvS0ZROUU4T1VOS1BqaGRZMnpT?=
 =?utf-8?B?czVuc0drdVRHZm93Vll1dnJuWnlQWGt6TXhoUXg0NStjRmRoOFo4TzVKRW5s?=
 =?utf-8?B?TVlrNmZFOFJkWnloN3lUL2dDSzdKaURjbThBdnh2Mnp5QWpqRE91c3hwQWZL?=
 =?utf-8?B?d1ZuVnM3UTRlWVNYaEhiSlh2Nng2MlplVm5LMHA4OERDY08vaVRMcnppVGk2?=
 =?utf-8?B?OVJkdWJkODEzUlN1Nm5ZVUw3SnpoVlQ5Szl4QlppQWhMQlFEN1hWM3M2OElQ?=
 =?utf-8?B?RVVub1FoeElncEsyN1JtYUY3Zm0rd2l3VStZUC90c1lndXk2L3dNWFF5QTFj?=
 =?utf-8?B?UjBNTGVtTDlQLzkyVEYrZkFneHc1ZFc0Y3VGd2hUR050ZzdFSTJhRjI5U2RI?=
 =?utf-8?B?UFRTSnlZMS9aNWRtaFFZZi9JSW91TzFsNUhGR2tqSVgyK1VKN0tTRWNLQ3B0?=
 =?utf-8?B?RUorK3BBc1lqa3BXUTFFa1NUd2QxaXpIbjVjbUl1MkVseU1LNDIxMWs3Ump3?=
 =?utf-8?B?elpmZCtibWdma0RrVTFJaWtpOXJtK1BjOG9TQTJSNlZLS2ZjakViZWZRWXlp?=
 =?utf-8?B?Z2dhL3RqbU1iQnBhbDlhN091elkzMzdqa3ZHMGFESDN4VWVPZDNkSHlqc2w2?=
 =?utf-8?B?a0xLMlBkK0l1SERVNmtsWDczRlpYMnMrS1h1NTQ2b3JHMlh6NEtoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71893a4-bbd1-4b4b-0041-08de749dc419
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:43:28.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enRE5CXZaahASYfYZyfTLBmt8ab0X+CrXY31Cz7dn6yvs8MCvMHE/XbkjZMjDrCF4U612aqywd4qd5LnXrqEYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-219691-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,gmail.com,vger.kernel.org,yahoo.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: D96EE19C673
X-Rspamd-Action: no action



On 19.02.26 22:26, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") and moving the lock to
> sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> or manual unbind) that calls pci_disable_sriov() directly remains
> unprotected against concurrent hotplug events. This affects any SR-IOV
> capable driver that calls pci_disable_sriov() from its .remove()
> callback (i40e, ice, mlx5, bnxt, etc.).
> 
> On s390, platform-generated hot-unplug events for VFs can race with
> sriov_del_vfs() when a PF driver is being unloaded. The platform event
> handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> leading to double removal and list corruption.
> 
> We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> be called from paths that already hold pci_rescan_remove_lock (e.g.
> remove_store -> pci_stop_and_remove_bus_device_locked, or
> sriov_numvfs_store with the lock taken by the previous patch). Using
> mutex_lock() in those cases would deadlock.
> 
> Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> pci_lock_rescan_remove_reentrant() helper. This function checks if the
> current task already holds the lock:
>  - If the lock is not held: acquires it and returns true, providing
>    full serialization against concurrent hotplug events (including
>    platform-generated events on s390).
>  - If the lock is already held by the current task (reentrant call from
>    remove_store or sriov_numvfs_store paths): returns false without
>    re-acquiring, avoiding deadlock while the caller already provides
>    the necessary serialization.
>  - If the lock is held by another task (concurrent hotplug): blocks
>    until the lock is released, then acquires it, providing complete
>    serialization. This is the key improvement over a trylock approach.
> 
> A matching pci_unlock_rescan_remove_reentrant() helper takes the return
> value of the lock function as argument, so callers don't need to
> open-code the conditional unlock.
> 
> The "reentrant" naming is chosen to avoid confusion with existing
> mutex_lock_nested() which is a lockdep annotation concept, not actual
> reentrant locking.
> 
> Note: owner-tracking patterns for reentrant lock behavior exist elsewhere
> in the kernel, for example in the regulator core (drivers/regulator/core.c)
> with rdev->mutex_owner, and in the PPP subsystem (drivers/net/ppp/
> ppp_generic.c) with xmit_recursion->owner.
> 
> The declarations are placed in include/linux/pci.h alongside the existing
> pci_lock_rescan_remove()/pci_unlock_rescan_remove() declarations to
> maintain API consistency and allow use by external drivers if needed.
> 
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Thanks! According to [1]:

Tested-by: Dragos Tatulea <dtatulea@nvidia.com>

[1] https://lore.kernel.org/linux-pci/a02222aa-64a2-43b9-86f3-a31b4668206c@nvidia.com/

Thanks,
Dragos

