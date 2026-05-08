Return-Path: <stable+bounces-244823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKHJCS5J/mllowAAu9opvQ
	(envelope-from <stable+bounces-244823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 22:35:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0B4FB859
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 22:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BECF3037DD9
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605EA40F8C7;
	Fri,  8 May 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfcIzSak"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EE37CD54
	for <stable@vger.kernel.org>; Fri,  8 May 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272537; cv=pass; b=Hrvz6HzlQHGCZ8vIFZuowreYzIt/hOFBCxpFH4HkGmpJXnk9KUfOZRjpKhcOKTXsao/l4RZh6qXV8PlMuKJ1SLvqtyVejnYBvNOo0FeOnZfWKmuFprlwZy+JuRcRd9bz8pNjNsgfUccQR6OXbz0LNDAzwvXo9fD5xUsIfgGut/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272537; c=relaxed/simple;
	bh=tGkZvwR3HBJnT2gUAjQAFsWKSQlCDycL90ho1SbjpNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmIvhjjFJ5noMw/2uSz3T00PJqON2vHDBWuMo9NcN3OLGipeAXIwUgG4OoQIKMUBHmCBN+gRKX0Aey9xYHqmdDPoVUOvYIcrpoQvqKPVI8cYZqaTDvmsjji9IAUPvUmjNmfGT8dq9kghoQ0Pvrzcgg/r+wSzfwiSlnw9J6DSGH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfcIzSak; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-837cd669be0so1883770b3a.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 13:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778272534; cv=none;
        d=google.com; s=arc-20240605;
        b=aBzOAgGxcgN30to/84F5GLFn149IvT9UPnLHx7L27t26Xgct6pvWFZnaWtxleOMk3s
         tduyP/Wpbx0vr8DjHLf5uDqd197ynz/aW6AC6LnEW/Ax0abNSUKsQ9J3oZPqQlOykH1w
         6zrolWXFmgU+W2OhB1+GYV9TSM5xyAQzNa1/weHrj4S96ec7m5gHF0JwPcad7Y5Eo4NZ
         COCHZsU0JA1SGjke/4gkdO1wY0cn4AMBfbtEip0gDFQbWzx9jbrg7awRtAwDjo+ZqNQz
         JkBl7kTsZO/Wcy08l28iTZZFnHGPmNOUIbAGGwmgS1VWktDeE/vLbaNxSN17NByB3a1w
         VxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        fh=5O38oUGf3rHSwPTlpCv4GAJSzOe8eXQFMBcG+CEKoEY=;
        b=gkeUbJ0VulBEWXD52pGjNKQsFytwbPN5dpVi/Yzyc2MmZc9TZeKoWG/BX94vDSXKzi
         qMBR348BLo2PAmw+WpKhY+hFbUsHTTr9QqYAygSweWAXx84Po+ptMcizFf5OJYIOmFWm
         1tcJHKllNwQF3GmZ/aU8kl6U3Ekcw6WpJAWru0ZTGxaWktMNvT42zSw3WKAbwbCaVZ4P
         9jOeGElCOe5Clcp24kEq+d7HhDJ8WMZ/2oeeN+kbI29HsU8KnGF5dCc9Z6zjXyYa+qXL
         AdHHv0U3qNXy2rB/bfWa99/jFdyyPc/Z8Y+hFd083O7+ox9urv3wttHg/lT8JUwMLy6a
         iJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272534; x=1778877334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        b=dfcIzSakxh9uQBHhVv1tj//DWz6nTK22aaUQAxyEckytckZ/SHFzUrMFvixsX3IwtZ
         EslM2G4S8cDvB5LFrhUhCdALObKjr/xIYRds4igKxR6mKeGTIWi7jvxQ62aax1KBkZPN
         DcF8VxdUCJRlPyjuBi+Seum4+dEnVMGSpZHgnrZ7P1ix8UU8UtoTn3SzHKTApvhmF+fe
         MT5giEPBUM3hW/69N2QU8wGQVtFfV2XxocXmcsWnLCyTrt7QCKQgSRuUaYg7w8Et+ea3
         bdcjyn0hUZkbtUHF1Hi/LQWoUI5pgfC1pLWHpwP/mvVZZv7wXDYApvq4c8KHIJwkQNNM
         UmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272534; x=1778877334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        b=AHturovVH+i8BsBVS254nye80z0U00Z/wgAlVSFmzvf4gfaojJiF8NoXZdhozHSKVz
         hpAQaIep8xgJ61qgpN1YCTF1LnVeZPDqiUWqtOfHvoYIjxQfEXsXK6XH5F7+/2Vw4cpF
         bV/b6GJQ79Ne9SXbTeB539M00k1FCLwWsXK7ntHL71AkvnRHVvwzgCWnxUyEwdkPesN2
         fFFq2lQRwio7Ps8sW3hs8TIjEiNK4mOesaCsu0Q8p9IN4cordzMRVS410k3I54IiZi1q
         beZikASQSaYwA/5aNLptjS6fHyhpj20HhKbtHd9/YMutK5tV5nGLcDxiA6yZSgICyijK
         cKug==
X-Forwarded-Encrypted: i=1; AFNElJ9cUi4N+bEab8ZQf5YzoJuxcg9nF4QYjQVYrPOMqafDx6nhAAPlQvlo/u5+VJ51Vsrjrb+R4pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPomvirwrYrAnaaiRwI4PuZQZFl95qFNnAcbmYDiXaB2YRLibi
	xyRBP9AyIVy1VtJLC5mrhYGgIupDAYCY//rPtEGUOWZBHoQUGVVCbYRDco8vnDYdm69xePdd0A0
	Ph1pfMHdEstYGRQjA3WbDjzOw01qOaAs=
X-Gm-Gg: Acq92OFbL86MREqkG+k+XBEyHV8R2XgSKhPCcKCcTHz36hnAUpQkJtCOw8bx6ulfhkv
	uqDqZGcQXla2Ns1DH1AgIuWuuscpFDykhTLdtABHwrzfhM7HPpJjLulgHUjkoFYtRDqpuYHV2V1
	Lz0reTElJSaia1FsurkSWWjf/9dK9licGuONNFsHHSPd5nbevJP1g1Rtn3TgZYlHYjI8XbwRt4r
	2GFAdDbTwGbuDU2SCtu9Sa9MOIIs3KzUHUvLRC+1ZtyZs3mLACZhXin3TXZLckQWyX6yOVzVyVO
	1A3Vc0Ed4SQfOkQNiiw2+Ob4ELT4MK1phHuzhQiXl8wfOK/y8a0qFlVKbmpfR++lAKsfRzHFvF2
	2niFtS8TqArOu8veykyViwvKWr2vCxNE+k5TsKBm0MnzutE6AClI=
X-Received: by 2002:a05:6a00:2347:b0:837:7e7d:3c8 with SMTP id
 d2e1a72fcca58-83a5df4b883mr14060988b3a.39.1778272534439; Fri, 08 May 2026
 13:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508001455.3137-1-joycathacker@gmail.com>
In-Reply-To: <20260508001455.3137-1-joycathacker@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 8 May 2026 16:35:21 -0400
X-Gm-Features: AVHnY4LqanISktwmN-weO_GvoUqdGbL_ndw_WJ60yora6lW3wrSNlyT6YeLV0Ts
Message-ID: <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
To: joycathacker@gmail.com
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Ben Morris <bmorris@anthropic.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B7F0B4FB859
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244823-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,anthropic.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
>
> From: Ben Morris <bmorris@anthropic.com>
>
> The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> list_for_each_entry_safe(), which caches the next entry in @tmp before
> the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> drop the socket lock inside sctp_wait_for_sndbuf().
>
> While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
> association cached in @tmp, migrating it to a new endpoint via
> sctp_sock_migrate() (list_del_init() + list_add_tail() to
> newep->asocs), and optionally close the new socket which frees the
> association via kfree_rcu().  The cached @tmp can also be freed by a
> network ABORT for that association, processed in softirq while the
> lock is dropped.
>
> sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
> via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but nothing
> revalidates @tmp.  After a successful return, the iterator advances to
> the stale @tmp, yielding either a use-after-free (if the peeled socket
> was closed) or a list-walk onto the new endpoint's list head (type
> confusion of &newep->asocs as a struct sctp_association *).
>
> Both are reachable from CapEff=3D0; the type-confusion path gives
> controlled indirect call via the outqueue.sched->init_sid pointer.
>
> Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> returns.  @asoc is known to still be on ep->asocs at that point: the
> only callers that list_del an association from ep->asocs are
> sctp_association_free() (which sets asoc->base.dead) and
> sctp_assoc_migrate() (which changes asoc->base.sk), and
> sctp_wait_for_sndbuf() checks both under the lock before any
> successful return; a tripped check propagates as err < 0 and the loop
> bails before the re-derive.
>
> The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> the @tmp cached by list_for_each_entry_safe() still covers the
> lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> safely") was added for.
>
> Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process=
 in sendmsg")
> Cc: stable@vger.kernel.org
> Assisted-by: claude:mythos
> Signed-off-by: Ben Morris <bmorris@anthropic.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

