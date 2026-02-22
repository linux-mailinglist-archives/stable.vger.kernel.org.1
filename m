Return-Path: <stable+bounces-217671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDvLIM0hm2mStQMAu9opvQ
	(envelope-from <stable+bounces-217671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 16:33:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEF316F88D
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C383300B445
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849634F259;
	Sun, 22 Feb 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JK38DpPX"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F1CA6F
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771774411; cv=none; b=t1rQRjK0fFHsJvHeICHV6NKa9HQgD3YmpXq64LVfOoo6E9FQ3AiWgv09hWrb7t0vUqe1o0RslzFGIi+A3H26EXe95d4efjC35LhsqSaeQiQkIEdSkZh29rznxKHiOi4uDL7qEm+hWn7FS23Vr0HpYpvid++H6U0Xr6BImdEaI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771774411; c=relaxed/simple;
	bh=fZANeEVcMhdCynQNpAQpU+Fxs3tkRMVwsp/nTFeEYy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZAtXi2uOptGnBYaOUkkolk1aR73/6Ib4hbna+ftySPD/5JetnoMPXGJ4ZnhSoNd7NQDp+zlMMyx1TuGvtG8IHOHBit+uXcUUL+fao8HHMKLQ5J8dg9rjR2haCKmw01tocFSxHzFyLP5fk7ZIH/ESRUGWfhXUVZbEjpIpTV2w9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JK38DpPX; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f0b597eb4so2131661b6e.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 07:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771774407; x=1772379207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH5ka964ImU4MPRn0XUQDpQ1hlSBdaDzyXvjeAzs27Y=;
        b=JK38DpPXnLtdH0sYJ9AxiRcgoxqoLNADNEKjzmWdqDmGmYbQP+Dc73lkxH+53pkPMX
         r9GFqgCN+vbOFQqNV6xvj6x4QbfKsycdwCv5KdG+WI1//tnHFi3aaAKhVu/DplRLHgjX
         RlJax3UoYluA8POMsJwOVUEL4S0VGl8QZX4l6byd8oD1Web2zDt0jPDoAJLfxCGMKHa4
         R7alzPR8K86fTB9LqUpJNtTjYEiD18E4c26nWTvJwheonrMsnwI+ANEcmYaLNbABqvSa
         8ahay4957B2h788LvgbD+upkEI7ssSRbmm968wm3UXuPhklH/Vv8D5z6sPJvhjxtjghC
         Uzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771774407; x=1772379207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH5ka964ImU4MPRn0XUQDpQ1hlSBdaDzyXvjeAzs27Y=;
        b=hCCcbAbl/WLqV9golSv8WLJ1ePbwYqMSeJKT58WPTEeUL13gBEn88ALymDW3g5jnw7
         K2glDJnK489y2PQGZb9mbUtkRbEMOQvEQ/i6UHVn6L0mulg+dxn6xueQMBrOL/ca+qcQ
         ZnswYGLYvja+SNvEojAekqsCqHdRjZyLDKfQ0p0gypZ6py8zti+jezf0zZYdQGV3Xhqm
         ijf9A1YTXyW+ykmyfxWoySqh0azcd0CqUWXaYrLigUXYOo5VUNluH2kmhB09TSS9K7jI
         ZxrViX5HjAu+A+YPJXIw79vGBWKeCNMWJ9UIVMhGxnfqVMF4AHdB5XmNASnhOoHuZW88
         Y7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUwarpQmkK4C7AxkxYilpar/tobl7461mUkVfI0G2ym3icetZ7Nv3+igZRQMvCPcFMXFtFpo54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtSjAGHetwqkLXwAj+RDdeaXRyxu3iRU/1mYpIqgDdgPTQ5ys
	wSLCVdfJExK6plVE4MAoZR0YIySdUgcI0nuUEk0OLVDn1C6v59lspu7emDDGFREIHpQ=
X-Gm-Gg: AZuq6aKpc1M4DLLwUtauf2p3TxI983fxxaf+QyE8nrQMkbEe+y722+D7MeFCBNbtv/V
	BHEHPBr+64qNA2Zf8P92d3fWV4dztuFN/Zs77rIQlVA8eWtRz9Y74YXYlHHG+xR37G5+mGo4J6W
	Jdt5AOiCw2iICqJpbM2PNyWX8CMcuW2EktFja1ZqnkoZwGtxmTzZSzVvlY63n9qtfmgYExM0sLS
	DWRniLyjC/8rNutMazIbj/V4OyNlJJw2KdkfexGuQxsNjz0Jt9rDSywR8vf1Kt/eDsAVPi9g2IB
	3mAg8HtyesuEfxGaf9LiQXs58j1av1MrPnpWJo7YuSlgW4MLhPppJeqO89SVibeRgKv1Dn5mArH
	SOaO+bv/H4TwD+gG3BWYh7tCWtz7luRLrzd8zluoxvgiY0AMF9e0sm09uuCxP2uGMX2BPO54eyJ
	vaWvxi9InlYj7kwNngWTrqAiRb4v4XZ/TxzNYwEyCBcvUKwcIzLAd+29fxfowtmh1SN5G1t45hU
	YDXLUO9zO0=
X-Received: by 2002:a05:6808:1b8e:b0:459:b569:702f with SMTP id 5614622812f47-464461b2aa6mr4205108b6e.15.1771774406890;
        Sun, 22 Feb 2026 07:33:26 -0800 (PST)
Received: from [172.25.209.35] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46449fd7a0asm3428446b6e.1.2026.02.22.07.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 07:33:26 -0800 (PST)
Message-ID: <ee96be6b-f0d9-479c-8ab1-f8c7e04ccdeb@kernel.dk>
Date: Sun, 22 Feb 2026 08:33:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/rsrc: clean up buffer cloning arg validation
 (for 6.18-stable tree)
To: Joanne Koong <joannelkoong@gmail.com>, stable@vger.kernel.org
Cc: clm@meta.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAJnrk1YA9hk5Mv0BXFe+TcWLXsNLpWtcA-gy+k03zDt4f0z7zg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJnrk1YA9hk5Mv0BXFe+TcWLXsNLpWtcA-gy+k03zDt4f0z7zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217671-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1BEF316F88D
X-Rspamd-Action: no action

On 2/20/26 11:19 AM, Joanne Koong wrote:
> Commit id upstream: b8201b50e403815f941d1c6581a27fdbfe7d0fd4
> ("io_uring/rsrc: clean up buffer cloning arg validation")
> Link to the patch:
> https://lore.kernel.org/io-uring/20251204215116.2642044-1-joannelkoong@gmail.com/#t
> Kernel version to apply it to: 6.18-stable tree
> 
> Hi stable@,
> 
> Chris Mason recently detected that this patch is a required dependency
> for commit 5b804b8f1e0d ("io_uring/rsrc: fix lost entries after cloned
> range") in the 6.18-stable tree [1]. Without this patch, the changes
> in commit 5b804b8f1e0d use an incorrect value for nbufs when it
> assigns "i = nbufs" [2].
> 
> Could you please apply this patch to the 6.18-stable tree as a
> dependency fix needed for commit 5b804b8f1e0d?	
> 
> Thanks,
> Joanne
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=5b804b8f1e0d66413774d43f7a4b78bba0ca6272
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/io_uring/rsrc.c?h=linux-6.18.y#n1252.

FWIW, this is approved on my end. CC Greg.


-- 
Jens Axboe


