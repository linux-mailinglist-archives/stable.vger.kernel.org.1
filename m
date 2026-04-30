Return-Path: <stable+bounces-242098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOI7MHJH82kMzAEAu9opvQ
	(envelope-from <stable+bounces-242098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:13:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204C4A2A22
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8005B300FFB5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8090E402444;
	Thu, 30 Apr 2026 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci9Sy1pl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23C401A1E
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551215; cv=pass; b=CAQ7YBWNrwngiTJS4fgS6C+dLUK8xcjYZyAWL44E+Nf20bBnvevWSFLySPsXThnJdA6YwUccG9n058bs94iRqLObS73CVovQkY15JrJYaRe3QRYBZxCNCbQQCbGUMyaRwvXeWZgi8C4iHNz4QkxXaTxB8bQZiU4a09wMUWbKvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551215; c=relaxed/simple;
	bh=TXDa7NSy3a1jhWRS3H4Tp3vEJQ8F5w1HWUyRgirZx6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fs3zLwjUu9n7VXnrty8MI+KHwSE0nqxYYwiY4Y+NRadHsKcVmWH+p4LzLU8QcD0HcXedHgZhDuNWltcTUkbLH3ALHMA0sx+aY+nlCnd5iE4cld6vSy5sUGCbdjxze12f/mwXbO+vt0W+brTlKPFcFMWjmz16j6H/MW/pae0kKW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci9Sy1pl; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso9744871fa.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777551212; cv=none;
        d=google.com; s=arc-20240605;
        b=GWD43zKhfaip8qghWa2IgI5CziCyMiRq8280yOvBo6RSteKgTUKgdgOb2vu1pvZC9X
         fpRpqXPX2u71ENMvbvMvyi3tO2+a99W0JSvkLCHsEYYXD+rVYkNSxjvSYPTmXHpR6nGb
         Q65P7HyDljxgMeFTMbPkTJDPrxggS8ofwBT6bWWLAizPIxNgjvcwGAF23qNZ5wYIbVqs
         hRo/iO/O4GASEE3kzEaLJEGF1FiY6YYhLlGPxLCj8lXAkzupZGlrTmfvb9dlg8APXq90
         jPs3wwHqZccB2IvjCHnx4suK0rhDMQp1kJjsQxbDaQSbK4eMOtRhRj3tYjQUUYyktpDy
         cHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYuaEj62f6abXXXknGHMgNIJHgrJvbt+knMI7MVBneE=;
        fh=OG389UaHTI0xO94/eVAZAIkvtXsxro6FPmSeFbWmoTs=;
        b=GY+jFdoiriLNWJcsM89xeUQ/3jcO2Pvdg9Anw3/e8PCX+NxxOLtzRozNP8XQKMGumN
         q8fjQeIjbl9N4YUSBOv9U4oCK6J3T38usbFOB+UmlrDCJ0AM4Y33KGqxJctkqMn8rlPg
         rQAUBDLw51fnrqzKHOvCEdj3BfMpuyOG7Dq3vrvrsMEPLU9ukOs4PazN45gWvbpcVkJr
         4yNY7N0a1VJnnLWl1EJybAeib9IxXjJr11/qmS7fbhcFEH23MpSP7g3CB4ZDT2okWdcw
         6YQ7Oe8BYd3mAaTOHI0HaZTbFhsCcuAYHjs/uQC/2SfVYOTptk06jlXQ5xAFVKoJkU//
         e0bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777551212; x=1778156012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYuaEj62f6abXXXknGHMgNIJHgrJvbt+knMI7MVBneE=;
        b=Ci9Sy1plPyQU4UoMlE0Hah7bQf63oXJiek5ZesbqNjgEH21rFGHD36u6T9Kf4v01Vn
         oOfWHQJvCp8pb7cARwTB7z+drZx5rl8eBxO7CFk3Km9LucjovE0Xj4s0ZiVkjWJ4ZS3I
         7qXAjMhucUwGYGkKzARdVpcZtK/d5t+Xm4pYQ8IGpjBM580Qe6ZUjp9eDLTw6uAyF4lO
         tEl7VH9DQ8/aUXlo2RCdItpMbZbWLYNdPHJkCMbgSyL+Zt+JZyHR0AMObSDjFfXuh7rR
         rq1o7KagK+cbxAbnWLTJec5pJ72lJpr0lHsZ4A0sB3u1xKLyOPcRZBOZhRaFSbjBUNoa
         ObeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777551212; x=1778156012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYuaEj62f6abXXXknGHMgNIJHgrJvbt+knMI7MVBneE=;
        b=JX76p2lPCdZ7dsyJdFjfapFa8f6sdUaH2rWPnjXfWdzBnue89MqfXz0VWmPFxH9jwm
         PcMddIanMrqc7JMZRtLNJaA781vQr1AWmCvzMI85W+ZCA3s6yDB+93E2jEMIvutxM9lU
         S0P47AnNodK1KrFBkiRlAJKq+5P31S3Fa2vODWK5TkWzbHvoa0EKBPWJWMoK7AhHIZJA
         nUkiEW3MMjqlMom32bha+DKHCnBoiX7UvlN25G2mNnQuj2L0VzeF8n1jgQuibckarRbH
         dNXGnWmXbwStKaGCo+7Cvt1808MCaTLyyqonh4CRfGEv0JTgy+DsygX+3QaY30KqTMky
         snNA==
X-Forwarded-Encrypted: i=1; AFNElJ/uNj12oI4q3DA6t9hrzeTK90+oWdRrDg7FYOUttv8RXPOmUjFPiwhoNMABN31F41onGVHlgQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBNo16k+vxP2ypJkSOGBFLANLsqdL9jJzjmQsZy5I+8ctXKQ3
	8660rhqWrf/JvXL16mY8Rleo5vvU9kl0Qx0AYBmfJ4ARkIVv1dEoymKo9ZX9CYQAWLJTad4oVob
	Y4uvlkdY8J/tn81KMPAIE/tkcBF7iC/ms12Fj
X-Gm-Gg: AeBDiev6vjckHOF301qZRurhbbxFFI7JQKOAzRcYH8HBw1BSdfhRMiSdx6Hjhe/iClf
	KzvGxZjXXOXqaRKZjqqgnrOU6JX7+Y5PkwHO3VYwsXv024efp+qnKbM+v/ShXk3S9x16XwZVjUW
	JenqYUES7Taqn5d6Fxd+esH81iNKnpiiABlPbMZJhjELqccy4U1etR4SuuX/6zUnrfD6ZAfujKq
	BBTJLL/FogBgBn86vEe/HIJamL7XNmCxIyaaGmrm9abovfYwbCW8hhXpdQ1x0VACVZImK8GYtBH
	c8jHRMzvTBDFC2cKZss=
X-Received: by 2002:a05:6512:3b28:b0:5a6:2a5f:11d with SMTP id
 2adb3069b0e04-5a8522d4b14mr982679e87.26.1777551211529; Thu, 30 Apr 2026
 05:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430040704.113622-1-kartikey406@gmail.com>
In-Reply-To: <20260430040704.113622-1-kartikey406@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 30 Apr 2026 21:13:15 +0900
X-Gm-Features: AVHnY4Iy8pyMuz7kCxFxo_q6faXjAqhfSG5inFa-dNzyMIHUZn4zGe-SBjClBdU
Message-ID: <CAKFNMo=_mkGn6OtXXcjhiYFQ2cvBVisPbSsRMz3XBqxHvByyMw@mail.gmail.com>
Subject: Re: [PATCH v3] nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range
 segment numbers
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3204C4A2A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242098-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,62f0f99d2f2bb8e3bbd7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 1:07=E2=80=AFPM Deepanshu Kartikey wrote:
>
> Syzbot reported a hung task in nilfs_transaction_begin() where multiple
> tasks performing chmod() on a nilfs2 mount blocked for over 143 seconds
> waiting to acquire ns_segctor_sem for read:
>
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
>
> The writer holding ns_segctor_sem was a concurrent
> NILFS_IOCTL_CLEAN_SEGMENTS caller, stuck inside printk while emitting
> per-element warnings from nilfs_sufile_updatev():
>
>    __nilfs_msg+0x373/0x450 fs/nilfs2/super.c:78
>    nilfs_sufile_updatev+0x21c/0x6d0 fs/nilfs2/sufile.c:186
>    nilfs_sufile_freev fs/nilfs2/sufile.h:93 [inline]
>    nilfs_free_segments fs/nilfs2/segment.c:1140 [inline]
>    nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1261 [inline]
>    nilfs_segctor_do_construct+0x1f55/0x76c0
>    nilfs_clean_segments+0x3bd/0xa50
>    nilfs_ioctl_clean_segments fs/nilfs2/ioctl.c:922 [inline]
>    nilfs_ioctl+0x261f/0x2780
>
> The root cause is that user-supplied segment numbers are not validated
> before nilfs_clean_segments() begins doing work; the range check on
> each segnum is performed deep inside the call chain by
> nilfs_sufile_updatev(), which emits a nilfs_warn() per invalid entry
> while still holding the segctor lock and the sufile mi_sem.  Under load
> (repeated invocations across multiple mounts saturating the global
> printk path), the cumulative printk latency keeps ns_segctor_sem held
> long enough to trip the hung_task watchdog, blocking concurrent
> operations such as chmod() that need ns_segctor_sem for read.
>
> Fix by validating the contents of kbufs[4] in nilfs_clean_segments()
> immediately after acquiring ns_segctor_sem via nilfs_transaction_lock().
> Holding ns_segctor_sem serializes the check against
> nilfs_ioctl_resize(), which can modify ns_nsegments, so the validation
> uses a consistent value.  Out-of-range segment numbers are rejected
> with -EINVAL before any segment-cleaning work begins, so the bad
> entries never reach the per-element diagnostic path inside
> nilfs_sufile_updatev().
>
> Reported-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D62f0f99d2f2bb8e3bbd7
> Tested-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
> Fixes: 4f6b828837b4 ("nilfs2: fix lock order reversal in nilfs_clean_segm=
ents ioctl")

The cause appears to be commit 071cb4b81987 ("nilfs2: eliminate
removal list of segments"), which removed the segment release logic
that used a list of segment information structures.
Prior to that, the validity check of segment numbers was performed
within nilfs_ioctl_prepare_clean_segments().

Everything else seems OK, so I'll fix only that tag myself, perform a
final check, and then send it upstream.

Thanks,
Ryusuke Konishi

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
>
> Changes in v2:
>   - Reuse existing 'n' loop variable instead of introducing a new
>     one (Slava Dubeyko)
>   - Add dedicated out_free_segnums label so the validation-failure
>     path falls through the existing cleanup ladder rather than
>     duplicating kfree(kbufs[4]) inline (Slava Dubeyko)
> ---
>  fs/nilfs2/segment.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 1491a4d4b1e1..dc54643866ce 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2512,12 +2512,33 @@ int nilfs_clean_segments(struct super_block *sb, =
struct nilfs_argv *argv,
>         struct nilfs_sc_info *sci =3D nilfs->ns_writer;
>         struct nilfs_transaction_info ti;
>         int err;
> +       size_t i, nfreesegs =3D argv[4].v_nmembs;
> +       __u64 *segnumv =3D kbufs[4];
>
>         if (unlikely(!sci))
>                 return -EROFS;
>
>         nilfs_transaction_lock(sb, &ti, 1);
>
> +       /*
> +        * Validate segment numbers under ns_segctor_sem (held for write
> +        * by nilfs_transaction_lock above) so the check is serialized
> +        * against nilfs_ioctl_resize(), which can modify ns_nsegments.
> +        * Rejecting bad input here, before any segment-cleaning work
> +        * begins, avoids the per-element diagnostic path inside
> +        * nilfs_sufile_updatev() that would otherwise run under this
> +        * same lock and stall concurrent readers.
> +        */
> +       for (i =3D 0; i < nfreesegs; i++) {
> +               if (segnumv[i] >=3D nilfs->ns_nsegments) {
> +                       nilfs_err(sb,
> +                                "Segment number %llu to be freed is out =
of range",
> +                                (unsigned long long)segnumv[i]);
> +                       err =3D -EINVAL;
> +                       goto bail_unlock;
> +               }
> +       }
> +
>         err =3D nilfs_mdt_save_to_shadow_map(nilfs->ns_dat);
>         if (unlikely(err))
>                 goto out_unlock;
> @@ -2558,6 +2579,7 @@ int nilfs_clean_segments(struct super_block *sb, st=
ruct nilfs_argv *argv,
>         sci->sc_freesegs =3D NULL;
>         sci->sc_nfreesegs =3D 0;
>         nilfs_mdt_clear_shadow_map(nilfs->ns_dat);
> + bail_unlock:
>         nilfs_transaction_unlock(sb);
>         return err;
>  }
> --
> 2.43.0
>
>

