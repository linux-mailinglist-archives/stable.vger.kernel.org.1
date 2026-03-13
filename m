Return-Path: <stable+bounces-225332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGalJwAxtGmuigAAu9opvQ
	(envelope-from <stable+bounces-225332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:45:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3328644D
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 080AD301DEDC
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6123BD626;
	Fri, 13 Mar 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eRLV/98M"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418933BBA01;
	Fri, 13 Mar 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416341; cv=fail; b=Eh2vVYNp6KFRi4N/Sv0UzcQ0i0yhXahgMPkX4q299NWSlswv+URBvBztCjTVbqv68/6xeGcTp0tCvTjP3pm/yxwz1fq56aNWJo73naG4zusVSQYeP8PDc3LNI4xTSqqKfWwBHl/b2b1cTNKGOnw7LJVNI/oLr6IbI7UsKrQcKXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416341; c=relaxed/simple;
	bh=Gp02k7+QUZccxmsvhd5BPv3ZET1OK0na+SOl4uy7G9Q=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=I90zXyU06RMZcuh3skawgHJrfOwdjRs2HxG+3cR5MgaXx/Tphnn3sSr+zFPUdxbwKksPMLDIoExkU1Zf19VMzfrie7o6k9Puh47H0saErvil6n12ODdu96O39j0N8WRm9OpaoPxdBq6AR/WJ9p1li++2B/hq0LE6xkE9spLnJ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eRLV/98M; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFDYYNt68yRFg5rgQy0svl2XUj5rB3i1LnpksUxoeR0M7gluJ1eWyE1tLN4noGuAn4TGrUUXDgUdU3D9yWonB/9xSXRO8d060V1QsrJkojRbHEOcI3TtHZJXCl8XuZ2Tlf5FYZJFMJwUkW78iG+vW1Ws431yhfkqV5HqxsOz7TorhTBTbnd8+5jZgFLnwnr5gzVxTS3VP/+H4sUfr2w/PADiKUuJBKLNxm/VM2eGo2h7IsK5yv4IwPgDvzjvrfwNObL9uMBLGDKEQx/kIirixKu1yvPxW8CVKE7l6s/PyuRgPrL1vxczuVX1P9Wcw4OE7VvjYLuRFLaASkIjSD+ZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV7bOZgHHplHKR96LDg8vPe8/s9gJns6VApysFM5eBs=;
 b=Bg5iJjRhvPVjuxPZ9kDui5cxl8acLW7wz3aRLjhqkANHu7KMprrukpVxYtUGdkYxH0koAXkd3dWFmQP0K1hpJzx7vf2fXADtvD0bSilvgDt2Jy4nb8GHbKM9qhrnprzniB4T7xwl6Rzc3vi0SiOAQ3/zjLYbxSSf+OQQabqm8C4E8hGpq8ToueKAkSi6oqjdlKkxvJMIXByJsR7skHZfBFECtmz0lmCUepMTKgXl14LlaxFHNlwmsI+k/iilvxpfyY9+ZuNYFnFfMudNZRVXGmc2zBtYKx0flgm0lPCiXtmGoGgrG1STka7xM/jokbuMQFMfEK00W3wT2X9KbI30IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV7bOZgHHplHKR96LDg8vPe8/s9gJns6VApysFM5eBs=;
 b=eRLV/98Mte/QIw+CA6glyzQXd9PKA/EBUZ1YPFtb0oUO0PkyeAo4HQSe8snjf0fUnBGl2LxWnkVnsxzA8ASHCADleNC24kMcQu5/dewaX9F56iszmNAv5wkzmVcu2eL8nCoDdk2K9zPDCdV945hpEdk5wWvY0U1tsJIwUYrJ43vOb31wZbx9lsPr/FlC16K746qDFxQqhAQmaAknl87NzlM1b6+GQKDQpLA4LoYeqQjB0LXd5PVDDLEBm3Skn8fXdYv9xnTSnzdFoCQkiQIR88eb4G5ZXLl+I0C8WZtLvGwjzHDKoEtvSKxV/kkQPvATU/lWLtf5DCQF9pXMj2ajMg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB10808.ausprd01.prod.outlook.com (2603:10c6:10:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 13 Mar
 2026 15:38:49 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 15:38:49 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Fri, 13 Mar 2026 23:37:40 +0800
Subject: [PATCH net v2] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78817D5AED8035071888D7EDAF45A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NzQ7CIBCEX6XZs5gu+NN48j1MDxQWS9SuASSah
 ncXOXqazMyXmRUiBU8RTt0KgbKPnpdqcNOBmfVyJeFt9SB7eegVKuH8m6IgdDuLWrsJCSr7DNS
 Kil5gofTLsoSxyuxj4vBpDxkb8DeWUaBQA9o9Ho2kaTjzK92Zb1vDDxhLKV8jk4m0pwAAAA==
X-Change-ID: 20260313-fixes-e1f4d1aafb1e
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shruti Parab <shruti.parab@broadcom.com>, 
 Hongguang Gao <hongguang.gao@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=Gp02k7+QUZccxmsvhd5BPv3ZET1OK0na+SOl4uy7G9Q=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhswt+k1OMzVvmyfx+vo8Ezp6LrPjIMe3m13TjQ2/vtMqa
 Htp4pvZUcrCIMbFICumyHK84NI3C98tult8tiTDzGFlAhnCwMUpABNxjWNkuN29aNMLngdtPRmB
 W/jX3w4/GREza7fOos6zVmwsP98qz2Vk2OxdsqUg71vGm4AoluXSTzY4b00x/zn5ycv97h8mqEW
 xMAIA
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TP0P295CA0026.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::7)
 To SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260313-fixes-v1-1-5a8b0767e5b5@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB10808:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b2ec38-96e9-4d61-9d46-08de81169ecd
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYCy6WZBtXjyg4e4+qWcxdNA/A9YEMUq5eVWTzdu+2i4Rsh9e30Ukc3yXZ9sy2NI8RD4ciW6XYyGQ70f3Kq9XXa/w2r2u2v5YvvzXXQ5/quV2itXXyRENPsLoo1Tb0kAb13MZGiHu+SU1gTSAEBjoa8gBN7g7SuoyFSTZqbqiKRNQGh3zwrkfqtBq6X5MsGXDq3ZTRBdyAFdfGW/wVvI58HLlJCccoCh7VgT3CoPpA/d6s4HQ0ugRbvyBnkAug811sTNbAfm3bJqYFmPppgCXAaYjooCcPuPbtIYIQsHnJfi1lemJhLUfpBDIaw1gIGcDyP+NF0QmkEqEmHcyCbC+SUVFZopzUj60l+QaVq3aYNzTRO1ZYLKR5S8jbsnCypjmclXVUoFY1b/A3iBN4WZBqVSxljYWMrJAKhScamQswolcf+8MT0M8Svz+bVk5wyyFwWGkZH2qD4gzeA4Kfo4bLJTGmKf4j1WXv34/YOIzPtBv/+4FYb6fRnIPbEOtiuCY0yT9+zf/zMij6E9CjFwJzOZjaUqtSTrDoJnglOqJ0NRDkND/hQmcHEAwlIxBlIbWuyLDkDFDuRuiojNMXANNIsTbiZRoAXaX+E/09REERYE18pBTcl1DiR3i6NRIa9byKyngB+l5iyGT2nueVEqaiFFwIE/85s9MdxBlyiT7GNQspNx+5I4Z0m3W0ATzJ0qlLThBBN0AkLhN9+HOReYEL1YPowBPQLy0NLw0PI269riWkbrfunLopGUR6LeXQnITMb34qVFZ2ZUzcgUPFitcic4Y7t9nvkdPxcW8efcWFdij0EMaUqSsHToGmjlCYRpVjXuXH3lyKux/Q==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|12121999013|5072599009|5062599005|8060799015|22091999003|461199028|13031999003|51005399006|19110799012|23021999003|15080799012|24121999003|10035399007|4302099013|3412199025|440099028|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9DWWJYbENjdm4wL24yTUFqSUJlWGZCUHN6MzZ2VUorazVFT3dMNmNWeEZx?=
 =?utf-8?B?a3Z0aDhvZjF0bWRJRlhpYXdKamZuWjRUQXdvSkdUUFR5LzdQelhTUmRFUnhG?=
 =?utf-8?B?NEZhdjZYVHRhQUFodFhpTExYbWwwYlVYR2g2cVpFL2d1eXU0Mkg4WmZlSEgr?=
 =?utf-8?B?SHVpL0dzYXpWMndDUUZmMWlIdTJxNDkvdDZDOUpaYnNDdWpjY0dYLy80dnd3?=
 =?utf-8?B?a1lhTTMwUWJYMHdYU2tCajcyVVVpS1FKR0owVUNOTnNBeEc2dEpJaU9ra3VX?=
 =?utf-8?B?ejloOW95TXFFVjlURWlCNThLM242QVlvL3ZWK1NDQm5VRFlYUjhHSlphMW1N?=
 =?utf-8?B?bjNHU0RDTFZSejVldWJCT2UzWUxhZ1FwbjNVUzc1QnNoQnBSdTk3L1daUkxx?=
 =?utf-8?B?VFVZampvVnhITjM1eFJoMHB0NzNKcDdYM09FalY1c2x0UkpSeU5ZRVJRdnpY?=
 =?utf-8?B?SHBEOGh1eFFzd25lbVF6akVLTHFMVFhlcHcxc3lBYnNkVkdTaGJzc3dsY1lq?=
 =?utf-8?B?NWF2am1LampJQW9GM0Q0aWZVU0Z1OFlBYzZqVk1BWnRLTWxMZFFXOUNLTnRZ?=
 =?utf-8?B?TnpNa1pXWWZsK0xwNmwwYkZtdVBHeFh6MkJoVS9RbG04WVpoSjl4eTl2N3E0?=
 =?utf-8?B?S3ZZQnl4WEhHUXl2NDZkM0tubXVDYVpMQUxMR093NTZtNkZ5TEt6SFhZbjBG?=
 =?utf-8?B?RmExT1V0M0VHRFVUZnFGaERRa0FLbVE5UnAzL3FhY3piVndSNFVEcjlMWlUr?=
 =?utf-8?B?Q2ZrZkhHWEVveU5GTHZVTjB6TnlKRlNCWHNsL0thdzlyQlhUVGJjUjJKeTZI?=
 =?utf-8?B?eVp3bDhtM1kxWnhOL25hRktrR09zY1puMWtKMlI2N0xVa3lleHo2WHhZdy83?=
 =?utf-8?B?QktLV1RCYlljZzNlNUpPaWk2S1pZVXo4Smw4RE9NdXJVSEFZVk9xUDliZUI1?=
 =?utf-8?B?SjU0SmJTM3d4OWEzZHZnOGkrVnVHNmVuMzFOS1J3SEVvVDlSYjAxVUJTZkdR?=
 =?utf-8?B?eHFBN1JkZ3l4WEE0eDRTbVh3Sk1acDJsZGxEVmFnYjRPSVJhczIrSUNqbWJO?=
 =?utf-8?B?TUM2b0kvaDBlbkNyT2NGcHVIbHZaRHlETktGbktmb3UwZEhrOS92RVBDV2h1?=
 =?utf-8?B?Vm1IWE5JaVBpVkdqOVZlVFRnNzFVdFN6LzkrZHFXZ1F2NGY0ejVySkJWaGNh?=
 =?utf-8?B?SVkzcTV0ZzlDNEMvaGdRM2hkQSt0WXF6NTRES2d3NnpUZGFldWZoaEFsM1NE?=
 =?utf-8?B?SW01SXh3dms2a0dKN1JNMzgrY285UTBTYVBMU3VMZllnWkVXVTdPZ0tvaFFh?=
 =?utf-8?B?aHJiaTAzcCtUejVIZXN2M3VmNVJYWFFSeVhOUmYyYU1IRGQwbThkalh5NjJC?=
 =?utf-8?B?ZGlEdlA2ZzViUXR2c1BKaGtTUm1kLzlDRENZdzVCN3VrcXdUR1ZsbVg0S0pv?=
 =?utf-8?B?UE1jc0o2blhOWHVLMWxEUnRYUkkvcHZrTDNienYrVUNtOXhla28yYkczdDlI?=
 =?utf-8?B?T1c0Zk1DSFE0VWUyUk1YR3ArNE1GQTRJQURza3lld0phL3FGcE5oMjRheWZV?=
 =?utf-8?B?QW12dmFxK015eVBqQzdoTHNydXA4S3FSWmY5TXV3cjhHZG1WN0dTT2N4TldR?=
 =?utf-8?B?N2tRcTFEWEw5QU1wWm15ckgrenlZM09TOTJucTQ4bWUwVnEyL3JRQmhxcnRr?=
 =?utf-8?Q?7udvDL1kHMbDwjb78P/w?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEF5ZGwrY3czSnJXSEFJM000TE5xK1hHRExkRFFjRGtlVWtrdWhxL3pkNEpC?=
 =?utf-8?B?RzlBZGVpNjJRd2ZlTGtOUTBHcnZHTzVlcmZmQU1RMndMd0hiYnBaUnUxRXMr?=
 =?utf-8?B?VmRMckdrcWNSU0gzN3RqeUNLMWorbFA1STdPMldrT0o1WStjVTk2Ym4ybzlV?=
 =?utf-8?B?RFZheGdnUWtJWkxyMHNJaHZKNFNnWHB6bWVCVkxIZjFVc0VxbXljUXNSYXVz?=
 =?utf-8?B?cWRzWXVXbGNobUl6amtMZFNJYWdYOFdsaHJuMEpuL2IwL1Bqdys1QlB0bjlQ?=
 =?utf-8?B?cUVjcDNwYjJ5VGxvdlRGaGpISGtPTVBqYmxqUVlqUFp3dE5SK0FqWnQyV1c4?=
 =?utf-8?B?R3JLV2RHQ3BFNWRxKzJNVThLTDV6RjRvUkdnQ2R0ZXUzY1UwZlhndUxFN2FN?=
 =?utf-8?B?MzhzUjhmSnhRRHdWYlEzd1pjSXJrdWFxLzdZWVMweExsMzFJcUl4Mm8wTnFm?=
 =?utf-8?B?c3VSdkwzWGpUbi9qUjllV29UVmphVm1lS1MrV2dPNFZHRTA0YmdNZUFDaENU?=
 =?utf-8?B?UXRrY2syZ3c1TTFFaWpXb1g3N3ZoYTk2K1JKYytSdUx4bmd5cWt4MG5BV0VK?=
 =?utf-8?B?cVNnZURGdktHL2JsOTJPaWFNakZxRndyUVh5RldCZjlnN2VWL3pyU3lodlRB?=
 =?utf-8?B?MnQrSUErNGpuLzVLa3NHRmNweEdTNzNkR2loWVdBMHRxT0JlYnRzTGJPTzNZ?=
 =?utf-8?B?MVAxVmpjQ0ZhRFBQcDA0YUszVU5TdXQ5MERpdzBaQWo2emh3d1BibmlRTUx3?=
 =?utf-8?B?cW9EbzR2VEpsTTVoMkttWkt0R1FwUSs1YTJWVlgvVy9xdStZTWZJUEh5amtT?=
 =?utf-8?B?MUVPdGEzK1U5VlphU1lFS1FnNkwxdkFXRTM1NDgzWjY3T0duNVVrS0REYnZC?=
 =?utf-8?B?UTFKUG9xSmNHMGVDaGR2aWszdFdSOExJbnovZUNFajR2VW9qSVpGOHZBaVBq?=
 =?utf-8?B?VmNyR3ZqbFpVZXI2UVhhakNNU3VtYTBZelJVTC9ibGFlYW8wRm1EUUo5TmZG?=
 =?utf-8?B?UTNzN0Q4cGV4V29MdXBtWTYvNlcvQTRwdFphdnQ5cU1JR2I2SHB3eVpTbVhZ?=
 =?utf-8?B?eFA3dTNtSHcwZ1M0cmthdEVlVDdsNXVUUUxEcU9INUs2c1JaRUNjTnhxTHZP?=
 =?utf-8?B?Yjk4NmkvMU1BUU14UjllbVdXWld0WVdUUDZ3bjZnRGNaMFNOMWlORnpEaC9M?=
 =?utf-8?B?aWFMR3J2enYwWGxYM3hmUHBwNW9heUpRSGxzZFV6RWhRQ3hxbVFCZVBEZ2hD?=
 =?utf-8?B?SUl2NTlpbm1XZ3ZESVI5NjJLcEsvdUtxVnF4VmJpSVdSV2duUVhMNFUvQUFS?=
 =?utf-8?B?WG5aa1VIRHZRMHhRdldPOHd5TlV2TkxWQ2VLZHRrZmk3U3Z4bnNFblZQZmoy?=
 =?utf-8?B?MnM1SDR0NkhxVFF0ZEJnVTkydEZOY01qU1JHRXhablhYVk1iUW93bzFRUGxZ?=
 =?utf-8?B?UEUySUxwQjIyd2tCQzFoeUx1Y2NMdld4Zkd2NUoxUk8za0Yrb1NCMVZaZkVX?=
 =?utf-8?B?ek5xODFuU2ZsYUcwTkwxT0xYcTVFekhreG1IVmFMaHE1Z1FxbUNZdEFONXUx?=
 =?utf-8?B?WGVkWFpoR2xzdndVMEtMc0JLQlRLMzM3V1FVK1R4enEyVmlUUTExVXJGQnhh?=
 =?utf-8?B?UmVTYXowdlM5eDg3eGZPSHhGZnIzZSsrajdqOENJYkdOZ3FlajRzc2tSNTJ1?=
 =?utf-8?B?TjdzT2ptdDViSW91RDIvQ1RySVhTMUJIM0lOVDdra2JiWG16RC9JeGlwTi9w?=
 =?utf-8?B?UGpMU0VVWHdlWVVwRkZPLzRSeFBJOHN0KysyNldHMTBjSXZxaEFxVkRMTmVM?=
 =?utf-8?B?dEpOVC9wMnB3dnVYSHF3SGk1RHJBYWxNUElMbTFscDZ3Skh1S3hzRlhzZXhG?=
 =?utf-8?B?Y29YWDNRQmNGQmZNZG5CRVNsdmQwcE1NN2FVaHRzb1RaTGc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b2ec38-96e9-4d61-9d46-08de81169ecd
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 15:38:49.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB10808
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225332-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1DA3328644D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
bnxt_async_event_process() uses a firmware-supplied 'type' field
directly as an index into bp->bs_trace[] without bounds validation.

The 'type' field is a 16-bit value extracted from DMA-mapped completion
ring memory that the NIC writes directly to host RAM. A malicious or
compromised NIC can supply any value from 0 to 65535, causing an
out-of-bounds access into kernel heap memory.
The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_byte
and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
kernel memory corruption or a crash.

Fix by adding a bounds check and updating BNXT_TRACE_MAX from 11 to 13
to cover all currently defined firmware trace types (0x0 through 0xc).

Fixes: 84fcd9449fd7 ("bnxt_en: Manage the FW trace context memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Use ARRAY_SIZE(bp->bs_trace) instead of BNXT_TRACE_MAX for the
  bounds check, as suggested by Andrew Lunn.
- Link to v1: https://lore.kernel.org/all/SYBPR01MB7881338BC956C39A9848EE86AF45A@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c426a41c3663..0751c0e4581a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2929,6 +2929,8 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
 		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
 
+		if (type >= ARRAY_SIZE(bp->bs_trace))
+			goto async_event_process_exit;
 		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);
 		goto async_event_process_exit;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9a41b9e0423c..597932cdea09 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2146,7 +2146,7 @@ enum board_idx {
 };
 
 #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
-#define BNXT_TRACE_MAX 11
+#define BNXT_TRACE_MAX 13
 
 struct bnxt_bs_trace_info {
 	u8 *magic_byte;

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-fixes-e1f4d1aafb1e

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


