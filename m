Return-Path: <stable+bounces-242187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NhpGHOb82ku5QEAu9opvQ
	(envelope-from <stable+bounces-242187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A134A6BC5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F62730060B2
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10B44D696;
	Thu, 30 Apr 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/whbGG7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWR4nAct"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFF46AF01
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572715; cv=none; b=pCvDXv0Q6ll+lflh88zt4v/XtTuGuB9mQcGZ8DPehrQ6VJvMwjRoAy7Z89OeG+pxRVtwHos+ecOpsEsS0CCYSJPcf7wxjmq7bAyZhblaFvAmQrQCBkF3F/I8w9SLk5V8uoy8DVmtReUHPr4ZA9TBzdbc1sex+inK0bpwFPHGtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572715; c=relaxed/simple;
	bh=gQzIxcSxyvmzQKisxCRYc/QwhGs1vo24eOUTTDHgv8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnFKjJkesGDZkSzaAwDzlVoIFL70vAu59s+ic8iEqwXRbiXsnxnwpatkmEd02x24pHOei+BJVmDErKnglN+IWuXub7nSW3gye00hGHYHXVh/a4HPLcWxruD5lIYeEt+bzqiAAxnUajkrnW/M8w/daKCNILT+4nr7DaB+f7Cp0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/whbGG7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWR4nAct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777572713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1Whz6JpMQNNVhu6Dh4cuj5tfSFS3tpn/UV4LHkcCn0=;
	b=T/whbGG7rohgT9TSa62OIwIinfZH0Ah0BCHXZ4k7WdWWsReLxUf17C73i4xAuKoQsieYfQ
	yVueipirhGCskRlEvwgtH5YrUU42ro3Pf59RUECbTk0fnYyn8yJsZwxf/H3dwfE4X42D7t
	d6Gb0dfYRI900EqIbrybMYPNSqA1+LU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-RL_gv-vTMx-MOI3Boby6Xw-1; Thu, 30 Apr 2026 14:11:51 -0400
X-MC-Unique: RL_gv-vTMx-MOI3Boby6Xw-1
X-Mimecast-MFC-AGG-ID: RL_gv-vTMx-MOI3Boby6Xw_1777572711
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7b3e41a97f0so22054767b3.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777572711; x=1778177511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1Whz6JpMQNNVhu6Dh4cuj5tfSFS3tpn/UV4LHkcCn0=;
        b=XWR4nActPlKZY6LW0pnG+164YKbr0XbgYBkgvdjwCLzldjfA2OPLWYM6u8sZ5XMJyR
         DReWVoQ88vjpVSHvZqpL/byHX9Q8ZNxIyb208+BfLBaa5uzMXAU8YX6CyRN+1F6eIkAL
         0RZm+6gvphfKcWozKNh92V5mc7jll/A4rDuq4JWykVyYRxw82pwtM2EN0Q2t2IevNRFU
         +YIPUsDLxmN2HIjYEm0mGl98FqEfwOsfChWf/qq+H7cv8CzURQrYAaNjL87yfHR09edL
         egyeQLhvtBmOjzHz37V1OAII85fU+oT9qp+GJFsbpNKPZwiTXWaTEa9rHE0aC/VUrdNb
         BxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777572711; x=1778177511;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1Whz6JpMQNNVhu6Dh4cuj5tfSFS3tpn/UV4LHkcCn0=;
        b=lyJT85hfmm0HwRTpL1CoKksU1jkF3KwlSvuNhzf4V1ofWZjMxzo2EmEl5Vqt1Jr6py
         uuynpgdbDHJpui0VWj7ggjSI8fsb15ivIKDulkNr+7jeNZRghmVQMJtMBJ3XUjjxXRmb
         RwBQdkGenICkvtUmxGmUx6z/JkXjFpuSF+lLZPdALxXw3MbT+/dA+f56fxg8jsAwNhO6
         MT5UINJZ7fjOoC8BBPemocXw72Y9eS2dl/sLH2QE52PU48kOlCCmYboqx5HqxCqp5yw+
         zEv7IMBupsgVO6EsjLOzVzTPg7c24iczM2URPFAnbYWtU6d+wg7iYVN6+LHRYiWJ8uJK
         H7IA==
X-Forwarded-Encrypted: i=1; AFNElJ/ESIajp9xWupGyWs7VOJX39osQzebDhoJejOkU4F3D70swDmNyp+akaGUZ2ee/L33IaJ1q1Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhIP5FZpNc0Ri/SygCDPn9T+z8ZLysvdToK8HbsrlDpk8ibZsw
	VwR7zf/JZz+w+xeXH6v0kCMDqsCdjgoRf/Qxx8k/HWrj/e+PYsvQ+UVNrZkKONzDv3aaYW2Z9ss
	0iP1QJen8KZ/YeqqmjwG9Xg4gcv0XcMs7kgxSVsSr85NokjlV6BT29hcefw==
X-Gm-Gg: AeBDiesVxShJfGmXJAE9H7675p513VV0o0Mu5bGxmyJSE5PK7+2IlC6ZGXaPiH7P9kJ
	mWHfAX2PIApZs0Prl/GeXnqG1wXuJBZtsV8xKlRylp2Qty3RwWucH7PEHFQ84HVq8gFErN4Eti9
	W6vQdcxDypNJ/+RbfWe8ihdhG+GgDSwDeWTnuRGBv8zz9HfW28LYtVbnd03g8+7MV9rDHeB1NCP
	D6Ojdxz2C7qUbnsVXLiOl5Yju3GML//hU2MNv7FhOs/geIRGrgF7BAHfiFX613WPs14nN3x+f0L
	SVe2GhXt4FjFtuqmSv+pIBV4I8Lk+vgTbtJBQE2zI7Iad3XGOaqO1jY1gJPHUpH7pSygjOgwe3l
	cQpgNmEr3cWu8LCsGNoXFxJnGLBQX5SG29LthcKoqhg8lVhktWIyDd3OS+LG4JRI=
X-Received: by 2002:a05:690c:660d:b0:79a:dae4:5832 with SMTP id 00721157ae682-7bd52892ec7mr42941127b3.22.1777572705777;
        Thu, 30 Apr 2026 11:11:45 -0700 (PDT)
X-Received: by 2002:a05:690c:660d:b0:79a:dae4:5832 with SMTP id 00721157ae682-7bd52892ec7mr42940677b3.22.1777572705281;
        Thu, 30 Apr 2026 11:11:45 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6683836asm556967b3.25.2026.04.30.11.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:11:44 -0700 (PDT)
Message-ID: <eea194aa0f8734f38fa645db935aca47175bdf17.camel@redhat.com>
Subject: Re: [PATCH v3] nilfs2: reject CLEAN_SEGMENTS ioctl with
 out-of-range segment numbers
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, konishi.ryusuke@gmail.com, 
	slava@dubeyko.com
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Date: Thu, 30 Apr 2026 11:11:43 -0700
In-Reply-To: <20260430040704.113622-1-kartikey406@gmail.com>
References: <20260430040704.113622-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 92A134A6BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-242187-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,62f0f99d2f2bb8e3bbd7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

On Thu, 2026-04-30 at 09:37 +0530, Deepanshu Kartikey wrote:
> Syzbot reported a hung task in nilfs_transaction_begin() where multiple
> tasks performing chmod() on a nilfs2 mount blocked for over 143 seconds
> waiting to acquire ns_segctor_sem for read:
>=20
>   INFO: task syz.0.17:5918 blocked for more than 143 seconds.
>   Call Trace:
>    schedule+0x164/0x360
>    rwsem_down_read_slowpath+0x6d9/0x940
>    down_read+0x99/0x2e0
>    nilfs_transaction_begin+0x364/0x710 fs/nilfs2/segment.c:221
>    nilfs_setattr+0x124/0x2c0 fs/nilfs2/inode.c:921
>    notify_change+0xc1a/0xf40
>    chmod_common+0x273/0x4a0
>    do_fchmodat+0x12d/0x230
>=20
> The writer holding ns_segctor_sem was a concurrent=20
> NILFS_IOCTL_CLEAN_SEGMENTS caller, stuck inside printk while emitting=20
> per-element warnings from nilfs_sufile_updatev():
>=20
>    __nilfs_msg+0x373/0x450 fs/nilfs2/super.c:78
>    nilfs_sufile_updatev+0x21c/0x6d0 fs/nilfs2/sufile.c:186
>    nilfs_sufile_freev fs/nilfs2/sufile.h:93 [inline]
>    nilfs_free_segments fs/nilfs2/segment.c:1140 [inline]
>    nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1261 [inline]
>    nilfs_segctor_do_construct+0x1f55/0x76c0
>    nilfs_clean_segments+0x3bd/0xa50
>    nilfs_ioctl_clean_segments fs/nilfs2/ioctl.c:922 [inline]
>    nilfs_ioctl+0x261f/0x2780
>=20
> The root cause is that user-supplied segment numbers are not validated
> before nilfs_clean_segments() begins doing work; the range check on
> each segnum is performed deep inside the call chain by
> nilfs_sufile_updatev(), which emits a nilfs_warn() per invalid entry
> while still holding the segctor lock and the sufile mi_sem.  Under load
> (repeated invocations across multiple mounts saturating the global
> printk path), the cumulative printk latency keeps ns_segctor_sem held
> long enough to trip the hung_task watchdog, blocking concurrent
> operations such as chmod() that need ns_segctor_sem for read.
>=20
> Fix by validating the contents of kbufs[4] in nilfs_clean_segments()
> immediately after acquiring ns_segctor_sem via nilfs_transaction_lock().
> Holding ns_segctor_sem serializes the check against
> nilfs_ioctl_resize(), which can modify ns_nsegments, so the validation
> uses a consistent value.  Out-of-range segment numbers are rejected
> with -EINVAL before any segment-cleaning work begins, so the bad
> entries never reach the per-element diagnostic path inside
> nilfs_sufile_updatev().
>=20
> Reported-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D62f0f99d2f2bb8e3bbd7
> Tested-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
> Fixes: 4f6b828837b4 ("nilfs2: fix lock order reversal in nilfs_clean_segm=
ents ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v3:
>   - Move validation from nilfs_ioctl_clean_segments() into
>     nilfs_clean_segments(), under ns_segctor_sem held for write
>     by nilfs_transaction_lock(), to serialize against
>     nilfs_ioctl_resize() which can modify ns_nsegments
>     (Ryusuke Konishi)
>   - Introduce local variables segnumv and nfreesegs for readability,
>     rather than open-coding casts of kbufs[4] (Ryusuke Konishi)
>   - Emit nilfs_err() once on the first out-of-range segnum and bail
>     out, instead of nilfs_warn() per element (Ryusuke Konishi)
>   - Add bail_unlock label for the early-failure path, parallel to
>     the existing out_unlock structure (Ryusuke Konishi)
>=20
> Changes in v2:
>   - Reuse existing 'n' loop variable instead of introducing a new
>     one (Slava Dubeyko)
>   - Add dedicated out_free_segnums label so the validation-failure
>     path falls through the existing cleanup ladder rather than
>     duplicating kfree(kbufs[4]) inline (Slava Dubeyko)
> ---
>  fs/nilfs2/segment.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 1491a4d4b1e1..dc54643866ce 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2512,12 +2512,33 @@ int nilfs_clean_segments(struct super_block *sb, =
struct nilfs_argv *argv,
>  	struct nilfs_sc_info *sci =3D nilfs->ns_writer;
>  	struct nilfs_transaction_info ti;
>  	int err;

Usually, I prefer to keep the err variable at the end of declarations. Beca=
use,
it is the ending state of the function. And I am feeling that something is =
wrong
every time when likewise variable is hidden inside of declaration list. :) =
There
is nothing critical in my remark. But anyway... :)

The path looks good to me.

Thanks,
Slava.

> +	size_t i, nfreesegs =3D argv[4].v_nmembs;
> +	__u64 *segnumv =3D kbufs[4];
> =20
>  	if (unlikely(!sci))
>  		return -EROFS;
> =20
>  	nilfs_transaction_lock(sb, &ti, 1);
> =20
> +	/*
> +	 * Validate segment numbers under ns_segctor_sem (held for write
> +	 * by nilfs_transaction_lock above) so the check is serialized
> +	 * against nilfs_ioctl_resize(), which can modify ns_nsegments.
> +	 * Rejecting bad input here, before any segment-cleaning work
> +	 * begins, avoids the per-element diagnostic path inside
> +	 * nilfs_sufile_updatev() that would otherwise run under this
> +	 * same lock and stall concurrent readers.
> +	 */
> +	for (i =3D 0; i < nfreesegs; i++) {
> +		if (segnumv[i] >=3D nilfs->ns_nsegments) {
> +			nilfs_err(sb,
> +				 "Segment number %llu to be freed is out of range",
> +				 (unsigned long long)segnumv[i]);
> +			err =3D -EINVAL;
> +			goto bail_unlock;
> +		}
> +	}
> +
>  	err =3D nilfs_mdt_save_to_shadow_map(nilfs->ns_dat);
>  	if (unlikely(err))
>  		goto out_unlock;
> @@ -2558,6 +2579,7 @@ int nilfs_clean_segments(struct super_block *sb, st=
ruct nilfs_argv *argv,
>  	sci->sc_freesegs =3D NULL;
>  	sci->sc_nfreesegs =3D 0;
>  	nilfs_mdt_clear_shadow_map(nilfs->ns_dat);
> + bail_unlock:
>  	nilfs_transaction_unlock(sb);
>  	return err;
>  }


