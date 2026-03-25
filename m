Return-Path: <stable+bounces-230262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBfuC2JPw2lGqAQAu9opvQ
	(envelope-from <stable+bounces-230262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 03:58:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684631EF78
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 03:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18F233058097
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F4829E117;
	Wed, 25 Mar 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpbOC1wT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA1283CBF
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407380; cv=pass; b=mK341JvhgpO7MOnoZU5/eYOHaCVQOymqn8GJFFdhfqJMjhmGi49EfUQ/iumOqPmOjDkT1n6ikfC3OCUv/UNF4pGY8grDOt1EkcaAexSWosbRoq4V2l6kELcVKa0S39y0RFDy4d6+iyVSTjjgjj+WYKp8CFDbuhf6zsRv77RYjcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407380; c=relaxed/simple;
	bh=+uPMDPPtiGZlDWZpdQ5piUM06engoMAUBApWm8b8a4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2nRMRcV9IFcl6T7K/8NMfbtz3BN4JQS2tiOawEcP0IXNI3h0PYT9kr6F6JyjH6u1UxT240A3j6tIwb40k/jBxUKmrlr4j3RZMjWg09mj+6UM6VMKudUay+iY96eHqrCGCSeqf/FRt7DciciLt4Yw1laBFfhwBv0oGE++1wD1EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpbOC1wT; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso3978063f8f.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774407377; cv=none;
        d=google.com; s=arc-20240605;
        b=gLkRHn3kq4P5irukxfW4/IBdOhSYoJb2CNLqoj4R5Xw7dD/zAgdzAV4yaJDtXK0OBz
         JQYeFP9UJDZ8hT+PocKMW1WCt9VS8I0+UTMACBE4RJ2SIaSCwc/FHSdUm3csCMqYOww0
         EXl5aLU2BsY9oDf89s+oiYFaSX6MELUZB3eka2R7ykgjg1K0Ca0fwKVsnifNZMxHeo+K
         I5nnXvJHZpkis+yaTIBVjLEww/Q3SVwjsW5AEaxj3MkQU/4eXsCIkm/CRAdjYGBr2LzO
         U0vYxm5XdErBSUOeOkXjl/T/UoaTVl+KubAJswWgC4S2toE7uUVkKoJYPYF7VOBnxpNv
         I6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8beg8RaijPeg8FFoZVPlIFnyuzA+pj3RPJBxTKpVis=;
        fh=//B1+oXoDxcyL42Jez7WJUTnKulJLF9i1XP7HMyEfW4=;
        b=kAjHVak7ukZb27fsKluKCWBAYQiWMLwLvwKVc4WT0EPVtuKFwh6qDgIbWJWOIQs+Sm
         Dbf7H2YMKyE+tB0eGuntl0IPTv1B6RX8lr9+rw3mvHuonZx+px30DJD3ATLQaZkOcs0M
         /5aDPx3qcHoD63VkqiT6B3TUG7WVhZV7MBAGoezR3sr0L9y942CKj9WXJLqnGzk9Ep/l
         4ozWOsP52sJ42qRrGooxAztiRvezC4NvEz1IwOtQwiYw6ZoDtClS4gen2PWVYfl4kvCU
         B0Ep33w7kyBeAGSVcAJsTiemeiCzSC7y4ahSlupgjisvfj1gAnxnYvcsQlka21RZjxyr
         hz7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774407377; x=1775012177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8beg8RaijPeg8FFoZVPlIFnyuzA+pj3RPJBxTKpVis=;
        b=HpbOC1wTwno7znp4XtV4JgJQq0YvB68QNRJzcsB8DwE56PwsssnLSQy/3ER20hRFby
         7aphxGoUNt/rYHrpJ8V7P4Mpmkc7quE8kqrC4TIBEsAPeegmZUekU8FMzxAklAXL2UAQ
         c+DoWp4PnsyajSlG4VX07Q3x/AgVtHyx5zN88JXjfYNvzRRoFasMvIEqViwJRr1IqxTi
         zy/o4ZjISc02UqB1rbIc9hsabrXa+cSklNF2ebtpbcDL3qcJy+P6BRjCtcucv+uQ8Ps/
         5oEwUjfN5jKSloLLM5SJmEZecA0EhzhRTPiw0G+6JHxgk+c+D/TFKqjkiLzvjffkPfBa
         LaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774407377; x=1775012177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8beg8RaijPeg8FFoZVPlIFnyuzA+pj3RPJBxTKpVis=;
        b=ob0fV8q5EYNHETgm8ikcd/1rUUlDUjRUgLPo7724uECB59NeWmmU4aR1W59r2dgrTC
         0f7QNYL+TAKQKTYr6qV+HpYG2vMlM19S24EtRz9fBgBzITO7dR5M8q2FzVK/IWeaIrcQ
         1c1QbASqWaDEc0r6NFAIJnl0/9IzQFyGh7og1D2Kfi5UK3qSEljla9fef2gqnxs/JKDH
         fH01stiWccWgz2drADNfvS7w9MkEXRsi0e5z5VHUCbKdzsSfT3cukkEns/D7o4eomtmG
         Vs6lzho0jHUMhL3TMmLfc0hlqrnx/f6mVqO4g8IKZ9+sCzlZJ6Wr00HbFK99HHcWkgM5
         5LZg==
X-Forwarded-Encrypted: i=1; AJvYcCXFpFQMQT0+ZRj8AMFwJpZu9B2FJ7Krp7iIzr9XxrPgHbxPyjhWdxhs+N8huqNfH9Msrd2rBqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhP8VlBq/dX1eMdAiUmJv1dgNjglMhst/o2hkBYl1PyAD/k8m
	iKCSzvVwJenbMo8+BIRk0iD5nLtINkX4E2slD59JwkB5PTf7uASlXlXB0XCdEDitKR4r6ccppcX
	uK/vfN+D1VRCe/eV2NfXaiP8kwdBbPX4=
X-Gm-Gg: ATEYQzy9zhd/rGuvzSnUQvh5V01ss+3rigLCBzoqSPZmHzu4wRdi+wtpsi7U0IzaK2x
	ET9BGgqhKdf1FMweqNVUf/wbS+wu5TJUHFT+ukDzHVHcSQzU05waZ/HwItvlMsnrTnaAn5ISjdc
	9QYhiEFL64JvrxbpMktaSSv266o6/y7CV+uPxQOAjFYjNQhy19hCSw4SsCzOVl2bqQ9PDbLYI5C
	b7F1K3OM2gk7CEMzmYpzQVGx1LPSj2XiraruSVyWP8Sy6QGHwIl9syyXAO7MrkqTU27QtLL1D6d
	Osg3XpSVDZFq/Mb1dg==
X-Received: by 2002:a5d:5d13:0:b0:439:b629:42d7 with SMTP id
 ffacd0b85a97d-43b88a0d06bmr2402635f8f.46.1774407376729; Tue, 24 Mar 2026
 19:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318023733.116789-1-CFSworks@gmail.com> <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
In-Reply-To: <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 24 Mar 2026 19:56:05 -0700
X-Gm-Features: AQROBzAlSbvlJ_j1hrAwDeyayBxlZCGPHoqUP3hJK2r7_KYkhbvBusND6PVGDs0
Message-ID: <CAH5Ym4i_Vbu88yHr5UG=6=kOS_jebsSaV3B-AvZjrn+jk8h-xA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230262-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,dubeyko.com,vger.kernel.org,kernel.org,lists.linux.dev];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8684631EF78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:42=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> ...

Hi Slava,

> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This looks like you gave "for future reference" feedback and provided
a R-b tag for the current version of the patch; is that it? Or is this
a tag to roll forward to a v3 with your feedback applied?

If necessary to pass review, I can do something like your (2) and
amend the commit message:

<excerpt>
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    /* in ceph_submit_write() */
    req =3D ceph_osdc_new_request(/* ... */, ceph_wbc->num_ops, /* ... */);
    /* ... */
    BUG_ON(ceph_wbc->op_idx + 1 !=3D req->r_num_ops);

This issue can be reproduced on affected kernels by writing to
</excerpt>

But I fear adding even that much sacrifices clarity: the central point
is that num_ops needs to be correct when ceph_process_folio_batch()
returns; I understand that documenting the symptom of the problem
(where it panics) is an important secondary goal for helping affected
users/stable/downstreams understand the impact and/or discover the
commit, but I'm also trying to be respectful of their time by not
reiterating code to someone who would just CTRL+F the source file if
they wanted this level of detail.

Best,
Sam

