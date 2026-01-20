Return-Path: <stable+bounces-210475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bh8GGrzb2m+UQAAu9opvQ
	(envelope-from <stable+bounces-210475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:28:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8444C411
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AECBD74515E
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3743ECBC2;
	Tue, 20 Jan 2026 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="a55HiFpV"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1E3A4AB0;
	Tue, 20 Jan 2026 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904506; cv=fail; b=Q6gMH/iyPUFtkLCUlw9kRoekQmC7umIfNfHoefdcXP0b4ZEL+DOiYgYp+fqJF790qlaM0bP0t/2T5AYISkonMzTXSytOWvGpWPvwxScydv+krb3mmR/BBTgvSX7hlnxMSnF/13Tt5VFZjfAh6EH7kJcBu7atEO6cLsmhfFAfQ7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904506; c=relaxed/simple;
	bh=4w3DtDHZ34IcJqlop4VbVL2jDSQ3wCnU82R9kBLEQEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHvrxDQ9urOd4QFnnnpmiTZcpoq2aT3BTms+jy/dX7UNPa2j2eVtcCAAjLZwRksb2ZBwsDQBc52DaQ6we8nfuZo3DcrFsLzzUNoA7U7uIVlMWTsm6cha8hRwxMBk6yyB4mF7TqB+ZFDAd//5qDk/mPaqOj1Gfc/bGJJiNlhp9wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=a55HiFpV; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHTkcu9V7jff/X5qqIMFVklgWwXjNiks0YI9EmmTLuFQ2A5AjzL1XGYuns13HSOo1uVfKl4x1zOGWPsNaLDDpY9+AJcLKeypHsk6lpEqDZAMaRp/XUHz4z4synsr6z+UbB8eq5eTnGeFM3BWLmD5aYLHBalJAeNKxJguUXZp0GdMmgTP8bEVRagrQBssX78EJpz7G1x9snE1lKZ8HK9tg5ckHeush59/xF12ZTxpNkHB2rX8Gn6F5PLIdquNRBLqLaSyUi31yrkqmnlZIM0xCRyDdei6n/t71isUF62e6wHXN4KmWXEst2yTEye03c6SpxyUnjGhKWsIrR5hIaPTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bfT4PfsdxcnYexI5ijl7KjBDV17MG5wDUsbfoTGaPM=;
 b=Kn++L7B1sqnS6GeidnEfdrnOqx5tjz4smE/IJBSoQSNE0/iW42RrehB5MWn+CP9Ir4HNB8DoDWP61rPnIUeuX/vDN2dPn29SjNpyWklGU39yWodKq9t/9DkIwy3EC4Lls2GMe2tl1rEuKdMuTNVum1az86Jtcxttn3RqBIn3qbar5coyq2S20eBGH10681R+YmiEWw+lEuYzf8kdnZdIJ/3JE1oBpo0j+CAhtJByHnYLkMZeCw6VZ2voEUD9sRVX0pLbpLYks19BCj1AHF4WczlkToiCNp/kv2tAUqClgUeweLVAvNszCOrRD4R23aNTXYFEVr22kAz7GnrVAVov2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bfT4PfsdxcnYexI5ijl7KjBDV17MG5wDUsbfoTGaPM=;
 b=a55HiFpVXCCceov1FlawD8/2s4UnBNC0AX5BC1Cx77VdZlTP3yplyJ6nASv54rUGiwBt2k9P9LYCqgezvKibPJlrK/ui0trITdvwUq9Qh6G9AH8A+bSg+Ri6lnUEww6jNQ9BHk5liqWr1kqGl6Of/tagH/SnK0VnaEavjLH2I3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 10:21:39 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 10:21:39 +0000
Message-ID: <8df14d73-8e20-4d89-89eb-d40f27814d2d@cherry.de>
Date: Tue, 20 Jan 2026 11:21:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on
 RK3576
To: Heiko Stuebner <heiko@sntech.de>, Alexey Charkov <alchark@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
 <6479d7b8-7712-4181-9c82-0021da94d1a8@rock-chips.com>
 <5743823.mogB4TqSGs@phil>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5743823.mogB4TqSGs@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 282caf19-a31e-444e-07c7-08de580db2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|14052099004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTAzNUYrU25hSlRDQW51TVJsTWpIMUNrTHhTWmtEN1dHUFVVM3ZiTCsrUFVN?=
 =?utf-8?B?dmVGNStMVTFONVRGWWcxNEhXSkhoVmY5MnBjTjBTNCtZblRXUEs3Skxac2ZD?=
 =?utf-8?B?V29ERlVQYVhRWWNlcXB5ZDhmSFlxOEFVc1UvelYrOHRWK01JVkxYd2hZeTg1?=
 =?utf-8?B?eDcrbUx1NnNLQ0ZSbDJQdzhFeEptQ1hBcHQvMTQ1VVk2NmJFZmNjTVhqV0lt?=
 =?utf-8?B?QUJlZm9ib2E1SDNSdGFZTW1QWTRFR3ZPNEptSDlHL0hSQndDb3NXZDNseGdL?=
 =?utf-8?B?NmtyWEN1SzhPQTdzNjVPa0FxZmpwTElXUzB0U29WZzBUYk1uSW8xWSt5K3Ry?=
 =?utf-8?B?TVo3QkRTZ2JYVWNYSk11aXhUdVcvUzcwMkg1d3lKaGRIUW1TTGhheS9lV3lw?=
 =?utf-8?B?N1ZUUFhpVVgwWXNOdzBrS2ZuYmxDSVl2a2VBU2VWdFErVkpXWEtrd3FWaUNy?=
 =?utf-8?B?UXRIMHF0Nms4a0dqUHFpSjlQNzdwMk9sNGtHdWtEaGhUNzFZcTQrenkwZkxq?=
 =?utf-8?B?anhiTjMzTmliQ3JRNGlreldhNS9Zdi9lWmRya29XdkJhQXFjS2dWbzQxbjNK?=
 =?utf-8?B?VjduejlqU1FYUUpuN3BVWSs2bTFhV1lobktBaDRQaFRuSGlkZk5pS1M5S2dl?=
 =?utf-8?B?TFZncjh5MDZBV05KRlZJTE5TeHcrRDEvK0dJUTBMK2lxdXBLcUJnM2E0SmRK?=
 =?utf-8?B?MW9HWUVqZUpBR1o2dzUvNTRiekFKc1prb3E0R2grNjJGSE5rc1NJWGM1NVZn?=
 =?utf-8?B?aFlZazN4dkxrNUFxUjd3bmRjRUlaVVBtd3hQekIxYWxGajNSTzFldGgzOFY4?=
 =?utf-8?B?UXgvblNPOERlSU0wWE5rUDZWMy9hRVF6N3ZaS0MvbitTdzVIRVRVZklFdjFq?=
 =?utf-8?B?djhqN0d3VzJlYVhLNnJoc0JxQ0FqQWh5bUdaMVhya2FXdWt4Z1RJQ3g1NUdM?=
 =?utf-8?B?V1Z6V3Bvb0M1SHJiN0RTK2NremxDUEZPdnhoUUdPUFlKdm44U1haOTJCK0Za?=
 =?utf-8?B?QkE3Y2NIbkFVYm9SaVZEQWlWM1NPUzBNRGJ5dVZ1OE9zTXlhNGRkZmdOeGxB?=
 =?utf-8?B?bVpSYWhyTGJ0RmNkSXAwTm1uM1JQR3BMdkNWM1oxdVM1TUQzaUhxUHNTVllz?=
 =?utf-8?B?ZWM5cVhlQkUyNnNnNmgzTXVEazlpOVJzcmsxQXY5Z2tWaVlCSGdSaloraGVU?=
 =?utf-8?B?dmw0bWxmYTFZM0JmaEhGbXVBMEJrbi90d0c5bEplZFRXZkwxeHJDeHdnNVpQ?=
 =?utf-8?B?Y0lYZjRVV0EzYTJIdEVUS3dQMmg4ZG1rYVVhREN1b0xMUWxGdSttb2ZHbldy?=
 =?utf-8?B?UlE5dTBvWW5IM1EyVUZCOEdFYjBvdmE3UVJLMlVHVktIWlNRV0hzbTdmNk9a?=
 =?utf-8?B?enMzckdiSGV0LzR5b3hJVVFVOXRuUFBJang4a09iUHJUaGFOYU10MWdnTGZU?=
 =?utf-8?B?KzR5VnJjdUdNbzZyYzl4OW1IeTgydW53L2pWemhtZE9iMmF3d2UzaEJXV2Jl?=
 =?utf-8?B?NEJzV3BpbzhZRlBUc01vN3kwbzNwdDlYYy93enV0OHVQanV4MVpoajFnZTdN?=
 =?utf-8?B?b1d1b2FiMUdQb2Ruc2pnZW01TnRabVBJMHNZN1FNeG5ndmY4VXBxU2hpaHdH?=
 =?utf-8?B?a253MVIyLzJMQW0ya0o0TWY3RjVnd0ErOGpHN1kxeGlsUmtwS3JuQWwxaUdQ?=
 =?utf-8?B?bU9ESHdNMk9rZytrZmprVTFudHdFMUt1UFhKbzVvaWtUbmNXNzNjRE9heXRv?=
 =?utf-8?B?ZitIY05vRXZERWRXM1libnRSQk9lYlBHTEhRNUllb25pSzZwa0ltRFZIYXJU?=
 =?utf-8?B?clRDZ0pmOW9qWmswKzlIRkNlaW1IMXhWOUhNcHZFQ3VvY0xWZmJlNnlZU0tz?=
 =?utf-8?B?dkt0SlZQRllMVGRNaWhWdWZ1NENNSlpKdmZYcDJYQ0QyQTg1bk9XOVZ4Lzl2?=
 =?utf-8?B?RysvRlJOMHEvMFY4R3pWRXpvUVNzaTc0KzM5RktDZno2WEJnVmVLcjJCbjFY?=
 =?utf-8?B?Sm95eGpKRG1HUkVQekNkL2NRV0wyY3FjM0tsWWhtTG1RVy9nOVl0QmJzNnJx?=
 =?utf-8?Q?vowhPW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(14052099004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zy9Ha1FLS2xNVDB5d1hBSmFkS2hYNDVoRCtJVjRwZ2xVQXBGNllXNDNtM1d0?=
 =?utf-8?B?cWZ3MVBsRjQvZ0drTkFEY2k4LzBnbUM5TGRhR3hDUStpSHkyeWd3V1BQSTly?=
 =?utf-8?B?WTlJK2lXcXN3SHR6ZHY2WFlKOGt6NGFLcDVnQkhQR3o5OEtiVGJhK1Jicnhv?=
 =?utf-8?B?UnRTRWdRdjJEck9zWTZvd3JKODhMczViT2VyWFFocDRlSjFMNWVFd2JRcmNO?=
 =?utf-8?B?bmdFbHVzc2lHR0lqbS80VmUwRnlGTmR5RitaUkJOZE55QXRxWnRzN2tZS2hr?=
 =?utf-8?B?VTRaTkZHZDdxcnpTQkI2RkpXNHNsS010MFpObTFnS3JTVDJKQmNWNDh0R1Nu?=
 =?utf-8?B?NGFVR3Ftb0w5VklWakJkeTlqaGloRGNuQzBreHMxU1RHWjgwbENWWjJkbWFG?=
 =?utf-8?B?aUNEV3RKdUNsM0JuZ3A1dHFPU0czQUhIeC82NGVJQkJzL3VIcElscmdvZGFa?=
 =?utf-8?B?aDAxdjZwT2lucE15YTI3Nk5tdDdsVTNSTTZEZG9IUStGQlBYVERVc3UyU3VX?=
 =?utf-8?B?NGNHM3czWUFNdEx3VzN1QkJYZVNwSkdFaVJMWGNnWnBVbXlvYnhPaC9wcGM1?=
 =?utf-8?B?WHpLS0VIdWNCejg2cXhzaVk5YVFEQUswN0J3Z0pDUStRbWtvK2QrWXJxZnVK?=
 =?utf-8?B?b3dLU1dMN0szWjNpOTRNU09odmh5b1YxS2NHSDNBa1FIV0tWZzZQT2pnaHJz?=
 =?utf-8?B?NHdXYURVNEIvT1pCNXNkT3hWY0VuOWE5aU1DVHRibWUvNWNESEhBY1FHc2tX?=
 =?utf-8?B?WHdIb1BuUlZRSGpRcFllMGNQUTEwbHVBY0tSOXFxTWdOWldaejJBWVltd3du?=
 =?utf-8?B?UFNTZHE5cjkvcFJkT2Rjd3M2VWdQWElpNStSVWJOMXl5M2ZEMTJIK0ZSc2FF?=
 =?utf-8?B?VW4xdFIraWozdndUQnNkM1JqbVJqYlRsdVdDUGpSaTliTXdvUmU4c0RSSGNi?=
 =?utf-8?B?NUtTeU05M2VLc0FjeGlWN0dHbEw1YzZJQmEwdjZiakhtMC94cHhFbjBPRVRs?=
 =?utf-8?B?RUNRVVJoUENkM0w4S3ZBT0VGbkZkNklYbEFIQ3RaMS9nYnBFSm9lOXJHVU9u?=
 =?utf-8?B?enNYK01NUUE5dzRScUIrdkUxOWVtTy9uUXNMSlkrQkR1Mk54R2VsL0swMDF5?=
 =?utf-8?B?a1dFbXdTVUdJdTR4SWw1cmtkUzV3VEtNNGdmSHFmVEFWNVBLZmNZRkRzS2R4?=
 =?utf-8?B?N3VEeWFNMHk1ZUFWOVg0MThld2xrZkh4Z0l1VWJTOC9IZG9xQjhHMVlZeFgw?=
 =?utf-8?B?Qk9GTTdCK1I2SUp3Y1UzaERCdGZTTXRKdUxIc0YwQmpQWng0Z1hVY1lOaE9x?=
 =?utf-8?B?V0lEaUxvQjVzRkN5cjh4YmUzMlpJdzV0TXloSGtjTzJES3VXY2VKMDA4MlZX?=
 =?utf-8?B?c2JaMjYrZE1MbVhJZDZzNE85MzBiWmJaK0JTWmxKM01IbVB3ZkhjRVJxSXND?=
 =?utf-8?B?V0s4UWxlZlJNWUlsTHNBYTFnaTlpcmZ0Sk9OWWYxRmhMSGIvUmVQdEpCMVNU?=
 =?utf-8?B?ZnJmT3NjMlJjd3dsNVZNL1pmaWVHemNGK3FJQnBuK3hNZWk4QVduVExtYUtm?=
 =?utf-8?B?NllxUkgzUE1kOU5WMjl1MTB3RFFoOTFHREhycENKbThhOE5LOHhOeWtQOElX?=
 =?utf-8?B?OHYxSncwam05MFQ1dDI3OHJJRlIrdVRYdXNUSFlud1NLZzVLT2dvN2thREpq?=
 =?utf-8?B?c2psVkZ0VDd1TkV2ZXY0RkRGVy94ZW0wcFRmbFpJalRxTGdzYlF4QTkrYzdE?=
 =?utf-8?B?RDlWOHJtTkYzNElsUnVWc1hpTW16a1dGTkN0ZWdLa05OVkNMc0FTZ3RISHly?=
 =?utf-8?B?c2M3UmRqSmpSZTVPRXI2SmhuaVlLcEFCYTVFSkhnbVY0ZFFFMjZ4OVZhZUpm?=
 =?utf-8?B?UlhIL1QxbGVtcWg2ZDlpOHpOZGJmdWZXQUZhMU9BdFQ0cHY3clI1MytiaEVT?=
 =?utf-8?B?V1IxblFtaVliTXNEcklzZ2YxODN5MThyQS9rT3dRaUpqa1lWTGRmRS9jMFhv?=
 =?utf-8?B?RGdrcno0YlJaSDRKRXAybWxqUUxnQUZ6K2R3VzJPcWZNQXVrWFhCQXJKUjNz?=
 =?utf-8?B?enh5M0VJeHhuY2dsWlgwY3ZKb2h5V1cwbDdMV2Zod01sSk9DbENRbGpUamxw?=
 =?utf-8?B?bzNYLzNGbHRxbW9ka1lMRG10WExqL0g3NnJ1NTNHdXgwY2RFb21EcjIzeWNQ?=
 =?utf-8?B?c2pEb2dUdVZRQ2FIZDRmSU52dzJqQXBTODZBSG1sUTJ3MnVKUHBoVEh6eXZk?=
 =?utf-8?B?VEJQZkNpRW9UeDhmYm5NZk5sYkdtQWx2SmxNY2lkTjFtUVRocW82NUVZUmJG?=
 =?utf-8?B?QlEvSXp2dE45V1JJWWdzL2M2ME1SaXFCaVpMS2ZQazNIcUM2aVNjckVjSnFm?=
 =?utf-8?Q?5sJx6n4YisDWxFThQizz01LKA01HTa+6+Ytl+?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 282caf19-a31e-444e-07c7-08de580db2e8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 10:21:39.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+AR/2ZdGQBCIhbKq329beuOE9+LKw9bebV38KQxcmSynYyXb5Dw5Wa+kIkvDFQhK4BZ0VbKt24Kp4c2hRcYgOBDykmEwhSEfnzUwdncmm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210475-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sntech.de,gmail.com,kernel.org,oracle.com,rock-chips.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[cherry.de,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[cherry.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,u-boot.org:url]
X-Rspamd-Queue-Id: EE8444C411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heiko,

On 1/20/26 9:55 AM, Heiko Stuebner wrote:
> Am Dienstag, 20. Januar 2026, 02:39:28 Mitteleuropäische Normalzeit schrieb Shawn Lin:
>> 在 2026/01/19 星期一 17:22, Alexey Charkov 写道:
>>> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
>>> UFS device, which can operate either in a hardware controlled mode or as a
>>> GPIO pin.
>>>
>>
>> It's the only one 1.2V IO could be used on RK3576 to reset ufs devices,
>> except ufs refclk. So it's a dedicated pin for sure if using ufs, that's
>> why we put it into rk3576.dtsi.
>>
>>> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
>>> hardware controlled mode if it uses UFS to load the next boot stage.
>>>
>>
>> ROM code could be specific, but the linux/loader driver is compatible，
>> so for the coming SoCs, with more 1.2V IO could be used, it's more
>> flexible to use gpio-based instead of hardware controlled(of course,
>> move reset pinctrl settings into board dts).
>>
>>> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
>>> device reset, request the required pin config explicitly.
>>>
>>> This doesn't appear to affect Linux, but it does affect U-boot:
>>>
>>
>> IIUC, it's more or less a fix for loader, more precisely U-boot here?
>> I'm not entirely certain about the handling here, is it standard
>> convention to add a fixes tag in this context?
> 
> Yes, a fixes tag is warranted here, in Linux it "only" fixes a potential
> issue due to the mismatch between pinconfig and gpio during probe.
> 
> nce this patch then enters the kernel, it can be cherry-picked to
> the current u-boot development cycle. I don't think u-boot is doing
> stable releases though, so U-Boot will only profit for the next
> version where this is included.
> 

U-Boot only takes what's in devicetree-rebasing 
(https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git), 
so only from Linus's tree AFAICT. C.f. 
https://docs.u-boot.org/en/latest/develop/process.html#resyncing-of-the-device-tree-subtree 
and 
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing. 
See also OF_UPSTREAM Kconfig symbol in U-Boot.

This policy does make adding support for a new board quite slow as we 
may need to wait months before it makes it to Linus's tree, and then go 
through the development cycle in U-Boot which can also take a few months 
if the timing is unfortunate. For now it seems like we're sticking with 
this policy to avoid too much in "downstream" DT in U-Boot. I know we 
push for this aggressively for new Rockchip boards and SoCs, cannot say 
for other vendors.

Cheers,
Quentin

