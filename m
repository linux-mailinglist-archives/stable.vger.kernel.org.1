Return-Path: <stable+bounces-225236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Yw5gDk57s2lmXAAAu9opvQ
	(envelope-from <stable+bounces-225236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:49:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D027CE6E
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8381D30BCEC5
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416D33F59F;
	Fri, 13 Mar 2026 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXGpWvaa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B2313E03
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370184; cv=pass; b=TMiR1GR89OSg6W+hpyyaKWNLLL/lo84D0DF7Kno17IITA6jAwQZyKBMxA5tbotRUKzu+95REnchHqHMEEgnz81QFBnvo8Uf8REw3U1gikGRul9OyUUJ08L/UczThLlBTl7P9DwBl4FJZV4bvWVG1Vl9UVAVYiNGKxmis92/CH+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370184; c=relaxed/simple;
	bh=2nl6Q1hAD/NF4AgH7AUp+8dC+dI+oJz0xmvRpiUcjpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElUEqvWTgI1ZXjOTDYHA5FDNXxVuxi7Ft6BqYTc5KeV9oGU9jKWSN5deMNM97sa/yfvoNKPi3i3Omc/R0BkfcgNcikbNS723G+MlhLnrhaUfCszjux2DIrKgqw8doRuxFRaZQUNcV1KWjLXct4pdxl7isqgKnduzhyw69mLqdpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXGpWvaa; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6634d819492so3257110a12.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 19:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773370181; cv=none;
        d=google.com; s=arc-20240605;
        b=bDqY+Vof4ZL0WOH8IyMmrRZlXncc7etEbbviq2SNlDGkTsVBZ/1LV2Pcb2+Yx2vHmE
         4gCERxYIA/JvW2blyRPLKTmW6dV7iQgsNzMlmG3bjlrSOoeMy7pJuzpPI3IwwvB+AlKJ
         qOz+aNOJ2l95v02ZAB+koILmJ+LshNczqU56V+GPDO2hQ3Fve7hSfPePREDnTf8FsNZn
         3noxWu4lk7HpZnhCG/HmU9eIm39pN2xqWwSMJRtn35OKadj3kJ4nWbhUUISXoLxrek2i
         6mw+ISyjiEVvZm+/4KbUUrrSZHO8kR3OcPk4H4JZt5l6OexJxe1pyKQh/Ia1OBYzQ7NS
         bAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r86hWZiRENffSA3Lk94ABHfCxhUdSSg3UrcQ6cLP5Ik=;
        fh=FOYSWq8u8nYkXQT5YiJB5013mK84/pYEmkE2fpQ2ghE=;
        b=M2bw7zTsHi+UCvFk4Bsr2Y6hNMDjmxWBcUjjMqHalP96T4vgbMk9NOI+JfV2CkAxrH
         c932bLdfNpHG+t7f3CLkhU+/FAlDXof41ZKgivF9SDLQu/1NY6Q9ujmrMuOej+rps8K6
         39dtP1pH9An5O1KNvSbXD0UWtEI8DDA9IaTW0CgVG0m1WmfksjWpVnn4Iac3ztDBy8Pc
         ZrZ3Mr6XSzggoXUqIT9LSs53dRnEr0XcdECXxskUEMxxltASjLQTpH4zkDisPwbhsyNp
         +79I81NDEk3yP1BqvXsmcOvTl+PQzjJuYZ8Ldq+j9QG0ZAw3jXsdaqAEB2VGysNzfegJ
         Xn/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773370181; x=1773974981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r86hWZiRENffSA3Lk94ABHfCxhUdSSg3UrcQ6cLP5Ik=;
        b=dXGpWvaal/41N1hsQig3qpYJ0hYYnas85SR5LBAIGiN8GhGdcBlMyYL1HRUfa9HP6f
         5kEZNAnUr00khW3rJpr9xad/uzb4SUZD6+xGlbBer2ucd/hdSVYneqvoiMt84m0V4G3g
         qSG0c/VrZ0ZevE+JuQa6tQrgpeLrsQFV76MO1vSx7TascQFx7WPEnLy4ok0nHkKdLijM
         RBrGHWT/4gTsWVqtequepxI+hdYysqnAoADJosOujWLj/+k3T7CujlqDTz8Z6tZ1LELy
         b0wvni0Dq+yT/AkOf3QDKYzXZ+zB3Phh/hXRQTCUTE5p6/TR9WQnm1hwZKXkoAB2VNRk
         wsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773370181; x=1773974981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r86hWZiRENffSA3Lk94ABHfCxhUdSSg3UrcQ6cLP5Ik=;
        b=TGXiBy+FBQ020WvL8s2i4oXKf1L7OGPDK3ijkhJ/ofH2+gFmdPKbDEnyVNnRHV7T8Y
         6l90QRseyHqkaivxNmePTkEbL2jmhkXkaxFWhEZSfzerhtuj5W76r78ZiYJ/z7kXMgz3
         DkMJ/e2Vz4eg2njnMTVz6OLdw5mN9l5r/JzvmrBIsIuq28Qhlyv66f7HcqXTZWOhBrHr
         ITp/LioA7PvJEo2wHmGtl7K2sEWExz4L9kRkGYryF978Sb7d0nI1NeGZR5VUCNnevJCZ
         qcEumAEtpUw7Slzo/b+QMTkDJfbs/tWxkCXmluCFLxdG37nxXLbyzPl+6dv6LI5QCP5h
         VuMw==
X-Forwarded-Encrypted: i=1; AJvYcCVmcnIJfUI72KQ8FcZC+zIuGS2uvxKBRikdIcyIXeqIXyUyZ4H13JQFkRif8JRHhmeO0KCUVxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhcUPWdDCIngEIYy38ArKsXkI1PB0bky5s6eogIG5FjQceZo6
	TI1Y+2MOW9UKC8FoOlNrwiIuw4z6oC6ekuFqUTUq4k/Un2X96GL4xcQGfM+knzadzwi6ZcUoPRS
	YCtqIxHGCbSjchA/bFdmgn7kig7QfFD8=
X-Gm-Gg: ATEYQzyayjwB7A6zWpz16j55ZP9QtNhQv8oF1SHDaKbHnOjIeOPvL8X+mTlWbTsQHGu
	GELhe8VdG0wxQhpM9mxd4sY2abiV8GZzuzTeMEd0lAqnONQZfQ7jOM19bmm9kfgMVsiskC06xHb
	VF3njMswvKM4g99jnkyHj7RiaW0pO3L+fJs08YQosbFho2/TOMOUpuo4kby2/LMUl7B+unLQz5o
	uha2LkLDpOuG/nPZmQdovjTGF9a3GzWoM/ghlT9q4ReBU9yvkDYnubiplyQVV8YmIWppjrGw+vJ
	KF2DnbKiFYXWNgn8uTVej8fRZalS3WebUZFRLflEL65KzZX53U5p1Os=
X-Received: by 2002:a17:907:94d4:b0:b97:464:9553 with SMTP id
 a640c23a62f3a-b97650d8e72mr106309066b.17.1773370180764; Thu, 12 Mar 2026
 19:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312102229.220570-1-gality369@gmail.com> <ac5058d0-ba4e-4de6-b231-64a29ee2d5e3@suse.com>
In-Reply-To: <ac5058d0-ba4e-4de6-b231-64a29ee2d5e3@suse.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Fri, 13 Mar 2026 10:49:29 +0800
X-Gm-Features: AaiRm531rVJ_2xHaAm0NHTetiWgLQdV_9Auq70c0Sq-wIfwHjIrPtOP0PGgjGBc
Message-ID: <CAOmEq9U14a=pwN_dw2M70gfujhMKki434cfmegoxcyUpkYs5bQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reject root with mismatched level between
 root_item and node header
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225236-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 791D027CE6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 5:29=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> Nope, we have btrfs_tree_parent_check structure, which has all the
> needed checks at read time.
>
> The point of using that other than doing it manually here is, if one
> mirror is bad, but the other mirror is good, then we can still grab the
> good copy, but checking it here means if we got the bad mirror first, we
> have no more chance.
>
> And during read of root-node, we have already passed the proper level
> into it.
>
> So the only possibility is, your fuzzing tool is modifying the memory
> after the read check.
>
> If so, it's impossible to fix.

Thanks for the review and for pointing this out.

I agree that btrfs_tree_parent_check is the intended read-time
verifier, but the crash path here relies on a cache-hit bypass where
that verification is not re-run.

My earlier description may have been misleading, or at least not clear
enough, so let me clarify the exact trigger path in more detail below.

Two different metadata blocks are involved:
- Block A: a root-tree leaf containing root_item for tree 265 (this
field is corrupted: root_item.level =3D 1)
  item 11 key (265 ROOT_ITEM 0) itemoff 13489 itemsize 439
      generation 4255 root_dirid 256 bytenr 18787663872 level 1 refs 1
      lastsnap 4214 byte_limit 0 bytes_used 16384 flags 0x0(none)
      uuid 4cc4bc58-9708-2848-a264-19b95269f104
      ctransid 13 otransid 13 stransid 0 rtransid 0
      ctime 1766050670.362764444 (2025-12-18 09:37:50)
      otime 1766050670.362000000 (2025-12-18 09:37:50)
      drop key (0 UNKNOWN.0 0) level 0

- Block B: the actual tree-265 root block at bytenr 18787663872
(header.level =3D 0, otherwise valid)
    item 57 key (18787663872 METADATA_ITEM 0) itemoff 14198 itemsize 33
      refs 1 gen 4255 flags TREE_BLOCK
      tree block skinny level 0
      tree block backref root 265

In relocate_tree_blocks phase 1 (get_tree_block_key), block B is read
with check.level =3D block->level =3D 0 (from extent-tree metadata for
that extent item).
This I/O path runs btrfs_validate_extent_buffer, and level check
passes (found 0, expected 0).
So block B becomes EXTENT_BUFFER_UPTODATE.

In phase 2 (build_backref_tree -> handle_indirect_tree_backref ->
btrfs_get_fs_root -> read_tree_root_path), level is taken from
root_item in block A via btrfs_root_level, so expected level becomes 1
(corrupt value).
Then read_tree_block is called for the same bytenr (block B), but now
it hits EXTENT_BUFFER_UPTODATE and returns from
read_extent_buffer_pages_nowait early.

On that cache-hit path, btrfs_validate_extent_buffer is not executed
again, so no level mismatch check occurs for expected=3D1 vs actual=3D0.

Because no read error is returned on cache hit, mirror retry logic is
never entered. So this is not a =E2=80=9Cbad mirror first, good mirror late=
r=E2=80=9D
case: there is no second mirror attempt because the read already
succeeded from cache.

read_tree_root_path then builds an inconsistent root object:
  - root->root_item.level =3D 1 (from block A)
  - root->node/commit_root level =3D 0 (from cached block B)

handle_indirect_tree_backref computes level =3D cur->level + 1 =3D 1,
searches commit_root (actual level 0), path->nodes[1] remains NULL,
and btrfs_node_blockptr(NULL, ...) crashes. So the issue is a
cross-block consistency gap at root construction time, not post-read
memory corruption by the fuzzer.

That is why the fix in read_tree_root_path (checking
btrfs_header_level(root->node) =3D=3D btrfs_root_level(&root->root_item))
is needed even with btrfs_tree_parent_check in place.

To clarify, our fuzzing tool does not perform any in-memory
modification during testing. In fact, this bug is not caused by memory
corruption at all; it is triggered entirely by corrupted on-disk
metadata together with a cache-hit path that skips re-validation of
the root block. I have also uploaded the reproduction script to
https://drive.google.com/drive/folders/1BPXcgVI4DLzDcufNyynOakKD4EKnfVCg.

To reproduce the issue:
1. Build the PoC program: gcc repro.c -o poc
2. Build the ublk helper program from the ublk codebase, which is
used to provide the runtime corruption capability:
g++ -std=3Dc++20 -fcoroutines -O2 -o standalone_replay \
standalone_replay_btrfs.cpp targets/ublksrv_tgt.cpp \
-I. -Iinclude -Itargets/include \
-L./lib/.libs -lublksrv -luring -lpthread
3. Attach the crafted image through ublk:
./standalone_replay add -t loop -f /path/to/image
4. Run the PoC: ./poc
This reliably reproduces the bug.

Thanks,
ZhengYuan Huang

