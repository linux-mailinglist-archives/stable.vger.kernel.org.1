Return-Path: <stable+bounces-217933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LBeORL1nWk2SwQAu9opvQ
	(envelope-from <stable+bounces-217933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:59:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59618BA09
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9D153079C7C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CE2DE709;
	Tue, 24 Feb 2026 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0bouMI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE223B61E;
	Tue, 24 Feb 2026 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959418; cv=none; b=N9k8ytPcJpDzJjtFgGfGVBdleGVyFSA1T9e6nlyYDWc8CsayxXECf09Q2EaYZMXdw8Cr7Acv49XROeaxGdRWMRa5EkhOm2VdOTZ+btT1HOqb/CHWyOFgdKFyHEBuf5E2ofjtOOFxCr4LMhNgbGAURSiQspgv0HBQaNf2nliCAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959418; c=relaxed/simple;
	bh=gWdGdty3sObst3AxSEA0asv9WiXUMqiWiXHPwha+dYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dlmw/X/tAkfG1e6iMM1icqRPpsbPD5NY8jAI1jnLZ4rikBWPB6K31at0yoOM5c9X4wZG9/EiJ+Qb1wVVxjrC7FpiHIe995Jk/tbxMGUIk/Hs7lnRM9MY88qg6kYBD+z4YqeDWg5zHBBhPAQekjeOVamfUWaqj+GQvT6lMxaeKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0bouMI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B70C116D0;
	Tue, 24 Feb 2026 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771959417;
	bh=gWdGdty3sObst3AxSEA0asv9WiXUMqiWiXHPwha+dYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L0bouMI17ncW/SS+XgjL74W12JnYoJOnwq8KW/v6EPNN6QjPbFKmpInvuK+7HLFfA
	 XShG+5GpQ1sTWIAQ1QbBMxX0QgbkfmcXKaUgRjImjri121Lf82tTqFE9ZgJBObvmrQ
	 5O/qoLQTcr9KUAPPyLunHNmjOcyXgldxmLWd4mTBTz0Y2GAhyLxon+gxnLTFPKRJ6d
	 1vWBkpv7+CQU1Z8H09irgOp5IEwUV7XnSrftBqg0Y8tbrEnqKtqMIkzC8aIN8zEPeE
	 7XTqVORVSlWa2yFtZN4YdffIywI7OySSpDcoqyzeevdRAdB+QWxoLsTA5wHP1uQC5G
	 vdawmVjkip/YQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Subject: Re: [PATCH] rust_binder: call set_notification_done() without proc
 lock
In-Reply-To: <20260224-binder-dead-binder-done-proc-lock-v1-1-bbe1b8a6e74a@google.com>
References: <ry8ugS1oyLFjfDWcakB39X4ARsALkKYmVM1oDOKvSkH3GTMA14eykHFAXT7_QKsQw80UqFPOdmnlvRlaxjFbGw==@protonmail.internalid>
 <20260224-binder-dead-binder-done-proc-lock-v1-1-bbe1b8a6e74a@google.com>
Date: Tue, 24 Feb 2026 19:56:44 +0100
Message-ID: <87h5r60y37.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-217933-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c8287e65a57a89e7fb72];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,t14s.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 4C59618BA09
X-Rspamd-Action: no action

"Alice Ryhl" <aliceryhl@google.com> writes:

> Consider the following sequence of events on a death listener:
> 1. The remote process dies and sends a BR_DEAD_BINDER message.
> 2. The local process invokes the BC_CLEAR_DEATH_NOTIFICATION command.
> 3. The local process then invokes the BC_DEAD_BINDER_DONE.
> Then, the kernel will reply to the BC_DEAD_BINDER_DONE command with a
> BR_CLEAR_DEATH_NOTIFICATION_DONE reply using push_work_if_looper().
>
> However, this can result in a deadlock if the current thread is not a
> looper. This is because dead_binder_done() still holds the proc lock
> during set_notification_done(), which called push_work_if_looper().
> Normally, push_work_if_looper() takes the thread lock, which is fine to
> take under the proc lock. But if the current thread is not a looper,
> then it falls back to delivering the reply to the process work queue,
> which involves taking the proc lock. Since the proc lock is already
> held, this is a deadlock.
>
> Fix this by releasing the proc lock during set_notification_done(). It
> was not intentional that it was held during that function to begin with.
>
> I don't think this ever happens in Android because BC_DEAD_BINDER_DONE
> is only invoked in response to BR_DEAD_BINDER messages, and the kernel
> always delivers BR_DEAD_BINDER to a looper. So there's no scenario where
> Android userspace will call BC_DEAD_BINDER_DONE on a non-looper thread.
>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
> Tested-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg



