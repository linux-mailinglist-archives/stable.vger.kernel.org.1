Return-Path: <stable+bounces-249702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hbSACXvXDGp8oAUAu9opvQ
	(envelope-from <stable+bounces-249702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:34:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4C5853CD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EF3730210EA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EDE3E8358;
	Tue, 19 May 2026 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPDGbx0T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HswAA1rn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB243603F7
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226482; cv=none; b=oQwYzjyzFCn7FaFhvVpCrjgC+uPVel92SijKgVIL0gHBug6of6MvM+goxgXUulN/7pYaDRcfPu8N20XfjmV3IfiOj28HY3gNK6RicsG6xhovtC4LE0jqOwmf53RFsK/RpWqkdaWbNkVKtpqv3o3XaKhEYwKhCGSIenFuWcvFYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226482; c=relaxed/simple;
	bh=E1sHCyblrk7BJl7Dj8sMzoANqsn0uVEMsM3jmhvZQdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2RLe9S2DKzqudPqGm8CQu+9mguBUPvNL9M/aRQCqri3CC3+Q4EO/raDM1dCDP9kJIeX6yquIkDVQ1TGHlCKboysbwTT7l8aTujzHtEHYypBCwnLhy2HQKJQpze/3R4SGnwIqck0x8WL/jOwqQLooD4o6e+Zese+GPfT5Wzrit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPDGbx0T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HswAA1rn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEweMP1725401
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=; b=FPDGbx0TuXRy5ByC
	aCnLH69AqWtqKU0ZeYV2Mz1Ff+ymL1ypchmygcp/NXSBhhcbVOHDdrujTXkaTnQu
	QTG27uEWjq/j0GPled3OiBWUk3Mff18opD4MMsyt3p7wE4mdv/fEDGSjXYmMKM11
	KZKZVgGDN6N2+N5Qw0Rlv/RlU3YNXN2FAXZWC2CV6oAGgUM8jljG9qUM3QPouv+9
	a3OslV8v0u6xIs12ZxpO4AlGGc9iCySIeDXMLWU6N7h4R8Ja1E8+koWYHIwqqTH7
	7x9wOHwSA/VAxMC0UbejwlQ3wEeNs7v2Y7dEmIFzVEpzsPwr6woMSVr6k44gd3e/
	zHyBLg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qhky8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:34:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2efc342ef15so5468374eec.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779226475; x=1779831275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=;
        b=HswAA1rn5YUDC90EzddosQFj+a42YiFHKQIXkLFCScUhMRnewTHMrAXmhIlWVpr4Kg
         KCIRow5EuBiqLqplaIv33tZ8CBecxSAXrIyczj+u9Wj9QGDVygf2Ws01z1tJ2kdlnFOR
         ZMxhryC9nc3bd4TOkmfCQVZt9r6kp7z0jDp8QEFoQ5eoImDf8V4KsNepKVjh1aO5iAqA
         kKccz8R9G7K6fWr6yp0bZZDpfTa2117TZ2dANEF8UCcGvjWQKsJYEwmQ0zi1R9jGvCcH
         vz3VrUCAo/8o/eCgrjSBHMwBMUqBBee+tcXBr2o5isTPYrk1zrQmVIQ6Lxr4cECny8+g
         NGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226475; x=1779831275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=;
        b=Yh2OSNiF8wPpjb9FSj6xOdQ6umRkyh3TnfEE7UUZquGKiLz9/KejDKhQMzEvnKU75m
         8mJ/3K7zC3ET5N1omw8MJQ4sZIH/lSKxlicZHujUwZNiT6HH0uqzOfPR6KI/MDfOYGKO
         XhOPjnMrr/AHBq+El1ttv2iaRxKe/DJ1T/lg4lQ4/o0lbD1pbKm7ofjyw8yMAazDN/WB
         qJlEjpZscnQxCpGP7ZUjdcLtmu+tLrn+As4iBSVBPmr2cdC6LyFrbvCFa5Ypi4ynpTYn
         NNAVoRjeSqY/IGkTgbG3+QI9/DlQ7GJ7I14rULoPDe1sSscj87eGwMJvM5118LwoGK1X
         xfyg==
X-Forwarded-Encrypted: i=1; AFNElJ+G9Kl+49TD8KyZXEfJCA2pdT3d7VaS5Q0SkNhKQoRZnyLC4qraXEfbuNmwrWC/JsrwKcPGTBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18hvLH80Tcn4GQMFUw90wWf6ZOyUmxPVZTT5n674HshutgM0f
	3io+VNgd5l5WgOkHJH0IK4wnQR7ivP9s6a4NPo4ikKD0lBd59328CcAx2EPIOKFkurTZl5VsZuZ
	AxicFgpBDI+/bgqlZ+bqcrKTeCxd+fMPHjJTwyZFIc8oWMoORy9Bg0V0KPdA=
X-Gm-Gg: Acq92OFtoDq6I7PXAI7xqWUVfkhk2DDF7YQYNzXh89eb4Dfejucu8UiVa6nNtoaXFR8
	xWMkUEs68n+yKIgbuLpGFhr6S3Pc+XIGVGBWpl2y3yAXTb/mkGjEf4rXUpvZ9uV09dXuj2ygqVB
	JCIG14Au2JtEXStj0akvPVrX80yLKf3eYjtATffcnvCvWKehmdvDqA2+p/O4FZHVGAka2hDspUz
	/zsX7HkMsyZfB1rC6+p2HUjNS4QxHWV9Mntacv8leLPI4mweYEY+ucZxZYWla83Bqx3674MYpb6
	U9Try8b4pspR6GqGhFQ0JncYt1zQ0VqpV9CTyLzmMX/fa6Brf5hxHb4qyHXMzsLM6GtVwF15u7E
	xXGLSWENIe7KLUHEYB/A+pkCTYNpk7/iRTgvzd+OasRWJYM9AZ0tt
X-Received: by 2002:a05:7301:19ae:b0:304:13f3:e461 with SMTP id 5a478bee46e88-30413f4159bmr584074eec.3.1779226474503;
        Tue, 19 May 2026 14:34:34 -0700 (PDT)
X-Received: by 2002:a05:7301:19ae:b0:304:13f3:e461 with SMTP id 5a478bee46e88-30413f4159bmr584047eec.3.1779226473901;
        Tue, 19 May 2026 14:34:33 -0700 (PDT)
Received: from [192.168.0.31] ([212.5.153.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm16873423eec.23.2026.05.19.14.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 14:34:33 -0700 (PDT)
Message-ID: <35028dcc-3bb1-4e76-b471-183f319a7f46@oss.qualcomm.com>
Date: Wed, 20 May 2026 00:34:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] mm/memory_hotplug: Fix incorrect altmap passing in
 error path
To: Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
        joao.m.martins@oracle.com, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
 <20260428081855.1249045-3-songmuchun@bytedance.com>
Content-Language: en-US
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
In-Reply-To: <20260428081855.1249045-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIxNCBTYWx0ZWRfXxhzNGhwfStCX
 7qqQpzWdExzjged7v8NkZ5s8qoK/5+0hZKtZRU99F+VlapZ/QEySpFyI8keR8eCLZf3vPZWYYws
 yngdmo23aIRudszutJIzM4MgRsqDzBe41r0QWWr13NohQdezKsz/qBCmuTJ6yF/YZvXMkZc8ksA
 FF9JoAlA18p0HhwvdheqZGHythFBLp1KvrBlZPBFtOmN2cmJSOgrBpM5+wOn4btaLx6fU7b6WGa
 ki/3Y10d3kjUF5j+X848NIVkRkUm8UEj80bt91fWbFDJ12WeQTZuHpiLfbQD6wHzxgbwiLFOWUu
 XUzvsaquL1M/HzoVZoRd8eHN5zMRiv6M1v1mSVCbq41ckTIlDnmUYF3CdWsAU5xe2EXieeld3YZ
 Qd6w50fxCXcz1nA61kMeWc9Kzbo3KrTSuUFnMWh5tO1r3RBw1cquDBwY0DV+ra2vesNXEuBDR4C
 91z3WmN83H+TdjRyuig==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0cd76b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=douLNevBrtimd63D7eljNA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8 a=cJIYO2twRcDUUobFbVwA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: vifEJYkdszPQfE7fNrKpQT5pFlrv-U76
X-Proofpoint-ORIG-GUID: vifEJYkdszPQfE7fNrKpQT5pFlrv-U76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190214
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249702-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgi.djakov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 15A4C5853CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/28/2026 11:18 AM, Muchun Song wrote:
> In create_altmaps_and_memory_blocks(), when arch_add_memory() succeeds
> with memmap_on_memory enabled, the vmemmap pages are allocated from
> params.altmap. If create_memory_block_devices() subsequently fails, the
> error path calls arch_remove_memory() with a NULL altmap instead of
> params.altmap.
> 
> This is a bug that could lead to memory corruption. Since altmap is
> NULL, vmemmap_free() falls back to freeing the vmemmap pages into the
> system buddy allocator via free_pages() instead of the altmap.
> arch_remove_memory() then immediately destroys the physical linear
> mapping for this memory. This injects unowned pages into the buddy
> allocator, causing machine checks or memory corruption if the system
> later attempts to allocate and use those freed pages.
> 
> Fix this by passing params.altmap to arch_remove_memory() in the error
> path.
> 
> Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4426abb05655..e3352284f635 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1469,7 +1469,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>  		ret = create_memory_block_devices(cur_start, memblock_size, nid,
>  						  params.altmap, group);
>  		if (ret) {
> -			arch_remove_memory(cur_start, memblock_size, NULL);
> +			arch_remove_memory(cur_start, memblock_size, params.altmap);
>  			kfree(params.altmap);
>  			goto out;
>  		}


