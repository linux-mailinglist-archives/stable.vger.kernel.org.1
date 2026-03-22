Return-Path: <stable+bounces-227845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aSe+BcQbwGlODwQAu9opvQ
	(envelope-from <stable+bounces-227845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:41:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5971D2EA08D
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF87B300AB1D
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219DD3644CF;
	Sun, 22 Mar 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c053kx1v"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4B347C6
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197695; cv=pass; b=gIrgHn/SiMQevwrVjDPa2ZA8LYsk4th0eA7RYZhGwlkthKCing75GlXN6uqtZ428PtmVDlHZLBzMyxlYxbHSAumD+jLgSyJhA4iRx3XASvyi9V/vW+qM7H4sRk/nbCHEQK0U/4DdXZHTe42NcyqSDePs9/XQiDDi/ljlNLJ4kj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197695; c=relaxed/simple;
	bh=9KabN4smbTp+s5e1/XKAr1ODtoWZx8nVCeLUu8RT+3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9PfFY3b/0g5Tedgcw9TXNiqd+xHuJcqEwHpxy6fSZuaezP3ZiqQpeLOeU/dKYCWlptVmPo5ddkKpVPKuvQzHmYi6SCKQylabQ619GEY1iRD9LGiXMnabAufEOHSn149GUdeZbXHSbU+JsrKS3DNwQhKqg/JmELZ/1DHNiq7EwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c053kx1v; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-46704177508so1269196b6e.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 09:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774197693; cv=none;
        d=google.com; s=arc-20240605;
        b=LoM7SwP43Qy7U5/ja2QuHMKvk/6ODm09Y/y1pq9VnDgTJc4ui9Rbi474u1SPaEg47o
         g+CpgyLri37ptm1Q4tIAaBXu/HE2S2I+1JNXfWkaVXBV/IvWCwNp2142BzlELIaSV1s4
         NqaWjioxwS6LuWAHEDzLgvYOa/OoDNxApFZhYZHXtLwSI5kk88yKNu8nYENCK1PNALQ5
         GOokahq9FfuH+5bGf78M9P4piMz1mOzTx4s7Hzl0uaj1xJsY22Bdeasr8xq8p4Nxf0a2
         cSMedmoKkL8h7WWn+p/KE80gIObtXKaqGftyGLORftBy8JwyTYeh2JZcaQOzxxRaTFVb
         oeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UygfMtOJ6WycYibEscp9BcqIlnDy0mhESfEMXmTarYc=;
        fh=LNp3JVfgIdo88HQSKOfbyO4NMQtQ5H5ghw0FW5tKd6A=;
        b=Yez8UXOWqALCFXLUEsEzD0QT2x25VBgBv7+wDuaAYORAv9HIWQ7R9HMGnMlbZQ/GjR
         YCbv4A+921ke7EyHTzND+EzTnkQY6ZSNLfokwbqfdUoJTN9LxjGZYc8DIduoS6IP4egA
         E4obron5U2XGg6t1Ink+uDpzB+0APKk2uW1LdMvjGDg9ysqxh9x8nZaNy1DI5+DUpca2
         dh3Hm/2rI0WfrEeYSwqejSd5SSh/5lkzBLLA1GyfY/BqMJur1B/MKK9YPpmlO+ecqWih
         mW9UbITnILZ1Nvogpq/5WoCXsPHQgm6bttpnCWUK6mPIigZB7y6C/JbNkoj0aGgIatyD
         X3+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197693; x=1774802493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UygfMtOJ6WycYibEscp9BcqIlnDy0mhESfEMXmTarYc=;
        b=c053kx1vriYJfXMNl4qSO+7mbmkdnUwl9mZ1cKS5SuHwQsZFJue5JJUVSuZcvtmCRD
         rXg+W4yolueY2wj+4nx4K8DaGUllZGhQq9/65rSuOUB/vK2az6QFq2wWQymNJLSMJQhE
         PcK2BLw2lp9N5dcW9r3ZrpCdoF7/V+1Xc0xgCpfEIJ3aoyNSsKZwABhEB5P0YaDNWsKe
         jvCGzlA6HpKdhAN9fYAY3kJQxqZ7qQVe+di/YtnckTwhIHMChoa0FEdlUlTUKktfcu1Z
         RjRjdEly4fN7gTrtjY+WZusULH5OzXBiKVZJhA3GXAdAHcnf7ZxvGXxuh5YSw0/3EhW3
         TiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197693; x=1774802493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UygfMtOJ6WycYibEscp9BcqIlnDy0mhESfEMXmTarYc=;
        b=S7V5lJP1DG46hbxP+jj8HTmO9LUd5YampfAibCsjvs4E3N9x2u9J5K2yEHnFRtOWKe
         i2i5DU8w0SFTb4/gAY/XbUbJ5XGvlURahs06c6Uas23fDg6LRveX8oq+u6JUxyZVUV7C
         RpDKIiw7dhcK2g2hvJY5lJmRFiBiH7kob+OvEbFpa4OLFA/rFOoGuVZ2YNK71wtAP0bh
         DMtD9xQekp/Bhg/1w0sQk6B9iEk2BymwOu8uY7S5Nkkk1X9rhOhrzfHZ8o9PYqVzLYwV
         fNyKtvm3zsTdmHmCJVYapiUINgjHSpA40FNBR8HN2Ui55pMi8PuarcsX6mq4mC0jQKbw
         i7cw==
X-Forwarded-Encrypted: i=1; AJvYcCV7qmmrAzb12Z0PVNRecn/6Ve6ZldCDgxesQ4uRrs7TUfcnbKyb9FcwcifRVZlgtlBSFQDDgpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJJJbWHiTapau8sF+a2zn7baNOZcazvyJcC9SjFOL+Jq+GG3T
	CcVWc+0O7mVbG9ccGY8o19zQXx4ZHP0WE3MhrZlNHn5eF2bxlx2SFmkkKpy/Qnt3sSp1rEGy6Dr
	RiS4o6Kuu/5G5YhP/KkYKsaGCsc2IHN8r47HxAbk=
X-Gm-Gg: ATEYQzxNkpBSHiUTHQyhtDoZefeYTyaG8kIPwPHpCA0DeY8Pk5+4TXWYLKQA+T2Ou/s
	yzegDbSV+MvWtxDm+Z7XuBgMbNBlmT1yfHCRWCLMoUMEnA/5eJ6sBvbCXW7+3795sgSUCt6Dx/4
	5Rko0Ex6ccWG7Q0pIHzLmImledk2HSDUEkbgwMp92rLYGRpsh91BqS31aof8cdZr5VdgFsOes+Q
	84/6e+RkmM0edtLblib1YNWzTnxGnQr2yYCSv4iqkmQ+zOLseDTuzFHXti2Pjez2lW83SJu7xOE
	NxgWMxIaw9AB4raDAUnkGYedMmROHbLB8MU2TQ==
X-Received: by 2002:a05:6870:b0c9:b0:417:5a8c:feba with SMTP id
 586e51a60fabf-41c10f8df21mr6204359fac.12.1774197693494; Sun, 22 Mar 2026
 09:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322080142.5834-1-devnexen@gmail.com> <20260322092043.2c411821c2b883ba86c7cbd9@linux-foundation.org>
In-Reply-To: <20260322092043.2c411821c2b883ba86c7cbd9@linux-foundation.org>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 22 Mar 2026 16:41:21 +0000
X-Gm-Features: AaiRm50KUQZhn5mijKvExU03fMI6RXQO2XfIUx7DNkx_z4S0nSXFWK1lyb8dVdU
Message-ID: <CA+XhMqyy82d9PmKVBgjsbod4vwris-3+prOoVwJatYqqJf4nXw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: fix obj_cgroup leak in mem_cgroup_css_online()
 error path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227845-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5971D2EA08D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Sun, 22 Mar 2026 at 16:20, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 22 Mar 2026 08:01:42 +0000 David Carlier <devnexen@gmail.com> wrote:
>
> > When obj_cgroup_alloc() fails partway through the NUMA node loop in
> > mem_cgroup_css_online(), the free_objcg error path drops the extra
> > reference held by pn->orig_objcg but never kills the initial percpu_ref
> > from obj_cgroup_alloc() stored in pn->objcg.
> >
> > Since css_offline is never called when css_online fails,
> > memcg_reparent_objcgs() never runs, so the percpu_ref_kill() that
> > normally drops this initial reference never executes. The obj_cgroup and
> > its per-cpu ref allocations are leaked.
> >
> > Add the missing percpu_ref_kill() in the error path, matching the normal
> > teardown sequence in memcg_reparent_objcgs().
> >
>
> Thanks.  Some questions from the AI reviewbot:
>         https://sashiko.dev/#/patchset/20260322080142.5834-1-devnexen@gmail.com

On the first point - you're right, the pointer should be cleared
before
  killing the percpu_ref. The normal teardown in
__memcg_reparent_objcgs()
  uses rcu_replace_pointer(pn->objcg, NULL, true) before
percpu_ref_kill(),
  and we should match that here to prevent RCU readers from observing
a
  dying objcg. I'll send a v2 using rcu_replace_pointer() instead of
  rcu_dereference_protected().

  On the second point - the pn->orig_objcg = NULL and the comment are
  pre-existing code, not introduced by this patch. The free_objcg
error
  path already guards with if (pn && pn->orig_objcg). As for
  __mem_cgroup_free() not checking pn for NULL, that path is only reachable
  after mem_cgroup_alloc() succeeded, which guarantees all nodeinfo
was
  allocated, so pn is never NULL there. That said, adding a defensive
check
  there could be a nice hardening improvement as a follow-up patch.

Kind regards.

