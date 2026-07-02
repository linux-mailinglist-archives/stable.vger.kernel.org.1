Return-Path: <stable+bounces-270397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ZLjF0dGRmpJNgsAu9opvQ
	(envelope-from <stable+bounces-270397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE26F66B9
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:06:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DlnyGN6g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270397-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270397-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C95E30B98F2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D74D38E121;
	Thu,  2 Jul 2026 10:33:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2935F17D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 10:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988427; cv=none; b=acnRbwLk5HJ75q0sVlSuHlL/m5WD2RXG7EDVALeFT4wMP744Qt1RlcTEiPQc+UmVD5AjRET4yhtfLtgbqvYB2HwC4nohoGN5eQI9h1gBJ8qJWwMdYpT62+urBSLxmZfS3vAOq9HVHnDbnGdC1FlgBfZ3NLC+sjLnQpf36+4pqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988427; c=relaxed/simple;
	bh=dU/JhXcw9C+3bxVyhCk433RwAWlu/+DSj3wRiplg67w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGNZRUbOoF63NOIgKBw6lOZ8I2R8FmNVZcOiyze5reD4gCWlASbaBH9k7paMkfUM5Y6liPAamPVh1qMbu+/dcwIIiP4WgqA7TCXl1egbOK32DKiHk7GaT5vuy1mrKh3s+WFyseSpaaVAst9iS6QrokuZyqHA828mYb/E15KcJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlnyGN6g; arc=none smtp.client-ip=209.85.218.74
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c126de56711so179907366b.2
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988424; x=1783593224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSBXWVP6cFuS41+bLzi/68MzajKJS5Rgon/65yIMPQ4=;
        b=DlnyGN6g9tvWkuWfVDZzKtjbR/v7hFljcRPYucvfsFeS/1S1Zb5obZF5Xb5+oDWTwl
         C397p2jqUlXd/Mef+brDL/Psj8y/SVLrXOBuEDb0hg09TbCJZ2MKv049uKx/miy/3V3s
         2ArJzxPRicgaPH9jU2B0xN+JYZEHPUzu/9EtGkkSqxB6AvGpAiTHUJR39BGpJSiIn8Xu
         smM/UK3gk5wQQ0h/j61wgZqkoEu2JYwn8dodsHae+LitBGqF5kmQWYh+NQC+mV5G9tJJ
         zsG5rKoiA7+1dBg1eJ0Zuv6Ol3RhIYE4Sfonz1uRrFSvhDywrVW3oYMwUcDH8yPhWuUN
         QKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988424; x=1783593224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSBXWVP6cFuS41+bLzi/68MzajKJS5Rgon/65yIMPQ4=;
        b=gqXq+CkwXw17L+FToEaiqEcYmqVL8wZPzhfubYTY4VhXr3BhmAVJVnC8AqMxkImq9i
         eqGhM2D14k4BMLH1Oy7LpAhG0L6xfiB16ieSMmXw1TL0InGdOBoJYJWo3P7GVjEhognN
         rDpA3AbuBqOZu/NOdOsInKckvF/KXtRqSkTGBGKXtGy7F81rJgosNoZyU/s1D5pXXh4w
         qxCXqC9F7ub1l8cZ2i7jOwLmJKhUwzOVFw2ruUtFD74YwgOd22C292BaiY6/UclhSP9d
         qUVd9pvzOB+DHEBXSPcpd0w8g9Vd9oYbLA26HAtjDgiTCSGyNQL8dtJQtcvisovvYHhL
         szYg==
X-Forwarded-Encrypted: i=1; AHgh+RrrALUy43sex+ptw04szuxa3VmrCnWx1hdZsS61KBRSQc83+sQMJJZbvreEooRH+9RQlILt350=@vger.kernel.org
X-Gm-Message-State: AOJu0YwleAHZN4KvAPl0JD5lsFJIebbIln40C5bRTIcwhhPEYoaljbba
	VZkw9CfJD3dpjA/1cst5oBY/cHYSmZZrADda62kpYjsZtel9xcO4mrkKYqE/nmVVO3ZRd1dAmK8
	RMJ8hKJdFys5KOkPI4g==
X-Received: from ejsc14.prod.google.com ([2002:a17:906:694e:b0:c12:4bb6:ec57])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f85:b0:c12:add7:b97b with SMTP id a640c23a62f3a-c12add7bc23mr240698066b.29.1782988423378;
 Thu, 02 Jul 2026 03:33:43 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:33:42 +0000
In-Reply-To: <20260628174451.2275679-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260628174451.2275679-1-dakr@kernel.org>
Message-ID: <akY-hn0upJuaeS8i@google.com>
Subject: Re: [PATCH] rust: devres: fix race between concurrent revokers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, tmgross@umich.edu, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, lyude@redhat.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270397-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEFE26F66B9

On Sun, Jun 28, 2026 at 07:44:38PM +0200, Danilo Krummrich wrote:
> There is a potential race condition when two paths try to revoke a
> Devres concurrently.
> 
> The driver core's devres_release_all() calls Revocable::revoke() via the
> release callback, while Devres::drop() calls revoke_nosync() on another
> CPU.
> 
> The revoker that does not claim the is_available swap returns
> immediately, but the revoker that did may still be executing
> drop_in_place() on the inner data. This can cause a use-after-free when
> the other revoker's caller proceeds to drop adjacent resources that
> drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
> SGTable freeing the backing sg_table and pages).
> 
> Fix this by adding a Completion. The release callback signals the
> Completion after revoke() finishes, and Devres::drop() waits for it when
> it loses the is_available swap. This ensures the wrapped object is fully
> torn down before Devres::drop() returns.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smtp.kernel.org/
> Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

