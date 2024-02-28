Return-Path: <stable+bounces-25384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2D86B34F
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B151F29497
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81015B99D;
	Wed, 28 Feb 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jvcp7yXR"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63D1487DC
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134715; cv=fail; b=fYH2BWs7frebgvYHrnXvZkJAhkL3NcEiMjCqBBcaJz9wa1S5mmnPRT5vz1G0uzhVYzjvFpul/kIiQzcAhUN5mJeawYj3cZXbc36kOhSPnQYYRBRu3HMNp5vRAeEy24abqLGTgT0LoGFJ9GjkvVFAn5Dq7D7jfRECG2+ujx15U7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134715; c=relaxed/simple;
	bh=uXocm8pFcarf62W6gCUqK9o1l/w2pcvgnXE0Jaj8l6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Di7aaNDozUKCrlRSsnzUPtIbn6dI/esBHSBBY4FiFV3TLXhD4s5J9Nv5XIBy4OQdBBHTCSef1Ke9ituDrk0sdq23iJhIxrZXinLyCtswvktWGnOJ3aSUpEDpIiivHdZ7IkVl+PBw0b5b8PN7TVDXpSd85nW8yq40rd4pkn1EgMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jvcp7yXR; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+wp9uj0KQZWir2JUrOQoXemEUIVKWXBsKpBA7xlisGe/9z42qD8m1z5sk+pVkYq8IcaqIzERU9ba60lPaEfJKh8dMTUJFwImtsgJAq13QbVCe/lvbEH8gvvtoE8XWXUlpM2fl5JhC1qZO7eAjotwHXjP6gQ8YzygdiQQcQSDya4puF3CyalpuVxpsrKZ6nMSwURYD3C7Kyx35UtHIxdDPKfRX+tbBeisiD6RcAD3gWKeIpy+os0gP2gE1IEqlyStMOFjYrC4zN9t57jK4/DLRK8Q5GdTQ5LYEmW09ICsmex1BSo4ZlN/tq4nEDiKxNJbsnYYiv3B3wt+9QDYHw9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmgkBsRukrD/fIxzpzS88bpWtxyP6ZMy045qQ1JX1wg=;
 b=H7NakbAGONFwclNC+2xsNWrzVlDPBX3rCB6sIb5IL0gE8qpUVkANc8hLwbprlnosnzyTpxDyVrUKPSJpsddNFX4E0+DrkustaPuT02AdmQBa0As9xXtckxyj1ciHqG35V1BDKXwhpr/PHWlQetf7MUgmawGDojVIx9QRTwkWHSDOsmC3BmzgZlIa/AaegpUO7J3A+M1Zld4nj0uGxHTtZZmMALwdRJy56ILscJ+KQeDQY5nj4KDryUHXvuJ+5dmuTAZVa3pcmX6r5NbpE8acvtoXgb296+LrD2ceDIM0AKReGnGiuEaFkBXacglelmjqBQ0vGeenTnwPoy0DYgdAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmgkBsRukrD/fIxzpzS88bpWtxyP6ZMy045qQ1JX1wg=;
 b=Jvcp7yXRW/WryJHgnQqJzyb4zzWfzcU2cnKAyWkrkQbX65fx5daPpwMnu8g68GLCAiZT4hYsQ3CzEBHIcYhBNPpqikntxmvAD0dXeWjSTBxLqvEilAi0qGPdnmJQmfOa71zoj+C8c3nlPL3210o0m4pt4Zk+G5LOSeJKdgtazkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 15:38:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 15:38:30 +0000
Message-ID: <13456daf-a1c5-48f3-807f-e6bfb78e9a4c@amd.com>
Date: Wed, 28 Feb 2024 10:38:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add monitor patch for specific eDP
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Cc: Ivan Lipski <ivlipski@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Tsung-hua Lin <tsung-hua.lin@amd.com>, Chris Chi <moukong.chi@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Sun peng Li <sunpeng.li@amd.com>
References: <20240227181854.482773-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240227181854.482773-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0030.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: c19d0956-48c7-4338-901c-08dc387350cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEY3ICcx67UsaclP/HTmQ9ZmIbiHeprmCJCm0jCLp7E7zpigI8c3DR7iLI/jTIhDoRbV5zWh/LrUaQPSGQl1bS2ZKUfFr5msc5igF0ffiAsr4OL5unzuct4xM8HRJzJ0brrT7QjIQF6oyFDPSJeFHidOxQJ5sy76AWJWwhU85ardaEejr8C3sdlCTFXFTuVlRtkeYzxmSQK4HzK4MDU4RhLNIAhiyRQwqZQXAG8kVwbp1fftFfaSLDAuq+L6aUS6eigciqR2QiBYRRhlpGOSRplaMKTbBJ2moN8LlyfEkmfLj5FCJbcwVyuYo6HX1ACCn494k5ZAXg41YH+g7hBx+EUQRhPYFjCL0z7jevWBd6TfeVVnlB97QTFO66g67KxlPXdNndOhbCUf8C7cAlpaMlLLPc40yfZdiQaf2sPnJjHLmLiTfCpH2fL9qMQpDyWFus3fsp6svXc/rL5wAvcb/T9YxXsb9PIy+WzxaOOK232tJ7CrpkyMWzdGxNAXZ4gedJwcUBOqdDnpCNJXEb1hYj3P5jpN3gUvnDvvWfiEFeX0m3oUmdI4fufxHE+m8TyRVZdqHIC/tbtngz7owmJC+JFylBfYbWVPT7QIndcI1OflTokA6b+S5DP9v9uoEuiKM/te5sHg6yxpX1gO+RBheA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGh6ZHZUWkxBYWY1RjBkUWFEQTJxcFVGZEU5WFVkbkYrKzN5Q3FtSmZnZDYz?=
 =?utf-8?B?SmV2SDZ5TTVtKzVsL0hRek5hTUora2xuWTJCcU4zT3VhZEdzMDBNcVYyeVZv?=
 =?utf-8?B?OXdSc043dkVHdDV2cGNIanhoZUI3cHpQcEJId3FRbUVKVTRjM1VVdG12MWhq?=
 =?utf-8?B?bEw0c0tlbllVYTd0TjRSYjRKd1BhSncxWldDc2orYlphdkVEaUJQNGNkVHRX?=
 =?utf-8?B?NkFLNEQ2eDBQMTM1a3Y3dnB5ckE0dHJrc3huRHBCemN5N1RLWVFOWWdqQVFk?=
 =?utf-8?B?WWY5TU1OZXE5cUxnKzdCN0ZyTnc2NGZ1RXlFcnd0cW9rcGVKaGhjNU1jb0xJ?=
 =?utf-8?B?QlBYNTlxZWNUVjFpOFNCY1EwR2tPMzkwZlRNQkZzV1ROOFAyVVhDWEpZV2d1?=
 =?utf-8?B?emt4TXBHRXd4NVpSd3NvbzZlTTJXVG5Yek9DdHZPdFhxRDlzbm1OSytWQlJq?=
 =?utf-8?B?dEU4d213V3pFRGdTWnBzTThKQ294SDdESGdUeVZtc01IMmZnVFpUTmFCYWw2?=
 =?utf-8?B?QmhrcUdHdDZlRyswOTF5djNIUnd3OEJlbnFwRlpDNC9jWno2NDl0Myt6REc1?=
 =?utf-8?B?V3ZYYzN1a1c3TkV0bVNOUFk5NklNTzVBYXZDcDN0TzRuQ2VTdng2aXFhMVFa?=
 =?utf-8?B?TURkZS9TQWdkNzMwMEdVbVA2L09mK3RoYW9NWGxiblgxT1gzdVBtQlhFb0Va?=
 =?utf-8?B?RExrMXllRjNsR0JYLzF0TitBK1NTcEtmOWplQ0pQcTRRSTFjMEdwNDVDbGla?=
 =?utf-8?B?Q3BwcjVpUUxXVWJMbjVsZTJNWWhPbHJ5WEk0TEUvT1pDdXdheVVhYUtyY0dS?=
 =?utf-8?B?UUkxQWxWZ1o2Y3YxM1NLMWhYZWsyeUdHMzNvcGVmcHBDdUdQODlpR3ZYUWM1?=
 =?utf-8?B?bXk0OEF3clk3S01TOVdiYnZlTFdGckpjTDhSdGRZZUlpMmFsQnhrOVpwT3RM?=
 =?utf-8?B?ZjU1dzdYY1NKdXkrekoyNXM0SW91cmo5TVlSZkNIZ0J2aWlEL0tCcFVueUda?=
 =?utf-8?B?WTllV2Z1Y09MTkZoaXk4cnBRL1pjUEt0RUhrSDE2bHA4NzN0dDFjeUVKVUNZ?=
 =?utf-8?B?ZS8vekdiN25zVldpbWJNbk90UFdkNTU4SHpsOUpnRWw3NytUK2lndXJPdHlV?=
 =?utf-8?B?aWZHUjFvTWxoNWRZQkxsN2NQNUZkY281SXdaQWU4VVRHN09tL3E5aUVHeXdP?=
 =?utf-8?B?M09xRkU1NFFKOU9WUkQ3Z3czbldJSExmaDdMdFo3VlQ3Y0FyNllpNFEzTVR6?=
 =?utf-8?B?bTJEQ3oyUCtIZ2djT0pGN3RFcjZiTCtqWTc1OU9WR1RualhIQVoxbUh0OGZM?=
 =?utf-8?B?UVlkWXlDZm1nMW0xTzd0cmtadHhOZWpsZEFNcXhseERaRFB1RHF4TExlakNh?=
 =?utf-8?B?YzVOckNZaTJ5dFY1Yk5TQVZka0J6L1lYNmsrY2kwbnFFQzZEdGUzazNNc29V?=
 =?utf-8?B?NXdWaldqUk9Rcm5vOXpPRDFCWHdMc2pON0t0WDdWUGg4NnRma1pQZ0prRXhi?=
 =?utf-8?B?THBvZXZIM1ArV1RzL0dJYThEcFBnK1EzczMzaVJRRU1uRjZBSWF6eGJwcXZP?=
 =?utf-8?B?UVQ5aUhHUTl5Ty9uZkUrNFhOVkVXemtlVUZMaU1wdHBES3RwUjUwQlQyOE1h?=
 =?utf-8?B?TTFRdllHcEIybUh4bGJrUmhSOTlwS2FzWXpvOHg0SUo4MGRUenVnWTZ6Wjl6?=
 =?utf-8?B?TUJ5N2FSamJMbkVjWnl1UGxpalgyZko4Rmc2V3pOeVBadklBUmFxaWxQOG5U?=
 =?utf-8?B?cXprdEovcm1WK0c5UmZqNFhmc25uVGtmb052Wm9PSG1Gd0wzdlV2akl5OGYw?=
 =?utf-8?B?ZmhaTk9LcG5wb2hGK2t2V052QWJ4TmpydHhPVHlRY1ZKY1lGTkhhTEp5VHdl?=
 =?utf-8?B?Ylgzclc0OTBqSXJWWEhxeksrNkVKQ3FoVzVuc1JKMXEyMlFTQm5jVmd0aUcx?=
 =?utf-8?B?U3YyNzVVQXlpcjhMWnFDeWh6N3hKU3ZaM1Bqdng3emRMN0dKOTNvdVlEVHVE?=
 =?utf-8?B?MGdrdE5nYlcrVEhRR3RjQ3pRenVFL0hLVytodHV5RDBYTHZXdjFaNkJFdnpJ?=
 =?utf-8?B?MVVlY1MrY2plZ2pBQVZSdEc3YS8rK3FsOHgzbFlCQlMzNU5nTDVnVTlON0xC?=
 =?utf-8?Q?jlPi+eZ2BqqT9+JZDzRP5JaCO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19d0956-48c7-4338-901c-08dc387350cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:38:30.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQZQ8btobCROYXGC1c+AJsLmkwp6+pfsr0TXcLqo5W73D7UbIEZKSC/p/z35tE/1raZ38bomx8Lw5sIcqqJzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231



On 2024-02-27 13:18, Rodrigo Siqueira wrote:
> From: Ivan Lipski <ivlipski@amd.com>
> 
> [WHY]
> Some eDP panels's ext caps don't write initial value cause the value of
> dpcd_addr(0x317) is random.  It means that sometimes the eDP will
> clarify it is OLED, miniLED...etc cause the backlight control interface
> is incorrect.
> 
> [HOW]
> Add a new panel patch to remove sink ext caps(HDR,OLED...etc)
> 
> Cc: stable@vger.kernel.org # 6.5.x
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Tsung-hua Lin <tsung-hua.lin@amd.com>
> Cc: Chris Chi <moukong.chi@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Ivan Lipski <ivlipski@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index d9a482908380..764dc3ffd91b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -63,6 +63,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
>  		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
>  		edid_caps->panel_patch.disable_fams = true;
>  		break;
> +	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
> +	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
> +	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
> +		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
> +		edid_caps->panel_patch.remove_sink_ext_caps = true;
> +		break;
>  	default:
>  		return;
>  	}


