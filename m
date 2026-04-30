Return-Path: <stable+bounces-242094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGcFMkhE82lDzAEAu9opvQ
	(envelope-from <stable+bounces-242094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:00:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED34A27C1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F6A302F240
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBB63DA7EC;
	Thu, 30 Apr 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="slvjTA/R"
X-Original-To: stable@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9483AC0DD;
	Thu, 30 Apr 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550339; cv=none; b=UPoy6uNFE/U+o1o4Lx3hNF53cBaGctIgib4OuYNIfK4X6RiXTDstyXdNuh1rqsKW7cSR/ZVuyG9QI4CqFNPiQpdRxOPDSNJ55erpCTX1telm7DAnVe6DjSl+obEwX/nJrY6sd7tV/aMvDHuBbXRaGm0E2mBXsnVa0QGjEN0ay+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550339; c=relaxed/simple;
	bh=A89M7mwpaBx8Ge51XUwe97mlQREFVHakXGkd9LwoF58=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l23PsXyOuPV1Df6kly9O9QfHsU+jcMyx/mA6SlKN1YhPRQyzSzBb/XscjpZ9REZKmM7vjISJseIr2AEmhWYwl061g356eQt+VU49QUGiylvnBbvuy1Fs0ozasSW3tLLzcHXV76U9gAtooIKg09WnzOBTFAWiTwWGDAeHFFUO2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=slvjTA/R; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AB0A71D27;
	Thu, 30 Apr 2026 11:59:03 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=slvjTA/R;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id DA809212D;
	Thu, 30 Apr 2026 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1777550335;
	bh=a3LLX4iA20FCSoYbBRSrLDcmY694oGqoFfCoL7kf2D0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=slvjTA/RBI0ibzKcGfCYk5KIkPN3HwT8YEcDNfpoZ8ScyE85fshe7P/fc/j3LiXa3
	 KUBPYjwJhRkovm9RV6vEwEk295Iv3wxmTPagmoEo84XyLeH8hHja3mYpTgER4UP6WZ
	 CHyi6E508tnarSD89t3Z/MJiPHwF3Rwg4lGD7hBU=
Received: from [192.168.95.128] (172.30.20.214) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 30 Apr 2026 14:58:54 +0300
Message-ID: <3b76b31d-ebd4-4c83-b100-481b89960a00@paragon-software.com>
Date: Thu, 30 Apr 2026 13:58:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: validate split-point offset in
 indx_insert_into_buffer
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260417225712.1736320-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260417225712.1736320-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Queue-Id: C1ED34A27C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242094-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paragon-software.com:dkim,paragon-software.com:mid,aka.ms:url]

On 4/18/26 00:57, Michael Bommarito wrote:

> [You don't often get email from michael.bommarito@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> indx_insert_into_buffer() computes
>
>      used = used1 - to_copy - sp_size;
>      memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
>
> where sp and sp_size come from hdr_find_split().  hdr_find_split()
> walks entries by le16_to_cpu(e->size) without validating that each
> step stays within hdr->used or that the size field is at least
> sizeof(struct NTFS_DE).  index_hdr_check(), the on-load gatekeeper,
> only validates header-level fields (used, total, de_off) and does
> not walk per-entry sizes.
>
> A crafted NTFS image whose leaf INDEX_HDR reports used == total but
> contains one interior NTFS_DE with size = 0xFFF0 therefore passes
> validation, descends to indx_insert_into_buffer() through the
> ntfs_create() -> indx_insert_entry() path, and makes hdr_find_split()
> return an sp whose sp_size (0xFFF0) greatly exceeds the remaining
> bytes in the buffer.  The u32 subtraction underflows and the memmove
> count becomes a near-4-GiB value, producing an out-of-bounds kernel
> write that corrupts adjacent allocations and panics the kernel.
>
> Reproduced on 7.0.0-rc7 with UML + KASAN via a crafted image and a
> single 'touch' inside the mounted directory; crash site resolves to
> fs/ntfs3/index.c at the memmove.  Trigger requires only local mount
> of an attacker-supplied filesystem image (USB, loopback, or removable
> media auto-mount).
>
> Reject the split whenever the chosen sp plus its declared size
> already extends past hdr1->used.  This is the minimal fix; it
> preserves the existing hdr_find_split() contract and relies on the
> same out: cleanup path as the pre-existing error returns.
>
> A prior OOB read in the very same indx_insert_into_buffer() memmove
> was fixed in commit b8c44949044e ("fs/ntfs3: Fix OOB read in
> indx_insert_into_buffer") by tightening hdr_find_e(), but that fix
> does not cover the split-point size field path addressed here: sp is
> returned by hdr_find_split(), not hdr_find_e(), and the underflow is
> driven by sp->size rather than hdr->used exceeding hdr->total.
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Cc: stable@vger.kernel.org
> Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>
>   - FYI, I have a larger refactor variant that migrates
>     hdr_find_split() to the validated hdr_next_de() helper and closes
>     the whole per-entry size-read class for that walker.  Happy to
>     send it as v2 if you prefer the wider change; otherwise this
>     minimal guard is scoped to the actual memmove underflow site and
>     is easier to backport.
>
>   fs/ntfs3/index.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 2c43e7c27861..24add048b4b5 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1844,6 +1844,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
>          memcpy(up_e, sp, sp_size);
>
>          used1 = le32_to_cpu(hdr1->used);
> +
> +       /*
> +        * hdr_find_split does not validate per-entry sizes, so a crafted
> +        * NTFS_DE whose le16 size field is out of range can place sp such
> +        * that (PtrOffset(hdr1, sp) + sp_size) exceeds used1. Without this
> +        * guard the u32 'used = used1 - to_copy - sp_size' underflows and
> +        * the subsequent memmove count becomes a near-4-GiB value,
> +        * triggering an out-of-bounds kernel write.
> +        */
> +       if (PtrOffset(hdr1, sp) + sp_size > used1) {
> +               err = -EINVAL;
> +               goto out;
> +       }
> +
>          hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
>          if (!hdr1_saved) {
>                  err = -ENOMEM;
> --
> 2.53.0
>
Hello,

Sorry for the delay.
Patch is applied. Thank you.

Regards,
Konstantin


