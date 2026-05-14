Return-Path: <stable+bounces-247135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OuNDh2CBWo5XwIAu9opvQ
	(envelope-from <stable+bounces-247135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:04:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5EE53F0DF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15BEC30160CE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EB3B6362;
	Thu, 14 May 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk2ah9IM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7j32k/v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3A3B7773
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745879; cv=none; b=BSTcmMX+vdY24XMlBm7kCVxDldpqyEUT6Yuh56lfeUSkEpwCYUfsKniPuDXYbcwSHw2bY+lS/tzawhjx4DeS8npzNMm+yX3vyuRRgifISrA/ho0fKleVPU3XjBceyZBktDDjc/KI8zzqF0+0TNCNa+3OeLi8BZbennDjiWWq4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745879; c=relaxed/simple;
	bh=pR8bXbbS4u5EKNRXj2zEHOpJiVcalT/ukEuzNpKEJB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W65DhCJxujD/hYVWWPiCO4P0gT0Fuyaa/DSXkAeoz9/kgMNUBsgU4bXjvm2xCEPqBd7ed7Aljmym3Y5PZA0R6bCQWZJwi7iBvb96iEztRXqv+krY6dGwlaIOt3wistqehHY1CwJDxV9CO/gKOsnp7rcVscrRVTwd4Tv76GUrW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk2ah9IM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7j32k/v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778745875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxZzKQ4uRfadsTI1kktYrRaUnAmhPKZRac2rb7z5so0=;
	b=Bk2ah9IMKogL89rLhHhwztxO0QK7eWU2PQdETqBYi6o4KCExfZysNfi1FB8cVDxJm/zhT6
	ub07CYjQ1/1RXrwg4KS7QH/zSF/PZ9Pfg20sXt9t4Pb9mNS2b9SR2jIAJgY8GJih2A5z/Q
	2kZ8dT+FLei7137byLAxzu6uKI3iea8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Y0I8qfgXOH-9k_2SZ2Nv-w-1; Thu, 14 May 2026 04:04:33 -0400
X-MC-Unique: Y0I8qfgXOH-9k_2SZ2Nv-w-1
X-Mimecast-MFC-AGG-ID: Y0I8qfgXOH-9k_2SZ2Nv-w_1778745873
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44b186b715aso4833360f8f.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778745872; x=1779350672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxZzKQ4uRfadsTI1kktYrRaUnAmhPKZRac2rb7z5so0=;
        b=S7j32k/v8XVsIPWVPNhxrwIH5Qy4IDl8d5BHk5P3ISMxGkK6+9n9DEpHpg9bRZuJ7t
         AVSBPAK2EkHOCUenTMkMUnJ1LJWPAW46fyuguentTetYKzllP4MiWw4YqJfu5p20KyX3
         DztRETGEYFqFtb3/6qe2QZYO/3r2+VOpSZ0bfKDvfUp7n/ST+rNX6siyZ5jdGNOyxLzP
         UHGNyvyNQYUZ4rZJMHCsRSxzEjJP3oX6qRarQ5g1CZr85qRb5yMEActKk246TJRgd2Ff
         fPQG93/pJOZdE1aC6UQw2sEowilL5Y1SEx2aW6awOSVHK27COYyD74zUw0mY6XyuBxeW
         fohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745872; x=1779350672;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxZzKQ4uRfadsTI1kktYrRaUnAmhPKZRac2rb7z5so0=;
        b=r0fpDCFK6ix3wRvI1+2dk9/qcUuQr/fesePXcoTWw5h48BcdFVFD4Buj8WQN3NzuQ7
         xgLSbq+MxwxRYoes7PTF9fZz6Q0eofYK6YltiFRB3btIhUvbPiELtm4ioOr01Wj1Rt4l
         AmhYBQC/P9CcBWl5u8+mTEPjUCieo9WD7sYSmLDPIWTJQjfhHW9hpTXWv/pKaJA+1bvs
         OnhB8SuQ7CdJzcc31FvuaMFT1C/T1B0fY6pJ0qdKVIjzKRt0caDlyhVPQQG3QpnnD8M4
         EKUvH9UF3Yq/Z9Ii4tyyKjAFXeeAspbDT/Iyvu5Y8hXEjnS2UiNa5ta+kTIM9awKWNwz
         yJow==
X-Forwarded-Encrypted: i=1; AFNElJ8AJru0N04zSNM6Yb2h+fbEs04PIQru2IvFy0lRY5laB3N/gw45O4VqjeViykcg7nZbr2spJSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3poUUbu5kBYDr3FZfD7l4KopUWFIJD2Szen7vGWwlr2OGrieX
	1ZzDMCAz1K4F3xHbJShw5M2q1UyrwnoIUKFWU1IyGJ+F8JOu1HTKavD2ruoFMcraKUWnf5h9vLE
	2PAHDbdU+wXqSpV3zXQGqBf/Ia2WnCzi8KY+LghTQRCd3VRtH4bsGPSU8tw==
X-Gm-Gg: Acq92OGK3i8dkgTm8ET9eNuHi2FZvxKPGQ2wodNJRKXnWtnJ1z0cUhOZVDtPLK7SSYH
	OKFMjLH8zkUY1h8qSCXYpJEqQi+FSi7IDIrBkHQ22n3zU5ilJlDOLwQ6rV1Lrq91pdHgh5LAace
	LQXsTCDxTh8KqK3CY8pxafYtpDyt8XzYEWPaeKcOBHbqP5ElAcVq77k7oqQ2+eJcFB1UDpypCXI
	TVLLXV2JkFvkBB+DYEQhxc4z3aBAXzODRdni+8uxSLG/sVQfH1uZ5r379ZeVLP0IWaXDki7NdHp
	iJz2bzOfQpO0BnP0wpNKsXoiG4WFxQT8GSlr9pKDI2/Ix5KhP7b09yt+txVYvCwoytktdpsZhid
	eaT4oqxQZWfWRrX7m5pBUJvt+EzcZiR8UZmtdJulaNv+4AvMN1kgVPCBtYL3eMMsvxA==
X-Received: by 2002:a05:600c:4858:b0:48f:da34:ec6e with SMTP id 5b1f17b1804b1-48fda34ed73mr17828605e9.24.1778745872148;
        Thu, 14 May 2026 01:04:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4858:b0:48f:da34:ec6e with SMTP id 5b1f17b1804b1-48fda34ed73mr17828015e9.24.1778745871574;
        Thu, 14 May 2026 01:04:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498a7esm44622505e9.4.2026.05.14.01.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 01:04:31 -0700 (PDT)
Message-ID: <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
Date: Thu, 14 May 2026 10:04:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
To: Hyunwoo Kim <imv4bel@gmail.com>, kuba@kernel.org,
 steffen.klassert@secunet.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, mhal@rbox.co,
 davem@davemloft.net, horms@kernel.org, edumazet@google.com,
 kerneljasonxing@gmail.com, herbert@gondor.apana.org.au, vakzz@zellic.io,
 kuniyu@google.com, jiayuan.chen@linux.dev, ben@decadent.org.uk,
 dsahern@kernel.org, Sabrina Dubroca <sd@queasysnail.net>
References: <agToIEDI4TaTNLRb@v4bel>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <agToIEDI4TaTNLRb@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9F5EE53F0DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,rbox.co,davemloft.net,kernel.org,google.com,gmail.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-247135-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,secunet.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 11:07 PM, Hyunwoo Kim wrote:
> Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
> and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
> skb_shinfo()->flags when moving frags from source to destination.
> __pskb_copy_fclone() defers the rest of the shinfo metadata to
> skb_copy_header() after copying frag descriptors, but that helper
> only carries over gso_{size,segs,type} and never touches
> skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
> descriptors directly and leave flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")

WRT the 2nd fixes tag, I *think* f4c50a4034e6 would need
additionally/instead a follow-up similar to the one mentioned by Jakub here:

https://lore.kernel.org/all/20260510084520.476745b5@kernel.org/

/P


