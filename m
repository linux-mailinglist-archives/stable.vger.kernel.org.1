Return-Path: <stable+bounces-249740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAc7LEcrDWo2uAUAu9opvQ
	(envelope-from <stable+bounces-249740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:32:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67779587452
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 188A63095B2E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBA364E89;
	Wed, 20 May 2026 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eaqu5VLo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A63363C59
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247834; cv=pass; b=Al5K9NCKX5IB/5PlfeSxUdmOefLEgmtgtN5BvCOBCb/CkDy4euSeGmsI7/6n+3Obsa8W/3x47YH8chM+EJCR6y9jw59nHpGVKzVbhBvMHbcZ51h2ou83WtMeiQ+TI4cMG2K2s+O3UXlpUxJdbY0/46DXqM9+Ed7c6FL9M9qiZxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247834; c=relaxed/simple;
	bh=XlvntvFLAZ/gmagOYtupDAd9TDvKhbdbJAmnyBBol4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMtTacMQEPTk1fegyR8b/ixk+u56lZ+iBEnnlna+62r5tbzkv3wXOA8R44s1nZ2ijE/672fGQuImPu4AzPQRquwqaBJcUtrxMBVE7UYXY9kCmSKHM3BpAQBaRDsptK+NNKS81VH5eidVQe2/liTIHU7yqrRpOnly5HBQV/UWBvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eaqu5VLo; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso856903466b.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 20:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779247831; cv=none;
        d=google.com; s=arc-20240605;
        b=iZf9+TYwCnsSrP2FcC4Dddvj15TDmUX9PsW1iZaDIOndzRWyKUSdRxOS9jbVnhGM5+
         D3ut6ho9qS8heYQOEhZUO8ZhAIJm5Aw/6SrJOY/IqjR6tiw0PgCgHaU19BLNvk6kljmt
         znU7iha0G4EYJ+uvKeSl6Fk5sgZh1ykfbWRM+P1aXHEGYmEDvDLmIHtvcqmysdx/vGA6
         7vEF856vZMpwSWktaPzr2BOV12cI2aWUYk5FAorSH2xqhT4xvoeKjrfbe7xd4xu8/7xC
         Cdt8NXawOqNanAeql3NF5TXtEv5oo0l6YqNXc/6ns1E7R3tDyKKQQJFENOiQJ7OR7nP2
         IjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8SIgBJvxx3sBqW2VIs6dSHbO8RZ+0pmRwfw/q7lB8zU=;
        fh=3OGY498V6FxpdfGV2MowDJs8ZuapSmKrwPt2LZWaY1k=;
        b=AIsYKWzaXXbKhtnlRHD/PjAV4bRmtiYEW75SdOtbrnDSay84LHahFX1WSRjc2L6L6g
         zyWIdlUoU2Ev7g3lyK3gu2FBLj4Ob7jovrWi8kXiM7raxes0p0WJfMWFAMFnEEw/qwsV
         BPIkg9fTaPQNd4Kf6Qesn42C3UnAg4OYcNLIq1rLb3/5/RI0/4SnRkx+BtD+HaX2YjUB
         E6Qi2r/E1q5+eAe9GBwQaIoISqtD37jmYd1RH7iagQaW2Aa66dd3gpqaUYH1WPZZUIzk
         otzbGK1HC70Bj/A5eR1+ShS/QdtvG24wbO91YBNi2nafxLG+RHpjHLQa1/9DdvqLyQ24
         jvkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247831; x=1779852631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SIgBJvxx3sBqW2VIs6dSHbO8RZ+0pmRwfw/q7lB8zU=;
        b=Eaqu5VLo/DDm7j35xJKYKs26y1mCyaGKJHTJULRIsAgjJkjAmZ6x5QOSEOZsXpV7Pd
         y/bndF8ofkIl9h2g+JhZ2Fb5XApxErC4croacSpdvu36op4/TE8KrMKbvTcH3C1RwS2B
         RkMFT6U0cQpIKBc4kuzOqvwEt3IaudAx71hVBNj7FHvK/ZP3mPmBoW+l4LcQJ6sHXzjS
         8PGMEGK/2ZiNZKWDfnEcMgX+UOC3e5wDBCoG9lmBe0vS6+DfHI6Cb12c3Y+uSSg9pW0A
         A9P/t+vReoM9YB4CgIA7Abyqv/qRHxHj4IyshDQhQNcLEgLLbVDtgMCDeOTqD2wXZcNY
         OGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247831; x=1779852631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SIgBJvxx3sBqW2VIs6dSHbO8RZ+0pmRwfw/q7lB8zU=;
        b=fSddeJbQcYzX2JEaDED6vjK6fIqhudA++aBa8IJq6nQP2W4K0Zc0qHP6wq+QEndyLY
         xqsziYlyM9QJUvOcQ7m/6KNA1cwmBJd7xbpb1As/KsAakI5koqBugxOTYb6xpKbkYU4a
         Lw1H2Ku1l6UWrLN8jw9d6OaYWmXUtT8sRrhlynIdS3SCzUZcEnVPLRyHytciEh568MC0
         0XRka/CL2TR+a6iDTR8X8A3Km+XpxCbIgLFbpdpv5D91l8LWtASYB5tzitpvfKGndv6D
         7V/1ViyPXi953bWVCX1innbV47X0RFYyEtJufWwAzdK6h0Mas+aFWXX2iN6Q4xKWflRF
         kSjA==
X-Forwarded-Encrypted: i=1; AFNElJ9I6T/yYOwd5vfsnoqra57BGD4D8+rdy/dcMpigJQhURZ2m3wrMc0XryL6PxGF9dT7gSMyxyCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb8U0PG6EWEOBHUfZj/2lB8bmZyQJRD9i0M5omZouFNJUGL4n
	sV95IUaCABE0erwVdfAJLjRMaCDVcQ05tSXC8iWQZXc7gt12QEo3Moq/26nwHxIyxSbEAul9L6f
	ya1fCyN4s8BCyt8lgdvVVpLNRqmnsSoQ=
X-Gm-Gg: Acq92OEp4EgQbyFjh5Rwg3tBcexjoM7CufXoUIaj2gBL4c8pmJLqoOBMk7IdJqk6meL
	c3IteO9IpFMfYvHCO3mCVjoMeTv84ByEpCk5St8iJN/mTBfdaTSmeJT7ZvVs79+I6my4Fda3z3D
	DHHje7u3rKqpN7l9ZfsO64l2pAdF+bE65UoYJlmqcaM+THPwG7pVZb/dDVgse6aHDnujbY+z6eY
	+Y9hchYVU5SBaw8BEemZib3b4DgEzi6STviZy/ix2rLcgrTcS3b3wLzLg/aBlvYFyidv4FFP+Ub
	IzdXFos=
X-Received: by 2002:a17:906:6185:b0:bd4:f440:ba71 with SMTP id
 a640c23a62f3a-bd5177dd06dmr1203142766b.19.1779247830925; Tue, 19 May 2026
 20:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com> <206188f9-5642-4348-9fa1-c48f9a890640@linux.dev>
In-Reply-To: <206188f9-5642-4348-9fa1-c48f9a890640@linux.dev>
From: Han Guidong <2045gemini@gmail.com>
Date: Wed, 20 May 2026 11:29:54 +0800
X-Gm-Features: AVHnY4IG0C9s7OF73ggcyerk0wqu3oyQgPB5odeWhoxjVWfBwC-fa9GPTMKRXFc
Message-ID: <CAOPYjvYLf=VPTdm4EzmCQ4a6F8QeVO7JT+2YTH1XXD+9N2Uh3g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Zhang Cen <rollkingzzc@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249740-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2045gemini@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 67779587452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:13=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
>
> On 5/17/26 8:16 PM, Zhang Cen wrote:
> > SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
> > with this bit set are copied before data/data_end are exposed to SK_MSG
> > BPF programs for direct packet access.
> >
> > bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite
> > the sk_msg scatterlist ring by collapsing, splitting and shifting
> > entries. These operations move msg->sg.data[] entries, but the parallel
> > copy bitmap can be left behind or stale in slots that no longer contain
> > the original entry. A copied entry can therefore later occupy a slot wh=
ose
> > copy bit is clear and be exposed as directly writable packet data.
> >
> > Keep msg->sg.copy synchronized with scatterlist entry moves, preserve t=
he
> > copy bit when an entry is split, clear it when a helper replaces an ent=
ry
> > with a private page, and clear every slot vacated by pull-data
> > compaction.
> >
> > Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> > Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> > Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Han Guidong <2045gemini@gmail.com>
> > Signed-off-by: Han Guidong <2045gemini@gmail.com>
> > Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> > ---
> > v2:
> > Sashiko-bot pointed out that bpf_msg_pull_data() could leave stale copy
> > bits on collapsed tail entries.
> >
> > Clear msg->sg.copy for every entry consumed by bpf_msg_pull_data()
> > before compacting the scatterlist ring.
> >
> > While researching recent page cache bugs, we discovered this bug.
> > We confirmed it allows overwriting the page cache of read-only files
> > via splice(). We haven't attempted to write an exploit, but the
> > corruption primitive is verified. PoC available upon request.
> > Recommend fixing ASAP.
>
> I think only "splice() + KTLS + sockmap" is vulnerable, right ?
>
> I digded a lot but didn't find any other combo.
>
> Actually the normal TCP/UDP  with splice() will not go through sockmap
> (unsupported yet)

Hi Jiayuan,

Thanks for digging into this. Yes, our PoC exactly relies on the
splice() + KTLS + sockmap combo.

We haven't exhaustively audited all other potential paths, so we can't
say for sure if it's the absolutely only vulnerable combination, but
it is indeed the one we used and verified.

Thanks.

