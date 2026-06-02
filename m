Return-Path: <stable+bounces-259838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3H2yOVvvHmrHZQAAu9opvQ
	(envelope-from <stable+bounces-259838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 16:57:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCC862F855
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 16:57:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GcJKL2Cv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259838-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259838-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3EA8301AA52
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3C3630B3;
	Tue,  2 Jun 2026 14:56:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CA317155;
	Tue,  2 Jun 2026 14:56:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412186; cv=none; b=TnprcXFRVRW4o7lrbppN7Te6fBzrIrTTblfLP87zbirruaG3REcPyMAHtvwYzUISvaSSz51gNPbe/C7Qx2yygjLYLBNziyHb8SbCo5z56bxpJvDl53a852VbVz4IC18o0G4Ahy7imO+ggxei7iTrAu+7eVnMEqNygna4INpBZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412186; c=relaxed/simple;
	bh=YIJ7rX18HompEVY/4NNVgbjIACeu2JguLfv2oFETzRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGiEihQKKeF0/3jthXqW2qF9Uj6tyPF3GZtOPV8SIDkUCGE0JH0pddm8LfFnm9iD2GU607P3Eo1RbE42Jd6jXMVcSfllhdyOslzovfHNFEmncofxtSM7Rgsy1O5wtJUpFnrDWH+3pUs2huJZ3QLg5k7BWxRNK8ZpaSBwg9vGLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcJKL2Cv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571D61F00893;
	Tue,  2 Jun 2026 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412185;
	bh=0e2WjIs6vl0bBZ5EFT0fhM25ePLzt3kOIfXa7ZB9L/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcJKL2CvaHnwZW6E7iGjBIFcbBHLFvPp9WHiVlMihkSzVt6lTfMwhubopJb69WO8y
	 aS9UKuMoKGvl4hkPXh5hVhPeXaxkEh/P/7jahkX925GzB71OLePVeukYnU3bobi/cy
	 StjmYBKRu1bEKq6LJ745EKvE0Kq8wMrvp7JsOkvSDCvTX50qW8IGpVKuM/ZRleq3e+
	 Gpncx5Dt/sHaog6DCc+zanVtzY33MiUWMv69GkxKFcqpWYxpqa/aNX8GL3FPUfOfFa
	 QhlFJ6cfaMuao0Zicw5vmxvAtdLa61RHcOnEu4Cqk6tzVnOV8JyDM2gJQw+4hACeBa
	 +VzOXWGoyH30w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org,
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in userspace)
Date: Tue,  2 Jun 2026 16:55:43 +0200
Message-ID: <20260602-qualifizieren-besagen-raspel-96ecdd95091e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602020444.GP2636677@ZenIV>
References: <20260602020444.GP2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org; h=from:subject:message-id; bh=YIJ7rX18HompEVY/4NNVgbjIACeu2JguLfv2oFETzRw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJvRcpWOl/4NJv3VmVSx93vGr3PpK+83pRd2yRkCyPT +4VZz/ejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImccGFk6GDlS5smNDukyEhL esIk72L/pftkbO5OW/ZFftOidq/4PIZ/VkGajL21x85YpE7if992sXTiz8Pf1j9tnhXn+DTr2Jd pjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:stable@vger.kernel.org,m:arefev@swemel.ru,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-259838-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BCC862F855

On Tue, 02 Jun 2026 03:04:44 +0100, Al Viro wrote:
> one should *not* be allowed to mount one of those, new API or not.

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] mount: honour SB_NOUSER in the new mount API 
      https://git.kernel.org/vfs/vfs/c/67d8c452fae1

