Return-Path: <stable+bounces-232942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKMMA7kuzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:54:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E18538654F
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81373015CA3
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8293BBA10;
	Thu,  2 Apr 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YcP1igHc"
X-Original-To: stable@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5A3A4503;
	Thu,  2 Apr 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119456; cv=fail; b=d+Nuwl5i9XMRy50g/g9A8lbNeGbMGE2fquth+ENYM9+TUs769TAvZlgxGzpigX+OCiwcoeN5oBv9GTnq1LBZRyN8hZUdVA9xHOS16jSze3FyK3D6tSKLoD15sBJRgN4Ckw0sY0Lfo98UEFH/vHPu9kSrd+Lz3dKo4NdCO6Wb8VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119456; c=relaxed/simple;
	bh=08g4XwNAfBBy9YOYJ0X22Zfbr4teyRThECpQORpJiT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HlsbnRA19b5QoFlb+DAxtT6EYGTYPYl7jlvNeERiUo3DBGjLr5dXImUh8GY1I9MLF0wt+gLdKyCfKXj2PbbjdP2OyYY2AF9LPTrDXGeLnWpzhw6ddJTMF2TS/sW1mnaaynAiWJnHLbrPcgeekjD/wx8xugiV2NGKo9CKq6CCAjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YcP1igHc; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8sUXR9SjguuKqAV9wwza4MwMnsfUlBRontiQ+5kn1a03uaY7ToOUacmLNd6r0S41YyHWKPL+yOeqDbWArWnxqNjOPtqZR9n3LIy+zvEsDtd/5QdHaMtRyzRq6QSo771RKIGtDmX08TO+qIPexPTp76srlb6x3VwgHrQb5mupiqGf5KiyskKLOcB6ex5B+fYZWgCwcP2ZeiGzBMt89dwpthXN2bBEXs6W8Y7uwl5JkKGMxpznC3SzYeNKUzMORcWxrPI0hG4C9lCulqKQ0HMLbxwFSca0EbSs6/Vgi8ZcQh00IIa44G0R0Tq4/52TVfHvuidfrAE65eLNBAXN4sR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRciRWlqlnspWMjJwx73hG1h8KCJqU/eHDniAAWDfMo=;
 b=x4WXeNzAg/s1cRd2FqIiA8NoGAjCIzfz0lJi683dlvRage3sHchOloB6eqGBSp2p87nBzof9VUF+vXQt+l9Cg15b6iaf488WnMXW8OwalCRQW7Qk/HeWuNZExa8cgbIVStj6jkkVHWB+JlEZ1SGkBq979IBSL83lfTySV0KqVsH0YE7u3x4pQ4BVkUijOVYIa+SkA4jCRv14KnX7b6p4p8GXfNXIFZ7ih6lXT/Pko0uI8RTB+cGTOqsXS94cLhjc9KeNDfQbmk8NS0DYu3JjG8qx8Hcw/5e2tPOl88CpNdN0JnoTWItH0JfEGHw9RM0LmYhIuFSNH+K8Y4hEQcXx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRciRWlqlnspWMjJwx73hG1h8KCJqU/eHDniAAWDfMo=;
 b=YcP1igHcMhnRMQqhMYVKSXg7F/KIFHno50dbRoKqOrdC4sc/jYVTVbRfenrZbYrMJcdFl8PJ7xIhqPLW8u79L4faeoVD0TAN34zYLGm/HpK83Y3yXaz5++7aXwPleYTo9QoIv6G1HLWc8oYhvRMsJUXjTo5Lrk2qp2ucCoVdXwhYkLrF11qRZ179R0o10WeYqSvf6SSf5+tv9CKQpfUqoIUNFnX8BlzHmCpHOkDuIFmZbOUWOH0xDK+O7d0DdM32wLJhy+1p7zSyfhAdcJHJSd7tNjwfIMitlG3xy71p2G8X+yZWEmRtMJPTFibw1gRFplRAYs88d/ZWlNWsnvsuHw==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by PN0PR01MB9119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:169::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 08:44:06 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 08:44:05 +0000
Message-ID:
 <MA5PR01MB12500707BE1C6E11EC3F4B94FFE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 2 Apr 2026 16:43:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe
 controllers
To: Han Gao <gaohan@iscas.ac.cn>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Zixian Zeng <sycamoremoon376@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>,
 stable@vger.kernel.org
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
 <20260331171248.973014-3-gaohan@iscas.ac.cn>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20260331171248.973014-3-gaohan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::13) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <25947a4c-b000-4548-810b-60dc4572713a@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|PN0PR01MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c54316-acdd-492e-5758-08de9093ff7e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|22091999003|24121999003|19110799012|8060799015|6090799003|23021999003|15080799012|461199028|5072599009|40105399003|52005399003|440099028|3412199025|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdnTHZhcTYwME5jQXI0N0J1Yy9KUlhxR0lMUE5EUVB3WVBqUkZSTXV4R1hZ?=
 =?utf-8?B?bWVQS2h4OExJMDRxWWs2ZnQzNDNVZjZuejBOZklMdktZU3h0czRBTngzbm9O?=
 =?utf-8?B?TlBMa2hZZ0I5YmRHdThwbks5Q1ZMY0NNakNOUTRUcWpiQWQ4dDZvanUzZlFa?=
 =?utf-8?B?RytoRVhyV2cvVkJRc2U3NU5GNjM4YklUS3Mvc3M0M0RnY2hMNVR6dk9zc1JY?=
 =?utf-8?B?R3pwRThzbkZjZHdrK2VnZXVxL0xIN2h6NXdTeUk5NTZFNWMvclhSN1A2TmxD?=
 =?utf-8?B?bGFZZStROE5NeHNQb2RZZlJMMHl3SEx4SW5OM2swdEp5UTBaSHpTMUF1MXdh?=
 =?utf-8?B?Mkc1bkNvaXQvWnVlSm1sd0o4RmQ0T1FrajVGQmJyWjBMdHVpR0tBaUNWS3R3?=
 =?utf-8?B?dEN0ajZLdUlXTE8rK2VFd3N3U1ZjY3ZxTThJRFZlbVJSWFNFKy9zY0lkTDVV?=
 =?utf-8?B?U0tYMy9UN0dRVERKWE5ocTdmVkF6SVF4V1pZbEw1czBnSlNoaDVSL3hncXFs?=
 =?utf-8?B?ZndORGZlbEZHcHBJYXBkUGE4UTkydWl2ZytzRUd5cVVhMDFZcWlabmpNUFZM?=
 =?utf-8?B?blcwZnlVSS9tNCs4WVczdTlaQW9MZGhKR2R3aWRrakdMSUtPN1dVb1NlRkY3?=
 =?utf-8?B?SjVkV0VkeU1rLzVjOW1iK2FTMXRXcXBEcDBOcExTVzE2Y09iQTY1emRCVjJV?=
 =?utf-8?B?YTVHcWFBSGYwMjVkcW13YkhYdkU0RXhKUjdwZTFwZDBwYUplTjVsT1RBNk11?=
 =?utf-8?B?cXZseEc4ekxvYlorQWFpakhkOTd4cjRWTFBHRnk0d2tpVHJMRUp2YXphU2Rq?=
 =?utf-8?B?dmpsb1Y4S2I0bUF5S2lTNDQwQ0FJSENqcVkxemY5c1ZrK25FMkdDRTNwc0Fa?=
 =?utf-8?B?UGJWNmdmRDZpaDRUYXdXL3ZUaFdIT3E2Q2hDbksxa0RlMlhZK0FOdGt6SUVU?=
 =?utf-8?B?bmhCMDc3K1NEUnRtNk9SV3NabVFZRHN6UEhVNGJsWitZbE5Jbm5tSkFrSGQy?=
 =?utf-8?B?MkxWOXNsM3NQNUVWbFhzMGRDV3lQOUNQVmZBR1JHaHJwWnp0STNzOXhMMWYv?=
 =?utf-8?B?cmlRZ3QrREl5ZXNsMEx6b01YYnZLbFAxMWY3aWJEZCtSdWFkUUU1L21UZmFS?=
 =?utf-8?B?Q1hsbXB6TlV5MzlNWWxUS3IrVmJVTTZnUnhydkg1ekVMQ3QzcjRnTFJRN3Bq?=
 =?utf-8?B?QmVMQWNjbnhYYlJic2xreDdNV204WUR0SEFKV3NITDZKbjNMbVI2alFYRGQ5?=
 =?utf-8?B?SGhPNURMZG1ud0lETUs1MkFxektoOC9Fd3RBdzdQT3UwOE13NEFrVUI4VER5?=
 =?utf-8?B?OTdSVFpVQW9KcUxqUnQyeU9ldGwxMVBGejNId0JKZW9aWXJoeW9qUUhKSW5M?=
 =?utf-8?B?aDVpbUlYbllhY1RWUlp4YmVLeE4zcHI4TC9EUG83QUtUdExXbjdMSEkwVU9P?=
 =?utf-8?Q?qb1nMGlT?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnV4RHlRR2oxZDcrNG5RcjhRNHc2S3dpUlRISVUzRVZQNVlRSUhkSjJoZUla?=
 =?utf-8?B?a3UwbUt2bjkxL3hZL3ZuTVJ3cVM0SDBwYVphTGRHTncrTU1oeUdHVXhkaDNs?=
 =?utf-8?B?N3l3b1NVbjE1emlsc3VVUm12MmhZZW9HQTJ5WGxNWTc3T1RlcFkyelJTMUpW?=
 =?utf-8?B?VHZ5dC8xNmJ1c0ZZVTQwSG9nVlFoZkZqUEVadEFwUEZpaWFTZlhwdDFTalF3?=
 =?utf-8?B?cUtxUW5DVUFIQzhITkE2TGgvQ21vU0IxUkc4U01ZYUFIUE90MnBpUUtmcVZU?=
 =?utf-8?B?bGRWSjJrNlpPcUxtV0pIVDZ1MU5VMDZIN0hXTFhmbktxZHdRYWhHKy9SUGc4?=
 =?utf-8?B?MFlxY0tsMVR1VlFLeW9pNjJxWGIxMGcrN1NMWnQ4cjdPWXpjM28veVdwVjAv?=
 =?utf-8?B?WG1SR0RHdVRBLy9TQmxCbW9qRWVxbnRwcGZnUVNYNFlBY0NTNFRlU3hNMWRp?=
 =?utf-8?B?eFF5cjRQb1kxd1BVQ21PTUg3V1RLamdtbHRmMWdncjJKTTZEUUhQMUZQaFRR?=
 =?utf-8?B?Nk0xcHBQZVNxZVRFd21vWEZnOElYMmwweEFra0IrVmtoUmdJSXB0KzFFTVNl?=
 =?utf-8?B?MTYzdnprMEZFWTlSZVdhaTg1aHBLMDZQdUhwVExTS1cxZkhjZkI1c0ZCeVNH?=
 =?utf-8?B?ZDBGNTcxVlhHSkFORzNqdkc1NXkvc0x2eHR5TWxqNVc1K21LQzFWMFRTRC9u?=
 =?utf-8?B?N1RFa0lXRkVNLzhPbnd5MmFqcDZsZ2VyM2l3OVUvakNNN0VPV01XRmg0aURY?=
 =?utf-8?B?RklBenJ3Njk1SHErTGl5bVgreVQ3UmR1T2ZrNjNJaGl6eTBMOEZWZHBjZ0J2?=
 =?utf-8?B?NHd1WDM5NVEvZTVoVUNVRE12RW9rWENheXdQMzNoUVFMdFpDZXh4S2U4RFNQ?=
 =?utf-8?B?SnBiV3NPampsMUxYekt1RG15eGc0SjdSZTNSSHl2V2Q1Rm90eDJRcFRGVXZE?=
 =?utf-8?B?MDV5b0llNVFoOXZTM2gxcHptcG1WYnEybzJrUlU2NGtQQ2NENkJUYU9DYnYr?=
 =?utf-8?B?VzZpZ0p4OXpPcStpcUgySHZaQWFIQm95V01EVWNpWC9qV1JDMkFDWUxTSXhG?=
 =?utf-8?B?YVFlSG0wZ3h2Y2FWZ1RDbDdZcmxINTVUNTVMeHRlTnBZTjZXMVVUNGl5LzlM?=
 =?utf-8?B?Yk5ORm1MY3kzNUVrS2xVU2VIOEFEcmlhZ0R1SWIrR3lPZ1V6b2NkMVpoakxu?=
 =?utf-8?B?UVRud3ZOWFBIQzhLLzNYeVRyTk1Cd29aYWhwTlRRVlBwQW05cVFqSlJ6b0Ra?=
 =?utf-8?B?aS9aRW9RdmhyMUJhMFJDK1RpY2RkUkdDSlpnNzBaSDFOWE9Tc3Y1UGJ4UWti?=
 =?utf-8?B?QlhXT2RVcnM2a2hSeUk4c2swcFRLdzRUT2pvWnFtcUs0QTRDS0JHVEsybHZF?=
 =?utf-8?B?V1k5TFQ0dWRrK09Pc2FGM0VONk5BbmtNTGswZHp2QU13RkRrdXFLM3ljWGdz?=
 =?utf-8?B?ZDRHZ0traWYwUXVUS0NkaFlBYzhxbTlXd1NCRnN3bUJzODZPckg5ODhaMUxn?=
 =?utf-8?B?b3VoaENHVHhjcnZTc2pxRFVNcThXb3BRTThsdmtuZ2hIbG5kcmRoUzIycDJW?=
 =?utf-8?B?cEd5VjdnSTNrSXlsbm5ndEpYMHhXdGVXWXhnZlg0bjVya3I2ZEM0SUFEVkps?=
 =?utf-8?B?ZEQ3WmpCK3JYT21kbFdML0tZRG15Qm40b1VKZzFZTVAxd0p2RW5sOTl2WWxB?=
 =?utf-8?B?VUIyd3pGZTJROURYK3hCM1lvSnRUM2hteVk3UzRjTVdJM0VjT0hqeDViQ29B?=
 =?utf-8?B?MWpOUmJad2swTFVVcVhRcE1tQU5nZ0E2NVFvR3pWVzZUL0hlRFRRVTU4OTVk?=
 =?utf-8?B?aThubEpuMTNlL05ZeDBLbUpndjFraFB1OEQ4UUJ1SStHMFI3S0Y4UDJURmpC?=
 =?utf-8?B?Y2UwZm5rQjdFamZxNk1id0JxUC8zU0NROTJhS2dwVGhRN0o2VmxOeFVKNUE0?=
 =?utf-8?Q?yXfyYc9tkEVaHpDGrpmVTFBHQS0vw0lI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c54316-acdd-492e-5758-08de9093ff7e
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:44:05.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9119
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232942-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[iscas.ac.cn,google.com,kernel.org,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[unicorn_wang@outlook.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3E18538654F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/2026 1:12 AM, Han Gao wrote:
> SG2042's PCIe root complexes are cache-coherent with the CPU. Mark all
> four PCIe controller nodes (pcie_rc0 through pcie_rc3) as dma-coherent
> so the kernel uses coherent DMA mappings instead of non-coherent bounce
> buffering.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 9fddf3f0b3b9..3af770549742 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -417,6 +417,7 @@ pcie_rc0: pcie@7060000000 {
>   			vendor-id = <0x1f1c>;
>   			device-id = <0x2042>;
>   			cdns,no-bar-match-nbits = <48>;
> +			dma-coherent;
>   			msi-parent = <&msi>;
>   			status = "disabled";
>   		};
> @@ -439,6 +440,7 @@ pcie_rc1: pcie@7060800000 {
>   			vendor-id = <0x1f1c>;
>   			device-id = <0x2042>;
>   			cdns,no-bar-match-nbits = <48>;
> +			dma-coherent;
>   			msi-parent = <&msi>;
>   			status = "disabled";
>   		};
> @@ -461,6 +463,7 @@ pcie_rc2: pcie@7062000000 {
>   			vendor-id = <0x1f1c>;
>   			device-id = <0x2042>;
>   			cdns,no-bar-match-nbits = <48>;
> +			dma-coherent;
>   			msi-parent = <&msi>;
>   			status = "disabled";
>   		};
> @@ -483,6 +486,7 @@ pcie_rc3: pcie@7062800000 {
>   			vendor-id = <0x1f1c>;
>   			device-id = <0x2042>;
>   			cdns,no-bar-match-nbits = <48>;
> +			dma-coherent;
>   			msi-parent = <&msi>;
>   			status = "disabled";
>   		};
For binding changes, LGTM. But I have a question regarding this change 
in dtsi.

 From your patch description, I understand that enabling the 
`dma-coherent` attribute requires upgrading the firmware `fip.bin`. If a 
user only updates the kernel (which is relatively easy) but forgets or 
doesn't know how to upgrade the firmware, enabling `coherent` might 
cause the kernel to skip all explicit cache maintenance operations. 
Could this pose a subtle risk?

Wouldn't it be safer to leave the upstream unchanged in dtsi and allow 
users to add the `dma-coherent` attribute themselves after they upgrade 
the firmware?

I would greatly appreciate your guidance.

Thanks,

Chen



