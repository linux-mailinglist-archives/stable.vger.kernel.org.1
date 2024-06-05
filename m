Return-Path: <stable+bounces-48235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1C8FD2A0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B081F23E48
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260B188CA0;
	Wed,  5 Jun 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PNQUqnw1"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285235280;
	Wed,  5 Jun 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604171; cv=fail; b=tbeMvLYUraD4yXxiXIUUUntiuOCzl2mPuSCN4MelpLih4F0/axiaWUi40InkrGEBGYm0e6UgXKeSVcukR6Z+PHNlDhM1xOkU5VkolbxEc8k9J/3cd7uflpGAABbToQ1kNqYVuHt9xHAnwx70IZxwCy+VHnxwsZBoTrRW16eaGw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604171; c=relaxed/simple;
	bh=3E7NVD8UzKPwCT5xbP26RQp05ns0ubKHCGmvxgDEti0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uYP/K3IR2h9jjEyKHIxiCVdcto/3YGmw8dBEHjqp0BimHF9RQcVtp7uSF0D2/qD2sX0ELFZsxZCRI3gZ3C28WO/J7XcThc66L8qECZ3F0nclt+o8aA0ogwijd45o18rqZ8gEPp9U6LHQZiciOjYwIU+AaYP+QIGiaJ+RI0JvU7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PNQUqnw1; arc=fail smtp.client-ip=40.107.220.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNLervl2aczvpeqytfelM37RdkRnL+e45eMo0IGGtDsfZ8SIj4fcf+x3jbxzO9VdzFkIXd6Ow34/8TqwPRteqg7wcSR5eZxt5Yw+wrVManamsuKt5xqKR0Rkcy8jO3r4dNzDG2SLRMXUE2mLmgPGM/KlxJ++/Povt57jLa4TmaUWwifvULgudnzjvSaeJeVGLMkIDPJtZqXxBqPavFBNWHWLJgiYRQOrr6upZZg7tkOnaGYWn/wRDqPK1/6U8MbdzEjiCgZ4rdof4R6MEhMG7P9Rw8a8zYayLejaeNb1TejSf9ej62n54bGx6Hdz8Vuhsh+2DPpMddFagI2PBhhIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usmNsxsHfGubGNiNo9dOJH2tJXuEx5wpPMtszY/9xFc=;
 b=dOV6cL/HtrCvmYNZbhBoN4xMxwdu5ve37oe2vAz7+F8P6xEs2YO5CbkCfcQIQmBqZtWDyFEQgeK9DCgTP7d1JCMgnPRI0903PnfSJpReqk+O14yT1TYvMqkF9y61KwXidwe4Fx2ZlBUMlGxGT8ep+XFSK1TEx1PDB+NA+YKAaVOu1cTQRtkRhn7KssIX98gI0s8HqZJCDksmzGg/i/+8SY7kD1axhQTkhxpA+EmV//2KOgdVXo+TWQjrx5q9ERIVPLcTnw7GrEa8KdJ7wHfhF0lZIUPnfIadrkiiTSS+hFhk1bpHKVv3JV/LWgpCuMSCWGSV0PDqGJQlNu5OCdckjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usmNsxsHfGubGNiNo9dOJH2tJXuEx5wpPMtszY/9xFc=;
 b=PNQUqnw19QR6m7k2IuIcV7P3teYQySGrLTkjRqEYg/dA2K54MIEZ6qU2Dkv2143i5Vp7MgFWGEQ6Na0maXZbc9Ggn8ie7JSyHohfQNGZWGVb0gaLxTlZvHh6Vmz7ZepLZBrEoBOgBLJrMAH1497eAZHwECJhd7YU/fgiJsG5Ir8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SJ0PR01MB6463.prod.exchangelabs.com (2603:10b6:a03:298::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Wed, 5 Jun 2024 16:16:06 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:16:06 +0000
Message-ID: <58f249cf-c2a9-429b-871d-15584ed37956@os.amperecomputing.com>
Date: Wed, 5 Jun 2024 09:16:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_ref: remove folio_try_get_rcu()
To: Peter Xu <peterx@redhat.com>
Cc: oliver.sang@intel.com, paulmck@kernel.org, david@redhat.com,
 willy@infradead.org, riel@surriel.com, vivek.kasireddy@intel.com,
 cl@linux.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240604234858.948986-1-yang@os.amperecomputing.com>
 <ZmCDU5PMBqE-H-om@x1n>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZmCDU5PMBqE-H-om@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::34) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SJ0PR01MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 6907c79a-6971-4ba1-6ec0-08dc857acdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R054RGFuWlRuMVlrVGszSDFzcURPeXNsZXE0cDlwMTFueFZ4eXR3QnhlclF3?=
 =?utf-8?B?WVBmWW5iQjhkOEJtMTFoU3RFcDlVRDcxbUhka3NuRTdsUDZOSTdBR040ajRn?=
 =?utf-8?B?bnpDR0RLZGM1ckIxQWd0bXA4RzhCbThQV1RHWkxHbU5IUFl5elkvdGE3UmNG?=
 =?utf-8?B?MGJWaitLNWUwd3FxRHlQSUlyeXhLbWZmU1lxOEI0TlFjM1pLYWZZSVhkT0Ry?=
 =?utf-8?B?dG9pbHhzQmtJaExWd2VRRmt6R0lycGI3OXBaTFV4aUc4MWZORTZSSVo5ZzRu?=
 =?utf-8?B?OEp6dG5zNHhEVnVtQXFsNDk1REJpTjcrRzk4OTBMQTdxT0VJWXpibGRJNThO?=
 =?utf-8?B?aUREUVV6dVVlRGlWNXFxSG5sY3NGMmxZUzZaM3dBY2xVM25McWFlRmhPcU9Y?=
 =?utf-8?B?OEtQanZ0M3p2L2ZObUNJQVhQZS9Qd1RmYytoRE1uMXhlcmRYY0pyMjJxcFJS?=
 =?utf-8?B?aTZUTFpoblFWRXdLOHY2aVFjaHlxcDdGbGlBcWRoWU5OWE5HNVRMQURhYVNQ?=
 =?utf-8?B?RmUzKy9iSU9SZmpvblNCUnpHdGhjSnloaEQxb0hLNTZmTFJsT1poN3FwdVJJ?=
 =?utf-8?B?QjNJRldlV0l2OHRNK0dNaWZib3h6cmk1aStaRlZaeDBmcDZwL1F0TDlrdDFa?=
 =?utf-8?B?ZEFoM05sY2h6c2RlYkNxOS9iSFNsTGhRQmZGQ3MremU0U05Bdm5TWElJRnZv?=
 =?utf-8?B?VGEzUGJSMlRkdFpKa1U1Z3RXWDdwcXJsejI4MjlYR0NjRXJlVTZaM0txdDVC?=
 =?utf-8?B?WEhYc0hlcjNZRVU2VEZsbUxGSTB6UXN1TE5HUk0rZ3lLNjYrampDaDVrZitr?=
 =?utf-8?B?QmdmUUc0SFl1QjJ6dTJnQ3ZjalV6QllZMW5iMDNBR0l1eTB0RHAyOTB3WGFZ?=
 =?utf-8?B?UWFwNUJOcUJhNWlNWGxySUUxbnFJdUplem8zZ0t2NzVKQ0oxYWpVNmhKVW1G?=
 =?utf-8?B?NWtJdlR4ME81K3ZKOHo3R0RHNG9qaDczNTJzdHVrKzQzNUpHT2NhMERjbFNX?=
 =?utf-8?B?Nit1dUh3RUxPYlE5M01pZFgxQ0tKakFVcFpSMS9EaVhjaE1LM1Q2WVlpbkJ2?=
 =?utf-8?B?emFYM09LOVpydVFQK0ZhUXU3aFJwbm5sL1NuM2p4eG1QYm1YVC9tRkxsY25j?=
 =?utf-8?B?ZEsvOGhhRXBNNVdWZFB6dURpZndlaUF0V0tWaVN3NFVsSWY2Z0t5LzVHMkl1?=
 =?utf-8?B?TXJXdURmOU9kOTRWWFlIeHZoMFJVcGRLRXlrTExUc0d1STVZWEZqTytYdUxT?=
 =?utf-8?B?Y0dvYlRJNjUyRVpZaFRuUVZpbm1YbVFudHNRZGFWUXlHUU9zLyt3NVNEc2dD?=
 =?utf-8?B?UGJKZGtRdWkzL2h2bVd5aE9NdW9wLzc0YVdJeU9VUU1mQ3RubGZHZTQwTm9z?=
 =?utf-8?B?SEQ5Q0JHU0o1MnIxY3FVQm9VdDlkSnAxcW1MYWJjTWRvNjJ2angvZEdhMnRD?=
 =?utf-8?B?cTYxVlp4Q1dVcDFtWmNmbmRmdzFjR1A3ZGV5cW9pRzVsd21OaWs3STJZV0tW?=
 =?utf-8?B?OEwvZTRhd2NxZzdmQlZMN05EZi82WjF2VmtXUGZXT2MwbC9lWlM1YXRPN0ZX?=
 =?utf-8?B?SXVZUVlMVTNRL2RhK3FJUjNPOVdweWo1alVHRTdiOXhlU2Izd3NWa3pVTWpH?=
 =?utf-8?B?Z2tKSkJCc21qSWVNbzY0dWdkL1BGdUxSUjc3SlNvNDd1azY5eVdXYU1uUVZB?=
 =?utf-8?B?ei9PWGhHSHNKQ01yeUxLS0lpamtzTjJWMUpzR1g1VVptYjh0SysvNU1GQXBu?=
 =?utf-8?Q?o+3Kp1/VCHXSQqms/eLyNOmJEDfle6VDlMM6h+r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJVdGN5bUNCN1UvT0lra0U5Y3hXaVR6NVFZM1U1b0kyQnNQUkQrdjgyU3FS?=
 =?utf-8?B?YkwzNWlqUlFZamVOR3U5MG1wM0JrbFJib283Uy83SEZjU1MwUzFQZkY4MWl1?=
 =?utf-8?B?R0I0YWRCR0lIRjMvUUI2VDB6YU44clRFZFRVNXpVRkd1UHFjaWRWTU5KS1Q5?=
 =?utf-8?B?eGtoY2ErcU9ZSjdkU3h1eDJpTjdxalIzY0ZKcTk5SW5KNFFoR3NnNGY3bTRa?=
 =?utf-8?B?MytNZzRPcjU1NlNrajMzdVU4dDJOTG9QM3krQVFJUmNXZTV5K3MwZXRzVzZq?=
 =?utf-8?B?ZjRCSUJMWXB2ZnR1TW51cmo3K0lianVLZzJHV0RCajZJNHVHbW1qcWFobnFi?=
 =?utf-8?B?WEJxV1Z1TlVkMFBOY0pKaXJVOWNoNmNNaTBNTUxFb09RNHlWbktTR0RtQjls?=
 =?utf-8?B?QUhmTExaZ0oyeThrN3VzdC96Zk5pSjVRVGdoMkk5Ti8wS2Z4WlZETW5kM3Uw?=
 =?utf-8?B?TjIyZm9qZjlMajZjQzhtTUt4UHh3MjRvOWx0UGdYd2VET0Q4Rjk4YjBjR3dL?=
 =?utf-8?B?eWcrTGlZaENrbVRrOTArbkg0ZEpJRkROYm1nUXkwTU9wR3FiSTRtOFJlcUNK?=
 =?utf-8?B?SmhWNjcyYm5Lc3U1OUNEeHMvMmRMMHowTzBadkcvTm1mOXlyajd1S2pJNTR1?=
 =?utf-8?B?eUc3b3VIKzBSMlpWYnJoMzNDb2UxTHlCdGFyak8zNTNab2dCZ0Q4SU9zYXdt?=
 =?utf-8?B?Z2tpUnpWNGJzdkpPblRCK2Q3T0cwTlNENTgzRHJSSEdwakl6a3dNc1piemhk?=
 =?utf-8?B?QklxclVVd3p2ditsMDJ4UEdzN09ySmsvT3ZmNUxkbmRsSUF0T3hUWG45cmFJ?=
 =?utf-8?B?Z2tFY0VpYXBKMS9laUlmd0VKakdnWWZGVyt1WThPTW81QWh5aE9OQlpyRGdn?=
 =?utf-8?B?Qis2eW9TK1ZsVDkrcDJBeWdlaXg5blZPak1BSnpqM2FuQzlUVk1sdkg1aWNQ?=
 =?utf-8?B?WDFVdUh6RENHaFB2N0RUVXl3VGVYM2hIWkVhdnZaclJBRFJNNG11YUxZM3lw?=
 =?utf-8?B?a1pkdHVTa2VHMzZrY0l5OUovTnkrSURib2dESDFJK3dzSW9Sc21idVA3Qm41?=
 =?utf-8?B?K0FWK01Zc2VVV1d0dXRRdzlNeWR0TGdBSDRtRG5neFN3VEVMa2hraFRYVVJ3?=
 =?utf-8?B?MWtIa3ovdjJNcjZWN3B0NzdzR3B1bEtscVBmOFgyUkVWZnZ6OGdBOG8yTUg0?=
 =?utf-8?B?eGpGbXUzMytNUUpxWnAxbGl5NE9hRXVlNXJxaTFRajhOSGlTRS81M0dNWWc0?=
 =?utf-8?B?aFlsNGR0UmlsNWFOUmJ0UTVCKzdlZDV5R0VVeS9qdVZIZGF6dnVZVU1TbnNT?=
 =?utf-8?B?akR4MDk4d0ZKWEMwWk83QnhxZ09HbjdZUVROZHgzT2wwZGR0N2xxUHF1YXFD?=
 =?utf-8?B?TThoY2hqZ3h5RHNnaVo1djRTQjdQd2JNaUtpTmZoN1h6dHVaV3V1WFplaTFV?=
 =?utf-8?B?emxnWWpNZ2toZWY4bmFrZWNZS0p0R3o0S0NYcXRWdlBzRU1FaDhCdzYzUS9r?=
 =?utf-8?B?UDZvaEZLNEpFSzBFaHlPVGRYdnN6YnprTWw4b0tLTU42TEY2c3o3a0FJWXJ1?=
 =?utf-8?B?SCtuVW81M3BSeWNJN3poeXY3OElNSUpKRFhWdFlMZkZ4VjFJNnVvNnc3aWVG?=
 =?utf-8?B?S2YrZi9PVXdJaHZSVk9rN2lKdDJZUk9lRmMrZTUyZllnaExCaHlCWERoZzNk?=
 =?utf-8?B?ck4vK1hhMUtOcWVXSi9Vc3QxTy9JWXVIQ3pUWDBKbFFpazZ3OUhSMi9ydTlx?=
 =?utf-8?B?Uk4xR1ZtZ09zdzVSNmY4dVdKQjg1NzZVc1J0eHUwL3hZYmkzMk5yNHA1cGRl?=
 =?utf-8?B?cjlMNlVlbmVFOUs2eW1ybTlZU1llems2eE0rc1Qxck41L3dSclV3OS82Qi9R?=
 =?utf-8?B?bE8vUWxZaG1JU09Pa1lqV1FCUS95Q2h4OUY0dW56R3IvNnJBV2MzZDBHRWRE?=
 =?utf-8?B?SDBhUTdVRlIxRGxXN0Y4VjBOQmwvTzU5aVduNHI4aWw3T0FSR0hxbzA5b2U2?=
 =?utf-8?B?WVM3VnFNUlNnK21zOWxRazNmVnVHd0JTZDlNUnFiMHFkOUFrLzd1dC9lN2xm?=
 =?utf-8?B?UDRSeS9GdEJIeWdMTE5sa0JhUEdlUWtDd1NIYm9BN29QcnRyOEhJOHl5MjFs?=
 =?utf-8?B?ZnNoU3l5dXJveWxraWVLLzFqQlZXV0d3cW9TN0p4eE1jbEZhRGtCREpMOFA1?=
 =?utf-8?Q?x1YADoUCbCJZubbnuwCCH6E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6907c79a-6971-4ba1-6ec0-08dc857acdd3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:16:06.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsVU0m0KWZxC0K9UzsOZEoQsv9aLIe3YgCAAtnJ1FfmjbiPZyZgLMRQnpSwYo9XMc5IJJCEfYygB3PoA8mh23oUZ/PMlT7mIdvbAl1KzQUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6463



On 6/5/24 8:25 AM, Peter Xu wrote:
> On Tue, Jun 04, 2024 at 04:48:57PM -0700, Yang Shi wrote:
>> The below bug was reported on a non-SMP kernel:
>>
>> [  275.267158][ T4335] ------------[ cut here ]------------
>> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
>> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
>> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
>> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [  275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
>> [  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0000000000000000
>> [  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: ffffea00066e0034
>> [  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: fffff94000cdc006
>> [  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0000000000000136
>> [  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: ffffea00066e0008
>> [  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(0000) knlGS:0000000000000000
>> [  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 00000000000406f0
>> [  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  275.280201][ T4335] Call Trace:
>> [  275.280499][ T4335]  <TASK>
>> [ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
>> [ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153)
>> [ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174)
>> [ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212)
>> [ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264)
>> [ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
>> [ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [ 275.285278][ T4335] try_grab_folio (mm/gup.c:148)
>> [ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1))
>> [ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188)
>> [ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:3825)
>> [ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discriminator 1))
>> [ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209)
>> [ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204)
>> [ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
>> [ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106)
>> [ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350)
>> [ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350)
>> [ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
>> [ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573)
>> [ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360
>> [ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10
>> [ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573)
>> [ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0
>> [ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228)
>> [ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10
>> [ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284)
>> [ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259)
>> [ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
>> [ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:291)
>> [ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common.c:94 kernel/entry/common.c:112)
>> [ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discriminator 1) arch/x86/entry/common.c:82 (discriminator 1))
>> [ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
>> [ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
>> [ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>> [ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
>> [ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>> [ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>> [ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
>> [ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
>>
>> This BUG is the VM_BUG_ON(!in_atomic() && !irqs_disabled()) assertion in
>> folio_ref_try_add_rcu() for non-SMP kernel.
>>
>> The process_vm_readv() calls GUP to pin the THP. An optimization for
>> pinning THP instroduced by commit 57edfcfd3419 ("mm/gup: accelerate thp
>> gup even for "pages != NULL"") calls try_grab_folio() to pin the THP,
>> but try_grab_folio() is supposed to be called in atomic context for
>> non-SMP kernel, for example, irq disabled or preemption disabled, due to
>> the optimization introduced by commit e286781d5f2e ("mm: speculative
>> page references").
>>
>> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>> boundaries") is not actually the root cause although it was bisected to.
>> It just makes the problem exposed more likely.
>>
>> The follow up discussion suggested the optimization for non-SMP kernel
>> may be out-dated and not worth it anymore [1].  So removing the
>> optimization to silence the BUG.
>>
>> However calling try_grab_folio() in GUP slow path actually is
>> unnecessary, so the following patch will clean this up.
>>
>> [1] https://lore.kernel.org/linux-mm/821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop/
>> Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Cc: linux-stable <stable@vger.kernel.org> v6.6+
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Just to mention, IMHO it'll still be nicer if we keep the 1st fix patch
> only have the folio_ref_try_add_rcu() changes, it'll be easier for
> backport.
>
> Now this patch contains not only that but also logically a cleanup patch
> that replaces old rcu calls to folio_try_get().  But squashing these may
> mean we need explicit backport to 6.6 depending on whether those lines
> changed, meanwhile the cleanup part may not be justfied to be backported in
> the first place.  I'll leave that to you to decide, no strong feelings here.

Neither do I. But I slightly prefer have the patch as is for mainline 
since removing the #ifdef and the clean up lead by it seems 
self-contained and naturally integral. If it can not be applied to 
stable tree without conflict, I can generate a separate patch for stable 
tree with the removing #ifdef part. The effort should be trivial.

>
> Acked-by: Peter Xu <peterx@redhat.com>

Thank you!

>
> Thanks,
>


