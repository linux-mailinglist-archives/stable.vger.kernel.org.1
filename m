Return-Path: <stable+bounces-254400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C5rKPXVFWrRcwcAu9opvQ
	(envelope-from <stable+bounces-254400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:18:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807E5DA836
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50757303E4D1
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC34028EF;
	Tue, 26 May 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pj6uwUjc"
X-Original-To: stable@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A2402435;
	Tue, 26 May 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814733; cv=none; b=IushxSgJ9odq3ir6EahAlTu2jHDH84pzsPkMxRE2WsoS+Mprl6WC4d+BLQYn46tiUqj+B5Ce+tltQYG1IbqYyOfHQPJHPz2v9NZC/uyBOanJHKKwb2VND9xo0Zb92tXCE4Qkm4qu1za6iA9q1EA2Vdn02eEmDeeFmq48g7l/0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814733; c=relaxed/simple;
	bh=zVkBDy4IKD52m3+Sh+8FAPKpGKyNWyO1dU8YkOUgdRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDC2T8hZco3fWc5nm/D/AVL1w00LTypMOX+Lr5dRIQBt/13BKISPBEys6YYGRAdqAjyr6AgYe5bIIMUsIK9xrZ4C7ycRKTCM9qPr1fRYLiO1Gjq37R5fwLTnUT0Goj3yAXNUtMNGwH11YbPxIyH4+wIZJhG+kNJ6w6bvr4HvVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pj6uwUjc; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gPzVM6XHqzlh2g9;
	Tue, 26 May 2026 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779814729; x=1782406730; bh=zVkBDy4IKD52m3+Sh+8FAPKp
	GKyNWyO1dU8YkOUgdRE=; b=pj6uwUjcQlaEcRKa2yr7GSn6ih9RtE2AoxlWkBtr
	Q9slddaY+20WsEry3rnd0/Ruh3TZ1Oddc0vcjDWmIXRkY8UXJdsHsAcu66fVSKvH
	2qHW8v262GLAvR0mKkS2qVQ7z1cvVE1b9jC3j7lxEc3ifFleWRkqQ3JL8bYLTCcj
	mkVvFD9690c6SxDDw2oZScjevcjoCWpWifVoQNoziJx7hd3FP/rzKkbePKBs4DSw
	GGU+QB/ZrpPbIDiTcftsU2+ZVgGbzjlueBbRVSB+SBKjB82Lko+SaWpKm+RpPEVM
	Aul05jyN4Lf5zzBgfS1XKExIq4SEtVGSGacl++/d1X+mIg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nORD2Q18jygU; Tue, 26 May 2026 16:58:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gPzVJ1990zlgr48;
	Tue, 26 May 2026 16:58:47 +0000 (UTC)
Message-ID: <36dfbcac-91a1-4bd8-b496-3309b20a30f1@acm.org>
Date: Tue, 26 May 2026 09:58:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-mq: fix ws_active refcount leak in
 blk_mq_mark_tag_wait()
To: Wentao Liang <vulab@iscas.ac.cn>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526103722.2287587-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260526103722.2287587-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254400-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: 4807E5DA836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 3:37 AM, Wentao Liang wrote:
> blk_mq_mark_tag_wait() calls sbitmap_queue_get()

I don't see any sbitmap_queue_get() calls in blk_mq_mark_tag_wait().
Additionally, I don't see any other code above the modified code in
blk_mq_mark_tag_wait() that modifies sbq->ws_active directly or
indirectly. What am I missing?

> Fix this by calling sbitmap_queue_clear() to properly release the
> ws_active reference before returning on the error path.

This patch doesn't add a sbitmap_queue_clear() call. It seems like
there is a mismatch between the patch description and the code changes?

Bart.

