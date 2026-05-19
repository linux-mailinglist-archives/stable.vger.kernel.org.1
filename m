Return-Path: <stable+bounces-249699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6COmG9/UDGqJnAUAu9opvQ
	(envelope-from <stable+bounces-249699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:23:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF2558527F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C276302472A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90133E7BA8;
	Tue, 19 May 2026 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlUf+Sdl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF13D9DCB
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225816; cv=none; b=A6ix8eF79ThLHQF65ipq8p4TrT6Z4bQwh/IwnuHEw1oBCDRQMXMsXSf/pIaBz+85WV2NGB0ZKWUDy/4PN4plH4AYQoe0Xf20fIxbXLcxmLjpXeEk+48eGJCKz7FlBlN5kJNFT1Hh61UQnNQEe4FITbq+6Qwo4rDE/gmWV9l0Gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225816; c=relaxed/simple;
	bh=lWpu8BLqWj1TfNJlm3ClQfJmScLbNoYxCmBu95VgfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOW9PBIuoITEo2uSQrDghcO7DOeULAzf7g16ZWVVq3GiAmFmbXF7ExM5t6xtwFS6CcoA6jchYGEryYVb2Rw5FEpc9RD59o4Jh+rgZFh2EmQhqibYukpgdujpDBqcu+SgadHhAY4KN24005YyqZgLoJiAsYxEqLksQICB2EJj/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlUf+Sdl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso505ad.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779225815; x=1779830615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ56lnoRLJyhWveNJGv3cFgJb4oUuS+nNxeIsg+gH7Y=;
        b=OlUf+SdlQxGGE420K3w/hBZFOOiiyiNflgf+i0Ze7GEHpZwBHdXHBw5SWQmvBaRWBz
         Itss8MFwpuN4P9ZSEB7H7maXMWl5Hwk9L4djSAxmS38ESM+99UhFvPNOLXS/bLLam9JB
         ANIFxm6w7VADD/C/VxC4fuhIsIw+iR8uLEcrGC/xYAjf5ywx3ZRlGpERtoVRc9zRGOMZ
         0tCeFsPx8Qt1hSgfCBBEBEB7sxguj9ao2PeduAvI5wmKwT9Hp1ROwIU24ulKGq4zVehq
         qZ1F6Rhq0HjG7LACg7VyHTIApf2kzIIlAaWYmEH4oF59YdgAuW9zffLpckZhVN+HlANc
         cofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225815; x=1779830615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ56lnoRLJyhWveNJGv3cFgJb4oUuS+nNxeIsg+gH7Y=;
        b=dYj88UbaHxVDVKljoCK5E5dTx9pGqMMllQMi5wtM01S08TWGe6M/c/DRW4W4OofUic
         tXOOskb77JMIQKw8SfZAoN9+/d24g+L6iscAg68w7vsJSsVYYiVQoX0lydsHn5wz1WIP
         duBcWSBTDLT8Hl+W8++mXRZOGlPhrn35oJJZJSozp/8m+ihKb7SyT8M7qA9s5FUHIelq
         eW4FZ5kZzBauh/7vKLvBYQns5V3yDng3WlyD03jrmI0VxLAspPL1mjnaJkoJ4Ke40thq
         ErcnKmAK3HSU5jCC9TLDCEAb5mbS6U+TxkEnL/UcBvT4kHUD9EVSh0yQYehwDGwH033q
         3bxw==
X-Forwarded-Encrypted: i=1; AFNElJ+4UWjWOvyVJpajQvnaM6Zg3NCHm5Yxv5kf5yYgqjeAPy0TuhawIhALFiEM901c47cQOI/TBdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9202JXWGYCfNKgEzC8wEdbFDNXMPIwFLA7XwSJykt2Qpim7r9
	wG4bsw+VhTLQeUGT+MDM9slpsBllWtuDyBXZXviOntLHL4eQGo2tKvCHTnzx4dShhA==
X-Gm-Gg: Acq92OGMZWhUJ+5kHEBlHR6aeUgCDBIRD4pQLwjZ/tevQITcAxW/iE3MCq6xOMKbujl
	skCwjb8q4pzXVJ1zjkLHppjyYzU4VMfClAxb4YJ5dZZnE6wcx8zA9uO2j2SeGmQeLWGA1F7S8Bv
	I4cy2EJkm6i84TAuICF4ygDuG4ZwUfUExlRcH1rhmGIDteAzjxA1hHaEy4jyutAsHIGD11lOm+Z
	Hd6FQwHiVKX23ArD1ZznEjYkUZrjISOLs1iB3iz/ZLGWOXVEpxniBYYYcw0lUrFxPY+aI7WZ+fN
	7XSm093hM8pyAEY4I2X3V3BjhA1ELyV7p+9fMoc1E0N+Bo5j8JhNtNmBTg9GIQvvsiWe/Mm6vXy
	4DOtvlVqzJsB6mEBLJCHBtuRhKLHp7gKUsf2RUTR2rTWKY8Eusrw0D3dXz2mgpFVz8j0mhqGYMq
	0N19iqCjJ2792czHp+KESI4W89cAnWeDLurrfEFbx6jcKznhHEf6Ys92eMpxtPkZ39kJcCK0RQj
	BJHQdE=
X-Received: by 2002:a17:902:ef52:b0:2bd:6dad:7ccb with SMTP id d9443c01a7336-2bdb32bb6damr8726015ad.23.1779225814226;
        Tue, 19 May 2026 14:23:34 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm18608271b3a.11.2026.05.19.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:23:33 -0700 (PDT)
Date: Tue, 19 May 2026 21:23:28 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Andrii Kuchmenko <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
Message-ID: <20260519212328.GA2614626@google.com>
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518143233.16091-1-capyenglishlite@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249699-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samitolvanen@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6AF2558527F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrii,

On Mon, May 18, 2026 at 05:32:33PM +0300, Andrii Kuchmenko wrote:
> module_extend_max_pages() calls kvrealloc() internally and returns
> -ENOMEM on allocation failure. The return value is never checked.

We should definitely fix this, but I'm not sure the rest of the
commit message is entirely accurate.

> The decompression loop then continues calling module_get_next_page(),
> which writes struct page pointers into info->pages[]. When used_pages
> reaches the stale max_pages value (not updated due to the failed
> extend), a subsequent write to info->pages[used_pages++] goes out of
> bounds into adjacent heap memory.
> 
> Adjacent slab objects in the same kmalloc cache (pipe_buffer,
> seq_operations, cred) can be corrupted, potentially leading to local
> privilege escalation on kernels without SLAB_VIRTUAL mitigation.

Looking at the code:

- struct load_info info is zero-initialized in init_module_from_file().

- If module_extend_max_pages() fails, info->pages remains NULL and
  info->max_pages and info->used_pages both remain 0.

- module_get_next_page() sees info->max_pages == info->used_pages
  immediately and calls module_extend_max_pages(info, 0).

- kvrealloc() is called with a size of 0 and it returns ZERO_SIZE_PTR.

- Because ZERO_SIZE_PTR != NULL, module_extend_max_pages() sets
  info->pages to ZERO_SIZE_PTR and returns 0.

- module_get_next_page() writes to info->pages[info->used_pages++],
  and the write to ZERO_SIZE_PTR results in an immediate oops.

This isn't great, but I do not see a potential for an out-of-bounds
write or slab corruption in this specific case. What am I missing?

Sami

