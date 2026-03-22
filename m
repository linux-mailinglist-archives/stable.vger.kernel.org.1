Return-Path: <stable+bounces-227825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBEOOGnNv2nC8gMAu9opvQ
	(envelope-from <stable+bounces-227825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 12:07:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E162E8E41
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 12:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53B93300ECA2
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4B92C0298;
	Sun, 22 Mar 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFVRr+bj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505030499A
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774177639; cv=pass; b=OMdS9alfvJY9Qz8vsagSTfdFVEGExbycZCs7T6cYNFA855xNCeMFSGGvK07gGMie/QmwTSeUoxGMtXWLyzeIw1U95HdKRECXSwcmbAiDVbgdlPAypCokrwxsKNtP/hmCFCyd1RpqSK4UV4UHNtfYhfL7Kak5+vL11uofpyhvxjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774177639; c=relaxed/simple;
	bh=gvtTpkQne7LV/j8cKiXI+qrmKSSfF7shyrzLqW2IuWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCFXuOvFKNoXSujtJw5rIzDx0ix2rWklJ3k1OCmOV/qvtFlaht6uVreYKSP7NPMbrr53Rd28plakKycEd57kN/mGriVBLcLNUMMeH71jZCOjbvNq3AWQhakEmNLKU5ZOC+EvexVfY+MzCJUbqnpbXkw/lOr7iKJsrVdjappTdgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFVRr+bj; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso3376651f8f.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 04:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774177636; cv=none;
        d=google.com; s=arc-20240605;
        b=YJIte20/n343koLgWIbsFSYhYMsGDwnm8b9YI8V9KeBVSXJp0m7yyLDb4Edaj1dYOv
         /KGKhA4QiY36VNAHeBXA28J3LGZCuHw4kwxg2eHP/kj8mj+kuqcNHOLF1n/bGDbQm1qJ
         C33znYiMobtJlq+yA2EDIwZrdleMEpJsTd3UHLjRaCdnsGflPDxRMXeDMKYBtyhCYkn5
         d90BD2KId4zJps98wOLsDSxgsSF2Bkti8e/dgqpj146qsEqS8UAKR2Qu4RDYgHoVOY4K
         oSrZ+e40Wlmx6YIAJuhRUD/xu9WRhbrh7bA8CEGPWJIaidpOZr5n2BjwE6D/Q9p5KpUT
         oqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gvtTpkQne7LV/j8cKiXI+qrmKSSfF7shyrzLqW2IuWI=;
        fh=CNMN0U5KI0qqU8ljedSSTRfMWWL9TUumkQolBzekNuc=;
        b=V2UANQ/nvSmsn1DMh1lb8TRpDH/RFPdxzwC01e5B4XliYgnSOYJKzGSsHTo759SR6c
         QWhLBZbc/w9TRSifPPIZmjLJWxup7qfp5rYygnHUoOxhteX8F1QeqrZu1T+dZs+u4DI9
         CGx7KjFkZ8xOdeHLiAkQ1VizMiMYpFNnJWbp/FLPGQbvKmtOznEbaiiP3IMxCodLGGzp
         u5KbLxUwpZvTSFLS8/tRrbOz+9wQoPNHUAaIGc1BpYoBiHqeGdL92VeCFUyGhrluy0+u
         3sYU5qjj2lsLS+yUFAxsGZwLZMly3U0P8+4sjML73W8VNC4/1QPkkqF8QXjjNo4Hm4jb
         59fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774177636; x=1774782436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvtTpkQne7LV/j8cKiXI+qrmKSSfF7shyrzLqW2IuWI=;
        b=fFVRr+bjUjwjFv6Pee7sHlmI7jO6DLjc3xDpaU5X9zKKU5TRicFOkVLdC5MqMk3EeN
         3nftd3NwDPV80eNNaQu7M7j+25A3HOnRLVqFxaAz3UDcWFvPj6ZW+4+8m3h1SsANEKhr
         XIbDGJE2jZXrdD1mveoi8hQqYZcLjvlPlxSi602UXQxIy7uSe6WBTQGm6Uu7KzLziKRS
         QijBy3qm2IFDKwoeGRoPoRHfM3V8a5jsPTay2YP6LpKqTmS+3ftYvrCAqmM8rzPvrhhh
         2NkgA/WlY82ilN0N2FCJ741XWr60tCRacAG+MwiFxd04Us5OqfsIdNO0+P7ngwOUplqS
         S22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774177636; x=1774782436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvtTpkQne7LV/j8cKiXI+qrmKSSfF7shyrzLqW2IuWI=;
        b=ZIzcS3u3XPBLRDorHaLb3EjEYiCQXrw25wGyhazl9MAwYXYbA5BnDULHh/GWkp1DnY
         aOkYRC1JHZtgMagKpWOcBHDCGjR/hM/cegLMqQAkrP4ALZZ9k/KBXd6wzD2v8m+MklKp
         ZALdBn99oGyaSJ4MqZtbQGV0Ocwqa6beXc87EQnkZn9LZK1qR8X6P5eSa02TviWswS2r
         prPlIZICqAXyoYYPz8SknNw38rc5E8DeXVR3IUcQ3bnbe1TDJ/fE/fviqIv6DuhD8SxS
         /RnNzSM27q0NfVMi+c2v9qv4Svlpu6WItEXlpn+97VhI9zKqPQaWLhfs+hhpV5X4fieE
         KxPw==
X-Forwarded-Encrypted: i=1; AJvYcCUkytD4VS/gWFHEQUK3Rzb3LyzpBdvrs5cF85npSDxSRGRYRyQBF3yQeKD2fgs3Jrtf8dVl0G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hl9PbvrfRmeTmXEQI3/TnBZfYO5X9zHWOWPExiDwfuwfPp/D
	ySPkJHzgmke7rZJCa+84QJ0CmE6zz+6a9CV6dIkpjJ0kKiDfoFAU5pSQQWq2DPrgh1wNuoVgmeR
	gtmq86Xazf9p7Ma5iKDnmAdHcz2gMYXACM/QiRpbn
X-Gm-Gg: ATEYQzwfbaIE6BhmHtgoN+ulOsh6ReX0M2FCXT73bPiwT+1bdF8oecvfdw+UaTGqCCs
	Bw+aGChn4yt8zebVYjNAs1JSJPHMutWYrh1Utas5MJPOx86B1MMdZs7aeR+Zk6vv5XnTAPo6oQ3
	dWQhRPFOVfhCvUmQ2QbBTXFa0pv/L7V8yPcpZBe9sU7g/0P8T/tPtcbDFR7cvKxx9WGo5dyeUQa
	NFCYxNNIoqy5OF5iZpf5ali45rjH/zdmuWvoxWDflbgFtE5CkfQEtbze3SFXpjS2Ii6AhUm+NEx
	Ul1lE+kO4f9T0fSDP/EqIfze0v0koRToQk/48Oj1+wPh5hXA
X-Received: by 2002:a05:6000:420a:b0:43b:498f:dcec with SMTP id
 ffacd0b85a97d-43b6423287dmr13588528f8f.3.1774177636049; Sun, 22 Mar 2026
 04:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321172749.592387-1-dakr@kernel.org>
In-Reply-To: <20260321172749.592387-1-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 22 Mar 2026 12:07:03 +0100
X-Gm-Features: AQROBzBApyQfE-ScLGU2x2ibUvgga-dh4itt4h7qwXjWFehs-qG5x3_XOAmIH2U
Message-ID: <CAH5fLghK2q4Du+74ctWftbDXrS4E4uPsuOrsOwxbs=HGm5CX6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from
 public attrs
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, tmgross@umich.edu, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227825-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,arm.com,kernel.org,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73E162E8E41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 6:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> When DMA_ATTR_NO_KERNEL_MAPPING is passed to dma_alloc_attrs(), the
> returned CPU address is not a pointer to the allocated memory but an
> opaque handle (e.g. struct page *).
>
> Coherent<T> (or CoherentAllocation<T> respectively) stores this value as
> NonNull<T> and exposes methods that dereference it and even modify its
> contents.
>
> Remove the flag from the public attrs module such that drivers cannot
> pass it to Coherent<T> (or CoherentAllocation<T> respectively) in the
> first place.
>
> Instead DMA_ATTR_NO_KERNEL_MAPPING can be supported with an additional
> opaque type (e.g. CoherentHandle) which does not provide access to the
> allocated memory.
>
> Cc: stable@vger.kernel.org
> Fixes: ad2907b4e308 ("rust: add dma coherent allocator abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

