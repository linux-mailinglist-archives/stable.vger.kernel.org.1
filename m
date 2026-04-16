Return-Path: <stable+bounces-238333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ1AEBsQ4WnoogAAu9opvQ
	(envelope-from <stable+bounces-238333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:36:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FBF411C10
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 563A730088A3
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80552291C10;
	Thu, 16 Apr 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLhgogZ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1DC2110E
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357374; cv=none; b=kHnnFsMV30Ua3S7EAz5nHH4Cie5Fm5jip//hH/v90Apth7VvrIyM/9/kDBbqbtBWnKleux6WLzxjvUHMxUsO9okEOrnJYG1wlrDlM5i5/CosNYd5sBjTW261lFBD6RZQOpZg5VLEj7uNtzhzVyB1xCoJ1MVl34E0FXQKbuabN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357374; c=relaxed/simple;
	bh=WJYVQTQOX5tRnf0OyJLQ5jgx6iHDqjgS2DHyFfvjgVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoeSTKUUskc+I446Fk/bYIWCW+orMzDhyziG+3DTYa/gG6WmQ6S1MuAOxLbrVbtBq56y4qMLB5DRLaTqQQ+gz8utonRJR63nIXiDOoU67BqFHPKl735mRhzpxCo40JHbsuEM8k5uUsNrmdY9LUB3oBd3HIpXURU5T+hGPcgVOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLhgogZ3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d74086e5bso3615638f8f.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357371; x=1776962171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQQ9E6o3BV373q2JNSi8afwSKSRwz/rYWGVsBEc8BuM=;
        b=FLhgogZ3ERpT2SXTl7gOGXpRzCrZyr6PnunREmPdKATtYEJrYQIWVhY5nNjh+SP2UG
         FoyIsi6WxiGmBHlYLFYDrNZcGWsL0DC5Hl8KDpsS+f4rH4/jUTvHkHHuE/WT+4UnGFMr
         0zjI12JZlsYvNIfUtY8Irn7wX6A/321SrzI19GI9Zh/qXU2EP7rcP/0rvqxg/pPs2+aZ
         DZLrsKvsuP6nKRwuCzQ06hwhNHPaQK6VmaqlzX0O8Ad1epexC+D7czGQEouAC+HezhM6
         D33cUn7Fg6M496AH/JI6PHk4PzVGYDGAm10KrL5f71LZ/gB6P0cFGiN8POPJzPdZzFwK
         qlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357371; x=1776962171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQQ9E6o3BV373q2JNSi8afwSKSRwz/rYWGVsBEc8BuM=;
        b=C5Rew73DbAKDARpLzISnWWqJj/yZUqpI4Hdm58eOpbkFkovLWtabT00WlWuho6cSzo
         x+f6iEFZu1Snn4UNXfvuUQ4DMn260rxllyH5srCf8aCDIXFCdxmcwMygzlqgHYef8qyQ
         17LhX+l8ohpiTajOd1aqL9n+dcYmKpwkdoBkTpoh4jAhVOxUuJx4+CGGZeuOes+axQou
         qmQUcwrdF5RQWQYUe9t3U4Ym8i18bV0b1KrZx4KYpmr3GLpIdjoPhPIXaJy2Ovf6/5bm
         lJ1Yh69aok0QC0DRvE2inlR3QpMQ2tAqm1dLiV8NNVm9lgdidFU9a9aAU/Q0VmPk05dX
         abhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FGEkH7UdjEWGWGekPqJ/6Vj9U7yaIl7w2oqQFwUznAbGHwXhmQGEGnViXQTQYkRyJE7KSq6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17c564i1fdH6PtFtDUw75/e2plYRHZtraBgyS0ZHqkRgfM5zL
	nCoQSXz7Qs+yxGGYe+iijN3jy2sw2p/bmiS3uQiq/qyvdtamShrKUlMr
X-Gm-Gg: AeBDietCpxA0JH2sFIzbkrE+W94CFk/R2FizJ1KMKwLR+vkFu3UQlU/oMOArwKDvVLp
	vTABc6B4bcH0dftnBBnESmQfB7PukoW+7V1mxceYAS5SZyQLuPgFL/Va8hGuDm7WeNZuqOxJcXn
	+/snra/KQ4zV6XlWPTFJjh0peGQY/uZf03MuNTVeslawH9unPqwVBEcJdBFBsBBIhOdBOJRg4Th
	2znM5n+X9Mwra94Vjk8vn672FpzUotbyjX1EkkAP4MPYKs6bFnXZb52V4Y/wp4GkOj9h+XpbMVA
	07K0fandX3hkG/IkO7+a4MVNvf6AHdfqT6vr6lp89lHgo0j7/VuNmH7Wu0JUIWjNAorcOZPCqNO
	H6IS0FzH1B1BXEz+U9O8UwaIpCbojgIZX0vYlYc5oL3/2jD8IiNHFFI/je3ezkBC8MARZYgLHGO
	pmkEBqb2hQFzZtZXcNukw=
X-Received: by 2002:a05:6000:24c1:b0:43d:7d6f:f529 with SMTP id ffacd0b85a97d-43fe149a3e5mr94932f8f.31.1776357370724;
        Thu, 16 Apr 2026 09:36:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6d3sm15189739f8f.8.2026.04.16.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:36:10 -0700 (PDT)
Date: Thu, 16 Apr 2026 19:36:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
	luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 3/5] staging: rtl8723bs: fix out-of-bounds read in
 portctrl()
Message-ID: <aeEP9qSuokAzDa5r@stanley.mountain>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
 <20260415185501.440492-4-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415185501.440492-4-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238333-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,get_maintainer.pl:url,stanley.mountain:mid]
X-Rspamd-Queue-Id: A3FBF411C10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:54:59PM +0100, Delene Tchio Romuald wrote:
> In portctrl(), when 802.1X port control is enabled and a non-EAPOL
> frame is received, the ether_type is read from the LLC header
> without verifying that the frame actually contains enough bytes to
> hold the MAC header, IV and the LLC header plus two bytes of
> ether_type. For sufficiently short frames, the memcpy() that loads
> be_tmp reads past the end of the receive buffer.
> 
> An attacker within WiFi radio range can exploit this by sending a
> crafted short frame. No authentication is required.
> 
> Validate the frame length before dereferencing the LLC header; drop
> the frame if it is too short.
> 
> Found by reviewing length validation in the receive path.
> Not tested on hardware.
> 
> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
> v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
>     Reviewed-by.
> v3: rebased on staging-next; sent as numbered series with proper
>     Cc from get_maintainer.pl.
> v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
>     apply).
> 
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 28 +++++++++++++++--------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 00b69571bbb83..c0a1c2ab710ee 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -539,17 +539,25 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
>  
>  			prtnframe = precv_frame;
>  
> -			/* get ether_type */
> -			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
> -			memcpy(&be_tmp, ptr, 2);
> -			ether_type = ntohs(be_tmp);
> -
> -			if (ether_type == eapol_type)
> -				prtnframe = precv_frame;
> -			else {
> -				/* free this frame */
> -				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue);
> +			/* Ensure frame has LLC header and ether_type */
> +			if (pfhdr->len < pattrib->hdrlen +
> +			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
> +				rtw_free_recvframe(precv_frame,
> +						   &adapter->recvpriv.free_recv_queue);
>  				prtnframe = NULL;

I feel like it's sort of weird to write this as a pfhdr->len < condition.
I feel like the untrusted part of the condition is the pattrib->hdrlen
stuff and normally you would put the untrusted parts on the left.  I
kind of see what you're saying that the packet is too small, but to me
I see it as the hdrlen is too big...  But, also since you found the bug
then you get to choose the style on this, so do which ever way you feel
is best.

It would be better if instead of setting "prtnframe = NULL;" here,
you just did "return NULL;" instead.  You've followed the pattern of
the existing code, but the rule is that if the function has a 100 lines
of bad style code, you should add 1 line of good style even if it's
inconsistent.

It makes the code slightly better and it makes the diff a lot smaller
and clearer.

regards,
dan carpenter

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f78194d508df..9cedca1bd83a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -531,6 +531,13 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 			/* only accept EAPOL frame */
 
 			prtnframe = precv_frame;
+			/* Ensure frame has LLC header and ether_type */
+			if (pfhdr->len < pattrib->hdrlen +
+			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
+				rtw_free_recvframe(precv_frame,
+						   &adapter->recvpriv.free_recv_queue);
+				return NULL;
+			}
 
 			/* get ether_type */
 			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;


