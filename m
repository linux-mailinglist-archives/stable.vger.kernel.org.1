Return-Path: <stable+bounces-217889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P/YH0plnWlgPQQAu9opvQ
	(envelope-from <stable+bounces-217889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:46:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD83F183EE9
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903633130074
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0B366DD8;
	Tue, 24 Feb 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpRbp+D2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B65366DB9;
	Tue, 24 Feb 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922576; cv=none; b=EEEiSZMYwZFavRCwCTd5+v9DBZZjDvvLRooH95ewomFMZGyMUn1uRtmnJpC1YtX/Cjg0lj32gDm3RzvJtNWUXLGB9HO7tVldnyTogDc+GZbUktYpotjn3QgmZkSnl3lX4oTEO3pmciKfKR2mMZX+hQkjrlBCsVXdDlWXVL8B5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922576; c=relaxed/simple;
	bh=mAauT/h91Ezbt8aiRcd/cFBF8hsetiUWYCIPUG2LX5o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OrTkDb152uP0bjI1aWiBwpkAT5kWmxUJANY80fFP3yQX+VhnwH/aFLTKODjh7+RqAOVkdIgjoOtt3Qk9YUyQLM1QP4CRPNhJlNkLzBJc0e5vqev5OgFp22mLsjOzmdbpWBPBhhT57qlIFXj07ebm43AqxPSZiDIrelwCM7BNlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpRbp+D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2900C19423;
	Tue, 24 Feb 2026 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771922576;
	bh=mAauT/h91Ezbt8aiRcd/cFBF8hsetiUWYCIPUG2LX5o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DpRbp+D2nZp9T0AuMTd3fpkY3iNxayUIO57Aha9TQF/P9a6JnOx4CcmAEmKhI1ilu
	 pPUePK1f71QMkfuOP/fI4v4O7u5iwAIX6SKvjguD8R9BNGNrMdZuvCP5VI0WErMDz/
	 WBnYrEXqwJFu/OZEn7HD1chbFCZCUZm8KLcvayCCoXYukipuhAE3k/U2y7giVB0xpN
	 r1in4KiYmx4TxRLampX1+EelFVFp9BKAo5uMcjj+UOM55wwClFz6+qh4gKHPnnIsig
	 Sl2p+1MfpxdLUIXp22c10aFclL1ISDAWJo/UcBUOyvMgqN+KBwSS+9PSu9X4U8Lbap
	 UaVdTQbUN54Kw==
Date: Tue, 24 Feb 2026 09:42:53 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Lee Jones <lee@kernel.org>, David Rheinsberg <david@readahead.eu>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
In-Reply-To: <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
Message-ID: <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
References: <20260211164025.171242-1-lee@kernel.org> <aZmsTQeeGf26FqvY@plouf> <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217889-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xreary.bet:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: DD83F183EE9
X-Rspamd-Action: no action

On Sat, 21 Feb 2026, Jiri Kosina wrote:

> > > Since the report ID is located within the data buffer, overwriting it
> > > would mean that any subsequent matching could cause a disparity in
> > > assumed allocated buffer size.  This in turn could trivially result in
> > > an out-of-bounds condition.  To mitigate this issue, let's refuse to
> > > overwrite a given report's data area if the ID in get_report_reply
> > > doesn't match.
> > 
> > That's a strong assumption and a breakage of the userspace FWIW. The CI
> > is now full of errors:
> > https://gitlab.freedesktop.org/bentiss/hid/-/commits/for-7.0/upstream-fixes
> > 
> > It is pretty common to allocate the buffer and not initialize it in
> > get_report operations.
> > 
> > It was a bad API choice to have rnum and data[0] for all HID requests
> > (internally, externally), but we should stick to it. The CI breakage in
> > itself is not a big issue TBH, but if it breaks here, it will probably
> > break existing users.
> 
> Lee,
> 
> was this found via code inspection, fuzzing, or is there some real-world 
> report behind it?

For now I've dropped this from for-7.0/upstream-fixes until it's all 
clarified.

Thanks,

-- 
Jiri Kosina
SUSE Labs


