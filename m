Return-Path: <stable+bounces-225692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O9dO9JkuGlOdQEAu9opvQ
	(envelope-from <stable+bounces-225692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:15:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7762A01A0
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0E88301779D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E93EE1C5;
	Mon, 16 Mar 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVDEnNlo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F113EE1C8
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692108; cv=pass; b=NwzkLw4c68qafrd94O/EbgiDYnZ7lHZq89E0p2plJU25eaP5Ngpz9RTwgt2OddZ/ylId4+k934I8X7o7/5qtQTISGiBr3AF1bgfXZ+rjKWx7ucJcqYtxj7Fzsoi0AzJufm2W7+XfKaPA2ghJtVoY4nDCMeA3OCpaIsw3Tc62ShU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692108; c=relaxed/simple;
	bh=8niDkbFsuiT/+hqsTJO6w83pdohKFBF4kUT+Kf+V3LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B394FgTOUqkpBSCZyrjie5hInhhWZbSxX7u7vlgx72PQCdUlUgq8ecVooqoHw3TUqqNiGkdO8gAmlgoKMzAl1x/3qzzp7uxgMyuzEjR6RVgN4nE/iESg0d6hgPpG/bw1ZBjrJTh/fVnINnvBwhP3eBUXm5QI3Mriom7Z2oQAkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVDEnNlo; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso44402525e9.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692105; cv=none;
        d=google.com; s=arc-20240605;
        b=hdYEX0gq/a20XxZLbvoyJQiYs2PmX9JLz7klUJAY1tLM7vwA0S1e1w850iRlS9vay9
         8rn06nRYXpm4+sY+9dMrWlgScMe//Deh1QBtBq97paCyFqecCaLDxLJ/wzFBcsnf9ZER
         DmXT33IKszlCRUXtEb5MD79BL8K1qZhMOPcOrxu8KWEbezz9uV5oyRSAGA7VSeoiVnaX
         RDnrEwNXkhXU29qdGeEG0NYFCMGDTBpquRqJXJroJwP9vs5jaz+i1R5Z5W2twl6eza7R
         iPV33ras8JISpyi2IUblt1v+a5HwDT6mp5TxeU9VtMBVl/c//WG/Jo2k3+uqdLi0syMd
         FKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CYoN8btAUIlvILFgoOAtc9iU/qNjitR/kbbHyyiUI+c=;
        fh=2bRH+onBcZXYiXdutTy3/PIsKYmwgP4rr3q1gQfuBK8=;
        b=Xo8J9qYvogW8P4w0vcar0t4JI4VT90ioRBUltLee38s4ixRpQEkGBhuM1BzsVpSus1
         LJ6pU3nlgvKUT3rD3wstTdtRVUX6pXZITJIrYRTPtwRPTYKSobJRPmidBA24ybHDPzP9
         RquKS5tn6sFWlfCp+FdwRztcowoo4+0SHLKw1DXxz7b4kb+QBoVchJkW3UUaHzNBNi3i
         Ae9zFdXPxH6ieoX0YozDteuanWEhfUKczBMo2ORpMH9ogYb9zoMp5UgkNPoDlDYcozew
         xavsfoGB3MYvI0zd7wWpkqHfSyIg/8cKLz6O/HaAuu2Y3P54az1GWEG9kzSnVHNR7XMw
         Cl6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773692105; x=1774296905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYoN8btAUIlvILFgoOAtc9iU/qNjitR/kbbHyyiUI+c=;
        b=fVDEnNloFqOdz29Kk0eJSkXisqbgtBhtZ1GCHYD+Lsab5Q8Q2p0xKTAONLOEZa+5tm
         wQag7wou7pfvRJn4tYIs6Uy8qbcg5AvzBDQXaAYFZMTHJTEp+3IpaviYtCRza5zaye0k
         /5B15r1I68hI2oyeyW0Hhl8YzFZoN7X2/QJSgweIRh5Xai38JjELR5y9/oShn1IZhFyG
         eZAuUInSIKlv8KGwY8xLpurNSatih9Iqm2CkbvsmXSg0Gp/r5fqL+zBvvkfCVd1nxC55
         EkLxKb9nxySVeGvdm31dqDrsS6xk56EpYk3nHQoxEy4nJi38t4oSRqYpAPgu9GwT69y8
         Qgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692105; x=1774296905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYoN8btAUIlvILFgoOAtc9iU/qNjitR/kbbHyyiUI+c=;
        b=aluIbNtX4TLDETa3gNQYQL82mssEVAsvYkl/0X1Y2ijNccVr5GusXwjsEmGAEXMKVK
         81nGrdg4Ongd7/s8qU/Fq4+FUDkA2pkxrSsIwS7vouRCN3mkCUgLHChzQ8QnsB3ZW6sJ
         xesy03SS3FsBWV76C1GV0TW3cqTjuhmABQ9B/lQsu49jOkF4Nr9x4m9aH59hNWz4ovoU
         MT+q0rq+Xiy7VYon80OhhY3HVC3ygzIdNrxO9qqNpYmMODQmjuHtN+FOnMlGikPKwbKK
         L5DkRe6G9ZP+VoLQjegiIGZB4cqw3I5fbhiocNyWL5vdoZXe4QBtKos0aAYHAgCuTxdh
         Jakg==
X-Forwarded-Encrypted: i=1; AJvYcCXQBJ/YNQDArKqgpdiFyawpoyM47RUT2lotEhJ4fRU9BgrGqc6I4apElA5Uws7cX/2k9TaCo3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8SOSUR2WzXN5rkq57vVGzMqBfpuDFj3mY84dvtDsSifzTCGX
	7HEVs8eiPjpMjDaXjHuYFs5yM7e+zlxW09LPwhWjSvcl23SRKKb+5HdT+KqFkaapHwSkZfRuMQX
	+v8ke32i30hZ4raIDIUsWN5Lw33cdpF3u0Px7ELc=
X-Gm-Gg: ATEYQzx9G6tsUlfghlWS/iqqN1ITjRjtSPr3OXnuu72IpdytYky+wiCegsfesT74XK9
	wYanD7OFK5dD4UpYOWMsK1dRGKBitzl4ZNZFBTqir8Su4MqQAxi7a3CxUL+TL13kN+/IdiXAKSU
	2dAF1bHavs8BHXAkG4o5LQKAGQaVXLMO+sCLNyjthu4bTn2mVsx1dV2sWU/52khm3v5b8lGkkLx
	SGwnd7TcPe9exkXrGiC91pqdotiv06vs6CKdrqdA50NBLdCF6Y7vEvdHrECaXdZpT1Z2v7Zsytw
	0BNw5rGEEbhLnJ9vDX1lqJx0pIn7qr8=
X-Received: by 2002:a05:600c:1395:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4855670b72fmr237585685e9.27.1773692104868; Mon, 16 Mar 2026
 13:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315232500.251088-1-CFSworks@gmail.com> <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
In-Reply-To: <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 16 Mar 2026 13:14:53 -0700
X-Gm-Features: AaiRm51dpPBipZZWQanwptiEoyoB_MXYhvmujHnwSw7-J6BK8JmDh4pDIUmVfgQ
Message-ID: <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,dubeyko.com,vger.kernel.org,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC7762A01A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:44=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Sun, 2026-03-15 at 16:25 -0700, Sam Edwards wrote:
> > move_dirty_folio_in_page_array() may fail if the file is encrypted, the
> > dirty folio is not the first in the batch, and it fails to allocate a
> > bounce buffer to hold the ciphertext. When that happens,
> > ceph_process_folio_batch() simply redirties the folio and flushes the
> > current batch -- it can retry that folio in a future batch.
> >
>
> How this issue can be reproduced? Do you have a reproduction script or an=
ything
> like this?

Good day Slava,

Is this question about the preceding paragraph? If so: that paragraph
is just describing current (and intended) behavior, not an issue.

If this is just a general question about the patch, then I don't know
of a way to trigger the issue in a short timeframe, but something like
this ought to work:
1. Create a reasonably-sized (e.g. 4GiB) fscrypt-protected file in CephFS
2. Put the CephFS client system under heavy memory pressure, so that
bounce page allocation is more likely to fail
3. Repeatedly write to the file in a 4KiB-written/4KiB-skipped
pattern, starting over upon getting to the end of the file
4. Wait for the system to panic, gradually ramping up the memory
pressure until it does

I run a workload that performs fairly random I/O atop CephFS+fscrypt.
Before this patch, I'd get a panic after about a day. After this
patch, I've been running for 4+ days without this particular issue
reappearing.

> > However, if this failed folio is not contiguous with the last folio tha=
t
> > did make it into the batch, then ceph_process_folio_batch() has already
> > incremented `ceph_wbc->num_ops`; because it doesn't follow through and
> > add the discontiguous folio to the array, ceph_submit_write() -- which
> > expects that `ceph_wbc->num_ops` accurately reflects the number of
> > contiguous ranges (and therefore the required number of "write extent"
> > ops) in the writeback -- will panic the kernel:
> >
> >     BUG_ON(ceph_wbc->op_idx + 1 !=3D req->r_num_ops);
>
> I don't quite follow. We decrement ceph_wbc->num_ops but BUG_ON() operate=
s by
> req->r_num_ops. How req->r_num_ops receives the value of ceph_wbc->num_op=
s?

ceph_submit_write() passes ceph_wbc->num_ops to ceph_osdc_new_request()...

> We change ceph_wbc->num_ops, ceph_wbc->offset, and ceph_wbc->len here:
>
>                 } else if (!is_folio_index_contiguous(ceph_wbc, folio)) {
>                         if (is_num_ops_too_big(ceph_wbc)) {
>                                 folio_redirty_for_writepage(wbc, folio);
>                                 folio_unlock(folio);
>                                 break;
>                         }
>
>                         ceph_wbc->num_ops++;
>                         ceph_wbc->offset =3D (u64)folio_pos(folio);
>                         ceph_wbc->len =3D 0;
>                 }
>
> First of all, technically speaking, move_dirty_folio_in_page_array() can =
fail
> even if is_folio_index_contiguous() is positive. Do you mean that we don'=
t need
> to decrement the ceph_wbc->num_ops in such case?

Yes, exactly: as stated in the commit message, we only need to correct
the value "when move_dirty_folio_in_page_array() fails, but the folio
already started counting a new (i.e. still-empty) extent." The `len =3D=3D
0` test is checking for that new/still-empty condition.

> Secondly, do we need to correct ceph_wbc->offset?

No, we do not; the valid lifetime of offset/len ends when
ceph_process_folio_batch() returns. I'd even argue they don't belong
in ceph_wbc at all and should be local variables instead, but that's a
matter for a different patch.

Cheers,
Sam

