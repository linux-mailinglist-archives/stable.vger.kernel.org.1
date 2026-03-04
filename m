Return-Path: <stable+bounces-223001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENs/L1Tgp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-223001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:33:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7754D1FBA19
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 542B0302F7ED
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4936C598;
	Wed,  4 Mar 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjR+++5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E31369999
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609602; cv=none; b=MmgQpv9hKjK0bFgJeRyQQxLOJntYzGZZ9d3xs82+5/XaSszNSybRWgrjKNMfbgvq9xrwKtoiJGGBFfxuUUTlnQvaMwgcbUYf/IfiOAGFSr+j+TPmKJThoQCtlO9aQo6v+Yb5KIiWhBskgP3gB+C6pUluV7gFMdGP67Ju+UwCOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609602; c=relaxed/simple;
	bh=JpywoMyHFkjiKZjEsn53+IkfTs0czhJllJ7JQK7wrI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsRGt/gMHaZHxqVPvIS5McU1FM3BE5J5HYyjTuw6BYtrDg51FbwrfoZOgD7L3dTWNzTRpwuwIAgn/KH2DgMkuY1nwzncCIC63xE7FENh8u7Z+i1OJ2il8yyktlQwRQDwImATeniEiT7H48bIpjM1mBCELtAStFyDLtQLKz+Q3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjR+++5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A607C19423
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609602;
	bh=JpywoMyHFkjiKZjEsn53+IkfTs0czhJllJ7JQK7wrI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MjR+++5oqBp0Jw9NuoAPlGBVBv2JnoFjSp5sbjsgoWtUYqstx6PtYxQMudf34LVL0
	 sIws0eJAmhd9h5rZcxei8RDDfgz7ln1vRnlMXcQPvKEhcdCV06G8f1zZpmRJgI5hBL
	 n4SUVQblLRKP3OdTPvHLtKnS96QCp0xIQNWzvW+C7ChS9DxWcr1E/gwo1XinuwXw2U
	 9C5fQQjrNqOy9/E2RVSSuinqEaazVHKsJXPxLhejFsyG5WK6MtWbQ154juji+N5vhd
	 KM8BTdx8fYDxhayxXvbWnsdDzgUXs6Z27ZZL/aXf6ciBhw/s5DmsLGkXED35kuW1by
	 xFXfDiYe+K3pw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9360037cdfso967410666b.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:33:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKZ3WFYUKQF+6T+CqDzLNNoLGM85dbKg2l4rECLuiwNxwh318kUqcWSiTyJ3C0YBp2yHFAM9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnOgKxX3lcIVqt13fl449EHpBfJHjrzffgwpC50v0xOx9TJ5W
	/uSBaYB9+6N0pJxPDpE5V08tmLuMgFUBurIF2e+Bm5s3I/cJgCC2ibo7tcMi4hqWi0bwpmljKWJ
	EeIo3O9jMTGaNYrUJCRqYsaOwMZENbw4=
X-Received: by 2002:a17:907:3e9f:b0:b87:2f29:2060 with SMTP id
 a640c23a62f3a-b93f13b269amr64049766b.26.1772609600557; Tue, 03 Mar 2026
 23:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132552.65235-2-thorsten.blum@linux.dev>
In-Reply-To: <20260303132552.65235-2-thorsten.blum@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Mar 2026 16:33:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8kvfDForq-UegFW+aC=y2X0riYn6bBGF2w2XTUOW=tUg@mail.gmail.com>
X-Gm-Features: AaiRm528qVX0kLxkzn3X7EpvjA0z6czgB-DbC-DVu3I91q11eIWo00QF0VGX_Tc
Message-ID: <CAKYAXd8kvfDForq-UegFW+aC=y2X0riYn6bBGF2w2XTUOW=tUg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Don't log keys in SMB3 signing and encryption key generation
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, stable@vger.kernel.org, 
	Namjae Jeon <namjae.jeon@samsung.com>, Steve French <stfrench@microsoft.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7754D1FBA19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,redhat.com,vger.kernel.org,samsung.com,microsoft.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-223001-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 10:27=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> When KSMBD_DEBUG_AUTH logging is enabled, generate_smb3signingkey() and
> generate_smb3encryptionkey() log the session, signing, encryption, and
> decryption key bytes. Remove the logs to avoid exposing credentials.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Applied it to #ksmbd-for-next-next.
Thanks!

