Return-Path: <stable+bounces-111188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C405A22130
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBD31884497
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D621143722;
	Wed, 29 Jan 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="BLjESpUc"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E928EB;
	Wed, 29 Jan 2025 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166741; cv=fail; b=gYfAMTodgni0YjG+/bRS5p7QCnhMC8iSJ53bSjxJ72pWQHsnTw41uS99KWCW90KVQ9flRafhz0wHXcZS419YVxEyGFmZq3+OIlZa7+hjnLGPSKNbMCbrXgnUsr2lor2W473+XJGXTXQO8pPKxYfQ56t7T8kDB+U7t+K1Pfdmjmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166741; c=relaxed/simple;
	bh=flsBVqhWP+MJgRHK10mULlYiqJqDpEgr43wztSI6jxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fw+/snfce3rUWieAwDLY1p5onVZPEch9KGWIfNjHaHQcbTbt+fKbgkAiZtHji7QTwcAf2EOB9p9jdfX4xwj5KGPNep+jKWy5+y1BMZ734BeTIDnYHkqr0xePbscqks6bGpOwPsZDyfvsEnNjZQQ9DHqEp7OtK4EbtKDnIcuyrXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=BLjESpUc; arc=fail smtp.client-ip=40.107.220.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNk/Tv17m1QMTXeFRPHfRBlHZUap3zBjzcJoK9rh6qhyyyM/iaxzdj1IlfkThn5bBjBV/iEEqhBlL1sbXnpbp1UhW3aFtCvpLwsBuEJ3fD7Kk6YfzbI1Ugts0vCwBft1NVQB6aYi09iHzI2UUjh3gp8H+g/K10wWM/hRKxvPWvSP0B5m1NjGmsVSGrvatUezEAwnzkhpM3Ezb08atgI8IyEquW1dfvAybMuokYR5+9JEEOcPs1adOkdu/nE8VxhYpINgxr7rYbPfIDYyKzdW2mnsyAZ1P4Bnr2djLlnMYfStIolUoF0v4Lx8QiRaywUY+N7EhvpQ47zv/Ye67p79qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh8CjVML/7FVRgdAG6230pBCFyu5tLEANDDUq+yle2o=;
 b=ClHbue20mo6ROhU0zgEKTXSaom2tCBG9WCclYT/QRd/jc++yb2Mc8AXzhJHOZpTTFODapu/Bg1Lwgrs7xfbRGbPEKEaGzPbXl/Ts86e51wDWK89xsMoYf4id/xTdgsW7LfqtHnTGh8PbL4tibqWEt2z3UDuCmFCCNknpuqQ7nXFa0wS3D2xKmh4SnmBZmNbtfPTyqFmOnLjNteMSUFSh6VXufZRUr9sTfLw5dvYgN7ho/uwjg8HmylbZjIgJWTjin8axO6tQ371Vx9QPDqvkr3qhHC+QhyZIOQbPypeHCWUb5/6Vd7wPHr9xmkvXCSA7xiLFCjg1hd7lUbEor8GSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh8CjVML/7FVRgdAG6230pBCFyu5tLEANDDUq+yle2o=;
 b=BLjESpUcj5ZXfmealjuCwjrEFFLr9IHiECmoZVYSTPmVZP3Zo30GB3V4yLA6pkdM8lgBCgcnQxHdBWPZW4ltRxvK0rajlxUBa1JWqdc+SAStYQT3kA/4xijNjmJV1dHkb3nEZXx+KTATvGl1Sd2KY34wkO95DCpKzErIMAN+ZEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by CH3PR08MB9346.namprd08.prod.outlook.com (2603:10b6:610:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 16:05:35 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 16:05:35 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-usb@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Abdul Rahim <abdul.rahim@myyahoo.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Felipe Balbi <balbi@ti.com>,
	Daniel Mack <zonque@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
Date: Wed, 29 Jan 2025 16:05:19 +0000
Message-ID: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|CH3PR08MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 860fd170-5a50-41f6-ebe1-08dd407ec3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YVh8VMSeaSsXfM3522ep2KNfN4C5/c+UoNkFmlPb5ybzTCDvbFxAa5KpX4dk?=
 =?us-ascii?Q?SeTNlO9SBV8fHlzz2eAKciNDnMK4SbrBdZn1n8+jnOf0raFBtxpR5XYORG4L?=
 =?us-ascii?Q?Wj6D/6dbOhc0aNKGfFp6fvGo6mL+8NomkAl6goR9+3y8A8QgVTYd+a1b8xh4?=
 =?us-ascii?Q?hKmOgXTFZ4jMT/SpekTYFLD3lhIgmuQu3ic+6Rsvvy7fm9nGmu6GViRKVjJw?=
 =?us-ascii?Q?T7sFatzq3yVWXReKQDz4YvzEH2L4fI/ZPaCgjmNBFInCupFpUJwEXtq2V57a?=
 =?us-ascii?Q?GWDScm071Xx36+hTIdGtTnOTA/nEF45Ep5dNu8BaEBN8bARBWqiCx7+EcFOi?=
 =?us-ascii?Q?4eaWxad1wZFx79uVbIlpUqYMABkudjKIIW8QBFhHdlAMxLn8So9O89GSMCqz?=
 =?us-ascii?Q?0s6z3zA71f+XweKGqEmDkbGhXknacPjliZaW9IsOtIQlfbwBOFMt0a2yNRsH?=
 =?us-ascii?Q?mDAatFa55bHD5hAIc9jfxVXwiaElsyop6EFOcEYZD2lw2GjZPpuCohsBummI?=
 =?us-ascii?Q?V6KWZCPojZS0HwsCtIo2ooYGgTm14A+1S+CwpaMia6MRr4EVoI0/axVMxpnG?=
 =?us-ascii?Q?p19c4L8zYxHOKcxRp55t6NnHZBy1RGXVBL+2Zft+zR2mUJQJxzJmqWjsixPV?=
 =?us-ascii?Q?s2IwuU1wCPrNs4a/5O7lwr9u8KefBaBVltJZe6zvy6jEnORcwe3jO2Tc9s6i?=
 =?us-ascii?Q?m8lnl13juZmpzi7OYnWSMKCUlrg1z8y2KGiHHuNpgiAk9AQq16gAVDS3Gpma?=
 =?us-ascii?Q?TuU84fgOf7SuexpqUmBqwxwMLM55CeHVFj2fnGHaO9AnC2fdo7JyCStzFTHg?=
 =?us-ascii?Q?M7bO1VZSnU4C/iMGk2jFVt8rWSK1e/Dvol1h3V3BPRvMsTLjNn9NZj50GInk?=
 =?us-ascii?Q?fXxD4xKfp0d8oFmreLILxatRLTN9rcKtlu3ZoNh/D1mKVWlBBg9zetnkWQLP?=
 =?us-ascii?Q?0ZwcGkJbMA6JKrNRSb6E15C54Fah32s0ppV2+vaWkIb9omSQrwizdBcGNQ07?=
 =?us-ascii?Q?yDAL4X5+s3K1e30A5dxRizRMenm0k6WZ8CPIb4WllZ6sFnbFOZCSLWRrkMH2?=
 =?us-ascii?Q?k9icu+4BZko6P7JSMqPb0AGBRq6cRtlB1HHI0yvIP5QGEElIq+UuF0ebpvll?=
 =?us-ascii?Q?aI8nk+AECzXLwHebCPMDuAZ3KJGQ2jHDShgqSzH1H+K7E6Kf8wJpgqcpTtyT?=
 =?us-ascii?Q?oYv8Lpxp9IScIohOVCfXTHSk7nc6B7uyIu9yF7DNw//emZV5OeT2sDfyNNOT?=
 =?us-ascii?Q?/TtKlRUd7F5t2qMY3QEhwcl+irFNdfySKmNCCFdgcx8/Os7Heoj9E+1qr0Pt?=
 =?us-ascii?Q?DEvRAX6K+hcSneay4qLHfRhZK+KFkxNFHVJhNhxH1k3TyZp+rYIE20MRLzpa?=
 =?us-ascii?Q?BF6CE/K+yLFCD4IpPNIOuyP69AUF/lNidEGCPvgnFfnqhiDmsxx2BZ4qEJSS?=
 =?us-ascii?Q?94APi4dodou/ZW08aVf+JxMM8Z+VV2Oy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rbtlwIqGmnmzCtCJcBEYu6sr9nt+3pe2lcU8OseKRui2nTMZ20UmBDjOqZbY?=
 =?us-ascii?Q?lYJYzXgH5ghhYv7s1zZWqt9oUA0tSsaQL2+EkCwG6noFO+VlJRQHAQN8im54?=
 =?us-ascii?Q?M94IVIe+1EH6lCP8eB5s3wyOqLlyBLhmsz7gj2V3Cp1Tuc5xMekirTed37fW?=
 =?us-ascii?Q?sgSwcuTFaIjj0q6Encp03G4N5akqEBPX3Kfm98YjYdBndbSYW3bhETs361J3?=
 =?us-ascii?Q?d4F4k0+N+xNQLDhjVnU2OYr8mHA0arzwILYftBzDTzBmCtV2PCIi6pbS+NXd?=
 =?us-ascii?Q?zjTsQIcpoibk94UWwVin5jd1W2u0f5MzBc4fX5gKLkh5X7ulVIJxW1IErgvh?=
 =?us-ascii?Q?hRunISAOtaAxF6IR5KoH/nhkk74VVTUXiEQwX5Rd093x70ya2LbKXl8cy9e9?=
 =?us-ascii?Q?RZkADknXR0zZS3QuF3NxrrGLhMMiKDmhCnsRt5JYdN2fJRliEx5h3T/dWe9X?=
 =?us-ascii?Q?VhvCqKT0rDRCR1MrJnMG8j0uOrNfdnnd/ONXPqAAsQgG4bhzSUTSRm8QL/rc?=
 =?us-ascii?Q?0g1PA/y9UBYyAVWDFUzhkvqjRpNRdlO6+kE4ughsIamIYqYrVNfQZgTtaou6?=
 =?us-ascii?Q?k7NNwcmy7CYYjHNF/HgsrTF0hRrbzr9IqkHCo1nkvaQ5p3FThBag03w7X9I/?=
 =?us-ascii?Q?YWoCrNWNp/Lqz284VO7Og6G0sAhQyc6+HY9SrtCm8IZh7bDx3Azwk+TN7CJb?=
 =?us-ascii?Q?AKBDQr/wTqLytvDe6dvGp0+eOg2QA/v6PQl5l5PYMlJ+0HgzpK7L8IueaqNC?=
 =?us-ascii?Q?iItwscxl1ONf+8mA6nTDztt+4EElkiMY/prUoHjqm2lZYye3ifaPNb5HFbiA?=
 =?us-ascii?Q?QeHTvFsMDczlmxVgpxjaz173K2vbAB/m1zoLIA97hFqWpaBJK8W0MP0SCJ33?=
 =?us-ascii?Q?wSgJm76M06bPSoXDLOibHpEpG0EoGXJUuTfBYGrwtFxXv7k1d5bNFfWNFcjP?=
 =?us-ascii?Q?rybTLyhOgp+4W2E4E3ZRVsOZOo4RBgx4Lp9Nv0xkl2z+SrCpN4qSuuCdC+ER?=
 =?us-ascii?Q?IFlmo7kySWB0xkSiIzeuQzyeU+RuuB1m40ZkjsNPTq+xhsio67h/QooJbkuR?=
 =?us-ascii?Q?ULOf+qYkkyuQ3YNbGyna/kvptYZJM6smJrAc8qormLSrlA0DyvBz3fWlrRW/?=
 =?us-ascii?Q?jkiI7grHCGOaEXcyQkEcELxpoxmmUB0uyr0zbZX24YqBn72BsXbBvIuMFK1b?=
 =?us-ascii?Q?2gvhW34teRhEGaTZs/JL/SsZux3lNusr68jfDOfgVBxoNqagsAY1C25Bld+u?=
 =?us-ascii?Q?+auhbUeYheVgAw8RU3Adf84VZcFr+aNcy4QTfI/KIb2+D9239J42YAJ8KG15?=
 =?us-ascii?Q?t8LJrF3nKqp32ybrd3UsTG+P/nZ27+jYUfk3jwGMxvwLridOSPZ00CsF3NS2?=
 =?us-ascii?Q?6f5izpo6MdHis5cwhIyOtVKzOFkJxczJMPiE+VGzQjduC7yxnWiGK572aoj4?=
 =?us-ascii?Q?3qCGjPPNzRZ8Yutz4SYT8dENVaQCur6SjNfg76Y7P+IfQw+LkTQ8WkPE9EoT?=
 =?us-ascii?Q?bIuUJKi17XStqtxoAaxY6JsQ1EK7tTPgniQmHgkcBU+ucA6tjqRV2tq51TFk?=
 =?us-ascii?Q?4nCljYxU9dT4JZTM2U3CbOtC4GBIVdWD8VF1eDyLBrOFiOP0xKEFebkEez9R?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860fd170-5a50-41f6-ebe1-08dd407ec3a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:05:35.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsUZqq4oPD1UMaNXC5figORQy8/S7GFapp4ur05gjFbT4WRKBql5kfuMnVaPcy0UZQDOQ9VnuoMq40h7CxMw/xkZbGAaWM+5ljF56EMa/4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB9346

In the two loops before setting the MIDIStreaming descriptors,
ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
But the counts and lengths are set the other way round in the
descriptors.

Fix the descriptors so that the bNumEmbMIDIJack values and the
descriptor lengths match the number of entries populated in the trailing
arrays.

Cc: stable@vger.kernel.org
Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/usb/gadget/function/f_midi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840f..6cc3d86cb4774 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* configure the endpoint descriptors ... */
-	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
-	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
+	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
+	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
 
-	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
-	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
+	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
+	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
 
 	/* ... and add them to the list */
 	endpoint_descriptor_index = i;
-- 
2.48.1


