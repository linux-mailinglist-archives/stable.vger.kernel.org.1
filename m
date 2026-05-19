Return-Path: <stable+bounces-249709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAW1B3jzDGqPqQUAu9opvQ
	(envelope-from <stable+bounces-249709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 01:34:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813A5860BF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 01:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 334A03028F70
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E5372EF6;
	Tue, 19 May 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwx4K0Lt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811630F543
	for <stable@vger.kernel.org>; Tue, 19 May 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233637; cv=none; b=SEUwnatVk8k+RE5KFeClVfCI8eRHVNEaVT6uI36lWH7cc+vjiLMyIG3WwIQZxJY1kwn4oWyFehhxoZLK9Wlg5GK3zqGSM9AfvXvbxPrWKU1Qs8/0kLrSCc9OgeFE19NcRQlphwtSgqcl5XYwUH5eHqLeuX/zIBMhAw0qcXtYKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233637; c=relaxed/simple;
	bh=vWp1K7SkFtPXP8NpxuPbKqX8DiXUPCucssT7uxnbYHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYMwAILFZoiQooX2bn/1W2nWuUIVbDGYVLSFa4x6h+EdbHmAkoT+z9vv1/FXON2mdgYd50OCX2hlzIfHBJreNaZQ5fD4yhxFgck9XXUdwkB8ZDx8vuSHV1gXSxiYKvT0NxoOfnvDbHhpR4eDkR7R3P4rN32zrdPpm3EK3Ggykq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwx4K0Lt; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1412809a12.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779233635; x=1779838435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhZ8XqsRht1If9UNrz6T/KJzsMWi9OQBMKb8F+sw0Zk=;
        b=Wwx4K0LtyCyr/gYTf6l0rfMzYzM6afgNClodmb/UwMaTZX9p/NsFyCwOAsa9kZxNgk
         eqRlaVYP5i1Wkc7u5BmnomkGWTbXWLqz4cXnuUCjafqMD8rrTXYHWxuMF+dWEyReJz9X
         ELiMPqygE3RstQHDXDWJokXQ4CugNve7UlUk54IOoE1Ba8F6hM/MLJoj2Q5vf8UpY8rz
         e0g3W8iQtAtPCG6Zt/Eol3FwiKleVT05n9bkqbiZCX19SmOZan6R5XlynJedxXJ06cpG
         50rDSL+B3EOPNZF3C2CKbf4DyVzfBpK2mJf6Z+7cFThw0nm3VKmwgyUcj34i7QHhrOdl
         8KRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233635; x=1779838435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhZ8XqsRht1If9UNrz6T/KJzsMWi9OQBMKb8F+sw0Zk=;
        b=avlOFETxPNx4z48cP7jcMRAovtwyHQ39NaFxpjxFjNSGEYKXreHvC99+VqSuCUQPjT
         eON77U6+9yYqZiWBg07Wn0kAJWal91WNjuvyU9YPCmvkprOqmX0zIWg4zdqsF2q9sFEV
         Pa5sFP73tO28p4+Wsq5VifK2xDyz7iPGMErkQLSuIAy7duAmBv00E5R/Lx9jm2PEZury
         nSgyDME8koFZagnNyLUhCEFCt3h6NWf/QcMGFWYdGgOQ+JSFk9nEEsuNBq1sNiGeSsDR
         4hh1fHEo+jy43frMMbggR+mjp/bQDHy3vXlKqfZk+Yvl1udq5Z8IjX3RowqZ7fBI1DGL
         78Zw==
X-Forwarded-Encrypted: i=1; AFNElJ8JkIDLQlAMN3nieMD9peq0RH9RfrOrAiz78HAtUCYQ0JxqyqSrQGpS09WBB9Je0fk5z/Bj5l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jZoTSea1Cha8n/WNiPun56mjD/at6VN6uayWxypp84mzqbu+
	3JT2m8iyY4nUXM+e2Rdh1w8o1EDQ+OmqYNXl2juWbbMKURQEzz8HL9B9fdpgqkU0
X-Gm-Gg: Acq92OFzmg6QemQE/BJAkHZAa3MdcNK++hdnWYIWw1Fe986u+sKb1x+NCz6T6m4mVZE
	HUgnIWoCsqmZsKZQ9F6d29yrkSd+4ttwbOF4QgNgOByztyEABxf5ykXOGHL2DlzYhSI7wwVsf6I
	qCRKMslg+PTI5as6uNF0tcjQhNeAkh/uKraxqg7oMxWEyB7i/DHQa+QG21WofelkhpZW2rVAaJf
	AOkGHJA4VzHckmuxjZjWP0Y4R9artRLi5vAeQEQRaKCklWSSLpxBqumRlYI8uC3GzsLUUj2+5BN
	lVyDpka0EtC5WzFUvcd21tQHqouzQu9NyuRITXMaWHvBKpK3xHnTFLplR7pN8TlTrdv1bdmp/Vw
	S2izLlsfdNTEtjv8DOSi47sfv3MMW9MNjliiepO+aXURHz8Zv9thOCh2sdR4KhtOsS5dnf3MYx4
	WstdrfIybzEbx2cxD0mIZbCbuwSg==
X-Received: by 2002:a17:903:3c6b:b0:2b9:fb9a:1103 with SMTP id d9443c01a7336-2bd7e90ebafmr222425135ad.38.1779233635347;
        Tue, 19 May 2026 16:33:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8698sm189776065ad.40.2026.05.19.16.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:33:54 -0700 (PDT)
Date: Tue, 19 May 2026 16:33:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, kaiyuanz@google.com, almasrymina@google.com, 
	bobbyeshleman@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned size or SG length
Message-ID: <agzzVHU8tt2rP4ip@devvm7509.cco0.facebook.com>
References: <20260519203530.66310-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519203530.66310-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249709-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8813A5860BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/19, David Carlier wrote:
> net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> PAGE_SIZE multiples without checking:
> 
>   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
>     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
>     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =
>     N*PAGE_SIZE + r (1 <= r < PAGE_SIZE), sendmsg() at iov_base =
>     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.
> 
>   - owner->area.num_niovs = len / PAGE_SIZE while gen_pool_add_owner()
>     covers the full byte len, so a non-page-multiple non-final sg
>     desyncs num_niovs from the gen_pool region for every later sg, on
>     both RX and TX.
> 
> dma-buf does not require page-aligned sizes, so the bind path has to
> enforce what its own indexing assumes. Reject both with -EINVAL.
> 
> The size check is TX-only (only tx_vec is sized off dmabuf->size); the
> SG-length check covers both directions.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> Changes in v2:
>   - Reframe commit message around the kernel-side OOB instead of
>     "real exporters already page-align", which read as the OOB being
>     unreachable and undercut Cc: stable (Stanislav Fomichev).
>   - Hoist the SG-length check out of the if (TX) branch so it covers
>     RX too; RX has the same num_niovs / gen_pool desync on a
>     contract-violating exporter, just without an OOB. Keep the
>     size-multiple check TX-only (Stanislav Fomichev).
>   - Drop bool todevice; compare direction == DMA_TO_DEVICE inline to
>     match the existing call site at the tx_vec[] assignment
>     (Bobby Eshleman).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks!

