Return-Path: <stable+bounces-233277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE+wK7Ld0GkPBgcAu9opvQ
	(envelope-from <stable+bounces-233277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 11:45:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 583AF39A93C
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BDF530180BA
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13E3A8748;
	Sat,  4 Apr 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fJq44Y5f"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951C3A7F48;
	Sat,  4 Apr 2026 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775295915; cv=fail; b=OxM5jWwKeLZIolo4bNNl1i0yCQjiDJ0vKB4gO7CSpf6o1md04c3vO5923zMUtbaHfbeG/ykQgOqsY4E7xQvExqZxoF7+vCffz6QKZryzyXt5ecH5v2O6nTGY+CGhnPSiWOSjqSneOLdxDIAdZ95Tr/x2Y5XwgDPRvHD/9JdAFlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775295915; c=relaxed/simple;
	bh=ETyRZexaccSo1y+lj8UN+EyYdey064NQXdVLI95w0tA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kYdl7tKMxIggCLBnsykdZBqqGUXgjGY9ztDtWBSNIW1Eg0wS9R0gUbi03itn966SRMprrVJPiVwLV9j6tcWJFKERoUguUyMc3iaIPSpTUzRKaE25PcOhnncWv8LH5kCu63M4NmfMMi7k6EoM+fmeAYoIYFwnxlHDl0DnCk5quBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fJq44Y5f; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI4umOQEcmEFU5fwr7lHwGiv6l2ge0YM1ZsnCLj4FeW6vy3vGEObs7bvFksZ/mMwCFfR6fAo+fc6S3q2fiaUvuJi4uxdi7vorwXLBLzVcEo8qGwu23LzSwwUx7inoqSMUEKNFb8fyp9FR5hUs1joYWtZYtd+FNTPeWX4tJWI/1nM5qW8QFLurMtOEJRIXEnli4Fj9iCyEtEqZvgU7/zplBbQ/ioY0W7dnFjY3hfOHX08h+DnVaLE4k2XPVGRhuT0h3zYl4sBhnNugZ+rGHaB96dYd2XdKRh63pQMriOtFOt2+28jvMc7nd5YDg8WnneWvyKMC1uE4W649h2WhBFrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w5QYwHIZLxTST7EjuflNQlu9HEiffUx9lGy4RKW4Vc=;
 b=pZgx3eYXmUNmZsF4Dy72QZtS3tx1y0t5cGbCgX/3v4VYpSzD9XZPzRTsyco5vgRnUwCAqmWS6QlofUr9DgdD3gEBqvFWtoFdEudGf4PQAGruAtd8+A42G+KT8dHuWA5Ysu3VRXJq3WE88CtkIYdhzxV7LZCf7ECO3prJ04gNt8HJ0Tf89rphebOnw1ZvIR2AGmtOQ6MgomRBfojT/d3oV9QDrIt7/i3Q02Jq888zKibywXbyATCalemdSXsw3vARC9x9ky92IRj1kz1tTnUa6BGo5NN/XpfNubYDNaQh8ARqKfYtqgUsailzCqr+Qd0EP2E06IgQ6crBFiKySdf2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w5QYwHIZLxTST7EjuflNQlu9HEiffUx9lGy4RKW4Vc=;
 b=fJq44Y5frWRzb2brDJwCVUJ6ib+sa33vlsOpdyWSd9jH6yoXSLnAjwNYD/Tdichg8R8EqziuNrqvbyxFhUiWsU1UVMoNGvwxiEyjxFsJzog1jpovYjVPBHKVcKcvT7idJQuVSsQffBS/xTmmlf/2PLfjr9TaA5M/pVq4Vo+Kkq+BCGGb7DqoZ8+AA15RvA15ML0JergGornQ0yzBIBsiHMWdvjxQ/YC3WqJSXRjdUK9s/Ywi0wMdpnYWWrjJXfjJJgZTVJQQt1xy7pIdo/UEkjl+eIZS1zdE1tKFqzb/ezGJCth9zfwM7axU1Q66ZxabWphxiHlS2oRTs832xfdILQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN3PR01MB7000.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ab::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Sat, 4 Apr
 2026 09:45:10 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9769.018; Sat, 4 Apr 2026
 09:45:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Eikmeyer?= <andre.eikmeyer@gmail.com>
Subject: [PATCH] HID: apple: ensure the keyboard backlight is off if suspending
Date: Sat,  4 Apr 2026 15:14:34 +0530
Message-ID:
 <MAUPR01MB115467C51E492BD620ED390B6B85FA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::16) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID: <20260404094442.6040-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|PN3PR01MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f12d1a-993e-468a-7dd5-08de922edbc8
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/xYcxR7TY+ceHg3Nhq89ATvKlWbc7Is4EQmpoGttsMu97EeMHRvEygKxOjAy1ePkt21NogoRTmY5b6pRRXmhs0HckjcpJ5Ea9LKHZuN4Jui857nPv4yqG7SJuByWSF0anDy3Y4YX7zE8s+z189y9oYnjcTdAPFiOFVPayTyyh6kP2wNRP3dkRa2m4GyhLBjqUhEunXevrRRKXU/NmuV3JFD69edII8LtN/bxcmyt37Se3Cck3LZdLQE9e55bTrB74K/4vVJLMBHBq5w2cZkS+nwC5pLDjrG/FbPoYTDyN1Bkm7OxwXEco0udIJSONPufzEN/bTzVtPyenUCjUA5HLkrlM9Z8do5XeWHx1PSs4zJCR5GmwPoOCwjySx3oab4fNbaJTL7WoBDlYx0VzcqnJXZFuHKcvAdBNUIpDGFMvK4knhFCGfA+9lVCT/l9MllygUxHzXli8PzWouQMAvc06rYkQMGIEY8QGoIhfO3yMubKlyVM9l61H5ehGH/k2AbdwYEffO+3jyRM0rpPadh51V3popojRzaBeRP1KPcv+PvqGzdgcwXeFyFCCxAUyTURar7/GM52dvhI+71GJhv6EWyir1Pv0wwPMm0jdOTbjtC/yWzT1f+QstPUBPD841p2+RU8Xyu9LqWaBK4x+VCeyabsAy4KZRCQ54RovBsGeb4ZSV1A+atO0Fn8gx7jFbN8QwCLno/D0k/tZywyeZLJf5OJhIZHavegkolxEW6MyRLQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|5062599005|19110799012|25031999004|6090799003|23021999003|8060799015|461199028|15080799012|40105399003|52005399003|440099028|3412199025|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3dRQks1TUhOcDNFS0QyeHBXVTFwVFIzWTVhRS9MODNGbHJCVm9ZQXJUSDM4?=
 =?utf-8?B?NGVuM1hUNkk1a2s4bVFiYW1SdVZ3WnB6YnZ5YTMvZ2dFU1JocldyKzAxZ1lt?=
 =?utf-8?B?UWxlV005N1dZT0Fpc25SbWd4T0tQclNsSU1yRE5hdlJpZEtBYVdZQVhwQTJ0?=
 =?utf-8?B?SXorT3drOHVEcklzYmpGODROQlI2bVI3RlFVc0IwZlgvWVpZQU1EZWMwM3gw?=
 =?utf-8?B?VnJKL0NSOFJsUVI3eHhFUGs0b0t6OU9yTUZlVnNmUkhtbkwyVjdPZ0xkWWVj?=
 =?utf-8?B?a1Z5dWdic0VSYlcxdncyWHYyK29ucWxadllRZWVNalByeS9SbUJhakhPa0F6?=
 =?utf-8?B?M1plZ1lYY2tuS3czc2RBZkNNQVlGRDhUV0dtQkhRVUhFY0FUZVZtVFZUUkpj?=
 =?utf-8?B?ZHVJQ2FtbE8weS9ZcWpQZnl5R1dIM3VhcEZqa2h0T1EvbzlmMkRNVy9oNDdU?=
 =?utf-8?B?MVFWaTFxSjZORUR4Nm4reEVOTWJITy9PcS92Z1V1ZTEzNXBJaUtNUmJzUWQx?=
 =?utf-8?B?OFRyZUtISE4wS0ovWUpBNHc4dUg1Wkphc0F2SzBMd1hhaU83YURMQTdzdXYv?=
 =?utf-8?B?R3RFRTNuQVdGd3B4b3VQeS9SNFIvTkRDZzVXbjh1cUZvYXk5RHVtWWc2UXNV?=
 =?utf-8?B?YzVFNHA3azZsZGY3N3pxQ3hnbUZoaXFSK0RoRDFsQzJvblZQV2hYUkF2UWRo?=
 =?utf-8?B?cGg2UjNoYjUzMzZmRkRTdmp3Y2MxMEFXK05uZzgwSjNMNTgyb2gzb2J1UEdx?=
 =?utf-8?B?ZWUwYXN6YWZzYTVtUERtbHpUc2FQWGlUbWlVcm9MZ2IxNFFuNXFIRUM4T2NR?=
 =?utf-8?B?VWQ0MU56ZWlSYmtYcGhSWUFYZENaWC9CSWZ5K3lkYkdWMlVjekZJL05MUVYx?=
 =?utf-8?B?bTJYV3BpdWprSHRJaER1VlNhQXE1d3grL1kxMjBsSVQyODNrLzlxb2FBK3p5?=
 =?utf-8?B?djhGRk5DZmpxR1pmSDd0OVFpZGtnYi8yQVVLYXNEcHpaZUlJb0dmeWVPb0hS?=
 =?utf-8?B?S1EyQnJGdWdhVDNQZ1hrN0VsajZza0Q5eDFzR0FodHVpSVFzMEkzOWVmaFJR?=
 =?utf-8?B?OHNPMlJaM0Q5TWVaV0toK0xCa0ZoeW9tQmhJOVRYc1N4R3ZmVWJpVURLS2xi?=
 =?utf-8?B?c3Y2ZEZOU3hmc1FQUWl2WjdwelhGeHphUmdHcGdkRGhUdzc3bGpNc25naEhk?=
 =?utf-8?B?azNIaCtiTDBUenA3bmxRUnhDTDFlVE1HalBtSU5SYmVHRFlQSkFOaVZ1NVRI?=
 =?utf-8?B?MTJGYWZxOE5XSEM5SldiWnBKR3RDV3dxTXRIN1RTUERpdWlOaVRMdVlXTlFn?=
 =?utf-8?B?V3VoUEQ2R2E5cmxwckhGK3VXbk1KQ0g1RTlEV2FFajl1dTVPTWlFamlQQ0RM?=
 =?utf-8?B?R2Z3QUxxY3VBa3c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V05oZUV5NVpycXhqZHh2aGlXZ09uSTJpSUt3RnZRZllqZ2JleGxkN0JDdFZs?=
 =?utf-8?B?M3FZZVdNOGtCcC8wRWk0L1lpeEpIRENFUUpxQXUxZGNmSkthQkhFWjh1U0dP?=
 =?utf-8?B?dHl1ay9yMWdPK1ptY21Fc1FNS1dQVDVnSnA3bWFmMUFKbytKWVc2Q2JtWm51?=
 =?utf-8?B?YWhpcmlhZG1EczNmbzJnUkR5YnFpZnZEalNkQ2ExczFkTCtVMUxtYkJZRHhj?=
 =?utf-8?B?RGhwTjMyMXVNa2NteEhqNkpRY2R2T3hjY0p4TXBCbk9KL1BFMEE1QzZvb2pG?=
 =?utf-8?B?WDRrdTZjUjVJWG5CdjRYV1FLSjZEdm01L3U2Z2JEWUo1ZVY1blBxYXhTTHcz?=
 =?utf-8?B?WUI2ZS9uWjgzN3FIY0piRThnZ3lTcEZ2cm5DL2VMMnB6My9XZjdrOXRTMnJk?=
 =?utf-8?B?VnhTR0FmWjZ1NEdieUxaUlU1ZVI3UVU2dTQ0SVlOWmFxK2NHZG1UOHp4ZHNw?=
 =?utf-8?B?MXZmM0FaNzMxcVE1c2JxN1haWHozZXNZYWhnaXJjb2VqaGtvczRNdlNHb1ZV?=
 =?utf-8?B?T2tiNXlJcTVrTDVWMEVFZElzei9iWnBGRHRIUzhaVGtRRFBJdlYrdXNrTjBo?=
 =?utf-8?B?NUFJT1BaZmFoRnJMU0VEZnpJS3VXbGwzaG1wY0tXVE9NZGtwWFB4MnJOTDdq?=
 =?utf-8?B?MFFlaUZOUkpxV3dyVlZYdkoydVpRdHlwQnk1OWp3U2VaRm0zWEJ0SUQyWXdW?=
 =?utf-8?B?aU4vVGowenN2dWwwazdSK0lEeHhoRDZVN1hxRDdyeitwb2QyZ3h5YmY1NS9H?=
 =?utf-8?B?UEswak50SndPN25IZ0NidUhCUlJyZG5DK1MwWm0weUZ4eWF2MWpZNFRiTXRC?=
 =?utf-8?B?NWI4RFY0ZVQvUTU0MlBadXpoNEpIajY4ZjNOaU9pTlh4TmVVc3hlc0lHYjNR?=
 =?utf-8?B?aktLUWVLVTlwS0tlZEdLRDY2MFJybE0xKzBTSEpJUlRUVzVyNUs4VDlrSXFh?=
 =?utf-8?B?RHhNNThUQld5TzVFRnNTSWVEc0p5am82QTAwM1VpKytzZHE5VGYvK0J4OVc3?=
 =?utf-8?B?T2hZSnBKdDBrUUJDaThLM01odmpoNnRLM1Zzai9PREF4aWhsMWJQTEpQZHJx?=
 =?utf-8?B?alFrS0pmQlV3Nk1vcnlCUlF1MkpBeGZ1M0NpMDE4QllPOFpTMmdxZVBaditj?=
 =?utf-8?B?dC9GZ0swZHp0UXpzb24wWW5Vc2hBYU9YRmU0cnVCTEs4U3NMbzVPb3o0cXZx?=
 =?utf-8?B?c3VUZndRQVZrbCtQUW1wUFpydTBPU2RKZVRQQ250Z1lqWkgwMGlGUndNSi9O?=
 =?utf-8?B?eWZ3Nk9BWmcvQlI0dzZ4WHJTUC9SSS9uU1krbE1yelNRMlRGdWNkZDREWGh3?=
 =?utf-8?B?ZG1HNk5QVkZXSEJma1FpbnNqdWFJZGU2RVdTUzYwNGl3Q2JDUHljenVvYzZH?=
 =?utf-8?B?MGM5YzZoQW9yQVNlcjh0SVJvMUVyWTl0eTIwalhjK2w2cGRTbHZkbEx5N3Rt?=
 =?utf-8?B?c1V5ZThCSzVTYUJOVnk5RW1JSjhyeGkyZlRPR3UzMW1YdWhQR2srYkg2RGtR?=
 =?utf-8?B?bHhmUlNzUHlKV2c5U1A3SldqMHQ2VmYvMDlnSWNHVW82dG9Ld3BSdE1hR1pm?=
 =?utf-8?B?Zjk1QlQwQ1BXMjE4SWg5NFpIVlhuL3ExQ3pwVlVFUHZ4L3NPQWpIS2ZPVzNH?=
 =?utf-8?B?VVdISFJRTVNoaWVUN3l1MWFGak9TK2lBQjJnRk5oNEp6VjR5N1Yrb05KNGto?=
 =?utf-8?B?bVNGOU9yRS9OaFJoVndjdkc5VHMxbG03cnF3bldpOXFrVzFJclIxQm1wTXd0?=
 =?utf-8?B?b0s3b0NhaGZNZnNwNTdwZktrOEtrdjQ3YUk4L0VhT3FCSXlSVjNvdmVGc09u?=
 =?utf-8?B?aUJLR1JIN2llWnp3QXN6ZlhxeVRvQzBEQ1V2U2VRMWVuWU8yckNCUllwM3FG?=
 =?utf-8?B?NkxsNXlmK1BuUTN3aG4wOFk3RzZFUmRzUzVWUTI0RGJtL3FKL0dZWXJiRmUr?=
 =?utf-8?Q?L7m1aYjAE8xnQoeRYHWL4ioaMJfSqX9s?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f12d1a-993e-468a-7dd5-08de922edbc8
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 09:45:09.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7000
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233277-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[live.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid,live.com:dkim,live.com:email]
X-Rspamd-Queue-Id: 583AF39A93C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some users reported that upon suspending their keyboard backlight
remained on. Fix this by adding the missing LED_CORE_SUSPENDRESUME flag.

Cc: stable@vger.kernel.org
Fixes: 394ba612f941 ("HID: apple: Add support for magic keyboard backlight on T2 Macs")
Fixes: 9018eacbe623 ("HID: apple: Add support for keyboard backlight on certain T2 Macs.")
Reported-by: André Eikmeyer <andre.eikmeyer@gmail.com>
Tested-by: André Eikmeyer <andre.eikmeyer@gmail.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index fc5897a6b..2eb45fac8 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -858,6 +858,7 @@ static int apple_backlight_init(struct hid_device *hdev)
 	asc->backlight->cdev.name = "apple::kbd_backlight";
 	asc->backlight->cdev.max_brightness = rep->backlight_on_max;
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
+	asc->backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
 
 	ret = apple_backlight_set(hdev, 0, 0);
 	if (ret < 0) {
@@ -926,6 +927,7 @@ static int apple_magic_backlight_init(struct hid_device *hdev)
 	backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;
 	backlight->cdev.max_brightness = backlight->brightness->field[0]->logical_maximum;
 	backlight->cdev.brightness_set_blocking = apple_magic_backlight_led_set;
+	backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
 
 	apple_magic_backlight_set(backlight, 0, 0);
 
-- 
2.52.0


