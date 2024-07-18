Return-Path: <stable+bounces-60581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A399370FB
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 01:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB8F2826F4
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED621145A01;
	Thu, 18 Jul 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZVpCKEI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C377F2C;
	Thu, 18 Jul 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344070; cv=none; b=gafTRQOWHrPu+LNKRPLd/fIgJ6vM0z2Yhbx30vHn7dRfXFXwOB8r1S0u/20qJ6HPqZJ0mxVxoFp9+7tDxMHoQosd+dFI0jEXIhN8KEpEB9aKOrKZcPquuZTf9m5/dGXXpsv7HqxPO/HJ8eoYmZVCVVXdBG9iWV6uqUKzds0IRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344070; c=relaxed/simple;
	bh=gPNJI135KSMGR9LcMGzqjiRNwasxQqERFFQXkFteG/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O+NWwM/p0OUNeWyYv2hsLwQX8/Qkaow6Mz+q1VdmqzMnxJSZ8nVOQqn8zS2gWvusfouQRiUuZqZEN4D0Dr7vuASPnnLiW6eF5E+KkUxPmWm1ANhRKWthNxQzo4eFFTA+pj0Kga/GDAKlJTNfjbrBLS7OxpmCqA2Dw8TsCMhV08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZVpCKEI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f0c08aa45so54263085a.0;
        Thu, 18 Jul 2024 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721344068; x=1721948868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FltS2dAB/qLasUrVJjG5fa1PWnsM794LnAQsql21PwY=;
        b=iZVpCKEI9pJoS5cq0eXQ2hAll2WeGZn3jHnLatJsgEgNNIDz1RZxBbj/tgIOLjMtH6
         OeGrDfR4PMjTve4AaXUq/SKwrLvsyfnfV0zndXHqZK/pWM+J4XYBjTHm0+ZsumJM7hfi
         uLhPdlbRGqRVSa0ZQQmp1GgsCb+tCVLbxqxjxWOu7Ep0+f39r0C9xtXddert1kgF8/4b
         5N0n7Tes/oHI4vjkiStsVsIZxG+1wkfWu8MoTUY5IHWNgqFsK2eqJ90f9uWkPTm9RZv+
         Ba/AcHUIBdHTPgGdEvVfBhf/uWH166VP41nMkgAv29i2OUiipljjF1u1hR7A8u1exiin
         +9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721344068; x=1721948868;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FltS2dAB/qLasUrVJjG5fa1PWnsM794LnAQsql21PwY=;
        b=cFD+SYPicSjMoyLi3e0I4dDpA4HBQ+wJZqHfznxUy2wXHny6xXHh9M+nRIpMG3k2Y2
         6DJiqyBof16JOFEwmNpzSJu2/J1w0FrqEON6l3SwOCRf81uMhDDf8oaiRbspmf8jKOOn
         cPBpK1jcHj2uBCQes82rbOe1+Z1AzUL2gxa/3rAta+H/VSCEkg0aBGptNcYZqCl8YHzL
         5SU0BPcbc/UP4I8mABqcuCl/T06XKb+V/LRASS70yP8UlaU3UUmhDIfJoHfZtZGNukAX
         q+YZ6hwuvWgC+3WLnev+szUEfP38tvMyrnw+uAUi9H64rVCnTSvhFpm4HlOEaWPJhOHn
         hqog==
X-Forwarded-Encrypted: i=1; AJvYcCX/N/a23OAd2ntNxlv9l6lRiiTI1QFUT4CH1IguH+jMOIhgaWfx09kzr0zIPk0JQuwpqThinVCU+7i6/vRiM+PL9Xy2XdC450m3oJc1mON4Qe5BBpcZ6/T52pA400ix
X-Gm-Message-State: AOJu0Ywd8HL0CxCEoTpeCCKInAiaJdseDzO9sy5HF2o3oOVCeV3GaYNG
	k6rI0MNdKKiCMbSLB4vTgy2/HQbKcxFFowuCW6lYhNeyuLYED2RAiABHZg==
X-Google-Smtp-Source: AGHT+IE6D4XcmnYNxavWv7T4X4fWUNkWjIX3smq3RfRvJuuxhPlLHz+DpBBcfNYdT/Haqnlm69jAXQ==
X-Received: by 2002:a05:620a:28cd:b0:79f:12e9:1e71 with SMTP id af79cd13be357-7a1937ad55emr306707585a.0.1721344067882;
        Thu, 18 Jul 2024 16:07:47 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198ffe9d4sm10774985a.63.2024.07.18.16.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:07:47 -0700 (PDT)
Date: Thu, 18 Jul 2024 19:07:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 shailend@google.com, 
 hramamurthy@google.com, 
 csully@google.com, 
 jfraker@google.com, 
 stable@vger.kernel.org, 
 Bailey Forrest <bcf@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Jeroen de Borst <jeroendb@google.com>
Message-ID: <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240718190221.2219835-1-pkaligineedi@google.com>
References: <20240718190221.2219835-1-pkaligineedi@google.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Praveen Kaligineedi wrote:
> From: Bailey Forrest <bcf@google.com>
> 
> The NIC requires each TSO segment to not span more than 10
> descriptors. gve_can_send_tso() performs this check. However,
> the current code misses an edge case when a TSO skb has a large
> frag that needs to be split into multiple descriptors

because each descriptor may not exceed 16KB (GVE_TX_MAX_BUF_SIZE_DQO)

>, causing
> the 10 descriptor limit per TSO-segment to be exceeded. This
> change fixes the edge case.
> 
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Bailey Forrest <bcf@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 22 +++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index 0b3cca3fc792..dc39dc481f21 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -866,22 +866,42 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
>  	const int header_len = skb_tcp_all_headers(skb);
>  	const int gso_size = shinfo->gso_size;
>  	int cur_seg_num_bufs;
> +	int last_frag_size;

nit: last_frag can be interpreted as frags[nr_frags - 1], perhaps prev_frag.

>  	int cur_seg_size;
>  	int i;
>  
>  	cur_seg_size = skb_headlen(skb) - header_len;
> +	last_frag_size = skb_headlen(skb);
>  	cur_seg_num_bufs = cur_seg_size > 0;
>  
>  	for (i = 0; i < shinfo->nr_frags; i++) {
>  		if (cur_seg_size >= gso_size) {
>  			cur_seg_size %= gso_size;
>  			cur_seg_num_bufs = cur_seg_size > 0;
> +
> +			/* If the last buffer is split in the middle of a TSO

s/buffer/frag?

> +			 * segment, then it will count as two descriptors.
> +			 */
> +			if (last_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
> +				int last_frag_remain = last_frag_size %
> +					GVE_TX_MAX_BUF_SIZE_DQO;
> +
> +				/* If the last frag was evenly divisible by
> +				 * GVE_TX_MAX_BUF_SIZE_DQO, then it will not be
> +				 * split in the current segment.

Is this true even if the segment did not start at the start of the frag?

Overall, it's not trivial to follow. Probably because the goal is to
count max descriptors per segment, but that is not what is being
looped over.

Intuitive (perhaps buggy, a quick sketch), this is what is intended,
right?

static bool gve_can_send_tso(const struct sk_buff *skb)
{
        int frag_size = skb_headlen(skb) - header_len;
        int gso_size_left;
        int frag_idx = 0;
        int num_desc;
        int desc_len;
        int off = 0;

        while (off < skb->len) {
                gso_size_left = shinfo->gso_size;
                num_desc = 0;

                while (gso_size_left) {
                        desc_len = min(gso_size_left, frag_size);
                        gso_size_left -= desc_len;
                        frag_size -= desc_len;
                        num_desc++;

                        if (num_desc > max_descs_per_seg)
                                return false;

                        if (!frag_size)
                                frag_size = skb_frag_size(&shinfo->frags[frag_idx++]);
                }
        }

        return true;
}

This however loops skb->len / gso_size. While the above modulo
operation skips many segments that span a frag. Not sure if the more
intuitive approach could be as performant.

Else, I'll stare some more at the suggested patch to convince myself
that it is correct and complete..

> +                              */


> +				 */
> +				if (last_frag_remain &&
> +				    cur_seg_size > last_frag_remain) {
> +					cur_seg_num_bufs++;
> +				}
> +			}
>  		}
>  
>  		if (unlikely(++cur_seg_num_bufs > max_bufs_per_seg))
>  			return false;
>  
> -		cur_seg_size += skb_frag_size(&shinfo->frags[i]);
> +		last_frag_size = skb_frag_size(&shinfo->frags[i]);
> +		cur_seg_size += last_frag_size;
>  	}
>  
>  	return true;
> -- 
> 2.45.2.993.g49e7a77208-goog
> 



