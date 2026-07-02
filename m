Return-Path: <stable+bounces-270390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZM1iEtk6RmqMMQsAu9opvQ
	(envelope-from <stable+bounces-270390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:18:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8306F5C44
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=P5ms3SYD;
	dkim=pass header.d=redhat.com header.s=google header.b=oastiVx2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270390-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270390-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74FB33004F2F
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874A480DE6;
	Thu,  2 Jul 2026 10:02:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A698480949
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 10:02:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986540; cv=none; b=rFpeamMKLEfLTnPWaPoaRhlbDMGK6F8MtiEC/OqYGotPB5njobf1JQ0mqgxhQMI309ooYC1e695ddBaqeS7kxH3d70tHatxKlj96mgrBKCBt6S3NlVvmLc+hoirz/VR2J0unPBebO/G3LlLJAfGBj7i4Na0fTSR9qV0S+XgW1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986540; c=relaxed/simple;
	bh=l/4zG+3D9ejOnVWvPH58fKkY+gswQsvE7oQpLDlZzVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ll2b2pLNu6EOGbYQHkGAsEtgjif7nwMqZW8daaqamy/dgP5AyHEpxtJLX9rzwDG4yBevrPSRp3a6EcpRUSK+lNzjtfbHYBqpQyxwNxsj24q2Am/vBikxvsrzQP+75FjdgrRSNFiXnStskh9vINfExzQJMSGHvszcrAt7OG5gq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5ms3SYD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oastiVx2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782986538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
	b=P5ms3SYDYuxgXZ5OShfS9Iehx4CCpELFuI/MNI2jdAPWDWuSOmcH/VtTl2Khni/rCAhIBU
	iymC6c0tpC8Wj64FkLNvm5d8qO/AA/05+5NsA7OxQA9kHVB+VRJjyah/0RHLLUEQlKEFMj
	rbxByKwF5AHCzXobguEj9j+a7V5QKp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-gohKeCYTO_eLcedJJJrAsA-1; Thu, 02 Jul 2026 06:02:15 -0400
X-MC-Unique: gohKeCYTO_eLcedJJJrAsA-1
X-Mimecast-MFC-AGG-ID: gohKeCYTO_eLcedJJJrAsA_1782986534
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so12757615e9.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782986534; x=1783591334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
        b=oastiVx2aWNgeMvEzBzlDXTp2ULJOG/l7LYkAbG+jAOtHz8SUtTId7wAaMBI1ggp5J
         OWjur+qphQ8MZjdkYQDqQpqnY7zXxkwPETVtoS2/1d8a39uFAJpLG5vmbuqYPWj0HjTc
         j7NU0NzCdGzMYlP7oI40QD9vMonxi++xemoogK+nqJ/S1CIwFwaOzj71aWwXqpa8EmrR
         bNwSK7xwGq4mTXih5i0KMlYoz1WiBL91SGTyqFHafq5ba5a9/LKViSZwW8XuR5FEZe9U
         +Ht45Jc1IBRrbbiTz85wwz/3NMaod8ViFir2t3OtX3C5unzc8GPvLaRwBBEUfGXip8k0
         XTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782986534; x=1783591334;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
        b=C0VNhcm9ksVg7Y/R5gy4DuwIviYntt/7UGp2OLr5ENxZ92LUmmRlPswodkVaiqPsAs
         Ebkgda9PL85fWhsmGFLZeY2Bj+KTIUVO/i3oQcV1D3ifaKZqBBmkLhlPWDYQae2zH9ME
         fv6G7q7TP8AkOjZ8ke37MzQVmlZO3OAkLjsDNTJ7dyMzUca7sxj1rfbF7kQG/0qK2llH
         GdzC/BW1WL+wpIPfpI7AX19P5fK1ylWlpRBniYbny873On6aI9bDimC6zDDfjVmejSc+
         aGkdJJ9L0oEk2E1tEw7diIBSS4/Am5sBDFpdYqmkQOe/sCCj+MtjSJtfqM2/B4IsyPbC
         Y7nA==
X-Gm-Message-State: AOJu0YyACp5RpKra6waiX/3CzUT+6zDUEoTvaC6uagyPqOtUWwHwFs3F
	ccrnpZCWW1ER4X+wPtg9Xf16pM7ezuAXu0rgWqVNWXX/8tKkwEyPo5CuYveuEoBzSLTFv1Wiwa0
	5i8NXEFIYNCVTJCNTikGoeGS7DXWeUGeijAizl3sZxFnkoIdFD7Hr3yOqBA==
X-Gm-Gg: AfdE7clEil17mvLWGqHKuexJdvlXLJBDkegTVqjnBB4F35M/QNWI8A5gtpxcFiGAcWM
	GL2FRs+vTst9x8Zzd8LCPnaAd8MsUi09H2KrjMkVavkt3y2EKEO31Njt88kgAKp/bsiYYkoqGtO
	N9dnijCO34Hj+xV6GqbAgmDShiZFokft+hKMwdlDjMtgCG/tVUslrQBKltNyNgssY94rFQuR4wA
	R/ZSp7Sael/TbvF+ge5swxniDujnBcAw0JcF2FpBIuv9dhhXcBiDq65qONt6eqGxl1VKNAVWgIz
	2xoYvaqtPYVnrbH7kWw4o2mmnmmoiuAgSfu7tgyEo29UYBDUEo6jxJ2gAL49f5+qlrqhg3lAxSX
	Z/v5LftEs40Gh2UdGENPMJW2yocWlkPHeZoTH20EAJUJciH7Wj/aSnH28OnKjStVNIUYngNcehK
	ZC0pf52PV1Og==
X-Received: by 2002:a05:600c:1547:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493c3cfb04fmr58962335e9.27.1782986533607;
        Thu, 02 Jul 2026 03:02:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1547:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493c3cfb04fmr58961865e9.27.1782986533117;
        Thu, 02 Jul 2026 03:02:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm80193455e9.1.2026.07.02.03.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:02:11 -0700 (PDT)
Message-ID: <3f540a8a-4167-4727-9516-6fb91335333f@redhat.com>
Date: Thu, 2 Jul 2026 12:02:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
To: Shiming Cheng <shiming.cheng@mediatek.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 willemb@google.com, daniel.zahka@gmail.com, alice@isovalent.com,
 sd@queasysnail.net, eilaimemedsnaimel@gmail.com, imv4bel@gmail.com,
 nbd@nbd.name, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, lena.wang@mediatek.com
References: <20260630023512.26927-1-shiming.cheng@mediatek.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630023512.26927-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270390-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,davemloft.net,google.com,kernel.org,gmail.com,collabora.com,isovalent.com,queasysnail.net,nbd.name,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:daniel.zahka@gmail.com,m:alice@isovalent.com,m:sd@queasysnail.net,m:eilaimemedsnaimel@gmail.com,m:imv4bel@gmail.com,m:nbd@nbd.name,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:lena.wang@mediatek.com,m:matthiasbgg@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF8306F5C44

Note: the patch subject is quite uncorrected

On 6/30/26 4:35 AM, Shiming Cheng wrote:
> The new skb_gro_receive_list() function is missing a critical safety check
> present in the legacy skb_gro_receive() path. Specifically, it does not
> validate NAPI_GRO_CB(skb)->flush before allowing packet aggregation.

skb_gro_receive_list() is not very "new" and definitely
skb_gro_receive() is not legacy.

> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list

I can't parse the above. Is this something that can happen with in-tree
drivers or do you need OoT module to trigger it? In any case please
clarify the actual order and the involved driver. Possibly a stack
strace leading to the critical aggregation could help.

> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 8928756d53d5 ("net: add fraglist GRO/GSO support")

The fix tag is wrong, should be:

Fixes: 3a1296a38d0c ('net: Support GRO/GSO fraglist chaining.')

/P


