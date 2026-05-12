Return-Path: <stable+bounces-245368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB+6NEx1AmrjtAEAu9opvQ
	(envelope-from <stable+bounces-245368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:33:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DE8517E2E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7FA30151DD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4974222582;
	Tue, 12 May 2026 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmgIAGXx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647C20D4E9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545988; cv=none; b=Oo8E7mK0nnWafBc1ShlvZXwFo5KmYCZd7tgG/fp/KvH3t2z2JmNYedB9L47k+CvABc//NQC9jtV455cVgp6aVFAa/j2IpIXrKJdIkJT4SN5e4Ekf9pWxOf9mWJdgoCRU4k23Vboz/rmGM2qseSmSV8lP+R1BUl1UimP0s4RLLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545988; c=relaxed/simple;
	bh=z21Rg6dmOLldj+oqibiwtuhS4k3yPzkSfenzFdYrmpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be/WHfpCgFVq8bMUHVFzLQvd7xkMvOkYyz1Y0Z8hf+gY7KVflm6df/Ngj34LqlQKhPkcuwBr7Xx8/835IGcA65HztMQujE0wkSB365nDJBT9ffUes7XI351YBOkvlgJk7UVXIRcyNHPS8pHba2I/cGZCXBHR4DiofIM7fNcRApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmgIAGXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191AEC2BCFB
	for <stable@vger.kernel.org>; Tue, 12 May 2026 00:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545988;
	bh=z21Rg6dmOLldj+oqibiwtuhS4k3yPzkSfenzFdYrmpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OmgIAGXxjndeoe1bfk88vAfgXkA2QDWLej3i3BNGGcelnPgM7ij176C8ivFccHk4g
	 8zfNjpFRGYT0JtjN85YL8GSkUKUT0y/gNqzNxNGedu6m2m/aNlHbewTobP4ngUMbFK
	 emLt4LRk3AbyY6NfvZmPHPZCNc3g7+tnsTrhguRQZaX8iDV/ObxEGwUufldo6veCOk
	 Vfxado3X7JEyTv/LqBftQYcI8hljHrV6AwuGxhZXS4JsYFeMPn5ycyZeNYQZVCNaHl
	 CBSJrU4GmIe2pt0LBTxF3ZNRnHUH7QNR6p1BOzRMaP5NFna59aJp/8rpbGw08EFAgb
	 ijeiI750kQ2ug==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b941762394aso789118466b.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 17:33:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9575rXVMHddF4xDRYZwbtOLZewKUCMf1Rgt/EVCleyPLNmgJkH7FV+jCxk0NpK2aMadmAteeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDPpsIXFWy7MEuf4WurC5COx8IiC/DQgX4LTrZGQKrmW+dnv9
	8l8a1VKjW2WCTox1XZ19ntLAzf1fMK4iFm14LSsnlsnewBSfGnPhgi3YQp6qDBcPwZ/OOROPlIn
	G1McX3V5iavz41/VR0u8+sXZBOXBpg0c=
X-Received: by 2002:a17:906:f591:b0:ba9:559:10c8 with SMTP id
 a640c23a62f3a-bcc14b9be71mr683392666b.41.1778545986700; Mon, 11 May 2026
 17:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511131816.93314-1-mengferry@linux.alibaba.com>
In-Reply-To: <20260511131816.93314-1-mengferry@linux.alibaba.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 May 2026 09:32:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Ut2=r=3r6t6GJFdKkKa_w7oDfVB3SX3OYOt_9ob5rtQ@mail.gmail.com>
X-Gm-Features: AVHnY4IRQjJ6bnV_NMwFSzexW9DfMtoqU6bF-mn4wvE_MV46FAbeXrp2imQThw8
Message-ID: <CAKYAXd8Ut2=r=3r6t6GJFdKkKa_w7oDfVB3SX3OYOt_9ob5rtQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix SID memory leak in set_posix_acl_entries_dacl()
 on overflow
To: Ferry Meng <mengferry@linux.alibaba.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Tristan Madani <tristan@talencesecurity.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 80DE8517E2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,talencesecurity.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245368-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:18=E2=80=AFPM Ferry Meng <mengferry@linux.alibab=
a.com> wrote:
>
> Commit 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16
> DACL size overflow") added check_add_overflow() guards that break out
> of the ACE-building loops in set_posix_acl_entries_dacl() when the
> accumulated DACL size would wrap past 65535.
>
> However, each iteration allocates a struct smb_sid via kmalloc_obj()
> at the top of the loop and relies on the kfree(sid) call at the end
> of the loop body (the 'pass_same_sid' label in the first loop, and
> the explicit kfree at the tail of the second loop) to release it.
> The newly introduced 'break' statements bypass those kfree() calls,
> leaking the sid buffer every time an overflow is detected.
>
> A malicious or malformed file with enough POSIX ACL entries to trip
> the overflow check will leak one or more struct smb_sid allocations
> on every request that touches the file's DACL, providing a trivial
> kernel memory exhaustion vector.
>
> Free sid before breaking out of the loops to plug the leak.
>
> Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL=
 size overflow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Applied it to #ksmbd-for-next-next.
Thanks!

