Return-Path: <stable+bounces-227602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKKZMDqPvWnY+wIAu9opvQ
	(envelope-from <stable+bounces-227602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:17:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604412DF45E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6D83071C7C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE440318ED6;
	Fri, 20 Mar 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YGblnqZ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E62184540
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030284; cv=none; b=ECKmiza3B1xhD26ik8SrPsZIefhx1rV8FY8mafvKdBrm3gK7ZQeX1W1awxsAZmwlBqE2GNnPzadnxCsT2kCNaSZknigrnO0uogUg5KX0u3JT/i3tuJ42WOeKTOZO/LVZb8kBpemn/16bxKmyl9voCcwgNugiN0BM2XtPwZF1rf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030284; c=relaxed/simple;
	bh=n577oA9CTlQ46aY+TxdqWeVLJkye8cZec/Ba6vMwNvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HS171mcoXrStnXBlwVNUj8G2y2pA32Fv+3N/dwxwNBQOXVPzlBidEVv8hNfJRZFHjsWO23C1NLAkBk4/KW3k0MUkTutMKBl4jsHjkn4K/W5hDH9zWL+3y9rCFaIjAb/HAcFUwC5lWbdF9BJXmqjX2h9+Y4fxXhUn5uahjezUoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YGblnqZ7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-404254ffe8aso1537759fac.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774030282; x=1774635082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivN0r34EX+CatZvjgoIrnFxNuH8epFHqIRcMB1ZVbaw=;
        b=YGblnqZ7NAdmlCEoLkwcN33whe2GmbwWAQkbDjItIna02aZxXTEcRlgS6AR0FufOAL
         MNDvb/z0VPfq/N+8a7hIkPODrVzzOyp6OQxer9B4X2dufUP50qy9F9vcuAHa6nhXUoyD
         wngkimNs/wzpOcci7JU3riNNY+SAGhWyVpa3XI1H/XDmwp06aKE+N5sshLu7lXx62dY8
         ERTDBiVCaDLf1MGAjE7QoxAOT+rtwTrC+bPXIW1XxsyCOGHKJpxklNY2wrH1KqUeL/G7
         xPi1DrmMKoCylHnrnbkQQWY40HgXMdTYHC/HsExaOqz+kmT9xd00/MD0G/8xHMVqQhUn
         VKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030282; x=1774635082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivN0r34EX+CatZvjgoIrnFxNuH8epFHqIRcMB1ZVbaw=;
        b=F7e4P3KzJkDksVSqR4+r1zs7hB1HcwCc/TnLMSpWlJ2kE8sNuO/oAocZN2z07UcDxk
         MeFJBR2yiq5Rd7GtS1hIy4t7ob7ukuCj35Ulut8MdFCKdTirOhqg7M3dHv9Ly3rHmOs/
         emjYrnyFwTmJ/ZGDGX2ZWvGZowFPxuiPpWwB7QQbI9D+rmCkc3SSr8tpktE6EV4FUztb
         DJ4cwst+FKdgnjKlLUrA5dTKXX0AGsnFxVtSh82uyrEWSqPg5uT3dAoZQ14a1LXpnw27
         qhYH0BIKQDZxrOt3e485dDkHlTEdTTf11WuehUjz8VrsCt0GSLDU/y62rdGjCtCOLkVO
         ZT3A==
X-Gm-Message-State: AOJu0YxSasSy9b1Nk3VWQv+dJ6mznrxRqZ6dvsB+HY8IEs7xZpwK6SqF
	IKXS3UAZB1jVx/+Qo43DqN4yfM0sJx3cf+XnN9zywPfAD9UhNIVf32aV2oQoAu1ToO6qgERYyOk
	yC7M38ac=
X-Gm-Gg: ATEYQzxQ9+dAVWrP1NjPPvv8P1XnwGKmVvPlSZY6hgULdv5iRjUlEd53XhhcdSdHpq4
	3RynAs7KjwaYtETqSPdFqOuLVtBkWW3R75nk/jBTDVKiDW0GgdufAONmeGKPAehoLyi5Rn26GnP
	j8NwVPK+lImiZpowuAgzw7LUamQ3Y3v6ms2DvSV6wYJtkz+H+PhlkNR3jgkjU8DkT5gI+wynkSI
	ErQGMywwh7Bp5TgwlE+5BhvhvFM1d6glQpCA3NP7ZSoe7L8CnFfdnlhDslP8T4Xq/hIdxiAi513
	yEFQ57aNKP1OI1Gknl4wsa9h5acahCcLTYTCYjR/jM5PiRMNLOluhqVleen+L0jNJNckM/Xrc4q
	hEuOc2wft/VOqX5caDef3FkZWGuECkDbBsRbekVhak8p7fKwd96CpsQTejWQ87XRU7LgocfjuL2
	NhvZdR0ZrwxEdfD6z3ct1aL/9mBvOh8e1HJP+319ivR5fXRWfdA12rgPMRRtSVuFchvfQ3VXMCR
	K138wjY/iEUqAwfAqQ=
X-Received: by 2002:a05:6870:9a24:b0:408:7ed6:e0a0 with SMTP id 586e51a60fabf-41befcc7465mr5149917fac.9.1774030282137;
        Fri, 20 Mar 2026 11:11:22 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d64fbbsm2287318fac.9.2026.03.20.11.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:11:21 -0700 (PDT)
Message-ID: <de1f70e8-7414-4bb7-8839-101d6cdd01ea@kernel.dk>
Date: Fri, 20 Mar 2026 12:11:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: fix missing BUF_MORE for
 incremental buffers" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, code@mgjm.de
Cc: stable@vger.kernel.org
References: <2026032008-prologue-sarcastic-de41@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026032008-prologue-sarcastic-de41@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227602-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 604412DF45E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 11:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Same on this, fine to drop for 6.12.

-- 
Jens Axboe


