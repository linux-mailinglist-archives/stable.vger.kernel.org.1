Return-Path: <stable+bounces-123219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567D2A5C325
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A567A5304
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12E25A348;
	Tue, 11 Mar 2025 14:00:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A625A331
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701632; cv=fail; b=Kr8W8sppjJQR+38KR/LtNglInWUREcnUCGaPwNYBD0J8hwUjYFXMQrV5WOEksCzO7bM2EEQz2Gz6kP48Xnib0m1TusQaF7na3whFUbqo3WSZFoIvuNXVsTqew+XdlAfaiSrekirqkziDm5X62PHH1fPmoMLa23C4qyaT5T57ktg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701632; c=relaxed/simple;
	bh=xAWvGBh0Z4dQpAx9GgowH1YghZVgwWlS4aMyGIhCXSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FLaaHaKC85ndfYLIAkwWc5KfftIo3j2XtalGLaGEEhHRMzdljNeBFqQ19Kxo9Aj1rfydRkQ2AE6hg2cwfnBY1lyiCgsn4hphWowT/Nn1/Pb355SpRKLPL9eKlH/QVf1j88rjW3q+VMMA0FLcxMTB2Nll5P3QrQzBypTiUTTR0+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B5dJs0017999;
	Tue, 11 Mar 2025 07:00:17 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458j27b8uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 07:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7dMlUwks21YU/C+rI8NxG0a6PoaEMaTtHuzKXYYq6a2qKbKx7XN9mTUSnTAj1NS2jt9Wsw6eFDwQfG81POo6NQXSvDeRp9Ssknl/J+xDN6KbmsrAtuew9AQhGB4OP1FSxeYCLqKEJtd5wRIfeoU0BtUKQG41qlfwgd4bxPPc4lpjJGj0WTZR08krSeF23xZSW7wteG1LFV6yKktvXgzEP0vLYZ0n1DkPWOl6zACf1u0D5yo70jAnvKVnjM/f81DDo16i1LTTIEIcNEdk+EhfHq7pNNQIYjdoYRuKU74Slf7AzMOP7+d82vcPcJeymlCiXV3mzwXtXLeIEpj/qkLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MDMkqKcqOocIY2Pytl4RGZzJZMW7DNIT8b8RlhTvJg=;
 b=RMzPLH/V8hZeJmgDy26jpcz/y/TcQ09pijpMlkVvr2Z2zej2wdJAXCDIDzjnTGwa3XlEwua2/Lq/2rPB+lvRAEj6oIQBMU+bn6ucvkSIcVqtQAsbs3br7bwOmNR7xCQYJDMf8XtzGhhd/YmQar6Di7dFBfxBnaH7KhpwkCoclLZfThfE/vYoafYpW6JmNjb7Sqt1EjhJmeQTP5YglKWn669h+ztx0jCNAsPhKNe95wZLTj7EannnR+kSK52wR/CB7KxZkMbhzgX++82PFzQScW8H48z76IYxLi/Svi4lw3gMwUwT1zz6mBtRd5RfVZAV5yNCvwqxXYRfilgjNVFJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:00:13 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 14:00:13 +0000
Message-ID: <f5638ac5-e9c6-4c3e-8c20-823e0267ba92@windriver.com>
Date: Tue, 11 Mar 2025 22:00:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag
 for Marvell CN96XX/CN10XXX boards
To: Bo <bo@joymail.io>
Cc: stable@vger.kernel.org
References: <20250311054240.3246843-1-Bo.Sun.CN@windriver.com>
 <20250311054240.3246843-2-Bo.Sun.CN@windriver.com>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <20250311054240.3246843-2-Bo.Sun.CN@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|CH0PR11MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 78645c36-e9ff-4f0d-57d5-08dd60a50aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2JxWThTOVZKWlIyS1ZBT3B5Qlh1aUlCMWV5NGZhbitBSlFERTJGSlh5UnUz?=
 =?utf-8?B?ZkFBTWZXS3RXZVRwK1p1MDdXT3BkVE8zUTZUM1h5eS9TcXN4MzRMdTJ5cUxy?=
 =?utf-8?B?bFhiaFFvUmR6L3JZaW4xZ01xdXdzdTJhcExZS0s4ZjN5K0dic211eC9WSTZx?=
 =?utf-8?B?b1NKc1RnQ3VIUjZDdGdodGtJMHpwaFJvU1B3aVVONnBnTW1PeXNkZVFoYW1a?=
 =?utf-8?B?ZzlRM3JKdFE0VDRUcWdZQUMxaDFUYlhtbkR6SWVOMlRaUEM4OVdGbnJSV3FM?=
 =?utf-8?B?ckFuWkczWUhjNkVUVk8vK2lLY3FzU1hFT1V1MlByMVcvMVFVSlNmWWZMNWY5?=
 =?utf-8?B?M3preUp6MXpkNDJJY1ViRTRYQmJIb0Y2SGdBbnpyUnNMNjdBb2lsbUgxbjRC?=
 =?utf-8?B?ZitTdjAySVRJaTJiaWQ3Wlozb0VxRUlFNURySUU0VktUSHo4angzVHJIRWg5?=
 =?utf-8?B?NDZtSm1OKzJjVzcrRVVkQzJJbVI1MUh2ZWc2SXRpUVZVYjNFbzRSRWM3Y2JF?=
 =?utf-8?B?MmEwVEJxR0FpaHJzTXU4YVdvVDVLVHNpUVJVb0VZYkNCS1BQaHIva2FuWUNS?=
 =?utf-8?B?aTJRbk9sRmZsVU5jY2hGSDhOcjJHRHVaSjJmNUxzSnhPd05KUFYzRlhiUmp5?=
 =?utf-8?B?M0JlYzZET2VVUUNPWE8wT1lqRE9keXNtNW1rNEN2S1VVa2tXYVAva1FacE9M?=
 =?utf-8?B?ZmZpdmNndVl4WGZvaCtGMGFSK2tuQkdEYlVTQkk2a3NRZTJocGdML0ZvTW5a?=
 =?utf-8?B?akR4aHkvSm0vVzFXRjBobVRFeTcwaUFhSnhsRllVdWZ4UlJiNUQwS2p5em5m?=
 =?utf-8?B?SWVQb0RFTHJ0ZU9VK3k5cVNnejFHeklHOE10VlZHN3ZFVlk1NG4yMEhHT0FU?=
 =?utf-8?B?V0phV1lIcWNxT1FRcXRacVplU1ZSWTNaSDRaendrczYySUwrd0RSUDR3c3c5?=
 =?utf-8?B?RUw2dnZ4L2lQOGZHMFEzemhYT1dJa2xSakRaTE54UG80UnhleFcwdnJxVmV3?=
 =?utf-8?B?UGNaTVZrRFZQUStTS1FxR1FNQWdPU2phZzlBMGZOaVFIOURScm8xSkJ1ZlpN?=
 =?utf-8?B?OUMxUzQ4MUZTYVdjNCtoSytlOTBIak9aZG9UZU5HcXdncWMvTnFpSFZxczM1?=
 =?utf-8?B?NnNSalZseGY0QVpiT0hiaFFOR2puL2kwSlN0QkhUdmVNSWoyRmI5UWd5S0lN?=
 =?utf-8?B?alVjUnFyUUFYV0ppYmRhY0RJRzQzV2lHZC9rWjlDak1QRE54WDJ2MVErNTJt?=
 =?utf-8?B?VlNJSkE0VnpaWmg0MjlyL1d4S2dZM3NVbFluUE81SWVoYmxBZFdqU0JqWEN4?=
 =?utf-8?B?d2FSdTVkczMxVUt1K3FpWDJZd0RtV2hENmtxdzVibXRGbGpaU0lEV1ZaOEpC?=
 =?utf-8?B?dUxuMFRKZjlLTzNGY3oxOEc0enRwWjlmdVFqSE5nM25HZ1F6cm5qdUVLV0dR?=
 =?utf-8?B?WE4xczJ3U1FRaXlBeXdYTFBCWGl0SkcwVmJkWTBrNVFNSVZyMHlEd0lTNm91?=
 =?utf-8?B?QjNsdCtzRGFNVUh5N3lzN1FQVE5mNFUzOHdGdTNwamVGUmxzNmp4WS9WMlEv?=
 =?utf-8?B?NzVRakVIRjhaVWRKMko1eEdsM2g0RStBcWtZNCs5TUQxSCtQNlRQWUE0d041?=
 =?utf-8?B?cFdiTlpIamRoUWYvOWIvcVdieDhPeENwYW15NlFTc2FzOU1wSDZXejRUZ3Qz?=
 =?utf-8?B?K1VrSGhObFdtU0VSUWtFUkZ3WGFVOEJkL1ozbUpXTi9VaUs4ZW1na1ZheGg2?=
 =?utf-8?B?Wm54VUJJa2ozVktKQk5KdGNjTDZ4RW1BU1N0bGRwb1BseVRLWHJhSUNhU3NK?=
 =?utf-8?B?RlNHdmN4VnhaYkFDTER5clQ1QTJUODBPdjY1Rm1lbXdUOTJtMENHSC9TNHpW?=
 =?utf-8?Q?bokeiqFLPlelY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllncFhaTzFFTkJhMVE3RW5yT3J2RUdOT09yN3FYb0ErbDNKaldxQlFiZllZ?=
 =?utf-8?B?cHdwSzA1amRob0FKUlNNQ2RVNk96N25ha2p4ZEdpaWg1aS9UYUQ3MjhQbWp0?=
 =?utf-8?B?OGpMWFFaZm9aVjY1T1ZPZy9zeFhIL3dyQ2ZON1NiT2k5bHpMQnRSRFhLYUly?=
 =?utf-8?B?d2thZ1luZDNBTmNZMTVJSXAxeHNrNHlWY1o0QWhCK3RmYko4R204a1pNa09V?=
 =?utf-8?B?bTBvRFdFQmQzRjVsQ0JRR0EyRVNFamlwWm1Na0NTZ3ptREc1MHRlTUdOS0E1?=
 =?utf-8?B?M1NNekQ1MS9mVHZiTjVscTNTdjQyVTNlLzZ5YTUrTHRiM0pIZmpPODdZRkc3?=
 =?utf-8?B?c0JLQW5icTdNVTdNQzNRc1ltVC9sNVNxSjcyVllFdTJsZmZ4Q1h2VmduOFlS?=
 =?utf-8?B?S3JWTHFaVUN5dEdFVk9rVE9Qa3NTT3Z6dnRKSmorM0VRbm8vYjFzUkZqZ3g0?=
 =?utf-8?B?QjA0Nk1lQlpud0h3ZFZFb3o3NGNJTXFlWG9vQ2ROTWtVelFQUEkwWXZoV2V0?=
 =?utf-8?B?OUZtZFVrR2g0dmFMU2VQbldjbzZYak8zczRGcGlHaHpweDZ6SEcxOE1kelJI?=
 =?utf-8?B?K25mQjFDMzRhaHlCN0tBcjRnM0lMOHh6QnFFWXFvZlRsa25CMXcxenhWK0to?=
 =?utf-8?B?OFBMKzhEMTFxQkxYV25TeXpJOFdURExQeGNrS3kwa1BoejE5c0JmOXpHZTFL?=
 =?utf-8?B?SCtqcGpqNzlHZDFiTUZSYmpPN1BLUkNjTFdOSnNGUlpJSFo5TUZURytqRWpt?=
 =?utf-8?B?TXRCc05zVHVFd2p3eEIwaCtweGNNSE1VYjdiSm1KL2lNclZMWko0Mi9LUnFy?=
 =?utf-8?B?ZUVQOFhIMy81ZmZ6bW5HNDcxUXBSMm9PT3hiRndoS0UzTisvdzhuMDdCT05r?=
 =?utf-8?B?N3FHYlVrN3BHeHIwWE8yOE5TTjBYTWF5aTZSRFRqQzQ3aVFzQmhjeDZnb2x2?=
 =?utf-8?B?NWdrcFhjdk9JNU9MREFrYXVHTjEvMGxDMDBPMEdBdWRJTEMvOU9MOW93azFB?=
 =?utf-8?B?SjJxQzJuMDQrb29TY2QwcXhneUQrZUVVU1FmRCtGeUlvc1dJNjgwNnpHYjJj?=
 =?utf-8?B?SXVmU0Z6ZmlMN3FKZFdhNEMxUExPOURkTGcwejFGRHNGTVdlaEhWdkpBWVNM?=
 =?utf-8?B?bWk3WGV1bittaTczRU5KM3FrMjd0bkJ6VDdlaGd6ZUwxdFBuSytWWVhFQ2hO?=
 =?utf-8?B?c0JWUW9GWTBuUUNRdkg1VWMvdk9QaVNQeitHSTU0ei9PNHljdFJDMVYyRmZz?=
 =?utf-8?B?eXNOZFVpRzBlM1hnVnZLZFhPOG82VGEzdXJLSnRabzJ1WEVlOU5zamM2TTUw?=
 =?utf-8?B?bE00RlJxTVVDNyttU2d2M3N1SnkxWlRUc29tdGhlYSt5cmRTSWdNYVpLTnR0?=
 =?utf-8?B?cnEzZ0VYREZ4ZWxZeHJwMDZxK1ZreElUMlBNNTRsb1N2QmhkODVlWWI0UEp4?=
 =?utf-8?B?S2pPUGFYdkIyV21PS1lwTURKWmIraHlmeUtnTXZlQUNwRlhCZ2w1L1Qva2pl?=
 =?utf-8?B?SWNMa0JodTdibkF6dGc0NFV0a2ZZQ3ZhczlxVDdGeURoZkFkMjVlL3NIWjhz?=
 =?utf-8?B?Rzlnc0FuUGxSZnYxS1hDTWRNaCt2UzV5ZkdKMWdWdkJCbUUrTW1BUkdkWEZY?=
 =?utf-8?B?MEpPY3R2WU0reWZjb2JNQ0FRZVVMeGJxVTdDY2ZJYXJUQ2RXZU4rQUJUREo2?=
 =?utf-8?B?b2dYcTNsbHVuMS9pZFJjc0lQTEZyVkNybEYxK2p6NTVzOUdiakNkNkxucG1Y?=
 =?utf-8?B?TUY3RkdSQTU3TnpNcUpxdk1NaW9mMjdrdmJhbFJ0a201Qm40VWU3Vm4xL2tK?=
 =?utf-8?B?eWFhRkRqRkRJT0V4QkI2RWRvREVibGNYSlE5V1lnVWIzd0NCUFhkZU82OEFV?=
 =?utf-8?B?blFPeXNFc2JiUzRrUmJvYXI2RWFkWm9EZlZ3dzRqaEhEbXM2Y1FheFNDaUY5?=
 =?utf-8?B?QTJjYks4QkVQeU12YjFsZzR3bm51WTFpd2NidTNoMnZEajNJK2JpZGFRakpn?=
 =?utf-8?B?M1lSelYyUmc3dXZZSUFUVCt4ZSt0K1UrKzlZd3VnK0ZQS2dMdmgxRTRZeUdk?=
 =?utf-8?B?bUNLcXFuYjFmbXI1MjB6dVJBSVFnVVh1T2RsODd4citlVWc4QytNUFBKS0I3?=
 =?utf-8?B?K1Y1WGwrWUt0NmlaaDVrcU5lekdxYWMzVTFOK3dmR1FJSk5OK1RXN0dOY2d3?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78645c36-e9ff-4f0d-57d5-08dd60a50aa3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:00:12.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Qe7DWkqoGKIJkMc2Z563f9I9ZBmqhjVGic8GMOa1KhbkjdMvVtpcm7IbP+5rUMsFwHm5FJHon9QSOlbC7s/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284
X-Proofpoint-ORIG-GUID: os2kLF7sMWh_PuzQ7Ps5Gz4eKVFEVV9f
X-Authority-Analysis: v=2.4 cv=WNuFXmsR c=1 sm=1 tr=0 ts=67d041f1 cx=c_pps a=F7QtyTBSWJEVkVFduP+sHw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=uIYeJafkmubIaOOQyfEA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: os2kLF7sMWh_PuzQ7Ps5Gz4eKVFEVV9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2503110089

On 3/11/25 1:42 PM, Bo Sun wrote:
> ---8<---
> Changes in v2:
>   - Added explicit comment about the quirk, as requested by Mani.
>   - Made commit message more clear, as requested by Bjorn.
> ---8<---
> 
> On our Marvell OCTEON CN96XX board, we observed the following panic on
> the latest kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> CPU: 22 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6 #20
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> pc : of_pci_add_properties+0x278/0x4c8
> Call trace:
>   of_pci_add_properties+0x278/0x4c8 (P)
>   of_pci_make_dev_node+0xe0/0x158
>   pci_bus_add_device+0x158/0x228
>   pci_bus_add_devices+0x40/0x98
>   pci_host_probe+0x94/0x118
>   pci_host_common_probe+0x130/0x1b0
>   platform_probe+0x70/0xf0
> 
> The dmesg logs indicated that the PCI bridge was scanning with an invalid bus range:
>   pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
>   pci_bus 0002:00: root bus resource [bus 00-ff]
>   pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
>   pci 0002:00:01.0: scanning [bus fa-fa] behind bridge, pass 0
>   pci 0002:00:02.0: scanning [bus fb-fb] behind bridge, pass 0
>   pci 0002:00:03.0: scanning [bus fc-fc] behind bridge, pass 0
>   pci 0002:00:04.0: scanning [bus fd-fd] behind bridge, pass 0
>   pci 0002:00:05.0: scanning [bus fe-fe] behind bridge, pass 0
>   pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
>   pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
>   pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>   pci 0002:00:08.0: scanning [bus 01-01] behind bridge, pass 0
>   pci 0002:00:09.0: scanning [bus 02-02] behind bridge, pass 0
>   pci 0002:00:0a.0: scanning [bus 03-03] behind bridge, pass 0
>   pci 0002:00:0b.0: scanning [bus 04-04] behind bridge, pass 0
>   pci 0002:00:0c.0: scanning [bus 05-05] behind bridge, pass 0
>   pci 0002:00:0d.0: scanning [bus 06-06] behind bridge, pass 0
>   pci 0002:00:0e.0: scanning [bus 07-07] behind bridge, pass 0
>   pci 0002:00:0f.0: scanning [bus 08-08] behind bridge, pass 0
> 
> This regression was introduced by commit 7246a4520b4b ("PCI: Use
> preserve_config in place of pci_flags"). On our board, the 0002:00:07.0
> bridge is misconfigured by the bootloader. Both its secondary and
> subordinate bus numbers are initialized to 0, while its fixed secondary
> bus number is set to 8. However, bus number 8 is also assigned to another
> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was set
> by default when PCI_PROBE_ONLY was not enabled, ensuing that all the
> bus number for these bridges were reassigned, avoiding any conflicts.
> 
> After the change introduced in commit 7246a4520b4b, the bus numbers
> assigned by the bootloader are reused by all other bridges, except
> the misconfigured 0002:00:07.0 bridge. The kernel attempt to reconfigure
> 0002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> bootloader. However, since a pci_bus has already been allocated for
> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> 0002:00:07.0. This results in a pci bridge device without a pci_bus
> attached (pdev->subordinate == NULL). Consequently, accessing
> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
> dereference.
> 
> To summarize, we need to set the PCI_REASSIGN_ALL_BUS flag when
> PCI_PROBE_ONLY is not enabled in order to work around issue like the
> one described above.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
> ---
>   drivers/pci/quirks.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 82b21e34c545..cec58c7479e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6181,6 +6181,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>   
> +/*
> + * Quirk for Marvell CN96XX/CN10XXX boards:
> + *
> + * Adds PCI_REASSIGN_ALL_BUS unless PCI_PROBE_ONLY is set, forcing bus number
> + * reassignment to avoid conflicts caused by bootloader misconfigured PCI bridges.
> + *
> + * This resolves a regression introduced by commit 7246a4520b4b ("PCI: Use
> + * preserve_config in place of pci_flags"), which removed this behavior.
> + */
> +static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev *dev)
> +{
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_add_flags(PCI_REASSIGN_ALL_BUS);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
> +			 quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
> +
>   #ifdef CONFIG_PCIEASPM
>   /*
>    * Several Intel DG2 graphics devices advertise that they can only tolerate

Dear All,

I apologize for the oversight in my previous email, which I sent 
inadvertently. Kindly disregard the email regarding the patch.

Best regards,
Bo

