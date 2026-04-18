Return-Path: <stable+bounces-238546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BmIHg4l42naCQEAu9opvQ
	(envelope-from <stable+bounces-238546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D25274202E2
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCFF30305C8
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774B3446CC;
	Sat, 18 Apr 2026 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJhtncX6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EF33985A
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493700; cv=none; b=XFWqB0bJZnNFW6PGGZjuEEiEIr67wcW9ts2tJKlQXrzUaV5GVqzzk/1dw5ImYFxNHo1jUGbLpmgbFlsh0JsRBSxTHnYDIWTT47rG8Flj96RnLdMKrxnJEF4ZFUj257CubxmeqkUw3LhO2Nv5uPCyWkOSUVaRYOV6vQRLxHI6GUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493700; c=relaxed/simple;
	bh=OKKixADUa7Qf6rDznlLGRF7ZfXVBuUqdH9SbW6P5uA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7K6Kfxn2aYdMw93YtsrCAbkHhAks5Bml9w4qrirqSyCvCC3mp5JzO9jylz59CTIlmqXM/3DSkFerWBerM9FcndQeHYaUuSVuuPiuXGPOUpTQUjO9ESros9mQhDOmPvX1OrZpysIpcnDn+oqa3y8cfjrq95Ja23V/uK4IxHHwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJhtncX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF10C19424
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776493700;
	bh=OKKixADUa7Qf6rDznlLGRF7ZfXVBuUqdH9SbW6P5uA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJhtncX6vJAa9PCdqesPeHRLM5VMsy61rrXYaj4M4Y5zbbDzNgDW8BooY8YDwdu56
	 Gqq/Vz7KwEMtJzmz0O276eTjtQBTomA0iEZyRS6LWt+Hg89TgM2LMT1GHdcA8QyMn6
	 Rr7kGWQZpzZSNYwDKzp/pqZl5VW8pOle3rZ5f7cIxcLVJn+W8YyuZI2gL2XkQp8Gep
	 gHaSD7+aDglEgK/7r7ufxIusnyTZeASAYfPBy7Epa5ONZLXj9/SaoLayTEFM+IxBwD
	 rAws1UK5+FwYZN9GnInmNQpor20ZkxRPMnF7PV58vyFiW4Gmz8CE8KoTJbrk4xOgTF
	 my9gW0DoLSiWQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso171113a12.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5hKVY9qg4O+LwGdH3ItusD4lyjB0fx18mW3r0+OPsOb9pWgN2tMEasHEQriT3yWBYuakIMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7siAve9XJ68BML856PTSoTPrWmB+stjGv4ALsBlIjUjmrTqhM
	PoWwBiHKLjo+IxfAYP7v8/GIPLRIjltlpG/lJftKMhJ6e6rfDMpy/UUhUkYj1G4WJmA5zMREsGz
	VRA0CHUTtDI7ekSP401mNrawl9ICC+pg=
X-Received: by 2002:a05:6402:90a:b0:66e:aade:e2e3 with SMTP id
 4fb4d7f45d1cf-672bfdde7b4mr2966711a12.27.1776493698960; Fri, 17 Apr 2026
 23:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416200439.2987930-1-michael.bommarito@gmail.com> <20260417184557.1138554-1-michael.bommarito@gmail.com>
In-Reply-To: <20260417184557.1138554-1-michael.bommarito@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 18 Apr 2026 15:28:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-C358TaLXHAMdfEn8FBNjjfN1ONq3tuDSAyguzc2qEjg@mail.gmail.com>
X-Gm-Features: AQROBzD3WcGqkyfD9s3HibPWpNoDBmgBkHVuGv04v9w7DgczlUEFgZ5QZ1DlAPQ
Message-ID: <CAKYAXd-C358TaLXHAMdfEn8FBNjjfN1ONq3tuDSAyguzc2qEjg@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Ronnie Sahlberg <lsahlber@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,chromium.org,talpey.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-238546-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D25274202E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 3:46=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> smb_inherit_dacl() trusts the on-disk num_aces value from the parent
> directory's DACL xattr and uses it to size a heap allocation:
>
>   aces_base =3D kmalloc(sizeof(struct smb_ace) * num_aces * 2, ...);
>
> num_aces is a u16 read from le16_to_cpu(parent_pdacl->num_aces)
> without checking that it is consistent with the declared pdacl_size.
> An authenticated client whose parent directory's security.NTACL is
> tampered (e.g. via offline xattr corruption or a concurrent path that
> bypasses parse_dacl()) can present num_aces =3D 65535 with minimal
> actual ACE data.  This causes a ~8 MB allocation (not kzalloc, so
> uninitialized) that the subsequent loop only partially populates, and
> may also overflow the three-way size_t multiply on 32-bit kernels.
>
> Additionally, the ACE walk loop uses the weaker
> offsetof(struct smb_ace, access_req) minimum size check rather than
> the minimum valid on-wire ACE size, and does not reject ACEs whose
> declared size is below the minimum.
>
> Reproduced on UML + KASAN + LOCKDEP against the real ksmbd code path.
> A legitimate mount.cifs client creates a parent directory over SMB
> (ksmbd writes a valid security.NTACL xattr), then the NTACL blob on
> the backing filesystem is rewritten to set num_aces =3D 0xFFFF while
> keeping the posix_acl_hash bytes intact so ksmbd_vfs_get_sd_xattr()'s
> hash check still passes.  A subsequent SMB2 CREATE of a child under
> that parent drives smb2_open() into smb_inherit_dacl() (share has
> "vfs objects =3D acl_xattr" set), which fails the page allocator:
>
>   WARNING: mm/page_alloc.c:5226 at __alloc_frozen_pages_noprof+0x46c/0x9c=
0
>   Workqueue: ksmbd-io handle_ksmbd_work
>    __alloc_frozen_pages_noprof+0x46c/0x9c0
>    ___kmalloc_large_node+0x68/0x130
>    __kmalloc_large_node_noprof+0x24/0x70
>    __kmalloc_noprof+0x4c9/0x690
>    smb_inherit_dacl+0x394/0x2430
>    smb2_open+0x595d/0xabe0
>    handle_ksmbd_work+0x3d3/0x1140
>
> With the patch applied the added guard rejects the tampered value
> with -EINVAL before any large allocation runs, smb2_open() falls back
> to smb2_create_sd_buffer(), and the child is created with a default
> SD.  No warning, no splat.
>
> Fix by:
>
>   1. Validating num_aces against pdacl_size using the same formula
>      applied in parse_dacl().
>
>   2. Replacing the raw kmalloc(sizeof * num_aces * 2) with
>      kmalloc_array(num_aces * 2, sizeof(...)) for overflow-safe
>      allocation.
>
>   3. Tightening the per-ACE loop guard to require the minimum valid
>      ACE size (offsetof(smb_ace, sid) + CIFS_SID_BASE_SIZE) and
>      rejecting under-sized ACEs, matching the hardening in
>      smb_check_perm_dacl() and parse_dacl().
>
> v1 -> v2:
>   - Replace the synthetic test-module splat in the changelog with a
>     real-path UML + KASAN reproduction driven through mount.cifs and
>     SMB2 CREATE; Namjae flagged the kcifs3_test_inherit_dacl_old name
>     in v1 since it does not exist in ksmbd.
>   - Drop the commit-hash citation from the code comment per Namjae's
>     review; keep the parse_dacl() pointer.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

