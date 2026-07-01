Return-Path: <stable+bounces-270162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y1vgNTMWRWr/6goAu9opvQ
	(envelope-from <stable+bounces-270162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 15:29:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2917B6EE1E5
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 15:29:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dJbMczVB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270162-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270162-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C58732670E1
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30F481FC4;
	Wed,  1 Jul 2026 12:50:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33794481FA2;
	Wed,  1 Jul 2026 12:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910223; cv=none; b=tOZvqJ511SR9o6YLAqkraR2955hg0CSAagB914gUMPK0e1Vyx4fGmludE+rvrMntHj/JIZorUQtbXsbCbmZUbI7VnMna1lKduIysX9gO/0oQ1poNjghqSAASB93zEiu9s/m2lwi67V7b8jRNlGfV2udM45KlxWhPNIfr8v0Hwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910223; c=relaxed/simple;
	bh=detUbZrgUvA+9uPju04NHgTnrkdUao4SkdZZ09nQQOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iiMEUsbIk/vzDK2L+fKEeDVLVF+2H/lrW4tQQqs9hn/Cy4iBIha2p+6XzE2BBU9A8k5lxBfpDm/OC02ut6k984MDqAJ7RF+nJSXhKrZTBGrDwr73m2HxlAmb7o0L5K/pp/+5TrXRGocmq9wZQlZ9VW+xNT/aUwnCHjGTuxIr4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJbMczVB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379261F00ACF;
	Wed,  1 Jul 2026 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782910221;
	bh=das9fe4BLc1rw94oj94HmXrYzMBPLP7/uEWIlEDh1IU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dJbMczVB+TUFTLsHnWBpQeJ8xbg6cCC5n/bYM66wmgKdUQf0zWQv9z15I6vdOZsGY
	 p1zajWxdXt/QaaemE3j5lNZHGUAVch22qB6XdtP5rkgvYUvW4MjHayoxo44MPz8cpj
	 jiqZeYJ7FWCulZJJpA3+JYXKVh4Prs6qPaTp/jSybX7o49TRZheNFmVVfDYhoaOVsj
	 VSUrW2TGADlaujS4DQ3T6yd/MXe1FsRR6EOEwv/SY5uuvdKa1GilXZrEc33WDkRkpm
	 qwHgnDeF04cTeKY5xOs9rTSh5u3eulUDPM0YdO7V2NUWY5B414RDqRRv0jKwplzQgc
	 SvaLNRE+mo97Q==
From: Carlos Maiolino <cem@kernel.org>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn, 
 zilin@seu.edu.cn
In-Reply-To: <20260627060402.2544349-1-dawei.feng@seu.edu.cn>
References: <20260627060402.2544349-1-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH] xfs: fix memory leak in xfs_dqinode_metadir_create()
Message-Id: <178291021990.353898.12065940355634080852.b4-ty@b4>
Date: Wed, 01 Jul 2026 14:50:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270162-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2917B6EE1E5

On Sat, 27 Jun 2026 14:04:02 +0800, Dawei Feng wrote:
> If xfs_metadir_create() fails in xfs_dqinode_metadir_create(), the current
> code returns directly, leaking the allocated update and transaction state.
> If the subsequent commit fails, the caller-owned inode reference is left
> behind.
> 
> Fix this memory leak by routing the create failure path through
> xfs_metadir_cancel().  For both create and commit failures, finish and
> release any inode returned to the caller, mirroring the unwind pattern in
> xfs_metadir_mkdir().
> 
> [...]

Applied to for-next, thanks!

[1/1] xfs: fix memory leak in xfs_dqinode_metadir_create()
      commit: 45de375b25060edf46e20abb36521ba530336ceb

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


