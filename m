Return-Path: <stable+bounces-214743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKeCB2iJhmmOOgQAu9opvQ
	(envelope-from <stable+bounces-214743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 01:38:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287C104582
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 01:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B97E303FDC2
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058921CC5B;
	Sat,  7 Feb 2026 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8rol4Np"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE721767D;
	Sat,  7 Feb 2026 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424554; cv=none; b=duMrs17YYh1ysK4dbK5TWCGMCIs2Nnjf+8ZEr/2zZHZN3Tu8SaFaTksIIrG2swRwbPU/+76zXW80go0Otn/lz6sAs/1fKa/TBqf/uPZ/oXVdDjjfpLAPM74Y9gTRLZD/wplrrEU+sZBzP0/SkcMC8XlbGBk1XYYmdaDD1rujtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424554; c=relaxed/simple;
	bh=WSoiTb459q4CuoijHEOgQ2VKDloBFwyEv6asKhqZYPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvJQ2hzITEXDP8vihyotT/jRcrZriveZOyd7HoALQtBhT5qDz4Qm56BFInPBk7FhJDGupG55kZUBVIf22n/L9LZLeo6InEFp9OB/hm2F3b7X2OkjtWJEZcxengG6bPm7iRE+hQMZRdIlHqWruEwLvL329zPkihIu82efuMZOATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8rol4Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26083C116C6;
	Sat,  7 Feb 2026 00:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424554;
	bh=WSoiTb459q4CuoijHEOgQ2VKDloBFwyEv6asKhqZYPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8rol4NpLDK5zjmr1rBQaT4Yz2UTR0MHEPg6U9gE7bwWdRx5ZyW5c1351b9FlxSNG
	 Jc+5xLOzpor+oTv1l7Z9/XANoPWDIhPE6VQVQQnzurQEmtXFXXU2chf+EPT2DtbHFC
	 rruxA4NmuBggPdRBUP7IVYIXwWTMCAfN51fXgzvybsX19KmI+6LDWRlpi9L8IZ9OtE
	 E1RlRlrvdHX2vg3jqQUTnNKlIlxY8Us5tHX/AS9pXz5nyZAOW1G4+91HtK619Y+OGR
	 ++ihZnX6eygaG0SgKQLIE2caRXgbNabSGpNTq/Di0TBleBujtX/5MMf8mEPtWBpXi9
	 8yN5FIC7aix4w==
Date: Fri, 6 Feb 2026 16:35:53 -0800
From: Kees Cook <kees@kernel.org>
To: Sai Ritvik Tanksalkar <stanksal@purdue.edu>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
	"gpiccoli@igalia.com" <gpiccoli@igalia.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"anton.vorontsov@linaro.org" <anton.vorontsov@linaro.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] pstore/ram: fix buffer overflow in
 persistent_ram_save_old()
Message-ID: <202602061626.1C0B1DE0C@keescook>
References: <SJ2PR22MB4268B38E0E4FF3EEB9979E04BE9CA@SJ2PR22MB4268.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR22MB4268B38E0E4FF3EEB9979E04BE9CA@SJ2PR22MB4268.namprd22.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214743-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purdue.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7287C104582
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 02:49:20PM +0000, Sai Ritvik Tanksalkar wrote:
> persistent_ram_save_old() can be called multiple times for the same
> persistent_ram_zone (e.g., via ramoops_pstore_read -> ramoops_get_next_prz
> for PSTORE_TYPE_DMESG records).

Thanks for the report!

> Currently, the function only allocates prz->old_log when it is NULL,
> but it unconditionally updates prz->old_log_size to the current buffer
> size and then performs memcpy_fromio() using this new size. If the
> buffer size has grown since the first allocation (which can happen
> across different kernel boot cycles), this leads to:
> 
> 1. A heap buffer overflow (OOB write) in the memcpy_fromio() calls.
> 2. A subsequent OOB read when ramoops_pstore_read() accesses the buffer
>    using the incorrect (larger) old_log_size.
> 
> The KASAN splat would look similar to:
>   BUG: KASAN: slab-out-of-bounds in ramoops_pstore_read+0x...
>   Read of size N at addr ... by task ...

"would look"? Have you confirmed this for a real scenario? It seems like
an extreme corner case that should be almost impossible to hit in
practice:

  0. Crash with a ramoops write of less-than-record-max-size bytes.
  1. Reboot: ramoops registers, pstore_get_records(0) reads old crash,
     allocates old_log with size X
  2. Crash handler registered, timer started (if pstore_update_ms >= 0)
  3. Oops happens (non-fatal, system continues)
  4. pstore_dump() writes oops via ramoops_pstore_write() size Y (>X)
  5. pstore_new_entry = 1, pstore_timer_kick() called
  6. System continues running (not a panic oops)
  7. Timer fires after pstore_update_ms milliseconds
  8. pstore_timefunc() → schedule_work() → pstore_dowork() → pstore_get_records(1)
  9. ramoops_get_next_prz() → persistent_ram_save_old()
 10. buffer_size() returns Y, but old_log is X bytes
 11. Y > X: memcpy_fromio() overflows heap

  Requirements:
  - a prior crash record exists that did not fill the record size
    (almost impossible since the crash handler writes as much as it
    can possibly fit into the record, capped by max record size and
    the kmsg buffer almost always exceeds the max record size)
  - pstore_update_ms >= 0 (disabled by default)
  - Non-fatal oops (system survives)

So, yes, this is technically possible, but very very hard to do. :)
Unless you see another way?

> Fix this by freeing and reallocating the buffer when the new size
> exceeds the previously allocated size. This ensures old_log always has
> sufficient space for the data being copied.
> 
> Fixes: 201e4aca5aa1 ("pstore/ram: Should update old dmesg buffer before reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pwnverse <stanksal@purdue.edu>
> ---
>  fs/pstore/ram_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index f1848cdd6d34..8df813a42a41 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -298,6 +298,14 @@ void persistent_ram_save_old(struct persistent_ram_zone *prz)
>      if (!size)
>          return;
> 
> +     /*
> +      * If the existing buffer is too small, free it so a new one is
> +      * allocated. This can happen when persistent_ram_save_old() is
> +      * called multiple times with different buffer sizes.
> +      */
> +     if (prz->old_log && prz->old_log_size < size)

This should be "!=", I think? Just to deal with leaving old data in if
the size _shrinks_ too?

> +           persistent_ram_free_old(prz);
> +
>      if (!prz->old_log) {
>          persistent_ram_ecc_old(prz);
>          prz->old_log = kvzalloc(size, GFP_KERNEL);
> --
> 2.43.0

-- 
Kees Cook

