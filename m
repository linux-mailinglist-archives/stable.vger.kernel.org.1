Return-Path: <stable+bounces-23250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94D85EBC3
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F48A284734
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BB12883A;
	Wed, 21 Feb 2024 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="npHZg+Qn"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4321292D7
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554105; cv=fail; b=PDeM4qZn+/v+GmGuXGl/qukpLeaz4iXFwHPD2K/BqA6ozUhhi/2lF0zTmmK8WWo54uPjrCGQHoAyRp3BGdR7F2CucP1Qdc7KeNsCrh7tXnt6V7wgbgRTo2SaKkH57HwJ6j4pfeW/KgCh/ulmydDOuy87tLpf+EEgXEh81GQ1G6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554105; c=relaxed/simple;
	bh=FRSeo6eq23+Zl/lmK2JHWls2VQAcTw38ebgaFWEk3nA=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=LiwjySbSG9V2J0b96PpLVfqNen21erETGJiltZd1hSMZGDjSKmzvQzoIanXzXSwuXZt9SfXmlfuTNoSnn+j+ABuztZJ4T8nrN8tB+CK1mlzYggq2p8QRStxqSfd0Ury+OGtNm7XNZZHwalbAdLonK5ykgz94i3KqjPr0Kaf/sYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=npHZg+Qn; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8OivjEUEqT7hEU4QskzwCLnRwScr1feVUjbYcnPwDWqHXGNCZhH77Rj3Z9iO833ndmhqk/WcjP4cuJiZRrlpW2RKgCnYiYgSgj4B/b1Asczx5r0l1wIakM1smjYBZE0oHUIPqJQgoEW65JGCYuZIcGroDUTJMi5URXD0z1WwvA0QwIRwUPuqfHP2Gz3Q2zby0kzwDX1X2OCfOOSI8UCYURmEgAiEmbjXMoI3eJ0fT0GSkYSN/zC1w/4ZbDweObEYX1zPR7e2hx21K/inVvPNQHJUduzCgdd2TJgZbQLmAQXx16aKK5zlRXA9BX/wPU0cWoHrXjDNStBJnYTvFGToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/dsZSzqdeOrWLALqLD6MsVcvGH9aDFkk49OCZ8ibe4=;
 b=gG3BRN8fdRfikTPjmCY4JfACu4iB0ZUxCE9kLDw709cgTYKFKlkzi59dkoxtqygb9tilOkjsWDnW41ObVEHDrRftokxUtlMMAmxYfmDpmnTr45yUjvPfew7H5oaS/yiP/gMittTWeS1m9onOc9i40eb35bUa/dkCX5hWn4I9zsqLWGz+60qI+kSeVY4yafJHbpkZDI835H6BaQatH0vtVIWipOxAJnmc5TL6mIB69zMzVWV9VopiyqPcdShSxJTkLNfVE2XzaccTdHU5D7jL+hWD5x951Ftp4rwFLB1Yvi2i9m8P14ghyk0vO1NN54bYQFOUv0f9Daz4Lr2jSkag9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/dsZSzqdeOrWLALqLD6MsVcvGH9aDFkk49OCZ8ibe4=;
 b=npHZg+QnAhstU/aUxcWhJko3Wt6UJGJduW/vHqwbpeklpEWAb5yeZUOv1FKZimFgQ6TVHXmniaDjeNRj3I53dwdwcudrDNTbTQ96Vjyjvif/JUgyZfjZDjGy0IfU10XssK9JOx3XIvE4MkAhtOCst0Pt53DkXBu/eUUrZbRq+2JTmXo9DdrAaK4CknyQR4UlBHvlKX1Q+tI94Uq39R1MjPXcma9zYAKGc7xoBBBIVnTtc0fppx66ZGGgFn4hHFjPqRtLjNPD9mWsin4EU3ymzjpenyJUyIJaVNFhCSghFZ8bWiWAPaSD/QYilXlw8f9OeF6dXRiirAeKo7syJZ71ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 22:21:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 22:21:25 +0000
Message-ID: <3b0b6bb9-f346-46dd-8ce6-fdf5f916ddf6@siemens.com>
Date: Wed, 21 Feb 2024 23:21:24 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6.1.y] riscv/efistub: Ensure GP-relative addressing is not
 used
Content-Language: en-US
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 76615d4a-9c6f-4a5e-5719-08dc332b70cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ziDkC2RvyM1njI6SCa2CcxE8mu2Lm+yTKGO0SSBthiFYnsXENk/qTRA8/XJWPRRhDbfHOEi4uhDJmz83NhLdiZkilmv+fF1B+GdWVkBBESrtYbM2vsx8/s8fXsj07c+LD4Gc1QfYc2JOylH7YFyS2+OWIPh05SaFSaF0UWz457N1uh3n7owmqNbQJS1Ar5HAt/2/0FQh0Ik21MXlKstS/jQBcoVBF8fPIzclW2k32wIFxNciXeNoazmZpLRVsBokHeHcxSAcLf7ydI6xoh4vk3FSbjKDk4oI3NOL8WEDXMOTWfNjmXlo3xCx4l6HMNjENGk4rD7tXbiBT3zR+cseK8CdtuJIu4ivlTZBC3Z8hw4qcpDRXP74oeHhUtM3hV21gzxcVdwzilUOsyaiSE/0i4xCbL7luv+/1T721QC47jeD18TN9mupFGWJIOkZXj5IQuokt+Z/x3F4B1znDHmsZ/WIHRB0qjFn/fGVOFKwPFmCQZw4WL4Ii7dbVQNddpr9xDiHB8gzr5zIh+2uBTr/p24WM0WBOtuyln6vvI3uKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0hDWXpxWC9JdXptaTVSWFQvd2wrVktNZlZ4TmRFcGlXd01uT0w1bFRGRnBM?=
 =?utf-8?B?Z1Y3OWQxaWNld1U5ZlRIRDNXRElveXY3Mnd2NWJnVGY1L1pUeUkxQ2RVcUgz?=
 =?utf-8?B?WDR6Tlg5V2V1SXRGT3lTOTRubkV0b0FoYURudC9sT1VRU1R0Z3htWUpLYnNy?=
 =?utf-8?B?aWppVkFXbUFqRFdTQ21ibTl1UjB3SHlPdlUyVTZrUFRManBtQ3FNdlVIcHhY?=
 =?utf-8?B?N3hOY3lWazBEYWdHY1A4OGZadlNVNVhUWmp4U0JaU1JIcUhqakIwRHo0aVpR?=
 =?utf-8?B?T2ZlbE9jSjFTSFVjUVZjN2J5azUwUTl4RDZtSXBSNFpaUHE3Wno2bHJwWWd0?=
 =?utf-8?B?Q2tBY1FRT1RsZEZJamxORDJ2aG1pWk0rOWRaSkE3OXhXZGhZTm1RYlE0c0Zn?=
 =?utf-8?B?VWF1cUF3UHhNd2g4ZkhKby9JaGZ0UGcxNng4dEtUbk1yM0RMMzNWQndyblh3?=
 =?utf-8?B?bnk2RnRhdU5CdFg1SytuV3pZNkpoODZnTzA4ZGFOc0xyMkYxY01EWUpUbW16?=
 =?utf-8?B?NzBZL3lEclNrcThwTlc3K2RuVXZYUlRrMnE0cjVUdDlvQzhvN2hFZ0JDTzFo?=
 =?utf-8?B?amdNTUZ2QmRodkpBdGVEaFdMcnVSN1lQY2VMbTZya3NSb3p5YmJvUGIwU2ky?=
 =?utf-8?B?dWlPaHNtN3BmUzlUejBpZUFBUDBrUXdha2RpMExuZytNcU1jZ3VLYTZtdVI0?=
 =?utf-8?B?SFVBVWVCSkh0SmtodVFrN1F4eHNaeFRrbW8xQXF4Yit1OWJBQmhXcU02aEZO?=
 =?utf-8?B?c1kwaDhvVWRDMEhibll2Yi81VzEzTGs5aUk3VnhVUWZuUDY3NnZNS1VFWm5E?=
 =?utf-8?B?TXdxSEF6aGFDMEFEZWpRMmNCUUdFTlhES2VpVDB2L3VxSVFYVWJOa1Ziajlm?=
 =?utf-8?B?RVZIaHFxL1k0U0MyMll1b1lHTTQ0NnpMNXQyQzczRzJKeURSaCtVK0xKMSsw?=
 =?utf-8?B?TWVEZTVPL2VGM1NpT2E4bjNrN05ObEx5UGNTVyt4OE11aEFqYkp2Tmd0a2gr?=
 =?utf-8?B?bDh0aWY2dUxqOHJnWVNzZE1hMytHM1Jud0swaENQTTkydkRscTFDVFl6Tncy?=
 =?utf-8?B?cmh6eDNDcGJXUnhCa3M1Zkk5OHdMaDdvNzZ5VzFEY1pjaUJMenY4SStzMVh1?=
 =?utf-8?B?bTZZRGZKQ1NYQ1hMZkpCSlhYWGg3TmRhbndGTG8vYTZNZ1NVLzNHSjZwMzdh?=
 =?utf-8?B?eC9JbW8vVzFPNDFtL01MdDNLdWU3amkxSUVCVUxBL2JuWWtvV2p3c0JOSmZv?=
 =?utf-8?B?TDVyU1hOQi9uRXNweFM1eFhBYmZKNytEeVZiSFpkbGNxZFU4bmVyUGRrTTg5?=
 =?utf-8?B?bFJhazFWdUFwNTNJbDNtWno5a3RQS3FBRmFvbjB6VGRwUnZ1dVhyUkhlNGxL?=
 =?utf-8?B?ZDU5UE1YUGVyTGtEeGpKeWhRdGhuanNSOWdsSkVXa3YvV3lQbnF4N0VyWS9T?=
 =?utf-8?B?UDBVWnpZNVY5NnlHc09Qa0FoYVF5Mk5IYlRjbXZBRnpMakZpaWJ5aUtrUExY?=
 =?utf-8?B?RHJ3VXgwWkY1TDQ1RTBicmg0T3FRTkZtZ2x5VWdHY1hudTNBbXRJamR0N3Az?=
 =?utf-8?B?Qjl5cm1RUUNqVkEyNFlTUzFka01zQWhZcnBod0I0RStvUUY0Yi9DMS9LdXNN?=
 =?utf-8?B?M1I2VGxGd0FDVEFkbEFwN0lxMHp1SnJEOHdGVFdPSi9VWlJQV01OcTJZRTFs?=
 =?utf-8?B?dy9qMW1KS1JzSWZMUjRKRFVUNlA2SjNVcFBHakRadHFLMENYaDdlQzNwMFdz?=
 =?utf-8?B?R0sxSzV0NHpBSGxESFJEc2VlSEh6bDZCSTM5MlhKdXFiQ05HWXI0dERBelZV?=
 =?utf-8?B?TGdtNnlFd21IclMrUDQrcCtpczlBcHUvTVQ5Q3N6clFyNkhJQTRDYXFMalZR?=
 =?utf-8?B?OEE4YjFWWlU3UVNmOE1OOXcyM2VWamNycXVVSk9kRERPOGVQdEljaFU4Zmxm?=
 =?utf-8?B?RUJZKytuUWEraWhTeHBPRG1LdlFZVm0rZi83cHZHdHNWL1psNFhNUHA1SVBS?=
 =?utf-8?B?QlZua2NwNkpCSTYvcmJpY2NtK1QyVG1yd1JmdlhENlVQOEhBUHVGeTZSV1li?=
 =?utf-8?B?Qno2L3JhbzBoWWxLR0Y2VVVzWVA3L2c2Z0s3UUpMN05VZDFWLzBmSjlwcVV0?=
 =?utf-8?B?cXpoalA1ckRRVk1PSjNSbERUVmpCZFhmYnlWK1MrL28rMWhIcXloV054eE11?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76615d4a-9c6f-4a5e-5719-08dc332b70cd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 22:21:24.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZQSLJKwxq3a1N5HkUa2ip56O6Flsk/7g4IfuvE40ScoMNMJMCzi0ZLLw/zb3zrCvZCBuqUmSLbxn4kwPM+65w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5268

From: Jan Kiszka <jan.kiszka@siemens.com>

commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5 upstream.

The cflags for the RISC-V efistub were missing -mno-relax, thus were
under the risk that the compiler could use GP-relative addressing. That
happened for _edata with binutils-2.41 and kernel 6.1, causing the
relocation to fail due to an invalid kernel_size in handle_kernel_image.
It was not yet observed with newer versions, but that may just be luck.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ef5045a53ce0..b6e1dcb98a64 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpic
+				   -fpic -mno-relax
 cflags-$(CONFIG_LOONGARCH)	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpie
 
-- 
2.35.3

