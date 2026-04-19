Return-Path: <stable+bounces-238632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP7nM6iE5GkAWQEAu9opvQ
	(envelope-from <stable+bounces-238632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:30:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8642354E
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BF7301C144
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A04C378807;
	Sun, 19 Apr 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9QCQs0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0A33CEA8
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776583834; cv=none; b=MRZFBdsxSjdm/RzFVQ3HX29iMO0bqs6+yS3qDIKunDnQAHcGNWphTpFkFYTDkiPB6H77WnOHA18IF5GcBFyD0GD/JaQBI4yD0Dak1Knh2AhRWm9mpI+6IHFHgP5wqVMy972liN/LdSfpmZUqL91d/c3xxdRpJgNkUlwqvMt53x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776583834; c=relaxed/simple;
	bh=wfUrrQBCkecgTuBu9NhgoRwwZHhreWaGejevzpekHV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMq4iw44pXHX1ps3IWgYrCvQc6My78CWi+Xtx0KSz/jjJEXtE9c0AN7qMUO1/gdyGPKL2/zT8KvlxEuBiPP4P4IpAN03mTZ+F4AmbeVyFPvioYdXUkjxV5+IT/79eBa73z8EATPpRzFfog9+PfCKi07VZL2MCqfH5g4VR91M2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9QCQs0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1342C2BCB7
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776583834;
	bh=wfUrrQBCkecgTuBu9NhgoRwwZHhreWaGejevzpekHV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q9QCQs0W1wQHHNT29hVD1QBiQLjImjS7lbViJ+v3WRJXVw8ZpSccCoTT4h6E0CIEi
	 0DFoLPc9ggeTjZJR0z8bProuDBdEK9773UHaMC2OKC4s48h8w9lqLdhi1caTfZCGtx
	 sGB46WgbZrNo84ThqPpNqhrcPMgsVFFtWi9iUlaeiWQDUt49nJCNvwqfTO8I46rlDZ
	 72m4DoJGy8697JlxQZb6qJfPBcB2HDxSQQbioaSTw03MCHU0Ciy4br1gwfWsmAxqg2
	 /2qde9C8p6znyZGF2kx3rruEho2gZkUt6jUI6P1HVdbaPQc0YcY5YHvnz8cBXFQqAi
	 C5oBcA1/7O4Jw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso2761484a12.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:30:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/hAHvOXk9vyAMPrkuyAxS9/FPDgawW96ObN84H/3k0HdaLuxS2WNQA9fmP7JKmgt5CvmJ+jmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydX53YE6+aDKBJwCO0+dIcVxtXY3yncuG7RH/L3NfmmmkRoYPs
	KQqEF+Ww3Smk2hUC2+dGHVVSGGo17pqXNoFNYAEepOKPoDyfvVlKZ7epz8b4Fpv8gWYUPxbsP/o
	zSvLJUetT9ilaTcRUPXqEPt87K633++s=
X-Received: by 2002:a05:6402:26d2:b0:66e:8ce7:5461 with SMTP id
 4fb4d7f45d1cf-672bfdc947cmr4231892a12.16.1776583833220; Sun, 19 Apr 2026
 00:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418172844.1333378-1-charsyam@gmail.com> <20260418172844.1333378-2-charsyam@gmail.com>
In-Reply-To: <20260418172844.1333378-2-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 19 Apr 2026 16:30:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8=ckDwaYgKFZQG80umwKBO1S2UuTWq34qq8hRQ0Nz2tA@mail.gmail.com>
X-Gm-Features: AQROBzBZ6N8P1_138HmLsN8SXaSKKLbOnBVKn-zYmzcS-gbAK7Pzb7AQE19FL6U
Message-ID: <CAKYAXd8=ckDwaYgKFZQG80umwKBO1S2UuTWq34qq8hRQ0Nz2tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ksmbd: fix active_num_conn leak when
 alloc_transport() fails
To: DaeMyung Kang <charsyam@gmail.com>
Cc: smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Henrique Carvalho <henrique.carvalho@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238632-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5FC8642354E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 2:30=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ksmbd_kthread_fn() increments active_num_conn right after accept(),
> before calling ksmbd_tcp_new_connection().  The decrement normally
> happens in ksmbd_tcp_disconnect() at the end of the connection's
> lifetime.
>
> If alloc_transport() fails in ksmbd_tcp_new_connection(), the function
> releases the socket and returns -ENOMEM without going through
> ksmbd_tcp_disconnect(), so active_num_conn never gets decremented.
> Under memory pressure, repeated failures monotonically inflate the
> counter until max_connections is reached and new clients are refused
> indefinitely.
>
> Decrement active_num_conn on this error path, matching the accounting
> rule used by ksmbd_kthread_fn() and ksmbd_tcp_disconnect().
>
> Commit 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in
> ksmbd_tcp_new_connection()") fixed the sibling leak on the kthread_run()
> failure path; this patch closes the remaining one.
>
> Reproduced with a debug build that adds a temporary module parameter
> guarding an early return at the top of alloc_transport(), forcing
> the first N accept-time transport allocations to fail:
>
>   * Configure ksmbd with "max connections =3D 3".
>   * Force 5 successive alloc_transport() failures at the accept path.
>   * Without the fix: active_num_conn drifts up to max_connections and
>     subsequent legitimate mount.cifs attempts are refused with
>     "ksmbd: Limit the maximum number of connections(3)" in dmesg.
>   * With the fix: the counter is correctly decremented on each
>     failure and legitimate mounts continue to succeed.
>
> Tested by injecting 5 alloc_transport() failures with
> max_connections=3D3 and verifying that subsequent mount.cifs attempts
> still succeed on the patched kernel while the unpatched kernel
> refuses them.
>
> Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
> Cc: stable@vger.kernel.org
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Looks good, but Michael Bommarito has already submitted the same patch
to the list, and it has been merged into the ksmbd-for-next branch as
shown below.
https://github.com/smfrench/smb3-kernel/commit/6551300dc452ac16a855a83dbd1e=
74899542d3b3

Thanks!

