Return-Path: <stable+bounces-177699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BDB43340
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 09:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488B4188DF1A
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C32288C35;
	Thu,  4 Sep 2025 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="dgmqx+Aa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DE2877F7
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969014; cv=fail; b=fS3yoDKUn/HDtjnNcaEeF5IdbvbB7MHuHjzwuG639U2nlqsYlKiSxfZFPHBk9WRhPZQO11UsmJCgnHFaixibqjdYi19UPcDqHP7CKluas3O36eggs4v9Vb+v62sjsGxW7ujTcvE/Xn0SbwgnMZOZKB5g3a1fOptFCxvtz4SYZbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969014; c=relaxed/simple;
	bh=nbMW0EujXbiFZVKJESnAH4EHex1nNhJdO2DPjHdQ/1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HToZ/KjkVmaYPKAsAwzTsUyLL12rNoD2yBvLAY/vm/G2xXUdkgVq0hhXYIY20Fg8KdCElm88xm5U36Lj6VM3M67fR11uoKuqQyyn04lgl0y6aD5b4ZhB2nR5ZrwPX9Cv3RRDMBCaRUneT1xjm892EoNWmEhDoz3GfRnl7dZjKhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dgmqx+Aa; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5841Aeff2895354;
	Wed, 3 Sep 2025 23:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=9EWGCcYUCQKEDSQHDPMALxjBN7Dr1CnbrT1AUyAr+88=; b=
	dgmqx+AaZa/YDKzhlkMbi4Eg1ISFEY0ZO7Cc3hVhlJhyDIx5GX4RoAGobpm+NjKb
	OjWSQugGLG+Lb6yaw0W/dYuetHw8nHviqu92gQpvJph3WezuvuTgoozH2ZXiavvE
	TFzcrSaRLfFHeXTk3VFu5XRmWP7rezjtd3ylduTJ5QC7h0PCPCOUGMRlL7vyvbUj
	yBhHvDa6gBDVqckbe/tICwk7uSqZsAzn6Yjtt9GmtdvePWuGwtJwopUxXWGEad9B
	OffIkWpyNf9Xq872ovdPmKz62lqoQu778h7Xm5Asg5hMEQkmBk5zYGWAHeAOUiD2
	TBGX72pjGzlrXTfB/wZj2Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48y0u7r71y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 23:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtRpxcdC8i2h9xQ0PpEv9/Qyx+4pLHQYC8cM0ah0pwuic1KlI9TgWatRUpJgWFy3Ghr+A/WosI022XeD5OZfEKKx/xs5FnxcSbl2ROA8hWANc7N/eHN09MHrxl6elTErofKSmIxaBiqU5P+fnx39XVmmjGh+/fVr+bCgTpwcrrEZkADP0K/HjmQh82lcwpeeT/PUXSkacHD/uwNhuIFti6EOXjk2Vtk6r8N59+XMpT6ZYNQJrdfDB5rx1puEM5Wkfaork0MNBV3SkooGhgkYxx7MY+8hA8SHaZmyebTNujz6LzIiJnc/ryVEEfYUmfFCV+nPm7aHzJ/BKOAJxD0zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EWGCcYUCQKEDSQHDPMALxjBN7Dr1CnbrT1AUyAr+88=;
 b=QMDa7tiZHANXlHlTfBnJ/riD47Sgn4w4ASJypQU0FztYBHtdd+jRwvGhO2+exul3/WMiGLWj6AFd5MgHtMO74j1Dnrp7hTZt63E/PfvTcnuYRW9nDL8ckEI5XTI0t3hg9HcMHkD8ZPnDJjeRRt6cnasEMnhmgHR2Pq8kwoXVFMAKz960nnk7N96hxPFpmfJhReaJ2GqqBS0RLL7H7Ki8VTvMALH1flwI9CE6ukBxzI+IXEbyrycKTZRGWyMJ+dzox9v+SwBxCG9hSbFgdeE/lbKwpXr79IpxD6cjKcIM+EEEG1VcqP3UwjadhtFtXYwWmtAQL9uaaQ6Adub5n/z/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5533.namprd11.prod.outlook.com (2603:10b6:5:38a::7) by
 PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 06:56:36 +0000
Received: from DM4PR11MB5533.namprd11.prod.outlook.com
 ([fe80::8ce3:74f6:33ca:3dfd]) by DM4PR11MB5533.namprd11.prod.outlook.com
 ([fe80::8ce3:74f6:33ca:3dfd%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:56:36 +0000
Message-ID: <de014a11-0c2c-4022-b14c-faf01e9d76b4@windriver.com>
Date: Thu, 4 Sep 2025 14:54:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/2] Revert "spi: cadence-quadspi: fix cleanup of
 rx_chan on failure paths"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: d-gole@ti.com, ronald.wahl@legrand.com, broonie@kernel.org,
        matthew.gerlach@altera.com, khairul.anuar.romli@altera.com,
        stable@vger.kernel.org
References: <20250903075815.1034962-1-jinfeng.wang.cn@windriver.com>
 <2025090339-pursuable-gradient-4781@gregkh>
Content-Language: en-US
From: Jinfeng Wang <jinfeng.wang.cn@windriver.com>
In-Reply-To: <2025090339-pursuable-gradient-4781@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DM4PR11MB5533.namprd11.prod.outlook.com (2603:10b6:5:38a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5533:EE_|PH0PR11MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: d33031d0-3898-428b-a398-08ddeb80309a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUZoT2FtUHpvY0RJeTViZ1Z1YUNYM3V6aDMvWWlCMmwzK21PZlpIbHc0SU9B?=
 =?utf-8?B?OW4zd2JyNjdSZXplQ2hSM1p6T0lJNkhLQklMbkZUNWN0ZU9JUHhlUnRjV3E5?=
 =?utf-8?B?cW5lVWpuVHNhV2RmQWJlQTRxTzRpZkhsNDF3eUEzd1VubFlFUTMwb3dxRkhm?=
 =?utf-8?B?ekUrVmJjVWpOd3RzR1VFU2RUem83ajk4T1g5VWhPRExSam1XdTBoNUg1a3pi?=
 =?utf-8?B?VHByTWovV3FNZFNEMmI4SGpwWWsxMnplVDZtVzBBTVQxb3pzdHBiY0U3M2Zt?=
 =?utf-8?B?Y2tJdTZjRFNUa2NkYUZubDMzZy9LUjJmQk9DT0ZzaG9RbC93d1N3SkUwYTFl?=
 =?utf-8?B?U0svdHdRazhFWlZxWE1FNFNkd2YzbmZaOFNrYkJYWkJCY3J4VDRoR0NwT2ty?=
 =?utf-8?B?aUNtbnArTU5LL0VBRDdzZ3Q4S3RjY0t0eVlsem12dWJTQ1JmT3AzdzN0b2xv?=
 =?utf-8?B?UXJsc3NoczRVN2orUjltbjNRdkpGRm9RM2pYT1l6OURxNDl5VExsQXU5TDA4?=
 =?utf-8?B?aXlPenR4VWdGaTNpZ0s5aDBkUk02ME1OTkViQTRJeE40SW5NWkxxckc2ZmdB?=
 =?utf-8?B?dEtwaFVQYVNUd2cra2psdWg4MmJTVXBnVXh3a0FUMzdHZ3BWNmRVOHNjYkN4?=
 =?utf-8?B?QWlHa09EVG4xdjN5Um5OU21UeHNTSEJhOGU1VVlTKzdhVHkyWmtKUHBkVGk1?=
 =?utf-8?B?czU3SDRYS2lsK0Q0cEVpU1NqSU45cjZ2V3Brb2lDNUF4T2hRd1ljVDlBczU3?=
 =?utf-8?B?Lytwb2pIMS9aNXpMOGUrVXJkZm9tVmlqUlkvVzdaMjZXaEZBK2QwdHpUaTF5?=
 =?utf-8?B?YjVnU0tpdmtsZkRBeDZla0xtaHd6aXpBbzEwRUhSVTBOenFLdVc4ZXhuTkZq?=
 =?utf-8?B?Mk1iaVFlTjNjblNXOEIvTG93OERxRjR5bWZsVGU5YVQ5MW1yYVd4Y1RUaWhB?=
 =?utf-8?B?dkEwR3JDTTNUMmgyeTh0bjlHSGYwVmI3YmEvSlJ0Wk5hZUErcXR6R1VVenc2?=
 =?utf-8?B?Z0pEWlNZSXo4ZFY3OHdvZFB5R0JwZXBXMEI4dUFGT2dXRUhNeXhtd3RJbVl0?=
 =?utf-8?B?OHVXTjVwTjFxK05rTno2SjlJN2VNUGNML01KNmRyWjY2aEhLTzkva2UvKzAx?=
 =?utf-8?B?QktGQXlYQXNBSlZIb1BVWjVYUFd3M1IyV2hyRkgyUjFLWkgxYWswS3pZNldk?=
 =?utf-8?B?ZG1kTUc4SzFaSkNZVGdIbk1Xb0JvRG95aTlrcVJMZ2VZczI5TEhVSHV0WkdC?=
 =?utf-8?B?MUx6MkFOSE1vYVc0NU1obVVhalQzby96Z29mVzRTQ3pRZW9yc3FQakFLRVgx?=
 =?utf-8?B?czc2TG0yMDd3UWNEYm92ekx1WmNxVHhhYksvR1JWdk5wKzZqenRxdVBVTlhx?=
 =?utf-8?B?dDVURUI0UWV4bHdBaCtMcDlNOHY2VndrdXJJOWhVRmk2YktOc05qLzFpSm1r?=
 =?utf-8?B?RGdubm93MHRCb1p1bDFTZWE4ZWNzNUNPQTZ2QjlQZTFYQk5zMStDZ0V5L0hQ?=
 =?utf-8?B?U3l1c0ZCQVk5Q0dOZUdSeXdubWlYaGltQ3lSZmlBZ3o4NjN3WnRDLzNTdU5u?=
 =?utf-8?B?RXBQdThaV0RpOE5FSmowT1c5T2N4TTJVTFlXTy9uWkNiUVdpbldZdjI4SWRr?=
 =?utf-8?B?K3BTa2RYc0VxUzZ1Q2ZMUGVXam1xMjh4cUFRZTJRUmd4a3FYNWVHNmpZRlow?=
 =?utf-8?B?TDZ2UTRQRnp0MGhveUk4enh4YjRCMVJESXFmWHFoWmo5RUdVaXZPTGhWK3Yw?=
 =?utf-8?B?ZjdLMTRVMEVZekplRFNhWGJBYk5WekxBTDQza243UGZQbkh0NFI0Vjg0Qm5w?=
 =?utf-8?B?UGdqQ21wNGhBYWY0Qk95bkVEUkM2VUNWRm5BUTBORUxjSmx4M1dSN3NieDVN?=
 =?utf-8?B?cmpKL2o4MGxRd2VBbitUNTZ4NHlIbmN3OXBkcmZxTlJJT3RVUkgyTW0vK1p4?=
 =?utf-8?Q?m5hKhJmz0ic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5533.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFRKM0ZQbUNvdmN2MCszNjMvekRBTHdXQUJVMnRQU0cyUVVqNzdacEhVcjdB?=
 =?utf-8?B?QXZEYWJaWW5NMEZmSkpyNnViZWVkY2JkR2ZOQXQyTlhTeWRZRzFpUDhud3Bh?=
 =?utf-8?B?bkg1eEZFaWpVWUIvZVNOUE5rQnY0Vng5ZWpTUi9zUCt5YTUwYVRKTjVRYjdi?=
 =?utf-8?B?ei9jcVNaVzJFaVpyK2NsdWpRU1h2dHVzZUh5WE1lUzBjdGs2SC9GeFlsb2NS?=
 =?utf-8?B?YkNoNGQ3RVZnRlFVVXgrMEJJdjNsa2toWUZFVXBLNFlaeklZYjFaWkJndC83?=
 =?utf-8?B?bW5QVWc0NlA3WHhFTEdmZTd5dE4zcDdGcHJsMUR2VU50a2ZrSWZvTG5TL0lw?=
 =?utf-8?B?WWxsNHJ6ektZQ0NvanNMR3ZwWGx6UUtBV0gyYmVmcUdOR1RJT0EwdDlCL1pq?=
 =?utf-8?B?TklPejRoaW1ZSzVHU1Z6aVRwRDRFQk5iV3JuVE5haVBrY0UrZVNEaE1iSDRJ?=
 =?utf-8?B?Y05hRStEbTlKbVBJbjBXZXlQNElyQ0UzVmtiNDZDSkFRZUgwNUYvbkl4dm1J?=
 =?utf-8?B?SVRLSytsSTJwaFlRcEl5a0lTbmRTNmJrdnVpaUdHc1hQTjdGVmt0L3psK2ll?=
 =?utf-8?B?L0dlYWg2Q2dkS3lPQnUvV3dxdmlTc1dMU0VCRFpwUmJVTmRYMHYxM2tXczZC?=
 =?utf-8?B?V3RTRVRnakQ4TkNGRlM0MTBoZWoxNm5MYjZLUjhmaGFzSVREd0VzVlphbHVw?=
 =?utf-8?B?YU9QcExnQmZoODl0aXhnWmdCeFMvaVBVWk05TXJ4eFU0NjljL2wrL2s5aVJk?=
 =?utf-8?B?c0lOR01BTVBtdkl6UXZhNVpVVXk0eGdQUmVzbHhZU21keHNjZUdLMmdEemM5?=
 =?utf-8?B?M2dhYUhSMlc1d2lFSlVrb2NvWFpnWTNCTWFHdnRLYnNjaWNnNnR5QTZna2gy?=
 =?utf-8?B?Mkt6WXRLQWVVTlcvZGg1UzNQNjQ1dXg0cFRRVnZSN2draHhKMyt6NkVybDg3?=
 =?utf-8?B?eWdxZHQzZWtZQ3RFbDk2U1FodURabVNkb1BSdWdlY0ZVSjNtNTNtcjlMMFZ6?=
 =?utf-8?B?NDlwRFEzZHR2WlNuYktJT3YySFovZTRXWExYb2d0RnRXQWJZY28zSHF3VnpC?=
 =?utf-8?B?MkJrTFVrSlUwaGhxT1hpUU1zdGlhanZSWCs0bjFzeGI3V2RoSXZaS1FGVjFJ?=
 =?utf-8?B?T2xnak8vMSswOEJkWHZseDNTdFpXcktrQzJ2MDlHVWsydGk4OEdkOGlraWdk?=
 =?utf-8?B?MU9JVGhOUHE1SEV4ejBJQmxrOFNZa1NDTXl1bzFRUzlMU29KSUZOUUhaMjRa?=
 =?utf-8?B?eFB6VjBtZFVWOWFKZWFHZEh5Mis5QTdPUG9yWjdSOGJJNEJLbFJ5S3ovVVJy?=
 =?utf-8?B?RXhVQllhL0ZsMW1KeERZb2RwNEdyMHBWQXV5TEZFaE5kUm5WYWx4VG1aQU1N?=
 =?utf-8?B?V0NTU3JQQkhaQmdJQWI0VkZmMmlZanBzWjdwQ21IcGhJSExyV2dUaDlWTDFs?=
 =?utf-8?B?RW5zaXZ0eU5xdGliby9FSUpuemlEMkh2bkJqR0RsTVVtSWtmWm1iSnhyeS9l?=
 =?utf-8?B?YlVTSkViVjJIMW9ZZExoaDRHZlJwbU05czRvcU5YMGE4UCsxaCt0cDFCa1Zm?=
 =?utf-8?B?OGtHM25FeHpWdlFaUUNVZDQ2QlNscGsvSkthVG9Wa3h5WVUzTGE1VHcrVHRZ?=
 =?utf-8?B?cUoxdHl4Mzd5aTBUSkpUbWpaMDFnNXhGbUtDMVQvSkJGc3hkRGtRbUM1bE9K?=
 =?utf-8?B?M0JoUzJlSUsxWjByNkFWbzIzWDlUbHFIU0o0c21KNGxzVThUU0VrdlVGK05k?=
 =?utf-8?B?UG5tZi9MNmYvanEvYzg5dEtONnJTMHgyOGhXSnlKd21VVHRRb1g2Rkp4RUZG?=
 =?utf-8?B?bkFwaEpaMEx5NlB5N3RMVG93Z1llRE1DVXR1Rzc4aUJyQUxkZmY2UzdkUTBP?=
 =?utf-8?B?aDJYNzloV1VUR3FXS01ic2J2amg4dC95QVZjOWkyZk1nclFWOE51ZEx6UFpu?=
 =?utf-8?B?ZTYwWTdkamVIVVM3cGh3R2Z6T2ZqMVoxK2x1UTJPV28wR3FmNHhlV3FBa2t4?=
 =?utf-8?B?RGdhT1Mra0lMcHBrU1lRY002TStQcXA4WGVnR0tVUWYwWjJoR0FES2c4bnp6?=
 =?utf-8?B?Q0xYMnRBclozdFVBSkJZcnI0ajNURUFlVTNkM3U0Q0ZRcUVydEFMM1hMSDdK?=
 =?utf-8?B?aG1WazNjMkpVd1BLN1lSSW5rM3N4RURXVGJwVVlucTJUUExpV216OXU2ZllS?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33031d0-3898-428b-a398-08ddeb80309a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5533.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:56:36.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bifBIFWGuZzyoHBb/VDNvjywMQTnwdLh7V0614e+ulxpuVTuagwr/Fp11otz/AO04CcLGeM9jPmtinCtu1GoI/EzEQ/MEpjanMS6NBJ7jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDA2OSBTYWx0ZWRfXx9Ga1TzzoBEo
 aPIoQM9s9UfD0dE65MMwwgZDuOO8zZTtsTF6lJBXAd+O0WSDu9Qq5G0ApLdhRS5z8J6yTvKwWpc
 pXVysIghjnGKt1KmMnORkOmZj6kzusfs3TZmduMItIJHZvrx4Losa0fgWWzi6Sn25uneXTK2r2k
 i0tiAXZPc8VzJtRumVE/4wH/OwlA8LR+Dxp8HAlvnw56U5ZsYVqUUxBMoOllH8lRoupIP7NVpDB
 uYAw8L8eNKjHTrckLri0tnpM9bUKcgcA6F0J07EX2xp8OTRqfgm5PwCq+oZRHG64B8G3P07YcZP
 1VdAimar5ikyQ6UIN0/WgD531ovqI54bWElnpV0DtkHfF89cLSyffK7BuFQ87I=
X-Proofpoint-GUID: n9xNVkCQwvCLaisQKE-QaSIYI5voDT3J
X-Authority-Analysis: v=2.4 cv=QpVe3Uyd c=1 sm=1 tr=0 ts=68b93826 cx=c_pps
 a=7FdjbrT3gl74nB853+SW4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8
 a=kGKge11XqZWLzgvz9I0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: n9xNVkCQwvCLaisQKE-QaSIYI5voDT3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun


On 9/3/25 16:22, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, Sep 03, 2025 at 03:58:14PM +0800, jinfeng.wang.cn@windriver.com wrote:
>> From: Jinfeng Wang <jinfeng.wang.cn@windriver.com>
>>
>> This reverts commit 1af6d1696ca40b2d22889b4b8bbea616f94aaa84.
> What is the upstream commit id for this?

I'm sorry, I didn't describe this clearly. Let me try to summarize and 
clarify the issue:

### Background on the Commits and Dependencies:
- **Upstream Commit Chain**:
   - Original feature: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add 
runtime pm support")   – Introduces runtime power management support.
   - Fix 1: 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind 
goto warnings")    – Fix unwind issue introduced by the previous commit.
   - Fix 2: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime 
unbalance")            – Fix unbalance issue introduced by the previous 
two commits.
   - Fix 3: 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan 
on failure paths") – Fix cleanup issue introduced by previous commit.

- **Backports to 6.6.y Stable Branch**:
   - Only the later fixes (Fix 2 and Fix 3) were backported:
     - b07f349d1864 as cdfb20e4b34a ("spi: spi-cadence-quadspi: Fix pm 
runtime unbalance") – Note: This backport differs from the upstream commit.
     - 04a8ff1bc351 as 1af6d1696ca4 ("spi: cadence-quadspi: fix cleanup 
of rx_chan on failure paths").
   - The foundational commits (0578a6dbfe75 and 86401132d7bb) were 
**not** backported to 6.6.y.

### The Problem:
- Without reverting these backports, we see the error: "cadence-qspi 
ff8d2000.spi: Unbalanced pm_runtime_enable!" on 6.6.y.
- This error occurs because:
   - The backported fixes (especially cdfb20e4b34a) assume the presence 
of the earlier commits (0578a6dbfe75 and 86401132d7bb), which isn't in 
6.6.y.

### Proposed Solutions and Testing:
- **Option 1: Revert the Backports** (this patch):
   - Revert cdfb20e4b34a and 1af6d1696ca4.
   - Result: The "unbalanced pm_runtime_enable" error disappears, and 
the system works without issues.
- **Option 2: Backport the Foundational Commits**:
   - First revert cdfb20e4b34a and 1af6d1696ca4. Then backport the 
original feature and Fix 1, Fix 2, Fix 3, and 959043afe53a to avoid boot 
hang.(I just identified the cause of boot hang. The commit 959043afe53a 
is key to preventing the hang)
   - Result:  The "unbalanced pm_runtime_enable" error does not appear.

The newer kernels have all these commits including 959043afe53a, so 
there is no boot hang issue in newer kernels.
I think Option 1 is simple and easy to fix "Unbalanced 
pm_runtime_enable!" error. My patches are Option 1. If you have any 
objections, please let me know.

Thanks.

Jinfeng

>
>> There is cadence-qspi ff8d2000.spi: Unbalanced pm_runtime_enable! error
>> without this revert.
>>
>> After reverting commit cdfb20e4b34a ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
>> and commit 1af6d1696ca4 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"),
>> Unbalanced pm_runtime_enable! error does not appear.
>>
>> These two commits are backported from upstream commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
>> and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths").
>>
>> The commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
>> fix commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance").
>>
>> The commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance") fix
>> commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings").
>>
>> The commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings") fix
>> commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support").
> I am sorry, but I can not parse any of this.
>
>> 6.6.y only backport commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
>> and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"),
>> but does not backport commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
>> and commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings").
>> And the backport of commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
>> differs with the original patch. So there is Unbalanced pm_runtime_enable error.
>>
>> If revert the backport for commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
>> and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"), there is no error.
>> If backport commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support") and
>> commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings"), there
>> is hang during booting. I didn't find the cause of the hang.
> Is this hang also in newer kernels?  Why is this only an issue in older
> kernels?
>
> thanks,
>
> greg k-h

