Return-Path: <stable+bounces-247164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDkUNh+rBWrtZQIAu9opvQ
	(envelope-from <stable+bounces-247164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:59:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4EC540B5B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63379301603A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBB3AEF44;
	Thu, 14 May 2026 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+FAjQ0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF43A1A2F
	for <stable@vger.kernel.org>; Thu, 14 May 2026 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755836; cv=none; b=htqipblmnRhVOgGuhTM321QbVHUOJt5KodfagkrsyQC9dKkZMORFcwVLeR1UboN5+bgZef/vrr+cKylLfPIDUjG/n+5B5smzQoyYf4gjpM/NbVJVy8YD//DVcYJfmq/MyZYmFE4O6Hmg6fKMCWDmKWalBYzhMy5bgqYWQJfmN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755836; c=relaxed/simple;
	bh=Xis8AWQbeRmvveMUcjmhG+4uoii7jvsGUUXTKCq+77k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idNaeZe/yTjmDVc9JR0pC3K1Y8B6owZG2uQNTbZhFIOuWHuNvp6ywr65/m3sRCmGigrwTEeu1PuOLcp/uPGZLxiDHaiaZ3igM4KRb8p0nwfdfSLxktiHBwXLLw2dVVYP3303P62ymv6N2Eu+THKCo6ms+R/2TMiXTt+IOR9ggyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+FAjQ0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E262CC2BCB3;
	Thu, 14 May 2026 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778755836;
	bh=Xis8AWQbeRmvveMUcjmhG+4uoii7jvsGUUXTKCq+77k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q+FAjQ0REJmtQc4DDiR4rIREzV9Wm+Xzm5ld0LodQIWf2tzNHZhhYH03FtBg8ftH3
	 SnCgqY6YLlLXfNbLiZ1Zud1kWO0paTMv9Br/Y+NSfRm/1YNw+f1RyJKE6GSny6Yra3
	 lSr0IA00w5xen3RviPzB8M7/jyZaxA2/dONoCI6RgmSeM8g2cpFbDA5aDab1jPyKtf
	 EdW4teKi1S+/axhfEP5yibQcuMSMFets30o5OZw0ypu455l/4QruFayDe4WyhIIyFN
	 NI/FUcgTkM33CH90prhpEvU+9WybvbdMWGi3tabf5lCfzRfUOcGJeung0TVDJ7UbTv
	 CFKJ4P1rEPWew==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, dnaim@cachyos.org,
 i.r.e.c.c.a.k.u.n+kernel.org@gmail.com
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clockevents: Add missing resets of the
 next_event_forced flag" failed to apply to 7.0-stable tree
In-Reply-To: <2026051258-schedule-parcel-c95c@gregkh>
References: <2026051258-schedule-parcel-c95c@gregkh>
Date: Thu, 14 May 2026 12:50:32 +0200
Message-ID: <87o6iiz2mf.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2F4EC540B5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,cachyos.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247164-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernelorg];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Tue, May 12 2026 at 15:50, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 7.0-stable tree.

Obviously not. It's in linux-7.0.y since April 22:

commit 9401b593fa48218d2667df1610b0ebc518554880
Author:     Thomas Gleixner <tglx@kernel.org>
AuthorDate: Tue Apr 21 08:26:19 2026 +0200
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Wed Apr 22 13:32:23 2026 +0200

    clockevents: Add missing resets of the next_event_forced flag
    
    commit 4096fd0e8eaea13ebe5206700b33f49635ae18e5 upstream.

