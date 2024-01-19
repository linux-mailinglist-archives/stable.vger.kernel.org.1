Return-Path: <stable+bounces-12246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555D83253C
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC63B21DDC
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F2C13B;
	Fri, 19 Jan 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O0q/cIRo"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A4D51C
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650457; cv=fail; b=V20EqoQbKM248/nakYqw5uUNfbu/ZkD4BOQ77qZaLYPFmMesjuVKNpkccsmlIh4hv3jh1DR5Syg6/nt5096CI0tWxQVPPA/pWyrSMChHleH2tSqD+F0e2MuxzceRw1wVFruFMYkbupKjbyupDXEQ1eVuLNgKz475MHSFT+/xS4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650457; c=relaxed/simple;
	bh=CvFCX+4cxEBKRmu2/QVNNXkpZs2Ep2jc/uUC6w9wWCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lpy8gmb0JfA/sjO9ScRDkaWC07I8L7QeJ8U1aTeFZwtZE4qPp5JX+lZ8J97T/Bm88ZpfV0DNMvtfy0XYqqXOoeMvOarAQGkZZhha40uFSADjRNDvkU89g8m9RJe8AK4jP7hUkoxdxd/4h01P4EaVqPtavPitgwKyEJqgvorQDPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O0q/cIRo; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkSXBzVZkt2CrJj32IeCI5qSaBIHkMZtAQY/shURGphHb9r1xpjZEfxh3Qq11Au9PkRiBfu00wS2Y1OB/fUq7oygNS4qKYFcU0NbWWSZ2aZNcujLnJBxsqop3FQ6W5R9ltj+6czUUXJpMKyLI9jiNeNoV/DUZw1M/JUIBepSG6GnJDPhXyhH+N7lurjcbcCP0ocLxSwTUA2Zd2SuW3Vrd5z0Qak4zwaLxrQsqgjrCW8ocWZ2mFSJaQ8SmCUc1fFObdWRI1H4ZC/XE/zkbDSC1b+Oafm9QJjKSaLHol08LzvYE3Y+IbKQmj5kvAhixkIDYaPIeUDKyzLooJTOdNE1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrJH5GxzshCDDdSmBDp2nZCmtSaSNSRIzZKMrkeSTOA=;
 b=cdpdZzV5mCz2A5oME3ari4Ja6C7K/314WGZnjgu008SdcvzW0aeM+NexMkJjK4mwKkTxcMTmGrfVariOMYu40OXV2UmSpbEbySNrQIzOQHsPE4Anb1f3jRypKewGDr5965WDAA7yad7mkBxopB35rpEfmbSjGbZQapWqcp73UbyWf1WiWL/9aYQZzLjeQJNJpoPDFk24luDvkmOdWHyPb77acVRZ7cXVDDZsWnwBIwQedS+a8ZmHvgAeLQSRrEYZJT2776d3Z1Jlp8zPJzgm4G3Y6ZwPbqGU94Xo/Tb5nhxiBwbHQ/HlqU5QNx4hAbt31jYKu6xsXq6IBdUxAxyaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrJH5GxzshCDDdSmBDp2nZCmtSaSNSRIzZKMrkeSTOA=;
 b=O0q/cIRor00oZLRhU98XK5YwHR6be7GyKbgV86KkcaDH31aw4pTPoBhI0bVTFl3Dab5Yle4n37YLTyB6kQwlaWhT1oooQnIrnuSRUMtorxVYAkYuBjEMzaoMi83hqLNF+nvBLEOtwBWBMqbTBM5MBtekfv8JLDNQcKVVdX8meQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 07:47:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:47:33 +0000
Message-ID: <c3d81197-a2a6-4884-832c-d0b8459340aa@amd.com>
Date: Fri, 19 Jan 2024 08:47:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>, Alex Deucher
 <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20240118185402.919396-1-friedrich.vock@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240118185402.919396-1-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8f266e-03a4-42ca-c29b-08dc18c2e58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9RBzTXSPQNen3wY7+OjoaG9EFcb64T1ySFbCB+dj0EyR1sgTP8Jwri4gjHczsbeyktu5HeaFdXieDOFujw9ImJHeG9WVs0//pEOH8ZubtzjKvVArtXGdXqoMGsPAE+ASywDF8Kvmh3fsJNaYYZMLEUvPfTIcD8JgOF7uJ05binuTuvbu8YgVbyTWqR1yO6sH0cT/xjvNqeJE8Xzke/ueHmbOnDO4A8be3Z42/gMtINSMX3GXu2pr8fRz/0qn6H1r7WExggmLdsKastXaoxBbx96hZjgKTvjwsZ6kYDL1xvtPq5xpgdVpQIII4dgTlWLrsUF93u8Ll/ZJLk20kr/ZQlt0xNOIFxzC/yXYnK4jpqjCspOIPH+XbndXdMUwSc779Rst8oHs7yEfT598ASXp95BlCOS/8aD06Zb4lou7dlsmDPI8rtRZWyUEhurSBvEzRNdV2L98GGUNsQ2Dq33rwoqlpJ1LYeadDqaNFh4bnKUCLHMIqOhA15iZwTc8ypOZI/uOklHV+WK/Dh01FNHAPtw1J2dJclmzzryqiAOb+KLiNoX/tGFbOW87VLcMimxU4LIHK6LcCUA8VLkTTAPVREF0+tzOYOq70kOgJQMylAy0XF9q6zXa7x3PA9z0OW4qKnvUvGOkweGGKDzJ0J1vUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(41300700001)(6486002)(38100700002)(26005)(2616005)(31686004)(66574015)(83380400001)(6666004)(6506007)(478600001)(31696002)(6512007)(8676002)(86362001)(8936002)(4326008)(66946007)(66476007)(66556008)(54906003)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXVEQVcxcjVXVXRjK25GcS9nSkF0Y01Wb0syK05Ub2Q5dnZxTFRYNWp3Ukdu?=
 =?utf-8?B?elhPTkc0Smo3ZldLRExxYjhEVTVEcllSdloxNVRwVnBxaXE2clhwQmtNcEpu?=
 =?utf-8?B?SE5WWEFWdUNDczAwMVNjdk1ROFRRRWFubUkxUElTak16emlwM3cxdk5YWXdM?=
 =?utf-8?B?Zk9DQVpzWFpsQWZ4VzNFMWt2Vmphdy93T3ZIKzF0OTRheWw2b3FJN2RjMXZZ?=
 =?utf-8?B?Nm9yWERkKzFoMEhoNzE1R2lvaUdvczlTN1dxQVJ6QldKNFJIdXprNHNRUzdQ?=
 =?utf-8?B?UUhvbVh2NFlQV1NucTVlaE50clFxbUFWaXhLRkhTZ0theERIQ1FDQlRLV05Y?=
 =?utf-8?B?cnpDaWxSM3BSV1EwaGlTUDRabUZ2QVljNVgyb09SNk80cGk5aWxuTk9WWmRG?=
 =?utf-8?B?RkZab1R5OTQ0RnBSeVJYbFZWZE5NbXVDZFBOa1lMZ1dpQmg2cFVjbGExSjhW?=
 =?utf-8?B?TXM4YlpuZG42UU43UU5GSnJwbXQ3ZFhMcDA0RGNuU0poNS8yb29NQmFyYmlB?=
 =?utf-8?B?RXArNFljSEhKdm9CN1pNNUg0ajRNemY0VUp0MTVMNmxUdWtlbWZrSEh4SGN5?=
 =?utf-8?B?UVE1UEhFT1l0SkJrdldRTkR2QmNDTkVhZlRnZHNnL3pCRGZ5Wm9MZmFhMHBl?=
 =?utf-8?B?UkFVdHR6eVgrSDhyMEQzM012OTc5eHdsNDl5SkhYMFNSRkZFOTVJZW9qS0Nn?=
 =?utf-8?B?QndGUFNlODN5SFYxRWF5dWZoMzg5ekhEaXZ0TzFvbS93NkpIL1RMYlp0cnRV?=
 =?utf-8?B?MFNkdnVkTmNoUHVIbkFQWTBMcW1wdDRaMlE1NzdOVXJ4bXJnKzRGb0N0WVJq?=
 =?utf-8?B?UkpYMTJtWlI2R2hVUWRTL2xsYXE0bU0vUCtLM091MUp0VFcyK21GVlRYaHZm?=
 =?utf-8?B?WjBycVlMY0ovRkY5WDl0SlgzWGEzRDBsWVM5c3J0SERKaG9xQmFTdXdsenVU?=
 =?utf-8?B?RzQwOHhZajJCckNSVTQzZGsva1BLQUsxMkYza05iaUdDaDZvdGVPTkVEZi9Q?=
 =?utf-8?B?bjJQcTFzWVB1RXg2MGVua0lCT2lFYStzSGY1aGthczhZZ0pqQUs5b1E4YUQ2?=
 =?utf-8?B?ajRTZkF2SVc2UDkzZGlvM1V4bVJLVWdSN2xoQWpUdjJQcDNTMjU3Q1Z1amdw?=
 =?utf-8?B?UXpub2daRjZVTnlNVXVHTVNKZlFFN2dpbVhvZ2Y4TXltTHBudTZNQ3NTWk5G?=
 =?utf-8?B?dlk3b09HNWZSTm9SL2Zwc09sQjQzc3N3ODF4NURXdEJLWXdGSkgyMFhmV290?=
 =?utf-8?B?bUtQRTlGby9rM0N3VC9hMStUYk5hVEpEbElqc1RrdGdjZzFPQ3JKVHVDYWNn?=
 =?utf-8?B?REFIaUwyZDMwMzR3bzVSQjNXNWRJdCtZVUpRSnVMMDZBcFdMV3J6R1ZCZDRx?=
 =?utf-8?B?cGZmMmNnUllPM3FVQ1VmeVhrd3J5cVE0TFJpbXVwVWNPRWxBMVM3aWpmenlH?=
 =?utf-8?B?eEp6SUtsOEtWaHhiZzkyMjZ3dlBnQXJrZlBKZVpCYnBaYWk3WFVhQU5JWHdB?=
 =?utf-8?B?NWNwZXpQUk0xTFNnMUp5b2tKekdyRE9sMlBmaVdoRU8zbjdTR1htZS9NbUE5?=
 =?utf-8?B?cWxDcmpBVzkvSWtteUJicnRCMDlUYzNOeGdpU3BhdXZVenhXRmJ6QTdRaU5y?=
 =?utf-8?B?ZjdqL2I1Z3F5NjA3K0grRWFhZGNlc2pBQXZiUU5mYkdFSXZWbEFDN1FZTHdW?=
 =?utf-8?B?YUI2V2N2VEdWQndkVGs5M3pyQmYrRG1kN082YnJ1UGNUa0xvU1EwS1A1Q1ly?=
 =?utf-8?B?NGtQMFFyU0xVZjBQT21id0JjSlREeTlhRjU2NTdmSVV2ZVNncHBZRmVXYmhN?=
 =?utf-8?B?eHYxbkJYVkZHMVRtN1FLSC9yTWpjNlF1ZktLRVNadUdxY2NKdHRwT1Q1YUZu?=
 =?utf-8?B?ak5FWUdHb0NHa0R6MEFpVjg5elRsdGo1SWRrYW9kcmkwaHZIZzhza2RwMi85?=
 =?utf-8?B?WlJYVlBwdFk2TlJnbERxQTNPQUpMVlhRQXQvUXI3TVZqa2xpZTByY3g5SGcy?=
 =?utf-8?B?M3hSU2FhT0E3cjFZalRwNGpOOFVJZFRWbkVVUFp5MkVBemZMS3FQckZyRTFV?=
 =?utf-8?B?WGZpdXhXS2djbG5qczRhdEkxU0hlNUF4RnhwY3JGR3BKZDRHYjBTUmdxSE9V?=
 =?utf-8?Q?L+96f0M5yZ44QvmhfU1zI5BvQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8f266e-03a4-42ca-c29b-08dc18c2e58f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:47:33.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em8gP/gWqpFlZtDIut05FP0NR586TCSRBYvlrkYIn8G8WXza7SUrfX5lxeDZS/Qx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766



Am 18.01.24 um 19:54 schrieb Friedrich Vock:
> Allows us to detect subsequent IH ring buffer overflows as well.
>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
> v2: Reset CLEAR_OVERFLOW bit immediately after setting it
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 2 ++
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/si_ih.c      | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 7 +++++++
>   11 files changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 508f02eb0cf8..6041ec727f06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
>   	unsigned		rptr;
>   	struct amdgpu_ih_regs	ih_regs;
>
> +	bool overflow;
> +

That flag isn't needed any more in this patch as far as I can see.

Regards,
Christian.

>   	/* For waiting on IH processing at checkpoint. */
>   	wait_queue_head_t wait_process;
>   	uint64_t		processed_timestamp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 6f7c031dd197..bbadf2e530b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -204,6 +204,13 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
>   		tmp = RREG32(mmIH_RB_CNTL);
>   		tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>   		WREG32(mmIH_RB_CNTL, tmp);
> +
> +		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +		 * can be detected.
> +		 */
> +		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> +		WREG32(mmIH_RB_CNTL, tmp);
> +		ih->overflow = true;
>   	}
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index b8c47e0cf37a..e5c4ed44bad9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -216,6 +216,12 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32(mmIH_RB_CNTL, tmp);
>
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32(mmIH_RB_CNTL, tmp);
> +	ih->overflow = true;
>
>   out:
>   	return (wptr & ih->ptr_mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index aecad530b10a..075e5c1a5549 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -215,6 +215,12 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32(mmIH_RB_CNTL, tmp);
>
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32(mmIH_RB_CNTL, tmp);
> +	ih->overflow = true;
>
>   out:
>   	return (wptr & ih->ptr_mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index d9ed7332d805..d0a5a08edd55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -418,6 +418,13 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
>   	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +	ih->overflow = true;
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 8fb05eae340a..6bf4f210ef74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -418,6 +418,14 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
>   	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +	ih->overflow = true;
> +
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index e64b33115848..cdbe7d01490e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -442,6 +442,13 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>   	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +	ih->overflow = true;
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 9a24f17a5750..398fbc296cac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -119,6 +119,13 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
>   		tmp = RREG32(IH_RB_CNTL);
>   		tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>   		WREG32(IH_RB_CNTL, tmp);
> +
> +		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +		 * can be detected.
> +		 */
> +		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> +		WREG32(IH_RB_CNTL, tmp);
> +		ih->overflow = true;
>   	}
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 917707bba7f3..1d1e064be7d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -219,6 +219,13 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32(mmIH_RB_CNTL, tmp);
>
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32(mmIH_RB_CNTL, tmp);
> +	ih->overflow = true;
> +
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index d364c6dd152c..619087a4c4ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -373,6 +373,13 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +	ih->overflow = true;
> +
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index ddfc6941f9d5..f42f8e5dbe23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -421,6 +421,13 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>   	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>
> +	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> +	 * can be detected.
> +	 */
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> +	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> +	ih->overflow = true;
> +
>   out:
>   	return (wptr & ih->ptr_mask);
>   }
> --
> 2.43.0
>


