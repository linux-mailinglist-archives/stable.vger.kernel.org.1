Return-Path: <stable+bounces-249267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIHFJtcEC2rd/QQAu9opvQ
	(envelope-from <stable+bounces-249267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:23:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9C56C906
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74E353054880
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75773FD959;
	Mon, 18 May 2026 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWyIZKeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C03FD947;
	Mon, 18 May 2026 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106274; cv=none; b=GEapcdm/DMhWRsIjKoZCU9gTns8xU+2tOqP3O8mnrdu7lSCsV0UolyJ7ykVVpLrq9CQIeNKafE7VmJS3tBwzxdPj7enQxAwfBiHyzEIKhvpzZ+ZGSk+OvxEn9/wLYKI1MFjZf4O6Tp56vGWAVfdy5AcXWomJAnxA2n0tQR/a468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106274; c=relaxed/simple;
	bh=r5jzII3rEEB7Bvaff0gh9EGxCIHT2y9dgQr23V7KZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRS/DBat1tSJ2YwnSe2IWz5jNzzb3ZPsnqJfNqVZEmg5+HFpKQEbnmXe/KGK2BVhqvkWY/pjjfH78ctrXLpj1HrTEGlRhgIzEDXiUzurwGQp+59G415jwLUanJbSE784DqHmn0ZlJCqY3TSuSi7ea0LbSBFTcPH3P5Kj7NtCTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWyIZKeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B2BC2BCC6;
	Mon, 18 May 2026 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106274;
	bh=r5jzII3rEEB7Bvaff0gh9EGxCIHT2y9dgQr23V7KZQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWyIZKeCvjJz6PaNbN9a3n4OfV2F4vW2SY3AGOi57n5LDy0kcOch5a2IZ1S78O/SV
	 LVbwzT60qUSooP8jNG4KY4Syii8/sT0NaoEqS5z2qZXY2SAzbJc8k2P7/w7xt6oAHC
	 v3OEPSRZ8V+HjiQ3ws+HeNdtRMLA7j3tz1wXYHYkgI9N7GLzz/X2ix7+yWMCiTDpNc
	 feeOyDeL7zvyIrtK2XKNahIlLspne6UDnS1IX5CYGzZFjjfv1SwsrYlZ8oxGvCtnLa
	 mnCoa2aOw50KHDeeGE999qN+yvYFowoy1j79f1JDEaLR1/SPrD1se+UpNoEsioy7qC
	 Dz0hyatE7eqgg==
Date: Mon, 18 May 2026 13:11:09 +0100
From: Will Deacon <will@kernel.org>
To: chichina c <li17324910702@gmail.com>, dovmurik@linux.ibm.com,
	kraxel@redhat.com
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, gshan@redhat.com,
	viro@zeniv.linux.org.uk, suzuki.poulose@arm.com, ardb@kernel.org
Subject: Re: [REPORT] efi_secret: potential use-after-unmap via stale
 seq_file private after device removal
Message-ID: <agsB3ZxcmF-AKPb2@willie-the-truck>
References: <CAOKsz8xqb9MYTbcFnJ-0R=zBRR-oKSNXmMLjFbO5aw1vXo_Ncw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOKsz8xqb9MYTbcFnJ-0R=zBRR-oKSNXmMLjFbO5aw1vXo_Ncw@mail.gmail.com>
X-Rspamd-Queue-Id: D2D9C56C906
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249267-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

[Adding folks who were involved in the efi_secret driver]

I also think this should probably just be discussed on the mailing
list...

Will

(original report below)

On Fri, Apr 03, 2026 at 05:10:17PM +0800, chichina c wrote:
>    Hello Linux kernel security team,
> 
>    I would like to report a potential security issue in
>    drivers/virt/coco/efi_secret/efi_secret.c.
> 
>    The issue appears to be a stale pointer / use-after-unmap in the
>    securityfs read path after device removal.
> 
>    In efi_secret_securityfs_setup(), each securityfs file is created with
>    its private data pointing directly to a struct secret_entry inside the
>    mapped EFI secret area:
> 
>  e = (struct secret_entry *)ptr;
>  securityfs_create_file(guid_str, 0440, dir, (void *)e,
>                         &efi_secret_bin_file_fops);
> 
>    The file uses DEFINE_SHOW_ATTRIBUTE(efi_secret_bin_file), so open()
>    eventually calls:
> 
>  single_open(file, efi_secret_bin_file_show, inode->i_private);
> 
>    This means an already-open file descriptor keeps the secret_entry pointer
>    in seq_file->private.
> 
>    Later, efi_secret_bin_file_show() uses that saved pointer:
> 
>  struct secret_entry *e = file->private;
>  if (e)
>          seq_write(file, e->data, secret_entry_data_len(e));
> 
>    The problem is that the lifetime of this pointer is tied to the EFI
>    secret area mapping. The secret_entry object is not separately allocated;
>    it lives inside s->secret_data.
> 
>    On device removal, the driver does:
> 
>  efi_secret_securityfs_teardown(dev);
>  efi_secret_unmap_area();
> 
>    and efi_secret_unmap_area() calls:
> 
>  iounmap(s->secret_data);
> 
>    At that point, an already-open file descriptor may still hold the old
>    secret_entry pointer in seq_file->private. A later read on that old fd
>    appears able to reach efi_secret_bin_file_show() and dereference
>    e->len / e->data after the backing mapping has been removed.
> 
>    My understanding is that securityfs_remove() tears down the dentry/inode
>    tree, but it does not invalidate seq_file->private for file descriptors
>    that were already opened before removal. Also, the show path uses
>    single_release() only, with no extra pinning or refcounting of the
>    underlying secret_entry object.
> 
>    Expected trigger sequence:
> 
>     1. The platform exposes EFI coco secrets and the driver creates
>        /sys/kernel/security/secrets/coco/.
>     2. A process opens one of the secret files and keeps the fd open.
>     3. The device is removed or unbound, so efi_secret_remove() runs and
>        unmaps s->secret_data.
>     4. The process reads again from the already-open fd.
>    probe
>     └─ efi_secret_map_area
>         └─ s->secret_data = ioremap_encrypted(...)
> 
>    probe
>     └─ efi_secret_securityfs_setup
>         ├─ e = (struct secret_entry *)ptr
>         └─ securityfs_create_file(..., data=e, ...)
> 
>    open(fd)
>     └─ efi_secret_bin_file_open
>         └─ single_open(file, show, inode->i_private)
>             └─ seq_file->private = e
> 
>    read(fd)
>     └─ seq_read
>         └─ efi_secret_bin_file_show
>             └─ e = seq_file->private
>             └─ read e->len / e->data
> 
>    remove
>     └─ efi_secret_remove
>         ├─ securityfs_remove(...)
>         └─ iounmap(s->secret_data)
> 
>    read(old fd again)
>     └─ seq_read
>         └─ efi_secret_bin_file_show
>             └─ use old seq_file->private = stale e
>             └─ access unmapped memory
> 
>    The expected result is a stale dereference of a secret_entry pointer
>    whose backing memory has already been unmapped. At minimum this looks
>    like a local kernel crash / DoS issue.
> 
>    This report is currently based on source analysis.
> 
>    Environment:
>    Kernel: [v7.0-rc6]
> 
>    A possible fix would be one of the following:
> 
>      • avoid storing raw pointers into the mapped secret area in
>        seq_file->private;
>      • use a separately allocated refcounted object whose lifetime is not
>        tied directly to the ioremap mapping;
>      • delay iounmap(s->secret_data) until all open readers are gone;
>      • explicitly invalidate or drain already-open readers before unmapping.
>        |
> 
>    If this is confirmed to be a real issue and fixed, I would appreciate it
>    if my reporter information could be included in the report/changelog.
> 
>    Best regards,
> 
>    chichi
> 
>    [1]Li17324910702@gmail.com
> 
> References
> 
>    Visible links
>    1. mailto:Li17324910702@gmail.com

