Return-Path: <stable+bounces-227900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2InrFlPtwGm3OgQAu9opvQ
	(envelope-from <stable+bounces-227900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:35:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9D2EDA71
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1168301E3DA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B435F61A;
	Mon, 23 Mar 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="K12JP9xN"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010074.outbound.protection.outlook.com [52.103.72.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692733090C4;
	Mon, 23 Mar 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251205; cv=fail; b=nJbLoK3ZHFXC/9fDIs7Zo/770znTVQYNuRgk7Y3Sfkkc7OxQ/fljNg3U3ywJ5x+Wo6pQDgYJrVS1TSaFHyaLmg4YDw/4QCMn3C8shQU1tzFcY8pe3mqRhZ5SLwcryR5IfU72EuwGEB+fGzrzs0EnEs5Q+3NjTsc6OI0fJ2CxsBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251205; c=relaxed/simple;
	bh=QmPr4KVyrKdy6oTeuqq2YdF8MgOwQth7pFVwOp6kmmw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=bB8jimVrd8HBUFV3R8ZjIKaKKOfPNhZjOjQaHu69yydEXAs0qrw1z9CunFON/j2mCwdfUlFknco2Cq/w/0Hg21A6eKFZMSaDAT5xo6ZeHOzui12cs7RCvH672jyR4o9qK0rzeEReOHV+kbvXxVO7hqdApcRjne8d8BdSXC5VVhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=K12JP9xN; arc=fail smtp.client-ip=52.103.72.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz4VnvtD4qjpKWXQ9rcs6Xz2whfB8hpXcKc0Ntc/IvGDMsgkkSihhWW/C8OZzu1iK+MUIyVHbSrJEqZ/22q58idXiny8DS8o8eEzgVdiv4Q1BxFKLJ2s+Iz8hB2X2MNfTpKePkrcS8R16YaMvrg4dRD0+NtTHT39p5+i/v0zhXQNkP/wXnzbC/WzeZW+gHjavX9emjTSWKrR3gqm1XGBjYt5JZqJXNfUjEHSUDkV9upA3QVA6oMLQal3NbJBUMoIBeVWdl/ex7qa9E/o6Sl2FuPFUu54fymGpxFsGRnWz1wv+JDn1pRE66Uh96ZQ5EoB66c92oSoY8gJjYDGJnYhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzhyxJ8VPH3c/hvnEemb7RGYmEGSwcAMtWyvSkwv9J4=;
 b=oEb3K2K/ma0z1Nn21AeLBPYf8UyVm90ArgmlTuSqhZS/d4kKg0OPCBPF4hWGqE/9mQEMHIn3iplnoBRqEZ673nItYGHRscP1F7Y6KX00pwqOweCU7guyVsQBnzLcTv1OWZzoNxHkchG8+7Swm46PmIsEceSYmMqjSkcBArVS6nZIRCxegklwa7dlCCNpI1D8PWMO0C9bwUFJHHzUeBjxlvEO6XecupGKP+fiONtPahYMzvmF2q/uiVIydTegBAhgmAU6LeVzdFx1sqLtXo1RT7y8+cX4gOQkOFNyEKm0w+jpGthPY+Ns3JR0dhMI/1eVmjjiJywjuvferG+rWFr29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzhyxJ8VPH3c/hvnEemb7RGYmEGSwcAMtWyvSkwv9J4=;
 b=K12JP9xNCNamxUH5HvPbXeY2z2nnVjhmKRZjoE49Xbl8eNeuofpFSP10roVgvZkvojs7+7CAFaI3oxXrEnHuf130GzBwlgy2xy7adQIMA9GhxUihvYbWaosDMEBbRrRDVKiKStr8QxtO6BSsQFJ9lDQAPb+mCkK2uqyYYx+cPm+d9mU9Hm9NLPGN9nAJnP9ol/FIiX2a32bYvPVvD9F2ZNFee1GIKo379aVIR3hcntiqyqmeSyeQvYEKA2JwE1sOt5RvuQiMs0QwOr6Eyk3Uz/YdEV/kH34R9b4yNVLvcJjaZWliPkrcevRNtoP61sHGDpzMQQU6/qaihMUsm9pXmA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY3PPFF874E1CE0.ausprd01.prod.outlook.com (2603:10c6:18::43e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 07:33:19 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 07:33:19 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 23 Mar 2026 15:31:56 +0800
Subject: [PATCH] staging: sm750fb: fix division by zero in ps_to_hz()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881AFBFCE28CCF528B35D0CAF4BA@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNj3bTMitRiXWND8xTzFEsz87REIyWg2oKiVLAEUGl0bG0tANrHdh5
 XAAAA
X-Change-ID: 20260323-fixes-317d7d967fa2
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
 Teddy Wang <teddy.wang@siliconmotion.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=QmPr4KVyrKdy6oTeuqq2YdF8MgOwQth7pFVwOp6kmmw=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhswDb7KT7/yuPZ8yrd/zlZLweoN98yqs/pdNm7DtlfLVf
 zdNrvKv7ShlYRDjYpAVU2Q5XnDpm4XvFt0tPluSYeawMoEMYeDiFICJfH/A8Js91FxGdGrv428z
 FK7yPy3gnNYhzsVzX0bFoiNXIFR5UwvD//hNO69sM99SZ5mvybZf90a+llGxeZPjWfEyi2TTj0e
 7WAE=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260323-fixes-v1-1-0c2e00fbe232@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY3PPFF874E1CE0:EE_
X-MS-Office365-Filtering-Correlation-Id: a43e8cab-7d8b-45dc-2dc6-08de88ae7441
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|41001999006|19110799012|5072599009|22091999003|23021999003|12121999013|8060799015|15080799012|5062599005|24121999003|52005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3dXdzdOcTMxRFUwUG1YdHp0UnRjQ29FWWZseHFYak85UGllQXZNUEQyTkRz?=
 =?utf-8?B?ZmFrQTZSTGx2S3lRTkxsUERmK2Rvb0czWHhKcG15YlZWYnpKanlIUW1oMzdi?=
 =?utf-8?B?M2dxV3VkVmVvMzk1bW9KUFJRUVZmZ1drSkc1dHYrUFdXdnNGd0trMEdQaUsw?=
 =?utf-8?B?Zi9iYy9oT1krWFJkWE8yenZTMXl2aGRxLzhGYXYrcko3QkxoeWFVcExDMFgw?=
 =?utf-8?B?bENVbUY5YnJGVWZVL2wrd3F6ZEdoeGNCL1lmZ2lyWk9ocmUwd3lwa2l1K1Jl?=
 =?utf-8?B?TTlTSHNmU0g0QWo1K2FkUWd0Mld4VGdEU1NCZGcxSGMxREt1NUNpNDNlamR2?=
 =?utf-8?B?ZmlSaW1KNmZWb0FKK0dhVDQ3VmprMWRJOHV4Z1ZWQy9vOFRidE12bFdQQzlD?=
 =?utf-8?B?Ylg5ajlJcng2cUhpeDJXMzZpU2U2QTZURk5rZnpzNmZMbWtuMGd3K0RDZnN2?=
 =?utf-8?B?L1JnUjVnajAvaitWcDdzR3JZR1RnRnkyT3dYSG9QTGRvVHU4NjduVUVxNnlL?=
 =?utf-8?B?ZndHTGx0b2JnRHl6c0I3ekJITFhZVWxHVnhIdHJIU0d5VmZaNnZxSkxWU1d2?=
 =?utf-8?B?U2ZHa2wraVBQa2Nxcko3NjFKVktlNHdmS2FoZUV3SDY5RlZrbTgzZTRkSk1i?=
 =?utf-8?B?SjkrSTBSOGkrV040Wlg1NFFuazd5b3BnSVozc1JQVmp3S21zbkpsajc1ZmFI?=
 =?utf-8?B?MjJTSHhaSm9tc0JoS0htYXNQdVZKdnB1Ukd3UGhVQjVsaFJKd0VwMWZ6N09G?=
 =?utf-8?B?UUIzRzNWc1RScExuYlRPU29ZMkM5bGZjRHlmUUR6MnNiTjYwZkFPUUJIRmRG?=
 =?utf-8?B?SnBiZmx2WExtNC9jRU5JUnkrMVBNcTRIK0JtQW91Zm1JTHo5eWdaRjVEOE9Y?=
 =?utf-8?B?RHZTS0R3V1o0TDI2bmZBR2VPTjZZYnVwWjhiQ05nZlNWTTZmcGVBbFdIWmtF?=
 =?utf-8?B?L0xzMlhDc3BsVW5ZcTF3dTVVQVI3WGUvYXBMVlZPUlVjOENnUFIwaHdmc1lq?=
 =?utf-8?B?YnMvcmR3K1VCblRKcDlBWHpRMDJvUG5VWmE3MS9zK2c2eTV1NnVEYVZ3OGdQ?=
 =?utf-8?B?TytISFB4bTFVQjk2U1dEMVdpNjFMaHpWc2dadkRydHBMekNvOUF6WGdxM2pE?=
 =?utf-8?B?dFBBOVFGL0dpRXViRStJY3VPVjRQdHJTcGQybHBpVks4dVNia0ZhZ1l5TXNk?=
 =?utf-8?B?anlkaHNPcUVxOWhzeXBKeERaT0pFaGxySEVvNUpwTXVtakNTYmU3K3h6Mmow?=
 =?utf-8?B?LytudU4yNGlJdkZsN3ZxRno5aExweE1ZdU90ZlVuSEVNWGJkckNxOTNXU2FS?=
 =?utf-8?B?bTJQeElqdUJ6b2NZZHcrbWx0VEhkVTZlMFJLbmd5Z2RadWEzSmpUVG9PRitH?=
 =?utf-8?B?clFPa0d3cVI1T2Q4cDhQeVlKRFFmZjBpaVVlTWp5akIyd0wwUHBwM3BVNFdO?=
 =?utf-8?B?RmhqUHVTUGI4Uk82WWJ0RzFiY2lac3RjQk95RGxFM0tyMHYzUyszQlJ2MVh0?=
 =?utf-8?Q?NIJ54Asz7HTTXywwzoXUKzQpGu+?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3lITXh0ZVJYb1N2bDZGVnJoNXBaWEUwS29keTU5ZDhBL0FvM1FySFpLenVX?=
 =?utf-8?B?aFljR3JnWElVV0pIcmR4a1BTdHI2NE9hQlpLQ0drV2ZVZTJvZlpIL2tzVHdi?=
 =?utf-8?B?YnRFZ0xSR0ZRUnljcUo4b1BoSVV4bUpsaWpFbHprYXRrcXNZbDRWWlYyaXVa?=
 =?utf-8?B?enhQT2lLSDdTSXJrTVhmM29sS1ptZWpPaXBtZTNNQ2x1cnNpOS9Rdzhuc0Zz?=
 =?utf-8?B?Vnc1VE80aHlqaldWUmNKWm80OWFhZk5PV0pFTS9KUWRjRGJoYnllenpSRFE0?=
 =?utf-8?B?V1crQkNGbHpJWnJQTFI1WW9VQWkrWEh0d0xBNEJXTVVIVzdJQytFbHdCY2x0?=
 =?utf-8?B?Y2ZSQno2WGM1OUF6REo1aDFYT29LUm02SmdNZm44TExCZWhETkZQR3JMakd6?=
 =?utf-8?B?NmJFQmE4ajlsMlR2VUxiN2NIT1NJMG9rTnIycmozZy8rNTljblF0SVYvOWRU?=
 =?utf-8?B?WFd0N2xGUmhxUURLZllXWng0eWdBcUExd0p5WHV4TlY3dmxmTGNuaTUveC9W?=
 =?utf-8?B?dTlBY1NFNERyWXd0a2ZLc0xGeGxQZDBPLytyaGh2a2xBdXFPeTdHNlNEQkZM?=
 =?utf-8?B?eXVCM3JOMTR3ZHRqWEYyQ1BqMDhSK1lrd3MwUXROSmJPcDUrWmJGdGY5OXlW?=
 =?utf-8?B?cnJxMTFmand6TVFGUmkxczNRb2VPM0QzRkRGWWMyQ1FrMVVqTmZYQWdza0pv?=
 =?utf-8?B?WnJKcWg3U2YyMkQ1OHJ4TnFzTHdoTEpvT0lMZ0Q2Ly9PMnBMajY5a2ZpR2lm?=
 =?utf-8?B?THcyd24rY0h3MjM3U3dJTHFzKzI1eVNnMVI2cnBkWkMvL2IxYUdlNVZ6TXVz?=
 =?utf-8?B?ODFwTTJHV2pnaUk1SGdERmFJMnpJa0ltNVVhN20vbUNpc0hteUdaTXhmVkVJ?=
 =?utf-8?B?QUVCMXIwV1ozNTloUDJtVng5Z1liclQ0ekRCKyt1SzhIOHpiZTBsMi9hbVFZ?=
 =?utf-8?B?VnF0dXFTajRkT0tmTWZvTE9wODZSanhwKzJUU0VUZU1QYXpScjE5ZmJzWFJp?=
 =?utf-8?B?d0M4UlVkRnlOWVl2aVdDWDFPWGpMa0lXeHN6K1JzV25CeXNsOVhCL1p2MEZP?=
 =?utf-8?B?WXZURHhsYkcyeEMxUHlJa1pScDBxdDlkMVZ6TitaYmdJa2xnbzRKeFBQTmw4?=
 =?utf-8?B?VFQyZHJSbU9aUkdHZ3dmTGxxK3NybUJSRCtlelZIUjJxTkxXK0V6SDdjS1Vt?=
 =?utf-8?B?UUxxeEorSCsyUDJPRWlRbW5VK2wzZUZkWHEvTlplR29zdDJKbjkycE5PL0li?=
 =?utf-8?B?WW85eit1RWwrbGdKdGc4c09BQmtMT08zcDhxL1M0MlRHeXAwbmNQMUpBV2tt?=
 =?utf-8?B?cFh5M3J5aU8yNEkxZHdSTUFMa1Z5eUpYV01zVFR6aEkwK3cyby9KNUphZGt2?=
 =?utf-8?B?S3B5NU14VTZYQnFIOWYzUVVNSzgrT2pNNS96eFI5b3NleFREaGR0ZUt3aXZi?=
 =?utf-8?B?UlJkRkJBU0VubkdqS09OQVBqMGViRTZMb3NVbW1ReTgvOEI5QXoyc3lsVWo4?=
 =?utf-8?B?M2hrN2E2bkFpNko3d0ZEYlplMTFlOENyZ0VBc2t6NjNnOEtvM01oQkdkTjdH?=
 =?utf-8?B?a0NjT1lDdmRQdm4wYXRIV0tSVkhyemExaHhkRGRnTWo5cFZyRW9pM1RGZ2NW?=
 =?utf-8?B?RGViaGxLeE5XM2M4NDgwMmU3Tjl3VjhrZHhSLzRDR01uT2xvekJ0eGk5MlJk?=
 =?utf-8?B?MFg0ZGE4RFU2ZHRBdVhmVDZZdXpxbkM5RFc2clJlY2g0a1lwMjdudXJtdW5R?=
 =?utf-8?B?L2dVM2NYNllNREZnYlRtbXFIenJDM3l5dmwrMElkbUpMUFo3enkvWHlXM25z?=
 =?utf-8?B?VjNGOVdHK1NmbU5yLzFyU1N4Wk5keHk5dTZXa0dWaUlrUzZmRjhqT1Q2c1Vh?=
 =?utf-8?B?M1dUS3ZkRjQ2YmYwYm9pdVQwNUJFdFNRUU1XL3dnNzA4dHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43e8cab-7d8b-45dc-2dc6-08de88ae7441
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:33:19.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPFF874E1CE0
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,siliconmotion.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: B7C9D2EDA71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ps_to_hz() is called from hw_sm750_crtc_set_mode() without validating
that pixclock is non-zero. A zero pixclock passed via FBIOPUT_VSCREENINFO
causes a division by zero.

Fix by rejecting zero pixclock in lynxfb_ops_check_var(), consistent
with other framebuffer drivers.

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/staging/sm750fb/sm750.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 62f6e0cdff4d..18433aebb4dc 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -490,6 +490,9 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		 var->yres,
 		 var->bits_per_pixel);
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	ret = lynxfb_set_color_offsets(info);
 
 	if (ret) {

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260323-fixes-317d7d967fa2

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


