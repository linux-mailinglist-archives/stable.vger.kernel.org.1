Return-Path: <stable+bounces-238631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GtR5DXOE5GkAWQEAu9opvQ
	(envelope-from <stable+bounces-238631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:29:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B042352E
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A135630055BE
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F3378815;
	Sun, 19 Apr 2026 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlkF91Sc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01A375F97
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776583791; cv=none; b=I119upQDmeSrSvzaOA/FxmG2MbSWEfiWFIGrGzxbMyROkTB2LJAsXy2DGV9jKz1zJ3JeGBX4R7gewAeMllEQDaw5dwhhgxIvjOootr5ZHOTjRipdakmYQa9Hh94Jw1WoJK1rjSAjaytspBgG3UsH+GjIjKcM3eU3j1dnbXL8wN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776583791; c=relaxed/simple;
	bh=QJqUE+KIWv01jPr0qaOhAYIMdk3vkM2VjM9uMykgIa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9gfzYl/lGPehh5L0fp0Fjz+wIhebBgoBqsNLp9NEs+xoW/wVnPUfSDEil87Zq90jzt7EKq1fvU5g+uRRd7cdP+e7Sk9cBkmJzyisDQ3wXt+CZxYeHsLwPwBD40r2zv/o1Uti47timzLS11BppzO170leTabIKr3tXCxYym63n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlkF91Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DFAC2BCB7
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776583791;
	bh=QJqUE+KIWv01jPr0qaOhAYIMdk3vkM2VjM9uMykgIa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nlkF91ScFrhpJeWmo1aO+q9hRzmgOcNKxtcqnRMBVcf9SjhY9uEGOy0rXV/+addoR
	 39Zn9iZBa0yim4uCArlyeqAtJIoKPYE0b5MWFHpVrf68eDBztMYO7Jf7/ZMjFQSTF1
	 FUfB1Zr+NGRCkq54I/unG5GC2ACKao4OFLTVSOgzLtmrIlbo6OLhjPRPd14N7HNdnf
	 Eag/SWD1qUrqi7ck1AzlIhiwxMv75FB/zbo/gCucQBggWMxQ7njYlD2nCsUo4K9Mfy
	 7AXCir9HquZyqrmaUaXwSQtC17FO3Q6qAZkkLG64i4klgiPyIEkM/ibh3YSztGNyEB
	 9mt7dEfYqFcCg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-672bd8d2400so3997512a12.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 00:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+e9tUuC+GCfmK010sUBQB2UyJuhgdhkT18uaeuaEXDuy3OfasKNVK1DBVWHELaIhtT+Eznvt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MJwCgHIY82MYNkFaRT/Xh842K1bXheDvrWEFPgEUfDzsOha0
	ioyqpSJ6clRAOUSP0kNlm7dBsqUoObWZdg8ZnTcJra+YSna/i5lnxnrrdd9InHZOdwoy3+6dmSA
	1xnOUTZoYCYbBESNht72HTIrnnHI95sQ=
X-Received: by 2002:a05:6402:a54e:10b0:669:cc03:334a with SMTP id
 4fb4d7f45d1cf-672bfd9db0dmr3075102a12.11.1776583790183; Sun, 19 Apr 2026
 00:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418172844.1333378-1-charsyam@gmail.com> <20260418172844.1333378-3-charsyam@gmail.com>
In-Reply-To: <20260418172844.1333378-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 19 Apr 2026 16:29:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_0-qXXktu0EBmLWATqthSXetVvQ2EzpgBnsOkq1bU=wQ@mail.gmail.com>
X-Gm-Features: AQROBzAOKLjcpFyO0NiqvNftv3mmS9SxvjLG3WX0f-Iq4zWubKruu_tv2He3XbY
Message-ID: <CAKYAXd_0-qXXktu0EBmLWATqthSXetVvQ2EzpgBnsOkq1bU=wQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Henrique Carvalho <henrique.carvalho@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238631-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A91B042352E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 2:30=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> rcount is intended to be connection-specific: 2 for curr_conn, 1 for
> every other connection sharing the same session.  However, it is
> initialised only once before the hash iteration and is never reset.
> After the loop visits curr_conn, later sibling connections are also
> checked against rcount =3D=3D 2, so a sibling with req_running =3D=3D 1 i=
s
> incorrectly treated as idle.  This makes the outcome depend on the
> hash iteration order: whether a given sibling is checked against the
> loose (< 2) or the strict (< 1) threshold is decided by whether it
> happens to be visited before or after curr_conn.
>
> The function's contract is "wait until every connection sharing this
> session is idle" so that destroy_previous_session() can safely tear
> the session down.  The latched rcount violates that contract and
> reopens the teardown race window the wait logic was meant to close:
> destroy_previous_session() may proceed before sibling channels have
> actually quiesced, overlapping session teardown with in-flight work
> on those connections.
>
> Recompute rcount inside the loop so each connection is compared
> against its own threshold regardless of iteration order.
>
> This is a code-inspection fix for an iteration-order-dependent logic
> error; a targeted reproducer would require SMB3 multichannel with
> in-flight work on a sibling channel landing after curr_conn in hash
> order, which is not something that can be triggered reliably.
>
> Fixes: 76e98a158b20 ("ksmbd: fix race condition between destroy_previous_=
session() and smb2 operations()")
> Cc: stable@vger.kernel.org
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

