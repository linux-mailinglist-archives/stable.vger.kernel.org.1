Return-Path: <stable+bounces-223426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEDEJ0w/rGkinwEAu9opvQ
	(envelope-from <stable+bounces-223426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C9722C4F8
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9085B302A06D
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC43A2564;
	Sat,  7 Mar 2026 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="gn8ySyni"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1F395D87
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896049; cv=none; b=WkQ7qMurncUSy3qhrnQsGHtULLuNKzl2mryxnqkEKKRCTylkcTfrTFNOYgelWESoMFacQGPJVUAnksT1m3GWKChz+4jPb2EoEqSXdrqRA7SFFIrRskrMur75b80SuNQC6O8EFi81GtQi9zCTDQYH0N8tn8z2Vck76RErMWopx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896049; c=relaxed/simple;
	bh=ZYBGv71PdycZq+aLFPH8zUzhJ8ZpxJ5TIDJbEFgp3fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J82crGB01LwBs8JlCA27gbJGiTGwXR/olX5nLFVQMEeDTJIhGD2Kumzm5Yp7FlJ6Mw7IJgQwKjYaRQ6Zo6w4A2Sce8ODXPnWn4HgwqS3zg7os4EvxC9q9Hpu4RBCDp9xoNZI+WDp1Gu64YAGpUvPUbcai4ong4Bgvx9YF3Xa0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=gn8ySyni; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73a12af63cso724032a12.0
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1772896048; x=1773500848; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYBGv71PdycZq+aLFPH8zUzhJ8ZpxJ5TIDJbEFgp3fo=;
        b=gn8ySyniSRTLs9IIDOAoGwwPA0TxGEFMH8ypi6XSpcFQ5XXWDM7PnrwwX93FJ3Fbvb
         UKlBvQwa9YfPeleoC1KNNEPzBEGIID6SK18j41qMcCj0n/hDUU+r6mou2oUSgHdKEtLU
         7LlywHKwxegTI/ZEJi193IjzfGdrn0QMUcQ54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772896048; x=1773500848;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYBGv71PdycZq+aLFPH8zUzhJ8ZpxJ5TIDJbEFgp3fo=;
        b=jMqkvLhW0xe+6eAh7tvp05QUb6WTjy4idKbwmIjFBjJi30TeFCej+82bvbgJDetZXT
         fJEYJFUjQp0eT32zxGGThh6cKhMZF8AOjSaiDzRQm8zjIJJ9k0321x4aT5E7w/XRy8uD
         e4Xn34jzI3A207p4U1HoUQZMCErI0tlz1EOw0hXNsHN57uxhWhmxDmJ0H8EMbo0NTwRz
         NoPWQLnrHipJKNdQvLFWIU/e1CiCBvviFxR9WQLy4JNM7tTTZNZG5ZEWpP4uyb6VjGm2
         ZgsWuQO0kcZs9XBiLFrmIiqqiW+C1kcgTLtz3mb0qlL8I4DNkswdw4KuooPVjytspvVP
         cLMg==
X-Forwarded-Encrypted: i=1; AJvYcCUb0T94v1l7yUejp5P9c53uF4IBeWOdFIWX79QguUPJS2azHUzEbUz65Qzxv9uaLuwxgEyAc70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXcsVBdp2i9Rtsf4XU07dkTw+hV0nwbmtNittlKrXG6L5TPCH
	WU9cwvnOkBzHfwIJl2lHrcI28HSL5oDdK2azUytgHJ18Zy4h+4rMYlh3FAGkZFEAuoU=
X-Gm-Gg: ATEYQzwxLCPTdGi96zxVQADeVKAyEfHdhbtITq6XQhfSibmTsH+0d1R6WQZc8GWRWFn
	RcmTa6BCDXawmg126iTs2hg0sutAdHgoCbp5ttlUfXnpi/uIaJDoQUEt04pzndkDVwos38++YE+
	85QUYv3sV7XcfMB0sq8IIYfRFTBm5mSWgUyFavNcRVbZF9YZxjattUiAMfmyj1VW+gVwGksxq3A
	39z5A7ACzbWXwG2cJ0NLWdtN7QRO32AFPQ7GD8GX5SQwdCsVGNbyiZ1NNszVjVgW/mAk71tsFCK
	MAZJM+hjTVFgzymXMXbAvUeMLzM/V4djfOh6J03iWzft+geyANhRMbq21HrqToB4rm5wr2HfY9r
	EPUKvote8ltaGxVJ3X5in/L+Vynzrh2vJorRxRiS5p1iuIVIYj9eBzSL3zpVGcV9dpITrPmsgaY
	OsCTdTvIZTWCY2QnrWE9I=
X-Received: by 2002:a05:6a21:4d05:b0:394:f972:43ca with SMTP id adf61e73a8af0-398590b611emr5336431637.54.1772896047874;
        Sat, 07 Mar 2026 07:07:27 -0800 (PST)
Received: from localhost ([149.28.151.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e183596sm4394555a12.27.2026.03.07.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 07:07:27 -0800 (PST)
Date: Sat, 7 Mar 2026 23:07:22 +0800
From: Chris Down <chris@chrisdown.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/huge_memory: Prevent huge zeropage refcount
 corruption in PMD move
Message-ID: <aaw_KkASxkpONUdU@chrisdown.name>
References: <aaBVz7eb6-VBCvaz@chrisdown.name>
 <842272d9-9e9c-498b-9b11-cbad25f526c9@lucifer.local>
 <1cece140-0602-4563-80b6-fc7ab608de2c@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1cece140-0602-4563-80b6-fc7ab608de2c@lucifer.local>
User-Agent: Mutt/2.2.15 (2b349c5e) (2025-10-02)
X-Rspamd-Queue-Id: 08C9722C4F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chrisdown.name,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chrisdown.name:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chrisdown.name:+];
	TAGGED_FROM(0.00)[bounces-223426-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris@chrisdown.name,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chrisdown.name:dkim,chrisdown.name:mid]
X-Rspamd-Action: no action

Lorenzo Stoakes writes:
>TL;DR - To make life easier, I squashed the two patches and asked Andrew to take
>it with my R-b,T-b tags attached, hope that's ok with you Chris.

That's fine, thanks again for sorting this out.

