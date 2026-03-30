Return-Path: <stable+bounces-230982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLt0IEDJyWk12gUAu9opvQ
	(envelope-from <stable+bounces-230982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:52:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C924354791
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 623BB30028F0
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2A1C7012;
	Mon, 30 Mar 2026 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9M6QDaV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA740DFB3;
	Mon, 30 Mar 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774831927; cv=none; b=LVa1/lB0DRxAab3IIixZEWr+5dvSVkgRRK6dVb00fBOaipRC3SmU+s9ha2cYKYGKf50EpoDFQk2Ymtua/lpzbWu7hB0b9jpWLbQT5RMEFAqiclA+/cEEegTsHdVTY34H51wZEFBKIqVoixPm/OX4XCv7SiIFjN4Zv4KRPvWSf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774831927; c=relaxed/simple;
	bh=uKNz51piWVofToZhM+NFOqxREDaEtXG2Nv5b2OLoq9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVWL4eshM8sXlqBjMs9JvWKbtTl8fj+uUSuNk7VAwk0yNvsmOaF2UqAoR71v/+R9AgMkOFFbEFWhxA3TZ6YKD9vc+JXSy7PAqWMjIaUMY9t2SuUmjwlSo3duXBN+2VaGQ18ipZfsZLn16bGsS26TtaHbw/sEoSAJsa5qN84CqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9M6QDaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A12C116C6;
	Mon, 30 Mar 2026 00:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774831927;
	bh=uKNz51piWVofToZhM+NFOqxREDaEtXG2Nv5b2OLoq9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9M6QDaVSp92RYm4lYeuWF+ypXxDtO+kGHCnVuQlUInt5OeUYs8gJw1PBA79chNNg
	 pCKLHwO+Lbx1OwbeSN8m/kf4CL9T8VTXOf9F3d/2KJ8jD7sgeNW6kFVdN0czfONHBl
	 7M43o/+OIkgKz+3Xc2EcB78//zMzQQaBnqL5jLBzE1GVNx6lw5yRAlg5erqEe5dWvx
	 MmKUbs31pdSZixXmSmV1BJKh4/C2G7UFckRptbU5OkF5ufhQdC/FL/aoocWkp7EXfz
	 3r6V+xFR5/gIQ6yuDcGkFzF4EAyqphPn/fXGJavyiqn28/2aLOmnPNtrPTELIYpXdj
	 zxMB7rqL1bvqg==
Date: Mon, 30 Mar 2026 11:52:02 +1100
From: Dave Chinner <dgc@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] xfs: annotate lockless b_flags read in xfs_buf_lock
Message-ID: <acnJMhFpp42bdW93@dread>
References: <20260327131152.155617-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327131152.155617-1-zzzccc427@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230982-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C924354791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 09:11:52PM +0800, Cen Zhang wrote:
> xfs_buf_lock() reads bp->b_flags before acquiring the buffer semaphore
> to check whether a stale, pinned buffer needs a log force:
> 
>     if (atomic_read(&bp->b_pin_count) && (bp->b_flags & XBF_STALE))
> 
> This races with xfs_trans_dirty_buf(), which modifies b_flags while
> the buffer is locked by a transaction on another CPU.
> 
> The pre-semaphore check is a performance hint: if a stale pinned
> buffer is detected, forcing the log avoids a long wait on the
> semaphore.  Either outcome of the race is benign -- a false positive
> triggers a harmless log force, and a false negative simply means the
> caller blocks on the semaphore and the log force happens later.
> 
> Annotate the lockless read with READ_ONCE().

No. READ_ONCE should not be used to annotate a benign data access
race. data_race() should be used because all it does is turn off
KASAN for that access, and unlike READ_ONCE(), there is no code
change when KASAN is not enabled.

But, in reality, the race condition here is more than just the
b_flags access.  There is a big comment above the function explaining what
the check does, and that the buffer pinned check that precedes the
b_flags check can race with journal completion, too. SO, if we lose
the race and trigger the log force, then nothing bad happens, and
latency is no worse than if we won the race and triggered a log
force.

IOWs, adding READ_ONCE() to these check doesn't actually "annotate"
anything useful or informative - it's not paired with WRITE_ONCE()
anywhere (nor would we want to be doing that), and so it's just a
random, uncommented macro in the code that makes things harder to
read.

-Dave.
-- 
Dave Chinner
dgc@kernel.org

