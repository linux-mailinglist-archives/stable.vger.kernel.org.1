Return-Path: <stable+bounces-244869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMFEKjeJ/mkBsgAAu9opvQ
	(envelope-from <stable+bounces-244869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:09:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE144FD303
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3947830166CA
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 01:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0ED1A6823;
	Sat,  9 May 2026 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW6sf94a"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328DE573
	for <stable@vger.kernel.org>; Sat,  9 May 2026 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288947; cv=pass; b=Ktf8m+5Gvl/LO0oGjaR7+6HqqmqDYgkLbmvN85nu6znLvC20TVg5G35igQbeSFdZ4EtN/hAULNhiZ28/YimvkUa3stvJBXco+Dm8qh/MVfiFyfNp4af6QKEufwT3tkpjqd3JZm79qbVzxvJWHPZGZlN0eZ2dtxMZxR24k9WpTNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288947; c=relaxed/simple;
	bh=krjTyrVJAYN9IrLptc14C/iCGoxw9JU1GJu87evWwKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev4yRYwnAfz9nomzVfzyDdfjqYPbohwM2UG71vnnC8lV6jVYExCY3PeW93/qhf8KESi8/xT3itxZ56qmHShk49oiRmbd2qT1e8fEKuO6qoe+lACiQAK1X5xMHCPXxBT/t2Qdkxk/Hrk6UcTkARh6fq3+XzOW6F8tFhztU2UOogw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW6sf94a; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47cbd444fd0so1626628b6e.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 18:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778288945; cv=none;
        d=google.com; s=arc-20240605;
        b=VbAmByDoSixJI6IWQgFSJ1KP3G6FRfWoOTwuUwX604XM5/EbOAqSw9gWY0dp6cNECA
         F6oQkXMIXf16IeRAZGatYgmVC5bPMsxf/kXKyI2tptbFTUYBe7lWjo+ur9jCYXgsV9Kl
         4/rl0zEvRhPLRGPcirHDEKb8sBCtFNYPD56mMvn7D2LZRwebG3uIq6fbqMktgK3F3MpU
         MdOALrNN9Br1ue+9s4RImSGhY4ZUaWhpKZOLNQ4gfij3qFypFt1iHDiXCqgIRY+naXpc
         RJD+p9UZ/3HPSX+TN4TLJfTCHapF05FlHAbSeJNeAk5R3nTjeX9j6qYgAj0S2OETk1z9
         Nwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=krjTyrVJAYN9IrLptc14C/iCGoxw9JU1GJu87evWwKc=;
        fh=zSsx5ZGMGYLLlTM9vuW7sNfXN5PBlfoct9Bsh9oJkRM=;
        b=UhHQLc7t4E/0bh2DITCvF+gw+xrvNTScNV3LlpVQnUPE9EhRKen+FedcI7akfquk6R
         eUrT0Ns9yoLNoRKhCJVhIhY+C5x1B67IwrDjavBkAxXgkGE11P8ld7ohuceoYJ6vbSLo
         BT2ILui90N/MA3nuQKtsQhk3aehLVl7KKaGvsqnpXR/5SOApjFpWQp+uqoJCgu/AO/mQ
         ws2lpi1p7WdnaQ3euCty0a/7PqguQ+AFDrHCy8F8Gn5esv7AeJsrETuLLMPQv3bjKHRA
         CJmxOKR7JlOZN6cn2oRKaqRxvvoHsZteTOOlwjJ1cUDPh7V+kA6hUuypmafXffcFGvfu
         hpmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778288945; x=1778893745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krjTyrVJAYN9IrLptc14C/iCGoxw9JU1GJu87evWwKc=;
        b=VW6sf94aTzF+I82bgYGq89iOzRFWi8GzAmHoRvewyd0h+q1AEJW6wvZQJSg6jT1A05
         Pn5ldpDKm2Nwf37nTn/i4/xQ+XDZ8tPvJ3z3/1b583xnKq9KNUXPo/5pGO4PuqQFocuC
         hBAxniSavgqrMbr6eUZJgpes/omKJoHWVucdmQSTlEpFzX4pV8VZeAkOHZpZjVzDiLvb
         g/erL4JQqMloiNOHdwTsP/UDSkX99BEDMQQGlQVmS3qBcCRbjYE7r/InQZUW6schPn7b
         u9KcjdTHP9554EloKnffLyILYbo/ZBbIz6m0JWf4wIOI5dCZJNsgTu0IkeDoiMWMhVau
         9B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778288945; x=1778893745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krjTyrVJAYN9IrLptc14C/iCGoxw9JU1GJu87evWwKc=;
        b=jguYnAAbGXk7Y67mLgTylGyks89Vsg4G7t6UaAX8XLr6t/vUxXhGCKzw52JowSdKp7
         wy585Iitq9NXZ/us42LQWizlo3W8Na9sbPUYk22gCDIyAGv2QhzJBp3KIR901smNWqyI
         7dokCVL5lSRQA9KWAgLlCdF1cudWQeGp1cIltg0fiE8BMrmewHp9j1pEWZysgSs/Yeg4
         b0ScTo3CM/DeeSwSpTmpmqgmXG54FwmewbS1OYyJBW/WVRa81cGUCjFqX0IILsCHPBO1
         21Yih4RPSDjg5pdBwFUqv0I4eY5oLbw+M4tdMf3RgYZe2NwkAfTofrBl4vcnuIwlgElx
         Ee0g==
X-Forwarded-Encrypted: i=1; AFNElJ+lNaSs4kVDimJkHmOb1rIn2EcmWRnaK2L9n94l+0uOipn5Sj2VKEcnBhFlYISFevk9+FNnoiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tr8IOV08RECcpboHzFXMM6keRz96dflszUwduG/i7e+ledn1
	St1ozYsb3blDTP7N6rdQuz84RkbV80F1rAgEIyBGyAy+J7E8/e7k1bvRCgbqu/H4Ul3JdEJqkPt
	JCSk2uyCgRyGN9yCOtKgDe78+L6mD1z8=
X-Gm-Gg: AeBDiesrbIle48GzBy0xgzWZbqZtwTN3HYXICLflCMVFxMXCbcCBw4pEO70oJ9jXAnN
	zcrpBIyuWYTuT8N8+EL6GC/92QIJ4qfl9sOEihLFnG2pcTPaxmRWa/QOA0KZ49wcmqyOyW8v/fz
	VyBT4MzBEmrJOue9rXW1i8TIwYHJexKb34XhuSrnfNn6nxBzARFdU0h3jJZZhv2HTW/wYkdPrBi
	j/CatEyGiQOpQ2sEB4SjNhM7TESSUiToXBergxOsVq0kAciTK/848Qd+93nSq/PTXh3RQckpCQe
	xypprRZ8
X-Received: by 2002:a05:6808:6f85:b0:463:c56f:a45b with SMTP id
 5614622812f47-4804247a9c7mr10038344b6e.28.1778288945235; Fri, 08 May 2026
 18:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508090228.3796635-1-joonwonkang@google.com>
In-Reply-To: <20260508090228.3796635-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 8 May 2026 20:08:53 -0500
X-Gm-Features: AVHnY4JUKNl1_xRipuSJI5WGUg1FK8KdDHMVx3-aWzzetrbTRsZlK65wfReh3lw
Message-ID: <CABb+yY0Y0YHKviAaJiC8ZbJKCPnfJnQ2S-ifcsB-HFO3JzKJCA@mail.gmail.com>
Subject: Re: [PATCH v5] mailbox: Make mbox_send_message() return error code
 when tx fails
To: Joonwon Kang <joonwonkang@google.com>
Cc: sudeep.holla@kernel.org, dianders@chromium.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1AE144FD303
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244869-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 4:02=E2=80=AFAM Joonwon Kang <joonwonkang@google.com=
> wrote:
>
> When the mailbox controller failed transmitting message, the error code
> was only passed to the client's tx done handler and not to
> mbox_send_message() in blocking mode. For this reason, the function could
> return a false success. This commit resolves the issue by introducing the
> tx status and checking it before mbox_send_message() returns.
>
> This commit works with the premise that the multi-threads' access to a
> channel in blocking mode is serialized by clients, not by the mailbox
> APIs, since the current mbox_send_message() in blocking mode does not
> support multi-threads.
>
> Cc: stable@vger.kernel.org
>
Not sure if this should go into stable. It is not a bug fix. See
stable-kernel-rules

Thanks,
Jassi

