Return-Path: <stable+bounces-123149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2EA5B971
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93905170B94
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603491EE01F;
	Tue, 11 Mar 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="mXMSyF4r"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2100.outbound.protection.outlook.com [40.92.91.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82801156861;
	Tue, 11 Mar 2025 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676220; cv=fail; b=lm0VMpn8IAK3JBg3Y4wRG0xG5+QAeEiW2IkUIuXFMaWIufSbeBnAZBQ58zNaA6OaioArr0HRbbxys1OWTdAJJAZ4AlvDkKw6SBClIV8eVJkwTFEM3TZHzqCeozdIuT/zCKtySNUOhGq2thoMIYzwHuEPRtn4InqhU39IaxwoJ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676220; c=relaxed/simple;
	bh=e+mn9iVObP2vMChaXZGCAp5HRkHcDjnWE7ur8mBraag=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=IzaOnad8WfBauo3tP+m25rtP6ox2YkfhI6CD/5Yif8kvE4KpbJl8/vG8VJcBpwGAYG1UVQQWKz1gsdj/OZXVUyVlKQyAvFgkWuS/rBPchBUUvXf3WV38q/3xcYt5x64SRwKs+ZpAQqeQJ8fr0ZFTzXlX9WXxJby3Gq4DB6eXhBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=mXMSyF4r; arc=fail smtp.client-ip=40.92.91.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh1WVLoGQ2DCMtLOSC68v4XvgisdGC9ju75iRMgG09H6G0Eujk7eFvUhChT44yzLnBR2oPoaDibPYSAf4I6E2IyUxUQcswbxY8IPu8chL7lKYmA/zN56N65RClnV8WSGQ0wszOmsj8tCYUrbRcGAvjNfHCCMaxOL/SW1NH8wBAehQkGJ+iRusc8F+EDp/2Tj8Tukpm4nqHGiDINBmOBAd6MKCVk9jA4bsTwy/n/6Cy9M7raK+0g6XREDMYiRoi+4hPWhp+9ptaoGBVa5H4g5e7v8mR5zo6D1K0lrBA50ybnWZf2/X3QobHFi4IVELHyJe8EicjSqHuP3F3YHxt3svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESI08zbAIFBIe2pcah54p3/mEyI622DmNrHk2muuSxo=;
 b=A1PJ0g87meP71dLOyJPOQdi5Cg0wVOjvQbRT0p3K35ahT2TMicf80gRJyV7S+yncSJqHBkTgj310d/4LF0NqBKKdYhZtO1RiKg8loV5t6a79ET6gekziq6orvIf0FJwk9QWygin4xql1m/qKnqYalhncBShQlJjfIPnckaB1svY4uvO/EBPjKqpPAe1mxhB+4gyomIfVd0fGCjZa1gl1w2lUQRZHDsS6AoOgMJXJzmpaAS1RyffDF4GpVufQ8LLg1E5CUPhebtHodp+igUXRTUa4IsTtx9pdRlVIJIayNF1FyoiNbITjECamRDXWPOKzT2jdzJZ86gxMHK/CDlNScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESI08zbAIFBIe2pcah54p3/mEyI622DmNrHk2muuSxo=;
 b=mXMSyF4r/rsSuDe04MrhktBTEll6LrMJKj7s8GxR424HFJq49LZG4vU+/NNbWotFciukza+JRbBoA0rz/G/WJAMBRMOk8KG9zbSl3wOmoKfXimAAGshwEi09XdA5bd6pr+6FfLpiVAVzHPffz9gxAm58/lpBAg9gyvTdyhio4hbNW46zxFBAZyuDP34EPxkaQ8RbP5eyxuDl0WlTbNZWa29XZDJrfmoxbeflhwYNjP6zo21NJX92GSCV3Dg9InhFPAQ3hwdiTnanmrvA+IBZSEoqMVnzw8ohWEfIPORzFEwMZMLNOTWqLx/XEhtpdHZk5GRWhQ45HopUxI6p1PizOQ==
Received: from AM0PR02MB3793.eurprd02.prod.outlook.com (2603:10a6:208:41::14)
 by AS1PR02MB10347.eurprd02.prod.outlook.com (2603:10a6:20b:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:56:56 +0000
Received: from AM0PR02MB3793.eurprd02.prod.outlook.com
 ([fe80::e01e:5e25:e074:79a0]) by AM0PR02MB3793.eurprd02.prod.outlook.com
 ([fe80::e01e:5e25:e074:79a0%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:56:56 +0000
Date: Tue, 11 Mar 2025 06:56:54 +0000
From: Cameron Williams <cang1@live.co.uk>
To: linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Add Brainboxes XC devices
User-Agent: K-9 Mail for Android
In-Reply-To: <DB7PR02MB3802907A9360F27F6CD67AAFC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
References: <DB7PR02MB3802907A9360F27F6CD67AAFC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
Message-ID:
 <AM0PR02MB37932C36EDBA13822CE6F5EBC4D12@AM0PR02MB3793.eurprd02.prod.outlook.com>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To AM0PR02MB3793.eurprd02.prod.outlook.com
 (2603:10a6:208:41::14)
X-Microsoft-Original-Message-ID:
 <EEEF471E-00F0-4103-BF0B-B292669E1CAD@live.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB3793:EE_|AS1PR02MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: e07b80ee-79b8-4934-c6ac-08dd6069e93b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|8060799006|5072599009|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0VQNDM3U2VQekMzK2JCZGJCYWFOZ1AxNk05aW4zTUZPZ2ZVdy8wK1pHZG5z?=
 =?utf-8?B?WnFpTlVjdmh0TkF0NGJ5YlRTK1p4SThPZHhjVjZZdU5zZXBRTHVXZmZqdWpw?=
 =?utf-8?B?MG9pNXdUamN5U2djVXR3Q3NpOURSaFpSa003YVRMbjhKRnVUb3NiUGlnUWx5?=
 =?utf-8?B?dExqSnpZMTMyT3JtTHkxTHl2c3B3ajBDNEppQkg3TWxMSkhMeis2T0JhSGFE?=
 =?utf-8?B?K1FiaHI5YTRKaFRmeHljdGFEYlphVXJsOUU2ZWhtTG1McFdGL1ZYRmdYUlRD?=
 =?utf-8?B?aVkxRlhRdkZCVXYzWlFIejI4dmJFSDFQMmdGWHk1ZjJCc05RSzBzNHBLemJu?=
 =?utf-8?B?S0tLUmpUaitTZVBTY3NsR3pGOTcvS2lacXZVV1RaR0huR3A4RjdPZHgxSDFV?=
 =?utf-8?B?aEsyMEg0MzRkenFsblJYN01jdzl3QjJKeEpUd3JoUXVuMHhpZGtYMkM0dFlm?=
 =?utf-8?B?RFRlaTVqZWZuTGtlVnNRcUNxTmU1YlRPVzhua0RoTDlBbWpQSlA1WWdvSTMx?=
 =?utf-8?B?Q3VRY1FHSmNyWkFsNlc3aUhPTVViZkVBckx6UHpIU3VuQUJHelc5bCtUYlVn?=
 =?utf-8?B?KzFiZjdPeDBBNHFOTThDYXc2ckZEWUVCdVBzL2MvK05rcnA0cTFaNVdwVnkr?=
 =?utf-8?B?U0ZNTEFCK1pyTDFhN1NuMjJNN3MzT1NHUVRkNm5vS216aC9YVzlzcit4bDhp?=
 =?utf-8?B?TDVhdkJqdVRCWkFqRXMxMFUrQnFLOGU3bGRLblg3S1RDMUpPWUtJWFFXQkQ1?=
 =?utf-8?B?a3RRdVBSZEhJb0p0YWFxdkd1eXRabVgwTGVFcm1PT3lWcmZ0bHg5RmdwcUti?=
 =?utf-8?B?aHBCSTJQOC90WENGL2VFcWJFRGRlclBBazFyK3ZlQXBjaTd5RjlVMTZ3RXJ4?=
 =?utf-8?B?YlljZDFBRkRicDN4Z0dQL0ZwZlgvWUpsWk8wQTlia2NadVJZNmxlRTRmd2FP?=
 =?utf-8?B?RWxxemNXNjBJaHV3dlJIK29JRFRMVkZNQ2J6MHVmUTU3c2dhRnc5LzFieVBk?=
 =?utf-8?B?bVlUa0VqelI3UzdXcTdrMmcrZjcyYktHMnZ5b1VSWEFoNlRuYk9WY1NybU1m?=
 =?utf-8?B?SzcrWG1JQXVJb2ZybC8rcEZOZHJTMkREMk1MN05JQS9zTGI1MEJmZURuNTAw?=
 =?utf-8?B?a0krbEVTNTg1Z2pHUzNDY1RsS3NWUUhWUWp5S2R3WUpxaHNNQkdHTXZqUWta?=
 =?utf-8?B?ejNqUitJVkFsS0VXVVhUM2lSVUJ4QTFEdDFvb3ZSNVVuUlZ3L1pJVFhBL1Ni?=
 =?utf-8?B?aG9VSkp2ZEdvK2VBZkRBOGpkTjVZbEtQYnVaZW9HS3ZYSUhhdjA2QVo0SGh6?=
 =?utf-8?B?ZjkwenFuYlNudTlqS252Vlk0OS92SWdtQkl2SGoyUUdsam52Mmx1bVF0SnBs?=
 =?utf-8?B?ZjRGYkhoMFJoKzcrcnR0aE9WMktkeTVJeEtmVFBwL2s0T0pvNVNzTWNVTkh3?=
 =?utf-8?B?ZEIxMGdCbDhuMElpcFpaWkEwaEpCcmlXYXFRN2grcEZNbVl5clBDQVNLQWY5?=
 =?utf-8?Q?v3dDEw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGRMd2RBVEZOem1PQnF6Z3g5Y1ZvQXJieU5xK1RPczJ0aHVLZU1YbVM5VXIx?=
 =?utf-8?B?VUJpODZIU1ZJM0dsM3Zyc3JpYWdmelYwdXo5WndMZXU1ZnFDekw3U3VKc2Rm?=
 =?utf-8?B?N054bHhUNXZ3NStsalVadGM5dTJTQUVjWXE4MURZQXNUUmpVMENaWUYvRUM0?=
 =?utf-8?B?eU1GempmMldoRTc1VFBoSkdRSzhnQjFwb0daVUFnQjRyRWEwNUEwRTdyYStj?=
 =?utf-8?B?NWR1a3l1ditVbjV6eW9BeFVxNnhoanhiNDhuWndCTTF4YmF6bVFpbU1waVZX?=
 =?utf-8?B?N3FGZEN5UVFJR3R3OHIzQzk3cFNScXJxZldsYTUrU3lmbWtzc3M1Q0VESVUv?=
 =?utf-8?B?eTZIZ1RQVTRKUWlRbDJuSWFQOVVRbjNIK2tCSXR2TkkwdmtkOVlrOFk3cFZI?=
 =?utf-8?B?aVdETnczeHplWmNUUGd5bk5TU0VPVWRzNnk3TlNKOFVyMEZhalBaTEdLQnA1?=
 =?utf-8?B?eGsvMXQrZXdySHh0UlMwcm5McW42cjlrajhZU0hMRE0wQm1HQkpZSnI5Vk9k?=
 =?utf-8?B?c0xFS2t0Vko4Sis3QkN2RVFLcllHbTJKZks1S1BLS2FXNWpJdDJhRTduK1NT?=
 =?utf-8?B?V3hITTBKVjdBSWxuMGZxZDRjUWFXTEFkSHFGckZBOFU5WG1xOFFPUnh2aE1x?=
 =?utf-8?B?bVhGdDRjeFpFVWV1OGJqem1Ec0pWWVI1c0REQ2Q2T3Q2NERjK2pZczBzQnht?=
 =?utf-8?B?THdWbkViTExTSDRydkJuTldJczRML25zSDdDdUdwd000RDBXcW1EWThjaVB2?=
 =?utf-8?B?Rk1BWGdabmpNK1BLM1JtTTdHYzhSdmJZckxxMVp1RXp1S3JoWFVWU01mNk5n?=
 =?utf-8?B?UmdtVXF4K0lJcURiS0xPT1R3dFBtK29WVTVtcTg4QjQxS1VqOXU3WEp5YVJ6?=
 =?utf-8?B?ZHZaOGRCTEhTWXo3MnRkYXZta0MwVXAydkJIMDdnRXMyYTRhNDhMQld4a3pm?=
 =?utf-8?B?N0RvWHNSbVlyVFRFaEpjcEx0VDFhZWE3MlF1NGQ3aVhUdEFjWE5EUkhKSDFt?=
 =?utf-8?B?cGR5M0FvQzhiREFqZVcxVngwdXRxQnY3b2EvbXgxTStvWERUcjBnQVl3MlZT?=
 =?utf-8?B?S0Jvak5ZZVNQcHRnRVhjSjZBaDlIN1p1ZnN0WXFKdXZiV0JJeldmdTkwOGpw?=
 =?utf-8?B?SmJ4dFBGOGdQaGhHbHF1VFVZQktlaU80Y2p3RGwxQklYTEZWeStFVFVVUGR1?=
 =?utf-8?B?WEJDQkRMOEFTTFUzdXh1ZFpmSlZQYkxMNHRhUHFGWGJvWXZKTklWcTAwWVVp?=
 =?utf-8?B?N0ZQSzd6em5XdzhVRG90N1pmenBXNUh1MG5tWUxPL1F4c2U0aS92MWZ3T2JT?=
 =?utf-8?B?OGlyeUV0UHQyd3hRdTdSVWdKckRsRVpVWGw2eDZ4Mmd3Ym56MU9YYlVvZ2E5?=
 =?utf-8?B?K0ZGYm1lVDBOV1MwOEl3SW1BOVc1Z24yZ3BnSk1ZdHVYQVJCOXpnTVdhZlV6?=
 =?utf-8?B?R0Jibi84RzBjSGdxTVZJVXh0aDljbjlSYnRWTmIwakgwYlpZeTU4OUlBOXBL?=
 =?utf-8?B?UVErcDQ0NFhQdUJPOStLMFlrQ3hDYXhCeG1LRld2YXBiMnpoNEVvc3Jtc2ZJ?=
 =?utf-8?B?N0haWW1nS2FOQkNld2RSZDJUY1VQZ1FsK1dCUVFSK2hSU0grZkZkRHU0UDg5?=
 =?utf-8?Q?MJ3/naRVzLluqE6O4GhQRXWq2ORdNbMZwPqRB7x1NxHo=3D?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e07b80ee-79b8-4934-c6ac-08dd6069e93b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB3793.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:56:55.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB10347

Cc'ing stable

Cc: stable@vger.kernel.org

On 10 March 2025 22:27:10 GMT, Cameron Williams <cang1@live.co.uk> wrote:
>These ExpressCard devices use the OxPCIE chip and can be used with
>this driver.
>
>Signed-off-by: Cameron Williams <cang1@live.co.uk>
>---
> drivers/tty/serial/8250/8250_pci.c | 30 ++++++++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
>diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/=
8250_pci.c
>index df4d0d832..911774fb8 100644
>--- a/drivers/tty/serial/8250/8250_pci.c
>+++ b/drivers/tty/serial/8250/8250_pci.c
>@@ -2727,6 +2727,22 @@ static struct pci_serial_quirk pci_serial_quirks[] =
=3D {
> 		.init		=3D pci_oxsemi_tornado_init,
> 		.setup		=3D pci_oxsemi_tornado_setup,
> 	},
>+	{
>+		.vendor		=3D PCI_VENDOR_ID_INTASHIELD,
>+		.device		=3D 0x4026,
>+		.subvendor	=3D PCI_ANY_ID,
>+		.subdevice	=3D PCI_ANY_ID,
>+		.init		=3D pci_oxsemi_tornado_init,
>+		.setup		=3D pci_oxsemi_tornado_setup,
>+	},
>+	{
>+		.vendor		=3D PCI_VENDOR_ID_INTASHIELD,
>+		.device		=3D 0x4021,
>+		.subvendor	=3D PCI_ANY_ID,
>+		.subdevice	=3D PCI_ANY_ID,
>+		.init		=3D pci_oxsemi_tornado_init,
>+		.setup		=3D pci_oxsemi_tornado_setup,
>+	},
> 	{
> 		.vendor         =3D PCI_VENDOR_ID_INTEL,
> 		.device         =3D 0x8811,
>@@ -5599,6 +5615,20 @@ static const struct pci_device_id serial_pci_tbl[] =
=3D {
> 		PCI_ANY_ID, PCI_ANY_ID,
> 		0, 0,
> 		pbn_oxsemi_1_15625000 },
>+	/*
>+	 * Brainboxes XC-235
>+	 */
>+	{	PCI_VENDOR_ID_INTASHIELD, 0x4026,
>+		PCI_ANY_ID, PCI_ANY_ID,
>+		0, 0,
>+		pbn_oxsemi_1_15625000 },
>+	/*
>+	 * Brainboxes XC-475
>+	 */
>+	{	PCI_VENDOR_ID_INTASHIELD, 0x4021,
>+		PCI_ANY_ID, PCI_ANY_ID,
>+		0, 0,
>+		pbn_oxsemi_1_15625000 },
>=20
> 	/*
> 	 * Perle PCI-RAS cards

