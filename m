Return-Path: <stable+bounces-238207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMbQH2Tt32kCagAAu9opvQ
	(envelope-from <stable+bounces-238207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:56:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4D40775C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D230930268BD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD35386C0F;
	Wed, 15 Apr 2026 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvl8VI2y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78525386442
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282973; cv=none; b=grThu+ze6tMupxJDRvuZKXyQLzD9rYtd9+7JbU1trDzWWQ6uifX7awYi/kYjLtAvXRs0sVBrQ83ICBxQrV27SuCmPlRHwCOeCzBWKhs85bfw0tT//fSUJYNCHO2GOpWOVO2Cdj4bV6WfBCdedF+NqwX5LI1OkMKOlwOEPeghy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282973; c=relaxed/simple;
	bh=W1LTulubr9TL/UfwjdegdwUx5akyKQxeDDaubGeE7mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbnLw3DYvF2tirheFKg3jKVKloyzgz2mCvdlH0U/HJldL2xbW8WlTLGmdADXkTz/s8hJAyPImKZ7lF+JVgTA6FBtXy9mxrptYVKRKH7dELZKVqYh8NSU719QHJQawmgzJZbqu0YvKiB+dSL8te60JjClmDzazN8KR9+UceVMr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvl8VI2y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488c2690057so73086435e9.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776282971; x=1776887771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEl2OJLVmeUKNE3lrILu4jNBkDcCdXL1nw4osbZOHXw=;
        b=Bvl8VI2yys1H7B9OkObbi3hado56F7k6mjQD3ebmSxQS8/6fsNmNBUJhgr6ue8xKuB
         dx91kGeHSDr3Pvavk+9QWJFE/WgTy5Sexhhf3UEarTorhOY9sPFmozts5GVxXa0gqgCD
         c1VNTQQ9GPejYM4Hhtu4JxUqxGLWlW1zDOefuwJY8Bo++sPhdWeiAbfSp+RQhG2W2vzZ
         oK+zFLfusir4NZEmNa7U3O6YSwbSNLeUwA+U1w792/FvFMKWmYNMgtRierKfhKIKR/wG
         pz8TxH5K2Q50rFLAgH3AJk7IT7G7doUWITN9ZBISIlmULFoS7hrB80N8J6uQIevhtLea
         AzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282971; x=1776887771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEl2OJLVmeUKNE3lrILu4jNBkDcCdXL1nw4osbZOHXw=;
        b=R1/yLLwwtPxr5OK9nXsxmhBVhBOgPkaCK/cIq0wwF6B+fsr7v9UxYLgOZl2eM/VG6m
         /YZMhtHojljGC8dzMOTD9vAFchnKGJGULGUOT+K6OBGSEzyX2z4T6YlWPvyxN/hfzEwA
         YcW6QMKs7k41O6BfaO0pS4hEW2rhuZ4c8kD8I43aLEOKBqbkfyhmLFu01uj/ERmboN09
         ONxSgLhqjKaNBYb32Ij8synttfKTElcYnWMoMslde0rwxOXYfMgL3aHuFAAPyM4cPJOf
         QkEaJsUEHm9TCmQFVzmGl+JBC4sau2tmoH7Cke22xwsUiwflkfVOVSkV1SU40bWVmPPf
         9o7A==
X-Forwarded-Encrypted: i=1; AFNElJ9yQhux0Xl9GuRk+X/Fl1yKk+46SuygVVDgFXUVRXymbMsQf+GDaeQ6z4VP1hxVM39WOeggQRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIgXRPraXUwSgUgj4mqiB+wjqlttljX3ZDveou7o/9/vEBjaI
	sibSgD2RcbhtZoV7f235lwk44jcAcq+yVGm8DqDuKn8AZ1HDTjwEWTyL
X-Gm-Gg: AeBDies+Zv/synTkEjG4PZpVWRuTMfoa248tzOKhqTE8imwVenbPwCnW1TGggZ5zqQw
	HgLrgPdpjvFDKYcyCcFc/PtMMHIpTpxlkkc5uXSyO4EAqkiT1B1+sr13olq1JQkrjp6vIuC2GL/
	ZIKcbQtfRxFG5SV9Hs6w8s7I/rMRyN+8F6QaEvqT7Ip7D9a8Pcgdfb0g16TwHCsJSucxJe12B/3
	KRki+mlz760FsECjfxiPkntXvS7iMfxItR1fY7SJK/Xn4y901unIsBPQw959taB+1tIp7OGyiT7
	M1mh9nbxof/o2c5//hZyQqv3YMyhceTLKQDJah6HP19aPji4k9iXLhvLgs70/ZL7LwRlCvZoBaB
	2OKcgdMiXaAGIFJsK9bmGbFebsIDbFdljUm+2g4PPtrlVjUa0EuHCZ9Q+0O/k6e0u1yL4AbqRMe
	ldnGkxsdeyAizoIzmnu1YRV77Desi36A==
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bd9a with SMTP id ffacd0b85a97d-43d9bb5bfbfmr14140449f8f.23.1776282970578;
        Wed, 15 Apr 2026 12:56:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fd6sm7761528f8f.24.2026.04.15.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:56:10 -0700 (PDT)
Date: Wed, 15 Apr 2026 22:56:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
	luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/5] staging: rtl8723bs: fix heap buffer overflow in
 recvframe_defrag()
Message-ID: <ad_tVr0Pyz9ws01I@stanley.mountain>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
 <20260415185501.440492-2-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415185501.440492-2-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: E8C4D40775C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:54:57PM +0100, Delene Tchio Romuald wrote:
> In recvframe_defrag(), a memcpy() copies fragment data into the
> reassembly buffer before validating that the buffer has sufficient
> space. If the total reassembled payload exceeds the receive buffer
> capacity, this results in a heap buffer overflow.
> 
> Additionally, the return values of recvframe_pull() and
> recvframe_pull_tail() were ignored. On failure those helpers revert
> their pointer updates and return NULL; continuing past such a
> failure would leave pfhdr->rx_tail at its pre-strip value, so the
> subsequent bounds check against rx_end - rx_tail would operate on
> stale pointers.
> 
> An attacker within WiFi radio range can exploit this by sending
> crafted 802.11 fragmented frames. No authentication is required.
> 
> Check the return values of recvframe_pull() and recvframe_pull_tail(),
> then verify that the fragment payload fits within the remaining
> buffer space before the memcpy().
> 
> Found by reviewing memory operations in the driver and tracing
> buffer pointer manipulation through rtw_recv.h inline helpers.
> Not tested on hardware.
> 
> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
> v4: check return values of recvframe_pull() and recvframe_pull_tail();
>     drop unnecessary (uint) cast; add Fixes: tag and Cc: stable
>     (Dan Carpenter). Luka Gejak's Reviewed-by dropped because the
>     code changed.
> v3: rebased on staging-next; sent as numbered series with proper
>     Cc from get_maintainer.pl.
> v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
>     apply).
> 
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index f78194d508dfc..a739c2bada2a1 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -1127,12 +1127,26 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
>  
>  		wlanhdr_offset = pnfhdr->attrib.hdrlen + pnfhdr->attrib.iv_len;
>  
> -		recvframe_pull(pnextrframe, wlanhdr_offset);
> +		if (!recvframe_pull(pnextrframe, wlanhdr_offset)) {
> +			rtw_free_recvframe(prframe, pfree_recv_queue);
> +			rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
> +			return NULL;

We have four blocks now that do exactly this...  Add a cleanup at the
end of the function:

	return pframe;

out_err:
	rtw_free_recvframe(prframe, pfree_recv_queue);
	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
	return NULL;

Btw, I'm planning to review the other patches in the series so hold off a
day before resending.  If I haven't reviewed them by End Of Day on
Thursday, then I have gotten busy and feel free to resend at that point.

regards,
dan carpenter


