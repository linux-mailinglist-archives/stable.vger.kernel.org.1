Return-Path: <stable+bounces-268327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kfbQFgj+PGrWvQgAu9opvQ
	(envelope-from <stable+bounces-268327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:08:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA916C47DA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="o2x/0XO1";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268327-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268327-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52315302E924
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949863C4B92;
	Thu, 25 Jun 2026 10:07:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868C3C2BA4
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:07:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382049; cv=none; b=Un8JCFAsQrQwWMLt7QCi2HxtiRwK5Z/3xR7FnV5rRD2HgPNuWhj6KOJPQQE4fc8bCqj95AaXwEwTSS4W5xEFxmmLeQyq9t1JBcu8rU1uE5tdGYWmYxId0BNYimLhEfG4r53/dXDJemR/sFAqAlDdqfPeDmcqaLQ1/w9CZAbnb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382049; c=relaxed/simple;
	bh=JRKcCwku1VbtJJEhFhz+Kf1u5xuWM/axT/2vwJWLaos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvDKRu8ESkpfR8UL3dn9bT+MIrHWmOTDdv7fWSfZSnro0p9S5ao7QAwmS0LFxnl1hZ9abemAssoxXY9HxfQwyAeFCSO3tPBKqRt8PhB/nulI864MuHfY9NG+wfrTv/d6Bvl/SCyt3iYD6amgQeg8ixf+zcvj8xQyvxakhQLqk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2x/0XO1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AF91F01561
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782382048;
	bh=JRKcCwku1VbtJJEhFhz+Kf1u5xuWM/axT/2vwJWLaos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o2x/0XO1xrRvf319YAiLAVMBX4BXD1ncJXyBMYgfFq4a0w4pQnpJ5bgMTXs3J27/n
	 FTtTRqrTi4lTZNpt8p4+X4HLj0iVvwKzZ7JXa92i2mNgbMoRWQU5TBpmB+35IdeNSY
	 lI+GaaarnUhFjjUdr2eIIjb1qsDlEvSkR5Xt+0wvIp7LeZRKxZiuZc9MOyLnOmd7we
	 HaETwwRJkf9H2RrWj4ZrbIW7soSd2dKY+96Vsz1+Na97Z3YOTVRFY7iG9R3ojDkjWi
	 rftx81cOqv4cUO8si2SBFX02bEbR5ZYU1r2FZ4devdrmhZPxX2UpkTmA4uGTwyOmk+
	 8X8oxlBL5t8mg==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91562bf6c12so197184185a.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:07:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ88nEG9nPm7ZbPBSXo3He4PlfNFou7qq2DpnbKCRz9WN95hsCT3WS54SIX5T1N0+QStKRH0f7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76KY9Mn93QjiZBCm/md/6duNXgUxA9to47iT5k7MbSeJItu1w
	DXm2se2fiECPotP6/lR6vCK/W8uzNb8UOUB0utonHQ6ncjbQ33l68BcgA/nVKQQ3at9hEJY2wh4
	+MdD2TSWg3YfpjiUnpAkCrwkIX6m94ug=
X-Received: by 2002:a05:620a:1720:b0:920:56af:cef2 with SMTP id
 af79cd13be357-9293af9a8e7mr225785685a.25.1782382047433; Thu, 25 Jun 2026
 03:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623024237.45990-1-qi.zheng@linux.dev> <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev> <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev> <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev> <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
 <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
In-Reply-To: <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 25 Jun 2026 18:07:15 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zwyaOtNkk8Xgqc3rNNE23XbU-kCB8oULqdGhpMERPsug@mail.gmail.com>
X-Gm-Features: AVVi8Cds3hyjYY1EEWV4vTH8VzylNNkIBPvgwWgSkKxNrZ0vwSNhmCzbjB5L9p8
Message-ID: <CAGsJ_4zwyaOtNkk8Xgqc3rNNE23XbU-kCB8oULqdGhpMERPsug@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg reparenting
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	kasong@tencent.com, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, 
	muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, 
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268327-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:harry@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[baohua@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA916C47DA

On Thu, Jun 25, 2026 at 2:11=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:

[...]
> >>
> >> Does this make sense?
> >
> > Yes, looks good to me!
>
> OK, this sync method makes more sense as it doesn't require adding a
> new lrugen->reparente. I'll go with this method and update v3.
>
> Hi Barry and Baolin, what do you think? Since the sync method has been
> changed, I will temporarily drop your previous Reviewed-by tags in v3. ;)

Feel free to proceed with the new version and drop my tag :-)

Best Regards
Barry

