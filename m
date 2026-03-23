Return-Path: <stable+bounces-227988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABWCCU9CwWmqRwQAu9opvQ
	(envelope-from <stable+bounces-227988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:38:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9D2F3132
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B48243020517
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035F3AB26E;
	Mon, 23 Mar 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GuoJJeKo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440D3AC0F3
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273049; cv=none; b=nLxwx0DDMNCK00aN3VdUNvovhyyxHMKOYzvsMFVdbQHglK6x/2TaAZao8Ku1VLSRgM8xentZSI3W1bmLAvcsxAdSVhivJu2ibuM99Co7dqNCw30LV+eMBbpeMrfTdZN4S/CL/ncuhCs3XZIu4KP7mxUpdJvQLS/lENonYCLFsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273049; c=relaxed/simple;
	bh=cuqf5WKEOeSBvl5nCWR95sghaIdZAB/uyQOlk0lWsBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJjtCK57euqrIWHiHoO1+2lJ+qJbsQRmP9p8vSMsKK+2y1JuzmGJGtVDPYgOxrU3BqDN0hh3GWMOWUPIvreEC962Sr3h4fq/VSR4Nl2VaOgGtWuf9V6pZHAkMmeGgAPDAJaKxsQTQWGA6a/0JL12i/weG4DK/OqYRoJqlAaDv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GuoJJeKo; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7653db148so2303808a34.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774273045; x=1774877845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr0xfFxyDLcn1eSxu2mPqEreGtCiMmN42izltshk9hE=;
        b=GuoJJeKoRGTMpbffh6cfLal7modHZRLYB3Oy5bCZCcbW1t4Rj/yzA8nIQh//NJIdCk
         PSWc7+IlkhjcA+mj7cUkATZt1RYEIcQD+leVjaW7nCjZazp3jVTs/3rH6KwM/iE9st3K
         /lc2grCjzw2PPRmUJFmKLTky8QzNMcn1uIhl91uRSTXitpWX3Z0LYMHyif+A+dxGxaiy
         Y/RjCvGAtOm+gGCBBsUpaEmu8lFusQQeQuTox95+9+Pnh4Z7bUIeRKYjcoN2Sk6HmlY2
         2CMRM2xsZCBk1/XGOrvP03S9F/mc0QWXGIh2e4DAol0iJmub2GFQgT6ZZnI87NpFQ6xm
         oAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774273045; x=1774877845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr0xfFxyDLcn1eSxu2mPqEreGtCiMmN42izltshk9hE=;
        b=AI4MYyjgW2KEy5Ga7DE3mz+ci3emFyLM9XZQ0gpO/x+NngunhCnfgmfEOwM3mnYzgE
         K8y9j6hwNIa2HpsJBPAvWwEZB8+7h3Be6lxr3J9QBFH2GgaagI6k8yFZ7vf7TIARIYov
         7RiU4pK9ba9H9uOhJYouXf/+8lbv+NrRbGEqf/mxO0zAix0GyAQSFF+OXy7n7345z4Xk
         odgOetbmQm24N9chBM8c84BC38qLDPaJhLnL29G2KTk6HHNfYeCZIGYAarpqTuvlXSaA
         fLMHlf4rJJaWJP3Orxaao94x1TDAurPyKsDxXSYH/0LL9s3P2BwWSUR/lKxd/RE57su2
         0vJA==
X-Forwarded-Encrypted: i=1; AJvYcCUlGxlB4nXoCk5iJOekGOTcfOhLa4EpzbkWPOonqYFKfEo1lGDZCMZ6mlFuk1ub3PbHVC7FlAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oK96cDDTYUwL55+UFhqRXcDuljscPVY7Wn4X0SLGznDjk36j
	m3+hVXqANMnWOGKYiPdA8GD3vCOc80fVP3MX9RMN4E9R83UOsorm3xtbeO/MGUxthnw=
X-Gm-Gg: ATEYQzxmZD1/TQNFivNqLsxgB0XKl0GXWrbBcB/S+mT7SXI4nF6tdkuPJA7nMu49dic
	2H1H8fsTjBG60BPUjFaZDdsARg7tDTDKXEcA/3Yy0Ydnk2Wck901grEM+iTD7WWIBzhRLrNm1Bm
	1w+q5WzRq1qWLTuiK+VRNnnP9fzy/WuYMucgpXNYvrhPoOxLQytehrXTSSZTouAkNTCSRAy4PUw
	Bgi7uOKsGbsJXwXlDax40RjFzGQ8/BlyfM7GAxlZyc4DKIR2OrW/laHr8RJtSDoZI+LNg2Qr+qf
	5WmzAo7EpoYQN6C2y+KzAEsWafIzJBQPLw5bUIY/aDcrcJs40nU0DSA8KCcYE6HwNMZtQWTFJHF
	oIPCB480dzXY4lfrHprE4AqUU46qKEoBs2U3dk+zXarHCN7TLxja8AZfJItDzkdhsRgMfqeStL/
	95oB+QVrUlZ1Aiht/TmUpBYMY6/FENipOpWS/JAtDH0ejdC2rlca7qLjulGUNa1NMEp+AsXZkps
	UDvJq4uCQ==
X-Received: by 2002:a05:6830:82cb:b0:7d7:f700:fec1 with SMTP id 46e09a7af769-7d7f7011e61mr6635086a34.32.1774273045411;
        Mon, 23 Mar 2026 06:37:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadfc678sm9323570a34.19.2026.03.23.06.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 06:37:24 -0700 (PDT)
Message-ID: <c0e7718f-7bec-44b5-966d-46149fe30507@kernel.dk>
Date: Mon, 23 Mar 2026 07:37:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] io_uring/tctx: work around xa_store() allocation
 error issue
To: Robert Garcia <rob_garcia@163.com>, stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260323081930.899697-1-rob_garcia@163.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260323081930.899697-1-rob_garcia@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02E9D2F3132
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 2:19 AM, Robert Garcia wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> [ Upstream commit 7eb75ce7527129d7f1fee6951566af409a37a1c4 ]
> 
> syzbot triggered the following WARN_ON:
> 
> WARNING: CPU: 0 PID: 16 at io_uring/tctx.c:51 __io_uring_free+0xfa/0x140 io_uring/tctx.c:51
> 
> which is the
> 
> WARN_ON_ONCE(!xa_empty(&tctx->xa));
> 
> sanity check in __io_uring_free() when a io_uring_task is going through
> its final put. The syzbot test case includes injecting memory allocation
> failures, and it very much looks like xa_store() can fail one of its
> memory allocations and end up with ->head being non-NULL even though no
> entries exist in the xarray.
> 
> Until this issue gets sorted out, work around it by attempting to
> iterate entries in our xarray, and WARN_ON_ONCE() if one is found.
> 
> Reported-by: syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/io-uring/673c1643.050a0220.87769.0066.GAE@google.com/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [ Modify the function in io_uring.c because it's located here in v5.15. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

I'm find adding this to 5.15 stable. However, this also need to go to
5.10-stable then as the io_uring bases are identical. Greg, when you
queue this up, please add to both. Thanks!

-- 
Jens Axboe


