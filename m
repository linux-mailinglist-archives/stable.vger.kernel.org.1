Return-Path: <stable+bounces-241484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ1eOaFl8GmWSwEAu9opvQ
	(envelope-from <stable+bounces-241484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:45:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F847F278
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6101C3070766
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B743EAC75;
	Tue, 28 Apr 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qITnXv2W"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72C3E9591
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361103; cv=none; b=htCR01J+aDSGauAjQd6zYuLEa6qO9YVBSJjASvfnXQevQR4POCN2PVlJ2zB0UMLPW5Q/Ekoi6rpaWa733vMCrQHp+bscfBhyzu7a/mIq3YsMwM4192M4vHFvZE+rSVw+8Ehh3DaNJ+NZT2D15Cp8jLPDkTYWKREXCwL7O9U6fM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361103; c=relaxed/simple;
	bh=LX5pLfBgJOfNpsO9FijmGFyFM1foRZCPvIIhllinNRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VvherKFKFhkiwC6iOVAw6sZ7QcrWpywifhtDT3vA6IQaoKPoHRpcwZYBMu49fcbPNFuGl6YCB2M7kvMCvfyg4TUjtHZyHREo8gVX7sCsJB6N8TLrVS9OXdC2RRKY9Ryjgwvf47vlxiDZl2Mip8g+E9a6NAWC7Pq1wq15W/Xhx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qITnXv2W; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ba661b6c550so1060608366b.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777361101; x=1777965901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ5yFfShBWBYpMcznSUsRaXS61QWv/Z8/quc22j7qLg=;
        b=qITnXv2WcqClnyG95lM05OlY72qwC8hJit2NvcPpo4Q6ZMiWSIvPTbUTKEdpSxiMDg
         CJN525DFIh8dTTzFsy8mqXZ6R9MHKwRvKtnKcpL+PAmPzpAR6k6/KQirETGa74eE613S
         LaqF3wKLLyqcG5YJjkucesmfuKg2HCD7jiT2sS7nc3WqOWTmQ2+zgIS9NQGDo0QEa/Dw
         uUNjDshEphdj+Pwx2GOnln30/sqhtVHR45LhmooGvJhkJlTQX8NXqVMJtRRISrMLn48e
         SOpAQ3xYJ/yY9IxsrSHyNe/S0QG/pnHc66/p5xSWvnPZXfCbA2/W3066mceJ7I2TBx7v
         s9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777361101; x=1777965901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ5yFfShBWBYpMcznSUsRaXS61QWv/Z8/quc22j7qLg=;
        b=JjLV+3W81/QDvVj6HEV1taiZ6l82P+5Y5wDmyUAd7MwA17Dre97UevbTmtBDNstOzd
         3dhJX5VkbIMb8575TSvAQbFiumhtFukvHtGH7F7ZQsM9lnd3poNtqRV0pNmsT5Bbcvrv
         YUxR8sK9GcoQC9f2FlnvUz6GeqTjVJjIvSKKynxyzDX2gyI4Npnk6+9Ryv8Dy300dL7Z
         VGJfZmSjKIioAQWoEoPtNJ55KuDXMsoX2DaqI3xmajZFlew2tYtubSuGoTbFk0J5ZAb+
         P95TuRCZcGREIEDgLOFeCJ/ofcHNgmRcyGbu4PW8UHX3kqARrkHOdSKoyfEU7Naf6HSe
         zmpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9beuwkhN2sJDNkkshXlXzByKsoZTPuMYtdMCoJtfBG4+fISZLJMbZYMjANsZXuvwLpKSIKNPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHu1ItJNOUItNmVR9n6cGMFLasnESH50Z6nIjhGnFztHvuEK2
	eAy3XW6xgayyENgZQcuwR1avVnXCR7FPrqseculzzhgyMWgO2rYVgf1VeCbHRvTwkLmf/X8LjXM
	z3eXQfMKf8EVUHkVXOg==
X-Received: from ejcgl16.prod.google.com ([2002:a17:907:3c90:b0:b97:914c:2968])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e9c:b0:bae:642a:8712 with SMTP id a640c23a62f3a-bb804728367mr108142566b.26.1777361100566;
 Tue, 28 Apr 2026 00:25:00 -0700 (PDT)
Date: Tue, 28 Apr 2026 07:24:59 +0000
In-Reply-To: <20260403-lockhold-v1-1-c332b56cd8ae@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-lockhold-v1-1-c332b56cd8ae@google.com>
Message-ID: <afBgy7x4Hui3Rzpp@google.com>
Subject: Re: [PATCH] rust_binder: Avoid holding lock when dropping delivered_death
From: Alice Ryhl <aliceryhl@google.com>
To: Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, Paul Moore <paul@paul-moore.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 5D6F847F278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241484-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[android.com,kernel.org,google.com,garyguo.net,protonmail.com,umich.edu,gmail.com,paul-moore.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, Apr 03, 2026 at 06:18:58PM +0000, Matthew Maurer wrote:
> In 6c37bebd8c926, we switched to looping over the list and dropping each
> individual node, ostensibly without the lock held in the loop body.
> 
> If the kernel were using Rust Edition 2024, the comment would be
> accurate, and the lock would not be held across the drop. However, the
> kernel is currently using 2021, so tail expression lifetime extension
> results in the lock being held across the drop. Explicitly binding the
> expression result to a variable makes the lockguard no longer part of a
> tail expression, causing the lock to be dropped before entering the loop
> body.
> 
> This was detected via `CONFIG_PROVE_LOCKING` identifying an invalid wait
> context at the drop site.
> 
> Reported-by: David Stevens <stevensd@google.com>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")

I realized this tag should be:

Fixes: 6c37bebd8c92 ("rust_binder: avoid mem::take on delivered_deaths")

Greg, can you fix this on apply, or do you want a new version?

Alice

