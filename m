Return-Path: <stable+bounces-222561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMQ8I/dhpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:09:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB01D6176
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F483040448
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B86395D96;
	Mon,  2 Mar 2026 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeQ55TbE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA29394470
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445788; cv=none; b=WsBi61rAsdTmwe+Mo1k93idqMCioH1EEKLZVla4QBtg6f4OgDcmmKIYlFSG7e5c3SgNK/4laztHqjZvwyk6su4gOhX7nsk0AQOOTPSaxfOpWAnZly+Y8lTbfR7QmAscCZK3VPlPAFP+PqIW4PWDmZRGdNya9kWyj78dobLuNIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445788; c=relaxed/simple;
	bh=57fRY/uldheHXz8pZoqfNhRreb762+PjD5Xu/G23mGs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qES6GsmduRECPiN4TJJIrBk5J7Qa9caYcAkxqI6TyWtxVBtKXeekRLgj4cS9xdJ5efE/GAycf/nCC1gmhQjPvm+naWsowxxD7Ziv+l4FszIVn0qtUzJ6IMdoHjKTiBgw//h15zzgWb8HXNNnvuSZzbaAcU4ukg3kABJ7V3tfjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeQ55TbE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso35492425e9.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 02:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772445785; x=1773050585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTyW8POl7cRW2tLQQUG/rmH31BNr8DtkbGHz9hqNo+Y=;
        b=AeQ55TbEJ4+BNiv3stRXgs5A3PNsqv4J+3uGvPgvE9/abEtWwXB7x3rC6Gb7UMlsQ6
         fHP5LJfTSQmY6iAjAFjZhtEtlrKxygz+PUmjsRd3QFSckT9JZdxkI6Ny6PzMkC9uHyWT
         oVUcTaFGtSokkpgdmtlvk9NJOyub/S3Nk3BdfOgjOvLsPIJeOWhsfHEfqgzECs1IjWO6
         VJkLuQGxSNZI8gXsR5OFNxlWfKJsiBqpN3Zk7UnFEOtIC9PyMzy+ddnVpktn/oCDXGFy
         6LCZbTtPjFVTwEfsB8EVWQGwHAeVAoQ2deOGqNT3osJwD+TlzLS1Xrj1nEBFDzFliyi9
         fGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445785; x=1773050585;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTyW8POl7cRW2tLQQUG/rmH31BNr8DtkbGHz9hqNo+Y=;
        b=p0q/8eXy+d9nfAdhQc0981D0ESlKbhfCjwbkPikw57Up3tOryJ4r2+owb4vv1BRz4H
         wrMuUribXtRMVH7F4cQs5DVAfa/FfUnJ4r2ntw43/Ww+7fVBA69x2/zrCYs4GBaCId/N
         3ZdxmB1jT9J7APaAnu7rD5ReXCWmzwHSmp8pwj3gHXSxLpShXn+3iIylmbHRCHjAuHhB
         BqHuASRrhgtiIWe0pHqAFjKi1tEReHTiR7pQfWaZHHK0wmrEH8C8RYe6UcKpK8D4xlh+
         cbK9kDHocCwUE6ZsH7sSjw4jEQwvzA0//HaBGWBVHbHHSPlIv37RXCEFOrsIA+JOoayG
         V/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXty52dc35An35HNd/oBSB2POfdfyjEPrGgn1ry8ewvQFkmSOFWF//WPDYW/bKawlUVFasJyZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI24SBTqRYD1zOwS1OMyb/nEPKktpka2bO9x2WBc9lnLqhyb0j
	E7P4tjXrcxHLqsMQnzwpp/TSYFJfXE16cE1t9EQurilOrSYMepPXO/Lq
X-Gm-Gg: ATEYQzziGAgCmLuF4cnEPRUHS9R34bv/rpoAoyJMzwWK+/tXGpvGyKuQudGAiQOIds4
	SxIbPJ5PfLozxVKgyD6JyA6vwZzqUJf4+V4/Z0kA1sahoTcECrRSEE2nm89cBeO8R9mOSn0Kqg9
	vHxwYALPsocu2WYTYWnKTkhxrMKEy7n6Z3FAcCCd99gMMcHAY/ANQBcZGwXymb3HdDeeQynk2To
	6FPpQjcRThk4s5hbdpCA5Slls61QbhETGW4I/qZMEKERNdb0mZur8nWuuznSRQk/s5+Rc7zf92P
	fHBJB4IfzPa03TdASLyfo1IV0E9hjpXSwVKUorde1gNb0jHIhh9ZoXkgVGIj+fmJS6ahSTuf1pX
	xz9CjNyzTcCfdjxP3nX+/Fdsh2ZoJrmkXH1Pesf1DD+JttxBqALSB/1fUkkmeQPQzTV+AbcsWbX
	JP2s722JtbsQ/ASLGjMhQ5UryNUhe0VZg9Yoa9p7+15ZBM3ZOwIOhKV9wo/KYLDicrwweocj56d
	oJAwHwn1+GRw911OMlNICIE9fzpXtrPT5lxrLVS51SebGvlonTq7CP7YqA=
X-Received: by 2002:a05:600c:8b11:b0:483:6f7c:19f4 with SMTP id 5b1f17b1804b1-483c9c0b6c4mr201046285e9.30.1772445785317;
        Mon, 02 Mar 2026 02:03:05 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:773b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c765c67sm28190288f8f.32.2026.03.02.02.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:03:04 -0800 (PST)
Message-ID: <53896290-9a0a-4822-854f-945595a19fe0@gmail.com>
Date: Mon, 2 Mar 2026 10:02:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: FAILED: Patch "io_uring/zcrx: fix post open error handling"
 failed to apply to 6.18-stable tree
To: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20260301011746.1671806-1-sashal@kernel.org>
 <002c2bb8-3304-40e0-b8c6-8eee7dcb7710@kernel.dk>
Content-Language: en-US
In-Reply-To: <002c2bb8-3304-40e0-b8c6-8eee7dcb7710@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222561-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02CB01D6176
X-Rspamd-Action: no action

On 3/1/26 13:22, Jens Axboe wrote:
> On 2/28/26 6:17 PM, Sasha Levin wrote:
>> The patch below does not apply to the 6.18-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
> 
> Looks like this has dependencies on parts of this:
> 
> https://lore.kernel.org/io-uring/cover.1763029704.git.asml.silence@gmail.com/
> 
> series. But seems easier to just do a variant for the 6.18 base,
> I'll leave that to Pavel.

I was thinking to remove post open error handling. xarray is preallocated
and shouldn't fail. And copy_to_user can be moved earlier. Should be safer
than taking all deps.

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c524be7109c2..c6ac7365acae 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -625,6 +625,14 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
  	if (ret)
  		goto netdev_put_unlock;
  
+	reg.zcrx_id = id;
+	if (copy_to_user(arg, &reg, sizeof(reg)) ||
+	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
+	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
+		ret = -EFAULT;
+		goto err;
+	}
+
  	mp_param.mp_ops = &io_uring_pp_zc_ops;
  	mp_param.mp_priv = ifq;
  	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
@@ -633,21 +641,11 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
  	netdev_unlock(ifq->netdev);
  	ifq->if_rxq = reg.if_rxq;
  
-	reg.zcrx_id = id;
-
  	scoped_guard(mutex, &ctx->mmap_lock) {
  		/* publish ifq */
-		ret = -ENOMEM;
-		if (xa_store(&ctx->zcrx_ctxs, id, ifq, GFP_KERNEL))
-			goto err;
+		xa_store(&ctx->zcrx_ctxs, id, ifq, GFP_KERNEL);
  	}
  
-	if (copy_to_user(arg, &reg, sizeof(reg)) ||
-	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
-	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
-		ret = -EFAULT;
-		goto err;
-	}
  	return 0;
  netdev_put_unlock:
  	netdev_put(ifq->netdev, &ifq->netdev_tracker);

  
-- 
Pavel Begunkov


