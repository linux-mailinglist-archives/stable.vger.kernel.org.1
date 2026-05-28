Return-Path: <stable+bounces-256455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHk0M1HaGGpDoAgAu9opvQ
	(envelope-from <stable+bounces-256455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:14:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652C5FBA43
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33CE2304740B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDA2772E;
	Fri, 29 May 2026 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PhGR6495"
X-Original-To: stable@vger.kernel.org
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3426AE5
	for <stable@vger.kernel.org>; Fri, 29 May 2026 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013644; cv=none; b=JeRw5OqprbpxwutV/rEFDDc+I2S45YPKkaj5z8pxfnXYVXPCjG9wMItr2OWUOaEEdimP3owi0IMrAy2UPmoWEBZkbqZJ7nSjGjMMjtIcCfvFWdUb17nvjkB9zQ77d/HXUjAiQbRe9NeYJvqf8ZMfISwzNi1iAVhMfuaQwlRUAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013644; c=relaxed/simple;
	bh=EJ9DBujlCtPS42LtbVFKLbjHcrFxdvRzdmSCHoG5B4s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IelebBeZWykE2QC7cloTYzN4aFxtSmR3VzT/t8GsLSLLUUOoNlJ8k0MWUYVlBcoK6ggbU+SvgT/L6fCKZ0jyrbph/3lLURXeA5BDBUo3liIApXxR8UC/6HUpIL0nwxYSDViCzyH2A9Gt0Pl/IGs8zZn8x+FZHC5hrGwLFi+JcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PhGR6495; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780013628; x=1780272828;
	bh=/NklfoWCDoxPcwrWRxH1KpgXRYiohQbVsmhu6h2/EYA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PhGR6495vhd5vvoNvLlWGHmuOj4kl5hvr64721x6ckrNBbqMnEgqtOinsMFAZen5g
	 wgVgNIbF9YiyDY07QJCdtTKO5FceF6dEomYbuxaa6NSd5g6g0drlcGB3L7alRduNWw
	 +RAHi3kp9qSXJ+EWzRWaRL+uR67N9PequB2brgSw8e42WzLNZEe7tvrKwkaEU5N+PH
	 TGZr8sKOOgc9YlOAeEts7QGD8/V8vINx0VF43xezpYEijGuZ/H4jobY+FpwnTpHX/a
	 RUnDyKujIhtxTNldE4gnP3PsuWkHcyAFdhiShmLQ7qwzSB1/GLOGZl7Q75VH9vLXga
	 V/TdVgojglDxQ==
Date: Thu, 28 May 2026 16:02:17 +0000
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: hexlabsecurity@proton.me
Cc: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>, sagi@grimberg.me, kch@nvidia.com, "bvanassche@acm.org" <bvanassche@acm.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "hexlabsecurity@proton.me" <hexlabsecurity@proton.me>
Subject: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page
Message-ID: <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
In-Reply-To: <20260528083537.GA7590@lst.de>
References: <Q8CVAA098pa1LIPOSNGvR2qrzqdOBQqRTLK54O4KsGMzSh4IOT2Ucrlv87C0ULvpILYim-FotD-OumzPcjFauZM2iyjJ4tjzaMRsXE7G_3Q=@proton.me> <20260527132353.GB11071@lst.de> <QQhn1zPqAyjwS7XXM_jeFtjpyW7pXcVTGMP38boMl6zWR5ehel-nsdJdksZf0ASO03qt5pX1B5UAnlANuO7KZISSgggAjnjLruly7nAjJ2A=@proton.me> <20260528083537.GA7590@lst.de>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 9699613454a2d80a91573b984356703a7369e0d2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256455-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[proton.me:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 3652C5FBA43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 6710e68439c458d691a4fe5c7fa354404745dd0a Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Wed, 27 May 2026 15:00:00 -0500
Subject: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in Discover=
y
 Get Log Page

nvmet_execute_disc_get_log_page() validates only the dword alignment
of the host-supplied Log Page Offset (lpo).  The 64-bit offset is then
added to a small kzalloc'd buffer that holds the discovery log page
and the result is passed straight to nvmet_copy_to_sgl(), which
memcpy()s data_len bytes out to the host with no source-side bound
check:

    u64 offset      =3D nvmet_get_log_page_offset(req->cmd);  /* 64-bit hos=
t */
    size_t data_len =3D nvmet_get_log_page_len(req->cmd);     /* 32-bit hos=
t */
    ...
    if (offset & 0x3) { ... }                               /* only check *=
/
    ...
    alloc_len =3D sizeof(*hdr) + entry_size * discovery_log_entries(req);
    buffer =3D kzalloc(alloc_len, GFP_KERNEL);
    ...
    status =3D nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);

The Discovery controller is unauthenticated -- nvmet_host_allowed()
returns true unconditionally for the discovery subsystem -- so the call
is reachable pre-authentication by any TCP/RDMA/FC peer that can reach
the nvmet target.  With a discovery log page of ~1 KiB, an attacker
requesting up to 4 KiB starting at offset =3D=3D alloc_len reads the next
slab page out and gets its content returned over the fabric (an
empirical run on a default nvmet-tcp loopback target leaked 81
canonical kernel pointers in one Get Log Page response).  Pointing the
offset at unmapped kernel memory faults the in-kernel memcpy and
crashes (or panics, on panic_on_oops=3D1) the target host instead.

The attacker-controlled source-side offset pattern
"nvmet_copy_to_sgl(req, 0, buffer + ATTACKER_OFFSET, ...)" is unique
to nvmet_execute_disc_get_log_page in the entire nvmet codebase: every
other Get Log Page handler in admin-cmd.c either ignores lpo (and
silently starts every response at offset 0) or tracks a local
destination offset with a fixed source pointer.

Validate the host-supplied offset against the log page size, cap the
copy length to what is actually available, and zero-fill any remainder
of the host transfer buffer.  The zero-fill matches the existing
short-response pattern in nvmet_execute_get_log_changed_ns()
(admin-cmd.c) and prevents leaking transport SGL contents when the
host asks for more bytes than the log page contains.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Suggested-by: Christoph Hellwig <hch@lst.de>
Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: rewrote the validation flow per Christoph's suggestion -- single
    `out_free_buffer` cleanup label reached by `goto` on the offset
    overflow path, `min_t(size_t, ...)` for the capped copy length,
    one fewer level of nesting.  `min_t(size_t, ...)` (rather than
    bare `min()`) because `data_len` is `size_t` and `alloc_len -
    offset` promotes to `unsigned long long` (since `offset` is
    `u64`), which trips the kernel min() __typecheck; the size_t
    rendition matches the analogous shape in io-cmd-bdev.c:228.

    Empirically verified on a Linux 6.12.90 KASAN INLINE +
    kasan.fault=3Dpanic VM: pre-fix `nvme get-log lpo=3Dalloc_len
    len=3D4096` reboots the host via KASAN catching the OOB memcpy;
    post-fix the same probe returns cleanly with zero kernel-pointer
    qwords leaked, and `lpo > alloc_len` returns
    NVME_SC_INVALID_FIELD as intended.

v1: https://lore.kernel.org/linux-nvme/ -- (search by Reported-by)

 drivers/nvme/target/discovery.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discover=
y.c
index e9b35549e254..114869d16a1f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -166,6 +166,7 @@ static void nvmet_execute_disc_get_log_page(struct nvme=
t_req *req)
 =09u64 offset =3D nvmet_get_log_page_offset(req->cmd);
 =09size_t data_len =3D nvmet_get_log_page_len(req->cmd);
 =09size_t alloc_len;
+=09size_t copy_len;
 =09struct nvmet_subsys_link *p;
 =09struct nvmet_port *r;
 =09u32 numrec =3D 0;
@@ -242,7 +243,27 @@ static void nvmet_execute_disc_get_log_page(struct nvm=
et_req *req)
=20
 =09up_read(&nvmet_config_sem);
=20
-=09status =3D nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);
+=09/*
+=09 * Validate the host-supplied log page offset before copying out.
+=09 * Without this check, the host controls a 64-bit byte offset into
+=09 * a small kzalloc'd buffer: a value past the log page lets the
+=09 * subsequent memcpy read adjacent kernel heap, and a value aimed
+=09 * at unmapped kernel memory faults the in-kernel copy and crashes
+=09 * the target host. The Discovery controller is unauthenticated,
+=09 * so the bug is reachable from any reachable fabric peer.
+=09 */
+=09if (offset > alloc_len) {
+=09=09req->error_loc =3D
+=09=09=09offsetof(struct nvme_get_log_page_command, lpo);
+=09=09status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+=09=09goto out_free_buffer;
+=09}
+
+=09copy_len =3D min_t(size_t, data_len, alloc_len - offset);
+=09status =3D nvmet_copy_to_sgl(req, 0, buffer + offset, copy_len);
+=09if (!status && copy_len < data_len)
+=09=09status =3D nvmet_zero_sgl(req, copy_len, data_len - copy_len);
+out_free_buffer:
 =09kfree(buffer);
 out:
 =09nvmet_req_complete(req, status);
--=20
2.43.0

