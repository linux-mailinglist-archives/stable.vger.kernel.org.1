Return-Path: <stable+bounces-270398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EJjjOcNBRmrGMwsAu9opvQ
	(envelope-from <stable+bounces-270398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:47:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8730E6F625E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:47:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=n3EesT7K;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270398-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270398-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA03E3044730
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83608367B67;
	Thu,  2 Jul 2026 10:33:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAD367B9E
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 10:33:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988437; cv=none; b=XAAZLxakdOPWBxjsw69C4P1s6ObjJPIUSeYTXmBzGKeTj2b2nAmD5H+c3Js1mTBB1sgWnjsflCpmB2BOWU3vOspTHU7XUZN1nu8hMo+qaRljQjMMMARMQYjnsaWU/QAN1V8Wj1/U1o7IymQFasVf52BZSzmK7UHqwMw1ILGX+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988437; c=relaxed/simple;
	bh=NHYOxC/q6w/85rLuoJ0b+7CKB6hCkyDyHdrXzKZNzeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ES/qUFcJ4FoOCkIOMkNNXO7z0LlIer7yJPO+3C81ejYd3OI0CuvhOVmW/VGwymcHK1E9pqjFX4uM9CrTq/Mq85x0wUHRelgIan493xUbiEBwIp8tpAzaQKr3ul9OiQwj/y7+Z0dXwH8IHdAuU4V0dehn74JwynzRGzrZEdOmztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3EesT7K; arc=none smtp.client-ip=209.85.218.74
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c126f9928f6so171576266b.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988434; x=1783593234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVZFMgSKrwLqQxBvI+EZbsGquxAKWLQHl8rLAdlBvVo=;
        b=n3EesT7K9dChn8noiVXZ6bUuhK3M4YWCVIewXDulgaSe0JO2WijCtI0gV0UCLtzKLR
         19ASFqiH3WzfIm9sgkV0KM7jrpCSgdZ3gJJV9gzh7puWlNxNyMphHR/XB01KQZmXL5lN
         zedUXrt3QZ+ZpD7Pe+Fli610vjs8lg65A0WVp9fQ33MiyxtuM0PncnMjGJcjbcNR/px8
         GHd7WpczctbOPHlxjWqSW8RfC29SLNrCccvOvysfah+9IBWhdq5ZW4gHq44ML39PnEFr
         xEU8ln3uvAzjI0bLvIYahVWBFXLOG+ai6EdUVMgPdx4yh554+XHJC7w0+OdjmSZdD2gp
         fzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988434; x=1783593234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVZFMgSKrwLqQxBvI+EZbsGquxAKWLQHl8rLAdlBvVo=;
        b=NdyZFvs6yhT6t9X1paPFtEC9gMNCyQdiY0anKfBsyAtOf5CKL7ObBhr0qBjw0KvYPz
         H1YygEELN9wAKJ6sj6OSCj91Ty9zT4ndf3K2/gaajPd9FCPGrKFXWVrUYPqT5HSrC5XS
         yeojo7+uPq7NmKF2pXztBOKCAniyM4sC6jfDNipReU1Z7x4DZ/2s8YDx1L/mwwYvY3v0
         qQ5/mJDTfywMCHEGoS01qM9aMFtKyt98SvIhLNC5wxzUxet4x/FjSJPlG900iDAsEZX/
         +taHtTfrIpELUUJNR6r8hJy/z3zinWM2hOLtXtQeqcEIcDQ7YDiPC/zIhFyudaFq/x2c
         6/MQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtTc7AWLeVrhKXsM02lVKHCWGkvNI5lqUlX18LM5pHN9+mTqpNz7rbZSwK7hRmsJREqcXuB6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys40ldG7c2+THpFUzasFpQGILh+I3JvX2hLSbe3TurnW6+yglj
	VgZ1BCb2C3dfbwVVXoV5cegcZ7w9AI2vZ1ii0fuMOO8ehD6BpaBswNJN1+VTSHAfu1EH530GJ/f
	l1oMn+D+DvAbebBCQDA==
X-Received: from edvm11.prod.google.com ([2002:a05:6402:50b:b0:697:8356:d9d4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3510:b0:698:5610:76de with SMTP id 4fb4d7f45d1cf-6989f2de56fmr2576538a12.4.1782988433394;
 Thu, 02 Jul 2026 03:33:53 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:33:52 +0000
In-Reply-To: <20260628200304.2365598-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260628174451.2275679-1-dakr@kernel.org> <20260628200304.2365598-1-dakr@kernel.org>
Message-ID: <akY-kHO1o3WgUSoW@google.com>
Subject: Re: [PATCH] rust: devres: ensure revocation is complete before device
 finishes unbinding
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, tmgross@umich.edu, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, lyude@redhat.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270398-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8730E6F625E

On Sun, Jun 28, 2026 at 10:02:53PM +0200, Danilo Krummrich wrote:
> Now that the revocation Completion is in place, also address the
> symmetric case. When Devres::drop() wins the is_available swap and the
> devres callback loses, the callback returns to devres_release_all()
> without waiting. This means device unbinding can complete while
> Devres::drop() is still executing drop_in_place() on another CPU, which
> is a problem if T's destructor accesses device state.
> 
> Make the synchronization bidirectional. Whichever side performs
> drop_in_place() signals the Completion, and the other side waits.
> 
> This does not reintroduce the nested Devres deadlock fixed by commit
> ba268514ea14 ("rust: devres: fix race condition due to nesting"),
> because that deadlock was caused by drop waiting for the release
> callback to return (the old 'devm' Completion). Here, both sides only
> wait for drop_in_place() to finish, which completes within the current
> call chain. The Arc<Inner<T>> keeps the Inner allocation alive
> independently.
> 
> Cc: stable@vger.kernel.org
> Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

