Return-Path: <stable+bounces-245175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO2mHWKpAWqFhgEAu9opvQ
	(envelope-from <stable+bounces-245175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:03:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E563A50B805
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8C623047DDB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6B3C3C00;
	Mon, 11 May 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7openh+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA323C3C07
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493537; cv=pass; b=ThRu7oHaS2RXNi8QB5E/zaMkTP/lSduPMK0YdwAjCpmtxKcSxcnQqqciM0hdCIgwQtAKpY4xDaofJDBn2f8d08U4fteEuvwEceW1fnXzmx/2n98s5lCZp7Pqyod7MHet2vJw5Vbeob1JdImbXzaZIJZJFOfa+70gyiZY7EQC164=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493537; c=relaxed/simple;
	bh=VgAbfLZ25lu3eN+rVp08IzNGrcqim9qvYCZbACv6kgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl9uX7GxWmh/dK8+ibVQSzv5a7GcnABaB6+923qlyFUlgLDKLhkxWS3vVQBERuKDuB4DFM60k5J/NAu2Jj05RbVrnozLiuGzFDyeT1huVz51x+2sydPFFqVhSOFMSQgskhtKovPU0fJlzFqRnGhrMGANdeN4n1uY84RVhD8GSFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7openh+; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f24905306dso256943eec.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 02:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778493535; cv=none;
        d=google.com; s=arc-20240605;
        b=MXE3OoFSKkT72rLW7KEqbdrE88MMUKf4zkhEYWrLbp/Dpb7Xb0DKl1yUUxuhqfV0HS
         yhsKbUuxJl/ugMUBpIqtmFIAzo2LVOejaTZvadFqoJB6+U6ehdj1UmzVQ6ROXEoZ1pqE
         Gh55L0IWbfShM97DjPgW/XSe7MvSBYpAADlMEAQBR+I2HqFPj2SwOAQbZl8ggqIVhpLZ
         WmAOF//h0so6TPFZoJW0l4my8lDS0jg/y9XVbT2eYFdhvH0F6yRgjid0W/Z5iSrwAMwK
         Qor0wKMwg0cUEhHIY9QKYJk7lQ6z7DuPIJGa6nOk4K7uN7bkt3d6iqq3G5NlJl9f03KN
         HTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VgAbfLZ25lu3eN+rVp08IzNGrcqim9qvYCZbACv6kgU=;
        fh=l3WZRuTV7mFmlrJ2v6No2ET6ZKsbCZ2LyvhwbdxK5tM=;
        b=WBO1HC4E6wesM/9PX60FGvjtpvEom72csW3oWnIog8l8bD7Ju9ZTrOiKJtf97vsvBL
         XYBmnhbTJ4UwmEVVXeVTRcRDts02dLLeFDwoMWDELsbAm6JYSOUBkoxSpIUdURh+Sxp0
         ehSQEyIrzosUi4T9lygwYfhi+7kpEPZaY8zYCePYxszPkESN1sjCslNGGP29q59DP3Gz
         3uUun2OSk0UJmVGYdajJcyxNcet1Zbc84+goxz638+vUF/PI9pdTZi0OErwxnFhHxalS
         JVAZat7W77LiiRbghJTOuB3ENZkKCSuJJXCvFZYpGVkELWgycr3zY7uYgc80mnwFM8oF
         bbcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778493535; x=1779098335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgAbfLZ25lu3eN+rVp08IzNGrcqim9qvYCZbACv6kgU=;
        b=k7openh+0VBT3UqkowdNM7mmCYaTvdPbkl/soWVS8JyJpvj+vbrWbWrQpdYcpMKSye
         wmZ1ImmJipyqmsBfWSlCmgiXr1AI/lZJg7tRwfCCqirutuSGp9ZEgyfBjkJw23Jbn2Jh
         AHrmz4oLI6A7Tv02hRL198EgRHiTvfYWAN/jC1dcb4tafwFCsy71iDrjXx9LjA+wLrTU
         tRgQIO8UuFKbQxIfb3JSDfhBP+qFiA8snY7d3QOa8Sfua1XRwFYctxWX8BTJ00urBa/0
         mLEiadREJ+K07CYeuYLVP0cmqy2F6Ts8F0iscewWbLI8L8TTr74GDTiC1omsZnFO6O+J
         t8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778493535; x=1779098335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgAbfLZ25lu3eN+rVp08IzNGrcqim9qvYCZbACv6kgU=;
        b=lOrJiQS+CWPJtL2TClKWqt69XtQ+7OhHTIldA2rNskdGHITcXcc0xBOdmG4r9TFClz
         ZnCbCIuFKXaarXkzlMmN1hnbPcQ7SIOzbE1oKZhLHFTlKHWzKHST43cb0fXmtgwjJMwL
         7wnydIwN3W/XihW1R0Dk05tk0gvV8lU6E6kb0j4QssqmRfKGnu13bcEm/sGaSjddtaHT
         1paSIJ9NPhc35cO3ocMiz3Rc4An/92Be6DpX9lBhxCxppp7df6P1LJFsuQDtVVqeAUtz
         2Yd4CIG3hlFoh9tusbzpLwpA++hCdZJbomtvpPKsd0tLz4K/6q7fHEfDiOUrKFndpyi3
         kDhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DMX+QAwLt9g1KMXlDbryybqS7xh/95pX9FbmIaLt4NGaiGJn+NQrkCin4Vqelcb6jp9gosTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmudJ7pauPCGQ6HON2w4JbTWVYFY1fEvbGJeVNqG8t1txP427
	JNso7QhkzbROYuVg2kn2I6IClZcfr2O0wia7Ep/sqI9AnCZtRUkC3BG4zah85wjdFD3acJa1eE5
	T7JPJcirg/MhwKmPwXR8HG8CBWorT8ic=
X-Gm-Gg: Acq92OHya1G51jW77rs4geU9ru+ajX00B5rQidQzJ8Svd86EI/8YA0G5rEjNfIKTHY+
	CeMZND22rWAXl68zmJQNDRIFNC0ZL/NrWo8RU56Pqwf9/KFo4hbwyU6XMJB1tcXSH1SGyf4hSOR
	OxK20XlmW3I3/qP0qqKd1SJxX76DUQ6FuFmOfiKpCFVJLTCYkNJVRL7gom6Up7oAbFXbgesmb5p
	RlJdPZVogEO1W8CtzGoyuAQSYwK3CnCsVKH0kZ9IfADungkY8Scm/+NMWSGvn1CWuA6ujaQ5RqB
	daZOKP2gvNNm829qeWlAtTKkA18CBgglpGPhC1zuyY3QOlKQ4IIqZ+bhE5VOdTcQQmaAMQT1dUy
	ybpggwzCm7ei4t/F7yXvUnHZEdsTvR9ZFjw==
X-Received: by 2002:a05:7301:408b:b0:2c6:7f49:a840 with SMTP id
 5a478bee46e88-2f548ba3636mr4653507eec.1.1778493534947; Mon, 11 May 2026
 02:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
 <agGRnHVTLiwobb9W@google.com> <20260511090943.GA1029560@ax162>
In-Reply-To: <20260511090943.GA1029560@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 11 May 2026 11:58:42 +0200
X-Gm-Features: AVHnY4JBwbANAL1JBo2hZTZsbExaBqv3bNbSXroud4wMMH0avITBnenRjEHK_84
Message-ID: <CANiq72nm_3KM4gMnb0x34oJk1+_8XrUz-43zwW58Mr1UHG8qtQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Russell King <linux@armlinux.org.uk>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Christian Schrrefl <chrisi.schrefl@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E563A50B805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245175-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[google.com,armlinux.org.uk,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:09=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> Sure, I kept it simple for backporting purposes but I don't mind
> breaking out the dependencies into their own symbol, even though it
> feels like that could be done when support for the sanitizer is
> re-enabled, which would truly mirror what you did. No strong opinion
> though, so I will send a v2 after giving some time for other comments.

I think it is fine either way, especially for a fix, but up to the
KASAN/arm maintainers of course.

Thanks for the patch!

If KASAN or arm maintainers want to pick it up:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise I can send it in a fixes PR I will likely need to send later
this cycle, so please let me know!

Cheers,
Miguel

