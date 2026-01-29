Return-Path: <stable+bounces-212811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KIkDhOxe2mSHwIAu9opvQ
	(envelope-from <stable+bounces-212811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 20:12:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E3B3D43
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D23301BCF6
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3A3128AE;
	Thu, 29 Jan 2026 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5gHoOdG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0B2F745B
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713924; cv=pass; b=VvT1PnlE8CwpiBkZ80qY5ypWNeXej8sPzG5ORy0uNiLOR1ICcssDhrAWiq3DNh4UbZhOvB7inoQi5xQpD6Pnzf529YH1vNpj8acgKS+kgHuynSQwyK5L7Pffzt6/p3xMOkw/vMn5jGEw1xCVSr2TUJ+l5rlu9/rjHO0wisypq6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713924; c=relaxed/simple;
	bh=yc52hjGkzZ5Tm2VKtjUQwD03ntP/HPo+QsVMLQpBmME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hIrBMk78xiMfEBzr1ALnj6UdVT9+W3qzgBDlG3cQB0LnWU/GgJrYAbLv3xVtgoLBE1LB0BV37X6EnMswGXfI61suPrVWJXbMMzgtrI748DzABNACIjwwNxmQwVTGmu5wkKVtDc4VOZJ+FU81gO5YQkvZxTN9xd9tGxgkThV0Z6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5gHoOdG; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so5115e9.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 11:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769713921; cv=none;
        d=google.com; s=arc-20240605;
        b=XQ2Lph52v+WEcpiciatf7DOzVjp1qR4NPg27FltDHmqp4Adgs2OlFO0ZOFXAi3fdiD
         KtEN5T3OLd8bu/u2C5vcsE+MxkQCjnAkriqUrYKMWMNIq/GmqLDyei5IHbIulk5KcLwb
         AC9f+VINX1NUuHD0dytxxWeCKfJFTuxRcg1Q3w5GYgWVBW9Mg64ALxCJ5C0EuuE88S2e
         /6UW15OPhIiL6AAXfJYuHMU6HGc70NAwPFVzZPqiINwXbh30BhSTOsw86fQBczRp3c22
         6kLxaEJM1nykasAk8PxNFo2/o61zqvux8KbyDbBIwYhEr+quQQ6y+6tKmcD6yi/Rte8v
         TpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pq8IaKrmDbwcHKyI5wAzPjbWS8D/qtr9VjRJFvUYIfU=;
        fh=riOosLZbKd0eB1TL0R0FHdXJszfje7PzEYasgIUj2Js=;
        b=BEEfsMDjDOrH4EV7hwiAuemnyKqCCwLdzw17gwPi58mhAxBtREFZUTaq4VQIhsj9n8
         /HpPvLF1hqbXoJVcjB/nGpytXcGBsae1D5WFbvyDeH1o5L1B1b+K3y8EDSUaCc22xWEB
         P2mTlMBygjTjkGxOVDUBaqYwn/1+ApGIqKrFZ7zQ2g6bM1TjjxHG5WAQy42naXnk6ZKq
         WKVE3Bo8Ks27DQxkbm0lso20FqQCkG2tBDXbbk/XKbZXZSx9cBkrS7LO/Hu4T9FyOkFt
         dfS3KU5KF3yR4Zicf4mEYEoRdvnlKxbDolxE3cxgdS7H3PS7KdRfeQ22uGEra+tpU7AY
         TR5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769713921; x=1770318721; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq8IaKrmDbwcHKyI5wAzPjbWS8D/qtr9VjRJFvUYIfU=;
        b=u5gHoOdGQv/t9W24Pb3QXnGgJ5YHbNyy1S7OQI2Iv8cffoxBuKI5Lc/Y/5rAIFP8Uu
         lDNPGYznHVwPJsaNZwFWIQie+wdmaC0f167pQaqAzG0FOcxYXgeGIXdGY/vu8r+ZePKW
         7348yNRuEQ0B/YDMsxc/fNR2+l96GOMRss+TgrNFUOi9/mI14mPeKYNU1Ik9Vd2g74ym
         mmRK19ToQr5Mp0vkH4VtQQRro77tI77cvfBdgDCRUwMwxrJBj1WB+OskjM7moF/jlaCi
         wzSm0sPB4NSGBw4/JQCT2FCEN0BqpN/gi7/WOtRB6zg9wxjelrLXkiAVGAPpgm8JGW0j
         jYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769713921; x=1770318721;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq8IaKrmDbwcHKyI5wAzPjbWS8D/qtr9VjRJFvUYIfU=;
        b=GoNcUP7Hlcl8RVx1ThRs4Av6JeVMWXUn3/ufaEPSsE3zf9Te2g5KFdd7hN6pAIe50f
         VOYL+t33If/8gprgX+jFHQ27/UFVoofS4dOGUtAvTS/XI5ZmLVzrSqc6t/fRV0lXUIY7
         hrATKQalZII7+k6vxTDKIaNzsf+e/sJAjGY7MCjjRa78ak/hUN+l840ORMC2ZIXKslUn
         o8GlaqQmpK+t2wGXAsO62bSItTxM4vtim1jO16NHej/0CNjUHGHMzkwdlPoPum7NcrEu
         hn5MbF5DOJv1+0GGdO5MTPXovrXtavFczZkxnorxP42TQUWXzgc0pjO9WXO4zswNv7vy
         M4Ng==
X-Gm-Message-State: AOJu0YyPDQmrmmA1yAb1y5+cnmhRQdpopU2V0KnQyXW4qSki86Uw8AyZ
	2kZ8fkJZlDiH7j7CcOVeXkLEV+PvtOVOc1aqIb5kC9mHfl7YkZCTMELWdof0xTTS3DGvWWbpIQP
	z7OaQ+FrmRsw63sHpyRHwwK8KnZnlPL2fbJ2kjKjwXxACOshcKa8h69QI2j0=
X-Gm-Gg: AZuq6aJ4DgsRpYxLee0HzCxPdyE5DGLIPvSfMlAQdwW0QCOX1EzMjXHM/wgfklCgIta
	ZYk1BeGNmYWGtZxSiXilQA2l4yoFKlULXn4jxdJ4zbYtOkxmixIZC+KEoS8rg6UCJLfZfWn57qX
	JPmK1v+mY1xz3ysPdRTRbD3jkuFZ/i/qHXcE6jlm7Nxr5CMCD2CS2zv8pUuy80vMANCIcbTmq1p
	TaXYY+iXBFWpQa0zFXq0/NLNfqs1y/Fh0f6u40d3/h6R6RKbBBTcPDwbkCZhQ84y+XoLJynUMCf
	waOioPup01sg4o2kkMNjSM3mUpj0OBsAF5TMT5ZBUIJ1vKynpsa2ITp1Kg==
X-Received: by 2002:a05:600c:4a21:b0:47e:d98a:b8f8 with SMTP id
 5b1f17b1804b1-482db4b95d0mr22465e9.8.1769713920885; Thu, 29 Jan 2026 11:12:00
 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129191034.3181412-1-tjmercier@google.com>
In-Reply-To: <20260129191034.3181412-1-tjmercier@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 29 Jan 2026 11:11:48 -0800
X-Gm-Features: AZwV_Qh3f5iIw7mra1yd2db15YJhi7znzQ9dMp1rY2req_9Nav5G0jgS4pMiMy8
Message-ID: <CABdmKX3rhV-Kn7fMg689Yo2M3f88xS5BxK+5R6G0-rEx9thBOA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
To: stable@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, cgroups@vger.kernel.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212811-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 973E3B3D43
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:10=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> This fix patch is not upstream, and is applicable only to kernels 6.10
> (where the cgroup_rstat_lock tracepoint was added) through 6.15 after
> which commit 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> subsystem") reordered cgroup_rstat_flush as part of a new feature
> addition and inadvertently fixed this UAF.

I am proposing we apply this one-off patch to stable rather than
backporting 5da3bfa029d6 ("cgroup: use separate rstat trees for each
subsystem") and its fixes to 6.12.y.

Cgroups folks, please let me know your thoughts.

>  kernel/cgroup/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index b8cde3d1cb7b..cb756ee15b6f 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5481,9 +5481,9 @@ static void css_free_rwork_fn(struct work_struct *w=
ork)
>                          * children.
>                          */
>                         cgroup_put(cgroup_parent(cgrp));
> -                       kernfs_put(cgrp->kn);
>                         psi_cgroup_free(cgrp);
>                         cgroup_rstat_exit(cgrp);
> +                       kernfs_put(cgrp->kn);
>                         kfree(cgrp);
>                 } else {
>                         /*
>
> base-commit: abf529abd660d8ccad46dd8c8f20e93db6134f5f
> --
> 2.53.0.rc1.225.gd81095ad13-goog
>

