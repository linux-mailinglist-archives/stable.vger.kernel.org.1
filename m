Return-Path: <stable+bounces-210508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KnSCbh4cWkJHwAAu9opvQ
	(envelope-from <stable+bounces-210508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 02:09:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A8860309
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 02:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DAD84BA13
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0A42EED0;
	Tue, 20 Jan 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="bZrGnh7A"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730513491F6;
	Tue, 20 Jan 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914023; cv=fail; b=Q1G9VbrVAB23va5SPCYCoKShI4Y91RbfD0FI7I94cKGVdQSGob2sEKL748jH43LZvFzoXxcM50AkO6fYvm2WFJGKosmIMorz4xyX0ykfXf+qcE8UjF6eE3jt9z5ccJ2bNXpywM0GVWMrp0Ijg+iqCnBs1XBZtG7AJr/FW2mf1Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914023; c=relaxed/simple;
	bh=93Dg9QSaTcxveAd3WqxliUG/s5mS5kIOUJMSIPvewjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kb6opTnc2e13sdgPqAp8g132LsxqqTSqNd4kSgY3hBpBu3oZ0Gfd2cVqckIGlgjUw5uicTDMNHp5rSnouU7RA0d0gu349gNrOQD20kMWyRy73xMv+XQ8nh9bRqxCPx5jrNlb+DFcQSbfYZfMVwvU5WqRRA4A1DqMrEXuB5gL17M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=bZrGnh7A; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1tFNqvwGfJYdF9v74eXgaB8PS4sL7TpLH6AzVgeY2NjEaHNhFtc4SXOC3DyLkr8+2xHo7wfvnSNE30smuf90AWsL68GT3vrc/vx+GikgLeZjag2cbBbiisFMO78Ab3GFNtRAf3eXiJLOiEXx03ksHBoQ9YLd5SMhjLVF0nOF6ufTp08hBsssZCZgpyPs2ertLfGFrdtjvMpt+TU3EVMJlfOWX9YChiRRJR4hK2ppHon7J0EdaAC1Y4JI0zwHrNAHx8wGSPUnWcUtfsEzlJAaNmVkf07FCPR1RjO6FhLV33trTrDlccrbpX+TJaTQrOrFqD4Qvm93mTvzWQ14GwwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P80mk+3tBLY3havWD+ldypv+EDdwFceUlLAM6c1pBnw=;
 b=ODAIJzOVfXzGyIySajWw/I44RhPt+86/M0iqcKMD27oYWKsrajeoqEpw06ujtRRjSe3U80Oq/ZjnrI5vlB0Ue273hZ3peMZuscl3501eePLyU5NzncdQ4y1DQVMsBeLd94dUM3G3cfszV3dYLM5VEPSiVFxROhYGzhPPWLR4QBIl4KSTJwJYy7DM6k763x2ity3MFhQuUzPxWi8TSMGs99ADncRJRkSAgfaoxh3Q/egzPptAOtfKzBX69KM0BYGjk7rSf5ZSqB7Wl/sgUH8I94Rq1/6m7wFmVcfpbVNJ0+ouyBC4OiMBDmkEsF8yQ57X40fnqkZDnHQwPae1YG6Ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P80mk+3tBLY3havWD+ldypv+EDdwFceUlLAM6c1pBnw=;
 b=bZrGnh7AEAojjDMaW8bP+yF22/XF34/Vt6nAo9QXe37637jexATkamki6M5L8lLTeaiu7B0+GpKlh+OmIbSGaFyxcDS1DSWldp3FqyigtGzcfH9EAzfK48WbncLg/Xabfj0NxWVw+I9AZH4P90kEjDFdlCavDSiqeNSGLXmH2i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:00:14 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 13:00:14 +0000
Message-ID: <9e51b504-e0f0-4d17-baa2-387339507c86@cherry.de>
Date: Tue, 20 Jan 2026 13:59:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Explicitly request UFS reset pin
 on RK3576
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cc1f95-e2cd-494b-6a4f-08de5823da24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVpN3FJTnFiV3JKVXFyNmhMQjZQNk1sdFNHdXhNb2hLWnYzQkkyOVpHMWpR?=
 =?utf-8?B?Y3RmbHRIVE1oOFRFanBra0RsaFl5SXVxanBzTjBpNklnanZhNzBHTWo1RU9S?=
 =?utf-8?B?SktiVUZSNDBFZXRyakhBUUxUeDBZUzYrOFdCZ1hNRTVwcmFHM3JPTGhHbGwx?=
 =?utf-8?B?dVozSUt5bVFNbW82N0piWTdkVFJodWYva1Izb21CMGNrbWlsRDZLZmhIMHlp?=
 =?utf-8?B?RjNuVVJSV1d1OGZ6MFZzcWdpUExCK1FkZ2lDLzFWUVZhY1gvbHcrd1JNWUhM?=
 =?utf-8?B?dDc1UkhZVVkvbU9zRmJXVUN5NjErN3pFbjBBOEVoSHhOQXJkMTBmcUQyN3NN?=
 =?utf-8?B?NTAxdHpoZ0NDV0RZN3lDOG1sL0tzRVRVNWM3SG81ZDJSeDNQcFNpdW1jbHZG?=
 =?utf-8?B?MnlKcVQyN0h5WVVRREZiNzVZKzdMREVoc0o3ZUYzaXV3TnR6Mnh2RWUwZkRi?=
 =?utf-8?B?UlUxQWlUa2tsTjFjMW5GWEVGdkdwZUZGUDdLcVVWcmIxRFhOY2JKd1o1VzN2?=
 =?utf-8?B?bXY3R2c0dVg4SlNlVnU2dGw2bklDRi82VEtON3ExdG1BbkFTczdKam9aQ0Z2?=
 =?utf-8?B?VXF5YjYzQ21EMzUyMVY1MmFsaFlXTDlHZjBxSTNCaHRhZ1k1S3lEa25GNHIv?=
 =?utf-8?B?dEdsaTIyczZDZlBEMHBpbStHM21xdDYvRXhrZkN3dnBCNlRsV3NXTEQyWjFv?=
 =?utf-8?B?dG1USmkyUGx5bzhOeTBpQjJwWURwb1l2RWtJa0FuNjlpUzcwa3dOQ0taNUo0?=
 =?utf-8?B?am5xK05aL20zc2VNemVuZWgzWHVDN3JIdDVxMi9xL25PR3ZFbGZ3K3UxRDlC?=
 =?utf-8?B?NWpobmsvQWJLcHlWTElDQUFXTUQxYjRMM0p3bjJqMzQzRndodWFMM3ErdTlU?=
 =?utf-8?B?RjVXMEZ6bDBiL1lOYlhyNHVUUkV4SFB0MXp3U1hVa3hYUEpQbC9kc1BIb0VO?=
 =?utf-8?B?d2FBM21HUVdxRHRod3g4dEJPdmZsU3FUY1hqcmpacVdKcjY4aC81UThRMWtq?=
 =?utf-8?B?eVQrVlFPaWhscXFmNllWcThZNGVkMStuL3FUYkJRNyt3dERrZkhuT3JXTjFu?=
 =?utf-8?B?dDd4L1MxT0c0cFoyTklia1lMSHViMnF6MDN6VGVjNmhtcnluRU5lWFpZNEFQ?=
 =?utf-8?B?RGhMeWcyejd4RUlkYm5TMjI4bEZ6VUNEMFB4K2tmU3lFZTd2aGFWTWxXNis5?=
 =?utf-8?B?STE5WWlKZ0dFNnpiaVdqMzA2MVE0VGQvU0duZFFhRnV1RkVtL25Zb2dPYVZH?=
 =?utf-8?B?cERScVF5SkozcFkzQXE0M0FrN0kyWk8ybmI3NldMYzRuYjduTUJVRVAzaFJD?=
 =?utf-8?B?dFlqOExDRG5GZW1CbnhuUEI5ak91aGlFMDRWVC80MzZScTU0QUVMRzU1U1hF?=
 =?utf-8?B?Sk5CNXlDeHBLdjdIZjhOY1Njb2w5VkZRQ09pY0JXTk90ZHcrNjExM014aWp2?=
 =?utf-8?B?OGtUOXoxNFNSVmFQVjE3SktYNWpmQS92MTVTTVhwTy8rTmUyK01BOWpaMHBh?=
 =?utf-8?B?NFBUekEzNFBWeG9FSXlMVzNuNW96TWllZ1NHclI1Ums0SUJHcnBlaEwyMk9Y?=
 =?utf-8?B?UEdpbjhwVStCVnJ3SFF1TVRjdXYrdGthUkpwSytDUUpZZEg5c0p3N0hOSlFV?=
 =?utf-8?B?VzRSUVdoSHBEaXVkUVlqaDl0d1JId2VwcUZEN0loVTFMTWF6UTFPTSsrM3Nk?=
 =?utf-8?B?ZDB5WEJ2ZnBjZEc4MTRsSWtBSVBzUmd1Z2tDMDFXcEd3WDRkUlNpSGdhRmZY?=
 =?utf-8?B?dW1xekduTThTMTJ4SDFzU1o1OUhRbGIzMldXaFlNVzJiczBjTW9UQVdPQjVE?=
 =?utf-8?B?Qy93ZWM4WGJLZUszMXluV0Q4M3JVZkp4UmxTVXZVUU1SM0dhdnA5VG1udHRR?=
 =?utf-8?B?anJIRDQrYUhibHFCdHRGeWZhRDJ3Sm90cXVyTnh6SmpVM28zUXNKRENHYTdQ?=
 =?utf-8?B?Tm5SM3kxOTU5K0hoNEE1blFlYnRnSXNzTjNKYzdmNUg3Wm1rNmkvM0twYk1G?=
 =?utf-8?B?MHVWZ1JmS2Q1eTdkaXJtT3IzNXVVdHR6cUhQcDZDOC85SVNwcXZWd056MkFm?=
 =?utf-8?B?dGUxcG9VNDZSWGFOajFoMUZnZzBtNHRycFVtUzh0OWxTWFRteUFFZUZyNGQx?=
 =?utf-8?Q?/iss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUQxSDZ2STRNeDR1VCtjNFNHSDhuTzdPZUwwL3lwM0NabTM1dks2NTlFSEd2?=
 =?utf-8?B?akFRYkhxUnR0UFIwbG1zeGZDN1ZvVlJFZElOU0tVSUlQL3hMd2lrKysvSVJT?=
 =?utf-8?B?UWh1WGp3TnNERWVzK3o4bldZV0NneWtOQ0ZuR2luYjMzSVo1RVBlMU5hd2hM?=
 =?utf-8?B?eXlva2lZMWh5MVFHOSsvNHZ1UnJUZnFydXpmbDNUQ0paRzZDaWw0U2xqQmh2?=
 =?utf-8?B?aEJNbUlSQ1Fjc2lCU0FLTnJac1ZyU3hudVdnKzlHWlpNeXFtM0lCRDRpY2cv?=
 =?utf-8?B?NnJKcDhzbCt3emR0eDU5U3hycjNRQ0tZckg3UkRuLzZyY3BkUitoSVRKYVRp?=
 =?utf-8?B?L0k4K0ZsaFFJWEp2L2JEYi9xT2t6RXdXL0RnZUVpTHNsYXJLN3lrMGRQRDBB?=
 =?utf-8?B?RlYwdDFtVG9MQjNCeU5NZGZDdVl4NFpvdCtKS3dKRDQxdTdxNUZUUUthcEJk?=
 =?utf-8?B?cTlxb1k1YVlNaXdRYkRLSE9EWTYrTU1KZnhpdkVBSnJWeks5alhDNlYvMkxX?=
 =?utf-8?B?RWw2Z0NQSzRXSDV4Tnp2MENIb0FXQi85L01oSXBhaW5uVjBjSk8zMjErYSto?=
 =?utf-8?B?VTVxVXk3U3hKU2RLNnlMMUxGL1hPZjRaZC9EcUxtbzhTVDF4c1FHQ2hNaHpp?=
 =?utf-8?B?bXB4b25XeVFVcGlEK1RjOE54dy9DT1JMQ0ZUdWo3djl2SDhMS1hDQlZyT2NI?=
 =?utf-8?B?eHVaOXVrN1lYaEhMbWYrR1BFTEtqUndaRmpPajQ4Y3NwTm05MXliVmdIZ2dP?=
 =?utf-8?B?YVhibHJvVXVxdWsyUVZEWEdJeEhtT2Z1eGovbkJoUjMyK2RxMnZGMDdBSncv?=
 =?utf-8?B?MjVhUGFwMkhJYUkrZ2ltK2x0Qi9NcVVUK0pudGVhWnA5bGtHRCt2VndCVFZ0?=
 =?utf-8?B?bjRpaGVrTmt2WWRZY1dPbTVjU245YU9vT1B1YS9GbVhtTDBFVitDT09KT3VB?=
 =?utf-8?B?NkdPZmtSSEdiWGNtRUZWNWtTaEZzaEpZbnplTnFHeFZyWFFLenlzbHVuTXdP?=
 =?utf-8?B?WXBZeTFSNzM3TlVGYnRvWlluaWhWSUdTa2N3RzU3a2dmajlYS01UWHEvTUd3?=
 =?utf-8?B?enZHczlMa0ZoM3dVNVVGZE5XOFMrMFcxTEplVUN1V2pWSTNMZXkxS2R3Wk5Y?=
 =?utf-8?B?ZXpBMFM2NXBlaHhCK2ZIb3dNQ05EVVRDcnFBKy9HWUg1VG96T3IzSG1QUmM5?=
 =?utf-8?B?SmgrL1RHSHVRT01vTWNWc21vaVdyc0hjUmdVUlZ4YmNTSWtXYjBLdG85TkJp?=
 =?utf-8?B?OG4wNDJHZWRIM3dVU3dPbzBPWWIyaHdYUmhoaXJOZVMxTTRRcDBKU1hCUkVU?=
 =?utf-8?B?d012bWJXaCt0WGZlcGxIdE5NVE9IM1VCRnVQRmxnZlF3c2NtemJXckdBUXVE?=
 =?utf-8?B?NTJNaVRQMW5Pci90RXdmaHAwQzNsZmFPanYyekJ0Z1gwVUVEcnRqV3NVTmtW?=
 =?utf-8?B?STNtWWl1UytGbm9BeS9DRVovQ0JqSDdwenp6QnZqaHpSTHl1M1ZwU1FrQzlv?=
 =?utf-8?B?ZnFlOFNSekRXTTBJVjVpaEdLNGpuaVRuRGZ0bmV5TG90QmRoTEVySE5pRXFM?=
 =?utf-8?B?a1FYazhrSnk5UmpjRXpMZlBYamkxMUZlY1dNYWt1NTRsTDZpNzlSd1ZFa1Ew?=
 =?utf-8?B?UGtjVGlJcE50aDBUdW5IdFFpWk5WdnZoMllJRXJaRUY5WFZUS3hmVUp6bHMv?=
 =?utf-8?B?Y3gvOUNaSHVFTjN2c0ZqbUhiQis0VVB2TEl0NHNhQml3Q0ZHNS9QdWx0NXlB?=
 =?utf-8?B?dWwycldxbUVqYVdZOFBPa0xGc2FXOUtIaTBhQkc2VndBS3paK1dtb0JLM28w?=
 =?utf-8?B?YWZsQVZUZzlrZ3pVQUFOZG1Qb05qS3cyaHVGeEtiZVpZc0xRUGVqS3ZmOVp3?=
 =?utf-8?B?Y2lYeU5kbmpjRUN4dVpaQkpvell4SHF4YTc4NWNjcVVSNURCVStWR3pHQ1JW?=
 =?utf-8?B?ZXVkLzlucEVUK2VkT1RhZHJJL3dNQy9BMHd1ZFBMeDc5UExXa3pHNGxYSGxw?=
 =?utf-8?B?UHdHU0lhRk9NUTdkbFpHNGNZcW9CMXFPNThsSmxkd3BYbjN0WjRXcE56ek9n?=
 =?utf-8?B?Q2JGbms0VTROMDJFeUw1TWhrYWpaaFFxaEprZ0N1QkdYMlkvcGFQQ29mNm5v?=
 =?utf-8?B?UWpKTW50WjNqaDdpdmVJNTZqNVNuNmVPNnE4VnNhZm8wTGZ4cGRNMHdjZmN2?=
 =?utf-8?B?V3dPZ29BM0w1TGZVVDl0NmExU2FCVk9DTkRydzJZckQwRVVPQnRnQWV3VGlU?=
 =?utf-8?B?aExrM0M5cy9YQXpyRSs5MXVraDBVcEd6aFJTR0dab2RVdVh6T3NVOXJOMDA1?=
 =?utf-8?B?VWZzdTd4N2dVUEhQcXpkaS84WnQxMEFMWUpNemNPdnR2Z1JFQUNDQ3ZYalY2?=
 =?utf-8?Q?gydfpqfL9uNoDa8L7rcrbVgEa3qJUOzcia0Ws?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cc1f95-e2cd-494b-6a4f-08de5823da24
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:00:14.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlDXGu9wXfpA72deWd965Wr4rfeC9/3HSV0u2nWW5MXbCu1xH+qZRqiOp8AeeA7snJGvhi+21AIGlf1gjfy5q9xDixyjunxWzK3IkoAPcvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[36];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210508-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,sntech.de,oracle.com,rock-chips.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[cherry.de,quarantine];
	DKIM_TRACE(0.00)[cherry.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 68A8860309
X-Rspamd-Action: no action

Hi Alexey,

On 1/20/26 1:53 PM, Alexey Charkov wrote:
> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
> UFS device, which can operate either in a hardware controlled mode or as a
> GPIO pin.
> 
> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> hardware controlled mode if it uses UFS to load the next boot stage.
> 
> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> device reset, request the required pin config explicitly.
> 
> This doesn't appear to affect Linux, but it does affect U-boot:
> 
> Before:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ... >
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> 
> After:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ...>
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000010 00000000 00000000 00000000  ................
> 
> (0x2604b398 is the respective pin mux register, with its BIT0 driving the
> mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)
> 
> This helps ensure that GPIO-driven device reset actually fires when the
> system requests it, not when whatever black box magic inside the UFSHC
> decides to reset the flash chip.
> 

Would have liked a mention on why pull-down in the commit log.

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

